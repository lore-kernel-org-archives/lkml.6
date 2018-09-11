Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE52AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C2220854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeIKLCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:02:43 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:44392 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeIKLCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:02:43 -0400
Received: by mail-io0-f200.google.com with SMTP id s15-v6so2806548iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SuN3/oApKGqe6H7XhY2MNX6FWJ8rHlwQ8imDVQF8pzs=;
        b=l3l+PeD4KS0yWuAuot1OZwHshuRGbNM+7UxsbzEQZESprYoa2Wer05vZvpfGmrWB9D
         YJSIqrZ+DBkiDg0dlozBQ3tjhqlI5VwVz1Z//EkKFlxGB1SmFwmIayo+e4cAaFckTdFe
         IJMIhNxhytmyP9Ci6C+mWE2DeKtvK7eDEIYlxMD56arc8G60+6y6v1Tgn5CsNacBDF99
         /D3ty/IBVRUvhsd3eqzJddtAUeoAVjC1ncQBxjx8Ue9jNJjFxYIQiee4hwmfiC7NsMks
         swh94FEr5GnCD6qogdu1lIMpZzqeVcDtxd7nTfgTMF2MshOUDHgvXm3MLRdLG1L5gNiv
         Br3g==
X-Gm-Message-State: APzg51BDqf6iPcAYdNqMqGXFwS4e7X8epaQVxD0gzqZjlFY2FrsRzZC7
        vStu7zYHp+XFbZgyUFB3mfoUS2JTepYVjdQNho43xNe7SmMo
X-Google-Smtp-Source: ANB0Vdb2BiuBOlLJDGrHq/xg3RtdmyZf5TeYCEdofTdNvCdOeKHsTXipBNaMXSN3sE7ImLuhIpV7TZU7V/doCD8Ux0uTOyH5j0Mw
MIME-Version: 1.0
X-Received: by 2002:a24:328e:: with SMTP id j136-v6mr155078ita.26.1536645902830;
 Mon, 10 Sep 2018 23:05:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 23:05:02 -0700
In-Reply-To: <0000000000005c23ca0575803f6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f19a705759241c3@google.com>
Subject: Re: general protection fault in rhashtable_walk_exit
From:   syzbot <syzbot+3f8324abccfbf8c74a9f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7c5cca358854 qmi_wwan: Support dynamic config on Quectel E..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10ea5bb6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=3f8324abccfbf8c74a9f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1029be66400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f7cd49400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3f8324abccfbf8c74a9f@syzkaller.appspotmail.com

RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6713 Comm: syz-executor470 Not tainted 4.19.0-rc2+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rhashtable_walk_exit+0x74/0x360 lib/rhashtable.c:689
Code: 8e 83 c7 00 f1 f1 f1 f1 c7 40 04 00 f2 f2 f2 65 48 8b 04 25 28 00 00  
00 48 89 45 d0 31 c0 e8 13 28 f0 fd 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 e5 01 00 00 48 8b 03 48 8d b8 00 01 00 00 e8
RSP: 0018:ffff8801b77d70e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff838ea71d RDI: 0000000000000000
RBP: ffff8801b77d7188 R08: ffff8801d3334680 R09: ffffed003a877e54
R10: ffffed003a877e54 R11: ffff8801d43bf2a3 R12: 1ffff10036efae20
R13: dffffc0000000000 R14: ffff8801b77d7160 R15: dffffc0000000000
FS:  0000000002080880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b5abc CR3: 00000001ce4b7000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tipc_dump_done+0x34/0x50 net/tipc/socket.c:3295
  __tipc_nl_compat_dumpit.isra.11+0x670/0xb30 net/tipc/netlink_compat.c:220
  tipc_nl_compat_dumpit+0x1f4/0x440 net/tipc/netlink_compat.c:267
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1169 [inline]
  tipc_nl_compat_recv+0x14a0/0x19a0 net/tipc/netlink_compat.c:1207
  genl_family_rcv_msg+0x8a9/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
  __sys_sendmsg+0x11d/0x280 net/socket.c:2152
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg net/socket.c:2159 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441d39
Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 04 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc3125798 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fffc31257b0 RCX: 0000000000441d39
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 037223c8463c1458 ]---
RIP: 0010:rhashtable_walk_exit+0x74/0x360 lib/rhashtable.c:689
Code: 8e 83 c7 00 f1 f1 f1 f1 c7 40 04 00 f2 f2 f2 65 48 8b 04 25 28 00 00  
00 48 89 45 d0 31 c0 e8 13 28 f0 fd 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 e5 01 00 00 48 8b 03 48 8d b8 00 01 00 00 e8
RSP: 0018:ffff8801b77d70e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff838ea71d RDI: 0000000000000000
RBP: ffff8801b77d7188 R08: ffff8801d3334680 R09: ffffed003a877e54
R10: ffffed003a877e54 R11: ffff8801d43bf2a3 R12: 1ffff10036efae20
R13: dffffc0000000000 R14: ffff8801b77d7160 R15: dffffc0000000000
FS:  0000000002080880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b5abc CR3: 00000001ce4b7000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

