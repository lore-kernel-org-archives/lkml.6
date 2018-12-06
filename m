Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702AC20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLSUtkLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702AC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeLFMZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbeLFMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so841189wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uSAA6A1aRTWO16DLBjPQUae1SegzQbJDGVzmV8tpfs=;
        b=tLSUtkLSM4VsoseHSxkk9UlgsSF9LYHyfSyPHzE/hgw9NdIVRYjEYCt2b2sZUlJG/1
         uqDS28//AknGUJ6zk2zY4PKdQ8+4tirjbHwaZwuxUYII8/CJ2BuOvvpkEq/aDfpTbtoA
         VH3gjYgJrXPk8eyVj8GZp51F8r6L+zIZ6ZpfxVzGvB6LVe2umAITfjSip/j218/bx97S
         HEvzXQSP2vxF0z4FWOYeSDWfMGAnX7lb9LTbaJAupapKa+mQu+Pwrsg7gUZRweVO212H
         R6tMZh/eBx1slp1fOaIraS+NDJMvXZ3LH07qR8gRV2FudaCq+whsbKrPssVnGqelpPwL
         B8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uSAA6A1aRTWO16DLBjPQUae1SegzQbJDGVzmV8tpfs=;
        b=jlPkaMX0SwnMn1bCyWR5/xkWEgQ5cU0gkYnsW4pHj7Il5RjbnApufSDu57xRIh/c+k
         hslmvfXaQtkedxxUqsWqc6wZVbLlZGJ7P9ZJq/zg0l+9kBjqHTHVZozt9yFqu4QTAzqv
         v8KSUxh7rnDGaIqmnQcip9RqS9fD8b3nmpA/ZNNnM3iJ+3WF0ksA7JgjQqI22lT127ju
         qBSkibpyPWioGzWqw+JSOF/iNiruro8ttw2YrxhrVEodN3euOmiJEkF8utbIY5xTuQ23
         SGdHJBL2zPEgBdY2XMc6Vdjy41JqbXKJgoh2vRNJtYYzfn3LSyZzFgKNEn7EWJ7xygHg
         9qyA==
X-Gm-Message-State: AA+aEWYw+cHQfH7dwUAhbM8n0ruFi7FmCVrLisxNVKEAxhCRNnEd/LQ6
        5iiD+yvW009W8fa5pLL3wiIy2g==
X-Google-Smtp-Source: AFSGD/V4zIb54Ou409sQv+ZnuWNPIZMqrE2tacqLuIwacW/LC9rLfpzzJFwYCO48owsIvI7L30/Cmg==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr9124048wma.24.1544099116333;
        Thu, 06 Dec 2018 04:25:16 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:15 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v13 17/25] kasan: add bug reporting routines for tag-based mode
Date:   Thu,  6 Dec 2018 13:24:35 +0100
Message-Id: <aee6897b1bd077732a315fd84c6b4f234dbfdfcb.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds rountines, that print tag-based KASAN error reports.
Those are quite similar to generic KASAN, the difference is:

1. The way tag-based KASAN finds the first bad shadow cell (with a
   mismatching tag). Tag-based KASAN compares memory tags from the shadow
   memory to the pointer tag.

2. Tag-based KASAN reports all bugs with the "KASAN: invalid-access"
   header.

Also simplify generic KASAN find_first_bad_addr.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/generic_report.c | 16 ++++-------
 mm/kasan/kasan.h          |  5 ++++
 mm/kasan/report.c         | 57 +++++++++++++++++++++------------------
 mm/kasan/tags_report.c    | 18 +++++++++++++
 4 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index 5201d1770700..a4604cceae59 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -33,16 +33,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
-static const void *find_first_bad_addr(const void *addr, size_t size)
+void *find_first_bad_addr(void *addr, size_t size)
 {
-	u8 shadow_val = *(u8 *)kasan_mem_to_shadow(addr);
-	const void *first_bad_addr = addr;
+	void *p = addr;
 
-	while (!shadow_val && first_bad_addr < addr + size) {
-		first_bad_addr += KASAN_SHADOW_SCALE_SIZE;
-		shadow_val = *(u8 *)kasan_mem_to_shadow(first_bad_addr);
-	}
-	return first_bad_addr;
+	while (p < addr + size && !(*(u8 *)kasan_mem_to_shadow(p)))
+		p += KASAN_SHADOW_SCALE_SIZE;
+	return p;
 }
 
 static const char *get_shadow_bug_type(struct kasan_access_info *info)
