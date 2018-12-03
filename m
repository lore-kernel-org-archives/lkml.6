Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02233C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC820661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AC820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLCVdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41264 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeLCVdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so12345168oii.8;
        Mon, 03 Dec 2018 13:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmY97rqmVLH/aYhI9MMshRrLQb1X3srsPldhSeApmNY=;
        b=nI7zm80+0PNNpk/xs0KU7760L4bYt3zC+OtLsMvHjKVpoTTuJaBMcWTHBDPjuaMYyX
         E2yxJMWWPpiNJcdM4O2ehLDzy0V3M3eCaXS8MrPqMcsl7k8nR+xH7q6Plyazzo7/9oTY
         HaefN8kLXkelprrGOA3MKv8iowj3VV12fPNJCQpuWuCsVHMBZKIFCpTocrjP/zd4ywCp
         yu27acO1jDE9Rnl3pT2bS2DdNgSlQsJ99hIdWAm1kpQlzMhxHlaMQG5xzbT74sPZJpuL
         8z4KqbD5diAxcfm8pPnvBER7LKdmOJ1UOGLbiJ8WE8cTA7szx6Ua7mQEH6q57LgQ/FKJ
         UA7g==
X-Gm-Message-State: AA+aEWZWKw9jV/THi2KOhdRi2DxOdd4K1KLDTyWCkBFaZ/HtG8Y63CCO
        pkADhYWScCWUqsMZBGd0QIcSdcU=
X-Google-Smtp-Source: AFSGD/VCt7hGvmZxKqKvQyo6sGAvlI0gmsrPJbiXunL2+nUrFgxM5xIaK1eaMkx9Ocdoag5aHiHaLQ==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr8198529oic.233.1543872786508;
        Mon, 03 Dec 2018 13:33:06 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:33:05 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Jun Nie <jun.nie@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 34/34] dt-bindings: arm: Convert ZTE board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:23 -0600
Message-Id: <20181203213223.16986-35-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ZTE SoC bindings to DT schema format using json-schema.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/zte.txt | 14 ----------
 .../devicetree/bindings/arm/zte.yaml          | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/arm/zte.yaml

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
deleted file mode 100644
index 340612794a37..000000000000
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-ZTE platforms device tree bindings
-
----------------------------------------
--  ZX296702 board:
-    Required root node properties:
-      - compatible = "zte,zx296702-ad1", "zte,zx296702"
-
----------------------------------------
--  ZX296718 SoC:
-    Required root node properties:
-      - compatible = "zte,zx296718"
-
-ZX296718 EVB board:
-      - "zte,zx296718-evb"
diff --git a/Documentation/devicetree/bindings/arm/zte.yaml b/Documentation/devicetree/bindings/arm/zte.yaml
new file mode 100644
index 000000000000..2d3fefdccdff
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/zte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE platforms device tree bindings
+
+maintainers:
+  - Jun Nie <jun.nie@linaro.org>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - zte,zx296702-ad1
+          - const: zte,zx296702
+      - items:
+          - enum:
+              - zte,zx296718-evb
+          - const: zte,zx296718
+
+...
-- 
2.19.1

