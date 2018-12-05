Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD90C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7836620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+ZndMzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7836620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeLEJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbeLEJg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:26 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A6620851;
        Wed,  5 Dec 2018 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002585;
        bh=CF1nsx0kfJpT0hEzu/fuReCb03krJlBUIBEphYtWAGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+ZndMzPTz5soDLpFK4pDELI1YHnICuz75CE5OLWJkosvVXdGQCL/okIpD+gbzUB7
         tzhsVmcA69N+zppWHenZM7dRGm85u3B97ESajz32oa3vM4qB666zWdSwAqCTlj2+Tu
         kNh7LoInAI2T24B0+qlY+ELTRnXNWahtZiKhtc1s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 008/123] ARM: dts: am3517: Fix pinmuxing for CD on MMC1
Date:   Wed,  5 Dec 2018 04:34:00 -0500
Message-Id: <20181205093555.5386-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit e7f4ffffa972db4820c23ff9831a6a4f3f6d8cc5 ]

The MMC1 is active low, not active high.  For some reason,
this worked with different combination of U-Boot and kernels,
but it's supposed to be active low and is currently broken.

Fixes: cfaa856a2510 ("ARM: dts: am3517: Add pinmuxing, CD and
WP for MMC1") #kernel 4.18+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am3517-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 1d158cfda15f..c45aef806870 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -227,7 +227,7 @@
 	vmmc-supply = <&vmmc_fixed>;
 	bus-width = <4>;
 	wp-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>; /* gpio_126 */
-	cd-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>; /* gpio_127 */
+	cd-gpios = <&gpio4 31 GPIO_ACTIVE_LOW>; /* gpio_127 */
 };
 
 &mmc3 {
-- 
2.17.1

