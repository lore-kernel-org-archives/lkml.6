Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A096720854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="YYslVW7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A096720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGRQdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:33:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32923 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeGRQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:33:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so4675814edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6MRB6uZSDqFKMsXzgSjqy1sOdLjKKtb4mLi6pXkEym0=;
        b=YYslVW7WoJkkWeWEPrWYdl+W9zeBX1LspRvou23Sbu6CRGM7ARxXhhWZjkK1MkSoFX
         2zEnUOVqWCIvShTA8K2Acui1dzq1BvA7qUvBp+x5leykIklKC6oqwxWPY7D6oWRkaZd7
         WV5Qc1zwXRYoySU80m9HhWuiJJhCmijKmjudXELdo26Tev+k30P5B2BLvwStHePcV8BU
         RFA/RRxg7lNSdlBEa7vO1PoxRRAm004T1VK8ox68xuXsTbNCZsb0zaOGeqUVgQLP6ngq
         6ZMVX8i2Z7ov4p/l1QCr7P1c8J5kXE7sMOI8a6K8Mx8h7/DaWlkqvFaQ3s6dd+6a41zu
         I34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6MRB6uZSDqFKMsXzgSjqy1sOdLjKKtb4mLi6pXkEym0=;
        b=AawdV1gMKiuvUBJsSn3mgVph+1JiR2RuNUTKJN+ln26wLHMN1WJqW4y/TefZpT8chw
         4SxqmT1pca8+2zyLVicMOLfKrjFsllgy/pTrudMgDqyKke0vxYnVzPMQfMDobH+IxH4P
         isxgl3W93zl+fS9EHUSwjpvzqT6o2+3obifH3EzhfvrF5IlfCuq81VCdLPP4H29mcV1B
         LBmhC/x011zkS92XlB6+DmeO0pvAfLSS0Q4FNMJHb9pY0sJRczRVWH3XpBzf3uIeV7jV
         7NuYvwmFXMPlC8uH2Mw2Ol+l3yLiIV78Qh8yrvRyF+0CVu4yuDBLxoi+8AXLZqIYC1Z6
         TxqA==
X-Gm-Message-State: AOUpUlEioUxL+9rq6pz7vM4SUDQe2NM9fEUJVdG2DAW18dMHK/olG7Xc
        JAXRxgbd+qH7uLYWip9LatOGq9R7+sCpE6PjOE5oJg==
X-Google-Smtp-Source: AAOMgpeCPaKnv30KOipWpayEn2+YCmptQC8cx9dpUEmAsFn26n6PiBv7Bb1X4+ca+bQM8LhnWbIn9q1pV0/FSBxTo58=
X-Received: by 2002:a50:b902:: with SMTP id m2-v6mr7458479ede.185.1531929285265;
 Wed, 18 Jul 2018 08:54:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:d1cd:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:54:44
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Wed, 18 Jul 2018 12:54:44 -0300
Message-ID: <CADHB5bDhdXonoSUahgxqV8_rcUwYxvh3t9WDNN4YO8g7KSt07Q@mail.gmail.com>
Subject: [PATCH v1 03/04] arm: dts: actions: Enable clock controller for
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
Tested on a Lemaker Guitar board.

File(s) updated: "/arch/arm/boot/dts/owl-s500.dtsi"

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

diff -uprN -X vanilla/Documentation/dontdiff
vanilla/arch/arm/boot/dts/owl-s500.dtsi
linux/arch/arm/boot/dts/owl-s500.dtsi
--- vanilla/arch/arm/boot/dts/owl-s500.dtsi    2018-07-17
13:07:15.675710000 -0300
+++ linux/arch/arm/boot/dts/owl-s500.dtsi    2018-07-18 12:51:07.875364441 =
-0300
@@ -2,12 +2,14 @@
  * Actions Semi S500 SoC
  *
  * Copyright (c) 2016-2017 Andreas F=C3=A4rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  *
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */

 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/clock/actions,s500-cmu.h>

 / {
     compatible =3D "actions,s500";
@@ -71,6 +73,12 @@
         #clock-cells =3D <0>;
     };

+    losc: losc {
+        compatible =3D "fixed-clock";
+        clock-frequency =3D <32678>;
+        #clock-cells =3D <0>;
+    };
+
     soc {
         compatible =3D "simple-bus";
         #address-cells =3D <1>;
@@ -170,6 +178,13 @@
             status =3D "disabled";
         };

+        cmu: clock-controller@b0160000 {
+            compatible =3D "actions,s500-cmu";
+            reg =3D <0xb0160000 0x8000>;
+            clocks =3D <&hosc>, <&losc>;
+            #clock-cells =3D <1>;
+        };
+
         timer: timer@b0168000 {
             compatible =3D "actions,s500-timer";
             reg =3D <0xb0168000 0x8000>;
