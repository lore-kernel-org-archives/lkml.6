Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC328C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7657E2173B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTHN+XGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfAECiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:38:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42215 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAECh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:37:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so18194866plp.9;
        Fri, 04 Jan 2019 18:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNO0eJVD7QNizKwKpe2kxUQ5NL7c+qonse6H61Z/kaw=;
        b=sTHN+XGfCTbQzBMSWCx5gEpW4z/qXQDQS54/POtWuwfE3Wz7oXkFkuzBQ84d+TyXwg
         emsmv0L6cgxyT9s9FCnC5VRHpf3uQGLjweVVr/JWJgmqpQU8vfW/+DsC5W6M8Rq4yVk4
         Y0B0mLqsT7CMM39lmb/YhGLGdJuj/6Hd6PhEGouATAi0ahf25Z3XSyO18Pm7WrS2KEPW
         +DrpMUcw4A3n7iRLufOESV+tF5ntwGRvhhHhOnq0C5BkdqXFT16TaDM+OGmrllw7RHol
         CcCIWAPR6UqBgDTDDED6gvhhFOefEombmStl2rnSk9e98iy+gJgvxX4G8SNL5uw8i8Xg
         3FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNO0eJVD7QNizKwKpe2kxUQ5NL7c+qonse6H61Z/kaw=;
        b=jdPIHDPQtBbt1Ml56rvBPJ2H3KcJ7qc30pwlPaxNWyovLyr01b+r4Vj8m4xQyQCqIp
         EpGsvENOCLGi112Kg3+gUndwHRtKxCTnsmeEC9rWvJIeeqm5swSmm1hxUVQY5YsPcV2k
         sWelxINyoWLA0ScbiFQKNvweIiGWP1lkPBRIcIzkFY2vFuUHPumct5QmPQUBt8Pq512w
         BY5SObYyx41z1UmyG2sNk/62xyk2pFMXoq1Iq3/noX2V7RsvmDa41eWR5fjGAAr/CVog
         EGe9LyHvuHYevVCHGj6kNIwX+Um+e6ip5P2k8g89/OjTvfEU94Fd0cJCYIoa40vJkgOO
         puEA==
X-Gm-Message-State: AJcUukdMKJDOkDGqMldTqQ/OMA1U+B6SVs1cbHrdxC2v/Ul8V3sHyNVp
        IFBlYuw4QL4dJJ8o08oUnynjaa5n
X-Google-Smtp-Source: ALg8bN7OJYaMRniNhO8zuFtn5dcVRyv9Cp4jm/BVrJQxIOaEjRv04VKlxwUa4H+mIxqtWOAv3HhBYw==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr55171860plb.125.1546655878445;
        Fri, 04 Jan 2019 18:37:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t90sm125054729pfj.23.2019.01.04.18.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 18:37:57 -0800 (PST)
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Implement ti,single-shot DT property
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190105004904.17947-1-nicoleotsuka@gmail.com>
 <20190105004904.17947-3-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c5d8771d-3274-6982-2f9f-903fd5310488@roeck-us.net>
Date:   Fri, 4 Jan 2019 18:37:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190105004904.17947-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 4:49 PM, Nicolin Chen wrote:
> By default, ina3221, as a hardware monitor, continuously measures
> the inputs and generates corresponding data. However, for battery
> powered devices, this mode might be power consuming.
> 
> The DT binding doc is updated with a new boolean type property to
> allow changing the default operating mode from consuming mode to
> single-shot mode, which will measure input on demand and then shut
> down to save power.
> 
> So this patch implements the DT property accordingly.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   drivers/hwmon/ina3221.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e90ccac8bebb..152735659e19 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -91,6 +91,12 @@ enum ina3221_channels {
>   	INA3221_NUM_CHANNELS
>   };
>   
> +enum ina3221_modes {
> +	INA3221_MODE_SINGLE_SHOT,
> +	INA3221_MODE_CONTINUOUS,
> +	INA3221_NUM_MODES,

Is NUM_MODES used anywhere ? Please drop unless there is a reason to keep it.

Guenter

> +};
> +
>   /**
>    * struct ina3221_input - channel input source specific information
>    * @label: label of channel input source
> @@ -111,6 +117,7 @@ struct ina3221_input {
>    * @inputs: Array of channel input source specific structures
>    * @lock: mutex lock to serialize sysfs attribute accesses
>    * @reg_config: Register value of INA3221_CONFIG
> + * @mode: Operating mode -- continuous or single-shot
>    */
>   struct ina3221_data {
>   	struct device *pm_dev;
> @@ -119,6 +126,7 @@ struct ina3221_data {
>   	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
>   	struct mutex lock;
>   	u32 reg_config;
> +	enum ina3221_modes mode;
>   };
>   
>   static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
> @@ -188,6 +196,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>   		if (!ina3221_is_enabled(ina, channel))
>   			return -ENODATA;
>   
> +		/* Write CONFIG register to trigger a single-shot measurement */
> +		if (ina->mode == INA3221_MODE_SINGLE_SHOT)
> +			regmap_write(ina->regmap, INA3221_CONFIG,
> +				     ina->reg_config);
> +
>   		ret = ina3221_wait_for_data(ina);
>   		if (ret)
>   			return ret;
> @@ -232,6 +245,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>   		if (!ina3221_is_enabled(ina, channel))
>   			return -ENODATA;
>   
> +		/* Write CONFIG register to trigger a single-shot measurement */
> +		if (ina->mode == INA3221_MODE_SINGLE_SHOT)
> +			regmap_write(ina->regmap, INA3221_CONFIG,
> +				     ina->reg_config);
> +
>   		ret = ina3221_wait_for_data(ina);
>   		if (ret)
>   			return ret;
> @@ -617,6 +635,9 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
>   	if (!np)
>   		return 0;
>   
> +	if (of_property_read_bool(np, "ti,single-shot"))
> +		ina->mode = INA3221_MODE_SINGLE_SHOT;
> +
>   	for_each_child_of_node(np, child) {
>   		ret = ina3221_probe_child_from_dt(dev, child, ina);
>   		if (ret)
> @@ -654,6 +675,9 @@ static int ina3221_probe(struct i2c_client *client,
>   		}
>   	}
>   
> +	/* Hardware default uses the continuous mode */
> +	ina->mode = INA3221_MODE_CONTINUOUS;
> +
>   	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
>   		ina->inputs[i].shunt_resistor = INA3221_RSHUNT_DEFAULT;
>   
> @@ -666,6 +690,10 @@ static int ina3221_probe(struct i2c_client *client,
>   	/* The driver will be reset, so use reset value */
>   	ina->reg_config = INA3221_CONFIG_DEFAULT;
>   
> +	/* Clear continuous bit to use single-shot mode */
> +	if (ina->mode == INA3221_MODE_SINGLE_SHOT)
> +		ina->reg_config &= ~INA3221_CONFIG_MODE_CONTINUOUS;
> +
>   	/* Disable channels if their inputs are disconnected */
>   	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
>   		if (ina->inputs[i].disconnected)
> 

