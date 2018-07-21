Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D27ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160ED20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtddyeRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160ED20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbeGUNuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39137 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbeGUNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:43 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so1338911plt.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqsTviS5LCPbpilAaLsUiiIHY+C0tnyeqqXRuMZQK0M=;
        b=CtddyeRKtRWXiISfqBdhxcMbfYp19dJaUwdZM2RLCU4/4RLn1LNR8QY50vSRl1n0Ds
         x6uX01HtB61uxOyGyuOrouSmcoA9B0xL3DdkPkLHB1v4MfG4NzWlBLbodzRosJgf2gne
         YSJ+rLSEFTgcNnyXd63pOppg7a4UnlBugBvUbgXep8G2XOFPf/FX8BFm96ejuhzf9Vqa
         M4FJqAr1sbWEP7IwcJcYg5YAcpX+ego+a+owaBWJT/pOXTQv4Qr8VLS98OFrhRYoUgj8
         kKKKDSV78nUXj4Nb/OzM2m6aePMVcFJhHhxPTTqfA21PhAXTryRU+JI5WR9M5/zUzUKu
         rXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqsTviS5LCPbpilAaLsUiiIHY+C0tnyeqqXRuMZQK0M=;
        b=hQefiqwJPqSjOAwEZu/vyyArzpuj+zRr2FA21VOvS3i+KejctF2BqbyajUYqYeftAA
         1HO/HdhRZ2LzMcdGGozZwEh2yP4nitwroUv170yE4nXGSVxtxa/N7ivwt07DpJs6Ktr0
         Y3oUDEG6Ofl+ykBid1qCIjEPZfPvh0ST6gxVVYEKha6cggrz5t4yeCo1wabH2n6sJv9S
         pQzF1bWJEBqMUvRn08fHycFE9O80GlsNG5xhTMfMbgm/ue32S5DDCgi5mnMdHooxpDA0
         PSMEp5DTMQIQExziM36Mmbu34UIrebKDfGOmcIF3+xusJGFrj1ocdbfY7RkFOx3qzBi1
         ysrw==
X-Gm-Message-State: AOUpUlFGWI81Yjs45c5rpu3PDKfHQVC6OY2dhTWH49dihDgwgbII+ZeQ
        XvBwwJXOng3aVPydxVrWIAA=
X-Google-Smtp-Source: AAOMgpfvLrSK0YOvBuwp5tZkpe686+3L5oQ+F/oVj4o8SlhzQhGeVjvmdAChXqRte5Nu1PAZfOZY7Q==
X-Received: by 2002:a17:902:9681:: with SMTP id n1-v6mr5974789plp.244.1532177882665;
        Sat, 21 Jul 2018 05:58:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:58:02 -0700 (PDT)
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
Subject: [PATCH 18/20] staging: gasket: apex ioctl add __user annotations
Date:   Sat, 21 Jul 2018 05:57:11 -0700
Message-Id: <20180721125713.88501-33-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add __user annotation to ioctl pointer argument, for sparse checking.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 4c00f3609f081..3e76c4db5db2e 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Google, Inc.
  */
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -142,9 +143,10 @@ static int apex_get_status(struct gasket_dev *gasket_dev);
 
 static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
 
-static long apex_ioctl(struct file *file, uint cmd, ulong arg);
+static long apex_ioctl(struct file *file, uint cmd, void __user *argp);
 
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg);
+static long apex_clock_gating(struct gasket_dev *gasket_dev,
+			      struct apex_gate_clock_ioctl __user *argp);
 
 static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
 
@@ -635,7 +637,7 @@ static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 /*
  * Apex-specific ioctl handler.
  */
-static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
+static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
 {
 	struct gasket_dev *gasket_dev = filp->private_data;
 
@@ -644,7 +646,7 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
 
 	switch (cmd) {
 	case APEX_IOCTL_GATE_CLOCK:
-		return apex_clock_gating(gasket_dev, arg);
+		return apex_clock_gating(gasket_dev, argp);
 	default:
 		return -ENOTTY; /* unknown command */
 	}
@@ -653,16 +655,17 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
 /*
  * Gates or un-gates Apex clock.
  * @gasket_dev: Gasket device pointer.
- * @arg: User ioctl arg, in this case to a apex_gate_clock_ioctl struct.
+ * @argp: User ioctl arg, pointer to a apex_gate_clock_ioctl struct.
  */
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
+static long apex_clock_gating(struct gasket_dev *gasket_dev,
+			      struct apex_gate_clock_ioctl __user *argp)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
 	if (bypass_top_level || !allow_sw_clock_gating)
 		return 0;
 
-	if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
+	if (copy_from_user(&ibuf, argp, sizeof(ibuf)))
 		return -EFAULT;
 
 	gasket_log_error(gasket_dev, "%s %llu", __func__, ibuf.enable);
-- 
2.18.0.233.g985f88cf7e-goog

