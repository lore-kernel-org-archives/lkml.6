Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F4C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446620843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1446620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIARRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:40 -0400
Received: from mout.perfora.net ([74.208.4.196]:60545 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:39 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MXoiP-1gRpMZ1UbH-00Wnof; Sat, 01 Sep 2018 15:05:32 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 09/19] ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
Date:   Sat,  1 Sep 2018 15:04:54 +0200
Message-Id: <20180901130504.14318-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:MeuFZFqCKofeD/GfMdF85t3tLAnQJMwjjKyakbKS0WA2bkz5nU7
 MpztQtSuLuwTy/TCdT0p53ZDCwuti2S2pgLEq+VqXz+iziNKHs3TKHU/sFzW3oGYtE6RCcA
 nq/PVM7jTGCvgOVa7takz8bSF5Td9gImBttAgVDatM6rN2Ri6HSRydp7jpfASdEaw+sZPIP
 NWHc5nLpAmbdcUkSAZYtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rvnQWmlDDKM=:9sOusggGjKfLT1M/HhSXId
 axpHZYG0OiPjdv+YMhlm2V8yoCS7pn6FiXORoS5bWfz3RdCAUIW3LrxprFIysWSIBj94oraXD
 DnHU6rnKYqMnJ4oJFALaKfDPuZvJ1RpYJXSpWBoMz6G+wSWDHq6a1vje8aBeUROt2ofbDcRTn
 a9ZR1IsxMnOV2F7lktJ0QbCgv6eH8NYnw0ckfZdGo4bMptsxiwqGnTFci3JiHS77Om+pM/eiy
 Y7MOaM+pv1FljIrmiNBn5UqufJBRrL2jLkohdokDHuqekveHcquzT/m28VqFKDyK1s+WItb5R
 r9NPoNCXqC/H1ExZG8keAcxzKJ0s1JyHlw/42FZ/Q2wsjE33i9z4FaRxaZ6ysev4QUoDRAujm
 5QC9/YQUeEV9ilMsITOZHCtanTd6ju8zagj7NP9/jzhHCsQcrqH3xDiR9IqG5K8s6uYLwJvTK
 +Dsc/0MfHbphWy3KaQU+h4kPi50xa94OStCZO5RJ9iktHTry60ADaufv7CdfZyYGcqXgc6C59
 1UIWuykjoMnbcsAUoccFmebmCa2w0I0j6/7pM/UG36tOmZSsFMngeuESdgxMBet4iAHeXBBjv
 bfBfIrLYVvf//UQdeyz0VZY2/Mm3Z4KnU1hikbIgMCxUPu/yBe931eb7AkIvrujRTF842ExmZ
 yUdSr6afNO1s7kK9nGhw/O/D3AXleWDHkyBkDN3YSLJ1lkrGdUAd7YAelqkmUorpRSnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add proper eMMC vmmc and vqmmc supplies e.g. fixing signalling voltage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 ++
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 14114bc43e38..3408317c0f00 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1917,6 +1917,8 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vddio>; /* VCCQ */
 	};
 
 	/* CPU DFLL clock */
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 955adebc9e90..ba6fc2e51b2d 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1946,6 +1946,8 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vddio>; /* VCCQ */
 	};
 
 	/* CPU DFLL clock */
-- 
2.14.4

