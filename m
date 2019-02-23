Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B553320700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jD3SZf4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfBWBLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:11:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57900 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWBLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Date:
        Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AYRoMy8WaS79il9dJOu9+tAuZV4ynfmZ15wfYW6TmHs=; b=jD3SZf4TUjlunT7qZJWWT/WXU
        HdZaXibBcR6UuWYsH9glxh2hF5ekvkNIQZ747pWRUIYczc9McshoC9aktmEhrL0B9pprYf+BENJy3
        PPfcf7gDvJ4+imQaDgl6cNYnlFVbPk+kx9Eh8Q+z7BdI4n3cFOGMzh453RKN84qp2dAztQD8sBeFz
        ZfOwm8FNpjsBk5nUlVO13Rvvo+LFgASs2z7fQAibpSAWNq870+E/giPQLkCFadqqS2NF/Rq4jEwsV
        2zKkD9pdIIiyGUFyoBM0bajSdwiJDuer7TV3VcX1atn/U98OCrOvpbwJNXcKDGbjKhj7feHmFBb48
        D0JiQ+4Pw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxLqT-0001H2-25; Sat, 23 Feb 2019 01:11:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: BUG: KASAN: use-after-free in intel_hdmi_destroy+0x79/0x80
To:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Message-ID: <dc22722f-a55c-6160-6485-a02f3bb91836@infradead.org>
Date:   Fri, 22 Feb 2019 17:11:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AC70EEF5625217B09E672E0D"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AC70EEF5625217B09E672E0D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


This is 5.0-rc7 on an old Toshiba Portege laptop.
No hdmi or other external video.

Linux dragon.dunlab 5.0.0-rc7mod #3 SMP PREEMPT Wed Feb 20 00:05:17 PST 2019 x86_64 x86_64 x86_64 GNU/Linux

on openSUSE LEAP 15.0 distro.

Full boot log is attached.

-- 
~Randy


--------------AC70EEF5625217B09E672E0D
Content-Type: text/x-log;
 name="500rc7001.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="500rc7001.log"

[    0.000000] Linux version 5.0.0-rc7mod (rdunlap@dragon.dunlab) (gcc version 7.3.1 20180323 [gcc-7-branch revision 258812] (SUSE Linux)) #3 SMP PREEMPT Wed Feb 20 00:05:17 PST 2019
[    0.000000] Command line: BOOT_IMAGE=/boot/bzImage-500rc7-allmod root=/dev/sda8 resume=/dev/sda7 splash=native quiet showopts selinux=0 audit=0 apparmor=0 debug initcall_debug ignore_loglevel logo.nologo fbcon~font:VGA8x8 v1de0=vesafb earlyprintk=vga,keep
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000aa5cffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000aa5d0000-0x00000000aa5d01ff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000aa5d0200-0x00000000aa5d2fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000aa5d3000-0x00000000aa6cffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000aa6d0000-0x00000000aa6effff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000aa6f0000-0x00000000af9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000014fdfffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2394.413 MHz processor
[    0.008298] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.008306] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.008325] last_pfn = 0x14fe00 max_arch_pfn = 0x400000000
[    0.008335] MTRR default type: uncachable
[    0.008340] MTRR fixed ranges enabled:
[    0.008345]   00000-9FFFF write-back
[    0.008350]   A0000-BFFFF uncachable
[    0.008355]   C0000-D3FFF write-protect
[    0.008360]   D4000-DFFFF uncachable
[    0.008365]   E0000-EFFFF write-through
[    0.008370]   F0000-FFFFF write-protect
[    0.008374] MTRR variable ranges enabled:
[    0.008380]   0 base 0FFC00000 mask FFFC00000 uncachable
[    0.008386]   1 base 000000000 mask F80000000 write-back
[    0.008391]   2 base 080000000 mask FC0000000 write-back
[    0.008396]   3 base 0B0000000 mask FF0000000 uncachable
[    0.008401]   4 base 0AC000000 mask FFC000000 uncachable
[    0.008406]   5 base 0AB800000 mask FFF800000 uncachable
[    0.008411]   6 base 100000000 mask F80000000 write-back
[    0.008416]   7 disabled
[    0.008420]   8 disabled
[    0.008424]   9 disabled
[    0.009802] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.012936] e820: update [mem 0xab800000-0xffffffff] usable ==> reserved
[    0.012949] last_pfn = 0xaa5d0 max_arch_pfn = 0x400000000
[    0.029243] check: Scanning 1 areas for low memory corruption
[    0.029252] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.029258] reserving inaccessible SNB gfx pages
[    0.029271] BRK [0xa2801000, 0xa2801fff] PGTABLE
[    0.029278] BRK [0xa2802000, 0xa2802fff] PGTABLE
[    0.029283] BRK [0xa2803000, 0xa2803fff] PGTABLE
[    0.029444] BRK [0xa2804000, 0xa2804fff] PGTABLE
[    0.029834] BRK [0xa2805000, 0xa2805fff] PGTABLE
[    0.031309] ACPI: Early table checksum verification disabled
[    0.031372] ACPI: RSDP 0x00000000000F0030 000014 (v00 TOSHIB)
[    0.031382] ACPI: RSDT 0x00000000AA6EF038 000050 (v01 TOSHIB A007D    00000004      01000013)
[    0.031395] ACPI: FACP 0x00000000AA6EE000 000081 (v02 TOSHIB A007D    00000004 LOHR 0000005F)
[    0.031410] ACPI: DSDT 0x00000000AA6DD000 008A46 (v02 TOSHIB A007D    20111220 INTL 20061109)
[    0.031420] ACPI: FACS 0x00000000AA6BE000 000040
[    0.031429] ACPI: HPET 0x00000000AA6ED000 000038 (v01 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.031439] ACPI: APIC 0x00000000AA6EC000 0000BC (v01 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.031448] ACPI: MCFG 0x00000000AA6EB000 00003C (v01 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.031458] ACPI: ASF! 0x00000000AA6EA000 0000A0 (v32 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.031467] ACPI: BOOT 0x00000000AA6E8000 000028 (v01 TOSHIB A007D    00000000 LOHR 0000005F)
[    0.031477] ACPI: SLIC 0x00000000AA6E7000 000176 (v01 TOSHIB A007D    00000000 LOHR 0000005F)
[    0.031486] ACPI: SSDT 0x00000000AA6DC000 000395 (v01 TOSHIB SataAhci 00001000 INTL 20061109)
[    0.031496] ACPI: SSDT 0x00000000AA6D9000 000720 (v01 TOSHIB PtidDevc 00001000 INTL 20061109)
[    0.031505] ACPI: SSDT 0x00000000AA6D7000 0007E5 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.031515] ACPI: SSDT 0x00000000AA6D6000 000996 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.031533] ACPI: Local APIC address 0xfee00000
[    0.031835] No NUMA configuration found
[    0.031840] Faking a node at [mem 0x0000000000000000-0x000000014fdfffff]
[    0.031870] NODE_DATA(0) allocated [mem 0x14fdd2000-0x14fdfcfff]
[    0.032346] Zone ranges:
[    0.032352]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.032358]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.032363]   Normal   [mem 0x0000000100000000-0x000000014fdfffff]
[    0.032369]   Device   empty
[    0.032374] Movable zone start for each node
[    0.032385] Early memory node ranges
[    0.032390]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.032394]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.032399]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.032404]   node   0: [mem 0x0000000040200000-0x00000000aa5cffff]
[    0.032408]   node   0: [mem 0x0000000100000000-0x000000014fdfffff]
[    0.033113] Zeroed struct page in unavailable ranges: 24211 pages
[    0.033116] Initmem setup node 0 [mem 0x0000000000001000-0x000000014fdfffff]
[    0.033125] On node 0 totalpages: 1023853
[    0.033131]   DMA zone: 64 pages used for memmap
[    0.033136]   DMA zone: 157 pages reserved
[    0.033141]   DMA zone: 3997 pages, LIFO batch:0
[    0.033510]   DMA32 zone: 10824 pages used for memmap
[    0.033516]   DMA32 zone: 692688 pages, LIFO batch:63
[    0.100277]   Normal zone: 5112 pages used for memmap
[    0.100287]   Normal zone: 327168 pages, LIFO batch:63
[    0.194686] kasan: KernelAddressSanitizer initialized
[    0.194709] Reserving Intel graphics memory at [mem 0xaba00000-0xaf9fffff]
[    0.194972] ACPI: PM-Timer IO Port: 0x408
[    0.194979] ACPI: Local APIC address 0xfee00000
[    0.194994] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.194999] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.195003] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.195008] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.195013] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.195017] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.195022] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.195027] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.195057] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.195065] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.195072] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.195078] ACPI: IRQ0 used by override.
[    0.195084] ACPI: IRQ9 used by override.
[    0.195092] Using ACPI (MADT) for SMP configuration information
[    0.195098] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.195110] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.195169] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.195176] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.195181] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.195186] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.195190] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.195197] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.195203] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.195210] PM: Registered nosave memory: [mem 0xaa5d0000-0xaa5d0fff]
[    0.195215] PM: Registered nosave memory: [mem 0xaa5d1000-0xaa5d2fff]
[    0.195219] PM: Registered nosave memory: [mem 0xaa5d3000-0xaa6cffff]
[    0.195224] PM: Registered nosave memory: [mem 0xaa6d0000-0xaa6effff]
[    0.195228] PM: Registered nosave memory: [mem 0xaa6f0000-0xaf9fffff]
[    0.195233] PM: Registered nosave memory: [mem 0xafa00000-0xf7ffffff]
[    0.195237] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.195242] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.195246] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.195251] PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
[    0.195255] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
[    0.195260] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
[    0.195264] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.195269] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.195273] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.195278] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
[    0.195282] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.195292] [mem 0xafa00000-0xf7ffffff] available for PCI devices
[    0.195297] Booting paravirtualized kernel on bare hardware
[    0.195306] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.195339] random: get_random_bytes called from start_kernel+0xdb/0x6bd with crng_init=0
[    0.195358] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.201518] percpu: Embedded 507 pages/cpu @(____ptrval____) s2036824 r8192 d31656 u2097152
[    0.201543] pcpu-alloc: s2036824 r8192 d31656 u2097152 alloc=1*2097152
[    0.201548] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.201638] Built 1 zonelists, mobility grouping on.  Total pages: 1007696
[    0.201644] Policy zone: Normal
[    0.201655] Kernel command line: BOOT_IMAGE=/boot/bzImage-500rc7-allmod root=/dev/sda8 resume=/dev/sda7 splash=native quiet showopts selinux=0 audit=0 apparmor=0 debug initcall_debug ignore_loglevel logo.nologo fbcon~font:VGA8x8 v1de0=vesafb earlyprintk=vga,keep
[    0.201816] audit: disabled (until reboot)
[    0.201976] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.201981] printk: log_buf_len total cpu_extra contributions: 229376 bytes
[    0.201986] printk: log_buf_len min size: 262144 bytes
[    0.202091] printk: log_buf_len: 524288 bytes
[    0.202096] printk: early log buf free: 249916(95%)
[    0.405597] Memory: 2761484K/4095412K available (36868K kernel code, 15424K rwdata, 7768K rodata, 4716K init, 22724K bss, 959388K reserved, 0K cma-reserved)
[    0.406712] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.406763] Kernel/User page tables isolation: enabled
[    0.408423] rcu: Preemptible hierarchical RCU implementation.
[    0.408429] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.408434] 	Tasks RCU enabled.
[    0.408439] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.408444] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.408515] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
[    0.409463] Console: colour dummy device 80x25
[    0.412879] printk: console [tty0] enabled
[    0.412899] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.412926] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.412942] ... MAX_LOCK_DEPTH:          48
[    0.412958] ... MAX_LOCKDEP_KEYS:        8191
[    0.412974] ... CLASSHASH_SIZE:          4096
[    0.412990] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.413007] ... MAX_LOCKDEP_CHAINS:      65536
[    0.413023] ... CHAINHASH_SIZE:          32768
[    0.413040]  memory used by lock dependency info: 7743 kB
[    0.413059]  per task-struct memory footprint: 2688 bytes
[    0.413171] ACPI: Core revision 20181213
[    0.414302] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.414356] hpet clockevent registered
[    0.414384] APIC: Switch to symmetric I/O mode setup
[    0.414487] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.415507] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.420368] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x228399ca0ed, max_idle_ns: 440795326939 ns
[    0.420425] Calibrating delay loop (skipped), value calculated using timer frequency.. 4788.82 BogoMIPS (lpj=2394413)
[    0.420471] pid_max: default: 32768 minimum: 301
[    0.420888] LSM: Security Framework initializing
[    0.422005] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.422621] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.422772] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.422840] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.424903] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.424931] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.424965] mce: CPU supports 7 MCE banks
[    0.425052] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.425090] process: using mwait in idle threads
[    0.425117] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.425141] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.425170] Spectre V2 : Mitigation: Full generic retpoline
[    0.425194] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.425233] Speculative Store Bypass: Vulnerable
[    0.425562] Freeing SMP alternatives memory: 28K
[    0.428622] TSC deadline timer enabled
[    0.428650] smpboot: CPU0: Intel(R) Core(TM) i5-2435M CPU @ 2.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.434506] calling  init_hw_perf_events+0x0/0xa13 @ 1
[    0.434531] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.434621] core: PEBS disabled due to CPU errata, please upgrade microcode
[    0.434678] ... version:                3
[    0.434698] ... bit width:              48
[    0.434717] ... generic registers:      4
[    0.434737] ... value mask:             0000ffffffffffff
[    0.434760] ... max period:             00007fffffffffff
[    0.434783] ... fixed-purpose events:   3
[    0.434802] ... event mask:             000000070000000f
[    0.434887] initcall init_hw_perf_events+0x0/0xa13 returned 0 after 0 usecs
[    0.434919] calling  init_real_mode+0x0/0x1e1 @ 1
[    0.434972] initcall init_real_mode+0x0/0x1e1 returned 0 after 0 usecs
[    0.435003] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
[    0.435033] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
[    0.435068] calling  kvm_setup_vsyscall_timeinfo+0x0/0x1dc @ 1
[    0.435095] initcall kvm_setup_vsyscall_timeinfo+0x0/0x1dc returned 0 after 0 usecs
[    0.435128] calling  early_efi_map_fb+0x0/0x1f1 @ 1
[    0.435153] initcall early_efi_map_fb+0x0/0x1f1 returned 0 after 0 usecs
[    0.435182] calling  spawn_ksoftirqd+0x0/0x45 @ 1
[    0.436463] initcall spawn_ksoftirqd+0x0/0x45 returned 0 after 1953 usecs
[    0.436494] calling  migration_init+0x0/0xf2 @ 1
[    0.436518] initcall migration_init+0x0/0xf2 returned 0 after 0 usecs
[    0.436547] calling  check_cpu_stall_init+0x0/0x1b @ 1
[    0.436578] initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
[    0.436608] calling  srcu_bootup_announce+0x0/0x30 @ 1
[    0.436631] rcu: Hierarchical SRCU implementation.
[    0.436654] initcall srcu_bootup_announce+0x0/0x30 returned 0 after 0 usecs
[    0.436684] calling  rcu_spawn_gp_kthread+0x0/0x1f3 @ 1
[    0.436845] initcall rcu_spawn_gp_kthread+0x0/0x1f3 returned 0 after 0 usecs
[    0.436878] calling  cpu_stop_init+0x0/0x185 @ 1
[    0.438482] initcall cpu_stop_init+0x0/0x185 returned 0 after 1953 usecs
[    0.438513] calling  jump_label_init_module+0x0/0x12 @ 1
[    0.438544] initcall jump_label_init_module+0x0/0x12 returned 0 after 0 usecs
[    0.438577] calling  dynamic_debug_init+0x0/0x468 @ 1
[    0.440916] initcall dynamic_debug_init+0x0/0x468 returned 0 after 1953 usecs
[    0.440951] calling  rand_initialize+0x0/0x80 @ 1
[    0.441072] initcall rand_initialize+0x0/0x80 returned 0 after 0 usecs
[    0.441102] calling  efi_memreserve_root_init+0x0/0x29 @ 1
[    0.441129] initcall efi_memreserve_root_init+0x0/0x29 returned 0 after 0 usecs
[    0.441162] calling  initialize_ptr_random+0x0/0x54 @ 1
[    0.441192] initcall initialize_ptr_random+0x0/0x54 returned 0 after 0 usecs
[    0.442853] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.445460] smp: Bringing up secondary CPUs ...
[    0.453507] x86: Booting SMP configuration:
[    0.453529] .... node  #0, CPUs:      #1 #2 #3
[    0.472696] smp: Brought up 1 node, 4 CPUs
[    0.472696] smpboot: Max logical packages: 2
[    0.472696] smpboot: Total of 4 processors activated (19155.30 BogoMIPS)
[    0.489447] node 0 initialised, 93635 pages in 14ms
[    0.490016] pgdatinit0 (29) used greatest stack depth: 30552 bytes left
[    0.491458] devtmpfs: initialized
[    0.492471] x86/mm: Memory block size: 128MB
[    0.511875] calling  bpf_jit_charge_init+0x0/0x35 @ 1
[    0.511909] initcall bpf_jit_charge_init+0x0/0x35 returned 0 after 0 usecs
[    0.511941] calling  ipc_ns_init+0x0/0x10b @ 1
[    0.511994] initcall ipc_ns_init+0x0/0x10b returned 0 after 0 usecs
[    0.512024] calling  init_mmap_min_addr+0x0/0x16 @ 1
[    0.512049] initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
[    0.512079] calling  net_ns_init+0x0/0x133 @ 1
[    0.512506] initcall net_ns_init+0x0/0x133 returned 0 after 976 usecs
[    0.512669] calling  xen_pvh_gnttab_setup+0x0/0xa4 @ 1
[    0.512696] initcall xen_pvh_gnttab_setup+0x0/0xa4 returned -19 after 0 usecs
[    0.512728] calling  e820__register_nvs_regions+0x0/0x171 @ 1
[    0.512763] PM: Registering ACPI NVS region [mem 0xaa5d0000-0xaa5d01ff] (512 bytes)
[    0.512808] PM: Registering ACPI NVS region [mem 0xaa5d3000-0xaa6cffff] (1036288 bytes)
[    0.513822] initcall e820__register_nvs_regions+0x0/0x171 returned 0 after 976 usecs
[    0.513859] calling  cpufreq_register_tsc_scaling+0x0/0xf1 @ 1
[    0.513887] initcall cpufreq_register_tsc_scaling+0x0/0xf1 returned 0 after 0 usecs
[    0.513920] calling  init_cpu_syscore+0x0/0x14 @ 1
[    0.513952] initcall init_cpu_syscore+0x0/0x14 returned 0 after 0 usecs
[    0.513982] calling  reboot_init+0x0/0x9f @ 1
[    0.514009] initcall reboot_init+0x0/0x9f returned 0 after 0 usecs
[    0.514037] calling  init_lapic_sysfs+0x0/0x82 @ 1
[    0.514062] initcall init_lapic_sysfs+0x0/0x82 returned 0 after 0 usecs
[    0.514091] calling  alloc_frozen_cpus+0x0/0x1e @ 1
[    0.514131] initcall alloc_frozen_cpus+0x0/0x1e returned 0 after 0 usecs
[    0.514161] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
[    0.514194] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
[    0.514227] calling  wq_sysfs_init+0x0/0x2b @ 1
[    0.514571] initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
[    0.514601] calling  ksysfs_init+0x0/0xb4 @ 1
[    0.514732] initcall ksysfs_init+0x0/0xb4 returned 0 after 0 usecs
[    0.514760] calling  pm_init+0x0/0x7b @ 1
[    0.515419] initcall pm_init+0x0/0x7b returned 0 after 976 usecs
[    0.515419] calling  pm_disk_init+0x0/0x3c @ 1
[    0.515419] initcall pm_disk_init+0x0/0x3c returned 0 after 0 usecs
[    0.515419] calling  swsusp_header_init+0x0/0x40 @ 1
[    0.515419] initcall swsusp_header_init+0x0/0x40 returned 0 after 0 usecs
[    0.515419] calling  rcu_set_runtime_mode+0x0/0x50 @ 1
[    0.515419] initcall rcu_set_runtime_mode+0x0/0x50 returned 0 after 0 usecs
[    0.515419] calling  rcu_spawn_tasks_kthread+0x0/0x7f @ 1
[    0.516098] initcall rcu_spawn_tasks_kthread+0x0/0x7f returned 0 after 0 usecs
[    0.516098] calling  init_jiffies_clocksource+0x0/0x19 @ 1
[    0.516098] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.516098] initcall init_jiffies_clocksource+0x0/0x19 returned 0 after 0 usecs
[    0.516098] calling  futex_init+0x0/0x329 @ 1
[    0.516098] futex hash table entries: 2048 (order: 6, 262144 bytes)
[    0.516531] initcall futex_init+0x0/0x329 returned 0 after 976 usecs
[    0.516560] calling  cgroup_wq_init+0x0/0x43 @ 1
[    0.516650] initcall cgroup_wq_init+0x0/0x43 returned 0 after 0 usecs
[    0.516680] calling  cgroup1_wq_init+0x0/0x43 @ 1
[    0.516762] initcall cgroup1_wq_init+0x0/0x43 returned 0 after 0 usecs
[    0.516794] calling  init_per_zone_wmark_min+0x0/0x75 @ 1
[    0.516837] initcall init_per_zone_wmark_min+0x0/0x75 returned 0 after 0 usecs
[    0.516870] calling  init_zero_pfn+0x0/0xd7 @ 1
[    0.516894] initcall init_zero_pfn+0x0/0xd7 returned 0 after 0 usecs
[    0.516922] calling  kasan_memhotplug_init+0x0/0x14 @ 1
[    0.516948] initcall kasan_memhotplug_init+0x0/0x14 returned 0 after 0 usecs
[    0.516978] calling  memory_failure_init+0x0/0x28a @ 1
[    0.517005] initcall memory_failure_init+0x0/0x28a returned 0 after 0 usecs
[    0.517035] calling  cma_init_reserved_areas+0x0/0x49e @ 1
[    0.517061] initcall cma_init_reserved_areas+0x0/0x49e returned 0 after 0 usecs
[    0.517093] calling  fsnotify_init+0x0/0x84 @ 1
[    0.517157] initcall fsnotify_init+0x0/0x84 returned 0 after 0 usecs
[    0.517185] calling  filelock_init+0x0/0x17d @ 1
[    0.517275] initcall filelock_init+0x0/0x17d returned 0 after 0 usecs
[    0.517304] calling  init_script_binfmt+0x0/0x16 @ 1
[    0.517335] initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.517370] calling  init_elf_binfmt+0x0/0x16 @ 1
[    0.517400] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.517418] calling  init_compat_elf_binfmt+0x0/0x16 @ 1
[    0.517445] initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.517476] calling  configfs_init+0x0/0xe6 @ 1
[    0.517542] initcall configfs_init+0x0/0xe6 returned 0 after 0 usecs
[    0.517571] calling  debugfs_init+0x0/0x9e @ 1
[    0.517603] initcall debugfs_init+0x0/0x9e returned 0 after 0 usecs
[    0.517632] calling  securityfs_init+0x0/0xb6 @ 1
[    0.517862] initcall securityfs_init+0x0/0xb6 returned 0 after 0 usecs
[    0.517892] calling  prandom_init+0x0/0x5e4 @ 1
[    0.517915] prandom: seed boundary self test passed
[    0.519139] prandom: 100 self tests passed
[    0.519164] initcall prandom_init+0x0/0x5e4 returned 0 after 976 usecs
[    0.519193] calling  pinctrl_init+0x0/0xae @ 1
[    0.519214] pinctrl core: initialized pinctrl subsystem
[    0.519468] initcall pinctrl_init+0x0/0xae returned 0 after 976 usecs
[    0.519498] calling  gpiolib_dev_init+0x0/0x132 @ 1
[    0.519645] initcall gpiolib_dev_init+0x0/0x132 returned 0 after 0 usecs
[    0.519677] calling  sfi_sysfs_init+0x0/0x1db @ 1
[    0.519701] initcall sfi_sysfs_init+0x0/0x1db returned 0 after 0 usecs
[    0.519730] calling  regulator_init+0x0/0x8c @ 1
[    0.521027] probe of reg-dummy returned 1 after 1000 usecs
[    0.521113] initcall regulator_init+0x0/0x8c returned 0 after 976 usecs
[    0.521143] calling  iommu_init+0x0/0x5f @ 1

