Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1314C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE620861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBE620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeIMPND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:13:03 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45079 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeIMPNC (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 13 Sep 2018 11:13:02 -0400
Received: from linux-9avr.suse (prg-ext-pat.suse.com [213.151.95.130])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 13 Sep 2018 12:03:38 +0200
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
 <2580518.z31CQjiopR@aspire.rjw.lan> <20180911110111.GF11418@zn.tnic>
 <441b2b19-1a73-4cde-913d-61a9f8072f08@suse.com>
 <s5hlg88z0un.wl-tiwai@suse.de>
From:   James Wang <jnwang@suse.com>
Openpgp: preference=signencrypt
Organization: QA-SLE
Message-ID: <8d9cf4b9-4c52-2e1d-6778-312c7a2fdffe@suse.com>
Date:   Thu, 13 Sep 2018 12:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hlg88z0un.wl-tiwai@suse.de>
Content-Type: multipart/mixed;
 boundary="------------F5519E624D0AD1E3F7DDA019"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F5519E624D0AD1E3F7DDA019
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 09/11/2018 02:15 PM, Takashi Iwai wrote:
> On Tue, 11 Sep 2018 14:11:30 +0200,
> James Wang wrote:
>> I did try it from kernel : head
> OK, then the bug is present with 4.19-rc2, at least.
> Please check my test kernel later (it's still being built).
Hi folks,  I attach two log about 4.19-rc3 and 4.19-rc3+Rafeal suggestion.


> Takashi
>
>> ⁣发自 BlueMail ​
>>
>> 2018年9月11日 19:01, 19:01，在 Borislav Petkov <bp@suse.de> 已写:
>>> On Tue, Sep 11, 2018 at 12:51:32PM +0200, Rafael J. Wysocki wrote:
>>>> that may help in principle, so any chance to try them on the affected
>>>> systems?
>>> Right, and I don't recall James trying the upstream kernel on his box.
>>> James?
>>>
>>> --
>>> Regards/Gruss,
>>>    Boris.
>>>
>>> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
>>> HRB 21284 (AG Nürnberg)
>>> --
>> [2  <text/html; utf-8 (quoted-printable)>]
>>

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)


--------------F5519E624D0AD1E3F7DDA019
Content-Type: text/x-log;
 name="takashi.the-latest-upstream.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="takashi.the-latest-upstream.log"


[    0.000000] Linux version 4.19.0-rc3-1.gd3995d7-default (geeko@buildhost) (gcc version 8.2.1 20180817 [gcc-8-branch revision 263612] (SUSE Linux)) #1 SMP PREEMPT Mon Sep 10 05:38:58 UTC 2018 (d3995d7)
[    0.000000] Command line: BOOT_IMAGE=/boot/loader-cO0lcw/linux install=http://apac2-kvm.qa2.suse.asia/index2/jnwang/dist/install/SLP/SLE-12-SP4-Server-Beta4/ Textmode=1 sysrq_always_enabled panic=100 ignore_loglevel addon= console=ttyS0,115200n8 ssh=1 sshpassword=susetesting
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x1df/0x270 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bddddfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bddde000-0x00000000bde0dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bde0e000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083effefff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.1 MHz processor
[    0.002540] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002543] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011122] AGP: No AGP bridge found
[    0.011225] last_pfn = 0x83efff max_arch_pfn = 0x400000000
[    0.011231] MTRR default type: uncachable
[    0.011232] MTRR fixed ranges enabled:
[    0.011234]   00000-9FFFF write-back
[    0.011236]   A0000-BFFFF uncachable
[    0.011238]   C0000-FFFFF write-back
[    0.011239] MTRR variable ranges enabled:
[    0.011241]   0 base 000000000000 mask FFFF80000000 write-back
[    0.011243]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.011245]   2 disabled
[    0.011246]   3 disabled
[    0.011247]   4 disabled
[    0.011248]   5 disabled
[    0.011249]   6 disabled
[    0.011250]   7 disabled
[    0.011252] TOM2: 000000083f000000 aka 33776M
[    0.012239] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.012531] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.012540] last_pfn = 0xbddde max_arch_pfn = 0x400000000
[    0.015079] found SMP MP-table at [mem 0x000f4f60-0x000f4f6f] mapped at [(____ptrval____)]
[    0.015196] Scanning 1 areas for low memory corruption
[    0.015199] Base memory trampoline at [(____ptrval____)] 84000 size 24576
[    0.015204] Using GB pages for direct mapping
[    0.015207] BRK [0x772a6a000, 0x772a6afff] PGTABLE
[    0.015210] BRK [0x772a6b000, 0x772a6bfff] PGTABLE
[    0.015212] BRK [0x772a6c000, 0x772a6cfff] PGTABLE
[    0.015244] BRK [0x772a6d000, 0x772a6dfff] PGTABLE
[    0.015247] BRK [0x772a6e000, 0x772a6efff] PGTABLE
[    0.015359] BRK [0x772a6f000, 0x772a6ffff] PGTABLE
[    0.015388] BRK [0x772a70000, 0x772a70fff] PGTABLE
[    0.015418] BRK [0x772a71000, 0x772a71fff] PGTABLE
[    0.015436] RAMDISK: [mem 0x1979f000-0x28bc6fff]
[    0.015441] ACPI: Early table checksum verification disabled
[    0.015498] ACPI: RSDP 0x00000000000F4EE0 000024 (v02 HP    )
[    0.015502] ACPI: XSDT 0x00000000BDDE1880 00B4 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015510] ACPI: FACP 0x00000000BDDE1980 0000F4 (v03 HP     ProLiant 00000002 �?   0000162E)
[    0.015518] ACPI: DSDT 0x00000000BDDE1A80 00D2F7 (v01 HP     DSDT     00000001 INTL 20061109)
[    0.015523] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015527] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015531] ACPI: SPCR 0x00000000BDDDE180 000050 (v01 HP     SPCRRBSU 00000001 �?   0000162E)
[    0.015535] ACPI: MCFG 0x00000000BDDDE200 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.015539] ACPI: HPET 0x00000000BDDDE240 000038 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015544] ACPI: SPMI 0x00000000BDDDE280 000040 (v05 HP     ProLiant 00000001 �?   0000162E)
[    0.015548] ACPI: ERST 0x00000000BDDDE2C0 000230 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015552] ACPI: APIC 0x00000000BDDDE500 00009E (v01 HP     ProLiant 00000002      00000000)
[    0.015556] ACPI: SRAT 0x00000000BDDDE800 000128 (v02 AMD    AGESA    00000001 AMD  00000001)
[    0.015560] ACPI: FFFF 0x00000000BDDDF000 000176 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015564] ACPI: BERT 0x00000000BDDDF180 000030 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015568] ACPI: HEST 0x00000000BDDDF1C0 00018C (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015572] ACPI: FFFF 0x00000000BDDDF380 000064 (v02 HP     ProLiant 00000002 �?   0000162E)
[    0.015576] ACPI: SLIT 0x00000000BDDDF400 000030 (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.015580] ACPI: FFFF 0x00000000BDDE1800 00006E (v01 HP     Proliant 00000001 PH   0000504D)
[    0.015584] ACPI: IVRS 0x00000000BDDDF800 0001A0 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.015588] ACPI: SSDT 0x00000000BDDEED80 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
[    0.015592] ACPI: SSDT 0x00000000BDDEEEC0 000377 (v01 HP     pmab     00000001 INTL 20120503)
[    0.015596] ACPI: SSDT 0x00000000BDDEF240 001714 (v02 AMD    POWERNOW 00000001 AMD  00000001)
[    0.015604] ACPI: Local AP address 0xfee00000
[    0.015652] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.015654] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.015655] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.015656] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.015658] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.015659] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.015660] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.015662] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.015665] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.015667] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.015669] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83effffff]
[    0.015674] NUMA: Initialized distance table, cnt=2
[    0.015677] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.015679] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x83effefff] -> [mem 0x00000000-0x83effefff]
[    0.015687] NODE_DATA(0) allocated [mem 0x83efe8000-0x83effdfff]
[    0.015761] Zone ranges:
[    0.015763]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015765]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015767]   Normal   [mem 0x0000000100000000-0x000000083effefff]
[    0.015770]   Device   empty
[    0.015771] Movable zone start for each node
[    0.015774] Early memory node ranges
[    0.015775]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.015777]   node   0: [mem 0x0000000000100000-0x00000000bddddfff]
[    0.015778]   node   0: [mem 0x0000000100000000-0x000000083effefff]
[    0.015951] Reserved but unavailable: 8836 pages
[    0.015952] Initmem setup node 0 [mem 0x0000000000001000-0x000000083effefff]
[    0.015955] On node 0 totalpages: 8375675
[    0.015957]   DMA zone: 64 pages used for memmap
[    0.015958]   DMA zone: 42 pages reserved
[    0.015960]   DMA zone: 3998 pages, LIFO batch:0
[    0.016070]   DMA32 zone: 12088 pages used for memmap
[    0.016072]   DMA32 zone: 773598 pages, LIFO batch:63
[    0.037772]  ormal zone: 118720 pages used for memmap
[    0.037777]   Normal zone: 7598079 pages, LIFO batch:63
[    0.038879] ACPI: PM-Timer IO Port: 0x920
[    0.038883] ACPI: Local APIC address 0xfee00000
[    0.038893] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.038906] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
[    0.038909] IOAPIC[1]: apic_id 9, version 33, address 0xfaffc000, GSI 24-55
[    0.038913] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.038915] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.038917] ACPI: IRQ0 used by override.
[    0.038919] ACPI: IRQ9 used by override.
[    0.038922] Using ACPI (MADT) for SMP configuration information
[    0.038924] ACPI: HPET id: 0x1166a201 base: 0xfed00000
[    0.038927] ACPI: SPCR: SPCR table version 1
[    0.038929] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.038931] ACPI: SPCR: console: uart,mmio,0x0,115200
[    0.038933] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.038936] NODE_DATA(1) allocated [mem 0x83efc9000-0x83efdefff]
[    0.038938]     NODE_DATA(1) on node 0
[    0.038958] Initmem setup node 1 [mem 0x0000000000000000-0x0000000000000000]
[    0.038959] On node 1 totalpages: 0
[    0.038973] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.038975] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.038976] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.038977] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.038979] PM: Registered nosave memory: [mem 0xbddde000-0xbde0dfff]
[    0.038981] PM: Registered nosave memory: [mem 0xbde0e000-0xcfffffff]
[    0.038982] PM: Registered nosave memory: [mem 0xd0000000-0xfebfffff]
[    0.038983] PM: Registered nosave memory: [mem 0xfec00000-0xfee0ffff]
[    0.038984] PM: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.038985] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.038988] [mem 0xd0000000-0xfeffff] available for PCI devices
[    0.038990] Booting paravirtualized kernel on bare hardware
[    0.038993] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.174073] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:2
[    0.175192] percpu: Embedded 47 pages/cpu @(____ptrval____) s155648 r8192 d28672 u524288
[    0.175201] pcpu-alloc: s155648 r8192 d28672 u524288 alloc=1*2097152
[    0.175203] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7
[    0.175229] Built 2 zonelists, mobility grouping on.  Total pages: 8244761
[    0.175230] Policy zone: Normal
[    0.175233] Kernel command line: BOOT_IMAGE=/boot/loader-cO0lcw/linux install=http://apac2-kvm.qa2.suse.asia/index2/jnwang/dist/install/SLP/SLE-12-SP4-Server-Beta4/ Textmode=1 sysrq_always_enabled panic=100 ignore_loglevel addon= console=ttyS0,115200n8 ssh=1 sshpassword=susetesting
[    0.175305] sysrq: sysrq always enabled.
[    0.175372] log_buf_len individual max cpu contribution: 32768 bytes
[    0.175373] log_buf_len total cpu_extra contributions: 229376 bytes
[    0.175374] log_buf_len min size: 262144 bytes
[    0.175554] log_buf_len: 524288 bytes
[    0.175555] early log buf free: 250636(95%)
[    0.190466] AGP: Checking aperture...
[    0.199055] AGP: No AGP bridge found
[    0.199059] AGP: Node 0: aperture [bus addr 0xb0000000-0xb1ffffff] (32MB)
[    0.199061] Aperture pointing to e820 RAM. Ignoring.
[    0.199062] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.199063] AGP: Please enable the IOMMU option in the BIOS setup
[    0.199064] AGP: This costs you 64MB of RAM
[    0.199067] AGP: Mapping aperture over RAM [mem 0xb4000000-0xb7ffffff] (65536KB)
[    0.199070] PM: Registered nosave memory: [mem 0xb4000000-0xb7ffffff]
[    0.241972] Memory: 2860168K/33502700K available (12300K kernel code, 1504K rwdata, 3600K rodata, 2028K init, 1364K bss, 935440K reserved, 0K cma-reserved)
[    0.242108] ftrace: allocating 36136 entries in 142 pages
[  0.261864] rcu: Preemptible hierarchical RCU implementation.
[    0.261867] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.261868]  Tasks RCU enabled.
[    0.261870] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.265799] NR_IRQS: 33024, nr_irqs: 1032, preallocated irqs: 16
[    0.266105] spurious 8259A interrupt: IRQ7.
[    0.270686] Console: colour VGA+ 80x25
[    1.243877] console [ttyS0] enabled
[    1.245091] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.248831] ACPI: Core revision 20180810
[    1.250423] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    1.253560] hpet clockevent registered
[    1.254885] APIC: Switch to symmetric I/O mode setup
[    1.296259] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.317560] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28430dbc6e6, max_idle_ns: 440795249668 ns
[    1.321135] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.34 BogoMIPS (lpj=11172684)
[    1.325128] pid_max: default: 32768 minimum: 301
[    1.329230] Security Framework initialized
[    1.330820] AppArmor: AppArmor initialized
[    1.341442] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    1.348135] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    1.349298] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.353259] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.356016] mce: CPU supports 7 MCE banks
[    1.357136] LVT offset 1 assigned for vector 0xf9
[    1.358833] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    1.361128] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    1.363370] Spectre V2 : Mitigation: Full AMD retpoline
[    1.365128] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.367881] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    1.369129] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    1.381706] Freeing SMP alternatives memory: 32K
[    1.385127] smpboot: CPU0: AMD Opteron(tm) Processor 6320 (family: 0x15, model: 0x2, stepping: 0x0)
[    1.409139] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    1.412537] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 430076)
[    1.413133] AMD PMU driver.
[    1.414078] ... version:                0
[    1.417131] ... bit width:              48
[    1.418483] ... generic registers:      6
[    1.419840] ... value mask:             0000ffffffffffff
[    1.421128] ... max period:             00007fffffffffff
[    1.423187] ... fixed-purpose events:   0
[    1.425128] ... event mask:             000000000000003f
[    1.433133] rcu: Hierarchical SRCU implementation.
[    1.453145] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.461137] smp: Bringing up secondary CPUs ...
[    1.501189] x86: Booting SMP configuration:
[    1.502570] .... node  #0, CPUs:      #1 #2 #3
[    1.626781] .... node  #1, CPUs:   #4 #5 #6 #7
[    1.752053] smp: Brought up 2 nodes, 8 CPUs
[    1.754572] smpboot: Max logical packages: 1
[    1.755947] smpboot: Total of 8 processors activated (44690.73 BogoMIPS)
[    2.125141] node 0 initialised, 7426773 pages in 364ms
[    2.130259] devtmpfs: initialized
[    2.130259] x86/mm: Memory block size: 128MB
[    2.137267] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.137267] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.141141] pinctrl core: initialized pinctrl subsystem
[    2.141179] RTC time:  9:09:06, date: 09/13/18
[    2.142888] NET: Registered protocol family 16
[    2.145260] audit: initializing netlink subsys (disabled)
[    2.149165] audit: type=2000 audit(1536829744.856:1): state=initialized audit_enabled=0 res=1
[    2.153137] cpuidle: using governor ladder
[    2.157140] cpuidle: using governor menu
[    2.158470] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    2.161130] ACPI: bus type PCI registered
[    2.162557] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.165225] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    2.168377] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    2.169143] PCI: Using configuration type 1 for base access
[    2.175290] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.177138] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.179368] ACPI: Added _OSI(Module Device)
[    2.181130] ACPI: Added _OSI(Processor Device)
[    2.182676] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.184274] ACPI: Added _OSI(Processor Aggregator Device)
[    2.185137] ACPI: Added _OSI(Linux-Dell-Video)
[    2.186648] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.207146] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    2.229196] ACPI: Interpreter enabled
[    2.230496] ACPI: (supports S0 S4 S5)
[    2.231732] ACPI: Using IOAPIC for interrupt routing
[    2.233237] HEST: Table parsing has been initialized.
[    2.234955] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.269671] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    2.271772] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.273299] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    2.277130] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    2.281131] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    2.284279] acpi PNP0A08:00: _OSC: platform willing to grant []
[    2.285130] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    2.287805] PCI host bridge to bus 0000:00
[    2.289130] pci_bus 0000:00: root bus resource [mem 0xfaf00000-0xfdffffff window]
[    2.291647] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
[    2.293129] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.297129] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.299427] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    2.301129] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed03fff window]
[    2.303689] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    2.305129] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    2.309129] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    2.311388] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.313130] pci_bus 0000:00: root bus resource [bus 00-3f]
[    2.314930] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    2.317358] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    2.319637] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    2.321148] pci 0000:00:02.0: enabling Extended Tags
[    2.322911] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    2.325339] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    2.327393] pci 0000:00:0a.0: enabling Extended Tags
[    2.329155] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    2.331405] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    2.333147] pci 0000:00:0c.0: enabling Extended Tags
[    2.334827] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    2.337340] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    2.339422] pci 0:00:11.0: reg 0x10: [io  0x1000-0x1007]
[    2.341138] pci 0000:00:11.0: reg 0x14: [io  0x1008-0x100b]
[    2.343115] pci 0000:00:11.0: reg 0x18: [io  0x1010-0x1017]
[    2.345137] pci 0000:00:11.0: reg 0x1c: [io  0x1018-0x101b]
[    2.346976] pci 0000:00:11.0: reg 0x20: [io  0x1020-0x102f]
[    2.349137] pci 0000:00:11.0: reg 0x24: [mem 0xfccf0000-0xfccf03ff]
[    2.351223] pci 0000:00:11.0: set SATA to AHCI mode
[    2.353344] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    2.355452] pci 0000:00:12.0: reg 0x10: [mem 0xfcce0000-0xfcce0fff]
[    2.357366] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    2.359390] pci 0000:00:12.1: reg 0x10: [mem 0xfccd0000-0xfccd0fff]
[    2.361368] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    2.363484] pci 0000:00:12.2: reg 0x10: [mem 0xfccc0000-0xfccc00ff]
[    2.365211] pci 0000:00:12.2: supports D1 D2
[    2.366651] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    2.369325] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    2.371488] pci 0000:00:13.0: reg 0x10: [mem 0xfccb0000-0xfccb0fff]
[    2.373365] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    2.377173] pci 0000:00:13.1: reg 0x10: [mem 0xfcca0000-0xfcca0fff]
[    2.379484] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    2.381149] pci 0000:00:13.2: reg 0x10: [mem 0xfcc90000-0xfcc900ff]
[    2.383460] pci 0000:00:13.2: supports D1 D2
[    2.385129] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    2.387370] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    2.389405] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    2.391535] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
[    2.393137] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
[    2.395045] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
[    2.397137] pci 0000:00:14.1: reg 0x1c: [io  0x0374-0x0377]
[    2.398950] pci 0000:00:14.1: reg 0x20: [io  0x0500-0x050f]
[    2.401148] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    2.403629] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    2.405130] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[ 2.407489] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    2.409339] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    2.413386] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    2.415613] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    2.417329] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    2.419589] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    2.421319] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    2.423568] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    2.425325] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    2.429319] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    2.431596] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[    2.433319] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    2.435532] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    2.437324] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    2.439560] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    2.441369] pci 0000:03:00.0: [103c:323b] type 00 class 0x010400
[    2.445146] pci 0000:03:00.0: reg 0x10: [mem 0xfdf00000-0xfdffffff 64bit]
[    2.447439] pci 0000:03:00.0: reg 0x18: [mem 0xfdef0000-0xfdef03ff 64bit]
[    2.449135] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
[    2.451276] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    2.453133] pci 0000:03:00.0: enabling Extended Tags
[    2.454823] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    2.457152] pci 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x8 link at 0000:00:02.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[    2.461177] pci 0000:00:02.0: PCI bridge to [bus 03]
[    2.462989] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    2.465130] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    2.467423] pci 0000:02:00.0: [103c:3306] type 00 class 0x088000
[    2.469150] pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
[    2.471093] pci 0000:02:00.0: reg 0x14: [mem 0xfddf0000-0xfddf01ff]
[    2.473138] pci 0000:02:00.0:  0x18: [io  0x3400-0x34ff]
[    2.481198] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:0a.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    2.485193] pci 0000:02:00.1: [102b:0533] type 00 class 0x030000
[    2.487397] pci 0000:02:00.1: reg 0x10: [mem 0xfb000000-0xfbffffff pref]
[    2.489138] pci 0000:02:00.1: reg 0x14: [mem 0xfdde0000-0xfdde3fff]
[    2.491202] pci 0000:02:00.1: reg 0x18: [mem 0xfd000000-0xfd7fffff]
[    2.493292] pci 0000:02:00.2: [103c:3307] type 00 class 0x088000
[    2.497150] pci 0000:02:00.2: reg 0x10: [io  0x3800-0x38ff]
[    2.499065] pci 0000:02:00.2: reg 0x14: [mem 0xfcff0000-0xfcff00ff]
[    2.501138] pci 0000:02:00.2: reg 0x18: [mem 0xfce00000-0xfcefffff]
[    2.503237] pci 0000:02:00.2: reg 0x1c: [mem 0xfcd80000-0xfcdfffff]
[    2.505138] pci 0000:02:00.2: reg 0x20: [mem 0xfcd70000-0xfcd77fff]
[    2.507346] pci 0000:02:00.2: reg 0x24: [mem 0xfcd60000-0xfcd67fff]
[    2.509139] pci 0000:02:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    2.511416] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    2.513204] pci 0000:02:00.4: [103c:3300] type 00 class 0x0c0300
[    2.515275] pci 0000:02:00.4: reg 0x20: [io  0x3c00-0x3c1f]
[    2.529151] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    2.530849] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    2.532921] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    2.533132] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    2.537251] pci 0000:04:00.0: [14e4:1657] type 00 class 0x020000
[    2.539332] pci 0000:04:00.0: reg 0x10: [mem 0xfcbf0000-0xfcbfffff 64bit pref]
[    2.541139] pci 0000:04:00.0: reg 0x18: [mem 0xfcbe0000-0xfcbeffff 64bit pref]
[    2.543492] pci 0000:04:00.0: reg 0x20: [mem 0xfcbd0000-0xfcbdffff 64bit pref]
[    2.545136] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.549194] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    2.551279] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:0c.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
[    2.553234] pci 0000:04:00.1: [14e4:1657] type 00 class 0x020000
[    2.557150] pci 0000:04:00.1: reg 0x10: [mem 0xfcbc0000-0xfcbcffff 64bit pref]
[    2.561139] pci 0000:04:00.1: reg 0x18: [mem 0xfcbb0000-0xfcbbffff 64bit pref]
[    2.563537] pci 0000:04:00.1: reg 0x20: [mem 0xfcba0000-0xfcbaffff 64bit pref]
[    2.565135] pci 0000:04:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.567561] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    2.569246] pci 0000:04:00.2: [14e4:1657] type 00 class 0x020000
[    2.571331] pci 0000:04:00.2: reg 0x10: [mem 0xfcb90000-0xfcb9ffff 64bit pref]
[    2.573139] pci 0000:04:00.2: reg 0x18: [mem 0xfcb80000-0xfcb8ffff 64bit pref]
[    2.577139] pci 0000:04:00.2: reg 0x20: [mem 0xfcb70000-0xfcb7ffff 64bit pref]
[    2.579553] pci 0000:04:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.581191] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
[    2.583261] pci 0000:04:00.3: [14e4:1657] type 00 class 0x020000
[    2.585150] pci 0000:04:00.3: reg 0x10: [mem 0xfcb60000-0xfcb6ffff 64bit pref]
[    2.589138] pci 0000:04:00.3: reg 0x18: [memfcb50000-0xfcb5ffff 64bit pref]
[    2.593139] pci 0000:04:00.3: reg 0x20: [mem 0xfcb40000-0xfcb4ffff 64bit pref]
[    2.597136] pci 0000:04:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.599457] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    2.601280] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    2.602973] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    2.605141] pci_bus 0000:01: extended config space not accessible
[    2.607167] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    2.609136] pci 0000:00:14.4:   bridge window [mem 0xfaf00000-0xfdffffff window] (subtractive decode)
[    2.613129] pci 0000:00:14.4:   bridge window [io  0x1000-0xffff window] (subtractive decode)
[    2.617129] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    2.619923] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    2.621129] pci 0000:00:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
[    2.625129] pci 0000:00:14.4:   bridge window [mem 0xfed00000-0xfed03fff window] (subtractive decode)
[    2.628170] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
[    2.629129] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    2.633129] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    2.637129] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    2.640716] ACPI: PCI Interrupt Link [I020] (IRQs *24)
[    2.641615] ACPI: PCI Interrupt Link [I021] (IRQs *25)
[    2.645465] ACPI: PCI Interrupt Link [I022] (IRQs *26)
[    2.647724] ACPI: PCI Interrupt Link [I023] (IRQs *27)
[    2.649607] ACPI: PCI Interrupt Link [I030] (IRQs *28)
[    2.651944] ACPI: PCI Interrupt Link [I031] (IRQs *29)
[    2.653628] ACPI: PCI Interrupt Link [I032] (IRQs *30)
[    2.655925] ACPI: PCI Interrupt Link [I033] (IRQs *31)
[    2.657622] ACPI: PCI Interrupt Link [I040] (IRQs *44)
[    2.661425] ACPI: PCI Interrupt Link [I041] (IRQs *45)
[    2.663697] ACPI: PCI Interrupt Link [I042] (IRQs *46)
[    2.665654] ACPI: PCI Interrupt Link [I043] (IRQs *47)
[    2.667963] ACPI: PCI Interrupt Link [I050] (IRQs *48)
[    2.669639] ACPI: PCI Interrupt Link [I051] (IRQs *49)
[    2.672053] ACPI: PCI Interrupt Link [I052] (IRQs *50)
[    2.673657] ACPI: PCI Interrupt Link [I053] (IRQs *51)
[    2.677520] ACPI: PCI Interrupt Link [I060] (IRQs *47)
[    2.679798] ACPI: PCI Interrupt Link [I061] (IRQs *44)
[    2.681646] ACPI: PCI Interrupt Link [I062] (IRQs *45)
[    2.683899] ACPI: PCI Interrupt Link [I063] (IRQs *46)
[    2.685649] ACPI: PCI Interrupt Link [I070] (IRQs *24)
[    2.687973] ACPI: PCI Interrupt Link [I071] (IRQs *25)
[    2.689669] ACPI: PCI Interrupt Link [I072] (IRQs *26)
[    2.693682] ACPI: PCI Interrupt Link [I073] (IRQs *27)
[    2.695589] ACPI: PCI Interrupt Link [I090] (IRQs *24)
[    2.697291] ACPI: PCI Interrupt Link [I091] (IRQs *24)
[    2.699304] ACPI: PCI Interrupt Link [I092] (IRQs *24)
[    2.701289] ACPI: PCI Interrupt Link [I093] (IRQs *24)
[    2.703645] ACPI: PCI Interrupt Link [I0A0] (IRQs *24)
[    2.705680] ACPI: PCI Interrupt Link [I0A1] (IRQs *25)
[    2.708039] ACPI: PCI Interrupt Link [I0A2] (IRQs *26)
[    2.709700] ACPI: PCI Interrupt Link [I0A3] (IRQs *27)
[    2.713360] ACPI: PCI Interrupt Link [I0B0] (IRQs *32)
[    2.715649] ACPI: PCI Interrupt Link [I0B1] (IRQs *33)
[    2.717704] ACPI: PCI Interrupt Link [I0B2] (IRQs *34)
[    2.720033] ACPI: PCI Interrupt Link [I0B3] (IRQs *35)
[    2.721687] ACPI: PCI Interrupt Link [I0C0] (IRQs *36)
[    2.724004] ACPI: PCI Interrupt Link [I0C1] (IRQs *37)
[    2.725710] ACPI: PCI Interrupt Link [I0C2] (IRQs *38)
[    2.729707] ACPI: PCI Interrupt Link [I0C3] (IRQs *39)
[    2.732124] ACPI: PCI Interrupt Link [I0D0] (IRQs *40)
[    2.733707] ACPI: PCI Interrupt Link [I0D1] (IRQs *41)
[    2.736145] ACPI: PCI Interrupt Link [I0D2] (IRQs *42)
[    2.737727] ACPI: PCI Interrupt Link [I0D3] (IRQs *43)
[    2.741198] ACPI: PCI Interrupt Link [BI02] (IRQs *52)
[    2.742985] ACPI: PCI Interrupt Link [BI03] (IRQs *52)
[    2.744872] ACPI: PCI Interrupt Link [BI04] (IRQs *52)
[    2.745235] ACPI: PCI Interrupt Link [BI05] (IRQs *52)
[    2.747130] ACPI: PCI Interrupt Link [BI06] (IRQs *54)
[    2.749255] ACPI: PCI Interrupt Link [BI07] (IRQs *24)
[    2.751572] ACPI: PCI Interrupt Link [BI08] (IRQs *24)
[    2.753275] ACPI: PCI Interrupt Link [BI09] (IRQs *24)
[    2.755242] ACPI: PCI Interrupt Link [BI0A] (IRQs *24)
[    2.757295] ACPI: PCI Interrupt Link [BI0B] (IRQs *54)
[    2.759202] ACPI: PCI Interrupt Link [BI0C] (IRQs *54)
[    2.761313] ACPI: PCI Interrupt Link [BI0D] (IRQs *54)
[    2.763190] ACPI: PCI Interrupt Link [PI20] (IRQs 10 11) *0, disabled.
[    2.765271] ACPI: PCI Interrupt Link [PI21] (IRQs 10 11) *0, disabled.
[    2.767577] ACPI: PCI Interrupt Link [PI22] (IRQs 10 11) *0, disabled.
[    2.769267] ACPI: PCI Interrupt Link [PI23] (IRQs 10 11) *0, disabled.
[    2.773267] ACPI: PCI Interrupt Link [PI30] (IRQs 10 11) *0, disabled.
[    2.775664] ACPI: PCI Interrupt Link [PI31] (IRQs 10 11) *0, disabled.
[    2.777268] ACPI: PCI Interrupt Link [PI32] (IRQs 10 11) *0, disabled.
[    2.781150] ACPI: PCI Interrupt Link [PI33] (IRQs 10 11) *0, disabled.
[    2.783517] ACPI: PCI Interrupt Link [PI40] (IRQs 10 11) *0, disabled.
[    2.785268] ACPI: PCI Interrupt Link [PI41] (IRQs 10 11) *0, disabled.
[    2.787636] ACPI: PCI Interrupt Link [PI42] (IRQs 10 11) *0, disabled.
[    2.789267] ACPI: PCI Interrupt Link [PI43] (IRQs 10 11) *0, disabled.
[    2.791696] ACPI: PCI Interrupt Link [PI50] (IRQs 10 11) *0, disabled.
[    2.793267] ACPI: PCI Interrupt Link [PI51] (IRQs 10 11) *0, disabled.
[    2.797266] ACPI: PCI Interrupt Link [PI52] (IRQs 10 11) *0, disabled.
[    2.799621] ACPI: PCI Interrupt Link [PI53] (IRQs 10 11) *0, disabled.
[    2.801268] ACPI: PCI Interrupt Link [PI60] (IRQs 10 11) *0, disabled.
[    2.803632] ACPI: PCI Interrupt Link [PI61] (IRQs 10 11) *0, disabled.
[    2.805266] ACPI: PCI Interrupt Link [PI62] (IRQs 10 11) *0, disabled.
[    2.809293] ACPI: PCI Interrupt Link [PI63] (IRQs 10 11) *0, disabled.
[    2.811634] ACPI: PCI Interrupt Link [PI70] (IRQs 10 11) *0, disabled.
[    2.813265] ACPI: PCI Interrupt Link [PI71] (IRQs 10 11) *0, disabled.
[    2.815577] ACPI: PCI Interrupt Link [PI72] (IRQs 10 11) *0, disabled.
[    2.817266] ACPI: PCI Interrupt Link [PI73] (IRQs 10 11) *0, disabled.
[    2.821267] ACPI: PCI Interrupt Link [PI90] (IRQs 10 11) *0, disabled.
[    2.823599] ACPI: PCI Interrupt Link [PI91] (IRQs 10 11) *0, disabled.
[    2.825266] ACPI: PCI Interrupt Link [PI92] (IRQs 10 11) *0, disabled.
[    2.827624CPI: PCI Interrupt Link [PI93] (IRQs 10 11) *0, disabled.
[    2.829267] ACPI: PCI Interrupt Link [PIA0] (IRQs 10 11) *0, disabled.
[    2.833268] ACPI: PCI Interrupt Link [PIA1] (IRQs 10 11) *0, disabled.
[    2.835589] ACPI: PCI Interrupt Link [PIA2] (IRQs 10 11) *0, disabled.
[    2.837275] ACPI: PCI Interrupt Link [PIA3] (IRQs 10 11) *0, disabled.
[    2.839566] ACPI: PCI Interrupt Link [PIB0] (IRQs 10 11) *0, disabled.
[    2.841266] ACPI: PCI Interrupt Link [PIB1] (IRQs 10 11) *0, disabled.
[    2.843534] ACPI: PCI Interrupt Link [PIB2] (IRQs 10 11) *0, disabled.
[    2.845267] ACPI: PCI Interrupt Link [PIB3] (IRQs 10 11) *0, disabled.
[    2.849266] ACPI: PCI Interrupt Link [PIC0] (IRQs 10 11) *0, disabled.
[    2.851610] ACPI: PCI Interrupt Link [PIC1] (IRQs 10 11) *0, disabled.
[    2.853266] ACPI: PCI Interrupt Link [PIC2] (IRQs 10 11) *0, disabled.
[    2.855616] ACPI: PCI Interrupt Link [PIC3] (IRQs 10 11) *0, disabled.
[    2.857267] ACPI: PCI Interrupt Link [PID0] (IRQs 10 11) *0, disabled.
[    2.861271] ACPI: PCI Interrupt Link [PID1] (IRQs 10 11) *0, disabled.
[    2.863596] ACPI: PCI Interrupt Link [PID2] (IRQs 10 11) *0, disabled.
[    2.865292] ACPI: PCI Interrupt Link [PID3] (IRQs 10 11) *0, disabled.
[    2.867594] ACPI: PCI Interrupt Link [PIR2] (IRQs 10 11) *0, disabled.
[    2.869267] ACPI: PCI Interrupt Link [PIR3] (IRQs 10 11) *0, disabled.
[    2.873266] ACPI: PCnterrupt Link [PIR4] (IRQs 10 11) *0, disabled.
[    2.877268] ACPI: PCI Interrupt Link [PIR5] (IRQs 10 11) *0, disabled.
[    2.881267] ACPI: PCI Interrupt Link [PIR6] (IRQs 10 11) *0, disabled.
[    2.883844] ACPI: PCI Interrupt Link [PIR7] (IRQs 10 11) *0, disabled.
[    2.885266] ACPI: PCI Interrupt Link [PIR8] (IRQs 10 11) *0, disabled.
[    2.889265] ACPI: PCI Interrupt Link [PIR9] (IRQs 10 11) *0, disabled.
[    2.891612] ACPI: PCI Interrupt Link [PIRA] (IRQs 10 11) *0, disabled.
[    2.893267] ACPI: PCI Interrupt Link [PIRB] (IRQs 10 11) *0, disabled.
[    2.895606] ACPI: PCI Interrupt Link [PIRC] (IRQs 10 11) *0, disabled.
[    2.897268] ACPI: PCI Interrupt Link [PIRD] (IRQs 10 11) *0, disabled.
[    2.901149] ACPI: PCI Interrupt Link [USB1] (IRQs *22)
[    2.902979] ACPI: PCI Interrupt Link [USB2] (IRQs *23)
[    2.904810] ACPI: PCI Interrupt Link [USB3] (IRQs *23)
[    2.905243] ACPI: PCI Interrupt Link [USB4] (IRQs *22)
[    2.907148] ACPI: Invalid _PRS IRQ 0
[    2.909295] ACPI: PCI Interrupt Link [U1PI] (IRQs) *0
[    2.911169] ACPI: Invalid _PRS IRQ 0
[    2.913138] ACPI: PCI Interrupt Link [U2PI] (IRQs) *0
[    2.915098] ACPI: Invalid _PRS IRQ 0
[    2.916506] ACPI: PCI Interrupt Link [U3PI] (IRQs) *0
[    2.917299] ACPI: Invalid _PRS IRQ 0
[    2.918677] ACPI: PCI Interrupt Link [U4PI] (IRQs) *0
[    2.921200] ACPI: PCI Interrupt Link [SATA] (IRQs *16)
[    2.923008] ACPI: Invalid _PRS IRQ 0
[    2.924272] ACPI: PCI Interrupt Link [SATP] (IRQs) *0
[    2.925683] pci 0000:02:00.1: vgaarb: setting as boot VGA device
[    2.927159] pci 0000:02:00.1: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.929131] pci 0000:02:00.1: vgaarb: bridge control possible
[    2.933129] vgaarb: loaded
[    2.934166] SCSI subsystem initialized
[    2.935471] libata version 3.00 loaded.
[    2.937171] EDAC MC: Ver: 3.0.0
[    2.938360] PCI: Using ACPI for IRQ routing
[    2.949097] PCI: pci_cache_line_size set to 64 bytes
[    2.949194] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    2.951262] e820: reserve RAM buffer [mem 0xbddde000-0xbfffffff]
[    2.953129] e820: reserve RAM buffer [mem 0x83efff000-0x83fffffff]
[    2.957139] NetLabel: Initializing
[    2.958338] NetLabel:  domain hash size = 128
[    2.959795] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.961145] NetLabel:  unlabeled traffic allowed by default
[    2.962992] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    2.965131] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    2.969129] clocksource: Switched to clocksource tsc-early
[    2.989073] VFS: Disk quotas dquot_6.6.0
[    2.990492] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.993006] AppArmor: AppArmor Filesystem Enabled
[    2.994740] pnp: PnP ACPI init
[    2.999727] system 00:00: [io  0x0379-0x037a] has been reserved
[    3.001838] system 00:00: [io  0x0400-0x043f] has been reserved
[    3.003806] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    3.005863] system 00:00: [io  0x04d6] has been reserved
[    3.007643] system 00:00: [io  0x0520] has been reserved
[    3.009416] system 00:00: [io  0x0580-0x059f] has been reserved
[    3.011404] system 00:00: [io  0x0600-0x067f] has been reserved
[    3.013358] system 00:00: [io  0x0700-0x0703] has been reserved
[    3.015375] system 00:00: [io  0x0820-0x082f] has been reserved
[    3.017394] system 00:00: [io  0x0900-0x09fe] has been reserved
[    3.019333] system 00:00: [io  0x0c06-0x0c07] has been reserved
[    3.021335] system 00:00: [io  0x0c14] has been reserved
[    3.023089] system 00:00: [io  0x0c4a] has been reserved
[    3.024970] system 00:00: [io  0x0c50-0x0c52] has been reserved
[    3.026915] system 00:00: [io  0x0c6c] has been reserved
[    3.028692] system 00:00: [io  0x0c6f] has been reserved
[    3.030449] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    3.032421] system 00:00: [io  0x0c90-0x0c9f] has been reserved
[    3.034392] system 00:00: [io  0x0ca0-0x0ca5] could not be reserved
[    3.036498] system 00:00: [io  0x0cd0-0x0cdf] has been reserved
[    3.038517] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    3.040464] system 00:00: [io  0x0b00-0x0b3f] has been reserved
[    3.042430] system 00:00: [io  0x03f8-0x03ff] has been reserved
[    3.044450] system 00:00: [mem 0xc0000000-0xcfffffff] has been reserved
[    3.046712] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.048993] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    3.051227] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    3.053916] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    3.056492] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.058841] system 00:05: [mem 0xfaff4000-0xfaff7fff] could not be reserved
[    3.061184] system 00:05: Plug and Play ACPI dev, IDs PNP0c02 (active)
[    3.163505] pnp: PnP ACPI: found 6 devices
[    3.171691] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.174695] pci 0000:00:0c.0: BAR 14: assigned [mem 0xfc000000-0xfc0fffff]
[    3.177012] pci 0000:03:00.0: BAR 6: assigned [mem 0xfde00000-0xfde7ffff pref]
[    3.179427] pci 0000:00:02.0: PCI bridge to [bus 03]
[    3.181086] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    3.183430] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    3.185753] pci 0000:02:00.2: BAR 6: assigned [mem 0xfcd00000-0xfcd0ffff pref]
[    3.188138] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    3.189778] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    3.191847] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    3.194107] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    3.196694] pci 0000:04:00.0: BAR 6: assigned [mem 0xfc000000-0xfc03ffff pref]
[    3.199173] pci 0000:04:00.1: BAR 6: assigned [mem 0xfc040000-0xfc07ffff pref]
[    3.201510] pci 0000:04:00.2: BAR 6: assigned [mem 0xfc080000-0xfc0bffff pref]
[    3.203926] pci 0000:04:00.3: BAR 6: assigned [mem 0xfc0c0000-0xfc0fffff pref]
[    3.206402] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    3.208057] pci 0000:00:0c.0:   bridge window [mem 0xfc000000-0xfc0fffff]
[    3.210295] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    3.212901] pci 0000:00:14.4: PCI bridge to [bus 01]
[    3.214629] pci_bus 0000:00: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    3.217426] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
[    3.219881] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[    3.221970] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[    3.224008] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
[    3.226171] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff window]
[    3.228471] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff window]
[    3.230786] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb win]
[    3.332843] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df window]
[    3.335109] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.337450] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    3.339294] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdffffff]
[    3.341406] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    3.343310] pci_bus 0000:02: resource 1 [mem 0xfcd00000-0xfddfffff]
[    3.345493] pci_bus 0000:02: resource 2 [mem 0xfb000000-0xfbffffff 64bit pref]
[    3.347904] pci_bus 0000:04: resource 1 [mem 0xfc000000-0xfc0fffff]
[    3.349967] pci_bus 0000:04: resource 2 [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    3.352341] pci_bus 0000:01: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    3.354602] pci_bus 0000:01: resource 5 [io  0x1000-0xffff window]
[    3.356729] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
[    3.358773] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
[    3.360829] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
[    3.362892] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed03fff window]
[    3.365249] pci_bus 0000:01: resource 10 [mem 0xfed40000-0xfed44fff window]
[    3.367507] pci_bus 0000:01: resource 11 [io  0x03b0-0x03bb window]
[    3.369543] pci_bus 0000:01: resource 12 [io  0x03c0-0x03df window]
[    3.371588] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.374153] NET: Registered protocol family 2
[    3.375850] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
[    3.378813] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    3.381874] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.384362] TCP: Hash tables configured (established 262144 bind 65536)
[    3.386660] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    3.388905] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    3.391333] NET: Registered protocol family 1
[    3.392835] NET: Registered protocol family 44
[    3.394540] PCI Interrupt Link [USB1] enabled at IRQ 22
[    3.477317] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x693 took 81070 usecs
[    3.557303] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x693 took 75610 usecs
[    3.560048] PCI Interrupt Link [USB2] enabled at IRQ 23
[    3.581305] pci 0000:00:12.2: quirk_usb_early_handoff+0x0/0x693 took 20949 usecs
[    3.583999] PCI Interrupt Link [USB3] enabled at IRQ 23
[    3.665304] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x693 took 79594 usecs
[    3.745520] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x693 took 75837 usecs
[    3.748302] PCI Interrupt Link [USB4] enabled at IRQ 22
[    3.769308] pci 0000:00:13.2: quirk_usb_early_handoff+0x0/0x693 took 20731 usecs
[    3.771918] pci 0000:02:00.1: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.775040] PCI Interrupt Link [BI0A] enabled at IRQ 24
[    3.777215] PCI Interrupt Link [I061] enabled at IRQ 44
[    3.779088] PCI: CLS 64 bytes, default 64
[    3.780512] Unpacking initramfs...
[   12.581695] Freeing initrd memory: 250016K
[   12.583550] pci 0000:00:00.2: can't derive routing for PCI INT A
[   12.585703] pci 0000:00:00.2: PCI INT A: no GSI
[   12.587615] iommu: Adding device 0000:00:00.0 to group 0
[   12.589605] iommu: Adding device 0000:00:02.0 to group 1
[   12.591575] iommu: Adding device 0000:00:0a.0 to group 2
[   12.593566] iommu: Adding device 0000:00:0c.0 to group 3
[   12.595596] iommu: Adding device 0000:00:11.0 to group 4
[   12.597563] iommu: Adding device 0000:00:12.0 to group 5
[   12.599435] iommu: Adding device 0000:00:12.1 to group 5
[   12.601200] iommu: Adding device 0000:00:12.2 to group 5
[   12.603162] iommu: Adding device 0000:00:13.0 to group 6
[   12.605072] iommu: Adding device 0000:00:13.1 to group 6
[   12.606913] iommu: Adding device 0000:00:13.2 to group 6
[   12.608842] iommu: Adding device 0000:00:14.0 to group 7
[   12.610781] iommu: Adding device 0000:00:14.1 to group 8
[   12.612731] iommu: Adding device 0000:00:14.3 to group 9
[   12.614758] iommu: Adding device 0000:00:14.4 to group 10
[   12.616791] iommu: Adding device 0000:03:00.0 to group 11
[   12.618800] iommu: Adding device 0000:02:00.0 to group 12
[   12.620659] iommu: Adding device 0000:02:00.1 to group 12
[   12.622501] iommu: Adding device 0000:02:00.2 to group 12
[   12.624637] iommu: Adding device 0000:02:00.4 to group 12
[   12.626685] iommu: Adding device 0000:04:00.0 to group 13
[   12.628586] iommu: Adding device 0000:04:00.1 to group 13
[   12.630448] iommu: Adding device 0000:04:00.2 to group 13
[   12.632220] iommu: Adding device 0000:04:00.3 to group 13
[   12.671541] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[   12.673313] AMD-Vi: Interrupt remapping enabled
[   12.675067] AMD-Vi: Lazy IO/TLB flushing enabled
[   12.679063] amd_uncore: AMD NB counters detected
[   12.680875] LVT offset 0 assigned for vector 0x400
[   12.682587] perf: AMD IBS detected (0x000000ff)
[   12.684182] Scanning for low memory corruption every 60 seconds
[   12.686995] Initialise system trusted keyrings
[   12.688600] Key type blacklist registered
[   12.690031] workingset: timestamp_bits=37 max_order=23 bucket_order=0
[   12.692290] zbud: loaded
[   12.693678] pstore: using deflate compression
[   12.697172] Key type asymmetric registered
[   12.698608] Asymmetric key parser 'x509' registered
[   12.700272] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   12.702807] io scheduler noop registered
[   12.704256] io scheduler deadline registered
[   12.705692] io scheduler cfq registered (default)
[   12.707281] io scheduler mq-deadline registered
[   12.708748] io scheduler kyber registered
[   12.710538] PCI Interrupt Link [BI02] enabled at IRQ 52
[   12.712687] PCI Interrupt Link [BI0C] enabled at IRQ 54
[   12.714652] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.717692] ERST: Error Record Serialization Table (ERST) support is initialized.
[   12.722423] pstore: No deflate compression
[   12.723869] pstore: Registered erst as persistent store backend
[   12.726009] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[   12.728794] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   12.751515] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   12.774715] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   12.778921] Non-volatile memory driver v1.3
[   12.780401] Linux agpgart interface v0.103
[   12.783203] ahci 0000:00:11.0: version 3.0
[   12.784916] PCI Interrupt Link [SATA] enabled at IRQ 16
[   12.786838] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
[   12.789709] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc
[   12.796938] scsi host0: ahci
[   12.798083] ata1: SATA max UDMA/133 abar m1024@0xfccf0000 port 0xfccf0100 irq 16
[   12.800821] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[   12.805502] serio: i8042 KBD port at 0x60,0x64 irq 1
[   12.807268] serio: i8042 AUX port at 0x60,0x64 irq 12
[   12.809047] mousedev: PS/2 mouse device common for all mice
[   12.811049] rtc_cmos 00:04: RTC can wake from S4
[   12.812797] rtc_cmos 00:04: registered as rtc0
[   12.814477] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   12.817512] ledtrig-cpu: registered to indicate activity on CPUs
[   12.819596] hidraw: raw HID events driver (C) Jiri Kosina
[   12.821647] NET: Registered protocol family 10
[   12.827550] Segment Routing with IPv6
[   12.829651] RAS: Correctable Errors collector initialized.
[   12.832682] microcode: CPU0: patch_level=0x06000852
[   12.834525] microcode: CPU1: patch_level=0x06000852
[   12.836100] microcode: CPU2: patch_level=0x06000852
[   12.837809] microcode: CPU3: patch_level=0x06000852
[   12.839617] microcode: CPU4: patch_level=0x06000852
[   12.841331] microcode: CPU5: patch_level=0x06000852
[   12.843137] microcode: CPU6: patch_level=0x06000852
[   12.844886] microcode: CPU7: patch_level=0x06000852
[   12.846595] microcode: Microcode Update Driver: v2.2.
[   12.846606] sched_clock: Marking stable (11819539690, 1027048576)->(13547197328, -700609062)
[   12.851620] registered taskstats version 1
[   12.853037] Loading compiled-in X.509 certificates
[   12.855118] Loaded X.509 cert 'Devel:Kernel OBS Project: 997e70001fb163f0b061e406501f73bdf3e10ca0'
[   12.858194] zswap: loaded using pool lzo/zbud
[   12.863677] Key type big_key registered
[   12.867090] Key type encrypted registered
[   12.868597] AppArmor: AppArmor sha1 policy hashing enabled
[   12.870440] ima: No TPM chip found, activating TPM-bypass!
[   12.872272] ima: Allocated hash algorithm: sha256
[   12.873969] evm: Initialising EVM extended attributes:
[   12.875706] evm: security.selinux
[   12.876829] evm: security.apparmor
[   12.878018] evm: security.ima
[   12.879063] evm: security.capability
[   12.880291] evm: HMAC attrs: 0x1
[   12.882017]   Magic number: 2:564:171
[   12.883700] rtc_cmos 00:04: setting system clock to 2018-09-13 09:09:17 UTC (1536829757)
[   13.113938] ata1: SATA link down (SStatus 0 SControl 300)
[   13.587291] Freeing unused kernel image memory: 2028K
[   13.611509] Write protecting the kernel read-only data: 18432k
[   13.641887] Freeing unused kernel image memory: 2008K
[   13.666215] Freeing unused kernel image memory: 496K
[   13.689793] Run /init as init process
[   13.705354] tsc: Refined TSC clocksource calibration: 2792.998 MHz
[   13.710358] random: init: uninitialized urandom read (48 bytes read)
[   13.737130] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28426a4c5eb, max_idle_ns: 440795237780 ns
[   13.767632] random: init: uninitialized urandom read (48 bytes read)
[   13.846354] clocksource: Switched to clocksource tsc
[   13.846422] random: init: uninitialized urandom read (48 bytes read)
[   14.793450] urandom_read: 5 callbacks suppressed
[   14.793452] random: init: uninitialized urandom read (48 bytes read)
[   14.846263] random: init: uninitialized urandom read (48 bytes read)
[   14.938287] loop: module loaded
[   15.175955] squashfs: version 4.0 (2009/01/31) Phillip Lougher

