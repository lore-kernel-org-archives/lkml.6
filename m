Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F10C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FBD2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FBD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeH2MKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:48 -0400
Received: from mout.perfora.net ([74.208.4.197]:47543 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:46 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MCJMN-1g42Rn1pUP-0096SF; Wed, 29 Aug 2018 10:14:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 21/31] ARM: tegra: colibri_t20: iris: add dr_mode property
Date:   Wed, 29 Aug 2018 10:13:57 +0200
Message-Id: <20180829081407.11304-22-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:HGh/K/uDAE5bEhZHSKTOogzN2rixQmrpns4xhhKzyVuxYBnDbJa
 8A235gmGBqnkojXYCh7HBALXNHYF1unsPrGGFgFHBUrw3ek6TuWHVZ+1P0yzqE7ygbzluXd
 c2LVpXmt8BJ/FUF3Y4OF2NgfEDixLv0yS7bGSkTolsJTS01pJ34/9ZXCsC0i54vtktT/T/6
 Wtuq2YuaZ2d6fNycCb9hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jrn5TXLA3nQ=:lPK+I0c/tRZnc/I1d2qXpi
 EnmTVKKy79YwR64F0xjAHASmXxdlNqA+BKpY3kOzB4FYIkCEUzt2yLl3myLQ+ho90kBwpb2JL
 EoqDiCpvF7oJbdOgkxvj3gtAN9Y8+yeO0vQswY7m6m4cHRbSy8yN5zVtghQqDMbi3KNDHidBB
 zRjkhArLX9fOHZ+tmfCjnVqm+2RxsuErHwyoRxKhAxuIEZV+P/yTKfqfaFHFkRn32v2pCcqou
 AUmoQWdHYxSgmPKc5Ns+rBjcYGExxLqsxgGeIEYcr95wUmrHoIs2Bn63v5nWO5hl2BekaP/Se
 ZvUdUoQmzpwihqEvc8qmIjEs7v9cInY1x4iBQwVBA64q/ued/C6nNd8hKr1SD0lNJmztNJa4Z
 bP9Fcm9aylJPsJ7uGLNvqk/mmIvQgQUW6AoxHwlgxTbeQC2Eg32lE4Wwgm5clO2B71lr5YfVE
 Dh09BXEQYkdjoLkt1b1V1GkFs2CjBz7qLsBL7ksens+KbFDxHINe09xZF3kuaMXg/nAm8LLJk
 8pRuI+zRgaHp7mWfa6TOIy55Es5SD2+nx0aGjc9LiV/BH/jiBZr/L43lZqf16NcPf7QNw54r4
 eTOhtkHTBtnrFc134A6CGaM1iANmChL32ZEExNTWBbruQulJRUp60yXriuXwTL1OPjSG7guuf
 V1FrZVuIOzs+bJM0X0HkehTbBuZwEyWxwTLhX0vBhlJ+gLd8YFk3XbG9MpdD8OvBngvY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add dr_mode property to the USB controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index f615e3b9490f..91b3404e1b3d 100644
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

