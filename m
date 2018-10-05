Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA224C65BAB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927F12148C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927F12148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeJEX61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39916 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeJEX60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id c20-v6so13345479otl.6;
        Fri, 05 Oct 2018 09:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71oY5HWjvjta+vASdeqnC6CknPvTEuU3/FDPawmJ7HI=;
        b=tUaLnFrZb5US74nXKpOrVjuq/Jy0brkhvUVAP5J5ZUi4HUzLd/G7coRUAPbDZzXMRk
         Zri7Infk6u2Bbg3tCO+CS3eXRP0/SfjROF4eEctE5S8aD6HVfc9j5XaJisV/dA2DdB1d
         Gr8lc674xUbUum6ib9IeOmGW+SGyyYjjHbf3vxeOhvifWteujCeDUgxHYfm2xEHZDoi9
         T6xvPDnevS7IFAXv08gPTkcoEgd0RAk5KVaqCAj56aYPEUjc8PdtMCzmvt8NSXYrc0va
         IItC57j2s653tIyUbsg5sRcwACcbD0JwC2AK7JBXV1mVtnWO+sXMnGNdptxW5C5TbAO3
         youA==
X-Gm-Message-State: ABuFfohCcm+II5l/qXCjMgGRNS93A42ymOa8jBNqBlvKX7WlchDnEcpx
        N7RriHaJhWqgOlxD9XnZTU5VDMpSbQ==
X-Google-Smtp-Source: ACcGV6309J0wcTnWnYW9xumd4jiVdJLzbRTItcct9QsNLZtgsD8SvKo6hrlq3RTPwwyyN1C8vgGH4g==
X-Received: by 2002:a9d:2992:: with SMTP id n18mr661801otb.54.1538758731588;
        Fri, 05 Oct 2018 09:58:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:58:51 -0700 (PDT)
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
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 01/36] dt-bindings: arm: alpine: Move CPU control related binding to cpu-enable-method/al,alpine-smp
Date:   Fri,  5 Oct 2018 11:58:13 -0500
Message-Id: <20181005165848.3474-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is best practice to have 1 binding per file, so board level bindings
should be separate for various misc SoC bindings. Move the Alpine CPU
control to al,alpine-smp and we can also remove a cross reference.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 72 -------------------
 .../arm/cpu-enable-method/al,alpine-smp       | 34 ++++++++-
 2 files changed, 31 insertions(+), 75 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
index f404a4f9b165..d00debe2e86f 100644
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ b/Documentation/devicetree/bindings/arm/al,alpine.txt
@@ -14,75 +14,3 @@ compatible: must contain "al,alpine"
 
 	...
 }
-
-* CPU node:
-
-The Alpine platform includes cortex-a15 cores.
-enable-method: must be "al,alpine-smp" to allow smp  [1]
-
-Example:
-
-cpus {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	enable-method = "al,alpine-smp";
-
-	cpu@0 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <0>;
-	};
-
-	cpu@1 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <1>;
-	};
-
-	cpu@2 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <2>;
-	};
-
-	cpu@3 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <3>;
-	};
-};
-
-
-* Alpine CPU resume registers
-
-The CPU resume register are used to define required resume address after
-reset.
-
-Properties:
-- compatible : Should contain "al,alpine-cpu-resume".
-- reg : Offset and length of the register set for the device
-
-Example:
-
-cpu_resume {
-	compatible = "al,alpine-cpu-resume";
-	reg = <0xfbff5ed0 0x30>;
-};
-
-* Alpine System-Fabric Service Registers
-
-The System-Fabric Service Registers allow various operation on CPU and
-system fabric, like powering CPUs off.
-
-Properties:
-- compatible : Should contain "al,alpine-sysfabric-service" and "syscon".
-- reg : Offset and length of the register set for the device
-
-Example:
-
-nb_service {
-        compatible = "al,alpine-sysfabric-service", "syscon";
-        reg = <0xfb070000 0x10000>;
-};
-
-[1] arm/cpu-enable-method/al,alpine-smp
diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
index c2e0cc5e4cfd..35e5afb6d9ad 100644
--- a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
@@ -14,7 +14,28 @@ Related properties:	(none)
 
 Note:
 This enable method requires valid nodes compatible with
-"al,alpine-cpu-resume" and "al,alpine-nb-service"[1].
+"al,alpine-cpu-resume" and "al,alpine-nb-service".
+
+
+* Alpine CPU resume registers
+
+The CPU resume register are used to define required resume address after
+reset.
+
+Properties:
+- compatible : Should contain "al,alpine-cpu-resume".
+- reg : Offset and length of the register set for the device
+
+
+* Alpine System-Fabric Service Registers
+
+The System-Fabric Service Registers allow various operation on CPU and
+system fabric, like powering CPUs off.
+
+Properties:
+- compatible : Should contain "al,alpine-sysfabric-service" and "syscon".
+- reg : Offset and length of the register set for the device
+
 
 Example:
 
@@ -48,5 +69,12 @@ cpus {
 	};
 };
 
---
-[1] arm/al,alpine.txt
+cpu_resume {
+	compatible = "al,alpine-cpu-resume";
+	reg = <0xfbff5ed0 0x30>;
+};
+
+nb_service {
+        compatible = "al,alpine-sysfabric-service", "syscon";
+        reg = <0xfb070000 0x10000>;
+};
-- 
2.17.1

