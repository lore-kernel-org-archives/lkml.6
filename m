Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D644C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C64A20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLCVct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37571 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeLCVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so12373326oia.4;
        Mon, 03 Dec 2018 13:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWELqPwXjCqkhQiWQTIVxmpoPf+1qSnx8/GOPVWjztw=;
        b=TtzjmSo2A5cjNon1r0g+lmBFv7fAYKmyX3I9e4iPT7KEUMwWtqQ6z4VhNXKHbUbTyx
         X2HSaJfxriqbdlwf3aV4nr2wPVhyEUrErXWio2HDkwUK67RHiYDkPUivjlkXPblLCLbK
         ICqGY+ah+uJWUKayhPPPuRIkwxL0Diu83BsD4tj2OO1b8mFLivDwzvnRRzWePCxK9eQM
         /i8FeGQ9tONpkUZkQMVh1ySJYcxeiLMnb0eTV+wHdyvK9xoj7B0+5AmDh0s3LtA/LBFs
         QrIkz/Z0yaz9uhc6EVAY063q/vdRFrw+A6rjHCpfyOFG25FG0zv5qeqbP9H4C4HiGTyl
         l8dQ==
X-Gm-Message-State: AA+aEWZou+Er9oCYmGwR9k+u2kphpncXqZFuMESdxhEqTB/J0ohWOwTl
        2qQCo96XJD6opHdwEn+/1ap+qhs=
X-Google-Smtp-Source: AFSGD/Xw0J/aF8gf6B59Zok0SLOSeIwBWjs7aOXS4v3+j1aMd8Qau4+dAhIQFP+IbvJRjTsf/9zUiw==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr8197663oic.233.1543872765086;
        Mon, 03 Dec 2018 13:32:45 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:44 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 16/34] dt-bindings: arm: Convert Calxeda board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:05 -0600
Message-Id: <20181203213223.16986-17-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Calxeda SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/calxeda.txt       | 15 -------------
 .../devicetree/bindings/arm/calxeda.yaml      | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml

diff --git a/Documentation/devicetree/bindings/arm/calxeda.txt b/Documentation/devicetree/bindings/arm/calxeda.txt
deleted file mode 100644
index 25fcf96795ca..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Calxeda Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC shall have the
-following properties.
-
-Required root node properties:
-    - compatible = "calxeda,highbank";
-
-
-Boards with Calxeda Cortex-A15 based ECX-2000 SOC shall have the following
-properties.
-
-Required root node properties:
-    - compatible = "calxeda,ecx-2000";
diff --git a/Documentation/devicetree/bindings/arm/calxeda.yaml b/Documentation/devicetree/bindings/arm/calxeda.yaml
new file mode 100644
index 000000000000..aa5571d23c39
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/calxeda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Platforms Device Tree Bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+description: |+
+  Bindings for boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC
+  or Cortex-A15 based ECX-2000 SOCs
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - calxeda,highbank
+          - calxeda,ecx-2000
-- 
2.19.1

