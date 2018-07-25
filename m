Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C97C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8876220671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sopwaHrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8876220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbeGYVqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731270AbeGYVqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:46:43 -0400
Received: from [10.82.11.241] (unknown [131.107.174.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF0F20882;
        Wed, 25 Jul 2018 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532550804;
        bh=Bwypo21a6fUJsRcl7nYlbn28qSONz3wP0EIngUGuP+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sopwaHrGn9+XpeBYFWtG/ZfCOLqLlnwpYir6DhIu343CJekwONGbYfNcw72UZQCT0
         Ch5amELl4AsRWfkY91wO91cwheFkiz5WckucMUOUJucQJStHtEfJ9PIE+aWfYj7UpT
         oGub0H7cfd6k4tnllfInzdUv/32LPOGxCwH/r5jY=
Subject: Re: [PATCH v1 0/4] PCI: Remove unnecessary includes of
 <linux/pci-aspm.h>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        ath9k-devel@qca.qualcomm.com, linuxwifi@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <43748afd-712a-48e5-97a9-0b6046f575b3@kernel.org>
Date:   Wed, 25 Jul 2018 13:33:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2018 12:52 PM, Bjorn Helgaas wrote:
> emove includes of <linux/pci-aspm.h> from files that don't need
> it.  I'll apply all these via the PCI tree unless there's objection.
> 
> ---
> 
> Bjorn Helgaas (4):
>        igb: Remove unnecessary include of <linux/pci-aspm.h>
>        ath9k: Remove unnecessary include of <linux/pci-aspm.h>
>        iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
>        PCI: Remove unnecessary include of <linux/pci-aspm.h>

Thanks.

Reviewed-by: Sinan Kaya <okaya@kernel.org>

Is it possible to kill that file altogether? I haven't looked who is
using outside of pci directory.
