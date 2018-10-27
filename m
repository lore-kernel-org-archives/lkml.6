Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929DC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682972082D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3hRr5qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682972082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJ1B4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 21:56:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43899 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1B4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 21:56:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so1882860plb.10;
        Sat, 27 Oct 2018 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OCRv4A0VJ9/qMPljWG2QE5nwjzDgigATOeOWkARuYp4=;
        b=j3hRr5qPNvYbzXYul9kMQcJzveqnDeNJBFX50oFC/JbY1lMlNGK1xH/njoGkOEf0Pm
         cJ3q9pYkpzxJvBgyze7oVWe7ZKU5VCCqnPwYQj0GR/+Nc0ApNuam9zr63+0npriOUXye
         IJsnE2FJWX1Mz/ZxpaJR8k53YsnET4xsnC/JVRkio5XvavzVNoEdt0ZrOqdmWWpB46/i
         neuRJ3VJAyX8kQPfHeRdR9wik+QhSkYrLwWOlbOTmaspSVXTGQRVlO5NNMfGdOeuigRF
         9/S3YBdlZmD287uHhEkJ7JQy0ge7H/kRJItL5kfXz9xMB1pM3XEHg6h/2Oul9Q38MxxZ
         /WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OCRv4A0VJ9/qMPljWG2QE5nwjzDgigATOeOWkARuYp4=;
        b=RMN4kbBQr8sqn1jQ3l8ulm9OHYnPVjgRoEWr7ffv9TxrcUGvxre4QBqAzs4KwG6q27
         QxTvRsiEBvGBKoAx3VM9gNytzTWt7U5nk3LnYjm2VnZyvlX02gjwSPBUsuBwlGJjY+cZ
         lJH4VHO5B4b/YIUT7R//DOsZ2trIIwSdG6i4fSX48e+L5WnHiCu8/Lv+rXfbleYVTVa6
         qgxAUFO9p4i3KMfN1kUl5eybqHVeeWxx2AqTA/a7shl9YX9ZNcOT6Gc4QECcwpPgRN+0
         CBTa6dbqKd8gVYVxEXdN/jMayT4b2F3o2LMx2v6JL70SUIaV2uP1mhEyMlwExT7KAYQH
         6sNw==
X-Gm-Message-State: AGRZ1gKQcJCVnry/KOudHIoiTiEsjvDL/c6Z+qR66Xrt/TAiRTDjs34I
        myVr+SxdKG6u6z1LlvLXOHw=
X-Google-Smtp-Source: AJdET5dtzkxWJDV8BSBDlVZtSmwvV18FlwU1EnUlkrNw45OdyhZMdHCWmnysFiyIZ/ly+Xo9uUCKrw==
X-Received: by 2002:a17:902:7802:: with SMTP id p2-v6mr7802914pll.170.1540660483738;
        Sat, 27 Oct 2018 10:14:43 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id b88-v6sm35081053pfc.150.2018.10.27.10.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 10:14:42 -0700 (PDT)
Date:   Sat, 27 Oct 2018 22:44:28 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181027171428.GA2503@himanshu-Vostro-3559>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-3-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540481742-23596-3-git-send-email-dan@emutex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:
> From: Nicola Lunghi <nicola.lunghi@emutex.com>
> 
> ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
> Squared board.
> 
> Add it to the driver.
> 
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> [javier@emutex.com: fix up commit message and one checkpatch warning]
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

