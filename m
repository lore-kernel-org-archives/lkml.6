Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0AC18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEF020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4je6NC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEF020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJPTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:53:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46337 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeJPTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:53:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so10915879plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sZDIV1NyVltEK8s0PDVsIndD6hMHsfubVOLkA0mdug=;
        b=B4je6NC7CmpnM4TBRDdpTr+YyNZAZgfWrzBnDA/fFr7jXR585YZUbGc398rNn9U2wZ
         D5Yc4KS84GjZcsCXDE2hHqmzA7IpnKWImfHyKFXv+n13ufgy6oz1uh76IQoghJfEi/B3
         kUlpjdf7lHX/G/dYMISH4rZs5NtRE0+gAxA/oSUNdcFtQSPYz4f0zonDUgJS1oYZor9W
         9FUetKSf0J2tTTxk7iZYC1E0aX7aTuvAkfEclXyN3G5EfdDfi2Zz4wYd4ugWjfFBkfNP
         GpWGQtGoCviEIuH5JknjQKu7zWj34804qz0kMxweG4kSrnUkHvgfVNJpSpfYIbbb8VU3
         zA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sZDIV1NyVltEK8s0PDVsIndD6hMHsfubVOLkA0mdug=;
        b=oZQ8P1/6a0DDe/2JhJdr3ZNeK1aHj9Dwvl28GuEHE4zZP8RH6y8Iak3FgfBWEQvjOp
         TNZQhL0SR3psYPMGL5+v40aE7CtA0jcPsENky+/fSO2jqcTtS7JsrUkaAXE8XssBqjEe
         O0j99lDlmuSvRvqtVcrspJ8GhOGE858Tx3kxGIMOG9X/ucqYpSf8SyxfPhUUu+BBOpEB
         gFmBSviWZRi81aON7JFDVAPc9+6vwXKOqzw7ZsGbEGBIqYMaaFeCFGv6h3YBfztSMIli
         L42RaXTdyOWQNJ06tQ6qDWIywDvYgL3n9yCRUEVLHSZQxJS5hV3Ayzy1+JbyF4pdAnnL
         YgNg==
X-Gm-Message-State: ABuFfoin+rjKFU2aqiz5JoEwka+FpR/nStLpmWLWrhROCU+QxZ8sjW0R
        o6cPxuZNj+v9vOxq6A2lb4Y=
X-Google-Smtp-Source: ACcGV610n433XXIjQBgmZahV8cccj4ByuS0E5tX6G8Yy7oPXdilEaMznXI76AX9SkqmtByatv1xCjw==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10-v6mr20645480pls.245.1539691418080;
        Tue, 16 Oct 2018 05:03:38 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id u21-v6sm23028375pfa.176.2018.10.16.05.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 05:03:37 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 2/3] staging: gasket: remove debug logs in page table mapping calls
Date:   Tue, 16 Oct 2018 05:03:08 -0700
Message-Id: <20181016120309.9082-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181016120309.9082-1-toddpoynor@gmail.com>
References: <20181016120309.9082-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove very noisy debug logs that also contain typos and incorrect
output formats.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 24 ----------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 5b398b7ba81d3..b7d460cf15fbc 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -477,7 +477,6 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 	for (i = 0; i < num_pages; i++) {
 		page_addr = host_addr + i * PAGE_SIZE;
 		offset = page_addr & (PAGE_SIZE - 1);
-		dev_dbg(pg_tbl->device, "%s i %d\n", __func__, i);
 		if (is_coherent(pg_tbl, host_addr)) {
 			u64 off =
 				(u64)host_addr -
@@ -506,22 +505,9 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 			ptes[i].dma_addr =
 				dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
 					     DMA_BIDIRECTIONAL);
-			dev_dbg(pg_tbl->device,
-				"%s i %d pte %p pfn %p -> mapped %llx\n",
-				__func__, i, &ptes[i],
-				(void *)page_to_pfn(page),
-				(unsigned long long)ptes[i].dma_addr);
 
 			if (dma_mapping_error(pg_tbl->device,
 					      ptes[i].dma_addr)) {
-				dev_dbg(pg_tbl->device,
-					"%s i %d -> fail to map page %llx "
-					"[pfn %p ohys %p]\n",
-					__func__, i,
-					(unsigned long long)ptes[i].dma_addr,
-					(void *)page_to_pfn(page),
-					(void *)page_to_phys(page));
-
 				if (gasket_release_page(ptes[i].page))
 					--pg_tbl->num_active_pages;
 
@@ -892,11 +878,6 @@ static int gasket_alloc_extended_subtable(struct gasket_page_table *pg_tbl,
 	pte->dma_addr = dma_map_page(pg_tbl->device, pte->page, 0, PAGE_SIZE,
 				     DMA_TO_DEVICE);
 	if (dma_mapping_error(pg_tbl->device, pte->dma_addr)) {
-		dev_dbg(pg_tbl->device,
-			"%s: fail to map page [pfn %lx phys %llx]\n",
-			__func__, page_to_pfn(pte->page),
-			page_to_phys(pte->page));
-
 		free_page(page_addr);
 		vfree(pte->sublevel);
 		memset(pte, 0, sizeof(struct gasket_page_table_entry));
@@ -1050,11 +1031,6 @@ int gasket_page_table_map(struct gasket_page_table *pg_tbl, ulong host_addr,
 	}
 
 	mutex_unlock(&pg_tbl->mutex);
-
-	dev_dbg(pg_tbl->device,
-		"%s done: ha %llx daddr %llx num %d, ret %d\n",
-		__func__, (unsigned long long)host_addr,
-		(unsigned long long)dev_addr, num_pages, ret);
 	return ret;
 }
 EXPORT_SYMBOL(gasket_page_table_map);
-- 
2.19.1.331.ge82ca0e54c-goog

