Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0E8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF73E2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSelnCAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfABL36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:29:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39775 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfABL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:29:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so25887275edt.6;
        Wed, 02 Jan 2019 03:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=12qRhJPw0d5rJ6gvBywXMXD1+zvI0qW5xlG+Gs15/PY=;
        b=HSelnCAvjb2rFFrej1WKBNfo7sl10E2q+etN5XuBhx0KMaHYaUos1pLZwaz/eC/tUW
         33iXsnVY+IHZZz5obEuMEPs2rkyCjrMhAbDZTcgwUe2dBoWC1W3T8AkVo9zXdCNGThAS
         qZp+zseyNn8qh6O9Aqj6oK0jFRU21uhRC/nRzJoLaEygSGclLqnt5yl1Bw2/qBWH4xQ9
         TClm9bIAs4neLUbq4pu7FSu3cyTq9xOXt0e87lxRZyqGJmJX3gZJqpEKYkG8xVoL7Ii7
         WBBwghCOPxhNTAyrr1xwlLSCA9rGo98EJ8boxw+gevRk8Wzg82zwCHRsTfNjluW8JDFZ
         pv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12qRhJPw0d5rJ6gvBywXMXD1+zvI0qW5xlG+Gs15/PY=;
        b=qJ8RhaXMb3itBGlM1Fx+lbMbg/t3mpLa8vlH7Y+AzS7cmHPeh9i2qw5NwLiSRUXnrr
         fvW8mNlMoNyaaGYn+SnV3IHRBJMoFGKFMvJFO4Gv/eVAY8PpSPbpi/HKiq0e5EOWbRmd
         scAIE0kWDlgnLlqLQstj/3Mp4RDjKJUwrhbLs7rgFVE/2mXY5qgf5PwdsOHWgbmhVlpx
         Rc+RMPvihgnbS/3hy0uycVPNQvuUV+aZTMAtFU+upNl7Kg/idQNEXpyma39O/8oPMhX0
         hYbugZvQgpy8nOTaCTA5i0zLY+Tg42z+EvudoUefNPMSbS3cw8LZsl4rE+rchBRpmRrx
         Dzcw==
X-Gm-Message-State: AA+aEWY026hErX2IkBRtE/IfBe4FR9Rkxz/vr4ztqswdpmTzUgd4OBzN
        W/F+zHhwuIS9u/NrxBJE2vGDE9Ph
X-Google-Smtp-Source: AFSGD/XmzhrHl9FzI0IVuPShfgoSoicwIgZAGB/VvQKz8ThkSvTJkjhse69FOZaYoYY+AdwzuIDuGA==
X-Received: by 2002:a17:906:7751:: with SMTP id o17-v6mr32363126ejn.15.1546428594360;
        Wed, 02 Jan 2019 03:29:54 -0800 (PST)
Received: from [192.168.8.147] (148.86.136.77.rev.sfr.net. [77.136.86.148])
        by smtp.gmail.com with ESMTPSA id gy12-v6sm12563212ejb.44.2019.01.02.03.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 03:29:52 -0800 (PST)
Subject: Re: general protection fault in __smc_diag_dump
To:     syzbot <syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
References: <00000000000060600e057e7748dc@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2ffacbe4-a33a-8e82-a492-711c00b25754@gmail.com>
Date:   Wed, 2 Jan 2019 03:29:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00000000000060600e057e7748dc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 02:41 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    28e8c4bc8eb4 Merge tag 'rtc-4.21' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10c040d3400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
> dashboard link: https://syzkaller.appspot.com/bug?extid=5dd1f9327a9ee760048c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d17880c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
> IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> 8021q: adding VLAN 0 to HW filter on device batadv0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7982 Comm: syz-executor0 Not tainted 4.20.0+ #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:43 [inline]
> RIP: 0010:__smc_diag_dump.isra.0+0x32a/0x2ba0 net/smc/smc_diag.c:93
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 26 25 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 20 49 8d 7f 0e 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 d2
> RSP: 0018:ffff88808a29f120 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffff88807f4d7240 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff87b4e7c2 RDI: 000000000000000e
> RBP: ffff88808a29f3e8 R08: ffff88808d5721c0 R09: ffff888098960e90
> R10: fffffbfff14a0020 R11: ffffffff8a500103 R12: ffff88808878d760
> R13: ffff888098960e40 R14: ffff88807f4d76a0 R15: 0000000000000000
> FS:  00007f6b83b40700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000095561000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  smc_diag_dump_proto.isra.0+0x2e7/0x3c0 net/smc/smc_diag.c:211
>  smc_diag_dump+0x27/0x80 net/smc/smc_diag.c:225
>  netlink_dump+0x5f2/0x1070 net/netlink/af_netlink.c:2244
>  __netlink_dump_start+0x5b4/0x7e0 net/netlink/af_netlink.c:2352
>  netlink_dump_start include/linux/netlink.h:225 [inline]
>  smc_diag_handler_dump+0x2a7/0x350 net/smc/smc_diag.c:242
>  __sock_diag_cmd net/core/sock_diag.c:232 [inline]
>  sock_diag_rcv_msg+0x322/0x410 net/core/sock_diag.c:263
>  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
>  sock_diag_rcv+0x2b/0x40 net/core/sock_diag.c:274
>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
>  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xdd/0x130 net/socket.c:631
>  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
>  __sys_sendmsg+0x112/0x270 net/socket.c:2154
>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457ec9
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f6b83b3fc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000006
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b83b406d4
> R13: 00000000004c5188 R14: 00000000004d8a10 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace db4e074cdaa51579 ]---
> RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:43 [inline]
> RIP: 0010:__smc_diag_dump.isra.0+0x32a/0x2ba0 net/smc/smc_diag.c:93
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 26 25 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 20 49 8d 7f 0e 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 d2
> RSP: 0018:ffff88808a29f120 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffff88807f4d7240 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff87b4e7c2 RDI: 000000000000000e
> RBP: ffff88808a29f3e8 R08: ffff88808d5721c0 R09: ffff888098960e90
> R10: fffffbfff14a0020 R11: ffffffff8a500103 R12: ffff88808878d760
> R13: ffff888098960e40 R14: ffff88807f4d76a0 R15: 0000000000000000
> FS:  00007f6b83b40700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000095561000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches


Probable fix would be :

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c4da4a78d369e359f237772090ff0890a1782c5b..afa1e24fb935281219016c339b15939312f2c89c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -165,12 +165,12 @@ static int smc_release(struct socket *sock)
 
        /* detach socket */
        sock_orphan(sk);
-       sock->sk = NULL;
        if (!smc->use_fallback && sk->sk_state == SMC_CLOSED)
                smc_conn_free(&smc->conn);
        release_sock(sk);
 
        sk->sk_prot->unhash(sk);
+       sock->sk = NULL;
        sock_put(sk); /* final sock_put */
 out:
        return rc;

