Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913B4C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6396A21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6396A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeJEX7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40339 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbeJEX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id w67so13338959ota.7;
        Fri, 05 Oct 2018 09:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y7aoVKyFfwtD/XX+mmuwaVWhSjIowWCZ6eMMY+0377c=;
        b=lXkVmhfrqA3PgNHSu+mW4aiHJYtURzAI0T5KqajLQJt7+ZhuVTwP3DmtE8kKAH9q+m
         QJwJPg2qfyY1FnhcFmICtKRlabkdUKoyymbiveJ81+oo4Imo+NHVpAZNFIedew05+xNE
         bMVQLRb1iHZdJBij1HphZCVQ+QbFQCR/e4KcEQ7T53w5sjf0fbz4jYvJP3MHcLPPZtpF
         ddB64CvV2LrpPkHrNy2WMRgchfw85XKKCNuwCQbOWx6DtS9Nu4/8S6Zkmcbua2Za1rjb
         Ivl2CeuFR/RHR2kGf+cjYA+XZcYZ+eLx9kAR76mOBmP2k3aJY3vF/wNFh8Vt82rCpb/i
         hVJg==
X-Gm-Message-State: ABuFfoh8DB/vc+CjIYh0G6D0k8sNAXbN/xt0NMZCdyghfmQXOjH5MBiz
        x6g32lZRe23TcqX8MDVYLX93TLlVJw==
X-Google-Smtp-Source: ACcGV63AXxjp9n2DA/7x8LwESe3X3ifNCO5wYGtNbwqG0vh+OYNB0OLz/egD72iUV3+eY0J8UGJKuQ==
X-Received: by 2002:a9d:2af:: with SMTP id 44-v6mr6580039otl.244.1538758764568;
        Fri, 05 Oct 2018 09:59:24 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:23 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 24/36] dt-bindings: arm: Convert TI nspire board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:36 -0500
Message-Id: <20181005165848.3474-25-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
index 000000000000..882f79f95942
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/nspire.yaml#
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
2.17.1

