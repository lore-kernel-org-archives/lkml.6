Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240FEC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2A72077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6mYxekC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2A72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeJNEVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:21:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41393 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeJNEVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:21:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so16911013wru.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j12gbL6WE2ADQrM85DVHeVOnU4/vgFnY327egk28zls=;
        b=G6mYxekCxLwwMwE7jXussjQf51XUcPYP7K0nQhCFEWmVF5LDE8RDAc1013nxj1jFWC
         qMuS4WrRUMDbiQczGlmqMvKh1cMCwo4dixs4vmzInLFO4P5gsCiru3XHltyiGXn9Tr6u
         o25d6QWzBK0tUJw/qeOqEt2dhFKf9p+cbuUu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j12gbL6WE2ADQrM85DVHeVOnU4/vgFnY327egk28zls=;
        b=VqNTFCcYOvO1OKdkPEpraZIJIyijMmYM7p1NMmdiHd40bUnmn6ZBdh13WqfTZsRIJS
         ic4eVMb8KyDFnAKGcgt5XWYsF8AV4Km84390kKRsGCdjlV/ONQ2p4j2uJ+EqDhxTnOCu
         boQAuldCN3pcsb/dNabonOSFKtfs33dUTG3qGzwa1SYlHY05SCzxxlen7xdP3BgApEOQ
         6q0MmgXTfLSQhgq/mB7mqnViZ3cpgBTprGEMsI6UNBMPvsVrLGH6kFbnLQlbB8YLXzZY
         15DLyBa7HbvMavwIZ9AAbxSbTUpXFteBKHn0FiKtSXOTgR0UnSWyrgpjQTqlX9CEd2C8
         NuKQ==
X-Gm-Message-State: ABuFfojImhQ6PxDAf1e42D6h2yDQbnSG5lNYqLGTqovvbv3PXvC7F4rt
        HVLk+fZJmKHCt+zbOopT0hTkpBhPxEQ=
X-Google-Smtp-Source: ACcGV61qrrBJIrmEMIISWN6ziAlqjypRKiOz7g6LaeSujKiAUFUjzGm0GnG+KDg/VIl6TQpSsQ0uzw==
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr8963177wri.139.1539463359620;
        Sat, 13 Oct 2018 13:42:39 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 77-v6sm7905584wmv.6.2018.10.13.13.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 13:42:38 -0700 (PDT)
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
To:     andy.tang@nxp.com, rui.zhang@intel.com
Cc:     edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180927024204.17314-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
Date:   Sat, 13 Oct 2018 22:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927024204.17314-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yuantian,


On 27/09/2018 04:42, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> There is only one sensor supported in current driver.
> Multiple sensors are existing on Layscape socs. To support them,
> covert this driver to support multiple sensors.

s/covert/convert/

What about the following changelog ?

"
The QorIQ Layerscape SoC has several thermal sensors but the current
driver only supports one.

Massage the code to be sensor oriented and allow the support for
multiple sensors.
"

> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c |  117 +++++++++++++++++++++++----------------
>  1 files changed, 70 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index c866cc1..7c1e88a 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -69,14 +69,21 @@ struct qoriq_tmu_regs {
>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>  };
>  
> +struct qoriq_tmu_data;
> +
>  /*
>   * Thermal zone data
>   */
> +struct qoriq_sensor {
> +	struct thermal_zone_device	*tzd;
> +	struct qoriq_tmu_data		*qdata;
> +	int				id;
> +};

Can you move the qoriq_tmu_site_regs structure content inside the
qoriq_sensor structure and kill the 'sites' field in the qoriq_tmu_regs
structure ? Otherwise we end up with a SITES_MAX array in the
qoriq_tmu_data structure and another one in the qoriq_tmu_regs structure.

