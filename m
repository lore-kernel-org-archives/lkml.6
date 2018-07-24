Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BECECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39BA205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39BA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbeGXMNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:13:48 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbeGXMNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:13:48 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M5gVc-1fxXDS2Td2-00xcBg; Tue, 24 Jul 2018 13:07:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfs: include linux/errno.h in header
Date:   Tue, 24 Jul 2018 13:07:13 +0200
Message-Id: <20180724110737.3985088-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:EaZLP1ln1XERN2do726xHF8PsMLl8sf2X/ECuPcP5KWpi0zRPfQ
 4CoOa1PxvRmbVUdkLQ9UVZ90Z8FhI/3v4vIaRSySl2eGPvSUPNY5aOZOWfAlZn/jp9FBRzi
 z2fqwz8eLvbniP1fpyhPbM/aJ0MwMnh4Rbk++1zPtATM5yMlFbR+8YczHO3lIZ2xmYejp2h
 GH6viKnvh79JhDz7mhgAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U7a4NBuKkw4=:4xaUhXEBZhYOMUKCAw8I3w
 ojqkyVsxUPnC+noSR1oURxXBvU8M71wfvUjdfD/u2EAz50XqQr3WrHbgxbZ9UOHSGpjFge9gC
 /x1hbpkOh23ewnbmW/5j4UiU0BqFpEJrVHdmiGeqPSRxcUkdRavTRF0hhQb1VMkT4BM0zmnbv
 XDbEERD6LH6r9aZoYa/dSaVEbQ7w9PleBql/UpljOfp0HpCx6tCXA21QWW7bawLVb/F8/N4+o
 q9XppxZcVTX8zCVbxbtH4j0i6dI0mRrYHqKB5G9Dqo3FU0W90jYJT0/wA0jaOE9ghucXhgO2R
 dXzM5Xx9k7WHBSBkJ0Ub07Q6vWzjgyylc43e7yGE0TcL91SM+SkMBPP9gG4ORHMD++X040nYr
 RvGkEB8GI9DOwcAhzyRYv+sJcvnPlbfqGMGipAkiVwdUMgNjOYFlKjo0+QQ6++LZnmj02HwkY
 hNdTVPENxXpyCj2qybH/AKSKoNiWrLzPyDCEC3AVNsb2Xn49knzeuTGi2tsIZrrviaJ1juq2T
 ErsVVkNwb5U8GoRirZ9EqErSpmAgqxwAkD4cAKCqt+eZuO8FhH+F39xNg2jP+yga2zjT3dgOq
 Tr+EKJ6HjxsBSY6cR9L5FCaqIL6o0LHj6APNJtvV6bOqxTIo6L8zRUniZHgx5DztKncMBh8uY
 QTWQKI6VhKRADjxplWKw34GDbUa3lwsShqiY5noqaWy3mXFy6cBMBy03ZRbT6NtJLem8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new gasket staging driver ran into a randconfig build failure when
CONFIG_EVENTFD is disabled:

In file included from drivers/staging/gasket/gasket_interrupt.h:11,
                 from drivers/staging/gasket/gasket_interrupt.c:4:
include/linux/eventfd.h: In function 'eventfd_ctx_fdget':
include/linux/eventfd.h:51:9: error: implicit declaration of function 'ERR_PTR' [-Werror=implicit-function-declaration]

I can't see anything wrong with including eventfd.h before err.h,
so the easiest fix is to make it possible to do this by including the
file where it is needed.

Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/eventfd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 7094718b653b..ffcc7724ca21 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -11,6 +11,7 @@
 
 #include <linux/fcntl.h>
 #include <linux/wait.h>
+#include <linux/err.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
-- 
2.18.0

