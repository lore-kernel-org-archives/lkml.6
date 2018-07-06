Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3265E20896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXuHzfLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3265E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeGFGFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:05:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35809 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeGFGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:03:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so9122427qti.2;
        Thu, 05 Jul 2018 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCm4ulKFf5ZYa2v2tL5Y/9KpANuQapCWwcXi5Ty2fU0=;
        b=WXuHzfLLR9DoxZ9zdd22uAP+t1KQfcjsOhhRi0QkZ3Rbk6++mbVzrzO0Yl/iB5Ccij
         RIkbOPJAgCkP36uSobEgZrKm78CrP9vz3BbGoRaxye1a18mQfEUKwJKtXPG8ItH0VxKn
         Ub882rQ38KZXKXJiurqKxgQ6WQzD2A85aF4xJxmimag4HUyC4LGjWgJWIKDi9FOVjTS8
         YAL6yYwKF3Zh1PasAOGM9tWnmhhjrJuA99IZO/pdWNeSrti1BOYhSLaRiVjVGqO7I3R6
         xVKuBptVCMXOT4I4r7T0scpWe0Qf47yN9PnwWZGmtHbbQ3qP/fy1PEF1ktZTvL7DUks0
         1NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCm4ulKFf5ZYa2v2tL5Y/9KpANuQapCWwcXi5Ty2fU0=;
        b=s1sh8He/cSZnV2yga3ez3aiK2iSOBftDzh4Q7yFY/BPdXceIX8d6EJA4rt/EJzWTId
         1G5E5SuHKvlYMnxmjTfZ5rCBNVR8ePbsf/u+1/CyNgkV4dBO4FwePzCGsbE5dRCEcNU8
         NqI34P/vhw1P6gQLSSoAoyqKOD1GuO9d6PeuvDI2pieXr93V9X0Mscg7mmFkmBDNieUR
         Ckm5Gd66Wn6VRGH7kzf7KrvJNGKy3BJiqjoDyXaqlJAvXBI0ay2gDVDh/XzFE2ofst8d
         htTu7xjcZnkqChK1MjtU90aaUnCx+PV+3Hkjckq+St48nsuuqGOuevJPjMnr3hqLhkgB
         vzBA==
X-Gm-Message-State: APt69E2SXCfghfNs8M09Ch/kLW8WFrY2fCTlfPjut47VuRRjdITCb9Ma
        YOmtYVQn5vert+Sds6TustM=
X-Google-Smtp-Source: AAOMgpeO2S//C272ZH9t8yRuNVPHj0ycrnhr35lYUvzUziS3SzP2qccLSjVOylTXEW+dmu37iITJ2w==
X-Received: by 2002:ac8:31e:: with SMTP id q30-v6mr8081708qtg.255.1530857005610;
        Thu, 05 Jul 2018 23:03:25 -0700 (PDT)
Received: from localhost.localdomain (186-106-247-248.baf.movistar.cl. [186.106.247.248])
        by smtp.gmail.com with ESMTPSA id j11-v6sm1829119qtn.10.2018.07.05.23.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:03:25 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v2 3/3] arm: dts: zynq: correct and improve the model property of dt files
Date:   Fri,  6 Jul 2018 02:01:58 -0400
Message-Id: <20180706060158.24155-4-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706060158.24155-1-luaraneda@gmail.com>
References: <20180706060158.24155-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the current value of the model property by a more accurate
description of each board (which includes the manufacturer), as some
of the boards had the same value ("Xilinx Zynq")

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---

Changes since v1 (RFC):
- No changes

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

