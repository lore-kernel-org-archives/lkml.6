Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B827720BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEK1ch0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B827720BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeGKJvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:51:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50428 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeGKJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:51:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so1807256wmc.0;
        Wed, 11 Jul 2018 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q7IHJR67uG7EvlDz1uhX/0WNFfGbMV0JriPvf8HvY6M=;
        b=eEK1ch0iVOYl+DZYCTDs8aNRJiZGKcagl6SpR2I44uIRM09EBj77rl3dFKQ2F/yaw+
         5PHtQmJ2B/sW7QXkegj/isXW112o+16PyFrXAovvWG+bBbJkRB8icX9LFCq+rQv1oX1d
         9FpMUr07K76FLnToTnisnugQtCiAjc2OHWx/sOn2yyuqnmmJydvML1rbLYLInLGnz/M7
         QUrYzhvhiLcrKwHkyZypyJTggAnoNaP8hoUHRlahqjKoFdQfgMd6+1ZrODME6oA8fbSg
         UGsGNE2er9XXSAwaPuS4tUgbCd4HLKf8IOeQ1UvvKHnjCI0/0M17dLJz3LYLD7l51+sx
         LzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q7IHJR67uG7EvlDz1uhX/0WNFfGbMV0JriPvf8HvY6M=;
        b=FN9OKNbM/45E4rKrNXQve3Z1JOGR6ZQo4XlBvfSDr3NiE/jdYig9X2q17c+NIm+yAF
         tTMwbw7D3tcQT/pTJJCWp6KGM5U0nvXS90XaT39LHb7vWQmYj8HngYhtdbvBgITvDPlt
         7q2XtcY58csQ5U5yxQfKeLOMQWfSsnXvOysS7Gio6ONbeD/iLvdJvTsIuFkOz4dsJ5+y
         m+fvV/ZG+DoZTfPqXkYhQc9HHSXf0lX5FWLdP504iH1yJIFVW+1I9dqJl5mXDKviAX/G
         oAJoxQtGnx2W28VU4R97ST2ujG53HOBNuM/rva0fLGrRxiWw3iwSnU1GQlr0zQo2n8No
         hKCg==
X-Gm-Message-State: APt69E0jBtuoDNGQfcVchO9Cho1XYrRyc6nXEnGsJ1v7Qic94pyFkGLs
        6RXnIYK0+i3iFOlTTaQWaqFN6wNp
X-Google-Smtp-Source: AAOMgpdu2w2/xeo5VP7hTbwJTg/+h50C087nElDQes0+gm4NXs2veuRkoJQSneRnj5XB+fMjGZ7LOQ==
X-Received: by 2002:a1c:180e:: with SMTP id 14-v6mr17748627wmy.120.1531302484685;
        Wed, 11 Jul 2018 02:48:04 -0700 (PDT)
Received: from cox.net ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1359792wma.11.2018.07.11.02.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:48:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite
Date:   Wed, 11 Jul 2018 02:47:58 -0700
Message-Id: <20180711094758.1670-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYSTEMPORT Lite reversed the logic compared to SYSTEMPORT, the
GIB_FCS_STRIP bit is set when the Ethernet FCS is stripped, and that bit
is not set by default. Fix the logic such that we properly check whether
that bit is set or not and we don't forward an extra 4 bytes to the
network stack.

Fixes: 44a4524c54af ("net: systemport: Add support for SYSTEMPORT Lite")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
 drivers/net/ethernet/broadcom/bcmsysport.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index d5fca2e5a9bc..a1f60f89e059 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1946,8 +1946,8 @@ static int bcm_sysport_open(struct net_device *dev)
 	if (!priv->is_lite)
 		priv->crc_fwd = !!(umac_readl(priv, UMAC_CMD) & CMD_CRC_FWD);
 	else
-		priv->crc_fwd = !!(gib_readl(priv, GIB_CONTROL) &
-				   GIB_FCS_STRIP);
+		priv->crc_fwd = !((gib_readl(priv, GIB_CONTROL) &
+				  GIB_FCS_STRIP) >> GIB_FCS_STRIP_SHIFT);
 
 	phydev = of_phy_connect(dev, priv->phy_dn, bcm_sysport_adj_link,
 				0, priv->phy_interface);
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index d6e5d0cbf3a3..cf440b91fd04 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -278,7 +278,8 @@ struct bcm_rsb {
 #define  GIB_GTX_CLK_EXT_CLK		(0 << GIB_GTX_CLK_SEL_SHIFT)
 #define  GIB_GTX_CLK_125MHZ		(1 << GIB_GTX_CLK_SEL_SHIFT)
 #define  GIB_GTX_CLK_250MHZ		(2 << GIB_GTX_CLK_SEL_SHIFT)
-#define  GIB_FCS_STRIP			(1 << 6)
+#define  GIB_FCS_STRIP_SHIFT		6
+#define  GIB_FCS_STRIP			(1 << GIB_FCS_STRIP_SHIFT)
 #define  GIB_LCL_LOOP_EN		(1 << 7)
 #define  GIB_LCL_LOOP_TXEN		(1 << 8)
 #define  GIB_RMT_LOOP_EN		(1 << 9)
-- 
2.14.1

