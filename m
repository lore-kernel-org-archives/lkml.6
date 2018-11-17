Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F251C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB240208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoDa2qhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB240208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeKQMP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:15:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbeKQMP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:15:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so7530396pfc.6;
        Fri, 16 Nov 2018 18:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EDECk6CIUbAw8t+5+S6Rv35UfBl3+vfY5F15m3+cH3U=;
        b=WoDa2qhyDjyNM/M7IxEaGkOrp5uhdEqzGTClSKSvZEWQ4ujiPqYN5zDA5w+A0edAY7
         76KGv2TOuD89zMFW70853Dg+VinSNUzwipzqwULGG1fS4Nnk7EKNdMvWnhEZAhvCstVl
         sM4lOr80YVAnXzx3JZP2PGSPjy4L0ebZuih+VCysFKKSNoOYvr/jvLcsLguUDoFUzjy4
         NLo54x1OJj4jqhFuJxrsydJ6+UxVeKDdy67NZL5CFIuy5YSm5QvpETNfeJU5hWRFebTy
         Idw41QUckTjdp2uyINyfYhHuIyJFvgA0Z7LszElcs37OdnecwuqSPT5YKmemDrGCyUH7
         eNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EDECk6CIUbAw8t+5+S6Rv35UfBl3+vfY5F15m3+cH3U=;
        b=XivquvbKxI+jmwzC8k4jk/JofS5xrtDqS7ZAxoIPqGqZZQJK/uaskS9Mv65IVrL8bL
         VCPwpb5G0o1E6q+vNpawf659NIFsqcafWFT0JD3oO6jqFxm6vVSXTO1B/wut+909FynC
         jWbseMaF5jSU/k909/Q40kFiUf1FqC3vLKpK2J59Mt3HQvIgBTz3nRgFPOmC85w3lUFc
         FP5wGM+PJiJTce+qIxyEqZEwbAmNvxIx6glQYcFGuRaQuk7f31gicSsXGJY1z5TtS2fo
         ybTQPfykMJ7Kuw+U+2MAGZ1MzOSig9zvQiOWq3N4srkxB7qHqaAy6vzkSSSKPPIk5DrB
         jTgQ==
X-Gm-Message-State: AGRZ1gIc4HQpwD0+T7gPV+ndPkhbjGaqw/JnvwDgw+uWIBbtUGpoZ2kN
        wIIMNA7VkttPSxnRtu79Kks=
X-Google-Smtp-Source: AJdET5fBjNw4J03j3u/qFat+JKscYLxeffWYS2yI9yuxdf0ydbeL5yQfMCkFqjuFg7uIqhl5+PSfgw==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr12103331pgf.193.1542420066027;
        Fri, 16 Nov 2018 18:01:06 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b14-v6sm47535498pgn.49.2018.11.16.18.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 18:01:05 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 1/2] net: bcmgenet: code movement
Date:   Fri, 16 Nov 2018 18:00:21 -0800
Message-Id: <1542420022-30251-2-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
References: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit switches the order of bcmgenet_suspend and bcmgenet_resume
in the file to prevent the need for a forward declaration in the next
commit and to make the review of that commit easier.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 60 +++++++++++++-------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index bf88749505a9..01c8499fd87f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3612,36 +3612,6 @@ static int bcmgenet_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int bcmgenet_suspend(struct device *d)
-{
-	struct net_device *dev = dev_get_drvdata(d);
-	struct bcmgenet_priv *priv = netdev_priv(dev);
-	int ret = 0;
-
-	if (!netif_running(dev))
-		return 0;
-
-	netif_device_detach(dev);
-
-	bcmgenet_netif_stop(dev);
-
-	if (!device_may_wakeup(d))
-		phy_suspend(dev->phydev);
-
-	/* Prepare the device for Wake-on-LAN and switch to the slow clock */
-	if (device_may_wakeup(d) && priv->wolopts) {
-		ret = bcmgenet_power_down(priv, GENET_POWER_WOL_MAGIC);
-		clk_prepare_enable(priv->clk_wol);
-	} else if (priv->internal_phy) {
-		ret = bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
-	}
-
-	/* Turn off the clocks */
-	clk_disable_unprepare(priv->clk);
-
-	return ret;
-}
-
 static int bcmgenet_resume(struct device *d)
 {
 	struct net_device *dev = dev_get_drvdata(d);
@@ -3719,6 +3689,36 @@ static int bcmgenet_resume(struct device *d)
 	clk_disable_unprepare(priv->clk);
 	return ret;
 }
+
+static int bcmgenet_suspend(struct device *d)
+{
+	struct net_device *dev = dev_get_drvdata(d);
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	int ret = 0;
+
+	if (!netif_running(dev))
+		return 0;
+
+	netif_device_detach(dev);
+
+	bcmgenet_netif_stop(dev);
+
+	if (!device_may_wakeup(d))
+		phy_suspend(dev->phydev);
+
+	/* Prepare the device for Wake-on-LAN and switch to the slow clock */
+	if (device_may_wakeup(d) && priv->wolopts) {
+		ret = bcmgenet_power_down(priv, GENET_POWER_WOL_MAGIC);
+		clk_prepare_enable(priv->clk_wol);
+	} else if (priv->internal_phy) {
+		ret = bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
+	}
+
+	/* Turn off the clocks */
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(bcmgenet_pm_ops, bcmgenet_suspend, bcmgenet_resume);
-- 
2.7.4

