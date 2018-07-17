Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A5BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7220693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekVHMYrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E7220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeGQVjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37575 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeGQVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:45 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so991682plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGDBiLHjs21Gva2iCU7i92iWoE1wuS+rDFjfFsVx9yI=;
        b=ekVHMYrh1BgTQM5wheoWgfLaKaeshkCoYp5ZvKIC8cjpM0OCTzu62dqLfmyZLL9mw6
         Wcd/K9OnT3Um/jsLBLRlKg18vKvjLftdzoZvPircNSWQguHWVeu6MDiHK/SLqC3liBhj
         gQzhzGYThKjp3/4EdeLXX+hmMn5OeXbxjjQNfs170V8qmHwsWn9awAoA9SIfPfGDgBUs
         FTFhjlqgBB0/lH0paKqjPRwTZcRh3LMTMTMRdOLQhojzqn+Srge3MEyPzdUhzzIss0FF
         F8eeCSPhzhyhzGPvGyqJnFjrrPAVbUKrznAzUadzkeziurwYQ1ijHzkGb9jWTxao+45U
         t/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGDBiLHjs21Gva2iCU7i92iWoE1wuS+rDFjfFsVx9yI=;
        b=U1tbf9D4S3RQriPmAh8mBNMMnyB3UKtUSdYo4o01HmVk/BS8gDZHQ+K9yVYszL9BHs
         dz1SzD07OXIKyyv3omazjK7/RR6X66J0S0kNFdV/rXv1dO3ry53Su0aHcKzqvX/hUm+9
         kJ4h44D+uRb53UlV3y8YcOA6smhtiuxTJ/c2lxEL9Tq3vFLLYbUI2VZ/5noBd9bSuJoo
         g2zwaJZpkjuUODfbIpYKwdlEn9i3G9LCGfsD/+33M2/A+drdkpU65wV5fGq/3sg4VwyV
         uu3ivr2LsCrlDdzsosP55fYXVQJMverg5wMYsGMHkf9XkKMb5M1C0v151+MPhnwAuItW
         y78g==
X-Gm-Message-State: AOUpUlEBMh7Xy2Wq06+gNlgopQ9D9T+9DHPL0SdhdxTmK2TIgKhaHHB3
        F3V6SmG+tY4Jvv4hYZCTEo+Ck4s9
X-Google-Smtp-Source: AAOMgpfO++hAYXf8QmLvRdvvkrcC3dlxNQGRxIeEtoxJfQIQDMtL10tO5QH/oqe/FcvkBUOwiCw+Mg==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr3143450plo.292.1531861517697;
        Tue, 17 Jul 2018 14:05:17 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:16 -0700 (PDT)
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
Subject: [PATCH 24/32] staging: gasket: apex_clock_gating simplify logic, reduce indentation
Date:   Tue, 17 Jul 2018 13:57:04 -0700
Message-Id: <20180717205712.29495-25-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Collapse together two checks and return immediately, avoid conditional
indentation for most of function code.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 43 +++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index c91c5aff5ab9c..6953b3b35ab50 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -660,33 +660,30 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
-	if (bypass_top_level)
+	if (bypass_top_level || !allow_sw_clock_gating)
 		return 0;
 
-	if (allow_sw_clock_gating) {
-		if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
-			return -EFAULT;
+	if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
+		return -EFAULT;
 
-		gasket_log_error(
-			gasket_dev, "%s %llu", __func__, ibuf.enable);
+	gasket_log_error(gasket_dev, "%s %llu", __func__, ibuf.enable);
 
-		if (ibuf.enable) {
-			/* Quiesce AXI, gate GCB clock. */
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
-		} else {
-			/* Un-gate GCB clock, un-quiesce AXI. */
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
-		}
+	if (ibuf.enable) {
+		/* Quiesce AXI, gate GCB clock. */
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
+	} else {
+		/* Un-gate GCB clock, un-quiesce AXI. */
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
 	}
 	return 0;
 }
-- 
2.18.0.203.gfac676dfb9-goog

