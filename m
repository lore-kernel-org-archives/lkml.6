Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8656ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585CC208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H19dJEXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585CC208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbeGQCke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34250 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbeGQCkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so2178010plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tvVVX5GsFT6En6Ha6Ngkmd9agcqBVL0J4En55DMoe0s=;
        b=H19dJEXGezeVYGyh1l2/c/wSYoSHxxBFtsgtjOV53S4F3zr3w2VbXRw4LSuo55ab9R
         udfvmoK0TmtBcjBI39Q6VbOXpaEjCJZCdcWFrXO5Nr7OP09pCEAilgj7bquVthsRNW4v
         cZiBuhZjROYJ+G7hdSBJGWnyUbi0Au+TaV9VJNlYqkhq1XU6LwTrD5YvBzB6D9FY4NKh
         VdbJS5IXPVX0mfnPCtPWsWjiTML5BVkHXLAvKr1wPDXtcMUGyR4VJ/zwSREqikVHfU3R
         8MpYzX1n/Lq7g/ZUQU5fZwF95syCn5X5vgkyVasRiXkWLLXWJ/6rKOucQQk19gvw3uDn
         RJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tvVVX5GsFT6En6Ha6Ngkmd9agcqBVL0J4En55DMoe0s=;
        b=tKVJpNeESCt4w1axqrAC1N1XIdKTzQ+wDvK/JMT7Blmdsu5Kf91Q6RCC8q0anc29SZ
         lBgL1rMRqeZ4vJFhhVXHaXivqzgNM1o6I9kZhyWbojvSAmxj6vLGxqTnrsgjQeD1HiOY
         sBmgKsDNM+b5sfB1ObTqQxg0sF5KXn+y7XKeJONV3YHv7oWUJxTfu8UAsAB7FkNAuTct
         WWwUubX4XGgMIar+7fHFW/5sLMD9DsRc+1p0kjRnwHPmM9CSINjEACdy6avJvXCf0ZME
         Iqrj4dYGh1mm/SDuMnLt0EZvvitOnVLwZ4XZ3dqObtgyXn368RaRTJfTBbk+uYHfQfz9
         JJxA==
X-Gm-Message-State: AOUpUlF9h0g2wT4QyEj/W6JiqhDlyqZNwg6IN5By/B+t5LlZb+qkQH2c
        CNST0Jj18cWlhCn5U9RIapI=
X-Google-Smtp-Source: AAOMgpdvu5lOjH4U64+JmLO1+dR2/yOnGROb7vVXHtDVx/ec/Dj86ZiJ1K8IGrYgCqiEoJIpxQ7aVA==
X-Received: by 2002:a17:902:3303:: with SMTP id a3-v6mr18940759plc.209.1531793423451;
        Mon, 16 Jul 2018 19:10:23 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:22 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 26/32] staging: gasket: gasket page table functions use bool return type
