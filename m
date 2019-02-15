Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB66C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6021A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUdIkILN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfBONtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:49:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36669 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfBONtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:49:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so4878576pfa.3;
        Fri, 15 Feb 2019 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
        b=SUdIkILNKbrThMwrxZCsayoWOfbdTX2g56JlRBeoSzkw2koyMBpkm7D+A4pqlPqu8j
         6sx0NZck7pEzDzw6W7xd23f8MOesVRLOw6bn43qcPozZou+cQppqxliMNEEg3u3+O67D
         UedNnVtK4cBiv7cFAbdM0AvmVIsT2BVniaXo4nB7aTj7/MNy7iIGju/znkqO0JsQ2nCO
         IV6VwZKto4jmkJ7j1pTDdWTuy1aaU0UnNcQoquE++yEJqOf5oJAICGVrATOg0HkvFEf/
         w1qfKxEkzn8ha8cGZDHV4LTPsL5UZdL11DGKHke694k+Q57okGW6uY2bE1o3ThDu9ovD
         J3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
        b=YlcGz6Dg7YFrIiLWJz2U74aXA3uyB7fJgYdAsEThvUhYlsS+xZbVyDF+hBzsexN3G/
         qs5hRCuGSJD8IBqXNGB9ZBTofTCChXRcUmVIjgL4aFAfm5rw8Lw2RpQDYs/Hb4d/Hg7a
         SsJ01iJliqPbeJhSyvIxbboh6LYOSdSgwEnlhpkSOt+/7iEnJB+7J8YuZChTEglFF3ak
         N7iQPfEglGXgjwgUeIhm5BOweG5EP+G6jy4ilTz6sYwAUfH2MshwzGp/5B32o5zacjq1
         dQ+hFlFl4S+CZSPzXjqi3G+2rGKWtPYivJSTxpoRoXsiCKYmrex5tMIfmawOLvuMOnEz
         42Nw==
X-Gm-Message-State: AHQUAuZjkmYRpL4uXcxjc9O1+2lSDUYolwC4K7KvfvrzCjzrCaDCQOWs
        zmWFTqQDORvbzgVz76V/GbeeczNVS5o=
X-Google-Smtp-Source: AHgI3IbZsCVHGI52vrVzACQkZi2FipVAL9Drh7gLlLvOIgexSuvkL/MdN9BbOT+NL1zwQgV3++C72g==
X-Received: by 2002:a62:a9b:: with SMTP id 27mr9834425pfk.223.1550238585509;
        Fri, 15 Feb 2019 05:49:45 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v9sm8595498pfg.144.2019.02.15.05.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 05:49:44 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATVH v2 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
Date:   Fri, 15 Feb 2019 08:49:34 -0500
Message-Id: <20190215134937.10259-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
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

