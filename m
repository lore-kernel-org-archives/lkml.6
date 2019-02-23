Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B94C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C63620651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVclmUU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfBWACQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:02:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33869 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:02:16 -0500
Received: by mail-it1-f194.google.com with SMTP id d125so12716009ith.1;
        Fri, 22 Feb 2019 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3C3cNeeKq6yucYAZybEpBTQGnb4Kd2vihQcCCjoV4VE=;
        b=LVclmUU5fmqaWloSNui5OgBEjuoeOpAd3mKWcjnkKg29zFHOUrzgJgYQEIAG0v/uDt
         QNjw585CvgUAQjf9zAcRr6S/32DuKqTdTGyZoHY1zlBe1UCH0V4Vy7FJ/5x+up5S9/sF
         7ij9NsYknPxsriqXKbH+P+eOlFlg5CLVwmiayi17hvkBqwigNPF7IUDAb9jn1LVYiK6e
         aVJEfWZZTmNDgCl3lYQKI9Hl9soYj0LO2ryAw4lrFh1u2qdH/4ET0eHbGbEaapMM5ZDi
         TYX2VHI8st6/ZSyu0YqBJQems6sBthrvBE1BsV3nkL2LSoM14VUGTMTaXU8BdOwf3L47
         4xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3C3cNeeKq6yucYAZybEpBTQGnb4Kd2vihQcCCjoV4VE=;
        b=P9MZMjthShF7hoPP9GXB1+YO1y2LWEjcIeSIgfGwBBXMkOWF4pYahdlbUwTGPsVtTD
         2dgRbd3r2LTu+UCoYhIn3/Obkjqv6tlLGpLQJGOhNT6ipP5L9BDRCQXiO9IvjDGvRZId
         AJrMp8llN46DO4tP56Z+5Y+UbV71OiJQDD6oDeGOHtsDHGNnEkp+DCkvavANaoJcJyWs
         70HVvElA/Z7z9lGbXolcGaPSqf2iNDjHkNA/Wd8QMkmm/K5oTNdSwJn+EcQORVPB3coq
         etf6+mj42XHZNPf/XBdtt+9fKAnupEVFtXTR+Wo0D4gV899vRvPH5V5JcGDD6WxgZcds
         om1Q==
X-Gm-Message-State: AHQUAuZ0B/1Sw13qYWWIOsPa5NctfJRnbVmtl1cxzQTvCpvVoKI2Yv+E
        Rs9JaOxMQMwzmTs60KZcjNfBCQaC3hQLYY/eNpU=
X-Google-Smtp-Source: AHgI3IbLkhj0g0MkN77ESiSD1H1GhHyo0t8ZVxeb1Ayb0AS5pP8KUc4Ortj9UVmpEXkgeEPEJQdExX+1SYWW8Fz0gME=
X-Received: by 2002:a24:45e3:: with SMTP id c96mr3626180itd.89.1550880132439;
 Fri, 22 Feb 2019 16:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 22 Feb 2019 16:02:00 -0800
Message-ID: <CAKgT0UdLgkWNJkMu-4pS5dKdQiA_Ux_myjitJpG10Xtf=G-=FA@mail.gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 1:47 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote=
:
>
> The following patch-set proposes an efficient mechanism for handing freed=
 memory between the guest and the host. It enables the guests with no page =
cache to rapidly free and reclaims memory to and from the host respectively=
.
>
> Benefit:
> With this patch-series, in our test-case, executed on a single system and=
 single NUMA node with 15GB memory, we were able to successfully launch atl=
east 5 guests
> when page hinting was enabled and 3 without it. (Detailed explanation of =
the test procedure is provided at the bottom).
>
> Changelog in V8:
> In this patch-series, the earlier approach [1] which was used to capture =
and scan the pages freed by the guest has been changed. The new approach is=
 briefly described below:
>
> The patch-set still leverages the existing arch_free_page() to add this f=
unctionality. It maintains a per CPU array which is used to store the pages=
 freed by the guest. The maximum number of entries which it can hold is def=
