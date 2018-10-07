Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F43EC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158B920882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 07:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzuIrTpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158B920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJGOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 10:14:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40298 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeJGOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 10:14:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so8649700plv.7;
        Sun, 07 Oct 2018 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=01rPbkWjj0g40TETzu+5kH93W/Bce1LOWBWeDhObELM=;
        b=XzuIrTpMMmpFX359sW/WvV/E7vZxzoceS9zHuw4gMkD9eK9Su19qAENr84xsUpeN44
         zyHQihPFa0I6qlB2ylZl7PtKKnI62b7S29YqI5ikAjXGVn7f8h+X6qXhhH+RH0cUs4Ub
         pWq/mJfTDN81oiPWNtRvEhYYQj+AWhtoBpwhmIhO0GbDp2o9Jc//Bf/oBdpHi7sAbhmC
         OY01LY2hBlmj/Z3YLoH1g0luhBLBcesYzI+K0KUa8Nuo2V28z1mQ9PF/yMjLmgBn1mtR
         bBoHE4vnHyuDi4uOvkEdYei/rHF1yejVF4W6ChS+lWhxim05TQDRtnVKmnspXHrL+A3x
         i9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=01rPbkWjj0g40TETzu+5kH93W/Bce1LOWBWeDhObELM=;
        b=aOKioyV4maJ4b2u5NWeazI0bSRWKUQpWtSKSALDBIUdsZKRj+nTVHXmMcAIznQd2yg
         wyEqkt+BA6yDEWfGiMfEVnXft8aF22krTkfRo3RejJsAPs+3NdqwlkzotRVyGW3eR7ZF
         YQaTdQgY8uEC/HCV/2F9h2CPwr31I4bqgowMPfk38L1PePmjV7Ovi4JZ1bXUGU/EAzDk
         eVlZvCPzEY6P1c+BlnA+Q9eHolASyqYbH+gfAC7Nso7JjHH4012i6AF58Ai3ZnlL3ZcR
         +/meULCOgKHpRocOwYKnkrZWTXIjdrUyXSTVsBTsZECoLficTXDoCXYIiiiC5Lg6KTXY
         VoHQ==
X-Gm-Message-State: ABuFfoivLVHUI79uwVflXJywnNRa54K3wn/coXc9n9CRXI7qapMT7XXB
        zENzjejHxSXCt7hy80Z4icM=
X-Google-Smtp-Source: ACcGV61FPxIwKXUzcyAfW1hS5e1hrCyl3sZ+esMNfCnsJA71VbyWUOEVUDT/e+svRC4MBcxSki3nNQ==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr18510953pln.147.1538896085916;
        Sun, 07 Oct 2018 00:08:05 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27490977pgt.83.2018.10.07.00.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 00:08:05 -0700 (PDT)
Date:   Sun, 7 Oct 2018 00:07:55 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Use _info API to register hwmon
 device
Message-ID: <20181007070754.GA10804@Asurada>
References: <20181005235905.29403-1-nicoleotsuka@gmail.com>
 <20181005235905.29403-3-nicoleotsuka@gmail.com>
 <20181006200527.GA3432@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006200527.GA3432@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 01:05:27PM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On Fri, Oct 05, 2018 at 04:59:05PM -0700, Nicolin Chen wrote:
> > The hwmon core has a newer API which abstracts most of common
> > things in the core so as to simplify the hwmon device drivers.
> > 
> > This patch implements this _info API to ina3221 hwmon driver.
> > 
> 
> $ size drivers/hwmon/ina*.o
>    text	   data	    bss	    dec	    hex	filename
>    9251	   3552	     64	  12867	   3243	drivers/hwmon/ina3221.o
>   12959	   9256	     64	  22279	   5707	drivers/hwmon/ina3221-orig.o
> 
> It looks like this version is about 45% smaller. Surprising, isn't it ?

I was thinking about adding a memory saving report like this in
the commit log until I noticed that the actual saving of binary
size is 7~8KB on my side and there seems to be no difference at
the size showed in the lsmod list (I built the driver with =m).

Yet, I agree the saving is proportionally huge.

