Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2641ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9A20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFLk11J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C9A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeGUNxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:53:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43194 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeGUNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so9022922pgr.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+b4GBpUhCwwdfz79rhlZIwoXvD/yAsDVw/JaGwhQAA8=;
        b=GFLk11J5xcJjvjvD7T4eqwKw9c+HQek4yMAqCi/bGriqp/kGa5ouybWDOCaaFNHz6Q
         PGT4KzSIYyJQOqrb1aQomiQq8djntbzl9jS2EUndStNv/3jP9DbGffXfJlOyFC8v1RmY
         T7KTPR8YyqsO6Ig6BjUUWk+oBRliUb914TNdtCjVKZKt5tOSldsZ6UuMSRU1FXiy1m40
         LX8njT8RA2eQr6FT6gQIqlf9KyxJwyRgBQx9FmpjB7gDmBeWIzeNO78eeqylLaf46W4D
         PJs0Iki8Ew0MjDP5bhw2E2hG0VyE00dIwH0Ml8uoATmj+Wr0xGvTeQc33uyDbA3kbirs
         Y6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+b4GBpUhCwwdfz79rhlZIwoXvD/yAsDVw/JaGwhQAA8=;
        b=OzA29yOiyfUOHi+Lck5jhDqDsxNH0OXGyHi5jduir69lsY4lZYv9Nf9E1/CLlzVHFK
         QKpwMQrnYIh4NM8QIAA2+42EXo9AUF65fEY/bXFaiUu+1+XlZSwy3NTrd0gtJ+H+u5FY
         V+MDrSLV8nN1mIz1R+n28FOhg6xXHMKF1BJdn+J6hPvH4Y9qFFEtz5OP3K//hqsDXE5R
         +yWVbDuCfQhtYZczKCIb0N90kNmiWDS2cs8pX9WDTDlIbQ72R7I44/voF25OSAzRidrU
         AsYVW2qNQYq7RhhRruDDjZupZq4yprJzMrG0IieEe0G6IZUBxnLGpLY8jHGlFCzikKDI
         AmXA==
X-Gm-Message-State: AOUpUlGSLHk8f+DBRweJMOF0tayMAN9A7FOsN019gQmZGZq9W2xZCkPR
        x6JPprLA1xKfO3aTCi6pwDQ=
X-Google-Smtp-Source: AAOMgpetjOg6guPT1+9Vcw2lMeElZ8Db+ZQ6pJTCXMXMx7W9btRQmWxyiU7qYPvn2D9mmnS9l2ioZw==
X-Received: by 2002:a63:b91c:: with SMTP id z28-v6mr5621077pge.22.1532177855792;
        Sat, 21 Jul 2018 05:57:35 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:35 -0700 (PDT)
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
Subject: [PATCH 02/20] staging: gasket: gasket_enable_dev remove unnecessary variable
Date:   Sat, 21 Jul 2018 05:56:42 -0700
Message-Id: <20180721125713.88501-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unnecessary variable, pass constant param instead.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0d5ba7359af73..f327c9d7f90a3 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -898,7 +898,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	bool has_dma_ops;
 	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
@@ -917,8 +916,6 @@ static int gasket_enable_dev(
 		return ret;
 	}
 
-	has_dma_ops = true;
-
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
@@ -936,7 +933,7 @@ static int gasket_enable_dev(
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, has_dma_ops);
+			ddev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.233.g985f88cf7e-goog

