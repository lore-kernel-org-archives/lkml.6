Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC48BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DBE2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DBE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeJYXOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:14:53 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:55898 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbeJYXOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:14:52 -0400
Subject: Re: HP DL585 warm boot fail (old)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
 <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
 <b36c537a-90ee-c474-9efa-df2ead8e0376@linux.ee>
 <20181024134946.GA214775@bhelgaas-glaptop.roam.corp.google.com>
 <8a8c6cf8-dd21-87db-3498-48f1ddb8fbc1@linux.ee>
 <20181024163422.GB214775@bhelgaas-glaptop.roam.corp.google.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <06e8354f-efad-4843-f36b-a2898b89b8e0@linux.ee>
Date:   Thu, 25 Oct 2018 17:40:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024163422.GB214775@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Can you try the patch below?  This is extracted from the code here:
>>> https://github.com/joyent/illumos-joyent/blob/b6a0b04d591f5b877cfe05f45e81f0e8a5cfc2b3/usr/src/uts/intel/io/pci/pci_boot.c#L1805
>>
>> Thank you. Unfortunately it does not change anything noticable.
> 
> Do you see the "disabling NMI on error" message?> 
> Can you boot with "pci=earlydump vga=0xf07" and capture the output?
> Drop the "vga=0xf07" if it doesn't work or makes the screen
> unreadable.

vga= modes did not work with any LCD available there, vga=6 worked with old CRT only.
But I connected serial console and got full dmesg.

There is no "disabling NMI on error" in the dmesg.

This also caused(?) a working boot with the same kernel that failed before. Both 9600 and 115200 worked the same.

dmesg from pci=earlydump from serial console:

