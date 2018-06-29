Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66166C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1A727C97
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="p5DnHu+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1A727C97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966827AbeF2Jm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43056 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966792AbeF2JmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:42:24 -0400
Received: by mail-io0-f194.google.com with SMTP id i23-v6so7904997iog.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bsYQR3Gz7ELM4U5eb4yIYg4fvobGlZ+oUBx6/iddn9k=;
        b=p5DnHu+0s2iC5mFU4E37oXwbVGor5x11kmJW5EnQ+jfrxdldFsLT1NKnkFVewbNtlq
         w8BPw3Zan3FtsWuNEfD9LaKiWaZb749xYJ82BHJlL/Q4Lj7prJT1AVSd7MzD/IKdiQPZ
         8GYvmNrmKDE6rpNG6KWY7tfvAP4czvPJr8uwXDK4Wm2v6wHZUNUPMJFN8JzM6MEn4MK4
         my5Bp0Mpepzndj+I76Jj5BUoPq1jnWIVdDTDh+XM//waa+DCyaoWEbtB2n2aepyWydvP
         LuqqEiBt/bQ93I43bBhClLufI1y0X8B+bzTH+xvMxRNzdd0SYVYt2qJa5YAMZ6mi4Nn8
         7L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bsYQR3Gz7ELM4U5eb4yIYg4fvobGlZ+oUBx6/iddn9k=;
        b=ZdbsFEJsJpH4YZeHkXGExgAPddWbmga+HxM9Xw35jounyawFn81eGNnO88KlSnH/1n
         BtS6bhOMInjpXcpHlZsaba4vzBGgeAZxYSiYiKV45K6SHaKBpai7646BOCXWUzhxE8uP
         jwmJ+8AGl/VfFRCTo2cV5p8pgLX+2ziY/qXmCyrCHuO+85gcjCR/8QMvnd8kqrj9wPsY
         wOU3TXOjkru3UfJm2PtXeAAskM7pAeGRT5znYxivtx4EJ9Ur9fM60EUuPN5eNDMivnV6
         M0SV1VTFCsPceNEyT2I3/gvdWiUHohV9CkZHX4mc3YiF4yEGYKBHL0cI6YsoOtpo7e6t
         AzEw==
X-Gm-Message-State: APt69E3mihX7hOwMeKlqxgcCzky4/v0LlhRNZZ1KoJCg6zonc9PhtNqX
        KIqHUy7ccl8eHqpUO2r3qClgXj2Cc2xK0hQldFRdNg==
X-Google-Smtp-Source: AAOMgpfX4dcH1adCe90rw8XLdDg3WQRAWOPdpFyC/nQiuBlNdgidA2XG6fvDNLbfCtHE7oEbPYtmes2lFc1SDW8qJlo=
X-Received: by 2002:a6b:6403:: with SMTP id t3-v6mr12145640iog.111.1530265343820;
 Fri, 29 Jun 2018 02:42:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 02:42:23
 -0700 (PDT)
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 29 Jun 2018 11:42:23 +0200
Message-ID: <CAMRc=MdPhiqqCQUm0JAANeZeqMJajdDVfHPLv=xWtO7T0cnDCw@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] ARM: davinci: step towards removing at24_platform_data
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-28 16:32 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
> Most boards use the EEPROM to store the MAC address. This series adds
> support for cell lookups to the nvmem framework, registers relevant
> cells for all users, converts the davinci_emac driver to using them
> and replaces at24_platform_data with device properties.
>
> The only board that's still using this callback is now mityomapl138.
> Unfortunately it stores more info in EEPROM than just the MAC address
> and will require some more work. Unfortunately I don't have access
> to this board so I can't test any actual solutions on a live hardware.
>
> Tested on a dm365-evm board.
>
> v1 -> v2:
> - for backward compatiblity: fall back to using of_get_mac_address() if
>   we can't get an nvmem cell in patch 7
> - add patch 15 which removes dead code
>
> v2 -> v3:
> - documented new nvmem cell lookup API
> - renamed the nvmem cell lookup routines
> - in order to completly remove the mac_addr from davinci's soc_info
>   added a patch that moves reading the MAC address from SPI to the emac
>   driver
> - removed more dead code
>
> Bartosz Golaszewski (18):
>   nvmem: add support for cell lookups
>   Documentation: nvmem: document lookup entries
>   ARM: davinci: dm365-evm: use nvmem lookup for mac address
>   ARM: davinci: dm644-evm: use nvmem lookup for mac address
>   ARM: davinci: dm646x-evm: use nvmem lookup for mac address
>   ARM: davinci: da830-evm: use nvmem lookup for mac address
>   ARM: davinci: mityomapl138: add nvmem cells lookup entries
>   net: davinci_emac: potentially get the MAC address from MTD
>   ARM: davinci: da850-evm: remove dead MTD code
>   net: davinci_emac: use nvmem to retrieve the mac address
>   ARM: davinci: mityomapl138: don't read the MAC address from machine
>     code
>   ARM: davinci: dm365-evm: use device properties for at24 eeprom
>   ARM: davinci: da830-evm: use device properties for at24 eeprom
>   ARM: davinci: dm644x-evm: use device properties for at24 eeprom
>   ARM: davinci: dm646x-evm: use device properties for at24 eeprom
>   ARM: davinci: sffsdr: fix the at24 eeprom device name
>   ARM: davinci: sffsdr: use device properties for at24 eeprom
>   ARM: davinci: remove dead code related to MAC address reading
>
>  Documentation/nvmem/nvmem.txt              | 28 ++++++++
>  arch/arm/mach-davinci/board-da830-evm.c    | 25 +++++---
>  arch/arm/mach-davinci/board-da850-evm.c    | 28 --------
>  arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++---
>  arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++---
>  arch/arm/mach-davinci/board-dm646x-evm.c   | 25 +++++---
>  arch/arm/mach-davinci/board-mityomapl138.c | 30 ++++++---
>  arch/arm/mach-davinci/board-sffsdr.c       | 13 ++--
>  arch/arm/mach-davinci/common.c             | 15 -----
>  drivers/net/ethernet/ti/davinci_emac.c     | 50 ++++++++++++---
>  drivers/nvmem/core.c                       | 75 +++++++++++++++++++++-
>  include/linux/davinci_emac.h               |  2 -
>  include/linux/nvmem-consumer.h             |  6 ++
>  include/linux/nvmem-provider.h             | 10 +++
>  14 files changed, 253 insertions(+), 103 deletions(-)
>
> --
> 2.17.1
>

Superseded by v4 - I noticed some more issues with the series that
needed fixing.

Bart
