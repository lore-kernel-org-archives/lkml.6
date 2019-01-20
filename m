Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5312EC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2033E2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu4wB/03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfATQGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:06:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34409 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfATQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:06:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so13814775lfc.1;
        Sun, 20 Jan 2019 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wzao/hU6QG9MuXoF33EVgSfu5MdpCuvVVrCUvJF7L8s=;
        b=Cu4wB/03fAmp2pkWvVa/2DBZoXAPkASLyD2ygeQPiEKf9quoeMl9WYNUwOc0RgGv5U
         xdjuRB65GCCv1TgMxbTEFkEdJ9xYhHQYhuwiixnAzDR0jOj4sb8wssrxsH/WERrIwU/w
         O5tLsJkSKlPoT7v/2wB4Cvm72nt+zeusEMwOlm7ehpSUsrUfhPCQyTL4Vq275pdu+8IQ
         zRchYtFxjZ8KHio4vbRoitrE0Beufv2Gb+nGjqlVgacAjmYsydOpr3GR6wU3WNOCP7n8
         hzq4TIN4VzJcBoLEAwvwhNyn/qS9ymqx11al2Ql6SFOVW2cKjGajLk+Rc8fWqoRikysO
         +1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Wzao/hU6QG9MuXoF33EVgSfu5MdpCuvVVrCUvJF7L8s=;
        b=PrkYOHFR86QEuoS3nBmK7oFNhfdBm7YgXQxt/Ry3xuv5a5DblpbCRYMD7PS9TwXqQa
         Dtcr/f5RZfyE4VJjDzOMuuuJCXTObhqchNgYHk9Dcmo3+sscgIwfG6CkRR6EBz+0C/TF
         aWpIsPxv6/odro3BB6PyJ65ueKWL284q9BiwQwFUU63+nEQUGL502Ur5iIfii+CGrsc6
         iCYiq38j62ZphS2XxcFVNSZ+SxfHHdRipCEBSnj3S1iCD5NymSQdgHNO8tcqTRhZykez
         2kFJRODfXAuXu4DVDKAMChJrR6+6RDfR8spORSJiTfdrEN6mpRzJaiQCjnUktiGYODOT
         ywUQ==
X-Gm-Message-State: AJcUukfyn6TrTgQ94FPIwpExw4rzryXvWJx8xDbkWtKBbx7F3uT1NDI5
        hRlTZkFr7QxLhcDIvFO99Vo=
X-Google-Smtp-Source: ALg8bN6URnXDDx6Bg9+J/UqdX/Kgm0FXM792oZt+XtaG/6xxDZjZjxQ98jCkzzVTfyicuCCykppJRA==
X-Received: by 2002:a19:5059:: with SMTP id z25mr11978146lfj.120.1548000370907;
        Sun, 20 Jan 2019 08:06:10 -0800 (PST)
Received: from localhost.localdomain ([31.134.130.226])
        by smtp.googlemail.com with ESMTPSA id k11-v6sm1801540ljk.40.2019.01.20.08.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 08:06:10 -0800 (PST)
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Artem Panfilov <panfilov.artyom@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net: stmmac: implement the SIOCGHWTSTAMP ioctl
Date:   Sun, 20 Jan 2019 19:05:15 +0300
Message-Id: <20190120160515.26473-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
processes to read the current hwtstamp_config settings
non-destructively.

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 ++++++++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..f9b42b0c20f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include "common.h"
 #include <linux/ptp_clock_kernel.h>
+#include <linux/net_tstamp.h>
 #include <linux/reset.h>
 
 struct stmmac_resources {
@@ -174,6 +175,7 @@ struct stmmac_priv {
 	unsigned int mode;
 	unsigned int chain_mode;
 	int extend_desc;
+	struct hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
 	unsigned int default_addend;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5afba69981cf..517555bcfa44 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -534,7 +534,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 }
 
 /**
- *  stmmac_hwtstamp_ioctl - control hardware timestamping.
+ *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
  *  @ifr: An IOCTL specific structure, that can contain a pointer to
  *  a proprietary structure used to pass information to the driver.
@@ -544,7 +544,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
  *  Return Value:
  *  0 on success and an appropriate -ve integer on failure.
  */
-static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	struct hwtstamp_config config;
@@ -573,7 +573,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 	}
 
 	if (copy_from_user(&config, ifr->ifr_data,
-			   sizeof(struct hwtstamp_config)))
+			   sizeof(config)))
 		return -EFAULT;
 
 	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
@@ -765,8 +765,31 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 				(u32)now.tv_sec, now.tv_nsec);
 	}
 
+	memcpy(&priv->tstamp_config, &config, sizeof(config));
+
 	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
+			    sizeof(config)) ? -EFAULT : 0;
+}
+
+/**
+ *  stmmac_hwtstamp_get - read hardware timestamping.
+ *  @dev: device pointer.
+ *  @ifr: An IOCTL specific structure, that can contain a pointer to
+ *  a proprietary structure used to pass information to the driver.
+ *  Description:
+ *  This function obtain the current hardware timestamping settings
+    as requested.
+ */
+static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config *config = &priv->tstamp_config;
+
+	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
+		return -EOPNOTSUPP;
+
+	return copy_to_user(ifr->ifr_data, config,
+			    sizeof(*config)) ? -EFAULT : 0;
 }
 
 /**
@@ -3767,7 +3790,10 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		ret = phy_mii_ioctl(dev->phydev, rq, cmd);
 		break;
 	case SIOCSHWTSTAMP:
-		ret = stmmac_hwtstamp_ioctl(dev, rq);
+		ret = stmmac_hwtstamp_set(dev, rq);
+		break;
+	case SIOCGHWTSTAMP:
+		ret = stmmac_hwtstamp_get(dev, rq);
 		break;
 	default:
 		break;
-- 
2.19.1

