Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE35C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C614A21707
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C614A21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeLCVdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43149 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeLCVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so13092196otr.10;
        Mon, 03 Dec 2018 13:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/92DiavR/XOHqaCGpCKXJW+JP+tQRs9C+uVOk6OIp1s=;
        b=jA8X+A01fMPO7NNO64FmgbwlHT5Pp63EvtXONXIvsavDWPoqE6sNieEUKeE3aPasZi
         opmTmLEBsiHiTsPzexHztDcc9IEEnpLC+8qFe8rOsr+K2JYtMg94Ps1ljq0vauiTmUSW
         8uapchVu+sggz8D/PDM6g+c0jpsqMTqMSRk8t+e/bVZt/aIDtJyd3vNs+ThEXXOXY4kM
         W5sQ22sDiEFzL3lAriOlXNoRKHIusMpcE/j1IPdJ6TGaoL8tDZLrKo70NItT1kZYAdD6
         Iz6vkWrAPnnbbItHqNAf1Rn2WqOxhfjMrYZ6NyNQ2zCVcb0+U8TvovyQuSLSLud9cQPH
         3/kw==
X-Gm-Message-State: AA+aEWby4bg7JI1U6+UhpkIfhybXcM8Z+0tvLJ2DI0KSHikRY3SBFlBw
        YaqF+jjJjE5h8JgZcgSxABEStSg=
X-Google-Smtp-Source: AFSGD/VtQ/5gSTtjzeX8q6VwImffvSZJapn9KmJ8qmm7Tc4/yN2d0tyrgec64J8lZNgv4y3KHtwuuA==
X-Received: by 2002:a05:6830:1099:: with SMTP id y25mr12304339oto.313.1543872784277;
        Mon, 03 Dec 2018 13:33:04 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:33:03 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 32/34] dt-bindings: arm: Convert Xilinx board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:21 -0600
Message-Id: <20181203213223.16986-33-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Xilinx SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/xilinx.txt        | 83 -------------------
 .../devicetree/bindings/arm/xilinx.yaml       | 82 ++++++++++++++++++
 2 files changed, 82 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
deleted file mode 100644
index 26fe5ecc4332..000000000000
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Xilinx Zynq Platforms Device Tree Bindings
-
-Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
-shall have the following properties.
-
-Required root node properties:
-    - compatible = "xlnx,zynq-7000";
-
-Additional compatible strings:
-
-- Adapteva Parallella board
-  "adapteva,parallella"
-
-- Avnet MicroZed board
-  "avnet,zynq-microzed"
-  "xlnx,zynq-microzed"
-
-- Avnet ZedBoard board
-  "avnet,zynq-zed"
-  "xlnx,zynq-zed"
-
-- Digilent Zybo board
-  "digilent,zynq-zybo"
-
-- Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
-
-- Xilinx CC108 internal board
-  "xlnx,zynq-cc108"
-
-- Xilinx ZC702 internal board
-  "xlnx,zynq-zc702"
-
-- Xilinx ZC706 internal board
-  "xlnx,zynq-zc706"
-
-- Xilinx ZC770 internal board, with different FMC cards
-  "xlnx,zynq-zc770-xm010"
-  "xlnx,zynq-zc770-xm011"
-  "xlnx,zynq-zc770-xm012"
-  "xlnx,zynq-zc770-xm013"
-
----------------------------------------------------------------
-
-Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
-
-Boards with ZynqMP SOC based on an ARM Cortex A53 processor
-shall have the following properties.
-
-Required root node properties:
-    - compatible = "xlnx,zynqmp";
-
-
-Additional compatible strings:
-
-- Xilinx internal board zc1232
-  "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232"
-
-- Xilinx internal board zc1254
-  "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254"
-
-- Xilinx internal board zc1275
-  "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
-
-- Xilinx internal board zc1751
-  "xlnx,zynqmp-zc1751"
-
-- Xilinx 96boards compatible board zcu100
-  "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
-
-- Xilinx evaluation board zcu102
-  "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
-  "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
-  "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
-
-- Xilinx evaluation board zcu104
-  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
-
-- Xilinx evaluation board zcu106
-  "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
-
-- Xilinx evaluation board zcu111
-  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
new file mode 100644
index 000000000000..64cd21b737af
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Platforms Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  Xilinx boards with Zynq-7000 SOC or Zynq UltraScale+ MPSoC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - adapteva,parallella
+              - digilent,zynq-zybo
+              - digilent,zynq-zybo-z7
+              - xlnx,zynq-cc108
+              - xlnx,zynq-zc702
+              - xlnx,zynq-zc706
+              - xlnx,zynq-zc770-xm010
+              - xlnx,zynq-zc770-xm011
+              - xlnx,zynq-zc770-xm012
+              - xlnx,zynq-zc770-xm013
+          - const: xlnx,zynq-7000
+
+      - items:
+          - const: avnet,zynq-microzed
+          - const: xlnx,zynq-microzed
+          - const: xlnx,zynq-7000
+
+      - items:
+          - const: avnet,zynq-zed
+          - const: xlnx,zynq-zed
+          - const: xlnx,zynq-7000
+
+      - items:
+          - enum:
+              - xlnx,zynqmp-zc1751
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1232
+        items:
+          - const: xlnx,zynqmp-zc1232-revA
+          - const: xlnx,zynqmp-zc1232
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1254
+        items:
+          - const: xlnx,zynqmp-zc1254-revA
+          - const: xlnx,zynqmp-zc1254
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1275
+        items:
+          - const: xlnx,zynqmp-zc1275-revA
+          - const: xlnx,zynqmp-zc1275
+          - const: xlnx,zynqmp
+
+      - description: Xilinx 96boards compatible board zcu100
+        items:
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu102
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu102-revA
+              - xlnx,zynqmp-zcu102-revB
+              - xlnx,zynqmp-zcu102-rev1.0
+          - const: xlnx,zynqmp-zcu102
+          - const: xlnx,zynqmp
+
+...
-- 
2.19.1