>>> SUSE Linux Enterprise 12 SP4 installation program v5.1.14.0 (c) 1996-2018 SUSE LLC <<<
Starting udev... [   15.767517] alua: device handler registered
[   15.789437] emc: device handler registered
[   15.814087] rdac: device handler registered
[   15.857006] udevd[246]: starting version 228
[   15.878441] udevd[247]: Network interface NamePolicy= disabled by default.
[   15.981352] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   16.019195] ACPI: Power Button [PWRF]
[   16.037016] acpi_cpufreq: overriding BIOS provided _PSD data
[   16.069008] ipmi message handler version 39.2
[   16.092418] pps_core: LinuxPPS API ver. 1 registered
[   16.118633] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   16.168479] ipmi device interface
[   16.184578] pata_atiixp 0000:00:14.1: can't derive routing for PCI INT A
[   16.184680] PTP clock support registered
[   16.217888] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   16.270959] scsi host1: pata_atiixp
[   16.288011] scsi host2: pata_atiixp
[   16.293208] cryptd: max_cpu_qlen set to 1000
[   16.304807] ata2: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x500 irq 14
[   16.358062] ata3: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x508 irq 15
[   16.391312] ACPI: bus type USB registered
[   16.410785] usbcore: registered new interface driver usbfs
[   16.437457] usbcore: registered new interface driver hub
[   16.463121] usbcore: registered new device driver usb
[   16.491971] HP HPSA Driver (v 3.4.20-125)
[   16.492468] IPMI System Interface driver.
[   16.511241] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   16.530668] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   16.566266] PCI Interrupt Link [I020] enabled at IRQ 24
[   16.596355] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   16.621684] hpsa 0000:03:00.0: Logical aborts not supported
[   16.649209] ipmi_si: Adding SMBIOS-specified kcs state machine
[   16.675696] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
[   16.703780] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   16.763327] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   16.793402] scsi host3: hpsa
[   16.797547] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[   16.811553] hpsa can't handle SMP requests
[   16.853879] ipmi_si: Adding ACPI-specified kcs state machine
[   16.883106] hpsa 0000:03:00.0: scsi 3:0:0:0: added RAID              HP       P420i            controller SSDSmartPathCap- En- Exp=1
[   16.900765] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   16.957565] hpsa 0000:03:00.0: scsi 3:0:1:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   16.957573] hpsa 0000:03:00.0: scsi 3:0:2:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   17.117354] hpsa 0000:03:00.0: scsi 3:0:3:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   17.173358] hpsa 0000:03:00.0: scsi 3:0:4:0: masked Enclosure         PMCSIERA SRCv8x6G         enclosure SSDSmartPathCap- En- Exp=0
[   17.230873] hpsa 0000:03:00.0: scsi 3:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   17.286375] hpsa 0000:03:00.0: scsi 3:1:0:1: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   17.305304] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[   17.342481] hpsa can't handle SMP requests
[   17.417699] scsi 3:0:0:0: RAID              HP       P420i            8.32 PQ: 0 ANSI: 5
[   17.457270] tg3.c:v3.137 (May 11, 2014)
[   17.475653] scsi 3:1:0:0: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   17.515041] AVX version of gcm_enc/dec engaged.
[   17.515412] PCI Interrupt Link [I0C0] enabled at IRQ 36
[   17.536720] AES CTR mode by8 optimization enabled
[   17.562332] scsi 3:1:0:1: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   17.562365] sd 3:1:0:0: [sda] 585871964 512-byte logical blocks: (300 GB/279 GiB)
[   17.562428] sd 3:1:0:0: [sda] Write Protect is off
[   17.562463] sd 3:1:0:0: [sda] Mode Sense: 73 00 00 08
[   17.562548] sd 3:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   17.565550] ipmi_si IPI0001:00: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x13)
[   17.586891]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   17.624204] sd 3:1:0:1: [sdb] 1171743324 512-byte logical blocks: (600 GB/559 GiB)
[   17.642904] tg3 0000:04:00.0 eth0: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:90
[   17.642915] tg3 0000:04:00.0 eth0: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   17.642923] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   17.642931] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   17.645085] PCI Interrupt Link [I0C1] enabled at IRQ 37
[   17.668770] tg3 0000:04:00.1 eth1: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:91
[   17.681768] sd 3:1:0:1: [sdb] Write Protect is off
[   17.682368] sd 3:1:0:0: [sda] Attached SCSI disk
[   17.705224] tg3 0000:04:00.1 eth1: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   17.748947] sd 3:1:0:1: [sdb] Mode Sense: 73 00 00 08
[   17.790735] tg3 0000:04:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   17.791051] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   17.814179] sd 3:1:0:1: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   17.850722] tg3 0000:04:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[   17.911983]  sdb: sdb1
[   17.971582] tg3 0000:04:00.2 eth2: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:92
[   18.013563] sd 3:1:0:1: [sdb] Attached SCSI disk
[   18.018852] tg3 0000:04:00.2 eth2: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   18.258137] random: fast init done
[   18.281169] tg3 0000:04:00.2 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   18.445627] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   18.489104] tg3 0000:04:00.2 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   18.505384] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   18.561639] tg3 0000:04:00.3 eth3: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:93
[   18.684839] tg3 0000:04:00.3 eth3: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   18.732000] tg3 0000:04:00.3 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   18.769397] tg3 0000:04:00.3 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[   18.802364] ehci-pci: EHCI PCI platform driver
[   18.823897] ehci-pci 0000:00:12.2: EHCI Host Controller
[   18.849452] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[   18.884912] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   18.926847] ehci-pci 0000:00:12.2: debug port 1
[   18.948595] ehci-pci 0000:00:12.2: irq 23, io mem 0xfccc0000
[   18.977345] IPMI SSIF Interface driver
[   18.978558] udevd[247]: Network interface NamePolicy= disabled by default.
[   19.027649] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   19.027744] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   19.095284] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.129952] usb usb1: Product: EHCI Host Controller
[   19.153366] usb usb1: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ehci_hcd
[   19.188923] usb usb1: SerialNumber: 0000:00:12.2
[   19.211219] hub 1-0:1.0: USB hub found
[   19.229097] hub 1-0:1.0: 6 ports detected
[   19.248704] ehci-pci 0000:00:13.2: EHCI Host Controller
[   19.273779] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[   19.309329] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   19.351142] ehci-pci 0000:00:13.2: debug port 1
[   19.372594] ehci-pci 0000:00:13.2: irq 22, io mem 0xfcc90000
[   19.400014] uhci_hcd: USB Universal Host Controller Interface driver
[   19.417157] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   19.458288] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   19.497571] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.532474] usb usb2: Product: EHCI Host Controller
[   19.555895] usb usb2: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ehci_hcd
[   19.591759] usb usb2: SerialNumber: 0000:00:13.2
[   19.614617] hub 2-0:1.0: USB hub found
[   19.632827] hub 2-0:1.0: 6 ports detected
[   19.652357] uhci_hcd 0000:02:00.4: UHCI Host Controller
[   19.677511] uhci_hcd 0000:02:00.4: new USB bus registered, assigned bus number 3
[   19.712279] uhci_hcd 0000:02:00.4: detected 8 ports
[   19.735635] uhci_hcd 0000:02:00.4: port count misdetected? forcing to 2 ports
[   19.769872] uhci_hcd 0000:02:00.4: irq 38, io base 0x00003c00
[   19.797091] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   19.837306] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.873160] usb usb3: Product: UHCI Host Controller
[   19.896779] usb usb3: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default uhci_hcd
[   19.932788] usb usb3: SerialNumber: 0000:02:00.4
[   19.955922] hub 3-0:1.0: USB hub found
[   19.974331] hub 3-0:1.0: 2 ports detected
[   19.994146] ohci-pci: OHCI PCI platform driver
[   20.016011] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   20.042841] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[   20.079130] ohci-pci 0000:00:12.0: irq 22, io mem 0xfcce0000
[   20.106929] usb 1-2: new high-speed USB device number 2 using ehci-pci
[   20.144533] [TTM] Zone  kernel: Available graphics memory: 16443896 kiB
[   20.176533] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   20.211856] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   20.251091] [TTM] Initializing pool allocator
[   20.271986] [TTM] Initializing DMA pool allocator
[   20.294518] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   20.340595] usb usb4: Product: OHCI PCI host controller
[   20.378159] usb usb4: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   20.413713] usb 1-2: New USB device found, idVendor=0424, idProduct=2660, bcdDevice= 8.01
[   20.472434] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   20.506753] fbcon: mgadrmfb (fb0) is primary device
[   20.525162] usb usb4: SerialNumber: 0000:00:12.0
[   20.525525] hub 4-0:1.0: USB hub found
[   20.525538] hub 4-0:1.0: 3 ports detected
[   20.561691] hub 1-2:1.0: USB hub found
[   20.561858] hub 1-2:1.0: 2 ports detected
[   20.626826] ohci-pci 0000:00:12.1: OHCI PCI host controller
[   20.626833] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 5
[   20.626863] ohci-pci 0000:00:12.1: irq 22, io mem 0xfccd0000
[   20.689259] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   20.689264] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   20.689267] usb usb5: Product: OHCI PCI host controller
[   20.689270] usb usb5: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   20.689273] usb usb5: SerialNumber: 0000:00:12.1
[   20.689721] hub 5-0:1.0: USB hub found
[   20.689739] hub 5-0:1.0: 3 ports detected
[   20.730358] Console: switching to colour frame buffer device 160x64
[   21.238372] mgag200 0000:02:00.1: fb0: mgadrmfb frame buffer device
[   21.238806] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   21.295616] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 6
[   21.295671] ohci-pci 0000:00:13.0: irq 23, io mem 0xfccb0000
[   21.301337] [drm] Initialized mgag200 1.0.0 20110418 for 0000:02:00.1 on minor 0
[   21.398450] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   21.438103] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.472750] usb usb6: Product: OHCI PCI host controller
[   21.497272] usb usb6: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   21.532828] usb usb6: SerialNumber: 0000:00:13.0
[   21.555797] hub 6-0:1.0: USB hub found
[   21.573545] hub 6-0:1.0: 3 ports detected
[   21.592964] ohci-pci 0000:00:13.1: OHCI PCI host controller
[   21.619149] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 7
[   21.654324] ohci-pci 0000:00:13.1: irq 23, io mem 0xfcca0000
[   21.745385] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   21.785231] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.820222] usb usb7: Product: OHCI PCI host controller
[   21.845387] usb usb7: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   21.880970] usb usb7: SerialNumber: 0000:00:13.1
[   21.903584] hub 7-0:1.0: USB hub found
[   21.921554] hub 7-0:1.0: 3 ports detected
ok
[   22.196178] udevd[247]: Network interface NamePolicy= disabled by default.
[   22.197271] RPC: Registered named UNIX socket transport module.
[   22.257563] RPC: Registered udp transport module.
[   22.279987] RPC: Registered tcp transport module.
[   22.295092] random: crng init done
[   22.302568] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   22.305369] usb 7-3: new low-speed USB device number 2 using ohci-pci
[   22.511513] usb 7-3: New USB device found, idVendor=0d3d, idProduct=0040, bcdDevice= 0.01
[   22.550876] usb 7-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   22.585276] usb 7-3: Product: USB CAT5
[   22.630676] usbcore: registered new interface driver usbhid
[   22.657658] usbhid: USB HID core driver
[   22.679976] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.0/0003:0D3D:0040.0001/input/input4
[   22.789826] hid-generic 0003:0D3D:0040.0001: input,hidraw0: USB HID v1.00 Keyboard [USB CAT5] on usb-0000:00:13.1-3/input0
[   22.843110] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.1/0003:0D3D:0040.0002/input/input5
[   22.892992] hid-generic 0003:0D3D:0040.0002: input,hidraw1: USB HID v1.00 Mouse [USB CAT5] on usb-0000:00:13.1-3/input1
[   22.958312] No iBFT detected.
Loading basic drivers...[   24.152882] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   24.225576] scsi 3:0:0:0: Attached scsi generic sg0 type 12
[   24.252547] sd 3:1:0:0: Attached scsi generic sg1 type 0
[   24.278173] sd 3:1:0:1: Attached scsi generic sg2 type 0
[   24.746259] NET: Registered protocol family 17
[   28.146102] FS-Cache: Loaded
[   31.574681] FS-Cache: Netfs 'nfs' registered for caching
[   41.930643] 8021q: 802.1Q VLAN Support v1.8
 ok
