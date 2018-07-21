Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D56EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A2420856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5mk7SkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A2420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeGUPdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:33:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43260 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbeGUPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:33:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so6390481plk.10;
        Sat, 21 Jul 2018 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pFtN89tgkk00wt37Gp7qqssLgeknSIpScR5xvOP/JjM=;
        b=V5mk7SkLBLcLbhL5wAoqxzcgoJNQ2rKV38QdMOFSicUZH2Td67gHDetp4rSdt/PdhG
         8EVYUY+VR/jc4u5rnAc6euxKBBm8DujS0JYluErpVJrFTvx+4dmG5zTFlgukSjpGeX9X
         kzEvfC6vuvNtoDJbaBV//DwVmeiPe+Z7LEM2xHiH78sEGT+eWMHu5zjZwblzYmZh5f9o
         wzFUpsfpKjoiYgMNhobsFBY7/Kkr6MOsDwp+2ZR7ZskKGhvTBwRRssxhA3JMUSnFHw3B
         cqEgBHiEdHDzBXjr58txxz6KITtdq/mYW+WfPnEmcMmvdKPu1Ep03rkG5j6iAglnGngO
         4llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pFtN89tgkk00wt37Gp7qqssLgeknSIpScR5xvOP/JjM=;
        b=m5df+eZkqKDOeSFLI53wW52qwBFeJy6BPAywEt4IWbe7xuU79f+udsqOAgxubRufaD
         fYD3beizOX7iYclD42EEVnHjAD/7dEouOqPAdH4kmgdGn7G6aufMFH1lkZGvZmGrrojE
         paWIuU6Cu8Nat6NbBlDx9ZfxI8vurJ9aUmBtK+9Xz0z9EWPLB0dT2OkkIiefmm4dMpXG
         mOHvbQqASG6OuOmCNd8dCsndM+2fHksvQinnqQD/INJBEAcCUWmK54WnxQ2NF8uzSS+E
         i/nxCT12zzNtSW35Wr0P0iHQLBYPrgBbPRuoo6hlqYcTZMKsx/AvVhd3R/ZILl/NolA6
         qX0w==
X-Gm-Message-State: AOUpUlGSy0n8g+UCHDbr5ph7u1mbBtbT2U1XgqM4dbonEw5LFF/zp96k
        pG/6PFcMbSqhJr7srqhwdIY=
X-Google-Smtp-Source: AAOMgper8MqXirJqimeQCbJXKbqxR+jHn1A059c0bKNE6De+2mf5c5fNDw3gxbtj4tQY3cIFTdxiHg==
X-Received: by 2002:a17:902:7c89:: with SMTP id y9-v6mr6050508pll.187.1532184019852;
        Sat, 21 Jul 2018 07:40:19 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e2-v6sm7275929pfb.62.2018.07.21.07.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 07:40:19 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
        stewart@linux.ibm.com
References: <1532067143-22022-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1532067143-22022-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <83b7b5ed-dc84-c10b-984e-488b7fa71368@roeck-us.net>
Date:   Sat, 21 Jul 2018 07:40:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532067143-22022-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 11:12 PM, Shilpasri G Bhat wrote:
> OPAL firmware provides the facility for some groups of sensors to be
> enabled/disabled at runtime to give the user the option of using the
> system resources for collecting these sensors or not.
> 
> For example, on POWER9 systems, the On Chip Controller (OCC) gathers
> various system and chip level sensors and maintains their values in
> main memory.
> 
> This patch provides support for enabling/disabling the sensor groups
> like power, temperature, current and voltage.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> [stewart@linux.vnet.ibm.com: Commit message]

Acked-by: Guenter Roeck <linux@roeck-us.net>

Given the dependency on patch 1, I assume this will be pushed through
a powerpc tree.

Guenter

