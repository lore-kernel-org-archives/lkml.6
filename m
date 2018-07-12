Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3A4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC66820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="N4jkWKzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuhdQTGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC66820BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbeGLCiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:38:24 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38581 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389647AbeGLCiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:38:24 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2018 22:38:23 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 25E4C2144B;
        Wed, 11 Jul 2018 22:25:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 22:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NrfYnPkuiuZhDakJR
        +pWhWIu4JzsTglHCS/Eh/v5mKQ=; b=N4jkWKzg/zTImvluz309CUWfsnwQw7UTc
        7K3Jx4Gjew1lQ5noluQHBTgxOieMft+n3/msICy3nldoPR9pwJHGjwZ9UDQuxOpA
        8RF1KGT4pHXIew+QHTwx9AHmsh4C+yWdZHwR+kCJ4TuBldSH61eRmwevvcKI8+TP
        jJFVUhouFkAflTaIubXHVG28IoGxGA8ButdcDuG/iO12qcYe+Q27fYZoYyySW9l6
        pgJoxDiRiD0K58MoevODhyAkWMtwRF5oIKUj8hw0Iuyi71pB6MkHtdjHQ7B12FjQ
        3Tr4iaS+vo8JlRCvZ2uIgImZxQyfZb0lo2TZM4uc7ThWoNdXW/T7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NrfYnPkuiuZhDakJR+pWhWIu4JzsTglHCS/Eh/v5mKQ=; b=EuhdQTGV
        FUeShqgVDXd24VBIG4AIDBbJUJoR8p5XcX+d/FjTntdnA2hR1/bT7OIWldYV8tpm
        dWS5H3zoWayIB5hl8Cjm5Rauk8L/c+5SZ5Zyvbz32KGf71p4FPeGqQ9B4K68/Jy5
        q2giG7CJIBVvMEInFJE0MsHH18s34j5aRqZ2FvHk1R+pgaFu85lnXuqDCdGP5Phb
        PngWG3yMBkiwSSSfJEonmSSv95fjdd85QwP6b9UzqMZMrLlc/8DyVcvchZ71lnz+
        6T3Kw2823ioOq2qpjX6K2Tf2RcWQAEu/NAVzr1Z0Ziot/zdHer4bXbEunH4vf6FU
        GtxkVTcDwuBf/Q==
X-ME-Proxy: <xmx:ErxGW2pFn6SpticayGlUbOpBHsrPp3Cxs0jSFI3Yv5gCPxnr_kZTfw>
    <xmx:ErxGW6w5q2PLHfi26I4iOlVK-KcTFZIw8-UO2JUV_uveMPw_xkKKbA>
    <xmx:E7xGWyI7agD-l2wWNi_BvNDGalTu6z3cJrvjilVixIKOAvAfIRml7g>
    <xmx:E7xGW9A22mxgtHbH2R3UxJRLsW00cdguJNqFJxPsBnhqPw0eKJlATw>
    <xmx:E7xGW7tpEdJtST0xL0qBF_drQ41UeqHt3IKM7aId6CrnMQRpucsDMA>
    <xmx:E7xGW2wne-gZ5wPCr1LNvaYZGKuo2JCSQlN0q_JjQ4n5ypdHIfD-nA>
X-ME-Sender: <xms:ErxGWyPYsgDXl9Sb2rmzSFTt6xJNrr11cCNzWE9lYQY6kDyhcdQsqg>
Received: from indium.zzz.sholland.net (mobile-107-77-172-88.mobile.att.net [107.77.172.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 78121E4519;
        Wed, 11 Jul 2018 22:25:21 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64: Enable A64 timer workaround
Date:   Wed, 11 Jul 2018 21:25:15 -0500
Message-Id: <20180712022515.7255-3-samuel@sholland.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180712022515.7255-1-samuel@sholland.org>
References: <20180712022515.7255-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As instability in the architectural timer has been observed on multiple
devices using this SoC, inluding the Pine64 and the Orange Pi Win,
enable the workaround in the SoC's device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..5202b76e9684 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -152,6 +152,7 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
+		allwinner,sun50i-a64-unstable-timer;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14
-- 
2.16.1

