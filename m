Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA767C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92966214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfAJQ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:28:11 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:35285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfAJQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:28:08 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3bfB-1hOpxi10ex-010gXM; Thu, 10 Jan 2019 17:25:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 12/15] sparc64: fix sparc_ipc type conversion
Date:   Thu, 10 Jan 2019 17:24:32 +0100
Message-Id: <20190110162435.309262-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8LjwLF71onD7Un3igtIcMvlIPZOlhlWUzQRoDccuK5lL0rN5NIV
 3nd9PCzb2nQdqQGzIkmdHxgElT6H3c8JzOETRrNb/eN8Z8I6WwBRWsQELv4pGUHfxbWt0fM
 GzgRAOsetyOd9IeatPWWGPu/dnvSY6mChK/iYK7FaIyDgWu+fwsSDLwxUJrfQ/jg0vOF2D0
 ftdh9RqhNUIobjsFwQMQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s8zXH90QMCw=:+hTFXoQYh8mxeKimTxGxqF
 B15Jc3L5v0MiV6tI6llMIqx0rxi62AMEjpKJYLfABiIOuBA0OZNI4pqIHG+Lr2AozjOp2vyOO
 oEy7CktmKfYEPLF7mWOjP+1OqUEiX/b63rkbD9BsntlgUUVtQQgfQq2ToMomFxkNGDuvNlzkx
 luhRPvWjxFkLPWrvmv9VwAUYmySUTIFTEPLmGFxmanA/9C5oKIcgC6zaxsb0jejPmoUN27iDh
 aI9l07d5W/psSP746zO6UKwmb20CBnpgbYUBv4q9vTjCvzgq09qXojGdBuCAtPthHP5fo3Q5B
 qYnD91TYbaM1kgyxVo1rIi9cM5oS3Qj3kwk2u9DIW9E3jTHeECrsgiYg7hk2f3uoOeyzRGPoJ
 jxmPSH7+m+JIyCsYirjUZl61OPqhGg+hS1q2EQqvSsEfAQotaR0D819svXVDZ610jlTej5NfT
 FIEhJdTp2bS2mBK75c7MWdtXbEv8qQ4czm0NbjvIlpi+vsc9I9jWSuLyRiiUZOTJEtov84nAS
 xGHqWmBtkTP0Nz2e4o2ZUnNg6lB3j8uN7h5Ynt1L9vXfI7xNdfgdZkDib+7gyFKruD9aty/xF
 JXvb6QH3haQd3X3624R1ncC0ZWInsyb2fM3JzOnuaPCaD7/FZkTlb0fVBcdgcFtU3Gx1T0GrF
 1rV3kz54uhPnX0uyH1Tg114rcmdAL5fposyPDBa+BLOHTnliVs2l1fk26274baGkuCyK+rzch
 FBT4zGaPABq987gfcJdg6qe33BoaIXhKLLr2OA==
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