> Something else I just noticed: When reading the shunt resistor
> value from devicetree, the value range is not checked. A shunt
> resistor value of 0 should result in a divide by zero error.
> Also, the value read from dt is an u32, but assigned to an int.
> A shunt resistor value of 0x80000000 or higher should yield quite
> interesting results. Not that this makes sense, but we should not
> accept bad values. Can you send a follow-up patch to fix that ?

Will send a separate fix in the next version.

> Other comments inline.

Will fix them too.

Thank you
Nicolin

--------

> Thanks,
> Guenter
> 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/hwmon/ina3221.c | 528 +++++++++++++++++++---------------------
> >  1 file changed, 245 insertions(+), 283 deletions(-)
> > 
> > diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> > index c3a497aed345..08cc0b4bc0ba 100644
> > --- a/drivers/hwmon/ina3221.c
> > +++ b/drivers/hwmon/ina3221.c
> > @@ -77,21 +77,6 @@ enum ina3221_channels {
> >  	INA3221_NUM_CHANNELS
> >  };
> >  
> > -static const unsigned int register_channel[] = {
> > -	[INA3221_BUS1] = INA3221_CHANNEL1,
> > -	[INA3221_BUS2] = INA3221_CHANNEL2,
> > -	[INA3221_BUS3] = INA3221_CHANNEL3,
> > -	[INA3221_SHUNT1] = INA3221_CHANNEL1,
> > -	[INA3221_SHUNT2] = INA3221_CHANNEL2,
> > -	[INA3221_SHUNT3] = INA3221_CHANNEL3,
> > -	[INA3221_CRIT1] = INA3221_CHANNEL1,
> > -	[INA3221_CRIT2] = INA3221_CHANNEL2,
> > -	[INA3221_CRIT3] = INA3221_CHANNEL3,
> > -	[INA3221_WARN1] = INA3221_CHANNEL1,
> > -	[INA3221_WARN2] = INA3221_CHANNEL2,
> > -	[INA3221_WARN3] = INA3221_CHANNEL3,
> > -};
> > -
> >  /**
> >   * struct ina3221_input - channel input source specific information
> >   * @label: label of channel input source
> > @@ -123,58 +108,6 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
> >  	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
> >  }
> >  
> > -static ssize_t ina3221_show_label(struct device *dev,
> > -				  struct device_attribute *attr, char *buf)
> > -{
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> > -	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int channel = sd_attr->index;
> > -	struct ina3221_input *input = &ina->inputs[channel];
> > -
> > -	return snprintf(buf, PAGE_SIZE, "%s\n", input->label);
> > -}
> > -
> > -static ssize_t ina3221_show_enable(struct device *dev,
> > -				   struct device_attribute *attr, char *buf)
> > -{
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> > -	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int channel = sd_attr->index;
> > -
> > -	return snprintf(buf, PAGE_SIZE, "%d\n",
> > -			ina3221_is_enabled(ina, channel));
> > -}
> > -
> > -static ssize_t ina3221_set_enable(struct device *dev,
> > -				  struct device_attribute *attr,
> > -				  const char *buf, size_t count)
> > -{
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> > -	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int channel = sd_attr->index;
> > -	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
> > -	bool enable;
> > -	int ret;
> > -
> > -	ret = kstrtobool(buf, &enable);
> > -	if (ret)
> > -		return ret;
> > -
> > -	config = enable ? mask : 0;
> > -
> > -	/* Enable or disable the channel */
> > -	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
> > -	if (ret)
> > -		return ret;
> > -
> > -	/* Cache the latest config register value */
> > -	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return count;
> > -}
> > -
> >  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
> >  			      int *val)
> >  {
> > @@ -190,94 +123,107 @@ static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
> >  	return 0;
> >  }
> >  
> > -static ssize_t ina3221_show_bus_voltage(struct device *dev,
> > -					struct device_attribute *attr,
> > -					char *buf)
> > +static const u8 ina3221_in_reg[] = {
> > +	INA3221_BUS1,
> > +	INA3221_BUS2,
> > +	INA3221_BUS3,
> > +	INA3221_SHUNT1,
> > +	INA3221_SHUNT2,
> > +	INA3221_SHUNT3,
> > +};
> > +
> > +static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
> >  {
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> > +	const bool is_shunt = channel > INA3221_CHANNEL3;
> >  	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int reg = sd_attr->index;
> > -	unsigned int channel = register_channel[reg];
> > -	int val, voltage_mv, ret;
> > +	u8 reg = ina3221_in_reg[channel];
> > +	int regval, ret;
> >  
> > -	/* No data for read-only attribute if channel is disabled */
> > -	if (!attr->store && !ina3221_is_enabled(ina, channel))
> > -		return -ENODATA;
> > +	/* Translate shunt channel ID to sensor channel ID: 4->1, 5->2, 6->3 */
> 
> Misleading. The channel number as used here is 0-aligned, so it is 3 -> 0
> etc.
> 
> I know the chip talks about channels 1..3, but that is not how "channel"
> is used here. It took me a bit to find out that the calling code
> subtracts 1 from the channel number and that the code is correct.
> We don't want others to suffer the same fate.
> 
> > +	channel %= INA3221_NUM_CHANNELS;
> 
> 3 % 3 = 0, not 1.
> 
> >  
> > -	ret = ina3221_read_value(ina, reg, &val);
> > -	if (ret)
> > -		return ret;
> > +	switch (attr) {
> > +	case hwmon_in_input:
> > +		if (!ina3221_is_enabled(ina, channel))
> > +			return -ENODATA;
> >  
> > -	voltage_mv = val * 8;
> > +		ret = ina3221_read_value(ina, reg, &regval);
> > +		if (ret)
> > +			return ret;
> >  
> > -	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_mv);
> > +		/*
> > +		 * Scale of shunt voltage (uV): LSB is 40uV
> > +		 * Scale of bus voltage (mV): LSB is 8mV
> > +		 */
> > +		*val = regval * (is_shunt ? 40 : 8);
> > +		return 0;
> > +	case hwmon_in_enable:
> > +		*val = ina3221_is_enabled(ina, channel);
> > +		return 0;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> >  }
> >  
> > -static ssize_t ina3221_show_shunt_voltage(struct device *dev,
> > -					  struct device_attribute *attr,
> > -					  char *buf)
> > +static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS] = {
> > +	[hwmon_curr_input] = { INA3221_SHUNT1, INA3221_SHUNT2, INA3221_SHUNT3 },
> > +	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3 },
> > +	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2, INA3221_CRIT3 },
> > +	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3 },
> > +	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3 },
> > +};
> > +
> > +static int ina3221_read_curr(struct device *dev, u32 attr,
> > +			     int channel, long *val)
> >  {
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> >  	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int reg = sd_attr->index;
> > -	unsigned int channel = register_channel[reg];
> > -	int val, voltage_uv, ret;
> > -
> > -	/* No data for read-only attribute if channel is disabled */
> > -	if (!attr->store && !ina3221_is_enabled(ina, channel))
> > -		return -ENODATA;
> > -
> > -	ret = ina3221_read_value(ina, reg, &val);
> > -	if (ret)
> > -		return ret;
> > -	voltage_uv = val * 40;
> > -
> > -	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_uv);
> > -}
> > -
> > -static ssize_t ina3221_show_current(struct device *dev,
> > -				    struct device_attribute *attr, char *buf)
> > -{
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> > -	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int reg = sd_attr->index;
> > -	unsigned int channel = register_channel[reg];
> >  	struct ina3221_input *input = &ina->inputs[channel];
> >  	int resistance_uo = input->shunt_resistor;
> > -	int val, current_ma, voltage_nv, ret;
> > +	u8 reg = ina3221_curr_reg[attr][channel];
> > +	int regval, voltage_nv, ret;
> >  
> > -	/* No data for read-only attribute if channel is disabled */
> > -	if (!attr->store && !ina3221_is_enabled(ina, channel))
> > -		return -ENODATA;
> > +	switch (attr) {
> > +	case hwmon_curr_input:
> > +		if (!ina3221_is_enabled(ina, channel))
> > +			return -ENODATA;
> > +		/* fallthrough */
> 
> I think the official terminology is "fall through".
> But then it looks like "fallthrough" is also widely used,
> so maybe we are ok.
> 
> > +	case hwmon_curr_crit:
> > +	case hwmon_curr_max:
> > +		ret = ina3221_read_value(ina, reg, &regval);
> > +		if (ret)
> > +			return ret;
> >  
> > -	ret = ina3221_read_value(ina, reg, &val);
> > -	if (ret)
> > -		return ret;
> > -	voltage_nv = val * 40000;
> > -
> > -	current_ma = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
> > -
> > -	return snprintf(buf, PAGE_SIZE, "%d\n", current_ma);
> > +		/* Scale of shunt voltage: LSB is 40uV (40000nV) */
> > +		voltage_nv = regval * 40000;
> > +		/* Return current in mA */
> > +		*val = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
> > +		return 0;
> > +	case hwmon_curr_crit_alarm:
> > +	case hwmon_curr_max_alarm:
> > +		ret = regmap_field_read(ina->fields[reg], &regval);
> > +		if (ret)
> > +			return ret;
> > +		*val = regval;
> > +		return 0;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> >  }
> >  
> > -static ssize_t ina3221_set_current(struct device *dev,
> > -				   struct device_attribute *attr,
> > -				   const char *buf, size_t count)
> > +static int ina3221_write_curr(struct device *dev, u32 attr,
> > +			      int channel, long val)
> >  {
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> >  	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int reg = sd_attr->index;
> > -	unsigned int channel = register_channel[reg];
> >  	struct ina3221_input *input = &ina->inputs[channel];
> >  	int resistance_uo = input->shunt_resistor;
> > -	int val, current_ma, voltage_uv, ret;
> > +	u8 reg = ina3221_curr_reg[attr][channel];
> > +	int regval, current_ma, voltage_uv;
> >  
> > -	ret = kstrtoint(buf, 0, &current_ma);
> > -	if (ret)
> > -		return ret;
> > +	if (attr != hwmon_curr_crit && attr != hwmon_curr_max)
> > +		return -EOPNOTSUPP;
> 
> I don't think this is needed.
> 
> >  
> >  	/* clamp current */
> > -	current_ma = clamp_val(current_ma,
> > +	current_ma = clamp_val(val,
> >  			       INT_MIN / resistance_uo,
> >  			       INT_MAX / resistance_uo);
> >  
> > @@ -287,15 +233,175 @@ static ssize_t ina3221_set_current(struct device *dev,
> >  	voltage_uv = clamp_val(voltage_uv, -163800, 163800);
> >  
> >  	/* 1 / 40uV(scale) << 3(register shift) = 5 */
> > -	val = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
> > +	regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
> >  
> > -	ret = regmap_write(ina->regmap, reg, val);
> > +	return regmap_write(ina->regmap, reg, regval);
> > +}
> > +
> > +static int ina3221_write_enable(struct device *dev, int channel, bool enable)
> > +{
> > +	struct ina3221_data *ina = dev_get_drvdata(dev);
> > +	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
> > +	int ret;
> > +
> > +	config = enable ? mask : 0;
> > +
> > +	/* Enable or disable the channel */
> > +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
> >  	if (ret)
> >  		return ret;
> >  
> > -	return count;
> > +	/* Cache the latest config register value */
> > +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> >  }
> >  
> > +static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
> > +			u32 attr, int channel, long *val)
> > +{
> > +	switch (type) {
> > +	case hwmon_in:
> > +		return ina3221_read_in(dev, attr, channel - 1, val);
> > +	case hwmon_curr:
> > +		return ina3221_read_curr(dev, attr, channel, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
> > +			 u32 attr, int channel, long val)
> > +{
> > +	switch (type) {
> > +	case hwmon_in:
> > +		if (attr != hwmon_in_enable)
> > +			return -EOPNOTSUPP;
> 
> I think you can drop this.
> 
> > +		return ina3221_write_enable(dev, channel - 1, val);
> > +	case hwmon_curr:
> > +		return ina3221_write_curr(dev, attr, channel, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> 
> I tend to have drivers return -EOPNOTSUPP for default: cases
> since otherwise static checkers may complain about missing default
> cases, but otherwise we should refrain from unnecessary checks.
> 
> > +	}
> > +}
> > +
> > +static int ina3221_read_string(struct device *dev, enum hwmon_sensor_types type,
> > +			       u32 attr, int channel, const char **str)
> > +{
> > +	struct ina3221_data *ina = dev_get_drvdata(dev);
> > +	int index = channel - 1;
> > +
> > +	if (type != hwmon_in || attr != hwmon_in_label)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Only 1-3 channels have hwmon_in_label */
> > +	if (channel < 1 || channel > 3)
> > +		return -EOPNOTSUPP;
> > +
> The above checks should be unnecessary.
> 
> > +	*str = ina->inputs[index].label;
> > +
> > +	return 0;
> > +}
> > +
> > +static umode_t ina3221_is_visible(const void *drvdata,
> > +				  enum hwmon_sensor_types type,
> > +				  u32 attr, int channel)
> > +{
> > +	const struct ina3221_data *ina = drvdata;
> > +	const struct ina3221_input *input = NULL;
> > +
> > +	switch (type) {
> > +	case hwmon_in:
> > +		/* Ignore in0_ */
> > +		if (channel == 0)
> > +			return 0;
> > +
> > +		switch (attr) {
> > +		case hwmon_in_label:
> > +			if (channel - 1 <= INA3221_CHANNEL3)
> > +				input = &ina->inputs[channel - 1];
> > +			/* Hide label node if label is not provided */
> > +			return (input && input->label) ? 0444 : 0;
> > +		case hwmon_in_input:
> > +			return 0444;
> > +		case hwmon_in_enable:
> > +			return 0644;
> > +		default:
> > +			return 0;
> > +		}
> > +	case hwmon_curr:
> > +		switch (attr) {
> > +		case hwmon_curr_input:
> > +		case hwmon_curr_crit_alarm:
> > +		case hwmon_curr_max_alarm:
> > +			return 0444;
> > +		case hwmon_curr_crit:
> > +		case hwmon_curr_max:
> > +			return 0644;
> > +		default:
> > +			return 0;
> > +		}
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> > +static const u32 ina3221_in_config[] = {
> > +	/* 0: dummy, skipped in is_visible */
> > +	HWMON_I_INPUT,
> > +	/* 1-3: input voltage Channels */
> > +	HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> > +	HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> > +	HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> > +	/* 4-6: shunt voltage Channels */
> > +	HWMON_I_INPUT,
> > +	HWMON_I_INPUT,
> > +	HWMON_I_INPUT,
> > +	0
> > +};
> > +
> > +static const struct hwmon_channel_info ina3221_in = {
> > +	.type = hwmon_in,
> > +	.config = ina3221_in_config,
> > +};
> > +
> > +#define INA3221_HWMON_CURR_CONFIG (HWMON_C_INPUT | \
> > +				   HWMON_C_CRIT | HWMON_C_CRIT_ALARM | \
> > +				   HWMON_C_MAX | HWMON_C_MAX_ALARM)
> > +
> > +static const u32 ina3221_curr_config[] = {
> > +	INA3221_HWMON_CURR_CONFIG,
> > +	INA3221_HWMON_CURR_CONFIG,
> > +	INA3221_HWMON_CURR_CONFIG,
> > +	0
> > +};
> > +
> > +static const struct hwmon_channel_info ina3221_curr = {
> > +	.type = hwmon_curr,
> > +	.config = ina3221_curr_config,
> > +};
> > +
> > +static const struct hwmon_channel_info *ina3221_info[] = {
> > +	&ina3221_in,
> > +	&ina3221_curr,
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_ops ina3221_hwmon_ops = {
> > +	.is_visible = ina3221_is_visible,
> > +	.read_string = ina3221_read_string,
> > +	.read = ina3221_read,
> > +	.write = ina3221_write,
> > +};
> > +
> > +static const struct hwmon_chip_info ina3221_chip_info = {
> > +	.ops = &ina3221_hwmon_ops,
> > +	.info = ina3221_info,
> > +};
> > +
> > +/* Extra attribute groups */
> >  static ssize_t ina3221_show_shunt(struct device *dev,
> >  				  struct device_attribute *attr, char *buf)
> >  {
> > @@ -329,54 +435,6 @@ static ssize_t ina3221_set_shunt(struct device *dev,
> >  	return count;
> >  }
> >  
> > -static ssize_t ina3221_show_alert(struct device *dev,
> > -				  struct device_attribute *attr, char *buf)
> > -{
> > -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> > -	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	unsigned int field = sd_attr->index;
> > -	unsigned int regval;
> > -	int ret;
> > -
> > -	ret = regmap_field_read(ina->fields[field], &regval);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
> > -}
> > -
> > -/* input channel label */
> > -static SENSOR_DEVICE_ATTR(in1_label, 0444,
> > -		ina3221_show_label, NULL, INA3221_CHANNEL1);
> > -static SENSOR_DEVICE_ATTR(in2_label, 0444,
> > -		ina3221_show_label, NULL, INA3221_CHANNEL2);
> > -static SENSOR_DEVICE_ATTR(in3_label, 0444,
> > -		ina3221_show_label, NULL, INA3221_CHANNEL3);
> > -
> > -/* voltage channel enable */
> > -static SENSOR_DEVICE_ATTR(in1_enable, 0644,
> > -		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL1);
> > -static SENSOR_DEVICE_ATTR(in2_enable, 0644,
> > -		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL2);
> > -static SENSOR_DEVICE_ATTR(in3_enable, 0644,
> > -		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL3);
> > -
> > -/* bus voltage */
> > -static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
> > -		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
> > -static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO,
> > -		ina3221_show_bus_voltage, NULL, INA3221_BUS2);
> > -static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO,
> > -		ina3221_show_bus_voltage, NULL, INA3221_BUS3);
> > -
> > -/* calculated current */
> > -static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO,
> > -		ina3221_show_current, NULL, INA3221_SHUNT1);
> > -static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO,
> > -		ina3221_show_current, NULL, INA3221_SHUNT2);
> > -static SENSOR_DEVICE_ATTR(curr3_input, S_IRUGO,
> > -		ina3221_show_current, NULL, INA3221_SHUNT3);
> > -
> >  /* shunt resistance */
> >  static SENSOR_DEVICE_ATTR(shunt1_resistor, S_IRUGO | S_IWUSR,
> >  		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL1);
> > @@ -385,109 +443,13 @@ static SENSOR_DEVICE_ATTR(shunt2_resistor, S_IRUGO | S_IWUSR,
> >  static SENSOR_DEVICE_ATTR(shunt3_resistor, S_IRUGO | S_IWUSR,
> >  		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL3);
> >  
> > -/* critical current */
> > -static SENSOR_DEVICE_ATTR(curr1_crit, S_IRUGO | S_IWUSR,
> > -		ina3221_show_current, ina3221_set_current, INA3221_CRIT1);
> > -static SENSOR_DEVICE_ATTR(curr2_crit, S_IRUGO | S_IWUSR,
> > -		ina3221_show_current, ina3221_set_current, INA3221_CRIT2);
> > -static SENSOR_DEVICE_ATTR(curr3_crit, S_IRUGO | S_IWUSR,
> > -		ina3221_show_current, ina3221_set_current, INA3221_CRIT3);
> > -
> > -/* critical current alert */
> > -static SENSOR_DEVICE_ATTR(curr1_crit_alarm, S_IRUGO,
> > -		ina3221_show_alert, NULL, F_CF1);
> > -static SENSOR_DEVICE_ATTR(curr2_crit_alarm, S_IRUGO,
> > -		ina3221_show_alert, NULL, F_CF2);
> > -static SENSOR_DEVICE_ATTR(curr3_crit_alarm, S_IRUGO,
> > -		ina3221_show_alert, NULL, F_CF3);
> > -
> > -/* warning current */
> > -static SENSOR_DEVICE_ATTR(curr1_max, S_IRUGO | S_IWUSR,
> > -		ina3221_show_current, ina3221_set_current, INA3221_WARN1);
> > -static SENSOR_DEVICE_ATTR(curr2_max, S_IRUGO | S_IWUSR,
> > -		ina3221_show_current, ina3221_set_current, INA3221_WARN2);
> > -static SENSOR_DEVICE_ATTR(curr3_max, S_IRUGO | S_IWUSR,
> > -		ina3221_show_current, ina3221_set_current, INA3221_WARN3);
> > -
> > -/* warning current alert */
> > -static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO,
> > -		ina3221_show_alert, NULL, F_WF1);
> > -static SENSOR_DEVICE_ATTR(curr2_max_alarm, S_IRUGO,
> > -		ina3221_show_alert, NULL, F_WF2);
> > -static SENSOR_DEVICE_ATTR(curr3_max_alarm, S_IRUGO,
> > -		ina3221_show_alert, NULL, F_WF3);
> > -
> > -/* shunt voltage */
> > -static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO,
> > -		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT1);
> > -static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
> > -		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT2);
> > -static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
> > -		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
> > -
> >  static struct attribute *ina3221_attrs[] = {
> > -	/* channel 1 -- make sure label at first */
> > -	&sensor_dev_attr_in1_label.dev_attr.attr,
> > -	&sensor_dev_attr_in1_enable.dev_attr.attr,
> > -	&sensor_dev_attr_in1_input.dev_attr.attr,
> > -	&sensor_dev_attr_curr1_input.dev_attr.attr,
> >  	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
> > -	&sensor_dev_attr_curr1_crit.dev_attr.attr,
> > -	&sensor_dev_attr_curr1_crit_alarm.dev_attr.attr,
> > -	&sensor_dev_attr_curr1_max.dev_attr.attr,
> > -	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
> > -	&sensor_dev_attr_in4_input.dev_attr.attr,
> > -
> > -	/* channel 2 -- make sure label at first */
> > -	&sensor_dev_attr_in2_label.dev_attr.attr,
> > -	&sensor_dev_attr_in2_enable.dev_attr.attr,
> > -	&sensor_dev_attr_in2_input.dev_attr.attr,
> > -	&sensor_dev_attr_curr2_input.dev_attr.attr,
> >  	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
> > -	&sensor_dev_attr_curr2_crit.dev_attr.attr,
> > -	&sensor_dev_attr_curr2_crit_alarm.dev_attr.attr,
> > -	&sensor_dev_attr_curr2_max.dev_attr.attr,
> > -	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
> > -	&sensor_dev_attr_in5_input.dev_attr.attr,
> > -
> > -	/* channel 3 -- make sure label at first */
> > -	&sensor_dev_attr_in3_label.dev_attr.attr,
> > -	&sensor_dev_attr_in3_enable.dev_attr.attr,
> > -	&sensor_dev_attr_in3_input.dev_attr.attr,
> > -	&sensor_dev_attr_curr3_input.dev_attr.attr,
> >  	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
> > -	&sensor_dev_attr_curr3_crit.dev_attr.attr,
> > -	&sensor_dev_attr_curr3_crit_alarm.dev_attr.attr,
> > -	&sensor_dev_attr_curr3_max.dev_attr.attr,
> > -	&sensor_dev_attr_curr3_max_alarm.dev_attr.attr,
> > -	&sensor_dev_attr_in6_input.dev_attr.attr,
> > -
> >  	NULL,
> >  };
> > -
> > -static umode_t ina3221_attr_is_visible(struct kobject *kobj,
> > -				       struct attribute *attr, int n)
> > -{
> > -	const int max_attrs = ARRAY_SIZE(ina3221_attrs) - 1;
> > -	const int num_attrs = max_attrs / INA3221_NUM_CHANNELS;
> > -	struct device *dev = kobj_to_dev(kobj);
> > -	struct ina3221_data *ina = dev_get_drvdata(dev);
> > -	enum ina3221_channels channel = n / num_attrs;
> > -	struct ina3221_input *input = &ina->inputs[channel];
> > -	int index = n % num_attrs;
> > -
> > -	/* Hide label node if label is not provided */
> > -	if (index == 0 && !input->label)
> > -		return 0;
> > -
> > -	return attr->mode;
> > -}
> > -
> > -static const struct attribute_group ina3221_group = {
> > -	.is_visible = ina3221_attr_is_visible,
> > -	.attrs = ina3221_attrs,
> > -};
> > -__ATTRIBUTE_GROUPS(ina3221);
> > +ATTRIBUTE_GROUPS(ina3221);
> >  
> >  static const struct regmap_range ina3221_yes_ranges[] = {
> >  	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
> > @@ -620,9 +582,9 @@ static int ina3221_probe(struct i2c_client *client,
> >  
> >  	dev_set_drvdata(dev, ina);
> >  
> > -	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> > -							   client->name,
> > -							   ina, ina3221_groups);
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
> > +							 &ina3221_chip_info,
> > +							 ina3221_groups);
> >  	if (IS_ERR(hwmon_dev)) {
> >  		dev_err(dev, "Unable to register hwmon device\n");
> >  		return PTR_ERR(hwmon_dev);
