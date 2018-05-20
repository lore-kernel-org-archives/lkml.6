Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeETK1G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeETK1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:27:04 -0400
Date: Sun, 20 May 2018 11:26:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: include stm32-dfsdm-adc.h
Message-ID: <20180520112658.1c84968b@archlinux>
In-Reply-To: <1526397557-31389-1-git-send-email-fabrice.gasnier@st.com>
References: <1526397557-31389-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 17:19:17 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix the following sparse warnings:
>   CHECK   drivers/iio/adc/stm32-dfsdm-adc.c
> symbol 'stm32_dfsdm_get_buff_cb' was not declared. Should it be static?
> symbol 'stm32_dfsdm_release_buff_cb' was not declared. Should it be static?
> 
> BTW, move interrupt.h to sort headers alphabetically.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c       | 4 ++--
>  include/linux/iio/adc/stm32-dfsdm-adc.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 1b78bec..31462ae 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -8,11 +8,11 @@
>  
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/interrupt.h>
> +#include <linux/iio/adc/stm32-dfsdm-adc.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/hw-consumer.h>
> -#include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> diff --git a/include/linux/iio/adc/stm32-dfsdm-adc.h b/include/linux/iio/adc/stm32-dfsdm-adc.h
> index e7dc7a5..0da298b 100644
> --- a/include/linux/iio/adc/stm32-dfsdm-adc.h
> +++ b/include/linux/iio/adc/stm32-dfsdm-adc.h
> @@ -9,6 +9,8 @@
>  #ifndef STM32_DFSDM_ADC_H
>  #define STM32_DFSDM_ADC_H
>  
> +#include <linux/iio/iio.h>
> +
>  int stm32_dfsdm_get_buff_cb(struct iio_dev *iio_dev,
>  			    int (*cb)(const void *data, size_t size,
>  				      void *private),