Starting hardware detection... ok
(If a driver is not working for you, try booting with brokenmodules=driver_name.)

Hewlett-Packard Company P420i
  drivers: hpsa*
ATI SB7x0/SB8x0/SB9x0 IDE Controller
  drivers: pata_atiixp*, pata_acpi, ata_generic
Activating usb devices... ok
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Driver Update: kernel update for bsc1106743
eth3: network config created
Sending DHCP request to eth3...
[   62.188161] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   65.339215] tg3 0000:04:00.3 eth3: Link is up at 1000 Mbps, full duplex
[   65.370956] tg3 0000:04:00.3 eth3: Flow control is on for TX and on for RX
[   65.405092] tg3 0000:04:00.3 eth3: EEE is disabled
[   65.428320] IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
no/incomplete answer.
eth1: network config created
Sending DHCP request to eth1...
[  100.123876] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
no/incomplete answer.
eth2: network config created
Sending DHCP request to eth2...
[  132.580533] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
no/incomplete answer.
eth0: network config created
Sending DHCP request to eth0...
[  165.033350] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[  168.749254] tg3 0000:04:00.0 eth0: Link is up at 1000 Mbps, full duplex
[  168.780966] tg3 0000:04:00.0 eth0: Flow control is off for TX and off for RX
[  168.814907] tg3 0000:04:00.0 eth0: EEE is enabled
[  168.838118] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ok, ip = 10.67.130.39/21
Loading Installation System (1/6) -      100%
Loading Installation System (2/6) -      100%
Loading Installation System (3/6) -      100%
Loading Installation System (4/6) -      100%
Loading Installation System (5/6) -      100%
Loading Installation System (6/6) - missing (optional)
starting rsyslogd (logging to /dev/tty4)... ok
starting klogd... ok
starting nscd... ok
setting temporary root password to 'susetesting'
Checking for missing server keys in /etc/ssh
ssh-keygen: generating new host keys: RSA1 RSA DSA ECDSA ED25519
Starting SSH daemon... ok
IP addresses:
  10.67.130.39

