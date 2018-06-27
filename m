Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE9DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0726071
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIEUNa0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F0726071
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeF0P2Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36504 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934849AbeF0P2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id u18-v6so5975946wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTs56AHvy6n4KWdfQCk5+mkf+fJThH/BkJrEXFnLkOk=;
        b=KIEUNa0Zj98zU6QZS9HRyNaM8Rm2DMHuM4kWqpNCFGn0qivw1VH6Um3baqHDfw3Fw0
         31YKr11rvEQhst25ULi37Eb7tbUEFPGQ+lsr61tuic/MAMwtQDqN9NAMWg9QCikusPMO
         gKikJDIlFp2Xup/ytCo5IKE9r+HGVwltbXS4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JTs56AHvy6n4KWdfQCk5+mkf+fJThH/BkJrEXFnLkOk=;
        b=Znl/XLLhLmDLeZZdCNR9fUOMmB/9DiODh2wzTSMSHhxcx8/03NVvjDKDxsfPVDsHP8
         IIQIB3V/2SZId/n7Ufg2PpJ6SktrCxgx5mX158ZbzwCk9Cnxa7Hk0y0Qqsc9zTdol95i
         EexQEXmFpv5MIRh8JOyRNzyOZoNNwiykn4R4IvbihV1PJ76A9iI1qrxVxpPoDMSy2i28
         1AbtwDKNg4Ha6RWC1WDbvYYETnoiRubpsqP5u4BsK6MGBdEbfR0AofDiYnsKC4aVGF5s
         LpEC1ESEYeVHBojPlbnrrPXDIflXl4sl312hi4T2LEUKfWkjpmHqGbBP2U4iUWugMf8V
         /Fdw==
X-Gm-Message-State: APt69E3ZH8AlcSuAmCBHtOblBOXyQ5p7znDCjVj4fe/b5IfB2gNLmI0Q
        goT4lUtXawdlxInFz8bZeN26bA==
X-Google-Smtp-Source: AAOMgpf3DeZYP7d1HsPWWMYbQ4S+CR4opI/C3TP+AAjLA3sbxYX4futhnmvTiQHKL3oDwdCTWmZr3g==
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr5039453wmi.46.1530113285944;
        Wed, 27 Jun 2018 08:28:05 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:05 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 07/27] venus: hfi_venus: add halt AXI support for Venus 4xx
Date:   Wed, 27 Jun 2018 18:27:05 +0300
Message-Id: <20180627152725.9783-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AXI halt support for version 4xx by using venus wrapper
registers.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c    | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_venus_io.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 734ce11b0ed0..784b3ad1a9f6 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -532,6 +532,24 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
 	u32 val;
 	int ret;
 
+	if (IS_V4(hdev->core)) {
+		val = venus_readl(hdev, WRAPPER_CPU_AXI_HALT);
+		val |= WRAPPER_CPU_AXI_HALT_HALT;
+		venus_writel(hdev, WRAPPER_CPU_AXI_HALT, val);
+
+		ret = readl_poll_timeout(base + WRAPPER_CPU_AXI_HALT_STATUS,
+					 val,
+					 val & WRAPPER_CPU_AXI_HALT_STATUS_IDLE,
+					 POLL_INTERVAL_US,
+					 VBIF_AXI_HALT_ACK_TIMEOUT_US);
+		if (ret) {
+			dev_err(dev, "AXI bus port halt timeout\n");
+			return ret;
+		}
+
+		return 0;
+	}
+
 	/* Halt AXI and AXI IMEM VBIF Access */
 	val = venus_readl(hdev, VBIF_AXI_HALT_CTRL0);
 	val |= VBIF_AXI_HALT_CTRL0_HALT_REQ;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index d327b5cea334..c0b18de1e396 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -104,7 +104,9 @@
 
 #define WRAPPER_CPU_CLOCK_CONFIG		(WRAPPER_BASE + 0x2000)
 #define WRAPPER_CPU_AXI_HALT			(WRAPPER_BASE + 0x2008)
+#define WRAPPER_CPU_AXI_HALT_HALT		BIT(16)
 #define WRAPPER_CPU_AXI_HALT_STATUS		(WRAPPER_BASE + 0x200c)
+#define WRAPPER_CPU_AXI_HALT_STATUS_IDLE	BIT(24)
 
 #define WRAPPER_CPU_CGC_DIS			(WRAPPER_BASE + 0x2010)
 #define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
-- 
2.14.1

