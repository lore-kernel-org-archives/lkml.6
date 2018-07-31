Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC1BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941AE208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnqrSJjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941AE208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeGaRGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:06:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36955 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbeGaRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:06:10 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so13357360ioh.4;
        Tue, 31 Jul 2018 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0QXkBiTKA/6WYvVNwM2xrFqf8hlrLsZa7cTITxvd/zg=;
        b=JnqrSJjfXBwjE9DnRArcH5D6cOkONNyGDqpIh0z7bVIyyHjAtFvovDS4oIBUWE1QZE
         WtG+HzvJPhKAn0AP0WSGO1qMPJ7R3ErjakUN8wHiMz4CudYr28dBbJdU1MARqgqxXwAS
         U9Jh73gnNXNO0Y3Jxm9JVsPB4eZcFFKTIOqr0hBi5gClbBPWRwNKzaAzS/FXQvLdATZv
         KuXPuffT1B6U45s0erT1Z+Fugi97puMKK3tp3YOSLVpMyoBZPxAcEr8xn8M4XQSAr2lA
         h/KRMPUC6yN6Jv2EEcStZgI5SepGnSUXkzeJSea1GNC9IFTeXAEDzodGgWu1Lr2ClReW
         e3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0QXkBiTKA/6WYvVNwM2xrFqf8hlrLsZa7cTITxvd/zg=;
        b=iajt9HJsfCwf9y726I5Bm73IT9nv4Q4TCOqxfumfxEEc9X5xrY8/VNTEXvyWkT4cGM
         aJkQU0VmL/IcxWfS9v8NHKTmoB/aLLiVCaDb4SeqpcX+oX0fjvtXfBT4DnfbEoqct6oz
         l4QbzXfa+2EqksZhvbFN8PQaloIC76bmqnJrF04HoKww1w34m+BId8aT8FsoA939vxK0
         cuO0RXBnFphIpqRj17knHOZPgzLcpyNwJOaDmKnWtXYA+qhSrANAhG4XFytwwmtAIZP7
         eva9a258SyRdti5YQy0BsCs5MKtxorbGzn7WGQMNH5juGUL552wh+Ze1Rj3kJE53pD7Q
         oUtQ==
X-Gm-Message-State: AOUpUlG7SevoOuR6KdN6/MvU8G3TPmcagBeUF6N11YecunTSJ5klXmWi
        DouMzrzU3bzhmXIXtw/siAY=
X-Google-Smtp-Source: AAOMgpcNTQLviyJNtFI20vCgf70iu5OiXJSZmI2jlN3+i7x2b9cJfHXA3k+ajZUXVScgM9nG9wypyg==
X-Received: by 2002:a6b:a2d5:: with SMTP id l204-v6mr184353ioe.166.1533050720534;
        Tue, 31 Jul 2018 08:25:20 -0700 (PDT)
Received: from [192.168.86.235] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id q1-v6sm5918842iod.16.2018.07.31.08.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:25:19 -0700 (PDT)
Subject: Re: KASAN: stack-out-of-bounds Read in bpf_tcp_close
To:     syzbot <syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com>,
        ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000002f5daa05714d739b@google.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <9d8024eb-8797-28d6-76f1-4b5de00423a7@gmail.com>
Date:   Tue, 31 Jul 2018 08:25:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0000000000002f5daa05714d739b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 03:19 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    8ae71e76cf1f Merge branch 'bpf-offload-sharing'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1379a978400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=65a97319fd875ea52b73
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=114f4b2c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1774932c400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> swap_info_get: Bad swap file entry 8007fffc400d72b
> BUG: KASAN: stack-out-of-bounds in __read_once_size include/linux/compiler.h:188 [inline]
> BUG: KASAN: stack-out-of-bounds in smap_psock_sk kernel/bpf/sockmap.c:149 [inline]
> BUG: KASAN: stack-out-of-bounds in bpf_tcp_close+0xf10/0x1050 kernel/bpf/sockmap.c:316
> Read of size 8 at addr ffff8801adcc4428 by task syz-executor115/24313
> BUG: Bad page map in process syz-executor115  pte:1ffff10035cac810 pmd:1ae564067
> 
> CPU: 0 PID: 24313 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
> 
> addr:(____ptrval____) vm_flags:00000875 anon_vma:          (null) mapping:(____ptrval____) index:0
> Allocated by task 2294230744:
> usercopy: Kernel memory overwrite attempt detected to SLAB object 'task_struct(17:syz0)' (offset 6088, size 2)!
> file:syz-executor115250413 fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected to SLAB object 'task_struct(17:syz0)' (offset 4936, size 2)!
> WARNING: CPU: 0 PID: 24313 at mm/usercopy.c:81 usercopy_warn+0xf5/0x120 mm/usercopy.c:76
> CPU: 1 PID: 4479 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
> Kernel panic - not syncing: panic_on_warn set ...
> 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_bad_pte.cold.116+0x1cd/0x22b mm/memory.c:774
>  zap_pte_range mm/memory.c:1380 [inline]
>  zap_pmd_range mm/memory.c:1437 [inline]
>  zap_pud_range mm/memory.c:1466 [inline]
>  zap_p4d_range mm/memory.c:1487 [inline]
>  unmap_page_range+0x1cb9/0x2220 mm/memory.c:1508
>  unmap_single_vma+0x1a0/0x310 mm/memory.c:1553
>  unmap_vmas+0x120/0x1f0 mm/memory.c:1583
>  exit_mmap+0x2c2/0x5b0 mm/mmap.c:3105
>  __mmput kernel/fork.c:970 [inline]
>  mmput+0x265/0x620 kernel/fork.c:991
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0xea9/0x2750 kernel/exit.c:852
>  do_group_exit+0x177/0x440 kernel/exit.c:968
>  get_signal+0x88e/0x1970 kernel/signal.c:2468
>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
>  retint_user+0x8/0x18
> RIP: 0033:0x4731e0
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 002b:00007ffd426a9928 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000002e7e RCX: 00000000004731e0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd426a9930
> RBP: 0000000000002e7e R08: 0000000000000001 R09: 0000000000e2a880
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000f7e
> R13: 000000000003ab5f R14: 0000000000000000 R15: 0000000000000000
> CPU: 0 PID: 24313 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
> swap_info_get: Bad swap file entry 403fffe200725fc
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 

Seems KCM and ULPs are colliding here, sockmap/tls need
some extra checks. I'll have a fix shortly.

Thanks,
John






