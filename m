Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6589CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9CE2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDBpHtmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfA2Vxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:53:30 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:39768 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfA2Vxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:53:30 -0500
Received: by mail-lf1-f42.google.com with SMTP id n18so15821768lfh.6;
        Tue, 29 Jan 2019 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZVZHWgE3kKVgNpUsUyPvaTvBAa8Rzi6VMN+jLKLLTQ=;
        b=DDBpHtmZydCEKNnRJBvjKOVmUM/WKLc8a2HI5P5AuIhD30C+OPu4oG12NoX/UmytPj
         hcZKqwIg/fsCK7sAO5MAwWyzcRyMIqNABl23s/2JONARWPKp9rcCvBVFvkluVlGU+XJN
         XyUUvmRYmQ/A5AkiUR5ViZgk80VlDbofiFYUcES1QGrwrtQ42RQnuKBoWN7nJ0/oSwrf
         5w+HTbq+IPMHPkpR6CiYwN+fzSXfEU7Wt+nIMGzYXXsjLB6DQ54OmPF/eKFRSuAlEC2J
         PxyN5xLq+rvbnl8AkF8sUBxbzJfuRkAK2AVRBE/Ra5/Id9Xirl9kth30wqziCsBDeN8o
         mvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZVZHWgE3kKVgNpUsUyPvaTvBAa8Rzi6VMN+jLKLLTQ=;
        b=Py67MtEzG5jZo0Vun5bVFdy+r4Ws5VnTnBS4vHNdg35zTMekzQU5VSWGSlJwRUNrN2
         AGlLirK9z6+SrpU/35Y0KsFEq9PvPMVjHZ7vKMnU3Ue0QbhmsLHGUL1GeJis07hCMpsx
         YIDil0IlOQ2dGKddKsEcvgaWt4wDzRCRkDhAmAiuGLuXbptLpg2flORN7K+4xot08Cqh
         0TgwJJ0UAnLHcRPk4s+OPRDWId8kFjQjKe1sxK1iQp9B4PTluBd1dHgTZ871deYWR00r
         uG6LIqtxVLtCeCtYVZpbyiIzN+sZRqlbqGPZJttwYKkewGYrN3O8LbUMxKABhngQUUWa
         zfSg==
X-Gm-Message-State: AJcUukdT66R6B8SHoCTTDt0ywrDVty7NWbHmbUEM6avjdS+wF4ypsXVB
        cBogwxgGhtrmzcxZdt2b2i0=
X-Google-Smtp-Source: ALg8bN6AcmKYvt6KTG7WAThCkoWCjpzdZ7SfvYvo6eDNaLVjWkaBGIucXirj/Ry54qYEB/NCOcnp9w==
X-Received: by 2002:a19:c995:: with SMTP id z143mr21062105lff.79.1548798805118;
        Tue, 29 Jan 2019 13:53:25 -0800 (PST)
Received: from [192.168.1.18] (dnt76.neoplus.adsl.tpnet.pl. [83.24.101.76])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3836655lje.89.2019.01.29.13.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 13:53:24 -0800 (PST)
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
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
 <27318c48-f84a-5129-ac88-545edd549101@gmail.com>
 <21d3e21a-e50e-ee46-6f81-5a22db878c15@ti.com>
 <1c7680d3-6926-d837-dcd9-254aca23df39@gmail.com>
 <3e804986-89ef-2465-51ad-86e793b39b7e@ti.com>
 <f7ad8d5a-2998-f6f0-be4b-b47237b3397f@gmail.com>
 <4d80cc7f-1f18-ec5b-d312-a6a0da2a4506@ti.com>
 <ca8b4251-afd4-ddde-96f2-6e3fc72e3b55@gmail.com>
 <a097bfc8-cdee-67bb-6c30-6a31142d01ab@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <cc4a0320-6faf-1e6a-faa7-9456926f35a5@gmail.com>
