Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDOSLl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752464AbeDOSLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:11:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CD92172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 19:11:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] iio:dac:ad5686: Style fixes no functional
 changes
Message-ID: <20180415191134.0bb81d86@archlinux>
In-Reply-To: <1523447511-13059-1-git-send-email-stefan.popa@analog.com>
References: <1523375806-29296-1-git-send-email-stefan.popa@analog.com>
        <1523447511-13059-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 14:51:51 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch fixes some indentation issues and does not modify the
> functionality of the driver.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
I'll try unwinding it this time, but please make absolutely
sure you don't reply to an existing series with a new series.
The patches are displayed in my email account, weirdly nested
and interleaved out of order.

Much nicer to have a new separate series!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it,

Thanks,

Jonathan

> ---
> Changes v2:
> 	- Nothing changed, just follow the patch set version.
> Changes v3:
>         - Nothing changed, just follow the patch set version.
> 
>  drivers/iio/dac/ad5686.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 20254df..f7f975c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -24,7 +24,7 @@
>  #define AD5686_ADDR(x)				((x) << 16)
>  #define AD5686_CMD(x)				((x) << 20)
>  
> -#define AD5686_ADDR_DAC(chan)		(0x1 << (chan))
> +#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
>  #define AD5686_ADDR_ALL_DAC			0xF
>  
>  #define AD5686_CMD_NOOP				0x0
> @@ -137,7 +137,7 @@ static const char * const ad5686_powerdown_modes[] = {
>  };
>  
>  static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan)
> +				     const struct iio_chan_spec *chan)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> @@ -145,7 +145,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
>  }
>  
>  static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, unsigned int mode)
> +				     const struct iio_chan_spec *chan,
> +				     unsigned int mode)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> @@ -163,17 +164,19 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
>  };
>  
>  static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
> -	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> +		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
>  	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
> -			(0x3 << (chan->channel * 2))));
> +				       (0x3 << (chan->channel * 2))));
>  }
>  
>  static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
> -	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
> -	 size_t len)
> +					  uintptr_t private,
> +					  const struct iio_chan_spec *chan,
> +					  const char *buf,
> +					  size_t len)
>  {
>  	bool readin;
>  	int ret;
> @@ -221,10 +224,10 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int ad5686_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  	int ret;
