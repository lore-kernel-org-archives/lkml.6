Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D2BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061E52173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfAJQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:27:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfAJQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:22 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N9Mh8-1hK9GT0x08-015KyR; Thu, 10 Jan 2019 17:25:09 +0100
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
Subject: [PATCH 03/15] ia64: assign syscall numbers for perf and seccomp
Date:   Thu, 10 Jan 2019 17:24:23 +0100
Message-Id: <20190110162435.309262-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Aqo6N9d9grrvjwZZFEqN/kvQ31MLlDiiylB1bz3l3bnWOkX29Jb
 FIpuJ/jDdTbyft/4m0XHsdrBBVlm/5kn3AxdnjdvfrdFVcnigok/cmoOYzEopX64Kvw6dls
 WX4c0A3ajbuIPBhtDJnOxItEcolnrdicUdlbDH0vyMO4tFgIrLIN3zrBeur2mEJPy3oMIBX
 ZH1cdK/uOrjSnDnCsmVEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DcqPdkrtZkA=:QS9oAutwixmbvSVltaI9L6
 +m9uizBojpDw4Y/KGXSwSjuE5RFBEi7OZQFNyG/xCTeJGtb6VPYkwAOz9MsrA2pxEiUjFa9rG
 fuJdxhEHR1LixU3L7SSftPuAu/E+HMI7cMR38HXeU8sTwYxz1Lhfz/ndk7VKbWpgR6e48hHTh
 52oG4XPC5Sd/bup/d7xyO1GwtMOv8KicBE7MTnwJg30UL0KV+2zy8+uaQIIBfpCDfWM6kjw1Y
 9zf/dxhuEvLX4cTqoUgQnILjvndG21zv6xai7n9Mo8+weKMX3oFsIyKniIqcYSLZpFjZZad6J
 iFX8KqIDD2L15m14S+VUGqz3BXl9nnN+3YZmaY2aCgRLj+1lVPyqEAJNryhh8rK6FIJ8GHxDJ
 b6kKEjdlplavAtZsSD6iylVr6KSzwNw62ShZ5OZvUL5XVI3/keVLJIlNTf9Dj4xsiQPsm/3YS
 hBnYM2p500m6A4e6wcUThTchOc2YPdSSH2b1Gg0KaympGurdwlWM2AnEkcYg+rJMB8ejQK2OV
 FvODRVy/7YsxTrzkyuDInaJdUb6X2TzSWEOoqh1ifvX44kfRzsj3wFkCRTG7Tcl0WUsDB/tak
 aArpMEZ5ewfQfVdDVvG0xAc0R1LMlt+LCk6prUqgqK6D+A4b9mninT6hfcvtpKZL0P1KVrvKJ
 elmxmdqcPPwGsxzlTz8rV4AOm/8m9AoXxIvPJ0wCPLcEf+m+XNV/BH5QBhqwba8jH8VLEyHqT
 16Toqp4Rzx0iHqbsVLKUtulq49kZQX99otz0fw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures have assigned numbers for both seccomp and
perf_event_open, even when they do not implement either.

ia64 is an exception here, so for consistency lets add numbers for both
of them. Unless CONFIG_PERF_EVENTS and CONFIG_SECCOMP are implemented,
the system calls just return -ENOSYS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 52585281205b..2e93dbdcdb80 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -337,3 +337,5 @@
 325	common	pwritev2			sys_pwritev2
 326	common	statx				sys_statx
 327	common	io_pgetevents			sys_io_pgetevents
+328	common	perf_event_open			sys_perf_event_open
+329	common	seccomp				sys_seccomp
-- 
2.20.0

