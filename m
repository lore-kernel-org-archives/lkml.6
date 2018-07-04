Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC2AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9F92420C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6R8/IP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9F92420C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeGDUa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:30:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45730 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeGDUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:30:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id y24-v6so3414771pfe.12;
        Wed, 04 Jul 2018 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMd3809bFGUU1SJ5E4TKFQUnZV5N8Kczi26yBK5egG0=;
        b=O6R8/IP8BlefEu4J4SRFWFjMi8gAefzvbXsDktsUaXlejFhsjDvEYAvclvIW0P6/En
         EsjHCgFFp3lg8CN3g/H3eKyObqwyFo/PrDzdkAP/UkLtO+DPKlZCuUVZ4VvPXTdJ/TGf
         4fzV1lxWrZw9Yul8kP1CJnHTwvQ5hYm/NVyULoqR8dCVySlRiPdOykwgDDIbMWC1RhZJ
         slYffTC10QianqK/u3DE490gdAu0Grbjm7/Qyb2EHPagWw0d+x+R7SF4Dskmx95ab63B
         Ze+16u+F4Kh4fXXNcINNvWKss+LejqMUEYrchlcYVV9NiePWE4a8dku6IQEfS8W+aZpD
         U7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMd3809bFGUU1SJ5E4TKFQUnZV5N8Kczi26yBK5egG0=;
        b=sGh5YEhdqPs9syuEaa3ZPQDDH6qIOz1jT1H5xGdoGavKjE1k7DH8rjQXnShr62TAha
         nlw+CYyCHaamwg6dsnL4oLdfHiN6BUj739KA6TjixJhBkYxJKWd5Dj9qO7HarHPzOhkF
         QFnOzrRj/27hbVh7VlT8HkFTDoTmizlpGpAemPfmsojUjrHdk3CCv2yKlpwXXqBsJNna
         nf++Sl510YnyFY1ZqJiqmsZ+DNzLTjXngjyw89CvVv0bpJ+tym6rlOwdWRsCMmFB8AWA
         gVwfSm+CoITqXkJjn/W5fV2ZImAAKUdjvHLmA1KgwLUws0pQsz7DGPgj8Ob9fr/WKyJu
         KGxg==
X-Gm-Message-State: APt69E2I7KeEEuALvqSRyhAI7qTJkpAHNEKmK0GMmSFPhX39qhrPd3FI
        4PXm4VRY+pHS0MY7DbxxT4k=
X-Google-Smtp-Source: AAOMgpewfiTjsa24iDkHmGIdZzUfWoLon5k27fuOWNcBv7Hd3sS2p9Kz+XO1fKvLlF3JY1b5Z5b0YA==
X-Received: by 2002:a62:4494:: with SMTP id m20-v6mr3540575pfi.205.1530736224201;
        Wed, 04 Jul 2018 13:30:24 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id z10-v6sm7616485pgo.58.2018.07.04.13.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 13:30:23 -0700 (PDT)
Date:   Wed, 4 Jul 2018 13:30:21 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+f25098149f0536920141@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Subject: Re: BUG: corrupted list in tipc_nametbl_unsubscribe
Message-ID: <20180704203021.GD725@sol.localdomain>
References: <001a114535f203560405670110f5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114535f203560405670110f5@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 12:59:04PM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on net-next commit
> fd372a7a9e5e9d8011a0222d10edd3523abcd3b1 (Thu Mar 8 19:43:48 2018 +0000)
> Merge tag 'mlx5-updates-2018-02-28-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
> 
> So far this crash happened 2 times on net-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f25098149f0536920141@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Name sequence creation failed, no memory
> Failed to create subscription for {1020,0,4294967295}
> list_del corruption. prev->next should be 00000000f6eff561, but was
> (null)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:53!
> invalid opcode: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4187 Comm: syzkaller951783 Not tainted 4.16.0-rc4+ #258
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__list_del_entry_valid+0xef/0x150 lib/list_debug.c:51
> RSP: 0018:ffff8801b7ed6ec8 EFLAGS: 00010282
> RAX: 0000000000000054 RBX: ffffffff879ffd20 RCX: 0000000000000000
> RDX: 0000000000000054 RSI: 1ffff10036fdad8e RDI: ffffed0036fdadcd
> RBP: ffff8801b7ed6ee0 R08: 1ffff10036fdad25 R09: 0000000000000000
> R10: ffff8801b7ed6da8 R11: 0000000000000000 R12: ffffffffffffffff
> R13: ffff8801b7ed7080 R14: ffff8801b7f6d998 R15: ffff8801d59c6c00
> FS:  0000000000000000(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3357e55000 CR3: 0000000006e22001 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del_init include/linux/list.h:159 [inline]
>  tipc_nametbl_unsubscribe+0x337/0x990 net/tipc/name_table.c:855
>  tipc_sub_unsubscribe+0x6d/0x2e0 net/tipc/subscr.c:164
>  tipc_conn_delete_sub+0x324/0x4a0 net/tipc/topsrv.c:245
>  tipc_topsrv_kern_unsubscr+0x21d/0x350 net/tipc/topsrv.c:598
>  tipc_group_delete+0x2c0/0x3d0 net/tipc/group.c:231
>  tipc_sk_leave+0x10b/0x200 net/tipc/socket.c:2794
>  tipc_release+0x154/0xff0 net/tipc/socket.c:577
>  sock_release+0x8d/0x1e0 net/socket.c:594
>  sock_close+0x16/0x20 net/socket.c:1149
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  SYSC_exit_group kernel/exit.c:979 [inline]
>  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x43f0c8
> RSP: 002b:00007ffd4b6bf148 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f0c8
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf1a8 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000020265000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> Code: 4c 89 e2 48 c7 c7 c0 7c 40 86 e8 75 f6 fb fe 0f 0b 48 c7 c7 20 7d 40
> 86 e8 67 f6 fb fe 0f 0b 48 c7 c7 80 7d 40 86 e8 59 f6 fb fe <0f> 0b 48 c7 c7
> e0 7d 40 86 e8 4b f6 fb fe 0f 0b 48 89 df 48 89
> RIP: __list_del_entry_valid+0xef/0x150 lib/list_debug.c:51 RSP:
> ffff8801b7ed6ec8
> ---[ end trace 1d4e489a074c9174 ]---
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

This was fixed by commit c3317f4db831b75 (thanks Jon!):

#syz fix: tipc: fix unbalanced reference counter

- Eric
