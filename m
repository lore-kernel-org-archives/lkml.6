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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2862C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E69920815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OPUYqzJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E69920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKREh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39650 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeKREh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so1555956wmc.4;
        Sat, 17 Nov 2018 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJpIgwlsTe0LOyUb8MnWA+b5vKEsUgRJ4aTegvVUKRg=;
        b=OPUYqzJujt82fGyg+rpZ0YTFgQdVRF9nZblyJpa9l6d8oeLHgREb6WK29lkx6mhCvK
         ZIjA/k7PVrMhP41lvmpavdNMgsU6XvBaJ0wshILTKmGMS5KCeYEs0n8+9taEjYDDuAt0
         nsUMsUJXiII3a+jM1I+9SrfsYhmvSJsrKHifY2Co5bqSpzvgdNfZi4oqaR2RzhaXsbAr
         2W2D9erQJJghF+yu/whPHua+Q3l53T6wH773SG9xRChQLsp95oCglPnQtixwbW4TMruj
         DPrg2veWx5Tv3r+D3BoGXiuVjtbHX5l8O5iDTTEyRRgDCi3Pb3eIPZjsCehkf+epHMBL
         Pb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJpIgwlsTe0LOyUb8MnWA+b5vKEsUgRJ4aTegvVUKRg=;
        b=ULON0JFPi+W4rOnukUGhhAQI4jjjqaVpoMYxSDLUTfkXuWh0pqzrnpBJrdVzOSyC8q
         JUFO+b3A4FHExeA6GgGEuLzdt3buMdc885RbD8cUCl6ZgPJb+xzWMhBrXBX+CnqHi7Pp
         mmd9+wMsptz9IX6IOdbuCvl2VV+gZM6IPejKrIwYshdcEznft/UIkXqexy0u+Ax441YS
         hYPMTe+FRriZoJ08HBqOBUmxbAjergN2LsI8id4QWSdEgwFZ3R1zBaER2qkA+ZMbwreN
         VcucgSNWQgh6Rhz5W7Ei0kraySOaqNXfSkehklqrQg/tI69XW9js0MqJLHYc/dBiOtoJ
         Vs8Q==
X-Gm-Message-State: AGRZ1gJl1yog/KsP1Sz5sDW2yMGDYStY6J5hUQpwGIZMc80bf2Y4+hfr
        WP8Hglfzbh+h8/NrwaYewdM2DWi7Ouw=
X-Google-Smtp-Source: AJdET5f/cYvcwmM2I3IdwM+D7j54901R3tktq4DBGAjH+0KGM+cjMAsioE2S+R4ENgFaD+Ww3+Va0w==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr2120303wma.91.1542478825458;
        Sat, 17 Nov 2018 10:20:25 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:24 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/7] net: phy: icplus: rename IP101A_G_NO_IRQ to IP101A_G_IRQ_ALL_MASK
Date:   Sat, 17 Nov 2018 19:20:05 +0100
Message-Id: <20181117182007.14791-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
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

