Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0220C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A3820C10
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbTgW3dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A3820C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeHTCgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 22:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHTCgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 22:36:51 -0400
Received: from [192.168.0.122] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B750120C0B;
        Sun, 19 Aug 2018 23:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534721018;
        bh=adhesXCFIY1lqw6BP7i+uQGmPXFx/uS2DEMSJAeKLmQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MbTgW3dmBt/rb2g1DEGT0KrZH9dlp67XSPvfwEjJj4lr1tNVcWwYG+VmOy2smioBF
         T7HK5imaZBjn8tPf+/unBMVEM77yhoIUZyePQgIVEeaRhzrDFRIrXDkukh9kbtZZK2
         otbgfevQ9oHCvMk8TcSf/uDg4e8KD/QL6DAWtzZA=
Subject: Re: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if
 hotplug is enabled
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180818065126.77912-2-okaya@kernel.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <75a82f6d-10dc-d980-8abf-8e1410f866cb@kernel.org>
Date:   Sun, 19 Aug 2018 19:23:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180818065126.77912-2-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2018 2:51 AM, Sinan Kaya wrote:
>   	cleanup_slot(ctrl);
> +	pciehp_control_surprise_error(ctrl, true);

I think I need to move this one line up but I'd like to see some input
here and also ask for some testing.

I don't have any hardware to test.