ined by MAX_FGPT_ENTRIES(1000). When the array is completely filled, it is =
scanned and only the pages which are available in the buddy are stored. Thi=
s process continues until the array is filled with pages which are part of =
the buddy free list. After which it wakes up a kernel per-cpu-thread.
> This kernel per-cpu-thread rescans the per-cpu-array for any re-allocatio=
n and if the page is not reallocated and present in the buddy, the kernel t=
hread attempts to isolate it from the buddy. If it is successfully isolated=
, the page is added to another per-cpu array. Once the entire scanning proc=
ess is complete, all the isolated pages are reported to the host through an=
 existing virtio-balloon driver.
>
> Known Issues:
>         * Fixed array size: The problem with having a fixed/hardcoded arr=
ay size arises when the size of the guest varies. For example when the gues=
t size increases and it starts making large allocations fixed size limits t=
his solution's ability to capture all the freed pages. This will result in =
less guest free memory getting reported to the host.
>
> Known code re-work:
>         * Plan to re-use Wei's work, which communicates the poison value =
to the host.
>         * The nomenclatures used in virtio-balloon needs to be changed so=
 that the code can easily be distinguished from Wei's Free Page Hint code.
>         * Sorting based on zonenum, to avoid repetitive zone locks for th=
e same zone.
>
> Other required work:
>         * Run other benchmarks to evaluate the performance/impact of this=
 approach.
>
> Test case:
> Setup:
> Memory-15837 MB
> Guest Memory Size-5 GB
> Swap-Disabled
> Test Program-Simple program which allocates 4GB memory via malloc, touche=
s it via memset and exits.
> Use case-Number of guests that can be launched completely including the s=
uccessful execution of the test program.
> Procedure:
> The first guest is launched and once its console is up, the test allocati=
on program is executed with 4 GB memory request (Due to this the guest occu=
pies almost 4-5 GB of memory in the host in a system without page hinting).=
 Once this program exits at that time another guest is launched in the host=
 and the same process is followed. We continue launching the guests until a=
 guest gets killed due to low memory condition in the host.
>
> Result:
> Without Hinting-3 Guests
> With Hinting-5 to 7 Guests(Based on the amount of memory freed/captured).
>
> [1] https://www.spinics.net/lists/kvm/msg170113.html

So I tried reproducing your test and I am not having much luck.
According to the sysctl in the guest  I am seeing
"vm.guest-page-hinting =3D 1" which is supposed to indicate that the
hinting is enabled in both QEMU and the guest right? I'm just wanting
to verify that this is the case before I start doing any debugging.

I'm assuming you never really ran any multi-threaded tests on a
multi-CPU guest did you? With the patches applied I am seeing
stability issues. If I enable a VM with multiple CPUs and run
something like the page_fault1 test from the will-it-scale suite I am
seeing multiple traces being generated by the guest kernel and it
ultimately just hangs.

I have included the traces below. There end up being 3 specific
issues, a double free that is detected, the RCU stall, and then starts
complaining about a soft lockup.

Thanks.

- Alex

