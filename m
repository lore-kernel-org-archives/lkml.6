Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeCWM5w convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:57:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41283 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752865AbeCWM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:57:45 -0400
Date: Fri, 23 Mar 2018 12:57:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] staging: iio: ad7746: Rename sysfs attrs to
 comply with the ABI
Message-ID: <20180323135729.00003e93@huawei.com>
In-Reply-To: <1521642539-4845-11-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-11-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:58 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Please look at what these do.  It is not what those abi elements are
documented as doing.

Also if it were you would need to support them via read_raw and write_raw
and put them in the relevant info mask elements.

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index b6b99e2..c1f76fc 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -336,16 +336,16 @@ static ssize_t ad7746_start_gain_calib(struct device *dev,
>  				  AD7746_CONF_MODE_GAIN_CAL);
>  }
>  
> -static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
> -		       0200, NULL, ad7746_start_offset_calib, CIN1);
> -static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
> -		       0200, NULL, ad7746_start_offset_calib, CIN2);
> -static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
> -		       0200, NULL, ad7746_start_gain_calib, CIN1);
> -static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
> -		       0200, NULL, ad7746_start_gain_calib, CIN2);
> -static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
> -		       0200, NULL, ad7746_start_gain_calib, VIN);
> +static IIO_DEVICE_ATTR(in_capacitance0_calibbias, 0200, NULL,
> +		       ad7746_start_offset_calib, CIN1);
> +static IIO_DEVICE_ATTR(in_capacitance1_calibbias, 0200, NULL,
> +		       ad7746_start_offset_calib, CIN2);
> +static IIO_DEVICE_ATTR(in_capacitance0_calibscale, 0200, NULL,
> +		       ad7746_start_gain_calib, CIN1);
> +static IIO_DEVICE_ATTR(in_capacitance1_calibscale, 0200, NULL,
> +		       ad7746_start_gain_calib, CIN2);
> +static IIO_DEVICE_ATTR(in_voltage0_calibscale, 0200, NULL,
> +		       ad7746_start_gain_calib, VIN);
>  
>  static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
>  					      int val)
> @@ -388,11 +388,11 @@ static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
>  		       "91 84 50 26 16 13 11 9");
>  
>  static struct attribute *ad7746_attributes[] = {
> -	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance0_calibbias.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance0_calibscale.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance1_calibscale.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance1_calibbias.dev_attr.attr,
> +	&iio_dev_attr_in_voltage0_calibscale.dev_attr.attr,
>  	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
>  	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.attr,
>  	NULL,
