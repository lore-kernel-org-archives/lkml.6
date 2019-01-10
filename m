Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4CBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfAJQ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:27:29 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbfAJQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:22 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3UdI-1gh5Av3nYQ-000Zdl; Thu, 10 Jan 2019 17:25:08 +0100
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
Subject: [PATCH 02/15] ia64: add statx and io_pgetevents syscalls
Date:   Thu, 10 Jan 2019 17:24:22 +0100
Message-Id: <20190110162435.309262-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jZ+pK1soglClNV8JzDCTro7NHj/jUQtDuwPrtlNj70FE5cXaEjQ
 r+SHifgmj/OSg7YZwhAOnPSW9mMqXmoPHKnySSVlYLAvZ5Qhmn0Ta+SNUS25ZKwBP+7W0FI
 oC428/ece5QP7XVIUK6jj6GfWl2BehhsCgBk1eJ35E6ipEp+AkgoJ4p50hpr3L8WlpiANBy
 Ux+9nIr/6cdCw6+aDpHaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VEnbB0N4QPA=:rFF45PK4fVaAoP1KJQfuTu
 qvzYM8C+SXZ0bdt6/VS1aHwqCz9bxt9HM0Dy+SmyNnsMPzSGOvYUznlNmPBP7WaOWN0H5/Hsk
 wxXtf6q9lDrPBVeh9tGtqh/pqc3fNDVJGBwe7R4H4MOKF5gBFDjdrUfh6kTv/6hZ4VFGEfXPu
 k9JND7wy/Q2wfIh4iR74yZ8OK6p5d2VXYILYRlJt5yqqV/4vm0mIg4RabkqYyniSDjAqoA/yR
 4neMRN765leyRi0iM7/PySopaHdETBP6GgGXogfbu1sh98uM/8LzEo5BgiQGRk3LNOPzb6kHL
 dzaPrOjflqNJGjbPhhKSRmG3IMKFRiyLtGNf0B9RcDIteLZiWGBTgOR3iASyXUwTM5jbvHYgO
 xNSP+vUMJY+PDeHm4b8Yy64mS1bUGhxJqdytmPQcSw63vqGswdT1vxlphYGiDQeqHitDVFDrI
 Soez+KleqeFa8mcLOsKe6ZMqPJTG1MqVfOmsdnuwKJy2UUWy5aNh0BsMpbD7/IwUBv+XL8MZJ
 EtPa5ZK1i/IEf6wgxy8JWdU8NQaVBJ19YEXykvAAYJ11RWKsFBUGULs64DI7sN91HITcMOMPB
 5EpGhU0ofNb/PBtMBhqlZdNvcgLmG6FvIw7LhcS+IHweR6qjnVPU+vtRy3UrhpKJiLKuQgrwS
 RgCxnAOj/yl+1DloOIxpgLtvFmKTkShVrAJU0h3SoLsnuQ3+rkRvC0iczX5xOWaXZebvIKRH/
 7WlXNpAGcwfi5K0UvkY0Ar+HWNEg1kGaLHiv6A==
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

