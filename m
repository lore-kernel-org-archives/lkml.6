Return-Path: <nsekhar@ti.com>
X-Google-Smtp-Source: AB8JxZodFNHYutvPuLZW0urJvy/fbd+0rtfEvmRYYlHPDHx9Urcy8/sTyU+3gIo6axCo0huyD1SW
ARC-Seal: i=1; a=rsa-sha256; t=1524557934; cv=none;
        d=google.com; s=arc-20160816;
        b=zuaYNAv8C/5Ugl6PSlJh/aqNcVkgS9L95P4hqr6PvHXNVM2Cft/Zy79BtHn7MGvU96
         aa9zIbi4KGZMLETYog0k1xKYzyl4pw3fMOxhBfuoiBCQBGTHQaFfd2pvocc3WEz7IZa7
         BeXPT8y4cl3hDPTMah+f1OOY+/hPembCkrosS5lxip1Hr3JnanfjVS4qT9tqq0m1c8Hy
         G+tEs/lCUh2UXgFsD3NyntuG9BTP9GFkHhigfr9XvSsKPhua+jCAlE1NmD71IEUN1jTE
         rmO1dNmhQpo7HzbNL86VgpYwcjje1XM1EN7VjO95TXS2olXQTG21h7kHk+chkQzIHYnr
         nqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=gR3a9Hc8vfK8irpTN0kOJ3zhsg41q8TVd5RJ1/9ROc8=;
        b=rtnAFG60InVfUARWPzUMRVZRz6sGuW3IqBp6RqOTF3MsM+IR/bSrtA7cEoG6UzQfv+
         DoO4FZtdAL/+OeS5yiCbI95mAEnwkorYgUGj+vRkSL4lOgWphVCG8BSwKAGXQayGnldz
         8hvqDiauPdcZxIxHGCV/6Qub4kHoaAsm5v59O762Riq+aOEkL7gVv+hyzn7wO0B8Ctoy
         rPHZiyhPUsqOVp0CwY0miaOqAZjC0PvqjhR1ZB9ObjIVt0/okLaZtK68/M9PM9/GkUOE
         GBvRYtVZx1eoznpigxwr+CDFEuzF3eRy8YY6/Q6nCgo7YDEupftfIVs7969E4G1ATs2/
         raRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=CivYBeN/;
       spf=pass (google.com: domain of nsekhar@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=nsekhar@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=CivYBeN/;
       spf=pass (google.com: domain of nsekhar@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=nsekhar@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [RFC work-in-progress 0/7] of: platform: use early platform
 routines instead of OF_DECLARE
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>
CC: Kevin Hilman <khilman@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Linux ARM
	<linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bgolaszewski@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20180423183814.20615-1-brgl@bgdev.pl>
 <b50d1a0d-4585-5c2b-bfc7-4f2ad023b753@lechnology.com>
 <CAMRc=Md0vKTtYXOWAHv7mEZUqBWG7U4oF26xMwSL_u_wPZn9rg@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <71b04060-b33c-d566-f5a5-aba506c96cdd@ti.com>
Date: Tue, 24 Apr 2018 13:48:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Md0vKTtYXOWAHv7mEZUqBWG7U4oF26xMwSL_u_wPZn9rg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598563237980894406?=
X-GMAIL-MSGID: =?utf-8?q?1598614860633243414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 24 April 2018 12:56 PM, Bartosz Golaszewski wrote:
> 2018-04-23 23:38 GMT+02:00 David Lechner <david@lechnology.com>:
>> FYI: It looks like the CC for Stephen and Arnd was messed up, so I
>> fixed.
>>
> 
> Thanks!
> 
>> On 04/23/2018 01:38 PM, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Hi David, Sekhar,
>>>
>>> since platform devices are generally considered more desirable than
>>> CLK_OF_DECLARE, TIMER_OF_DECLARE etc. and we need to figure out how to
>>> handle the clocks that need to be initialized early in the boot
>>> process on DaVinci, I thought that I could give the early_platform
>>> mechanism a try.
>>>
>>> This API is only used on one architecture (sh) but seems to work just
>>> fine on ARM. It allows to register early platform drivers and then
>>> probe them early in the boot process. So far only machine code is
>>> supported but with a bit of hacking I was able to probe a DT device.
>>>
>>> This is a very dirty and far-from-upstream proof of concept that allows
>>> to probe the (so far dummy) davinci timer platform device during the
>>> call to init_time (from machine_desc).
>>>
>>> The idea is to have a special compatible fallback string: "earlydev"
>>> that similarily to "syscon" would be added to device nodes that need
>>> early probing. Then we'd call the of_early_platform_populate()
>>> function that would find all compatible nodes and populate them
>>> long before all the "normal" nodes.
>>
>>
>> FWIW, "earlydev" sounds like a driver implementation detail, so not
>> something that should be included in the device tree. We only need
>> this because Linux needs a clocksource early on, but that doesn't
>> mean that all device tree users need to do the same.
>>
>> I'm sure it makes things easier for a proof of concept though. :-)
>>
> 
> We already have "syscon" which too is more an implementation detail
> than HW description. I should have probably Cc'ed Rob Herring. I'll do
> it with a more polished version I should have today.

Yeah, we should check with DT maintainers here. Even if there is push
back on this, I suppose we can make of_early_platform_populate() take a
list of compatible strings whose DT nodes should be considered early
platform devices?

>>> This would allow us to make the davinci timer a normal platform device
>>> and possibly also probe the psc and pll drivers earlier than we do now.
>>>
>>> The early platform API even allows us to check if we're being probed
>>> early in probe() so we can possibly probe the driver twice if needed:
>>> only doing the critical stuff first and then completing the process
>>> later.
>>>
>>> If you think this is a good idea, I would like to continue on that
>>> and eventually make it an alternative to OF_DECLARE macros.
>>>
>>> For a quick conversion of the davinci timer to a platform driver
>>> I image we'd need to use platform data lookup that would be passed
>>> to of_early_platform_populate().
>>
>>
>> On the surface, it certainly sounds like a good idea to me. Do we have
>> access to struct device of the platform device when using this early
>> platform device? I remember when I was working on the clock drivers, I
>> tried registering a platform device in the init_time callback but the
>> kernel crashed because kobj stuff was not initialized yet. I'm guessing
>> that the early platform device somehow works around this.
>>
> 
> Yes, it seems we do. I was getting kobj stack dumps too when trying to
> register a device using just platform_device_register() and it went
> away as soon as I switched to early platform.

I agree, it sounds like a good idea to use for clock and timer devices.
Thanks for looking into this. Looking forward to the more polished version.

Thanks,
Sekhar
