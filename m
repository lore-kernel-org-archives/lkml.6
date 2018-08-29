Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC56AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2320858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sprGRxk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC2320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeH2PcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:32:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55508 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeH2PcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so4935899wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RptGi1N09kqi5nALd3Lw1kS3KWHrO9/wmh1vLWiCPsQ=;
        b=sprGRxk69Bgq2fEeJZYij7WuPS5dd42cNx8LOGTtKuHyxeGw9qNWBhl7CaazsAv2L8
         0Z5a+YfEPdFTzLPIEMD0qo3Onb3R87L1f883KaLzvddIJcQv8umtpkJKssdcauC6ACw/
         L2Q2LRhzqv+ozMgzDO81VYgZMrR0AQeQbFew/ywJAN8mDBTqbD+n6xgBHehW5wYdR8AX
         3TJ2uGALKi2Ff9a9/USYAZSCJWtp8SCmomSn8P5XwrObk8hFwmvXLbEkrjX3O0GIfLyL
         Q989jfOQUiPJoa45r149PVVlaqKZtoDfLMB5LI0YyIsYbrKIphQZgUdF1iq5rf0z9kKm
         ZgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RptGi1N09kqi5nALd3Lw1kS3KWHrO9/wmh1vLWiCPsQ=;
        b=TuqaRdkREanlerht2BwawWbMiICwwr+KKDGB7y7ObbUV5g5LUuVVND67UFi6Cm99Uk
         z3CXUf2395nPon8j4kQmcfNClAj/2lE+IQ8Ps1YYROMO0UBt8l+dN04ZQYe2PjUYjy8p
         QlfJKjyVFXl/mlxMphLMsBVGTgidSQs4+3DAFZ+ikM2JwfOpX70WMaJV1phmhwip2SHs
         fNQjEb/efDF/wXxbUsItyKpcCOs6dl8+wpXcbqKUC2g500Gw2LFmNwSPyumJqnWBMnxf
         81LjCGUq6nPgjuc4a5+RRlSiXBq7GgU0IJ2hfMfxLWyuPR1/z8y9/SEYCrK0wwwxJSzp
         IX9g==
X-Gm-Message-State: APzg51DatwGwcNVc7oiGcyh/IbZtxM23QucE7k338GrDo1mkkYmdleDk
        pcUbbwdJTqpQh+adppzXnoYgjQ==
X-Google-Smtp-Source: ANB0VdapbVuh8UM8tmw1fbsxfHLxbzYLXGvQJN/t9MYIn48sIEE2gDAiYdQOxGPzZ6wTAybzKarjqw==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr3789441wmd.18.1535542548680;
        Wed, 29 Aug 2018 04:35:48 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:47 -0700 (PDT)
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
Subject: [PATCH v6 13/18] khwasan: add bug reporting routines
Date:   Wed, 29 Aug 2018 13:35:17 +0200
Message-Id: <f39cdef4fde40b6d2ef356db3e0126bda0e1e8c7.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 1f852244e739..4424359a9dfa 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -174,6 +174,9 @@ void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr);
 void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx,
 					const void *addr);
 
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
2.19.0.rc0.228.g281dcd1b4d0-goog

