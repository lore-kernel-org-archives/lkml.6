Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B75B20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qEsaR7je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B75B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeLMIzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:55:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40908 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:55:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so1102889wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h54WoB3PvoLevlfzcCTG32nZUmvQxFmjfx5dijvUHbs=;
        b=qEsaR7je8eXCPRlABC7BYFFURBNTueU8K+siQk42i8oFvCtaoyZvmNe9S4ma53lKki
         4p6WR0l9FSz1Mt323oDSg4LTaaxVTkjnVb6jenCyn6LedE1rsUhW3etP+eVHvOKt01EQ
         3e5vKUHYRpAnt8LJPr3b3feekKDCh8z8No7aAOhaa5HZR1o8l936yFgfI3wC2FyeCzBB
         5vp+p9z0IPTasWzDKhD8v5HxNE1ciQ04IsbfmBMcx5boquKytG5Sk+LxbOzJYFiAM6/u
         pDYARsyMsKBf8wiHAsmyZmVDpbVRCMQ9NmAcJcXowuTX7dPPu5KN+2ueJwQjeyCLK3Bo
         yPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h54WoB3PvoLevlfzcCTG32nZUmvQxFmjfx5dijvUHbs=;
        b=N+WEONMOtFw4ZTynpjCEw6tMXUnMC9Z6lRMh3Eye9XFJKE3tqPnoyY8QJVtgqC4VIG
         lo6xA/C8fDgrzg26rq1eUp1VE2xWMYgqwj0bFHAsQ+2aSYVz4cQB9v8aNzwQwTWZQYJQ
         Aw/ov+oXSQBLkJDtMXvmLhGxiuq8KULAwc5vUVLQbNtGbrvlEnoTaG4VoHYq5FWxFKPg
         b12NiGGCa3ZfY2qQmnXXdx3guFOIUo058N2cQvz7l3sMbqPvvtJ1o/yz47+C9trmU76C
         S5NA8NXBw1LPnwYyAVMHNnAuF1dgHhQ34K++Y8n6NSquNqQ+j2+7LJyOtgrbS46MXG/I
         nQgQ==
X-Gm-Message-State: AA+aEWY2j/My2OBroT+R3t5CnNz1WbMB0m9U/yMboFb2cUi6FtSsT2F1
        0P/+JApqSlR/f2qQjIdnlWBjZJUILvqhEg==
X-Google-Smtp-Source: AFSGD/Uo1wModIhOoy6vsAwuoUmjWzm7krnLl9jPnNsqNh97/IH7jP+/KMZXHgwphXPJ2/33RqrFPg==
X-Received: by 2002:adf:c108:: with SMTP id r8mr21191920wre.233.1544691312657;
        Thu, 13 Dec 2018 00:55:12 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157? ([2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157])
        by smtp.gmail.com with ESMTPSA id y1sm1323242wme.1.2018.12.13.00.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 00:55:12 -0800 (PST)
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
To:     Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
Date:   Thu, 13 Dec 2018 09:55:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunny,

On 13/12/2018 09:39, Sunny Luo wrote:
> The SPICC controller in Meson-AXG SoC is capable of using
> a linear clock divider to reach a much fine tuned range of clocks,
> while the old controller only use a power of two clock divider,
> result at a more coarse clock range.

This patch should definitely go before patch 1.

