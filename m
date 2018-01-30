Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeA3W2R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:28:17 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:52134 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3W2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:28:15 -0500
X-Google-Smtp-Source: AH8x224dnUyxIv9NCZeQ5G8X1OkC8fzqWkIZztChoBMGH/4XaF37SYRbytt/M/P8eWHLeQd7cVtBOw==
Date: Tue, 30 Jan 2018 14:28:11 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzbot
        <bot+d3f5d339869eb8cd834d2c9f0a88bf4f05c29781@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: spinlock bad magic (2)
Message-ID: <20180130222811.yxfiqnlx3la3vyyw@gmail.com>
References: <001a113fae28c2fd6605609c97a2@google.com>
 <6dbd4f85-f3f2-97f3-5b82-451276fbf877@oracle.com>
 <CACT4Y+Zoat=3j7B--D=pLK=SU0zhNA2yw0O0cEwj_p6vSBfM7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zoat=3j7B--D=pLK=SU0zhNA2yw0O0cEwj_p6vSBfM7g@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2017 at 06:01:30PM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Mon, Dec 18, 2017 at 5:46 PM, Santosh Shilimkar
> <santosh.shilimkar@oracle.com> wrote:
> > On 12/18/2017 4:36 AM, syzbot wrote:
> >>
> >> Hello,
> >>
> >> syzkaller hit the following crash on
> >> 6084b576dca2e898f5c101baef151f7bfdbb606d
> >> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> >> compiler: gcc (GCC) 7.1.1 20170620
> >> .config is attached
> >> Raw console output is attached.
> >>
> >> Unfortunately, I don't have any reproducer for this bug yet.
> >>
> > [...]
> >
> >> BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
> >> IP: rds_send_xmit+0x80/0x930 net/rds/send.c:186
> >
> >
> > This one seems to be same bug as reported as below.
> >
> > BUG: unable to handle kernel NULL pointer dereference in rds_send_xmit
> 
> Hi Santosh,
> 
> The proper syntax to tell syzbot about dups is this (from email footer):
> 
> > See https://goo.gl/tpsmEJ for details.
> > Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
> > syzbot will keep track of this bug report.
> > To mark this as a duplicate of another syzbot report, please reply with:
> > #syz dup: exact-subject-of-another-report
> > Note: all commands must start from beginning of the line in the email body.

#syz dup: BUG: unable to handle kernel NULL pointer dereference in rds_send_xmit
