Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524832835; cv=none;
        d=google.com; s=arc-20160816;
        b=dL0/7fjsAbPpuHscPUrNWc927lN0iL4iVztyvrv2Kan+HioZAHCRtLVnRd8FjHJTe3
         XF+fRg92brOysjMrstRucXR1oz5sxeP5TDtZ++LheueRpnVSi6DTdD75WCG+X7qih2I8
         suBR6nxxdjNANVEqNyWcODoVOkZY+WTtUij+Lo30OLSgnKxIaEbzHJXshTAmeqqpbGIK
         kX4WKE1YOvhmka3hXQR+6gofh2lLSD+JGspkV8q3/Z/U8Ol8bGXVg/PnktPdN/eY87+/
         NQVcmmkE9guuJs9uWCkp9dmY6ayvY9PNSqyt/6fewWJUNULcEGNx10BpHSAztMldK7sS
         1pKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AyVsQDJUwRFdnPduJmQsY4nz+Ewwpz/IgZUA6Hl+K3k=;
        b=Q+s419o0G/YoX8V9HO7rV80HzD6ntG0yW6vo8XwBd3KWdcL22N8kgEfRXIm/og1/ks
         ZkFPgUWidxC3ZoEgY3LhlXWrXRczqiHVOtrhYcNzTnYLchVE7hI1P7/dIV9z6hCDeBY2
         J42QbF8she8pe+cM2YiD9GEMsrRdzhbqeNmZw5FVMLfWZTEIVKmYElC9xR0XIeYPpsQm
         fiIdX6s6w++0wVbqsYtvu+6J9K2jPixBexXCgSbPmdQGNZ0OGjLN6f2IcZU+e5xu5Coj
         aKWL/kTrM2PM7EC/TkDa1RSBXUKb2w9ncOXYZjg0+9KpyZxreWGs7AUbHlnAAHsVUYwn
         LheQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iWaVlR/7;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iWaVlR/7;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZrXBRo7+okiVyivDhxJbotAnU5ISVxUoZ3+8+oxPCiQRQZmBHuOyWiaKF9dfZ/6sNi90OwWWUV9GAoYqC+RXPg=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com> <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 14:40:34 +0200
X-Google-Sender-Auth: E7aKCnRSOm0jdjVWNGX7yN3MWvA
Message-ID: <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, David Lechner <david@lechnology.com>,
	Rich Felker <dalias@libc.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1598903115825408481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 1:53 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
>> <bgolaszewski@baylibre.com> wrote:
>>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>> My patch tries to address exactly the use cases we're facing - for
>>> example by providing means to probe devices twice (early and late) and
>>> to check the state we're at in order for users to be able to just do
>>> the critical initialization early on and then continue with regular
>>> stuff later.
>>
>> Maybe the problem is reusing the name and some of the code from
>> an existing functionality that we've been trying to get rid of.
>>
>
> I'm not reusing the name - in fact I set the prefix to earlydev_
> exactly in order to not confuse anyone. I'm also not reusing any code
> in the second series.

Ok.

>> If what you want to do is completely different from the existing
>> early_platform implementation, how about starting by moving that
>> out of drivers/base/platform.c into something under arch/sh/
>> and renaming it to something with an sh_ prefix.
>>
>
> Yes, this is a good idea, but what about the sh-specific drivers that
> rely on it? Is including headers from arch/ in driver code still an
> accepted practice?

I think it's fine here, since we're just move it out of the way and
there are only very few drivers using it:

drivers/clocksource/sh_cmt.c:early_platform_init("earlytimer",
&sh_cmt_device_driver);
drivers/clocksource/sh_mtu2.c:early_platform_init("earlytimer",
&sh_mtu2_device_driver);
drivers/clocksource/sh_tmu.c:early_platform_init("earlytimer",
&sh_tmu_device_driver);
drivers/clocksource/timer-ti-dm.c:early_platform_init("earlytimer",
&omap_dm_timer_driver);
drivers/tty/serial/sh-sci.c:early_platform_init_buffer("earlyprintk",
&sci_driver,

For timer-ti-dm, it seems like a leftover from old times that can
be removed. The other four are shared between arch/sh and
arch/arm/mach-shmobile and already have some #ifdef
to handle those two cases.

>> Let's just leave the non-DT part out of it by making it sh specific.
>> Then we can come up with improvements to the current
>> platform_device handling for DT based platforms that you can
>> use on DT-based davinci to replace what currently happens on
>> board-file based davinci systems, without mixing up those
>> two code paths too much in the base driver support.
>
> I don't see why we wouldn't want to unify these two cases. The best
> solution to me seems having only one entry point into the driver code
> - the probe() function stored in platform_driver - whether we're
> probing it from DT, platform data, ACPI or early boot code.

I'd rather keep those separate and would prefer not to have
that many different ways of getting there instead. DT and
board files can already share most of the code through the
use of platform_device, especially when you start using
device properties instead of platform_data, and the other
two are rare corner cases and ideally left that way.

The early boot code is always special and instead of making
it easier to use, we should focus on using it as little as
possible: every line of code that we call before even
initializing timers and consoles means it gets harder to
debug when something goes wrong.

      Arnd
