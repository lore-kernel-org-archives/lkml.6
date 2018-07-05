Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F47C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6724053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiJ7+ein"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE6724053
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeGEQTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:19:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42923 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbeGEQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:19:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id v9-v6so5862929pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/PDY1x+Oj5o/ai6Ry0d5b1Qmuv4UguZYH8p5HfQB8KY=;
        b=uiJ7+einmZqf8K0YJNCELDJ0dmV2iiMr3XLU0kj5uCigXgi1KHY/3H6EQpCGnu5409
         r6LKtj1Eao8CL6caLOxdGA4+dckdkXPiiKLMlE8yv410XQQuh91Tp54V4zuZjZQ84Wl/
         3EgN/WI4m9p7qnVKiQgOA+dq0cjIhP8F500DO5P/biOpfvvcl27xpS5bKCKASjwrmNOG
         rd8xZitpcQ9ItoRDAy3Ax9g8lKPKLOg8lsYE2Wako/4M2fCiwJ1pVx3JRge/w4lODOh5
         YDtB7UeBKNk+MmzJq0Mw3vqGfiJzDr8B7G8pzIFlK7iFXCvPMvuxUt1zt1jLQiKKx24e
         5wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/PDY1x+Oj5o/ai6Ry0d5b1Qmuv4UguZYH8p5HfQB8KY=;
        b=K6YpxMM61LLLkFFy3VB0csKl0oBt9yjppMkqCu2aN2+QJfGvl0+i5WzO/g82fJCghY
         sfcTLe25j6XZ9XAzedsqhKZ6OcKIyNED98LZ1aKfGjdxvMrHAEyUqIvrCPo2PH5EO8ea
         AC1JZuyFplfJXkJQKBKtfDC2sJ6zLCVrNLC0thPL4JuTZd19Gxp5ZsM+4lNtIKV22EHw
         7kLwgUMXDa1OPMQsoGc9zAHVU+cJiwCu7KxysVDLBWXze9v1TtCrSjEuy+LTixOOHuUs
         LMnywqPZwUc/Q13Y4L8aT/R+VbqaKKrKHIti0ENlmop4wl/7NLLxH6F2ev9WkdAAqi9E
         +TbQ==
X-Gm-Message-State: APt69E1nRJISQexltrCX3nJUwBGv2fAf31Lzz72jAdPRdl/KGfYD7l8y
        M+ft1vPlrxgPEHyzdPtVYul95QutahQMw/JuLJWzAw==
X-Google-Smtp-Source: AAOMgpfsmx7FjOlbER0E36871D5wQnW5TEAn5hFqTpPBEmItmVifqSy0uE8c6cMIne/+TElbu0kb4EGr7pVHJsYXoeE=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr6364487pgp.334.1530807547553;
 Thu, 05 Jul 2018 09:19:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:18:47
 -0700 (PDT)
