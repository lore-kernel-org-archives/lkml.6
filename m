Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E65C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C5820817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OTngOWfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C5820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKREhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34465 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeKREhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so3135675wmg.1;
        Sat, 17 Nov 2018 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yRshoTlbJU8ReR5pMJHtrEv7ruvlij0JSHTbvXWAr4=;
        b=OTngOWfMoHAuvn7DMLJZfu4OJpZ/bgklfLWU1rc3skhTEtWx46b6rjzsXXdKPIZJf5
         n/x0LcCpKBNK+jdUPWqxA6kPWvlVxUbf5+uvSUVxxxsrJn/fjmG5AjUinRPNOWy/UVR7
         Wg2NQgKHgPmmTjWBBEuOYjj4+h4wNkTvedZBWt12mSRjsLbmKJejRyWPLyNeYV1b7/Rb
         Sh9R/ZhavlrHddxVy9VrtdBiEQ9A4QJPNyiIzwLI5Vz/IJFOiaJ6EsB4BxgFFN8aKrfB
         Ma7OH4wrp+rZWYBCswcOedFPVVZMXG8jJITJKcCmJexNfWQ8LS0DMs10Ilql7ju6Dhu+
         3WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yRshoTlbJU8ReR5pMJHtrEv7ruvlij0JSHTbvXWAr4=;
        b=HLxXcU/Vj3xcEapyavcgNRJYPNN3z58Z0ZYBmShqOVjtzvObiyjSS9JLvpDQkfp1A6
         P3m6RQ07xfCdHPB7M2OES84mWmRZmO779lpvpHMdXRYHu2XXJvhImYwhyWpIoVn/3Ku2
         iq0S+YoIiIy1HUm1yfbskHbyHzjQYIA5GBLGqoQUwDJJmY//ArjMfqN70BMqEIoV7+GY
         RJ0kszQesC+lh9EIWStbFQayJOT8ZtHru9RBY5yscY7F5hW+WjyhUd020Gpieo+RRuer
         JYbxLuO4YCtq/y7giPzZz7yWx12B+jEZSxeDCM1vkNtaGLfAKRtd9k/3rJfqwOly4sgm
         1iKw==
X-Gm-Message-State: AA+aEWb4HEIMt/WYJxYrmr0tF7BuisHDn4+Dm0NfIClGBxJ/4xekoTJF
        lKL5jkGP6AMG0CLofMW2gGCQKKmAcmw=
X-Google-Smtp-Source: AJdET5fI7WTwCOMfDYDqvt6af7MsgXXFZJgH1uCKr8IPXF8kZbC7ew9cARGDCNsJeyPr3WIsS8fJSA==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr2131897wmo.138.1542478823237;
        Sat, 17 Nov 2018 10:20:23 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:22 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/7] net: phy: icplus: keep all ip101a_g functions together
Date:   Sat, 17 Nov 2018 19:20:03 +0100
Message-Id: <20181117182007.14791-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
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

