Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16205C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DF420855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DF420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIBOZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:18 -0400
Received: from mout.perfora.net ([74.208.4.194]:58649 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeIBOZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:17 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M6DOO-1fgNVm1GRO-00y2rJ; Sun, 02 Sep 2018 12:09:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 21/37] ARM: tegra: colibri_t20: iris: add dr_mode property
Date:   Sun,  2 Sep 2018 12:08:50 +0200
Message-Id: <20180902100906.25792-22-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:gF78GoAJrenqpjkbRAclX+LvH9xNGJvyzm2ZXODMYJydDWpLL3D
 cOX+vNXUR3Av239ff4UeuNRfhjVzNyxnatezH7/YXjyjaFR+quhg0Sx1tvmyQGJj2epXnw5
 s9m+IOZSvbfnErnrefkHKG0dSg6Bc/YdD5PfOlnpIEwwp0P7Pd/LsnO7iGnypjkkwf69rlw
 eXuGzUgB0NUhibeNPELdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fgeJnDlJ3+U=:Tl+G3CaGZztx3+tsTZ8Z4p
 Toz9sCvlKJ/Rv2tAvsEWPuwpSAjnKVjaGVvU0KeSmBIKuVKDZsqUUwSizP7bUP8dlOL/z7hAe
 OGjL8YpuFa9jzExU0IKsTDYStlIQzHuoMCo6fgSCKOaeawhNp6JuQ/07fXa+TIcPLbDAJRIKk
 EVYGJ53wh0x6WMXYI4BHtqoFZhrFiKxPfcUYXGAJcL9DJ98oUcvSIKCLJGcj29YsWDO2kqMn+
 KFxexA4ovTPYHsGNsC8QBE1OtIICC3Vuqhb88HqSCwBTaNl1hPFeZjYLcMngaQFO7WACR8Wbd
 JfPXeTujX6KNeXR4sSYxNPuYaB0Nplkv573fISQVqDQIFRPEiAWR0DLeCA1rn7qKgWgFtMaXd
 8V9xCQajHsaqRRlL5JHccOF/pdHTZt1ufSvKQq9HP3t9mcWmdV7vF+U/oTKvNtodGYppaSl80
 SzVW60/xzjbMh0nNJso+A55EPFcMVKveGpX/lDhBCi+GvV56yOY40aDHzUPgEWICawKjyl/nz
 xL6eQldoEIVsRmTk48nP3Qe+LTKyGNrwF/2CIZSPmCcXRwYRKjmsuP1eUjAEkIGD9sc0C05Sk
 vM5q4Sm6iDM5obUN1dzeH4zOuWqOoT0rtOORt+3KdG+V+n0NsLqfQu8a5VAFpVFh8hzXBnHDI
 LNxUgBsWZdDdY1eYR3+8L3wkEDnTzykCDncdhtBtigO+pwCSpMVV/36wD9NOXAqRsuAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add dr_mode property to the USB controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 5b25e4b38a69..7a7530820188 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -145,6 +145,7 @@
 	/* EHCI instance 0: USB1_DP/N -> USBC_P/N */
 	usb@c5000000 {
 		status = "okay";
+		dr_mode = "otg";
 	};
 
 	usb-phy@c5000000 {
-- 
2.14.4

