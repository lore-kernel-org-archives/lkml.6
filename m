Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE2AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2B820660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nln996AB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfANJ7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:59:00 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34305 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfANJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:57 -0500
Received: by mail-ua1-f66.google.com with SMTP id c24so6869440uak.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6J6gLekR5zPwd65RjVZEkm672GsNwMJfl+kiubKacWs=;
        b=Nln996ABE08i0DXfiMBeN9+3GCkIHhzHsUV9W+IEQPT+AdL5l661dHHedgQXihtoVn
         uQqi1uI4M5vccHZ2/lslifAO4sbXbxfsf1EfwQj+MZD5ksIikEtK2T2PtFA0XxcY/G0e
         UXf7cLYDEg367kB+q64hyvc5t93LgT4XYY/HHADzNRdPQxwL6xb4RhrHAmdNpGffmtfA
         mWtkqQ4qb/hXpDYpsvWCNsEsLFjWnYsLGxtQhMH2zLcPz7hSbeB5j2B1h9s80HX3XWiR
         e7J/pSgGVW0mDwPyutRBs965apXh8M1Pxh08tCow6yWoX2ORl1yZ8OTk9Fhi75D+MBnN
         LKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6J6gLekR5zPwd65RjVZEkm672GsNwMJfl+kiubKacWs=;
        b=ntAfn6Ft5ID7cLIIk+kDLAWjlz5uoo+Hi7mE6dlQHbAf6xwWAKJp1q3c2FjtDfGy5N
         Hgx9H2133a1fUoDMNikk3XUOjr3xdzt6wpDdQgT13DFYVIwZfkU5IdAVVZZ7nyh6UZXb
         cHhuY8P0vcgM1rmxdXgGqT4lHuTBPhLeQY38chckc+HBZGz35uwpPqJEJ+X2bGt5YwRa
         IfXCx/ZCx1Y15+7nrtpat1Gzkg00Uv9cl84gn6PGmPBGQbd+v0firyDxXU3ol23MrOl3
         6+1srvSLh3XpdAW6v4ZKkRrOhvga9oaEDnoGnkvr8OPu+QddNgRAdM4GEWqj2KWOrLwc
         g3+w==
X-Gm-Message-State: AJcUukcUcuFSFAdptzS1KsRuW7b6UhA2v84z2KPwt1fczh997XtY/WFZ
        BntUuZUHi6mUWU4SWriV39TmEVj2ibFcvouVaKXsng==
X-Google-Smtp-Source: ALg8bN6+uVDHQBLzN0rjb8OHT9Euj1e3LT1fyADm+GT/ansMV8fKj1NsCDDbbfTPA3RtPG3iDzQSgkA1EJfHRtdyvWQ=
X-Received: by 2002:ab0:aa:: with SMTP id 39mr8971898uaj.120.1547459935483;
 Mon, 14 Jan 2019 01:58:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000311344057c4b6cc3@google.com> <CAG_fn=WbOyQ0R35_OhCLjxTTnV7z=u5xnjtm2gXtiSRdHbDz=A@mail.gmail.com>
 <20181206110634.GA9056@localhost.localdomain> <CADvbK_f-F9hp8HwxCp8og8FmEf_4E3=HOr8DPq3sEmRA8wGepg@mail.gmail.com>
 <CAG_fn=VYn-QNoyfvQKOynAR0cyJx+Sczvyh8Gk0SukEgYMmAVw@mail.gmail.com> <CADvbK_d4Tu57JJM55p=cwOMQ0mh3PDwUEkJdz9O=iTZKnp35mA@mail.gmail.com>