[    0.000000] Linux version 4.19.0-dirty (mroos@dl585) (gcc version 8.2.0 (Debian 8.2.0-4)) #97 SMP Wed Oct 24 17:36:06 EEST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-dirty root=/dev/sda1 ro ignore_loglevel pci=earlydump console=ttyS0,115200
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000f57f67ff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f57f6800-0x00000000f57fffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000fdc00000-0x00000000fdc00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdc10000-0x00000000fdc10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdc20000-0x00000000fdc20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdc30000-0x00000000fdc30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003ffffefff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: HP ProLiant DL585 G1, BIOS A01 02/14/2007
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2196.908 MHz processor
[    0.008307] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.008311] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.015723] AGP: No AGP bridge found
[    0.015858] last_pfn = 0x3fffff max_arch_pfn = 0x400000000
[    0.015865] MTRR default type: write-back
[    0.015866] MTRR fixed ranges enabled:
[    0.015869]   00000-9FFFF write-back
[    0.015871]   A0000-BFFFF uncachable
[    0.015873]   C0000-FFFFF write-back
[    0.015874] MTRR variable ranges enabled:
[    0.015878]   0 base 00F5800000 mask FFFF800000 uncachable
[    0.015881]   1 base 00F6000000 mask FFFE000000 uncachable
[    0.015883]   2 base 00F8000000 mask FFF8000000 uncachable
[    0.015884]   3 disabled
[    0.015885]   4 disabled
[    0.015886]   5 disabled
[    0.015887]   6 disabled
[    0.015888]   7 disabled
[    0.016523] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.016767] last_pfn = 0xf57f6 max_arch_pfn = 0x400000000
[    0.016863] Base memory trampoline at [(____ptrval____)] 99000 size 24576
[    0.016878] BRK [0x2be401000, 0x2be401fff] PGTABLE
[    0.016887] BRK [0x2be402000, 0x2be402fff] PGTABLE
[    0.016891] BRK [0x2be403000, 0x2be403fff] PGTABLE
[    0.016964] BRK [0x2be404000, 0x2be404fff] PGTABLE
[    0.016971] BRK [0x2be405000, 0x2be405fff] PGTABLE
[    0.017198] BRK [0x2be406000, 0x2be406fff] PGTABLE
[    0.017209] BRK [0x2be407000, 0x2be407fff] PGTABLE
[    0.017219] BRK [0x2be408000, 0x2be408fff] PGTABLE
[    0.017284] BRK [0x2be409000, 0x2be409fff] PGTABLE
[    0.017521] BRK [0x2be40a000, 0x2be40afff] PGTABLE
[    0.017583] ACPI: Early table checksum verification disabled
[    0.018039] ACPI: RSDP 0x00000000000F4F20 000024 (v02 HP    )
[    0.018046] ACPI: XSDT 0x00000000F57F6C00 000044 (v01 HP     A01      00000002 �?   0000162E)
[    0.018058] ACPI: FACP 0x00000000F57F6C80 0000F4 (v03 HP     A01      00000002 �?   0000162E)
[    0.018074] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20180810/tbfadt-674)
[    0.018079] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1bControlBlock: 32, using default 16 (20180810/tbfadt-674)
[    0.018085] ACPI: DSDT 0x00000000F57F6D80 0051D5 (v01 HP     DSDT     00000001 MSFT 02000001)
[    0.018091] ACPI: FACS 0x00000000F57F68C0 000040
[    0.018094] ACPI: FACS 0x00000000F57F68C0 000040
[    0.018098] ACPI: APIC 0x00000000F57F6900 0000D0 (v01 HP     00000083 00000002      00000000)
[    0.018103] ACPI: SPCR 0x00000000F57F6A00 000050 (v01 HP     SPCRRBSU 00000001 �?   0000162E)
[    0.018108] ACPI: SRAT 0x00000000F57F6A80 000150 (v01 HP     A01      00000001      00000000)
[    0.018123] ACPI: Local APIC address 0xfee00000
[    0.018294] SRAT: PXM 1 -> APIC 0x00 -> Node 0
[    0.018296] SRAT: PXM 2 -> APIC 0x01 -> Node 1
[    0.018297] SRAT: PXM 3 -> APIC 0x02 -> Node 2
[    0.018299] SRAT: PXM 4 -> APIC 0x03 -> Node 3
[    0.018305] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0xffffffff]
[    0.018307] ACPI: SRAT: Node 1 PXM 2 [mem 0x100000000-0x1ffffffff]
[    0.018309] ACPI: SRAT: Node 2 PXM 3 [mem 0x200000000-0x2ffffffff]
[    0.018311] ACPI: SRAT: Node 3 PXM 4 [mem 0x300000000-0x3ffffffff]
[    0.018324] NODE_DATA(0) allocated [mem 0xf57f3000-0xf57f5fff]
[    0.018333] NODE_DATA(1) allocated [mem 0x1ffffd000-0x1ffffffff]
[    0.018341] NODE_DATA(2) allocated [mem 0x2ffffd000-0x2ffffffff]
[    0.018349] NODE_DATA(3) allocated [mem 0x3ffffc000-0x3ffffefff]
[    0.018419] Zone ranges:
[    0.018421]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018424]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018426]   Normal   [mem 0x0000000100000000-0x00000003ffffefff]
[    0.018428] Movable zone start for each node
[    0.018430] Early memory node ranges
[    0.018432]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.018434]   node   0: [mem 0x0000000000100000-0x00000000f57f5fff]
[    0.018436]   node   1: [mem 0x0000000100000000-0x00000001ffffffff]
[    0.018437]   node   2: [mem 0x0000000200000000-0x00000002ffffffff]
[    0.018439]   node   3: [mem 0x0000000300000000-0x00000003ffffefff]
[    0.018881] Reserved but unavailable: 10348 pages
[    0.018884] Initmem setup node 0 [mem 0x0000000000001000-0x00000000f57f5fff]
[    0.018889] On node 0 totalpages: 1005460
[    0.018892]   DMA zone: 64 pages used for memmap
[    0.018894]   DMA zone: 21 pages reserved
[    0.018897]   DMA zone: 3998 pages, LIFO batch:0
[    0.019095]   DMA32 zone: 15648 pages used for memmap
[    0.019096]   DMA32 zone: 1001462 pages, LIFO batch:63
[    0.074478] Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
[    0.074483] On node 1 totalpages: 1048576
[    0.074485]   Normal zone: 16384 pages used for memmap
[    0.074487]   Normal zone: 1048576 pages, LIFO batch:63
[    0.143287] Initmem setup node 2 [mem 0x0000000200000000-0x00000002ffffffff]
[    0.143291] On node 2 totalpages: 1048576
[    0.143294]   Normal zone: 16384 pages used for memmap
[    0.143296]   Normal zone: 1048576 pages, LIFO batch:63
[    0.219896] Initmem setup node 3 [mem 0x0000000300000000-0x00000003ffffefff]
[    0.219901] On node 3 totalpages: 1048575
[    0.219903]   Normal zone: 16384 pages used for memmap
[    0.219905]   Normal zone: 1048575 pages, LIFO batch:63
[    0.288121] ACPI: PM-Timer IO Port: 0x908
[    0.288126] ACPI: Local APIC address 0xfee00000
[    0.288138] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.288158] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
[    0.288165] IOAPIC[1]: apic_id 5, version 17, address 0xfec10000, GSI 24-27
[    0.288170] IOAPIC[2]: apic_id 6, version 17, address 0xfec20000, GSI 28-31
[    0.288176] IOAPIC[3]: apic_id 7, version 17, address 0xfdc00000, GSI 32-35
[    0.288182] IOAPIC[4]: apic_id 8, version 17, address 0xfdc10000, GSI 36-39
[    0.288186] IOAPIC[5]: apic_id 9, version 17, address 0xfdc20000, GSI 40-43
[    0.288191] IOAPIC[6]: apic_id 10, version 17, address 0xfdc30000, GSI 44-47
[    0.288195] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.288202] ACPI: IRQ0 used by override.
[    0.288204] ACPI: IRQ9 used by override.
[    0.288209] Using ACPI (MADT) for SMP configuration information
[    0.288212] ACPI: SPCR: SPCR table version 1
[    0.288213] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.288217] ACPI: SPCR: console: uart,mmio,0x0,9600
[    0.288222] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.288265] [mem 0xf5800000-0xfdbfffff] available for PCI devices
[    0.288272] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.394045] random: get_random_bytes called from start_kernel+0x8a/0x439 with crng_init=0
[    0.394066] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:8 nr_node_ids:4
[    0.402609] percpu: Embedded 42 pages/cpu @(____ptrval____) s134168 r8192 d29672 u1048576
[    0.402626] pcpu-alloc: s134168 r8192 d29672 u1048576 alloc=1*2097152
[    0.402630] pcpu-alloc: [0] 0 4 [1] 1 5 [2] 2 6 [3] 3 7
[    0.402688] Built 4 zonelists, mobility grouping on.  Total pages: 4086302
[    0.402691] Policy zone: Normal
[    0.402695] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-dirty root=/dev/sda1 ro ignore_loglevel pci=earlydump console=ttyS0,115200
[    0.457372] AGP: Checking aperture...
[    0.464778] AGP: No AGP bridge found
[    0.464783] AGP: Node 0: aperture [bus addr 0xfc7e000000-0xfc7fffffff] (32MB)
[    0.464785] Aperture beyond 4GB. Ignoring.
[    0.464787] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.464789] AGP: Please enable the IOMMU option in the BIOS setup
[    0.464790] AGP: This costs you 64MB of RAM
[    0.464794] AGP: Mapping aperture over RAM [mem 0xe8000000-0xebffffff] (65536KB)
[    0.679034] Memory: 16190932K/16604748K available (10252K kernel code, 1306K rwdata, 1784K rodata, 940K init, 1628K bss, 413816K reserved, 0K cma-reserved)
[    0.679355] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=4
[    0.679542] rcu: Hierarchical RCU implementation.
[    0.679545] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[    0.679548] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.679621] NR_IRQS: 4352, nr_irqs: 896, preallocated irqs: 16
[    0.679942] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.680034] spurious 8259A interrupt: IRQ7.
[    0.683861] Console: colour VGA+ 80x25
[    1.593321] console [ttyS0] enabled
[    1.596871] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.608100] ACPI: Core revision 20180810
[    1.612268] APIC: Switch to symmetric I/O mode setup
[    1.617948] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    1.640229] tsc: Marking TSC unstable due to TSCs unsynchronized
[    1.646241] Calibrating delay loop (skipped), value calculated using timer frequency.. 4393.81 BogoMIPS (lpj=8787632)
[    1.650231] pid_max: default: 32768 minimum: 301
[    1.654314] Security Framework initialized
[    1.658278] AppArmor: AppArmor initialized
[    1.676110] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    1.685783] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    1.686472] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    1.690441] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    1.694753] mce: CPU supports 5 MCE banks
[    1.698247] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 4
[    1.702231] Last level dTLB entries: 4KB 512, 2MB 8, 4MB 4, 1GB 0
[    1.706234] Spectre V2 : Spectre mitigation: LFENCE not serializing, switching to generic retpoline
[    1.710231] Spectre V2 : Mitigation: Full generic retpoline
[    1.714231] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.718466] Freeing SMP alternatives memory: 32K
[    1.726229] smpboot: CPU0: AMD Opteron (tm) Processor 848 (family: 0xf, model: 0x5, stepping: 0x8)
[    1.726526] Performance Events: AMD PMU driver.
[    1.730236] ... version:                0
[    1.734231] ... bit width:              48
[    1.738231] ... generic registers:      4
[    1.742231] ... value mask:             0000ffffffffffff
[    1.746231] ... max period:             00007fffffffffff
[    1.750231] ... fixed-purpose events:   0
[    1.754231] ... event mask:             000000000000000f
[    1.758333] rcu: Hierarchical SRCU implementation.
[    1.762487] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.766553] smp: Bringing up secondary CPUs ...
[    1.770454] x86: Booting SMP configuration:
[    1.774238] .... node  #1, CPUs:      #1
[    1.858234] .... node  #2, CPUs:   #2
[    1.942234] .... node  #3, CPUs:   #3
[    2.022436] smp: Brought up 4 nodes, 4 CPUs
[    2.030232] smpboot: Max logical packages: 8
[    2.034233] smpboot: Total of 4 processors activated (17577.54 BogoMIPS)
[    2.044491] devtmpfs: initialized
[    2.046666] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.050264] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.054540] NET: Registered protocol family 16
[    2.058395] audit: initializing netlink subsys (disabled)
[    2.062416] cpuidle: using governor ladder
[    2.062416] audit: type=2000 audit(1540477862.448:1): state=initialized audit_enabled=0 res=1
[    2.074247] cpuidle: using governor menu
[    2.078240] node 0 link 0: io port [1000, 5fff]
[    2.082235] node 1 link 0: io port [6000, 6fff]
[    2.086233] TOM: 00000000f5800000 aka 3928M
[    2.090234] node 0 link 0: mmio [f5f00000, f7efffff]
[    2.094232] node 0 link 0: mmio [f5e00000, f5efffff]
[    2.098232] node 1 link 0: mmio [f7f00000, f7ffffff]
[    2.102232] node 0 link 0: mmio [a0000, bffff]
[    2.106232] node 0 link 0: mmio [fe000000, ffffffff]
[    2.110232] node 1 link 0: mmio [f8000000, fdffffff]
[    2.114232] TOM2: 0000000400000000 aka 16384M
[    2.118236] bus: [bus 00-03] on node 0 link 0
[    2.122232] bus: 00 [io  0x0000-0x5fff]
[    2.126231] bus: 00 [io  0x7000-0xffff]
[    2.130231] bus: 00 [mem 0xf5800000-0xf7efffff]
[    2.134231] bus: 00 [mem 0x000a0000-0x000bffff]
[    2.138231] bus: 00 [mem 0xfe000000-0xffffffff]
[    2.142231] bus: 00 [mem 0x400000000-0xfcffffffff]
[    2.146231] bus: [bus 04-08] on node 1 link 0
[    2.150231] bus: 04 [io  0x6000-0x6fff]
[    2.154231] bus: 04 [mem 0xf7f00000-0xfdffffff]
[    2.158279] ACPI: bus type PCI registered
[    2.162295] PCI: Using configuration type 1 for base access
[    2.166424] mtrr: your CPUs had inconsistent fixed MTRR settings
[    2.170233] mtrr: probably your BIOS does not setup all CPUs.
[    2.174231] mtrr: corrected configuration.
[    2.179484] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.182637] ACPI: Added _OSI(Module Device)
[    2.186237] ACPI: Added _OSI(Processor Device)
[    2.190232] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.194232] ACPI: Added _OSI(Processor Aggregator Device)
[    2.198233] ACPI: Added _OSI(Linux-Dell-Video)
[    2.202232] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.212621] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    2.216396] ACPI: Interpreter enabled
[    2.218241] ACPI: (supports S0 S5)
[    2.222233] ACPI: Using IOAPIC for interrupt routing
[    2.226274] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.239546] ACPI: PCI Root Bridge [CFG0] (domain 0000 [bus 00-03])
[    2.242241] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    2.246239] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.250248] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    2.258375] PCI host bridge to bus 0000:00
[    2.262236] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.266233] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    2.270233] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    2.274232] pci_bus 0000:00: root bus resource [io  0x03e0-0x0fff window]
[    2.278233] pci_bus 0000:00: root bus resource [io  0x1000-0x5fff window]
[    2.282233] pci_bus 0000:00: root bus resource [mem 0xf5f00000-0xf7efffff window]
[    2.286233] pci_bus 0000:00: root bus resource [mem 0xf5e00000-0xf5efffff window]
[    2.290233] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.294234] pci_bus 0000:00: root bus resource [bus 00-03]
[    2.298258] pci 0000:00:03.0: [1022:7460] type 01 class 0x060400
[    2.302233] pci 0000:00:03.0: config space:
[    2.306296] 00000000: 22 10 60 74 47 01 30 02 07 00 04 06 00 40 01 00
[    2.310232] 00000010: 00 00 00 00 00 00 00 00 00 01 01 40 40 40 00 22
[    2.314232] 00000020: f0 f5 d0 f7 f0 ff 00 00 00 00 00 00 00 00 00 00
[    2.318232] 00000030: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 09 00
[    2.322232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.326250] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.330232] 00000060: 00 00 04 06 00 00 00 00 00 00 00 00 00 00 00 00
[    2.334232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.338232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.342232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.346232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.350232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.354232] 000000c0: 08 f0 83 00 20 00 00 00 d0 00 00 00 22 00 01 00
[    2.358232] 000000d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.362232] 000000e0: 08 00 0d 00 08 00 0e 00 0f 00 15 00 00 00 00 00
[    2.366232] 000000f0: 08 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[    2.370411] pci 0000:00:04.0: [1022:7468] type 00 class 0x060100
[    2.374233] pci 0000:00:04.0: config space:
[    2.378303] 00000000: 22 10 68 74 07 00 20 02 05 00 01 06 00 00 80 00
[    2.382232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.386232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 03 32
[    2.390232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.394232] 00000040: 00 10 07 ff 01 00 00 80 0b f1 00 01 00 00 00 c0
[    2.398232] 00000050: 00 00 00 00 85 01 00 00 42 00 00 00 00 00 00 00
[    2.402232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.406232] 00000070: 11 0e 03 32 00 de 00 00 00 00 00 00 00 00 00 00
[    2.410232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.414232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.418232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.422232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.426232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.430232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.434232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.438232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.442363] pci 0000:00:04.1: [1022:7469] type 00 class 0x01018a
[    2.446233] pci 0000:00:04.1: config space:
[    2.450288] 00000000: 22 10 69 74 05 00 00 02 03 8a 01 01 00 00 00 00
[    2.454232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.458232] 00000020: 01 20 00 00 00 00 00 00 00 00 00 00 11 0e 04 32
[    2.462232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
[    2.466232] 00000040: 42 00 00 00 00 00 00 00 a8 a8 a8 a8 ff 00 ff ff
[    2.470232] 00000050: 03 03 03 03 00 00 00 00 00 00 00 00 00 00 00 00
[    2.474232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.478232] 00000070: 11 0e 04 32 00 00 00 00 00 00 00 00 00 00 00 00
[    2.482232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.486232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.490232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.494232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.498232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.502232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.506232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.510232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.514269] pci 0000:00:04.1: reg 0x20: [io  0x2000-0x200f]
[    2.522247] pci 0000:00:04.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    2.526233] pci 0000:00:04.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    2.530233] pci 0000:00:04.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    2.534232] pci 0000:00:04.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    2.538302] pci 0000:00:04.3: [1022:746b] type 00 class 0x068000
[    2.542233] pci 0000:00:04.3: config space:
[    2.546311] 00000000: 22 10 6b 74 00 00 80 02 05 00 80 06 00 40 00 00
[    2.550232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.554232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 05 32
[    2.558232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.562232] 00000040: 00 b9 09 64 00 00 00 00 20 04 50 00 00 00 00 00
[    2.566232] 00000050: 00 80 00 00 0f 00 a7 5b 01 09 00 00 00 00 00 00
[    2.570232] 00000060: 00 00 80 06 13 00 00 00 00 00 00 00 00 00 00 00
[    2.574232] 00000070: 00 20 00 00 02 00 00 00 00 00 00 00 11 0e 05 32
[    2.578232] 00000080: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
[    2.582236] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.586232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.590232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.594232] 000000c0: 00 00 00 00 f8 02 00 00 00 00 00 00 07 00 00 00
[    2.598232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.602232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.606232] 000000f0: e8 66 48 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.610369] pci 0000:00:07.0: [1022:7450] type 01 class 0x060400
[    2.614233] pci 0000:00:07.0: config space:
[    2.618266] 00000000: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
[    2.622232] 00000010: 00 00 00 00 00 00 00 00 00 02 02 40 51 51 20 22
[    2.626232] 00000020: e0 f7 e0 f7 e1 f5 e1 f5 00 00 00 00 00 00 00 00
[    2.630232] 00000030: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
[    2.634232] 00000040: 05 00 1f 00 01 00 00 00 02 0c 00 00 01 2c 00 00
[    2.638232] 00000050: 00 00 03 00 00 00 04 00 00 00 00 00 00 00 00 00
[    2.642232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.646232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.650232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.654232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.658232] 000000a0: 07 b8 83 00 38 00 03 00 0e 00 ff ff 02 00 ff ff
[    2.662232] 000000b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 05
[    2.666232] 000000c0: 08 00 47 00 20 00 11 11 20 00 00 00 22 04 35 00
[    2.670232] 000000d0: 02 00 35 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.674232] 000000e0: 08 08 0e 00 08 08 0f 00 0f 0f 16 00 00 00 00 00
[    2.678232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.682337] pci 0000:00:07.1: [1022:7451] type 00 class 0x080010
[    2.686233] pci 0000:00:07.1: config space:
[    2.690265] 00000000: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
[    2.694232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.698232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.702232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.706232] 00000040: 00 00 00 00 02 00 00 00 04 00 c1 fe 00 00 00 00
[    2.710232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.714232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.718232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.722232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.726232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.730232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.734232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.738232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.742232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.746232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.750232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.754335] pci 0000:00:08.0: [1022:7450] type 01 class 0x060400
[    2.758233] pci 0000:00:08.0: config space:
[    2.762266] 00000000: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
[    2.766232] 00000010: 00 00 00 00 00 00 00 00 00 03 03 40 f1 01 20 22
[    2.770232] 00000020: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
[    2.774232] 00000030: ff ff 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
[    2.778232] 00000040: 05 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
[    2.782232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.786232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.790232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.794232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.798232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.802232] 000000a0: 07 b8 83 00 40 00 03 00 0e 00 ff ff 02 00 ff ff
[    2.806232] 000000b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 06
[    2.810232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.814232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.818232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.822232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.826332] pci 0000:00:08.1: [1022:7451] type 00 class 0x080010
[    2.830233] pci 0000:00:08.1: config space:
[    2.834266] 00000000: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
[    2.838236] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.842232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.846232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.850232] 00000040: 00 00 00 00 02 00 00 00 04 00 c2 fe 00 00 00 00
[    2.854232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.858232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.862232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.866232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.870232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.874232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.878232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.882232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.886232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.890232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.894232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.898348] pci 0000:00:18.0: [1022:1100] type 00 class 0x060000
[    2.902233] pci 0000:00:18.0: config space:
[    2.906249] 00000000: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
[    2.910232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.914232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.918232] 00000030: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
[    2.922232] 00000040: 01 01 0d 00 08 08 01 00 08 04 01 00 04 04 09 00
[    2.926232] 00000050: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
[    2.930232] 00000060: 30 00 03 00 e4 00 00 00 00 c0 00 0f 1c 00 00 00
[    2.934232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.938232] 00000080: 08 a0 01 21 20 00 11 11 22 04 75 80 02 00 00 00
[    2.942232] 00000090: 56 02 51 02 00 00 03 00 07 00 00 00 00 00 00 00
[    2.946232] 000000a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    2.950232] 000000b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    2.954232] 000000c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    2.958232] 000000d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    2.962232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.966232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.970317] pci 0000:00:18.1: [1022:1101] type 00 class 0x060000
[    2.974233] pci 0000:00:18.1: config space:
[    2.978249] 00000000: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
[    2.982232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.986232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.990232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.994232] 00000040: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
[    2.998232] 00000050: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
[    3.002232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.006232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.010232] 00000080: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
[    3.014232] 00000090: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
[    3.018232] 000000a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
[    3.022232] 000000b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
[    3.026232] 000000c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
[    3.030232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.034232] 000000e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
[    3.038232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.042307] pci 0000:00:18.2: [1022:1102] type 00 class 0x060000
[    3.046233] pci 0000:00:18.2: config space:
[    3.050249] 00000000: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.054232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.058232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.062232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.066232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.070232] 00000050: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
[    3.074232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.078232] 00000070: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
[    3.082232] 00000080: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
[    3.086232] 00000090: 00 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
[    3.090232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.094236] 000000b0: 8c 84 ab 7d 4a 00 00 00 6b 38 ff 88 e7 f8 23 fc
[    3.098232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.102232] 000000d0: 71 ac ed 6c 48 e0 f6 84 66 8e eb fa e9 12 78 b0
[    3.106232] 000000e0: 38 e4 54 6e 4c f4 72 82 66 c6 f7 eb 68 1b 7d 9a
[    3.110232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.114306] pci 0000:00:18.3: [1022:1103] type 00 class 0x060000
[    3.118233] pci 0000:00:18.3: config space:
[    3.122249] 00000000: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.126232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.130232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.134232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.138232] 00000040: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
[    3.142232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 f8 ef 3c
[    3.146232] 00000060: f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.150232] 00000070: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
[    3.154232] 00000080: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.158232] 00000090: 02 00 00 00 74 00 00 00 f0 7f d5 7f 00 00 00 00
[    3.162232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.166232] 000000b0: 00 00 00 00 00 00 00 00 38 00 00 e0 c1 00 00 00
[    3.170232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.174232] 000000d0: 00 00 00 00 07 07 e2 04 00 00 00 00 25 25 25 00
[    3.178232] 000000e0: 00 00 00 00 20 15 59 00 1f 01 00 00 00 00 00 00
[    3.182232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.186306] pci 0000:00:19.0: [1022:1100] type 00 class 0x060000
[    3.190233] pci 0000:00:19.0: config space:
[    3.194251] 00000000: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
[    3.198232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.202232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.206232] 00000030: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
[    3.210232] 00000040: 04 04 01 00 01 01 0d 00 08 08 05 00 04 08 01 00
[    3.214232] 00000050: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
[    3.218232] 00000060: 31 00 03 00 e4 00 00 00 00 c0 00 0f 04 00 00 00
[    3.222232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.226232] 00000080: 08 a0 01 21 20 00 11 11 22 04 75 80 02 00 00 00
[    3.230232] 00000090: 56 02 51 02 00 04 08 00 07 00 00 00 00 00 00 00
[    3.234232] 000000a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    3.238232] 000000b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    3.242232] 000000c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    3.246232] 000000d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    3.250232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.254232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.258322] pci 0000:00:19.1: [1022:1101] type 00 class 0x060000
[    3.262233] pci 0000:00:19.1: config space:
[    3.266251] 00000000: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.270232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.274232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.278232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.282232] 00000040: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
[    3.286232] 00000050: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
[    3.290232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.294232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.298232] 00000080: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
[    3.302232] 00000090: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
[    3.306232] 000000a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
[    3.310232] 000000b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
[    3.314232] 000000c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
[    3.318232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.322232] 000000e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
[    3.326232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.330302] pci 0000:00:19.2: [1022:1102] type 00 class 0x060000
[    3.334233] pci 0000:00:19.2: config space:
[    3.338251] 00000000: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.342232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.346232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.350236] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.354232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.358232] 00000050: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
[    3.362232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.366232] 00000070: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
[    3.370232] 00000080: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
[    3.374232] 00000090: 00 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
[    3.378232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.382232] 000000b0: b8 f4 0b b9 4a 00 00 00 cb ff a6 c3 ef e0 19 e0
[    3.386232] 000000c0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.390232] 000000d0: 18 64 6d 4b 9a 29 6c 79 22 a2 41 d9 5f 5e 70 3f
[    3.394232] 000000e0: 98 a6 24 26 95 74 2c 3d 23 82 48 49 1f 5a 30 ae
[    3.398232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.402307] pci 0000:00:19.3: [1022:1103] type 00 class 0x060000
[    3.406233] pci 0000:00:19.3: config space:
[    3.410251] 00000000: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.414232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.418232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.422232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.426232] 00000040: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
[    3.430232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.434232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.438238] 00000070: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
[    3.442232] 00000080: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.446232] 00000090: 02 00 00 00 74 00 00 00 f0 bf de ab 00 00 00 00
[    3.450232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.454232] 000000b0: 00 00 00 00 00 00 00 00 0f 00 00 80 78 f0 00 00
[    3.458232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.462232] 000000d0: 00 00 00 00 07 07 e2 04 00 00 00 00 25 25 25 00
[    3.466232] 000000e0: 00 00 00 00 20 16 59 00 1f 01 00 00 00 00 00 00
[    3.470232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.474308] pci 0000:00:1a.0: [1022:1100] type 00 class 0x060000
[    3.478233] pci 0000:00:1a.0: config space:
[    3.482253] 00000000: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
[    3.486232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.490232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.494232] 00000030: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
[    3.498232] 00000040: 08 04 01 00 04 04 09 00 01 01 0d 00 08 08 01 00
[    3.502232] 00000050: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
[    3.506232] 00000060: 32 00 03 00 e4 00 00 00 00 c0 00 0f 04 00 00 00
[    3.510232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.514232] 00000080: 08 a0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
[    3.518232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.522232] 000000a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    3.526232] 000000b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    3.530232] 000000c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    3.534232] 000000d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    3.538232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.542232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.546317] pci 0000:00:1a.1: [1022:1101] type 00 class 0x060000
[    3.550233] pci 0000:00:1a.1: config space:
[    3.554253] 00000000: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.558232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.562232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.566232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.570232] 00000040: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
[    3.574232] 00000050: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
[    3.578232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.582232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.586232] 00000080: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
[    3.590232] 00000090: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
[    3.594232] 000000a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
[    3.598232] 000000b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
[    3.602232] 000000c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
[    3.606236] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.610232] 000000e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
[    3.614232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.618307] pci 0000:00:1a.2: [1022:1102] type 00 class 0x060000
[    3.622233] pci 0000:00:1a.2: config space:
[    3.626253] 00000000: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.630232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.634232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.638232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.642232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.646232] 00000050: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
[    3.650232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.654232] 00000070: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
[    3.658232] 00000080: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
[    3.662232] 00000090: 00 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
[    3.666232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.670232] 000000b0: 1e ec 68 f4 4a 00 00 00 1c be 82 07 4b 1e c7 c1
[    3.674232] 000000c0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.678232] 000000d0: 9c d1 4e a7 15 56 90 e2 e5 a2 54 7e 16 2c b6 0c
[    3.682232] 000000e0: 01 4d aa 26 03 57 42 ca a0 a1 2e 2d bb 34 af 1a
[    3.686232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.690310] pci 0000:00:1a.3: [1022:1103] type 00 class 0x060000
[    3.694233] pci 0000:00:1a.3: config space:
[    3.698253] 00000000: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.702232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.706232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.710232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.714232] 00000040: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
[    3.718232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 74 3c 98
[    3.722232] 00000060: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.726232] 00000070: 11 01 02 51 11 80 00 50 00 39 00 08 2b 23 00 00
[    3.730232] 00000080: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.734232] 00000090: 02 00 00 00 74 00 00 00 e0 07 1a 5f 00 00 00 00
[    3.738232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.742232] 000000b0: 00 00 00 00 00 00 00 00 23 00 00 20 00 00 00 00
[    3.746232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.750232] 000000d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 25 00
[    3.754232] 000000e0: 00 00 00 00 20 12 5d 00 1f 01 00 00 00 00 00 00
[    3.758232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.762309] pci 0000:00:1b.0: [1022:1100] type 00 class 0x060000
[    3.766233] pci 0000:00:1b.0: config space:
[    3.770251] 00000000: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
[    3.774232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.778232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.782232] 00000030: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
[    3.786232] 00000040: 08 08 05 00 04 08 01 00 04 04 01 00 01 01 0d 00
[    3.790232] 00000050: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
[    3.794232] 00000060: 33 00 03 00 e4 00 00 00 00 c0 00 0f 08 00 00 00
[    3.798232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.802232] 00000080: 08 a0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
[    3.806232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.810232] 000000a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    3.814232] 000000b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    3.818232] 000000c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
[    3.822232] 000000d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
[    3.826232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.830232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.834315] pci 0000:00:1b.1: [1022:1101] type 00 class 0x060000
[    3.838233] pci 0000:00:1b.1: config space:
[    3.842251] 00000000: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.846232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.850232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.854232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.858232] 00000040: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
[    3.862236] 00000050: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
[    3.866232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.870232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.874232] 00000080: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
[    3.878232] 00000090: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
[    3.882232] 000000a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
[    3.886232] 000000b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
[    3.890232] 000000c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
[    3.894232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.898232] 000000e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
[    3.902232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.906305] pci 0000:00:1b.2: [1022:1102] type 00 class 0x060000
[    3.910233] pci 0000:00:1b.2: config space:
[    3.914251] 00000000: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.918232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.922232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.926232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.930232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.934232] 00000050: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
[    3.938232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.942232] 00000070: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
[    3.946232] 00000080: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
[    3.950232] 00000090: 02 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
[    3.954232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.958232] 000000b0: c9 dc c7 2f 4b 00 00 00 f8 73 d3 39 1a b0 3f 00
[    3.962232] 000000c0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.966232] 000000d0: a6 2f 2b 28 02 6e cd 6a 9a 6f 05 62 d2 b4 66 05
[    3.970232] 000000e0: 73 0d 40 98 02 8a ee 3c d8 35 84 2a bb d4 72 a1
[    3.974232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.978306] pci 0000:00:1b.3: [1022:1103] type 00 class 0x060000
[    3.982233] pci 0000:00:1b.3: config space:
[    3.986251] 00000000: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
[    3.990232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.994232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.998232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.002232] 00000040: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
[    4.006232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 80 01 07 f3
[    4.010232] 00000060: 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.014232] 00000070: 11 01 02 51 11 80 00 50 00 39 00 08 2b 23 00 00
[    4.018232] 00000080: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.022232] 00000090: 02 00 00 00 74 00 00 00 50 42 09 70 00 00 00 00
[    4.026232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.030232] 000000b0: 00 00 00 00 00 00 00 00 33 00 00 20 00 00 00 00
[    4.034232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.038232] 000000d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 25 00
[    4.042232] 000000e0: 00 00 00 00 20 16 5b 00 1f 01 00 00 00 00 00 00
[    4.046232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.050335] pci_bus 0000:01: extended config space not accessible
[    4.054271] pci 0000:01:00.0: [1022:7464] type 00 class 0x0c0310
[    4.058233] pci 0000:01:00.0: config space:
[    4.062309] 00000000: 22 10 64 74 17 01 80 02 0b 10 03 0c 00 40 80 00
[    4.066232] 00000010: 00 00 df f7 00 00 00 00 00 00 00 00 00 00 00 00
[    4.070232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 02 32
[    4.074232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 50
[    4.078232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.082232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.086232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.090232] 00000070: 11 0e 02 32 00 00 00 00 00 00 00 00 00 00 00 00
[    4.094232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.098232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.102232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.106232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.110232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.114232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.118236] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.122232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.126250] pci 0000:01:00.0: reg 0x10: [mem 0xf7df0000-0xf7df0fff]
[    4.130349] pci 0000:01:00.1: [1022:7464] type 00 class 0x0c0310
[    4.134233] pci 0000:01:00.1: config space:
[    4.138309] 00000000: 22 10 64 74 17 01 80 02 0b 10 03 0c 00 40 00 00
[    4.142232] 00000010: 00 00 de f7 00 00 00 00 00 00 00 00 00 00 00 00
[    4.146232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 02 32
[    4.150232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 50
[    4.154232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.158232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.162232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.166232] 00000070: 11 0e 02 32 00 00 00 00 00 00 00 00 00 00 00 00
[    4.170232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.174232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.178232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.182232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.186232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.190232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.194232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.198232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.202249] pci 0000:01:00.1: reg 0x10: [mem 0xf7de0000-0xf7de0fff]
[    4.206359] pci 0000:01:02.0: [0e11:b203] type 00 class 0x088000
[    4.210233] pci 0000:01:02.0: config space:
[    4.214322] 00000000: 11 0e 03 b2 03 01 90 02 01 00 80 08 00 00 80 00
[    4.218232] 00000010: 01 48 00 00 00 00 db f7 00 00 00 00 00 00 00 00
[    4.222232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 06 b2
[    4.226232] 00000030: 00 00 00 00 f0 00 00 00 00 00 00 00 07 01 00 00
[    4.230232] 00000040: 00 7f 3b 7c 00 c0 40 00 00 00 00 00 0f 01 0f 00
[    4.234232] 00000050: a6 81 f0 77 04 cb 00 00 f9 f7 fc 77 01 00 00 00
[    4.238232] 00000060: ff 00 ff ff 00 00 00 00 00 ff 00 00 00 00 00 00
[    4.242232] 00000070: 00 00 00 01 00 00 81 00 00 00 00 00 00 00 00 00
[    4.246232] 00000080: 00 00 00 00 00 00 00 00 08 00 00 03 43 50 51 00
[    4.250232] 00000090: 02 02 00 54 02 00 00 5f 00 00 00 01 00 00 00 00
[    4.254232] 000000a0: 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 03
[    4.258232] 000000b0: 00 00 00 88 00 00 00 00 f0 01 10 51 fa 48 30 00
[    4.262232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.266232] 000000d0: 01 00 00 00 00 00 00 00 01 00 00 00 00 1b 00 00
[    4.270232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.274232] 000000f0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.278250] pci 0000:01:02.0: reg 0x10: [io  0x4800-0x48ff]
[    4.282242] pci 0000:01:02.0: reg 0x14: [mem 0xf7db0000-0xf7db01ff]
[    4.286380] pci 0000:01:02.2: [0e11:b204] type 00 class 0x088000
[    4.290233] pci 0000:01:02.2: config space:
[    4.294323] 00000000: 11 0e 04 b2 97 01 90 02 01 00 80 08 10 40 80 00
[    4.298232] 00000010: 01 40 00 00 00 00 da f7 00 00 d9 f7 00 00 d0 f7
[    4.302232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 06 b2
[    4.306232] 00000030: 00 00 00 00 f0 00 00 00 00 00 00 00 0a 02 00 00
[    4.310232] 00000040: 00 0d 00 00 00 00 00 00 00 00 00 00 0a 01 15 12
[    4.314232] 00000050: 02 e0 7f 00 05 00 33 00 04 00 00 00 00 00 60 00
[    4.318232] 00000060: 00 00 04 00 00 00 00 00 85 60 56 05 59 28 82 00
[    4.322232] 00000070: 00 08 10 01 03 03 40 00 ec 01 00 80 00 00 00 00
[    4.326232] 00000080: fc 02 00 00 44 3a 01 00 0a 2e e9 5c 49 05 00 00
[    4.330232] 00000090: b8 0b 00 00 03 03 00 00 00 00 00 00 00 00 00 00
[    4.334232] 000000a0: 04 06 01 00 80 00 00 00 20 00 00 00 00 00 00 00
[    4.338232] 000000b0: 00 00 00 00 00 00 e7 81 ff e5 0e 00 00 00 00 00
[    4.342232] 000000c0: 01 00 00 00 00 00 02 00 01 00 00 00 00 00 02 00
[    4.346232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.350232] 000000e0: 00 00 00 00 0b 00 00 00 00 00 00 00 0b 00 00 00
[    4.354232] 000000f0: 01 00 02 c8 00 01 00 00 00 00 00 00 00 00 00 00
[    4.358252] pci 0000:01:02.2: reg 0x10: [io  0x4000-0x40ff]
[    4.362243] pci 0000:01:02.2: reg 0x14: [mem 0xf7da0000-0xf7da07ff]
[    4.366243] pci 0000:01:02.2: reg 0x18: [mem 0xf7d90000-0xf7d91fff]
[    4.370243] pci 0000:01:02.2: reg 0x1c: [mem 0xf7d00000-0xf7d7ffff]
[    4.374267] pci 0000:01:02.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    4.378270] pci 0000:01:02.2: PME# supported from D0 D3hot D3cold
[    4.382305] pci 0000:01:03.0: [1002:4752] type 00 class 0x030000
[    4.386233] pci 0000:01:03.0: config space:
[    4.390317] 00000000: 02 10 52 47 87 00 90 02 27 00 00 03 10 40 00 00
[    4.394232] 00000010: 00 00 00 f6 01 44 00 00 00 00 ff f5 00 00 00 00
[    4.398232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 1e 00
[    4.402232] 00000030: 00 00 00 00 5c 00 00 00 00 00 00 00 ff 00 08 00
[    4.406232] 00000040: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.410232] 00000050: 02 5c 10 00 01 00 00 ff 00 00 00 00 01 00 02 06
[    4.414232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.418232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.422232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.426232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.430232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.434232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.438232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.442232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.446232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.450232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.454250] pci 0000:01:03.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
[    4.458242] pci 0000:01:03.0: reg 0x14: [io  0x4400-0x44ff]
[    4.462242] pci 0000:01:03.0: reg 0x18: [mem 0xf5ff0000-0xf5ff0fff]
[    4.466271] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    4.470267] pci 0000:01:03.0: supports D1 D2
[    4.474327] pci 0000:00:03.0: PCI bridge to [bus 01]
[    4.478237] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
[    4.482235] pci 0000:00:03.0:   bridge window [mem 0xf5f00000-0xf7dfffff]
[    4.486251] pci_bus 0000:02: extended config space not accessible
[    4.490272] pci 0000:02:04.0: [0e11:b178] type 00 class 0x010400
[    4.494233] pci 0000:02:04.0: config space:
[    4.498276] 00000000: 11 0e 78 b1 57 01 b0 02 01 00 04 01 10 47 00 00
[    4.502232] 00000010: 04 00 ec f7 00 00 00 00 01 50 00 00 0c 00 ef f5
[    4.506232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 80 40
[    4.510232] 00000030: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 00 00
[    4.514232] 00000040: 00 00 00 00 00 00 00 00 ff 01 07 00 00 00 00 00
[    4.518232] 00000050: d2 03 00 00 ff ff 37 6d 29 0a 00 00 60 00 00 00
[    4.522232] 00000060: c3 01 00 00 00 00 00 a0 01 00 00 e0 00 00 00 00
[    4.526232] 00000070: 00 00 00 00 00 00 10 80 00 00 00 00 00 00 00 00
[    4.530232] 00000080: 00 00 00 00 01 00 00 00 03 00 fc ff 00 00 7c 40
[    4.534232] 00000090: 01 ff ff ff 00 00 00 98 01 c0 ff ff 00 00 f7 ff
[    4.538232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.542232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.546232] 000000c0: 01 cc 02 02 00 00 00 00 10 00 00 00 05 dc 82 00
[    4.550232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 30 00
[    4.554232] 000000e0: 20 02 81 05 00 00 00 00 00 00 00 00 00 00 00 00
[    4.558232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.562245] pci 0000:02:04.0: reg 0x10: [mem 0xf7ec0000-0xf7efffff 64bit]
[    4.566237] pci 0000:02:04.0: reg 0x18: [io  0x5000-0x50ff]
[    4.570240] pci 0000:02:04.0: reg 0x1c: [mem 0xf5ef0000-0xf5ef3fff 64bit pref]
[    4.574243] pci 0000:02:04.0: reg 0x30: [mem 0x00000000-0x00003fff pref]
[    4.578261] pci 0000:02:04.0: supports D1
[    4.582296] pci 0000:02:06.0: [14e4:1648] type 00 class 0x020000
[    4.586233] pci 0000:02:06.0: config space:
[    4.590277] 00000000: e4 14 48 16 56 01 b0 02 10 00 00 02 10 40 80 00
[    4.594232] 00000010: 04 00 eb f7 00 00 00 00 00 00 00 00 00 00 00 00
[    4.598232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e d0 00
[    4.602232] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 40 00
[    4.606232] 00000040: 07 48 08 00 30 02 43 04 01 50 02 c0 00 21 00 64
[    4.610232] 00000050: 03 58 7c 00 f3 db e7 f7 05 00 86 00 e0 f7 b3 f6
[    4.614232] 00000060: f7 ff f6 fb fa fb 00 00 00 00 00 21 00 00 00 00
[    4.618232] 00000070: 02 32 00 00 c6 00 00 00 14 04 00 00 00 00 00 00
[    4.622232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 fe 90 68 00
[    4.626232] 00000090: 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.630236] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.634232] 000000b0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
[    4.638232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.642232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.646232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.650232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.654245] pci 0000:02:06.0: reg 0x10: [mem 0xf7eb0000-0xf7ebffff 64bit]
[    4.658286] pci 0000:02:06.0: PME# supported from D3hot D3cold
[    4.662312] pci 0000:02:06.1: [14e4:1648] type 00 class 0x020000
[    4.666233] pci 0000:02:06.1: config space:
[    4.670277] 00000000: e4 14 48 16 56 01 b0 02 10 00 00 02 10 40 80 00
[    4.674232] 00000010: 04 00 ea f7 00 00 00 00 00 00 00 00 00 00 00 00
[    4.678232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e d0 00
[    4.682232] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 07 02 40 00
[    4.686232] 00000040: 07 48 08 00 31 02 43 04 01 50 02 c0 00 21 00 64
[    4.690232] 00000050: 03 58 34 00 27 a9 9b fe 05 00 86 00 7c 7f 56 85
[    4.694232] 00000060: da dd 9a e4 3d 99 00 00 00 00 00 21 00 00 00 00
[    4.698232] 00000070: 02 32 00 00 c6 00 00 00 14 04 00 00 00 00 00 00
[    4.702232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 fe 90 28 00
[    4.706232] 00000090: 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.710232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.714232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.718232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.722232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.726232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.730232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.734245] pci 0000:02:06.1: reg 0x10: [mem 0xf7ea0000-0xf7eaffff 64bit]
[    4.738286] pci 0000:02:06.1: PME# supported from D3hot D3cold
[    4.742324] pci 0000:00:07.0: PCI bridge to [bus 02]
[    4.746236] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    4.750234] pci 0000:00:07.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    4.754235] pci 0000:00:07.0:   bridge window [mem 0xf5e00000-0xf5efffff 64bit pref]
[    4.758246] pci_bus 0000:03: extended config space not accessible
[    4.762388] pci 0000:00:08.0: PCI bridge to [bus 03]
[    4.767120] ACPI: PCI Root Bridge [CFG1] (domain 0000 [bus 04-08])
[    4.770235] acpi PNP0A03:01: _OSC: OS supports [Segments MSI]
[    4.774236] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    4.778237] acpi PNP0A03:01: [Firmware Bug]: no _PXM; falling back to node 1 from hardware (may be inconsistent with ACPI node numbers)
[    4.782244] acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    4.790635] PCI host bridge to bus 0000:04
[    4.794234] pci_bus 0000:04: root bus resource [io  0x6000-0x6fff window]
[    4.798233] pci_bus 0000:04: root bus resource [mem 0xf7f00000-0xf7ffffff window]
[    4.802233] pci_bus 0000:04: root bus resource [bus 04-08]
[    4.806248] pci 0000:04:09.0: [1022:7450] type 01 class 0x060400
[    4.810232] pci 0000:04:09.0: config space:
[    4.814279] 00000000: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
[    4.818232] 00000010: 00 00 00 00 00 00 00 00 04 05 05 40 f1 01 20 22
[    4.822232] 00000020: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
[    4.826232] 00000030: ff ff 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
[    4.830232] 00000040: 05 00 1f 00 01 00 00 00 02 0c 00 00 01 2c 00 00
[    4.834232] 00000050: 00 00 03 00 00 00 04 00 00 00 00 00 00 00 00 00
[    4.838232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.842232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.846232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.850232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.854232] 000000a0: 07 b8 c3 00 48 04 03 00 0e 00 ff ff 02 00 ff ff
[    4.858232] 000000b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 07
[    4.862232] 000000c0: 08 00 49 00 20 00 11 00 50 00 00 77 22 04 35 00
[    4.866232] 000000d0: 02 04 35 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.870232] 000000e0: 08 08 0e 00 08 08 0d 00 0f 0f 15 00 00 00 00 00
[    4.874232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.878346] pci 0000:04:09.1: [1022:7451] type 00 class 0x080010
[    4.882233] pci 0000:04:09.1: config space:
[    4.886283] 00000000: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
[    4.890232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.894232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.898232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.902232] 00000040: 00 00 00 00 02 00 00 00 04 00 c0 fd 00 00 00 00
[    4.906232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.910232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.914232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.918232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.922232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.926232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.930232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.934232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.938232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.942232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.946232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.950338] pci 0000:04:0a.0: [1022:7450] type 01 class 0x060400
[    4.954233] pci 0000:04:0a.0: config space:
[    4.958279] 00000000: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
[    4.962232] 00000010: 00 00 00 00 00 00 00 00 04 06 06 40 61 61 20 22
[    4.966232] 00000020: f0 f7 f0 f7 f1 ff 01 00 00 00 00 00 00 00 00 00
[    4.970232] 00000030: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
[    4.974232] 00000040: 05 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
[    4.978232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.982232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.986232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.990232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.994232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.998232] 000000a0: 07 b8 c3 00 50 04 03 00 0e 00 ff ff 02 00 ff ff
[    5.002232] 000000b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 08
[    5.006232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.010232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.014232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.018232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.022337] pci 0000:04:0a.1: [1022:7451] type 00 class 0x080010
[    5.026233] pci 0000:04:0a.1: config space:
[    5.030279] 00000000: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
[    5.034232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.038232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.042232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.046232] 00000040: 00 00 00 00 02 00 00 00 04 00 c1 fd 00 00 00 00
[    5.050232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.054232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.058232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.062232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.066232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.070232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.074232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.078232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.082232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.086232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.090232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.094337] pci 0000:04:0b.0: [1022:7450] type 01 class 0x060400
[    5.098233] pci 0000:04:0b.0: config space:
[    5.102269] 00000000: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
[    5.106232] 00000010: 00 00 00 00 00 00 00 00 04 07 07 40 f1 01 20 22
[    5.110232] 00000020: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
[    5.114232] 00000030: ff ff 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
[    5.118232] 00000040: 05 00 1f 00 01 00 00 00 02 0c 00 00 01 2c 00 00
[    5.122232] 00000050: 00 00 03 00 00 00 05 00 00 00 00 00 00 00 00 00
[    5.126232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.130232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.134232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.138232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.142236] 000000a0: 07 b8 83 00 58 04 03 00 0e 00 ff ff 02 00 ff ff
[    5.146232] 000000b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 09
[    5.150232] 000000c0: 08 00 4b 00 20 00 11 11 20 00 00 00 22 04 35 00
[    5.154232] 000000d0: 02 04 35 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.158232] 000000e0: 08 08 0f 00 08 08 0f 00 0f 0f 17 00 00 00 00 00
[    5.162232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.166330] pci 0000:04:0b.1: [1022:7451] type 00 class 0x080010
[    5.170233] pci 0000:04:0b.1: config space:
[    5.174269] 00000000: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
[    5.178232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.182232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.186232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.190232] 00000040: 00 00 00 00 02 00 00 00 04 00 c2 fd 00 00 00 00
[    5.194232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.198232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.202232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.206232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.210232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.214232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.218232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.222232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.226232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.230232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.234232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.238325] pci 0000:04:0c.0: [1022:7450] type 01 class 0x060400
[    5.242233] pci 0000:04:0c.0: config space:
[    5.246269] 00000000: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
[    5.250232] 00000010: 00 00 00 00 00 00 00 00 04 08 08 40 f1 01 20 22
[    5.254232] 00000020: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
[    5.258232] 00000030: ff ff 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
[    5.262232] 00000040: 05 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
[    5.266232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.270232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.274232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.278232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.282232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.286232] 000000a0: 07 b8 83 00 60 04 03 00 0e 00 ff ff 02 00 ff ff
[    5.290232] 000000b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 0a
[    5.294232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.298232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.302232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.306232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.310328] pci 0000:04:0c.1: [1022:7451] type 00 class 0x080010
[    5.314233] pci 0000:04:0c.1: config space:
[    5.318269] 00000000: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
[    5.322232] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.326232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.330232] 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.334232] 00000040: 00 00 00 00 02 00 00 00 04 00 c3 fd 00 00 00 00
[    5.338232] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.342232] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.346232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.350232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.354232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.358232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.362232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.366232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.370232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.374232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.378232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.382352] pci_bus 0000:05: extended config space not accessible
[    5.386333] pci 0000:04:09.0: PCI bridge to [bus 05]
[    5.390258] pci_bus 0000:06: extended config space not accessible
[    5.394329] pci 0000:06:0e.0: [117c:0030] type 00 class 0x010000
[    5.398237] pci 0000:06:0e.0: config space:
[    5.402284] 00000000: 7c 11 30 00 57 01 30 02 08 00 00 01 10 40 80 00
[    5.406232] 00000010: 01 60 00 00 04 00 fc f7 00 00 00 00 04 00 f8 f7
[    5.410232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 7c 11 13 80
[    5.414232] 00000030: 00 00 00 00 50 00 00 00 00 00 00 00 07 01 10 06
[    5.418232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.422232] 00000050: 01 58 02 06 00 00 00 00 05 68 80 00 00 00 00 00
[    5.426232] 00000060: 00 00 00 00 00 00 00 00 07 00 14 00 70 06 43 06
[    5.430232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.434232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.438232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.442232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.446232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.450232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.454232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.458232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.462232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.466244] pci 0000:06:0e.0: reg 0x10: [io  0x6000-0x60ff]
[    5.470242] pci 0000:06:0e.0: reg 0x14: [mem 0xf7fc0000-0xf7ffffff 64bit]
[    5.474242] pci 0000:06:0e.0: reg 0x1c: [mem 0xf7f80000-0xf7fbffff 64bit]
[    5.478244] pci 0000:06:0e.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    5.482265] pci 0000:06:0e.0: supports D1 D2
[    5.486298] pci 0000:06:0e.1: [117c:0030] type 00 class 0x010000
[    5.490233] pci 0000:06:0e.1: config space:
[    5.494283] 00000000: 7c 11 30 00 57 01 30 02 08 00 00 01 10 40 80 00
[    5.498232] 00000010: 01 64 00 00 04 00 f4 f7 00 00 00 00 04 00 f0 f7
[    5.502232] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 7c 11 13 80
[    5.506232] 00000030: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 10 06
[    5.510232] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.514232] 00000050: 01 58 02 06 00 00 00 00 05 68 80 00 00 00 00 00
[    5.518232] 00000060: 00 00 00 00 00 00 00 00 07 00 14 00 71 06 43 06
[    5.522232] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.526232] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.530232] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.534232] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.538232] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.542232] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.546232] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.550232] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.554232] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.558244] pci 0000:06:0e.1: reg 0x10: [io  0x6400-0x64ff]
[    5.562242] pci 0000:06:0e.1: reg 0x14: [mem 0xf7f40000-0xf7f7ffff 64bit]
[    5.566242] pci 0000:06:0e.1: reg 0x1c: [mem 0xf7f00000-0xf7f3ffff 64bit]
[    5.570244] pci 0000:06:0e.1: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    5.574264] pci 0000:06:0e.1: supports D1 D2
[    5.582234] pci 0000:04:0a.0: PCI bridge to [bus 06]
[    5.586236] pci 0000:04:0a.0:   bridge window [io  0x6000-0x6fff]
[    5.590234] pci 0000:04:0a.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    5.594251] pci_bus 0000:07: extended config space not accessible
[    5.602338] pci 0000:04:0b.0: PCI bridge to [bus 07]
[    5.606253] pci_bus 0000:08: extended config space not accessible
[    5.610387] pci 0000:04:0c.0: PCI bridge to [bus 08]
[    5.614397] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 *7 10 11)
[    5.618289] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 7 *10 11)
[    5.622287] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 *11)
[    5.626287] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *5 7 10 11)
[    5.630554] pci 0000:01:03.0: vgaarb: setting as boot VGA device
[    5.634229] pci 0000:01:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    5.634251] pci 0000:01:03.0: vgaarb: bridge control possible
[    5.638248] vgaarb: loaded
[    5.641052] SCSI subsystem initialized
[    5.642242] ACPI: bus type USB registered
[    5.646262] usbcore: registered new interface driver usbfs
[    5.650244] usbcore: registered new interface driver hub
[    5.654267] usbcore: registered new device driver usb
[    5.658265] EDAC MC: Ver: 3.0.0
[    5.662355] PCI: Using ACPI for IRQ routing
[    5.666239] PCI: pci_cache_line_size set to 64 bytes
[    5.670322] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    5.674234] e820: reserve RAM buffer [mem 0xf57f6800-0xf7ffffff]
[    5.678233] e820: reserve RAM buffer [mem 0x3fffff000-0x3ffffffff]
[    5.682464] clocksource: Switched to clocksource refined-jiffies
[    5.686653] AppArmor: AppArmor Filesystem Enabled
[    5.690260] pnp: PnP ACPI init
[    5.694508] system 00:00: [io  0x0230-0x0233] has been reserved
[    5.698235] system 00:00: [io  0x0260-0x0267] has been reserved
[    5.702234] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    5.706234] system 00:00: [io  0x0800-0x081f] has been reserved
[    5.710235] system 00:00: [io  0x0900-0x0903] has been reserved
[    5.714235] system 00:00: [io  0x0904-0x0907] has been reserved
[    5.718235] system 00:00: [io  0x0908-0x090b] has been reserved
[    5.722235] system 00:00: [io  0x090c-0x092e] has been reserved
[    5.726236] system 00:00: [io  0x092f] has been reserved
[    5.730236] system 00:00: [io  0x0930-0x09ff] has been reserved
[    5.734240] system 00:00: [io  0x0c80-0x0c87] has been reserved
[    5.738237] system 00:00: [io  0x0cf9] could not be reserved
[    5.742237] system 00:00: [io  0x02f8-0x02ff] has been reserved
[    5.746244] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    5.750285] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    5.754265] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    5.758461] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    5.762402] pnp 00:04: [dma 2]
[    5.766269] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    5.770441] pnp: PnP ACPI: found 5 devices
[    5.784374] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    5.790274] clocksource: Switched to clocksource acpi_pm
[    5.795691] pci 0000:00:03.0: BAR 15: no space for [mem size 0x00100000 pref]
[    5.802841] pci 0000:00:03.0: BAR 15: failed to assign [mem size 0x00100000 pref]
[    5.810336] pci 0000:01:03.0: BAR 6: assigned [mem 0xf5f00000-0xf5f1ffff pref]
[    5.817640] pci 0000:01:02.2: BAR 6: assigned [mem 0xf5f20000-0xf5f2ffff pref]
[    5.824875] pci 0000:00:03.0: PCI bridge to [bus 01]
[    5.829852] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
[    5.835958] pci 0000:00:03.0:   bridge window [mem 0xf5f00000-0xf7dfffff]
[    5.842758] pci 0000:02:04.0: BAR 6: assigned [mem 0xf7e00000-0xf7e03fff pref]
[    5.849982] pci 0000:00:07.0: PCI bridge to [bus 02]
[    5.854955] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    5.861058] pci 0000:00:07.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    5.867851] pci 0000:00:07.0:   bridge window [mem 0xf5e00000-0xf5efffff 64bit pref]
[    5.875601] pci 0000:00:08.0: PCI bridge to [bus 03]
[    5.880586] pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
[    5.889627] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    5.895813] pci_bus 0000:00: resource 5 [io  0x03b0-0x03bb window]
[    5.901999] pci_bus 0000:00: resource 6 [io  0x03c0-0x03df window]
[    5.908186] pci_bus 0000:00: resource 7 [io  0x03e0-0x0fff window]
[    5.914376] pci_bus 0000:00: resource 8 [io  0x1000-0x5fff window]
[    5.920560] pci_bus 0000:00: resource 9 [mem 0xf5f00000-0xf7efffff window]
[    5.927442] pci_bus 0000:00: resource 10 [mem 0xf5e00000-0xf5efffff window]
[    5.934408] pci_bus 0000:00: resource 11 [mem 0x000a0000-0x000bffff window]
[    5.941374] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    5.946955] pci_bus 0000:01: resource 1 [mem 0xf5f00000-0xf7dfffff]
[    5.953335] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    5.958913] pci_bus 0000:02: resource 1 [mem 0xf7e00000-0xf7efffff]
[    5.965185] pci_bus 0000:02: resource 2 [mem 0xf5e00000-0xf5efffff 64bit pref]
[    5.972499] pci 0000:04:09.0: PCI bridge to [bus 05]
[    5.977485] pci 0000:06:0e.0: BAR 6: no space for [mem size 0x00100000 pref]
[    5.984536] pci 0000:06:0e.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    5.991937] pci 0000:06:0e.1: BAR 6: no space for [mem size 0x00100000 pref]
[    5.998990] pci 0000:06:0e.1: BAR 6: failed to assign [mem size 0x00100000 pref]
[    6.006391] pci 0000:04:0a.0: PCI bridge to [bus 06]
[    6.011364] pci 0000:04:0a.0:   bridge window [io  0x6000-0x6fff]
[    6.017466] pci 0000:04:0a.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    6.024265] pci 0000:04:0b.0: PCI bridge to [bus 07]
[    6.029246] pci 0000:04:0c.0: PCI bridge to [bus 08]
[    6.034221] pci_bus 0000:04: resource 4 [io  0x6000-0x6fff window]
[    6.040410] pci_bus 0000:04: resource 5 [mem 0xf7f00000-0xf7ffffff window]
[    6.047290] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
[    6.052869] pci_bus 0000:06: resource 1 [mem 0xf7f00000-0xf7ffffff]
[    6.059353] NET: Registered protocol family 2
[    6.064078] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
[    6.072180] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    6.080469] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.088015] TCP: Hash tables configured (established 131072 bind 65536)
[    6.094820] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    6.101127] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    6.107989] NET: Registered protocol family 1
[    6.112366] NET: Registered protocol family 44
[    6.116850] pci 0000:00:04.3: boot interrupts on device [1022:746b] already disabled
[    6.124602] pci 0000:00:07.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    6.131662] pci 0000:00:07.0: MSI quirk detected; subordinate MSI disabled
[    6.138555] pci 0000:00:08.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    6.145609] pci 0000:00:08.0: MSI quirk detected; subordinate MSI disabled
[    6.230339] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0x706 took 75915 usecs
[    6.314304] pci 0000:01:00.1: quirk_usb_early_handoff+0x0/0x706 took 74762 usecs
[    6.321728] pci 0000:01:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.330097] pci 0000:04:09.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    6.337155] pci 0000:04:09.0: MSI quirk detected; subordinate MSI disabled
[    6.344038] pci 0000:04:0a.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    6.351096] pci 0000:04:0a.0: MSI quirk detected; subordinate MSI disabled
[    6.357983] pci 0000:04:0b.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    6.365041] pci 0000:04:0b.0: MSI quirk detected; subordinate MSI disabled
[    6.371926] pci 0000:04:0c.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    6.378985] pci 0000:04:0c.0: MSI quirk detected; subordinate MSI disabled
[    6.385876] PCI: CLS 64 bytes, default 64
[    6.391217] PCI-DMA: Disabling AGP.
[    6.394902] PCI-DMA: aperture base @ e8000000 size 65536 KB
[    6.400476] PCI-DMA: using GART IOMMU.
[    6.404239] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    6.415762] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    6.424833] workingset: timestamp_bits=42 max_order=22 bucket_order=0
[    6.435247] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    6.442664] io scheduler noop registered
[    6.446652] io scheduler cfq registered (default)
[    6.451766] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    6.459180] ACPI: Power Button [PWRF]
[    6.462919] ACPI: ACPI: processor limited to max C-state 1
[    6.468688] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    6.495564] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    6.549519] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    6.557756] Linux agpgart interface v0.103
[    6.562368] HP HPSA Driver (v 3.4.20-125)
[    6.566394] hpsa 0000:02:04.0: legacy board ID: 0x40800e11
[    6.571901] hpsa 0000:02:04.0: legacy board ID: 0x40800e11
[    6.577555] hpsa 0000:02:04.0: Controller reports max supported commands of 0 Using 16 instead. Ensure that firmware is up to date.
[    6.589371] hpsa 0000:02:04.0: Physical aborts not supported
[    6.595034] hpsa 0000:02:04.0: Logical aborts not supported
[    6.600613] hpsa 0000:02:04.0: HP SSD Smart Path aborts not supported
[    6.666506] hpsa 0000:02:04.0: Controller reports max supported commands of 0 Using 16 instead. Ensure that firmware is up to date.
[    6.758469] scsi host0: hpsa
[    6.761485] hpsa can't handle SMP requests
[    6.765918] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.772452] ehci-pci: EHCI PCI platform driver
[    6.776913] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.783101] ohci-pci: OHCI PCI platform driver
[    6.787711] ohci-pci 0000:01:00.0: OHCI PCI host controller
[    6.793314] ohci-pci 0000:01:00.0: new USB bus registered, assigned bus number 1
[    6.800789] ohci-pci 0000:01:00.0: irq 19, io mem 0xf7df0000
[    6.824802] hpsa 0000:02:04.0: C0:T0:L0 Volume status not available, assuming online.
[    6.833152] hpsa 0000:02:04.0: scsi 0:1:0:0: added Direct-Access     COMPAQ   LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
[    6.837012] hpsa 0000:02:04.0: scsi 0:3:0:0: added RAID              COMPAQ   Smart Array 5i   controller SSDSmartPathCap- En- Exp=1
[    6.857417] scsi 0:1:0:0: Direct-Access     COMPAQ   LOGICAL VOLUME   2.76 PQ: 0 ANSI: 4
[    6.866105] scsi 0:3:0:0: RAID              COMPAQ   Smart Array 5i   2.76 PQ: 0 ANSI: 0
[    6.876607] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    6.884884] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.892108] usb usb1: Product: OHCI PCI host controller
[    6.897337] usb usb1: Manufacturer: Linux 4.19.0-dirty ohci_hcd
[    6.903292] usb usb1: SerialNumber: 0000:01:00.0
[    6.908245] hub 1-0:1.0: USB hub found
[    6.912030] hub 1-0:1.0: 3 ports detected
[    6.916079] sd 0:1:0:0: [sda] 142253280 512-byte logical blocks: (72.8 GB/67.8 GiB)
[    6.923838] sd 0:1:0:0: [sda] Write Protect is off
[    6.928642] sd 0:1:0:0: [sda] Mode Sense: 5b 00 00 08
[    6.933975] ohci-pci 0000:01:00.1: OHCI PCI host controller
[    6.939565] ohci-pci 0000:01:00.1: new USB bus registered, assigned bus number 2
[    6.946990] ohci-pci 0000:01:00.1: irq 19, io mem 0xf7de0000
[    6.952669] sd 0:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    6.978194]  sda: sda1 sda2 < sda5 >
[    6.982739] sd 0:1:0:0: [sda] Attached SCSI disk
[    7.012327] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    7.020594] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.027818] usb usb2: Product: OHCI PCI host controller
[    7.033096] usb usb2: Manufacturer: Linux 4.19.0-dirty ohci_hcd
[    7.039024] usb usb2: SerialNumber: 0000:01:00.1
[    7.043775] hub 2-0:1.0: USB hub found
[    7.047543] hub 2-0:1.0: 3 ports detected
[    7.051768] usbcore: registered new interface driver usb-storage
[    7.057825] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    7.067748] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.072730] serio: i8042 AUX port at 0x60,0x64 irq 12
[    7.077856] rtc_cmos rtc_cmos: RTC can wake from S4
[    7.083019] rtc_cmos rtc_cmos: registered as rtc0
[    7.087763] rtc_cmos rtc_cmos: alarms up to one year, y3k, 114 bytes nvram
[    7.094664] hidraw: raw HID events driver (C) Jiri Kosina
[    7.100098] usbcore: registered new interface driver usbhid
[    7.105677] usbhid: USB HID core driver
[    7.109905] NET: Registered protocol family 10
[    7.115469] Segment Routing with IPv6
[    7.119172] NET: Registered protocol family 17
[    7.123986] RAS: Correctable Errors collector initialized.
[    7.129710] registered taskstats version 1
[    7.133839] AppArmor: AppArmor sha1 policy hashing enabled
[    7.139671] console [netcon0] enabled
[    7.143355] netconsole: network logging started
[    7.147963] rtc_cmos rtc_cmos: setting system clock to 2018-10-25 14:31:10 UTC (1540477870)
[    7.163774] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    7.195041] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    7.202732] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    7.227733] devtmpfs: mounted
[    7.231979] Freeing unused kernel image memory: 940K
[    7.242255] Write protecting the kernel read-only data: 14336k
[    7.250067] Freeing unused kernel image memory: 2004K
[    7.255397] Freeing unused kernel image memory: 264K
[    7.275148] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    7.281607] Run /sbin/init as init process
[    7.585631] random: fast init done
[    8.180014] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    8.201545] systemd[1]: Detected architecture x86-64.