> 
> Also convert the clock registration into Common Clock Framework.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/spi/Kconfig           |   2 +-
>  drivers/spi/spi-meson-spicc.c | 209 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 170 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9f89cb1..75f7362 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -384,7 +384,7 @@ config SPI_FSL_ESPI
>  
>  config SPI_MESON_SPICC
>  	tristate "Amlogic Meson SPICC controller"
> -	depends on ARCH_MESON || COMPILE_TEST
> +	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
>  	help
>  	  This enables master mode support for the SPICC (SPI communication
>  	  controller) available in Amlogic Meson SoCs.
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 0384c28..59af18e 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -116,6 +116,9 @@
>  #define SPICC_DWADDR	0x24	/* Write Address of DMA */
>  
>  #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
> +#define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
> +#define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
> +#define SPICC_ENH_DATARATE_EN		BIT(24)
>  #define SPICC_ENH_MOSI_OEN		BIT(25)
>  #define SPICC_ENH_CLK_OEN		BIT(26)
>  #define SPICC_ENH_CS_OEN		BIT(27)
> @@ -131,6 +134,7 @@
>  struct meson_spicc_data {
>  	unsigned int			max_speed_hz;
>  	bool				has_oen;
> +	bool				has_enhance_clk_div;
>  };
>  
>  struct meson_spicc_device {
> @@ -138,6 +142,7 @@ struct meson_spicc_device {
>  	struct platform_device		*pdev;
>  	void __iomem			*base;
>  	struct clk			*core;
> +	struct clk			*clk;
>  	struct spi_message		*message;
>  	struct spi_transfer		*xfer;
>  	const struct meson_spicc_data	*data;
> @@ -325,40 +330,6 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static u32 meson_spicc_setup_speed(struct meson_spicc_device *spicc, u32 conf,
> -				   u32 speed)
> -{
> -	unsigned long parent, value;
> -	unsigned int i, div;
> -
> -	parent = clk_get_rate(spicc->core);
> -
> -	/* Find closest inferior/equal possible speed */
> -	for (i = 0 ; i < 7 ; ++i) {
> -		/* 2^(data_rate+2) */
> -		value = parent >> (i + 2);
> -
> -		if (value <= speed)
> -			break;
> -	}
> -
> -	/* If provided speed it lower than max divider, use max divider */
> -	if (i > 7) {
> -		div = 7;
> -		dev_warn_once(&spicc->pdev->dev, "unable to get close to speed %u\n",
> -			      speed);
> -	} else
> -		div = i;
> -
> -	dev_dbg(&spicc->pdev->dev, "parent %lu, speed %u -> %lu (%u)\n",
> -		parent, speed, value, div);
> -
> -	conf &= ~SPICC_DATARATE_MASK;
> -	conf |= FIELD_PREP(SPICC_DATARATE_MASK, div);
> -
> -	return conf;
> -}
> -
>  static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
>  				   struct spi_transfer *xfer)
>  {
> @@ -367,9 +338,6 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
>  	/* Read original configuration */
>  	conf = conf_orig = readl_relaxed(spicc->base + SPICC_CONREG);
>  
> -	/* Select closest divider */
> -	conf = meson_spicc_setup_speed(spicc, conf, xfer->speed_hz);
> -
>  	/* Setup word width */
>  	conf &= ~SPICC_BITLENGTH_MASK;
>  	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK,
> @@ -378,6 +346,8 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
>  	/* Ignore if unchanged */
>  	if (conf != conf_orig)
>  		writel_relaxed(conf, spicc->base + SPICC_CONREG);
> +
> +	clk_set_rate(spicc->clk, xfer->speed_hz);
>  }
>  
>  static int meson_spicc_transfer_one(struct spi_master *master,
> @@ -486,9 +456,6 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
>  	/* Disable all IRQs */
>  	writel(0, spicc->base + SPICC_INTREG);
>  
> -	/* Disable controller */
> -	writel_bits_relaxed(SPICC_ENABLE, 0, spicc->base + SPICC_CONREG);
> -
>  	device_reset_optional(&spicc->pdev->dev);
>  
>  	return 0;
> @@ -528,6 +495,157 @@ static void meson_spicc_cleanup(struct spi_device *spi)
>  	spi->controller_state = NULL;
>  }
>  
> +/*
> + * The Clock Mux
> + *            x-----------------x   x------------x    x------\
> + *        |---| 0) fixed factor |---| 1) old div |----|      |
> + *        |   x-----------------x   x------------x    |      |
> + * src ---|                                           |5) mux|-- out
> + *        |   x-----------------x   x------------x    |      |
> + *        |---| 2) fixed factor |---| 3) new div |0---|      |
> + *            x-----------------x   x------------x    x------/
> + *
> + * Clk path for GX series:
> + *    src -> 0 -> 1 -> out
> + *
> + * Clk path for AXG series:
> + *    src -> 0 -> 1 -> 5 -> out
> + *    src -> 2 -> 3 -> 5 -> out
> + */
> +
> +/* algorithm for div0 + div1: rate = freq / 4 / (2 ^ N) */
> +static struct clk_fixed_factor meson_spicc_div0 = {
> +	.mult	= 1,
> +	.div	= 4,
> +};
> +
> +static struct clk_divider meson_spicc_div1 = {
> +	.reg	= (void *)SPICC_CONREG,
> +	.shift	= 16,
> +	.width	= 3,
> +	.flags	= CLK_DIVIDER_POWER_OF_TWO,
> +};
> +
> +/* algorithm for div2 + div3: rate = freq / 2 / (N + 1) */
> +static struct clk_fixed_factor meson_spicc_div2 = {
> +	.mult	= 1,
> +	.div	= 2,
> +};
> +
> +static struct clk_divider meson_spicc_div3 = {
> +	.reg	= (void *)SPICC_ENH_CTL0,
> +	.shift	= 16,
> +	.width	= 8,
> +};
> +
> +static struct clk_mux meson_spicc_sel = {
> +	.reg	= (void *)SPICC_ENH_CTL0,
> +	.mask	= 0x1,
> +	.shift	= 24,
> +};
> +
> +static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
> +{
> +	struct device *dev = &spicc->pdev->dev;
> +	struct clk_fixed_factor *div0;
> +	struct clk_divider *div1;
> +	struct clk_mux *mux;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	const char *parent_names[1];
> +	const char *mux_parent_names[2];
> +	char name[32];
> +
> +	div0 = &meson_spicc_div0;
> +	snprintf(name, sizeof(name), "%s#_div0", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_fixed_factor_ops;
> +	init.flags = 0;
> +	parent_names[0] = __clk_get_name(spicc->core);
> +	init.parent_names = parent_names;
> +	init.num_parents = 1;
> +
> +	div0->hw.init = &init;
> +
> +	clk = devm_clk_register(dev, &div0->hw);
> +	if (WARN_ON(IS_ERR(clk)))
> +		return PTR_ERR(clk);
> +
> +	div1 = &meson_spicc_div1;
> +	snprintf(name, sizeof(name), "%s#_div1", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_divider_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	parent_names[0] = __clk_get_name(clk);
> +	init.parent_names = parent_names;
> +	init.num_parents = 1;
> +
> +	div1->reg = spicc->base + (u64)div1->reg;
> +	div1->hw.init = &init;
> +
> +	clk = devm_clk_register(dev, &div1->hw);
> +	if (WARN_ON(IS_ERR(clk)))
> +		return PTR_ERR(clk);
> +
> +	if (!spicc->data->has_enhance_clk_div) {
> +		spicc->clk = clk;
> +		return 0;
> +	}
> +
> +	mux_parent_names[0] = __clk_get_name(clk);
> +
> +	div0 = &meson_spicc_div2;
> +	snprintf(name, sizeof(name), "%s#_div2", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_fixed_factor_ops;
> +	init.flags = 0;
> +	parent_names[0] = __clk_get_name(spicc->core);
> +	init.parent_names = parent_names;
> +	init.num_parents = 1;
> +
> +	div0->hw.init = &init;
> +
> +	clk = devm_clk_register(dev, &div0->hw);
> +	if (WARN_ON(IS_ERR(clk)))
> +		return PTR_ERR(clk);
> +
> +	div1 = &meson_spicc_div3;
> +	snprintf(name, sizeof(name), "%s#_div3", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_divider_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	parent_names[0] = __clk_get_name(clk);
> +	init.parent_names = parent_names;
> +	init.num_parents = 1;
> +
> +	div1->reg = spicc->base + (u64)div1->reg;
> +	div1->hw.init = &init;
> +
> +	clk = devm_clk_register(dev, &div1->hw);
> +	if (WARN_ON(IS_ERR(clk)))
> +		return PTR_ERR(clk);
> +
> +	mux_parent_names[1] = __clk_get_name(clk);
> +
> +	mux = &meson_spicc_sel;
> +	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_mux_ops;
> +	init.parent_names = mux_parent_names;
> +	init.num_parents = 2;
> +	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
> +
> +	mux->reg = spicc->base + (u64)mux->reg;
> +	mux->hw.init = &init;
> +
> +	spicc->clk = devm_clk_register(dev, &mux->hw);
> +	if (WARN_ON(IS_ERR(spicc->clk)))
> +		return PTR_ERR(spicc->clk);
> +
> +	clk_set_parent(spicc->clk, clk);
> +	return 0;
> +}

I'll let Jerome review this !

> +
>  static int meson_spicc_probe(struct platform_device *pdev)
>  {
>  	struct spi_master *master;
> @@ -557,6 +675,10 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  		goto out_master;
>  	}
>  
> +	/* Set master mode and enable controller */
> +	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
> +		       spicc->base + SPICC_CONREG);

Please remove it from meson_spicc_prepare_message() now.

> +
>  	/* Disable all IRQs */
>  	writel_relaxed(0, spicc->base + SPICC_INTREG);
>  
> @@ -603,6 +725,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	master->max_speed_hz = min_t(unsigned int, rate >> 1,
>  				     spicc->data->max_speed_hz);
>  
> +	ret = meson_spicc_clk_init(spicc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clock registration failed\n");
> +		goto out_master;
> +	}
> +
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret) {
>  		dev_err(&pdev->dev, "spi master registration failed\n");
> @@ -639,6 +767,7 @@ static const struct meson_spicc_data meson_spicc_gx_data = {
>  static const struct meson_spicc_data meson_spicc_axg_data = {
>  	.max_speed_hz		= 80000000,
>  	.has_oen		= true,
> +	.has_enhance_clk_div	= true,
>  };
>  
>  static const struct of_device_id meson_spicc_of_match[] = {
> 

