Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBXSO6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:14:58 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44619 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBXSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:14:56 -0500
X-Google-Smtp-Source: AG47ELvtSKx92ssV7H0UGJrdPXxbOrh3Tt9fxx9xwmQ/yDhhdAPgGI6v16kqGcNyn0PVVP3SYSVcFQ==
From: Gustavo Leite <gustavoleite.ti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Gustavo Leite <gustavoleite.ti@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>, Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] linux/kernel.h: break long lines
Date: Sat, 24 Feb 2018 15:10:02 -0300
Message-Id: <20180224181003.29604-1-gustavoleite.ti@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break lines that are longer than 80 characters do match the linux coding
style.

Signed-off-by: Gustavo Leite <gustavoleite.ti@gmail.com>
---
 include/linux/kernel.h | 74 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..13b84cfd09a9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -307,10 +307,12 @@ static inline void refcount_error_report(struct pt_regs *regs, const char *err)
 #endif
 
 /* Internal, do not use. */
-int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
+int __must_check _kstrtoul(const char *s, unsigned int base,
+		unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
 
-int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int __must_check kstrtoull(const char *s, unsigned int base,
+		unsigned long long *res);
 int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
 
 /**
@@ -329,7 +331,8 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * Used as a replacement for the obsolete simple_strtoull. Return code must
  * be checked.
 */
-static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
+static inline int __must_check kstrtoul(const char *s, unsigned int base,
+		unsigned long *res)
 {
 	/*
 	 * We want to shortcut function call, but
@@ -358,7 +361,8 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * Used as a replacement for the obsolete simple_strtoull. Return code must
  * be checked.
  */
-static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
+static inline int __must_check kstrtol(const char *s, unsigned int base,
+		long *res)
 {
 	/*
 	 * We want to shortcut function call, but
@@ -371,25 +375,30 @@ static inline int __must_check kstrtol(const char *s, unsigned int base, long *r
 		return _kstrtol(s, base, res);
 }
 
-int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
+int __must_check kstrtouint(const char *s, unsigned int base,
+		unsigned int *res);
 int __must_check kstrtoint(const char *s, unsigned int base, int *res);
 
-static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
+static inline int __must_check kstrtou64(const char *s, unsigned int base,
+		u64 *res)
 {
 	return kstrtoull(s, base, res);
 }
 
-static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
+static inline int __must_check kstrtos64(const char *s, unsigned int base,
+		s64 *res)
 {
 	return kstrtoll(s, base, res);
 }
 
-static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
+static inline int __must_check kstrtou32(const char *s, unsigned int base,
+		u32 *res)
 {
 	return kstrtouint(s, base, res);
 }
 
-static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
+static inline int __must_check kstrtos32(const char *s, unsigned int base,
+		s32 *res)
 {
 	return kstrtoint(s, base, res);
 }
@@ -400,34 +409,49 @@ int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
 int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 int __must_check kstrtobool(const char *s, bool *res);
 
-int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
-int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
-int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
-int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
-int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
-
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
+int __must_check kstrtoull_from_user(const char __user *s, size_t count,
+		unsigned int base, unsigned long long *res);
+int __must_check kstrtoll_from_user(const char __user *s, size_t count,
+		unsigned int base, long long *res);
+int __must_check kstrtoul_from_user(const char __user *s, size_t count,
+		unsigned int base, unsigned long *res);
+int __must_check kstrtol_from_user(const char __user *s, size_t count,
+		unsigned int base, long *res);
+int __must_check kstrtouint_from_user(const char __user *s, size_t count,
+		unsigned int base, unsigned int *res);
+int __must_check kstrtoint_from_user(const char __user *s, size_t count,
+		unsigned int base, int *res);
+int __must_check kstrtou16_from_user(const char __user *s, size_t count,
+		unsigned int base, u16 *res);
+int __must_check kstrtos16_from_user(const char __user *s, size_t count,
+		unsigned int base, s16 *res);
+int __must_check kstrtou8_from_user(const char __user *s, size_t count,
+		unsigned int base, u8 *res);
+int __must_check kstrtos8_from_user(const char __user *s, size_t count,
+		unsigned int base, s8 *res);
+int __must_check kstrtobool_from_user(const char __user *s, size_t count,
+		bool *res);
+
+static inline int __must_check kstrtou64_from_user(const char __user *s,
+		size_t count, unsigned int base, u64 *res)
 {
 	return kstrtoull_from_user(s, count, base, res);
 }
 
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
+static inline int __must_check kstrtos64_from_user(const char __user *s,
+		size_t count, unsigned int base, s64 *res)
 {
 	return kstrtoll_from_user(s, count, base, res);
 }
 
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
+static inline int __must_check kstrtou32_from_user(const char __user *s,
+		size_t count, unsigned int base, u32 *res)
 {
 	return kstrtouint_from_user(s, count, base, res);
 }
 
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
+static inline int __must_check kstrtos32_from_user(const char __user *s,
+		size_t count, unsigned int base, s32 *res)
 {
 	return kstrtoint_from_user(s, count, base, res);
 }
-- 
2.16.1