[]

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id adc128_acpi_match[] = {
> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> +#endif

I'm curious about the naming conventions used for selecting 
an ACPI ID.

AFAIK, ACPI or PNP ID consists of *Vendor* ID + Product ID.

PNP ID: PNP Vendor IDs consist of 3 characters, each character being
an uppercase letter (A-Z).

ACPI ID: ACPI Vendor IDs consist of 4 characters, each character being
either an uppercase letter (A-Z) or a numeral (0-9).

In your case,

Vendor ID -> AANT (AAEON TECHNOLOGY INC. registered ACPI ID prefix)
http://www.uefi.org/ACPI_ID_List?search=AANT

Product ID -> 1280

How did you come up with 1280 ? And why AANT ? why not TXNW which is
registered ACPI prefix for TEXAS INSTRUMENTS ?
http://www.uefi.org/ACPI_ID_List?search=Texas+

Latest ACPI manuals says:

6.1.5 _HID (Hardware ID)
------------------------

This object is used to supply OSPM with the device’s Plug and Play
hardware ID.[1]

[1] "A Plug and Play ID or ACPI ID can be obtained by sending e-mail to
pnpid@microsoft.com."

A _HID object evaluates to either a numeric 32-bit compressed EISA type ID or a string. If a
string, the format must be an alphanumeric PNP or ACPI ID with no asterisk or other leading
characters.

A valid PNP ID must be of the form "AAA####" where A is an uppercase letter and # is a hex
digit. A valid ACPI ID must be of the form "NNNN####" where N is an uppercase letter or a
digit ('0'-'9') and # is a hex digit. This specification reserves the string "ACPI" for use only
with devices defined herein. It further reserves all strings representing 4 HEX digits for
exclusive use with PCI-assigned Vendor IDs.


Next question:

There are a lot drivers in iio/ using ACPI for device enumeration using
these IDs. For now, let's take an example of Bosch Sensors:

drivers/iio/accel/bmc150-accel-i2c.c:static const struct acpi_device_id bmc150_accel_acpi_match[] = {
drivers/iio/accel/bmc150-accel-i2c.c-   {"BSBA0150",    bmc150},
drivers/iio/accel/bmc150-accel-i2c.c-   {"BMC150A",     bmc150},
drivers/iio/accel/bmc150-accel-i2c.c-   {"BMI055A",     bmi055},
drivers/iio/accel/bmc150-accel-i2c.c-   {"BMA0255",     bma255},

drivers/iio/gyro/bmg160_i2c.c:static const struct acpi_device_id bmg160_acpi_match[] = {
drivers/iio/gyro/bmg160_i2c.c-  {"BMG0160", 0},
drivers/iio/gyro/bmg160_i2c.c-  {"BMI055B", 0},
drivers/iio/gyro/bmg160_i2c.c-  {},
drivers/iio/gyro/bmg160_i2c.c-};

drivers/iio/imu/bmi160/bmi160_i2c.c:static const struct acpi_device_id bmi160_acpi_match[] = {
drivers/iio/imu/bmi160/bmi160_i2c.c-    {"BMI0160", 0},
drivers/iio/imu/bmi160/bmi160_i2c.c-    { },
drivers/iio/imu/bmi160/bmi160_i2c.c-};
drivers/iio/imu/bmi160/bmi160_i2c.c-MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);

Bosch registered ACPI ID: BOSC
http://www.uefi.org/ACPI_ID_List?search=Bosch

Bosch registered PNP ID: BSG
http://www.uefi.org/PNP_ID_List?search=Bosch

So, how could we use PNP ID "BMI" which is registered prefix for
BENSON MEDICAL INSTRUMENTS COMPANY ?
http://www.uefi.org/PNP_ID_List?search=BMI

Product ID -> "160" is fine for bmi160 which uniquely identifies the
sensor device.

But shouldn't the prefix be "BSG0160" instead of "BMI0160" ?

When I wrote the driver for Bosch BME680, I followed the same guideline
as done everywhere else in the Bosch family:

drivers/iio/pressure/bmp280-i2c.c-      {"BMP0280", BMP280_CHIP_ID },
drivers/iio/pressure/bmp280-i2c.c-      {"BMP0180", BMP180_CHIP_ID },
drivers/iio/pressure/bmp280-i2c.c-      {"BMP0085", BMP180_CHIP_ID },
drivers/iio/pressure/bmp280-i2c.c-      {"BME0280", BME280_CHIP_ID },

Therefore, I used BME0680 for bosch bme680 sensor!

In OF matching, we use vendor prefixes and that looks more legimate:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/vendor-prefixes.txt

Dan,

These questions are not just for you but to rest of the community
members as well.

If there is something I misunderstood, then please let me know :)


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
