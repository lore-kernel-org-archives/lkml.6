Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8743220874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfAKOYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:24:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40975 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbfAKOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:23 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054I-76; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002vm-0e; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v1 00/11] MIPS: ath79: move towards proper OF support
Date:   Fri, 11 Jan 2019 15:22:29 +0100
Message-Id: <20190111142240.10908-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches are take from OpenWRT, rebased and tested with kernel
v5.0-rt1 on DPTechnics DPT-Module (Atheros AR9331) by me.

Since one dt-bindings header is touched, I added DT maintainers to the
TO/CC.

Felix Fietkau (6):
  MIPS: ath79: add helpers for setting clocks and expose the ref clock
  MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc
    init
  MIPS: ath79: pass PLL base to clock init functions
  MIPS: ath79: make specifying the reference clock in DT optional
  MIPS: ath79: support setting up clock via DT on all SoC types
  MIPS: ath79: export switch MDIO reference clock

John Crispin (5):
  MIPS: ath79: drop legacy IRQ code
  MIPS: ath79: drop machfiles
  MIPS: ath79: drop legacy pci code
  MIPS: ath79: drop platform device registration code
  MIPS: ath79: drop !OF clock code

 arch/mips/Kconfig                        |   1 -
 arch/mips/ath79/Kconfig                  |  73 -----
 arch/mips/ath79/Makefile                 |  23 +-
 arch/mips/ath79/clock.c                  | 342 ++++++++++-------------
 arch/mips/ath79/common.h                 |   5 -
 arch/mips/ath79/dev-common.c             | 159 -----------
 arch/mips/ath79/dev-common.h             |  18 --
 arch/mips/ath79/dev-gpio-buttons.c       |  56 ----
 arch/mips/ath79/dev-gpio-buttons.h       |  23 --
 arch/mips/ath79/dev-leds-gpio.c          |  54 ----
 arch/mips/ath79/dev-leds-gpio.h          |  21 --
 arch/mips/ath79/dev-spi.c                |  38 ---
 arch/mips/ath79/dev-spi.h                |  22 --
 arch/mips/ath79/dev-usb.c                | 242 ----------------
 arch/mips/ath79/dev-usb.h                |  17 --
 arch/mips/ath79/dev-wmac.c               | 155 ----------
 arch/mips/ath79/dev-wmac.h               |  17 --
 arch/mips/ath79/irq.c                    | 169 -----------
 arch/mips/ath79/mach-ap121.c             |  92 ------
 arch/mips/ath79/mach-ap136.c             | 156 -----------
 arch/mips/ath79/mach-ap81.c              | 100 -------
 arch/mips/ath79/mach-db120.c             | 136 ---------
 arch/mips/ath79/mach-pb44.c              | 128 ---------
 arch/mips/ath79/mach-ubnt-xm.c           | 126 ---------
 arch/mips/ath79/machtypes.h              |  28 --
 arch/mips/ath79/pci.c                    | 273 ------------------
 arch/mips/ath79/pci.h                    |  35 ---
 arch/mips/ath79/setup.c                  |  78 +-----
 arch/mips/include/asm/mach-ath79/ath79.h |   4 -
 arch/mips/pci/Makefile                   |   1 +
 arch/mips/pci/fixup-ath79.c              |  21 ++
 include/dt-bindings/clock/ath79-clk.h    |   4 +-
 32 files changed, 185 insertions(+), 2432 deletions(-)
 delete mode 100644 arch/mips/ath79/dev-common.c
 delete mode 100644 arch/mips/ath79/dev-common.h
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.h
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.c
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.h
 delete mode 100644 arch/mips/ath79/dev-spi.c
 delete mode 100644 arch/mips/ath79/dev-spi.h
 delete mode 100644 arch/mips/ath79/dev-usb.c
 delete mode 100644 arch/mips/ath79/dev-usb.h
 delete mode 100644 arch/mips/ath79/dev-wmac.c
 delete mode 100644 arch/mips/ath79/dev-wmac.h
 delete mode 100644 arch/mips/ath79/irq.c
 delete mode 100644 arch/mips/ath79/mach-ap121.c
 delete mode 100644 arch/mips/ath79/mach-ap136.c
 delete mode 100644 arch/mips/ath79/mach-ap81.c
 delete mode 100644 arch/mips/ath79/mach-db120.c
 delete mode 100644 arch/mips/ath79/mach-pb44.c
 delete mode 100644 arch/mips/ath79/mach-ubnt-xm.c
 delete mode 100644 arch/mips/ath79/machtypes.h
 delete mode 100644 arch/mips/ath79/pci.c
 delete mode 100644 arch/mips/ath79/pci.h
 create mode 100644 arch/mips/pci/fixup-ath79.c

-- 
2.20.1

