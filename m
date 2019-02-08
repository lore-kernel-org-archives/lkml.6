Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82555C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED6A217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NADbzZAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfBHRhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52119 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfBHRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:37:14 -0500
Received: by mail-it1-f193.google.com with SMTP id y184so4407647itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Wve+4NbFDSjDPCHrofPHyf91DgMmuRDrxDL/6OPeDk=;
        b=NADbzZAwz736/vXMWCl334RpCiptfBU4KVf+EqvvYePl9UQ+8j3lqh424P3tYvxvhe
         4+LQfpR1z/pLDSsx8UWlcWRN5dMG4tBIvL4i6YFtroUJOPSKKAnG3JolSFhzPmQX/wQL
         9YVYb9/pV+51fNxBvMpbie6Qb9XZsv41kofwq6NcdNayeatvA3M2/c6+E4idMzrzZ6M+
         2t/kF0fzF/y7fEUB8zEsIa5ZPhL3aG1feJZ7k1+YXXgyP0eB+A6jYU7estrxLE+HUldK
         D5LgC9Mw0CwFGy/c/NRvqOG5IjqxJO00XiCRkIgsPfSWOHWegK+Dr6/iTnuBVdDwKUTL
         MBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Wve+4NbFDSjDPCHrofPHyf91DgMmuRDrxDL/6OPeDk=;
        b=cYpAFGeTh6PUG+lfXHbO9JA04XkAM6YXpmLV2RVRIFRDur7JygOGesYpVvpURF2EoG
         uFMXEgP2vHGl+23lLPkgmbMMDT+wxpunxWZBD4jccnSqJ/QbOYg3ZF5kDhjoGydBFJW1
         x8UQHBSJWnuJcRAImajj7dkdNaeXLUKjXDW5OxrkMX62H9NyQ3ZTL6FJie/oMoOvfrFH
         VAcluFJd3IkM/x9ww7yPxEph+PSVjtATgkBKAe8Buj9xszNT0TOFbAnkXkDT9kVNjDd5
         gBoKcVwmoQ7labu6aaQD7BztYL6nZ5qqtH8qbeXBDf4GXseO/bBnxlct75OH+XzAoZsp
         3sKQ==
X-Gm-Message-State: AHQUAubrPXNc9CdvFcwlvxFL0tHsajnmB8aqJbQ0GUENrVusd4Pjo5SD
        4zCXW/iXgSUHTRHrUZ3GXg4otkuvXQKobcHPGaRMPQ==
X-Google-Smtp-Source: AHgI3IYQdfGCOF6tHhY4WC5Um/HhqtRfzDdDoorxy25dRMIJ5/1Q4fDAd5112oX8MY692TK/59X6mbeitrHUuh4XQVw=
X-Received: by 2002:a24:5d94:: with SMTP id w142mr7326747ita.74.1549647433575;
 Fri, 08 Feb 2019 09:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20190208173458.4801-1-brgl@bgdev.pl>
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Feb 2019 18:37:02 +0100
Message-ID: <CAMRc=Mcuwu1ikAf7p3T2jCd-rycxePRyYhbMbdnBnav5gzvwiA@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] ARM: davinci: modernize the irq support
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lut 2019 o 18:35 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> the irqchip drivers and moves them over to drivers/irqchip.
>
> The series can be logically split into four parts. The first (1-8) aims
> at introducing support for SPARSE_IRQ. It contains a couple changes
> required for that functionality and the final patch actually selecting
> it.
>
> Second part (9-19) makes the aintc driver suitable for drivers/irqchip
> and eventually moves it over there.
>
> Part 3 (20-32) does the same for the cp-intc driver.
>
> Last patch removes unnecessary code.
>
> The series has been tested on da850-lcdk (for cp-intc) and
> dm365-evm (for aintc).
>
> v1 -> v2:
> - made commit messages readable without reading the subject line first
> - collected David's Reviewed-by tags for patches that haven been
>   significantly modified since v1
> - added handling of spurious interrupts in cp-intc
> - added comments explaining the irq handlers (C versions translated from
>   assembly)
> - dropped the patches removing the hardware interrupt numbers from
>   the priority tables
> - don't remove irqs.h, make it a local header instead
> - rearranged the patches in order not to remove the code added
>   by earlier ones
> - renamed d*_init_irqs to d*_init_irq to fit the name of the relevant
>   callback in machine info struct
> - fixed license identifiers where needed
> - added comments to config structures for irqchip drivers
> - fixed all off-by-one errors in resource sizes
> - clarified the comments on the weird handling of IRQ_TINT1_TINT34 as lev=
el
>   irq and added missing calls to irq_set_handler() to dm3* SoCs
> - fixed one function that was missing a correct prefix in cp_intc
> - return value variables should be called ret not rv
> - added a patch converting calls to _raw_readl/writel() to their _relaxed
>   counterparts
> - fixed the commit message prefix in patches that belong to the irqchip
>   subsystem
> - other minor tweaks
>

I'm terribly sorry for spamming - I had messed up two e-mail addresses.

Best regards,
Bartosz Golaszewski

