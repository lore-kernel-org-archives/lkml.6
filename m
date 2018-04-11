Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756835AbeDKTpt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:45:49 -0400
Received: from ja.ssi.bg ([178.16.129.10]:38812 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754733AbeDKTpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:45:47 -0400
Date: Wed, 11 Apr 2018 22:45:23 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Dmitry Vyukov <dvyukov@google.com>
cc: syzbot <syzbot+3c43eecd7745a5ce1640@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: possible recursive locking detected
In-Reply-To: <CACT4Y+Z3Ktnio1B0TAZpx8HOEfd2evwyQqbMeWGvEkzh0yfhKQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1804112241120.3922@ja.home.ssi.bg>
References: <94eb2c056114525fed05699315f1@google.com> <CACT4Y+Z3Ktnio1B0TAZpx8HOEfd2evwyQqbMeWGvEkzh0yfhKQ@mail.gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 11 Apr 2018, Dmitry Vyukov wrote:

> On Wed, Apr 11, 2018 at 4:02 PM, syzbot
> <syzbot+3c43eecd7745a5ce1640@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot hit the following crash on upstream commit
> > b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
> > Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=3c43eecd7745a5ce1640
> >
> > So far this crash happened 3 times on upstream.
> > C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5103706542440448
> > syzkaller reproducer:
> > https://syzkaller.appspot.com/x/repro.syz?id=5641659786199040
> > Raw console output:
> > https://syzkaller.appspot.com/x/log.txt?id=5099510896263168
> > Kernel config:
> > https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
> > compiler: gcc (GCC) 8.0.1 20180301 (experimental)
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+3c43eecd7745a5ce1640@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
> 
> #syz dup: possible deadlock in rtnl_lock (5)

	Yes, patch is now in the "nf" tree, so all these
lockups around start_sync_thread should be resolved soon...

> > IPVS: sync thread started: state = BACKUP, mcast_ifn = lo, syncid = 0, id =
> > 0
> > IPVS: stopping backup sync thread 4546 ...
> >
> > ============================================
> > IPVS: stopping backup sync thread 4559 ...
> > WARNING: possible recursive locking detected

Regards

--
Julian Anastasov <ja@ssi.bg>
