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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04976C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA572075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iNQU11Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA572075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeKSHpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54375 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeKSHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so3422937wma.4;
        Sun, 18 Nov 2018 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2coiUdTpsMAJ+bAjU1EqD4XJbssWadzLXVEGEHao8U=;
        b=iNQU11GkbPMBQ8E1suWe+CplEdwrmdAb77OWjUzaKVCYa4+jTimkBnHspkv0ac0tpZ
         u8A/3A36vDSb802cGho8Jmn9lkOoYXcyV8Pk7bfcM95oC/79BGwAatAfKWnyWbtcj/5I
         9p+wBcqcCs1VrvDkCUYTJJVf9hvaB48IWRjipJQ/ZB6ZcDelrw7ftPIiUqVysJUX8HRR
         yh8XskDR+nZ5ZopPDNeG+O9wIaJp1dIlo8Yo4qp/lrZbIEBAR8pcxYyEes8h502G3JJb
         /Gy3yRKQ3mneX3QIKC8yllcS1aXzu6oA8I8D2hupJtHIasuVSVsUwzc/Rr9a5Nrwyu39
         UBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2coiUdTpsMAJ+bAjU1EqD4XJbssWadzLXVEGEHao8U=;
        b=Iu4l9W3SQsp1y03A9D6dMeMHYm2bSvyH+bzcFRmk4hDoiEqofMx8SGhQkL+a3i/yMG
         Mzf62I2XAla5bNKGPjbF3HCYwVNDje8wPSnBuiC2JltIdutVUaAMZP+c6yyvdr2LUyop
         KO5k3ygI+tazbOSqGAStf4CBOLd0SBNpjohPn9UjIjuaRDE1/bqNNNsZsBoNu8kaBZkh
         /4BZAhH92ND95ZnTwTaSvmsYPJPnylqxNjFUC74eiK7SFIyOi9fhKJ/fwIW7NEI2ExJ7
         WPeXbw/UuZVjRPSIsekTNpHJN7JziADgc2D4zkhcMDGvl77MC5FIEH+7yln7qYKtPji/
         gMqg==
X-Gm-Message-State: AGRZ1gL+oo4gDUIzuVOsgzzZFPm/qNdfLhAsaYLDze0MtqgphuU3kLbv
        IHYhGj253D7c4GaHh9E08M42WxKMBEc=
X-Google-Smtp-Source: AJdET5eZbaQm7VXurbMiqkau/rAGPybcNS4NWWbk0cxq+93fybNwNuqnEYwAmX6JPCwSlXJvv4s/Cg==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr4828701wmf.47.1542576256725;
        Sun, 18 Nov 2018 13:24:16 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:16 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/7] net: phy: icplus: use the BIT macro where possible
Date:   Sun, 18 Nov 2018 22:23:56 +0100
Message-Id: <20181118212359.32414-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the code consistent by using the BIT() macro instead of
manual bit-shifting for some of the fields. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

