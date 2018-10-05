Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FE721477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FE721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeJEX62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42893 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbeJEX62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so13359764otl.9;
        Fri, 05 Oct 2018 09:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nWJ/W+jar+UdXjg1HaxmR9q3z8+XxFV2Te6InmR2rr4=;
        b=d44uhtnv3WJRolJCk5WkGnfLR8+RItiUlq62aVLgCGODzfkyKooPQrKqLl4kxYjr/S
         yeULEgxfdULuSp8yz4WFmOal5cWzSeKZaiKTpLzZYxOPtBhH5cx+qe7CSzzsnZlVfrwn
         ku3F0VxOemJdvHutIDVZJXPUs0723HPp5mwdY1qnJLxVVS1gXsyEv+IffR2YFWNcT1Kd
         haOObEyAuibc/8F407eE3DM8Xq8D8t4+Kw8sKpoPIi899xjygm9rtqcDubiDDKQp4FE5
         GzYN/vBhfE+OvIIDoF14b+BtLIp6DzcrnOP5OAfqnMq9CvaREtXKR8aMDv7OfpquijVo
         J5aA==
X-Gm-Message-State: ABuFfogyJW4Xg6i56ud6nra5uoo06M/jyWgbWtor/cb7z41Of4DfjyM3
        yvhkEatXzDqrIj+vGtoClngYerK2JQ==
X-Google-Smtp-Source: ACcGV60lHex6VH59xUBqeaWpiCR5GUCzV7Jfb0gC6BzRfdvaYewShZLZJcerAuZH8nrmMaEEH60rTA==
X-Received: by 2002:a9d:76d:: with SMTP id 100mr7220736ote.153.1538758733044;
        Fri, 05 Oct 2018 09:58:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:58:52 -0700 (PDT)
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
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 02/36] dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding to its own file
Date:   Fri,  5 Oct 2018 11:58:14 -0500
Message-Id: <20181005165848.3474-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is best practice to have 1 binding per file, so board level bindings
should be separate for various misc SoC bindings.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
 .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
 2 files changed, 28 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index b5c2b5c35766..2f2d01a00c54 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -100,32 +100,3 @@ Board compatible values (alphabetically, grouped by SoC):
   - "tronsmart,vega-s96" (Meson gxm s912)
 
   - "amlogic,s400" (Meson axg a113d)
-
-Amlogic Meson Firmware registers Interface
-------------------------------------------
-
-The Meson SoCs have a register bank with status and data shared with the
-secure firmware.
-
-Required properties:
- - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
-
-Properties should indentify components of this register interface :
-
-Meson GX SoC Information
-------------------------
-A firmware register encodes the SoC type, package and revision information on
-the Meson GX SoCs.
-If present, the following property should be added :
-
-Optional properties:
-  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
-
-Example
--------
-
-ao-secure@140 {
-	compatible = "amlogic,meson-gx-ao-secure", "syscon";
-	reg = <0x0 0x140 0x0 0x140>;
-	amlogic,has-chip-id;
-};
diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
new file mode 100644
index 000000000000..c67d9f48fb91
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
@@ -0,0 +1,28 @@
+Amlogic Meson Firmware registers Interface
+------------------------------------------
+
+The Meson SoCs have a register bank with status and data shared with the
+secure firmware.
+
+Required properties:
+ - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
+
+Properties should indentify components of this register interface :
+
+Meson GX SoC Information
+------------------------
+A firmware register encodes the SoC type, package and revision information on
+the Meson GX SoCs.
+If present, the following property should be added :
+
+Optional properties:
+  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
+
+Example
+-------
+
+ao-secure@140 {
+	compatible = "amlogic,meson-gx-ao-secure", "syscon";
+	reg = <0x0 0x140 0x0 0x140>;
+	amlogic,has-chip-id;
+};
-- 
2.17.1

