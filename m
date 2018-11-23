Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734D9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO2g0jgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504242AbeKWXFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:05:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46428 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394543AbeKWXFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:05:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so10073310edt.13;
        Fri, 23 Nov 2018 04:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wotCpAV5075qezqHiHnnTQKRjQncmClZGWsAwHl60SI=;
        b=NO2g0jgyFFNN2dTTDNu40pJkCSfrvwN+OuJ6XUZz5GUYiVFtQ1Nmra+uDJLBwtUTTt
         HiAQ6azq4wJIoiydKd18tGCCYsKZTrMyPgOMCODtSk1jW0he0WlDJfK/Itx5gpbfpnQ/
         CHt1RhuIJ9EW/V/taHywCVChQGFath70fEe/vljpdqlbjIVohtHgqGl/VoTcOnZIO5Bt
         v3+suoDWJDqal78Rr4SSXXas+/iJLg3oDmM5vBcKUqm6V3lB0bHi5plUZaE4JSlEeU+E
         7bzLkTFAcMWaca7ihyNzd3cUwdI/pKK08iQ/6Dapoum7O+/7ASJZ5phx8lZafxId3+Tm
         MuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wotCpAV5075qezqHiHnnTQKRjQncmClZGWsAwHl60SI=;
        b=XgB4BP+pQL/03y6nC5BiSXoYSbaEjdLmEyj3rl16UFc7hq4J1T7NH7KwCXgFhBEn0y
         jCTFLvPfOthGs5RWZRLFBmHsb3XUBqo4ZBRc2K5m2I1ISfGAEiXJLd86/Af5hYgXk6Bo
         wjjqj5hJKpVAce2wh2WLfWwGwYD1vfr+BxhuO4P3v1neUOkat8Wrr7GeRHsoHFykJQap
         b9jrC4EmT8PivSdqyM5TJknt7y5X+2hLaczydczS4lUyyKyhf4C71O7/P4bKbiqNksHc
         Qdl2KFVXuUcOOj5yU7sBxFji9sundgY0+YFtOhJHY0GRJW6/r1oSL7w6DxK/wQCNc1IN
         hg3Q==
X-Gm-Message-State: AGRZ1gJXGBlLor+OmzZ1mbiaV6fNzzO9wyOidf21QxqCXB4RDt39gsMM
        g8CCJ96qxlbFaD51G9z3lcI=
X-Google-Smtp-Source: AJdET5fZsFu7tNwIdYUeTRN1b3eBKCnSRHxn3RoROLyR+vbvcGNjFlhL1mpZCdXeH8pjW2Bz8cL36w==
X-Received: by 2002:a17:906:a4cf:: with SMTP id cc15-v6mr11431320ejb.157.1542975683778;
        Fri, 23 Nov 2018 04:21:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h8sm3311057edb.95.2018.11.23.04.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:21:23 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Move debugfs init/exit to ->probe()/->remove()
Date:   Fri, 23 Nov 2018 13:21:22 +0100
Message-Id: <20181123122122.18957-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Setting up and tearing down debugfs is current unbalanced, as seen by
this error during resume from suspend:

    [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to create debugfs directory
    [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: failed debugFS registration

The imbalance happens because the driver creates the debugfs hierarchy
when the device is opened and tears it down when the device is closed.
There's little gain in that, and it could be argued that it is even
surprising because it's not usually done for other devices. Fix the
imbalance by moving the debugfs creation and teardown to the driver's
->probe() and ->remove() implementations instead.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
This applies on top of net-next.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 076a8be18d67..3ced86ac2ab1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2550,12 +2550,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
 			netdev_warn(priv->dev, "PTP init failed\n");
 	}
 
-#ifdef CONFIG_DEBUG_FS
-	ret = stmmac_init_fs(dev);
-	if (ret < 0)
-		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
-			    __func__);
-#endif
 	priv->tx_lpi_timer = STMMAC_DEFAULT_TWT_LS;
 
 	if (priv->use_riwt) {
@@ -2756,10 +2750,6 @@ static int stmmac_release(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-#ifdef CONFIG_DEBUG_FS
-	stmmac_exit_fs(dev);
-#endif
-
 	stmmac_release_ptp(priv);
 
 	return 0;
@@ -4397,6 +4387,13 @@ int stmmac_dvr_probe(struct device *device,
 		goto error_netdev_register;
 	}
 
+#ifdef CONFIG_DEBUG_FS
+	ret = stmmac_init_fs(ndev);
+	if (ret < 0)
+		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
+			    __func__);
+#endif
+
 	return ret;
 
 error_netdev_register:
@@ -4432,6 +4429,9 @@ int stmmac_dvr_remove(struct device *dev)
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
+#ifdef CONFIG_DEBUG_FS
+	stmmac_exit_fs(ndev);
+#endif
 	stmmac_stop_all_dma(priv);
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-- 
2.19.1

