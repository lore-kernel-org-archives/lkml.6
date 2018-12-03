Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44993C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12868215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12868215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeLCVdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45022 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLCVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so12331657oig.11;
        Mon, 03 Dec 2018 13:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1DZ7qanLgT6TNvZv+UGgnb7e+rg6Vx6EWDRxaGp6rc=;
        b=XJyokh6UyO3Z7H3zIL5JJPETVQv72y8E6dMhtVmASwHoGy57HeMn9P3PnCHkPoH789
         Gq3K3zM2IEnF2mtBNUfwXjiPFzmPuMeEi8DepkslbpP7xycPms2f7t+r7a+xp5cDhapZ
         c030bjL5w39QCuHH25kFrcUS5a+RspXWQG3Y9jrMDyLWhG0jTPy5qwuveazV2w11Ceqr
         43+Cec15WjFZdpgcEueZk8tC4b7yojYASFzU+IRZ8m41Tg7nkA8IvjlpRI3H4DiJrD1q
         vpAdWF0xBNq19utBjTPhzj+uA74HWTZKUv5Mj3AGjkUTtW2dUmakldy4ol7HitPx3Szc
         meHw==
X-Gm-Message-State: AA+aEWbwbXEW9QYDzPAZNyBZtUx80rX8iS9D4n6ZMVb6YVlrbajTnASs
        uKHiwqfS0UOwKUcW15xtITrxlDw=
X-Google-Smtp-Source: AFSGD/VXUJP/+4/TsKC9atq6RJWaovkxUtpJGDI/LJRj2Z98TIHCTl1R/TP0ERzJIps1ROa6KSijxA==
X-Received: by 2002:aca:d00a:: with SMTP id h10mr10413699oig.316.1543872778504;
        Mon, 03 Dec 2018 13:32:58 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:57 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH v2 27/34] dt-bindings: arm: Convert CSR SiRF board/soc bindings to json-schema
Date:   Mon,  3 Dec 2018 15:32:16 -0600
Message-Id: <20181203213223.16986-28-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert CSR SiRF SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/sirf.txt          | 11 --------
 .../devicetree/bindings/arm/sirf.yaml         | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.yaml

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
deleted file mode 100644
index 7b28ee6fee91..000000000000
--- a/Documentation/devicetree/bindings/arm/sirf.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-CSR SiRFprimaII and SiRFmarco device tree bindings.
-========================================
-
-Required root node properties:
-    - compatible:
-    - "sirf,atlas6-cb" : atlas6 "cb" evaluation board
-    - "sirf,atlas6" : atlas6 device based board
-    - "sirf,atlas7-cb" : atlas7 "cb" evaluation board
-    - "sirf,atlas7" : atlas7 device based board
-    - "sirf,prima2-cb" : prima2 "cb" evaluation board
-    - "sirf,prima2" : prima2 device based board
diff --git a/Documentation/devicetree/bindings/arm/sirf.yaml b/Documentation/devicetree/bindings/arm/sirf.yaml
new file mode 100644
index 000000000000..0b597032c923
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sirf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CSR SiRFprimaII and SiRFmarco device tree bindings.
+
+maintainers:
+  - Binghua Duan <binghua.duan@csr.com>
+  - Barry Song <Baohua.Song@csr.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: sirf,atlas6-cb
+          - const: sirf,atlas6
+      - items:
+          - const: sirf,atlas7-cb
+          - const: sirf,atlas7
+      - items:
+          - const: sirf,prima2-cb
+          - const: sirf,prima2
+...
-- 
2.19.1

