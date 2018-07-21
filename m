Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3939B20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPcG+zF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3939B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeGUNvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:51:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36400 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeGUNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id d14-v6so229143pfo.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z81/wVfnvkuwyBDYVUx9HulwxVk5OwVko9OgSWO0G6M=;
        b=KPcG+zF0mZboLYxAPtDNTzQyCTpfBci61C/MeiCAC4VyQJK30JXvMKu3GPE/RUtwI7
         I01+/4dozdeEXupb22QhN1sPHzIi0UHucjH7HhewnzvsLfS3pxTwxwMiYQqWdBkimI8N
         VzZYFb2s0Y5RIq4HSQnBBTK8P1QGBQ9AfxEw2W1ED4nbd72sVRqrNOa2HCeB4Tp736sI
         WEAafVB1F0w4A01LxqFzfTHtv8B7ew4n07+GGSPz3sVld+DlDzns7kgw3xGtaKIDVdHi
         mYMzKxuGRJOO9qSPisK+5iGfd7BNlxJpRm3yXu2Z2optBqXv1Hwm1KREP2IBp3MVoNgp
         CZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z81/wVfnvkuwyBDYVUx9HulwxVk5OwVko9OgSWO0G6M=;
        b=pjjoJ8GHFhelRFshe12BXYSFpe/WCLr9FCIUtoNPkdY+9QfAxhXFWyKuJJ9hrnmYmE
         gHRwU3tNsshNkbCxlu5F5t0DTcJ1iy4MLlK3XbVfjFdPUe4EJCHqSi7r92l4REA7IZLP
         MVZ2y8sDYArJYfc4a+4CLe4DbTSHHaxkmww81Yifhwej5jccvlOA2uNK6OeqXnZrC90f
         UpCL6jCUEg8qzHmOuu7piCaDrzOLH9MICCsBeatODP/vdE603jiF+/m2co1kvCMGFP1w
         tlCastaG/kRTLS6lByRexwowiHX9QYzjxayYjuYDbD0ILy/DYJFv8/i6khXXP28JtDkF
         Mxag==
X-Gm-Message-State: AOUpUlGSz+8bTDRq/P77LYNecfZMBjVib7/QgW/WhbWlErYfF2lcGD11
        NzwwqYOwKq4brB8l8kOpBFFjRynajV8=
X-Google-Smtp-Source: AAOMgpdxaRTg+C9w3G3TsiUvVWLTYNMIaRFRI/XGqeXQwRq88H8/O660odZEDqz0ZHRJEuTs6Y6mkA==
X-Received: by 2002:a63:1e08:: with SMTP id e8-v6mr5505389pge.281.1532177877076;
        Sat, 21 Jul 2018 05:57:57 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:56 -0700 (PDT)
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
Date:   Sat, 21 Jul 2018 05:57:05 -0700
Message-Id: <20180721125713.88501-27-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
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

