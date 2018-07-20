Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E43ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4E320850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4E320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeGTRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:23:45 -0400
Received: from mout.perfora.net ([74.208.4.196]:58303 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbeGTRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:23:45 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLPtc-1fg0880osc-000c3K; Fri, 20 Jul 2018 18:34:34 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] ARM: dts: tegra20/tegra30: add pmu interrupt-affinity
Date:   Fri, 20 Jul 2018 18:34:26 +0200
Message-Id: <20180720163426.4410-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720163426.4410-1-marcel@ziswiler.com>
References: <20180720163426.4410-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:H6sW2qsS9vq8+E9sAdrYECle5NHmLmJdKWN4fsVrxxjNnNmiam8
 OA/q8FarsQNEZvblDFYTUNeRaqAQiVam0Zk78EB9eZ3uf8H4+Rh+7K0Nc3G+D+igyeG1KSy
 zoyyWqZHi3buuKm0Qw8TdBVyv2ccXMj9D7gttHgbQb8mTRBhMrmaBPdfymMId4x0K125T89
 6kDx8All9/WsdAg3HX3Pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Saf7fdN5HWk=:vDJXLqbB52F47icrStZR8y
 4rYI6clHA7XCzrKTTQHtpS24GgeiCLtfWWYXbb3kCPasXw0CerSJStu9NwYFlYSsMWStnz1Qh
 lR23AOHJCzL+WnhYx/j8GO7q0R5xreDNGqMU9E4vepkxMhiidrQWVBQkrgStxzOPreEUcgnJb
 QJgHiMwHb8ZkAXCoZikyb+eRgmXtQVZqyEjrHaaFrzX9E8Ea5Nv4bhNp24IolW3z5eRQ3sYYB
 v+B+EOeOVI3RiSstbChWgRyUuPvsTQ5l+jG3jhhrVfXIy37JEfJfJ+W99HC1hYAvl2/Pu46cj
 /lxAr4gglbpGHHYtApWlrhRk5RRK5Ps36RRK3LSmJZB3QHx5IEkavDTU9T9+vhBMstr1gQsd4
 tOhnylCeUIWlztyTehvGRDHo2EUmeVSvEf72Uz93f0lI2I4vfFJO4oSJ7vMK6dXeZYki2H3hf
 RijNPW4dGm1R2jyxuscb1LlrJsJSxj8gsJVR6nL0Keh5314MCh75p5irCDsmXhI11oDyghpDq
 Sej72li0m+x9zorbrWRfBpufyMBY0VqdKpCpbRQeQ5Uq/kzrzim0oMfQXm4dXa361c/GgPezw
 j1bNn8kS6nzurlL7WVgamCJXUDNv+wm8HQcu2xVzaaUgxA7rw7LWEp+B0er1Ewiv+DxNODvVf
 6pCWPsHJGLYhh4Rj/moZlpqx1ipC2MdAqPqFv4OmLevJst68hYc60MjnFoL6ddWSQgWk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This is similar to tegra124 and avoids the following being reported
upon boot:

hw perfevents: no interrupt-affinity property for /pmu, guessing.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

