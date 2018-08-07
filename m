Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C12FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AE8219A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Jyaw/UPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AE8219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbeHGJbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:31:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37708 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388755AbeHGJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:31:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so8124420pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCelP08FJqkgeSCITgTHqdYXaWN9OL4Rj1Xk8c/H9+k=;
        b=Jyaw/UPsctcjLjFyX8sHCy5REoKuKRVh+/S5q8HFgjxbZeDoNweTRl9o+MTvuRAHz2
         UHHwnSGC9J7IjFn4xQ+osaH4KtKbyIia2iou318MFDEFj1+zmVDTmyZzHur7+RZ8+RM7
         SsYJXXSOgZV0NOrNAdRMuQaRshHCdqv+PTPZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCelP08FJqkgeSCITgTHqdYXaWN9OL4Rj1Xk8c/H9+k=;
        b=i59C8QVGKP13mjN7a4OzKGEb2wmW/NrLA1RodPNt6XogrpICnhR+hWWtQydYbVjh6L
         L3tKJAFbgJVx1kvnE86g3lUth3lvPqglgqePnOXMyS9CRRD9QLBnuTQH7+cJ2rJZQgp8
         2113H7/l5evNeMDLBqi3GYjb/AE/GezqkiI5KUjU2uVC80uS4ZM58nCE0UWziLDnqq1Y
         zPBFJN6HKz8Jhyr3IUHR8FCr/mrxuE2bJB3iSlD8UkBR0O85Ac1x5l2lEHvdNYpwlI++
         8MTH4djO0lnyz/lCIUq3msnq1l4vNGCf+muHqF1AX/1L3pFFlzIvxR2NG05rhQePTnBq
         U/tw==
X-Gm-Message-State: AOUpUlGbF7L2q3DB7APO0iYLHbOGS3fODN1MynLZj7nq+r39Yaci/7x8
        RzUxwU0Bw84Lm/Y2inmOE75wjQ==
X-Google-Smtp-Source: AA+uWPxmpsL5CX1Qwro/pV0JR3NS0/tCkVKMHRYz1pc0E8yJD9lPZKEqdSfpJwzuvO8ouIWDmD7fyA==
X-Received: by 2002:a63:ed07:: with SMTP id d7-v6mr1399424pgi.429.1533626329899;
        Tue, 07 Aug 2018 00:18:49 -0700 (PDT)
Received: from localhost.localdomain ([183.82.226.112])
        by smtp.gmail.com with ESMTPSA id f75-v6sm2519754pfk.85.2018.08.07.00.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:18:49 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
Date:   Tue,  7 Aug 2018 12:48:39 +0530
Message-Id: <20180807071839.25305-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet support for orangepi-one-plus board,
- Ethernet port connected via RTL8211E PHY
- GMAC_EN is connected via PD6
- GMAC-3V supplied from ALDO2 regulator

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 0612c19cd994..eca5b7ea0d6d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -21,6 +21,35 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		vin-supply = <&reg_aldo2>;
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_3v3>;
+	allwinner,rx-delay-ps = <200>;
+	allwinner,tx-delay-ps = <200>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
 };
 
 &mmc0 {
-- 
2.18.0.321.gffc6fa0e3