Welcome to Debian GNU/Linux buster/sid!

[    8.239640] systemd[1]: Set hostname to <dl585>.
[    9.158084] random: systemd: uninitialized urandom read (16 bytes read)
[    9.164948] systemd[1]: Listening on fsck to fsckd communication Socket.
[  OK  ] Listening on fsck to fsckd communication Socket.
[    9.186319] random: systemd: uninitialized urandom read (16 bytes read)
[    9.193067] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[    9.214293] random: systemd: uninitialized urandom read (16 bytes read)
[    9.221032] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    9.238352] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[    9.265479] systemd[1]: Mounting Kernel Debug File System...
          Mounting Kernel Debug File System...
[    9.283980] systemd[1]: Starting File System Check on Root Device...
          Starting File System Check on Root Device...
[    9.306594] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Listening on Syslog Socket.
          Starting Load Kernel Modules...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
[  OK  ] Listening on Journal Audit Socket.
          Starting Journal Service...
          Starting Create list of required st…ce nodes for the current kernel...
[    9.452120] loop: module loaded
          Mounting Huge Pages File System...
[  OK  ] Listening on udev Control Socket.
[  OK  ] Reached target System Time Synchronized.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Set up automount Arbitrary Executab…rmats File System Automount Point.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
          Mounting POSIX Message Queue File System...
