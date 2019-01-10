Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B475C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32410206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfAJQ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:26:32 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfAJQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:29 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mate1-1hILjh2T0d-00cOMW; Thu, 10 Jan 2019 17:25:18 +0100
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
Subject: [PATCH 10/15] sh: add statx system call
Date:   Thu, 10 Jan 2019 17:24:30 +0100
Message-Id: <20190110162435.309262-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h4QdAifLam4g7JZ0RiA7Sql/9EWtvVpzCJaWohLb5+jRFokClhv
 9v/OjTvK3x5DsjX1gTUQ6lOp7C5GYphXGZen1IMAu02YPxTyzAdMYoowsG7kkmc/YQOjJPa
 jX7UfF8kf4eGDgsrm8Xa/J/plh2QibVg882GQ9cXpVBd0jyXZ9nSdMk2p9qn1fiHurxOKS9
 El2e2jM1xOn8YE19u03AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QmoIGFVpQPw=:Im57Cbx4QWOknyrADQIk10
 YM4vWHeQCwjtn0jwZHdKXuu65dc+gaH7qoFXIP9/jTL7Xmkc8qqGah6zY5QwkzYmllqQCQ8nv
 qxVuB5lOZZ243zGZAD4TCC+mNRwozDE1BG5o+FnPx+k9o4/LQeYDEn//OPYHs41he9YPOzojY
 90Wcv9veGVctFFVCWIpGv1I+NXVFM+psFPwrFIie5V8H32GUKuL1A4C99y8LVnGmL/OcVBXaO
 J3lno/p8+ma5DQVHA/u3syk2vOThkzDuPVlh2V7MpiZHgIDh4u4VNzM4wzJfRN6aXTjqJ+3lW
 aIRmD099eDt/fDvex11MwxqqjBmatpxug5DVTjgs9DDx0wujr9F7YaBgDckfCKPL/1rLBhPFo
 I2JOPMYGJL95GLRjM4fnE2uOj3RCAg0T7ueBv6Rt2zMHXYqKiEHB+/f4dO2ipScwwM7MbU8i4
 bfY7nnwl+iv7QWTJpdnAX0VOH2ysB1uBv3766MdzVV0JrlTUoBY3FPEaRkzZhiNAvuXdsHD4t
 C9iRTot2FGphsMYModOYHaTrG8HctbzPaCM4OXfA/MfWcZHXsT4VzLKNnK5kvw3ga9rNqwxR0
 f4j3VHuAPYnaiQy4j5/jP3CPhsxrx3vUojaNCAEL/h9zwVUCYlK6OfXfxEJlFfDoNIMaUPVks
 IShmqkYzYphYWX5a882YE2ZFKPo02u/v0S7HbljQbFS5Ut5kCiGvEysl8tFvAHLSFdaUpJ7+y
 CQYKGG6ugXm0Kr9fk5qKrem+LcN4rqj3srtwlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

statx is available on almost all other architectures but
got missed on sh, so add it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 21ec75288562..a70db013dbc7 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -390,3 +390,4 @@
 380	common	copy_file_range			sys_copy_file_range
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
+383	common	statx				sys_statx
-- 
2.20.0

