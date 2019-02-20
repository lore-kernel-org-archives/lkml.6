Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD18C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30952146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550679590;
	bh=oRxw5BjXoDBrqaHGSXs7j0Lh7ht9b3S+xJpXBliLBlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J/ssQfAiCAKsIt5YJ89O/AeX+lWmBWKbVNj8MqhgQXfn684EydwOKmPq1GItUGUPU
	 BgUfjyoBJ4YWGb6HkVujl2GUD6oJWEiN8ocqzuT2qioVIs8aY4VKJBc4cIqQO7xhzB
	 /B5AERgNZzauk8Vzep9n6gv2GWPjSnqOxpjq8Xl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBTQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfBTQTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:19:49 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD2C20880;
        Wed, 20 Feb 2019 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550679588;
        bh=oRxw5BjXoDBrqaHGSXs7j0Lh7ht9b3S+xJpXBliLBlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2DL3Q/4FHo5Jab1NXn9T78bphbCGDPHaYmm/6xHWo0wgJ3ypsEXMmZF46qSg49PXS
         k84GALWpa4ptOOZF95Cx95JVwby+VIeSlhibHCYkpriEKxwID0gZ0Sn2mD6OTb4Anh
         rtfVh4nchmL1GH6kj19dlMl3Vr5eqeUvwjWSScBQ=
Date:   Wed, 20 Feb 2019 16:19:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] iio: magnetometer: hmc5843: add mount matrix
 support
Message-ID: <20190220161942.703f0c4a@archlinux>
In-Reply-To: <effcfa7fb13fb8ba2b8b13ab07a6eb86defec77e.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
        <effcfa7fb13fb8ba2b8b13ab07a6eb86defec77e.1550671256.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 15:00:56 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio
> clients.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
The rest of these are all fine, though I suggest considering
a local variable rather than the fiddly bit of casting.

Jonathan
> ---
>  drivers/iio/magnetometer/hmc5843.h      |  1 +
>  drivers/iio/magnetometer/hmc5843_core.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
> index a75224cf99df..e3e22d2508d3 100644
> --- a/drivers/iio/magnetometer/hmc5843.h
> +++ b/drivers/iio/magnetometer/hmc5843.h
> @@ -43,6 +43,7 @@ struct hmc5843_data {
>  	struct mutex lock;
>  	struct regmap *regmap;
>  	const struct hmc5843_chip_info *variant;
> +	struct iio_mount_matrix orientation;
>  	__be16 buffer[8];
>  };
>  
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index ada142fb7aa3..e6b6da70c152 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -237,6 +237,13 @@ int hmc5843_set_measurement_configuration(struct iio_dev *indio_dev,
>  	return hmc5843_set_meas_conf(data, meas_conf);
>  }
>  
> +static const struct iio_mount_matrix *
> +hmc5843_get_mount_matrix(const struct iio_dev *indio_dev,
> +			  const struct iio_chan_spec *chan)
> +{
> +	return &((struct hmc5843_data *)iio_priv(indio_dev))->orientation;
> +}
> +
>  static const struct iio_enum hmc5843_meas_conf_enum = {
>  	.items = hmc5843_meas_conf_modes,
>  	.num_items = ARRAY_SIZE(hmc5843_meas_conf_modes),
> @@ -247,6 +254,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
>  static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
>  	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
>  	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>  	{ },
>  };
>  
> @@ -260,6 +268,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
>  static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
>  	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
>  	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>  	{ },
>  };
>  
> @@ -635,6 +644,11 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
>  	data->variant = &hmc5843_chip_info_tbl[id];
>  	mutex_init(&data->lock);
>  
> +	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
> +				&data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = name;
>  	indio_dev->info = &hmc5843_info;

