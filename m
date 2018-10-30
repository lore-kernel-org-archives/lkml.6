Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B8C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7220657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF7220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJaAVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:21:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55064 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeJaAVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:21:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so12217445wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uE3s+ozqng/e1H2fNFPeYSYLcb1UhwZgqLar/x1R4J0=;
        b=d+9xEAv73UNEf0exUucdYIq0DoaSbXlaMrBkk6nirzCVEn8uS0ZklofTYErQVji7Ag
         AwDyltP6rltL4wApuhX85fyhmUd92ZO3DUUeKaVva6RZLeeqzsHQQXBw5i4KDqLWhwqr
         kc0fldogKAtoN2+rDIPxcKGZQ8/RVwwDrakD/wfbfAZa63i7sdL5dQdDcFe2qTASq0Br
         fBTV1YI7amm6p5iqUHkIRRiStHl2xcXStR+rx4U1bfmPkIEAsno3Ax7f+GfgjSVb8ktl
         zXyRJvfgJ+m/AJhG3McMUvo2a3Kyk5g1BOqSGKGjn50j/kl8A7XbT9eoG3sLo6kUGWSr
         1z6w==
X-Gm-Message-State: AGRZ1gJdk7yFpbz+4G2ykeuRYWPhXy+AmuRj8RtoEqMWrh+Kd+zl/gPY
        YTSpmTX9iR8aJEOpEbB+jy6LZA==
X-Google-Smtp-Source: AJdET5ePwSaZfRezYtwiQByaGgWyJPRSUXYb74sZiy6H7E6HHGAB7KQwoKGOGE5Yh1JGETcRsbJYEQ==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr2248720wmf.33.1540913258361;
        Tue, 30 Oct 2018 08:27:38 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x139-v6sm27747482wme.3.2018.10.30.08.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:27:37 -0700 (PDT)
Subject: Re: [RFC][PATCH v1] ACPI / scan: Create platform device for BOSC0200
 ACPI nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Steven Presser <steve@pressers.name>,
        Bastien Nocera <hadess@hadess.net>
References: <20181030144706.6737-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e34f7c0-e747-7393-4b79-317b8483f0a6@redhat.com>
Date:   Tue, 30 Oct 2018 16:27:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181030144706.6737-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-10-18 15:47, Andy Shevchenko wrote:
> On some laptops the ACPI device with BOSC0200 _HID is representing
> two accelerometers under one node.
> 
> We add an ID to the I2C multi instantiate list to enumerate
> all I2C slaves correctly.

I believe that overall the approach here is correct, but I've
several (at least 4 different models) devices which use the
BOSC0200 _HID but with only 1 accelerometer / 1 I2cSerialBus
resource in the _CRS table.

So I believe that you need to add a new optional bool to
struct i2c_inst_data and ignore i2c_acpi_new_device()
returning NULL when this is set (and set it for the second
accelerometer).

i2c_unregister_device can handle NULL, so some entries
of the multi->clients[i] array ending up as NULL is not
a problem.

Hmm, I have just realized that there is another issue
which is a real problem, we have stuff like this:

