Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C5FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE66C2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHFaYa20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfAHImT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:42:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36919 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfAHImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:42:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1554630plr.4;
        Tue, 08 Jan 2019 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVZjZYFPLtmn4+3E+4YZCMQFpHfNrHKl9wLnRK94PSQ=;
        b=uHFaYa20MjnvDjmGcs7QV5yqwKagAtsyxBsj0Py+19GpAuYl8nbWyY8lPVou9VBXOH
         uLF8tLPpLU1EG4M3F2D4CHRInD1jsuvOAE6ldKtkbXUux2cxR/nwTdX9/EYpJP02l4zo
         9fAdOFcXLaWsYKsLcAdxuyhZ+j15TVm13NgbIu8qGy37Nh6eGeyPnVRWKcNkzWIinbNj
         7l6Ze4Ry+Eh+fQ4gaY6pDPSZzs9F9Wuf4ZTK0e4uXQv4qb86qr1qlTXP7Npn9HS1wTbW
         IWdH14UrfmZuwiyQFQryAcdzzoM+tC03BK32uxoQWXJ3uwiVCd6M5Tath9P0hXIfRol1
         giYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qVZjZYFPLtmn4+3E+4YZCMQFpHfNrHKl9wLnRK94PSQ=;
        b=pqS5KMwZKESwjQfzS/63g2Gtkp/LaXCvrwVxhSGWrY4YWIVLJ/btPoBdZBtkjsnQCV
         kOPVTl+UyJg1KFlbR7u9xa8lnsgJVkiwgB6h1WmoFgO8T5LT1DIWlcFIP0GKGwQY89gV
         sKx2KnjoieK9SyU8O+jFYaxwMLB2rYOsEpV4M7Qe4YKfFCOE8Ol1ZSnFCmUNKVvcizbC
         4mdPCgf+031s9f/9+XIJKpb/+vZzY9XnG9v92vUsPM70qW9a6oL61E+a2YnICTfS4J7B
         EJ/H3VzQ+FdL0niVQ8WTJwAz8MGsJmB/d/Ajj6UsScl8ewR0iBA5lGsUnRJvSVTQhSQq
         qs1g==
X-Gm-Message-State: AJcUukdwsdGY7aCEVLMZo3YJrC1vZG8KDaxBwBpvVjwCU2uVkT27vIW6
        4VKSIaPcQ4mwsD+oItUr9qE=
X-Google-Smtp-Source: ALg8bN6DItOts/p7f74OcUXQedJQ9pEor4eHmEPTxhMWjdgSNG+X5j7IH2+DIq9h21Duiqsrg6zqqQ==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr852477plr.135.1546936938260;
        Tue, 08 Jan 2019 00:42:18 -0800 (PST)
Received: from localhost.localdomain (i121-116-192-145.s41.a020.ap.plala.or.jp. [121.116.192.145])
        by smtp.gmail.com with ESMTPSA id l64sm86277445pge.73.2019.01.08.00.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 00:42:17 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-lpwan@lists.infradead.org, afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH lora-next 1/4] dt-bindings: lora: sx130x: add basic documentation
Date:   Tue,  8 Jan 2019 17:41:29 +0900
Message-Id: <20190108084132.10214-1-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic documentation in YAML format for the sx130x series concentrators
from Semtech.
Required is; the location on the SPI bus, the reset gpio and the node for
downstream IQ radios, typically sx125x.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 .../bindings/lora/semtech,sx130x.yaml         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/lora/semtech,sx130x.yaml

diff --git a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
new file mode 100644
index 000000000000..ad263bc4e60d
--- /dev/null
+++ b/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/lora/semtech,sx130x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech LoRa concentrator
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Ben Whitten <ben.whitten@gmail.com>
+
+description: |
+  Semtech LoRa concentrator sx130x digital baseband chip is capable of
+  demodulating LoRa signals on 8 channels simultaneously.
+
+  It is typically paired with two sx125x IQ radios controlled over an
+  SPI directly from the concentrator.
+
+  The concentrator itself it controlled over SPI.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - semtech,sx1301
+        - semtech,sx1308
+
+  reg:
+    maxItems: 1
+    description: The chip select on the SPI bus.
+
+  reset-gpios:
+    maxItems: 1
+    description: A connection of the reset gpio line.
+
+  spi-max-frequency:
+    maximum: 10000000
+    default: 8000000
+    description: The frequency of the SPI communication to the concentrator,
+      in Hz. Maximum SPI frequency is 10MHz although 8MHz is typically used
+      on a number of cards.
+
+  radio-spi:
+    description: The concentrator has two radios connected which are contained
+      within the following node.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - radio-spi
+
+examples:
+  - |
+    concentrator0: lora@0 {
+      compatible = "semtech,sx1301";
+      reg = <0>;
+      reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
+      spi-max-frequency = <8000000>;
+
+      radio-spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        radio0: lora@0 {
+          compatible = "semtech,sx1257";
+          reg = <0>;
+        };
+
+        radio1: lora@1 {
+          compatible = "semtech,sx1257";
+          reg = <1>;
+        };
+      };
+    };
-- 
2.17.1

