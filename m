Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BA521019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKTg/t5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeLaPrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:47:21 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:38176 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLaPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:47:20 -0500
Received: by mail-lj1-f178.google.com with SMTP id c19-v6so23831873lja.5;
        Mon, 31 Dec 2018 07:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zVcgOXh0zrr6QnufeYacBM6Iy0OzipO3L3vkLNvy3Uc=;
        b=nKTg/t5zpkJhgUsiJwCjPctfF7lby2iRiIl8LrmaJ7ucEjHeKxjTDtQ1Ijo1rWvGIY
         GNwij/bhEl5oOWxzHtLYU4iBaN+6sxiBzWy8qn7pqY9JGBMYlMSbPpVhqIfRqEtICQ+D
         fQXnisnszUXrhM1+kKCl/eouCKNzBaW6WUfBlTR0BLcG8vr0p3oiTdm7mOSx6m6MaLJc
         mghioJbbC/um2da6QRC+Gn5x7IwRYMTgi4wLt13yEeuQSc8Uw9nrATpp03Tq1IZabdte
         kKyoSxKoPQPSKfjU9Cx7zGH3hY3kcEX5s03vOKNiJzm+tV6n2t/Ye66y0LTBr5QhpJrp
         i1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zVcgOXh0zrr6QnufeYacBM6Iy0OzipO3L3vkLNvy3Uc=;
        b=HY2K8sQJ1jYwLvpWGmLBPA3RI2TbTn4JOZECx12WVMbVB+esauWpo85TCwWRW8P7uL
         7ZkurDJEqXiIc6oTd4HnrhNHrQJMlrZV4yxn01Dm3gzhOyKJ4NegO3Xaz7HOX/hJdMeV
         FExb0gUhfAkhi1nnWjJ0bF/VfbeSvJ3i0deatH+KKMojTcuGI9aVheY+v4So1Wn6cqDq
         i0CmbGtHaYWBQjgWqChDvNjwDt4dDGHdiS4dJKSHSHiyTE333TO2M1zofTKW5/yu9waB
         vE/vdbFxR38r28otY6KIRwsVHV8rgzzG6RpIkzINBgL7dt3w9yrGyMMTK71HCW+IjJFw
         KDYg==
X-Gm-Message-State: AJcUukc6WDvR2dVBeCXDB2wfhEF3X96MyG61BRj5HLuDwbR8ag4wRJr7
        XPfalfaMVn0hz4xYbeFMMHljGbNX
X-Google-Smtp-Source: ALg8bN7Y159BeYKD3A5NatY9QrOWg0sm/EGaDVykrBVJQmGr9h0rKJ5mTugZqjUWZ1FcpCJKfYokbQ==
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr21245428lji.57.1546271237469;
        Mon, 31 Dec 2018 07:47:17 -0800 (PST)
Received: from [192.168.1.18] (dkq143.neoplus.adsl.tpnet.pl. [83.24.20.143])
        by smtp.gmail.com with ESMTPSA id y11-v6sm10185387ljc.85.2018.12.31.07.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 07:47:16 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
 <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com> <20181229190726.GA29851@amd>
 <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com> <20181230173505.GA19593@amd>
 <7763a3ae-343c-0fbe-da88-afce8459e4c2@gmail.com>
