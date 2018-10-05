Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3539C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892CF2098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892CF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeJFABg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:01:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43276 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeJEX6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so10935170oie.10;
        Fri, 05 Oct 2018 09:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zoNxd1sQf4bhVATt8RklSISv1vp3Ut2WaEzmkh9zdXo=;
        b=K9NvKJKJnYlPB+/XEOcbDYU3wuADZTRAM2P+mjDRthw/iPWhSEkLDRQaq8HyKYNlT3
         i7d3T9ypU4GI/mwF3syhZHkKNvhXEjreNSoyFjNiDAm9j5BE/0CvXY44X6/jMXh0BQdB
         fNlUX5Y/OOWNaK2v4veQ/sc5KMvb0+1pB8IDoJ7gqcy8ACqDU9YjvQSYbmjgc2fu0xkM
         9/g412RvIzNnEfUiGJG0KhPlrG2EGQ06b026CYvRdY0K6eyD6TloszFOsUefZlT379Pg
         gZ6VH9Q225eP1ZZFnT3g3x5JO+vJy8fAWYoP/ClfP3DJlh29NZaDVDsxUlDBo5AFkQza
         gnRQ==
X-Gm-Message-State: ABuFfoj0qvbB1wZQTT55gThFoM7cAy/XdSxj0GHF9qK0vOBjLV7uI8vF
        h6GK/VhoxkApcqE4Z0TP4Jf7BghVTg==
X-Google-Smtp-Source: ACcGV60ra+ZWkkDwvIDTvmqyG9Jnx/zX9evmVtVhgTMw12gz5UPPJB/4HBUGFojHd2Df58cLg11pPA==
X-Received: by 2002:aca:754b:: with SMTP id q72-v6mr6275729oic.13.1538758744745;
        Fri, 05 Oct 2018 09:59:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:03 -0700 (PDT)
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
Subject: [PATCH 10/36] dt-bindings: altera: Convert clkmgr binding to json-schema
Date:   Fri,  5 Oct 2018 11:58:22 -0500
Message-Id: <20181005165848.3474-11-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Altera clkmgr to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/altera/socfpga-clk-manager.txt        | 11 -------
 .../arm/altera/socfpga-clk-manager.yaml       | 30 +++++++++++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
deleted file mode 100644
index 2c28f1d12f45..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Altera SOCFPGA Clock Manager
-
-Required properties:
-- compatible : "altr,clk-mgr"
-- reg : Should contain base address and length for Clock Manager
-
-Example:
-	 clkmgr@ffd04000 {
-		compatible = "altr,clk-mgr";
-		reg = <0xffd04000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
new file mode 100644
index 000000000000..37c2cf08fae0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/altera/socfpga-clk-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA Clock Manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@altera.com>
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: altr,clk-mgr
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+examples:
+  - |
+    clkmgr@ffd04000 {
+      compatible = "altr,clk-mgr";
+      reg = <0xffd04000 0x1000>;
+    };
+
+...
-- 
2.17.1

