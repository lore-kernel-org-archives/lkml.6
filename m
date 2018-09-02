Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC6C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E7D20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E7D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIBO03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:26:29 -0400
Received: from mout.perfora.net ([74.208.4.194]:43313 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeIBOZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:30 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MhCAZ-1gIBR22tdJ-00MVFi; Sun, 02 Sep 2018 12:10:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 24/37] ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
Date:   Sun,  2 Sep 2018 12:08:53 +0200
Message-Id: <20180902100906.25792-25-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ipKnDjVzYG95N7n7wL/inS2/3hYwnM4ANHk1Va0Bf19JojV4vGk
 esUbhEu3Imw6fP+sLLJHdfS9iQphraLScXu4epgVWqeLKe+TkleSLTeQkHYA2klvgCyKwj7
 W+yl+XKzbvc3V3NNb1IiU5JRv783WnNt2KxvjdkN3jw8VOb46r7X34y/uTKOu77zHka07KK
 ouy3nBfJBM3J0mmlAE+kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X9OYHmP5Vw8=:XeTBXD2mC2B7l6K+RLTz2Z
 2uxOy+i1UPDYV1IqEu7kix2sNCevdgeXhsf0oAnvX4u9MZMMUElLLpt/gutLrXGSwOBjQ8GKp
 rkubUvIPXAjQLhZ1P6cUL3VNsRx95O8g1EdkvTIeMPTgLmbN0PjVi6UKkVJqTKftaBKKP4ZRo
 l6ENep8efJOzBwfESqGi4g0VrjtwmN/8AieAVtSS/jXlaC9cu3SSWIzvSfaRzjI3HRh0IEKPB
 HyuVVkb81XkRWUXhzrhGL4sMtY1OVCnf3iJb1W/7vxThGQp7WQ90Sr8AblNv0nDEZpZny1yHF
 bhY+ZzUDZjU2QmEur54BLdogQxyQLniAuHGrdfwAGhaoDO3THuElGfJWfoYApargy2TmNIbUP
 ceLKR/Y2NXbs9r0kI8fNVErUNqjqhy/dloIjk3pz9Ag0ITNQXcI3ceVtT1RvDNQJG23GpBkYe
 N4tRMvdIrIaX3fpqbBbDAhCoMNK+zH3nuTcABmIRM1VmattbnaA6VZCh8OeyFWB6wVYDd6oQl
 b2Xbh3ZCGhXU6IPGkLxrTM3klJb87DiK/dYzw5LlQ7vtuitwg9VYdakHToxOxKqNHxGv30Afv
 DHRe4vMzxx132sHarMxqiZDljHkxIHtRMBUgl1YE1t6cpJTHFw2PpIEr6/O09X9glTx7T6N11
 9kzG4tjWO7nbx/mWJTUQlEhmS4tzb4NfEz5rgs2Umvc7uy2nU2uKH7oobIF7dNOeOiUo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO hog to unreset ASIX AX88772B USB Ethernet chip.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also replace underscores in node name with dashes.

 arch/arm/boot/dts/tegra20-colibri.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 9ec56f49c30c..281e0dd11565 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -749,3 +749,12 @@
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
+
+&gpio {
+	lan-reset-n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LAN_RESET#";
+	};
+};
-- 
2.14.4

