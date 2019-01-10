Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF0208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158767;
	bh=6Iv/PPOIjmEwPbwF5g7x79NbQO/d37D4LsWAXVwzrmQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xX7w8g6hg5eziYx7oY+ZTZF8HC86tpdc6KkkzmctsLyaFxz6L+1MwU/L/whw2xDqg
	 oA7omEiaAXEAv75U1gC/zBItpHZ/OcaY74kKnrEhDLBRx9mRw7ccyMr114YZrdvcHn
	 8taQYv5z/hGt0frk/zaKnUUOaNPBpS79NlkwH2kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfAJWT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:19:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41092 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfAJWTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so11416846otk.8;
        Thu, 10 Jan 2019 14:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mXKyDOeuv77l2GB4kWHUs7/iI/PNHekuOkXLJVMaq4=;
        b=ESTmADy3BsFZmTYKyAmGk/ebTiYkHrB7B1PDHs1rXZdFqpvXl2qorlP3y3pVqHtMBQ
         TVCWmN8xJDgF9KrVpDZhihU/SA7YxlL+IxkG6qZ1GFzmPpcXH4wVVExKqqJA9osCQgk5
         y5pJovaYaRqvQymmIkrWECjAzd8O099JzFFzMdD00Qn0hrv+1xtqECNocpvg0U5KUHgI
         pJhDcygjypQc602DCjvIMhmyQ7xBqnWhjciLOBXdkuc32Zk2pB6xcvmMgUnOCpDlWW8T
         pUQBHdQrh4tUR1eYTJw/gYqhxuroFvl/VUgzKOeh61K9uNMC7Z0GQ3KDGJxG0v1+tFpM
         dabg==
X-Gm-Message-State: AJcUukeuToYSxcimp++2Rxc1mEE3IWfeR/PTSszf3n1zl6TCfT597Q8a
        jj75ZlM1TDYvLNLjvfl0czwzyd8=
X-Google-Smtp-Source: ALg8bN6f8SHvnKK5VJSIN1SWFmUwn/fYGBFQwswqM37xWh4pLZzoZrcXET7WfIxfmPySy5xQMoRZMg==
X-Received: by 2002:a9d:5a81:: with SMTP id w1mr8415635oth.317.1547158753259;
        Thu, 10 Jan 2019 14:19:13 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c19sm36776707otl.16.2019.01.10.14.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:19:12 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert fixed-factor-clock to json-schema
Date:   Thu, 10 Jan 2019 16:19:02 -0600
Message-Id: <20190110221903.3990-5-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fixed-factor-clock binding to DT schema format using
json-schema.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/fixed-factor-clock.txt     | 28 ----------
 .../bindings/clock/fixed-factor-clock.yaml    | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
deleted file mode 100644
index 189467a7188a..000000000000
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Binding for simple fixed factor rate clock sources.
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be "fixed-factor-clock".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clock-div: fixed divider.
-- clock-mult: fixed multiplier.
-- clocks: parent clock.
-
-Optional properties:
-- clock-output-names : From common clock binding.
-
-Some clocks that require special treatments are also handled by that
-driver, with the compatibles:
-  - allwinner,sun4i-a10-pll3-2x-clk
-
-Example:
-	clock {
-		compatible = "fixed-factor-clock";
-		clocks = <&parentclk>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
new file mode 100644
index 000000000000..e7cd4ebac456
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fixed-factor-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for simple fixed factor rate clock sources.
+
+maintainers:
+  - Michael Turquette <mturquette@baylibre.com>
+  - Stephen Boyd <sboyd@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun4i-a10-pll3-2x-clk
+      - fixed-factor-clock
+
+  "#clock-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-div:
+    description: Fixed divider
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 1
+
+  clock-mult:
+    description: Fixed multiplier
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - "#clock-cells"
+  - clock-div
+  - clock-mult
+
+additionalProperties: false
+
+examples:
+  - |
+    clock {
+      compatible = "fixed-factor-clock";
+      clocks = <&parentclk>;
+      #clock-cells = <0>;
+      clock-div = <2>;
+      clock-mult = <1>;
+    };
+...
-- 
2.19.1

