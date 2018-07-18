Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB58ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC052075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="n80HyDOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC052075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeGRRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:00:46 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39688 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbeGRRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:00:46 -0400
Received: by mail-ed1-f44.google.com with SMTP id w14-v6so4728159eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OUxpyV6emQB/yEAP76ySZvfVZVYAl+HV3IrTbTnAO+M=;
        b=n80HyDOf4I5O8F0dVs5YfDWxjWuID9b/aYUXdulQ6e6AF9fPD70VcIehJj1JKW455i
         HYeC8snsfXlFLTK67LRNFLEBcp+iqscBX5SOko+kgcrdO0FnRUnia54+LEO01ZemBbz3
         RvOmXMDSmNiom4a4BlketX5qJq1iH1/uWBfjoi+PBVVVVnY0Sny5TDxUm8RJ4/BDOZ9M
         iANzD2k8cyi9s/2HrJO7YSQlFdEh003U4ekZVDSyzjAs2jsPnCd+4Cvlx3z4C9qQLVXZ
         tZh8TfVt9BK7ymhbV//VrheB2H6GMguycnN/oP98KGVHh1hNinsyVkq6QkE4w6/hFo8D
         iFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OUxpyV6emQB/yEAP76ySZvfVZVYAl+HV3IrTbTnAO+M=;
        b=dj7BtIZDZUC06CyF+Ukjtk/3teDrXUS6k8I7CdmrlKwqiJGdOuZPlf1bmicf9COMl9
         HL7BdtIDzDEaG+XqH5nGggPC+sbdHo5BkTXtO4oD0OHNJ7YxK8KdgV9b+Oz86T+n7kDv
         vkp/XaABx97s3xzVkA5sakOVXP3goDomGLNBD4p6tAJUOxTYXtHW4u8lLwJZ0x5enDEt
         6wk+NKKfi6HjonUgymVPjFhoWMWk7eGy1G/RfLtP64Z/EkJHEVUa+20CKEgAU8Msi/R6
         ZdFQYs+jcR+vrZFHvQizRgeTNn+P3PTXLz3xOFN27L0plHCHQA3d+XpA6NfJ/W+Nscqe
         rjuQ==
X-Gm-Message-State: AOUpUlEs+ZAfFdfYLld+apggdfRykz7GrYBMZ9UmTAyMwWlk6efvgdgm
        s+Bljir6vhGu5lXlnqvXwqUxlnyQeDWmfHYnSHNB8g==
X-Google-Smtp-Source: AAOMgpeTPWqpAtS+euhOV5K+gQYgNNnhXHeFBfS1y6wn7RfP8OeLOpO8OiZXKr9iI4OI80f5X8B5i21eYfjjZFAqqhE=
X-Received: by 2002:a50:aa43:: with SMTP id p3-v6mr7682360edc.233.1531930925712;
 Wed, 18 Jul 2018 09:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:d1cd:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:22:05
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Wed, 18 Jul 2018 13:22:05 -0300
Message-ID: <CADHB5bBARxb2ob4pg1sKxJsUf4eRhJThB=OuBkmHq-fSoD7f4A@mail.gmail.com>
Subject: [PATCH v1 04/04] arm: dts: actions: Set UART clock reference from CMU
 for Actions Semi S500 SoC
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

Set UART clock reference from CMU for Actions Semi S500 SoC.
Tested on a Lemaker Guitar board.

File(s) updated: "/arch/arm/boot/dts/owl-s500.dtsi",
"/arch/arm/boot/dts/owl-s500-cubieboard6.dts",
"/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts",
"/arch/arm/boot/dts/owl-s500-sparky.dts"

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

diff -uprN -X vanilla/Documentation/dontdiff
vanilla/arch/arm/boot/dts/owl-s500-cubieboard6.dts
linux/arch/arm/boot/dts/owl-s500-cubieboard6.dts
--- vanilla/arch/arm/boot/dts/owl-s500-cubieboard6.dts    2018-07-17
13:07:15.675710511 -0300
+++ linux/arch/arm/boot/dts/owl-s500-cubieboard6.dts    2018-07-17
16:42:53.202336000 -0300
@@ -26,12 +26,6 @@
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
@@ -40,5 +34,5 @@

 &uart3 {
     status =3D "okay";
-    clocks =3D <&uart3_clk>;
 };
+
diff -uprN -X vanilla/Documentation/dontdiff
vanilla/arch/arm/boot/dts/owl-s500.dtsi
linux/arch/arm/boot/dts/owl-s500.dtsi
--- vanilla/arch/arm/boot/dts/owl-s500.dtsi    2018-07-18
12:51:07.875364441 -0300
+++ linux/arch/arm/boot/dts/owl-s500.dtsi    2018-07-17 16:43:47.786063000 =
-0300
@@ -133,6 +133,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0120000 0x2000>;
             interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART0>;
             status =3D "disabled";
         };

@@ -140,6 +141,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0122000 0x2000>;
             interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART1>;
             status =3D "disabled";
         };

@@ -147,6 +149,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0124000 0x2000>;
             interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART2>;
             status =3D "disabled";
         };

@@ -154,6 +157,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0126000 0x2000>;
             interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART3>;
             status =3D "disabled";
         };

@@ -161,6 +165,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb0128000 0x2000>;
             interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART4>;
             status =3D "disabled";
         };

@@ -168,6 +173,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb012a000 0x2000>;
             interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART5>;
             status =3D "disabled";
         };

@@ -175,6 +181,7 @@
             compatible =3D "actions,s500-uart", "actions,owl-uart";
             reg =3D <0xb012c000 0x2000>;
             interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cmu CLK_UART6>;
             status =3D "disabled";
         };

@@ -182,6 +189,8 @@
             compatible =3D "actions,s500-cmu";
             reg =3D <0xb0160000 0x8000>;
             clocks =3D <&hosc>, <&losc>;
+            clock-indices =3D <CLK_UART0>, <CLK_UART1>, <CLK_UART2>,
+                            <CLK_UART3>, <CLK_UART4>, <CLK_UART5>, <CLK_UA=
RT6>;
             #clock-cells =3D <1>;
         };

diff -uprN -X vanilla/Documentation/dontdiff
vanilla/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
linux/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
--- vanilla/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
2018-07-17 13:07:15.675710511 -0300
+++ linux/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts    2018-07-18
13:15:24.956371706 -0300
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2016-2017 Andreas F=C3=A4rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  *
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
@@ -19,15 +20,9 @@
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
+
diff -uprN -X vanilla/Documentation/dontdiff
vanilla/arch/arm/boot/dts/owl-s500-sparky.dts
linux/arch/arm/boot/dts/owl-s500-sparky.dts
--- vanilla/arch/arm/boot/dts/owl-s500-sparky.dts    2018-07-17
13:07:15.675710511 -0300
+++ linux/arch/arm/boot/dts/owl-s500-sparky.dts    2018-07-16
11:53:58.799410000 -0300
@@ -25,12 +25,6 @@
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
@@ -39,5 +33,4 @@

 &uart3 {
     status =3D "okay";
-    clocks =3D <&uart3_clk>;
 };
