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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2363320820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQJPPe+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2363320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504122AbeKWWyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:54:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41295 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388020AbeKWWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:54:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so10070364edi.8;
        Fri, 23 Nov 2018 04:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUY8zFGbDTxAkSPcyWUt49Gpw7Cg8YDFkbAFRhvl5Q0=;
        b=FQJPPe+MP5DrW403Ya2tKGOJQjeKaXBgKjg/tWusBwrMwpxhR/K0T+md1H6D37Ah2+
         JxOGVqFygI7zOa3qTbBOewMl+zFXOgRi1rc+I086pvQYXx0069iuhjTsaxUFMJhN5w9N
         HFHpWAZhL3njUUzgKQmxGcu/QLeFcumDzYc6L8PTAUSTWXccaLF7d+ZXK7Q0uVLruVwu
         /z+Nfp25JTWsOwRQEP/oEYq3opSWJ0qf2fVZbavmZvkK5g0y3jP/7lqOTOXEdu+v5NGf
         vTWHICgF7PqKbS6n3WLYnFUKw4gk27Xso79ZZwoptvSYFGYuS7MAYMmWgOv+6k7RSm2F
         nbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUY8zFGbDTxAkSPcyWUt49Gpw7Cg8YDFkbAFRhvl5Q0=;
        b=Yyg7qghv8O0VjJH0273k0hbeeWrPM5Bz9qjbIurpjo/iYKdF8XwJSd9wo9oSBdrN7X
         3Lx/DIPjX1Angp9Kv//OQzsYDm6vgZMWaQV4MDGj40JcfUdHEw0nat6btHVoU0iTRmLX
         ZpaFflERiwcAEcjZPiAV0S2//Rp1h1HN2/k3zGrPcQADpXY9GlWn3BVXTcp6yjxqjRMk
         j7/IXWnLn7WLNG55vG9SgaFY+4W0HX+HmRRMOMkM6yFIEh9lg9kyFSelu0UPxr1rgCv4
         g2KFrmVnZ2yMgnXWDWM3SCaHodmcSs0PpYUEru+vvf3+UAC9M1MtOOYrI2xa6h64F6rL
         3Zpw==
X-Gm-Message-State: AA+aEWYYWPlowYJXPLaEwJJ12sweIJvjusRCEDVb1o9Ci/fxSqNjCJIy
        RR1o433YmLxMBsCwHzBnSmE=
X-Google-Smtp-Source: AFSGD/VvYti5dRu3AaFd7Be1soDuq/PHMphKnknl/XL7fUNUcvnOP/fjUrK5oZs9w+jVfpX8hU86zQ==
X-Received: by 2002:a50:a086:: with SMTP id 6mr5204129edo.88.1542975011336;
        Fri, 23 Nov 2018 04:10:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b2sm5923326ede.30.2018.11.23.04.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:10:10 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date:   Fri, 23 Nov 2018 13:10:09 +0100
Message-Id: <20181123121009.17213-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The "at," prefix was never correct for Atmel, so fix the few occurrences
that got it wrong. Use "atmel," instead.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 +-
 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt     | 2 +-
 Documentation/devicetree/bindings/trivial-devices.txt     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
index 6ab001fa1ed4..b7a7eaf2979a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,7 +21,7 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
-at,24c08		i2c serial eeprom  (24cxx)
+atmel,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-- 
2.19.1

