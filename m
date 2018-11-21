Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF24C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4C214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F4C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeKUXDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:03:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53798 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeKUXDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:03:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so2092214wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHFhtVbEnLBXYnhHUNzQ0IjtYFRqTgrczo2iTeBsUS8=;
        b=fEMYcE5ynw9MsdzT68XjhgwSzAkF9k/Tu8rzT9bD14J7MfbmYnKKiMC4CqLJY939Y5
         hdtdSOuwFw2m6Q4rtmY6L5MqDXddq+xFj//tEf3jIDH6Mmif/Ja1z0ByeXK8IiCsfWQB
         yrdoVGDOUqXLbu/ONKhiFD3aYLVuyZ4c9REjs6aXvzd6ebNizGnBGuG7gX15C2R5llZ4
         VfvA2vqQtKwuNuPHQWmh4UWKiOX02FsVtu9qX+6KGRqhuQGEWcOtHn6RgRmplPJOWib+
         bvJsucN88Vh8Bh0IqzdZoUaqgANcF+/iYrpzKfDQded9dPWoDyjmDcp0+vQafs6JOm/L
         jmWQ==
X-Gm-Message-State: AA+aEWYBTbXFCZDiCx5ID9vybRhwdvirJTuaGi48pm7mBKFTcfIL5tTm
        fSQAykeVmBuVIXovDaodLpyOzg==
X-Google-Smtp-Source: AFSGD/XneKQRLM4/4zQBRTTunl4bIE7OzuwUEiutWY2BOgMq9M268HwqBs6CmBzKYZNGMhuMTHKLQA==
X-Received: by 2002:a7b:c044:: with SMTP id u4mr5556685wmc.50.1542803380053;
        Wed, 21 Nov 2018 04:29:40 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 78-v6sm898951wma.30.2018.11.21.04.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 04:29:39 -0800 (PST)
Subject: Re: [PATCH v1 14/15] ACPI / scan: Create platform device for BOSC0200
 ACPI nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Presser <steve@pressers.name>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-15-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <86b36781-a95f-f280-759a-c4865be603a2@redhat.com>
Date:   Wed, 21 Nov 2018 13:29:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120155924.10773-15-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 20-11-18 16:59, Andy Shevchenko wrote:
> On some laptops the ACPI device with BOSC0200 _HID is representing
> two accelerometers under one node.
> 
> We add an ID to the I2C multi instantiate list to enumerate
> all I2C slaves correctly.
> 
> For reference here is the relevant DSDT blurb from the Yoga 11e:
> 
> Device (ACC)
> {
> 	Name (_ADR, Zero)  // _ADR: Address
> 	Name (_HID, "BOSC0200")  // _HID: Hardware ID
> 	Name (_CID, "BOSC0200")  // _CID: Compatible ID
> 	Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> 	Name (_UID, One)  // _UID: Unique ID
> 	Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> 	{
> 		Name (RBUF, ResourceTemplate ()
> 		{
> 			I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
> 				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
> 				0x00, ResourceConsumer, , Exclusive,
> 			)
> 			I2cSerialBusV2 (0x0018, ControllerInitiated, 0x00061A80,
> 				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
> 				0x00, ResourceConsumer, , Exclusive,
> 			)
> 		})
> 		Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
> 	}
> 
> Reported-by: Jeremy Cline <jeremy@jcline.org>
> Cc: Steven Presser <steve@pressers.name>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

So as already discussed switching all devices which define a BOSC0200
device in their ACPI tables to using i2c-multi-instantiate.c will
break the orientation quirks in udev's hwdb since those go by
the modalias and this will change the modalias from acpi:BOSC0200:BOSC0200
to i2c:bmc150_accel

After our last discussion I've been thinking about this and I think the
best solution is something like this in drivers/acpi/scan.c:

#define I2C_MULTI_INST_FORCE      0x01

         static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
                 {"BOSC0200", },
                 {"BSG1160", },
                 {"INT33FE", I2C_MULTI_INST_FORCE},
                 {"INT3515", },
                 {}
         };
	const struct acpi_device_id *id = NULL;

         ...

	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to? */
	__acpi_match_device(device, i2c_multi_instantiate_ids, NULL, &id, NULL);
	if (id) {
		if (id->driver_data & I2C_MULTI_INST_FORCE)
			return false;

                 count = i2c_multi_inst_count_resources(device);
		if (count > 1)
			return false;
	}

This way we only move to a platform-device + i2c-multi-inst for BOSC0200
devices on devices which actually have multiple accelerometers defined
in the node, avoiding the problem of breaking hwdb for existing devices.

Note arguably the force flag should be set on all existing entries in
the i2c_multi_instantiate_ids, but at least the BSG1160 entry is expected
to always have multiple I2cSerialBus resources and I guess the same may
apply to the INT3515 case

The weird BYT/CHT INT33FE fake battery device is special and we always
need to not create an i2c-client for it, so that we ignore the
clkrate / speed from its bogus first and sometimes only I2cSerialBus resource.

Regards,

Hans







> ---
>   drivers/acpi/scan.c                          | 1 +
>   drivers/iio/accel/bmc150-accel-i2c.c         | 1 -
>   drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e9eda5558c1f..e46c877fa9f1 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1539,6 +1539,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>   	 * which i2c_device_id to use for each resource.
>   	 */
>   	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
> +		{"BOSC0200", },
>   		{"BSG1160", },
>   		{"INT33FE", },
>   		{"INT3515", },
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 8ffc308d5fd0..9d22a4d9d568 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -64,7 +64,6 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>   	{"BMA250E",	bma250e},
>   	{"BMA222E",	bma222e},
>   	{"BMA0280",	bma280},
> -	{"BOSC0200"},
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index efaf34cbbc7b..c90137d30a98 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -151,6 +151,12 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct i2c_inst_data bosc0200_data[]  = {
> +	{ "bmc150_accel" },
> +	{ "bmc150_accel" },
> +	{}
> +};
> +
>   static const struct i2c_inst_data bsg1160_data[]  = {
>   	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
>   	{ "bmc150_magn" },
> @@ -171,6 +177,7 @@ static const struct i2c_inst_data int3515_data[]  = {
>    * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>    */
>   static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
> +	{ "BOSC0200", (unsigned long)bosc0200_data },
>   	{ "BSG1160", (unsigned long)bsg1160_data },
>   	{ "INT3515", (unsigned long)int3515_data },
>   	{ }
> 
