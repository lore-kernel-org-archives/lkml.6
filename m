Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbeCKQTu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:19:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:19:49 -0400
Date: Sun, 11 Mar 2018 09:19:40 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer fix for 4.16
Message-ID: <alpine.DEB.2.21.1803110911500.3841@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

Just a single fix which adds a missing Kconfig dependency to avoid unmet
dependency warnings.

Thanks,

	tglx

------------------>
Masahiro Yamada (1):
      clocksource/atmel-st: Add 'depends on HAS_IOMEM' to fix unmet dependency


 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b3b4ed9b6874..d2e5382821a4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -386,6 +386,7 @@ config ATMEL_PIT
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
+	depends on HAS_IOMEM
 	select TIMER_OF
 	select MFD_SYSCON
 	help
