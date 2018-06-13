Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A925AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F5208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIwuOhb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5F5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936096AbeFMPP7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:15:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38991 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935984AbeFMPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so3140353wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g23pTkthDir6WiafxRO9C54UE8+PUxr4OXpPgPQrngc=;
        b=NIwuOhb7g/SEQ5QyvP56c8xntKRy/PAgqmEu4b6hePbEeg0WCFf0rpXGtaono1T/3p
         tNXWs3DWLyctca/VFvrmZoZZbelqid6ab2qSN2a7mCTUNtm+TUT579+yYEeWMaS84FyT
         aySGzX+0nn/nY8xv65LGAX04h9qp3sTOisoQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g23pTkthDir6WiafxRO9C54UE8+PUxr4OXpPgPQrngc=;
        b=sIPtpmcWZm8COdDAeL0OjOSYbWeOe7l70AP7UWp9mxfrS91vPzQMrvMeJbdTleblJG
         bu1x91bZLkU0NvM8TrOZ7sOcMLyulgogbESppS/sWYUkZ2Ux3iJqEY2YZGRJGwzoboZ1
         x9jyDQvc0Z0aOQ+x0jVDdh8YwSkNKV4ef68L7VSXJI66MS3qMt6weyXa32QFKq/MMHoL
         oni7Ie0l2FAk8wwAJmk0XE7Op1FvhIPvt8TZx2c7wAz0kLjY+jovZIXaDIh3ZOx1pC7J
         FbJYKlnja7NczM5OZcksNBizCs3+hJ9XsXO/4Z2V4SeRKMrOCcBmiBrJCwjRBaU4dLd7
         4nXQ==
X-Gm-Message-State: APt69E2UVk7WmA8eIC3X2UzYudIzX/HrwDO+fBu7kpvSG07Flbi+aCLI
        2zpIdIBvuq0xTTPM/i/lEbKk6w==
X-Google-Smtp-Source: ADUXVKITRvlN+ysJFURhtDHijdA+UQMlBlwv3ERPY1yxyOgeJsSVd/TUn2pdIanDyk9Ngwyqr6X9Cw==
X-Received: by 2002:adf:a54a:: with SMTP id j10-v6mr4903792wrb.155.1528902556833;
        Wed, 13 Jun 2018 08:09:16 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:16 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 08/27] venus: hfi_venus: fix suspend function for venus 3xx versions
Date:   Wed, 13 Jun 2018 18:07:42 +0300
Message-Id: <20180613150801.11702-9-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the suspend function for Venus 3xx versions by
add a check for WFI (wait for interrupt) bit. This bit
is on when the ARM9 is idle and entered in low power mode.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c    | 72 ++++++++++++++++--------
 drivers/media/platform/qcom/venus/hfi_venus_io.h |  1 +
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 784b3ad1a9f6..72a8547eab39 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1444,13 +1444,40 @@ static int venus_suspend_1xx(struct venus_core *core)
 	return 0;
 }
 
+static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
+{
+	u32 ctrl_status, cpu_status;
+
+	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
+	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+
+	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
+	    ctrl_status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
+		return true;
+
+	return false;
+}
+
+static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
+{
+	u32 ctrl_status, cpu_status;
+
+	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
+	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+
+	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
+	    ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)
+		return true;
+
+	return false;
+}
+
 static int venus_suspend_3xx(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
-	u32 ctrl_status, wfi_status;
+	bool val;
 	int ret;
-	int cnt = 100;
 
 	if (!hdev->power_enabled || hdev->suspended)
 		return 0;
@@ -1464,29 +1491,30 @@ static int venus_suspend_3xx(struct venus_core *core)
 		return -EINVAL;
 	}
 
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
-	if (!(ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)) {
-		wfi_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-		ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
-
-		ret = venus_prepare_power_collapse(hdev, false);
-		if (ret) {
-			dev_err(dev, "prepare for power collapse fail (%d)\n",
-				ret);
-			return ret;
-		}
+	/*
+	 * Power collapse sequence for Venus 3xx and 4xx versions:
+	 * 1. Check for ARM9 and video core to be idle by checking WFI bit
+	 *    (bit 0) in CPU status register and by checking Idle (bit 30) in
+	 *    Control status register for video core.
+	 * 2. Send a command to prepare for power collapse.
+	 * 3. Check for WFI and PC_READY bits.
+	 */
+	ret = readx_poll_timeout(venus_cpu_and_video_core_idle, hdev, val, val,
+				 1500, 100 * 1500);
+	if (ret)
+		return ret;
 
-		cnt = 100;
-		while (cnt--) {
-			wfi_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-			ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
-			if (ctrl_status & CPU_CS_SCIACMDARG0_PC_READY &&
-			    wfi_status & BIT(0))
-				break;
-			usleep_range(1000, 1500);
-		}
+	ret = venus_prepare_power_collapse(hdev, false);
+	if (ret) {
+		dev_err(dev, "prepare for power collapse fail (%d)\n", ret);
+		return ret;
 	}
 
+	ret = readx_poll_timeout(venus_cpu_idle_and_pc_ready, hdev, val, val,
+				 1500, 100 * 1500);
+	if (ret)
+		return ret;
+
 	mutex_lock(&hdev->lock);
 
 	ret = venus_power_off(hdev);
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index c0b18de1e396..def0926a6dee 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -110,6 +110,7 @@
 
 #define WRAPPER_CPU_CGC_DIS			(WRAPPER_BASE + 0x2010)
 #define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
+#define WRAPPER_CPU_STATUS_WFI			BIT(0)
 #define WRAPPER_SW_RESET			(WRAPPER_BASE + 0x3000)
 
 /* Venus 4xx */
-- 
2.14.1

