Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDAAC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F3A218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="kbzM1SZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBIVNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:13:40 -0500
Received: from vern.gendns.com ([98.142.107.122]:32930 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfBIVNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 16:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tI6HtZ+cou49J3I+feGLu6QXsuZ0+P4Rp4ag5PuTizc=; b=kbzM1SZB6JTJ4SIrpchZkS0mAR
        onR1a3xSr3vbcAf5fswa0PNBk4Q9jE2iUwGPgR3/ZRZrJTB2Ih470w4PPsSkMCvBI/nB7fMkBrX8G
        M8fvDXYkTiBk2vAA9UIzAxyseg/NzfVCru8hMYPO6gwqeiasNUmDHjsQMTUQgm7sdBHWav0wG1+n7
        ARTNay87RiqeMzRvUF2rVi8CTQuHSdZ8EPHXGbnVA1QD37riSurxus3loXiiDVFZMZ7rzp4u8+orW
        n/rEuq9zvKfsEgnPEr9OCXiCjLO4IZSIz7d/E5QKll+z/Jh/Hb2NdwnT2KAdbAB7tm97cB9ZPamcu
        c0BGTu0w==;
Received: from [38.123.241.2] (port=60095 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gsZsd-0000CR-DF; Sat, 09 Feb 2019 16:09:43 -0500
Subject: Re: [PATCH v2 03/33] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190208173458.4801-1-brgl@bgdev.pl>
 <20190208173458.4801-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <c9dbec4e-8738-e2bf-9011-1cc1ac5f44dd@lechnology.com>
Date:   Sat, 9 Feb 2019 15:13:04 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208173458.4801-4-brgl@bgdev.pl>
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



On 2/8/19 11:34 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to support SPARSE_IRQ we first need to make davinci use the
> generic irq handler for ARM. Translate the legacy assembly to C and
> put the irq handlers into their respective drivers (aintc and cp-intc).
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 07d8ef8037e4..3ce821a06e52 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -29,11 +29,13 @@
>   #include <mach/cputype.h>
>   #include <mach/common.h>
>   #include <asm/mach/irq.h>
> +#include <asm/exception.h>

Alphabetical order?
