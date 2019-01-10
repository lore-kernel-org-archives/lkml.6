Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D78213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urh8lFWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfAJVCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:02:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35283 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfAJVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:02:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so405275wmt.0;
        Thu, 10 Jan 2019 13:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KXzkQE71Ojgzq845NZ7S8VMrhXWBL4ySwrDtdAfE9po=;
        b=urh8lFWxAwpyCiEvfZSoRgNN7COLX+gDa0I6g/Myets7V6/+VbwgnkS0lsS3/1lZA9
         0nApJ2TuKBkOsxgoYXsGlMtE+OI/nJZs9feh/3pBmvRTIQr3UzakYb57/YMsG2qlXuGi
         r+Hy4q9oqT+7iKARNOgaVeA5hK5fcWN0QxbmuoXf/mgZtXZFgtoNjZZsC/+1My2iGkiQ
         yS2q3hATxJY+Q1filC7j2ZcL/t19zb4QTnrECXehOXlr7AU3ad6qTvRqlO19fepCG+xp
         NiBuevwS7JPGh8PofLMPrK236+nLEeMb1NZdza3QUeHYYBOaLPDxgV8OC8rh7IBjuxbw
         BxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KXzkQE71Ojgzq845NZ7S8VMrhXWBL4ySwrDtdAfE9po=;
        b=CDbODB9jnGlOcGnmaI6Vpg+esJxIPkp4B91F3jmRCq3NqSCkRV1cJsKCsSk0ujY5Bs
         9+GTXpFQN7+daIJZ04A4ZMlTCYkzlnHquecYObXmRK4+RfzVAqg1JhIYJNR4nHHpce7+
         0vjSzJr7nUIVMHys5ktRvdx/0rAPHeey1gUngeqDoudHgVqC+bthESE02INUT47zNT7C
         ey+YwF21JAtoWW/yH3GGAUeBzzbhey4VVqzMOEfnMd5ZqBZHDCeVt9y7rwUy9RBGbw42
         ySQn5Kuq48ZFSc73bQuVpch38z/mZOtm7229jK6PSmz5HpfvnfUc1QNymZX6wFHFvqk/
         dF3g==
X-Gm-Message-State: AJcUukc2iL06QvjZbeolU21a8ysRvg1UqmDulN8fkBV74UgU2A45ZK0G
        NqdunGdq4rrfTJIWw4yXtb2r6uZE
X-Google-Smtp-Source: ALg8bN7tN6w2ZxewGaDlbHYfFx2CC5kxWbDDbFp+whqBJgD5Ar2z50QCI06s3AHXRoAjn+61jdK33g==
X-Received: by 2002:a1c:a70a:: with SMTP id q10mr321831wme.58.1547154125686;
        Thu, 10 Jan 2019 13:02:05 -0800 (PST)
Received: from [192.168.1.18] (che161.neoplus.adsl.tpnet.pl. [83.31.2.161])
        by smtp.gmail.com with ESMTPSA id p139sm33060312wmd.31.2019.01.10.13.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 13:02:05 -0800 (PST)
Subject: Re: Generic RGB LED support was Re: [PATCH 2/2] leds: lp5024: Add the
 LP5024/18 RGB LED driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com> <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com> <20190105123146.GA16354@amd>
 <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com> <20190105221254.GA22322@amd>
 <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com>
 <70366f2a-aafd-174f-73ec-a8117133b7af@gmail.com>
 <b027299c-a24a-abeb-8f92-97c32c13290b@ti.com>
 <2c3425b0-70af-1f38-35ee-0af857bf0539@gmail.com>
 <a388f510-d0a4-e88b-cfa4-8c9f45f7252a@ti.com>
 <63713076-b111-316d-7e60-9b799ff22c0a@gmail.com>
 <f323ce2c-01f9-f474-4071-96c3c4ef2b24@ti.com>
 <0a163b0c-eabc-6cf0-c605-28622af3d31d@ti.com>
 <1594152a-4f57-e258-5c9c-e1b158c72932@gmail.com>
 <5972a548-89cd-18ab-4f62-dd26057cf444@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <155f0473-0be0-e8a2-7873-607e4e495a03@gmail.com>
