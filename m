Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9161DC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A08821547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A08821547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeI0WVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:21:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0WVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:21:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG1Ssh083173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:01:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG1Sed083170;
        Thu, 27 Sep 2018 09:01:28 -0700
Date:   Thu, 27 Sep 2018 09:01:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-50ff18ab497aa22f6a59444625df7508c8918237@git.kernel.org>
Cc:     schwidefsky@de.ibm.com, arnd@arndb.de, mingo@kernel.org,
        tglx@linutronix.de, will.deacon@arm.com, jeyu@kernel.org,
        peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        heiko.carstens@de.ibm.com, rostedt@goodmis.org,
        keescook@chromium.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
          catalin.marinas@arm.com, will.deacon@arm.com, jeyu@kernel.org,
          ard.biesheuvel@linaro.org, peterz@infradead.org,
          mingo@kernel.org, arnd@arndb.de, tglx@linutronix.de,
          schwidefsky@de.ibm.com, hpa@zytor.com, rostedt@goodmis.org,
          keescook@chromium.org
In-Reply-To: <20180919065144.25010-3-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] jump_label: Implement generic support for relative
 references
Git-Commit-ID: 50ff18ab497aa22f6a59444625df7508c8918237
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

Commit-ID:  50ff18ab497aa22f6a59444625df7508c8918237
Gitweb:     https://git.kernel.org/tip/50ff18ab497aa22f6a59444625df7508c8918237
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 18 Sep 2018 23:51:37 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:47 +0200

jump_label: Implement generic support for relative references

To reduce the size taken up by absolute references in jump label
entries themselves and the associated relocation records in the
.init segment, add support for emitting them as relative references
instead.

Note that this requires some extra care in the sorting routine, given
that the offsets change when entries are moved around in the jump_entry
table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Link: https://lkml.kernel.org/r/20180919065144.25010-3-ard.biesheuvel@linaro.org

---
 arch/Kconfig               |  3 +++
 include/linux/jump_label.h | 28 ++++++++++++++++++++++++++++
 kernel/jump_label.c        | 22 +++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..9d329608913e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -359,6 +359,9 @@ config HAVE_PERF_USER_STACK_DUMP
 config HAVE_ARCH_JUMP_LABEL
 	bool
 
+config HAVE_ARCH_JUMP_LABEL_RELATIVE
+	bool
+
 config HAVE_RCU_TABLE_FREE
 	bool
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2eadff9b3b90..2768a925bafa 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -121,6 +121,32 @@ struct static_key {
 #include <asm/jump_label.h>
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
+
+struct jump_entry {
+	s32 code;
+	s32 target;
+	long key;	// key may be far away from the core kernel under KASLR
+};
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->code + entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->target + entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	long offset = entry->key & ~1L;
+
+	return (struct static_key *)((unsigned long)&entry->key + offset);
+}
+
+#else
 
 static inline unsigned long jump_entry_code(const struct jump_entry *entry)
 {
@@ -137,6 +163,8 @@ static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 	return (struct static_key *)((unsigned long)entry->key & ~1UL);
 }
 
+#endif
+
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
 {
 	return (unsigned long)entry->key & 1UL;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 834e43de0daf..898a1d0c38dc 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -47,14 +47,34 @@ static int jump_label_cmp(const void *a, const void *b)
 	return 0;
 }
 
+static void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 static void
 jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 {
 	unsigned long size;
+	void *swapfn = NULL;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE))
+		swapfn = jump_label_swap;
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, swapfn);
 }
 
 static void jump_label_update(struct static_key *key);
