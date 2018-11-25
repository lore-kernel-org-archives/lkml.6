Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E324C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCACA20868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWCpcWj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCACA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeKYUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeKYUuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:50:03 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB3A20672;
        Sun, 25 Nov 2018 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543139960;
        bh=LKYFmvkVg1l6SZYRzS1rVh/o5Jsc9irGQq5YdHPU2mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BWCpcWj434QGPpYyAUwNDjYNbGKNUJiF1Mw52jcbSBSCLPBwHxsrvNHcI5yytS4Cf
         tlmXby7ZCkClvfO7uv+ZVTKoHDM7jHW8z1RRDOzBmLbZEpwGGOl9g6HrwXo1vBlXTX
         n5IlMK4rHHw2D243Pdow/L/o7anxsGlLFW53jTrw=
Date:   Sun, 25 Nov 2018 09:59:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad5933: add device tree support
Message-ID: <20181125095916.58de5773@archlinux>
In-Reply-To: <20181124131857.ur6rt7nnjinmj6gm@smtp.gmail.com>
References: <20181124131857.ur6rt7nnjinmj6gm@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2018 11:18:57 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to complete device tree support.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.  Note we'll need a binding
doc for this before it can leave staging.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index edb8b540bbf1..6faa2700dc8d 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, ad5933_id);
>  
> +static const struct of_device_id ad5933_of_match[] = {
> +	{ .compatible = "adi,ad5933" },
> +	{ .compatible = "adi,ad5934" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
>  static struct i2c_driver ad5933_driver = {
>  	.driver = {
>  		.name = "ad5933",
> +		.of_match_table = ad5933_of_match,
>  	},
>  	.probe = ad5933_probe,
>  	.remove = ad5933_remove,

