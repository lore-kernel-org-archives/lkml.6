Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B389BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156B2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="QNLv8Gki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeLDPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:20:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40234 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLDPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:20:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so18385902qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EX3c5Y9lXJnREplZdsnECwQbW9mnnjIxQ7nV0qALrUg=;
        b=QNLv8Gkiurr6cbuowHLsrFgH2XzGVcc0CmEEkq+NymsNAqqQpwP+mpqXtWu64vJRHi
         7VfKGIHC8mPTr9tLu7a9A4ky36Ry5oIrVJVWIuhEniJfZn7SGdQzyYaDNdj426OptNln
         vlKBBCEeVbZWRgn9S8WlWYBak1oAgd8BiwVGNyC+pf2n4kr/M9a68/cC3beQSrXNyiBo
         i+ilq9Arwg2mZ0oVI39u8BwfLG7syHixyidDhrMRKXwCOR2luUyYAJqxcysnGarAtKKS
         GE2mI4CF6p8phQGyKNaPkJGjTTxSzJf+2XNUQUzaKfd68dpTIu/iNJIT7RzRUDr2XZlQ
         +3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EX3c5Y9lXJnREplZdsnECwQbW9mnnjIxQ7nV0qALrUg=;
        b=nVlv08s67CzBbKidTjZ7TaLHZypDYmiF6WOG+WSKiHuH88g/kB6LxCZV3Elya5X1NW
         bQzJ483V0uoLzI5jXlr7xf94heU6rekSswYhJAj41b8KxJKyKiLb4FwHInvMO9O21FLr
         64gMbw7MYBkpwyCAaRDk4erodl2WTsFEqMTmtfBH3G++p0gw07x4JSo8nagUNL6nGaF7
         P3eLZ/GAfp1lNjx+/aN7nMxXjvWM9D33J5bXzteIdvX28NNz3GGJNCbphPvXwSUvLHcb
         1gIYsFsZbshxPqaA9Hk6ODc1e5CgC0C3avXa1W6WLFB+UgKt3CrrLYatmU0nYuJKCNy/
         AbzA==
X-Gm-Message-State: AA+aEWbegNPi8HMNnHQhU2XDvjShqae89Mjqb17fmaY+D/aLJHtJpHZ7
        aqkKMBUCPvtEUPqskN/vuHeIfw==
X-Google-Smtp-Source: AFSGD/UXObyrRY2xYO3H15lFdmsPa+wIRhM9ekFvjE4M3Yog7gYq0XtsL8VHHeCWpy9dEhf0gsFZuA==
X-Received: by 2002:ac8:3879:: with SMTP id r54mr18998707qtb.69.1543936803885;
        Tue, 04 Dec 2018 07:20:03 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q17sm11053989qtc.19.2018.12.04.07.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:20:03 -0800 (PST)
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
Subject: [PATCH v4 4/5] ARM: dts: imx5: add gpu nodes
Date:   Tue,  4 Dec 2018 10:17:00 -0500
Message-Id: <20181204151702.8514-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204151702.8514-1-jonathan@marek.ca>
References: <20181204151702.8514-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, now
supported by the freedreno driver.

The compatible for the iMX51 uses a patchid of 1, which is used by drm/msm
driver to identify the smaller 128KiB GMEM size.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v4:
 added commit message
 moved to follow address order
 removed frequencies, they are not needed as clocks have fixed rate

 arch/arm/boot/dts/imx51.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 67d462715..14dcc5a41 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -123,6 +123,16 @@
 			reg = <0x1ffe0000 0x20000>;
 		};
 
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.1", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+		};
+
 		ipu: ipu@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 207eb557c..d7d5fe4c7 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -209,6 +209,16 @@
 			};
 		};
 
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.0", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+		};
+
 		aips@50000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.17.1

