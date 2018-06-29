Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EF7C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1270C27C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bapDwlDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1270C27C7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeF2Jkr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:40:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39184 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeF2Jko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so1358393wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=D0sm8KVigbKd7osqf7kMu5unfGlbUtxIm9HDueQRlIk=;
        b=bapDwlDT5Q8W6/9HW3mUY/4ygaOcxd4Qg1hGxcayn+B1YZsNeeArvqUjHaeUQ/cPWN
         WloYnuLtujw7AgstQvgR5wKWfhbpCOlgZfiHwwUikwXdxQajLfnP1RRDi9q60A12gL/+
         A9LiR3OYo+qUFl7lDuPtNYcFsfiluA69n1S5ft9T0JNL6G/UJre8HqbmQfGfLYKZ+WbZ
         At+25DPTY3Y8K30tFaL3QakqSZDR2pRlKr+jM7Rju3KDocYxuZORGmm8q7jYPBn5i7s6
         xkCK5I3JZjax55Kmo7unQDfgbQrlAihI4Fo2qd0DQy8+IgCmovUDwc0OH8IFtn+4AJB5
         2m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D0sm8KVigbKd7osqf7kMu5unfGlbUtxIm9HDueQRlIk=;
        b=ITft9IL+qOtpVTZXL35cPN9QHpCpYMMNqdlNdGRmmiehEZV2KcWGefHILu+iI/CSnJ
         xVJAwP82nPhIphtsuNaHEVI5I8oHErrHn405qJDQ+EnBfjMmnmW48m1Wt26QAH7gLN0+
         6rkfTDLkilBt3z/O0VXhTKnfSWkD1BIEcXQHtvfFrdTgBHtwMP6/Skrqm+PpvrcQqhff
         XQokLDwmlkZhYhPuQIcJ/dmW+926QxF/NBCURMW6H7dqf6QC62F7lsiT6kWgZlz87GUW
         3jz1pBioQAHtJ7hBJEUjCRmb/jobycxATZrWNtkaWuFzYmTyeBrme/0EAGDXkS6H5cow
         nfDQ==
X-Gm-Message-State: APt69E1MSFQOXr13CZtaTYdBnN89W5IGQjEADCAdOKTa1ik6i+f5PrvV
        yZr5SAk9hOq2H4YenReBgA4ctQ==
X-Google-Smtp-Source: AAOMgpdN2rRdDrTlic/qd2pyc2Icvh+Du0c8oLU9hW92nXzP660DEN1SD2LH/WKdt8rIYlgSWwcGYg==
X-Received: by 2002:a1c:8d15:: with SMTP id p21-v6mr1121624wmd.145.1530265243240;
        Fri, 29 Jun 2018 02:40:43 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
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
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 00/18] ARM: davinci: step towards removing at24_platform_data
Date:   Fri, 29 Jun 2018 11:40:21 +0200
Message-Id: <20180629094039.7543-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since I took over maintainership of the at24 driver I've been working
towards removing at24_platform_data in favor for device properties.

DaVinci is the only platform that's still using it - all other users
have already been converted.

One of the obstacles in case of DaVinci is removing the setup() callback
from the pdata struct, the only user of which are some davinci boards.

Most boards use the EEPROM to store the MAC address. This series adds
support for cell lookups to the nvmem framework, registers relevant
cells for all users, converts the davinci_emac driver to using them
and replaces at24_platform_data with device properties.

The only board that's still using this callback is now mityomapl138.
Unfortunately it stores more info in EEPROM than just the MAC address
and will require some more work. Unfortunately I don't have access
to this board so I can't test any actual solutions on a live hardware.

Tested on a dm365-evm board.

v1 -> v2:
- for backward compatiblity: fall back to using of_get_mac_address() if
  we can't get an nvmem cell in patch 7
- add patch 15 which removes dead code

v2 -> v3:
- documented new nvmem cell lookup API
- renamed the nvmem cell lookup routines
- added a function for removing the lookup tables
- in order to completly remove the mac_addr from davinci's soc_info
  added a patch that moves reading the MAC address from SPI to the emac
  driver
- removed more dead code

v3 -> v4:
- only return -EPROBE_DEFER from nvmem_cell_from_lookup() if we have
  a matching lookup entry but no corresponding nvmem device yet, return
  -ENOENT if we can't match the lookup
- check for -EPROBE_DEFER in the emac driver
- put the mtd device after reading the MAC address

Bartosz Golaszewski (18):
  nvmem: add support for cell lookups
  Documentation: nvmem: document lookup entries
  ARM: davinci: dm365-evm: use nvmem lookup for mac address
  ARM: davinci: dm644-evm: use nvmem lookup for mac address
  ARM: davinci: dm646x-evm: use nvmem lookup for mac address
  ARM: davinci: da830-evm: use nvmem lookup for mac address
  ARM: davinci: mityomapl138: add nvmem cells lookup entries
  net: davinci_emac: potentially get the MAC address from MTD
  ARM: davinci: da850-evm: remove dead MTD code
  net: davinci_emac: use nvmem to retrieve the mac address
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code related to MAC address reading

 Documentation/nvmem/nvmem.txt              | 28 ++++++++
 arch/arm/mach-davinci/board-da830-evm.c    | 25 ++++---
 arch/arm/mach-davinci/board-da850-evm.c    | 28 --------
 arch/arm/mach-davinci/board-dm365-evm.c    | 25 ++++---
 arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++---
 arch/arm/mach-davinci/board-dm646x-evm.c   | 25 ++++---
 arch/arm/mach-davinci/board-mityomapl138.c | 30 ++++++---
 arch/arm/mach-davinci/board-sffsdr.c       | 13 ++--
 arch/arm/mach-davinci/common.c             | 15 -----
 drivers/net/ethernet/ti/davinci_emac.c     | 53 ++++++++++++---
 drivers/nvmem/core.c                       | 77 +++++++++++++++++++++-
 include/linux/davinci_emac.h               |  2 -
 include/linux/nvmem-consumer.h             |  6 ++
 include/linux/nvmem-provider.h             | 10 +++
 14 files changed, 258 insertions(+), 103 deletions(-)

-- 
2.17.1

