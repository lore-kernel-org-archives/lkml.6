Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A721872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfBRVID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:08:03 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:42149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfBRVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:07:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MwPjf-1hESyz1HV7-00sQM3; Mon, 18 Feb 2019 22:07:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        arnd@arndb.de, linux-riscv@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 5/8] unicore32: Fix __ARCH_WANT_STAT64 definition
Date:   Mon, 18 Feb 2019 22:07:09 +0100
Message-Id: <20190218210712.3503891-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e5iV7jAPMPcGjRPi5MYNZ2dkznZ8Mrfx++9ngOzQfg3eN/TiQ1R
 189AXFIfz0cS7YjZUjf7xpRIC+5HGDzQrVDpbwnWeWZYnSH6gDE4OS2+d9PddhFkBcsqNC3
 gkSMnhQ/1X5TPh7cDtrVgQk3tG6Ere1m238Mf0fY6tAGIKRw+GnPuguBJ/QmmtfBExPQkwj
 K2FyVc6iNYGZicULIu0mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gI5wfFjSFEE=:LWNxFn7RL5I+WsBjHLIVXM
 omzfoUukQpkdif1Aifk2CaM+uCLu97sodQrVqAKEmJNvL8vU6Rz9au8I7/6LYLLZ2Xefe1eyV
 yLVyxmJITR7cFaGJFSJZd1M+8eGYej0R3l54Fv/8S8RG9V6H+NHo+21tr+XgtPZI1lIZyCX0V
 7+2ZkslAxXFR1f9dW/f+LURiJgEol+sc9RxYBxrPxZmBSXpOXmIAIHIEUaLPlX3lQmfG7INRy
 6t/+5EEqHWX8EiwZ+IzrT7I4TV5KQwHVLcFvL1bUEHe7VJdUTsEuTWu0cnXqpwfffnPGKU2LE
 fwCgv2n584SKNZjerSO2/h38m3glzmb+jAPCsjG531KFMC3DxlWx/ODxizOg2YBQaaWJAGOrM
 O5DJRP/rCYfLXHLEXJznQHzpFW0iXSrQUdPx8Fqy6+JmUP87frzv0lqxkUp9DBTYzIcAnL23M
 PevSFPAOiAyZDx8D76O37xtLpeUKAZ3WqrhLhuR6rScgKhDLYRZhQAn2LU0ZCuh0pKi2EwSP4
 P0RK0vT6L/LizZRXGqGbc+xOyK0lTz1D1TR1UDUD7KuKGcgcde5rioT/7YltNq2n4OdsmcFkG
 YPsdOCZDgRO/gIiVXOoFxrCLvlhT3KuPIu2ZmnZyKHx7c+72B0dzBTBCtMVIQ96cojUzrxUL/
 g2+5u37brMmdGBJ2Snq66VsTdJMLw2bBbRfwT1aOBa/kfbVBefs52sMhbLLuIaM1hKxxDc79r
 lj/4nMMwaxinhvIehCaknN+7V1PQlxYngbqhyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __ARCH_WANT_STAT64 macro must be defined before including
asm-generic/unistd.h. I got this right for everything except
unicore32.

Fixes: bf4b6a7d371e ("y2038: Remove stat64 family from default syscall set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/unicore32/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 4e5e624f5d7e..54a7378a70b1 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -13,9 +13,9 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
-- 
2.20.0

