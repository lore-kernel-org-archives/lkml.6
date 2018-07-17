Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF00F20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGLC/jX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF00F20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbeGQOUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:20:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34346 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbeGQOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:20:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so476732pgv.1;
        Tue, 17 Jul 2018 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+xPTZgg6SmrkoDtBKMQ0DsU2oqBU6IDxQksMQK60nQ=;
        b=VGLC/jX1mP5aApd6SbF0q6xwToJUEW1Yze1B0t3MGkd4pnN66gZR3gYwIjrtnc1fyO
         7ArOoO8mXPFXaf+tIqu2/R1ZTPkeKy4zlOfLvq8kIHCfiCHxba4+DrfKYQhl8s+DhQeC
         VXXGlNudow4S4YU6uT9Omjx1WMuoSx6Ji5mAWAj5zQWbW4dPXc3/xgcThSP9M3Obketf
         9ngFsqbdSurxsblAzQ0LmWPsnFqWw7fVizsb/R6uEyEcmkO0FcClXAfKHi4w1c2osjtn
         IwQh+WFHNxrtchv3ix58IzjYjn/ObXYi2Rh1TwX7JatQ7k2ChoR+J2AdHTGk7MK004NX
         HFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+xPTZgg6SmrkoDtBKMQ0DsU2oqBU6IDxQksMQK60nQ=;
        b=n2t8w2OKml6dzVdD898wOPiCDZ+7CpLoIWATAB0RoWzSvRNdCjgLeMOrFxljCVQOW+
         OOjwkgK5ewkmk7AoJCBS5NjpyOFT6BQGTnzJxcFOw3M10cigdu7D+bN25QC5lUjahoK9
         wlVPziO2EwfqpvCuKYMRInPTnotE9i0CGZL70Uwd7+cGREeRiT2LncP8sc82GCyrSuAh
         bwhgwTJdx7kG5KVua6wsgTcWmZdc16n/KB76k845ywr16VhXdBr30eeg+y7zEc5XoDIH
         n2EFTvblWUtjzFrHqVZ6xIGSKKy0rF+bZLe/UzkU5YLHj6Qe6kcXYVtM5mu7Xuq4SfPZ
         oI1A==
X-Gm-Message-State: AOUpUlGHBp4oiUcoKvjUNxJ+Uk1/+BKVxxNq4E1O0WlZJ0vlz2ztd8hE
        RkLYhaCgCS1Nq9Hcf6wAGdQ=
X-Google-Smtp-Source: AAOMgpdlG8nZVO0hO1H1mdWXmDkcjU/RKWqmeVCRfeRUPL/mQ3wmNrEP2q9mUX0ln36lFwPIWhMTOA==
X-Received: by 2002:a63:6743:: with SMTP id b64-v6mr1645834pgc.91.1531835258384;
        Tue, 17 Jul 2018 06:47:38 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm1945127pgu.5.2018.07.17.06.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 06:47:37 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1531637685-23250-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1531637685-23250-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9e7f301e-c169-d034-eee7-a45f0afb03a1@roeck-us.net>