>  struct qoriq_tmu_data {
> -	struct thermal_zone_device *tz;
>  	struct qoriq_tmu_regs __iomem *regs;
> -	int sensor_id;
>  	bool little_endian;
> +	struct qoriq_sensor	*sensor[SITES_MAX];
>  };
>  
>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
> @@ -97,48 +104,83 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
>  
>  static int tmu_get_temp(void *p, int *temp)
>  {
> +	struct qoriq_sensor *qsensor = p;
> +	struct qoriq_tmu_data *qdata = qsensor->qdata;
>  	u32 val;
> -	struct qoriq_tmu_data *data = p;
>  
> -	val = tmu_read(data, &data->regs->site[data->sensor_id].tritsr);
> +	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
>  	*temp = (val & 0xff) * 1000;
>  
>  	return 0;
>  }
>  
> -static int qoriq_tmu_get_sensor_id(void)
> +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> +	.get_temp = tmu_get_temp,
> +};
> +
> +static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  {
> -	int ret, id;
> +	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>  	struct of_phandle_args sensor_specs;
>  	struct device_node *np, *sensor_np;
> +	int ret, id, sites = 0;
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
> +	for_each_available_child_of_node(np, sensor_np) {
> +		ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +				"#thermal-sensor-cells",
> +				0, &sensor_specs);
> +		if (ret) {
> +			of_node_put(np);
> +			of_node_put(sensor_np);
> +			return ret;
> +		}
> +
> +		if (sensor_specs.args_count >= 1) {
> +			id = sensor_specs.args[0];
> +			WARN(sensor_specs.args_count > 1,
> +					"%s: too many cells in sensor specifier %d\n",
> +					sensor_specs.np->name,
> +					sensor_specs.args_count);
> +		} else {
> +			id = 0;
> +		}
> +
>  		of_node_put(np);
>  		of_node_put(sensor_np);
> -		return ret;
> -	}
>  
> -	if (sensor_specs.args_count >= 1) {
> -		id = sensor_specs.args[0];
> -		WARN(sensor_specs.args_count > 1,
> -				"%s: too many cells in sensor specifier %d\n",
> -				sensor_specs.np->name, sensor_specs.args_count);
> -	} else {
> -		id = 0;
> +		if (id > SITES_MAX)
> +			return -EINVAL;
> +
> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
> +		if (!qdata->sensor[id])
> +			return -ENOMEM;
> +
> +		qdata->sensor[id]->id = id;
> +		qdata->sensor[id]->qdata = qdata;
> +
> +		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
> +
> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
> +			ret = PTR_ERR(qdata->sensor[id]->tzd);
> +			dev_err(&pdev->dev,
> +				"Failed to register thermal zone device.\n");
> +			return -ENODEV;
> +		}
> +
> +		sites |= 0x1 << (15 - id);

The current code is reading the DT in order to get the sensor id and
initialize it. IOW, the DT gives the sensors to use.

IMO, it would be more self contained if the driver initializes all the
sensors without taking care of the DT and let the of- code to do the
binding when the thermal zone, no ?

>  	}
>  
> -	of_node_put(np);
> -	of_node_put(sensor_np);
> +	/* Enable monitoring */
> +	if (sites != 0)
> +		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
>  
> -	return id;
> +	return 0;
>  }
>  
>  static int qoriq_tmu_calibration(struct platform_device *pdev)
> @@ -188,16 +230,11 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>  }
>  
> -static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> -	.get_temp = tmu_get_temp,
> -};
> -
>  static int qoriq_tmu_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
> -	u32 site = 0;
>  
>  	if (!np) {
>  		dev_err(&pdev->dev, "Device OF-Node is NULL");
> @@ -213,13 +250,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	data->little_endian = of_property_read_bool(np, "little-endian");
>  
> -	data->sensor_id = qoriq_tmu_get_sensor_id();
> -	if (data->sensor_id < 0) {
> -		dev_err(&pdev->dev, "Failed to get sensor id\n");
> -		ret = -ENODEV;
> -		goto err_iomap;
> -	}
> -
>  	data->regs = of_iomap(np, 0);
>  	if (!data->regs) {
>  		dev_err(&pdev->dev, "Failed to get memory region\n");
> @@ -233,18 +263,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_tmu;
>  
> -	data->tz = thermal_zone_of_sensor_register(&pdev->dev, data->sensor_id,
> -				data, &tmu_tz_ops);
> -	if (IS_ERR(data->tz)) {
> -		ret = PTR_ERR(data->tz);
> -		dev_err(&pdev->dev,
> -			"Failed to register thermal zone device %d\n", ret);
> -		goto err_tmu;
> +	ret = qoriq_tmu_register_tmu_zone(pdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register sensors\n");
> +		ret = -ENODEV;
> +		goto err_iomap;
>  	}
>  
> -	/* Enable monitoring */
> -	site |= 0x1 << (15 - data->sensor_id);
> -	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
>  
>  	return 0;
>  
> @@ -261,8 +286,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
>  {
>  	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
>  
> -	thermal_zone_of_sensor_unregister(&pdev->dev, data->tz);
> -
>  	/* Disable monitoring */
>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

