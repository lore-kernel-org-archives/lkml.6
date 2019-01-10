Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C5EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53391208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158786;
	bh=X7gds3erUp9TB+MHHOh/CHLaTtPI8WNusNcxJe1WgFg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q/HERRvHnjliglIyxYg+SJmPfKXXBR5vD8565B6QuiEzIsIZUEXfasIF1EB8zzGcC
	 sXgBtcpYhdh9HEuDS3hcLSvevi9Negc/ngr+ViGYCpXW1CP69uTXPIP5Ob96+W09sp
	 tN1uerHjwCtMMXeeZjqH/nARl2q8+CAPtI+P1tNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfAJWTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:19:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44292 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAJWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so11388425otl.11;
        Thu, 10 Jan 2019 14:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcEn48btYuBBpFW3H6jCSdPYCQ5J3zew7Gw3e+pbdng=;
        b=RNMMZfGuTG1aB0xa4Vk7/g9DewO9K8+GoGhRe4pdoZUE7XxUe+pGoBNx3FCeHD2Wgh
         dihdb9Fe9jImPLBL3efhoQgjtWBSiUyZMIIrKyMjL663Qvj7T6ddmRbOZwEegPEr4M/P
         67n26rlkMqyGyEl7vA5W1VdFeblLT+GIPFTjgKGRAbeEBG7R23SRS0ISOFNmTMJuvfoc
         79rI9VO2Pdq13C/hdlgVQ2IonxPkYPvg8HMgwTSFhlxPKWyoXPSjA9VVn5gu19Xv3EQt
         ZxhbNbtk2teTK0aCbgI7GM7rW54ZGi1X/Pc5UMtBF1dSS/1X/2cIFQ4+uwUn2hLRHgTe
         YJTw==
X-Gm-Message-State: AJcUukdaVY4Z6lc4n2GFNA+M8luDq7BNVLrXPKfGrMUJLdGCcgc1vFlX
        vEzMOstS+YkVO1tf5q2ISOR5sUU=
X-Google-Smtp-Source: ALg8bN60MD55tdYQwHak1aQ5zyPP4GWqLEr9ietPQFIbdRjmDPbyyniY5Bgu3cNhZB0KkOD+ARhf6A==
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr7388152otj.301.1547158783935;
        Thu, 10 Jan 2019 14:19:43 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h24sm34719828otq.11.2019.01.10.14.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:19:43 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert arm,pl011 to json-schema
Date:   Thu, 10 Jan 2019 16:19:42 -0600
Message-Id: <20190110221942.5374-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the arm,pl011 binding to DT schema using json-schema.

The zte,zx296702-uart binding appears to be broken as the dts files are
missing 'arm,primecell'. That's included in the schema here to throw a
warning.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/pl011.txt      |  51 -------
 .../devicetree/bindings/serial/pl011.yaml     | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/pl011.txt
 create mode 100644 Documentation/devicetree/bindings/serial/pl011.yaml

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
deleted file mode 100644
index 77863aefe9ef..000000000000
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* ARM AMBA Primecell PL011 serial UART
-
-Required properties:
-- compatible: must be "arm,primecell", "arm,pl011", "zte,zx296702-uart"
-- reg: exactly one register range with length 0x1000
-- interrupts: exactly one interrupt specifier
-
-Optional properties:
-- pinctrl:
-	   When present, must have one state named "default",
-	   and may contain a second name named "sleep". The former
-	   state sets up pins for ordinary operation whereas
-	   the latter state will put the associated pins to sleep
-	   when the UART is unused
-- clocks:
-	   When present, the first clock listed must correspond to
-	   the clock named UARTCLK on the IP block, i.e. the clock
-	   to the external serial line, whereas the second clock
-	   must correspond to the PCLK clocking the internal logic
-	   of the block. Just listing one clock (the first one) is
-	   deprecated.
-- clock-names:
-	   When present, the first clock listed must be named
-	   "uartclk" and the second clock listed must be named
-	   "apb_pclk"
-- dmas:	
-	   When present, may have one or two dma channels.
-	   The first one must be named "rx", the second one
-	   must be named "tx".
-- auto-poll:
-	   Enables polling when using RX DMA.
-- poll-rate-ms:
-	   Rate at which poll occurs when auto-poll is set,
-	   default 100ms.
-- poll-timeout-ms:
-	   Poll timeout when auto-poll is set, default
-	   3000ms.
-
-See also bindings/arm/primecell.txt
-
-Example:
-
-uart@80120000 {
-	compatible = "arm,pl011", "arm,primecell";
-	reg = <0x80120000 0x1000>;
-	interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
-	dmas = <&dma 13 0 0x2>, <&dma 13 0 0x0>;
-	dma-names = "rx", "tx";
-	clocks = <&foo_clk>, <&bar_clk>;
-	clock-names = "uartclk", "apb_pclk";
-};
diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
new file mode 100644
index 000000000000..1a64d59152aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/pl011.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM AMBA Primecell PL011 serial UART
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - arm,pl011
+          - zte,zx296702-uart
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: arm,pl011
+          - const: arm,primecell
+      - items:
+          - const: zte,zx296702-uart
+          - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    description:
+      When present, must have one state named "default",
+      and may contain a second name named "sleep". The former
+      state sets up pins for ordinary operation whereas
+      the latter state will put the associated pins to sleep
+      when the UART is unused
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+  clocks:
+    description:
+      When present, the first clock listed must correspond to
+      the clock named UARTCLK on the IP block, i.e. the clock
+      to the external serial line, whereas the second clock
+      must correspond to the PCLK clocking the internal logic
+      of the block. Just listing one clock (the first one) is
+      deprecated.
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: uartclk
+      - const: apb_pclk
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    minItems: 1
+    items:
+      - const: rx
+      - const: tx
+
+  auto-poll:
+    description:
+      Enables polling when using RX DMA.
+    type: boolean
+
+  poll-rate-ms:
+    description:
+      Rate at which poll occurs when auto-poll is set.
+      default 100ms.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 100
+
+  poll-timeout-ms:
+    description:
+      Poll timeout when auto-poll is set, default
+      3000ms.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 3000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+dependencies:
+  poll-rate-ms: [ auto-poll ]
+  poll-timeout-ms: [ auto-poll ]
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@80120000 {
+      compatible = "arm,pl011", "arm,primecell";
+      reg = <0x80120000 0x1000>;
+      interrupts = <0 11 4>;
+      dmas = <&dma 13 0 0x2>, <&dma 13 0 0x0>;
+      dma-names = "rx", "tx";
+      clocks = <&foo_clk>, <&bar_clk>;
+      clock-names = "uartclk", "apb_pclk";
+    };
+
+...
-- 
2.19.1

