Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeDRGEo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 02:04:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:51538 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeDRGEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 02:04:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="32807767"
Subject: Re: [RFC PATCH spi] spi: pxa2xx: pxa2xx_spi_transfer_one() can be
 static
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
 <20180417195323.GA69680@ivb43>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <22cf611b-6a88-ec72-bb3c-51f8b62a8019@linux.intel.com>
Date: Wed, 18 Apr 2018 09:04:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417195323.GA69680@ivb43>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/18 22:53, kbuild test robot wrote:
> 
> Fixes: d5898e19c0d7 ("spi: pxa2xx: Use core message processing loop")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>   spi-pxa2xx.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index c852ea5..40f1346 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -911,9 +911,9 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *master,
>   	       xfer->len >= chip->dma_burst_size;
>   }
>   
> -int pxa2xx_spi_transfer_one(struct spi_controller *master,
> -			    struct spi_device *spi,
> -			    struct spi_transfer *transfer)
> +static int pxa2xx_spi_transfer_one(struct spi_controller *master,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *transfer)

Thanks Fengguang. I don't understand how I managed to drop "static" 
while doing manual s/pump_transfers/pxa2xx_spi_transfer_one/ :-)

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
