Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD5BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408412082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408412082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeH2MLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:11:06 -0400
Received: from mout.perfora.net ([74.208.4.197]:40163 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbeH2MLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:11:05 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LyT68-1foxXQ0BWA-015re4; Wed, 29 Aug 2018 10:15:14 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 28/31] ARM: tegra: colibri_t20: simplify model and compatible properties
Date:   Wed, 29 Aug 2018 10:14:04 +0200
Message-Id: <20180829081407.11304-29-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:EqdscI4N5aQNVdzys1oPumiXmTzBC1JdO6VItzuf1NwridQlvMC
 15ryPj1ghsB//75FJER/oPoiHlg3pe6DzDe24zZnGDCNfBvy0rcnGiASK1a1au9IPLdTya4
 AjfBK4x4/AiRZDRzMzjMwix+19b1kELgH12D/9850Stua8EiOi56ROcQVx2/2JP2k0LGHKZ
 34lu9t5yATfXHkUEfUjuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:90wMz7a09ss=:ACr6ns++UAGbZKoAq9MEdw
 TW8qiTgSr9qxMOrt/uV9H9Y3WfKiRUg9GK89FGbk3ObNUUiotwkwb2lLqBC9AZt8SI3C5wtkB
 PP5pC5nZySJ4UssuNnuP3A+xusOtY/c9HmHtJAXrEbStbk6+QKkTu86kQrVL3m8shsCEB1rtw
 2MBAohIvnZjAel5jkuLUkvbU0C1jRHFwdbLPCYHTi65NBihW3cWFs0+Cbq25JnEj0/bqd/ojd
 E5qmvoNrcFqvq0z0e0q27fAfZ/PrdyAnSGLAZWmKN5d+ZAfKyaGaXIbvmDscbL6Kz0Z0yx7Y0
 PThzS9hhI2PSoPwrhThkiF9N/Iy9r19bs4ahAZLbVzRX9GbYSbEKq2dFKlL+66Rt01XdL3EWu
 zM7V3QQx2YDy3TrqqTwq6ZKHgqNERiS4WjW+hxjgtbKY0yD0q7aO0KXfy/gfDX7fj2rjkZnin
 Oc+laVjHGPOEH1lrTNldwBPu4U9QMxwR0MfEc06SPlnsgXmmqcgdJ/s6s56S5P+aEFLBBxYzb
 /tchKYhGUlHD7YgsbRSP8/Rrg6buVzUzH9RokyLlRuvSt/IYnK2VOuOYFvpeVHQD/u2DrET79
 58kvn4ncNsIxNCSgalxO8q31oHa21mq0VYLXmPS9xHsKeJhtQq//4ijg/DEh5azV6ynT/twHb
 PI3bdoTwuVGyfMDsxEwyvB1T46NxXSXBOIvLf+gclzfi44A6aiZ2SQjbNY8f647YKVXQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Simplify model and compatible by dropping the 256/512 MB from the model
and -512 from the compatible properties to be more in-line with all our
other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 1204aa9e1d57..d870414e2cb6 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -8,8 +8,8 @@
  * Colibri T20 512MB IT V1.2A
  */
 / {
-	model = "Toradex Colibri T20 256/512 MB";
-	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
+	model = "Toradex Colibri T20";
+	compatible = "toradex,colibri_t20", "nvidia,tegra20";
 
 	memory@0 {
 		/*
-- 
2.14.4

