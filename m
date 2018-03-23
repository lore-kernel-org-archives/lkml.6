Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeCWMhN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:37:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34206 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752003AbeCWMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:37:12 -0400
Date: Fri, 23 Mar 2018 12:36:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] staging: iio: ad7746: Adjust arguments to match
 open parenthesis
Message-ID: <20180323133658.00004d4d@huawei.com>
In-Reply-To: <1521642539-4845-2-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-2-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:49 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Clear two more checkpatch.pl CHECKS.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Hi Hernán,

Technically the comment below isn't about this patch, but there
seems little point in fixing alignment when the function
called should be changed anyway (requiring the alignment to change
again!)

Otherwise patch looks good.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 4882dbc..02e3164 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -463,7 +463,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  		ret = i2c_smbus_write_word_data(chip->client,
> -				AD7746_REG_CAP_OFFH, swab16(val));
> +						AD7746_REG_CAP_OFFH,
> +						swab16(val));
Take a look at i2c_smbus_write_word_swapped.

I thought we had long ago gotten rid of all the places this was
being done by hand, but apparently not!

>  		if (ret < 0)
>  			goto out;
>  
> @@ -556,7 +557,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		/* Now read the actual register */
>  
>  		ret = i2c_smbus_read_i2c_block_data(chip->client,
> -			chan->address >> 8, 3, &chip->data.d8[1]);
> +						    chan->address >> 8, 3,
> +						    &chip->data.d8[1]);
>  
>  		if (ret < 0)
>  			goto out;
