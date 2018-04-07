Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeDGJIJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 05:08:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42620 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeDGJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 05:08:08 -0400
Date: Sat, 7 Apr 2018 11:07:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180407090754.GP4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:50:19PM -0400, Waiman Long wrote:
>   # of threads  4.16 kernel     patched 4.16 kernel
>   ------------  -----------     -------------------
>         1       7,417 kop/s         7,408 kop/s
>         2       5,755 kop/s         4,486 kop/s
>         3       4,214 kop/s         4,169 kop/s
>         4       4,396 kop/s         4,383 kop/s
>        

Interesting, I didn't see that dip in my userspace tests.. I'll have to
try again.
