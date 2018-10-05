Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B8C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006C22147C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006C22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeJEX64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36877 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbeJEX6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so10956810oib.4;
        Fri, 05 Oct 2018 09:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MLkB6QDD+qMQPlNXzKBuD+GOXCxeFHPrO581g6RS5g=;
        b=hg/8RSNTUjptVBqLxEYZSeGTQguZtWJXIaIV5sfzsDsthZjXwie73Cyrp0hKw7LgWq
         6uzatBm55Hvx00NRX7h11q/8M9LZtnNhvZGlRzAXWisxhuSRMfYEljPEkHZTbreT+KV7
         L3cU+PGh09BUkAs0joKSOhDaZDrmjt6Fu8jhEEJJoyQKJ5Zy9FjwmzTlDX9ycRhAG+mn
         68x2RN35pcR48UHnoAi91zp5gBKrjUXPYr4r3nPxU2g6OuGzSEJvTS5FMtcFQfPpqbU4
         TymVbAicoko2kmgd+zQg2IQy2VcP+37cU0cRREp8ijPagByfPx6esMHuFBpclHmWCtgX
         r5gA==
X-Gm-Message-State: ABuFfoglJq5j5/NBcu9GQi4N8gv0FmwCFbJA9JpX64wF24s5GgqksX/z
        zGZRoZpbk7nS0GrTNjHpDWbAz0b35Q==
X-Google-Smtp-Source: ACcGV629LouluxdgNS1LuFqu8Y3xcImnmDk/ruWOeXsYCEKkGLnz6m3/CszIzQIdlqqh8Mdm9KdVYQ==
X-Received: by 2002:aca:f4c2:: with SMTP id s185-v6mr5857040oih.245.1538758759126;
        Fri, 05 Oct 2018 09:59:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 20/36] dt-bindings: arm: Convert Calxeda board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:32 -0500
Message-Id: <20181005165848.3474-21-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
index 000000000000..bc5c69926c6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/calxeda.yaml#
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
2.17.1

