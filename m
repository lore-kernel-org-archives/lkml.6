Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC36C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D85621726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5gIP4Qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfAVVjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:39:54 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:36248 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAVVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:39:54 -0500
Received: by mail-lj1-f181.google.com with SMTP id g11-v6so52454ljk.3;
        Tue, 22 Jan 2019 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MLomtasu8kEScRX++LtYueqLaJ/IjSiV8uryMknPuRQ=;
        b=n5gIP4QzdeSYzt71UwyJ7j/BSNfNLEkctPa6mPyk0+oNfDVqzj7KLfDHy/+xloBf31
         zgZ31G8tmsoIKWLWEPU2hHUKI1vr/3MGkTeG25kxL9W7OK86bXyLr4GA5Jk4zTcTGuQi
         hvlcznH5e8HdY/qyhHnIznNJdc9C8BskAueXssMDbGGqFArX7j+2769NOKcpRlt2Ck1B
         2/TQ9aJD3yCNEPkvMuJuhNIFCJHlTE92YFr2WSiuTeM2RSlOUi2ArXbabXCDoitUR5LJ
         urncpKel4bjUls+m156H2sGePiiG/FshF2m66Yxp1tBPaVgKHkrm/pLMsVfJiC+uzjNs
         Ef1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MLomtasu8kEScRX++LtYueqLaJ/IjSiV8uryMknPuRQ=;
        b=DQb8HVuXITqYwOdFPgx0OaOzgrVaAw36AWq88R4tfVNLX6oy6HbdhgI1ftugbHKZHT
         im/e6mPcTAGfVR+KDaP9ofsvtcFQrLk9esTAwdVrVEdiJrrFw73Q/gf9mxJRKumGKavv
         GRGv5PXlc1TKXpxfQsaJ1dho8dvcwSQQFRd8FRKpM2e6Rkfn999EY1V/14sBRuYahhzx
         /cBsaVMaHm6jCEis7J9qG6JAh5Ti1fL2Jzum9XrwZvw9D+Fy/EuuMFRIYFKfxBXVJnoH
         6G9VUkSr3vK135mtiGFZzm2FeQ8oFknJg/ob1nmLKhhg3qUqCg1VMlGU3DDISsrOeuv4
         e1gw==
X-Gm-Message-State: AJcUukfWlcCFctrjMsiWVpgzg8THayNtcy+QjIh/nyDgGLYC7IBmy+PB
        v0WrCORGGxJlylOTyYQlm218y1b7
X-Google-Smtp-Source: ALg8bN6nbi2O3MxUHV1ZbKE5y96gdhqHK6UilWbmNlHMUlF4PPUzZDqtAGBa2b7RM2s5g3L1ujKMCA==
X-Received: by 2002:a2e:561d:: with SMTP id k29-v6mr21733191ljb.91.1548193190556;
        Tue, 22 Jan 2019 13:39:50 -0800 (PST)
Received: from [192.168.1.18] (drq236.neoplus.adsl.tpnet.pl. [83.24.202.236])
        by smtp.gmail.com with ESMTPSA id q2sm184569lfa.63.2019.01.22.13.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:39:49 -0800 (PST)
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com>
 <9f87e1ac-be66-2998-578c-de2c1794a00a@ti.com>
 <4a20b14c-9514-25b8-affe-20f9ede4d4d8@ti.com>
 <8fac6aeb-28a8-d136-c654-9d1b5d4f7ddb@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <27318c48-f84a-5129-ac88-545edd549101@gmail.com>
