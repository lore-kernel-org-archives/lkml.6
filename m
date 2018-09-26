Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71F1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1TrgovI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71F1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeIZTT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:19:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38407 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:19:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so473723plr.5;
        Wed, 26 Sep 2018 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qutz0/lV7vOTKwTH9g4Umnh+RBF2ICmVfaQLJ8xEVgE=;
        b=N1TrgovIoo8CmPWGKHAtdlqrJK4Zlbjgzb3+Ban7z16ms+0bIevoPuMH5HkM7wp/4y
         v6vtSd0z5+rsMm7VKTJv90IqonlxsZcJURkzMp2AY6xR97vz4DQpaV9BBKCX6qPVXTLX
         yk5XqEY/HGgql6NIULEWaHuHbQ79fhiZkGcO0Pi1tZloZig7zxrEqPMm34qig9EeA7cY
         jT3vK7lTWXkNbEtzd7xLQ04L/3Z5vz2c7QKi/gm4dhtR/vAHqawSZtEK0CbNnHyvU0Xe
         5+AoE5TyzTV8BMtHfXBlYtxlN5BNmx+LryRTRZqRUWWpu/tvA6ZNtWGVMoy/gDKw/aau
         tuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qutz0/lV7vOTKwTH9g4Umnh+RBF2ICmVfaQLJ8xEVgE=;
        b=Hpgse6e2ie1WKG/DR5/bbnb3UBsdgtSw0XZQ8YnoK2dCg0fOgt/XcipNaFZ7vW1yjp
         pddeLfkvacwn+vLq3SWRQ8Xn6OXADcxndtpksKr6wbpKjlrEpF4nMujN+NSXLNJ/tzZ9
         Q7npsKiB4KWWg5G+JDBEWsn8Ut5JUi5P4jqtvI6eF3XIJryTGjDOGmmsDvAAB+MKqV9h
         U73K0UbjxcSP1JeJgwy2x42KLpqPcR6zjKQWSTiLZYxo+RAV+fPfyxFlpumUPg5AMsJf
         aBgZUL29eKc7bHEiESSAZUOwQPpHOD3qE6yT+1lFTr3j8AHM77riN8ZNIcyIvx46d2tL
         KTZw==
X-Gm-Message-State: ABuFfojEZf+Rc/6xarkma+hxop+I15cEIUmSuyAWAP137G//vE8+Vb93
        gWDAD3AcrbqP+lx6RpKvF1TKQRZa
X-Google-Smtp-Source: ACcGV61QOT1dCFXDv7oqUe5lVkvJxZitiTlupnl9AhKT7sdSiwMKLv9F97w45iK3PIQ2AzgzAR9iqA==
X-Received: by 2002:a17:902:d201:: with SMTP id t1-v6mr6124291ply.63.1537967195421;
        Wed, 26 Sep 2018 06:06:35 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u62-v6sm8049171pfu.69.2018.09.26.06.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:06:34 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
Date:   Wed, 26 Sep 2018 06:06:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926064245.4091-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> The inX_enable interface allows user space to enable or disable
> the corresponding channel. Meanwhile, according to hwmon ABI, a
> disabled channel/sensor should return -ENODATA as a read result.
> 
> However, there're configurable nodes sharing the same __show()
> functions. So this change also adds to check if the attribute is
> read-only to make sure it's not reading a configuration but the
> sensor data.
> 

