Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112EE2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="AogdW2RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112EE2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeK0INh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:13:37 -0500
Received: from vern.gendns.com ([98.142.107.122]:44174 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeK0INg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oUeeBCZvv45J1G1xV+GwW+iYmNqVxnG9HQATayAZJK8=; b=AogdW2RKuwuwlVZSUTluyBx2ay
        1Vgc6w+WwZPbQkVkjLzIVIIcHiLrRCgrVV7t5ISRHLKxT5QcxM1QKSdFDgfadl5YymB5yrzEL4sc6
        5HphPFtPSlpBu+glGvCMFNzyl67me2LWD2RuvdwrExUtQL/4o9qXCz9wDawYSlCgjgfru2gKtpl6s
        QF78CZATlXXyQ6KnCame/WwzWw9l0++CtcbftRhGyW+YkffhV3xbxBsszHP7GXm7iY/VBmwTW6he3
        TuEW1aJJdeYomxBtmz9LJhIirDwUe17Fe3w1xDzBzozpj1x/IynI7iLQ2vjOexdGyaTweGI6+DUHS
        u2BH4yvA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44836 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROFp-0002SP-MT; Mon, 26 Nov 2018 16:17:17 -0500
Subject: Re: [PATCH 09/17] soc: ti: pruss: add
 pruss_{request,release}_mem_region() API
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-10-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <bbbc5274-0ce2-3806-0a6a-c71785e7aebd@lechnology.com>
Date:   Mon, 26 Nov 2018 15:18:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-10-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> Add two new API - pruss_request_mem_region() & pruss_release_mem_region(),
> to the PRUSS platform driver to allow client drivers to acquire and release
> the common memory resources present within a PRU-ICSS subsystem. This
> allows the client drivers to directly manipulate the respective memories,
> as per their design contract with the associated firmware.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> [s-anna@ti.com: rename functions, add error checking, comments]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---


> diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
> index a5a0667..f8878c2 100644
> --- a/drivers/soc/ti/pruss.h
> +++ b/drivers/soc/ti/pruss.h
> @@ -22,28 +22,6 @@
>   #define MAX_PRU_HOST_INT	10
>   
>   /**
> - * enum pruss_mem - PRUSS memory range identifiers
> - */
> -enum pruss_mem {
> -	PRUSS_MEM_DRAM0 = 0,
> -	PRUSS_MEM_DRAM1,
> -	PRUSS_MEM_SHRD_RAM2,
> -	PRUSS_MEM_MAX,
> -};
> -
> -/**
> - * struct pruss_mem_region - PRUSS memory region structure
> - * @va: kernel virtual address of the PRUSS memory region
> - * @pa: physical (bus) address of the PRUSS memory region
> - * @size: size of the PRUSS memory region
> - */
> -struct pruss_mem_region {
> -	void __iomem *va;
> -	phys_addr_t pa;
> -	size_t size;
> -};

Why don't we just put these definitions in the correct header file
to start with when they are introduced earlier in this series?


> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> new file mode 100644
> index 0000000..198ae25
> --- /dev/null
> +++ b/include/linux/pruss.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * PRU-ICSS Subsystem user interfaces
> + *
> + * Copyright (C) 2015-2018 Texas Instruments Incorporated - http://www.ti.com
> + *	Suman Anna <s-anna@ti.com>
> + *	Tero Kristo <t-kristo@ti.com>
> + */
> +
> +#ifndef __LINUX_PRUSS_H
> +#define __LINUX_PRUSS_H
> +
> +/**
> + * enum pruss_mem - PRUSS memory range identifiers
> + */
> +enum pruss_mem {
> +	PRUSS_MEM_DRAM0 = 0,
> +	PRUSS_MEM_DRAM1,
> +	PRUSS_MEM_SHRD_RAM2,
> +	PRUSS_MEM_MAX,
> +};
> +
> +/**
> + * struct pruss_mem_region - PRUSS memory region structure
> + * @va: kernel virtual address of the PRUSS memory region
> + * @pa: physical (bus) address of the PRUSS memory region
> + * @size: size of the PRUSS memory region
> + */
> +struct pruss_mem_region {
> +	void __iomem *va;
> +	phys_addr_t pa;
> +	size_t size;
> +};
> +

