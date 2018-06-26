Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C4726AF9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvQju4Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C4726AF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935611AbeFZNQG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:16:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54029 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935541AbeFZNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:15:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so1883247wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x7LgSHU71ZgD9Kw/P3WyW4fTO0KGuI1+HIz2YOw8Y6c=;
        b=PvQju4EoC02gWNWypHB1WVME32+6VN3JOj6cEONl0f/gm4TOUdhuUBFEMtev/HqM7G
         zGP3FXESuIask7f5/+J4+E5WyACgh7NJcC6/2iRh55jS0WIjNhCWIChj6MGHxtJndici
         7A+7WSNVGkVDvPFz1npDJYnUDAq8cTZotdngPB2mHqIDAXkSvChYguYfZ2oDYTNVyS1O
         Nihi6kyKUEXGEJ7rqsWz7VnbxVNhy4NCT5d7ox17ozgSsTHHKz4WEq6AM/ioy1Z6UMbv
         9Z6/7kN7LFXTk0UXXPOzfAB6l3eB2LkfMpfSqbUX97i4ODvPnv5HYvUoBn5ClhUOXTXo
         gbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x7LgSHU71ZgD9Kw/P3WyW4fTO0KGuI1+HIz2YOw8Y6c=;
        b=GSzQiUPIBhRIXHUjjjseJhMAD5QUj5TmtSOcWcRX3WqZicElaZTqqDlVA+F47UExgj
         ddCq4c0L9XsMTZhZPx1e4jm2X731XvJFcMGqG9FtE8iJ8GkD7NjAYDMbf6tFp0zurndt
         cCqUvJBQK+q/sDAzHdgeA/Q0QBEF944qlkBhzTtJh88NHSvJ5w5wslzCJWdAS5tk8D29
         430V1zem/rnUXz2pBLotvALLVcL1kYBEowjbmSU6uFsQafWGsbMWzW5WGmKMnUPPW9dC
         GkV6HzfeleUMLAZNE7txmiBX74lSPHjhGfxchw8zvmzBP6GY/cPxkE+wDuaGMam4Meu1
         UpZg==
X-Gm-Message-State: APt69E3127Xsdw9VQvVNEbKiHFb0S/10mVxw7wVCooEm22NkaIwkzmW8
        vtRg5fYKP40eCWoD7/OfZfMOKA==
X-Google-Smtp-Source: AAOMgpcCPD6tKB2C6xmWvogDyu4Ng1HIod306Ojol668U6f0tl3vpiAFXzfCzzP597968CyvfHdUzg==
X-Received: by 2002:a1c:29c5:: with SMTP id p188-v6mr1566476wmp.45.1530018955522;
        Tue, 26 Jun 2018 06:15:55 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id w15-v6sm2162639wrn.25.2018.06.26.06.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 06:15:54 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 12/17] khwasan: add bug reporting routines
Date:   Tue, 26 Jun 2018 15:15:22 +0200
Message-Id: <bcdb2974522e4664412d8d026ee1a31622467ba1.1530018818.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds rountines, that print KHWASAN error reports. Those are
quite similar to KASAN, the difference is:

1. The way KHWASAN finds the first bad shadow cell (with a mismatching
   tag). KHWASAN compares memory tags from the shadow memory to the pointer
   tag.

2. KHWASAN reports all bugs with the "KASAN: invalid-access" header. This
   is done, so various external tools that already parse the kernel logs
   looking for KASAN reports wouldn't need to be changed.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h     |  3 +++
 mm/kasan/kasan.h          |  7 +++++
 mm/kasan/kasan_report.c   |  7 ++---
 mm/kasan/khwasan_report.c | 21 +++++++++++++++
 mm/kasan/report.c         | 57 +++++++++++++++++++++------------------
 5 files changed, 64 insertions(+), 31 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d7624b879d86..e209027f3b52 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -161,6 +161,9 @@ void *khwasan_set_tag(const void *addr, u8 tag);
 u8 khwasan_get_tag(const void *addr);
 void *khwasan_reset_tag(const void *ptr);
 
+void kasan_report(unsigned long addr, size_t size,
+			bool write, unsigned long ip);
+
 #else /* CONFIG_KASAN_HW */
 
 static inline void khwasan_init(void) { }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 82672473740c..d60859d26be7 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -119,8 +119,15 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value);
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
+void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
+#ifdef CONFIG_KASAN_HW
+void print_tags(u8 addr_tag, const void *addr);
+#else
+static inline void print_tags(u8 addr_tag, const void *addr) { }
+#endif
+
 void kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
diff --git a/mm/kasan/kasan_report.c b/mm/kasan/kasan_report.c
index 2d8decbecbd5..fdf2d77e3125 100644
--- a/mm/kasan/kasan_report.c
+++ b/mm/kasan/kasan_report.c
@@ -33,10 +33,10 @@
 #include "kasan.h"
 #include "../slab.h"
 
-static const void *find_first_bad_addr(const void *addr, size_t size)
+void *find_first_bad_addr(void *addr, size_t size)
 {
 	u8 shadow_val = *(u8 *)kasan_mem_to_shadow(addr);
-	const void *first_bad_addr = addr;
+	void *first_bad_addr = addr;
 
 	while (!shadow_val && first_bad_addr < addr + size) {
 		first_bad_addr += KASAN_SHADOW_SCALE_SIZE;
@@ -50,9 +50,6 @@ static const char *get_shadow_bug_type(struct kasan_access_info *info)
 	const char *bug_type = "unknown-crash";
 	u8 *shadow_addr;
 
-	info->first_bad_addr = find_first_bad_addr(info->access_addr,
-						info->access_size);
-
 	shadow_addr = (u8 *)kasan_mem_to_shadow(info->first_bad_addr);
 
 	/*
diff --git a/mm/kasan/khwasan_report.c b/mm/kasan/khwasan_report.c
index 2edbc3c76be5..51238b404b08 100644
--- a/mm/kasan/khwasan_report.c
+++ b/mm/kasan/khwasan_report.c
@@ -37,3 +37,24 @@ const char *get_bug_type(struct kasan_access_info *info)
 {
 	return "invalid-access";
 }
+
+void *find_first_bad_addr(void *addr, size_t size)
+{
+	u8 tag = get_tag(addr);
+	void *untagged_addr = reset_tag(addr);
+	u8 *shadow = (u8 *)kasan_mem_to_shadow(untagged_addr);
+	void *first_bad_addr = untagged_addr;
+
+	while (*shadow == tag && first_bad_addr < untagged_addr + size) {
+		first_bad_addr += KASAN_SHADOW_SCALE_SIZE;
+		shadow = (u8 *)kasan_mem_to_shadow(first_bad_addr);
+	}
+	return first_bad_addr;
+}
+
+void print_tags(u8 addr_tag, const void *addr)
+{
+	u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
+
+	pr_err("Pointer tag: [%02x], memory tag: [%02x]\n", addr_tag, *shadow);
+}
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 155247a6f8a8..e031c78f2e52 100644
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
-- 
2.18.0.rc2.346.g013aa6912e-goog

