Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B1720850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfARQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:20:36 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfARQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4i3d-1hC3o90g59-011gmK; Fri, 18 Jan 2019 17:19:18 +0100
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
Subject: [PATCH v2 02/29] ia64: add statx and io_pgetevents syscalls
Date:   Fri, 18 Jan 2019 17:18:08 +0100
Message-Id: <20190118161835.2259170-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iIDCS1VFnyKTHSdfnANmJaXoeSIZjJNeoIeNpmRgK3i74OpuB4O
 eJR7+B640nWU7cI5HbePKVHdmMw6Q9RnL4odwsk7keaOXE1tspGbmTjF+YVFfrsjlCz+8Pk
 c6LKkZNxB5SmFLtBapr7yXQckqoFa5ZTM5Ot72QtiDtCW3tiyH5ohmtPxlTlupzyYoxAsvM
 0njQaJNBq+N6Kmwm2u2RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QhW8nqZCixw=:FEDmad82yIffa62QsVqnWE
 uz1Wrim1T8l4l2nNLg7tI/QVN0sQNBVXDYm/NnsKLv7zs8LehTf6t5+qBRKo/0rh35CYACfnh
 HyaRp8O9EjgYHn8q5sfTDpNC1EA1qlL2VgJV7uFhKZ42rkCb/kvXDCLTj6e4eLqMiLLHwkYgA
 tg/kcev5qJ7IM9ob7D3yzCAq8ni94r1+4puI+m2IXISBpGYQAycFdcpnkAdl25Fp/ndfEZBg4
 YXNQwxFdDSigpL4BqDznMEklcUn0WDgyBJuTIe9s/D6zDgeIZoI7nU3riAsN/dWuWcnbkNnyz
 IId+DwROqDXieCnpGuBiZvOiLBS+urH6rgeCYekmDL8q7krWCyjHp4rvWFx7xcHD1o2VXsGot
 1a/8zGhBF+fqq58MrSp3TEn+6DOva3zIrSvk4tNapXtZZZprR8T75kOgPOvix1rgRrHk4ck8Q
 XG9VJB2f13nJVdtAIWsqENy/zAmWNP8RmLku761b6Sj8zHabwSrP59tSyG90YiRFFrAcrZcBy
 KgsrDJFq33B6rFnPLS6k8KrAwUkLaKXZp2tEwUEl7UxeFy3EamT5ORoeoTGvhxuO3ffTTWGuB
 YHr09kc6nvgYBKaTNvTlODeNk5KwBw66kFtJmW65s3rJj0voBCtwT73q7zm1gdOPRYk7r4ur3
 pOK6QqhYKoWR7gOjVF2r0tazZFTLqGupgU0ddYnvBi9U45R/Ja3Ea+uhLN5Vzw87BFZJr0JNI
 ctK94+FmLls+QETWW952oM3gGqZ4wEKj7crFiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All architectures should implement these two, so assign numbers
and hook them up on ia64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e97caf51be42..52585281205b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -335,3 +335,5 @@
 323	common	copy_file_range			sys_copy_file_range
 324	common	preadv2				sys_preadv2
 325	common	pwritev2			sys_pwritev2
+326	common	statx				sys_statx
+327	common	io_pgetevents			sys_io_pgetevents
-- 
2.20.0

