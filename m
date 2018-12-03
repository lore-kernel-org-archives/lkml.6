Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E99C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A4220864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="KTJEG6/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A4220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeLCVVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:21:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39669 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLCVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:21:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id n21so15594716qtl.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nESaeaha8h52I+/daK2v+IFiza8HEsTIFWyRHl7bcl4=;
        b=KTJEG6/pmpCBQHZi/S0+c2+4iN1lmItwIGA3kvNgX4W3UaesMSiD85++dw5oEuFsZ6
         o7Wiwz2GhKoZgcxhfcgXxt+k1A0Or23UsLWRVCx+K/D00ngY5+XCVUJY1/h9adm1cU0Y
         T8L4zLDtiykvvRYkUmoVNbeMl33dJIUxWRqUVexXWlhaKgyJlYLobKk1GD8pvSYk9srj
         wlD8t+sIRxZ1+oDoBHPd69BrMI03tZHhstcDcyBZ5KWVwoofCgDjLnEaOMstaHiDyXpA
         i+TZ5EXRfQAe/TXrOUlcYcITBCXffHDhaaAKYkbyyyaj2InDfi6zIjA0RYse5+j9nbij
         OVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nESaeaha8h52I+/daK2v+IFiza8HEsTIFWyRHl7bcl4=;
        b=KmddPwkzciJj/TS1zKIYxsbIrom6qK5N2OZsI5+NnWSy2eWmjOoQjyOv++dy76c+bl
         oLQzSOzxzP8SpNJ1VMDQbjLUk8AeWilqNl9SWIRi0Y+HFgp2jVn7pmmMIr0X8FFyCdPu
         PhwOmM95iMj3Vc+blpS8LF3Qq1dbWu7ZSUTjgadlPl/pDwpN/nH1WfXGkMvhiXCuW/Yr
         HKtkzh5/994Eos1+oMjHZatl2lbm7QCJ5/xWSNCHZR5xA45awD4orVgJ4mfKMqc74yGg
         02CEBST/7PhiPByvfJZ6jZe0B6b2/KXowUFHyUlBjwPC1vxgK5BINlISi5PvVgoKr99V
         FxlQ==
X-Gm-Message-State: AA+aEWaI+lPdgQ8yJ0SHTR0xLAqJOc1ptxn05CAe8WS3FsP+Q4xKebsv
        wy+gFySiqJ9PSdOYR9S2UY+Lfg==
X-Google-Smtp-Source: AFSGD/W68sSsiIY627/Hp7yaghpXz85KuqKq+KhvmoO2nlO6YgIh7eYJ2AsfYS/yh+qNm3/+YdAEuw==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr16495109qtg.326.1543872074162;
        Mon, 03 Dec 2018 13:21:14 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id l33sm10567353qta.57.2018.12.03.13.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:21:13 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
Date:   Mon,  3 Dec 2018 16:18:16 -0500
Message-Id: <20181203211816.5129-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203211816.5129-1-jonathan@marek.ca>
References: <20181203211816.5129-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 67d462715..e9a7bbce9 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -628,5 +628,22 @@
 				clock-names = "ipg", "ahb";
 			};
 		};
+
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.1", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+
+			qcom,gpu-pwrlevels {
+				compatible = "qcom,gpu-pwrlevels";
+				qcom,gpu-pwrlevel@0 {
+					qcom,gpu-freq = <166250000>;
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 207eb557c..586d45586 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -838,5 +838,22 @@
 			reg = <0xf8000000 0x20000>;
 			clocks = <&clks IMX5_CLK_OCRAM>;
 		};
+
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.0", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+
+			qcom,gpu-pwrlevels {
+				compatible = "qcom,gpu-pwrlevels";
+				qcom,gpu-pwrlevel@0 {
+					qcom,gpu-freq = <200000000>;
+				};
+			};
+		};
 	};
 };
-- 
2.17.1

