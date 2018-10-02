Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DDC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A0920684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A0920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeJCD5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:57:49 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbeJCD5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:57:49 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7auL-1g62mr0qsv-0080vt; Tue, 02 Oct 2018 23:12:16 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7auL-1g62mr0qsv-0080vt; Tue, 02 Oct 2018 23:12:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: arch_timer: avoid unused function warning
Date:   Tue,  2 Oct 2018 23:11:44 +0200
Message-Id: <20181002211214.2672576-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:CJRvB1nT2xHgVp25Uun+bN7R5JwgkVt8LEcBJpQGDFyLk3RLvzM
 EROZeiG0AqeUFQHr5Q3tX/n1iR22tpo3euQjY6LkN3fkoFlIMsFopF94OwEcC3QfC/si9CI
 0ykWpWsmeQkCyEh5xJulftxOffl+29CRZNE2DWR888xsClsaMsB5jVfGOYiy2H4G3MTGkCy
 xFuAb026cxO1MMNmc6+yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/JyWiJX2rA4=:uyUj5Xpvmr+Kqzjs/cQCcz
 8xE58r3kt+woSzcyu5H9fZ5CGpLmDG3lHG+fPZEEFkFSQ0ED4EVJKzvBSWM9vrbwzMi1Vi2As
 SgTX9DcStVIzUzAgRVN8qL0A+2lp3jaPG92+25jLvganM4si6FCJwyCYgsQidzBX5o1UDIN+v
 7T/GYj5EGxq+adUzCv68L0NThI3P90GrKfitdysuPYSKSgQCVH0WbIHQZ0clRgBwERTCNQWvA
 pKRz3mbKVzjIQL3O2pkbgqI2BO8XFII9tQteN/UCPp4Qo6PLwGZuBf2oO4waprfoiMPaorESg
 /SHb0Rcj+cunh2yQtOLIUXsNEhls87aqFQURKAN1YpmkKFQYu1nFbZWZ8HEJVWa3s9L/BxwYj
 YQmZnEnKx1fXKK7XqYqaJShctuRTNuJRlVwOxn06bHXChkRXclTiVaNj42rfMTSCyyl1ocgIT
 bSRvntDaGye0QcoEVv8cFkDKiues6AgpX3qquNuOAMs2CeEMHs2HFcrNVh4b0r26mGaGHh5VQ
 BdxXCrBqqnejSpkI2Sz6hgHR9IYzhLHB4S7IoeCDuvqZbwJjLIIwigvuOb7eZTzSmjwAuyhSe
 i7l+i1QvQ1mkd03OarXU/izfOrVHaP/NVYcr1FMUHoQHvrnTXeFdAZ/gHLx0EsCpahWGgkF4L
 8InJ/VtcDBHkp5EPahNl7mDQfUx87Cw+/7yK2UxpHpLpgki0fnR75rdVIAnioSKTmo9o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64_1188873_read_cntvct_el0() is protected by the correct
CONFIG_ARM64_ERRATUM_1188873 #ifdef, but the only reference to it is
also inside of an CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND section,
and causes a warning if that is disabled:

drivers/clocksource/arm_arch_timer.c:323:20: error: 'arm64_1188873_read_cntvct_el0' defined but not used [-Werror=unused-function]

Since the erratum requires that we always apply the workaround
in the timer driver, select that symbol as we do for SoC
specific errata.

Fixes: 95b861a4a6d9 ("arm64: arch_timer: Add workaround for ARM erratum 1188873")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 130f3a766aef..0661c6103c21 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -483,6 +483,7 @@ config ARM64_ERRATUM_1024718
 config ARM64_ERRATUM_1188873
 	bool "Cortex-A76: MRC read following MRRC read of specific Generic Timer in AArch32 might give incorrect result"
 	default y
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
 	help
 	  This option adds work arounds for ARM Cortex-A76 erratum 1188873
 
-- 
2.18.0

