Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF085C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D57620661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HjSAdxrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D57620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeHaQ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:27:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35652 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeHaQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VCJbvd122281;
        Fri, 31 Aug 2018 07:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535717977;
        bh=3jDHVqQlAi/fAtXslrO6jbOsWjYaYmRvrcbbqtGkOFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HjSAdxrwdX2YLSVL0Q32CxpmOYsoc+WlyZFm/QwkL0j6yzwBM6gdnakaIlJRb2LpR
         dd4ufHT279nGr35uTiaUQ9ueShCHPc8S+zLS1/eCuuVkCRmflgX1Zz/y8BdAHazY9U
         Ht7LMqGfge8O0G7U7zpaheM4Toz+53V2pTDwS1Ys=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VCJbGI022517;
        Fri, 31 Aug 2018 07:19:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 07:19:37 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 07:19:37 -0500
Received: from [172.22.190.205] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VCJbii015183;
        Fri, 31 Aug 2018 07:19:37 -0500
Subject: Re: [rfc] leds: add TI LMU backlight driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <jacek.anaszewski@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com> <20180830201825.GA1936@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
Date:   Fri, 31 Aug 2018 07:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830201825.GA1936@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 03:18 PM, Pavel Machek wrote:
> Hi!
> 
>>> Here's preview of driver for TI LMU. It controls LEDs on Droid 4
>>> smartphone, including keyboard and screen backlights.
>>>
>>> This adds backlight support for the following TI LMU
>>> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>>>
>>> Signed-off-by: Milo Kim <milo.kim@ti.com>
>>> [add LED subsystem support for keyboard backlight and rework DT
>>> binding according to Rob Herrings feedback]
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>> [remove backlight subsystem support for now]
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>
>>> ---
>>>
>>> Does it looks mostly reasonable? I guess it will need some
>>> s/BACKLIGHT/LEDS/ , and I'll need to remove my debugging hacks.
>>>
>>> I'd prefer this to be LED driver, first; I'll need to figure out what
>>> to do with backlight. I guess something like existing "backlight"
>>> trigger should do the trick.
>>>
>>
>> I looked at this driver from Milo before submitting a specific LM3697 driver.
> 
> Aha. I did not realize that was for same hardware... I should have
> cc-ed you, I guess.
> 

No worries Jacek cc'd me.

>> I do not like this driver.
>> I don't like that it smashes numerous devices into some structure with varying register maps.
>>
> 
> Can you elaborate? The chips are similar enough that single driver
> makes sense, and we certainly want to maintain one driver, not 6
> drivers differing only in .. what exactly?

Well I think it is justified to have independent drivers as each device has different features from
this basic LED driver.  If we are just looking for basic support then yes this driver is fine.

But here is where a single driver will start getting messy and support difficult

LM3533 has ALS and an ADC for an ALS analog sensor
LM3631 has no ALS functionality
LM3632 has strobe functionality and no ramp support
LM3633 has indicator support coupled with the hvled support
LM3695 does not even appear to be available publicly
LM3697 is the only device that that this driver could be used for as is.

In addition if I wanted to only support a single device I have to pull in the full data
file that defines all the other devices.  That is pretty bad to increase the size of the kernel
image to have support for devices that are not even on the target product.  The ti-lmu data file
alone is ~15k, the ti-lmu code does not even build with this patch (So this is a nack on the patch as it is.)
but commenting out the offending code gives me at least ~23k more data on top
of the ti-lmu MFD framework which is ~33k.  That is ~71k of code just to support 1 LED device
that is 3x what we have now.  That is not good for IoT devices.

The LM3697 is 22k without ramp support.

It may make sense for Droid 4 but not for most other customer products.  This is why I created the
LM3697 as a customer is only using that specific part on their end product so why would they want
to pull in data structures for 5 other devices?  It won't make sense for IoT devices as memory
real estate is critical.

And I will continue. TI LMU really means nothing unless you know what LMU stands for.  But this
also now implies support for all of TI's lighting products which will confuse the heck out of
customers and TI support staff.  We have a similar issue in our SoC sound CODECs code that we are
attempting to clean up.  We have a generic driver that is supposed to support a common set of features
but when extending support for other features the code gets very complicated and it is almost more
beneficial to re-write and create a new driver.

I would be OK with creating a ti-lmu framework that commonizes the functionality and create children that
register to that framework but even that is over kill.

> 
>> Not only that but it appears that you just pulled this driver from a repo and posted it without clean up.
>>
> 
> a) No I did not, feel free to generate a diff.
> 

No I looked at this driver before and determined a re-write was a waste of time.
If you look that the LM3697 driver I submitted it configures the banks via the config file.

Only the ramp code is missing and the code is much simpler in nature.  We could adopt that
code to extend out to the other devices as well and base the register map deltas on the 
device configuration file.  I am already using the fwnode calls and setting up the banks.


> b) Even if I did, why would that be a problem?

So what you are saying is all I have to do is look for other peoples work pull it in to a branch
slap a new copyright on it, push to a list and claim support?

I don't think you checked with the original author on pushing it upstream.  Milo has not updated
his email with a public one unless you sent him a private email and received and ack on pushing

> 
>> If the devices share register maps and can be added to families I would prefer to do it that way.
>>
>> So if the LM3695 and LM3697 share the same features and register map they should be one driver
>> The LM363x series may be able to be a different driver.
> 
> Well all 6 chips this driver supports seem to be similar enough, so
> that single driver makes sense.

See above on device differentiation. So in my opinion a single driver that supports
basic functionality is good but when adding additional support this driver will get very
complicated as to only allow different features for different devices.

Dan

> 
> Best regards,
> 								Pavel
> 


-- 
------------------
Dan Murphy
