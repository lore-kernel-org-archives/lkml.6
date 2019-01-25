Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1EC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50446218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/LMYkqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfAYXqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:46:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44415 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfAYXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:45:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so5416763pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zQrB5UHvwcxXHJ7bkEL+mhC1DvLfJAjrlhsTBR91TCw=;
        b=R/LMYkqyF0jZUQrVlCFbEReop77coHX8n6DSrLzu3Y3877OD1DCLSPl9M3sItyRRAH
         4iz32rLhx5cKwAEnrlQujqN1XKm8yU8fB1Zzc8NdfPCNsEwiptmS44P++4tQqfb+imCh
         glNsU5aW2GQwpGX+xaNyG7+CyVXvqJYwWxcJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zQrB5UHvwcxXHJ7bkEL+mhC1DvLfJAjrlhsTBR91TCw=;
        b=jCQJZ1GzjlNB4yJM+D7EfcHmQEuOBwC5IxuiS0ksv/bVbHa87X8tnHU3QtkoB8CCgw
         ZEc7T9JIJL2jsYP30OFywK0bUmBEo+u/jlzS7z3NT9UvJSdBKV8HCDmaVn8IBwJ05Wmg
         qNAYU9RjaNvfqQBvjXSvO5OrXAV8FFQ1Kpu0Jzta+RW+n8pE9d4bQB9eIObh9IDAhGjx
         IQLpu1io9XAONyy68Cu/6vI8k/JErouHherWVhnYUdG4Z9oX0QkUoy8tXGhd31oYjc7Y
         CstlxY+GerlnT5Z+yBuUC/PivbP7Lw5Vvruzl1aWg1Ns/Lvq+SR+rU5DKKeUJ15cw+Jj
         GrhA==
X-Gm-Message-State: AJcUukeYwPTyA2Kne8WOuDKVxTicodo3AhS7mPbkYpbObFe8suxBDCSn
        j9yMSEY++da3EPmk6Q1yTE+/Ag==
X-Google-Smtp-Source: ALg8bN6gH4kGnX+yK2J3Ruc65j3Mp4DfeHNxmfjUbFh5oXnuaS0NW1j/aXfrMbIAH5li80/FnrsCZw==
X-Received: by 2002:a62:109b:: with SMTP id 27mr12710072pfq.227.1548459942075;
        Fri, 25 Jan 2019 15:45:42 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:41 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 4/7] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Date:   Fri, 25 Jan 2019 15:45:06 -0800
Message-Id: <20190125234509.26419-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125234509.26419-1-bjorn.andersson@linaro.org>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before introducing the QCS404 platform, which uses the same PCIe
controller as IPQ4019, migrate this to use the bulk clock API, in order
to make the error paths slighly cleaner.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++-------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a7f703556790..9d366fad2b7f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -113,9 +113,8 @@ struct qcom_pcie_resources_2_3_2 {
 };
 
 struct qcom_pcie_resources_2_4_0 {
-	struct clk *aux_clk;
-	struct clk *master_clk;
-	struct clk *slave_clk;
+	struct clk_bulk_data clks[3];
+	int num_clks;
 	struct reset_control *axi_m_reset;
 	struct reset_control *axi_s_reset;
 	struct reset_control *pipe_reset;
@@ -638,18 +637,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "master_bus";
+	res->clks[2].id = "slave_bus";
 
-	res->master_clk = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_clk))
-		return PTR_ERR(res->master_clk);
+	res->num_clks = 3;
 
-	res->slave_clk = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
+	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
+	if (ret < 0)
+		return ret;
 
 	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
 	if (IS_ERR(res->axi_m_reset))
@@ -719,9 +717,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_m_sticky_reset);
 	reset_control_assert(res->pwr_reset);
 	reset_control_assert(res->ahb_reset);
-	clk_disable_unprepare(res->aux_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->slave_clk);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
@@ -850,23 +846,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	usleep_range(10000, 12000);
 
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	if (ret)
 		goto err_clk_aux;
-	}
-
-	ret = clk_prepare_enable(res->master_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->slave_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_clk_axi_s;
-	}
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
@@ -891,10 +873,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	return 0;
 
-err_clk_axi_s:
-	clk_disable_unprepare(res->master_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->aux_clk);
 err_clk_aux:
 	reset_control_assert(res->ahb_reset);
 err_rst_ahb:
-- 
2.18.0

