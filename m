Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C671C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10592146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550658628;
	bh=MVznfsX95EaztBzEBEXYfwN1lCoZgYbS1R7JuMHRoss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MDZ0rpQGn92Y9ds02xpuqOQBH2/1JRIJDoun2vIPT4MtC+gDlM5+W4kOVAbAxl8YM
	 fTaC2iigUhEzhdpLjXJf+ibM5HKngzicqObjG972aFN+Jd9CFob58WZUGKLGgw4CK7
	 PK6xEpBOIqhgI2FpO5WDdzevoU6jegp6tvViH+EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBTKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBTKa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:30:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC132086A;
        Wed, 20 Feb 2019 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550658626;
        bh=MVznfsX95EaztBzEBEXYfwN1lCoZgYbS1R7JuMHRoss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JA/fR+KM7LuHLX2ZOAIAb2QjnflFrIYbcW0sjAUYo/Uzn9Nk3Cn+M3qTzN8b917r/
         vw6hKOz8S3jn29IWU51quk5C3KfkYj+4V5pzJW4gSxTLvU7t6siPmrEleNN+pg38Al
         szvQpf9QSWIRl4IAg9RL9gVtOqGE7g6dVVaZCA1w=
Date:   Wed, 20 Feb 2019 10:30:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/6] iio: imu: adis16480: Add OF device ID table
Message-ID: <20190220103020.095382d6@archlinux>
In-Reply-To: <1550596338-24220-4-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
        <1550596338-24220-4-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 19:12:15 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The driver does not have a struct of_device_id table, but supported
> devices are registered via Device Trees. This patch adds OF device ID
> table.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
This is fine, I'll pick it up in v2.
> ---
>  drivers/iio/imu/adis16480.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 38ba0c1..7ae71f4 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -988,9 +988,19 @@ static const struct spi_device_id adis16480_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adis16480_ids);
>  
> +static const struct of_device_id adis16480_of_match[] = {
> +	{ .compatible = "adi,adis16375" },
> +	{ .compatible = "adi,adis16480" },
> +	{ .compatible = "adi,adis16485" },
> +	{ .compatible = "adi,adis16488" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adis16480_of_match);
> +
>  static struct spi_driver adis16480_driver = {
>  	.driver = {
>  		.name = "adis16480",
> +		.of_match_table = adis16480_of_match,
>  	},
>  	.id_table = adis16480_ids,
>  	.probe = adis16480_probe,

