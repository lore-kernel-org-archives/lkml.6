Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3588AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0488620818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfBVJSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:18:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40699 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfBVJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:18:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so1176266eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1q5UjpTnJE8uCbob/AkBjHZ5vgorQBug2pevyrC2UA=;
        b=YG5LLOcfWrENEMiuDCZYmLvV8JXN4hBI42kipGSHi3LJp80wOLaMydzLq/+Y47zPud
         uVEAVNaJU4AVdEzcCXksBXrbioee9pGyMG0IGBcZz7UcGlWqrsJ5Y711qjQazpfcD1Z+
         GBUZAuvipXv+lNWVT0zWg6xKk5LEGcuh/XYXU6ARH5p/Hhf77w/AHfXomNx+agQsryvK
         jpS0ARWZxQI2AXhBOjSjIXgZsdm34OCMx1IYr4+e5LBh1bSeKTDBxWdokaBe6l5QZ8+W
         YVR2VpenKZP9DaGBk3tdyd+OX8wVXY2R2uX/aN4LJys3oNUPGf7kqRn0b8LTtwoSYhEz
         v+uw==
X-Gm-Message-State: AHQUAuZFdWcyEcaEJ9yRcZFNKmBJ4W1HaFyjKMLJ/QstfvGlqWd/cbN/
        qAtmwf8ooXE90+jF2JQ5RKIpww==
X-Google-Smtp-Source: AHgI3IZbXbkBOMLgy6iuUyrrtglKrRS8tU4dCtxymEPRZLY97JGTVC9RQ+NOi6NJII5z0hLs0QkLJw==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr2474490edq.14.1550827091891;
        Fri, 22 Feb 2019 01:18:11 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f6sm155594eja.33.2019.02.22.01.18.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 01:18:11 -0800 (PST)
Subject: Re: [PATCH v2 2/2] extcon intel-cht-wc: Enable external charger
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190219212441.19391-1-jekhor@gmail.com>
 <20190219212441.19391-3-jekhor@gmail.com>
 <19f27109-434d-3e5e-c895-fdec0324572f@redhat.com>
 <CAKWEGV7rOzvyK5GHQc65XvtGd3Pe7Czccro=sjpoH0DbQ+h+Rg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b7a98801-87fa-ebdd-7142-485c3ec454fb@redhat.com>
Date:   Fri, 22 Feb 2019 10:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAKWEGV7rOzvyK5GHQc65XvtGd3Pe7Czccro=sjpoH0DbQ+h+Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-02-19 22:24, Yauhen Kharuzhy wrote:
> ср, 20 февр. 2019 г. в 18:53, Hans de Goede <hdegoede@redhat.com>:
>>
>> Hi,
>>
>> On 2/19/19 10:24 PM, Yauhen Kharuzhy wrote:
>>> In some configuration external charger "#charge enable" signal is
>>> connected to PMIC. Enable it at device probing to allow charging.
>>>
>>> Save CHGRCTRL0 and CHGDISCTR registers at driver probing and restore
>>> them at driver unbind to re-enable hardware charging control if it was
>>> enabled before.
>>>
>>> Tested at Lenovo Yoga Book (YB1-X91L).

<snip>

>>> @@ -400,6 +487,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>>>
>>>    disable_sw_control:
>>>        cht_wc_extcon_sw_control(ext, false);
>>> +     cht_wc_restore_initial_state(ext);
>>
>> The restore_initial_state will clober al changes made by the
>> cht_wc_extcon_sw_control call, so we do not need both. Thinking a bit
>> more about this I think it might be best to drop the state save/restore
>> code and just enable hw-control on exit unconditionally. We cannot be
>> sure that te initial state is sane, so just switching to hw-control on
>> exit seem best and requires less code.  Andy, what is your take on this?
> 
> On the other hand we don't know if HW mode is suitable for given
> hardware configuration.
> 
> We can suppose that if existing code with unconditionally switching to
> HW mode didn't cause
> any issues before than we can safely leave this for future discussions
> and add CHGDISCTRL restoring only.

The code would be a lot simpler if we also unconditionally put the chrgdis
pin back in hw control mode, then we only need your modifications to
cht_wc_extcon_sw_control() and we don't need the save / restore state
functions.

On my hardware with a whiskey cove PMIC the firmware comes up with 0x50 in
the CHGDISCTRL register, which means it is under hw control, so we would
normally end up restoring that. I believe your Yoga Book is similar, so
there really is no need for the save / restore state functions.

Regards,

Hans
