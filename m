Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2080C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6709020864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6709020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLCVc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36267 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeLCVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so13140673otk.3;
        Mon, 03 Dec 2018 13:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv1C1cWbY7+OPspfi5BzDzIaFQlkYbh4xh/OQ1DKxUo=;
        b=b6GYz6G7+s6c0x/y/cXClI8SdrMngKgvKQfYbRQ41jF7yjfoPT+7yrcSAyclzL7I0Q
         H+edFx48nQQrOkGX2RKsGSwDsw+jTNBuRs9VaM0cwNY3DzmZcOU1ClyIj1Uak/N+5fOe
         uRi1AVHToQMZtJkDWxW36gjRjGbtnxpt+9AL/bNwJjanKuRT3QoxC3P1/yBrFkPvZWCm
         4oxrHHDh+Vij7Qn64+lSrNFLrKCzjcbc7CP/B0OeY4eW9hqQJZxt9D6WxhukVpwwsejP
         8fnlxPkRdfbqV+NQn95KLN05sGPL96ePuYDhhiZpQO2Lw+oRQgU7Ybo+PsTL/Xhf6xqE
         gxAw==
X-Gm-Message-State: AA+aEWaRZdu7FNUP/qXFxkwj8LnsrZvyeC16uhjdCO9xkbPhf0eI6iHy
        UrTg5dGZO0J7wXzJiFmDClw8mR0=
X-Google-Smtp-Source: AFSGD/U62nXAo98cAJSCehYAqTguT/cYVQs0hsee8swcUbHlQkVpfMwa8BKoc6j/z5V8U2WaYAghvg==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr12059581otg.74.1543872768891;
        Mon, 03 Dec 2018 13:32:48 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:48 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 19/34] dt-bindings: arm: Convert MediaTek board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:08 -0600
Message-Id: <20181203213223.16986-20-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MediaTek SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek.txt      | 79 -----------------
 .../devicetree/bindings/arm/mediatek.yaml     | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
deleted file mode 100644
index 8f260e5cfd16..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-MediaTek SoC based Platforms Device Tree Bindings
-
-Boards with a MediaTek SoC shall have the following property:
-
-Required root node property:
-
-compatible: Must contain one of
-   "mediatek,mt2701"
-   "mediatek,mt2712"
-   "mediatek,mt6580"
-   "mediatek,mt6589"
-   "mediatek,mt6592"
-   "mediatek,mt6755"
-   "mediatek,mt6765"
-   "mediatek,mt6795"
-   "mediatek,mt6797"
-   "mediatek,mt7622"
-   "mediatek,mt7623" which is referred to MT7623N SoC
-   "mediatek,mt7623a"
-   "mediatek,mt8127"
-   "mediatek,mt8135"
-   "mediatek,mt8173"
-
-
-Supported boards:
-
-- Evaluation board for MT2701:
-    Required root node properties:
-      - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
-- Evaluation board for MT2712:
-    Required root node properties:
-      - compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
-- Evaluation board for MT6580:
-    Required root node properties:
-      - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
-- bq Aquaris5 smart phone:
-    Required root node properties:
-      - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
-- Evaluation board for MT6592:
-    Required root node properties:
-      - compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
-- Evaluation phone for MT6755(Helio P10):
-    Required root node properties:
-      - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
-- Evaluation board for MT6765(Helio P22):
-    Required root node properties:
-      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
-- Evaluation board for MT6795(Helio X10):
-    Required root node properties:
-      - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT6797(Helio X20):
-    Required root node properties:
-      - compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
-- Mediatek X20 Development Board:
-    Required root node properties:
-      - compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
-- Reference board variant 1 for MT7622:
-    Required root node properties:
-      - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
-- Reference board for MT7623a with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
-- Reference board for MT7623a with NAND:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
-- Reference board for MT7623n with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
-- Bananapi BPI-R2 board:
-      - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
-- MTK mt8127 tablet moose EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- MTK mt8135 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
-- MTK mt8173 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
new file mode 100644
index 000000000000..d991676222e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+description: |
+  Boards with a MediaTek SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-evb
+          - const: mediatek,mt2701
+
+      - items:
+          - enum:
+              - mediatek,mt2712-evb
+          - const: mediatek,mt2712
+      - items:
+          - enum:
+              - mediatek,mt6580-evbp1
+          - const: mediatek,mt6580
+      - items:
+          - enum:
+              - mundoreader,bq-aquaris5
+          - const: mediatek,mt6589
+      - items:
+          - enum:
+              - mediatek,mt6592-evb
+          - const: mediatek,mt6592
+      - items:
+          - enum:
+              - mediatek,mt6755-evb
+          - const: mediatek,mt6755
+      - items:
+          - enum:
+              - mediatek,mt6765-evb
+          - const: mediatek,mt6765
+      - items:
+          - enum:
+              - mediatek,mt6795-evb
+          - const: mediatek,mt6795
+      - items:
+          - enum:
+              - archermind,mt6797-x20-dev
+              - mediatek,mt6797-evb
+          - const: mediatek,mt6797
+      - items:
+          - enum:
+              - mediatek,mt7622-rfb1
+          - const: mediatek,mt7622
+      - items:
+          - enum:
+              - mediatek,mt7623a-rfb-emmc
+              - mediatek,mt7623a-rfb-nand
+              - mediatek,mt7623n-rfb-emmc
+              - bananapi,bpi-r2
+          - const: mediatek,mt7623
+        description: Also referred to as MT7623N SoC
+
+      - items:
+          - const: mediatek,mt7623a
+      - items:
+          - enum:
+              - mediatek,mt8127-moose
+          - const: mediatek,mt8127
+      - items:
+          - enum:
+              - mediatek,mt8135-evbp1
+          - const: mediatek,mt8135
+      - items:
+          - enum:
+              - mediatek,mt8173-evb
+          - const: mediatek,mt8173
+...
-- 
2.19.1

