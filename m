Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B0320672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUz6ef0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B0320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504422AbeKWXfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:35:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38744 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeKWXfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:35:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so10189135ede.5;
        Fri, 23 Nov 2018 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZYl4FbB26l44XYMBcuKES+7Ka9zhm/EPBmfof1QOP0=;
        b=NUz6ef0WFrJmWYvudn/okq4qsdzQtvUzb4rx1dH3KcD+LnoZ21kvlDl5m/ILwLHH1C
         haZOeaz8/H5XKw8/Os0ka8vNrWerSQ5dK4VRO04ZMG+wkHX9BPCBgOwe7nU8L9g8JfpB
         wboSkNIvjxi9z22kPbbZHDtzCsck3ApirHFcR6Z+4VpGo22onnkAaDjGC+wjScCZR8Ib
         titnN6+zDGk4eU+cRsOZ4035RoDc4qLHP/iKZ/KIz1GogLUQL9hmqVizrIQst1W48O88
         ErzH9gRoNJ8fIn8Kn28QCTsjwFqXDvLxiaAtF5yfwHrMxoB2SocAmbi54xERoAWsJuI4
         cuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZYl4FbB26l44XYMBcuKES+7Ka9zhm/EPBmfof1QOP0=;
        b=X1GAOtf2C4UTA8ojiClrh9usBVX1xhbGg0S7MzBcF2gkfPbQu0ZGR50LWLvzz0/3TG
         r7FiPCH98/YItTUlf9741My6qFW93oUwERS3X1waFOb0Ablk57yH2agrzxnYBlT9QfcS
         JbsXwxLvkTWc+YmJdnsHdC+o2Gyy4fTx9nslNAQ7+FuOXnZO8522aeSyuvJ2+7TlBScm
         4a+ofB7n0Vl1hMNe4YB+V2X8VBPjE2sjbwOyt7o8Id7+zBraVnpt8p+p/4Ufkbh4rXn4
         b2kATaac5AzFuc5XIZ2cLHAbUvVvehPMTMyW6glQjKw4MDweMlB4r5ooQVVChViyY21t
         bV7A==
X-Gm-Message-State: AGRZ1gIhUxtL4tf5jcHp6ZLDnx2PZf6KhpgftK0hq1klgoH0tIs/FTCW
        zyGVQQs/odz4q5VGSg172zw=
X-Google-Smtp-Source: AJdET5fU82pf/+cQ+6hu9ezDesUU8Bu+y2qsrZP6qCw6QbvFNsUKM1k6SYEKfI89PwNVj/0nWl1UOw==
X-Received: by 2002:a17:906:6898:: with SMTP id n24-v6mr11267394ejr.189.1542977500158;
        Fri, 23 Nov 2018 04:51:40 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g5-v6sm6835475ejm.15.2018.11.23.04.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:51:39 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date:   Fri, 23 Nov 2018 13:51:38 +0100
Message-Id: <20181123125138.22489-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123121009.17213-1-thierry.reding@gmail.com>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The "at," prefix was never correct for Atmel, so fix the few occurrences
that got it wrong. Use "atmel," instead.

While at it, remove the at,24c08 compatible string from the list of
trivial devices because it is already documented in eeprom/at24.txt.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- remove at,24c08 compatible from trivial-devices since it is already
  documented in Documentation/devicetree/bindings/eeprom/at24.txt

 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 +-
 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt     | 2 +-
 Documentation/devicetree/bindings/trivial-devices.txt     | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
index 1e98c6b3a721..c661b9083ec6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
@@ -43,7 +43,7 @@ Example:
 			reg = <0>;
 
 			eeprom@50 {
-				compatible = "at,24c02";
+				compatible = "atmel,24c02";
 				reg = <0x50>;
 			};
 		};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index ccf6c86ed076..30ac6a60f041 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -54,7 +54,7 @@ Example:
 			reg = <2>;
 
 			eeprom@54 {
-				compatible = "at,24c08";
+				compatible = "atmel,24c08";
 				reg = <0x54>;
 			};
 		};
diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
index 0fbbc6970ec5..42bfc09c8918 100644
--- a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
+++ b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
@@ -22,7 +22,7 @@ Example:
 			#size-cells = <0>;
 
 			eeprom@54 {
-				compatible = "at,24c08";
+				compatible = "atmel,24c08";
 				reg = <0x54>;
 			};
 		};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 6ab001fa1ed4..94beb5a63ac2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,7 +21,6 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
-at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-- 
2.19.1

