Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986DBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594912175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9ffUrB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfA2XUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:20:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45050 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfA2XUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so10412124pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vQtj1RgLOJyVWqjP3LDkxERM3vqDYFSOf7eObwJSg24=;
        b=Q9ffUrB8MyrLTLQryg7TPORIXj6bKh2SleIX4oMTTZYXmdZFOJKJr8Xzah3M6WQKgt
         sgMO5VDe18cGf7arOZyfFl9uKVqDnZi5OLkAAn2fRwE9kzVHqwIpI2BUiIjj6cel64eF
         hNdGKnV5RSkIYHeDcQ98L4Eu/5fbmwWiot+Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vQtj1RgLOJyVWqjP3LDkxERM3vqDYFSOf7eObwJSg24=;
        b=ioHp1bWpzPmWPBGNVttTo7bHtr+MttEXvhiFj+2fMXIsDb6zTvwQ+MtSwnAuBAd0kU
         md02VsUqV+S+Zl19OvQxv/5VT+4s8MZ8zjjvwFW9nGMcc4V7lqvbIhku5JsXL76ZPB3c
         6VoqxPtbZ3x1ownVRPyEnq3bfvzDFx0Uw1/e91zK2oE1jdfawIkb0JQjNK3Q1rXls59r
         vF71TpdUFSZ2etOIbMaLc2TbOytyOUHdK5X9k96OcT+x8zDEAiLZ3FySw16062dUo05J
         2hZOlI3Q7kUjJbiC0r/yPRzaSIwmk4G+6eMVuvnzRQwBYDgbNgaIpyJyuHBIakSrgiMf
         VVKA==
X-Gm-Message-State: AJcUukdi+XW8NxZ5bPkBMNqXajLVG3dKYi7Ydx992hbYGJ8p8tetPBgB
        H68/8Pq3CvGcrBurO2dr7nGv98mnbQg=
X-Google-Smtp-Source: ALg8bN5E4LcJ/H0MbKg8dnP1hzyGa2GVV1NY3TunVjlbZ04F8TOcAoxf53Mha6GArHwQ0091g3HRBg==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr28375511pfc.209.1548804038241;
        Tue, 29 Jan 2019 15:20:38 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 07/10] remoteproc: q6v5-mss: Vote for rpmh power domains
Date:   Tue, 29 Jan 2019 15:20:06 -0800
Message-Id: <20190129232009.5033-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

With rpmh ARC resources being modelled as power domains with performance
state, we need to proxy vote on these for SDM845.
Add support to vote on multiple of them, now that genpd supports
associating mutliple power domains to a device.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
[bjorn: Drop device link, improve error handling, name things "proxy"]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Rebased upon latest remoteproc branch

 drivers/remoteproc/qcom_q6v5_mss.c | 119 +++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 07d1cc52a647..c32c63e351a0 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -25,6 +25,8 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
@@ -131,6 +133,7 @@ struct rproc_hexagon_res {
 	char **proxy_clk_names;
 	char **reset_clk_names;
 	char **active_clk_names;
+	char **proxy_pd_names;
 	int version;
 	bool need_mem_protection;
 	bool has_alt_reset;
@@ -156,9 +159,11 @@ struct q6v5 {
 	struct clk *active_clks[8];
 	struct clk *reset_clks[4];
 	struct clk *proxy_clks[4];
+	struct device *proxy_pds[3];
 	int active_clk_count;
 	int reset_clk_count;
 	int proxy_clk_count;
+	int proxy_pd_count;
 
 	struct reg_info active_regs[1];
 	struct reg_info proxy_regs[3];
@@ -321,6 +326,41 @@ static void q6v5_clk_disable(struct device *dev,
 		clk_disable_unprepare(clks[i]);
 }
 
+static int q6v5_pds_enable(struct q6v5 *qproc, struct device **pds,
+			   size_t pd_count)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pd_count; i++) {
+		dev_pm_genpd_set_performance_state(pds[i], INT_MAX);
+		ret = pm_runtime_get_sync(pds[i]);
+		if (ret < 0)
+			goto unroll_pd_votes;
+	}
+
+	return 0;
+
+unroll_pd_votes:
+	for (i--; i >= 0; i--) {
+		dev_pm_genpd_set_performance_state(pds[i], 0);
+		pm_runtime_put(pds[i]);
+	}
+
+	return ret;
+};
+
+static void q6v5_pds_disable(struct q6v5 *qproc, struct device **pds,
+			     size_t pd_count)
+{
+	int i;
+
+	for (i = 0; i < pd_count; i++) {
+		dev_pm_genpd_set_performance_state(pds[i], 0);
+		pm_runtime_put(pds[i]);
+	}
+}
+
 static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int *current_perm,
 				   bool remote_owner, phys_addr_t addr,
 				   size_t size)