[    0.521213] *************************************************************
[    0.521240] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.521268] **                                                         **
[    0.521295] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.521322] **                                                         **
[    0.521357] ** This means that this kernel is built to expose internal **
[    0.521389] ** IOMMU data structures, which may compromise security on **
[    0.521414] ** your system.                                            **
[    0.521442] **                                                         **
[    0.521469] ** If you see this message and you are not debugging the   **
[    0.521497] ** kernel, report this immediately to your vendor!         **
[    0.521524] **                                                         **
[    0.521551] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.521579] *************************************************************
[    0.521609] initcall iommu_init+0x0/0x5f returned 0 after 976 usecs
[    0.521637] calling  component_debug_init+0x0/0x1d @ 1
[    0.521684] initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
[    0.521715] calling  genpd_bus_init+0x0/0x12 @ 1
[    0.521850] initcall genpd_bus_init+0x0/0x12 returned 0 after 0 usecs
[    0.521879] calling  opp_debug_init+0x0/0x3c @ 1
[    0.521933] initcall opp_debug_init+0x0/0x3c returned 0 after 0 usecs
[    0.521961] calling  cpufreq_core_init+0x0/0x7b @ 1
[    0.522004] initcall cpufreq_core_init+0x0/0x7b returned 0 after 0 usecs
[    0.522033] calling  cpuidle_init+0x0/0x5e @ 1
[    0.522089] initcall cpuidle_init+0x0/0x5e returned 0 after 0 usecs
[    0.522118] calling  capsule_reboot_register+0x0/0x12 @ 1
[    0.522150] initcall capsule_reboot_register+0x0/0x12 returned 0 after 0 usecs
[    0.522183] calling  bsp_pm_check_init+0x0/0x14 @ 1
[    0.522209] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
[    0.522238] calling  sock_init+0x0/0xa6 @ 1
[    0.522803] initcall sock_init+0x0/0xa6 returned 0 after 976 usecs
[    0.522833] calling  net_inuse_init+0x0/0x29 @ 1
[    0.522864] initcall net_inuse_init+0x0/0x29 returned 0 after 0 usecs
[    0.522893] calling  net_defaults_init+0x0/0x29 @ 1
[    0.522918] initcall net_defaults_init+0x0/0x29 returned 0 after 0 usecs
[    0.522948] calling  init_default_flow_dissectors+0x0/0x50 @ 1
[    0.522977] initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
[    0.523011] calling  netpoll_init+0x0/0x41 @ 1
[    0.523034] initcall netpoll_init+0x0/0x41 returned 0 after 0 usecs
[    0.523062] calling  netlink_proto_init+0x0/0x22d @ 1
[    0.523901] NET: Registered protocol family 16
[    0.524135] initcall netlink_proto_init+0x0/0x22d returned 0 after 976 usecs
[    0.524166] calling  tcp_bpf_v4_build_proto+0x0/0xc8 @ 1
[    0.524192] initcall tcp_bpf_v4_build_proto+0x0/0xc8 returned 0 after 0 usecs
[    0.524224] calling  __gnttab_init+0x0/0xb0 @ 1
[    0.524248] initcall __gnttab_init+0x0/0xb0 returned -19 after 0 usecs
[    0.524423] calling  irq_sysfs_init+0x0/0xdc @ 1
[    0.525669] initcall irq_sysfs_init+0x0/0xdc returned 0 after 976 usecs
[    0.525699] calling  audit_init+0x0/0x216 @ 1
[    0.525722] initcall audit_init+0x0/0x216 returned 0 after 0 usecs
[    0.525750] calling  bdi_class_init+0x0/0x6e @ 1
[    0.525853] initcall bdi_class_init+0x0/0x6e returned 0 after 0 usecs
[    0.525882] calling  mm_sysfs_init+0x0/0x4c @ 1
[    0.525922] initcall mm_sysfs_init+0x0/0x4c returned 0 after 0 usecs
[    0.525951] calling  gpiolib_sysfs_init+0x0/0x118 @ 1
[    0.526045] initcall gpiolib_sysfs_init+0x0/0x118 returned 0 after 0 usecs
[    0.526077] calling  pcibus_class_init+0x0/0x19 @ 1
[    0.526155] initcall pcibus_class_init+0x0/0x19 returned 0 after 0 usecs
[    0.526184] calling  pci_driver_init+0x0/0x22 @ 1
[    0.526438] initcall pci_driver_init+0x0/0x22 returned 0 after 976 usecs
[    0.526468] calling  backlight_class_init+0x0/0xef @ 1
[    0.526547] initcall backlight_class_init+0x0/0xef returned 0 after 0 usecs
[    0.526578] calling  xenbus_init+0x0/0x592 @ 1
[    0.526602] initcall xenbus_init+0x0/0x592 returned -19 after 0 usecs
[    0.526630] calling  tty_class_init+0x0/0x59 @ 1
[    0.526714] initcall tty_class_init+0x0/0x59 returned 0 after 0 usecs
[    0.526744] calling  vtconsole_class_init+0x0/0x1b4 @ 1
[    0.527038] initcall vtconsole_class_init+0x0/0x1b4 returned 0 after 0 usecs
[    0.527069] calling  iommu_dev_init+0x0/0x19 @ 1
[    0.527139] initcall iommu_dev_init+0x0/0x19 returned 0 after 0 usecs
[    0.527168] calling  mipi_dsi_bus_init+0x0/0x12 @ 1
[    0.527292] initcall mipi_dsi_bus_init+0x0/0x12 returned 0 after 0 usecs
[    0.527322] calling  software_node_init+0x0/0x4e @ 1
[    0.527371] initcall software_node_init+0x0/0x4e returned 0 after 0 usecs
[    0.527402] calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
[    0.527440] initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.527473] calling  isa_bus_init+0x0/0x39 @ 1
[    0.527692] initcall isa_bus_init+0x0/0x39 returned 0 after 0 usecs
[    0.527721] calling  register_node_type+0x0/0x2f @ 1
[    0.527990] initcall register_node_type+0x0/0x2f returned 0 after 0 usecs
[    0.528020] calling  regmap_initcall+0x0/0xd @ 1
[    0.528074] initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
[    0.528103] calling  sram_init+0x0/0x14 @ 1
[    0.528212] initcall sram_init+0x0/0x14 returned 0 after 0 usecs
[    0.528240] calling  syscon_init+0x0/0x14 @ 1
[    0.528343] initcall syscon_init+0x0/0x14 returned 0 after 0 usecs
[    0.528371] calling  spi_init+0x0/0x108 @ 1
[    0.528620] initcall spi_init+0x0/0x108 returned 0 after 976 usecs
[    0.528649] calling  i2c_init+0x0/0xfb @ 1
[    0.528858] initcall i2c_init+0x0/0xfb returned 0 after 0 usecs
[    0.528886] calling  eisa_init+0x0/0x28 @ 1
[    0.529023] EISA bus registered
[    0.529043] initcall eisa_init+0x0/0x28 returned 0 after 0 usecs
[    0.529069] calling  init_ladder+0x0/0x6b @ 1
[    0.529100] workqueue: round-robin CPU selection forced, expect performance impact
[    0.529188] cpuidle: using governor ladder
[    0.529420] initcall init_ladder+0x0/0x6b returned 0 after 976 usecs
[    0.529449] calling  init_menu+0x0/0x12 @ 1
[    0.529553] cpuidle: using governor menu
[    0.529553] initcall init_menu+0x0/0x12 returned 0 after 0 usecs
[    0.529553] calling  pcc_init+0x0/0xcb @ 1
[    0.529553] initcall pcc_init+0x0/0xcb returned -19 after 0 usecs
[    0.529553] calling  amd_postcore_init+0x0/0x22c @ 1
[    0.529553] initcall amd_postcore_init+0x0/0x22c returned 0 after 0 usecs
[    0.529568] calling  kobject_uevent_init+0x0/0x12 @ 1
[    0.529651] initcall kobject_uevent_init+0x0/0x12 returned 0 after 0 usecs
[    0.529812] calling  bts_init+0x0/0x1a2 @ 1
[    0.529834] initcall bts_init+0x0/0x1a2 returned -19 after 0 usecs
[    0.529861] calling  pt_init+0x0/0x814 @ 1
[    0.529883] initcall pt_init+0x0/0x814 returned -19 after 0 usecs
[    0.529911] calling  boot_params_ksysfs_init+0x0/0x555 @ 1
[    0.529976] initcall boot_params_ksysfs_init+0x0/0x555 returned 0 after 0 usecs
[    0.530009] calling  sbf_init+0x0/0xcd @ 1
[    0.530033] Simple Boot Flag at 0x7c set to 0x1
[    0.530065] initcall sbf_init+0x0/0xcd returned 0 after 0 usecs
[    0.530093] calling  arch_kdebugfs_init+0x0/0x24 @ 1
[    0.530145] initcall arch_kdebugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.530418] calling  intel_pconfig_init+0x0/0x1a7 @ 1
[    0.530443] initcall intel_pconfig_init+0x0/0x1a7 returned 0 after 0 usecs
[    0.530473] calling  mtrr_if_init+0x0/0x131 @ 1
[    0.530507] initcall mtrr_if_init+0x0/0x131 returned 0 after 0 usecs
[    0.530536] calling  ffh_cstate_init+0x0/0x58 @ 1
[    0.530566] initcall ffh_cstate_init+0x0/0x58 returned 0 after 0 usecs
[    0.530596] calling  activate_jump_labels+0x0/0x35 @ 1
[    0.530621] initcall activate_jump_labels+0x0/0x35 returned 0 after 0 usecs
[    0.530652] calling  kvm_setup_pv_tlb_flush+0x0/0x1d8 @ 1
[    0.530679] initcall kvm_setup_pv_tlb_flush+0x0/0x1d8 returned 0 after 0 usecs
[    0.530710] calling  gigantic_pages_init+0x0/0x90 @ 1
[    0.530735] initcall gigantic_pages_init+0x0/0x90 returned 0 after 0 usecs
[    0.530764] calling  kcmp_cookies_init+0x0/0x104 @ 1
[    0.530793] initcall kcmp_cookies_init+0x0/0x104 returned 0 after 0 usecs
[    0.530822] calling  acpi_pci_init+0x0/0x126 @ 1
[    0.530844] ACPI: bus type PCI registered
[    0.530865] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.530893] initcall acpi_pci_init+0x0/0x126 returned 0 after 0 usecs
[    0.530922] calling  dma_channel_table_init+0x0/0x1fb @ 1
[    0.530969] initcall dma_channel_table_init+0x0/0x1fb returned 0 after 0 usecs
[    0.531001] calling  dma_bus_init+0x0/0x1d9 @ 1
[    0.531313] initcall dma_bus_init+0x0/0x1d9 returned 0 after 0 usecs
[    0.531342] calling  setup_vcpu_hotplug_event+0x0/0xa4 @ 1
[    0.531369] initcall setup_vcpu_hotplug_event+0x0/0xa4 returned -19 after 0 usecs
[    0.531402] calling  register_xen_pci_notifier+0x0/0x91 @ 1
[    0.531418] initcall register_xen_pci_notifier+0x0/0x91 returned 0 after 0 usecs
[    0.531451] calling  xen_pcpu_init+0x0/0x112 @ 1
[    0.531475] initcall xen_pcpu_init+0x0/0x112 returned -19 after 0 usecs
[    0.531503] calling  dmi_id_init+0x0/0xbb9 @ 1
[    0.532005] initcall dmi_id_init+0x0/0xbb9 returned 0 after 0 usecs
[    0.532035] calling  ts_dmi_init+0x0/0x84 @ 1
[    0.532061] initcall ts_dmi_init+0x0/0x84 returned 0 after 0 usecs
[    0.532089] calling  pci_arch_init+0x0/0x100 @ 1
[    0.532166] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.533229] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.533229] PCI: Using configuration type 1 for base access
[    0.533229] initcall pci_arch_init+0x0/0x100 returned 0 after 976 usecs
[    0.533229] calling  of_platform_default_populate_init+0x0/0xbd @ 1
[    0.533417] initcall of_platform_default_populate_init+0x0/0xbd returned -19 after 0 usecs
[    0.533586] calling  init_vdso+0x0/0x20 @ 1
[    0.533612] initcall init_vdso+0x0/0x20 returned 0 after 0 usecs
[    0.533639] calling  sysenter_setup+0x0/0x14 @ 1
[    0.533663] initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
[    0.533691] calling  fixup_ht_bug+0x0/0x1cd @ 1
[    0.533712] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.533741] initcall fixup_ht_bug+0x0/0x1cd returned 0 after 0 usecs
[    0.533770] calling  topology_init+0x0/0x164 @ 1
[    0.536134] initcall topology_init+0x0/0x164 returned 0 after 1953 usecs
[    0.536165] calling  mtrr_init_finialize+0x0/0x85 @ 1
[    0.536191] initcall mtrr_init_finialize+0x0/0x85 returned 0 after 0 usecs
[    0.536220] calling  eisa_bus_probe+0x0/0xe8 @ 1
[    0.536276] initcall eisa_bus_probe+0x0/0xe8 returned 0 after 0 usecs
[    0.536306] calling  uid_cache_init+0x0/0x110 @ 1
[    0.536369] initcall uid_cache_init+0x0/0x110 returned 0 after 0 usecs
[    0.536399] calling  param_sysfs_init+0x0/0x320 @ 1
[    0.568706] initcall param_sysfs_init+0x0/0x320 returned 0 after 31250 usecs
[    0.568746] calling  user_namespace_sysctl_init+0x0/0x4c @ 1
[    0.568841] initcall user_namespace_sysctl_init+0x0/0x4c returned 0 after 0 usecs
[    0.568875] calling  proc_schedstat_init+0x0/0x25 @ 1
[    0.568913] initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
[    0.568944] calling  pm_sysrq_init+0x0/0x19 @ 1
[    0.569023] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
[    0.569054] calling  create_proc_profile+0x0/0xe0 @ 1
[    0.569079] initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
[    0.569110] calling  crash_save_vmcoreinfo_init+0x0/0x606 @ 1
[    0.569195] initcall crash_save_vmcoreinfo_init+0x0/0x606 returned 0 after 0 usecs
[    0.569237] calling  crash_notes_memory_init+0x0/0x36 @ 1
[    0.569273] initcall crash_notes_memory_init+0x0/0x36 returned 0 after 0 usecs
[    0.569305] calling  cgroup_sysfs_init+0x0/0x3c @ 1
[    0.569356] initcall cgroup_sysfs_init+0x0/0x3c returned 0 after 0 usecs
[    0.569386] calling  cgroup_namespaces_init+0x0/0x8 @ 1
[    0.569406] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
[    0.569468] calling  user_namespaces_init+0x0/0x2d @ 1
[    0.569525] initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
[    0.569556] calling  hung_task_init+0x0/0x5b @ 1
[    0.569745] initcall hung_task_init+0x0/0x5b returned 0 after 0 usecs
[    0.569745] calling  dev_map_init+0x0/0x14 @ 1
[    0.569745] initcall dev_map_init+0x0/0x14 returned 0 after 0 usecs
[    0.569745] calling  stack_map_init+0x0/0x140 @ 1
[    0.569745] initcall stack_map_init+0x0/0x140 returned 0 after 0 usecs
[    0.569745] calling  oom_init+0x0/0x30 @ 1
[    0.569745] initcall oom_init+0x0/0x30 returned 0 after 0 usecs
[    0.569745] calling  default_bdi_init+0x0/0x47 @ 1
[    0.570665] initcall default_bdi_init+0x0/0x47 returned 0 after 976 usecs
[    0.570697] calling  cgwb_init+0x0/0x37 @ 1
[    0.570782] initcall cgwb_init+0x0/0x37 returned 0 after 0 usecs
[    0.570811] calling  percpu_enable_async+0x0/0xf @ 1
[    0.570836] initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
[    0.570865] calling  kcompactd_init+0x0/0x9b @ 1
[    0.571013] initcall kcompactd_init+0x0/0x9b returned 0 after 0 usecs
[    0.571013] calling  init_user_reserve+0x0/0xa0 @ 1
[    0.571013] initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
[    0.571013] calling  init_admin_reserve+0x0/0xa0 @ 1
[    0.571013] initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
[    0.571013] calling  init_reserve_notifier+0x0/0x24 @ 1
[    0.571013] initcall init_reserve_notifier+0x0/0x24 returned 0 after 0 usecs
[    0.571013] calling  swap_init_sysfs+0x0/0x88 @ 1
[    0.571013] initcall swap_init_sysfs+0x0/0x88 returned 0 after 0 usecs
[    0.571013] calling  swapfile_init+0x0/0x129 @ 1
[    0.571013] initcall swapfile_init+0x0/0x129 returned 0 after 0 usecs
[    0.571013] calling  hugetlb_init+0x0/0x79 @ 1
[    0.571436] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.571654] initcall hugetlb_init+0x0/0x79 returned 0 after 0 usecs
[    0.571683] calling  ksm_init+0x0/0x233 @ 1
[    0.571921] initcall ksm_init+0x0/0x233 returned 0 after 0 usecs
[    0.571921] calling  hugepage_init+0x0/0x214 @ 1
[    0.572456] initcall hugepage_init+0x0/0x214 returned 0 after 976 usecs
[    0.572488] calling  mem_cgroup_init+0x0/0x4e0 @ 1
[    0.572581] initcall mem_cgroup_init+0x0/0x4e0 returned 0 after 0 usecs
[    0.572611] calling  mem_cgroup_swap_init+0x0/0x52 @ 1
[    0.572641] initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
[    0.572671] calling  page_idle_init+0x0/0x52 @ 1
[    0.572713] initcall page_idle_init+0x0/0x52 returned 0 after 0 usecs
[    0.572742] calling  crypto_wq_init+0x0/0x3a @ 1
[    0.572948] initcall crypto_wq_init+0x0/0x3a returned 0 after 0 usecs
[    0.572948] calling  cryptomgr_init+0x0/0x12 @ 1
[    0.572948] initcall cryptomgr_init+0x0/0x12 returned 0 after 0 usecs
[    0.572948] calling  init_bio+0x0/0x293 @ 1
[    0.574150] initcall init_bio+0x0/0x293 returned 0 after 976 usecs
[    0.574181] calling  blk_settings_init+0x0/0x70 @ 1
[    0.574213] initcall blk_settings_init+0x0/0x70 returned 0 after 0 usecs
[    0.574242] calling  blk_ioc_init+0x0/0x2a @ 1
[    0.574293] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
[    0.574322] calling  blk_softirq_init+0x0/0x168 @ 1
[    0.574348] initcall blk_softirq_init+0x0/0x168 returned 0 after 0 usecs
[    0.574378] calling  blk_mq_init+0x0/0x2a @ 1
[    0.574401] initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
[    0.574417] calling  genhd_device_init+0x0/0x99 @ 1
[    0.574691] initcall genhd_device_init+0x0/0x99 returned 0 after 0 usecs
[    0.574691] calling  irq_poll_setup+0x0/0x168 @ 1
[    0.574691] initcall irq_poll_setup+0x0/0x168 returned 0 after 0 usecs
[    0.574691] calling  sx150x_init+0x0/0x14 @ 1
[    0.574781] initcall sx150x_init+0x0/0x14 returned 0 after 0 usecs
[    0.574810] calling  byt_gpio_init+0x0/0x14 @ 1
[    0.574894] initcall byt_gpio_init+0x0/0x14 returned 0 after 0 usecs
[    0.574923] calling  gpiolib_debugfs_init+0x0/0x24 @ 1
[    0.574973] initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.575004] calling  pwm_debugfs_init+0x0/0x24 @ 1
[    0.575050] initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.575080] calling  pwm_sysfs_init+0x0/0x19 @ 1
[    0.575153] initcall pwm_sysfs_init+0x0/0x19 returned 0 after 976 usecs
[    0.575422] calling  pci_slot_init+0x0/0x50 @ 1
[    0.575464] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    0.575492] calling  fbmem_init+0x0/0xdb @ 1
[    0.575839] initcall fbmem_init+0x0/0xdb returned 0 after 0 usecs
[    0.575867] calling  scan_for_dmi_ipmi+0x0/0x28e @ 1
[    0.575893] initcall scan_for_dmi_ipmi+0x0/0x28e returned 0 after 0 usecs
[    0.575922] calling  acpi_init+0x0/0x5f0 @ 1
[    0.576160] ACPI: Added _OSI(Module Device)
[    0.576182] ACPI: Added _OSI(Processor Device)
[    0.576203] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.576226] ACPI: Added _OSI(Processor Aggregator Device)
[    0.576266] ACPI: Added _OSI(Linux-Dell-Video)
[    0.576300] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.576337] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.744240] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.755895] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.838731] ACPI: Dynamic OEM Table Load:
[    0.838784] ACPI: SSDT 0xFFFF88811E88DDC8 00071E (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.850011] ACPI: Dynamic OEM Table Load:
[    0.850063] ACPI: SSDT 0xFFFF88811DC10008 000303 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.856959] ACPI: Dynamic OEM Table Load:
[    0.857001] ACPI: SSDT 0xFFFF88811E994028 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.880629] ACPI: Interpreter enabled
[    0.880891] ACPI: (supports S0 S3 S4 S5)
[    0.880913] ACPI: Using IOAPIC for interrupt routing
[    0.881401] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.886180] ACPI: Enabled 8 GPEs in block 00 to 3F
[    0.963859] ACPI: Power Resource [PDOC] (off)
[    0.965174] acpi PNP0A05:00: ACPI dock station (docks/bays count: 1)
[    1.032743] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    1.032810] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.032967] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.046239] PCI host bridge to bus 0000:00
[    1.046275] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.046322] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.046360] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.046401] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    1.046423] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    1.046464] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    1.046505] pci_bus 0000:00: root bus resource [mem 0xafa00000-0xfeafffff window]
[    1.046549] pci_bus 0000:00: root bus resource [bus 00-3f]
[    1.046622] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
[    1.046661] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
[    1.046694] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
[    1.048478] pci 0000:00:02.0: [8086:0126] type 00 class 0x030000
[    1.048528] pci 0000:00:02.0: reg 0x10: [mem 0xc0000000-0xc03fffff 64bit]
[    1.048567] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    1.048605] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    1.048701] pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x5e0 @ 1
[    1.048734] pci 0000:00:02.0: efifb_fixup_resources+0x0/0x5e0 took 0 usecs
[    1.050402] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    1.050463] pci 0000:00:16.0: reg 0x10: [mem 0xc4824000-0xc482400f 64bit]
[    1.050682] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.052222] pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
[    1.052266] pci 0000:00:19.0: calling  quirk_f0_vpd_link+0x0/0x230 @ 1
[    1.052304] pci 0000:00:19.0: quirk_f0_vpd_link+0x0/0x230 took 0 usecs
[    1.052336] pci 0000:00:19.0: calling  quirk_intel_no_flr+0x0/0x50 @ 1
[    1.052366] pci 0000:00:19.0: quirk_intel_no_flr+0x0/0x50 took 0 usecs
[    1.052426] pci 0000:00:19.0: reg 0x10: [mem 0xc4800000-0xc481ffff]
[    1.052469] pci 0000:00:19.0: reg 0x14: [mem 0xc482a000-0xc482afff]
[    1.052512] pci 0000:00:19.0: reg 0x18: [io  0x3060-0x307f]
[    1.052720] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.054420] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    1.054488] pci 0000:00:1a.0: reg 0x10: [mem 0xc4829000-0xc48293ff]
[    1.054725] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.056416] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    1.056491] pci 0000:00:1b.0: reg 0x10: [mem 0xc4820000-0xc4823fff 64bit]
[    1.056753] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.058484] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    1.058523] pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x100 @ 1
[    1.058556] pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x100 took 0 usecs
[    1.058587] pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x180 @ 1
[    1.058617] pci 0000:00:1c.0: quirk_no_aersid+0x0/0x180 took 0 usecs
[    1.058780] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    1.058816] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    1.058936] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.060712] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    1.060750] pci 0000:00:1c.1: calling  quirk_cmd_compl+0x0/0x100 @ 1
[    1.060782] pci 0000:00:1c.1: quirk_cmd_compl+0x0/0x100 took 0 usecs
[    1.060812] pci 0000:00:1c.1: calling  quirk_no_aersid+0x0/0x180 @ 1
[    1.060842] pci 0000:00:1c.1: quirk_no_aersid+0x0/0x180 took 0 usecs
[    1.061012] pci 0000:00:1c.1: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    1.061048] pci 0000:00:1c.1: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    1.061169] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.062953] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    1.062990] pci 0000:00:1c.2: calling  quirk_cmd_compl+0x0/0x100 @ 1
[    1.063023] pci 0000:00:1c.2: quirk_cmd_compl+0x0/0x100 took 0 usecs
[    1.063053] pci 0000:00:1c.2: calling  quirk_no_aersid+0x0/0x180 @ 1
[    1.063083] pci 0000:00:1c.2: quirk_no_aersid+0x0/0x180 took 0 usecs
[    1.063246] pci 0000:00:1c.2: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    1.063284] pci 0000:00:1c.2: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    1.063406] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.065155] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    1.065193] pci 0000:00:1c.4: calling  quirk_cmd_compl+0x0/0x100 @ 1
[    1.065226] pci 0000:00:1c.4: quirk_cmd_compl+0x0/0x100 took 0 usecs
[    1.065255] pci 0000:00:1c.4: calling  quirk_no_aersid+0x0/0x180 @ 1
[    1.065289] pci 0000:00:1c.4: quirk_no_aersid+0x0/0x180 took 0 usecs
[    1.065456] pci 0000:00:1c.4: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    1.065492] pci 0000:00:1c.4: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    1.065612] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.067359] pci 0000:00:1c.5: [8086:1c1a] type 01 class 0x060400
[    1.067396] pci 0000:00:1c.5: calling  quirk_cmd_compl+0x0/0x100 @ 1
[    1.067420] pci 0000:00:1c.5: quirk_cmd_compl+0x0/0x100 took 0 usecs
[    1.067450] pci 0000:00:1c.5: calling  quirk_no_aersid+0x0/0x180 @ 1
[    1.067480] pci 0000:00:1c.5: quirk_no_aersid+0x0/0x180 took 0 usecs
[    1.067643] pci 0000:00:1c.5: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    1.067678] pci 0000:00:1c.5: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    1.067799] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.069567] pci 0000:00:1c.6: [8086:2448] type 01 class 0x060401
[    1.069604] pci 0000:00:1c.6: calling  quirk_cmd_compl+0x0/0x100 @ 1
[    1.069637] pci 0000:00:1c.6: quirk_cmd_compl+0x0/0x100 took 0 usecs
[    1.069666] pci 0000:00:1c.6: calling  quirk_no_aersid+0x0/0x180 @ 1
[    1.069696] pci 0000:00:1c.6: quirk_no_aersid+0x0/0x180 took 0 usecs
[    1.069861] pci 0000:00:1c.6: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    1.069896] pci 0000:00:1c.6: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    1.070017] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    1.071793] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    1.071862] pci 0000:00:1d.0: reg 0x10: [mem 0xc4828000-0xc48283ff]
[    1.072100] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.073781] pci 0000:00:1f.0: [8086:1c49] type 00 class 0x060100
[    1.075626] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
[    1.075696] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308f]
[    1.075736] pci 0000:00:1f.2: reg 0x14: [io  0x309c-0x309f]
[    1.075776] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x3087]
[    1.075817] pci 0000:00:1f.2: reg 0x1c: [io  0x3098-0x309b]
[    1.075857] pci 0000:00:1f.2: reg 0x20: [io  0x3040-0x305f]
[    1.075898] pci 0000:00:1f.2: reg 0x24: [mem 0xc4827000-0xc48277ff]
[    1.076072] pci 0000:00:1f.2: PME# supported from D3hot
[    1.078620] pci 0000:01:00.0: [1180:e823] type 00 class 0x088001
[    1.078715] pci 0000:01:00.0: calling  ricoh_mmc_fixup_r5c832+0x0/0x230 @ 1
[    1.078987] pci 0000:01:00.0: MMC controller base frequency changed to 50Mhz.
[    1.079255] pci 0000:01:00.0: ricoh_mmc_fixup_r5c832+0x0/0x230 took 976 usecs
[    1.079482] pci 0000:01:00.0: reg 0x10: [mem 0xc4700000-0xc47000ff]
[    1.080328] pci 0000:01:00.0: supports D1 D2
[    1.080351] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.081788] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.081823] pci 0000:00:1c.0:   bridge window [mem 0xc4700000-0xc47fffff]
[    1.082601] acpiphp: Slot [1] registered
[    1.082635] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    1.082664] pci 0000:00:1c.1:   bridge window [io  0x2000-0x2fff]
[    1.082696] pci 0000:00:1c.1:   bridge window [mem 0xc2700000-0xc46fffff]
[    1.082734] pci 0000:00:1c.1:   bridge window [mem 0xc0400000-0xc23fffff 64bit pref]
[    1.083416] pci 0000:04:00.0: [8086:0083] type 00 class 0x028000
[    1.083533] pci 0000:04:00.0: reg 0x10: [mem 0xc2600000-0xc2601fff 64bit]
[    1.083991] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.084961] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.084996] pci 0000:00:1c.2:   bridge window [mem 0xc2600000-0xc26fffff]
[    1.085839] pci 0000:05:00.0: [1033:0194] type 00 class 0x0c0330
[    1.085929] pci 0000:05:00.0: reg 0x10: [mem 0xc2500000-0xc2501fff 64bit]
[    1.086306] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    1.087355] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    1.087389] pci 0000:00:1c.4:   bridge window [mem 0xc2500000-0xc25fffff]
[    1.088175] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    1.088209] pci 0000:00:1c.5:   bridge window [mem 0xc2400000-0xc24fffff]
[    1.088816] pci 0000:00:1c.6: PCI bridge to [bus 07] (subtractive decode)
[    1.088874] pci 0000:00:1c.6:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    1.088919] pci 0000:00:1c.6:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    1.088970] pci 0000:00:1c.6:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    1.089024] pci 0000:00:1c.6:   bridge window [mem 0x000d4000-0x000d7fff window] (subtractive decode)
[    1.089071] pci 0000:00:1c.6:   bridge window [mem 0x000d8000-0x000dbfff window] (subtractive decode)
[    1.089118] pci 0000:00:1c.6:   bridge window [mem 0x000dc000-0x000dffff window] (subtractive decode)
[    1.089165] pci 0000:00:1c.6:   bridge window [mem 0xafa00000-0xfeafffff window] (subtractive decode)
[    1.094503] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.096005] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
[    1.097485] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.098974] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 *3 4 5 6 7 11 12 14 15)
[    1.100423] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.101883] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.103358] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 *6 7 10 12 14 15)
[    1.104816] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    1.114431] initcall acpi_init+0x0/0x5f0 returned 0 after 526367 usecs
[    1.114431] calling  adxl_init+0x0/0x28f @ 1
[    1.114431] initcall adxl_init+0x0/0x28f returned -19 after 0 usecs
[    1.114431] calling  pnp_init+0x0/0x12 @ 1
[    1.114554] initcall pnp_init+0x0/0x12 returned 0 after 976 usecs
[    1.114583] calling  balloon_init+0x0/0x449 @ 1
[    1.114607] initcall balloon_init+0x0/0x449 returned -19 after 0 usecs
[    1.114637] calling  xen_setup_shutdown_event+0x0/0x70 @ 1
[    1.114664] initcall xen_setup_shutdown_event+0x0/0x70 returned -19 after 0 usecs
[    1.114697] calling  xenbus_probe_backend_init+0x0/0x4e @ 1
[    1.114850] initcall xenbus_probe_backend_init+0x0/0x4e returned 0 after 0 usecs
[    1.114884] calling  xenbus_probe_frontend_init+0x0/0x4e @ 1
[    1.115021] initcall xenbus_probe_frontend_init+0x0/0x4e returned 0 after 0 usecs
[    1.115055] calling  xen_acpi_pad_init+0x0/0xa0 @ 1
[    1.115080] initcall xen_acpi_pad_init+0x0/0xa0 returned -19 after 0 usecs
[    1.115110] calling  ab3100_regulators_init+0x0/0x14 @ 1
[    1.115218] initcall ab3100_regulators_init+0x0/0x14 returned 0 after 0 usecs
[    1.115250] calling  misc_init+0x0/0xe1 @ 1
[    1.115361] initcall misc_init+0x0/0xe1 returned 0 after 0 usecs
[    1.115389] calling  tpm_init+0x0/0x205 @ 1
[    1.116570] initcall tpm_init+0x0/0x205 returned 0 after 976 usecs
[    1.116570] calling  vga_arb_device_init+0x0/0x6f5 @ 1
[    1.116787] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.116787] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.116787] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.116787] vgaarb: loaded
[    1.116787] initcall vga_arb_device_init+0x0/0x6f5 returned 0 after 0 usecs
[    1.116787] calling  cn_init+0x0/0x160 @ 1
[    1.116787] initcall cn_init+0x0/0x160 returned 0 after 976 usecs
[    1.116787] calling  pm860x_i2c_init+0x0/0x2c @ 1
[    1.116787] initcall pm860x_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.116787] calling  stmpe_init+0x0/0x14 @ 1
[    1.116787] initcall stmpe_init+0x0/0x14 returned 0 after 0 usecs
[    1.116787] calling  stmpe_init+0x0/0x14 @ 1
[    1.116870] initcall stmpe_init+0x0/0x14 returned 0 after 0 usecs
[    1.116897] calling  tc3589x_init+0x0/0x14 @ 1
[    1.117007] initcall tc3589x_init+0x0/0x14 returned 0 after 0 usecs
[    1.117036] calling  wm8400_module_init+0x0/0x2c @ 1
[    1.117145] initcall wm8400_module_init+0x0/0x2c returned 0 after 0 usecs
[    1.117175] calling  wm831x_i2c_init+0x0/0x2c @ 1
[    1.117272] initcall wm831x_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.117301] calling  wm831x_spi_init+0x0/0x28 @ 1
[    1.117403] initcall wm831x_spi_init+0x0/0x28 returned 0 after 0 usecs
[    1.117415] calling  wm8350_i2c_init+0x0/0x14 @ 1
[    1.117512] initcall wm8350_i2c_init+0x0/0x14 returned 0 after 976 usecs
[    1.117542] calling  tps65910_i2c_init+0x0/0x14 @ 1
[    1.117638] initcall tps65910_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.117667] calling  tps80031_init+0x0/0x14 @ 1
[    1.117761] initcall tps80031_init+0x0/0x14 returned 0 after 0 usecs
[    1.117790] calling  ezx_pcap_init+0x0/0x14 @ 1
[    1.117882] initcall ezx_pcap_init+0x0/0x14 returned 0 after 0 usecs
[    1.117911] calling  da903x_init+0x0/0x14 @ 1
[    1.118028] initcall da903x_init+0x0/0x14 returned 0 after 0 usecs
[    1.118057] calling  da9052_spi_init+0x0/0x2c @ 1
[    1.118152] initcall da9052_spi_init+0x0/0x2c returned 0 after 0 usecs
[    1.118181] calling  da9052_i2c_init+0x0/0x2c @ 1
[    1.118280] initcall da9052_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.118309] calling  lp8788_init+0x0/0x14 @ 1
[    1.118403] initcall lp8788_init+0x0/0x14 returned 0 after 0 usecs
[    1.118416] calling  da9055_i2c_init+0x0/0x2c @ 1
[    1.118513] initcall da9055_i2c_init+0x0/0x2c returned 0 after 976 usecs
[    1.118543] calling  max77843_i2c_init+0x0/0x14 @ 1
[    1.118623] initcall max77843_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.118653] calling  max8925_i2c_init+0x0/0x2c @ 1
[    1.118748] initcall max8925_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.118777] calling  max8997_i2c_init+0x0/0x14 @ 1
[    1.118864] initcall max8997_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.118893] calling  max8998_i2c_init+0x0/0x14 @ 1
[    1.118983] initcall max8998_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.119013] calling  ab3100_i2c_init+0x0/0x14 @ 1
[    1.119099] initcall ab3100_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.119128] calling  tps6586x_init+0x0/0x14 @ 1
[    1.119231] initcall tps6586x_init+0x0/0x14 returned 0 after 0 usecs
[    1.119260] calling  tps65090_init+0x0/0x14 @ 1
[    1.119357] initcall tps65090_init+0x0/0x14 returned 0 after 0 usecs
[    1.119385] calling  aat2870_init+0x0/0x14 @ 1
[    1.119485] initcall aat2870_init+0x0/0x14 returned 0 after 976 usecs
[    1.119515] calling  palmas_i2c_init+0x0/0x14 @ 1
[    1.119625] initcall palmas_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.119655] calling  rc5t583_i2c_init+0x0/0x14 @ 1
[    1.119758] initcall rc5t583_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.119788] calling  sec_pmic_init+0x0/0x14 @ 1
[    1.119883] initcall sec_pmic_init+0x0/0x14 returned 0 after 0 usecs
[    1.119911] calling  as3711_i2c_init+0x0/0x14 @ 1
[    1.120018] initcall as3711_i2c_init+0x0/0x14 returned 0 after 0 usecs
[    1.120047] calling  dax_fs_init+0x0/0xe0 @ 1
[    1.120270] initcall dax_fs_init+0x0/0xe0 returned 0 after 0 usecs
[    1.120299] calling  dma_buf_init+0x0/0xaa @ 1
[    1.120368] initcall dma_buf_init+0x0/0xaa returned 0 after 0 usecs
[    1.120397] calling  init_scsi+0x0/0xaa @ 1
[    1.121848] SCSI subsystem initialized
[    1.121872] initcall init_scsi+0x0/0xaa returned 0 after 1953 usecs
[    1.121900] calling  ata_init+0x0/0x637 @ 1
[    1.122106] libata version 3.00 loaded.
[    1.122129] initcall ata_init+0x0/0x637 returned 0 after 0 usecs
[    1.122156] calling  usb_init+0x0/0x149 @ 1
[    1.122221] ACPI: bus type USB registered
[    1.122526] usbcore: registered new interface driver usbfs
[    1.122710] usbcore: registered new interface driver hub
[    1.123720] usbcore: registered new device driver usb
[    1.123720] initcall usb_init+0x0/0x149 returned 0 after 976 usecs
[    1.123720] calling  xdbc_init+0x0/0x14d @ 1
[    1.123720] initcall xdbc_init+0x0/0x14d returned 0 after 0 usecs
[    1.123720] calling  serio_init+0x0/0x2a @ 1
[    1.123720] initcall serio_init+0x0/0x2a returned 0 after 0 usecs
[    1.123720] calling  input_init+0x0/0xfd @ 1
[    1.123720] initcall input_init+0x0/0xfd returned 0 after 0 usecs
[    1.123720] calling  rtc_init+0x0/0x72 @ 1
[    1.123720] initcall rtc_init+0x0/0x72 returned 0 after 0 usecs
[    1.123720] calling  dw_i2c_init_driver+0x0/0x14 @ 1
[    1.123720] initcall dw_i2c_init_driver+0x0/0x14 returned 0 after 0 usecs
[    1.123720] calling  cec_devnode_init+0x0/0xa4 @ 1
[    1.123738] initcall cec_devnode_init+0x0/0xa4 returned 0 after 0 usecs
[    1.123768] calling  pps_init+0x0/0xd0 @ 1
[    1.123851] pps_core: LinuxPPS API ver. 1 registered
[    1.123874] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.123920] initcall pps_init+0x0/0xd0 returned 0 after 0 usecs
[    1.123947] calling  ptp_init+0x0/0xb9 @ 1
[    1.124036] PTP clock support registered
[    1.124058] initcall ptp_init+0x0/0xb9 returned 0 after 0 usecs
[    1.124085] calling  power_supply_class_init+0x0/0x65 @ 1
[    1.124164] initcall power_supply_class_init+0x0/0x65 returned 0 after 0 usecs
[    1.124197] calling  dmi_init+0x0/0x139 @ 1
[    1.124310] initcall dmi_init+0x0/0x139 returned 0 after 0 usecs
[    1.124338] calling  efisubsys_init+0x0/0x486 @ 1
[    1.124362] initcall efisubsys_init+0x0/0x486 returned 0 after 0 usecs
[    1.124391] calling  devfreq_init+0x0/0xd4 @ 1
[    1.125536] initcall devfreq_init+0x0/0xd4 returned 0 after 976 usecs
[    1.125536] calling  devfreq_event_init+0x0/0x74 @ 1
[    1.125567] initcall devfreq_event_init+0x0/0x74 returned 0 after 0 usecs
[    1.125601] calling  vme_init+0x0/0x12 @ 1
[    1.125731] initcall vme_init+0x0/0x12 returned 0 after 0 usecs
[    1.125758] calling  ras_init+0x0/0x10 @ 1
[    1.125824] initcall ras_init+0x0/0x10 returned 0 after 0 usecs
[    1.125851] calling  nvmem_init+0x0/0x12 @ 1
[    1.125979] initcall nvmem_init+0x0/0x12 returned 0 after 0 usecs
[    1.126008] calling  pci_subsys_init+0x0/0x145 @ 1
[    1.126030] PCI: Using ACPI for IRQ routing
[    1.129003] PCI: pci_cache_line_size set to 64 bytes
[    1.130444] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    1.130485] e820: reserve RAM buffer [mem 0xaa5d0000-0xabffffff]
[    1.130521] e820: reserve RAM buffer [mem 0x14fe00000-0x14fffffff]
[    1.130559] initcall pci_subsys_init+0x0/0x145 returned 0 after 4882 usecs
[    1.130590] calling  proto_init+0x0/0x12 @ 1
[    1.130625] initcall proto_init+0x0/0x12 returned 0 after 0 usecs
[    1.130653] calling  net_dev_init+0x0/0x6b6 @ 1
[    1.131959] initcall net_dev_init+0x0/0x6b6 returned 0 after 976 usecs
[    1.131991] calling  neigh_init+0x0/0x85 @ 1
[    1.132054] initcall neigh_init+0x0/0x85 returned 0 after 0 usecs
[    1.132082] calling  fib_notifier_init+0x0/0x12 @ 1
[    1.132108] initcall fib_notifier_init+0x0/0x12 returned 0 after 0 usecs
[    1.132137] calling  fib_rules_init+0x0/0xac @ 1
[    1.132187] initcall fib_rules_init+0x0/0xac returned 0 after 0 usecs
[    1.132216] calling  init_cgroup_netprio+0x0/0x14 @ 1
[    1.132243] initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
[    1.132273] calling  bpf_lwt_init+0x0/0x17 @ 1
[    1.132296] initcall bpf_lwt_init+0x0/0x17 returned 0 after 0 usecs
[    1.132325] calling  pktsched_init+0x0/0x10f @ 1
[    1.132419] initcall pktsched_init+0x0/0x10f returned 0 after 0 usecs
[    1.132449] calling  tc_filter_init+0x0/0x12a @ 1
[    1.132654] initcall tc_filter_init+0x0/0x12a returned 0 after 0 usecs
[    1.132684] calling  tc_action_init+0x0/0x55 @ 1
[    1.132730] initcall tc_action_init+0x0/0x55 returned 0 after 0 usecs
[    1.132759] calling  genl_init+0x0/0x43 @ 1
[    1.132866] initcall genl_init+0x0/0x43 returned 0 after 0 usecs
[    1.132894] calling  cipso_v4_init+0x0/0xed @ 1
[    1.132928] initcall cipso_v4_init+0x0/0xed returned 0 after 0 usecs
[    1.132957] calling  wireless_nlevent_init+0x0/0x39 @ 1
[    1.132996] initcall wireless_nlevent_init+0x0/0x39 returned 0 after 0 usecs
[    1.133027] calling  netlbl_init+0x0/0x85 @ 1
[    1.133047] NetLabel: Initializing
[    1.133064] NetLabel:  domain hash size = 128
[    1.133084] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.133383] NetLabel:  unlabeled traffic allowed by default
[    1.133406] initcall netlbl_init+0x0/0x85 returned 0 after 976 usecs
[    1.133442] calling  xen_mcfg_late+0x0/0x2a7 @ 1
[    1.133466] initcall xen_mcfg_late+0x0/0x2a7 returned 0 after 0 usecs
[    1.133495] calling  watchdog_init+0x0/0x109 @ 1
[    1.133712] initcall watchdog_init+0x0/0x109 returned 0 after 0 usecs
[    1.133712] calling  pci_eisa_init_early+0x0/0x1fa @ 1
[    1.133712] initcall pci_eisa_init_early+0x0/0x1fa returned 0 after 0 usecs
[    1.133772] calling  nmi_warning_debugfs+0x0/0x4a @ 1
[    1.133826] initcall nmi_warning_debugfs+0x0/0x4a returned 0 after 0 usecs
[    1.133856] calling  save_microcode_in_initrd+0x0/0x19f @ 1
[    1.133886] initcall save_microcode_in_initrd+0x0/0x19f returned 0 after 0 usecs
[    1.133919] calling  hpet_late_init+0x0/0x1d1 @ 1
[    1.133960] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.133996] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.135415] initcall hpet_late_init+0x0/0x1d1 returned 0 after 1953 usecs
[    1.135446] calling  init_amd_nbs+0x0/0x1ef @ 1
[    1.135493] initcall init_amd_nbs+0x0/0x1ef returned 0 after 0 usecs
[    1.135521] calling  sugov_register+0x0/0x12 @ 1
[    1.135556] initcall sugov_register+0x0/0x12 returned 0 after 0 usecs
[    1.135585] calling  init_qspinlock_stat+0x0/0x10e @ 1
[    1.135978] initcall init_qspinlock_stat+0x0/0x10e returned 0 after 0 usecs
[    1.136011] calling  clocksource_done_booting+0x0/0x44 @ 1
[    1.136412] clocksource: Switched to clocksource tsc-early
[    1.136412] initcall clocksource_done_booting+0x0/0x44 returned 0 after 43 usecs
[    1.136412] calling  bpf_init+0x0/0x95 @ 1
[    1.136412] initcall bpf_init+0x0/0x95 returned 0 after 13 usecs
[    1.136412] calling  init_pipe_fs+0x0/0x47 @ 1
[    1.136412] initcall init_pipe_fs+0x0/0x47 returned 0 after 128 usecs
[    1.136412] calling  cgroup_writeback_init+0x0/0x34 @ 1
[    1.136993] initcall cgroup_writeback_init+0x0/0x34 returned 0 after 63 usecs
[    1.136993] calling  inotify_user_setup+0x0/0xa4 @ 1
[    1.136993] initcall inotify_user_setup+0x0/0xa4 returned 0 after 31 usecs
[    1.136993] calling  eventpoll_init+0x0/0x141 @ 1
[    1.137054] initcall eventpoll_init+0x0/0x141 returned 0 after 72 usecs
[    1.137084] calling  anon_inode_init+0x0/0x8d @ 1
[    1.137236] initcall anon_inode_init+0x0/0x8d returned 0 after 123 usecs
[    1.137266] calling  init_dax_wait_table+0x0/0x42 @ 1
[    1.137580] initcall init_dax_wait_table+0x0/0x42 returned 0 after 281 usecs
[    1.137612] calling  proc_locks_init+0x0/0x28 @ 1
[    1.137647] initcall proc_locks_init+0x0/0x28 returned 0 after 11 usecs
[    1.137677] calling  dquot_init+0x0/0x1f7 @ 1
[    1.137697] VFS: Disk quotas dquot_6.6.0
[    1.137816] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.137855] initcall dquot_init+0x0/0x1f7 returned 0 after 152 usecs
[    1.137883] calling  quota_init+0x0/0x24 @ 1
[    1.137998] initcall quota_init+0x0/0x24 returned 0 after 90 usecs
[    1.138027] calling  proc_cmdline_init+0x0/0x22 @ 1
[    1.138061] initcall proc_cmdline_init+0x0/0x22 returned 0 after 9 usecs
[    1.138091] calling  proc_consoles_init+0x0/0x25 @ 1
[    1.138124] initcall proc_consoles_init+0x0/0x25 returned 0 after 8 usecs
[    1.138154] calling  proc_cpuinfo_init+0x0/0x1f @ 1
[    1.138187] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 8 usecs
[    1.138216] calling  proc_devices_init+0x0/0x25 @ 1
[    1.138249] initcall proc_devices_init+0x0/0x25 returned 0 after 8 usecs
[    1.138278] calling  proc_interrupts_init+0x0/0x25 @ 1
[    1.138312] initcall proc_interrupts_init+0x0/0x25 returned 0 after 8 usecs
[    1.138342] calling  proc_loadavg_init+0x0/0x22 @ 1
[    1.138375] initcall proc_loadavg_init+0x0/0x22 returned 0 after 8 usecs
[    1.138404] calling  proc_meminfo_init+0x0/0x22 @ 1
[    1.138455] initcall proc_meminfo_init+0x0/0x22 returned 0 after 8 usecs
[    1.138484] calling  proc_stat_init+0x0/0x1f @ 1
[    1.138517] initcall proc_stat_init+0x0/0x1f returned 0 after 8 usecs
[    1.138545] calling  proc_uptime_init+0x0/0x22 @ 1
[    1.138587] initcall proc_uptime_init+0x0/0x22 returned 0 after 17 usecs
[    1.138616] calling  proc_version_init+0x0/0x22 @ 1
[    1.138650] initcall proc_version_init+0x0/0x22 returned 0 after 8 usecs
[    1.138679] calling  proc_softirqs_init+0x0/0x22 @ 1
[    1.138712] initcall proc_softirqs_init+0x0/0x22 returned 0 after 8 usecs
[    1.138742] calling  proc_kcore_init+0x0/0x133 @ 1
[    1.138869] initcall proc_kcore_init+0x0/0x133 returned 0 after 99 usecs
[    1.138899] calling  vmcore_init+0x0/0x5d @ 1
[    1.138922] initcall vmcore_init+0x0/0x5d returned 0 after 0 usecs
[    1.138949] calling  proc_kmsg_init+0x0/0x22 @ 1
[    1.138983] initcall proc_kmsg_init+0x0/0x22 returned 0 after 9 usecs
[    1.139011] calling  proc_page_init+0x0/0x56 @ 1
[    1.139060] initcall proc_page_init+0x0/0x56 returned 0 after 25 usecs
[    1.139089] calling  init_ramfs_fs+0x0/0x22 @ 1
[    1.139113] initcall init_ramfs_fs+0x0/0x22 returned 0 after 0 usecs
[    1.139141] calling  init_hugetlbfs_fs+0x0/0x52f @ 1
[    1.139352] initcall init_hugetlbfs_fs+0x0/0x52f returned 0 after 180 usecs
[    1.139384] calling  blk_scsi_ioctl_init+0x0/0x399 @ 1
[    1.139425] initcall blk_scsi_ioctl_init+0x0/0x399 returned 0 after 14 usecs
[    1.139456] calling  dynamic_debug_init_debugfs+0x0/0x67 @ 1
[    1.139528] initcall dynamic_debug_init_debugfs+0x0/0x67 returned 0 after 43 usecs
[    1.139561] calling  simplefb_init+0x0/0xc2 @ 1
[    1.139679] initcall simplefb_init+0x0/0xc2 returned 0 after 92 usecs
[    1.139708] calling  acpi_event_init+0x0/0x5e @ 1
[    1.139824] initcall acpi_event_init+0x0/0x5e returned 0 after 89 usecs
[    1.139853] calling  pnp_system_init+0x0/0x12 @ 1
[    1.139952] initcall pnp_system_init+0x0/0x12 returned 0 after 72 usecs
[    1.139982] calling  pnpacpi_init+0x0/0xd0 @ 1
[    1.140003] pnp: PnP ACPI init
[    1.142995] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.143047] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.143095] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.143143] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.143191] system 00:00: [mem 0xafa00000-0xafa00fff] has been reserved
[    1.143239] system 00:00: [mem 0xfeb00000-0xfeb03fff] has been reserved
[    1.143286] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.143334] system 00:00: [mem 0xfed40000-0xfed8ffff] has been reserved
[    1.143388] system 00:00: [mem 0xff000000-0xffffffff] could not be reserved
[    1.143462] system 00:00: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.143601] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.143650] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.143697] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.143745] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.143792] system 00:00: [mem 0xafa00000-0xafa00fff] has been reserved
[    1.143840] system 00:00: [mem 0xfeb00000-0xfeb03fff] has been reserved
[    1.143887] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.143934] system 00:00: [mem 0xfed40000-0xfed8ffff] has been reserved
[    1.143986] system 00:00: [mem 0xff000000-0xffffffff] could not be reserved
[    1.144039] system 00:00: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.144115] probe of 00:00 returned 1 after 1216 usecs
[    1.144162] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.151367] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    1.151512] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    1.151577] probe of 00:01 returned 1 after 290 usecs
[    1.151609] system 00:01: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    1.152292] system 00:02: [io  0x1000-0x100f] has been reserved
[    1.152339] system 00:02: [io  0xffff] has been reserved
[    1.152393] system 00:02: [io  0xffff] has been reserved
[    1.152456] system 00:02: [io  0x0400-0x047f] has been reserved
[    1.152502] system 00:02: [io  0x0500-0x053f] has been reserved
[    1.152624] system 00:02: [io  0x1000-0x100f] has been reserved
[    1.152670] system 00:02: [io  0xffff] has been reserved
[    1.152714] system 00:02: [io  0xffff] has been reserved
[    1.152757] system 00:02: [io  0x0400-0x047f] has been reserved
[    1.152802] system 00:02: [io  0x0500-0x053f] has been reserved
[    1.152863] probe of 00:02 returned 1 after 659 usecs
[    1.152893] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.153584] system 00:03: [io  0x0680-0x06ff] has been reserved
[    1.153630] system 00:03: [io  0x01e0-0x01e7] has been reserved
[    1.153757] system 00:03: [io  0x0680-0x06ff] has been reserved
[    1.153803] system 00:03: [io  0x01e0-0x01e7] has been reserved
[    1.153864] probe of 00:03 returned 1 after 359 usecs
[    1.153894] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.154289] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.154729] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.155099] pnp 00:06: Plug and Play ACPI device, IDs TOS0220 PNP0f13 (active)
[    1.156260] system 00:07: [mem 0x20000000-0x201fffff] has been reserved
[    1.156309] system 00:07: [mem 0x40000000-0x401fffff] has been reserved
[    1.156448] system 00:07: [mem 0x20000000-0x201fffff] has been reserved
[    1.156496] system 00:07: [mem 0x40000000-0x401fffff] has been reserved
[    1.156559] probe of 00:07 returned 1 after 379 usecs
[    1.156590] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.159309] pnp: PnP ACPI: found 8 devices
[    1.159337] initcall pnpacpi_init+0x0/0xd0 returned 0 after 18874 usecs
[    1.159367] calling  chr_dev_init+0x0/0x189 @ 1
[    1.181605] initcall chr_dev_init+0x0/0x189 returned 0 after 21689 usecs
[    1.181644] calling  firmware_class_init+0x0/0x13b @ 1
[    1.181744] initcall firmware_class_init+0x0/0x13b returned 0 after 71 usecs
[    1.181776] calling  thermal_init+0x0/0x13a @ 1
[    1.181968] initcall thermal_init+0x0/0x13a returned 0 after 163 usecs
[    1.181998] calling  cpufreq_gov_performance_init+0x0/0x12 @ 1
[    1.182027] initcall cpufreq_gov_performance_init+0x0/0x12 returned 0 after 1 usecs
[    1.182061] calling  map_properties+0x0/0xc36 @ 1
[    1.182085] initcall map_properties+0x0/0xc36 returned 0 after 0 usecs
[    1.182113] calling  init_acpi_pm_clocksource+0x0/0xd7 @ 1
[    1.186664] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.186706] initcall init_acpi_pm_clocksource+0x0/0xd7 returned 0 after 4458 usecs
[    1.186739] calling  pcibios_assign_resources+0x0/0x1e9 @ 1
[    1.186856] pci 0000:00:1c.5: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
[    1.186903] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000
[    1.187014] pci 0000:00:1c.5: BAR 15: assigned [mem 0xafb00000-0xafcfffff 64bit pref]
[    1.187052] pci 0000:00:1c.5: BAR 13: assigned [io  0x4000-0x4fff]
[    1.187093] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.187124] pci 0000:00:1c.0:   bridge window [mem 0xc4700000-0xc47fffff]
[    1.187167] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    1.187193] pci 0000:00:1c.1:   bridge window [io  0x2000-0x2fff]
[    1.187227] pci 0000:00:1c.1:   bridge window [mem 0xc2700000-0xc46fffff]
[    1.187261] pci 0000:00:1c.1:   bridge window [mem 0xc0400000-0xc23fffff 64bit pref]
[    1.187303] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.187333] pci 0000:00:1c.2:   bridge window [mem 0xc2600000-0xc26fffff]
[    1.187375] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    1.187405] pci 0000:00:1c.4:   bridge window [mem 0xc2500000-0xc25fffff]
[    1.187461] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    1.187487] pci 0000:00:1c.5:   bridge window [io  0x4000-0x4fff]
[    1.187521] pci 0000:00:1c.5:   bridge window [mem 0xc2400000-0xc24fffff]
[    1.187555] pci 0000:00:1c.5:   bridge window [mem 0xafb00000-0xafcfffff 64bit pref]
[    1.187596] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    1.187641] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.187669] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.187697] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.187727] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff window]
[    1.187756] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff window]
[    1.187786] pci_bus 0000:00: resource 9 [mem 0x000dc000-0x000dffff window]
[    1.187816] pci_bus 0000:00: resource 10 [mem 0xafa00000-0xfeafffff window]
[    1.187846] pci_bus 0000:01: resource 1 [mem 0xc4700000-0xc47fffff]
[    1.187875] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    1.187900] pci_bus 0000:02: resource 1 [mem 0xc2700000-0xc46fffff]
[    1.187928] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc23fffff 64bit pref]
[    1.187960] pci_bus 0000:04: resource 1 [mem 0xc2600000-0xc26fffff]
[    1.187988] pci_bus 0000:05: resource 1 [mem 0xc2500000-0xc25fffff]
[    1.188016] pci_bus 0000:06: resource 0 [io  0x4000-0x4fff]
[    1.188042] pci_bus 0000:06: resource 1 [mem 0xc2400000-0xc24fffff]
[    1.188070] pci_bus 0000:06: resource 2 [mem 0xafb00000-0xafcfffff 64bit pref]
[    1.188102] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7 window]
[    1.188129] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff window]
[    1.188157] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.188187] pci_bus 0000:07: resource 7 [mem 0x000d4000-0x000d7fff window]
[    1.188217] pci_bus 0000:07: resource 8 [mem 0x000d8000-0x000dbfff window]
[    1.188246] pci_bus 0000:07: resource 9 [mem 0x000dc000-0x000dffff window]
[    1.188276] pci_bus 0000:07: resource 10 [mem 0xafa00000-0xfeafffff window]
[    1.189410] initcall pcibios_assign_resources+0x0/0x1e9 returned 0 after 2579 usecs
[    1.189460] calling  sysctl_core_init+0x0/0x2c @ 1
[    1.189557] initcall sysctl_core_init+0x0/0x2c returned 0 after 70 usecs
[    1.189587] calling  eth_offload_init+0x0/0x14 @ 1
[    1.189622] initcall eth_offload_init+0x0/0x14 returned 0 after 9 usecs
[    1.189651] calling  ipv4_offload_init+0x0/0x74 @ 1
[    1.189676] initcall ipv4_offload_init+0x0/0x74 returned 0 after 1 usecs
[    1.189705] calling  inet_init+0x0/0x2d4 @ 1
[    1.189953] NET: Registered protocol family 2
[    1.191453] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 180224 bytes)
[    1.191683] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    1.192130] TCP bind hash table entries: 32768 (order: 9, 2621440 bytes)
[    1.193798] TCP: Hash tables configured (established 32768 bind 32768)
[    1.194296] UDP hash table entries: 2048 (order: 6, 393216 bytes)
[    1.194623] UDP-Lite hash table entries: 2048 (order: 6, 393216 bytes)
[    1.195587] initcall inet_init+0x0/0x2d4 returned 0 after 5718 usecs
[    1.195619] calling  af_unix_init+0x0/0x4e @ 1
[    1.195676] NET: Registered protocol family 1
[    1.195746] initcall af_unix_init+0x0/0x4e returned 0 after 101 usecs
[    1.195776] calling  ipv6_offload_init+0x0/0x7f @ 1
[    1.195802] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
[    1.195831] calling  vlan_offload_init+0x0/0x20 @ 1
[    1.195856] initcall vlan_offload_init+0x0/0x20 returned 0 after 1 usecs
[    1.195886] calling  pci_apply_final_quirks+0x0/0x318 @ 1
[    1.195931] pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x2d0 @ 1
[    1.195965] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.196003] pci 0000:00:02.0: pci_fixup_video+0x0/0x2d0 took 40 usecs
[    1.196045] pci 0000:00:19.0: calling  quirk_e100_interrupt+0x0/0x2e0 @ 1
[    1.196076] pci 0000:00:19.0: quirk_e100_interrupt+0x0/0x2e0 took 0 usecs
[    1.196117] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0xcc0 @ 1
[    1.206714] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0xcc0 took 10312 usecs
[    1.206806] pci 0000:00:1d.0: calling  quirk_usb_early_handoff+0x0/0xcc0 @ 1
[    1.217222] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0xcc0 took 10136 usecs
[    1.217533] pci 0000:05:00.0: calling  quirk_usb_early_handoff+0x0/0xcc0 @ 1
[    1.225188] pci 0000:05:00.0: quirk_usb_early_handoff+0x0/0xcc0 took 7439 usecs
[    1.225227] PCI: CLS 64 bytes, default 64
[    1.225251] initcall pci_apply_final_quirks+0x0/0x318 returned 0 after 28650 usecs
[    1.225285] calling  acpi_reserve_resources+0x0/0x25d @ 1
[    1.225354] initcall acpi_reserve_resources+0x0/0x25d returned 0 after 41 usecs
[    1.225386] calling  populate_rootfs+0x0/0x2e4 @ 1
[    1.225968] initcall populate_rootfs+0x0/0x2e4 returned 0 after 527 usecs
[    1.226001] calling  pci_iommu_init+0x0/0xa3 @ 1
[    1.226023] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.226052] software IO TLB: mapped [mem 0xa65d0000-0xaa5d0000] (64MB)
[    1.226081] initcall pci_iommu_init+0x0/0xa3 returned 0 after 54 usecs
[    1.226110] calling  calgary_fixup_tce_spaces+0x0/0x2aa @ 1
[    1.226137] initcall calgary_fixup_tce_spaces+0x0/0x2aa returned -19 after 0 usecs
[    1.226171] calling  ir_dev_scope_init+0x0/0x64 @ 1
[    1.226195] initcall ir_dev_scope_init+0x0/0x64 returned 0 after 0 usecs
[    1.226365] calling  ia32_binfmt_init+0x0/0x14 @ 1
[    1.226465] initcall ia32_binfmt_init+0x0/0x14 returned 0 after 73 usecs
[    1.226495] calling  amd_uncore_init+0x0/0x4a3 @ 1
[    1.226520] initcall amd_uncore_init+0x0/0x4a3 returned -19 after 0 usecs
[    1.226549] calling  amd_ibs_init+0x0/0x197 @ 1
[    1.226572] initcall amd_ibs_init+0x0/0x197 returned -19 after 0 usecs
[    1.226600] calling  amd_iommu_pc_init+0x0/0x5f3 @ 1
[    1.226624] initcall amd_iommu_pc_init+0x0/0x5f3 returned -19 after 0 usecs
[    1.226654] calling  msr_init+0x0/0x4af @ 1
[    1.226693] initcall msr_init+0x0/0x4af returned 0 after 16 usecs
[    1.226721] calling  register_kernel_offset_dumper+0x0/0x1b @ 1
[    1.226750] initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 1 usecs
[    1.226784] calling  i8259A_init_ops+0x0/0x24 @ 1
[    1.226809] initcall i8259A_init_ops+0x0/0x24 returned 0 after 1 usecs
[    1.226838] calling  init_tsc_clocksource+0x0/0x1a3 @ 1
[    1.226876] initcall init_tsc_clocksource+0x0/0x1a3 returned 0 after 9 usecs
[    1.226925] calling  add_rtc_cmos+0x0/0x1e6 @ 1
[    1.226951] initcall add_rtc_cmos+0x0/0x1e6 returned 0 after 2 usecs
[    1.226979] calling  i8237A_init_ops+0x0/0x3a @ 1
[    1.227006] initcall i8237A_init_ops+0x0/0x3a returned 0 after 4 usecs
[    1.227035] calling  thermal_throttle_init_device+0x0/0x53 @ 1
[    1.227279] initcall thermal_throttle_init_device+0x0/0x53 returned 0 after 211 usecs
[    1.227315] calling  ioapic_init_ops+0x0/0x14 @ 1
[    1.227340] initcall ioapic_init_ops+0x0/0x14 returned 0 after 1 usecs
[    1.227369] calling  register_e820_pmem+0x0/0x44 @ 1
[    1.227396] initcall register_e820_pmem+0x0/0x44 returned 0 after 3 usecs
[    1.227447] calling  add_pcspkr+0x0/0xbc @ 1
[    1.227695] initcall add_pcspkr+0x0/0xbc returned 0 after 218 usecs
[    1.227725] calling  start_periodic_check_for_corruption+0x0/0x80 @ 1
[    1.227753] check: Scanning for low memory corruption every 60 seconds
[    1.227791] initcall start_periodic_check_for_corruption+0x0/0x80 returned 0 after 34 usecs
[    1.227865] calling  add_bus_probe+0x0/0x45 @ 1
[    1.227889] initcall add_bus_probe+0x0/0x45 returned 0 after 0 usecs
[    1.227917] calling  sysfb_init+0x0/0x101 @ 1
[    1.228294] simple-framebuffer simple-framebuffer.0: framebuffer at 0xb0000000, 0x180000 bytes, mapped to 0x(____ptrval____)
[    1.228342] simple-framebuffer simple-framebuffer.0: format=r5g6b5, mode=1024x768x16, linelength=2048
[    1.232217] Console: switching to colour frame buffer device 128x48
[    1.234760] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    1.234992] Console: switching to colour dummy device 80x25
[    1.235808] simple-framebuffer simple-framebuffer.0: framebuffer at 0xb0000000, 0x180000 bytes, mapped to 0x(____ptrval____)
[    1.235862] simple-framebuffer simple-framebuffer.0: format=r5g6b5, mode=1024x768x16, linelength=2048
[    1.239426] Console: switching to colour frame buffer device 128x48
[    1.241955] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    1.242063] probe of simple-framebuffer.0 returned 1 after 13903 usecs
[    1.242131] initcall sysfb_init+0x0/0x101 returned 0 after 13857 usecs
[    1.242192] calling  audit_classes_init+0x0/0xaf @ 1
[    1.242314] initcall audit_classes_init+0x0/0xaf returned 0 after 71 usecs
[    1.242379] calling  goldfish_init+0x0/0xf0 @ 1
[    1.242441] initcall goldfish_init+0x0/0xf0 returned -19 after 0 usecs
[    1.242502] calling  iosf_mbi_init+0x0/0x2f @ 1
[    1.242693] initcall iosf_mbi_init+0x0/0x2f returned 0 after 140 usecs
[    1.242755] calling  proc_execdomains_init+0x0/0x22 @ 1
[    1.242821] initcall proc_execdomains_init+0x0/0x22 returned 0 after 13 usecs
[    1.242886] calling  register_warn_debugfs+0x0/0x24 @ 1
[    1.242966] initcall register_warn_debugfs+0x0/0x24 returned 0 after 27 usecs
[    1.243031] calling  cpuhp_sysfs_init+0x0/0x119 @ 1
[    1.243257] initcall cpuhp_sysfs_init+0x0/0x119 returned 0 after 171 usecs
[    1.243321] calling  ioresources_init+0x0/0x4a @ 1
[    1.243388] initcall ioresources_init+0x0/0x4a returned 0 after 18 usecs
[    1.243489] calling  init_sched_debug_procfs+0x0/0x2f @ 1
[    1.243553] initcall init_sched_debug_procfs+0x0/0x2f returned 0 after 10 usecs
[    1.243620] calling  psi_proc_init+0x0/0x5b @ 1
[    1.243701] initcall psi_proc_init+0x0/0x5b returned 0 after 33 usecs
[    1.243762] calling  lockdep_proc_init+0x0/0x5f @ 1
[    1.243836] initcall lockdep_proc_init+0x0/0x5f returned 0 after 24 usecs
[    1.244666] calling  snapshot_device_init+0x0/0x12 @ 1
[    1.245784] initcall snapshot_device_init+0x0/0x12 returned 0 after 269 usecs
[    1.246660] calling  irq_gc_init_ops+0x0/0x14 @ 1
[    1.247560] initcall irq_gc_init_ops+0x0/0x14 returned 0 after 1 usecs
[    1.248471] calling  irq_pm_init_ops+0x0/0x14 @ 1
[    1.249372] initcall irq_pm_init_ops+0x0/0x14 returned 0 after 1 usecs
[    1.250323] calling  irq_debugfs_init+0x0/0xe6 @ 1
[    1.251794] initcall irq_debugfs_init+0x0/0xe6 returned 0 after 498 usecs
[    1.252790] calling  timekeeping_init_ops+0x0/0x14 @ 1
[    1.253802] initcall timekeeping_init_ops+0x0/0x14 returned 0 after 1 usecs
[    1.254840] calling  init_clocksource_sysfs+0x0/0x24 @ 1
[    1.256296] initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 389 usecs
[    1.257392] calling  init_timer_list_procfs+0x0/0x32 @ 1
[    1.258516] initcall init_timer_list_procfs+0x0/0x32 returned 0 after 11 usecs
[    1.259649] calling  alarmtimer_init+0x0/0x256 @ 1
[    1.261266] probe of alarmtimer returned 1 after 169 usecs
[    1.262449] initcall alarmtimer_init+0x0/0x256 returned 0 after 1620 usecs
[    1.263646] calling  init_posix_timers+0x0/0x2a @ 1
[    1.264902] initcall init_posix_timers+0x0/0x2a returned 0 after 41 usecs
[    1.266124] calling  clockevents_init_sysfs+0x0/0x1c2 @ 1
[    1.268958] initcall clockevents_init_sysfs+0x0/0x1c2 returned 0 after 1588 usecs
[    1.270172] calling  proc_dma_init+0x0/0x22 @ 1
[    1.271365] initcall proc_dma_init+0x0/0x22 returned 0 after 10 usecs
[    1.272556] calling  proc_modules_init+0x0/0x1f @ 1
[    1.273738] initcall proc_modules_init+0x0/0x1f returned 0 after 10 usecs
[    1.274908] calling  kallsyms_init+0x0/0x22 @ 1
[    1.276068] initcall kallsyms_init+0x0/0x22 returned 0 after 9 usecs
[    1.277230] calling  pid_namespaces_init+0x0/0x40 @ 1
[    1.278460] initcall pid_namespaces_init+0x0/0x40 returned 0 after 70 usecs
[    1.279631] calling  ikconfig_init+0x0/0x3b @ 1
[    1.280792] initcall ikconfig_init+0x0/0x3b returned 0 after 10 usecs
[    1.281959] calling  audit_watch_init+0x0/0x3a @ 1
[    1.283127] initcall audit_watch_init+0x0/0x3a returned 0 after 10 usecs
[    1.284298] calling  audit_fsnotify_init+0x0/0x3a @ 1
[    1.285477] initcall audit_fsnotify_init+0x0/0x3a returned 0 after 10 usecs
[    1.286652] calling  audit_tree_init+0x0/0xce @ 1
[    1.287849] initcall audit_tree_init+0x0/0xce returned 0 after 40 usecs
[    1.289023] calling  init_kprobes+0x0/0x382 @ 1
[    1.291777] Kprobe smoke test: started
[    1.415811] Kprobe smoke test: passed successfully
[    1.416964] initcall init_kprobes+0x0/0x382 returned 0 after 123806 usecs
[    1.418135] calling  seccomp_sysctl_init+0x0/0x2c @ 1
[    1.419331] initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 39 usecs
[    1.420515] calling  utsname_sysctl_init+0x0/0x14 @ 1
[    1.421727] initcall utsname_sysctl_init+0x0/0x14 returned 0 after 52 usecs
[    1.423993] calling  init_lstats_procfs+0x0/0x22 @ 1
[    1.425178] initcall init_lstats_procfs+0x0/0x22 returned 0 after 12 usecs
[    1.426342] calling  perf_event_sysfs_init+0x0/0x10f @ 1
[    1.428632] initcall perf_event_sysfs_init+0x0/0x10f returned 0 after 1110 usecs
[    1.429803] calling  padata_driver_init+0x0/0x39 @ 1
[    1.430952] initcall padata_driver_init+0x0/0x39 returned 0 after 2 usecs
[    1.432112] calling  system_trusted_keyring_init+0x0/0x8e @ 1
[    1.433270] Initialise system trusted keyrings
[    1.434499] initcall system_trusted_keyring_init+0x0/0x8e returned 0 after 1197 usecs
[    1.435691] calling  kswapd_init+0x0/0x90 @ 1
[    1.437059] initcall kswapd_init+0x0/0x90 returned 0 after 184 usecs
[    1.438252] calling  extfrag_debug_init+0x0/0x78 @ 1
[    1.439520] initcall extfrag_debug_init+0x0/0x78 returned 0 after 70 usecs
[    1.440707] calling  mm_compute_batch_init+0x0/0x19 @ 1
[    1.441891] initcall mm_compute_batch_init+0x0/0x19 returned 0 after 2 usecs
[    1.443078] calling  slab_proc_init+0x0/0x22 @ 1
[    1.444271] initcall slab_proc_init+0x0/0x22 returned 0 after 10 usecs
[    1.445457] calling  workingset_init+0x0/0xdb @ 1
[    1.446636] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    1.447859] initcall workingset_init+0x0/0xdb returned 0 after 1192 usecs
[    1.449058] calling  proc_vmalloc_init+0x0/0x61 @ 1
[    1.450267] initcall proc_vmalloc_init+0x0/0x61 returned 0 after 10 usecs
[    1.451464] calling  procswaps_init+0x0/0x1f @ 1
[    1.452663] initcall procswaps_init+0x0/0x1f returned 0 after 9 usecs
[    1.453855] calling  init_frontswap+0x0/0x91 @ 1
[    1.455162] initcall init_frontswap+0x0/0x91 returned 0 after 120 usecs
[    1.456355] calling  slab_sysfs_init+0x0/0xfe @ 1
[    1.524550] initcall slab_sysfs_init+0x0/0xfe returned 0 after 65433 usecs
[    1.525767] calling  init_cleancache+0x0/0x91 @ 1
[    1.527086] initcall init_cleancache+0x0/0x91 returned 0 after 126 usecs
[    1.528286] calling  hmm_init+0x0/0x64 @ 1
[    1.529547] initcall hmm_init+0x0/0x64 returned 0 after 70 usecs
[    1.530740] calling  fcntl_init+0x0/0x2a @ 1
[    1.532527] initcall fcntl_init+0x0/0x2a returned 0 after 583 usecs
[    1.533726] calling  proc_filesystems_init+0x0/0x22 @ 1
[    1.534935] initcall proc_filesystems_init+0x0/0x22 returned 0 after 13 usecs
[    1.536134] calling  start_dirtytime_writeback+0x0/0x52 @ 1
[    1.537337] initcall start_dirtytime_writeback+0x0/0x52 returned 0 after 2 usecs
[    1.538543] calling  blkdev_init+0x0/0x21 @ 1
[    1.540484] initcall blkdev_init+0x0/0x21 returned 0 after 727 usecs
[    1.541689] calling  dio_init+0x0/0x2d @ 1
[    1.543467] initcall dio_init+0x0/0x2d returned 0 after 564 usecs
[    1.544688] calling  dnotify_init+0x0/0x7e @ 1
[    1.547039] initcall dnotify_init+0x0/0x7e returned 0 after 1120 usecs
[    1.548254] calling  fanotify_user_setup+0x0/0x77 @ 1
[    1.551174] initcall fanotify_user_setup+0x0/0x77 returned 0 after 1669 usecs
[    1.552399] calling  userfaultfd_init+0x0/0x2e @ 1
[    1.554185] initcall userfaultfd_init+0x0/0x2e returned 0 after 557 usecs
[    1.555408] calling  aio_setup+0x0/0x80 @ 1
[    1.557930] initcall aio_setup+0x0/0x80 returned 0 after 1269 usecs
[    1.559153] calling  init_sys32_ioctl+0x0/0x28 @ 1
[    1.560525] initcall init_sys32_ioctl+0x0/0x28 returned 0 after 152 usecs
[    1.561740] calling  mbcache_init+0x0/0x31 @ 1
[    1.563520] initcall mbcache_init+0x0/0x31 returned 0 after 555 usecs
[    1.564740] calling  init_devpts_fs+0x0/0x28 @ 1
[    1.565993] initcall init_devpts_fs+0x0/0x28 returned 0 after 45 usecs
[    1.567198] calling  ext4_init_fs+0x0/0x192 @ 1
[    1.573054] initcall ext4_init_fs+0x0/0x192 returned 0 after 4561 usecs
[    1.574260] calling  journal_init+0x0/0x118 @ 1
[    1.578867] initcall journal_init+0x0/0x118 returned 0 after 3344 usecs
[    1.580070] calling  init_fat_fs+0x0/0x4a @ 1
[    1.582391] initcall init_fat_fs+0x0/0x4a returned 0 after 1114 usecs
[    1.583592] calling  init_vfat_fs+0x0/0x12 @ 1
[    1.584770] initcall init_vfat_fs+0x0/0x12 returned 0 after 1 usecs
[    1.585962] calling  init_msdos_fs+0x0/0x12 @ 1
[    1.587139] initcall init_msdos_fs+0x0/0x12 returned 0 after 1 usecs
[    1.588320] calling  init_iso9660_fs+0x0/0x6d @ 1
[    1.590090] initcall init_iso9660_fs+0x0/0x6d returned 0 after 585 usecs
[    1.591265] calling  ipc_init+0x0/0x25 @ 1
[    1.592532] initcall ipc_init+0x0/0x25 returned 0 after 101 usecs
[    1.593704] calling  ipc_sysctl_init+0x0/0x14 @ 1
[    1.594910] initcall ipc_sysctl_init+0x0/0x14 returned 0 after 39 usecs
[    1.596086] calling  init_mqueue_fs+0x0/0x24a @ 1
[    1.598030] initcall init_mqueue_fs+0x0/0x24a returned 0 after 756 usecs
[    1.599214] calling  key_proc_init+0x0/0x6e @ 1
[    1.600404] initcall key_proc_init+0x0/0x6e returned 0 after 19 usecs
[    1.601579] calling  crypto_algapi_init+0x0/0xd @ 1
[    1.602762] initcall crypto_algapi_init+0x0/0xd returned 0 after 10 usecs
[    1.603937] calling  dh_init+0x0/0x20 @ 1
[    1.835657] cryptomgr_test (50) used greatest stack depth: 29072 bytes left
[    1.836183] initcall dh_init+0x0/0x20 returned 0 after 225663 usecs
[    1.837027] kworker/u16:0 (51) used greatest stack depth: 28168 bytes left
[    1.838947] calling  rsa_init+0x0/0x40 @ 1
[    2.238457] tsc: Refined TSC clocksource calibration: 2394.564 MHz
[    2.240620] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2284284d7d9, max_idle_ns: 440795247978 ns
[    2.242859] clocksource: Switched to clocksource tsc
[    2.404754] initcall rsa_init+0x0/0x40 returned 0 after 552537 usecs
[    2.406010] calling  hmac_module_init+0x0/0x12 @ 1
[    2.407247] initcall hmac_module_init+0x0/0x12 returned 0 after 0 usecs
[    2.408515] calling  crypto_null_mod_init+0x0/0x48 @ 1
[    2.411746] initcall crypto_null_mod_init+0x0/0x48 returned 0 after 1945 usecs
[    2.413022] calling  md5_mod_init+0x0/0x12 @ 1
[    2.415088] initcall md5_mod_init+0x0/0x12 returned 0 after 807 usecs
[    2.416357] calling  sha1_generic_mod_init+0x0/0x12 @ 1
[    2.418566] initcall sha1_generic_mod_init+0x0/0x12 returned 0 after 891 usecs
[    2.419835] calling  sha256_generic_mod_init+0x0/0x17 @ 1
[    2.422946] initcall sha256_generic_mod_init+0x0/0x17 returned 0 after 1806 usecs
[    2.424220] calling  crypto_ecb_module_init+0x0/0x12 @ 1
[    2.425492] initcall crypto_ecb_module_init+0x0/0x12 returned 0 after 0 usecs
[    2.426754] calling  crypto_cbc_module_init+0x0/0x12 @ 1
[    2.427989] initcall crypto_cbc_module_init+0x0/0x12 returned 0 after 0 usecs
[    2.429239] calling  aes_init+0x0/0x12 @ 1
[    2.431085] initcall aes_init+0x0/0x12 returned 0 after 588 usecs
[    2.432343] calling  deflate_mod_init+0x0/0x3f @ 1
[    2.439397] initcall deflate_mod_init+0x0/0x3f returned 0 after 5639 usecs
[    2.440699] calling  crc32c_mod_init+0x0/0x12 @ 1
[    2.443181] initcall crc32c_mod_init+0x0/0x12 returned 0 after 1215 usecs
[    2.444445] calling  crct10dif_mod_init+0x0/0x12 @ 1
[    2.446742] initcall crct10dif_mod_init+0x0/0x12 returned 0 after 1014 usecs
[    2.448006] calling  lzo_mod_init+0x0/0x3a @ 1
[    2.451454] initcall lzo_mod_init+0x0/0x3a returned 0 after 2119 usecs
[    2.452726] calling  asymmetric_key_init+0x0/0x12 @ 1
[    2.454005] Key type asymmetric registered
[    2.455250] initcall asymmetric_key_init+0x0/0x12 returned 0 after 1247 usecs
[    2.456522] calling  x509_key_init+0x0/0x12 @ 1
[    2.457780] Asymmetric key parser 'x509' registered
[    2.459028] initcall x509_key_init+0x0/0x12 returned 0 after 1227 usecs
[    2.460295] calling  proc_genhd_init+0x0/0x42 @ 1
[    2.461586] initcall proc_genhd_init+0x0/0x42 returned 0 after 24 usecs
[    2.462858] calling  bsg_init+0x0/0x3d8 @ 1
[    2.464204] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    2.465502] initcall bsg_init+0x0/0x3d8 returned 0 after 1359 usecs
[    2.466785] calling  throtl_init+0x0/0x50 @ 1
[    2.468323] initcall throtl_init+0x0/0x50 returned 0 after 257 usecs
[    2.469632] calling  iolatency_init+0x0/0x12 @ 1
[    2.470934] initcall iolatency_init+0x0/0x12 returned 0 after 4 usecs
[    2.472216] calling  btree_module_init+0x0/0x2a @ 1
[    2.474080] initcall btree_module_init+0x0/0x2a returned 0 after 571 usecs
[    2.475361] calling  crc_t10dif_mod_init+0x0/0x4a @ 1
[    2.476661] initcall crc_t10dif_mod_init+0x0/0x4a returned 0 after 22 usecs
[    2.477926] calling  percpu_counter_startup+0x0/0x56 @ 1
[    2.479284] initcall percpu_counter_startup+0x0/0x56 returned 0 after 84 usecs
[    2.480551] calling  sg_pool_init+0x0/0x37f @ 1
[    2.484807] initcall sg_pool_init+0x0/0x37f returned 0 after 2963 usecs
[    2.486038] calling  phy_core_init+0x0/0x70 @ 1
[    2.487314] initcall phy_core_init+0x0/0x70 returned 0 after 64 usecs
[    2.488546] calling  ocelot_pinctrl_driver_init+0x0/0x14 @ 1
[    2.489843] initcall ocelot_pinctrl_driver_init+0x0/0x14 returned 0 after 80 usecs
[    2.491073] calling  bgpio_driver_init+0x0/0x14 @ 1
[    2.492366] initcall bgpio_driver_init+0x0/0x14 returned 0 after 84 usecs
[    2.493596] calling  ftgpio_gpio_driver_init+0x0/0x14 @ 1
[    2.494890] initcall ftgpio_gpio_driver_init+0x0/0x14 returned 0 after 82 usecs
[    2.496115] calling  sdv_gpio_driver_init+0x0/0x1b @ 1
[    2.497442] initcall sdv_gpio_driver_init+0x0/0x1b returned 0 after 116 usecs
[    2.498666] calling  crystalcove_pwm_driver_init+0x0/0x14 @ 1
[    2.499972] initcall crystalcove_pwm_driver_init+0x0/0x14 returned 0 after 92 usecs
[    2.501205] calling  stmpe_pwm_driver_init+0x0/0x1b @ 1
[    2.502591] initcall stmpe_pwm_driver_init+0x0/0x1b returned -19 after 158 usecs
[    2.503832] calling  pci_proc_init+0x0/0x71 @ 1
[    2.505293] initcall pci_proc_init+0x0/0x71 returned 0 after 233 usecs
[    2.506534] calling  pcie_portdrv_init+0x0/0x61 @ 1
[    2.525677] probe of 0000:00:1c.0 returned 1 after 17597 usecs
[    2.544967] probe of 0000:00:1c.1 returned 1 after 18043 usecs
[    2.564145] probe of 0000:00:1c.2 returned 1 after 17952 usecs
[    2.565676] probe of 0000:00:1c.4 returned 1 after 319 usecs
[    2.584232] probe of 0000:00:1c.5 returned 1 after 17372 usecs
[    2.585516] initcall pcie_portdrv_init+0x0/0x61 returned 0 after 75933 usecs
[    2.586692] calling  pci_hotplug_init+0x0/0x49 @ 1
[    2.587860] initcall pci_hotplug_init+0x0/0x49 returned 0 after 0 usecs
[    2.589030] calling  shpcd_init+0x0/0x76 @ 1
[    2.590365] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.591551] initcall shpcd_init+0x0/0x76 returned 0 after 1327 usecs
[    2.592727] calling  pcifront_init+0x0/0xd0 @ 1
[    2.593896] initcall pcifront_init+0x0/0xd0 returned -19 after 0 usecs
[    2.595071] calling  pci_ep_cfs_init+0x0/0xce @ 1
[    2.596598] initcall pci_ep_cfs_init+0x0/0xce returned 0 after 358 usecs
[    2.597777] calling  pci_epc_init+0x0/0x42 @ 1
[    2.598992] initcall pci_epc_init+0x0/0x42 returned 0 after 57 usecs
[    2.600153] calling  pci_epf_init+0x0/0x2a @ 1
[    2.601407] initcall pci_epf_init+0x0/0x2a returned 0 after 113 usecs
[    2.602562] calling  dw_plat_pcie_driver_init+0x0/0x14 @ 1
[    2.603784] initcall dw_plat_pcie_driver_init+0x0/0x14 returned 0 after 75 usecs
[    2.604938] calling  meson_pcie_driver_init+0x0/0x14 @ 1
[    2.606184] initcall meson_pcie_driver_init+0x0/0x14 returned 0 after 91 usecs
[    2.607342] calling  imsttfb_init+0x0/0x261 @ 1
[    2.608608] initcall imsttfb_init+0x0/0x261 returned 0 after 110 usecs
[    2.609762] calling  asiliantfb_init+0x0/0x34 @ 1
[    2.611017] initcall asiliantfb_init+0x0/0x34 returned 0 after 104 usecs
[    2.612172] calling  xenfb_init+0x0/0x9f @ 1
[    2.613319] initcall xenfb_init+0x0/0x9f returned -19 after 0 usecs
[    2.614470] calling  efifb_driver_init+0x0/0x14 @ 1
[    2.615701] initcall efifb_driver_init+0x0/0x14 returned 0 after 82 usecs
[    2.616854] calling  intel_idle_init+0x0/0x3d1 @ 1
[    2.618006] intel_idle: MWAIT substates: 0x21120
[    2.619147] intel_idle: v0.4.1 model 0x2A
[    2.623792] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.624952] initcall intel_idle_init+0x0/0x3d1 returned 0 after 6783 usecs
[    2.626107] calling  acpi_button_driver_init+0x0/0x4e @ 1
[    2.627912] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.629379] ACPI: Power Button [PWRB]
[    2.631769] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.633107] ACPI: Power Button [PWRB]
[    2.634336] probe of PNP0C0C:00 returned 1 after 6962 usecs
[    2.636056] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    2.639548] ACPI: Lid Switch [LID]
[    2.641629] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input3
[    2.644541] ACPI: Lid Switch [LID]
[    2.645808] probe of PNP0C0D:00 returned 1 after 10273 usecs
[    2.647545] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    2.650543] ACPI: Power Button [PWRF]
[    2.652744] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    2.657530] ACPI: Power Button [PWRF]
[    2.658874] probe of LNXPWRBN:00 returned 1 after 11824 usecs
[    2.660254] initcall acpi_button_driver_init+0x0/0x4e returned 0 after 32228 usecs
[    2.661577] calling  acpi_video_init+0x0/0x1c6 @ 1
[    2.662902] initcall acpi_video_init+0x0/0x1c6 returned 0 after 28 usecs
[    2.664215] calling  acpi_processor_driver_init+0x0/0xc1 @ 1
[    2.667174] probe of cpu0 returned 1 after 1629 usecs
[    2.669903] probe of cpu1 returned 1 after 1399 usecs
[    2.672376] probe of cpu2 returned 1 after 1167 usecs
[    2.674878] probe of cpu3 returned 1 after 1226 usecs
[    2.676241] initcall acpi_processor_driver_init+0x0/0xc1 returned 0 after 10468 usecs
[    2.677525] calling  acpi_hed_driver_init+0x0/0x12 @ 1
[    2.678963] initcall acpi_hed_driver_init+0x0/0x12 returned 0 after 164 usecs
[    2.680237] calling  bgrt_init+0x0/0x18b @ 1
[    2.681501] initcall bgrt_init+0x0/0x18b returned -19 after 0 usecs
[    2.682772] calling  erst_init+0x0/0x49a @ 1
[    2.684032] initcall erst_init+0x0/0x49a returned 0 after 2 usecs
[    2.685294] calling  ghes_init+0x0/0x29e @ 1
[    2.686591] initcall ghes_init+0x0/0x29e returned -19 after 0 usecs
[    2.687840] calling  intel_crc_pmic_opregion_driver_init+0x0/0x14 @ 1
[    2.689198] initcall intel_crc_pmic_opregion_driver_init+0x0/0x14 returned 0 after 91 usecs
[    2.690467] calling  intel_bxtwc_pmic_opregion_driver_init+0x0/0x14 @ 1
[    2.691825] initcall intel_bxtwc_pmic_opregion_driver_init+0x0/0x14 returned 0 after 90 usecs
[    2.693103] calling  intel_cht_wc_pmic_opregion_driver_init+0x0/0x14 @ 1
[    2.694491] initcall intel_cht_wc_pmic_opregion_driver_init+0x0/0x14 returned 0 after 110 usecs
[    2.695780] calling  chtdc_ti_pmic_opregion_driver_init+0x0/0x14 @ 1
[    2.697148] initcall chtdc_ti_pmic_opregion_driver_init+0x0/0x14 returned 0 after 84 usecs
[    2.698436] calling  of_fixed_factor_clk_driver_init+0x0/0x14 @ 1
[    2.699807] initcall of_fixed_factor_clk_driver_init+0x0/0x14 returned 0 after 82 usecs
[    2.701099] calling  of_fixed_clk_driver_init+0x0/0x14 @ 1
[    2.702477] initcall of_fixed_clk_driver_init+0x0/0x14 returned 0 after 91 usecs
[    2.703782] calling  gpio_clk_driver_init+0x0/0x14 @ 1
[    2.705174] initcall gpio_clk_driver_init+0x0/0x14 returned 0 after 87 usecs
[    2.706482] calling  hsdk_pll_clk_driver_init+0x0/0x14 @ 1
[    2.707865] initcall hsdk_pll_clk_driver_init+0x0/0x14 returned 0 after 81 usecs
[    2.709169] calling  plt_clk_driver_init+0x0/0x14 @ 1
[    2.710540] initcall plt_clk_driver_init+0x0/0x14 returned 0 after 89 usecs
[    2.711821] calling  st_clk_driver_init+0x0/0x14 @ 1
[    2.713148] initcall st_clk_driver_init+0x0/0x14 returned 0 after 66 usecs
[    2.714425] calling  xenbus_probe_initcall+0x0/0xa7 @ 1
[    2.715677] initcall xenbus_probe_initcall+0x0/0xa7 returned -19 after 0 usecs
[    2.716927] calling  xenbus_init+0x0/0x67 @ 1
[    2.718149] initcall xenbus_init+0x0/0x67 returned -19 after 0 usecs
[    2.719369] calling  xenbus_backend_init+0x0/0xa3 @ 1
[    2.720583] initcall xenbus_backend_init+0x0/0xa3 returned -19 after 0 usecs
[    2.721799] calling  evtchn_init+0x0/0x75 @ 1
[    2.722994] initcall evtchn_init+0x0/0x75 returned -19 after 0 usecs
[    2.724195] calling  xenfs_init+0x0/0x4e @ 1
[    2.725380] initcall xenfs_init+0x0/0x4e returned 0 after 0 usecs
[    2.726570] calling  hyper_sysfs_init+0x0/0x3f0 @ 1
[    2.727746] initcall hyper_sysfs_init+0x0/0x3f0 returned -19 after 0 usecs
[    2.728924] calling  hypervisor_subsys_init+0x0/0x9b @ 1
[    2.730097] initcall hypervisor_subsys_init+0x0/0x9b returned -19 after 0 usecs
[    2.731274] calling  platform_driver_init+0x0/0x1b @ 1
[    2.732586] initcall platform_driver_init+0x0/0x1b returned 0 after 134 usecs
[    2.733789] calling  xen_late_init_mcelog+0x0/0xbc @ 1
[    2.734995] initcall xen_late_init_mcelog+0x0/0xbc returned -19 after 0 usecs
[    2.736227] calling  privcmd_init+0x0/0x93 @ 1
[    2.737439] initcall privcmd_init+0x0/0x93 returned -19 after 0 usecs
[    2.738650] calling  pvcalls_back_init+0x0/0x81 @ 1
[    2.739860] initcall pvcalls_back_init+0x0/0x81 returned -19 after 0 usecs
[    2.741071] calling  n_null_init+0x0/0x2b @ 1
[    2.742273] initcall n_null_init+0x0/0x2b returned 0 after 1 usecs
[    2.743484] calling  pty_init+0x0/0xdbf @ 1
[    2.880604] initcall pty_init+0x0/0xdbf returned 0 after 132722 usecs
[    2.881856] calling  sysrq_init+0x0/0x41 @ 1
[    2.883094] initcall sysrq_init+0x0/0x41 returned 0 after 21 usecs
[    2.884315] calling  xen_hvc_init+0x0/0x5f1 @ 1
[    2.885532] initcall xen_hvc_init+0x0/0x5f1 returned -19 after 0 usecs
[    2.886745] calling  serial8250_init+0x0/0x230 @ 1
[    2.887952] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.898159] probe of serial8250 returned 1 after 6302 usecs
[    2.899467] initcall serial8250_init+0x0/0x230 returned 0 after 11240 usecs
[    2.900682] calling  serial_pci_driver_init+0x0/0x1b @ 1
[    2.902060] initcall serial_pci_driver_init+0x0/0x1b returned 0 after 161 usecs
[    2.903275] calling  exar_pci_driver_init+0x0/0x1b @ 1
[    2.904595] initcall exar_pci_driver_init+0x0/0x1b returned 0 after 110 usecs
[    2.905805] calling  ttyprintk_init+0x0/0x2a3 @ 1
[    2.907406] initcall ttyprintk_init+0x0/0x2a3 returned 0 after 391 usecs
[    2.908635] calling  hpet_init+0x0/0x65 @ 1
[    2.911509] probe of PNP0103:00 returned 0 after 1225 usecs
[    2.912817] initcall hpet_init+0x0/0x65 returned 0 after 2916 usecs
[    2.914025] calling  agp_init+0x0/0x27 @ 1
[    2.915205] Linux agpgart interface v0.103
[    2.916380] initcall agp_init+0x0/0x27 returned 0 after 1146 usecs
[    2.917569] calling  agp_intel_init+0x0/0x5a @ 1
[    2.918874] initcall agp_intel_init+0x0/0x5a returned 0 after 119 usecs
[    2.920064] calling  hangcheck_init+0x0/0xb0 @ 1
[    2.921241] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    2.922469] initcall hangcheck_init+0x0/0xb0 returned 0 after 1198 usecs
[    2.923695] calling  init_tis+0x0/0x143 @ 1
[    2.925097] initcall init_tis+0x0/0x143 returned 0 after 184 usecs
[    2.926330] calling  drm_kms_helper_init+0x0/0x14 @ 1
[    2.927627] initcall drm_kms_helper_init+0x0/0x14 returned 0 after 81 usecs
[    2.928854] calling  drm_core_init+0x0/0xdc @ 1
[    2.930196] initcall drm_core_init+0x0/0xdc returned 0 after 131 usecs
[    2.931423] calling  i915_init+0x0/0xa6 @ 1
[    2.943680] checking generic (b0000000 180000) vs hw (b0000000 10000000)
[    2.944932] fb0: switching to inteldrmfb from simple
[    2.946318] Console: switching to colour dummy device 80x25
[    2.946965] [drm] Replacing VGA console driver
[    2.947048] pmd_set_huge: Cannot satisfy [mem 0xb0000000-0xb0200000] with a huge-page mapping due to MTRR override.
[    2.955566] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.955604] [drm] Driver supports precise vblank timestamp query.
[    2.962683] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.054760] [drm] Initialized i915 1.6.0 20181204 for 0000:00:02.0 on minor 0
[    3.057281] probe of LNXVIDEO:00 returned 0 after 315 usecs
[    3.062100] ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
[    3.092466] acpi device:04: registered as cooling_device4
[    3.094340] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input6
[    3.102054] ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
[    3.131838] acpi device:04: registered as cooling_device4
[    3.133656] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input7
[    3.133819] probe of LNXVIDEO:01 returned 1 after 76503 usecs
[    3.149758] fbcon: inteldrmfb (fb0) is primary device
[    3.583614] Console: switching to colour frame buffer device 170x48
[    3.600367] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.600837] Console: switching to colour dummy device 80x25
[    3.646125] ==================================================================
[    3.646173] BUG: KASAN: use-after-free in intel_hdmi_destroy+0x79/0x80
[    3.646203] Read of size 8 at addr ffff88811b63b630 by task kworker/3:1/35

