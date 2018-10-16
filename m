Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D78CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227B920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPh/AAYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227B920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:49:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36941 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:49:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so22658618wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3tXeOfP9/NVoEfrstPNB1vMihdx2bRPlf6ysDXG1io=;
        b=ZPh/AAYhYaztaIdxG3FLj36DN0WJepMcdsJ+9f4ymf3hrQWcnXje1aPWbY6Yj9I1yh
         SHFu7PnRUBJAVdq9GlEn5iL1maqtGLFgHDRnV6GZA61mdYVPuWUTYXtguxebYHYUj3M4
         FQR5YDKPjE6MSD+XFG9DxMPPPdq0FGtQQqnV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3tXeOfP9/NVoEfrstPNB1vMihdx2bRPlf6ysDXG1io=;
        b=j28LdmgbtuwNPsYaLjYkxwQOhcDT/rMnqriaEg9x6EXKK+dumhHNER3Ip+ACSc0TKV
         F231gPwjyf3hYAN2/oyOkf/mIDP1Tff3CLbQocyu1jOa9ztZoKo4WS3gpJ8uRF1ciMI7
         V5F1JjYD+B933Rs+zXnOz9Rj0Clxo3myTWDo+BOX3TOUvg+NI4bCmCtjwbQqVQuSTXqm
         eHR3Dx/VJ4U8eh8JPNSh7Jt0CKuYhnBQSiZcmAGACUJ1zYy4jfJxjfS8ijuBtapOgeeS
         A35JF/xscqA+0MhPgDdsV4FgXKeEEMKeoq0h9iPqqYsgWHI97KBc6m9fB54xoqaUg37K
         yN8A==
X-Gm-Message-State: ABuFfohKTnMBn5yXvBk0CYzspaGpke124IsCXZjLh3INF8eNj5UTaqVR
        FY6cXnI8NQa2F4myjYxppPMRqw==
X-Google-Smtp-Source: ACcGV62s7gycClb9uH8sUKG+O4bsILC6mLoQ1eISMyIOcN3oUn6P2BF1cT1TVG5EA33givIyq2Ph/A==
X-Received: by 2002:a1c:5e49:: with SMTP id s70-v6mr15883918wmb.131.1539683992828;
        Tue, 16 Oct 2018 02:59:52 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 195-v6sm12085163wmx.21.2018.10.16.02.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 02:59:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     colin.king@canonical.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: ngd: remove unnecessary check
Date:   Tue, 16 Oct 2018 10:57:48 +0100
Message-Id: <20181016095748.30325-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLIM_MSG_CLK_PAUSE_SEQ_FLG is never set in any of the slim core,
so performing a check in ngd driver is totally unnecessary.

Also this patch fixes warning about mc field overflow reported
with CoverityScan.

Making clk pause feature optional will be added to slim core in
next development cycle.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 ---
 drivers/slimbus/slimbus.h       | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7218fb963d0a..1382a8df6c75 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -777,9 +777,6 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 	u8 la = txn->la;
 	bool usr_msg = false;
 
-	if (txn->mc & SLIM_MSG_CLK_PAUSE_SEQ_FLG)
-		return -EPROTONOSUPPORT;
-
 	if (txn->mt == SLIM_MSG_MT_CORE &&
 		(txn->mc >= SLIM_MSG_MC_BEGIN_RECONFIGURATION &&
 		 txn->mc <= SLIM_MSG_MC_RECONFIGURE_NOW))
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 4399d1873e2d..9be41089edde 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -61,12 +61,6 @@
 #define SLIM_MSG_MC_NEXT_REMOVE_CHANNEL          0x58
 #define SLIM_MSG_MC_RECONFIGURE_NOW              0x5F
 
-/*
- * Clock pause flag to indicate that the reconfig message
- * corresponds to clock pause sequence
- */
-#define SLIM_MSG_CLK_PAUSE_SEQ_FLG		(1U << 8)
-
 /* Clock pause values per SLIMbus spec */
 #define SLIM_CLK_FAST				0
 #define SLIM_CLK_CONST_PHASE			1
-- 
2.19.1

