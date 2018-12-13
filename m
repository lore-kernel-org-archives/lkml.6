Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F70E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hxmomjhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F70E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeLMJ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:28:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35294 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:28:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so1610841wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mjwD57QnChG25xZu1S6Cb1iNpy1YrgTMJzgNi1FGZt0=;
        b=HxmomjhsJm3Ia1ob2/UF1q8tYZV1XW6g9vCqcCOa6/GLGxyWuqgM9qEFz52Jsv3zId
         R5kRJIbN+0J0gOQPN1IWpFuZZHyirD43wpUU+eUk+zG8NGPVrYs2p/7LlraF+q+fngyU
         piY2Iw4dhGzW5pVEXlDwwron4Bf3bL3Cz+g803CaoIBADyn8kOz/3ZyMG1JMnN80VQqF
         OnsIZBWtiTYtBjXLU0Wu3gttZmsUDkYu9trul1l4YxIPscLqQTgSQIIUgx9mMcwwuoqB
         VVj66XmKT2wk5fhiPSUxw0+gON0g9KopoN3/4qoxFBJVCQNwCJomAhrbaAg0tm+yDBDk
         d7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mjwD57QnChG25xZu1S6Cb1iNpy1YrgTMJzgNi1FGZt0=;
        b=iLtk2tWAQxG4kuBRMVuu2Wvn1vClSMo9DJECXbb47dHPtlVW3uAZDtI/1AAgGN4rSC
         fpMhns33q/UsIn9h+eS0eAnShCch+kgZKq9uGD8UI1g18gs7h2RK7TjY+EhkxN6eiyRq
         2+XGC9j8mfOoX5eyGI8J0bUdQj0zqeIl687hRKkOhjCoWAiZjBzaEHWfsJRLhzOXX7Ff
         i51UcCYp6v1zD38fsp+9w7rARrJgJVHbYmDOS3x/y5M+U2XZmSllBToakp0+yltH2qt2
         0zyPBCHMJxQNKN4IPSm9wMZut7wpy0RCup1uezLQUQN3gS5c7YhTPIDXgBboGqegLcjp
         qlyA==
X-Gm-Message-State: AA+aEWZknkebJrDPbUocoMZioXQ337kng/QcBziauaO7WK2/XKgntnyN
        FiEgGCAoSIWHyWoRXDdXN5Rzlg==
X-Google-Smtp-Source: AFSGD/UnWHI0pitoFlg08V4gQ4REItrSD9397wveEwb61rJkDVmwpy/k8jmzkMfQ5bQs/czZIwwpfg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr9113077wmc.5.1544693313513;
        Thu, 13 Dec 2018 01:28:33 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id f187sm1106297wma.4.2018.12.13.01.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:28:32 -0800 (PST)
Message-ID: <e6d5220e45a54d5251bec0f8fd3c147307f8b071.camel@baylibre.com>
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider
 support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Sunny Luo <sunny.luo@amlogic.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Dec 2018 10:28:30 +0100
In-Reply-To: <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
         <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
         <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 09:55 +0100, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
> > The SPICC controller in Meson-AXG SoC is capable of using
> > a linear clock divider to reach a much fine tuned range of clocks,
> > while the old controller only use a power of two clock divider,
> > result at a more coarse clock range.
> 
> This patch should definitely go before patch 1.
> 
> > Also convert the clock registration into Common Clock Framework.
> > 
> > Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >  drivers/spi/Kconfig           |   2 +-
> >  drivers/spi/spi-meson-spicc.c | 209 ++++++++++++++++++++++++++++++++++---
> > -----
> >  2 files changed, 170 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 9f89cb1..75f7362 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -384,7 +384,7 @@ config SPI_FSL_ESPI
> >  
> >  config SPI_MESON_SPICC
> >  	tristate "Amlogic Meson SPICC controller"
> > -	depends on ARCH_MESON || COMPILE_TEST
> > +	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)

The purpose of this patch is clock, right ? Why does it add a dependency on OF
?