@@ -690,11 +730,17 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 
 	qcom_q6v5_prepare(&qproc->q6v5);
 
+	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+	if (ret < 0) {
+		dev_err(qproc->dev, "failed to enable proxy power domains\n");
+		goto disable_irqs;
+	}
+
 	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
 				    qproc->proxy_reg_count);
 	if (ret) {
 		dev_err(qproc->dev, "failed to enable proxy supplies\n");
-		goto disable_irqs;
+		goto disable_proxy_pds;
 	}
 
 	ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
@@ -791,6 +837,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 disable_proxy_reg:
 	q6v5_regulator_disable(qproc, qproc->proxy_regs,
 			       qproc->proxy_reg_count);
+disable_proxy_pds:
+	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 disable_irqs:
 	qcom_q6v5_unprepare(&qproc->q6v5);
 
@@ -841,6 +889,8 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 
 	ret = qcom_q6v5_unprepare(&qproc->q6v5);
 	if (ret) {
+		q6v5_pds_disable(qproc, qproc->proxy_pds,
+				 qproc->proxy_pd_count);
 		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
 				 qproc->proxy_clk_count);
 		q6v5_regulator_disable(qproc, qproc->proxy_regs,
@@ -1121,6 +1171,7 @@ static void qcom_msa_handover(struct qcom_q6v5 *q6v5)
 			 qproc->proxy_clk_count);
 	q6v5_regulator_disable(qproc, qproc->proxy_regs,
 			       qproc->proxy_reg_count);
+	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 }
 
 static int q6v5_init_mem(struct q6v5 *qproc, struct platform_device *pdev)
@@ -1181,6 +1232,45 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
 	return i;
 }
 
+static int q6v5_pds_attach(struct device *dev, struct device **devs,
+			   char **pd_names)
+{
+	size_t num_pds = 0;
+	int ret;
+	int i;
+
+	if (!pd_names)
+		return 0;
+
+	while (pd_names[num_pds])
+		num_pds++;
+
+	for (i = 0; i < num_pds; i++) {
+		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
+		if (IS_ERR(devs[i])) {
+			ret = PTR_ERR(devs[i]);
+			goto unroll_attach;
+		}
+	}
+
+	return num_pds;
+
+unroll_attach:
+	for (i--; i >= 0; i--)
+		dev_pm_domain_detach(devs[i], false);
+
+	return ret;
+};
+
+static void q6v5_pds_detach(struct q6v5 *qproc, struct device **pds,
+			    size_t pd_count)
+{
+	int i;
+
+	for (i = 0; i < pd_count; i++)
+		dev_pm_domain_detach(pds[i], false);
+}
+
 static int q6v5_init_reset(struct q6v5 *qproc)
 {
 	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
@@ -1322,10 +1412,18 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->active_reg_count = ret;
 
+	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
+			      desc->proxy_pd_names);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to init power domains\n");
+		goto free_rproc;
+	}
+	qproc->proxy_pd_count = ret;
+
 	qproc->has_alt_reset = desc->has_alt_reset;
 	ret = q6v5_init_reset(qproc);
 	if (ret)
-		goto free_rproc;
+		goto detach_proxy_pds;
 
 	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
@@ -1333,7 +1431,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
 			     qcom_msa_handover);
 	if (ret)
-		goto free_rproc;
+		goto detach_proxy_pds;
 
 	qproc->mpss_perm = BIT(QCOM_SCM_VMID_HLOS);
 	qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
@@ -1343,15 +1441,17 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12);
 	if (IS_ERR(qproc->sysmon)) {
 		ret = PTR_ERR(qproc->sysmon);
-		goto free_rproc;
+		goto detach_proxy_pds;
 	}
 
 	ret = rproc_add(rproc);
 	if (ret)
-		goto free_rproc;
+		goto detach_proxy_pds;
 
 	return 0;
 
+detach_proxy_pds:
+	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 free_rproc:
 	rproc_free(rproc);
 
@@ -1368,6 +1468,9 @@ static int q6v5_remove(struct platform_device *pdev)
 	qcom_remove_glink_subdev(qproc->rproc, &qproc->glink_subdev);
 	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
 	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
+
+	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+
 	rproc_free(qproc->rproc);
 
 	return 0;
@@ -1392,6 +1495,12 @@ static const struct rproc_hexagon_res sdm845_mss = {
 			"mnoc_axi",
 			NULL
 	},
+	.proxy_pd_names = (char*[]){
+			"cx",
+			"mx",
+			"mss",
+			NULL
+	},
 	.need_mem_protection = true,
 	.has_alt_reset = true,
 	.version = MSS_SDM845,
-- 
2.18.0

