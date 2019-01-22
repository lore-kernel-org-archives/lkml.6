Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3729C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29AB21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIurZ1Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAVSHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:07:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35188 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfAVSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:07:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so15314279wmt.0;
        Tue, 22 Jan 2019 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ya3H+ZTnuGjJNr1EVqWxISdggU9hjIWwY99VhY5fSOQ=;
        b=sIurZ1Khzxeky71LvNH5yiZTchOZBKTMIsZ02gW7eR1a/gbcf3RDanTHQQsGcb7XYP
         l9Xc/eiPvxG1YfdOcrKgYKgP+pB6RoJxplUCa7mcZlaXZTX10Db17ChmywD0DIEiPfsn
         bAhMSgLDyxUezQL+xGLnwMZw+QVIGlN+G7PUz1RN+cmYzTl4QKqM5VgZhMRDWV7mRL6J
         FIyt8+enN+mtHadayttpGAzgv1nAEDnQB19iVmjtTUJcC7HgaKXVQHKubuAccla4rij8
         Q0OGoxMdCypwkgC0kWpmzhzpTYCyIXVaNoVmZ2RMOXrpKEyU0ak4HMufA5vQ1Kn6f+y6
         BF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ya3H+ZTnuGjJNr1EVqWxISdggU9hjIWwY99VhY5fSOQ=;
        b=e5mUDsXAIrGsQFri6FivGnjZ+5hQZJ49+IHO5aV77+gjGbb99NyHzmfaLBnuYslBl2
         zZHYHvn7jryFrOhK5ae2AFoTGUOeO4IvBDUOANYYjSTBce+zn3oZ0Jrp5F6zUb92ENrZ
         pvO4XRGYZYjV3fdK1U+Ql/2DmdEsHBkaySRfczeLGzovtsGma2uAauEkqmEteVUmiaqm
         2wmsOqN4kDYiKW1UqbDbmcstejd3uUF3vscPVFU1lLgJ+oxq7hTqfwjH7bkKe8/ZU41+
         iRS7S6hSOjeFgSamqIEFaXIUASNSKgZkK2gbMu5etpgtTYob36EFMGhNsmFSnhoiaXb5
         1qmA==
X-Gm-Message-State: AJcUukdAGgxRpz27rTerj19km6FcDn8HIR9zPT1G+1Jz6eJw/vTTXIvH
        6ZxV9RC0T2zgVgiVoEkYZOo=
X-Google-Smtp-Source: ALg8bN4AugS+kNuINBnjbM1m2aS/IMlpniXnHKjWk/OlgZfwUYpkwoRresBu3gDrFagXpXx84ezaXw==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr4860816wma.85.1548180470841;
        Tue, 22 Jan 2019 10:07:50 -0800 (PST)
Received: from Sarah.lan (229.98.125.91.dyn.plus.net. [91.125.98.229])
        by smtp.gmail.com with ESMTPSA id 129sm93804220wmd.18.2019.01.22.10.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:07:50 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-lpwan@lists.infradead.org, robh@kernel.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 lora-next 1/4] dt-bindings: lora: sx130x: add basic documentation
Date:   Tue, 22 Jan 2019 18:07:26 +0000
Message-Id: <20190122180729.1834-2-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122180729.1834-1-ben.whitten@lairdtech.com>
References: <20190122180729.1834-1-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

Add basic documentation in YAML format for the SX130x series concentrators
from Semtech.
Required is; the location on the SPI bus and the compatible string.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
v1 -> v2:
* Dropped reset-gpios, radio-spi from required.
* Dropped spi-max-frequency from binding.
* Changed compatible to allow fallback from SX1308 to SX1301.
* Wording changes in commit and descriptions.
* Dual licence
* Incorperate Robs comments on child node and spi wrapper
---
 .../bindings/net/lora/semtech,sx130x.yaml     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
new file mode 100644
index 000000000000..41919fb67ec4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/lora/semtech,sx130x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech LoRa concentrator
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Ben Whitten <ben.whitten@gmail.com>
+
+description: |
+  Semtech LoRa concentrator SX130x digital baseband chip is capable of
+  demodulating LoRa signals on 8 channels simultaneously.
+
+  It is typically paired with two SX125x IQ radios controlled over an
+  SPI directly from the concentrator.
+
+  The concentrator itself is controlled over SPI.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - semtech,sx1308
+      - enum:
+        - semtech,sx1301
+
+  reg:
+    maxItems: 1
+    description: The chip select on the SPI bus.
+
+  reset-gpios:
+    maxItems: 1
+    description: A connection of the reset gpio line.
+
+  radio-spi:
+    type: object
+    description: The concentrator can have two radios connected which are
+      contained within the following node.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^[a-zA-Z0-9]@[0-1]$":
+        properties:
+          reg:
+            maxItems: 1
+        required:
+          - reg
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      concentrator0: lora@0 {
+        compatible = "semtech,sx1301";
+        reg = <0>;
+        reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
+        spi-max-frequency = <8000000>;
+
+        radio-spi {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          radio0: lora@0 {
+            compatible = "semtech,sx1257";
+            reg = <0>;
+          };
+
+          radio1: lora@1 {
+            compatible = "semtech,sx1257";
+            reg = <1>;
+          };
+        };
+      };
+    };
-- 
2.17.1

