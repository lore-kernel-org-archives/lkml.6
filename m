Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186052-1527709249-2-10003004974208253494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527709248; b=i4pKzFDRsexs9mp20gJtbhzUn/Z2LdiR0dmdgzBbaqZrc29M8b
    uLzitxMxEtJQnArgRbLYEWN305IjwqnJXgVoYZT2UX5GptfsUV3fIrEz691XiY1Z
    bt5MGezXulE4DHGcibGHTwQzT9FbKLZxZofV5aQrsBxfLoOzRLWqO+YWNUESIoLz
    EVC6qTy1Q656xVbkfgx98E7ktap0r5aHqbiVxQvGo9I1LYvL7CyQ8bN2z7dVQugO
    S2w6PqpR4MuFPytkb+ZRC30vkZqsIH8unHW18AL08TJ3xFcJki68jEfVInuuhECr
    Wzn/Qrw/2iP2nZxNymJEHxhxlMHRz6kMtbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=fm2; t=1527709248;
    bh=wZ9BJ+mKRso4qIDOqtrmNEG+TqBL24cCq6QkKk09aOY=; b=biiKOzXSik5T
    bbQMW4c959b/aT5zCYLoat8ZDBwOkg9fcXgY6RhJN5yqmVqzk3ZuxDqSSH+2DdJa
    L7/5WAcilpg+jz43EG1RX+HaKpcqQttUOe7mX8F5/yDXgq/+IfdDjpeHu6kpEyAT
    TXP7iAAluIzM4Gfmo72LNYdKwO07n491P54iSltIQrGO5wX0SBssLiOp92xQXZx3
    GNKEb2IemcLBfZZ6Ww0KE++wOVfI6v3Y2NoSO+EOC09IxW85Na0E4WpXoFn4oEWV
    D6lTTz4AUKeyuux2p1KE0O5hRW7raIKmv+b7xxa4QBpB63QgXnQdGiCPU0AIZouj
    cIBVl+rQaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=baylibre-com.20150623.gappssmtp.com
    header.i=@baylibre-com.20150623.gappssmtp.com header.b=rqmo418h
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=OV6Ufq0x;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=baylibre.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=baylibre-com.20150623.gappssmtp.com
      header.i=@baylibre-com.20150623.gappssmtp.com header.b=rqmo418h
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=OV6Ufq0x;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=baylibre.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBXfcWkN2Z9xmoC8xKWOIYAIn6D1M7RiSuDRM6q1+jHToN2/R0EtYl3+vd23dqSM6r2Z8ZgKExmFMHYYEY+BIO9bdVQv5fO1Qn9KVHw0Sp3xGojX7m3D
    iUpLAtjX3d8/Fe5aJb0BbaeCqY5HbMF5BQ4Hpy0g6FvSUb8yFHiEwa0fzPUWOsF2SfLD9pVE6ClEbBgYao7izP1khbCUpYcw6kd8JMtl9PIp96OD2Z0eckBI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=EVbPa-k36tqigwwghs8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeE3Tkp (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 15:40:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43199 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeE3Tkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 15:40:43 -0400
X-Google-Smtp-Source: ADUXVKLV0L/5XdX0VnXRa1UwXTZYbnLmBVw8YoGfuGX24on4n+DwEKPb5Ssv3cP383Ymn6cFByIHMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES"
        <linux-arch@vger.kernel.org>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
Message-ID: <20180530194032.982.41562@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
Date: Wed, 30 May 2018 12:40:35 -0700
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

Quoting Rob Herring (2018-05-14 06:20:57)
> On Mon, May 14, 2018 at 6:38 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > 2018-05-11 22:13 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
> >> On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> >>> This series is a follow-up to the RFC[1] posted a couple days ago.
> >>>
> >>> NOTE: this series applies on top of my recent patches[2] that move th=
e previous
> >>> implementation of early platform devices to arch/sh.
> >>>
> >>> Problem:
> >>>
> >>> Certain class of devices, such as timers, certain clock drivers and i=
rq chip
> >>> drivers need to be probed early in the boot sequence. The currently p=
referred
> >>> approach is using one of the OF_DECLARE() macros. This however does n=
ot create
> >>> a platform device which has many drawbacks - such as not being able t=
o use
> >>> devres routines, dev_ log functions or no way of deferring the init O=
F function
> >>> if some other resources are missing.
> >>
> >> I skimmed though this and it doesn't look horrible (how's that for
> >> positive feedback? ;) ). But before going into the details, I think
> >> first there needs to be agreement this is the right direction.
> >>
> >> The question does remain though as to whether this class of devices
> >> should be platform drivers. They can't be modules. They can't be
> >> hotplugged. Can they be runtime-pm enabled? So the advantage is ...
> >>
> >
> > The main (but not the only) advantage for drivers that can both be
> > platform drivers and OF_DECLARE drivers is that we get a single entry
> > point and can reuse code without resorting to checking if (!dev). It
> > results in more consistent code base. Another big advantage is
> > consolidation of device tree and machine code for SoC drivers used in
> > different boards of which some are still using board files and others
> > are defined in DT (see: DaVinci).
> >
> >> I assume that the clock maintainers had some reason to move clocks to
> >> be platform drivers. It's just not clear to me what that was.
> >>
> >>> For drivers that use both platform drivers and OF_DECLARE the situati=
on is even
> >>> more complicated as the code needs to take into account that there ca=
n possibly
> >>> be no struct device present. For a specific use case that we're havin=
g problems
> >>> with, please refer to the recent DaVinci common-clock conversion patc=
hes and
> >>> the nasty workaround that this problem implies[3].
> >>
> >> So devm_kzalloc will work with this solution? Why did we need
> >> devm_kzalloc in the first place? The clocks can never be removed and
> >> cleaning up on error paths is kind of pointless. The system would be
> >> hosed, right?
> >>
> >
> > It depends - not all clocks are necessary for system to boot.
> =

