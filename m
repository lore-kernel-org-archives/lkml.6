Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E667C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646FA2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FK7a1zOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfA2XUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:20:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38488 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbfA2XUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so9450153pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+VB4lYf9DNI0f5oxIEKDuBpa7GNxZTlTEpIziZQr2lk=;
        b=FK7a1zOH+uDiPanqJJPgFQlERDW5djLwpFLeN7Z2c1/2lJ/xPoSynfnEbwPnHTlDvk
         IqVKTreSXLXARjzAQntWrAqb932VVEj4lJP9L9+oNTcVHo3vMhb7nweJrlTbJrEXvOZb
         gq0BbHPcby5ijOA8fxpYJhQmjiVteLp41lz7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+VB4lYf9DNI0f5oxIEKDuBpa7GNxZTlTEpIziZQr2lk=;
        b=Tjzj5C3vPS5xb0tfZLS9WMASnX+SfnWi1kBavN75oMI5JZeK7Fc1/iICBRIr9cwJmY
         TM5dkOfDB7UergT3vDGB6GM8xtKOsl82CvDoY7aMRF0HsfZBQxxEKvh994MuX9LjqzVY
         pxnA1JHBpsdW9VGXyjY5ZDYQqiD7Iw1Gm9rxPjZPSMrmjyN18ubbSWFBvsjWv37xKn/b
         UTFBWjwXFWsQPkewE3Dqh6/6oyDRCsfUcCZ6UwyHe5V2Lp7kwq1TSu+aXZhhVCEbCymv
         ktvpNyQ68NtD+JbfvOuqQsMjMKlUokLel0G3bGibdjRBshQJNCuevw1kCS7qeC11lAIT
         AUtQ==
X-Gm-Message-State: AJcUukckeyWW3NKwc9118Nt/JD1po0M0CCWBAbyszaPAl+7TUp5ZSpt/
        IEY2Cv5/SuLk4bfZjFf61jHv+Q==
X-Google-Smtp-Source: ALg8bN4APlbkY/m3CNOxFm8ZGr/1BRrf/EeX3zrxVM+OuW3bzFUJgSgvGvSU0IeHusaY44sgXUEIUA==
X-Received: by 2002:a63:111c:: with SMTP id g28mr25113118pgl.85.1548804039696;
        Tue, 29 Jan 2019 15:20:39 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:38 -0800 (PST)
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
Subject: [PATCH v4 08/10] remoteproc: q6v5-mss: Active powerdomain for SDM845
Date:   Tue, 29 Jan 2019 15:20:07 -0800
Message-Id: <20190129232009.5033-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 MSS needs the load_state powerdomain voted for during the
duration of the MSS being powered on, to let the AOSS know that it may
not perform certain power save measures. So vote for this.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- None

 drivers/remoteproc/qcom_q6v5_mss.c | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index c32c63e351a0..e30f5486fd20 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -133,6 +133,7 @@ struct rproc_hexagon_res {
 	char **proxy_clk_names;
 	char **reset_clk_names;
 	char **active_clk_names;
+	char **active_pd_names;
 	char **proxy_pd_names;
 	int version;
 	bool need_mem_protection;
@@ -159,10 +160,12 @@ struct q6v5 {
 	struct clk *active_clks[8];
 	struct clk *reset_clks[4];
 	struct clk *proxy_clks[4];
+	struct device *active_pds[1];
 	struct device *proxy_pds[3];
 	int active_clk_count;
 	int reset_clk_count;
 	int proxy_clk_count;
+	int active_pd_count;
 	int proxy_pd_count;
 
 	struct reg_info active_regs[1];
@@ -730,10 +733,16 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 
 	qcom_q6v5_prepare(&qproc->q6v5);
 
+	ret = q6v5_pds_enable(qproc, qproc->active_pds, qproc->active_pd_count);
+	if (ret < 0) {
+		dev_err(qproc->dev, "failed to enable active power domains\n");
+		goto disable_irqs;
+	}
+
 	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 	if (ret < 0) {
 		dev_err(qproc->dev, "failed to enable proxy power domains\n");
-		goto disable_irqs;
+		goto disable_active_pds;
 	}
 
 	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
@@ -839,6 +848,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 			       qproc->proxy_reg_count);
 disable_proxy_pds:
 	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+disable_active_pds:
+	q6v5_pds_disable(qproc, qproc->active_pds, qproc->active_pd_count);
 disable_irqs:
 	qcom_q6v5_unprepare(&qproc->q6v5);
 
@@ -878,6 +889,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 			 qproc->active_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
+	q6v5_pds_disable(qproc, qproc->active_pds, qproc->active_pd_count);
 
 	/* In case of failure or coredump scenario where reclaiming MBA memory
 	 * could not happen reclaim it here.
@@ -1412,11 +1424,19 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->active_reg_count = ret;
 
+	ret = q6v5_pds_attach(&pdev->dev, qproc->active_pds,
+			      desc->active_pd_names);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to attach active power domains\n");
+		goto free_rproc;
+	}
+	qproc->active_pd_count = ret;
+
 	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
 			      desc->proxy_pd_names);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to init power domains\n");
-		goto free_rproc;
+		goto detach_active_pds;
 	}
 	qproc->proxy_pd_count = ret;
 
@@ -1452,6 +1472,8 @@ static int q6v5_probe(struct platform_device *pdev)
 
 detach_proxy_pds:
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
+detach_active_pds:
+	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
 free_rproc:
 	rproc_free(rproc);
 
@@ -1469,6 +1491,7 @@ static int q6v5_remove(struct platform_device *pdev)
 	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
 	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
 
+	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 
 	rproc_free(qproc->rproc);
@@ -1495,6 +1518,10 @@ static const struct rproc_hexagon_res sdm845_mss = {
 			"mnoc_axi",
 			NULL
 	},
+	.active_pd_names = (char*[]){
+			"load_state",
+			NULL
+	},
 	.proxy_pd_names = (char*[]){
 			"cx",
 			"mx",
-- 
2.18.0

