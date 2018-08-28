Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11585C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10BE2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhPxZtss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10BE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeH1VrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:47:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41012 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1VrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:47:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so1048464plr.8;
        Tue, 28 Aug 2018 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8MDTaGU//iqm0vbcxHeF2lK9GzB0/8f29KZfhaAPV4=;
        b=hhPxZtssdfWe6ylIJ9CU8xNx4d+OVRwqXDeIgMEGIP23fjpHVourxxL1GyfzP29L4q
         ntxifcyw9IzO30Q53emJhE/i0w6aJt21PtK5hWaHXCRLBuIBFiqOzpNivKDNqYb1ElRR
         fOfj89DcAgjYbqhw+X8d15WTkyfaARHQKlDDpAYzFmGkoLqVtPnDAp1SsOe9diif278f
         ZHMqHveexiG6wPrYn+fdYWoD7X2oZ/crdoVDkuOuWdOGPYzch4j1ZGBU3t7n7CUcmQHp
         osjmiY12xu7ahkyB+kXsBk6Xx9NMmZvJMsKSlYiFBirbcQ6if2uu0OnIZhxogaokSdzL
         AlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R8MDTaGU//iqm0vbcxHeF2lK9GzB0/8f29KZfhaAPV4=;
        b=Kz6tqNj1dWrqQo5tCiAVK4txzRFoOUhmjuM9V+L3vZnCN0Cp3rLSczF5eu2ed+5RyU
         7JQIHfmW2taBayl5AP/cquVuwN+K9aSFghWlLQdvu8IIy7s3fsYmVTK3wZrqx6v1ltoz
         JXiJ3L8fc8w6M8EWZsNHrCupFj7VItQawcVJqesR4c/5pOUSW7T7omgwyk4CGaXw1DiN
         9TxwGEhFiu3VxA0TznF/UE6ePPCFuBoiOOzkQJYkJ4jJZ7LNOENpZ2JrAQ2InkI/+Cwc
         vGBkIiXvl4jqP0BFi4JEpiT8q6V1QKnTDWawaCGGypmKyAatb2lKiWy9HyevW/V3njSV
         pVrQ==
X-Gm-Message-State: APzg51CTMSwWy9PR4u3c0qqmUbgtAfpy/Bua+3QPk5AJDieLhoYdTfK2
        3TExfgQsYHqKnY49bVLlrNk=
X-Google-Smtp-Source: ANB0Vdb9j+sGJa8UODcnCPWvaWOs+QgvrQoyqCcpBWkomjzd8ebEB9zhzXYTMyOCAgRqEn4l1Rm/vw==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr2514348plc.270.1535478874188;
        Tue, 28 Aug 2018 10:54:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v23-v6sm2664465pfm.80.2018.08.28.10.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:54:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH v2 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
Date:   Tue, 28 Aug 2018 10:54:18 -0700
Message-Id: <20180828175420.7992-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828175420.7992-1-f.fainelli@gmail.com>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SFP connected to port 5 of the switch and wire up all GPIOs
to the SFP cage. Because of a hardware limitation of the i2c controller
on the iProc SoCs which prevents large i2c (> 63 bytes) transactions to
work, we use the i2c-gpio interface instead, which does not have that
limitation. This allows us to read the SFP module EEPROM, which would
not be possible otherwise since it exceeds that size during a single
read transfer.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index ea3fc194f8f3..6fa0d8d1a218 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -58,6 +58,24 @@
 		open-source;
 		priority = <200>;
 	};
+
+	/* Hardware I2C block cannot do more than 63 bytes per transfer,
+	 * which would prevent reading from a SFP's EEPROM (256 byte).
+	 */
+	i2c1: i2c1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c1>;
+		mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioa 26 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &amac0 {
@@ -210,6 +228,14 @@
 			reg = <4>;
 		};
 
+		port@5 {
+			label = "sfp";
+			phy-mode = "sgmii";
+			reg = <5>;
+			sfp = <&sfp>;
+			managed = "in-band-status";
+		};
+
 		port@8 {
 			ethernet = <&amac2>;
 			label = "cpu";
-- 
2.17.1

