Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3390ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646D820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646D820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeGWNiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:20 -0400
Received: from mout.perfora.net ([74.208.4.194]:59357 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbeGWNiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:18 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MDOgd-1fmqru0xkj-00GojY; Mon, 23 Jul 2018 14:37:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 02/26] ARM: tegra: colibri_t30: add local-mac-address property
Date:   Mon, 23 Jul 2018 14:36:33 +0200
Message-Id: <20180723123658.980-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:zLNTWy4+pvCdmGAGBMKHnBYiYHUjLgw41GyjoIUWhRNLEPlc0QL
 dxR2gbz27aBVLYmWAv22J7V8nK/dqiK4dSnPfY1pAsn9CLtwhhOIiK9SseuyPTuFdGa2guj
 eA+wcaUUzduPzYTnznRNmotr2IHjBJwrn49TFQsQX28d/Uv6xAUjQ2dDXi0JD8qOO4W1rGW
 2kqy8qf6jtgR4AFJGWpAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vUNZM7vCybs=:dVPKBYgfYDGZLvx1PqfDM0
 cZbOeXTfwDQBhvnZ4pXwngCYRsXAXTSQdxgQhVMKtF6fd8th5hO/FAciak8Y/3j5rdOar3S/B
 WRx44pGugJuRETLwkpMVacwJF8fmYMiPw4PEU4JCi+FffWGLxxmUiydVT2jtDTAZ/gxgtOaEZ
 wlKRmbGwjUzDZ4yiiGK+LxWOMh6cbknB8XJYTsxfEV8Aj+olINGpej4sBdcHBo/NSRQ/kncY3
 cKtq294z5P3iVfjaor8KYyY50LgoY01VTjd6zH7Biufm58O+JwplzB74whZYxzsgK0ZGRJe4r
 8Di6uK2Qf4in4SZ/i5ywNfLgHmd/Y5JYiBsqWyBeD6WpYtScfwiS4cqxzy85MeixJ2Tw/0EJm
 hzGTEDNYC0npFvz14tIuA3NRB1bMeaGnfFTF3ZeMMxPoh8Z0T/B4HqyYhiLb5zwqZ4PLmCn+G
 vgQjXJbKXAK2L62+mKBHPCYVJmmVvXHfutsIVFm6pZHWvkf3axyZc6o+QsW8kpwt357GUcLNX
 wUl+jl2ZDduwUr0wlwFAVV3/bLbQ/M9K0KyAwVz7naizipdWw9hTQeRAOOyx0pRJzw+HaG41z
 ski7lVU7cx7iv1a4ECUA7OfGTYAR60e41CNBpT4lj1yrlZah7DTvo82H0JV0NYm/+HBR1f44T
 EmwQ9//ABAL83njv4Tt7V2BrohC8+eUHQASYQCHgGOArciOUoN3Wl3LBEgJJAo321V5c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 6293422c977a..5cceb69743bc 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -445,6 +445,13 @@
 	/* EHCI instance 1: USB2_DP/N -> AX88772B */
 	usb@7d004000 {
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		asix@1 {
+			reg = <1>;
+			local-mac-address = [00 00 00 00 00 00];
+		};
 	};
 
 	usb-phy@7d004000 {
-- 
2.14.4

