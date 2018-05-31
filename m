Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-855541-1527749011-2-218053229286905690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527749010; b=UfldJPasGY7cX2IA/Y5Z5DaoOerQfUaDWXHYOjiSLw3RtCLOyR
    061bvNyuMjzjweo8qsFBTrfis6dNKg7rYWHgc52UfW1SFMHoNGYLIHAUBgda6xhk
    Jidt5dKWu2BTv0oHaFANl4SifSCbD/i8GzZRPAtNa5DNc2G298g8jqQiFI2vIICp
    JX5ZdBKj1drhlHZon49qudOwgDSB2BHj+6f9+TfPxB0C5Qit+yyvMMkzJ34iVGpE
    PQiepx5WVY6aFxE7LkESZoRNagsD5nMwYbgiunF6e+rhhbnD9fr6o1xY7xqxHfxC
    +qq6/dMhlfOzZ3DquW7jBjibbw6RfYg2niHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527749010; bh=wgu6QVcVxpftt7JbZcJ0CwuicNGJbyrvuHdmzvR4qV
    E=; b=gzqUB+xjP9x0ZOcQRj5WqXEoUjI+sB+mii9VX6SJTOf8WS9sO7xszYtVSR
    LtJ7CF1ISpGshBonYErykzcVJs55EwYYFF5RyTxJP1ih1v7NQVnTNGtdzc0lsCeq
    rKQsXnrNK74RrDQwsyaU28ysn9z/AfCxHhNS10MxjZc67vYEc+RpgFJiurLQEk31
    seCWF1CgBMUTKuirVfvwzLULt1T4GckkybM62js4fsC2bGSukiTs5AoApEBGOlqo
    3aTMp1vcQbnAcw+u2lYLHVBWrU3pijZwcGTxfMC32fZMe+2kyCCJOZqC+uS0kc8t
    W7enUzo58pU6oA1Kde7wedFkwDAQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=oerpV6En
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=lzac7jgY;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=oerpV6En
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=lzac7jgY;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMi7Uc7/vsJcPjW0iNu3mJzL9eRGdSSjETRxxr+jw9c1wXDQ3/1pV+junzez2pg5ZROASufkgk16QFydxsiEBOEQVPkmZv9vsijghDIlpblFbOnYFXBj
    KnwzNeceRmBjLBQYbIsXYnuKUTkPq593rBT0G93jbVYnF7djhTxTm30KpbQR3/he1Zx9GaR4y1TSfw9FvCToPDilI1GxqFIEFxOPgnhd45EJD7AsFe176iBD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=tBb2bbeoAAAA:8 a=BVchoPcLTrqPMNfBm40A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=IawgGOuG5U0WyFbmm1f5:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeEaGmw (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 02:42:52 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38289 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753740AbeEaGmu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 May 2018 02:42:50 -0400
X-Google-Smtp-Source: ADUXVKK1dZ+s8Iyf2bpGSBwWutpS2rlHSGwUwjryEP9S7Hzzw3RRwsHlrezSCZocKLLLgIF3sIXdV50TiZMB4Hv7psM=
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+7=NGj57k=E5GAuDmW7Uu_YkHJXf8jSyc_ad3r1op4yA@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl> <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
 <20180530194032.982.41562@harbor.lan> <CAL_Jsq+7=NGj57k=E5GAuDmW7Uu_YkHJXf8jSyc_ad3r1op4yA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 May 2018 08:42:48 +0200
X-Google-Sender-Auth: kVnJ4AOF-10H7E48sGzsE6cyI28
Message-ID: <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
To: Rob Herring <robh+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES"
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

On Thu, May 31, 2018 at 12:36 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, May 30, 2018 at 2:40 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
>> Quoting Rob Herring (2018-05-14 06:20:57)
>>> On Mon, May 14, 2018 at 6:38 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> > 2018-05-11 22:13 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
>>> >> On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> >>> This series is a follow-up to the RFC[1] posted a couple days ago.
>>> >>>
>>> >>> NOTE: this series applies on top of my recent patches[2] that move the previous
>>> >>> implementation of early platform devices to arch/sh.
>>> >>>
>>> >>> Problem:
>>> >>>
>>> >>> Certain class of devices, such as timers, certain clock drivers and irq chip
>>> >>> drivers need to be probed early in the boot sequence. The currently preferred
>>> >>> approach is using one of the OF_DECLARE() macros. This however does not create
>>> >>> a platform device which has many drawbacks - such as not being able to use
>>> >>> devres routines, dev_ log functions or no way of deferring the init OF function
>>> >>> if some other resources are missing.
>>> >>
>>> >> I skimmed though this and it doesn't look horrible (how's that for
>>> >> positive feedback? ;) ). But before going into the details, I think
>>> >> first there needs to be agreement this is the right direction.
>>> >>
>>> >> The question does remain though as to whether this class of devices
>>> >> should be platform drivers. They can't be modules. They can't be
>>> >> hotplugged. Can they be runtime-pm enabled? So the advantage is ...
>>> >>
>>> >
>>> > The main (but not the only) advantage for drivers that can both be
>>> > platform drivers and OF_DECLARE drivers is that we get a single entry
>>> > point and can reuse code without resorting to checking if (!dev). It
>>> > results in more consistent code base. Another big advantage is
>>> > consolidation of device tree and machine code for SoC drivers used in
>>> > different boards of which some are still using board files and others
>>> > are defined in DT (see: DaVinci).
>>> >
>>> >> I assume that the clock maintainers had some reason to move clocks to
>>> >> be platform drivers. It's just not clear to me what that was.
>>> >>
>>> >>> For drivers that use both platform drivers and OF_DECLARE the situation is even
>>> >>> more complicated as the code needs to take into account that there can possibly
>>> >>> be no struct device present. For a specific use case that we're having problems
>>> >>> with, please refer to the recent DaVinci common-clock conversion patches and
>>> >>> the nasty workaround that this problem implies[3].
>>> >>
>>> >> So devm_kzalloc will work with this solution? Why did we need
>>> >> devm_kzalloc in the first place? The clocks can never be removed and
>>> >> cleaning up on error paths is kind of pointless. The system would be
>>> >> hosed, right?
>>> >>
>>> >
>>> > It depends - not all clocks are necessary for system to boot.
>>>
>>> That doesn't matter. You have a single driver for all/most of the
>>> clocks, so the driver can't be removed.
>>
>> -ECANOFWORMS
>>
>> A couple of quick rebuttals, but I imagine we're going to disagree on
>> the platform_driver thing as a matter of taste no matter what...
>
> It's really more should the clocksource, clockevents and primary
> interrupt controller be drivers. Let's get agreement on that first. If
> yes, then it probably does make sense that their dependencies are
> drivers too. If not, then making only the dependencies drivers doesn't
> seem right to me.

