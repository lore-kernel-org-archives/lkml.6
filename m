Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA932C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687E2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="YHsy00as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3687E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeIXUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:04:24 -0400
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:40388 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbeIXUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:04:24 -0400
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
        by resqmta-ch2-04v.sys.comcast.net with ESMTP
        id 4Os2gxbD0lHCv4RR0gZrPM; Mon, 24 Sep 2018 14:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1537797718;
        bh=ZDCnW62fj0uXEHSTrCtYco+mtHNT7sCbk1Xj9/hbzqw=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=YHsy00asMKxKyl4/J6XCjRxMsIegrF7sNOr+74LBDYjF8DtwZk+BpGVkVwmxJFigX
         T2cFxlYHZnMMAADSd0WWwuFehqYYn8LrGbkfHYwV72QEj2kqdM57H36Zf+cAQ2vCda
         jPMk0Kf7adLfVxHOsu8HKd7RqToRIzxCSsCejDfBydR9rME6jn62i7+lnkhX5iUI5g
         LbbF0PwJOf681Tsh3kAUYsZpNwo2yQtri+TGvFI0qTSl2DWzMWmQ09EPIdlbMdmX/w
         HF91ZK1XQozICo1/isRg4Comv4Z2PE0cPIVsBBIxAR73MuYLeIK9JPJ8qEIs8CIdzj
         llziSLYwBBXlg==
Received: from [10.1.10.100] ([73.214.254.59])
        by resomta-ch2-09v.sys.comcast.net with ESMTPSA
        id 4RQzgZW57JD4x4RR0gBog0; Mon, 24 Sep 2018 14:01:58 +0000
Subject: Re: AMD Athlon bogus performance value causing RCU stalls?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net>
 <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de>
 <de33e029-2be3-85de-4777-64dd8803fe1e@comcast.net>
 <alpine.DEB.2.21.1809240822020.1398@nanos.tec.linutronix.de>
From:   Rob Prowel <rprowel@comcast.net>
Message-ID: <4454657b-d683-46aa-f8f2-190556639805@comcast.net>
Date:   Mon, 24 Sep 2018 10:01:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809240822020.1398@nanos.tec.linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------58ED236F023F903C31C918EF"
Content-Language: en-US
X-CMAE-Envelope: MS4wfGcVbATpmQ0N3C5KTdf5JLv6kORiO7aKvpOpYbWudjOJ7qzaNcoKoBduiciTPFUuk4U5z6uvS4FJH7UXM3xLbt39N0UYMeB/OOCLEs5Ymt/WqrD91LZG
 hHzLK1TdL4x9sXcCw7E+u94wZciRvTbCt3yA2lj0qErLAQz2LG2jkNzUxBqiV1TGukigElIfM0SlyivbM8LjlqOpz/MkqPW1uQs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------58ED236F023F903C31C918EF
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 09/24/18 02:23, Thomas Gleixner wrote:

> No that thing does not affect 64bit for sure. Can you please provide me a
> full dmesg from that machine?
> 


Will do.  See attached dmesg.txt file




