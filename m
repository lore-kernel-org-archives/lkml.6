Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C07C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF964208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1/Sx4gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF964208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeHPCdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:33:22 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33642 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbeHPCdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:33:22 -0400
Received: by mail-lj1-f170.google.com with SMTP id s12-v6so2237426ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=acApT6WFnBjynuZaYxE9uDs/4nPTrU0lVGxXh11K02A=;
        b=O1/Sx4gjUVDFYxyyLSPwq5UgcSc2bi95vQ9JpteCWA5E4At7lZ0SFaa5Xx32TcHzEd
         VVyScCS9/JEL5ci962zWEx3e+fUYpdNW/UMrdopMTFj9PGRVPb3kUupPkstM/rPbY4XP
         KWdxBFyN9S8W89G3P4/He3AkScFowOChfc0fv2KnjHsjrbBIVDqUJ/sdo1kPwJw8Is0s
         H43F5D1zqTYAuEMX03jfqfgUrGnXW7S6lP0Pfi1zYxRPs10taC09a2tPknADI32f6q3r
         JcUg7QDIcE0u2I8dBRQamBKy9sAIKZ2LFgkWB32WRRQygpnzCCbf7uPH6KWP5sbTO+Z+
         DMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=acApT6WFnBjynuZaYxE9uDs/4nPTrU0lVGxXh11K02A=;
        b=Crp314QaNhqU9ehMDcV2drkykkevysyyx6v9Aou/9e77UsI+o8rMW6W/QbpzE5qwJe
         4bI7KBFthK25QOLtLpN0cuLMekEeQfePcS3wNb7AiUExIMNf8LmjhbOnQLmq7G+AR8ZT
         8kIjoaumSO2shKhBI265IENVZzdaGEAHXSWFKTL/QOkLBLdynpGuzd80dugHjk0iF4jC
         ih2otc+rxeKbEnWWPdC5JNIXp9GLNeafr4rz5seh955dQoZ2Dc3ANrVH3ku7ijGfue3r
         b/Kd4KkBeqfkq3prnEWS5jSYsm9MHM1xBWM8VoQdMD8lAsmC+3q7ssZIYrMwyo6yhAVB
         OR/g==
X-Gm-Message-State: AOUpUlEdYO03r1HNH+Mk/ST0qQD6J5NQops310u0w5YGTbhF8EUC4aAk
        DMpjR7JXLxq20DFEqDX5iYVXlb7F
X-Google-Smtp-Source: AA+uWPxvgG/B61j9JGSz+siHEchNYoIfAFW4dD8LmZt25dHairpmz9g23r0H8RG/2tdUktCYCoXOUw==
X-Received: by 2002:a2e:5d88:: with SMTP id v8-v6mr18603337lje.137.1534376333273;
        Wed, 15 Aug 2018 16:38:53 -0700 (PDT)
Received: from [10.112.23.205] (nat-eduroam-hy-138-172.fe.helsinki.fi. [128.214.138.172])
        by smtp.gmail.com with ESMTPSA id 97-v6sm4776834lfw.13.2018.08.15.16.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 16:38:52 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: AArch64 boot failure on Hikey960 on latest master after "arm64: insn:
 Don't fallback on nosync path for general insn patching"
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
Date:   Thu, 16 Aug 2018 02:38:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Booting Linus's master of today with the usual arm64 defconfig fails for
me on the Hikey960 board. I've bisected it down to:

commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Jun 19 17:55:28 2018 +0100

     arm64: insn: Don't fallback on nosync path for general insn patching

