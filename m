Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B162098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B162098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeJEX7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:59:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45350 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbeJEX7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:59:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id u22so13321507ota.12;
        Fri, 05 Oct 2018 09:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3VPklCipOuWldUvPpbh0zr7j2Wj5BAxPOt4Q1LfEFxc=;
        b=d12UDYbF4coJEYvH35b/XEEHeKtZVgcav1+EKG1Zjpccpf9mjWw5VKcoj/Bx/zKRQ8
         KOU0s4e7A3YNvLsVvct/K4M7KKtZGKw6MJ/mrWiuClWqpKrvzcIRPZ48mgQXRKfbf/NS
         xh/KRHHwyWdeAhO6XY++IG6Oe1KBl4bcbzT0JaDjk68LrLJA/RFMoDNo65I+6YwccoIs
         lk8Weisa8IuXFYdV48E44JMzUIjaSDrjVXrv2JlkxLMYZbivtUEGpME0chYTb7a7tj0L
         XNP66B1CXHVZ/RJMgZpHVUmiXraJhHvkWp6HcUusEe831g6GCAQOqQ1P8z+3S0kjV45Q
         Ncdw==
X-Gm-Message-State: ABuFfoi3SYMD3uT8gWcHV1+TRIaNhQ+y6ZXPhKtO2+Aev4SGcuFRmTXY
        dDNxa8RB3U7UjKkM+RxUj0zRDXztvQ==
X-Google-Smtp-Source: ACcGV60TI+AtgrXrtCPu1O5XvTYk1/FiY3Liow99t7CKrJSaCRqZPsBcMU4bMWIJmc4w6xOU7yZqdA==
X-Received: by 2002:a9d:f2:: with SMTP id 47mr7503473otk.43.1538758775042;
        Fri, 05 Oct 2018 09:59:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:59:34 -0700 (PDT)
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
        Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 32/36] dt-bindings: arm: Convert ST STi board/soc bindings to json-schema
Date:   Fri,  5 Oct 2018 11:58:44 -0500
Message-Id: <20181005165848.3474-33-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
index 000000000000..10814334cfc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sti.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/sti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST STi Platforms Device Tree Bindings
+
+maintainers:
+  - Maxime Coquelin <maxime.coquelin@st.com>
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
2.17.1

