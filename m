Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F316C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB79E26F68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSop4TqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB79E26F68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeF1Fmy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:42:54 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36046 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeF1Fmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:42:35 -0400
Received: by mail-qt0-f195.google.com with SMTP id o9-v6so3746569qtp.3;
        Wed, 27 Jun 2018 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=acuVQP87Z1bJ9jwEOZLUf34P9tVFU2QWk67UGCKgAug=;
        b=bSop4TqZfrictmIAQ6AO3m+jlxfz5BE/CY1tgZtR3q9CPpduCFDymKEH+VaxVtGeiV
         u//xzYH93JqKbR2BMcYTv1KOsGUcIfQWeekjFFwAw075pozHCxu2+T7lWhPUlMTOSdBF
         r8kV4kxM+A03KuR515vfRCwMQbgIx2jSwjKLuZwbZSu+B8iSd2RVTYlVGXvnu0+/SsUW
         iGNvNj4dkaw8ASrh6mZqKK4qIF8alfSiKX61CRRAbBvlpKSBj8blO2OQmrniFoPYUcLX
         4cZG5JULZztk+X8l40h5Nu+BLo4rAFdRnN8biEKoMw9bn9FcDoWxV5loXuvEU/F6J98k
         W41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=acuVQP87Z1bJ9jwEOZLUf34P9tVFU2QWk67UGCKgAug=;
        b=PLgg627WxOPoSVILFo/RqZYZw6duUz18TA0CAXGzAuVGJ3JrJOpODh7joU5sAhqykf
         vu3tWexPrk6W840UKe/0kByaWMXYsM5uHf9eU18MmNztKoeNHkAo0Aw7WZ4bDfbmCy2K
         qshf+t9SRPM/z8W37+yB3EP5oHMbujRRC6im2FnGz30zDDW49IC2kdN3jmImnSoQjU/J
         83BZnCgq2/hxMXbfwyG/meNbFnlOsiNG4BtiG5gJPzTIW+AT9SxNHNvmTLxCeAU9dlI1
         kSU6TPV+/vI7e67FpgneI+yibaFfa666xgzYQS70ade+1Nsw7ZjN1tApusa2E7FVma2S
         2qrA==
X-Gm-Message-State: APt69E0DizFKQzP7I32gZ6gm3kTGI6Tl2ld1bRHCh9wKU79SRdeQCoQK
        Xf4QPcrQRJr1tOl5fR2zlow=
X-Google-Smtp-Source: AAOMgpdbeZwJq3NBiUIJk7cv+/XOCOhkIBvcsggS9g1j/EDH3rAZyP2Ec6mwoRmtUeCcAfsKsUdWhw==
X-Received: by 2002:ac8:3f54:: with SMTP id w20-v6mr7692964qtk.91.1530164554378;
        Wed, 27 Jun 2018 22:42:34 -0700 (PDT)
Received: from localhost.localdomain (186-106-135-170.baf.movistar.cl. [186.106.135.170])
        by smtp.gmail.com with ESMTPSA id u40-v6sm3410281qth.24.2018.06.27.22.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:42:34 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from compatible property
Date:   Thu, 28 Jun 2018 01:42:05 -0400
Message-Id: <20180628054205.17737-6-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value "zynq" isn't officially part of the model on any board.
Additionally, the value is redundant as it's included in a
subsequent value of the property.

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++----------
 arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
 arch/arm/boot/dts/zynq-microzed.dts           |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
 arch/arm/boot/dts/zynq-zedboard.dts           |  2 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
 12 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index d10adc4d0..0785acce4 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -9,34 +9,34 @@ Required root node properties:
 Additional compatible strings:
 
 - Xilinx CC108 board
-  "xlnx,zynq-cc108"
+  "xlnx,cc108"
 
 - Avnet MicroZed board
-  "avnet,zynq-microzed"
+  "avnet,microzed"
 
 - Adapteva Parallella board
   "adapteva,parallella"
 
 - Xilinx ZC702 board
-  "xlnx,zynq-zc702"
+  "xlnx,zc702"
 
 - Xilinx ZC706 board
-  "xlnx,zynq-zc706"
+  "xlnx,zc706"
 
 - Xilinx ZC770 board, with different FMC cards
-  "xlnx,zynq-zc770-xm010"
-  "xlnx,zynq-zc770-xm011"
-  "xlnx,zynq-zc770-xm012"
-  "xlnx,zynq-zc770-xm013"
+  "xlnx,zc770-xm010"
+  "xlnx,zc770-xm011"
+  "xlnx,zc770-xm012"
+  "xlnx,zc770-xm013"
 
 - Avnet ZedBoard board
-  "avnet,zynq-zedboard"
+  "avnet,zedboard"
 
 - Digilent Zybo board
-  "digilent,zynq-zybo"
+  "digilent,zybo"
 
 - Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
+  "digilent,zybo-z7"
 
 ---------------------------------------------------------------
 
diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
index 8b9ab9bba..ccff20099 100644
--- a/arch/arm/boot/dts/zynq-cc108.dts
+++ b/arch/arm/boot/dts/zynq-cc108.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Xilinx CC108 board";
-	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
+	compatible = "xlnx,cc108", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index 3cc957428..ef55adb02 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Avnet MicroZed board";
-	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
+	compatible = "avnet,microzed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 3f84b94db..bd633a9bc 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Xilinx ZC702 board";
-	compatible = "xlnx,zynq-zc702", "xlnx,zynq-7000";
+	compatible = "xlnx,zc702", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index a15908cac..f4805f01b 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Xilinx ZC706 board";
-	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
+	compatible = "xlnx,zc706", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
index 0e1bfdd34..21f457656 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "Xilinx ZC770 XM010 board";
-	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
+	compatible = "xlnx,zc770-xm010", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
index b7f65862c..e4a0b2629 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "Xilinx ZC770 XM011 board";
-	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
+	compatible = "xlnx,zc770-xm011", "xlnx,zynq-7000";
 
 	aliases {
 		i2c0 = &i2c1;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
index d2359b789..d2ee09590 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "Xilinx ZC770 XM012 board";
-	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
+	compatible = "xlnx,zc770-xm012", "xlnx,zynq-7000";
 
 	aliases {
 		i2c0 = &i2c0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
index 651913f1a..9d6090ee4 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "Xilinx ZC770 XM013 board";
-	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
+	compatible = "xlnx,zc770-xm013", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem1;
diff --git a/arch/arm/boot/dts/zynq-zedboard.dts b/arch/arm/boot/dts/zynq-zedboard.dts
index 540581c56..8a7894552 100644
--- a/arch/arm/boot/dts/zynq-zedboard.dts
+++ b/arch/arm/boot/dts/zynq-zedboard.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Avnet ZedBoard board";
-	compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
+	compatible = "avnet,zedboard", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index be40be9b7..bcb633860 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Digilent Zybo Z7 board";
-	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
+	compatible = "digilent,zybo-z7", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 0439e9f1e..776d3d77d 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Digilent Zybo board";
-	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
+	compatible = "digilent,zybo", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0

