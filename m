Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEDKfU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:35:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39058 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:35:19 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH REPOST] mfd: syscon: atmel-smc: include string.h
Date: Fri,  4 May 2018 12:34:46 +0200
Message-Id: <20180504103446.20104-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The string.h header file is needed for the memset() definition. The RT
build fails because it is not pulled in via other header files.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/atmel-smc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -12,6 +12,7 @@
  */
=20
 #include <linux/mfd/syscon/atmel-smc.h>
+#include <linux/string.h>
=20
 /**
  * atmel_smc_cs_conf_init - initialize a SMC CS conf
