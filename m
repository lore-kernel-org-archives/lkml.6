Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF69C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A49B21707
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A49B21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLCVdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41166 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeLCVdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so13121893otk.8;
        Mon, 03 Dec 2018 13:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cE1v9dL0zvH+rxZgt//TElW5sNm8BLRK/4XdbU5h9c=;
        b=B6eGs1O3R/TJMZn8kJK78ndHRkkl1ocU+k+WwrbqMJEH96N2FEdeLnHeed38rEieTW
         8swVY/X7mreDmllATsaKmgMB2afOgGjY0o8K9NNqm8lGVdcn/rf5zKZqT6luIIa9u11O
         9VDBIg71Rrk8hx6IdCi5CeGtfBfh/kwD49ZdEAlC1gTIiIm21QVU0HkFJvig38du+2kD
         bApeU+bbM/w5DBrL1qhwfnRtr0k60A+VPCA9R8ZO/INUIgdXYoJ2SbQORloFfKtBp3lJ
         otnxSLyIqcmHAj44AX4xdO2spxAHH95f6xD1g8TiEpBadL5HKmToK5C1dWNiqacQgzV/
         kUiQ==
X-Gm-Message-State: AA+aEWYhYIpKBgtNKYWlroPVzaCW9rZW0UCK2gAXNNuMjz9zEAa68dTI
        r/oHPRSn+sykS3D7CsPUzk4nw/Q=
X-Google-Smtp-Source: AFSGD/V4E2Kn34tHeytd72/r5PH7r5wPiTkquvmlJoSQYBqXc4+jB9QkvqYvGiHgfP6dVkM51GiUrA==
X-Received: by 2002:a9d:784a:: with SMTP id c10mr11686907otm.175.1543872780957;
        Mon, 03 Dec 2018 13:33:00 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:33:00 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 29/34] dt-bindings: arm: Convert ST STi board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:18 -0600
Message-Id: <20181203213223.16986-30-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ST STi SoC bindings to DT schema format using json-schema.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sti.txt | 23 -------------------
 .../devicetree/bindings/arm/sti.yaml          | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sti.yaml

diff --git a/Documentation/devicetree/bindings/arm/sti.txt b/Documentation/devicetree/bindings/arm/sti.txt
deleted file mode 100644
index 8d27f6b084c7..000000000000
--- a/Documentation/devicetree/bindings/arm/sti.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-ST STi Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the ST STiH415 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih415";
-
-Boards with the ST STiH416 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih416";
-
-Boards with the ST STiH407 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih407";
-
-Boards with the ST STiH410 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih410";
-
-Boards with the ST STiH418 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih418";
-
diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
new file mode 100644
index 000000000000..47f9b8eebaa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sti.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST STi Platforms Device Tree Bindings
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@st.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - st,stih415
+          - st,stih416
+          - st,stih407
+          - st,stih410
+          - st,stih418
+...
-- 
2.19.1

