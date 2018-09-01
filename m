Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E85C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A07420844
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A07420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIAMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:42 -0400
Received: from mout.perfora.net ([74.208.4.194]:48267 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeIAMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:42 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MhCMx-1gIEsx0yMD-00MO2L; Sat, 01 Sep 2018 10:13:26 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 13/34] ARM: tegra: colibri_t30: further lm95245 temperature sensor annotation
Date:   Sat,  1 Sep 2018 10:12:27 +0200
Message-Id: <20180901081248.22639-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:XdcRFlUcKsnUmt4AbFihfFPjWK1Z9VALMgWMT/gpOQGYC950gsB
 bT+r4TY4P8JDta4w2O0SVmLtfBxH+fwaNlSid5hg1MxkJYbNcCN7cZIdNevkY0egl6qCuOA
 OMq4nnSPkwgc3ldbXJ6pd+u/LtsQJ70XNEz6hpPxd0FT7DWARvwpqBG76Z5O9O5mY1LUp2m
 Y62jrHJgqJ7yjfm7elLCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ck33emIIC4=:SfFym4GDRDzQMkNUwvu7K2
 KhpG4y4UsojiNb1A3mtbMciCQWfU1YzeTmGBTf9eZ8FiBYCfS221miADMh0iX5GEkWCjs54E0
 4LtRnifInDT42GO7DS8LWXJdqxM2dmXZerXvdO6Ly6y9gKVlwTCSzfVi67AKtLI7yBVvA8+l9
 bHTMOREQrF5gSjKWb9TW6CL705rZlqFgeJ6OheMYP8/IdDBte+nJfEu0h0/EmzD7+ivXgEaHR
 UTLyeuMAJZQa9uozxhPcZ18D7ZF6wWEGxj3N93qfZXUZoNiwLhtHR5mXylVY0qQHtjcYFQmJr
 5mpPMnUUFU26GlM9dOX/z5FkIP+6Nu8K+3zo25aipB0naKZapVh6uLb1L4CQchiF3kDaCs2yI
 62lGUqwZiDuB6BnG29308Ly6EJwX/U+j4/0t8S0MMnLIaXCM3Qn2ZLEYAjYJIDuByo3Ba+KKm
 77B2VoMPebwtQUxUcxnmVkcbJb5/z11PccRw7BFglgryS66zYkwWeC4z5NWRPazXRMN4UdNwm
 910Kc5B6fmn34DI1VGNqYmxqe0bNM0SjaucvfkOnazS4YoGac5E2yoOWBjVOvb2M4QTQOXzvY
 B5aEGRYo0yQoWJfFwUrcoqWeL/FVea6tDBc1ZzuzEUSdfYAhlr3prvbOgDFg3Uqzuo5mbDbQm
 +AHWBRCBK3s9U3wtkBWovhxnrTd7NNn6pgCTZExWd/Pkt6K7weRHj9ClSbO1q8ije/dE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Further LM95245 temperature sensor annotation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 3a5151dc8483..73ff098612a2 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -878,7 +878,7 @@
 
 		/*
 		 * LM95245 temperature sensor
-		 * Note: OVERT_N directly connected to PMIC PWRDN
+		 * Note: OVERT1# directly connected to TPS65911 PMIC PWRDN
 		 */
 		temp-sensor@4c {
 			compatible = "national,lm95245";
-- 
2.14.4

