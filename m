Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78820C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E94B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XxRw3bHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfAWWM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33473 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfAWWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so1716089pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvnvwhNvCGrSis6JRGT93tM/S42bc8wz6EQE7IemcyQ=;
        b=XxRw3bHNlF6NBKGqF02v1JZhgh/AvBgaSawZ2Vq78Yry4D1p+U7RK813XjCqQhfH6D
         Dl+alGwbpBl6GnCzvB9giwb9EBmfrgPoknF00thSKtE9PMDrCwcVRPAAzZRvVzh2roSb
         l8sx1yL9eazR4wE71xnwisqxlcqWu0zsbSTeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvnvwhNvCGrSis6JRGT93tM/S42bc8wz6EQE7IemcyQ=;
        b=Hc0qjkOmTVQwm2FoKfMKw8zuBvJgApvhTqMgnglH7bJLLtaDZcbTCKdQxBz3t8bXb5
         T1tNNdwJ4GR/uY+MY+R8LM7sQ8WI9nInv5vNoDMZMqkUHw/M+1dFmK6E1wQiQyWrBFPR
         iCAgOyLWW6/IWxU6ZwKMKqBC5AyhI7z4HFbR8/sJ2jISNI7dmqrf6XdeQclTQjihnFJI
         ZWe7Hi+QDXp4OXefAnQoyTARjoegxucPOuQs16YWs0pUmpJ9pW4aFpZAAMTbxgeaolSv
         OWT6U4ArsW1CHj3k5K54ztkILMJ0vJnfMlH64Ut0w0EnA7acZeaPRO5NOq5tiHgbTOus
         aToQ==
X-Gm-Message-State: AJcUukce7KJdUHHKQRv8zBoWbqwBbhbraJ63DgSqikgf3bXgw2fZQByQ
        IRIIljbYvlwVUpgbuGMJgprCBQ==
X-Google-Smtp-Source: ALg8bN4bfa6WwqHyYaLf2fCQJKAwb8bA8h5H6zbuRCgEwj9JgG2MRJOa8AGA3poGjFVSLq8w6hPeUQ==
X-Received: by 2002:a65:4381:: with SMTP id m1mr3603803pgp.358.1548281543926;
        Wed, 23 Jan 2019 14:12:23 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:23 -0800 (PST)
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
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v2 8/9] phy: qcom-qmp: Move UFS phy to phy_poweron/off
Date:   Wed, 23 Jan 2019 14:11:36 -0800
Message-Id: <20190123221137.41722-9-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For UFS, move the actual firing up of the PHY to phy_poweron and
phy_poweroff callbacks, rather than init/exit. UFS calls
phy_poweroff during suspend, so now all clocks and regulators for
the phy can be powered down during suspend.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v2:
- Removed whitespace changes (Stephen)

 drivers/phy/qualcomm/phy-qcom-qmp.c | 80 +++++++++--------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 721af5706fbb1..fa32b2837e708 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1346,8 +1346,7 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
 	return 0;
 }
 
-/* PHY Initialization */
-static int qcom_qmp_phy_init(struct phy *phy)
+static int qcom_qmp_phy_enable(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -1428,14 +1427,6 @@ static int qcom_qmp_phy_init(struct phy *phy)
 			goto err_lane_rst;
 	}
 
-	/*
-	 * UFS PHY requires the deassert of software reset before serdes start.
-	 * For UFS PHYs that do not have software reset control bits, defer
-	 * starting serdes until the power on callback.
-	 */
-	if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
-		goto out;
-
 	/*
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
@@ -1447,7 +1438,9 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
 
 	/* Pull PHY out of reset state */
-	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+	if (!cfg->no_pcs_sw_reset)
+		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
 	if (cfg->has_phy_dp_com_ctrl)
 		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
@@ -1464,11 +1457,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		goto err_pcs_ready;
 	}
 	qmp->phy_initialized = true;
-
-out:
-	return ret;
+	return 0;
 
 err_pcs_ready:
+	if (qmp->ufs_reset)
+		reset_control_assert(qmp->ufs_reset);
+
 	clk_disable_unprepare(qphy->pipe_clk);
 err_clk_enable:
 	if (cfg->has_lane_rst)
@@ -1479,7 +1473,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	return ret;
 }
 
-static int qcom_qmp_phy_exit(struct phy *phy)
+static int qcom_qmp_phy_disable(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -1507,44 +1501,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_poweron(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *pcs = qphy->pcs;
-	void __iomem *status;
-	unsigned int mask, val;
-	int ret = 0;
-
-	if (cfg->type != PHY_TYPE_UFS)
-		return 0;
-
-	/*
-	 * For UFS PHY that has not software reset control, serdes start
-	 * should only happen when UFS driver explicitly calls phy_power_on
-	 * after it deasserts software reset.
-	 */
-	if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
-	    (qmp->init_count != 0)) {
-		/* start SerDes and Phy-Coding-Sublayer */
-		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
-
-		status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
-		mask = cfg->mask_pcs_ready;
-
-		ret = readl_poll_timeout(status, val, !(val & mask), 1,
-					 PHY_INIT_COMPLETE_TIMEOUT);
-		if (ret) {
-			dev_err(qmp->dev, "phy initialization timed-out\n");
-			return ret;
-		}
-		qmp->phy_initialized = true;
-	}
-
-	return ret;
-}
-
 static int qcom_qmp_phy_set_mode(struct phy *phy,
 				 enum phy_mode mode, int submode)
 {
@@ -1794,9 +1750,15 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 }
 
 static const struct phy_ops qcom_qmp_phy_gen_ops = {
-	.init		= qcom_qmp_phy_init,
-	.exit		= qcom_qmp_phy_exit,
-	.power_on	= qcom_qmp_phy_poweron,
+	.init		= qcom_qmp_phy_enable,
+	.exit		= qcom_qmp_phy_disable,
+	.set_mode	= qcom_qmp_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops qcom_qmp_ufs_ops = {
+	.power_on	= qcom_qmp_phy_enable,
+	.power_off	= qcom_qmp_phy_disable,
 	.set_mode	= qcom_qmp_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
@@ -1807,6 +1769,7 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
+	const struct phy_ops *ops = &qcom_qmp_phy_gen_ops;
 	char prop_name[MAX_PROP_NAME];
 	int ret;
 
@@ -1893,7 +1856,10 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 		}
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_gen_ops);
+	if (qmp->cfg->type == PHY_TYPE_UFS)
+		ops = &qcom_qmp_ufs_ops;
+
+	generic_phy = devm_phy_create(dev, np, ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
 		dev_err(dev, "failed to create qphy %d\n", ret);
-- 
2.18.1