One necessary high level change I don't see below: With this change,
we should no longer drop a channel entirely if it is disabled from
devicetree. All channels should be visible but report -ENODATA if
disabled. In other words, it should be possible for the 'enable' flag
to override settings in DT.

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   Documentation/hwmon/ina3221 |  1 +
>   drivers/hwmon/ina3221.c     | 85 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
> index 6be64b553cd0..1aa32366d8aa 100644
> --- a/Documentation/hwmon/ina3221
> +++ b/Documentation/hwmon/ina3221
> @@ -23,6 +23,7 @@ Sysfs entries
>   
>   in[123]_input           Bus voltage(mV) channels
>   in[123]_label           Voltage channel labels
> +in[123]_enable          Voltage channel enable controls
>   curr[123]_input         Current(mA) measurement channels
>   shunt[123]_resistor     Shunt resistance(uOhm) channels
>   curr[123]_crit          Critical alert current(mA) setting, activates the
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 5890a2da3bfe..1be2d062a19e 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -78,6 +78,9 @@ enum ina3221_channels {
>   };
>   
>   static const unsigned int register_channel[] = {
> +	[INA3221_BUS1] = INA3221_CHANNEL1,
> +	[INA3221_BUS2] = INA3221_CHANNEL2,
> +	[INA3221_BUS3] = INA3221_CHANNEL3,
>   	[INA3221_SHUNT1] = INA3221_CHANNEL1,
>   	[INA3221_SHUNT2] = INA3221_CHANNEL2,
>   	[INA3221_SHUNT3] = INA3221_CHANNEL3,
> @@ -113,6 +116,19 @@ struct ina3221_data {
>   	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
>   };
>   
> +static inline bool ina3221_is_enable(struct ina3221_data *ina, int channel)

s/is_enable/is_enabled/, maybe ?

> +{
> +	unsigned int config;
> +	int ret;
> +
> +	/* Return false to reject further read */
> +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &config);
> +	if (ret)
> +		return false;
> +
> +	return (config & INA3221_CONFIG_CHx_EN(channel)) > 0;

The "> 0" is unnecessary. Conversion to bool is automatic. If you want to make
it explicit, please use

	return !!(config & INA3221_CONFIG_CHx_EN(channel));

It should not be necessary to re-read the value from the chip all the time.
I would suggest to cache the value in the 'disabled' variable.

> +}
> +
>   static ssize_t ina3221_show_label(struct device *dev,
>   				  struct device_attribute *attr, char *buf)
>   {
> @@ -124,6 +140,45 @@ static ssize_t ina3221_show_label(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%s\n", input->label);
>   }
>   
> +static ssize_t ina3221_show_enable(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	unsigned int channel = sd_attr->index;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +			ina3221_is_enable(ina, channel));
> +}
> +
> +static ssize_t ina3221_set_enable(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	unsigned int channel = sd_attr->index;
> +	unsigned int mask = INA3221_CONFIG_CHx_EN(channel);
> +	unsigned int config;
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* inX_enable only accepts 1 for enabling or 0 for disabling */
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
Just use kstrtobool().

> +	config = val ? mask : 0;
> +
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>   static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
>   			      int *val)
>   {
> @@ -146,8 +201,13 @@ static ssize_t ina3221_show_bus_voltage(struct device *dev,
>   	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
>   	struct ina3221_data *ina = dev_get_drvdata(dev);
>   	unsigned int reg = sd_attr->index;
> +	unsigned int channel = register_channel[reg];
>   	int val, voltage_mv, ret;
>   
> +	/* No data for read-only attribute if channel is disabled */
> +	if (!attr->store && !ina3221_is_enable(ina, channel))
> +		return -ENODATA;
> +
>   	ret = ina3221_read_value(ina, reg, &val);
>   	if (ret)
>   		return ret;
> @@ -164,8 +224,13 @@ static ssize_t ina3221_show_shunt_voltage(struct device *dev,
>   	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
>   	struct ina3221_data *ina = dev_get_drvdata(dev);
>   	unsigned int reg = sd_attr->index;
> +	unsigned int channel = register_channel[reg];
>   	int val, voltage_uv, ret;
>   
> +	/* No data for read-only attribute if channel is disabled */
> +	if (!attr->store && !ina3221_is_enable(ina, channel))
> +		return -ENODATA;
> +
>   	ret = ina3221_read_value(ina, reg, &val);
>   	if (ret)
>   		return ret;
> @@ -201,8 +266,13 @@ static ssize_t ina3221_show_current(struct device *dev,
>   	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
>   	struct ina3221_data *ina = dev_get_drvdata(dev);
>   	unsigned int reg = sd_attr->index;
> +	unsigned int channel = register_channel[reg];
>   	int current_ma, ret;
>   
> +	/* No data for read-only attribute if channel is disabled */
> +	if (!attr->store && !ina3221_is_enable(ina, channel))
> +		return -ENODATA;
> +
>   	ret = __ina3221_show_current(ina, reg, &current_ma);
>   	if (ret)
>   		return ret;
> @@ -318,6 +388,10 @@ static ssize_t ina3221_show_power(struct device *dev,
>   	int val, current_ma, voltage_mv, ret;
>   	s64 power_uw;
>   
> +	/* No data for read-only attribute if channel is disabled */
> +	if (!attr->store && !ina3221_is_enable(ina, channel))
> +		return -ENODATA;
> +
>   	/* Read bus voltage */
>   	ret = ina3221_read_value(ina, reg_bus, &val);
>   	if (ret)
> @@ -377,6 +451,14 @@ static SENSOR_DEVICE_ATTR(in2_label, 0444,
>   static SENSOR_DEVICE_ATTR(in3_label, 0444,
>   		ina3221_show_label, NULL, INA3221_CHANNEL3);
>   
> +/* voltage channel enable */
> +static SENSOR_DEVICE_ATTR(in1_enable, 0644,
> +		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL1);
> +static SENSOR_DEVICE_ATTR(in2_enable, 0644,
> +		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL2);
> +static SENSOR_DEVICE_ATTR(in3_enable, 0644,
> +		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL3);
> +
>   /* bus voltage */
>   static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
>   		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
> @@ -460,6 +542,7 @@ static SENSOR_DEVICE_ATTR(power3_crit, 0644,
>   static struct attribute *ina3221_attrs[] = {
>   	/* channel 1 -- make sure label at first */
>   	&sensor_dev_attr_in1_label.dev_attr.attr,
> +	&sensor_dev_attr_in1_enable.dev_attr.attr,
>   	&sensor_dev_attr_in1_input.dev_attr.attr,
>   	&sensor_dev_attr_curr1_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
> @@ -473,6 +556,7 @@ static struct attribute *ina3221_attrs[] = {
>   
>   	/* channel 2 -- make sure label at first */
>   	&sensor_dev_attr_in2_label.dev_attr.attr,
> +	&sensor_dev_attr_in2_enable.dev_attr.attr,
>   	&sensor_dev_attr_in2_input.dev_attr.attr,
>   	&sensor_dev_attr_curr2_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
> @@ -486,6 +570,7 @@ static struct attribute *ina3221_attrs[] = {
>   
>   	/* channel 3 -- make sure label at first */
>   	&sensor_dev_attr_in3_label.dev_attr.attr,
> +	&sensor_dev_attr_in3_enable.dev_attr.attr,
>   	&sensor_dev_attr_in3_input.dev_attr.attr,
>   	&sensor_dev_attr_curr3_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
> 

