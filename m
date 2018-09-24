Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B947C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677A021480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZK/mm4jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeIXJeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 05:34:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIXJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 05:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tnI6ZV6oATjyWAVSaFf/CEihnyXiCnpDpL3ZWM554cM=; b=ZK/mm4jW5GQd7DkyJJ5Hyh3o4
        yiMbGhYSX2w77t+YkwsX5RSDZflnAhtcWcMhQAtOFld1tuBd8t02CuJp0Xd8Wvs+fgzNfi0sDXOda
        Xl3RbRH/aPhbdUcX+IaDGhXBg9Q4Hhlwu0VIK1zngt8HlhEDq3YtsJLwVt0TfWCW2M4Uacv3noo8G
        5iNrvXFDgQSm1FEMZSPA8jzkL2gh7BO7zku/q/bPZ1DI2ZVj8PSCacUx9cC1jLqp5fb0Wi4mJLHwk
        WrIG/Uw/5IywR5bgRuw2TNEdDnMvSvPy6h5U2NedccWq9qe5ct0cUxT0ST5ws9yD25vHvAyegw9Wj
        0B76ZG9gw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4HdY-0008OM-6K; Mon, 24 Sep 2018 03:34:16 +0000
To:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        axboe <axboe@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: libata-core WARNING during boot
Message-ID: <b9b55c84-a90c-e7ac-add7-fdf1b7e13dc6@infradead.org>
Date:   Sun, 23 Sep 2018 20:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having (repeatable) problems booting 4.18 and 4.18.9 (latest stable):

WARNING: CPU: 1 PID: 1 at ../drivers/ata/libata-core.c:6677 ata_host_detach+0x6e/0x150


It never completes the boot.  Could that be due to this eh warning?

Full boot log is below.
Any suggestions?  what more info would help?

thanks.
~~~

