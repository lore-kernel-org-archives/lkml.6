Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBXM6G (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 07:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeBXM6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 07:58:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFA521741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 12:57:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/7] iio: adc: stm32-dfsdm: fix call to stop channel
Message-ID: <20180224125759.18678f8b@archlinux>
In-Reply-To: <1519390261-25453-3-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
        <1519390261-25453-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 13:50:56 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> stm32_dfsdm_stop_channel must be called with channel id, not filter id.
> 
> Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index daa026d..0eff811 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -464,7 +464,7 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc, bool dma)
>  
>  	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
>  			   DFSDM_CR1_RCONT_MASK, 0);
> -	stm32_dfsdm_stop_channel(adc->dfsdm, adc->fl_id);
> +	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
>  
>  	return ret;
>  }