***  login using 'ssh -X root@ph039.qa2.suse.asia'  ***
***  run 'yast.ssh' to start the installation  ***

Active interfaces:
eth0: 28:80:23:ae:1a:90
  10.67.130.39/21
  fe80::2a80:23ff:feae:1a90/64
[  230.010648] udevd[247]: Network interface NamePolicy= disabled by default.
umount: /var/lib/nfs/rpc_pipefs: target is busy
        (In some cases useful info about processes that
         use the device is found by lsof(8) or fuser(1).)
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│┌───────────────────────────────────────────────────────────────────[  267.946932] udevd[247]: Network interface NamePolicy= disable┐ ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐│
││                                 >>> linuxrc 5.1.14.0 (Kernel 4.19.0-rc3-1.gd3995d7-default) <<<                                   ││
│└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘































^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^[
</>hpiLO->

</>hpiLO->

</>hpiLO-> vsp

Virtual Serial Port Active: COM1

Starting virtual serial port.
Press 'ESC (' to return to the CLI Session.

^M^M^M^M^M^M^M^C^C^\^C^\^C^\^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M[  370.979034] systemd[1]: Failed to set up the root directory for shared mount propagation: Invalid argument
[  371.031198] systemd[1]: systemd 228 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[  371.138070] systemd[1]: Detected architecture x86-64.

Welcome to SUSE Linux Enterprise 12 SP4!

[  371.173569] systemd[1]: Set hostname to <rescue>.
[  371.394782] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[  371.434300] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[  371.473461] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[  371.509531] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[  371.541840] systemd[1]: Created slice System Slice.
[  OK  ] Created slice System Slice.
[  371.577714] systemd[1]: Created slice system-getty.slice.
[  OK  ] Created slice system-getty.slice.
[  371.613484] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
         Mounting /...
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Mounted /.
[  OK  ] Listening on Journal Socket (/dev/log).
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
[  OK  ] Listening on Syslog Socket.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on Journal Socket.
         Starting Rule generator for /dev/root symlink...
         Starting Setup Virtual Console...
         Starting Journal Service...
         Mounting Debug File System...
         Mounting Huge Pages File System...
         Starting Load Kernel Modules...
         Starting Remount Root and Kernel File Systems...
         Starting Create list of required st... nodes for the current kernel...
[  371.896008] device-mapper: uevent: version 1.0.3
[  371.918314] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
         Mounting POSIX Message Queue File System...
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Started Journal Service.
[  OK  ] Started Rule generator for /dev/root symlink.
[  OK  ] Started Setup Virtual Console.
[  OK  ] Started Load Kernel Modules.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
         Starting Rebuild Hardware Database...
         Starting Create System Users...
         Starting Load/Save Random Seed...
         Starting Apply Kernel Variables...
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Create System Users.
[  OK  ] Started Load/Save Random Seed.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
         Mounting Runtime Directory...
         Starting udev Kernel Device Manager...
[  OK  ] Mounted Runtime Directory.
[  372.287099] systemd-journald[20574]: Received request to flush runtime journal from PID 1
[  OK  ] Reached target Local File Systems.
         Starting Restore /run/initramfs on shutdown...
         Starting Rebuild Journal Catalog...
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Restore /run/initramfs on shutdown.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Rebuild Journal Catalog.
[  OK  ] Started Create Volatile Files and Directories.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Rebuild Hardware Database.
         Starting Update is Completed...
         Starting udev Coldplug all Devices...
[  OK  ] Started Update is Completed.
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  372.556288] ppdev: user-space parallel port driver
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  372.694816] PCI Interrupt Link [I060] enabled at IRQ 47
[  OK  ] Reached target Basic System.
[  372.721879] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: NMI decoding initialized
[  372.760262] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: 2.0.0, timer margin: 30 seconds (nowayout=0).
[  OK  ] Started D-Bus System Message Bus.
[  372.809594] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[  372.842889] input: PC Speaker as /devices/platform/pcspkr/input/input6
[  372.900737] kvm: Nested Virtualization enabled
[  372.921905] kvm: Nested Paging enabled
[  372.941905] MCE: In-kernel MCE decoding enabled.
[  372.965904] EDAC amd64: Node 0: DRAM ECC enabled.
[  372.988341] EDAC amd64: F15h detected (node 0).
[  373.010465] EDAC MC: DCT0 chip selects:
[  373.028887] EDAC amd64: MC: 0:     0MB 1:     0MB
[  373.051756] EDAC amd64: MC: 2:     0MB 3:     0MB
         [  373.074486] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[  373.097076] EDAC amd64: MC: 6:     0MB 7:     0MB
[  373.119508] EDAC MC: DCT1 chip selects:
Starting wicked [  373.137904] EDAC amd64: MC: 0:     0MB 1:     0MB
[  373.160419] EDAC amd64: MC: 2:     0MB 3:     0MB
[  373.183034] EDAC amd64: MC: 4:  8192MB 5:  8192MB
AutoIPv4 supplic[  373.205653] EDAC amd64: MC: 6:     0MB 7:     0MB
[  373.228278] EDAC amd64: using x8 syndromes.
[  373.248305] EDAC amd64: MCT channel count: 2
ant service...
[  373.269494] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
[  373.316195] EDAC amd64: Node 1: DRAM ECC disabled.
[  373.339185] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[  373.339185]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[  373.339185]  (Note that use of the override may cause unknown side effects.)
[  373.339210] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[  373.456891] raid6: sse2x1   gen() 14867 MB/s
         Startin[  373.508379] AMD64 EDAC driver v3.5.0
g System Logging Service...
         Starting Login Service...
         Starting /etc/init.d/boot.local Compatibility...
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timers.
         Starting wicked DHCPv6 supplicant service...
[  373.613190] raid6: sse2x1   xor()  3736 MB/s
         Starting LSB: Keyboard settings (don't disable!)...
         Starting Permit User Sessions...
         Starting wicked DHCPv4 supplicant service...
[  OK  ] Started /etc/init.d/boot.local Compatibility.
[  OK  ] Started LSB: Keyboard settings (don't disable!).
[  OK  ] Started Permit User Sessions.
[  373.701308] raid6: sse2x2   gen()  6910 MB/s
[  OK  ] Found device /dev/ttyS0.
[  OK  ] Started wicked AutoIPv4 supplicant service.
[  OK  ] Started wicked DHCPv6 supplicant service.
[  OK  ] Started wicked DHCPv4 supplicant service.
[  373.789185] raid6: sse2x2   xor()  5820 MB/s
[  OK  ] Started Login Service.
         Starting wicked network management service daemon...
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  373.877308] raid6: sse2x4   gen()  9302 MB/s
[  OK  ] Started /etc/init.d/after.local Compatibility.
[  OK  ] Started wicked network management service daemon.
         Starting wicked network nanny service...
[  373.965317] raid6: sse2x4   xor()  5233 MB/s
[  373.985888] raid6: using algorithm sse2x1 gen() 14867 MB/s
[  373.985890] raid6: .... xor() 3736 MB/s, rmw enabled
[  373.985895] raid6: using ssse3x2 recovery algorithm
[  OK  ] Started wicked network nanny service.
[  374.060623] xor: automatically using best checksumming function   avx
[  OK  ] Started System Logging Service.
         Starting wicked managed network interfaces...
[  374.148588] Btrfs loaded, crc32c=crc32c-intel, assert=on
[  374.174815] BTRFS: device fsid a279a180-354e-4250-88aa-69f0bad6d187 devid 1 transid 34 /dev/sda5
[  374.217403] BTRFS: device label SLE-12-SP3-GM_MU devid 1 transid 56482 /dev/sda2
[  374.253135] BTRFS: device label SLE-12-SP4-Beta3 devid 1 transid 17385 /dev/sda3


SUSE Linux Enterprise 12 SP4 Rescue System

ph039 login: root
Password:
ttyS0:ph039:~ # uname -r
4.19.0-rc3-1.gd3995d7-default
ttyS0:ph039:~ # reboot
         Stopping Session 3 of user root.
Stopped target Graphical Interface.
[  OK  ] Stopped target Multi-User System.
         Stopping OpenSSH Daemon...
         Stopping System Logging Service...
         Stopping LSB: Keyboard settings (don't disable!)...
         Stopping Restore /run/initramfs on shutdown...
[  OK  ] Stopped target Timers.
[  OK  ] Stopped Daily Cleanup of Temporary Directories.
[  OK  ] Stopped /etc/init.d/after.local Compatibility.
[  OK  ] Stopped target Login Prompts.
         Stopping Serial Getty on ttyS0...
         Stopping Getty on tty1...
[  OK  ] Stopped System Logging Service.
[  OK  ] Stopped Serial Getty on ttyS0.
[  OK  ] Stopped Getty on tty1.
[  OK  ] Stopped User Manager for UID 0.
[  OK  ] Stopped OpenSSH Daemon.
[  OK  ] Stopped Session 3 of user root.
[  OK  ] Stopped LSB: Keyboard settings (don't disable!).
[  OK  ] Stopped Restore /run/initramfs on shutdown.
[  OK  ] Stopped target Network.
         Stopping wicked managed network interfaces...
[  OK  ] Removed slice User Slice of root.
         Stopping Login Service...
[  OK  ] Removed slice system-getty.slice.
[  OK  ] Removed slice system-serial\x2dgetty.slice.
         Stopping Permit User Sessions...
[  OK  ] Stopped /etc/init.d/boot.local Compatibility.
[  OK  ] Stopped Login Service.
[  OK  ] Stopped Permit User Sessions.
[  OK  ] Stopped wicked managed network interfaces.
         Stopping wicked network nanny service...
[  OK  ] Stopped wicked network nanny service.
         Stopping wicked network management service daemon...
[  OK  ] Stopped wicked network management service daemon.
         Stopping wicked DHCPv4 supplicant service...
         Stopping wicked DHCPv6 supplicant service...
         Stopping wicked AutoIPv4 supplicant service...
[  OK  ] Stopped wicked AutoIPv4 supplicant service.
[  OK  ] Stopped wicked DHCPv6 supplicant service.
[  OK  ] Stopped wicked DHCPv4 supplicant service.
         Stopping D-Bus System Message Bus...
[  OK  ] Stopped D-Bus System Message Bus.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Sockets.
[  OK  ] Closed Syslog Socket.
[  OK  ] Stopped target Slices.
[  OK  ] Removed slice User and Session Slice.
[  OK  ] Closed D-Bus System Message Bus Socket.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped target Encrypted Volumes.
[  OK  ] Stopped Dispatch Password Requests to Console Directory Watch.
[  OK  ] Stopped Update is Completed.
[  OK  ] Stopped Rebuild Journal Catalog.
[  OK  ] Stopped Rebuild Hardware Database.
[  OK  ] Stopped Setup Virtual Console.
         Stopping Update UTMP about System Boot/Shutdown...
         Stopping Load/Save Random Seed...
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped Load Kernel Modules.
[  OK  ] Stopped Load/Save Random Seed.
[  OK  ] Stopped Update UTMP about System Boot/Shutdown.
[  OK  ] Stopped Create Volatile Files and Directories.
[  OK  ] Stopped target Local File Systems.
         Unmounting Runtime Directory...
         Unmounting /mounts/mp_0007...
         Unmounting /run/user/0...
         Unmounting /mounts/mp_0008...
         Unmounting /mounts/mp_0006...
         Unmounting /parts/mp_0001...
         Unmounting /parts/mp_0000...
         Unmounting /parts/mp_0002...
[  OK  ] Unmounted Runtime Directory.
[FAILED] Failed unmounting /mounts/mp_0007.
[  OK  ] Unmounted /run/user/0.
[  OK  ] Unmounted /mounts/mp_0008.
[FAILED] Failed unmounting /mounts/mp_0006.
[  OK  ] Unmounted /parts/mp_0001.
[  OK  ] Unmounted /parts/mp_0000.
[  OK  ] Unmounted /parts/mp_0002.
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Stopped target Local File Systems (Pre).
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create System Users.
[  OK  ] Stopped Remount Root and Kernel File Systems.
[  OK  ] Reached target Shutdown.
[  395.257540] watchdog: watchdog0: watchdog did not stop!
[  395.293527] systemd-shutdow: 26 output lines suppressed due to ratelimiting
[  395.328579] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[  395.368598] systemd-journald[20574]: Received SIGTERM from PID 1 (systemd-shutdow).
[  395.407072] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[  395.446676] systemd-shutdown[1]: Hardware watchdog 'HPE iLO2+ HW Watchdog Timer', version 0
[  395.486573] systemd-shutdown[1]: Unmounting file systems.
[  395.512981] systemd-shutdown[1]: Remounting '/mounts/mp_0007' read-only with options ''.
[  395.553794] systemd-shutdown[1]: Unmounting /mounts/mp_0007.
[  395.580892] systemd-shutdown[1]: Remounting '/mounts/mp_0006' read-only with options ''.
[  395.623059] systemd-shutdown[1]: Unmounting /mounts/mp_0006.
[  395.650665] systemd-shutdown[1]: Remounting '/mounts/mp_0007' read-only with options ''.
[  395.690185] systemd-shutdown[1]: Unmounting /mounts/mp_0007.
[  395.801559] kvm: exiting hardware virtualization
[  395.845937] usb 7-3: USB disconnect, device number 2
[  395.871144] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  395.925427] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  395.979835] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.034388] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.088923] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.143572] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.198263] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.201198] usb 4-2: new full-speed USB device number 2 using ohci-pci
[  396.252547] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.338649] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.393474] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.448037] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.498950] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.550102] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.600537] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.651809] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.702482] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.753413] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.804273] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.855220] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  396.905728] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  397.161326] reboot: Restarting system
[  397.178771] reboot: machine restart




