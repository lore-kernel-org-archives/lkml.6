Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeDQMri (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:47:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64414 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbeDQMrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:47:37 -0400
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Remove RTC clock on 88x
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180417124735.8991D6C0AC@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 17 Apr 2018 14:47:35 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 885 familly processors don't have the Real Time Clock

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/adder875.c        | 2 --
 arch/powerpc/platforms/8xx/ep88xc.c          | 2 --
 arch/powerpc/platforms/8xx/mpc885ads_setup.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index 333dece79394..bcef9f66191e 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -111,7 +111,5 @@ define_machine(adder875) {
 	.get_irq = mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
 	.calibrate_decr = generic_calibrate_decr,
-	.set_rtc_time = mpc8xx_set_rtc_time,
-	.get_rtc_time = mpc8xx_get_rtc_time,
 	.progress = udbg_progress,
 };
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index cd0d90f1fb1c..ebcf34a14789 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -170,7 +170,5 @@ define_machine(ep88xc) {
 	.get_irq	= mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
 	.calibrate_decr = mpc8xx_calibrate_decr,
-	.set_rtc_time = mpc8xx_set_rtc_time,
-	.get_rtc_time = mpc8xx_get_rtc_time,
 	.progress = udbg_progress,
 };
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index e821a42d5816..a0c83c1905c6 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -220,7 +220,5 @@ define_machine(mpc885_ads) {
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
-	.set_rtc_time		= mpc8xx_set_rtc_time,
-	.get_rtc_time		= mpc8xx_get_rtc_time,
 	.progress		= udbg_progress,
 };
-- 
2.13.3
