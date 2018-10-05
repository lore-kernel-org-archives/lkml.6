Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA646C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE22098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFE22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeJEX7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34097 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbeJEX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12-v6so13401761otl.1;
        Fri, 05 Oct 2018 09:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pw0v9K8eQLjlmD9GNG38KcZSA/yO1NRAOL0GIrmfslI=;
        b=eyi2KGBxrO/e1p3kbJs1R/aI0p2DXLrtmqbKs5TUJO+1G9WwXdkBmDhozg7KgyMPE1
         BwmYfWK/uqvZX+LUMmmQkd1yINI99MN3T761QeB4Gp074z2ow+CbGROAPWNsrMlK0G+M
         iw7Z8q5VCYl2agwoFXQz5VAFiU++9BZP7O0JTGen1EMGXN4r1QjdcQR/+j54Tep7ANPI
         87skJZqyMDTrVYLoUetgptgZGGWB9eTnPK2enj/5Be1ktYWIo376HlhHbfaQddleXga+
         3S2IcMlro30xiKnmL76iuYh8KbgCkgKYHEc6CaCwkuifx4XkQdCA2BYyW4uj2jLfjVwa
         BJIA==
X-Gm-Message-State: ABuFfojcYRw6ao2uBq/G2bmezUGjmI5ktGn642hMVoLVSCA7qGCVP6Yz
        AWFQ3o4s0w+jox4Vwa4BS57T5f2uzg==
X-Google-Smtp-Source: ACcGV60V51IBXZg9hjZhWscF6z8ntGmh7H6yE5ggaXuAOPx/YdxK429N6UfoN6ISiVfwCuGRPzl/Gg==
X-Received: by 2002:a9d:1723:: with SMTP id i35mr7449054ota.223.1538758776434;
        Fri, 05 Oct 2018 09:59:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:35 -0700 (PDT)
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
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 33/36] dt-bindings: arm: Convert Tegra board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:45 -0500
Message-Id: <20181005165848.3474-34-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Tegra SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra.txt         | 60 -------------
 .../devicetree/bindings/arm/tegra.yaml        | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
deleted file mode 100644
index 32f62bb7006d..000000000000
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-NVIDIA Tegra device tree bindings
--------------------------------------------
-
-SoCs
--------------------------------------------
-
-Each device tree must specify which Tegra SoC it uses, using one of the
-following compatible values:
-
-  nvidia,tegra20
-  nvidia,tegra30
-  nvidia,tegra114
-  nvidia,tegra124
-  nvidia,tegra132
-  nvidia,tegra210
-  nvidia,tegra186
-  nvidia,tegra194
-
-Boards
--------------------------------------------
-
-Each device tree must specify which one or more of the following
-board-specific compatible values:
-
-  ad,medcom-wide
-  ad,plutux
-  ad,tamonten
-  ad,tec
-  compal,paz00
-  compulab,trimslice
-  nvidia,beaver
-  nvidia,cardhu
-  nvidia,cardhu-a02
-  nvidia,cardhu-a04
-  nvidia,dalmore
-  nvidia,harmony
-  nvidia,jetson-tk1
-  nvidia,norrin
-  nvidia,p2371-0000
-  nvidia,p2371-2180
-  nvidia,p2571
-  nvidia,p2771-0000
-  nvidia,p2972-0000
-  nvidia,roth
-  nvidia,seaboard
-  nvidia,tn7
-  nvidia,ventana
-  toradex,apalis_t30
-  toradex,apalis_t30-eval
-  toradex,apalis-tk1
-  toradex,apalis-tk1-eval
-  toradex,colibri_t20-512
-  toradex,colibri_t30
-  toradex,colibri_t30-eval-v3
-  toradex,iris
-
-Trusted Foundations
--------------------------------------------
-Tegra supports the Trusted Foundation secure monitor. See the
-"tlm,trusted-foundations" binding's documentation for more details.
diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
new file mode 100644
index 000000000000..9cebcfaaad1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/tegra.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra device tree bindings
+
+maintainers:
+  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
+  - Peter De Schrijver <pdeschrijver@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - compal,paz00
+              - compulab,trimslice
+              - nvidia,harmony
+              - nvidia,seaboard
+              - nvidia,ventana
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - ad,medcom-wide
+              - ad,plutux
+              - ad,tec
+          - const: ad,tamonten
+          - const: nvidia,tegra20
+      - items:
+          - const: toradex,iris
+          - const: toradex,colibri_t20-512
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - nvidia,beaver
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - nvidia,cardhu-a02
+              - nvidia,cardhu-a04
+          - const: nvidia,cardhu
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - toradex,apalis_t30-eval
+          - const: toradex,apalis_t30
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - toradex,colibri_t30-eval-v3
+          - const: toradex,colibri_t30
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - nvidia,dalmore
+              - nvidia,roth
+              - nvidia,tn7
+          - const: nvidia,tegra114
+      - items:
+          - enum:
+              - nvidia,jetson-tk1
+              - nvidia,venice2
+          - const: nvidia,tegra124
+      - items:
+          - const: toradex,apalis-tk1-eval
+          - const: toradex,apalis-tk1
+          - const: nvidia,tegra124
+      - items:
+          - enum:
+              - nvidia,norrin
+          - const: nvidia,tegra132
+          - const: nvidia,tegra124
+      - items:
+          - enum:
+              - nvidia,p2371-0000
+              - nvidia,p2371-2180
+              - nvidia,p2571
+          - const: nvidia,tegra210
+      - items:
+          - enum:
+              - nvidia,p2771-0000
+          - const: nvidia,tegra186
+      - items:
+          - enum:
+              - nvidia,p2972-0000
+          - const: nvidia,tegra194
-- 
2.17.1

