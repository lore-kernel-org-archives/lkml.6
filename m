Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADAC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A891021D66
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A891021D66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeHINzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:55:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45796 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeHINzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:55:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so4812794wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzmZx5k35WRa7ixF1jvS3aZKSsjYqSAm9hl2zd/4/ds=;
        b=HNAB8GZf8Ib5kF7ooRMxBqLV19fzeWJqLiUdojRN2jM59X1vvI62pCmEjeGWC3N2GZ
         ivLzXdtU4yXJ6aS7rPW2eIvm8pT7wPKZIFaNr7c8znzOP4YcON7/XIqTKavsXFrQCx78
         GJX09MmbXmYVuM8lxOKf1gA1EdnwEie0yR+h91NyKx7rnDWP5wFAsIr2xcY1U826th8f
         FxMoQLGwB79d5yK0XcCgapncU9i1oAtWF0mhnqBv7eryPFX5YL0ckJbouDBz6L5cITXx
         wYsOXrv4+gHi99ox7HSAgFCcvfJzo2K9C7s162Hc7OU433caDMPem5f7KVU7Se5M8kzY
         DJvQ==
X-Gm-Message-State: AOUpUlHpinFozQZjdg0U780uf7xAZrjq9YFXvyNGRblbhlDrL+Au86oi
        UjSWUoRO0GyImDj+X1jlLB6Zhw==
X-Google-Smtp-Source: AA+uWPx13Ye9Oyvoevyeyx0fcgM/BR4X2fvOz/lgfAg2Ro/9+qtG4miAQO/keo5DmCXWX25O30ldiQ==
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr1245896wrc.251.1533814237192;
        Thu, 09 Aug 2018 04:30:37 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p12-v6sm4974735wrw.3.2018.08.09.04.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 04:30:36 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-5-hdegoede@redhat.com>
 <20180809110929.GD1634@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7b0b21db-affc-d198-ec86-fd20105222b9@redhat.com>
Date:   Thu, 9 Aug 2018 13:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180809110929.GD1634@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-08-18 13:09, Heikki Krogerus wrote:
> On Thu, Aug 09, 2018 at 11:15:58AM +0200, Hans de Goede wrote:
>> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
>> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
>> i2c-device.
>>
>> But in some rare cases the manufacturer has decided to describe multiple
>> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>>
>> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
>> code to support this corner-case.
>>
>> This commit introduces a new i2c-multi-instantiate driver which fixes this
>> in a different way. This new driver can be built as a module which will
>> only loaded on affected systems.
>>
>> This driver will instantiate a new i2c-client per I2cSerialBus resource,
>> using the driver_data from the acpi_device_id it is binding to to tell it
>> which chip-type (and optional irq-resource) to use when instantiating.
>>
>> Note this driver depends on a platform device being instantiated for the
>> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
>> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> 
> <snip>
> 
>> +static int i2c_multi_inst_probe(struct platform_device *pdev)
>> +{
>> +	struct i2c_multi_inst_data *multi;
>> +	const struct acpi_device_id *match;
>> +	const struct i2c_inst_data *inst_data;
>> +	struct i2c_board_info board_info = {};
>> +	struct device *dev = &pdev->dev;
>> +	struct acpi_device *adev;
>> +	char name[32];
>> +	int i, ret;
>> +
>> +	match = acpi_match_device(dev->driver->acpi_match_table, dev);
>> +	if (!match) {
>> +		dev_err(dev, "Error ACPI match data is missing\n");
>> +		return -ENODEV;
>> +	}
>> +	inst_data = (const struct i2c_inst_data *)match->driver_data;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +
>> +	/* Count number of clients to instantiate */
>> +	for (i = 0; inst_data[i].type; i++) {}
>> +
>> +	multi = devm_kmalloc(dev,
>> +			offsetof(struct i2c_multi_inst_data, clients[i]),
>> +			GFP_KERNEL);
>> +	if (!multi)
>> +		return -ENOMEM;
>> +
>> +	multi->num_clients = i;
>> +
>> +	for (i = 0; i < multi->num_clients; i++) {
>> +		memset(&board_info, 0, sizeof(board_info));
>> +		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
>> +		snprintf(name, sizeof(name), "%s-%s", match->id,
>> +			 inst_data[i].type);
>> +		board_info.dev_name = name;
>> +		board_info.irq = 0;
>> +		if (inst_data[i].irq_idx != -1) {
>> +			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
>> +			if (ret < 0) {
>> +				dev_err(dev, "Error requesting irq at index %d: %d\n",
>> +					inst_data[i].irq_idx, ret);
>> +				goto error;
> 
> This seems to assume that we always have GpioInt with assigned for
> these devices, but that's wrong. This needs to work with normal
> Interrupt type resources as well.
> 
> The TI USB PD controller instances (HID 3515) for exmaple have normal
> Interrupts assigned to them
> 
> Why not use the "irq_idx" with normal interrupts, and add a new member
> for the GpioInts, something like gpio_irq_idx?

I don't have any use-cases to test using normal interrupts, so I
will leave adding support for that to the first patch adding support
for a device which needs that, such as the HID3515 you mention.

I do agree that it is good to prepare for adding this later, so
I'm going to post a v6 doing s/irq_idx/gpio_irq_idx/

Regards,

Hans



> 
>> +			}
>> +			board_info.irq = ret;
>> +		}
>> +		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>> +		if (!multi->clients[i]) {
>> +			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>> +			ret = -ENODEV;
>> +			goto error;
>> +		}
>> +	}
>> +
>> +	platform_set_drvdata(pdev, multi);
>> +	return 0;
>> +
>> +error:
>> +	while (--i >= 0)
>> +		i2c_unregister_device(multi->clients[i]);
>> +
>> +	return ret;
>> +}
> 
> Thanks,
> 
