Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5859C65BAB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41212098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41212098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeJEX7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36975 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbeJEX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id o13-v6so13350876otl.4;
        Fri, 05 Oct 2018 09:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOcP7SKttVPj8DIgwnpgktISVP3hKyMV9PP4Ts7Q0SY=;
        b=H89WgkuaO1ALxX8QjhfVHsa9vFy3A/YTlVQlloqvH8WnTmdoc+tfmPEfaUtcvNBFq0
         Sgs+/Ix0UwGn0N3lU+ss1Ue6va3dm/VIPH2Z3byYzMKLbxjKvPvNOC6D5RSeiZvsdZAS
         GWXNjdx0fQy7y3ZaooQEIEd00M2UJRcMlN6eU8hsirShw1dy2julTBGEUpwadIo1UaK5
         jG0DIieIMgMiKrJuVTGsbbmlnri31gFdWlhMTTvKSr13SSgkE7lBPupmqx1/v0C4ThkM
         +LdvCYXwNI/rUzhd3mPSFD7NeGFqrX5ODWYeKFMGdmudjmcvj5iNoy7Oi6J4uo6gucOL
         2EmQ==
X-Gm-Message-State: ABuFfoj42jmAK6u+pC8lsAMT9Lu7jloniSroxvtfi0E0KJb30US/+sq6
        EKc7yzZxZ3qvaHebwu0IC9ZVKKxNEA==
X-Google-Smtp-Source: ACcGV61IA8cpWwDpWkKLrO0qxl/0iEZNICtaEWbvZ7Ure+YS4a+2pnF0oFJ57Fsy1lfFc7upccIk2A==
X-Received: by 2002:a9d:3cd0:: with SMTP id t16mr7184592otf.158.1538758765884;
        Fri, 05 Oct 2018 09:59:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:25 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io
Subject: [PATCH 25/36] dt-bindings: arm: Convert Oxford Semi board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:37 -0500
Message-Id: <20181005165848.3474-26-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Oxford Semi SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-oxnas@groups.io
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
 .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)
diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
new file mode 100644
index 000000000000..c847a5707417
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/oxnas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+            - wd,mbwe
+        - const: oxsemi,ox810se
+
+      - items:
+        - enum:
+            - cloudengines,pogoplugv3
+        - const: oxsemi,ox820
-- 
2.17.1

