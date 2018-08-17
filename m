Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B36C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B3A21A39
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYiFV/5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B3A21A39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeHQUVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:21:47 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41195 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:21:46 -0400
Received: by mail-ua1-f68.google.com with SMTP id h1-v6so6130744uao.8;
        Fri, 17 Aug 2018 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=/6G56r5YHBe2OBvIZgMZ2iGTeX4rr6xZ5DGTpDV03qM=;
        b=oYiFV/5/a4gwKzf9ZVjYPL6GFq+mq7u6ac/Tz57iq/bgdiIEylbqnjKHZfptk/PaHt
         8TzD2rMwug2cKhO60eCEffV/RgSH/bvbncXy3OA6p82kXvZOd0sE6PoPYoKp7Nf67yRn
         XV8JZMsliMFQtKSxtUfXkmDGquLQJhk2/2d2757vvTETayQn9WbtO83W5gLhPwCZXO59
         PgxGey0E00sE4+7YS6GWkjQvce87lg69Pi4lwbzPkaQIOqs7x07HuNQxXAc9m2byA2Yu
         h/OGQQxFn7+z1l9xd3nFMWw4LEBPhZDKO3EGrKDTwMeh8Qb6mA8Uw/Ba8qcJEOeT3iYt
         o5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/6G56r5YHBe2OBvIZgMZ2iGTeX4rr6xZ5DGTpDV03qM=;
        b=t0BZdumhOaE/kpXtDRde77cONu9osCj49gaR6Ghdi7mEV73QDSBW9jFH5f7QjiQpfx
         zyyqzdnX4x9qthuKsjaihqlcPMDr1T/LHFjxCV8Fa22u+i3z70i9uEx1d31CEOoxsTKE
         TsomykCTYmWAoOEN1jtywZj10kOo7L/xN/ov5Fr5uewMMBALUMx4SO8k69WLv4XZ7Cke
         2v3XMYWc8PTkesh07MEvHCHpWsCW35pmf2P6HV1lin7Liq0aSX+wEgtsKTNEj/JlJ1Mm
         ZfIluly4m96lwCktpjX+uBBIECkqIcxQBNVLwjVoISOpB/RINFyB6GEnCJdmxNYdcYYt
         nnvA==
X-Gm-Message-State: AOUpUlFfX77GPdRqOq3kz9nxqtuumOdE5hLdoDs5KeAyx+FwoKhYPg56
        TauDlaLQlWynfpNyVO1mWkhiNePiiV+zB4lzOYo1yuQScw==
X-Google-Smtp-Source: AA+uWPwBcR7ySBJRkNOdLdzjQ1ahWybAmlbcV8z2BIaNcHYj+p3c4b1CTYeY/cmjrrbc8JeVbu+e3vabS2VOJ+xcqjI=
X-Received: by 2002:ab0:51d2:: with SMTP id h18-v6mr23665657uaa.165.1534526254756;
 Fri, 17 Aug 2018 10:17:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:e915:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 10:17:14
 -0700 (PDT)
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Fri, 17 Aug 2018 13:17:14 -0400
Message-ID: <CAP8WD_YEyxKOimMrGk+5Db8DpNfqQL84-2xLXbe53jiY_FoPrQ@mail.gmail.com>
Subject: Allocation failure with subsequent kernel crash
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to bisect this crash but I have not found a
reliable reproducer. My best guess is that it was introduced after the
4.14 release.

This is a 32 bit kernel. It is odd in that it first generates a memory
allocation failure, and then quickly crashes with a succeeding bug.

I'm including the netdev group since there is a lot of BPF stacktrace.

