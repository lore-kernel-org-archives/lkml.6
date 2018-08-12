Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645DBC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4121976
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 17:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED4121976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeHLTox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 15:44:53 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:38726 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbeHLTox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 15:44:53 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 96FC19002C;
        Sun, 12 Aug 2018 20:06:08 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 86DF5220905; Sun, 12 Aug 2018 20:06:06 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 8E6652207BD;
        Sun, 12 Aug 2018 20:06:06 +0300 (EEST)
Date:   Sun, 12 Aug 2018 20:06:06 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org
Subject: UBSAN warning from ac97_codec.c - shift exponent 68 is too large
 for 32-bit type 'int'
Message-ID: <alpine.LRH.2.21.1808122003050.26173@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the NULL UBSAN warning with gcc-8 are gone, there are still 2 new 
UBSAN warnings left with gcc-8.2:

[   16.174194] UBSAN: Undefined behaviour in sound/pci/ac97/ac97_codec.c:836:7
[   16.174282] shift exponent 68 is too large for 32-bit type 'int'

Full dnesg:

[    0.000000] Linux version 4.18.0-rc8-00049-gec0c96714e7d (mroos@kukeseen) (gcc version 8.2.0 (Debian 8.2.0-3)) #51 Sun Aug 12 19:38:09 EEST 2018
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000ec000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fecfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffee0000-0x00000000fff0fffe] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.3 present.
[    0.000000] DMI: MSI                              MS-6547                         /MS-6547                         , BIOS 07.00T                
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x40000 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 base 0E0000000 mask FFC000000 write-combining
[    0.000000]   7 base 0E0000000 mask FFC000000 write-combining
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] initial memory mapped: [mem 0x00000000-0x1fbfffff]
[    0.000000] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.000000] BRK [0x1f818000, 0x1f818fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI BIOS Error (bug): A valid RSDP was not found (20180531/tbxfroot-210)
[    0.000000] 136MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] BRK [0x1f819000, 0x1f819fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003fffffff]
[    0.000000] On node 0 totalpages: 262046
[    0.000000]   DMA zone: 36 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 1962 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 34818 pages, LIFO batch:7
[    0.000000] Using APIC driver default
[    0.000000] Local APIC disabled by BIOS -- reenabling.
[    0.000000] Found and enabled local APIC!
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000ebfff]
[    0.000000] PM: Registered nosave memory: [mem 0x000ec000-0x000fffff]
[    0.000000] [mem 0x40000000-0xfebfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x6d/0x36b with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260048
[    0.000000] Kernel command line: auto BOOT_IMAGE=test ro root=803 lapic
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:00040000)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 1029772K/1048184K available (4988K kernel code, 676K rwdata, 1308K rodata, 412K init, 312K bss, 18412K reserved, 0K cma-reserved, 139272K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
                 cpu_entry : 0xffc00000 - 0xffc28000   ( 160 kB)
                   pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
                   vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
                     .init : 0xdf6e3000 - 0xdf74a000   ( 412 kB)
                     .data : 0xdf4df35c - 0xdf6d5100   (2007 kB)
                     .text : 0xdf000000 - 0xdf4df35c   (4988 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] NR_IRQS: 2304, nr_irqs: 32, preallocated irqs: 16
[    0.000000] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.004000] APIC: ACPI MADT or MP tables are not detected
[    0.004000] APIC: Switch to virtual wire mode setup with no configuration
[    0.004000] Enabling APIC mode:  Flat.  Using 0 I/O APICs
[    0.004000] tsc: Fast TSC calibration using PIT
[    0.008000] tsc: Detected 2000.156 MHz processor
[    0.008000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1cd4c1a02bd, max_idle_ns: 440795302132 ns
[    0.008000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4000.31 BogoMIPS (lpj=8000624)
[    0.008000] pid_max: default: 32768 minimum: 301
[    0.008000] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.008000] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.012213] mce: CPU supports 4 MCE banks
[    0.012307] CPU0: Thermal monitoring enabled (TM1)
[    0.012408] Last level iTLB entries: 4KB 128, 2MB 128, 4MB 128
[    0.012491] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 64, 1GB 0
[    0.012576] CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz (family: 0xf, model: 0x2, stepping: 0x7)
[    0.012709] Spectre V2 : Mitigation: Full generic retpoline
[    0.012789] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.012872] Speculative Store Bypass: Vulnerable
[    0.013320] Performance Events: Netburst events, Netburst P4/Xeon PMU driver.
[    0.013424] ... version:                0
[    0.013505] ... bit width:              40
[    0.013584] ... generic registers:      18
[    0.013665] ... value mask:             000000ffffffffff
[    0.013743] ... max period:             0000007fffffffff
[    0.013819] ... fixed-purpose events:   0
[    0.013895] ... event mask:             000000000003ffff
[    0.120108] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.120443] devtmpfs: initialized
[    0.120967] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.121098] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.121366] NET: Registered protocol family 16
[    0.121778] cpuidle: using governor ladder
[    0.121860] cpuidle: using governor menu
[    0.127211] PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
[    0.127294] PCI: Using configuration type 1 for base access
[    0.128993] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    0.129533] ACPI: Interpreter disabled.
[    0.129724] vgaarb: loaded
[    0.129934] SCSI subsystem initialized
[    0.130089] libata version 3.00 loaded.
[    0.130166] PCI: Probing PCI hardware
[    0.130249] PCI: root bus 00: using default resources
[    0.130251] PCI: Probing PCI hardware (bus 00)
[    0.130303] PCI host bridge to bus 0000:00
[    0.130390] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.130475] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.130558] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.130701] pci 0000:00:00.0: [1039:0645] type 00 class 0x060000
[    0.130725] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff]
[    0.130888] pci 0000:00:01.0: [1039:0001] type 01 class 0x060400
[    0.131005] pci 0000:00:02.0: [1039:0008] type 00 class 0x060100
[    0.131101] pci 0000:00:02.0: Enabling SiS 96x SMBus
[    0.131256] pci 0000:00:02.1: [1039:0016] type 00 class 0x0c0500
[    0.131323] pci 0000:00:02.1: reg 0x20: [io  0x0c00-0x0c1f]
[    0.131419] pci 0000:00:02.2: [1039:7001] type 00 class 0x0c0310
[    0.131445] pci 0000:00:02.2: reg 0x10: [mem 0xdfffe000-0xdfffefff]
[    0.131579] pci 0000:00:02.3: [1039:7001] type 00 class 0x0c0310
[    0.131604] pci 0000:00:02.3: reg 0x10: [mem 0xdffff000-0xdfffffff]
[    0.131742] pci 0000:00:02.5: [1039:5513] type 00 class 0x010180
[    0.131809] pci 0000:00:02.5: reg 0x20: [io  0xff00-0xff0f]
[    0.131839] pci 0000:00:02.5: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.131926] pci 0000:00:02.5: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.132010] pci 0000:00:02.5: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.132096] pci 0000:00:02.5: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.132257] pci 0000:00:02.7: [1039:7012] type 00 class 0x040100
[    0.132287] pci 0000:00:02.7: reg 0x10: [io  0xdc00-0xdcff]
[    0.132302] pci 0000:00:02.7: reg 0x14: [io  0xd800-0xd87f]
[    0.132392] pci 0000:00:02.7: PME# supported from D3hot D3cold
[    0.132482] pci 0000:00:07.0: [1011:0009] type 00 class 0x020000
[    0.132507] pci 0000:00:07.0: reg 0x10: [io  0xd400-0xd47f]
[    0.132522] pci 0000:00:07.0: reg 0x14: [mem 0xdfffdf80-0xdfffdfff]
[    0.132577] pci 0000:00:07.0: reg 0x30: [mem 0xdff80000-0xdffbffff pref]
[    0.132695] pci_bus 0000:01: extended config space not accessible
[    0.132820] pci 0000:01:00.0: [10de:0172] type 00 class 0x030000
[    0.132841] pci 0000:01:00.0: reg 0x10: [mem 0xde000000-0xdeffffff]
[    0.132852] pci 0000:01:00.0: reg 0x14: [mem 0xd8000000-0xdbffffff pref]
[    0.132863] pci 0000:01:00.0: reg 0x18: [mem 0xddc80000-0xddcfffff pref]
[    0.132898] pci 0000:01:00.0: reg 0x30: [mem 0xdfee0000-0xdfefffff pref]
[    0.132983] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.133069] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.133244] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.133333] pci 0000:00:01.0:   bridge window [mem 0xdde00000-0xdfefffff]
[    0.133341] pci 0000:00:01.0:   bridge window [mem 0xd5b00000-0xddcfffff pref]
[    0.133354] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    0.133401] pci 0000:00:02.0: SIS IRQ router [1039:0961]
[    0.133506] PCI: pci_cache_line_size set to 64 bytes
[    0.133548] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.133958] clocksource: Switched to clocksource tsc-early
[    0.134202] pnp: PnP ACPI: disabled
[    0.135956] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.135956] pci 0000:00:01.0:   bridge window [mem 0xdde00000-0xdfefffff]
[    0.135956] pci 0000:00:01.0:   bridge window [mem 0xd5b00000-0xddcfffff pref]
[    0.135956] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.135956] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.135956] pci_bus 0000:01: resource 1 [mem 0xdde00000-0xdfefffff]
[    0.135956] pci_bus 0000:01: resource 2 [mem 0xd5b00000-0xddcfffff pref]
[    0.135956] NET: Registered protocol family 2
[    0.135956] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    0.135956] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.136014] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.136122] TCP: Hash tables configured (established 8192 bind 8192)
[    0.136289] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.136377] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.136522] NET: Registered protocol family 1
[    0.136615] NET: Registered protocol family 44
[    0.136736] PCI: setting IRQ 10 as level-triggered
[    0.136742] pci 0000:00:02.2: found PCI INT D -> IRQ 10
[    0.722076] pci 0000:00:02.2: quirk_usb_early_handoff+0x0/0x6c4 took 571620 usecs
[    0.722211] PCI: setting IRQ 11 as level-triggered
[    0.722215] pci 0000:00:02.3: found PCI INT A -> IRQ 11
[    1.310087] pci 0000:00:02.3: quirk_usb_early_handoff+0x0/0x6c4 took 574100 usecs
[    1.310238] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.310362] PCI: CLS 32 bytes, default 64
[    1.310550] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    1.311438] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    1.313353] bounce: pool size: 64 pages
[    1.313468] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.313653] io scheduler noop registered
[    1.313733] io scheduler deadline registered
[    1.313839] io scheduler cfq registered (default)
[    1.314127] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.334624] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.355174] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.355685] pata_sis 0000:00:02.5: version 0.5.2
[    1.356259] scsi host0: pata_sis
[    1.356498] scsi host1: pata_sis
[    1.356643] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    1.356727] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    1.356874] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[    1.356973] tulip 0000:00:07.0: found PCI INT A -> IRQ 11
[    1.361115] tulip0: EEPROM default media type Autosense
[    1.361195] tulip0: Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block
[    1.361310] tulip0: Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block
[    1.362129] tulip0: Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block
[    1.362245] tulip0: Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block
[    1.362728] tulip0:  MII transceiver #1 config 3100 status 786b advertising 01e1
[    1.367148] net eth0: Digital DS21140 Tulip rev 34 at MMIO 0xdfffdf80, 00:00:e8:2c:66:f7, IRQ 11
[    1.367351] i8042: PNP: No PS/2 controller found.
[    1.367435] i8042: Probing ports directly.
[    1.370666] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.370950] mousedev: PS/2 mouse device common for all mice
[    1.373707] rtc_cmos rtc_cmos: registered as rtc0
[    1.373819] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[    1.374133] NET: Registered protocol family 10
[    1.374695] Segment Routing with IPv6
[    1.374862] mip6: Mobile IPv6
[    1.374943] NET: Registered protocol family 17
[    1.375093] Key type dns_resolver registered
[    1.375377] microcode: sig=0xf27, pf=0x4, revision=0x24
[    1.375520] microcode: Microcode Update Driver: v2.2.
[    1.375528] Using IPI Shortcut mode
[    1.375691] sched_clock: Marking stable (1374080775, 0)->(1472968189, -98887414)
[    1.376022] registered taskstats version 1
[    1.376469] console [netcon0] enabled
[    1.376546] netconsole: network logging started
[    1.376665] rtc_cmos rtc_cmos: setting system clock to 2018-08-12 20:01:04 UTC (1534104064)
[    1.404348] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.534617] ata1.00: ATA-5: ST360021A, 3.19, max UDMA/100
[    1.534700] ata1.00: 117231408 sectors, multi 16: LBA 
[    1.582499] ata1.01: ATA-7: ST3160815A, 3.AAC, max UDMA/100
[    1.582583] ata1.01: 312581808 sectors, multi 16: LBA48 
[    1.649202] scsi 0:0:0:0: Direct-Access     ATA      ST360021A        3.19 PQ: 0 ANSI: 5
[    1.649812] scsi 0:0:1:0: Direct-Access     ATA      ST3160815A       C    PQ: 0 ANSI: 5
[    1.650462] sd 0:0:0:0: [sda] 117231408 512-byte logical blocks: (60.0 GB/55.9 GiB)
[    1.650599] sd 0:0:0:0: [sda] Write Protect is off
[    1.650680] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.650713] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.704611]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    1.704833] sd 0:0:1:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    1.704971] sd 0:0:1:0: [sdb] Write Protect is off
[    1.705053] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    1.705181] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.730182] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.730476]  sdb: sdb1 sdb2
[    1.731040] sd 0:0:1:0: [sdb] Attached SCSI disk
[    1.810646] ata2.00: ATAPI: LTN526, YH0X, max UDMA/33
[    1.815621] scsi 1:0:0:0: CD-ROM            LITEON   CD-ROM LTN526    YH0X PQ: 0 ANSI: 5
[    1.846484] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
[    1.859356] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    1.859509] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    1.887772] devtmpfs: mounted
[    1.888350] Freeing unused kernel memory: 412K
[    1.888490] Write protecting the kernel text: 4992k
[    1.888605] Write protecting the kernel read-only data: 1328k
[    2.350136] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1cd4c1a02bd, max_idle_ns: 440795302132 ns
[    2.350271] clocksource: Switched to clocksource tsc
[    3.005387] random: fast init done
[    4.147919] systemd[1]: RTC configured in localtime, applying delta of 180 minutes to system time.
[    4.696051] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    4.696528] systemd[1]: Detected architecture x86.
[    4.772312] systemd[1]: Set hostname to <kukeseen>.
[    6.469937] random: crng init done
[    8.173758] systemd[1]: Configuration file /etc/systemd/system/postfix.service.d/override.conf is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[    8.613832] systemd[1]: Listening on fsck to fsckd communication Socket.
[    8.614926] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.615731] systemd[1]: Listening on udev Control Socket.
[    8.617740] systemd[1]: Created slice system-postfix.slice.
[    8.618446] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    8.619600] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    9.415422] RPC: Registered named UNIX socket transport module.
[    9.415519] RPC: Registered udp transport module.
[    9.415598] RPC: Registered tcp transport module.
[    9.415676] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    9.640125] hidraw: raw HID events driver (C) Jiri Kosina
[    9.916663] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   10.489323] snd_intel8x0 0000:00:02.7: found PCI INT C -> IRQ 10
[   10.537091] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro
[   10.774603] systemd-journald[75]: Received request to flush runtime journal from PID 1
[   10.808069] snd_intel8x0 0000:00:02.7: intel8x0_measure_ac97_clock: measured 58651 usecs (2821 samples)
[   10.808207] snd_intel8x0 0000:00:02.7: clocking to 48000
[   11.236894] w83627hf: w83627hf: Found W83697HF chip at 0x290
[   11.237269] w83627hf w83627hf.656: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   13.964176] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   14.087955] sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
[   14.089334] Linux agpgart interface v0.103
[   14.183339] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   14.183547] sd 0:0:1:0: Attached scsi generic sg1 type 0
[   14.183692] scsi 1:0:0:0: Attached scsi generic sg2 type 5
[   14.237656] usbcore: registered new interface driver usbfs
[   14.237774] usbcore: registered new interface driver hub
[   14.240936] usbcore: registered new device driver usb
[   14.279033] agpgart-sis 0000:00:00.0: SiS chipset [1039/0645]
[   14.285283] Error: Driver 'pcspkr' is already registered, aborting...
[   14.291513] agpgart-sis 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[   14.529577] sr 1:0:0:0: [sr0] scsi3-mmc drive: 52x/52x cd/rw xa/form2 cdda tray
[   14.530523] cdrom: Uniform CD-ROM driver Revision: 3.20
[   14.531564] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   14.905983] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   14.908887] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   14.910678] ehci-pci: EHCI PCI platform driver
[   14.912470] ohci-pci: OHCI PCI platform driver
[   14.912619] ohci-pci 0000:00:02.2: found PCI INT D -> IRQ 10
[   14.912756] ohci-pci 0000:00:02.2: OHCI PCI host controller
[   14.912850] ohci-pci 0000:00:02.2: new USB bus registered, assigned bus number 1
[   14.913023] ohci-pci 0000:00:02.2: irq 10, io mem 0xdfffe000
[   14.974137] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[   14.974275] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.974523] usb usb1: Product: OHCI PCI host controller
[   14.974608] usb usb1: Manufacturer: Linux 4.18.0-rc8-00049-gec0c96714e7d ohci_hcd
[   14.974731] usb usb1: SerialNumber: 0000:00:02.2
[   14.975678] hub 1-0:1.0: USB hub found
[   14.975781] hub 1-0:1.0: 3 ports detected
[   14.980709] ohci-pci 0000:00:02.3: found PCI INT A -> IRQ 11
[   14.980859] ohci-pci 0000:00:02.3: OHCI PCI host controller
[   14.981075] ohci-pci 0000:00:02.3: new USB bus registered, assigned bus number 2
[   14.981249] ohci-pci 0000:00:02.3: irq 11, io mem 0xdffff000
[   15.042118] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[   15.042252] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.042373] usb usb2: Product: OHCI PCI host controller
[   15.042457] usb usb2: Manufacturer: Linux 4.18.0-rc8-00049-gec0c96714e7d ohci_hcd
[   15.042578] usb usb2: SerialNumber: 0000:00:02.3
[   15.043830] hub 2-0:1.0: USB hub found
[   15.043935] hub 2-0:1.0: 3 ports detected
[   16.174055] ================================================================================
[   16.174194] UBSAN: Undefined behaviour in sound/pci/ac97/ac97_codec.c:836:7
[   16.174282] shift exponent 68 is too large for 32-bit type 'int'
[   16.174367] CPU: 0 PID: 140 Comm: alsactl Not tainted 4.18.0-rc8-00049-gec0c96714e7d #51
[   16.174488] Hardware name: MSI                              MS-6547                         /MS-6547                         , BIOS 07.00T                
[   16.174616] Call Trace:
[   16.174711]  dump_stack+0x16/0x1e
[   16.174795]  ubsan_epilogue+0xb/0x29
[   16.174875]  __ubsan_handle_shift_out_of_bounds.cold.14+0x20/0x6a
[   16.174962]  ? seccomp_run_filters+0x40/0x140
[   16.175055]  snd_ac97_put_spsa.cold.50+0xf/0x23 [snd_ac97_codec]
[   16.175144]  snd_ctl_ioctl+0x73a/0x900 [snd]
[   16.175230]  ? snd_ctl_elem_add_user+0x900/0x900 [snd]
[   16.175314]  do_vfs_ioctl+0x86/0x650
[   16.175396]  ? __secure_computing+0x2b/0x80
[   16.175478]  ? syscall_trace_enter+0x10c/0x170
[   16.175559]  ksys_ioctl+0x31/0x60
[   16.175639]  sys_ioctl+0x11/0x13
[   16.175718]  do_fast_syscall_32+0x74/0x1b0
[   16.175800]  entry_SYSENTER_32+0x4e/0x7c
[   16.175878] EIP: 0xb7ee2b91
[   16.175952] Code: f7 ff ff 55 89 e5 8b 55 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[   16.176177] EAX: ffffffda EBX: 00000003 ECX: c2c45513 EDX: bfd68f60
[   16.176256] ESI: 00000000 EDI: 00000001 EBP: bfd692d8 ESP: bfd68df8
[   16.176336] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   16.176416] ================================================================================
[   16.176570] ================================================================================
[   16.176686] UBSAN: Undefined behaviour in sound/pci/ac97/ac97_codec.c:837:8
[   16.176767] shift exponent 68 is too large for 32-bit type 'int'
[   16.176848] CPU: 0 PID: 140 Comm: alsactl Not tainted 4.18.0-rc8-00049-gec0c96714e7d #51
[   16.176962] Hardware name: MSI                              MS-6547                         /MS-6547                         , BIOS 07.00T                
[   16.177082] Call Trace:
[   16.177159]  dump_stack+0x16/0x1e
[   16.177235]  ubsan_epilogue+0xb/0x29
[   16.177312]  __ubsan_handle_shift_out_of_bounds.cold.14+0x20/0x6a
[   16.177394]  ? seccomp_run_filters+0x40/0x140
[   16.177478]  snd_ac97_put_spsa.cold.50+0x1e/0x23 [snd_ac97_codec]
[   16.177564]  snd_ctl_ioctl+0x73a/0x900 [snd]
[   16.177646]  ? snd_ctl_elem_add_user+0x900/0x900 [snd]
[   16.177726]  do_vfs_ioctl+0x86/0x650
[   16.177805]  ? __secure_computing+0x2b/0x80
[   16.177883]  ? syscall_trace_enter+0x10c/0x170
[   16.177965]  ksys_ioctl+0x31/0x60
[   16.178045]  sys_ioctl+0x11/0x13
[   16.178124]  do_fast_syscall_32+0x74/0x1b0
[   16.178207]  entry_SYSENTER_32+0x4e/0x7c
[   16.178286] EIP: 0xb7ee2b91
[   16.178363] Code: f7 ff ff 55 89 e5 8b 55 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[   16.178591] EAX: ffffffda EBX: 00000003 ECX: c2c45513 EDX: bfd68f60
[   16.178673] ESI: 00000000 EDI: 00000001 EBP: bfd692d8 ESP: bfd68df8
[   16.178755] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   16.178839] ================================================================================

-- 
Meelis Roos (mroos@linux.ee)
