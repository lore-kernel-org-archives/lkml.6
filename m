Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B861C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E2220841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+KRklmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E2220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeHaX3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43432 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:46 -0400
Received: by mail-qt0-f196.google.com with SMTP id g53-v6so15732161qtg.10;
        Fri, 31 Aug 2018 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KaDF8Y9NiIVVpO8fIUtLbwriHKMu6JuYaDupLhRe/4A=;
        b=O+KRklmfzHPxu/J8d+CD0QilmY4TpeJrWu2yN91gP4Cw/UKUE2uqSNLtLWyP4uOLTp
         5WY/jQPyI4vhOlIlZPG5MBdl6mhF0RZt+nHAMkxf2qWId/GJwpBW8PATNP5VukF1hb5e
         1ej4nv6ByehL7ugDcFw6V4rtsSeCSKJIFgduoreSFT1BH2e1Vgb/Wsu/ufKHe53vc7+w
         lEWYQFKTX7PynmpzhEBD5y7kz719fr3OUBZDb0XITyMo/AF9pqmQQyl8nrIMUyDRbZ4t
         ZoyiqFXmljZ2Fw5M/8lKdo1eUR46DcTPA4rfz+RmlJgmdmvVZsjxYwNZAVAZnEnFSCTa
         mcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KaDF8Y9NiIVVpO8fIUtLbwriHKMu6JuYaDupLhRe/4A=;
        b=aFvBa7Vs2+8E6YoQfssSjHXV++8xzjoTg8pVKdVW0jeAj8xPZA7RrxiV9brbpUmMP0
         5YUJZ65SMX1jhbuPc50hIY1I089r9iGgx+5D41W2PINj5cHVfJc8daO6RHhkUylzMsP9
         Cl7lyklQL1o+Gz3t+bGg8W6AoURDtsXdz8Xv0zHomEfPYenHbCXil7nZi/Ss7VR5BGXH
         ykHx4DxaK8xlz03hLK14aNmtQxbdrEf4/y+nCe/cehIJ248UUq/TdpDIEb7VhxEtWpTY
         Au+oPLsTkbn3bK/BtL2oVcIFvXPW9rEoNPz/mSUSUNTlB7fQ6HrmXJn41YdrQXFGv9qP
         Q51g==
X-Gm-Message-State: APzg51AczbCrb8dwEK1Dmc2j1otHXEHLVJnrPxV6KN5KMeD+7Y7OOhs+
        MpEyELyxypnUzj1REXAwCsQ=
X-Google-Smtp-Source: ANB0Vdb87CxRvleILM5F6xLq/iTIDkY7pVazJrxoMBoHb3AHzcrQAM092f8qi2pUccn8w9pyTbcIIQ==
X-Received: by 2002:a0c:9c09:: with SMTP id v9-v6mr17149613qve.186.1535743251883;
        Fri, 31 Aug 2018 12:20:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f53-v6sm6949160qtk.40.2018.08.31.12.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:20:50 -0700 (PDT)
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
Subject: [PATCH v3 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
Date:   Fri, 31 Aug 2018 12:20:37 -0700
Message-Id: <20180831192039.11842-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831192039.11842-1-f.fainelli@gmail.com>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
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
index ea3fc194f8f3..a53a2f629d74 100644
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
+	i2c1: i2c {
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