Date:   Tue, 29 Jan 2019 22:53:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a097bfc8-cdee-67bb-6c30-6a31142d01ab@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 1/29/19 9:26 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/29/19 2:19 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> On 1/29/19 2:56 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/24/19 3:55 PM, Jacek Anaszewski wrote:
>>>> Dan
>>>>
>>>> On 1/24/19 10:00 PM, Dan Murphy wrote:
>>>>> Jacek
>>>>>
>>>>> On 1/23/19 3:52 PM, Jacek Anaszewski wrote:
>>>>>> Dan,
>>>>>>
>>>>>> On 1/22/19 11:44 PM, Dan Murphy wrote:
>>>>>>> Jacek
>>>>>>>
>>>>>>> On 1/22/19 3:39 PM, Jacek Anaszewski wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> On 1/20/19 7:42 AM, Vesa Jääskeläinen wrote:
>>>>>>>>> Hi Dan,
>>>>>>>>>
>>>>>>>>> On 18/01/2019 15.58, Dan Murphy wrote:
>>>>>>>>>> Jacek
>>>>>>>>>>
>>>>>>>>>> On 1/18/19 7:45 AM, Dan Murphy wrote:
>>>>>>>>>>> Jacek
>>>>>>>>>>>
>>>>>>>>>>> On 1/17/19 3:10 PM, Jacek Anaszewski wrote:
>>>>>>>>>>>> Hi Dan,
>>>>>>>>>>>>
>>>>>>>>>>>> On 1/16/19 7:41 PM, Dan Murphy wrote:
>>>>>>>>>>>>> Hello
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 1/16/19 4:55 AM, Pavel Machek wrote:
>>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>>>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>>>>>>>>>>>>>>>>> +XX - Do not care ignored by the driver
>>>>>>>>>>>>>>>>>> +RR - is the 8 bit Red LED value
>>>>>>>>>>>>>>>>>> +GG - is the 8 bit Green LED value
>>>>>>>>>>>>>>>>>> +BB - is the 8 bit Blue LED value
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +Example:
>>>>>>>>>>>>>>>>>> +LED module output 4 of the LP5024 will be a yellow color:
>>>>>>>>>>>>>>>>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>>>>>>>>>>>>>>>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +LED banked RGBs of the LP5036 will be a white color:
>>>>>>>>>>>>>>>>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This part with example cans remain in Documentation/leds if you
>>>>>>>>>>>>>>>>>> like.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Does it actually work like that on hardware?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> What?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
>>>>>>>>>>>>>> does it actually produce white? With all the different RGB modules
>>>>>>>>>>>>>> manufacturers can use with lp5024P?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, does
>>>>>>>>>>>>>> it actually produce yellow, with all the different RGB modules
>>>>>>>>>>>>>> manufacturers can use with lp5024P?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I believe the answer to the general questions is no for any RGB cluster and driver out there.
>>>>>>>>>>>>> Because if you set the same values on each and every RGB device out there you will get varying shades of the color.
>>>>>>>>>>>>> But for this device yes the color does appear to be yellow to me versus what was displayed on my monitor by the HSL picker.
>>>>>>>>>>>>> But everyone interprets colors differently.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If you write the same value for yellow or white on a droid 4 and the N900 do they produce the same color side by side?
>>>>>>>>>>>>> Most probably not.
>>>>>>>>>>>>>
>>>>>>>>>>>>> As you pointed out the PWM needs to be modified to obtain the correct white color to account for LED and other device constraints.
>>>>>>>>>>>>>
>>>>>>>>>>>>> But we need to take into account the light pipe.  Pools nowadays have RGB LED spot lights in them.  It can
>>>>>>>>>>>>> be set to white.  On my pool right off the lens the color has a purplish hue to it.  As the light is diffracted into
>>>>>>>>>>>>> the pool the color becomes white.  The pool is clear.  When I add chemicals to the pool and make it cloudy
>>>>>>>>>>>>> and turn on the lights the color off the lens is now white.  This is an example on a large scale but the issue
>>>>>>>>>>>>> scales down to the hand helds and smart home applications.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If the cluster is piped through a flexible optic 0xffffff may produce the "white" you want on its output.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So an expectation of certain color without proper piping based on a single RGB value may be a little unreasonable.
>>>>>>>>>>>>> There may need to be a way to attenuate the values based on the hardware aspect of the equation ie light pipe (or lack thereof) and LED vendor.
>>>>>>>>>>>>> So if we write 0xffffff to the RGB driver the driver could adjust the intensity of the individual LEDs based on the diffraction
>>>>>>>>>>>>> coefficients.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I also think that is an unreasonable expectation here that writing a single value to any LED RGB driver would produce
>>>>>>>>>>>>> a "rest of the world" absolute color.  Maybe it can produce something similar but not identical.
>>>>>>>>>>>>> As you indicated in the requirements there is more involved here then just the LED and the values written.
>>>>>>>>>>>>> The colors should be close but may not be identical.
>>>>>>>>>>>>>
>>>>>>>>>>>>> A 10 year old N900 should not be considered the gold standard for color production due to advancements in LED,
>>>>>>>>>>>>> light pipe and LED driver technology.
>>>>>>>>>>>>> The single package RGB clusters on the board I am testing is about the size of a single RGB LED from 10 years ago.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I agree that the interface developed should work on the device but the algorithm derived to obtain the color needs to have
>>>>>>>>>>>>> a hardware aspect to the calculation.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Is it supposed to support "normal" RGB colors as seen on monitors?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Monitors are not an application for this part.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> You did not answer the question. When you talk about yellow, is it
>>>>>>>>>>>>>> same yellow the rest of world talks about?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> See above.  It is close to what was on my monitor displayed.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Because 100% PWM on all channels does not result in white on hardware
>>>>>>>>>>>>>>>> I have.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I don't know I am usually blinded by the light and have no diffuser over
>>>>>>>>>>>>>>> the LEDs to disperse the light so when I look I see all 3 colors.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> How can we have useful discussion about colors when you don't see the
>>>>>>>>>>>>>> colors?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Place a piece of paper over the LEDs....
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Good suggestion for a rough test.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> But...
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I believe we should have a reasonable design before we do something
>>>>>>>>>>>>>>>> like this. There's no guarantee someone will not use lp50xx with just
>>>>>>>>>>>>>>>> the white LEDs for example. How will this work? Plus existing hardware
>>>>>>>>>>>>>>>> already uses three separate LEDs for RGB LED. Why not provide same
>>>>>>>>>>>>>>>> interface?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Which existing hardware?  Are they using this part?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Nokia N900. They are not using this part, but any interface we invent
>>>>>>>>>>>>>> should work there, too.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes a common interface would be nice with some sort of hardware tuning coefficient.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> <rant>
>>>>>>>>>>>>>>> Why are we delaying getting the RGB framework or HSV in?
>>>>>>>>>>>>>>> I would rather design against something you want instead of having
>>>>>>>>>>>>>>> everyone complain about every implementation I post.
>>>>>>>>>>>>>>> </rant>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Because you insist on creating new kernel interfaces, when existing
>>>>>>>>>>>>>> interfaces work, and are doing that badly.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Because your patches are of lower quality than is acceptable for linux
>>>>>>>>>>>>>> kernel.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Because you don't seem to be reading the emails.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I sent list of requirements for RGB led support. This does not meet
>>>>>>>>>>>>>> them.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sigh.  You did not answer my question.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Your requirements seem to be centered around monitors but that is only one application of the current
>>>>>>>>>>>>> RGB LED landscape.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am willing to work with you on the HSV and adapting the LP50xx part to this framework.
>>>>>>>>>>>>> Or any RGB framework for that matter.  I still don't agree with the kernel needing to declare colors
>>>>>>>>>>>>>        maybe color capabilities but not specific colors.
>>>>>>>>>>>>
>>>>>>>>>>>> Dan, if you have a bandwidth for LED RGB class implementation
>>>>>>>>>>>> then please go ahead. It would be good to compare colors produced
>>>>>>>>>>>> by software HSV->RGB algorithm to what can be achieved with
>>>>>>>>>>>> LEDn_BRIGHTNESS feature.
>>>>>>>>>>>>
>>>>>>>>>>>> The requirements for LED RGB class as I would see it:
>>>>>>>>>>>>
>>>>>>>>>>>> sysfs interface:
>>>>>>>>>>>>
>>>>>>>>>>>> brightness-model: space separated list of available options:
>>>>>>>>>>>> - rgb (default):
>>>>>>>>>>>>        - creates color file with "red green blue" decimal values
>>>>>>>>>>>
>>>>>>>>>>> What about other colored LEDs?  Presenting RGB for an Amber LED does not seem right.
>>>>>>>>>>> Should the LED color come from the DT?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I thought about this, other non-RGB LEDs would not use the RGB framework.
>>>>>>>>>> But should they have the same interfaces as RGB?
>>>>>>>>>>
>>>>>>>>>> Should PWM control be a global interface?
>>>>>>>>>
>>>>>>>>> In order to being able to set multi color element led at one go I would recommend using then model:
>>>>>>>>>
>>>>>>>>> color_names: "red green blue white"
>>>>>>>>>
>>>>>>>>> echo "32 43 0 128" > color
>>>>>>>>>
>>>>>>>>> This way all elements would be set at same time from user space point of view.
>>>>>>>>>
>>>>>>>>> This of course requires that it is part of the physical/logical led that is being controlled. If it is a separate thing then it would logically be differently controlled mono color led.
>>>>>>>>>
>>>>>>>>> If you look what kinds of leds are available lets say from digikey you get all kinds of combos:
>>>>>>>>>
>>>>>>>>> - red, green, blue
>>>>>>>>> - red, green, blue, amber
>>>>>>>>> - red, green, blue, white
>>>>>>>>> - red, green, blue, white - cool
>>>>>>>>> - red, green, blue, white - neutral
>>>>>>>>> - red, green, blue, white - warm
>>>>>>>>> - red, orange
>>>>>>>>> - purple, ultraviolet
>>>>>>>>> - amber, blue
>>>>>>>>> - amber, blue, cyan, green, red, violet, white - cool
>>>>>>>>> - amber, blue, green
>>>>>>>>> - amber, green, blue
>>>>>>>>> - and then lots of single special colors
>>>>>>>>
>>>>>>>> It suggested me another solution. Instead of LED RGB class
>>>>>>>> we would have LED multi-color class.
>>>>>>>>
>>>>>>>
>>>>>>> I was thinking the same thing this morning.  But I was thinking that the RGB
>>>>>>> class should be an additional class to stand on its own or can register to the
>>>>>>> multi color class.
>>>>>>>
>>>>>>>> Sysfs interface design:
>>>>>>>> -----------------------
>>>>>>>>
>>>>>>>> colors: directory containing files that map to
>>>>>>>>             the brightness of particular LEDs; there
>>>>>>>>             would be predefined color names that LED class
>>>>>>>>             driver should map iouts to, e.g.:
>>>>>>>
>>>>>>> Filling in the missing ideas with questions.
>>>>>>>
>>>>>>> Is it a directory or a file?  If it is a directory does that not break the current
>>>>>>> directory label model?
>>>>>>>
>>>>>>> so the path would be /sys/class/leds/colors ?  (It is probably not this but needs clarification)
>>>>>>> How would this look if I had 2 of the same color LEDs?  The Beagle bone black has 2 Blue LEDs.
>>>>>>> They are assigned to different triggers and have different directories.  Both are GPIO controlled.
>>>>>>>
>>>>>>> Or are you saying it would be something like (More then likely this is what you intended)
>>>>>>> /sys/class/leds/input4::numlock/colors?
>>>>>>
>>>>>> Yes, this is what I meant.
>>>>>>
>>>>>
>>>>> OK.  Thanks for the clarification
>>>>>
>>>>>>> Maybe it is mandated that "multi" be added to the label when the class is registered so the caller
>>>>>>> knows that this is a multi color class and not a single LED color class.
>>>>>>
>>>>>> Like I am going to come up with standardized color names
>>>>>> in my LED naming related patch, the multi-color names
>>>>>> can be defined as well, e.g.: rgb, rgbw, rgbwa, rgbwauv etc.
>>>>>>
>>>>>
>>>>> That may be better it is descriptive off the command line.
>>>>>
>>>>>>> What about providing a file called colors_raw which takes in the raw decimal values to obtain other color
>>>>>>> variants when RGB is only available?  And this can also present a single write to the kernel with the new
>>>>>>> color values.
>>>>>>
>>>>>> My design already covers that in the form of files in the colors
>>>>>> directory. Like I stated: "files that map to the brightness of
>>>>>> particular LEDs". Single write is secured by "echo "write" > sync.
>>>>>>
>>>>>
>>>>> OK.  So set the new values and then tell the set the sync which will make the device driver write the
>>>>> device.
>>>>>
>>>>> Sounds good.  how about echo 1 > sync and we can stay away from a long string conversion
>>>>
>>>> We need also to be able to do a readout.
>>>>
>>>> If we changed "sync" to "rw" then we could come up with intuitive
>>>> semantics:
>>>>
>>>> echo 1 > rw  // write
>>>> echo 0 > rw  // read
>>>>
>>>> rw file would have WO permission.
>>>
>>> I have re-written the lp50xx driver to show red, green, blue, sync and sync_enable files for each registered LED.
>>
>> Did you change your mind regarding LED multi color class implementation?
>>
> 
> No.  I just did not want to put effort into the class if the interfaces were not agreed upon.
> So if we are good with the interfaces I can start the MC class.
I'm good with that. It would be nice to see some input from the
other people.

