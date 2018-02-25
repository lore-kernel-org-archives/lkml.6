Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeBYT2l (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:28:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBYT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:28:37 -0500
Date: Sun, 25 Feb 2018 20:28:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf fix for 4.16
Message-ID: <alpine.DEB.2.21.1802252014150.1468@nanos.tec.linutronix.de>
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

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A single commit which shuts up a bogus GCC-8 warning.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()


 arch/x86/oprofile/nmi_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 174c59774cc9..a7a7677265b6 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -460,7 +460,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
