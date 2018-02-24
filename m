Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeBXM4l (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 07:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeBXM4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 07:56:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F32F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 12:56:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 1/7] iio: adc: stm32-dfsdm: fix compatible data use
Message-ID: <20180224125634.0035d81f@archlinux>
In-Reply-To: <1519390261-25453-2-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
        <1519390261-25453-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 13:50:55 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix use of compatible data: stm32h7 regmap configuration is statically
> used. Rather use regmap_cfg from compatible data.
> 
> Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 6290332..0635f93 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -274,7 +274,7 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
>  
>  	dfsdm->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "dfsdm",
>  						  dfsdm->base,
> -						  &stm32h7_dfsdm_regmap_cfg);
> +						  dev_data->regmap_cfg);
>  	if (IS_ERR(dfsdm->regmap)) {
>  		ret = PTR_ERR(dfsdm->regmap);
>  		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
