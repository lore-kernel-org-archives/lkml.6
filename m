Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF477ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B23B20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uN91sFmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B23B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeGUO2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39718 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeGUO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so9069420pgs.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z81/wVfnvkuwyBDYVUx9HulwxVk5OwVko9OgSWO0G6M=;
        b=uN91sFmn5UMStgGt7DugOHKZdXvusG0Iofjf2sgOyZtmKjaVQ/+GMa2hG4l6+2gBYA
         AQuzYXK+szIMw/NOJaZmKQ93mjfhesWXg+u6DiZixm+SynidZuu0SSTwruo51tgpKEBf
         BOpgc/DKUbxkk4CKcpVv4X9mdwGsKslm4lyG8+yr6ZJ9oLG49Eh/lr8K0wjhhrxB1QA5
         CLc8uEdnvFu2vWMXTDvD02rcfCuL34yDbKHzNegTamwFWinVFJa0Og+ItBYXwapEAKXp
         AbHiHy1QVN36G1g6d4YviYLHWLt0j6FH8EU59NGMHgbhqGT9sb0Q0v4pwTg6tOcpWrJX
         NcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z81/wVfnvkuwyBDYVUx9HulwxVk5OwVko9OgSWO0G6M=;
        b=EIyg1ybd16AIb+VQSU4dKEhCzV9B5ev6qfswCwrkVNpLoTJRjEiWx5yWziGA6bRlMg
         BeBGTQ7+WYvqk8RaxwD+7B07+6yNZqNnnwZ7eg7DQGK/JScE0CNJ9+L701aKKWcZi/5P
         uypsYwUx8PXi92tkILt4quCEQ4+M8cfym3DX/WvYo0v5O+YoeMPN3ovxRSlB8qrqI5yj
         ZLH7qLBSTQ3Q+ss+R6ui628EFnmRdCySJoAksommmVauzzy0qOrg8yHesA+R3hjbdhpA
         bCnhxN6PKjupj0VkVLOCcg4wVuegoHIZWbJsoFqNVTcItffty1pAkU7LsZGcEjWVU4R5
         3ZGA==
X-Gm-Message-State: AOUpUlF64tEqqPOBHcQN7OO/1MT2nVJ16oj2dfNInwNcft7HzknPu33b
        TC0eGSzDXcFdoMt2DLhfK+MTGhnzl+I=
X-Google-Smtp-Source: AAOMgpcO7a0qW8W1ps1b+LDGA3nLVtcP6+q9WeHPB8oCGP+VdRsFVTIx6m1MSBijTIKdDeYxa9Hwrw==
X-Received: by 2002:a63:f14f:: with SMTP id o15-v6mr5709126pgk.306.1532180132536;
        Sat, 21 Jul 2018 06:35:32 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:32 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/14] staging: gasket: page table: remove unnecessary logs
Date:   Sat, 21 Jul 2018 06:35:06 -0700
Message-Id: <20180721133507.95599-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Some error logs in page table handling code could only be hit in
cases of programming errors not expected in the current code base, and
aren't likely to be useful on their own.  Remove these.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 23 +++++-----------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index f0c4884cb4bc6..4f2ff77006586 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -605,10 +605,8 @@ EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 /* See gasket_page_table.h for description. */
 uint gasket_page_table_max_size(struct gasket_page_table *page_table)
 {
-	if (!page_table) {
-		gasket_nodev_error("Passed a null page table.");
+	if (!page_table)
 		return 0;
-	}
 	return page_table->config.total_entries;
 }
 EXPORT_SYMBOL(gasket_page_table_max_size);
@@ -616,11 +614,8 @@ EXPORT_SYMBOL(gasket_page_table_max_size);
 /* See gasket_page_table.h for description. */
 uint gasket_page_table_num_entries(struct gasket_page_table *pg_tbl)
 {
-	if (!pg_tbl) {
-		gasket_nodev_error("Passed a null page table.");
+	if (!pg_tbl)
 		return 0;
-	}
-
 	return pg_tbl->num_simple_entries + pg_tbl->num_extended_entries;
 }
 EXPORT_SYMBOL(gasket_page_table_num_entries);
@@ -628,11 +623,8 @@ EXPORT_SYMBOL(gasket_page_table_num_entries);
 /* See gasket_page_table.h for description. */
 uint gasket_page_table_num_simple_entries(struct gasket_page_table *pg_tbl)
 {
-	if (!pg_tbl) {
-		gasket_nodev_error("Passed a null page table.");
+	if (!pg_tbl)
 		return 0;
-	}
-
 	return pg_tbl->num_simple_entries;
 }
 EXPORT_SYMBOL(gasket_page_table_num_simple_entries);
@@ -640,11 +632,8 @@ EXPORT_SYMBOL(gasket_page_table_num_simple_entries);
 /* See gasket_page_table.h for description. */
 uint gasket_page_table_num_active_pages(struct gasket_page_table *pg_tbl)
 {
-	if (!pg_tbl) {
-		gasket_nodev_error("Passed a null page table.");
+	if (!pg_tbl)
 		return 0;
-	}
-
 	return pg_tbl->num_active_pages;
 }
 EXPORT_SYMBOL(gasket_page_table_num_active_pages);
@@ -652,10 +641,8 @@ EXPORT_SYMBOL(gasket_page_table_num_active_pages);
 /* See gasket_page_table.h */
 int gasket_page_table_system_status(struct gasket_page_table *page_table)
 {
-	if (!page_table) {
-		gasket_nodev_error("Passed a null page table.");
+	if (!page_table)
 		return GASKET_STATUS_LAMED;
-	}
 
 	if (gasket_page_table_num_entries(page_table) == 0) {
 		gasket_nodev_debug("Page table size is 0.");
-- 
2.18.0.233.g985f88cf7e-goog

