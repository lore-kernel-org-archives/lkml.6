Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E0C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817F0218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SglbaEct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbfAXOyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:54:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36476 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfAXOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:53:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so6810205wrp.3;
        Thu, 24 Jan 2019 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zndVnj3d64tbcPJgxyTchcrUoiXidx1kg7GR71aJ6DM=;
        b=SglbaEctxpIdlndix2TOUQ4nZziNklAn14c19B62H3pzftrFsSVSrqXfy8IWek8g1f
         nXwvajI9LLaoWGSR7ZnFayYa+cn5389kv+e+ug9s5ezO59MPjmP5vxm0KjuOmDdZ7FsI
         q3JVP03uyPSsIjHbpo+pTzzNU8eOdNxkOzFg4AslQSOR0uhJo17oCgOQ1vFhQMvEXu4L
         KFFMt4D6ab3ytX4W258VRCbSJywmiRwv55SAPjGp7RUYh/KLYPiwFXbsBffpf+NIeDiI
         /Px661pajKZPnOzIAQ18ttPYMhTGnN0FpWScE6LJ8YrOMM/JJcpT24S78yNtDyT/oGRM
         9p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zndVnj3d64tbcPJgxyTchcrUoiXidx1kg7GR71aJ6DM=;
        b=iXG/3W3NAJQ44zkD2oLFKSKRNWVh4TTBM67TzV96862v0wg1QbG09TZ6v2SjK8f/wt
         5sIIMSVd2LPS2CwOo0G4fewQjWbb17LxppeDbTYyAU8IIz3huaVCO8kvi3EVzZ2Gp2+p
         smZuc8SGLT4LWRAx9JimJeFrkvuA3anPcYDRPsROkPeBwrd/GtYKCyPeGjVzGbqw0YIE
         +/rF0H73s7eBZNMIOwb0vV4EmI+KrB7Jh0PhoSpVi2UWiF8tm3hsyhVfW/Kcd8C7atCo
         oAOiIfNr/HV71whmT3PzN4Hs1a4z26Ic+OUHm7jVhCya1x/P851E+OHlfUwscp6v2WxP
         eNMQ==
X-Gm-Message-State: AJcUukdoytSXbMPBRdP3rGOQy458PbTn8/pOeHniRKOKmeEgcW6OlT/p
        0MQOwFk7eHSozVUmzHqzFCw=
X-Google-Smtp-Source: ALg8bN4ZMw7gLute/kBYHOjBqOqElXmxn4fXhaOOHciSAStijYNVX/xGD2awJ7M6GYLgsFJT9t9NQQ==
X-Received: by 2002:adf:b608:: with SMTP id f8mr7353432wre.120.1548341636050;
        Thu, 24 Jan 2019 06:53:56 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t63sm53611538wmt.8.2019.01.24.06.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:53:55 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>
Subject: [PATCH v3 lora-next 1/4] dt-bindings: lora: sx130x: add basic documentation
Date:   Thu, 24 Jan 2019 14:53:06 +0000
Message-Id: <20190124145309.21698-2-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124145309.21698-1-ben.whitten@lairdtech.com>
References: <20190124145309.21698-1-ben.whitten@lairdtech.com>
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
v2 -> v3:
* Corrected fallback notation
* Limited radio node names from anything to 'radio@'
v1 -> v2:
* Dropped reset-gpios, radio-spi from required.
* Dropped spi-max-frequency from binding.
* Changed compatible to allow fallback from SX1308 to SX1301.
* Wording changes in commit and descriptions.
* Dual licence
* Incorperate Robs comments on child node and spi wrapper
---
 .../bindings/net/lora/semtech,sx130x.yaml     | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
new file mode 100644
index 000000000000..24fad1218735
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
@@ -0,0 +1,101 @@
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
+    oneOf:
+      - items:
+        - enum:
+          - semtech,sx1308
+        - const: semtech,sx1301
+      - items:
+        - const: semtech,sx1301
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
+      "^radio@[0-1]$":
+        type: object
+        properties:
+          reg:
+            maxItems: 1
+            minimum: 0
+            maximum: 1
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
+          radio0: radio@0 {
+            compatible = "semtech,sx1257";
+            reg = <0>;
+          };
+
+          radio1: radio@1 {
+            compatible = "semtech,sx1257";
+            reg = <1>;
+          };
+        };
+      };
+    };
-- 
2.17.1

