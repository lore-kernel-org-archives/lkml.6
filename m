Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC20DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2382089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUm0bIbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2382089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJHXri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:47:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJHXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:47:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so21508853wra.11;
        Mon, 08 Oct 2018 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2uQY3rUSBKqw8O35EQPrT9j9ER5Std0rFDoVrpsFcl4=;
        b=FUm0bIbQWPCqedZjKgVJGxikzq9iLJHWUC8Lzc2Jp+l3/zPtKmIPxhVjbqq3Lw58zk
         C90IrLE4Vp9pinlO4cZqHVH0v7wpCgiEhU309g4gA7VVildXXv1Sg/vTm5r9wP5D+d96
         KnL6MU/IGZeMrbg8y+uvUqSDIG8NVoLq9UWi7LPgxXjFICpYpGOFnK5m0JmQmyYbBpV8
         It/FwVXCXqdrgxA3/YBp+paahwCNSE2ybOKPQEEjYmbWi5//vWTaP8H+ORIMFq29sUkc
         HzEAJVYjSB9LhAL9UoykObEyw3FuUQhP54kLbvh8TePxgFmL6dh6OwpMx40mCweYqL+R
         Ghug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2uQY3rUSBKqw8O35EQPrT9j9ER5Std0rFDoVrpsFcl4=;
        b=byEpIeM/xf+AiPMZ6+zNmsDQkzxb0WdBtJREm8et+dv8ggROrlzl6CLHjdfHm6BP0r
         L6W7J1ojMciIhZcC0yEccZfM/fIUsJaJBJLZYcC9ysc3o2Hys6PQJm5nc5yiLRq7mXaA
         aXdYdbpWmWXExjz71a8ubadBWbxhf06llj7Jh5EL2XymEsKF+3N6EVS5Q+Ai+HLlJat2
         SwV8RTBuPRCfT+/O4ZRFXmB0dV57RCxh968RNQ8fuwbZSqNHngaxih/fjFk8JgRJLnXz
         dmAU+wooH09jgeqo+2kCuPXZkprJzY5SqDLPlqO0xS9oJ+eRv4BwPngHotkrTnWjwsn6
         6tCQ==
X-Gm-Message-State: ABuFfoiNa3pD61lUz3Oun8O75c+EPvoBo++zxyEDayYMyRXr1vduVzyS
        mReue+QFQpx/lbAccuvuVuC/bXtzQ8nqvQcyzh0=
X-Google-Smtp-Source: ACcGV60KtJhyHLIiu6r8YlJYmsL9qAIB++JWr3wRLciTaq7YgEeM7vnTSvCGYXk80pVa0S+vW8xiPHyJpHhXVgtjLVg=
X-Received: by 2002:adf:8382:: with SMTP id 2-v6mr16729635wre.13.1539016503398;
 Mon, 08 Oct 2018 09:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
 <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com> <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de>
In-Reply-To: <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de>
From:   =?UTF-8?Q?Ren=C3=A9_Kjellerup?= <rk.katana.steel@gmail.com>
Date:   Mon, 8 Oct 2018 09:34:49 -0700
Message-ID: <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
Subject: Re: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hauke,

Updated the file header per your suggestion.

From e97c15ef78d2535c23f32ebbec43bced72b5eaf7 Mon Sep 17 00:00:00 2001
From: Rene Kjellerup <rk.katana.steel@gmail.com>
Date: Mon, 1 Oct 2018 14:11:56 -0700
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2

It's wireless home router based on BCM4708A0 with BCM4360 + BCM4331
wireless chipsets. The 5GHz chip currently isn't supported only due
to missing compatible firmware.

the DTS here was based on the Linksys EA6300 V1 DTS, only changing
the model strings

Signed-off-by: Rene Kjellerup <rk.katana.steel@gmail.com>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts | 47 +++++++++++++++++++++=
++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..adf8f28f5e44 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -88,6 +88,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) +=3D \
     bcm4708-asus-rt-ac68u.dtb \
     bcm4708-buffalo-wzr-1750dhp.dtb \
     bcm4708-linksys-ea6300-v1.dtb \
+    bcm4708-linksys-ea6500-v2.dtb \
     bcm4708-luxul-xap-1510.dtb \
     bcm4708-luxul-xwc-1000.dtb \
     bcm4708-netgear-r6250.dtb \
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
new file mode 100644
index 000000000000..8a434d2a4b72
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
+ * Copyright (C) 2018 Rene Kjellerup <rk.katana.steel@gmail.com>
+ *
+ * this DTS was originally based on bcm4708-linksys-ea6300-v1.dts
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+    compatible =3D "linksys,ea6500-v2", "brcm,bcm4708";
+    model =3D "Linksys EA6500 V2";
+
+    chosen {
+        bootargs =3D "console=3DttyS0,115200";
+    };
+
+    memory {
+        reg =3D <0x00000000 0x08000000>;
+    };
+
+    gpio-keys {
+        compatible =3D "gpio-keys";
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        wps {
+            label =3D "WPS";
+            linux,code =3D <KEY_WPS_BUTTON>;
+            gpios =3D <&chipcommon 7 GPIO_ACTIVE_LOW>;
+        };
+
+        restart {
+            label =3D "Reset";
+            linux,code =3D <KEY_RESTART>;
+            gpios =3D <&chipcommon 11 GPIO_ACTIVE_LOW>;
+        };
+    };
+};
+
+&usb3_phy {
+    status =3D "okay";
+};
--=20
2.16.4

On Sun, Oct 7, 2018 at 2:08 PM Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
> On 10/04/2018 11:08 PM, Ren=C3=A9 Kjellerup wrote:
> > Hi Hauke,
> >
> > thank you for suggesting adding the dts patch to mainline kernel,
> > so here it is.
> > I feel Rafal technically still have the copyrights, this is pretty
> > much just a few string updates for the ea6500v2. However with this
> > dts in latest OpenWrt 18.06 loads and installs on my device.
> >
> > I will be available to do more testing should it be required.
> >
> > Regrads
> > Rene Kjellerup
> > --
> > -- as life grows older, I gain experience.
> > -- http://www.alchemiestick.net/
> >
>
> Hi Rene,
>
> Please send you patch inline in the mail and not as an attachment, I
> would suggest to use "git send-email" for sending the patch.
>
> Adding Rafal as copyright owner is ok, like you did it now. You could
> mention in the file header on which dts file this is based.
>
> Hauke
>


--=20
-- as life grows older, I gain experience.
-- http://www.alchemiestick.net/apps/
