Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C24DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEF720843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEF720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIAM1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:27:33 -0400
Received: from mout.perfora.net ([74.208.4.197]:36859 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbeIAMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:23 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Md5dc-1gCzgF38kM-00IHJ4; Sat, 01 Sep 2018 10:13:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 01/34] ARM: tegra: colibri_t30: add local-mac-address property
Date:   Sat,  1 Sep 2018 10:12:15 +0200
Message-Id: <20180901081248.22639-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:q8Yfnr5yn3PR8ruZRWRuSKuDSa5WvreifXk7yF8YWag7COhAjaM
 /0Y98xeCm1XiYZHOwMDD7Kw4I8kQfRPmRHs/dj4DCsqC51d/YFldmZvvNc6/aD6Kd0iNoI7
 xNWOKoAV/CACFJbuejnPt3t0EYdg5JuO25VnmTkDTELYKRqPCCCHAuJf60hDckqwo5bpEgY
 XY3PcL1w+S+G3RLP828tQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:slHJvbKRvi8=:Qgiak9Mbq6jRsL7z6Hsp86
 O8hmRwF45Ajso1Yc5WLj/sRe+mZ1PP9A3HhkiodBQQ0yIjX8f3ai9Px/riQnhRDEzFWzXO+d1
 AAY4tjDlC478cKv73qpjpjvWEzqSPIUtWyLFgctrWTWiAnpJEx2zR39+FfhLlaI6hi7MF6puA
 yayC7rgBfVIXmMr8MQjMgxcBIaL51Zowd9SSqhnUxnYapHPSNccwljpDygGnm//TfYnDriM4y
 stZgzqPgHlTlHQlJOOV1BXfQ4S7y3fs1COh2AtcTwEPLs9m9f4tEGNCixgD5S1hHoI0iUPw/E
 Gaxjger0QnZ2b2DB11EnEiP9hI/oTHwSMsmZkLraKBR6N9Qnn38owVXcXJPslozb2W8O4/w6S
 mjkMlofuHbstqDbMBM7MRm1J1sD38sjbqepJg8d1EEdTDOkLTb1pFqDooxjhOb1KwbGFfegXl
 3YOjeSzZKmOgo/F7ICQ6WsTQLYQ8PrwEkHa9XN80KU7PF8AMLYX0p2bCeT+QlXE3H1WogDaBT
 eKfSf0Mssi/incnymMzXa4SqZ9kxeMqi+M7T4vGnh1wTmZOJa8Dec4shBwQdDoFF5kIJAs/hV
 Agt9JG7sUU83t4r9qLcCA8PZAKlrkgdBHWjBl5fYpCwBLIpatJxPodPsiXhBHTPqmyL8kzwzu
 wMJDOF/fXpoh8zJi+NMRyxBF2MbN4S/1l0BCCUrhhUIoMwJ2bbmDiwq4UTy8O867rHbY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 526ed71cf7a3..a392b65a0b64 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -437,6 +437,13 @@
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