--------------58ED236F023F903C31C918EF
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Linux version 4.18.7-100.fc27.x86_64 (mockbuild@bkernel04.phx2.fedoraproject.org) (gcc version 7.3.1 20180712 (Red Hat 7.3.1-6) (GCC)) #1 SMP Thu Sep 13 18:41:39 UTC 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.18.7-100.fc27.x86_64 root=UUID=2f8727e4-4a2a-4df7-ad25-7f2eca84d532 ro rd.md.uuid=70bd1f4e:c591854b:74e6b7cc:02fc8125 rd.md.uuid=d9b2975a:dc0b0068:caef4dd3:5adb091a rhgb quiet LANG=en_US.UTF-8
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfedffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfee0000-0x00000000bfee2fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bfee3000-0x00000000bfeeffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bfef0000-0x00000000bfefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: Dell Inc. Inspiron 531/0RY206, BIOS 1.0.7 11/09/2007
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0xbfee0 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask FF80000000 write-back
[    0.000000]   1 base 0080000000 mask FFC0000000 write-back
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] found SMP MP-table at [mem 0x000f4ca0-0x000f4caf] mapped at [(____ptrval____)]
[    0.000000] Base memory trampoline at [(____ptrval____)] 99000 size 24576
[    0.000000] BRK [0x82aaa000, 0x82aaafff] PGTABLE
[    0.000000] BRK [0x82aab000, 0x82aabfff] PGTABLE
[    0.000000] BRK [0x82aac000, 0x82aacfff] PGTABLE
[    0.000000] BRK [0x82aad000, 0x82aadfff] PGTABLE
[    0.000000] BRK [0x82aae000, 0x82aaefff] PGTABLE
[    0.000000] BRK [0x82aaf000, 0x82aaffff] PGTABLE
[    0.000000] BRK [0x82ab0000, 0x82ab0fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x362eb000-0x3716dfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7060 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000BFEE3100 00004C (v01 DELL   AS09     42302E31 AWRD 00000000)
[    0.000000] ACPI: FACP 0x00000000BFEE9380 0000F4 (v03 DELL   AS09     42302E31 AWRD 00000000)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Pm1aEventBlock: 32/8 (20180531/tbfadt-569)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Pm1aControlBlock: 16/8 (20180531/tbfadt-569)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/PmTimerBlock: 32/8 (20180531/tbfadt-569)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/8 (20180531/tbfadt-569)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe1Block: 128/8 (20180531/tbfadt-569)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aEventBlock: 8, using default 32 (20180531/tbfadt-674)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 8, using default 16 (20180531/tbfadt-674)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/PmTimerBlock: 8, using default 32 (20180531/tbfadt-674)
[    0.000000] ACPI: DSDT 0x00000000BFEE3280 0060B7 (v01 DELL   AS09     00001000 MSFT 03000000)
[    0.000000] ACPI: FACS 0x00000000BFEE0000 000040
[    0.000000] ACPI: FACS 0x00000000BFEE0000 000040
[    0.000000] ACPI: SLIC 0x00000000BFEE9580 000176 (v01 DELL   AS09     42302E31 AWRD 00000000)
[    0.000000] ACPI: HPET 0x00000000BFEE9740 000038 (v01 DELL   AS09     42302E31 AWRD 00000098)
[    0.000000] ACPI: MCFG 0x00000000BFEE97C0 00003C (v01 DELL   AS09     42302E31 AWRD 00000000)
[    0.000000] ACPI: APIC 0x00000000BFEE94C0 00007C (v01 DELL   AS09     42302E31 AWRD 00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000000bfedffff]
[    0.000000] NODE_DATA(0) allocated [mem 0xbfeb5000-0xbfedffff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000bfedffff]
[    0.000000]   Normal   empty
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bfedffff]
[    0.000000] Reserved but unavailable: 386 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000000bfedffff]
[    0.000000] On node 0 totalpages: 786046
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12220 pages used for memmap
[    0.000000]   DMA32 zone: 782048 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfefff000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] [mem 0xbff00000-0xefffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x94/0x55b with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:1024 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 45 pages/cpu @(____ptrval____) s147456 r8192 d28672 u1048576
[    0.000000] pcpu-alloc: s147456 r8192 d28672 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 773741
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.18.7-100.fc27.x86_64 root=UUID=2f8727e4-4a2a-4df7-ad25-7f2eca84d532 ro rd.md.uuid=70bd1f4e:c591854b:74e6b7cc:02fc8125 rd.md.uuid=d9b2975a:dc0b0068:caef4dd3:5adb091a rhgb quiet LANG=en_US.UTF-8
[    0.000000] Memory: 3052144K/3144184K available (12300K kernel code, 1619K rwdata, 4012K rodata, 2160K init, 1336K bss, 92040K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] ftrace: allocating 37959 entries in 149 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=1024 to nr_cpu_ids=2.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 65792, nr_irqs: 440, preallocated irqs: 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180531
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.000000] do_IRQ: 0.55 No irq handler for vector
[    0.005000] tsc: Fast TSC calibration using PIT
[    0.006000] tsc: Detected 2109.745 MHz processor
[    0.006000] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.006000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4219.49 BogoMIPS (lpj=2109745)
[    0.006000] pid_max: default: 32768 minimum: 301
[    0.006000] Security Framework initialized
[    0.006000] Yama: becoming mindful.
[    0.006000] SELinux:  Initializing.
[    0.006000] SELinux:  Starting in permissive mode
[    0.010097] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.012039] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.012145] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.012210] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.012630] mce: CPU supports 5 MCE banks
[    0.012639] LVT offset 0 assigned for vector 0xf9
[    0.012642] process: using AMD E400 aware idle routine
[    0.012644] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 4
[    0.012645] Last level dTLB entries: 4KB 512, 2MB 8, 4MB 4, 1GB 0
[    0.012649] Spectre V2 : Spectre mitigation: LFENCE not serializing, switching to generic retpoline
[    0.012725] Spectre V2 : Mitigation: Full generic retpoline
[    0.012726] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.012902] Freeing SMP alternatives memory: 36K
[    0.015000] APIC calibration not consistent with PM-Timer: 329ms instead of 100ms
[    0.015000] APIC delta adjusted to PM-Timer: 54837227 (180699781)
[    0.015000] smpboot: CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.015000] Performance Events: AMD PMU driver.
[    0.015000] ... version:                0
[    0.015000] ... bit width:              48
[    0.015000] ... generic registers:      4
[    0.015000] ... value mask:             0000ffffffffffff
[    0.015000] ... max period:             00007fffffffffff
[    0.015000] ... fixed-purpose events:   0
[    0.015000] ... event mask:             000000000000000f
[    0.015000] Hierarchical SRCU implementation.
[    0.015000] smp: Bringing up secondary CPUs ...
[    0.015000] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.015000] x86: Booting SMP configuration:
[    0.015000] .... node  #0, CPUs:      #1
[    0.074117] smp: Brought up 1 node, 2 CPUs
[    0.074117] smpboot: Max logical packages: 1
[    0.074117] smpboot: Total of 2 processors activated (188472.55 BogoMIPS)
[    0.074865] devtmpfs: initialized
[    0.074865] x86/mm: Memory block size: 128MB
[    0.074865] PM: Registering ACPI NVS region [mem 0xbfee0000-0xbfee2fff] (12288 bytes)
[    0.074865] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.074865] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.074865] pinctrl core: initialized pinctrl subsystem
[    0.074865] RTC time: 19:08:08, date: 09/23/18
[    0.074865] NET: Registered protocol family 16
[    0.074865] audit: initializing netlink subsys (disabled)
[    0.074865] audit: type=2000 audit(1537729670.074:1): state=initialized audit_enabled=0 res=1
[    0.074865] cpuidle: using governor menu
[    0.074865] node 0 link 0: io port [9000, ffff]
[    0.074865] TOM: 00000000c0000000 aka 3072M
[    0.074865] node 0 link 0: mmio [a0000, bffff]
[    0.074865] node 0 link 0: mmio [c0000000, efffffff]
[    0.074865] node 0 link 0: mmio [f4000000, fe02ffff]
[    0.074865] node 0 link 0: mmio [f0000000, f03fffff]
[    0.074865] bus: [bus 00-03] on node 0 link 0
[    0.074865] bus: 00 [io  0x0000-0xffff]
[    0.074865] bus: 00 [mem 0x000a0000-0x000bffff]
[    0.074865] bus: 00 [mem 0xc0000000-0xf3ffffff]
[    0.074865] bus: 00 [mem 0xf4000000-0xfcffffffff]
[    0.074865] ACPI: bus type PCI registered
[    0.074865] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.074865] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
[    0.074865] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
[    0.074865] PCI: Using configuration type 1 for base access
[    0.075000] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.075000] cryptd: max_cpu_qlen set to 1000
[    0.075000] ACPI: Added _OSI(Module Device)
[    0.075000] ACPI: Added _OSI(Processor Device)
[    0.075000] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.075000] ACPI: Added _OSI(Processor Aggregator Device)
[    0.075000] ACPI: Added _OSI(Linux-Dell-Video)
[    0.075000] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.075000] ACPI: Interpreter enabled
[    0.075000] ACPI: (supports S0 S3 S4 S5)
[    0.075000] ACPI: Using IOAPIC for interrupt routing
[    0.075000] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.075000] ACPI: Enabled 6 GPEs in block 00 to 1F
[    0.075000] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-03])
[    0.075000] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.075000] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.075000] PCI host bridge to bus 0000:00
[    0.075000] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.075000] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.075000] pci_bus 0000:00: root bus resource [io  0x1c00-0x1c7f window]
[    0.075000] pci_bus 0000:00: root bus resource [io  0x9000-0xffff window]
[    0.075000] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.075000] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.075000] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xefffffff window]
[    0.075000] pci_bus 0000:00: root bus resource [mem 0xf4000000-0xfe02ffff window]
[    0.075000] pci_bus 0000:00: root bus resource [bus 00-03]
[    0.075000] pci 0000:00:00.0: [10de:03ea] type 00 class 0x050000
[    0.075000] pci 0000:00:01.0: [10de:03e0] type 00 class 0x060100
[    0.075000] pci 0000:00:01.1: [10de:03eb] type 00 class 0x0c0500
[    0.075000] pci 0000:00:01.1: reg 0x10: [io  0xfc00-0xfc3f]
[    0.075000] pci 0000:00:01.1: reg 0x20: [io  0x1c00-0x1c3f]
[    0.075000] pci 0000:00:01.1: reg 0x24: [io  0x1c40-0x1c7f]
[    0.075000] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    0.075000] pci 0000:00:01.2: [10de:03f5] type 00 class 0x050000
[    0.075000] pci 0000:00:02.0: [10de:03f1] type 00 class 0x0c0310
[    0.075000] pci 0000:00:02.0: reg 0x10: [mem 0xfe02f000-0xfe02ffff]
[    0.075000] pci 0000:00:02.0: supports D1 D2
[    0.075000] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.075000] pci 0000:00:02.1: [10de:03f2] type 00 class 0x0c0320
[    0.075000] pci 0000:00:02.1: reg 0x10: [mem 0xfe02e000-0xfe02e0ff]
[    0.075000] pci 0000:00:02.1: supports D1 D2
[    0.075000] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.075000] pci 0000:00:04.0: [10de:03f3] type 01 class 0x060401
[    0.075000] pci 0000:00:05.0: [10de:03f0] type 00 class 0x040300
[    0.075000] pci 0000:00:05.0: reg 0x10: [mem 0xfe024000-0xfe027fff]
[    0.075000] pci 0000:00:05.0: PME# supported from D3hot D3cold
[    0.075000] pci 0000:00:06.0: [10de:03ec] type 00 class 0x01018a
[    0.075000] pci 0000:00:06.0: reg 0x20: [io  0xf000-0xf00f]
[    0.075000] pci 0000:00:06.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.075000] pci 0000:00:06.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.075000] pci 0000:00:06.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.075000] pci 0000:00:06.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.075000] pci 0000:00:07.0: [10de:03ef] type 00 class 0x068000
[    0.075000] pci 0000:00:07.0: reg 0x10: [mem 0xfe02d000-0xfe02dfff]
[    0.075000] pci 0000:00:07.0: reg 0x14: [io  0xec00-0xec07]
[    0.075000] pci 0000:00:07.0: supports D1 D2
[    0.075000] pci 0000:00:07.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.075000] pci 0000:00:08.0: [10de:03f6] type 00 class 0x010185
[    0.075000] pci 0000:00:08.0: reg 0x10: [io  0x09f0-0x09f7]
[    0.075000] pci 0000:00:08.0: reg 0x14: [io  0x0bf0-0x0bf3]
[    0.075000] pci 0000:00:08.0: reg 0x18: [io  0x0970-0x0977]
[    0.075000] pci 0000:00:08.0: reg 0x1c: [io  0x0b70-0x0b73]
[    0.075000] pci 0000:00:08.0: reg 0x20: [io  0xd800-0xd80f]
[    0.075000] pci 0000:00:08.0: reg 0x24: [mem 0xfe02c000-0xfe02cfff]
[    0.075000] pci 0000:00:08.1: [10de:03f6] type 00 class 0x010185
[    0.075000] pci 0000:00:08.1: reg 0x10: [io  0x09e0-0x09e7]
[    0.075000] pci 0000:00:08.1: reg 0x14: [io  0x0be0-0x0be3]
[    0.075000] pci 0000:00:08.1: reg 0x18: [io  0x0960-0x0967]
[    0.075000] pci 0000:00:08.1: reg 0x1c: [io  0x0b60-0x0b63]
[    0.075000] pci 0000:00:08.1: reg 0x20: [io  0xc400-0xc40f]
[    0.075000] pci 0000:00:08.1: reg 0x24: [mem 0xfe02b000-0xfe02bfff]
[    0.075000] pci 0000:00:09.0: [10de:03e8] type 01 class 0x060400
[    0.075000] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.075000] pci 0000:00:0b.0: [10de:03e9] type 01 class 0x060400
[    0.075000] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.075000] pci 0000:00:18.0: [1022:1100] type 00 class 0x060000
[    0.075000] pci 0000:00:18.1: [1022:1101] type 00 class 0x060000
[    0.075000] pci 0000:00:18.2: [1022:1102] type 00 class 0x060000
[    0.075000] pci 0000:00:18.3: [1022:1103] type 00 class 0x060000
[    0.075000] pci_bus 0000:01: extended config space not accessible
[    0.075000] pci 0000:01:09.0: [1033:0035] type 00 class 0x0c0310
[    0.075000] pci 0000:01:09.0: reg 0x10: [mem 0xfdeff000-0xfdefffff]
[    0.075000] pci 0000:01:09.0: supports D1 D2
[    0.075000] pci 0000:01:09.0: PME# supported from D0 D1 D2 D3hot
[    0.075000] pci 0000:01:09.1: [1033:0035] type 00 class 0x0c0310
[    0.075000] pci 0000:01:09.1: reg 0x10: [mem 0xfdefe000-0xfdefefff]
[    0.075000] pci 0000:01:09.1: supports D1 D2
[    0.075000] pci 0000:01:09.1: PME# supported from D0 D1 D2 D3hot
[    0.075000] pci 0000:01:09.2: [1033:00e0] type 00 class 0x0c0320
[    0.075000] pci 0000:01:09.2: reg 0x10: [mem 0xfdefd000-0xfdefd0ff]
[    0.075000] pci 0000:01:09.2: supports D1 D2
[    0.075000] pci 0000:01:09.2: PME# supported from D0 D1 D2 D3hot
[    0.075000] pci 0000:01:0a.0: [10ec:8169] type 00 class 0x020000
[    0.075000] pci 0000:01:0a.0: reg 0x10: [io  0xbc00-0xbcff]
[    0.075000] pci 0000:01:0a.0: reg 0x14: [mem 0xfdefc000-0xfdefc0ff]
[    0.075000] pci 0000:01:0a.0: reg 0x30: [mem 0xfdec0000-0xfdedffff pref]
[    0.075000] pci 0000:01:0a.0: supports D1 D2
[    0.075000] pci 0000:01:0a.0: PME# supported from D1 D2 D3hot D3cold
[    0.075000] pci 0000:00:04.0: PCI bridge to [bus 01] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [io  0xb000-0xbfff]
[    0.075000] pci 0000:00:04.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.075000] pci 0000:00:04.0:   bridge window [mem 0xfdd00000-0xfddfffff pref]
[    0.075000] pci 0000:00:04.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [io  0x1c00-0x1c7f window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [io  0x9000-0xffff window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xefffffff window] (subtractive decode)
[    0.075000] pci 0000:00:04.0:   bridge window [mem 0xf4000000-0xfe02ffff window] (subtractive decode)
[    0.075000] pci 0000:02:00.0: [10de:104a] type 00 class 0x030000
[    0.075000] pci 0000:02:00.0: reg 0x10: [mem 0xfb000000-0xfbffffff]
[    0.075000] pci 0000:02:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64bit pref]
[    0.075000] pci 0000:02:00.0: reg 0x1c: [mem 0xe6000000-0xe7ffffff 64bit pref]
[    0.075000] pci 0000:02:00.0: reg 0x24: [io  0xac00-0xac7f]
[    0.075000] pci 0000:02:00.0: reg 0x30: [mem 0xfcf00000-0xfcf7ffff pref]
[    0.075000] pci 0000:02:00.0: enabling Extended Tags
[    0.075000] pci 0000:02:00.1: [10de:0e08] type 00 class 0x040300
[    0.075000] pci 0000:02:00.1: reg 0x10: [mem 0xfcffc000-0xfcffffff]
[    0.075000] pci 0000:02:00.1: enabling Extended Tags
[    0.075000] pci 0000:00:09.0: ASPM: current common clock configuration is broken, reconfiguring
[    0.077015] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.077019] pci 0000:00:09.0:   bridge window [io  0xa000-0xafff]
[    0.077021] pci 0000:00:09.0:   bridge window [mem 0xfb000000-0xfcffffff]
[    0.077024] pci 0000:00:09.0:   bridge window [mem 0xd8000000-0xe7ffffff 64bit pref]
[    0.077060] pci 0000:00:0b.0: PCI bridge to [bus 03]
[    0.077063] pci 0000:00:0b.0:   bridge window [io  0x9000-0x9fff]
[    0.077065] pci 0000:00:0b.0:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.077068] pci 0000:00:0b.0:   bridge window [mem 0xfdb00000-0xfdbfffff 64bit pref]
[    0.077653] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.077725] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 *7 9 10 11 14 15)
[    0.077792] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 *7 9 10 11 14 15)
[    0.077859] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 *10 11 14 15)
[    0.077925] ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 *10 11 14 15)
[    0.077991] ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 *11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LIGP] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 *10 11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LMAC] (IRQs *5 7 9 10 11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LAZA] (IRQs 5 *7 9 10 11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [LSMB] (IRQs 5 *7 9 10 11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 *10 11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 *11 14 15)
[    0.078000] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [AIGP] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APCF] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APCH] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APMU] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [AAZA] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APCS] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APCL] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APCM] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APCZ] (IRQs 22 23) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APSI] (IRQs 20) *0, disabled.
[    0.078000] ACPI: PCI Interrupt Link [APSJ] (IRQs 21) *0, disabled.
[    0.078000] pci 0000:02:00.0: vgaarb: setting as boot VGA device
[    0.078000] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.078000] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.078000] vgaarb: loaded
[    0.078000] SCSI subsystem initialized
[    0.078000] libata version 3.00 loaded.
[    0.078000] ACPI: bus type USB registered
[    0.078000] usbcore: registered new interface driver usbfs
[    0.078000] usbcore: registered new interface driver hub
[    0.078000] usbcore: registered new device driver usb
[    0.078000] pps_core: LinuxPPS API ver. 1 registered
[    0.078000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.078000] PTP clock support registered
[    0.078000] EDAC MC: Ver: 3.0.0
[    0.078000] PCI: Using ACPI for IRQ routing
[    0.078000] PCI: pci_cache_line_size set to 64 bytes
[    0.078000] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.078000] e820: reserve RAM buffer [mem 0xbfee0000-0xbfffffff]
[    0.078000] NetLabel: Initializing
[    0.078000] NetLabel:  domain hash size = 128
[    0.078000] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.078000] NetLabel:  unlabeled traffic allowed by default
[    0.078000] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.078000] hpet0: at MMIO 0xfefff000, IRQs 2, 8, 31
[    0.078000] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.078000] clocksource: Switched to clocksource hpet
[    0.078000] VFS: Disk quotas dquot_6.6.0
[    0.078000] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.078000] pnp: PnP ACPI init
[    0.078000] system 00:00: [io  0x1000-0x107f] has been reserved
[    0.078000] system 00:00: [io  0x1080-0x10ff] has been reserved
[    0.078000] system 00:00: [io  0x1400-0x147f] has been reserved
[    0.078000] system 00:00: [io  0x1480-0x14ff] has been reserved
[    0.078000] system 00:00: [io  0x1800-0x187f] has been reserved
[    0.078000] system 00:00: [io  0x1880-0x18ff] has been reserved
[    0.078000] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.078000] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.078000] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.078000] system 00:01: [io  0x0294-0x0297] has been reserved
[    0.078000] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.078000] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.078000] system 00:03: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.078000] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.078000] system 00:04: [mem 0x000ce000-0x000cffff] has been reserved
[    0.078000] system 00:04: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.078000] system 00:04: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.078000] system 00:04: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.078000] system 00:04: [mem 0xfefff000-0xfefff0ff] has been reserved
[    0.078000] system 00:04: [mem 0xbfee0000-0xbfefffff] could not be reserved
[    0.078000] system 00:04: [mem 0xffff0000-0xffffffff] has been reserved
[    0.078000] system 00:04: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.078000] system 00:04: [mem 0x00100000-0xbfedffff] could not be reserved
[    0.078000] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.078000] system 00:04: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.078000] system 00:04: [mem 0xfefff000-0xfeffffff] could not be reserved
[    0.078000] system 00:04: [mem 0xfff80000-0xfff80fff] has been reserved
[    0.078000] system 00:04: [mem 0xfff90000-0xfffbffff] has been reserved
[    0.078000] system 00:04: [mem 0xfffed000-0xfffeffff] has been reserved
[    0.078000] system 00:04: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.078000] pnp: PnP ACPI: found 5 devices
[    0.115536] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.115536] pci 0000:00:04.0: PCI bridge to [bus 01]
[    0.115536] pci 0000:00:04.0:   bridge window [io  0xb000-0xbfff]
[    0.115536] pci 0000:00:04.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.115536] pci 0000:00:04.0:   bridge window [mem 0xfdd00000-0xfddfffff pref]
[    0.115536] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.115536] pci 0000:00:09.0:   bridge window [io  0xa000-0xafff]
[    0.115536] pci 0000:00:09.0:   bridge window [mem 0xfb000000-0xfcffffff]
[    0.115536] pci 0000:00:09.0:   bridge window [mem 0xd8000000-0xe7ffffff 64bit pref]
[    0.115536] pci 0000:00:0b.0: PCI bridge to [bus 03]
[    0.115536] pci 0000:00:0b.0:   bridge window [io  0x9000-0x9fff]
[    0.115536] pci 0000:00:0b.0:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.115536] pci 0000:00:0b.0:   bridge window [mem 0xfdb00000-0xfdbfffff 64bit pref]
[    0.115536] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.115536] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.115536] pci_bus 0000:00: resource 6 [io  0x1c00-0x1c7f window]
[    0.115536] pci_bus 0000:00: resource 7 [io  0x9000-0xffff window]
[    0.115536] pci_bus 0000:00: resource 8 [io  0x03b0-0x03df window]
[    0.115536] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
[    0.115536] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xefffffff window]
[    0.115536] pci_bus 0000:00: resource 11 [mem 0xf4000000-0xfe02ffff window]
[    0.115536] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.115536] pci_bus 0000:01: resource 1 [mem 0xfde00000-0xfdefffff]
[    0.115536] pci_bus 0000:01: resource 2 [mem 0xfdd00000-0xfddfffff pref]
[    0.115536] pci_bus 0000:01: resource 4 [io  0x0000-0x03af window]
[    0.115536] pci_bus 0000:01: resource 5 [io  0x03e0-0x0cf7 window]
[    0.115536] pci_bus 0000:01: resource 6 [io  0x1c00-0x1c7f window]
[    0.115536] pci_bus 0000:01: resource 7 [io  0x9000-0xffff window]
[    0.115536] pci_bus 0000:01: resource 8 [io  0x03b0-0x03df window]
[    0.115536] pci_bus 0000:01: resource 9 [mem 0x000a0000-0x000bffff window]
[    0.115536] pci_bus 0000:01: resource 10 [mem 0xc0000000-0xefffffff window]
[    0.115536] pci_bus 0000:01: resource 11 [mem 0xf4000000-0xfe02ffff window]
[    0.115536] pci_bus 0000:02: resource 0 [io  0xa000-0xafff]
[    0.115536] pci_bus 0000:02: resource 1 [mem 0xfb000000-0xfcffffff]
[    0.115536] pci_bus 0000:02: resource 2 [mem 0xd8000000-0xe7ffffff 64bit pref]
[    0.115536] pci_bus 0000:03: resource 0 [io  0x9000-0x9fff]
[    0.115536] pci_bus 0000:03: resource 1 [mem 0xfdc00000-0xfdcfffff]
[    0.115536] pci_bus 0000:03: resource 2 [mem 0xfdb00000-0xfdbfffff 64bit pref]
[    0.115536] NET: Registered protocol family 2
[    0.115536] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
[    0.115536] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.115536] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.115536] TCP: Hash tables configured (established 32768 bind 32768)
[    0.115536] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.115536] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.115536] NET: Registered protocol family 1
[    0.115536] PCI Interrupt Link [APCF] enabled at IRQ 23
[    0.217669] pci 0000:00:02.0: quirk_usb_early_handoff+0x0/0x6b0 took 85606 usecs
[    0.217934] PCI Interrupt Link [APCL] enabled at IRQ 22
[    0.218081] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218129] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218184] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218234] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218285] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218338] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218394] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    0.218544] PCI Interrupt Link [APC2] enabled at IRQ 17
[    0.218544] PCI Interrupt Link [APC3] enabled at IRQ 18
[    0.218544] PCI Interrupt Link [APC4] enabled at IRQ 19
[    0.218544] pci 0000:02:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.218544] pci 0000:02:00.1: Linked as a consumer to 0000:02:00.0
[    0.218544] PCI: CLS 32 bytes, default 64
[    0.218544] Unpacking initramfs...
[    0.562244] Freeing initrd memory: 14860K
[    0.564533] Initialise system trusted keyrings
[    0.564554] Key type blacklist registered
[    0.564613] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    0.565592] zbud: loaded
[    0.568472] pstore: using deflate compression
[    0.568590] SELinux:  Registering netfilter hooks
[    0.881378] alg: No test for 842 (842-generic)
[    0.881436] alg: No test for 842 (842-scomp)
[    0.892607] NET: Registered protocol family 38
[    0.892614] Key type asymmetric registered
[    0.892615] Asymmetric key parser 'x509' registered
[    0.892725] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.892793] io scheduler noop registered
[    0.892794] io scheduler deadline registered
[    0.892880] io scheduler cfq registered (default)
[    0.892882] io scheduler mq-deadline registered
[    0.892977] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.893359] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.893557] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.893572] ACPI: Power Button [PWRB]
[    0.893646] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.893678] ACPI: Power Button [PWRF]
[    0.894639] thermal LNXTHERM:00: registered as thermal_zone0
[    0.894640] ACPI: Thermal Zone [THRM] (26 C)
[    0.894917] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.898116] Non-volatile memory driver v1.3
[    0.898163] Linux agpgart interface v0.103
[    0.899354] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.899359] ehci-pci: EHCI PCI platform driver
[    0.899588] ehci-pci 0000:00:02.1: EHCI Host Controller
[    0.899692] ehci-pci 0000:00:02.1: new USB bus registered, assigned bus number 1
[    0.899706] ehci-pci 0000:00:02.1: debug port 1
[    0.899743] ehci-pci 0000:00:02.1: cache line size of 32 is not supported
[    0.899774] ehci-pci 0000:00:02.1: irq 22, io mem 0xfe02e000
[    0.913658] ehci-pci 0000:00:02.1: USB 2.0 started, EHCI 1.00
[    0.913760] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    0.913762] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.913764] usb usb1: Product: EHCI Host Controller
[    0.913766] usb usb1: Manufacturer: Linux 4.18.7-100.fc27.x86_64 ehci_hcd
[    0.913768] usb usb1: SerialNumber: 0000:00:02.1
[    0.913949] hub 1-0:1.0: USB hub found
[    0.913960] hub 1-0:1.0: 10 ports detected
[    0.914411] ehci-pci 0000:01:09.2: EHCI Host Controller
[    0.914476] ehci-pci 0000:01:09.2: new USB bus registered, assigned bus number 2
[    0.914540] ehci-pci 0000:01:09.2: irq 19, io mem 0xfdefd000
[    0.968759] ehci-pci 0000:01:09.2: USB 2.0 started, EHCI 1.00
[    0.968836] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    0.968838] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.968840] usb usb2: Product: EHCI Host Controller
[    0.968842] usb usb2: Manufacturer: Linux 4.18.7-100.fc27.x86_64 ehci_hcd
[    0.968844] usb usb2: SerialNumber: 0000:01:09.2
[    0.968989] hub 2-0:1.0: USB hub found
[    0.968998] hub 2-0:1.0: 5 ports detected
[    0.969212] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.969218] ohci-pci: OHCI PCI platform driver
[    0.969373] ohci-pci 0000:00:02.0: OHCI PCI host controller
[    0.969433] ohci-pci 0000:00:02.0: new USB bus registered, assigned bus number 3
[    0.969474] ohci-pci 0000:00:02.0: irq 23, io mem 0xfe02f000
[    1.011461] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[    1.011461] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.011461] usb usb3: Product: OHCI PCI host controller
[    1.011461] usb usb3: Manufacturer: Linux 4.18.7-100.fc27.x86_64 ohci_hcd
[    1.011461] usb usb3: SerialNumber: 0000:00:02.0
[    1.012681] hub 3-0:1.0: USB hub found
[    1.012691] hub 3-0:1.0: 10 ports detected
[    1.013065] ohci-pci 0000:01:09.0: OHCI PCI host controller
[    1.013129] ohci-pci 0000:01:09.0: new USB bus registered, assigned bus number 4
[    1.013176] ohci-pci 0000:01:09.0: irq 17, io mem 0xfdeff000
[    2.022386] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[    2.022388] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.022390] usb usb4: Product: OHCI PCI host controller
[    2.022391] usb usb4: Manufacturer: Linux 4.18.7-100.fc27.x86_64 ohci_hcd
[    2.022393] usb usb4: SerialNumber: 0000:01:09.0
[    2.022581] hub 4-0:1.0: USB hub found
[    2.022594] hub 4-0:1.0: 3 ports detected
[    2.022819] ohci-pci 0000:01:09.1: OHCI PCI host controller
[    2.022974] ohci-pci 0000:01:09.1: new USB bus registered, assigned bus number 5
[    2.022974] ohci-pci 0000:01:09.1: irq 18, io mem 0xfdefe000
[    2.905681] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[    2.905681] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.905681] usb usb5: Product: OHCI PCI host controller
[    2.905681] usb usb5: Manufacturer: Linux 4.18.7-100.fc27.x86_64 ohci_hcd
[    2.905681] usb usb5: SerialNumber: 0000:01:09.1
[    2.907742] hub 5-0:1.0: USB hub found
[    2.907742] hub 5-0:1.0: 2 ports detected
[    2.907958] uhci_hcd: USB Universal Host Controller Interface driver
[    2.908062] usbcore: registered new interface driver usbserial_generic
[    2.908071] usbserial: USB Serial support registered for generic
[    2.908109] i8042: PNP: No PS/2 controller found.
[    2.908205] mousedev: PS/2 mouse device common for all mice
[    2.908374] rtc_cmos 00:02: RTC can wake from S4
[    2.908606] rtc_cmos 00:02: registered as rtc0
[    2.908609] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    2.908711] device-mapper: uevent: version 1.0.3
[    2.908813] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    2.909247] hidraw: raw HID events driver (C) Jiri Kosina
[    2.909318] usbcore: registered new interface driver usbhid
[    2.909319] usbhid: USB HID core driver
[    2.909490] drop_monitor: Initializing network drop monitor service
[    2.909639] Initializing XFRM netlink socket
[    2.909886] NET: Registered protocol family 10
[    2.914385] Segment Routing with IPv6
[    2.914425] mip6: Mobile IPv6
[    2.914430] NET: Registered protocol family 17
[    2.914852] RAS: Correctable Errors collector initialized.
[    2.915086] registered taskstats version 1
[    2.915102] Loading compiled-in X.509 certificates
[    2.990763] Loaded X.509 cert 'Fedora kernel signing key: 1d3a42cfcd57b98edd0bb8152d108c4c86b766a2'
[    2.990763] zswap: loaded using pool lzo/zbud
[    2.995358] Key type big_key registered
[    2.999158] Key type encrypted registered
[    2.999171] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    2.999177] ima: Allocated hash algorithm: sha1
[    2.999714]   Magic number: 2:827:142
[    2.999815] acpi device:13: hash matches
[    2.999923] rtc_cmos 00:02: setting system clock to 2018-09-23 19:08:11 UTC (1537729691)
[    3.000010] Unstable clock detected, switching default tracing clock to "global"
               If you want to keep using the local clock, then add:
                 "trace_clock=local"
               on the kernel command line
