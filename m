Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whw1yjr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfBUA5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:57:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43631 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:57:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id m10so3524723plt.10;
        Wed, 20 Feb 2019 16:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W5NYWAaYm1siPuBKDVETRxJ6Iyy/SS/8yv3pakY4JVM=;
        b=Whw1yjr/7gvdd3YlBkZb9wEUL99/oUV5mCWcZYifD/1FXOjynfIWOFpQgSraxvIBxY
         jrZ97MJJgO4EuQpvQncdoHHE2J+EUbqUfS8OrjO5haI3X7vm1WyV4q4uNGBG6VKrT0SI
         Ig345hdU9gWNU7Ruv0g/9suMdwgdpiFYVLD+b4NwdJ8dqOgIbSdYd4kyHTElSGgQSFAx
         zijfGi+ec8DDa8jmvqP86SMTpunQCd0OGlRQsGPBQFCz1ftPu10rvL8IbyZhJMv6XEie
         s0rWEmVZpQ7XdWpNnrj4vqK4ooxj2M5J0jgY+lKy0E+sC4k/21Of8gPbZv5u/oPPYKmD
         QeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5NYWAaYm1siPuBKDVETRxJ6Iyy/SS/8yv3pakY4JVM=;
        b=bfexukqQmdM08uITrp2UJYzIToEk13svBSfJuoXojylex7GujivFV+dUkg/HDhffAq
         mvYUXDGEyIO150yE0rHs14z2XXEl32V4PGv4t5wZrb3M0KJjJduM3uHyYFoVXAfKs7kD
         h3qbyZR5BjuAW+bBnKQXjPzgeaSgiTrFh1yoKbmi5zJ5LqU+DG8BuxPeEfF6xkJEBtro
         Wjob8unAH9a63c2F5C8dS/XlytOS34odUUzUDB8DKiLxs81YtiaFWdR2pTPoZ+p3bDSC
         8meKmdXCLP/kznz1efP2CDpOf2KX2YSglM41MXCeVPJqSLEjpKDaVNm5OQoAduMyvQgh
         TmlQ==
X-Gm-Message-State: AHQUAuZWZn9guB+Udni6z6qso0lE/UAb9LawGZ4DyFzsMpTcQMrrtIYl
        ltOSpu8ywtCqjSf+QRu4dv8=
X-Google-Smtp-Source: AHgI3IZ6o4m++0FM6HEsPAn5JpjgP3PDOadvrFYsMGk+XU4hXXQWbGmPhysFO1w2BbnBoFkPNvLdVw==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr38862111plh.99.1550710642092;
        Wed, 20 Feb 2019 16:57:22 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id e63sm37886625pfc.47.2019.02.20.16.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:57:21 -0800 (PST)
Date:   Wed, 20 Feb 2019 16:57:19 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] thermal: qoriq: Add support for multiple thremal
 sites
Message-ID: <20190221005717.GC31479@localhost.localdomain>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
 <20190218191141.3729-13-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218191141.3729-13-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:11:41AM -0800, Andrey Smirnov wrote:
> TMU IP block provides temerature measurement for up to 16 sites,
> current implementation of the driver however hardcodes a single site
> ID. Change the code so it would be possible to reference multiple
> sites as indivudial sensors and get their temperature readings.

small typo: indivudial/individual.

> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/thermal/qoriq_thermal.c | 132 ++++++++++++++++++++------------
>  1 file changed, 84 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index f746c62789b0..6cc6e6b36fb0 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -24,6 +24,8 @@
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
>  #define TMR_ALPF	0x0c000000
> +#define TMR_ALPF_MASK	GENMASK(27, 26)
> +
>  
>  #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
>  #define TMTMIR_DEFAULT	0x0000000f
> @@ -41,21 +43,32 @@
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> +struct qoriq_tmu_sensor {
> +	struct thermal_zone_device *tz;
> +	int id;
> +};
> +
>  /*
>   * Thermal zone data
>   */
>  struct qoriq_tmu_data {
>  	struct thermal_zone_device *tz;
>  	struct regmap *regmap;
> -	int sensor_id;
> +	struct qoriq_tmu_sensor sensors[SITES_MAX];
>  };
>  
> +static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_tmu_sensor *s)
> +{
> +	return container_of(s, struct qoriq_tmu_data, sensors[s->id]);
> +}
> +
>  static int tmu_get_temp(void *p, int *temp)
>  {
>  	u32 val;
> -	struct qoriq_tmu_data *data = p;
> +	struct qoriq_tmu_sensor *s = p;
> +	struct qoriq_tmu_data *data = qoriq_sensor_to_data(s);
>  
> -	regmap_read(data->regmap, REGS_TRITSR(data->sensor_id), &val);
> +	regmap_read(data->regmap, REGS_TRITSR(s->id), &val);
>  	if (!(val & TRITSR_V))
>  		return -ENODATA;
>  
> @@ -63,38 +76,86 @@ static int tmu_get_temp(void *p, int *temp)
>  	return 0;
>  }
>  
> -static int qoriq_tmu_get_sensor_id(void)
> +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> +	.get_temp = tmu_get_temp,
> +};
> +
> +static int qoriq_tmu_populate_sensors(struct device *dev,
> +				      struct qoriq_tmu_data *data)
>  {
> -	int ret, id;
> +	int ret, id, i, count = 0;
>  	struct of_phandle_args sensor_specs;
>  	struct device_node *np, *sensor_np;
> +	struct qoriq_tmu_sensor *s;
>  
>  	np = of_find_node_by_name(NULL, "thermal-zones");
>  	if (!np)
>  		return -ENODEV;
>  
> -	sensor_np = of_get_next_child(np, NULL);
> -	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> -			"#thermal-sensor-cells",
> -			0, &sensor_specs);
> -	if (ret) {
> -		id = ret;
> -		goto out;
> +	for_each_child_of_node(np, sensor_np) {
> +		u16 msite;
> +
> +		ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +						 "#thermal-sensor-cells",
> +						 0, &sensor_specs);
> +		if (ret)
> +			break;
> +
> +		if (sensor_specs.args_count != 1) {
> +			pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
> +			       sensor_specs.np, sensor_specs.args_count);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		id = sensor_specs.args[0];
> +		if (id >= SITES_MAX) {
> +			ret = -EINVAL;
> +			dev_err(dev, "Sensor id %d is out of range\n", id);
> +			break;
> +		}
> +
> +		msite = BIT(15 - id);
> +		/* Enable monitoring of that particular sensor*/
> +		regmap_update_bits(data->regmap, REGS_TMR, msite, msite);
> +
> +		s = &data->sensors[id];
> +		s->id = id;
> +		count++;

Not sure I follow why you need to bother about thermal-sensor-cells..

>  	}
>  
> -	if (sensor_specs.args_count != 1) {
> -		pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
> -		       sensor_specs.np, sensor_specs.args_count);
> -		id = -EINVAL;
> -		goto out;
> +	of_node_put(np);
> +	if (ret) {
> +		/* We only need to "put" sensor_np if we exited the
> +		 * loop early with "break"
> +		 */
> +		of_node_put(sensor_np);
> +		return ret;
>  	}
>  
> -	id = sensor_specs.args[0];
> -out:
> -	of_node_put(np);
> -	of_node_put(sensor_np);
> +	/* Enable monitoring */
> +	regmap_update_bits(data->regmap, REGS_TMR, TMR_ME | TMR_ALPF_MASK,
> +			   TMR_ME | TMR_ALPF);
> +
> +	for (i = 0; i < count; i++) {
> +		s = &data->sensors[i];
> +		s->tz = devm_thermal_zone_of_sensor_register(dev, s->id, s,
> +							     &tmu_tz_ops);
> +		if (IS_ERR(s->tz)) {
> +			ret = PTR_ERR(s->tz);
> +			dev_err(dev,
> +				"Failed to register thermal zone device %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		ret = devm_thermal_add_hwmon_sysfs(s->tz);
> +		if (ret)
> +			break;
> +
> +	}
>  
> -	return id;
> +	return ret;
>  }
>  
>  static int qoriq_tmu_calibration(struct device *dev,
> @@ -142,10 +203,6 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>  }
>  
> -static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> -	.get_temp = tmu_get_temp,
> -};
> -
>  static const struct regmap_range qiriq_wr_yes_ranges[] = {
>  	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
>  	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
> @@ -187,19 +244,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  		.max_register		= SZ_4K,
>  	};
>  	void __iomem *base;
> -	u32 site;
>  
>  	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->sensor_id = qoriq_tmu_get_sensor_id();
> -	if (data->sensor_id < 0) {
> -		dev_err(dev, "Failed to get sensor id\n");
> -		return -ENODEV;
> -	}
> -
>  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!io) {
>  		dev_err(dev, "Failed to get memory region\n");
> @@ -225,21 +275,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Enable monitoring */
> -	site = 0x1 << (15 - data->sensor_id);
> -	regmap_write(data->regmap, REGS_TMR, site | TMR_ME | TMR_ALPF);
> -
> -	data->tz = devm_thermal_zone_of_sensor_register(dev,
> -							data->sensor_id,
> -							data, &tmu_tz_ops);
> -	if (IS_ERR(data->tz)) {
> -		ret = PTR_ERR(data->tz);
> -		dev_err(dev, "Failed to register thermal zone device %d\n",
> -			ret);
> -		goto disable_monitoring;
> -	}
> -
> -	ret = devm_thermal_add_hwmon_sysfs(data->tz);
> +	ret = qoriq_tmu_populate_sensors(dev, data);
>  	if (ret)
>  		goto disable_monitoring;
>  
> -- 
> 2.20.1
> 
