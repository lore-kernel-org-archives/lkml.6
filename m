Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D95FC65BAB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B1208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2B1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeJEX6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45377 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbeJEX6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so10927883oig.12;
        Fri, 05 Oct 2018 09:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j25dCtrBKVBugAGpQt2CYXbqKQPtlxQHNDkhsveznr8=;
        b=UE81BCjiZjEbqGhtOZ9QSJgknGTDrIz02A81k9nSTL4kDRc3g6vIFjAIptj/adfdPO
         9CLarV8qjXxF0Vvx8kUQ2Y6+zFT9jkJmK6jAbwclx7H72bo0r3M7C64f7UHC2/uLuGXa
         1+H9Opl/YRur6mTZb9Sf91WS5Qyz9wiihVv4lk+ai3gMS9SPq9/UIeKET+pqWMNIMTf6
         kvB+P8hI9/RByJExRxqYwxFMLsvuOwVo9UNY4Dd4mw9FO2IhQJ4Cz0vK1rqyCn9tHtuG
         kN7DjB+cFdT3H4MQ9qG1OndTOQ8VXqagNrlsGWj7ShwSDDrdM1nPiC4bMkjUkg4AB6Jn
         z9Hg==
X-Gm-Message-State: ABuFfojRAoNFSzz++qymj7rQbcLm7CvDJeeG2V35DRhu7BHIT70+fTVr
        SocPmp31ej5oRv3Ir+2781paUAoGkw==
X-Google-Smtp-Source: ACcGV60Q3EFLLDUDFdtBgN2Yqx5ArY5LdijKnLm9HIhiYvRvGzi2wwWxRktrTKW/kBily4ZdksPxXg==
X-Received: by 2002:aca:c6d5:: with SMTP id w204-v6mr5424577oif.319.1538758757190;
        Fri, 05 Oct 2018 09:59:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 19/36] dt-bindings: arm: Convert Atmel board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:31 -0500
Message-Id: <20181005165848.3474-20-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
 .../devicetree/bindings/arm/atmel-at91.yaml   | 132 ++++++++++++++++++
 2 files changed, 132 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
deleted file mode 100644
index 4bf1b4da7659..000000000000
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-Atmel AT91 device tree bindings.
-================================
-
-Boards with a SoC of the Atmel AT91 or SMART family shall have the following
-properties:
-
-Required root node properties:
-compatible: must be one of:
- * "atmel,at91rm9200"
-
- * "atmel,at91sam9" for SoCs using an ARM926EJ-S core, shall be extended with
-   the specific SoC family or compatible:
-    o "atmel,at91sam9260"
-    o "atmel,at91sam9261"
-    o "atmel,at91sam9263"
-    o "atmel,at91sam9x5" for the 5 series, shall be extended with the specific
-      SoC compatible:
-       - "atmel,at91sam9g15"
-       - "atmel,at91sam9g25"
-       - "atmel,at91sam9g35"
-       - "atmel,at91sam9x25"
-       - "atmel,at91sam9x35"
-    o "atmel,at91sam9g20"
-    o "atmel,at91sam9g45"
-    o "atmel,at91sam9n12"
-    o "atmel,at91sam9rl"
-    o "atmel,at91sam9xe"
- * "atmel,sama5" for SoCs using a Cortex-A5, shall be extended with the specific
-   SoC family:
-    o "atmel,sama5d2" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d27"
-    o "atmel,sama5d3" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d31"
-       - "atmel,sama5d33"
-       - "atmel,sama5d34"
-       - "atmel,sama5d35"
-       - "atmel,sama5d36"
-    o "atmel,sama5d4" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d41"
-       - "atmel,sama5d42"
-       - "atmel,sama5d43"
-       - "atmel,sama5d44"
-
- * "atmel,samv7" for MCUs using a Cortex-M7, shall be extended with the specific
-   SoC family:
-    o "atmel,sams70" shall be extended with the specific MCU compatible:
-       - "atmel,sams70j19"
-       - "atmel,sams70j20"
-       - "atmel,sams70j21"
-       - "atmel,sams70n19"
-       - "atmel,sams70n20"
-       - "atmel,sams70n21"
-       - "atmel,sams70q19"
-       - "atmel,sams70q20"
-       - "atmel,sams70q21"
-    o "atmel,samv70" shall be extended with the specific MCU compatible:
-       - "atmel,samv70j19"
-       - "atmel,samv70j20"
-       - "atmel,samv70n19"
-       - "atmel,samv70n20"
-       - "atmel,samv70q19"
-       - "atmel,samv70q20"
-    o "atmel,samv71" shall be extended with the specific MCU compatible:
-       - "atmel,samv71j19"
-       - "atmel,samv71j20"
-       - "atmel,samv71j21"
-       - "atmel,samv71n19"
-       - "atmel,samv71n20"
-       - "atmel,samv71n21"
-       - "atmel,samv71q19"
-       - "atmel,samv71q20"
-       - "atmel,samv71q21"
diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
new file mode 100644
index 000000000000..f788315b94fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/atmel-at91.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel AT91 device tree bindings.
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
+  - Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+description: |
+  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: atmel,at91rm9200
+      - items:
+          - enum:
+              - olimex,sam9-l9260
+          - enum:
+              - atmel,at91sam9260
+              - atmel,at91sam9261
+              - atmel,at91sam9263
+              - atmel,at91sam9g20
+              - atmel,at91sam9g45
+              - atmel,at91sam9n12
+              - atmel,at91sam9rl
+              - atmel,at91sam9xe
+          - const: atmel,at91sam9
+
+      - items:
+          - enum:
+              - atmel,at91sam9g15
+              - atmel,at91sam9g25
+              - atmel,at91sam9g35
+              - atmel,at91sam9x25
+              - atmel,at91sam9x35
+          - const: atmel,at91sam9x5
+          - const: atmel,at91sam9
+
+      - items:
+          - const: atmel,sama5d27
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
+      - description: Nattis v2 board with Natte v2 power board
+        items:
+          - const: axentia,nattis-2
+          - const: axentia,natte-2
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - description: TSE-850 v3 board
+        items:
+          - const: axentia,tse850v3
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sama5d31
+              - atmel,sama5d33
+              - atmel,sama5d34
+              - atmel,sama5d35
+              - atmel,sama5d36
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sama5d41
+              - atmel,sama5d42
+              - atmel,sama5d43
+              - atmel,sama5d44
+          - const: atmel,sama5d4
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sams70j19
+              - atmel,sams70j20
+              - atmel,sams70j21
+              - atmel,sams70n19
+              - atmel,sams70n20
+              - atmel,sams70n21
+              - atmel,sams70q19
+              - atmel,sams70q20
+              - atmel,sams70q21
+          - const: atmel,sams70
+          - const: atmel,samv7
+
+      - items:
+          - enum:
+              - atmel,samv70j19
+              - atmel,samv70j20
+              - atmel,samv70n19
+              - atmel,samv70n20
+              - atmel,samv70q19
+              - atmel,samv70q20
+          - const: atmel,samv70
+          - const: atmel,samv7
+
+      - items:
+          - enum:
+              - atmel,samv71j19
+              - atmel,samv71j20
+              - atmel,samv71j21
+              - atmel,samv71n19
+              - atmel,samv71n20
+              - atmel,samv71n21
+              - atmel,samv71q19
+              - atmel,samv71q20
+              - atmel,samv71q21
+          - const: atmel,samv71
+          - const: atmel,samv7
+
+...
-- 
2.17.1

