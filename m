Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBCC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1777E20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1777E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIBOZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:15 -0400
Received: from mout.perfora.net ([74.208.4.194]:34933 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeIBOZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:14 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MF3BF-1g6XOd2qxn-00GQT2; Sun, 02 Sep 2018 12:09:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 19/37] ARM: tegra: colibri_t20: use high speed uart driver
Date:   Sun,  2 Sep 2018 12:08:48 +0200
Message-Id: <20180902100906.25792-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:zHBDMKl2DjvqX8oRQjxcdUMec3kzh8HLBoQpJ3Smz5/l7G9IT0S
 GfUvoCiGXQlb5pHHcVrkgXt2NSyJ5Qcdal/XN2ygGIDx5T91T0pb+fwKxqBqhX7iH4vphyN
 ttXv30ZvVSnCMuh955Y/2QIOhMk3NYy6TU/SZEmTx3GTJoTrvr7CcdEpoSSQBo+5QWwlW/8
 Dz9rSo3nS9133nDP+gPiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:95GqZfX2vQQ=:wrgWiEk9M6D7DRDtXPYKQ3
 P0MHDeg74GI5iOKQ2na8h0yji5fq8EUMSCpjSskzjyPmt0GqTdgekza+boI2S9u+LPSFfYKPG
 +EJ74wl/J0vWl/NiG0HL41039MWLXX4SGXVNB17EKQ0kDj+o51YqFsSFBvKxarzeGh4k8lrFv
 S8D1ubjVBMOQjXi9agGxeole3u5W4D6dijygFVIytSkOvHnzlblSvY5ZClBx0P5UUqeLOai9L
 oEsycriQYzQ/rHKqcc5vckoApLfBabQUag+IRWh8+yhZF1XeDAQoSWaQ7/+QETnc1enMG2gz4
 3ceQIktrTuzXQj8SHIVLYfXXfWWlWXCayahALrm9sSOdSaiDbwRNPHr0JOWJLb1AyUwh0SgNy
 Xpzicw9oSPsuJ5KGp4FnPmGb+Bs8mN4da0zPwTE0ta5wmbLQD3RoXnMF9kitHEeQAf3s/Uvxk
 4fZ4UvttG6RMMq3OZ8OBjK3rqES4guIM1JgBiRk5GfPVx37Ratuzpg58diXr5Bu8p904SO2I0
 Ttk4BNfjflCzRuOLzn52HKMnnSLa/fhXaxbcuSNjhN5zg2Bq1jnj+gUJMuJ2vovveDctHuoMb
 t272WG4DbqZh5rIQhoHReaZWnrVvfS8rDGt53DvSU0JPRSRLSGDYQlrHJ3qtDs47nLfjzODge
 aT2323srHUYkyXWJvrKXBZmPc3uWsPYcklu8mTQ3vNNfP5ykYT4JG2MJ1/yd2hrX+Ub4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use high speed UART driver compatible nvidia,tegra20-hsuart.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index aa2ca3dad32c..86bfe77d9230 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -423,6 +423,14 @@
 			<&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 	};
 
+	serial@70006040 {
+		compatible = "nvidia,tegra20-hsuart";
+	};
+
+	serial@70006300 {
+		compatible = "nvidia,tegra20-hsuart";
+	};
+
 	nand-controller@70008000 {
 		status = "okay";
 
-- 
2.14.4