[    0.000000] Linux version 4.18.9 (rdunlap@dragon.dunlab) (gcc version 7.3.1 20180323 [gcc-7-branch revision 258812] (SUSE Linux)) #2 SMP Sun Sep 23 13:58:26 PDT 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/bzImage-418.9 root=/dev/sda8 resume=/dev/sda7 splash=native quiet showopts selinux=0 audit=0 debug initcall_debug ignore_loglevel logo.nologo vga=0x317 fbcon=font:VGA8x8 video=vesafb earlyprintk=dbgp1,keep
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
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
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlydbg0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x14fe00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 uncachable
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0AC000000 mask FFC000000 uncachable
[    0.000000]   5 base 0AB800000 mask FFF800000 uncachable
[    0.000000]   6 base 100000000 mask F80000000 write-back
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xab800000-0xffffffff] usable ==> reserved
Memory KASLR using RDTSC...
[    0.000000] last_pfn = 0xaa5d0 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] BRK [0x47aaa000, 0x47aaafff] PGTABLE
[    0.000000] BRK [0x47aab000, 0x47aabfff] PGTABLE
[    0.000000] BRK [0x47aac000, 0x47aacfff] PGTABLE
[    0.000000] BRK [0x47aad000, 0x47aadfff] PGTABLE
[    0.000000] BRK [0x47aae000, 0x47aaefff] PGTABLE
[    0.000000] BRK [0x47aaf000, 0x47aaffff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0030 000014 (v00 TOSHIB)
[    0.000000] ACPI: RSDT 0x00000000AA6EF038 000050 (v01 TOSHIB A007D    00000004      01000013)
[    0.000000] ACPI: FACP 0x00000000AA6EE000 000081 (v02 TOSHIB A007D    00000004 LOHR 0000005F)
[    0.000000] ACPI: DSDT 0x00000000AA6DD000 008A46 (v02 TOSHIB A007D    20111220 INTL 20061109)
[    0.000000] ACPI: FACS 0x00000000AA6BE000 000040
[    0.000000] ACPI: HPET 0x00000000AA6ED000 000038 (v01 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.000000] ACPI: APIC 0x00000000AA6EC000 0000BC (v01 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.000000] ACPI: MCFG 0x00000000AA6EB000 00003C (v01 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.000000] ACPI: ASF! 0x00000000AA6EA000 0000A0 (v32 TOSHIB A007D    00000001 LOHR 0000005F)
[    0.000000] ACPI: BOOT 0x00000000AA6E8000 000028 (v01 TOSHIB A007D    00000000 LOHR 0000005F)
[    0.000000] ACPI: SLIC 0x00000000AA6E7000 000176 (v01 TOSHIB A007D    00000000 LOHR 0000005F)
[    0.000000] ACPI: SSDT 0x00000000AA6DC000 000395 (v01 TOSHIB SataAhci 00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000AA6D9000 000720 (v01 TOSHIB PtidDevc 00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000AA6D7000 0007E5 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000AA6D6000 000996 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000014fdfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x14fdbe000-0x14fdfcfff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000014fdfffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000040200000-0x00000000aa5cffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000014fdfffff]
[    0.000000] Reserved but unavailable: 24211 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000014fdfffff]
[    0.000000] On node 0 totalpages: 1023853
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 157 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10824 pages used for memmap
[    0.000000]   DMA32 zone: 692688 pages, LIFO batch:31
[    0.000000]   Normal zone: 5112 pages used for memmap
[    0.000000]   Normal zone: 327168 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at [mem 0xaba00000-0xaf9fffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa5d0000-0xaa5d0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa5d1000-0xaa5d2fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa5d3000-0xaa6cffff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa6d0000-0xaa6effff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa6f0000-0xaf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xafa00000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.000000] [mem 0xafa00000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x8f/0x4ff with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] percpu: Embedded 526 pages/cpu @(____ptrval____) s2117632 r8192 d28672 u4194304
[    0.000000] pcpu-alloc: s2117632 r8192 d28672 u4194304 alloc=2*2097152
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1007696
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/bzImage-418.9 root=/dev/sda8 resume=/dev/sda7 splash=native quiet showopts selinux=0 audit=0 debug initcall_debug ignore_loglevel logo.nologo vga=0x317 fbcon=font:VGA8x8 video=vesafb earlyprintk=dbgp1,keep
[    0.000000] audit: disabled (until reboot)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 2793544K/4095412K available (10252K kernel code, 14532K rwdata, 3880K rodata, 3964K init, 20296K bss, 207360K reserved, 0K cma-reserved)
[    0.000000] random: get_random_u64 called from __kmem_cache_create+0x41/0x580 with crng_init=0
[    0.000000] random: get_random_u64 called from cache_random_seq_create+0x60/0x150 with crng_init=0
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.000000] 	RCU debug extended QS entry/exit.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 7871 kB
[    0.000000]  per task-struct memory footprint: 2688 bytes
[    0.000000] ACPI: Core revision 20180531
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.020000] tsc: Fast TSC calibration using PIT
[    0.024000] tsc: Detected 2394.474 MHz processor
[    0.024000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2283d35fca1, max_idle_ns: 440795239061 ns
[    0.024000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4788.94 BogoMIPS (lpj=9577896)
[    0.028004] pid_max: default: 32768 minimum: 301
[    0.029059] Security Framework initialized
[    0.029751] Yama: becoming mindful.
[    0.032034] LoadPin: ready to pin (currently enabled)
[    0.032042] AppArmor: AppArmor disabled by boot time parameter
[    0.034983] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.036395] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.037799] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.039012] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.040942] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.041996] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.044007] mce: CPU supports 7 MCE banks
[    0.044766] CPU0: Thermal monitoring enabled (TM1)
[    0.045632] process: using mwait in idle threads
[    0.046498] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.047496] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.048005] Spectre V2 : Mitigation: Full generic retpoline
[    0.048997] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.050497] Speculative Store Bypass: Vulnerable
[    0.052112] Freeing SMP alternatives memory: 24K
[    0.053941] TSC deadline timer enabled
[    0.054628] smpboot: CPU0: Intel(R) Core(TM) i5-2435M CPU @ 2.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.056000] calling  init_hw_perf_events+0x0/0x5e1 @ 1
[    0.056000] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.056006] core: PEBS disabled due to CPU errata, please upgrade microcode
[    0.057259] ... version:                3
[    0.057996] ... bit width:              48
[    0.058747] ... generic registers:      4
[    0.059496] ... value mask:             0000ffffffffffff
[    0.060004] ... max period:             00007fffffffffff
[    0.060997] ... fixed-purpose events:   3
[    0.061747] ... event mask:             000000070000000f
[    0.062777] initcall init_hw_perf_events+0x0/0x5e1 returned 0 after 7812 usecs
[    0.064006] calling  init_real_mode+0x0/0x1a5 @ 1
[    0.064894] initcall init_real_mode+0x0/0x1a5 returned 0 after 0 usecs
[    0.066126] calling  register_nmi_cpu_backtrace_handler+0x0/0x11 @ 1
[    0.067377] initcall register_nmi_cpu_backtrace_handler+0x0/0x11 returned 0 after 0 usecs
[    0.068005] calling  numachip_system_init+0x0/0x64 @ 1
[    0.069000] initcall numachip_system_init+0x0/0x64 returned 0 after 0 usecs
[    0.070249] calling  early_efi_map_fb+0x0/0x2f @ 1
[    0.071124] initcall early_efi_map_fb+0x0/0x2f returned 0 after 0 usecs
[    0.072006] calling  spawn_ksoftirqd+0x0/0x3b @ 1
[    0.072997] initcall spawn_ksoftirqd+0x0/0x3b returned 0 after 0 usecs
[    0.074251] calling  migration_init+0x0/0x2f @ 1
[    0.075127] initcall migration_init+0x0/0x2f returned 0 after 0 usecs
[    0.076004] calling  check_cpu_stall_init+0x0/0x16 @ 1
[    0.077004] initcall check_cpu_stall_init+0x0/0x16 returned 0 after 0 usecs
[    0.078250] calling  srcu_bootup_announce+0x0/0x2b @ 1
[    0.079249] Hierarchical SRCU implementation.
[    0.080004] initcall srcu_bootup_announce+0x0/0x2b returned 0 after 3906 usecs
[    0.081375] calling  rcu_register_oom_notifier+0x0/0xf @ 1
[    0.082378] initcall rcu_register_oom_notifier+0x0/0xf returned 0 after 0 usecs
[    0.083750] calling  rcu_spawn_gp_kthread+0x0/0x14a @ 1
[    0.084152] initcall rcu_spawn_gp_kthread+0x0/0x14a returned 0 after 0 usecs
[    0.085501] calling  cpu_stop_init+0x0/0xa4 @ 1
[    0.086465] initcall cpu_stop_init+0x0/0xa4 returned 0 after 0 usecs
[    0.087625] calling  jump_label_test+0x0/0xda @ 1
[    0.088143] initcall jump_label_test+0x0/0xda returned 0 after 0 usecs
[    0.089375] calling  jump_label_init_module+0x0/0xc @ 1
[    0.090380] initcall jump_label_init_module+0x0/0xc returned 0 after 0 usecs
[    0.091750] calling  dynamic_debug_init+0x0/0x23c @ 1
[    0.093096] initcall dynamic_debug_init+0x0/0x23c returned 0 after 0 usecs
[    0.094376] calling  rand_initialize+0x0/0x60 @ 1
[    0.095300] initcall rand_initialize+0x0/0x60 returned 0 after 0 usecs
[    0.096007] calling  initialize_ptr_random+0x0/0x35 @ 1
[    0.097002] initcall initialize_ptr_random+0x0/0x35 returned 0 after 0 usecs
[    0.099529] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.100071] smp: Bringing up secondary CPUs ...
[    0.101404] x86: Booting SMP configuration:
[    0.102122] .... node  #0, CPUs:      #1 #2 #3
[    0.108101] smp: Brought up 1 node, 4 CPUs
[    0.109568] smpboot: Max logical packages: 2
[    0.110454] ----------------
[    0.111068] | NMI testsuite:
[    0.111693] --------------------
[    0.112008]   remote IPI:  ok  |
[    0.112623]    local IPI:  ok  |
[    0.113253] --------------------
[    0.113872] Good, all   2 testcases passed! |
[    0.114749] ---------------------------------
[    0.115624] smpboot: Total of 4 processors activated (19155.79 BogoMIPS)
[    0.132018] node 0 initialised, 273627 pages in 16ms
[    0.133103] pgdatinit0 (33) used greatest stack depth: 15320 bytes left
[    0.136579] devtmpfs: initialized
[    0.137064] x86/mm: Memory block size: 128MB
[    0.142646] calling  ipc_ns_init+0x0/0x52 @ 1
[    0.143453] initcall ipc_ns_init+0x0/0x52 returned 0 after 0 usecs
[    0.144007] calling  init_mmap_min_addr+0x0/0x11 @ 1
[    0.144999] initcall init_mmap_min_addr+0x0/0x11 returned 0 after 0 usecs
[    0.146249] calling  net_ns_init+0x0/0x10a @ 1
[    0.147264] initcall net_ns_init+0x0/0x10a returned 0 after 0 usecs
[    0.148081] calling  xen_pvh_gnttab_setup+0x0/0x2f @ 1
[    0.149000] initcall xen_pvh_gnttab_setup+0x0/0x2f returned -19 after 0 usecs
[    0.150375] calling  e820__register_nvs_regions+0x0/0x33 @ 1
[    0.151504] PM: Registering ACPI NVS region [mem 0xaa5d0000-0xaa5d01ff] (512 bytes)
[    0.152011] PM: Registering ACPI NVS region [mem 0xaa5d3000-0xaa6cffff] (1036288 bytes)
[    0.154141] initcall e820__register_nvs_regions+0x0/0x33 returned 0 after 3906 usecs
[    0.155623] calling  cpufreq_register_tsc_scaling+0x0/0x2a @ 1
[    0.156007] initcall cpufreq_register_tsc_scaling+0x0/0x2a returned 0 after 0 usecs
[    0.157375] calling  init_cpu_syscore+0x0/0xf @ 1
[    0.158255] initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
[    0.159499] calling  reboot_init+0x0/0x38 @ 1
[    0.160009] initcall reboot_init+0x0/0x38 returned 0 after 0 usecs
[    0.161126] calling  init_lapic_sysfs+0x0/0x1c @ 1
[    0.162000] initcall init_lapic_sysfs+0x0/0x1c returned 0 after 0 usecs
[    0.163251] calling  uv_bau_init+0x0/0xe84 @ 1
[    0.164006] initcall uv_bau_init+0x0/0xe84 returned 0 after 0 usecs
[    0.165124] calling  cpu_hotplug_pm_sync_init+0x0/0xf @ 1
[    0.166131] initcall cpu_hotplug_pm_sync_init+0x0/0xf returned 0 after 0 usecs
[    0.167500] calling  alloc_frozen_cpus+0x0/0x19 @ 1
[    0.168010] initcall alloc_frozen_cpus+0x0/0x19 returned 0 after 0 usecs
[    0.169248] calling  wq_sysfs_init+0x0/0x26 @ 1
[    0.170237] initcall wq_sysfs_init+0x0/0x26 returned 0 after 0 usecs
[    0.171500] calling  ksysfs_init+0x0/0x8e @ 1
[    0.172056] initcall ksysfs_init+0x0/0x8e returned 0 after 0 usecs
[    0.173124] calling  pm_init+0x0/0x75 @ 1
[    0.174025] initcall pm_init+0x0/0x75 returned 0 after 0 usecs
[    0.175124] calling  pm_disk_init+0x0/0x13 @ 1
[    0.176027] initcall pm_disk_init+0x0/0x13 returned 0 after 3906 usecs
[    0.177246] calling  swsusp_header_init+0x0/0x30 @ 1
[    0.178246] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    0.179494] calling  rcu_spawn_tasks_kthread+0x0/0x3f @ 1
[    0.180072] initcall rcu_spawn_tasks_kthread+0x0/0x3f returned 0 after 0 usecs
[    0.181417] calling  rcu_set_runtime_mode+0x0/0xd @ 1
[    0.182417] initcall rcu_set_runtime_mode+0x0/0xd returned 0 after 0 usecs
[    0.183666] calling  init_jiffies_clocksource+0x0/0x13 @ 1
[    0.183666] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.183666] initcall init_jiffies_clocksource+0x0/0x13 returned 0 after 0 usecs
[    0.184006] calling  futex_init+0x0/0x113 @ 1
[    0.184905] futex hash table entries: 2048 (order: 6, 262144 bytes)
[    0.186070] initcall futex_init+0x0/0x113 returned 0 after 0 usecs
[    0.187125] calling  cgroup_wq_init+0x0/0x32 @ 1
[    0.191877] initcall cgroup_wq_init+0x0/0x32 returned 0 after 0 usecs
[    0.192004] calling  cgroup1_wq_init+0x0/0x32 @ 1
[    0.193985] initcall cgroup1_wq_init+0x0/0x32 returned 0 after 0 usecs
[    0.193985] calling  init_per_zone_wmark_min+0x0/0x70 @ 1
[    0.196019] initcall init_per_zone_wmark_min+0x0/0x70 returned 0 after 0 usecs
[    0.197375] calling  init_zero_pfn+0x0/0x1a @ 1
[    0.198251] initcall init_zero_pfn+0x0/0x1a returned 0 after 0 usecs
[    0.199501] calling  memory_failure_init+0x0/0xd7 @ 1
[    0.200007] initcall memory_failure_init+0x0/0xd7 returned 0 after 0 usecs
[    0.201250] calling  cma_init_reserved_areas+0x0/0x1b9 @ 1
[    0.202250] initcall cma_init_reserved_areas+0x0/0x1b9 returned 0 after 0 usecs
[    0.204018] calling  fsnotify_init+0x0/0x52 @ 1
[    0.205234] initcall fsnotify_init+0x0/0x52 returned 0 after 0 usecs
[    0.205345] calling  filelock_init+0x0/0xa2 @ 1
[    0.206260] initcall filelock_init+0x0/0xa2 returned 0 after 0 usecs
[    0.208007] calling  init_elf_binfmt+0x0/0x11 @ 1
[    0.208881] initcall init_elf_binfmt+0x0/0x11 returned 0 after 0 usecs
[    0.210123] calling  init_compat_elf_binfmt+0x0/0x11 @ 1
[    0.211124] initcall init_compat_elf_binfmt+0x0/0x11 returned 0 after 0 usecs
[    0.212007] calling  configfs_init+0x0/0x8f @ 1
[    0.212897] initcall configfs_init+0x0/0x8f returned 0 after 0 usecs
[    0.214123] calling  debugfs_init+0x0/0x4e @ 1
[    0.215004] initcall debugfs_init+0x0/0x4e returned 0 after 0 usecs
[    0.216006] calling  securityfs_init+0x0/0x64 @ 1
[    0.216974] initcall securityfs_init+0x0/0x64 returned 0 after 0 usecs
[    0.218250] calling  prandom_init+0x0/0x190 @ 1
[    0.219124] prandom: seed boundary self test passed
[    0.220519] prandom: 100 self tests passed
[    0.221246] initcall prandom_init+0x0/0x190 returned 0 after 3906 usecs
[    0.222494] calling  pinctrl_init+0x0/0xa9 @ 1
[    0.223368] pinctrl core: initialized pinctrl subsystem
[    0.224112] initcall pinctrl_init+0x0/0xa9 returned 0 after 3906 usecs
[    0.225374] calling  gpiolib_dev_init+0x0/0xc6 @ 1
[    0.226326] initcall gpiolib_dev_init+0x0/0xc6 returned 0 after 0 usecs
[    0.227498] calling  sfi_sysfs_init+0x0/0xc8 @ 1
[    0.228006] initcall sfi_sysfs_init+0x0/0xc8 returned 0 after 0 usecs
[    0.229248] calling  regulator_init+0x0/0x87 @ 1
[    0.230716] regulator-dummy: Failed to create debugfs directory
[    0.231813] initcall regulator_init+0x0/0x87 returned 0 after 0 usecs
[    0.232006] calling  iommu_init+0x0/0x26 @ 1
[    0.232882] initcall iommu_init+0x0/0x26 returned 0 after 0 usecs
[    0.233997] calling  component_debug_init+0x0/0x18 @ 1
[    0.235010] initcall component_debug_init+0x0/0x18 returned 0 after 0 usecs
[    0.236006] calling  genpd_bus_init+0x0/0xc @ 1
[    0.236921] initcall genpd_bus_init+0x0/0xc returned 0 after 0 usecs
[    0.238124] calling  opp_debug_init+0x0/0x37 @ 1
[    0.239010] initcall opp_debug_init+0x0/0x37 returned 0 after 0 usecs
[    0.240005] calling  cpufreq_core_init+0x0/0x47 @ 1
[    0.240884] initcall cpufreq_core_init+0x0/0x47 returned 0 after 0 usecs
[    0.242124] calling  cpuidle_init+0x0/0x36 @ 1
[    0.243018] initcall cpuidle_init+0x0/0x36 returned 0 after 0 usecs
[    0.244006] calling  capsule_reboot_register+0x0/0xc @ 1
[    0.245002] initcall capsule_reboot_register+0x0/0xc returned 0 after 0 usecs
[    0.246375] calling  bsp_pm_check_init+0x0/0xf @ 1
[    0.247251] initcall bsp_pm_check_init+0x0/0xf returned 0 after 0 usecs
[    0.248006] calling  sock_init+0x0/0x95 @ 1
[    0.249104] initcall sock_init+0x0/0x95 returned 0 after 0 usecs
[    0.250250] calling  net_inuse_init+0x0/0x1f @ 1
[    0.251131] initcall net_inuse_init+0x0/0x1f returned 0 after 0 usecs
[    0.252006] calling  net_defaults_init+0x0/0x1f @ 1
[    0.252875] initcall net_defaults_init+0x0/0x1f returned 0 after 0 usecs
[    0.254124] calling  init_default_flow_dissectors+0x0/0x4b @ 1
[    0.255251] initcall init_default_flow_dissectors+0x0/0x4b returned 0 after 0 usecs
[    0.256006] calling  netpoll_init+0x0/0x3c @ 1
[    0.256876] initcall netpoll_init+0x0/0x3c returned 0 after 0 usecs
[    0.258001] calling  netlink_proto_init+0x0/0x152 @ 1
[    0.259299] NET: Registered protocol family 16
[    0.260107] initcall netlink_proto_init+0x0/0x152 returned 0 after 3906 usecs
[    0.261500] calling  __gnttab_init+0x0/0x30 @ 1
[    0.262373] initcall __gnttab_init+0x0/0x30 returned -19 after 0 usecs
[    0.263691] calling  irq_sysfs_init+0x0/0x91 @ 1
[    0.264654] initcall irq_sysfs_init+0x0/0x91 returned 0 after 0 usecs
[    0.265874] calling  audit_init+0x0/0x1b2 @ 1
[    0.266750] initcall audit_init+0x0/0x1b2 returned 0 after 0 usecs
[    0.267875] calling  bdi_class_init+0x0/0x44 @ 1
[    0.268047] initcall bdi_class_init+0x0/0x44 returned 0 after 0 usecs
[    0.269249] calling  mm_sysfs_init+0x0/0x24 @ 1
[    0.270132] initcall mm_sysfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.271374] calling  gpiolib_sysfs_init+0x0/0x9b @ 1
[    0.272040] initcall gpiolib_sysfs_init+0x0/0x9b returned 0 after 0 usecs
[    0.273249] calling  pcibus_class_init+0x0/0x13 @ 1
[    0.274143] initcall pcibus_class_init+0x0/0x13 returned 0 after 0 usecs
[    0.275374] calling  pci_driver_init+0x0/0x1d @ 1
[    0.276109] initcall pci_driver_init+0x0/0x1d returned 0 after 0 usecs
[    0.277373] calling  backlight_class_init+0x0/0xa1 @ 1
[    0.278406] initcall backlight_class_init+0x0/0xa1 returned 0 after 0 usecs
[    0.279624] calling  xenbus_init+0x0/0x27e @ 1
[    0.280006] initcall xenbus_init+0x0/0x27e returned -19 after 0 usecs
[    0.281247] calling  tty_class_init+0x0/0x2f @ 1
[    0.282149] initcall tty_class_init+0x0/0x2f returned 0 after 0 usecs
[    0.283373] calling  vtconsole_class_init+0x0/0xd3 @ 1
[    0.284127] initcall vtconsole_class_init+0x0/0xd3 returned 0 after 0 usecs
[    0.285374] calling  iommu_dev_init+0x0/0x13 @ 1
[    0.286269] initcall iommu_dev_init+0x0/0x13 returned 0 after 0 usecs
[    0.287499] calling  mipi_dsi_bus_init+0x0/0xc @ 1
[    0.288050] initcall mipi_dsi_bus_init+0x0/0xc returned 0 after 0 usecs
[    0.289250] calling  wakeup_sources_debugfs_init+0x0/0x1f @ 1
[    0.290388] initcall wakeup_sources_debugfs_init+0x0/0x1f returned 0 after 0 usecs
[    0.291749] calling  isa_bus_init+0x0/0x37 @ 1
[    0.292102] initcall isa_bus_init+0x0/0x37 returned 0 after 0 usecs
[    0.293248] calling  register_node_type+0x0/0x2a @ 1
[    0.294356] initcall register_node_type+0x0/0x2a returned 0 after 0 usecs
[    0.295624] calling  regmap_initcall+0x0/0x8 @ 1
[    0.296025] initcall regmap_initcall+0x0/0x8 returned 0 after 0 usecs
[    0.297251] calling  sram_init+0x0/0xe @ 1
[    0.298042] initcall sram_init+0x0/0xe returned 0 after 0 usecs
[    0.299126] calling  syscon_init+0x0/0xe @ 1
[    0.300036] initcall syscon_init+0x0/0xe returned 0 after 3906 usecs
[    0.301243] calling  spi_init+0x0/0xc8 @ 1
[    0.302088] initcall spi_init+0x0/0xc8 returned 0 after 0 usecs
[    0.303118] calling  i2c_init+0x0/0xd0 @ 1
[    0.303968] initcall i2c_init+0x0/0xd0 returned 0 after 0 usecs
[    0.304005] calling  init_ladder+0x0/0x1f @ 1
[    0.304879] workqueue: round-robin CPU selection forced, expect performance impact
[    0.306275] cpuidle: using governor ladder
[    0.306275] initcall init_ladder+0x0/0x1f returned 0 after 0 usecs
[    0.308012] calling  init_menu+0x0/0xc @ 1
[    0.308813] cpuidle: using governor menu
[    0.308813] initcall init_menu+0x0/0xc returned 0 after 0 usecs
[    0.309877] calling  pcc_init+0x0/0x90 @ 1
[    0.310629] initcall pcc_init+0x0/0x90 returned -19 after 0 usecs
[    0.312008] calling  amd_postcore_init+0x0/0x119 @ 1
[    0.313000] initcall amd_postcore_init+0x0/0x119 returned 0 after 0 usecs
[    0.314250] calling  broadcom_postcore_init+0x0/0x48 @ 1
[    0.315324] initcall broadcom_postcore_init+0x0/0x48 returned 0 after 0 usecs
[    0.316012] calling  kobject_uevent_init+0x0/0xc @ 1
[    0.317030] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
[    0.318316] calling  bts_init+0x0/0xb6 @ 1
[    0.318999] initcall bts_init+0x0/0xb6 returned -19 after 0 usecs
[    0.320006] calling  pt_init+0x0/0x34e @ 1
[    0.320749] initcall pt_init+0x0/0x34e returned -19 after 0 usecs
[    0.321874] calling  boot_params_ksysfs_init+0x0/0x28b @ 1
[    0.322891] initcall boot_params_ksysfs_init+0x0/0x28b returned 0 after 0 usecs
[    0.324005] calling  sbf_init+0x0/0xc6 @ 1
[    0.324751] Simple Boot Flag at 0x7c set to 0x1
[    0.325627] initcall sbf_init+0x0/0xc6 returned 0 after 0 usecs
[    0.326749] calling  arch_kdebugfs_init+0x0/0x242 @ 1
[    0.327817] initcall arch_kdebugfs_init+0x0/0x242 returned 0 after 0 usecs
[    0.328006] calling  intel_pconfig_init+0x0/0xe4 @ 1
[    0.329001] initcall intel_pconfig_init+0x0/0xe4 returned 0 after 0 usecs
[    0.330248] calling  mtrr_if_init+0x0/0x59 @ 1
[    0.331142] initcall mtrr_if_init+0x0/0x59 returned 0 after 0 usecs
[    0.332008] calling  kvm_setup_pv_tlb_flush+0x0/0x81 @ 1
[    0.332999] initcall kvm_setup_pv_tlb_flush+0x0/0x81 returned 0 after 0 usecs
[    0.334374] calling  activate_jump_labels+0x0/0x2d @ 1
[    0.335374] initcall activate_jump_labels+0x0/0x2d returned 0 after 0 usecs
[    0.336005] calling  gigantic_pages_init+0x0/0x2a @ 1
[    0.337000] initcall gigantic_pages_init+0x0/0x2a returned 0 after 0 usecs
[    0.338251] calling  intel_mid_platform_init+0x0/0x31 @ 1
[    0.339252] initcall intel_mid_platform_init+0x0/0x31 returned 0 after 0 usecs
[    0.340005] calling  mrfld_pinctrl_init+0x0/0x1b @ 1
[    0.340999] initcall mrfld_pinctrl_init+0x0/0x1b returned -19 after 0 usecs
[    0.342248] calling  mrfld_sd_init+0x0/0x1c @ 1
[    0.343125] initcall mrfld_sd_init+0x0/0x1c returned -19 after 0 usecs
[    0.344005] calling  msic_init+0x0/0x1f @ 1
[    0.344751] initcall msic_init+0x0/0x1f returned 0 after 0 usecs
[    0.345875] calling  register_mrfld_power_btn+0x0/0x24 @ 1
[    0.346875] initcall register_mrfld_power_btn+0x0/0x24 returned -19 after 0 usecs
[    0.348005] calling  mrfld_legacy_rtc_init+0x0/0x8d @ 1
[    0.349000] initcall mrfld_legacy_rtc_init+0x0/0x8d returned -19 after 0 usecs
[    0.350373] calling  register_mid_wdt+0x0/0x2f @ 1
[    0.351250] initcall register_mid_wdt+0x0/0x2f returned -19 after 0 usecs
[    0.352005] calling  uv_rtc_setup_clock+0x0/0x27b @ 1
[    0.353000] initcall uv_rtc_setup_clock+0x0/0x27b returned -19 after 0 usecs
[    0.354375] calling  kcmp_cookies_init+0x0/0x33 @ 1
[    0.355254] initcall kcmp_cookies_init+0x0/0x33 returned 0 after 0 usecs
[    0.356005] calling  acpi_pci_init+0x0/0x5d @ 1
[    0.356881] ACPI: bus type PCI registered
[    0.357625] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.358876] initcall acpi_pci_init+0x0/0x5d returned 0 after 0 usecs
[    0.360005] calling  mid_pci_init+0x0/0x20 @ 1
[    0.360874] initcall mid_pci_init+0x0/0x20 returned 0 after 0 usecs
[    0.361998] calling  dma_bus_init+0x0/0xd6 @ 1
[    0.363022] initcall dma_bus_init+0x0/0xd6 returned 0 after 0 usecs
[    0.364005] calling  dma_channel_table_init+0x0/0xd4 @ 1
[    0.365013] initcall dma_channel_table_init+0x0/0xd4 returned 0 after 0 usecs
[    0.366374] calling  setup_vcpu_hotplug_event+0x0/0x27 @ 1
[    0.367374] initcall setup_vcpu_hotplug_event+0x0/0x27 returned -19 after 0 usecs
[    0.368005] calling  register_xen_pci_notifier+0x0/0x28 @ 1
[    0.369000] initcall register_xen_pci_notifier+0x0/0x28 returned 0 after 0 usecs
[    0.370374] calling  xen_pcpu_init+0x0/0xa9 @ 1
[    0.371251] initcall xen_pcpu_init+0x0/0xa9 returned -19 after 0 usecs
[    0.372005] calling  dmi_id_init+0x0/0x333 @ 1
[    0.373127] initcall dmi_id_init+0x0/0x333 returned 0 after 0 usecs
[    0.374248] calling  numachip_timer_init+0x0/0x4f @ 1
[    0.375250] initcall numachip_timer_init+0x0/0x4f returned -19 after 0 usecs
[    0.376005] calling  silead_ts_dmi_init+0x0/0x54 @ 1
[    0.377001] initcall silead_ts_dmi_init+0x0/0x54 returned 0 after 0 usecs
[    0.378249] calling  pci_arch_init+0x0/0x61 @ 1
[    0.379160] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.380023] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.381231] PCI: Using configuration type 1 for base access
[    0.382216] initcall pci_arch_init+0x0/0x61 returned 0 after 3906 usecs
[    0.383463] calling  of_platform_default_populate_init+0x0/0x98 @ 1
[    0.384008] initcall of_platform_default_populate_init+0x0/0x98 returned -19 after 0 usecs
[    0.385566] calling  init_vdso+0x0/0x3b @ 1
[    0.386276] initcall init_vdso+0x0/0x3b returned 0 after 0 usecs
[    0.386276] calling  sysenter_setup+0x0/0xf @ 1
[    0.388008] initcall sysenter_setup+0x0/0xf returned 0 after 0 usecs
[    0.389249] calling  fixup_ht_bug+0x0/0x9d @ 1
[    0.390123] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.391375] initcall fixup_ht_bug+0x0/0x9d returned 0 after 0 usecs
[    0.392005] calling  topology_init+0x0/0xbc @ 1
[    0.394094] initcall topology_init+0x0/0xbc returned 0 after 0 usecs
[    0.395250] calling  mtrr_init_finialize+0x0/0x3a @ 1
[    0.396007] initcall mtrr_init_finialize+0x0/0x3a returned 0 after 0 usecs
[    0.397250] calling  uid_cache_init+0x0/0x8c @ 1
[    0.398147] initcall uid_cache_init+0x0/0x8c returned 0 after 0 usecs
[    0.399373] calling  param_sysfs_init+0x0/0x1ec @ 1
[    0.412320] initcall param_sysfs_init+0x0/0x1ec returned 0 after 11718 usecs
[    0.413604] calling  user_namespace_sysctl_init+0x0/0x2f @ 1
[    0.414758] initcall user_namespace_sysctl_init+0x0/0x2f returned 0 after 0 usecs
[    0.416006] calling  proc_schedstat_init+0x0/0x20 @ 1
[    0.417007] initcall proc_schedstat_init+0x0/0x20 returned 0 after 0 usecs
[    0.418249] calling  pm_sysrq_init+0x0/0x14 @ 1
[    0.419139] initcall pm_sysrq_init+0x0/0x14 returned 0 after 0 usecs
[    0.420013] calling  create_proc_profile+0x0/0xd0 @ 1
[    0.420999] initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
[    0.422248] calling  crash_save_vmcoreinfo_init+0x0/0x5d6 @ 1
[    0.423410] initcall crash_save_vmcoreinfo_init+0x0/0x5d6 returned 0 after 0 usecs
[    0.424058] calling  crash_notes_memory_init+0x0/0x31 @ 1
[    0.425004] initcall crash_notes_memory_init+0x0/0x31 returned 0 after 0 usecs
[    0.426375] calling  cgroup_sysfs_init+0x0/0x13 @ 1
[    0.427264] initcall cgroup_sysfs_init+0x0/0x13 returned 0 after 0 usecs
[    0.428005] calling  cgroup_namespaces_init+0x0/0x3 @ 1
[    0.428999] initcall cgroup_namespaces_init+0x0/0x3 returned 0 after 0 usecs
[    0.430374] calling  user_namespaces_init+0x0/0x28 @ 1
[    0.431394] initcall user_namespaces_init+0x0/0x28 returned 0 after 0 usecs
[    0.432006] calling  hung_task_init+0x0/0x4a @ 1
[    0.432957] initcall hung_task_init+0x0/0x4a returned 0 after 0 usecs
[    0.433167] calling  dev_map_init+0x0/0xf @ 1
[    0.434044] initcall dev_map_init+0x0/0xf returned 0 after 0 usecs
[    0.436012] calling  bpf_offload_init+0x0/0xf @ 1
[    0.436876] initcall bpf_offload_init+0x0/0xf returned 0 after 0 usecs
[    0.438124] calling  stack_map_init+0x0/0x49 @ 1
[    0.439001] initcall stack_map_init+0x0/0x49 returned 0 after 0 usecs
[    0.440066] calling  oom_init+0x0/0x2b @ 1
[    0.440825] initcall oom_init+0x0/0x2b returned 0 after 0 usecs
[    0.441050] calling  cgwb_init+0x0/0x32 @ 1
[    0.441824] initcall cgwb_init+0x0/0x32 returned 0 after 0 usecs
[    0.442924] calling  default_bdi_init+0x0/0xb2 @ 1
[    0.444158] initcall default_bdi_init+0x0/0xb2 returned 0 after 0 usecs
[    0.445350] calling  percpu_enable_async+0x0/0xa @ 1
[    0.446351] initcall percpu_enable_async+0x0/0xa returned 0 after 0 usecs
[    0.447598] calling  kcompactd_init+0x0/0x92 @ 1
[    0.448079] initcall kcompactd_init+0x0/0x92 returned 0 after 0 usecs
[    0.449296] calling  init_reserve_notifier+0x0/0x1f @ 1
[    0.450296] initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
[    0.451671] calling  init_admin_reserve+0x0/0x40 @ 1
[    0.452007] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    0.453248] calling  init_user_reserve+0x0/0x40 @ 1
[    0.454124] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    0.455374] calling  swap_init_sysfs+0x0/0x5e @ 1
[    0.456022] initcall swap_init_sysfs+0x0/0x5e returned 0 after 0 usecs
[    0.457248] calling  swapfile_init+0x0/0xae @ 1
[    0.458127] initcall swapfile_init+0x0/0xae returned 0 after 0 usecs
[    0.459373] calling  hugetlb_init+0x0/0x492 @ 1
[    0.460010] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.461338] initcall hugetlb_init+0x0/0x492 returned 0 after 0 usecs
[    0.462499] calling  ksm_init+0x0/0x180 @ 1
[    0.463372] initcall ksm_init+0x0/0x180 returned 0 after 0 usecs
[    0.463372] calling  hugepage_init+0x0/0x14f @ 1
[    0.465464] initcall hugepage_init+0x0/0x14f returned 0 after 0 usecs
[    0.465464] calling  mem_cgroup_swap_init+0x0/0x4d @ 1
[    0.465464] initcall mem_cgroup_swap_init+0x0/0x4d returned 0 after 0 usecs
[    0.466251] calling  mem_cgroup_init+0x0/0x198 @ 1
[    0.469521] initcall mem_cgroup_init+0x0/0x198 returned 0 after 0 usecs
[    0.469521] calling  page_idle_init+0x0/0x2a @ 1
[    0.469521] initcall page_idle_init+0x0/0x2a returned 0 after 0 usecs
[    0.472004] calling  crypto_wq_init+0x0/0x35 @ 1
[    0.474106] initcall crypto_wq_init+0x0/0x35 returned 0 after 0 usecs
[    0.474106] calling  cryptomgr_init+0x0/0xc @ 1
[    0.474106] initcall cryptomgr_init+0x0/0xc returned 0 after 0 usecs
[    0.474124] calling  init_bio+0x0/0xc8 @ 1
[    0.478357] initcall init_bio+0x0/0xc8 returned 0 after 0 usecs
[    0.478357] calling  blk_settings_init+0x0/0x25 @ 1
[    0.478357] initcall blk_settings_init+0x0/0x25 returned 0 after 0 usecs
[    0.478357] calling  blk_ioc_init+0x0/0x25 @ 1
[    0.479020] initcall blk_ioc_init+0x0/0x25 returned 0 after 0 usecs
[    0.480005] calling  blk_softirq_init+0x0/0x6c @ 1
[    0.480875] initcall blk_softirq_init+0x0/0x6c returned 0 after 0 usecs
[    0.482124] calling  blk_mq_init+0x0/0x25 @ 1
[    0.483000] initcall blk_mq_init+0x0/0x25 returned 0 after 0 usecs
[    0.484005] calling  genhd_device_init+0x0/0x7b @ 1
[    0.488845] initcall genhd_device_init+0x0/0x7b returned 0 after 0 usecs
[    0.489254] calling  irq_poll_setup+0x0/0x6c @ 1
[    0.490129] initcall irq_poll_setup+0x0/0x6c returned 0 after 0 usecs
[    0.492006] calling  sx150x_init+0x0/0xe @ 1
[    0.492917] initcall sx150x_init+0x0/0xe returned 0 after 0 usecs
[    0.493998] calling  byt_gpio_init+0x0/0xe @ 1
[    0.494898] initcall byt_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.495997] calling  gpiolib_debugfs_init+0x0/0x1f @ 1
[    0.496019] initcall gpiolib_debugfs_init+0x0/0x1f returned 0 after 0 usecs
[    0.497249] calling  platform_msic_gpio_init+0x0/0xe @ 1
[    0.498281] initcall platform_msic_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.499623] calling  rc5t583_gpio_init+0x0/0xe @ 1
[    0.500044] initcall rc5t583_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.501249] calling  stmpe_gpio_init+0x0/0xe @ 1
[    0.502152] initcall stmpe_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.503373] calling  tc3589x_gpio_init+0x0/0xe @ 1
[    0.504046] initcall tc3589x_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.505248] calling  palmas_gpio_init+0x0/0xe @ 1
[    0.506157] initcall palmas_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.507374] calling  tps6586x_gpio_init+0x0/0xe @ 1
[    0.508038] initcall tps6586x_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.509249] calling  tps65910_gpio_init+0x0/0xe @ 1
[    0.510157] initcall tps65910_gpio_init+0x0/0xe returned 0 after 0 usecs
[    0.511375] calling  pwm_debugfs_init+0x0/0x1f @ 1
[    0.512018] initcall pwm_debugfs_init+0x0/0x1f returned 0 after 0 usecs
[    0.513248] calling  pwm_sysfs_init+0x0/0x13 @ 1
[    0.514144] initcall pwm_sysfs_init+0x0/0x13 returned 0 after 0 usecs
[    0.515375] calling  pci_slot_init+0x0/0x40 @ 1
[    0.516015] initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
[    0.517249] calling  fbmem_init+0x0/0xd6 @ 1
[    0.518275] initcall fbmem_init+0x0/0xd6 returned 0 after 0 usecs
[    0.519376] calling  scan_for_dmi_ipmi+0x0/0xec @ 1
[    0.520007] initcall scan_for_dmi_ipmi+0x0/0xec returned 0 after 0 usecs
[    0.521250] calling  acpi_init+0x0/0x34f @ 1
[    0.522240] ACPI: Added _OSI(Module Device)
[    0.522997] ACPI: Added _OSI(Processor Device)
[    0.523872] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.524005] ACPI: Added _OSI(Processor Aggregator Device)
[    0.525004] ACPI: Added _OSI(Linux-Dell-Video)
[    0.648826] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.656431] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.675759] ACPI: Dynamic OEM Table Load:
[    0.676015] ACPI: SSDT 0xFFFF8DD40AA6AE98 00071E (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.684721] ACPI: Dynamic OEM Table Load:
[    0.685491] ACPI: SSDT 0xFFFF8DD409E6EA48 000303 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.690252] ACPI: Dynamic OEM Table Load:
[    0.690252] ACPI: SSDT 0xFFFF8DD3C72E6D58 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.704910] ACPI: Interpreter enabled
[    0.705792] ACPI: (supports S0 S3 S4 S5)
[    0.706540] ACPI: Using IOAPIC for interrupt routing
[    0.707782] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.753002] ACPI: Power Resource [PDOC] (off)
[    0.754453] acpi PNP0A05:00: ACPI dock station (docks/bays count: 1)
[    0.795044] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.796022] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.797565] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.806012] PCI host bridge to bus 0000:00
[    0.806742] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.807992] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.812010] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.813377] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.814753] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.816010] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.817378] pci_bus 0000:00: root bus resource [mem 0xafa00000-0xfeafffff window]
[    0.818754] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.819774] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
[    0.820013] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    0.821251] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    0.822555] pci 0000:00:00.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.823750] pci 0000:00:00.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.824788] pci 0000:00:02.0: [8086:0126] type 00 class 0x030000
[    0.825888] pci 0000:00:02.0: reg 0x10: [mem 0xc0000000-0xc03fffff 64bit]
[    0.827131] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.828009] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.832022] pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x130 @ 1
[    0.832022] pci 0000:00:02.0: efifb_fixup_resources+0x0/0x130 took 0 usecs
[    0.832022] pci 0000:00:02.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.836008] pci 0000:00:02.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.838054] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.839165] pci 0000:00:16.0: reg 0x10: [mem 0xc4824000-0xc482400f 64bit]
[    0.840106] pci 0000:00:16.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.841377] pci 0000:00:16.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.842674] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.844495] pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
[    0.845629] pci 0000:00:19.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[    0.846871] pci 0000:00:19.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[    0.848007] pci 0000:00:19.0: calling  quirk_intel_no_flr+0x0/0x10 @ 1
[    0.849252] pci 0000:00:19.0: quirk_intel_no_flr+0x0/0x10 took 0 usecs
[    0.850525] pci 0000:00:19.0: reg 0x10: [mem 0xc4800000-0xc481ffff]
[    0.852004] pci 0000:00:19.0: reg 0x14: [mem 0xc482a000-0xc482afff]
[    0.852018] pci 0000:00:19.0: reg 0x18: [io  0x3060-0x307f]
[    0.853086] pci 0000:00:19.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.854252] pci 0000:00:19.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.856005] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.856812] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    0.858060] pci 0000:00:1a.0: reg 0x10: [mem 0xc4829000-0xc48293ff]
[    0.860005] pci 0000:00:1a.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.860008] pci 0000:00:1a.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.861306] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.864005] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.864045] pci 0000:00:1b.0: reg 0x10: [mem 0xc4820000-0xc4823fff 64bit]
[    0.865349] pci 0000:00:1b.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.868005] pci 0000:00:1b.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.868005] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.872005] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.872005] pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x60 @ 1
[    0.872005] pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x60 took 0 usecs
[    0.872104] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    0.876004] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    0.876004] pci 0000:00:1c.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.876007] pci 0000:00:1c.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.880004] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.880004] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.884012] pci 0000:00:1c.1: calling  quirk_cmd_compl+0x0/0x60 @ 1
[    0.885127] pci 0000:00:1c.1: quirk_cmd_compl+0x0/0x60 took 0 usecs
[    0.886348] pci 0000:00:1c.1: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    0.887751] pci 0000:00:1c.1: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    0.888007] pci 0000:00:1c.1: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.889251] pci 0000:00:1c.1: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.890570] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.892459] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.893500] pci 0000:00:1c.2: calling  quirk_cmd_compl+0x0/0x60 @ 1
[    0.894623] pci 0000:00:1c.2: quirk_cmd_compl+0x0/0x60 took 0 usecs
[    0.896006] pci 0000:00:1c.2: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    0.896007] pci 0000:00:1c.2: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    0.897375] pci 0000:00:1c.2: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.900004] pci 0000:00:1c.2: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.900004] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.904005] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.904005] pci 0000:00:1c.4: calling  quirk_cmd_compl+0x0/0x60 @ 1
[    0.904005] pci 0000:00:1c.4: quirk_cmd_compl+0x0/0x60 took 0 usecs
[    0.904107] pci 0000:00:1c.4: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    0.908004] pci 0000:00:1c.4: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    0.908004] pci 0000:00:1c.4: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.908007] pci 0000:00:1c.4: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.912005] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.912005] pci 0000:00:1c.5: [8086:1c1a] type 01 class 0x060400
[    0.912014] pci 0000:00:1c.5: calling  quirk_cmd_compl+0x0/0x60 @ 1
[    0.916004] pci 0000:00:1c.5: quirk_cmd_compl+0x0/0x60 took 0 usecs
[    0.916004] pci 0000:00:1c.5: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    0.916004] pci 0000:00:1c.5: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    0.920007] pci 0000:00:1c.5: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.921251] pci 0000:00:1c.5: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.922574] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.924462] pci 0000:00:1c.6: [8086:2448] type 01 class 0x060401
[    0.925501] pci 0000:00:1c.6: calling  quirk_cmd_compl+0x0/0x60 @ 1
[    0.926621] pci 0000:00:1c.6: quirk_cmd_compl+0x0/0x60 took 0 usecs
[    0.928006] pci 0000:00:1c.6: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    0.928008] pci 0000:00:1c.6: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    0.929376] pci 0000:00:1c.6: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.932004] pci 0000:00:1c.6: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.932004] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.936005] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    0.936005] pci 0000:00:1d.0: reg 0x10: [mem 0xc4828000-0xc48283ff]
[    0.936005] pci 0000:00:1d.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.936008] pci 0000:00:1d.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.940005] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.940005] pci 0000:00:1f.0: [8086:1c49] type 00 class 0x060100
[    0.944005] pci 0000:00:1f.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.944005] pci 0000:00:1f.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.944005] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
[    0.948045] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308f]
[    0.949012] pci 0000:00:1f.2: reg 0x14: [io  0x309c-0x309f]
[    0.950012] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x3087]
[    0.951012] pci 0000:00:1f.2: reg 0x1c: [io  0x3098-0x309b]
[    0.952014] pci 0000:00:1f.2: reg 0x20: [io  0x3040-0x305f]
[    0.953007] pci 0000:00:1f.2: reg 0x24: [mem 0xc4827000-0xc48277ff]
[    0.954168] pci 0000:00:1f.2: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.955371] pci 0000:00:1f.2: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.956069] pci 0000:00:1f.2: PME# supported from D3hot
[    0.958322] pci 0000:01:00.0: [1180:e823] type 00 class 0x088001
[    0.960005] pci 0000:01:00.0: calling  ricoh_mmc_fixup_r5c832+0x0/0x150 @ 1
[    0.960117] pci 0000:01:00.0: MMC controller base frequency changed to 50Mhz.
[    0.961578] pci 0000:01:00.0: ricoh_mmc_fixup_r5c832+0x0/0x150 took 0 usecs
[    0.964005] pci 0000:01:00.0: reg 0x10: [mem 0xc4700000-0xc47000ff]
[    0.964498] pci 0000:01:00.0: supports D1 D2
[    0.965368] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.968004] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.968014] pci 0000:00:1c.0:   bridge window [mem 0xc4700000-0xc47fffff]
[    0.969634] acpiphp: Slot [1] registered
[    0.972005] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    0.972005] pci 0000:00:1c.1:   bridge window [io  0x2000-0x2fff]
[    0.972009] pci 0000:00:1c.1:   bridge window [mem 0xc2700000-0xc46fffff]
[    0.973255] pci 0000:00:1c.1:   bridge window [mem 0xc0400000-0xc23fffff 64bit pref]
[    0.976005] pci 0000:04:00.0: [8086:0083] type 00 class 0x028000
[    0.976087] pci 0000:04:00.0: reg 0x10: [mem 0xc2600000-0xc2601fff 64bit]
[    0.980004] pci 0000:04:00.0: calling  pci_fixed_bar_fixup+0x0/0xc0 @ 1
[    0.980004] pci 0000:04:00.0: pci_fixed_bar_fixup+0x0/0xc0 took 0 usecs
[    0.980009] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.984005] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.984005] pci 0000:00:1c.2:   bridge window [mem 0xc2600000-0xc26fffff]
[    0.984356] pci 0000:05:00.0: [1033:0194] type 00 class 0x0c0330
[    0.988005] pci 0000:05:00.0: reg 0x10: [mem 0xc2500000-0xc2501fff 64bit]
[    0.988005] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.992005] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.992005] pci 0000:00:1c.4:   bridge window [mem 0xc2500000-0xc25fffff]
[    0.992005] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.992012] pci 0000:00:1c.5:   bridge window [mem 0xc2400000-0xc24fffff]
[    0.996005] pci 0000:00:1c.6: PCI bridge to [bus 07] (subtractive decode)
[    0.996005] pci 0000:00:1c.6:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    1.000010] pci 0000:00:1c.6:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    1.001628] pci 0000:00:1c.6:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    1.003377] pci 0000:00:1c.6:   bridge window [mem 0x000d4000-0x000d7fff window] (subtractive decode)
[    1.004014] pci 0000:00:1c.6:   bridge window [mem 0x000d8000-0x000dbfff window] (subtractive decode)
[    1.005753] pci 0000:00:1c.6:   bridge window [mem 0x000dc000-0x000dffff window] (subtractive decode)
[    1.008004] pci 0000:00:1c.6:   bridge window [mem 0xafa00000-0xfeafffff window] (subtractive decode)
[    1.012005] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.012903] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
[    1.016006] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.020005] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 *3 4 5 6 7 11 12 14 15)
[    1.020005] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.024005] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.024005] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 *6 7 10 12 14 15)
[    1.028891] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    1.035636] initcall acpi_init+0x0/0x34f returned 0 after 500000 usecs
[    1.036007] calling  pnp_init+0x0/0xc @ 1
[    1.036798] initcall pnp_init+0x0/0xc returned 0 after 0 usecs
[    1.037874] calling  balloon_init+0x0/0x1b6 @ 1
[    1.038750] initcall balloon_init+0x0/0x1b6 returned -19 after 0 usecs
[    1.040004] calling  xen_setup_shutdown_event+0x0/0x30 @ 1
[    1.040997] initcall xen_setup_shutdown_event+0x0/0x30 returned -19 after 0 usecs
[    1.042370] calling  xenbus_probe_backend_init+0x0/0x4b @ 1
[    1.044004] initcall xenbus_probe_backend_init+0x0/0x4b returned 0 after 0 usecs
[    1.044006] calling  xenbus_probe_frontend_init+0x0/0x4b @ 1
[    1.045173] initcall xenbus_probe_frontend_init+0x0/0x4b returned 0 after 0 usecs
[    1.048005] calling  xen_acpi_pad_init+0x0/0x37 @ 1
[    1.048005] initcall xen_acpi_pad_init+0x0/0x37 returned -19 after 0 usecs
[    1.048005] calling  misc_init+0x0/0xb8 @ 1
[    1.048795] initcall misc_init+0x0/0xb8 returned 0 after 0 usecs
[    1.052004] calling  tpm_init+0x0/0xcc @ 1
[    1.052004] initcall tpm_init+0x0/0xcc returned 0 after 0 usecs
[    1.052004] calling  vga_arb_device_init+0x0/0x244 @ 1
[    1.053335] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.053335] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.054724] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.055838] vgaarb: loaded
[    1.056012] initcall vga_arb_device_init+0x0/0x244 returned 0 after 3906 usecs
[    1.057374] calling  pm860x_i2c_init+0x0/0x27 @ 1
[    1.058288] initcall pm860x_i2c_init+0x0/0x27 returned 0 after 0 usecs
[    1.059498] calling  stmpe_init+0x0/0xe @ 1
[    1.060046] initcall stmpe_init+0x0/0xe returned 0 after 0 usecs
[    1.061126] calling  stmpe_init+0x0/0xe @ 1
[    1.061912] initcall stmpe_init+0x0/0xe returned 0 after 0 usecs
[    1.063000] calling  tc3589x_init+0x0/0xe @ 1
[    1.063909] initcall tc3589x_init+0x0/0xe returned 0 after 0 usecs
[    1.068006] calling  wm8400_module_init+0x0/0x27 @ 1
[    1.069036] initcall wm8400_module_init+0x0/0x27 returned 0 after 0 usecs
[    1.070249] calling  wm831x_i2c_init+0x0/0x27 @ 1
[    1.071164] initcall wm831x_i2c_init+0x0/0x27 returned 0 after 3906 usecs
[    1.072005] calling  wm831x_spi_init+0x0/0x23 @ 1
[    1.072909] initcall wm831x_spi_init+0x0/0x23 returned 0 after 0 usecs
[    1.074127] calling  wm8350_i2c_init+0x0/0xe @ 1
[    1.075045] initcall wm8350_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.076007] calling  tps65910_i2c_init+0x0/0xe @ 1
[    1.076909] initcall tps65910_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.078126] calling  tps80031_init+0x0/0xe @ 1
[    1.079042] initcall tps80031_init+0x0/0xe returned 0 after 0 usecs
[    1.080006] calling  ezx_pcap_init+0x0/0xe @ 1
[    1.080909] initcall ezx_pcap_init+0x0/0xe returned 0 after 0 usecs
[    1.081998] calling  da903x_init+0x0/0xe @ 1
[    1.082909] initcall da903x_init+0x0/0xe returned 0 after 0 usecs
[    1.083999] calling  da9052_spi_init+0x0/0x27 @ 1
[    1.084040] initcall da9052_spi_init+0x0/0x27 returned 0 after 0 usecs
[    1.085251] calling  da9052_i2c_init+0x0/0x27 @ 1
[    1.086161] initcall da9052_i2c_init+0x0/0x27 returned 0 after 0 usecs
[    1.087375] calling  lp8788_init+0x0/0xe @ 1
[    1.088039] initcall lp8788_init+0x0/0xe returned 0 after 0 usecs
[    1.089124] calling  da9055_i2c_init+0x0/0x27 @ 1
[    1.090033] initcall da9055_i2c_init+0x0/0x27 returned 0 after 0 usecs
[    1.091249] calling  max77843_i2c_init+0x0/0xe @ 1
[    1.092031] initcall max77843_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.093251] calling  max8925_i2c_init+0x0/0x27 @ 1
[    1.094161] initcall max8925_i2c_init+0x0/0x27 returned 0 after 0 usecs
[    1.095377] calling  max8997_i2c_init+0x0/0xe @ 1
[    1.096038] initcall max8997_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.097251] calling  max8998_i2c_init+0x0/0xe @ 1
[    1.098152] initcall max8998_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.099374] calling  ab3100_i2c_init+0x0/0xe @ 1
[    1.100032] initcall ab3100_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.101251] calling  tps6586x_init+0x0/0xe @ 1
[    1.102159] initcall tps6586x_init+0x0/0xe returned 0 after 0 usecs
[    1.103250] calling  tps65090_init+0x0/0xe @ 1
[    1.104040] initcall tps65090_init+0x0/0xe returned 0 after 0 usecs
[    1.105122] calling  aat2870_init+0x0/0xe @ 1
[    1.106030] initcall aat2870_init+0x0/0xe returned 0 after 0 usecs
[    1.107120] calling  palmas_i2c_init+0x0/0xe @ 1
[    1.108026] initcall palmas_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.109238] calling  rc5t583_i2c_init+0x0/0xe @ 1
[    1.110149] initcall rc5t583_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.111363] calling  sec_pmic_init+0x0/0xe @ 1
[    1.112038] initcall sec_pmic_init+0x0/0xe returned 0 after 0 usecs
[    1.113126] calling  as3711_i2c_init+0x0/0xe @ 1
[    1.114041] initcall as3711_i2c_init+0x0/0xe returned 0 after 0 usecs
[    1.115250] calling  dax_fs_init+0x0/0xba @ 1
[    1.116013] _warn_unseeded_randomness: 194 callbacks suppressed
[    1.116017] random: get_random_u64 called from __kmem_cache_create+0x41/0x580 with crng_init=0
[    1.118757] random: get_random_u64 called from cache_random_seq_create+0x60/0x150 with crng_init=0
[    1.124102] initcall dax_fs_init+0x0/0xba returned 0 after 7812 usecs
[    1.125376] calling  dma_buf_init+0x0/0xa7 @ 1
[    1.126274] initcall dma_buf_init+0x0/0xa7 returned 0 after 0 usecs
[    1.127375] calling  init_scsi+0x0/0x83 @ 1
[    1.128011] random: get_random_u64 called from __kmem_cache_create+0x41/0x580 with crng_init=0
[    1.130275] SCSI subsystem initialized
[    1.131002] initcall init_scsi+0x0/0x83 returned 0 after 0 usecs
[    1.132006] calling  ata_init+0x0/0x30f @ 1
[    1.133152] libata version 3.00 loaded.
[    1.133152] initcall ata_init+0x0/0x30f returned 0 after 0 usecs
[    1.133989] calling  xdbc_init+0x0/0x147 @ 1
[    1.134865] initcall xdbc_init+0x0/0x147 returned 0 after 0 usecs
[    1.136006] calling  serio_init+0x0/0x25 @ 1
[    1.136925] initcall serio_init+0x0/0x25 returned 0 after 0 usecs
[    1.137999] calling  input_init+0x0/0xf8 @ 1
[    1.138914] initcall input_init+0x0/0xf8 returned 0 after 0 usecs
[    1.140000] calling  rtc_init+0x0/0x47 @ 1
[    1.140033] initcall rtc_init+0x0/0x47 returned 0 after 0 usecs
[    1.141124] calling  dw_i2c_init_driver+0x0/0xe @ 1
[    1.142048] initcall dw_i2c_init_driver+0x0/0xe returned 0 after 3906 usecs
[    1.143248] calling  pps_init+0x0/0xa5 @ 1
[    1.144024] pps_core: LinuxPPS API ver. 1 registered
[    1.144992] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.146744] initcall pps_init+0x0/0xa5 returned 0 after 3906 usecs
[    1.147868] calling  ptp_init+0x0/0x94 @ 1
[    1.148030] PTP clock support registered
[    1.148751] initcall ptp_init+0x0/0x94 returned 0 after 0 usecs
[    1.149874] calling  power_supply_class_init+0x0/0x3b @ 1
[    1.150900] initcall power_supply_class_init+0x0/0x3b returned 0 after 0 usecs
[    1.152005] calling  dmi_init+0x0/0x10f @ 1
[    1.152795] initcall dmi_init+0x0/0x10f returned 0 after 0 usecs
[    1.153874] calling  efisubsys_init+0x0/0x2ca @ 1
[    1.154751] initcall efisubsys_init+0x0/0x2ca returned 0 after 0 usecs
[    1.156000] calling  ion_device_create+0x0/0xe0 @ 1
[    1.157997] initcall ion_device_create+0x0/0xe0 returned 0 after 0 usecs
[    1.157997] calling  devfreq_init+0x0/0xa5 @ 1
[    1.162021] initcall devfreq_init+0x0/0xa5 returned 0 after 0 usecs
[    1.162021] calling  devfreq_event_init+0x0/0x49 @ 1
[    1.164034] initcall devfreq_event_init+0x0/0x49 returned 0 after 0 usecs
[    1.165249] calling  vme_init+0x0/0xc @ 1
[    1.166044] initcall vme_init+0x0/0xc returned 0 after 0 usecs
[    1.167123] calling  ras_init+0x0/0xa @ 1
[    1.167899] initcall ras_init+0x0/0xa returned 0 after 0 usecs
[    1.168005] calling  nvmem_init+0x0/0xc @ 1
[    1.168808] initcall nvmem_init+0x0/0xc returned 0 after 0 usecs
[    1.169876] calling  pci_subsys_init+0x0/0x62 @ 1
[    1.170750] PCI: Using ACPI for IRQ routing
[    1.174887] PCI: pci_cache_line_size set to 64 bytes
[    1.176281] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    1.177372] e820: reserve RAM buffer [mem 0xaa5d0000-0xabffffff]
[    1.178495] e820: reserve RAM buffer [mem 0x14fe00000-0x14fffffff]
[    1.179619] initcall pci_subsys_init+0x0/0x62 returned 0 after 11718 usecs
[    1.180006] calling  proto_init+0x0/0xc @ 1
[    1.180761] initcall proto_init+0x0/0xc returned 0 after 0 usecs
[    1.181876] calling  net_dev_init+0x0/0x280 @ 1
[    1.183405] initcall net_dev_init+0x0/0x280 returned 0 after 0 usecs
[    1.184006] calling  neigh_init+0x0/0x7b @ 1
[    1.184891] initcall neigh_init+0x0/0x7b returned 0 after 0 usecs
[    1.186000] calling  fib_notifier_init+0x0/0xc @ 1
[    1.186875] initcall fib_notifier_init+0x0/0xc returned 0 after 0 usecs
[    1.188005] calling  fib_rules_init+0x0/0xa7 @ 1
[    1.188885] initcall fib_rules_init+0x0/0xa7 returned 0 after 0 usecs
[    1.190125] calling  init_cgroup_netprio+0x0/0xf @ 1
[    1.191126] initcall init_cgroup_netprio+0x0/0xf returned 0 after 0 usecs
[    1.192005] calling  bpf_lwt_init+0x0/0x11 @ 1
[    1.192877] initcall bpf_lwt_init+0x0/0x11 returned 0 after 0 usecs
[    1.194001] calling  pktsched_init+0x0/0x10a @ 1
[    1.194914] initcall pktsched_init+0x0/0x10a returned 0 after 0 usecs
[    1.196006] calling  tc_filter_init+0x0/0xa7 @ 1
[    1.200005] initcall tc_filter_init+0x0/0xa7 returned 0 after 0 usecs
[    1.200005] calling  tc_action_init+0x0/0x64 @ 1
[    1.200005] initcall tc_action_init+0x0/0x64 returned 0 after 0 usecs
[    1.200006] calling  genl_init+0x0/0x31 @ 1
[    1.200792] initcall genl_init+0x0/0x31 returned 0 after 0 usecs
[    1.201876] calling  cipso_v4_init+0x0/0x84 @ 1
[    1.202756] initcall cipso_v4_init+0x0/0x84 returned 0 after 0 usecs
[    1.204000] calling  wireless_nlevent_init+0x0/0x37 @ 1
[    1.208019] initcall wireless_nlevent_init+0x0/0x37 returned 0 after 0 usecs
[    1.209374] calling  netlbl_init+0x0/0x74 @ 1
[    1.210248] NetLabel: Initializing
[    1.210874] NetLabel:  domain hash size = 128
[    1.211749] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.212147] NetLabel:  unlabeled traffic allowed by default
[    1.213126] initcall netlbl_init+0x0/0x74 returned 0 after 3906 usecs
[    1.214374] calling  xen_mcfg_late+0x0/0xe1 @ 1
[    1.215249] initcall xen_mcfg_late+0x0/0xe1 returned 0 after 0 usecs
[    1.216005] calling  watchdog_init+0x0/0x95 @ 1
[    1.218739] initcall watchdog_init+0x0/0x95 returned 0 after 0 usecs
[    1.218739] calling  xen_p2m_debugfs+0x0/0x40 @ 1
[    1.218739] initcall xen_p2m_debugfs+0x0/0x40 returned 0 after 0 usecs
[    1.220007] calling  nmi_warning_debugfs+0x0/0x22 @ 1
[    1.221019] initcall nmi_warning_debugfs+0x0/0x22 returned 0 after 0 usecs
[    1.222250] calling  save_microcode_in_initrd+0x0/0x9f @ 1
[    1.223253] initcall save_microcode_in_initrd+0x0/0x9f returned 0 after 0 usecs
[    1.224006] calling  hpet_late_init+0x0/0x10d @ 1
[    1.224887] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.225999] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.229008] initcall hpet_late_init+0x0/0x10d returned 0 after 3906 usecs
[    1.230245] calling  apbt_late_init+0x0/0x37 @ 1
[    1.231121] initcall apbt_late_init+0x0/0x37 returned 0 after 0 usecs
[    1.232005] calling  init_amd_nbs+0x0/0x111 @ 1
[    1.232890] initcall init_amd_nbs+0x0/0x111 returned 0 after 0 usecs
[    1.234126] calling  uv_ptc_init+0x0/0xaf @ 1
[    1.235002] initcall uv_ptc_init+0x0/0xaf returned 0 after 0 usecs
[    1.236006] calling  sugov_register+0x0/0xc @ 1
[    1.236885] initcall sugov_register+0x0/0xc returned 0 after 0 usecs
[    1.238126] calling  init_qspinlock_stat+0x0/0x95 @ 1
[    1.239290] initcall init_qspinlock_stat+0x0/0x95 returned 0 after 0 usecs
[    1.240006] calling  clocksource_done_booting+0x0/0x3f @ 1
[    1.244010] clocksource: Switched to clocksource tsc-early
[    1.244783] initcall clocksource_done_booting+0x0/0x3f returned 0 after 961 usecs
[    1.244783] calling  bpf_init+0x0/0x45 @ 1
[    1.247130] initcall bpf_init+0x0/0x45 returned 0 after 10 usecs
[    1.248245] calling  init_pipe_fs+0x0/0x42 @ 1
[    1.249171] initcall init_pipe_fs+0x0/0x42 returned 0 after 60 usecs
[    1.250358] calling  cgroup_writeback_init+0x0/0x2f @ 1
[    1.251382] initcall cgroup_writeback_init+0x0/0x2f returned 0 after 23 usecs
[    1.252742] calling  inotify_user_setup+0x0/0x43 @ 1
[    1.253752] initcall inotify_user_setup+0x0/0x43 returned 0 after 18 usecs
[    1.254982] calling  eventpoll_init+0x0/0xfd @ 1
[    1.255902] initcall eventpoll_init+0x0/0xfd returned 0 after 42 usecs
[    1.257117] calling  anon_inode_init+0x0/0x56 @ 1
[    1.258044] initcall anon_inode_init+0x0/0x56 returned 0 after 59 usecs
[    1.259231] calling  init_dax_wait_table+0x0/0x3b @ 1
[    1.260413] initcall init_dax_wait_table+0x0/0x3b returned 0 after 164 usecs
[    1.261732] calling  proc_locks_init+0x0/0x23 @ 1
[    1.262615] initcall proc_locks_init+0x0/0x23 returned 0 after 7 usecs
[    1.263857] calling  dquot_init+0x0/0x114 @ 1
[    1.264742] VFS: Disk quotas dquot_6.6.0
[    1.265536] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.266737] initcall dquot_init+0x0/0x114 returned 0 after 1947 usecs
[    1.267982] calling  quota_init+0x0/0x1f @ 1
[    1.268917] initcall quota_init+0x0/0x1f returned 0 after 47 usecs
[    1.269984] calling  proc_cmdline_init+0x0/0x1d @ 1
[    1.270864] initcall proc_cmdline_init+0x0/0x1d returned 0 after 5 usecs
[    1.272118] calling  proc_consoles_init+0x0/0x20 @ 1
[    1.273114] initcall proc_consoles_init+0x0/0x20 returned 0 after 5 usecs
[    1.274359] calling  proc_cpuinfo_init+0x0/0x1a @ 1
[    1.275238] initcall proc_cpuinfo_init+0x0/0x1a returned 0 after 4 usecs
[    1.276493] calling  proc_devices_init+0x0/0x20 @ 1
[    1.277364] initcall proc_devices_init+0x0/0x20 returned 0 after 4 usecs
[    1.278608] calling  proc_interrupts_init+0x0/0x20 @ 1
[    1.279612] initcall proc_interrupts_init+0x0/0x20 returned 0 after 4 usecs
[    1.280867] calling  proc_loadavg_init+0x0/0x1d @ 1
[    1.281738] initcall proc_loadavg_init+0x0/0x1d returned 0 after 4 usecs
[    1.282984] calling  proc_meminfo_init+0x0/0x1d @ 1
[    1.283863] initcall proc_meminfo_init+0x0/0x1d returned 0 after 4 usecs
[    1.285117] calling  proc_stat_init+0x0/0x1a @ 1
[    1.285990] initcall proc_stat_init+0x0/0x1a returned 0 after 5 usecs
[    1.287232] calling  proc_uptime_init+0x0/0x1d @ 1
[    1.288125] initcall proc_uptime_init+0x0/0x1d returned 0 after 7 usecs
[    1.289357] calling  proc_version_init+0x0/0x1d @ 1
[    1.290239] initcall proc_version_init+0x0/0x1d returned 0 after 4 usecs
[    1.291483] calling  proc_softirqs_init+0x0/0x1d @ 1
[    1.292500] initcall proc_softirqs_init+0x0/0x1d returned 0 after 6 usecs
[    1.293734] calling  proc_kcore_init+0x0/0xcb @ 1
[    1.294651] initcall proc_kcore_init+0x0/0xcb returned 0 after 40 usecs
[    1.295858] calling  vmcore_init+0x0/0x90 @ 1
[    1.296744] initcall vmcore_init+0x0/0x90 returned 0 after 0 usecs
[    1.297858] calling  proc_kmsg_init+0x0/0x1d @ 1
[    1.298739] initcall proc_kmsg_init+0x0/0x1d returned 0 after 4 usecs
[    1.299982] calling  proc_page_init+0x0/0x51 @ 1
[    1.300884] initcall proc_page_init+0x0/0x51 returned 0 after 15 usecs
[    1.302108] calling  init_ramfs_fs+0x0/0x1b @ 1
[    1.302984] initcall init_ramfs_fs+0x0/0x1b returned 0 after 0 usecs
[    1.304242] calling  init_hugetlbfs_fs+0x0/0x176 @ 1
[    1.305332] initcall init_hugetlbfs_fs+0x0/0x176 returned 0 after 93 usecs
[    1.306610] calling  tomoyo_initerface_init+0x0/0x173 @ 1
[    1.307610] initcall tomoyo_initerface_init+0x0/0x173 returned 0 after 0 usecs
[    1.308994] calling  aa_create_aafs+0x0/0x3af @ 1
[    1.309861] initcall aa_create_aafs+0x0/0x3af returned 0 after 0 usecs
[    1.311108] calling  blk_scsi_ioctl_init+0x0/0x394 @ 1
[    1.312120] initcall blk_scsi_ioctl_init+0x0/0x394 returned 0 after 1 usecs
[    1.313358] calling  dynamic_debug_init_debugfs+0x0/0x62 @ 1
[    1.314509] initcall dynamic_debug_init_debugfs+0x0/0x62 returned 0 after 23 usecs
[    1.315860] calling  simplefb_init+0x0/0x70 @ 1
[    1.316792] initcall simplefb_init+0x0/0x70 returned 0 after 48 usecs
[    1.317986] calling  acpi_event_init+0x0/0x28 @ 1
[    1.318904] initcall acpi_event_init+0x0/0x28 returned 0 after 42 usecs
[    1.320118] calling  pnp_system_init+0x0/0xc @ 1
[    1.321017] initcall pnp_system_init+0x0/0xc returned 0 after 33 usecs
[    1.322235] calling  pnpacpi_init+0x0/0x69 @ 1
[    1.323109] pnp: PnP ACPI init
[    1.325553] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.326741] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.327990] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.329257] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.330491] system 00:00: [mem 0xafa00000-0xafa00fff] has been reserved
[    1.331747] system 00:00: [mem 0xfeb00000-0xfeb03fff] has been reserved
[    1.333008] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.334241] system 00:00: [mem 0xfed40000-0xfed8ffff] has been reserved
[    1.335497] system 00:00: [mem 0xff000000-0xffffffff] could not be reserved
[    1.336761] system 00:00: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.338039] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.339241] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.340505] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.341742] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.342992] system 00:00: [mem 0xafa00000-0xafa00fff] has been reserved
[    1.344253] system 00:00: [mem 0xfeb00000-0xfeb03fff] has been reserved
[    1.345491] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.346741] system 00:00: [mem 0xfed40000-0xfed8ffff] has been reserved
[    1.348011] system 00:00: [mem 0xff000000-0xffffffff] could not be reserved
[    1.349248] system 00:00: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.350515] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.356517] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    1.357786] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    1.359006] system 00:01: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    1.360720] system 00:02: [io  0x1000-0x100f] has been reserved
[    1.361867] system 00:02: [io  0xffff] has been reserved
[    1.362867] system 00:02: [io  0xffff] has been reserved
[    1.363868] system 00:02: [io  0x0400-0x047f] has been reserved
[    1.365007] system 00:02: [io  0x0500-0x053f] has been reserved
[    1.366168] system 00:02: [io  0x1000-0x100f] has been reserved
[    1.367244] system 00:02: [io  0xffff] has been reserved
[    1.368256] system 00:02: [io  0xffff] has been reserved
[    1.369242] system 00:02: [io  0x0400-0x047f] has been reserved
[    1.370367] system 00:02: [io  0x0500-0x053f] has been reserved
[    1.371506] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.373105] system 00:03: [io  0x0680-0x06ff] has been reserved
[    1.374242] system 00:03: [io  0x01e0-0x01e7] has been reserved
[    1.375413] system 00:03: [io  0x0680-0x06ff] has been reserved
[    1.376507] system 00:03: [io  0x01e0-0x01e7] has been reserved
[    1.377632] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.379052] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.380457] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.381796] pnp 00:06: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.383628] system 00:07: [mem 0x20000000-0x201fffff] has been reserved
[    1.384884] system 00:07: [mem 0x40000000-0x401fffff] has been reserved
[    1.386162] system 00:07: [mem 0x20000000-0x201fffff] has been reserved
[    1.387368] system 00:07: [mem 0x40000000-0x401fffff] has been reserved
[    1.388645] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.391729] pnp: PnP ACPI: found 8 devices
[    1.392498] initcall pnpacpi_init+0x0/0x69 returned 0 after 67759 usecs
[    1.393736] calling  chr_dev_init+0x0/0xa4 @ 1
[    1.405018] initcall chr_dev_init+0x0/0xa4 returned 0 after 10159 usecs
[    1.406237] calling  firmware_class_init+0x0/0x135 @ 1
[    1.407268] initcall firmware_class_init+0x0/0x135 returned 0 after 28 usecs
[    1.408642] calling  thermal_init+0x0/0x139 @ 1
[    1.409577] initcall thermal_init+0x0/0x139 returned 0 after 87 usecs
[    1.410737] calling  cpufreq_gov_performance_init+0x0/0xc @ 1
[    1.411864] initcall cpufreq_gov_performance_init+0x0/0xc returned 0 after 1 usecs
[    1.413247] calling  map_properties+0x0/0x53c @ 1
[    1.414113] initcall map_properties+0x0/0x53c returned 0 after 0 usecs
[    1.415362] calling  init_acpi_pm_clocksource+0x0/0xda @ 1
[    1.420859] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.422489] initcall init_acpi_pm_clocksource+0x0/0xda returned 0 after 5974 usecs
[    1.423862] calling  pcibios_assign_resources+0x0/0xc5 @ 1
[    1.424941] pci 0000:00:1c.5: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
[    1.426368] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000
[    1.428533] pci 0000:00:1c.5: BAR 15: assigned [mem 0xafb00000-0xafcfffff 64bit pref]
[    1.429988] pci 0000:00:1c.5: BAR 13: assigned [io  0x4000-0x4fff]
[    1.431128] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.432129] pci 0000:00:1c.0:   bridge window [mem 0xc4700000-0xc47fffff]
[    1.433373] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    1.434365] pci 0000:00:1c.1:   bridge window [io  0x2000-0x2fff]
[    1.435492] pci 0000:00:1c.1:   bridge window [mem 0xc2700000-0xc46fffff]
[    1.436749] pci 0000:00:1c.1:   bridge window [mem 0xc0400000-0xc23fffff 64bit pref]
[    1.438245] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.439242] pci 0000:00:1c.2:   bridge window [mem 0xc2600000-0xc26fffff]
[    1.440507] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    1.441492] pci 0000:00:1c.4:   bridge window [mem 0xc2500000-0xc25fffff]
[    1.442749] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    1.443739] pci 0000:00:1c.5:   bridge window [io  0x4000-0x4fff]
[    1.444876] pci 0000:00:1c.5:   bridge window [mem 0xc2400000-0xc24fffff]
[    1.446117] pci 0000:00:1c.5:   bridge window [mem 0xafb00000-0xafcfffff 64bit pref]
[    1.447620] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    1.448639] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.449737] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.450862] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.452122] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff window]
[    1.453362] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff window]
[    1.454612] pci_bus 0000:00: resource 9 [mem 0x000dc000-0x000dffff window]
[    1.455864] pci_bus 0000:00: resource 10 [mem 0xafa00000-0xfeafffff window]
[    1.457122] pci_bus 0000:01: resource 1 [mem 0xc4700000-0xc47fffff]
[    1.458237] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    1.459239] pci_bus 0000:02: resource 1 [mem 0xc2700000-0xc46fffff]
[    1.460371] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc23fffff 64bit pref]
[    1.461737] pci_bus 0000:04: resource 1 [mem 0xc2600000-0xc26fffff]
[    1.462862] pci_bus 0000:05: resource 1 [mem 0xc2500000-0xc25fffff]
[    1.463987] pci_bus 0000:06: resource 0 [io  0x4000-0x4fff]
[    1.464996] pci_bus 0000:06: resource 1 [mem 0xc2400000-0xc24fffff]
[    1.466113] pci_bus 0000:06: resource 2 [mem 0xafb00000-0xafcfffff 64bit pref]
[    1.467489] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7 window]
[    1.468622] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff window]
[    1.469739] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.470988] pci_bus 0000:07: resource 7 [mem 0x000d4000-0x000d7fff window]
[    1.472245] pci_bus 0000:07: resource 8 [mem 0x000d8000-0x000dbfff window]
[    1.473488] pci_bus 0000:07: resource 9 [mem 0x000dc000-0x000dffff window]
[    1.474739] pci_bus 0000:07: resource 10 [mem 0xafa00000-0xfeafffff window]
[    1.476611] initcall pcibios_assign_resources+0x0/0xc5 returned 0 after 50526 usecs
[    1.477989] calling  sysctl_core_init+0x0/0x26 @ 1
[    1.478896] initcall sysctl_core_init+0x0/0x26 returned 0 after 29 usecs
[    1.480123] calling  eth_offload_init+0x0/0xf @ 1
[    1.480998] initcall eth_offload_init+0x0/0xf returned 0 after 6 usecs
[    1.482237] calling  inet_init+0x0/0x280 @ 1
[    1.483264] NET: Registered protocol family 2
[    1.485113] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 180224 bytes)
[    1.486728] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    1.488339] TCP bind hash table entries: 32768 (order: 9, 2621440 bytes)
[    1.490653] TCP: Hash tables configured (established 32768 bind 32768)
[    1.492145] UDP hash table entries: 2048 (order: 6, 393216 bytes)
[    1.493412] UDP-Lite hash table entries: 2048 (order: 6, 393216 bytes)
[    1.495091] initcall inet_init+0x0/0x280 returned 0 after 11692 usecs
[    1.496375] calling  ipv4_offload_init+0x0/0x6f @ 1
[    1.497241] initcall ipv4_offload_init+0x0/0x6f returned 0 after 1 usecs
[    1.498490] calling  ipv6_offload_init+0x0/0x7a @ 1
[    1.499366] initcall ipv6_offload_init+0x0/0x7a returned 0 after 1 usecs
[    1.500623] calling  xsk_init+0x0/0x39 @ 1
[    1.501364] NET: Registered protocol family 44
[    1.502241] initcall xsk_init+0x0/0x39 returned 0 after 856 usecs
[    1.503365] calling  pci_apply_final_quirks+0x0/0x121 @ 1
[    1.504383] pci 0000:00:00.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.505617] pci 0000:00:00.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.506866] pci 0000:00:00.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.508126] pci 0000:00:00.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.509370] pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x110 @ 1
[    1.510618] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.512126] pci 0000:00:02.0: pci_fixup_video+0x0/0x110 took 1472 usecs
[    1.513365] pci 0000:00:02.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.514615] pci 0000:00:02.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.515864] pci 0000:00:02.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.517126] pci 0000:00:02.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.518370] pci 0000:00:16.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.519615] pci 0000:00:16.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.520875] pci 0000:00:16.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.522116] pci 0000:00:16.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.523370] pci 0000:00:19.0: calling  quirk_e100_interrupt+0x0/0x180 @ 1
[    1.524626] pci 0000:00:19.0: quirk_e100_interrupt+0x0/0x180 took 0 usecs
[    1.525866] pci 0000:00:19.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.527116] pci 0000:00:19.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.528375] pci 0000:00:19.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.529618] pci 0000:00:19.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.530871] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    1.538765] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x6b0 took 6362 usecs
[    1.540128] pci 0000:00:1a.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.541368] pci 0000:00:1a.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.542617] pci 0000:00:1a.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.543868] pci 0000:00:1a.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.545132] pci 0000:00:1b.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.546369] pci 0000:00:1b.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.547617] pci 0000:00:1b.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.548877] pci 0000:00:1b.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.550121] pci 0000:00:1c.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.551368] pci 0000:00:1c.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.552624] pci 0000:00:1c.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.553867] pci 0000:00:1c.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.555121] pci 0000:00:1c.1: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.556377] pci 0000:00:1c.1: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.557618] pci 0000:00:1c.1: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.558868] pci 0000:00:1c.1: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.560130] pci 0000:00:1c.2: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.561368] pci 0000:00:1c.2: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.562617] pci 0000:00:1c.2: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.563868] pci 0000:00:1c.2: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.565131] pci 0000:00:1c.4: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.566369] pci 0000:00:1c.4: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.567618] pci 0000:00:1c.4: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.568877] pci 0000:00:1c.4: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.570120] pci 0000:00:1c.5: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.571369] pci 0000:00:1c.5: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.572626] pci 0000:00:1c.5: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.573869] pci 0000:00:1c.5: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.575121] pci 0000:00:1c.6: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.576376] pci 0000:00:1c.6: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.577618] pci 0000:00:1c.6: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.578869] pci 0000:00:1c.6: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.580131] pci 0000:00:1d.0: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    1.587973] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x6b0 took 6327 usecs
[    1.589289] pci 0000:00:1d.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.590472] pci 0000:00:1d.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.591650] pci 0000:00:1d.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.592837] pci 0000:00:1d.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.594022] pci 0000:00:1f.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.595201] pci 0000:00:1f.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.596387] pci 0000:00:1f.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.597568] pci 0000:00:1f.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.598749] pci 0000:00:1f.2: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.599927] pci 0000:00:1f.2: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.601112] pci 0000:00:1f.2: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.602293] pci 0000:00:1f.2: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.603525] pci 0000:04:00.0: calling  mid_power_off_devices+0x0/0x80 @ 1
[    1.604712] pci 0000:04:00.0: mid_power_off_devices+0x0/0x80 took 0 usecs
[    1.605892] pci 0000:04:00.0: calling  pci_d3delay_fixup+0x0/0x40 @ 1
[    1.607070] pci 0000:04:00.0: pci_d3delay_fixup+0x0/0x40 took 0 usecs
[    1.608260] pci 0000:05:00.0: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    1.614118] pci 0000:05:00.0: quirk_usb_early_handoff+0x0/0x6b0 took 4443 usecs
[    1.615425] PCI: CLS 64 bytes, default 64
[    1.616108] initcall pci_apply_final_quirks+0x0/0x121 returned 0 after 109115 usecs
[    1.617417] calling  acpi_reserve_resources+0x0/0xe6 @ 1
[    1.618359] initcall acpi_reserve_resources+0x0/0xe6 returned 0 after 18 usecs
[    1.619664] calling  populate_rootfs+0x0/0x105 @ 1
[    1.620782] initcall populate_rootfs+0x0/0x105 returned 0 after 302 usecs
[    1.621961] calling  pci_iommu_init+0x0/0x3a @ 1
[    1.622757] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.623931] software IO TLB [mem 0xa65d0000-0xaa5d0000] (64MB) mapped at [(____ptrval____)-(____ptrval____)]
[    1.625754] initcall pci_iommu_init+0x0/0x3a returned 0 after 2925 usecs
[    1.626934] calling  calgary_fixup_tce_spaces+0x0/0xfa @ 1
[    1.627859] initcall calgary_fixup_tce_spaces+0x0/0xfa returned -19 after 0 usecs
[    1.629169] calling  ir_dev_scope_init+0x0/0x2e @ 1
[    1.629970] initcall ir_dev_scope_init+0x0/0x2e returned 0 after 0 usecs
[    1.631215] calling  ia32_binfmt_init+0x0/0xf @ 1
[    1.632037] initcall ia32_binfmt_init+0x0/0xf returned 0 after 14 usecs
[    1.633215] calling  amd_uncore_init+0x0/0x270 @ 1
[    1.634014] initcall amd_uncore_init+0x0/0x270 returned -19 after 0 usecs
[    1.635191] calling  amd_ibs_init+0x0/0x1a4 @ 1
[    1.635988] initcall amd_ibs_init+0x0/0x1a4 returned -19 after 0 usecs
[    1.637175] calling  amd_iommu_pc_init+0x0/0x284 @ 1
[    1.638099] initcall amd_iommu_pc_init+0x0/0x284 returned -19 after 0 usecs
[    1.639276] calling  msr_init+0x0/0xec @ 1
[    1.639959] initcall msr_init+0x0/0xec returned 0 after 10 usecs
[    1.641016] calling  register_kernel_offset_dumper+0x0/0x16 @ 1
[    1.642067] initcall register_kernel_offset_dumper+0x0/0x16 returned 0 after 1 usecs
[    1.643497] calling  i8259A_init_ops+0x0/0x1c @ 1
[    1.644302] initcall i8259A_init_ops+0x0/0x1c returned 0 after 1 usecs
[    1.645479] calling  init_tsc_clocksource+0x0/0xbe @ 1
[    1.646408] initcall init_tsc_clocksource+0x0/0xbe returned 0 after 4 usecs
[    1.647595] calling  add_rtc_cmos+0x0/0xc6 @ 1
[    1.648403] initcall add_rtc_cmos+0x0/0xc6 returned 0 after 2 usecs
[    1.649454] calling  i8237A_init_ops+0x0/0x32 @ 1
[    1.650255] initcall i8237A_init_ops+0x0/0x32 returned 0 after 3 usecs
[    1.651431] calling  thermal_throttle_init_device+0x0/0x3d @ 1
[    1.652646] initcall thermal_throttle_init_device+0x0/0x3d returned 0 after 154 usecs
[    1.654078] calling  ioapic_init_ops+0x0/0xf @ 1
[    1.654878] initcall ioapic_init_ops+0x0/0xf returned 0 after 0 usecs
[    1.656064] calling  register_e820_pmem+0x0/0x3d @ 1
[    1.656990] initcall register_e820_pmem+0x0/0x3d returned 0 after 2 usecs
[    1.658167] calling  add_pcspkr+0x0/0x6a @ 1
[    1.659076] initcall add_pcspkr+0x0/0x6a returned 0 after 108 usecs
[    1.660143] calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
[    1.661327] Scanning for low memory corruption every 60 seconds
[    1.662380] initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 1027 usecs
[    1.663936] calling  add_bus_probe+0x0/0x1d @ 1
[    1.664785] initcall add_bus_probe+0x0/0x1d returned 0 after 0 usecs
[    1.665962] calling  sysfb_init+0x0/0x91 @ 1
[    1.666952] simple-framebuffer simple-framebuffer.0: framebuffer at 0xb0000000, 0x180000 bytes, mapped to 0x(____ptrval____)
[    1.669024] simple-framebuffer simple-framebuffer.0: format=r5g6b5, mode=1024x768x16, linelength=2048
[    1.672347] Console: switching to colour frame buffer device 128x96
[    1.674411] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    1.675839] Console: switching to colour dummy device 80x25
[    1.677283] simple-framebuffer simple-framebuffer.0: framebuffer at 0xb0000000, 0x180000 bytes, mapped to 0x(____ptrval____)
[    1.679368] simple-framebuffer simple-framebuffer.0: format=r5g6b5, mode=1024x768x16, linelength=2048
[    1.682337] Console: switching to colour frame buffer device 128x96
[    1.684418] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    1.685761] initcall sysfb_init+0x0/0x91 returned 0 after 18553 usecs
[    1.686945] calling  audit_classes_init+0x0/0xaa @ 1
[    1.687903] initcall audit_classes_init+0x0/0xaa returned 0 after 27 usecs
[    1.689096] calling  pt_dump_init+0x0/0x3e @ 1
[    1.689900] initcall pt_dump_init+0x0/0x3e returned 0 after 0 usecs
[    1.690956] calling  goldfish_init+0x0/0x80 @ 1
[    1.691759] initcall goldfish_init+0x0/0x80 returned -19 after 0 usecs
[    1.692949] calling  iosf_mbi_init+0x0/0x15 @ 1
[    1.693826] initcall iosf_mbi_init+0x0/0x15 returned 0 after 71 usecs
[    1.695010] calling  intel_mid_device_create+0x0/0x53 @ 1
[    1.695939] initcall intel_mid_device_create+0x0/0x53 returned -19 after 0 usecs
[    1.697257] calling  mid_pwr_pci_driver_init+0x0/0x15 @ 1
[    1.698237] initcall mid_pwr_pci_driver_init+0x0/0x15 returned 0 after 47 usecs
[    1.699550] calling  sgi_uv_sysfs_init+0x0/0xa3 @ 1
[    1.700362] initcall sgi_uv_sysfs_init+0x0/0xa3 returned -19 after 0 usecs
[    1.701547] calling  proc_execdomains_init+0x0/0x1d @ 1
[    1.702486] initcall proc_execdomains_init+0x0/0x1d returned 0 after 8 usecs
[    1.703797] calling  register_warn_debugfs+0x0/0x1f @ 1
[    1.704751] initcall register_warn_debugfs+0x0/0x1f returned 0 after 16 usecs
[    1.706061] calling  cpuhp_sysfs_init+0x0/0x89 @ 1
[    1.706956] initcall cpuhp_sysfs_init+0x0/0x89 returned 0 after 88 usecs
[    1.708147] calling  ioresources_init+0x0/0x45 @ 1
[    1.708963] initcall ioresources_init+0x0/0x45 returned 0 after 11 usecs
[    1.710149] calling  init_sched_debug_procfs+0x0/0x2a @ 1
[    1.711085] initcall init_sched_debug_procfs+0x0/0x2a returned 0 after 5 usecs
[    1.712403] calling  lockdep_proc_init+0x0/0x5a @ 1
[    1.713222] initcall lockdep_proc_init+0x0/0x5a returned 0 after 13 usecs
[    1.714404] calling  snapshot_device_init+0x0/0xc @ 1
[    1.715458] initcall snapshot_device_init+0x0/0xc returned 0 after 121 usecs
[    1.716778] calling  irq_gc_init_ops+0x0/0xf @ 1
[    1.717582] initcall irq_gc_init_ops+0x0/0xf returned 0 after 0 usecs
[    1.718765] calling  irq_pm_init_ops+0x0/0xf @ 1
[    1.719568] initcall irq_pm_init_ops+0x0/0xf returned 0 after 0 usecs
[    1.720757] calling  irq_debugfs_init+0x0/0x78 @ 1
[    1.721826] initcall irq_debugfs_init+0x0/0x78 returned 0 after 258 usecs
[    1.723011] calling  timekeeping_init_ops+0x0/0xf @ 1
[    1.723940] initcall timekeeping_init_ops+0x0/0xf returned 0 after 0 usecs
[    1.725130] calling  init_clocksource_sysfs+0x0/0x1f @ 1
[    1.726253] initcall init_clocksource_sysfs+0x0/0x1f returned 0 after 188 usecs
[    1.727565] calling  init_timer_list_procfs+0x0/0x2d @ 1
[    1.728509] initcall init_timer_list_procfs+0x0/0x2d returned 0 after 6 usecs
[    1.729818] calling  alarmtimer_init+0x0/0x14f @ 1
[    1.730867] initcall alarmtimer_init+0x0/0x14f returned 0 after 239 usecs
[    1.732059] calling  init_posix_timers+0x0/0x25 @ 1
[    1.732889] initcall init_posix_timers+0x0/0x25 returned 0 after 23 usecs
[    1.734073] calling  clockevents_init_sysfs+0x0/0xc6 @ 1
[    1.735796] initcall clockevents_init_sysfs+0x0/0xc6 returned 0 after 775 usecs
[    1.737116] calling  proc_dma_init+0x0/0x1d @ 1
[    1.737926] initcall proc_dma_init+0x0/0x1d returned 0 after 6 usecs
[    1.739109] calling  proc_modules_init+0x0/0x1a @ 1
[    1.739918] initcall proc_modules_init+0x0/0x1a returned 0 after 5 usecs
[    1.741108] calling  kallsyms_init+0x0/0x1d @ 1
[    1.741917] initcall kallsyms_init+0x0/0x1d returned 0 after 5 usecs
[    1.743101] calling  pid_namespaces_init+0x0/0x3b @ 1
[    1.744071] initcall pid_namespaces_init+0x0/0x3b returned 0 after 32 usecs
[    1.745256] calling  ikconfig_init+0x0/0x36 @ 1
[    1.746065] initcall ikconfig_init+0x0/0x36 returned 0 after 5 usecs
[    1.747248] calling  audit_watch_init+0x0/0x35 @ 1
[    1.748064] initcall audit_watch_init+0x0/0x35 returned 0 after 4 usecs
[    1.749249] calling  audit_fsnotify_init+0x0/0x35 @ 1
[    1.750182] initcall audit_fsnotify_init+0x0/0x35 returned 0 after 3 usecs
[    1.751367] calling  audit_tree_init+0x0/0x48 @ 1
[    1.752183] initcall audit_tree_init+0x0/0x48 returned 0 after 4 usecs
[    1.753368] calling  gcov_init+0x0/0xc @ 1
[    1.754046] initcall gcov_init+0x0/0xc returned 0 after 1 usecs
[    1.755103] calling  gcov_fs_init+0x0/0xc3 @ 1
[    1.755937] initcall gcov_fs_init+0x0/0xc3 returned 0 after 30 usecs
[    1.757127] calling  init_kprobes+0x0/0x216 @ 1
[    1.758313] Kprobe smoke test: started
[    1.770951] Kprobe smoke test: passed successfully
[    1.772473] initcall init_kprobes+0x0/0x216 returned 0 after 14199 usecs
[    1.774360] calling  seccomp_sysctl_init+0x0/0x27 @ 1
[    1.776054] initcall seccomp_sysctl_init+0x0/0x27 returned 0 after 63 usecs
[    1.777935] calling  utsname_sysctl_init+0x0/0xf @ 1
[    1.779577] initcall utsname_sysctl_init+0x0/0xf returned 0 after 15 usecs
[    1.781476] calling  init_lstats_procfs+0x0/0x1d @ 1
[    1.783109] initcall init_lstats_procfs+0x0/0x1d returned 0 after 6 usecs
[    1.784995] calling  perf_event_sysfs_init+0x0/0x86 @ 1
[    1.787181] initcall perf_event_sysfs_init+0x0/0x86 returned 0 after 541 usecs
[    1.789221] calling  padata_driver_init+0x0/0x34 @ 1
[    1.790894] initcall padata_driver_init+0x0/0x34 returned 0 after 1 usecs
[    1.792807] calling  system_trusted_keyring_init+0x0/0xe9 @ 1
[    1.794592] Initialise system trusted keyrings
[    1.796219] initcall system_trusted_keyring_init+0x0/0xe9 returned 0 after 1586 usecs
[    1.798401] calling  blacklist_init+0x0/0x9b @ 1
[    1.799964] Key type blacklist registered
[    1.801425] initcall blacklist_init+0x0/0x9b returned 0 after 1431 usecs
[    1.803375] calling  kswapd_init+0x0/0x87 @ 1
[    1.805133] initcall kswapd_init+0x0/0x87 returned 0 after 150 usecs
[    1.807092] calling  extfrag_debug_init+0x0/0x73 @ 1
[    1.808859] initcall extfrag_debug_init+0x0/0x73 returned 0 after 45 usecs
[    1.810817] calling  mm_compute_batch_init+0x0/0x14 @ 1
[    1.812531] initcall mm_compute_batch_init+0x0/0x14 returned 0 after 1 usecs
[    1.814613] calling  slab_proc_init+0x0/0x1d @ 1
[    1.816209] initcall slab_proc_init+0x0/0x1d returned 0 after 9 usecs
[    1.818163] calling  workingset_init+0x0/0x7d @ 1
[    1.819736] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    1.821724] initcall workingset_init+0x0/0x7d returned 0 after 1939 usecs
[    1.823679] calling  proc_vmalloc_init+0x0/0x2b @ 1
[    1.825283] initcall proc_vmalloc_init+0x0/0x2b returned 0 after 8 usecs
[    1.827238] calling  procswaps_init+0x0/0x1a @ 1
[    1.828831] initcall procswaps_init+0x0/0x1a returned 0 after 8 usecs
[    1.830785] calling  init_frontswap+0x0/0x8e @ 1
[    1.832432] initcall init_frontswap+0x0/0x8e returned 0 after 66 usecs
[    1.834386] calling  slab_sysfs_init+0x0/0xf7 @ 1
[    1.867253] initcall slab_sysfs_init+0x0/0xf7 returned 0 after 30558 usecs
[    1.869228] calling  init_cleancache+0x0/0x8e @ 1
[    1.870871] initcall init_cleancache+0x0/0x8e returned 0 after 70 usecs
[    1.872830] calling  hmm_init+0x0/0x5f @ 1
[    1.874306] initcall hmm_init+0x0/0x5f returned 0 after 34 usecs
[    1.876140] calling  fcntl_init+0x0/0x25 @ 1
[    1.878015] initcall fcntl_init+0x0/0x25 returned 0 after 296 usecs
[    1.879838] calling  proc_filesystems_init+0x0/0x1d @ 1
[    1.881562] initcall proc_filesystems_init+0x0/0x1d returned 0 after 10 usecs
[    1.883635] calling  start_dirtytime_writeback+0x0/0x25 @ 1
[    1.885349] initcall start_dirtytime_writeback+0x0/0x25 returned 0 after 1 usecs
[    1.887437] calling  blkdev_init+0x0/0x1b @ 1
[    1.889385] initcall blkdev_init+0x0/0x1b returned 0 after 360 usecs
[    1.891333] calling  dio_init+0x0/0x28 @ 1
[    1.893095] initcall dio_init+0x0/0x28 returned 0 after 299 usecs
[    1.894914] calling  dnotify_init+0x0/0x74 @ 1
[    1.897091] initcall dnotify_init+0x0/0x74 returned 0 after 588 usecs
[    1.899039] calling  fanotify_user_setup+0x0/0x72 @ 1
[    1.901626] initcall fanotify_user_setup+0x0/0x72 returned 0 after 859 usecs
[    1.903700] calling  userfaultfd_init+0x0/0x29 @ 1
[    1.905587] initcall userfaultfd_init+0x0/0x29 returned 0 after 295 usecs
[    1.907538] calling  aio_setup+0x0/0x76 @ 1
[    1.909657] initcall aio_setup+0x0/0x76 returned 0 after 648 usecs
[    1.911487] calling  fscrypt_init+0x0/0xba @ 1
[    1.913883] initcall fscrypt_init+0x0/0xba returned 0 after 780 usecs
[    1.915837] calling  init_sys32_ioctl+0x0/0x23 @ 1
[    1.917613] initcall init_sys32_ioctl+0x0/0x23 returned 0 after 181 usecs
[    1.919570] calling  mbcache_init+0x0/0x2c @ 1
[    1.921458] initcall mbcache_init+0x0/0x2c returned 0 after 287 usecs
[    1.923415] calling  init_devpts_fs+0x0/0x23 @ 1
[    1.925034] initcall init_devpts_fs+0x0/0x23 returned 0 after 22 usecs
[    1.926996] calling  ext4_init_fs+0x0/0x161 @ 1
[    1.930713] initcall ext4_init_fs+0x0/0x161 returned 0 after 2081 usecs
[    1.932679] calling  journal_init+0x0/0x107 @ 1
[    1.936062] initcall journal_init+0x0/0x107 returned 0 after 1765 usecs
[    1.938020] calling  init_pstore_fs+0x0/0x4a @ 1
[    1.939595] pstore: using deflate compression
[    1.941197] initcall init_pstore_fs+0x0/0x4a returned 0 after 1562 usecs
[    1.943151] calling  ipc_init+0x0/0x55 @ 1
[    1.944666] initcall ipc_init+0x0/0x55 returned 0 after 54 usecs
[    1.946497] calling  ipc_sysctl_init+0x0/0xf @ 1
[    1.948101] initcall ipc_sysctl_init+0x0/0xf returned 0 after 19 usecs
[    1.950057] calling  init_mqueue_fs+0x0/0xff @ 1
[    1.952032] initcall init_mqueue_fs+0x0/0xff returned 0 after 387 usecs
[    1.953988] calling  key_proc_init+0x0/0x5f @ 1
[    1.955576] initcall key_proc_init+0x0/0x5f returned 0 after 11 usecs
[    1.957545] calling  init_smk_fs+0x0/0x105 @ 1
[    1.959124] initcall init_smk_fs+0x0/0x105 returned 0 after 0 usecs
[    1.960959] calling  smack_nf_ip_init+0x0/0x24 @ 1
[    1.962534] initcall smack_nf_ip_init+0x0/0x24 returned 0 after 0 usecs
[    1.964497] calling  ima_mok_init+0x0/0x8c @ 1
[    1.966076] Allocating IMA blacklist keyring.
[    1.967669] initcall ima_mok_init+0x0/0x8c returned 0 after 1553 usecs
[    1.969635] calling  crypto_algapi_init+0x0/0x8 @ 1
[    1.971224] initcall crypto_algapi_init+0x0/0x8 returned 0 after 6 usecs
[    1.973196] calling  seqiv_module_init+0x0/0xc @ 1
[    1.974786] initcall seqiv_module_init+0x0/0xc returned 0 after 8 usecs
[    1.976753] calling  dh_init+0x0/0x10 @ 1
[    2.138507] initcall dh_init+0x0/0x10 returned 0 after 156545 usecs
[    2.138532] cryptomgr_test (57) used greatest stack depth: 14504 bytes left
[    2.140600] calling  rsa_init+0x0/0x40 @ 1
[    2.530498] initcall rsa_init+0x0/0x40 returned 0 after 380751 usecs
[    2.530509] cryptomgr_test (58) used greatest stack depth: 14152 bytes left
[    2.532472] calling  hmac_module_init+0x0/0xc @ 1
[    2.536040] initcall hmac_module_init+0x0/0xc returned 0 after 0 usecs
[    2.538010] calling  crypto_null_mod_init+0x0/0x43 @ 1
[    2.540305] initcall crypto_null_mod_init+0x0/0x43 returned 0 after 559 usecs
[    2.542419] calling  md5_mod_init+0x0/0xc @ 1
[    2.544258] initcall md5_mod_init+0x0/0xc returned 0 after 226 usecs
[    2.546232] calling  sha1_generic_mod_init+0x0/0xc @ 1
[    2.548286] initcall sha1_generic_mod_init+0x0/0xc returned 0 after 325 usecs
[    2.550392] calling  sha256_generic_mod_init+0x0/0x11 @ 1
[    2.552752] initcall sha256_generic_mod_init+0x0/0x11 returned 0 after 608 usecs
[    2.554870] calling  crypto_ecb_module_init+0x0/0xc @ 1
[    2.556604] initcall crypto_ecb_module_init+0x0/0xc returned 0 after 0 usecs
[    2.558704] calling  crypto_cbc_module_init+0x0/0xc @ 1
[    2.560432] initcall crypto_cbc_module_init+0x0/0xc returned 0 after 0 usecs
[    2.562529] calling  crypto_cts_module_init+0x0/0xc @ 1
[    2.564290] initcall crypto_cts_module_init+0x0/0xc returned 0 after 0 usecs
[    2.566385] calling  crypto_module_init+0x0/0xc @ 1
[    2.567981] initcall crypto_module_init+0x0/0xc returned 0 after 0 usecs
[    2.569964] calling  crypto_ctr_module_init+0x0/0x37 @ 1
[    2.571685] initcall crypto_ctr_module_init+0x0/0x37 returned 0 after 0 usecs
[    2.573795] calling  crypto_gcm_module_init+0x0/0xad @ 1
[    2.575517] initcall crypto_gcm_module_init+0x0/0xad returned 0 after 5 usecs
[    2.577620] calling  aes_init+0x0/0xc @ 1
[    2.579216] initcall aes_init+0x0/0xc returned 0 after 127 usecs
[    2.581071] calling  crc32c_mod_init+0x0/0xc @ 1
[    2.582984] initcall crc32c_mod_init+0x0/0xc returned 0 after 316 usecs
[    2.584960] calling  crct10dif_mod_init+0x0/0xc @ 1
[    2.587021] initcall crct10dif_mod_init+0x0/0xc returned 0 after 459 usecs
[    2.589011] calling  lzo_mod_init+0x0/0x35 @ 1
[    2.591446] initcall lzo_mod_init+0x0/0x35 returned 0 after 826 usecs
[    2.593441] calling  crypto842_mod_init+0x0/0x35 @ 1
[    2.595271] alg: No test for 842 (842-generic)
[    2.596997] alg: No test for 842 (842-scomp)
[    2.598606] initcall crypto842_mod_init+0x0/0x35 returned 0 after 3365 usecs
[    2.600719] calling  drbg_init+0x0/0x78 @ 1
[    2.602530] kworker/u16:0 (76) used greatest stack depth: 14040 bytes left
[    2.604674] cryptomgr_test (79) used greatest stack depth: 13752 bytes left
[    2.606888] cryptomgr_test (75) used greatest stack depth: 13600 bytes left
[    2.610458] initcall drbg_init+0x0/0x78 returned 0 after 8070 usecs
[    2.612359] calling  jent_mod_init+0x0/0x29 @ 1
[    2.614220] initcall jent_mod_init+0x0/0x29 returned 0 after 270 usecs
[    2.616201] calling  ghash_mod_init+0x0/0xc @ 1
[    2.618202] initcall ghash_mod_init+0x0/0xc returned 0 after 402 usecs
[    2.620187] calling  asymmetric_key_init+0x0/0xc @ 1
[    2.621892] Key type asymmetric registered
[    2.623347] initcall asymmetric_key_init+0x0/0xc returned 0 after 1421 usecs
[    2.625442] calling  x509_key_init+0x0/0xc @ 1
[    2.627039] Asymmetric key parser 'x509' registered
[    2.628624] initcall x509_key_init+0x0/0xc returned 0 after 1561 usecs
[    2.630582] calling  proc_genhd_init+0x0/0x3d @ 1
[    2.632185] initcall proc_genhd_init+0x0/0x3d returned 0 after 16 usecs
[    2.634145] calling  bsg_init+0x0/0x18f @ 1
[    2.635606] _warn_unseeded_randomness: 120 callbacks suppressed
[    2.635610] random: get_random_u64 called from __kmem_cache_create+0x41/0x580 with crng_init=0
[    2.639815] random: get_random_u64 called from cache_random_seq_create+0x60/0x150 with crng_init=0
[    2.642511] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    2.644610] initcall bsg_init+0x0/0x18f returned 0 after 8800 usecs
[    2.646448] calling  throtl_init+0x0/0x45 @ 1
[    2.648102] random: get_random_u64 called from copy_process+0x2be/0x1da0 with crng_init=0
[    2.650397] initcall throtl_init+0x0/0x45 returned 0 after 2299 usecs
[    2.652387] calling  noop_init+0x0/0xc @ 1
[    2.653850] io scheduler noop registered (default)
[    2.655430] initcall noop_init+0x0/0xc returned 0 after 1549 usecs
[    2.657377] calling  btree_module_init+0x0/0x25 @ 1
[    2.659277] initcall btree_module_init+0x0/0x25 returned 0 after 296 usecs
[    2.661247] calling  crc_t10dif_mod_init+0x0/0x39 @ 1
[    2.662965] initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 6 usecs
[    2.664933] calling  sw842_init+0x0/0x12c @ 1
[    2.666516] initcall sw842_init+0x0/0x12c returned 0 after 0 usecs
[    2.668358] calling  sw842_init+0x0/0x12c @ 1
[    2.669941] initcall sw842_init+0x0/0x12c returned 0 after 0 usecs
[    2.671769] calling  percpu_counter_startup+0x0/0x51 @ 1
[    2.673498] tsc: Refined TSC clocksource calibration: 2394.560 MHz
[    2.675340] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2284248580e, max_idle_ns: 440795288736 ns
[    2.678358] clocksource: Switched to clocksource tsc
[    2.678420] initcall percpu_counter_startup+0x0/0x51 returned 0 after 4822 usecs
[    2.682453] calling  digsig_init+0x0/0x36 @ 1
[    2.684052] initcall digsig_init+0x0/0x36 returned 0 after 7 usecs
[    2.685889] calling  sg_pool_init+0x0/0xd4 @ 1
[    2.689051] initcall sg_pool_init+0x0/0xd4 returned 0 after 1540 usecs
[    2.691011] calling  phy_core_init+0x0/0x45 @ 1
[    2.692631] initcall phy_core_init+0x0/0x45 returned 0 after 26 usecs
[    2.694593] calling  bgpio_driver_init+0x0/0xe @ 1
[    2.696236] initcall bgpio_driver_init+0x0/0xe returned 0 after 52 usecs
[    2.698203] calling  ftgpio_gpio_driver_init+0x0/0xe @ 1
[    2.699952] initcall ftgpio_gpio_driver_init+0x0/0xe returned 0 after 37 usecs
[    2.702063] calling  intel_gpio_driver_init+0x0/0x15 @ 1
[    2.703836] initcall intel_gpio_driver_init+0x0/0x15 returned 0 after 62 usecs
[    2.705931] calling  sdv_gpio_driver_init+0x0/0x15 @ 1
[    2.707686] initcall sdv_gpio_driver_init+0x0/0x15 returned 0 after 42 usecs
[    2.709779] calling  tps68470_gpio_driver_init+0x0/0xe @ 1
[    2.711534] initcall tps68470_gpio_driver_init+0x0/0xe returned 0 after 41 usecs
[    2.713634] calling  crystalcove_pwm_driver_init+0x0/0xe @ 1
[    2.715508] initcall crystalcove_pwm_driver_init+0x0/0xe returned 0 after 36 usecs
[    2.717612] calling  stmpe_pwm_driver_init+0x0/0x15 @ 1
[    2.719391] initcall stmpe_pwm_driver_init+0x0/0x15 returned -19 after 67 usecs
[    2.721490] calling  pci_proc_init+0x0/0x67 @ 1
[    2.723199] initcall pci_proc_init+0x0/0x67 returned 0 after 118 usecs
[    2.725172] calling  pcie_portdrv_init+0x0/0x30 @ 1
[    2.765733] initcall pcie_portdrv_init+0x0/0x30 returned 0 after 38058 usecs
[    2.767823] calling  aer_service_init+0x0/0x2d @ 1
[    2.769448] initcall aer_service_init+0x0/0x2d returned 0 after 32 usecs
[    2.771414] calling  pcie_pme_service_init+0x0/0xc @ 1
[    2.773170] initcall pcie_pme_service_init+0x0/0xc returned 0 after 36 usecs
[    2.775260] calling  dpc_service_init+0x0/0xc @ 1
[    2.776891] initcall dpc_service_init+0x0/0xc returned 0 after 32 usecs
[    2.778855] calling  pci_hotplug_init+0x0/0x2c @ 1
[    2.780452] initcall pci_hotplug_init+0x0/0x2c returned 0 after 0 usecs
[    2.782419] calling  pcied_init+0x0/0x51 @ 1
[    2.784049] initcall pcied_init+0x0/0x51 returned 0 after 34 usecs
[    2.785890] calling  shpcd_init+0x0/0x54 @ 1
[    2.787566] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.789541] initcall shpcd_init+0x0/0x54 returned 0 after 2016 usecs
[    2.791508] calling  pci_ep_cfs_init+0x0/0xc9 @ 1
[    2.793275] initcall pci_ep_cfs_init+0x0/0xc9 returned 0 after 167 usecs
[    2.795244] calling  pci_epc_init+0x0/0x3d @ 1
[    2.796877] initcall pci_epc_init+0x0/0x3d returned 0 after 27 usecs
[    2.798846] calling  pci_epf_init+0x0/0x25 @ 1
[    2.800497] initcall pci_epf_init+0x0/0x25 returned 0 after 48 usecs
[    2.802471] calling  cdns_pcie_host_driver_init+0x0/0xe @ 1
[    2.804240] initcall cdns_pcie_host_driver_init+0x0/0xe returned 0 after 38 usecs
[    2.806344] calling  cdns_pcie_ep_driver_init+0x0/0xe @ 1
[    2.808118] initcall cdns_pcie_ep_driver_init+0x0/0xe returned 0 after 41 usecs
[    2.810222] calling  faraday_pci_driver_init+0x0/0xe @ 1
[    2.811973] initcall faraday_pci_driver_init+0x0/0xe returned 0 after 29 usecs
[    2.814096] calling  gen_pci_driver_init+0x0/0xe @ 1
[    2.815861] initcall gen_pci_driver_init+0x0/0xe returned 0 after 32 usecs
[    2.817849] calling  dw_plat_pcie_driver_init+0x0/0xe @ 1
[    2.819616] initcall dw_plat_pcie_driver_init+0x0/0xe returned 0 after 30 usecs
[    2.821732] calling  imsttfb_init+0x0/0x10c @ 1
[    2.823392] initcall imsttfb_init+0x0/0x10c returned 0 after 57 usecs
[    2.825377] calling  asiliantfb_init+0x0/0x2d @ 1
[    2.827035] initcall asiliantfb_init+0x0/0x2d returned 0 after 50 usecs
[    2.829027] calling  vesafb_driver_init+0x0/0xe @ 1
[    2.830674] initcall vesafb_driver_init+0x0/0xe returned 0 after 41 usecs
[    2.832665] calling  efifb_driver_init+0x0/0xe @ 1
[    2.834312] initcall efifb_driver_init+0x0/0xe returned 0 after 36 usecs
[    2.836303] calling  intel_idle_init+0x0/0x671 @ 1
[    2.837916] intel_idle: MWAIT substates: 0x21120
[    2.839520] intel_idle: v0.4.1 model 0x2A
[    2.842537] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.844412] initcall intel_idle_init+0x0/0x671 returned 0 after 6343 usecs
[    2.846393] calling  ged_driver_init+0x0/0xe @ 1
[    2.848063] initcall ged_driver_init+0x0/0xe returned 0 after 63 usecs
[    2.850044] calling  acpi_button_driver_init+0x0/0x18 @ 1
[    2.852119] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.854529] ACPI: Power Button [PWRB]
[    2.856674] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.859110] ACPI: Power Button [PWRB]
[    2.860922] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    2.863400] ACPI: Lid Switch [LID]
[    2.865239] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input3
[    2.867522] ACPI: Lid Switch [LID]
[    2.869134] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    2.871403] ACPI: Power Button [PWRF]
[    2.873138] button: probe of LNXPWRBN:00 failed with error -22
[    2.875020] initcall acpi_button_driver_init+0x0/0x18 returned 0 after 22700 usecs
[    2.877141] calling  acpi_video_init+0x0/0xa6 @ 1
[    2.878755] initcall acpi_video_init+0x0/0xa6 returned 0 after 13 usecs
[    2.880739] calling  acpi_hed_driver_init+0x0/0xc @ 1
[    2.882542] initcall acpi_hed_driver_init+0x0/0xc returned 0 after 76 usecs
[    2.884528] calling  bgrt_init+0x0/0xb0 @ 1
[    2.886003] initcall bgrt_init+0x0/0xb0 returned -19 after 0 usecs
[    2.887857] calling  erst_init+0x0/0x322 @ 1
[    2.889462] initcall erst_init+0x0/0x322 returned 0 after 1 usecs
[    2.891314] calling  ghes_init+0x0/0x138 @ 1
[    2.892916] initcall ghes_init+0x0/0x138 returned -19 after 0 usecs
[    2.894767] calling  intel_crc_pmic_opregion_driver_init+0x0/0xe @ 1
[    2.896791] initcall intel_crc_pmic_opregion_driver_init+0x0/0xe returned 0 after 39 usecs
[    2.899015] calling  intel_xpower_pmic_opregion_driver_init+0x0/0xe @ 1
[    2.901030] initcall intel_xpower_pmic_opregion_driver_init+0x0/0xe returned 0 after 37 usecs
[    2.903380] calling  intel_bxtwc_pmic_opregion_driver_init+0x0/0xe @ 1
[    2.905413] initcall intel_bxtwc_pmic_opregion_driver_init+0x0/0xe returned 0 after 45 usecs
[    2.907763] calling  intel_cht_wc_pmic_opregion_driver_init+0x0/0xe @ 1
[    2.909791] initcall intel_cht_wc_pmic_opregion_driver_init+0x0/0xe returned 0 after 44 usecs
[    2.912149] calling  chtdc_ti_pmic_opregion_driver_init+0x0/0xe @ 1
[    2.914037] initcall chtdc_ti_pmic_opregion_driver_init+0x0/0xe returned 0 after 36 usecs
[    2.916276] calling  tps68470_pmic_opregion_driver_init+0x0/0xe @ 1
[    2.918162] initcall tps68470_pmic_opregion_driver_init+0x0/0xe returned 0 after 35 usecs
[    2.920397] calling  of_fixed_factor_clk_driver_init+0x0/0xe @ 1
[    2.922280] initcall of_fixed_factor_clk_driver_init+0x0/0xe returned 0 after 35 usecs
[    2.924512] calling  of_fixed_clk_driver_init+0x0/0xe @ 1
[    2.926277] initcall of_fixed_clk_driver_init+0x0/0xe returned 0 after 43 usecs
[    2.928385] calling  gpio_clk_driver_init+0x0/0xe @ 1
[    2.930143] initcall gpio_clk_driver_init+0x0/0xe returned 0 after 37 usecs
[    2.932124] calling  hsdk_pll_clk_driver_init+0x0/0xe @ 1
[    2.933882] initcall hsdk_pll_clk_driver_init+0x0/0xe returned 0 after 37 usecs
[    2.935980] calling  plt_clk_driver_init+0x0/0xe @ 1
[    2.937742] initcall plt_clk_driver_init+0x0/0xe returned 0 after 37 usecs
[    2.939713] calling  st_clk_driver_init+0x0/0xe @ 1
[    2.941365] initcall st_clk_driver_init+0x0/0xe returned 0 after 46 usecs
[    2.943335] calling  xenbus_probe_initcall+0x0/0x3d @ 1
[    2.945060] initcall xenbus_probe_initcall+0x0/0x3d returned -19 after 0 usecs
[    2.947161] calling  xenbus_init+0x0/0x31 @ 1
[    2.948755] initcall xenbus_init+0x0/0x31 returned -19 after 0 usecs
[    2.950728] calling  xenbus_backend_init+0x0/0x3a @ 1
[    2.952451] initcall xenbus_backend_init+0x0/0x3a returned -19 after 0 usecs
[    2.954551] calling  hypervisor_subsys_init+0x0/0x20 @ 1
[    2.956275] initcall hypervisor_subsys_init+0x0/0x20 returned -19 after 0 usecs
[    2.958372] calling  hyper_sysfs_init+0x0/0x172 @ 1
[    2.959959] initcall hyper_sysfs_init+0x0/0x172 returned -19 after 0 usecs
[    2.961935] calling  platform_driver_init+0x0/0x15 @ 1
[    2.963706] initcall platform_driver_init+0x0/0x15 returned 0 after 53 usecs
[    2.965809] calling  xen_late_init_mcelog+0x0/0x53 @ 1
[    2.967529] initcall xen_late_init_mcelog+0x0/0x53 returned -19 after 0 usecs
[    2.969634] calling  pvcalls_back_init+0x0/0x4b @ 1
[    2.971232] initcall pvcalls_back_init+0x0/0x4b returned -19 after 0 usecs
[    2.973210] calling  n_null_init+0x0/0x1a @ 1
[    2.974803] initcall n_null_init+0x0/0x1a returned 0 after 1 usecs
[    2.976652] calling  pty_init+0x0/0x333 @ 1
[    3.040744] initcall pty_init+0x0/0x333 returned 0 after 61150 usecs
[    3.042727] calling  sysrq_init+0x0/0x45 @ 1
[    3.044341] initcall sysrq_init+0x0/0x45 returned 0 after 12 usecs
[    3.046182] calling  xen_hvc_init+0x0/0x262 @ 1
[    3.047769] initcall xen_hvc_init+0x0/0x262 returned -19 after 0 usecs
[    3.049744] calling  serial8250_init+0x0/0x156 @ 1
[    3.051337] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.057945] initcall serial8250_init+0x0/0x156 returned 0 after 6451 usecs
[    3.059914] calling  hpet_init+0x0/0x60 @ 1
[    3.062349] initcall hpet_init+0x0/0x60 returned 0 after 941 usecs
[    3.064200] calling  agp_init+0x0/0x1f @ 1
[    3.065655] Linux agpgart interface v0.103
[    3.067111] initcall agp_init+0x0/0x1f returned 0 after 1420 usecs
[    3.068956] calling  agp_intel_init+0x0/0x24 @ 1
[    3.070604] initcall agp_intel_init+0x0/0x24 returned 0 after 62 usecs
[    3.072569] calling  init_tis+0x0/0xd3 @ 1
[    3.074118] initcall init_tis+0x0/0xd3 returned 0 after 91 usecs
[    3.075950] calling  crb_acpi_driver_init+0x0/0xc @ 1
[    3.077742] initcall crb_acpi_driver_init+0x0/0xc returned 0 after 72 usecs
[    3.079706] calling  drm_kms_helper_init+0x0/0xf @ 1
[    3.081473] initcall drm_kms_helper_init+0x0/0xf returned 0 after 37 usecs
[    3.083438] calling  drm_core_init+0x0/0xdc @ 1
[    3.085084] initcall drm_core_init+0x0/0xdc returned 0 after 56 usecs
[    3.087040] calling  intelfb_init+0x0/0x8f @ 1
[    3.088621] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM chipsets
[    3.092269] intelfb: Version 0.9.6
[    3.093689] initcall intelfb_init+0x0/0x8f returned 0 after 4947 usecs
[    3.095659] calling  _nvm_misc_init+0x0/0xc @ 1
[    3.097486] initcall _nvm_misc_init+0x0/0xc returned 0 after 223 usecs
[    3.099463] calling  topology_sysfs_init+0x0/0x30 @ 1
[    3.101303] initcall topology_sysfs_init+0x0/0x30 returned 0 after 110 usecs
[    3.103400] calling  cacheinfo_sysfs_init+0x0/0x27 @ 1
[    3.106940] initcall cacheinfo_sysfs_init+0x0/0x27 returned 168 after 1766 usecs
[    3.109068] calling  devcoredump_init+0x0/0x13 @ 1
[    3.110718] initcall devcoredump_init+0x0/0x13 returned 0 after 41 usecs
[    3.112706] calling  htcpld_core_init+0x0/0x28 @ 1
[    3.114406] initcall htcpld_core_init+0x0/0x28 returned -19 after 97 usecs
[    3.116392] calling  tps68470_driver_init+0x0/0xe @ 1
[    3.118154] initcall tps68470_driver_init+0x0/0xe returned 0 after 35 usecs
[    3.120141] calling  twl_driver_init+0x0/0xe @ 1
[    3.121776] initcall twl_driver_init+0x0/0xe returned 0 after 34 usecs
[    3.123751] calling  twl4030_audio_driver_init+0x0/0xe @ 1
[    3.125519] initcall twl4030_audio_driver_init+0x0/0xe returned 0 after 37 usecs
[    3.127625] calling  twl6040_driver_init+0x0/0xe @ 1
[    3.129393] initcall twl6040_driver_init+0x0/0xe returned 0 after 33 usecs
[    3.131373] calling  smsc_i2c_driver_init+0x0/0xe @ 1
[    3.133140] initcall smsc_i2c_driver_init+0x0/0xe returned 0 after 36 usecs
[    3.135119] calling  max77620_driver_init+0x0/0xe @ 1
[    3.136883] initcall max77620_driver_init+0x0/0xe returned 0 after 32 usecs
[    3.138864] calling  adp5520_driver_init+0x0/0xe @ 1
[    3.140637] initcall adp5520_driver_init+0x0/0xe returned 0 after 39 usecs
[    3.142616] calling  intel_msic_driver_init+0x0/0xe @ 1
[    3.144398] initcall intel_msic_driver_init+0x0/0xe returned 0 after 45 usecs
[    3.146507] calling  intel_soc_pmic_i2c_driver_init+0x0/0xe @ 1
[    3.148401] initcall intel_soc_pmic_i2c_driver_init+0x0/0xe returned 0 after 34 usecs
[    3.150637] calling  cht_wc_driver_init+0x0/0xe @ 1
[    3.152277] initcall cht_wc_driver_init+0x0/0xe returned 0 after 34 usecs
[    3.154255] calling  init_sd+0x0/0x165 @ 1
[    3.156208] initcall init_sd+0x0/0x165 returned 0 after 472 usecs
[    3.158058] calling  nvme_core_init+0x0/0x159 @ 1
[    3.160549] initcall nvme_core_init+0x0/0x159 returned 0 after 876 usecs
[    3.162522] calling  nvme_init+0x0/0x15 @ 1
[    3.164100] initcall nvme_init+0x0/0x15 returned 0 after 106 usecs
[    3.165943] calling  ahci_pci_driver_init+0x0/0x15 @ 1
[    3.167727] ahci 0000:00:1f.2: version 3.0
[    3.172732] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    3.184900] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0xd impl SATA mode
[    3.187134] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems sxs apst 
[    3.217322] scsi host0: ahci
[    3.219735] scsi host1: ahci
[    3.222003] scsi host2: ahci
[    3.224064] scsi host3: ahci
[    3.226245] scsi host4: ahci
[    3.228305] scsi host5: ahci
[    3.230063] ata1: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827100 irq 24
[    3.232148] ata2: DUMMY
[    3.233339] ata3: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827200 irq 24
[    3.235421] ata4: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827280 irq 24
[    3.237511] ata5: DUMMY
[    3.238699] ata6: DUMMY
[    3.556491] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.560454] ata3.00: ATAPI: MATSHITADVD-RAM UJ8A2ES, 1.20, max UDMA/100
[    3.566405] ata3.00: configured for UDMA/100
[    3.571777] ata3.00: disabled
[    3.888497] ata4: SATA link down (SStatus 0 SControl 300)
[    3.890241] WARNING: CPU: 1 PID: 1 at ../drivers/ata/libata-core.c:6677 ata_host_detach+0x6e/0x150
[    3.892580] Modules linked in:
[    3.893895] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.18.9 #2
[    3.894214] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[    3.894214] RIP: 0010:ata_host_detach+0x6e/0x150
[    3.894214] Code: 00 00 4c 89 e7 48 89 c3 e8 ef cd 00 00 49 8b 7c 24 10 48 89 de e8 82 f4 1a 00 4c 89 e7 e8 0a bd 00 00 41 f6 44 24 21 04 75 02 <0f> 0b 49 8d bc 24 f0 40 00 00 e8 13 8d ab ff 31 ff ba 01 00 00 00 
[    3.894214] RSP: 0000:ffffb9758064fd08 EFLAGS: 00010246
[    3.894214] RAX: 0000000000000000 RBX: 0000000000000282 RCX: 0000000000000002
[    3.894214] RDX: ffff8dd408b39158 RSI: 0000000000000002 RDI: 0000000000000246
[    3.894214] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[    3.894214] R10: ffffb9758064fc18 R11: 0000000000000000 R12: ffff8dd408b20000
[    3.894214] R13: 0000000000000003 R14: ffff8dd40af42128 R15: 0000000000000000
[    3.894214] FS:  0000000000000000(0000) GS:ffff8dd409800000(0000) knlGS:0000000000000000
[    3.894214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.894214] CR2: 0000000000000000 CR3: 0000000045224001 CR4: 00000000000606e0
[    3.894214] Call Trace:
[    3.894214]  pci_device_remove+0x50/0xb0
[    3.894214]  driver_probe_device+0x239/0x4a0
[    3.894214]  ? do_early_param+0x8b/0x8b
[    3.894214]  __driver_attach+0xcd/0x110
[    3.894214]  ? driver_probe_device+0x4a0/0x4a0
[    3.894214]  ? driver_probe_device+0x4a0/0x4a0
[    3.894214]  bus_for_each_dev+0x5a/0xb0
[    3.894214]  bus_add_driver+0x135/0x230
[    3.894214]  ? ata_sff_init+0x35/0x35
[    3.894214]  driver_register+0x9a/0xd0
[    3.894214]  ? ata_sff_init+0x35/0x35
[    3.894214]  do_one_initcall+0x6d/0x16a
[    3.894214]  kernel_init_freeable+0x1e4/0x2a3
[    3.894214]  ? rest_init+0x100/0x100
[    3.894214]  kernel_init+0x5/0x100
[    3.894214]  ret_from_fork+0x35/0x40
[    3.894214] _warn_unseeded_randomness: 18 callbacks suppressed
[    3.894214] random: get_random_bytes called from print_oops_end_marker+0x1d/0x40 with crng_init=0
[    3.894214] ---[ end trace c233452dde376be1 ]---
[    4.163461] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    4.175588] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0xd impl SATA mode
[    4.177767] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems sxs apst 
[    4.209185] scsi host0: ahci
[    4.211347] scsi host1: ahci
[    4.213338] scsi host2: ahci
[    4.215410] scsi host3: ahci
[    4.217401] scsi host4: ahci
[    4.219387] scsi host5: ahci
[    4.221081] ata7: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827100 irq 24
[    4.223082] ata8: DUMMY
[    4.224207] ata9: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827200 irq 24
[    4.226213] ata10: SATA max UDMA/133 abar m2048@0xc4827000 port 0xc4827280 irq 24
[    4.228223] ata11: DUMMY
[    4.229342] ata12: DUMMY
[    4.230580] initcall ahci_pci_driver_init+0x0/0x15 returned 0 after 1038007 usecs
[    4.232629] calling  net_olddevs_init+0x0/0x58 @ 1
[    4.234133] initcall net_olddevs_init+0x0/0x58 returned 0 after 3 usecs
[    4.236020] calling  kgdbdbgp_start_thread+0x0/0x48 @ 1
[    4.237645] initcall kgdbdbgp_start_thread+0x0/0x48 returned 0 after 0 usecs
[    4.239651] calling  i8042_init+0x0/0x476 @ 1
[    4.241341] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    4.245894] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.247548] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.249320] initcall i8042_init+0x0/0x476 returned 0 after 7968 usecs
[    4.251207] calling  atkbd_init+0x0/0x21 @ 1
[    4.252770] initcall atkbd_init+0x0/0x21 returned 0 after 54 usecs
[    4.254525] calling  as3722_poweroff_driver_init+0x0/0xe @ 1
[    4.256325] initcall as3722_poweroff_driver_init+0x0/0xe returned 0 after 39 usecs
[    4.258333] calling  gpio_poweroff_driver_init+0x0/0xe @ 1
[    4.259997] initcall gpio_poweroff_driver_init+0x0/0xe returned 0 after 37 usecs
[    4.261410] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    4.262013] calling  gpio_restart_driver_init+0x0/0xe @ 1
[    4.265948] initcall gpio_restart_driver_init+0x0/0xe returned 0 after 37 usecs
[    4.267955] calling  ltc2952_poweroff_driver_init+0x0/0xe @ 1
[    4.269778] initcall ltc2952_poweroff_driver_init+0x0/0xe returned 0 after 49 usecs
[    4.271787] calling  restart_poweroff_driver_init+0x0/0xe @ 1
[    4.273596] initcall restart_poweroff_driver_init+0x0/0xe returned 0 after 42 usecs
[    4.275607] calling  syscon_reboot_driver_init+0x0/0xe @ 1
[    4.277303] initcall syscon_reboot_driver_init+0x0/0xe returned 0 after 51 usecs
[    4.279317] calling  syscon_poweroff_register+0x0/0xe @ 1
[    4.281010] initcall syscon_poweroff_register+0x0/0xe returned 0 after 44 usecs
[    4.283024] calling  watchdog_gov_panic_register+0x0/0xc @ 1
[    4.284808] initcall watchdog_gov_panic_register+0x0/0xc returned 0 after 23 usecs
[    4.286818] calling  cpufreq_dt_platdev_init+0x0/0x131 @ 1
[    4.288466] initcall cpufreq_dt_platdev_init+0x0/0x131 returned -19 after 1 usecs
[    4.290491] calling  ledtrig_disk_init+0x0/0x4f @ 1
[    4.292040] initcall ledtrig_disk_init+0x0/0x4f returned 0 after 19 usecs
[    4.293948] calling  ledtrig_mtd_init+0x0/0x29 @ 1
[    4.295490] initcall ledtrig_mtd_init+0x0/0x29 returned 0 after 15 usecs
[    4.297401] calling  ledtrig_cpu_init+0x0/0xce @ 1
[    4.299142] ledtrig-cpu: registered to indicate activity on CPUs
[    4.300939] initcall ledtrig_cpu_init+0x0/0xce returned 0 after 1962 usecs
[    4.302847] calling  ledtrig_panic_init+0x0/0x34 @ 1
[    4.304524] initcall ledtrig_panic_init+0x0/0x34 returned 0 after 9 usecs
[    4.306430] calling  efi_load_efivars+0x0/0x6c @ 1
[    4.307958] initcall efi_load_efivars+0x0/0x6c returned 0 after 0 usecs
[    4.308089] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input6
[    4.309873] calling  esrt_sysfs_init+0x0/0x2f5 @ 1
[    4.313705] initcall esrt_sysfs_init+0x0/0x2f5 returned -38 after 0 usecs
[    4.315620] calling  ion_system_contig_heap_create+0x0/0x50 @ 1
[    4.317433] initcall ion_system_contig_heap_create+0x0/0x50 returned 0 after 17 usecs
[    4.319601] calling  ion_system_heap_create+0x0/0xd0 @ 1
[    4.321439] initcall ion_system_heap_create+0x0/0xd0 returned 0 after 164 usecs
[    4.323477] calling  ion_add_cma_heaps+0x0/0x20 @ 1
[    4.325018] initcall ion_add_cma_heaps+0x0/0x20 returned 0 after 0 usecs
[    4.326908] calling  ashmem_init+0x0/0xe8 @ 1
[    4.328538] random: get_random_u64 called from __kmem_cache_create+0x41/0x580 with crng_init=0
[    4.330814] random: get_random_u64 called from cache_random_seq_create+0x60/0x150 with crng_init=0
[    4.333981] ashmem: initialized
[    4.335248] initcall ashmem_init+0x0/0xe8 returned 0 after 6563 usecs
[    4.337162] calling  ipc_driver_init+0x0/0x15 @ 1
[    4.338739] initcall ipc_driver_init+0x0/0x15 returned 0 after 54 usecs
[    4.340650] calling  pmc_atom_init+0x0/0x282 @ 1
[    4.342184] initcall pmc_atom_init+0x0/0x282 returned -19 after 13 usecs
[    4.344090] calling  goldfish_pdev_bus_driver_init+0x0/0xe @ 1
[    4.345905] initcall goldfish_pdev_bus_driver_init+0x0/0xe returned 0 after 39 usecs
[    4.348075] calling  extcon_class_init+0x0/0x5 @ 1
[    4.349635] initcall extcon_class_init+0x0/0x5 returned 0 after 26 usecs
[    4.351554] calling  powercap_init+0x0/0x2be @ 1
[    4.353351] initcall powercap_init+0x0/0x2be returned 0 after 239 usecs
[    4.355278] calling  binder_init+0x0/0x2bf @ 1
[    4.357756] initcall binder_init+0x0/0x2bf returned 0 after 889 usecs
[    4.359701] calling  pm_check_save_msr+0x0/0x10 @ 1
[    4.361285] initcall pm_check_save_msr+0x0/0x10 returned 0 after 0 usecs
[    4.363235] calling  sock_diag_init+0x0/0x38 @ 1
[    4.364888] initcall sock_diag_init+0x0/0x38 returned 0 after 71 usecs
[    4.366846] calling  blackhole_init+0x0/0xc @ 1
[    4.368441] initcall blackhole_init+0x0/0xc returned 0 after 1 usecs
[    4.370412] calling  gre_offload_init+0x0/0x44 @ 1
[    4.372016] initcall gre_offload_init+0x0/0x44 returned 0 after 0 usecs
[    4.373994] calling  sysctl_ipv4_init+0x0/0x47 @ 1
[    4.375661] initcall sysctl_ipv4_init+0x0/0x47 returned 0 after 67 usecs
[    4.377653] calling  strp_mod_init+0x0/0x35 @ 1
[    4.379463] initcall strp_mod_init+0x0/0x35 returned 0 after 195 usecs
[    4.381458] calling  dcbnl_init+0x0/0x48 @ 1
[    4.383067] initcall dcbnl_init+0x0/0x48 returned 0 after 10 usecs
[    4.384926] calling  plist_test+0x0/0x1ca @ 1
[    4.386519] start plist test
[    4.389840] end plist test
[    4.391046] initcall plist_test+0x0/0x1ca returned 0 after 4420 usecs
[    4.393030] calling  mcheck_init_device+0x0/0x168 @ 1
[    4.395836] initcall mcheck_init_device+0x0/0x168 returned 0 after 1053 usecs
[    4.397964] calling  dev_mcelog_init_device+0x0/0x46 @ 1
[    4.399903] initcall dev_mcelog_init_device+0x0/0x46 returned 0 after 196 usecs
[    4.402097] calling  tboot_late_init+0x0/0x300 @ 1
[    4.403703] initcall tboot_late_init+0x0/0x300 returned 0 after 0 usecs
[    4.405690] calling  intel_rdt_late_init+0x0/0x4c5 @ 1
[    4.407422] initcall intel_rdt_late_init+0x0/0x4c5 returned -19 after 0 usecs
[    4.409536] calling  mcheck_late_init+0x0/0x67 @ 1
[    4.411222] RAS: Correctable Errors collector initialized.
[    4.412962] initcall mcheck_late_init+0x0/0x67 returned 0 after 1774 usecs
[    4.414942] calling  severities_debugfs_init+0x0/0x36 @ 1
[    4.416698] initcall severities_debugfs_init+0x0/0x36 returned 0 after 19 usecs
[    4.418807] calling  threshold_init_device+0x0/0x46 @ 1
[    4.420547] initcall threshold_init_device+0x0/0x46 returned 0 after 0 usecs
[    4.422655] calling  microcode_init+0x0/0x1fa @ 1
[    4.424407] microcode: sig=0x206a7, pf=0x10, revision=0x23
[    4.426570] microcode: Microcode Update Driver: v2.2.
[    4.426576] initcall microcode_init+0x0/0x1fa returned 0 after 2256 usecs
[    4.430295] calling  hpet_insert_resource+0x0/0x1e @ 1
[    4.432031] initcall hpet_insert_resource+0x0/0x1e returned 0 after 2 usecs
[    4.434013] calling  update_mp_table+0x0/0x50a @ 1
[    4.435616] initcall update_mp_table+0x0/0x50a returned 0 after 0 usecs
[    4.437609] calling  lapic_insert_resource+0x0/0x3a @ 1
[    4.439340] initcall lapic_insert_resource+0x0/0x3a returned 0 after 1 usecs
[    4.441455] calling  print_ICs+0x0/0x198 @ 1
[    4.443059] initcall print_ICs+0x0/0x198 returned 0 after 0 usecs
[    4.444922] calling  pat_memtype_list_init+0x0/0x2d @ 1
[    4.446666] initcall pat_memtype_list_init+0x0/0x2d returned 0 after 16 usecs
[    4.448778] calling  create_tlb_single_page_flush_ceiling+0x0/0x24 @ 1
[    4.450770] initcall create_tlb_single_page_flush_ceiling+0x0/0x24 returned 0 after 11 usecs
[    4.453139] calling  create_init_pkru_value+0x0/0x24 @ 1
[    4.454883] initcall create_init_pkru_value+0x0/0x24 returned 0 after 12 usecs
[    4.457000] calling  pb_keys_init+0x0/0xa6 @ 1
[    4.458605] initcall pb_keys_init+0x0/0xa6 returned 0 after 0 usecs
[    4.460467] calling  init_oops_id+0x0/0x30 @ 1
[    4.462068] initcall init_oops_id+0x0/0x30 returned 0 after 0 usecs
[    4.463926] calling  sched_clock_init_late+0x0/0x73 @ 1
[    4.465665] sched_clock: Marking stable (4465659658, 0)->(4493466019, -27806361)
[    4.468002] initcall sched_clock_init_late+0x0/0x73 returned 0 after 2280 usecs
[    4.470121] calling  sched_init_debug+0x0/0x39 @ 1
[    4.471747] initcall sched_init_debug+0x0/0x39 returned 0 after 22 usecs
[    4.473734] calling  pm_qos_power_init+0x0/0xa8 @ 1
[    4.476045] initcall pm_qos_power_init+0x0/0xa8 returned 0 after 689 usecs
[    4.478034] calling  pm_debugfs_init+0x0/0x1f @ 1
[    4.479667] initcall pm_debugfs_init+0x0/0x1f returned 0 after 26 usecs
[    4.481660] calling  printk_late_init+0x0/0x11d @ 1
[    4.483263] initcall printk_late_init+0x0/0x11d returned 0 after 2 usecs
[    4.485250] calling  tk_debug_sleep_time_init+0x0/0x37 @ 1
[    4.486993] initcall tk_debug_sleep_time_init+0x0/0x37 returned 0 after 12 usecs
[    4.489108] calling  debugfs_kprobe_init+0x0/0xcd @ 1
[    4.490878] initcall debugfs_kprobe_init+0x0/0xcd returned 0 after 38 usecs
[    4.492869] calling  taskstats_init+0x0/0x32 @ 1
[    4.494501] registered taskstats version 1
[    4.495974] initcall taskstats_init+0x0/0x32 returned 0 after 1470 usecs
[    4.497963] calling  load_system_certificate_list+0x0/0xe7 @ 1
[    4.499815] Loading compiled-in X.509 certificates
[    4.501422] initcall load_system_certificate_list+0x0/0xe7 returned 0 after 1567 usecs
[    4.503658] calling  fault_around_debugfs+0x0/0x30 @ 1
[    4.505407] initcall fault_around_debugfs+0x0/0x30 returned 0 after 12 usecs
[    4.507518] calling  max_swapfiles_check+0x0/0x3 @ 1
[    4.509257] initcall max_swapfiles_check+0x0/0x3 returned 0 after 0 usecs
[    4.511238] calling  init_zswap+0x0/0x444 @ 1
[    4.513548] zswap: default zpool zbud not available
[    4.515157] zswap: pool creation failed
[    4.516908] initcall init_zswap+0x0/0x444 returned 0 after 3968 usecs
[    4.518881] calling  split_huge_pages_debugfs+0x0/0x30 @ 1
[    4.520620] initcall split_huge_pages_debugfs+0x0/0x30 returned 0 after 11 usecs
[    4.522720] calling  gup_benchmark_init+0x0/0x30 @ 1
[    4.524457] initcall gup_benchmark_init+0x0/0x30 returned 0 after 10 usecs
[    4.526426] calling  pageowner_init+0x0/0x41 @ 1
[    4.528021] page_owner is disabled
[    4.529356] initcall pageowner_init+0x0/0x41 returned 0 after 1301 usecs
[    4.531321] calling  check_early_ioremap_leak+0x0/0x34 @ 1
[    4.533042] initcall check_early_ioremap_leak+0x0/0x34 returned 0 after 0 usecs
[    4.535135] calling  cma_debugfs_init+0x0/0x1b9 @ 1
[    4.536743] initcall cma_debugfs_init+0x0/0x1b9 returned 0 after 11 usecs
[    4.538712] calling  init_percpu_stats_debugfs+0x0/0x1f @ 1
[    4.540454] initcall init_percpu_stats_debugfs+0x0/0x1f returned 0 after 13 usecs
[    4.542412] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.542549] calling  init_root_keyring+0x0/0x5 @ 1
[    4.542605] initcall init_root_keyring+0x0/0x5 returned 0 after 51 usecs
[    4.546051] ACPI BIOS Error (bug): 
[    4.547967] calling  big_key_init+0x0/0xaf @ 1
[    4.547991] Could not resolve [\_SB.PCI0.SAT0.PRT0._SDD.GTF0], AE_NOT_FOUND (20180531/psargs-330)
[    4.551245] Key type big_key registered
[    4.553421] ACPI Error: 
[    4.554886] initcall big_key_init+0x0/0xaf returned 0 after 5439 usecs
[    4.554889] Method parse/execution failed 
[    4.556105] calling  init_encrypted+0x0/0xc4 @ 1
[    4.558066] \_SB.PCI0.SAT0.PRT0._SDD
[    4.560646] Key type encrypted registered
[    4.561253] , AE_NOT_FOUND
[    4.562707] initcall init_encrypted+0x0/0xc4 returned 0 after 3101 usecs
[    4.564165]  (20180531/psparse-516)
[    4.564355] ACPI BIOS Error (bug): 
[    4.565373] calling  init_profile_hash+0x0/0x7a @ 1
[    4.567357] Could not resolve [\_SB.PCI0.SAT0.PRT0._GTF.GTF0], AE_NOT_FOUND
[    4.568676] initcall init_profile_hash+0x0/0x7a returned 0 after 0 usecs
[    4.568680] calling  integrity_fs_init+0x0/0x3a @ 1
[    4.570005]  (20180531/psargs-330)
[    4.571597] initcall integrity_fs_init+0x0/0x3a returned 0 after 16 usecs
[    4.573562] ACPI Error: 
[    4.575518] calling  init_ima+0x0/0x85 @ 1
[    4.577111] Method parse/execution failed 
[    4.578458] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    4.580394] \_SB.PCI0.SAT0.PRT0._GTF
[    4.581615] ima: Allocated hash algorithm: sha1
[    4.583040] , AE_NOT_FOUND
[    4.584614] initcall init_ima+0x0/0x85 returned 0 after 6036 usecs
[    4.586306]  (20180531/psparse-516)
[    4.587742] calling  init_evm+0x0/0x11f @ 1
[    4.589444] ata7.00: ATA-9: WDC WD10JPVX-60JC3T0, 01.01A01, max UDMA/133
[    4.590505] evm: Initialising EVM extended attributes:
[    4.592335] ata7.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.593955] ACPI BIOS Error (bug): 
[    4.595122] evm: security.SMACK64
[    4.597101] Could not resolve [\_SB.PCI0.SAT0.PRT0._SDD.GTF0], AE_NOT_FOUND
[    4.598765] evm: security.SMACK64EXEC
[    4.598767] evm: security.SMACK64TRANSMUTE
[    4.600724]  (20180531/psargs-330)
[    4.602028] evm: security.SMACK64MMAP
[    4.602030] evm: security.apparmor
[    4.603339] ACPI Error: 
[    4.605281] evm: security.ima
[    4.605282] evm: security.capability
[    4.606722] Method parse/execution failed 
[    4.608149] evm: HMAC attrs: 0x1
[    4.608211] initcall init_evm+0x0/0x11f returned 0 after 17290 usecs
[    4.609449] \_SB.PCI0.SAT0.PRT0._SDD
[    4.610870] calling  prandom_reseed+0x0/0x2a @ 1
[    4.612166] , AE_NOT_FOUND
[    4.615094] initcall prandom_reseed+0x0/0x2a returned 0 after 19 usecs
[    4.616365]  (20180531/psparse-516)
[    4.617767] calling  init_error_injection+0x0/0x6a @ 1
[    4.619340] ACPI BIOS Error (bug): 
[    4.623121] initcall init_error_injection+0x0/0x6a returned 0 after 2620 usecs
[    4.623760] Could not resolve [\_SB.PCI0.SAT0.PRT0._GTF.GTF0], AE_NOT_FOUND
[    4.625266] calling  pci_resource_alignment_sysfs_init+0x0/0x17 @ 1
[    4.626405]  (20180531/psargs-330)
[    4.628314] initcall pci_resource_alignment_sysfs_init+0x0/0x17 returned 0 after 10 usecs
[    4.629571] ACPI Error: 
[    4.631202] calling  pci_sysfs_init+0x0/0x4d @ 1
[    4.632471] Method parse/execution failed 
[    4.635718] initcall pci_sysfs_init+0x0/0x4d returned 0 after 1205 usecs
[    4.636378] \_SB.PCI0.SAT0.PRT0._GTF, AE_NOT_FOUND
[    4.638146] calling  bert_init+0x0/0x22c @ 1
[    4.639397]  (20180531/psparse-516)
[    4.641546] initcall bert_init+0x0/0x22c returned 0 after 1 usecs
[    4.642811] ata7.00: configured for UDMA/133
[    4.644197] calling  clk_debug_init+0x0/0x110 @ 1
[    4.644263] initcall clk_debug_init+0x0/0x110 returned 0 after 61 usecs
[    4.646042] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10JPVX-60J 1A01 PQ: 0 ANSI: 5
[    4.647471] calling  boot_wait_for_devices+0x0/0x24 @ 1
[    4.649720] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    4.650486] initcall boot_wait_for_devices+0x0/0x24 returned -19 after 0 usecs
[    4.651732] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    4.653488] calling  dmar_free_unused_resources+0x0/0xc8 @ 1
[    4.653493] initcall dmar_free_unused_resources+0x0/0xc8 returned 0 after 1 usecs
[    4.655004] sd 0:0:0:0: [sda] Write Protect is off
[    4.656487] calling  deferred_probe_initcall+0x0/0x30 @ 1
[    4.656527] initcall deferred_probe_initcall+0x0/0x30 returned 0 after 34 usecs
[    4.658378] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.660582] calling  genpd_debug_init+0x0/0x17f @ 1
[    4.662161] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.664167] initcall genpd_debug_init+0x0/0x17f returned 0 after 25 usecs
[    4.683904] calling  genpd_power_off_unused+0x0/0x7b @ 1
[    4.685554] initcall genpd_power_off_unused+0x0/0x7b returned 0 after 10 usecs
[    4.687561] calling  sync_debugfs_init+0x0/0x56 @ 1
[    4.689118] initcall sync_debugfs_init+0x0/0x56 returned 0 after 44 usecs
[    4.690998] calling  rtc_hctosys+0x0/0xfd @ 1
[    4.692501] hctosys: unable to open rtc device (rtc0)
[    4.694123] initcall rtc_hctosys+0x0/0xfd returned -19 after 1584 usecs
[    4.695999] calling  charger_manager_init+0x0/0xb0 @ 1
[    4.697875] initcall charger_manager_init+0x0/0xb0 returned 0 after 238 usecs
[    4.699882] calling  intel_scu_watchdog_init+0x0/0x2a1 @ 1
[    4.701533] initcall intel_scu_watchdog_init+0x0/0x2a1 returned -19 after 0 usecs
[    4.703539] calling  firmware_memmap_init+0x0/0x2e @ 1
[    4.705640] initcall firmware_memmap_init+0x0/0x2e returned 0 after 459 usecs
[    4.707648] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[    4.709410] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 0 usecs
[    4.711542] calling  efi_shutdown_init+0x0/0x37 @ 1
[    4.713055] initcall efi_shutdown_init+0x0/0x37 returned -19 after 0 usecs
[    4.714937] calling  pci_mmcfg_late_insert_resources+0x0/0x4c @ 1
[    4.716711] initcall pci_mmcfg_late_insert_resources+0x0/0x4c returned 0 after 3 usecs
[    4.718852] calling  sch_default_qdisc+0x0/0xc @ 1
[    4.720371] initcall sch_default_qdisc+0x0/0xc returned 0 after 1 usecs
[    4.722269] calling  tcp_congestion_default+0x0/0x13 @ 1
[    4.723912] initcall tcp_congestion_default+0x0/0x13 returned 0 after 1 usecs
[    4.725941] calling  ip_auto_config+0x0/0xf84 @ 1
[    4.727485] initcall ip_auto_config+0x0/0xf84 returned 0 after 25 usecs
[    4.729393] calling  software_resume+0x0/0x240 @ 1
[    4.803356]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
[    4.808154] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.812836] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[    4.825411] initcall software_resume+0x0/0x240 returned -22 after 92270 usecs
[    4.827461] calling  acpi_gpio_initial_sync+0x0/0x90 @ 1
[    4.829175] initcall acpi_gpio_initial_sync+0x0/0x90 returned 0 after 30 usecs
[    4.831204] calling  fb_logo_late_init+0x0/0xa @ 1
[    4.832737] initcall fb_logo_late_init+0x0/0xa returned 0 after 0 usecs
[    4.834649] calling  clk_disable_unused+0x0/0x170 @ 1
[    4.836326] initcall clk_disable_unused+0x0/0x170 returned 0 after 14 usecs
[    4.837558] sd 0:0:0:0: [sda] Stopping disk
[    4.838233] calling  regulator_init_complete+0x0/0x59 @ 1
[    4.838241] initcall regulator_init_complete+0x0/0x59 returned 0 after 4 usecs
[    5.404668] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    5.406896] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    5.408599] sd 0:0:0:0: [sda] Write Protect is off
[    5.410130] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.411812] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.720447] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.724896] ata9.00: ATAPI: MATSHITADVD-RAM UJ8A2ES, 1.20, max UDMA/100
[    5.729340] ata9.00: configured for UDMA/100
[    5.734887] scsi 2:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ8A2ES  1.20 PQ: 0 ANSI: 5
[    6.104494] ata10: SATA link down (SStatus 0 SControl 300)
[    6.237654]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
[    6.241205] WARNING: CPU: 2 PID: 141 at ../block/blk.h:62 blk_register_queue+0x93/0x200
[    6.243391] Modules linked in:
[    6.244702] CPU: 2 PID: 141 Comm: kworker/u16:7 Tainted: G        W         4.18.9 #2
[    6.246898] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[    6.249101] Workqueue: events_unbound async_run_entry_fn
[    6.250805] RIP: 0010:blk_register_queue+0x93/0x200
[    6.252380] Code: 03 00 00 85 c0 74 25 8b 15 fa 4e 98 01 85 d2 74 1b 48 8b 83 e0 02 00 00 be ff ff ff ff 48 8d 78 18 e8 31 be d2 ff 85 c0 75 02 <0f> 0b 48 0f ba ab 88 02 00 00 1a 48 8b 83 88 02 00 00 a9 00 00 02 
[    6.257528] RSP: 0000:ffffb97580787d68 EFLAGS: 00010246
[    6.259262] RAX: 0000000000000000 RBX: ffff8dd4087851c0 RCX: 0000000000000003
[    6.261376] RDX: 0000000000000000 RSI: ffff8dd408785470 RDI: 0000000000000246
[    6.263493] RBP: ffff8dd4087e41e8 R08: 0000000000000001 R09: 0000000000000001
[    6.265620] R10: ffffb97580787c78 R11: 0000000000000000 R12: ffff8dd4087e4138
[    6.267738] R13: ffff8dd3c781ad40 R14: ffff8dd4087e4144 R15: ffff8dd4087e41d8
[    6.269855] FS:  0000000000000000(0000) GS:ffff8dd409c00000(0000) knlGS:0000000000000000
[    6.272105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.273975] CR2: ffffb97580790000 CR3: 0000000045224001 CR4: 00000000000606e0
[    6.276098] Call Trace:
[    6.277343]  __device_add_disk+0x393/0x480
[    6.278839]  sd_probe_async+0xe9/0x200
[    6.280323]  async_run_entry_fn+0x6c/0x150
[    6.281807]  process_one_work+0x228/0x400
[    6.283286]  ? process_one_work+0x1bf/0x400
[    6.284774]  worker_thread+0x207/0x380
[    6.286247]  ? process_one_work+0x400/0x400
[    6.287716]  kthread+0x11b/0x130
[    6.289068]  ? kthread_create_worker_on_cpu+0x70/0x70
[    6.290791]  ret_from_fork+0x35/0x40
[    6.292265] ---[ end trace c233452dde376be3 ]---
[    6.294420] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.347107] _warn_unseeded_randomness: 9 callbacks suppressed
[    6.347113] random: get_random_u64 called from __kmem_cache_create+0x41/0x580 with crng_init=0
[    6.351323] random: get_random_u64 called from cache_random_seq_create+0x60/0x150 with crng_init=0
[    6.357446] EXT4-fs (sda8): mounted filesystem with ordered data mode. Opts: (null)
[    6.359582] VFS: Mounted root (ext4 filesystem) readonly on device 8:8.
[    6.392761] devtmpfs: mounted
[    6.423169] integrity: Unable to open file: /etc/keys/x509_ima.der (-2)
[    6.423196] integrity: Unable to open file: /etc/keys/x509_evm.der (-2)
[    6.427055] Freeing unused kernel image memory: 3964K
[    6.444258] Write protecting the kernel read-only data: 16384k
[    6.447505] Freeing unused kernel image memory: 2028K
[    6.449516] Freeing unused kernel image memory: 216K
[    6.460236] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.462198] x86/mm: Checking user space page tables
[    6.472512] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.474469] rodata_test: all tests were successful
[    6.627534] random: get_random_u64 called from arch_rnd+0x19/0x40 with crng_init=0
[    7.395441] random: fast init done
[    7.640474] _warn_unseeded_randomness: 8 callbacks suppressed
[    7.640480] random: get_random_u64 called from copy_process+0x2be/0x1da0 with crng_init=1
[    7.724030] systemd[1]: RTC configured in localtime, applying delta of -420 minutes to system time.
[    7.941013] LoadPin: kernel-module old-api-denied obj=<unknown> pid=1 cmdline="/sbin/init showopts"
[    7.943400] systemd[1]: Failed to insert module 'autofs4': Operation not permitted
[    7.972669] LoadPin: kernel-module old-api-denied obj=<unknown> pid=1 cmdline="/sbin/init showopts"
[    7.975062] systemd[1]: Failed to insert module 'ipv6': Operation not permitted
[    8.029159] LoadPin: kernel-module old-api-denied obj=<unknown> pid=1 cmdline="/sbin/init showopts"
[    8.031553] systemd[1]: Failed to insert module 'unix': Operation not permitted
[    8.109178] systemd[1]: Mounting cgroup to /sys/fs/cgroup/net_cls,net_prio of type cgroup with options net_cls,net_prio.
[    8.112474] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpuset of type cgroup with options cpuset.
[    8.115767] systemd[1]: Mounting cgroup to /sys/fs/cgroup/perf_event of type cgroup with options perf_event.
[    8.118772] systemd[1]: Mounting cgroup to /sys/fs/cgroup/rdma of type cgroup with options rdma.
[    8.121513] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpu,cpuacct of type cgroup with options cpu,cpuacct.
[    8.124784] systemd[1]: Mounting cgroup to /sys/fs/cgroup/blkio of type cgroup with options blkio.
[    8.127790] systemd[1]: Mounting cgroup to /sys/fs/cgroup/devices of type cgroup with options devices.
[    8.130675] systemd[1]: Mounting cgroup to /sys/fs/cgroup/memory of type cgroup with options memory.
[    8.135317] systemd[1]: Mounting cgroup to /sys/fs/cgroup/hugetlb of type cgroup with options hugetlb.
[    8.138211] systemd[1]: Mounting cgroup to /sys/fs/cgroup/pids of type cgroup with options pids.
[    8.177538] random: get_random_u32 called from bucket_table_alloc+0x132/0x170 with crng_init=1
[    8.177595] random: get_random_u32 called from new_slab+0x273/0x6c0 with crng_init=1
[    8.270891] systemd-gpt-auto-generator[170]: /dev/sda8: root device /dev/sda.
[    8.272544] systemd-fstab-generator[168]: Parsing /etc/fstab
[    8.306192] nfs-server-gene (165) used greatest stack depth: 13304 bytes left
[    8.326399] systemd-fstab-generator[168]: Found entry what=/dev/sda8 where=/ type=ext4 nofail=no noauto=no
[    8.386406] systemd-sysv-generator[175]: Cannot find unit xfs.service.
[    8.390714] systemd-sysv-generator[175]: Loading SysV script /etc/init.d/xfs
[    8.439335] systemd-fstab-generator[168]: Found entry what=/dev/sda9 where=/home type=ext4 nofail=no noauto=no
[    8.442348] systemd-fstab-generator[168]: Found entry what=/dev/sda7 where=swap type=swap nofail=no noauto=no
[    8.455960] systemd-fstab-generator[168]: Found entry what=/dev/sda6 where=/tester type=btrfs nofail=yes noauto=no
[    8.514373] systemd-fstab-generator[168]: Found entry what=/dev/sda5 where=/xfer type=vfat nofail=yes noauto=no
[    8.800254] systemd-gpt-auto-generator[170]: No suitable partition table found, ignoring.
[    8.831663] _warn_unseeded_randomness: 75 callbacks suppressed
[    8.831668] random: get_random_u32 called from bpf_jit_binary_alloc+0x4f/0x90 with crng_init=1
[    8.868628] random: get_random_u32 called from new_slab+0x273/0x6c0 with crng_init=1
[   10.219926] random: get_random_u64 called from copy_process+0x2be/0x1da0 with crng_init=1
[   10.239025] random: get_random_u32 called from bucket_table_alloc+0x132/0x170 with crng_init=1
[   10.239965] random: get_random_u32 called from new_slab+0x273/0x6c0 with crng_init=1
[   10.247609] Core dump to |/bin/false pipe failed
[   10.250724] systemd: 153 output lines suppressed due to ratelimiting
[   46.044153] random: get_random_bytes called from __prandom_timer+0x23/0xa0 with crng_init=1
[  238.785032] random: crng init done


