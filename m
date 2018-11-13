Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81274C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4142080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R4LYc7rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4142080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbeKNACw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:02:52 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40498 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbeKNACw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:02:52 -0500
Received: by mail-it1-f193.google.com with SMTP id e11so18518978itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MPrwbB8Nia4kEdgC3qZgsDb60YlvnlArEEhjst8wSFI=;
        b=R4LYc7rdFS2kimdr9XYCf7OCkOZPmUulEGYpG/9l/lhRt95nbQBckXpk2Tx5+xN/lZ
         cy8CGspO664n8O8lio3IOVr++kAb1RDbQtkgCX0a+JnvyH5douQIEyv204GGrZYoTJYG
         Rs4u0kHKxwo9whwpQ7LzZ4lGMoLMzb25B0HVlEKrpHgvO8d4WOnkz5VlqOzdfOB38zTE
         xrDF9dfNKyUZ5aiSFTYLE49TVcYNfNuY0x/pSKXcTRGSxaS0DToSHvi4WKVOplcWLYuw
         2xMnb7WMkX5m2VQM/QaSG2Cp6NzeifLIqzC8E2b4ALf2T16XDxbbHHh4j5XOczzlW0CF
         3emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MPrwbB8Nia4kEdgC3qZgsDb60YlvnlArEEhjst8wSFI=;
        b=b1rhfBPdtoj2mVuKhTxYvmwgcePcsVSGTGyZCEUTEsbU/AdhYO/cUXrYzBAqlV75dP
         a54cEfjVD8x6HAtfi6ZOTYTT1hr/gjn/60oFgRHGLo2cElHAO1xRSCRO0TBZPLjbD/Tn
         2KvY9fhVsw+UuEaM/23fRTlZAGc4Lrn3hKhnnfVVlyR30clmZLrnVQHl5JMQR5p5k51A
         BkSDBlqLURUyPdOX2fu3ECh6fGdqbG9UokqccgMsaF7X68IV8KaEyzme4ibVjG3gHcx7
         SPojvm423B6FIbJjAe0yRGzhFArnON/6lMKL3yhg/hzi4EcH+SQQu8P6mnuN2pQVWMCO
         Lpow==
X-Gm-Message-State: AGRZ1gIjKFvFgLkrl4hXzkzrLWSc0vgC76mME2wFNACw33a1i+HYhdPc
        FMC6DGz/x7WphznJm9uKwV266cgSsNlawE/rULkOAA==
