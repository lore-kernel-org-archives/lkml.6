Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D15BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFC52088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHZvRH8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFC52088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeIQSHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:07:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35307 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeIQSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:07:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so7619143pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvHC7e36zmVTHp3aDES3WiuYNM3yF2vxS7ZZngJBYu0=;
        b=JHZvRH8MvWMSvSOoF78R/hoXQx1lbGGtfr+HQgzbVxh4ZaC/9icjId43gOcGhCPDBu
         Q20mmUdhXA/TIcf5/06v6SwOC7rNnwtf2s5u4fECY1XPMUEBi+wLsLLlOvmtAcSK0KGl
         bp+i9zQofihPwdbGpUxB1cBjCssZr8Vw5detbaGvGzMcmgSN7CE0910OQKP0ybwsJ6+d
         0NiDUvkXeMoHuscxdNLauGC7MyzjFuc4BXxbQaHPLOW1ejOmrq1fVFA3B8P3vSIr0DbI
         vlQ/vGkaW5wbRbL7KGGaX2jdftB7FzleMQbYAWTQ91PO0fZZszsNaRYLD+xhn5A+z0g4
         ykIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvHC7e36zmVTHp3aDES3WiuYNM3yF2vxS7ZZngJBYu0=;
        b=ThO1hdUlX08p5Ki+Ps8EjLxrYkUihN6kB4ziWxEom8lte3MuFNQGx/COY/mBDAjp7z
         J9Ys5Ly5UmG4UB83I/6iylpBkbzNoHdReMplYNQ9HmWfAvdrQWkgPVS2jUnbgIqsItJ6
         u6J+p99R4G38VzfznG7iF+FRS141e7qhZjxXNAfRQBj44yYwvPR/SI2Su00ZeTRqQcHE
         4UPe4rtNXkCjfwdN05iqtUZHHGr67d8jKbMbcp+8tvmcr/IBcIBMLyFWByr6u4l2hywV
         bF9pe8B45B8toLNYEmcAq/buAGEAGViqMqxgV88KdwUNGXTJw5Wt0+YOZVLuqq0eokUb
         KkNg==
X-Gm-Message-State: APzg51D02MWLTVcX3cFez191XDNgVkEHG9Q9kZgDy8ceuVIAvfK9NWTp
        O+UQkKFUWT4Am3CTeRYnR1M=
X-Google-Smtp-Source: ANB0VdZ4M5bT8G9p++Czn9tAqzH9RR4+Sp59bzx0KwMojLoSjQlclV1lEcFXUcS4kbv6XPOrtdXjfQ==
X-Received: by 2002:a62:848e:: with SMTP id k136-v6mr25702881pfd.231.1537187992587;
        Mon, 17 Sep 2018 05:39:52 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:52 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/10] staging: gasket: cleanup if dma_map_page fails in gasket_perform_mapping
Date:   Mon, 17 Sep 2018 05:39:03 -0700
Message-Id: <20180917123905.213639-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Previously pages would have never been unmapped in this case.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 33 +++++++++++++---------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index c1ce8f984f8e0..779ad2f23ef9b 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -433,6 +433,19 @@ static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr)
 	return min <= host_addr && host_addr < max;
 }
 
+/* Safely return a page to the OS. */
+static bool gasket_release_page(struct page *page)
+{
+	if (!page)
+		return false;
+
+	if (!PageReserved(page))
+		SetPageDirty(page);
+	put_page(page);
+
+	return true;
+}
+
 /*
  * Get and map last level page table buffers.
  *
@@ -500,6 +513,13 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 					(unsigned long long)ptes[i].dma_addr,
 					(void *)page_to_pfn(page),
 					(void *)page_to_phys(page));
+
+				/* clean up */
+				if (gasket_release_page(ptes[i].page))
+					--pg_tbl->num_active_pages;
+
+				memset(&ptes[i], 0,
+				       sizeof(struct gasket_page_table_entry));
 				return -1;
 			}
 		}
@@ -571,19 +591,6 @@ static int gasket_alloc_simple_entries(struct gasket_page_table *pg_tbl,
 	return 0;
 }
 
-/* Safely return a page to the OS. */
-static bool gasket_release_page(struct page *page)
-{
-	if (!page)
-		return false;
-
-	if (!PageReserved(page))
-		SetPageDirty(page);
-	put_page(page);
-
-	return true;
-}
-
 /*
  * Unmap and release mapped pages.
  * The page table mutex must be held by the caller.
-- 
2.19.0.397.gdd90340f6a-goog

