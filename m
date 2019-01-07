Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0EBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32152085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HycEyN4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfAGIZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:25:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44611 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfAGIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:25:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so20530656plt.11;
        Mon, 07 Jan 2019 00:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XEcHGqwJUzmIUf41a2Xhm7NS5w/C+pCtuhu5Vfcqy0c=;
        b=HycEyN4mfQxc/g6ZGBKoZqlxDYOY5rWjUoSkylHj4SQWkSYMlwd1kDM+4hQ3ECd+PD
         FMw6rkgMg9cVxF0oVTCEcEqRkwwm9E0yXj4K5RT5QLj8JZJQ4Z+V8ukYtfT8LHPrF0Jy
         jYPj46stu6KwWLG0Pv3fvWYvKWxGeEEJZU25j8/GR4KDHpTP8dWW7n9xxDKCulnQqHIC
         CxYakeifGAb9Ny6GeHuGoEkcU6ToHEU7mK7cf1d8WthmjUijulZSzWYLg18qaQ7pYFKD
         DmscauZKSYHFssNwmLCfFcNO5nDF0Uwu/pPa9xE8mcspYOMGjbU9oe/4BF2WLOt5Zk9i
         kWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XEcHGqwJUzmIUf41a2Xhm7NS5w/C+pCtuhu5Vfcqy0c=;
        b=Q+uObXL/asTwYeXQFF5LtceHjut/M2oNWOS/bSbuhSJIzm9mXe55owT4rwrTAmdi6L
         3zVo3T8ZLSzZtn7cgdU8srHPhRN8GV3YsKxi4LhbpYoYT15N14LReWQjsVhquT+aatVK
         dWZ1RDBQEq5nWpFZm+Lmj3pQsgVqjX+u5lGxjdzXO8fkLIu82SQ20HI806DCpaQF04OB
         nzvWL44T4iL9APf/bNfGMA78IszucUtTdWvlGsTMu4TeKSP+MxURprCgqTk+f1fTg9lK
         E5A675190hxBJp4WHFwC6cdaxFlwbSMgs/2Mpeqao89UB8gXToiLfOR5sIfhlqdzYCn+
         xddg==
X-Gm-Message-State: AJcUukfFiZ1oKazfJMGtEHI/3Pl3B638B0YNKnt4pDQhOpqX58mKoSUB
        P/n4uWocS38vj0HTiIQVAA==
X-Google-Smtp-Source: ALg8bN6xujw9nynaeL0WMdSbG+tGXtEMbf/2bMmD2jVaRCLKukupvvFjcyLNoo68VErLkP3Ygqksvw==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr58273451pla.272.1546849511296;
        Mon, 07 Jan 2019 00:25:11 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm76981674pgv.31.2019.01.07.00.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:25:10 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-acpi@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] x86/mm: set allowed range for memblock allocator
Date:   Mon,  7 Jan 2019 16:24:44 +0800
Message-Id: <1546849485-27933-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the incoming divergence of x86_32 and x86_64, there is requirement
to set the allowed allocating range at the early boot stage.
This patch also includes minor change to remove redundat cond check, refer
to memblock_find_in_range_node(), memblock_find_in_range() has already
protect itself from the case: start > end.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/mm/init.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f905a23..84baa66 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -76,6 +76,14 @@ static unsigned long min_pfn_mapped;
 
 static bool __initdata can_use_brk_pgt = true;
 
+static unsigned long min_pfn_allowed;
+static unsigned long max_pfn_allowed;
+void set_alloc_range(unsigned long low, unsigned long high)
+{
+	min_pfn_allowed = low;
+	max_pfn_allowed = high;
+}
+
 /*
  * Pages returned are already directly mapped.
  *
@@ -100,12 +108,10 @@ __ref void *alloc_low_pages(unsigned int num)
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
 		unsigned long ret = 0;
 
-		if (min_pfn_mapped < max_pfn_mapped) {
-			ret = memblock_find_in_range(
-					min_pfn_mapped << PAGE_SHIFT,
-					max_pfn_mapped << PAGE_SHIFT,
-					PAGE_SIZE * num , PAGE_SIZE);
-		}
+		ret = memblock_find_in_range(
+			min_pfn_allowed << PAGE_SHIFT,
+			max_pfn_allowed << PAGE_SHIFT,
+			PAGE_SIZE * num, PAGE_SIZE);
 		if (ret)
 			memblock_reserve(ret, PAGE_SIZE * num);
 		else if (can_use_brk_pgt)
@@ -588,14 +594,17 @@ static void __init memory_map_top_down(unsigned long map_start,
 			start = map_start;
 		mapped_ram_size += init_range_memory_mapping(start,
 							last_start);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
 		last_start = start;
 		min_pfn_mapped = last_start >> PAGE_SHIFT;
 		if (mapped_ram_size >= step_size)
 			step_size = get_new_step_size(step_size);
 	}
 
-	if (real_end < map_end)
+	if (real_end < map_end) {
 		init_range_memory_mapping(real_end, map_end);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+	}
 }
 
 /**
@@ -636,6 +645,7 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 		}
 
 		mapped_ram_size += init_range_memory_mapping(start, next);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
 		start = next;
 
 		if (mapped_ram_size >= step_size)
-- 
2.7.4

