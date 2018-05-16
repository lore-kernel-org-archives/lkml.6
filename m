Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeEPV2j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:28:39 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33996 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeEPV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:28:36 -0400
X-Google-Smtp-Source: AB8JxZr8zLBAGFiyo/ozE7JUfRGcnHCu10DakoxsTCc5qqyQIrNQQB8nHhaV+hh/QywXTJlV2X1duQ==
Subject: Re: [PATCH v6 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180515154352.20263-1-dmurphy@ti.com>
 <20180515154352.20263-2-dmurphy@ti.com>
 <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
 <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com>
 <CAHp75Vcz08zrs3bgMFcvYwRrN_A43D=Nvt5cFDQf8m9whB=yhA@mail.gmail.com>
 <f46e4b54-c463-6ef0-4155-a5dfb9dc4c2b@gmail.com>
 <52380a68-9e33-f52a-134d-5d4a928b5383@ti.com>
 <f155e9da-e41d-1201-a9f9-c321654be42e@ti.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9050013a-7eb1-6786-2c94-3fc00510a739@gmail.com>
Date: Wed, 16 May 2018 23:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f155e9da-e41d-1201-a9f9-c321654be42e@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 05/16/2018 11:17 PM, Dan Murphy wrote:
> Jacek and Andy
> 
> On 05/16/2018 04:13 PM, Dan Murphy wrote:
>> Jacek and Andy
>>
>> On 05/16/2018 04:02 PM, Jacek Anaszewski wrote:
>>> Hi Andy and Dan,
>>>
>>
>> I will make all the changes then.  I don't want to go through and ack each one.
>>
> 
> Let me clarify. I will make all the change Jacek has guided on.  There is still a
> terminator comma vs no comma comment that needs disposition at the end of this file.

No comma option seems better in this case.

>> Thanks for the guidance and the reviews.
>>
>> It will take a couple days to find all the comments and get this all fixed up.
>>
>> Dan
>>
>>> On 05/16/2018 12:24 AM, Andy Shevchenko wrote:
>>>> On Wed, May 16, 2018 at 1:08 AM, Dan Murphy <dmurphy@ti.com> wrote:
>>>>> On 05/15/2018 04:56 PM, Andy Shevchenko wrote:
>>>>>> On Tue, May 15, 2018 at 6:43 PM, Dan Murphy <dmurphy@ti.com> wrote:
>>>>
>>>>>>> +       depends on LEDS_CLASS && I2C && OF
>>>>>>
>>>>>> What is OF specific in this driver?
>>>>>
>>>>> as3645a_led_class_setup has a "of" dependency
>>>>
>>>> So what? Is it called from this driver or?
>>>>
>>>>
>>>>>>> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
>>>>>>> +       { 40000, 0x00 },
>>>>>>> +       { 80000, 0x01 },
>>>>>>> +       { 120000, 0x02 },
>>>>>>> +       { 160000, 0x03 },
>>>>>>> +       { 200000, 0x04 },
>>>>>>> +       { 240000, 0x05 },
>>>>>>> +       { 280000, 0x06 },
>>>>>>> +       { 320000, 0x07 },
>>>>>>> +       { 360000, 0x08 },
>>>>>>> +       { 400000, 0x09 },
>>>>>>> +       { 600000, 0x0a },
>>>>>>> +       { 800000, 0x0b },
>>>>>>> +       { 1000000, 0x0c },
>>>>>>> +       { 1200000, 0x0d },
>>>>>>> +       { 1400000, 0x0e },
>>>>>>> +       { 1600000, 0x0f },
>>>>>>
>>>>>> Huh?!
>>>>>
>>>>> Please give comments that actually mean something other wise I will opt to ignore them.
>>>>
>>>> I did below.
>>>>
>>>>>> strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>>>>>
>>>>> Not sure what equation you are trying to point out here.  But if you are trying to apply
>>>>> a timeout step you cannot do this with this part.  As pointed out in the DT doc the timeout
>>>>> step is not linear.
>>>>
>>>> Yeah, I know people are more than often too lazy to think.
>>>>
>>>> if (x < 9)
>>>>    strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>>>> else
>>>>    strobe_timeout = (400 + (x - 9) * 200) * MSECS_IN_SEC;
>>>>
>>>
>>> I like the idea.
>>>
>>>>>>> +               brightness_val = (brightness/2);
>>>>>>
>>>>>> Spaces.
>>>>>
>>>>> Not sure what this means checkpatch was clean
>>>>
>>>> Even besides missed whispaces it has redundant parens.
>>>>
>>>> checkpatch is not a silver bullet to get your code clean and nice.
>>>>
>>>>>> This is return led_...();
>>>>>
>>>>> That is a preference.  It does not have to be that way.
>>>
>>> I missed that. Dan, please follow Andy's advise.
>>>
>>>>
>>>> What do you mean? We do not appreciate +LOCs for no (or even nagative!) benefit.
>>>>
>>>>>>> +               ret = of_property_read_string(led->led_node, "label", &name);
>>>>>>
>>>>>> device_property_...();
>>>>>
>>>>> It can be if the maintainer is requesting this.
>>>>
>>>> Jacek, if you need rationale behind this comment it's here: the driver
>>>> has nothing DT specific and getting rid of OF centric programming
>>>> allows to reuse the driver on non-DT platforms w/o touching a source
>>>> code.
>>>
>>> It has an added value, so yes, let's use it as a standard approach
>>> from now on.
>>>
>>>>> Is the trend to move to these functions?
>>>>
>>>> See above.
>>>>
>>>>> Most drivers use the "of" calls.
>>>>
>>>> So what?
>>>>
>>>>
>>>>>>> +               if (!ret)
>>>>>>
>>>>>> if (ret) sounds more natural. And better just to split
>>>>>>
>>>>>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>>>>>> +                               "%s:%s", led->led_node->name, name);
>>>>>>> +               else
>>>>>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>>>>>> +                               "%s:torch", led->led_node->name);
>>>>>>
>>>>>> const char *tmp;
>>>>>>
>>>>>> ret = device_property_read_...(&tmp);
>>>>>> if (ret)
>>>>>>    tmp = ...
>>>>>> sprintf(...);
>>>
>>> We're no longer taking devicename section of a LED class device name
>>> from DT, so it will look differently anyway.
>>>
>>>> No comments on this?
>>>>
>>>>>>> +       led = devm_kzalloc(&client->dev,
>>>>>>> +                           sizeof(struct lm3601x_led), GFP_KERNEL);
>>>>>>
>>>>>> sizeof(*led) and one line in the result
>>>>
>>>> And this?
>>>
>>> Ack.
>>>
>>>>
>>>>>>> +       { },
>>>>>>
>>>>>> Terminators better w/o comma.
>>>>>
>>>>> Looking at other drivers adding comma's on the sentinel is accepted.  See the as3645a driver
>>>>
>>>> So what?
>>>>
>>>> Terminator at compile time even better.
>>>>
>>>>>>> +       {},
>>>>>>
>>>>>> Ditto.
>>>>>
>>>>> See above
>>>>
>>>> See above.
>>>>
>>>
>>
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
