Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A5E214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTwsU5kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A5E214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJKBts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbeJKBtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:49:47 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0602098A;
        Wed, 10 Oct 2018 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195987;
        bh=qYp3W0zpB8fywhIgqsukDCUi2EMH/7i+kA+wPUXd4F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTwsU5kNMeAMe0WHvRaUrDMmMSTY3dVVfn3q3MrmLTeZwLp6n7wzu4d9s5jZxmpKu
         +5Aa6jZjDoOu5McSfsZs0eOoxIO0sxg6Zz2/G/I4pynaI0ykyb7kAdtaYuyI0Xd2tm
         Pp+DL9H7uCRJP6pYEmY2ssQIcfr5ZaAn6EcmIGlY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH / PULL 4/4] arm64: exynos: Enable generic power domain support
Date:   Wed, 10 Oct 2018 20:25:58 +0200
Message-Id: <20181010182558.7034-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010182558.7034-1-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Generic power domains are needed to enable support for Exynos power
domains.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 393d2b524284..3b8e7e6ea6fb 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -67,6 +67,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select PINCTRL
 	select PINCTRL_EXYNOS
+	select PM_GENERIC_DOMAINS if PM
 	select SOC_SAMSUNG
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
-- 
2.17.1

