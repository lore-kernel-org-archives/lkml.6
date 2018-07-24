Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5079AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D8920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D8920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGXLtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:20 -0400
Received: from mout.perfora.net ([74.208.4.194]:55851 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbeGXLtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:18 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M3CvB-1fxnVb3IN5-00szNZ; Tue, 24 Jul 2018 12:43:17 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 01/15] ARM: tegra: apalis-tk1: add local-mac-address property
Date:   Tue, 24 Jul 2018 12:42:55 +0200
Message-Id: <20180724104309.21741-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Zmt4BU4oFkTemDM0OJNBzQONTaCG3xJjiplE4Qdy3WuUKyqV5hn
 hmn+F3PnbR05liDPiyrX32SAfhE4wC9cIf8UQj7hF8kK0yQOfXEGeYpsr/zN47igrguHupN
 hvM4ph3fyNm8WO6HnDTeN6b7ysZbDQ87zrctddhEA96P8XSwwpgSQ7ulXccADbsVwdRbEwM
 m7IdxRSWZtjZcgbk9E+3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QqL1I4GywH4=:YYociym02Jzqs3wYHpysee
 O9EUwIH0fTUEMEdeYLCZoB9blBT+nkWc55+SquuZ5aJZ5pGo3R37QneCNP3O/XWuwrq4xXcXs
 rygTz9WMxA4yG+yCYk3pT+2DQd7P/wo51m5jKmsJhiljzD2mJauDKM2eSmS6FB0U3UHttLwvu
 lWltsq6qKLblsWBMoXShwic3+snHXZ03yOibimY9HsiPhSLg2Kom39h5oUrZAeEBHVNFRKqD2
 259DY+pOgDwGTEtn94yBOUR3YNbuVJ6isV1WA+YYTEHjuixFvss4kIc+v2aVGhyvx+uvvUHyR
 WI56GIjs2/ZVG6SHIA1Mo6IcGhQVqrDzuO0rlbgpFgRsD+2C3AfCirVmXNIS4JLo+H7bbu7aQ
 qLcbY6JRegHvfpeGwdItB9QobkMzljndmHo3XnzyFBysrS//JWyvB2p3IqYeLOxlP/n8PgoTN
 eE7Ig8CIUJBZhkJ8n9y1OUrkWIBksx57+ramUiz26zCTPcXzUM9n4C8ywCsn+UpO4WAs7mKXJ
 804wPqjJYn2gP6S06san4D5+hEMF73tfY1UB3yZkPzBPePLCj7iWz4gRc6vD4SCcw70zF8/l0
 NH2Utn+trv3WiBmtnbycucoxWc5VjZXMJNtASPRFzUO4IAoOwY7OWv/nTx31hQPVhnhVZMDUq
 bb38+thUNt2WC7+3i0gK+SNiZPC85Dzq7OSNsddj1Rj5sUvgUm5JIyfTBfunkAdS9tIs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 5 +++++
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 573aaa50fff1..09e3641258ae 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -42,6 +42,11 @@
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
 			phy-names = "pcie-0";
 			status = "okay";
+
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 0f0d4a4988b9..5e7ae5e92fb8 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -77,6 +77,11 @@
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
 			phy-names = "pcie-0";
 			status = "okay";
+
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
 		};
 	};
 
-- 
2.14.4