[    3.005705] Freeing unused kernel image memory: 2160K
[    3.051139] Write protecting the kernel read-only data: 18432k
[    3.052133] Freeing unused kernel image memory: 2012K
[    3.052133] Freeing unused kernel image memory: 84K
[    3.062384] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.062384] rodata_test: all tests were successful
[    3.068920] systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[    3.068920] systemd[1]: Detected architecture x86-64.
[    3.068920] systemd[1]: Running in initial RAM disk.
[    3.068920] systemd[1]: Set hostname to <files>.
[    3.175658] random: systemd: uninitialized urandom read (16 bytes read)
[    3.175658] systemd[1]: Reached target Local File Systems.
[    3.175658] random: systemd: uninitialized urandom read (16 bytes read)
[    3.175658] systemd[1]: Reached target Timers.
[    3.175658] random: systemd: uninitialized urandom read (16 bytes read)
[    3.175658] systemd[1]: Listening on udev Control Socket.
[    3.175658] systemd[1]: Listening on udev Kernel Socket.
[    3.175658] systemd[1]: Listening on Journal Audit Socket.
[    3.175658] systemd[1]: Created slice System Slice.
[    3.217691] audit: type=1130 audit(1537729691.716:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.217691] audit: type=1130 audit(1537729691.716:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.230206] usb 3-3: new low-speed USB device number 2 using ohci-pci
[    3.231130] audit: type=1130 audit(1537729691.729:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.249129] audit: type=1130 audit(1537729691.729:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.318098] audit: type=1130 audit(1537729691.817:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.342608] audit: type=1130 audit(1537729691.817:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.357269] audit: type=1130 audit(1537729691.856:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.469102] audit: type=1130 audit(1537729691.961:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.469110] audit: type=1131 audit(1537729691.961:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.482815] usb 3-3: New USB device found, idVendor=0461, idProduct=4d8a, bcdDevice= 1.00
[    3.482815] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.482815] usb 3-3: Product: HP USB Multimedia Keyboard
[    3.482815] usb 3-3: Manufacturer: NOVATEK
[    3.494046] input: NOVATEK HP USB Multimedia Keyboard as /devices/pci0000:00/0000:00:02.0/usb3/3-3/3-3:1.0/0003:0461:4D8A.0001/input/input2
[    3.550293] hid-generic 0003:0461:4D8A.0001: input,hidraw0: USB HID v1.11 Keyboard [NOVATEK HP USB Multimedia Keyboard] on usb-0000:00:02.0-3/input0
[    3.557181] input: NOVATEK HP USB Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:02.0/usb3/3-3/3-3:1.1/0003:0461:4D8A.0002/input/input3
[    3.612354] input: NOVATEK HP USB Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:02.0/usb3/3-3/3-3:1.1/0003:0461:4D8A.0002/input/input4
[    3.612468] hid-generic 0003:0461:4D8A.0002: input,hidraw1: USB HID v1.11 Device [NOVATEK HP USB Multimedia Keyboard] on usb-0000:00:02.0-3/input1
[    3.753283] pata_amd 0000:00:06.0: version 0.4.1
[    3.772536] scsi host0: pata_amd
[    3.772536] scsi host1: pata_amd
[    3.772536] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[    3.772536] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[    3.791889] sata_nv 0000:00:08.0: version 3.5
[    3.792253] PCI Interrupt Link [APSI] enabled at IRQ 20
[    3.792255] scsi host2: sata_nv
[    3.792255] scsi host3: sata_nv
[    3.792255] ata3: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd800 irq 20
[    3.792255] ata4: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd808 irq 20
[    3.796026] PCI Interrupt Link [APSJ] enabled at IRQ 21
[    3.838176] scsi host4: sata_nv
[    3.859461] scsi host5: sata_nv
[    3.859569] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400 irq 21
[    3.859571] ata6: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma 0xc408 irq 21
[    3.921302] ata2: port disabled--ignoring
[    4.082859] usb 3-4: new low-speed USB device number 3 using ohci-pci
[    4.274321] PCI Interrupt Link [APC8] enabled at IRQ 16
[    4.274535] nouveau 0000:02:00.0: NVIDIA GF119 (0d90a0a1)
[    4.357004] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.370465] ata5.00: ATA-9: ST2000DM001-1CH164, CC27, max UDMA/133
[    4.370468] ata5.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    4.372073] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.382947] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    4.382949] ata3.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    4.387356] nouveau 0000:02:00.0: bios: version 75.19.56.00.04
[    4.415394] nouveau 0000:02:00.0: fb: 1024 MiB DDR3
[    4.421993] ata3.00: configured for UDMA/133
[    4.422235] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB51 PQ: 0 ANSI: 5
[    4.422628] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    4.422631] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    4.422651] sd 2:0:0:0: [sda] Write Protect is off
[    4.422654] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.422686] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.422980] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    4.427649] ata5.00: configured for UDMA/133
[    4.456778] usb 3-4: New USB device found, idVendor=1267, idProduct=0210, bcdDevice=22.70
[    4.456778] usb 3-4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    4.456778] usb 3-4: Product: PS/2+USB Mouse
[    4.468077] input: PS/2+USB Mouse as /devices/pci0000:00/0000:00:02.0/usb3/3-4/3-4:1.0/0003:1267:0210.0003/input/input5
[    4.469196] hid-generic 0003:1267:0210.0003: input,hidraw2: USB HID v1.00 Mouse [PS/2+USB Mouse] on usb-0000:00:02.0-4/input0
[    4.492850] [TTM] Zone  kernel: Available graphics memory: 1535648 kiB
[    4.492854] [TTM] Initializing pool allocator
[    4.492861] [TTM] Initializing DMA pool allocator
[    4.492882] nouveau 0000:02:00.0: DRM: VRAM: 1024 MiB
[    4.492884] nouveau 0000:02:00.0: DRM: GART: 1048576 MiB
[    4.492891] nouveau 0000:02:00.0: DRM: TMDS table version 2.0
[    4.492893] nouveau 0000:02:00.0: DRM: DCB version 4.0
[    4.492896] nouveau 0000:02:00.0: DRM: DCB outp 00: 02000300 00000000
[    4.492899] nouveau 0000:02:00.0: DRM: DCB outp 01: 01000302 00020030
[    4.492901] nouveau 0000:02:00.0: DRM: DCB outp 02: 02011362 00020010
[    4.492903] nouveau 0000:02:00.0: DRM: DCB outp 03: 04022310 00000000
[    4.492906] nouveau 0000:02:00.0: DRM: DCB conn 00: 00001030
[    4.492908] nouveau 0000:02:00.0: DRM: DCB conn 01: 00002161
[    4.492909] nouveau 0000:02:00.0: DRM: DCB conn 02: 00000200
[    4.494218] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.494218] [drm] Driver supports precise vblank timestamp query.
[    4.503683] nouveau 0000:02:00.0: DRM: MM: using COPY0 for buffer copies
[    4.587075] nouveau 0000:02:00.0: DRM: allocated 1280x1024 fb: 0x60000, bo (____ptrval____)
[    4.639345] usb 1-5: new high-speed USB device number 4 using ehci-pci
[    4.639359] fbcon: nouveaufb (fb0) is primary device
[    4.685932] Console: switching to colour frame buffer device 160x64
[    4.688654] nouveau 0000:02:00.0: fb0: nouveaufb frame buffer device
[    4.755195] [drm] Initialized nouveau 1.3.1 20120801 for 0000:02:00.0 on minor 0
[    4.831601]  sda: sda1 sda2
[    4.865001] sd 2:0:0:0: [sda] Attached SCSI disk
[    4.918461] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.946770] ata4.00: ATA-8: ST2000DL003-9VT166, CC32, max UDMA/133
[    4.946775] ata4.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    4.962799] usb 1-5: New USB device found, idVendor=0644, idProduct=0200, bcdDevice= 4.08
[    4.962804] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.962806] usb 1-5: Product: CA-200
[    4.962808] usb 1-5: Manufacturer: TEAC
[    4.962810] usb 1-5: SerialNumber: 000004838F9D
[    4.988710] ata4.00: configured for UDMA/133
[    4.990091] scsi 3:0:0:0: Direct-Access     ATA      ST2000DL003-9VT1 CC32 PQ: 0 ANSI: 5
[    4.990477] sd 3:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    4.990478] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    4.990500] sd 3:0:0:0: [sdb] Write Protect is off
[    4.990503] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.990535] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.990754] scsi 4:0:0:0: Direct-Access     ATA      ST2000DM001-1CH1 CC27 PQ: 0 ANSI: 5
[    4.991175] sd 4:0:0:0: Attached scsi generic sg2 type 0
[    4.991198] sd 4:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    4.991198] sd 4:0:0:0: [sdc] 4096-byte physical blocks
[    4.991198] sd 4:0:0:0: [sdc] Write Protect is off
[    4.991198] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    4.991198] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.010697]  sdb: sdb1 sdb2
[    5.011293] sd 3:0:0:0: [sdb] Attached SCSI disk
[    5.017071]  sdc: sdc1 sdc2
[    5.017621] sd 4:0:0:0: [sdc] Attached SCSI disk
[    5.062045] random: fast init done
[    5.305944] usb-storage 1-5:1.0: USB Mass Storage device detected
[    5.306872] scsi host6: usb-storage 1-5:1.0
[    5.307035] usbcore: registered new interface driver usb-storage
[    5.310976] usbcore: registered new interface driver uas
[    5.513522] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.517032] ata6.00: ATA-9: ST2000DM001-1CH164, CC27, max UDMA/133
[    5.517037] ata6.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    5.567409] ata6.00: configured for UDMA/133
[    5.567773] scsi 5:0:0:0: Direct-Access     ATA      ST2000DM001-1CH1 CC27 PQ: 0 ANSI: 5
[    5.568309] sd 5:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    5.568313] sd 5:0:0:0: [sdd] 4096-byte physical blocks
[    5.568333] sd 5:0:0:0: [sdd] Write Protect is off
[    5.568336] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    5.568367] sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.568503] sd 5:0:0:0: Attached scsi generic sg3 type 0
[    5.597309]  sdd: sdd1 sdd2
[    5.597900] sd 5:0:0:0: [sdd] Attached SCSI disk
[    5.605539] random: crng init done
[    5.605539] random: 7 urandom warning(s) missed due to ratelimiting
[    5.821391] raid6: sse2x1   gen()  6968 MB/s
[    5.898393] raid6: sse2x1   xor()  5300 MB/s
[    5.996232] raid6: sse2x2   gen()  8937 MB/s
[    6.068138] raid6: sse2x2   xor()  6673 MB/s
[    6.108909] raid6: sse2x4   gen()  3687 MB/s
[    6.173564] raid6: sse2x4   xor()  2642 MB/s
[    6.173564] raid6: using algorithm sse2x2 gen() 8937 MB/s
[    6.173564] raid6: .... xor() 6673 MB/s, rmw enabled
[    6.173564] raid6: using intx1 recovery algorithm
[    6.176410] async_tx: api initialized (async)
[    6.177770] xor: measuring software checksum speed
[    6.185336] md/raid1:md127: active with 4 out of 4 mirrors
[    6.367103]    prefetch64-sse: 235372.000 MB/sec
[    6.651796]    generic_sse: 199648.000 MB/sec
[    6.651798] xor: using function: prefetch64-sse (235372.000 MB/sec)
[    6.652124] md127: detected capacity change from 0 to 4999610368
[    6.662472] scsi 6:0:0:0: Direct-Access     TEAC     USB   HS-CF Card 4.08 PQ: 0 ANSI: 0
[    6.666451] scsi 6:0:0:1: Direct-Access     TEAC     USB   HS-xD/SM   4.08 PQ: 0 ANSI: 0
[    6.670181] scsi 6:0:0:2: Direct-Access     TEAC     USB   HS-MS Card 4.08 PQ: 0 ANSI: 0
[    6.673552] scsi 6:0:0:3: Direct-Access     TEAC     USB   HS-SD Card 4.08 PQ: 0 ANSI: 0
[    6.674065] sd 6:0:0:0: Attached scsi generic sg4 type 0
[    6.674354] sd 6:0:0:1: Attached scsi generic sg5 type 0
[    6.674555] sd 6:0:0:2: Attached scsi generic sg6 type 0
[    6.674763] sd 6:0:0:3: Attached scsi generic sg7 type 0
[    6.688553] md/raid:md126: device sdd2 operational as raid disk 3
[    6.688553] md/raid:md126: device sdc2 operational as raid disk 2
[    6.688553] md/raid:md126: device sdb2 operational as raid disk 1
[    6.688553] md/raid:md126: device sda2 operational as raid disk 0
[    6.704237] md/raid:md126: raid level 5 active with 4 out of 4 devices, algorithm 2
[    6.733254] md126: detected capacity change from 0 to 5985779318784
[    6.924473] kauditd_printk_skb: 3 callbacks suppressed
[    6.924473] audit: type=1130 audit(1537729695.423:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.933559] sd 6:0:0:3: [sdh] Attached SCSI removable disk
[    6.933559] sd 6:0:0:0: [sde] Attached SCSI removable disk
[    6.943325] sd 6:0:0:1: [sdf] Attached SCSI removable disk
[    6.947812] sd 6:0:0:2: [sdg] Attached SCSI removable disk
[    6.960656] audit: type=1130 audit(1537729695.446:15): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-mount comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.400468] audit: type=1130 audit(1537729695.895:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.556528] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: (null)
[    7.765231] audit: type=1130 audit(1537729696.259:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.765231] audit: type=1131 audit(1537729696.259:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.797880] audit: type=1130 audit(1537729696.294:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.816396] audit: type=1131 audit(1537729696.315:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.816671] audit: type=1130 audit(1537729696.315:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.816671] audit: type=1131 audit(1537729696.315:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.816671] audit: type=1130 audit(1537729696.315:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.237326] systemd-journald[154]: Received SIGTERM from PID 1 (systemd).
[    8.464208] systemd: 17 output lines suppressed due to ratelimiting
[    8.868494] SELinux:  Disabled at runtime.
[    8.868525] SELinux:  Unregistering netfilter hooks
[   12.165831] kauditd_printk_skb: 26 callbacks suppressed
[   12.165834] audit: type=1130 audit(1537729700.636:50): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.165840] audit: type=1131 audit(1537729700.636:51): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.166419] audit: type=1130 audit(1537729700.636:52): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.166441] audit: type=1131 audit(1537729700.636:53): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.167871] audit: type=1130 audit(1537729700.636:54): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.167896] audit: type=1131 audit(1537729700.636:55): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.219136] audit: type=1305 audit(1537729700.708:56): audit_enabled=1 old=1 auid=4294967295 ses=4294967295 res=1
[   12.482525] audit: type=1130 audit(1537729700.979:57): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.483413] audit: type=1130 audit(1537729700.979:58): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.608243] EXT4-fs (md126): re-mounted. Opts: (null)
[   12.611150] audit: type=1130 audit(1537729701.110:59): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.736705] systemd-journald[551]: Received request to flush runtime journal from PID 1
[   13.106886] RPC: Registered named UNIX socket transport module.
[   13.106890] RPC: Registered udp transport module.
[   13.106891] RPC: Registered tcp transport module.
[   13.106891] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   13.585206] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   14.280422] i2c i2c-12: nForce2 SMBus adapter at 0x1c00
[   14.280422] i2c i2c-13: nForce2 SMBus adapter at 0x1c40
[   14.316314] forcedeth: Reverse Engineered nForce ethernet driver. Version 0.64.
[   14.316314] PCI Interrupt Link [APCH] enabled at IRQ 23
[   14.646690] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   14.646690] r8169 0000:01:0a.0: not PCI Express
[   14.646690] r8169 0000:01:0a.0 eth0: RTL8110s, c0:3f:0e:41:de:ea, XID 04000000, IRQ 18
[   14.646690] r8169 0000:01:0a.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[   14.878054] forcedeth 0000:00:07.0: ifname eth1, PHY OUI 0x732 @ 1, addr 00:1a:a0:6a:f3:44
[   14.878059] forcedeth 0000:00:07.0: highdma pwrctl mgmt lnktim msi desc-v3
[   15.107278] PCI Interrupt Link [AAZA] enabled at IRQ 22
[   15.107278] snd_hda_intel 0000:00:05.0: Disabling MSI
[   15.108533] PCI Interrupt Link [APC5] enabled at IRQ 16
[   15.108533] snd_hda_intel 0000:02:00.1: Disabling MSI
[   15.108533] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[   15.286628] k8temp 0000:00:18.3: Temperature readouts might be wrong - check erratum #141
[   15.286628] k8temp 0000:00:18.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   15.319256] dell_smm_hwmon: unable to get SMM Dell signature
[   15.480713] forcedeth 0000:00:07.0 enp0s7: renamed from eth1
[   15.480713] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   15.614473] r8169 0000:01:0a.0 enp1s10: renamed from eth0
[   15.641529] kvm: disabled by bios
[   15.707254] MCE: In-kernel MCE decoding enabled.
[   15.777888] EDAC amd64: Node 0: DRAM ECC disabled.
[   15.777888] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   15.818006] powernow_k8: [Firmware Bug]: No compatible ACPI _PSS objects found.
               [Firmware Bug]: First, make sure Cool'N'Quiet is enabled in the BIOS.
               [Firmware Bug]: If that doesn't help, try upgrading your BIOS.
