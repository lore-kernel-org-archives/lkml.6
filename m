Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07652C65BAB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6792098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6792098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeJEX6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42343 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJEX6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so10931405oiw.9;
        Fri, 05 Oct 2018 09:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3XM1RBhY4v1WmTiSPBtIk0ka+l440+ODBKqqXu90pw=;
        b=othPUBM2bK4dCM4/9X3WqfXoKFSqMo0rr706Rl0XvrKEXTb3WNVwystvGb8EuBA+fs
         3qINTlxdjhpAI9fZ32bJiGGI+NAIQOOo4xFVhFg4JtqzV68iOa98HJX0xqrDuCfLo93c
         cRT4m9QtS7NBIKopRwIGZ+D2BdPRCDJ79Tcs++J8S26AXspWKmJw4bSJ46W7cN4irOYD
         UTG5UeIOm9s0noXg3+o4O/L9hvPbu0pQ4K5k6qX3mGPgOtI/PIyWxgW0IXx93bODzXaf
         TNM4OHKtNaDAHCYelgyCHpioZ077RMl0lwqome82EMFYMtiJ6n5ds/jPw7x3IVroakHb
         QBZw==
X-Gm-Message-State: ABuFfoj8uuZSKh3jkIt2VXPqbPSG1EwNkhkKABxh6Ml5lgq0+LlAbIwp
        5U1qf9tXxKpYjYUk4eVVs8R4APXpiA==
X-Google-Smtp-Source: ACcGV60AgRw3R5LJgV1x9+oI865q5N6/ndRU9D+ZWO2QIsss0NXUboNGgrxCF+DjBK6gh3Q57fTXXg==
X-Received: by 2002:aca:490b:: with SMTP id w11-v6mr5885174oia.126.1538758754465;
        Fri, 05 Oct 2018 09:59:14 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:13 -0700 (PDT)
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
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 17/36] dt-bindings: arm: Convert Altera board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:29 -0500
Message-Id: <20181005165848.3474-18-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Altera SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/altera.txt        | 14 -------------
 .../devicetree/bindings/arm/altera.yaml       | 20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera.txt b/Documentation/devicetree/bindings/arm/altera.txt
deleted file mode 100644
index 558735aacca8..000000000000
--- a/Documentation/devicetree/bindings/arm/altera.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Altera's SoCFPGA platform device tree bindings
----------------------------------------------
-
-Boards with Cyclone 5 SoC:
-Required root node properties:
-compatible = "altr,socfpga-cyclone5", "altr,socfpga";
-
-Boards with Arria 5 SoC:
-Required root node properties:
-compatible = "altr,socfpga-arria5", "altr,socfpga";
-
-Boards with Arria 10 SoC:
-Required root node properties:
-compatible = "altr,socfpga-arria10", "altr,socfpga";
diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
new file mode 100644
index 000000000000..0fc6564badc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/altera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera's SoCFPGA platform device tree bindings
+
+maintainers:
+  - Dinh Nguyen <dinguyen@opensource.altera.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - altr,socfpga-cyclone5
+        - altr,socfpga-arria5
+        - altr,socfpga-arria10
+      - const: altr,socfpga
+...
-- 
2.17.1

