Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B88208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B88208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeJFAAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:00:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39899 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbeJEX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so10952769oia.6;
        Fri, 05 Oct 2018 09:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vAcI980IVTgNbupxMoc9uNYhSqenj2+Wb2EWxNk+YTs=;
        b=KP0h8m9yO2W98OkBk2qBDlDW8hVug+wsArlPtowkuQKObRC3V3D+d1UCiNJUz9UceX
         zKNgaZOYHwF05apN2LGy38mRLJBqLA4uVvF7vcjIDD4gi5x7QsdwiQAhK+rezU2Pb/8x
         TESYRefjW1Gh/1Ag6kxqRjCnbHZ70KQELcKbikU0qGVZmagxDt0i1x/TavVi8WaTatlD
         LhoD4nlIY1cMOgLxtJsgST/ncJRdIBvwmjfP+SpAJC3TcywW83WF8swW9iY1BygR7oeE
         xE8vem8uQPLzVF5WxS9PkVRgUsonDBtJ9IgHEBDBiIPBd9/iOwYBL6UXTkeq2m4176to
         1cVw==
X-Gm-Message-State: ABuFfojR4/jVIuZVatx9z1NQG05ovUSRYNSPnES6eoERH8vwcL2UiQF3
        U6XY4O+iI7Zg6EYdRQdTbdYF3d5Qbg==
X-Google-Smtp-Source: ACcGV637NIaTq6QLgGUtEnfs8uahImqjLdBgfwKc3fFjYwdBgGsL3MQCe0ESnYkGbgrk6hOt4x95mA==
X-Received: by 2002:aca:38d5:: with SMTP id f204-v6mr5981634oia.195.1538758760439;
        Fri, 05 Oct 2018 09:59:20 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:19 -0700 (PDT)
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
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 21/36] dt-bindings: arm: Convert TI davinci board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:33 -0500
Message-Id: <20181005165848.3474-22-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert TI Davinci SoC bindings to DT schema format using json-schema.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/davinci.txt       | 25 ------------------
 .../bindings/arm/ti/ti,davinci.yaml           | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml

diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
deleted file mode 100644
index 715622c36260..000000000000
--- a/Documentation/devicetree/bindings/arm/davinci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Texas Instruments DaVinci Platforms Device Tree Bindings
---------------------------------------------------------
-
-DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
-Required root node properties:
-    - compatible = "ti,da850-evm", "ti,da850";
-
-DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
-Required root node properties:
-    - compatible = "ti,da850-lcdk", "ti,da850";
-
-EnBW AM1808 based CMC board
-Required root node properties:
-    - compatible = "enbw,cmc", "ti,da850;
-
-LEGO MINDSTORMS EV3 (AM1808 based)
-Required root node properties:
-    - compatible = "lego,ev3", "ti,da850";
-
-Generic DaVinci Boards
-----------------------
-
-DA850/OMAP-L138/AM18x generic board
-Required root node properties:
-    - compatible = "ti,da850";
diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
new file mode 100644
index 000000000000..2675cae91a60
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/davinci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DaVinci Platforms Device Tree Bindings
+
+maintainers:
+  - Sekhar Nori <nsekhar@ti.com>
+description: |
+  DA850/OMAP-L138/AM18x based boards
+
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - ti,da850-evm
+          - ti,da850-lcdk
+          - enbw,cmc
+          - lego,ev3
+      - const: ti,da850
+...
-- 
2.17.1