@@ -50,9 +47,6 @@ static const char *get_shadow_bug_type(struct kasan_access_info *info)
 	const char *bug_type = "unknown-crash";
 	u8 *shadow_addr;
 
-	info->first_bad_addr = find_first_bad_addr(info->access_addr,
-						info->access_size);
-
 	shadow_addr = (u8 *)kasan_mem_to_shadow(info->first_bad_addr);
 
 	/*
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 33cc3b0e017e..82a23b23ff93 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -119,6 +119,7 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value);
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
+void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
 void kasan_report(unsigned long addr, size_t size,
@@ -139,10 +140,14 @@ static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
+void print_tags(u8 addr_tag, const void *addr);
+
 u8 random_tag(void);
 
 #else
 
+static inline void print_tags(u8 addr_tag, const void *addr) { }
+
 static inline u8 random_tag(void)
 {
 	return 0;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 64a74f334c45..214d85035f99 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -64,11 +64,10 @@ static int __init kasan_set_multi_shot(char *str)
 }
 __setup("kasan_multi_shot", kasan_set_multi_shot);
 
-static void print_error_description(struct kasan_access_info *info,
-					const char *bug_type)
+static void print_error_description(struct kasan_access_info *info)
 {
 	pr_err("BUG: KASAN: %s in %pS\n",
-		bug_type, (void *)info->ip);
+		get_bug_type(info), (void *)info->ip);
 	pr_err("%s of size %zu at addr %px by task %s/%d\n",
 		info->is_write ? "Write" : "Read", info->access_size,
 		info->access_addr, current->comm, task_pid_nr(current));
@@ -272,6 +271,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 
 	start_report(&flags);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
+	print_tags(get_tag(object), reset_tag(object));
+	object = reset_tag(object);
 	pr_err("\n");
 	print_address_description(object);
 	pr_err("\n");
@@ -279,41 +280,45 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags);
 }
 
-static void kasan_report_error(struct kasan_access_info *info)
-{
-	unsigned long flags;
-
-	start_report(&flags);
-
-	print_error_description(info, get_bug_type(info));
-	pr_err("\n");
-
-	if (!addr_has_shadow(info->access_addr)) {
-		dump_stack();
-	} else {
-		print_address_description((void *)info->access_addr);
-		pr_err("\n");
-		print_shadow_for_address(info->first_bad_addr);
-	}
-
-	end_report(&flags);
-}
-
 void kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip)
 {
 	struct kasan_access_info info;
+	void *tagged_addr;
+	void *untagged_addr;
+	unsigned long flags;
 
 	if (likely(!report_enabled()))
 		return;
 
 	disable_trace_on_warning();
 
-	info.access_addr = (void *)addr;
-	info.first_bad_addr = (void *)addr;
+	tagged_addr = (void *)addr;
+	untagged_addr = reset_tag(tagged_addr);
+
+	info.access_addr = tagged_addr;
+	if (addr_has_shadow(untagged_addr))
+		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
+	else
+		info.first_bad_addr = untagged_addr;
 	info.access_size = size;
 	info.is_write = is_write;
 	info.ip = ip;
 
-	kasan_report_error(&info);
+	start_report(&flags);
+
+	print_error_description(&info);
+	if (addr_has_shadow(untagged_addr))
+		print_tags(get_tag(tagged_addr), info.first_bad_addr);
+	pr_err("\n");
+
+	if (addr_has_shadow(untagged_addr)) {
+		print_address_description(untagged_addr);
+		pr_err("\n");
+		print_shadow_for_address(info.first_bad_addr);
+	} else {
+		dump_stack();
+	}
+
+	end_report(&flags);
 }
diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index 8af15e87d3bc..573c51d20d09 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -37,3 +37,21 @@ const char *get_bug_type(struct kasan_access_info *info)
 {
 	return "invalid-access";
 }
+
+void *find_first_bad_addr(void *addr, size_t size)
+{
+	u8 tag = get_tag(addr);
+	void *p = reset_tag(addr);
+	void *end = p + size;
+
+	while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
+		p += KASAN_SHADOW_SCALE_SIZE;
+	return p;
+}
+
+void print_tags(u8 addr_tag, const void *addr)
+{
+	u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
+
+	pr_err("Pointer tag: [%02x], memory tag: [%02x]\n", addr_tag, *shadow);
+}
-- 
2.20.0.rc1.387.gf8505762e3-goog

