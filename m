Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC691C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBF324491
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PItnEbO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBF324491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965244AbeF0Peu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:34:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37087 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934856AbeF0P2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6-v6so2478406wrp.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g23pTkthDir6WiafxRO9C54UE8+PUxr4OXpPgPQrngc=;
        b=PItnEbO4dfB3z0jBJ7+lv6zBTqFgKi/kHC1T4YB5Ew7xdBxV0Na5jcCAz9m2fQr1+A
         HUOyMIJyaMY0KhXlC7kdrTaS0fx5SuMgUURP348Z9mpYjmVSDH8YHgacoBFW1p+p0xaJ
         QoLV9QdhFKGycNRHqB4eli7Pp8fQttOTQVpuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g23pTkthDir6WiafxRO9C54UE8+PUxr4OXpPgPQrngc=;
        b=TIO/RoV8QOFERvn3mFcPg69loKKVVvWL80n4mw5UgPJxdsU+8/qrtbPCiwVaR38yhy
         ln0bA5Rj2EUkPtP+yRxMxB7Aibz+5FIIco6+5GeiaqJy0Vb2AuWAdH+MYprlExLT0d8S
         waimSC3wORTho2WtRYLoNsAWvdKlDyd8cAbmQD9pWOuHL81wy+9/GvRX8mJNX3SBnYqM
         dKDxlIaRcb/TdZoHbxjOtQRfVtaH3vQeTRvKm9kyRxfzQknBvUfeKY0u6U7WzRmCpowY
         0Z5mhAbi+aY82NUhCbLCx+pvkgFA+7PVdxxyAJryNH99S5UU2n3403YvpDq9xUV8ftEH
         HauQ==
X-Gm-Message-State: APt69E3ypswXjWR/nkCd7WtjYEbkLN2N0/m/Toh4O8AOQ2UC5CFKa0L/
        +J4cRygGjISELhT0UqpBEA6UfA==
X-Google-Smtp-Source: AAOMgpdrnOSGPNQXflwFhuWqaCTj+qs/K+YlmJ1OGd9jbFQKlM9eKkCrYgzXBlRxxONAYCFHFd2MPw==
X-Received: by 2002:adf:c646:: with SMTP id u6-v6mr5487460wrg.177.1530113287087;
        Wed, 27 Jun 2018 08:28:07 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:06 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 08/27] venus: hfi_venus: fix suspend function for venus 3xx versions
Date:   Wed, 27 Jun 2018 18:27:06 +0300
Message-Id: <20180627152725.9783-9-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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