Message-ID: <9eafcf90-9083-ff42-e256-82d61991d610@gmail.com>
Date:   Mon, 31 Dec 2018 16:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <7763a3ae-343c-0fbe-da88-afce8459e4c2@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/18 4:43 PM, Jacek Anaszewski wrote:
> On 12/30/18 6:35 PM, Pavel Machek wrote:
>> On Sun 2018-12-30 18:09:35, Jacek Anaszewski wrote:
>>> On 12/29/18 8:07 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>> With the "color" sysfs file it will make more sense to allow for 
>>>>>>> user
>>>>>>> defined color palettes.
>>>>>>>
>>>>>>
>>>>>> I think defining these values in the device tree or acpi severely 
>>>>>> limits the devices
>>>>>> capabilities.  Especially in development phases.  If the knobs 
>>>>>> were exposed then the user space
>>>>>> can create new experiences.  The color definition should be an 
>>>>>> absolute color defined in the dt and
>>>>>> either the framework or user space needs to mix these 
>>>>>> appropriately.  IMO user space should set the policy
>>>>>> of the user experience and the dt/acpi needs to set the capabilities.
>>>>>>
>>>>>> I do like Pavels idea on defining the more standard binding 
>>>>>> pattern to "group" leds into a single group.
>>>>>>
>>>>>> Maybe the framework could take these groups and combine/group them 
>>>>>> into a single node with the groups colors.
>>>>>
>>>>> There is still HSV approach [0] in store. One problem with proposed
>>>>> implementation is fixed algorithm of RGB <-> HSV color space 
>>>>> conversion.
>>>>> Maybe allowing for some board specific adjustments in DT would add
>>>>> more flexibility.
>>>>>
>>>>> [0] https://lkml.org/lkml/2017/8/31/255
>>>>
>>>> Yes we could do HSV. Problem is that that we do not really have RGB
>>>> available. We do have integers for red, green and blue, but they do
>>>> not correspond to RGB colorspace.
>>>
>>> OK, so conversion from HSV to RGB would only increase the aberration.
>>> So, let's stick to RGB - we've got to have some stable ground and this
>>> is something that the hardware at least pretends to be compliant
>>> with.
>>
>> I'm not saying that we should stick to RGB. I'm just saying that
>> problem is complex.
>>
>> And no, hardware does not even pretend to be compliant with RGB color
>> model ( https://en.wikipedia.org/wiki/RGB_color_model ). In
>> particular, in RGB there is non-linear brightness curve.
> 
> Quotation from the wiki page you referred to:
> 
> "RGB is a device-dependent color model: different devices detect or
> reproduce a given RGB value differently, since the color elements (such
> as phosphors or dyes) and their response to the individual R, G, and B
> levels vary from manufacturer to manufacturer, or even in the same
> device over time. Thus an RGB value does not define the same color
> across devices without some kind of color management"
> 
> This claim alone leaves much room for the manufacturers to pretend that
> their devices are compliant with RGB model.
> 
> And the documentation of the hardware the discussed driver is for
> also refers to RGB model in many places - e.g. see Table 1, page 15
> in the document [0], where mapping of output triplets to an RGB module
> is shown.
> 
> One thing that I missed is that the discussed hardware provides
> LEDn_BRIGHTNESS registers for each RGB LED module, that can be
> configured to set color intensity in linear or logarithmic fashion.
> 
> Actually this stands in contradiction with RGB model, since
> change of "color intensity" means change of all RGB components.
> 
> We could use brightness file as for monochrome LEDs for that,

Here I mean brightness file in addition to the previously proposed
red, green and blue files.

> but we'd need to come up with consistent interface semantics
> for all devices, also those which don't have corresponding
> functionality. Probably this is the place where we could apply
> some RGB<->HSV conversion, as color intensity feels something
> more of HSV's saturation and value.
> 
> It would be good to hear from Dan how that looks in reality
> in case of lp5024 device.
> 
>>> Our problem is how to set the color atomically. With HSV approach we
>>> were to obviate the problem by mapping brightness file to the "V"
>>> component of that color space, and write all H,S and V values to the
>>> hardware only on write to brightness file.
>>
>> I'm not sure how realistic the "atomic color" problem is. Computers
>> are way faster than human vision.
> 
> With LEDn_BRIGHTNESS registers of lp5024 it seems that we need the
> ability for grouping LEDs in triplets and be able to set their intensity
> with a single write operation.
> 
>> I believe problem to start with is the "white" problem. Setting
>> R=G=B=255 will _not_ result in anything close to white light on
>> hardware I have.
> 
> RGBW LED controllers solve this problem. For the devices without
> white/amber we cannot do more than the hardware allows for.
> 
> [0] http://www.ti.com/lit/ds/symlink/lp5024.pdf
> 

-- 
Best regards,
Jacek Anaszewski
