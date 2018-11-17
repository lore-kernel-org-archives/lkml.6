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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FAEC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15F2082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hF2ENepf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF15F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeKREh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKREhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so3135694wmg.1;
        Sat, 17 Nov 2018 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOD1awuZF6odOFBkPMJ1CPZMTQu3oKzS+1l0zEYgy6Y=;
        b=hF2ENepfw22mZc3RuVtHsaqohTX+AF01BQDj23s1kUiE5/FNiLdqa7QdRrf7n6lkra
         JHm8gnDk/TAol5LAb/JOuptgetkh7JEWUXRl5c73WeDD5Jy9bbCuAUJa41MDbbpti1Tj
         WHN5r2Ox0BI9+fCXeFS2LyjZ/pLSkHCVa/7jyYRl4kUQz8LUxxsYK9F9YNQI9K3htFNf
         0Xm0ynT8oYxWbPozBOmt2YEqF/o/Z1g6h4QbINtNM0MUh7MmiRBJsMIxjatke4xASjFH
         4t6e7w8sYBs9IyVy4yeexeKYwvyo9ujOYnQ97QMacqwDFA6JWHw7Pm/0NM2YQANPiiah
         UkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOD1awuZF6odOFBkPMJ1CPZMTQu3oKzS+1l0zEYgy6Y=;
        b=jn29uWcUGqE5kgR5wG5WCb5IQTnYf7Hu9rRE5TI3pG/fKHO0sNBGqsKlXQ1AT5wxEA
         Xnt8xcm92Ihurf8ARrhsqw3VhPP2G81vbN6g/QAqyRir6rL575lC0DPZcgIL+wTr4c5+
         snkE1zcVxowZeXZ1xvHZWxQEcPn0epBxGY63OHxuOAWNl9lIVFUPV9+GCl7v38h3/n9t
         75+yy7yKBqYBH8SX67UWQ88+w1Ie2RXEw4vdQ/ZRZQHTN/UIQbFIQQtAalorUG1Pw3iX
         OUUObOJHDyTGlmiOuDHD+vUMIEC5jZqy6OXULAbxFokMrG5FhDMygaUy7X+spSem9ita
         JYCw==
X-Gm-Message-State: AGRZ1gJ/rCNKXpeVnonbFVxZ/nbnZQ87YfIFpg/GQ2/Lqo+dAuE2nrAh
        0y6YBza8aoYSwo/fCncgbaGOsVKsSqw=
X-Google-Smtp-Source: AJdET5cU3UEw8BLuZxmnAO1thjMwfSeOCtPliAlpUQBeDoTiAHaBvrEfaRS+slxwNsRhWXrvmyQNpA==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr2127529wmc.4.1542478824461;
        Sat, 17 Nov 2018 10:20:24 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:23 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/7] net: phy: icplus: use the BIT macro where possible
Date:   Sat, 17 Nov 2018 19:20:04 +0100
Message-Id: <20181117182007.14791-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the code consistent by using the BIT() macro instead of
manual bit-shifting for some of the fields. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/phy/icplus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index 3d3e9134c762..3ec470adde3d 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -36,11 +36,11 @@ MODULE_LICENSE("GPL");
 
 /* IP101A/G - IP1001 */
 #define IP10XX_SPEC_CTRL_STATUS		16	/* Spec. Control Register */
-#define IP1001_RXPHASE_SEL		(1<<0)	/* Add delay on RX_CLK */
-#define IP1001_TXPHASE_SEL		(1<<1)	/* Add delay on TX_CLK */
+#define IP1001_RXPHASE_SEL		BIT(0)	/* Add delay on RX_CLK */
+#define IP1001_TXPHASE_SEL		BIT(1)	/* Add delay on TX_CLK */
 #define IP1001_SPEC_CTRL_STATUS_2	20	/* IP1001 Spec. Control Reg 2 */
 #define IP1001_APS_ON			11	/* IP1001 APS Mode  bit */
-#define IP101A_G_APS_ON			2	/* IP101A/G APS Mode bit */
+#define IP101A_G_APS_ON			BIT(1)	/* IP101A/G APS Mode bit */
 #define IP101A_G_IRQ_CONF_STATUS	0x11	/* Conf Info IRQ & Status Reg */
 #define	IP101A_G_IRQ_PIN_USED		BIT(15) /* INTR pin used */
 #define	IP101A_G_NO_IRQ			BIT(11) /* IRQ's inactive */
-- 
2.19.1

