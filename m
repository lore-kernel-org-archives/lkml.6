Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5EDC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18BD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIQzr7if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfARWNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:13:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36410 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbfARWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:13:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so12906589ljk.3;
        Fri, 18 Jan 2019 14:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zQ1kqZSzZo+d78RYI0f6TjG3S0YXKTweVvw/l5AqbU=;
        b=QIQzr7ifH17lP81Eywgww1/hynQLpp5E52oItG2zKvA3LMnlqJvz2kvfdE1Ox3undQ
         /3lHW7pH7XXmxpryAzAf4RqmyOBJol+xZaWoFLSxdp6TKt6qHY7l1RoMHMBZOQJ30hzz
         X7e1y0Y1nN03RckfTTdi/ozo/pK4gRS//e9Wz1jKilLtCLFIMy9NjySQvoqMw6ovNSe/
         Yhqk1p53SLmUuQ3SUgVfao52ZfFr/RH7vhToMNZWQJeZ/CVKCu8+60BtXnyi6ShZZQO+
         e0BGZz+MaHcu1i3jmt3ZfzfAAMVHNPLzpr3JKzdew/2r6bjJuE6gJdPshqrq1qqOnD6M
         5XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zQ1kqZSzZo+d78RYI0f6TjG3S0YXKTweVvw/l5AqbU=;
        b=SvvY5H+gb0UA04cp/yPPxXdLOfjYYi/ij4Q4Ub3SmIXA+6OMuL4+ayICsNVKngcbzQ
         nyppn0SMS3XPGsFQdgABa0pA+84YrXO7Hy1zFpBpW739eme3P91Ph1++QjR1SaXqq5//
         bW7Yk7EA+CMnZrgIVYR+Q2vEXZsl1d7FjDj1YPvSw4ReaOHwtY5BJE6lZ3OgElfEarEy
         XZFWP2IhQxsmJKciXTSamD0Fev43TXWQylqHy7bZMHL+RFjX1lyNvue+XtQxKV/qz+4o
         grYWkUkcLYzXfZzTy2y14qC37hHXf2ZJT9oFIkkdReRcnz8jdBf/ni1CKowh5Ss/1Azq
         nNTQ==
X-Gm-Message-State: AJcUukeCAui2MqLPVXUjRhgPMRnO5L3xMsPFJOXP7B+ffNkwUf+sYXOo
        2ci6VFEB+b1PDVstjEhUmbc=
X-Google-Smtp-Source: ALg8bN6fiFdrco/EW47qh1v3eXfGQC7jLifhC2eXB+rnWQiyLOGONOoQVRzQIfCwpZehjzi6ygxa1A==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr12993062ljh.63.1547849593386;
        Fri, 18 Jan 2019 14:13:13 -0800 (PST)
Received: from [192.168.1.18] (bkq208.neoplus.adsl.tpnet.pl. [83.28.184.208])
        by smtp.gmail.com with ESMTPSA id b25sm979385lfa.96.2019.01.18.14.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 14:13:12 -0800 (PST)
Subject: Re: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX
 family of the RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dachaac@gmail.com, robh+dt@kernel.org
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com> <20190118000235.GB27661@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <61fa89eb-c12e-8f9c-9457-9d6d17ba7717@gmail.com>
Date:   Fri, 18 Jan 2019 23:13:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118000235.GB27661@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 1/18/19 1:02 AM, Pavel Machek wrote:
> Hi!
> 
> 
>>> I am willing to work with you on the HSV and adapting the LP50xx part to this framework.
>>> Or any RGB framework for that matter.  I still don't agree with the kernel needing to declare colors
>>>   maybe color capabilities but not specific colors.
>>
>> Dan, if you have a bandwidth for LED RGB class implementation
>> then please go ahead. It would be good to compare colors produced
>> by software HSV->RGB algorithm to what can be achieved with
>> LEDn_BRIGHTNESS feature.
> 
> Don't get me wrong, I'd like to see LED RGB class implementation. But
> it will delay merge of this driver.
> 
> If we want to do that, we should first discuss the requirements, and
> then come up with interface.. and only then we can talk about the
> driver code.
> 
> That's why I believe preferable way would be to merge the driver using
> the existing interface.
> 
> Of course, first designing RGB LED class and then merging the
> driver.. is okay with me. But lets not rush the class because there's
> driver waiting for it.
> 
>> The requirements for LED RGB class as I would see it:
>>
>> sysfs interface:
>>
>> brightness-model: space separated list of available options:
>> - rgb (default):
>>    - creates color file with "red green blue" decimal values
>>    - creates brightness file
>> 	a) for devices with hardware support for adjusting color
>>             intensity it maps to corresponding register
>>          b) for the rest writing any value greater than 0 will result
>>             in setting all color registers to max
>> - hsv:
>>    - creates color file with "h s v" values - it shall
>>      use software HSV->RGB algorithm for setting color registers
>>
>> - any other custom color ranges defined in DT, but it can be covered
>>    later
>> - other options?
> 
> First, I think we want to decide if RGB LED should be presented as
> 3 LEDs or as 1 LED... and what to do with existing RGB leds being
> presented as 3 LEDs.
> 
> I don't think we want to support both RGB and HSV in the kernel. It is
> math, and not a nice one.
> 
> Yes, both have advantages and disadvantages, but having _both_ in
> kernel has disadvantages of both.
> 
> One way I could imagine the interface:
> 
>      RGB LED presented as one LED.
> 
>      brightness -- controls brightness of whole RGB module.

What algorithm would be used for mapping brightness levels to RGB values
in case of devices without hardware support for that?

>      pwm_channels -- "1000 240 300" -- "red part should be full on, green
>      should be pwm controlled to 240/1000, blue should be 300/1000"
> 
>      pwm_white -- "1000 500 400" -- tells userspace what to write to PWM
>      channels to get approximately white color.
> 
>      This would assume that RGB LEDs are always pwm controlled. That
>      seems to be true for hardware I seen.

Why pwm in the file names? I don't see any gain and only possible
problems. Many LED controllers use current level and not PWM
for driving LEDs.

Even mainline RGB LED driver: drivers/leds/leds-lp3952.c [0].

s/pwm/color/

Besides white also other color presets could be defined in DT.

>      + no complex math in kernel
> 
>      + userspace knows enough to display arbitrary colors
> 
>      + userspace can use full range of available PWM intensities
> 
>      + existing triggers will work nicely
> 
>      - userland needs to do non-trivial math to get colors it wants
> 
>      - not sure how to migrate existing devices
> 
> Thoughts? Other possible interfaces?


[0] https://www.mouser.com/ds/2/348/bd2802gu-e-210449.pdf

-- 
Best regards,
Jacek Anaszewski
