Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9630A218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1FSwlGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfA3XDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:03:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46802 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA3XDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:03:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so831655lfc.13;
        Wed, 30 Jan 2019 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SMppWToWdF/okg8aWzrS8lnU7IPMd/C4DafPKikcecA=;
        b=g1FSwlGY/8H7t2tf5+pLOnTH0jMRG4Pl54BGk7DjC+ikVX5x1rALdVc8BA0MGhG4Lj
         L/yXhoGqTPvm4o/Ed2soA7JaV7a6b/kn/Lzu20Yj0kcqMmTVj4+uZIdYF80dwKNphMBu
         lfGTh4RA+QmmhPikSMb5DMcjc4dE5APGDlmLweArIMbD50avA/RFFJTbjMIztx1FHmhs
         eIXQno2bZwgkLFc/LotZjxFQlKc1TFJrWTVsY6iytFCtr1+bSBNK1P7DJEtnQTojYQOZ
         NUy7x3gMt3jx170up34FTjGOBMianAPUvk1FRigM1gbrbvwAfofarx/1N680xMd9ERR7
         mI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SMppWToWdF/okg8aWzrS8lnU7IPMd/C4DafPKikcecA=;
        b=A7zZe3QzkBjYCEOAv8bHhFWOxBXYMUCcOmN77+i++R40DKNxD/I34rvNM4MHuoD6c5
         w42p/vRIGQSPbxGLmvZvUwGYcU8X71jyh6diTDXT4I/FPJFu7SJF1rC/2i3HejCakZBT
         Q/UMO40Kcj8A8GkX4ek2QSAb/yydbydBWfo5KMoO8UDD0MtXXamzniy8J1T8tFGNut8B
         599Zc6z2iekU+USRyawhOW4Zd5AuvGZqLdE3aQQiSpo3U45+eRiIfGlwnFZT0BN8gVfn
         ASdLtQdZtJvG3w5X9lQIWma67ust9ZivfAHSyxQme3a7hYYceFntSchJQSQdE07Yje+G
         qCPQ==
X-Gm-Message-State: AJcUukfPCbUtq6L+ZgnWNITuF2WnZuX7PO3TtnRvGpZ5xdkj1FtXe9t0
        sUVRiscroLrv80Gd7Z1KA+dmImvl
X-Google-Smtp-Source: ALg8bN6AdNOLvwjHrX7jVch4pwzulRZKMTnVkHGjiKlQ+LqS77gRYYGhvszRvP4djuR4glhTCfG/WQ==
X-Received: by 2002:a19:6806:: with SMTP id d6mr24792271lfc.48.1548886475458;
        Wed, 30 Jan 2019 14:14:35 -0800 (PST)
Received: from [192.168.1.18] (dks71.neoplus.adsl.tpnet.pl. [83.24.22.71])
        by smtp.gmail.com with ESMTPSA id k21-v6sm464335ljc.15.2019.01.30.14.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:14:34 -0800 (PST)
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190130183005.833-1-dmurphy@ti.com>
 <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
 <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
 <c65ca84d-8054-2244-1899-e4a9cb0842da@gmail.com>
 <138450e2-9082-6986-a89b-0028dca0d365@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8b701a97-f945-488d-8bf3-d2efe400e30c@gmail.com>
Date:   Wed, 30 Jan 2019 23:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <138450e2-9082-6986-a89b-0028dca0d365@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 1/30/19 10:07 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/30/19 2:20 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 1/30/19 8:59 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/30/19 1:37 PM, Jacek Anaszewski wrote:
>>>> Hi Dan,
>>>>
>>>> Thank you for the RFC.
>>>>
>>>> One vital thing is missing - documentation of brightness file must
>>>> be updated to define its semantics for LED multi color class.
>>>>
>>>> Either we need brightness-model file returning only "onoff" option
>>>> available, or, for time being, fix the max_brightness for LED multi
>>>> color class to 1 (which will map to max intensity level for each color).
>>>>
>>>
>>> I can make max_brightness default to 1 if not set by the LED driver.
>>>
>>> But the LP50xx has brightness controls so setting max_brightness from the driver should over ride
>>> the max of 1 in the upper level.
>>
>> Yes, so the max_brightness should be updated basing on current
>> brightness-model. For LEDn_BRIGHTNESS of LP50xx we could have
>> "hw" or maybe even better just "lp50xx-linear" and "lp50xx-logarithmic"
>> - I just forgot about that capability of the device.
>>
> 
> OK maybe "hw" would make sense as there may be other devices that have dedicated brightness controls
> over color controls.

