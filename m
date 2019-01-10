Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB6CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfAJQ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:27:21 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfAJQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:23 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlf8e-1h7aDx3tBq-00ik97; Thu, 10 Jan 2019 17:25:16 +0100
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
Subject: [PATCH 08/15] m68k: assign syscall number for seccomp
Date:   Thu, 10 Jan 2019 17:24:28 +0100
Message-Id: <20190110162435.309262-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cAxqL4Pr32LfUICErQXLweOdeKXEeQmVpfR3EH9HEknl3Rx7o7E
 3gUWhnJXo/Ubf1H9GjN7gL/hmeHLUh13G8skhoZVYIlxTGcXEAJWfHMK5fqwDp3C4mE6U0X
 qU5L8eRnhl276oNgVKUTHhKQsmD41xIQYhIiHkfU/+doRmo4DFVRig7b6U0yHHq8by33NdZ
 hcAmBJVorlGuA9B3ZJvMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDCus6IHYZs=:59ePj81cYO3U2E3eiWHh1M
 sBYu+VjNywqUwFg/ihKW68e09BYM+B9wyJRztaakMTQXqRhqdEmvZ1ojdiFn0PboHSl1sg6Jz
 lktVPIRNjSHV++3RcDapX5ekI8ig/J0IvxH1f4+g6djzOk81uQeI5fVOD5R8OO0yszdfBId8u
 bb2KyOJqmuC0e+cXrMswmdkk/j+BBIteI5Mmb3mP+1uYhOF+TfOtsnOry98sXfwt5ZUPA9G11
 6Bq2Pyf8idFvfkqnomphG6qXjz59WU2R1Q9Rx7kZwVitLUrtIW2RRr7yq1n7ODZWZGQ2z8AoO
 z24C7F3FN6OHu0pcfqceGVVVuzVusmsWJwQG+I6qPtgtEzJ98nxKoDWen8bapo4VdUefswZ8o
 6W9+k1MDORiZpzr2jtSy9Ndat8iO6D+3zwTqbLUBoNqQtCgrmkHlAGhalt1LHHGyNhOW148bV
 PpMR+nZk7cIlmB54DRwSnuFmOUO6LDwN1o+g/il93UIM6NlbxyI/DWUKjWVYBGVdQ3s6Ic1Zf
 0vSKAXuuihlQy5+pZqwaU8DXbOPv4HafkS3SIDPs2yD4d38mWQptPnqKD/bHDpvp4VJ5b/kNU
 aQ+nkmqzQ/IA01YkCZdy/qpBVvRyBS9YoP7Bz5rdcT7rE/Pq4hpkFgqLOPRpxbuJBNTSr2VaF
 icl78Ty7oQCbEHsFAET4OGF8IzhdbEX4J989KHwG97wdV3IRjqDo/uOxwU7z25q/vFvVzTku/
 IOt8wsJUD0b10sFcR6in2Nc/TFY9E3NMoaCyBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures have assigned a numbers for the seccomp syscall
even when they do not implement it.

m68k is an exception here, so for consistency lets add the number.
Unless CONFIG_SECCOMP is implemented, the system call just
returns -ENOSYS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 1a95c4a1bc0d..85779d6ef935 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -387,3 +387,4 @@
 377	common	preadv2				sys_preadv2
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
+380	common	seccomp				sys_seccomp
-- 
2.20.0