Date:   Mon, 16 Jul 2018 19:09:20 -0700
Message-Id: <20180717020926.176408-27-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Convert from int to bool return type for gasket page table functions
that return values used as booleans.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 58 +++++++++++-----------
 drivers/staging/gasket/gasket_page_table.h |  8 +--
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 36a560c87af36..2a27db658a4e4 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -262,16 +262,16 @@ static void gasket_perform_unmapping(
 static void gasket_free_extended_subtable(
 	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
 	u64 __iomem *att_reg);
-static int gasket_release_page(struct page *page);
+static bool gasket_release_page(struct page *page);
 
 /* Other/utility declarations */
-static inline int gasket_addr_is_simple(
+static inline bool gasket_addr_is_simple(
 	struct gasket_page_table *pg_tbl, ulong addr);
-static int gasket_is_simple_dev_addr_bad(
+static bool gasket_is_simple_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static int gasket_is_extended_dev_addr_bad(
+static bool gasket_is_extended_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static int gasket_is_pte_range_free(
+static bool gasket_is_pte_range_free(
 	struct gasket_page_table_entry *pte, uint num_entries);
 static void gasket_page_table_garbage_collect_nolock(
 	struct gasket_page_table *pg_tbl);
@@ -558,7 +558,7 @@ int gasket_page_table_lookup_page(
 }
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_are_addrs_bad(
+bool gasket_page_table_are_addrs_bad(
 	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
 	ulong bytes)
 {
@@ -567,7 +567,7 @@ int gasket_page_table_are_addrs_bad(
 			pg_tbl,
 			"host mapping address 0x%lx must be page aligned",
 			host_addr);
-		return 1;
+		return true;
 	}
 
 	return gasket_page_table_is_dev_addr_bad(pg_tbl, dev_addr, bytes);
@@ -575,7 +575,7 @@ int gasket_page_table_are_addrs_bad(
 EXPORT_SYMBOL(gasket_page_table_are_addrs_bad);
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_is_dev_addr_bad(
+bool gasket_page_table_is_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, ulong bytes)
 {
 	uint num_pages = bytes / PAGE_SIZE;
@@ -584,7 +584,7 @@ int gasket_page_table_is_dev_addr_bad(
 		gasket_pg_tbl_error(
 			pg_tbl,
 			"mapping size 0x%lX must be page aligned", bytes);
-		return 1;
+		return true;
 	}
 
 	if (num_pages == 0) {
@@ -592,7 +592,7 @@ int gasket_page_table_is_dev_addr_bad(
 			pg_tbl,
 			"requested mapping is less than one page: %lu / %lu",
 			bytes, PAGE_SIZE);
-		return 1;
+		return true;
 	}
 
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
@@ -1285,23 +1285,23 @@ static void gasket_free_extended_subtable(
 /*
  * Safely return a page to the OS.
  * @page: The page to return to the OS.
- * Returns 1 if the page was released, 0 if it was
+ * Returns true if the page was released, false if it was
  * ignored.
  */
-static int gasket_release_page(struct page *page)
+static bool gasket_release_page(struct page *page)
 {
 	if (!page)
-		return 0;
+		return false;
 
 	if (!PageReserved(page))
 		SetPageDirty(page);
 	put_page(page);
 
-	return 1;
+	return true;
 }
 
 /* Evaluates to nonzero if the specified virtual address is simple. */
-static inline int gasket_addr_is_simple(
+static inline bool gasket_addr_is_simple(
 	struct gasket_page_table *pg_tbl, ulong addr)
 {
 	return !((addr) & (pg_tbl)->extended_flag);
@@ -1317,7 +1317,7 @@ static inline int gasket_addr_is_simple(
  * address to/from page + offset) and that the requested page range starts and
  * ends within the set of currently-partitioned simple pages.
  */
-static int gasket_is_simple_dev_addr_bad(
+static bool gasket_is_simple_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
 	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
@@ -1328,7 +1328,7 @@ static int gasket_is_simple_dev_addr_bad(
 		pg_tbl, 1, page_index, page_offset) != dev_addr) {
 		gasket_pg_tbl_error(
 			pg_tbl, "address is invalid, 0x%lX", dev_addr);
-		return 1;
+		return true;
 	}
 
 	if (page_index >= pg_tbl->num_simple_entries) {
@@ -1336,7 +1336,7 @@ static int gasket_is_simple_dev_addr_bad(
 			pg_tbl,
 			"starting slot at %lu is too large, max is < %u",
 			page_index, pg_tbl->num_simple_entries);
-		return 1;
+		return true;
 	}
 
 	if (page_index + num_pages > pg_tbl->num_simple_entries) {
@@ -1344,10 +1344,10 @@ static int gasket_is_simple_dev_addr_bad(
 			pg_tbl,
 			"ending slot at %lu is too large, max is <= %u",
 			page_index + num_pages, pg_tbl->num_simple_entries);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
@@ -1359,7 +1359,7 @@ static int gasket_is_simple_dev_addr_bad(
  * @dev_addr: The device address to which the pages will be mapped.
  * @num_pages: The number of second-level/sub pages in the range to consider.
  */
-static int gasket_is_extended_dev_addr_bad(
+static bool gasket_is_extended_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
 	/* Starting byte index of dev_addr into the first mapped page */
@@ -1373,7 +1373,7 @@ static int gasket_is_extended_dev_addr_bad(
 	if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
 		gasket_pg_tbl_error(pg_tbl, "device address out of bound, 0x%p",
 				    (void *)dev_addr);
-		return 1;
+		return true;
 	}
 
 	/* Find the starting sub-page index in the space of all sub-pages. */
@@ -1391,7 +1391,7 @@ static int gasket_is_extended_dev_addr_bad(
 		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
 		gasket_pg_tbl_error(
 			pg_tbl, "address is invalid, 0x%p", (void *)dev_addr);
-		return 1;
+		return true;
 	}
 
 	if (page_lvl0_idx >= pg_tbl->num_extended_entries) {
@@ -1399,7 +1399,7 @@ static int gasket_is_extended_dev_addr_bad(
 			pg_tbl,
 			"starting level 0 slot at %lu is too large, max is < "
 			"%u", page_lvl0_idx, pg_tbl->num_extended_entries);
-		return 1;
+		return true;
 	}
 
 	if (page_lvl0_idx + num_lvl0_pages > pg_tbl->num_extended_entries) {
@@ -1408,10 +1408,10 @@ static int gasket_is_extended_dev_addr_bad(
 			"ending level 0 slot at %lu is too large, max is <= %u",
 			page_lvl0_idx + num_lvl0_pages,
 			pg_tbl->num_extended_entries);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
@@ -1425,17 +1425,17 @@ static int gasket_is_extended_dev_addr_bad(
  *
  * The page table mutex must be held before this call.
  */
-static int gasket_is_pte_range_free(
+static bool gasket_is_pte_range_free(
 	struct gasket_page_table_entry *ptes, uint num_entries)
 {
 	int i;
 
 	for (i = 0; i < num_entries; i++) {
 		if (ptes[i].status != PTE_FREE)
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/drivers/staging/gasket/gasket_page_table.h b/drivers/staging/gasket/gasket_page_table.h
index 720ce2bc2c012..0e8afdb8c1139 100644
--- a/drivers/staging/gasket/gasket_page_table.h
+++ b/drivers/staging/gasket/gasket_page_table.h
@@ -162,9 +162,9 @@ int gasket_page_table_lookup_page(
  * specified by both addresses and the size are valid for mapping pages into
  * device memory.
  *
- * Returns 1 if true - if the mapping is bad, 0 otherwise.
+ * Returns true if the mapping is bad, false otherwise.
  */
-int gasket_page_table_are_addrs_bad(
+bool gasket_page_table_are_addrs_bad(
 	struct gasket_page_table *page_table, ulong host_addr, ulong dev_addr,
 	ulong bytes);
 
@@ -178,9 +178,9 @@ int gasket_page_table_are_addrs_bad(
  * specified by the device address and the size is valid for mapping pages into
  * device memory.
  *
- * Returns 1 if true - if the address is bad, 0 otherwise.
+ * Returns true if the address is bad, false otherwise.
  */
-int gasket_page_table_is_dev_addr_bad(
+bool gasket_page_table_is_dev_addr_bad(
 	struct gasket_page_table *page_table, ulong dev_addr, ulong bytes);
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog

