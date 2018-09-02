Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74908C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D14020841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D14020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeIBOZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:04 -0400
Received: from mout.perfora.net ([74.208.4.197]:54835 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeIBOZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:04 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M10Kf-1fcok115Rv-00uzv2; Sun, 02 Sep 2018 12:09:38 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 11/37] ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
Date:   Sun,  2 Sep 2018 12:08:40 +0200
Message-Id: <20180902100906.25792-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:TlNotpAoTeJRxtX6Kq98d+BXvFAaRdIeQQD+XmN8bu+PhV/Kf2R
 lHfA7a/pUyu3FvYvbmtciUMMgyN3gxedX22voZrbLCsO2M1n7bLKxnCnoGxBa4JxLHhWR2b
 +Zf8XBqtRd4TUERD/MJdvUp5vIyvvHurtgLtXZVpAeUb5lm9Fwbqf/WvC/67l+DTg2hkcB4
 2+oKGWDcnk7Z7Xwd+ODLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UaRQvyZpvd0=:jCCHR45AvJt8Mkqo9bvooB
 6e26wncRWcpB4zZf5R1lDxhjusbWP+nZlavV5EgiG5eK+Y7twql558imkP/RaFmfjWE1lv/yi
 LL/ozYjIIP419YoewSWhO0qOV74zDMdjWI6jftXvRLJ1G24NfyaDpb8pcUHwt/B7QLlMNdsw2
 4Ub/c4PEK+7aFI8I+EnUNv7gBrwObt3KxH2jShGbeZGPufNXzvi25fr8XIQC5axBH9Z3N7LdD
 oLlraSk3oAL/4oSikpZ3hk/bLTLnfnApwHI1Z3wKcjZm3rRR72lBjt9rkcImiibfpYyTZjZMY
 Z7P3DzNbXDeVAV75zfXeZS9VtcfdfoSOKXtTZecMXhnOnpPB2oi+46Ddpwt5bfXfGSioIrpD+
 0MKPSq+cuNcXaF8CO9T8WtYD/20Jf0/bNVnw9xI65h+vvtQOTOkrJ+2nkwI7acu2mwuE1sFiU
 lJxYOlOCZSJf8C8a422NkCpYjTooPCTf0XmClq0ULbNOye2/mvLNe8djrn/fEHV0MscpZpYYi
 kfp/vjy52t74tO5/d5x/xwRf6R0sRVjjxj1U4g3yrnuPoNhHs1qxdCVubdrE2Z/xyD0a+gFKt
 OIVQY/BwGghdN6Bhc0QyHLTGisDFT+9KRLbqWA05hgIjRa1ZtVDPFCpwwsrome6LXN2K0tXnw
 TImsBPDeeNLlBeXi8hQtnPsyHmbDVZjqNt8g7LVpSK114cHu7RMzc7nM/v5319uuu10w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove the phy-reset-gpio from the USB controller node as it is already
specified in the PHY node.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

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

