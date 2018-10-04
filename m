Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F45EC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09B420856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqUXbuaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09B420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJDJxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:53:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43007 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeJDJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:53:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id h26-v6so7717668otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 20:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=aHNJUVGWc87kI6iamPVCYQvJQ+9QXBcwD7qisRxpR3w=;
        b=CqUXbuaMNmzoh5XIr84vQzFpMhtVBvBdBTcra4Mi4eOu6t6MdW7vW4KREhuaO6aH4/
         Qb559IXDFarVf+wiNt6qJ/cmymqeCWtXIyD9lQd+DplsuEYkS0OkxxG0m3Nnz4OuUuzk
         SrZPjHrZSmPIqq72MXQ6RpCvPvILDemtKvrFyGzDZJ1p/aqYD/j9tkfxEWUpPY/GdTti
         Fd6JiLdzCTyv6TtP1t8E8fR88qf2keEgLM0WPQUPLYXR4Gd2bdDcW3pfsUM1cQmsZVN/
         aqsQvTM41cVDAqfQm00VoK65LrCFx12iWwmO+igkI5gcTb95y+ioNGRA3K79EOs/OFdZ
         vsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=aHNJUVGWc87kI6iamPVCYQvJQ+9QXBcwD7qisRxpR3w=;
        b=FZ2oehaaXYIIvv56hsHg39e1tOz/JyvJ/soyBWYM/051U0+ou1d1g0ie8fKa2KVqGo
         yo+N7fW9Gj7uPT+NPrGKZMEVI+w94m7qJK7ZFh25LmvlH2BqT2ug5R3+unM6OAScZSMt
         UamO0jKMyfWUXxSFt+Jjo5iSDj8YCWSSu6KbFHC49R9LY+z77kk2qLeC9rfzJSEC0ACg
         QQER8ZcAXo8+0YKGKIFpAhccRjBtONWuentTv8oyIuvZDSHoSmobLzdyhW33iHYxzmuO
         ws1sxEISudRX5fdrvb1HTrQvwDhbn9D2GCdUP7EADTgqyQYs4oCsO12JV/TTZpAAJhMz
         ILxg==
X-Gm-Message-State: ABuFfogv9EHLiu0gUgEPQOVfcdIouGaTywRlv8mZ/QWcTmHVJnM92f4S
        QBjzGj7g5DbRFZ7P/XO2d8UT9fAI
