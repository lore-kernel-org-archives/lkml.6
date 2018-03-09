Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeCIMNP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:13:15 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34809 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeCIMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:13:13 -0500
X-Google-Smtp-Source: AG47ELuxF8pfxWasdKwBtdMnZ+x24vhxS/wpSbr+CDcJuwLLB7WsXQAC3iBou8mPT1kn5+kGsiTnWw==
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Cc: Daniel Lustig <dlustig@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2 0/2] riscv/spinlock,atomic: Miscellaneous fixes
Date: Fri,  9 Mar 2018 13:12:39 +0100
Message-Id: <1520597559-16547-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series is a follow-up on the discussion in [1], which led to the
discovery of a few issues in the current implementations of RISC-V
locking and atomic operations.

In summary, this series proposes the following modifications:

  1. Use lightweigth fences for acquire/release (locking, atomics)

  2. Use the combination of .rl and full fences for fully-ordered
     atomics implemented with LR/SC pairs.

  3. A few style changes (80-chars lines, alignment).

Applies on top of "next-smp_sl_ar".

Cheers,
  Andrea

Changes since v1 [2]:
  - correct implementation of atomic_{xchg,cmpxchg}_release().

[1] https://marc.info/?l=linux-kernel&m=151930201102853&w=2
[2] https://marc.info/?l=linux-kernel&m=152027423529883&w=2

Andrea Parri (2):
  riscv/spinlock: Strengthen implementations with fences
  riscv/atomic: Strengthen implementations with fences

 arch/riscv/include/asm/atomic.h   | 417 ++++++++++++++++++++++++--------------
 arch/riscv/include/asm/cmpxchg.h  | 391 ++++++++++++++++++++++++++++-------
 arch/riscv/include/asm/fence.h    |  12 ++
 arch/riscv/include/asm/spinlock.h |  29 +--
 4 files changed, 615 insertions(+), 234 deletions(-)
 create mode 100644 arch/riscv/include/asm/fence.h

-- 
2.7.4
