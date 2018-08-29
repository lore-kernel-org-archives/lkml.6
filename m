Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A96C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B82082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3B82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeH2MK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:57 -0400
Received: from mout.perfora.net ([74.208.4.196]:41527 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:56 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MZF1O-1gDYyV16Pk-00L1cw; Wed, 29 Aug 2018 10:15:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 25/31] ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
Date:   Wed, 29 Aug 2018 10:14:01 +0200
Message-Id: <20180829081407.11304-26-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lznYXJTaAAU1x/F7owjN7D6bHfC3bBGgTagEGgp/C5Ar3Kg1sZz
 sPRkUHA3rRYeOgQUb8xTy9r1s70HcaWTfAz/X6FSfl8+/Z2ymX+5VWMMvU6D8Qcmgj8WuqU
 Ls9+nly1DUzMQ7A05aZgZrs+Is+LIKDMHNrLwbZm49sWHcTGCgGFVdQVEc7y4tVgo8itBOW
 nftMhmtZgJZ1MmZ0jjl8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hV3iWUkIJC4=:dZ6aefjTJx8zu327kyJ/yK
 NW/MmgGYz7wE1I2oVz3NRIDl7nXk/RCFLqrCzVasaKWhgsIq5jbf4xNdhYjk3vD1iajiBhBhD
 L4qKPUgG9KIqRxYj4W9IJ8ZBQRwFeBWZluQAOvdyyIPH3tnEj82FaOeQCQoi6x5EV8/37Uc86
 ImpDhHK8dPMjuVadVwTmU3X+g+1bn7YIgLyy1I+rRUfWmj8HghfdCQyH3UDfRu1tAAQcvQeQT
 8KJRjW1mM1PiDzkZD8q3IIQHAtz8fO9Ry1IAePaJYRoGIM0v2MdciN5ObygvlKQe5WFTqCinm
 8vBEdGLN7H/wKLuxz1vs7LoJkAJhwT/RLCK6NR4R2hhmbeSaYu0GYlKQFR/T1EhaC8TiFVi5x
 xNSNs2YnxM1MdfxV+DJsOcUKhzHie2jCpTGBmA/kjYEnlfWEmxWyQQP30YffM9CGw5vK5aCqw
 CmtyL/TTe2OgtQvBFHtw9XlNN1BE6JjFlsD5Jtd9b8YW61lyNgoBXhcFZPqckMjaaqKeaxaJx
 MYAw5zHc8PkAoXsuCEi8uBmwLcs3+065Iln/dKDubLDU9hHObe1pJ0gqlFENC7fsrZFIkjD7Y
 tZIaXx80NAq2dBA2g8NWjdrldQnRBZf3VWhWLjRizPYzUoJeGja9AELOhTNowofGxEggHKlOx
 pEBSnIsHBnxzu1lwNPW/wcfKjZUA0LmwwglZVI9Q/LOX7qzqf91OctWkyD4xxnS2Lk5U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO hogs for GMI_WR_N buffers:
- tri-stating GMI_WR_N on SODIMM pin 99 nPWE
- not tri-stating GMI_WR_N on SODIMM pin 93 RDnWR

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 339316dd57e9..35eec7ade70d 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -757,4 +757,20 @@
 		output-high;
 		line-name = "LAN_RESET#";
 	};
+
+	/* Tri-stating GMI_WR_N on SODIMM pin 99 nPWE */
+	npwe {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(T, 5) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "Tri-state nPWE";
+	};
+
+	/* Not tri-stating GMI_WR_N on SODIMM pin 93 RDnWR */
+	rdnwr {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(T, 6) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "Not tri-state RDnWR";
+	};
 };
-- 
2.14.4