[   16.648325] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:09.0/0000:02:00.1/sound/card1/input6
[   16.648353] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:09.0/0000:02:00.1/sound/card1/input7
[   17.068091] EXT4-fs (md127): mounting ext2 file system using the ext4 subsystem
[   17.324133] EXT4-fs (md127): mounted filesystem without journal. Opts: (null)
[   17.345588] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC888: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   17.345588] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   17.377633] kauditd_printk_skb: 11 callbacks suppressed
[   17.377637] audit: type=1130 audit(1537729705.870:71): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   17.554329] audit: type=1130 audit(1537729706.027:72): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   17.554371] audit: type=1131 audit(1537729706.027:73): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   17.723348] audit: type=1130 audit(1537729706.215:74): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   17.723355] audit: type=1131 audit(1537729706.215:75): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   17.882671] audit: type=1130 audit(1537729706.374:76): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.269339] audit: type=1130 audit(1537729706.767:77): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-idmapd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.320335] audit: type=1305 audit(1537729706.806:78): audit_enabled=1 old=1 auid=4294967295 ses=4294967295 res=1
[   18.320343] audit: type=1305 audit(1537729706.806:79): audit_pid=694 old=0 auid=4294967295 ses=4294967295 res=1
[   22.351518] IPv6: ADDRCONF(NETDEV_UP): enp0s7: link is not ready
[   22.351518] forcedeth 0000:00:07.0 enp0s7: MSI enabled
[   22.351518] forcedeth 0000:00:07.0 enp0s7: no link during initialization
[   22.351518] IPv6: ADDRCONF(NETDEV_UP): enp0s7: link is not ready
[   22.358340] IPv6: ADDRCONF(NETDEV_UP): enp1s10: link is not ready
[   22.377143] r8169 0000:01:0a.0 enp1s10: link down
[   22.377769] r8169 0000:01:0a.0 enp1s10: link down
[   22.377781] IPv6: ADDRCONF(NETDEV_UP): enp1s10: link is not ready
[   24.643947] input: HDA NVidia Front Mic as /devices/pci0000:00/0000:00:05.0/sound/card0/input8
[   24.643947] input: HDA NVidia Rear Mic as /devices/pci0000:00/0000:00:05.0/sound/card0/input9
[   24.643947] input: HDA NVidia Line as /devices/pci0000:00/0000:00:05.0/sound/card0/input10
[   24.643947] input: HDA NVidia Line Out Front as /devices/pci0000:00/0000:00:05.0/sound/card0/input11
[   24.643947] input: HDA NVidia Line Out Surround as /devices/pci0000:00/0000:00:05.0/sound/card0/input12
[   24.643947] input: HDA NVidia Line Out CLFE as /devices/pci0000:00/0000:00:05.0/sound/card0/input13
[   24.643947] input: HDA NVidia Line Out Side as /devices/pci0000:00/0000:00:05.0/sound/card0/input14
[   24.643947] input: HDA NVidia Front Headphone as /devices/pci0000:00/0000:00:05.0/sound/card0/input15
[   25.775104] r8169 0000:01:0a.0 enp1s10: link up
[   25.775118] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s10: link becomes ready
[   28.661218] NFSD: starting 90-second grace period (net f0000098)
[38948.575127] INFO: rcu_sched detected stalls on CPUs/tasks:
[38948.575182] 	1-...!: (0 ticks this GP) idle=2bc/0/0 softirq=74524/74524 fqs=0 
[38948.575235] 	(detected by 0, t=60018 jiffies, g=50183, c=50182, q=380)
[38948.575287] Sending NMI from CPU 0 to CPUs 1:
[38948.575309] NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x2/0x10
[38948.576119] rcu_sched kthread starved for 60018 jiffies! g50183 c50182 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[38948.576119] RCU grace-period kthread stack dump:
[38948.576119] rcu_sched       I    0    10      2 0x80000000
[38948.576119] Call Trace:
[38948.576119]  ? __schedule+0x25c/0x860
[38948.576119]  ? __switch_to_asm+0x40/0x70
[38948.576119]  schedule+0x28/0x80
[38948.576119]  schedule_timeout+0x174/0x370
[38948.576119]  ? __next_timer_interrupt+0xc0/0xc0
[38948.576119]  rcu_gp_kthread+0x4b6/0x8c0
[38948.576119]  ? _synchronize_rcu_expedited.constprop.68+0x310/0x310
[38948.576119]  kthread+0x113/0x130
[38948.576119]  ? kthread_create_worker_on_cpu+0x70/0x70
[38948.576119]  ret_from_fork+0x35/0x40

--------------58ED236F023F903C31C918EF--
