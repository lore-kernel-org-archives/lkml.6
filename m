Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeEOGTQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:19:16 -0400
Received: from mail-he1eur01on0133.outbound.protection.outlook.com ([104.47.0.133]:4758
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752208AbeEOGTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:19:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Mon, 14 May 2018 23:18:55 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com>,
        avagin <avagin@openvz.org>, David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in sk_diag_fill
Message-ID: <20180515061854.GA30523@outlook.office365.com>
References: <000000000000169606056b793179@google.com>
 <20180511183358.GA1492@outlook.office365.com>
 <CACT4Y+bt-HwBNA5REeZwoKAymCc-Da5rEU=yeeHodg7zByStQg@mail.gmail.com>
 <20180514180035.GA20189@outlook.office365.com>
 <CACT4Y+a9v+38=DUpTGu0doaf3xWW02PUzoC7idgwOg+rV2eFTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CACT4Y+a9v+38=DUpTGu0doaf3xWW02PUzoC7idgwOg+rV2eFTQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR19CA0060.namprd19.prod.outlook.com
 (2603:10b6:300:94::22) To DB7PR08MB3260.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3260;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;3:y0cEfCuaju/xT98tUd8J7c+hmFopCLVAPQeX+NKLfOTIFizH6mDRJDlzDy9ck+yo6qEZv60cGArLPlJLuOrFgHhhgQf+1uWdwKd3lpod49NXaTo7WMrbZA+N2b9M2d0R8tBpwsxAIB/DUl4TC5YoJcrpVuNoCRb2STUFZsn2S+OlbLkGb13rjnOsUrSLz+QxN2NLJtRlERLHOctUpYv27HqpBy2mFsrW4AUHrHjT3kP8rxnvXJsL5V003tJrwdTk;25:w1nDXbkX6caZeb4/LUaGPOidhYzBPGkQDHX0d/iXPVm2DoNhLxSh9/r60CkcmGeMT/A8rJod5FP1sNyOXKYCxBMpwhTdEt4Bqi11I0e9xHalB1nDZyjtdJOpmz5vbt5qOriqlpr1iqlAuA3NwNgW3NZphUQahCtFvs3FvLqdyEClgDir3qH8UBlNKHZFzHu+e5lOQMvLCmIRwWR4tXv4vzUP7bwD9QWv3zg+07grhJWWUOxQF48SbhqiaeNVMODpz6lHkI9vkh4nHMyEUzHfUTipzy9+O9wq1Q6Kuom8ZLoKrSSQOycE08zWCT1VT0H91UNzJlo6jb24/D7bzMHmNw==;31:SbII5zKYLm/oqe7w5bKgdZbKnchD0jfnTSavbi+dZCTXulwkf8bPcZr9L5EOCqg8AhkpKGGgZiKaecuLvHhA8ZzwGf6nOmTf4sJynuNXwVXkEhNH8+arlql/HUnqsDml2oUNv8Nh+nVMNRKskCHqTTn7Kyf8YitNFrnjFPtxzmvizdKpT12o9elZ0Af6/+tF7F2WfidqXPs5TRXobs3KaaGXAW7vYJaNEyOOgNZTFZI=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3260:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;20:Xb6icN3aLYs41gbP7+m1+F4OVPAUW4PZav/myLrT/vx525iPkDBGZmYwj+JeSVvqeg6zvQBm9EaYkDjGxNcYRPbQ00sxRj/0SDwX6CZNFot5uFXKnwaD+jgGAg0BIiZuBCHdFjM1jdcn8XWR3aEb3zrO+KQL8CpST+cbgFL2jxzMEV3rLbfzY3M999NXjVh/YCc8nbhL0mYb/rtmA71+/O7ALW+uWq+wlnyR9Y4mmtq+1I1rQBjVEVIM+GE7b8ECT+ksvByEGZtJAZwDs+tOcoKGj0XdGG/R0oICmyZNEDaif9eOzgcb3sfXJuDrARFPxp0t37JPQoxWg4TG1PJzC2URHDxyOROQlf4zKfemmhjMgizKlgW7brytB8oRGQ2Xu1WRoIfmS8q/fZlUPxH6QBCixwgoqAibROOYCtLLEzyZc5RcVAaxcDZ8UPIg30uZtPtCgJFKcijSL4KVEicf05mTypA+GOzDD3akpZCsCYjNHQsIZdncORy0+sjijIoD;4:TSat2yEw9pg6myDN6+5B8954xvmJhxyhDKFzkUdh0H68hhfR4en3PcG59zh7QNxQhI9hQvo2pvUs4ndJkhLru4UwKNNq4Lh8oH4Fesd7w8aobPemhl91lgPojY44hMycNwjn0ZSiEzgAR9J75l4wdUc2tMgXKfQH4rixfrh9cwO6M/8nIxGRYJNarB/T4VBqprPYW+VNfPUS9QoxlCwyIyDEqhX/5MYuUVz4oqeMVjInq0dIEtFUSy16/RcHDbbWOSzZKCv2MRTXKDYG0wHimw==
X-Microsoft-Antispam-PRVS: <DB7PR08MB326094FF52ECF09BC03D206DCF930@DB7PR08MB3260.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB7PR08MB3260;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3260;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39850400004)(346002)(366004)(376002)(199004)(189003)(54906003)(9686003)(93886005)(106356001)(6306002)(2906002)(52116002)(7696005)(76176011)(50466002)(6116002)(1076002)(186003)(16526019)(7736002)(26005)(86362001)(105586002)(68736007)(3846002)(486006)(69596002)(81166006)(476003)(81156014)(316002)(11346002)(58126008)(446003)(956004)(16586007)(8676002)(386003)(53546011)(6506007)(59450400001)(53416004)(8936002)(55016002)(966005)(6916009)(6246003)(4326008)(66066001)(478600001)(23686003)(53936002)(33656002)(97736004)(305945005)(229853002)(25786009)(5660300001)(47776003)(6666003)(18370500001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3260;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;DB7PR08MB3260;23:0J6rswh8n0qwFYRsaRRz3OPQzJrOKlehH6OF4wxAqSo?=
 =?koi8-r?Q?A6llevEJOovZ09nlwLxJd2U3Z7tc4jl0ftk8qelDcbmq+tGDYI5dTN5bmZmQnS?=
 =?koi8-r?Q?CH604NqrKlr7uEVjhTRHEVemS1R5nV1gDhsIkvCUlxKXD81EwfORb021dRLLI6?=
 =?koi8-r?Q?4qmLgz2pKPkLSyzTy3+sNG3xBAiTBSbM7fQaGE61MvAcMMfvOHP6sFFlZZv7WD?=
 =?koi8-r?Q?nEoOcsRUFsTfWg6njugROhlRdw/BTQH8HTRAKyBl0OdK1RRKyDoflLeW7p7jop?=
 =?koi8-r?Q?VkLioQBNrpFkTNhtHIV3uK2W+3BlvoPNX4BlRLaazIkWUPZ3uNk4ynY7Nln3EX?=
 =?koi8-r?Q?B31Nfg6z6EdTVLWPc+5JDN+KonGjCjDrpLIbuuhxg0ID1DIsjfy4VEuTk/lRc8?=
 =?koi8-r?Q?VPQjSItHuK4tWgXWxNt2bWCdY/XVPd8LvHr1K4trwNqppyOaZOUmE5iuUOJKli?=
 =?koi8-r?Q?Nv1xq0TmerMWyCQWw07Eg3A5AtDEMxfKLoFKVnajOdYdb1bpksDpZkyBlJs9L8?=
 =?koi8-r?Q?CieSLz8uh1i0RvnISP3rY8o0o16mGqufQuKS7hM5BsA6rFA8QIL2uqGcFuvqN8?=
 =?koi8-r?Q?CgHI3Mdm8G4D1fqgGEP0uHBXXEHdNKYMdXYOZHaQkMf7lTHfoDhkhgtZaMk3O3?=
 =?koi8-r?Q?i3wbhiF0nR9J6iti/dKTtu9BsoWbCdub2Avry7bdJBspqR35CXUVvEbUNcOxbN?=
 =?koi8-r?Q?SO1R1irbOa3qdp16Z42itGYaY2MuzG/9/stZovTKnEi8p/je1YTpYDOJB4T+QU?=
 =?koi8-r?Q?KsCXriWd/naOydLxBYqNMPQ9UgoUZ83MP1EUTbqLSSv2BeMaRz8NlBdcEjjpD/?=
 =?koi8-r?Q?w4eZDdwBj/H4wgrEoe3WQybTB90yjakjPchAkOgmA+/G6IjJMxl16mka9kekNM?=
 =?koi8-r?Q?QaWjZFwhhYZXpokg3XmAsSxKQpys76kZZxdfbgfX8Pjk2SrVHUjU3CEALEKSk6?=
 =?koi8-r?Q?9a1j/h9JMr6NqcpG2aQqez87rFpexXTmnGuWdggJ6ohHjFjNqhCvG1H0D1VyUo?=
 =?koi8-r?Q?9rY9r41wj4Nb4EqvuWa0A9RzmZM+LpRxoGpaN5+hcpL8oiNhpZGoEzX5EhBevh?=
 =?koi8-r?Q?BZHWcJxbD7Fxx+gxhBR4Xfve4PVrBCs1IpkuQ2tsi2faT2BwBO3QqZ0aMyYqJ1?=
 =?koi8-r?Q?4uH5/gaj54J6dlDHZGE/4m8XADRbE1NZR61Js2Kv2BtQlNJDX+3+buF4rRL1WH?=
 =?koi8-r?Q?e1HSDX02h0UO2x0W17NHUF5ERmW7Xkt+4j/wFiqbDQsfBKQU+vPBZOuv+Xpsuf?=
 =?koi8-r?Q?qS+wLGBgZ2RBs6yGJ0vg+i+hG8k46MgzKmTo9Aw+KWICE34sztD0/DUe2X73N0?=
 =?koi8-r?Q?DQWhLZX5A2rb/kvs7Ee3eJiwxORJnNZj8s1vyW9aAvLWL07NGVpTQCTBQmKNMl?=
 =?koi8-r?Q?In7ls0fiAqDSed/5PxJiXGN2oqjl3b0WTPkB/w+yNq0k=3D?=
X-Microsoft-Antispam-Message-Info: qV8s7GG30QAWOGdsotCVEUs470wn2hHsmKQwUGlUvCkiCJzKKabTU21+JDT9JhziHeBiThlT4x8s5n/YF13EdtPiUUqHqCAEVfrtmUBgdK48EnvD4ywVUELJs59dMfwUkw3zAI0ooikcsnclCZW5SgREUcBOpUnA/y/3xsN6tT1r6eQODoQ1FLYNHPETKWRF
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;6:4C9CJdQhIWPUw1MZNxlAWWwiL4ewH3aGsOZoUb5En8pExVESGRtjH6T0pAegQD8egMEcezcWYeac54L8olmjZeoQGEbMIzg1zUb5F6RBFT4kCkvSD7SDUXyX3c0bE0piuvS+4wznVzeKjjnv2kWShFVZ95U1LW2jCCtGQIj/mtVpYXaq37CT3NZpm7V4rPaCYqvkvg59FwIInTot4siznmFoPvSSL0y+8HogD6V+5q29tPRRoAtfaPe5LJJSK/+Ou1pXoIzNsg+Wih/QHxikF6bWHlD8GIiazYO7y7MhjrXPVWHCYFZDhFyW5+8D2xHhnl5Q+EnYZlW9+e8hVSPlJ3Nb97seWlnCHJsq6+1hMpLGy0DFia2mBkNPdvO1vjAUdZ4Nea7MnOcF+zbd05SHiUXHHK+mpL10ql6rX/XdbOMh4fTZSrAsOjb3lAPOVCNMYEEkrtxDxyXua8j0ddFD4w==;5:aRPnaOb6BE5wy6JM5keKp+G1zuN2d2VyKgTeoPyvxhBnScwZuqMN3TTfyfP8iaUivKME6VCE74wnrw30pmriSmsLulldN/JL7sqgbdIefbUqiMummCtcoAKLYOcS1FmrD6z6pwnSlwFoNsYX/4G4hU2BKrJVAi6cpC8ZjkKCZj0=;24:ZnuIRf7WPEG+Beb+PlYJh0kYpYT5o1OZeUtj/Oe62gWx/zxZHcwqkzN/x+WB8MIzSdWL4wfN+xZnvnQZPm+mV5mdAXowfgw3QhucEqGa72U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;7:mXy8RCr3i83wQHSEM6fOMitw1NAv7uUk0Xo4esDke5nyjIEJnAsg7JIafgWj8pfybDFaEXqdrxsyD/b+HWiPpcp052eMnK3mftwqyg5R5YPz8kKDHyT/3XhlftyDl8EB42r2+HIsb788YAAdm2YfrPsJ26qrA9NzthND+zLDRojivL60jdyRU7MjU1qTShWOyfgXtBumVMYQTa8XwIidqPQuYe2auW56bTI0nE9p093CV5K0BmzO0Xerg/+kdzAI;20:BrH2X1taJL/XO7JIq/RXhyfCpfNZJSbDaolzP96itMNPLIpj8xn9x2XWHAD6ApcWNt6wg/XArAUHiy1o6yS5LeGs4KfeYaJpl7w1RiSb6yNA/KSYvvTyJvoyoS8EXIpo2fXSoLO+r7TVzr1b080rz0GWXMsPQCiV3CLaUpXX9c0=
X-MS-Office365-Filtering-Correlation-Id: 7101dda7-4fb3-4e04-5977-08d5ba2bc4e9
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 06:19:07.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7101dda7-4fb3-4e04-5977-08d5ba2bc4e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 07:19:39AM +0200, Dmitry Vyukov wrote:
> On Mon, May 14, 2018 at 8:00 PM, Andrei Vagin <avagin@virtuozzo.com> wrote:
> >> >> Hello,
> >> >>
> >> >> syzbot found the following crash on:
> >> >>
> >> >> HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
> >> >> git tree:       upstream
> >> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12164c97800000
> >> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
> >> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c1872be62e587eae9669
> >> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> >> userspace arch: i386
> >> >>
> >> >> Unfortunately, I don't have any reproducer for this crash yet.
> >> >>
> >> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> >> Reported-by: syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com
> >> >>
> >> >>
> >> >> ======================================================
> >> >> WARNING: possible circular locking dependency detected
> >> >> 4.17.0-rc3+ #59 Not tainted
> >> >> ------------------------------------------------------
> >> >> syz-executor1/25282 is trying to acquire lock:
> >> >> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at: sk_diag_dump_icons
> >> >> net/unix/diag.c:82 [inline]
> >> >> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at:
> >> >> sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
> >> >>
> >> >> but task is already holding lock:
> >> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock
> >> >> include/linux/spinlock.h:310 [inline]
> >> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons
> >> >> net/unix/diag.c:64 [inline]
> >> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_fill.isra.5+0x94e/0x10d0
> >> >> net/unix/diag.c:144
> >> >>
> >> >> which lock already depends on the new lock.
> >> >
> >> > In the code, we have a comment which explains why it is safe to take this lock
> >> >
> >> > /*
> >> >  * The state lock is outer for the same sk's
> >> >  * queue lock. With the other's queue locked it's
> >> >  * OK to lock the state.
> >> >  */
> >> > unix_state_lock_nested(req);
> >> >
> >> > It is a question how to explain this to lockdep.
> >>
> >> Do I understand it correctly that (&u->lock)->rlock associated with
> >> AF_UNIX is locked under rlock-AF_UNIX, and then rlock-AF_UNIX is
> >> locked under (&u->lock)->rlock associated with AF_NETLINK? If so, I
> >> think we need to split (&u->lock)->rlock by family too, so that we
> >> have u->lock-AF_UNIX and u->lock-AF_NETLINK.
> >
> > I think here is another problem. lockdep woried about
> > sk->sk_receive_queue vs unix_sk(s)->lock.
> >
> > sk_diag_dump_icons() takes sk->sk_receive_queue and then
> > unix_sk(s)->lock.
> >
> > unix_dgram_sendmsg takes unix_sk(sk)->lock and then sk->sk_receive_queue.
> >
> > sk_diag_dump_icons() takes locks for two different sockets, but
> > unix_dgram_sendmsg() takes locks for one socket.
> >
> > sk_diag_dump_icons
> >         if (sk->sk_state == TCP_LISTEN) {
> >                 spin_lock(&sk->sk_receive_queue.lock);
> >                 skb_queue_walk(&sk->sk_receive_queue, skb) {
> >                         unix_state_lock_nested(req);
> >                                 spin_lock_nested(&unix_sk(s)->lock,
> >
> >
> > unix_dgram_sendmsg
> >         unix_state_lock(other)
> >                 spin_lock(&unix_sk(s)->lock)
> >         skb_queue_tail(&other->sk_receive_queue, skb);
> >                 spin_lock_irqsave(&list->lock, flags);
> 
> 
> Do you mean the following?
> There is socket 1 with state lock (S1) and queue lock (Q2), and socket
> 2 with state lock (S2) and queue lock (Q2). unix_dgram_sendmsg lock
> S1->Q1. And sk_diag_dump_icons locks Q1->S2.
> If yes, then this looks pretty much as deadlock. Consider that 2
> unix_dgram_sendmsg in 2 different threads lock S1 and S2 respectively.
> Now 2  sk_diag_dump_icons in 2 different threads lock Q1 and Q2
> respectively. Now sk_diag_dump_icons want to lock S's, and
> unix_dgram_sendmsg want to lock Q's. Nobody can proceed.

Q1 and S1 belongs to a listen socket, so they can't be taken from
unix_dgram_sendmsg().