Date:   Tue, 22 Jan 2019 22:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8fac6aeb-28a8-d136-c654-9d1b5d4f7ddb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 1/20/19 7:42 AM, Vesa Jääskeläinen wrote:
> Hi Dan,
> 
> On 18/01/2019 15.58, Dan Murphy wrote:
>> Jacek
>>
>> On 1/18/19 7:45 AM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/17/19 3:10 PM, Jacek Anaszewski wrote:
>>>> Hi Dan,
>>>>
>>>> On 1/16/19 7:41 PM, Dan Murphy wrote:
>>>>> Hello
>>>>>
>>>>> On 1/16/19 4:55 AM, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>>>>>>>>> +XX - Do not care ignored by the driver
>>>>>>>>>> +RR - is the 8 bit Red LED value
>>>>>>>>>> +GG - is the 8 bit Green LED value
>>>>>>>>>> +BB - is the 8 bit Blue LED value
>>>>>>>>>> +
>>>>>>>>>> +Example:
>>>>>>>>>> +LED module output 4 of the LP5024 will be a yellow color:
>>>>>>>>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>>>>>>>>> +
>>>>>>>>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>>>>>>>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>>>>>>>>> +
>>>>>>>>>> +LED banked RGBs of the LP5036 will be a white color:
>>>>>>>>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>>>>>>>>
>>>>>>>>> This part with example cans remain in Documentation/leds if you
>>>>>>>>>> like.
>>>>>>>>
>>>>>>>> Does it actually work like that on hardware?
>>>>>>>
>>>>>>> What?
>>>>>>
>>>>>> If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
>>>>>> does it actually produce white? With all the different RGB modules
>>>>>> manufacturers can use with lp5024P?
>>>>>>
>>>>>> If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, 
>>>>>> does
>>>>>> it actually produce yellow, with all the different RGB modules
>>>>>> manufacturers can use with lp5024P?
>>>>>>
>>>>>
>>>>> I believe the answer to the general questions is no for any RGB 
>>>>> cluster and driver out there.
>>>>> Because if you set the same values on each and every RGB device out 
>>>>> there you will get varying shades of the color.
>>>>> But for this device yes the color does appear to be yellow to me 
>>>>> versus what was displayed on my monitor by the HSL picker.
>>>>> But everyone interprets colors differently.
>>>>>
>>>>> If you write the same value for yellow or white on a droid 4 and 
>>>>> the N900 do they produce the same color side by side?
>>>>> Most probably not.
>>>>>
>>>>> As you pointed out the PWM needs to be modified to obtain the 
>>>>> correct white color to account for LED and other device constraints.
>>>>>
>>>>> But we need to take into account the light pipe.  Pools nowadays 
>>>>> have RGB LED spot lights in them.  It can
>>>>> be set to white.  On my pool right off the lens the color has a 
>>>>> purplish hue to it.  As the light is diffracted into
>>>>> the pool the color becomes white.  The pool is clear.  When I add 
>>>>> chemicals to the pool and make it cloudy
>>>>> and turn on the lights the color off the lens is now white.  This 
>>>>> is an example on a large scale but the issue
>>>>> scales down to the hand helds and smart home applications.
>>>>>
>>>>> If the cluster is piped through a flexible optic 0xffffff may 
>>>>> produce the "white" you want on its output.
>>>>>
>>>>> So an expectation of certain color without proper piping based on a 
>>>>> single RGB value may be a little unreasonable.
>>>>> There may need to be a way to attenuate the values based on the 
>>>>> hardware aspect of the equation ie light pipe (or lack thereof) and 
>>>>> LED vendor.
>>>>> So if we write 0xffffff to the RGB driver the driver could adjust 
>>>>> the intensity of the individual LEDs based on the diffraction
>>>>> coefficients.
>>>>>
>>>>> I also think that is an unreasonable expectation here that writing 
>>>>> a single value to any LED RGB driver would produce
>>>>> a "rest of the world" absolute color.  Maybe it can produce 
>>>>> something similar but not identical.
>>>>> As you indicated in the requirements there is more involved here 
>>>>> then just the LED and the values written.
>>>>> The colors should be close but may not be identical.
>>>>>
>>>>> A 10 year old N900 should not be considered the gold standard for 
>>>>> color production due to advancements in LED,
>>>>> light pipe and LED driver technology.
>>>>> The single package RGB clusters on the board I am testing is about 
>>>>> the size of a single RGB LED from 10 years ago.
>>>>>
>>>>> I agree that the interface developed should work on the device but 
>>>>> the algorithm derived to obtain the color needs to have
>>>>> a hardware aspect to the calculation.
>>>>>
>>>>>>>> Is it supposed to support "normal" RGB colors as seen on monitors?
>>>>>>>
>>>>>>> Monitors are not an application for this part.
>>>>>>
>>>>>> You did not answer the question. When you talk about yellow, is it
>>>>>> same yellow the rest of world talks about?
>>>>>>
>>>>>
>>>>> See above.  It is close to what was on my monitor displayed.
>>>>>
>>>>>>>> Because 100% PWM on all channels does not result in white on 
>>>>>>>> hardware
>>>>>>>> I have.
>>>>>>>
>>>>>>> I don't know I am usually blinded by the light and have no 
>>>>>>> diffuser over
>>>>>>> the LEDs to disperse the light so when I look I see all 3 colors.
>>>>>>
>>>>>> How can we have useful discussion about colors when you don't see the
>>>>>> colors?
>>>>>>
>>>>>> Place a piece of paper over the LEDs....
>>>>>>
>>>>>
>>>>> Good suggestion for a rough test.
>>>>>
>>>>>>>> But...
>>>>>>>>
>>>>>>>> I believe we should have a reasonable design before we do something
>>>>>>>> like this. There's no guarantee someone will not use lp50xx with 
>>>>>>>> just
>>>>>>>> the white LEDs for example. How will this work? Plus existing 
>>>>>>>> hardware
>>>>>>>> already uses three separate LEDs for RGB LED. Why not provide same
>>>>>>>> interface?
>>>>>>>
>>>>>>> Which existing hardware?  Are they using this part?
>>>>>>
>>>>>> Nokia N900. They are not using this part, but any interface we invent
>>>>>> should work there, too.
>>>>>>
>>>>>
>>>>> Yes a common interface would be nice with some sort of hardware 
>>>>> tuning coefficient.
>>>>>
>>>>>>> <rant>
>>>>>>> Why are we delaying getting the RGB framework or HSV in?
>>>>>>> I would rather design against something you want instead of having
>>>>>>> everyone complain about every implementation I post.
>>>>>>> </rant>
>>>>>>
>>>>>> Because you insist on creating new kernel interfaces, when existing
>>>>>> interfaces work, and are doing that badly.
>>>>>>
>>>>>> Because your patches are of lower quality than is acceptable for 
>>>>>> linux
>>>>>> kernel.
>>>>>>
>>>>>> Because you don't seem to be reading the emails.
>>>>>>
>>>>>> I sent list of requirements for RGB led support. This does not meet
>>>>>> them.
>>>>>>
>>>>>
>>>>> Sigh.  You did not answer my question.
>>>>>
>>>>> Your requirements seem to be centered around monitors but that is 
>>>>> only one application of the current
>>>>> RGB LED landscape.
>>>>>
>>>>> I am willing to work with you on the HSV and adapting the LP50xx 
>>>>> part to this framework.
>>>>> Or any RGB framework for that matter.  I still don't agree with the 
>>>>> kernel needing to declare colors
>>>>>    maybe color capabilities but not specific colors.
>>>>
>>>> Dan, if you have a bandwidth for LED RGB class implementation
>>>> then please go ahead. It would be good to compare colors produced
>>>> by software HSV->RGB algorithm to what can be achieved with
>>>> LEDn_BRIGHTNESS feature.
>>>>
>>>> The requirements for LED RGB class as I would see it:
>>>>
>>>> sysfs interface:
>>>>
>>>> brightness-model: space separated list of available options:
>>>> - rgb (default):
>>>>    - creates color file with "red green blue" decimal values
>>>
>>> What about other colored LEDs?  Presenting RGB for an Amber LED does 
>>> not seem right.
>>> Should the LED color come from the DT?
>>>
>>
>> I thought about this, other non-RGB LEDs would not use the RGB framework.
>> But should they have the same interfaces as RGB?
>>
>> Should PWM control be a global interface?
> 
> In order to being able to set multi color element led at one go I would 
> recommend using then model:
> 
> color_names: "red green blue white"
> 
> echo "32 43 0 128" > color
> 
> This way all elements would be set at same time from user space point of 
> view.
> 
> This of course requires that it is part of the physical/logical led that 
> is being controlled. If it is a separate thing then it would logically 
> be differently controlled mono color led.
> 
> If you look what kinds of leds are available lets say from digikey you 
> get all kinds of combos:
> 
> - red, green, blue
> - red, green, blue, amber
> - red, green, blue, white
> - red, green, blue, white - cool
> - red, green, blue, white - neutral
> - red, green, blue, white - warm
> - red, orange
> - purple, ultraviolet
> - amber, blue
> - amber, blue, cyan, green, red, violet, white - cool
> - amber, blue, green
> - amber, green, blue
> - and then lots of single special colors

