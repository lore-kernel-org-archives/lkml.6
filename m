Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B23EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4420851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLgWPf/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B4420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeLEJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeLEJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:33 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1088120850;
        Wed,  5 Dec 2018 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002592;
        bh=buawz9DrKsRzM6c+THoL3e22jFadJES6uWq40vzs5Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLgWPf/1AwHLtJmXt+8D2IWbFs94Xdg1bKwn6o8bQJuOzCKsjWFUesLuuad+s/tA9
         gi2d6ftsibd4iYJRh3AIgcSUiEWPxn0H4HnoUZWr/B8dl22jMpTMBpX/ulCwqhJbAI
         ekxtOYg/y6rmYpeSA5wsoNDW4kXwLxHALA5lpKIM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 011/123] ARM: dts: am3517-som: Fix WL127x Wifi interrupt
Date:   Wed,  5 Dec 2018 04:34:03 -0500
Message-Id: <20181205093555.5386-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 419b194cdedc76d0d3cd5b0900db0fa8177c4a52 ]

At the same time the AM3517 EVM was gaining WiFi support,
separate patches were introduced to move the interrupt
from HIGH to RISING.  Because they overlapped, this was not
done to the AM3517-EVM.  This patch fixes Kernel 4.19+

Fixes: 6bf5e3410f19 ("ARM: dts: am3517-som: Add WL127x Wifi")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am3517-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517-som.dtsi b/arch/arm/boot/dts/am3517-som.dtsi
index dae6e458e59f..b1c988eed87c 100644
--- a/arch/arm/boot/dts/am3517-som.dtsi
+++ b/arch/arm/boot/dts/am3517-som.dtsi
@@ -163,7 +163,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_LEVEL_HIGH>; /* gpio_170 */
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>; /* gpio_170 */
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
-- 
2.17.1