--------------F5519E624D0AD1E3F7DDA019
Content-Type: text/x-log;
 name="takashi.the-latest-upstream.with.rafael.suggestion.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="takashi.the-latest-upstream.with.rafael.suggestion.log"




[    0.000000] Linux version 4.19.0-rc3-1.ga673072-default (geeko@buildhost) (gcc version 8.2.1 20180817 [gcc-8-branch revision 263612] (SUSE Linux)) #1 SMP PREEMPT Tue Sep 11 11:47:58 UTC 2018 (a673072)
[    0.000000] Command line: BOOT_IMAGE=/boot/loader-esfHVL/linux install=http://apac2-kvm.qa2.suse.asia/index2/jnwang/dist/install/SLP/SLE-12-SP4-Server-Beta4/ Textmode=1 sysrq_always_enabled panic=100 ignore_loglevel addon= console=ttyS0,115200n8 ssh=1 sshpassword=susetesting
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x1df/0x270 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bddddfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bddde000-0x00000000bde0dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bde0e000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083effefff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.1 MHz processor
[    0.002540] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002544] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011130] AGP: No AGP bridge found
[    0.011207] last_pfn = 0x83efff max_arch_pfn = 0x400000000
[    0.011212] MTRR default type: uncachable
[    0.011213] MTRR fixed ranges enabled:
[    0.011215]   00000-9FFFF write-back
[    0.011217]   A0000-BFFFF uncachable
[    0.011218]   C0000-FFFFF write-back
[    0.011220] MTRR variable ranges enabled:
[    0.011222]   0 base 000000000000 mask FFFF80000000 write-back
[    0.011224]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.011225]   2 disabled
[    0.011227]   3 disabled
[    0.011228]   4 disabled
[    0.011229]   5 disabled
[    0.011230]   6 disabled
[    0.011231]   7 disabled
[    0.011232] TOM2: 000000083f000000 aka 33776M
[    0.012220] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.012511] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.012520] last_pfn = 0xbddde max_arch_pfn = 0x400000000
[    0.015049] found SMP MP-table at [mem 0x000f4f60-0x000f4f6f] mapped at [(____ptrval____)]
[    0.015173] Scanning 1 areas for low memory corruption
[    0.015176] Base memory trampoline at [(____ptrval____)] 84000 size 24576
[    0.015180] Using GB pages for direct mapping
[    0.015183] BRK [0x4a8a6a000, 0x4a8a6afff] PGTABLE
[    0.015187] BRK [0x4a8a6b000, 0x4a8a6bfff] PGTABLE
[    0.015189] BRK [0x4a8a6c000, 0x4a8a6cfff] PGTABLE
[    0.015217] BRK [0x4a8a6d000, 0x4a8a6dfff] PGTABLE
[    0.015220] BRK [0x4a8a6e000, 0x4a8a6efff] PGTABLE
[    0.015314] BRK [0x4a8a6f000, 0x4a8a6ffff] PGTABLE
[    0.015340] BRK [0x4a8a70000, 0x4a8a70fff] PGTABLE
[    0.015364] BRK [0x4a8a71000, 0x4a8a71fff] PGTABLE
[    0.015379] RAMDISK: [mem 0x1962d000-0x28b0dfff]
[    0.015384] ACPI: Early table checksum verification disabled
[    0.015442] ACPI: RSDP 0x00000000000F4EE0 000024 (v02 HP    )
[    0.015446] ACPI: XSDT 0x00000000BDDE1880 00B4 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015454] ACPI: FACP 0x00000000BDDE1980 0000F4 (v03 HP     ProLiant 00000002 �?   0000162E)
[    0.015462] ACPI: DSDT 0x00000000BDDE1A80 00D2F7 (v01 HP     DSDT     00000001 INTL 20061109)
[    0.015467] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015471] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015474] ACPI: SPCR 0x00000000BDDDE180 000050 (v01 HP     SPCRRBSU 00000001 �?   0000162E)
[    0.015479] ACPI: MCFG 0x00000000BDDDE200 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.015483] ACPI: HPET 0x00000000BDDDE240 000038 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015487] ACPI: SPMI 0x00000000BDDDE280 000040 (v05 HP     ProLiant 00000001 �?   0000162E)
[    0.015491] ACPI: ERST 0x00000000BDDDE2C0 000230 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015495] ACPI: APIC 0x00000000BDDDE500 00009E (v01 HP     ProLiant 00000002      00000000)
[    0.015499] ACPI: SRAT 0x00000000BDDDE800 000128 (v02 AMD    AGESA    00000001 AMD  00000001)
[    0.015503] ACPI: FFFF 0x00000000BDDDF000 000176 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015507] ACPI: BERT 0x00000000BDDDF180 000030 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015511] ACPI: HEST 0x00000000BDDDF1C0 00018C (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015515] ACPI: FFFF 0x00000000BDDDF380 000064 (v02 HP     ProLiant 00000002 �?   0000162E)
[    0.015519] ACPI: SLIT 0x00000000BDDDF400 000030 (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.015523] ACPI: FFFF 0x00000000BDDE1800 00006E (v01 HP     Proliant 00000001 PH   0000504D)
[    0.015527] ACPI: IVRS 0x00000000BDDDF800 0001A0 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.015531] ACPI: SSDT 0x00000000BDDEED80 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
[    0.015535] ACPI: SSDT 0x00000000BDDEEEC0 000377 (v01 HP     pmab     00000001 INTL 20120503)
[    0.015539] ACPI: SSDT 0x00000000BDDEF240 001714 (v02 AMD    POWERNOW 00000001 AMD  00000001)
[    0.015548] ACPI: Local AP address 0xfee00000
[    0.015596] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.015597] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.015599] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.015600] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.015601] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.015602] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.015604] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.015605] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.015608] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.015610] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.015611] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83effffff]
[    0.015616] NUMA: Initialized distance table, cnt=2
[    0.015619] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.015621] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x83effefff] -> [mem 0x00000000-0x83effefff]
[    0.015629] NODE_DATA(0) allocated [mem 0x83efe8000-0x83effdfff]
[    0.015704] Zone ranges:
[    0.015706]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015708]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015711]   Normal   [mem 0x0000000100000000-0x000000083effefff]
[    0.015713]   Device   empty
[    0.015714] Movable zone start for each node
[    0.015717] Early memory node ranges
[    0.015718]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.015720]   node   0: [mem 0x0000000000100000-0x00000000bddddfff]
[    0.015721]   node   0: [mem 0x0000000100000000-0x000000083effefff]
[    0.015894] Reserved but unavailable: 8836 pages
[    0.015896] Initmem setup node 0 [mem 0x0000000000001000-0x000000083effefff]
[    0.015898] On node 0 totalpages: 8375675
[    0.015900]   DMA zone: 64 pages used for memmap
[    0.015901]   DMA zone: 42 pages reserved
[    0.015903]   DMA zone: 3998 pages, LIFO batch:0
[    0.016015]   DMA32 zone: 12088 pages used for memmap
[    0.016017]   DMA32 zone: 773598 pages, LIFO batch:63
[    0.037735]  ormal zone: 118720 pages used for memmap
[    0.037739]   Normal zone: 7598079 pages, LIFO batch:63
[    0.038842] ACPI: PM-Timer IO Port: 0x920
[    0.038846] ACPI: Local APIC address 0xfee00000
[    0.038855] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.038868] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
[    0.038871] IOAPIC[1]: apic_id 9, version 33, address 0xfaffc000, GSI 24-55
[    0.038874] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.038876] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.038878] ACPI: IRQ0 used by override.
[    0.038880] ACPI: IRQ9 used by override.
[    0.038883] Using ACPI (MADT) for SMP configuration information
[    0.038885] ACPI: HPET id: 0x1166a201 base: 0xfed00000
[    0.038889] ACPI: SPCR: SPCR table version 1
[    0.038890] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.038892] ACPI: SPCR: console: uart,mmio,0x0,115200
[    0.038895] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.038898] NODE_DATA(1) allocated [mem 0x83efc9000-0x83efdefff]
[    0.038899]     NODE_DATA(1) on node 0
[    0.038921] Initmem setup node 1 [mem 0x0000000000000000-0x0000000000000000]
[    0.038922] On node 1 totalpages: 0
[    0.038936] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.038939] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.038940] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.038942] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.038944] PM: Registered nosave memory: [mem 0xbddde000-0xbde0dfff]
[    0.038945] PM: Registered nosave memory: [mem 0xbde0e000-0xcfffffff]
[    0.038946] PM: Registered nosave memory: [mem 0xd0000000-0xfebfffff]
[    0.038947] PM: Registered nosave memory: [mem 0xfec00000-0xfee0ffff]
[    0.038949] PM: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.038950] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.038952] [mem 0xd0000000-0xfeffff] available for PCI devices
[    0.038954] Booting paravirtualized kernel on bare hardware
[    0.038958] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.184498] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:2
[    0.185602] percpu: Embedded 47 pages/cpu @(____ptrval____) s155648 r8192 d28672 u524288
[    0.185611] pcpu-alloc: s155648 r8192 d28672 u524288 alloc=1*2097152
[    0.185613] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7
[    0.185639] Built 2 zonelists, mobility grouping on.  Total pages: 8244761
[    0.185640] Policy zone: Normal
[    0.185643] Kernel command line: BOOT_IMAGE=/boot/loader-esfHVL/linux install=http://apac2-kvm.qa2.suse.asia/index2/jnwang/dist/install/SLP/SLE-12-SP4-Server-Beta4/ Textmode=1 sysrq_always_enabled panic=100 ignore_loglevel addon= console=ttyS0,115200n8 ssh=1 sshpassword=susetesting
[    0.185714] sysrq: sysrq always enabled.
[    0.185781] log_buf_len individual max cpu contribution: 32768 bytes
[    0.185782] log_buf_len total cpu_extra contributions: 229376 bytes
[    0.185783] log_buf_len min size: 262144 bytes
[    0.185961] log_buf_len: 524288 bytes
[    0.185962] early log buf free: 250636(95%)
[    0.200885] AGP: Checking aperture...
[    0.209471] AGP: No AGP bridge found
[    0.209475] AGP: Node 0: aperture [bus addr 0xb4000000-0xb5ffffff] (32MB)
[    0.209477] Aperture pointing to e820 RAM. Ignoring.
[    0.209478] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.209479] AGP: Please enable the IOMMU option in the BIOS setup
[    0.209480] AGP: This costs you 64MB of RAM
[    0.209483] AGP: Mapping aperture over RAM [mem 0xb4000000-0xb7ffffff] (65536KB)
[    0.209486] PM: Registered nosave memory: [mem 0xb4000000-0xb7ffffff]
[    0.252321] Memory: 2859428K/33502700K available (12300K kernel code, 1504K rwdata, 3596K rodata, 2028K init, 1364K bss, 936180K reserved, 0K cma-reserved)
[    0.252456] ftrace: allocating 36133 entries in 142 pages
[  0.272260] rcu: Preemptible hierarchical RCU implementation.
[    0.272263] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.272265]  Tasks RCU enabled.
[    0.272267] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.276078] NR_IRQS: 33024, nr_irqs: 1032, preallocated irqs: 16
[    0.276383] spurious 8259A interrupt: IRQ7.
[    0.280973] Console: colour VGA+ 80x25
[    1.253913] console [ttyS0] enabled
[    1.255131] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.258880] ACPI: Core revision 20180810
[    1.260475] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    1.263584] hpet clockevent registered
[    1.264877] APIC: Switch to symmetric I/O mode setup
[    1.306115] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.327584] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28430372478, max_idle_ns: 440795344753 ns
[    1.331139] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.32 BogoMIPS (lpj=11172640)
[    1.335132] pid_max: default: 32768 minimum: 301
[    1.339234] Security Framework initialized
[    1.340717] AppArmor: AppArmor initialized
[    1.351019] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    1.357762] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    1.359300] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.361776] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.363429] mce: CPU supports 7 MCE banks
[    1.367140] LVT offset 1 assigned for vector 0xf9
[    1.368697] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    1.370690] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    1.371133] Spectre V2 : Mitigation: Full AMD retpoline
[    1.372878] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.375131] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    1.379132] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    1.391188] Freeing SMP alternatives memory: 32K
[    1.395130] smpboot: CPU0: AMD Opteron(tm) Processor 6320 (family: 0x15, model: 0x2, stepping: 0x0)
[    1.419143] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    1.422561] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 430076)
[    1.423136] AMD PMU driver.
[    1.424095] ... version:                0
[    1.427134] ... bit width:              48
[    1.428544] ... generic registers:      6
[    1.429953] ... value mask:             0000ffffffffffff
[    1.431131] ... max period:             00007fffffffffff
[    1.432862] ... fixed-purpose events:   0
[    1.435131] ... event mask:             000000000000003f
[    1.443136] rcu: Hierarchical SRCU implementation.
[    1.463147] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.471140] smp: Bringing up secondary CPUs ...
[    1.511194] x86: Booting SMP configuration:
[    1.512646] .... node  #0, CPUs:      #1 #2 #3
[    1.636733] .... node  #1, CPUs:   #4 #5 #6 #7
[    1.762056] smp: Brought up 2 nodes, 8 CPUs
[    1.764627] smpboot: Max logical packages: 1
[    1.766052] smpboot: Total of 8 processors activated (44690.56 BogoMIPS)
[    2.135145] node 0 initialised, 7426773 pages in 364ms
[    2.139186] devtmpfs: initialized
[    2.139208] x86/mm: Memory block size: 128MB
[    2.145252] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.147148] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.151283] pinctrl core: initialized pinctrl subsystem
[    2.153094] RTC time:  9:52:06, date: 09/13/18
[    2.153094] NET: Registered protocol family 16
[    2.153094] audit: initializing netlink subsys (disabled)
[    2.155163] audit: type=2000 audit(1536832324.852:1): state=initialized audit_enabled=0 res=1
[    2.159135] cpuidle: using governor ladder
[    2.163161] cpuidle: using governor menu
[    2.164500] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    2.167135] ACPI: bus type PCI registered
[    2.168483] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.168483] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    2.171134] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    2.173454] PCI: Using configuration type 1 for base access
[    2.179188] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.183136] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.185523] ACPI: Added _OSI(Module Device)
[    2.187134] ACPI: Added _OSI(Processor Device)
[    2.188643] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.190355] ACPI: Added _OSI(Processor Aggregator Device)
[    2.191133] ACPI: Added _OSI(Linux-Dell-Video)
[    2.192644] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.212757] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    2.234823] ACPI: Interpreter enabled
[    2.235148] ACPI: (supports S0 S4 S5)
[    2.236411] ACPI: Using IOAPIC for interrupt routing
[    2.239143] HEST: Table parsing has been initialized.
[    2.240961] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.275452] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    2.277576] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.279302] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    2.283133] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    2.286169] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    2.287132] acpi PNP0A08:00: _OSC: platform willing to grant []
[    2.291133] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    2.293787] PCI host bridge to bus 0000:00
[    2.295133] pci_bus 0000:00: root bus resource [mem 0xfaf00000-0xfdffffff window]
[    2.297668] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
[    2.299133] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.303132] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.305435] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    2.307132] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed03fff window]
[    2.309708] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    2.311133] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    2.315132] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    2.317354] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.319133] pci_bus 0000:00: root bus resource [bus 00-3f]
[    2.321006] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    2.323363] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    2.326000] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    2.327151] pci 0000:00:02.0: enabling Extended Tags
[    2.328945] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    2.331343] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    2.333449] pci 0000:00:0a.0: enabling Extended Tags
[    2.335159] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    2.337411] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    2.339150] pci 0000:00:0c.0: enabling Extended Tags[    2.343158] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    2.347344] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    2.349322] pci 0000:00:11.0: reg 0x10: [io  0x1000-0x1007]
[    2.351140] pci 0000:00:11.0: reg 0x14: [io  0x1008-0x100b]
[    2.353074] pci 0000:00:11.0: reg 0x18: [io  0x1010-0x1017]
[    2.355140] pci 0000:00:11.0: reg 0x1c: [io  0x1018-0x101b]
[    2.357031] pci 0000:00:11.0: reg 0x20: [io  0x1020-0x102f]
[    2.359140] pci 0000:00:11.0: reg 0x24: [mem 0xfccf0000-0xfccf03ff]
[    2.361246] pci 0000:00:11.0: set SATA to AHCI mode
[    2.363342] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    2.365420] pci 0000:00:12.0: reg 0x10: [mem 0xfcce0000-0xfcce0fff]
[    2.367368] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    2.369344] pci 0000:00:12.1: reg 0x10: [mem 0xfccd0000-0xfccd0fff]
[    2.371370] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    2.375153] pci 0000:00:12.2: reg 0x10: [mem 0xfccc0000-0xfccc00ff]
[    2.377353] pci 0000:00:12.2: supports D1 D2
[    2.378878] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    2.381369] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    2.383149] pci 0000:00:13.0: reg 0x10: [mem 0xfccb0000-0xfccb0fff]
[    2.385551] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    2.387149] pci 0000:00:13.1: reg 0x10: [mem 0xfcca0000-0xfcca0fff]
[    2.389475] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    2.391152] pci 0000:00:13.2: reg 0x10: [mem 0xfcc90000-0xfcc900ff]
[    2.393458] pci 0000:00:13.2: supports D1 D2
[    2.395132] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    2.397350] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    2.399408] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    2.401702] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
[    2.403140] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
[    2.407140] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
[    2.409017] pci 0000:00:14.1: reg 0x1c: [io  374-0x0377]
[    2.411140] pci 0000:00:14.1: reg 0x20: [io  0x0500-0x050f]
[    2.415151] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    2.419132] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    2.421320] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    2.423132] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    2.425516] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    2.427390] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    2.429744] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    2.431329] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    2.435320] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    2.437563] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    2.439326] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    2.441556] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    2.443322] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    2.445669] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[    2.447323] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    2.451325] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    2.453551] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    2.455325] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    2.457649] pci 0000:03:00.0: [103c:323b] type 00 class 0x010400
[    2.459149] pci 0000:03:00.0: reg 0x10: [mem 0xfdf00000-0xfdffffff 64bit]
[    2.461423] pci 0000:03:00.0: reg 0x18: [mem 0xfdef0000-0xfdef03ff 64bit]
[    2.463138] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
[    2.464978] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    2.467137] pci 0000:03:00.0: enabling Extended Tags
[    2.468816] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    2.471154] pci 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x8 link at 0000:00:02.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[    2.475181] pci 0000:00:02.0: PCI bridge to [bus 03]
[    2.479134] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    2.481204] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    2.483193] pci 0000:02:00.0: [103c:3306] type 00 class 0x088000
[    2.485258] pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
[    2.487141] pci 0002:00.0: reg 0x14: [mem 0xfddf0000-0xfddf01ff]
[    2.491141] pci 0000:02:00.0: reg 0x18: [io  0x3400-0x34ff]
[    2.495246] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:0a.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    2.499193] pci 0000:02:00.1: [102b:0533] type 00 class 0x030000
[    2.501352] pci 0000:02:00.1: reg 0x10: [mem 0xfb000000-0xfbffffff pref]
[    2.503141] pci 0000:02:00.1: reg 0x14: [mem 0xfdde0000-0xfdde3fff]
[    2.505198] pci 0000:02:00.1: reg 0x18: [mem 0xfd000000-0xfd7fffff]
[    2.507294] pci 0000:02:00.2: [103c:3307] type 00 class 0x088000
[    2.511154] pci 0000:02:00.2: reg 0x10: [io  0x3800-0x38ff]
[    2.513116] pci 0000:02:00.2: reg 0x14: [mem 0xfcff0000-0xfcff00ff]
[    2.515141] pci 0000:02:00.2: reg 0x18: [mem 0xfce00000-0xfcefffff]
[    2.517241] pci 0000:02:00.2: reg 0x1c: [mem 0xfcd80000-0xfcdfffff]
[    2.519140] pci 0000:02:00.2: reg 0x20: [mem 0xfcd70000-0xfcd77fff]
[    2.521142] pci 0000:02:00.2: reg 0x24: [mem 0xfcd60000-0xfcd67fff]
[    2.523141] pci 0000:02:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    2.525441] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    2.527206] pci 0000:02:00.4: [103c:3300] type 00 class 0x0c0300
[    2.529254] pci 0000:02:00.4: reg 0x20: [io  0x3c00-0x3c1f]
[    2.543154] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    2.544910] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    2.546930] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    2.547135] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    2.551258] pci 0000:04:00.0: [14e4:1657] type 00 class 0x020000
[    2.553337] pci 0000:04:00.0: reg 0x10: [mem 0xfcbf0000-0xfcbfffff 64bit pref]
[    2.555142] pci 0000:04:00.0: reg 0x18: [mem 0xfcbe0000-0xfcbeffff 64bit pref]
[    2.557533] pci 0000:04:00.0: reg 0x20: [mem 0xfcbd0000-0xfcbdffff 64bit pref]
[    2.559139] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.563197] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    2.565257] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:0c.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
[    2.567236] pci 0000:04:00.1: [14e4:1657] type 00 class 0x020000
[    2.571153] pci 0000:04:00.1: reg 0x10: [mem 0xfcbc0000-0xfcbcffff 64bit pref]
[    2.575142] pci 0000:04:00.1: reg 0x18: [mem 0xfcbb0000-0xfcbbffff 64bit pref]
[    2.577568] pci 0000:04:00.1: reg 0x20: [mem 0xfcba0000-0xfcbaffff 64bit pref]
[    2.579139] pci 0000:04:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.581589] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    2.583249] pci 0000:04:00.2: [14e4:1657] type 00 class 0x020000
[    2.585324] pci 0000:04:00.2: reg 0x10: [mem 0xfcb90000-0xfcb9ffff 64bit pref]
[    2.587142] pci 0000:04:00.2: reg 0x18: [mem 0xfcb80000-0xfcb8ffff 64bit pref]
[    2.591142] pci 0000:04:00.2: reg 0x20: [mem 0xfcb70000-0xfcb7ffff 64bit pref]
[    2.593573] pci 0000:04:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.595193] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
[    2.597353] pci 0000:04:00.3: [14e4:1657] type 00 class 0x020000
[    2.599153] pci 0000:04:00.3: reg 0x10: [mem 0xfcb60000-0xfcb6ffff 64bit pref]
[    2.601630] pci 0000:04:00.3: reg 0x18: [memfcb50000-0xfcb5ffff 64bit pref]
[    2.603142] pci 0000:04:00.3: reg 0x20: [mem 0xfcb40000-0xfcb4ffff 64bit pref]
[    2.607139] pci 0000:04:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.609454] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    2.611255] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    2.612934] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    2.615144] pci_bus 0000:01: extended config space not accessible
[    2.617189] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    2.619140] pci 0000:00:14.4:   bridge window [mem 0xfaf00000-0xfdffffff window] (subtractive decode)
[    2.623133] pci 0000:00:14.4:   bridge window [io  0x1000-0xffff window] (subtractive decode)
[    2.625920] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    2.627132] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    2.631132] pci 0000:00:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
[    2.635132] pci 0000:00:14.4:   bridge window [mem 0xfed00000-0xfed03fff window] (subtractive decode)
[    2.638149] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
[    2.639132] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    2.643132] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    2.647133] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    2.651140] ACPI: PCI Interrupt Link [I020] (IRQs *24)
[    2.653456] ACPI: PCI Interrupt Link [I021] (IRQs *25)
[    2.655630] ACPI: PCI Interrupt Link [I022] (IRQs *26)
[    2.658143] ACPI: PCI Interrupt Link [I023] (IRQs *27)
[    2.659609] ACPI: PCI Interrupt Link [I030] (IRQs *28)
[    2.663189] ACPI: PCI Interrupt Link [I031] (IRQs *29)
[    2.665453] ACPI: PCI Interrupt Link [I032] (IRQs *30)
[    2.667646] ACPI: PCI Interrupt Link [I033] (IRQs *31)
[    2.669938] ACPI: PCI Interrupt Link [I040] (IRQs *44)
[    2.671635] ACPI: PCI Interrupt Link [I041] (IRQs *45)
[    2.673880] ACPI: PCI Interrupt Link [I042] (IRQs *46)
[    2.675651] ACPI: PCI Interrupt Link [I043] (IRQs *47)
[    2.679190] ACPI: PCI Interrupt Link [I050] (IRQs *48)
[    2.681461] ACPI: PCI Interrupt Link [I051] (IRQs *49)
[    2.683660] ACPI: PCI Interrupt Link [I052] (IRQs *50)
[    2.686021] ACPI: PCI Interrupt Link [I053] (IRQs *51)
[    2.687673] ACPI: PCI Interrupt Link [I060] (IRQs *47)
[    2.690020] ACPI: PCI Interrupt Link [I061] (IRQs *44)
[    2.691652] ACPI: PCI Interrupt Link [I062] (IRQs *45)
[    2.695485] ACPI: PCI Interrupt Link [I063] (IRQs *46)
[    2.697766] ACPI: PCI Interrupt Link [I070] (IRQs *24)
[    2.699667] ACPI: PCI Interrupt Link [I071] (IRQs *25)
[    2.702030] ACPI: PCI Interrupt Link [I072] (IRQs *26)
[    2.703682] ACPI: PCI Interrupt Link [I073] (IRQs *27)
[    2.705625] ACPI: PCI Interrupt Link [I090] (IRQs *24)
[    2.707290] ACPI: PCI Interrupt Link [I091] (IRQs *24)
[    2.709202] ACPI: PCI Interrupt Link [I092] (IRQs *24)
[    2.711290] ACPI: PCI Interrupt Link [I093] (IRQs *24)
[    2.713581] ACPI: PCI Interrupt Link [I0A0] (IRQs *24)
[    2.715682] ACPI: PCI Interrupt Link [I0A1] (IRQs *25)
[    2.719531] ACPI: PCI Interrupt Link [I0A2] (IRQs *26)
[    2.721894] ACPI: PCI Interrupt Link [I0A3] (IRQs *27)
[    2.723678] ACPI: PCI Interrupt Link [I0B0] (IRQs *32)
[    2.726042] ACPI: PCI Interrupt Link [I0B1] (IRQs *33)
[    2.727700] ACPI: PCI Interrupt Link [I0B2] (IRQs *34)
[    2.731540] ACPI: PCI Interrupt Link [I0B3] (IRQs *35)
[    2.734009] ACPI: PCI Interrupt Link [I0C0] (IRQs *36)
[    2.735706] ACPI: PCI Interrupt Link [I0C1] (IRQs *37)
[    2.738071] ACPI: PCI Interrupt Link [I0C2] (IRQs *38)
[    2.739719] ACPI: PCI Interrupt Link [I0C3] (IRQs *39)
[    2.743604] ACPI: PCI Interrupt Link [I0D0] (IRQs *40)
[    2.745993] ACPI: PCI Interrupt Link [I0D1] (IRQs *41)
[    2.747720] ACPI: PCI Interrupt Link [I0D2] (IRQs *42)
[    2.750039] ACPI: PCI Interrupt Link [I0D3] (IRQs *43)
[    2.751209] ACPI: PCI Interrupt Link [BI02] (IRQs *52)
[    2.753047] ACPI: PCI Interrupt Link [BI03] (IRQs *52)
[    2.755228] ACPI: PCI Interrupt Link [BI04] (IRQs *52)
[    2.757026] ACPI: PCI Interrupt Link [BI05] (IRQs *52)
[    2.759248] ACPI: PCI Interrupt Link [BI06] (IRQs *54)
[    2.761111] ACPI: PCI Interrupt Link [BI07] (IRQs *24)
[    2.763270] ACPI: PCI Interrupt Link [BI08] (IRQs *24)
[    2.765358] ACPI: PCI Interrupt Link [BI09] (IRQs *24)
[    2.767286] ACPI: PCI Interrupt Link [BI0A] (IRQs *24)
[    2.769324] ACPI: PCI Interrupt Link [BI0B] (IRQs *54)
[    2.771309] ACPI: PCI Interrupt Link [BI0C] (IRQs *54)
[    2.773378] ACPI: PCI Interrupt Link [BI0D] (IRQs *54)
[    2.775252] ACPI: PCI Interrupt Link [PI20] (IRQs 10 11) *0, disabled.
[    2.777636] ACPI: PCI Interrupt Link [PI21] (IRQs 10 11) *0, disabled.
[    2.779272] ACPI: PCI Interrupt Link [PI22] (IRQs 10 11) *0, disabled.
[    2.781729] ACPI: PCI Interrupt Link [PI23] (IRQs 10 11) *0, disabled.
[    2.783271] ACPI: PCI Interrupt Link [PI30] (IRQs 10 11) *0, disabled.
[    2.787273] ACPI: PCI Interrupt Link [PI31] (IRQs 10 11) *0, disabled.
[    2.789742] ACPI: PCI Interrupt Link [PI32] (IRQs 10 11) *0, disabled.
[    2.791271] ACPI: PCI Interrupt Link [PI33] (IRQs 10 11) *0, disabled.
[    2.793624] ACPI: PCI Interrupt Link [PI40] (IRQs 10 11) *0, disabled.
[    2.795270] ACPI: PCI Interrupt Link [PI41] (IRQs 10 11) *0, disabled.
[    2.799272] ACPI: PCI Interrupt Link [PI42] (IRQs 10 11) *0, disabled.
[    2.801693] ACPI: PCI Interrupt Link [PI43] (IRQs 10 11) *0, disabled.
[    2.803271] ACPI: PCI Interrupt Link [PI50] (IRQs 10 11) *0, disabled.
[    2.807145] ACPI: PCI Interrupt Link [PI51] (IRQs 10 11) *0, disabled.
[    2.809539] ACPI: PCI Interr Link [PI52] (IRQs 10 11) *0, disabled.
[    2.811270] ACPI: PCI Interrupt Link [PI53] (IRQs 10 11) *0, disabled.
[    2.813605] ACPI: PCI Interrupt Link [PI60] (IRQs 10 11) *0, disabled.
[    2.815269] ACPI: PCI Interrupt Link [PI61] (IRQs 10 11) *0, disabled.
[    2.817537] ACPI: PCI Interrupt Link [PI62] (IRQs 10 11) *0, disabled.
[ 2.819268] ACPI: PCI Interrupt Link [PI63] (IRQs 10 11) *0, disabled.
[    2.823271] ACPI: PCI Interrupt Link [PI70] (IRQs 10 11) *0, disabled.
[    2.825640] ACPI: PCI Interrupt Link [PI71] (IRQs 10 11) *0, disabled.
[    2.827269] ACPI: PCI Interrupt Link [PI72] (IRQs 10 11) *0, disabled.
[    2.829581] ACPI: PCI Interrupt Link [PI73] (IRQs 10 11) *0, disabled.
[    2.831269] ACPI: PCI Interrupt Link [PI90] (IRQs 10 11) *0, disabled.
[    2.835268] ACPI: PCI Interrupt Link [PI91] (IRQs 10 11) *0, disabled.
[    2.837611] ACPI: PCI Interrupt Link [PI92] (IRQs 10 11) *0, disabled.
[    2.839268] ACPI: PCI Interrupt Link [PI93] (IRQs 10 11) *0, disabled.
[    2.841706] ACPI: PCI Interrupt Link [PIA0] (IRQs 10 11) *0, disabled.
[    2.843268] ACPI: PCI Interrupt Link [PIA1] (IRQs 10 11) *0, disabled.
[    2.847273] ACPI: PCI Interrupt Link [PIA2] (IRQs 10 11) *0, disabled.
[    2.849609] ACPI: PCI Interrupt Link [PIA3] (IRQs 10 11) *0, disabled.
[    2.851283] ACPI: PCI Interrupt Link [PIB0] (IRQs 10 11) *0, disabled.
[    2.853608] ACPI: PCI Interrupt Link [PIB1] (IRQs 10 11) *0, disabled.
[    2.855270] ACPI: PCI Interrupt Link [PIB2] (IRQs 10 11) *0, disabled.
[    2.859269] ACPI: PCI Interrupt Link [PIB3] (IRQs 10 11) *0, disabled.
[    2.861601] ACPI: PCI Interrupt Link [PIC0] (IRQs 10 11) *0, disabled.
[    2.863269] ACPI: PCI Interrupt Link [PIC1] (IRQs 10 11) *0, disabled.
[    2.865635] ACPI: PCI Interrupt Link [PIC2] (IRQs 10 11) *0, disabled.
[    2.869464] ACPI: PCI Interrupt Link [PIC3] (IRQs 10 11) *0, disabled.
[    2.871269] ACPI: PCI Interrupt Link [PID0] (IRQs 10 11) *0, disabled.
[    2.873633] ACPI: PCI Interrupt Link [PID1] (IRQs 10 11), disabled.
[    2.875271] ACPI: PCI Interrupt Link [PID2] (IRQs 10 11) *0, disabled.
[    2.877647] ACPI: PCI Interrupt Link [PID3] (IRQs 10 11) *0, disabled.
[    2.879283] ACPI: PCI Interrupt Link [PIR2] (IRQs 10 11) *0, disabled.
[    2.883278] ACPI: PCI Interrupt Link [PIR3] (IRQs 10 11) *0, disabled.
[    2.885601] ACPI: PCI Interrupt Link [PIR4] (IRQs 10 11) *0, disabled.
[    2.887270] ACPI: PCI Interrupt Link [PIR5] (IRQs 10 11) *0, disabled.
[    2.889625] ACPI: PCI Interrupt Link [PIR6] (IRQs 10 11) *0, disabled.
[    2.891269] ACPI: PCI Interrupt Link [PIR7] (IRQs 10 11) *0, disabled.
[    2.895268] ACPI: PCI Interrupt Link [PIR8] (IRQs 10 11) *0, disabled.
[    2.897620] ACPI: PCI Interrupt Link [PIR9] (IRQs 10 11) *0, disabled.
[    2.899269] ACPI: PCI Interrupt Link [PIRA] (IRQs 10 11) *0, disabled.
[    2.901683] ACPI: PCI Interrupt Link [PIRB] (IRQs 10 11) *0, disabled.
[    2.903270] ACPI: PCI Interrupt Link [PIRC] (IRQs 10 11) *0, disabled.
[    2.907268] ACPI: PCI Interrupt Link [PIRD] (IRQs 10 11) *0, disabled.
[    2.909598] ACPI: PCI Interrupt Link [USB1] (IRQs *22)
[    2.911231] ACPI: PCI Interrupt Link [USB2] (IRQs *23)
[    2.913222] ACPI: PCI Interrupt Link [USB3] (IRQs *23)
[    2.915246] ACPI: PCI Interrupt Link [USB4] (IRQs *22)
[    2.917098] ACPI: Invalid _PRS IRQ 0
[    2.918467] ACPI: PCI Interrupt Link [U1PI] (IRQs) *0
[    2.919294] ACPI: Invalid _PRS IRQ 0
[    2.920722] ACPI: PCI Interrupt Link [U2PI] (IRQs) *0
[    2.923297] ACPI: Invalid _PRS IRQ 0
[    2.924690] ACPI: PCI Interrupt Link [U3PI] (IRQs) *0
[    2.927307] ACPI: Invalid _PRS IRQ 0
[    2.928704] ACPI: PCI Interrupt Link [U4PI] (IRQs) *0
[    2.930513] ACPI: PCI Interrupt Link [SATA] (IRQs *16)
[    2.931214] ACPI: Invalid _PRS IRQ 0
[    2.932478] ACPI: PCI Interrupt Link [SATP] (IRQs) *0
[    2.935685] pci 0000:02:00.1: vgaarb: setting as boot VGA device
[    2.937087] pci 0000:02:00.1: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.939134] pci 0000:02:00.1: vgaarb: bridge control possible
[    2.941129] vgaarb: loaded
[    2.943233] SCSI subsystem initialized
[    2.944589] libata version 3.00 loaded.
[    2.944589] EDAC MC: Ver: 3.0.0
[    2.947236] PCI: Using ACPI for IRQ routing
[    2.958453] PCI: pci_cache_line_size set to 64 bytes
[    2.959199] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    2.961340] e820: reserve RAM buffer [mem 0xbddde000-0xbfffffff]
[    2.963132] e820: reserve RAM buffer [mem 0x83efff000-0x83fffffff]
[    2.965356] NetLabel: Initializing
[    2.967132] NetLabel:  domain hash size = 128
[    2.968577] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.971144] NetLabel:  unlabeled traffic allowed by default
[    2.973057] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    2.973057] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    2.975224] clocksource: Switched to clocksource tsc-early
[    2.994949] VFS: Disk quotas dquot_6.6.0
[    2.996448] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.998956] AppArmor: AppArmor Filesystem Enabled
[    3.000706] pnp: PnP ACPI init
[    3.005617] system 00:00: [io  0x0379-0x037a] has been reserved
[    3.007834] system 00:00: [io  0x0400-0x043f] has been reserved
[    3.009893] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    3.011848] system 00:00: [io  0x04d6] has been reserved
[    3.013654] system 00:00: [io  0x0520] has been reserved
[    3.015423] system 00:00: [io  0x0580-0x059f] has been reserved
[    3.017415] system 00:00: [io  0x0600-0x067f] has been reserved
[    3.019466] system 00:00: [io  0x0700-0x0703] has been reserved
[    3.021376] system 00:00: [io  0x0820-0x082f] has been reserved
[    3.023364] system 00:00: [io  0x0900-0x09fe] has been reserved
[    3.025339] system 00:00: [io  0x0c06-0x0c07] has been reserved
[    3.027323] system 00:00: [io  0x0c14] has been reserved
[    3.029168] system 00:00: [io  0x0c4a] has been reserved
[    3.031033] system 00:00: [io  0x0c50-0x0c52] has been reserved
[    3.033034] system 00:00: [io  0x0c6c] has been reserved
[    3.034804] system 00:00: [io  0x0c6f] has been reserved
[    3.036571] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    3.038632] system 00:00: [io  0x0c90-0x0c9f] has been reserved
[    3.040654] system 00:00: [io  0x0ca0-0x0ca5] could not be reserved
[    3.042728] system 00:00: [io  0x0cd0-0x0cdf] has been reserved
[    3.044678] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    3.046665] system 00:00: [io  0x0b00-0x0b3f] has been reserved
[    3.048683] system 00:00: [io  0x03f8-0x03ff] has been reserved
[    3.050714] system 00:00: [mem 0xc0000000-0xcfffffff] has been reserved
[    3.052925] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.055222] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    3.057791] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    3.060587] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    3.063111] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.065478] system 00:05: [mem 0xfaff4000-0xfafff] could not be reserved
[    3.167895] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.170314] pnp: PnP ACPI: found 6 devices
[    3.178406] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.181449] pci 0000:00:0c.0: BAR 14: assigned [mem 0xfc000000-0xfc0fffff]
[    3.183706] pci 0000:03:00.0: BAR 6: assigned [mem 0xfde00000-0xfde7ffff pref]
[    3.186105] pci 0000:00:02.0: PCI bridge to [bus 03]
[    3.187762] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    3.189854] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    3.192079] pci 0000:02:00.2: BAR 6: assigned [mem 0xfcd00000-0xfcd0ffff pref]
[    3.194531] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    3.196171] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    3.198209] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    3.200519] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    3.203259] pci 0000:04:00.0: BAR 6: assigned [mem 0xfc000000-0xfc03ffff pref]
[    3.205702] pci 0000:04:00.1: BAR 6: assigned [mem 0xfc040000-0xfc07ffff pref]
[    3.208121] pci 0000:04:00.2: BAR 6: assigned [mem 0xfc080000-0xfc0bffff pref]
[    3.210583] pci 0000:04:00.3: BAR 6: assigned [mem 0xfc0c0000-0xfc0fffff pref]
[    3.212943] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    3.214604] pci 0000:00:0c.0:   bridge window [mem 0xfc000000-0xfc0fffff]
[    3.216854] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    3.219486] pci 0000:00:14.4: PCI bridge to [bus 01]
[    3.221114] pci_bus 0000:00: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    3.223402] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
[    3.225469] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[    3.227488] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[    3.229653] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
[    3.231685] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff window]
[    3.233973] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff window]
[    3.236282] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb win]
[    3.338499] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df window]
[    3.340665] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.342992] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    3.344835] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdffffff]
[    3.346935] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    3.348866] pci_bus 0000:02: resource 1 [mem 0xfcd00000-0xfddfffff]
[    3.350923] pci_bus 0000:02: resource 2 [mem 0xfb000000-0xfbffffff 64bit pref]
[    3.353346] pci_bus 0000:04: resource 1 [mem 0xfc000000-0xfc0fffff]
[    3.355461] pci_bus 0000:04: resource 2 [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    3.357808] pci_bus 0000:01: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    3.360179] pci_bus 0000:01: resource 5 [io  0x1000-0xffff window]
[    3.362249] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
[    3.364301] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
[    3.366428] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
[    3.368573] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed03fff window]
[    3.370816] pci_bus 0000:01: resource 10 [mem 0xfed40000-0xfed44fff window]
[    3.373134] pci_bus 0000:01: resource 11 [io  0x03b0-0x03bb window]
[    3.375236] pci_bus 0000:01: resource 12 [io  0x03c0-0x03df window]
[    3.377320] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.379981] NET: Registered protocol family 2
[    3.381672] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
[    3.384486] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    3.387620] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.390277] TCP: Hash tables configured (established 262144 bind 65536)
[    3.392647] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    3.394933] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    3.397279] NET: Registered protocol family 1
[    3.399322] NET: Registered protocol family 44
[    3.401107] PCI Interrupt Link [USB1] enabled at IRQ 22
[    3.483320] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x693 took 80516 usecs
[    3.563318] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x693 took 75616 usecs
[    3.566006] PCI Interrupt Link [USB2] enabled at IRQ 23
[    3.587312] pci 0000:00:12.2: quirk_usb_early_handoff+0x0/0x693 took 20998 usecs
[    3.590166] PCI Interrupt Link [USB3] enabled at IRQ 23
[    3.671306] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x693 took 79434 usecs
[    3.751522] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x693 took 75856 usecs
[    3.754254] PCI Interrupt Link [USB4] enabled at IRQ 22
[    3.775313] pci 0000:00:13.2: quirk_usb_early_handoff+0x0/0x693 took 20766 usecs
[    3.777974] pci 0000:02:00.1: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.780981] PCI Interrupt Link [BI0A] enabled at IRQ 24
[    3.783236] PCI Interrupt Link [I061] enabled at IRQ 44
[    3.785132] PCI: CLS 64 bytes, default 64
[    3.786561] Unpacking initramfs...
[   12.640993] Freeing initrd memory: 250756K
[   12.642777] pci 0000:00:00.2: can't derive routing for PCI INT A
[   12.644867] pci 0000:00:00.2: PCI INT A: no GSI
[   12.646727] iommu: Adding device 0000:00:00.0 to group 0
[   12.648786] iommu: Adding device 0000:00:02.0 to group 1
[   12.650782] iommu: Adding device 0000:00:0a.0 to group 2
[   12.652727] iommu: Adding device 0000:00:0c.0 to group 3
[   12.654668] iommu: Adding device 0000:00:11.0 to group 4
[   12.656625] iommu: Adding device 0000:00:12.0 to group 5
[   12.658535] iommu: Adding device 0000:00:12.1 to group 5
[   12.660322] iommu: Adding device 0000:00:12.2 to group 5
[   12.662297] iommu: Adding device 0000:00:13.0 to group 6
[   12.664111] iommu: Adding device 0000:00:13.1 to group 6
[   12.665887] iommu: Adding device 0000:00:13.2 to group 6
[   12.667871] iommu: Adding device 0000:00:14.0 to group 7
[   12.669778] iommu: Adding device 0000:00:14.1 to group 8
[   12.671760] iommu: Adding device 0000:00:14.3 to group 9
[   12.673719] iommu: Adding device 0000:00:14.4 to group 10
[   12.675652] iommu: Adding device 0000:03:00.0 to group 11
[   12.677693] iommu: Adding device 0000:02:00.0 to group 12
[   12.679621] iommu: Adding device 0000:02:00.1 to group 12
[   12.681457] iommu: Adding device 0000:02:00.2 to group 12
[   12.683326] iommu: Adding device 0000:02:00.4 to group 12
[   12.685346] iommu: Adding device 0000:04:00.0 to group 13
[   12.687218] iommu: Adding device 0000:04:00.1 to group 13
[   12.689150] iommu: Adding device 0000:04:00.2 to group 13
[   12.691009] iommu: Adding device 0000:04:00.3 to group 13
[   12.730300] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[   12.732138] AMD-Vi: Interrupt remapping enabled
[   12.733745] AMD-Vi: Lazy IO/TLB flushing enabled
[   12.737799] amd_uncore: AMD NB counters detected
[   12.739645] LVT offset 0 assigned for vector 0x400
[   12.741466] perf: AMD IBS detected (0x000000ff)
[   12.743199] Scanning for low memory corruption every 60 seconds
[   12.745937] Initialise system trusted keyrings
[   12.747456] Key type blacklist registered
[   12.748906] workingset: timestamp_bits=37 max_order=23 bucket_order=0
[   12.751211] zbud: loaded
[   12.752580] pstore: using deflate compression
[   12.755785] Key type asymmetric registered
[   12.757269] Asymmetric key parser 'x509' registered
[   12.759020] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   12.761538] io scheduler noop registered
[   12.762830] io scheduler deadline registered
[   12.764258] io scheduler cfq registered (default)
[   12.765842] io scheduler mq-deadline registered
[   12.767363] io scheduler kyber registered
[   12.769207] PCI Interrupt Link [BI02] enabled at IRQ 52
[   12.771342] PCI Interrupt Link [BI0C] enabled at IRQ 54
[   12.773220] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.776271] ERST: Error Record Serialization Table (ERST) support is initialized.
[   12.781102] pstore: No deflate compression
[   12.782458] pstore: Registered erst as persistent store backend
[   12.784591] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[   12.787370] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   12.810188] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   12.833386] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   12.837713] Non-volatile memory driver v1.3
[   12.839243] Linux agpgart interface v0.103
[   12.842208] ahci 0000:00:11.0: version 3.0
[   12.843834] PCI Interrupt Link [SATA] enabled at IRQ 16
[   12.845689] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
[   12.848542] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc
[   12.851678] scsi host0: ahci
[   12.852766] ata1: SATA max UDMA/133 abar m1024@0xfccf0000 port 0xfccf0100 irq 16
[   12.855376] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[   12.860002] serio: i8042 KBD port at 0x60,0x64 irq 1
[   12.861709] serio: i8042 AUX port at 0x60,0x64 irq 12
[   12.863544] mousedev: PS/2 mouse device common for all mice
[   12.865510] rtc_cmos 00:04: RTC can wake from S4
[   12.867286] rtc_cmos 00:04: registered as rtc0
[   12.868906] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   12.871873] ledtrig-cpu: registered to indicate activity on CPUs
[   12.873940] hidraw: raw HID events driver (C) Jiri Kosina
[   12.875986] NET: Registered protocol family 10
[   12.881670] Segment Routing with IPv6
[   12.883616] RAS: Correctable Errors collector initialized.
[   12.886142] microcode: CPU0: patch_level=0x06000852
[   12.887852] microcode: CPU1: patch_level=0x06000852
[   12.889531] microcode: CPU2: patch_level=0x06000852
[   12.891167] microcode: CPU3: patch_level=0x06000852
[   12.892902] microcode: CPU4: patch_level=0x06000852
[   12.894561] microcode: CPU5: patch_level=0x06000852
[   12.896331] microcode: CPU6: patch_level=0x06000852
[   12.898111] microcode: CPU7: patch_level=0x06000852
[   12.899812] microcode: Microcode Update Driver: v2.2.
[   12.899824] sched_clock: Marking stable (11873034026, 1026772617)->(13703888767, -804082124)
[   12.904938] registered taskstats version 1
[   12.906339] Loading compiled-in X.509 certificates
[   12.908448] Loaded X.509 cert 'home:tiwai OBS Project: 42bc70d8916edac45455e6044ade94894dd77a6a'
[   12.911467] zswap: loaded using pool lzo/zbud
[   12.917036] Key type big_key registered
[   12.920562] Key type encrypted registered
[   12.922010] AppArmor: AppArmor sha1 policy hashing enabled
[   12.923907] ima: No TPM chip found, activating TPM-bypass!
[   12.925706] ima: Allocated hash algorithm: sha256
[   12.927355] evm: Initialising EVM extended attributes:
[   12.929191] evm: security.selinux
[   12.930322] evm: security.apparmor
[   12.931536] evm: security.ima
[   12.932563] evm: security.capability
[   12.933775] evm: HMAC attrs: 0x1
[   12.935490]   Magic number: 2:288:879
[   12.937056] rtc_cmos 00:04: setting system clock to 2018-09-13 09:52:18 UTC (1536832338)
[   13.167961] ata1: SATA link down (SStatus 0 SControl 300)
[   13.640979] Freeing unused kernel image memory: 2028K
[   13.665189] Write protecting the kernel read-only data: 18432k
[   13.694954] Freeing unused kernel image memory: 2008K
[   13.719503] Freeing unused kernel image memory: 500K
[   13.743295] Run /init as init process
[   13.751359] tsc: Refined TSC clocksource calibration: 2792.998 MHz
[   13.763946] random: init: uninitialized urandom read (48 bytes read)
[   13.790691] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28426a4c5eb, max_idle_ns: 440795237780 ns
[   13.821613] random: init: uninitialized urandom read (48 bytes read)
[   13.899600] clocksource: Switched to clocksource tsc
[   13.899736] random: init: uninitialized urandom read (48 bytes read)
[   15.001996] urandom_read: 6 callbacks suppressed
[   15.001998] random: init: uninitialized urandom read (48 bytes read)
[   15.123710] loop: module loaded
[   15.367494] squashfs: version 4.0 (2009/01/31) Phillip Lougher

