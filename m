Return-Path: <bgolaszewski@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524837940; cv=none;
        d=google.com; s=arc-20160816;
        b=RS9r76osrq8rhE6a30r9+/EdOM3aamHfVkhSru/7UNsxMXdYpmv6/WVwdLLTFsW2Bp
         8nvZZGpSSO1pxoSkxLfJezSMdzzSnnAmL2FJpTPK/izLRGMcJzjRsjxlUg49jRnz52X7
         0Uecnmjl3Y5gBLxJXkvKb7SLeyTHZzIFojknkfz56QLUlmwqVsDiZIpiI/p413KNVCt2
         AOeNTP6tZ4R+Sah94ogImYlimwma6XgRKbubJ9Y4nU1Cs6/2EYF/BvSIWGVBKx73/Exy
         5hBUmwChMqAAN4p/Lr24JX3lXjaPhJ/TGCT04jXrkBOqRPLM8Pfc9QZBB88zDnx55j0B
         rwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=BFV6PpldPWAZdnkvAhcr1RZvxABEwkU/8vbkhzSzrnc=;
        b=0XIyOQ0okT/PJQ/RREev9lNvKnKAbKJVJb2h9i3OhH/kH3MWZMLjYMlP0HUnPqjv6p
         B0q6xlKnI2/8Jgro4fFNmEdUcRmEvqkaqBiADj7afCppqK5bHjl7/EzsEta+LHocp0/z
         TLuI6bfAgZTAlkRVeSq1a7M0mumNeEhkTYgKZPIWuxVx1vOOgkziZOmOOn+nU6CucNAL
         +UTANlXDnt9L5s871fvfAIfxT1F3e8Tx2fdE5eL3kocvtVc3Csyvz/DXgwQnjeYSDRzI
         7QrV1cuTkt95HTjM079QM7IIlsv/fT1iuOT1t2Ply9Sh0paaOZpGGmw/AchbdydnGk+P
         8VYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=ahzBfWCq;
       spf=softfail (google.com: domain of transitioning bgolaszewski@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=bgolaszewski@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=ahzBfWCq;
       spf=softfail (google.com: domain of transitioning bgolaszewski@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=bgolaszewski@baylibre.com
X-Google-Smtp-Source: AB8JxZrjB38alz4MwMbZzXGJKIibd0z8zl3bNgZ6z6/6GGCC1HQ0BDXn1R87V9o+waPGuv8HzMCl0zYtoDZUaFInwaQ=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com> <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 27 Apr 2018 16:05:39 +0200
Message-ID: <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>, Rich Felker <dalias@libc.org>,
	Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598908468361000722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-27 14:40 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Apr 27, 2018 at 1:53 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
>>> <bgolaszewski@baylibre.com> wrote:
>>>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>>> My patch tries to address exactly the use cases we're facing - for
>>>> example by providing means to probe devices twice (early and late) and
>>>> to check the state we're at in order for users to be able to just do
>>>> the critical initialization early on and then continue with regular
>>>> stuff later.
>>>
>>> Maybe the problem is reusing the name and some of the code from
>>> an existing functionality that we've been trying to get rid of.
>>>
>>
>> I'm not reusing the name - in fact I set the prefix to earlydev_
>> exactly in order to not confuse anyone. I'm also not reusing any code
>> in the second series.
>
> Ok.
>
>>> If what you want to do is completely different from the existing
>>> early_platform implementation, how about starting by moving that
>>> out of drivers/base/platform.c into something under arch/sh/
>>> and renaming it to something with an sh_ prefix.
>>>
>>
>> Yes, this is a good idea, but what about the sh-specific drivers that
>> rely on it? Is including headers from arch/ in driver code still an
>> accepted practice?
>
> I think it's fine here, since we're just move it out of the way and
> there are only very few drivers using it:
>
> drivers/clocksource/sh_cmt.c:early_platform_init("earlytimer",
> &sh_cmt_device_driver);
> drivers/clocksource/sh_mtu2.c:early_platform_init("earlytimer",
> &sh_mtu2_device_driver);
> drivers/clocksource/sh_tmu.c:early_platform_init("earlytimer",
> &sh_tmu_device_driver);
> drivers/clocksource/timer-ti-dm.c:early_platform_init("earlytimer",
> &omap_dm_timer_driver);
> drivers/tty/serial/sh-sci.c:early_platform_init_buffer("earlyprintk",
> &sci_driver,
>
> For timer-ti-dm, it seems like a leftover from old times that can
> be removed. The other four are shared between arch/sh and
> arch/arm/mach-shmobile and already have some #ifdef
> to handle those two cases.
>

I'm also seeing that we also call early_platform_cleanup() from
platform_bus_init(). Any ideas for this one?

>>> Let's just leave the non-DT part out of it by making it sh specific.
>>> Then we can come up with improvements to the current
>>> platform_device handling for DT based platforms that you can
>>> use on DT-based davinci to replace what currently happens on
>>> board-file based davinci systems, without mixing up those
>>> two code paths too much in the base driver support.
>>
>> I don't see why we wouldn't want to unify these two cases. The best
>> solution to me seems having only one entry point into the driver code
>> - the probe() function stored in platform_driver - whether we're
>> probing it from DT, platform data, ACPI or early boot code.
>
> I'd rather keep those separate and would prefer not to have
> that many different ways of getting there instead. DT and
> board files can already share most of the code through the
> use of platform_device, especially when you start using
> device properties instead of platform_data, and the other
> two are rare corner cases and ideally left that way.
>
> The early boot code is always special and instead of making
> it easier to use, we should focus on using it as little as
> possible: every line of code that we call before even
> initializing timers and consoles means it gets harder to
> debug when something goes wrong.
>

I'm afraid I don't quite understand your reasoning. I fully agree that
devices that need to be initialized that early are a rare corner case.
We should limit any such uses to the absolute minimum. But when we do
need to go this way, we should do it right. Having a unified mechanism
for early devices will allow maintainers to enforce good practices
(using resources for register mapping, devres, reusing driver code for
reading/writing to registers). Having initialization code in machine
code will make everybody use different APIs and duplicate solutions. I
normally assume that code consolidation is always good.

If we add a way for DT-based platform devices to be probed early - it
would be based on platform device/driver structures anyway. Why would
we even want to not convert the board code into a simple call to
early_platform_device_register() if we'll already offer this API for
device tree?

Best regards,
Bartosz Golaszewski
