Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C020837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTH3nV6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeH3Tsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54893 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3Tsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so2473410wmb.4;
        Thu, 30 Aug 2018 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uL+RlF1B8X/odxljz0MZSNmhjxVAqq2N7EvHMawx/vQ=;
        b=sTH3nV6t6alJ644hRiZ1vJjRhtz7c2syDksMfEE0JxXa+Woh1JxBWUovFdbpuw8uzV
         Xo4/UrH5Li9xXOkir35nIx0HeDLVJKSXIrI0U3KbXNBlIz4731zitPTit7jObJu+hTEd
         HTtHbzNT0rDImceTuciYxQIKotQbzw/DEK59yGvvp6wb/MDsJiejbJ0Djd9Eg8g05g7w
         eokB9Cq3ZUzoIEP4cq2UIS1EhQ5ALtYbQ6HUWfcAGvWIDZAaf2axj7LSm5puMhRvutHU
         rhPI5yleS7mM7Svzn3NR5dK5X4TGHGC7qCdetgr2HpUrP4Q0874BabnexHcftqaT6CDa
         PMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uL+RlF1B8X/odxljz0MZSNmhjxVAqq2N7EvHMawx/vQ=;
        b=e1XX8Jnc8KbjREIPGe3gUvaykPmQjKwSGxu08v1EPssEE0j1geMkzoUnxlyHEg+wfk
         gX5ZzxSkfggd3WIHSFNm9bzpVfPXxA32PpSA4POzKDgLjcmRynTx53ux2f9URkzdBEpG
         UyLzmn3UH+GLbhQD/e/Tz8faCav2prLx0CXjGLn28uBSCIb3PG3ARDI/g251bJU8VTO4
         jmR+g/AahJuV06xOV3BSH/fN8ouyw2iEer6SECiF1y39TXO64wc7EZYzR+nxWqzAVO3h
         JXcA+QYpvu3fFLcJnyNOrOtZufEn33yTaVdPiaHvgVQt3lyeC0cPNECJEKpQYI5h55QY
         hipw==
X-Gm-Message-State: APzg51AMn1QUuif9XaK3VTt1xg/h98rGZ9hSxwGqEko+9JCUgIYde57c
        lfaOFI42a1xbT1+hvciFsYg=
X-Google-Smtp-Source: ANB0VdbcppwMi0pbfqC1/1hcsx8Wa1g8hjNqGUhDOM+NvoVaj4+RzzJnlnPWk8L6qomTrkarfHUCig==
X-Received: by 2002:a1c:1f48:: with SMTP id f69-v6mr2114357wmf.152.1535643948953;
        Thu, 30 Aug 2018 08:45:48 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:48 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
Date:   Thu, 30 Aug 2018 17:45:15 +0200
Message-Id: <20180830154518.29507-28-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 SID is supported by the kernel so we can add a NVMEM Data cell,
that contains the calibration data.

On the H3 the eFuses are located at the offset 0x200. The thermal data
itself has an offset of 0x34 from the eFuse base. So we end on an offset
of 0x234.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 1866aec69ec1..0fc447f0c02a 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -106,8 +106,15 @@
 
 	soc {
 		sid: eeprom@1c14000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "allwinner,sun8i-h3-sid";
 			reg = <0x01c14000 0x400>;
+
+			/* Data cells */
+			thermal_calibration: calib@234 {
+				reg = <0x234 0x8>;
+			};
 		};
 	};
 
@@ -227,4 +234,6 @@
 &ths {
 	compatible = "allwinner,sun8i-h3-ths";
 	#thermal-sensor-cells = <0>;
+	nvmem-cells = <&thermal_calibration>;
+	nvmem-cell-names = "calibration";
 };
-- 
2.11.0

