Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0E02086C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWbTGWwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbfBOPyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:54:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732673AbfBOPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:54:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so5012712pfi.9;
        Fri, 15 Feb 2019 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
        b=cWbTGWwcksU58COyasdg2y9snthOMSvYD3iH71rA5Pdpn9tfRgoiXp0bWDTlhJBRms
         8yO+h/Qx2/g7u4UJXfL79nYJq0fZ2ZnhRbkiGi8qHJBWhQKPKmLr7jzR2Dw9F6Q8thIt
         in82IrQE+5SUt59zfdDabCRNxIwerm3/0mHmeO0wOfNVw5Pv4zt7DrvP4Df+lbhxNg8n
         PcJjm8Af7Vn2Qm4FcYMK5gi2sq20P0r8FXS+Sz6b+77xuw5lFWR9prlP4yDiJzV3BMb/
         kgH1d6GMYffnGbnD0nZKwQ0HXjx6Y7baYkSDTv3S5hvYDFp2CNJLREYj4TCIEVCZYtk7
         wDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
        b=Bl0RYayp+cNybiv9Tk2CvPm0+Sd52QRxoUSsPQDaMFYmQD56Ava/thlc21w9y1wLqw
         U95JxRxHbhulv2Ay0SKnEceDZfsHIlTWs/zW9pmRq6erhS4yBNX2BjXcPQ3eLjR0/yL4
         Ko2EDFMzgkGGIhRmbFdpHnOXxL3ljuVziYfALgdaZzJinu0xTU89L4rVkSDI/+6YlF2R
         NCsWr9/afLX2yGauKKMhzCGQYrezyridzgF2RIcEOlEPxwf+9ud4aHoIIu2IHuf0YBk2
         yMGP9ZWjrRk4ACXSQuUerdJHNsU9ZjnAJnxnexsJMBiDSdrAAaUQm7kiWPVFPrsthpdD
         tOGQ==
X-Gm-Message-State: AHQUAuYADsq2swatbGd2UDUQmIKUtF82SRLZ3j4XxhO/i8SCKT8HoK+p
        aR6dMun/ccTKmgh1mFHGYQc=
X-Google-Smtp-Source: AHgI3Ib7h/RNzKj9f2oMf8yn4Dn9ea2wY/ByCaKy7dCzF/lrDfpnlj1DHWBIUFRtKh+ML3OtyL7bVQ==
X-Received: by 2002:aa7:83c2:: with SMTP id j2mr10375984pfn.119.1550246039438;
        Fri, 15 Feb 2019 07:53:59 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n73sm8130397pfj.148.2019.02.15.07.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 07:53:58 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
Date:   Fri, 15 Feb 2019 10:53:35 -0500
Message-Id: <20190215155338.10564-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original orangepi use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller.
For some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..e7aebaf91ede 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -159,8 +159,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -191,6 +191,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0

