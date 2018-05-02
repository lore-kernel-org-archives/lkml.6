Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295209-2-11950000628102214376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295208; b=ZncDpzRvGMIxgTrfqxacHpfst5poTzFxtDBGzHS2qdMD+0XMiY
    G8GQFwRaYbc/sG1IcQ7p6hEb8Eyo9jelQHsmMwFarhfwdZTLNHIdrlJwM3gCdrD/
    pgylpZJOy7HSZiS0BJfYMyYxaVsqVmZRcM1QEw5nsi6vEpTgIY2tjDy8gHpJ3dJR
    rMpmvSv8KlybPhhX5V8th+ZgKSCeX95RG4sF95DYxSl3dPUpK8EP/eVSbEQE6vLb
    yj6nBP59SlVpp/tdojJqm3n7v1Edfg1167ihL2oEINXMKEdArF3MlXzZ4JL8TaA4
    PB691yTG9h9mCGJCk4zaUue9v2B431dMuOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295208; bh=
    kB5irY1wcdtiWA4XZOZZXdVgYnGWZAho/Jf+TIcGniw=; b=MM6AaE1UuiVcYxhB
    c4+/5lqFvT5Q/nMOO/svQPLoY/AmK1DtfyQKq/gYtx6GVkDEAylB6RffBSrVocAz
    zBlh+fe1znYTZn6xz+JW5ulmbpiFqDf8pK4YJZH3SrUnUHOGFeMrNEJR1FbuztFO
    m4uF3fCT81l3Y6eC2lWrRGDyKGIls1MiPrP8d6zavjaG22aCrzh7rAyyywELfefm
    ttQwO9nYZ3ce/xcIs7YU3F1UyAvh1oDVxfF0QKY0zbrr5zVTc9aMyYSh18U5dboW
    rX06hIdZJeMxHBv3BZnO+6HjbDE+taYbFMs737p5UqctXhZi9bSGJhoIh//X8Wj6
    8b5n+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=JIvW9BIl
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=Nj2+i6tJ
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=JIvW9BIl
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=Nj2+i6tJ
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHRORamjRTqq7DQDF4BFQ41/ya8Tqm86hSTMhhiJbGIFqPixhx+0IrkD2tNu8MReD4XOvyuSGrs0PGiuaVG9motPrEs3IEJ1np+jL3N4Q5AhWMsWMFoM
    Fmervjpndx3nuRSIE72U8vMgcUg3yhi7P+mHxyu5IGbF/IFnHEa9PHedpSh3e6hWL8zIXA7z0yvkKsRNZJzT1E16JVOzooJ5ISob41gDTFSnkgJXr/X0RsPV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=gQzYTCSkdcmE2bKtuKIA:9 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeEBVGq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:06:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59568 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEBVGl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:06:41 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C626F607E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v5 2/7] phy: qcom-qmp: Enable pipe_clk before PHY initialization
Date: Thu,  3 May 2018 02:36:09 +0530
Message-Id: <1525295174-15995-3-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

QMP PHY for USB/PCIE requires pipe_clk for locking of
retime buffers at the pipe interface. Driver checks for
PHY_STATUS without enabling pipe_clk due to which
phy_init() fails with initialization timeout.
Though pipe_clk is output from PHY (after PLL is programmed
during initialization sequence) to GCC clock_ctl and then fed
back to PHY but for PHY_STATUS register to reflect successful
initialization pipe_clk from GCC must be present.
Since, clock driver now ignores status_check for pipe_clk on
clk_enable/disable, driver can safely enable/disable pipe_clk
from phy_init/exit.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 6470c5d..fddb1c9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -793,19 +793,6 @@ static void qcom_qmp_phy_configure(void __iomem *base,
 	}
 }
 
-static int qcom_qmp_phy_poweron(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	int ret;
-
-	ret = clk_prepare_enable(qphy->pipe_clk);
-	if (ret)
-		dev_err(qmp->dev, "pipe_clk enable failed, err=%d\n", ret);
-
-	return ret;
-}
-
 static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -974,6 +961,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		}
 	}
 
+	ret = clk_prepare_enable(qphy->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		goto err_clk_enable;
+	}
+
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
 	/* Configuration for other LANE for USB-DP combo PHY */
@@ -1019,6 +1012,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	return ret;
 
 err_pcs_ready:
+	clk_disable_unprepare(qphy->pipe_clk);
+err_clk_enable:
 	if (cfg->has_lane_rst)
 		reset_control_assert(qphy->lane_rst);
 err_lane_rst:
@@ -1283,7 +1278,6 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 static const struct phy_ops qcom_qmp_phy_gen_ops = {
 	.init		= qcom_qmp_phy_init,
 	.exit		= qcom_qmp_phy_exit,
-	.power_on	= qcom_qmp_phy_poweron,
 	.set_mode	= qcom_qmp_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