>>> SUSE Linux Enterprise 12 SP4 installation program v5.1.14.0 (c) 1996-2018 SUSE LLC <<<
Starting udev... [   15.957604] alua: device handler registered
[   15.980353] emc: device handler registered
[   16.005261] rdac: device handler registered
[   16.048085] udevd[247]: starting version 228
[   16.069642] udevd[248]: Network interface NamePolicy= disabled by default.
[   16.160108] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   16.198237] ACPI: Power Button [PWRF]
[   16.220988] acpi_cpufreq: overriding BIOS provided _PSD data
[   16.250375] ipmi message handler version 39.2
[   16.273167] pata_atiixp 0000:00:14.1: can't derive routing for PCI INT A
[   16.309019] scsi host1: pata_atiixp
[   16.325896] pps_core: LinuxPPS API ver. 1 registered
[   16.337455] scsi host2: pata_atiixp
[   16.364272] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   16.368073] ata2: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x500 irq 14
[   16.443976] cryptd: max_cpu_qlen set to 1000
[   16.444159] ata3: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x508 irq 15
[   16.520230] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   16.555935] ipmi device interface
[   16.572783] PTP clock support registered
[   16.592326] IPMI System Interface driver.
[   16.594857] HP HPSA Driver (v 3.4.20-125)
[   16.611483] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   16.630130] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   16.661025] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   16.696492] PCI Interrupt Link [I020] enabled at IRQ 24
[   16.724831] ipmi_si: Adding SMBIOS-specified kcs state machine
[   16.749869] hpsa 0000:03:00.0: Logical aborts not supported
[   16.777639] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   16.804352] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
[   16.832995] ACPI: bus type USB registered
[   16.863731] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   16.882831] usbcore: registered new interface driver usbfs
[   16.917161] scsi host3: hpsa
[   16.917172] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[   16.917176] ipmi_si: Adding ACPI-specified kcs state machine
[   16.917308] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   16.943617] usbcore: registered new interface driver hub
[   16.957297] hpsa can't handle SMP requests
[   16.998874] usbcore: registered new device driver usb
[   17.034978] hpsa 0000:03:00.0: scsi 3:0:0:0: added RAID              HP       P420i            controller SSDSmartPathCap- En- Exp=1
[   17.200435] hpsa 0000:03:00.0: scsi 3:0:1:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   17.219392] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[   17.257404] hpsa 0000:03:00.0: scsi 3:0:2:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   17.257410] hpsa 0000:03:00.0: scsi 3:0:3:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   17.257415] hpsa 0000:03:00.0: scsi 3:0:4:0: masked Enclosure         PMCSIERA SRCv8x6G         enclosure SSDSmartPathCap- En- Exp=0
[   17.257424] hpsa 0000:03:00.0: scsi 3:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   17.461321] ipmi_si IPI0001:00: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x13)
[   17.484300] hpsa 0000:03:00.0: scsi 3:1:0:1: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   17.484549] hpsa can't handle SMP requests
[   17.539728] AVX version of gcm_enc/dec engaged.
[   17.582107] scsi 3:0:0:0: RAID              HP       P420i            8.32 PQ: 0 ANSI: 5
[   17.636592] AES CTR mode by8 optimization enabled
[   17.745529] scsi 3:1:0:0: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   17.784255] scsi 3:1:0:1: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   17.791996] sd 3:1:0:0: [sda] 585871964 512-byte logical blocks: (300 GB/279 GiB)
[   17.823478] sd 3:1:0:1: [sdb] 1171743324 512-byte logical blocks: (600 GB/559 GiB)
[   17.859183] sd 3:1:0:0: [sda] Write Protect is off
[   17.895216] sd 3:1:0:1: [sdb] Write Protect is off
[   17.918133] sd 3:1:0:0: [sda] Mode Sense: 73 00 00 08
[   17.941013] sd 3:1:0:1: [sdb] Mode Sense: 73 00 00 08
[   17.965486] sd 3:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   17.989634] sd 3:1:0:1: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   18.064828]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   18.089120]  sdb: sdb1
[   18.113577] sd 3:1:0:1: [sdb] Attached SCSI disk
[   18.114498] sd 3:1:0:0: [sda] Attached SCSI disk
[   18.158210] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   18.158606] tg3.c:v3.137 (May 11, 2014)
[   18.209030] PCI Interrupt Link [I0C0] enabled at IRQ 36
[   18.240692] ehci-pci: EHCI PCI platform driver
[   18.263214] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   18.275741] ehci-pci 0000:00:12.2: EHCI Host Controller
[   18.317627] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[   18.352321] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   18.363383] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   18.393077] ehci-pci 0000:00:12.2: debug port 1
[   18.442877] ehci-pci 0000:00:12.2: irq 23, io mem 0xfccc0000
[   18.471284] IPMI SSIF Interface driver
[   18.478039] tg3 0000:04:00.0 eth0: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:90
[   18.540630] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   18.568578] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   18.608429] tg3 0000:04:00.0 eth0: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   18.655258] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.655328] uhci_hcd: USB Universal Host Controller Interface driver
[   18.689596] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   18.757730] usb usb1: Product: EHCI Host Controller
[   18.781014] usb usb1: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default ehci_hcd
[   18.816929] usb usb1: SerialNumber: 0000:00:12.2
[   18.839196] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   18.871678] hub 1-0:1.0: USB hub found
[   18.890092] hub 1-0:1.0: 6 ports detected
[   18.909884] uhci_hcd 0000:02:00.4: UHCI Host Controller
[   18.935023] uhci_hcd 0000:02:00.4: new USB bus registered, assigned bus number 2
[   18.970658] uhci_hcd 0000:02:00.4: detected 8 ports
[   18.994172] uhci_hcd 0000:02:00.4: port count misdetected? forcing to 2 ports
[   19.028435] uhci_hcd 0000:02:00.4: irq 37, io base 0x00003c00
[   19.055832] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   19.096525] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.131696] usb usb2: Product: UHCI Host Controller
[   19.155388] usb usb2: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default uhci_hcd
[   19.191135] usb usb2: SerialNumber: 0000:02:00.4
[   19.213549] PCI Interrupt Link [I0C1] enabled at IRQ 37
[   19.239181] hub 2-0:1.0: USB hub found
[   19.257567] hub 2-0:1.0: 2 ports detected
[   19.277538] ehci-pci 0000:00:13.2: EHCI Host Controller
[   19.309030] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
[   19.345153] [TTM] Zone  kernel: Available graphics memory: 16443898 kiB
[   19.376937] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   19.418545] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   19.450000] ehci-pci 0000:00:13.2: debug port 1
[   19.471789] [TTM] Initializing pool allocator
[   19.493037] ehci-pci 0000:00:13.2: irq 22, io mem 0xfcc90000
[   19.520382] [TTM] Initializing DMA pool allocator
[   19.555160] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   19.584482] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   19.639158] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.691676] usb usb3: Product: EHCI Host Controller
[   19.715070] fbcon: mgadrmfb (fb0) is primary device
[   19.727161] usb usb3: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default ehci_hcd
[   19.727163] usb usb3: SerialNumber: 0000:00:13.2
[   19.743226] hub 3-0:1.0: USB hub found
[   19.743234] hub 3-0:1.0: 6 ports detected
[   19.748423] ohci-pci: OHCI PCI platform driver
[   19.821818] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   19.821826] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[   19.821859] ohci-pci 0000:00:12.0: irq 22, io mem 0xfcce0000
[   19.839455] tg3 0000:04:00.1 eth1: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:91
[   19.839461] tg3 0000:04:00.1 eth1: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   19.839465] tg3 0000:04:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   19.839468] tg3 0000:04:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[   19.861640] tg3 0000:04:00.2 eth2: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:92
[   19.861644] tg3 0000:04:00.2 eth2: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   19.861647] tg3 0000:04:00.2 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   19.861650] tg3 0000:04:00.2 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   19.883256] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   19.883259] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.883262] usb usb4: Product: OHCI PCI host controller
[   19.883264] usb usb4: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default ohci_hcd
[   19.883266] usb usb4: SerialNumber: 0000:00:12.0
[   19.883648] hub 4-0:1.0: USB hub found
[   19.883663] hub 4-0:1.0: 3 ports detected
[   19.924129] Console: switching to colour frame buffer device 160x64
[   20.784720] mgag200 0000:02:00.1: fb0: mgadrmfb frame buffer device
[   20.785194] ohci-pci 0000:00:12.1: OHCI PCI host controller
[   20.840610] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 5
[   20.840643] ohci-pci 0000:00:12.1: irq 22, io mem 0xfccd0000
[   20.847378] [drm] Initialized mgag200 1.0.0 20110418 for 0000:02:00.1 on minor 0
[   20.940714] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   20.980922] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.015748] usb 1-2: new high-speed USB device number 2 using ehci-pci
[   21.047171] usb usb5: Product: OHCI PCI host controller
[   21.072192] usb usb5: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default ohci_hcd
[   21.107400] usb usb5: SerialNumber: 0000:00:12.1
[   21.130070] hub 5-0:1.0: USB hub found
[   21.147561] hub 5-0:1.0: 3 ports detected
[   21.166892] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   21.193514] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 6
[   21.228972] ohci-pci 0000:00:13.0: irq 23, io mem 0xfccb0000
[   21.262073] tg3 0000:04:00.3 eth3: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:93
[   21.313497] tg3 0000:04:00.3 eth3: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   21.364286] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   21.403152] tg3 0000:04:00.3 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   21.440029] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.475048] tg3 0000:04:00.3 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[   21.507352] usb 1-2: New USB device found, idVendor=0424, idProduct=2660, bcdDevice= 8.01
[   21.546598] usb usb6: Product: OHCI PCI host controller
[   21.571785] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   21.605592] usb usb6: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default ohci_hcd
[   21.640700] usb usb6: SerialNumber: 0000:00:13.0
[   21.662588] hub 1-2:1.0: USB hub found
[   21.680127] hub 6-0:1.0: USB hub found
[   21.698375] hub 6-0:1.0: 3 ports detected
[   21.717585] hub 1-2:1.0: 2 ports detected
[   21.718252] random: fast init done
[   21.736724] ohci-pci 0000:00:13.1: OHCI PCI host controller
[   21.778893] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 7
[   21.814057] ohci-pci 0000:00:13.1: irq 23, io mem 0xfcca0000
[   21.903399] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   21.942974] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.977628] usb usb7: Product: OHCI PCI host controller
[   22.002852] usb usb7: Manufacturer: Linux 4.19.0-rc3-1.ga673072-default ohci_hcd
[   22.038123] usb usb7: SerialNumber: 0000:00:13.1
[   22.060620] hub 7-0:1.0: USB hub found
[   22.078693] hub 7-0:1.0: 3 ports detected
[   22.487298] usb 7-3: new low-speed USB device number 2 using ohci-pci
[   22.713614] usb 7-3: New USB device found, idVendor=0d3d, idProduct=0040, bcdDevice= 0.01
[   22.752026] usb 7-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   22.785680] usb 7-3: Product: USB CAT5
[   22.805385] udevd[248]: Network interface NamePolicy= disabled by default.
[   22.864809] usbcore: registered new interface driver usbhid
[   22.891904] usbhid: USB HID core driver
[   22.914035] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.0/0003:0D3D:0040.0001/input/input4
[   23.023948] hid-generic 0003:0D3D:0040.0001: input,hidraw0: USB HID v1.00 Keyboard [USB CAT5] on usb-0000:00:13.1-3/input0
[   23.077798] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.1/0003:0D3D:0040.0002/input/input5
[   23.127898] hid-generic 0003:0D3D:0040.0002: input,hidraw1: USB HID v1.00 Mouse [USB CAT5] on usb-0000:00:13.1-3/input1
ok
[   25.076954] RPC: Registered named UNIX socket transport module.
[   25.105515] RPC: Registered udp transport module.
[   25.128273] RPC: Registered tcp transport module.
[   25.150880] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   25.172875] random: crng init done
[   25.715889] No iBFT detected.
Loading basic drivers...[   26.675185] udevd[248]: Network interface NamePolicy= disabled by default.
[   26.729902] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   26.799694] scsi 3:0:0:0: Attached scsi generic sg0 type 12
[   26.826638] sd 3:1:0:0: Attached scsi generic sg1 type 0
[   26.851635] sd 3:1:0:1: Attached scsi generic sg2 type 0
[   27.318760] NET: Registered protocol family 17
[   30.703844] FS-Cache: Loaded
[   34.141791] FS-Cache: Netfs 'nfs' registered for caching
[   44.265322] 8021q: 802.1Q VLAN Support v1.8
 ok
