Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6035120864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6035120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLCVdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47059 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeLCVdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so12313592oif.13;
        Mon, 03 Dec 2018 13:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aP/9dUo4g9hl89aQ4HR1/ZsNrOfnag/55wppWEa93Hs=;
        b=cee/b7UCgHSxbPMU6w1R3newK/V8mnhcTeReO7YaK/VDYvrsLEds8a9u66winoWHmR
         lDur41iMDKf91Um2By/t05hasDN4Bv4jHdCDpBdOCZmKuK4QrCFqXTDB1b9qntw3RljN
         llsuw1pRFmGfHmlTOK3i2Vd7jxZ/KHeSc3U34+ek2ey4jLKdgGcFBag8dhs6V+bDi78a
         e1cUEi2SM16LaFG2uiYNW9gnh9uDsx931fglE6l7kWVhm5yPLX5yjgCaF0kRkq4ToHE0
         nbi3BjNPxqIVRaApGFjlKhUT4JP70L7negdDqqQDkHNGH8yzbw7uTN9vNoQoQzQ++lY5
         M3/w==
X-Gm-Message-State: AA+aEWb00NzMorpUN7QEcwDQLy6tr1U0EVUkRNbAwq/SOMPCI6+BLYpu
        /rpPydGHOFb1ekDo4s4SAJKcqL8=
X-Google-Smtp-Source: AFSGD/VhMeuopsbMmjg3NZLwFCs0tf0JJupxZWjP7qjvPqX37CBQlTeEBpKCQomqRSwKem5n5kBGeg==
X-Received: by 2002:aca:ad53:: with SMTP id w80mr10279520oie.148.1543872782048;
        Mon, 03 Dec 2018 13:33:02 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:33:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 30/34] dt-bindings: arm: Convert Tegra board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:19 -0600
Message-Id: <20181203213223.16986-31-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../devicetree/bindings/arm/tegra.txt         |  65 -----------
 .../devicetree/bindings/arm/tegra.yaml        | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
deleted file mode 100644
index c59b15f64346..000000000000
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ /dev/null
@@ -1,65 +0,0 @@
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
-  toradex,apalis_t30-v1.1
-  toradex,apalis_t30-v1.1-eval
-  toradex,apalis-tk1
-  toradex,apalis-tk1-eval
-  toradex,apalis-tk1-v1.2
-  toradex,apalis-tk1-v1.2-eval
-  toradex,colibri_t20
-  toradex,colibri_t20-eval-v3
-  toradex,colibri_t20-iris
-  toradex,colibri_t30
-  toradex,colibri_t30-eval-v3
-
-Trusted Foundations
--------------------------------------------
-Tegra supports the Trusted Foundation secure monitor. See the
-"tlm,trusted-foundations" binding's documentation for more details.
diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
new file mode 100644
index 000000000000..66493892ffc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/tegra.yaml#
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
+          - enum:
+              - toradex,colibri_t20-eval-v3
+              - toradex,colibri_t20-iris
+          - const: toradex,colibri_t20
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
+          - const: toradex,apalis_t30-eval
+          - const: toradex,apalis_t30
+          - const: nvidia,tegra30
+      - items:
+          - const: toradex,apalis_t30-eval-v1.1
+          - const: toradex,apalis_t30-eval
+          - const: toradex,apalis_t30-v1.1
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
+          - const: toradex,apalis-tk1-v1.2-eval
+          - const: toradex,apalis-tk1-eval
+          - const: toradex,apalis-tk1-v1.2
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
2.19.1

