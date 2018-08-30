Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7EDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DF620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjKPkeLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DF620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeH3Tsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42690 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeH3Tse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so8515880wrr.9;
        Thu, 30 Aug 2018 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7fcz895GUsu55hC5nTmUgHw6xA+IJt+1id8NXirwNlM=;
        b=SjKPkeLySCJEK4Y13+HT7/9l6WrLyE/c73c83Fykti/+fVoYb+P/DCvpKQhMPgbbt3
         Z+k6EjZIYPEQm4kpEZTDYryKCniBgzyx5mfO1U8Srco38IgQG23lyT2H4ahmcXZwpaLB
         a59gxBRF4QmavAd9aErhRSafN2cLz3oS1P5JFlEoibmP/muy+TCx+rV6rfWUHKdcot8z
         jgA2TiO6dpZu0WWiycqUHdKQKJk1OoTHdpbCGARMe7Wc+B3YkrhnaRLG9oWgoTexK4uW
         /zUKd6Wc7xMmNmRJAx17ksXQrTL2hfSl4fKz647kiSQzgaJbkJlvSxtrzddULpUt441E
         gQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7fcz895GUsu55hC5nTmUgHw6xA+IJt+1id8NXirwNlM=;
        b=CWgEA6S0tlE0svwFyyqTXCAaX8zc0TWNLiJX7czM/EBIJTT4kdpCym0ELxSm6RHcB/
         fy034QE5ZQ75D03xQoQfoVNja+Oe3nv2/3++o3gmE/j5cbdpTZh4QqzpQRVlhAODWa+4
         3r+RQtMpGKptOWJ1V7cGEQ5Q/HGqFg0V1oiyVshMX5s94lN9zlrTB5G5tTHPXCVvNgE5
         6y2J1o00bjZ0/Lp2yMGAT6ObRwSA2CsrVpIQmS8V4tev3J6wd+yBnbTxk/OMjlw2luSX
         nDFxu7xy98wARYrhW+sTcoEathjEvdB+w88jJumyJcB0PGI7XOfukNVD2THF4bYViX/W
         nQ6g==
X-Gm-Message-State: APzg51A2lSs+8CTaz8qXMzN3yyBDr7ZXiDf6VOwg0d+gMFmxSgc8XFUg
        6xyEYBOHyYcW53DBb1YK3sk=
X-Google-Smtp-Source: ANB0VdYY8IRyJyHvIIx2ksl+ThEEVOKF+FOMBA3dpXx+QuDAFvRk7+O2kpuCoTl06PlR48Or1XA4GQ==
X-Received: by 2002:adf:cc91:: with SMTP id p17-v6mr8042454wrj.226.1535643947922;
        Thu, 30 Aug 2018 08:45:47 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:47 -0700 (PDT)
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
Subject: [PATCH v3 26/30] ARM: dts: sun8i: h3: enable H3 sid controller
Date:   Thu, 30 Aug 2018 17:45:14 +0200
Message-Id: <20180830154518.29507-27-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the the sid controller in the H3. It can be used
for thermal calibration data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 954848d5df50..1866aec69ec1 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -104,6 +104,13 @@
 		};
 	};
 
+	soc {
+		sid: eeprom@1c14000 {
+			compatible = "allwinner,sun8i-h3-sid";
+			reg = <0x01c14000 0x400>;
+		};
+	};
+
 	thermal-zones {
 		cpu-thermal {
 			/* milliseconds */
-- 
2.11.0

