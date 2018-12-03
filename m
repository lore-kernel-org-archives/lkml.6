Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9DC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF8B20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF8B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLCVco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45000 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeLCVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so12331007oig.11;
        Mon, 03 Dec 2018 13:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IIdvslIkKvyI14uCjPFuiKDQb0ro77CNIToQQS9yUU=;
        b=U3IFA7Q6qz6ZpgK29vnfBOgVamfdTBZKrZr798txtveRujMEVBvOQHu9Ft3TszixGM
         6mlPYxutunUhqtO/MfIfSZB5KziJYSdJbHiroiwHYis1D8g4INjdIVARr61feKAw9tLd
         5Sd8xIx7dblS5+SxB7HdoCmODIaS2TpPIdVHzlaPENmOcIplDBsE1nLTWg080aulxozU
         7nUnFWVSUWRm78tdVUEym9bsZwUaC6ugeeWPzlr14+Y+I93SPQQ9AngoL/CwqFJ+zsDb
         muQQts+Jk9kV3sZE8PhheDTLqzUIXL8Xx4iQunM6KOvKRcjmRNiwksX1KoZfKNlusd+h
         e8sA==
X-Gm-Message-State: AA+aEWbPhLcBOwsUAFLbx9Bf773/9FO3jgUZ5LFAsYwf5a+WC98mSzZC
        /L1PBhcnqC4tTeEeaGTU1Cxd0Z0=
X-Google-Smtp-Source: AFSGD/V0RKWgiV+8v5o/ObZn40fBtu+tEnkBn3Y8PAKZCP7bxtrjWb3WwwWiIO1daI7k6IqgrdhdMQ==
X-Received: by 2002:aca:ad53:: with SMTP id w80mr10278765oie.148.1543872761266;
        Mon, 03 Dec 2018 13:32:41 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding to its own file
Date:   Mon,  3 Dec 2018 15:32:02 -0600
Message-Id: <20181203213223.16986-14-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is best practice to have 1 binding per file, so board level bindings
should be separate for various misc SoC bindings.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
 .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
 2 files changed, 28 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4498292b833d..f5c8d50a3506 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -107,32 +107,3 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,s400" (Meson axg a113d)
 
   - "amlogic,u200" (Meson g12a s905d2)
-
-Amlogic Meson Firmware registers Interface
-------------------------------------------
-
-The Meson SoCs have a register bank with status and data shared with the
-secure firmware.
-
-Required properties:
- - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
-
-Properties should indentify components of this register interface :
-
-Meson GX SoC Information
-------------------------
-A firmware register encodes the SoC type, package and revision information on
-the Meson GX SoCs.
-If present, the following property should be added :
-
-Optional properties:
-  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
-
-Example
--------
-
-ao-secure@140 {
-	compatible = "amlogic,meson-gx-ao-secure", "syscon";
-	reg = <0x0 0x140 0x0 0x140>;
-	amlogic,has-chip-id;
-};
diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
new file mode 100644
index 000000000000..c67d9f48fb91
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
@@ -0,0 +1,28 @@
+Amlogic Meson Firmware registers Interface
+------------------------------------------
+
+The Meson SoCs have a register bank with status and data shared with the
+secure firmware.
+
+Required properties:
+ - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
+
+Properties should indentify components of this register interface :
+
+Meson GX SoC Information
+------------------------
+A firmware register encodes the SoC type, package and revision information on
+the Meson GX SoCs.
+If present, the following property should be added :
+
+Optional properties:
+  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
+
+Example
+-------
+
+ao-secure@140 {
+	compatible = "amlogic,meson-gx-ao-secure", "syscon";
+	reg = <0x0 0x140 0x0 0x140>;
+	amlogic,has-chip-id;
+};
-- 
2.19.1

