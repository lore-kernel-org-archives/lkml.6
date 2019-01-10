Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCCC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BE92173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158757;
	bh=U/x2yqEqcdP00bCHAXoVpNIOySDl/UrEskRYg324LKI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uMOOS0p7+q/2AXABcuD+PMo3f3VYoE7uEtQpNvy8QTp0CqPCL/gi2Gy8yysIyjzFA
	 D4oEBzdQDkeJrS1HXFtR2X5NlkAYfpZtb2cpFVie6lj3fd+gykU27lSTsOdfzypeic
	 /u7/aULUwj+yKjBDxoZHm7aFgvUeU3007dn/UX+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfAJWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:19:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35546 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfAJWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so11447686otj.2;
        Thu, 10 Jan 2019 14:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5pRmWNfodQ0VVwG2Uqbu5471LXeV1RU+JqhgLaUyDg=;
        b=Giwku3AeYNSJa4TxlymSkRBgWzeQR/mE9yzEYigyPP3M15+2V8oxJMZjkr0s1gj9Xq
         iZVnb3wz3hU28sa1bTxR71A7WkmLDulzaxMmvWixjdNM8ppQdPtWiQKtVCRuzqXerYzb
         83pMar2ppGeSHjjZPQen064ublqJnFRCKCqJK0zWaE+KLYQ5UX6zZOU/trI6BmfCLIeX
         Mo56AqtCojAI5uEgvWtYbRMiJ5Lujv4WJ1kubxl7jzhV9FSd3tCc9erOTc3CfcThFQqz
         KRaVtdzA4UAjQzdDRbNV7RSA3L5mc1Y+NJZ7rkj9Ee7q0ZgCns3dY5hRw0XIFckoQ4zA
         zO4A==
X-Gm-Message-State: AJcUukfHI0kZLPjwLGuUoYJzzBhVvg+T6cTaybZN43ndDlyC7b9F3IT7
        fHc5nCty9y6NWmxkrwnFRAsZ/vA=
X-Google-Smtp-Source: ALg8bN6Lo3RdGUG+AGgMAuiuYt8KgaR9TGBnosUK60R82x8g4dFnTIaFQaf0SE73hz0CYyeQAYnMQw==
X-Received: by 2002:a9d:6197:: with SMTP id g23mr7688177otk.324.1547158752091;
        Thu, 10 Jan 2019 14:19:12 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c19sm36776707otl.16.2019.01.10.14.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:19:10 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
Date:   Thu, 10 Jan 2019 16:19:01 -0600
Message-Id: <20190110221903.3990-4-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fixed-clock binding to DT schema format using json-schema.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/fixed-clock.txt | 23 ----------
 .../bindings/clock/fixed-clock.yaml           | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.txt b/Documentation/devicetree/bindings/clock/fixed-clock.txt
deleted file mode 100644
index 0641a663ad69..000000000000
--- a/Documentation/devicetree/bindings/clock/fixed-clock.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Binding for simple fixed-rate clock sources.
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be "fixed-clock".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clock-frequency : frequency of clock in Hz. Should be a single cell.
-
-Optional properties:
-- clock-accuracy : accuracy of clock in ppb (parts per billion).
-		   Should be a single cell.
-- clock-output-names : From common clock binding.
-
-Example:
-	clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1000000000>;
-		clock-accuracy = <100>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
new file mode 100644
index 000000000000..8b5628463b90
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for simple fixed-rate clock sources.
+
+maintainers:
+  - Michael Turquette <mturquette@baylibre.com>
+  - Stephen Boyd <sboyd@kernel.org>
+
+properties:
+  compatible:
+    const: fixed-clock
+
+  "#clock-cells":
+    const: 0
+
+  clock-frequency: true
+
+  clock-accuracy:
+    description: accuracy of clock in ppb (parts per billion).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    clock {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <1000000000>;
+      clock-accuracy = <100>;
+    };
+...
-- 
2.19.1

