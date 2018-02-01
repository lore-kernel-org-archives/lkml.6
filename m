Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBAJKQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:10:16 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:58452 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBAJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:10:15 -0500
Date: Thu, 1 Feb 2018 10:10:12 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Olivier Moysan <olivier.moysan@st.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: stm32: add of dependency for
 stm32 drivers
Message-ID: <20180201091012.GA10746@lenoch>
References: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 09:54:41AM +0100, Olivier Moysan wrote:
> Add of dependency for STM32 ASoC drivers.
> DFSDM of dependency is already inherited
> from STM32_DFSDM_ADC dependency.
> 
> Signed-off-by: olivier moysan <olivier.moysan@st.com>
> ---
>  sound/soc/stm/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
> index 3ad881f..b5375f9 100644
> --- a/sound/soc/stm/Kconfig
> +++ b/sound/soc/stm/Kconfig
> @@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
>  config SND_SOC_STM32_SAI
>  	tristate "STM32 SAI interface (Serial Audio Interface) support"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on OF

depends on (ARCH_STM32 && OF) || COMPILE_TEST ?

>  	depends on SND_SOC
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	select REGMAP_MMIO
> @@ -12,6 +13,7 @@ config SND_SOC_STM32_SAI
>  config SND_SOC_STM32_I2S
>  	tristate "STM32 I2S interface (SPI/I2S block) support"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on OF
>  	depends on SND_SOC
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	select REGMAP_MMIO
> @@ -21,6 +23,7 @@ config SND_SOC_STM32_I2S
>  config SND_SOC_STM32_SPDIFRX
>  	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on OF
>  	depends on SND_SOC
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	select REGMAP_MMIO
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
