Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6754DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5225401
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iytV47+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B5225401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeFYDfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:35:44 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:50442 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeFYDfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:35:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w5P3YrPZ012508;
        Mon, 25 Jun 2018 12:34:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w5P3YrPZ012508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529897694;
        bh=mnGLruqlKKCL7Hp12gMKZFZ6jyP3pl0EqnTnLbLtjb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iytV47+VfXYRgtgdxndYcNwF3yA+AwwIVz+zhokDg2abJZAWGl2XJ6Z/LX6mSAdPf
         Unm9kg4VCYwGjoHLRjo/4WoKFKaGd+UInCrnOkcRzqUaTQuqN+B9BuG4pcgvFPfZps
         8nPeyAGazNiw9hwEh/ymOFKIPOiYfJXoHCNqqshQlN8PfAI7aoZnWIGYoyNdQ7p7dk
         XrmYmhr1ReUmdl11kINccLBQExsZ01x0/WBh3aVe/SA3+3k838J8eyL2kEmN/DRX7V
         uy6rQwcV6K5o86BVfjsU0h7aquZQ7L4pKSJkDhWom4Q94FT/E6jYj3MkYQqoT4JVFN
         Jdx8kjf4YLgag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: uniphier: select RESET_CONTROLLER
Date:   Mon, 25 Jun 2018 12:34:45 +0900
Message-Id: <1529897685-15029-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529897685-15029-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529897685-15029-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UniPhier platform highly relies on the reset controller.
Select RESET_CONTROLLER to enable it forcibly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac3..f34cd1b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -261,6 +261,7 @@ config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
+	select RESET_CONTROLLER
 	help
 	  This enables support for Socionext UniPhier SoC family.
 
-- 
2.7.4

