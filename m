Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E998A20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kGx6w/X5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E998A20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeKREh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeKREh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so1553337wmc.2;
        Sat, 17 Nov 2018 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYGoom25Br6V0N2ceQU9TtwhEgL5kaByknhOX/P1/ao=;
        b=kGx6w/X5zV3Hs1b5RMHI5s6G/Xendu7Jccjs2zH2mt1s+OUmv2SUlU9MsOG3PJt0xQ
         rITR4rl+8SvSIF8nPqaVEtdPsef+Nelxq2wE6ltDLzkw7Qbm/uodlWit7o9sRWIOhJjz
         f1juL5oDHJJn/ZGYAtzCJHTqLD6Z8Lt2AeV43CV9dHltGK0lr5LDC2ImvcY4ylldbm7i
         S01ALs5RBZSIr6LiEErfUdF192kVCl5bySUbR69wQLqFhxwbatdX/blCOjsVItIrNlr0
         7th+TLIaUiP6dyeFlzRXmNK3KpcIu6+FIp7AO+PBVR8Bp4xrtXdw6znyheSnbx/6+ynt
         raGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYGoom25Br6V0N2ceQU9TtwhEgL5kaByknhOX/P1/ao=;
        b=cYu8EI2Jz8J0QpefMOmwtBr5Bd5jtkF0dxDAQNJNKBBp4ELpGgUtQvYcjMgKXmtgJR
         7mADTlAKwycgweSLZnO80lEnNaPbpbPlnI16s51XNaJTiV4a0pdK15IX0OlVvycz5wo7
         ZUL5nyb5iP0gzFmvX5qO183FG2qbXqNLsJNr/t20znrSdqKrUQ2tNntY3oyXz/fVnsEy
         0n0rIhrcmApXOw5fPop26dCHIN50GAmsor3mzBGZtoQftQ/F/tN3Q3wvT3V3xZFwNbJG
         9k1nO18UfrXTFx+hc7ep1tDFScdc4HMeyrGN1AR6qQDOjXjWZWVD+7i0H26e+iGw4Ycg
         Y5lw==
X-Gm-Message-State: AGRZ1gI5NmFPJUbvGTH3nZaHBKzOcaCQxBKtCLy7GDUxZsCqRyLe1TP+
        g34H2l07Oe48fp/963f5Ssr72xmW71o=
X-Google-Smtp-Source: AJdET5cpzC+OJa+JBH/sCV+fliK2bODx2dp3J8XFzYPbA/4O0QGO1AW8kEFuFlrl5Efszya/XLAvAw==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr2081777wmg.23.1542478826491;
        Sat, 17 Nov 2018 10:20:26 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:25 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 6/7] net: phy: icplus: implement .did_interrupt for IP101A/G
Date:   Sat, 17 Nov 2018 19:20:06 +0100
Message-Id: <20181117182007.14791-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
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

