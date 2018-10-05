Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623CDC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31936208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31936208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeJEX7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34088 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbeJEX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so13401552otl.1;
        Fri, 05 Oct 2018 09:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QaNxpesTBxVr/7vfmPYasCc5X/KE8pFik4kvCVqTlQ=;
        b=ju0MXjpEbULJ3s9WGNRVvIjkcBOcUPF/QRLu6sKAzuqdbMvpo6RtfGPrqEjjVDkpyt
         xWCyZdJ5Yd3be0I/KVICcrQGQ4jwh/xWKxlgX3CNK2VIJjsOurr35kZ8cyyARmp7Zirp
         Q7OHLMfnMwZBIZRB4lgomLcRbT9sSCBKQK8skgKFOKLON2JoFxEWm8tTy6gfc/0aBaxP
         PyYWnSGoJxQxrp6VQ2wNK4eJLxzjoJ0DJaWBBDO0lpilV7kU2rwGlsRmj97dBz4eh7yS
         ZdzZIYwmlgWwWDoHzkkPoZVgbJAXbe6JJu7zl3nSduwCZldumW+4BCWxGrfud8pcorsF
         RG7g==
X-Gm-Message-State: ABuFfoglhTx/OFePUkONuMI00BK4VQ4RwZ2MrVx87iE7Yr4AdDufC38c
        3bDXYZIQIrsv44/OKiUt11d20uIiNw==
X-Google-Smtp-Source: ACcGV62iT/xVLjAPRKDQGEMKgJsFQwL40/myLGQExeWi6fOCiogYbQuC642rKZB22O2JdqLW3mnHTQ==
X-Received: by 2002:a9d:3c1b:: with SMTP id q27mr7258445otc.103.1538758772490;
        Fri, 05 Oct 2018 09:59:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:31 -0700 (PDT)
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
        Barry Song <baohua@kernel.org>
Subject: [PATCH 30/36] dt-bindings: arm: Convert CSR SiRF board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:42 -0500
Message-Id: <20181005165848.3474-31-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert CSR SiRF SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/sirf.txt          | 11 --------
 .../devicetree/bindings/arm/sirf.yaml         | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.yaml

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
deleted file mode 100644
index 7b28ee6fee91..000000000000
--- a/Documentation/devicetree/bindings/arm/sirf.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-CSR SiRFprimaII and SiRFmarco device tree bindings.
-========================================
-
-Required root node properties:
-    - compatible:
-    - "sirf,atlas6-cb" : atlas6 "cb" evaluation board
-    - "sirf,atlas6" : atlas6 device based board
-    - "sirf,atlas7-cb" : atlas7 "cb" evaluation board
-    - "sirf,atlas7" : atlas7 device based board
-    - "sirf,prima2-cb" : prima2 "cb" evaluation board
-    - "sirf,prima2" : prima2 device based board
diff --git a/Documentation/devicetree/bindings/arm/sirf.yaml b/Documentation/devicetree/bindings/arm/sirf.yaml
new file mode 100644
index 000000000000..5675b3efda96
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/sirf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CSR SiRFprimaII and SiRFmarco device tree bindings.
+
+maintainers:
+  - Binghua Duan <binghua.duan@csr.com>
+  - Barry Song <Baohua.Song@csr.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: sirf,atlas6-cb
+          - const: sirf,atlas6
+      - items:
+          - const: sirf,atlas7-cb
+          - const: sirf,atlas7
+      - items:
+          - const: sirf,prima2-cb
+          - const: sirf,prima2
+...
-- 
2.17.1

