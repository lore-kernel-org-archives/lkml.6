Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524829997; cv=none;
        d=google.com; s=arc-20160816;
        b=IjndIaaZ657a9+pYNAqFf/Cux6nkIooGzgtWlMZ3Rjkc6gevfDCTne/Sr8heGozmbG
         WV7OcGklTSFw6Hv6778uA3tVxBybOpEHUAM2Zywc3R6wmf76zuwotOsH1v1nBmi8tLxT
         cLZjNW24cXT6qdDx44oAsFKV0oesDsBAljG32qOdPyanWwGVaI72F2hQT3fX/aXupAH4
         X5bkJSso2Yg4Jv90QIC7iZh8xjUbyuGmB9se1QJTnql2hhQi0ovhA3A05xnVBB89oQID
         K8dCpNfiahkwysevw+hqVuxcpLO9+uXsN/8NDzFPJbN6IgmcDaupdoa2ldSo4H2aPkXi
         9q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QiiSzbkNQpLBD2Jsn7Evhy3lMCkTWc6B2TNKJKgH7rc=;
        b=aAi/ibDr5rCeR+uRTFzL3guCc/SYqbTJsXxYo07cLtvaWV9+jIi2IhVTAn5CpN+NWh
         UimTShbcLmY9DPIYXD7pZLaYMc4XoGitsulA+/P55HgxDF8jCZZ6VmH6Z83/y9IKND69
         tYET6tu2QjFLU1FQxMSsC7OgNHh65/1igprdCB+hgTrrA7ElfSuT1YNQ0W+AlwA3t2qS
         yoepj26b1hbm2qo5ZNY32Rtpz6y8CR5RoATzngZBXurcE+w+njXeKsERshin8HfrvCmg
         X1azSdFNYbbp8iheJJCB8j4s/ZO0mPRdTRDF6HbmOitZh70gcQs+1RZ1O7bpTDJWtXwW
         XcLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=uTvT9VZh;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=uTvT9VZh;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZq6p+GULd/5YdAkUDUUAH21Wg4CRgisdtdkK8ZQXceQOJmeY1ngzJtgYuwrSHqwdm9c0y94B3+EtnfIhPNSn/8=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com> <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 27 Apr 2018 13:53:16 +0200
Message-ID: <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Arnd Bergmann <arnd@arndb.de>
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
X-GMAIL-MSGID: =?utf-8?q?1598900139046193361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>>> On 04/26/2018 12:31 PM, Rich Felker wrote:
>>
>> We have platforms out there which still use both board files and
>> device tree. They are still comercially supported and are not going
>> anywhere anytime soon. Some of these platforms are being actively
>> maintained and cleaned-up. An example is the DaVinci platform: David
>> has recently converted all the SoCs and boards to using the common
>> clock framework. I'm cleaning up some other parts too.
>>
>> The problem with the legacy board code is that a lot of things that
>> should be platform drivers ended up in arch/arm/mach-*. We're now
>> slowly moving this code to drivers/ but some initialization code
>> (timers, critical clocks, irqs) needs to be called early in the boot
>> sequence.
>
> Right, and that's very good work.
>
>> When you're saying that we already have all the OF_DECLARE macros, it
>> seems to me that you're forgetting that we also want to keep
>> supporting the board files. So without the early platform drivers we
>> need to use a mix of OF_DECLARE and handcrafted initialization in
>> arch/arm/mach-* since we can't call platform_device_register() that
>> early. This blocks us from completely moving the should-be-driver code
>> to drivers/, because these drivers *need* to support both cases.
>
> The OF_DECLARE_* functions were initially added as a way to
> remove board files that just consist of callbacks into early
> initialization for some subsystems. As long as you still have
> board files and you are looking for a way to reuse code between
> OF_DECLARE_* functions and board files, why not just leave
> those functions globally visible and call them from the non-DT
> board files?
>
>> The main problem with OF_DECLARE is that although we have
>> corresponding device nodes, we never actually register any real linux
>> devices. If we add to this the fact that current early platform
>> drivers implementation is broken (for reasons I mentioned in the cover
>> letter) the support gets really messy, since we can have up to three
>> entry points to the driver's code. Other issues come to mind as well:
>> if we're using OF_DECLARE we can't benefit from devm* routines.
>
> Right, the devm_* problem has come up before.
>
>> My aim is to provide a clean, robust and generic way of probing
>> certain devices early and then converting them to actual platform
>> devices when we're advanced enough into the boot sequence. If we
>> merged such a framework, we could work towards removing both the
>> previous early platform devices (in favor of the new mechanism) and
>> maybe even deprecating and replacing OF_DECLARE(), since we could
>> simply early probe the DT drivers. Personally I see OF_DECLARE as a
>> bigger hack than early devices.
>>
>> My patch tries to address exactly the use cases we're facing - for
>> example by providing means to probe devices twice (early and late) and
>> to check the state we're at in order for users to be able to just do
>> the critical initialization early on and then continue with regular
>> stuff later.
>
> Maybe the problem is reusing the name and some of the code from
> an existing functionality that we've been trying to get rid of.
>

I'm not reusing the name - in fact I set the prefix to earlydev_
exactly in order to not confuse anyone. I'm also not reusing any code
in the second series.

> If what you want to do is completely different from the existing
> early_platform implementation, how about starting by moving that
> out of drivers/base/platform.c into something under arch/sh/
> and renaming it to something with an sh_ prefix.
>

Yes, this is a good idea, but what about the sh-specific drivers that
rely on it? Is including headers from arch/ in driver code still an
accepted practice?

> Let's just leave the non-DT part out of it by making it sh specific.
> Then we can come up with improvements to the current
> platform_device handling for DT based platforms that you can
> use on DT-based davinci to replace what currently happens on
> board-file based davinci systems, without mixing up those
> two code paths too much in the base driver support.
>

I don't see why we wouldn't want to unify these two cases. The best
solution to me seems having only one entry point into the driver code
- the probe() function stored in platform_driver - whether we're
probing it from DT, platform data, ACPI or early boot code.

Best regards,
Bartosz Golaszewski
