Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2B4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997D82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkoIaHaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997D82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbeJYXAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbeJYWwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:34 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7BF20870;
        Thu, 25 Oct 2018 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477177;
        bh=whBmUio4rUt6EUq/PVPadyewwD+U6AKPHnLohQDi5do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkoIaHaHaJ2yXa5AuLyU+21LIfAckQgBD7mmtO+m1gXI5Yl1uT7tWX+HEs+NkZKzv
         GJ+eCL7T7MXjnG+VVKVXP2oMTNJlK1+ODdT5r+2p2WTcZgYE40I0z78+dPWuIqeYA/
         /majpbp+sLR4kM9WFeuoBs8wkH2QvDXwAD5DhdFI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vivek Gautam <gautam.vivek@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 28/98] arm: dts: Use pmu_system_controller phandle for dp phy
Date:   Thu, 25 Oct 2018 10:17:43 -0400
Message-Id: <20181025141853.214051-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Gautam <gautam.vivek@samsung.com>

[ Upstream commit e93e54544adf3aa6908b821e896cb17a562cb683 ]

DP PHY now require pmu-system-controller to handle PMU register
to control PHY's power isolation. Adding the same to dp-phy
node.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Reviewed-by: Jingoo Han <jg1.han@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5250.dtsi | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index d55c1a2eb798..251226eefad7 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -732,7 +732,7 @@
 
 	dp_phy: video-phy@10040720 {
 		compatible = "samsung,exynos5250-dp-video-phy";
-		reg = <0x10040720 4>;
+		samsung,pmu-syscon = <&pmu_system_controller>;
 		#phy-cells = <0>;
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8617a031cbc0..1353a092134f 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -503,8 +503,8 @@
 	};
 
 	dp_phy: video-phy@10040728 {
-		compatible = "samsung,exynos5250-dp-video-phy";
-		reg = <0x10040728 4>;
+		compatible = "samsung,exynos5420-dp-video-phy";
+		samsung,pmu-syscon = <&pmu_system_controller>;
 		#phy-cells = <0>;
 	};
 
-- 
2.17.1

