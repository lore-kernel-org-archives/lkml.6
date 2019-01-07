Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D08C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA325206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ89IFDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfAGTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:13:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36212 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:13:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so1315875ljk.3;
        Mon, 07 Jan 2019 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N/xr4f0uEjvh8U2NSLZRnLKIapDMmUbiM1biX8KG98U=;
        b=VJ89IFDbldEAkfNjF63yIkIhLkVf/J+WU623s6dMb4YnemJM6rrlPsISextt6hTYhE
         nWfF6N3F0ysU2jYV621ESXESdnX9dWIy38lXsYjaaG6Qsv+1/Mf4uQAPfSpiYc4CzeYg
         4hyGCtT6jQ/MtxDrwRhFoY1WzqIoiZS0fiDOHkhlVMSNP6cmTzID6aVxXALCEGVWUcUS
         JO02xqeIMlbXIEiTcNiVMwQ3+dHx9Da0PcydZsGHTVQ0a52Pab8ZctsWyDG858CFbb7V
         9D3PBT6+5Vy93EqPbA/XpmfnwI1+hk+9z+V0ePkb7OitpgBx9EDRK4NMdVG144/VHqCj
         iCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/xr4f0uEjvh8U2NSLZRnLKIapDMmUbiM1biX8KG98U=;
        b=IB2RERYEWi6bC8oKhNSuUgplPYaFC3o7mVXRQ9jxklLuvEDifTsoMgj6yEwGCW0YPC
         KqDomdpxzcOYU2ssWpyKtrtPFQ3jzGIxkzaPL0dEJHy8RTrxoQDeVMmU4VCSIVfXuPz/
         qO55J7MNzGqpTcgeynmUh23Mq+nZ8t4uf/0ayQqb/gp3bDjuvjZxFFTRJ/codAfWR61J
         yQjTunUqewjSdVOHZlSOGq5Kep+h/+fzht8D2LdPY0XOtqppWsSB9kGDrLHwhHFl32PI
         kgI+L5nyRJD93DTiz54EE2+RPzunGGhEhW0G734cpMiOkb9RlqDmhX8dgnTof9UgPXNS
         iWDg==
X-Gm-Message-State: AJcUukdGv32E6utg7/tXtgDIFagvY1PaRplvtI+iwXKEsEXkF+tZ1k2r
        Kk40GBO0xpapLMl533oWDr12kvRa
X-Google-Smtp-Source: ALg8bN5io/G2UGfBu3L4cgPxShbCVioraWqnS+n6bxeI2tvlkDLdl5WVHMoBMr6OL7Aoabe5nulh3Q==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr34341754ljw.75.1546888426986;
        Mon, 07 Jan 2019 11:13:46 -0800 (PST)
Received: from [192.168.1.18] (dnq218.neoplus.adsl.tpnet.pl. [83.24.98.218])
        by smtp.gmail.com with ESMTPSA id c203sm12792936lfe.95.2019.01.07.11.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:13:46 -0800 (PST)
Subject: Re: Generic RGB LED support was Re: [PATCH 2/2] leds: lp5024: Add the
 LP5024/18 RGB LED driver
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com> <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com> <20190105123146.GA16354@amd>
 <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com> <20190105221254.GA22322@amd>
 <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com>
