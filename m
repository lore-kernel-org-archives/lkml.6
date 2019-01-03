Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E87220883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="beqjtfXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfACIzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:55:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40690 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbfACIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:55:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so16393691pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 00:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RArOkgJ6iozCqW4Amczd+Jty4/unLLqgawp7H0t8Irg=;
        b=beqjtfXvVp4z+It6JjvR6dpmy/72aZvQHGM5NQy9CSeUeyiRUgKUEeRHsfqVHkcRaN
         h5yIkI1bqHdjB6LPtZ1Ts6Peo55ysnEfYSYkkp8wuu7+KuyM2Yjw+ATQG2dYh+OihgPx
         98Ob5hN93th27yOPBWgkdwwBy4nAfuLuR4j6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RArOkgJ6iozCqW4Amczd+Jty4/unLLqgawp7H0t8Irg=;
        b=IvPaBQmQhLBR4IFNt9KpL6HLnDMzNfPHHJPiYo31exii5GAyzz78FnNyRpob95NX9v
         Bapo6cSxHMIDYwKPHV+WwfBjDbDXeDeO3YTspDCHSRKkUWxSA7wec9ffyddUy0cHUwpr
         PfaH0yU2+ccEPtNMH3NS0wkuXlLwOiQyqADWvJZp5x1zFCdiOlr/T7Dr+OBsGzXsjP9/
         sPpTWHMtzlsaQ9agLTFtf4YDbnfEqNbswA+fmLMbT9v664ULyIIZ7A4bH2FANqliyGDY
         0ai99M58zoAnfbI1pgFNjenkRUWHinOcVCJnjbIdlbz9H1nMygCJkDGTIUMSDg5oHGti
         hLUQ==
X-Gm-Message-State: AJcUukej47728mC7P7IAtiYxtTyRRdBAOJmbBSHfN9t0npaA6bfkYAPK
        Yy50GpiHF0+BunGa7jsoRYm+Ng==
X-Google-Smtp-Source: ALg8bN5Fbvwz8sFztmvDWCNW6Tfk7/sHytMJbnk5cX9744oVPBgQyAtW3K+ck3DoQNaQKKG58OIfjA==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr16219443pgt.260.1546505752418;
        Thu, 03 Jan 2019 00:55:52 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s190sm78189727pfb.103.2019.01.03.00.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 00:55:51 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 1/3] dt-bindings: thermal: Add binding document for SR thermal
Date:   Thu,  3 Jan 2019 14:25:32 +0530
Message-Id: <1546505734-24527-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add binding document for supported thermal implementation
in Stingray.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
new file mode 100644
index 0000000..3ab3302
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
@@ -0,0 +1,105 @@
+* Broadcom Stingray Thermal
+
+This binding describes thermal sensors that is part of Stingray SoCs.
+
+Required properties:
+- compatible : Must be "brcm,sr-thermal"
+- reg : Memory where tmon data will be available.
+- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
+                  Each bit represents single TMON source.
+- #thermal-sensor-cells : Thermal sensor phandler
+- polling-delay: Max number of milliseconds to wait between polls.
+- thermal-sensors: A list of thermal sensor phandles and specifier.
+                   specifier value is tmon ID and it should be
+                   in correspond with brcm,tmon-mask.
+- temperature: trip temperature threshold in millicelsius.
+
+Example:
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x8f100000 0x100>;
+
+		tmon: tmon@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x0 0x40>;
+			brcm,tmon-mask = <0x3f>;
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		ihost0_thermal: ihost0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 0>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		ihost1_thermal: ihost1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 1>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		ihost2_thermal: ihost2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 2>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		ihost3_thermal: ihost3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 3>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		crmu_thermal: crmu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 4>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		nitro_thermal: nitro-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 5>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
-- 
2.7.4