> That doesn't matter. You have a single driver for all/most of the
> clocks, so the driver can't be removed.

-ECANOFWORMS

A couple of quick rebuttals, but I imagine we're going to disagree on
the platform_driver thing as a matter of taste no matter what...

1) There should be multiple clk drivers in a properly modeled system.
Some folks still incorrectly put all clocks in a system into a single
driver because That's How We Used To Do It, and some systems (simpler
ones) really only have a single clock generator IP block.

Excepting those two reasons above, we really should have separate
drivers for clocks controlled by the PMIC, for the (one or more) clock
generator blocks inside of the AP/SoC, and then even more for the
drivers that map to IP blocks that have their own clock gens.

Good examples of the latter are display controllers that generate their
own PLL and pixel clock. Or MMC controllers that have a
runtime-programmable clock divider. Examples of these are merged into
mainline.

2) Stephen and I wanted clock drivers to actually be represented in the
driver model. There were these gigantic clock drivers that exclusively
used CLK_OF_DECLARE and they just sort of floated out there in the
ether... no representation in sysfs, no struct device to map onto a
clock controller struct, etc.

I'd be happy to hear why you think that platform_driver is a bad fit for
a device driver that generally manages memory-mapped system resources
that are part of the system glue and not really tied to a specific bus.
Sounds like a good fit to me.

If platform_driver doesn't handle the early boot thing well, that tells
me that we have a problem to solve in platform_driver, not in the clk
subsystem or drivers.

3) Lots of clock controllers should be loadable modules. E.g. i2c clock
expanders, potentially external PMIC-related drivers, external audio
codecs, etc.

Again, repeating my point #1 above, just because many platforms have a
monolithic clock driver does not mean that this is the Right Way to do
it.

Best regards,
Mike

> =

> >>> We also used to have an early platform drivers implementation but the=
y were not
> >>> integrated with the linux device model at all - they merely used the =
same data
> >>> structures. The users could not use devres, defer probe and the early=
 devices
> >>> never became actual platform devices later on.
> >>>
> >>> Proposed solution:
> >>>
> >>> This series aims at solving this problem by (re-)introducing the conc=
ept of
> >>> early platform drivers and devices - this time however in a way that =
seamlessly
> >>> integrates with the existing platform drivers and also offers device-=
tree
> >>> support.
> >>>
> >>> The idea is to provide a way for users to probe devices early, while =
already
> >>> being able to use devres, devices resources and properties and also d=
eferred
> >>> probing.
> >>>
> >>> New structures are introduced: the early platform driver contains the
> >>> early_probe callback which has the same signature as regular platform=
_device
> >>> probe. This callback is called early on. The user can have both the e=
arly and
> >>> regular probe speficied or only one of them and they both receive the=
 same
> >>> platform device object as argument. Any device data allocated early w=
ill be
> >>> carried over to the normal probe.
> >>>
> >>> The architecture code is responsible for calling early_platform_start=
() in
> >>> which the early drivers will be registered and devices populated from=
 DT.
> >>
> >> Can we really do this in one spot for different devices (clk, timers,
> >> irq). The sequence is all very carefully crafted. Platform specific
> >> hooks is another thing to consider.
> >>
> >
> > This is why I added support for early probe deferral - so that we can
> > stop caring for the order as long as the drivers are aware of other
> > resources they need and we call early_platform_start() the moment the
> > earliest of the early devices is needed.
> =

> Deferred probe helps for inter-device dependencies, but I am more
> concerned about timing of trying to register clocksources, irqchips,
> etc. What happens if we probe drivers before the infrastructure is
> initialized?
> =

> Rob