[   42.512745] systemd: vmalloc: allocation failure: 0 bytes,
mode:0x14080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
[   42.526396] CPU: 0 PID: 1 Comm: systemd Not tainted
4.14.0.bisect-4.k5-tsc-desktop+ #168
[   42.535878] Hardware name:   AX5TC/AX5TC, BIOS 4.51 PG 03/23/98
[   42.540944] Call Trace:
[   42.550334]  dump_stack+0x16/0x18
[   42.558519]  warn_alloc+0xa3/0x10b
[   42.563844]  __vmalloc_node_range+0x170/0x17d
[   42.574293]  __vmalloc_node+0x35/0x3a
[   42.586454]  ? bpf_check+0x52/0x2c64
[   42.594504]  vzalloc+0x21/0x23
[   42.602499]  ? bpf_check+0x52/0x2c64
[   42.614418]  bpf_check+0x52/0x2c64
[   42.622623]  ? slob_page_alloc+0x130/0x177
[   42.642524]  ? vmap_page_range_noflush+0xe/0x109
[   42.655415]  ? slob_page_alloc+0x130/0x177
[   42.666466]  ? native_io_delay+0x8/0x2e
[   42.674455]  ? tk_clock_read+0xa/0xd
[   42.685808]  ? timekeeping_get_ns+0x10/0x70
[   42.688097]  ? ktime_get_with_offset+0x49/0x66
[   42.702478]  bpf_prog_load+0x2fc/0x442
[   42.710467]  ? bpf_prog_load+0x2fc/0x442
[   42.722474]  ? bpf_prog_array_alloc+0x1b/0x24
[   42.734478]  ? bpf_prog_array_alloc+0x1b/0x24
[   42.746532]  ? compute_effective_progs+0x5c/0xb7
[   42.758492]  ? css_next_descendant_pre+0xa/0x43
[   42.766488]  ? cap_capable+0xa/0x5d
[   42.778457]  ? security_capable+0x2d/0x40
[   42.786537]  ? __copy_from_user_ll_nocache_nozero+0xb/0x37
[   42.799175]  ? __copy_user_ll+0xd/0xf
[   42.810492]  ? security_bpf+0xc/0x3b
[   42.816807]  SyS_bpf+0x7f7/0xd79
[   42.822333]  ? __rcu_read_unlock+0x9/0x4b
[   42.834457]  ? mntput_no_expire+0x28/0x119
[   42.842525]  do_int80_syscall_32+0x45/0x57
[   42.854449]  ? do_int80_syscall_32+0x45/0x57
[   42.866486]  entry_INT80_32+0x27/0x27
[   42.878299] EIP: 0xb7a95082
[   42.881808] EFLAGS: 00000246 CPU: 0
[   42.886454] EAX: ffffffda EBX: 00000005 ECX: bfe76e40 EDX: 00000048
[   42.902452] ESI: 00000040 EDI: 00000000 EBP: 00a8a458 ESP: bfe76e0c
[   42.918413]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   42.932627] Mem-Info:
[   42.936616] active_anon:845 inactive_anon:31 isolated_anon:0
[   42.936616]  active_file:4364 inactive_file:9478 isolated_file:0
[   42.936616]  unevictable:0 dirty:428 writeback:0 unstable:0
[   42.936616]  slab_reclaimable:0 slab_unreclaimable:0
[   42.936616]  mapped:4966 shmem:54 pagetables:46 bounce:0
[   42.936616]  free:47214 free_pcp:25 free_cma:0
[   42.946479] Node 0 active_anon:3380kB inactive_anon:124kB
active_file:17456kB inactive_file:37912kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB mapped:19928kB dirty:1720kB
writeback:0kB shmem:216kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? no
[   42.958503] Normal free:188856kB min:2012kB low:2512kB high:3012kB
active_anon:3380kB inactive_anon:124kB active_file:17456kB
inactive_file:37912kB unevictable:0kB writepending:1732kB
present:261756kB managed:254168kB mlocked:0kB kernel_stack:328kB
pagetables:184kB bounce:0kB free_pcp:100kB local_pcp:100kB
free_cma:0kB
[   42.970387] lowmem_reserve[]: 0 0
[   42.978444] Normal: 26*4kB (U) 34*8kB (UM) 10*16kB (UM) 5*32kB (U)
4*64kB (U) 4*128kB (U) 4*256kB (UM) 0*512kB 2*1024kB (U) 0*2048kB
45*4096kB (M) = 188856kB
[   42.986472] 13897 total pagecache pages
[   42.998400] 0 pages in swap cache
[   43.007903] Swap cache stats: add 0, delete 0, find 0/0
[   43.010200] Free swap  = 0kB
[   43.013762] Total swap = 0kB
[   43.024725] 65439 pages RAM
[   43.034360] 0 pages HighMem/MovableOnly
[   43.046385] 1897 pages reserved