Yes, they should all be drivers.

Assuming clocksources, clockevents, or primary interrupt controllers are
special, and thus forcing everyone to use OF_DECLARE for the whole
subsystem, doesn't fly everywhere.

Clockevents and interrupt controllers can have a module clock.
All three can be part of a PM Domain, which requires a struct device to
be handled properly.

>> 1) There should be multiple clk drivers in a properly modeled system.
>> Some folks still incorrectly put all clocks in a system into a single
>> driver because That's How We Used To Do It, and some systems (simpler
>> ones) really only have a single clock generator IP block.
>>
>> Excepting those two reasons above, we really should have separate
>> drivers for clocks controlled by the PMIC, for the (one or more) clock
>> generator blocks inside of the AP/SoC, and then even more for the
>> drivers that map to IP blocks that have their own clock gens.
>
> I agree those should be separate entities at least. But for a given
> h/w block, if you already have to use OF_DECLARE, why would you try to
> split that into OF_DECLARE and a driver? what advantage does putting
> non-boot essential clocks in a driver or transitioning to a driver get
> you?

You may want to split it because of dependencies. OF_DECLARE
doesn't handle EPROBE_DEFER, while some critical parts may be
needed early.

> And I've seen PMIC clocks could be inputs to the SoC's clock
> controller(s), so the dependencies get more complicated. Then does the
> PMIC driver and its dependencies need to be early drivers too?

Especially if there are clock loops, but that's something different.
Cfr. cs2000 in arch/arm64/boot/dts/renesas/salvator-common.dtsi, which
provides a clock from the main SoC, but also consumes a clock from the main
SoC. The latter is modeled in DT as a fixed-clock as a workaround.

>> Good examples of the latter are display controllers that generate their
>> own PLL and pixel clock. Or MMC controllers that have a
>> runtime-programmable clock divider. Examples of these are merged into
>> mainline.
>
> But those are drivers of types other than a clock controller that
> happen to register some clocks as well. I wasn't saying these cases
> can't or shouldn't be part of the driver model. Look at irqchips. We
> have some that use the driver model (e.g. every GPIO driver) and some
> that don't because there's no need (e.g. GIC).

There is a need for using the driver model for the GIC. On some platforms,
the GIC can be part of a clock and/or power domain.

For secondary GICs, that got fixed in commit 9c8edddfc9924cb4
("irqchip/gic: Add platform driver for non-root GICs that require RPM").
For primary GICs, it's still not fixed, so we have to live with
CLK_IS_CRITICAL, and rely on other critical devices in the same power
domain to avoid the power domain being powered off.

>> 2) Stephen and I wanted clock drivers to actually be represented in the
>> driver model. There were these gigantic clock drivers that exclusively
>> used CLK_OF_DECLARE and they just sort of floated out there in the
>> ether... no representation in sysfs, no struct device to map onto a
>> clock controller struct, etc.
>>
>> I'd be happy to hear why you think that platform_driver is a bad fit for
>> a device driver that generally manages memory-mapped system resources
>> that are part of the system glue and not really tied to a specific bus.
>> Sounds like a good fit to me.
>>
>> If platform_driver doesn't handle the early boot thing well, that tells
>> me that we have a problem to solve in platform_driver, not in the clk
>> subsystem or drivers.
>
> Doing things earlier is not the only way to solve the problems.
> Perhaps we need to figure out how to start things later. Maybe it's
> not feasible here, I don't know.

The fixed probe order imposed by OF_DECLARE() limits this: if your
OF_DECLARE() driver depends on something else, the latter must become an
early device.
If all subsystems would use real devices, EPROBE_DEFER would handle most of
it automatically.

Then, next step would be to avoid triggering EPROBE_DEFER, e.g. by
analyzing dependencies in DT...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