>>> I added the sync_enable file so that the there can be real time control of the individual LEDs as well.
>>
>> Yes, it's a good idea.
>>
>>> Turning on sync means that the user will write to one of the color files and the setting won't take affect until
>>> sync is written.
>>>
>>> If sync is off then the LED register is updated immediately.
>>>
>>> Being able to turn on and off syncing maybe better.  A developer may choose to set up the color and then sync
>>> or they may want to ramp a specific color.  This will help reduce user space writes but also reduce the number
>>> of peripheral writes when color values do not change.
>>>
>>> I am having difficulty in creating the colors directory in the device driver.
>>> This appears to need to be done in the class when the class pointer is available.
>>
>> Not necessarily, you need only dev->kobj. Please follow the implementation of drivers/usb/core/ledtrig-usbport.c. However I would
>> really prefer if it became a part of new LED multi color class.
>>
> 
> It will.  I should be able to create the colors directory there as well.
> I need to figure out how to cleanly tell the MC class what LEDs are available.

Of course the solution from ledtrig-usbport.c is equally good for the
class.

Related to the LED color identifications in the multi color class -
we'd need some defines in e.g. include/dt-bindings/leds/colors.h:

#define LED_COLOR_RED   0
#define LED_COLOR_GREEN 1
#define LED_COLOR_BLUE  2

