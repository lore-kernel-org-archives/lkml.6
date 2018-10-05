Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D86C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A42E20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A42E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeJEPbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:31:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53573 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeJEPbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:31:06 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MsJXG-1fsc7G2Jli-00thjs; Fri, 05 Oct 2018 10:33:20 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MsJXG-1fsc7G2Jli-00thjs; Fri, 05 Oct 2018 10:33:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, yamada.masahiro@socionext.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
Date:   Fri,  5 Oct 2018 10:33:13 +0200
Message-Id: <20181005083313.2088252-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
X-Provags-ID: V03:K1:eSd4N3smMHCfUFjJFljqXtcK91JFZmx2RfcWSHInkLBfiD7xq5v
 P264HkIKnrVNh4BWEkE4PHYs5stZrJXLRICxtqFL7AJFD2ujiEQP10LG6VEdC84Ln2wpkFk
 X2iUIHAtxlCSHa323jMrdRQCzq+/aWTnS4B9qZnByyeVl6d9IaDE0lstRH5Dj6LESTrcqsf
 jQR8Gh9qBSnr5Uk7DCr0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d/K1V4pDUnc=:3Rl49oCLPskCTsCWUhET/Y
 eKsqj02irIOQNE4RjLVw5XKTNDCgGbKFNv/pPce0wfisGvej37ZCs6DjKg32JaIExL+yCk0g9
 XLLZ910t60mpQ5R53uA1VNps1m/hkid1CgwdHIbK/Uc1wUHtumV1q0pxPwDgNt1AA8si/wae1
 g/Ob+SWFE2ENq0+/ap94w9Xg9InfHyaQ84sFND8Xzy1mGrB2cup+MGIDgVpQi+QD7HKjRfq6f
 EcxFBccXtNxRQ9HzIwoG6fc9qDox7eYd68B1DbNuxqL6pp4nAGbDUZR5baDG7I0vJDGOiAVKH
 uqUrOtC4tRdcxP0m4U+lnBKRcGwic0WRSfPJKlqcMPFjcOi4hHgjthqS5+3qM9ghA8Y8bVix2
 TBFUSD9TdW0yNngeKAEeCdVBbVi6Pft7DyoDQOK8FHia0Kpe72gjTCdEyVouGEohqhLJQ954T
 GFQZQOxGrgxMBXhLDhuHvcaLg7iMOK+CeHSY4XZ74Ypj713I6S9hRQ2oGmG4hI8ngqbMDhuak
 KkkYgEtBYzoRNsbCdkae44tkvPVu2bQLH92vSJiHbJAZMwTUbCSTLxE5ECFwS2I9LRBQtO6N1
 LDdQQ6GD2SD5OcXrEfBkYDVKOsXOu+n9vgKPvtg/+JVmxupt4xHVAdpT0uvyxAE/LU1sPE9ii
 YCV98HLq+QLSkArfZgNaQ/Yz5HCyITcx/ldvlUBXy2CLtdXz0moAa+1qmHwuYL0x22p0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building any configuration with 'make W=1' produces a warning:

kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]

When also passing -Werror, this prevents us from building any
other files. Nobody ever calls the function, but we can't make
it 'static' either since we want the compiler output.

Calling it 'main' instead however avoids the warning, because gcc
does not insist on having a declaration for main.

Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have run into this problem several times before, and thought I had
sent a fix at some point. Looking in the archives, I came across
the suggested fix from Kieran, so I'm following up on that here.
---
 kernel/bounds.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bounds.c b/kernel/bounds.c
index c373e887c066..9795d75b09b2 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -13,7 +13,7 @@
 #include <linux/log2.h>
 #include <linux/spinlock_types.h>
 
-void foo(void)
+int main(void)
 {
 	/* The enum constants to put into include/generated/bounds.h */
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
@@ -23,4 +23,6 @@ void foo(void)
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 	/* End of constants */
+
+	return 0;
 }
-- 
2.18.0

