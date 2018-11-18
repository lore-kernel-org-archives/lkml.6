Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8FC169D4
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E032087A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="StG2PVR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E032087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeKSHpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34028 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbeKSHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so4728201wmg.1;
        Sun, 18 Nov 2018 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYMWIOc1d+rfElJqrVFa6XII7ZMFdv/DJnjqxoqEGUc=;
        b=StG2PVR6j0Km9GU/OjbmwkIPXRdT44ohyGMxJqRSWHh88wkuskV/g+JYuUjzZCOxKB
         k+t3Q2DK3VGFPZUvUDG03a0C2GczOz/PRGQXvcCaZJIk78NAbC/FlQsdQXX4d6SrOkgI
         zUZHJNgbOS3o9yiwXpcoZyYmYYSR0XEOVQhJhKz8OyupN5F761zbH+Lytc/Wohph3VAZ
         XDqnZKwA2lCsMumplZEJmcvd//2Of8yXhsjzrhAt6raMYOtk0pLYgItjunOPriczHbbb
         6n4vzM8+g9fLAp41aAivJSz/1jJ+iPHrLIC87TKQlLs7OS3ux9K1q0o7+BoknyD0Avjq
         NrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYMWIOc1d+rfElJqrVFa6XII7ZMFdv/DJnjqxoqEGUc=;
        b=tVzYsAJCkjM4TM4iXn3/GIa4UMF3HJNZ+E9YkepKt4Cmexm3qKu1rdCWoBJg7AVuuw
         +mKvRzj0VvsYnQeJGgHrUFCRrSxYK2fV7x1YiDJB8C1/cRcU4pFs8/7kbzpXUovBMp2b
         qKEAETpRKo4ZQ0Sp3KhfO5plFob2WktOMa3iXUERIy0in/pnkRXaaMLgB1oQo3zRrRqi
         PrUjwUMeFMq9N4zxU5CIEvwrzYC2If51VKwiaBsd1SFcktuUZLVbhl1zq5Hj+y6uqZIP
         kANzII8A5LwIXa802b/RWHTf+9z02ZH+Y+1LM5oj7BikivNGnCrLBSO6z2NA6Q7Yf2xN
         Jm3A==
X-Gm-Message-State: AA+aEWbHktVi6DORcYy041F1NGqYSyZkL1bw6fsebF11WKwTz+SJQzNq
        KHHp63FVyBl3uIWuJ1j5H8HkWV+84hA=
X-Google-Smtp-Source: AJdET5cq1HM0lUlUKUT8LWW2rVjx2mm2lzaLvukWMnCAHHhNYcVzTBxcO3XR1zk4BdVYzaDCYLS5Ag==
X-Received: by 2002:a1c:2304:: with SMTP id j4mr4945784wmj.14.1542576255561;
        Sun, 18 Nov 2018 13:24:15 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/7] net: phy: icplus: keep all ip101a_g functions together
Date:   Sun, 18 Nov 2018 22:23:55 +0100
Message-Id: <20181118212359.32414-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simply moves ip101a_g_config_init right above
ip101a_g_config_intr so all functions for the ICPlus IP101A/G PHYs are
grouped together.
No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/icplus.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index ad87bd3280d7..3d3e9134c762 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -162,21 +162,6 @@ static int ip1001_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int ip101a_g_config_init(struct phy_device *phydev)
-{
-	int c;
-
-	c = ip1xx_reset(phydev);
-	if (c < 0)
-		return c;
-
-	/* Enable Auto Power Saving mode */
-	c = phy_read(phydev, IP10XX_SPEC_CTRL_STATUS);
-	c |= IP101A_G_APS_ON;
-
-	return phy_write(phydev, IP10XX_SPEC_CTRL_STATUS, c);
-}
-
 static int ip175c_read_status(struct phy_device *phydev)
 {
 	if (phydev->mdio.addr == 4) /* WAN port */
@@ -196,6 +181,21 @@ static int ip175c_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
+static int ip101a_g_config_init(struct phy_device *phydev)
+{
+	int c;
+
+	c = ip1xx_reset(phydev);
+	if (c < 0)
+		return c;
+
+	/* Enable Auto Power Saving mode */
+	c = phy_read(phydev, IP10XX_SPEC_CTRL_STATUS);
+	c |= IP101A_G_APS_ON;
+
+	return phy_write(phydev, IP10XX_SPEC_CTRL_STATUS, c);
+}
+
 static int ip101a_g_config_intr(struct phy_device *phydev)
 {
 	u16 val;
-- 
2.19.1

