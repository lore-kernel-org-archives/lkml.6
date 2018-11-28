Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A427620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A427620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeK2BWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:22:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38405 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeK2BWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:22:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so22240596ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 06:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BfesgYdO54q4pYgbRjAV6Quo3oYSaQvkZq0teuCDPQg=;
        b=dELrklI4qYSFKEJuAd6HYtmJkKb+mrVMIDjGzGrQOZdBe+UEuggPxSSdLk2KLvgKqb
         MEuUx8iqOCZSuh1fcqbyYCqe36iPA4Xf+K8nMeW5NXvcbfqnD2JL6Wep8ubMuTjj7F9X
         KFO6pYxruzeE5qCmyk4YO7ZrmVAX8q0wCmT3IcUQTM92UM5a385DWb8JYmppEW0p9gUT
         DGwNPex1V62OmyU5BllKD08V98OthMYlZr5iGLjFsFXh+/QpU8cw8mS86/bsB4vHYTCC
         CH2F72BURZ2aqqh4pc9IDOajZr8WYqtWg73ODU4VYjFrqTuW9LlgYwMY6dyi+j+SeNZi
         5Y2g==
X-Gm-Message-State: AGRZ1gJR+qJHRjMf40UbyVaG985d3LtY2sEVuorOrlrIVYYXJxUgMEZ/
        2EeQ6cd/VcKklF19iDWJ9QQMBej75/E=
X-Google-Smtp-Source: AJdET5dtcYaab6cHvJ1aCdVU6UPxkXxiwzSFwjnbd5zTRtp7Cj1VRhRdFi+j+Sn8TVv23dbm1zwtBQ==
X-Received: by 2002:a17:906:7805:: with SMTP id u5-v6mr27386285ejm.213.1543414832101;
        Wed, 28 Nov 2018 06:20:32 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o37sm1791575edc.32.2018.11.28.06.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 06:20:31 -0800 (PST)
Subject: Re: [PATCH v5 00/15] i2c-multi-instantiate: Adapt for INT3515 and
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
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <776a33a7-bea0-fac9-3dbd-e17223180623@redhat.com>
Date:   Wed, 28 Nov 2018 15:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-11-18 12:45, Andy Shevchenko wrote:
> Currently i2c-multi-instantiate driver does not support the case
> of INT3515 USB PD device, where:
> 
> - Interrupt() is used instead of GpioInt()
> - All slaves may be the same from IP point of view
> - There can be variadic amount of slaves
> 
> This series is addressing all above.
> 
> Note, series has been smoke tested (Heikki would do BAT or more)
> on Intel Coffee Lake system.
> 
> The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
> In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.
> 
> Testing and comments are warmly welcome.
> 
> In v5:
> - unmess with patches 3 and 4 (there were squashed by my mistake)
> - other than above no code change from v4

v5 looks good to me, you can add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

To the patches which don't have this yet.

Regards,

Hans




> 
> In v4:
> - directly return -EPROBE_DEFER from i2c_acpi_new_device()
> - due to above split error handling simplification to separate patches
> 
> In v3:
> - revisit error codes returned by i2c_acpi_new_device() (Hans, Mika)
> - add documentation to exported i2c_acpi_get_i2c_resource() (Mika)
> - drop Hans' Rb tag in patch 5 due to changes
> - append Mika's Ab tag to patch 6
> 
> In v2:
> - drop patches to copy fwnode and to handle BOSC0200 device
> - append check for amount of devices listed in the driver's mapping
> - add Rb tag given by Hans
> 
> Andy Shevchenko (15):
>    platform/x86: intel_cht_int33fe: Remove duplicate NULL check
>    platform/x86: intel_cht_int33fe: Accept errors of
>      i2c_acpi_new_device()
>    platform/x86: i2c-multi-instantiate: Accept errors of
>      i2c_acpi_new_device()
>    platform/x86: i2c-multi-instantiate: Defer probe when no adapter found
>    i2c: acpi: Return error pointers from i2c_acpi_new_device()
>    platform/x86: intel_cht_int33fe: Get rid of obsolete conditional
>    platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
>    i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
>    i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
>    platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
>    platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
>    platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
>    platform/x86: i2c-multi-instantiate: Allow to have same slaves
>    ACPI / scan: Create platform device for INT3515 ACPI nodes
>    iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
> 
>   drivers/acpi/scan.c                          |  1 +
>   drivers/i2c/i2c-core-acpi.c                  | 64 +++++++++----
>   drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
>   drivers/platform/x86/i2c-multi-instantiate.c | 97 ++++++++++++++++----
>   drivers/platform/x86/intel_cht_int33fe.c     | 20 ++--
>   drivers/usb/typec/tps6598x.c                 |  8 +-
>   include/linux/acpi.h                         | 11 +++
>   7 files changed, 157 insertions(+), 60 deletions(-)
> 
> --
> 2.19.2
> 