Here's the boot log with earlycon enabled after which the boot hangs:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.18.0-rc3-00017-g693350a79980 (tmtynkky@duuni) (gcc version 8.2.0 (Buildroot 2018.08-git-00807-g0184fa3)) #17 SMP PREEMPT Thu Aug 16 02:18:59 EEST 2018
[    0.000000] Machine model: HiKey960
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  MEMATTR=0xbe65d698
[    0.000000] cma: Reserved 32 MiB at 0x00000000bbc00000
[    0.000000] earlycon: pl11 at MMIO 0x00000000fff32000 (options '115200n8')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000000bfffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xbffbf240-0xbffc09ff]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000bfffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000001abfffff]
[    0.000000]   node   0: [mem 0x000000001ad88000-0x0000000031ffffff]
[    0.000000]   node   0: [mem 0x0000000032101000-0x000000003dffffff]
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000089b7ffff]
[    0.000000]   node   0: [mem 0x0000000089cc0000-0x00000000b9bdffff]
[    0.000000]   node   0: [mem 0x00000000b9be0000-0x00000000b9c7ffff]
[    0.000000]   node   0: [mem 0x00000000b9c80000-0x00000000b9d6ffff]
[    0.000000]   node   0: [mem 0x00000000b9d70000-0x00000000ba12ffff]
[    0.000000]   node   0: [mem 0x00000000ba130000-0x00000000ba130fff]
[    0.000000]   node   0: [mem 0x00000000ba131000-0x00000000ba134fff]
[    0.000000]   node   0: [mem 0x00000000ba135000-0x00000000bf0fffff]
[    0.000000]   node   0: [mem 0x00000000bf100000-0x00000000bf13ffff]
[    0.000000]   node   0: [mem 0x00000000bf140000-0x00000000bf14ffff]
[    0.000000]   node   0: [mem 0x00000000bf150000-0x00000000bf19ffff]
[    0.000000]   node   0: [mem 0x00000000bf1a0000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000bfffffff]
[    0.000000] On node 0 totalpages: 777271
[    0.000000]   DMA32 zone: 12288 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 777271 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] random: get_random_bytes called from start_kernel+0x94/0x400 with crng_init=0
[    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s56024 r8192 d29992 u94208
[    0.000000] pcpu-alloc: s56024 r8192 d29992 u94208 alloc=23*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 764983
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/linux-next-kernel/Image loglevel=8 console=ttyAMA6,115200n8 root=/dev/mmcblk0p2 clk_ignore_unused earlycon
[    0.000000] Memory: 2998448K/3109084K available (10428K kernel code, 1352K rwdata, 7108K rodata, 1216K init, 379K bss, 77868K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: cp15 timer(s) running at 1.92MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1c570327e, max_idle_ns: 1763180809505 ns
[    0.000004] sched_clock: 56 bits at 1920kHz, resolution 520ns, wraps every 4398046510977ns
[    0.008472] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58334160866034 ns
[    0.018760] Console: colour dummy device 80x25
[    0.023349] Calibrating delay loop (skipped), value calculated using timer frequency.. 3.84 BogoMIPS (lpj=7680)
[    0.033596] pid_max: default: 32768 minimum: 301
[    0.038337] Security Framework initialized
[    0.043842] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.051817] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.059009] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.065827] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.097149] ASID allocator initialised with 32768 entries
[    0.102693] Hierarchical SRCU implementation.
[    0.112378] Remapping and enabling EFI services.
[    0.121086] smp: Bringing up secondary CPUs ...
PU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.165989] Detected VIPT I-cache on CPU2
[    0.166013] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.186002] Detected VIPT I-cache on CPU3
[    0.186020] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.207565] CPU features: enabling workaround for ARM erratum 858921
[    0.207575] Detected VIPT I-cache on CPU4
[    0.207583] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
[    0.207614] CPU features: Unsupported CPU feature variation detected.
[    0.207643] BUG: scheduling while atomic: swapper/4/0/0x00000002
[    0.207645] Modules linked in:
[    0.207652] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                4.18.0-rc3-00017-g693350a79980 #17
[    0.207654] Hardware name: HiKey960 (DT)
[    0.207656] Call trace:
[    0.207670]  dump_backtrace+0x0/0x150
[    0.207674]  show_stack+0x14/0x20
[    0.207680]  dump_stack+0x90/0xbc
[    0.207685]  __schedule_bug+0x58/0x70
[    0.207690]  __schedule+0x51c/0x5b0
[    0.207693]  schedule+0x38/0xa0
[    0.207694]  schedule_timeout+0x23c/0x340
[    0.207698]  wait_for_common+0x140/0x170
[    0.207701]  wait_for_completion+0x14/0x20
[    0.207704]  __stop_cpus+0x68/0xa0
[    0.207706]  stop_cpus+0x40/0x60
[    0.207708]  stop_machine_cpuslocked+0xd4/0xf0
[    0.207711]  aarch64_insn_patch_text+0x48/0x70
[    0.207715]  arch_jump_label_transform+0x48/0x80
[    0.207718]  __jump_label_update+0xa4/0xf0
[    0.207721]  jump_label_update+0xe8/0x120
[    0.207724]  static_key_enable_cpuslocked+0x7c/0xc0
[    0.207730]  arch_timer_check_ool_workaround+0x190/0x1f0
[    0.207732]  arch_timer_starting_cpu+0xd8/0x290
[    0.207737]  cpuhp_invoke_callback+0x90/0x220
[    0.207739]  notify_cpu_starting+0x68/0xa0
[    0.207742]  secondary_start_kernel+0xe8/0x160
[    0.207754] bad: scheduling from the idle thread!
[    0.207756] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S      W         4.18.0-rc3-00017-g693350a79980 #17
[    0.207757] Hardware name: HiKey960 (DT)
[    0.207758] Call trace:
[    0.207761]  dump_backtrace+0x0/0x150
[    0.207764]  show_stack+0x14/0x20
[    0.207766]  dump_stack+0x90/0xbc
[    0.207769]  dequeue_task_idle+0x24/0x40
[    0.207771]  deactivate_task+0x70/0xc0
[    0.207774]  __schedule+0x2f8/0x5b0
[    0.207776]  schedule+0x38/0xa0
[    0.207778]  schedule_timeout+0x23c/0x340
[    0.207780]  wait_for_common+0x140/0x170
[    0.207783]  wait_for_completion+0x14/0x20
[    0.207784]  __stop_cpus+0x68/0xa0
[    0.207786]  stop_cpus+0x40/0x60
[    0.207788]  stop_machine_cpuslocked+0xd4/0xf0
[    0.207790]  aarch64_insn_patch_text+0x48/0x70
[    0.207792]  arch_jump_label_transform+0x48/0x80
[    0.207794]  __jump_label_update+0xa4/0xf0
[    0.207796]  jump_label_update+0xe8/0x120
[    0.207799]  static_key_enable_cpuslocked+0x7c/0xc0
[    0.207801]  arch_timer_check_ool_workaround+0x190/0x1f0
[    0.207804]  arch_timer_starting_cpu+0xd8/0x290
[    0.207806]  cpuhp_invoke_callback+0x90/0x220
[    0.207808]  notify_cpu_starting+0x68/0xa0
[    0.207810]  secondary_start_kernel+0xe8/0x160
[    0.207819] bad: scheduling from the idle thread!
[    0.207821] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S      W         4.18.0-rc3-00017-g693350a79980 #17
[    0.207822] Hardware name: HiKey960 (DT)
[    0.207823] Call trace:
[    0.207826]  dump_backtrace+0x0/0x150
[    0.207828]  show_stack+0x14/0x20
[    0.207830]  dump_stack+0x90/0xbc
[    0.207832]  dequeue_task_idle+0x24/0x40
[    0.207834]  deactivate_task+0x70/0xc0
[    0.207836]  __schedule+0x2f8/0x5b0
[    0.207839]  schedule+0x38/0xa0
[    0.207841]  schedule_timeout+0x23c/0x340
[    0.207843]  wait_for_common+0x140/0x170
[    0.207845]  wait_for_completion+0x14/0x20
[    0.207847]  __stop_cpus+0x68/0xa0
[    0.207848]  stop_cpus+0x40/0x60
[    0.207851]  stop_machine_cpuslocked+0xd4/0xf0
[    0.207853]  aarch64_insn_patch_text+0x48/0x70
[    0.207855]  arch_jump_label_transform+0x48/0x80
[    0.207857]  __jump_label_update+0xa4/0xf0
[    0.207859]  jump_label_update+0xe8/0x120
[    0.207861]  static_key_enable_cpuslocked+0x7c/0xc0
[    0.207864]  arch_timer_check_ool_workaround+0x190/0x1f0
[    0.207866]  arch_timer_starting_cpu+0xd8/0x290
[    0.207868]  cpuhp_invoke_callback+0x90/0x220
[    0.207870]  notify_cpu_starting+0x68/0xa0
[    0.207872]  secondary_start_kernel+0xe8/0x160
[    1.226177] CPU4: failed to come online
[    1.633614] CPU4: failed in unknown state : 0x0

Any idea what could be the problem?

Thanks in advance!
- Tuomas
