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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6D2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BF52075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bVVhLnm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BF52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeKSHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54070 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeKSHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id g131so3018662wmg.3;
        Sun, 18 Nov 2018 13:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQcer1PYC6uf+nevCssWpxdorG7rVFWdADxdb7flNgQ=;
        b=bVVhLnm4Wgp/E7W2/dsk39bDM6jCqmFbWzbw9+fZj9vp7FLlCiizwPfWj/0XoL5oNs
         3znvHdV0eNb94q/KmA8979REUiS4rRE/sPR1LJvZql2rpko8UfMHRflW2H8nKPxAkMOd
         gt36MmQ8cYx6r9yz8OrO9G7xzgrCAa6UIx+EzzF+2zdY3Fb9W5gXCB1fQg8tjItyFjtr
         i/kjy3TBQLfOZoYfiA7TOx4EqAyw9n0H4lNxgkEl0BHRiGnxZ7AILA6Z+JLJgutX9Ww1
         uMgd2lORdU4+oEE2awD2rCcxyLUrG54nFRKVc74biv6KVk90JAvk67DautRCHIwim9ub
         FmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQcer1PYC6uf+nevCssWpxdorG7rVFWdADxdb7flNgQ=;
        b=ZJ2dnUwONrFBZ+z4iZSG5sHGhqNcA99WWUGCOfKW5oW3J632iKfB/fcUsMUDcBkB0L
         4jpP+GhoDUc6sjPHEu/CoFOeI1ueEW0GoE2clxLqo9xg3uf4QcBKJXA8w83vKEL+yLJm
         TB8bBJw1XTnhVyO47e1+yFjW5Ct1+sEN+56PM+m1XoQN0F3MDSk3gQ54x5btLGJQd52X
         kkBVwQ5CoU0pRzMBKkIJizPvyLdknhgKmoeMF+GwBK+F54CS1HFWe0Dg8TlV2AM4QPAo
         C4dBNP8a38H/O+PsVxBNqyIkhNUGXR82oZJxufDUNb05CkVByP8U0rLty9VAXBghjTOu
         47Fw==
X-Gm-Message-State: AGRZ1gIFXUMyWqBlx1BLqC2XkffVamcQwPd3fA448VVEbIagpAuIvVyA
        +1su3xgPmvev7b2YRsrjWreA1heQVvo=
X-Google-Smtp-Source: AFSGD/UVyj6l1BJC1Homn0mpjcQY+HTPTw+hCww1WS9p7tFJE3hsdDP25dLVz+wncQZ1PAIuxnticw==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr5105985wmi.144.1542576258973;
        Sun, 18 Nov 2018 13:24:18 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:18 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 6/7] net: phy: icplus: implement .did_interrupt for IP101A/G
Date:   Sun, 18 Nov 2018 22:23:58 +0100
Message-Id: <20181118212359.32414-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP101A_G_IRQ_CONF_STATUS register has bits to detect which
interrupts have fired. Implement the .did_interrupt callback to let the
PHY core know whether the interrupt was for this specific PHY.

This is useful for debugging interrupt problems with 32-pin IP101GR PHYs
where the interrupt line is shared with the RX_ERR (receive error
status) signal. The default values are:
- RX_ERR is enabled by default (LOW means that there is no receive
  error)
- the PHY's interrupt line is configured "active low" by default

Without any additional changes there is a flood of interrupts if the
RX_ERR/INTR32 signal is configured in RX_ERR mode (which is the
default). Having a did_interrupt ensures that the PHY core returns
IRQ_NONE instead of endlessly triggering the PHY state machine.
Additionally the kernel will report this after a while:
  irq 28: nobody cared (try booting with the "irqpoll" option)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/icplus.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index c9489ec77cef..3dc8bbbe746b 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -44,6 +44,9 @@ MODULE_LICENSE("GPL");
 #define IP101A_G_IRQ_CONF_STATUS	0x11	/* Conf Info IRQ & Status Reg */
 #define	IP101A_G_IRQ_PIN_USED		BIT(15) /* INTR pin used */
 #define IP101A_G_IRQ_ALL_MASK		BIT(11) /* IRQ's inactive */
+#define IP101A_G_IRQ_SPEED_CHANGE	BIT(2)
+#define IP101A_G_IRQ_DUPLEX_CHANGE	BIT(1)
+#define IP101A_G_IRQ_LINK_CHANGE	BIT(0)
 
 static int ip175c_config_init(struct phy_device *phydev)
 {
@@ -209,6 +212,18 @@ static int ip101a_g_config_intr(struct phy_device *phydev)
 	return phy_write(phydev, IP101A_G_IRQ_CONF_STATUS, val);
 }
 
+static int ip101a_g_did_interrupt(struct phy_device *phydev)
+{
+	int val = phy_read(phydev, IP101A_G_IRQ_CONF_STATUS);
+
+	if (val < 0)
+		return 0;
+
+	return val & (IP101A_G_IRQ_SPEED_CHANGE |
+		      IP101A_G_IRQ_DUPLEX_CHANGE |
+		      IP101A_G_IRQ_LINK_CHANGE);
+}
+
 static int ip101a_g_ack_interrupt(struct phy_device *phydev)
 {
 	int err = phy_read(phydev, IP101A_G_IRQ_CONF_STATUS);
@@ -243,6 +258,7 @@ static struct phy_driver icplus_driver[] = {
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
 	.config_intr	= ip101a_g_config_intr,
+	.did_interrupt	= ip101a_g_did_interrupt,
 	.ack_interrupt	= ip101a_g_ack_interrupt,
 	.config_init	= &ip101a_g_config_init,
 	.suspend	= genphy_suspend,
-- 
2.19.1

