Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeECQ3h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:29:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34530 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeECQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:29:36 -0400
Date: Thu, 3 May 2018 18:29:34 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.7-rt1
Message-ID: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.7-rt1 patch set. 

Changes since v4.14.39-rt28:

  - Rebase to v4.16

  - The queue went through a big cleanup and reordering, so the patches
    which belong together are not scattered all over the place.

    The sections at the front of the series are patches which are either
    upstream already (4.17), queued in a maintainer tree for 4.18, posted
    and under discussion or just ready to be posted.

  - A large section covers the recent rework of the *_nort/*_rt()
    wrappers. Instead of trying to argue them upstream they have been made
    obsolete by refactoring the code in which they have been used. There
    are a few hard to solve leftovers, but non of them should survive.

  - The cpu_chill() related try-lock-loop in dcache has been replaced
    with a rework avoiding the loop. The rework was joint work by Al
    Viro and John Ogness.

    There are still a few cpu_chill() instances which are going to be
    tackled in the next weeks.

  - The AT91 timer patches have been mostly replaced with the "TCB timer
    driver" patches by Alexandre Belloni.

  - The latest version of the latency tracer patches which is aimed for 4.18
    has been incorporated.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.7-rt1

The RT patch against v4.16.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.7-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.7-rt1.tar.xz

Sebastian
