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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED2C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472FF2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C5Rd+VdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472FF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeKSHpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeKSHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so3402864wmt.0;
        Sun, 18 Nov 2018 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KscFh18vRIxTCpnO55pgvkmxg3jZLMB7zUvoRJGjL0Q=;
        b=C5Rd+VdGt+GL0I6HULC7sg3a2OLF/DmegElLltlQsabP4hKoWQvCVjBqLoI61lyPpL
         xuMWiGw0oBWLZ8Mt3Eg0arTZHp7XnsPpEY9ey3aaebS8AIeZ/venmZiJF/hV0+8mN2KI
         TXQV2szG4EymkdALgE0cJAC5m5C4qg7ueScJCaXdim7FEWhtvqiRHGblxm0M+YguB3uc
         5Mik+ZAOTegA2BNNr1vlZKAfoGaAWNc6iQnGvNfwFy0ZON8Im8ZIFJODd/UlKFiG9ZdG
         MfpdpRnB9naS2qIwn1pRP96lOGn70C9gBsSyCuOQukIvv+A8gyUoFH/xbWrTDQMjPvs8
         68Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KscFh18vRIxTCpnO55pgvkmxg3jZLMB7zUvoRJGjL0Q=;
        b=pGsE29Z/z9GhjaMHovc3l/WK9MojoALGi/lU4CbX1VUVU1SE4ShRZCArffj21WoyLK
         it3uw5XxL3Rw/1CYhdfsyqhk9GRvf1HlhwjRQ9VFOfGAgvnxVKCYkliCovaXaK0YkchQ
         bvYrpsSHK5g588kQE2Tdrg73BZEVVvR93Wl7+K6WZ4/Oug5qO1yGWiSW0eN2zpvz1QAS
         4PT5d2VpPEw97Wn2LucWLj+FQIn8GLgJzq4t+/L8UmaWSwg5MTjlln7L3HthMX3oa9XC
         IfgFCLvE+l1eDU7Gy4tlSOfvwnh5iaJMjR3CKg6Ku2MCbk0yydSBhbXvFVe2WIq6Q4a7
         khlg==
X-Gm-Message-State: AGRZ1gKC8VzKokI2YIyYnqaeAAg5DgLaqD0L7et+NWFrXBmi/a2dnMvZ
        vPPohIJ4jSHtNG77JYLTnuU5Z49q+1k=
X-Google-Smtp-Source: AFSGD/W87EMWBdWbBA73qRv7p2EULH+6959kgRMw/G/pGSQOavXTCR2bD6kiMFCUoOibVMQ7iBNjNQ==
X-Received: by 2002:a1c:307:: with SMTP id 7-v6mr4984763wmd.146.1542576257868;
        Sun, 18 Nov 2018 13:24:17 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:17 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 5/7] net: phy: icplus: rename IP101A_G_NO_IRQ to IP101A_G_IRQ_ALL_MASK
Date:   Sun, 18 Nov 2018 22:23:57 +0100
Message-Id: <20181118212359.32414-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet uses the name "All Mask" for this bit. Change the name of
our #define to be consistent with the datasheet. While here also replace
the tab between the #define and IP101A_G_IRQ_ALL_MASK with a space.
No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/icplus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index 3ec470adde3d..c9489ec77cef 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 #define IP101A_G_APS_ON			BIT(1)	/* IP101A/G APS Mode bit */
 #define IP101A_G_IRQ_CONF_STATUS	0x11	/* Conf Info IRQ & Status Reg */
 #define	IP101A_G_IRQ_PIN_USED		BIT(15) /* INTR pin used */
-#define	IP101A_G_NO_IRQ			BIT(11) /* IRQ's inactive */
+#define IP101A_G_IRQ_ALL_MASK		BIT(11) /* IRQ's inactive */
 
 static int ip175c_config_init(struct phy_device *phydev)
 {
@@ -204,7 +204,7 @@ static int ip101a_g_config_intr(struct phy_device *phydev)
 		/* INTR pin used: Speed/link/duplex will cause an interrupt */
 		val = IP101A_G_IRQ_PIN_USED;
 	else
-		val = IP101A_G_NO_IRQ;
+		val = IP101A_G_IRQ_ALL_MASK;
 
 	return phy_write(phydev, IP101A_G_IRQ_CONF_STATUS, val);
 }
-- 
2.19.1

