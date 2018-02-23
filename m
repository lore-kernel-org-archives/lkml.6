Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3104079-1519395581-2-1058786441162011545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519395580; b=obwKcEYYQQR+jO4N6fYIz/0b1+LMPgytpo6TF31UkxMcG0G
    ut2ep9dlwp8D/aHl19qNkR91+6+GUTQPq1dlDGF4DQwlNkyc/lanJXmyu40k+sf5
    psF9r1tcaCf+sXM5EsZ3dp+FJnPC54yM0kL+gagkz1/YPdS66V5L+nw43umG0+qL
    U176aMz40xdxyblEEwsAkRWFOcWZ8+VRi7CFL5g+emY2hfoiZ2cr1XlHhqP9Dsre
    Mn2jk8xiRyF4/Hnh9Z32ujVdBz5cHT0ONLOX9I7egbDP/vU4jbiPNQcIb3SWEZYh
    9HT/Kjw/iowa2VVbh9luryLxC4lXHNHybvS4r0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519395580; bh=XL5flrd6pAU2ceMwgYbquy6M2bDd686MCejZPh
    q5ADo=; b=gjlnOljv/XXpH6G1FBpVRiNVzylepbVWM3OTM08gqebP8POFV1xAXB
    KGceZIx7X8+w8Eq/B1Av4MFxvQssni1vFrIz9VWM2IqaCx+ouorxFuFEPUQlCzwK
    eqN7EtEQu7wsajJGIzma8PNyBrfhFe0w577LTp0vm3qBkP+DrYEieG7YyZdEKBjL
    E3978evwaigPCaJpmilLPRuDKH3fiO0TPpby52sV4/FssZ5RQQE2d1C2BnTJ5YhS
    /MY+aRqWGra8wExPbhjtgeawG+vRyxwtmIB75kbnENkgcpKv0eqKSj1+cezz/pkL
    TcWOPf8AgicDJyt/OasJ4avxJNQIt3dw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OYRWx5si x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XMJcXwY9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OYRWx5si x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XMJcXwY9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBWOTh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 09:19:37 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34693 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWOTg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 09:19:36 -0500
X-Google-Smtp-Source: AG47ELu7bLkRtnLulN6BVwBt1qO85iiHrENW5ZPHErESQjRhPT71V/KRNY/U8GRBmsv7oXpgpF3vE3Q2NIrMX2ectOo=
MIME-Version: 1.0
In-Reply-To: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Fri, 23 Feb 2018 15:19:14 +0100
Message-ID: <CAP71WjzZqcxr-zHFfFUP0jAPfmJm7NM1MpS6tfPkMmj45U7MVg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for v4.14-stable
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        marc.zyngier@arm.com, Mark Brown <broonie@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hi,

On Mon, Feb 12, 2018 at 12:38 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Hi Greg,
>
> As mentioned by Will, I have created the v4.14 counterpart of his stable
> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
> into v4.16-rc1.
>
> Given that this is the v4.15 version backported to v4.14, I have removed any
> mention of 'conflicts' from the commit logs as they are now ambiguous. The
> patches applied surprisingly cleanly, I only needed to drop two patches that
> are already in (the same ones Will mentioned in his PR), and drop another one
> dealing with SPE, support for which did not exist yet in v4.14. I also included
> the patch
>
>   arm64: move TASK_* definitions to <asm/processor.h>
>
> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.
>
> Thanks,
> Ard.
>
> Will Deacon (40):
>       [Variant 3/Meltdown] arm64: mm: Use non-global mappings for kernel space
>       [Variant 3/Meltdown] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
>       [Variant 3/Meltdown] arm64: mm: Move ASID from TTBR0 to TTBR1
>       [Variant 3/Meltdown] arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003
>       [Variant 3/Meltdown] arm64: mm: Rename post_ttbr0_update_workaround
>       [Variant 3/Meltdown] arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
>       [Variant 3/Meltdown] arm64: mm: Allocate ASIDs in pairs
>       [Variant 3/Meltdown] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
>       [Variant 3/Meltdown] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
>       [Variant 3/Meltdown] arm64: entry: Add exception trampoline page for exceptions from EL0
>       [Variant 3/Meltdown] arm64: mm: Map entry trampoline into trampoline and kernel page tables
>       [Variant 3/Meltdown] arm64: entry: Explicitly pass exception level to kernel_ventry macro
>       [Variant 3/Meltdown] arm64: entry: Hook up entry trampoline to exception vectors
>       [Variant 3/Meltdown] arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
>       [Variant 3/Meltdown] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
>       [Variant 3/Meltdown] arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
>       [Variant 3/Meltdown] arm64: kaslr: Put kernel vectors address in separate data page
>       [Variant 3/Meltdown] arm64: use RET instruction for exiting the trampoline
>       [Variant 3/Meltdown] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
>       [Variant 3/Meltdown] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
>       [Variant 3/Meltdown] arm64: Take into account ID_AA64PFR0_EL1.CSV3
>       [Variant 3/Meltdown] arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR
>       [Variant 3/Meltdown] arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()

