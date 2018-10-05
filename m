Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC84C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B77214C1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B77214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeJEX6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34498 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJEX6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id v69-v6so10975874oif.1;
        Fri, 05 Oct 2018 09:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPjyBcDgH3rQvK5Topeu+rZwcMHC70P5llkoEmHzmYE=;
        b=n35/2+WrgZJw8tHlvTa6JCsMCg9+HE0UPfP3X9B5Jl8E8OEZFLqN3J/84bOZeIih9C
         eGnxyQNJ/T+EFNEZ3AwzMkXdVCy/YEXARhMireN/J+CV2hiQIc7WHND5souq5FhurC8z
         8OPlKGCo91JS9cE0YbJpeiW9WnqB44qGmzIv6bW0XyBJvW6n5ZWKuPezG2PFDt+NkQ18
         hTKEIg7Sv3FlsLQCYbhYvOFZPzLpqpiCiwX/qi0qwpzVyf9h25VMw1Rbdk3e/QpZdc+h
         mzIe5kBm57i0k8LFtVI6Zx3hilPqLYNhnm2l/cQYPRKEgPB03JhN9e05roqEhFG23Ec8
         aIQw==
X-Gm-Message-State: ABuFfoh7NfnliFgxHp1ctGs7ozMddzq7S1JXtStqziOlw/VfvzkzRSgv
        gdbkUQuzwuhm2U2vEnD+YraMfdBAeg==
X-Google-Smtp-Source: ACcGV63zJcemAHN9pGK3CQ96Xg0N80/A72O3lshCWxDxbzkvqiuBxIVevpG07Krmfcy6q/4N8CFL5A==
X-Received: by 2002:aca:3585:: with SMTP id c127-v6mr1661072oia.63.1538758751756;
        Fri, 05 Oct 2018 09:59:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:11 -0700 (PDT)
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
Subject: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings to jsonschema
Date:   Fri,  5 Oct 2018 11:58:27 -0500
Message-Id: <20181005165848.3474-16-robh@kernel.org>
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

Convert Actions Semi SoC bindings to DT schema format using json-schema.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/actions.txt       | 56 -------------------
 .../devicetree/bindings/arm/actions.yaml      | 34 +++++++++++
 2 files changed, 34 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
deleted file mode 100644
index d54f33c4e0da..000000000000
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Actions Semi platforms device tree bindings
--------------------------------------------
-
-
-S500 SoC
-========
-
-Required root node properties:
-
- - compatible :  must contain "actions,s500"
-
-
-Modules:
-
-Root node property compatible must contain, depending on module:
-
- - LeMaker Guitar: "lemaker,guitar"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Allo.com Sparky: "allo,sparky"
- - Cubietech CubieBoard6: "cubietech,cubieboard6"
- - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
-
-
-S700 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s700"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Cubietech CubieBoard7: "cubietech,cubieboard7"
-
-
-S900 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s900"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
new file mode 100644
index 000000000000..af9345a228b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -0,0 +1,34 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/arm/actions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC. The Actions Semi
+  S900 is a quad-core ARM Cortex-A53 SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - lemaker,guitar-bb-rev-b
+          - enum:
+              - lemaker,guitar
+              - allo,sparky
+              - cubietech,cubieboard6
+          - const: actions,s500
+        minItems: 2
+        maxItems: 3
+        additionalItems: false
+      - items:
+          - const: cubietech,cubieboard7
+          - const: actions,s700
+      - items:
+          - const: ucrobotics,bubblegum-96
+          - const: actions,s900
-- 
2.17.1

