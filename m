Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDBEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C622750F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="m6O93B+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C622750F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966615AbeF1OdM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33269 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966493AbeF1OdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so21004330wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VWqFfr1hyMACqJhZV+Y1bRgQChY+cwo1K2Sr0r+jgYY=;
        b=m6O93B+7Tyxle5w1H11Dfud0UMQNIWG9VnFqWjP5b+KnoYpxTrsQZxk4dcYZ2ZzIpr
         5JFH0jqJr11gKDaW3FdsFU4bjacbPHkktfsG06QnE2CJxswWIXG8FSWDV/lwPd1OGx8o
         0HfFemfuUmJCdYEni9Kg/UIvMpSzI06aNM0Xo5kLdBRtsJrynwgdudtHi38KGWKTQj4A
         vc5rEpQEnHwL64cfrYK8MDk5Fu4EECF9RQlyo48l2moLYUd/Akx6taCTbQHSw2CAJAtf
         Woh3eddvmPpfeKVTB23yfNuh1oDlu5NyuuFyHXS92vQPXily7EfDRVR+KNM9Bs6x5LH1
         tvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VWqFfr1hyMACqJhZV+Y1bRgQChY+cwo1K2Sr0r+jgYY=;
        b=H17Mr0TZh8XlP2T/RYT6xLjIfnSF1LqvWSy8fV02Al8sFG4H6LmHOkIlhwLvjpCMjv
         ndZDihoblLtRMyvHWRRXAb1nwEPc51bW3h5lp7SBo4Feaq0uWyLeR9jpSBRp3ytaYfVl
         hz2wb2I3AJL9usnP/QuFTJDLVnBKbd+BxATxI3e/crw9vAQE+m1DU2quYY1FtG8IRP4H
         AKPDYcyMY6lwU9L1tUDDB+wtutZuxyI/eW/IE8oQHIM5M6Dew3wcbhalqgj4KP/V10Wf
         1eaonU0zaE1AzioHUOHjQdhcfGCzu7SMEGlMc7JSyYFlsf2YADqgOigqtCiunDHBHLH9
         BpFw==
X-Gm-Message-State: APt69E3gJeV0TMhtigfc7a8xpCzonWGpYicVvFswK9rZfLrr4a7u6Sp4
        SktqlZO8UaMsBOWKOvzpTSm4PQ==
X-Google-Smtp-Source: AAOMgpfXRu3DWPSluAwwiHEnD8ANg+e/mAHgFNXRLd2hqrVYOVEb3bh2cixVXQC/qOSNYhFeu3pivw==
X-Received: by 2002:a1c:d482:: with SMTP id l124-v6mr7937054wmg.22.1530196388404;
        Thu, 28 Jun 2018 07:33:08 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:07 -0700 (PDT)
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
Subject: [PATCH v3 00/18] ARM: davinci: step towards removing at24_platform_data
Date:   Thu, 28 Jun 2018 16:32:26 +0200
Message-Id: <20180628143244.4561-1-brgl@bgdev.pl>
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
- in order to completly remove the mac_addr from davinci's soc_info
  added a patch that moves reading the MAC address from SPI to the emac
  driver
- removed more dead code

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
 arch/arm/mach-davinci/board-da830-evm.c    | 25 +++++---
 arch/arm/mach-davinci/board-da850-evm.c    | 28 --------
 arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++---
 arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++---
 arch/arm/mach-davinci/board-dm646x-evm.c   | 25 +++++---
 arch/arm/mach-davinci/board-mityomapl138.c | 30 ++++++---
 arch/arm/mach-davinci/board-sffsdr.c       | 13 ++--
 arch/arm/mach-davinci/common.c             | 15 -----
 drivers/net/ethernet/ti/davinci_emac.c     | 50 ++++++++++++---
 drivers/nvmem/core.c                       | 75 +++++++++++++++++++++-
 include/linux/davinci_emac.h               |  2 -
 include/linux/nvmem-consumer.h             |  6 ++
 include/linux/nvmem-provider.h             | 10 +++
 14 files changed, 253 insertions(+), 103 deletions(-)

-- 
2.17.1