It suggested me another solution. Instead of LED RGB class
we would have LED multi-color class.

Sysfs interface design:
-----------------------

colors: directory containing files that map to
         the brightness of particular LEDs; there
         would be predefined color names that LED class
         driver should map iouts to, e.g.:
   - red
   - green
   - blue
   - white
   - sync: accepts "write" and "read", which executes
           write/readout to/from a device respectively.

brightness-model: defines brightness level to color configuration
                   mapping
   - "hardware": for devices with feature like LEDn_BRIGHTNESS of lp50xx
   - "rgb-<hue>": available only when all three red,green,blue colors
                  are present in the colors directory.
                  <hue> is a placeholder for given DT hue presets.
   - "rgbw-<hue>": Same as above, but available only when white color
                  (any of amber or white-{cool|neutral|warm} can be
                  mapped to white) is also available. In this mode
                  max_brightness equals num-of-hue-presets + 1, and
                  max_brightness, when set, turns the "white" LED on
   - "rgb-linear": I'm not sure if it should be available - it will
                   have unpredictable results

brightness: sets/reads brightness in the way specific to the
             current brightness-model. When more colors are available
             (e.g. amber, blue, cyan, green, red, violet, white), they
             are not touched by write to brightness).

HSV->RGB conversion is left entirely to the userspace, which can set any
color with use of the proposed interface.

