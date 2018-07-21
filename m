Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A21ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D82E20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecJ/NsYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeGUNu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43212 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeGUNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so9023137pgr.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aRBEd917vBbtvwzu/T79jZ6xYeCcIw2e7ivpersymng=;
        b=ecJ/NsYII0Zw8n+wfaYaiZMC5rVdWOnZxkp0tzBymV3Y6hWp7pfdzlNlPHemiHzIYz
         DXEh6gpUAIQ10DDm/1GOS+h2G5Xkzcm/8fdVrsCv432OUUGzxOHmGFYszo/Xm2fb/PDA
         MXJSExhADBrSvKC/OmVhJU3OdpGI2k1zFwLiR2KZ5f2D+wh5rravxbvpV1fYzkKPmy6b
         mcGRxjvT6b+exzhA0J+XlRVm18zgqx4GaYl3T+31l45SgNLC7qNXiAlRRDha2ElNz7nt
         e06tTkOjyUiy8zKHCjJ61vD0GNXnSrsffi2TcdHRdvxeiDgCXQRrMPLfYHqj9P9Len6B
         KTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aRBEd917vBbtvwzu/T79jZ6xYeCcIw2e7ivpersymng=;
        b=BfF0OvcbLy/NvT7wTM1Mw4bTYgr5kV3KsijUtGTVY5EpEMKPwTUtpfcNY9M915P8/y
         bLrunzXHGQz1rnXEdhj/wGb/ddMooM2xz4RVTMBSy3G+BYkLW+x3N/cQjWmULEh2iiIN
         3r1GGu6DVQ0cUMgoezqDg7IScNTJGbaojriWKpuC95Xm1q5tyLYz9+P2rN5HZvYDsVwk
         OXgJRTHMwZUccrumXquBArhu4xzxBPSGCnIbCiFrADpsRb10ossfqo3Va2wIiCHQNzYh
         LlE4oIwhuU7K1bAYJ4lDx7IXT0w5KzWWxWLg6R9OPhXtR0fuIBs4FHPAOSMO3o5qeTcC
         9jKA==
X-Gm-Message-State: AOUpUlEARKF0FQ1d2S+FrFwLnyBXOu/lcjw6dkM0HHM2K1rNNQ+lUbBX
        yzATmzWJQiYLs49HCxoJXxU=
X-Google-Smtp-Source: AAOMgpe+xNUv/80fecNmlRpOmRXJ6uxhuk8rL3bBCjTWe+IpcGU7HNO5Knio7CxV7+rPBpHbN/rl3g==
X-Received: by 2002:a62:3c4f:: with SMTP id j76-v6mr6009085pfa.119.1532177867681;
        Sat, 21 Jul 2018 05:57:47 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:47 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 08/20] staging: gasket: apex_clock_gating simplify logic, reduce indentation
Date:   Sat, 21 Jul 2018 05:56:55 -0700
Message-Id: <20180721125713.88501-17-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
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

