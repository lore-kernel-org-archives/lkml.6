Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9576C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711702087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711702087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbeHPLDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:03:07 -0400
Received: from mout.perfora.net ([74.208.4.196]:40157 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389777AbeHPLDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:03:07 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LloAA-1gPY710pVo-00ZOnY; Thu, 16 Aug 2018 10:06:11 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/2] ARM: dts: tegra20/tegra30: add pmu interrupt-affinity
Date:   Thu, 16 Aug 2018 10:06:04 +0200
Message-Id: <20180816080604.29064-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180816080604.29064-1-marcel@ziswiler.com>
References: <20180816080604.29064-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:cGLiOg2/fUa6c4ORM0lbdno4EKsX1FtZ4a/VwFApu5sjY8CCa18
 cBnP2wIDujXw13B+QWHTYFp69yWG7jk7RMJdZWIC3y/vq1iqtwiLN1CtCdfx+ARK44oYVBj
 M8rzBu1iAWGTlWoNYi12Jwdrpv4Vj20tpijx2xoz+iBtdk1ZwsrXS1t9rEAB+/6Tj29XZ+1
 WPC6E7De+a9fPS1MkGf2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+N8BB+V741A=:kkwgakCkLM7R0DGIbCpwX7
 dbIvPu5AGVF7hEaK9hvDlYeID5xoHC3OAST7QRLn5NF48iI6FvK7W+cSZcycosLWPW5522qX7
 A0mOQ7wqRn31e65SYD2R4abPLG9LSozqzBYSY7Jd19n+kxmWVBl8KMh3oKYDto4IJ3/wCWrUS
 GgX5iBoWIqqBauwmgqS9bF0PjfUHqulmVEM68EfySRQpjVuO7Fo7KG6F4v35DTbgTtJhGPBZk
 sZPgfE+RG0jJQ2WYAnkk2Ru0HkvX/xN5c1QsQsNzBrMMhmVTPdIhhIE/8d3wGwyZ2jA7FVAsS
 Z71KP/TWSyhnaFCNOUR/35jTfhOVEyftVeJm+ulpK3VoQYltxDebe0qg1DRAgq6z3Vova+nl1
 MxXDBLL1Fqcx8H7YXeiMRu8DxXjbESM3ybjc5aze5c7sUw6hnCLSk/hy+YLqR1NXnZ4WiguhR
 pOcFbqI7KdDiWkemZVZ2uv8NDuWCMMyia7GhIzZV2AnH0dZbJzEGNkxRoL7Ic5RPPqBNsOJZD
 BNlbSSBeFOwlV4FXdmdjJ0nBEt3NryURUl5mbnQvybDReAGcMzqtWaYjGQVG9dMq/tLFS2g0M
 334sNnqC0vYART7FEBg14Xotbs6T3gSffKtRf3J7kuX4RvHChtJ47EMDE+lUBSR/uNF4Y3NDB
 NdmvxbDd6qin+wqDsnljruDMDWQNBibV1h1y6nf3lfpTvAylPeDmjB+pt6OVhEWpm2i8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This is similar to tegra124 and avoids the following being reported
upon boot:

hw perfevents: no interrupt-affinity property for /pmu, guessing.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>

---

Changes in v2:
- Add Stefan's acks.

 arch/arm/boot/dts/tegra20.dtsi | 2 ++
 arch/arm/boot/dts/tegra30.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index a22c6a8f8f83..dcad6d6128cf 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -867,5 +867,7 @@
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&{/cpus/cpu@0}>,
+				     <&{/cpus/cpu@1}>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index a6781f653310..1de10f0d1da7 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1013,5 +1013,9 @@
 			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&{/cpus/cpu@0}>,
+				     <&{/cpus/cpu@1}>,
+				     <&{/cpus/cpu@2}>,
+				     <&{/cpus/cpu@3}>;
 	};
 };
-- 
2.14.4

