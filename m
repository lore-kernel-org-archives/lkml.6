Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeBGAxi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:53:38 -0500
Received: from mx1.mpynet.fi ([82.197.21.84]:24972 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932106AbeBGAxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:53:37 -0500
From: Tuomas Tynkkynen <tuomas@tuxera.com>
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
CC: <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable serial console on RPi 3
Date: Wed, 7 Feb 2018 02:53:09 +0200
Message-ID: <20180207005309.14365-1-tuomas@tuxera.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raspberry Pi 3 uses the 8250-based auxilary UART of the BCM2837 SoC
as the primary serial console of the board, so enable it in the
multiplatform defconfig.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index da7387689b88..f77bd01c7927 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -312,6 +312,9 @@ CONFIG_INPUT_ADXL34X=m
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_8250_MT6577=y
-- 
2.16.1
