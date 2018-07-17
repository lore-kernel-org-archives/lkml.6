Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E03ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBF5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV605P/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBF5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbeGQCkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43729 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbeGQCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id j26-v6so2720914pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gke86c6QC7gVdcAYcERqw/Q9FflT847Q1zoLYsNJQV0=;
        b=AV605P/MWXEXCbjgaYSNQ2+JDM4ml+tiK0QrEGP70UGGk46foC29qihTYsgC7Rgg0u
         LQ8uW79hVNlFdfqnrulmsYiEP2a1uqTBxtrqC+ZfRaBVmxaSWR1UfL8kIkyJTIRv53Fm
         bxLh332oH5lcivNq7Op9YZLVLepAa7sWr46nah4DA5fSziH2xtHPxgRjtkGeapZlhpKj
         yJyOEB/ehtzWhODYBYrWDIqkFsjQi32e5XGIIUTmsOaauouDr08ebdKD3zHUUfim7LU/
         Z8q2MBIvURXKxc+GYul2IJ+oDLVpzaAjnl6dbGk8NwKiMa+ttJZhaTf9m8F8AGOVyGZw
         wGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gke86c6QC7gVdcAYcERqw/Q9FflT847Q1zoLYsNJQV0=;
        b=CKWtn4zCveSDrcqignwRb60rszTMhZ+cs42G24uoaRDlSNd6s9MKVBvqkniM4BzTT+
         sOTUKjm6juulk5V269/SqzGc0K3gJpqu4lA+eF1wuNiFZlQus3P3ehov0UvDSdTGWn53
         WSNK5MArq0bD6J2731QEzzlqG09j0RtK/kyalKTF0MTOQ/otP3RcWxfX5dnkjN8gLvTQ
         suoiJiqQ4LvfsFR2aqKXaVWYgwA8B04nV2T3H0JM5+bUnG4WJuRAx71JAFtngmPKK5/C
         ogVzxGmtKy5DtYqae9eXt/Ro7OmVMMkpXnoz3lThiov0e5Njtc5sxBBXHaOao+xIP0DL
         b6gg==
X-Gm-Message-State: AOUpUlEP7iDHMqYAQesqiDkEsN1a/9iYwWwISYs0rvefZhlFqGofBcnt
        757f+RGEz5yrYiU5SvAjoEM=
X-Google-Smtp-Source: AAOMgpc+YzFdoF0sM9shVHz7D3QZnNH2kJsXNtssoJsmX7Ib56c444FntZRyntlRVMOl/CK9vbRE+Q==
X-Received: by 2002:a63:4f63:: with SMTP id p35-v6mr17748591pgl.167.1531793398379;
        Mon, 16 Jul 2018 19:09:58 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:57 -0700 (PDT)
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
Subject: [PATCH 10/32] staging: gasket: fix gasket_wait_with_reschedule timeout return code
Date:   Mon, 16 Jul 2018 19:09:04 -0700
Message-Id: <20180717020926.176408-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Return -ETIMEDOUT, not -EINVAL, on timeout, including callers.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 8 ++++----
 drivers/staging/gasket/gasket_core.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index a31937dfff836..3a83c3d4d5561 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -490,7 +490,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 		gasket_log_error(gasket_dev,
 				 "DMAs did not quiesce within timeout (%d ms)",
 				 APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/*  - Enable GCB reset (0x1 to rg_rst_gcb) */
@@ -513,7 +513,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 			gasket_dev,
 			"RAM did not shut down within timeout (%d ms)",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
@@ -562,7 +562,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			gasket_dev,
 			"RAM did not enable within timeout (%d ms)",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/*    - Wait for Reset complete. */
@@ -574,7 +574,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			gasket_dev,
 			"GCB did not leave reset within timeout (%d ms)",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	if (!allow_hw_clock_gating) {
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 248d717e1df65..803566229bfcb 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2106,7 +2106,7 @@ int gasket_wait_with_reschedule(
 			"%s timeout: reg %llx timeout (%llu ms)",
 			__func__,
 			offset, max_retries * delay_ms);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 	return 0;
 }
-- 
2.18.0.203.gfac676dfb9-goog

