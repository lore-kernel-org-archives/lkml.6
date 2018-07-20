Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0202ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1FF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+kSb6Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1FF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeGTEgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44475 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeGTEgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:08 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so4559083pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aRBEd917vBbtvwzu/T79jZ6xYeCcIw2e7ivpersymng=;
        b=h+kSb6Jp1Aod45yLlczNWISUnaEHfGMDcdfhynji8Q1VxDjtHODr0JUW3+mbwVbtS8
         1jf5fi9TlxTqViuzT/RfFW263/22l8ylH9SmZpnePze2050tvXlF0Ge1bHqhaQTbX++w
         uCaFHkAp2rEW7s3+XK/7EFeZc4TmXrFBQIGXmCf5XChpuW3ONjpaoCBU9luqrYA0WiXI
         nb9JwaKcbClcYbXXUzLlvvofwJ+OoTfhq6bkMKhoaHkslLqq4BbggiKs9R/HW3jiqoHV
         kCY0ZCfigSm5vA9P4ri1ObgH2T32xl60j1eiiuG2Ui2vMLuuNoFxspnS//mkLKSn5ug2
         dI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aRBEd917vBbtvwzu/T79jZ6xYeCcIw2e7ivpersymng=;
        b=cM9mLZwwaBhKR9inVLlhlFrWRd0uUq2U2sVZkzxXaq4PTeL+yusP6RLpCS6giWxPPr
         Wys3XxtN7dqnBzBrgctvm6u2szgiVd/RSBYdGaptQHrcZK0DzRSR1LTOLkyKgSBb8pxx
         pVKemPtGZ2AlqNU90VXyqeQXxEFgtIKoAZH27EjrbjWaeNUVWteAnRzONWkYtIZlR97u
         yrU7IpeTPRYQsceOfOU/iJJGgMz83R0JIjNVTacZmb3odwtPU0Jk/VdrfQrYiQ4x3iPC
         oJWExEg5h1T1OuwMaUS1TSsvokxW6kMB04FfGoOYYnZiPPROU4okTj9HARjkIufA3RRH
         kllg==
X-Gm-Message-State: AOUpUlFUvkW7ZyBQhyudtAZtiLsTTA4vvvv6+9TCiqivxcCGAtYJ6Uvo
        b7owCjlL/osskSIRe0PLmkY=
X-Google-Smtp-Source: AAOMgpc+7sHcx3lDAAH+JSYLBy3s5/Jkk8RS4lCUSJQjPX2aaBq1yR0B4HD8du0hFG/vuA1TYY53bQ==
X-Received: by 2002:a17:902:a9:: with SMTP id a38-v6mr469152pla.102.1532058597074;
        Thu, 19 Jul 2018 20:49:57 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:56 -0700 (PDT)
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
Subject: [PATCH 08/20] staging: gasket: apex_clock_gating simplify logic, reduce indentation
Date:   Thu, 19 Jul 2018 20:49:08 -0700
Message-Id: <20180720034920.77320-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
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
index 3a83c3d4d5561..a01b1f2b827ea 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -666,33 +666,30 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
-	if (bypass_top_level)
+	if (bypass_top_level || !allow_sw_clock_gating)
 		return 0;
 
-	if (allow_sw_clock_gating) {
-		if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
-			return -EFAULT;
+	if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
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
2.18.0.233.g985f88cf7e-goog

