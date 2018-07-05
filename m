Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84113C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C64823F82
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERyUzZTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C64823F82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753769AbeGEPhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:37:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42765 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:37:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id v9-v6so5761866pff.9;
        Thu, 05 Jul 2018 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuLmhVb0FtBHWvSZlsj7tqIMqYenv+456e+Q+X/r2M4=;
        b=ERyUzZTAcfJL4R9HjLIKJNcL+HZ5ue9bTod3nM3ux4kn/1Qz5McxEDiPhCgacE7j/R
         n1xDplfRQYmB3/bWvv1q6iFJTxh9D3jvyzKWleqenNcGCaW93wimQZk5zOuhaKzszY5f
         grfONPNaJ0Q9pJ0L+DFdEkARjIDg9DN2UN+sOBdwFZUmBI8zjLX6/GnmPSF/OZFCCzTA
         Nqm+hVDiKUH/v6kdTNmy0hvO/IRwfmhNy+vMtpUcK5BKY5QUeX0D9coyWLH7xxz9QBne
         65YPppH5OkNBzsM3LVi4GrVa/0z4ZJyoMLjR3Ntm8q3XIv/ME4WwoqszAFpMizkxvVj+
         GdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuLmhVb0FtBHWvSZlsj7tqIMqYenv+456e+Q+X/r2M4=;
        b=jWDPYEQZwUAFpre9BOHAHDgzOzcopcfhhDW+bv0g1NWAjMvAA28HyhP4DbZYEHrwp9
         UgP2+j84i+cxCQRl9z09Z2plOSGHgT/jOwtCdFBXab0guvjwJU3vDDdwLtTHBSHb6C47
         acZiPCIEIR2KvXAC0VMaKh+vWhZ75j809p9dqZNj4Kp1itJRU5YlqZ2GEjph5NjXEGtf
         pxeiRm51pCpgYTb+4eg5PmZfAW0RUwRmNCiBmsgZnPfI5fDKP+nGpukSlepvm0dwOu9L
         hj5LUG50tjE4aO61G6fp+m+tow6NFUknsC+6Lrg3qYhmMlL8FXJV6zb2VT3HMYJCwxcZ
         3WbA==
X-Gm-Message-State: APt69E2yS7Sf+9NNNMvutaCA88Y34Op/89bOUOUVqoRYMhXEgRHPFIGg
        1XF8Lyp5qZa18MrSOOlHSoA=
