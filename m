Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147DB222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIyDakSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391126AbfBOWbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:31:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45974 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390603AbfBOWbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:31:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so9630642ljd.12;
        Fri, 15 Feb 2019 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lTOqihQXBEziRBp8qsuh70LNMirjYV0K2k2qJv8vPgE=;
        b=jIyDakSkd/qXiz/CbUj7bXzIc8+gQ2d+pM0vzHNXnlhMMLtI+rsFL/OQGeRRoPTsEi
         AYikHr7243ocp4sZxfbgZe9Ro/dNU/B0Or5XJGg8bLe13L7B9Mkv6tEQRCa8ddFlyFkB
         pyREJZReXUqZ20ONk+nqrD5VaNyMHAfa/cLemeCnDhM3oGxfxzwdv67GIRNP+Jvh8TO0
         nrKlgNYA2TDzMnp1xxg2fqbz/MizifzIj33PY7YZDuqYLFwHgNPYPUdmn0Vq6rC0Vl+C
         4DbSI5c+tOnpNdNGvTewdu1WrugDqD5EdMb0depqZSRq5qz2AoFSV06idx2/em0Ktx7Y
         +pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTOqihQXBEziRBp8qsuh70LNMirjYV0K2k2qJv8vPgE=;
        b=jr471AENKztyw14CVzE+Q7k6ofCRuG2lQ3jTEkYaI3/bgzyh+4miIyZ19bSPIXx9ge
         X8DRVdEcdvTIeqTdyqC72eRzosNIQr5B+cOTWLiBVZzYdGl1rCiUVycwwfHVI6d6SF0u
         omDf5fBZJ6/e1o09POcpfKJbAeCfceIC7vnVnisA0DSswmANfFgwiLlDudzF2l0wmS7X
         kJAg6i7ZeWI1FYOltwqslYG9BqBRkqnW0y1eBEkn8Pyk4lNOpKetosfLFz3nZ/KXAwSQ
         X+tK3HYnEFT3PWwYHATFYgwQSPeFcvhOOObgZyUhJInmq/VpNVWbRwtJgAGHLo3MCI36
         fGMA==
X-Gm-Message-State: AHQUAuaWXk1rcmFuxls53BzvH/vTmsWrAxxwTjj7GHDdr1NAvUXMkmmo
        D5kaeL3NQoR9jWJNtGThCGjWRwgf
X-Google-Smtp-Source: AHgI3IZM/07zC/IazQ+14vZi+mBIAp9v8kI32hz3j1nyN3Wt0eczyqss71bqmELCAldWBdsgQ8Eo3g==
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr6936887ljd.31.1550269888327;
        Fri, 15 Feb 2019 14:31:28 -0800 (PST)
Received: from [192.168.1.18] (bkp179.neoplus.adsl.tpnet.pl. [83.28.183.179])
        by smtp.gmail.com with ESMTPSA id l72sm1681532lfg.75.2019.02.15.14.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:31:27 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com> <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
Date:   Fri, 15 Feb 2019 23:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 11:26 PM, Hans de Goede wrote:
> Hi,
> 
> On 2/15/19 10:42 PM, Jacek Anaszewski wrote:
>> Hi all,
>>
>> On 2/15/19 12:27 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 15-02-19 00:03, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>>> I suggest that we deal with this special case by adding 3 custom
>>>>>>>> sysfs attributes:
>>>>>>>>
>>>>>>>> 1) "mode" which when read, prints, e.g. :
>>>>>>>> manual [on-when-charging]
>>>>>>>
>>>>>>> While this allows _user on console_ to control everything using 
>>>>>>> echo,
>>>>>>> it is not suitable for applications trying to control LEDs.
>>>>>>>
>>>>>>> As there's nothing special about the case here, I believe we should
>>>>>>> have generic solution here.
>>>>>>>
>>>>>>> My preffered solution would be "hardware" trigger that leaves the 
>>>>>>> LED
>>>>>>> in hardware control.
>>>>>>
>>>>>> As you explained in the parts which I snipped, there are many
>>>>>> devices which have a similar choice for a LED being under hw or
>>>>>> user control. I can see how this looks like a trigger and how we
>>>>>> could use the trigger API for this.
>>>>>>
>>>>>> I believe though, that if we implement a "virtual" (for lack of
>>>>>> a better word) trigger for this, that this should be done in the
>>>>>> LED core. I can envision this working like this:
>>>>>>
>>>>>> 1) Add a:
>>>>>>
>>>>>> hw_control_set(struct led_classdev *led_cdev, bool 
>>>>>> enable_hw_control);
>>>>>
>>>>> Please note that we have support for hw patterns in the pattern 
>>>>> trigger.
>>>>> (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
>>>>> breathing pattern).
>>>>> We have also support for hw blinking in timer trigger via blink_set 
>>>>> op.
>>>>>
>>>>> In addition to that there is brightness_hw_changed sysfs attribute
>>>>> with led_classdev_notify_brightness_hw_changed() LED API.
>>>>>
>>>>> Couldn't they be used in concert to support the specific features
>>>>> of the device in question?
>>>>
>>>> I believe main issue here is this:
>>>>
>>>> Hardware can automatically control the LED according to the charging
>>>> status, or it can be used as normal software-controlled LED.
>>>>
>>>> I believe we should use trigger to select if hardware controls it or
>>>> not (and then add driver-specific files to describe the
>>>> details). Other proposal is in the mail thread, too.
>>>
>>> Right, so there are really 2 orthogonal issues here:
>>>
>>> 1) With this hardware the LED is either turned on/off automatically
>>> by the PMIC based on charging state; or it is under user control.
>>>
>>> This is different from the led_classdev_notify_brightness_hw_changed
>>> case, where the hardware may update the state underneath the driver,
>>> but the driver can still always update the state itself. In this case
>>> if the LED is in hw-control mode then the driver cannot turn it on/off.
>>>
>>> Pavel suggested modeling this with a new "hardware' trigger, where
>>> setting the trigger to this trigger will enable the hw-controlled
>>> mode and setting any other trigger will switch thing to the 
>>> user-controlled
>>> mode.
>>
>> We already do have hw_pattern file exposed by pattern trigger.
>> It can be used to set hw breathing mode using some device specific
>> syntax semantics, documented in dedicated ABI documentation.
>> It was introduced for similar case, see
>> Documentation/ABI/testing/sysfs-class-led-driver-sc27xx.
> 
> Ah I see, yes that could be used, the pattern would just be a single
> integer specifying the cycle time in milliseconds, as nothing
> else is configurable.

I depends on how the pattern looks like. If it is breathing then
we'd need more than one value.

> I think that should work fine, which means that we can use the timer and
> pattern trigger support for the blinking and breathing modes.
> 
> That still leaves the switching between user and hw-control modes,
> as discussed the hw-controlled mode could be modelled as a new "hardware"
> trigger, but then we cannot choose between on/blink/breathing when
> in hw-controlled mode. As Pavel mentioned, that would require some
> sort of composed trigger, where we have both the hardware and
> timer triggers active for example.
> 
> I think it might be easier to just allow turning on/off the hardware
> control mode through a special "hardware_control" sysfs attribute and
> then use the existing timer and pattern triggers for blinking / breathing.

Pattern trigger exposes pattern file by default and hw_pattern if
pattern_set/get ops are provided. Writing them enables software and
hardware pattern respectively.

-- 
Best regards,
Jacek Anaszewski
