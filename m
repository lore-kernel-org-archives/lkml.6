Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDFC282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E0D20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT09cRHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBBPSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:18:16 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42713 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfBBPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:18:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so8259608lja.9;
        Sat, 02 Feb 2019 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM8+91JdLr+V8EUKlKWq7jbt+WdAKn3F2/NnaalcLGQ=;
        b=MT09cRHHEtVHU4sIS89bhCnLOq/o5fw150K04EhfB8cT7ua7aZG+V8tRH8wJPgbhPy
         DVyvudb1ZrDhSMmdBaXlYviZK6W/PHm5iemQKwJJe/+d2csZE0tKsDCJ/T5niPdW8jTT
         TRNObAe3Rd2RojJijawqStc2xcYEVrIhDM+M+9avmBClrPfPAWwhHBhasPqyuVwNA6ZA
         SUXGUV1Ej9d942MHMfZ7qNXDPUmgLXiCZTweS7l0t+X8Sm4wdJfWWRqjejZu3x3tvhlc
         rwmYAxga3Yx3kYYmqLQPuYfcGUgqZY62sRqFqE2piP6CBZxR6KePqXoydGY/dKvelFEB
         a15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM8+91JdLr+V8EUKlKWq7jbt+WdAKn3F2/NnaalcLGQ=;
        b=GZJ337QKqcdSGCWbsh1XRc1US7W56WydaNRzaoUhe7ngRsaBtQoPGH4auMGlQzuDdT
         OBd1/N0J6JHTirkO5PbRYtnWHBEIRF1Fo7cLuTiO/lo2u3Faj+Imcgq0Kbfg9As8fj0P
         SzSr1zwOX/X+3psrR7QvbKx9PMlTP0/WgOTsqo8nSM6pDIkN2dHvNG8BYXQ+Wsa8GY9i
         +C2yQ5SUUnu5m8PJAOq46mD1YMIxIJn32FttcAB2nrnhlzaLTAdLAKP1EBuHQ6CI/c8t
         BFKaidaqO/ATYmRcQA4JeNPWntCC4g2O0cjilJhK3xtmBl22z8eKbzppL1KZU0ILfTso
         0QPg==
X-Gm-Message-State: AJcUukfxv4SOZdBumUxtO/9Xq2DBO4EHFxIAj9mdyKBgjIwrr9SLC14f
        dlQUOfqTCcgpi1Qj9UgVEAUuDZVg
X-Google-Smtp-Source: ALg8bN50qIhktagaEu1zM46IVWljVr5osKjCbau1BwCKQjWT16eY37pCI8drUxWa7yXFBo436r8sHw==
X-Received: by 2002:a2e:91c1:: with SMTP id u1-v6mr31712366ljg.188.1549120691688;
        Sat, 02 Feb 2019 07:18:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1863245ljj.48.2019.02.02.07.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:18:11 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: input: Add binding for bma150 sensor
Date:   Sat,  2 Feb 2019 16:18:02 +0100
Message-Id: <20190202151806.9064-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add device tree bindings for Bosch BMA150 Accelerometer Sensor

Changes from v1:
 - Add properties for all of bma150_cfg
 - Correct IRQ type in example

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/input/bosch,bma150.txt           | 38 +++++++++++++++++++
 include/dt-bindings/input/bma150.h            | 22 +++++++++++
 include/linux/bma150.h                        | 13 +------
 3 files changed, 62 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
 create mode 100644 include/dt-bindings/input/bma150.h

diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
new file mode 100644
index 000000000000..f644d132f79c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
@@ -0,0 +1,38 @@
+* Bosch BMA150 Accelerometer Sensor
+
+Also works for the SMB380 and BMA023 accelerometers
+
+Required properties:
+- compatible : Should be "bosch,bma150"
+- reg : The I2C address of the sensor
+
+Optional properties:
+- interrupt-parent : should be the phandle for the interrupt controller
+- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
+- any-motion-int : bool for if the any motion interrupt should be enabled
+- hg-int : bool for if the high-G interrupt should be enabled
+- lg-int : bool for if the low-G interrupt should be enabled
+- any-motion-cfg : array of integers for any motion duration and threshold
+- hg-cfg : array of integers for high-G hysterisis, duration, and threshold
+- lg-cfg : array of integers for low-G hysterisis, duration, and threshold
+- range : configuration of range, one of BMA150_RANGE_* as defined in [1]
+- bandwidth : refresh rate of device, one of BMA150_BW_* as defined in [1]
+
+Example:
+
+bma150@38 {
+	compatible = "bosch,bma150";
+	reg = <0x38>;
+	interrupt-parent = <&gph0>;
+	interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+	any-motion-int;
+	hg-int;
+	lg-int;
+	any-motion-cfg = <0 0>;
+	hg-cfg = <0 150 160>;
+	lg-cfg = <0 150 20>;
+	range = <BMA150_RANGE_2G>;
+	bandwidth = <BMA150_BW_50HZ>;
+};
+
+[1] include/dt-bindings/input/bma150.h
diff --git a/include/dt-bindings/input/bma150.h b/include/dt-bindings/input/bma150.h
new file mode 100644
index 000000000000..fb38ca787f0f
--- /dev/null
+++ b/include/dt-bindings/input/bma150.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides bindings for the BMA150 accelerometer
+ */
+#ifndef _DT_BINDINGS_INPUT_BMA150_H
+#define _DT_BINDINGS_INPUT_BMA150_H
+
+/* Range */
+#define BMA150_RANGE_2G		0
+#define BMA150_RANGE_4G		1
+#define BMA150_RANGE_8G		2
+
+/* Refresh rate */
+#define BMA150_BW_25HZ		0
+#define BMA150_BW_50HZ		1
+#define BMA150_BW_100HZ		2
+#define BMA150_BW_190HZ		3
+#define BMA150_BW_375HZ		4
+#define BMA150_BW_750HZ		5
+#define BMA150_BW_1500HZ	6
+
+#endif /* _DT_BINDINGS_INPUT_BMA150_H */
diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index 97ade7cdc870..b85266a9c35c 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -20,19 +20,10 @@
 #ifndef _BMA150_H_
 #define _BMA150_H_
 
-#define BMA150_DRIVER		"bma150"
+#include <dt-bindings/input/bma150.h>
 
-#define BMA150_RANGE_2G		0
-#define BMA150_RANGE_4G		1
-#define BMA150_RANGE_8G		2
+#define BMA150_DRIVER		"bma150"
 
-#define BMA150_BW_25HZ		0
-#define BMA150_BW_50HZ		1
-#define BMA150_BW_100HZ		2
-#define BMA150_BW_190HZ		3
-#define BMA150_BW_375HZ		4
-#define BMA150_BW_750HZ		5
-#define BMA150_BW_1500HZ	6
 
 struct bma150_cfg {
 	bool any_motion_int;		/* Set to enable any-motion interrupt */
-- 
2.17.1

