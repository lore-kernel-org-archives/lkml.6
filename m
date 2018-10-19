Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F43ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38702148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lj72pxwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38702148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJSUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:14:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51440 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeJSUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:14:46 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so4003425itw.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apwnH7TwG9qJh/mrDqwR2etOU0uxd1t/+S/GqM/MbbA=;
        b=lj72pxwKdKmB3GbdDb7SE0Bg7EImdjOZalHAL2OukvblGkgPq81KpNMttEDWYpfa8l
         mY7kvxtksN4NLR+5b0Nl3cXo61IywCkkPjsXDpt52Cyzr7N2uBBBERDYUz+Ecm8+jKA+
         dsMS85Z5/T6MCzTJcDRyPGL1PCYxdiiLFjjhWZSXjmPn9nnhDic8LxbUBeeOlN7SS7g5
         Jse3MsfXJKV23NPwpmDZo6KJU3dDUr1HYMkGUGpQJkc+MwjIeIe/KmL8A1AlAoUivkMK
         LFYwdBH5r+ZQIUYy3sjkIBJERGbPuh4YyUf3df7uJ9bHWLvpU2LJwg79Mot3jinSh9PG
         +Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apwnH7TwG9qJh/mrDqwR2etOU0uxd1t/+S/GqM/MbbA=;
        b=hjB4zvu/7/IWPGL1mUWHdIPLZr7axbtrk/9nh/r8mUIwIbtzqwzkuN4WwREUuCXemt
         Q+muhP7p12qZkhdm3vGGutvyj05TKhpC2wc8aj2KVWFQjO6AGlh0dQNK4v+WhAAhHjSp
         Cl1/8Goqm7AqWAWydbUr/V1RPihWf6oqkFZLIGdrNcGAc8zxeeAOk6F5H8JD5/e+2eyY
         V+xTZHc41itxWkCipzK1TqgObvUXQbUjTW4meRZrTuAmLFCRi5DF0LW6HnbkT75kG1Te
         GaAaFxu//EFWIcYrDwUQijY80CTsWQqMYLi6KF2CIZ2pkfYXHpxSsGGYzjJivZH3bLI9
         x8WA==
X-Gm-Message-State: ABuFfojZqZulDcXWgjlSIpMBQut2IX3lbBmngZdLr44rIFzUCRW2YwX9
        Ybq/7YJV7wfqaiL5zF7qMtQNf0hjqVaFHy824YhVKA==
X-Google-Smtp-Source: ACcGV62COafFdNWgrIoB4xdjPo35x+WiuK4rcgu3UZyHZLygww9ctF4R8wIwNpi/W+5rxvetysYQcOUUVnrafF1Cj+s=
X-Received: by 2002:a02:1b4f:: with SMTP id l76-v6mr25320050jad.57.1539950938022;
 Fri, 19 Oct 2018 05:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180511162028.20616-1-brgl@bgdev.pl>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 19 Oct 2018 14:08:46 +0200
Message-ID: <CAMRc=MdShqv00spBgOu1=YfG9enZ6umPss7kfi=XRV=J6S3qGA@mail.gmail.com>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
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
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 11 maj 2018 o 18:21 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> This series is a follow-up to the RFC[1] posted a couple days ago.
>
> NOTE: this series applies on top of my recent patches[2] that move the pr=
evious
> implementation of early platform devices to arch/sh.
>
> Problem:
>
> Certain class of devices, such as timers, certain clock drivers and irq c=
hip
> drivers need to be probed early in the boot sequence. The currently prefe=
rred
> approach is using one of the OF_DECLARE() macros. This however does not c=
reate
> a platform device which has many drawbacks - such as not being able to us=
e
> devres routines, dev_ log functions or no way of deferring the init OF fu=
nction
> if some other resources are missing.
>
> For drivers that use both platform drivers and OF_DECLARE the situation i=
s even
> more complicated as the code needs to take into account that there can po=
ssibly
> be no struct device present. For a specific use case that we're having pr=
oblems
> with, please refer to the recent DaVinci common-clock conversion patches =
and
> the nasty workaround that this problem implies[3].
>
> We also used to have an early platform drivers implementation but they we=
re not
> integrated with the linux device model at all - they merely used the same=
 data
