Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8E20833
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzJWZM6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C8E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeITBEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:04:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39525 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeITBEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:04:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id v77-v6so6161565lfa.6;
        Wed, 19 Sep 2018 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYoor9Akjo3GZGq5KRgbv8soX4wqgwXJK8e8uf2iyyg=;
        b=QzJWZM6wYGbuhOKiDUzK0acSLzMp0zUDtcJfhvGevWiWDNsoso5itTl6/lV6vOX50o
         nnaibBHrLUarU7bEF9wHZpBq5fol26M+4wHhYT8SEeVgFw9fHFMiY8LTSC2LkwKzFSsZ
         VP4/CrUq6tdbhiUXSCzE1EqpLzjkzh8AU5ZAYez6B0am+N/Mai7tGRqo1zdtD/9xq7y5
         FI6eLI/xQ3k6uWs0aay7wtmVJq/7UBD30LPVTqMQEwWgvjWuDup7sqWIb6JFyVH+n0d8
         Hq/3ewVTveSrAzDvv7y5rk3tU5v/ZvRSn22rxUQ1U/bbHNEz1ytI4R3Fb9eNxRuGrH/+
         PIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYoor9Akjo3GZGq5KRgbv8soX4wqgwXJK8e8uf2iyyg=;
        b=YY0HYWpkBKpJZ4eO3vbbPGzQSK1tqAml5jgEol9dS4Ij204D50HvmHs9MfNHryrklr
         FIiUXFY1/6n2Ybs4jFbKUtQNC0uxa2a5aGJAargxPoCLRVJaiiJrV2Ezd/+g3gQHSqnR
         K7ISiW32ETzwmVDJ35Ef1QEhjH0LiOCgTrGodKh0Wjez2sIk1+yPKVQQYecsYbmoXvC6
         bFQRAz08J1vbedQhELv7BO/+9mB/WvEkFTjZ9+oEzRbArMHACC6JcdBNn8ndbtBl51te
         t/NqMifRHaCv5BTEtNcejjcHQGsfIoGM4Nx6JPi0Kz/9g+53jk5o2YowMhvZpNHyk+SL
         2gCg==
X-Gm-Message-State: APzg51ArVuz+Rt+TABrBswV9qIBTsUoyb4xQDF5TyWrJvS6lQ6SDm6iU
        doRI+ImeajDSG1Wq7BvfI9w=
X-Google-Smtp-Source: ANB0VdbucBUfynt/3oEaDaKu68KwIfD1cm9sYTUvr8zIapYoJxPxA5l32Uuq8XlUITvcB/ofGW2p8A==
X-Received: by 2002:a19:db15:: with SMTP id s21-v6mr17456473lfg.114.1537385119417;
        Wed, 19 Sep 2018 12:25:19 -0700 (PDT)
Received: from localhost (89-70-220-78.dynamic.chello.pl. [89.70.220.78])
        by smtp.gmail.com with ESMTPSA id b26-v6sm1244995lfc.68.2018.09.19.12.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 12:25:18 -0700 (PDT)
Date:   Wed, 19 Sep 2018 21:22:39 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     ryang <decatf@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180919192238.GA19391@arch>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
 <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments inline.

On Sat, Sep 15, 2018 at 01:42:14PM -0400, ryang wrote:
> Add device tree support for ROHM BH1750 series ambient light sensors.
>
> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  drivers/iio/light/bh1750.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index a814828e69f5..50b599abb383 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bh1750_id);
>
> +static const struct of_device_id bh1750_of_match[] = {
> +	{ .compatible = "rohm,bh1710", },
> +	{ .compatible = "rohm,bh1715", },
> +	{ .compatible = "rohm,bh1721", },
> +	{ .compatible = "rohm,bh1750", },
> +	{ .compatible = "rohm,bh1751", },
> +	{ }
> +};
> +

Hmm, I believe this should be exported additionally using
MODULE_DEVICE_TABLE(of, bh1750_of_match). Otherwise module loading
will not work as expected.

Moreover, we can do without DT and if you want to avoid
warning about unused variables you may consider enclosing everything
with:

#ifdef CONFIG_OF
...
#endif

>  static struct i2c_driver bh1750_driver = {
>  	.driver = {
>  		.name = "bh1750",
> +		.of_match_table = of_match_ptr(bh1750_of_match),
>  		.pm = BH1750_PM_OPS,

I've recently simplified setting pm ops so this would not apply to
iio/togreg cleanly.

>  	},
>  	.probe = bh1750_probe,
> --
> 2.17.1
>
