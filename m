Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B711C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4027820837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX+e4XDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4027820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLGTL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:11:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45582 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:11:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so4429353ljd.12;
        Fri, 07 Dec 2018 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLoK8dxaYhkkvoDpPS82xpkVnSH4qU0dp8vtgaAdqTE=;
        b=HX+e4XDBM1RO5xTwGc74azJX8XJQFVhsu+8lpf5ZELaCCb6j5G4/71XpkPiqJ3RCgP
         VNeCZidzoU5ILeX6Mmu/xtwJI1BpV8DWuBCp8nOWBFqKwhFBf3VlNxuL75pOHXcFjHxQ
         NOokIor5Z3jkj8GVU0j6I7NRMqmIRluV5qK2+to0ZziF3F/ra8fxXBF0UPEOgqRd1+op
         pO4NFF/pC+Teyr0vm5X5aTHPdzlqC5klzFsLKg7i0anVnSR35tHUzRM0eQBppLL3yy57
         xfs+SGEUsclZjamACSiZ34EtdMIwn47pR8dsBsR+RQ+sUwzAg+5oPuXxgXfrjOdJKwLO
         VWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLoK8dxaYhkkvoDpPS82xpkVnSH4qU0dp8vtgaAdqTE=;
        b=fFeUOVOQFG+K0PIQAaFS1Aq0O0bdF+pQpL0JpdfOC+npISD8p0SvxIN7lfnGclsSmw
         4f4AOXwb9IP5PfxvepSsZpN60r1ABuHt6Fe3feQ39nwsb+9+iI1BUCCc1XRAXC9lmu/i
         ucKtJ3QHeNiEsVsxb7p+TpHSQXQK44gWiq4OuZe90D8Ilz/vuDs3NCEz2eGoYsH5iiRe
         Dm5q1aFwVqOfAqgldDFmBlu2T4pSPNQFJuaKyV4VVbv9EMOHDUh+9nyEvYHiWR3KOoyl
         oY0SVGt21GsM6HU3a2e9z8FiJBhluiqOnpAEYcs7Pl59IVNuI3biOAwgxSoywexhD9ca
         Yf6A==
X-Gm-Message-State: AA+aEWbY+wJN46hNw62nl48Nj8t4hhomGCM8Sr0JkvYwpIYqxbqkAtuk
        ZKeJ7pf/cBSXiypx2hGjFD0=
X-Google-Smtp-Source: AFSGD/XBeZQPwmkFSo16rt1CctJcoLbztk0UDADFMQLOMWmRwsLXkobD2L6mwE+fwip1oTMMl8RmAA==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr2043984ljh.63.1544209912365;
        Fri, 07 Dec 2018 11:11:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:11:51 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, broonie@kernel.org,
        arnaud.pouliquen@st.com, baolin.wang@linaro.org,
        smohanad@codeaurora.org, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
        geert@linux-m68k.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: Allow selection of Exynos ADC on S5PV210
Date:   Fri,  7 Dec 2018 20:11:35 +0100
Message-Id: <20181207191136.5464-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Make it possible to use Exynos ADC driver on S5PV210 based devices.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a52fea8749a9..20e126ff030e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -274,7 +274,7 @@ config EP93XX_ADC
 
 config EXYNOS_ADC
 	tristate "Exynos ADC driver support"
-	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
+	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || (OF && COMPILE_TEST)
 	depends on HAS_IOMEM
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
-- 
2.17.1

