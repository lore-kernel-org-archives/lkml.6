Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00174C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B337520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="llJ4KHdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAPAVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:21:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51282 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfAPAVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:21:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G0L2gH120865;
        Tue, 15 Jan 2019 18:21:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547598062;
        bh=96YnxJH5gLYsDwPKudfM5GZQ9dX2slcPiSf1QaO604o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=llJ4KHdIa/MyPoCtBuEg8d8ZlEzMJXvzAaRdKctBgfBIPOnyX7AIEKCYym9OcmmA3
         9b9p2tXzrGCPeSlV2whYQ+tVIvPYxqA//MwBhnwbxoEIylEb8DOZRzeqhguOj0RpSV
         g8q2u6zEOxTr7TV1Ppn/1hseoyb8MzrQbRteSLVA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G0L2R8029676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 18:21:02 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 18:21:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 18:21:02 -0600
Received: from [172.22.73.223] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G0L2j8027651;
        Tue, 15 Jan 2019 18:21:02 -0600
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
Date:   Tue, 15 Jan 2019 18:20:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115222223.GA17363@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Pavel Thanks for the review it is always good to have your comments.

On 1/15/19 4:22 PM, Pavel Machek wrote:
> Hi!
> 
>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>> +XX - Do not care ignored by the driver
>>> +RR - is the 8 bit Red LED value
>>> +GG - is the 8 bit Green LED value
>>> +BB - is the 8 bit Blue LED value
>>> +
>>> +Example:
>>> +LED module output 4 of the LP5024 will be a yellow color:
>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>> +
>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>> +
>>> +LED banked RGBs of the LP5036 will be a white color:
>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>
>> This part with example cans remain in Documentation/leds if you
>>> like.
> 
> Does it actually work like that on hardware?

What?

> 
> Is it supposed to support "normal" RGB colors as seen on monitors?

Monitors are not an application for this part.

Data sheet indicates these are the target applications

LED Lighting, Indicator Lights, and Fun Lights for:
Smart Speaker
Smart Home Appliances
Video Doorbell
Electric Smart Lock
Smoke Detector
Set-Top Box
Smart Router
Handheld Devices

ie Echo, Ring

> 
> Because 100% PWM on all channels does not result in white on hardware
> I have.
> 

I don't know I am usually blinded by the light and have no diffuser over
the LEDs to disperse the light so when I look I see all 3 colors.

>>> +	} else {
>>> +		led_offset = (led->led_number * 3);
>>> +		red_reg = priv->mix_out0_reg + led_offset;
>>> +		green_reg = priv->mix_out0_reg + led_offset + 1;
>>> +		blue_reg = priv->mix_out0_reg + led_offset + 2;
>>> +	}
>>> +
>>> +	red_val = (mix_value & 0xff0000) >> 16;
>>> +	green_val = (mix_value & 0xff00) >> 8;
>>> +	blue_val = (mix_value & 0xff);
>>
>> I've been rather thinking about space separated list of decimal
>> "red green blue" values, but maybe this way it will be less
>> controversial. Let's if there will be other opinions.
> 
> We support maximum brightness > 255, so space separated is certainly
> better option than this.
> 

I was using the HSL picker URL that Jacek sent to me that gave me that idea
And there were comments about presenting a single file to control the color.
But that was probably lost in the noise of the email chain.

https://lore.kernel.org/patchwork/patch/1026514/

"Apart of that, I've been also mulling over if we shouldn't go for single
"color" sysfs file for setting r,g,b components at one go."

http://hslpicker.com/#e6e200

> But...
> 
> I believe we should have a reasonable design before we do something
> like this. There's no guarantee someone will not use lp50xx with just
> the white LEDs for example. How will this work? Plus existing hardware
> already uses three separate LEDs for RGB LED. Why not provide same
> interface?
> 

Which existing hardware?  Are they using this part?

<rant>
Why are we delaying getting the RGB framework or HSV in?
I would rather design against something you want instead of having
everyone complain about every implementation I post.
</rant>

It is not a normal RGB driver.  The device collates the individual RGB
clusters into a single brightness register and you can modify the intensity of the individual
LEDs via other registers.  If brightness is 0 then the cluster is OFF regardless of the color
set in the individual registers.

And the RGB clusters can be banked into a single RGB cluster group to
present a single register to control numerous RGB LED clusters.

> (Oh and don't try to say "sysfs is slow", without numbers).

Never said sysfs was slow.

Dan
> 
> Thanks,
> 									Pavel
> 


-- 
------------------
Dan Murphy
