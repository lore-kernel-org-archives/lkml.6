Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE43BC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B8C2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EnxRTnux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B8C2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeJCHFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:05:30 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:17535 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCHFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:05:30 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w930IZSn018610;
        Wed, 3 Oct 2018 09:18:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w930IZSn018610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538525920;
        bh=K6zJLHhpR6wnv7vRteZ77XPpnbrHj6ZKljftNXn/28I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnxRTnux5vnystqJyqEj9dXn8o/ahsOGcGaZWeSZnZgztYCxhPccBJjQVGu2NT933
         S25vqTiaV1Woz78WIWqFt8CuIbrTdnF22BC+wbpERBgDtNNoZLLdjvE1En+p9xRAbK
         2Q8ioxcocBPzP0gAl6Bh853kjZ9Mv5ps+OQOgklUNMt7/lWB4POkDDB4odw+1afB3s
         YbOGFhI3zHPp+f1Xe9jT61TmHor5f7V/khp81yF8DiCS5Bxph8XAYpHiV+pvBFuZSO
         BNSsimSG6NMyAJ97LrlIBB+GFdgSQymwOuXe4fz6TiYl1+KW48xsrwrSPt57LPtf/Q
         z0FBei5rl5D5Q==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: defconfig: enable CONFIG_MMC_UNIPHIER
Date:   Wed,  3 Oct 2018 09:18:23 +0900
Message-Id: <1538525903-22548-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UniPhier SD controller driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..a15016e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -520,6 +520,7 @@ CONFIG_MMC_MESON_GX=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SDHI=y
+CONFIG_MMC_UNIPHIER=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_HI3798CV200=y
-- 
2.7.4

