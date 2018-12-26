Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277F21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MAiNKHxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbeLZEIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 23:08:51 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33714 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLZEIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 23:08:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 43B72A69
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 11X_36aLiShV for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 22:08:47 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1907EA98
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:08:47 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id t143so17637236itc.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AzSmwRCT9p7aBl81Q9ChFuNFBbwZF8tz5YO1aR1UGEw=;
        b=MAiNKHxjeUgWdwt6T3Khxoz4u/b5RSfaLAAFQW+fqoYr2ABkF5IrVPZcUVZRkF0LoI
         3+7zPMZj9Clcrs+dHsej9Wp/mwxRm9XIFhmA48J1j7mGbQF9hguxiV9tZPB0f5RY4xmJ
         cGG5zCadbxO9uZW+9fsRrOO5DT00f4JFkj0b7sZ/bDwlQDwpj3EXWgxHHImxzGl5uISq
         QHvEC1rBYvMQX+jxS7+UbXXVU4g/CEn5pGuJER3u+ABoz22sU2hBLOrTGIkNWoZPxihU
         s9qCD8HHjYPvbJmzxp3gkqfxwLFoplTSV7Nd8E31JeOSWXTp8TskoNmY5qG4M7kfABoH
         8G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AzSmwRCT9p7aBl81Q9ChFuNFBbwZF8tz5YO1aR1UGEw=;
        b=CBUFnVycKssa4XYHC2aImWMe/AVX3hAzzlqKIXk8Tyllf8R+GFz8UvgeMtR4bzVKUL
         KUC6PdzENUBDdzOn3HTKOmcUpnh2PTQ/liJs6ykGLIIzWCVV0oZCb3QZ/vSM2UTwLZ79
         1snGMbPKxFpMwHj9iDswnoqgK5WkVXml0geKW7ShH5FEz4uUq9+pc6mN7fm//MDh6B/x
         ZxCH98xeoMxHd3eEy/K1uqScGviaT/M8FsRPWOmxDwlBWZnUq2AqJOwIFeZr+7VI5oRw
         9GwQx23aLtPYNj8WolcFpGPW1EydZiJGqnE2OzDK5LVfq7rLYi97hynuNShNBC0Eu3wZ
         frGA==
X-Gm-Message-State: AA+aEWYgYVEn/2mjLyC6jbF7toJU1DpNQ1NCfl6ldlYQf4nQn7ALoWAF
        +eWG6ihS8MAuxCxJdyJXWlR57/90DqS+eXAleRTWweLoNMzpWJOAQ7Gug/tDer8ZO++nFKv0m8y
        3C9T2ykqGr+MHIRERuSl34FpAOjdP
X-Received: by 2002:a02:a990:: with SMTP id q16mr12264151jam.132.1545797325759;
        Tue, 25 Dec 2018 20:08:45 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VEdsOKlA0VBE25yM58CQfIPB7/tqepOJ0776ooguTOKVtGr7asuTjms7rHhrqcvFbh8WoTMg==
X-Received: by 2002:a02:a990:: with SMTP id q16mr12264145jam.132.1545797325561;
        Tue, 25 Dec 2018 20:08:45 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id e16sm17199035iob.43.2018.12.25.20.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 20:08:44 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dsa: return error code upstream
Date:   Tue, 25 Dec 2018 22:08:18 -0600
Message-Id: <20181226040818.73764-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
return their error codes upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/dsa/bcm_sf2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 2eb68769562c..441fea57a7ea 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -303,11 +303,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	 * send them to our master MDIO bus controller
 	 */
 	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
-		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
+		return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
 	else
-		mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
-
-	return 0;
+		return mdiobus_write_nested(priv->master_mii_bus, addr,
+				regnum, val);
 }
 
 static irqreturn_t bcm_sf2_switch_0_isr(int irq, void *dev_id)
-- 
2.17.2 (Apple Git-113)

