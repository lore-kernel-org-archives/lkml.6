Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B642C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D668F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbvr/F2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D668F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeH3Tsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37233 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeH3Tsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so8500295wrr.4;
        Thu, 30 Aug 2018 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3W91bGBF1HpXiJKP9B53w9fhR17jbGJS1HMpVllHUDg=;
        b=gbvr/F2HG8fxSR5G3qpM1w/HDHaOhquocX4t4s4Iriv1Oag0KkMCt9kVdUenhdLo7z
         Vg0c1ulZlgLpzC/nCYix1MfpC4qwbWUaTHI0/Poj2KgrmM3d4dDxW4hilvyjeASrCKEV
         SK6WKzwU4wLyE/w8Qd4m+b2+YXhn6i8oQhnfhjIX6cdMk4P+HQrE4rE/q2NqHWFzbM9l
         bZryZTbOSAMUpVzoRSDO/xe5wN1yuZDogc4vD2TBED7YswaCWPgwbH/RBT1HI8MkDKdw
         FexGMW99YGWdbO8Sm5ayMzwuG3q+3GGuyAtHuLgyJo9DNth2OPHQrPGo6od3HbOj/DWM
         4Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3W91bGBF1HpXiJKP9B53w9fhR17jbGJS1HMpVllHUDg=;
        b=RppLhabFFiGUhH4YqLQ6ketMYhWAA0WmA+jqkekXUTmraTJu5NjmQW/8aBWOMmx8bB
         PLzoy9Ptk8rp6BFwoVooK4iSYbu9Sq60g6WUMPyzugrQqKdh+S6hPJSH0aAefVX0ubI6
         Crd8YsKREOKQrDCl+SKoQqnnza1dfSlGEw57qog103elsn5amaX/sBdKnwZPfyokmfhS
         yNRTs9K/Kp6jycp9eclJgrSEh+Vb/3OyWtfd7DjJFMJh5HYYJLgl5BBVhozspll99mgY
         TfKBSjm/SWPlBX4R59R8gTHR62TwEc0LZKATNIRn2cOf5jhRGPwgZrIiiPT9F5drmAgv
         s4Iw==
X-Gm-Message-State: APzg51Dr5V53pI87Vp7vQDS0XihINYdOzCuhsNmpAfTxGq5STScybG0O
        BDF9pqmhqv0As8ZUJIoMRmM=
X-Google-Smtp-Source: ANB0VdYplH+KyHB34+f5e/lpoUakLxXB/+ITZhkOm7a8OcAvHUtBBgtm0J1cFOmXZ/SchLPMerKIkw==
X-Received: by 2002:adf:824f:: with SMTP id 73-v6mr8055934wrb.130.1535643952128;
        Thu, 30 Aug 2018 08:45:52 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:51 -0700 (PDT)
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
Subject: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and CPUfreq
Date:   Thu, 30 Aug 2018 17:45:18 +0200
Message-Id: <20180830154518.29507-31-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have now thermal trotteling enabeled we can now add the full
range of the OPP table.

The operating points were found in Allwinner BSP and fex files.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 78aa448e869f..ddcf404f9c80 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -250,6 +250,22 @@
 			opp-microvolt = <840000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <920000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1800000000 { /* BOOT FREQ */
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1080000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
 	};
 
 	cpu1_opp_table: opp_table1 {
@@ -303,6 +319,22 @@
 			opp-microvolt = <840000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <920000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1800000000 { /* BOOT FREQ */
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1080000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
 	};
 
 	soc {
-- 
2.11.0

