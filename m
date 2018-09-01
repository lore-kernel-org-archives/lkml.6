Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC20C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD620845
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBD620845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIARRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:55 -0400
Received: from mout.perfora.net ([74.208.4.196]:41359 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeIARRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MAebN-1g2RFB06nr-00Bqej; Sat, 01 Sep 2018 15:05:38 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 12/19] ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
Date:   Sat,  1 Sep 2018 15:04:57 +0200
Message-Id: <20180901130504.14318-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:KQ9RBVHb5DmIpxc0MKKfiuDJDYEe/rRi9GkMLIh8BOAWDeYpNNZ
 fQfRpZSGAViMW5UUTyU8yMJQ5SwcBa4LmXCLJD1ZsQ0YNilO9ZYUPMTqOMbcwCSm2bWaerI
 Rs2JgeQnBdMFZ9HimNfYIdJwe7DneOgb6sEgqWU60gs0Dg7zUc6+qilEpV8dcz6D2E5zMkt
 VhsTDFX4bx29QpFQwoGqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qm0qcABNCzw=:GDft4zTrRWAwfqK+nNqA/n
 VU0+mbpVv2XWEUlYAT3Vp1oxvBgAsJu7Jo5VavDRTD5SAX3xY8q4QHc3Yf2CoWndRd6y2BGTy
 13gqtearPjmqjr2+9hjbyOtZBkUYLv4zNgk3RV7xjMMxP9b6eXJnKy46lKVZZ6GMW7RyTOgr6
 VFQjA1gR98/vwZfiY+NX3L2z+PfynGZRPlKzRHVpKJwMTn0WJeyzpWhEcFQfPPGocLMo33Yrk
 lDCjzuUPBO8MX7rGisWFClzRHA39mcrCOi+6eXmlCHhgSESr043iW849eEbyFar8WSDXmg5mv
 kgGwWpXCl1F3VG9hID9cEDjEqK7ETIds4JSKJYTLarluuM811zpzcx0HftRRS0J3BEFrJ+oCD
 46c3Fz7nXlJeh8ZbwbKZQt2ioz2mBioyb18qoKmDf/lpDW0E1EWhV1kfm9DPM3+RjAub5bZyb
 MQpbB9fBxdybp2b6o6J3VMgA/wgEdpCU3yaIArBdkqegQLq5w8Aw/7J4ugNJ7pvkJX24Kj36S
 an0rC+vP/woULOEG/JiVRKoizvs6/En4CoHKBR4WoUOj5ba2KedAdyzlZA+mYT81HzKfyY0oR
 CPZ1/opiJbnNXHXThaiFLvGVNqB25Y9bkfRrDwAgsw+IuyaFnvR8kCxbDE3zZ9nXQ+FxiTsQ2
 1c5L+K0ly55Q6iL+YNlZ9E4n7H0p1WpTzNuKd/MhRQ+qtRSpIzPwGmsubA+//+8XRAgQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder CPU DFLL clock properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 37e443e21ce6..07dd208296d3 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1925,8 +1925,8 @@
 	/* CPU DFLL clock */
 	clock@70110000 {
 		status = "okay";
-		vdd-cpu-supply = <&reg_vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
+		vdd-cpu-supply = <&reg_vdd_cpu>;
 	};
 
 	ahub@70300000 {
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index f76580f6cc80..fe10c5180768 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1954,8 +1954,8 @@
 	/* CPU DFLL clock */
 	clock@70110000 {
 		status = "okay";
-		vdd-cpu-supply = <&reg_vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
+		vdd-cpu-supply = <&reg_vdd_cpu>;
 	};
 
 	ahub@70300000 {
-- 
2.14.4

