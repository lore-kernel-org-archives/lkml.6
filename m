Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA0320880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA0320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbeGWNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:29 -0400
Received: from mout.perfora.net ([74.208.4.196]:49321 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbeGWNi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:28 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPnfw-1fdkbi0OqQ-004xJP; Mon, 23 Jul 2018 14:37:20 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/26] ARM: tegra: colibri_t30: move dr_mode property from phy to controller
Date:   Mon, 23 Jul 2018 14:36:39 +0200
Message-Id: <20180723123658.980-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:2zZs7pyDMMu3Me9VZvyayPNMiW52mG0wdtjoqHzfsG61Vl4qmUn
 PnW6WLsTwuDtxLxYawV/v4Sb2/10bmgI0Dua3635OMNaqahRXVHSmSPjnNGj8e3b/JvSGdL
 dtAzoov1EcSpzkn5f2cm5De/Da1lkd5fYPsyG8DgEeKQ4yiiOFESf3hxjBh0NeULtf7J5cl
 +82DreD04umBRaD35jQXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3rYEG3+IFnY=:HMarOumxTrdrPn1Zo4A5o7
 gRIfybFUmvGAr4tZ1bhYPCgiXTAPbVC1ZhJtAxHxzbxLnvMOXE5VkvYhBRS6SYe6bTQnlD7qA
 2a55IxcNsbsbok+ePM7JA1wREGcTKoPRQXSQTlCtL10MoZxOeh5yDhExAv+VFSJddB0N+2FZq
 Ng/i2ofuPei43UCSELToSEoxWPSWfzP3OnGDHhJ/1JoA3wjcOIQeh09FSZKEqX1rL1J77t7yd
 XI4AYEgPj9XyBwoEDfP/aFZqejkxI+yTQ+faJezatewLODBcLq+pZSbHSIgOpp1SKxinvUgZC
 ITfVnRa5gtJZtGXktcILzLXhEkMAASmbTHyGy5fqIxNnfpgjt2dHjBB9Xipn9z6yNHNrx6mWw
 zikVV7Rf115UdThmVCXooBai89ewElsvsmSf7RR5zKOIe8cNpqzWNV+J+4MJmIfZRxCRBNZ4T
 zM6EeBODIqs5wVR03l6A+ssSAIUyVBNfE9yETo8Y3Peca/st4qhkMhzeWJBUxHADmb7nOBbl4
 vtmzuEY3QYMTL641H+eBZ176fqs7glwzvIkLQZWU5DfDttK0+1Pyh0k+0iBmN+HgMscoTe+hx
 ARoXL8HfuXEuhmV8+oiHBA7xQ6C8VCn3rzXIb+cXfAhVRYnNtm9FGyzZ25x040k7XN3ojG4if
 LJ7+WNpsWvA5amb/Ac4Y1tnC18rMNev3ytTf3ykIiSgr4M59QsyAYxYxD+vGXwbBbptc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move dr_mode property from USB PHY node to controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 19af6ccd57b2..70d3a89825a4 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -107,11 +107,11 @@
 	/* EHCI instance 0: USB1_DP/N -> USBC_P/N */
 	usb@7d000000 {
 		status = "okay";
+		dr_mode = "otg";
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "otg";
 		vbus-supply = <&reg_usbc_vbus>;
 	};
 
-- 
2.14.4

