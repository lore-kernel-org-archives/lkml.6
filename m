Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C99C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED32075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqxYXddR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ED32075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeJYWws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbeJYWwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0FB2086D;
        Thu, 25 Oct 2018 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477189;
        bh=PBZgxaAtcKQJOKYXxgJoBpRvFt5M/ZbtPiAmSaqBpqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqxYXddRneyeqE7V5X+W1aWicARvWIGVBvgcP7qfZ0oqI9FBZcG8HhiM4WteCxkHs
         228NIfdqc+MhcyUUybkT+6tewGj/qkxNl4pf7P5odNSJ2/CHb2D1vkffKKjaiFzs+3
         aJ1ucArJlrw5QjGUOILQuZ4tXzHEZgUoPKSPYwRQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bo Shen <voice.shen@atmel.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 37/98] ARM: at91/dt: sama5d4: fix the timer reg length
Date:   Thu, 25 Oct 2018 10:17:52 -0400
Message-Id: <20181025141853.214051-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Shen <voice.shen@atmel.com>

[ Upstream commit 0068b2e1b7f925a818fdc0a5d10ef0ad40f746e7 ]

The second property of reg is the length, so correct it for timer.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 0837c1afd666..24e7b237c048 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -939,7 +939,7 @@
 
 			pit: timer@fc068630 {
 				compatible = "atmel,at91sam9260-pit";
-				reg = <0xfc068630 0xf>;
+				reg = <0xfc068630 0x10>;
 				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
 				clocks = <&h32ck>;
 			};
-- 
2.17.1

