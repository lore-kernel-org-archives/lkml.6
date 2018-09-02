Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48453C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFEB20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFEB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeIBOZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:32 -0400
Received: from mout.perfora.net ([74.208.4.196]:51345 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:31 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8PFU-1fiZTk413q-00vpw9; Sun, 02 Sep 2018 12:10:11 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 29/37] ARM: tegra: colibri_t20: iris: simplify model and compatible properties
Date:   Sun,  2 Sep 2018 12:08:58 +0200
Message-Id: <20180902100906.25792-30-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:3xWtz5YCpVcC9AxGTLkp3Wt2eu4HfuoOfkoNx5K27cbyL3+lFGm
 4u1DGykDYkRe/P2xgID8nrLWd5KSmbM195rJ4To6UEkyRyAeVK2f+HTHux8MC0k2kxS6nUZ
 dgFUAx4WrSbPQbEEQXs5Xsrh6yUUT12hp93zb0GPQMxsj0uu19C70ggHdgo9K52ub/sNO17
 5sWGtTg7E2LqToPyr1/jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4SWOHqffU/c=:tE9yRpky+o4xbwBObHiN+x
 MCHKJ1P6oKiEYhtLPBixRb5zcl8OKuE+nxf/TQj+5Scg0JB8/e1csCfrf8mxnvyRhxMd2B517
 ByQaDjSTvJorg6EStmAi+3kfqC3VaRsg+MP4P0uuUbXrc1ykdbJNBW/FUeoDRPrRX+l3d6gwL
 p+bwlJqDXWuiyrkB0PZS4RLQm56lgZHDo1kXHEhq2ReSS+78RE+plMbkmWi/O+TDbNQvF002P
 QtOdf4CfjR38c2/a3b/aGGgCXvqfnCSX60LFzogKlXSkj89uXfEtp6piyHyvXuXkSa04fJTdy
 +5jzu7Nqn6Tjflu8oIAFip+zZrXbBhC6QR6jyCmpeuXzgCbh22VhokSJAJMPtfzfGYBNysLGH
 1+15YMftLzLrn/iYcK30WbpzJtBFUxKWQvF4rWha0LSMUPs8YVBi3oaPlBPJeR009XsFpJ2ij
 rbcG/3m1xjTGLheaN4bjQZp5Hgj7Nx4vyLBscW/ImK7sN28qc5h9sbFN4B0oIJiS9ur/DRgzU
 Q5Dz5h62DUFiOkVDk/OBbKKcTNzEQHnmYPwc+D17VM25lNUUqJeqB9ZmQ/mMawqm76JQOl3rF
 Fqb26IPyN2+u+aUocbPeqCp8mI5HxOH5X1Cd0h/KUUjw5aOJctRqTj1XbcP+3nSToPN32EuEP
 6TuBdkqOxjpA8KLRlDRYxCuqYndYB9FGeGCajuQUqHX0f7U0Kt44VY3ikfrYf9jyTl0c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Simplify model and compatible by dropping the 256/512 MB from the model,
-512 from the compatible and rename that property from toradex,iris to
toradex,colibri_t20-iris to be more in-line with all our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also reflect this change in the device tree bindings documentation.

 Documentation/devicetree/bindings/arm/tegra.txt | 2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 5e1b0b30ece2..0909122a2bee 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -54,9 +54,9 @@ board-specific compatible values:
   toradex,apalis-tk1-v1.2
   toradex,apalis-tk1-v1.2-eval
   toradex,colibri_t20
+  toradex,colibri_t20-iris
   toradex,colibri_t30
   toradex,colibri_t30-eval-v3
-  toradex,iris
 
 Trusted Foundations
 -------------------------------------------
diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index cd47ac5b528f..dbdf596dd151 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -6,7 +6,8 @@
 
 / {
 	model = "Toradex Colibri T20 on Iris";
-	compatible = "toradex,iris", "toradex,colibri_t20", "nvidia,tegra20";
+	compatible = "toradex,colibri_t20-iris", "toradex,colibri_t20",
+		     "nvidia,tegra20";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