X-Google-Smtp-Source: AAOMgpdDESxMcwHZMTiJd9nHjs9z9HZtRPgbzhiXmIHA/lz41hpCCo+Q3Hwa37EmFz0LcsqQfj0efw==
X-Received: by 2002:a63:c44a:: with SMTP id m10-v6mr6130393pgg.416.1530805055613;
        Thu, 05 Jul 2018 08:37:35 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z4-v6sm10801354pfb.108.2018.07.05.08.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:37:34 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ego@linux.vnet.ibm.com
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530798689-27742-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b55f78a-1d29-4391-c43e-124772b7aa9f@roeck-us.net>
Date:   Thu, 5 Jul 2018 08:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530798689-27742-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 06:51 AM, Shilpasri G Bhat wrote:
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
> Changes from v2:
> - Writes to first 'enable' attribute of the sensor group will affect all the
>    sensors in the group
> - Removed global mutex and made it per sensor-group
> 
>   drivers/hwmon/ibmpowernv.c | 184 ++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 155 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index f829dad..9c6adee 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -73,6 +73,10 @@ enum sensors {
>   	struct attribute_group group;
>   	u32 attr_count;
>   	u32 hwmon_index;
> +	struct mutex mutex;
> +	u32 *gid;
> +	u32 nr_gid;
> +	bool enable;
>   } sensor_groups[] = {
>   	{ "fan"   },
>   	{ "temp"  },
> @@ -105,6 +109,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	ssize_t ret;
>   	u64 x;
>   
> +	if (!sensor_groups[sdata->type].enable)
> +		return -ENODATA;
> +
>   	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>   
>   	if (ret)
> @@ -120,6 +127,46 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	return sprintf(buf, "%llu\n", x);
>   }
>   
> +static ssize_t show_enable(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +
> +	return sprintf(buf, "%u\n", sensor_groups[sdata->type].enable);
> +}
> +
> +static ssize_t store_enable(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +	struct sensor_group *sg = &sensor_groups[sdata->type];
> +	int ret, i;
> +	bool data;
> +
> +	ret = kstrtobool(buf, &data);
> +	if (ret)
> +		return ret;
> +
> +	ret = mutex_lock_interruptible(&sg->mutex);
> +	if (ret)
> +		return ret;
> +
> +	if (data != sg->enable)
> +		for (i = 0; i < sg->nr_gid && !ret; i++)
> +			ret =  sensor_group_enable(sg->gid[i], data);
> +

Wouldn't it be better to have a separate attribute for each of the
affected groups if there can be more than one ? Just wondering.

The idea was to widen the scope to a point where there is a 1:1 match
between the hardware capabilities and attributes. Clearly having
a separate attribute for all sensors was inappropriate, but the code
above now suggests that a single attribute for all sensors may have
widened the scope too much (because the hardware can do better than
this).

Thanks,
Guenter

> +	if (!ret) {
> +		sg->enable = data;
> +		ret = count;
> +	}
> +
> +	mutex_unlock(&sg->mutex);
> +	return ret;
> +}
> +
>   static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>   			  char *buf)
>   {
> @@ -292,13 +339,68 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
>   	return ++sensor_groups[sdata->type].hwmon_index;
>   }
>   
> +static int init_sensor_group_data(struct platform_device *pdev)
> +{
> +	struct device_node *groups, *sg;
> +	enum sensors type;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < MAX_SENSOR_TYPE; i++) {
> +		sensor_groups[i].nr_gid = 0;
> +		sensor_groups[i].enable = true;
> +	}
> +
> +	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
> +	if (!groups)
> +		return ret;
> +
> +	for (i = 0; i < MAX_SENSOR_TYPE; i++) {
> +		u32 gid[256];
> +		u32 id, size;
> +
> +		for_each_child_of_node(groups, sg) {
> +			type = get_sensor_type(sg);
> +			if (type != i)
> +				continue;
> +
> +			if (of_property_read_u32(sg, "sensor-group-id", &id))
> +				continue;
> +
> +			gid[sensor_groups[i].nr_gid++] = id;
> +		}
> +
> +		if (!sensor_groups[i].nr_gid)
> +			continue;
> +
> +		size = sensor_groups[i].nr_gid * sizeof(u32);
> +		sensor_groups[i].gid = devm_kzalloc(&pdev->dev, size,
> +						    GFP_KERNEL);
> +		if (!sensor_groups[i].gid) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		memcpy(sensor_groups[i].gid, gid, size);
> +		sensor_groups[i].enable = false;
> +		mutex_init(&sensor_groups[i].mutex);
> +	}
> +
> +	of_node_put(groups);
> +	return ret;
> +}
> +
>   static int populate_attr_groups(struct platform_device *pdev)
>   {
>   	struct platform_data *pdata = platform_get_drvdata(pdev);
>   	const struct attribute_group **pgroups = pdata->attr_groups;
>   	struct device_node *opal, *np;
> +	int ret;
>   	enum sensors type;
>   
> +	ret = init_sensor_group_data(pdev);
> +	if (ret)
> +		return ret;
> +
>   	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	for_each_child_of_node(opal, np) {
>   		const char *label;
> @@ -313,7 +415,7 @@ static int populate_attr_groups(struct platform_device *pdev)
>   		sensor_groups[type].attr_count++;
>   
>   		/*
> -		 * add attributes for labels, min and max
> +		 * add attributes for labels, min, max and enable
>   		 */
>   		if (!of_property_read_string(np, "label", &label))
>   			sensor_groups[type].attr_count++;
> @@ -321,6 +423,8 @@ static int populate_attr_groups(struct platform_device *pdev)
>   			sensor_groups[type].attr_count++;
>   		if (of_find_property(np, "sensor-data-max", NULL))
>   			sensor_groups[type].attr_count++;
> +		if (sensor_groups[type].nr_gid)
> +			sensor_groups[type].attr_count++;
>   	}
>   
>   	of_node_put(opal);
> @@ -344,7 +448,10 @@ static int populate_attr_groups(struct platform_device *pdev)
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
> @@ -352,8 +459,13 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
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
> @@ -361,13 +473,16 @@ static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
>   			    const struct attribute_group *pgroup,
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
>   }
>   
> @@ -408,18 +523,16 @@ static int create_device_attrs(struct platform_device *pdev)
>   	u32 count = 0;
>   	int err = 0;
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
>   		const char *attr_name;
> -		u32 opal_index;
> +		u32 opal_index, hw_id;
>   		const char *label;
>   
>   		if (np->name == NULL)
> @@ -456,14 +569,11 @@ static int create_device_attrs(struct platform_device *pdev)
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
> +		populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
> +				attr_name, type, pgroups[type], show_sensor,
> +				NULL);
> +		count++;
>   
>   		if (!of_property_read_string(np, "label", &label)) {
>   			/*
> @@ -474,33 +584,49 @@ static int create_device_attrs(struct platform_device *pdev)
>   			 */
>   
>   			make_sensor_label(np, &sdata[count], label);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>   					sensor_id, "label", type, pgroups[type],
> -					show_label);
> +					show_label, NULL);
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
> +					pgroups[type], show_sensor, NULL);
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
> +					pgroups[type], show_sensor, NULL);
>   			count++;
>   		}
> +
> +		if (sensor_groups[type].nr_gid) {
> +			ssize_t (*store)(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count);
> +
> +			if (!sensor_groups[type].enable) {
> +				sensor_groups[type].enable = true;
> +				store = store_enable;
> +			} else {
> +				store = NULL;
> +			}
> +
> +			sensor_groups[type].enable = true;
> +			populate_sensor(&sdata[count], opal_index, hw_id,
> +					sensor_id, "enable", type,
> +					pgroups[type], show_enable, store);
> +			count++;
> +		}
> +
>   	}
>   
> -exit_put_node:
>   	of_node_put(opal);
>   	return err;
>   }
> 