Then, in the device tree we could have:

led-controller@8 {
     ...
     led@0 {
         multi-color = <LED_COLOR_RED
                        LED_COLOR_GREEN
                        LED_COLOR_BLUE>;
         reg = <0x0>; // in case of lp5024 this would identify
                      // RGB LED module;
     };
};

For pwm LEDs we would need a bit different approach, so I'd not
strive to create generic bindings for LED multi color class.

We need generic interface only for LED multi color class registration.
e.g.:

struct led_classdev_multicolor {
     /* led class device */
     struct led_classdev led_cdev; // for legacy brightness support
     struct led_classdev *colors;  // dynamically allocated array

     void (*multicolor_set) (struct led_classdev_multicolor *led_mcdev);
     void (*unicolor_set) (struct led_classdev *led_cdev,
                           enum led_brightness); // [color]_store ssyfs
                                                 // callback will call it
};

led_classdev_multicolor_register(struct device *parent,
		struct led_classdev_multicolor *led_mcdev)
...

>>>>>>> I am not a fan of hard coding preset colors as you can see there are to many of them and variations of the color.
>>>>>>> In addition this severely limits the ability of the user.  Unless we stick to primary colors only and not secondary
>>>>>>> colors.
>>>>>>> Defining and hard coding hte colors can get out of control and not maintainable moving forward.  Especially
>>>>>>> if we start adding defines like white_warm, white_neutral and other variations to the color.
>>>>>>
>>>>>> We would not limit anything. Every color combination can be achieved
>>>>>> by following this exemplary sequence:
>>>>>>
>>>>>> $ echo 154 > colors/red
>>>>>> $ echo 232 > colors/green
>>>>>> $ echo 43  > colors/blue
>>>>>> # echo "write" > sync     //only this changes hardware state
>>>>>>
>>>
>>> The code works more like this
>>> $ :/sys/class/leds/lp5024:led1_mod# ls
>>> blue            device          max_brightness  red             sync            trigger
>>> brightness      green           power           subsystem       sync_enable     uevent
>>>
>>> $ cat sync_enable
>>> enabled        // I can change this to return an int instead
>>> $ echo 154 > red
>>> $ echo 232 > green
>>> $ echo 43  > blue
>>> $ echo 1 > sync     //this changes hardware state
>>>
>>> $ echo 0 > sync_enable
>>> $ cat sync_enable
>>> disabled
>>> $ echo 154 > red    // changes red LED immediately
>>> $ echo 232 > green    // changes green LED immediately
>>> $ echo 43  > blue    // changes blue LED immediately
>>> $ echo 1 > sync     // Has no affect on the hardware
>>>
>>> If this is OK I can post the patch with this update.
>>>
>>> But I would rather put the file creation in a class and have the colors directory.
>>
>> Yes, please post your work when it is ready.
> 
> OK.  I will derive the class and try to post it by the EOW.
> 
>>
>>>>>> brightness-model is provided only to define mapping of legacy brightness
>>>>>> levels (governed by brightness file and led_set_brightness() API) to
>>>>>> the specific combination of colors.
>>>>>>
>>>>>> For instance we can define three brightness levels for green hue:
>>>>>>
>>>>>> DT definition for it would look like below:
>>>>>>
>>>>>> rgb-green = <0x277c33 0x37b048 0x47e45d>;
>>>>>>
>>>>>> LED multi color class would then do the following mapping for
>>>>>> each of the three brightness levels for rgb-green brightness model:
>>>>>>
>>>>>> $ echo rgb-green > brightness_model
>>>>>> $ echo 1 > brightness // red=0x27, green=0x7c, blue=0x33
>>>>>> $ echo 2 > brightness // red=0x37, green=0xb0, blue=0x48
>>>>>> $ echo 3 > brightness // red=0x47, green=0xe4, blue=0x5d
>>>>>>
>>>>>
>>>>> OK I would have to play with this on the LP devices.
>>>
>>> I have not done anything with this.
>>>
> 
> I will omit this until we figure out how to nicely present this to user space from the MC class.