X-Google-Smtp-Source: AJdET5cEKm8NnGF6sNKPDv47BAHhBzx7fv5ne/pEN5COaOO1/Sy54XFjyPCoJCugMufibzgOxOSF6oASys/1rYxb7OU=
X-Received: by 2002:a02:3d42:: with SMTP id n63mr4927871jan.136.1542117873799;
 Tue, 13 Nov 2018 06:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20181113140133.17385-1-brgl@bgdev.pl>
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Nov 2018 15:04:22 +0100
Message-ID: <CAMRc=MfvdWMKheWfm8UnEYuvd+rs+9yVahwM+=e2zmVm_6iKJg@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] at24: remove
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 13 lis 2018 o 15:01 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Now that nvmem has gained support for defining cells from board files and
> looking them up from relevant drivers[1], it's time for a respin of the
> previous series[2] that aims at removing struct at24_platform_data from
> the tree.
>
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.
>
> DaVinci is the only platform that's still using it - all other users
> have already been converted.
>
> One of the obstacles in case of DaVinci is removing the setup() callback
> from the pdata struct, the only user of which are some davinci boards.
>
> First we add support for nvmem to MTD in a way previously discussed with
> Boris Brezillon and Srinivas Kandagatla.
>
> Then, since most boards use the EEPROM to store the MAC address, we regis=
ter
> relevant cells for all users, implement a function that allows to read
> the MAC address from nvmem (and also replaces the previous DT-specific
> variant) and make davinci_emac aware of it.
>
> Next we switch all davinci users to using at24 device properties instead
> of platform data. While we're at it: we remove all other traces of the
> setup callback and platform data from davinci.
>
> Finally we remove the at24 platform data structure.
>
> I kept the review tags in patches that haven't changed from the last
> submission.
>
> As far as merging of this series goes: I'd like to avoid dragging it over
> four releases. The series is logically split into five groups:
>
> patches 1-2: nvmem and mtd changes
> patches 3-9: davinci arch-specific changes
> patches 10-13: networking changes
> patches 14-24: davinci specific again
> patch 25: final at24 change
>
> With that I believe we can do the following: Greg KH could pick up the
> first two patches into his char-misc tree. Sekhar would take the second
> group and the third would go through the networking tree since the first
> three sets are not linked in any way. This would be merged for 4.21. Then
> for the next release Sekhar would pick up 14-24, provide an immutable
> branch for me and I'd merge the final patch for at24 and send it upstream
> through Wolfram's i2c tree (maybe we could even delay the i2c PR in the
> merge window to avoid the immutable branch altogether).
>
> [1] https://lkml.org/lkml/2018/9/21/293
> [2] https://lkml.org/lkml/2018/8/8/528
>
> Alban Bedel (1):
>   mtd: add support for reading MTD devices via the nvmem API
>
> Bartosz Golaszewski (24):
>   nvmem: add new config option
>   ARM: davinci: dm365-evm: use cell nvmem lookup for mac address
>   ARM: davinci: dm644x-evm: use cell nvmem lookup for mac address
>   ARM: davinci: dm646x-evm: use cell nvmem lookup for mac address
>   ARM: davinci: da830-evm: use cell nvmem lookup for mac address
>   ARM: davinci: mityomapl138: use cell nvmem lookup for mac address
>   ARM: davinci: dm850-evm: use cell nvmem lookup for mac address
>   ARM: davinci: da850-evm: remove unnecessary include
>   net: ethernet: provide nvmem_get_mac_address()
>   net: cadence: switch to using nvmem_get_mac_address()
>   of: net: kill of_get_nvmem_mac_address()
>   net: davinci_emac: use nvmem_get_mac_address()
>   ARM: davinci: da850-evm: remove dead MTD code
>   ARM: davinci: mityomapl138: don't read the MAC address from machine
>     code
>   ARM: davinci: dm365-evm: use device properties for at24 eeprom
>   ARM: davinci: da830-evm: use device properties for at24 eeprom
>   ARM: davinci: dm644x-evm: use device properties for at24 eeprom
>   ARM: davinci: dm646x-evm: use device properties for at24 eeprom
>   ARM: davinci: sffsdr: fix the at24 eeprom device name
>   ARM: davinci: sffsdr: use device properties for at24 eeprom
>   ARM: davinci: remove dead code related to MAC address reading
>   ARM: davinci: mityomapl138: use nvmem notifiers
>   ARM: davinci: mityomapl138: use device properties for at24 eeprom
>   eeprom: at24: remove at24_platform_data
>
>  MAINTAINERS                                |   1 -
>  arch/arm/mach-davinci/board-da830-evm.c    |  39 ++++-
>  arch/arm/mach-davinci/board-da850-evm.c    |  58 ++++----
>  arch/arm/mach-davinci/board-dm365-evm.c    |  38 ++++-
>  arch/arm/mach-davinci/board-dm644x-evm.c   |  37 ++++-
>  arch/arm/mach-davinci/board-dm646x-evm.c   |  37 ++++-
>  arch/arm/mach-davinci/board-mityomapl138.c |  67 ++++++---
>  arch/arm/mach-davinci/board-sffsdr.c       |  13 +-
>  arch/arm/mach-davinci/common.c             |  15 --
>  drivers/misc/eeprom/at24.c                 | 162 ++++++++++-----------
>  drivers/mtd/Kconfig                        |   1 +
>  drivers/mtd/mtdcore.c                      |  56 +++++++
>  drivers/net/ethernet/cadence/macb_main.c   |   2 +-
>  drivers/net/ethernet/ti/davinci_emac.c     |  14 +-
>  drivers/nvmem/core.c                       |   3 +-
>  drivers/of/of_net.c                        |  39 -----
>  include/linux/davinci_emac.h               |   1 -
>  include/linux/etherdevice.h                |   1 +
>  include/linux/mtd/mtd.h                    |   2 +
>  include/linux/nvmem-provider.h             |   2 +
>  include/linux/of_net.h                     |   6 -
>  include/linux/platform_data/at24.h         |  60 --------
>  net/ethernet/eth.c                         |  38 +++++
>  23 files changed, 391 insertions(+), 301 deletions(-)
>  delete mode 100644 include/linux/platform_data/at24.h
>
> --
> 2.19.1
>

Ugh the subject was supposed to be: at24: remove platform data...
