Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E259214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E259214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLCVc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37582 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLCVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so12373680oia.4;
        Mon, 03 Dec 2018 13:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oC6xtxPGgX0vrAEYZdrzvcerpUBFv1AQjT/XCrxTgx0=;
        b=gKJmNsEr77qWZ8VoS1P+H6WXgEEle0+MP5kMXxtL9G9dEnKojj6GRoZXJWNyQ+ZX7d
         UaD/AUBhsGYBLaAiaHvodrGrT+59KekZBUiwT5SAklv8jqfVh64GCo0y4e2/8hlBM0FX
         fVSwQfyGhbtfqGJi5/7w2D53qXmluY8HY7B7sztDCt4jA0/brl8qnWkU0jIXVFgEn8Bh
         twkkl8DYcYAvR/0fsU/Su8CAoKEolN+dgjRt8+VittM0fgjI+HAXdURGswHRexznpOsU
         fB2GliQTSrvPZ3zVOlnQnMjhN2HyjI3MtdtRJPuGtuvX4k/OsUHPj/NdWxv3Bvf+jT6T
         xxGw==
X-Gm-Message-State: AA+aEWZvSopBTHTa8YxAY4kMCAhCTzGSmlibnw9L/rVTpxIrO0Rqp3tc
        mvb6N6DEv4qfZEaBZ81W6incS4k=
X-Google-Smtp-Source: AFSGD/U4jSE9cLoojt1F8nCYnEN25i4Ed+nmzggq5QD7npe8dCtWHghkjfbGS0jwVDUPRG4QNPbaww==
X-Received: by 2002:aca:5b88:: with SMTP id p130mr10394553oib.96.1543872773873;
        Mon, 03 Dec 2018 13:32:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:53 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 23/34] dt-bindings: arm: Convert Realtek board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:12 -0600
Message-Id: <20181203213223.16986-24-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Realtek SoC bindings to DT schema format using json-schema.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/realtek.txt       | 22 ------------------
 .../devicetree/bindings/arm/realtek.yaml      | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
deleted file mode 100644
index 95839e19ae92..000000000000
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Realtek platforms device tree bindings
---------------------------------------
-
-
-RTD1295 SoC
-===========
-
-Required root node properties:
-
- - compatible :  must contain "realtek,rtd1295"
-
-
-Root node property compatible must contain, depending on board:
-
- - MeLE V9: "mele,v9"
- - ProBox2 AVA: "probox2,ava"
- - Zidoo X9S: "zidoo,x9s"
-
-
-Example:
-
-    compatible = "zidoo,x9s", "realtek,rtd1295";
diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
new file mode 100644
index 000000000000..84ee9b22ef7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/realtek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    # RTD1295 SoC based boards
+    items:
+      - enum:
+          - mele,v9
+          - probox2,ava
+          - zidoo,x9s
+      - const: realtek,rtd1295
+...
-- 
2.19.1

