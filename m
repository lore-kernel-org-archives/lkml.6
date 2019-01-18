Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46592C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4A520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfARQZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:25:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfARQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:34 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mz9d7-1h6a9s2Fm7-00wCau; Fri, 18 Jan 2019 17:19:19 +0100
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
Subject: [PATCH v2 03/29] ia64: assign syscall numbers for perf and seccomp
Date:   Fri, 18 Jan 2019 17:18:09 +0100
Message-Id: <20190118161835.2259170-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2+79bnr8ZMppmGxfaffVCG2dp2/wwc6gEdzbYANW5JYZND/0OwS
 MAt33/0YNXlbqd4mO5SoIU4aXs5yE3a789oiPqsjKE3w1+eLlrkfY674jum0juRLN7MOuaL
 i0PBboitySA9E6k0frFnstFkZCm1ySbhyQqt95A4tdxW+Hr/ScPMoiVcmlREtKxzMCkToGj
 Md1rhYzZ2FzECNJvkjCmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipIgTsan9yc=:0MeISoJzpLGvk/kWrCIBlv
 S+Yw/qQPnhjymS19cJ/UIUWkohjKJyNd8hwSs5uQStf5qGBeQGt4lidllvnuoi2JQUe1aaNAu
 wAUx4uxnjlHNMprhMTX8qQu2QtxYfjuHBG/4kpgbsZo+toZ0ty7UAaD50PDiySl0LcdI7QbR3
 r52Qm/078mebTyywwL/QBoniWGO1Z2t1jDfOovAQnxNofzf2V/kEReO2RkVGFmTdizU8RrAFt
 KQzu2z/2pU1b/90ZpGBykBm14Sul0qRK3gdWRdSQsNfxtgqDixdwEwgZC8KN0JLJiqiyRbNcK
 btfjx3QOj1GgQiTw+nLdhduXDaOxDNN8LOhDH+CbNlqqa4GBRg3EUSD2AT7Vk1xoZWZjpX9dI
 vrnMSvJKOh0qBopear2NsMeNciro1+A2M067Lf+D51UMrp5aFr39y0RnVSAeTLUR7O5hc9IHt
 nlHo6D/XmhGtdnXx1s9tHkTONpiNJyd0WhXsABDf5GmlPZQW0TT2n5Q4jhHT2tX5zAXqROdyK
 PQfa5ZtBKGQKVQpwQkf2IMyMvKpvSVugsw+At8Qm6XRs0QZo+4yJ1dpzEyEhGMTqEfVjWu+zg
 8N6buvae3MJrPiQ46uDjQr9ykQkEREpv6gdpV9J+Syg41c/SFkqsqNVbzDU01S0/c2FEtaPH7
 3VbtQ55muhFQhJjw6VnbM1w8SqUKPBYMbF+3e3HcXW4JIGzx3sUorsx4D/f+kUH16UkUFZlrY
 ruE6J/9I90uB5Q+0TZ3djyNQLumSrHOHI2enUQ==
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

