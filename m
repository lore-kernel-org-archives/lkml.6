Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419CBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA74A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABry7qGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA74A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH1X06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:26:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33824 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1X06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:26:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so1204419pgv.1;
        Tue, 28 Aug 2018 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JT39clwoSnWvpe2Ui72ZQIXAHXwFOWJCkFVhBPVoe8s=;
        b=ABry7qGXBSpYC2Cm3DNo5h6tkoPU0jxD1J6a1ebM0qOq5Ma7yrpcytYeLonR4uSEYk
         K/UaNYzersHunEv9CEPfWWWfFErZY1nyadjI843ItDXbxGPSN4UYARAZ/WGTfE4qjaz5
         wusbBDSh9IG8L/rsnC5s1kvPLH3WXLsLPZf165BqQ6wFix+cfHLxU+JTGQ4TyOfs9VEI
         uX4UzI/uS8VVXF7rSzgfMOf9zfMbtYceUczHaaJZPoSMcucjluVEYndr3kzU4ijEi4wm
         iGSxgH6Qo6WA2uAAKQLI35rRR/HdZgoTATQm04/Coq2imSw3+NwFigSLADZ90qSeTLXe
         dljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JT39clwoSnWvpe2Ui72ZQIXAHXwFOWJCkFVhBPVoe8s=;
        b=Pwar3IEJw0LDr8b4C7f2g5rTCORmebj9NmmtwyHQLBBMUXJ71w7Trb56Gri9t6pG2e
         HaZbvOpnTTSw0seNJgLwBVlWkEpIxk7zdpuh6rr+Ufh9FXXVO+5uKOr8dkW/vwBEqWQT
         Z13pzMJjsZb0TQzGVVehbBdpRmkeRoYyfnVDjgCmMrSPn1dnlHtGOE0hYYfmFiEmiUIN
         NKDRv7GrIf6/KtdQWCyXeXrL+9jFWyN8plCIHo/8uhpLIvYgRc4Cn111mvydx0jAe0JG
         oQHpWjF0FNVWmX7iQPsq2tF4s5Sp9c9rm93QVgy1atwdCkkaCnMyfdVHWGzfdQCoMmsc
         LWOA==
X-Gm-Message-State: APzg51D82wCVy68UQCVWznJmaEctwLjKMILIuNNNsJ4fl7AscuPOHPe4
        EagjyT2UG4lKChzZj95XnLqyUlRd
X-Google-Smtp-Source: ANB0VdbnyIlLeBFZ6e5xbQm8Q82GbMsmWIJkXGn4dgaoEt/w52txYUUdorKdXdQYZANbOpUIxkxUSQ==
X-Received: by 2002:a63:a40a:: with SMTP id c10-v6mr2760960pgf.346.1535484831530;
        Tue, 28 Aug 2018 12:33:51 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id h130-v6sm2656480pgc.88.2018.08.28.12.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 12:33:51 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH net] net: bcmgenet: use MAC link status for fixed phy
Date:   Tue, 28 Aug 2018 12:33:15 -0700
Message-Id: <1535484795-31871-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the fixed PHY with GENET (e.g. MOCA) the PHY link
status can be determined from the internal link status captured
by the MAC. This allows the PHY state machine to use the correct
link state with the fixed PHY even if MAC link event interrupts
are missed when the net device is opened.

Fixes: 8d88c6e ("net: bcmgenet: enable MoCA link state change detection")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  3 +++
 drivers/net/ethernet/broadcom/genet/bcmmii.c   | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index b773bc0..14b49612a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -186,6 +186,9 @@ struct bcmgenet_mib_counters {
 #define UMAC_MAC1			0x010
 #define UMAC_MAX_FRAME_LEN		0x014
 
+#define UMAC_MODE			0x44
+#define  MODE_LINK_STATUS		(1 << 5)
+
 #define UMAC_EEE_CTRL			0x064
 #define  EN_LPI_RX_PAUSE		(1 << 0)
 #define  EN_LPI_TX_PFC			(1 << 1)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 5333274..4241ae9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -115,8 +115,14 @@ void bcmgenet_mii_setup(struct net_device *dev)
 static int bcmgenet_fixed_phy_link_update(struct net_device *dev,
 					  struct fixed_phy_status *status)
 {
-	if (dev && dev->phydev && status)
-		status->link = dev->phydev->link;
+	struct bcmgenet_priv *priv;
+	u32 reg;
+
+	if (dev && dev->phydev && status) {
+		priv = netdev_priv(dev);
+		reg = bcmgenet_umac_readl(priv, UMAC_MODE);
+		status->link = !!(reg & MODE_LINK_STATUS);
+	}
 
 	return 0;
 }
-- 
2.7.4

