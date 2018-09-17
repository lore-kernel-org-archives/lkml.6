Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663BDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2E2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFmy9pQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B2E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeIQSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:07:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeIQSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:07:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so7626801pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=loSaWB381XgE4uLk+3G4GUZ75fHWlIRVMv/kqqZi9NY=;
        b=TFmy9pQhHESJZxnt2AXjM30KzgxoaUBEN5ffLsua9tUX/SNckh0htroSDNECSlGImx
         P8nd2Oa3aVvC/93FraiZm8rKPD4ZgrG3uzdpqWoUU3EbxBVlwITDoG/jdQl6UJkPteIk
         vPPeKXMCNXrPHKIk/kjG44gUXkFVlobJUmBqb16oES+Wz+nnNWCFnMR8uM6JRzcFJI+Q
         7JjhUxVyagIn5S1ktZ4dta5AGB4KbhDQSVY2G8L10a9Jh53/uEcAl6CvlacwM0zVqMUd
         7dupkeqMUNmowAVFJ4eGLb5QhlK0Pbs4s9N1zII5KGKFOyU/1Hnehg9t9ZYmr2j+Af1t
         SIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loSaWB381XgE4uLk+3G4GUZ75fHWlIRVMv/kqqZi9NY=;
        b=XgYGVsEQNvObUygEb+5oyhZ8c6lqemEr6AtSEBwEW8HO9MO8q6Y7ZDjFR2EmuH1xcN
         NEObuueSIeLqSiyDy9cd7zMfGh+lFxWPMMP5+m6j/cwvQwlJGzWsZ8l7TmMWHmIu12I5
         YuLZKL85dtPGMyBHbZXxcczuUGOtR2/HCmVP4NXE5wgG0j/xQDDlBd4X4YeJkYMGnKh3
         8y9D8dIFINg34RRTNZqAzszOK9Wv3DCUM8UGvbHI/FlIAaQP/16OfxSvM1oSyy7q+LKy
         d1e7XQcFmsWuO38Xrzx5XxZM/+R88Lb7yEs7e6B2DY9HKoBaK1MJXaW4bwmXL7JXhEiB
         0WmQ==
X-Gm-Message-State: APzg51BZ4XoULNhah7YHP03b0V1mdweSBA3S+xQg7AIDqR0R9nCnn7u8
        mER2T6e1jlYUv1BNW4Zg5Jw=
X-Google-Smtp-Source: ANB0VdbTHxtm2JUauiMHqF4LL7fCaK15poBUmcRBTazeDbjawuanJ3HLGDKTzn9XE5qb0TCwFbFZTg==
X-Received: by 2002:a63:d613:: with SMTP id q19-v6mr23574760pgg.327.1537187994982;
        Mon, 17 Sep 2018 05:39:54 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:54 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/10] staging: gasket: page_table: handle failed dma_map_page
Date:   Mon, 17 Sep 2018 05:39:05 -0700
Message-Id: <20180917123905.213639-11-toddpoynor@gmail.com>
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

Handle dma_map_page failing in gasket_alloc_extended_subtable: free
memory, don't add invalid page table entry.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 8364b49f147c2..964146f0df526 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -902,6 +902,17 @@ static int gasket_alloc_extended_subtable(struct gasket_page_table *pg_tbl,
 	/* Map the page into DMA space. */
 	pte->dma_addr = dma_map_page(pg_tbl->device, pte->page, 0, PAGE_SIZE,
 				     DMA_TO_DEVICE);
+	if (dma_mapping_error(pg_tbl->device, pte->dma_addr)) {
+		dev_dbg(pg_tbl->device,
+			"%s: fail to map page [pfn %lx phys %llx]\n",
+			__func__, page_to_pfn(pte->page),
+			page_to_phys(pte->page));
+
+		free_page(page_addr);
+		vfree(pte->sublevel);
+		memset(pte, 0, sizeof(struct gasket_page_table_entry));
+		return -ENOMEM;
+	}
 
 	/* make the addresses available to the device */
 	dma_addr = (pte->dma_addr + pte->offset) | GASKET_VALID_SLOT_FLAG;
-- 
2.19.0.397.gdd90340f6a-goog

