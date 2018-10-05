Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E840C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E92B208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E92B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbeJEX7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36992 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbeJEX7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id o13-v6so13351231otl.4;
        Fri, 05 Oct 2018 09:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E0eCUxfOwBpipo7Bw/JN/xoyxB44uKaqnXkAgBBbYjI=;
        b=E9lYNO0xVTKnYGNG4vJdvL7B8RSNUN+dOsq+wcV1OhTXYmwEk2cy4xy/40v2uOK26U
         9ahpZqFw07yw9eEHF65OvulGpAoWxEC0OKq8b7DK7UEVT++yRIeyL3ylviUPcatZES8J
         G6la/RBXOiZIsvgPbsJGKGu8v5qBdpvpCCBJbu1KY5obqraBeamk9Ooku/JrmJfm8DL2
         y5mDE2I097it79sjZGYREz1FIx0eSwB6EcyQO9Q53iEHqY/rIfpU4vSRGtCpbDf6Xgn0
         iAFj+Z18In12rZWj49EQ4mXx/ccwbc7OvufVVLQtLTxBrG2kD++eOdkYbSf8qIV94AFV
         Nznw==
X-Gm-Message-State: ABuFfogIWyUm0TDwYI6AJAzRAryJGkrQfEmE2P+EudXN3mMVKHhSyukw
        N/RY/xiY/SjW6ruWEgc43PsTYUXlJg==
X-Google-Smtp-Source: ACcGV63GhuQKbXKe8PjXYhKLenBZA/xlMg2ZGfN2sJ6ULc6jIqbI06Ym0vHif9gRlDyBO+hgkuu5qA==
X-Received: by 2002:a9d:3e54:: with SMTP id h20mr6321692otg.184.1538758773772;
        Fri, 05 Oct 2018 09:59:33 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:33 -0700 (PDT)
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
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Subject: [PATCH 31/36] dt-bindings: arm: Convert SPEAr board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:43 -0500
Message-Id: <20181005165848.3474-32-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SPEAr SoC bindings to DT schema format using json-schema.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/spear.txt         | 26 -------------------
 .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
 2 files changed, 25 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
deleted file mode 100644
index 0d42949df6c2..000000000000
--- a/Documentation/devicetree/bindings/arm/spear.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-ST SPEAr Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the ST SPEAr600 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear600";
-
-Boards with the ST SPEAr300 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear300";
-
-Boards with the ST SPEAr310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear310";
-
-Boards with the ST SPEAr320 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear320";
-
-Boards with the ST SPEAr1310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1310";
-
-Boards with the ST SPEAr1340 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1340";
diff --git a/Documentation/devicetree/bindings/arm/spear.yaml b/Documentation/devicetree/bindings/arm/spear.yaml
new file mode 100644
index 000000000000..6ce8ef979390
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/spear.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SPEAr Platforms Device Tree Bindings
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+  - Stefan Roese <sr@denx.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - st,spear600
+          - st,spear300
+          - st,spear310
+          - st,spear320
+          - st,spear1310
+          - st,spear1340
+...
-- 
2.17.1

