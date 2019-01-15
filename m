Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60792C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC1320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTWDHC8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfAOSrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:47:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42404 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfAOSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:47:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so1687532plp.9;
        Tue, 15 Jan 2019 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wSubFHe8/oa13pkZFXARBTKBZdVFUdlmdipdfvfpkeI=;
        b=MTWDHC8RFGyRex+H2Nfmp5PSbEJTuyktG147FZltIu5vJco8lMAqQz5cZmlI81bdU4
         LwP1jmZOA0RVw2MiNuaDOg2mHyStc/L8/mAEh3TUZfNkwQWU4EkhTn489PuEs263FZK1
         qGsppYiOpY+C0RJegDWnZoEtWpAri4MHnYD1SbO4/EYCT/cc28t9uULuskac4JCcV+u2
         HYbVKtQlVKWClu3DryTAVAwz7WYTKUrql6YbZOr1bDzI3Jp1XeKb49JbjfuF+gwdlQyv
         bkBgpXM0tOyFnBdVlAIgG3LubMn6EquiBc/kbdo3rzX2d2X/qqZrzM8Q6z9/YF+Ws60o
         1qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSubFHe8/oa13pkZFXARBTKBZdVFUdlmdipdfvfpkeI=;
        b=eUazdq9KCN45qrsWl0acHGYTfViMjxDvk4V0F6so4ocvklch4OkkmLWZlkjg3URQau
         OF0uBdBkThAt3t0B7uPYr1NXfwwwwqlCM0j0jiu5Jci0ALc0vGuXBTTS7dzzjCN9Mbxc
         +cV8f59lTk21kTWH0tFB51l+qH3FDVzameSsJnxWQKCX7zHoeGnHQOY7W+YlIvvXDb/2
         2OSIyxJ8pthBPLhAgZ27Ykr2ezM4dcT1q3HysogRC2O/tX+4XpggvxBYRA33znSjLZGj
         wQvtDGdO68O8ORGPVoGQWYoFCM3p91zChqE1Wtnbd9FPioaMrOG7yQuKMy2qwZjgCSmY
         TXAg==
X-Gm-Message-State: AJcUukcPt3ndo53V5rGNc318B7cZGMNPYGmSIdUXFcAwCnT/khAzCLp2
        +/4AwJdM7csec5+CeGloMPE=
X-Google-Smtp-Source: ALg8bN4U9bGnrVNvciptPR0wmUuvLHxv6XdiAFv/I2ATGurxKGim5ducKO80krh86fVjDsqL/MRiRA==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr5409669plb.223.1547578041530;
        Tue, 15 Jan 2019 10:47:21 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id z7sm6890722pga.6.2019.01.15.10.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:47:20 -0800 (PST)
Date:   Wed, 16 Jan 2019 00:17:13 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH v3 1/2] iio: chemical: bme680: Add device-tree support
Message-ID: <20190115184713.GC10186@himanshu-Vostro-3559>
References: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:19:13PM -0500, Sebastien Bourdelin wrote:
> This commit allow the driver to work with device-tree.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> ---

	Acked-by: Himanshu Jha <himanshujha199640@gmail.com>

Thanks!

> v2 -> v3:
>   - remove of_match_ptr: Suggested by Jonathan Cameron <jic23@kernel.org>
>   - minor style fixup
>   - rebase on master
> v1 -> v2:
>   - add missing of.h header in bme680_spi.c
> ---
>  drivers/iio/chemical/bme680_i2c.c | 7 +++++++
>  drivers/iio/chemical/bme680_spi.c | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> index 06d4be539d2e..b2f805b6b36a 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
>  
> +static const struct of_device_id bme680_of_i2c_match[] = {
> +	{ .compatible = "bosch,bme680", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
> +
>  static struct i2c_driver bme680_i2c_driver = {
>  	.driver = {
>  		.name			= "bme680_i2c",
>  		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
> +		.of_match_table		= bme680_of_i2c_match,
>  	},
>  	.probe = bme680_i2c_probe,
>  	.id_table = bme680_i2c_id,
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index c9fb05e8d0b9..d0b7bdd3f066 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> @@ -110,10 +111,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
>  
> +static const struct of_device_id bme680_of_spi_match[] = {
> +	{ .compatible = "bosch,bme680", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
> +
>  static struct spi_driver bme680_spi_driver = {
>  	.driver = {
>  		.name			= "bme680_spi",
>  		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
> +		.of_match_table		= bme680_of_spi_match,
>  	},
>  	.probe = bme680_spi_probe,
>  	.id_table = bme680_spi_id,
> -- 
> 2.20.1
> 

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