Date:   Tue, 17 Jul 2018 06:47:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531637685-23250-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/2018 11:54 PM, Shilpasri G Bhat wrote:
> On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
> which measures various system and chip level sensors. These sensors
> comprises of environmental sensors (like power, temperature, current
> and voltage) and performance sensors (like utilization, frequency).
> All these sensors are copied to main memory at a regular interval of
> 100ms. OCC provides a way to select a group of sensors that is copied
> to the main memory to increase the update frequency of selected sensor
> groups. When a sensor-group is disabled, OCC will not copy it to main
> memory and those sensors read 0 values.
> 
> This patch provides support for enabling/disabling the sensor groups
> like power, temperature, current and voltage. This patch adds new
> per-senor sysfs attribute to disable and enable them.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v4:
> - As per Mpe's suggestion store device_node instead of phandles and
>    clean it after init
> - s/sg_data/sgrp_data
> 
>   Documentation/hwmon/ibmpowernv |  43 ++++++-
>   drivers/hwmon/ibmpowernv.c     | 256 +++++++++++++++++++++++++++++++++++------
>   2 files changed, 265 insertions(+), 34 deletions(-)
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
> index f829dad..a509b9b 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -90,11 +90,23 @@ struct sensor_data {
>   	char label[MAX_LABEL_LEN];
>   	char name[MAX_ATTR_LEN];
>   	struct device_attribute dev_attr;
> +	struct sensor_group_data *sgrp_data;
> +};
> +
> +struct sensor_group_data {
> +	struct mutex mutex;
> +	struct device_node **of_nodes;
> +	u32 gid;
> +	u32 nr_nodes;
> +	enum sensors type;
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
> @@ -105,6 +117,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	ssize_t ret;
>   	u64 x;
>   
> +	if (sdata->sgrp_data && !sdata->sgrp_data->enable)
> +		return -ENODATA;
> +
>   	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>   
>   	if (ret)
> @@ -120,6 +135,46 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
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
> @@ -292,12 +347,129 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
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
> +	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
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
> +		int len, gid, i, k = 0;
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
> +		sgrp_data[count].of_nodes = devm_kcalloc(&pdev->dev,
> +						sizeof(struct device_node *),
> +						len, GFP_KERNEL);
> +		if (!sgrp_data[count].of_nodes) {
> +			ret = -ENOMEM;
> +			of_node_put(sgrp);
> +			goto out;
> +		}
> +
> +		for (i = 0; i < len; i++) {
> +			struct device_node *node;
> +
> +			node = of_parse_phandle(sgrp, "sensors", i);
> +			if (!node)
> +				continue;
> +			sgrp_data[count].of_nodes[k++] = node;

I don't immediately see where "node" is used later. As mentioned below,
I'll need to have a much closer look into the code to understand what
is going on here.

> +		}
> +
> +		sensor_groups[type].attr_count++;
> +		sgrp_data[count].gid = gid;
> +		sgrp_data[count].type = type;
> +		sgrp_data[count].nr_nodes = len;
> +		mutex_init(&sgrp_data[count].mutex);
> +		sgrp_data[count++].enable = false;
> +	}
> +	pdata->sgrp_data = sgrp_data;
> +out:
> +	of_node_put(groups);
> +	return ret;
> +}
> +
> +static struct sensor_group_data *get_sensor_group(struct platform_data *pdata,
> +						  struct device_node *node,
> +						  enum sensors type)
> +{
> +	struct sensor_group_data *sgrp_data = pdata->sgrp_data;
> +	int i, j;
> +
> +	for (i = 0; i < pdata->nr_sensor_groups; i++) {
> +		if (type != sgrp_data[i].type)
> +			continue;
> +
> +		for (j = 0; j < sgrp_data[i].nr_nodes; j++)
> +			if (sgrp_data[i].of_nodes[j] == node)
> +				return &sgrp_data[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static void clean_sensor_group_of_node(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata = platform_get_drvdata(pdev);
> +	struct sensor_group_data *sgrp_data = pdata->sgrp_data;
> +	int i, j;
> +
> +	for (i = 0; i < pdata->nr_sensor_groups; i++) {
> +		for (j = 0; j < sgrp_data[i].nr_nodes; j++)
> +			of_node_put(sgrp_data[i].of_nodes[j]);
> +
> +		devm_kfree(&pdev->dev, sgrp_data[i].of_nodes);

The whole point of calling devm_kzalloc() is that calling devm_kfree()
is not necessary. Any call to devm_kfree() is a strong indication
that something is wrong.

> +		sgrp_data[i].of_nodes = NULL;
> +	}
> +}
> +

Ok, this will require a detailed review. I don't understand what this
function is about. It seems that sgrp_data[].of_nodes is only allocated
to be  freed at the end of create_dev_attrs(), suggesting that the cleared
data isn't needed for runtime and thus should not be stored in an
array in the first place. I'll have to understand this much better
than I do right now before approving it.

Guenter

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
> @@ -344,7 +516,10 @@ static int populate_attr_groups(struct platform_device *pdev)
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
> @@ -352,23 +527,33 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
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
> @@ -403,24 +588,23 @@ static int create_device_attrs(struct platform_device *pdev)
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
> @@ -456,14 +640,12 @@ static int create_device_attrs(struct platform_device *pdev)
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
> @@ -474,35 +656,44 @@ static int create_device_attrs(struct platform_device *pdev)
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
> +	clean_sensor_group_of_node(pdev);
> +	return 0;
>   }
>   
>   static int ibmpowernv_probe(struct platform_device *pdev)
> @@ -517,6 +708,7 @@ static int ibmpowernv_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, pdata);
>   	pdata->sensors_count = 0;
> +	pdata->nr_sensor_groups = 0;
>   	err = populate_attr_groups(pdev);
>   	if (err)
>   		return err;
> 

