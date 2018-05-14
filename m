Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1526297897; cv=none;
        d=google.com; s=arc-20160816;
        b=TOo9r6sFhWxMFDuZGfbnZZoVrzZRkjfgD+qSund9hixQsz04PSETUAHMw6dDuVLqh5
         HvDrSw5/j3DhhYldJuDOUGEVOZehUSW1shBWWNCZ5NaOYpDpQv5mvqM1YlwKEYcK2t7h
         IN/06PNXy8l2z2iXWVYvhAPyCAiW0zmQAy+/MhUpeuGgOXYuPKPDhoxoFGHsUaBe5urI
         R4tjrsLzVXK8MZHiN+3QuNeTdVZfGi/mFTuIhhmCCekYacq11GbT4wx9QRxOukfC8pNV
         o6hxa9Wl9rPzYte27fsmQGO90RjYsrjMR/sB1lt3wSvKBvS1RopXleOalgat0UbSTW9D
         BqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Aym6qTP1VAcyYMXvqQMmDpjKygFNBfMKFJV1b0PqcVA=;
        b=ipz4BE23Ho8+LR+y5yguoUsPFr2ywjg9MdiayM+4yZJsacMNFIS9B66C89QTCrekPk
         nY83xKU2j0nEAwWlJH1X8eKUhkmnYAPpIYJt+FTEG4L+H8ASG2cmrtil5dlaFCHI4pvP
         V9JGkicxV22PfO2QBJC6JuwO379HA3Za4HWPj6vGK5wbR6GBuXcGfVjFAb+MmLGH8Cgo
         Biy97V5Bj1zTOaLcToPt9oPSRGmWAcsgNfb/AKFvVNgQVpFJKYyZCfVw/F90XA4XoZSY
         yCYAO+8lyPfnyGqjJHo1zZsXhrq37TSs26xj2zHKyt5SPpDzYGN4As5sz38DroGNaGy+
         sjoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=yaEt3m6O;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=yaEt3m6O;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZrA2QduCSyZxmIJ2YfbZznBc3oLMdBSLDS0ToyGk60TgZ8HXbWX0WVmzH+B2TjOOpV19dlC+m9zHiuRhJOD+jk=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl> <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 May 2018 13:38:16 +0200
Message-ID: <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
To: Rob Herring <robh+dt@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>,
	Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600185365724813240?=
X-GMAIL-MSGID: =?utf-8?q?1600439344033852308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-11 22:13 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
> On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> This series is a follow-up to the RFC[1] posted a couple days ago.
>>
>> NOTE: this series applies on top of my recent patches[2] that move the previous
>> implementation of early platform devices to arch/sh.
>>
>> Problem:
>>
>> Certain class of devices, such as timers, certain clock drivers and irq chip
>> drivers need to be probed early in the boot sequence. The currently preferred
>> approach is using one of the OF_DECLARE() macros. This however does not create
>> a platform device which has many drawbacks - such as not being able to use
>> devres routines, dev_ log functions or no way of deferring the init OF function
>> if some other resources are missing.
>
> I skimmed though this and it doesn't look horrible (how's that for
> positive feedback? ;) ). But before going into the details, I think
> first there needs to be agreement this is the right direction.
>
> The question does remain though as to whether this class of devices
> should be platform drivers. They can't be modules. They can't be
> hotplugged. Can they be runtime-pm enabled? So the advantage is ...
>

The main (but not the only) advantage for drivers that can both be
platform drivers and OF_DECLARE drivers is that we get a single entry
point and can reuse code without resorting to checking if (!dev). It
results in more consistent code base. Another big advantage is
consolidation of device tree and machine code for SoC drivers used in
different boards of which some are still using board files and others
are defined in DT (see: DaVinci).

> I assume that the clock maintainers had some reason to move clocks to
> be platform drivers. It's just not clear to me what that was.
>
>> For drivers that use both platform drivers and OF_DECLARE the situation is even
>> more complicated as the code needs to take into account that there can possibly
>> be no struct device present. For a specific use case that we're having problems
>> with, please refer to the recent DaVinci common-clock conversion patches and
>> the nasty workaround that this problem implies[3].
>
> So devm_kzalloc will work with this solution? Why did we need
> devm_kzalloc in the first place? The clocks can never be removed and
> cleaning up on error paths is kind of pointless. The system would be
> hosed, right?
>

It depends - not all clocks are necessary for system to boot.

>> We also used to have an early platform drivers implementation but they were not
>> integrated with the linux device model at all - they merely used the same data
>> structures. The users could not use devres, defer probe and the early devices
>> never became actual platform devices later on.
>>
>> Proposed solution:
>>
>> This series aims at solving this problem by (re-)introducing the concept of
>> early platform drivers and devices - this time however in a way that seamlessly
>> integrates with the existing platform drivers and also offers device-tree
>> support.
>>
>> The idea is to provide a way for users to probe devices early, while already
>> being able to use devres, devices resources and properties and also deferred
>> probing.
>>
>> New structures are introduced: the early platform driver contains the
>> early_probe callback which has the same signature as regular platform_device
>> probe. This callback is called early on. The user can have both the early and
>> regular probe speficied or only one of them and they both receive the same
>> platform device object as argument. Any device data allocated early will be
>> carried over to the normal probe.
>>
>> The architecture code is responsible for calling early_platform_start() in
>> which the early drivers will be registered and devices populated from DT.
>
> Can we really do this in one spot for different devices (clk, timers,
> irq). The sequence is all very carefully crafted. Platform specific
> hooks is another thing to consider.
>

This is why I added support for early probe deferral - so that we can
stop caring for the order as long as the drivers are aware of other
resources they need and we call early_platform_start() the moment the
earliest of the early devices is needed.

>> Once the device and kobject mechanisms are ready, all early drivers and devices
>> will be converted into real platform drivers and devices. Also: if any of the
>> early platform registration functions will be called once early initialization
>> is done, these functions will work like regular platform_device/driver ones.
>
> This could leave devices in a weird state. They've successfully probed
> early, but then are on the deferred list for normal probe for example.
>

It's not really a weird state - once we're past the 'early' stage, the
drivers' "earlyness" no longer plays any role. An early deferred
device wouldn't be any different from other deferred devices. It's
possible that we enabled some crucial resources in the early stage and
then failed to fully probe the device later. I don't see a problem
with that.

Best regards,
Bartosz Golaszewski
