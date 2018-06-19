Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F80C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F09E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bBpTNjNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F09E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967122AbeFSQLM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:11:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42458 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967032AbeFSQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:10:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so224839wrk.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADA5Q+NCfXV/mZjpNHccIMsB+3ZlXTeJHda7DVng7Y8=;
        b=bBpTNjNMWGfBcInQXTydKWpkkzcjkPqmELo2IC3aJzFG5vhhO68Kl96rVhzwWD1lef
         j8cQ0jxsj22Ss3QHCRSC+GhP3MS/5v5XGYgz5neFqGnCIXtslLfJlF3XIr8X3xS/S68C
         JvpsMO1HZjwTdBmbFzyehVZBc2J6s6kEK2+NUivE+WXhDCEM21uNdaqEEMW8XTR4MZx1
         5Fm8dpGDSFkNYlZJLR7W7U7pjEhJhw+GytVpU9eirODwjqU16uxel0nkHnYZ+bzAlKKN
         9LJju5NCLurKsHI9elnm35xyE/EHyMAM6ZMkmOcM0kmDP56stxfuYo0hd53yRDfXfVGo
         1rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ADA5Q+NCfXV/mZjpNHccIMsB+3ZlXTeJHda7DVng7Y8=;
        b=MXfmbRjhtnae8dJAqlTccwNmtjEsyUczlVoPkJFGQxkWrXMltf+FmZ+GyP3Ex5UFgG
         h+8iIAcCPGKGp4kpQ9QjFmoQzYhJcP+fUd/AmP7vPSIh4katAUdpd9fYk9DtKdbYa954
         AvODcYGQKdGEdT6ixMrwvNNtpLcZhE0a4e3yQ1uFlMsqP5xWrfSr7sysQC0EqGxmHSZb
         AOVJsfbeZIu16XWZeldHVbbw2rvuXAzCOysROQH4CEpptZKx59pP5ThTLEjGBuXw1dU6
         90GpJ+VJ7pycd/WbrWH5oJ0PwsDkpL/q/Wkl9GaABPpCxTI7nZYP8ubzo/8Xn3FNTL47
         YSUA==
X-Gm-Message-State: APt69E3hc12RJRf0mp1t2Z2Z9/yibdy4y30N6GFi8DWgYuaisx/Z4eq+
        FCtOdk//yExXfKwvQGXlDBuWew==
X-Google-Smtp-Source: ADUXVKIjwij/lqALI0QK9YRl+rz93jyfhcl1g3LG1YppsoNM97E1BP/TFx/dIhp5JSeAX6U1YLHj9g==
X-Received: by 2002:adf:9d02:: with SMTP id k2-v6mr14388213wre.213.1529424599631;
        Tue, 19 Jun 2018 09:09:59 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id 74-v6sm619327wmt.31.2018.06.19.09.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:09:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] net: ethernet: fix suspend/resume in davinci_emac
Date:   Tue, 19 Jun 2018 18:09:48 +0200
Message-Id: <20180619160950.6283-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619160950.6283-1-brgl@bgdev.pl>
References: <20180619160950.6283-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
Deduplicate bus_find_device() by name matching") and adds a comment
which should stop anyone from reintroducing the same "fix" in the future.

We can't use bus_find_device_by_name() here because the device name is
not guaranteed to be 'davinci_mdio'. On some systems it can be
'davinci_mdio.0' so we need to use strncmp() against the first part of
the string to correctly match it.

Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 06d7c9e4dcda..a1a6445b5a7e 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 		return -EOPNOTSUPP;
 }
 
+static int match_first_device(struct device *dev, void *data)
+{
+	return !strncmp(dev_name(dev), "davinci_mdio", 12);
+}
+
 /**
  * emac_dev_open - EMAC device open
  * @ndev: The DaVinci EMAC network adapter
@@ -1484,8 +1489,14 @@ static int emac_dev_open(struct net_device *ndev)
 
 	/* use the first phy on the bus if pdata did not give us a phy id */
 	if (!phydev && !priv->phy_id) {
-		phy = bus_find_device_by_name(&mdio_bus_type, NULL,
-					      "davinci_mdio");
+		/* NOTE: we can't use bus_find_device_by_name() here because
+		 * the device name is not guaranteed to be 'davinci_mdio'. On
+		 * some systems it can be 'davinci_mdio.0' so we need to use
+		 * strncmp() against the first part of the string to correctly
+		 * match it.
+		 */
+		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
+				      match_first_device);
 		if (phy) {
 			priv->phy_id = dev_name(phy);
 			if (!priv->phy_id || !*priv->phy_id)
-- 
2.17.1