[    3.646247] CPU: 3 PID: 35 Comm: kworker/3:1 Not tainted 5.0.0-rc7mod #3
[    3.646276] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[    3.646315] Workqueue: events drm_connector_free_work_fn
[    3.646340] Call Trace:
[    3.646361]  dump_stack+0x7b/0xb5
[    3.646385]  print_address_description+0x6e/0x360
[    3.646416]  kasan_report+0x11a/0x198
[    3.646437]  ? __kasan_slab_free+0x14e/0x190
[    3.646458]  ? intel_hdmi_destroy+0x79/0x80
[    3.646484]  ? intel_hdmi_destroy+0x79/0x80
[    3.646509]  __asan_report_load8_noabort+0x14/0x20
[    3.646533]  intel_hdmi_destroy+0x79/0x80
[    3.646557]  drm_connector_free_work_fn+0xd0/0x100
[    3.646585]  process_one_work+0x9fb/0x1710
[    3.646617]  ? cancel_delayed_work_sync+0x10/0x10
[    3.646655]  worker_thread+0x6ca/0xee0
[    3.646676]  ? do_raw_spin_unlock+0x54/0x220
[    3.646712]  kthread+0x349/0x410
[    3.646731]  ? process_one_work+0x1710/0x1710
[    3.646753]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[    3.646782]  ret_from_fork+0x35/0x40

