Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB0620878
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="VQCFZC/f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJBq9L23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfAMCRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 21:17:25 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37645 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbfAMCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 21:17:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 58C172217A;
        Sat, 12 Jan 2019 21:17:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 12 Jan 2019 21:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=BcKEOqrm2Nddz
        dFcJfheN0gw9UIuZWkg3rxvmQZRiIs=; b=VQCFZC/fuHByg4cpT6HXrPggPO7Ya
        7v5IEDVxQpSkqH702Nr1s4JAYbcdkol3j0AwYlfh4DXsKWVJu6aeu6WdntZViEGr
        cKYGOmRx9g/A9t4Pv74giorkqeDx4qsmjrOPGTxNkvYAVWOWYtyXllZDm2U+s30g
        wCw2Y40NPYrJKqcGXFrKmiLQeelJA7aBNcv464toHdGKqKssaj9Ga06vS9UnG7Pj
        JT90zC11j2dqM/SI+lblqWz3IQQqfx87qiKn/qhhOkiSv74fMFDfmBpgzQcfwJFZ
        hStK5QZihYCLG94SuhTGgfJzRTSXks0Kt3EL5AcLDqaVH9qujyMg6JKXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=BcKEOqrm2NddzdFcJfheN0gw9UIuZWkg3rxvmQZRiIs=; b=iJBq9L23
        6lDXPuxV7FsoVVaFnY3c+Sc/+wsLVJCsIzowctPQ4Kt89W15UIaACbxm72T4LzGw
        RSg47CGMKVmqWdoFlCF3AqsADizdNHw8bZgSsug8OxThLWnm8bwDCMDgQNnoY9kN
        nlkmNI3g26PQJSTzYw+nPfgk//LCBlPWsacufHcT6dfbaoPLOVyRMXZTqwFArUQv
        oWx34MVGM+BYBvo78zpG4EkdLXx2nuvwiO3nz/D9aaFvLt//mXBHhpR2qFNCQoQh
        ExIIq/6GJSLRF29mHXwtmXSGGE2plK85c7lc599Hr6AwEFCMBbyYftksKF8gRCDT
        X5KWIrsMAHwNmw==
X-ME-Sender: <xms:sp86XK7GnQHA9uHaHGZsyRJJRdVPHqaqXrcZSZDhFHK9mw52sOD8Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfeekgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehs
    rghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepjedtrddufeehrddugeekrd
    duhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:sp86XB018KTtDKatCu7gB4vrEktSU_R5Kofe4r5HX1Vgcfgs3AWTxQ>
    <xmx:sp86XBApgRBLm_CLOjfcZdkoeYXTHGiaw5bTKV1ZWrD68QOFmKvX8A>
    <xmx:sp86XD3HOmrRMd6Re7jXqrUdDh9oicR3Mx3OuyUSPBmc0uhZzn-Dlw>
    <xmx:s586XOboucBXUXW8COEbY-dWquI3bdp6K1N7Piyn8RdSWcTQSPUVew>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07E8010085;
        Sat, 12 Jan 2019 21:17:22 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/2] arm64: dts: allwinner: a64: Enable A64 timer workaround
Date:   Sat, 12 Jan 2019 20:17:19 -0600
Message-Id: <20190113021719.46457-3-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190113021719.46457-1-samuel@sholland.org>
References: <20190113021719.46457-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As instability in the architectural timer has been observed on multiple
devices using this SoC, inluding the Pine64 and the Orange Pi Win,
enable the workaround in the SoC's device tree.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f3a66f888205..13eac92a8c55 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -175,6 +175,7 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
+		allwinner,erratum-unknown1;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14
-- 
2.19.2

