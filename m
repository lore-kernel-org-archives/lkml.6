Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03813C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97E72243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+mqrY17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97E72243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbeKMGVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:21:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36238 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:21:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so10819582wrs.3;
        Mon, 12 Nov 2018 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jf1wzNuzV+bOfaMyZTWfvnvVRhiebj+W0LYPCEcsELo=;
        b=S+mqrY17L7ElhWba5PRQ4PsBdhCONjtGkkEQ8DxpTtOs4gFpvONPLzFIKUkQhbFn3S
         qI6jQ7+vxWOuI23LzewhXu57umEw9uoNURZAPKKEKzHrleMIuKF+N4jeZvjtKAkES4fv
         GF9K5yb0y7JaedDPpitHgRew0ZKIkCqYwXDvZzOY9QKjUEoxgKdudS3bJ09waE4+ScV6
         T9wxRHMZ6svFuYTEYnX8ioAWBeZCER7up53XVs4XJ3u6j6UF38xInmxl+OKFpqVZXxeU
         VI/2A48wJA8N3GN7PsZnSc/ss7bvW82nL6LjRwarmrykH4nr31yPRfinqJmkBANhcgJ1
         UqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jf1wzNuzV+bOfaMyZTWfvnvVRhiebj+W0LYPCEcsELo=;
        b=qfxJkHtwButifdn65k7CNDRfeGnn48/aiBYSVj242IUdKFBmo357hlfvsFtPaiep09
         KYgvV+MRb785y8vAOtuui3jSWDROE0c7s3PbKktvBywp4RAZb8sfV9jQ5t5+2eRIBJrg
         of/rvHc4eF7ivdmSDeUvZO9bQtPBSJKeuBlw9TxPhTl06YR8piCnbWyAwVJvudSy6H26
         DDuB1ERPqOGmRUyIE6fLOD7+4BQXO+TqhLn0cDWCK3mZRWqZSjDMXcdVWm7ZJYm7SS5e
         L+NlSTSlKhy67MS9UN8mKy0OmhDPyxAHz/i7QthPBb8EWjGdPCGZrQcb28/+t2l+WZVq
         3/jg==
X-Gm-Message-State: AGRZ1gICiksH1WSmFYm0JuXefSkq0c5jZ1mayd7ThF3IIv/hUxQx3/r6
        XDXCB87Z4RXwVFsDEFWjYg==
X-Google-Smtp-Source: AJdET5cKEoV1ikDT33HDLbCxBvdsmM1wuJWxp2wgvbVVmUICdDH7AtGNeEZpscdl9xyFWvSoYkR7xA==
X-Received: by 2002:adf:bd0f:: with SMTP id j15-v6mr2233705wrh.267.1542054411402;
        Mon, 12 Nov 2018 12:26:51 -0800 (PST)
Received: from arch.home (host86-147-12-72.range86-147.btcentralplus.com. [86.147.12.72])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm34948582wmd.41.2018.11.12.12.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:26:50 -0800 (PST)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: sdm660: Set tile property for pingroups
Date:   Mon, 12 Nov 2018 20:25:53 +0000
Message-Id: <20181112202553.1410-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was missed when tiles support was added in a revison and
causes the driver to fail to load.

Fixes: 9cf0c526bc58 ("pinctrl: qcom: Add sdm660 pinctrl driver")
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-sdm660.c | 28 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660.c b/drivers/pinctrl/qcom/pinctrl-sdm660.c
index 6838b38555a1..1bfb0ae6b387 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm660.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
@@ -33,7 +33,7 @@ enum {
 	}
 
 
-#define PINGROUP(id, base, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
+#define PINGROUP(id, _tile, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
 	{					        \
 		.name = "gpio" #id,			\
 		.pins = gpio##id##_pins,		\
@@ -51,11 +51,12 @@ enum {
 			msm_mux_##f9			\
 		},				        \
 		.nfuncs = 10,				\
-		.ctl_reg = base + REG_SIZE * id,	\
-		.io_reg = base + 0x4 + REG_SIZE * id,		\
-		.intr_cfg_reg = base + 0x8 + REG_SIZE * id,		\
-		.intr_status_reg = base + 0xc + REG_SIZE * id,	\
-		.intr_target_reg = base + 0x8 + REG_SIZE * id,	\
+		.ctl_reg = REG_SIZE * id,		\
+		.io_reg = 0x4 + REG_SIZE * id,		\
+		.intr_cfg_reg = 0x8 + REG_SIZE * id,	\
+		.intr_status_reg = 0xc + REG_SIZE * id,	\
+		.intr_target_reg = 0x8 + REG_SIZE * id,	\
+		.tile = _tile,			\
 		.mux_bit = 2,			\
 		.pull_bit = 0,			\
 		.drv_bit = 6,			\
@@ -82,6 +83,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
+		.tile = NORTH,				\
 		.mux_bit = -1,				\
 		.pull_bit = pull,			\
 		.drv_bit = drv,				\
@@ -1397,13 +1399,13 @@ static const struct msm_pingroup sdm660_groups[] = {
 	PINGROUP(111, SOUTH, _, _, _, _, _, _, _, _, _),
 	PINGROUP(112, SOUTH, _, _, _, _, _, _, _, _, _),
 	PINGROUP(113, SOUTH, _, _, _, _, _, _, _, _, _),
-	SDC_QDSD_PINGROUP(sdc1_clk, 0x99a000, 13, 6),
-	SDC_QDSD_PINGROUP(sdc1_cmd, 0x99a000, 11, 3),
-	SDC_QDSD_PINGROUP(sdc1_data, 0x99a000, 9, 0),
-	SDC_QDSD_PINGROUP(sdc2_clk, 0x99b000, 14, 6),
-	SDC_QDSD_PINGROUP(sdc2_cmd, 0x99b000, 11, 3),
-	SDC_QDSD_PINGROUP(sdc2_data, 0x99b000, 9, 0),
-	SDC_QDSD_PINGROUP(sdc1_rclk, 0x99a000, 15, 0),
+	SDC_QDSD_PINGROUP(sdc1_clk, 0x9a000, 13, 6),
+	SDC_QDSD_PINGROUP(sdc1_cmd, 0x9a000, 11, 3),
+	SDC_QDSD_PINGROUP(sdc1_data, 0x9a000, 9, 0),
+	SDC_QDSD_PINGROUP(sdc2_clk, 0x9b000, 14, 6),
+	SDC_QDSD_PINGROUP(sdc2_cmd, 0x9b000, 11, 3),
+	SDC_QDSD_PINGROUP(sdc2_data, 0x9b000, 9, 0),
+	SDC_QDSD_PINGROUP(sdc1_rclk, 0x9a000, 15, 0),
 };
 
 static const struct msm_pinctrl_soc_data sdm660_pinctrl = {
-- 
2.19.1