-- This looks like a page complaining about a double add when added to
the LRU --
[   50.479635] list_add double add: new=3Dfffff64480000008,
prev=3Dffffa000fffd50c0, next=3Dfffff64480000008.
[   50.481066] ------------[ cut here ]------------
[   50.481753] kernel BUG at lib/list_debug.c:31!
[   50.482448] invalid opcode: 0000 [#1] SMP PTI
[   50.483108] CPU: 1 PID: 852 Comm: hinting/1 Not tainted
5.0.0-rc7-next-20190219-baseline+ #50
[   50.486362] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[   50.487881] RIP: 0010:__list_add_valid+0x4b/0x70
[   50.488623] Code: 00 00 c3 48 89 c1 48 c7 c7 d8 70 10 9e 31 c0 e8
4f db c8 ff 0f 0b 48 89 c1 48 89 fe 31 c0 48 c7 c7 88 71 10 9e e8 39
db c8 ff <0f> 0b 48 89 d1 48 c7 c7 30 71 10 9e 48 89 f2 48 89 c6 31 c0
e8 20
[   50.492626] RSP: 0018:ffffb9a8c3b4bdf0 EFLAGS: 00010246
[   50.494189] RAX: 0000000000000058 RBX: ffffa000fffd50c0 RCX: 00000000000=
00000
[   50.496308] RDX: 0000000000000000 RSI: ffffa000df85e6c8 RDI: ffffa000df8=
5e6c8
[   50.497876] RBP: ffffa000fffd50c0 R08: 0000000000000273 R09: 00000000000=
00005
[   50.498981] R10: 0000000000000000 R11: ffffb9a8c3b4bb70 R12: fffff644800=
00008
[   50.500077] R13: fffff64480000008 R14: fffff64480000000 R15: ffffa000fff=
d5000
[   50.501184] FS:  0000000000000000(0000) GS:ffffa000df840000(0000)
knlGS:0000000000000000
[   50.502432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.503325] CR2: 00007ffff6e47000 CR3: 000000080f76c002 CR4: 00000000001=
60ee0
[   50.504431] Call Trace:
[   50.505464]  free_one_page+0x2b5/0x470
[   50.506070]  hyperlist_ready+0xa9/0xc0
[   50.506662]  hinting_fn+0x1db/0x3c0
[   50.507220]  smpboot_thread_fn+0x10e/0x160
[   50.507868]  kthread+0xf8/0x130
[   50.508371]  ? sort_range+0x20/0x20
[   50.508934]  ? kthread_bind+0x10/0x10
[   50.509520]  ret_from_fork+0x35/0x40
[   50.510098] Modules linked in: ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat
ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ebtable_filter ebtables ip6table_filter ip6_tables
sunrpc sb_edac crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
kvm_intel kvm ppdev irqbypass parport_pc joydev virtio_balloon
pcc_cpufreq i2c_piix4 pcspkr parport xfs libcrc32c cirrus
drm_kms_helper ttm drm e1000 crc32c_intel virtio_blk ata_generic
floppy serio_raw pata_acpi qemu_fw_cfg
[   50.519202] ---[ end trace 141fe2acdf2e3818 ]---
[   50.519935] RIP: 0010:__list_add_valid+0x4b/0x70
[   50.520675] Code: 00 00 c3 48 89 c1 48 c7 c7 d8 70 10 9e 31 c0 e8
4f db c8 ff 0f 0b 48 89 c1 48 89 fe 31 c0 48 c7 c7 88 71 10 9e e8 39
db c8 ff <0f> 0b 48 89 d1 48 c7 c7 30 71 10 9e 48 89 f2 48 89 c6 31 c0
e8 20
[   50.523570] RSP: 0018:ffffb9a8c3b4bdf0 EFLAGS: 00010246
[   50.524399] RAX: 0000000000000058 RBX: ffffa000fffd50c0 RCX: 00000000000=
00000
[   50.525516] RDX: 0000000000000000 RSI: ffffa000df85e6c8 RDI: ffffa000df8=
5e6c8
[   50.526634] RBP: ffffa000fffd50c0 R08: 0000000000000273 R09: 00000000000=
00005
[   50.527754] R10: 0000000000000000 R11: ffffb9a8c3b4bb70 R12: fffff644800=
00008
[   50.528872] R13: fffff64480000008 R14: fffff64480000000 R15: ffffa000fff=
d5000
[   50.530004] FS:  0000000000000000(0000) GS:ffffa000df840000(0000)
knlGS:0000000000000000
[   50.531276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.532189] CR2: 00007ffff6e47000 CR3: 000000080f76c002 CR4: 00000000001=
60ee0

-- This appears to be a deadlock on the zone lock --
[  156.436784] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  156.439195] rcu: 0-...0: (0 ticks this GP)
idle=3D6ca/1/0x4000000000000000 softirq=3D10718/10718 fqs=3D2546
[  156.440810] rcu: 1-...0: (1 GPs behind)
idle=3D8f2/1/0x4000000000000000 softirq=3D8233/8235 fqs=3D2547
[  156.442320] rcu: 2-...0: (0 ticks this GP)
idle=3Dae2/1/0x4000000000000002 softirq=3D6779/6779 fqs=3D2547
[  156.443910] rcu: 3-...0: (0 ticks this GP)
idle=3D456/1/0x4000000000000000 softirq=3D1616/1616 fqs=3D2547
[  156.445454] rcu: (detected by 14, t=3D60109 jiffies, g=3D17493, q=3D31)
[  156.446545] Sending NMI from CPU 14 to CPUs 0:
[  156.448330] NMI backtrace for cpu 0
[  156.448331] CPU: 0 PID: 1308 Comm: page_fault1_pro Tainted: G
D           5.0.0-rc7-next-20190219-baseline+ #50
[  156.448331] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  156.448332] RIP: 0010:queued_spin_lock_slowpath+0x21/0x1f0
[  156.448332] Code: c0 75 ec c3 90 90 90 90 90 0f 1f 44 00 00 0f 1f
44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3
c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 44 01 00 00 81 e6 00 ff ff ff
75 3e
[  156.448333] RSP: 0000:ffffb9a8c3e83c10 EFLAGS: 00000002
[  156.448339] RAX: 0000000000000001 RBX: 0000000000000007 RCX: 00000000000=
00001
[  156.448340] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffa000fff=
d6240
[  156.448340] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000006=
f36aa
[  156.448341] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00081
[  156.448341] R13: 0000000000100dca R14: 0000000000000000 R15: ffffa000fff=
d5d00
[  156.448342] FS:  00007ffff7fec440(0000) GS:ffffa000df800000(0000)
knlGS:0000000000000000
[  156.448342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.448342] CR2: 00007fffefe2d000 CR3: 0000000695904004 CR4: 00000000001=
60ef0
[  156.448343] Call Trace:
[  156.448343]  get_page_from_freelist+0x50f/0x1280
[  156.448343]  ? get_page_from_freelist+0xa44/0x1280
[  156.448344]  __alloc_pages_nodemask+0x141/0x2e0
[  156.448344]  alloc_pages_vma+0x73/0x180
[  156.448344]  __handle_mm_fault+0xd59/0x14e0
[  156.448345]  handle_mm_fault+0xfa/0x210
[  156.448345]  __do_page_fault+0x207/0x4c0
[  156.448345]  do_page_fault+0x32/0x140
[  156.448346]  ? async_page_fault+0x8/0x30
[  156.448346]  async_page_fault+0x1e/0x30
[  156.448346] RIP: 0033:0x401840
[  156.448347] Code: 00 00 45 31 c9 31 ff 41 b8 ff ff ff ff b9 22 00
00 00 ba 03 00 00 00 be 00 00 00 08 e8 d9 f5 ff ff 48 83 f8 ff 74 2b
48 89 c2 <c6> 02 00 48 01 ea 48 83 03 01 48 89 d1 48 29 c1 48 81 f9 ff
ff ff
[  156.448347] RSP: 002b:00007fffffffc0a0 EFLAGS: 00010293
[  156.448348] RAX: 00007fffeee48000 RBX: 00007ffff7ff7000 RCX: 0000000000f=
e5000
[  156.448348] RDX: 00007fffefe2d000 RSI: 0000000008000000 RDI: 00000000000=
00000
[  156.448349] RBP: 0000000000001000 R08: ffffffffffffffff R09: 00000000000=
00000
[  156.448349] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffffff=
fc240
[  156.448349] R13: 0000000000000000 R14: 0000000000610710 R15: 00000000000=
00005
[  156.448355] Sending NMI from CPU 14 to CPUs 1:
[  156.489676] NMI backtrace for cpu 1
[  156.489677] CPU: 1 PID: 1309 Comm: page_fault1_pro Tainted: G
D           5.0.0-rc7-next-20190219-baseline+ #50
[  156.489677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  156.489678] RIP: 0010:queued_spin_lock_slowpath+0x21/0x1f0
[  156.489678] Code: c0 75 ec c3 90 90 90 90 90 0f 1f 44 00 00 0f 1f
44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3
c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 44 01 00 00 81 e6 00 ff ff ff
75 3e
[  156.489679] RSP: 0000:ffffb9a8c3b4bc10 EFLAGS: 00000002
[  156.489679] RAX: 0000000000000001 RBX: 0000000000000007 RCX: 00000000000=
00001
[  156.489680] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffa000fff=
d6240
[  156.489680] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000006=
f36aa
[  156.489680] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00081
[  156.489681] R13: 0000000000100dca R14: 0000000000000000 R15: ffffa000fff=
d5d00
[  156.489681] FS:  00007ffff7fec440(0000) GS:ffffa000df840000(0000)
knlGS:0000000000000000
[  156.489682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.489682] CR2: 00007ffff4608000 CR3: 000000081ddf6003 CR4: 00000000001=
60ee0
[  156.489682] Call Trace:
[  156.489683]  get_page_from_freelist+0x50f/0x1280
[  156.489683]  ? get_page_from_freelist+0xa44/0x1280
[  156.489683]  __alloc_pages_nodemask+0x141/0x2e0
[  156.489683]  alloc_pages_vma+0x73/0x180
[  156.489684]  __handle_mm_fault+0xd59/0x14e0
[  156.489684]  handle_mm_fault+0xfa/0x210
[  156.489684]  __do_page_fault+0x207/0x4c0
[  156.489685]  do_page_fault+0x32/0x140
[  156.489685]  ? async_page_fault+0x8/0x30
[  156.489685]  async_page_fault+0x1e/0x30
[  156.489686] RIP: 0033:0x401840
[  156.489686] Code: 00 00 45 31 c9 31 ff 41 b8 ff ff ff ff b9 22 00
00 00 ba 03 00 00 00 be 00 00 00 08 e8 d9 f5 ff ff 48 83 f8 ff 74 2b
48 89 c2 <c6> 02 00 48 01 ea 48 83 03 01 48 89 d1 48 29 c1 48 81 f9 ff
ff ff
[  156.489687] RSP: 002b:00007fffffffc0a0 EFLAGS: 00010293
[  156.489687] RAX: 00007fffeee48000 RBX: 00007ffff7ff7080 RCX: 00000000057=
c0000
[  156.489692] RDX: 00007ffff4608000 RSI: 0000000008000000 RDI: 00000000000=
00000
[  156.489693] RBP: 0000000000001000 R08: ffffffffffffffff R09: 00000000000=
00000
[  156.489693] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffffff=
fc240
[  156.489694] R13: 0000000000000000 R14: 000000000060f870 R15: 00000000000=
00005
[  156.489696] Sending NMI from CPU 14 to CPUs 2:
[  156.530601] NMI backtrace for cpu 2
[  156.530602] CPU: 2 PID: 858 Comm: hinting/2 Tainted: G      D
    5.0.0-rc7-next-20190219-baseline+ #50
