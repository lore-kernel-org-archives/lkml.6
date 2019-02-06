Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E8C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A34217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8WU5ZJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfBFAxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:53:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33391 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFAxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:53:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2192766pgu.0;
        Tue, 05 Feb 2019 16:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xprkqdRaqmi3kWJXLytQa/TDOOKc9AS87ujUPnh+CAI=;
        b=m8WU5ZJ15QT7KzG6rOqXVjWyj6UZ40aggF6HiwmBg5qIjHAPkN0fl2VjZEGNdhFMMg
         GEmx+vM6M9jlXMqpvpbJDckj6lFBIcWw6UnTmaxVYycLnEXRXMybgirtJNlSoQTk4Ca1
         hgAeNdN4w8Xz/xp3SfqhX4J/7ZNSAlURlWYT0AP4fsE8N7dcoznOMCsKJdUp2bGRaKJp
         u7B5dJUdyMspQ5BSnT6HKdAlVDbYCscemQ+48aQgve9j885xYrLvJ2Pj1L6lywcDRHhZ
         nkh4pu0/h4cohftu0v6bEXT6V3DTIcXsJa9AMmL1FkYZDGhP2mXNWlRnhSRKjcK+8oE2
         084g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xprkqdRaqmi3kWJXLytQa/TDOOKc9AS87ujUPnh+CAI=;
        b=CHWzNNfGlcUFwl4QIpQKr6jkUuypU7AEKAlvj0s7V8U4KoHgQ+onEAAN1PoSCkEC2l
         wyue0Xzgd93ta/admVSItz7r0Up0PGkzCph0SKGrDbymoExR1IYOZFeb2n3FpyvsyvFq
         JyF4MI6MTnfuDnwgEfB1FrlLzXvIKz2OI5Q2sUgYkrlFo/klUr6lph8VKEnNkvY4C0QJ
         RAdEenoo6tLz/fHO9J/diyrKgPiJBfilK4anXOsyh8Q0DrjhW3dju9p5aaO/9ErA09/+
         RsByKz8IprxjDKqEu2DLQ9Vi+E70/zTHVXsurFN71p0kFK3vZua8LuB4Fl9Ru8zJozhz
         DVmw==
X-Gm-Message-State: AHQUAuafn4m7Z56a8yGtrn6t3Wsc7x/yfloFxXWHAImTnEQkcsY9/npI
        bL5tIrM8T6i4yHXH9pcwDBo=
X-Google-Smtp-Source: AHgI3IagaiB28kfXas58FRjrIQFbuolGAX2QgdVqNIsNoOlc/wAaPYCTAY4bgSWKHjatSY0GnELYug==
X-Received: by 2002:a63:da18:: with SMTP id c24mr7097580pgh.318.1549414391360;
        Tue, 05 Feb 2019 16:53:11 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id y72sm123455pfa.98.2019.02.05.16.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 16:53:10 -0800 (PST)
Date:   Tue, 5 Feb 2019 16:53:03 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     michael.kao@mediatek.com
Cc:     =Zhang Rui <rui.zhang@intel.com>,
        =Daniel Lezcano <daniel.lezcano@linaro.org>,
        =Rob Herring <robh+dt@kernel.org>,
        =Mark Rutland <mark.rutland@arm.com>,
        =Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH 4/7] thermal: mediatek: add thermal controller offset
Message-ID: <20190206005300.GD19687@localhost.localdomain>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
 <1549006693-11659-5-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549006693-11659-5-git-send-email-michael.kao@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:38:10PM +0800, michael.kao@mediatek.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> One thermal controller can read four sensors at most,
