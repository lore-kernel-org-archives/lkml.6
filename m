Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF37C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893772077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3ijgWQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893772077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIDTAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:00:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60762 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDTAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:00:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84EYoeh026872;
        Tue, 4 Sep 2018 09:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536071690;
        bh=cSu/BF+dGPzNAB9MeKiQMlZYuyxDIlv71Df8cozMGYI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s3ijgWQoz1CVvutgAibOf0acmlRtSE3QHkCGK0AzS1BU24ho2HnU2ncb9RtusjRlK
         b63Jst7ISUA63SZa6zOZ478BdBr1Axc/pta2veDI1/hvBAVwl8qME49ogymDlexg9e
         9yHar/60Dlc7VN8B17jUWpOuaH0eNWqnwSKCqELA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84EYovs007340;
        Tue, 4 Sep 2018 09:34:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 09:34:49 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 09:34:49 -0500
Received: from [172.22.182.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84EYnQI022127;
        Tue, 4 Sep 2018 09:34:49 -0500
Subject: Re: [rfc] leds: add TI LMU backlight driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <jacek.anaszewski@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com> <20180830201825.GA1936@amd>
 <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com> <20180831213030.GA23447@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d96eab23-dbd9-71a6-551e-2bc99ce4a57c@ti.com>
Date:   Tue, 4 Sep 2018 09:34:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831213030.GA23447@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 08/31/2018 04:30 PM, Pavel Machek wrote:
> Hi!
> 
>>> Aha. I did not realize that was for same hardware... I should have
>>> cc-ed you, I guess.
>>
>> No worries Jacek cc'd me.
> 
> Good.
> 
>>>> I do not like this driver.
>>>> I don't like that it smashes numerous devices into some structure with varying register maps.
>>>>
>>>
>>> Can you elaborate? The chips are similar enough that single driver
>>> makes sense, and we certainly want to maintain one driver, not 6
>>> drivers differing only in .. what exactly?
>>
>> Well I think it is justified to have independent drivers as each device has different features from
>> this basic LED driver.  If we are just looking for basic support then yes this driver is fine.
> 
>> But here is where a single driver will start getting messy and support difficult
>>
>> LM3533 has ALS and an ADC for an ALS analog sensor
>> LM3631 has no ALS functionality
>> LM3632 has strobe functionality and no ramp support
>> LM3633 has indicator support coupled with the hvled support
>> LM3695 does not even appear to be available publicly
>> LM3697 is the only device that that this driver could be used for as is.
> 
> Ok, so ... yes, I'm really interested in basic support. But drivers
> seem to have a lot in common, voltage limits, for example. 
> 
>> In addition if I wanted to only support a single device I have to pull in the full data
>> file that defines all the other devices.  That is pretty bad to increase the size of the kernel
>> image to have support for devices that are not even on the target product.  The ti-lmu data file
>> alone is ~15k, the ti-lmu code does not even build with this patch (So this is a nack on the patch as it is.)
>> but commenting out the offending code gives me at least ~23k more data on top
>> of the ti-lmu MFD framework which is ~33k.  That is ~71k of code just to support 1 LED device
>> that is 3x what we have now.  That is not good for IoT devices.
> 
>> The LM3697 is 22k without ramp support.
> 
> Well, I don't think object file size is huge problem. First,
> "distribution" kernel with support for 6 different chips will be ~71k,
> while your proposal will result in ~136k. Second, yes, we could put
> ifdefs into ti-lmu data file to make it smaller.
> 
> Anyway, clean source code and easy maintainance is more important.

I am going to reply here and snip the rest of the chain.

My proposal is to create a ti-lmu-led-common file that contains all the common
code.  We can have LED drivers use that common code to perform the common tasks.
This can then be extended to other devices past, present or future that have the
same feature set.

Then the register maps and LED registration can be contained in each LED driver and any additional features
can be supported in the LED driver.  The common code will retrieve any device settings from
the firmware that it is interested in.

I can throw some code together and RFC the code.  This way we get the common core for the
chips and not the bloat or messy source with a single driver.

And yes I can put this together and support it if it is needed.  I just need to go get the EVMs
so I can test it.

Thoughts?

<snip>-- 
------------------
Dan Murphy
