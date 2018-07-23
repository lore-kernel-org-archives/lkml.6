Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C311D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C311D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbeGWNiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:46 -0400
Received: from mout.perfora.net ([74.208.4.197]:42569 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388438AbeGWNip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:45 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LhuDc-1gLe4p1Wc6-00n7ol; Mon, 23 Jul 2018 14:37:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 16/26] ARM: tegra: colibri_t30: add proper emmc vmmc and vqmmc supplies
Date:   Mon, 23 Jul 2018 14:36:47 +0200
Message-Id: <20180723123658.980-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:rUaL4dtb0CodJEIESEgBOYWErC6NALpOgAc0LSpavn3oSS3WvCF
 2FCNSPvpd7dkYKg493r+2MC4Xgwz6xQPeI3KKVgDIlFutoWdwbDrhyUGgLCyxr+Bgpe4rMS
 iZ6JAnPd6SGb+lURmWYZhKR8c9YzpOKzXsjN1nM4CfTnDCH2eKMuBUrQ/TkkzNcWAfCz6OP
 WqyUB2QHdn6HKbW9N+EzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K6+3qwXLTuU=:uh1MKc4sXx+ReqCOaTqJFX
 9JIqqJWA91spE3jBtS9L1SsSITAsyHY6w4IihfJJm6WkuZfNjtbE0HpJaF8eVSBpp8gmOGYK4
 2OE36l3zrdxbk8aUQfXpf8QnvaLe91G5YuK0C2P8PIwi0zlWmC+1UWewtQaCgLmct/1+XyjaF
 r9+2OokMtwikdbVdv5VqRXN3OAY9UG9Gpr7A7DsLL1EFxQQhlPsc+8UOb/PrkQFm5BONUEWBt
 S750/1ojFLGhQeqcyTAPSOZMccrabp9/g6FBq3Bmcdh2qRc9yiiihIYz3nx+hw2ahM0I58Dno
 ZQNuc4Fkl9d1QCTixjkomHrykcguowbpzZuxa0N60DplH/Ow639hW5fFvU1bRiz3vlNFC/ZX+
 peZyqenssPL08pCTf+xszWI4jDqRPhBW4WnfPwOtvxCD06OSAvz7GJ7llpHTpklAthw1NYpaq
 R05HOYryuHl8Mv2/oBYelSLhueIHqQIe0EEw+vzwV3W8lo5FSZbMVoOmBaoGIOQCih75vKcl0
 pb2dkTSEsYQ2xequ2tlsxx6xz8kkOBNZJUqxJiRu5nbtq4Tr+873TdkAagAarv7yRiLac7daj
 xe5UlzLAQ0drD8pW37n3pH/qPc9NhmBgupCV1iviD4Xn/cCO3aiXB/CwHEe7fj3K7YBK56Uo7
 94xrWX6e49gfuPJkLt3EdedavIfLEabbbPT8ETKVnCCm83TO0SUYorQMX5WM2ZvcuYPU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add proper eMMC vmmc and vqmmc supplies e.g. fixing signalling voltage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 6608243e1d55..0a2115f59e41 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -925,6 +925,8 @@
 		#size-cells = <0>;
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
 
 		emmc: emmc@0 {
 			reg = <0>;
-- 
2.14.4

