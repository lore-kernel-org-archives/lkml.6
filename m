Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBC7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A23A20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A23A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeGVRrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:12 -0400
Received: from mout.perfora.net ([74.208.4.197]:40457 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbeGVRrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:11 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lebpg-1gMLWm0cXe-00qO7V; Sun, 22 Jul 2018 18:49:46 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Date:   Sun, 22 Jul 2018 18:49:09 +0200
Message-Id: <20180722164936.20581-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:WctzPQebzZlNXSrPqqk9YCjhO+3n4SguLjeveHaB+3ymh+X7/B+
 yBajPf1sF3p37wB4q64woCyaQgiQkQ+KJdVl/KYwjo7zNCCSuS7cCwb0KpZQIc/rMcPS/BR
 0SsyODLDI1ryeWD8CiT28ikGkK856jgITLDJpABvGy8ly+tAF9fM3yk2wsB2xX6LcTgnad3
 PIyztS934XqrYMic3yGyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yVWRZHRueuo=:8ACzw3koy5CJAFjoNh+psQ
 JN6NX4Y67kFw/PK+ekTb5l0qBLYXyA23bjwjhQ6hD0WR4gNqHcfGNjE2aGLAUS6yCVyAFgfyY
 2RffJYkbtWByxvE1tCKJxYKOjBMeqocNnqQTvx0KyBFjKrChcoWNUzC+1Vl3E7ygRyiJAWMni
 4qWpAhO4jDrLtCfcZP5KO3C73APgp4We/gzM0oUN8hrW0oe7Ns2lGYdy9tKyzjKmcypzeHQ1g
 i8lpUUALJgiUi24GuBid98NQ7zcKM2XXWX8uC5jk4YXYCD9RWBMAWm5YWSgp+aGyh6j5yJZbh
 yQoRhcMjIRQcUBltaJU/IV7BdUM2JuB6lkSPKG1NUxmscv31pVLdQDTjD0JXrL/SGKrGrkBT5
 4sRDdnFgWRgmwspa9HokYZn8kST6bnH/aHxO4fTmv7dD8BsXmM1EFS/fBDRFAB6GhGE7tPyQQ
 29g9kLzGZjOxWoOvhjRsOIfBiCY/bMgTF94B+TuOa0dx9fs4ykjW3+grHm05Ghx7u09txhJD3
 OadpvDtTAIVlPWbWqIb9UDqGgd5De5+uy+RcGohDM00rC5wDUlB0kisQkOFTbYdjJr5cOdrMG
 qskPZSeYZmZEXG7BltRTtjLPcAX7zoAAzI8IwiDWUElc9KpiD6LqoW52BCK6zsEdc335Pvogd
 mQn2QKs4RAy5nYYBCa/TwZGS3QqSezAyxvfYsus5ko9UK9k6kLSgXb8vzLKTU5U0oE9E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid eMMC issues by specifying broken-hpi.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 2f807d40c1b7..23ffe6a3bc2d 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -699,8 +699,16 @@
 	/* eMMC */
 	sdhci@78000600 {
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
 		bus-width = <8>;
 		non-removable;
+
+		emmc: emmc@0 {
+			reg = <0>;
+			compatible = "mmc-card";
+			broken-hpi;
+		};
 	};
 
 	clocks {
-- 
2.14.4