[    3.646828] Allocated by task 1:
[    3.646847]  save_stack+0x43/0xd0
[    3.646865]  __kasan_kmalloc.constprop.8+0xa7/0xd0
[    3.646888]  kasan_kmalloc+0x9/0x10
[    3.646908]  intel_hdmi_init+0x65/0x950
[    3.646928]  intel_setup_outputs+0x1247/0x18d0
[    3.646950]  intel_modeset_init+0x12c7/0x4450
[    3.646973]  i915_driver_load+0x1926/0x3430
[    3.646994]  i915_pci_probe+0xdf/0x150
[    3.647016]  local_pci_probe+0xdd/0x190
[    3.647035]  pci_device_probe+0x465/0x7e0
[    3.647057]  really_probe+0x15f/0xd40
[    3.647069]  driver_probe_device+0xe9/0x3a0
[    3.647069]  __driver_attach+0x294/0x360
[    3.647069]  bus_for_each_dev+0x116/0x1b0
[    3.647069]  driver_attach+0x38/0x50
[    3.647069]  bus_add_driver+0x3f5/0x730
[    3.647069]  driver_register+0x18e/0x410
[    3.647069]  __pci_register_driver+0x187/0x240
[    3.647069]  i915_init+0xa1/0xa6
[    3.647069]  do_one_initcall+0xab/0x2ad
[    3.647069]  kernel_init_freeable+0x63c/0x6f2
[    3.647069]  kernel_init+0xe/0x140
[    3.647069]  ret_from_fork+0x35/0x40

[    3.647069] Freed by task 1:
[    3.647069]  save_stack+0x43/0xd0
[    3.647069]  __kasan_slab_free+0x137/0x190
[    3.647069]  kasan_slab_free+0xe/0x10
[    3.647069]  kfree+0xb0/0x1b0
[    3.647069]  intel_encoder_destroy+0x15/0x20
[    3.647069]  drm_mode_config_cleanup+0x10e/0x8d0
[    3.647069]  intel_modeset_cleanup+0x19c/0x290
[    3.647069]  i915_driver_unload+0xda/0x1d0
[    3.647069]  i915_pci_remove+0x3e/0x90
[    3.647069]  pci_device_remove+0x103/0x310
[    3.647069]  really_probe+0x1a5/0xd40
[    3.647069]  driver_probe_device+0xe9/0x3a0
[    3.647069]  __driver_attach+0x294/0x360
[    3.647069]  bus_for_each_dev+0x116/0x1b0
[    3.647069]  driver_attach+0x38/0x50
[    3.647069]  bus_add_driver+0x3f5/0x730
[    3.647069]  driver_register+0x18e/0x410
[    3.647069]  __pci_register_driver+0x187/0x240
[    3.647069]  i915_init+0xa1/0xa6
[    3.647069]  do_one_initcall+0xab/0x2ad
[    3.647069]  kernel_init_freeable+0x63c/0x6f2
[    3.647069]  kernel_init+0xe/0x140
[    3.647069]  ret_from_fork+0x35/0x40

[    3.647069] The buggy address belongs to the object at ffff88811b63a168
                which belongs to the cache kmalloc-8k of size 8192
[    3.647069] The buggy address is located 5320 bytes inside of
                8192-byte region [ffff88811b63a168, ffff88811b63c168)
[    3.647069] The buggy address belongs to the page:
[    3.647069] page:ffffea00046d8e00 count:1 mapcount:0 mapping:ffff888107c118c0 index:0x0 compound_mapcount: 0
[    3.647069] flags: 0x17ffffc0010200(slab|head)
[    3.647069] raw: 0017ffffc0010200 ffffea00046d4208 ffff888107c02ff0 ffff888107c118c0
[    3.647069] raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
[    3.647069] page dumped because: kasan: bad access detected

