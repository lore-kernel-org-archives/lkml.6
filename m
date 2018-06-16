Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C90208DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C90208DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936506AbeFPAzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:55:20 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54400 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeFPAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:55:19 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Sat, 16 Jun 2018 00:53:48 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 15
 Jun 2018 17:53:59 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 15 Jun 2018 17:53:59 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH 0/3] Resolve -Wattribute-alias warnings from SYSCALL_DEFINEx()
Date:   Fri, 15 Jun 2018 17:53:19 -0700
Message-ID: <20180616005323.7938-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529110427-298552-24821-19463-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194099
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-kbuild@vger.kernel.org,paulus@samba.org,linux-kernel@vger.kernel.org,heiko.carstens@de.ibm.com,mpe@ellerman.id.au,keescook@chromium.org,yamada.masahiro@socionext.com,gidisrael@gmail.com,shorne@gmail.com,viro@zeniv.linux.org.uk,christophe.leroy@c-s.fr,raj.khem@gmail.com,linuxppc-dev@lists.ozlabs.org,michal.lkml@markovi.net,zhe.he@windriver.com,mka@chromium.org,akpm@linux-foundation.org,jpoimboe@redhat.com,dianders@chromium.org,tglx@linutronix.de,matthew@wil.cx,mingo@kernel.org,arnd@arndb.de,linux-mips@linux-mips.org,mchehab@kernel.org,benh@kernel.crashing.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces infrastructure allowing compiler diagnostics to
be disabled or their severity modified for specific pieces of code, with
suitable abstractions to prevent that code from becoming tied to a
specific compiler.

This infrastructure is then used to disable the -Wattribute-alias
warning around syscall definitions, which rely on type mismatches to
sanitize arguments.

Finally PowerPC-specific #pragma's are removed now that the generic code
is handling this.

The series takes Arnd's RFC patches & addresses the review comments they
received. The most notable effect of this series to to avoid warnings &
build failures caused by -Wattribute-alias when compiling the kernel
with GCC 8.

Applies cleanly atop master as of 9215310cf13b ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").

Thanks,
    Paul

Arnd Bergmann (2):
  kbuild: add macro for controlling warnings to linux/compiler.h
  disable -Wattribute-alias warning for SYSCALL_DEFINEx()

Paul Burton (1):
  Revert "powerpc: fix build failure by disabling attribute-alias
    warning in pci_32"

 arch/powerpc/kernel/pci_32.c   |  4 ---
 include/linux/compat.h         |  8 ++++-
 include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
 include/linux/compiler_types.h | 18 ++++++++++
 include/linux/syscalls.h       |  4 +++
 5 files changed, 95 insertions(+), 5 deletions(-)

-- 
2.17.1

