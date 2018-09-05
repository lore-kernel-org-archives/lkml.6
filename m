Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60452C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1200820659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdtLF/87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1200820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIFBp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:45:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42272 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFBp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:45:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so3872645plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FFB08YKorxcOMOwUtMi0I35BA7p13x7BDsSY6WAe3AI=;
        b=DdtLF/87vAOXPUTUfEcTfx2b2IglcVvadCSny53Kc9sSV52xzfZh0E+ZHHet2VuAqK
         hP5R+XpigMxTmZsuYyarck55nfJJZEWKH3RqqKxto0fpnqyUJtOguCSX9btcwVNQlqoq
         7Y444rlBrdR+4RVH9ifTCKwhQW0vgF7hdyJyNHdIH6WqXodrU5iYjbczT8eTPLytqkrA
         /NBjL+UL07iobWxnD/zTXafppmH/jQCYD0mwOAI6nUTARE3tbH+OHEq+WJK218M9NcaA
         IE3RsLwpzsTRoVH9N5YTV6L36tvbbEqVTiJOFZIGRoZ4l2Gv7u8I5XYM8069fIhYK4gS
         IE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FFB08YKorxcOMOwUtMi0I35BA7p13x7BDsSY6WAe3AI=;
        b=WuQxYveqhMbqYPHoTTBkGiGW6tAVpY0Rg0ExMHrEufSuAfpaOVb4uvw60e1uUL+zzs
         MTMp+YoRjuv7uI1hO0AkrHVsaP4u4F2Dxrgxkhy+C0Ci25xgllDXDu3B1c79X+VqxKfM
         wrrwneLfIpF8jb2IVhj5HetWCgb5Lxt+qKl/1Mgz/Fdu16k2WdghycCby3K86sUf/3QZ
         5+BYCEwoFsBbVTHVi8/KB+jJQXZ675EAin16/8506QySqzu/OLOAMzh7H96MLrZCufKl
         kj6tpHmvD4xEDOj+/Ekz5V3sYLXa0yhIpNF2wnSDe6FsWhD6maRt75rmR291oJRZpOko
         rCeA==
X-Gm-Message-State: APzg51Ab9AIdtuL6sR6Dq/pOixXvBjqxqBsuThfPElR36lv2YEy4Q/a8
        AOFSdl6RLDwWbH1gZj5Hadg=
X-Google-Smtp-Source: ANB0VdaP0uEFD0vUxKoZqr+MtSqk6mL/WLLyi+Nu7jfIFrinCMKXFzFyLQVGINzRzAMYlimlflyoiA==
X-Received: by 2002:a17:902:598d:: with SMTP id p13-v6mr18229562pli.171.1536182009350;
        Wed, 05 Sep 2018 14:13:29 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id 74-v6sm4307213pfv.33.2018.09.05.14.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:13:28 -0700 (PDT)
Subject: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        mhocko@suse.com, dave.hansen@intel.com, akpm@linux-foundation.org,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Wed, 05 Sep 2018 14:13:28 -0700
Message-ID: <20180905211328.3286.71674.stgit@localhost.localdomain>
In-Reply-To: <20180905211041.3286.19083.stgit@localhost.localdomain>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

On systems with a large amount of memory it can take a significant amount
of time to initialize all of the page structs with the PAGE_POISON_PATTERN
value. I have seen it take over 2 minutes to initialize a system with
over 12GB of RAM.

In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
the boot time returned to something much more reasonable as the
arch_add_memory call completed in milliseconds versus seconds. However in
doing that I had to disable all of the other VM debugging on the system.

Instead of keeping the value in CONFIG_DEBUG_VM I am adding a new CONFIG
value called CONFIG_DEBUG_VM_PAGE_INIT_POISON that will control the page
poisoning independent of the CONFIG_DEBUG_VM option.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/page-flags.h |    8 ++++++++
 lib/Kconfig.debug          |   14 ++++++++++++++
 mm/memblock.c              |    5 ++---
 mm/sparse.c                |    4 +---
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 74bee8cecf4c..0e95ca63375a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -13,6 +13,7 @@
 #include <linux/mm_types.h>
 #include <generated/bounds.h>
 #endif /* !__GENERATING_BOUNDS_H */
+#include <linux/string.h>
 
 /*
  * Various page->flags bits:
@@ -162,6 +163,13 @@ static inline int PagePoisoned(const struct page *page)
 	return page->flags == PAGE_POISON_PATTERN;
 }
 
+static inline void page_init_poison(struct page *page, size_t size)
+{
+#ifdef CONFIG_DEBUG_VM_PAGE_INIT_POISON
+	memset(page, PAGE_POISON_PATTERN, size);
+#endif
+}
+
 /*
  * Page flags policies wrt compound pages
  *
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 613316724c6a..3b1277c52fed 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -637,6 +637,20 @@ config DEBUG_VM_PGFLAGS
 
 	  If unsure, say N.
 
+config DEBUG_VM_PAGE_INIT_POISON
+	bool "Enable early page metadata poisoning"
+	default y
+	depends on DEBUG_VM
+	help
+	  Seed the page metadata with a poison pattern to improve the
+	  likelihood of detecting attempts to access the page prior to
+	  initialization by the memory subsystem.
+
+	  This initialization can result in a longer boot time for systems
+	  with a large amount of memory.
+
+	  If unsure, say Y.
+
 config ARCH_HAS_DEBUG_VIRTUAL
 	bool
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 237944479d25..a85315083b5a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1444,10 +1444,9 @@ void * __init memblock_virt_alloc_try_nid_raw(
 
 	ptr = memblock_virt_alloc_internal(size, align,
 					   min_addr, max_addr, nid);
-#ifdef CONFIG_DEBUG_VM
 	if (ptr && size > 0)
-		memset(ptr, PAGE_POISON_PATTERN, size);
-#endif
+		page_init_poison(ptr, size);
+
 	return ptr;
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..67ad061f7fb8 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -696,13 +696,11 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-#ifdef CONFIG_DEBUG_VM
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
-#endif
+	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
 
 	section_mark_present(ms);
 	sparse_init_one_section(ms, section_nr, memmap, usemap);

