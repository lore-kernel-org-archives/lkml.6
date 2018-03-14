Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeCNPsN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:48:13 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCNPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:48:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 30/47] can: remove bfin_can driver
Date: Wed, 14 Mar 2018 16:35:43 +0100
Message-Id: <20180314153603.3127932-31-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:BjmbugiYxHll1dstXBOJMalJ8xFjOpA/hHbuoNdg6729deb29Is
 srCDPJD1LOSMiOTWyqy6zm1VaqlAF2eoSly/TDotIVqJ+62i3UyqJfVTGNEGe1kB7hh5nac
 JIu0h3Nppl58dtLh/OhVXWZ2l/v+/uZ/5yuKj86tR1yU1WARuSudWhBcu8q7BKx9s3uK5V6
 1YstgzrOqwBqokv2DxY0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sJEoi5fnj2I=:498Ff7ZnwQY91/9VQiUGSU
 NqVMXum20rBI1GxMS6jGJQnaHNhOMCGFqW+T20oL10tdp0ZCv6IOYa9BS4S4a6gmszzoSFi4p
 V1Z/CDQL+UEyAP8Qm+SDS5I6hSjK7YSMKDkiW1GOqMgkA9JFlzYe3ZRouwSzX1G/W3ACedWGB
 hLPE9scn4ZgiKwMTHawitmg5kQkbT2CgSf2PuPteVu06sMVLGfMJ0CytdiLBOjnzecU2dncut
 npQ1csrzQC4aAD+/0g0/V5pJ2I9DFOHdSJiElU5DGeonL+8yAoAB92DSIOSco/l3UwO4vQYtA
 UhhfVTxLwHIUdHDxJJpI3Kxg0Q3rXpTbgVwuHcP9QgDj8Z2qBHHJ1A4a5HdgpB3QUuacU6SeZ
 Tc5c/yaUpJY+Mpf5C28gefuEBsEzVrvxFbz2PrO8ujv9/F2tnke4is94BJEAZZMqz4f1G+Iin
 Y3n48oq4rFt2u0ifu2ILO3JCQw6T5HxU2AxO/zbpJuCk142wtRFUcDMYXawVLefH5dBAghOFS
 1eGspdzoBZ6Pudi9zBIJ7e9hfg71ZLdiuRkjVZAGhF8DMIWXYVYzZQIxC4V7lRS9nAiBMKIYL
 /RnokOxj8qLPMk8SLIKc3xccomtNmIFGHuxRm3bOlJrRfv1OfgRFgg2AB32/iQBGFVatJVWQI
 EYhhuK+Z3tC/paG4HyArpAi+Z2VpIinIogllibWZ2V8BXK/jpSTAHPBYnHJKPrqdpUm6I+LYM
 inMVN7PXOzneLVcEvtM3dqM/wBc5CHm0kMbt3A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this one is now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/Kconfig    |   9 -
 drivers/net/can/Makefile   |   1 -
 drivers/net/can/bfin_can.c | 784 ---------------------------------------------
 3 files changed, 794 deletions(-)
 delete mode 100644 drivers/net/can/bfin_can.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index ac4ff394bc56..2cb75988b328 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -88,15 +88,6 @@ config CAN_AT91
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
 
-config CAN_BFIN
-	depends on BF534 || BF536 || BF537 || BF538 || BF539 || BF54x
-	tristate "Analog Devices Blackfin on-chip CAN"
-	---help---
-	  Driver for the Analog Devices Blackfin on-chip CAN controllers
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_can.
-
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
 	depends on ARM || PPC
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 02b8ed794564..44922bf29b6a 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -19,7 +19,6 @@ obj-y				+= usb/
 obj-y				+= softing/
 
 obj-$(CONFIG_CAN_AT91)		+= at91_can.o
-obj-$(CONFIG_CAN_BFIN)		+= bfin_can.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan.o
diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
deleted file mode 100644
index 1deb8ff90a89..000000000000
-- 
2.9.0