Date:   Thu, 10 Jan 2019 22:02:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5972a548-89cd-18ab-4f62-dd26057cf444@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 8:58 PM, Dan Murphy wrote:
> On 1/10/19 1:23 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 1/10/19 1:46 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/8/19 3:25 PM, Dan Murphy wrote:
>>>> Jacek
>>>>
>>>> On 1/8/19 3:18 PM, Jacek Anaszewski wrote:
>>>>> Hi Dan,
>>>>>
>>>>> On 1/7/19 10:14 PM, Dan Murphy wrote:
>>>>>> Jacek
>>>>>>
>>>>>> On 1/7/19 2:59 PM, Jacek Anaszewski wrote:
>>>>>>> Dan,
>>>>>>>
>>>>>>> On 1/7/19 8:36 PM, Dan Murphy wrote:
>>>>>>>> Jacek
>>>>>>>>
>>>>>>>> On 1/7/19 1:13 PM, Jacek Anaszewski wrote:
>>>>>>>>> On 1/6/19 4:52 PM, Jacek Anaszewski wrote:
>>>>>>>>>> Hi Pavel,
>>>>>>>>>>
>>>>>>>>>> On 1/5/19 11:12 PM, Pavel Machek wrote:
>>>>>>>>>>> Hi!
>>>>>>>>>>>
>>>>>>>>>>>>> Grab yourself an RGB LED and play with it; you'll see what the
>>>>>>>>>>>>> problems are. It is hard to explain colors over email...
>>>>>>>>>>>>
>>>>>>>>>>>> Video [0] gives some overview of lp5024 capabilities.
>>>>>>>>>>>>
>>>>>>>>>>>> I don't see any problems in exposing separate red,green,blue
>>>>>>>>>>>> files and brightness for the devices with hardware support for
>>>>>>>>>>>> that.
>>>>>>>>>>>
>>>>>>>>>>> Well, that's what we do today, as three separate LEDs, right?
>>>>>>>>>>
>>>>>>>>>> No. It doesn't allow for setting color intensity by having
>>>>>>>>>> the color fixed beforehand. Below is relevant excerpt from
>>>>>>>>>> the lp5024 documentation. This is not something that can be
>>>>>>>>>> mapped to RGB color space, but rather to HSV/HSL, with the
>>>>>>>>>> reservation that the hardware implementation uses PWM
>>>>>>>>>> for setting color intensity.
>>>>>>>>>>
>>>>>>>>>> <quote>
>>>>>>>>>> 8.3.1.2 Independent Intensity Control Per RGB LED Module
>>>>>>>>>>
>>>>>>>>>> When color is fixed, the independent intensity-control is used to
>>>>>>>>>> achieve accurate and flexible dimming control for every RGB LED module.
>>>>>>>>>>
>>>>>>>>>> 8.3.1.2.1 Intensity-Control Register Configuration
>>>>>>>>>>
>>>>>>>>>> Every three consecutive output channels are assigned to their respective
>>>>>>>>>> intensity-control register (LEDx_BRIGHTNESS). For example, OUT0, OUT1,
>>>>>>>>>> and OUT2 are assigned to LED0_BRIGHTNESS, so it is recommended to
>>>>>>>>>> connect the RGB LEDs in the sequence as shown in Table 1. The LP50xx
>>>>>>>>>> device allows 256-step intensity control for each RGB LED module, which
>>>>>>>>>> helps achieve a smooth dimming effect.
>>>>>>>>>> </quote>
>>>>>>>>>>
>>>>>>>>>>> I don't have problem with that, either; other drivers already do
>>>>>>>>>>> that. He's free to use existing same interface.
>>>>>>>>>>>
>>>>>>>>>>> But that is insufficient, as it does not allow simple stuff, such as
>>>>>>>>>>> turning led "white".
>>>>>>>>>>>
>>>>>>>>>>> So... perhaps we should agree on requirements, first, and then we can
>>>>>>>>>>> discuss solutions?
>>>>>>>>>>>
>>>>>>>>>>> Requirements for RGB LED interface:
>>>>>>>>>>>
>>>>>>>>>>> 1) Userspace should be able to set the white color
>>>>>>>>>>>
>>>>>>>>>>> 2) Userspace should be able to arbitrary color from well known list
>>>>>>>>>>> and it should approximately match what would CRT, LCD or OLED monitor display
>>>>>>>>>>
>>>>>>>>>> The difference is that monitor display driver is pre-calibrated
>>>>>>>>>> for given display by the manufacturer. With the LED controllers the
>>>>>>>>>> manufacturer has no control over what LEDs will be connected to the
>>>>>>>>>> iouts. Therefore it should be not surprising that colors produced
>>>>>>>>>> by custom LEDs are not as user would expect when comparing to
>>>>>>>>>> the RGB color displayed on the monitor display.
>>>>>>>>>>
>>>>>>>>>> TI provides "Various LED Ring Lighting Patterns Reference Design" [0]
>>>>>>>>>> that show how to produce various patterns with use of the reference
>>>>>>>>>> board with LED ring built using sixteen 19-337/R6GHBHC-A01/2T LEDs [1].
>>>>>>>>>>
>>>>>>>>>> Document [0] mentions also specific "Design considerations" in the
>>>>>>>>>> chapter 2.2:
>>>>>>>>>>
>>>>>>>>>> <quote>
>>>>>>>>>> Several considerations are taken into account for this particular design:
>>>>>>>>>> • LED map (ring) for meeting the requirement of popular human-machine interaction style.
>>>>>>>>>> • LED size, numbers and the diffuse design for meeting lighting pattern uniformity.
>>>>>>>>>> • Analog dimming in the difference ambient light lux without losing dimming resolution in lighting pattern.
>>>>>>>>>>
>>>>>>>>>> These considerations apply to most human-machine interaction end equipment with day and night vision
>>>>>>>>>> designs in some way, but the designer must decide the particular considerations to take into account for a
>>>>>>>>>> specific design.
>>>>>>>>>> </quote>
>>>>>>>>>>
>>>>>>>>>> This renders your requirement 2) infeasible with use of custom LEDs
>>>>>>>>>> any fixed algorithm, since the final effect will always heavily depend
>>>>>>>>>
>>>>>>>>> Typo here: s/any fixed/and fixed/
>>>>>>>>>
>>>>>>>>>> on the LED circuit design.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>          2a) LEDs probably slightly change color as they age. That's out of
>>>>>>>>>>>          scope, unless the variation is much greater than on monitors.
>>>>>>>>>>>
>>>>>>>>>>>          2b) Manufacturing differences cause small color variation. Again,
>>>>>>>>>>>          that's out of scope, unless the variation is much greater than on
>>>>>>>>>>>          monitors.
>>>>>>>>>>>
>>>>>>>>>>> Nice to have features:
>>>>>>>>>>>
>>>>>>>>>>> 3) Full range of available colors/intensities should be available to
>>>>>>>>>>> userspace
>>>>>>>>>>>
>>>>>>>>>>> 4) Interface should work well with existing triggers
>>>>>>>>>>>
>>>>>>>>>>> 5) It would be nice if userland knew how many lumens are produced at
>>>>>>>>>>> each wavelength for each setting (again, minus aging and manufacturing
>>>>>>>>>>> variations).
>>>>>>>>>>>
>>>>>>>>>>> 6) Complexity of math in kernel should be low, and preferably it
>>>>>>>>>>> should be integer or fixed point
>>>>>>>>>>>
>>>>>>>>>>> Problems:
>>>>>>>>>>>
>>>>>>>>>>> a) RGB LEDs are usually not balanced. Setting 100% PWM on
>>>>>>>>>>> red/green/blue channels will result in nothing close to white
>>>>>>>>>>> light. In fact, to get white light on N900, blue and green channel's
>>>>>>>>>>> PWM needs to be set pretty low, as in 5%.
>>>>>>>>>>>
>>>>>>>>>>> b) LED class does not define any relation between "brightness" in
>>>>>>>>>>> sysfs and ammount of light in lumens. Some drivers use close to linear
>>>>>>>>>>> relation, some use exponential relation. Human eyes percieve logarithm
>>>>>>>>>>> of lumens. RGB color model uses even more complex function.
>>>>>>>>>>>
>>>>>>>>>>> c) Except for white LEDs, LEDs are basically sources of single
>>>>>>>>>>> wavelength of light, while CRTs and LCDs produce broader
>>>>>>>>>>> spectrums.
>>>>>>>>>>>
>>>>>>>>>>> d) RG, RGBW and probably other LED combinations exist.
>>>>>>>>>>>
>>>>>>>>>>> e) Not all "red" LEDs will produce same wavelength. Similar
>>>>>>>>>>> differences will exist for other colors.
>>>>>>>>>>>
>>>>>>>>>>> f) We have existing RGB LEDs represented as three separate
>>>>>>>>>>> monochromatic LEDs in sysfs.
>>>>>>>>>>
>>>>>>>>>> One general question: do you have any solutions in store?
>>>>>>>>>>
>>>>>>>>>> [0] http://www.ti.com/lit/ug/tiduee6/tiduee6.pdf
>>>>>>>>>> [1] http://www.everlight.com/file/ProductFile/19-337-R6GHBHC-A01-2T.pdf
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> I just wanted to point out that there are 4 total devices right now that use the same mapping
>>>>>>>>
>>>>>>>> LP5018, LP5024, LP5030 and the LP5036.
>>>>>>>>
>>>>>>>> I can implement what ever we would like to I just need to know what to design against.
>>>>>>>
>>>>>>> As you can see from the discussion in this thread it may take some
>>>>>>> time to work out the interface satisfying everyone. I made some design
>>>>>>> proposal, but Pavel had no warm word for it. It would be easier if
>>>>>>> we had more opinions.
>>>>>>
>>>>>> I got it from the threads and just the time invested in the FW and HSV.
>>>>>>
>>>>>>>
>>>>>>> How do you feel about using brightness file for setting LEDn_BRIGHTNESS?
>>>>>>
>>>>>> I am using that now.  The brightness file will adjust the overall brightness of the LED group
>>>>>> or bank pending on how the LEDs are grouped in the DT file.
>>>>>>
>>>>>>>
>>>>>>> Does increasing LEDn_BRIGHTNESS value (i.e. color intensity) feel like
>>>>>>> increasing color lightness (i.e. the pattern presented in the video [0]
>>>>>>> starting from 1:22)?
>>>>>>
>>>>>> No unfortunately this is why I introduced the new files to control the individual RGB intensities
>>>>>> so that the designers can set, tune, create color variations or patterns like the video.
>>>>>>
>>>>>> The RGB group brightness would be independent based on lighting conditions, enclosures and diffusers.
>>>>>> So you could technically be changing color and overall brightness virtually simultaneously
>>>>>
>>>>> Oh, so this is surprising. Now it gets even more obscure to me.
>>>>>
>>>>> It would be really helpful if we could see a video showing
>>>>> the LED effects with regard to the applied settings.
>>>>
>>>> Well I am doing a test off the command line to ensure the user space can interface with the RGB LED.
>>>>
>>>> I can ping someone in product development to see the application of this device if that would help.
>>>> We did give them a test driver to work on their features but told them the driver is not final until it
>>>> is in the mainline kernel
>>>>
>>>> Dan
>>>>
>>>>>
>>>>>>>> But keep in mind I still need to invest my time in the other TI-lmu patches on my list to complete.
>>>>>>>
>>>>>>> Do what you deem most suitable for you. We are here only to help
>>>>>>> merging the patches, but keeping in mind that kernel interface once
>>>>>>> introduced must be preserved forever. Therefore we need to do our
>>>>>>> best to make the best possible design decisions.
>>>>>>>
>>>>>>> [0] https://www.youtube.com/watch?v=qdt-alh8i6E
>>>>>>>
>>>>>>
>>>>>> I understand.  Maybe I can make the files generic to use for either control or individual control.
>>>>>>
>>>>>> We can probably define new ABI's until either HSV or DT frameworks get going.  And them make the file presentation
>>>>>> configurable and default to the new files.
>>>>>
>>>>> I am leaning towards it. Just commented on your patches.
>>>>>
>>>>
>>>>
>>>
>>> Asked the HW team for videos this is what they sent
>>> https://training.ti.com/lp50x-led-drivers-achieve-optimal-color-brightness-zero-audible-noise
>>> https://training.ti.com/how-configuring-led-brightness-color-and-patterns-lp50x-gui-tool
>>>
>>> Not sure how helpful these would be
>>
>> Thank you for the videos - they are helpful, and they confirm my first
>> impression regarding the LEDn_BRIGHTNESS effect. In is shown in the
>> second video starting from 3:37.
>>
>> This is the same what I was asking about previously (video [0] from
>> previous message starting from 1:22). For me this looks similarly
>> to increasing V of HSV or L of HSL [1].
>>
>> You denied, so either we interpret colors differently, or there was
>> some misunderstanding.
>>
>> [1] http://hslpicker.com
>>
> 
> Well I did indicate later that I could work on implementing against the HSV/RGB framework and fit that into

