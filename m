Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF127C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B4C20842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEQAxP38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfAMQhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:37:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37424 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfAMQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:37:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so16940705ljd.4;
        Sun, 13 Jan 2019 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dalIR2/3RXjdf0tAuWAfL9lo1TZlPeqfwTim2qoVeWk=;
        b=kEQAxP38FXUZZmIN0nwtqotddJPXVmBwUiOQvzOdCsNTy0imzL6GvZb4xq3m8CWL7S
         UNo/kDMdWJkH+srnoTF+rvEiMPXkqCzOkRhh66JflqZi9Xotu8X0u9sbJZdHFF0bKaqz
         Ksdb411lQgbuP6F8K0ITZ60usqTIb+jiuTnOpW/N9AxHIRsJcgSBlX+RvjdSh6VpYbAZ
         Dn/CNotVAyvN4bUDP2Iriv0q++xeM6ENGT0rDrg4dOdemwXl1oHkoO9Jubi0/fLIu55h
         hyZFOCgOCd5aWqc8eKDRdoO32EMcXZSDTAkYSaBapBWHJdhTZRsj/9TWT5eAiVQh82Lf
         J5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dalIR2/3RXjdf0tAuWAfL9lo1TZlPeqfwTim2qoVeWk=;
        b=a6RMY0ibRG+duKlB51jYqdNPcvPMo+vNGp2jx6wsHfDR4kcGjqW3zgllYs6TWrJm02
         l6rkozLWtK2zZfYKNhXaBkEM1keOqDJOlEBsHtHvf+yUA4hwiZQgBhFhO9ptkQNUMjMH
         tQg4dDCTIHaPrWnlt0x0RoqL7rPN1MXw/oLNv65R9RV8rK1+H0jbh2wUM7NDw7hJhUxh
         warvLgFXsBp4Q+7wZ/cPigFqWVFIvB8YV5YPxEuPFlPxNgBJR6dkm2wbf+0pzkBlQZ4q
         K73jSOoZHzHKx818ajLPp6znRWHMMkK0v51VS17d/IYCkiX7SxiWRyUvEbfwarJ3glKV
         d8Qw==
X-Gm-Message-State: AJcUuke7rxvBJK374ZwcFZcE0paBtnigi35dZmPzHmGa5PQXrvZdMaz7
        eJ6jBcKO1hQ18qSh33cGRcV1X111
X-Google-Smtp-Source: ALg8bN7SmT2z7Ga6DmgemVif/Py+Dz/q0FvR3NdFwJholxW68wcaB6x0f76THYl1t6UF7uoow3EpRQ==
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr4576559ljg.151.1547397452256;
        Sun, 13 Jan 2019 08:37:32 -0800 (PST)
Received: from [192.168.1.18] (chf153.neoplus.adsl.tpnet.pl. [83.31.3.153])
        by smtp.gmail.com with ESMTPSA id r10-v6sm17067640ljj.71.2019.01.13.08.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 08:37:31 -0800 (PST)
Subject: Re: Generic RGB LED support was Re: [PATCH 2/2] leds: lp5024: Add the
 LP5024/18 RGB LED driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com> <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com> <20190105123146.GA16354@amd>
 <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com> <20190105221254.GA22322@amd>
 <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com> <20190108225952.GA13299@amd>
 <1c53d379-64e5-4e72-5236-de8db77a5048@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1e37a036-bf46-5717-69e3-7cf9a1917fee@gmail.com>
