Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A86FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF8026E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V31b8HJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF8026E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbeF1Fmi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:42:38 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37650 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeF1Fmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:42:31 -0400
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so2360341qke.4;
        Wed, 27 Jun 2018 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PI5WV05IhFh9mtCmeWEWxLUMs/65ra1I+ik5eyIiZq8=;
        b=V31b8HJqHOY8UORyUkrcFIE7uOYKV7LBFrWlCgAOqV7gkYXgF1Tz/HRiHuT/c9GClS
         Z2eZC5FScVkBKzwQbKdsmNS7NqESqhCUNe53by1ESrYshEQG7ACTEaT0oDGryxZEPm4d
         ReTPKuzBVUZjruP064JLJnW51uHV61o7m6hSRWDa6XGyyjTIo/xPMEGFaS9q/aTwms9G
         Dm3zOB87lBxZE+2gzFoJwg4ieeHbXmG9tWW9ZcFnSvIu5BU/rAFXKuvbBxkJZEDsyGZN
         lWciOZ4vjBr6/mIJWcOoyiJr1jzs9KH3Y/kSq8tUHK6CCCscCD7xtpaS36szJTV8LE92
         rjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PI5WV05IhFh9mtCmeWEWxLUMs/65ra1I+ik5eyIiZq8=;
        b=LGyUazwPsSaOjSvL+Q5zeDy+OOmyH3FhQ1gNtuC2pilelDn52+R3+4f1nK7GP7cOwJ
         Dy3oTP7ffTaJY4mMsH8WtI880Rq55R4Pa1frLVcvZlDbgNnX4gq+EwEp2hfaLlXGdMI6
         goAOPmCH6DiGDrQax6Dy7SR7ljAnVBRbl5pbs7r9E6tMn/4FHNPlPWB0I4wt1GEM8TSR
         IJSY7Wm2O0zPzIVizfGyRsetNh6mq4uOhSbbxDZappjQAT3KTlrZHncM1lPdLYnjVFUf
         FvQiWMOuzWF6iZxedQn8NldmlEEEBR3KFdQKQ5j+bwbXz17b/nrVcznGB4emJuFehC4F
         lozQ==
X-Gm-Message-State: APt69E1W/fatYGzlMm1MNKTbHj9dHG5jQTsKLuU4kQyEaqufEtq+uwUu
        XEgtCVgOhbv1uBGVrvBVezNhhPAL3mA=
X-Google-Smtp-Source: AAOMgpdki052K4aUDp4xDSqvDeJrISMU4XBaKt0aaJIejkz282r7YpLgztEP5Q9H7s5R5nysa4aftQ==
X-Received: by 2002:a37:7441:: with SMTP id p62-v6mr7748448qkc.262.1530164549492;
        Wed, 27 Jun 2018 22:42:29 -0700 (PDT)
Received: from localhost.localdomain (186-106-135-170.baf.movistar.cl. [186.106.135.170])
        by smtp.gmail.com with ESMTPSA id u40-v6sm3410281qth.24.2018.06.27.22.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:42:29 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH 3/5] arm: dts: zynq: correct and improve the model property of dt files
Date:   Thu, 28 Jun 2018 01:42:03 -0400
Message-Id: <20180628054205.17737-4-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
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
index 1a0f631c1..8b9ab9bba 100644
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
index e40f40a7f..3cc957428 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -7,7 +7,7 @@
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Zynq MicroZED Development Board";
+	model = "Avnet MicroZed board";
 	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index c05f4b67d..54592aeb9 100644
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
index f2330b0cb..3f84b94db 100644
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
index 3ad1260ff..a15908cac 100644
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
index 6884f1ad6..0e1bfdd34 100644
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
index b78883cee..b7f65862c 100644
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
index c3169d636..d2359b789 100644
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
index 8bb66859d..651913f1a 100644
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
index 98381cc85..bf3e26dbf 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq Zed Development Board";
+	model = "Avnet ZedBoard board";
 	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 1e713dc98..be40be9b7 100644
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
index a6c00e7fa..0439e9f1e 100644
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

