Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86533C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA142064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UzA3ehCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA142064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJBTP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:15:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59746 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJBTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:15:57 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w92CWekw088414;
        Tue, 2 Oct 2018 07:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538483560;
        bh=gMXKpHvULL0kp68l7nd5ECa/tLE+DrUQsL8GnygOmJk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UzA3ehCmPw8q3f9GX6SI58I8K6EvUVADxaS7fdksmkuDAyDnR9Tc2EMEQBoHJk+TC
         ExXx0Q5FgRiydnWSXZjeDxLCljTnlHwSxW6Or0WQl5868/JdWiC2Wd+mHeW5J5nPEk
         dnDUO0sAkWIQlBHSsOEmt40iz0FmR6w7JDXaupdw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w92CWe0Z032000;
        Tue, 2 Oct 2018 07:32:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 2 Oct
 2018 07:32:41 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 2 Oct 2018 07:32:41 -0500
Received: from [172.22.164.74] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w92CWePg025924;
        Tue, 2 Oct 2018 07:32:40 -0500
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
Date:   Tue, 2 Oct 2018 07:32:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002075629.GB19677@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 10/02/2018 02:56 AM, Pavel Machek wrote:
> On Fri 2018-09-28 13:29:46, Dan Murphy wrote:
>> From: Pavel Machek <pavel@ucw.cz>
>>
>> This adds backlight support for the following TI LMU
>> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>>
>> It controls LEDs on Droid 4
>> smartphone, including keyboard and screen backlights.
>>
>> Signed-off-by: Milo Kim <milo.kim@ti.com>
>> [add LED subsystem support for keyboard backlight and rework DT
>> binding according to Rob Herrings feedback]
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> [remove backlight subsystem support for now]
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> So... this driver adds support for LM3532, LM3631, LM3632, LM3633,
> LM3695 and LM3697 (or it did when I signed it off).

Yes I have to pull these out of the patch.

> 
> The rest of the series does not really bring any advantages (you claim
> it may add advantages in future). It takes code out of common driver
> and duplicates it.


I disagree.  Honestly using that ideallogy all LED drivers should use the common code
as it is a wrapper around regmap and a few if statements.

The 3632 adds the proper LED flash class support coupled with proper backlight support.
The 3633 adds the proper support for LV and HV LED support.

Duplicate code that I could find is put in the common file.
This patch set adds the LED devices as all other LED devices are added in the LED directory.

> 
> Could we take this patch, get the basic support for LM3532, LM3631,
> LM3632, LM3633, LM3695 and LM3697, and then split out the drivers when
> we actually gain some advantage doing so (and also when the costs are
> clear)?

We have debated this over and over and now we have 3 different implementations
available we need to collude on which one we want to support.

Jacek I defer to you and Pavel since you are both LED maintainers.

I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.

Dan

> 
> Thanks,
> 
> 								Pavel
> 
>>  drivers/leds/Kconfig             |   8 ++
>>  drivers/leds/Makefile            |   1 +
>>  drivers/leds/ti-lmu-led-common.c | 138 +++++++++++++++++++++++++++++++
>>  drivers/leds/ti-lmu-led-common.h |  54 ++++++++++++
>>  4 files changed, 201 insertions(+)
>>  create mode 100644 drivers/leds/ti-lmu-led-common.c
>>  create mode 100644 drivers/leds/ti-lmu-led-common.h
> 


-- 
------------------
Dan Murphy