Starting hardware detection... ok
(If a driver is not working for you, try booting with brokenmodules=driver_name.)

Hewlett-Packard Company P420i
  drivers: hpsa*
ATI SB7x0/SB8x0/SB9x0 IDE Controller
  drivers: pata_atiixp*, pata_acpi, ata_generic
Activating usb devices... ok
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Hewlett-Packard Company Ethernet 1Gb 4-port 331FLR Adapter
  drivers: tg3*
Driver Update: kernel update for bsc1106743
eth3: network config created
Sending DHCP request to eth3...
[   64.256542] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   67.817473] tg3 0000:04:00.3 eth3: Link is up at 1000 Mbps, full duplex
[   67.849167] tg3 0000:04:00.3 eth3: Flow control is on for TX and on for RX
[   67.882513] tg3 0000:04:00.3 eth3: EEE is disabled
[   67.905733] IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
no/incomplete answer.
eth1: network config created
Sending DHCP request to eth1...
[  102.127770] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
no/incomplete answer.
eth2: network config created
Sending DHCP request to eth2...
[  134.579557] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
no/incomplete answer.
eth0: network config created
Sending DHCP request to eth0...
[  167.034918] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[  170.607314] tg3 0000:04:00.0 eth0: Link is up at 1000 Mbps, full duplex
[  170.639423] tg3 0000:04:00.0 eth0: Flow control is off for TX and off for RX
[  170.673199] tg3 0000:04:00.0 eth0: EEE is enabled
[  170.695696] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ok, ip = 10.67.130.39/21
Loading Installation System (1/6) -      100%
Loading Installation System (2/6) -      100%
Loading Installation System (3/6) -      100%
Loading Installation System (4/6) -      100%
Loading Installation System (5/6) -      100%
Loading Installation System (6/6) - missing (optional)
starting rsyslogd (logging to /dev/tty4)... ok
starting klogd... ok
starting nscd... ok
setting temporary root password to 'susetesting'
Checking for missing server keys in /etc/ssh
ssh-keygen: generating new host keys: RSA1 RSA DSA ECDSA ED25519
Starting SSH daemon... ok
IP addresses:
  10.67.130.39

