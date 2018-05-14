Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeENSAx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:00:53 -0400
Received: from mail-eopbgr40131.outbound.protection.outlook.com ([40.107.4.131]:11958
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750760AbeENSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:00:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Mon, 14 May 2018 11:00:36 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com>,
        avagin <avagin@openvz.org>, David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in sk_diag_fill
Message-ID: <20180514180035.GA20189@outlook.office365.com>
References: <000000000000169606056b793179@google.com>
 <20180511183358.GA1492@outlook.office365.com>
 <CACT4Y+bt-HwBNA5REeZwoKAymCc-Da5rEU=yeeHodg7zByStQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CACT4Y+bt-HwBNA5REeZwoKAymCc-Da5rEU=yeeHodg7zByStQg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: HE1PR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::16) To VI1PR08MB3263.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3263;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;3:thgCHUtz7qHBrTwxDHCZ+6jnVIczoy5hRps8QFnepZ5f7MJkXCmFajpZDgtrAh+v0WRG7VQ2xAR8DDChftQz/4fVCKEMJot0KMLU7Wsia1fKfQk4mhJ567Tk2DUagbuinFvAopBrlvjr8uI52P03LZGtdpvIojqniWk7FjNvb+M1N1xbzSvRrA+vOt02Ju+rHpgZ+T4h3i0WOjG8J+1oEDmcXGlaVp9jx8eDs7g/K0UYkI8Ut/WNqyd3e4Vtmy+l;25:O8soTts4NLnLPn911EvddaSWCU0e4TjtjCGEFiE8eC4BN1USmI+3kTMBhTLY7UEwlJpfyW61telXPaomOInHiah2FKl0ezmc8G8vs+JV8iLMPbr5UDzPRdACiRiuxU8KWsapirp4vjmBzFkVDUEnCqfg2H0GTn20VIn0dfgKNm3aApyGjg92OSU1SMT8XFskd48jbwqQJqe212Z2c4j0QQHF20mEtLZJRz8AooBfMezLz/hgoGexeVxnGw6Yq00wJFxkrcmScTizefE+2pJsi4aHK8FO4TDzUnfSz2kJ+4HnogYF6qnkcYnrSRIZ6Uj0zThlQEmELUubzDH1Fvy2cA==;31:KKaWSsSHW78/2Mgiutr/EyRF6tiTlKGw9+kHqkSlF0c+M2Umxu5kL/uuqdyYqVqvNUzTkIhwfxEL/9LwfJ8Ur+D1WIZjOTQda9WsPLdczapN2LvEyP03y9mqOYO47VtVJ9sNAnYdSGVv9yFfOYyjxUn5RwGqrPpsk+sqd6hlZzs0LZTZXR6qFvqnk7wzyea1ECZburLpyD9cvio1fHjGHmSHxgKV21UsjZY+mWZ0IP0=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3263:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:Oq/LK/q+NAS1oTGUe9Q6qTJDPP3PDxrfsxCA8g4ub7l6MALH53jBiPA8ZJTq933jh2a+Qt8/QguVNZYwdqfZsvOuFxUxU1pYVEgn5VwOjUm9496xjvPyWynhDxM1xY8CmPSrXzfUbVdKu4gVHutPO8mOqPFmvgEisN9vsr55QkldytbnSlPIimh2N2pwNYMQuuYjbmDpjRgRc3OjoTdKDQwWy4+uAuj+rOej6ZsNirStgR/5A1qUef9aXdedoAwLDsLUb8c3iL3siktJBRUouT5LJxVPpFc3OSmixlkzRMQzpIetDilYH5ly2GSNaGUaR7VdI9VKVHz2G5CIPamMcvlVMFZ9UD7r07nmSVIApxqOySJ5VX9X5DKIsNcCvz7XLsksxG70sxKuyvJHa9HEKBZco6zlHFxz2k9nHxlwM78Wtz2fNQDZ3Nmsx+1vPGZoovjJzBPwgTJsFbOHlIQa/RGwh+jVmbJKzqbA1InJpoavcHamsdjzW8zZV8eIGW1v;4:a+v8jppKD6F6wZEuruGGYVIKgTiwLg5RNS4iFpYCsp9Ka+09GEhBu7zl5Y3zttH9kSeSiWP8uhWNczS4Hdp6tT95GUrqfaF9both9aDcrulfUp928eLGJrchRFvNQDWtH9L/lfyLwtzvJ87NwQeYYnIGfExHUf4Z205zcDQQN6mX9oqiftpaxdAIcBuPqVq6fMc4PujMx88LTZXoYLb5quMAxlufafWxlgX4/XtkJbmm/daZyOaOlp8FbXDR7uRPHJpmd7HPRVzeiJO72JFcjVLJ0Euyr6VU0K/0uL39Lvd3Q76hs8iIPS/l/txfLWDkjNSsVtVcl87Y8XYiWi2i7NXX8zfvE4Di/27+gkujSfUAPimYPsaQKQ//yLT89AlS
