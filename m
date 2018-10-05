Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE51F2147D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE51F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeJEX7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37001 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeJEX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id o13-v6so13351422otl.4;
        Fri, 05 Oct 2018 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NPLYmq8r2xM4JEKhhNKIpjB9p0qLt//yMuDdja+hyKo=;
        b=YOL4QAkHe5Y/RTEZ8z6kaP42IP8Pz8HYENV6hdQmN78qKJeIBVffyihPTZ09qdZFR6
         0m/Aijql/+2gfBlYKA3eodD1ECBpsso9AaC2xYnZFB1CSdoc0JTn9w61EmvWIRA+jr7R
         i7v/2zPGS24JrwGIu1B7KbJKs9wneFDAD+Ldtfq1c/Nnid+v6vEOQ9x7RlvPKeG29tpY
         GXt71IsfU4sOMVP3a4o6W7SI5xM7y67wRdiDjQKYIH+vmUm2Jg/KIaIeLC+LSR3ejZuJ
         ic2KiWf/ymYEsu+M9ShlvToh06DToeY64Fgt1eaAsSjcUeSMI1c0TbanLN0fW3rkALCl
         MsNw==
X-Gm-Message-State: ABuFfojA5UqW3BAmfyB7QQWYSkKWmi7pdv8pNzMMyoNN6BdbJU/1+3fa
        Aq25MdpF+2k2IHX9nyaB6O7YQkslQQ==
X-Google-Smtp-Source: ACcGV634LJ88gCnQYGc/cHlogepMmHh7tZduArLt+mli5CisxRoQe4LWBWYOkTZQnrNGVRXyRtB6nA==
X-Received: by 2002:a9d:538c:: with SMTP id w12mr1624159otg.139.1538758777856;
        Fri, 05 Oct 2018 09:59:37 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:37 -0700 (PDT)
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
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH 34/36] dt-bindings: arm: Convert VIA board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:46 -0500
Message-Id: <20181005165848.3474-35-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
index 000000000000..6e07775b160f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/vt8500.yaml#
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
2.17.1

