Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeBGJIN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:08:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751146AbeBGJIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:08:11 -0500
Message-ID: <1517994487.3996.7.camel@redhat.com>
Subject: Re: possible deadlock in rtnl_lock (3)
From: Paolo Abeni <pabeni@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+63682ce11532e0da2b9d@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Vladislav Yasevich <vyasevich@gmail.com>
Date: Wed, 07 Feb 2018 10:08:07 +0100
In-Reply-To: <CACT4Y+ahGbrH9BGFeAfRW08jJEWfWf7ovzP9vsHZVQ4-KM5hTw@mail.gmail.com>
References: <94eb2c07fd4c75cd8705648eeb87@google.com>
         <CACT4Y+ahGbrH9BGFeAfRW08jJEWfWf7ovzP9vsHZVQ4-KM5hTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 19:00 +0100, Dmitry Vyukov wrote:
> On Tue, Feb 6, 2018 at 6:58 PM, syzbot
> <syzbot+63682ce11532e0da2b9d@syzkaller.appspotmail.com> wrote:
> > Hello,
> > 
> > syzbot hit the following crash on net-next commit
> > 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
> > Merge tag 'usercopy-v4.16-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> > 
> > So far this crash happened 2510 times on net-next, upstream.
> > C reproducer is attached.
> > syzkaller reproducer is attached.
> > Raw console output is attached.
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+63682ce11532e0da2b9d@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
> 
> 
> Paolo, was this also fixed by "netfilter: on sockopt() acquire sock
> lock only in the required scope"?

I *think* this is fixed by the above commit, anyway I'll probably be
unable to verify such statement soon.

Thanks,

Paolo
