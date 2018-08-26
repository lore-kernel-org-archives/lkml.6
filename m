Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FCC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3474B2147E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3474B2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeHZNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 09:21:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 09:21:27 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftrW0-0000Gy-Rd; Sun, 26 Aug 2018 11:39:24 +0200
Subject: [GIT pull] timer updates for 4.19
Message-ID: <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
Date:   Sun, 26 Aug 2018 11:39:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

New defines for the compat time* types so they can be shared between 32bit
and 64bit builds. Not used yet, but merging them now allows the actual
conversions to be merged through different maintainer trees without
dependencies

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      y2038: Provide aliases for compat helpers


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

