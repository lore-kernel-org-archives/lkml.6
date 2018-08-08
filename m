Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E025C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712321A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j/gFy5Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B712321A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHHRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:53:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37378 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so2411145wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=J6H6Bsh49npPwrc6jtwTH6YnEkel4XpqDs5bKswsXX4=;
        b=j/gFy5SgXCFPu1abrKrSwAD9pbgHza8/cuMkVhV9WsG4Ps2ojtYApvoZTlp829FBKH
         0/mxTtQbOTwlxCxa0DdjprKs19DkKBFaQuDwjg2uZvst1vl0SDu8kVAeeBpkrdAe78kL
         7mfpzEQPAIXjo6HMr7ZvVhzEFV7anr/cLJUDZ9Qzgv8nTunt1NQ3kvro0y7w59y8Q9g3
         tHfbixqGd6r4+9AL3ssFZBeMl9ZE8V8hgvlqUAGHBsY8NzeOcUOPM/Bj3FBIxkQ1fR5/
         RSmSblMlNyJEflzaqiCpHhy1NZ6TuM8gwhd1TpDsTIkT/jPoEOMesWN1a56LyOso6x7o
         G+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J6H6Bsh49npPwrc6jtwTH6YnEkel4XpqDs5bKswsXX4=;
        b=EFPk4c3UqXbR+E7ZaeThKo4/DAurxSSaQ6nEJiZ9nS4YNB65BZbIIbpIoThL4RDQlq
         28fFjwNsRlKxs+Zv1y04zY4jL4k2IVdlN/EbD3aYsv9PVIe9qR2C4vTXomSZR0VUj1Qh
         Y88IqLTAH9Ue2tXx1hp56LnWbD0fTiViaspuP0B+32PNPuRtDR3BRiztOn1UgRDsEVWl
         Kki50pMpvFw6p2EvQuXvtb4tM5yEB1YTtZ/c/AeCAzEqJlsrB/fDGr+L4D3roDqweCfi
         4aTX78Zeh+897VD0bXcnMIrPyC26hsbnNPlavJjquwkosIJepeRE3Y/Dc6U08RUrwU76
         Fw/Q==
X-Gm-Message-State: AOUpUlFKfCY56OH1t+nt/L1WgkXpygd2U2NQ6QaCQaqhWN8TzOdglMx4
        g6B8BcQPRsSqenKsG863oW476w==
X-Google-Smtp-Source: AA+uWPxz1JDR6oBEG6encT3bfFpBgaaxLrYrHXg+WJGZFltlfW+dzrPOcU+4V1glcrw5Is9aM7StiQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr2073233wro.263.1533742404977;
        Wed, 08 Aug 2018 08:33:24 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/28] at24: remove at24_platform_data
Date:   Wed,  8 Aug 2018 17:31:22 +0200
Message-Id: <20180808153150.23444-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the previously rejected series[1] which partially
removed the at24_platform_data structure. After further development and
taking reviews into account, this series finally removes that struct
completely but not without touching many different parts of the code
base.

Since I took over maintainership of the at24 driver I've been working
towards removing at24_platform_data in favor for device properties.

DaVinci is the only platform that's still using it - all other users
have already been converted.

One of the obstacles in case of DaVinci is removing the setup() callback
from the pdata struct, the only user of which are some davinci boards.

Most boards use the EEPROM to store the MAC address. This series adds
support for cell lookups to the nvmem framework, registers relevant
cells for all users, adds nvmem support to eth_platform_get_mac_address(),
converts davinci_emac driver to using it and replaces at24_platform_data
with device properties.

There's also one board (da850-evm) which uses MTD for reading the MAC
address. I used the patch from Alban Bedel's previous submission[2] to
add support for nvmem to the MTD framework. Since this user doesn't
need device tree, I dropped Alban's patches modifying the DT bindings.
We can add that later once an agreement is reached. For the time being
MTD devices are registered as nvmem devices and we're registering the
mac-address cell using the cell lookup mechanism.

This series adds a blocking notifier chain to the nvmem framework, so
that we can keep the EEPROM reading code in the mityomapl138 board file
with only slight modifications.

I also included some minor fixes to the modified code.

Tested on da850-evm & dm365-evm.

[1] https://lkml.org/lkml/2018/6/29/153
[2] https://lkml.org/lkml/2018/3/24/312

Alban Bedel (1):
  mtd: Add support for reading MTD devices via the nvmem API

Bartosz Golaszewski (27):
  nvmem: add support for cell lookups
  Documentation: nvmem: document lookup entries
  nvmem: add a notifier chain
  nvmem: provide nvmem_device_name()
  nvmem: remove the name field from struct nvmem_device
  ARM: davinci: dm365-evm: use nvmem lookup for mac address
  ARM: davinci: dm644-evm: use nvmem lookup for mac address
  ARM: davinci: dm646x-evm: use nvmem lookup for mac address
  ARM: davinci: da830-evm: use nvmem lookup for mac address
  ARM: davinci: mityomapl138: add nvmem cells lookup entries
  ARM: davinci: da850-evm: use nvmem lookup for mac address
  ARM: davinci: da850-evm: remove unnecessary include
  net: split eth_platform_get_mac_address() into subroutines
  net: add support for nvmem to eth_platform_get_mac_address()
  net: davinci_emac: use eth_platform_get_mac_address()
  ARM: davinci: da850-evm: remove dead MTD code
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code related to MAC address reading
  ARM: davinci: mityomapl138: use nvmem notifiers
  ARM: davinci: mityomapl138: use device properties for at24 eeprom
  eeprom: at24: kill at24_platform_data

 Documentation/nvmem/nvmem.txt              |  28 +++++
 MAINTAINERS                                |   1 -
 arch/arm/mach-davinci/board-da830-evm.c    |  25 ++--
 arch/arm/mach-davinci/board-da850-evm.c    |  45 +++-----
 arch/arm/mach-davinci/board-dm365-evm.c    |  25 ++--
 arch/arm/mach-davinci/board-dm644x-evm.c   |  24 ++--
 arch/arm/mach-davinci/board-dm646x-evm.c   |  25 ++--
 arch/arm/mach-davinci/board-mityomapl138.c |  59 +++++++---
 arch/arm/mach-davinci/board-sffsdr.c       |  13 +--
 arch/arm/mach-davinci/common.c             |  15 ---
 drivers/misc/eeprom/at24.c                 | 127 +++++++++------------
 drivers/mtd/Kconfig                        |   1 +
 drivers/mtd/mtdcore.c                      |  50 ++++++++
 drivers/net/ethernet/ti/davinci_emac.c     |  12 +-
 drivers/nvmem/core.c                       | 106 ++++++++++++++++-
 include/linux/davinci_emac.h               |   2 -
 include/linux/mtd/mtd.h                    |   2 +
 include/linux/nvmem-consumer.h             |  31 +++++
 include/linux/nvmem-provider.h             |  10 ++
 include/linux/platform_data/at24.h         |  60 ----------
 net/ethernet/eth.c                         |  86 ++++++++++++--
 21 files changed, 492 insertions(+), 255 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

-- 
2.18.0

