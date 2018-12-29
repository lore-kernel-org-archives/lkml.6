Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2FFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9E520828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lROcxNZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeL2NeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:34:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33636 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeL2Ndm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so19513872eds.0;
        Sat, 29 Dec 2018 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohQaTv2J9kKKkZzf1BMm6V+1alRU++HuBiNVjD/Tdc8=;
        b=lROcxNZtyZz0YqrsCbaYhuDDYoGcZtzQ5YVmgJ28QLNus2d5lKpfUlKr8dLNUKa2RY
         rUoHV9cJfN3s5z5SmmwIrk+shjN6sLo+zzSh324y7Wrpk4oVvOsJchKWn0AkKHI0dDsr
         zOOXGRf+dkBmbRyW+Ba86F/muGL6bBGkEScm+f4tZnr4evTcqXZbxBOzXUdFkwGkaHgW
         yN9o2+WexfsDhYSXcLhOPDkoXaAOe2tBseE48zy4BF22S80/900W/CRLHrF7PxiQ8OBt
         FYRgplwlBv7VqI0v2Gj/mgFB2a1837qBzwQUUoEFebEevMJ41IoQu1zOup8JeiG7gAMw
         4kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohQaTv2J9kKKkZzf1BMm6V+1alRU++HuBiNVjD/Tdc8=;
        b=gZmsfRG9wGwLuSjIZfG2paiGtCe9ihD1IG5ClMVii1QP0Ry3FoVGRp0QeZkh533PK0
         CRgz1ecjEU3WfleTQJnhd/aVborYkFlO0Bzs86RXTQoHiuCE+2TwRFW5pgpI70+7OljX
         JdLAaO8NRwIXoG1xamg3+05a3JvURGqQP8B7sWSR3KstPYa6AYrBqtYE9y/GteTVEYs5
         GHYJdZcCRrau/spyxDf9447jnnwTzDFdEAY8/y9drmosj9/Msv5q7r/VncSoVwVMe/JW
         c+MZFp7fb/XQbZaWc83j7+p7ora6Zt+SBV7Slp3CZqJjMaL69+t+trkPEW0h8ZRnb0vV
         NZdw==
X-Gm-Message-State: AA+aEWZ4Q08vavGgPUD7odEltihePwUAkq7qIOJICV+q6i7qTAneG/5L
        PaN0roEceTErUvz4h7HzcZkO/6Iv
X-Google-Smtp-Source: AFSGD/VC0k1w65VqW7kPDVorcVnCE7blvPxWxkewJShB70llCBkmlHlsRSZBCrWVFmLqO86ITgpgzA==
X-Received: by 2002:a50:b5c6:: with SMTP id a64mr26354856ede.112.1546090420207;
        Sat, 29 Dec 2018 05:33:40 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:39 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 6/7] ARM: dts: rockchip: add rk3066 hdmi nodes
Date:   Sat, 29 Dec 2018 14:33:17 +0100
Message-Id: <20181229133318.18128-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

This patch adds the hdmi nodes to rk3066.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 653127a37..f95ce9881 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -80,6 +80,10 @@
 		vop0_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop0_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop0>;
+			};
 		};
 	};
 
@@ -101,6 +105,36 @@
 		vop1_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop1_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop1>;
+			};
+		};
+	};
+
+	hdmi: hdmi@10116000 {
+		compatible = "rockchip,rk3066-hdmi";
+		reg = <0x10116000 0x2000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HDMI>;
+		clock-names = "hclk";
+		power-domains = <&power RK3066_PD_VIO>;
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
+		status = "disabled";
+
+		hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in_vop0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&vop0_out_hdmi>;
+			};
+			hdmi_in_vop1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&vop1_out_hdmi>;
+			};
 		};
 	};
 
@@ -415,6 +449,16 @@
 			};
 		};
 
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_out: pwm0-out {
 				rockchip,pins = <RK_GPIO0 3 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.11.0