X-Google-Smtp-Source: ACcGV60jstQVoQGOkio9rcQ/Eipv/rVUVLLWYGX8yJDjxRdVUCO0NI7SJ4lZ6S59sX4zjSynL7FaKA==
X-Received: by 2002:a9d:2ea9:: with SMTP id w38mr2704487ota.192.1538622146321;
        Wed, 03 Oct 2018 20:02:26 -0700 (PDT)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id u9-v6sm1181872otc.14.2018.10.03.20.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 20:02:25 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>, christoffer.dall@arm.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: kernel BUG at arch/arm/kvm/coproc.c:1406!
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6b134030-f9a4-1983-caac-5cfcc2be9776@gmail.com>
Date:   Wed, 3 Oct 2018 20:02:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seeing the following BUG_ON() being triggered on a Lamobo R1
(SUN7I/Cortex-A7), did not have the time to run a bisection since I was
chasing another regression. My guess would be that
3e8a8a50c7ef1a4f71921731f0e1748a7f70ddaa ("KVM: arm: vgic-v3: Add
support for ICC_SGI0R and ICC_ASGI1R accesses") is the culprit since it
does add new entries to cp15_regs[].

Thanks!

Uncompressing Linux... done, booting the kernel.



[    0.000000] Booting Linux on physical CPU 0x0



[    0.000000] Linux version 4.19.0-rc5+ (florian@bender) (gcc version
7.3.0 (OpenWrt GCC 7.3.0 r8056-4fca0e889673)) #0 SMP PREEMPT Wed Sep 12
00:19:51 2018

[    0.000000] CPU: ARMv7 Processor [410fc074] revision 4 (ARMv7),
cr=30c5387d


[    0.000000] CPU: div instructions available: patching division code



[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache


[    0.000000] OF: fdt: Machine model: Lamobo R1



[    0.000000] bootconsole [earlycon0] enabled



[    0.000000] Memory policy: Data cache writealloc



[    0.000000] psci: probing for conduit method from DT.



[    0.000000] psci: Using PSCI v0.1 Function IDs from DT



[    0.000000] random: get_random_bytes called from
start_kernel+0x98/0x4f8 with crng_init=0


[    0.000000] percpu: Embedded 17 pages/cpu @(ptrval) s40844 r8192
d20596 u69632


[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
260608


[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk
root=/dev/mmcblk0p2 rootwait


[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)


[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)


[    0.000000] Memory: 1026088K/1048576K available (7106K kernel code,
693K rwdata, 1620K rodata, 2048K init, 252K bss, 22488K reserved, 0K
cma-reserved, 262144K highmem)

[    0.000000] Virtual kernel memory layout:



[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)



[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)



[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)



[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)



[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)



[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)



[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (9123 kB)



[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (2048 kB)



[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 694 kB)



[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 253 kB)



[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2,
Nodes=1


[    0.000000] ftrace: allocating 25465 entries in 75 pages



[    0.000000] rcu: Preemptible hierarchical RCU implementation.



[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to
nr_cpu_ids=2.


[    0.000000]  Tasks RCU enabled.



[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16,
nr_cpu_ids=2


[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16



[    0.000000] GIC: Using split EOI/Deactivate mode



[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).



[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns


[    0.000008] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps
every 4398046511097ns


[    0.008005] Switching to timer-based delay loop, resolution 41ns



[    0.014376] clocksource: timer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635851949 ns


[    0.023773] clocksource: hstimer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370868154 ns


[    0.033325] Console: colour dummy device 80x30



[    0.037819] Calibrating delay loop (skipped), value calculated using
timer frequency.. 48.00 BogoMIPS (lpj=240000)


[    0.048187] pid_max: default: 32768 minimum: 301



[    0.052962] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes)


[    0.059600] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)


[    0.067270] CPU: Testing write buffer coherency: ok



[    0.072642] /cpus/cpu@0 missing clock-frequency property



[    0.077964] /cpus/cpu@1 missing clock-frequency property



[    0.083323] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000



[    0.143531] Setting up static identity map for 0x40200000 -
0x40200060


[    0.150249] rcu: Hierarchical SRCU implementation.



[    0.195224] smp: Bringing up secondary CPUs ...



[    0.265699] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001



[    0.265883] smp: Brought up 1 node, 2 CPUs



[    0.275699] SMP: Total of 2 processors activated (96.00 BogoMIPS).



[    0.281871] CPU: All CPU(s) started in HYP mode.



[    0.286498] CPU: Virtualization extensions available.



[    0.299610] VFP support v0.3: implementor 41 architecture 2 part 30
variant 7 rev 4


[    0.308215] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns


[    0.318130] futex hash table entries: 512 (order: 3, 32768 bytes)



[    0.324653] pinctrl core: initialized pinctrl subsystem



[    0.331725] NET: Registered protocol family 16



[    0.336539] DMA: preallocated 256 KiB pool for atomic coherent
allocations


[    0.346011] No ATAGs?



[    0.346151] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
watchpoint registers.


[    0.356470] hw-breakpoint: maximum watchpoint size is 8 bytes.



[    0.439264] SCSI subsystem initialized



[    0.443426] usbcore: registered new interface driver usbfs



[    0.451004] usbcore: registered new interface driver hub



[    0.456575] usbcore: registered new device driver usb



[    0.462285] pps_core: LinuxPPS API ver. 1 registered



[    0.467253] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>


[    0.476478] PTP clock support registered



[    0.480847] Advanced Linux Sound Architecture Driver Initialized.



[    0.488639] clocksource: Switched to clocksource arch_sys_counter



[    0.593639] NET: Registered protocol family 2



[    0.598892] tcp_listen_portaddr_hash hash table entries: 512 (order:
0, 6144 bytes)


[    0.606569] TCP established hash table entries: 8192 (order: 3, 32768
bytes)


[    0.613748] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)



[    0.620333] TCP: Hash tables configured (established 8192 bind 8192)



[    0.626834] UDP hash table entries: 512 (order: 2, 16384 bytes)



[    0.632856] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)



[    0.639880] NET: Registered protocol family 1



[    0.644703] kvm [1]: 8-bit VMID



[    0.648317] kvm [1]: vgic interrupt IRQ16



[    0.652470] kvm [1]: reg table (ptrval) out of order (41)



[    0.657878] ------------[ cut here ]------------



[    0.662488] kernel BUG at arch/arm/kvm/coproc.c:1406!



[    0.667533] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM



[    0.673359] Modules linked in:



[    0.676421] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5+ #0



[    0.682764] Hardware name: Allwinner sun7i (A20) Family



[    0.687995] PC is at kvm_coproc_table_init+0xa8/0xb8



[    0.692959] LR is at vprintk_emit+0xac/0x1e8



[    0.697223] pc : [<c0218ca8>]    lr : [<c029ad60>]    psr: 20000113



[    0.703471] sp : ef11fe18  ip : ef11fd50  fp : ef11fe2c



[    0.708688] r10: c0c8d018  r9 : c0e05170  r8 : 00000000



[    0.713905] r7 : c0e04c84  r6 : c0eadd58  r5 : c0e04d54  r4 :
00000008


[    0.720423] r3 : e126e865  r2 : e126e865  r1 : 2eb34000  r0 :
00000001


[    0.726942] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment user


[    0.734066] Control: 30c5387d  Table: 40003000  DAC: fffffffd



[    0.739804] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))



[    0.745802] Stack: (0xef11fe18 to 0xef120000)



[    0.750155] fe00:
  00000008 c0e04d54


[    0.758324] fe20: ef11fe6c ef11fe30 c021d1e0 c0218c0c c0c59a18
c0e04c54 00000001 e126e865


[    0.766493] fe40: c0c02a30 c0e04c54 c0e97680 00000000 c021ac30
00000000 00000000 c0c00714


[    0.774662] fe60: ef11febc ef11fe70 c020f0c4 c021ce40 00000164
00000000 c0e8b340 e126e865


[    0.782831] fe80: ef11fec4 00000f60 c08cfad4 e126e865 ef11feac
c0e04c54 c0e97680 00000000


[    0.791000] fea0: c021ac30 ffffe000 c0c59834 c0c00714 ef11fecc
ef11fec0 c021ac58 c020f098


[    0.799169] fec0: ef11ff44 ef11fed0 c020341c c021ac3c c09d59c4
c09d59a4 c09d59f0 c09e307c


[    0.807338] fee0: c0e04c54 00000000 00000000 c09d5938 c0a2c760
00000006 00000006 c0e9abd8


[    0.815507] ff00: c0c00714 c0a84598 ef11ff2c efffce35 00000000
e126e865 00000000 e126e865


[    0.823676] ff20: c0e97680 c0c8bb08 00000007 c0ead740 c0ead740
c0c59834 ef11ff94 ef11ff48


[    0.831845] ff40: c0c01380 c02033c4 00000006 00000006 00000000
c0c00714 ef11ff7c ef11ff68


[    0.840013] ff60: c0a84598 000000a6 ffffe000 00000000 c08e73c0
00000000 00000000 00000000


[    0.848182] ff80: 00000000 00000000 ef11ffac ef11ff98 c08e73d8
c0c010b0 00000000 c08e73c0


[    0.856351] ffa0: 00000000 ef11ffb0 c02011f8 c08e73cc 00000000
00000000 00000000 00000000


[    0.864519] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000


[    0.872688] ffe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000


[    0.880878] [<c0218ca8>] (kvm_coproc_table_init) from [<c021d1e0>]
(kvm_arch_init+0x3ac/0x4b8)


[    0.889486] [<c021d1e0>] (kvm_arch_init) from [<c020f0c4>]
(kvm_init+0x38/0x2b0)


[    0.896878] [<c020f0c4>] (kvm_init) from [<c021ac58>]
(arm_init+0x28/0x2c)


[    0.903751] [<c021ac58>] (arm_init) from [<c020341c>]
(do_one_initcall+0x64/0x288)


[    0.911321] [<c020341c>] (do_one_initcall) from [<c0c01380>]
(kernel_init_freeable+0x2dc/0x374)


[    0.920016] [<c0c01380>] (kernel_init_freeable) from [<c08e73d8>]
(kernel_init+0x18/0x128)


[    0.928276] [<c08e73d8>] (kernel_init) from [<c02011f8>]
(ret_from_fork+0x14/0x3c)


[    0.935833] Exception stack(0xef11ffb0 to 0xef11fff8)



[    0.940879] ffa0:                                     00000000
00000000 00000000 00000000


[    0.949047] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000


[    0.957214] ffe0: 00000000 00000000 00000000 00000000 00000013
00000000


[    0.963825] Code: e89da830 e3e02000 e1e03312 eafffff9 (e7f001f2)



[    0.969931] ---[ end trace cc97e2085c3575af ]---



[    0.974544] Kernel panic - not syncing: Fatal exception



[    0.979773] CPU1: stopping



[    0.982486] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
4.19.0-rc5+ #0


[    0.990216] Hardware name: Allwinner sun7i (A20) Family



[    0.995453] [<c02394d8>] (unwind_backtrace) from [<c02347fc>]
(show_stack+0x20/0x24)


[    1.003195] [<c02347fc>] (show_stack) from [<c08d0040>]
(dump_stack+0x90/0xa4)


[    1.010415] [<c08d0040>] (dump_stack) from [<c0237568>]
(handle_IPI+0x424/0x438)


[    1.017807] [<c0237568>] (handle_IPI) from [<c0202360>]
(gic_handle_irq+0x9c/0xa0)


[    1.025371] [<c0202360>] (gic_handle_irq) from [<c0201b38>]
(__irq_svc+0x58/0x8c)


[    1.032841] Exception stack(0xef155f30 to 0xef155f78)



[    1.037888] 5f20:                                     00000000
00000614 ef7d66cc c0243e40


[    1.046057] 5f40: ffffe000 c0e04c7c c0e04cb8 00000002 00000001
c0e972eb c09d6ae4 ef155f8c


[    1.054224] 5f60: ef155f90 ef155f80 c0230d40 c0230d44 60000013
ffffffff


[    1.060840] [<c0201b38>] (__irq_svc) from [<c0230d44>]
(arch_cpu_idle+0x48/0x4c)


[    1.068237] [<c0230d44>] (arch_cpu_idle) from [<c08eeac4>]
(default_idle_call+0x30/0x3c)


[    1.076326] [<c08eeac4>] (default_idle_call) from [<c027da48>]
(do_idle+0xf4/0x164)


[    1.083980] [<c027da48>] (do_idle) from [<c027ddac>]
(cpu_startup_entry+0x28/0x2c)


[    1.091546] [<c027ddac>] (cpu_startup_entry) from [<c0236e78>]
(secondary_start_kernel+0x190/0x1b4)


[    1.100577] [<c0236e78>] (secondary_start_kernel) from [<4020294c>]
(0x4020294c)


[    1.107971] Rebooting in 1 seconds..



[    3.111688] Reboot failed -- System halted
-- 
Florian
