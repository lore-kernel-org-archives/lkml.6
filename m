Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DBECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C4620858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C4620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeGMVz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:55:29 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:44124 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGMVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:55:28 -0400
Received: by mail-it0-f70.google.com with SMTP id z8-v6so8569656itc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=95AjT7ny7qC8Gtw4p8JIK303mL9aMeo08DXkSIIh2So=;
        b=bc13wLfE7sHgswFHKSJW0QdiV/+GKbwbuE8w8FvJvdTNNiL55f7RFCl8AZEWuK6wpx
         reM+vLbRafeLo/MyiykYqcm8gvQzNGxf2yeoQXTXLfykS0ZzlDYq5e5sevQ3n1wfRtM1
         6edtqUWAgv4M2GjSqD7DUUN1TZ/goIVsGLvMmj6SttPTmALOmubMHTiGmq0owDs8B2dD
         k36zIuEVpNMsERjAVm9Pes0NW5pKwANUIOZokFFAkH5xlyrcYIFLVtZoJ0qY/3eDquAl
         vv6rm7U8rK6sPea4NM3HtnJnVr6t/2XWBCeJeJ6F9jOX5d55lPMPYGGKXbYbn9DhJlFr
         GhUA==
X-Gm-Message-State: AOUpUlF9rBHB+Xf5Jm0LCBkt4d5KTw5f4lHJchijMlkv3o0mHmW2G2ZA
        bRq6Vi2s0dKLYxAdNq0wU6KRvQ4KWJNp9bJLlkv7/faokxR3
X-Google-Smtp-Source: AAOMgpeMTlyJMnQl5U5z5cAb/glH6+XNESAnhDsTWoFHsl7NxSWgHWhVr7Ufed0vcekHJVkBL79bPNa6L84PAUzTDJA62IRYePcS
MIME-Version: 1.0
X-Received: by 2002:a24:27c8:: with SMTP id g191-v6mr3292169ita.20.1531517942315;
 Fri, 13 Jul 2018 14:39:02 -0700 (PDT)
Date:   Fri, 13 Jul 2018 14:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb546f0570e84e90@google.com>
Subject: unexpected kernel reboot (3)
From:   syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, gs051095@gmail.com,
        jhugo@codeaurora.org, jpoimboe@redhat.com, lauraa@codeaurora.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mingo@kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e4b044d2251 Linux 4.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c6a6d0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=cce9ef2dd25246f815ee
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=165012c2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1571462c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com

