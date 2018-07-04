Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3BBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8406C24159
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6MmXAa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8406C24159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeGDVYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:24:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39694 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbeGDVYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:24:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so251485plq.6;
        Wed, 04 Jul 2018 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ciqMw2xm929vxIr6CAkgJjttzf7OdEf+QxCKh8fV+xE=;
        b=f6MmXAa8PXw46NLTTm4qLYNGj2wRFhHlb6fT6R4EqUwkfzq+KeV+O6xFW4vF8VUOEF
         ZcHHBwW0Ns5cDuGl2N39mc7lk4gSZ2aVTe785pvaAbJplIDOqd+cVTlYxMon6bOWzDGx
         EYobWRg2ZcDj14FkUHX5YDfjFje9wuZO1GLntaQzJ7LYKaNXyF0P5JqBnzgXSgTmtPIj
         9eJ6Y1tunUGRRMJnFBxYNDEsmlkYK78yD6Txn91BfBg0+i5OpRyxmG2Cy4ZfPRoQEVvO
         EpgfUnLPFnz8wDQSatRqpAaX0qV/zubVB9VdHhreQFNf6A4SESqO1kG7Qy9onICHgBfu
         DPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ciqMw2xm929vxIr6CAkgJjttzf7OdEf+QxCKh8fV+xE=;
        b=VfmmddPHj1sBRkbW9PM/o6O7aGravyi+eN4ZA+CkdqEr+D9lye5CvYZmP5eRH+DW8S
         Dysv0yNgi7VaXX2Rn72MBA4WeccNSjgMfxXCDNqgkQWn46CUA8zuIyQd0yzLTSQXWIuo
         pR4dpgBSCQbrOavBXMtyApRkl2qpsROKyNiYefHHd6BbyXHO/wFPOHZzYvX6UGvVLbws
         iwuibitBNi0PRBOILqt5cs7LDaIjMTEbQOwf05GRL+kBumQjPA8I59qSjMXtfw73uWc6
         QcNq927BtopbyYPKURXcC9PCrp/yh37rrXzJuMmw3iHcj2HO56kJjuyazKKogjt/7Xpv
         PZoA==
X-Gm-Message-State: APt69E2yDjKKyLnboXtvjx26oxZq3xuw86cFOvFb7LtIxXndYZn0Jh0z
        CNxsoIXUFLgVXa2NdqIGvGXK4PC5
X-Google-Smtp-Source: AAOMgpc6sgGZjD6DiJE95zxgCsm7FChfePfJtBXRrq6fhjBBLuZ881Kd90bNPbgP9fGvIvBlFXV2yg==
X-Received: by 2002:a17:902:a508:: with SMTP id s8-v6mr3565306plq.223.1530739450232;
        Wed, 04 Jul 2018 14:24:10 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id h26-v6sm8992681pfj.77.2018.07.04.14.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 14:24:09 -0700 (PDT)
Date:   Wed, 4 Jul 2018 14:24:08 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+9d1c0d941336dbc741a1@syzkaller.appspotmail.com>
Cc:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ODEBUG bug in do_arpt_get_ctl
Message-ID: <20180704212408.GG725@sol.localdomain>
References: <94eb2c0efc1e7e42b20565bf3254@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c0efc1e7e42b20565bf3254@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:59:03PM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 91ab883eb21325ad80f3473633f794c78ac87f51 (Mon Feb 19 01:29:42 2018 +0000)
> Linux 4.16-rc2
> 
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9d1c0d941336dbc741a1@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: work_struct hint:
> htable_gc+0x0/0xc0 net/netfilter/xt_hashlimit.c:376
> WARNING: CPU: 1 PID: 4165 at lib/debugobjects.c:291
> debug_print_object+0x166/0x220 lib/debugobjects.c:288
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 4165 Comm: syz-executor3 Not tainted 4.16.0-rc2+ #320
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x58/0x80 arch/x86/entry/entry_64.S:957
> RIP: 0010:debug_print_object+0x166/0x220 lib/debugobjects.c:288
> RSP: 0018:ffff8801b3d8f790 EFLAGS: 00010082
> RAX: dffffc0000000008 RBX: 0000000000000003 RCX: ffffffff815abdbe
> RDX: 0000000000000000 RSI: 1ffff100367b1ea2 RDI: 1ffff100367b1e77
> RBP: ffff8801b3d8f7d0 R08: 0000000000000000 R09: 1ffff100367b1e49
> R10: ffffed00367b1f21 R11: ffffffff86b394b8 R12: 0000000000000001
> R13: ffffffff86b14d80 R14: ffffffff86007de0 R15: ffffffff8147ac00
>  __debug_check_no_obj_freed lib/debugobjects.c:745 [inline]
>  debug_check_no_obj_freed+0x662/0xf1f lib/debugobjects.c:774
>  __vunmap+0x112/0x380 mm/vmalloc.c:1530
>  vfree+0x50/0xe0 mm/vmalloc.c:1606
>  copy_entries_to_user net/ipv4/netfilter/arp_tables.c:714 [inline]
>  get_entries net/ipv4/netfilter/arp_tables.c:867 [inline]
>  do_arpt_get_ctl+0x7c4/0xa00 net/ipv4/netfilter/arp_tables.c:1485
>  nf_sockopt net/netfilter/nf_sockopt.c:104 [inline]
>  nf_getsockopt+0x6a/0xc0 net/netfilter/nf_sockopt.c:122
>  ip_getsockopt+0x15c/0x220 net/ipv4/ip_sockglue.c:1571
>  tcp_getsockopt+0x82/0xd0 net/ipv4/tcp.c:3359
>  sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2934
>  SYSC_getsockopt net/socket.c:1880 [inline]
>  SyS_getsockopt+0x178/0x340 net/socket.c:1862
>  do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x45687a
> RSP: 002b:0000000000a3eb48 EFLAGS: 00000212 ORIG_RAX: 0000000000000037
> RAX: ffffffffffffffda RBX: 0000000000000027 RCX: 000000000045687a
> RDX: 0000000000000061 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000a3f200 R08: 0000000000a3eb7c R09: 0000000000000001
> R10: 0000000000a3f200 R11: 0000000000000212 R12: 0000000000a3eb80
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000001380
> 

Like the similar bug report "WARNING: ODEBUG bug in do_ipt_get_ctl" [1], this
report doesn't make sense as there is no work_struct in the array being freed.
And this last occurred 4 months ago.  So I am invalidating this one too as it
probably was a weird bug elsewhere in the kernel that has since been fixed:

#syz invalid

[1] https://groups.google.com/forum/#!msg/syzkaller-bugs/A_gWpsvtxKc/5YSSVpImDQAJ

- Eric
