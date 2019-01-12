Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA2BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C4B2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOtf/dFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfALPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:39:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:39:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so18280619wra.6;
        Sat, 12 Jan 2019 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=nMwqmyNYMU4Y77Zqh2k3EBCoarap/68KCGLgVioocUU=;
        b=SOtf/dFAR8yU+SCrjfEVybTk0f5OPYc9/sOa4FPSKMfsU++g/Z6keAeEG7Hs2WE+bn
         AMsKOwbSs1mBedpRDdIVhOQWAlnXFtkav3VDgjaGOtd4Ao9vimBcfYPyO7cPKl3H8eL2
         iCQhzHy1Mq/uUXbZK+gnMyJAqe1rptq+SscyD+zo0aPFYXP9PRjW8vl4HMumN4uSI4gT
         sGPfTWvtJzdmjKp9FxjF4Q9U6IGEtwtpi2rnPuwsSa736DmLlcnOA9KgzdZLgsMZF/0j
         odPmdQRM3XOqfMsfpvgNG2LtHaQLePehKGzsGkjCf5g3InTVeuh1tKhPmQni494LfR5R
         Sfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=nMwqmyNYMU4Y77Zqh2k3EBCoarap/68KCGLgVioocUU=;
        b=q477d5i+t/SVxiK9Xga9GmAS1rvPjkOlmO6xH0NDD3gHS3IfJji2WRm0uSl1JypeyR
         nCJuO7oLgOe5IDhADzBaJtpOhPQEAKCvwsOOZD710MlNAVSsrwXvwyHIKhGSmOjMWcZp
         HUlc5i+kNM0zIQHoAM45S1MSVwQW7O+RNiNxI82DQx2bvNIVJ3wbddXmgS4msbl2KJVz
         Xqo+LJAxwSGRXUQD+4Gg2fkgoLCiQ7uXvA9zJ2r6k9HZuoOfb3BeXKLKXM6xmzjweuua
         xAlw85NuuV3O8W05sWf1oR1rZRwMiMs326aW/C1Nf3xXNONOWQ7wdxpfeIEB4lx/hm2+
         pIBg==
X-Gm-Message-State: AJcUukcBgRId2b/yO76urgJrUIqbc/s1Vg0MV/eX6VkfAgKGI8keK/Rl
        63R8kBsHg/7/XMdDWPumrhc=
X-Google-Smtp-Source: ALg8bN5NvFDYedcXTEQaePlc7FQiN2bOqTlXR+oWXim4hbsCsfc228aBI8cM06FJb1BwFkCOncZeZA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr16643422wrq.108.1547307540319;
        Sat, 12 Jan 2019 07:39:00 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
        by smtp.gmail.com with ESMTPSA id u204sm38589501wmu.30.2019.01.12.07.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 07:38:59 -0800 (PST)
Message-ID: <2fcdf0e9b1eef55350911984064dd94f16f1fcd8.camel@gmail.com>
Subject: [PATCH] clk: qcom: smd: Add support for MSM8956/76 RPM clocks
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Date:   Sat, 12 Jan 2019 16:38:58 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 6aeefad77a2a5d47a9bd009d2d10db2a5dd153a2 Mon Sep 17 00:00:00 2001
From: "Angelo G. Del Regno" <kholk11@gmail.com>
Date: Sat, 12 Jan 2019 16:31:09 +0100
Subject: [PATCH] clk: qcom: smd: Add support for MSM8956/76 RPM clocks

Add all RPM clocks found on MSM8956/MSM8976 SoCs.

Signed-off-by: Angelo G. Del Regno <kholk11@gmail.com>
---
 .../devicetree/bindings/clock/qcom,rpmcc.txt  |  1 +
 drivers/clk/qcom/clk-smd-rpm.c                | 53 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index 87b4949e9bc8..2aebc4db54f3 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -15,6 +15,7 @@ Required properties :
 			"qcom,rpmcc-msm8916", "qcom,rpmcc"
 			"qcom,rpmcc-msm8974", "qcom,rpmcc"
 			"qcom,rpmcc-apq8064", "qcom,rpmcc"
+			"qcom,rpmcc-msm8976", "qcom,rpmcc"
 			"qcom,rpmcc-msm8996", "qcom,rpmcc"
 			"qcom,rpmcc-qcs404", "qcom,rpmcc"
 
diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index d3aadaeb2903..b916435e2759 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -531,6 +531,58 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
 	.num_clks = ARRAY_SIZE(msm8974_clks),
 };
 
+/* msm8976 */
+DEFINE_CLK_SMD_RPM_BRANCH(msm8976, cxo, cxo_a,
+				QCOM_SMD_RPM_MISC_CLK, 0, 19200000);
+DEFINE_CLK_SMD_RPM(msm8976, bimc_clk, bimc_a_clk, QCOM_SMD_RPM_MEM_CLK, 0);
+DEFINE_CLK_SMD_RPM(msm8976, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
+DEFINE_CLK_SMD_RPM(msm8976, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
+DEFINE_CLK_SMD_RPM(msm8976, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
+DEFINE_CLK_SMD_RPM(msm8976, mmssnoc_axi_clk, mmssnoc_axi_a_clk,
+				QCOM_SMD_RPM_BUS_CLK, 2);
+DEFINE_CLK_SMD_RPM_QDSS(msm8976, qdss_clk, qdss_a_clk,
+				QCOM_SMD_RPM_MISC_CLK, 1);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8976, bb_clk1, bb_clk1_a, 0x1);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8976, bb_clk2, bb_clk2_a, 0x2);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8976, rf_clk2, rf_clk2_a, 0x5);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8976, div_clk2, div_clk2_a, 0xC);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8976, bb_clk1_pin, bb_clk1_a_pin, 1);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8976, bb_clk2_pin, bb_clk2_a_pin, 2);
+
+static struct clk_smd_rpm *msm8976_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &msm8976_cxo,
+	[RPM_SMD_XO_A_CLK_SRC] = &msm8976_cxo_a,
+	[RPM_SMD_BIMC_CLK] = &msm8976_bimc_clk,
+	[RPM_SMD_BIMC_A_CLK] = &msm8976_bimc_a_clk,
+	[RPM_SMD_MMAXI_CLK] = &msm8976_mmssnoc_axi_clk,
+	[RPM_SMD_MMAXI_A_CLK] = &msm8976_mmssnoc_axi_a_clk,
+	[RPM_SMD_IPA_CLK] = &msm8976_ipa_clk,
+	[RPM_SMD_IPA_A_CLK] = &msm8976_ipa_a_clk,
+	[RPM_SMD_PCNOC_CLK] = &msm8976_pcnoc_clk,
+	[RPM_SMD_PCNOC_A_CLK] = &msm8976_pcnoc_a_clk,
+	[RPM_SMD_SNOC_CLK] = &msm8976_snoc_clk,
+	[RPM_SMD_SNOC_A_CLK] = &msm8976_snoc_a_clk,
+	[RPM_SMD_QDSS_CLK] = &msm8976_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &msm8976_qdss_a_clk,
+	[RPM_SMD_BB_CLK1] = &msm8976_bb_clk1,
+	[RPM_SMD_BB_CLK1_A] = &msm8976_bb_clk1_a,
+	[RPM_SMD_BB_CLK1_PIN] = &msm8976_bb_clk1_pin,
+	[RPM_SMD_BB_CLK1_A_PIN] = &msm8976_bb_clk1_a_pin,
+	[RPM_SMD_BB_CLK2] = &msm8976_bb_clk2,
+	[RPM_SMD_BB_CLK2_A] = &msm8976_bb_clk2_a,
+	[RPM_SMD_BB_CLK2_PIN] = &msm8976_bb_clk2_pin,
+	[RPM_SMD_BB_CLK2_A_PIN] = &msm8976_bb_clk2_a_pin,
+	[RPM_SMD_RF_CLK2] = &msm8976_rf_clk2,
+	[RPM_SMD_RF_CLK2_A] = &msm8976_rf_clk2_a,
+	[RPM_SMD_DIV_CLK2] = &msm8976_div_clk2,
+	[RPM_SMD_DIV_A_CLK2] = &msm8976_div_clk2_a,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_msm8976 = {
+	.clks = msm8976_clks,
+	.num_clks = ARRAY_SIZE(msm8976_clks),
+};
+
 /* msm8996 */
 DEFINE_CLK_SMD_RPM(msm8996, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
 DEFINE_CLK_SMD_RPM(msm8996, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
@@ -658,6 +710,7 @@ static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
 static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
 	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
+	{ .compatible = "qcom,rpmcc-msm8976", .data = &rpm_clk_msm8976 },
 	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
 	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
 	{ }
-- 
2.19.1