[  156.530602] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  156.530603] RIP: 0010:queued_spin_lock_slowpath+0x21/0x1f0
[  156.530603] Code: c0 75 ec c3 90 90 90 90 90 0f 1f 44 00 00 0f 1f
44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3
c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 44 01 00 00 81 e6 00 ff ff ff
75 3e
[  156.530604] RSP: 0018:ffffa000df883e38 EFLAGS: 00000002
[  156.530604] RAX: 0000000000000001 RBX: fffff644a05a0ec8 RCX: dead0000000=
00200
[  156.530605] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffa000fff=
d6240
[  156.530605] RBP: ffffa000df8af340 R08: ffffa000da2b2000 R09: 00000000000=
00100
[  156.530606] R10: 0000000000000004 R11: 0000000000000005 R12: fffff6449fb=
5fb08
[  156.530606] R13: ffffa000fffd5d00 R14: 0000000000000001 R15: 00000000000=
00001
[  156.530606] FS:  0000000000000000(0000) GS:ffffa000df880000(0000)
knlGS:0000000000000000
[  156.530607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.530607] CR2: 00007ffff6e47000 CR3: 0000000813b34003 CR4: 00000000001=
60ee0
[  156.530607] Call Trace:
[  156.530608]  <IRQ>
[  156.530608]  free_pcppages_bulk+0x1af/0x6d0
[  156.530608]  free_unref_page+0x54/0x70
[  156.530608]  tlb_remove_table_rcu+0x23/0x40
[  156.530609]  rcu_core+0x2b0/0x470
[  156.530609]  __do_softirq+0xde/0x2bf
[  156.530609]  irq_exit+0xd5/0xe0
[  156.530610]  smp_apic_timer_interrupt+0x74/0x140
[  156.530610]  apic_timer_interrupt+0xf/0x20
[  156.530610]  </IRQ>
[  156.530611] RIP: 0010:_raw_spin_lock+0x10/0x20
[  156.530611] Code: b8 01 00 00 00 c3 48 8b 3c 24 be 00 02 00 00 e8
f6 cf 77 ff 31 c0 c3 0f 1f 00 0f 1f 44 00 00 31 c0 ba 01 00 00 00 f0
0f b1 17 <0f> 94 c2 84 d2 74 02 f3 c3 89 c6 e9 d0 e8 7c ff 0f 1f 44 00
00 65
[  156.530612] RSP: 0018:ffffb9a8c3bf3df0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  156.530612] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00000
[  156.530613] RDX: 0000000000000001 RSI: fffff6449fd4aec0 RDI: ffffa000fff=
d6240
[  156.530613] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000=
00002
[  156.530613] R10: 0000000000000000 R11: 0000000000003bf3 R12: 00000000007=
f52bb
[  156.530614] R13: 00000000007ecca4 R14: fffff6449fd4aec0 R15: ffffa000fff=
d5d00
[  156.530614]  free_one_page+0x32/0x470
[  156.530614]  ? __switch_to_asm+0x40/0x70
[  156.530615]  hyperlist_ready+0xa9/0xc0
[  156.530615]  hinting_fn+0x1db/0x3c0
[  156.530615]  smpboot_thread_fn+0x10e/0x160
[  156.530616]  kthread+0xf8/0x130
[  156.530616]  ? sort_range+0x20/0x20
[  156.530616]  ? kthread_bind+0x10/0x10
[  156.530616]  ret_from_fork+0x35/0x40
[  156.530619] Sending NMI from CPU 14 to CPUs 3:
[  156.577112] NMI backtrace for cpu 3
[  156.577113] CPU: 3 PID: 1311 Comm: page_fault1_pro Tainted: G
D           5.0.0-rc7-next-20190219-baseline+ #50
[  156.577113] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  156.577114] RIP: 0010:queued_spin_lock_slowpath+0x21/0x1f0
[  156.577114] Code: c0 75 ec c3 90 90 90 90 90 0f 1f 44 00 00 0f 1f
44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3
c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 44 01 00 00 81 e6 00 ff ff ff
75 3e
[  156.577115] RSP: 0000:ffffb9a8c407fc10 EFLAGS: 00000002
[  156.577115] RAX: 0000000000000001 RBX: 0000000000000007 RCX: 00000000000=
00001
[  156.577116] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffa000fff=
d6240
[  156.577116] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000006=
f36aa
[  156.577121] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00081
[  156.577122] R13: 0000000000100dca R14: 0000000000000000 R15: ffffa000fff=
d5d00
[  156.577122] FS:  00007ffff7fec440(0000) GS:ffffa000df8c0000(0000)
knlGS:0000000000000000
[  156.577122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.577123] CR2: 00007ffff398a000 CR3: 000000081aa00003 CR4: 00000000001=
60ee0
[  156.577123] Call Trace:
[  156.577123]  get_page_from_freelist+0x50f/0x1280
[  156.577124]  ? get_page_from_freelist+0xa44/0x1280
[  156.577124]  ? try_charge+0x637/0x860
[  156.577124]  __alloc_pages_nodemask+0x141/0x2e0
[  156.577125]  alloc_pages_vma+0x73/0x180
[  156.577125]  __handle_mm_fault+0xd59/0x14e0
[  156.577125]  handle_mm_fault+0xfa/0x210
[  156.577126]  __do_page_fault+0x207/0x4c0
[  156.577126]  do_page_fault+0x32/0x140
[  156.577126]  ? async_page_fault+0x8/0x30
[  156.577127]  async_page_fault+0x1e/0x30
[  156.577127] RIP: 0033:0x401840
[  156.577128] Code: 00 00 45 31 c9 31 ff 41 b8 ff ff ff ff b9 22 00
00 00 ba 03 00 00 00 be 00 00 00 08 e8 d9 f5 ff ff 48 83 f8 ff 74 2b
48 89 c2 <c6> 02 00 48 01 ea 48 83 03 01 48 89 d1 48 29 c1 48 81 f9 ff
ff ff
[  156.577128] RSP: 002b:00007fffffffc0a0 EFLAGS: 00010293
[  156.577129] RAX: 00007fffeee48000 RBX: 00007ffff7ff7180 RCX: 0000000004b=
42000
[  156.577129] RDX: 00007ffff398a000 RSI: 0000000008000000 RDI: 00000000000=
00000
[  156.577130] RBP: 0000000000001000 R08: ffffffffffffffff R09: 00000000000=
00000
[  156.577130] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffffff=
fc240
[  156.577130] R13: 0000000000000000 R14: 000000000060db00 R15: 00000000000=
00005