[   43.054521] BUG: unable to handle kernel NULL pointer dereference at 00000004
[   43.058026] IP: free_used_maps+0xe/0x2a
[   43.058026] *pde = 00000000
[   43.058026] Oops: 0000 [#1] PREEMPT
[   43.058026] Modules linked in: uhci_hcd ehci_pci ehci_hcd usbcore
3c59x i2c_piix4 i2c_core mii usb_common autofs4
[   43.058026] CPU: 0 PID: 1 Comm: systemd Not tainted
4.14.0.bisect-4.k5-tsc-desktop+ #168
[   43.058026] Hardware name:   AX5TC/AX5TC, BIOS 4.51 PG 03/23/98
[   43.058026] task: c00177c0 task.stack: c0032000
[   43.058026] EIP: free_used_maps+0xe/0x2a
[   43.058026] EFLAGS: 00010246 CPU: 0
[   43.058026] EAX: 00000000 EBX: 00000000 ECX: cfdf60b0 EDX: cff95274
[   43.058026] ESI: 00000000 EDI: 00000008 EBP: c0033e50 ESP: c0033e48
[   43.058026]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[   43.058026] CR0: 80050033 CR2: 00000004 CR3: 0034b000 CR4: 00000010
[   43.058026] Call Trace:
[   43.058026]  bpf_prog_load+0x3ce/0x442
[   43.058026]  ? bpf_prog_array_alloc+0x1b/0x24
[   43.058026]  ? bpf_prog_array_alloc+0x1b/0x24
[   43.058026]  ? compute_effective_progs+0x5c/0xb7
[   43.058026]  ? css_next_descendant_pre+0xa/0x43
[   43.058026]  ? cap_capable+0xa/0x5d
[   43.058026]  ? security_capable+0x2d/0x40
[   43.058026]  ? __copy_from_user_ll_nocache_nozero+0xb/0x37
[   43.058026]  ? __copy_user_ll+0xd/0xf
[   43.058026]  ? security_bpf+0xc/0x3b
[   43.058026]  SyS_bpf+0x7f7/0xd79
[   43.058026]  ? __rcu_read_unlock+0x9/0x4b
[   43.058026]  ? mntput_no_expire+0x28/0x119
[   43.058026]  do_int80_syscall_32+0x45/0x57
[   43.058026]  ? do_int80_syscall_32+0x45/0x57
[   43.058026]  entry_INT80_32+0x27/0x27
[   43.058026] EIP: 0xb7a95082
[   43.058026] EFLAGS: 00000246 CPU: 0
[   43.058026] EAX: ffffffda EBX: 00000005 ECX: bfe76e40 EDX: 00000048
[   43.058026] ESI: 00000040 EDI: 00000000 EBP: 00a8a458 ESP: bfe76e0c
[   43.058026]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   43.058026] Code: 89 43 30 89 43 34 c7 43 38 40 8c 07 c1 8d 4b 2c
b8 01 00 00 00 e8 7b d4 fa ff 5b 5d c3 55 89 e5 56 53 e8 e4 6d f9 ff
31 db 89 c6 <39> 5e 04 8b 46 38 76 0b 8b 04 98 43 e8 9b ff ff ff eb ed
e8 5b
[   43.058026] EIP: free_used_maps+0xe/0x2a SS:ESP: 0068:c0033e48
[   43.058026] CR2: 0000000000000004
[   43.070394] ---[ end trace 76c4354246d4bc3b ]---
[   43.154492] systemd: 35 output lines suppressed due to ratelimiting
[   43.172970] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
[   43.172970]
[   43.174034] Kernel Offset: disabled
[   43.174034] Rebooting in 45 seconds..
