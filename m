Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A766920864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A766920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbeLCVeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:34:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39492 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeLCVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so9259325otl.6;
        Mon, 03 Dec 2018 13:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epXZdkd68vXdy7U9ZmRZZFqk/KdWAOyhhT0ff/QRUGQ=;
        b=PH+Cnmh0vGjrBCrL8lv15Ohtj/pew4zI5W8PO8zDD3/VHoNjsGHBDK2tJrOreNHKDl
         bVz0BDMqywWaiaGBArz/9WWC0fQIJ0BN1w92yPkmwPvtgh6kbgc8KBxs09fKXVqv0Yyr
         fYgl9R/TDxOAZopsztbbHv4tM4S0ZRd9q3e63joIhT7oo0KNk+0vQpqXl1SAcGCsnvl+
         UU93ITZB7zjMERtGU1g5hF+/DPVu7eqIzPobFNyHyrFjwj5cdpHsNYxqDmE/mHnl9Hhd
         ZPvO9gTQEP5qklOXtzPxaZLPycxUYs+8I4O6DK5FzVyVod7O4Bnv5lUbCBk6naw3+fEd
         55Ww==
X-Gm-Message-State: AA+aEWZw9DMJoLVYBv5XRnPl2BDdK/8PjwkyDK+hGXPK2gJDmWE3dclH
        RjEYKorKxN8Tk0t+IretI92LuOY=
X-Google-Smtp-Source: AFSGD/WDHrGe+7TyTeIppYHGOSKOKMDr0xidFmV5znony64VM6lJBXnXwHVA8gW+iUwbZ+jqS9sZmw==
X-Received: by 2002:a05:6830:20d6:: with SMTP id z22mr11735816otq.106.1543872771366;
        Mon, 03 Dec 2018 13:32:51 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:50 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io
Subject: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:10 -0600
Message-Id: <20181203213223.16986-22-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Oxford Semi SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-oxnas@groups.io
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
 .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)
diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
new file mode 100644
index 000000000000..6ae51ef513be
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/oxnas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+            - wd,mbwe
+        - const: oxsemi,ox810se
+
+      - items:
+        - enum:
+            - cloudengines,pogoplugv3
+        - const: oxsemi,ox820
-- 
2.19.1

