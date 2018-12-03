Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77564C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467DB20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467DB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeLCVdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43606 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLCVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so12339679oie.10;
        Mon, 03 Dec 2018 13:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1hs7k72LLb2iEWqMGzdoCfupHeBs/tEkAC6k/rFIiI=;
        b=ltjaPr1tnhcNCcwcjkMa1pdl0aw1AyY7EpHvr2vd0svkFnI9c0M0NLtDRLfcPQI2Yb
         0GnyD/Dv69rjBqO0EdOIhmPyGuc/PY1Go/KSokTBgHHr2zwuDLw05tJKg3APTLhennQf
         HwrxD3wbsgTXXZ+P0EFHC2/EO3RfZQ/ByOts8P8sjylqosxTXxWUWqeYKvJQWrSMcKxo
         pfe7dgsidmF2zIwitcsOwXvc888Zjh7JxnsgJfW+M7TnkqZCEmQUOkavrudXAW6gtNKn
         +SaQZprqgKDaUrpipgcoVEW0I/i4SQy5cEDCMfksFHPtD3JEHUsH0JTDocmqH5351fy8
         scUQ==
X-Gm-Message-State: AA+aEWZh88XkWswKRDK9+d3tHCapObsm+zJpkB3xqKRgyPbPJXliBU9M
        bK6qPiI3uwZrKzMDFMstDxj0F/M=
X-Google-Smtp-Source: AFSGD/XF/jfO00XsySTH7otrkTH5OwF0eFb0bV+f9h4yYvxwB/+2Vpy36YSSJwTstEYTu374WliBaw==
X-Received: by 2002:aca:c186:: with SMTP id r128mr11603786oif.52.1543872779723;
        Mon, 03 Dec 2018 13:32:59 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 28/34] dt-bindings: arm: Convert SPEAr board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:17 -0600
Message-Id: <20181203213223.16986-29-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SPEAr SoC bindings to DT schema format using json-schema.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/spear.txt         | 26 -------------------
 .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
 2 files changed, 25 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
deleted file mode 100644
index 0d42949df6c2..000000000000
--- a/Documentation/devicetree/bindings/arm/spear.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-ST SPEAr Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the ST SPEAr600 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear600";
-
-Boards with the ST SPEAr300 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear300";
-
-Boards with the ST SPEAr310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear310";
-
-Boards with the ST SPEAr320 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear320";
-
-Boards with the ST SPEAr1310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1310";
-
-Boards with the ST SPEAr1340 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1340";
diff --git a/Documentation/devicetree/bindings/arm/spear.yaml b/Documentation/devicetree/bindings/arm/spear.yaml
new file mode 100644
index 000000000000..f6ec731c9531
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/spear.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SPEAr Platforms Device Tree Bindings
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+  - Stefan Roese <sr@denx.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - st,spear600
+          - st,spear300
+          - st,spear310
+          - st,spear320
+          - st,spear1310
+          - st,spear1340
+...
-- 
2.19.1

