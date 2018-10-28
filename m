Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A4ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4520824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enVUNLUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJ1O5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 10:57:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43186 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJ1O5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 10:57:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id h4-v6so2436655pfi.10;
        Sat, 27 Oct 2018 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7l5MjYNY6iHKRdMuj46MLgoai5f2CgS8d4jA3bILCwo=;
        b=enVUNLUSZRKi0GJhtyRqWg0kU27qxNWtn/NdmkRjJUlAlOxZMI2lgpQCSPnqUQQQay
         LNC6auRAn9aBhj9W0ccmna9/5ZEbTh9fm/Rg8kXUxAz4m05hTgWEuggN0ydWpWBMCoOK
         04rvS85dYjayQwNLvr2PeM45ZpNvmJ5FrdtOX5zAG5BtQKJpUi6PuIl4DcVO0VyKguFt
         Nv8Zj2vW3lpuY9eXY+/sc4hV0LNyNArLz/qA65F1H7CHuiEtBDUx/VbBoghsdBtWjyrP
         LgreoohIaLLfMqWpxOWL69Ok0Z75HnVXBLc85Sy1lVf7BGkPC2IxOCQVXeT5pFUXt71L
         CjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7l5MjYNY6iHKRdMuj46MLgoai5f2CgS8d4jA3bILCwo=;
        b=nt3Ck1UDNqqYXFr/nerFjVw3VqEkXD/+gvUG4goSVNPzEoicNVrMgIc18R9AhCqYe2
         kQOsenUvUv+SrC7vBO9Fg2a09MX7FR8RR+uHXGqTCw9FH2iJfCBKv6lRJogGQZMie9tP
         I9BYMgZBwuEG4hJv8FfzURjmMDxvUm00bCw1Jjtxh5zfGk0pyvkFh8hUURRt7BEnqICY
         A1rzuAd4T003GnT5QnPNonOf/glfxgZOYBpShmGgwPluyP20Eepp4mKLG7ZDhtHrYdhj
         nsHfCK1aBEbZ0xSGVggwsHYyWZtiibauQyV2UxzKYoPNv7znZF1zgp6BoO5kbysfmoiP
         XBYQ==
X-Gm-Message-State: AGRZ1gIjxZ5GRLNH3chqS9nrNx+kVa+79Dx4ZWYiWRE8Xzf/+p8XgEw3
        tEgDnD4WOrBxaj52wPP9DZI=
X-Google-Smtp-Source: AJdET5cqPxYrx0DNbJH4XIWeBG/blsx1TkIlcoRDAKtSqgOCi4TqoYzTlrE/o7iCj7yR/J+C4/yqBQ==
X-Received: by 2002:a62:7a92:: with SMTP id v140-v6mr3388186pfc.46.1540707237527;
        Sat, 27 Oct 2018 23:13:57 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id s186-v6sm13084188pfs.164.2018.10.27.23.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 23:13:57 -0700 (PDT)
Date:   Sun, 28 Oct 2018 11:43:48 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] staging: iio: ad2s1210: Add device tree support.
Message-ID: <20181028061346.GA5696@nishad>
References: <cover.1540489369.git.nishadkamdar@gmail.com>
 <1dc6fdf4626e7cf1ca4933fe3008cb3cd267149b.1540489369.git.nishadkamdar@gmail.com>
 <20181027154903.GA1582@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027154903.GA1582@x220.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 05:49:03PM +0200, Slawomir Stepien wrote:
> Hi
> 
> On paź 26, 2018 18:55, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID
> > and support for retrieving platform data
> > from device tree.
> 
> So maybe you should make 2 commits?
>
Ok. I'll do that.
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++++-
> >  1 file changed, 42 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index 93c3c70ce62e..9fd5461c4ed0 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -669,6 +670,27 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	struct ad2s1210_platform_data *pdata;
> > +
> > +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return NULL;
> > +
> > +	pdata->gpioin = of_property_read_bool(np, "adi,gpioin");
> 
> Why here you are adding "adi", but you are not adding it to the gpios in prev
> commit?
> 
> I've also seen this: https://patchwork.kernel.org/patch/10355839/. However I do
> not understand why adding vendor id to props is needed...
>
> > +
> > +	return pdata;
> > +}
> > +#else
> > +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> >  static int ad2s1210_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -682,7 +704,19 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  	st = iio_priv(indio_dev);
> > -	st->pdata = spi->dev.platform_data;
> > +	if (spi->dev.of_node) {
> > +		st->pdata = ad2s1210_parse_dt(&spi->dev);
> > +		if (!st->pdata)
> > +			return -EINVAL;
> > +	} else {
> > +		st->pdata = spi->dev.platform_data;
> > +	}
> > +
> > +	if (!st->pdata) {
> > +		dev_err(&spi->dev, "ad2s1210: no platform data supplied\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> Why not just use only device-tree here? The ad2s1210_platform_data has now only
> one entry... In that case remember to add "depends on OF" in Kconfig.
>

Ok. I'll do that.
> >  	ret = ad2s1210_setup_gpios(st);
> >  	if (ret < 0)
> >  		return ret;
> > @@ -724,6 +758,12 @@ static int ad2s1210_remove(struct spi_device *spi)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad2s1210_of_match[] = {
> > +	{ .compatible = "adi,ad2s1210", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
> > +
> >  static const struct spi_device_id ad2s1210_id[] = {
> >  	{ "ad2s1210" },
> >  	{}
> > @@ -733,6 +773,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
> >  static struct spi_driver ad2s1210_driver = {
> >  	.driver = {
> >  		.name = DRV_NAME,
> > +		.of_match_table = of_match_ptr(ad2s1210_of_match),
> >  	},
> >  	.probe = ad2s1210_probe,
> >  	.remove = ad2s1210_remove,
> 
> -- 
> Slawomir Stepien

Thanks for the review.

Regards,
Nishad
