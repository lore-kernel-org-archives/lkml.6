Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C36FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BDD20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BDD20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbeGWNiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:19 -0400
Received: from mout.perfora.net ([74.208.4.196]:55591 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388307AbeGWNiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:18 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LhdEl-1gKodg1Vwn-00mqhY; Mon, 23 Jul 2018 14:37:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 03/26] ARM: tegra: colibri_t30: reorder host1x/hdmi properties
Date:   Mon, 23 Jul 2018 14:36:34 +0200
Message-Id: <20180723123658.980-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:scsro0RBpw0rFcTupdaUCQOp1MNERzhjusAROqSB+iNVw3sfMrS
 5ukqqc175isL8DRfDfzDDgyLZUbJ4j43ozH85IZZyqQIe3lNRvqapuRbw4vqtIm/bmK/Iv6
 1dPBNhQ4BeYX9jr2E8N73RhSWnoPDTnYhQ2fylvMB4RtzSnVNyikdiBtOtAwMFQ2X3HBODs
 hG4xaqC6aB4HlvmUa4O9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V0WiPXIapUA=:aAFQAN9vILlqBS+GGA9W2w
 lgEm+2E+x8E8Nix0OmniqFB2n5zLks0EEqsL3kWB/Samc0RqCtypQ8nX4QTUjB31zDmzeZatj
 XOtoXcxspi91XZS7NmwjMk3bJHHgleplH+OaSKw9lgEP4PJunemUe5veSMWU6UN75WCmAp4+/
 8viBB/65tSGBfn+pSthPgb5b8r6Q8GbxvSunbxNEXMZ/eJ8P6Bo6/YtP1ohpf9DLnzqzTUvQH
 D5iTIgzhBYwQPeAOKx18JSziULdDZHfY6/KSU8ltP6j2r4VZkcVximQpKpt3AFoeOBsu7sko8
 a6kpUHo3dUD5USxBDvMKE7+ehv+9zRpp0kAAGmfjcHgS/SCMH4wlIbb/fgqOBXd+JStrwxxNK
 2DcvXQUXfoH9A0aB2yEmzcq/nwz/lV8LNua3QRlQbhSQLYHy5bePeU7cvOAkJ/ecQbTQzKbe6
 7EZo85U0zoejris8LBbIWwsPVzaYxxPCDIljgtF/iIIlZBc7gQLoQA7d2HjlS1b5qXuPHcfic
 yc1sLPzBw60aB9xXKIoQAlS4ff3xYHRcLd+92jXKektjBxPCySnK6ucv4QsufKnIsq8Y+8Zmu
 Vbda1pmI3dWGmGlSeXpKXc704VBEferSfMePVO/b8t5KBb8v/GlT/3ichVGAEfMD43uhYVfVv
 wFN8bXeyhKlMfmQaJXtcduIUHbLbXxjICG1SiQEZ0eu4kbfQkdAiyb37Mn/kMQyAb3/E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 5cceb69743bc..a4c2fbf270ff 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -16,12 +16,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-
+			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
+			vdd-supply = <&avdd_hdmi_3v3_reg>;
 		};
 	};
 
-- 
2.14.4

