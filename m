Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeBQOMY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 09:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeBQOMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 09:12:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59EC217A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 14:12:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Lai <richard@richardman.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ccs811: Typo correction in HW_ID_VALUE
 constant define naming
Message-ID: <20180217141148.78246adc@archlinux>
In-Reply-To: <1518561421-11736-1-git-send-email-richard@richardman.com>
References: <1518561421-11736-1-git-send-email-richard@richardman.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 22:36:57 +0000
Richard Lai <richard@richardman.com> wrote:

> This particular constant was named with prefix "CCS881", which should be
> "CCS811" instead, just like the rest of constant names in the file, as this
> driver implementation is for AMS CCS811 sensor. "CCS881" could literally be
> referring to another sensor product unrelated to AMS CCS811 sensor.
> 
> Signed-off-by: Richard Lai <richard@richardman.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/ccs811.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 840a6cb..8e8beb7 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -31,7 +31,7 @@
>  #define CCS811_ALG_RESULT_DATA	0x02
>  #define CCS811_RAW_DATA		0x03
>  #define CCS811_HW_ID		0x20
> -#define CCS881_HW_ID_VALUE	0x81
> +#define CCS811_HW_ID_VALUE	0x81
>  #define CCS811_HW_VERSION	0x21
>  #define CCS811_HW_VERSION_VALUE	0x10
>  #define CCS811_HW_VERSION_MASK	0xF0
> @@ -315,7 +315,7 @@ static int ccs811_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret != CCS881_HW_ID_VALUE) {
> +	if (ret != CCS811_HW_ID_VALUE) {
>  		dev_err(&client->dev, "hardware id doesn't match CCS81x\n");
>  		return -ENODEV;
>  	}