In-Reply-To: <0000000000002a71b20570394434@google.com>
References: <0000000000002a71b20570394434@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:18:47 +0200
Message-ID: <CACT4Y+Z-QeH=4qLDsQU41CF+hF9vEB0LXHjswZ79JHnoGXyMwA@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __run_timers
To:     syzbot <syzbot+833f0280096341307b18@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gargi Sharma <gs051095@gmail.com>, jhugo@codeaurora.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 6:49 AM, syzbot
<syzbot+833f0280096341307b18@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15438ad0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=833f0280096341307b18
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c1f4c2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16310594400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+833f0280096341307b18@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in lookup_object lib/debugobjects.c:157
> [inline]
> BUG: KASAN: stack-out-of-bounds in debug_object_deactivate+0x425/0x450
> lib/debugobjects.c:540
> Read of size 8 at addr ffff8801ca8254e8 by task swapper/0/0
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  lookup_object lib/debugobjects.c:157 [inline]
>  debug_object_deactivate+0x425/0x450 lib/debugobjects.c:540
>  debug_timer_deactivate kernel/time/timer.c:714 [inline]
>  debug_deactivate kernel/time/timer.c:770 [inline]
>  detach_timer kernel/time/timer.c:815 [inline]
>  expire_timers kernel/time/timer.c:1353 [inline]
>  __run_timers+0x571/0xc70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
>  ? __sanitizer_cov_trace_const_cmp4+SeaBIOS (version
> 1.8.2-20171130_102032-google)
> Linux version 4.18.0-rc3+ (syzkaller@ci) (gcc version 8.0.1 20180413
> (experimental) (GCC)) #45 SMP Wed Jul 4 07:02:20 UTC 2018
> Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0
> earlyprintk=serial vsyscall=native rodata=n ftrace_dump_on_oops=orig_cpu
> oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 kvm-intel.nested=1
> nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000
> nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000
> nf-conntrack-sane.ports=20000 nopcid
> x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using
> 'standard' format.
> BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000bfff2fff] usable
> BIOS-e820: [mem 0x00000000bfff3000-0x00000000bfffffff] reserved
> BIOS-e820: [mem 0x00000000fffbc000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000021fffffff] usable
> bootconsole [earlyser0] enabled
> Malformed early option 'vsyscall'
> nopcid: PCID feature disabled
> NX (Execute Disable) protection: active
> SMBIOS 2.4 present.
> DMI: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> Hypervisor detected: KVM
> last_pfn = 0x220000 max_arch_pfn = 0x400000000
> x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> last_pfn = 0xbfff3 max_arch_pfn = 0x400000000
> found SMP MP-table at [mem 0x000f2310-0x000f231f] mapped at
> [(____ptrval____)]
> Scanning 1 areas for low memory corruption
> Using GB pages for direct mapping
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x00000000000F22D0 000014 (v00 Google)
> ACPI: RSDT 0x00000000BFFF3430 000038 (v01 Google GOOGRSDT 00000001 GOOG
> 00000001)
> ACPI: FACP 0x00000000BFFFCF60 0000F4 (v02 Google GOOGFACP 00000001 GOOG
> 00000001)
> ACPI: DSDT 0x00000000BFFF3470 0017B2 (v01 Google GOOGDSDT 00000001 GOOG
> 00000001)
> ACPI: FACS 0x00000000BFFFCF00 000040
> ACPI: FACS 0x00000000BFFFCF00 000040
> ACPI: SSDT 0x00000000BFFF65F0 00690D (v01 Google GOOGSSDT 00000001 GOOG
> 00000001)
> ACPI: APIC 0x00000000BFFF5D10 000076 (v01 Google GOOGAPIC 00000001 GOOG
> 00000001)
> ACPI: WAET 0x00000000BFFF5CE0 000028 (v01 Google GOOGWAET 00000001 GOOG
> 00000001)
> ACPI: SRAT 0x00000000BFFF4C30 0000C8 (v01 Google GOOGSRAT 00000001 GOOG
> 00000001)
> SRAT: PXM 0 -> APIC 0x00 -> Node 0
> SRAT: PXM 0 -> APIC 0x01 -> Node 0
> ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
> ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x21fffffff]
> NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] ->
> [mem 0x00000000-0xbfffffff]
> NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x21fffffff] ->
> [mem 0x00000000-0x21fffffff]
> NODE_DATA(0) allocated [mem 0x21fffa000-0x21fffdfff]
> kvm-clock: cpu 0, msr 2:1fff8001, primary cpu clock
> kvm-clock: Using msrs 4b564d01 and 4b564d00
> kvm-clock: using sched offset of 5084926845 cycles
> clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb,
> max_idle_ns: 881590591483 ns
> Zone ranges:
>   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   [mem 0x0000000100000000-0x000000021fffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000001000-0x000000000009efff]
>   node   0: [mem 0x0000000000100000-0x00000000bfff2fff]
>   node   0: [mem 0x0000000100000000-0x000000021fffffff]
> Initmem setup node 0 [mem 0x0000000000001000-0x000000021fffffff]
> Reserved but unavailable: 111 pages
> kasan: KernelAddressSanitizer initialized
> ACPI: PM-Timer IO Port: 0xb008
> ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> Using ACPI (MADT) for SMP configuration information
> smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> PM: Registered nosave memory: [mem 0xbfff3000-0xbfffffff]
> PM: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
> PM: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
> [mem 0xc0000000-0xfffbbfff] available for PCI devices
> Booting paravirtualized kernel on KVM
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 1910969940391419 ns
> random: get_random_bytes called from boot_init_stack_canary
> arch/x86/include/asm/stackprotector.h:75 [inline] with crng_init=0
> random: get_random_bytes called from start_kernel+0x112/0x949
> init/main.c:559 with crng_init=0
> setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
> percpu: Embedded 56 pages/cpu @(____ptrval____) s188616 r8192 d32568
> u1048576
> Built 1 zonelists, mobility grouping on.  Total pages: 1935228
> Policy zone: Normal
> Kernel command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0
> earlyprintk=serial vsyscall=native rodata=n ftrace_dump_on_oops=orig_cpu
> oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 kvm-intel.nested=1
> nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000
> nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000
> nf-conntrack-sane.ports=20000 nopcid
> Memory: 6499788K/7863876K available (110620K kernel code, 12321K rwdata,
> 16056K rodata, 3968K init, 23144K bss, 1364088K reserved, 0K cma-reserved)
> Running RCU self tests
> Hierarchical RCU implementation.
>         RCU lockdep checking is enabled.
>         RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
>         RCU callback double-/use-after-free debug enabled.
> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
> Console: colour VGA+ 80x25
> console [ttyS0] enabled
> console [ttyS0] enabled
> bootconsole [earlyser0] disabled
> bootconsole [earlyser0] disabled
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     32768
> ... MAX_LOCKDEP_CHAINS:      65536
> ... CHAINHASH_SIZE:          32768
>  memory used by lock dependency info: 7391 kB
>  per task-struct memory footprint: 1920 bytes
> ACPI: Core revision 20180531
> APIC: Switch to symmetric I/O mode setup
> x2apic enabled
> Switched APIC routing to physical x2apic.
> ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
> tsc: Detected 2300.000 MHz processor
> clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212735223b2,
> max_idle_ns: 440795277976 ns
> Calibrating delay loop (skipped) preset value.. 4600.00 BogoMIPS
> (lpj=2300000)
> pid_max: default: 32768 minimum: 301
> Security Framework initialized
> Yama: becoming mindful.
> SELinux:  Initializing.
> AppArmor: AppArmor disabled by boot time parameter
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
> CPU: Physical Processor ID: 0
> mce: CPU supports 32 MCE banks
> Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
> Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> Spectre V2 : Mitigation: Full generic retpoline
> Speculative Store Bypass: Vulnerable
> Freeing SMP alternatives memory: 64K
> smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f,
> stepping: 0x0)
> Performance Events: unsupported p6 CPU model 63 no PMU driver, software
> events only.
> Hierarchical SRCU implementation.
> NMI watchdog: Perf event create on CPU 0 failed with -2
> NMI watchdog: Perf NMI watchdog permanently disabled
> smp: Bringing up secondary CPUs ...
> x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1
> kvm-clock: cpu 1, msr 2:1fff8041, secondary cpu clock
> smp: Brought up 1 node, 2 CPUs
> smpboot: Max logical packages: 1
> smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
> devtmpfs: initialized
> kworker/u4:0 (24) used greatest stack depth: 24072 bytes left
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
> 1911260446275000 ns
> futex hash table entries: 512 (order: 4, 65536 bytes)
> xor: automatically using best checksumming function   avx
> RTC time:  1:09:13, date: 07/05/18
> NET: Registered protocol family 16
> audit: initializing netlink subsys (disabled)
> audit: type=2000 audit(1530752952.920:1): state=initialized audit_enabled=0
> res=1
> kworker/u4:1 (40) used greatest stack depth: 23840 bytes left
> cpuidle: using governor menu
> ACPI: bus type PCI registered
> PCI: Using configuration type 1 for base access
> kworker/u4:3 (167) used greatest stack depth: 21704 bytes left
> HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> cryptd: max_cpu_qlen set to 1000
> raid6: sse2x1   gen()  1707 MB/s
> raid6: sse2x1   xor()  1011 MB/s
> raid6: sse2x2   gen()  3695 MB/s
> raid6: sse2x2   xor()  1945 MB/s
> raid6: sse2x4   gen()  6042 MB/s
> raid6: sse2x4   xor()  3408 MB/s
> raid6: avx2x1   gen()   968 MB/s
> raid6: avx2x1   xor()  1904 MB/s
> raid6: avx2x2   gen()  4250 MB/s
> raid6: avx2x2   xor()  3867 MB/s
> raid6: avx2x4   gen() 11429 MB/s
> raid6: avx2x4   xor()  5939 MB/s
> raid6: using algorithm avx2x4 gen() 11429 MB/s
> raid6: .... xor() 5939 MB/s, rmw enabled
> raid6: using avx2x2 recovery algorithm
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: Added _OSI(Linux-Dell-Video)
> ACPI: 2 ACPI AML tables successfully acquired and loaded
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and
> report a bug
> ACPI: Enabled 16 GPEs in block 00 to 0F
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI
> configuration space under this bridge.
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
> ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> vgaarb: loaded
> SCSI subsystem initialized
> ACPI: bus type USB registered
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> pps_core: LinuxPPS API ver. 1 registered
> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
> <giometti@linux.it>
> PTP clock support registered
> EDAC MC: Ver: 3.0.0
> Advanced Linux Sound Architecture Driver Initialized.
> PCI: Using ACPI for IRQ routing
> Bluetooth: Core ver 2.22
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO socket layer initialized
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> NetLabel: Initializing
> NetLabel:  domain hash size = 128
> NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> NetLabel:  unlabeled traffic allowed by default
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002a71b20570394434%40google.com.
> For more options, visit https://groups.google.com/d/optout.
