Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF7DC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D356205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fahPUWBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D356205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeJMTpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 15:45:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43211 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJMTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 15:45:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so16115975wrt.10;
        Sat, 13 Oct 2018 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G0T/pn0d70jOOapLRyGfOFyEjzcgZRirj6z3vSM+XCg=;
        b=fahPUWBJyeIlrtVobgnAAeKEJUhiTfZECHSkAWBshWgsjjl8dX3OB1j678XS6UC19h
         xqz4ldTW0YUd9nnYRKun2SHRN+at8BrTAeyiPacoIsH0eCe9rST0DJPtKA0g6ZpQnUV/
         JeFF9bQEWd8HbkMxAPAC24N1u8FwXZEhXCS4Wvi802r3JRXGRfPPPEM2TbAsQiQCl2Yy
         0Voylmv6akeymmPcpmlBMAvLhunq7Ee1zz8W3Ek5tCffr+huqEvMhSqc7XtaQuKWayM4
         7zx3PEwyvZX/Bm0T36Cfh6N+7oReSIdqPaFh5mWwZuJqeDQYmV2YpOvRE9ug33nKTYh8
         l7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G0T/pn0d70jOOapLRyGfOFyEjzcgZRirj6z3vSM+XCg=;
        b=M9fcY4iHItVDk/oJwgieYEd9bjrT3GjrwGTOm7VG4FmFc8ZuFtggUpXdZ4CPcVLeyc
         w4w1bMuAUPvyQhHacpEb7ImcrwpYZYzntsXhNVD2YYwKbVDo6r2fr8LZonSvKSl3A+zD
         NOTgqhUHbDk9yMIj/4CJn6nkibJxCq+0GMcJzZEev4o4VrYHa6jVBS6j4PIywHyp79ed
         TKgvBhINiFe63kVRvhBnLu6NYWdcMcBlSvf59x4jf4ODdsHEs7L0SRNaSBYWrhnZ14ue
         8ogHTSplvGqjz7a4vrDHqMn4ndN0tuwN2SJhpGUoK5HGKbRsQ3Hjev36AB+URPuhatV0
         szvQ==
X-Gm-Message-State: ABuFfohU1z6aQb3hlD3ZBTrUrZz9lJVtWRWtuwoNPHaKqctLT4DxTEP4
        eKEuL+DATf8gSuxzh4WPQLo=
X-Google-Smtp-Source: ACcGV63zd4dsxsTYFRHydYF1FQekG4WFiSj6qIs0AI9MlX5Po4tSvc3emrSYtnRn8T0xjRNcnPRq0g==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr8074854wrq.225.1539432487573;
        Sat, 13 Oct 2018 05:08:07 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id f16-v6sm2732011wrw.89.2018.10.13.05.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Oct 2018 05:08:06 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth
Date:   Sat, 13 Oct 2018 16:07:06 +0400
Message-Id: <1539432427-11779-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables Bluetooth support for the following models:

- Khadas VIM basic (AP6212) using firmware BCM43438A1.hcd
- Khadas VIM pro (AP6255) using firmware BCM4345C0.hcd

The AP6212 module used on the VIM basic has an ID clash with another
device. To get Bluetooth working you either need to apply a kernel
patch to drivers/bluetooth/btbcm.c so 0x2209 loads BCM43438A1 or the
BCM43438A1.hcd firmware must be renamed to BCM43430A1.hcd.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index d32cf38..7e0717d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -187,6 +187,13 @@
 	};
 };
 
+&uart_A {
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */
 &uart_AO {
 	status = "okay";
-- 
2.7.4

