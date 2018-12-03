Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5405320864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeLCVfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:35:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39814 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLCVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so12348243oia.6;
        Mon, 03 Dec 2018 13:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ekJXPkH8vDQKH6Ka6Zw4d6P9Suv20xxzhFNrwmwfqI=;
        b=WTVDaVYwFUYCSerKC1BdM2l6Mee0ZBzedLJcdi15fOdaCRJbh6K0+l6T5fnctjebYB
         8GFuWjUmOfF2p4NwobIYwElHyYqxIMvF7o//rllSfY2rMkolTeQ0d/rl7095X8s89l4f
         RqGEkzDrC8/EIQKGNIrMLsJ9iVB1AF1e6MGXpIUrz6ZHiH6+iRA0mATGYI8BfewVvLaP
         HGWFBm/OjgavRZlgtc1+3IMi3c2WDSMWEanpCdkJcJazYTHkQBRSJqSrSQM/MLBNksyo
         LWXQ9oHOFTV+Ko0ckxRwoBmutBnsojVje7YotBRwXw7zfxsTU6jxCOzlqAWUXxeBfMym
         kllg==
X-Gm-Message-State: AA+aEWZMAo2x0GyUog6G6/x1P1tLM8Ub4FUXmq/y70S+hfS8VshwIEpu
        VRNceC3jEDXzI6O7CeOGKLumrIY=
X-Google-Smtp-Source: AFSGD/VGqOggC/Ka1IFU2DFVSWF9kf0xVvODZsOQESAjd7vG+XHk/5PwWPdPnnsW1F/cu/6lIETVjg==
X-Received: by 2002:aca:c186:: with SMTP id r128mr11602926oif.52.1543872758963;
        Mon, 03 Dec 2018 13:32:38 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:38 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 11/34] dt-bindings: arm: Convert Alpine board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:00 -0600
Message-Id: <20181203213223.16986-12-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Alpine SoC bindings to DT schema format using json-schema.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 16 --------------
 .../devicetree/bindings/arm/al,alpine.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
deleted file mode 100644
index d00debe2e86f..000000000000
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Annapurna Labs Alpine Platform Device Tree Bindings
----------------------------------------------------------------
-
-Boards in the Alpine family shall have the following properties:
-
-* Required root node properties:
-compatible: must contain "al,alpine"
-
-* Example:
-
-/ {
-	model = "Annapurna Labs Alpine Dev Board";
-	compatible = "al,alpine";
-
-	...
-}
diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
new file mode 100644
index 000000000000..82e2fafdfece
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Annapurna Labs Alpine Platform Device Tree Bindings
+
+maintainers:
+  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: al,alpine
+  model:
+    items:
+      - const: "Annapurna Labs Alpine Dev Board"
+
+...
-- 
2.19.1