> ---
> Changes from v6:
> - Updated the commit message as per Stewart's suggestion
> - Use the compatible DT property instead of the path to find the node
> 
>   Documentation/hwmon/ibmpowernv |  43 ++++++-
>   drivers/hwmon/ibmpowernv.c     | 249 +++++++++++++++++++++++++++++++++++------
>   2 files changed, 258 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
> index 8826ba2..5646825 100644
> --- a/Documentation/hwmon/ibmpowernv
> +++ b/Documentation/hwmon/ibmpowernv
> @@ -33,9 +33,48 @@ fanX_input		Measured RPM value.
>   fanX_min		Threshold RPM for alert generation.
>   fanX_fault		0: No fail condition
>   			1: Failing fan
> +
>   tempX_input		Measured ambient temperature.
>   tempX_max		Threshold ambient temperature for alert generation.
> -inX_input		Measured power supply voltage
> +tempX_highest		Historical maximum temperature
> +tempX_lowest		Historical minimum temperature
> +tempX_enable		Enable/disable all temperature sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its temperature sensors.
> +			1: Enable
> +			0: Disable
> +
> +inX_input		Measured power supply voltage (millivolt)
>   inX_fault		0: No fail condition.
>   			1: Failing power supply.
> -power1_input		System power consumption (microWatt)
> +inX_highest		Historical maximum voltage
> +inX_lowest		Historical minimum voltage
> +inX_enable		Enable/disable all voltage sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its voltage sensors.
> +			1: Enable
> +			0: Disable
> +
> +powerX_input		Power consumption (microWatt)
> +powerX_input_highest	Historical maximum power
> +powerX_input_lowest	Historical minimum power
> +powerX_enable		Enable/disable all power sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its power sensors.
> +			1: Enable
> +			0: Disable
> +
> +currX_input		Measured current (milliampere)
> +currX_highest		Historical maximum current
> +currX_lowest		Historical minimum current
> +currX_enable		Enable/disable all current sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its current sensors.
> +			1: Enable
> +			0: Disable
> +
> +energyX_input		Cumulative energy (microJoule)
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index f829dad..99afbf7 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -90,11 +90,20 @@ struct sensor_data {
>   	char label[MAX_LABEL_LEN];
>   	char name[MAX_ATTR_LEN];
>   	struct device_attribute dev_attr;
> +	struct sensor_group_data *sgrp_data;
> +};
> +
> +struct sensor_group_data {
> +	struct mutex mutex;
> +	u32 gid;
> +	bool enable;
>   };
>   
>   struct platform_data {
>   	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
> +	struct sensor_group_data *sgrp_data;
>   	u32 sensors_count; /* Total count of sensors from each group */
> +	u32 nr_sensor_groups; /* Total number of sensor groups */
>   };
>   
>   static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
> @@ -105,6 +114,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	ssize_t ret;
>   	u64 x;
>   
> +	if (sdata->sgrp_data && !sdata->sgrp_data->enable)
> +		return -ENODATA;
> +
>   	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>   
>   	if (ret)
> @@ -120,6 +132,46 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	return sprintf(buf, "%llu\n", x);
>   }
>   
> +static ssize_t show_enable(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +
> +	return sprintf(buf, "%u\n", sdata->sgrp_data->enable);
> +}
> +
> +static ssize_t store_enable(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +	struct sensor_group_data *sgrp_data = sdata->sgrp_data;
> +	bool data;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &data);
> +	if (ret)
> +		return ret;
> +
> +	ret = mutex_lock_interruptible(&sgrp_data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	if (data != sgrp_data->enable) {
> +		ret =  sensor_group_enable(sgrp_data->gid, data);
> +		if (!ret)
> +			sgrp_data->enable = data;
> +	}
> +
> +	if (!ret)
> +		ret = count;
> +
> +	mutex_unlock(&sgrp_data->mutex);
> +	return ret;
> +}
> +
>   static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>   			  char *buf)
>   {
> @@ -292,12 +344,126 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
>   	return ++sensor_groups[sdata->type].hwmon_index;
>   }
>   
> +static int init_sensor_group_data(struct platform_device *pdev,
> +				  struct platform_data *pdata)
> +{
> +	struct sensor_group_data *sgrp_data;
> +	struct device_node *groups, *sgrp;
> +	enum sensors type;
> +	int count = 0, ret = 0;
> +
> +	groups = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
> +	if (!groups)
> +		return ret;
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		type = get_sensor_type(sgrp);
> +		if (type != MAX_SENSOR_TYPE)
> +			pdata->nr_sensor_groups++;
> +	}
> +
> +	if (!pdata->nr_sensor_groups)
> +		goto out;
> +
> +	sgrp_data = devm_kcalloc(&pdev->dev, pdata->nr_sensor_groups,
> +				 sizeof(*sgrp_data), GFP_KERNEL);
> +	if (!sgrp_data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		const __be32 *phandles;
> +		int len, gid;
> +
> +		type = get_sensor_type(sgrp);
> +		if (type == MAX_SENSOR_TYPE)
> +			continue;
> +
> +		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
> +			continue;
> +
> +		phandles = of_get_property(sgrp, "sensors", &len);
> +		if (!phandles)
> +			continue;
> +
> +		len /= sizeof(u32);
> +		if (!len)
> +			continue;
> +
> +		sensor_groups[type].attr_count++;
> +		sgrp_data[count].gid = gid;
> +		mutex_init(&sgrp_data[count].mutex);
> +		sgrp_data[count++].enable = false;
> +	}
> +
> +	pdata->sgrp_data = sgrp_data;
> +out:
> +	of_node_put(groups);
> +	return ret;
> +}
> +
> +static struct sensor_group_data *get_sensor_group(struct platform_data *pdata,
> +						  struct device_node *node,
> +						  enum sensors gtype)
> +{
> +	struct sensor_group_data *sgrp_data = pdata->sgrp_data;
> +	struct device_node *groups, *sgrp;
> +
> +	groups = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
> +	if (!groups)
> +		return NULL;
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		const __be32 *phandles;
> +		int len, gid, i;
> +		enum sensors type;
> +
> +		type = get_sensor_type(sgrp);
> +		if (type != gtype)
> +			continue;
> +
> +		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
> +			continue;
> +
> +		phandles = of_get_property(sgrp, "sensors", &len);
> +		if (!phandles)
> +			continue;
> +
> +		len /= sizeof(u32);
> +		if (!len)
> +			continue;
> +
> +		while (--len >= 0)
> +			if (be32_to_cpu(phandles[len]) == node->phandle)
> +				break;
> +
> +		if (len < 0)
> +			continue;
> +
> +		for (i = 0; i < pdata->nr_sensor_groups; i++)
> +			if (gid == sgrp_data[i].gid) {
> +				of_node_put(sgrp);
> +				of_node_put(groups);
> +				return &sgrp_data[i];
> +			}
> +	}
> +
> +	of_node_put(groups);
> +	return NULL;
> +}
> +
>   static int populate_attr_groups(struct platform_device *pdev)
>   {
>   	struct platform_data *pdata = platform_get_drvdata(pdev);
>   	const struct attribute_group **pgroups = pdata->attr_groups;
>   	struct device_node *opal, *np;
>   	enum sensors type;
> +	int ret;
> +
> +	ret = init_sensor_group_data(pdev, pdata);
> +	if (ret)
> +		return ret;
>   
>   	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	for_each_child_of_node(opal, np) {
> @@ -344,7 +510,10 @@ static int populate_attr_groups(struct platform_device *pdev)
>   static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>   			      ssize_t (*show)(struct device *dev,
>   					      struct device_attribute *attr,
> -					      char *buf))
> +					      char *buf),
> +			    ssize_t (*store)(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count))
>   {
>   	snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
>   		 sensor_groups[sdata->type].name, sdata->hwmon_index,
> @@ -352,23 +521,33 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>   
>   	sysfs_attr_init(&sdata->dev_attr.attr);
>   	sdata->dev_attr.attr.name = sdata->name;
> -	sdata->dev_attr.attr.mode = S_IRUGO;
>   	sdata->dev_attr.show = show;
> +	if (store) {
> +		sdata->dev_attr.store = store;
> +		sdata->dev_attr.attr.mode = 0664;
> +	} else {
> +		sdata->dev_attr.attr.mode = 0444;
> +	}
>   }
>   
>   static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
>   			    const char *attr_name, enum sensors type,
>   			    const struct attribute_group *pgroup,
> +			    struct sensor_group_data *sgrp_data,
>   			    ssize_t (*show)(struct device *dev,
>   					    struct device_attribute *attr,
> -					    char *buf))
> +					    char *buf),
> +			    ssize_t (*store)(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count))
>   {
>   	sdata->id = sid;
>   	sdata->type = type;
>   	sdata->opal_index = od;
>   	sdata->hwmon_index = hd;
> -	create_hwmon_attr(sdata, attr_name, show);
> +	create_hwmon_attr(sdata, attr_name, show, store);
>   	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
> +	sdata->sgrp_data = sgrp_data;
>   }
>   
>   static char *get_max_attr(enum sensors type)
> @@ -403,24 +582,23 @@ static int create_device_attrs(struct platform_device *pdev)
>   	const struct attribute_group **pgroups = pdata->attr_groups;
>   	struct device_node *opal, *np;
>   	struct sensor_data *sdata;
> -	u32 sensor_id;
> -	enum sensors type;
>   	u32 count = 0;
> -	int err = 0;
> +	u32 group_attr_id[MAX_SENSOR_TYPE] = {0};
>   
> -	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	sdata = devm_kcalloc(&pdev->dev,
>   			     pdata->sensors_count, sizeof(*sdata),
>   			     GFP_KERNEL);
> -	if (!sdata) {
> -		err = -ENOMEM;
> -		goto exit_put_node;
> -	}
> +	if (!sdata)
> +		return -ENOMEM;
>   
> +	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	for_each_child_of_node(opal, np) {
> +		struct sensor_group_data *sgrp_data;
>   		const char *attr_name;
> -		u32 opal_index;
> +		u32 opal_index, hw_id;
> +		u32 sensor_id;
>   		const char *label;
> +		enum sensors type;
>   
>   		if (np->name == NULL)
>   			continue;
> @@ -456,14 +634,12 @@ static int create_device_attrs(struct platform_device *pdev)
>   			opal_index = INVALID_INDEX;
>   		}
>   
> -		sdata[count].opal_index = opal_index;
> -		sdata[count].hwmon_index =
> -			get_sensor_hwmon_index(&sdata[count], sdata, count);
> -
> -		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
> -
> -		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> -				&sdata[count++].dev_attr.attr;
> +		hw_id = get_sensor_hwmon_index(&sdata[count], sdata, count);
> +		sgrp_data = get_sensor_group(pdata, np, type);
> +		populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
> +				attr_name, type, pgroups[type], sgrp_data,
> +				show_sensor, NULL);
> +		count++;
>   
>   		if (!of_property_read_string(np, "label", &label)) {
>   			/*
> @@ -474,35 +650,43 @@ static int create_device_attrs(struct platform_device *pdev)
>   			 */
>   
>   			make_sensor_label(np, &sdata[count], label);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>   					sensor_id, "label", type, pgroups[type],
> -					show_label);
> +					NULL, show_label, NULL);
>   			count++;
>   		}
>   
>   		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
>   			attr_name = get_max_attr(type);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>   					sensor_id, attr_name, type,
> -					pgroups[type], show_sensor);
> +					pgroups[type], sgrp_data, show_sensor,
> +					NULL);
>   			count++;
>   		}
>   
>   		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
>   			attr_name = get_min_attr(type);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>   					sensor_id, attr_name, type,
> -					pgroups[type], show_sensor);
> +					pgroups[type], sgrp_data, show_sensor,
> +					NULL);
> +			count++;
> +		}
> +
> +		if (sgrp_data && !sgrp_data->enable) {
> +			sgrp_data->enable = true;
> +			hw_id = ++group_attr_id[type];
> +			populate_sensor(&sdata[count], opal_index, hw_id,
> +					sgrp_data->gid, "enable", type,
> +					pgroups[type], sgrp_data, show_enable,
> +					store_enable);
>   			count++;
>   		}
>   	}
>   
> -exit_put_node:
>   	of_node_put(opal);
> -	return err;
> +	return 0;
>   }
>   
>   static int ibmpowernv_probe(struct platform_device *pdev)
> @@ -517,6 +701,7 @@ static int ibmpowernv_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, pdata);
>   	pdata->sensors_count = 0;
> +	pdata->nr_sensor_groups = 0;
>   	err = populate_attr_groups(pdev);
>   	if (err)
>   		return err;
> 

