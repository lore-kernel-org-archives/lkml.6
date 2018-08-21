Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4218C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C12A214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C12A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeHUXzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:55:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHUXzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:55:38 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lm8JB-1gRp9C1BI1-00Zhqz; Tue, 21 Aug 2018 22:33:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH] y2038: provide aliases for compat helpers
Date:   Tue, 21 Aug 2018 22:33:00 +0200
Message-Id: <20180821203329.2089473-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Tz4rR78D6D5YDjwxi2ltvZGIPabdLWnHbdesETs4CKgteO0gnVx
 4Uq5ah36AgwOmUsS6GI0YrwZ8Pc80VR7IiJNly6C3aB9KWImyP6cZNaCUdq01cFGsdOJZpF
 9fbXIK4PLTKF5isytvhDPNnmhiQKqgQeAtmhRpdrNzvDUn4pM8h+ugeKV74/MTcAC0LM7Mx
 3HSA6EWkUIaWi/31RUGjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MAg3g7v3ovI=:4wKqJaGy8zxXO3cwqLaGLY
 lu7AFywzr1x+E3hIrne6EoEhHv23mvnPImXt4BiPoDQeH4Oo54yYJqpSunVdVS/Pshhe0FMEa
 0CY8Ku8CSRM+mSNzpxYeM/3dnxCX0vKpYiPQDnz/TRdUv8oQNUB5/AcFrnq/8mJ3DqSEqmdi9
 xOn/FO4cxipx7yOeMrwv9CET7aHNBPsO+lUz/bG5NSgc57lY5KMIokejkuGOZsH3QVvu6oYHr
 SFrVGouXF8f0e3PMj70HoGrz9UWVEoE5ceF/yT+23YWuO+XwPc/RzyoI/BPzt+IJURNWEane7
 2lxuThFnkDT3IMVWdmiBWpijtvxcsiMay7Y+T8O9MDWToX6JyYN/U7h9BwQaL6n7ixy62vd6P
 K/vMfSHwecQQYyHe7pJCIal7GcTSeLWUWUIHFqpDUgGhzn/V7A4F5PMQftEbdRjgjQDkuK9gQ
 2z+c8+XScaM+TD1+tYPucaUME5l8poImkjudS1YV/MGm3mPYkICH2lIWp15KDQ+XeskhN2fWt
 VMpBREsJAoBijiafBrloGFJ1nCx/WHSODxyb8+v866VWz/z63oxv/DY3G+292dZA9HVjF+MC+
 bJs8PfHuG7wpNia05HwbP1SqtlY/7FAP5KeNf5i1rdQPwhb6la6fGCR2/OnFEhex2mP3tRRM9
 d5Yeh96wqIW/h3PiHUYHQGDefNTsZmAFPUV0x+5jfSTiWQTd269kTrqGYhGk9xbqGUbw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the system call rework for 64-bit time_t, we are restructuring
the way that compat syscalls deal with 32-bit time_t, reusing the
implementation for 32-bit architectures. Christoph Hellwig suggested
a rename of the associated types and interfaces to avoid the confusing
usage of the 'compat' prefix for 32-bit architectures.

To prepare for doing that in linux-4.20, this adds a set of macros
that lets us convert subsystems separately to the new names and
avoid some of the nastier merge conflicts.

Link: https://lore.kernel.org/lkml/20180713133204.3123939-1-arnd@arndb.de/
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch I posted originally was ready but didn't see proper linux-next
testing as I did not get to finalize it before my summer vacation,
so this is the minimal replacement I'd still like to get into 4.19-rc1,
in order to base patches for system calls, sound, networking, media
and file systems on top of.

I have put it into linux-next now after realizing that it would be
a problem to do all my other planned changes for the 4.20 merge
window. Please let me know if you have concerns about the approach,
or provide an Ack if this is ok with you.
---
 include/linux/time32.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index 0b14f936100a..d1ae43c13e25 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -207,4 +207,19 @@ static inline s64 timeval_to_ns(const struct timeval *tv)
 extern struct timeval ns_to_timeval(const s64 nsec);
 extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
 
+/*
+ * New aliases for compat time functions. These will be used to replace
+ * the compat code so it can be shared between 32-bit and 64-bit builds
+ * both of which provide compatibility with old 32-bit tasks.
+ */
+#define old_time32_t		compat_time_t
+#define old_timeval32		compat_timeval
+#define old_timespec32		compat_timespec
+#define old_itimerspec32	compat_itimerspec
+#define ns_to_old_timeval32	ns_to_compat_timeval
+#define get_old_itimerspec32	get_compat_itimerspec64
+#define put_old_itimerspec32	put_compat_itimerspec64
+#define get_old_timespec32	compat_get_timespec64
+#define put_old_timespec32	compat_put_timespec64
+
 #endif
-- 
2.18.0

