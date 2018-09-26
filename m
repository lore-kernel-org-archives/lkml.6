Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF479C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7BC20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7BC20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIZT5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:57:17 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:50238 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:57:17 -0400
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="17808107"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 06:44:14 -0700
Received: from [10.145.4.100] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Wed, 26 Sep 2018
 06:44:13 -0700
Subject: Re: [PATCH] ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Florian Meier <florian.meier@koalo.de>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180926125957.2256982-1-arnd@arndb.de>
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Message-ID: <f0410312-de2b-d0a8-4236-d7a751712767@microchip.com>
Date:   Wed, 26 Sep 2018 16:44:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926125957.2256982-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2018 15:59, Arnd Bergmann wrote:
> Selecting SND_SOC_WM8731 is only allowed when all its dependencies
> are already there:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_WM8731
>    Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=m]
>    Selected by [y]:
>    - SND_SOC_MIKROE_PROTO [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && OF [=y]
>    Selected by [m]:
>    - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && (ARCH_AT91 [=y] || COMPILE_TEST [=y]) && ATMEL_SSC [=y] && SND_SOC_I2C_AND_SPI [=m]
>    - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMPILE_TEST [=y] && SND_SOC_I2C_AND_SPI [=m]
> 
> Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Thank you!

Best regards,
Codrin

> ---
>   sound/soc/atmel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 81a0712d4f14..64f86f0b87e5 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -101,6 +101,7 @@ config SND_ATMEL_SOC_I2S
>   config SND_SOC_MIKROE_PROTO
>   	tristate "Support for Mikroe-PROTO board"
>   	depends on OF
> +	depends on SND_SOC_I2C_AND_SPI
>   	select SND_SOC_WM8731
>   	help
>   	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
> 

