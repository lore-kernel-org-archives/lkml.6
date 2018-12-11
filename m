Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDF72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeLKOIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:08:50 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeLKOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:08:49 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBDrM-1gbi7L3ghq-00Chw4; Tue, 11 Dec 2018 15:08:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: fix ARM64_USER_VA_BITS_52 builds
Date:   Tue, 11 Dec 2018 15:08:10 +0100
Message-Id: <20181211140832.567893-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W8udSShYvyH2j34sw3w7eYzyrXFcmW0ipO2ab2+4cFO+lUFO9yo
 4vEbNhJVXBnPirMSNGxF751ms+Suxfl+yOtttZuU5MELGbWxgbWM2CrtN0x0qNMTZo5WXvv
 axMny95TG9XcnYKiDdvtTCxgrO/HPPrhf+28pI/V1UIDDFhZAlliyNALydz2NcdWKowgibs
 GJ2IiBly6lUU0aRqchL8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1Qpeb7539s=:8xA3AuLjgt8wwTfIBajXLl
 vnJtF7/Q4d5RLcKyEy1IUiQKxudnhmgjGJ+GzTLGgA1FWJrYHPu/TGEygNWugRDdDRVswc2i2
 SJzxmdzg59rTxyBpNZZCXiu6X9tRdL2g3P7rLvnWVPWwtRpxI5FGTovyEicHTnVB9W18BwGqW
 2zPCnD47e8JOzKxUZ3ZWeSBYNwGzH7yOwysMvCGQzr9Jj4XgDui2QJFtHyEGbw3R916xsKab4
 k+MrjpcnKlA4wfJACRS2yPSEzBZhwpO7rfxZcqdDLwVpD+xXGx6BWaXXrLsQ9zpgmQyDvAGXU
 pQX6u0flb8d37zeB5WyMY87Pwj2hXXX6gHUIRdz6s3kJdegY7eTWraJ/tRYdXjWDWNqnTEaS/
 TkVfPUN+V6lv6iEYeiwYEoPIGC/NMEMZJ/Vaolxilcy5zNVVls+RQc7ZzlNyS/jub+xw1cv19
 41drbp2H8aIRdLuyTYUtMnhu3lmh3g0eVfhzMEWgCr2uDURP98wq91p/5oPExBTPaRS4kpSP+
 4tdeW5U9xRvYB2aHepNJkdjSxseICkaQPbQkwK09rt3phB96K946Yn4fFFyOFRoHKAW9LKUUn
 GceU417td5P+UJG6QW+kuMK3WICqxVqh42v5ezh+KxTYZnGiwcZNFB9LW3oabW6H2dBmwZhGv
 gzYJmyXwRLNsXPHoNuuPJySK2LmWCN2F4/JXKQhOaCw0fBI+OTfq7+f/2HxX7Ir0/Yy6HEevg
 PXj1AKT32QBZYeLklYKnG9JjUjBlQShW4YNL7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some randconfig builds, the new CONFIG_ARM64_USER_VA_BITS_52
triggered a build failure:

arch/arm64/mm/proc.S:287: Error: immediate out of range

As it turns out, we were incorrectly setting PGTABLE_LEVELS here,
lacking any other default value.
This fixes the calculation of CONFIG_PGTABLE_LEVELS to consider
all combinations again.

Fixes: 68d23da4373a ("arm64: Kconfig: Re-jig CONFIG options for 52-bit VA")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index df201d93697d..a0f3b921b6e6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -278,7 +278,7 @@ config PGTABLE_LEVELS
 	int
 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
-	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
+	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52)
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
-- 
2.20.0