[  OK  ] Reached target Remote File Systems.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
          Starting udev Coldplug all Devices...
          Starting Set the console keyboard layout...
[  OK  ] Started Journal Service.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Started File System Check on Root Device.
[  OK  ] Started Load Kernel Modules.
[  OK  ] Started Create list of required sta…vice nodes for the current kernel.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Started File System Check Daemon to report status.
          Starting Apply Kernel Variables...
          Starting Remount Root and Kernel File Systems...
[  OK  ] Started Appl[    9.829719] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
y Kernel Variables.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Started Remount Root and Kernel File Systems.
          Starting Load/Save Random Seed...
          Starting Create System Users...
          Starting Flush Journal to Persistent Storage...
          Starting Helper to synchronize boot up for ifupdown...
[  OK  ] Started Set the console keyboard layout.
[  OK  ] Started Load/Save Random Seed.
[    9.985409] systemd-journald[107]: Received request to flush runtime journal from PID 1
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Create System Users.
          Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
          Starting Set console font and keymap...
          Starting Create Volatile Files and Directories...
          Starting Load AppArmor profiles...
          Starting udev Kernel Device Manager...
[  OK  ] Started Set console font and keymap.
[  OK  ] Started Create Volatile Files and Directories.
          Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[   10.640940] AMD768-HWRNG detected
