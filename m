Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310BCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BEC20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAKj0dzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BEC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeKBIBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:01:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44031 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:01:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id h4-v6so46064pfi.10;
        Thu, 01 Nov 2018 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0shYggPHJZN448he8ENHRYq5X/d6aeX1GdZzOsaCMJU=;
        b=JAKj0dzuRijeAutbR5hxCackXJO0L5o1xbADC/ybYzWVQfm71yFkbdYLHhZyk6rvrL
         vwWffFARnsrxHTNIVlAx3TKgggNVwbCVE73m4zJvoMLGUuR2+Rt7EFcnEQlRbyXpkEIA
         Cwp8gJAfgWXEQ0YK4TJswnNrcQI8KjelL5zEvdHdA2F/FD67rMBjUDigzXZ0KNK/chOw
         ed7QlVUJPhDZX6E+MaC9EoOCTaKrs431HbI+n01cbOQEAfoOOGH3vyk2g/N/txBfLQr4
         Ri0Vj8BQi1gXOEowkNItSPTSrlVnxXRC6zrAVeZ2f5kjGn41d0shPcQbvWBuNBX8IfjP
         JSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0shYggPHJZN448he8ENHRYq5X/d6aeX1GdZzOsaCMJU=;
        b=ECWoyMvJI9m8EKr/udoZ2crSMG2mKxs0V4vYb6nyQg1dRiklP0IAj6aqSJN00+qyQD
         GbawdiyanW9Ef0U4QANJ3FlMZKV9FzKil94Pt0ai79dEpDv/c3NJxIi8ENHArTgMyaKY
         OfeXSBjSYBqo8HkqoScib6G87QXKGCQqNzItCop48WGNjnVSprAf+lk1q5gnW9WFQ5tn
         0AW2VuO7jXTapxGjD1qztmIDgL4vqPkuwe48dU6xSNpEfCQZLXG7cVZZaemZrIN/V5/9
         acmhbi744N0MiWjQTUXzJgnR94aW38Y0mdlW6uiJHevkaynWryRNAocReNTlORgeQ1KS
         7P6g==
X-Gm-Message-State: AGRZ1gIDPwemOVHyMnafcXVF831DuFxslwAmyU3h/UI2pF2kjyHonRpT
        ZAxYMpaTKqsWPGaLZPE9OHB1foY9
X-Google-Smtp-Source: AJdET5fPy+zqPord/3JmvodUAcMzeb9LY+BlS6kqB6lTSau2k8X04BrIa+TrIglr6yPKqNsKS+6XKA==
X-Received: by 2002:a62:30c7:: with SMTP id w190-v6mr9325227pfw.188.1541113003246;
        Thu, 01 Nov 2018 15:56:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v189-v6sm40929635pfb.54.2018.11.01.15.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 15:56:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     jaedon.shin@gmail.com, opendmb@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/2] net: systemport: Protect stop from timeout
Date:   Thu,  1 Nov 2018 15:55:38 -0700
Message-Id: <20181101225538.18632-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101225538.18632-1-f.fainelli@gmail.com>
References: <20181101225538.18632-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A timing hazard exists when the network interface is stopped that
allows a watchdog timeout to be processed by a separate core in
parallel. This creates the potential for the timeout handler to
wake the queues while the driver is shutting down, or access
registers after their clocks have been removed.

The more common case is that the watchdog timeout will produce a
warning message which doesn't lead to a crash. The chances of this
are greatly increased by the fact that bcm_sysport_netif_stop stops
the transmit queues which can easily precipitate a watchdog time-
out because of stale trans_start data in the queues.

This commit corrects the behavior by ensuring that the watchdog
timeout is disabled before enterring bcm_sysport_netif_stop. There
are currently only two users of the bcm_sysport_netif_stop function:
close and suspend.

The close case already handles the issue by exiting the RUNNING
state before invoking the driver close service.

The suspend case now performs the netif_device_detach to exit the
PRESENT state before the call to bcm_sysport_netif_stop rather than
after it.

These behaviors prevent any future scheduling of the driver timeout
service during the window. The netif_tx_stop_all_queues function
in bcm_sysport_netif_stop is replaced with netif_tx_disable to ensure
synchronization with any transmit or timeout threads that may
already be executing on other cores.

For symmetry, the netif_device_attach call upon resume is moved to
after the call to bcm_sysport_netif_start. Since it wakes the transmit
queues it is not necessary to invoke netif_tx_start_all_queues from
bcm_sysport_netif_start so it is moved into the driver open service.

Fixes: 40755a0fce17 ("net: systemport: add suspend and resume support")
Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4122553e224b..0e2d99c737e3 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1902,9 +1902,6 @@ static void bcm_sysport_netif_start(struct net_device *dev)
 		intrl2_1_mask_clear(priv, 0xffffffff);
 	else
 		intrl2_0_mask_clear(priv, INTRL2_0_TDMA_MBDONE_MASK);
-
-	/* Last call before we start the real business */
-	netif_tx_start_all_queues(dev);
 }
 
 static void rbuf_init(struct bcm_sysport_priv *priv)
@@ -2048,6 +2045,8 @@ static int bcm_sysport_open(struct net_device *dev)
 
 	bcm_sysport_netif_start(dev);
 
+	netif_tx_start_all_queues(dev);
+
 	return 0;
 
 out_clear_rx_int:
@@ -2071,7 +2070,7 @@ static void bcm_sysport_netif_stop(struct net_device *dev)
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 
 	/* stop all software from updating hardware */
-	netif_tx_stop_all_queues(dev);
+	netif_tx_disable(dev);
 	napi_disable(&priv->napi);
 	cancel_work_sync(&priv->dim.dim.work);
 	phy_stop(dev->phydev);
@@ -2658,12 +2657,12 @@ static int __maybe_unused bcm_sysport_suspend(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
+	netif_device_detach(dev);
+
 	bcm_sysport_netif_stop(dev);
 
 	phy_suspend(dev->phydev);
 
-	netif_device_detach(dev);
-
 	/* Disable UniMAC RX */
 	umac_enable_set(priv, CMD_RX_EN, 0);
 
@@ -2746,8 +2745,6 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 		goto out_free_rx_ring;
 	}
 
-	netif_device_attach(dev);
-
 	/* RX pipe enable */
 	topctrl_writel(priv, 0, RX_FLUSH_CNTL);
 
@@ -2788,6 +2785,8 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 
 	bcm_sysport_netif_start(dev);
 
+	netif_device_attach(dev);
+
 	return 0;
 
 out_free_rx_ring:
-- 
2.17.1

