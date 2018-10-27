Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419BC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E1420843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="T3slYCgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E1420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeJ1AaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:30:09 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:53953 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeJ1AaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:30:09 -0400
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <x220.localdomain>
Received: from x220.localdomain (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sat, 27 Oct 2018 17:48:41 +0200 (CEST)
Date:   Sat, 27 Oct 2018 17:49:03 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] staging: iio: ad2s1210: Add device tree support.
Message-ID: <20181027154903.GA1582@x220.localdomain>
References: <cover.1540489369.git.nishadkamdar@gmail.com>
 <1dc6fdf4626e7cf1ca4933fe3008cb3cd267149b.1540489369.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dc6fdf4626e7cf1ca4933fe3008cb3cd267149b.1540489369.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1540655323;
        bh=2Ng5HXZoZ5a4zxJqQh7L+eusyQ03ladSGI+4aJVJWJg=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         User-Agent:X-Interia-Antivirus;
        b=T3slYCgFLHHvt3uV9ektXnQa8WZZbTo8jNHK3NoK7Q0X6Yjp5DHE5LF9yAuI7pOpb
         Xhx3YB+pOO5+XL+Oa4L3qNYMg1M3Ab5q8Cbu2dqTCDSq64c0lySurXaUvPrWsBv5Gq
         WZ8KSwJvZ/JBvkerhWhRRVXnwRh/SPIu8ZYFiRP8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On paź 26, 2018 18:55, Nishad Kamdar wrote:
> Add device tree table for matching vendor ID
> and support for retrieving platform data
> from device tree.

So maybe you should make 2 commits?

> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 93c3c70ce62e..9fd5461c4ed0 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -669,6 +670,27 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct ad2s1210_platform_data *pdata;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	pdata->gpioin = of_property_read_bool(np, "adi,gpioin");

Why here you are adding "adi", but you are not adding it to the gpios in prev
commit?

I've also seen this: https://patchwork.kernel.org/patch/10355839/. However I do
not understand why adding vendor id to props is needed...

> +
> +	return pdata;
> +}
> +#else
> +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int ad2s1210_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -682,7 +704,19 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	st->pdata = spi->dev.platform_data;
> +	if (spi->dev.of_node) {
> +		st->pdata = ad2s1210_parse_dt(&spi->dev);
> +		if (!st->pdata)
> +			return -EINVAL;
> +	} else {
> +		st->pdata = spi->dev.platform_data;
> +	}
> +
> +	if (!st->pdata) {
> +		dev_err(&spi->dev, "ad2s1210: no platform data supplied\n");
> +		return -EINVAL;
> +	}
> +

Why not just use only device-tree here? The ad2s1210_platform_data has now only
one entry... In that case remember to add "depends on OF" in Kconfig.

>  	ret = ad2s1210_setup_gpios(st);
>  	if (ret < 0)
>  		return ret;
> @@ -724,6 +758,12 @@ static int ad2s1210_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id ad2s1210_of_match[] = {
> +	{ .compatible = "adi,ad2s1210", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
> +
>  static const struct spi_device_id ad2s1210_id[] = {
>  	{ "ad2s1210" },
>  	{}
> @@ -733,6 +773,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
>  static struct spi_driver ad2s1210_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(ad2s1210_of_match),
>  	},
>  	.probe = ad2s1210_probe,
>  	.remove = ad2s1210_remove,

-- 
Slawomir Stepien
