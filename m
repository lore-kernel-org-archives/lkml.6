Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B415C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD8920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPKK5/h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD8920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeKUTR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:17:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38380 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKUTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:17:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so4865547wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nzA+bv179H8Uu/sniTj231eZZoMfDkc3C7SZSH8k/go=;
        b=ZPKK5/h81f0ZlP9gFJnbZdbQc+1lR7jDKQDgJoogD1Gtu/RII37JagTfKvplCpK2JS
         KinotV60Q46NFVJOHq353DXn3sCiAN6aHKGnhY3MtsX7dR1MJXO7Pd8G//aaIeOwt7Q3
         lXkvscL2OI7pj4hXFyTsVFEALOC5SZK7s+lUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzA+bv179H8Uu/sniTj231eZZoMfDkc3C7SZSH8k/go=;
        b=iVPDV+du6RZiGlbrFt9AAhUSJWlWIdMwEny/xQ8o/Dr207vB2UgaY0PsKeSD7obCIK
         mUqJk4RvXdAyP8KlKrsnxe4OdmFzxrOZOBbnlQWyQcY+rkZ586J+qydcb/JLrXOdkUtN
         jDgAS3PCYRX0WfhWYfKqwEyoR59AQw+h7Z1J5nXS0vwc8IvNZSGaODByM3BYvwvQB1HH
         1swqJLqOIWz2JIuJ50LKtKMmP3pfijgKx70vbny25V+7ydG13zB6h6IqO9OpMT385kMT
         DDeqRTUIDOFWLcmMtaZ64R4R9E0CuvbnGsLNG4K+5zT95GNquw+XVLowYOJkalKqgoNW
         eBVA==
X-Gm-Message-State: AGRZ1gK0O5kSpwWDFtnTTb8jnIRmgrt+iEjmGL5/9mGk0LItinyiE78l
        fwmwZX6JWnG4dlM6NLW/wmooyF7VVz0=
X-Google-Smtp-Source: AFSGD/U8iRhcJWBQLtzUp/u1G1dd5eVYed+9AmU7v7ekBbqh00L2M7SMPW2t8A9j6LZDxa63ZbOW4g==
X-Received: by 2002:a1c:7004:: with SMTP id l4-v6mr4583056wmc.93.1542789828087;
        Wed, 21 Nov 2018 00:43:48 -0800 (PST)
Received: from [192.168.0.40] (239.22.136.77.rev.sfr.net. [77.136.22.239])
        by smtp.googlemail.com with ESMTPSA id x77sm569672wme.19.2018.11.21.00.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:43:47 -0800 (PST)
Subject: Re: [PATCH v3] thermal: qoriq: add multiple sensors support
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181030010008.27237-1-andy.tang@nxp.com>
 <VI1PR04MB4333200BCB4E2DABE1DC5B55F3C30@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB433384F335FBE426117B2188F3DA0@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <16bf9114-8403-a11a-0a29-f78bc139b480@linaro.org>
Date:   Wed, 21 Nov 2018 09:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB433384F335FBE426117B2188F3DA0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 02:34, Andy Tang wrote:
> Hi all,
> 
> Do you have any comments on this patch?
> 
> I found for our thermal driver(qoriq_thermal.c) there are different between the following two git trees:
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git 
> branch: next  
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git.
> branch: next
> 
> Could you please clarify which git tree/branch should I use?

SoC changes are submitted against linux-soc-thermal.git.

Generic thermal framework are sent against Zhang Rui's tree but it
happens sometimes Eduardo pick them also when the changes are related to
SoC behavior.

However, I agree that can be confusing :)

Eduardo, Rui,

how about to add a section in the maintainer handbook for the thermal to
clarify the expectations and the flow?

