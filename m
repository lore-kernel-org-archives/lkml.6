Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518932098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iJdlXUvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518932098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeJRXGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:06:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37318 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJRXGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:06:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1-v6so1181132wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hfIEmy/L0yThNprHRfv0ehO65sgCJvSFBVK5lgm1vLk=;
        b=iJdlXUvtS4BoJ0dkUwWZ9nBCRZfl71dYK8wzKt4F8c6qU/1JXWIjV6gY35GkWBlXXM
         gdesF002/RzcKx+lrIrkITgvQ6mEOyNA5TkjzP5G+Z2rww6c/eojy4ESuAYY+RUplLuL
         iOigWQhM5/U8wTCpjuK1rQEwDO7mrBFtpyTXey3eFRsI3zdUy4aoyBfwa1bk3ec7tNIy
         D5XfJOF1Jjh5QYUbImJZliwkpQxIdOOY6FzDvH0PrfbYlI2vTh7rYmDvlp6DWK5CpR62
         PMWq9sY1ilUylhDWyQI7bQLw1BC0hbojg0navv5VQVeE+jtGGVmuNpLoxIHvVgLf7Y2I
         rr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hfIEmy/L0yThNprHRfv0ehO65sgCJvSFBVK5lgm1vLk=;
        b=VTubbZRNVT7tGxU+dKMwWiMqgRtDoKaao7QvDdmw+rG/eOCiMDnSqRHmuEJ4Tue0S7
         ljNj0AU9c8mslZt94JqYJjjEYeT9Q+hX6WDfHDnjm6AofV1WE+rPnl6YJI67y4hRItMt
         CgdL3QpQY8n5ppSF5g6EN9vrN/LoQ5upwIxoqew53N1Z7rImUEDJSfTX4nYtAnd8Q10i
         YCoZ3c30a91vzy0SMAnBkKSzfz0lpgqorGQw+xyFgROItkG/dIg8YNUFDVsX95RzwZaV
         l7oE51rlXz90ewdJpMwjaQPJiQLiT2Jxx8/JXEuanvRfe6BbBz82uXNW3/RXBgHWW6L4
         +DVA==
X-Gm-Message-State: ABuFfohkZdCUHN1QFIQnfcYt5PU1XsA9HIqHN+yop7dcmLIV81uNNsQb
        aZUdu4RVzVKQKwET7/p2ZZp1v55kjOQ=
X-Google-Smtp-Source: ACcGV60PdtL48BLBM2y7DDm1O1RJKXyOac1//ERkeekKkIU+3M+J8hbwTUbD682KVEXVepLxciEcDQ==
X-Received: by 2002:a05:6000:1105:: with SMTP id z5mr28272690wrw.136.1539875116159;
        Thu, 18 Oct 2018 08:05:16 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b71-v6sm685272wma.13.2018.10.18.08.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 08:05:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     andrew@lunn.ch, davem@davemloft.net, f.fainelli@gmail.com,
        fugang.duan@nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: ethernet: fec: Add missing SPEED_
Date:   Thu, 18 Oct 2018 15:05:00 +0000
Message-Id: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
This is due to missing SPEED_.

Fixes: 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a17cc97..75fd7c9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1946,7 +1946,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 
 	/* mask with MAC supported features */
 	if (fep->quirks & FEC_QUIRK_HAS_GBIT) {
-		phy_set_max_speed(phy_dev, 1000);
+		phy_set_max_speed(phy_dev, SPEED_1000);
 		phy_remove_link_mode(phy_dev,
 				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
 #if !defined(CONFIG_M5272)
@@ -1954,7 +1954,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 #endif
 	}
 	else
-		phy_set_max_speed(phy_dev, 100);
+		phy_set_max_speed(phy_dev, SPEED_100);
 
 	fep->link = 0;
 	fep->full_duplex = 0;
-- 
2.7.4

