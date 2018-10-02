Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6613AC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309FA206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309FA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeJCEC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:02:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeJCEC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:02:27 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MD9Ox-1fyLMj0RiD-0096jp; Tue, 02 Oct 2018 23:16:52 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MD9Ox-1fyLMj0RiD-0096jp; Tue, 02 Oct 2018 23:16:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: dcdbas: include linux/io.h
Date:   Tue,  2 Oct 2018 23:16:42 +0200
Message-Id: <20181002211651.2804717-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:YUpQ2hynRTLDMh3eETcXmDqRdExw19YSARWVjOOKA7HKYcjxxWC
 5XjZxGoo5SOeHuAV8oKOYGGtknMq1ZCgfzZN7bkhcEQEp9eGqrOv13EW3sY6ld6TGRPjvPz
 wlHLQfxZTAFSgzGvh+EMm0u3rBgSCf3bbpFgz2ESOBe71AbG9BnvrSOFDa4ikTTg6YVyTEw
 JEd9SWmXZrmMddyXaVbPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QMDZ1k1GCGc=:VbbCinFo10uuikBO6LAfXm
 wFhwa0ppvTsW+V6uiDSfoFdqyI1VUDOPxeWK2N1dE/J1Z9SCRfkuVuakCjl4iMQs5DhM6pn5m
 whO7DphvS2cQXmsguAp6QsDx7/gP0LU8jakDKdlnJM/EpUU8hVfptp4iuVYzFYIiV7s+SnuDR
 1OlJUJsm+3KOFSuj5MPsaAtosK35pCUy5mNUNFECAdonNnx2/NFprFlTQNeMuhjsFSzlo8mfg
 gJkxgoTHQP1qxQR2qRBgSGJkfjjeTSLKjJwmSQTeN97QeTkeC1UxPw5kdbCJf02RXP5t9Jbyz
 +BpTF1lv1cxQmJ+4ElWPsjb0scexxLYluy9P7/+MKSbDRCbVhAsH5RCPOIvBkrqnxjRHo7UN1
 vy/QKJ+4nabwIayFOP2HpekNQguVQElhqcmV+ognJp6XTvdJyw+Dp5s3lj9hiKGKj+ePKGSA7
 dhk2jVO928p/jum2kqQwhgtCyt2EMyjhvpkg6TACNPFwLPdip7gj2I50EmZvfd0nzSWrbj0Vy
 9ZQKjXA6w7qCjvfWFpujs59YZe+c64fBGwcl+Dnnpp7UlwD3mi5Wku3FUAgGOPDhz2W+nI7vM
 KZUZl6BtRwVUp6AbAMkXPmMH4dKJhzAbYXtQiFxPg3QBZD8edWeMubypjqK2L5fYtXMIP5EI0
 EhHdFxKs/2C0AoJ6gFsTC6alVAEEXAC09Le35T49doe+lhfuL5Bz5vORWD4Nh2GHCYrU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memremap() is declared in linux/io.h, not in asm/io.h, so we should
include that header to avoid build errors:

drivers/platform/x86/dcdbas.c: In function 'dcdbas_check_wsmt':
drivers/platform/x86/dcdbas.c:572:15: error: implicit declaration of function 'memremap'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
  eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
               ^~~~~~~~
               ioremap
drivers/platform/x86/dcdbas.c:572:61: error: 'MEMREMAP_WB' undeclared (first use in this function)
  eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
                                                             ^~~~~~~~~~~
drivers/platform/x86/dcdbas.c:572:61: note: each undeclared identifier is reported only once for each function it appears in
drivers/platform/x86/dcdbas.c: In function 'dcdbas_exit':
drivers/platform/x86/dcdbas.c:748:3: error: implicit declaration of function 'memunmap'; did you mean 'vm_munmap'? [-Werror=implicit-function-declaration]

Fixes: 12c956c4f32e ("firmware: dcdbas: Add support for WSMT ACPI table")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/dcdbas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dcdbas.c b/drivers/platform/x86/dcdbas.c
index ae28e48ff7dc..daa7e3574568 100644
--- a/drivers/platform/x86/dcdbas.c
+++ b/drivers/platform/x86/dcdbas.c
@@ -37,7 +37,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "dcdbas.h"
 
-- 
2.18.0

