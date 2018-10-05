Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04897C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B7B2098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B7B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeJEX6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45372 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeJEX6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so10927721oig.12;
        Fri, 05 Oct 2018 09:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7OkSebvuDu3GYBwaaAJvmjae/fS/q7Ybf2TAf/0foQ=;
        b=GWuGDZygR9yg7YAkqsWsNPyvDCX9imsqibXW5ODmoZ+3jI6C1heEaRHPif+j/cmEE+
         jhCbekJSNdIfSArOoqbIgpn6otyp56BoocsNwX6fHDiNBgHbGY9ckKJE2KS7VE3cM04+
         3w0LFgMivx7SL/6UM2/vyzt/f06p/03jSQBLLBDnQnsJXK0SxSuvd5KRQQdVcJdLPnFM
         0HhLUiO2VZKrJg9UZi5ylW7Gsa9C+paj1T/8VNoHrfvOe7F39OFzkspdP13jy6k6BQ58
         m8D38qt/7Eqp+8xdjFZLhRbsMvoETZwwmM4vIufJSnSn6WwaDHW9qyXQosJcGBo9p+iz
         jcMg==
X-Gm-Message-State: ABuFfoiJm6vU6eVTccX7uOrxbXascF2JBUCgtLjx0aXyIIW1T8v4jWIW
        wD+ysT6wrTo1wS7pZcUwt9sdgayTLg==
X-Google-Smtp-Source: ACcGV603AZmYMM959ZiqeSNbPbCx6juZGnicL2LLW1xgg9bdM4NS/wyqNjo6TeDNGfZt8qWxvkdKFQ==
X-Received: by 2002:aca:b485:: with SMTP id d127-v6mr6011131oif.165.1538758753133;
        Fri, 05 Oct 2018 09:59:13 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:12 -0700 (PDT)
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
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 16/36] dt-bindings: arm: Convert Alpine board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:28 -0500
Message-Id: <20181005165848.3474-17-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Alpine SoC bindings to DT schema format using json-schema.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 16 --------------
 .../devicetree/bindings/arm/al,alpine.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
deleted file mode 100644
index d00debe2e86f..000000000000
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Annapurna Labs Alpine Platform Device Tree Bindings
----------------------------------------------------------------
-
-Boards in the Alpine family shall have the following properties:
-
-* Required root node properties:
-compatible: must contain "al,alpine"
-
-* Example:
-
-/ {
-	model = "Annapurna Labs Alpine Dev Board";
-	compatible = "al,alpine";
-
-	...
-}
diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
new file mode 100644
index 000000000000..95f8629f7b0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/al,alpine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Annapurna Labs Alpine Platform Device Tree Bindings
+
+maintainers:
+  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: al,alpine
+  model:
+    items:
+      - const: "Annapurna Labs Alpine Dev Board"
+
+...
-- 
2.17.1