Date:   Sun, 13 Jan 2019 17:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1c53d379-64e5-4e72-5236-de8db77a5048@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 1/9/19 8:11 AM, Vesa Jääskeläinen wrote:
> Hi Pavel,
> 
> On 09/01/2019 0.59, Pavel Machek wrote:
>> Hi!
>>
>>>>>> Grab yourself an RGB LED and play with it; you'll see what the
>>>>>> problems are. It is hard to explain colors over email...
>>>>>
>>>>> Video [0] gives some overview of lp5024 capabilities.
>>>>>
>>>>> I don't see any problems in exposing separate red,green,blue
>>>>> files and brightness for the devices with hardware support for
>>>>> that.
>>>>
>>>> Well, that's what we do today, as three separate LEDs, right?
>>>
>>> No. It doesn't allow for setting color intensity by having
>>> the color fixed beforehand. Below is relevant excerpt from
>>> the lp5024 documentation. This is not something that can be
>>> mapped to RGB color space, but rather to HSV/HSL, with the
>>> reservation that the hardware implementation uses PWM
>>> for setting color intensity.
>>
>> So they have feature where they have independent controls for each
>> channel, then one common control per three channels. Other chips have
>> common control for all the LEDs, for example. We don't support that
>> currently; lets focus on the RGB thing first.
>>
>>>> I don't have problem with that, either; other drivers already do
>>>> that. He's free to use existing same interface.
>>>>
>>>> But that is insufficient, as it does not allow simple stuff, such as
>>>> turning led "white".
>>>>
>>>> So... perhaps we should agree on requirements, first, and then we can
>>>> discuss solutions?
>>>>
>>>> Requirements for RGB LED interface:
>>>>
>>>> 1) Userspace should be able to set the white color
>>>>
>>>> 2) Userspace should be able to arbitrary color from well known list
>>>> and it should approximately match what would CRT, LCD or OLED 
>>>> monitor display
>>>
>>> The difference is that monitor display driver is pre-calibrated
>>> for given display by the manufacturer. With the LED controllers the
>>> manufacturer has no control over what LEDs will be connected to the
>>> iouts. Therefore it should be not surprising that colors produced
>>> by custom LEDs are not as user would expect when comparing to
>>> the RGB color displayed on the monitor display.
>>
>> It is true that _chip_ manufacturer can not know what LEDs will be
>> connected. But _system_ manufacturer can and should know that, and
>> should tell be able to tell us in the dts.
>>
>>> This renders your requirement 2) infeasible with use of custom LEDs
>>> any fixed algorithm, since the final effect will always heavily depend
>>> on the LED circuit design.
>>
>> Depending on LED circuit design and actual LEDs connected is okay.. we
>> just need to get information from _system_ designer (not chip
>> designer), and pass it to a place where color is computed.
>>
>>>> a) RGB LEDs are usually not balanced. Setting 100% PWM on
>>>> red/green/blue channels will result in nothing close to white
>>>> light. In fact, to get white light on N900, blue and green channel's
>>>> PWM needs to be set pretty low, as in 5%.
>>>>
>>>> b) LED class does not define any relation between "brightness" in
>>>> sysfs and ammount of light in lumens. Some drivers use close to linear
>>>> relation, some use exponential relation. Human eyes percieve logarithm
>>>> of lumens. RGB color model uses even more complex function.
>>>
>>> One general question: do you have any solutions in store?
>>
>> I played with LEDs on N900 over the weekend, yes.
>>
>> And getting reasonable colors seems to be possible, when a) and b) are
>> solved... a) seems to be more important than b).
>>
>> Now... this does not tell us how we should design kernel<->user
>> interface, but it should tell us that main goals - 1) and 2) are
>> possible.
> 
> I was thinking about this calibration and color correctness thing and I 
> am thinking a bit that it should be partly in kernel and partly in user 
> space.
> 
> For displays and printers there are defined icc-profiles that define how 
> colors are mapped to particular device in cases when you want to have 
> accurate color representation. In theory to get accurate LED output one 
> could model LEDs with icc profile and then pick your color and convert 
> it with icc profile to actual raw hardware values. Then this raw 
> hardware value could be written from user space to kernel.

icc-profiles idea sounds interesting. We would have to adjust hsv->rgb
algorithm to take the profiles into account. I wonder how that would
work in practice.

> In kernel we could provide raw hardware value support and in case of PWM 
> IC controlled LEDs we could provide curve mapping to linearize the 
> behavior of values entered to enable use in cases where close enough is 
> good enough.
> 
> Eg. if you want to have "white" then you have your color space picker 
> like sRGB(255,255,255). Then you would define icc profile it might 
> translate to hardware raw values 253%, 230%, 225%.

> Then you would write this to kernel with:
> 
> # set red, green and blue color elements
> echo "253 230 225" > color
> 
> In this case however behavior of brightness node is challening in 
> accuracy domain. Britghtness value 255 would of course provide 1:1 
> mapping in this case.
> 
> To go right to correct color and brightness at one go we could have 
> optional brightness at the end of color value array:
> 
> # set red, green and blue color element and brightness setting:
> echo "253 230 225 255" > color
> 
> If you want to have fancier behavior for brightness in your system then 
> we probably need to have configurable brightness model.
> 
> - hardware, like in lp5024 case would map to hardware register (would be 
> omitted if there is no such register)
> - onoff, would act like light switch ON/OFF eg. either configured value 
> or all zeroes.
> - scaled, would multiply the color elements
> - hsl, would use hsl formula
> - and this can be extended later with some other models and allows us to 
> start with with some models now.
> 
> We could define this in devicetree and from sysfs a bit like with trigger:
> 
> $ cat brightness_model
> [hardware] onoff scaled hsl
> 
> $ echo "hsl" > brightness_model
> 
> $ cat brightness_model
> hardware onoff scaled [hsl]
> 
> Then we could have "color_names" or such sysfs entry to determine allow 
> user space auto detection of led elements):
> 
> $ cat color_names
> red green blue
> 
> I suppose this model would provide flexibilty for multiple cases. Make 
> it simple for most uses, allow accuracy with icc profiles for advanced 
> users, would allow atomic color setting.
> 
> I have updated (not yet in github) my tests to use color array model and 
> color_names already and can play with brightness_model thing if this is 
> something that is good path?
> 
> What do you think?

-- 
Best regards,
Jacek Anaszewski
