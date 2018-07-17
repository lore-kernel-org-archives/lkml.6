Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82848ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6020693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBP744On"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA6020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbeGQVj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34523 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbeGQVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so996430plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gke86c6QC7gVdcAYcERqw/Q9FflT847Q1zoLYsNJQV0=;
        b=XBP744OnmV84syW15cjJZwnikdSIb/GUrU8a/9y/6RvwWJbVPqI1DVcwHvlTUupNSP
         7O9HL0oDBuFWzxT9eRDF6ffcvoaaJK0pCCAIX6LaqRAgwpJxiF2QBIPaQngr+xLPK0U5
         JMOsjHaq6H0QcP4XxQRMfg0wHiYdTKJ4fm0SYSpipmsPC4T3mY6H2uqpXWMCjF1Kvp8B
         bM3CzvGVslceLEX4dmR+tR3YFadBs9a6WCa9slRsFwHr8bs+MIMnlPyLrvURLia5Amtz
         5Uruh6+5elA6btAVoY+KO6pN9gHu5+6EHkmYnQyPNnLX2LfQPpE7Hp1aioqQVUnMmoNz
         itmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gke86c6QC7gVdcAYcERqw/Q9FflT847Q1zoLYsNJQV0=;
        b=Giss3G142eof9wpZtLhS7lvz1/74Ptuny+LJr0+39tlQLMTi+OZ931WhlrDmfXgQGN
         +VmAAFEhwRbkzJKQiQ7Cqg4IqJ1KrX58FZtKRDl4me/FSkt8vrzMW1Z+uczU+OLHDeMF
         nseSPJwr4RCXgVpJOsW/8zx8PPK1Tqf7lDAys2x8U5l5MwHgjyg1m16q0zxOzVvPbKfC
         qzfTeGvmnQbxvRgpGJJTxX9xF53EpGRu5RrJETDkIyh9ROkGeXTaxLqTcbzLk3p6anRq
         /xrq3y4YAywVGv8HXnp84gTZyMKQpiePCGR5wDscPFK0RWIQgNQAEgDNfS5bhYhY1m3Z
         tcFA==
X-Gm-Message-State: AOUpUlHzt30izRSvUp80olFTLg9CxlRXXaLcq2SyPemHVaZMA//SnDL1
        nvlGJPo3E2fsw/h5YuphCus=
X-Google-Smtp-Source: AAOMgpdFN8Xu18k8aMUt5wv1n1+kHWJPr0T2c2zryBer6hPtLKIxlv0Bsx0renPoXdbOq/Q/wQ2ddw==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91-v6mr3087591pld.27.1531861497034;
        Tue, 17 Jul 2018 14:04:57 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:56 -0700 (PDT)
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
Date:   Tue, 17 Jul 2018 13:56:50 -0700
Message-Id: <20180717205712.29495-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
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