> >  	help
> >  	  This enables master mode support for the SPICC (SPI communication
> >  	  controller) available in Amlogic Meson SoCs.
> > diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> > index 0384c28..59af18e 100644
> > --- a/drivers/spi/spi-meson-spicc.c
> > +++ b/drivers/spi/spi-meson-spicc.c
> > @@ -116,6 +116,9 @@
> >  #define SPICC_DWADDR	0x24	/* Write Address of DMA */
> >  
> >  #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
> > +#define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
> > +#define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
> > +#define SPICC_ENH_DATARATE_EN		BIT(24)
> >  #define SPICC_ENH_MOSI_OEN		BIT(25)
> >  #define SPICC_ENH_CLK_OEN		BIT(26)
> >  #define SPICC_ENH_CS_OEN		BIT(27)
> > @@ -131,6 +134,7 @@
> >  struct meson_spicc_data {
> >  	unsigned int			max_speed_hz;
> >  	bool				has_oen;
> > +	bool				has_enhance_clk_div;
> >  };
> >  
> >  struct meson_spicc_device {
> > @@ -138,6 +142,7 @@ struct meson_spicc_device {
> >  	struct platform_device		*pdev;
> >  	void __iomem			*base;
> >  	struct clk			*core;
> > +	struct clk			*clk;
> >  	struct spi_message		*message;
> >  	struct spi_transfer		*xfer;
> >  	const struct meson_spicc_data	*data;
> > @@ -325,40 +330,6 @@ static irqreturn_t meson_spicc_irq(int irq, void
> > *data)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static u32 meson_spicc_setup_speed(struct meson_spicc_device *spicc, u32
> > conf,
> > -				   u32 speed)
> > -{
> > -	unsigned long parent, value;
> > -	unsigned int i, div;
> > -
> > -	parent = clk_get_rate(spicc->core);
> > -
> > -	/* Find closest inferior/equal possible speed */
> > -	for (i = 0 ; i < 7 ; ++i) {
> > -		/* 2^(data_rate+2) */
> > -		value = parent >> (i + 2);
> > -
> > -		if (value <= speed)
> > -			break;
> > -	}
> > -
> > -	/* If provided speed it lower than max divider, use max divider */
> > -	if (i > 7) {
> > -		div = 7;
> > -		dev_warn_once(&spicc->pdev->dev, "unable to get close to speed
> > %u\n",
> > -			      speed);
> > -	} else
> > -		div = i;
> > -
> > -	dev_dbg(&spicc->pdev->dev, "parent %lu, speed %u -> %lu (%u)\n",
> > -		parent, speed, value, div);
> > -
> > -	conf &= ~SPICC_DATARATE_MASK;
> > -	conf |= FIELD_PREP(SPICC_DATARATE_MASK, div);
> > -
> > -	return conf;
> > -}
> > -
> >  static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
> >  				   struct spi_transfer *xfer)
> >  {
> > @@ -367,9 +338,6 @@ static void meson_spicc_setup_xfer(struct
> > meson_spicc_device *spicc,
> >  	/* Read original configuration */
> >  	conf = conf_orig = readl_relaxed(spicc->base + SPICC_CONREG);
> >  
> > -	/* Select closest divider */
> > -	conf = meson_spicc_setup_speed(spicc, conf, xfer->speed_hz);
> > -
> >  	/* Setup word width */
> >  	conf &= ~SPICC_BITLENGTH_MASK;
> >  	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK,
> > @@ -378,6 +346,8 @@ static void meson_spicc_setup_xfer(struct
> > meson_spicc_device *spicc,
> >  	/* Ignore if unchanged */
> >  	if (conf != conf_orig)
> >  		writel_relaxed(conf, spicc->base + SPICC_CONREG);
> > +
> > +	clk_set_rate(spicc->clk, xfer->speed_hz);
> >  }
> >  
> >  static int meson_spicc_transfer_one(struct spi_master *master,
> > @@ -486,9 +456,6 @@ static int meson_spicc_unprepare_transfer(struct
> > spi_master *master)
> >  	/* Disable all IRQs */
> >  	writel(0, spicc->base + SPICC_INTREG);
> >  
> > -	/* Disable controller */
> > -	writel_bits_relaxed(SPICC_ENABLE, 0, spicc->base + SPICC_CONREG);
> > -
> >  	device_reset_optional(&spicc->pdev->dev);
> >  
> >  	return 0;
> > @@ -528,6 +495,157 @@ static void meson_spicc_cleanup(struct spi_device
> > *spi)
> >  	spi->controller_state = NULL;
> >  }
> >  
> > +/*
> > + * The Clock Mux
> > + *            x-----------------x   x------------x    x------\
> > + *        |---| 0) fixed factor |---| 1) old div |----|      |
> > + *        |   x-----------------x   x------------x    |      |
> > + * src ---|                                           |5) mux|-- out
> > + *        |   x-----------------x   x------------x    |      |
> > + *        |---| 2) fixed factor |---| 3) new div |0---|      |
> > + *            x-----------------x   x------------x    x------/
> > + *
> > + * Clk path for GX series:
> > + *    src -> 0 -> 1 -> out
> > + *
> > + * Clk path for AXG series:
> > + *    src -> 0 -> 1 -> 5 -> out
> > + *    src -> 2 -> 3 -> 5 -> out
> > + */
> > +
> > +/* algorithm for div0 + div1: rate = freq / 4 / (2 ^ N) */
> > +static struct clk_fixed_factor meson_spicc_div0 = {
> > +	.mult	= 1,
> > +	.div	= 4,
> > +};
> > +
> > +static struct clk_divider meson_spicc_div1 = {
> > +	.reg	= (void *)SPICC_CONREG,
> > +	.shift	= 16,
> > +	.width	= 3,
> > +	.flags	= CLK_DIVIDER_POWER_OF_TWO,
> > +};
> > +
> > +/* algorithm for div2 + div3: rate = freq / 2 / (N + 1) */
> > +static struct clk_fixed_factor meson_spicc_div2 = {
> > +	.mult	= 1,
> > +	.div	= 2,
> > +};
> > +
> > +static struct clk_divider meson_spicc_div3 = {
> > +	.reg	= (void *)SPICC_ENH_CTL0,
> > +	.shift	= 16,
> > +	.width	= 8,
> > +};
> > +
> > +static struct clk_mux meson_spicc_sel = {
> > +	.reg	= (void *)SPICC_ENH_CTL0,
> > +	.mask	= 0x1,
> > +	.shift	= 24,
> > +};
> > +
> > +static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
> > +{
> > +	struct device *dev = &spicc->pdev->dev;
> > +	struct clk_fixed_factor *div0;
> > +	struct clk_divider *div1;

Could you come up with something better than div0 and div1 ? it is confusing,
especially with the comment above about div3 and 4 ... fixed_factor, div maybe
?

> > +	struct clk_mux *mux;
> > +	struct clk_init_data init;
> > +	struct clk *clk;
> > +	const char *parent_names[1];
> > +	const char *mux_parent_names[2];
> > +	char name[32];
> > +
> > +	div0 = &meson_spicc_div0;
> > +	snprintf(name, sizeof(name), "%s#_div0", dev_name(dev));
> > +	init.name = name;
> > +	init.ops = &clk_fixed_factor_ops;
> > +	init.flags = 0;
> > +	parent_names[0] = __clk_get_name(spicc->core);
> > +	init.parent_names = parent_names;
> > +	init.num_parents = 1;
> > +
> > +	div0->hw.init = &init;
> > +
> > +	clk = devm_clk_register(dev, &div0->hw);
> > +	if (WARN_ON(IS_ERR(clk)))
> > +		return PTR_ERR(clk);
> > +
> > +	div1 = &meson_spicc_div1;
> > +	snprintf(name, sizeof(name), "%s#_div1", dev_name(dev));
> > +	init.name = name;
> > +	init.ops = &clk_divider_ops;
> > +	init.flags = CLK_SET_RATE_PARENT;
> > +	parent_names[0] = __clk_get_name(clk);
> > +	init.parent_names = parent_names;
> > +	init.num_parents = 1;
> > +
> > +	div1->reg = spicc->base + (u64)div1->reg;

So you have static data which you override here. This works only if there is a
single instance ... and does not really improve readability in your case.

IMO, you'd be better off without the static data above.

> > +	div1->hw.init = &init;
> > +
> > +	clk = devm_clk_register(dev, &div1->hw);
> > +	if (WARN_ON(IS_ERR(clk)))
> > +		return PTR_ERR(clk);
> > +
> > +	if (!spicc->data->has_enhance_clk_div) {

Do all SoC with 'has_oen' have 'has_enhance_clk_div' too ?
DO you really need two flags ?

> > +		spicc->clk = clk;
> > +		return 0;
> > +	}
> > +
> > +	mux_parent_names[0] = __clk_get_name(clk);
> > +
> > +	div0 = &meson_spicc_div2;
> > +	snprintf(name, sizeof(name), "%s#_div2", dev_name(dev));
> > +	init.name = name;
> > +	init.ops = &clk_fixed_factor_ops;
> > +	init.flags = 0;
> > +	parent_names[0] = __clk_get_name(spicc->core);
> > +	init.parent_names = parent_names;
> > +	init.num_parents = 1;
> > +
> > +	div0->hw.init = &init;
> > +
> > +	clk = devm_clk_register(dev, &div0->hw);
> > +	if (WARN_ON(IS_ERR(clk)))
> > +		return PTR_ERR(clk);
> > +
> > +	div1 = &meson_spicc_div3;
> > +	snprintf(name, sizeof(name), "%s#_div3", dev_name(dev));
> > +	init.name = name;
> > +	init.ops = &clk_divider_ops;
> > +	init.flags = CLK_SET_RATE_PARENT;
> > +	parent_names[0] = __clk_get_name(clk);
> > +	init.parent_names = parent_names;
> > +	init.num_parents = 1;
> > +
> > +	div1->reg = spicc->base + (u64)div1->reg;
> > +	div1->hw.init = &init;
> > +
> > +	clk = devm_clk_register(dev, &div1->hw);
> > +	if (WARN_ON(IS_ERR(clk)))
> > +		return PTR_ERR(clk);
> > +
> > +	mux_parent_names[1] = __clk_get_name(clk);
> > +
> > +	mux = &meson_spicc_sel;
> > +	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
> > +	init.name = name;
> > +	init.ops = &clk_mux_ops;
> > +	init.parent_names = mux_parent_names;
> > +	init.num_parents = 2;
> > +	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;

Why CLK_SET_RATE_NO_REPARENT ? CCF should pick the parent that give the best
results, best to let it do its task ...

> > +
> > +	mux->reg = spicc->base + (u64)mux->reg;
> > +	mux->hw.init = &init;
> > +
> > +	spicc->clk = devm_clk_register(dev, &mux->hw);
> > +	if (WARN_ON(IS_ERR(spicc->clk)))
> > +		return PTR_ERR(spicc->clk);
> > +
> > +	clk_set_parent(spicc->clk, clk);

... then you can drop this.

> > +	return 0;
> > +}
> 
> I'll let Jerome review this !
> 
> > +
> >  static int meson_spicc_probe(struct platform_device *pdev)
> >  {
> >  	struct spi_master *master;
> > @@ -557,6 +675,10 @@ static int meson_spicc_probe(struct platform_device
> > *pdev)
> >  		goto out_master;
> >  	}
> >  
> > +	/* Set master mode and enable controller */
> > +	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
> > +		       spicc->base + SPICC_CONREG);
> 
> Please remove it from meson_spicc_prepare_message() now.
> 
> > +
> >  	/* Disable all IRQs */
> >  	writel_relaxed(0, spicc->base + SPICC_INTREG);
> >  
> > @@ -603,6 +725,12 @@ static int meson_spicc_probe(struct platform_device
> > *pdev)
> >  	master->max_speed_hz = min_t(unsigned int, rate >> 1,
> >  				     spicc->data->max_speed_hz);
> >  
> > +	ret = meson_spicc_clk_init(spicc);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "clock registration failed\n");
> > +		goto out_master;
> > +	}
> > +
> >  	ret = devm_spi_register_master(&pdev->dev, master);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "spi master registration failed\n");
> > @@ -639,6 +767,7 @@ static const struct meson_spicc_data
> > meson_spicc_gx_data = {
> >  static const struct meson_spicc_data meson_spicc_axg_data = {
> >  	.max_speed_hz		= 80000000,
> >  	.has_oen		= true,
> > +	.has_enhance_clk_div	= true,
> >  };
> >  
> >  static const struct of_device_id meson_spicc_of_match[] = {
> > 