> structures. The users could not use devres, defer probe and the early dev=
ices
> never became actual platform devices later on.
>
> Proposed solution:
>
> This series aims at solving this problem by (re-)introducing the concept =
of
> early platform drivers and devices - this time however in a way that seam=
lessly
> integrates with the existing platform drivers and also offers device-tree
> support.
>
> The idea is to provide a way for users to probe devices early, while alre=
ady
> being able to use devres, devices resources and properties and also defer=
red
> probing.
>
> New structures are introduced: the early platform driver contains the
> early_probe callback which has the same signature as regular platform_dev=
ice
> probe. This callback is called early on. The user can have both the early=
 and
> regular probe speficied or only one of them and they both receive the sam=
e
> platform device object as argument. Any device data allocated early will =
be
> carried over to the normal probe.
>
> The architecture code is responsible for calling early_platform_start() i=
n
> which the early drivers will be registered and devices populated from DT.
>
> Once the device and kobject mechanisms are ready, all early drivers and d=
evices
> will be converted into real platform drivers and devices. Also: if any of=
 the
> early platform registration functions will be called once early initializ=
ation
> is done, these functions will work like regular platform_device/driver on=
es.
>
> Patches 1-9/12 introduce changes to existing code that are necessary befo=
re
> adding support for early drivers. Patch 10/12 contains the new framwork i=
n an
> isolated file which can be compiled only if needed by the architecture.
>
> Patch 11/12 contains a dummy early platform driver that serves as a code
> example and can be used for simple testing.
>
> The last patch finally makes the of/platform code aware of early platform
> drivers.
>
> If accepted, this new mechanism could potentially lead to consolidation o=
f the
> code currently used by users of OF_DECLARE, since they could be converted=
 to
> actual platform drivers.
>
> [1] https://lkml.org/lkml/2018/4/26/657
> [2] https://lkml.org/lkml/2018/4/30/547
> [3] https://lkml.org/lkml/2018/4/26/1094
>
> Bartosz Golaszewski (12):
>   platform/early: add a new field to struct device
>   platform/early: don't WARN() on non-empty devres list for early
>     devices
>   platform/early: export platform_match() locally
>   platform: provide a separate function for initializing platform
>     devices
>   platform: export platform_device_release() locally
>   of: add a new flag for OF device nodes
>   of/platform: provide a separate routine for setting up device
>     resources
>   of/platform: provide a separate routine for device initialization
>   platform/early: add an init section for early driver data
>   platform/early: implement support for early platform drivers
>   misc: implement a dummy early platform driver
>   of/platform: make the OF code aware of early platform drivers
>
>  drivers/base/Kconfig              |   3 +
>  drivers/base/Makefile             |   1 +
>  drivers/base/base.h               |   4 +
>  drivers/base/dd.c                 |   2 +-
>  drivers/base/early.c              | 332 ++++++++++++++++++++++++++++++
>  drivers/base/platform.c           |  28 ++-
>  drivers/misc/Kconfig              |   8 +
>  drivers/misc/Makefile             |   2 +
>  drivers/misc/dummy-early.c        |  82 ++++++++
>  drivers/of/platform.c             |  85 +++++---
>  include/asm-generic/vmlinux.lds.h |  11 +
>  include/linux/device.h            |   1 +
>  include/linux/early_platform.h    |  75 +++++++
>  include/linux/of.h                |   1 +
>  include/linux/of_platform.h       |   2 +
>  include/linux/platform_device.h   |   2 +
>  16 files changed, 604 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/base/early.c
>  create mode 100644 drivers/misc/dummy-early.c
>  create mode 100644 include/linux/early_platform.h
>
> --
> 2.17.0
>

Hi

For anyone interested: I'll be doing a BoF about early platform
drivers next week on Monday at 6:00pm during the ELCE 2018 in
Edinburgh. It would be great to discuss this topic personally.

Best regards and hope to see you there
Bartosz Golaszewski