-- After the above two it starts spitting this one out every 10 - 30
seconds or so --
[  183.788386] watchdog: BUG: soft lockup - CPU#14 stuck for 23s!
[kworker/14:1:121]
[  183.790003] Modules linked in: ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat
ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ebtable_filter ebtables ip6table_filter ip6_tables
sunrpc sb_edac crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
kvm_intel kvm ppdev irqbypass parport_pc joydev virtio_balloon
pcc_cpufreq i2c_piix4 pcspkr parport xfs libcrc32c cirrus
drm_kms_helper ttm drm e1000 crc32c_intel virtio_blk ata_generic
floppy serio_raw pata_acpi qemu_fw_cfg
[  183.799984] CPU: 14 PID: 121 Comm: kworker/14:1 Tainted: G      D
        5.0.0-rc7-next-20190219-baseline+ #50
[  183.801674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  183.803078] Workqueue: events netstamp_clear
[  183.803873] RIP: 0010:smp_call_function_many+0x206/0x260
[  183.804847] Code: e8 0f 97 7c 00 3b 05 bd d1 1e 01 0f 83 7c fe ff
ff 48 63 d0 48 8b 4d 00 48 03 0c d5 80 28 18 9e 8b 51 18 83 e2 01 74
0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c7 0f b6 4c 24 0c 48 83 c4 10 89
ef 5b
[  183.808273] RSP: 0018:ffffb9a8c35a3d38 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  183.809662] RAX: 0000000000000000 RBX: ffffa000dfba9d88 RCX: ffffa000df8=
301c0
[  183.810971] RDX: 0000000000000001 RSI: 0000000000000100 RDI: ffffa000dfb=
a9d88
[  183.812268] RBP: ffffa000dfba9d80 R08: 0000000000000000 R09: 00000000000=
03fff
[  183.813582] R10: 0000000000000000 R11: 000000000000000f R12: ffffffff9d0=
2f690
[  183.814884] R13: 0000000000000000 R14: ffffa000dfba9da8 R15: 00000000000=
00100
[  183.816195] FS:  0000000000000000(0000) GS:ffffa000dfb80000(0000)
knlGS:0000000000000000
[  183.817673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  183.818729] CR2: 00007ffff704b080 CR3: 0000000814c48001 CR4: 00000000001=
60ee0
[  183.820038] Call Trace:
[  183.820510]  ? netif_receive_skb_list+0x68/0x4a0
[  183.821367]  ? poke_int3_handler+0x40/0x40
[  183.822126]  ? netif_receive_skb_list+0x69/0x4a0
[  183.822975]  on_each_cpu+0x28/0x60
[  183.823611]  ? netif_receive_skb_list+0x68/0x4a0
[  183.824467]  text_poke_bp+0x68/0xe0
[  183.825126]  ? netif_receive_skb_list+0x68/0x4a0
[  183.825983]  __jump_label_transform+0x101/0x140
[  183.826829]  arch_jump_label_transform+0x26/0x40
[  183.827687]  __jump_label_update+0x56/0xc0
[  183.828456]  static_key_enable_cpuslocked+0x57/0x80
[  183.829358]  static_key_enable+0x16/0x20
[  183.830085]  process_one_work+0x16c/0x380
[  183.830831]  worker_thread+0x49/0x3e0
[  183.831516]  kthread+0xf8/0x130
[  183.832106]  ? rescuer_thread+0x340/0x340
[  183.832848]  ? kthread_bind+0x10/0x10
[  183.833532]  ret_from_fork+0x35/0x40