> Bartosz Golaszewski (33):
>   ARM: davinci: remove intc_host_map from davinci_soc_info struct
>   ARM: davinci: aintc: use irq domain
>   ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
>   ARM: davinci: remove davinci_intc_type
>   ARM: davinci: pull davinci_intc_base into the respective intc drivers
>   ARM: davinci: wrap HW interrupt numbers with a macro
>   ARM: davinci: select SPARSE_IRQ
>   ARM: davinci: make irqs.h a local header
>   ARM: davinci: aintc: drop GPL license boilerplate
>   ARM: davinci: aintc: wrap davinci_irq_init() with a helper
>   ARM: davinci: aintc: use a common prefix for symbols in the driver
>   ARM: davinci: aintc: drop the 00 prefix from register offsets
>   ARM: davinci: aintc: use readl/writel_relaxed()
>   irqchip: davinci-aintc: add a new config structure
>   ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
>   ARM: davinci: aintc: use the new config structure
>   ARM: davinci: aintc: move timer-specific irq_set_handler() out of
>     irq.c
>   ARM: davinci: aintc: remove unnecessary includes
>   irqchip: davinci-aintc: move the driver to drivers/irqchip
>   ARM: davinci: cp-intc: remove cp_intc.h
>   ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
>   irqchip: davinci-cp-intc: add a new config structure
>   ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
>   ARM: davinci: cp-intc: use a common prefix for all symbols
>   ARM: davinci: cp-intc: convert all hex numbers to lowercase
>   ARM: davinci: cp-intc: use the new-style config structure
>   ARM: davinci: cp-intc: improve coding style
>   ARM: davinci: cp-intc: unify error handling
>   ARM: davinci: cp-intc: use readl/writel_relaxed()
>   ARM: davinci: cp-intc: drop GPL license boilerplate
>   ARM: davinci: cp-intc: remove redundant comments
>   irqchip: davinci-cp-intc: move the driver to drivers/irqchip
>   ARM: davinci: remove intc related fields from davinci_soc_info
>
>  arch/arm/Kconfig                              |   2 +
>  arch/arm/mach-davinci/Kconfig                 |  19 +-
>  arch/arm/mach-davinci/Makefile                |   3 -
>  arch/arm/mach-davinci/asp.h                   |   8 +-
>  arch/arm/mach-davinci/board-da830-evm.c       |   5 +-
>  arch/arm/mach-davinci/board-da850-evm.c       |   5 +-
>  arch/arm/mach-davinci/board-dm355-evm.c       |   2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c   |   2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c       |   2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c      |   8 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c      |   7 +-
>  arch/arm/mach-davinci/board-mityomapl138.c    |   3 +-
>  arch/arm/mach-davinci/board-neuros-osd2.c     |   2 +-
>  arch/arm/mach-davinci/board-omapl138-hawk.c   |   3 +-
>  arch/arm/mach-davinci/board-sffsdr.c          |   2 +-
>  arch/arm/mach-davinci/common.c                |   3 -
>  arch/arm/mach-davinci/cp_intc.c               | 215 ----------------
>  arch/arm/mach-davinci/cp_intc.h               |  57 -----
>  arch/arm/mach-davinci/da830.c                 | 128 ++--------
>  arch/arm/mach-davinci/da850.c                 | 154 +++---------
>  arch/arm/mach-davinci/davinci.h               |   4 +
>  arch/arm/mach-davinci/devices-da8xx.c         | 147 +++++------
>  arch/arm/mach-davinci/devices.c               |  40 +--
>  arch/arm/mach-davinci/dm355.c                 |  86 ++++---
>  arch/arm/mach-davinci/dm365.c                 | 110 ++++----
>  arch/arm/mach-davinci/dm644x.c                |  76 +++---
>  arch/arm/mach-davinci/dm646x.c                |  90 ++++---
>  arch/arm/mach-davinci/include/mach/common.h   |  14 +-
>  arch/arm/mach-davinci/include/mach/da8xx.h    |   2 +
>  .../mach-davinci/include/mach/entry-macro.S   |  39 ---
>  arch/arm/mach-davinci/irq.c                   | 117 ---------
>  .../mach-davinci/{include/mach =3D> }/irqs.h    |   4 -
>  arch/arm/mach-davinci/usb-da8xx.c             |   9 +-
>  arch/arm/mach-davinci/usb.c                   |  14 +-
>  drivers/irqchip/Kconfig                       |  10 +
>  drivers/irqchip/Makefile                      |   2 +
>  drivers/irqchip/irq-davinci-aintc.c           | 144 +++++++++++
>  drivers/irqchip/irq-davinci-cp-intc.c         | 238 ++++++++++++++++++
>  include/linux/irqchip/irq-davinci-aintc.h     |  27 ++
>  include/linux/irqchip/irq-davinci-cp-intc.h   |  25 ++
>  40 files changed, 872 insertions(+), 956 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/cp_intc.c
>  delete mode 100644 arch/arm/mach-davinci/cp_intc.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
>  delete mode 100644 arch/arm/mach-davinci/irq.c
>  rename arch/arm/mach-davinci/{include/mach =3D> }/irqs.h (98%)
>  create mode 100644 drivers/irqchip/irq-davinci-aintc.c
>  create mode 100644 drivers/irqchip/irq-davinci-cp-intc.c
>  create mode 100644 include/linux/irqchip/irq-davinci-aintc.h
>  create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h
>
> --
> 2.20.1
>
