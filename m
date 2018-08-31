Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45357C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82A520658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82A520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeHaUr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:56 -0400
Received: from mout.perfora.net ([74.208.4.196]:46039 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeHaUry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MIOML-1fuwJS2TRX-004B9W; Fri, 31 Aug 2018 18:39:30 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 33/34] ARM: tegra: apalis_t30: move hda node from carrier to module
Date:   Fri, 31 Aug 2018 18:38:15 +0200
Message-Id: <20180831163817.23970-34-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:M5npC9CEF5T3mAY2uOyYdCnO7sHaZZvv5eahgE9Y5DAEZ0PX7K2
 gZY0uPVVfsX2BdCp3DX5zYbBVz8KKZ9j/29Nv4Q+L2ni5Xf+BbMVTCglRZjG4BCLEPaOYEr
 YvQCCZrsbgiH7encHM6645ZwoVCkXoNWpnDbujszHmTwQBCwu/pN7QBmg8WjNu51W7YI56C
 SsotnlJB4NFi560ClJePA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y2ubJViBCgI=:ta4MCjApBHeIKBfV3JiTyv
 XNQU+LvcS3WUX04dTRtbcHY9H3YHaiwcTWLv7u6mfRJKPRUF9/dCEheLVy4gnEtfQjCEJqRbv
 SyuuV4uM/+u6mRIjWM8xXCT/ZbDDhE5nfOTQntgL9k3Ed3gIj8tGSV8lKb8E/wOYVMD/k5eFZ
 ++3mNBBILubuQJS3paNl/oQrr/at0iaGcHHczN5bEQwP43eWgv5fg3GKbFQlAvauu2x07raIq
 gAu/6EXTh+qcKDIIZolax7orW0S5I17FZLuhj6d3WlNUUdNYZ8qickZjON75FzMNLrlryBNbM
 bHXvmG95DHmRVOwF83veEaCofrIUV/BTHqnWpW/AJOzPTNpqkQ3SVamKApDlbXUKVzR1Tvvsp
 sCoMbKHmSyth7XIl/Ot4wH51hsRATp/GSqOlG5f6StwE+I0Y1piINE2EnCTC/b87hJmZbwhtw
 pAuTb5nBaNOLRpmBOgvFBaPmCmqYVielJyxC4CYnldyeh3TWq7i1DFrEYmv++aOpqUXHfxKHa
 046osWbyBHQeue0VaPhGqOxyFvD4ZXyr9TivaUzNxGV9j8uNsCRMwLykZwLRm5Z3e9cegOlFu
 hZXn/bFDzgF/3Lp7r8N6/vo1rKd8y5+yyD5/P8mUPsHjzYg219qHn9gYeA1DM2JDACvSEwmn9
 DoSUWBh3vrboSa/Aqm1HFmL/riNV3KY2854colv3aUAjW5fgUUviJOe7XraotdZQZjnk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move the hda node from the carrier board to the module level device
tree.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 4 ----
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index fdfadda72e0d..749fc6d1ff70 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -119,10 +119,6 @@
 		spi-max-frequency = <25000000>;
 	};
 
-	hda@70030000 {
-		status = "okay";
-	};
-
 	/* Apalis SD1 */
 	sdhci@78000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index e44b2bce6736..23cecd327172 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1078,6 +1078,10 @@
 		};
 	};
 
+	hda@70030000 {
+		status = "okay";
+	};
+
 	ahub@70080000 {
 		i2s@70080500 {
 			status = "okay";
-- 
2.14.4

