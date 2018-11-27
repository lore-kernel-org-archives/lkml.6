Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C894BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D3F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkyUFWSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D3F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeK1ATm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:19:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38852 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeK1ATm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:19:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so18983949ede.5;
        Tue, 27 Nov 2018 05:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3o0vSQSkbSH/77fB0ce64OvtwrlCj1Hgv5zEr/ADgg=;
        b=tkyUFWSOoB9PE6zWJQGcZAO2xruaROHOlstGasskXw1f8J0/xaFvA4qRluAwr1aAwF
         3RhZjVeNa2IxrosLARi9yXXo5N5Wn7tlMfALLCvABpOP8hni0DOUvrZdEeDVqmgE9cZF
         SAjdsyV7IvVZV0vlc3CQ584qhYnUfd4f4gSU+uOLqOdgYZjjEMXUuzhmwR4j/6r1HCjx
         SEwJA3cb+5C2JOnfnEcrzbHifVvGTi8lAzPQRuDjtAXYWlPouEjdS9SA1pGI/WrDGf9k
         Hup3qWOstAuVx4wfcQgRTWqDfY86Z3xiBctSKL2rrSp9eA9wLzHai7zib/VjxE1gcZ0Y
         ZLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3o0vSQSkbSH/77fB0ce64OvtwrlCj1Hgv5zEr/ADgg=;
        b=lG/cKoiOrjT77wxltOpTGDz5QrE9ltISjVoq96OSYfDu7x1bi04aM9KfWRUY6w9Qhp
         ztaf1LG6BCBf0bR9rJHlk9tRkd7ZhkZGF872ovO4o+B0WX+9NJdG+K07VCLRTO+ipEdv
         KgkoYH0RdT8jd4acgyq7jiYWRBhu0d0s2u6erd0U25HQct5S41j4+f2iOnC7cZ02KpOj
         8oN9WMtcaJTDAJlT0YMiZU4K+g3EGJODtazH4OSIbBIthPKEwBpKW9JgzUSTB7NzWEOc
         twTNaptJjUj9Ympj8El62xjcc+6okelI695CkrEyR+H7dspUvwndYZ15le/tFPcnDMMu
         5DeQ==
X-Gm-Message-State: AGRZ1gL2Oizii7fkxQyCWOPs45mawLBOnfTRCJdnep7U3ZzMYn3MEdnF
        n7WwYbsJVsIc30CgZ8FGQ47w0cbS
X-Google-Smtp-Source: AJdET5dAOoNK+aRKgjbN8DKkB6GVdINIF6UwIEfGl5+pkPHhflW92ot/RAwTVE2yqGfiPKVdsABOhQ==
X-Received: by 2002:a17:906:b243:: with SMTP id ce3-v6mr23203106ejb.87.1543324906049;
        Tue, 27 Nov 2018 05:21:46 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r18-v6sm567114eja.19.2018.11.27.05.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 05:21:45 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: Move debugfs init/exit to ->probe()/->remove()
Date:   Tue, 27 Nov 2018 14:21:43 +0100
Message-Id: <20181127132143.10473-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123122122.18957-1-thierry.reding@gmail.com>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
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

Note that the ring descriptors cannot be read while the interface is
down, so make sure to return an empty file when the descriptors_status
debugfs file is read.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
This applies on top of net-next.

Changes in v2:
- avoid access to ring descriptors when interface is down

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 076a8be18d67..5551fead8f66 100644
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
@@ -3899,6 +3889,9 @@ static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
 	u32 tx_count = priv->plat->tx_queues_to_use;
 	u32 queue;
 
+	if ((dev->flags & IFF_UP) == 0)
+		return 0;
+
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
 
@@ -4397,6 +4390,13 @@ int stmmac_dvr_probe(struct device *device,
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
@@ -4432,6 +4432,9 @@ int stmmac_dvr_remove(struct device *dev)
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
+#ifdef CONFIG_DEBUG_FS
+	stmmac_exit_fs(ndev);
+#endif
 	stmmac_stop_all_dma(priv);
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-- 
2.19.1

