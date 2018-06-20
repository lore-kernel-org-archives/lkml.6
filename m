Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5AEC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3DF20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQRKE0lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DF20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933288AbeFTRFl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:05:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37844 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933023AbeFTRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:05:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6-v6so272609wrp.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=c6sg1pKbiamx1XH13eqUpJsk3Y/yqaW2Qn4AoCG4i2U=;
        b=bQRKE0lSkokJsasZo4WjpZs6inPu0U1MibESqbeDz2cyBSgcevBOMZy0nsy3bAdQCc
         V7Kj3Fxr1WS28aeZI/gh4ZyE68+CCJ/7dpxL4OEnhCGQPtdkGiPKmg+aueXtapB4c4WP
         mOg55K56bwgVqzS2bOVuuLbtfnJPCnfi5IcuUv1qQnCSkbkV4PfbWIqZWV4oMrzDQnr0
         PhPEQUz2/Bv71xaWFJEYHr0BYlrtCkazw8tO2VSh0zXWw7DKKNaX0Z5kOAuSqBelJfJe
         HNDBmqv+q6mpKtCZWdw0KxNVvFRROVSUWg4UmBX/rmlWVl87Zs7Q2TxvIAYc7vHviSWq
         vkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c6sg1pKbiamx1XH13eqUpJsk3Y/yqaW2Qn4AoCG4i2U=;
        b=JUGSCupuhpNemklbo17S7XQ9r+uSUXY2jwmRCmbQ1GSFjZ/QsOv7qszKG0cw2pWPiQ
         MvojpHlpBFErCfcj00BalupxoUx+xTj3Yzlzwcz7s15RVDnN2ocN72MHqU0idn+IGTOD
         kCShCp2Mlq+Xm1duIUYy5ie3Lb3cSNHXJiPFIUCA/AOY829TQc5NUWIj8E77Gsl1len9
         +LkfbBcJ2oTd6171ywdHe/HbsTFDIHQ62XDdoroPoCEvzDqktSraiN4Fl5h6Q8QVyX3X
         QBdTiuAA+zLHuY1fe87K7a8ZwmtL6CIm/QLfOwkiUyp0ZAwJxCtSK5qHWlOnEhwSd6r4
         VwGA==
X-Gm-Message-State: APt69E2UKZ75xOZrbdjvsHGLi3tLGmll3kdmBOE4cwFNu9aaPdAFQYBh
        46RMSENAmRfbOtE8qWLq+w==
X-Google-Smtp-Source: ADUXVKIkROr42wlQjq2Uzg5RjXkrUXJu/HGHk0aWQSEqTjOa1hbzwW8WIAeNw2eYSzZnjhZqbN4U3w==
X-Received: by 2002:adf:e987:: with SMTP id h7-v6mr18241425wrm.102.1529514336356;
        Wed, 20 Jun 2018 10:05:36 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id c11-v6sm4242710wrm.65.2018.06.20.10.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:05:35 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:05:24 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     xdeguillard@vmware.com, moltmann@vmware.com, pv-drivers@vmware.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/misc: SPDX-licensing
Message-ID: <20180620170524.GA18126@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attach SPDX license header. Concatinate int on unsigned
Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/misc/vmw_balloon.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9047c0a..762429d 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * VMware Balloon driver.
  *
@@ -247,7 +248,7 @@ struct vmballoon_stats {
 	unsigned int doorbell_unset;
 };
 
-#define STATS_INC(stat) (stat)++
+#define STATS_INC(stat) ((stat)++)
 #else
 #define STATS_INC(stat)
 #endif
@@ -275,7 +276,7 @@ struct vmballoon {
 	struct vmballoon_page_size page_sizes[VMW_BALLOON_NUM_PAGE_SIZES];
 
 	/* supported page sizes. 1 == 4k pages only, 2 == 4k and 2m pages */
-	unsigned supported_page_sizes;
+	unsigned int supported_page_sizes;
 
 	/* balloon size in pages */
 	unsigned int size;
@@ -559,7 +560,7 @@ static void vmballoon_free_page(struct page *page, bool is_2m_page)
 static void vmballoon_pop(struct vmballoon *b)
 {
 	struct page *page, *next;
-	unsigned is_2m_pages;
+	unsigned int is_2m_pages;
 
 	for (is_2m_pages = 0; is_2m_pages < VMW_BALLOON_NUM_PAGE_SIZES;
 			is_2m_pages++) {
@@ -796,7 +797,7 @@ static void vmballoon_add_batched_page(struct vmballoon *b, int idx,
  */
 static void vmballoon_inflate(struct vmballoon *b)
 {
-	unsigned rate;
+	unsigned int rate;
 	unsigned int allocations = 0;
 	unsigned int num_pages = 0;
 	int error = 0;
@@ -936,7 +937,7 @@ static void vmballoon_inflate(struct vmballoon *b)
  */
 static void vmballoon_deflate(struct vmballoon *b)
 {
-	unsigned is_2m_pages;
+	unsigned int is_2m_pages;
 
 	pr_debug("%s - size: %d, target %d\n", __func__, b->size, b->target);
 
@@ -1234,7 +1235,7 @@ static int __init vmballoon_debugfs_init(struct vmballoon *b)
 {
 	int error;
 
-	b->dbg_entry = debugfs_create_file("vmmemctl", S_IRUGO, NULL, b,
+	b->dbg_entry = debugfs_create_file("vmmemctl", 0444, NULL, b,
 					   &vmballoon_debug_fops);
 	if (IS_ERR(b->dbg_entry)) {
 		error = PTR_ERR(b->dbg_entry);
@@ -1266,7 +1267,7 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 static int __init vmballoon_init(void)
 {
 	int error;
-	unsigned is_2m_pages;
+	unsigned int is_2m_pages;
 	/*
 	 * Check if we are running on VMware's hypervisor and bail out
 	 * if we are not.
-- 
2.7.4

