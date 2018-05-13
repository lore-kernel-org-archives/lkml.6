Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeEMCGV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 22:06:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:14851 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeEMCGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 22:06:19 -0400
To: ebiggers3@gmail.com,
        bot+e38be687a2450270a3b593bacb6b5795a7a74edb@syzkaller.appspotmail.com,
        peter@hurleysoftware.com
Cc: dvyukov@google.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: BUG: workqueue lockup (2)
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <94eb2c03c9bc75aff2055f70734c@google.com>
        <001a113f711a528a3f0560b08e76@google.com>
        <20180512215222.GC817@sol.localdomain>
In-Reply-To: <20180512215222.GC817@sol.localdomain>
Message-Id: <201805131106.GFF73973.OOtMVQFSFOJFHL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 13 May 2018 11:06:17 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers wrote:
> The bug that this reproducer reproduces was fixed a while ago by commit
> 966031f340185e, so I'm marking this bug report fixed by it:
> 
> #syz fix: n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)

Nope. Commit 966031f340185edd ("n_tty: fix EXTPROC vs ICANON interaction with
TIOCINQ (aka FIONREAD)") is "Wed Dec 20 17:57:06 2017 -0800" but the last
occurrence on linux.git (commit 008464a9360e31b1 ("Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid")) is only a few days ago
("Wed May 9 10:49:52 2018 -1000").

> 
> Note that the error message was not always "BUG: workqueue lockup"; it was also
> sometimes like "watchdog: BUG: soft lockup - CPU#5 stuck for 22s!".
> 
> syzbot still is hitting the "BUG: workqueue lockup" error sometimes, but it must
> be for other reasons.  None has a reproducer currently.

The last occurrence on linux.git is considered as a duplicate of

  [upstream] INFO: rcu detected stall in n_tty_receive_char_special
  https://syzkaller.appspot.com/bug?id=3d7481a346958d9469bebbeb0537d5f056bdd6e8

which we already have a reproducer at
https://groups.google.com/d/msg/syzkaller-bugs/O4DbPiJZFBY/YCVPocx3AgAJ
and debug output is available at
https://groups.google.com/d/msg/syzkaller-bugs/O4DbPiJZFBY/TxQ7WS5ZAwAJ .

We are currently waiting for comments from Peter Hurley who added that code.
