Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEMKrI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 06:47:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:30413 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMKrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 06:47:07 -0400
To: dvyukov@google.com
Cc: syzbot+3417712847e7219a60ee@syzkaller.appspotmail.com,
        miklos@szeredi.hu, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: KASAN: use-after-free Read in corrupted
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <000000000000eec34b056c128997@google.com>
        <CACT4Y+aRyMWXS0K0bqAVgBOTh=vXEY0dwM91vdSkJ75zgy+k-A@mail.gmail.com>
        <201805131920.GJJ58398.OHFVOOSQtLMJFF@I-love.SAKURA.ne.jp>
        <CACT4Y+asb-Anvn3ENyUVDGVivFUDT5XXz750ioi5MqWDtgvwRg@mail.gmail.com>
In-Reply-To: <CACT4Y+asb-Anvn3ENyUVDGVivFUDT5XXz750ioi5MqWDtgvwRg@mail.gmail.com>
Message-Id: <201805131947.IJC65168.OOFOMFJHLVQStF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 13 May 2018 19:47:05 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Sun, May 13, 2018 at 12:20 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Dmitry Vyukov wrote:
> >> This looks very similar to "KASAN: use-after-free Read in fuse_kill_sb_blk":
> >> https://groups.google.com/d/msg/syzkaller-bugs/4C4oiBX8vZ0/0NTQRcUYBgAJ
> >>
> >> which you fixed with "fuse: don't keep dead fuse_conn at fuse_fill_super().":
> >> https://groups.google.com/d/msg/syzkaller-bugs/4C4oiBX8vZ0/W6pi8NdbBgAJ
> >>
> >> However, here we have use-after-free in fuse_kill_sb_anon instead of
> >> use_kill_sb_blk. Do you think your patch will fix this as well?
> >
> > Yes, for fuse_kill_sb_anon() and fuse_kill_sb_blk() are symmetrical.
> > I'm waiting for Miklos Szeredi to apply that patch.
> 
> 
> Thanks for confirming. Let's do:
> 
> #syz fix: fuse: don't keep dead fuse_conn at fuse_fill_super().
> 
Excuse me, but that patch is not yet applied to any git tree. Isn't the rule that

  If you forgot to add the Reported-by tag, once the fix for this bug is merged into any tree, please reply to this email with:
  #syz fix: exact-commit-title 

? That's the reason I keep

  KASAN: use-after-free Read in fuse_kill_sb_blk
  https://syzkaller.appspot.com/bug?id=a07a680ed0a9290585ca424546860464dd9658db

report "open()" table but I want keyword column available in the "open()" table
so that we can announce that "patch is proposed and waiting for review" state.