Let's agree on sysfs interface first, and only after that move
to the DT details.

Best regards,
Jacek Anaszewski

> Better models even list some properties about how different color 
> elements behave.
> 
> I would expect red, green, blue to be the most common case. So 
> automating for that for chip like what you are working now is reasonable.
> 
> For simple case where we can expect red, green, blue mapping we can 
> auto-configure the multi color element led with "red", "green" and 
> "blue" color elements.
> 
> But TI also have other kind of driver chips that could be used in "more 
> freely" enabling use all of those combos.
> 
> If user would have "amber", "green" and "blue" then we would need to add 
> this definition in devicetree in order for user space to be able to 
> recognize that now we have different config.
> 
> Or if user would have most complex of those then in devicetree you would 
> configure 7 color element led like "amber", "blue", "cyan", "green", 
> "red", "violet", "white" as color elements.
> 
> Then you could set them in one go:
> echo "32 76 43 2 43 76 54" > color
> 
> Now in this special case if we would have hsl brightness model and lets 
> say it only knows red, green and blue. Then it would pick red, green and 
> blue color element names and only adjust those others would be linear 
> should there be non-zero value.
> 
> In this case however you might be better doing it in user space as it 
> might be preferable to control all values let say in sRGB space and then 
> let the software transform result to all color elements and then setup 
> entries to kernel. In here the ICC color profile might be the way to go 
> to model your let and let user space software do the fancier math.
> 
> As this latest example is the fanciest I would like to remind that the 
> red, green, blue is the most common. I would make their life easier and 
> then when you go to more advanced setups then you are are already 
> mentally ready to do more complex things :)
> 
> As an example in our case we can do with "red", "green", and "red", 
> "green", "blue" combos fill all our current requirements we have. 
> Perhaps white could be added as one thing in future (white is currently 
> used only in lcd module's background).
> 
> Latest proposal I have for the interface now lets you do all of those 
> things so it should be easy enough for most cases and still flexes to 
> more complex cases while keeping kernel space simple.
> 
> Thanks,
> Vesa Jääskeläinen
> 


