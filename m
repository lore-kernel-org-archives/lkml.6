Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeDOSVD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbeDOSVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:21:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53132176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 19:20:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iio:dac:ad5686: Add support for AD5685R
Message-ID: <20180415192056.6e28b695@archlinux>
In-Reply-To: <1523447568-13386-1-git-send-email-stefan.popa@analog.com>
References: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
        <1523447568-13386-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 14:52:48 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This driver acctually supports the AD5685R device and NOT the AD5685, which
> does not exist.
> 
> More information can be found in the datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686_5684.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hmm. Problem here is if there are devicetrees out there using the wrong name.
We can't be sure there aren't. So right option is to keep both in the id table.

I've modified the patch to include the wrong name with a note saying it
doesn't actually exist.

Hope that is fine with you

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Refactored the patch to add support for new parts
> Changes in v3:
> 	- Nothing changed, just to follow the patch set version.
> 
>  drivers/iio/dac/ad5686.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 87d6e6e..a753ffd 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -88,7 +88,7 @@ struct ad5686_state {
>  
>  enum ad5686_supported_device_ids {
>  	ID_AD5684,
> -	ID_AD5685,
> +	ID_AD5685R,
>  	ID_AD5686,
>  };
>  static int ad5686_spi_write(struct ad5686_state *st,
> @@ -303,7 +303,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 4,
>  		.int_vref_mv = 2500,
>  	},
> -	[ID_AD5685] = {
> +	[ID_AD5685R] = {
>  		.channels = ad5685r_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
> @@ -392,7 +392,7 @@ static int ad5686_remove(struct spi_device *spi)
>  
>  static const struct spi_device_id ad5686_id[] = {
>  	{"ad5684", ID_AD5684},
> -	{"ad5685", ID_AD5685},
> +	{"ad5685r", ID_AD5685R},
>  	{"ad5686", ID_AD5686},
>  	{}
>  };
