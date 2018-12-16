Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E263C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007C2183E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544961945;
	bh=ssCdJIdFTTi7E21xxfKQs0BAvRIo4H5F32ls9JeYowI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1AwwKvWuUPN1bjJddASYEdzzCxroboLhYc08VGzcfmzEptSNRkKiiikll04DicbkL
	 EfPnrEyS1ncgOGUP8SK0W52OLwsGxyTk3FUGvKCXL44eSMPVh6m3nymkEzZmzyUqd5
	 /qLHgmIp0ZwNBfNC4qK97e2VGGpuc8Xjq/HxmFUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeLPMFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPMFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:05:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FAB3217FA;
        Sun, 16 Dec 2018 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544961942;
        bh=ssCdJIdFTTi7E21xxfKQs0BAvRIo4H5F32ls9JeYowI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6NMqHlJ2jTrQF2UtklIGvgRppvoXIg09XYVYIlhYXzsiBuM4FvvFjzOsdmkpq3DV
         mGsXnQGP1lPNwCHABbI1axNUbVPbqiJGUypJ6pmBt0sYrbHZ/XH6CATO9ajmgBuit3
         Y9jTsbYDH1maTxEGKCcvJ71DbY6MrMx9eVrjPenA=
Date:   Sun, 16 Dec 2018 12:05:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hardik Singh Rathore <hardiksingh.k@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: drop unnecessary initialization
 of variables
Message-ID: <20181216120537.2c5c3280@archlinux>
In-Reply-To: <20181212164747.6402-1-hardiksingh.k@gmail.com>
References: <20181212164747.6402-1-hardiksingh.k@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 22:17:46 +0530
Hardik Singh Rathore <hardiksingh.k@gmail.com> wrote:

> Initialization is unnecessary when the variable is written before it is
> read. There were some occasions in which the driver would initialize `ret'
> during declaration without need.
> 
> Purely a cosmetic change with no functional impact.
> 
> Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
There is a lot of churn in this driver at the moment (this is one or
3 patch sets I'm reviewing for it today), but this seems to still be
relevant so I dealt with manually applying it.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 6 +++---
>  drivers/staging/iio/addac/adt7316-spi.c | 4 ++--
>  drivers/staging/iio/addac/adt7316.c     | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index 473e5e34ec00..48736c0ab0ef 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -47,7 +47,7 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
>  static int adt7316_i2c_write(void *client, u8 reg, u8 data)
>  {
>  	struct i2c_client *cl = client;
> -	int ret = 0;
> +	int ret;
>  
>  	ret = i2c_smbus_write_byte_data(cl, reg, data);
>  	if (ret < 0)
> @@ -59,7 +59,7 @@ static int adt7316_i2c_write(void *client, u8 reg, u8 data)
>  static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
>  {
>  	struct i2c_client *cl = client;
> -	int i, ret = 0;
> +	int i, ret;
>  
>  	if (count > ADT7316_REG_MAX_ADDR)
>  		count = ADT7316_REG_MAX_ADDR;
> @@ -78,7 +78,7 @@ static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
>  static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
>  {
>  	struct i2c_client *cl = client;
> -	int i, ret = 0;
> +	int i, ret;
>  
>  	if (count > ADT7316_REG_MAX_ADDR)
>  		count = ADT7316_REG_MAX_ADDR;
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> index 5cd22743e140..f524b4ccf5c7 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -27,7 +27,7 @@ static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
>  {
>  	struct spi_device *spi_dev = client;
>  	u8 cmd[2];
> -	int ret = 0;
> +	int ret;
>  
>  	if (count > ADT7316_REG_MAX_ADDR)
>  		count = ADT7316_REG_MAX_ADDR;
> @@ -56,7 +56,7 @@ static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
>  {
>  	struct spi_device *spi_dev = client;
>  	u8 buf[ADT7316_REG_MAX_ADDR + 2];
> -	int i, ret = 0;
> +	int i, ret;
>  
>  	if (count > ADT7316_REG_MAX_ADDR)
>  		count = ADT7316_REG_MAX_ADDR;
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 2f8a122f475d..2d1e707a8676 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2104,7 +2104,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned short *adt7316_platform_data = dev->platform_data;
> -	int ret = 0;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
>  	if (!indio_dev)

