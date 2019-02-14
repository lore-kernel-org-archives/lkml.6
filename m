Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB4E2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405887AbfBNLbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:31:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38322 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbfBNLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:31:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so4719062edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 03:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IsHGYw/1NQ1tlRUZNhd3dMpb5nLppXtN2TKdOd5GNfA=;
        b=s5FHz1geNDD/63Pa2gmDZr7bUPlpju3EqeMEoFEqV/y67Yi0AouW6re83ITTQF6kOe
         byz4+3ffGA/gE6hM+Vp+jCz3p75JsJXwZQcDdM0awJCfmtmxX/6Afdl9ge46vYJyavBm
         g4J7Lgxu/ohYocRfBi736JjQuFv/Kq3wZjuCfKfCHrPAUAS2wywPCZYLSekf78c+uf6s
         iOwaBIrj1zH096tv5wRv8P6nJqMiZ4CXKeS9KW2DnE++gdiRVUHBLRVVGYgpkVlAu8Cp
         XT9EWY4h0mCUhoEINN9wogDFxSeYHLkHtZK9vTPiDDknS0lNFIfZcnO7mdfx81rp5pig
         UuaQ==
X-Gm-Message-State: AHQUAuYooYgo6Z0h20oW/qUKtAEvEKirgllRh6y/iR0eSdnVQY9pQCjS
        MtpYo4xw2+Y9lxwBJGbEVfdbvg==
X-Google-Smtp-Source: AHgI3Ib4pMZNxFmVH8yOOTMxg0ezryK/rg3YQ+p41NcWEfdO8KErtz3SYmNdufvFhip119056L34Wg==
X-Received: by 2002:a17:906:1e43:: with SMTP id i3mr2413967ejj.64.1550143908957;
        Thu, 14 Feb 2019 03:31:48 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z60sm587827ede.82.2019.02.14.03.31.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 03:31:47 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com> <20190214111423.GE6132@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
Date:   Thu, 14 Feb 2019 12:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214111423.GE6132@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-02-19 12:14, Pavel Machek wrote:
> Hi!

<snip>

>> That assumes that breathing is the default setting on all hardware
>> and again I don't see why not to export this functionality to
 >
> Save the status on boot, then restore it on rmmod/reboot/poweroff? :-).

Which works until the system freezes one time. I believe that
if we are going to do a LED driver for the charging LED on these
devices, we MUST offer a way to put it back in its original
state, even if the state is foo-barred at bootup.

>> userspace. Just because something does not fit in the existing
>> API is IMHO not a good reason to not expose it to userspace.
>>
>> I suggest that we deal with this special case by adding 3 custom
>> sysfs attributes:
>>
>> 1) "mode" which when read, prints, e.g. :
>> manual [on-when-charging]
> 
> While this allows _user on console_ to control everything using echo,
> it is not suitable for applications trying to control LEDs.
> 
> As there's nothing special about the case here, I believe we should
> have generic solution here.
> 
> My preffered solution would be "hardware" trigger that leaves the LED
> in hardware control.

As you explained in the parts which I snipped, there are many
devices which have a similar choice for a LED being under hw or
user control. I can see how this looks like a trigger and how we
could use the trigger API for this.

I believe though, that if we implement a "virtual" (for lack of
a better word) trigger for this, that this should be done in the
LED core. I can envision this working like this:

1) Add a:

hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);

Callback to struct led_classdev which when implemented by a driver
like the current PMIC LED controller would do what it says.

2) Have the core create and register a virtual hardware trigger the
first time a LED cdev which has this callback gets registered.

When configured as the trigger for this LED device this trigger calls
hw_control_set(cdev, true) and when unregistered calls
hw_control_set(cdev, false)

Taking a quick look at the trigger code, a problem with this is
that normally any trigger can work with any led device, so this
"hardware" trigger will show up in the list of possible
triggers for each device.

This problem can be solved by making the activate method for the
hardware trigger check the classdev has a hw_control_set callback
and if not return -EINVAL, or maybe -ENXIO but still this is somewhat
inconsistent with other triggers, which AFAIK work with any LED.

> Alternatively I could imagine "hardware" sysfs attribute, containing
> 0/1, with 0==software controlled, 1==hardware controlled.

Hmm, maybe call it "hardware_controlled" instead ? Otherwise this
would work for me and I would personally prefer this solution. This
could even be done in the LED core using the hw_control_set callback
I proposed, to make sure it is handled consistently between devices.

> The rest of attributes would have to be Cove-specific, yes (but still
> should fit with the rest of LED subsystem).

Right, I see that the triggers attribute already uses the fmt where
on "cat" all options are listed and the current active one has [] around it,
so I think the pattern and frequency attributes I proposed should work
well, although thinking more about this I believe the freq. attribute should
be called pattern_freq to make clear it applies to blinking / breathing
set through the pattern attribute.

Regards,

Hans
