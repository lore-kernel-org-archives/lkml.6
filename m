Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B7C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120812098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="sYnIKpWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120812098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJSE0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:26:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34387 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeJSE0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:26:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id p6-v6so19699522qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rRSaxONrZWxSfcObSyXaZynV5IrpMUJ0BUHUIDN5YaE=;
        b=sYnIKpWZb0ethNv7ygrSHuJM9bQ6yfODonTwuNpvn0aI3FJoNvgjPlgWfQoMmpR9gd
         7KRCq4lfipETSrHqyEqxuaddeM6zru6h3oAj8UJ5ykK1EBWDbIiAodZcibkyhUoAeBGy
         rD+gE3mR4nq06NrFz1vZrWP4WHOoRZjdK/HfW9puyW+5LilQXWGBL+cwUrZMBQBx5Dmb
         TaT/v+QFKp3TUaOn357uQhnB8TbIpUsCjB7mfJY97nZyBVWA317u1+V2sumi31QG+D3Q
         gNSmWotTbFD1mmUwlAeAibeuaiBJgKswHrw7ri/QJqkOO2D1moAu7/MGP0weNtMfSGzd
         YYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rRSaxONrZWxSfcObSyXaZynV5IrpMUJ0BUHUIDN5YaE=;
        b=UrGiBGcf358fkbF2bt7Xh+yQvyxV//XzHWO/eVdyvAAsyVotlr+Gvvt6VEOujEl1Fw
         GLMlQNa6HR1krcU/8ogLFlfS2MubHV/Zmt4Yxs7AbbSddSRF/cp3chs0LUk2gHVUOb37
         vLKfz8OdvRnuXDOPAmkl5eEg5ceM5pHE2Sw97IY7nmxgYrVkZaLX67/Rpsthee73il/b
         EuVCN6ah6nP2uya7JeuAPXNF5sYuu+/UxHSL87/h+3llXZGJujrIjyB4W2ccnvqQnBKX
         E4+3bcPi6y0IcoggqR4jqZUwp5Bf1CpKnSXE2Z6mz80ybQwp86WC/GV6nYsiCr10GsJx
         zuvA==
X-Gm-Message-State: ABuFfohkPHFgBj1OXYb0NM8TqwCIiS+aNotGplx9XWUh9ZW5xtfubgxH
        3vcii+JmTbMCuG610kmzwUdGSW1jcIQeug==
X-Google-Smtp-Source: ACcGV62G7ya4wMwJkdmFy96WMrqdf+XZFz2cKbWI2in4JRemu28Kc13+O7n5qHte247QRx/a8tgXUA==
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr30144112qkb.326.1539894216216;
        Thu, 18 Oct 2018 13:23:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a13-v6sm13703972qkg.94.2018.10.18.13.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:23:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, riel@fb.com, linux-mm@kvack.org
Subject: [PATCH 5/7] mm: add a flag to indicate we used a cached page
Date:   Thu, 18 Oct 2018 16:23:16 -0400
Message-Id: <20181018202318.9131-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181018202318.9131-1-josef@toxicpanda.com>
References: <20181018202318.9131-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for dropping the mmap_sem in page_mkwrite.  We need
to know if we used our cached page so we can be sure it is the page we
already did the page_mkwrite stuff on so we don't have to redo all of
that work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/mm.h | 6 +++++-
 mm/filemap.c       | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4a84ec976dfc..a7305d193c71 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -318,6 +318,9 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
 #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
 #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
+#define FAULT_FLAG_USED_CACHED	0x200	/* Our vmf->page was from a previous
+					 * loop through the fault handler.
+					 */
 
 #define FAULT_FLAG_TRACE \
 	{ FAULT_FLAG_WRITE,		"WRITE" }, \
@@ -328,7 +331,8 @@ extern pgprot_t protection_map[16];
 	{ FAULT_FLAG_TRIED,		"TRIED" }, \
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
-	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }
+	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
+	{ FAULT_FLAG_USED_CACHED,	"USED_CACHED" }
 
 /*
  * vm_fault is filled by the the pagefault handler and passed to the vma's
diff --git a/mm/filemap.c b/mm/filemap.c
index 5212ab637832..e9cb44bd35aa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (cached_page->mapping == mapping &&
 		    cached_page->index == offset) {
 			page = cached_page;
+			vmf->flags |= FAULT_FLAG_USED_CACHED;
 			goto have_cached_page;
 		}
 		unlock_page(cached_page);
@@ -2619,8 +2620,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * We have a locked page in the page cache, now we need to check
 	 * that it's up-to-date. If not, it is going to be due to an error.
 	 */
-	if (unlikely(!PageUptodate(page)))
+	if (unlikely(!PageUptodate(page))) {
+		vmf->flags &= ~(FAULT_FLAG_USED_CACHED);
 		goto page_not_uptodate;
+	}
 
 	/*
 	 * Found the page and have a reference on it.
-- 
2.14.3