we are seeing a regression on Qualcomm Dragonbooard 410c at this
commit ^. we are seeing the same regression on 4.15.x, where the same
commit exists too. However there is no regression on mainline.

Starting from this commit , this is the bootlog (with earlyprintk)

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
[    0.000000] Linux version 4.15.3 (nicolas.dechesne@qcom-hackbox)
(gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)) #27
SMP PREEMPT Tue Feb 20 15:54:58 CET 2018
[    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
[    0.000000] earlycon: msm_serial_dm0 at MMIO 0x00000000078b0000
(options '115200n8')
[    0.000000] bootconsole [msm_serial_dm0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 16 MiB at 0x00000000bec00000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000000000000-0x00000000bfffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xbfeb1c00-0xbfeb36ff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x0000000085ffffff]
[    0.000000]   node   0: [mem 0x0000000089f00000-0x000000008e9fffff]
[    0.000000]   node   0: [mem 0x000000008eb00000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 23 pages/cpu @        (ptrval) s55064
r8192 d30952 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM errata
826319, 827319, 824069
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 241920
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=ttyMSM0,115200n8
root=/dev/disk/by-partlabel/rootfs rootwait rw
earlycon=msm_serial_dm,0x78b0000,115200n8
systemd.unit=multi-user.target androidboot.emmc=true
androidboot.serialno=1c580271 androidboot.baseband=apq
mdss_mdp.panel=0:dsi:0:
[    0.000000] Memory: 929108K/983040K available (9532K kernel code,
1160K rwdata, 4444K rodata, 1088K init, 396K bss, 37548K reserved,
16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000
(   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000
(129022 GB)
[    0.000000]       .text : 0x        (ptrval) - 0x        (ptrval)
(  9536 KB)
[    0.000000]     .rodata : 0x        (ptrval) - 0x        (ptrval)
(  4480 KB)
[    0.000000]       .init : 0x        (ptrval) - 0x        (ptrval)
(  1088 KB)
[    0.000000]       .data : 0x        (ptrval) - 0x        (ptrval)
(  1161 KB)
[    0.000000]        .bss : 0x        (ptrval) - 0x        (ptrval)
(   397 KB)
[    0.000000]     fixed   : 0xffff7dfffe7f9000 - 0xffff7dfffec00000
(  4124 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000
(    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000
(  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0001000000
(    16 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800040000000
(  1024 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] arch_timer: cp15 and mmio timer(s) running at 19.20MHz
(virt/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000004] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
every 4398046511078ns
[    0.011359] Console: colour dummy device 80x25
[    0.018805] Calibrating delay loop (skipped), value calculated
using timer frequency.. 38.40 BogoMIPS (lpj=76800)
[    0.023277] pid_max: default: 32768 minimum: 301
[    0.033670] Security Framework initialized
[    0.038818] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.042469] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.049423] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.056177] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.079104] ASID allocator initialised with 32768 entries
[    0.087102] Hierarchical SRCU implementation.
[    0.097379] EFI services will not be available.
[    0.103147] smp: Bringing up secondary CPUs ...
[    0.131430] Detected VIPT I-cache on CPU1
[    0.131479] CPU1: Booted secondary processor 0x0000000001 [0x410fd030]
[    0.159478] Detected VIPT I-cache on CPU2
[    0.159518] CPU2: Booted secondary processor 0x0000000002 [0x410fd030]
[    0.187535] Detected VIPT I-cache on CPU3
[    0.187571] CPU3: Booted secondary processor 0x0000000003 [0x410fd030]
[    0.187650] smp: Brought up 1 node, 4 CPUs
[    0.218074] SMP: Total of 4 processors activated.
[    0.222145] CPU features: detected feature: 32-bit EL0 Support
[    0.226921] CPU features: detected feature: Kernel page table
isolation (KPTI)
[    0.234739] CPU: All CPU(s) started at EL1
[    0.239866] alternatives: patching kernel code
[    0.244070] ------------[ cut here ]------------
[    0.248350] kernel BUG at ../arch/arm64/mm/mmu.c:138!
[    0.253128] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    0.258073] Modules linked in:
[    0.263455] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.3 #27
[    0.266495] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    0.272662] pstate: 00000005 (nzcv daif -PAN -UAO)
[    0.279347] pc : __create_pgd_mapping+0x544/0x660
[    0.283943] lr : __create_pgd_mapping+0x4d0/0x660
[    0.288714] sp : ffff000008033cb0
[    0.293400] x29: ffff000008033cb0 x28: ffff800000e2ffff
[    0.296701] x27: ffff800000080000 x26: ffff800000200000
[    0.302083] x25: 0000000080080000 x24: ffff800000e30000
[    0.307379] x23: ffff7dfffe638000 x22: 00000000bfef6003
[    0.312673] x21: ffff800000080000 x20: 00e0000000000f93
[    0.317969] x19: ffff800000e30000 x18: 0000000000000010
[    0.323264] x17: 000000001f8013fb x16: 000000000522cdac
[    0.328558] x15: 0000000000000000 x14: 0000000000000400
[    0.333854] x13: 0000800080000000 x12: 0000000080080000
[    0.339150] x11: 00e8000000000f13 x10: ffff8000001fffff
[    0.344445] x9 : ffff800000080000 x8 : 00e0000000000f93
[    0.349739] x7 : ffff800000090000 x6 : 0040000000000041
[    0.355034] x5 : 0040000000000001 x4 : 00e8000080080f93
[    0.360329] x3 : ffff800000080000 x2 : ffff7dfffe639400
[    0.365624] x1 : ffd7ffffffffff7f x0 : 0008000000000880
[    0.370922] Process swapper/0 (pid: 1, stack limit = 0x0000000095a442e7)
[    0.376216] Call trace:
[    0.382899]  __create_pgd_mapping+0x544/0x660
[    0.385070]  update_mapping_prot+0x48/0xd8
[    0.389585]  mark_linear_text_alias_ro+0x68/0x8c
[    0.393579]  smp_cpus_done+0x60/0x9c
[    0.398351]  smp_init+0xfc/0x114
[    0.401909]  kernel_init_freeable+0xcc/0x224
[    0.405123]  kernel_init+0x10/0x100
[    0.409374]  ret_from_fork+0x10/0x18
[    0.412588] Code: 92801001 f2fffae1 ea01001f 54000040 (d4210000)
[    0.416420] ---[ end trace e7ed67ae05b55982 ]---
[    0.422430] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    0.422430]
[    0.427091] SMP: stopping secondary CPUs
[    0.436203] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    0.436203]

I understand this is not a lot of data. but I am a bit clueless here.
One thing worth saying is that we are using custom/proprietary
firmware here, and CPUs are started in EL1. The DB410c is based on
APQ8016 SoC from Qualcomm (4x Cortex A53).
