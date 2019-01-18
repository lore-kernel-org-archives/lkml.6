Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E65C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC3C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfARQU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:20:57 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfARQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:55 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4s8v-1glu2i4Ab9-0023hU; Fri, 18 Jan 2019 17:19:36 +0100
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
Subject: [PATCH v2 15/29] alpha: add standard statfs64/fstatfs64 syscalls
Date:   Fri, 18 Jan 2019 17:18:21 +0100
Message-Id: <20190118161835.2259170-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rSakGMBaEBbAtQUcV3qv3NM7i+OWluASRZee787Xpo3/o23caVn
 QWs5OY5vh9opxy1/zCZ9LY9N9pIJScThNKTMUOE8nA6un262wDIq2Fjhg5yIiWEmn82x0g9
 8p3VeDjI0Rm19xjqPj0Z3FbT5slvuvHZtcUqZPj+gSCMB48TPbdYEEw4VLMKLx07SalqB3b
 h3OVH5LxVZJKnyB7bc21Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lg2Zcst79FI=:RjM/7u0hFuGHZ2BRfjTPMD
 8fbJ1Oqm5cIPC9GeaHvhUwxiy6Kjrm/A90avnT4gPYEGG3drhLEmcVMffAdNdtsLTT2kOQu/9
 9U1iqxCzfMtamHuo+Lvykvje1o1aTsd2rp+F0IR9Sf+vhzfs3Ry1952VDFu0nPS2jVP/yso/5
 /zohi1guOX5+PufGw5W40eWBbQtN7cydGZxEf3WMCnZ1zcVlXCx6sY9+1Rjbyvf1+k0f18R8K
 T2QJYu7012AdY16U6LfPR/21li2ADSjVByZ8E43b8tHba6P1U7dW1+DOogZ+wfBjkG0FW+22+
 hK/j1NbUyVDgs/0sAib43CUyRFQovnEdIJiz9ogsL8XY5ptvCVdCiXlgq8U4xBKgcba8zQ2zK
 zP7aq+pVaAWVNpRw9ucrV0CNZqVVkj6exO56AwQ7TSrWLv2er5omNVTKolhgh+K3vCud/MP3k
 QFUAdqHPpxJFDVWW0QclTKKiM+AqrHzrkW5L2rYyv0TKN+BltH3vLxKleH3bq4UKU3V9M54VY
 149cHyT5F0DL6qHinYu9NHirim1imOhLAhDnmiVl43A3WqSlfS3sTrd2jeYunrJrgAn5huc69
 rDrSDi5snBC3J6gkHsCqMxkqovxLuN0yASzWROjAAglW0rMvI5oSBu5kz+U6ziG7P0chho9G4
 NVjYAQ/GPHW1EJskkpatgeukn2lCfJ97qsSET1mX9q1QVgyHAWcBLswP9TPLd0jQA+/DMuOon
 r0AZp67Be14b8gSfAB9zm3btQOHXBPlWLDZnkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Joseph Myers points out, alpha has never had a standard statfs64
interface and instead returns only 32-bit numbers here.

While there is an old osf_statfs64 system call that returns additional
data, this has some other quirks and does not get used in glibc.

I considered making the stat64 structure layout compatible with
with the one used by the kernel on most other 64 bit architecture that
implement it (ia64, parisc, powerpc, and sparc), but in the end
decided to stay with the one that was traditionally defined in
the alpha headers but not used, since this is also what glibc
exposes to user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 25b4a7e76943..0ebd59fdcb8b 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -456,3 +456,5 @@
 525	common	pkey_free			sys_pkey_free
 526	common	pkey_mprotect			sys_pkey_mprotect
 527	common	rseq				sys_rseq
+528	common	statfs64			sys_statfs64
+529	common	fstatfs64			sys_fstatfs64
-- 
2.20.0

