Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BDDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E1C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V92Tq2KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E1C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeH3TsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeH3TsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so2476852wmc.5;
        Thu, 30 Aug 2018 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znNWD4c7xwHHzdKt+r4w+sW2qQCB/x6+Cp4Db3nfkDE=;
        b=V92Tq2KDAuTOS5ZXCjBYkHKFg44ritecrZ7ZE5O8ofAH/laW5wgzuFHy5iebseuYd2
         UMiflbVHAilN/P8jgZ12r5Z33fJOFqmsL4031S5dzCt/yLUuyqaCRUvnIsGE3qR+dOws
         SlYVxfX3DhOvr+oPlqQ4zISSUm/awMlTxnw/cmojhxFMzlGqdOmcEP6/47oa8U2og+jx
         vXob4+bNCmF9XoBlRD0EGa6KGRnKDEaDpbxBujheuWRMuHxnceL7XXYLWgDZnnoZVBPU
         hgpLUrjbFe+452AdUNT1DdZSJa/NDd+hug4pGvw2BcRdKgNchVRYzipAsQvLwQDe7NNS
         wbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=znNWD4c7xwHHzdKt+r4w+sW2qQCB/x6+Cp4Db3nfkDE=;
        b=Ai3+TgITTZNnY+pEWGxgx1HzlaMjjiMMTLOQtl2xG738z2ApYVD/vf/FcdpsPI52Pj
         i0OvmVwRFpmElNtmmw0xHKnTD4EKAsSIOfybguI0W7ou8078XXCwPcrrkr97VMVzZnhI
         bzsvcZ7ORUn3ql+DD31fg8KYqa52ZRv7bZ5qTuax3Qeqxm5vZEJa0bfDpg5oZf6hLy33
         X+YoYofuKd6ms81WC/OCbvbdrZMh3K3tz2Vc+iuWKpaV/phE22wikeBWfjPbgr//d7sP
         f/nRA/7D6bu8KmDQY0CNwwR7VMeKBEa/J1ouTplQAzRVJSuNPiRk0W8/3XNGkOpZ7dwF
         aDWA==
X-Gm-Message-State: APzg51BYWc3NwLopvBzAXtiMhpMJVHaFsFNiW4W4Sg8TPzVFBA/PWkU1
        SfqqMqUHlB67ZZ5S80FcCvw=
X-Google-Smtp-Source: ANB0VdZuXnaUMR0j5QPHrOlZECbitDpFtxY1nXAYEg80kpo4MiZSe5qr0nk3dEhEG6VGCPHu5ajrlA==
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr2082908wme.106.1535643921740;
        Thu, 30 Aug 2018 08:45:21 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:21 -0700 (PDT)
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
Subject: [PATCH v3 02/30] mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
Date:   Thu, 30 Aug 2018 17:44:50 +0200
Message-Id: <20180830154518.29507-3-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are merging the mfd:sun4i-gpadc driver into the
iio/adc/sun4i-gpadc driver. So we need to remove the MFD_SUN4I_GPADC
config option.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/mfd/Kconfig | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..c7ab57d65610 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -40,23 +40,6 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
-config MFD_SUN4I_GPADC
-	tristate "Allwinner sunxi platforms' GPADC MFD driver"
-	select MFD_CORE
-	select REGMAP_MMIO
-	select REGMAP_IRQ
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on !TOUCHSCREEN_SUN4I
-	help
-	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
-	  This driver will only map the hardware interrupt and registers, you
-	  have to select individual drivers based on this MFD to be able to use
-	  the ADC or the thermal sensor. This will try to probe the ADC driver
-	  sun4i-gpadc-iio and the hwmon driver iio_hwmon.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called sun4i-gpadc.
-
 config MFD_AS3711
 	bool "AMS AS3711"
 	select MFD_CORE
-- 
2.11.0

