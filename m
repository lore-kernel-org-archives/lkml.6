Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6997C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92400218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfAERtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:49:04 -0500
Received: from kozue.soulik.info ([108.61.200.231]:40172 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfAERtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:49:02 -0500
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
        by kozue.soulik.info (Postfix) with ESMTPA id 80697101784;
        Sun,  6 Jan 2019 02:49:39 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     linux-rockchip@lists.infradead.org
Cc:     Randy Li <ayaka@soulik.info>, mturquette@baylibre.com,
        sboyd@kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, zhangqing@rock-chips.com,
        geert+renesas@glider.be
Subject: [PATCH 2/3] arm64: dts: rockchip: add power domain to iommu rk3399
Date:   Sun,  6 Jan 2019 01:48:36 +0800
Message-Id: <20190105174837.19378-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105174837.19378-1-ayaka@soulik.info>
References: <20190105174837.19378-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU device won't work without power unless PMU
can't turn it off.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 6cc1c9fa4ea6..b22b2e40422b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1263,6 +1263,7 @@
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		power-domains = <&power RK3399_PD_VCODEC>;
+		status = "disabled";
 	};
 
 	vdec_mmu: iommu@ff660480 {
@@ -1273,6 +1274,7 @@
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3399_PD_VDU>;
 		status = "disabled";
 	};
 
-- 
2.20.1

