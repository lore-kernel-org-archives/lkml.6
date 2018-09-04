Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E727C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC48920867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="qBYVTor+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC48920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIDUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:04:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34370 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeIDUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:04:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so3634513eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rJFhJQdlXFMI3B+h5Idu1/AfbqyBp4CSVAf6R1RJ1yw=;
        b=qBYVTor+QreZE6WJTCcNS94zkiOSRWBFabfU8O1XZcQQP2YlJJk6iQleDFkSAYKCd7
         TJFFZPXMOXhAteVLh2Un4hFOaAQvxCOBwddlOuzYaAPrZ+9cc4dm0CQiZOJNS6XtDXdF
         Kw9q5kcphA2Z8ODl7vvXn35EH8kzkgLmJliyooKD4EykkBtUmE8+BqjBM3HqiChx/vG3
         QqhJ+Ej4YAt4bpDxmlKDg8jY7iuk7r6bQJHO/fTWAcWPjNcmpIEKzpgM2guZn1J3oY76
         Z+sejI9v1R7OhLt6T20TP5vUZS/lElYnJLVcOIw2RDf5xuoHlZXaC/fSTMpDFfuLLQv1
         TF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rJFhJQdlXFMI3B+h5Idu1/AfbqyBp4CSVAf6R1RJ1yw=;
        b=dyV6h3kT92kCPUH+znlCzY/0l3zVK3knSqqw6TAyghwH+LXC1mEnY3XvrphSWaXVIL
         G3A9Sm564cqqpNLZzcz9u9lDaUPbVjprG7tqfFdT2ayr3Pnnc4kJA46x0iJzqxI6xndE
         5JUi0Fb3KiuUXPh+cd/U5yYfhmueV8LMwFug1hdztg/g1GopBg1NxXXFIsavQFsu/DeY
         cMD21DyNJfkVwI/t1XAI/nfkMqaXyWsHIxeZ9EJbNWoiLsYLH2+7zQUjtcA4XYXvdGCZ
         7FWhMZG34EyOrFWa9/OFCoZ878Xb1teQt92HoSl8J7ap62pGCqdXuziYDwXKwyCngae1
         6oAA==
X-Gm-Message-State: APzg51AXJ901qcKXfi11fPzu+LBOwvFeVC0JAhffDvmqxTwtIRvVEG4x
        1GKvafqWwCVYoFqUymOlb+D61L/BUUxZEnetqEn+Gw==
X-Google-Smtp-Source: ANB0VdZxf7T6pXVeMJE0ZZTkiNEUoVzNkms26H1QHGaZ10ebnAJo64xPde+9sUbEhDje7G2YW9VB5PhW92XgZTuFpao=
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr36974682edd.243.1536075505307;
 Tue, 04 Sep 2018 08:38:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2443:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:38:24
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Tue, 4 Sep 2018 12:38:24 -0300
Message-ID: <CADHB5bAYs4QjhYVj--Vd5vVP0h5o8161St_=Yj2HfhFAR4U3eQ@mail.gmail.com>
Subject: [PATCH v2 02/03] arm: dts: actions: Enable clock controller for
 Actions Semi S500 SoC
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        will.deacon@arm.com, thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable clock controller for Actions Semi S500 SoC on owl-s500 device tree.
Set UART clock reference from CMU for Actions Semi S500 SoC.
Tested on a Lemaker Guitar board.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>


diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 7c96c59b610d..4a91a29d2f29 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -3,6 +3,7 @@
  * Cubietech CubieBoard6
  *
  * Copyright (c) 2017 Andreas F=C3=A4rber
+ * Copyright (c) 2018 Edgar Bernardi Righi
  */

 /dts-v1/;
@@ -25,12 +26,6 @@
         device_type =3D "memory";
         reg =3D <0x0 0x80000000>;
     };
-
-    uart3_clk: uart3-clk {
-        compatible =3D "fixed-clock";
-        clock-frequency =3D <921600>;
-        #clock-cells =3D <0>;
-    };
 };

 &timer {
@@ -39,5 +34,4 @@

 &uart3 {
     status =3D "okay";
-    clocks =3D <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index e610d49395d2..1a980ca6a426 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2016-2017 Andreas F=C3=A4rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  */

 /dts-v1/;
@@ -18,15 +19,8 @@
     chosen {
         stdout-path =3D "serial3:115200n8";
     };
-
-    uart3_clk: uart3-clk {
-        compatible =3D "fixed-clock";
-        clock-frequency =3D <921600>;
-        #clock-cells =3D <0>;
-    };
 };

 &uart3 {
     status =3D "okay";
-    clocks =3D <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts
b/arch/arm/boot/dts/owl-s500-sparky.dts
index c665ce8b88b4..65555afee584 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -3,6 +3,7 @@
  * Allo.com Sparky
  *
  * Copyright (c) 2017 Andreas F=C3=A4rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  */

 /dts-v1/;
@@ -25,12 +26,6 @@
         device_type =3D "memory";
         reg =3D <0x0 0x40000000>; /* 1 or 2 GiB */
     };
-
-    uart3_clk: uart3-clk {
-        compatible =3D "fixed-clock";
-        clock-frequency =3D <921600>;
-        #clock-cells =3D <0>;
-    };
 };

 &timer {
@@ -39,5 +34,4 @@

 &uart3 {
     status =3D "okay";
-    clocks =3D <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.d=
tsi
index 5ceb6cc4451d..bf506038e22b 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -3,10 +3,12 @@
  * Actions Semi S500 SoC
  *
  * Copyright (c) 2016-2017 Andreas F=C3=A4rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  */

 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/clock/actions,s500-cmu.h>

 / {
     compatible =3D "actions,s500";
@@ -69,6 +71,12 @@
         clock-frequency =3D <24000000>;
         #clock-cells =3D <0>;
     };
+
+    losc: losc {
+        compatible =3D "fixed-clock";
+        clock-frequency =3D <32678>;
+        #clock-cells =3D <0>;
+    };

     soc {
         compatible =3D "simple-bus";
@@ -124,6 +132,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0120000 0x2000>;
             interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART0>;
             status =3D "disabled";
         };

@@ -131,6 +140,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0122000 0x2000>;
             interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART1>;
             status =3D "disabled";
         };

@@ -138,6 +148,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0124000 0x2000>;
             interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART2>;
             status =3D "disabled";
         };

@@ -145,6 +156,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0126000 0x2000>;
             interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART3>;
             status =3D "disabled";
         };

@@ -152,6 +164,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0128000 0x2000>;
             interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART4>;
             status =3D "disabled";
         };

@@ -159,6 +172,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb012a000 0x2000>;
             interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART5>;
             status =3D "disabled";
         };

@@ -166,8 +180,18 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb012c000 0x2000>;
             interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART6>;
             status =3D "disabled";
         };
+
+        cmu: clock-controller@b0160000 {
+            compatible =3D "actions,s500-cmu";
+            reg =3D <0xb0160000 0x8000>;
+            clocks =3D <&hosc>, <&losc>;
+            clock-indices =3D <CLK_UART0>, <CLK_UART1>, <CLK_UART2>,
+                            <CLK_UART3>, <CLK_UART4>, <CLK_UART5>, <CLK_UA=
RT6>;
+            #clock-cells =3D <1>;
+        };

         timer: timer@b0168000 {
             compatible =3D "actions,s500-timer";
