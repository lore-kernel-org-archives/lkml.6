Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD767C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1120870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaD9zuBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB1120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJJUox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:44:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33766 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:44:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id s4-v6so2555176plp.0;
        Wed, 10 Oct 2018 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8s7R2ZQX/fhFWw5FF5/E3oeI7TsyVWv/5ts7Vva8q0=;
        b=oaD9zuBwAE0oMQN9AkdV5oFK8QcL+/ojcAq4CyF/RLojpNJsz0cOGLtzlrZA+NZFdo
         18VTX8njprXH24yFZ5SpaX8vcfXnTdf6fCIgEW+HvS/v1p7fHzKlkIu0GropOT0EMuQy
         uJZKzMAOH6JyM9TCDPGY0vQZUnrVz5FtZxacRdOAlNLpAD0GeSg/WMncqUWRd/Df0vNA
         0Uh28tguy+lnDOBeRhk1akWNXqogykwKDB4IZ5hWkNz1xGnMbAqmHiNgF8R6leymEiFI
         cVf18mhYBT6wf1ii11JeHIP+lxSXVjTjb56wlsKBkXwsrso78yKK3Cj0zh/vf0KVCLxu
         Qy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8s7R2ZQX/fhFWw5FF5/E3oeI7TsyVWv/5ts7Vva8q0=;
        b=tmKxtW2kIi/5FoukljO9UKWhqBYUB609GJHMvLXc+ZSnunlgoDfCZZy88KyIIJ8I6t
         PUK424Mol63lHHAMLGiKdlRSItqJwW3X0YuzCKriDgY+J8YBqpwWEJNWpAr/S/cgVeIz
         WBPOLhisZx1COrbrmQmwQQ/Wqja01sfTpobnb34JNJ27Uh5VVMwymNx7zbjGjOLE3Y5E
         EVW3lrz2pHP/6JNmPMDKU0tO3+Kspo2BzdYW7iCIcG4BMlM6aC0ppAxR+SKg6NyXzVSE
         vz1sqi4GTz0wyZRnPToDTbqkH/JgLHn5PNK7JnF4xRAThCTbzHHEMOMH1vW3aOx9OhU4
         Lnkw==
X-Gm-Message-State: ABuFfohuNSYDAZOABDNqEaiOeXOPB3z6pzr/YQYkAdlgvhnHIn/CJVXi
        2DtvjcWVLKJ4vSD+kcnxeEX+C94L
X-Google-Smtp-Source: ACcGV637T/LCja/rPjbCW/O7TAnL+rLdFZ3fd7lpleds7c9E4vti5blCw/D6LE8LQIQNRTESjKWdDQ==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr32935701plq.77.1539177761795;
        Wed, 10 Oct 2018 06:22:41 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t69-v6sm31881114pgd.43.2018.10.10.06.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:22:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
Date:   Wed, 10 Oct 2018 06:22:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010043310.30873-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 10/09/2018 09:33 PM, Nicolin Chen wrote:
> The hwmon core now has a new optional mode interface. So this patch
> just implements this mode support so that user space can check and
> configure via sysfs node its operating modes: power-down, one-shot,
> and continuous modes.
> 

One-shot mode on its own does not make sense or add value: It would require
explicit driver support to trigger a reading, wait for the result, and
report it back to the user. If the intent here is to have the user write the
mode (which triggers the one-shot reading), wait a bit, and then read the
results, that doesn't make sense because standard userspace applications
won't know that. Also, that would be unsynchronized - one has to read the
CVRF bit in the mask/enable register to know if the reading is complete.
The effort to do all this using CPU cycles would in most if not all cases
outweigh any perceived power savings. As such, I just don't see the
practical use case.

power-down mode effectively reinvents runtime power management (runtime
suspend/resume support) and is thus simply unacceptable.

I am open to help explore adding support for runtime power management
to the hwmon subsystem, but that would be less than straightforward and
require an actual use case to warrant the effort.

As such, NACK, sorry.

Thanks,
Guenter

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   drivers/hwmon/ina3221.c | 64 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index d61688f04594..5218fd85506d 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -77,6 +77,28 @@ enum ina3221_channels {
>   	INA3221_NUM_CHANNELS
>   };
>   
> +enum ina3221_modes {
> +	INA3221_MODE_POWERDOWN,
> +	INA3221_MODE_ONESHOT,
> +	INA3221_MODE_CONTINUOUS,
> +	INA3221_NUM_MODES,
> +};
> +
> +static const char *ina3221_mode_names[INA3221_NUM_MODES] = {
> +	[INA3221_MODE_POWERDOWN] = "power-down",
> +	[INA3221_MODE_ONESHOT] = "one-shot",
> +	[INA3221_MODE_CONTINUOUS] = "continuous",
> +};
> +
> +static const u16 ina3221_mode_val[] = {
> +	[INA3221_MODE_POWERDOWN] = INA3221_CONFIG_MODE_POWERDOWN,
> +	[INA3221_MODE_ONESHOT] = INA3221_CONFIG_MODE_SHUNT |
> +				     INA3221_CONFIG_MODE_BUS,
> +	[INA3221_MODE_CONTINUOUS] = INA3221_CONFIG_MODE_CONTINUOUS |
> +				    INA3221_CONFIG_MODE_SHUNT |
> +				    INA3221_CONFIG_MODE_BUS,
> +};
> +
>   /**
>    * struct ina3221_input - channel input source specific information
>    * @label: label of channel input source
> @@ -386,9 +408,51 @@ static const struct hwmon_ops ina3221_hwmon_ops = {
>   	.write = ina3221_write,
>   };
>   
> +static int ina3221_mode_get_index(struct device *dev, unsigned int *index)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	u16 mode = ina->reg_config & INA3221_CONFIG_MODE_MASK;
> +
> +	if (mode == INA3221_CONFIG_MODE_POWERDOWN)
> +		*index = INA3221_MODE_POWERDOWN;
> +	if (mode & INA3221_CONFIG_MODE_CONTINUOUS)
> +		*index = INA3221_MODE_CONTINUOUS;
> +	else
> +		*index = INA3221_MODE_ONESHOT;
> +
> +	return 0;
> +}
> +
> +static int ina3221_mode_set_index(struct device *dev, unsigned int index)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> +				 INA3221_CONFIG_MODE_MASK,
> +				 ina3221_mode_val[index]);
> +	if (ret)
> +		return ret;
> +
> +	/* Cache the latest config register value */
> +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_mode ina3221_hwmon_mode = {
> +	.names = ina3221_mode_names,
> +	.list_size = INA3221_NUM_MODES,
> +	.get_index = ina3221_mode_get_index,
> +	.set_index = ina3221_mode_set_index,
> +};
> +
>   static const struct hwmon_chip_info ina3221_chip_info = {
>   	.ops = &ina3221_hwmon_ops,
>   	.info = ina3221_info,
> +	.mode = &ina3221_hwmon_mode,
>   };
>   
>   /* Extra attribute groups */
> 

