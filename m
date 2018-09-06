Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB51C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B22E2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm2xsFww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B22E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbeIFXTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:19:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37239 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbeIFXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:19:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id f1-v6so5382646plt.4;
        Thu, 06 Sep 2018 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x9nbRVt55SCpVUTklCjGD2uzzSos0L7nziLG3uTKDHo=;
        b=Wm2xsFww6GSjDtluR7CCeKJnNkDoc+eykzvkAG9d7s6heENhGbZoRehW9A4r0XEcrf
         AWfukxwx6gMfjussox4P4oELB76YQjjGCaIV7P2f6NShcKigkI7fuiPSlDI8nu+3qyb7
         QIF0vPqjjF/vbRBpWMT5g3UU8BRa296CD2vDFyW+8DXfqkaCH4eDk2EoEmV+QvGmllDk
         ewwjn4tZZ9bag20C+QtRSNT1rTiAt8y5W0V3TIYiRAo+NYC2HehUWYawOEPHH2O0Dsyx
         mB+iIaUDHVUNgODStqyQYDjgrnuahhARz8o11JzjUzmnK5zSOD9E6/8KiI+vSC6lxvXt
         ML9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x9nbRVt55SCpVUTklCjGD2uzzSos0L7nziLG3uTKDHo=;
        b=RtBXEJZqYCRKJdynvaPoj47TOB55UVsdSOu4Ro3hKx0tkL46JXqZrr/khI///RIUsS
         uwFb2VuFqv0f7knIvt/Q9E7pTfhVz+gkhivs3VjlS7haitIi4yoTSK0K1HCcZ6Us7YRn
         64OsRlr2131TcYX+tv0mj/luV0zrFFHxFuvj9xtSq3297BKQFIOLdl5dKEU8d7cSr3FL
         QTH3sZzNxunKp32Iqi91ynEqQck73B3+rgtT0pcj26gJ91/1r2tffZMr14UyIkUSplho
         D2n3KoAm05FXXy+iBLHJW53056NqeK7+dJZIBj3wmt9itN1jVpeSRN1Ibvh54+HqbyQ6
         GroA==
X-Gm-Message-State: APzg51AC3FAjQoS9mnF2gamFOCI6CDIRk3FNuZJyog7Ycb5Ku3bqQUe7
        qje59lhoMFDUKrtcFcIgOQMxwk0Y
X-Google-Smtp-Source: ANB0VdZjeWSTibn0soahvAX+oOyyywyBdRw6Pgyuj9CxYSedJb6zGvzGH/mFrqJRAp0s9K1Uq8DDKw==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10-v6mr4138534pls.79.1536259372239;
        Thu, 06 Sep 2018 11:42:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n29-v6sm6807107pgl.30.2018.09.06.11.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 11:42:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Fix build with B53_SRAB enabled and not B53_SERDES
Date:   Thu,  6 Sep 2018 11:42:45 -0700
Message-Id: <20180906184245.31442-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case B53_SRAB is enabled, but not B53_SERDES, we can get the
following linking error:

ERROR: "b53_serdes_init" [drivers/net/dsa/b53/b53_srab.ko] undefined!

We also need to ifdef the body of b53_srab_serdes_map_lane() since it
would not be used when B53_SERDES is disabled and that would produce a
warning.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_serdes.h | 7 +++++++
 drivers/net/dsa/b53/b53_srab.c   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index e0674aa0167f..eed7c9357091 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -118,4 +118,11 @@ void b53_serdes_link_set(struct b53_device *dev, int port, unsigned int mode,
 void b53_serdes_phylink_validate(struct b53_device *dev, int port,
 				unsigned long *supported,
 				struct phylink_link_state *state);
+#if IS_ENABLED(CONFIG_B53_SERDES)
 int b53_serdes_init(struct b53_device *dev, int port);
+#else
+static inline int b53_serdes_init(struct b53_device *dev, int port)
+{
+	return -ENODEV;
+}
+#endif
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 149788697fd6..b0ed81876bae 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -390,6 +390,7 @@ static irqreturn_t b53_srab_port_isr(int irq, void *dev_id)
 	return IRQ_WAKE_THREAD;
 }
 
+#if IS_ENABLED(CONFIG_B53_SERDES)
 static u8 b53_srab_serdes_map_lane(struct b53_device *dev, int port)
 {
 	struct b53_srab_priv *priv = dev->priv;
@@ -407,6 +408,7 @@ static u8 b53_srab_serdes_map_lane(struct b53_device *dev, int port)
 		return B53_INVALID_LANE;
 	}
 }
+#endif
 
 static int b53_srab_irq_enable(struct b53_device *dev, int port)
 {
-- 
2.17.1