Message-ID: <70366f2a-aafd-174f-73ec-a8117133b7af@gmail.com>
Date:   Mon, 7 Jan 2019 20:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/19 4:52 PM, Jacek Anaszewski wrote:
> Hi Pavel,
> 
> On 1/5/19 11:12 PM, Pavel Machek wrote:
>> Hi!
>>
>>>> Grab yourself an RGB LED and play with it; you'll see what the
>>>> problems are. It is hard to explain colors over email...
>>>
>>> Video [0] gives some overview of lp5024 capabilities.
>>>
>>> I don't see any problems in exposing separate red,green,blue
>>> files and brightness for the devices with hardware support for
>>> that.
>>
>> Well, that's what we do today, as three separate LEDs, right?
> 
> No. It doesn't allow for setting color intensity by having
> the color fixed beforehand. Below is relevant excerpt from
> the lp5024 documentation. This is not something that can be
> mapped to RGB color space, but rather to HSV/HSL, with the
> reservation that the hardware implementation uses PWM
> for setting color intensity.
> 
> <quote>
> 8.3.1.2 Independent Intensity Control Per RGB LED Module
> 
> When color is fixed, the independent intensity-control is used to
> achieve accurate and flexible dimming control for every RGB LED module.
> 
> 8.3.1.2.1 Intensity-Control Register Configuration
> 
> Every three consecutive output channels are assigned to their respective
> intensity-control register (LEDx_BRIGHTNESS). For example, OUT0, OUT1,
> and OUT2 are assigned to LED0_BRIGHTNESS, so it is recommended to
> connect the RGB LEDs in the sequence as shown in Table 1. The LP50xx
> device allows 256-step intensity control for each RGB LED module, which
> helps achieve a smooth dimming effect.
> </quote>
> 
>> I don't have problem with that, either; other drivers already do
>> that. He's free to use existing same interface.
>>
>> But that is insufficient, as it does not allow simple stuff, such as
>> turning led "white".
>>
>> So... perhaps we should agree on requirements, first, and then we can
>> discuss solutions?
>>
>> Requirements for RGB LED interface:
>>
>> 1) Userspace should be able to set the white color
>>
>> 2) Userspace should be able to arbitrary color from well known list
>> and it should approximately match what would CRT, LCD or OLED monitor 
>> display
> 
> The difference is that monitor display driver is pre-calibrated
> for given display by the manufacturer. With the LED controllers the
> manufacturer has no control over what LEDs will be connected to the
> iouts. Therefore it should be not surprising that colors produced
> by custom LEDs are not as user would expect when comparing to
> the RGB color displayed on the monitor display.
> 
> TI provides "Various LED Ring Lighting Patterns Reference Design" [0]
> that show how to produce various patterns with use of the reference
> board with LED ring built using sixteen 19-337/R6GHBHC-A01/2T LEDs [1].
> 
> Document [0] mentions also specific "Design considerations" in the
> chapter 2.2:
> 
> <quote>
> Several considerations are taken into account for this particular design:
> • LED map (ring) for meeting the requirement of popular human-machine 
> interaction style.
> • LED size, numbers and the diffuse design for meeting lighting pattern 
> uniformity.
> • Analog dimming in the difference ambient light lux without losing 
> dimming resolution in lighting pattern.
> 
> These considerations apply to most human-machine interaction end 
> equipment with day and night vision
> designs in some way, but the designer must decide the particular 
> considerations to take into account for a
> specific design.
> </quote>
> 
> This renders your requirement 2) infeasible with use of custom LEDs
> any fixed algorithm, since the final effect will always heavily depend

Typo here: s/any fixed/and fixed/

> on the LED circuit design.
> 
>>
>>      2a) LEDs probably slightly change color as they age. That's out of
>>      scope, unless the variation is much greater than on monitors.
>>
>>      2b) Manufacturing differences cause small color variation. Again,
>>      that's out of scope, unless the variation is much greater than on
>>      monitors.
>>
>> Nice to have features:
>>
>> 3) Full range of available colors/intensities should be available to
>> userspace
>>
>> 4) Interface should work well with existing triggers
>>
>> 5) It would be nice if userland knew how many lumens are produced at
>> each wavelength for each setting (again, minus aging and manufacturing
>> variations).
>>
>> 6) Complexity of math in kernel should be low, and preferably it
>> should be integer or fixed point
>>
>> Problems:
>>
>> a) RGB LEDs are usually not balanced. Setting 100% PWM on
>> red/green/blue channels will result in nothing close to white
>> light. In fact, to get white light on N900, blue and green channel's
>> PWM needs to be set pretty low, as in 5%.
>>
>> b) LED class does not define any relation between "brightness" in
>> sysfs and ammount of light in lumens. Some drivers use close to linear
>> relation, some use exponential relation. Human eyes percieve logarithm
>> of lumens. RGB color model uses even more complex function.
>>
>> c) Except for white LEDs, LEDs are basically sources of single
>> wavelength of light, while CRTs and LCDs produce broader
>> spectrums.
>>
>> d) RG, RGBW and probably other LED combinations exist.
>>
>> e) Not all "red" LEDs will produce same wavelength. Similar
>> differences will exist for other colors.
>>
>> f) We have existing RGB LEDs represented as three separate
>> monochromatic LEDs in sysfs.
> 
> One general question: do you have any solutions in store?
> 
> [0] http://www.ti.com/lit/ug/tiduee6/tiduee6.pdf
> [1] http://www.everlight.com/file/ProductFile/19-337-R6GHBHC-A01-2T.pdf
> 

-- 
Best regards,
Jacek Anaszewski
