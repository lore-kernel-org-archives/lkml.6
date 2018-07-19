Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD74FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpkkIzgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7907A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeGSI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:28:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42390 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeGSI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:28:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so1479859plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u8sLcwGacCLNxLBrn3e+tbzVoqmdUnfwKkECQOtAaAk=;
        b=mpkkIzgANj+MblG1CDtfmdnYTEHf1XyEViHHpOYyX8LPy+VnhqumfFYEvpSZfhRx3s
         vFJUJN345uDpdicgryVwNcsmWaZHg03O+yJPqrnAvKPrRgci9jNqduwL4Vf+p2c9pSRa
         Gusq9SwVrMLbPfEoqK9IZO3rpr3JbM3JPyfZ06Lick8vYP1LLv9q5jlJ2Z7xGKdsUliS
         IbQT0TzF1ar4IeQbc4Rb3ewJ1L0m8NgHAgYgW5Lz18Bdd75aCjulm+Z9W4pJgzBSIMiI
         waQp8p23xuxvFCm037ktleRzIEEe/jaEqFHqlRAPPkxjMo0O/S4gDy7qM0gjltd0pf13
         vLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u8sLcwGacCLNxLBrn3e+tbzVoqmdUnfwKkECQOtAaAk=;
        b=qsTz10iLnVkYAoJoHFAQ9lIy+cuqgRCnuI35qBw9Tv16ts0z41QxYyt8EnH31tlIq/
         97gns6aMx9bLqbHpSZzqwke2IJ9K+A9l3X2LvzK5wke1jLg2M+Zg1A/jc9hP6pPvM0wM
         6daObDbOi9/GmMAd5Lx41XPX9OXbRq+hlxaaZ/31e1uWjx4k/UU8fe743jpdRw58eqYv
         KJUPpwbGv9WYvb1wnyWx7vrA8jlWBPUUbc79XMPTB6MP+UPsXh93aACmdr5jjfd5EWOD
         KB5ex1y+aG20jLsKjNUqFtIY3X4P/QCLJSkxOETMSOMWf+u3w0mFQ2BDvV/VZVjZiLd7
         teuQ==
X-Gm-Message-State: AOUpUlELPhasr2bISmsmrsL8q1wLUOLe4kiZmN8bIqvG6uEs56rx66ns
        d8KjHtaSZyc10IXHwB8wHLsl8TrCmvHVbav4O9iebA==
X-Google-Smtp-Source: AAOMgpd9/3YGeCtZuGL98sYNPuBTSlGhj8J1wbamsoi0WZ+BbsqyLGXI9gu6wJJ3NlXOkS+i7cqcPznx0PMK9VuLKaE=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr9150916pll.85.1531986405824;
 Thu, 19 Jul 2018 00:46:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 19 Jul 2018 00:46:25
 -0700 (PDT)
In-Reply-To: <0000000000002f5daa05714d739b@google.com>
References: <0000000000002f5daa05714d739b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Jul 2018 09:46:25 +0200
Message-ID: <CACT4Y+YL3nKsiARboyfN0hY3+esoZkmBzLavbiHLSbXRP9nkvA@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in bpf_tcp_close
To:     syzbot <syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: bpf: sockhash, disallow bpf_tcp_close and update in parallel

On Thu, Jul 19, 2018 at 12:19 AM, syzbot
<syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8ae71e76cf1f Merge branch 'bpf-offload-sharing'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1379a978400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=65a97319fd875ea52b73
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=114f4b2c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1774932c400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> swap_info_get: Bad swap file entry 8007fffc400d72b
> BUG: KASAN: stack-out-of-bounds in __read_once_size
> include/linux/compiler.h:188 [inline]
> BUG: KASAN: stack-out-of-bounds in smap_psock_sk kernel/bpf/sockmap.c:149
> [inline]
> BUG: KASAN: stack-out-of-bounds in bpf_tcp_close+0xf10/0x1050
> kernel/bpf/sockmap.c:316
> Read of size 8 at addr ffff8801adcc4428 by task syz-executor115/24313
> BUG: Bad page map in process syz-executor115  pte:1ffff10035cac810
> pmd:1ae564067
>
> CPU: 0 PID: 24313 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>
> addr:(____ptrval____) vm_flags:00000875 anon_vma:          (null)
> mapping:(____ptrval____) index:0
> Allocated by task 2294230744:
> usercopy: Kernel memory overwrite attempt detected to SLAB object
> 'task_struct(17:syz0)' (offset 6088, size 2)!
> file:syz-executor115250413 fault:ext4_filemap_fault mmap:ext4_file_mmap
> readpage:ext4_readpage
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected
> to SLAB object 'task_struct(17:syz0)' (offset 4936, size 2)!
> WARNING: CPU: 0 PID: 24313 at mm/usercopy.c:81 usercopy_warn+0xf5/0x120
> mm/usercopy.c:76
> CPU: 1 PID: 4479 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
> Kernel panic - not syncing: panic_on_warn set ...
>
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_bad_pte.cold.116+0x1cd/0x22b mm/memory.c:774
>  zap_pte_range mm/memory.c:1380 [inline]
>  zap_pmd_range mm/memory.c:1437 [inline]
>  zap_pud_range mm/memory.c:1466 [inline]
>  zap_p4d_range mm/memory.c:1487 [inline]
>  unmap_page_range+0x1cb9/0x2220 mm/memory.c:1508
>  unmap_single_vma+0x1a0/0x310 mm/memory.c:1553
>  unmap_vmas+0x120/0x1f0 mm/memory.c:1583
>  exit_mmap+0x2c2/0x5b0 mm/mmap.c:3105
>  __mmput kernel/fork.c:970 [inline]
>  mmput+0x265/0x620 kernel/fork.c:991
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0xea9/0x2750 kernel/exit.c:852
>  do_group_exit+0x177/0x440 kernel/exit.c:968
>  get_signal+0x88e/0x1970 kernel/signal.c:2468
>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
>  retint_user+0x8/0x18
> RIP: 0033:0x4731e0
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 002b:00007ffd426a9928 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000002e7e RCX: 00000000004731e0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd426a9930
> RBP: 0000000000002e7e R08: 0000000000000001 R09: 0000000000e2a880
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000f7e
> R13: 000000000003ab5f R14: 0000000000000000 R15: 0000000000000000
> CPU: 0 PID: 24313 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
> swap_info_get: Bad swap file entry 403fffe200725fc
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002f5daa05714d739b%40google.com.
> For more options, visit https://groups.google.com/d/optout.
