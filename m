Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0224C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4KY/wjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB46720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeH3Tsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33413 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeH3Tsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id i134-v6so2158676wmf.0;
        Thu, 30 Aug 2018 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l6QLRCww2N/gUDx4YyzxlMvXx8PICjJAWIzj33m3Y8k=;
        b=P4KY/wjMkYPFDbNjOeAzFPGXuvhGIkJHHgDVR/QUrBYJaPSFyZhLU/OKgDyVAtRfsL
         cwSC1UBpmTYC4KGzF43ZJNLd6bYwypq0T2oubDiL28AaiJ8wjL/FgxTn6rtbyrS2nnqz
         wRhinzDJs7882wZMTxrM5fu2QqFdfSRgns+WlBW7PhgOBoECmglfi85eFUZEKCjuBVy+
         bhL4hdRKCHKMD7QwvrYawCYayaIMKVhc6ZhkzwTUIpMK+kmvcFs+OSQ3DSxClClQpnz5
         5DKEEWANnKfCgSsYXHh2nXpcoQWGIP51an2xdKrHm5GroqXHhMEJI49pLwx4u/svWKbO
         7HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l6QLRCww2N/gUDx4YyzxlMvXx8PICjJAWIzj33m3Y8k=;
        b=Bpz3LV6h0oC/61v1xUJUPqc37g/SZ9uQA3nvdkQXDJ+xfVLKx15nu8PlhbZl8MF9zk
         PwfQviFiXh4YGFoEKCqsMPMYKF/zjSc5gX2vnf9rvL+RjNPEBKC1606TIUufVyQUXdLQ
         ApCQfyrGJmUU41wrymgL6ibbPXclrpc8zL+MbePwjPkA/9UdOz6z/8EQtg2Gl+O6koIv
         nIzDYOODuv0DwJ6wH6P1T7+eKahwR2BdSzzJkNjQm69LOz57l6cakNmRezfr6K1V/Q4E
         fQD8zptIYMLe+rjZyUQViu9Ic6+TvxPo4wJG4hYHDgGqWDQAA15Oj6htYiFoMbJLaE7H
         y4mw==
X-Gm-Message-State: APzg51CiNurjcgwLMFEwbDaeA/7FG3hO6BKwKOn5xSD6TU+3J8saWpvR
        Th554tpI2dRs5GTu2ksH8gI=
X-Google-Smtp-Source: ANB0VdatYCV55jeDhSuK82bQ3CoqrHQ8yzytm678XM5qd4qnGTaM7Jb2ZLl8iGE3cli+4sSVNjUMNw==
X-Received: by 2002:a1c:b80a:: with SMTP id i10-v6mr2123262wmf.30.1535643944392;
        Thu, 30 Aug 2018 08:45:44 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:43 -0700 (PDT)
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
Subject: [PATCH v3 23/30] ARM: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
Date:   Thu, 30 Aug 2018 17:45:11 +0200
Message-Id: <20180830154518.29507-24-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have gained the support for the thermal sensor in H3 and H5,
we can now add its device nodes to the device tree. The H3 and H5 share
most of its compatible. The compatible and the thermal sensor cells
will be added in an additional patch per device.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c3bff1105e5d..3520e4ad6042 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -488,6 +488,15 @@
 			};
 		};
 
+		ths: thermal-sensor@1c25000 {
+			reg = <0x01c25000 0x400>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_THS>;
+			#io-channel-cells = <0>;
+		};
+
 		timer@1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
-- 
2.11.0

