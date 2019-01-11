Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9C02084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CjMzx0Do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfAKXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39798 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAKXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:02:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so7393145pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOOFwetSMIBvpMYFsSAVPOjhWY66CwtEkheZqPuAnCw=;
        b=CjMzx0DotOnpd53gSlv6HqUbEcYbmnXgZ/YgLHWG4qd611lHvxlBMQPeWCxdCxIWk+
         /edOMmhskWR9VVGdOC4SXThu7gul61WHKN1EolPu0PRkCOhcCgUrgGBKosMCIyIl+8YR
         mwdk4KrImc7ZIoBu6UQBll++cPc5QyswBRPZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOOFwetSMIBvpMYFsSAVPOjhWY66CwtEkheZqPuAnCw=;
        b=U31GoT3CIA1dI5Z/vD8xRI1z7NvKISsaPfcUJixj7agp1MYHCtWC0UKzRgb2asI0e5
         JksUg5aCueCS9a8PVzN24q44xHZQ6LUMNBP1ufhlfJCJNhPxoZfZt3Wyn7o8idYuP4k8
         4Nf2TBFiH/PvrGVSFG5GNi67Yjw0FokS4JI4kM2oKMEoeY3wesGYp5nB7Ej8aTt8g0Lo
         NM7PaVIDkEBKulrIuztLRUutdbgv4cAgr4o612gqiZsw9gWQqbwYdUf6Ko8lTiug8qHu
         ZyBl3XrCfmC9OePFXcVbqGsg0v+3T6uIhplS9oYP2BezntECcjR+civihFL6AdI3jZIS
         aiHw==
X-Gm-Message-State: AJcUukccuFmESrs/ziyxyH0c3UNsEqhXFscBNXl0FaJJwve2h0o00mRu
        dncbwS949NBHVEguqo6d6qr65g==
X-Google-Smtp-Source: ALg8bN75hdGXOclrAIaana1gShGmyzKXzXIqVVrVPTcuJRcgsyDsIRArj9KCog568IdtsjODjNk2vA==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr16363125plo.133.1547247734447;
        Fri, 11 Jan 2019 15:02:14 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:02:13 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v1 6/8] phy: qcom-qmp: Utilize UFS reset controller
Date:   Fri, 11 Jan 2019 15:01:27 -0800
Message-Id: <20190111230129.127037-7-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request the newly minted reset controller from the Qualcomm UFS
controller, and use it to toggle the PHY reset line from within
the PHY. This will allow us to merge the two phases of UFS PHY
initialization.

Signed-off-by: Evan Green <evgreen@chromium.org>

---
Note: this change is dependent on the previous changes, including
the DT changes, in order to expose the reset controller from UFS.

 drivers/phy/qualcomm/phy-qcom-qmp.c | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b4006818e1b65..eb1cac8f0fd4e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -739,6 +739,9 @@ struct qmp_phy_cfg {
 
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
+
+	/* true if the PHY has a UFS reset control to toggle */
+	bool has_ufsphy_reset;
 };
 
 /**
@@ -787,6 +790,7 @@ struct qmp_phy {
  * @init_count: phy common block initialization count
  * @phy_initialized: indicate if PHY has been initialized
  * @mode: current PHY mode
+ * @ufs_reset: optional UFS PHY reset handle
  */
 struct qcom_qmp {
 	struct device *dev;
@@ -804,6 +808,8 @@ struct qcom_qmp {
 	int init_count;
 	bool phy_initialized;
 	enum phy_mode mode;
+
+	struct reset_control *ufs_reset;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -1034,6 +1040,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 
 	.is_dual_lane_phy	= true,
 	.no_pcs_sw_reset	= true,
+
+	.has_ufsphy_reset	= true,
 };
 
 static void qcom_qmp_phy_configure(void __iomem *base,
@@ -1177,6 +1185,9 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
 		return 0;
 	}
 
+	if (qmp->ufs_reset)
+		reset_control_assert(qmp->ufs_reset);
+
 	if (cfg->has_phy_com_ctrl) {
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
 			     SERDES_START | PCS_START);
@@ -1214,6 +1225,32 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
 
+	if (cfg->has_ufsphy_reset) {
+		/*
+		 * Get UFS reset, which is delayed until now to avoid a
+		 * circular dependency where UFS needs its PHY, but the PHY
+		 * needs this UFS reset.
+		 */
+		if (!qmp->ufs_reset) {
+			qmp->ufs_reset = of_reset_control_get(qmp->dev->of_node,
+							      "ufsphy");
+
+			if (IS_ERR(qmp->ufs_reset)) {
+				dev_err(qmp->dev,
+					"failed to get UFS reset: %d\n",
+					PTR_ERR(qmp->ufs_reset));
+
+				return PTR_ERR(qmp->ufs_reset);
+			}
+		}
+
+		ret = reset_control_assert(qmp->ufs_reset);
+		if (ret) {
+			dev_err(qmp->dev, "ufsphy reset deassert failed\n");
+			goto err_lane_rst;
+		}
+	}
+
 	ret = qcom_qmp_phy_com_init(qphy);
 	if (ret)
 		return ret;
@@ -1247,6 +1284,14 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
+	if (qmp->ufs_reset) {
+		ret = reset_control_deassert(qmp->ufs_reset);
+		if (ret) {
+			dev_err(qmp->dev, "ufsphy reset deassert failed\n");
+			goto err_lane_rst;
+		}
+	}
+
 	/*
 	 * UFS PHY requires the deassert of software reset before serdes start.
 	 * For UFS PHYs that do not have software reset control bits, defer
-- 
2.18.1

