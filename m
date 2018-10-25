Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53301C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B592082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewDmsgJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B592082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJYThw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:37:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:37:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so7768437lji.13;
        Thu, 25 Oct 2018 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x0pq+cfqta3t8LmAMvxjEl1jR9/Kl/k247PxX2X1veE=;
        b=ewDmsgJm+8+y2KlpJrK4SG3KP4QsFOdatB4LcyvLrBrDWDDVb92iiOUOcuJk+RJhmz
         8ShBdp+atoSlLAfpNdZfG3Uzo/kw0T2+gCJZr1kasq+EF+Bm9S9RgOZXZ2P9K7hWDbrU
         Gk/0oLfUx9PNUzi0E3hzaJBhn4s8RjzXtzXpanztdk0yPmr3dnxTGWyNxCgH5yyoTjCS
         63a6XWt+1ZF+2pr7O1DIBd4+Qyq72H/q7fXN/tfUvoCxXt+u2Odxx36nZts0i5eNSV0T
         1UXJ2ntdUhY2ldYmT994ZZcfr5wMFEfoZYgfEnpFONnfKLHWF17GLhZh+VX/dA8EgS/N
         tr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x0pq+cfqta3t8LmAMvxjEl1jR9/Kl/k247PxX2X1veE=;
        b=AR07kU0bq8XMdukT6brf+Rc+FREUl5lYhP9Hb4AIZbj2zu0D2qjwiMdW0isSuty+HT
         GtDHbBDcUCRs/bZMFABXcbe586+wbo1UvO5Gab2UhLkmtq4mQHluTZbiG80Ie42e1lHs
         pE2nKKqQz2PyUrBa2Sf2FiwPfsOnyeCZgGyaw/HOvGpXeS0b966Rld4QdMOgeLjWypYk
         2D1q1iQ3fsNqtU7YKgnx85QiLH7KH922a0RXsEXyMpe0GnB9U1Kj94GVy+zn6jOzrZ7Q
         5h9W7cQ3N/LeJO68uRiVV32Du3C/Z8984sLYS3b8hdM6UZXIpN107o1t1GdLW+pqcJRd
         5jrw==
X-Gm-Message-State: AGRZ1gIMDg20dcLJ7NjnZJGvjFoYxYpMQ7VCyyP3sXy4Mvcax3EdGgnk
        Cx//u+oLPeh+5/f/3YghFIFKeysC
X-Google-Smtp-Source: AJdET5eGt8IoRe+W3vcJv4I7zOLJERPvvW7m9GCRdLl01NGYE6RWFCtj+T86zFj2L+lFm7XdtKQOpQ==
X-Received: by 2002:a2e:a28b:: with SMTP id k11-v6mr947662lja.24.1540465533793;
        Thu, 25 Oct 2018 04:05:33 -0700 (PDT)
Received: from maxim-H61M-D2-B3.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1103773lji.36.2018.10.25.04.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 04:05:33 -0700 (PDT)
From:   Max Uvarov <muvarov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        Max Uvarov <muvarov@gmail.com>
Subject: [PATCH] dp83867: fix speed 10 in sgmii mode
Date:   Thu, 25 Oct 2018 14:05:30 +0300
Message-Id: <20181025110530.22826-1-muvarov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For support 10Mps sped in SGMII mode DP83867_10M_SGMII_RATE_ADAPT bit
of DP83867_10M_SGMII_CFG register has to be cleared by software.
That does not affect speeds 100 and 1000 so can be done on init.

Signed-off-by: Max Uvarov <muvarov@gmail.com>
---
 http://www.ti.com/lit/ds/symlink/dp83867e.pdf
 page 87 for register bits
 and
 page 23 last sentance that bit needs to be cleared.

 drivers/net/phy/dp83867.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index ab58224f897f..1df4da3f70a9 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -37,6 +37,7 @@
 #define DP83867_STRAP_STS1	0x006E
 #define DP83867_RGMIIDCTL	0x0086
 #define DP83867_IO_MUX_CFG	0x0170
+#define DP83867_10M_SGMII_CFG  0x016F
 
 #define DP83867_SW_RESET	BIT(15)
 #define DP83867_SW_RESTART	BIT(14)
@@ -79,6 +80,9 @@
 /* CFG4 bits */
 #define DP83867_CFG4_PORT_MIRROR_EN              BIT(0)
 
+/* 10M_SGMII_CFG bits */
+#define DP83867_10M_SGMII_RATE_ADAPT		 BIT(7)
+
 enum {
 	DP83867_PORT_MIRROING_KEEP,
 	DP83867_PORT_MIRROING_EN,
@@ -285,6 +289,24 @@ static int dp83867_config_init(struct phy_device *phydev)
 		}
 	}
 
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
+		/* For support SPEED_10 in SGMII mode
+		 * DP83867_10M_SGMII_RATE_ADAPT bit
+		 * has to be cleared by software. That
+		 * does not affect SPEED_100 and
+		 * SPEED_1000.
+		 */
+		val = phy_read_mmd(phydev, DP83867_DEVADDR,
+				   DP83867_10M_SGMII_CFG);
+		val &= ~DP83867_10M_SGMII_RATE_ADAPT;
+		ret = phy_write_mmd(phydev, DP83867_DEVADDR,
+				    DP83867_10M_SGMII_CFG, val);
+		if (ret) {
+			WARN_ONCE(1, "dp83867: error DP83867_10M_SGMII_CFG read\n");
+			return ret;
+		}
+	}
+
 	/* Enable Interrupt output INT_OE in CFG3 register */
 	if (phy_interrupt_is_valid(phydev)) {
 		val = phy_read(phydev, DP83867_CFG3);
-- 
2.17.1

