Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE10EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AAD20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AAD20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIAMYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:46 -0400
Received: from mout.perfora.net ([74.208.4.194]:43733 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbeIAMYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:45 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LmtMA-1fQGik0Psa-00h4mq; Sat, 01 Sep 2018 10:13:30 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 15/34] ARM: tegra: colibri_t30: add proper emmc vmmc and vqmmc supplies
Date:   Sat,  1 Sep 2018 10:12:29 +0200
Message-Id: <20180901081248.22639-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:cdhizJLLF/aEHf1z7H6TfbR5ZDmeHmwYmsnQVoGEONSs+lIs9ej
 TdePGETAJl460k0NBy4KBsp19l8b8uPlxBjflGUJf4uUWYcVRAqiMkbaOMiIvmrZPSRBLkd
 wYb0SIHfJDbgywmBzM4FxJ9/4YoD5weIfBL/M/9VEgNpzhv0anKQnlIgrja+bCQgSE3bFda
 z88isjCc0hJbLMx6RVYvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sgeGxvBUTVI=:d+vUefT8Xpgc3xvr/NBOml
 RRQySj8JoRtegxmEGw4AoI5Cjf/aOhGPhpt63RPn6NYfq8dVGihlzHOfH3g3DuQjbWwtC2bX6
 Y/CfTR1LPXoCuOCdMMZ3E7hS0Mm4BcjxPtlbhnfQsKiQ5SZ2tg53UYQTvM7OZNhIk6uEopgy0
 eBT17epUUIyKhPGqfOtd65bZ7n+tg4BRM5zuM/LomhV+QI3FeqArVN06d/J/rwFHqgOYQNuqa
 /PmkpSsnzJqEsaNPix7we5r7ElBQJRbGU7fbKk13cojPGmH1L5OELdCiD3k83TGj/PjeT0bbT
 Djr+xiVmlGaAQeN1quOURBdUXo5vDh2KGkuW4pKO6FRPBfutyTnfUTP15S3yj95dKiTMoUc58
 M9Ga6sGOqC5OtuN+mXnRsfxO7O7Yr2Hsi9lm+X4YGJT49SztWf/Qa3a8JnjffxJJ7YNh2ipvt
 IRvszEmEdFRIsEPm+7rO+VY+ig5F7lL+qTliwjbuUQIqUNBTFxSB8vZZieUTqIz36VRKaUgg1
 X8nrFXFofYX3IvyfKJVTRgaJvET5HqRwKrMuHfl4wTpdAIAqa5P4hjZsrG/hKuCTGMIWPsFkm
 /I6CgaGdeKTiIPZ0gXmGBokJbhKZnMTwY175EwqXMrBRS0+yJSrIvul9tHnVuIPCc2IjQGSAA
 LJ/WUdYczjM9pJOGprMmJejl6iVyW2vvXSSVtE0sUphgkfLbRk8VkeM4p1NB3amplf7o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add proper eMMC vmmc and vqmmc supplies e.g. fixing signalling voltage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 670edd5e4754..c5cb05f78604 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -931,6 +931,8 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
 	};
 
 	/* EHCI instance 1: USB2_DP/N -> AX88772B */
-- 
2.14.4

