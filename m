Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeCWMkl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:40:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752559AbeCWMkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:40:40 -0400
Date: Fri, 23 Mar 2018 12:40:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/11] staging: iio: ad7746: Reorder variable
 declarations
Message-ID: <20180323134016.00007753@huawei.com>
In-Reply-To: <1521642539-4845-5-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-5-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:52 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Reorder some variable declarations in an inverse-pyramid scheme.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
I'm not sure the first few cases here actually add much in
the way of readablity.

This 'rule' is very 'vague' deliberately as sometimes it makes sense
and sometimes it really doesn't.

One nice convention is to have ret on it's own line when it is the
value returned by the function (it doesn't logically group with anything
else).  Having that one last is also nice to see (so I like your final
change more than the others!)

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 86919e8..57623db 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -220,8 +220,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  				 struct iio_chan_spec const *chan)
>  {
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> -	int ret, delay, idx;
>  	u8 vt_setup, cap_setup;
> +	int ret, delay, idx;
>  
>  	switch (chan->type) {
>  	case IIO_CAPACITANCE:
> @@ -289,8 +289,8 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> -	bool doit;
>  	int ret, timeout = 10;
> +	bool doit;
>  
>  	ret = strtobool(buf, &doit);
>  	if (ret < 0)
> @@ -681,8 +681,8 @@ static int ad7746_probe(struct i2c_client *client,
>  	struct ad7746_platform_data *pdata = client->dev.platform_data;
>  	struct ad7746_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	int ret = 0;
>  	unsigned char regval = 0;
> +	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
