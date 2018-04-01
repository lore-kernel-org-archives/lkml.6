Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeDADfW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 23:35:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeDADfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 23:35:20 -0400
Date: Sun, 1 Apr 2018 04:35:19 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: syzbot <syzbot+f3bd89a5ab3266b10540@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in __dentry_kill
Message-ID: <20180401033519.GZ30522@ZenIV.linux.org.uk>
References: <001a11447acaa9eec40568bd5438@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11447acaa9eec40568bd5438@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 04:01:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 7828f20e3779e4e85e55371e0e43f5006a15fb41 (Sat Mar 31 00:17:57 2018 +0000)
> Merge branch 'bpf-cgroup-bind-connect'
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=f3bd89a5ab3266b10540
> 
> So far this crash happened 22 times on bpf-next, upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6290970458980352
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6577156880596992
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5107570603720704
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=5909223872832634926
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f3bd89a5ab3266b10540@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> RBP: 00007ffd1bbb3ae0 R08: 0000000020000200 R09: 0000000300000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000003 R14: 0000000000001380 R15: 00007ffd1bbb3378
> list_del corruption. prev->next should be 00000000a8104008, but was
> 00000000081c6144

Lovely...  I'll look into that tomorrow morning.
