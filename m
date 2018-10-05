Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F876C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017DF214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017DF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeJEX6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38551 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbeJEX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so28926otj.5;
        Fri, 05 Oct 2018 09:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OlNXSrgQVk4KWBLGVdUP3P75RriHc27c3ag6VlOGG+E=;
        b=S5rly4akOTXqpBWpHmibVaS2OeZiE/8BZJo1YTkhm6wwePplmNaKTMijNMur5ZyKPb
         4GSLP0DQBaHsLCDoxH3lqu9j0UEuYQ3SAMMQW4Bd7ClhLOgZM4nBo51z+qkDDsR6OzEX
         +4DT3ZCybNj+v2/us5jAay/Mb3pnOziM0LV3rAJv6FwoDtxXB7dE57SokC1LZRo+zY/d
         hbtwhvM5BlR8DPtSQ33XDQq51hlJvZsbUQZMDBFxcLA/cSAg71OVpIxPzvsni9bWf8/A
         L5N39I/dhojFs/fyauMRl3ObzMhh3c2NcffrekDxFy2I+xfRZzpeS3VCK+Ylo1waTSAI
         LyWg==
X-Gm-Message-State: ABuFfoi82ukE6qKMuUPWUNSNXXVpdFZ+LNTTnx0N+YPDQpEBAPvj5fPZ
        juk769qCHtMFl94ZoV23WTO+suNMhA==
X-Google-Smtp-Source: ACcGV60n79/HNJX/EEj0rfwdyJNxIcfyWNN9Ix/fcSf/Nkn3tJSBKa9rN2uBiVO0IYH8lG+CETwG7Q==
X-Received: by 2002:a9d:48b9:: with SMTP id d54mr6766139otf.144.1538758738565;
        Fri, 05 Oct 2018 09:58:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:58:58 -0700 (PDT)
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
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 06/36] dt-bindings: arm: zte: Move sysctrl bindings to their own doc
Date:   Fri,  5 Oct 2018 11:58:18 -0500
Message-Id: <20181005165848.3474-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/zte-sysctrl.txt   | 30 +++++++++++++++++++
 Documentation/devicetree/bindings/arm/zte.txt | 27 +----------------
 2 files changed, 31 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zte-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/zte-sysctrl.txt b/Documentation/devicetree/bindings/arm/zte-sysctrl.txt
new file mode 100644
index 000000000000..7e66b7f7ba96
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte-sysctrl.txt
@@ -0,0 +1,30 @@
+ZTE sysctrl Registers
+
+Registers for 'zte,zx296702' SoC:
+
+System management required properties:
+      - compatible = "zte,sysctrl"
+
+Low power management required properties:
+      - compatible = "zte,zx296702-pcu"
+
+Bus matrix required properties:
+      - compatible = "zte,zx-bus-matrix"
+
+
+Registers for 'zte,zx296718' SoC:
+
+System management required properties:
+      - compatible = "zte,zx296718-aon-sysctrl"
+      - compatible = "zte,zx296718-sysctrl"
+
+Example:
+aon_sysctrl: aon-sysctrl@116000 {
+	compatible = "zte,zx296718-aon-sysctrl", "syscon";
+	reg = <0x116000 0x1000>;
+};
+
+sysctrl: sysctrl@1463000 {
+	compatible = "zte,zx296718-sysctrl", "syscon";
+	reg = <0x1463000 0x1000>;
+};
diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
index 83369785d29c..340612794a37 100644
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -1,20 +1,10 @@
 ZTE platforms device tree bindings
----------------------------------------
 
+---------------------------------------
 -  ZX296702 board:
     Required root node properties:
       - compatible = "zte,zx296702-ad1", "zte,zx296702"
 
-System management required properties:
-      - compatible = "zte,sysctrl"
-
-Low power management required properties:
-      - compatible = "zte,zx296702-pcu"
-
-Bus matrix required properties:
-      - compatible = "zte,zx-bus-matrix"
-
-
 ---------------------------------------
 -  ZX296718 SoC:
     Required root node properties:
@@ -22,18 +12,3 @@ Bus matrix required properties:
 
 ZX296718 EVB board:
       - "zte,zx296718-evb"
-
-System management required properties:
-      - compatible = "zte,zx296718-aon-sysctrl"
-      - compatible = "zte,zx296718-sysctrl"
-
-Example:
-aon_sysctrl: aon-sysctrl@116000 {
-	compatible = "zte,zx296718-aon-sysctrl", "syscon";
-	reg = <0x116000 0x1000>;
-};
-
-sysctrl: sysctrl@1463000 {
-	compatible = "zte,zx296718-sysctrl", "syscon";
-	reg = <0x1463000 0x1000>;
-};
-- 
2.17.1

