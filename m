Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeDZUS6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:18:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752000AbeDZUS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:18:57 -0400
Subject: Re: [PATCH v3 00/14] kernel/locking: qspinlock improvements
To: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8fdcfa2d-7717-5eb6-a938-53524db8ea41@redhat.com>
Date: Thu, 26 Apr 2018 16:18:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 06:34 AM, Will Deacon wrote:
> Hi all,
>
> This is version three of the qspinlock patches I posted previously:
>
>   v1: https://lkml.org/lkml/2018/4/5/496
>   v2: https://lkml.org/lkml/2018/4/11/618
>
> Changes since v2 include:
>   * Fixed bisection issues
>   * Fixed x86 PV build
>   * Added patch proposing me as a co-maintainer
>   * Rebased onto -rc2
>
> All feedback welcome,
>
> Will
>
> --->8
>
> Jason Low (1):
>   locking/mcs: Use smp_cond_load_acquire() in mcs spin loop
>
> Waiman Long (1):
>   locking/qspinlock: Add stat tracking for pending vs slowpath
>
> Will Deacon (12):
>   barriers: Introduce smp_cond_load_relaxed and atomic_cond_read_relaxed
>   locking/qspinlock: Merge struct __qspinlock into struct qspinlock
>   locking/qspinlock: Bound spinning on pending->locked transition in
>     slowpath
>   locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound
>   locking/qspinlock: Remove unbounded cmpxchg loop from locking slowpath
>   locking/qspinlock: Kill cmpxchg loop when claiming lock from head of
>     queue
>   locking/qspinlock: Use atomic_cond_read_acquire
>   locking/qspinlock: Use smp_cond_load_relaxed to wait for next node
>   locking/qspinlock: Make queued_spin_unlock use smp_store_release
>   locking/qspinlock: Elide back-to-back RELEASE operations with
>     smp_wmb()
>   locking/qspinlock: Use try_cmpxchg instead of cmpxchg when locking
>   MAINTAINERS: Add myself as a co-maintainer for LOCKING PRIMITIVES
>
>  MAINTAINERS                               |   1 +
>  arch/x86/include/asm/qspinlock.h          |  21 ++-
>  arch/x86/include/asm/qspinlock_paravirt.h |   3 +-
>  include/asm-generic/atomic-long.h         |   2 +
>  include/asm-generic/barrier.h             |  27 +++-
>  include/asm-generic/qspinlock.h           |   2 +-
>  include/asm-generic/qspinlock_types.h     |  32 +++-
>  include/linux/atomic.h                    |   2 +
>  kernel/locking/mcs_spinlock.h             |  10 +-
>  kernel/locking/qspinlock.c                | 247 ++++++++++++++----------------
>  kernel/locking/qspinlock_paravirt.h       |  44 ++----
>  kernel/locking/qspinlock_stat.h           |   9 +-
>  12 files changed, 209 insertions(+), 191 deletions(-)
>
Other than my comment on patch 5 (which can wait as the code path is
unlikely to be used soon), I have no other issue with this patchset.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman
