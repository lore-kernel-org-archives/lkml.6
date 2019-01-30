Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD4EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2CB20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eZRgqpUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbfA3T7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:59:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53714 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbfA3T7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:59:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0UJxgxb113615;
        Wed, 30 Jan 2019 13:59:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548878382;
        bh=zvfRJknrDHIcRsKQceExcpFozfIp1joBR5g2o7OwTCA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eZRgqpUXybEMFUV7Dcn807d2aMreW4QJF4O/U2TH6ZBQ5fUpf6hzp/wNI2IOSSYyD
         8Tha1LJJpLWtVwF2ZBc2IXnNRxYoWBsAyajf+pe6RwGywUcqhSzsErQu3BGFDNEJuV
         FEwwwMkda3GI42cnIQ6Ybca9SZYWCPqOPkFkl17s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0UJxgaW094612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 13:59:42 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 30
 Jan 2019 13:59:41 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 30 Jan 2019 13:59:41 -0600
Received: from [172.22.83.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0UJxfBt020525;
        Wed, 30 Jan 2019 13:59:41 -0600
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190130183005.833-1-dmurphy@ti.com>
 <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
Date:   Wed, 30 Jan 2019 13:59:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/30/19 1:37 PM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> Thank you for the RFC.
> 
> One vital thing is missing - documentation of brightness file must
> be updated to define its semantics for LED multi color class.
> 
> Either we need brightness-model file returning only "onoff" option
> available, or, for time being, fix the max_brightness for LED multi
> color class to 1 (which will map to max intensity level for each color).
> 

I can make max_brightness default to 1 if not set by the LED driver.

But the LP50xx has brightness controls so setting max_brightness from the driver should over ride
the max of 1 in the upper level.  

For devices that do not support brightness as a separate control we can create a file called
max_brightness_<color> that defines the max that a specific color can be set to.  If max_brightness
is set to 1 then create max_brightness_<color>.  If max_brightness > 1 then do not create the files.

I don't think we have fully vetted the brightness-model yet so I prefer to omit
it and possibly introduce that later.

Dan

> Best regards,
> Jacek Anaszewski
> 
> On 1/30/19 7:30 PM, Dan Murphy wrote:
>> Add a documentation of LED Multicolor LED class specific
>> sysfs attributes.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../ABI/testing/sysfs-class-led-multicolor    | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
>> new file mode 100644
>> index 000000000000..19f8da9b150e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
>> @@ -0,0 +1,38 @@
>> +What:        /sys/class/leds/<led>/color/sync_enable
>> +Date:        January 2019
>> +KernelVersion:    5.0
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    read/write
>> +        Writing a 1 to this file will enable the sychronization of all
>> +        the defined color LEDs within the LED node.  Writing a 0 to
>> +        this file will disable syncing.
>> +
>> +What:        /sys/class/leds/<led>/color/sync
>> +Date:        January 2019
>> +KernelVersion:    5.0
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    write only
>> +        Writing a 1 to this file while sync_enable is set to 1 will
>> +        synchronize all defined LEDs within the LED node.  All LEDs
>> +        defined will be configured based on the brightness that has
>> +        been requested.
>> +
>> +        If sync_enable is set to 0 then writing a 1 to sync has no
>> +        affect on the LEDs.
>> +
>> +What:        /sys/class/leds/<led>/color/<led color>
>> +Date:        January 2019
>> +KernelVersion:    5.0
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    read/write
>> +        These files are dynamically created based on the colors defined
>> +        by the registrar of the class.
>> +        The led color(s) can be but not limited to red, green, blue,
>> +        white, amber and violet.  If sync is enabled then writing the
>> +        brightness value of the LED is deferred until a 1 is
>> +        written to /sys/class/leds/<led>/color/sync.  If syncing is
>> +        disabled then the LED brightness value will be written
>> +        immediately to the LED driver.
>> +
>> +        The value of the color is from 0 to
>> +        /sys/class/leds/<led>/max_brightness.
>>
> 


-- 
------------------
Dan Murphy
