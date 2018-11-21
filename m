Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F8620685
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F8620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeKUWBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:01:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbeKUWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:01:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so5116794wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 03:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f3RQOLyXagZXuM7ZmhzNjXL7csrLTG/J53aEBpeQ/uw=;
        b=WqR/M7Gz/mTOrI10rvcLqGpZ1keywAUrICjY76UddstlEJbyVnESMadE7l8Cgv71ec
         qhwVAR0fM+ZHgJ3hT2fFR71tnG4gGLGAbbsIwuARM2D4r4EeF9/B0FUCOXDJVuJ4R8MU
         qPhIfK/NxnIHDDnpBRpSEImGVfgOTr1iEhA8Zkz35DGN6Mr2Kj6trCMgzAmSoEPKfPCC
         /EKyNc9dmx9Kvl9/TBOFfrYj2TcvnO/Ig+gNhwEVyldey7Eg7xYBmNyVB7M+ttxL0wQA
         ntL2Y4t2JqM9t+SRXYUH/F4xbyQh+FPDeknlDd2Kc1v2j1FE4LQDjzVMajupyoXYk09W
         XBsg==
X-Gm-Message-State: AGRZ1gLMJonF0EaGfMi1w3OJgJVTRWxD5bhjWPnvCGXzoy/fqOcTG1XP
        IH+fliGgQa3aa0+T5niGrush9bJNJok=
X-Google-Smtp-Source: AFSGD/VS9guIx3Ype6xyG6EY9FjUfPjW+92GXQ0dqHNgPEd0a96k5Inku88Z2C/s6ZebeopQGlSiPg==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr5265877wmd.15.1542799669676;
        Wed, 21 Nov 2018 03:27:49 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m65sm1108745wmb.4.2018.11.21.03.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:27:48 -0800 (PST)
Subject: Re: [PATCH v1 00/15] i2c-multi-instantiate: Adapt for INT3515 and
 alike
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <24f96a15-6b57-c19d-b77d-fdc6c11fddc9@redhat.com>
Date:   Wed, 21 Nov 2018 12:27:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-11-18 16:59, Andy Shevchenko wrote:
> Currently i2c-multi-instantiate driver does not support the case
> of INT3515 USB PD device, where:
> 
> - Interrupt() is used instead of GpioInt()
> - All slaves may be the same from IP point of view
> - There can be variadic amount of slaves
> 
> This series is addressing all above.
> 
> Notes:
> - series has been smoke tested (Heikki would do BAT or more) on Coffee Lake system
> - patch for BOSC0200 might be considered as RFC since the modalias potential issue

Yeah the BOSC0200 patch cannot go upstream as is, that will break the
orientation quirks in hwdb on:

[hans@shalem systemd]$ grep BOSC0200 hwdb/60-sensor.hwdb | wc -l
17
[hans@shalem systemd]$

At least 17 different models laptops / 2-in-1s

> The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
> In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.

Patches 1-5, 7-13 and 15 are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will send separate replies to:

[PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
[PATCH v1 14/15] ACPI / scan: Create platform device for BOSC0200 ACPI nodes

Which are both a NACK from me (in their current state) because they both will
cause regressions.

Regards,

Hans






> 
> Testing and comments are warmly welcome.
> 
> Andy Shevchenko (15):
>    platform/x86: intel_cht_int33fe: Remove duplicate NULL check
>    platform/x86: intel_cht_int33fe: Accept errors of
>      i2c_acpi_new_device()
>    platform/x86: i2c-multi-instantiate: Accept errors of
>      i2c_acpi_new_device()
>    platform/x86: i2c-mutli-instantiate: Defer probe when no adapter found
>    i2c: acpi: Return error pointers from i2c_acpi_new_device()
>    i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
>    i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
>    i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
>    platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
>    platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
>    platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
>    platform/x86: i2c-multi-instantiate: Allow to have same slaves
>    ACPI / scan: Create platform device for INT3515 ACPI nodes
>    ACPI / scan: Create platform device for BOSC0200 ACPI nodes
>    iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
> 
>   drivers/acpi/scan.c                          |  2 +
>   drivers/i2c/i2c-core-acpi.c                  | 43 +++++----
>   drivers/iio/accel/bmc150-accel-i2c.c         |  1 -
>   drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
>   drivers/platform/x86/i2c-multi-instantiate.c | 99 ++++++++++++++++----
>   drivers/platform/x86/intel_cht_int33fe.c     | 34 +++++--
>   drivers/usb/typec/tps6598x.c                 |  8 +-
>   include/linux/acpi.h                         | 11 +++
>   8 files changed, 158 insertions(+), 56 deletions(-)
> 
