Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB50C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C112192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Y8ABFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfBONtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:49:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfBONtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:49:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so4875441pfa.6;
        Fri, 15 Feb 2019 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
        b=U1Y8ABFNe6DijqVmeFghi1ptQycTLD+AneOaZGTppxTLyooSw/+mP+mPaQPTgJ5jLg
         zGJBTFfultmw9FNXiUzJ7NbKw5IbHOq07XuI73OTMPZcYsmyMY4b0+SifPOpik0+VWVe
         3lp7eFdrtkAUz2tn90iufIslKWgaEMd5thLSbi0ru6lnRE7Rvnbt80bTlMFqGS5FC/yO
         bBvBw/C/ui0AcQm2amMXlBDDPimk3rHUJAGmA55oRh2OakBUbkaxOicGmYyEL7fhub7R
         A3VvbN4OL3YzjuEjlJUgT45g67RVDhi4dv2sRXKMlO+Rux62gGm0+/slngYHCePB9hWq
         K5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YN48q3Zw1C88JTVxjBmspop5bBKX5JFTmVnaYzS0vaw=;
        b=UEaHXaIszDdkewV7iCbUjPtqH8PO8Skkq/tFT5DLKpmSfRt9cful9e6ePW+VeGdPoT
         RqKfBA0O9aP4308Bel6oprsLX5QXcXSr46aHfBIXlCmvoA4PDqgy8Vx+aEWdWAgOUuj0
         XcdOsJvrIgNAa7rvOGAP2t4rhWWboPyrMiEPJqQc9VhSzr7ZjpxakaSlHkLhHF7W67/A
         bgTx3fKW0YKFUTOcFqiGeG3NkrNnU5Nrxx60vgB2yRMIsCww+XoAJJ690mbl977NFvUK
         UGQLN2/hGL0FHI8z2BkjICXUTzYDyX3xPTpMcF8kpDOGMskWgAb8vj1szIS2VfPMjz6g
         NVtg==
X-Gm-Message-State: AHQUAuZ9nBzxWM/97zQwFemrW1zxFbJ29yCMjPYQ7OTiacO/yS6PDJtK
        Qiyq8DkqMC9Hh9aM9WTWA58=
X-Google-Smtp-Source: AHgI3IanpSBU/woZi/rbo/sAUBkkZZHXhkf3OiaM5s7cI2TzXZ53uDCHzdYMrtQ9WKuwbM7l6bm5cg==
X-Received: by 2002:a62:e515:: with SMTP id n21mr10020282pff.159.1550238589121;
        Fri, 15 Feb 2019 05:49:49 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z62sm13122129pfi.4.2019.02.15.05.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 05:49:48 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATVH v2 2/4] arm64: dts: allwinner: h6: pine: Add CPU supply regulator
Date:   Fri, 15 Feb 2019 08:49:35 -0500
Message-Id: <20190215134937.10259-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original pine use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller. For
some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..95c81250c2b3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -213,8 +213,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -251,6 +251,10 @@
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