[   10.646467] k8temp 0000:00:18.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   10.659653] k8temp 0000:00:19.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   10.674826] k8temp 0000:00:1a.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   10.687590] k8temp 0000:00:1b.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   10.709928] libata version 3.00 loaded.
[   10.731781] input: PC Speaker as /devices/platform/pcspkr/input/input4
[  OK  ] Found device /dev/ttyS0.
[   10.776103] MCE: In-kernel MCE decoding enabled.
[   10.799291] pata_amd 0000:00:04.1: version 0.4.1
[   10.804704] scsi host1: pata_amd
[   10.808204] scsi host2: pata_amd
[   10.811524] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x2000 irq 14
[   10.813047] Floppy drive(s): fd0 is 1.44M
[   10.818666] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x2008 irq 15
[   10.844630] FDC 0 is a National Semiconductor PC87306
[   11.007540] sd 0:1:0:0: Attached scsi generic sg0 type 0
[   11.013026] Fusion MPT base driver 3.04.20
[   11.013169] scsi 0:3:0:0: Attached scsi generic sg1 type 12
[   11.017166] Copyright (c) 1999-2008 LSI Corporation
[   11.029582] tg3.c:v3.137 (May 11, 2014)
[   11.033616] EDAC amd64: Node 0: DRAM ECC enabled.
[   11.038360] EDAC amd64: K8 revE or earlier detected (node 0).
[   11.044148] EDAC amd64: using x4 syndromes.
[   11.048527] EDAC MC0: Giving out device to module amd64_edac controller K8: DEV 0000:00:18.3 (INTERRUPT)
[   11.058012] EDAC amd64: Node 1: DRAM ECC enabled.
[   11.062731] EDAC amd64: K8 revE or earlier detected (node 1).
[   11.068501] EDAC amd64: using x4 syndromes.
[   11.073192] tg3 0000:02:06.0 eth0: Tigon3 [partno(349321-001) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:13:21:07:9c:e3
[   11.073841] EDAC MC1: Giving out device to module amd64_edac controller K8: DEV 0000:00:19.3 (INTERRUPT)
[   11.084277] tg3 0000:02:06.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   11.093887] EDAC amd64: Node 2: DRAM ECC enabled.
[   11.093892] EDAC amd64: K8 revE or earlier detected (node 2).
[   11.103639] tg3 0000:02:06.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[0]
[   11.108387] EDAC amd64: using x4 syndromes.
[   11.114134] tg3 0000:02:06.0 eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[   11.122112] EDAC MC2: Giving out device to module amd64_edac controller K8: DEV 0000:00:1a.3 (INTERRUPT)
[   11.127268] ata1.00: ATAPI: COMPAQ  CD-ROM SN-124, N104, max PIO4
[   11.132875] EDAC amd64: Node 3: DRAM ECC enabled.
[   11.146252] scsi 1:0:0:0: CD-ROM            COMPAQ   CD-ROM SN-124    N104 PQ: 0 ANSI: 5
[   11.148454] EDAC amd64: K8 revE or earlier detected (node 3).
[   11.148479] EDAC amd64: using x4 syndromes.
[   11.171532] EDAC MC3: Giving out device to module amd64_edac controller K8: DEV 0000:00:1b.3 (INTERRUPT)
[   11.181104] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[   11.191889] AMD64 EDAC driver v3.5.0
[   11.195648] Fusion MPT SPI Host driver 3.04.20
[   11.200713] mptbase: ioc0: Initiating bringup
[   11.206897] tg3 0000:02:06.1 eth1: Tigon3 [partno(349321-001) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:13:21:07:9c:e2
[   11.217967] tg3 0000:02:06.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   11.227872] tg3 0000:02:06.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   11.235730] tg3 0000:02:06.1 eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[   11.243039] scsi 1:0:0:0: Attached scsi generic sg2 type 5
[   11.249754] ata2: port disabled--ignoring
[   11.317471] powernow_k8: Power state transitions not supported
[   11.323307] powernow_k8: Power state transitions not supported
[   11.329166] powernow_k8: Power state transitions not supported
[   11.335017] powernow_k8: Power state transitions not supported
[   11.430533] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   11.437874] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.443503] sr 1:0:0:0: Attached scsi CD-ROM sr0
[  OK     11.468668] audit: type=1400 audit(1540477874.815:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=182 comm="apparmor_parser"
0m] Found device[   11.484211] audit: type=1400 audit(1540477874.815:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=182 comm="apparmor_parser"
  LOGICAL_VOLUME [   11.500534] audit: type=1400 audit(1540477874.815:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=182 comm="apparmor_parser"
5.
[   11.516674] audit: type=1400 audit(1540477874.839:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ntpd" pid=181 comm="apparmor_parser"
[  OK  ] Started Load AppArmor profiles.
          Activating swap /dev/sda5...
[   11.579500] Adding 2927612k swap on /dev/sda5.  Priority:-2 extents:1 across:2927612k
[  OK  ] Activated swap /dev/sda5.
[  OK  ] Reached target Swap.
[  OK  ] Reached target System Initialization.
[  OK  ] Started ACPI Events Check.
[  OK  ] Reached target Paths.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[   11.699995] random: crng init done
[   11.703427] random: 7 urandom warning(s) missed due to ratelimiting
[  OK  ] Started Daily rotation of log files.
[  OK  ] Listening on UUID daemon activation socket.
[  OK  ] Listening on ACPID Listen Socket.
[  OK  ] Started Daily apt download activities.
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Reached target Timers.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
[  OK  ] Started ACPI event daemon.
          Starting LSB: Load kernel modules needed to enable cpufreq scaling...
[  OK  ] Started Regular background program processing daemon.
          Starting Deferred execution scheduler...
          Starting System Logging Service...
[  OK  ] Started D-Bus System Message Bus.
[   12.046262] ioc0: LSI53C1030 C0: Capabilities={Initiator,Target}
[  OK  ] Started irqbalance daemon.
          Starting Initialize hardware monitoring sensors...
          Starting Login Service...
[  OK  ] Started Self Monitoring and Reporting Technology (SMART) Daemon.
[  OK  ] Started Deferred execution scheduler.
[  OK  ] Started Initialize hardware monitoring sensors.
[  OK  ] Started Login Service.
[  OK  ] Started System Logging Service.
[   12.651154] powernow_k8: Power state transitions not supported
[   12.657072] powernow_k8: Power state transitions not supported
[   12.662927] powernow_k8: Power state transitions not supported
[   12.668775] powernow_k8: Power state transitions not supported
[  OK  ] Started LSB: Load kernel modules needed to enable cpufreq scaling.
          Starting LSB: set CPUFreq kernel parameters...
[  OK  ] Started LSB: set CPUFreq kernel parameters.[   12.824678] scsi host3: ioc0: LSI53C1030 C0, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=26

[   12.833513] mptbase: ioc1: Initiating bringup
[   13.566249] ioc1: LSI53C1030 C0: Capabilities={Initiator,Target}
[   14.296750] scsi host4: ioc1: LSI53C1030 C0, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=27
[  OK  ] Started Helper to synchronize boot up for ifupdown.
          Starting Raise network interfaces...
[   14.899979] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   16.524025] tg3 0000:02:06.0 eth0: Link is up at 100 Mbps, full duplex
[   16.527277] tg3 0000:02:06.0 eth0: Flow control is off for TX and off for RX
[   16.527277] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  OK  ] Started Raise network interfaces.
[  OK  ] Reached target Network.
[  OK  ] Reached target Network is Online.
          Starting LSB: exim Mail Transport Agent...
          Starting Network Time Service...
          Starting OpenBSD Secure Shell server...
          Starting /etc/rc.local Compatibility...
          Starting Permit User Sessions...
[  OK  ] Started /etc/rc.local Compatibility.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started OpenBSD Secure Shell server.
[  OK  ] Started LSB: exim Mail Transport Agent.
[  OK  ] Created slice User Slice of UID 1000.
[  OK  ] Created slice system-user\x2druntime\x2ddir.slice.
[  OK  ] Started /run/user/1000 mount wrapper.
          Starting User Manager for UID 1000...
[  OK  ] Started Session 1 of user mroos.
[  OK  ] Started User Manager for UID 1000.
[   72.811455] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com


-- 
Meelis Roos <mroos@linux.ee>
