Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CFCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3AA20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3AA20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeLCVfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:35:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41229 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLCVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so12344059oii.8;
        Mon, 03 Dec 2018 13:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crpmuMvjqBUzMweRcyITJf7puD+Tt8shjcgunnXtNSw=;
        b=rbTqbfNAGn9O004h9BI3+2XCBA/E+egHBV5maQ9L6jalv2E3ZIAN8CuPufOHHpdUp/
         dudAHou5PbX5NbZUGzRoWBkT5LPrHvtIJJ0VsbFqnfStFxIx3PHafx9fVSTYI96IEqQQ
         YiHishYM7j/zuTWwfGyBxXUaVsHYstDtdcrfrNEs6k9Jd0jumUvpS/pcyDPfaeA0FluX
         7roum2CSPTnn0GYLxYRy+d9ob9SCLxltP/lbrzDwHRDMJ4VazpcqKNMnV6P5pzSIGPS7
         X+0f5/ArNweIgEII+pfseCdg8kDpjNSmHjvMGM5DD40l64AZcf5otmfDrBCCE8Paj4On
         HjoQ==
X-Gm-Message-State: AA+aEWZomPg+iNeM3nThG8vHLkY9drICMfZRN2rWJCOo/ItMFGD8x0r5
        MXq5JEAiGfTTyVYvXquT+fuue6k=
X-Google-Smtp-Source: AFSGD/WbaVbWvCcLA6sXHHyRjSgS3AMA7ZRkmz2ls6tHdAnvD+09yqYGArH6HcCp2dFdAHA28AH6Mw==
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr11306228oig.35.1543872760042;
        Mon, 03 Dec 2018 13:32:40 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:39 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v2 12/34] dt-bindings: arm: Convert Altera board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:01 -0600
Message-Id: <20181203213223.16986-13-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 000000000000..49e0362ddc11
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/altera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera's SoCFPGA platform device tree bindings
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
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
2.19.1

