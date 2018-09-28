Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A48C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC55206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC55206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeI2EUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:20:21 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:45141 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbeI2EUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A31441802B160;
        Fri, 28 Sep 2018 21:54:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net67_629813cc37526
X-Filterd-Recvd-Size: 5128
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:54:37 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Low <jason.low2@hpe.com>, Ingo Molnar <mingo@kernel.org>
Subject: Bad MAINTAINERS pattern in section 'LOCKING PRIMITIVES'
Date:   Fri, 28 Sep 2018 14:54:36 -0700
Message-Id: <20180928215436.29842-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	8566	LOCKING PRIMITIVES
	8567	M:	Peter Zijlstra <peterz@infradead.org>
	8568	M:	Ingo Molnar <mingo@redhat.com>
	8569	M:	Will Deacon <will.deacon@arm.com>
	8570	L:	linux-kernel@vger.kernel.org
	8571	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
	8572	S:	Maintained
	8573	F:	Documentation/locking/
	8574	F:	include/linux/lockdep.h
	8575	F:	include/linux/spinlock*.h
	8576	F:	arch/*/include/asm/spinlock*.h
	8577	F:	include/linux/rwlock*.h
	8578	F:	include/linux/mutex*.h
-->	8579	F:	arch/*/include/asm/mutex*.h
	8580	F:	include/linux/rwsem*.h
	8581	F:	arch/*/include/asm/rwsem.h
	8582	F:	include/linux/seqlock.h
	8583	F:	lib/locking*.[ch]
	8584	F:	kernel/locking/
	8585	X:	kernel/locking/locktorture.c

Commit that introduced this:

commit d4c3be70ca0e7a1ae308bedd3462900c61e97b11
 Author: Ingo Molnar <mingo@kernel.org>
 Date:   Thu Jun 9 12:20:25 2016 +0200
 
     MAINTAINERS: Update locking tree description and file patterns
     
     Update the file patterns, the Git tree URI and also widen the
     scope from 'LOCKDEP and LOCKSTAT' to 'LOCKING PRIMITIVES'.
     
     Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Cc: Peter Zijlstra <peterz@infradead.org>
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Andrew Morton <akpm@linux-foundation.org>
     Cc: Thomas Gleixner <tglx@linutronix.de>
     Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
     Cc: linux-kernel@vger.kernel.org
 
  MAINTAINERS | 16 ++++++++++++----
  1 file changed, 12 insertions(+), 4 deletions(-)

Last commit with arch/*/include/asm/mutex*.h

commit 890658b7ab48d1362a0362df842cecc73c83146f
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Aug 23 13:36:04 2016 +0200

    locking/mutex: Kill arch specific code
    
    Its all generic atomic_long_t stuff now.
    
    Tested-by: Jason Low <jason.low2@hpe.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-arch@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

 arch/alpha/include/asm/mutex.h      |   9 ---
 arch/arc/include/asm/mutex.h        |  18 -----
 arch/arm/include/asm/mutex.h        |  21 ------
 arch/arm64/include/asm/Kbuild       |   1 -
 arch/avr32/include/asm/mutex.h      |   9 ---
 arch/blackfin/include/asm/Kbuild    |   1 -
 arch/c6x/include/asm/mutex.h        |   6 --
 arch/cris/include/asm/mutex.h       |   9 ---
 arch/frv/include/asm/mutex.h        |   9 ---
 arch/h8300/include/asm/mutex.h      |   9 ---
 arch/hexagon/include/asm/mutex.h    |   8 ---
 arch/ia64/include/asm/mutex.h       |  90 ------------------------
 arch/m32r/include/asm/mutex.h       |   9 ---
 arch/m68k/include/asm/Kbuild        |   1 -
 arch/metag/include/asm/Kbuild       |   1 -
 arch/microblaze/include/asm/mutex.h |   1 -
 arch/mips/include/asm/Kbuild        |   1 -
 arch/mn10300/include/asm/mutex.h    |  16 -----
 arch/nios2/include/asm/mutex.h      |   1 -
 arch/openrisc/include/asm/mutex.h   |  27 --------
 arch/parisc/include/asm/Kbuild      |   1 -
 arch/powerpc/include/asm/mutex.h    | 132 ------------------------------------
 arch/s390/include/asm/mutex.h       |   9 ---
 arch/score/include/asm/mutex.h      |   6 --
 arch/sh/include/asm/mutex-llsc.h    | 109 -----------------------------
 arch/sh/include/asm/mutex.h         |  12 ----
 arch/sparc/include/asm/Kbuild       |   1 -
 arch/tile/include/asm/Kbuild        |   1 -
 arch/um/include/asm/Kbuild          |   1 -
 arch/unicore32/include/asm/mutex.h  |  20 ------
 arch/x86/include/asm/mutex.h        |   5 --
 arch/x86/include/asm/mutex_32.h     | 110 ------------------------------
 arch/x86/include/asm/mutex_64.h     | 127 ----------------------------------
 arch/xtensa/include/asm/mutex.h     |   9 ---
 include/asm-generic/mutex-dec.h     |  88 ------------------------
 include/asm-generic/mutex-null.h    |  19 ------
 include/asm-generic/mutex-xchg.h    | 120 --------------------------------
 include/asm-generic/mutex.h         |   9 ---
 38 files changed, 1026 deletions(-)
