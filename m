Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B64EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B65B20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B65B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeGVRrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:17 -0400
Received: from mout.perfora.net ([74.208.4.197]:50381 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbeGVRrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:16 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MWiab-1fX8Pp14tX-00XtMi; Sun, 22 Jul 2018 18:49:54 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 05/28] ARM: tegra: apalis_t30: reorder pcie properties
Date:   Sun, 22 Jul 2018 18:49:13 +0200
Message-Id: <20180722164936.20581-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:KeleIPkIMRgk7vsVjBiTwdSLc5Rt4NHiz1TJ1tNSFnsq0z/zj0S
 g59tei59Aij08pETd4B2IUZAX1178FLIOGomK5SUewMzNohAqH5lYPJt0+ECjH3fm0kA42X
 U0l1KexOn1CDnm1I8mYrL5oQbEkwoIux0XA7P0a6WKCppPcwMjxe7/VyFy1wHTYJgx0eS07
 SPYJP/He3Xc9ukE6g3V8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dGs1jaBsvhs=:7Qnuugtt/34lQPTgtP7qOU
 Br0ok+g2s8VBPj3d9ADzlp9zwNA6SUxnOUzA6vmAQK+4BruzyV3WMpy3NO1fTByRyrPaePLd2
 grK+kidLsM0kguDlQFGgtFxk6jT+KcyN6zKEod2ZyJxEypO23yObxYdDkxOQ6IqvDv0Z6pLYs
 QmgCYVfTO0hAFKCCa3rhzCi2zyl3leIVckZ6k3aX3jLT1Galz1hJjFfDrnGjF/cg0IUEc0aCy
 eQ6UqkUuMZGtCjreCbYTgitKn7LItgZ9gAMTVaemYizi0S9U5A7mDeOpgybo+8Uebn/imBl3+
 Zd3DXgWO8xalqG9sNvAFYQIXWRoneF2/32MMpxjMK+HymH/NtCBpCo2giVo/8VAJN2Z00BTVs
 Mju4F8upJz/mu43fdE8or1Ejlbv/aX85io3+6BHjPoYpq7BpaSgV9QcZDsR+JGiiDREmFXeSd
 ijvy37OiRcmb3gPGHq52TdrUeAOk2Cxk4WxR78j8ktHhpGBLGrHLsK+nheOQ7fNZAKZxOqF2W
 M/kG7zrWV00+qVPzMyVWV8O8faAnDazaR6rq4YGylIsw1bnSK2xSlZVZorgCEcM/HwkLQ6Sa0
 rlrTOgQJ8iV6L5HXIGaF4MYYb0Y4jloYTqrxowDMCwh01acFnKsE8CREnXrz7rA5p1qa3ZKSk
 x/oUPTovKwnc6ksA0Q9GKWNpEkzNxHS9X1F08NAJpTtDtlykWuzXJm37/g8pbX9jK6RA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder PCIe properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 98d702bc3718..0574eda8b3f9 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -16,13 +16,13 @@
 
 	pcie@3000 {
 		avdd-pexa-supply = <&vdd2_reg>;
-		vdd-pexa-supply = <&vdd2_reg>;
 		avdd-pexb-supply = <&vdd2_reg>;
-		vdd-pexb-supply = <&vdd2_reg>;
 		avdd-pex-pll-supply = <&vdd2_reg>;
 		avdd-plle-supply = <&ldo6_reg>;
-		vddio-pex-ctl-supply = <&sys_3v3_reg>;
 		hvdd-pex-supply = <&sys_3v3_reg>;
+		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		vdd-pexa-supply = <&vdd2_reg>;
+		vdd-pexb-supply = <&vdd2_reg>;
 
 		pci@1,0 {
 			nvidia,num-lanes = <4>;
-- 
2.14.4

