Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA93C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3283214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3283214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLCVdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34967 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeLCVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so13148654otj.2;
        Mon, 03 Dec 2018 13:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeZnuus+ZQpEVnlN+wmNEXJ5n6BcAmDK+P7WR/GWygk=;
        b=EuXBYTNbjNCtB27jXwATxpXynPWMNxo1QPdaPkDYvf6f007+2GyBVa7sOnK39gqA4L
         zIXYNMWp5ZzEjK16H+aiDLTwZaKY3zHzPtn7rH/Mcxp6ZbJWqmdZyT+9ac8T5ocynsQt
         C4UzLTQ0GoYw1QI/38UIv59+/NpBRz2ScvshSMPw5/nmJuPBvAl/uHQ4/rlsixMTPDPX
         kcN+vUzkyEniYR+9L0Azy+xvmnAvDAAnVn7qG3cqkLE7cQEuBVScKafbic1TZkF6pcZ4
         thUHYx74PCwvKRxMpnuNGfbZg8u9qiwrHq9rgSOg38C/9SjJd4YlwZDq/K9HuFwPuCc4
         YsjQ==
X-Gm-Message-State: AA+aEWZhqbxY7mNeygRbGRmQLTTVMXkya8XMySunrIR0iJ+KpCf698az
        tatV8UVud/xWAmeikHV5LvaA9AA=
X-Google-Smtp-Source: AFSGD/V8cy+kF23PRCwPLdfrTXgC258vUtxGnyrueIzMgRY4FRj1ivgxz+4E8hQ3j2jzF4Ma1D46Tw==
X-Received: by 2002:a9d:439d:: with SMTP id t29mr11843807ote.284.1543872783148;
        Mon, 03 Dec 2018 13:33:03 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:33:02 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Tony Prisk <linux@prisktech.co.nz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 31/34] dt-bindings: arm: Convert VIA board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:20 -0600
Message-Id: <20181203213223.16986-32-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert VIA SoC bindings to DT schema format using json-schema.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/vt8500.txt        | 22 ------------------
 .../devicetree/bindings/arm/vt8500.yaml       | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.yaml

diff --git a/Documentation/devicetree/bindings/arm/vt8500.txt b/Documentation/devicetree/bindings/arm/vt8500.txt
deleted file mode 100644
index 87dc1ddf4770..000000000000
--- a/Documentation/devicetree/bindings/arm/vt8500.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-VIA/Wondermedia VT8500 Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the VIA VT8500 SoC shall have the following properties:
-Required root node property:
-compatible = "via,vt8500";
-
-Boards with the Wondermedia WM8505 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8505";
-
-Boards with the Wondermedia WM8650 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8650";
-
-Boards with the Wondermedia WM8750 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8750";
-
-Boards with the Wondermedia WM8850 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8850";
diff --git a/Documentation/devicetree/bindings/arm/vt8500.yaml b/Documentation/devicetree/bindings/arm/vt8500.yaml
new file mode 100644
index 000000000000..7b25b6fa34e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/vt8500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA/Wondermedia VT8500 Platforms Device Tree Bindings
+
+maintainers:
+  - Tony Prisk <linux@prisktech.co.nz>
+description: test
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - via,vt8500
+          - wm,wm8505
+          - wm,wm8650
+          - wm,wm8750
+          - wm,wm8850
-- 
2.19.1

