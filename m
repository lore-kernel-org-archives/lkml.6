Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B248C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5319724709
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuzeSXVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5319724709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeGDHwL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:52:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40914 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbeGDHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:52:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so4658366wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gmk4NOoa/0X0xxj87QLfORMlStN7lsbxZU3mKfMoIxQ=;
        b=WuzeSXVzqD9LzzFUPrAULi0Diu/uh8ZVipT/LL5CDWDOXpndS/XStUksJpQ0GLsUaS
         D5cqbqwaZKKa+Jr47bEb6G12Qqu2jh6LA66u3KaxqaVSevTtm9/IXx5tmDKLlhIJCWUj
         V4IHhFNcSlCw9dI3G7li//EsCPsWaq2GLnk0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gmk4NOoa/0X0xxj87QLfORMlStN7lsbxZU3mKfMoIxQ=;
        b=Smysg6warpX8B7FDmz9iGeAE6g3pXuls42WTDdcHVlIO28F/J1engmdXk5xIMDV8N4
         zha1flUuqAiWhxbUbVnTtVLqeiA1l21lObr2dWNXBaPLr7Y/2EQNw24qljtHtBIUgZUk
         tO2zTlXT6feGdATTyMy8ZHwMDROWImKpQLUcz+XJMJ9gG8APVU36E/Yo8ao2+k55EqQw
         u0ADBbn9EpUtLBK7Bea3aTT91v54yp98M+Xzrv3GF2ihz7eZpG8IHAT6wQAfuCx8iDMi
         1MVNGtihARR2qb/ElTBhy+29TMp95UTKo1SlL/zMhn1bw9jRPE5taWSbKVh6BNvzMBO+
         kJFw==
X-Gm-Message-State: APt69E18grYc0mEvmWC+iPqBpgPbtCDVM3DYUpdcGN3nAiowOO8l1lai
        /2rjn33mPVdKzm/9O8fonIivow==
X-Google-Smtp-Source: AAOMgpcwHAfKdfWEGqb3a52b9sICMVzDT6PrQISqhykfRzaRnwbpk5tQVakDdKbCcvIeA0y7G67AMg==
X-Received: by 2002:a1c:815:: with SMTP id 21-v6mr817636wmi.151.1530690725003;
        Wed, 04 Jul 2018 00:52:05 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id r123-v6sm5406456wmb.21.2018.07.04.00.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:52:04 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:52:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: as3722: disable auto power on when AC OK
Message-ID: <20180704075202.GQ20176@dell>
References: <20180703150411.29709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703150411.29709-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> On ams AS3722, power on when AC OK is enabled by default.
> Making this option as disable by default and enable only
> when platform need this explicitly.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Reviewed-by: Bibek Basu <bbasu@nvidia.com>
> Tested-by: Bibek Basu <bbasu@nvidia.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Document device tree property as suggested by Stefan.
> - Rename SEQ1 to SEQU1 as per datasheet as suggested by Stefan.
> - Drop reference to downstream commit as suggested by Lee.
> 
>  Documentation/devicetree/bindings/mfd/as3722.txt |  2 ++
>  drivers/mfd/as3722.c                             | 12 ++++++++++++
>  include/linux/mfd/as3722.h                       |  3 +++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
> index 5297b2210704..2a665741d7fe 100644
> --- a/Documentation/devicetree/bindings/mfd/as3722.txt
> +++ b/Documentation/devicetree/bindings/mfd/as3722.txt
> @@ -20,6 +20,8 @@ Optional properties:
>  - ams,enable-internal-i2c-pullup: Boolean property, to enable internal pullup on
>  	i2c scl/sda pins. Missing this will disable internal pullup on i2c
>  	scl/sda lines.
> +- ams,enable-ac-ok-power-on: Boolean property, to enable exit out of power off
> +	mode with AC_OK pin (pin enabled in power off mode).

This needs a DT Ack.

>  Optional submodule and their properties:
>  =======================================
> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index f87342c211bc..4d069ed21ff6 100644
> --- a/drivers/mfd/as3722.c
> +++ b/drivers/mfd/as3722.c
> @@ -349,6 +349,8 @@ static int as3722_i2c_of_probe(struct i2c_client *i2c,
>  					"ams,enable-internal-int-pullup");
>  	as3722->en_intern_i2c_pullup = of_property_read_bool(np,
>  					"ams,enable-internal-i2c-pullup");
> +	as3722->en_ac_ok_pwr_on = of_property_read_bool(np,
> +					"ams,enable-ac-ok-power-on");
>  	as3722->irq_flags = irqd_get_trigger_type(irq_data);
>  	dev_dbg(&i2c->dev, "IRQ flags are 0x%08lx\n", as3722->irq_flags);
>  	return 0;
> @@ -360,6 +362,7 @@ static int as3722_i2c_probe(struct i2c_client *i2c,
>  	struct as3722 *as3722;
>  	unsigned long irq_flags;
>  	int ret;
> +	u8 val = 0;
>  
>  	as3722 = devm_kzalloc(&i2c->dev, sizeof(struct as3722), GFP_KERNEL);
>  	if (!as3722)
> @@ -398,6 +401,15 @@ static int as3722_i2c_probe(struct i2c_client *i2c,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (as3722->en_ac_ok_pwr_on)
> +		val = AS3722_CTRL_SEQU1_AC_OK_PWR_ON;
> +	ret = as3722_update_bits(as3722, AS3722_CTRL_SEQU1_REG,
> +			AS3722_CTRL_SEQU1_AC_OK_PWR_ON, val);

What is the default value?

If 0, you could place all of this code inside the "if
(as3722->en_ac_ok_pwr_on)" and save on a few unnecessary cycles.

> +	if (ret < 0) {
> +		dev_err(as3722->dev, "CTRLsequ1 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = devm_mfd_add_devices(&i2c->dev, -1, as3722_devs,
>  				   ARRAY_SIZE(as3722_devs), NULL, 0,
>  				   regmap_irq_get_domain(as3722->irq_data));
> diff --git a/include/linux/mfd/as3722.h b/include/linux/mfd/as3722.h
> index 51e6f9414575..b404a5af9bba 100644
> --- a/include/linux/mfd/as3722.h
> +++ b/include/linux/mfd/as3722.h
> @@ -296,6 +296,8 @@
>  #define AS3722_ADC1_CONV_NOTREADY			BIT(7)
>  #define AS3722_ADC1_SOURCE_SELECT_MASK			0x1F
>  
> +#define AS3722_CTRL_SEQU1_AC_OK_PWR_ON			BIT(0)
> +
>  /* GPIO modes */
>  #define AS3722_GPIO_MODE_MASK				0x07
>  #define AS3722_GPIO_MODE_INPUT				0x00
> @@ -391,6 +393,7 @@ struct as3722 {
>  	unsigned long irq_flags;
>  	bool en_intern_int_pullup;
>  	bool en_intern_i2c_pullup;
> +	bool en_ac_ok_pwr_on;
>  	struct regmap_irq_chip_data *irq_data;
>  };
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
