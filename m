Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D347DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2BC208DC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i83OitsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2BC208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeGNGQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39440 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeGNGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so23773254pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9K2sF/3Jk6ncSRVLrzbeb5yBbFxpwj4A9/nCOf1KMo4=;
        b=i83OitsBogmQktXUjOtFXqzLKA1UcR79jjF6Jep/TuYk17USz/S86gqfJYh8lpSqII
         taGGIohAYPExCltLCu2WWy/Zj5ClFwGBrdkzghRkpk/rCvQkK3Qy5KXNxI0gAuFtuial
         DOYYVz8Vg1ceDhvdgxoFb3O6kWlqaAgNY8YF8lFueYgt7o/zxds2qi94UNnNjMUbWcDG
         +C8/JuocBgiGBdlbFpOl6H0fWmmFSYok5eUpbCoccDR+ZU7dNIWejO29Ywc69PYovwdp
         xv63kR2fzNI5RlAJ0UMGsC+0pZzT9gPHWdRGwjCeb4nzMgdz1KJic75nTc9ODDz8GrDp
         5h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9K2sF/3Jk6ncSRVLrzbeb5yBbFxpwj4A9/nCOf1KMo4=;
        b=L3W9yBW5yuUBZxQvPxuLTW3rxpA5ixUu33YBPr/c9Z6VvF8MPSD2A6z0DuvgUrr9MA
         TeSvydQ1PfjJicEmcmNRF73IimIqnJGH3Io5NpUR5eCwTAzDZsK/hmBxpJtGkJVo52pm
         p2Kp8oqLyzyKopNKcYIChqngCDoVl3yP+bmCR4Jj0I3xkMFUnCOscpSNJJIYqWrbN96H
         0mrV//D/nuip6No1b7EWK7IigbEZUqFPHopobhSRKhTM3AD40TZ5tjt6W51Cf/qRv7S+
         939W5KyGZLLrY2qHZrjKRU6kQI2nVyGd5VmYo6N2Yx5vcBxuXXwQbTCaKqX7ICnIRhFU
         bckQ==
X-Gm-Message-State: AOUpUlE91WUgQaR+cnaqvHz3Mb1Jp/qqX/s4hYecuAWwS0ingfne9r+S
        uq5e3IQd2GP4Al09PZ1JTuw=
X-Google-Smtp-Source: AAOMgpfnKtSDhbpaQ9DPHEE+HQgB0XiziYKt4cG6MxO4+oMAZixZV67VTuR+RioNJWK3CkdYSiwXWA==
X-Received: by 2002:a63:c114:: with SMTP id w20-v6mr8464298pgf.234.1531547927535;
        Fri, 13 Jul 2018 22:58:47 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:47 -0700 (PDT)
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
Subject: [PATCH 03/18] staging: gasket: typo and whitespace cleanups
Date:   Fri, 13 Jul 2018 22:58:01 -0700
Message-Id: <20180714055816.223754-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Trivial typo and whitespace fixes.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c       | 2 +-
 drivers/staging/gasket/gasket_core.h       | 2 +-
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 395256704428..f2d082c06c98 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -500,7 +500,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 					APEX_BAR2_REG_USER_HIB_DMA_PAUSED, 1, 1,
 					APEX_RESET_DELAY, APEX_RESET_RETRY)) {
 		gasket_log_error(gasket_dev,
-				 "DMAs did not quiece within timeout (%d ms)",
+				 "DMAs did not quiesce within timeout (%d ms)",
 				 APEX_RESET_RETRY * APEX_RESET_DELAY);
 		return -EINVAL;
 	}
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 5d6535a0f254..77d08c1265ca 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -63,7 +63,7 @@ enum gasket_interrupt_type {
 
 /* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
- * fields is relevant only for PCI_MSIX interrupt type and can be
+ * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
  */
 struct gasket_interrupt_desc {
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 5d3d33cac12f..d7600d8e385f 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -354,7 +354,7 @@ int gasket_page_table_init(
 	    pg_tbl->config.mode == GASKET_PAGE_TABLE_MODE_SIMPLE) {
 		pg_tbl->num_simple_entries = total_entries;
 		pg_tbl->num_extended_entries = 0;
-		pg_tbl->extended_flag =	1ull << page_table_config->extended_bit;
+		pg_tbl->extended_flag = 1ull << page_table_config->extended_bit;
 	} else {
 		pg_tbl->num_simple_entries = 0;
 		pg_tbl->num_extended_entries = total_entries;
-- 
2.18.0.203.gfac676dfb9-goog

