Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE66920851
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZfMn0eux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBZMOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:14:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39650 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfBZMOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:14:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so13691879wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8SlkkWNbz8a6Pc/LUbBX1rm7FrHNXiQoSoIVyFdUZw=;
        b=ZfMn0eux0oXgg9c8VhkoRGJQxArXR9Kdj9tv6dJIE7ZZS5Il7bmZR8+TDVifji3w0l
         ICQ2uiCbf6uGlUiLlwPX8AA34vOvJFHKqVRoNmWG93XzN3PBCKHPOkikVep0KCt3xTxR
         e3Qc7D4tZkOn4KUBFPXUPsOtpYmlqaWyiMJBcvxPxSOv+8bUVGJW5PXrZzXZWSNf+dYE
         FfZem/PClK0U5Rjqxl/ucQf9mZ1dEsw87Zh/lEASi4L80vRmFbvSXnVnlfMmbdZBdL2W
         Rm5f32c0Xso/KSgZM/+lAsBiMY+cYm0eWenYBiOICk/DdZkgq2E2FIQGdm0ekzysT5Y1
         wNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8SlkkWNbz8a6Pc/LUbBX1rm7FrHNXiQoSoIVyFdUZw=;
        b=dGqUcuen2d3piMJ5FiY7gP0551rbBYqc5rrfM6kxM1E5NiBDYTL+YGf/TQxtaUNapJ
         tWavg96nLm0dF54ZZjg64WxeAiCzpX9yuhSNLJXQlpWwdNZflsg9PHQOiZ2yfHEqIzmb
         Y6vInp6qxTUQYL3yVlxEvPwEnkmM7mGgxN1Zekw4xhqzJanksdEfmpa+NBDxpZSaxHPT
         lgUfDFGNorBJyrqMUDjx8jGEph06xZTKX9rzNbhp3EqH8mRNlV0tUTHe7Ki76cXguPF/
         5CMNZn7wu1am2InJiA2cKwQETg50EhQc5SVRWhUr0ds2dYTrKMtQ6GDHvXkGylmSxagF
         Ne7Q==
X-Gm-Message-State: AHQUAuYoye/ThOPwSFiotIhfCZs1RnGGNK9jKsD0WCNCOJYPetT0cg5s
        Gevkvyitfo9fwy+HWVzFisS18A==
X-Google-Smtp-Source: AHgI3IZtG3oFydmOm+FOSwFoHfcKMng7v0mNlYX1bEI5qpae3OWdODXh3TFE0a2NxnpW7e/7bBGYpw==
X-Received: by 2002:adf:e3cb:: with SMTP id k11mr16635882wrm.263.1551183244174;
        Tue, 26 Feb 2019 04:14:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p1sm11401877wrx.50.2019.02.26.04.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:14:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform build
Date:   Tue, 26 Feb 2019 13:13:53 +0100
Message-Id: <20190226121353.19413-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226121353.19413-1-brgl@bgdev.pl>
References: <20190226121353.19413-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add all DaVinci boards to multi_v5_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/multi_v5_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76fa26d1..d7b2dfe11b05 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -14,6 +14,18 @@ CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91SAM9=y
+CONFIG_ARCH_DAVINCI=y
+CONFIG_ARCH_DAVINCI_DM644x=y
+CONFIG_ARCH_DAVINCI_DM355=y
+CONFIG_ARCH_DAVINCI_DM646x=y
+CONFIG_ARCH_DAVINCI_DA830=y
+CONFIG_ARCH_DAVINCI_DA850=y
+CONFIG_ARCH_DAVINCI_DM365=y
+CONFIG_MACH_SFFSDR=y
+CONFIG_MACH_NEUROS_OSD2=y
+CONFIG_MACH_DM355_LEOPARD=y
+CONFIG_MACH_MITYOMAPL138=y
+CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
-- 
2.20.1

