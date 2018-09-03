Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48176C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DB420856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ywo+roAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DB420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeICJPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:15:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44550 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:15:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so8048023plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 21:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6zGYZmAU5seaH1VaJCT1aEMjO+hXFb7x2aPrdciV1d0=;
        b=Ywo+roAklwhIpGvE5P0XKFspdXCGjDG4qnCGH6Cpy/7horluWY/hyZjmp8rI4KeH32
         YZKp1W3DSCOFBq+o7BnevPQUM0qVJqK13kZRnt2lRmfAVdwCBWUAMYOXSYzU4kjaHcdy
         OBxCQLKGCEBtOYquG0i0yWna+lpDaown3gXkCsnrQt2vVoVPYc7JLKCjiOaJH0q/8Xpj
         0mv8F7lT0NMZ/z7jicnfK3RWApXEkTtl5Ybvf+fWsnZZAu3cMELnt5pgUz/FBnp1BJjK
         fq3bsQGD5GezjR9ngOiE2xbHL/d4hxtKLO+glHVqq7H9HgbXusrVuYH+Kl7PWQ5Yrmug
         c6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6zGYZmAU5seaH1VaJCT1aEMjO+hXFb7x2aPrdciV1d0=;
        b=gxWklj11ZJDGYoGH61QxENLtyWMHCSF70g0B5D4O0NApZkQIhATEqse8KzGyaskfdg
         PY8Wz9tp8jCCFbLVjZ8GOox+ydH/7uR8NsR7W0bq2DzlKDDbKrBbirdfW0EHdokiZRyi
         QM92DncJAfia9hm7ps5aa9faPk6S/bDgHLfmdOzbNmoGx+VArR3D5lBEityiDza63kOb
         DlO25+koOPRIvGRA8r+5zw+95JMO7GL3Ab+tt1Iz/0leuug7U388kbprxyZb+LwpRz9U
         W33OMHxedL5RPE2apYARYzRBKtRM4XZkaYfvpqtcw1H1HsHR2lP2DfL8OM0w9qNgaD1d
         WpBA==
X-Gm-Message-State: APzg51AWUbr4/eepTxGzml/XYsifJtVQ7o3WjGxJ8UhCTrj3d3hY/EWn
        y8w/iiUjt0XrnApXgdaDs425A/cR4ucnyDRQ2HMOYA==
X-Google-Smtp-Source: ANB0VdZQa2/TBtCEsqIol7/vlCss6IwM4dG98ikskC+We/085MOQjVoYPiTN1PCiEKNpucMtqAUPFhIkHBtOa1ihebQ=
X-Received: by 2002:a17:902:48c8:: with SMTP id u8-v6mr27117390plh.152.1535950600417;
 Sun, 02 Sep 2018 21:56:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Sun, 2 Sep 2018 21:56:19
 -0700 (PDT)
In-Reply-To: <000000000000f0c659056f7af058@google.com>
References: <0000000000002b532a056ebcb3eb@google.com> <000000000000f0c659056f7af058@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Sep 2018 06:56:19 +0200
Message-ID: <CACT4Y+bztV23fSL66x9zy+BN+Bo4dqByx8-egZf-N=9kgV=qEg@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in pid_task
To:     syzbot <syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>, weiyongjun1@huawei.com,
        netdev <netdev@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 7:45 PM, syzbot
<syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com> wrote:
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    6f0d349d922b Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c04304400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2d4c3ae3fd90bbaf059
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14f0a814400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce574c400000

Probably bpfilter problem, +bpfilter maintainers.


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com
>
> bpfilter: read fail -512
>
> =============================
> WARNING: suspicious RCU usage
> 4.18.0-rc2+ #117 Not tainted
> -----------------------------
> kernel/pid.c:323 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor106/7744:
>  #0: 00000000bee82115 (bpfilter_lock){+.+.}, at:
> __bpfilter_process_sockopt+0x1c5/0x39b net/bpfilter/bpfilter_kern.c:67
>
> stack backtrace:
> CPU: 1 PID: 7744 Comm: syz-executor106 Not tainted 4.18.0-rc2+ #117
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4562
>  pid_task+0x1ce/0x200 kernel/pid.c:322
>  shutdown_umh.constprop.0+0x33/0x7c net/bpfilter/bpfilter_kern.c:29
>  __stop_umh net/bpfilter/bpfilter_kern.c:41 [inline]
>  __bpfilter_process_sockopt.cold.1+0x9b/0xa0 net/bpfilter/bpfilter_kern.c:81
>  bpfilter_mbox_request+0x4d/0xb0 net/ipv4/bpfilter/sockopt.c:25
>  bpfilter_ip_set_sockopt+0x33/0x40 net/ipv4/bpfilter/sockopt.c:31
>  ip_setsockopt+0x124/0x140 net/ipv4/ip_sockglue.c:1250
>  dccp_setsockopt+0x96/0xf0 net/dccp/proto.c:565
>  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3040
>  __sys_setsockopt+0x1c5/0x3b0 net/socket.c:1947
>  __do_sys_setsockopt net/socket.c:1958 [inline]
>  __se_sys_setsockopt net/socket.c:1955 [inline]
>  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1955
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x44cdb9
> Code: e8 6c bd 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f63b04a8d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00000000006dfce4 RCX: 000000000044cdb9
> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000027
> RBP: 00000000006dfce0 R08: 0000000000000000 R09: 65732f636f72702f
> R10: 0000000020000000 R11: 0000000000000246 R12: 00007f63b04a8d20
> R13: 0100000000000000 R14: 6273752f7665642f R15: 0000000000000034
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f0c659056f7af058%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
