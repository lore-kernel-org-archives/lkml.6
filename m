Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F306C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BA321104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tE7GxJq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BA321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbeKTEVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:21:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35535 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbeKTEVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:21:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id v1-v6so7804485plo.2;
        Mon, 19 Nov 2018 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rAK0Xbr7VEsutf7yMRfRhJtOPREazjKLI+JMtMgaE1A=;
        b=tE7GxJq2PkJ+Fl8MKM1zi4KrToLVwrmxZmh4MWU39n+kEf2EHOQHp7PHiGe6bD7jXI
         bzXrgk+mKf1058XrrEXkAMl8dF4Z7AKoL+qFIL8sDm/QfNXnCdePWYs33/J3IAuVNZUv
         yZUuo37BB5Jg6ydHSNQSW+R186N9FzQJFZMT8e6AmazyoyQp1lzBlEA4V6RVPZLEDCdK
         w/s8VKiyI0CN6a68BJEUoQHTS6JfHnZKnXHbVMA9RL3qAsn4RYdngeafucAeoVEQ4pL8
         22IRg3ccbavlUCRDk6jOYXkelQeCtogNayLrcFzBozUxGgtwWW9jDNFOZiORZ9C8sScr
         uMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rAK0Xbr7VEsutf7yMRfRhJtOPREazjKLI+JMtMgaE1A=;
        b=fTufEgCNFT6yOHv4mLSBCVu8VWU/bOSsrDtTqHiRV+ScLdzffFtkuf2Pw/nVBZUXPZ
         XdiHUUT7IvtjM1+jL82TGZVPRMHe2sZ8OAD7RWlwGkczSP/Y/w1THRmyO7GTuxB4rppW
         Sh7JdplpsZJePB7fdyXivTNBG4V1e5xejZLqjpXKLhy72vDk6bhVTRxCPGuY3U+as/b4
         dYu7zkVa72KE/nRDjPtd22IpP5jfy8EMiC6rhhBcb+5JJ1bVjry9tW9NaZpzDw69urkk
         +QZqRUMqBvnO3gu2UESow6yJ9c/iSYvZYl10MJsOkLYU55Yjc08a0V172GZWpFkygaQ7
         KssA==
X-Gm-Message-State: AGRZ1gJeEzwgjVyLoELNN1o8DLsxHPkK8okZnw+pSeAmXBolK4KIkG/B
        FrA9oVel2k8xmuL3RNvZ6Pc=
X-Google-Smtp-Source: AJdET5fr3PdmWzvi5ZhNJN2iXB+w9sDzp1nlMlubKf2gGb03sLs+1w0tpr+4TnI02qkfWuYrjaQVKQ==
X-Received: by 2002:a17:902:7281:: with SMTP id d1-v6mr23056131pll.284.1542650197012;
        Mon, 19 Nov 2018 09:56:37 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x123-v6sm56159846pfb.124.2018.11.19.09.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 09:56:36 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Doug Berger <doug.berger@broadcom.com>
Subject: [PATCH net-next v2 1/2] net: bcmgenet: code movement
Date:   Mon, 19 Nov 2018 09:56:01 -0800
Message-Id: <1542650162-9229-2-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
References: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <doug.berger@broadcom.com>

This commit switches the order of bcmgenet_suspend and bcmgenet_resume
in the file to prevent the need for a forward declaration in the next
commit and to make the review of that commit easier.

Signed-off-by: Doug Berger <doug.berger@broadcom.com>
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

