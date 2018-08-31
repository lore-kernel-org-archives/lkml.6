Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D41FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1C20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC1C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeHaUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:47 -0400
Received: from mout.perfora.net ([74.208.4.194]:48945 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeHaUrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:46 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lb2rv-1fT08O3pWr-00kdFk; Fri, 31 Aug 2018 18:39:22 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 29/34] ARM: tegra: apalis_t30: hog group for pcie switch reset gpio
Date:   Fri, 31 Aug 2018 18:38:11 +0200
Message-Id: <20180831163817.23970-30-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:xjGh/vZsWPpbeMBw3BARlG81gaVJ9OqTQywvbSGuRwC1VxkyvHt
 DdkoQYq+I2utRnulT1vT9xf65O5n/NaoSjo3NC2HVvacI3LetY2yIhK/xl8sr6UVmZRTBg9
 7P5qcnGg9GZ+J8YdiylFXc9UdMc6WTJ6nzMymlWle6dAMB8yalzJn33FkMCP7rSCvCrkBgT
 HoEIxiGO4lhQMK0h8eizw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WA9OgZUY92c=:H95ZSwlubUJZWDUtslN8hh
 4QtPHh28kSXpxE9Sz9rUD8UN5iJKcm+abeuggmM/wnI5i88tEbjOFqaX1xjBRqDnIVJYfKTB0
 YoneFfvxycq3KqYCekXgjjLj04dtZo/Bt8uh0vIxbCobn21VK1P7y5QzQFpH243ReowGwMggn
 vbyjg1Kjfeol8+saNbONVPeBEXlTeq3eej3zoh+/mF9aupXVKNxoEU6aHgpabfpx5Eg7UVtUI
 vImyjMn/3JwJF22j89l76yJazqDwnUyoc0FLq3A9B9ySEaB7NQRtfIhM9ITCWIrh685kUcWj6
 YgJbMs3qvzqb7NwcvakUh3A4jJPErLDoLMi4JuN684iWVBbh0+3opCwXJss+QNYt+yVsrwZuA
 wDuWGEFu0RB4uV1GS3dj4ia4R5zndqZDdUj6bOEb2tbWoeQjH/h59yio5pNfa4v3GcfZegOPx
 jqi0535o2l2A7bcFzfX0IJnJuM/JeThIvxAKcAW6Au4Ym8dqLtniSCrCsXdNtin8lYgdxioRK
 1bG2r8+NnforA/S7OBymhOSLZ3jf3rfCQ05yiDrsKgrtX32ZvOGFhXL6Z2JUk6CRZCRczTqhF
 Xz+ifbqRJhHXD8kibpIaKVn4l916lOOhkZGv2rr/mXl9Ruf/8KjLV0xasHATAkvylC5oaHvjF
 LdZGDx2Kn50t5gplx2OAzKU/CpfZhYXuxTrLYgWzhSUr9ZdAclFIRsS57/zrE1P95FZU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The Apalis Evaluation Board uses Apalis GPIO7 on MXM3 pin 15 as reset
signal for its PLX PEX 8605 PCIe Switch.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index bbde98fd9712..9d9dda6c0246 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -240,3 +240,13 @@
 		vin-supply = <&reg_5v0>;
 	};
 };
+
+&gpio {
+	/* Apalis GPIO7 MXM3 pin 15 PLX PEX 8605 PCIe Switch Reset */
+	pex-perst-n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "PEX_PERST_N";
+	};
+};
-- 
2.14.4

