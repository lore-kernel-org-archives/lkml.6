Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49008C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64AB2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HKFYjLF9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SBW9IRok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64AB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKUAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:00:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:00:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D77E60227; Tue, 11 Dec 2018 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544558418;
        bh=b1cCFHkNyzpXw51nJO7Dp9Y78GDfx9moKasqPuTPQ+U=;
        h=From:To:Cc:Subject:Date:From;
        b=HKFYjLF9OAfBPZd5OcP9fdpWqwareXKQqVsO7Gwy68joF1rAsgoTtnds/SAzB62tN
         Yjcbh6XBOeswhEtarsxwnccJP9tLwBpIyfxp3Oh9baHmCi810rsfpWEHOuOlQWWAav
         U7JZdR/wn+18JfU0Qzx7m2W45kgU0BB40ZzCZS1E=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9CAD60132;
        Tue, 11 Dec 2018 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544558417;
        bh=b1cCFHkNyzpXw51nJO7Dp9Y78GDfx9moKasqPuTPQ+U=;
        h=From:To:Cc:Subject:Date:From;
        b=SBW9IRokC5U79mzo9yMnS6P/r1rIL6Dxf3pHiHCrVjPvBVDDHmKqfquNago4E2OG0
         yNIuhCsX3XzmN+fdLMKpfngwdKm2LMwOlwzzuMJLEleMTgGyE+uofA00kzhkhBhekt
         /hVtO9Eniau9s3nf3tsjW1R3KkCevsMr6fbpNOXI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9CAD60132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sboyd@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] clk: qcom: Add missing msm8998 resets
Date:   Tue, 11 Dec 2018 13:00:04 -0700
Message-Id: <1544558404-1705-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c0cb7c7e7164 ("clk: qcom: Enumerate remaining msm8998 resets")
missed two USB2 resets.  Add them.

Fixes: c0cb7c7e7164 ("clk: qcom: Enumerate remaining msm8998 resets")
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---

Sorry, noticed this when working on USB.  I double checked the documentation
again, and I'm reasonably sure I got them all now.

 drivers/clk/qcom/gcc-msm8998.c               | 2 ++
 include/dt-bindings/clock/qcom,gcc-msm8998.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 5f989ee..f3c2ab4 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2827,6 +2827,8 @@ enum {
 	[GCC_MMSS_BCR] = { 0xb000 },
 	[GCC_QDSS_BCR] = { 0xc000 },
 	[GCC_WCSS_BCR] = { 0x11000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
 	[GCC_BLSP1_BCR] = { 0x17000 },
 	[GCC_BLSP1_UART1_BCR] = { 0x1a000 },
 	[GCC_BLSP1_UART2_BCR] = { 0x1c000 },
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index 958fe83..ba84bba 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -296,5 +296,7 @@
 #define GCC_GLM_BCR						103
 #define GCC_SKL_BCR						104
 #define GCC_MSMPU_BCR						105
+#define GCC_QUSB2PHY_PRIM_BCR					106
+#define GCC_QUSB2PHY_SEC_BCR					107
 
 #endif
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