> so we need to add controller_offset for the project with
> more than four sensors to reuse the same register settings.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 79 +++++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 45c6587..e5cf3f4 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -105,6 +105,9 @@
>  /* The number of sensing points per bank */
>  #define MT8173_NUM_SENSORS_PER_ZONE	4
>  
> +/* The number of controller in the MT8173 */
> +#define MT8173_NUM_CONTROLLER		1
> +
>  /* The calibration coefficient of sensor  */
>  #define MT8173_CALIBRATION	165
>  
> @@ -150,6 +153,9 @@ enum {
>  /* The number of sensing points per bank */
>  #define MT2701_NUM_SENSORS_PER_ZONE	3
>  
> +/* The number of controller in the MT2701 */
> +#define MT2701_NUM_CONTROLLER		1
> +
>  /* The calibration coefficient of sensor  */
>  #define MT2701_CALIBRATION	165
>  
> @@ -168,6 +174,9 @@ enum {
>  /* The number of sensing points per bank */
>  #define MT2712_NUM_SENSORS_PER_ZONE	4
>  
> +/* The number of controller in the MT2712 */
> +#define MT2712_NUM_CONTROLLER		1
> +
>  /* The calibration coefficient of sensor  */
>  #define MT2712_CALIBRATION	165
>  
> @@ -176,6 +185,7 @@ enum {
>  #define MT7622_NUM_ZONES		1
>  #define MT7622_NUM_SENSORS_PER_ZONE	1
>  #define MT7622_TS1	0
> +#define MT7622_NUM_CONTROLLER		1
>  
>  /* The calibration coefficient of sensor  */
>  #define MT7622_CALIBRATION	165
> @@ -201,6 +211,8 @@ struct mtk_thermal_data {
>  	const int *msr;
>  	const int *adcpnp;
>  	const int cali_val;
> +	const int num_controller;
> +	const int *controller_offset;
>  	struct thermal_bank_cfg bank_data[];
>  };
>  
> @@ -240,6 +252,7 @@ struct mtk_thermal {
>  };
>  
>  static const int mt8173_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
> +static const int mt8173_tc_offset[MT8173_NUM_CONTROLLER] = { 0x0, };
>  
>  static const int mt8173_vts_index[MT8173_NUM_SENSORS] = {
>  	VTS1, VTS2, VTS3, VTS4, VTSABB
> @@ -259,6 +272,7 @@ struct mtk_thermal {
>  };
>  
>  static const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1, 16 };
> +static const int mt2701_tc_offset[MT2701_NUM_CONTROLLER] = { 0x0, };
>  
>  static const int mt2701_vts_index[MT2701_NUM_SENSORS] = {
>  	VTS1, VTS2, VTS3
> @@ -278,6 +292,7 @@ struct mtk_thermal {
>  };
>  
>  static const int mt2712_mux_values[MT2712_NUM_SENSORS] = { 0, 1, 2, 3 };
> +static const int mt2712_tc_offset[MT2712_NUM_CONTROLLER] = { 0x0, };
>  
>  static const int mt2712_vts_index[MT2712_NUM_SENSORS] = {
>  	VTS1, VTS2, VTS3, VTS4
> @@ -289,6 +304,7 @@ struct mtk_thermal {
>  static const int mt7622_adcpnp[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
>  static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
>  static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
> +static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
>  
>  /**
>   * The MT8173 thermal controller has four banks. Each bank can read up to
> @@ -309,6 +325,8 @@ struct mtk_thermal {
>  	.num_sensors = MT8173_NUM_SENSORS,
>  	.vts_index = mt8173_vts_index,
>  	.cali_val = MT8173_CALIBRATION,
> +	.num_controller = MT8173_NUM_CONTROLLER,
> +	.controller_offset = mt8173_tc_offset,
>  	.bank_data = {
>  		{
>  			.num_sensors = 2,
> @@ -345,6 +363,8 @@ struct mtk_thermal {
>  	.num_sensors = MT2701_NUM_SENSORS,
>  	.vts_index = mt2701_vts_index,
>  	.cali_val = MT2701_CALIBRATION,
> +	.num_controller = MT2701_NUM_CONTROLLER,
> +	.controller_offset = mt2701_tc_offset,
>  	.bank_data = {
>  		{
>  			.num_sensors = 3,
> @@ -372,6 +392,8 @@ struct mtk_thermal {
>  	.num_sensors = MT2712_NUM_SENSORS,
>  	.vts_index = mt2712_vts_index,
>  	.cali_val = MT2712_CALIBRATION,
> +	.num_controller = MT2712_NUM_CONTROLLER,
> +	.controller_offset = mt2712_tc_offset,
>  	.bank_data = {
>  		{
>  			.num_sensors = 4,
> @@ -393,6 +415,8 @@ struct mtk_thermal {
>  	.num_sensors = MT7622_NUM_SENSORS,
>  	.vts_index = mt7622_vts_index,
>  	.cali_val = MT7622_CALIBRATION,
> +	.num_controller = MT7622_NUM_CONTROLLER,
> +	.controller_offset = mt7622_tc_offset,
>  	.bank_data = {
>  		{
>  			.num_sensors = 1,
> @@ -523,19 +547,23 @@ static int mtk_read_temp(void *data, int *temperature)
>  };
>  
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> -				  u32 apmixed_phys_base, u32 auxadc_phys_base)
> +				  u32 apmixed_phys_base, u32 auxadc_phys_base,
> +				  int ctrl_id)
>  {
>  	struct mtk_thermal_bank *bank = &mt->banks[num];
>  	const struct mtk_thermal_data *conf = mt->conf;
>  	int i;
>  
> +	int offset = mt->conf->controller_offset[ctrl_id];
> +	void *controller_base = mt->thermal_base + offset;

This void * has to be at least __iomem, right?

See the report of kbuild bot, fix it and send it back.

> +
>  	bank->id = num;
>  	bank->mt = mt;
>  
>  	mtk_thermal_get_bank(bank);
>  
>  	/* bus clock 66M counting unit is 12 * 15.15ns * 256 = 46.540us */
> -	writel(TEMP_MONCTL1_PERIOD_UNIT(12), mt->thermal_base + TEMP_MONCTL1);
> +	writel(TEMP_MONCTL1_PERIOD_UNIT(12), controller_base + TEMP_MONCTL1);
>  
>  	/*
>  	 * filt interval is 1 * 46.540us = 46.54us,
> @@ -543,21 +571,21 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  	 */
>  	writel(TEMP_MONCTL2_FILTER_INTERVAL(1) |
>  			TEMP_MONCTL2_SENSOR_INTERVAL(429),
> -			mt->thermal_base + TEMP_MONCTL2);
> +			controller_base + TEMP_MONCTL2);
>  
>  	/* poll is set to 10u */
>  	writel(TEMP_AHBPOLL_ADC_POLL_INTERVAL(768),
> -	       mt->thermal_base + TEMP_AHBPOLL);
> +	       controller_base + TEMP_AHBPOLL);
>  
>  	/* temperature sampling control, 1 sample */
> -	writel(0x0, mt->thermal_base + TEMP_MSRCTL0);
> +	writel(0x0, controller_base + TEMP_MSRCTL0);
>  
>  	/* exceed this polling time, IRQ would be inserted */
> -	writel(0xffffffff, mt->thermal_base + TEMP_AHBTO);
> +	writel(0xffffffff, controller_base + TEMP_AHBTO);
>  
>  	/* number of interrupts per event, 1 is enough */
> -	writel(0x0, mt->thermal_base + TEMP_MONIDET0);
> -	writel(0x0, mt->thermal_base + TEMP_MONIDET1);
> +	writel(0x0, controller_base + TEMP_MONIDET0);
> +	writel(0x0, controller_base + TEMP_MONIDET1);
>  
>  	/*
>  	 * The MT8173 thermal controller does not have its own ADC. Instead it
> @@ -572,44 +600,44 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  	 * this value will be stored to TEMP_PNPMUXADDR (TEMP_SPARE0)
>  	 * automatically by hw
>  	 */
> -	writel(BIT(conf->auxadc_channel), mt->thermal_base + TEMP_ADCMUX);
> +	writel(BIT(conf->auxadc_channel), controller_base + TEMP_ADCMUX);
>  
>  	/* AHB address for auxadc mux selection */
>  	writel(auxadc_phys_base + AUXADC_CON1_CLR_V,
> -	       mt->thermal_base + TEMP_ADCMUXADDR);
> +	       controller_base + TEMP_ADCMUXADDR);
>  
>  	/* AHB address for pnp sensor mux selection */
>  	writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
> -	       mt->thermal_base + TEMP_PNPMUXADDR);
> +	       controller_base + TEMP_PNPMUXADDR);
>  
>  	/* AHB value for auxadc enable */
> -	writel(BIT(conf->auxadc_channel), mt->thermal_base + TEMP_ADCEN);
> +	writel(BIT(conf->auxadc_channel), controller_base + TEMP_ADCEN);
>  
>  	/* AHB address for auxadc enable (channel 0 immediate mode selected) */
>  	writel(auxadc_phys_base + AUXADC_CON1_SET_V,
> -	       mt->thermal_base + TEMP_ADCENADDR);
> +	       controller_base + TEMP_ADCENADDR);
>  
>  	/* AHB address for auxadc valid bit */
>  	writel(auxadc_phys_base + AUXADC_DATA(conf->auxadc_channel),
> -	       mt->thermal_base + TEMP_ADCVALIDADDR);
> +	       controller_base + TEMP_ADCVALIDADDR);
>  
>  	/* AHB address for auxadc voltage output */
>  	writel(auxadc_phys_base + AUXADC_DATA(conf->auxadc_channel),
> -	       mt->thermal_base + TEMP_ADCVOLTADDR);
> +	       controller_base + TEMP_ADCVOLTADDR);
>  
>  	/* read valid & voltage are at the same register */
> -	writel(0x0, mt->thermal_base + TEMP_RDCTRL);
> +	writel(0x0, controller_base + TEMP_RDCTRL);
>  
>  	/* indicate where the valid bit is */
>  	writel(TEMP_ADCVALIDMASK_VALID_HIGH | TEMP_ADCVALIDMASK_VALID_POS(12),
> -	       mt->thermal_base + TEMP_ADCVALIDMASK);
> +	       controller_base + TEMP_ADCVALIDMASK);
>  
>  	/* no shift */
> -	writel(0x0, mt->thermal_base + TEMP_ADCVOLTAGESHIFT);
> +	writel(0x0, controller_base + TEMP_ADCVOLTAGESHIFT);
>  
>  	/* enable auxadc mux write transaction */
>  	writel(TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
> -	       mt->thermal_base + TEMP_ADCWRITECTRL);
> +		controller_base + TEMP_ADCWRITECTRL);
>  
>  	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
>  		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
> @@ -617,11 +645,11 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
>  
>  	writel((1 << conf->bank_data[num].num_sensors) - 1,
> -	       mt->thermal_base + TEMP_MONCTL0);
> +	       controller_base + TEMP_MONCTL0);
>  
>  	writel(TEMP_ADCWRITECTRL_ADC_PNP_WRITE |
>  	       TEMP_ADCWRITECTRL_ADC_MUX_WRITE,
> -	       mt->thermal_base + TEMP_ADCWRITECTRL);
> +	       controller_base + TEMP_ADCWRITECTRL);
>  
>  	mtk_thermal_put_bank(bank);
>  }
> @@ -737,7 +765,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>  
>  static int mtk_thermal_probe(struct platform_device *pdev)
>  {
> -	int ret, i;
> +	int ret, i, ctrl_id;
>  	struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
>  	struct mtk_thermal *mt;
>  	struct resource *res;
> @@ -817,9 +845,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_clk_auxadc;
>  	}
>  
> -	for (i = 0; i < mt->conf->num_banks; i++)
> -		mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> -				      auxadc_phys_base);
> +	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
> +		for (i = 0; i < mt->conf->num_banks; i++)
> +			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> +					      auxadc_phys_base, ctrl_id);
>  
>  	platform_set_drvdata(pdev, mt);
>  
> -- 
> 1.9.1
> 
