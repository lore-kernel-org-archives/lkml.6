Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A050C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E0F20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHq0QH4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E0F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLEJgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeLEJg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:28 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433EC20878;
        Wed,  5 Dec 2018 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002588;
        bh=+A7/opq87sYs0rtTWvxkaTpIRyVHnGPrpqo2hd4Zof8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHq0QH4mSBowKVPrUDhbmOfxKyDceqjH8GYDoLfM5DviLEFUaup33U3erSFUVx4p6
         2NRAOAGmUfEM1drQmkaiZ+M7hFxkHb69DpG2JPNawfJQ98ff2CMGLhKkMYvV1rSH6y
         dEjPGISY4TC9n2a2jZ3OlNBiMKUmZ01as7E9tfpc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 009/123] ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
Date:   Wed,  5 Dec 2018 04:34:01 -0500
Message-Id: <20181205093555.5386-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 6809564d64ff1301d44c13334cc0e8369e825a20 ]

When the Torpedo was first introduced back at Kernel 4.2,
the interrupt extended flag has been set incorrectly.

It was subsequently moved, so this patch corrects Kernel
4.18+

Fixes: a38867305203 ("ARM: dts: Move move WiFi bindings to
logicpd-torpedo-37xx-devkit") # v4.18+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 9d5d53fbe9c0..c39cf2ca54da 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -35,7 +35,7 @@
  * jumpering combinations for the long run.
  */
 &mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
 	pinctrl-0 = <&mmc3_pins &mmc3_core2_pins>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
-- 
2.17.1

