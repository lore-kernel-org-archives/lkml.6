Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5882EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3E820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJN7EmtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3E820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504174AbeKWXCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:02:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34338 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387898AbeKWXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:02:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so10127466ede.1;
        Fri, 23 Nov 2018 04:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiJ8mgydcFLQgRIq3IKKEyTIgKLQiadTZ8mklrWjrmY=;
        b=rJN7EmtV1SvfEM4enPwsWtkcwsBRnOLFsaIw+26j2GgY5V//qCAQTQmrReX6hqNp0u
         5JnwX3u0sp0jSb1AtJAqYopVsRLV/VvyZK5WqSZN5obxn7frxM03v6eFnq0aZDMK8hUc
         uT4i/QUgGpHwEyV7j7gZuCW4Q7ZCDvfOfLkYVWq9EaSmGiU4YmX1jQ6uAkk29OPvRu14
         hZEudBRz7x3z2cDwyMxhK2AIA/QFXd0WRcobfNUilskZ320qlz2BNiloVGceuiw9C/Th
         xn+I1GuBifWgdkgSOFT6//04mDDCOuJZ+oBdJZNgqDO6kLDOzODsQ7hk97h8Cqs2aTgO
         LmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiJ8mgydcFLQgRIq3IKKEyTIgKLQiadTZ8mklrWjrmY=;
        b=tc17paB70Vm9TibCVhrInD4dl9ubns0jj3WBdSyDNXifutu2RMoECSWvrTzvPiSc/t
         m0f1Lk7fPv7cuO6dA7pxMPpxtDOLngUKCBHdsXN+ShNTjyZLKTLBUUzHuuve3qY73TGL
         ElHkJB8p4ZgzEcm43Lo7mvg5pOQOol6MWRYZVSPvzBtShAaUCqkIjjPAhOwp2WopNsvu
         yHYwNUTvw1j+LaM1pf9eFFVLOA8zBm+kuf27rPm5B3EYify9ytxR2wFyV48kp4m76TW1
         hlg6aoI0ktQC0aoSt6OKaXR6UytvmzDO9PeiJdIzML+mmTZ/VF+Ta1Pzmk1tV3p7AIyu
         15ug==
X-Gm-Message-State: AA+aEWYy/WCCWJfRTzceU+cEgUBu0Us0A0u5onEmJOqn1mhB2Csdcr9H
        Psd3NCJ/pkrPlbQB0pRHodY=
X-Google-Smtp-Source: AFSGD/VdFbOsPlP1AqdLvv+GIAS+xc/RexjBk/2YbR0ykvvR9El3sojinb+O+TpFstJ2fTgyH09d0A==
X-Received: by 2002:a50:d643:: with SMTP id c3mr1554525edj.178.1542975525202;
        Fri, 23 Nov 2018 04:18:45 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c11-v6sm6641048ejm.67.2018.11.23.04.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:18:44 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: tegra: p2972: Enable the CPU, GPU and AUX thermal zones
Date:   Fri, 23 Nov 2018 13:18:39 +0100
Message-Id: <20181123121839.18573-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123121839.18573-1-thierry.reding@gmail.com>
References: <20181123121839.18573-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Enable these thermal zones to be able to monitor their temperatures and
control the fan to cool down the system if necessary.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 91 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index cbae8e8b1281..e29f8f6117c8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -43,8 +43,97 @@
 		};
 	};
 
-	fan {
+	fan: fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm4 0 45334>;
+
+		cooling-levels = <0 64 128 255>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+	};
+
+	thermal-zones {
+		cpu {
+			polling-delay = <0>;
+			polling-delay-passive = <500>;
+			status = "okay";
+
+			trips {
+				cpu_trip_critical: critical {
+					temperature = <96500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cpu_trip_hot: hot {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_trip_active: active {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_passive: passive {
+					temperature = <30000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				cpu-critical {
+					cooling-device = <&fan 3 3>;
+					trip = <&cpu_trip_critical>;
+				};
+
+				cpu-hot {
+					cooling-device = <&fan 2 2>;
+					trip = <&cpu_trip_hot>;
+				};
+
+				cpu-active {
+					cooling-device = <&fan 1 1>;
+					trip = <&cpu_trip_active>;
+				};
+
+				cpu-passive {
+					cooling-device = <&fan 0 0>;
+					trip = <&cpu_trip_passive>;
+				};
+			};
+		};
+
+		gpu {
+			polling-delay = <0>;
+			polling-delay-passive = <500>;
+			status = "okay";
+
+			trips {
+				gpu_alert0: critical {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		aux {
+			polling-delay = <0>;
+			polling-delay-passive = <500>;
+			status = "okay";
+
+			trips {
+				aux_alert0: critical {
+					temperature = <90000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
 	};
 };
-- 
2.19.1

