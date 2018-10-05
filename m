Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8832CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BDB208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BDB208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeJFAAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:00:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38956 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeJEX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id c20-v6so13347085otl.6;
        Fri, 05 Oct 2018 09:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAy5qx+6J1oOwRzhSrnPqWe3tAf3nbvPmD7N4uqhtmQ=;
        b=YsKOCJE7caFxwCNjtpSfkmGlNQZMjhZd/jl5UN8zqDqlPJRrBTCLrxKG3RWG63Jdkr
         c+R2zHAkpKNOrOJsc6mm2QvfD+gHf3qK5cjPgLC9JiiM1kv1IrLdkRzzmHUVtgfe3h/B
         FImCe4/0KXAtgQwT5WdYcoggxz9PR+Bwwwr9BiE6ouuW/SB0uXsoMJUfIWPSQ2rax0X6
         uriKTIIKAnDtFE+q6IFR4txkpnF/ZGgMLc6aeJAP4faK4/4ZkbymAONltuA8ki+kv/uG
         U7+sPWjQPDyQqzFlXkd33eYZclGlMdcnPNz/Dc1jTqttBebckg24YWNPj9iCD2MDkulI
         c7Yw==
X-Gm-Message-State: ABuFfoiIP14IItlucnaf2l3b6GakQc3iXu2EbtntjLi5fr5bfnC74wVd
        XrA1h5nEetv7NK8exm3qW0VwhmD8mw==
X-Google-Smtp-Source: ACcGV60JWBKhhQVf9wh8sljmmZwoqjYVBjf7AoNbfZMPtUqGjaSJyAa94tYgLwstc8q89YbBwQMbRg==
X-Received: by 2002:a9d:41f6:: with SMTP id v51mr4448257oti.368.1538758768482;
        Fri, 05 Oct 2018 09:59:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:27 -0700 (PDT)
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
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 27/36] dt-bindings: arm: Convert Realtek board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:39 -0500
Message-Id: <20181005165848.3474-28-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
 .../devicetree/bindings/arm/realtek.txt       | 22 ----------------
 .../devicetree/bindings/arm/realtek.yaml      | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 22 deletions(-)
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
index 000000000000..9e3bb3249c77
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/realtek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |+
+  RTD1295 SoC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - mele,v9
+          - probox2,ava
+          - zidoo,x9s
+      - const: realtek,rtd1295
+...
-- 
2.17.1