[hans@shalem linux]$ ack BOSC0200 /lib/udev/hwdb.d/60-sensor.hwdb
sensor:modalias:acpi:BOSC0200*:dmi:*:svnHampoo:pnD2D3_Vi8A1:*
sensor:modalias:acpi:BOSC0200*:dmi:*:svnHampoo:pnX1D3_C806N:*
sensor:modalias:acpi:BOSC0200*:dmi:*:svn*CHUWIINNOVATIONANDTECHNOLOGY*:pnHi10protablet:*
sensor:modalias:acpi:BOSC0200*:dmi:*:svnHampoo:pnP02BD6_HI-122LP:*
# match the entire dmi-alias, assuming that the use of a BOSC0200 +
sensor:modalias:acpi:BOSC0200*:dmi:bvnAmericanMegatrendsInc.:bvr5.11:bd05/07/2016:svnDefaultstring:pnDefaultstring:pvrDefaultstring:rvnHampoo:rnCherryTrailCR:rvrDefaultstring:cvnDefaultstring:ct3:cvrDefaultstring:
sensor:modalias:acpi:BOSC0200*:dmi:bvnAmericanMegatrendsInc.:bvr5.11:bd05/28/2016:svnDefaultstring:pnDefaultstring:pvrDefaultstring:rvnHampoo:rnCherryTrailCR:rvrDefaultstring:cvnDefaultstring:ct3:cvrDefaultstring:
sensor:modalias:acpi:BOSC0200*:dmi:bvnINSYDECorp.:bvrjumperx.T87.KFBNEE*
sensor:modalias:acpi:BOSC0200*:dmi:*:svnJumper:pnEZpad:*:rvr.A006:*
sensor:modalias:acpi:BOSC0200:BOSC0200:dmi:*ThinkPadYoga11e3rdGen*
sensor:modalias:acpi:*BOSC0200*:dmi:*:svnLENOVO*:pn80XF:*
sensor:modalias:acpi:*BOSC0200*:dmi:*:svnLENOVO*:pn80XE:*
sensor:modalias:acpi:BOSC0200*:dmi:*:svnLINX*:pnLINX1010B:*

And using i2c-multi-instantiate will change the modalias from
acpi:BOSC0200 to i2c:bmc150_accel breaking this.

One way to fix this would be making sure we only use an
i2c:bmc150_accel modalias for the second device. This will
also allow differentiating between the 2 in hwdb quirks for
devices with 2 accelerometers. But the way we currently
generate modalias-es does not allow doing this in an
easy way. Making this possible will require some changes to
show_modalias() and i2c_device_uevent() in
drivers/i2c/i2c-core-base.c

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
> ---
> 
> The previous approach had been discussed at
> https://lore.kernel.org/lkml/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com/
> 
> This has an obvious regression as per commit 1911f48de0d9 ("iio: accel: bmc150:
> Add support for BOSC0200 ACPI device id") there are tables where under same ID
> we have different sets of the devices (luckily some of that is possible to
> autodetect):
> 
> - one accellerometer  (250e)
> - one accellerometer  (222e)
> - two accellerometers (???)
> 
> The proper enabling of the last case w/o a regression sounds like a DMI based
> data for I2C multi instantiate driver along with automatic selection of the latter
> whenever user selects bmc150-accel-i2c.c.

We can just use "bmc150_accel" everywhere without problems, i2c_device_id.driver_data
does get set by bmc150-accel-i2c.c but not used. i2c_device_id.name does get used
as the name for the iio-dev but that is purely cosmetic so we can simply use
"bmc150_accel" everywhere as the drivers/iio/accel/bmc150-accel-core.c code
will always auto-detect the actual type anyways. So this bit is not a problem
(unlike the modalias changing).

Regards,

Hans






> 
>   drivers/acpi/scan.c                          | 1 +
>   drivers/iio/accel/bmc150-accel-i2c.c         | 1 -
>   drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..a8cdae057a47 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1539,6 +1539,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>   	 * which i2c_device_id to use for each resource.
>   	 */
>   	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
> +		{"BOSC0200", },
>   		{"BSG1160", },
>   		{"INT33FE", },
>   		{}
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
> index 5456581b473c..8e763765a05e 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -100,6 +100,12 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct i2c_inst_data bosc0200_data[]  = {
> +	{ "bmc150_accel", -1 },
> +	{ "bmc150_accel", -1 },
> +	{}
> +};
> +
>   static const struct i2c_inst_data bsg1160_data[]  = {
>   	{ "bmc150_accel", 0 },
>   	{ "bmc150_magn", -1 },
> @@ -112,6 +118,7 @@ static const struct i2c_inst_data bsg1160_data[]  = {
>    * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>    */
>   static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
> +	{ "BOSC0200", (unsigned long)bosc0200_data },
>   	{ "BSG1160", (unsigned long)bsg1160_data },
>   	{ }
>   };
> 