I just wanted to make sure that brightness file semantics fits
for this particular LEDn_BRIGHTNESS feature.
Now it is clear to me - yes it does.

For RGB LED modules brightness file would map to LEDn_BRIGHTNESS and
red,green,blue files would map to OUTn_COLOR registers.

For banks brightness file would map to BANK_BRIGHTNESS and
red,green,blue files would map to BANK_n_COLOR.

I wouldn't bother with cases when someone connects LEDs of
other colors - he is on his own then.

If you want to have the driver merged quickly then you can
use this interface. We will convert it to LED RGB class once
it is ready. I presume that the interface I outlined will be
supported by one of the brightness-mode's - I like the name
proposed by Vesa.

Effectively - no need to implement HSV algorithm in your driver.

> the LP5024 driver.  Only issue I see is mapping of the LED color to the correct output.  I know what is recommended
> in the data sheet but that does not mean that is what the developers will do.  We cannot always guarantee that
> the red LEDs will be on OUT0, OUT3, OUT6 or on BANK A
> 
> But it is not part of the LED class yet I would have to pull in the patch to enable it.
> 
> What is the thought on this?  Would the HSV/RGB class be pulled in as a part of the LP5024 driver?
> I don't want to put to much effort into code that will have to wait.
> 
> Dan
> 

-- 
Best regards,
Jacek Anaszewski
