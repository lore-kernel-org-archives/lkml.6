Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C318C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D10C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D10C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeH2MKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:25 -0400
Received: from mout.perfora.net ([74.208.4.196]:53287 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbeH2MKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:25 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MAvmU-1g2eqW22Tc-009vne; Wed, 29 Aug 2018 10:14:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 11/31] ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
Date:   Wed, 29 Aug 2018 10:13:47 +0200
Message-Id: <20180829081407.11304-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:xDuubFumASrTMFIDGq/vkGgJiRHY35iS8O/eF6V1Dv5HJmo80Iy
 ZofKhtYVwjQFBmBySW/w1ZZs1WRN+RBnzvLp5e+wFCshGe5NisrHSHB1f7BguZtlkQKd3rc
 4E0GHa2FjAf2pIkrbSVIPtsQdS3Ii0nR+i4/su8sPJxOQQH9Y53snac8VdtFZ8Y4guurryx
 DKNz+Cv+GemGGlynyP2MA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cEUo5pDYxMI=:O9WALGgIrmsNBgoO9eJpd8
 upkScVVyl+RAlAe+41qyyThE0hZENpRVI5W2UEYjoh4GbzHxe/p+BfZnuETfMMVvupdmcBS5a
 KQqHRZUiBiWLBDzGgXQNEJp9bA+GNyXBdPrL2VVa68wuKrhjJEaDR1vxLEs+M5cjTGjln0+Sl
 FrFmf/9Ut8da/HTe+8o5uGjFedADgoIO9CGYl3f5ewgjVMUl9h8ab0T1V6CZ3k8SISlQecLcG
 i802iuj84mZu67yAb3SE6h5qARCL1TA+qVCUGMpGkY1RBQrxIealDju/7XDXgy7bxXO3Jp9u4
 0L2s9D9veMJ4N9OsbK+N95nEE0vQj3lBVgxPC1SgXCh+ob9y1cO3H6ULa1H+DJ52LK8mUdYbr
 BKCJtA7XdxMOk9eeOu+nbHkb6iFX+NnuMHyvYtiGQTog2JOd5jqeOs4hvDBo3GA2dKXGPxP1j
 nwqFkuNxJX2NawHxRMMCl7BmBAhvum4sQpaX2OkU5mUjW7hBsckTFj4vM6zSbASCWYB+jWOGK
 AsmI5zrlC9jiGmmbTUHcv/lzevvTFqTIsD00rsIRuyufumZSB2ezWPE1nFnPTn1A3mTTzwMQ4
 Mp2scBeLwCOwa4SlOO1yU7qVlFbYOgzaK93qy4aJY4f3oEDWbFuYfjmqhx4AYnWy7Y+2GUrdT
 EXnjur+TC33qJ/uBsMBMPSmo565Gk8uNXQXkGYqx1hKpXCy3szFGVoeZSxkEMwuyCCAk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove the phy-reset-gpio from the USB controller node as it is already
specified in the PHY node.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 77e99caf5606..06d0be29c0b4 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -457,8 +457,6 @@
 	/* EHCI instance 1: ULPI PHY -> AX88772B (On-module) */
 	usb@c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.14.4

