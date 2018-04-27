Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524824290; cv=none;
        d=google.com; s=arc-20160816;
        b=wLy+7BKHtpCa9LKnZ+DuBSGp/Edu6rZb02EmvTVHQsA1Zao5wvj5FPM4De+4DvJJq5
         Zj798TqoHrH7Plfe8CFk9HD1d3w5TL3oL55MoxWV2gPFEyGnop1Fpv1q72WcpxO/LJmj
         sQGQTWf2aQFAQc9lamNPWBHV22ug+FjeLZh8kHDk1R5lU2Oh9Gcp29jODSW+5c+2VPZ9
         CgCjlUV5DTR+PCzhr8J07tIlPmKhEXEVirsl3RG1+/mngR2HWbiJhKVCL2zulM/lCR0H
         eS4B2EQm2YeiNPgC5VlIG8+Ec3e2upTELfzlWMn68Hgu3/Ud6PHckXCQYlcRLdih/M+h
         8R5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Z2L0H80XesDdwERbKjUp2wGPOQc89Q1yDFcJyM2th3E=;
        b=qOStP6dejW5aE8/rjwOdWIlnkDzlfwccxwGPouBpAacWG1H9yXy3/YHLx31+l5FIHG
         oMymZ6srR95VPouolMP7ooNBweMDMYk4kuevlkPpOKcfAnwEnkxm6P7spC/qb3dErZg4
         2I1DKLcbgZoVKKz70IzBfMu6pxgVhRrMYIhefmIu9AAZKkCdcKVpnxoR6NL0CRanKdFb
         v7zl5v+6OSy0peXHyWIyck7E6JH3UGMJfhHyJGqBAvHPxCn6C1tYreb0rx68wGMa6/hV
         0Z99Oyf2s9gmZ+AifzSTntP9rm424D5Mzo5FjHsV+n+GzoGqsFQ5iRiElycomNUeyg+z
         PAzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rZMbIC6S;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rZMbIC6S;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZoE/DzkpBrZ0H8uB/n17P97+EHevkzMDsCpET8Jjl/MMkNbQoHzUv84vKRNvNwJmzb03HSER7oWsawfvrHUQds=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 12:18:09 +0200
X-Google-Sender-Auth: P3WDmTlGndAHNnaeRPsyF2Sfrz0
Message-ID: <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: David Lechner <david@lechnology.com>, Rich Felker <dalias@libc.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1598894155035376292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>> On 04/26/2018 12:31 PM, Rich Felker wrote:
>
> We have platforms out there which still use both board files and
> device tree. They are still comercially supported and are not going
> anywhere anytime soon. Some of these platforms are being actively
> maintained and cleaned-up. An example is the DaVinci platform: David
> has recently converted all the SoCs and boards to using the common
> clock framework. I'm cleaning up some other parts too.
>
> The problem with the legacy board code is that a lot of things that
> should be platform drivers ended up in arch/arm/mach-*. We're now
> slowly moving this code to drivers/ but some initialization code
> (timers, critical clocks, irqs) needs to be called early in the boot
> sequence.

Right, and that's very good work.

> When you're saying that we already have all the OF_DECLARE macros, it
> seems to me that you're forgetting that we also want to keep
> supporting the board files. So without the early platform drivers we
> need to use a mix of OF_DECLARE and handcrafted initialization in
> arch/arm/mach-* since we can't call platform_device_register() that
> early. This blocks us from completely moving the should-be-driver code
> to drivers/, because these drivers *need* to support both cases.

The OF_DECLARE_* functions were initially added as a way to
remove board files that just consist of callbacks into early
initialization for some subsystems. As long as you still have
board files and you are looking for a way to reuse code between
OF_DECLARE_* functions and board files, why not just leave
those functions globally visible and call them from the non-DT
board files?

> The main problem with OF_DECLARE is that although we have
> corresponding device nodes, we never actually register any real linux
> devices. If we add to this the fact that current early platform
> drivers implementation is broken (for reasons I mentioned in the cover
> letter) the support gets really messy, since we can have up to three
> entry points to the driver's code. Other issues come to mind as well:
> if we're using OF_DECLARE we can't benefit from devm* routines.

Right, the devm_* problem has come up before.

> My aim is to provide a clean, robust and generic way of probing
> certain devices early and then converting them to actual platform
> devices when we're advanced enough into the boot sequence. If we
> merged such a framework, we could work towards removing both the
> previous early platform devices (in favor of the new mechanism) and
> maybe even deprecating and replacing OF_DECLARE(), since we could
> simply early probe the DT drivers. Personally I see OF_DECLARE as a
> bigger hack than early devices.
>
> My patch tries to address exactly the use cases we're facing - for
> example by providing means to probe devices twice (early and late) and
> to check the state we're at in order for users to be able to just do
> the critical initialization early on and then continue with regular
> stuff later.

Maybe the problem is reusing the name and some of the code from
an existing functionality that we've been trying to get rid of.

If what you want to do is completely different from the existing
early_platform implementation, how about starting by moving that
out of drivers/base/platform.c into something under arch/sh/
and renaming it to something with an sh_ prefix.

Let's just leave the non-DT part out of it by making it sh specific.
Then we can come up with improvements to the current
platform_device handling for DT based platforms that you can
use on DT-based davinci to replace what currently happens on
board-file based davinci systems, without mixing up those
two code paths too much in the base driver support.

       Arnd
