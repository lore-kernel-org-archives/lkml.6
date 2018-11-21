Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD74CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBF021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBF021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeKUWeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:34:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbeKUWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:34:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so5216179wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsXj4F1FJjDwUvBqGL4oixqaMXYcUzCcXK7CwxlrjV0=;
        b=jWEgVfnSqDfNMtBpjux7Pf0nWmWkTsocduGrJkUUNVgTSyIQ5F8XJd04jpxEBzo+RT
         MxUdO5W/OUmK5hlY6PnBcCS3sLKoT7t4E9DtrTNDzBRXxnOT/lvWHkjHFtOPOxN51p8W
         EorVslnriww5o43Wot8CSeFWFzj2YbKBC1GNzL/lVcj/yBkTssO3uEDv6EGe+vs1CaPs
         CHJY0ftnfkdk6/QBRxsKcwn15FjJwDYpXAQD3JkeClpy2HXelp53dgrnGNIXYf/bWHIX
         rknb7JI2RkZrH2ITqX0cFYaja9nO7FuCm0buzZrujh+OVz4Q2BnWi7dS2P5ZjDTtVEzL
         hitQ==
X-Gm-Message-State: AA+aEWY93bmkGwO1pGrEnOk9fPlmXQAC2aZO/zPzaVI7iAu84gr5oZjY
        zuTca1NuLFChln1HQdpjdqFEXGzgPwg=
X-Google-Smtp-Source: AJdET5cIJC0DR2rGEESE26HrLxXJY5bJB7TpkhGsPvoLBw5B4eQLMxyXt1ckHquNcj7HGCTfJJwXdw==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr5557806wmc.106.1542801609450;
        Wed, 21 Nov 2018 04:00:09 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l3sm23583229wru.36.2018.11.21.04.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 04:00:08 -0800 (PST)
Subject: Re: [PATCH v1 00/15] i2c-multi-instantiate: Adapt for INT3515 and
 alike
From:   Hans de Goede <hdegoede@redhat.com>
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
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <24f96a15-6b57-c19d-b77d-fdc6c11fddc9@redhat.com>
Message-ID: <cdb902c7-324c-3f19-6caa-ff78132c593d@redhat.com>
Date:   Wed, 21 Nov 2018 13:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <24f96a15-6b57-c19d-b77d-fdc6c11fddc9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-11-18 12:27, Hans de Goede wrote:
> Hi,
> 
> On 20-11-18 16:59, Andy Shevchenko wrote:
>> Currently i2c-multi-instantiate driver does not support the case
>> of INT3515 USB PD device, where:
>>
>> - Interrupt() is used instead of GpioInt()
>> - All slaves may be the same from IP point of view
>> - There can be variadic amount of slaves
>>
>> This series is addressing all above.
>>
>> Notes:
>> - series has been smoke tested (Heikki would do BAT or more) on Coffee Lake system
>> - patch for BOSC0200 might be considered as RFC since the modalias potential issue
> 
> Yeah the BOSC0200 patch cannot go upstream as is, that will break the
> orientation quirks in hwdb on:
> 
> [hans@shalem systemd]$ grep BOSC0200 hwdb/60-sensor.hwdb | wc -l
> 17
> [hans@shalem systemd]$
> 
> At least 17 different models laptops / 2-in-1s
> 
>> The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
>> In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.
> 
> Patches 1-5, 7-13 and 15 are: >
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Correction, I also have some small remarks to patch 9:

[PATCH v1 09/15] platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources

Which will need to be addressed before you can add my Reviewed-by.

Regards,

Hans




> I will send separate replies to:
> 
> [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
> [PATCH v1 14/15] ACPI / scan: Create platform device for BOSC0200 ACPI nodes
> 
> Which are both a NACK from me (in their current state) because they both will
> cause regressions.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
>>
>> Testing and comments are warmly welcome.
>>
>> Andy Shevchenko (15):
>>    platform/x86: intel_cht_int33fe: Remove duplicate NULL check
>>    platform/x86: intel_cht_int33fe: Accept errors of
>>      i2c_acpi_new_device()
>>    platform/x86: i2c-multi-instantiate: Accept errors of
>>      i2c_acpi_new_device()
>>    platform/x86: i2c-mutli-instantiate: Defer probe when no adapter found
>>    i2c: acpi: Return error pointers from i2c_acpi_new_device()
>>    i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
>>    i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
>>    i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
>>    platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
>>    platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
>>    platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
>>    platform/x86: i2c-multi-instantiate: Allow to have same slaves
>>    ACPI / scan: Create platform device for INT3515 ACPI nodes
>>    ACPI / scan: Create platform device for BOSC0200 ACPI nodes
>>    iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
>>
>>   drivers/acpi/scan.c                          |  2 +
>>   drivers/i2c/i2c-core-acpi.c                  | 43 +++++----
>>   drivers/iio/accel/bmc150-accel-i2c.c         |  1 -
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
>>   drivers/platform/x86/i2c-multi-instantiate.c | 99 ++++++++++++++++----
>>   drivers/platform/x86/intel_cht_int33fe.c     | 34 +++++--
>>   drivers/usb/typec/tps6598x.c                 |  8 +-
>>   include/linux/acpi.h                         | 11 +++
>>   8 files changed, 158 insertions(+), 56 deletions(-)
>>
