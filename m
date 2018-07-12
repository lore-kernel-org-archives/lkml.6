Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F232BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2428208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb8u2yXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2428208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeGLESd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33675 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeGLESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:32 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so2716987qtp.0;
        Wed, 11 Jul 2018 21:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GwW43dH2kJh6lJItZ3e112SN5dB8I7crzh++mlw4EWs=;
        b=Yb8u2yXzpZhe9T5PTZk6RGo76E1ixYgeNRFGIVQfFK41/HunMCMs59XDqDMXxXemBF
         Y5fPAZiDW+/Q3uEEXs3htt9W0rsRx9QlMy/uMcEDDK4jbZ588gMyq8jhCCJK7yqSGydS
         UxoNIJxUgMuWLGDjCkD0fLEq9ZqX9V6GGwr63F3AsyhjCStKGJyTdB88/FF9PX9fGlTW
         8Yt1DsA9YUVUIoOsvwKBeHCVyzNlKeyYehRtWHytgTGcKG5+HADcJBq4RFhZCH92nVeR
         Tb2W85oFnz0JGRMac7r+29iBTfyG2nwG8/x3wCgUN8/5gDD5r6WbmHd0Kcx9xYm/CTX2
         1J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GwW43dH2kJh6lJItZ3e112SN5dB8I7crzh++mlw4EWs=;
        b=htTidrOUuHSyKRcnxIdWG4LEzQRCDpIzGhOb/VTPNqAHzAQo3b2HY6XdMWHGqy8Jbj
         mUIAwJdHR0u9BTZEiw3whJYz00LgbcFHbsGkYm7HIXqt6EtcjQ9zMhYcdw/LenoJwQc+
         B+ne0vnnlbZC3phg8cMEWTjS3yHjTy3vbvbp18ppxoBEpm8OKfEOfg0+wE5Q06KbY2MW
         a/O7YE9eugPvRF86pg/3exTYFWtJWa05OKAVRJa7htt8LAss7jzPmD6p2wVI0jenN4uw
         12We1gfz5GxmGkoyfaArxwUA7Dbw4sqtmLBfwOeb2BNrrzpDLKtNeymsT/SoPh75l8Yr
         2/9Q==
X-Gm-Message-State: AOUpUlFyLxqpcSRP4wbCo/huDcGezQdpEhLRr2nb4faE0jTTRrTnDLDe
        IXtAafSryPhIJ8XGTCw523s=
X-Google-Smtp-Source: AAOMgpeu3TNNoJwoe/3I2HfFo8uMJl//ki5mu9xK5lOqcXqehKeS6qm4vgK6TM+B9X1KdTsT2Nfvhg==
X-Received: by 2002:ac8:29f6:: with SMTP id 51-v6mr504754qtt.200.1531368652043;
        Wed, 11 Jul 2018 21:10:52 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:10:51 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 2/6] arm: dts: zynq: correct and improve the model property of dt files
Date:   Thu, 12 Jul 2018 00:10:20 -0400
Message-Id: <20180712041024.20583-3-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the current value of the model property by a more accurate
description of each board (which includes the manufacturer), as some
of the boards had the same value ("Xilinx Zynq")

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-cc108.dts       | 2 +-
 arch/arm/boot/dts/zynq-microzed.dts    | 2 +-
 arch/arm/boot/dts/zynq-parallella.dts  | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts         | 2 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts     | 2 +-
 arch/arm/boot/dts/zynq-zybo.dts        | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
index 1a0f631c1d8d..8b9ab9bba23b 100644
--- a/arch/arm/boot/dts/zynq-cc108.dts
+++ b/arch/arm/boot/dts/zynq-cc108.dts
@@ -12,8 +12,8 @@
 /include/ "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx CC108 board";
 	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index 574ef2276182..6ed84fb15902 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -7,7 +7,7 @@
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Zynq MicroZED Development Board";
+	model = "Avnet MicroZed board";
 	compatible = "avnet,zynq-microzed", "xlnx,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index c05f4b67d4c1..54592aeb92b9 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -12,7 +12,7 @@
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Adapteva Parallella Board";
+	model = "Adapteva Parallella board";
 	compatible = "adapteva,parallella", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index f2330b0cb63d..3f84b94db995 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZC702 Development Board";
+	model = "Xilinx ZC702 board";
 	compatible = "xlnx,zynq-zc702", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 3ad1260ff2a1..a15908cacbcf 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZC706 Development Board";
+	model = "Xilinx ZC706 board";
 	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
index 6884f1ad66b7..0e1bfdd3421f 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM010 board";
 	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
index b78883cee96a..b7f65862c022 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM011 board";
 	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		i2c0 = &i2c1;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
index c3169d63600d..d2359b789eb8 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM012 board";
 	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		i2c0 = &i2c0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
index 8bb66859d774..651913f1afa2 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM013 board";
 	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		ethernet0 = &gem1;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 595022487965..3a4ae51ca4da 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq Zed Development Board";
+	model = "Avnet ZedBoard board";
 	compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 1e713dc98920..be40be9b7222 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -3,7 +3,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZYBO Z7 Development Board";
+	model = "Digilent Zybo Z7 board";
 	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index a6c00e7fa767..0439e9f1ea6f 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZYBO Development Board";
+	model = "Digilent Zybo board";
 	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
 
 	aliases {
-- 
2.18.0

