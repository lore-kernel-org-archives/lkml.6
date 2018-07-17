Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBADECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F320779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPV7rvYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7F320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeGQQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbeGQQOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:14:34 -0400
Received: from [10.82.11.232] (unknown [131.107.174.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4FE20779;
        Tue, 17 Jul 2018 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531842080;
        bh=KHbbwVhMUX8DNv4TJezF3HTEMpMA04oIf5EKuQIAE/Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NPV7rvYsXYf3fH32ByUTTZwMupl6zXiuyrRcXaUfNJbBzgw27By8LRvhrVgQeWqM5
         VTCO2k8rPH62b3Z6YZww0ze9T/h1Q/Ff61RaEuLVxoETGMbNFlIgzcNE3DnZOD4+Dr
         Ftdo4saibAXmB6NMLz2TGCbBP8kPbS3vXgz5n068=
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
Date:   Tue, 17 Jul 2018 08:41:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717153135.25925-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/2018 8:31 AM, Alexandru Gagniuc wrote:
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;

Can you move this to closer to the caller pci_aer_init()?
