Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F820852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKe1fSnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeGWQCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:02:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33577 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbeGWQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:02:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so834164ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ulid1un2CprZvgwqqrxDKueDNXlu6JmJgGlBluN3lnY=;
        b=TKe1fSnZMydzwhqw7s3l+EuGOjX4BIp/LAdpA5x3ld/B+XIWmT9jrAh9BHELQk4spH
         xWuzkrp9J4+sgk/sg0sieUfRdMMUa5VWLW4i/e71cnRcSHJjT0UHeDCibg4fgEcnsDoZ
         tqCBt9paWteJQ6TYy3faHfMdx/w2eFm2ZplFS/QPurypk+O1aRqQNyB5yoZRNltKcWx8
         uGsIB+JrewQpeXfjbuVwx4fa+igxHmxV+AoDp1epkK9VT3aNQOPkqbuKVMqeYH3I6Vxf
         jwQj4nmsR0LFvDCxE9l1qTI1YDuZGbUnQnAyNdGX3tuxtfC2pOLneKCPS79n7o1fkKv/
         enOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ulid1un2CprZvgwqqrxDKueDNXlu6JmJgGlBluN3lnY=;
        b=BZZczaCP8HrXBg7ZYgRc3NVEO10HCuZWx5Uh3WUjacwbGYwEiq0OQFRoL/CQMWkV5r
         fbj2OAYzbTQ62RMX8KFTxgNKqjb1yHjQEkODNLYesYOCg9r+UsFB6F/xeeDeaKo9Kg7N
         H1d0mzku5CyKD3JNXFzsRo7RXvvOM4oVH2isWWsySGZUPn+K136D0pzmVPfR5doZwPuo
         9to8cYU9+5hwebvoPeYDzjeTpRaoAqPuTwKXyCRvqyjVmIQduVstZVDpi6LJsywCZndw
         97wbsTWrssU6Ep6+Ou4NAASGHDWK8YBejwDpj/FaSzqUiHn6rlMMSdj3N3CjnLCm+zRy
         n5xA==
X-Gm-Message-State: AOUpUlGJLrjqnVbky5rdBkvu+kicHbq19FekOGgyknrAA89Jbf9CfM5v
        YRlPTY7QqTd8zAsryRQOzFI=
X-Google-Smtp-Source: AAOMgpchKcbM/feb9Q425DjuVNUMfIsTUvg02h2Lx32jKeX7weOrs7gJNtXYxNRDj+56tRYI2fz1Kg==
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr8957633ljj.80.1532358070655;
        Mon, 23 Jul 2018 08:01:10 -0700 (PDT)
Received: from localhost.localdomain ([94.25.229.185])
        by smtp.gmail.com with ESMTPSA id t8-v6sm705231lfd.2.2018.07.23.08.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 08:01:09 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        benchan@chromium.org, jnjoseph@google.com, rspringer@google.com,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] staging: gasket: use vzalloc instead of vmalloc/memset
Date:   Mon, 23 Jul 2018 18:05:38 +0300
Message-Id: <20180723150538.3520-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

