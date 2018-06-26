Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF74C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750CE25090
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Gde6x2bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750CE25090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeFZIEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:04:51 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54204 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeFZIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:04:43 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B6FC45C015F;
        Tue, 26 Jun 2018 10:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530000281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B73mcBAp8rkfHCkK9qPM7vDCuOQnoQ+bFm3aVC/Ub7k=;
        b=Gde6x2bf+YfSTI1uam6VjN8YNJzU6wp5YrN7bYEiLHSkXNOFJGa6G2tw8fBJ0qvpG6khqv
        FOsKt0m5F3lUvRVHNBFUwpH72zigIMa5H8F3CBKC9PZ7KNOieqx7pcwJ3p0rksjthhRnBz
        S++EY1MxWhYo2Fs0FfVD4ThGwj/5xfc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jun 2018 10:04:41 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH] mfd: as3722: disable auto power on when AC OK
In-Reply-To: <20180625080013.32157-1-marcel@ziswiler.com>
References: <20180625080013.32157-1-marcel@ziswiler.com>
Message-ID: <9502dfa3fae42471ddedf05499876177@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-1.60 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2018 10:00, Marcel Ziswiler wrote:
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
> 
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

This property should be added to
Documentation/devicetree/bindings/mfd/as3722.txt.

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

Nit: Use SEQU1 instead of SEQ1 since that is how the register is named.

--
Stefan

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