>> -----Original Message-----
>> From: Andy Tang
>> Sent: 2018年11月14日 15:29
>> To: rui.zhang@intel.com; daniel.lezcano@linaro.org
>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: RE: [PATCH v3] thermal: qoriq: add multiple sensors support
>>
>> PING.
>>
>> BR,
>> Andy
>>
>>> -----Original Message-----
>>> From: andy.tang@nxp.com <andy.tang@nxp.com>
>>> Sent: 2018年10月30日 9:00
>>> To: rui.zhang@intel.com; daniel.lezcano@linaro.org
>>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>>> linux-kernel@vger.kernel.org; Andy Tang <andy.tang@nxp.com>
>>> Subject: [PATCH v3] thermal: qoriq: add multiple sensors support
>>>
>>> From: Yuantian Tang <andy.tang@nxp.com>
>>>
>>> The QorIQ Layerscape SoC has several thermal sensors but the current
>>> driver only supports one.
>>>
>>> Massage the code to be sensor oriented and allow the support for
>>> multiple sensors.
>>>
>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>> v3:
>>>   - add Reviewed-by
>>> v2:
>>>   - update the commit message
>>>   - refine the qoriq_tmu_register_tmu_zone()
>>>
>>>  drivers/thermal/qoriq_thermal.c |  100
>>> ++++++++++++++++++---------------------
>>>  1 files changed, 46 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>> b/drivers/thermal/qoriq_thermal.c index 450ed66..8beb344 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -59,14 +59,21 @@ struct qoriq_tmu_regs {
>>>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>>  };
>>>
>>> +struct qoriq_tmu_data;
>>> +
>>>  /*
>>>   * Thermal zone data
>>>   */
>>> +struct qoriq_sensor {
>>> +	struct thermal_zone_device	*tzd;
>>> +	struct qoriq_tmu_data		*qdata;
>>> +	int				id;
>>> +};
>>> +
>>>  struct qoriq_tmu_data {
>>> -	struct thermal_zone_device *tz;
>>>  	struct qoriq_tmu_regs __iomem *regs;
>>> -	int sensor_id;
>>>  	bool little_endian;
>>> +	struct qoriq_sensor	*sensor[SITES_MAX];
>>>  };
>>>
>>>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem
>>> *addr) @@ -87,48 +94,51 @@ static u32 tmu_read(struct
>> qoriq_tmu_data
>>> *p, void __iomem *addr)
>>>
>>>  static int tmu_get_temp(void *p, int *temp)  {
>>> +	struct qoriq_sensor *qsensor = p;
>>> +	struct qoriq_tmu_data *qdata = qsensor->qdata;
>>>  	u32 val;
>>> -	struct qoriq_tmu_data *data = p;
>>>
>>> -	val = tmu_read(data, &data->regs->site[data->sensor_id].tritsr);
>>> +	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
>>>  	*temp = (val & 0xff) * 1000;
>>>
>>>  	return 0;
>>>  }
>>>
>>> -static int qoriq_tmu_get_sensor_id(void)
>>> +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>>> +	.get_temp = tmu_get_temp,
>>> +};
>>> +
>>> +static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>>>  {
>>> -	int ret, id;
>>> -	struct of_phandle_args sensor_specs;
>>> -	struct device_node *np, *sensor_np;
>>> +	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>>> +	int id, sites = 0;
>>>
>>> -	np = of_find_node_by_name(NULL, "thermal-zones");
>>> -	if (!np)
>>> -		return -ENODEV;
>>> +	for (id = 0; id < SITES_MAX; id++) {
>>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>>> +		if (!qdata->sensor[id])
>>> +			return -ENOMEM;
>>>
>>> -	sensor_np = of_get_next_child(np, NULL);
>>> -	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
>>> -			"#thermal-sensor-cells",
>>> -			0, &sensor_specs);
>>> -	if (ret) {
>>> -		of_node_put(np);
>>> -		of_node_put(sensor_np);
>>> -		return ret;
>>> -	}
>>> +		qdata->sensor[id]->id = id;
>>> +		qdata->sensor[id]->qdata = qdata;
>>>
>>> -	if (sensor_specs.args_count >= 1) {
>>> -		id = sensor_specs.args[0];
>>> -		WARN(sensor_specs.args_count > 1,
>>> -				"%s: too many cells in sensor specifier %d\n",
>>> -				sensor_specs.np->name, sensor_specs.args_count);
>>> -	} else {
>>> -		id = 0;
>>> -	}
>>> +		qdata->sensor[id]->tzd =
>>> devm_thermal_zone_of_sensor_register(
>>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>>> +			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
>>> +				continue;
>>> +			else
>>> +				return PTR_ERR(qdata->sensor[id]->tzd);
>>>
>>> -	of_node_put(np);
>>> -	of_node_put(sensor_np);
>>> +		}
>>> +
>>> +		sites |= 0x1 << (15 - id);
>>> +	}
>>> +	/* Enable monitoring */
>>> +	if (sites != 0)
>>> +		tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>>> &qdata->regs->tmr);
>>>
>>> -	return id;
>>> +	return 0;
>>>  }
>>>
>>>  static int qoriq_tmu_calibration(struct platform_device *pdev) @@
>>> -178,16 +188,11 @@ static void qoriq_tmu_init_device(struct
>>> qoriq_tmu_data *data)
>>>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);  }
>>>
>>> -static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>>> -	.get_temp = tmu_get_temp,
>>> -};
>>> -
>>>  static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>>  	int ret;
>>>  	struct qoriq_tmu_data *data;
>>>  	struct device_node *np = pdev->dev.of_node;
>>> -	u32 site;
>>>
>>>  	if (!np) {
>>>  		dev_err(&pdev->dev, "Device OF-Node is NULL"); @@ -203,13
>>> +208,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>>>
>>>  	data->little_endian = of_property_read_bool(np, "little-endian");
>>>
>>> -	data->sensor_id = qoriq_tmu_get_sensor_id();
>>> -	if (data->sensor_id < 0) {
>>> -		dev_err(&pdev->dev, "Failed to get sensor id\n");
>>> -		ret = -ENODEV;
>>> -		goto err_iomap;
>>> -	}
>>> -
>>>  	data->regs = of_iomap(np, 0);
>>>  	if (!data->regs) {
>>>  		dev_err(&pdev->dev, "Failed to get memory region\n"); @@
>>> -223,19 +221,13 @@ static int qoriq_tmu_probe(struct platform_device
>>> *pdev)
>>>  	if (ret < 0)
>>>  		goto err_tmu;
>>>
>>> -	data->tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>> -							data->sensor_id,
>>> -							data, &tmu_tz_ops);
>>> -	if (IS_ERR(data->tz)) {
>>> -		ret = PTR_ERR(data->tz);
>>> -		dev_err(&pdev->dev,
>>> -			"Failed to register thermal zone device %d\n", ret);
>>> -		goto err_tmu;
>>> +	ret = qoriq_tmu_register_tmu_zone(pdev);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "Failed to register sensors\n");
>>> +		ret = -ENODEV;
>>> +		goto err_iomap;
>>>  	}
>>>
>>> -	/* Enable monitoring */
>>> -	site = 0x1 << (15 - data->sensor_id);
>>> -	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
>>>
>>>  	return 0;
>>>
>>> --
>>> 1.7.1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

