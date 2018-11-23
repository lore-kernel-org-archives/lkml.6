Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE53C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MNgeUNvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE53C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633180AbeKXGjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36649 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeKXGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so12986897wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk6NbW6xFFI/4/JJNngXdoHaDRPggf+bny1s89MRwTM=;
        b=MNgeUNvVGBLyaLH4ke0l9DdlneCQT5PmpstMQ74LIjJupfYPa8aINF+dRcYQktr59Y
         4sY9NSG2VDwd6MGUrYWwgcixradfn8C4iWwv3A5tjOLx4Q2WjDaqgzCUQuLNv5h/exCY
         aNm1BasYP6Qui/wb7NNQvwPkHZX7T8djUFacnbDrBj/SVX5u7P5yZHmRT1CFBiklPf31
         iaKa5qbEMdFPdSr0QoFO5TBgXPJqYQBQx+/twitijqf4CGv1PDCHCFjiYv3ebPYYJrlh
         CGkzBgdxFvKOEt2WrQFg99nvhc1xrpCWUIqSJIBcZi0cR/tCvtvNyShCwcxG4o7BACS8
         dglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk6NbW6xFFI/4/JJNngXdoHaDRPggf+bny1s89MRwTM=;
        b=tZcnACtXCUKwoSoC+WGPF+GloxpfdTpLgtGPxm4RKs9iYOY4Y/CQiNwWZ5QyFS8Lsa
         sWVZXBtITJLf5kFgaO+D7jvSqeGzn44+A6bQ4g90xm2FXnWyuQJY3KYzaPXdTWeQ7ifF
         Ok+PAR01m3dbkBDq5zdlEWGZkSRXZu2hMZXHx6TWqpp28pDSO6QVPuaO9DMhngis3vw5
         CAYSddBmmfYkCb4J1N1iVxjQ3sFPPr6TcxcdiWdUjWoV7B5WCwHz/+ELVyzHB4nYLQ9x
         PZ19b5TDtnLTxJQl3//CteB8DkG9zcsH4UMHD6/q/9vtSJyE7PqTgNZoj2rQhGZhwDuu
         uPnw==
X-Gm-Message-State: AA+aEWZjtqYXfns9/FgITp92KeMpWzlpzFeXC8rodCxCm1QWm5FG+Skk
        Dl0KFU1HMIOumIrCyeQkmsA=
X-Google-Smtp-Source: AFSGD/WjneB/cPaXtp4qCTMTg78oMJHAtgOSgrgtky6YR75WtV0VRog9ctb+PenzpvqXhMUIUyxBrQ==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr11905221wmc.115.1543002806306;
        Fri, 23 Nov 2018 11:53:26 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:25 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/6] ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
Date:   Fri, 23 Nov 2018 20:53:07 +0100
Message-Id: <20181123195311.4578-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The public Meson8b (S805) datasheet describes a memory region called "A9
Periph base" which starts at 0xC4300000 and ends at 0xC430FFFF. Add a
simple-bus node and move all peripherals that are part of this memory
region.
This makes the .dts a bit easier to read. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++--------
 arch/arm/boot/dts/meson8.dtsi  | 12 +++++++-----
 arch/arm/boot/dts/meson8b.dtsi | 12 +++++++-----
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 0839da07a75c..e4645f612712 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -59,14 +59,6 @@
 		cache-level = <2>;
 	};
 
-	gic: interrupt-controller@c4301000 {
-		compatible = "arm,cortex-a9-gic";
-		reg = <0xc4301000 0x1000>,
-		      <0xc4300100 0x0100>;
-		interrupt-controller;
-		#interrupt-cells = <3>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -207,6 +199,22 @@
 			};
 		};
 
+		periph: bus@c4300000 {
+			compatible = "simple-bus";
+			reg = <0xc4300000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xc4300000 0x10000>;
+
+			gic: interrupt-controller@1000 {
+				compatible = "arm,cortex-a9-gic";
+				reg = <0x1000 0x1000>,
+				      <0x100 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+			};
+		};
+
 		aobus: aobus@c8100000 {
 			compatible = "simple-bus";
 			reg = <0xc8100000 0x100000>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 3be5fbd07997..28b9f6779993 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -129,11 +129,6 @@
 			no-map;
 		};
 	};
-
-	scu@c4300000 {
-		compatible = "arm,cortex-a9-scu";
-		reg = <0xc4300000 0x100>;
-	};
 }; /* end of / */
 
 &aobus {
@@ -362,6 +357,13 @@
 	arm,shared-override;
 };
 
+&periph {
+	scu@0 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x0 0x100>;
+	};
+};
+
 &pwm_ab {
 	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
 };
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 587a855f872b..6b097ab8637f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -112,11 +112,6 @@
 			no-map;
 		};
 	};
-
-	scu@c4300000 {
-		compatible = "arm,cortex-a5-scu";
-		reg = <0xc4300000 0x100>;
-	};
 }; /* end of / */
 
 &aobus {
@@ -349,6 +344,13 @@
 	arm,shared-override;
 };
 
+&periph {
+	scu@0 {
+		compatible = "arm,cortex-a5-scu";
+		reg = <0x0 0x100>;
+	};
+};
+
 &pwm_ab {
 	compatible = "amlogic,meson8b-pwm";
 };
-- 
2.19.2

