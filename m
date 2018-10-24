Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC8C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEDC20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SJrSM3x2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEDC20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJXUgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:36:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50082 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeJXUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:36:03 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9OC85ga032577;
        Wed, 24 Oct 2018 07:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540382885;
        bh=qFc2bDEeZzuiO2UxrbmIuUdWmg9mFwV3HEwD38vdQ3w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SJrSM3x2CWVJcIwD1ApnUxHlWMbJdNQVYG+qFdvcAWpKmH4vSes9OcxwwqgQXvmLW
         Jn29XqNiv1bfgG5jX9HM1pntUBm6THAuVN4uvv1hzm9EBRGSmChQB3C3i/Lymt+E4d
         pOelwXlxgGbSxeSfzAj33tOyS8wrlJ4slD7fAQKw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OC84kB030151;
        Wed, 24 Oct 2018 07:08:04 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 24
 Oct 2018 07:08:04 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 24 Oct 2018 07:08:04 -0500
Received: from [172.22.136.76] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OC847Q028800;
        Wed, 24 Oct 2018 07:08:04 -0500
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024090421.GB24997@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
Date:   Wed, 24 Oct 2018 07:07:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024090421.GB24997@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 10/24/2018 04:04 AM, Pavel Machek wrote:
> Hi!
> 
>> The LM3697 is a single function LED driver. The single function LED
>> driver needs to reside in the LED directory as a dedicated LED driver
>> and not as a MFD device.  The device does have common brightness and ramp
> 
> So it is single function LED driver. That does not mean it can not
> share bindings with the rest. Where the bindings live is not imporant.
> 

It can share bindings that are correctly done, not ones that are incomplete and incorrect.

Where bindings live is important to new Linux kernel developers and product 
developers looking for the proper documentation on the H/W bindings.

>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>> current LED and general bindings guidelines.
> 
> What you forgot to tell us in the changelog:

I can add this to the changelog.

> 
>> +Optional child properties:
>> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
>> +				the a higher brightness level.
>> +				Range from 2048 us - 117.44 s
> 
> The other binding uses "ramp-up-msec". Tell us why you are changing this, or
> better don't change things needlessly.
> 
> We don't want to be using "runtime-ramp-up-msec" for one device and
> "ramp-up-msec" for the other.

This is another example of how the original bindings were incorrect and misleading.

The LM3697 have 2 ramp implementations that can be used.

Startup/Shutdown ramp and Runtime Ramp.  Same Ramp rates different registers and
different end user experience.

So having a single node call ramp-up-msec is misleading and it does not
indicate what the H/W will do.

> 
> I'm not sure what other changes you did, and changelog does not tell
> me.
> 
>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>>    LM3632       Backlight and regulator
>>    LM3633       Backlight, LED and fault monitor
>>    LM3695       Backlight
>> -  LM3697       Backlight and fault monitor
>>  
>>  Required properties:
>>    - compatible: Should be one of:
> 
> NAK. You can use existing binding.

Thank you for the consistency

Dan

> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