Single "hw" doesn't address both linear and logarithmic.
This is device specific, so I don't see anything wrong in
"lp50xx-*", provided that it will be documented.

> Probably need to create a model for non-modeled cases like "rgb-independent".  Dumb name but I could not
> think of anything better.

There is no point in having any rgb* brightness model since increasing
rgb in an arbitrary way will not give the impression of increasing color
intensity (lightness of the same hue). With DT defined hsl-<color>
ranges there is no way to verify that levels arrangement makes sense
with regard to preserving hue, this is a matter of trust. But we should
state that it is highly recommended to obey this constraint so as to
not mislead users.

>>> For devices that do not support brightness as a separate control we can create a file called
>>> max_brightness_<color> that defines the max that a specific color can be set to.  If max_brightness
>>> is set to 1 then create max_brightness_<color>.  If max_brightness > 1 then do not create the files.
>>
>> Right. We will need dedicated max_brightness for each color.
>> They should be placed also in the colors directory, next to the color
>> files.
>>
> 
> OK will document this.
> 
>>> I don't think we have fully vetted the brightness-model yet so I prefer to omit
>>> it and possibly introduce that later.
>>
>> We need to start from something. It will give better overview of the
>> whole idea.
>>
> 
> OK.  Don't get me wrong I don't oppose this idea I am just trying to figure out how the user space would
> know what models and brightness levels are available.

$ cat brightness-model
lp50xx-linear lp50xx-logarithmic onoff hsl-green hsl=blue

max_brightness will return available number of brightness levels
for each brightness model.

I'd not bother with presenting whole range of available color
presets. Userspace can verify the brightness->color mapping
by reading colors/<color> files after setting given brightness
level.

However, I'm not sure how useful it will be. This is a gist
of this whole discussion - we cannot be certain about exact
color effect produced with given settings.

> I mean we can read the brightness-models and present the available models but then how does the user know
> what and how many levels are in each model?  And how do we govern putting them in the right order?

`cat max_brightness` will return number of levels for the model
currently set. Regarding the order - we must rely on the DT array
arrangement. In case of hardware originated brightness model we
must trust hardware implementation.

> The DT file can get messed up, per the previous example
> rgb-green = <0x277c33 0x37b048 0x47e45d>;
> 
> This is assumed to be from dimmest to brightest.  But that is just an assumption
> 
> What if the entry looked like this?
> rgb-green = <0x37b048 0x277c33 0x47e45d>;

We can do nothing. It is just the cost of leaving some decisions to DT.

> Then echo 1 > brightness is not really a lower intensity then echo 2 > brightness.
> I know this is a product level issue but this can be misused and there is no way for maintainers
> or reviewers to really catch this error in code reviews.
> 
> The driver can map the brightness to the appropriate level requested by the class but again not
> sure how the user space can know what is available.  And there is nothing from stopping a
> definition of up to 2^32 brightness combinations.  This I know is unrealistic but the capability is there
> 
> I am wondering if there should be some sort of coefficient that can be defined that is
> applied to each color (no complex math).  I can see this working in a linear device but logrithimic
> maybe an issue.
> 
> Like
> 
> rgb-green = <0x277c33>;  //Coefficient used to set the dimmest allowed brightness for the color model.
> 
> echo 1 > brightness
> 
> red = 0x27
> green = 0x7c
> blue = 0x33
> 
> echo 2 > brightness
> 
> red = 0x28
> green = 0x7d
> blue = 0x34
> 
> echo 3 > brightness
> 
> red = 0x29
> green = 0x7e
> blue = 0x35
> 
> This example would give you 132 different brightness levels. green is the brightest defined color so the step calculation is
> 
> 255-124+1 = 132 (zero based) as 0 is off.
> 
> There can be a file called rgb_green_max which can be read to indicate how many brightness levels can be achieved.
> If the user goes beyond the steps then throw -EINVAL at them.
> 
> These brightness models probably should be put into a separate directory to isolate and not clutter the colors directory.
> And writing brightness to these models would be immediate no sync involved.

I intended that brightness-model location would be the main LED class
device directory.

And the whole concept is simple. We allow to set what we get from DT
or from the hardware. Without verification exceeding beyond
max_brightness values defined per iout.

-- 
Best regards,
Jacek Anaszewski
