Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 89118C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FD2208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZO0Faoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FD2208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965042AbeFNVzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:55:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53138 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965023AbeFNVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so410933wmb.2;
        Thu, 14 Jun 2018 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieEMVoRfoQhfxE+IpQp08MjWf/guXO0i0UaAfjgC4m0=;
        b=DZO0FaozbW+wgJ+kpL5zPyLsnzKLnGEZFVQOFK1WTMB0h3+dmYSmCMXvaECSR644q6
         Bt7KhOjax6/07TAO6u4B8oNvsov5f04yakxtZtJ5LLfksea74Ew0YqfPBeRiP67Lrm74
         gBTYT36d6vLY0fN661xhWoO0K3NJXWTEbZ2LTvQaVEdKzLtf+YMeAxN5QXgrxoOQN0nB
         yaOHiHvE9EEWYu0+mBXPrQ97Co2vwhc1B5T0lU3geOvqhGMjOf7P/gVauxNcKOOxCJTE
         6DKO38HlBX7OYQSAzKR56gotjX3RZjpi1uAGTGdAwHdOZqljx5+P6w8StcGFfwhvQ9y5
         nsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieEMVoRfoQhfxE+IpQp08MjWf/guXO0i0UaAfjgC4m0=;
        b=gDr+oMzxbPEKk3v7o7xtIoGaz23tF95RGyHGLhwKRQZ46sYbI1FIoqki6OXzN1WbDI
         OMviCUD5tGHOoep38yVT3S3Vq4nJJ8A88qSWyrwfiq1q1KLWhVGpxB5VTlRINKyoQ+g6
         93GeA/pqN0Uz4sndAI4CLhMCTNu5k6Xq5b4mqzsXjBS4RuQlvA51wPJxK3Zu2Gqep2Sv
         bX8M2AHgr8UDIe2XtcbtxRTczvosvc6zvmxPyZBzaI1ndU/Ng0iDfFSdFrokXtQMHhMt
         avHIa+NGjyKYZIBZnrQU3dSCKnVAuxFSIE99VxvFyf6mts7f3d6RFS/I2DYaX1QsedV+
         8ybQ==
X-Gm-Message-State: APt69E1fADP60g8l8hirYX9vHRwvG8a2R8iLdDQ+RvZPBbWFSC8YWooO
        hpHI3se0JlAezoo5aJIz2uA=
X-Google-Smtp-Source: ADUXVKL1T5V0UMiZ0MG6E4pK8GZqR1GOwaLxhP+MFb8pzU6K0Taof96Fmd0ipEuIZ1PRvm/pmxDSxw==
X-Received: by 2002:a1c:eccb:: with SMTP id h72-v6mr2991411wmi.157.1529013335832;
        Thu, 14 Jun 2018 14:55:35 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:35 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 6/8] clk: qcom: cpu-8996: Add support to switch to alternate PLL
Date:   Thu, 14 Jun 2018 23:53:53 +0200
Message-Id: <20180614215358.11264-7-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Each of the CPU clusters on msm8996 are powered via a primary
PLL and a secondary PLL. The primary PLL is what drives the
CPU clk, except for times when we are reprogramming the PLL
itself, when we temporarily switch to an alternate PLL.
Use clock rate change notifiers to support this.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index d92cad93af20..620fdc2266ba 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -52,6 +52,7 @@
  * detect voltage droops.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -178,10 +179,14 @@ struct clk_cpu_8996_mux {
 	u32	reg;
 	u8	shift;
 	u8	width;
+	struct notifier_block nb;
 	struct clk_hw	*pll;
 	struct clk_regmap clkr;
 };
 
+#define to_clk_cpu_8996_mux_nb(_nb) \
+	container_of(_nb, struct clk_cpu_8996_mux, nb)
+
 static inline
 struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
 {
@@ -227,6 +232,26 @@ clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	return 0;
 }
 
+int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
+			void *data)
+{
+	int ret;
+	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		break;
+	case POST_RATE_CHANGE:
+		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return notifier_from_errno(ret);
+};
 const struct clk_ops clk_cpu_8996_mux_ops = {
 	.set_parent = clk_cpu_8996_mux_set_parent,
 	.get_parent = clk_cpu_8996_mux_get_parent,
@@ -270,6 +295,7 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
 		.parent_names = (const char *[]){
@@ -289,6 +315,7 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
 		.parent_names = (const char *[]){
@@ -347,6 +374,12 @@ qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
 	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
 	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
 
+	ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
+	if (ret)
+		return ret;
+
+	ret = clk_notifier_register(perfcl_pmux.clkr.hw.clk, &perfcl_pmux.nb);
+
 	return ret;
 }
 
-- 
2.11.0

