Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB48C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD53222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390780AbfBMIqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:46:23 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbfBMIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:46:22 -0500
Received: from [192.168.178.52] ([109.104.49.86]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUGNZ-1gSaGW1fRz-00REPa; Wed, 13 Feb 2019 09:46:11 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of initialization.
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20190213003324.15224-1-eric@anholt.net>
 <20190213003324.15224-2-eric@anholt.net>
Message-ID: <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com>
Date:   Wed, 13 Feb 2019 09:46:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213003324.15224-2-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:sEMhSnRh5hyFnZBc9bt4wMupYNRokD4gOd4f09aNZ+HBKnI9lQr
 sOSekht1DM4xsdyxAAN6jQW1BfPPaxFs8nGlT/fVqbQxkqIkGlSjO0XmaVlHTGiQ+DhbPc+
 XF4w4pOkS8LqynK9AKHO8vu9HLvtRWLmHaZ3aKddu0jr7VIJ7tAvqhZGW8m4i810YIz1B18
 FdH0V5ZozjdGQDgfbpk/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:skIvdwNlXJg=:v4/TVx3FrzN2DUUp7iDpii
 PgTZuA2vlVQ7cS8PX/qZucxTCT4UtqLdqXw2sWpDvLy53WHN++qsuAHpU3PgKRRowR4hpfVDz
 WynOBiHQueOGhjn9+exRFeKMGMbjDb8C5pdodrbTHl2vufSfeo5HAkqjrgRUnjpVlq9WWIgmA
 mp0Jyzjjy5EV9GlyvGcEU/V/NWkcGFVdC3SZHWLu8ktMWwQKQaEEVs1a0x+XlXr/gSqsgUXaz
 uG8kKRxetQ2A/EoIMpJCSH2etluF2kOsnot6vEXXuN48V0OpNZWSvgjkktPPDxXFu2YxEenyg
 shnbX8Vidg4ZetTQ1fs71ouTFw4SyKWRNz39elANKwTuo2mEb05Hqb0FBOQlBlTgndAqzuICW
 e5zOATHMUH220GLp6woReclDswoTVwGici4aGKUVRwkBRcGX3M9PkjseVu8g+MPvNF66eOn+M
 E3J5xo7LeUK5t2CyVKDYn4UFASaQkpf0lDPE+8HzkYUY6lwdeYDN3U74RpY3xDjp+kZy89DR+
 TiJc98EX1yXvVdtWLklUV7R+7m/xH4hHqognU5yiRj7S7zp0/JVQr7dfjZ9M9b4Fm5FSSRQve
 sEwQp7DowUFFEoHWv8o0F8aST4JzRV4RUHNKwB0qFw8xjDGUa64BGK0ZsGt5b4H+FmmOgPUGy
 Vzoek82TJT3C99qcHM6/SyiZgxJDU2gzd7SymI5JIQTzfqDxPjn1xX0jOXaLudeRGtTq55Qrw
 s4ayiGNnpSazQXtIa6XRVJsHegQpKIEV5qzeTSfxA89/Lmbm+f7tJzJ6zyQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Am 13.02.19 um 01:33 schrieb Eric Anholt:
> The clock driver may probe after ours and so we need to pass the
> -EPROBE_DEFER out.  Fix the other error path while we're here.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> ---
>  drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
> index 4a1b99b773c0..11f9469423f7 100644
> --- a/drivers/soc/bcm/bcm2835-power.c
> +++ b/drivers/soc/bcm/bcm2835-power.c
> @@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
>  	}
>  }
>  
> -static void
> +static int
>  bcm2835_init_power_domain(struct bcm2835_power *power,
>  			  int pd_xlate_index, const char *name)
>  {
> @@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
>  	struct bcm2835_power_domain *dom = &power->domains[pd_xlate_index];
>  
>  	dom->clk = devm_clk_get(dev->parent, name);
> +	if (IS_ERR(dom->clk)) {
> +		int ret = PTR_ERR(dom->clk);
> +
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
is it safe to proceed in the other error cases?
Even it would be more consistent with clk_prepare_enable() to print an
error here.
> +	}
>  
>  	

Thanks
Stefan

