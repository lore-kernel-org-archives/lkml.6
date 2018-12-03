Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8917DC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575120864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5575120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeLCVeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:34:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43117 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLCVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so13091339otr.10;
        Mon, 03 Dec 2018 13:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYVF1/N3KzDGFvlUREOlAA6rOeGKGj1HKQArIj1wxGM=;
        b=t1CNXRjI1eHV2Ro8q3IM/C2aLbMNISSmjwL0OfYLkeEUchFB61q3LIE4s8cS2XQ+5/
         qpkX2oY171JLNCTyVZprrZgp8sWO0SNbhUU52kRfdJtm31fq1UnaRd64+OFYpZTY3jLC
         4xUU42P5WF9UA4AwmsD2CHm5zkJhXzHTvtWbanWQniLAp8y8rjpK4mdjoSNWJuUbZPll
         /LQ/DUrfvmULd7siZ09qHyqtWSt3iWY0y732C19aKiJDfo5R+SjvsaWh/oj8nhTa7SH1
         R02F8zFh+dXPxZXJ5aQ+MUovJwSZF5mze249+mDVkfdx/MsXlsU1o9nh5L19MMyjqhn4
         FIpQ==
X-Gm-Message-State: AA+aEWY6IEQO5DIzcB4JIvi4n39Ghq7OFtobHHskU2E+sbA+gbXGU8P1
        SUZV07+Tla/7s2dJEsHy9aOAVxs=
X-Google-Smtp-Source: AFSGD/UBdGfcxoc66a+Wu6V2RgEoWHkXqh+yZgo9RFy4a0rjU9R++UXS7xSpOi4QQ7F/mgJpLl9RLg==
X-Received: by 2002:a9d:348:: with SMTP id 66mr10568044otv.300.1543872766523;
        Mon, 03 Dec 2018 13:32:46 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:45 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 17/34] dt-bindings: arm: Convert TI davinci board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:06 -0600
Message-Id: <20181203213223.16986-18-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert TI Davinci SoC bindings to DT schema format using json-schema.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/davinci.txt       | 25 ------------------
 .../bindings/arm/ti/ti,davinci.yaml           | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml

diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
deleted file mode 100644
index 715622c36260..000000000000
--- a/Documentation/devicetree/bindings/arm/davinci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Texas Instruments DaVinci Platforms Device Tree Bindings
---------------------------------------------------------
-
-DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
-Required root node properties:
-    - compatible = "ti,da850-evm", "ti,da850";
-
-DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
-Required root node properties:
-    - compatible = "ti,da850-lcdk", "ti,da850";
-
-EnBW AM1808 based CMC board
-Required root node properties:
-    - compatible = "enbw,cmc", "ti,da850;
-
-LEGO MINDSTORMS EV3 (AM1808 based)
-Required root node properties:
-    - compatible = "lego,ev3", "ti,da850";
-
-Generic DaVinci Boards
-----------------------
-
-DA850/OMAP-L138/AM18x generic board
-Required root node properties:
-    - compatible = "ti,da850";
diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
new file mode 100644
index 000000000000..4326d2cfa15d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/davinci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DaVinci Platforms Device Tree Bindings
+
+maintainers:
+  - Sekhar Nori <nsekhar@ti.com>
+
+description:
+  DA850/OMAP-L138/AM18x based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - ti,da850-evm    # DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
+          - ti,da850-lcdk   # DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
+          - enbw,cmc        # EnBW AM1808 based CMC board
+          - lego,ev3        # LEGO MINDSTORMS EV3 (AM1808 based)
+      - const: ti,da850
+...
-- 
2.19.1

