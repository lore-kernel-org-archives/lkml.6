Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7652083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm1AAAVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7652083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeH3TsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeH3TsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so8531771wrd.1;
        Thu, 30 Aug 2018 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tHWKgVQ+LP5A64YbmsQPQ4TQy6BjNkjDuA1WjJuVxFc=;
        b=jm1AAAVuPY9EOrIexteon5sSq6w2VUiphdwBnzPsfyVT6LIAk9QR/qg4M1GELtOviP
         prOerDSGFrglpAQ8GjsmboVORQgKaEWyNqhlzrNm4FEd8p5IshSNYuWrWDJmiLfL57BO
         meRhdxxGdTx2glX5HXepaEwqTUj+IeAL3vth3OQlmQel6DitQYhA//5Gc4sJhMecLpIS
         3uVbJr/k4HC0yGome2RNhFF+lwOd/kvDzLiV3EnULya0ns/Sz7KFrljAjL9dpZBu+vtt
         kZKwnMYc+i7KJfFswbxm9PdJJoZBTCyOddwFkbmcqK72Hrfni/4896lbD4bUTV6QXhDs
         NCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tHWKgVQ+LP5A64YbmsQPQ4TQy6BjNkjDuA1WjJuVxFc=;
        b=TJE4UO0k+CNywKBK8Ml2Ymkro8lwE6PfWQ2uMLNAkBS2MwgHlXcf7F72N4ZeLqIfTs
         ys7IOj38d60WP6StBmcYbajegplU5i0goxkFjpF3v6ZMNp8BoBxOSZxrgBJA0Ka/S1HA
         gEgsRYbF+W4sgdh4/YJvvGjfnae6gkSePeAV49EIBFnJKUGvmJoC6DvuJc5E6AC6jhMO
         tKi0Tk1gsWwOMFZPFeAxSXojwdTbMUMx9vag5NpAdKmQvRDsQV2AkeEUwHxbIa9gSGE9
         QJiS7dxjBlczXu7KrJyjbDyjHn/h362fapPfEBOe0gUHxPxFbeiXXpbVMvUvQNcVfkna
         4Lpg==
X-Gm-Message-State: APzg51DJH2B7NJhFZ6lij599c7dVKVpM093M7033WMRoCe2Ba0FnmlKa
        +n/h7vSFuyCkH17copi9f3U=
X-Google-Smtp-Source: ANB0VdbABIGLqoYMoOjdStNEiEpxSnI4a5wV60mvWIm2iY431vbsOeGYB+GEp93JCTnxaB51r0mu5Q==
X-Received: by 2002:a5d:6243:: with SMTP id m3-v6mr8147675wrv.179.1535643923775;
        Thu, 30 Aug 2018 08:45:23 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:23 -0700 (PDT)
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
Subject: [PATCH v3 04/30] iio: adc: Kconfig: Update Kconfig to new build options
Date:   Thu, 30 Aug 2018 17:44:52 +0200
Message-Id: <20180830154518.29507-5-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are merging the mfd driver into the iio adc driver we need to
update the Kconfig build options.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9da79070357c..5d0cffd6d2e4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -713,13 +713,16 @@ config STX104
 	  array module parameter.
 
 config SUN4I_GPADC
-	tristate "Support for the Allwinner SoCs GPADC"
+	tristate "Allwinner sunxi platforms' GPADC/Thermal driver"
+	select REGMAP_MMIO
+	select REGMAP_IRQ
 	depends on IIO
-	depends on MFD_SUN4I_GPADC || MACH_SUN8I
-	depends on THERMAL || !THERMAL_OF
+	depends on ARCH_SUNXI || MACH_SUN8I
+	depends on THERMAL && THERMAL_OF
 	help
 	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
-	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
+	  GPADC or newer SOCs (A33, H3, A83T, ...) Thermal sensor driver.
+	  This ADC provides 4 channels which can be used as an ADC or as
 	  a touchscreen input and one channel for thermal sensor.
 
 	  The thermal sensor slows down ADC readings and can be disabled by
-- 
2.11.0

