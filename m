Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C042CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808B7214ED
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808B7214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLCVcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34669 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeLCVcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so13159389otk.1;
        Mon, 03 Dec 2018 13:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fzihti73hKbmmJj389IERxLXU8bEWQPykR3QHUcAyXE=;
        b=n7NJdPBeXVeHo+3LpilYro0u4MqRhgjjFFjBi43fTMOIU6+I5Uhn8l+38H7qkFi2TS
         5/G7PfzKAIOQfiA1t0oxlYBcz6HDWcE+baIxlW7KEp/IENy3OVnVt7qtkF+Nvtez9mTY
         NzmKY+Z7+kHU6DPzNBk7w+JcGzw2RUiaNsroh7I3zBL0cKWTr6eE+dDRoYNB5C/URMoR
         apTAU93Oa9UlNV/mhT8H5O1rNrcGzsvQeg/7Ag/mD5cK6ngwAvh6ZWcr4TWb9KVQePOc
         4spaAAop5TUKWm6trME3Sn39eugG6DUcYH5/meI35taikWS33t3cO2zoOQm7mkTWGL2l
         Dpew==
X-Gm-Message-State: AA+aEWYX7q+Y0QezUdZIpSfBNlQePRX8++sqa1wyJVByABlE5pSl02Z4
        3N89iuQiUp2ZQ24NhEMRXT4RK9A=
X-Google-Smtp-Source: AFSGD/W3VkST+YpK8l89kosRsB/Jx0BIl4Ln4graJWqTZKltf+DvjeoVagLbD7o1NTXUWuTn6VUyGA==
X-Received: by 2002:a9d:694a:: with SMTP id p10mr12005275oto.44.1543872757948;
        Mon, 03 Dec 2018 13:32:37 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:37 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 10/34] dt-bindings: arm: Convert Actions Semi bindings to jsonschema
Date:   Mon,  3 Dec 2018 15:31:59 -0600
Message-Id: <20181203213223.16986-11-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Actions Semi SoC bindings to DT schema format using json-schema.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/actions.txt       | 56 -------------------
 .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
 2 files changed, 38 insertions(+), 56 deletions(-)
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
index 000000000000..60abd371e474
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/actions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      # The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
+      - items:
+          - enum:
+              - allo,sparky # Allo.com Sparky
+              - cubietech,cubieboard6 # Cubietech CubieBoard6
+          - const: actions,s500
+      - items:
+          - enum:
+              - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
+          - const: lemaker,guitar
+          - const: actions,s500
+
+      # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
+      - items:
+          - enum:
+              - cubietech,cubieboard7 # Cubietech CubieBoard7
+          - const: actions,s700
+
+      # The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
+      - items:
+          - enum:
+              - ucrobotics,bubblegum-96 # uCRobotics Bubblegum-96
+          - const: actions,s900
-- 
2.19.1

