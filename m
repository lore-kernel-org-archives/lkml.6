Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8711DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B5F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B5F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeLLXwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:52:02 -0500
Received: from anholt.net ([50.246.234.109]:59136 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeLLXv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:51:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1AE9210A1DB1;
        Wed, 12 Dec 2018 15:51:59 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vi416EljiwjO; Wed, 12 Dec 2018 15:51:55 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6E4C310A1D8D;
        Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 237732FE2D16; Wed, 12 Dec 2018 15:51:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 0/5] BCM2835 PM driver
Date:   Wed, 12 Dec 2018 15:51:45 -0800
Message-Id: <20181212235150.6491-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 adds the system-power-controller node to the binding as requested
by Stefan.  No driver changes are added to make the power controller
behavior optional yet, since it's really unrelated to this series.

Eric Anholt (5):
  dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
  bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
  soc: bcm: bcm2835-pm: Add support for power domains under a new
    binding.
  ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
    (v4)
  ARM: bcm283x: Switch V3D over to using the PM driver instead of
    firmware.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |  46 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                |  17 +-
 arch/arm/mach-bcm/Kconfig                     |   1 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bcm2835-pm.c                      |  92 +++
 drivers/soc/bcm/Kconfig                       |  11 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm2835-power.c               | 661 ++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                |  26 +-
 include/dt-bindings/soc/bcm2835-pm.h          |  28 +
 include/linux/mfd/bcm2835-pm.h                |  14 +
 12 files changed, 878 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h

-- 
2.20.0.rc1