In-Reply-To: <CADvbK_d4Tu57JJM55p=cwOMQ0mh3PDwUEkJdz9O=iTZKnp35mA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 14 Jan 2019 10:58:43 +0100
Message-ID: <CAG_fn=VJVfpF9gOKaYt05hAhtbQyP9XvQMu--7ni634_d1PHVw@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in sctp_getsockopt
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.com,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:56 AM Xin Long <lucien.xin@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 5:34 PM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > On Mon, Dec 10, 2018 at 9:56 AM Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > On Thu, Dec 6, 2018 at 8:08 PM Marcelo Ricardo Leitner
> > > <marcelo.leitner@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 06, 2018 at 11:36:08AM +0100, Alexander Potapenko wrote=
:
> > > > > On Wed, Dec 5, 2018 at 8:31 PM syzbot
> > > > > <syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    fffec98ae2a6 net: proper support for CONFIG_GEN=
ERIC_CSUM o..
> > > > > > git tree:       https://github.com/google/kmsan.git/master
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12e=
84a47400000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D56b=
48b46dafe4516
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad5d3=
27e6936a2e284be
> > > > > > compiler:       clang version 8.0.0 (trunk 343298)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1=
03cd225400000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to =
the commit:
> > > > > > Reported-by: syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.=
com
> > > > > >
> > > > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > BUG: KMSAN: kernel-infoleak in _copy_to_user+0x19a/0x230 lib/us=
ercopy.c:33
> > > > > > CPU: 1 PID: 8164 Comm: syz-executor2 Not tainted 4.20.0-rc3+ #9=
5
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS
> > > > > > Google 01/01/2011
> > > > > > Call Trace:
> > > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > > >   dump_stack+0x32d/0x480 lib/dump_stack.c:113
> > > > > >   kmsan_report+0x12c/0x290 mm/kmsan/kmsan.c:683
> > > > > >   kmsan_internal_check_memory+0x32a/0xa50 mm/kmsan/kmsan.c:743
> > > > > >   kmsan_copy_to_user+0x78/0xd0 mm/kmsan/kmsan_hooks.c:634
> > > > > >   _copy_to_user+0x19a/0x230 lib/usercopy.c:33
> > > > > >   copy_to_user include/linux/uaccess.h:183 [inline]
> > > > > >   sctp_getsockopt_local_addrs net/sctp/socket.c:5998 [inline]
> > > > > >   sctp_getsockopt+0x15248/0x186f0 net/sctp/socket.c:7477
> > > > > >   sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2937
> > > > > >   __sys_getsockopt+0x489/0x550 net/socket.c:1939
> > > > > >   __do_sys_getsockopt net/socket.c:1950 [inline]
> > > > > >   __se_sys_getsockopt+0xe1/0x100 net/socket.c:1947
> > > > > >   __x64_sys_getsockopt+0x62/0x80 net/socket.c:1947
> > > > > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > > > > > RIP: 0033:0x457569
> > > > > > Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 =
f8 48 89 f7
> > > > > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01 f0 ff
> > > > > > ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > > > RSP: 002b:00007f4991886c78 EFLAGS: 00000246 ORIG_RAX: 000000000=
0000037
> > > > > > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004575=
69
> > > > > > RDX: 000000000000006d RSI: 0000000000000084 RDI: 00000000000000=
03
> > > > > > RBP: 000000000072bf00 R08: 0000000020000140 R09: 00000000000000=
00
> > > > > > R10: 0000000020001100 R11: 0000000000000246 R12: 00007f49918876=
d4
> > > > > > R13: 00000000004c7d88 R14: 00000000004ce348 R15: 00000000ffffff=
ff
> > > > > >
> > > > > > Uninit was stored to memory at:
> > > > > >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:246 [inline]
> > > > > >   kmsan_save_stack mm/kmsan/kmsan.c:261 [inline]
> > > > > >   kmsan_internal_chain_origin+0x13d/0x240 mm/kmsan/kmsan.c:469
> > > > > >   kmsan_memcpy_memmove_metadata+0x1a9/0xf70 mm/kmsan/kmsan.c:34=
4
> > > > > >   kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:362
> > > > > >   __msan_memcpy+0x61/0x70 mm/kmsan/kmsan_instr.c:162
> > > > > >   sctp_copy_laddrs net/sctp/socket.c:5901 [inline]
> > > > > >   sctp_getsockopt_local_addrs net/sctp/socket.c:5967 [inline]
> > > > > >   sctp_getsockopt+0x14f41/0x186f0 net/sctp/socket.c:7477
> > > > > >   sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2937
> > > > > >   __sys_getsockopt+0x489/0x550 net/socket.c:1939
> > > > > >   __do_sys_getsockopt net/socket.c:1950 [inline]
> > > > > >   __se_sys_getsockopt+0xe1/0x100 net/socket.c:1947
> > > > > >   __x64_sys_getsockopt+0x62/0x80 net/socket.c:1947
> > > > > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > > > > >
> > > > > > Uninit was stored to memory at:
> > > > > >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:246 [inline]
> > > > > >   kmsan_save_stack mm/kmsan/kmsan.c:261 [inline]
> > > > > >   kmsan_internal_chain_origin+0x13d/0x240 mm/kmsan/kmsan.c:469
> > > > > >   kmsan_memcpy_memmove_metadata+0x1a9/0xf70 mm/kmsan/kmsan.c:34=
4
> > > > > >   kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:362
> > > > > >   __msan_memcpy+0x61/0x70 mm/kmsan/kmsan_instr.c:162
> > > > > >   sctp_copy_laddrs net/sctp/socket.c:5890 [inline]
> > > > > >   sctp_getsockopt_local_addrs net/sctp/socket.c:5967 [inline]
> > > > > >   sctp_getsockopt+0x14de8/0x186f0 net/sctp/socket.c:7477
> > > > > >   sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2937
> > > > > >   __sys_getsockopt+0x489/0x550 net/socket.c:1939
> > > > > >   __do_sys_getsockopt net/socket.c:1950 [inline]
> > > > > >   __se_sys_getsockopt+0xe1/0x100 net/socket.c:1947
> > > > > >   __x64_sys_getsockopt+0x62/0x80 net/socket.c:1947
> > > > > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > > > > >
> > > > > > Uninit was created at:
> > > > > >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:246 [inline]
> > > > > >   kmsan_internal_poison_shadow+0x6d/0x130 mm/kmsan/kmsan.c:170
> > > > > >   kmsan_kmalloc+0xa1/0x100 mm/kmsan/kmsan_hooks.c:186
> > > > > >   __kmalloc+0x14c/0x4d0 mm/slub.c:3825
> > > > > >   kmalloc include/linux/slab.h:551 [inline]
> > > > > >   sctp_inet6addr_event+0x60e/0xbd0 net/sctp/ipv6.c:100
> > > > > >   notifier_call_chain kernel/notifier.c:93 [inline]
> > > > > >   __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
> > > > > >   atomic_notifier_call_chain+0x13d/0x240 kernel/notifier.c:193
> > > > > >   inet6addr_notifier_call_chain+0x76/0x90 net/ipv6/addrconf_cor=
e.c:107
> > > > > >   ipv6_add_addr+0x2597/0x2890 net/ipv6/addrconf.c:1115
> > > > > >   inet6_addr_add+0xc86/0x1c10 net/ipv6/addrconf.c:2912
> > > > > >   inet6_rtm_newaddr+0x167e/0x3d20 net/ipv6/addrconf.c:4750
> > > > > >   rtnetlink_rcv_msg+0x1148/0x1540 net/core/rtnetlink.c:4947
> > > > > >   netlink_rcv_skb+0x394/0x640 net/netlink/af_netlink.c:2477
> > > > > >   rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4965
> > > > > >   netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
> > > > > >   netlink_unicast+0x1699/0x1740 net/netlink/af_netlink.c:1336
> > > > > >   netlink_sendmsg+0x13c7/0x1440 net/netlink/af_netlink.c:1917
> > > > > >   sock_sendmsg_nosec net/socket.c:621 [inline]
> > > > > >   sock_sendmsg net/socket.c:631 [inline]
> > > > > >   ___sys_sendmsg+0xe3b/0x1240 net/socket.c:2116
> > > > > >   __sys_sendmsg net/socket.c:2154 [inline]
> > > > > >   __do_sys_sendmsg net/socket.c:2163 [inline]
> > > > > >   __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
> > > > > >   __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
> > > > > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > > > > >
> > > > > > Bytes 32-35 of 2100 are uninitialized
> > > > > > Memory access of size 2100 starts at ffff888185d8b000
> > > > > > Data copied to user address 0000000020001108
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > When a network device goes up and sctp_inetaddr_event() is called=
, it
> > > > > allocates a partially initialized struct sctp_sockaddr_entry to h=
old
> > > > > the newly created address.
> > > > > The attached reproducer can be then used to read up to 8 uninit b=
ytes
> > > > > for each of the local addresses.
> > > > > I guess the devices aren't created so often that this can pose an=
y
> > > > > security risk, but we probably still need to allocate this struct=
ure
> > > > > with __GFP_ZERO.
> > > >
> > > > Agree. Thanks Alexander.
> > > > Looks like this is the last/only place left with this issue.
> > Actually there's still a similar bug in IPv4. Memsetting addr->av4 shou=
ld help:
> seems right, because of __pad of struct sockaddr_in.
> Do you have any reproducer for this?
I just took the above reproducer. Not sure what changed (perhaps the
configuration of my VM), but now the uninitialized data is allocated
by sctp_inetaddr_event()
> We should use kzalloc for all sctp_sockaddr_entry allocations.
>
> Thanks.
>
> >
> > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > index d5878ae55840..f1cbfb4d0c39 100644
> > --- a/net/sctp/protocol.c
> > +++ b/net/sctp/protocol.c
> > @@ -778,6 +778,7 @@ static int sctp_inetaddr_event(struct
> > notifier_block *this, unsigned long ev,
> >         case NETDEV_UP:
> >                 addr =3D kmalloc(sizeof(struct sctp_sockaddr_entry), GF=
P_ATOMIC);
> >                 if (addr) {
> > +                       memset(&addr->a.v4, 0, sizeof(struct sockaddr_i=
n));
> >                         addr->a.v4.sin_family =3D AF_INET;
> >                         addr->a.v4.sin_port =3D 0;
> >                         addr->a.v4.sin_addr.s_addr =3D ifa->ifa_local;
> >
> >
> > > This field is not really used by sctp, I will just set it to 0.
> > >
> > > diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> > > index fc6c5e4bffa5..7f0539db5604 100644
> > > --- a/net/sctp/ipv6.c
> > > +++ b/net/sctp/ipv6.c
> > > @@ -101,6 +101,7 @@ static int sctp_inet6addr_event(struct
> > > notifier_block *this, unsigned long ev,
> > >                 if (addr) {
> > >                         addr->a.v6.sin6_family =3D AF_INET6;
> > >                         addr->a.v6.sin6_port =3D 0;
> > > +                       addr->a.v6.sin6_flowinfo =3D 0;
> > >                         addr->a.v6.sin6_addr =3D ifa->addr;
> > >                         addr->a.v6.sin6_scope_id =3D ifa->idev->dev->=
ifindex;
> > >                         addr->valid =3D 1;
> > >
> > > >
> > > > > >
> > > > > > ---
> > > > > > This bug is generated by a bot. It may contain errors.
> > > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > >
> > > > > > syzbot will keep track of this bug report. See:
> > > > > > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicat=
e with
> > > > > > syzbot.
> > > > > > syzbot can test patches for this bug, for details see:
> > > > > > https://goo.gl/tpsmEJ#testing-patches
> > > > > >
> > > > > > --
> > > > > > You received this message because you are subscribed to the Goo=
gle Groups "syzkaller-bugs" group.
> > > > > > To unsubscribe from this group and stop receiving emails from i=
t, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > > > > To view this discussion on the web visit https://groups.google.=
com/d/msgid/syzkaller-bugs/000000000000311344057c4b6cc3%40google.com.
> > > > > > For more options, visit https://groups.google.com/d/optout.
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Alexander Potapenko
> > > > > Software Engineer
> > > > >
> > > > > Google Germany GmbH
> > > > > Erika-Mann-Stra=C3=9Fe, 33
> > > > > 80636 M=C3=BCnchen
> > > > >
> > > > > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> > > > > Registergericht und -nummer: Hamburg, HRB 86891
> > > > > Sitz der Gesellschaft: Hamburg
> > > >
> > > > > #ifndef DUMP_BUF_H
> > > > > #define DUMP_BUF_H
> > > > >
> > > > > #ifndef DUMP_MIN_STRLEN
> > > > > #define DUMP_MIN_STRLEN 1
> > > > > #endif
> > > > >
> > > > > #ifndef DUMP_PARALLEL
> > > > > #define DUMP_PARALLEL 0
> > > > > #endif
> > > > >
> > > > > #ifndef DUMP_PRINT_BUF_ADDR
> > > > > #define DUMP_PRINT_BUF_ADDR 0
> > > > > #endif
> > > > >
> > > > > #ifndef DUMP_PRINT_HEX
> > > > > #define DUMP_PRINT_HEX 0
> > > > > #endif
> > > > >
> > > > > #ifndef DUMP_PRINT_STRING
> > > > > #define DUMP_PRINT_STRING 0
> > > > > #endif
> > > > >
> > > > > #if DUMP_PARALLEL
> > > > > pthread_mutex_t out_mutex =3D PTHREAD_MUTEX_INITIALIZER;
> > > > > #endif
> > > > >
> > > > > void dump_buf(unsigned char *buf, int len) {
> > > > >   int i, nz =3D 0;
> > > > >   for (i =3D 0; i < len; i++) {
> > > > >     if (buf[i]) {
> > > > >       nz =3D 1;
> > > > >       break;
> > > > >     }
> > > > >   }
> > > > >   if (!nz) {
> > > > >     // The buffer is empty.
> > > > >     return;
> > > > >   } else {
> > > > > #if DUMP_PARALLEL
> > > > >     pthread_mutex_lock(&out_mutex);
> > > > > #endif
> > > > > #if DUMP_PRINT_BUF_ADDR
> > > > >     fprintf(stderr, "nonempty buffer at %p\n", buf);
> > > > > #endif
> > > > > #if DUMP_PRINT_HEX
> > > > >     for (i=3D0; i < len; i++) {
> > > > >       if (buf[i]) {
> > > > >         fprintf(stderr, "buf[%d]: %x (%p)\n", i, buf[i], *(void**=
)&buf[i]);
> > > > >       }
> > > > >     }
> > > > > #endif // DUMP_PRINT_HEX
> > > > > #if DUMP_PARALLEL
> > > > >     pthread_mutex_unlock(&out_mutex);
> > > > > #endif
> > > > >   }
> > > > > #if DUMP_PARALLEL
> > > > >   pthread_mutex_lock(&out_mutex);
> > > > > #endif
> > > > > #if DUMP_PRINT_STRING
> > > > >   for (i =3D 0; i < len; i++) {
> > > > >     if (buf[i]) {
> > > > >       int str_len =3D strlen(&buf[i]);
> > > > >       // Short string pieces are too boring.
> > > > >       if (str_len >=3D DUMP_MIN_STRLEN) {
> > > > >         unsigned char *c;
> > > > >         for (c =3D &buf[i]; c < &buf[i + str_len]; c++) {
> > > > >           if ((*c > 127) || ((*c < 32) && (*c !=3D 10) && (*c !=
=3D 13)))  {
> > > > >             *c =3D ' ';
> > > > >             continue;
> > > > >           }
> > > > >         }
> > > > >         // Dump the buffer.
> > > > >         fprintf(stderr, "%s\n", &buf[i]);
> > > > >       }
> > > > >       i +=3D str_len;
> > > > >     }
> > > > >   }
> > > > > #endif // DUMP_PRINT_STRING
> > > > > #if DUMP_PARALLEL
> > > > >   pthread_mutex_unlock(&out_mutex);
> > > > > #endif
> > > > > }
> > > > >
> > > > > #endif
> > > >
> > > > > #include <stdio.h>
> > > > > #include <pthread.h>
> > > > > #include <sys/types.h>          /* See NOTES */
> > > > > #include <sys/socket.h>
> > > > > #include <unistd.h>
> > > > >
> > > > > #define DUMP_PARALLEL 1
> > > > > #define DUMP_PRINT_BUF_ADDR 1
> > > > > #define DUMP_PRINT_STRING 1
> > > > > #define DUMP_PRINT_HEX 1
> > > > > #include "dump_buf.h"
> > > > >
> > > > > void *setsockopt_fn(void *arg) {
> > > > >   int sock =3D (int)arg;
> > > > >   struct sockaddr addr;
> > > > >   memset(&addr, 0, sizeof(addr));
> > > > >   addr.sa_family =3D 2;
> > > > >   addr.sa_data[2] =3D 0xac;
> > > > >   addr.sa_data[3] =3D 0x14;
> > > > >   addr.sa_data[4] =3D 0x14;
> > > > >   setsockopt(sock, 0x84, 0x6e, &addr, 0x10);
> > > > > }
> > > > >
> > > > > #define BUFLEN (0x2c2)
> > > > > void *getsockopt_fn(void *arg) {
> > > > >   int sock =3D (int)arg;
> > > > >   char buf[BUFLEN];
> > > > >   memset(buf, 0, BUFLEN);
> > > > >   int socklen =3D BUFLEN;
> > > > >   getsockopt(sock, 0x84, /*SCTP_GET_LOCAL_ADDRS*/0x6d, buf, &sock=
len);
> > > > >   dump_buf(&(buf[8]), 32);
> > > > > }
> > > > >
> > > > > void do_work(int sock) {
> > > > >   pthread_t t1, t2;
> > > > >   for (int i =3D 0; i < 10; i++) {
> > > > >     pthread_create(&t1, NULL, getsockopt_fn, (void*)sock);
> > > > >     pthread_create(&t2, NULL, setsockopt_fn, (void*)sock);
> > > > >     usleep(100);
> > > > >   }
> > > > > }
> > > > >
> > > > > int main(int argc, char *argv[]) {
> > > > >   int res;
> > > > >   int pid =3D fork();
> > > > >   if (pid =3D=3D 0) {
> > > > >     int sock =3D socket(0x2, 0x1, 0x84);
> > > > >     do_work(sock);
> > > > >   }
> > > > >   sleep(10);
> > > > >   return 0;
> > > > > }
> > > >
> >
> >
> >
> > --
> > Alexander Potapenko
> > Software Engineer
> >
> > Google Germany GmbH
> > Erika-Mann-Stra=C3=9Fe, 33
> > 80636 M=C3=BCnchen
> >
> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> > Registergericht und -nummer: Hamburg, HRB 86891
> > Sitz der Gesellschaft: Hamburg



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
