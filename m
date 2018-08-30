Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9071C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0820838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiv8gZKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC0820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH3WGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeH3WGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:06:03 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EDA20658;
        Thu, 30 Aug 2018 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535652163;
        bh=uY1e8MIqbbCOExlB16wcQXYE45K754nnczrbVFIYeB4=;
        h=From:To:Cc:Subject:Date:From;
        b=iiv8gZKDlYE2CenRZw8a7YWZrIcQN5qfKqAkGnzHhELgPfv+HPHHjLLw41x5qsVYG
         WQrwtvMUB6MAUMLSSKPOQWltzWVNYvASQHusmp2Mx2jtPUMLa7CVpvLbcsVXpOR/9g
         K1cGSncyOq583KKF7YtXZ1y8GqXAKPsqIZDNGBxs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC as unstable
Date:   Thu, 30 Aug 2018 20:02:05 +0200
Message-Id: <20180830180205.18121-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Exynos SoCs and boards related bindings evolved since the initial
introduction, but initially the bindings were minimal and a bit incomplete
(they never described all the hardware modules available in the SoCs).
Since then some significant (not fully compatible) changes have been
already committed a few times (like gpio replaced by pinctrl, display ddc,
mfc reserved memory, some core clocks added to various hardware modules,
added more required nodes).

On the other side there are no boards which have device tree embedded in
the bootloader. Device tree blob is always compiled from the kernel tree
and updated together with the kernel image.

Thus to avoid further adding a bunch of workarounds for old/missing
bindings, make development of new platforms easier and allow to make
cleanup of the existing code and device tree files, lets mark some
Samsung Exynos SoC platform bindings as unstable. This means that
bindings can may change at any time and users should use the dtb file
compiled from the same kernel source tree as the kernel image.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[krzk: Explicitly list unstable bindings instead of marking entire
Exynos]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---

Changes since v2:
1. Add tags.

Changes since v1:
1. Rebase
2. Add specific compatibles to mark unstable.

v1 is here:
https://patchwork.kernel.org/patch/9477963/

Previous tags (not applying due to change in contents):
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../devicetree/bindings/arm/samsung/exynos.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos.txt b/Documentation/devicetree/bindings/arm/samsung/exynos.txt
new file mode 100644
index 000000000000..7410cb79e4b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos.txt
@@ -0,0 +1,26 @@
+Samsung Exynos SoC Family Device Tree Bindings
+---------------------------------------------------------------
+
+Work in progress statement:
+
+Following Device Tree files and bindings applying to Samsung Exynos SoCs and
+boards are considered "unstable":
+
+ - samsung,exynos5433* (all compatibles related to Exynos5433)
+ - samsung,exynos7* (all compatibles related to Exynos7)
+ - samsung,tm2-audio
+ - samsung,mfc-v10
+ - samsung,exynos*-mipi-dsi
+ - samsung,exynos5-dp
+ - samsung,exynos*-hdmi
+ - samsung,exynos*-hdmiddc
+ - samsung,exynos*-hdmiphy
+ - samsung,exynos*-mixer
+ - samsung,exynos*-fimd
+
+Any Samsung Exynos device tree binding mentioned may change at any time. Be
+sure to use a device tree binary and a kernel image generated from the same
+source tree.
+
+Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+stable binding/ABI.
-- 
2.14.1

