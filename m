Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FCF2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxxxZcOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbeLULBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:01:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53113 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390017AbeLULBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:01:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so4903759wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 03:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TEhgGEM/s+zPGiLOg1sZc8ktmTUnmyqwliueIKtQ5X0=;
        b=TxxxZcOPSPxBkbre9ZUupxvrg24UHGIoUVTO45iipZ4DTRbfmV0RroRtD4xcwM0wX1
         sRP0u2ZXkMdVntquXUBxYoTx+TItEW4ySe5Kb3lx0WAMnF5y4Zu9pP6sY/jkRZGKx5tb
         kt7HW83Chuim0n2SRRTF+A3OG04VhrxPrXt8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TEhgGEM/s+zPGiLOg1sZc8ktmTUnmyqwliueIKtQ5X0=;
        b=uA8fQrmx8+XHisxGce7/hCcJ+OjQSq9VRRmP3DsA1h1+H/obCYVSksTOrxRXPHRxlz
         52kWyICBP2KK6WPj4KRq9DwotMqtvLRXHOu6esIXvem5QP3FC/wxExwWlGlKGh10+Xzk
         bsWSrJdc6vhUuUejDdwyJroWIDI3IA1iV0a25DEZctDsKBVG/L138xo2U0YfJTvpMQof
         TkdwOJYgi5+fNei20fHiGGo8kaYTgFv7u49Isgot1NLCAx2UPbUCDF2lgX+rZ08iSzQ0
         AXCI/HF/vyH5YGaQljkb7izoGNVCUdusGpGzbcbuoSP45LerH3dxXYS3LKrRSUNjAsqB
         xFsg==
X-Gm-Message-State: AA+aEWbqF86PrDtLuC5JAsdrDXVRkSjjT32EdPjuw5CqcpfB0Vd7KcsE
        FMO1lgb8SXxZzWCsGTIYLzERgw==
X-Google-Smtp-Source: ALg8bN6Fn6L22oeY0QXQ2kXiSTZf/J9wJBQSjsImJzvohaC0yAwZ/ZOP5/BdGYHgMvNOuxW9T7JpnA==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr2276937wmm.52.1545390090884;
        Fri, 21 Dec 2018 03:01:30 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id a12sm9755570wrm.45.2018.12.21.03.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 03:01:30 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:01:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20181221110128.GO13248@dell>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:

> These options apply to all regulators in this chip.
> 
> strict-supply-voltage:
>   Set STRICT flag in CONFIG1
> under-voltage-limit:
>   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> under-voltage-hysteresis:
>   Select 200mV or 400mV UVLOHYS in CONFIG2
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

This needs a close review by Tony and any of the other OMAP guys.

At the very least, please put '\n's between the if() statements.  You
also need to return after an error print, else I suggest it's not an
error.

It would also look tidier if you changed the if()s to one liners to
assign to different variables, then dealt with them separately later
on.  The way it's done here looks messy to say the least.

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 8bcdecf..f5e559b 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -211,6 +211,50 @@ static const struct of_device_id of_tps65218_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
>  
> +static void tps65218_options(struct tps65218 *tps)
> +{
> +	struct device *dev = tps->dev;
> +	struct device_node *np = dev->of_node;
> +	u32 pval;

What does pval mean?  I suggest just val is more common.

> +	if (!of_property_read_u32(np, "strict-supply-voltage", &pval)) {
> +		tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
> +			TPS65218_CONFIG1_STRICT,
> +			pval ? TPS65218_CONFIG1_STRICT : 0,
> +			TPS65218_PROTECT_L1);
> +		dev_dbg(dev, "tps65218 strict-supply-voltage: %d\n", pval);
> +	}
> +	if (!of_property_read_u32(np, "under-voltage-hysteresis", &pval)) {
> +		if (pval != 400000 && pval != 200000) {
> +			dev_err(dev,
> +				 "under-voltage-hysteresis must be %d or %d\n",
> +				 200000, 400000);
> +		} else {
> +			tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
> +				TPS65218_CONFIG2_UVLOHYS,
> +				pval == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
> +				TPS65218_PROTECT_L1);
> +		}
> +		dev_dbg(dev, "tps65218 under-voltage-hysteresis: %d\n", pval);
> +	}
> +	if (!of_property_read_u32(np, "under-voltage-limit", &pval)) {
> +		int i, vals[] = { 275, 295, 325, 335 };
> +
> +		for (i = 0; i < ARRAY_SIZE(vals); i++) {
> +			if (pval == vals[i] * 10000)

Just use the full value in 'vals'.

> +				break;
> +		}

It took me a few seconds to realise what you're doing here.

I think a switch() statement would be cleaner.

You should also #define the values.

TPS65218_UNDER_VOLT_LIM_2750000 0

Etc.

> +		if (i < ARRAY_SIZE(vals)) {
> +			tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
> +				TPS65218_CONFIG1_UVLO_MASK, i,
> +				TPS65218_PROTECT_L1);
> +		} else {
> +			dev_err(dev, "Invalid under-voltage-limit: %d\n", pval);

This could go in the default: section.

> +		}
> +		dev_dbg(dev, "tps65218 under-voltage-limit: %d=%d\n", pval, i);

I suggest considering removing these.

> +	}
> +}
> +
>  static int tps65218_probe(struct i2c_client *client,
>  				const struct i2c_device_id *ids)
>  {
> @@ -249,6 +293,8 @@ static int tps65218_probe(struct i2c_client *client,
>  
>  	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
>  
> +	tps65218_options(tps);

Options is not good nomenclature as it doesn't really tell us
anything.  Looks like all the values are voltage related to me?

>  	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
>  			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
