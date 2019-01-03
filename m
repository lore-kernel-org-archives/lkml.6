Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB80C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F620883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LIJdsVzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfACI4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:56:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbfACI4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:56:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so15717836pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 00:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZ2W19+rOYu3Y/tMXOuNYWgMFRt3+zm/oa2zUyjqgVE=;
        b=LIJdsVzcy32F0XTyRFCtIY0QFpFHl10cEQdnc2e0/kF33sgDrgM/FedZvRwXHy2bUQ
         oPpsg6c1aWRaxexn/MPAfn/zrIGUloTNXHYEgM3B/RpwTP89jQUNJpAXXMqcadMIj7pa
         AmUE2Qvsha03aG2CN4zrfoJb6xAzGxo0fSgxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZ2W19+rOYu3Y/tMXOuNYWgMFRt3+zm/oa2zUyjqgVE=;
        b=MQt6WaafPNy2NMsR8lamVHcrw4P1xWULxf8ua6WoXElefLIL/Ukx85NqS8XWyEA0xU
         MoReWv1AcLTEmwxY8le1sTWo+Pvp1Bp+GaL/RXu46Uh0rUWV3E2f9bLqBqqt0TJKAM5f
         a4AaWt4eKI61efOnSxMMR+KIT9+TBE3FM1v+T3GGIwMih9N/yUVr1NnZPxslOCFwWPfL
         PRCpIPDsBizj2r2/8PrS31aS1Lej7AvWfoUNXU89/F7GlPfe59nXdwr3AANbshJBZT66
         J1E+BsU8CX8obHMuNmet8KQmeEcrPHi2ee6kvxG8dCwakYB7op0XIIfk0RmI7bLC/AEF
         x52A==
X-Gm-Message-State: AJcUukesIzUgVRzMF8jnA+FDldQ9DzOyISlXy9DQFpuR7nS+IFz+NBVM
        YN/IH8MxjM0e0NwBL92tR/+SRA==
X-Google-Smtp-Source: ALg8bN7dulh4nCt7A0PaUMXjT8p04hcyqzLR9BS8C+//p3Qt7WS2knvHWYMjmvvp45rf+rA95GnzOg==
X-Received: by 2002:a63:9306:: with SMTP id b6mr15622487pge.36.1546505759360;
        Thu, 03 Jan 2019 00:55:59 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s190sm78189727pfb.103.2019.01.03.00.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 00:55:58 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 3/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date:   Thu,  3 Jan 2019 14:25:34 +0530
Message-Id: <1546505734-24527-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add DT nodes for thermal zones memory base address
to read temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa85..4fd06ed 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,93 @@
 			status = "disabled";
 		};
 	};
+
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
 };
-- 
2.7.4

