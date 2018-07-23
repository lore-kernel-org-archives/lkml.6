Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C98ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808E620671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvR2tyZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808E620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeGWT2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:28:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46967 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbeGWT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:28:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so1345192ljj.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/nnBwSIjkHyi6/4Yv6lQABCxWToy1NJBpVp3YIyLUU4=;
        b=qvR2tyZLtix6kQN+Hd+CPBHdGOYdMK8/4jVb+T//OAfxNcTRUIpkk7q0mxTnw1dRiy
         Nlrp8btFtQrxNw12WekGv6jDeN7LN02S20HSuWo5HQO+MYdxjqY1Gyxx7fik7GqUjbcc
         bNcHjgencD1Ej15QNQ6eU7vLw18jsgnLrtcBGsP2CwR1GUjwDCtoBWUt0oPAN+zovvIU
         0djf6j6mSVkx8P5GbWjKUzLkJQli9j/L0m1bzAJ6RxBajIIIk/RdZHtWsvLjgeCorw+c
         C35aeY6uPiLXvCW4NN10o9lktJ1ezFXNyL4zi/odofhKL90vWO2DQlcQJnT8xbAQIYJ7
         jtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/nnBwSIjkHyi6/4Yv6lQABCxWToy1NJBpVp3YIyLUU4=;
        b=PpmRekHbYBKy3AJ10bnd98/j3f3QdwE+Yfha54ALxYpss39lv1DqxlxQI7Inw6Lun7
         j3X2woMG1gz0WlM1baVasyEsv0adOnpA+hilZEr2KJoybd+9TF9JFWWt7bC+BtoRxG/R
         jkTaNHpT9hZxDtrcmgd7+WcaLD4+yRYVYxb1GBzHqCQMSFrjOsAfuQKZyGWkONlM1mw6
         B0TLy6U5Wx+syzb0kO1Yyz+a1mCqap6PvJbrSDlkID45pm5B18CxWuSyPAt1nqgZJbIq
         r3kiNmUAO0EWsqnf292W+uTpP1M+o146p4jxTZgOm1d02M7BSVWypNVpnalyNOdx5mcc
         DxGg==
X-Gm-Message-State: AOUpUlEwhqhg5Cp9oIiCKVUkGE0kvz4uw9lmZYM+5zFcadoa+ht8eOb4
        wNyldOmECg/mHql1oXDiugo=
X-Google-Smtp-Source: AAOMgpftDQjDLN57rD/tvdOfe827AculcXJYXR7dHacLAn+uZnf2f58yoD5Uftsn7R6M5CZnsGnPDQ==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr10257292ljk.116.1532370349481;
        Mon, 23 Jul 2018 11:25:49 -0700 (PDT)
Received: from localhost.mts.local ([5.144.106.90])
        by smtp.gmail.com with ESMTPSA id w8-v6sm1521970lfe.67.2018.07.23.11.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 11:25:48 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        benchan@chromium.org, jnjoseph@google.com, rspringer@google.com,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH v2] staging: gasket: use vzalloc instead of vmalloc/memset
Date:   Mon, 23 Jul 2018 21:30:25 +0300
Message-Id: <20180723183025.16550-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180723153853.GA10528@kroah.com>
References: <20180723153853.GA10528@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc instead of vmalloc followed by memset with 0.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 9f8116112e0a..3ffc8d67ec05 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -330,7 +330,7 @@ int gasket_page_table_init(
 	pg_tbl = *ppg_tbl;
 	bytes = total_entries * sizeof(struct gasket_page_table_entry);
 	if (bytes != 0) {
-		pg_tbl->entries = vmalloc(bytes);
+		pg_tbl->entries = vzalloc(bytes);
 		if (!pg_tbl->entries) {
 			gasket_nodev_error(
 				"No memory for address translation metadata.");
@@ -338,7 +338,6 @@ int gasket_page_table_init(
 			*ppg_tbl = NULL;
 			return -ENOMEM;
 		}
-		memset(pg_tbl->entries, 0, bytes);
 	}
 
 	mutex_init(&pg_tbl->mutex);
@@ -1067,13 +1066,12 @@ static int gasket_alloc_extended_subtable(
 
 	subtable_bytes = sizeof(struct gasket_page_table_entry) *
 		GASKET_PAGES_PER_SUBTABLE;
-	pte->sublevel = vmalloc(subtable_bytes);
+	pte->sublevel = vzalloc(subtable_bytes);
 	if (!pte->sublevel) {
 		free_page(page_addr);
 		memset(pte, 0, sizeof(struct gasket_page_table_entry));
 		return -ENOMEM;
 	}
-	memset(pte->sublevel, 0, subtable_bytes);
 
 	/* Map the page into DMA space. */
 	if (pg_tbl->dma_ops) {
-- 
2.16.4

