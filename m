Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA688C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFB420874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFB420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeGVIhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:37:45 -0400
Received: from www17.your-server.de ([213.133.104.17]:59032 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeGVIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:37:45 -0400
X-Greylist: delayed 1344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2018 04:37:41 EDT
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1fh8eV-0002Zz-H1
        for linux-kernel@vger.kernel.org; Sun, 22 Jul 2018 09:19:35 +0200
Received: from [95.222.29.58] (helo=maria)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1fh8eV-000VL6-Am
        for linux-kernel@vger.kernel.org; Sun, 22 Jul 2018 09:19:35 +0200
Date:   Sun, 22 Jul 2018 09:19:03 +0200
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-kernel@vger.kernel.org
Subject: sky2: no irq handler on v4.17.6
Message-ID: <20180722070653.GA2687@maria>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24771/Sun Jul 22 02:41:52 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I currently use my old i386 laptop with kernel v4.14.55 where my sky2
ethernet driver works correctly.

I tried to upgrade to v4.17.6 but the sky2 driver fails with "No irq
handler for vector".

any ideas?

dmesg:

[    0.000000] Linux version 4.17.6+ (thomas@computer) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #2 SMP Sat Jul 21 09:14:49 CEST 2018
[    0.000000] Disabled fast string operations
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007f0c7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f0c8000-0x000000007f2c8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007f2c9000-0x000000007fe4afff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fe4b000-0x000000007fe6efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007fe6f000-0x000000007fe7efff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fe7f000-0x000000007feaafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007feab000-0x000000007feb1fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007feb2000-0x000000007feb6fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007feb7000-0x000000007feb8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007feb9000-0x000000007feeefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007feef000-0x000000007fefefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007feff000-0x000000007fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffb0000-0x00000000fffdffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] e820: update [mem 0x7c2a9010-0x7c2b8a3b] usable ==> usable
[    0.000000] e820: update [mem 0x7c2a9010-0x7c2b8a3b] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000007c2a900f] usable
[    0.000000] reserve setup_data: [mem 0x000000007c2a9010-0x000000007c2b8a3b] usable
[    0.000000] reserve setup_data: [mem 0x000000007c2b8a3c-0x000000007f0c7fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f0c8000-0x000000007f2c8fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007f2c9000-0x000000007fe4afff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fe4b000-0x000000007fe6efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007fe6f000-0x000000007fe7efff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fe7f000-0x000000007feaafff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007feab000-0x000000007feb1fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007feb2000-0x000000007feb6fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007feb7000-0x000000007feb8fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007feb9000-0x000000007feeefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007feef000-0x000000007fefefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007feff000-0x000000007fefffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fffb0000-0x00000000fffdffff] reserved
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi:  ACPI=0x7fefd000  ACPI 2.0=0x7fefd014  SMBIOS=0x7feba000 
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x7feb9 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFE00000 mask FFFE00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 07FF00000 mask FFFF00000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x053fffff]
[    0.000000] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.000000] BRK [0x04fcd000, 0x04fcdfff] PGTABLE
[    0.000000] Secure boot disabled
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007FEFD014 000024 (v02 APPLE )
[    0.000000] ACPI: XSDT 0x000000007FEFD120 000074 (v01 APPLE  Apple00  00000055      01000013)
[    0.000000] ACPI: FACP 0x000000007FEFB000 0000F4 (v03 APPLE  Apple00  00000055 Loki 0000005F)
[    0.000000] ACPI: DSDT 0x000000007FEF0000 0048C0 (v01 APPLE  MacBookP 00010001 INTL 20050309)
[    0.000000] ACPI: FACS 0x000000007FEBB000 000040
[    0.000000] ACPI: FACS 0x000000007FEBB000 000040
[    0.000000] ACPI: HPET 0x000000007FEFA000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: APIC 0x000000007FEF9000 000068 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: MCFG 0x000000007FEF8000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: ASF! 0x000000007FEF7000 00009C (v32 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: SBST 0x000000007FEF6000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: ECDT 0x000000007FEF5000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: SSDT 0x000000007FEB6000 00064F (v01 APPLE  SataPri  00001000 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000007FEB5000 00069C (v01 APPLE  SataSec  00001000 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000007FEEF000 0004DC (v01 APPLE  CpuPm    00003000 INTL 20050309)
[    0.000000] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 1158MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] BRK [0x04fce000, 0x04fcefff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000007feb8fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.000000]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007f0c7fff]
[    0.000000]   node   0: [mem 0x000000007f2c9000-0x000000007fe4afff]
[    0.000000]   node   0: [mem 0x000000007fe6f000-0x000000007fe7efff]
[    0.000000]   node   0: [mem 0x000000007feab000-0x000000007feb1fff]
[    0.000000]   node   0: [mem 0x000000007feb7000-0x000000007feb8fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007feb8fff]
[    0.000000] On node 0 totalpages: 523265
[    0.000000]   DMA zone: 40 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 2180 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 296037 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 1023 pages
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] e820: [mem 0x7ff00000-0xe00f7fff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x82/0x3fe with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 28 pages/cpu @(ptrval) s83468 r0 d31220 u114688
[    0.000000] pcpu-alloc: s83468 r0 d31220 u114688 alloc=28*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 521045
[    0.000000] Kernel command line: selinux=0 threadirqs 
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:0007feb9)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 2036436K/2093060K available (4986K kernel code, 281K rwdata, 1440K rodata, 656K init, 460K bss, 56624K reserved, 0K cma-reserved, 1157096K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xfff90000 - 0xfffff000   ( 444 kB)
                 cpu_entry : 0xffc00000 - 0xffc4f000   ( 316 kB)
                   pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
                   vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
                     .init : 0xc4e9a000 - 0xc4f3e000   ( 656 kB)
                     .data : 0xc4cdebd8 - 0xc4e90640   (1734 kB)
                     .text : 0xc4800000 - 0xc4cdebd8   (4986 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
[    0.000000] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180313
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.005000] tsc: Fast TSC calibration using PIT
[    0.006000] tsc: Detected 1830.877 MHz processor
[    0.006000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1a6419fa689, max_idle_ns: 440795246923 ns
[    0.006000] Calibrating delay loop (skipped), value calculated using timer frequency.. 3661.75 BogoMIPS (lpj=1830877)
[    0.006000] pid_max: default: 32768 minimum: 301
[    0.020141] Security Framework initialized
[    0.020152] SELinux:  Disabled at boot.
[    0.020203] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.020221] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.020747] Disabled fast string operations
[    0.020761] CPU: Physical Processor ID: 0
[    0.020768] CPU: Processor Core ID: 0
[    0.020785] mce: CPU supports 6 MCE banks
[    0.020801] CPU0: Thermal monitoring enabled (TM2)
[    0.020815] process: using mwait in idle threads
[    0.020832] Last level iTLB entries: 4KB 128, 2MB 0, 4MB 2
[    0.020840] Last level dTLB entries: 4KB 128, 2MB 0, 4MB 8, 1GB 0
[    0.020850] Spectre V2 : Mitigation: Full generic retpoline
[    0.020858] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.021071] Freeing SMP alternatives memory: 24K
[    0.023000] smpboot: CPU0: Genuine Intel(R) CPU           T2400  @ 1.83GHz (family: 0x6, model: 0xe, stepping: 0x8)
[    0.023000] Performance Events: Core events, core PMU driver.
[    0.023000] ... version:                1
[    0.023000] ... bit width:              40
[    0.023000] ... generic registers:      2
[    0.023000] ... value mask:             000000ffffffffff
[    0.023000] ... max period:             000000007fffffff
[    0.023000] ... fixed-purpose events:   0
[    0.023000] ... event mask:             0000000000000003
[    0.023000] Hierarchical SRCU implementation.
[    0.023000] smp: Bringing up secondary CPUs ...
[    0.023000] CPU 1 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.023000] x86: Booting SMP configuration:
[    0.023000] .... node  #0, CPUs:      #1
[    0.001000] Initializing CPU#1
[    0.001000] Disabled fast string operations
[    0.024074] smp: Brought up 1 node, 2 CPUs
[    0.024074] smpboot: Max logical packages: 1
[    0.024074] smpboot: Total of 2 processors activated (7323.50 BogoMIPS)
[    0.026032] devtmpfs: initialized
[    0.026460] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.026460] PM: Registering ACPI NVS region [mem 0x7f0c8000-0x7f2c8fff] (2101248 bytes)
[    0.026460] PM: Registering ACPI NVS region [mem 0x7feb9000-0x7feeefff] (221184 bytes)
[    0.027070] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.027090] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.027439] NET: Registered protocol family 16
[    0.027707] audit: initializing netlink subsys (disabled)
[    0.027791] audit: type=2000 audit(1532158059.027:1): state=initialized audit_enabled=0 res=1
[    0.028319] cpuidle: using governor menu
[    0.028430] ACPI: bus type PCI registered
[    0.028556] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.028604] PCI: not using MMCONFIG
[    0.043014] PCI: Using configuration type 1 for base access
[    0.050107] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    0.050221] ACPI: Disabled all _OSI OS vendors
[    0.050232] ACPI: Added _OSI(Module Device)
[    0.050241] ACPI: Added _OSI(Processor Device)
[    0.050249] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.050258] ACPI: Added _OSI(Processor Aggregator Device)
[    0.050268] ACPI: Added _OSI(Linux-Dell-Video)
[    0.050276] ACPI: Added _OSI(Darwin)
[    0.050296] ACPI: EC: EC started
[    0.050303] ACPI: EC: interrupt blocked
[    0.050341] ACPI: \: Used as first EC
[    0.050351] ACPI: \: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.050361] ACPI: \: Used as boot ECDT EC to handle transactions
[    0.055892] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.057592] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.061447] ACPI: Dynamic OEM Table Load:
[    0.061472] ACPI: SSDT 0x00000000F5C97800 00022A (v01 APPLE  Cpu0Ist  00003000 INTL 20050309)
[    0.062037] ACPI: Dynamic OEM Table Load:
[    0.062065] ACPI: SSDT 0x00000000F5C97C00 0002C3 (v01 APPLE  Cpu0Cst  00003001 INTL 20050309)
[    0.062889] ACPI: Dynamic OEM Table Load:
[    0.062909] ACPI: SSDT 0x00000000F5C419C0 000087 (v01 APPLE  Cpu1Ist  00003000 INTL 20050309)
[    0.063247] ACPI: Dynamic OEM Table Load:
[    0.063267] ACPI: SSDT 0x00000000F5C41840 000085 (v01 APPLE  Cpu1Cst  00003000 INTL 20050309)
[    0.063873] ACPI: Interpreter enabled
[    0.063949] ACPI: (supports S0 S3 S4 S5)
[    0.063958] ACPI: Using IOAPIC for interrupt routing
[    0.064056] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.064664] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.064678] PCI: Using MMCONFIG for extended config space
[    0.064700] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.065167] ACPI: Enabled 12 GPEs in block 00 to 1F
[    0.079643] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.079663] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability]
[    0.079998] acpi PNP0A08:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.080012] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.080016] acpi PNP0A08:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.080021] acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.080025] acpi PNP0A08:00: host bridge window [mem 0x000c0000-0x000c3fff window] (ignored)
[    0.080029] acpi PNP0A08:00: host bridge window [mem 0x000c4000-0x000c7fff window] (ignored)
[    0.080033] acpi PNP0A08:00: host bridge window [mem 0x000c8000-0x000cbfff window] (ignored)
[    0.080038] acpi PNP0A08:00: host bridge window [mem 0x000cc000-0x000cffff window] (ignored)
[    0.080042] acpi PNP0A08:00: host bridge window [mem 0x000d0000-0x000d3fff window] (ignored)
[    0.080046] acpi PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff window] (ignored)
[    0.080050] acpi PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff window] (ignored)
[    0.080055] acpi PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff window] (ignored)
[    0.080059] acpi PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff window] (ignored)
[    0.080063] acpi PNP0A08:00: host bridge window [mem 0x000e4000-0x000e7fff window] (ignored)
[    0.080067] acpi PNP0A08:00: host bridge window [mem 0x000e8000-0x000ebfff window] (ignored)
[    0.080072] acpi PNP0A08:00: host bridge window [mem 0x000ec000-0x000effff window] (ignored)
[    0.080076] acpi PNP0A08:00: host bridge window [mem 0x000f0000-0x000fffff window] (ignored)
[    0.080080] acpi PNP0A08:00: host bridge window [mem 0x80000000-0xfebfffff window] (ignored)
[    0.080083] PCI: root bus 00: using default resources
[    0.080170] PCI host bridge to bus 0000:00
[    0.080183] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.080195] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.080207] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.080233] pci 0000:00:00.0: [8086:27a0] type 00 class 0x060000
[    0.080471] pci 0000:00:01.0: [8086:27a1] type 01 class 0x060400
[    0.080554] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.080773] pci 0000:00:07.0: [8086:27a3] type 00 class 0x110100
[    0.080793] pci 0000:00:07.0: reg 0x10: [mem 0x90304000-0x90304fff]
[    0.081075] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300
[    0.081114] pci 0000:00:1b.0: reg 0x10: [mem 0x90300000-0x90303fff 64bit]
[    0.081234] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.081452] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400
[    0.081601] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.081829] pci 0000:00:1c.2: [8086:27d4] type 01 class 0x060400
[    0.081968] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.082212] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300
[    0.082285] pci 0000:00:1d.0: reg 0x20: [io  0x40a0-0x40bf]
[    0.082513] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300
[    0.082586] pci 0000:00:1d.1: reg 0x20: [io  0x4080-0x409f]
[    0.082819] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300
[    0.082892] pci 0000:00:1d.2: reg 0x20: [io  0x4060-0x407f]
[    0.083142] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300
[    0.083215] pci 0000:00:1d.3: reg 0x20: [io  0x4040-0x405f]
[    0.083449] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320
[    0.083481] pci 0000:00:1d.7: reg 0x10: [mem 0x90305400-0x903057ff]
[    0.083585] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.083785] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.084080] pci 0000:00:1f.0: [8086:27b9] type 00 class 0x060100
[    0.084222] pci 0000:00:1f.0: quirk: [io  0x0400-0x047f] claimed by ICH6 ACPI/GPIO/TCO
[    0.084243] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
[    0.084257] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 000f)
[    0.084272] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 1640 (mask 000f)
[    0.084288] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700 (mask 0003)
[    0.084303] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0300 (mask 001f)
[    0.084538] pci 0000:00:1f.1: [8086:27df] type 00 class 0x01018f
[    0.084567] pci 0000:00:1f.1: reg 0x10: [io  0x40e8-0x40ef]
[    0.084583] pci 0000:00:1f.1: reg 0x14: [io  0x40fc-0x40ff]
[    0.084598] pci 0000:00:1f.1: reg 0x18: [io  0x40e0-0x40e7]
[    0.084613] pci 0000:00:1f.1: reg 0x1c: [io  0x40f8-0x40fb]
[    0.084629] pci 0000:00:1f.1: reg 0x20: [io  0x40c0-0x40cf]
[    0.084860] pci 0000:00:1f.2: [8086:27c5] type 00 class 0x010601
[    0.084894] pci 0000:00:1f.2: reg 0x10: [io  0x40d8-0x40df]
[    0.084909] pci 0000:00:1f.2: reg 0x14: [io  0x40f4-0x40f7]
[    0.084924] pci 0000:00:1f.2: reg 0x18: [io  0x40d0-0x40d7]
[    0.084939] pci 0000:00:1f.2: reg 0x1c: [io  0x40f0-0x40f3]
[    0.084954] pci 0000:00:1f.2: reg 0x20: [io  0x4020-0x402f]
[    0.084970] pci 0000:00:1f.2: reg 0x24: [mem 0x90305000-0x903053ff]
[    0.085050] pci 0000:00:1f.2: PME# supported from D3hot
[    0.085257] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500
[    0.085349] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.085683] pci 0000:01:00.0: [1002:71c5] type 00 class 0x030000
[    0.085766] pci 0000:01:00.0: reg 0x10: [mem 0x80000000-0x87ffffff pref]
[    0.085805] pci 0000:01:00.0: reg 0x14: [io  0x3000-0x30ff]
[    0.085838] pci 0000:01:00.0: reg 0x18: [mem 0x90200000-0x9020ffff]
[    0.085978] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.086012] pci 0000:01:00.0: enabling Extended Tags
[    0.086221] pci 0000:01:00.0: supports D1 D2
[    0.086371] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.086406] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.086418] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.086424] pci 0000:00:01.0:   bridge window [mem 0x90200000-0x902fffff]
[    0.086432] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x87ffffff 64bit pref]
[    0.086557] pci 0000:02:00.0: [11ab:4362] type 00 class 0x020000
[    0.086610] pci 0000:02:00.0: reg 0x10: [mem 0x90100000-0x90103fff 64bit]
[    0.086630] pci 0000:02:00.0: reg 0x18: [io  0x2000-0x20ff]
[    0.086698] pci 0000:02:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.086822] pci 0000:02:00.0: supports D1 D2
[    0.086827] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.086987] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.087029] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.087044] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.087051] pci 0000:00:1c.0:   bridge window [mem 0x90100000-0x901fffff]
[    0.087150] pci 0000:00:1c.2: PCI bridge to [bus 03-0a]
[    0.087165] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    0.087172] pci 0000:00:1c.2:   bridge window [mem 0x8c100000-0x900fffff]
[    0.087183] pci 0000:00:1c.2:   bridge window [mem 0x88000000-0x8bffffff 64bit pref]
[    0.087276] pci 0000:0b:03.0: [11c1:5811] type 00 class 0x0c0010
[    0.087311] pci 0000:0b:03.0: reg 0x10: [mem 0x8c000000-0x8c000fff]
[    0.087436] pci 0000:0b:03.0: supports D1 D2
[    0.087440] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot
[    0.087626] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.087646] pci 0000:00:1e.0:   bridge window [mem 0x8c000000-0x8c0fffff]
[    0.087657] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.087661] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
[    0.087696] pci_bus 0000:00: on NUMA node 0
[    0.088025] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.088185] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.088339] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.088492] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.088661] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.088816] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.088969] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.089143] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.090153] ACPI: EC: interrupt unblocked
[    0.090187] ACPI: EC: event unblocked
[    0.090206] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.090219] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
[    0.090368] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.090368] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.090368] pci 0000:01:00.0: vgaarb: setting as boot device (VGA legacy resources not available)
[    0.090368] vgaarb: loaded
[    0.090386] SCSI subsystem initialized
[    0.090513] libata version 3.00 loaded.
[    0.090535] ACPI: bus type USB registered
[    0.091042] usbcore: registered new interface driver usbfs
[    0.091081] usbcore: registered new interface driver hub
[    0.091134] usbcore: registered new device driver usb
[    0.091208] pps_core: LinuxPPS API ver. 1 registered
[    0.091217] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.091284] Registered efivars operations
[    0.104781] PCI: Using ACPI for IRQ routing
[    0.116934] PCI: pci_cache_line_size set to 64 bytes
[    0.117021] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.117025] e820: reserve RAM buffer [mem 0x7c2a9010-0x7fffffff]
[    0.117029] e820: reserve RAM buffer [mem 0x7f0c8000-0x7fffffff]
[    0.117034] e820: reserve RAM buffer [mem 0x7fe4b000-0x7fffffff]
[    0.117037] e820: reserve RAM buffer [mem 0x7fe7f000-0x7fffffff]
[    0.117041] e820: reserve RAM buffer [mem 0x7feb2000-0x7fffffff]
[    0.117045] e820: reserve RAM buffer [mem 0x7feb9000-0x7fffffff]
[    0.117415] NetLabel: Initializing
[    0.117425] NetLabel:  domain hash size = 128
[    0.117432] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.117475] NetLabel:  unlabeled traffic allowed by default
[    0.118102] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.118119] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.118135] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.120044] clocksource: Switched to clocksource tsc-early
[    0.120140] VFS: Disk quotas dquot_6.6.0
[    0.120183] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.120328] pnp: PnP ACPI init
[    0.120519] system 00:00: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.120533] system 00:00: [mem 0xfed14000-0xfed17fff] has been reserved
[    0.120545] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.120557] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.120569] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.120578] system 00:00: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.120607] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.121140] pnp 00:01: Plug and Play ACPI device, IDs IFX0101 (active)
[    0.121377] system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.121408] system 00:02: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    0.121493] pnp 00:03: disabling [io  0x1640-0x164f] because it overlaps 0000:00:1c.2 BAR 7 [io  0x1000-0x1fff]
[    0.121635] system 00:03: [io  0x0680-0x06ef] has been reserved
[    0.121648] system 00:03: [io  0x0800-0x080f] has been reserved
[    0.121660] system 00:03: [io  0x0810-0x0817] has been reserved
[    0.121671] system 00:03: [io  0x0400-0x047f] has been reserved
[    0.121683] system 00:03: [io  0x0500-0x053f] has been reserved
[    0.121708] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.121774] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.121875] pnp: PnP ACPI: found 5 devices
[    0.162051] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.162091] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    0.162113] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    0.162152] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.162189] pci 0000:00:1c.0: BAR 9: assigned [mem 0x90400000-0x905fffff 64bit pref]
[    0.162206] pci 0000:01:00.0: BAR 6: assigned [mem 0x90220000-0x9023ffff pref]
[    0.162220] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.162232] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.162245] pci 0000:00:01.0:   bridge window [mem 0x90200000-0x902fffff]
[    0.162258] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x87ffffff 64bit pref]
[    0.162277] pci 0000:02:00.0: BAR 6: assigned [mem 0x90120000-0x9013ffff pref]
[    0.162290] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.162301] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.162317] pci 0000:00:1c.0:   bridge window [mem 0x90100000-0x901fffff]
[    0.162331] pci 0000:00:1c.0:   bridge window [mem 0x90400000-0x905fffff 64bit pref]
[    0.162351] pci 0000:00:1c.2: PCI bridge to [bus 03-0a]
[    0.162363] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    0.162378] pci 0000:00:1c.2:   bridge window [mem 0x8c100000-0x900fffff]
[    0.162392] pci 0000:00:1c.2:   bridge window [mem 0x88000000-0x8bffffff 64bit pref]
[    0.162413] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    0.162428] pci 0000:00:1e.0:   bridge window [mem 0x8c000000-0x8c0fffff]
[    0.162450] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.162454] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.162459] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    0.162464] pci_bus 0000:01: resource 1 [mem 0x90200000-0x902fffff]
[    0.162468] pci_bus 0000:01: resource 2 [mem 0x80000000-0x87ffffff 64bit pref]
[    0.162473] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    0.162477] pci_bus 0000:02: resource 1 [mem 0x90100000-0x901fffff]
[    0.162482] pci_bus 0000:02: resource 2 [mem 0x90400000-0x905fffff 64bit pref]
[    0.162486] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    0.162490] pci_bus 0000:03: resource 1 [mem 0x8c100000-0x900fffff]
[    0.162495] pci_bus 0000:03: resource 2 [mem 0x88000000-0x8bffffff 64bit pref]
[    0.162500] pci_bus 0000:0b: resource 1 [mem 0x8c000000-0x8c0fffff]
[    0.162504] pci_bus 0000:0b: resource 4 [io  0x0000-0xffff]
[    0.162508] pci_bus 0000:0b: resource 5 [mem 0x00000000-0xffffffff]
[    0.162780] NET: Registered protocol family 2
[    0.163141] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
[    0.163166] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.163221] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.163306] TCP: Hash tables configured (established 8192 bind 8192)
[    0.163382] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.163407] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.165772] pci 0000:00:1d.7: enabling device (0000 -> 0002)
[    0.166342] PCI: CLS mismatch (256 != 64), using 64 bytes
[    0.168000] Scanning for low memory corruption every 60 seconds
[    0.168062] efifb: dmi detected MacBookPro1,1 - framebuffer at 0x80010000 (1440x900, stride 5888)
[    0.168075] sysfb: VRAM smaller than advertised
[    0.169101] Initialise system trusted keyrings
[    0.169203] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    0.176984] Key type asymmetric registered
[    0.177000] Asymmetric key parser 'x509' registered
[    0.177036] bounce: pool size: 64 pages
[    0.177084] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.177100] io scheduler noop registered
[    0.177247] io scheduler cfq registered (default)
[    0.178451] pcieport 0000:00:1c.2: enabling device (0000 -> 0003)
[    0.179158] efifb: probing for efifb
[    0.179202] efifb: framebuffer at 0x80010000, using 5176k, total 5175k
[    0.179213] efifb: mode is 1440x900x32, linelength=5888, pages=1
[    0.179221] efifb: scrolling: redraw
[    0.179231] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.283022] Console: switching to colour frame buffer device 180x56
[    0.386814] fb0: EFI VGA frame buffer device
[    0.387404] intel_idle: does not run on family 6 model 14
[    0.387618] ACPI: AC Adapter [ADP1] (on-line)
[    0.388407] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.389476] ACPI: Lid Switch [LID0]
[    0.390007] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.391029] ACPI: Power Button [PWRB]
[    0.391590] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.392609] ACPI: Sleep Button [SLPB]
[    0.393206] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.394094] ACPI: Power Button [PWRF]
[    0.394980] Monitor-Mwait will be used to enter C-1 state
[    0.395004] Monitor-Mwait will be used to enter C-2 state
[    0.395034] Monitor-Mwait will be used to enter C-3 state
[    0.395053] Monitor-Mwait will be used to enter C-4 state
[    0.395065] tsc: Marking TSC unstable due to TSC halts in idle
[    0.395880] clocksource: Switched to clocksource hpet
[    0.401472] loop: module loaded
[    0.401979] ahci 0000:00:1f.2: version 3.0
[    0.401992] ahci 0000:00:1f.2: enabling device (0005 -> 0007)
[    0.403226] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.404068] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x4 impl SATA mode
[    0.405061] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pio slum part 
[    0.407224] scsi host0: ahci
[    0.407999] scsi host1: ahci
[    0.408718] scsi host2: ahci
[    0.409412] scsi host3: ahci
[    0.409966] ata1: DUMMY
[    0.410283] ata2: DUMMY
[    0.410576] ata3: SATA max UDMA/133 abar m1024@0x90305000 port 0x90305200 irq 26
[    0.411472] ata4: DUMMY
[    0.412072] i8042: PNP: No PS/2 controller found.
[    0.413218] hidraw: raw HID events driver (C) Jiri Kosina
[    0.414862] microcode: sig=0x6e8, pf=0x20, revision=0x39
[    0.415650] microcode: Microcode Update Driver: v2.2.
[    0.415664] Using IPI No-Shortcut mode
[    0.417168] registered taskstats version 1
[    0.447232] Loading compiled-in X.509 certificates
[    0.718431] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    0.760590] ata3.00: ATA-9: INTEL SSDSC2CT240A4, 335s, max UDMA/133
[    0.790781] ata3.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.833203] ata3.00: configured for UDMA/133
[    0.863375] scsi 2:0:0:0: Direct-Access     ATA      INTEL SSDSC2CT24 335s PQ: 0 ANSI: 5
[    0.894260] sd 2:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
[    0.925235] sd 2:0:0:0: [sda] Write Protect is off
[    0.951030] random: fast init done
[    0.955844] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.985867] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.020867]  sda: sda1 sda2 sda3 sda4
[    1.052707] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.084208] Freeing unused kernel memory: 656K
[    1.117205] Write protecting the kernel text: 4988k
[    1.148240] Write protecting the kernel read-only data: 1452k
[    1.203127] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: 
[    1.577365] NET: Registered protocol family 10
[    1.608514] Segment Routing with IPv6
[    1.642979] NET: Registered protocol family 1
[    1.708072] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    1.785237] systemd[1]: Detected architecture x86.
[    1.955955] systemd[751]: Failed to execute /usr/lib/systemd/system-generators/anaconda-generator: Exec format error
[    1.970696] systemd[757]: Failed to execute /usr/lib/systemd/system-generators/selinux-autorelabel-generator.sh: Exec format error
[    2.031250] systemd[752]: Failed to execute /usr/lib/systemd/system-generators/kdump-dep-generator.sh: Exec format error
[    2.191145] systemd[750]: /usr/lib/systemd/system-generators/anaconda-generator failed with exit status 1.
[    2.352961] systemd[750]: /usr/lib/systemd/system-generators/kdump-dep-generator.sh failed with exit status 1.
[    2.386671] systemd[750]: /usr/lib/systemd/system-generators/selinux-autorelabel-generator.sh failed with exit status 1.
[    2.499903] systemd[1]: /usr/lib/systemd/system/virtlockd-admin.socket:7: Unknown lvalue 'Server' in section 'Socket'
[    2.723913] random: systemd: uninitialized urandom read (16 bytes read)
[    2.757181] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    2.824599] random: systemd: uninitialized urandom read (16 bytes read)
[    2.892961] random: systemd: uninitialized urandom read (16 bytes read)
[    4.111507] audit: type=1130 audit(1532158063.110:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.270704] audit: type=1130 audit(1532158063.268:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.432583] audit: type=1130 audit(1532158063.431:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.561501] audit: type=1130 audit(1532158063.560:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.741735] audit: type=1130 audit(1532158063.740:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.834999] audit: type=1131 audit(1532158063.740:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.023903] audit: type=1130 audit(1532158064.022:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.489909] audit: type=1130 audit(1532158064.488:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[    5.640697] audit: type=1130 audit(1532158064.639:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fedora-readonly comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.798610] audit: type=1130 audit(1532158064.797:11): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.906785] systemd-journald[776]: Received request to flush runtime journal from PID 1
[    6.148571] audit: type=1130 audit(1532158065.147:12): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.454627] audit: type=1130 audit(1532158065.453:13): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.681069] audit: type=1130 audit(1532158065.633:14): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.855062] audit: type=1130 audit(1532158065.853:15): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.035511] rtc_cmos 00:04: RTC can wake from S4
[    7.042468] rtc_cmos 00:04: registered as rtc0
[    7.042531] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    7.374926] sky2: driver version 1.30
[    7.437810] ata_piix 0000:00:1f.1: version 2.13
[    7.439063] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.502399] sky2 0000:02:00.0: Yukon-2 EC chip revision 2
[    7.567210] scsi host4: ata_piix
[    7.627811] sky2 0000:02:00.0 eth0: addr 00:16:cb:8c:b2:65
[    7.689575] intel_rng: FWH not detected
[    7.747411] ehci-pci: EHCI PCI platform driver
[    7.808430] scsi host5: ata_piix
[    7.866635] ata5: PATA max UDMA/100 cmd 0x40e8 ctl 0x40fc bmdma 0x40c0 irq 18
[    7.923618] ata6: PATA max UDMA/100 cmd 0x40e0 ctl 0x40f8 bmdma 0x40c8 irq 18
[    7.994138] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    8.052116] EFI Variables Facility v0.08 2004-May-17
[    8.114337] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    8.137859] ata5.00: ATAPI: MATSHITADVD-R   UJ-857, HAEA, max UDMA/66
[    8.233093] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    8.235154] ata5.00: configured for UDMA/66
[    8.339991] scsi 4:0:0:0: CD-ROM            MATSHITA DVD-R   UJ-857   HAEA PQ: 0 ANSI: 5
[    8.405101] ehci-pci 0000:00:1d.7: debug port 1
[    8.459776] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    8.462108] ehci-pci 0000:00:1d.7: irq 23, io mem 0x90305400
[    8.519561] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    8.630947] [drm] radeon kernel modesetting enabled.
[    8.679126] applesmc: key=247 fan=2 temp=12 index=12 acc=1 lux=2 kbd=1
[    8.727264] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
[    8.775664] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.824068] usb usb1: Product: EHCI Host Controller
[    8.872531] usb usb1: Manufacturer: Linux 4.17.6+ ehci_hcd
[    8.920763] usb usb1: SerialNumber: 0000:00:1d.7
[    8.928890] checking generic (80010000 50e000) vs hw (80000000 8000000)
[    8.968500] fb: switching to radeondrmfb from EFI VGA
[    8.981531] hub 1-0:1.0: USB hub found
[    9.062174] hub 1-0:1.0: 8 ports detected
[    9.069270] input: applesmc as /devices/platform/applesmc.768/input/input4
[    9.158807] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[    9.295320] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    9.348879] uhci_hcd: USB Universal Host Controller Interface driver
[    9.351104] Console: switching to colour dummy device 80x25
[    9.365709] hdaudio hdaudioC0D0: Unable to bind the codec
[    9.368562] sky2 0000:02:00.0 enp2s0: renamed from eth0
[    9.374753] [drm] initializing kernel modesetting (RV530 0x1002:0x71C5 0x106B:0x0080 0x00).
[    9.377811] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    9.377842] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    9.382122] uhci_hcd 0000:00:1d.0: irq 23, io base 0x000040a0
[    9.382266] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
[    9.382282] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.382296] usb usb2: Product: UHCI Host Controller
[    9.382306] usb usb2: Manufacturer: Linux 4.17.6+ uhci_hcd
[    9.382317] usb usb2: SerialNumber: 0000:00:1d.0
[    9.383244] audit: type=1130 audit(1532158068.382:16): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-backlight@leds:smc::kbd_backlight comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.387274] hub 2-0:1.0: USB hub found
[    9.387305] hub 2-0:1.0: 2 ports detected
[    9.387970] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    9.387992] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    9.390325] ATOM BIOS: M56P
[    9.390366] [drm] GPU not posted. posting now...
[    9.391096] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00004080
[    9.391225] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
[    9.391241] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.391254] usb usb3: Product: UHCI Host Controller
[    9.391264] usb usb3: Manufacturer: Linux 4.17.6+ uhci_hcd
[    9.391275] usb usb3: SerialNumber: 0000:00:1d.1
[    9.392225] hub 3-0:1.0: USB hub found
[    9.392256] hub 3-0:1.0: 2 ports detected
[    9.392902] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    9.392924] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    9.396215] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00004060
[    9.396357] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
[    9.396373] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.396387] usb usb4: Product: UHCI Host Controller
[    9.396397] usb usb4: Manufacturer: Linux 4.17.6+ uhci_hcd
[    9.396407] usb usb4: SerialNumber: 0000:00:1d.2
[    9.397197] hub 4-0:1.0: USB hub found
[    9.397225] hub 4-0:1.0: 2 ports detected
[    9.397868] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    9.397890] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    9.398059] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    9.398075] cdrom: Uniform CD-ROM driver Revision: 3.20
[    9.399399] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    9.400154] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00004040
[    9.400375] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
[    9.400392] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.400405] usb usb5: Product: UHCI Host Controller
[    9.400416] usb usb5: Manufacturer: Linux 4.17.6+ uhci_hcd
[    9.400426] usb usb5: SerialNumber: 0000:00:1d.3
[    9.401212] hub 5-0:1.0: USB hub found
[    9.401269] hub 5-0:1.0: 2 ports detected
[    9.410452] [drm] GPU not posted. posting now...
[    9.432432] [drm] Generation 2 PCI interface, using max accessible memory
[    9.432460] radeon 0000:01:00.0: VRAM: 128M 0x0000000000000000 - 0x0000000007FFFFFF (128M used)
[    9.432476] radeon 0000:01:00.0: GTT: 512M 0x0000000008000000 - 0x0000000027FFFFFF
[    9.436274] [drm] Detected VRAM RAM=128M, BAR=128M
[    9.436290] [drm] RAM width 128bits DDR
[    9.439097] [TTM] Zone  kernel: Available graphics memory: 440010 kiB
[    9.439112] [TTM] Zone highmem: Available graphics memory: 1018558 kiB
[    9.439121] [TTM] Initializing pool allocator
[    9.439169] [drm] radeon: 128M of VRAM memory ready
[    9.439178] [drm] radeon: 512M of GTT memory ready.
[    9.439213] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    9.441781] [drm] Possible lm63 thermal controller at 0x4c
[    9.441827] [drm] radeon: power management initialized
[    9.451429] [drm] radeon: 1 quad pipes, 2 z pipes initialized.
[    9.456187] [drm] PCIE GART of 512M enabled (table at 0x0000000000040000).
[    9.456502] radeon 0000:01:00.0: WB enabled
[    9.456518] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000008000000 and cpu addr 0x(ptrval)
[    9.456532] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.456541] [drm] Driver supports precise vblank timestamp query.
[    9.456551] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    9.456638] radeon 0000:01:00.0: radeon: using MSI.
[    9.456793] [drm] radeon: irq initialized.
[    9.456821] [drm] Loading R500 Microcode
[    9.463354] [drm] radeon: ring at 0x0000000008001000
[    9.463887] [drm] ring test succeeded in 12 usecs
[    9.466037] [drm] ib test succeeded in 0 usecs
[    9.472212] [drm] Radeon Display Connectors
[    9.472227] [drm] Connector 0:
[    9.472234] [drm]   LVDS-1
[    9.472244] [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
[    9.472255] [drm]   Encoders:
[    9.472262] [drm]     LCD1: INTERNAL_LVTM1
[    9.472270] [drm] Connector 1:
[    9.472277] [drm]   SVIDEO-1
[    9.472283] [drm]   Encoders:
[    9.472290] [drm]     TV1: INTERNAL_KLDSCP_DAC2
[    9.472298] [drm] Connector 2:
[    9.472304] [drm]   DVI-I-1
[    9.472311] [drm]   HPD1
[    9.472321] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[    9.472331] [drm]   Encoders:
[    9.472338] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    9.472346] [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
[    9.713053] usb 2-2: new full-speed USB device number 2 using uhci_hcd
[    9.792156] [drm] fb mappable at 0x800C0000
[    9.792171] [drm] vram apper at 0x80000000
[    9.792179] [drm] size 5300224
[    9.792186] [drm] fb depth is 24
[    9.792193] [drm]    pitch is 5888
[    9.792447] fbcon: radeondrmfb (fb0) is primary device
[    9.864227] Console: switching to colour frame buffer device 180x56
[    9.876480] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[    9.876536] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    9.905247] usb 2-2: New USB device found, idVendor=05ac, idProduct=0218, bcdDevice= 0.60
[    9.905381] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    9.905489] usb 2-2: Product: Apple Internal Keyboard / Trackpad
[    9.905584] usb 2-2: Manufacturer: Apple Computer
[    9.978658] usbcore: registered new interface driver usbhid
[    9.978761] usbhid: USB HID core driver
[    9.982248] appletouch 2-2:1.1: Geyser mode initialized.
[    9.982799] input: appletouch as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.1/input/input5
[    9.983634] usbcore: registered new interface driver usbkbd
[    9.986138] usbcore: registered new interface driver appletouch
[    9.991061] usbcore: registered new interface driver usbmouse
[   10.018770] input: Apple Computer Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:05AC:0218.0001/input/input6
[   10.070275] apple 0003:05AC:0218.0001: input,hidraw0: USB HID v1.11 Keyboard [Apple Computer Apple Internal Keyboard / Trackpad] on usb-0000:00:1d.0-2/input0
[   10.072791] input: Apple Computer Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.2/0003:05AC:0218.0002/input/input7
[   10.125468] apple 0003:05AC:0218.0002: input,hidraw1: USB HID v1.11 Device [Apple Computer Apple Internal Keyboard / Trackpad] on usb-0000:00:1d.0-2/input2
[   10.420115] usb 1-4: new high-speed USB device number 3 using ehci-pci
[   10.552513] usb 1-4: New USB device found, idVendor=05ac, idProduct=8501, bcdDevice= 1.89
[   10.552641] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   10.552750] usb 1-4: Product: Built-in iSight
[   10.552820] usb 1-4: Manufacturer: Micron
[   11.059086] usb 4-2: new full-speed USB device number 2 using uhci_hcd
[   11.238172] usb 4-2: New USB device found, idVendor=05ac, idProduct=8240, bcdDevice= 1.09
[   11.238300] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   11.238409] usb 4-2: Product: IR Receiver
[   11.238474] usb 4-2: Manufacturer: Apple Computer, Inc.
[   11.277227] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.2/usb4/4-2/4-2:1.0/0003:05AC:8240.0003/input/input8
[   11.330368] appleir 0003:05AC:8240.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.2-2/input0
[   12.173115] usb 5-1: new full-speed USB device number 2 using uhci_hcd
[   12.359202] usb 5-1: New USB device found, idVendor=05ac, idProduct=1000, bcdDevice=19.65
[   12.363557] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   12.395358] input: HID 05ac:1000 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/0003:05AC:1000.0004/input/input9
[   12.453114] hid-generic 0003:05AC:1000.0004: input,hidraw3: USB HID v1.11 Keyboard [HID 05ac:1000] on usb-0000:00:1d.3-1/input0
[   12.475578] input: HID 05ac:1000 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.1/0003:05AC:1000.0005/input/input10
[   12.480710] hid-generic 0003:05AC:1000.0005: input,hidraw4: USB HID v1.11 Mouse [HID 05ac:1000] on usb-0000:00:1d.3-1/input1
[   12.716962] audit: type=1130 audit(1532158071.715:17): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.745065] audit: type=1130 audit(1532158071.726:18): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.778428] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[   12.796277] audit: type=1130 audit(1532158071.794:19): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.826212] audit: type=1130 audit(1532158071.824:20): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.826219] audit: type=1131 audit(1532158071.824:21): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.919561] audit: type=1130 audit(1532158071.918:22): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.933603] audit: type=1131 audit(1532158071.918:23): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.933611] audit: type=1130 audit(1532158071.932:24): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.964940] audit: type=1130 audit(1532158071.963:25): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.627459] random: crng init done
[   14.628010] random: 7 urandom warning(s) missed due to ratelimiting
[   17.526132] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   17.530766] sky2 0000:02:00.0 enp2s0: enabling interface
[   17.533151] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   37.504605] sky2 0000:02:00.0 enp2s0: disabling interface
[   37.540136] PM: suspend entry (deep)
[   37.540214] PM: Syncing filesystems ... done.
[   37.611311] Freezing user space processes ... (elapsed 0.000 seconds) done.
[   37.612260] OOM killer disabled.
[   37.612313] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
[   37.613464] Suspending console(s) (use no_console_suspend to debug)
[   37.619113] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[   37.619281] sd 2:0:0:0: [sda] Stopping disk
[   37.764397] ACPI: EC: interrupt blocked
[   37.967625] ACPI: Preparing to enter system sleep state S3
[   37.968855] ACPI: EC: event blocked
[   37.968857] ACPI: EC: EC stopped
[   37.968859] PM: Saving platform NVS memory
[   37.972061] Disabling non-boot CPUs ...
[   37.979508] smpboot: CPU 1 is now offline
[   37.982773] ACPI: Low-level resume complete
[   37.982773] ACPI: EC: EC started
[   37.982773] PM: Restoring platform NVS memory
[   37.982773] Enabling non-boot CPUs ...
[   37.982773] x86: Booting SMP configuration:
[   37.982773] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   37.979432] Initializing CPU#1
[   37.979432] Disabled fast string operations
[   37.983826]  cache: parent cpu1 should not be sleeping
[   37.984114] CPU1 is up
[   37.985695] ACPI: Waking up from system sleep state S3
[   38.200273] ACPI: EC: interrupt unblocked
[   38.408692] ACPI: EC: event unblocked
[   38.408855] usb usb2: root hub lost power or was reset
[   38.409002] usb usb3: root hub lost power or was reset
[   38.409337] radeon 0000:01:00.0: 9205c8ef unpin not necessary
[   38.410502] usb usb4: root hub lost power or was reset
[   38.410614] usb usb5: root hub lost power or was reset
[   38.411924] sd 2:0:0:0: [sda] Starting disk
[   38.416496] [drm] radeon: 1 quad pipes, 2 z pipes initialized.
[   38.419384] [drm] PCIE GART of 512M enabled (table at 0x0000000000040000).
[   38.419390] radeon 0000:01:00.0: WB enabled
[   38.419396] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000008000000 and cpu addr 0x367c2eb5
[   38.419435] [drm] radeon: ring at 0x0000000008001000
[   38.419477] [drm] ring test succeeded in 13 usecs
[   38.419500] [drm] ib test succeeded in 0 usecs
[   38.579324] ata5.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
[   38.579331] ata5.00: ACPI cmd ef/03:44:00:00:00:a0 (SET FEATURES) filtered out
[   38.584371] ata5.00: configured for UDMA/66
[   38.717330] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   38.734740] ata3.00: configured for UDMA/133
[   38.737130] usb 2-2: reset full-speed USB device number 2 using uhci_hcd
[   38.738115] usb 5-1: reset full-speed USB device number 2 using uhci_hcd
[   38.745106] usb 4-2: reset full-speed USB device number 2 using uhci_hcd
[   38.899843] appletouch 2-2:1.1: Geyser mode initialized.
[   38.944948] OOM killer enabled.
[   38.945000] Restarting tasks ... done.
[   38.965923] PM: suspend exit
[   38.986028] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   38.989833] sky2 0000:02:00.0 enp2s0: enabling interface
[   38.990082] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   42.069704] do_IRQ: 1.36 No irq handler for vector