output_len: 0x00000000092459b0
kernel_total_size: 0x000000000a505000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.18.0-rc4+ (syzkaller@ci) (gcc version 8.0.1  
20180413 (experimental) (GCC)) #138 SMP Mon Jul 9 10:45:11 UTC 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1  
console=ttyS0 earlyprintk=serial vsyscall=native rodata=n  
ftrace_dump_on_oops=orig_cpu oops=panic panic_on_warn=1 nmi_watchdog=panic  
panic=86400 workqueue.watchdog_thresh=140 kvm-intel.nested=1  
nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000  
nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000  
nf-conntrack-sane.ports=20000 nopcid
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point  
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832  
bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]  
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]  
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfff2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfff3000-0x00000000bfffffff]  
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffbc000-0x00000000ffffffff]  
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021fffffff] usable
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] Malformed early option 'vsyscall'
[    0.000000] nopcid: PCID feature disabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Google Google Compute Engine/Google Compute Engine,  
BIOS Google 01/01/2011
[    0.000000] Hypervisor detected: KVM
[    0.000000] last_pfn = 0x220000 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000000] last_pfn = 0xbfff3 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f2310-0x000f231f] mapped at  
[(____ptrval____)]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F22D0 000014 (v00 Google)
[    0.000000] ACPI: RSDT 0x00000000BFFF3430 000038 (v01 Google GOOGRSDT  
00000001 GOOG 00000001)
[    0.000000] ACPI: FACP 0x00000000BFFFCF60 0000F4 (v02 Google GOOGFACP  
00000001 GOOG 00000001)
[    0.000000] ACPI: DSDT 0x00000000BFFF3470 0017B2 (v01 Google GOOGDSDT  
00000001 GOOG 00000001)
[    0.000000] ACPI: FACS 0x00000000BFFFCF00 000040
[    0.000000] ACPI: FACS 0x00000000BFFFCF00 000040
[    0.000000] ACPI: SSDT 0x00000000BFFF65F0 00690D (v01 Google GOOGSSDT  
00000001 GOOG 00000001)
[    0.000000] ACPI: APIC 0x00000000BFFF5D10 000076 (v01 Google GOOGAPIC  
00000001 GOOG 00000001)
[    0.000000] ACPI: WAET 0x00000000BFFF5CE0 000028 (v01 Google GOOGWAET  
00000001 GOOG 00000001)
[    0.000000] ACPI: SRAT 0x00000000BFFF4C30 0000C8 (v01 Google GOOGSRAT  
00000001 GOOG 00000001)
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x21fffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem  
0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem  
0x100000000-0x21fffffff] -> [mem 0x00000000-0x21fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21fffa000-0x21fffdfff]
[    0.000000] kvm-clock: cpu 0, msr 2:1fff8001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 3687300352 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:  
0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bfff2fff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021fffffff]
[    0.000000] Initmem setup node 0 [mem  
0x0000000000001000-0x000000021fffffff]
[    0.000000] Reserved but unavailable: 111 pages
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] ACPI: PM-Timer IO Port: 0xb008
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI  
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbfff3000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[    0.000000] [mem 0xc0000000-0xfffbbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:  
0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] random: get_random_bytes called from boot_init_stack_canary  
arch/x86/include/asm/stackprotector.h:75 [inline] with crng_init=0
[    0.000000] random: get_random_bytes called from  
start_kernel+0x112/0x949 init/main.c:559 with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2  
nr_node_ids:1
[    0.000000] percpu: Embedded 56 pages/cpu @(____ptrval____) s188488  
r8192 d32696 u1048576
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:  
1935228
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1  
console=ttyS0 earlyprintk=serial vsyscall=native rodata=n  
ftrace_dump_on_oops=orig_cpu oops=panic panic_on_warn=1 nmi_watchdog=panic  
panic=86400 workqueue.watchdog_thresh=140 kvm-intel.nested=1  
nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000  
nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000  
nf-conntrack-sane.ports=20000 nopcid
[    0.000000] Memory: 6499784K/7863876K available (110620K kernel code,  
12325K rwdata, 16060K rodata, 3968K init, 23144K bss, 1364092K reserved, 0K  
cma-reserved)
[    0.001000] Running RCU self tests
[    0.001000] Hierarchical RCU implementation.
[    0.001000] 	RCU lockdep checking is enabled.
[    0.001000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.001000] 	RCU callback double-/use-after-free debug enabled.
[    0.001000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.001000] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    0.001000] Console: colour VGA+ 80x25
[    0.001000] console [ttyS0] enabled
[    0.001000] console [ttyS0] enabled
[    0.001000] bootconsole [earlyser0] disabled
[    0.001000] bootconsole [earlyser0] disabled
[    0.001000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,  
Ingo Molnar
[    0.001000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001000] ... MAX_LOCK_DEPTH:          48
[    0.001000] ... MAX_LOCKDEP_KEYS:        8191
[    0.001000] ... CLASSHASH_SIZE:          4096
[    0.001000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001000] ... CHAINHASH_SIZE:          32768
[    0.001000]  memory used by lock dependency info: 7391 kB
[    0.001000]  per task-struct memory footprint: 1920 bytes
[    0.001000] ACPI: Core revision 20180531
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.001276] x2apic enabled
[    0.003015] Switched APIC routing to physical x2apic.
[    0.006936] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
[    0.007000] tsc: Detected 2300.000 MHz processor
[    0.007036] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:  
0x212735223b2, max_idle_ns: 440795277976 ns
[    0.008027] Calibrating delay loop (skipped) preset value.. 4600.00  
BogoMIPS (lpj=2300000)
[    0.009009] pid_max: default: 32768 minimum: 301
[    0.010429] Security Framework initialized
[    0.011013] Yama: becoming mindful.
[    0.011564] SELinux:  Initializing.
[    0.012346] AppArmor: AppArmor disabled by boot time parameter
[    0.017471] Dentry cache hash table entries: 1048576 (order: 11, 8388608  
bytes)
[    0.021318] Inode-cache hash table entries: 524288 (order: 10, 4194304  
bytes)
[    0.022150] Mount-cache hash table entries: 16384 (order: 5, 131072  
bytes)
[    0.024021] Mountpoint-cache hash table entries: 16384 (order: 5, 131072  
bytes)
[    0.026898] CPU: Physical Processor ID: 0
[    0.027057] mce: CPU supports 32 MCE banks
[    0.028147] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.029009] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.030027] Spectre V2 : Mitigation: Full generic retpoline
[    0.030811] Speculative Store Bypass: Vulnerable
[    0.032237] Freeing SMP alternatives memory: 64K
[    0.035000] smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6,  
model: 0x3f, stepping: 0x0)
[    0.036166] Performance Events: unsupported p6 CPU model 63 no PMU  
driver, software events only.
[    0.037220] Hierarchical SRCU implementation.
[    0.038513] NMI watchdog: Perf event create on CPU 0 failed with -2
[    0.039010] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.040411] smp: Bringing up secondary CPUs ...
[    0.043141] x86: Booting SMP configuration:
[    0.043767] .... node  #0, CPUs:      #1
[    0.001000] kvm-clock: cpu 1, msr 2:1fff8041, secondary cpu clock
[    0.045621] smp: Brought up 1 node, 2 CPUs
[    0.046038] smpboot: Max logical packages: 1
[    0.047014] smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
[    0.050023] devtmpfs: initialized
[    0.061128] kworker/u4:0 (24) used greatest stack depth: 24072 bytes left
[    0.063068] clocksource: jiffies: mask: 0xffffffff max_cycles:  
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.064070] futex hash table entries: 512 (order: 4, 65536 bytes)
[    0.065665] xor: automatically using best checksumming function   avx
[    0.067163] RTC time: 23:50:08, date: 07/09/18
[    0.076126] NET: Registered protocol family 16
[    0.079027] audit: initializing netlink subsys (disabled)
[    0.082322] audit: type=2000 audit(1531180208.790:1): state=initialized  
audit_enabled=0 res=1
[    0.082489] kworker/u4:0 (38) used greatest stack depth: 23840 bytes left
[    0.083070] cpuidle: using governor menu
[    0.085961] ACPI: bus type PCI registered
[    0.087459] PCI: Using configuration type 1 for base access
[    0.116756] kworker/u4:1 (191) used greatest stack depth: 22816 bytes  
left
[    0.251466] kworker/u4:3 (813) used greatest stack depth: 21704 bytes  
left
[    0.264515] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.267167] cryptd: max_cpu_qlen set to 1000
[    0.286038] raid6: sse2x1   gen()  1058 MB/s
[    0.303018] raid6: sse2x1   xor()  1003 MB/s
[    0.320027] raid6: sse2x2   gen()  3699 MB/s
[    0.337015] raid6: sse2x2   xor()  2000 MB/s
[    0.354013] raid6: sse2x4   gen()  6117 MB/s
[    0.371011] raid6: sse2x4   xor()  3408 MB/s
[    0.388022] raid6: avx2x1   gen()  3949 MB/s
[    0.405023] raid6: avx2x1   xor()  2044 MB/s
[    0.422012] raid6: avx2x2   gen()  7105 MB/s
[    0.439013] raid6: avx2x2   xor()  3931 MB/s
[    0.456012] raid6: avx2x4   gen() 12011 MB/s
[    0.473011] raid6: avx2x4   xor()  6335 MB/s
[    0.473676] raid6: using algorithm avx2x4 gen() 12011 MB/s
[    0.474011] raid6: .... xor() 6335 MB/s, rmw enabled
[    0.475009] raid6: using avx2x2 recovery algorithm
[    0.476621] ACPI: Added _OSI(Module Device)
[    0.477025] ACPI: Added _OSI(Processor Device)
[    0.477644] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.478150] ACPI: Added _OSI(Processor Aggregator Device)
[    0.479020] ACPI: Added _OSI(Linux-Dell-Video)
[    0.667606] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    1.151332] ACPI: Interpreter enabled
[    1.152209] ACPI: (supports S0 S3 S4 S5)
[    1.152779] ACPI: Using IOAPIC for interrupt routing
[    1.153189] PCI: Using host bridge windows from ACPI; if necessary,  
use "pci=nocrs" and report a bug
[    1.156742] ACPI: Enabled 16 GPEs in block 00 to 0F
[    1.735035] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.736047] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments  
MSI]
[    1.737102] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.738167] acpi PNP0A03:00: fail to add MMCONFIG information, can't  
access extended PCI configuration space under this bridge.
[    1.743316] PCI host bridge to bus 0000:00
[    1.743969] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.744021] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.745019] pci_bus 0000:00: root bus resource [mem  
0x000a0000-0x000bffff window]
[    1.746019] pci_bus 0000:00: root bus resource [mem  
0xc0000000-0xfebfffff window]
[    1.747021] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.781185] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by  
PIIX4 ACPI
[    1.837777] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.841143] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.844264] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.847361] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.849429] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    2.211211] vgaarb: loaded
[    2.213323] SCSI subsystem initialized
[    2.215397] ACPI: bus type USB registered
[    2.216494] usbcore: registered new interface driver usbfs
[    2.217282] usbcore: registered new interface driver hub
[    2.218238] usbcore: registered new device driver usb
[    2.220307] pps_core: LinuxPPS API ver. 1 registered
[    2.221017] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo  
Giometti <giometti@linux.it>
[    2.222080] PTP clock support registered
[    2.224122] EDAC MC: Ver: 3.0.0
[    2.229323] Advanced Linux Sound Architecture Driver Initialized.
[    2.230385] PCI: Using ACPI for IRQ routing
[    2.233917] Bluetooth: Core ver 2.22
[    2.234133] NET: Registered protocol family 31
[    2.235025] Bluetooth: HCI device and connection manager initialized
[    2.236039] Bluetooth: HCI socket layer initialized
[    2.237037] Bluetooth: L2CAP socket layer initialized
[    2.238129] Bluetooth: SCO socket layer initialized
[    2.238849] NET: Registered protocol family 8
[    2.239010] NET: Registered protocol family 20
[    2.240188] NetLabel: Initializing
[    2.240741] NetLabel:  domain hash size = 128
[    2.241009] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.242236] NetLabel:  unlabeled traffic allowed by default
[    2.244513] nfc: nfc_init: NFC Core ver 0.1
[    2.245242] NET: Registered protocol family 39
[    2.247238] clocksource: Switched to clocksource kvm-clock
[    2.730556] VFS: Disk quotas dquot_6.6.0
[    2.731344] VFS: Dquot-cache hash table entries: 512 (order 0, 4096  
bytes)
[    2.732778] FS-Cache: Loaded
[    2.733940] CacheFiles: Loaded
[    2.734644] pnp: PnP ACPI init
[    2.745177] pnp: PnP ACPI: found 7 devices
[    2.787732] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,  
max_idle_ns: 2085701024 ns
[    2.789942] NET: Registered protocol family 2
[    2.792534] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6,  
294912 bytes)
[    2.794163] TCP established hash table entries: 65536 (order: 7, 524288  
bytes)
[    2.797360] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
[    2.802317] TCP: Hash tables configured (established 65536 bind 65536)
[    2.804421] UDP hash table entries: 4096 (order: 7, 655360 bytes)
[    2.805840] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
[    2.807770] NET: Registered protocol family 1
[    2.809909] RPC: Registered named UNIX socket transport module.
[    2.810879] RPC: Registered udp transport module.
[    2.811567] RPC: Registered tcp transport module.
[    2.812236] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.814244] NET: Registered protocol family 44
[    2.814936] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.816660] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.817618] software IO TLB [mem 0xbbff3000-0xbfff3000] (64MB) mapped at  
[(____ptrval____)-(____ptrval____)]
[    2.820236] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters,  
10737418240 ms ovfl timer
[    2.821433] RAPL PMU: hw unit of domain pp0-core 2^-0 Joules
[    2.822239] RAPL PMU: hw unit of domain package 2^-0 Joules
[    2.823046] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    2.824118] VPID CAP should not exist if not support 1-setting enable  
VPID VM-execution control
[    2.827661] kvm: already loaded the other module
[    2.828759] Machine check injector initialized
[    2.832780] Scanning for low memory corruption every 60 seconds
[    2.869858] Initialise system trusted keyrings
[    2.871581] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    2.876642] DLM installed
[    2.878845] NFS: Registering the id_resolver key type
[    2.879715] Key type id_resolver registered
[    2.880336] Key type id_legacy registered
[    2.880923] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.881905] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    2.884574] ntfs: driver 2.1.32 [Flags: R/W].
[    2.885749] fuse init (API version 7.27)
[    2.887944] JFS: nTxBlock = 8192, nTxLock = 65536
[    2.895884] SGI XFS with ACLs, security attributes, realtime, no debug  
enabled
[    2.899068] 9p: Installing v9fs 9p2000 file system support
[    2.899873] FS-Cache: Netfs '9p' registered for caching
[    2.903337] gfs2: GFS2 installed
[    2.905189] FS-Cache: Netfs 'ceph' registered for caching
[    2.905948] ceph: loaded (mds proto 32)
[    2.935887] NET: Registered protocol family 38
[    2.937491] async_tx: api initialized (async)
[    2.938288] Key type asymmetric registered
[    2.938903] Asymmetric key parser 'x509' registered
[    2.939616] Key type pkcs7_test registered
[    2.940390] Block layer SCSI generic (bsg) driver version 0.4 loaded  
(major 250)
[    2.941824] io scheduler noop registered
[    2.942491] io scheduler deadline registered
[    2.943253] io scheduler cfq registered (default)
[    2.943909] io scheduler mq-deadline registered
[    2.944558] io scheduler kyber registered
[    2.945224] io scheduler bfq registered
[    2.949801] input: Power Button as  
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.951274] ACPI: Power Button [PWRF]
[    2.952513] input: Sleep Button as  
/devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    2.953950] ACPI: Sleep Button [SLPF]
[    2.969156] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    2.970130] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy  
driver
[    2.981371] PCI Interrupt Link [LNKD] enabled at IRQ 10
[    2.982236] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy  
driver
[    2.987559] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.011074] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a  
16550A
[    3.036177] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a  
16550A
[    3.060461] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a  
16550A
[    3.085088] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a  
16550A
[    3.092161] Non-volatile memory driver v1.3
[    3.093887] Linux agpgart interface v0.103
[    3.096570] [drm] radeon kernel modesetting enabled.
[    3.097867] [drm] amdgpu kernel modesetting enabled.
[    3.136509] brd: module loaded
[    3.156103] loop: module loaded
[    3.199680] null: module loaded
[    3.202863] nfcsim 0.2 initialized
[    3.204173] Loading iSCSI transport class v2.0-870.
[    3.224950] scsi host0: Virtio SCSI HBA
[    3.278741] scsi 0:0:1:0: Direct-Access     Google   PersistentDisk    
1    PQ: 0 ANSI: 6
[    3.619321] random: fast init done
[    3.871317] tsc: Refined TSC clocksource calibration: 2299.848 MHz
[    3.872489] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:  
0x2126a59471c, max_idle_ns: 440795280417 ns
[    4.051580] sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (2.15  
GB/2.00 GiB)
[    4.053038] sd 0:0:1:0: [sda] 4096-byte physical blocks
[    4.054005] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    4.054689] sd 0:0:1:0: [sda] Write Protect is off
[    4.056801] sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled,  
doesn't support DPO or FUA
[    4.057662] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    4.075839] eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S.  
Miller (davem@redhat.com)
[    4.082787] MACsec IEEE 802.1AE
[    4.084211] tun: Universal TUN/TAP device driver, 1.6
[    4.090168]  sda: sda1
[    4.096308] sd 0:0:1:0: [sda] Attached SCSI disk
[    4.115739] vcan: Virtual CAN interface driver
[    4.116877] vxcan: Virtual CAN Tunnel driver
[    4.117782] slcan: serial line CAN interface driver
[    4.118727] slcan: 10 dynamic interface channels.
[    4.119630] CAN device driver interface
[    4.120748] enic: Cisco VIC Ethernet NIC Driver, ver 2.3.0.53
[    4.122290] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    4.123544] e100: Copyright(c) 1999-2006 Intel Corporation
[    4.124802] e1000: Intel(R) PRO/1000 Network Driver - version  
7.3.21-k8-NAPI
[    4.125915] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    4.127266] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.128375] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.129678] sky2: driver version 1.30
[    4.131666] PPP generic driver version 2.4.2
[    4.133413] PPP BSD Compression module registered
[    4.134316] PPP Deflate Compression module registered
[    4.135247] PPP MPPE Compression module registered
[    4.136171] NET: Registered protocol family 24
[    4.137135] PPTP driver version 0.8.5
[    4.138546] mac80211_hwsim: initializing netlink
[    4.151795] usbcore: registered new interface driver asix
[    4.153120] usbcore: registered new interface driver ax88179_178a
[    4.154756] usbcore: registered new interface driver cdc_ether
[    4.156228] usbcore: registered new interface driver net1080
[    4.157332] usbcore: registered new interface driver cdc_subset
[    4.158583] usbcore: registered new interface driver zaurus
[    4.159830] usbcore: registered new interface driver cdc_ncm
[    4.166750] aoe: AoE v85 initialised.
[    4.168571] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.170055] ehci-pci: EHCI PCI platform driver
[    4.170928] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.172466] ohci-pci: OHCI PCI platform driver
[    4.173447] uhci_hcd: USB Universal Host Controller Interface driver
[    4.175175] usbcore: registered new interface driver usblp
[    4.176421] usbcore: registered new interface driver usb-storage
[    4.178264] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at  
0x60,0x64 irq 1,12
[    4.180704] i8042: Warning: Keylock active
[    4.185766] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.186873] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.189883] mousedev: PS/2 mouse device common for all mice
[    4.195129] rtc_cmos 00:00: RTC can wake from S4
[    4.197629] rtc_cmos 00:00: registered as rtc0
[    4.198392] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
[    4.199601] i2c /dev entries driver
[    4.202279] piix4_smbus 0000:00:01.3: SMBus base address uninitialized -  
upgrade BIOS or use force_addr=0xaddr
[    4.204318] i2c-parport-light: adapter type unspecified
[    4.205464] usbcore: registered new interface driver RobotFuzz Open  
Source InterFace, OSIF
[    4.206992] usbcore: registered new interface driver i2c-tiny-usb
[    4.210196] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:  
dm-devel@redhat.com
[    4.212181] device-mapper: raid: Loading target version 1.13.2
[    4.214167] usbcore: registered new interface driver btusb
[    4.216842] usnic_verbs: Cisco VIC (USNIC) Verbs Driver v1.0.3 (December  
19, 2013)
[    4.218308] usnic_verbs:usnic_uiom_init:585:
[    4.218314] IOMMU required but not present or enabled.  USNIC QPs will  
not function w/o enabling IOMMU
[    4.221246] usnic_verbs:usnic_ib_init:649:
[    4.221252] Unable to initalize umem with err -1
[    4.223972] iscsi: registered transport (iser)
[    4.224940] OPA Virtual Network Driver - v1.0
[    4.233092] hidraw: raw HID events driver (C) Jiri Kosina
[    4.238672] usbcore: registered new interface driver usbhid
[    4.240181] usbhid: USB HID core driver
[    4.243319] NET: Registered protocol family 40
[    4.245444] ashmem: initialized
[    4.301535] NET: Registered protocol family 26
[    4.302705] Mirror/redirect action on
[    4.303369] Simple TC action Loaded
[    4.305549] netem: version 1.3
[    4.306442] u32 classifier
[    4.306881]     Actions configured
[    4.309592] nf_conntrack_irc: failed to register helpers
[    4.310817] nf_conntrack_sane: failed to register helpers
[    4.347790] nf_conntrack_sip: failed to register helpers
[    4.351566] xt_time: kernel timezone is -0000
[    4.352330] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[    4.353221] IPVS: Connection hash table configured (size=4096,  
memory=64Kbytes)
[    4.354864] IPVS: ipvs loaded.
[    4.355378] IPVS: [rr] scheduler registered.
[    4.355947] IPVS: [wrr] scheduler registered.
[    4.356690] IPVS: [lc] scheduler registered.
[    4.357411] IPVS: [wlc] scheduler registered.
[    4.357966] IPVS: [fo] scheduler registered.
[    4.358695] IPVS: [ovf] scheduler registered.
[    4.359320] IPVS: [lblc] scheduler registered.
[    4.359914] IPVS: [lblcr] scheduler registered.
[    4.360549] IPVS: [dh] scheduler registered.
[    4.361134] IPVS: [sh] scheduler registered.
[    4.361787] IPVS: [mh] scheduler registered.
[    4.362505] IPVS: [sed] scheduler registered.
[    4.363127] IPVS: [nq] scheduler registered.
[    4.363867] IPVS: ftp: loaded support on port[0] = 21
[    4.364617] IPVS: [sip] pe registered.
[    4.365354] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    4.367818] gre: GRE over IPv4 demultiplexor driver
[    4.368702] ip_gre: GRE over IPv4 tunneling driver
[    4.375584] IPv4 over IPsec tunneling driver
[    4.379441] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    4.381108] Initializing XFRM netlink socket
[    4.382089] NET: Registered protocol family 10
[    4.390304] Segment Routing with IPv6
[    4.391381] mip6: Mobile IPv6
[    4.395708] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.399963] input: AT Translated Set 2 keyboard as  
/devices/platform/i8042/serio0/input/input2
[    4.402417] ip6_gre: GRE over IPv6 tunneling driver
[    4.414889] bpfilter: Loaded bpfilter_umh pid 2226
Started bpfilter
[    4.417659] NET: Registered protocol family 17
[    4.418448] NET: Registered protocol family 15
[    4.419370] Bridge firewalling registered
[    4.420793] can: controller area network core (rev 20170425 abi 9)
[    4.421971] NET: Registered protocol family 29
[    4.422632] can: raw protocol (rev 20170425)
[    4.423371] can: broadcast manager protocol (rev 20170425 t)
[    4.424187] can: netlink gateway (rev 20170425) max_hops=1
[    4.425290] Bluetooth: RFCOMM TTY layer initialized
[    4.426234] Bluetooth: RFCOMM socket layer initialized
[    4.426996] Bluetooth: RFCOMM ver 1.11
[    4.427576] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.428327] Bluetooth: BNEP filters: protocol multicast
[    4.429074] Bluetooth: BNEP socket layer initialized
[    4.429790] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    4.430639] Bluetooth: HIDP socket layer initialized
[    4.431880] RPC: Registered rdma transport module.
[    4.432609] RPC: Registered rdma backchannel transport module.
[    4.433785] NET: Registered protocol family 41
[    4.434783] lec:lane_module_init: lec.c: initialized
[    4.435514] mpoa:atm_mpoa_init: mpc.c: initialized
[    4.436280] l2tp_core: L2TP core driver, V2.0
[    4.436928] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    4.437647] 8021q: 802.1Q VLAN Support v1.8
[    4.448256] DCCP: Activated CCID 2 (TCP-like)
[    4.448966] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[    4.450303] sctp: Hash tables configured (bind 64/64)
[    4.451927] NET: Registered protocol family 21
[    4.453840] Registered RDS/infiniband transport
[    4.455048] Registered RDS/tcp transport
[    4.455609] tipc: Activated (version 2.0.0)
[    4.456416] NET: Registered protocol family 30
[    4.457747] tipc: Started in single node mode
[    4.458537] NET: Registered protocol family 43
[    4.459408] 9pnet: Installing 9P2000 support
[    4.462714] NET: Registered protocol family 36
[    4.463664] Key type dns_resolver registered
[    4.464483] Key type ceph registered
[    4.465400] libceph: loaded (mon/osd proto 15/24)
[    4.466210] openvswitch: Open vSwitch switching datapath
[    4.468474] mpls_gso: MPLS GSO support
[    4.481116] AVX2 version of gcm_enc/dec engaged.
[    4.481786] AES CTR mode by8 optimization enabled
[    4.489137] sched_clock: Marking stable (4489098455, 0)->(5973777099,  
-1484678644)
[    4.492800] registered taskstats version 1
[    4.493466] Loading compiled-in X.509 certificates
[    4.494967] zswap: default zpool zbud not available
[    4.495913] zswap: pool creation failed
[    4.501246] Btrfs loaded, crc32c=crc32c-intel
[    4.504769] Key type big_key registered
[    4.506643] Key type encrypted registered
[    4.508723]   Magic number: 10:909:857
[    4.509390] bdi 8:0: hash matches
[    4.510492] console [netcon0] enabled
[    4.511047] netconsole: network logging started
[    4.512090] gtp: GTP module loaded (pdp ctx size 104 bytes)
[    4.514631] rdma_rxe: loaded
[    4.515450] cfg80211: Loading compiled-in X.509 certificates for  
regulatory database
[    4.519364] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.520839] platform regulatory.0: Direct firmware load for  
regulatory.db failed with error -2
[    4.522155] cfg80211: failed to load regulatory.db
[    4.522185] ALSA device list:
[    4.523499]   #0: Dummy 1
[    4.523951]   #1: Loopback 1
[    4.524389]   #2: Virtual MIDI Card 1
[    4.825991] input: ImExPS/2 Generic Explorer Mouse as  
/devices/platform/i8042/serio1/input/input4
[    4.829533] md: Waiting for all devices to be available before autodetect
[    4.830562] md: If you don't use raid, use raid=noautodetect
[    4.835237] md: Autodetecting RAID arrays.
[    4.835882] md: autorun ...
[    4.836364] md: ... autorun DONE.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
