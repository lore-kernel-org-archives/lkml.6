Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBQMB1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 07:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbeBQMB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 07:01:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A733217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:01:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ade7759: Fix open parenthesis alignment
Message-ID: <20180217120121.0a5b3be0@archlinux>
In-Reply-To: <20180210202315.l2jecbrips2g3vuq@smtp.gmail.com>
References: <20180210202315.l2jecbrips2g3vuq@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 18:23:15 -0200
rodrigosiqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch fixes the CHECKs reported by checkpatch.pl for "alignment
> should match open parenthesis"
> 
> Signed-off-by: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/ade7759.c | 80 ++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index d99cf508d8d0..1decb2b8afab 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -72,8 +72,8 @@ struct ade7759_state {
>  };
>  
>  static int ade7759_spi_write_reg_8(struct device *dev,
> -		u8 reg_address,
> -		u8 val)
> +				   u8 reg_address,
> +				   u8 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -91,8 +91,8 @@ static int ade7759_spi_write_reg_8(struct device *dev,
>  
>  /*Unlocked version of ade7759_spi_write_reg_16 function */
>  static int __ade7759_spi_write_reg_16(struct device *dev,
> -		u8 reg_address,
> -		u16 value)
> +				      u8 reg_address,
> +				      u16 value)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7759_state *st = iio_priv(indio_dev);
> @@ -104,8 +104,8 @@ static int __ade7759_spi_write_reg_16(struct device *dev,
>  }
>  
>  static int ade7759_spi_write_reg_16(struct device *dev,
> -		u8 reg_address,
> -		u16 value)
> +				    u8 reg_address,
> +				    u16 value)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -119,8 +119,8 @@ static int ade7759_spi_write_reg_16(struct device *dev,
>  }
>  
>  static int ade7759_spi_read_reg_8(struct device *dev,
> -		u8 reg_address,
> -		u8 *val)
> +				  u8 reg_address,
> +				  u8 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7759_state *st = iio_priv(indio_dev);
> @@ -128,8 +128,9 @@ static int ade7759_spi_read_reg_8(struct device *dev,
>  
>  	ret = spi_w8r8(st->us, ADE7759_READ_REG(reg_address));
>  	if (ret < 0) {
> -		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
> -				reg_address);
> +		dev_err(&st->us->dev,
> +			"problem when reading 8 bit register 0x%02X",
> +			reg_address);
>  		return ret;
>  	}
>  	*val = ret;
> @@ -138,8 +139,8 @@ static int ade7759_spi_read_reg_8(struct device *dev,
>  }
>  
>  static int ade7759_spi_read_reg_16(struct device *dev,
> -		u8 reg_address,
> -		u16 *val)
> +				   u8 reg_address,
> +				   u16 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7759_state *st = iio_priv(indio_dev);
> @@ -158,8 +159,8 @@ static int ade7759_spi_read_reg_16(struct device *dev,
>  }
>  
>  static int ade7759_spi_read_reg_40(struct device *dev,
> -		u8 reg_address,
> -		u64 *val)
> +				   u8 reg_address,
> +				   u64 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7759_state *st = iio_priv(indio_dev);
> @@ -179,8 +180,9 @@ static int ade7759_spi_read_reg_40(struct device *dev,
>  
>  	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
> -		dev_err(&st->us->dev, "problem when reading 40 bit register 0x%02X",
> -				reg_address);
> +		dev_err(&st->us->dev,
> +			"problem when reading 40 bit register 0x%02X",
> +			reg_address);
>  		goto error_ret;
>  	}
>  	*val = ((u64)st->rx[1] << 32) | ((u64)st->rx[2] << 24) |
> @@ -192,8 +194,8 @@ static int ade7759_spi_read_reg_40(struct device *dev,
>  }
>  
>  static ssize_t ade7759_read_8bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	int ret;
>  	u8 val = 0;
> @@ -207,8 +209,8 @@ static ssize_t ade7759_read_8bit(struct device *dev,
>  }
>  
>  static ssize_t ade7759_read_16bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	int ret;
>  	u16 val = 0;
> @@ -222,8 +224,8 @@ static ssize_t ade7759_read_16bit(struct device *dev,
>  }
>  
>  static ssize_t ade7759_read_40bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	int ret;
>  	u64 val = 0;
> @@ -237,9 +239,9 @@ static ssize_t ade7759_read_40bit(struct device *dev,
>  }
>  
>  static ssize_t ade7759_write_8bit(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> @@ -255,9 +257,9 @@ static ssize_t ade7759_write_8bit(struct device *dev,
>  }
>  
>  static ssize_t ade7759_write_16bit(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> @@ -277,9 +279,7 @@ static int ade7759_reset(struct device *dev)
>  	int ret;
>  	u16 val;
>  
> -	ret = ade7759_spi_read_reg_16(dev,
> -			ADE7759_MODE,
> -			&val);
> +	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &val);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -365,9 +365,7 @@ static int ade7759_stop_device(struct device *dev)
>  	int ret;
>  	u16 val;
>  
> -	ret = ade7759_spi_read_reg_16(dev,
> -			ADE7759_MODE,
> -			&val);
> +	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &val);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to power down the device, error: %d\n",
>  			ret);
> @@ -404,16 +402,14 @@ static int ade7759_initial_setup(struct iio_dev *indio_dev)
>  }
>  
>  static ssize_t ade7759_read_frequency(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
>  	int ret;
>  	u16 t;
>  	int sps;
>  
> -	ret = ade7759_spi_read_reg_16(dev,
> -			ADE7759_MODE,
> -			&t);
> +	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &t);
>  	if (ret)
>  		return ret;
>  
> @@ -424,9 +420,9 @@ static ssize_t ade7759_read_frequency(struct device *dev,
>  }
>  
>  static ssize_t ade7759_write_frequency(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7759_state *st = iio_priv(indio_dev);
