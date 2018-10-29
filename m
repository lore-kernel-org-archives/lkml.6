Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF2EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8FA20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdI4U6xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8FA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJ3BpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:45:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44419 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJ3BpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:45:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so819197pff.11;
        Mon, 29 Oct 2018 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=stgZ8MaSVKW5JVyPTsPvu0/l6uCyiaZAZp3utVDYDR4=;
        b=gdI4U6xL2zx5onrm7eTw1r49FHjvkzbjsyqLBIaGR3tW+/JmonFNtpjWhY+B8U9sgt
         ZsVufkRn5hoq3SxIER3XGpL4ExkX+1nGOtJbx07kwFGeCLqMJ2FL4vplVcBGZLo4ILYc
         4cSyXk/PrXckG/mEmuRffaEkuedLLq5ON/iyVWp+8nAUrVB+4KMkmtmHAhuuBE+HazsH
         Du0C5wS7jAieda0otOt+KEd9eCcpXWnTyAt55uo8yqEONJstZ2YmnpVJGNPyllXdQTzJ
         Far9dYCSsn4C+jfdyR40bjBGecGHt2KmzYWSw3iTRnot+RdkQqRkWd5funBDx7kjX/JW
         p0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=stgZ8MaSVKW5JVyPTsPvu0/l6uCyiaZAZp3utVDYDR4=;
        b=r4N7r90YVPMlDtJSZYcrz1U4KLKTHb+5PBNGgsi7dCkjVSIu4avCUrrEeJAnfJfeRq
         eQ8Y24DCCI+wg1relSl+LF7cxDz6tOwDE9j4LcH4xjoRL9o9QCeDFapdT3VbBxjBfAb/
         5L2TA2eSY0mHDUz/B5eFdYBWymjdWM84Vi1YN7msYtAFg4+jD7GI4I2bvHUX8ICRYYV2
         Ez8mBfI5MKUJ5eck4Xhim10na0ERpwGEnN2CiEYHixSpgLwmb0QGmeKh6xvdeLXSKwJQ
         2phpjrEjmtEIDKsEfcLpIj1nhBESGhnpwdJTWblZhMkqzr9uGhGTHDkVlgSpfUI4V5ps
         OawA==
X-Gm-Message-State: AGRZ1gL/wV7ziBNEvNqqthXIxf4BzEOj8wTdJhF+f0nIAtWCu62M+Cay
        Jq50jwqPkLk0wxRCVCYOxUM=
X-Google-Smtp-Source: AJdET5dU8OisWbMC00p9eP3zdwbrLUZ1mMXtcegvvNIBolSU4Po2UfP99Ctt0hpzhQjjRSMZcAmpWA==
X-Received: by 2002:a63:f357:: with SMTP id t23-v6mr14361656pgj.402.1540832143504;
        Mon, 29 Oct 2018 09:55:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 64-v6sm28913311pgb.74.2018.10.29.09.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:55:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: NSP: Move aliases to bcm-nsp.dtsi
Date:   Mon, 29 Oct 2018 09:55:23 -0700
Message-Id: <20181029165524.26162-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All boards replicate the aliases node, move the aliases node to
bcm-nsp.dtsi and add all the serial and ethernet ports such that a boot
program like u-boot can populate MAC addresses accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 8 ++++++++
 arch/arm/boot/dts/bcm958522er.dts  | 4 ----
 arch/arm/boot/dts/bcm958525er.dts  | 4 ----
 arch/arm/boot/dts/bcm958525xmc.dts | 4 ----
 arch/arm/boot/dts/bcm958622hr.dts  | 4 ----
 arch/arm/boot/dts/bcm958623hr.dts  | 4 ----
 arch/arm/boot/dts/bcm958625hr.dts  | 4 ----
 arch/arm/boot/dts/bcm958625k.dts   | 5 -----
 arch/arm/boot/dts/bcm988312hr.dts  | 4 ----
 9 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index ec869a80f9ba..cbe6c6453d76 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -41,6 +41,14 @@
 	model = "Broadcom Northstar Plus SoC";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		ethernet0 = &amac0;
+		ethernet1 = &amac1;
+		ethernet2 = &amac2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index f9dd342cc2ae..21479b4ce823 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958522ER)";
 	compatible = "brcm,bcm58522", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 374508a9cfbf..cda3d790965b 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958525ER)";
 	compatible = "brcm,bcm58525", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 403250c5ad8e..f86649812b59 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus XMC (BCM958525xmc)";
 	compatible = "brcm,bcm58525", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index ecd05e26c262..df60602b054d 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958622HR)";
 	compatible = "brcm,bcm58622", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index f5e85b301497..3893e7af343a 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958623HR)";
 	compatible = "brcm,bcm58623", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index a53a2f629d74..cf226b02141f 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958625HR)";
 	compatible = "brcm,bcm58625", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 3ea5f739e90b..10b3d512bb33 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -38,11 +38,6 @@
 	model = "NorthStar Plus SVK (BCM958625K)";
 	compatible = "brcm,bcm58625", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index ea9a0806b446..e39db14d805e 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM988312HR)";
 	compatible = "brcm,bcm88312", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.17.1

