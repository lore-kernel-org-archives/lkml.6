Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A062C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC620855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EC620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeIBOYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:48 -0400
Received: from mout.perfora.net ([74.208.4.196]:45011 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeIBOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPnbo-1g0Enk1ssk-0056rJ; Sun, 02 Sep 2018 12:09:26 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/37] ARM: tegra: colibri_t20: add local-mac-address property
Date:   Sun,  2 Sep 2018 12:08:34 +0200
Message-Id: <20180902100906.25792-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:mRtjbxPOI9lB9IcH8jzIDaVHePlJVbbocP9BlJJPQrnml5Hj3rM
 m9663xzHGcsx5UmFRGKhNRRRKcRHMLfsCQ+y0GRee8QeXMAYWkFCw1Jjqe2r+uecZ7vpawx
 Da4SmxgH+FzAz6vAdGsSMKyrWfRFdJRxLhzAnXTt3+dyC177SLUD6qWQ96w07KyKZjtUl7+
 v+44JCQieMQPKTpaxr7Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BiizVfONw1o=:ebjCU0AbXcGLL7QGHP7jKl
 GRNxGGZV/2YfG6zhNb+9w5A3yFy+iFsuDi9gvD6k6u5FTaJ+Iyd/p3j6is7sAsG8Nx0jPLxrx
 6GXmDjtbC32YPDgDyemJ59JmhXsShnQVRKnjEbva524x3EgchEL1QFP0bBn3uWxZZ1FySsDbx
 C/TRkz4lZeETEifZBGMWcq7Pq6bMG9l2HBjq/kyezLj1vlnbp6Fyh3XHkxTi38V0G0xZDAXpH
 BTb5iaxItsVK4hyZeL7uUJf3yzTDrpc7u3wXby4Qi7ZjCkNMjlR79Nwhz+vEI9t4cnDXcF47h
 Z+eUm9sQUXOhg/l+T95jbjc3HLHXS5qXTIQp2Z9W/3rhfpcaraFO2FpwUGHPoICep35gU4yo2
 CskFDbZn+ZBpxak6TQ5aJzK+RzKVqPeStnYR8ZeEl0wWHwmqckyF6wFcEcweMDKZbW4tpHKY7
 NHg4thAe5vTCRCd6jgkuxs5c1KDM01NI+Kxs7wBvgUkq8lX3GVqawBJlxlaHFc/+q2UKgHG3F
 U0D6hODcwS4XsrPxLLGX/lEJ0xUeOklQayLV5OoJrONCybnhZ7JVKz6gt1DLzsfpkl8ZgtO+k
 OB80S+vMXWcgUzXp68gzb2/KR133KPzZfW9THNoIxfg1DD/pKM1IBAjGHU3jyvUsJriBoprGy
 0spfWmJVsTkEKcHyDoSoPeWwHFR86fKFfEZYy/9Lm1zTPVSYA6ecShqOMJQgsNicTmV0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index e34ab4a76158..ad816fa827f7 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -482,6 +482,13 @@
 		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
 			GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		asix@1 {
+			reg = <1>;
+			local-mac-address = [00 00 00 00 00 00];
+		};
 	};
 
 	usb-phy@c5004000 {
-- 
2.14.4

