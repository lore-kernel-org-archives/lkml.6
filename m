Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE889214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE889214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeHVQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:41:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeHVQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:41:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7MDG4KP2861922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Aug 2018 06:16:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7MDG3E12861919;
        Wed, 22 Aug 2018 06:16:03 -0700
Date:   Wed, 22 Aug 2018 06:16:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-fd991a23c8f6ef30692f77409602ccf3614353b2@git.kernel.org>
Cc:     arnd@arndb.de, deepa.kernel@gmail.com, hpa@zytor.com,
        mingo@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, john.stultz@linaro.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hch@lst.de,
          john.stultz@linaro.org, arnd@arndb.de, mingo@kernel.org,
          hpa@zytor.com, deepa.kernel@gmail.com
In-Reply-To: <20180821203329.2089473-1-arnd@arndb.de>
References: <20180821203329.2089473-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] y2038: Provide aliases for compat helpers
Git-Commit-ID: fd991a23c8f6ef30692f77409602ccf3614353b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fd991a23c8f6ef30692f77409602ccf3614353b2
Gitweb:     https://git.kernel.org/tip/fd991a23c8f6ef30692f77409602ccf3614353b2
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Tue, 21 Aug 2018 22:33:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 22 Aug 2018 15:11:35 +0200

y2038: Provide aliases for compat helpers

As part of the system call rework for 64-bit time_t, we are restructuring
the way that compat syscalls deal with 32-bit time_t, reusing the
implementation for 32-bit architectures. Christoph Hellwig suggested a
rename of the associated types and interfaces to avoid the confusing usage
of the 'compat' prefix for 32-bit architectures.

To prepare for doing that in linux-4.20, add a set of macros that allows to
convert subsystems separately to the new names and avoids some of the
nastier merge conflicts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christoph Hellwig <hch@lst.de>
Cc: y2038@lists.linaro.org
Cc: John Stultz <john.stultz@linaro.org>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Link: https://lkml.kernel.org/r/20180821203329.2089473-1-arnd@arndb.de

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