Could you share what particularly is your concern?

> Or maybe it is something you can add once we have the class ready.

OK. But for the cases when neither LEDn_BRIGHTNESS feature nor
any DT color ranges are provided please do provide one brightness
model "onoff", that for brightness==1 will set brightness of all colors
to max, and turn them off on brightness==0.

>>>>>>> What about IR LEDs used for night vision products?  Do these fall into the multi color class?
>>>>>>> We do have a driver I submitted that had an IR LED and a White LED combined.  It was created against the
>>>>>>> flash class but it could be a multi color LED as well.
>>>>>>>
>>>>>>> How would traversing through the full color palette work if you were to want to produce a multi
>>>>>>> color ring like the LP50xx where the pattern can traverse from one end of the color spectrum and back?
>>>>>>> Or in a product like the gaming keyboards that will change color or change backlight brightness?
>>>>>>
>>>>>> This is not meant as a solution for pattern generator but for
>>>>>> consolidated source of multi color light. In the simplest case
>>>>>> RGB LED elements like those used for lp5024 reference board,
>>>>>> but it could be RGBWAUV LED [0] as well.
>>>>>>
>>>>>> For patterns traversing many LEDs I see a trigger as the best solution.
>>>>>> Hmm, now I see that trigger mechanism actually can serve as very
>>>>>> flexible pattern generator.
>>>>>>
>>>>>> We would need a device that could be configured to register
>>>>>> a number of multi-led-patternN triggers, one per LED, and generate
>>>>>> events for each trigger in a loop.
>>>>>>
>>>>>> The device would have to allow for configuring pattern intervals
>>>>>> via sysfs, like in case of current pattern trigger.
>>>>>>
>>>>>> LED class devices would have to register for its events:
>>>>>>
>>>>>> $/sys/class/leds/led1 echo multi-led-pattern1 > trigger
>>>>>> $/sys/class/leds/led2 echo multi-led-pattern2 > trigger
>>>>>> $/sys/class/leds/led3 echo multi-led-pattern3 > trigger
>>>>>>
>>>>>
>>>>> A bit off topic but I like the idea.  We should save this for another day
>>>>
>>>> Yes, that's another story.
>>>>
>>>>>> The ability to define brightness models in DT would
>>>>>> add even more flexibility.
>>>>>>
>>>>>
>>>>> brightness models would be mandatory to support in the driver but an optional
>>>>> DT entry.
>>>>>
>>>>> Is that a correct assumption?
>>>>
>>>> Correct.
>>>>
>>>>>>> Not sure what color LEDs the keyboard manufacturers place on their keyboards but does the interface design
>>>>>>> capable of doing this?
>>>>>>>
>>>>>>> https://www.youtube.com/watch?v=pfKv3g2FeBE
>>>>>>> or something like this
>>>>>>>
>>>>>>> https://www.youtube.com/watch?v=PO3auX3f5C4
>>>>>>>
>>>>>>> The LP5036 has this capability.
>>>>>>>
>>>>>>>>       - red
>>>>>>>>       - green
>>>>>>>>       - blue
>>>>>>>>       - white
>>>>>>>>       - sync: accepts "write" and "read", which executes
>>>>>>>>               write/readout to/from a device respectively.
>>>>>>>>
>>>>>>>
>>>>>>> What are these above, the values or the files under the colors directory?
>>>>>>
>>>>>> They are just color specific counterparts of monochrome brightness.
>>>>>> In terms of lp50xx they would map to OUTn_COLOR registers.
>>>>>>
>>>>>>> I am assuming they are files.
>>>>>>
>>>>>> Right.
>>>>>>
>>>>>>> Are they mandatory or optional?
>>>>>>
>>>>>> Mandatory, one per each iout to control.
>>>>>>
>>>>>
>>>>> OK And all the LEDs within this directory would be considered a LED cluster?
>>>>>
>>>>> And if there are 2 like colors of the LED defined in the same cluster would we just see a single
>>>>> file and write a common value to that file and the driver would have to update each
>>>>> red LED within that cluster.  No independent control of like colored LEDs within the
>>>>> registered LED cluster.
>>>>>
>>>>> If the developer wants this level of control they would have to register two separate classes
>>>>>
>>>>> Correct?
>>>>
>>>> I would abide by one color to one iout mapping. Registering more LEDs
>>>> under the same color feels more of a task for trigger.
>>>>
>>>>>>>> brightness-model: defines brightness level to color configuration
>>>>>>>>                       mapping
>>>>>>>>       - "hardware": for devices with feature like LEDn_BRIGHTNESS of lp50xx
>>>>>>>>       - "rgb-<hue>": available only when all three red,green,blue colors
>>>>>>>>                      are present in the colors directory.
>>>>>>>>                      <hue> is a placeholder for given DT hue presets.
>>>>>>>>       - "rgbw-<hue>": Same as above, but available only when white color
>>>>>>>>                      (any of amber or white-{cool|neutral|warm} can be
>>>>>>>>                      mapped to white) is also available. In this mode
>>>>>>>>                      max_brightness equals num-of-hue-presets + 1, and
>>>>>>>>                      max_brightness, when set, turns the "white" LED on
>>>>>>>
>>>>>>> Why do we need white combined here?  Should this not be its own entity?
>>>>>>
>>>>>> To be able to set white color. We're still talking about one LED
>>>>>> element (although they can be be physically few LEDs in one case).
>>>>>> This is brightness file, so we've got to stick to the semantics.
>>>>>> Max brightness level should be the brightest. With RGBW LEDs we
>>>>>> fortunately have a means to achieve pure white, that's why
>>>>>> rgbw-<hue> would be beneficial. If you increase L component of
>>>>>> HSL color space, the max value gives white for all hues.
>>>>>> So maybe this brightness-model would be rather called hsl-<hue>.
>>>>>>
>>>>>> For RGBW LEDs, we would have to allow for more shades of white too,
>>>>>> like in [1].
>>>>>>
>>>>>
>>>>> Yep.
>>>>
>>>> But this all would be left to the DT designer decision.
>>>>
>>>>>>> Again I don't like limiting the color palette from the DT.  I think that the
>>>>>>> user space can see what colors are available for that device and makes its own
>>>>>>> decision on what color to present.
>>>>>>>
>>>>>>> For the RGBw what about RGB amber and RGB purple.  Are the white LEDs always part of the
>>>>>>> same function trying to be achieved by the system designer?  The RGB can be used to denote
>>>>>>> notification status and the white can be used to denote that a charger is connected.  Motorola
>>>>>>> Droid did this.
>>>>>>
>>>>>> I hope I've just clarified my idea.
>>>>>>
>>>>>
>>>>> Its getting clearer.  I would like to see it in code and play with it not as a user
>>>>> but as a developer.  Make sure the paper model works as well as the real implementation.
>>>>>
>>>>> Is this model clear to the developer?
>>>>> How would a developer define what values are appropriate for the brightness-model?
>>>>
>>>> We could create guidelines e.g. that for hsl-<hue> pattern, the
>>>> colors corresponding to brightness levels should be arranged so
>>>> that increasing brightness felt like increasing value of
>>>> L component of HSL.
>>>>
>>>> But we wouldn't be able to enforce adherence to a particular scheme.
>>>>
>>>>> Does the driver have to become overly complex to support simple color generation?
>>>>
>>>> Not at all. Caching the colors written to the files in colors directory
>>>> would be responsibility of LED multi-color class. On echo 1 > sync
>>>> the core would call a new op e.g.
>>>>
>>>> color_set(struct led_classdev_multicolor *mcled_cdev)
>>>>
>>>> Driver would read in it colors cached in struct led_classdev_multicolor
>>>> and write them to the hardware.
>>>>
>>>>> Thoughts on putting code to idea?
>>>>>
>>>>>
>>>>>>>
>>>>>>>>       - "rgb-linear": I'm not sure if it should be available - it will
>>>>>>>>                       have unpredictable results
>>>>>>>>
>>>>>>>> brightness: sets/reads brightness in the way specific to the
>>>>>>>>                 current brightness-model. When more colors are available
>>>>>>>>                 (e.g. amber, blue, cyan, green, red, violet, white), they
>>>>>>>>                 are not touched by write to brightness).
>>>>>>>>
>>>>>>>> HSV->RGB conversion is left entirely to the userspace, which can set any
>>>>>>>> color with use of the proposed interface.
>>>>>>>>
>>>>>>>> Let's agree on sysfs interface first, and only after that move
>>>>>>>> to the DT details.
>>>>>>>>
>>>>>>>
>>>>>>> DT's are meant to describe hardware and not describe the product.  Unless Rob does not see
>>>>>>> an issue with defining product capabilities in the DT then we should keep that out of the DT.
>>>>>>
>>>>>> LED element is a device. I see nothing irrelevant for DT in describing the lighting specificity of a device mounted on the board. Please keep
>>>>>> in mind that it will not limit the number of colors available to set.
>>>>>> It will only allow to define mapping of brightness level to color.
>>>>>> We need that for current trigger mechanism to work with LED multi-color
>>>>>> class.
>>>>>>
>>>>>
>>>>> I see this now.
>>>>>
>>>>> Dan
>>>>>
>>>>>> [0] http://www.cobledarray.com/sale-4942931-10w-rgbwauv-led-diode-6-in-1-high-power-multicolor-led-chip.html
>>>>>> [1] https://www.youtube.com/watch?v=NzlFmTqOh9M
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
