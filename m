Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F036BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B777620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B777620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbeFRITE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964803AbeFRITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76F71BAD;
        Mon, 18 Jun 2018 08:19:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 088/279] arm64: dts: uniphier: fix input delay value for legacy mode of eMMC
Date:   Mon, 18 Jun 2018 10:11:13 +0200
Message-Id: <20180618080612.446957753@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit f4e5200fc0d7dad75c688e7ccc0652481a916df5 ]

The property of the legacy mode for the eMMC PHY turned out to
be wrong.  Some eMMC devices are unstable due to the set-up/hold
timing violation.  Correct the delay value.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi |    2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi |    2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -330,7 +330,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -435,7 +435,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -336,7 +336,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;


