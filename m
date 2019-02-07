Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A79C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867942175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jwzrbNkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGOIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:08:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48868 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfBGOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:08:02 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17E7igA126386;
        Thu, 7 Feb 2019 08:07:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549548464;
        bh=iKQqQ4B2hwiH2hM0XcpljoPwFxXZdlbKWIjZ+SkptXU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jwzrbNkvPmlcAeXVHuhWz91QxubKLeCkiXs6II7PCwiYqnerWIjsQAFlwOsFOTKfs
         amdHhYeluNclrwKIi70e3cR+8qF/5hW/iWhPbSq0Q1jkofIyZCLlkUQuc5h5iR3YYb
         Ak/PL4CvfEg47be18Jcm0JI7vPwMVihyAGK9kXBo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17E7iwG105574
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 08:07:44 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 08:07:43 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 08:07:44 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17E7e8N000513;
        Thu, 7 Feb 2019 08:07:41 -0600
Subject: Re: [PATCH 33/35] ARM: davinci: prepare to remove mach/irqs.h
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-34-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <73e93586-5681-4a37-04f4-da8d666adc59@ti.com>
Date:   Thu, 7 Feb 2019 19:37:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-34-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/19 7:09 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since we now select SPARSE_IRQ in davinci, the mach/irqs.h header is
> no longer included from asm/irq.h. All interrupt numbers for devices
> should be defined as platform device resources. Let's prepare for the
> removal of mach/irqs.h by moving all defines that we want to keep to
> relevant headers (davinci.h, common.h) and replacing others with
> simple literals.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
>  arch/arm/mach-davinci/board-da850-evm.c     |  4 ++--
>  arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c    |  2 +-
>  arch/arm/mach-davinci/da830.c               |  2 +-
>  arch/arm/mach-davinci/da850.c               |  2 +-
>  arch/arm/mach-davinci/davinci.h             |  2 ++
>  arch/arm/mach-davinci/include/mach/common.h |  5 +++++
>  arch/arm/mach-davinci/include/mach/irqs.h   | 18 ------------------
>  9 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index b3a0148f7f1a..950e98e4eda5 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -488,7 +488,7 @@ static int da830_evm_ui_expander_teardown(struct i2c_client *client, int gpio,
>  }
>  
>  static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
> -	.gpio_base	= DAVINCI_N_GPIO,
> +	.gpio_base	= 144,

Why drop DAVINCI_N_GPIO instead of just moving it to a local header file?

Thanks,
Sekhar
