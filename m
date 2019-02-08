Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D69EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811821916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549667166;
	bh=RKeYqyX82OZ4vC/YqDjtsL2Y4oWIh6XE77hXUdP9Fu4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xmZbNYCgwzHfc1aY7fQI3XaCyWUvNPHAn/ReVxpMpw4udIGBe77UxpR5XofCB1OHa
	 c9Nb7vamvGzWb3eLQS4EDTgBXrFO6bwau70zxRKiLc38wig+B/bZXsXMb9YDjj5su9
	 ArMBlulAqknNyYc6Js/gU3trbIUTBai2vZRBM93I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBHXGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfBHXGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:06:04 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C28421841;
        Fri,  8 Feb 2019 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549667164;
        bh=RKeYqyX82OZ4vC/YqDjtsL2Y4oWIh6XE77hXUdP9Fu4=;
        h=From:To:Cc:Subject:Date:From;
        b=Be+y5TiDxnAUeVC3nXGEzvibJHr8aLh9FuHuIBJIJv5TFLLWQPuFPt9KcWhfWLpo4
         I42jM53Wzf0ZtQgDD5luR9yruC3XtP4SUHDqHF2dPUdDsM6lhvuKuapZoWfZV6QaRQ
         dMIxchZftI34SXAMw8xeuqiKFprSUSPACVgxYb94=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] ARM: dts: exynos: Enable ADC on Odroid HC1
Date:   Sat,  9 Feb 2019 00:05:57 +0100
Message-Id: <20190208230557.9292-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odroid HC1 uses the exynos5422-odroid-core.dtsi file as a base.  All
other Exynos5422 Odroids use the "common".  The ADC node was defined
only in the latter.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 5 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index bf09eab90f8a..9b0bccb77be5 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -36,6 +36,11 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo4_reg>;
+	status = "okay";
+};
+
 &bus_wcore {
 	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
 			<&nocp_mem1_0>, <&nocp_mem1_1>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index b299e541cac0..5f195ad7e467 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -362,11 +362,6 @@
 	};
 };
 
-&adc {
-	vdd-supply = <&ldo4_reg>;
-	status = "okay";
-};
-
 &hdmi {
 	status = "okay";
 	ddc = <&i2c_2>;
-- 
2.17.1

