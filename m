Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56E5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D6E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D6E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbeGWNjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:39:01 -0400
Received: from mout.perfora.net ([74.208.4.196]:40575 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388235AbeGWNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:39:00 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MI7dw-1fjDii1oUA-003sRP; Mon, 23 Jul 2018 14:37:51 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 22/26] ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
Date:   Mon, 23 Jul 2018 14:36:53 +0200
Message-Id: <20180723123658.980-23-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:SIre8d3HCFDocQiqAdhRho9893GVR68ltX6zdbwskX7e7HHDz2k
 J1nWxszLoNYF5TtgScbIivuInMfYvC7w6DA4SFa8lCD4PtwvgoimjNrlW7SyVAWcwbBwWO5
 7cR7ph69PiG5C2BHf3llIGccuJ6ndQAXoqyP+0am+AQebHBK3qQNC2Yxo89LkbuxZyE4vBW
 1JQPZXX02eFkjYAjJt/9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wEbTsX8Yf3E=:lf5ersF07P07d1v85rP46C
 P77xogdpEhU37CPcCiCCW+grVXN1PgfmYA6eggCWIjzHz9Ar16NKCfz6Qkjv8QSzHlsmziUA/
 8DwSNL9egy5ID+HizDVR5O4jLF4utgMdZocLkYnhR8u5FlpPaQBZ918JDyJ/Va4yF783PEMaT
 OB1B+vqFp/gZsnJ6P9TsLKzeTcuJTst90Lb6bHFHqu6sD4keU1lYzGw6e7msYLDySr5QvPlC2
 oO+D/6aNqiyJdEDKDCZkIft6hcq8C3PQyeBB614ox3nZV1v3foMizgBNjCPehaRAWpbTioPAM
 SQqiIT5diRUxp1yyfUiOcZ6CPHFtkoNIDo0qFlTVJhrDc9SyhrCKZTUSsfjeoLVVH3LPQul3k
 6WqfhYF6IOOWLOXFl3Tb3JDKG7IipJpgcp79bbo5ogw9z305WXeH1IF/TpTYclPOK+9qE4seM
 WxQQ68E3dzma4qEhfVqxuWkqcJW9FnBeV1yOpnFFkk65bexQcJhe14Sia4pD35/NImGZk5ZZz
 riKSMbWTaEHmrILtp7neY1tF7ABZ1Z/CW4p+M47v5A3ub/BLLEInajBZM9hcHZKXGWWe/oIfK
 4AVsTsvs5I7N/VV3bgjL1+TogEN4zlADdyZJG4eLKyCYAgYN6k5ZYkL1POk1kwhE45MBChdAR
 Ly6IWCx/jIxauZ5wN9TFzHzL7XkrWj0yYCfPimiBJzVmIm+BGRDYBa1UEjsTpKBtuB/I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO hog to unreset ASIX AX88772B USB Ethernet chip.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index e32109475bc8..7f7a693f6e08 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -1034,3 +1034,12 @@
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
+
+&gpio {
+	lan_reset_n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LAN_RESET#";
+	};
+};
-- 
2.14.4

