Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D277C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3302020892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791419;
	bh=NCJ7rBbWhGz+sZAHJR2WjQmVQFzShEmjGNuw6vwgqaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LrZCFG8qaIm1pMXz4BFi504Ni7dNSG9fcXawKMUEYMxSEaTMplRV2Snnc9jB5W8fC
	 n5WxuKyJV3QNImemToirZPYfwLkZud5SclvLxrmvtEPVprebH/ixCKvdF8Sop7FkrH
	 jc2Bma2RZAvlllxbLJSIaKb5+zKXCsYAaP62xzdI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3302020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbeLNMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbeLNMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33CB2145D;
        Fri, 14 Dec 2018 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788927;
        bh=NCJ7rBbWhGz+sZAHJR2WjQmVQFzShEmjGNuw6vwgqaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEqxnDg5W/F2VktH9Ig4cJ/gfC8u/4Cb3QSmNVFppmmDtsp6BOctK5xzvcrdLZvxx
         dVU+oQlpC5jk3HgGr4yCti4dX6ODWhD8sZR7Uy4nFvtT0b4nfS1Mh8NuBpprZLhJKb
         qfedPG32aBZjPYCs/xVLi8bMoONCo5vp7GqKM0Ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/142] ARM: dts: am3517: Fix pinmuxing for CD on MMC1
Date:   Fri, 14 Dec 2018 12:58:32 +0100
Message-Id: <20181214115748.140545998@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



