Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83153C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3421E21925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWMznEMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3421E21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGCHfi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:35:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33743 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeGCHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:35:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id k7-v6so844060wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=khARqK23fwtNTUnyjPwAAqYVlKWLobeGQnhlx9xy0nU=;
        b=GWMznEMnbFqYmDl19Uq4MUiFH4Uj20zXy2BK+LZaT9n5AaawIlkUNUcxGzHQNA958N
         izW6f+cNVOVTyfJ2lx0rkkvLsqcPOaKy1QRhXNvFkeAEJLYpod8CSAFqj929UGYQ5MXI
         dYs6wllMzkP3RMDTJCiTkSRVxtd9PHsgPcJ44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=khARqK23fwtNTUnyjPwAAqYVlKWLobeGQnhlx9xy0nU=;
        b=V2y5/+6rxQY5O21e8tlATz35zRcwW4q3qgxe3B96fZbzGRiVLJHm8dDUxUVDphuZBQ
         gycM0LOLT88+Lb+reCOOji9i8CKJDWbIik6DRgfmJmy+aLOg+TeI/iVrsWvJ20Os30yu
         7WMRYfgFdLq7+F8ksEMzkwNm7RJa5ZeckkXy3ZfwJLEx22BUCzi4Z3JHHgrK5mKalNcO
         3Q0BI0YGyU/n4KvMXSMot3yCj9ZKv5UnWS64r2Eh5y+40T0axOSKXXJNv10ewvC0SD6O
         L66EgMrnFFiKY9msp0DN3reDcFznKOI4hJwIRYsIe15oiYcarWaUfQqtoAOh52pN3gHo
         OtEg==
X-Gm-Message-State: APt69E3BTjclszenOFgsNLc0rlO9RIyAoHanjIai8BL7rVb7D/QMwIrb
        JgoKhGb7zx5zLAG0t3ogCjthgg==
X-Google-Smtp-Source: AAOMgpcsxPtAq273vwpoIRJhP4LhP4s4d4OstW7dNCwCJLXAyzo5T48+bNb/TjahjAjB3eFtZppWSA==
X-Received: by 2002:adf:967d:: with SMTP id c58-v6mr19801410wra.197.1530603332871;
        Tue, 03 Jul 2018 00:35:32 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id l17-v6sm730877wrh.45.2018.07.03.00.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:35:32 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:35:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: as3722: disable auto power on when AC OK
Message-ID: <20180703073530.GI20176@dell>
References: <20180625080013.32157-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625080013.32157-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> On ams AS3722, power on when AC OK is enabled by default.
> Making this option as disable by default and enable only
> when platform need this explicitly.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Reviewed-by: Bibek Basu <bbasu@nvidia.com>
> Tested-by: Bibek Basu <bbasu@nvidia.com>
> Downsteam commit 09cd706fecb9 ("mfd: as3722: disable auto power on when
> AC OK").

Please drop this line.

> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/mfd/as3722.c       | 12 ++++++++++++
>  include/linux/mfd/as3722.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index f87342c211bc..215465c97759 100644
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
> +		val = AS3722_CTRL_SEQ1_AC_OK_PWR_ON;
> +	ret = as3722_update_bits(as3722, AS3722_CTRL_SEQU1_REG,
> +			AS3722_CTRL_SEQ1_AC_OK_PWR_ON, val);
> +	if (ret < 0) {
> +		dev_err(as3722->dev, "CTRL_SEQ1 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = devm_mfd_add_devices(&i2c->dev, -1, as3722_devs,
>  				   ARRAY_SIZE(as3722_devs), NULL, 0,
>  				   regmap_irq_get_domain(as3722->irq_data));
> diff --git a/include/linux/mfd/as3722.h b/include/linux/mfd/as3722.h
> index 51e6f9414575..8841b9896033 100644
> --- a/include/linux/mfd/as3722.h
> +++ b/include/linux/mfd/as3722.h
> @@ -296,6 +296,8 @@
>  #define AS3722_ADC1_CONV_NOTREADY			BIT(7)
>  #define AS3722_ADC1_SOURCE_SELECT_MASK			0x1F
>  
> +#define AS3722_CTRL_SEQ1_AC_OK_PWR_ON			BIT(0)
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