X-Microsoft-Antispam-PRVS: <VI1PR08MB3263792C0B8B132637911A62CF9C0@VI1PR08MB3263.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228788266533470)(148501403981450)(211936372134217);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR08MB3263;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3263;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(396003)(39850400004)(199004)(189003)(105586002)(47776003)(4326008)(6246003)(53416004)(305945005)(6916009)(966005)(106356001)(45080400002)(53936002)(16526019)(66066001)(86362001)(97736004)(50466002)(186003)(6666003)(478600001)(26005)(2906002)(7736002)(11346002)(8676002)(3846002)(6116002)(23686003)(446003)(6306002)(37156001)(76176011)(33656002)(59450400001)(69596002)(1076002)(9686003)(486006)(55016002)(58126008)(476003)(53546011)(54906003)(386003)(6506007)(11609785009)(5660300001)(956004)(16586007)(25786009)(316002)(8936002)(68736007)(81156014)(81166006)(52116002)(229853002)(7696005)(18370500001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3263;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;VI1PR08MB3263;23:LSGrFgnQ7Ncfvvf825fynF50rzNB0qtdwCIA2cQh3YA?=
 =?koi8-r?Q?zlztdJojh63ipHH7C0Ntowat4EzYbLABqsncR9xrazSNzIm3UE+oFtCABVrKRY?=
 =?koi8-r?Q?ItoSpWIZLuH3mB4enakmidOGRzNsxLpSt0tFW+aC+Wn5F9Z7cTuN87WwpLFo3y?=
 =?koi8-r?Q?RIjc+O6ivo5QEybo/QqsTvho/N/mD8rOOschF8xM4q4GfGCGekqr3o/OP9LtxK?=
 =?koi8-r?Q?XBnyUd3Xnpb7kOVscp42n34A7Cq874tzWsHRmgPSFzlNglkXzxj2ox31xRmVFZ?=
 =?koi8-r?Q?1Xd3pyAXGYS+exauJZqORkGo47jLXKaTvsz7P9Rbefyd5rk/+5xZbazLn6JqPy?=
 =?koi8-r?Q?MCO+SJjX+KCcVE5KqPbIh2+wJRM8OUCQSk74ERyoauNU5WxQv3+E0pJiA80ALC?=
 =?koi8-r?Q?CLEV4IBQRi3D9VamvaCIcmPsv5e/wMtSpLEoeoEJmlB+y1w2v6BeT7WvGA3Rmk?=
 =?koi8-r?Q?Vhb8yvT2V+FW54iHRFVOsd9WIE/iBCbt4IlHJsd0l8mgxCP5QatKMHQ0cUvb9v?=
 =?koi8-r?Q?1eovcgIAgZLWMX+JoEVVXsamfuBeEu1ONG5IFUO0IjtLiNFpXrVITutbWLuPVs?=
 =?koi8-r?Q?7hXGExP8fisA2Rtps6Es4lwVgxuhyCLlAOTHwXiRdgyJjqSQT02x+5dys+X43C?=
 =?koi8-r?Q?wGkTegp2mSDXehkqIXVyhaae+8XskClW/Qrm2PuJpGF+pW2ReUKYveYNb1wWUK?=
 =?koi8-r?Q?MazdArTnIb29AAxLJHNBITAuqY5x+Y+sMpeFUSrzaDN635/x9DFock15CuJgqV?=
 =?koi8-r?Q?4BORJ9h8Vmc3z8jVX6WUJZw3NOBNxOBPhMizDV7qx9CXVjCAIbr7t8PtdudPhb?=
 =?koi8-r?Q?D9rHazZ+8X3RNIVsNrtd5S/8j6oWR/yGKP2gocSaiq2givSOg/zWyH8qqomhCw?=
 =?koi8-r?Q?7dJzf1AVcKNqGVG9m46+cpFTZlu2ihVrNRQeSJIh1dpkWOGDQKW7TtdoTBjt6g?=
 =?koi8-r?Q?TIMT0V2ZTjFgMBi2wYLDlBLjPSxrcWyJVqMgG7B1nfCf2Fibj1UF0BRe+YRpeu?=
 =?koi8-r?Q?aJH3fVk0uT1vF/nTCiqA2v2KtKkVDleE7QHy3zzix29dtC6uladmibw70NdRqO?=
 =?koi8-r?Q?JNog3GIuQ+bNGSCDJkVmoONOYmf0K/7BIw4NPK/GNvgDkUmzo264vfLZf9zJtE?=
 =?koi8-r?Q?oHYX5KTzDpdYSjf//R1Ms3SkrPt7GSwthY9KIGF+F7OrqzRV34WSK3FTiw1yeg?=
 =?koi8-r?Q?R7DJrbZyh7t36OFY/1ucjC0hF1dfFbBN707UeXHR8QC5S3dxNw38cn/6iQ+9NA?=
 =?koi8-r?Q?Mjx3F7zlUVMmDothtMMTcdX1369PsnvUhKqg316wjIeMf9AzRhioV41ghBUiRG?=
 =?koi8-r?Q?wHdP6RKQdAcc+84fm34zKa3645PrBZsGz3u3vvQ1H52HFdY/iHUKkjrpOT4Txj?=
 =?koi8-r?Q?7LqW2WMuyFyd6CXxhJ4VvtL0poiCdMHkgXXFlZ9rZxxmtcs4B2uzE3L3r1XsrF?=
 =?koi8-r?Q?0/dmnpNWfOiOk5CK8shtdsDWhGy271wYG0uOjeAYRSKxYk=3D?=
X-Microsoft-Antispam-Message-Info: K7xhER+xHJoyE5jkbQkn3WUDKi9c4JIcUSefXKJGLso7TlcyWJZZykPRGweW9+x8GwhQDI6tr9F7oeivvyYjFxrjk9ceq/E6fBwgJqeVKRvfXOiLUDhD7/kSmYdnJX2bdlLs+eU9O6mKevr1NRsGWwLms3Ig9OMiRkB1bXYGKSK1junzjWwHu8Ho6QcQXa0R
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;6:/n5Lu9yzwE4WCik2kQkL907G5bsPFMDMZp4B3F1W5b6Z0Ond9lUYWi0Y6UOPGocqoC47p+fp9/GgtaVSxe42zBCgmZ4wR6hnHjHNiGuPSNrfKlNuYuzWw9kkxOJ0fs+zBYEEd7TpHeOYVLm4dDINwbGS0RdCJUmBqcSDDkBjtvfTtNPbJZE0boEjSdRlkWT9Eb3ZTCiLZ99u6Ibt6nO5sZz53MIj/vz+9V+j3wR4A7Ov0PbuRbN/mQwYYu9djHJ/mS8t6p0byVcitOuj4ZpIVKSd9p6hEK3WbguZktaNDKwtuVOY88c6lBt+rhGvhplthzpY7tBRY1k3vtvPtT6ABSph5brOZDgUG01pFD49X8T3ooDGxaBEguUHb2OgoVyn8FF5rvhKqtd7+FU8eVs84gmxO0PBL2RzLlndCbNHPtpo1i4r0x9K7EhIYMxpIrDsn4/yhJquRNYWD/27tk/ZpA==;5:yjS4A+SBLNpATGFPYByX3fMzXLDyHhMnOg8lrzdItdzfJzAojjnVzevqIbodu0yvjf9OBBoXLxrCRaVZkB2luz0iNSYJ/Meqt5qJUEgk2PBFqF1mMUl2GrEJQn8WQjIzLfH4FXHrR1g1dfOp7RWNsOwzrpVJvFmW7Tv4ReZHOr4=;24:ZZ9X/LgtQWIM6SjKhqdQmiwLr42e1yX1L2aU15Bh1bnTlr2Pabz24gM9DE5llL6vTlAOeKqPY/A/UEOo7JmTjvv21Boi9h/E8XIT2CPDW5M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;7:56GogsZCAFORBniZ85oBel7dyLCKiOsaXBi+8Wq8E8bj24zKGiFLsqM/66Pj7YdYzHgz5iUMxjbcmRJR5WVOiT1vlj8WTLW/B6wr8j0kpCpxJQdvUXjidhqeIuyDOHcCHT+zDBvjymkHXtCfL/D1UMQC6uTXLYuUbzVbRvuYMZwNmZq/pxZvL1a3JY1k+cbRp4uiSJ00Wg8vCF3vn98P2e9n/9589uqW0rQ0dQ9BkPTPC+KsEY4TahDSpNEjxzCP;20:cJ4oKV2VF9iF0ULofMn5naWVhOaj2kXI5OMV9gwGs4kQ4WDImzWJF/H2jR18mhKUcvxrmSZP5ss/qL0TRYjoelf85YdAqkeucngQ2V+m77R6ar/ZetMfd2pfutzGnYRWVX+fbOlhG+/UtdTEYovQdFuG9C/oE9Y/S4ys1CC1eZI=
X-MS-Office365-Filtering-Correlation-Id: 657cf000-d2b3-4ff3-5897-08d5b9c49ea3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 18:00:44.3557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657cf000-d2b3-4ff3-5897-08d5b9c49ea3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 09:46:25AM +0200, Dmitry Vyukov wrote:
> On Fri, May 11, 2018 at 8:33 PM, Andrei Vagin <avagin@virtuozzo.com> wrote:
> > On Sat, May 05, 2018 at 10:59:02AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12164c97800000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c1872be62e587eae9669
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> userspace arch: i386
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com
> >>
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 4.17.0-rc3+ #59 Not tainted
> >> ------------------------------------------------------
> >> syz-executor1/25282 is trying to acquire lock:
> >> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at: sk_diag_dump_icons
> >> net/unix/diag.c:82 [inline]
> >> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at:
> >> sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
> >>
> >> but task is already holding lock:
> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock
> >> include/linux/spinlock.h:310 [inline]
> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons
> >> net/unix/diag.c:64 [inline]
> >> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_fill.isra.5+0x94e/0x10d0
> >> net/unix/diag.c:144
> >>
> >> which lock already depends on the new lock.
> >
> > In the code, we have a comment which explains why it is safe to take this lock
> >
> > /*
> >  * The state lock is outer for the same sk's
> >  * queue lock. With the other's queue locked it's
> >  * OK to lock the state.
> >  */
> > unix_state_lock_nested(req);
> >
> > It is a question how to explain this to lockdep.
> 
> Do I understand it correctly that (&u->lock)->rlock associated with
> AF_UNIX is locked under rlock-AF_UNIX, and then rlock-AF_UNIX is
> locked under (&u->lock)->rlock associated with AF_NETLINK? If so, I
> think we need to split (&u->lock)->rlock by family too, so that we
> have u->lock-AF_UNIX and u->lock-AF_NETLINK.

I think here is another problem. lockdep woried about
sk->sk_receive_queue vs unix_sk(s)->lock.

sk_diag_dump_icons() takes sk->sk_receive_queue and then
unix_sk(s)->lock.

unix_dgram_sendmsg takes unix_sk(sk)->lock and then sk->sk_receive_queue.

sk_diag_dump_icons() takes locks for two different sockets, but
unix_dgram_sendmsg() takes locks for one socket.

sk_diag_dump_icons
        if (sk->sk_state == TCP_LISTEN) {
                spin_lock(&sk->sk_receive_queue.lock);
                skb_queue_walk(&sk->sk_receive_queue, skb) {
			unix_state_lock_nested(req);
				spin_lock_nested(&unix_sk(s)->lock,


unix_dgram_sendmsg
	unix_state_lock(other)
		spin_lock(&unix_sk(s)->lock)
        skb_queue_tail(&other->sk_receive_queue, skb);
	        spin_lock_irqsave(&list->lock, flags);

> 
> 
> 
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #1 (rlock-AF_UNIX){+.+.}:
> >>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
> >>        skb_queue_tail+0x26/0x150 net/core/skbuff.c:2900
> >>        unix_dgram_sendmsg+0xf77/0x1730 net/unix/af_unix.c:1797
> >>        sock_sendmsg_nosec net/socket.c:629 [inline]
> >>        sock_sendmsg+0xd5/0x120 net/socket.c:639
> >>        ___sys_sendmsg+0x525/0x940 net/socket.c:2117
> >>        __sys_sendmmsg+0x3bb/0x6f0 net/socket.c:2205
> >>        __compat_sys_sendmmsg net/compat.c:770 [inline]
> >>        __do_compat_sys_sendmmsg net/compat.c:777 [inline]
> >>        __se_compat_sys_sendmmsg net/compat.c:774 [inline]
> >>        __ia32_compat_sys_sendmmsg+0x9f/0x100 net/compat.c:774
> >>        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
> >>        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
> >>        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> >>
> >> -> #0 (&(&u->lock)->rlock/1){+.+.}:
> >>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
> >>        _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
> >>        sk_diag_dump_icons net/unix/diag.c:82 [inline]
> >>        sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
> >>        sk_diag_dump net/unix/diag.c:178 [inline]
> >>        unix_diag_dump+0x35f/0x550 net/unix/diag.c:206
> >>        netlink_dump+0x507/0xd20 net/netlink/af_netlink.c:2226
> >>        __netlink_dump_start+0x51a/0x780 net/netlink/af_netlink.c:2323
> >>        netlink_dump_start include/linux/netlink.h:214 [inline]
> >>        unix_diag_handler_dump+0x3f4/0x7b0 net/unix/diag.c:307
> >>        __sock_diag_cmd net/core/sock_diag.c:230 [inline]
> >>        sock_diag_rcv_msg+0x2e0/0x3d0 net/core/sock_diag.c:261
> >>        netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
> >>        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
> >>        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
> >>        netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
> >>        netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
> >>        sock_sendmsg_nosec net/socket.c:629 [inline]
> >>        sock_sendmsg+0xd5/0x120 net/socket.c:639
> >>        sock_write_iter+0x35a/0x5a0 net/socket.c:908
> >>        call_write_iter include/linux/fs.h:1784 [inline]
> >>        new_sync_write fs/read_write.c:474 [inline]
> >>        __vfs_write+0x64d/0x960 fs/read_write.c:487
> >>        vfs_write+0x1f8/0x560 fs/read_write.c:549
> >>        ksys_write+0xf9/0x250 fs/read_write.c:598
> >>        __do_sys_write fs/read_write.c:610 [inline]
> >>        __se_sys_write fs/read_write.c:607 [inline]
> >>        __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
> >>        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
> >>        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
> >>        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> >>
> >> other info that might help us debug this:
> >>
> >>  Possible unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(rlock-AF_UNIX);
> >>                                lock(&(&u->lock)->rlock/1);
> >>                                lock(rlock-AF_UNIX);
> >>   lock(&(&u->lock)->rlock/1);
> >>
> >>  *** DEADLOCK ***
> >>
> >> 5 locks held by syz-executor1/25282:
> >>  #0: 000000003919e1bd (sock_diag_mutex){+.+.}, at: sock_diag_rcv+0x1b/0x40
> >> net/core/sock_diag.c:271
> >>  #1: 000000004f328d3e (sock_diag_table_mutex){+.+.}, at: __sock_diag_cmd
> >> net/core/sock_diag.c:225 [inline]
> >>  #1: 000000004f328d3e (sock_diag_table_mutex){+.+.}, at:
> >> sock_diag_rcv_msg+0x169/0x3d0 net/core/sock_diag.c:261
> >>  #2: 000000004cc04dbb (nlk_cb_mutex-SOCK_DIAG){+.+.}, at:
> >> netlink_dump+0x98/0xd20 net/netlink/af_netlink.c:2182
> >>  #3: 00000000accdef41 (unix_table_lock){+.+.}, at: spin_lock
> >> include/linux/spinlock.h:310 [inline]
> >>  #3: 00000000accdef41 (unix_table_lock){+.+.}, at:
> >> unix_diag_dump+0x10a/0x550 net/unix/diag.c:192
> >>  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock
> >> include/linux/spinlock.h:310 [inline]
> >>  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons
> >> net/unix/diag.c:64 [inline]
> >>  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at:
> >> sk_diag_fill.isra.5+0x94e/0x10d0 net/unix/diag.c:144
> >>
> >> stack backtrace:
> >> CPU: 1 PID: 25282 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #59
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:77 [inline]
> >>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> >>  print_circular_bug.isra.36.cold.54+0x1bd/0x27d
> >> kernel/locking/lockdep.c:1223
> >>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
> >>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
> >>  validate_chain kernel/locking/lockdep.c:2417 [inline]
> >>  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
> >>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
> >>  _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
> >>  sk_diag_dump_icons net/unix/diag.c:82 [inline]
> >>  sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
> >>  sk_diag_dump net/unix/diag.c:178 [inline]
> >>  unix_diag_dump+0x35f/0x550 net/unix/diag.c:206
> >>  netlink_dump+0x507/0xd20 net/netlink/af_netlink.c:2226
> >>  __netlink_dump_start+0x51a/0x780 net/netlink/af_netlink.c:2323
> >>  netlink_dump_start include/linux/netlink.h:214 [inline]
> >>  unix_diag_handler_dump+0x3f4/0x7b0 net/unix/diag.c:307
> >>  __sock_diag_cmd net/core/sock_diag.c:230 [inline]
> >>  sock_diag_rcv_msg+0x2e0/0x3d0 net/core/sock_diag.c:261
> >>  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
> >>  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
> >>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
> >>  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
> >>  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
> >>  sock_sendmsg_nosec net/socket.c:629 [inline]
> >>  sock_sendmsg+0xd5/0x120 net/socket.c:639
> >>  sock_write_iter+0x35a/0x5a0 net/socket.c:908
> >>  call_write_iter include/linux/fs.h:1784 [inline]
> >>  new_sync_write fs/read_write.c:474 [inline]
> >>  __vfs_write+0x64d/0x960 fs/read_write.c:487
> >>  vfs_write+0x1f8/0x560 fs/read_write.c:549
> >>  ksys_write+0xf9/0x250 fs/read_write.c:598
> >>  __do_sys_write fs/read_write.c:610 [inline]
> >>  __se_sys_write fs/read_write.c:607 [inline]
> >>  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
> >>  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
> >>  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
> >>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> >> RIP: 0023:0xf7f8ccb9
> >> RSP: 002b:00000000f5f880ac EFLAGS: 00000282 ORIG_RAX: 0000000000000004
> >> RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 000000002058bfe4
> >> RDX: 0000000000000029 RSI: 0000000000000000 RDI: 0000000000000000
> >> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> >> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >>
> >>
> >> ---
> >> This bug is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this bug report.
> >> If you forgot to add the Reported-by tag, once the fix for this bug is
> >> merged
> >> into any tree, please reply to this email with:
> >> #syz fix: exact-commit-title
> >> To mark this as a duplicate of another syzbot report, please reply with:
> >> #syz dup: exact-subject-of-another-report
> >> If it's a one-off invalid bug report, please reply with:
> >> #syz invalid
> >> Note: if the crash happens again, it will cause creation of a new bug
> >> report.
> >> Note: all commands must start from beginning of the line in the email body.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180511183358.GA1492%40outlook.office365.com.
> > For more options, visit https://groups.google.com/d/optout.
