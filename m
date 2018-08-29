Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7520897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB7520897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeH2MKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:45 -0400
Received: from mout.perfora.net ([74.208.4.194]:44013 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:44 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LoH8R-1fSjTQ40Rl-00gFLT; Wed, 29 Aug 2018 10:14:54 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 19/31] ARM: tegra: colibri_t20: use high speed uart driver
Date:   Wed, 29 Aug 2018 10:13:55 +0200
Message-Id: <20180829081407.11304-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:u15gJtoQMjBP6jWDGg5F++ImrH7R0+7HqCneTSg4cXu8hQxuZZ9
 vxdPuMIxwazCxoLbp4rQZ5M59mobIFgwkZ1WuvN9vAxAc3tykbKnASjQJxwk4bYLb/3iUFs
 qmp0BnSS4ofP5oN/PkTyzMnqXkdceQJtLzXzy2D2kwAPt1vFlUPwnuWcyja3QHcRYTqencC
 32r686B3ZuUdOVpsV5mqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bu7NAgE2u+s=:C3HWqXYvnJkb4UJTmvjXKD
 y1WsAjXh0Gg4CtAlD0Dz1wybu3vhCsJ8Yg9v7ZxKVyQLJeRC4080d+1wX1z89sMzkzSdIF0YR
 JIlcAIi3giFF4Uhgr8HQS/oRRB10KVkzBss33q7D9JyRyQjzlhfIMnV39CUmSqlYXYLw/w7qx
 tUvprU6m8xPibUu0EROqxSD9FJ/QvqeZzz/qSN2M/8P9FEY1/OtU9j6ZCBWDpqkSCNE+7E8a4
 gN1M3zWt0yzD4tUSXGV+LdpPdalI1Tj3ljJ5yVT0gLQFCqquM8ko83dOYMXBGywnnrFojmXce
 dzJJMYobo4wdN9p6t4pTPq5lwaYcDK1mzs6YuTAwdOs8jq4RpvUh2Ietd3h2XtHs+juwqCvze
 5HtOskcj+6kJ9zoh2dkAphuw3z235vksmlWhOLDGwgMVGQODGqBkcK6xUPemKOoeE5wtBY+hg
 FSrGaPoH+/yFy/XK+oUJKremZM2Okiu/h6NJ4TBW6wI9dGE2mncdg3tyKGSpbwozulybfL/n0
 TCGosoyCMCAcVGT19tKAf+LJa1G2q1o9bxsrxnkkG7HfmDj28x7+yvsvplbHw27hsRJf2z8Mk
 MRVrw8L6kwmfBwLcUm5sjHMYxM5Ba21vE06Uc6ABuGWMcnCqMyB5LYbMF7MdROr2m21yfCIaX
 z+A097MnqRRtOYnacC2MHustFnijOz+vr1OkXQcKKdAt+8NtxwQ3/4KDZifPbBteNXms=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use high speed UART driver compatible nvidia,tegra20-hsuart.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index a7403ce9ee99..3d61175e2a9c 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -423,6 +423,14 @@
 			<&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 	};
 
+	serial@70006040 {
+		compatible = "nvidia,tegra20-hsuart";
+	};
+
+	serial@70006300 {
+		compatible = "nvidia,tegra20-hsuart";
+	};
+
 	nand-controller@70008000 {
 		status = "okay";
 
-- 
2.14.4

