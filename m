Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CABECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8581721104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0Z6GdTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8581721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeKIHdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeKIHdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:03 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD5E2086C;
        Thu,  8 Nov 2018 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714136;
        bh=iu2hobf1J42qcQE/cq94u1DXhhOx2Mb7dnaaQUHx5OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0Z6GdTKNRHasLHEhyDhg6RtYjTBF1htSDkxUsOU6Yu7cdT83m6NCM5SIufCUAujt
         YKqufsivIWfl4CKtNGu4PhfS+cx0Sfq6AzxZS+dPWlB1CMwfD7hNm0yT9qWzvorHkN
         xisG5REVYvE8b1RRFJPMzmCMfvVkSCu0yk8q4o5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Stein <alexanders83@web.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 068/144] ARM: at91/dt: sam9263: Add missing clocks to lcdc node
Date:   Thu,  8 Nov 2018 13:50:39 -0800
Message-Id: <20181108215059.828478826@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 55eb9c343fdd3611ae3de6ab8a8512f303d3f581 ]

atmel_lcdfb needs also uses hclk clock, but AT91SAM9263 doesn't have that
specific clock, so use lcd_clk twice. The same was done in
arch/arm/mach-at91/at91sam9263.c

Signed-off-by: Alexander Stein <alexanders83@web.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 51416c7d0625..272fdd64197c 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -913,6 +913,8 @@
 			interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_fb>;
+			clocks = <&lcd_clk>, <&lcd_clk>;
+			clock-names = "lcdc_clk", "hclk";
 			status = "disabled";
 		};
 
-- 
2.17.1