***  login using 'ssh -X root@ph039.qa2.suse.asia'  ***
***  run 'yast.ssh' to start the installation  ***

Active interfaces:
eth0: 28:80:23:ae:1a:90
  10.67.130.39/21
  fe80::2a80:23ff:feae:1a90/64
[  218.070702] udevd[248]: Network interface NamePolicy= disabled by default.
[  262.329850] ppdev: user-space parallel port driver
[  267.747930] device-mapper: uevent: version 1.0.3
[  267.770560] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[  269.131356] raid6: sse2x1   gen()  4284 MB/s
[  269.219335] raid6: sse2x1   xor()  3595 MB/s
[  269.307574] raid6: sse2x2   gen()  3572 MB/s
[  269.395369] raid6: sse2x2   xor()  3274 MB/s
[  269.483365] raid6: sse2x4   gen()  4801 MB/s
[  269.571179] raid6: sse2x4   xor()  3646 MB/s
[  269.591671] raid6: using algorithm sse2x4 gen() 4801 MB/s
[  269.617736] raid6: .... xor() 3646 MB/s, rmw enabled
[  269.641828] raid6: using ssse3x2 recovery algorithm
[  269.665996] xor: automatically using best checksumming function   avx
[  269.745489] Btrfs loaded, crc32c=crc32c-intel, assert=on
[  269.789231] BTRFS: device label SLE-12-SP3-GM_MU devid 1 transid 56482 /dev/sda2
[  269.825492] BTRFS info (device sda2): disk space caching is enabled
[  269.856079] BTRFS info (device sda2): has skinny extents
[  270.877000] BTRFS: device fsid a279a180-354e-4250-88aa-69f0bad6d187 devid 1 transid 34 /dev/sda5
[  270.920018] BTRFS info (device sda5): disk space caching is enabled
[  270.950054] BTRFS info (device sda5): has skinny extents
[  271.155353] BTRFS info (device sda5): checking UUID tree
[  271.547775] BTRFS: device label SLE-12-SP4-Beta3 devid 1 transid 17391 /dev/sda3
[  271.584675] BTRFS info (device sda3): disk space caching is enabled
[  271.614699] BTRFS info (device sda3): has skinny extents
[  271.747269] BTRFS info (device sda3): checking UUID tree
umount: /var/lib/nfs/rpc_pipefs: target is busy
        (In some cases useful info about processes that
         use the device is found by lsof(8) or fuser(1).)
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐│
││                                 >>> linuxrc 5.1.14.0 (Kernel 4.19.0-rc3-1.ga673072-default) <<<                                  [  290.788913] udevd[248]: Network interface NamePolicy= disabled by default.───────────────────────────────────────────────────────────┘│
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐│
││                                 >>> linuxrc 5.1.14.0 (Kernel 4.19.0-rc3-1.ga673072-default) <<<                                   ││
│└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
│                                                                                                                                     │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘































^M^M[  393.798530] systemd[1]: Failed to set up the root directory for shared mount propagation: Invalid argument
[  393.850685] systemd[1]: systemd 228 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[  393.956197] systemd[1]: Detected architecture x86-64.

Welcome to SUSE Linux Enterprise 12 SP4!

[  393.991574] systemd[1]: Set hostname to <rescue>.
[  394.212400] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[  394.255400] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[  394.288068] systemd[1]: Created slice System Slice.
[  OK  ] Created slice System Slice.
[  394.323621] systemd[1]: -.mount: Directory / to mount over is not empty, mounting anyway.
[  394.364133] systemd[1]: Mounting /...
         Mounting /...
[  394.391831] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  394.431648] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[  OK  ] Listening on Journal Audit Socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Mounted /.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Reached target Paths.
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on Journal Socket.
         Mounting Huge Pages File System...
         Starting Rule generator for /dev/root symlink...
         Starting Load Kernel Modules...
         Starting Setup Virtual Console...
         Starting Create list of required st... nodes for the current kernel...
         Starting Remount Root and Kernel File Systems...
         Mounting Debug File System...
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on Journal Socket (/dev/log).
         Mounting POSIX Message Queue File System...
[  OK  ] Listening on Syslog Socket.
         Starting Journal Service...
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Started Rule generator for /dev/root symlink.
[  OK  ] Started Load Kernel Modules.
[  OK  ] Started Setup Virtual Console.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Load/Save Random Seed...
         Starting Rebuild Hardware Database...
         Starting Create System Users...
         Starting Apply Kernel Variables...
[  OK  ] Started Journal Service.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Create System Users.
         Starting Create Static Device Nodes in /dev...
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
         Mounting Runtime Directory...
         Starting udev Kernel Device Manager...
[  OK  ] Mounted Runtime Directory.
[  OK  ] Reached target Local File Systems.
         Starting Rebuild Journal Catalog...
         Starting Restore /run/initramfs on shutdown...
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Restore /run/initramfs on shutdown.
[  395.112029] systemd-journald[21197]: Received request to flush runtime journal from PID 1
[  OK  ] Started Rebuild Journal Catalog.
[  OK  ] Started Flush Journal to Persistent Storage.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Rebuild Hardware Database.
         Starting Update is Completed...
         Starting udev Coldplug all Devices...
[  OK  ] Started Update is Completed.
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
[  OK  ] Started D-Bus System Message Bus.
[  395.475942] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[  395.504491] PCI Interrupt Link [I060] enabled at IRQ 47
[  395.539340] input: PC Speaker as /devices/platform/pcspkr/input/input6
[  395.543238] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: NMI decoding initialized
[  395.615070] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: 2.0.0, timer margin: 30 seconds (nowayout=0).
         Starting wicked DHCPv6 supplicant service...
         Starting /etc/init.d/boot.local Compatibility...
         Starting wicked AutoIPv4 supplicant service...
         Starting Login Service...
[  395.724846] kvm: Nested Virtualization enabled
[  395.746320] kvm: Nested Paging enabled
[  395.766441] MCE: In-kernel MCE decoding enabled.
[  395.768232] EDAC amd64: Node 0: DRAM ECC enabled.
[  395.768235] EDAC amd64: F15h detected (node 0).
[  395.768279] EDAC MC: DCT0 chip selects:
[  395.768282] EDAC amd64: MC: 0:     0MB 1:     0MB
[  395.768285] EDAC amd64: MC: 2:     0MB 3:     0MB
[  395.768288] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[  395.768292] EDAC amd64: MC: 6:     0MB 7:     0MB
[  395.768294] EDAC MC: DCT1 chip selects:
[  395.768296] EDAC amd64: MC: 0:     0MB 1:     0MB
[  395.768299] EDAC amd64: MC: 2:     0MB 3:     0MB
[  395.768303] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[  395.768306] EDAC amd64: MC: 6:     0MB 7:     0MB
[  395.768307] EDAC amd64: using x8 syndromes.
[  395.768308] EDAC amd64: MCT channel count: 2
[  395.768630] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
[  395.768637] EDAC amd64: Node 1: DRAM ECC disabled.
[  395.768639] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[  395.768639]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[  395.768639]  (Note that use of the override may cause unknown side effects.)
[  395.768662] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[  395.768663] AMD64 EDAC driver v3.5.0
         Starting Permit User Sessions...
         Starting System Logging Service...
         Starting wicked DHCPv4 supplicant service...
         Starting LSB: Keyboard settings (don't disable!)...
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timers.
[  OK  ] Started /etc/init.d/boot.local Compatibility.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started LSB: Keyboard settings (don't disable!).
[  OK  ] Found device /dev/ttyS0.
[  OK  ] Started wicked DHCPv6 supplicant service.
[  OK  ] Started wicked AutoIPv4 supplicant service.
[  OK  ] Started wicked DHCPv4 supplicant service.
[  OK  ] Started Login Service.
         Starting wicked network management service daemon...
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started /etc/init.d/after.local Compatibility.
[  OK  ] Started wicked network management service daemon.
         Starting wicked network nanny service...
[  OK  ] Started wicked network nanny service.
         Starting wicked managed network interfaces...
[  OK  ] Started System Logging Service.


SUSE Linux Enterprise 12 SP4 Rescue System

ph039 login: root
Password:
ttyS0:ph039:~ # reboot
         Stopping Restore /run/initramfs on shutdown...
[  OK  ] Stopped target Timers.
         Stopping Session 2 of user root.
[topping OpenSSH Daemon...
[  OK  ] Stopped /etc/init.d/after.local Compatibility.
[  OK  ] Stopped target Login Prompts.
         Stopping Getty on tty1...
         Stopping Serial Getty on ttyS0...
         Stopping LSB: Keyboard settings (don't disable!)...
         Stopping System Logging Service...
[  OK  ] Stopped System Logging Service.
[  OK  ] Stopped Getty on tty1.
[  OK  ] Stopped Serial Getty on ttyS0.
[  OK  ] Stopped User Manager for UID 0.
[  OK  ] Stopped OpenSSH Daemon.
[  OK  ] Stopped Restore /run/initramfs on shutdown.
[  OK  ] Stopped Session 2 of user root.
[  OK  ] Stopped LSB: Keyboard settings (don't disable!).
[  OK  ] Stopped target Network.
         Stopping wicked managed network interfaces...
[  OK  ] Removed slice User Slice of root.
         Stopping Login Service...
[  OK  ] Removed slice system-serial\x2dgetty.slice.
[  OK  ] Removed slice system-getty.slice.
         Stopping Permit User Sessions...
[  OK  ] Stopped /etc/init.d/boot.local Compatibility.
[  OK  ] Stopped Login Service.
[  OK  ] Stopped Permit User Sessions.
[  OK  ] Stopped wicked managed network interfaces.
         Stopping wicked network nanny service...
[  OK  ] Stopped wicked network nanny service.
         Stopping wicked network management service daemon...
[  OK  ] Stopped wicked network management service daemon.
         Stopping wicked DHCPv4 supplicant service...
         Stopping wicked AutoIPv4 supplicant service...
         Stopping wicked DHCPv6 supplicant service...
[  OK  ] Stopped wicked DHCPv6 supplicant service.
[  OK  ] Stopped wicked AutoIPv4 supplicant service.
[  OK  ] Stopped wicked DHCPv4 supplicant service.
         Stopping D-Bus System Message Bus...
[  OK  ] Stopped D-Bus System Message Bus.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Sockets.
[  OK  ] Closed Syslog Socket.
[  OK  ] Stopped target Slices.
[  OK  ] Removed slice User and Session Slice.
[  OK  ] Stopped target Paths.
[  OK  ] Closed D-Bus System Message Bus Socket.
[  OK  ] Stopped target System Initialization.
         Stopping Load/Save Random Seed...
         Stopping Update UTMP about System Boot/Shutdown...
[  OK  ] Stopped target Encrypted Volumes.
[  OK  ] Stopped Dispatch Password Requests to Console Directory Watch.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped Update is Completed.
[  OK  ] Stopped Rebuild Hardware Database.
[  OK  ] Stopped Rebuild Journal Catalog.
[  OK  ] Stopped Setup Virtual Console.
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped Load Kernel Modules.
[  OK  ] Stopped Load/Save Random Seed.
[  OK  ] Stopped Update UTMP about System Boot/Shutdown.
[  OK  ] Stopped Create Volatile Files and Directories.
[  OK  ] Stopped target Local File Systems.
         Unmounting /parts/mp_0000...
         Unmounting /run/user/0...
         Unmounting /mounts/mp_0006...
         Unmounting /mounts/mp_0008...
         Unmounting Runtime Directory...
         Unmounting /parts/mp_0001...
         Unmounting /mounts/mp_0007...
         Unmounting /parts/mp_0002...
[  OK  ] Unmounted /parts/mp_0000.
[  OK  ] Unmounted /run/user/0.
[FAILED] Failed unmounting /mounts/mp_0006.
[  OK  ] Unmounted /mounts/mp_0008.
[  OK  ] Unmounted Runtime Directory.
[  OK  ] Unmounted /parts/mp_0001.
[FAILED] Failed unmounting /mounts/mp_0007.
[  OK  ] Unmounted /parts/mp_0002.
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Stopped target Local File Systems (Pre).
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create System Users.
[  OK  ] Stopped Remount Root and Kernel File Systems.
[  OK  ] Reached target Shutdown.
[  414.925142] watchdog: watchdog0: watchdog did not stop!
[  414.959226] systemd-shutdow: 35 output lines suppressed due to ratelimiting
[  414.993847] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[  415.032464] systemd-journald[21197]: Received SIGTERM from PID 1 (systemd-shutdow).
[  415.071217] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[  415.109852] systemd-shutdown[1]: Hardware watchdog 'HPE iLO2+ HW Watchdog Timer', version 0
[  415.150377] systemd-shutdown[1]: Unmounting file systems.
[  415.176657] systemd-shutdown[1]: Remounting '/mounts/mp_0007' read-only with options ''.
[  415.217141] systemd-shutdown[1]: Unmounting /mounts/mp_0007.
[  415.244325] systemd-shutdown[1]: Remounting '/mounts/mp_0006' read-only with options ''.
[  415.284896] systemd-shutdown[1]: Unmounting /mounts/mp_0006.
[  415.312388] systemd-shutdown[1]: Remounting '/mounts/mp_0007' read-only with options ''.
[  415.351749] systemd-shutdown[1]: Unmounting /mounts/mp_0007.
[  415.449864] kvm: exiting hardware virtualization
[  415.494699] usb 7-3: USB disconnect, device number 2
[  415.519875] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.574090] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.628505] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.682800] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.736792] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.791393] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.845883] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.879332] usb 4-2: new full-speed USB device number 2 using ohci-pci
[  415.900476] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.900481] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  415.900487] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.094874] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.146117] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.196914] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.247931] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.298888] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.350192] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.401091] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.452581] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.503451] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.554687] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[  416.751328] reboot: Restarting system
[  416.768987] reboot: machine restart


--------------F5519E624D0AD1E3F7DDA019--
