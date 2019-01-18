Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57544C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FC52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfARQUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:20:45 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfARQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:40 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzz6m-1h7x482Ucw-00x1wT; Fri, 18 Jan 2019 17:19:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/29] sparc64: fix sparc_ipc type conversion
Date:   Fri, 18 Jan 2019 17:18:17 +0100
Message-Id: <20190118161835.2259170-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E0WLVEaCcQzfD09xtrq4A5jWMomm7adRfer83EpRAVfp369asuy
 x3/FJ1daGxLmHv7isfyBmmw9CiTpRNTIZF5Gr3d8LXmER0Y68fJAFAfjaBn0f4G0BGnMaQx
 x2SRX/iEk+wXVeqe10GMRlxV+Tfz1UGHqVsgCFYxSmbS+xtCO7zPPuk3cos5G9lUpWYPzzZ
 Cd+cyB2Mh1kEIhZmabg+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8fLlZM0o6k=:bhl6IpqDxoJ6kbMGE/L2Hc
 CzXueO2oa5jGlTL6WLnsLYPOBF2mZVhxD5AP4llrcKg4Do2nFrxENghqjFTLAbPL1QsxZXc/b
 LnpyH8IuA+uVRH8S8x50ONY5YeJxq+2QhNxaH/wLHtFKi7z8USTpeeVUZCXlul0nja0gF6rOO
 LL1USYrfYH8u14o6qjYuV81dwO272SuobC89RmEf5pmmulouyOUgkcp/shSJww4iWgefqz74u
 6U7B4Y+732hH50WeHW+jmK2UZNpQy29Zjoe2j/U7CTNx8BE+Gkr54u55/Lh2JunMk9s/og4TR
 dsMViyBx2kjJjkgEqxuWmHUTNlQu51BtfQLyRTAWbgOz01AACB59xRs8hgCJSfM1qdrhWxkWx
 b7Mf3ttpjFoH/yCzfhmqtBVJbePhcOvcZVDbx2TI+CZIobvf1sZQslNdYpNtm1VH178fbI+5B
 Ec2CtgMHKExKURICO74Kg//YVBx8XEU6LSNaZh7pucWUly+BVsVaNCdnU6hItAL/BM4GqJnT+
 w0oS45C/vBaPsuwz0142f3Y/62Xkn18OPu9YZUSlAzq7LM9Pe/9K5fmgYrLaC9FSDljZuydmq
 jykoWGCnNNUhJI5AYsoroGoYkVnN9Ec9lvj5OEb2n9u0Buc9VIYHXAq6knDPefHHxymWenmkD
 roYvKjwcBwNJpHKmEGmj7QZzsVbJDYDPSFwoNNBDl7fi9IWX3nVa1iRT0iAn7dyxgKUgZltdI
 hQ4oQT3HJwHWivAfkNceN5wG99AQRLWvlYiWXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kernel_timespec and timespec are currently the same type, but once
they are different, the type cast has to be changed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 274ed0b9b3e0..1c079e7bab09 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -344,7 +344,7 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 			goto out;
 		case SEMTIMEDOP:
 			err = sys_semtimedop(first, ptr, (unsigned int)second,
-				(const struct timespec __user *)
+				(const struct __kernel_timespec __user *)
 					     (unsigned long) fifth);
 			goto out;
 		case SEMGET:
-- 
2.20.0

