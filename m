Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB54C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA6520989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+chjP1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA6520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeLEKBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbeLEJs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:48:56 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941BF2133F;
        Wed,  5 Dec 2018 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003336;
        bh=+KBgXF/bF5GhR8AzzIGdkUhtXLvEOejjJEgY1W0+1eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+chjP1MfQcMUlP8Q63Xzj89fSD2GWOztwg9DBhrnaj+9i4+UPI2n1q8OfDMK3eLn
         orxT8EEJMHRfgrKR7+P2UnS/mQJ1xuYVChHtU+PNnaSOhfzvtBoJeekw1NwNfgdDfS
         3HNqlxxcgB14WyEUvbdJHITafHv++HvQcOirT2EA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 03/45] ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
Date:   Wed,  5 Dec 2018 04:46:24 -0500
Message-Id: <20181205094706.7225-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 3d8b804bc528d3720ec0c39c212af92dafaf6e84 ]

The interrupt on mmc3_dat1 is wrong which prevents this from
appearing in /proc/interrupts.

Fixes: ab8dd3aed011 ("ARM: DTS: Add minimal Support for Logic PD
DM3730 SOM-LV") #Kernel 4.9+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/logicpd-som-lv.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
index e262fa9ef334..876ed5f2922c 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -122,7 +122,7 @@
 };
 
 &mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
 	pinctrl-0 = <&mmc3_pins &wl127x_gpio>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
-- 
2.17.1

