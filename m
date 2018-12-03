Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F5FC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F3820864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F3820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLCVcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeLCVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so12346498oiw.9;
        Mon, 03 Dec 2018 13:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFNWYOfOG81Ka5GW51Nakr7upXPR0PcVFyZoRUNifgE=;
        b=MJXrwhCu/pRW/0QkdM8lENNVA4mVcteFcjKDGOcyJ1+DrWyNJBmWhyszpRloFlVWq2
         cmTVHRFy+cnKU7+mb2N+O/Cxivmcr09yz3+52DTY90aFx6lS51zLteWdjninjhbcHk+E
         6pAPj17+Z+LwSYIh9GdbA41sN5sF7KyAzSR08eanJOjgu0Wd9Z4TGhw4VeDHuUAJuUW3
         i6g95Rckk2hdHXeZBuVjOC7JN1IyTGWoSPPUYT2OQk8sY3nF/vp1DvVHjWgx3D79EMC8
         x3BHBXHgWz8eXV9T7J3Ovpa4l/skbry5GI76lT91XLxppuvFGKvui/Rz+eI4dWFSuTdU
         rOew==
X-Gm-Message-State: AA+aEWZFpQ/X9BkvIWTl4rEEcEgpscMj5n2bp5iKsQ/+3SkyDOCPf8+v
        kNz/EFN+RQxNcypxsrFzbyGlYlU=
X-Google-Smtp-Source: AFSGD/UTpQXmkeGP8n1W89AK/ZbfxGOYSI5PF+554u2S80Q9KWfGYJTxtJ1EOrGe/BVReme8WwqZWg==
X-Received: by 2002:aca:db41:: with SMTP id s62mr10386117oig.349.1543872770126;
        Mon, 03 Dec 2018 13:32:50 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:49 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 20/34] dt-bindings: arm: Convert TI nspire board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:09 -0600
Message-Id: <20181203213223.16986-21-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert TI NSpire SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/nspire.txt        | 14 -----------
 .../devicetree/bindings/arm/ti/nspire.yaml    | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/nspire.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/nspire.yaml

diff --git a/Documentation/devicetree/bindings/arm/nspire.txt b/Documentation/devicetree/bindings/arm/nspire.txt
deleted file mode 100644
index 4d08518bd176..000000000000
--- a/Documentation/devicetree/bindings/arm/nspire.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-TI-NSPIRE calculators
-
-Required properties:
-- compatible: Compatible property value should contain "ti,nspire".
-	CX models should have "ti,nspire-cx"
-	Touchpad models should have "ti,nspire-tp"
-	Clickpad models should have "ti,nspire-clp"
-
-Example:
-
-/ {
-	model = "TI-NSPIRE CX";
-	compatible = "ti,nspire-cx";
-	...
diff --git a/Documentation/devicetree/bindings/arm/ti/nspire.yaml b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
new file mode 100644
index 000000000000..e372b43da62f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/nspire.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-NSPIRE calculators
+
+maintainers:
+  - Daniel Tang <dt.tangr@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          # CX models
+          - ti,nspire-cx
+          # Touchpad models
+          - ti,nspire-tp
+          # Clickpad models
+          - ti,nspire-clp
+...
-- 
2.19.1