[    3.647069] Memory state around the buggy address:
[    3.647069]  ffff88811b63b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[    3.647069]  ffff88811b63b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[    3.647069] >ffff88811b63b600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[    3.647069]                                      ^
[    3.647069]  ffff88811b63b680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[    3.647069]  ffff88811b63b700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[    3.647069] ==================================================================
[    3.647069] Disabling lock debugging due to kernel taint
[    3.740859] [drm] Replacing VGA console driver
[    3.749847] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.749865] [drm] Driver supports precise vblank timestamp query.
[    3.838342] [drm] Initialized i915 1.6.0 20181204 for 0000:00:02.0 on minor 0
[    3.840245] probe of LNXVIDEO:00 returned 0 after 244 usecs
[    3.844479] ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
[    3.869971] acpi device:04: registered as cooling_device4
[    3.871578] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input8
[    3.877956] ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
[    3.903990] acpi device:04: registered as cooling_device4
[    3.905580] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input9
[    3.905697] probe of LNXVIDEO:01 returned 1 after 65434 usecs
[    3.905913] probe of 0000:00:02.0 returned 1 after 973253 usecs
[    3.906323] initcall i915_init+0x0/0xa6 returned 0 after 950868 usecs
[    3.906339] calling  cn_proc_init+0x0/0x36 @ 1
[    3.906357] initcall cn_proc_init+0x0/0x36 returned 0 after 7 usecs
[    3.906369] calling  _nvm_misc_init+0x0/0x12 @ 1
[    3.906790] initcall _nvm_misc_init+0x0/0x12 returned 0 after 397 usecs
[    3.906805] calling  topology_sysfs_init+0x0/0x30 @ 1
[    3.906999] initcall topology_sysfs_init+0x0/0x30 returned 0 after 178 usecs
[    3.907013] calling  cacheinfo_sysfs_init+0x0/0x2d @ 1
[    3.910467] initcall cacheinfo_sysfs_init+0x0/0x2d returned 176 after 3355 usecs
[    3.910490] calling  devcoredump_init+0x0/0x19 @ 1
[    3.910556] initcall devcoredump_init+0x0/0x19 returned 0 after 52 usecs
[    3.910570] calling  xlblk_init+0x0/0x1bc @ 1
[    3.910581] initcall xlblk_init+0x0/0x1bc returned -19 after 0 usecs
[    3.910593] calling  htcpld_core_init+0x0/0x2d @ 1
[    3.910782] initcall htcpld_core_init+0x0/0x2d returned -19 after 173 usecs
[    3.910796] calling  tps68470_driver_init+0x0/0x14 @ 1
[    3.910871] initcall tps68470_driver_init+0x0/0x14 returned 0 after 62 usecs
[    3.910885] calling  twl_driver_init+0x0/0x14 @ 1
[    3.910967] initcall twl_driver_init+0x0/0x14 returned 0 after 69 usecs
[    3.910980] calling  twl4030_audio_driver_init+0x0/0x14 @ 1
[    3.911056] initcall twl4030_audio_driver_init+0x0/0x14 returned 0 after 62 usecs
[    3.911070] calling  twl6040_driver_init+0x0/0x14 @ 1
[    3.911143] initcall twl6040_driver_init+0x0/0x14 returned 0 after 59 usecs
[    3.911156] calling  smsc_i2c_driver_init+0x0/0x14 @ 1
[    3.911238] initcall smsc_i2c_driver_init+0x0/0x14 returned 0 after 68 usecs
[    3.911251] calling  max77620_driver_init+0x0/0x14 @ 1
[    3.911328] initcall max77620_driver_init+0x0/0x14 returned 0 after 63 usecs
[    3.911341] calling  ab3100_otp_driver_init+0x0/0x1b @ 1
[    3.911461] initcall ab3100_otp_driver_init+0x0/0x1b returned -19 after 104 usecs
[    3.911476] calling  adp5520_driver_init+0x0/0x14 @ 1
[    3.911564] initcall adp5520_driver_init+0x0/0x14 returned 0 after 75 usecs
[    3.911578] calling  intel_soc_pmic_i2c_driver_init+0x0/0x14 @ 1
[    3.911662] initcall intel_soc_pmic_i2c_driver_init+0x0/0x14 returned 0 after 69 usecs
[    3.911677] calling  cht_wc_driver_init+0x0/0x14 @ 1
[    3.911752] initcall cht_wc_driver_init+0x0/0x14 returned 0 after 61 usecs
[    3.911765] calling  udmabuf_dev_init+0x0/0x12 @ 1
[    3.912270] initcall udmabuf_dev_init+0x0/0x12 returned 0 after 479 usecs
[    3.912287] calling  init_sd+0x0/0x234 @ 1
[    3.913097] initcall init_sd+0x0/0x234 returned 0 after 778 usecs
[    3.913112] calling  nvme_core_init+0x0/0x15e @ 1
[    3.914763] initcall nvme_core_init+0x0/0x15e returned 0 after 1598 usecs
[    3.914781] calling  nvme_init+0x0/0x1b @ 1
[    3.914931] initcall nvme_init+0x0/0x1b returned 0 after 135 usecs
[    3.914945] calling  ahci_pci_driver_init+0x0/0x1b @ 1
[    3.915058] ahci 0000:00:1f.2: version 3.0
[    3.919440] fbcon: inteldrmfb (fb0) is primary device
[    3.921287] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    3.931511] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0xd impl SATA mode
[    3.931518] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems sxs apst 
[    3.947286] scsi host0: ahci
[    3.949207] scsi host1: ahci
[    3.950699] scsi host2: ahci
[    3.952021] scsi host3: ahci
[    3.953585] scsi host4: ahci
[    3.955097] scsi host5: ahci
[    3.955883] ata1: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827100 irq 25
[    3.955886] ata2: DUMMY
[    3.955890] ata3: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827200 irq 25
[    3.955893] ata4: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827280 irq 25
[    3.955895] ata5: DUMMY
[    3.955896] ata6: DUMMY
[    3.956016] probe of 0000:00:1f.2 returned 1 after 41014 usecs
[    3.956229] initcall ahci_pci_driver_init+0x0/0x1b returned 0 after 40201 usecs
[    3.956235] calling  net_olddevs_init+0x0/0x62 @ 1
[    3.956244] initcall net_olddevs_init+0x0/0x62 returned 0 after 4 usecs
[    3.956247] calling  netif_init+0x0/0xd1 @ 1
[    3.956250] initcall netif_init+0x0/0xd1 returned -19 after 0 usecs
[    3.956253] calling  ehci_hcd_init+0x0/0xf5 @ 1
[    3.956255] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.956288] initcall ehci_hcd_init+0x0/0xf5 returned 0 after 30 usecs
[    3.956291] calling  ehci_pci_init+0x0/0x67 @ 1
[    3.956293] ehci-pci: EHCI PCI platform driver
[    3.961989] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    3.962063] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    3.962103] ehci-pci 0000:00:1a.0: debug port 2
[    3.966274] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    3.966433] ehci-pci 0000:00:1a.0: irq 16, io mem 0xc4829000
[    3.973562] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.974388] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    3.974392] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.974394] usb usb1: Product: EHCI Host Controller
[    3.974397] usb usb1: Manufacturer: Linux 5.0.0-rc7mod ehci_hcd
[    3.974400] usb usb1: SerialNumber: 0000:00:1a.0
[    3.975737] hub 1-0:1.0: USB hub found
[    3.975843] hub 1-0:1.0: 3 ports detected
[    3.977513] hub 1-0:1.0: USB hub found
[    3.977613] hub 1-0:1.0: 3 ports detected
[    3.978912] probe of 1-0:1.0 returned 1 after 3245 usecs
[    3.980117] hub 1-0:1.0: USB hub found
[    3.980343] hub 1-0:1.0: 3 ports detected
[    3.981797] hub 1-0:1.0: USB hub found
[    3.981897] hub 1-0:1.0: 3 ports detected
[    3.983117] probe of 1-0:1.0 returned 1 after 3062 usecs
[    3.983341] probe of usb1 returned 1 after 8018 usecs
[    3.983582] ehci-pci 0000:00:1a.0: remove, state 1
[    3.983598] usb usb1: USB disconnect, device number 1
[    3.988998] ehci-pci 0000:00:1a.0: USB bus 1 deregistered
[    4.000302] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    4.000368] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    4.000419] ehci-pci 0000:00:1a.0: debug port 2
[    4.004426] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    4.004465] ehci-pci 0000:00:1a.0: irq 16, io mem 0xc4829000
[    4.011561] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    4.012338] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    4.012342] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.012345] usb usb1: Product: EHCI Host Controller
[    4.012347] usb usb1: Manufacturer: Linux 5.0.0-rc7mod ehci_hcd
[    4.012350] usb usb1: SerialNumber: 0000:00:1a.0
[    4.013725] hub 1-0:1.0: USB hub found
[    4.013829] hub 1-0:1.0: 3 ports detected
[    4.015469] hub 1-0:1.0: USB hub found
[    4.015578] hub 1-0:1.0: 3 ports detected
[    4.016842] probe of 1-0:1.0 returned 1 after 3185 usecs
[    4.018029] hub 1-0:1.0: USB hub found
[    4.018254] hub 1-0:1.0: 3 ports detected
[    4.019735] hub 1-0:1.0: USB hub found
[    4.019836] hub 1-0:1.0: 3 ports detected
[    4.021057] probe of 1-0:1.0 returned 1 after 3090 usecs
[    4.021268] probe of usb1 returned 1 after 7944 usecs
[    4.021638] probe of 0000:00:1a.0 returned 1 after 65315 usecs
[    4.027625] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    4.027682] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    4.027721] ehci-pci 0000:00:1d.0: debug port 2
[    4.031726] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    4.031848] ehci-pci 0000:00:1d.0: irq 23, io mem 0xc4828000
[    4.038528] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    4.039192] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    4.039196] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.039199] usb usb2: Product: EHCI Host Controller
[    4.039202] usb usb2: Manufacturer: Linux 5.0.0-rc7mod ehci_hcd
[    4.039204] usb usb2: SerialNumber: 0000:00:1d.0
[    4.040557] hub 2-0:1.0: USB hub found
[    4.040668] hub 2-0:1.0: 3 ports detected
[    4.042244] hub 2-0:1.0: USB hub found
[    4.042344] hub 2-0:1.0: 3 ports detected
[    4.043480] probe of 2-0:1.0 returned 1 after 2992 usecs
[    4.044776] hub 2-0:1.0: USB hub found
[    4.044882] hub 2-0:1.0: 3 ports detected
[    4.046467] hub 2-0:1.0: USB hub found
[    4.046566] hub 2-0:1.0: 3 ports detected
[    4.047707] probe of 2-0:1.0 returned 1 after 2994 usecs
[    4.047923] probe of usb2 returned 1 after 7894 usecs
[    4.048269] ehci-pci 0000:00:1d.0: remove, state 1
[    4.048286] usb usb2: USB disconnect, device number 1
[    4.053441] ehci-pci 0000:00:1d.0: USB bus 2 deregistered
[    4.064994] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    4.065051] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    4.065089] ehci-pci 0000:00:1d.0: debug port 2
[    4.069079] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    4.069197] ehci-pci 0000:00:1d.0: irq 23, io mem 0xc4828000
[    4.075541] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    4.076188] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    4.076193] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.076195] usb usb2: Product: EHCI Host Controller
[    4.076198] usb usb2: Manufacturer: Linux 5.0.0-rc7mod ehci_hcd
[    4.076201] usb usb2: SerialNumber: 0000:00:1d.0
[    4.077427] hub 2-0:1.0: USB hub found
[    4.077543] hub 2-0:1.0: 3 ports detected
[    4.079081] hub 2-0:1.0: USB hub found
[    4.079189] hub 2-0:1.0: 3 ports detected
[    4.080311] probe of 2-0:1.0 returned 1 after 2973 usecs
[    4.081528] hub 2-0:1.0: USB hub found
[    4.081626] hub 2-0:1.0: 3 ports detected
[    4.083085] hub 2-0:1.0: USB hub found
[    4.083183] hub 2-0:1.0: 3 ports detected
[    4.084276] probe of 2-0:1.0 returned 1 after 2829 usecs
[    4.084521] probe of usb2 returned 1 after 7484 usecs
[    4.084919] probe of 0000:00:1d.0 returned 1 after 63267 usecs
[    4.085006] initcall ehci_pci_init+0x0/0x67 returned 0 after 125689 usecs
[    4.085011] calling  uhci_hcd_init+0x0/0x148 @ 1
[    4.085013] uhci_hcd: USB Universal Host Controller Interface driver
[    4.085679] initcall uhci_hcd_init+0x0/0x148 returned 0 after 646 usecs
[    4.085682] calling  xhci_hcd_init+0x0/0x1f @ 1
[    4.085703] initcall xhci_hcd_init+0x0/0x1f returned 0 after 16 usecs
[    4.085706] calling  xhci_pci_init+0x0/0x44 @ 1
[    4.087034] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    4.087086] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 3
[    4.087503] xhci_hcd 0000:05:00.0: hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000004
[    4.090263] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    4.090266] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.090269] usb usb3: Product: xHCI Host Controller
[    4.090272] usb usb3: Manufacturer: Linux 5.0.0-rc7mod xhci-hcd
[    4.090274] usb usb3: SerialNumber: 0000:05:00.0
[    4.091512] hub 3-0:1.0: USB hub found
[    4.091624] hub 3-0:1.0: 2 ports detected
[    4.092616] hub 3-0:1.0: USB hub found
[    4.092720] hub 3-0:1.0: 2 ports detected
[    4.093464] probe of 3-0:1.0 returned 1 after 2020 usecs
[    4.094525] hub 3-0:1.0: USB hub found
[    4.094635] hub 3-0:1.0: 2 ports detected
[    4.095560] hub 3-0:1.0: USB hub found
[    4.095662] hub 3-0:1.0: 2 ports detected
[    4.096373] probe of 3-0:1.0 returned 1 after 1909 usecs
[    4.096607] probe of usb3 returned 1 after 5493 usecs
[    4.096833] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    4.096870] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 4
[    4.096894] xhci_hcd 0000:05:00.0: Host supports USB 3.0  SuperSpeed
[    4.097081] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.097519] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.00
[    4.097523] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.097525] usb usb4: Product: xHCI Host Controller
[    4.097528] usb usb4: Manufacturer: Linux 5.0.0-rc7mod xhci-hcd
[    4.097531] usb usb4: SerialNumber: 0000:05:00.0
[    4.098672] hub 4-0:1.0: USB hub found
[    4.098786] hub 4-0:1.0: 2 ports detected
[    4.099861] hub 4-0:1.0: USB hub found
[    4.099963] hub 4-0:1.0: 2 ports detected
[    4.100731] probe of 4-0:1.0 returned 1 after 2137 usecs
[    4.101956] hub 4-0:1.0: USB hub found
[    4.102057] hub 4-0:1.0: 2 ports detected
[    4.103082] hub 4-0:1.0: USB hub found
[    4.103183] hub 4-0:1.0: 2 ports detected
[    4.103960] probe of 4-0:1.0 returned 1 after 2065 usecs
[    4.104178] probe of usb4 returned 1 after 5939 usecs
[    4.104353] xhci_hcd 0000:05:00.0: remove, state 1
[    4.104369] usb usb4: USB disconnect, device number 1
[    4.105510] xhci_hcd 0000:05:00.0: USB bus 4 deregistered
[    4.105529] xhci_hcd 0000:05:00.0: remove, state 1
[    4.105543] usb usb3: USB disconnect, device number 1
[    4.115832] xhci_hcd 0000:05:00.0: USB bus 3 deregistered
[    4.118209] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    4.118257] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 3
[    4.118727] xhci_hcd 0000:05:00.0: hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000004
[    4.121847] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    4.121851] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.121854] usb usb3: Product: xHCI Host Controller
[    4.121856] usb usb3: Manufacturer: Linux 5.0.0-rc7mod xhci-hcd
[    4.121859] usb usb3: SerialNumber: 0000:05:00.0
[    4.123097] hub 3-0:1.0: USB hub found
[    4.123213] hub 3-0:1.0: 2 ports detected
[    4.124252] hub 3-0:1.0: USB hub found
[    4.124355] hub 3-0:1.0: 2 ports detected
[    4.125072] probe of 3-0:1.0 returned 1 after 2042 usecs
[    4.126142] hub 3-0:1.0: USB hub found
[    4.126245] hub 3-0:1.0: 2 ports detected
[    4.127178] hub 3-0:1.0: USB hub found
[    4.127280] hub 3-0:1.0: 2 ports detected
[    4.128213] probe of 3-0:1.0 returned 1 after 2133 usecs
[    4.128456] probe of usb3 returned 1 after 5752 usecs
[    4.128742] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    4.128784] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 4
[    4.128810] xhci_hcd 0000:05:00.0: Host supports USB 3.0  SuperSpeed
[    4.128985] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.129365] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.00
[    4.129368] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.129371] usb usb4: Product: xHCI Host Controller
[    4.129374] usb usb4: Manufacturer: Linux 5.0.0-rc7mod xhci-hcd
[    4.129376] usb usb4: SerialNumber: 0000:05:00.0
[    4.130547] hub 4-0:1.0: USB hub found
[    4.130652] hub 4-0:1.0: 2 ports detected
[    4.131734] hub 4-0:1.0: USB hub found
[    4.131836] hub 4-0:1.0: 2 ports detected
[    4.132588] probe of 4-0:1.0 returned 1 after 2107 usecs
[    4.133792] hub 4-0:1.0: USB hub found
[    4.133892] hub 4-0:1.0: 2 ports detected
[    4.134937] hub 4-0:1.0: USB hub found
[    4.135039] hub 4-0:1.0: 2 ports detected
[    4.135798] probe of 4-0:1.0 returned 1 after 2067 usecs
[    4.136016] probe of usb4 returned 1 after 5914 usecs
[    4.136229] probe of 0000:05:00.0 returned 1 after 50492 usecs
[    4.136305] initcall xhci_pci_init+0x0/0x44 returned 0 after 49403 usecs
[    4.136309] calling  ledtrig_usb_init+0x0/0x2e @ 1
[    4.136327] initcall ledtrig_usb_init+0x0/0x2e returned 0 after 13 usecs
[    4.136330] calling  i8042_init+0x0/0x5d2 @ 1
[    4.136455] probe of 00:05 returned 1 after 92 usecs
[    4.136589] probe of 00:06 returned 1 after 76 usecs
[    4.136625] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    4.139086] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.139380] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.139475] probe of i8042 returned 1 after 2505 usecs
[    4.139547] initcall i8042_init+0x0/0x5d2 returned 0 after 3134 usecs
[    4.139553] calling  atkbd_init+0x0/0x27 @ 1
[    4.139697] initcall atkbd_init+0x0/0x27 returned 0 after 133 usecs
[    4.139703] calling  psmouse_init+0x0/0x8e @ 1
[    4.140037] initcall psmouse_init+0x0/0x8e returned 0 after 320 usecs
[    4.140043] calling  da9034_touch_driver_init+0x0/0x14 @ 1
[    4.140131] initcall da9034_touch_driver_init+0x0/0x14 returned 0 after 80 usecs
[    4.140134] calling  xenkbd_init+0x0/0x9f @ 1
[    4.140138] initcall xenkbd_init+0x0/0x9f returned -19 after 0 usecs
[    4.140141] calling  ab3100_rtc_driver_init+0x0/0x1b @ 1
[    4.140267] initcall ab3100_rtc_driver_init+0x0/0x1b returned -19 after 118 usecs
[    4.140271] calling  gpio_poweroff_driver_init+0x0/0x14 @ 1
[    4.140347] initcall gpio_poweroff_driver_init+0x0/0x14 returned 0 after 69 usecs
[    4.140350] calling  gpio_restart_driver_init+0x0/0x14 @ 1
[    4.140437] initcall gpio_restart_driver_init+0x0/0x14 returned 0 after 80 usecs
[    4.140441] calling  ltc2952_poweroff_driver_init+0x0/0x14 @ 1
[    4.140512] initcall ltc2952_poweroff_driver_init+0x0/0x14 returned 0 after 65 usecs
[    4.140515] calling  restart_poweroff_driver_init+0x0/0x14 @ 1
[    4.140583] initcall restart_poweroff_driver_init+0x0/0x14 returned 0 after 62 usecs
[    4.140587] calling  syscon_reboot_driver_init+0x0/0x14 @ 1
[    4.140664] initcall syscon_reboot_driver_init+0x0/0x14 returned 0 after 70 usecs
[    4.140667] calling  syscon_poweroff_register+0x0/0x14 @ 1
[    4.140743] initcall syscon_poweroff_register+0x0/0x14 returned 0 after 69 usecs
[    4.140746] calling  watchdog_gov_noop_register+0x0/0x12 @ 1
[    4.140757] initcall watchdog_gov_noop_register+0x0/0x12 returned 0 after 6 usecs
[    4.140760] calling  virtual_eisa_root_init+0x0/0x48 @ 1
[    4.140918] platform eisa.0: Probing EISA bus 0
[    4.140932] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    4.140946] platform eisa.0: Cannot allocate resource for EISA slot 1
[    4.140959] platform eisa.0: Cannot allocate resource for EISA slot 2
[    4.140972] platform eisa.0: Cannot allocate resource for EISA slot 3
[    4.140984] platform eisa.0: Cannot allocate resource for EISA slot 4
[    4.140996] platform eisa.0: Cannot allocate resource for EISA slot 5
[    4.141008] platform eisa.0: Cannot allocate resource for EISA slot 6
[    4.141020] platform eisa.0: Cannot allocate resource for EISA slot 7
[    4.141040] platform eisa.0: Cannot allocate resource for EISA slot 8
[    4.141044] platform eisa.0: EISA: Detected 0 cards
[    4.141048] initcall virtual_eisa_root_init+0x0/0x48 returned 0 after 278 usecs
[    4.141050] calling  intel_pstate_init+0x0/0x11b @ 1
[    4.141057] intel_pstate: Intel P-state driver initializing
[    4.141866] initcall intel_pstate_init+0x0/0x11b returned 0 after 792 usecs
[    4.141868] calling  ledtrig_disk_init+0x0/0x54 @ 1
[    4.141900] initcall ledtrig_disk_init+0x0/0x54 returned 0 after 28 usecs
[    4.141902] calling  ledtrig_mtd_init+0x0/0x2e @ 1
[    4.141914] initcall ledtrig_mtd_init+0x0/0x2e returned 0 after 9 usecs
[    4.141916] calling  ledtrig_cpu_init+0x0/0x18f @ 1
[    4.142085] ledtrig-cpu: registered to indicate activity on CPUs
[    4.142089] initcall ledtrig_cpu_init+0x0/0x18f returned 0 after 164 usecs
[    4.142091] calling  ledtrig_panic_init+0x0/0x5c @ 1
[    4.142102] initcall ledtrig_panic_init+0x0/0x5c returned 0 after 7 usecs
[    4.142106] calling  efivars_sysfs_init+0x0/0x4f0 @ 1
[    4.142109] initcall efivars_sysfs_init+0x0/0x4f0 returned -19 after 0 usecs
[    4.142119] calling  esrt_sysfs_init+0x0/0x4b6 @ 1
[    4.142122] initcall esrt_sysfs_init+0x0/0x4b6 returned -38 after 0 usecs
[    4.142124] calling  pmc_core_probe+0x0/0x43c @ 1
[    4.142127] initcall pmc_core_probe+0x0/0x43c returned -19 after 0 usecs
[    4.142129] calling  pmc_atom_init+0x0/0x3eb @ 1
[    4.142146] initcall pmc_atom_init+0x0/0x3eb returned -19 after 14 usecs
[    4.142149] calling  extcon_class_init+0x0/0x18 @ 1
[    4.142193] initcall extcon_class_init+0x0/0x18 returned 0 after 40 usecs
[    4.142196] calling  powercap_init+0x0/0x904 @ 1
[    4.142532] initcall powercap_init+0x0/0x904 returned 0 after 324 usecs
[    4.142535] calling  binder_init+0x0/0x513 @ 1
[    4.143253] probe of serio1 returned 0 after 3437 usecs
[    4.143400] initcall binder_init+0x0/0x513 returned 0 after 839 usecs
[    4.143406] calling  pm_check_save_msr+0x0/0x20 @ 1
[    4.143421] initcall pm_check_save_msr+0x0/0x20 returned 0 after 0 usecs
[    4.143424] calling  sock_diag_init+0x0/0x4a @ 1
[    4.143519] initcall sock_diag_init+0x0/0x4a returned 0 after 88 usecs
[    4.143522] calling  blackhole_init+0x0/0x12 @ 1
[    4.143527] initcall blackhole_init+0x0/0x12 returned 0 after 1 usecs
[    4.143529] calling  gre_offload_init+0x0/0x49 @ 1
[    4.143532] initcall gre_offload_init+0x0/0x49 returned 0 after 0 usecs
[    4.143534] calling  bpfilter_sockopt_init+0x0/0x3f @ 1
[    4.143537] initcall bpfilter_sockopt_init+0x0/0x3f returned 0 after 0 usecs
[    4.143539] calling  sysctl_ipv4_init+0x0/0x4c @ 1
[    4.143644] initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 99 usecs
[    4.143646] calling  cubictcp_register+0x0/0x11f @ 1
[    4.143650] initcall cubictcp_register+0x0/0x11f returned 0 after 1 usecs
[    4.143652] calling  unix_diag_init+0x0/0x12 @ 1
[    4.143655] initcall unix_diag_init+0x0/0x12 returned 0 after 0 usecs
[    4.143657] calling  inet6_init+0x0/0x416 @ 1
[    4.146351] NET: Registered protocol family 10
[    4.152736] Segment Routing with IPv6
[    4.152839] initcall inet6_init+0x0/0x416 returned 0 after 8958 usecs
[    4.152842] calling  strp_mod_init+0x0/0x3a @ 1
[    4.153026] initcall strp_mod_init+0x0/0x3a returned 0 after 173 usecs
[    4.153030] calling  dcbnl_init+0x0/0x4d @ 1
[    4.153055] initcall dcbnl_init+0x0/0x4d returned 0 after 21 usecs
[    4.153058] calling  plist_test+0x0/0x401 @ 1
[    4.153059] start plist test
[    4.155490] end plist test
[    4.155494] initcall plist_test+0x0/0x401 returned 0 after 2375 usecs
[    4.155497] calling  mcheck_init_device+0x0/0x1fb @ 1
[    4.156684] initcall mcheck_init_device+0x0/0x1fb returned 0 after 1153 usecs
[    4.156689] calling  dev_mcelog_init_device+0x0/0x4b @ 1
[    4.156917] initcall dev_mcelog_init_device+0x0/0x4b returned 0 after 211 usecs
[    4.157041] calling  tboot_late_init+0x0/0x4fa @ 1
[    4.157044] initcall tboot_late_init+0x0/0x4fa returned 0 after 0 usecs
[    4.157046] calling  mcheck_late_init+0x0/0x75 @ 1
[    4.157145] RAS: Correctable Errors collector initialized.
[    4.157148] initcall mcheck_late_init+0x0/0x75 returned 0 after 96 usecs
[    4.157150] calling  severities_debugfs_init+0x0/0x3b @ 1
[    4.157164] initcall severities_debugfs_init+0x0/0x3b returned 0 after 11 usecs
[    4.157166] calling  threshold_init_device+0x0/0xc7 @ 1
[    4.157169] initcall threshold_init_device+0x0/0xc7 returned 0 after 0 usecs
[    4.157171] calling  microcode_init+0x0/0x2eb @ 1
[    4.157362] microcode: sig=0x206a7, pf=0x10, revision=0x23
[    4.157738] microcode: Microcode Update Driver: v2.2.
[    4.157741] initcall microcode_init+0x0/0x2eb returned 0 after 553 usecs
[    4.157744] calling  resctrl_late_init+0x0/0xc2f @ 1
[    4.157748] initcall resctrl_late_init+0x0/0xc2f returned -19 after 1 usecs
[    4.157750] calling  hpet_insert_resource+0x0/0x24 @ 1
[    4.157755] initcall hpet_insert_resource+0x0/0x24 returned 0 after 2 usecs
[    4.157758] calling  update_mp_table+0x0/0x16ff @ 1
[    4.157761] initcall update_mp_table+0x0/0x16ff returned 0 after 0 usecs
[    4.157764] calling  lapic_insert_resource+0x0/0x40 @ 1
[    4.157767] initcall lapic_insert_resource+0x0/0x40 returned 0 after 0 usecs
[    4.157769] calling  print_ICs+0x0/0x331 @ 1
[    4.157772] initcall print_ICs+0x0/0x331 returned 0 after 0 usecs
[    4.157774] calling  cpa_stats_init+0x0/0x4c @ 1
[    4.157804] initcall cpa_stats_init+0x0/0x4c returned 0 after 26 usecs
[    4.157806] calling  pat_memtype_list_init+0x0/0x6d @ 1
[    4.157821] initcall pat_memtype_list_init+0x0/0x6d returned 0 after 11 usecs
[    4.157824] calling  create_tlb_single_page_flush_ceiling+0x0/0x4c @ 1
[    4.157838] initcall create_tlb_single_page_flush_ceiling+0x0/0x4c returned 0 after 11 usecs
[    4.157841] calling  create_init_pkru_value+0x0/0x4c @ 1
[    4.157855] initcall create_init_pkru_value+0x0/0x4c returned 0 after 11 usecs
[    4.157859] calling  init_oops_id+0x0/0x40 @ 1
[    4.157863] initcall init_oops_id+0x0/0x40 returned 0 after 1 usecs
[    4.157866] calling  sched_clock_init_late+0x0/0x12c @ 1
[    4.157870] sched_clock: Marking stable (4151564641, 6131662)->(4173502945, -15806642)
[    4.158112] initcall sched_clock_init_late+0x0/0x12c returned 0 after 234 usecs
[    4.158114] calling  sched_init_debug+0x0/0x3e @ 1
[    4.158144] initcall sched_init_debug+0x0/0x3e returned 0 after 25 usecs
[    4.158147] calling  pm_qos_power_init+0x0/0x22d @ 1
[    4.158860] initcall pm_qos_power_init+0x0/0x22d returned 0 after 692 usecs
[    4.158863] calling  pm_debugfs_init+0x0/0x24 @ 1
[    4.158880] initcall pm_debugfs_init+0x0/0x24 returned 0 after 13 usecs
[    4.158883] calling  printk_late_init+0x0/0x20e @ 1
[    4.158886] initcall printk_late_init+0x0/0x20e returned 0 after 1 usecs
[    4.158889] calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
[    4.158912] initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 19 usecs
[    4.158915] calling  debugfs_kprobe_init+0x0/0x113 @ 1
[    4.158965] initcall debugfs_kprobe_init+0x0/0x113 returned 0 after 46 usecs
[    4.158968] calling  taskstats_init+0x0/0x37 @ 1
[    4.159011] registered taskstats version 1
[    4.159014] initcall taskstats_init+0x0/0x37 returned 0 after 42 usecs
[    4.159017] calling  load_system_certificate_list+0x0/0x217 @ 1
[    4.159018] Loading compiled-in X.509 certificates
[    4.159021] initcall load_system_certificate_list+0x0/0x217 returned 0 after 1 usecs
[    4.159024] calling  fault_around_debugfs+0x0/0x35 @ 1
[    4.159041] initcall fault_around_debugfs+0x0/0x35 returned 0 after 12 usecs
[    4.159043] calling  max_swapfiles_check+0x0/0x8 @ 1
[    4.159047] initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
[    4.159048] calling  init_zswap+0x0/0x4b6 @ 1
[    4.159833] zswap: default zpool zbud not available
[    4.159835] zswap: pool creation failed
[    4.160177] initcall init_zswap+0x0/0x4b6 returned 0 after 1096 usecs
[    4.160181] calling  split_huge_pages_debugfs+0x0/0x35 @ 1
[    4.160197] initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 12 usecs
[    4.160199] calling  pageowner_init+0x0/0x45 @ 1
[    4.160201] page_owner is disabled
[    4.160203] initcall pageowner_init+0x0/0x45 returned 0 after 1 usecs
[    4.160205] calling  check_early_ioremap_leak+0x0/0xd2 @ 1
[    4.160208] initcall check_early_ioremap_leak+0x0/0xd2 returned 0 after 0 usecs
[    4.160210] calling  cma_debugfs_init+0x0/0x3a7 @ 1
[    4.160226] initcall cma_debugfs_init+0x0/0x3a7 returned 0 after 12 usecs
[    4.160228] calling  init_percpu_stats_debugfs+0x0/0x24 @ 1
[    4.160243] initcall init_percpu_stats_debugfs+0x0/0x24 returned 0 after 11 usecs
[    4.160247] calling  pstore_init+0x0/0x15 @ 1
[    4.160263] initcall pstore_init+0x0/0x15 returned 0 after 12 usecs
[    4.160265] calling  init_root_keyring+0x0/0xb @ 1
[    4.160316] initcall init_root_keyring+0x0/0xb returned 0 after 46 usecs
[    4.160319] calling  init_encrypted+0x0/0x152 @ 1
[    4.161771] cryptomgr_test (142) used greatest stack depth: 28008 bytes left
[    4.161967] Key type encrypted registered
[    4.161972] initcall init_encrypted+0x0/0x152 returned 0 after 1609 usecs
[    4.161976] calling  prandom_reseed+0x0/0x52 @ 1
[    4.161990] initcall prandom_reseed+0x0/0x52 returned 0 after 10 usecs
[    4.161992] calling  init_error_injection+0x0/0x6f @ 1
[    4.166254] initcall init_error_injection+0x0/0x6f returned 0 after 4156 usecs
[    4.166257] calling  pci_resource_alignment_sysfs_init+0x0/0x19 @ 1
[    4.166272] initcall pci_resource_alignment_sysfs_init+0x0/0x19 returned 0 after 10 usecs
[    4.166274] calling  pci_sysfs_init+0x0/0x55 @ 1
[    4.167816] initcall pci_sysfs_init+0x0/0x55 returned 0 after 1502 usecs
[    4.167820] calling  bert_init+0x0/0x68b @ 1
[    4.167824] initcall bert_init+0x0/0x68b returned 0 after 1 usecs
[    4.167827] calling  clk_debug_init+0x0/0x140 @ 1
[    4.167888] initcall clk_debug_init+0x0/0x140 returned 0 after 56 usecs
[    4.167891] calling  boot_wait_for_devices+0x0/0x29 @ 1
[    4.167894] initcall boot_wait_for_devices+0x0/0x29 returned -19 after 0 usecs
[    4.167897] calling  dmar_free_unused_resources+0x0/0x1bd @ 1
[    4.167900] initcall dmar_free_unused_resources+0x0/0x1bd returned 0 after 0 usecs
[    4.167902] calling  deferred_probe_initcall+0x0/0xe0 @ 1
[    4.167974] initcall deferred_probe_initcall+0x0/0xe0 returned 0 after 66 usecs
[    4.167977] calling  genpd_power_off_unused+0x0/0xf4 @ 1
[    4.167980] initcall genpd_power_off_unused+0x0/0xf4 returned 0 after 0 usecs
[    4.167982] calling  genpd_debug_init+0x0/0x1e3 @ 1
[    4.168011] initcall genpd_debug_init+0x0/0x1e3 returned 0 after 25 usecs
[    4.168014] calling  sync_debugfs_init+0x0/0x5b @ 1
[    4.168052] initcall sync_debugfs_init+0x0/0x5b returned 0 after 34 usecs
[    4.168055] calling  init_netconsole+0x0/0x573 @ 1
[    4.230493] hub 1-0:1.0: activate --> -113
[    4.262073] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.264029] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.SAT0.PRT0._SDD.GTF0], AE_NOT_FOUND (20181213/psargs-330)
[    4.264071] ACPI Error: Method parse/execution failed \_SB.PCI0.SAT0.PRT0._SDD, AE_NOT_FOUND (20181213/psparse-531)
[    4.264255] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.SAT0.PRT0._GTF.GTF0], AE_NOT_FOUND (20181213/psargs-330)
[    4.264296] ACPI Error: Method parse/execution failed \_SB.PCI0.SAT0.PRT0._GTF, AE_NOT_FOUND (20181213/psparse-531)
[    4.264538] ata1.00: ATA-9: WDC WD10JPVX-60JC3T0, 01.01A01, max UDMA/133
[    4.264542] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.266589] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.SAT0.PRT0._SDD.GTF0], AE_NOT_FOUND (20181213/psargs-330)
[    4.266632] ACPI Error: Method parse/execution failed \_SB.PCI0.SAT0.PRT0._SDD, AE_NOT_FOUND (20181213/psparse-531)
[    4.266814] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.SAT0.PRT0._GTF.GTF0], AE_NOT_FOUND (20181213/psargs-330)
[    4.266858] ACPI Error: Method parse/execution failed \_SB.PCI0.SAT0.PRT0._GTF, AE_NOT_FOUND (20181213/psparse-531)
[    4.267100] ata1.00: configured for UDMA/133
[    4.294527] hub 2-0:1.0: activate --> -113
[    4.334596] hub 3-0:1.0: activate --> -113
[    4.344573] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    4.378864] Console: switching to colour frame buffer device 170x48
[    4.410442] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    4.411249] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    4.541038] usb 2-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    4.541534] usb 3-1: new full-speed USB device number 2 using xhci_hcd
[    4.542949] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.557884] usb 1-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    4.559028] hub 2-1:1.0: USB hub found
[    4.559488] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.561135] hub 2-1:1.0: 6 ports detected
[    4.563353] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10JPVX-60J 1A01 PQ: 0 ANSI: 5
[    4.566550] hub 1-1:1.0: USB hub found
[    4.567716] hub 2-1:1.0: USB hub found
[    4.567838] hub 2-1:1.0: 6 ports detected
[    4.570514] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    4.571291] probe of 2-1:1.0 returned 1 after 12318 usecs
[    4.573206] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    4.573234] hub 1-1:1.0: 6 ports detected
[    4.578337] hub 2-1:1.0: USB hub found
[    4.578513] sd 0:0:0:0: [sda] Write Protect is off
[    4.581223] hub 2-1:1.0: 6 ports detected
[    4.583254] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.591725] hub 2-1:1.0: USB hub found
[    4.593022] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.595474] hub 2-1:1.0: 6 ports detected
[    4.598279] hub 1-1:1.0: USB hub found
[    4.603254] probe of 2-1:1.0 returned 1 after 25008 usecs
[    4.604504] hub 1-1:1.0: 6 ports detected
[    4.606006] probe of 2-1 returned 1 after 47499 usecs
[    4.610752] probe of 1-1:1.0 returned 1 after 44330 usecs
[    4.712472] hub 2-1:1.0: hub_ext_port_status failed (err = -113)
[    4.715126] hub 1-1:1.0: USB hub found
[    4.725786]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
[    4.728877] hub 1-1:1.0: 6 ports detected
[    4.738360] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.742860] random: fast init done
[    4.822577] psmouse serio1: synaptics: queried max coordinates: x [..5710], y [..4732]
[    4.825849] hub 1-1:1.0: USB hub found
[    4.874513] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xd00073/0x240000/0xa0400/0x0, board id: 1514, fw id: 743503
[    4.874972] hub 1-1:1.0: 6 ports detected
[    4.875725] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[    4.875862] sd 0:0:0:0: [sda] Stopping disk
[    4.906982] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input11
[    4.911662] probe of 1-1:1.0 returned 1 after 196591 usecs
[    5.210486] printk: console [netcon0] enabled
[    5.210729] probe of 1-1 returned 1 after 647396 usecs
[    5.212380] netconsole: network logging started
[    5.216323] initcall init_netconsole+0x0/0x573 returned 0 after 1023689 usecs
[    5.217907] usb 3-1: New USB device found, idVendor=04a5, idProduct=9213, bcdDevice= 1.01
[    5.218247] calling  rtc_hctosys+0x0/0x1bb @ 1
[    5.220182] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.222149] hctosys: unable to open rtc device (rtc0)
[    5.224039] usb 3-1: Product: API USB KB HUB
[    5.224041] usb 3-1: Manufacturer: API
[    5.224043] usb 3-1: SerialNumber: 1234
[    5.229100] hub 3-1:1.0: USB hub found
[    5.229700] initcall rtc_hctosys+0x0/0x1bb returned -19 after 7370 usecs
[    5.229703] hub 1-1:1.0: hub_ext_port_status failed (err = -108)
[    5.234896] hub 3-1:1.0: 3 ports detected
[    5.235022] calling  charger_manager_init+0x0/0xb6 @ 1
[    5.240707] initcall charger_manager_init+0x0/0xb6 returned 0 after 326 usecs
[    5.242502] calling  firmware_memmap_init+0x0/0x5c @ 1
[    5.244951] initcall firmware_memmap_init+0x0/0x5c returned 0 after 567 usecs
[    5.246723] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[    5.248514] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 0 usecs
[    5.249190] hub 3-1:1.0: USB hub found
[    5.250417] calling  efi_shutdown_init+0x0/0x84 @ 1
[    5.254013] initcall efi_shutdown_init+0x0/0x84 returned -19 after 0 usecs
[    5.255840] calling  of_fdt_raw_init+0x0/0x167 @ 1
[    5.255893] hub 3-1:1.0: 3 ports detected
[    5.257712] initcall of_fdt_raw_init+0x0/0x167 returned 0 after 0 usecs
[    5.257717] calling  of_unittest+0x0/0x2e7c @ 1
[    5.263958] Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    5.270396] ### dt-test ### start of unittest - you will see error messages
[    5.272470] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    5.274367] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    5.276287] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    5.277934] probe of 3-1:1.0 returned 1 after 48885 usecs
[    5.278341] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    5.283905] OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
[    5.286113] OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
[    5.288183] hub 3-1:1.0: USB hub found
[    5.288570] OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    5.293644] OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    5.294865] hub 3-1:1.0: 3 ports detected
[    5.296286] OF: /testcase-data/phandle-tests/consumer-b: arguments longer than property
[    5.301496] probe of testcase-data:overlay-node:test-bus:test-unittest100 returned 1 after 300 usecs
[    5.305741] probe of testcase-data:overlay-node:test-bus:test-unittest1 returned 1 after 163 usecs
[    5.308010] probe of testcase-data:overlay-node:test-bus:test-unittest3 returned 1 after 156 usecs
[    5.310269] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
[    5.312609] probe of testcase-data:overlay-node:test-bus:test-unittest0 returned 1 after 171 usecs
[    5.314697] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
[    5.315183] hub 3-1:1.0: USB hub found
[    5.317069] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
[    5.321268] probe of testcase-data:overlay-node:test-bus:test-unittest2 returned 1 after 187 usecs
[    5.322896] hub 3-1:1.0: 3 ports detected
[    5.323525] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
[    5.328609] probe of testcase-data:overlay-node:test-bus:test-unittest4 returned 1 after 165 usecs
[    5.330966] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
[    5.333614] probe of testcase-data:overlay-node:test-bus:test-unittest5 returned 1 after 182 usecs
[    5.336141] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
[    5.339164] probe of testcase-data:overlay-node:test-bus:test-unittest6 returned 1 after 302 usecs
[    5.341831] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
[    5.344763] probe of testcase-data:overlay-node:test-bus:test-unittest7 returned 1 after 164 usecs
[    5.344938] probe of 3-1:1.0 returned 1 after 56838 usecs
[    5.349898] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
[    5.353606] probe of 3-1 returned 1 after 129117 usecs
[    5.358744] probe of testcase-data:overlay-node:test-bus:test-unittest8 returned 1 after 308 usecs
[    5.365567] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
[    5.368294] OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
[    5.371018] OF: overlay: overlay #6 is not topmost
[    5.375430] probe of testcase-data:overlay-node:test-bus:test-unittest10:test-unittest101 returned 1 after 196 usecs
[    5.378327] probe of testcase-data:overlay-node:test-bus:test-unittest10 returned 1 after 3369 usecs
[    5.382684] probe of testcase-data:overlay-node:test-bus:test-unittest11:test-unittest111 returned 1 after 206 usecs
[    5.385603] probe of testcase-data:overlay-node:test-bus:test-unittest11 returned 1 after 3441 usecs
[    5.389571] probe of 7-0009 returned 1 after 212 usecs
[    5.393391] probe of 7-0009 returned 1 after 172 usecs
[    5.396397] probe of testcase-data:overlay-node:test-bus:i2c-test-bus returned 1 after 7459 usecs
[    5.399514] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
[    5.402843] probe of 7-0008 returned 1 after 170 usecs
[    5.405773] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
[    5.412137] probe of testcase-data:overlay-node:test-bus:test-unittest3 returned 1 after 174 usecs
[    5.415809] probe of testcase-data:overlay-node:test-bus:test-unittest1 returned 1 after 190 usecs
[    5.419007] ### dt-test ### FAIL of_unittest_overlay_high_level():2372 overlay_base_root not initialized
[    5.422137] ### dt-test ### end of unittest - 218 passed, 1 failed
[    5.425128] initcall of_unittest+0x0/0x2e7c returned 0 after 158265 usecs
[    5.428120] calling  itmt_legacy_init+0x0/0x4b @ 1
[    5.431048] initcall itmt_legacy_init+0x0/0x4b returned -19 after 0 usecs
[    5.434182] calling  pci_mmcfg_late_insert_resources+0x0/0xb7 @ 1
[    5.437136] initcall pci_mmcfg_late_insert_resources+0x0/0xb7 returned 0 after 4 usecs
[    5.440115] calling  sch_default_qdisc+0x0/0x12 @ 1
[    5.440577] probe of 0:0:0:0 returned 1 after 870990 usecs
[    5.440838] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    5.440843] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    5.440892] sd 0:0:0:0: [sda] Write Protect is off
[    5.440897] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.440980] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.444148] initcall sch_default_qdisc+0x0/0x12 returned 0 after 1 usecs
[    5.464886] calling  tcp_congestion_default+0x0/0x19 @ 1
[    5.467727] initcall tcp_congestion_default+0x0/0x19 returned 0 after 1 usecs
[    5.470620] calling  ip_auto_config+0x0/0x12b @ 1
[    5.473438] initcall ip_auto_config+0x0/0x12b returned 0 after 66 usecs
[    5.476542] calling  software_resume+0x0/0x390 @ 1
[    5.538565] usb 1-1.5: new high-speed USB device number 3 using ehci-pci
[    5.637072] psmouse serio1: synaptics: queried max coordinates: x [..5710], y [..4732]
[    5.638466] usb 3-1.1: new full-speed USB device number 3 using xhci_hcd
[    5.690657] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xd00073/0x240000/0xa0400/0x0, board id: 1514, fw id: 743503
[    5.725714] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input12
[    5.730662] probe of serio1 returned 1 after 1587401 usecs
[    5.741048] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input13
[    5.752940] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input14
[    5.755489] probe of serio0 returned 1 after 22283 usecs
[    5.757228] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.762991] ata3.00: ATAPI: MATSHITADVD-RAM UJ8A2ES, 1.20, max UDMA/100
[    5.765409] usb 3-1.1: New USB device found, idVendor=04a5, idProduct=0001, bcdDevice= 1.01
[    5.767794] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.768200] ata3.00: configured for UDMA/100
[    5.770164] usb 3-1.1: Product: API USB KB HUB
[    5.770170] usb 3-1.1: Manufacturer: API
[    5.777143] usb 3-1.1: SerialNumber: 1234
[    5.778198] scsi 2:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ8A2ES  1.20 PQ: 0 ANSI: 5
[    5.792093] probe of serio1 returned 0 after 4459 usecs
[    5.794437] probe of 3-1.1 returned 1 after 13710 usecs
[    5.805115] probe of 2:0:0:0 returned 0 after 60 usecs
[    5.849926] usb 1-1.5: New USB device found, idVendor=0bda, idProduct=58f5, bcdDevice=12.13
[    5.852140] usb 1-1.5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    5.854200] usb 1-1.5: Product: 2SF001
[    5.856180] usb 1-1.5: Manufacturer: XZB4F2H6
[    5.858150] usb 1-1.5: SerialNumber: 0x0001
[    5.869549] usb 3-1.2: new low-speed USB device number 4 using xhci_hcd
[    5.886501] probe of 1-1.5 returned 1 after 25984 usecs
[    5.976181] usb 3-1.2: New USB device found, idVendor=049c, idProduct=0002, bcdDevice= 0.00
[    5.978128] usb 3-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.994506] probe of 3-1.2 returned 1 after 14005 usecs
[    6.068552] usb 3-1.3: new low-speed USB device number 5 using xhci_hcd
[    6.118045] ata4: SATA link down (SStatus 0 SControl 300)
[    6.190155] usb 3-1.3: New USB device found, idVendor=046d, idProduct=c016, bcdDevice= 3.40
[    6.192156] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.194032] usb 3-1.3: Product: Optical USB Mouse
[    6.195907] usb 3-1.3: Manufacturer: Logitech
[    6.212504] probe of 3-1.3 returned 1 after 14236 usecs
[    6.261762]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
[    6.267389] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.313039] initcall software_resume+0x0/0x390 returned -22 after 814212 usecs
[    6.315065] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x130 @ 1
[    6.316993] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x130 returned 0 after 0 usecs
[    6.318972] calling  clk_disable_unused+0x0/0x240 @ 1
[    6.320898] initcall clk_disable_unused+0x0/0x240 returned 0 after 1 usecs
[    6.322920] calling  regulator_init_complete+0x0/0x6a @ 1
[    6.324863] initcall regulator_init_complete+0x0/0x6a returned 0 after 4 usecs
[    6.458612] psmouse serio1: synaptics: queried max coordinates: x [..5710], y [..4732]
[    6.511009] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xd00073/0x240000/0xa0400/0x0, board id: 1514, fw id: 743503
[    6.545503] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input16
[    7.238224] psmouse serio1: synaptics: queried max coordinates: x [..5710], y [..4732]
[    7.290681] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xd00073/0x240000/0xa0400/0x0, board id: 1514, fw id: 743503
[    7.325087] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input17
[    7.329541] probe of serio1 returned 1 after 1534929 usecs
[    7.428664] EXT4-fs (sda8): mounted filesystem with ordered data mode. Opts: (null)
[    7.430755] VFS: Mounted root (ext4 filesystem) readonly on device 8:8.
[    7.466903] devtmpfs: mounted
[    7.470465] Freeing unused kernel image memory: 4716K
[    7.474432] Write protecting the kernel read-only data: 47104k
[    7.477527] Freeing unused kernel image memory: 2032K
[    7.479972] Freeing unused kernel image memory: 424K
[    7.482037] Run /sbin/init as init process
[    7.969546] random: crng init done
[    9.084656] modprobe (153) used greatest stack depth: 26624 bytes left
[    9.181181] systemd[1]: RTC configured in localtime, applying delta of -480 minutes to system time.
[    9.250772] calling  init_autofs_fs+0x0/0x26 [autofs4] @ 1
[    9.253246] initcall init_autofs_fs+0x0/0x26 [autofs4] returned 0 after 317 usecs
[    9.328668] systemd[1]: Mounting cgroup to /sys/fs/cgroup/devices of type cgroup with options devices.
[    9.331297] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpu,cpuacct of type cgroup with options cpu,cpuacct.
[    9.334111] systemd[1]: Mounting cgroup to /sys/fs/cgroup/memory of type cgroup with options memory.
[    9.339340] systemd[1]: Mounting cgroup to /sys/fs/cgroup/net_cls,net_prio of type cgroup with options net_cls,net_prio.
[    9.342219] systemd[1]: Mounting cgroup to /sys/fs/cgroup/freezer of type cgroup with options freezer.
[    9.344792] systemd[1]: Mounting cgroup to /sys/fs/cgroup/hugetlb of type cgroup with options hugetlb.
[    9.347319] systemd[1]: Mounting cgroup to /sys/fs/cgroup/pids of type cgroup with options pids.
[    9.349844] systemd[1]: Mounting cgroup to /sys/fs/cgroup/perf_event of type cgroup with options perf_event.
[    9.352367] systemd[1]: Mounting cgroup to /sys/fs/cgroup/blkio of type cgroup with options blkio.
[    9.355524] systemd[1]: Mounting cgroup to /sys/fs/cgroup/rdma of type cgroup with options rdma.
[    9.553563] systemd-fstab-generator[160]: Parsing /etc/fstab
[    9.560742] systemd-gpt-auto-generator[162]: /dev/sda8: root device /dev/sda.
[    9.572492] systemd-debug-g (159) used greatest stack depth: 26104 bytes left
[    9.644089] systemd-fstab-generator[160]: Found entry what=/dev/sda8 where=/ type=ext4 nofail=no noauto=no
[    9.648684] systemd-sysv-generator[167]: Cannot find unit xfs.service.
[    9.693005] systemd-sysv-generator[167]: Loading SysV script /etc/init.d/xfs
[    9.747190] systemd-fstab-generator[160]: Found entry what=/dev/sda9 where=/home type=ext4 nofail=no noauto=no
[    9.749806] systemd-fstab-generator[160]: Found entry what=/dev/sda7 where=swap type=swap nofail=no noauto=no
[    9.806689] systemd-fstab-generator[160]: Found entry what=/dev/sda6 where=/tester type=btrfs nofail=yes noauto=no
[    9.865839] systemd-fstab-generator[160]: Found entry what=/dev/sda5 where=/xfer type=vfat nofail=yes noauto=no
[    9.869165] systemd-fstab-g (160) used greatest stack depth: 25768 bytes left
[   10.771084] systemd-gpt-auto-generator[162]: No suitable partition table found, ignoring.
[   12.812366] systemd-journald[178]: Fixed min_use=1.0M max_use=153.4M max_size=19.1M min_size=512.0K keep_free=230.2M n_max_files=100
[   12.819251] systemd-journald[178]: Reserving 34929 entries in hash table.
[   12.822134] systemd-journald[178]: Vacuuming...
[   12.824670] systemd-journald[178]: Vacuuming done, freed 0B of archived journals from /run/log/journal/76eac4e178c44ff9901745852136d529.
[   12.827329] systemd-journald[178]: Flushing /dev/kmsg...
[   12.890642] calling  alua_init+0x0/0x1000 [scsi_dh_alua] @ 175
[   12.895252] alua: device handler registered
[   12.899405] initcall alua_init+0x0/0x1000 [scsi_dh_alua] returned 0 after 4319 usecs
[   13.037174] calling  clariion_init+0x0/0x1000 [scsi_dh_emc] @ 175
[   13.039417] emc: device handler registered
[   13.041574] initcall clariion_init+0x0/0x1000 [scsi_dh_emc] returned 0 after 2103 usecs
[   13.146053] calling  rdac_init+0x0/0x1000 [scsi_dh_rdac] @ 175
[   13.150094] rdac: device handler registered
[   13.154399] initcall rdac_init+0x0/0x1000 [scsi_dh_rdac] returned 0 after 4196 usecs
[   13.392104] EXT4-fs (sda8): re-mounted. Opts: acl,user_xattr
[   13.481371] calling  dm_init+0x0/0x148 [dm_mod] @ 175
[   13.485195] device-mapper: uevent: version 1.0.3
[   13.490315] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[   13.492520] initcall dm_init+0x0/0x148 [dm_mod] returned 0 after 8584 usecs
[   13.543637] calling  dm_multipath_init+0x0/0x1000 [dm_multipath] @ 175
[   13.548307] initcall dm_multipath_init+0x0/0x1000 [dm_multipath] returned 0 after 554 usecs
[   13.650195] systemd-journald[178]: systemd-journald running as pid 178
[   13.654075] systemd-journald[178]: Sent READY=1 notification.
[   13.656616] systemd-journald[178]: Sent WATCHDOG=1 notification.
[   13.660027] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   13.664775] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   13.681801] calling  init_sg+0x0/0x1000 [sg] @ 175
[   13.686556] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   13.691179] scsi 2:0:0:0: Attached scsi generic sg1 type 5
[   13.695143] initcall init_sg+0x0/0x1000 [sg] returned 0 after 9147 usecs
[   15.197164] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 206
[   15.199325] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   15.226765] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 213
[   15.228920] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   15.257638] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 209
[   15.261566] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   15.266010] calling  pcc_cpufreq_init+0x0/0x1c3a [pcc_cpufreq] @ 213
[   15.268283] initcall pcc_cpufreq_init+0x0/0x1c3a [pcc_cpufreq] returned 0 after 0 usecs
[   15.271537] calling  acpi_thermal_init+0x0/0x1000 [thermal] @ 221
[   15.282935] thermal LNXTHERM:00: registered as thermal_zone0
[   15.286769] ACPI: Thermal Zone [TZ01] (66 C)
[   15.297269] thermal LNXTHERM:00: registered as thermal_zone0
[   15.299326] ACPI: Thermal Zone [TZ01] (66 C)
[   15.302887] probe of LNXTHERM:00 returned 1 after 27104 usecs
[   15.305040] initcall acpi_thermal_init+0x0/0x1000 [thermal] returned 0 after 28948 usecs
[   15.539339] calling  acpi_ac_init+0x0/0xfdc [ac] @ 203
[   15.544942] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[   15.549359] ACPI: AC Adapter [ADP1] (on-line)
[   15.555508] calling  e1000_init_module+0x0/0x1000 [e1000e] @ 219
[   15.558965] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[   15.559669] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   15.570599] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   15.582202] ACPI: AC Adapter [ADP1] (on-line)
[   15.587700] calling  mei_init+0x0/0xac [mei] @ 218
[   15.594919] initcall mei_init+0x0/0xac [mei] returned 0 after 388 usecs
[   15.603919] probe of ACPI0003:00 returned 1 after 59470 usecs
[   15.608029] initcall acpi_ac_init+0x0/0xfdc [ac] returned 0 after 13201 usecs
[   15.613874] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   15.641531] calling  init_soundcore+0x0/0x1000 [soundcore] @ 205
[   15.645546] initcall init_soundcore+0x0/0x1000 [soundcore] returned 0 after 176 usecs
[   15.729120] calling  lpc_ich_driver_init+0x0/0x1000 [lpc_ich] @ 207
[   15.733590] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\PMIO) (20181213/utaddress-213)
[   15.747880] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.748261] calling  acpi_battery_init+0x0/0xf31 [battery] @ 220
[   15.754398] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054F conflicts with OpRegion 0x0000000000000500-0x000000000000057B (\GPIO) (20181213/utaddress-213)
[   15.760311] calling  cmos_init+0x0/0xe8f [rtc_cmos] @ 222
[   15.766807] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.776379] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053F conflicts with OpRegion 0x0000000000000500-0x000000000000057B (\GPIO) (20181213/utaddress-213)
[   15.776463] initcall acpi_battery_init+0x0/0xf31 [battery] returned 0 after 25 usecs
[   15.788352] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.803305] battery: ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[   15.808213] battery: ACPI: Battery Slot [BAT1] (battery present)
[   15.813955] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052F conflicts with OpRegion 0x0000000000000500-0x000000000000057B (\GPIO) (20181213/utaddress-213)
[   15.818684] rtc_cmos 00:04: RTC can wake from S4
[   15.824346] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.830040] rtc_cmos 00:04: registered as rtc0
[   15.840045] rtc_cmos 00:04: alarms up to one year, 242 bytes nvram, hpet irqs
[   15.846144] rtc_cmos 00:04: RTC can wake from S4
[   15.853227] rtc_cmos 00:04: registered as rtc1
[   15.853607] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[   15.854738] battery: ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[   15.854788] battery: ACPI: Battery Slot [BAT1] (battery present)
[   15.855147] probe of PNP0C0A:00 returned 1 after 64772 usecs
[   15.864140] rtc_cmos 00:04: alarms up to one year, 242 bytes nvram, hpet irqs
[   15.873969] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   15.878850] probe of 00:04 returned 1 after 60296 usecs
[   15.895342] initcall cmos_init+0x0/0xe8f [rtc_cmos] returned 0 after 75050 usecs
[   15.895843] calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 218
[   15.906697] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\PMIO) (20181213/utaddress-213)
[   15.915762] initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 312 usecs
[   15.927753] calling  fjes_init_module+0x0/0x1000 [fjes] @ 225
[   15.936884] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.949871] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054F conflicts with OpRegion 0x0000000000000500-0x000000000000057B (\GPIO) (20181213/utaddress-213)
[   15.961454] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.964327] initcall fjes_init_module+0x0/0x1000 [fjes] returned -19 after 30235 usecs
[   15.967304] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053F conflicts with OpRegion 0x0000000000000500-0x000000000000057B (\GPIO) (20181213/utaddress-213)
[   15.984152] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   15.993173] calling  toshiba_haps_driver_init+0x0/0x1000 [toshiba_haps] @ 209
[   16.001638] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052F conflicts with OpRegion 0x0000000000000500-0x000000000000057B (\GPIO) (20181213/utaddress-213)
[   16.003111] calling  evdev_init+0x0/0x1000 [evdev] @ 216
[   16.013761] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   16.028602] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   16.039549] initcall evdev_init+0x0/0x1000 [evdev] returned 0 after 2563 usecs
[   16.043476] probe of 0000:00:1f.0 returned 1 after 310543 usecs
[   16.051691] toshiba_haps: Toshiba HDD Active Protection Sensor device
[   16.058953] calling  cdrom_init+0x0/0x1000 [cdrom] @ 211
[   16.068727] probe of 0000:00:16.0 returned 1 after 150967 usecs
[   16.078297] initcall cdrom_init+0x0/0x1000 [cdrom] returned 0 after 57 usecs
[   16.086701] calling  fjes_init_module+0x0/0x1000 [fjes] @ 215
[   16.095442] calling  mac_hid_init+0x0/0x1000 [mac_hid] @ 210
[   16.098335] initcall lpc_ich_driver_init+0x0/0x1000 [lpc_ich] returned 0 after 5686 usecs
[   16.103224] initcall mac_hid_init+0x0/0x1000 [mac_hid] returned 0 after 54 usecs
[   16.108000] initcall fjes_init_module+0x0/0x1000 [fjes] returned -19 after 4716 usecs
[   16.115929] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) e8:9d:87:4a:c2:2d
[   16.129641] calling  alsa_sound_init+0x0/0x82 [snd] @ 233
[   16.130942] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   16.138976] initcall alsa_sound_init+0x0/0x82 [snd] returned 0 after 378 usecs
[   16.148301] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[   16.163685] e1000e 0000:00:19.0 eth0: removed PHC
[   16.178621] calling  rfkill_init+0x0/0x1d2 [rfkill] @ 221
[   16.190104] calling  fjes_init_module+0x0/0x1000 [fjes] @ 204
[   16.198376] toshiba_haps: Toshiba HDD Active Protection Sensor device
[   16.199126] initcall fjes_init_module+0x0/0x1000 [fjes] returned -19 after 400 usecs
[   16.201383] initcall rfkill_init+0x0/0x1d2 [rfkill] returned 0 after 511 usecs
[   16.214994] calling  pcspkr_platform_driver_init+0x0/0x1000 [pcspkr] @ 210
[   16.223653] input: PC Speaker as /devices/platform/pcspkr/input/input18
[   16.244838] calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 216
[   16.245853] calling  init_sr+0x0/0x1000 [sr_mod] @ 211
[   16.250859] initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 291 usecs
[   16.264233] calling  fjes_init_module+0x0/0x1000 [fjes] @ 206
[   16.268729] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   16.271594] initcall fjes_init_module+0x0/0x1000 [fjes] returned -19 after 454 usecs
[   16.279307] input: PC Speaker as /devices/platform/pcspkr/input/input19
[   16.287807] probe of pcspkr returned 1 after 64695 usecs
[   16.293219] initcall pcspkr_platform_driver_init+0x0/0x1000 [pcspkr] returned 0 after 21578 usecs
[   16.296247] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   16.328052] calling  leds_init+0x0/0x1000 [led_class] @ 213
[   16.331863] probe of TOS620A:00 returned 1 after 332496 usecs
[   16.333238] cdrom: Uniform CD-ROM driver Revision: 3.20
[   16.338149] initcall toshiba_haps_driver_init+0x0/0x1000 [toshiba_haps] returned 0 after 65455 usecs
[   16.356661] initcall leds_init+0x0/0x1000 [led_class] returned 0 after 169 usecs
[   16.362364] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   16.362689] calling  iio_init+0x0/0x1000 [industrialio] @ 223
[   16.392670] initcall iio_init+0x0/0x1000 [industrialio] returned 0 after 451 usecs
[   16.413935] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   16.423178] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   16.427554] probe of 2:0:0:0 returned 1 after 168066 usecs
[   16.431804] initcall init_sr+0x0/0x1000 [sr_mod] returned 0 after 38678 usecs
[   16.498454] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[   16.519867] calling  input_leds_init+0x0/0x1000 [input_leds] @ 225
[   16.524848] initcall input_leds_init+0x0/0x1000 [input_leds] returned 0 after 2612 usecs
[   16.542709] calling  alsa_timer_init+0x0/0x1000 [snd_timer] @ 210
[   16.547457] initcall alsa_timer_init+0x0/0x1000 [snd_timer] returned 0 after 525 usecs
[   16.566706] calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 220
[   16.571613] initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 667 usecs
[   16.628095] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) e8:9d:87:4a:c2:2d
[   16.630505] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   16.632836] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[   16.636974] probe of 0000:00:19.0 returned 1 after 1062497 usecs
[   16.641261] initcall e1000_init_module+0x0/0x1000 [e1000e] returned 0 after 68667 usecs
[   16.642185] calling  uio_init+0x0/0x1000 [uio] @ 215
[   16.648310] initcall uio_init+0x0/0x1000 [uio] returned 0 after 220 usecs
[   16.738150] calling  mmc_init+0x0/0x1000 [mmc_core] @ 213
[   16.741943] initcall mmc_init+0x0/0x1000 [mmc_core] returned 0 after 347 usecs
[   16.745291] calling  mousedev_init+0x0/0x1000 [mousedev] @ 216
[   16.750667] mousedev: PS/2 mouse device common for all mice
[   16.754735] initcall mousedev_init+0x0/0x1000 [mousedev] returned 0 after 5260 usecs
[   16.771357] calling  cfg80211_init+0x0/0xd8 [cfg80211] @ 221
[   16.774319] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   16.831082] calling  sdhci_drv_init+0x0/0x1000 [sdhci] @ 213
[   16.835218] sdhci: Secure Digital Host Controller Interface driver
[   16.841305] calling  rapl_pmu_init+0x0/0x1000 [intel_rapl_perf] @ 225
[   16.842858] sdhci: Copyright(c) Pierre Ossman
[   16.849697] initcall sdhci_drv_init+0x0/0x1000 [sdhci] returned 0 after 2368 usecs
[   16.855863] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[   16.860038] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[   16.864445] RAPL PMU: hw unit of domain package 2^-16 Joules
[   16.868588] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[   16.872535] initcall rapl_pmu_init+0x0/0x1000 [intel_rapl_perf] returned 0 after 24672 usecs
[   16.877500] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   16.882265] calling  toshiba_acpi_init+0x0/0x1000 [toshiba_acpi] @ 220
[   16.883034] initcall cfg80211_init+0x0/0xd8 [cfg80211] returned 0 after 34905 usecs
[   16.886338] toshiba_acpi: Toshiba Laptop ACPI Extras version 0.24
[   16.897966] calling  uio_pdrv_genirq_init+0x0/0x1000 [uio_pdrv_genirq] @ 215
[   16.903514] initcall uio_pdrv_genirq_init+0x0/0x1000 [uio_pdrv_genirq] returned 0 after 306 usecs
[   16.946822] calling  alsa_pcm_init+0x0/0x1000 [snd_pcm] @ 286
[   16.950802] initcall alsa_pcm_init+0x0/0x1000 [snd_pcm] returned 0 after 68 usecs
[   17.000089] input: Toshiba input device as /devices/virtual/input/input20
[   17.034275] calling  joydev_init+0x0/0x1000 [joydev] @ 216
[   17.039933] calling  alsa_hwdep_init+0x0/0x1000 [snd_hwdep] @ 205
[   17.043722] initcall alsa_hwdep_init+0x0/0x1000 [snd_hwdep] returned 0 after 64 usecs
[   17.087662] initcall joydev_init+0x0/0x1000 [joydev] returned 0 after 7 usecs
[   17.137886] calling  pcsp_init+0x0/0x1000 [snd_pcsp] @ 210
[   17.161018] calling  intel_uncore_init+0x0/0x9cb [intel_uncore] @ 225
[   17.161248] Error: Driver 'pcspkr' is already registered, aborting...
[   17.179837] initcall intel_uncore_init+0x0/0x9cb [intel_uncore] returned 0 after 7851 usecs
[   17.210372] initcall pcsp_init+0x0/0x1000 [snd_pcsp] returned -16 after 37678 usecs
[   17.227346] calling  hda_bus_init+0x0/0x1000 [snd_hda_core] @ 205
[   17.231647] initcall hda_bus_init+0x0/0x1000 [snd_hda_core] returned 0 after 297 usecs
[   17.303522] calling  sdhci_driver_init+0x0/0x1000 [sdhci_pci] @ 213
[   17.307580] sdhci-pci 0000:01:00.0: SDHCI controller found [1180:e823] (rev 4)
[   17.327238] mmc0 bounce up to 128 segments into one, max segment size 65536 bytes
[   17.332214] toshiba_acpi: Registering Toshiba accelerometer iio device
[   17.339337] mmc0: SDHCI controller on PCI [0000:01:00.0] using DMA
[   17.352923] sdhci-pci 0000:01:00.0: SDHCI controller found [1180:e823] (rev 4)
[   17.368052] mmc0 bounce up to 128 segments into one, max segment size 65536 bytes
[   17.372042] mmc0: SDHCI controller on PCI [0000:01:00.0] using DMA
[   17.374479] probe of 0000:01:00.0 returned 1 after 67000 usecs
[   17.376723] initcall sdhci_driver_init+0x0/0x1000 [sdhci_pci] returned 0 after 67717 usecs
[   17.474899] toshiba_acpi: Supported laptop features: hotkeys video-out fan touchpad accelerometer-axes usb-sleep-charge panel-power-on cooling-method
[   17.512762] toshiba_acpi: Toshiba Laptop ACPI Extras version 0.24
[   17.576338] calling  cstate_pmu_init+0x0/0xe69 [intel_cstate] @ 225
[   17.584660] initcall cstate_pmu_init+0x0/0xe69 [intel_cstate] returned 0 after 3500 usecs
[   17.611063] input: Toshiba input device as /devices/virtual/input/input21
[   17.684793] calling  azx_driver_init+0x0/0x1000 [snd_hda_intel] @ 205
[   17.768515] calling  iwl_drv_init+0x0/0x1000 [iwlwifi] @ 221
[   17.772806] Intel(R) Wireless WiFi driver for Linux
[   17.777148] Copyright(c) 2003- 2015 Intel Corporation
[   17.785474] probe of 0000:00:1b.0 returned 1 after 92093 usecs
[   17.785693] snd_hda_intel 0000:00:1b.0: Linked as a consumer to 0000:00:02.0
[   17.786897] iwlwifi 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[   17.791962] initcall azx_driver_init+0x0/0x1000 [snd_hda_intel] returned 0 after 18694 usecs
[   17.793711] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[   17.816896] iwlwifi 0000:04:00.0: loaded firmware version 39.31.5.1 build 35138 op_mode iwldvm
[   17.855227] iwlwifi 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[   17.861264] probe of 0000:04:00.0 returned 1 after 79463 usecs
[   17.861733] iwlwifi 0000:04:00.0: loaded firmware version 39.31.5.1 build 35138 op_mode iwldvm
[   17.865501] initcall iwl_drv_init+0x0/0x1000 [iwlwifi] returned 0 after 90485 usecs
[   17.871276] toshiba_acpi: Registering Toshiba accelerometer iio device
[   17.886732] calling  cryptd_init+0x0/0x1000 [cryptd] @ 225
[   17.891457] cryptd: max_cpu_qlen set to 1000
[   17.898014] initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after 6440 usecs
[   17.931531] calling  ledtrig_audio_init+0x0/0x1000 [ledtrig_audio] @ 354
[   17.935881] initcall ledtrig_audio_init+0x0/0x1000 [ledtrig_audio] returned 0 after 33 usecs
[   18.005801] calling  aes_init+0x0/0x1000 [aes_x86_64] @ 222
[   18.017328] initcall aes_init+0x0/0x1000 [aes_x86_64] returned 0 after 7088 usecs
[   18.079876] toshiba_acpi: Supported laptop features: hotkeys video-out fan touchpad accelerometer-axes usb-sleep-charge panel-power-on cooling-method
[   18.084714] probe of TOS6208:00 returned 1 after 1198464 usecs
[   18.089376] initcall toshiba_acpi_init+0x0/0x1000 [toshiba_acpi] returned 0 after 77446 usecs
[   18.147286] calling  aesni_init+0x0/0x1000 [aesni_intel] @ 222
[   18.155368] AVX version of gcm_enc/dec engaged.
[   18.178077] AES CTR mode by8 optimization enabled
[   18.190562] calling  generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] @ 354
[   18.195354] initcall generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] returned 0 after 265 usecs
[   18.431250] calling  realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] @ 354
[   18.437003] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   18.441604] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.446106] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[   18.451321] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   18.455638] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   18.460098] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   18.464387] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   18.486375] WARNING: CPU: 0 PID: 354 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   18.487728] initcall aesni_init+0x0/0x1000 [aesni_intel] returned 0 after 50889 usecs
[   18.490662] Modules linked in: snd_hda_codec_realtek(+) snd_hda_codec_generic aesni_intel(+) aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   18.497246] systemd-journald[178]: Compressed data object 617 -> 540 using LZ4
[   18.513077] CPU: 0 PID: 354 Comm: modprobe Tainted: G    B             5.0.0-rc7mod #3
[   18.513081] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   18.513103] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   18.513109] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   18.513112] RSP: 0018:ffff888119e57668 EFLAGS: 00010246
[   18.513117] RAX: dffffc0000000000 RBX: ffff8881171ed6e8 RCX: ffffffffb58c3df7
[   18.513120] RDX: 1ffff11022e3db8b RSI: 0000000000000004 RDI: ffff8881158b3440
[   18.513123] RBP: ffff888119e57698 R08: ffffed1022882432 R09: ffffed1022882432
[   18.513126] R10: 0000000000000001 R11: ffffed1022882431 R12: ffff8881171edc58
[   18.513129] R13: ffff8881171edc40 R14: 1ffff11022e3dafd R15: 0000000000000000
[   18.513134] FS:  00007faf9d880b80(0000) GS:ffff88811ee00000(0000) knlGS:0000000000000000
[   18.513137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.513140] CR2: 00007fc48ecdded4 CR3: 000000010d8d4005 CR4: 00000000000606f0
[   18.513146] Call Trace:
[   18.590110]  ? pinctrl_bind_pins+0x2d6/0x830
[   18.594679]  really_probe+0x15f/0xd40
[   18.599334]  driver_probe_device+0xe9/0x3a0
[   18.603973]  __driver_attach+0x294/0x360
[   18.608484]  ? driver_probe_device+0x3a0/0x3a0
[   18.613077]  bus_for_each_dev+0x116/0x1b0
[   18.617492]  ? klist_add_tail+0x2f/0xe0
[   18.621922]  ? subsys_dev_iter_init+0xe0/0xe0
[   18.626408]  ? do_raw_spin_unlock+0x54/0x220
[   18.630745]  ? _raw_spin_unlock+0x22/0x40
[   18.635115]  driver_attach+0x38/0x50
[   18.639297]  bus_add_driver+0x3f5/0x730
[   18.643451]  driver_register+0x18e/0x410
[   18.647421]  ? 0xffffffffc0a18000
[   18.651497]  __hda_codec_driver_register+0x19c/0x220 [snd_hda_codec]
[   18.655615]  realtek_driver_init+0x1e/0x1000 [snd_hda_codec_realtek]
[   18.659687]  do_one_initcall+0xab/0x2ad
[   18.663635]  ? initcall_blacklisted+0x190/0x190
[   18.667713]  ? kasan_unpoison_shadow+0x35/0x50
[   18.671552]  ? kasan_unpoison_shadow+0x35/0x50
[   18.675359]  ? kasan_unpoison_shadow+0x35/0x50
[   18.679178]  ? kasan_poison_shadow+0x2f/0x40
[   18.682875]  ? __asan_register_globals+0x5a/0x70
[   18.686778]  do_init_module+0x1c7/0x542
[   18.690579]  load_module+0x4ba4/0x5d50
[   18.694330]  ? layout_and_allocate+0x2d40/0x2d40
[   18.698183]  ? kernel_read+0x90/0x130
[   18.701804]  ? kasan_check_write+0x14/0x20
[   18.705300]  ? kernel_read_file+0x24a/0x640
[   18.708677]  __do_sys_finit_module+0x193/0x1b0
[   18.711910]  ? __do_sys_finit_module+0x193/0x1b0
[   18.714860]  ? __ia32_sys_init_module+0xa0/0xa0
[   18.717804]  ? vfs_statx_fd+0x45/0x80
[   18.720689]  ? kasan_check_write+0x14/0x20
[   18.723566]  ? fput+0x18/0x130
[   18.726347]  ? ksys_mmap_pgoff+0x3d9/0xb50
[   18.728935]  __x64_sys_finit_module+0x6e/0xb0
[   18.731380]  ? __x64_sys_newfstat+0x4f/0x70
[   18.733883]  do_syscall_64+0xaa/0x310
[   18.736304]  ? prepare_exit_to_usermode+0x8b/0x150
[   18.738707]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   18.741064] RIP: 0033:0x7faf9cf69129
[   18.743529] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 0d 2c 00 f7 d8 64 89 01 48
[   18.748929] RSP: 002b:00007ffc4e0e3468 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   18.751697] RAX: ffffffffffffffda RBX: 00005598459a3ba0 RCX: 00007faf9cf69129
[   18.754383] RDX: 0000000000000000 RSI: 0000559845791548 RDI: 0000000000000002
[   18.756999] RBP: 0000559845791548 R08: 0000000000000000 R09: 00005598459a3480
[   18.759758] R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000040000
[   18.762506] R13: 00005598459a3b50 R14: 0000000000000000 R15: 00005598459a3ba0
[   18.765255] ---[ end trace d1246045466532ee ]---
[   18.788551] snd_hda_codec_realtek: probe of hdaudioC0D0 failed with error -22
[   18.791441] probe of hdaudioC0D0 returned 0 after 355773 usecs
[   18.794578] initcall realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] returned 0 after 350550 usecs
[   18.800621] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   18.804238] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.807268] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[   18.812435] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   18.818438] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   18.821463] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   18.828437] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   18.868360] WARNING: CPU: 2 PID: 146 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   18.871393] Modules linked in: snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   18.885036] CPU: 2 PID: 146 Comm: kworker/2:4 Tainted: G    B   W         5.0.0-rc7mod #3
[   18.888682] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   18.892505] Workqueue: events azx_probe_work [snd_hda_intel]
[   18.896356] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   18.900232] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   18.908398] RSP: 0000:ffff888119cff978 EFLAGS: 00010246
[   18.912451] RAX: dffffc0000000000 RBX: ffff8881171ed6e8 RCX: ffffffffb58c3df7
[   18.916682] RDX: 1ffff11022e3db8b RSI: 0000000000000004 RDI: ffff8881158b3440
[   18.920902] RBP: ffff888119cff9a8 R08: ffffed1022882432 R09: ffffed1022882432
[   18.925160] R10: 0000000000000001 R11: ffffed1022882431 R12: ffff8881171edc58
[   18.929425] R13: ffff8881171edc40 R14: 1ffff11022e3dafd R15: 0000000000000000
[   18.933717] FS:  0000000000000000(0000) GS:ffff88811f200000(0000) knlGS:0000000000000000
[   18.938020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.942345] CR2: 00007ff9d781fcf0 CR3: 000000011e254002 CR4: 00000000000606e0
[   18.946743] Call Trace:
[   18.951117]  ? pinctrl_bind_pins+0x2d6/0x830
[   18.955493]  really_probe+0x15f/0xd40
[   18.959934]  driver_probe_device+0xe9/0x3a0
[   18.964228]  __device_attach_driver+0x1c0/0x300
[   18.968618]  ? __driver_attach+0x360/0x360
[   18.973001]  bus_for_each_drv+0x10e/0x1b0
[   18.977365]  ? bus_rescan_devices+0x20/0x20
[   18.981673]  ? do_raw_spin_unlock+0x54/0x220
[   18.985793]  __device_attach+0x1df/0x2f0
[   18.989915]  ? device_bind_driver+0xb0/0xb0
[   18.993968]  device_attach+0xb/0x10
[   18.997865]  snd_hda_codec_configure+0x11c/0x490 [snd_hda_codec]
[   19.001906]  ? vsprintf+0x20/0x20
[   19.005868]  azx_codec_configure+0x83/0x120 [snd_hda_codec]
[   19.009961]  azx_probe_continue+0xc5d/0x1aa0 [snd_hda_intel]
[   19.013985]  ? lock_downgrade+0x6c0/0x6c0
[   19.017995]  azx_probe_work+0x10/0x20 [snd_hda_intel]
[   19.021933]  process_one_work+0x9fb/0x1710
[   19.025858]  ? cancel_delayed_work_sync+0x10/0x10
[   19.029715]  worker_thread+0x85/0xee0
[   19.033541]  ? do_raw_spin_unlock+0x54/0x220
[   19.037258]  kthread+0x349/0x410
[   19.040971]  ? process_one_work+0x1710/0x1710
[   19.044737]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   19.048553]  ret_from_fork+0x35/0x40
[   19.052266] ---[ end trace d1246045466532ef ]---
[   19.057537] systemd-journald[178]: Compressed data object 611 -> 533 using LZ4
[   19.063567] snd_hda_codec_realtek: probe of hdaudioC0D0 failed with error -22
[   19.068146] probe of hdaudioC0D0 returned 0 after 268884 usecs
[   19.090122] snd_hda_codec_generic hdaudioC0D0: autoconfig for Generic: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   19.093726] snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   19.097178] snd_hda_codec_generic hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[   19.100571] snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
[   19.103891] snd_hda_codec_generic hdaudioC0D0:    inputs:
[   19.110442] snd_hda_codec_generic hdaudioC0D0:      Mic=0x18
[   19.113700] snd_hda_codec_generic hdaudioC0D0:      Internal Mic=0x12
[   19.136875] WARNING: CPU: 2 PID: 146 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   19.139847] Modules linked in: snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   19.153109] CPU: 2 PID: 146 Comm: kworker/2:4 Tainted: G    B   W         5.0.0-rc7mod #3
[   19.156625] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   19.160246] Workqueue: events azx_probe_work [snd_hda_intel]
[   19.163788] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   19.167241] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   19.174622] RSP: 0018:ffff888119cff978 EFLAGS: 00010246
[   19.178337] RAX: dffffc0000000000 RBX: ffff8881171ed6e8 RCX: ffffffffb58c3df7
[   19.182199] RDX: 1ffff11022e3db8b RSI: 0000000000000004 RDI: ffff8881158b3440
[   19.186067] RBP: ffff888119cff9a8 R08: ffffed1014c62151 R09: ffffed1014c62151
[   19.189922] R10: 0000000000000001 R11: ffffed1014c62150 R12: ffff8881171edc58
[   19.193768] R13: ffff8881171edc40 R14: 1ffff11022e3dafd R15: 0000000000000000
[   19.197657] FS:  0000000000000000(0000) GS:ffff88811f200000(0000) knlGS:0000000000000000
[   19.201537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.205534] CR2: 000056277d8e0a90 CR3: 0000000101430006 CR4: 00000000000606e0
[   19.209617] Call Trace:
[   19.213580]  ? pinctrl_bind_pins+0x2d6/0x830
[   19.217659]  really_probe+0x15f/0xd40
[   19.221712]  driver_probe_device+0xe9/0x3a0
[   19.225629]  __device_attach_driver+0x1c0/0x300
[   19.229600]  ? __driver_attach+0x360/0x360
[   19.233507]  bus_for_each_drv+0x10e/0x1b0
[   19.237477]  ? bus_rescan_devices+0x20/0x20
[   19.241400]  ? do_raw_spin_unlock+0x54/0x220
[   19.245382]  __device_attach+0x1df/0x2f0
[   19.249246]  ? device_bind_driver+0xb0/0xb0
[   19.253116]  device_attach+0xb/0x10
[   19.257067]  snd_hda_codec_configure+0x2c6/0x490 [snd_hda_codec]
[   19.260905]  ? vsprintf+0x20/0x20
[   19.264869]  azx_codec_configure+0x83/0x120 [snd_hda_codec]
[   19.268826]  azx_probe_continue+0xc5d/0x1aa0 [snd_hda_intel]
[   19.272835]  ? lock_downgrade+0x6c0/0x6c0
[   19.276822]  azx_probe_work+0x10/0x20 [snd_hda_intel]
[   19.280802]  process_one_work+0x9fb/0x1710
[   19.284706]  ? cancel_delayed_work_sync+0x10/0x10
[   19.288446]  worker_thread+0x85/0xee0
[   19.292017]  ? do_raw_spin_unlock+0x54/0x220
[   19.295548]  kthread+0x349/0x410
[   19.299071]  ? process_one_work+0x1710/0x1710
[   19.302609]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   19.306185]  ret_from_fork+0x35/0x40
[   19.309769] ---[ end trace d1246045466532f0 ]---
[   19.316404] snd_hda_codec_generic: probe of hdaudioC0D0 failed with error -22
[   19.320225] probe of hdaudioC0D0 returned 0 after 231074 usecs
[   19.324007] hdaudio hdaudioC0D0: Unable to bind the codec
[   19.343414] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 209
[   19.849535] calling  iTCO_vendor_init_module+0x0/0x1000 [iTCO_vendor_support] @ 215
[   19.853104] iTCO_vendor_support: vendor-support=0
[   19.856615] initcall iTCO_vendor_init_module+0x0/0x1000 [iTCO_vendor_support] returned 0 after 3419 usecs
[   19.971878] calling  iTCO_wdt_init_module+0x0/0x1000 [iTCO_wdt] @ 215
[   19.975320] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   19.979235] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
[   19.983676] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   19.988626] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
[   19.993121] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   19.998994] probe of iTCO_wdt.0.auto returned 1 after 20023 usecs
[   20.003361] initcall iTCO_wdt_init_module+0x0/0x1000 [iTCO_wdt] returned 0 after 27375 usecs
[   20.043069] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 66151 usecs
[   20.129072] calling  hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] @ 449
[   20.138431] WARNING: CPU: 0 PID: 449 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.142004] Modules linked in: snd_hda_codec_hdmi(+) iTCO_wdt iTCO_vendor_support ghash_clmulni_intel snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   20.161451] CPU: 0 PID: 449 Comm: modprobe Tainted: G    B   W         5.0.0-rc7mod #3
[   20.165620] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   20.169880] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.174224] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   20.183228] RSP: 0018:ffff888103887668 EFLAGS: 00010246
[   20.187821] RAX: dffffc0000000000 RBX: ffff8881158ce848 RCX: ffffffffb58c3df7
[   20.192505] RDX: 1ffff11022b19db7 RSI: 0000000000000004 RDI: ffff8881158b3440
[   20.197113] RBP: ffff888103887698 R08: ffffed10149f5a5d R09: ffffed10149f5a5d
[   20.201848] R10: 0000000000000001 R11: ffffed10149f5a5c R12: ffff8881158cedb8
[   20.206423] R13: ffff8881158ceda0 R14: 1ffff11022b19d29 R15: 0000000000000000
[   20.211149] FS:  00007f1a4fe7eb80(0000) GS:ffff88811ee00000(0000) knlGS:0000000000000000
[   20.215927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.220686] CR2: 00007ffeb09101e4 CR3: 00000001126f8006 CR4: 00000000000606f0
[   20.225423] Call Trace:
[   20.230118]  ? pinctrl_bind_pins+0x2d6/0x830
[   20.234839]  really_probe+0x15f/0xd40
[   20.239463]  driver_probe_device+0xe9/0x3a0
[   20.244270]  __driver_attach+0x294/0x360
[   20.249049]  ? driver_probe_device+0x3a0/0x3a0
[   20.253815]  bus_for_each_dev+0x116/0x1b0
[   20.258602]  ? klist_add_tail+0x2f/0xe0
[   20.263353]  ? subsys_dev_iter_init+0xe0/0xe0
[   20.267967]  ? do_raw_spin_unlock+0x54/0x220
[   20.272698]  ? _raw_spin_unlock+0x22/0x40
[   20.277279]  driver_attach+0x38/0x50
[   20.281790]  bus_add_driver+0x3f5/0x730
[   20.286409]  driver_register+0x18e/0x410
[   20.290846]  ? 0xffffffffc0998000
[   20.295368]  __hda_codec_driver_register+0x19c/0x220 [snd_hda_codec]
[   20.299715]  hdmi_driver_init+0x1e/0x1000 [snd_hda_codec_hdmi]
[   20.304218]  do_one_initcall+0xab/0x2ad
[   20.308606]  ? initcall_blacklisted+0x190/0x190
[   20.313008]  ? kasan_unpoison_shadow+0x35/0x50
[   20.317210]  ? kasan_unpoison_shadow+0x35/0x50
[   20.321453]  ? kasan_unpoison_shadow+0x35/0x50
[   20.325644]  ? kasan_poison_shadow+0x2f/0x40
[   20.329691]  ? __asan_register_globals+0x5a/0x70
[   20.333778]  do_init_module+0x1c7/0x542
[   20.337798]  load_module+0x4ba4/0x5d50
[   20.341726]  ? layout_and_allocate+0x2d40/0x2d40
[   20.345638]  ? kernel_read+0x90/0x130
[   20.349394]  ? kasan_check_write+0x14/0x20
[   20.352988]  ? kernel_read_file+0x24a/0x640
[   20.356524]  __do_sys_finit_module+0x193/0x1b0
[   20.359794]  ? __do_sys_finit_module+0x193/0x1b0
[   20.362915]  ? __ia32_sys_init_module+0xa0/0xa0
[   20.365963]  ? vfs_statx_fd+0x45/0x80
[   20.368929]  ? kasan_check_write+0x14/0x20
[   20.371857]  ? fput+0x18/0x130
[   20.374712]  ? ksys_mmap_pgoff+0x3d9/0xb50
[   20.377377]  __x64_sys_finit_module+0x6e/0xb0
[   20.379846]  ? __x64_sys_newfstat+0x4f/0x70
[   20.382291]  do_syscall_64+0xaa/0x310
[   20.384801]  ? prepare_exit_to_usermode+0x8b/0x150
[   20.387280]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   20.389771] RIP: 0033:0x7f1a4f567129
[   20.392137] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 0d 2c 00 f7 d8 64 89 01 48
[   20.397533] RSP: 002b:00007fff2467eaa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   20.400272] RAX: ffffffffffffffda RBX: 0000558693717b30 RCX: 00007f1a4f567129
[   20.402907] RDX: 0000000000000000 RSI: 0000558693505548 RDI: 0000000000000000
[   20.405644] RBP: 0000558693505548 R08: 0000000000000000 R09: 0000558693717480
[   20.408386] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000040000
[   20.411136] R13: 0000558693717f80 R14: 0000000000000000 R15: 0000558693717b30
[   20.413788] ---[ end trace d1246045466532f1 ]---
[   20.418836] calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 225
[   20.419735] systemd-journald[178]: Compressed data object 682 -> 583 using LZ4
[   20.422646] snd_hda_codec_hdmi: probe of hdaudioC0D3 failed with error -22
[   20.428647] probe of hdaudioC0D3 returned 0 after 293992 usecs
[   20.432408] initcall hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] returned 0 after 9648 usecs
[   20.443107] initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 20098 usecs
[   20.449532] WARNING: CPU: 2 PID: 146 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.452630] Modules linked in: crc32c_intel snd_hda_codec_hdmi iTCO_wdt iTCO_vendor_support ghash_clmulni_intel snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   20.458750] systemd-journald[178]: Compressed data object 692 -> 588 using LZ4
[   20.469783] CPU: 2 PID: 146 Comm: kworker/2:4 Tainted: G    B   W         5.0.0-rc7mod #3
[   20.469786] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   20.469799] Workqueue: events azx_probe_work [snd_hda_intel]
[   20.469814] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.469818] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   20.469821] RSP: 0018:ffff888119cff978 EFLAGS: 00010246
[   20.469824] RAX: dffffc0000000000 RBX: ffff8881158ce848 RCX: ffffffffb58c3df7
[   20.469827] RDX: 1ffff11022b19db7 RSI: 0000000000000004 RDI: ffff8881158b3440
[   20.469829] RBP: ffff888119cff9a8 R08: ffffed10149f5a5d R09: ffffed10149f5a5d
[   20.469831] R10: 0000000000000001 R11: ffffed10149f5a5c R12: ffff8881158cedb8
[   20.469834] R13: ffff8881158ceda0 R14: 1ffff11022b19d29 R15: 0000000000000000
[   20.469838] FS:  0000000000000000(0000) GS:ffff88811f200000(0000) knlGS:0000000000000000
[   20.469840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.469842] CR2: 00007f1a4fa72ed4 CR3: 0000000115be0001 CR4: 00000000000606e0
[   20.469844] Call Trace:
[   20.469852]  ? pinctrl_bind_pins+0x2d6/0x830
[   20.469860]  really_probe+0x15f/0xd40
[   20.469870]  driver_probe_device+0xe9/0x3a0
[   20.469876]  __device_attach_driver+0x1c0/0x300
[   20.469881]  ? __driver_attach+0x360/0x360
[   20.469886]  bus_for_each_drv+0x10e/0x1b0
[   20.469891]  ? bus_rescan_devices+0x20/0x20
[   20.469897]  ? do_raw_spin_unlock+0x54/0x220
[   20.469905]  __device_attach+0x1df/0x2f0
[   20.562076]  ? device_bind_driver+0xb0/0xb0
[   20.564803]  device_attach+0xb/0x10
[   20.567120]  snd_hda_codec_configure+0x11c/0x490 [snd_hda_codec]
[   20.570450]  ? vsprintf+0x20/0x20
[   20.573647]  azx_codec_configure+0x83/0x120 [snd_hda_codec]
[   20.575938]  azx_probe_continue+0xc5d/0x1aa0 [snd_hda_intel]
[   20.579232]  ? lock_downgrade+0x6c0/0x6c0
[   20.581519]  azx_probe_work+0x10/0x20 [snd_hda_intel]
[   20.584368]  process_one_work+0x9fb/0x1710
[   20.587848]  ? cancel_delayed_work_sync+0x10/0x10
[   20.590402]  worker_thread+0x85/0xee0
[   20.592629]  ? do_raw_spin_unlock+0x54/0x220
[   20.595179]  kthread+0x349/0x410
[   20.598345]  ? process_one_work+0x1710/0x1710
[   20.600502]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   20.603748]  ret_from_fork+0x35/0x40
[   20.606158] ---[ end trace d1246045466532f2 ]---
[   20.609957] snd_hda_codec_hdmi: probe of hdaudioC0D3 failed with error -22
[   20.614139] probe of hdaudioC0D3 returned 0 after 176625 usecs
[   20.626818] WARNING: CPU: 2 PID: 146 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.630250] calling  ieee80211_init+0x0/0x24 [mac80211] @ 350
[   20.630363] Modules linked in: mac80211(+) zstd_decompress crc32c_intel snd_hda_codec_hdmi iTCO_wdt iTCO_vendor_support ghash_clmulni_intel snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   20.633712] initcall ieee80211_init+0x0/0x24 [mac80211] returned 0 after 30 usecs
[   20.651341] CPU: 2 PID: 146 Comm: kworker/2:4 Tainted: G    B   W         5.0.0-rc7mod #3
[   20.651344] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   20.651356] Workqueue: events azx_probe_work [snd_hda_intel]
[   20.651372] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.651377] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   20.651379] RSP: 0018:ffff888119cff978 EFLAGS: 00010246
[   20.651383] RAX: dffffc0000000000 RBX: ffff8881158ce848 RCX: ffffffffb58c3df7
[   20.651386] RDX: 1ffff11022b19db7 RSI: 0000000000000004 RDI: ffff8881158b3440
[   20.651388] RBP: ffff888119cff9a8 R08: ffffed10149f5a5d R09: ffffed10149f5a5d
[   20.651391] R10: 0000000000000001 R11: ffffed10149f5a5c R12: ffff8881158cedb8
[   20.651393] R13: ffff8881158ceda0 R14: 1ffff11022b19d29 R15: 0000000000000000
[   20.651397] FS:  0000000000000000(0000) GS:ffff88811f200000(0000) knlGS:0000000000000000
[   20.651400] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.651403] CR2: 00007f53671f6ed4 CR3: 000000009fe1a006 CR4: 00000000000606e0
[   20.651405] Call Trace:
[   20.651412]  ? pinctrl_bind_pins+0x2d6/0x830
[   20.651420]  really_probe+0x15f/0xd40
[   20.651430]  driver_probe_device+0xe9/0x3a0
[   20.651436]  __device_attach_driver+0x1c0/0x300
[   20.651441]  ? __driver_attach+0x360/0x360
[   20.651445]  bus_for_each_drv+0x10e/0x1b0
[   20.651450]  ? bus_rescan_devices+0x20/0x20
[   20.651455]  ? do_raw_spin_unlock+0x54/0x220
[   20.651464]  __device_attach+0x1df/0x2f0
[   20.651470]  ? device_bind_driver+0xb0/0xb0
[   20.651479]  device_attach+0xb/0x10
[   20.651492]  snd_hda_codec_configure+0x344/0x490 [snd_hda_codec]
[   20.651497]  ? vsprintf+0x20/0x20
[   20.651515]  azx_codec_configure+0x83/0x120 [snd_hda_codec]
[   20.651526]  azx_probe_continue+0xc5d/0x1aa0 [snd_hda_intel]
[   20.653661] systemd-journald[178]: Compressed data object 720 -> 615 using LZ4
[   20.777738]  ? lock_downgrade+0x6c0/0x6c0
[   20.781657]  azx_probe_work+0x10/0x20 [snd_hda_intel]
[   20.785587]  process_one_work+0x9fb/0x1710
[   20.789507]  ? cancel_delayed_work_sync+0x10/0x10
[   20.793419]  worker_thread+0x85/0xee0
[   20.797328]  ? do_raw_spin_unlock+0x54/0x220
[   20.801192]  kthread+0x349/0x410
[   20.805020]  ? process_one_work+0x1710/0x1710
[   20.808766]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   20.812445]  ret_from_fork+0x35/0x40
[   20.815980] ---[ end trace d1246045466532f3 ]---
[   20.819489] snd_hda_codec_hdmi: probe of hdaudioC0D3 failed with error -22
[   20.822992] probe of hdaudioC0D3 returned 0 after 199938 usecs
[   20.825919] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   20.840363] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 211
[   20.841178] snd_hda_codec_generic hdaudioC0D3: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
[   20.847351] snd_hda_codec_generic hdaudioC0D3:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   20.850785] snd_hda_codec_generic hdaudioC0D3:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   20.854146] snd_hda_codec_generic hdaudioC0D3:    mono: mono_out=0x0
[   20.854151] snd_hda_codec_generic hdaudioC0D3:    dig-out=0x5/0x0
[   20.854155] snd_hda_codec_generic hdaudioC0D3:    inputs:
[   20.861527] WARNING: CPU: 2 PID: 146 at ../sound/pci/hda/hda_bind.c:90 hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.861530] Modules linked in: libcrc32c(+) crc32_pclmul(+) hid(+) mac80211 zstd_decompress crc32c_intel snd_hda_codec_hdmi iTCO_wdt iTCO_vendor_support ghash_clmulni_intel snd_hda_codec_realtek snd_hda_codec_generic aesni_intel aes_x86_64 ledtrig_audio crypto_simd cryptd glue_helper iwlwifi snd_hda_intel intel_cstate snd_hda_codec sdhci_pci snd_hda_core intel_uncore cqhci snd_hwdep joydev snd_pcm uio_pdrv_genirq toshiba_acpi intel_rapl_perf sdhci sparse_keymap cfg80211 mousedev mmc_core uio wmi snd_timer input_leds industrialio led_class sr_mod serio_raw pcspkr rfkill snd mac_hid cdrom toshiba_haps evdev mei_me battery rtc_cmos lpc_ich soundcore mei e1000e ac thermal pcc_cpufreq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   20.861610] CPU: 2 PID: 146 Comm: kworker/2:4 Tainted: G    B   W         5.0.0-rc7mod #3
[   20.861613] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   20.861622] Workqueue: events azx_probe_work [snd_hda_intel]
[   20.861637] RIP: 0010:hda_codec_driver_probe+0x259/0x480 [snd_hda_codec]
[   20.861642] Code: e8 1c 13 01 00 8b 45 d4 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b b8 ea ff ff ff e9 45 fe ff ff b8 ea ff ff ff eb d0 <0f> 0b b8 ea ff ff ff e9 32 fe ff ff 48 89 df e8 a3 b7 00 00 85 c0
[   20.861645] RSP: 0000:ffff888119cff978 EFLAGS: 00010246
[   20.861649] RAX: dffffc0000000000 RBX: ffff8881158ce848 RCX: ffffffffb58c3df7
[   20.861652] RDX: 1ffff11022b19db7 RSI: 0000000000000004 RDI: ffff8881158b3440
[   20.861655] RBP: ffff888119cff9a8 R08: ffffed1014c62151 R09: ffffed1014c62151
[   20.861658] R10: 0000000000000001 R11: ffffed1014c62150 R12: ffff8881158cedb8
[   20.861661] R13: ffff8881158ceda0 R14: 1ffff11022b19d29 R15: 0000000000000000
[   20.861665] FS:  0000000000000000(0000) GS:ffff88811f200000(0000) knlGS:0000000000000000
[   20.861669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.861672] CR2: 00007f7ff4f1d5ad CR3: 000000011e254004 CR4: 00000000000606e0
[   20.861674] Call Trace:
[   20.861682]  ? pinctrl_bind_pins+0x2d6/0x830
[   20.861690]  really_probe+0x15f/0xd40
[   20.861700]  driver_probe_device+0xe9/0x3a0
[   20.861707]  __device_attach_driver+0x1c0/0x300
[   20.861713]  ? __driver_attach+0x360/0x360
[   20.861717]  bus_for_each_drv+0x10e/0x1b0
[   20.861722]  ? bus_rescan_devices+0x20/0x20
[   20.861728]  ? do_raw_spin_unlock+0x54/0x220
[   20.861737]  __device_attach+0x1df/0x2f0
[   20.861742]  ? device_bind_driver+0xb0/0xb0
[   20.861752]  device_attach+0xb/0x10
[   20.861765]  snd_hda_codec_configure+0x2c6/0x490 [snd_hda_codec]
[   20.861770]  ? vsprintf+0x20/0x20
[   20.861788]  azx_codec_configure+0x83/0x120 [snd_hda_codec]
[   20.861797]  azx_probe_continue+0xc5d/0x1aa0 [snd_hda_intel]
[   20.861802]  ? lock_downgrade+0x6c0/0x6c0
[   20.861814]  azx_probe_work+0x10/0x20 [snd_hda_intel]
[   20.861819]  process_one_work+0x9fb/0x1710
[   20.861828]  ? cancel_delayed_work_sync+0x10/0x10
[   20.861839]  worker_thread+0x85/0xee0
[   20.861844]  ? do_raw_spin_unlock+0x54/0x220
[   20.861855]  kthread+0x349/0x410
[   20.861859]  ? process_one_work+0x1710/0x1710
[   20.861863]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   20.861870]  ret_from_fork+0x35/0x40
[   20.861880] ---[ end trace d1246045466532f4 ]---
[   20.861909] snd_hda_codec_generic: probe of hdaudioC0D3 failed with error -22
[   20.861913] probe of hdaudioC0D3 returned 0 after 21288 usecs
[   20.861927] hdaudio hdaudioC0D3: Unable to bind the codec
[   20.864760] calling  hid_init+0x0/0x5d [hid] @ 226
[   20.875112] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 22969 usecs
[   20.878168] systemd-journald[178]: Compressed data object 753 -> 639 using LZ4
[   20.892164] hidraw: raw HID events driver (C) Jiri Kosina
[   20.925351] calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 450
[   20.925603] calling  media_devnode_init+0x0/0x1000 [media] @ 203
[   20.925606] media: Linux media interface: v0.10
[   20.925842] initcall media_devnode_init+0x0/0x1000 [media] returned 0 after 221 usecs
[   20.928655] initcall hid_init+0x0/0x5d [hid] returned 0 after 2960 usecs
[   20.941489] initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 24 usecs
[   21.154230] calling  hid_init+0x0/0x1000 [usbhid] @ 206
[   21.160997] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 211
[   21.194564] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 29657 usecs
[   21.206584] probe of 3-1.1:1.0 returned 1 after 45783 usecs
[   21.272670] Adding 10485756k swap on /dev/sda7.  Priority:-2 extents:1 across:10485756k FS
[   21.285760] probe of 3-1.2:1.0 returned 1 after 55318 usecs
[   21.311357] probe of 3-1.3:1.0 returned 1 after 23539 usecs
[   21.314083] usbcore: registered new interface driver usbhid
[   21.317120] usbhid: USB HID core driver
[   21.319702] initcall hid_init+0x0/0x1000 [usbhid] returned 0 after 151863 usecs
[   21.351780] calling  init_module+0x0/0x1000 [raid6_pq] @ 450
[   21.371425] raid6: sse2x4   gen()  6214 MB/s
[   21.391425] raid6: sse2x4   xor()  6544 MB/s
[   21.407179] calling  usb_kbd_driver_init+0x0/0x1000 [usbkbd] @ 206
[   21.410450] raid6: sse2x2   gen()  5464 MB/s
[   21.411197] usbcore: registered new interface driver usbkbd
[   21.417163] initcall usb_kbd_driver_init+0x0/0x1000 [usbkbd] returned 0 after 6372 usecs
[   21.430444] raid6: sse2x2   xor()  4041 MB/s
[   21.449436] raid6: sse2x1   gen()  5207 MB/s
[   21.454572] calling  videodev_init+0x0/0x1000 [videodev] @ 203
[   21.458394] videodev: Linux video capture interface: v2.00
[   21.461947] initcall videodev_init+0x0/0x1000 [videodev] returned 0 after 3446 usecs
[   21.469441] raid6: sse2x1   xor()  2910 MB/s
[   21.472898] raid6: using algorithm sse2x4 gen() 6214 MB/s
[   21.476401] raid6: .... xor() 6544 MB/s, rmw enabled
[   21.479906] raid6: using ssse3x2 recovery algorithm
[   21.483388] initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 24395 usecs
[   21.487562] calling  usb_mouse_driver_init+0x0/0x1000 [usbmouse] @ 226
[   21.490244] usbcore: registered new interface driver usbmouse
[   21.493407] initcall usb_mouse_driver_init+0x0/0x1000 [usbmouse] returned 0 after 3267 usecs
[   21.681452] calling  hid_generic_init+0x0/0x1000 [hid_generic] @ 214
[   21.684950] input: API API USB KB HUB as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.1/3-1.1:1.0/0003:04A5:0001.0002/input/input34
[   21.739537] calling  iwl_init+0x0/0x1000 [iwldvm] @ 350
[   21.742821] hid-generic 0003:04A5:0001.0002: input,hidraw0: USB HID v1.00 Keyboard [API API USB KB HUB] on usb-0000:05:00.0-1.1/input0
[   21.743821] iwlwifi 0000:04:00.0: CONFIG_IWLWIFI_DEBUG disabled
[   21.751446] iwlwifi 0000:04:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
[   21.755474] iwlwifi 0000:04:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
[   21.759502] iwlwifi 0000:04:00.0: Detected Intel(R) Centrino(R) Wireless-N 1000 BGN, REV=0x6C
[   21.769575] calling  calibrate_xor_blocks+0x0/0xe15 [xor] @ 450
[   21.772033] xor: automatically using best checksumming function   avx       
[   21.774442] initcall calibrate_xor_blocks+0x0/0xe15 [xor] returned 0 after 2346 usecs
[   21.808802] input: API API USB KB HUB as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.1/3-1.1:1.0/0003:04A5:0001.0002/input/input35
[   21.822088] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   21.877641] hid-generic 0003:04A5:0001.0002: input,hidraw0: USB HID v1.00 Keyboard [API API USB KB HUB] on usb-0000:05:00.0-1.1/input0
[   21.880273] probe of 0003:04A5:0001.0002 returned 1 after 196204 usecs
[   21.884616] input: HID 049c:0002 Consumer Control as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.2/3-1.2:1.0/0003:049C:0002.0004/input/input36
[   21.934070] calling  arc4_init+0x0/0x1000 [arc4] @ 588
[   21.941439] input: HID 049c:0002 System Control as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.2/3-1.2:1.0/0003:049C:0002.0004/input/input37
[   21.944503] initcall arc4_init+0x0/0x1000 [arc4] returned 0 after 7379 usecs
[   21.945884] input: HID 049c:0002 as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.2/3-1.2:1.0/0003:049C:0002.0004/input/input38
[   21.954759] hid-generic 0003:049C:0002.0004: input,hiddev96,hidraw1: USB HID v1.00 Device [HID 049c:0002] on usb-0000:05:00.0-1.2/input0
[   21.959602] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   21.970632] initcall iwl_init+0x0/0x1000 [iwldvm] returned 0 after 32881 usecs
[   21.974250] modprobe (350) used greatest stack depth: 25128 bytes left
[   21.994234] iwlwifi 0000:04:00.0 wlan1: renamed from wlan0
[   22.007870] input: HID 049c:0002 Consumer Control as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.2/3-1.2:1.0/0003:049C:0002.0004/input/input39
[   22.067124] input: HID 049c:0002 System Control as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.2/3-1.2:1.0/0003:049C:0002.0004/input/input40
[   22.072342] input: HID 049c:0002 as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.2/3-1.2:1.0/0003:049C:0002.0004/input/input41
[   22.076892] hid-generic 0003:049C:0002.0004: input,hiddev96,hidraw1: USB HID v1.00 Device [HID 049c:0002] on usb-0000:05:00.0-1.2/input0
[   22.081011] probe of 0003:049C:0002.0004 returned 1 after 198133 usecs
[   22.084960] input: Logitech Optical USB Mouse as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.3/3-1.3:1.0/0003:046D:C016.0006/input/input42
[   22.089278] hid-generic 0003:046D:C016.0006: input,hidraw2: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:05:00.0-1.3/input0
[   22.110206] input: Logitech Optical USB Mouse as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-1/3-1.3/3-1.3:1.0/0003:046D:C016.0006/input/input43
[   22.114608] hid-generic 0003:046D:C016.0006: input,hidraw2: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:05:00.0-1.3/input0
[   22.118883] probe of 0003:046D:C016.0006 returned 1 after 34711 usecs
[   22.122374] initcall hid_generic_init+0x0/0x1000 [hid_generic] returned 0 after 181080 usecs
[   22.371701] calling  init_btrfs_fs+0x0/0x125 [btrfs] @ 450
[   22.405294] Btrfs loaded, crc32c=crc32c-intel, assert=on
[   22.409753] initcall init_btrfs_fs+0x0/0x125 [btrfs] returned 0 after 31243 usecs
[   22.481992] calling  msr_init+0x0/0x1000 [msr] @ 598
[   22.488284] initcall msr_init+0x0/0x1000 [msr] returned 0 after 2816 usecs
[   22.526725] BTRFS: device fsid 05228891-5cb9-4635-ad3f-950539845ee1 devid 1 transid 173 /dev/sda6
[   22.745627] calling  uvc_init+0x0/0x1000 [uvcvideo] @ 203
[   22.828512] uvcvideo: Found UVC 1.00 device 2SF001 (0bda:58f5)
[   22.867638] uvcvideo 1-1.5:1.0: Entity type for entity Processing 2 was not initialized!
[   22.870871] uvcvideo 1-1.5:1.0: Entity type for entity Camera 1 was not initialized!
[   22.873948] uvcvideo 1-1.5:1.0: Entity type for entity Extension 4 was not initialized!
[   22.878067] input: 2SF001: TOSHIBA Web Camera as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input44
[   22.914515] uvcvideo: Found UVC 1.00 device 2SF001 (0bda:58f5)
[   22.953009] uvcvideo 1-1.5:1.0: Entity type for entity Processing 2 was not initialized!
[   22.958215] uvcvideo 1-1.5:1.0: Entity type for entity Camera 1 was not initialized!
[   22.961395] uvcvideo 1-1.5:1.0: Entity type for entity Extension 4 was not initialized!
[   22.969186] input: 2SF001: TOSHIBA Web Camera as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input45
[   22.973683] probe of 1-1.5:1.0 returned 1 after 168315 usecs
[   22.977406] usbcore: registered new interface driver uvcvideo
[   22.981094] USB Video Class driver (1.1.1)
[   22.984251] initcall uvc_init+0x0/0x1000 [uvcvideo] returned 0 after 229446 usecs
[   23.069307] calling  vmx_init+0x0/0x284 [kvm_intel] @ 222
[   23.082180] initcall vmx_init+0x0/0x284 [kvm_intel] returned 0 after 8629 usecs
[   23.253522] calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 209
[   23.257308] initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 301 usecs
[   23.341962] calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 222
[   23.347185] initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 715 usecs
[   23.354897] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 222
[   23.358418] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   23.386768] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 211
[   23.391420] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
[   23.483648] calling  rapl_init+0x0/0x1000 [intel_rapl] @ 225
[   23.487949] intel_rapl: Found RAPL domain package
[   23.491351] intel_rapl: Found RAPL domain core
[   23.495199] intel_rapl: Found RAPL domain uncore
[   23.498675] intel_rapl: RAPL package 0 domain package locked by BIOS
[   23.502658] initcall rapl_init+0x0/0x1000 [intel_rapl] returned 0 after 14965 usecs
[   23.619671] calling  hwmon_init+0x0/0x1000 [hwmon] @ 225
[   23.622641] initcall hwmon_init+0x0/0x1000 [hwmon] returned 0 after 114 usecs
[   23.685512] calling  coretemp_init+0x0/0x1000 [coretemp] @ 209
[   23.690267] probe of coretemp.0 returned 1 after 1350 usecs
[   23.694924] initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 6285 usecs
[   23.711048] systemd-udevd (205) used greatest stack depth: 24936 bytes left
[   23.717461] systemd-udevd (220) used greatest stack depth: 24816 bytes left
[   23.721407] systemd-udevd (219) used greatest stack depth: 24792 bytes left
[   23.774909] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   24.316693] EXT4-fs (sda9): mounted filesystem with ordered data mode. Opts: acl,user_xattr,data=ordered
[   24.344497] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   24.354401] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   24.361652] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   24.880596] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   24.989850] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   24.998099] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   26.582726] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   26.602087] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   26.613053] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   28.248441] systemd[1]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1 interface=org.freedesktop.systemd1.Manager member=UnitRemoved cookie=849 reply_cookie=0 error=n/a
[   28.454847] systemd-fstab-generator[872]: Parsing /etc/fstab
[   28.458610] systemd-fstab-generator[872]: Found entry what=/dev/sda8 where=/ type=ext4 nofail=no noauto=no
[   28.461842] systemd-fstab-generator[872]: Found entry what=/dev/sda9 where=/home type=ext4 nofail=no noauto=no
[   28.462252] systemd-fstab-generator[872]: Found entry what=/dev/sda7 where=swap type=swap nofail=no noauto=no
[   28.462746] systemd-fstab-generator[872]: Found entry what=/dev/sda6 where=/tester type=btrfs nofail=yes noauto=no
[   28.462998] systemd-fstab-generator[872]: Found entry what=/dev/sda5 where=/xfer type=vfat nofail=yes noauto=no
[   28.488036] systemd-gpt-auto-generator[874]: /dev/sda8: root device /dev/sda.
[   28.492421] systemd-sysv-generator[880]: Cannot find unit xfs.service.
[   28.496721] systemd-sysv-generator[880]: Loading SysV script /etc/init.d/xfs
[   28.497862] systemd-gpt-auto-generator[874]: No suitable partition table found, ignoring.
[   32.600431] systemd[1]: dev-ttyba.device: Changed dead -> plugged
[   32.600480] systemd[1]: lvm2-monitor.service: Changed dead -> exited
[   32.600519] systemd[1]: dev-disk-by\x2did-scsi\x2d350014ee606e89eab\x2dpart8.device: Changed dead -> plugged
[   32.600558] systemd[1]: dev-disk-by\x2dpartuuid-a5cb36ad\x2d09.device: Changed dead -> plugged
[   32.600596] systemd[1]: dev-ttyx7.device: Changed dead -> plugged
[   32.600632] systemd[1]: sys-devices-platform-serial8250-tty-ttyS3.device: Changed dead -> plugged
[   32.600672] systemd[1]: sys-devices-virtual-tty-ttyse.device: Changed dead -> plugged
[   32.600712] systemd[1]: dev-disk-by\x2did-scsi\x2d350014ee606e89eab\x2dpart7.device: Changed dead -> plugged
[   32.600753] systemd[1]: sys-devices-virtual-tty-ttyr4.device: Changed dead -> plugged
[   33.173008] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   33.349413] systemd[1]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1 interface=org.freedesktop.systemd1.Manager member=UnitRemoved cookie=164 reply_cookie=0 error=n/a
[   33.608383] systemd[1]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1 interface=org.freedesktop.systemd1.Manager member=UnitRemoved cookie=330 reply_cookie=0 error=n/a
[   34.504902] systemd-fstab-generator[923]: Parsing /etc/fstab
[   34.505121] systemd-fstab-generator[923]: Found entry what=/dev/sda8 where=/ type=ext4 nofail=no noauto=no
[   34.513434] systemd-fstab-generator[923]: Found entry what=/dev/sda9 where=/home type=ext4 nofail=no noauto=no
[   34.513920] systemd-fstab-generator[923]: Found entry what=/dev/sda7 where=swap type=swap nofail=no noauto=no
[   34.514442] systemd-fstab-generator[923]: Found entry what=/dev/sda6 where=/tester type=btrfs nofail=yes noauto=no
[   34.514820] systemd-fstab-generator[923]: Found entry what=/dev/sda5 where=/xfer type=vfat nofail=yes noauto=no
[   34.564378] systemd-sysv-generator[930]: Cannot find unit xfs.service.
[   34.565161] systemd-sysv-generator[930]: Loading SysV script /etc/init.d/xfs
[   34.568734] systemd-gpt-auto-generator[925]: /dev/sda8: root device /dev/sda.
[   34.572093] systemd-gpt-auto-generator[925]: No suitable partition table found, ignoring.
[   34.838410] calling  load_umh+0x0/0x1000 [bpfilter] @ 934
[   34.839576] bpfilter: Loaded bpfilter_umh pid 936
[   34.844086] initcall load_umh+0x0/0x1000 [bpfilter] returned 0 after 5499 usecs
[   34.906497] calling  xt_init+0x0/0x1000 [x_tables] @ 938
[   34.906556] initcall xt_init+0x0/0x1000 [x_tables] returned 0 after 34 usecs
[   34.973595] systemd[1]: dev-ttyba.device: Changed dead -> plugged
[   34.973628] systemd[1]: lvm2-monitor.service: Changed dead -> exited
[   34.973652] systemd[1]: dev-disk-by\x2did-scsi\x2d350014ee606e89eab\x2dpart8.device: Changed dead -> plugged
[   34.973678] systemd[1]: dev-disk-by\x2dpartuuid-a5cb36ad\x2d09.device: Changed dead -> plugged
[   34.973701] systemd[1]: dev-ttyx7.device: Changed dead -> plugged
[   34.973727] systemd[1]: sys-devices-platform-serial8250-tty-ttyS3.device: Changed dead -> plugged
[   34.973769] systemd[1]: sys-devices-virtual-tty-ttyse.device: Changed dead -> plugged
[   34.973799] systemd[1]: dev-disk-by\x2did-scsi\x2d350014ee606e89eab\x2dpart7.device: Changed dead -> plugged
[   34.987553] calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 938
[   34.987716] initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 128 usecs
[   35.068320] calling  iptable_filter_init+0x0/0x1000 [iptable_filter] @ 940
[   35.069049] initcall iptable_filter_init+0x0/0x1000 [iptable_filter] returned 0 after 668 usecs
[   35.160700] calling  ip6_tables_init+0x0/0x1000 [ip6_tables] @ 946
[   35.160894] initcall ip6_tables_init+0x0/0x1000 [ip6_tables] returned 0 after 157 usecs
[   35.180797] calling  ip6table_filter_init+0x0/0x1000 [ip6table_filter] @ 947
[   35.181597] initcall ip6table_filter_init+0x0/0x1000 [ip6table_filter] returned 0 after 747 usecs
[   35.394141] calling  ebtables_init+0x0/0x1000 [ebtables] @ 954
[   35.394175] initcall ebtables_init+0x0/0x1000 [ebtables] returned 0 after 1 usecs
[   35.410536] calling  ebtable_filter_init+0x0/0x1000 [ebtable_filter] @ 955
[   35.410854] initcall ebtable_filter_init+0x0/0x1000 [ebtable_filter] returned 0 after 279 usecs
[   35.460404] calling  iptable_security_init+0x0/0x1000 [iptable_security] @ 959
[   35.460702] initcall iptable_security_init+0x0/0x1000 [iptable_security] returned 0 after 258 usecs
[   35.512556] calling  iptable_raw_init+0x0/0x1000 [iptable_raw] @ 962
[   35.513140] initcall iptable_raw_init+0x0/0x1000 [iptable_raw] returned 0 after 531 usecs
[   35.555960] calling  iptable_mangle_init+0x0/0x1000 [iptable_mangle] @ 965
[   35.556656] initcall iptable_mangle_init+0x0/0x1000 [iptable_mangle] returned 0 after 648 usecs
[   35.595977] calling  nf_defrag_init+0x0/0x1000 [nf_defrag_ipv4] @ 968
[   35.596009] initcall nf_defrag_init+0x0/0x1000 [nf_defrag_ipv4] returned 0 after 1 usecs
[   35.622029] calling  nf_defrag_init+0x0/0x1000 [nf_defrag_ipv6] @ 968
[   35.623161] initcall nf_defrag_init+0x0/0x1000 [nf_defrag_ipv6] returned 0 after 1071 usecs
[   35.772856] calling  nf_conntrack_standalone_init+0x0/0x1000 [nf_conntrack] @ 973
[   35.779091] initcall nf_conntrack_standalone_init+0x0/0x1000 [nf_conntrack] returned 0 after 6038 usecs
[   35.807448] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   35.925554] calling  nf_nat_init+0x0/0x1000 [nf_nat] @ 968
[   35.925983] initcall nf_nat_init+0x0/0x1000 [nf_nat] returned 0 after 387 usecs
[   36.022987] calling  nf_nat_l3proto_ipv4_init+0x0/0x1000 [nf_nat_ipv4] @ 968
[   36.023020] initcall nf_nat_l3proto_ipv4_init+0x0/0x1000 [nf_nat_ipv4] returned 0 after 0 usecs
[   36.069925] calling  iptable_nat_init+0x0/0x1000 [iptable_nat] @ 968
[   36.070370] initcall iptable_nat_init+0x0/0x1000 [iptable_nat] returned 0 after 401 usecs
[   36.146069] calling  ip6table_security_init+0x0/0x1000 [ip6table_security] @ 986
[   36.146409] initcall ip6table_security_init+0x0/0x1000 [ip6table_security] returned 0 after 299 usecs
[   36.193026] calling  ip6table_raw_init+0x0/0x1000 [ip6table_raw] @ 989
[   36.194221] initcall ip6table_raw_init+0x0/0x1000 [ip6table_raw] returned 0 after 1133 usecs
[   36.292126] calling  ip6table_mangle_init+0x0/0x1000 [ip6table_mangle] @ 992
[   36.292676] initcall ip6table_mangle_init+0x0/0x1000 [ip6table_mangle] returned 0 after 503 usecs
[   36.378125] calling  nf_nat_l3proto_ipv6_init+0x0/0x1000 [nf_nat_ipv6] @ 995
[   36.378158] initcall nf_nat_l3proto_ipv6_init+0x0/0x1000 [nf_nat_ipv6] returned 0 after 0 usecs
[   36.431008] calling  ip6table_nat_init+0x0/0x1000 [ip6table_nat] @ 995
[   36.431629] initcall ip6table_nat_init+0x0/0x1000 [ip6table_nat] returned 0 after 577 usecs
[   36.570385] calling  llc_init+0x0/0x1000 [llc] @ 1000
[   36.570415] initcall llc_init+0x0/0x1000 [llc] returned 0 after 1 usecs
[   36.867317] calling  br_init+0x0/0x112 [bridge] @ 1000
[   36.872654] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   36.872725] initcall br_init+0x0/0x112 [bridge] returned 0 after 5219 usecs
[   36.890837] calling  ebtable_broute_init+0x0/0x1000 [ebtable_broute] @ 1000
[   36.891069] initcall ebtable_broute_init+0x0/0x1000 [ebtable_broute] returned 0 after 194 usecs
[   36.917229] calling  ebtable_nat_init+0x0/0x1000 [ebtable_nat] @ 1010
[   36.917780] initcall ebtable_nat_init+0x0/0x1000 [ebtable_nat] returned 0 after 506 usecs
[   37.014138] calling  nfnetlink_init+0x0/0x1000 [nfnetlink] @ 1014
[   37.014357] initcall nfnetlink_init+0x0/0x1000 [nfnetlink] returned 0 after 183 usecs
[   37.072071] calling  ip_set_init+0x0/0x1000 [ip_set] @ 1016
[   37.072172] initcall ip_set_init+0x0/0x1000 [ip_set] returned 0 after 68 usecs
[   37.241289] systemd-fstab-generator[1028]: Parsing /etc/fstab
[   37.241750] systemd-fstab-generator[1028]: Found entry what=/dev/sda8 where=/ type=ext4 nofail=no noauto=no
[   37.251807] systemd-fstab-generator[1028]: Found entry what=/dev/sda9 where=/home type=ext4 nofail=no noauto=no
[   37.252283] systemd-fstab-generator[1028]: Found entry what=/dev/sda7 where=swap type=swap nofail=no noauto=no
[   37.252813] systemd-fstab-generator[1028]: Found entry what=/dev/sda6 where=/tester type=btrfs nofail=yes noauto=no
[   37.253083] systemd-fstab-generator[1028]: Found entry what=/dev/sda5 where=/xfer type=vfat nofail=yes noauto=no
[   37.268261] systemd-gpt-auto-generator[1031]: /dev/sda8: root device /dev/sda.
[   37.270727] systemd-gpt-auto-generator[1031]: No suitable partition table found, ignoring.
[   37.283660] systemd-sysv-generator[1037]: Cannot find unit xfs.service.
[   37.284234] systemd-sysv-generator[1037]: Loading SysV script /etc/init.d/xfs
[   38.496093] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   39.023380] systemd[1]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1 interface=org.freedesktop.systemd1.Manager member=UnitRemoved cookie=374 reply_cookie=0 error=n/a
[   39.393389] calling  conntrack_mt_init+0x0/0x1000 [xt_conntrack] @ 1140
[   39.393423] initcall conntrack_mt_init+0x0/0x1000 [xt_conntrack] returned 0 after 1 usecs
[   39.447073] calling  reject_tg_init+0x0/0x1000 [ipt_REJECT] @ 1142
[   39.447105] initcall reject_tg_init+0x0/0x1000 [ipt_REJECT] returned 0 after 1 usecs
[   39.525622] calling  reject_tg6_init+0x0/0x1000 [ip6t_REJECT] @ 1146
[   39.525653] initcall reject_tg6_init+0x0/0x1000 [ip6t_REJECT] returned 0 after 1 usecs
[   39.780355] systemd[1]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1 interface=org.freedesktop.systemd1.Manager member=UnitRemoved cookie=4758 reply_cookie=0 error=n/a
[   39.950098] systemd-fstab-generator[1175]: Parsing /etc/fstab
[   39.957356] systemd-fstab-generator[1175]: Found entry what=/dev/sda8 where=/ type=ext4 nofail=no noauto=no
[   39.958223] systemd-fstab-generator[1175]: Found entry what=/dev/sda9 where=/home type=ext4 nofail=no noauto=no
[   39.971750] systemd-fstab-generator[1175]: Found entry what=/dev/sda7 where=swap type=swap nofail=no noauto=no
[   39.972241] systemd-fstab-generator[1175]: Found entry what=/dev/sda6 where=/tester type=btrfs nofail=yes noauto=no
[   39.976741] systemd-fstab-generator[1175]: Found entry what=/dev/sda5 where=/xfer type=vfat nofail=yes noauto=no
[   39.984539] systemd-gpt-auto-generator[1179]: /dev/sda8: root device /dev/sda.
[   39.989986] systemd-gpt-auto-generator[1179]: No suitable partition table found, ignoring.
[   40.009040] systemd-sysv-generator[1186]: Cannot find unit xfs.service.
[   40.009902] systemd-sysv-generator[1186]: Loading SysV script /etc/init.d/xfs
[   40.078656] calling  rpfilter_mt_init+0x0/0x1000 [ip6t_rpfilter] @ 1189
[   40.078688] initcall rpfilter_mt_init+0x0/0x1000 [ip6t_rpfilter] returned 0 after 1 usecs
[   40.136726] calling  tcpudp_mt_init+0x0/0x1000 [xt_tcpudp] @ 1192
[   40.136749] initcall tcpudp_mt_init+0x0/0x1000 [xt_tcpudp] returned 0 after 2 usecs
[   40.430551] systemd[1]: dev-ttyba.device: Changed dead -> plugged
[   40.430597] systemd[1]: lvm2-monitor.service: Changed dead -> exited
[   40.430634] systemd[1]: dev-disk-by\x2did-scsi\x2d350014ee606e89eab\x2dpart8.device: Changed dead -> plugged
[   40.430685] systemd[1]: dev-disk-by\x2dpartuuid-a5cb36ad\x2d09.device: Changed dead -> plugged
[   40.430725] systemd[1]: dev-ttyx7.device: Changed dead -> plugged
[   40.430760] systemd[1]: sys-devices-platform-serial8250-tty-ttyS3.device: Changed dead -> plugged
[   40.430801] systemd[1]: sys-devices-virtual-tty-ttyse.device: Changed dead -> plugged
[   40.430857] systemd[1]: NetworkManager.service: Changed dead -> start
[   41.122771] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.143361] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.161898] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.223220] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.232718] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.314722] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.335032] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.366687] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   41.450487] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   42.522918] iwlwifi 0000:04:00.0: Radio type=0x0-0x0-0x3
[   42.582107] iwlwifi 0000:04:00.0: Radio type=0x0-0x0-0x3
[   42.646073] iwlwifi 0000:04:00.0: Radio type=0x0-0x0-0x3
[   42.702839] iwlwifi 0000:04:00.0: Radio type=0x0-0x0-0x3
[   42.968697] calling  packet_init+0x0/0x1000 [af_packet] @ 1276
[   42.968724] NET: Registered protocol family 17
[   42.968798] initcall packet_init+0x0/0x1000 [af_packet] returned 0 after 67 usecs
[   43.549841] iwlwifi 0000:04:00.0: Radio type=0x0-0x0-0x3
[   43.620100] iwlwifi 0000:04:00.0: Radio type=0x0-0x0-0x3
[   44.078054] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   44.106957] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   44.157027] wlan1: authenticate with b0:39:56:90:0b:0b
[   44.162135] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[   44.164260] wlan1: authenticated
[   44.166338] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[   44.175567] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[   44.179517] wlan1: associated
[   44.229692] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   44.233765] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   44.261210] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   44.274163] calling  crypto_ccm_module_init+0x0/0x1000 [ccm] @ 1343
[   44.274197] initcall crypto_ccm_module_init+0x0/0x1000 [ccm] returned 0 after 1 usecs
[   44.392842] calling  crypto_ctr_module_init+0x0/0x1000 [ctr] @ 1357
[   44.392865] initcall crypto_ctr_module_init+0x0/0x1000 [ctr] returned 0 after 1 usecs
[   44.410571] IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
[   49.781785] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   50.467521] systemd-journald[178]: Data hash table of /run/log/journal/76eac4e178c44ff9901745852136d529/system.journal has a fill level at 75.0 (26198 of 34929 items, 16777216 file size, 640 bytes per hash table item), suggesting rotation.
[   50.467571] systemd-journald[178]: /run/log/journal/76eac4e178c44ff9901745852136d529/system.journal: Journal header limits reached or header out-of-date, rotating.
[   50.467606] systemd-journald[178]: Rotating...
[   50.472327] systemd-journald[178]: Reserving 34929 entries in hash table.
[   50.472825] systemd-journald[178]: Vacuuming...
[   50.473139] systemd-journald[178]: Vacuuming done, freed 0B of archived journals from /run/log/journal/76eac4e178c44ff9901745852136d529.
[   50.871377] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[   51.898432] ================================================================================
[   51.898454] UBSAN: Undefined behaviour in ../drivers/cpuidle/governors/menu.c:229:21
[   51.898467] signed integer overflow:
[   51.898478] 3758096350 * 3758096350 cannot be represented in type 'long long int'
[   51.898496] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.0.0-rc7mod #3
[   51.898507] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   51.898519] Call Trace:
[   51.898533]  dump_stack+0x7b/0xb5
[   51.898544]  ubsan_epilogue+0xd/0x81
[   51.898553]  handle_overflow+0x198/0x1d7
[   51.898564]  ? __ubsan_handle_negate_overflow+0x195/0x195
[   51.898575]  ? tick_nohz_get_sleep_length+0x121/0x1d0
[   51.898588]  ? ipv6_icmp_error+0x755/0x7f0
[   51.898597]  ? tick_nohz_next_event+0x1b3/0x4a0
[   51.898607]  ? can_stop_idle_tick+0x260/0x260
[   51.898617]  ? __switch_to_asm+0x40/0x70
[   51.898628]  ? calibrate_delay+0x25/0x2341
[   51.898637]  ? __switch_to_asm+0x34/0x70
[   51.898646]  ? common_interrupt+0xa/0xf
[   51.898658]  __ubsan_handle_mul_overflow+0xe/0x1c
[   51.898669]  menu_select+0x13d0/0x1df0
[   51.898682]  ? menu_enable_device+0x170/0x170
[   51.898691]  ? sched_clock+0x9/0x10
[   51.898701]  ? kasan_check_write+0x14/0x20
[   51.898711]  ? rcu_dynticks_eqs_exit+0x2c/0x80
[   51.898722]  cpuidle_select+0x5a/0xa0
[   51.898732]  do_idle+0x2aa/0x3c0
[   51.898742]  ? arch_cpu_idle_exit+0x40/0x40
[   51.898751]  ? kasan_check_read+0x11/0x20
[   51.898761]  ? do_raw_spin_unlock+0x54/0x220
[   51.898773]  cpu_startup_entry+0x18/0x20
[   51.898782]  rest_init+0x165/0x1a0
[   51.898793]  arch_call_rest_init+0x9/0x11
[   51.898803]  start_kernel+0x697/0x6bd
[   51.898813]  ? mem_encrypt_init+0x6/0x6
[   51.898822]  ? load_ucode_intel_bsp+0x53/0x8a
[   51.898832]  ? init_intel_microcode+0x1a4/0x1a4
[   51.898844]  ? load_ucode_bsp+0x1e8/0x21c
[   51.898854]  x86_64_start_reservations+0x24/0x26
[   51.898865]  x86_64_start_kernel+0x74/0x77
[   51.898874]  secondary_startup_64+0xa4/0xb0
[   51.898887] ================================================================================
[   63.155294] wlan1: disassociated from b0:39:56:90:0b:0b (Reason: 8=DISASSOC_STA_HAS_LEFT)
[   63.714780] wlan1: authenticate with b0:39:56:90:0b:0b
[   63.718641] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[   63.720866] wlan1: authenticated
[   63.722034] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[   63.742431] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[   63.746170] wlan1: associated
[   73.189994] wlan1: disassociated from b0:39:56:90:0b:0b (Reason: 8=DISASSOC_STA_HAS_LEFT)
[   73.877558] wlan1: authenticate with b0:39:56:90:0b:0b
[   73.881409] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[   73.906662] wlan1: send auth to b0:39:56:90:0b:0b (try 2/3)
[   73.931250] wlan1: send auth to b0:39:56:90:0b:0b (try 3/3)
[   73.958321] wlan1: authentication with b0:39:56:90:0b:0b timed out
[   80.514012] wlan1: authenticate with b0:39:56:90:0b:0b
[   80.516214] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[   80.519717] wlan1: authenticated
[   80.520179] wlan1: waiting for beacon from b0:39:56:90:0b:0b
[   80.523884] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[   80.533408] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[   80.537699] wlan1: associated
[  109.194421] systemd-journald[178]: Sent WATCHDOG=1 notification.
[  118.824708] wlan1: disassociated from b0:39:56:90:0b:0b (Reason: 8=DISASSOC_STA_HAS_LEFT)
[  119.419700] wlan1: authenticate with b0:39:56:90:0b:0b
[  119.423556] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[  119.425720] wlan1: authenticated
[  119.428436] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[  119.462199] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[  119.475615] wlan1: associated
[  128.859447] wlan1: disassociated from b0:39:56:90:0b:0b (Reason: 8=DISASSOC_STA_HAS_LEFT)
[  129.505432] wlan1: authenticate with b0:39:56:90:0b:0b
[  129.509109] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[  129.536880] wlan1: send auth to b0:39:56:90:0b:0b (try 2/3)
[  129.558309] wlan1: send auth to b0:39:56:90:0b:0b (try 3/3)
[  129.582531] wlan1: authentication with b0:39:56:90:0b:0b timed out
[  130.570618] wlan1: authenticate with b0:39:56:90:0b:0b
[  130.572873] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[  130.575007] wlan1: authenticated
[  130.575730] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[  130.585025] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[  130.589403] wlan1: associated
[  152.029448] systemd-journald[178]: Successfully sent stream file descriptor to service manager.
[  165.654317] wlan1: disassociated from b0:39:56:90:0b:0b (Reason: 8=DISASSOC_STA_HAS_LEFT)
[  166.303833] wlan1: authenticate with b0:39:56:90:0b:0b
[  166.307634] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[  166.309881] wlan1: authenticated
[  166.313435] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[  166.324613] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[  166.334660] wlan1: associated
[  175.689036] wlan1: disassociated from b0:39:56:90:0b:0b (Reason: 8=DISASSOC_STA_HAS_LEFT)
[  176.351419] wlan1: authenticate with b0:39:56:90:0b:0b
[  176.355297] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[  176.381888] wlan1: send auth to b0:39:56:90:0b:0b (try 2/3)
[  176.408391] wlan1: send auth to b0:39:56:90:0b:0b (try 3/3)
[  176.433722] wlan1: authentication with b0:39:56:90:0b:0b timed out
[  182.986360] wlan1: authenticate with b0:39:56:90:0b:0b
[  182.988811] wlan1: send auth to b0:39:56:90:0b:0b (try 1/3)
[  182.991937] wlan1: authenticated
[  182.992306] wlan1: waiting for beacon from b0:39:56:90:0b:0b
[  183.021431] wlan1: associate with b0:39:56:90:0b:0b (try 1/3)
[  183.041036] wlan1: RX AssocResp from b0:39:56:90:0b:0b (capab=0x431 status=0 aid=1)
[  183.045169] wlan1: associated


--------------AC70EEF5625217B09E672E0D--
