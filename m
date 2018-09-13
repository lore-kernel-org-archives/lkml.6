Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD2C46469
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28A20869
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC28A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeIMUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:32:54 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:46125 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIMUcx (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 13 Sep 2018 16:32:53 -0400
Received: from linux-9avr.suse (prg-ext-pat.suse.com [213.151.95.130])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 13 Sep 2018 17:21:29 +0200
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, bpetkov@suse.de, linux-kernel@vger.kernel.org
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
 <CAFgQCTtA0zFti3-X6r2E+60mWTWxzKoRehzE18Lg0M5D-MeM9w@mail.gmail.com>
 <14f8bb1c-ef13-1329-b144-d487949615e5@suse.com>
 <19d8cdd3-7f22-4066-e77f-8d17bf50bee7@intel.com>
From:   James Wang <jnwang@suse.com>
Openpgp: preference=signencrypt
Organization: QA-SLE
Message-ID: <90446c6c-e6ef-e55d-07f7-01f661fa2cd6@suse.com>
Date:   Thu, 13 Sep 2018 17:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19d8cdd3-7f22-4066-e77f-8d17bf50bee7@intel.com>
Content-Type: multipart/mixed;
 boundary="------------CB3DD83CD84F3B426A9A2787"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CB3DD83CD84F3B426A9A2787
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 09/12/2018 11:56 AM, Rafael J. Wysocki wrote:
> On 9/12/2018 11:10 AM, James Wang wrote:
>>
>> On 09/12/2018 02:41 PM, Pingfan Liu wrote:
>>> Cc James, could you try to enable initcall_debug, and paste the
>>> shutdown seq with 722e5f2b1eec ("driver core: Partially revert "driver
>>> core: correct device's shutdown order"") and without it?
>> OK. And I will scheudule some testing orders, ahah, I'm in a business
>> trip.
>> All operations will be a little bit delay, but I will make it done.
>>
>> James
>>
> Can you please open a Bugzilla entry at bugzilla.kernel.org for the
> tracking of this issue and attach the results to that one for future
> reference?
>
Hi sir,
File a bug is no problem. but which product category should be used.

I attach logs here, first. and then file a bug.
>
>
>

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)


--------------CB3DD83CD84F3B426A9A2787
Content-Type: text/x-log;
 name="initcall_debug_with_driver_core.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="initcall_debug_with_driver_core.log"

  Booting `SLES 12-SP4'

Loading Linux 4.19.0-rc3-1.gd3995d7-default ...
Loading initial ramdisk ...
[    0.000000] Linux version 4.19.0-rc3-1.gd3995d7-default (geeko@buildhost) (gcc version 8.2.1 20180817 [gcc-8-branch revision 263612] (SUSE Linux)) #1 SMP PREEMPT Mon Sep 10 05:38:58 UTC 2018 (d3995d7)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-rc3-1.gd3995d7-default root=UUID=b314d001-d850-402f-8bce-77806d9f4aea sysrq_always_enabled panic=100 ignore_loglevel unknown_nmi_panic console=ttyS0,115200n8 resume=/dev/disk/by-uuid/bbe275bf-803c-44e6-90d7-1695025b0532 splash=silent quiet showopts crashkernel=116M,high crashkernel=72M,low nopti nospec nospectre_v2 nospec_store_bypass_disable initcall_debug
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
[    0.0000] DMI: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.206 MHz processor
[    0.002737] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002741] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011326] AGP: No AGP bridge found
[    0.011402] last_pfn = 0x83efff max_arch_pfn = 0x400000000
[    0.011407] MTRR default type: uncachable
[    0.011409] MTRR fixed ranges enabled:
[    0.011411]   00000-9FFFF write-back
[    0.011412]   A0000-BFFFF uncachable
[    0.011414]   C0000-FFFFF write-back
[    0.011415] MTRR variable ranges enabled:
[    0.011417]   0 base 000000000000 mask FFFF80000000 write-back
[    0.011420]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.011421]   2 disabled
[    0.011422]   3 disabled
[    0.011423]   4 disabled
[    0.011424]   5 disabled
[    0.011425]   6 disabled
[    0.011426]   7 disabled
[    0.011428] TOM2: 000000083f000000 aka 33776M
[    0.012414] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.012705] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.012715] last_pfn = 0xbddde max_arch_pfn = 0x400000000
[    0.015242] found SMP MP-table at [mem 0x000f4f60-0x000f4f6f] mapped at [(____ptrval____)]
[    0.015361] Scanning 1 areas for low memory corruption
[    0.015364] Base memory trampoline at [(____ptrval____)] 99000 size 24576
[    0.015369] Using GB pages for direct mapping
[    0.015373] BRK [0x39a6a000, 0x39a6afff] PGTABLE
[    0.015375] BRK [0x39a6b000, 0x39a6bfff] PGTABLE
[    0.015377] BRK [0x39a6c000, 0x39a6cfff] PGTABLE
[    0.015417] BRK [0x39a6d000, 0x39a6dfff] PGTABLE
[    0.015420] BRK [0x39a6e000, 0x39a6efff] PGTABLE
[    0.015683] BRK [0x39a6f000, 0x39a6ffff] PGTABLE
[    0.015711] RAMDISK: [mem 0x35ec1000-0x36f57fff]
[    0.015719] ACPI: Early table checksum verification disabled
[    0.015777] ACPI: RSDP 0x00000000000F4EE0 000024 (v02 HP    )
[    0.015781] ACPI: XSDT 00000000BDDE1880 0000B4 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015790] ACPI: FACP 0x00000000BDDE1980 0000F4 (v03 HP     ProLiant 00000002 �?   0000162E)
[    0.015797] ACPI: DSDT 0x00000000BDDE1A80 00D2F7 (v01 HP     DSDT     00000001 INTL 20061109)
[    0.015802] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015806] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015810] ACPI: SPCR 0x00000000BDDDE180 000050 (v01 HP     SPCRRBSU 00000001 �?   0000162E)
[    0.015814] ACPI: MCFG 0x00000000BDDDE200 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.015818] ACPI: HPET 0x00000000BDDDE240 000038 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015823] ACPI: SPMI 0x00000000BDDDE280 000040 (v05 HP     ProLiant 00000001 �?   0000162E)
[    0.015827] ACPI: ERST 0x00000000BDDDE2C0 000230 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015831] ACPI: APIC 0x00000000BDDDE500 00009E (v01 HP     ProLiant 00000002      00000000)
[    0.015835] ACPI: SRAT 0x00000000BDDDE800 000128 (v02 AMD    AGESA    00000001 AMD  00000001)
[    0.015839] ACPI: FFFF 0x00000000BDDDF000 000176 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015843] ACPI: BERT 0x00000000BDDDF180 000030 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015847] ACPI: HEST 0x00000000BDDDF1C0 00018C (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015851] ACPI: FFFF 0x00000000BDDDF380 000064 (v02 HP     ProLiant 00000002 �?   0000162E)
[    0.015855] ACPI: SLIT 0x00000000BDDDF400 000030 (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.015859] ACPI: FFFF 0x00000000BDDE1800 00006E (v01 HP     Proliant 00000001 PH   0000504D)
[    0.015863] ACPI: IVRS 0x00000000BDDDF800 0001A0 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.015868] ACPI: SSDT 0x00000000BDDEED80 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
[    0.015872] ACPI: SSDT 0x00000000BDDEEEC0 000377 (v01 HP     pmab     00000001 INTL 20120503)
[    0.015876] ACPI: SSDT 0x00000000BDDEF240 001714 (v02 AMD    POWERNOW 00000001 AMD  00000001)
[    0.0184] ACPI: Local APIC address 0xfee00000
[    0.015932] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.015934] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.015935] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.015937] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.015938] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.015939] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.015941] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.015942] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.015945] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.015947] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.015949] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83effffff]
[    0.015953] NUMA: Initialized distance table, cnt=2
[    0.015957] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.015959] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x83effefff] -> [mem 0x00000000-0x83effefff]
[    0.015966] NODE_DATA(0) allocated [mem 0x83efe8000-0x83effdfff]
[    0.016003] Reserving 72MB of low memory at 2960MB for crashkernel (System low RAM: 3037MB)
[    0.016006] Reserving 116MB of memory at 33648MB for crashkernel (System RAM: 32717MB)
[    0.016050] Zone ranges:
[    0.016051]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.016053]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.016055]   Normal   [mem 0x0000000100000000-0x000000083effefff]
[    0.016057]   Device   empty
[    0.016059] Movable zone start for each node
[    0.016062] Early memory node ranges
[    0.016063]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.016065]   node   0: [mem 0x0000000000100000-0x00000000bddddfff]
[    0.016066]   node   0: [mem 0x0000000100000000-0x000000083effefff]
[    0.016244] Reserved but unavailable: 8836 pages
[    0.016246] Initmem setup node 0 [mem 0x0000000000001000-0x000000083effefff]
[    0.016248] On node 0 totalpages: 8375675
[    0.016250]   DMA zone: 64 pages used for memmap
[    0.016251]   DMA zon 21 pages reserved
[    0.016253]   DMA zone: 3998 pages, LIFO batch:0
[    0.016359]   DMA32 zone: 12088 pages used for memmap
[    0.016360]   DMA32 zone: 773598 pages, LIFO batch:63
[    0.037164]   Normal zone: 118720 pages used for memmap
[    0.037168]   Normal zone: 7598079 pages, LIFO batch:63
[    0.038270] ACPI: PM-Timer IO Port: 0x920
[    0.038274] ACPI: Local APIC address 0xfee00000
[    0.038283] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.038296] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
[    0.038300] IOAPIC[1]: apic_id 9, version 33, address 0xfaffc000, GSI 24-55
[    0.038302] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.038305] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.038307] ACPI: IRQ0 used by override.
[    0.038309] ACPI: IRQ9 used by override.
[    0.038311] Using ACPI (MADT) for SMP configuration information
[    0.038313] ACPI: HPET id: 0x1166a201 base: 0xfed00000
[    0.038317] ACPI: SPCR: SPCR table version 1
[    0.038318] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.038320] ACPI: SPCR: console: uart,mmio,0x0,115200
[    0.038323] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.038326] NODE_DATA(1) allocated [mem 0x83efc7000-0x83efdcfff]
[    0.038328]     NODE_DATA(1) on node 0
[    0.038348] Initmem setup node 1 [mem 0x0000000000000000-0x0000000000000000]
[    0.038350] On node 1 totalpages: 0
[    0.038363] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.038366] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.038367] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.038368] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.038370] PM: Registered nosave memory: [mem 0xbddde000-0xbde0dfff]
[    0.038372] PM: Registered nosave memory: [mem 0xbde0e000-0xcfffffff]
[    0.038373] PM: Registered nosave memory: [mem 0xd0000000-0xfebfffff]
[    0.038374] PM: Registered nosave memory: [mem fec00000-0xfee0ffff]
[    0.038375] PM: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.038377] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.038379] [mem 0xd0000000-0xfebfffff] available for PCI devices
[    0.038381] Booting paravirtualized kernel on bare hardware
[    0.038384] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.183696] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:2
[    0.184805] percpu: Embedded 47 pages/cpu @(____ptrval____) s155648 r8192 d28672 u524288
[    0.184813] pcpu-alloc: s155648 r8192 d28672 u524288 alloc=1*2097152
[    0.184815] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7
[    0.184841] Built 2 zonelists, mobility grouping on.  Total pages: 8244782
[    0.184843] Policy zone: Normal
[    0.184846] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-rc3-1.gd3995d7-default root=UUID=b314d001-d850-402f-8bce-77806d9f4aea sysrq_always_enabled panic=100 ignore_loglevel unknown_nmi_panic console=ttyS0,115200n8 resume=/dev/disk/by-uuid/bbe275bf-803c-44e6-90d7-1695025b0532 splash=silent quiet showopts crashkernel=116M,high crashkernel=72M,low nopti nospec nospectre_v2 nospec_store_bypass_disable initcall_debug
[    0.184894] sysrq: sysrq always enabled.
[    0.185065] log_buf_len individual max cpu contribution: 32768 bytes
[    0.185067] log_buf_len total cpu_extra contributions: 229376 bytes
[    0.185068] log_buf_len min size: 262144 bytes
[    0.185243] log_buf_len: 524288 bytes
[    0.185244] early log buf free: 250300(95%)
[    0.200126] AGP: Checking aperture...
[    0.208708] AGP: No AGP bridge found
[    0.208712] AGP: Node 0: aperture [bus addr 0xb0000000-0xb1ffffff] (32MB)
[    0.208713] Aperture pointing to e820 RAM. Ignoring.
[    0.208715] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.208716] AGP: Please enable the IOMMU option in the BIOS setup
[    0.208717] AGP: This costs you 64MB of RAM
[    0.208720] AGP: Mapping aperturover RAM [mem 0xb0000000-0xb3ffffff] (65536KB)
[    0.208723] PM: Registered nosave memory: [mem 0xb0000000-0xb3ffffff]
[    0.252584] Memory: 2992456K/33502700K available (12300K kernel code, 1504K rwdata, 3600K rodata, 2028K init, 1364K bss, 894720K reserved, 0K cma-reserved)
[    0.252722] ftrace: allocating 36136 entries in 142 pages
[    0.272459] rcu: Preemptible hierarchical RCU implementation.
[    0.272463] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.272465]  Tasks RCU enabled.
[    0.272466] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.276428] NR_IRQS: 33024, nr_irqs: 1032, preallocated irqs: 16
[    0.276733] spurious 8259A interrupt: IRQ7.
[    0.276938] calling  con_init+0x0/0x21c @ 0
[    0.281314] Console: colour VGA+ 80x25
[    0.281317] initcall con_init+0x0/0x21c returned 0 after 0 usecs
[    0.281320] calling  hvc_console_init+0x0/0x14 @ 0
[    0.281322] initcall hvc_console_init+0x0/0x14 returned 0 after 0 usecs
[    0.281326] calling  xen_cons_init+0x0/0x50 @ 0
[    0.281328] initcall xen_cons_init+0x0/0x50 returned 0 after 0 usecs
[    0.281330] calling  univ8250_console_init+0x0/0x27 @ 0
[    1.276742] console [ttyS0] enabled
[    1.277946] initcall univ8250_console_init+0x0/0x27 returned 0 after 0 usecs
[    1.280356] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.284018] ACPI: Core revision 20180810
[    1.285611] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    1.288859] hpet clockevent registered
[    1.290152] APIC: Switch to symmetric I/O mode setup
[    1.331410] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.352858] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28432e95979, max_idle_ns: 440795212526 ns
[    1.356463] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.41 BogoMIPS (lpj=11172824)
[    1.360456] pid_max: default: 32768 minimum: 301
[    1.364558] Security Framework initialized
[    1.365902] calling  selinux_init+0x0/0x1e3 @ 0
[    1.367503] initcall selinux_init+0x0/0x1e3 returned 0 after 0 usecs
[    1.368457] calling  tomoyo_init+0x0/0x5b @ 0
[    1.369992] initcall tomoyo_init+0x0/0x5b returned 0 after 0 usecs
[    1.372457] calling  apparmor_init+0x0/0x2e7 @ 0
[    1.374056] AppArmor: AppArmor initialized
[    1.376457] initcall apparmor_init+0x0/0x2e7 returned 0 after 3906 usecs
[    1.378693] calling  integrity_iintcache_init+0x0/0x2e @ 0
[    1.380464] initcall integrity_iintcache_init+0x0/0x2e returned 0 after 0 usecs
[    1.391810] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    1.398548] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    1.400623] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.403152] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.404736] mce: CPU supports 7 MCE banks
[    1.406108] LVT offset 1 assigned for vector 0xf9
[    1.408461] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    1.410467] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    1.412459] Speculative Store Bypass: Vulnerable
[    1.414199] Freeing SMP alternatives memory: 32K
[    1.420454] smpboot: CPU0: AMD Opteron(tm) Processor 6320 (family: 0x15, model: 0x2, stepping: 0x0)
[    1.444471] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
[    1.446437] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
[    1.448461] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
[    1.450274] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
[    1.452459] calling  init_hw_perf_events+0x0/0x5ad @ 1
[    1.454291] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    1.456456] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 430076)
[    1.460456] AMD PMU driver.
[    1.461339] ... version:                0
[    1.462705] ... bit width:              48
[    1.464456] ... generic registers:      6
[    1.465822] ... value mask:             0000ffffffffffff
[    1.467557] ... max period:             00007fffffffffff
[    1.468456] ... fixed-purpose events:   0
[    1.469821] ... event mask:             000000000000003f
[    1.472464] initcall init_hw_perf_events+0x0/0x5ad returned 0 after 19531 usecs
[    1.475000] calling  init_real_mode+0x0/0x1db @ 1
[    1.476469] initcall init_real_mode+0x0/0x1db returned 0 after 0 usecs
[    1.478591] calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
[    1.480457] initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
[    1.483108] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
[    1.484457] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
[    1.488457] calling  kvm_setup_vsyscall_timeinfo+0x0/0x3b @ 1
[    1.490357] initcall kvm_setup_vsyscall_timeinfo+0x0/0x3b returned 0 after 0 usecs
[    1.492457] calling  early_efi_map_fb+0x0/0x34 @ 1
[    1.494076] initcall early_efi_map_fb+0x0/0x34 returned 0 after 0 usecs
[    1.496457] calling  spawn_ksoftirqd+0x0/0x39 @ 1
[    1.504462] initcall spawn_ksoftirqd+0x0/0x39 returned 0 after 7812 usecs
[    1.506812] calling  migration_init+0x0/0x34 @ 1
[    1.508387] initcall migration_init+0x0/0x34 returned 0 after 0 usecs
[    1.508461] calling  check_cpu_stall_init+0x0/0x1b @ 1
[    1.510175] initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
[    1.512457] calling  srcu_bootup_announce+0x0/0x30 @ 1
[    1.514213] rcu: Hierarchical SRCU implementation.
[    1.516457] initcall srcu_bootup_announce+0x0/0x30 returned 0 after 3906 usecs
[    1.518808] calling  rcu_spawn_gp_kthread+0x0/0xfd @ 1
[    1.520517] initcall rcu_spawn_gp_kthread+0x0/0xfd returned 0 after 0 usecs
[    1.524460] calling  cpu_stop_init+0x0/0x86 @ 1
[    1.532467] initcall cpu_stop_init+0x0/0x86 returned 0 after 7812 usecs
[    1.534822] calling  init_events+0x0/0x40 @ 1
[    1.536321] initcall init_events+0x0/0x40 returned 0 after 0 usecs
[    1.536457] calling  init_trace_printk+0x0/0xc @ 1
[    1.538109] initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
[    1.540457] calling  event_trace_enable_again+0x0/0x21 @ 1
[    1.542320] initcall event_trace_enable_again+0x0/0x21 returned 0 after 0 usecs
[    1.544458] calling  jump_label_init_module+0x0/0x11 @ 1
[    1.546237] initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
[    1.548457] calling  dynamic_debug_init+0x0/0x25b @ 1
[    1.552729] initcall dynamic_debug_init+0x0/0x25b returned 0 after 3906 usecs
[    1.555599] calling  rand_initialize+0x0/0x60 @ 1
[    1.556485] initcall rand_initialize+0x0/0x60 returned 0 after 0 usecs
[    1.558684] calling  idle_inject_init+0x0/0x11 @ 1
[    1.568462] initcall idle_inject_init+0x0/0x11 returned 0 after 7812 usecs
[    1.570819] calling  initialize_ptr_random+0x0/0x4b @ 1
[    1.572467] initcall initialize_ptr_random+0x0/0x4b returned 0 after 0 usecs
[    1.576473] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.584464] smp: Bringing up secondary CPUs ...
[    1.624517] x86: Booting SMP configuration:
[    1.625973] .... node  #0, CPUs:      #1 #2 #3
[    1.750189] .... node  #1, CPUs:   #4 #5 #6 #7
[    1.875385] smp: Brought up 2 nodes, 8 CPUs
[    1.877951] smpboot: Max logical packages: 1
[    1.879454] smpboot: Total of 8 processors activated (44691.29 BogoMIPS)
[    2.240475] node 0 initialised, 7403881 pages in 356ms
[    2.245676] devtmpfs: initialized
[    2.245944] x86/mm: Memory block size: 128MB
[    2.252815] calling  ipc_ns_init+0x0/0x3f @ 1
[    2.254302] initcall ipc_ns_init+0x0/0x3f returned 0 after 0 usecs
[    2.256401] calling  init_mmap_min_addr+0x0/0x16 @ 1
[    2.256458] initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
[    2.258702] calling  net_ns_init+0x0/0x106 @ 1
[    2.260503] initcall net_ns_init+0x0/0x106 returned 0 after 0 usecs
[    2.262670] calling  xen_pvh_gnttab_setup+0x0/0x34 @ 1
[    2.264459] initcall xen_pvh_gnttab_setup+0x0/0x34 returned -19 after 0 usecs
[    2.266839] calling  e820__register_nvs_regions+0x0/0x38 @ 1
[    2.268473] initcall e820__register_nvs_regions+0x0/0x38 returned 0 after 0 usecs
[    2.272458] calling  cpufreq_register_tsc_scaling+0x0/0x2a @ 1
[    2.274329] initcall cpufreq_register_tsc_scaling+0x0/0x2a returned 0 after 0 usecs
[    2.276474] calling  init_cpu_syscore+0x0/0xf @ 1
[    2.278041] initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
[    2.280458] calling  reboot_init+0x0/0x3d @ 1
[    2.281895] initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
[    2.284457] calling  init_lapic_sysfs+0x0/0x21 @ 1
[    2.286136] initcall init_lapic_sysfs+0x0/0x21 returned 0 after 0 usecs
[    2.288457] calling  uv_bau_init+0x0/0xe46 @ 1
[    2.289954] initcall uv_bau_init+0x0/0xe46 returned 0 after 0 usecs
[    2.292061] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    2.292457] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usecs
[    2.294683] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
[    2.296458] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
[    2.298884] calling  wq_sysfs_init+0x0/0x2b @ 1
[    2.300474] initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
[    2.302606] calling  ksysfs_init+0x0/0x93 @ 1
[    2.304465] initcall ksysfs_init+0x0/0x93 returned 0 after 0 usecs
[    2.306583] calling  pm_init+0x0/0x7d @ 1
[    2.308514] initcall pm_init+0x0/0x7d returned 0 after 0 usecs
[    2.310446] calling  pm_disk_init+0x0/0x18 @ 1
[    2.311960] initcall pm_diinit+0x0/0x18 returned 0 after 0 usecs
[    2.412465] calling  swsusp_header_init+0x0/0x30 @ 1
[    2.414223] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    2.416458] calling  rcu_set_runtime_mode+0x0/0x12 @ 1
[    2.418232] initcall rcu_set_runtime_mode+0x0/0x12 returned 0 after 0 usecs
[    2.420457] calling  rcu_spawn_tasks_kthread+0x0/0x44 @ 1
[    2.424486] initcall rcu_spawn_tasks_kthread+0x0/0x44 returned 0 after 0 usecs
[    2.426937] calling  init_jiffies_clocksource+0x0/0x18 @ 1
[    2.428459] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.431647] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 3906 usecs
[    2.432457] calling  futex_init+0x0/0xce @ 1
[    2.434056] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.436483] initcall futex_init+0x0/0xce returned 0 after 0 usecs
[    2.438645] calling  cgroup_wq_init+0x0/0x2e @ 1
[    2.440489] initcall cgroup_wq_init+0x0/0x2e returned 0 after 0 usecs
[    2.442635] calling  cgroup1_wq_init+0x0/0x2e @ 1
[    2.444488] initcall cgroup1_wq_init+0x0/0x2e returned 0 after 0 usecs
[    2.446653] calling  ftrace_mod_cmd_init+0x0/0x9 @ 1
[    2.448459] initcall ftrace_mod_cmd_init+0x0/0x9 returned 0 after 0 usecs
[    2.450716] calling  init_wakeup_tracer+0x0/0x2d @ 1
[    2.452460] initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
[    2.454744] calling  init_graph_trace+0x0/0x5d @ 1
[    2.456462] initcall init_graph_trace+0x0/0x5d returned 0 after 0 usecs
[    2.458698] calling  init_per_zone_wmark_min+0x0/0x70 @ 1
[    2.460465] initcall init_per_zone_wmark_min+0x0/0x70 returned 0 after 0 usecs
[    2.462810] calling  init_zero_pfn+0x0/0x38 @ 1
[    2.464457] initcall init_zero_pfn+0x0/0x38 returned 0 after 0 usecs
[    2.466600] calling  memory_failure_init+0x0/0x9f @ 1
[    2.468458] initcall memory_failure_init+0x0/0x9f returned 0 after 0 usecs
[    2.470780] calling  fsnotify_init+0x0/0x49 @ 1
[    2.472478] initl fsnotify_init+0x0/0x49 returned 0 after 0 usecs
[    2.572459] calling  filelock_init+0x0/0x8c @ 1
[    2.576467] initcall filelock_init+0x0/0x8c returned 0 after 0 usecs
[    2.578504] calling  init_script_binfmt+0x0/0x16 @ 1
[    2.580457] initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
[    2.582729] calling  init_elf_binfmt+0x0/0x16 @ 1
[    2.584457] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    2.586715] calling  init_compat_elf_binfmt+0x0/0x16 @ 1
[    2.588457] initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    2.590817] calling  debugfs_init+0x0/0x51 @ 1
[    2.592459] initcall debugfs_init+0x0/0x51 returned 0 after 0 usecs
[    2.594573] calling  tracefs_init+0x0/0x3b @ 1
[    2.596115] initcall tracefs_init+0x0/0x3b returned 0 after 0 usecs
[    2.596457] calling  securityfs_init+0x0/0x69 @ 1
[    2.598047] initcall securityfs_init+0x0/0x69 returned 0 after 0 usecs
[    2.600458] calling  prandom_init+0x0/0xb8 @ 1
[    2.601917] initcall prandom_init+0x0/0xb8 returned 0 after 0 usecs
[    2.604457] calling  pinctrl_init+0x0/0xae @ 1
[    2.605932] pinctrl core: initialized pinctrl subsystem
[    2.608475] initcall pinctrl_init+0x0/0xae returned 0 after 3906 usecs
[    2.610663] calling  gpiolib_dev_init+0x0/0xcb @ 1
[    2.612465] initcall gpiolib_dev_init+0x0/0xcb returned 0 after 0 usecs
[    2.614666] calling  virtio_init+0x0/0x20 @ 1
[    2.616463] initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
[    2.618526] calling  iommu_init+0x0/0x2b @ 1
[    2.619918] initcall iommu_init+0x0/0x2b returned 0 after 0 usecs
[    2.620457] calling  component_debug_init+0x0/0x1d @ 1
[    2.622222] initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
[    2.624459] calling  early_resume_init+0x0/0xc0 @ 1
[    2.626065] RTC time: 12:37:13, date: 09/13/18
[    2.628458] initcall early_resume_init+0x0/0xc0 returned 0 after 3906 usecs
[    2.630765] calling  opp_debug_init+0x0/0x3c @ 1
[    2.632459] initcall opp_de_init+0x0/0x3c returned 0 after 0 usecs
[    2.732458] calling  cpufreq_core_init+0x0/0x4c @ 1
[    2.736459] initcall cpufreq_core_init+0x0/0x4c returned 0 after 0 usecs
[    2.738679] calling  cpuidle_init+0x0/0x3b @ 1
[    2.740460] initcall cpuidle_init+0x0/0x3b returned 0 after 0 usecs
[    2.742578] calling  capsule_reboot_register+0x0/0x11 @ 1
[    2.744458] initcall capsule_reboot_register+0x0/0x11 returned 0 after 0 usecs
[    2.746937] calling  bsp_pm_check_init+0x0/0x14 @ 1
[    2.748458] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
[    2.750672] calling  sock_init+0x0/0x9a @ 1
[    2.752540] initcall sock_init+0x0/0x9a returned 0 after 0 usecs
[    2.754619] calling  net_inuse_init+0x0/0x24 @ 1
[    2.756231] initcall net_inuse_init+0x0/0x24 returned 0 after 0 usecs
[    2.756458] calling  net_defaults_init+0x0/0x24 @ 1
[    2.758087] initcall net_defaults_init+0x0/0x24 returned 0 after 0 usecs
[    2.760458] calling  init_default_flow_dissectors+0x0/0x50 @ 1
[    2.762416] initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
[    2.764457] calling  netpoll_init+0x0/0x28 @ 1
[    2.765924] initcall netpoll_init+0x0/0x28 returned 0 after 0 usecs
[    2.768458] calling  netlink_proto_init+0x0/0x159 @ 1
[    2.770153] NET: Registered protocol family 16
[    2.772470] initcall netlink_proto_init+0x0/0x159 returned 0 after 0 usecs
[    2.774818] calling  __gnttab_init+0x0/0x30 @ 1
[    2.776458] initcall __gnttab_init+0x0/0x30 returned -19 after 0 usecs
[    2.778665] calling  irq_sysfs_init+0x0/0x94 @ 1
[    2.780530] initcall irq_sysfs_init+0x0/0x94 returned 0 after 0 usecs
[    2.782683] calling  audit_init+0x0/0x16c @ 1
[    2.784458] audit: initializing netlink subsys (disabled)
[    2.786514] initcall audit_init+0x0/0x16c returned 0 after 0 usecs
[    2.786514] audit: type=2000 audit(1536842232.456:1): state=initialized audit_enabled=0 res=1
[    2.788458] calling  release_early_probes+0x0/0x38 @ 1
[    2.792457] initcall release_earprobes+0x0/0x38 returned 0 after 0 usecs
[    2.896458] calling  bdi_class_init+0x0/0x49 @ 1
[    2.896463] initcall bdi_class_init+0x0/0x49 returned 0 after 0 usecs
[    2.898598] calling  mm_sysfs_init+0x0/0x29 @ 1
[    2.900458] initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usecs
[    2.902574] calling  gpiolib_sysfs_init+0x0/0xa0 @ 1
[    2.904463] initcall gpiolib_sysfs_init+0x0/0xa0 returned 0 after 0 usecs
[    2.906741] calling  pcibus_class_init+0x0/0x18 @ 1
[    2.908460] initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
[    2.910715] calling  pci_driver_init+0x0/0x22 @ 1
[    2.912471] initcall pci_driver_init+0x0/0x22 returned 0 after 0 usecs
[    2.914630] calling  backlight_class_init+0x0/0xa6 @ 1
[    2.916461] initcall backlight_class_init+0x0/0xa6 returned 0 after 0 usecs
[    2.918724] calling  xenbus_init+0x0/0x27c @ 1
[    2.920189] initcall xenbus_init+0x0/0x27c returned -19 after 0 usecs
[    2.920457] calling  tty_class_init+0x0/0x34 @ 1
[    2.922010] initcall tty_class_init+0x0/0x34 returned 0 after 0 usecs
[    2.924457] calling  vtconsole_class_init+0x0/0xd8 @ 1
[    2.926199] initcall vtconsole_class_init+0x0/0xd8 returned 0 after 0 usecs
[    2.928457] calling  iommu_dev_init+0x0/0x18 @ 1
[    2.930060] initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
[    2.932457] calling  mipi_dsi_bus_init+0x0/0x11 @ 1
[    2.934211] initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
[    2.936458] calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
[    2.938376] initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    2.940457] calling  isa_bus_init+0x0/0x3a @ 1
[    2.941972] initcall isa_bus_init+0x0/0x3a returned 0 after 0 usecs
[    2.944457] calling  register_node_type+0x0/0x2f @ 1
[    2.946165] initcall register_node_type+0x0/0x2f returned 0 after 0 usecs
[    2.948457] calling  regmap_initcall+0x0/0xd @ 1
[    2.950051] initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
[    2.952457] calling  spi_t+0x0/0x99 @ 1
[    3.052467] initcall spi_init+0x0/0x99 returned 0 after 0 usecs
[    3.056457] calling  i2c_init+0x0/0x89 @ 1
[    3.057864] initcall i2c_init+0x0/0x89 returned 0 after 0 usecs
[    3.060457] calling  init_ladder+0x0/0x24 @ 1
[    3.061915] cpuidle: using governor ladder
[    3.061915] initcall init_ladder+0x0/0x24 returned 0 after 0 usecs
[    3.062632] calling  init_menu+0x0/0x11 @ 1
[    3.064485] cpuidle: using governor menu
[    3.068459] initcall init_menu+0x0/0x11 returned 0 after 3906 usecs
[    3.070602] calling  pcc_init+0x0/0x93 @ 1
[    3.071985] initcall pcc_init+0x0/0x93 returned -19 after 0 usecs
[    3.072457] calling  amd_postcore_init+0x0/0x115 @ 1
[    3.074205] initcall amd_postcore_init+0x0/0x115 returned 0 after 0 usecs
[    3.076458] calling  kobject_uevent_init+0x0/0xc @ 1
[    3.078129] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
[    3.080523] calling  bts_init+0x0/0xbb @ 1
[    3.081898] initcall bts_init+0x0/0xbb returned -19 after 0 usecs
[    3.084457] calling  pt_init+0x0/0x32e @ 1
[    3.085927] initcall pt_init+0x0/0x32e returned -19 after 0 usecs
[    3.088457] calling  boot_params_ksysfs_init+0x0/0x271 @ 1
[    3.090277] initcall boot_params_ksysfs_init+0x0/0x271 returned 0 after 0 usecs
[    3.092457] calling  sbf_init+0x0/0xcb @ 1
[    3.093838] initcall sbf_init+0x0/0xcb returned 0 after 0 usecs
[    3.096457] calling  arch_kdebugfs_init+0x0/0x24 @ 1
[    3.098120] initcall arch_kdebugfs_init+0x0/0x24 returned 0 after 0 usecs
[    3.100457] calling  intel_pconfig_init+0x0/0xc7 @ 1
[    3.102091] initcall intel_pconfig_init+0x0/0xc7 returned 0 after 0 usecs
[    3.104457] calling  mtrr_if_init+0x0/0x5e @ 1
[    3.106065] initcall mtrr_if_init+0x0/0x5e returned 0 after 0 usecs
[    3.108121] calling  ffh_cstate_init+0x0/0x2a @ 1
[    3.108459] initcall ffh_cstate_init+0x0/0x2a returned 0 after 0 usecs
[    3.110583] calling  activate_jump_labels+0x0/0x32 @ 1
[    3.112457] initcall activate_jump_labels+0x0/0xreturned 0 after 0 usecs
[    3.212462] calling  kvm_setup_pv_tlb_flush+0x0/0x76 @ 1
[    3.214297] initcall kvm_setup_pv_tlb_flush+0x0/0x76 returned 0 after 0 usecs
[    3.220459] calling  gigantic_pages_init+0x0/0x2f @ 1
[    3.222137] initcall gigantic_pages_init+0x0/0x2f returned 0 after 0 usecs
[    3.224457] calling  uv_rtc_setup_clock+0x0/0x26d @ 1
[    3.226207] initcall uv_rtc_setup_clock+0x0/0x26d returned -19 after 0 usecs
[    3.228457] calling  kcmp_cookies_init+0x0/0x38 @ 1
[    3.230168] initcall kcmp_cookies_init+0x0/0x38 returned 0 after 0 usecs
[    3.230168] calling  acpi_pci_init+0x0/0x62 @ 1
[    3.230168] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.236457] ACPI: bus type PCI registered
[    3.237789] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.237789] initcall acpi_pci_init+0x0/0x62 returned 0 after 3906 usecs
[    3.238626] calling  dma_channel_table_init+0x0/0xd7 @ 1
[    3.240466] initcall dma_channel_table_init+0x0/0xd7 returned 0 after 0 usecs
[    3.243224] calling  dma_bus_init+0x0/0xd5 @ 1
[    3.244510] initcall dma_bus_init+0x0/0xd5 returned 0 after 0 usecs
[    3.246628] calling  setup_vcpu_hotplug_event+0x0/0x31 @ 1
[    3.248457] initcall setup_vcpu_hotplug_event+0x0/0x31 returned -19 after 0 usecs
[    3.251280] calling  register_xen_pci_notifier+0x0/0x2d @ 1
[    3.256457] initcall register_xen_pci_notifier+0x0/0x2d returned 0 after 0 usecs
[    3.256457] calling  xen_pcpu_init+0x0/0xae @ 1
[    3.257962] initcall xen_pcpu_init+0x0/0xae returned -19 after 0 usecs
[    3.260151] calling  dmi_id_init+0x0/0x33d @ 1
[    3.264487] initcall dmi_id_init+0x0/0x33d returned 0 after 0 usecs
[    3.266663] calling  ts_dmi_init+0x0/0x59 @ 1
[    3.266663] initcall ts_dmi_init+0x0/0x59 returned 0 after 0 usecs
[    3.266663] calling  pci_arch_init+0x0/0x66 @ 1
[    3.268468] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    3.271460] PCI: MMCONFIG at [mem 0xc0000-0xcfffffff] reserved in E820
[    3.376472] PCI: Using configuration type 1 for base access
[    3.378343] initcall pci_arch_init+0x0/0x66 returned 0 after 105468 usecs
[    3.380527] calling  init_vdso+0x0/0x40 @ 1
[    3.381949] initcall init_vdso+0x0/0x40 returned 0 after 0 usecs
[    3.384458] calling  sysenter_setup+0x0/0x14 @ 1
[    3.386095] initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
[    3.388457] calling  fixup_ht_bug+0x0/0xa2 @ 1
[    3.390010] initcall fixup_ht_bug+0x0/0xa2 returned 0 after 0 usecs
[    3.392457] calling  topology_init+0x0/0xc8 @ 1
[    3.394815] initcall topology_init+0x0/0xc8 returned 0 after 0 usecs
[    3.396457] calling  mtrr_init_finialize+0x0/0x3f @ 1
[    3.398136] initcall mtrr_init_finialize+0x0/0x3f returned 0 after 0 usecs
[    3.400457] calling  uid_cache_init+0x0/0x91 @ 1
[    3.402020] initcall uid_cache_init+0x0/0x91 returned 0 after 0 usecs
[    3.404457] calling  param_sysfs_init+0x0/0x1b6 @ 1
[    3.405127] initcall param_sysfs_init+0x0/0x1b6 returned 0 after 0 usecs
[    3.407435] calling  user_namespace_sysctl_init+0x0/0x34 @ 1
[    3.408468] initcall user_namespace_sysctl_init+0x0/0x34 returned 0 after 0 usecs
[    3.410941] calling  proc_schedstat_init+0x0/0x25 @ 1
[    3.416463] initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
[    3.418712] calling  pm_sysrq_init+0x0/0x19 @ 1
[    3.418712] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
[    3.418712] calling  create_proc_profile+0x0/0xd0 @ 1
[    3.420465] initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
[    3.422805] calling  crash_save_vmcoreinfo_init+0x0/0x5db @ 1
[    3.424485] initcall crash_save_vmcoreinfo_init+0x0/0x5db returned 0 after 0 usecs
[    3.427013] calling  crash_notes_memory_init+0x0/0x36 @ 1
[    3.432463] initcall crash_notes_memory_init+0x0/0x36 returned 0 after 0 usecs
[    3.434836] calling  cgroup_sysfs_init+0x0/0x18 @ 1
[    3.436460] initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    3.438646] calling  cgroup_namespaces_init+0x0/0x8 @ 1
[    3.440457] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
[    3.442749] calling  user_namespaces_init+0x0/0x2d @ 1
[    3.444459] initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
[    3.446835] calling  hung_task_init+0x0/0x4f @ 1
[    3.448477] initcall hung_task_init+0x0/0x4f returned 0 after 0 usecs
[    3.450637] calling  dev_map_init+0x0/0x14 @ 1
[    3.450637] initcall dev_map_init+0x0/0x14 returned 0 after 0 usecs
[    3.450762] calling  stack_map_init+0x0/0x4e @ 1
[    3.452458] initcall stack_map_init+0x0/0x4e returned 0 after 0 usecs
[    3.454655] calling  oom_init+0x0/0x30 @ 1
[    3.456471] initcall oom_init+0x0/0x30 returned 0ter 0 usecs
[    3.560458] calling  default_bdi_init+0x0/0xad @ 1
[    3.560487] initcall default_bdi_init+0x0/0xad returned 0 after 0 usecs
[    3.562733] calling  cgwb_init+0x0/0x2e @ 1
[    3.564458] initcall cgwb_init+0x0/0x2e returned 0 after 0 usecs
[    3.568458] calling  percpu_enable_async+0x0/0xf @ 1
[    3.570108] initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
[    3.572457] calling  kcompactd_init+0x0/0x97 @ 1
[    3.573968] initcall kcompactd_init+0x0/0x97 returned 0 after 0 usecs
[    3.576459] calling  init_user_reserve+0x0/0x40 @ 1
[    3.578084] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    3.580456] calling  init_admin_reserve+0x0/0x40 @ 1
[    3.582104] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    3.584457] calling  init_reserve_notifier+0x0/0x1f @ 1
[    3.586272] initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
[    3.588457] calling  swap_init_sysfs+0x0/0x63 @ 1
[    3.589980] initcall swap_init_sysfs+0x0/0x63 returned 0 after 0 usecs
[    3.589980] calling  swapfile_init+0x0/0xb3 @ 1
[    3.589980] initcall swapfile_init+0x0/0xb3 returned 0 after 0 usecs
[    3.592457] calling  hugetlb_init+0x0/0x497 @ 1
[    3.594007] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    3.596456] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    3.598683] initcall hugetlb_init+0x0/0x497 returned 0 after 3906 usecs
[    3.600457] calling  ksm_init+0x0/0x25d @ 1
[    3.604479] initcall ksm_init+0x0/0x25d returned 0 after 0 usecs
[    3.604479] calling  hugepage_init+0x0/0x155 @ 1
[    3.608478] initcall hugepage_init+0x0/0x155 returned 0 after 0 usecs
[    3.608478] calling  mem_cgroup_init+0x0/0x152 @ 1
[    3.612496] initcall mem_cgroup_init+0x0/0x152 returned 0 after 0 usecs
[    3.614734] calling  mem_cgroup_swap_init+0x0/0x52 @ 1
[    3.616459] initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
[    3.618742] calling  sel_ib_pkey_init+0x0/0x36 @ 1
[    3.620] initcall sel_ib_pkey_init+0x0/0x36 returned 0 after 0 usecs
[    3.624457] calling  crypto_wq_init+0x0/0x31 @ 1
[    3.628493] initcall crypto_wq_init+0x0/0x31 returned 0 after 0 usecs
[    3.630759] calling  cryptomgr_init+0x0/0x11 @ 1
[    3.632459] initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
[    3.634589] calling  init_bio+0x0/0xd2 @ 1
[    3.636022] initcall init_bio+0x0/0xd2 returned 0 after 0 usecs
[    3.636457] calling  blk_settings_init+0x0/0x2a @ 1
[    3.638151] initcall blk_settings_init+0x0/0x2a returned 0 after 0 usecs
[    3.640457] calling  blk_ioc_init+0x0/0x2a @ 1
[    3.641927] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
[    3.644456] calling  blk_softirq_init+0x0/0x71 @ 1
[    3.646051] initcall blk_softirq_init+0x0/0x71 returned 0 after 0 usecs
[    3.648456] calling  blk_mq_init+0x0/0x2a @ 1
[    3.649952] initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
[    3.652456] calling  genhd_device_init+0x0/0x76 @ 1
[    3.654096] initcall genhd_device_init+0x0/0x76 returned 0 after 0 usecs
[    3.656458] calling  irq_poll_setup+0x0/0x6c @ 1
[    3.657947] initcall irq_poll_setup+0x0/0x6c returned 0 after 0 usecs
[    3.660456] calling  byt_gpio_init+0x0/0x13 @ 1
[    3.661987] initcall byt_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    3.664457] calling  gpiolib_debugfs_init+0x0/0x24 @ 1
[    3.666186] initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    3.668457] calling  pwm_debugfs_init+0x0/0x24 @ 1
[    3.670157] initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    3.672457] calling  pwm_sysfs_init+0x0/0x18 @ 1
[    3.673971] initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    3.676072] calling  pci_slot_init+0x0/0x40 @ 1
[    3.676460] initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
[    3.678573] calling  fbmem_init+0x0/0xdb @ 1
[    3.680479] initcall fbmem_init+0x0/0xdb returned 0 after 0 usecs
[    3.682504] calling  scan_for_dmi_ipmi+0x0/0xf4 @ 1
[    3.684478] initcall s_for_dmi_ipmi+0x0/0xf4 returned 0 after 0 usecs
[    3.688457] calling  acpi_init+0x0/0x313 @ 1
[    3.692514] ACPI: Added _OSI(Module Device)
[    3.694054] ACPI: Added _OSI(Processor Device)
[    3.695730] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.696456] ACPI: Added _OSI(Processor Aggregator Device)
[    3.698300] ACPI: Added _OSI(Linux-Dell-Video)
[    3.700457] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.719487] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    3.741132] ACPI: Interpreter enabled
[    3.742383] ACPI: (supports S0 S4 S5)
[    3.743677] ACPI: Using IOAPIC for interrupt routing
[    3.744560] HEST: Table parsing has been initialized.
[    3.746288] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.781044] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    3.783207] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.784622] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    3.788457] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    3.792457] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    3.795497] acpi PNP0A08:00: _OSC: platform willing to grant []
[    3.796457] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    3.799138] PCI host bridge to bus 0000:00
[    3.800458] pci_bus 0000:00: root bus resource [mem 0xfaf00000-0xfdffffff window]
[    3.803004] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
[    3.804457] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    3.808457] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    3.810727] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    3.812457] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed03fff window]
[    3.814950] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    3.816457] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    3.820457] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    3.822670] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.824457] pci_bus 0000:00: root bus resource [bus 00-3f]
[    3.826319] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    3.828460] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.830642] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.832680] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    3.834958] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    3.836474] pci 0000:00:02.0: enabling Extended Tags
[    3.838131] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    3.840666] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    3.842880] pci 0000:00:0a.0: enabling Extended Tags
[    3.844482] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    3.846748] pci 0000:00:0c.0: [1002:5a20] type class 0x060400
[    3.848501] pci 0000:00:0c.0: enabling Extended Tags
[    3.850180] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    3.852662] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    3.854679] pci 0000:00:11.0: calling  quirk_no_ata_d3+0x0/0x10 @ 1
[    3.856458] pci 0000:00:11.0: quirk_no_ata_d3+0x0/0x10 took 0 usecs
[    3.860472] pci 0000:00:11.0: reg 0x10: [io  0x1000-0x1007]
[    3.862362] pci 0000:00:11.0: reg 0x14: [io  0x1008-0x100b]
[    3.864334] pci 0000:00:11.0: reg 0x18: [io  0x1010-0x1017]
[    3.864464] pci 0000:00:11.0: reg 0x1c: [io  0x1018-0x101b]
[    3.866300] pci 0000:00:11.0: reg 0x20: [io  0x1020-0x102f]
[    3.868466] pci 0000:00:11.0: reg 0x24: [mem 0xfccf0000-0xfccf03ff]
[    3.870527] pci 0000:00:11.0: calling  quirk_amd_ide_mode+0x0/0xb0 @ 1
[    3.872463] pci 0000:00:11.0: set SATA to AHCI mode
[    3.874070] pci 0000:00:11.0: quirk_amd_ide_mode+0x0/0xb0 took 0 usecs
[    3.876666] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    3.880468] pci 0000:00:12.0: reg 0x10: [mem 0xfcce0000-0xfcce0fff]
[    3.882798] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    3.884473] pci 0000:00:12.1: reg 0x10: [mem 0xfccd0000-0xfccd0fff]
[    3.886837] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    3.888477] pci 0000:00:12.2: reg 0x10: [mem 0xfccc0000-0xfccc00ff]
[    3.890626] pci 0000:00:12.2: supports D1 D2
[    3.892457] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    3.894789] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    3.896473] pci 0000:00:13.0: reg 0x10: [mem 0xfccb0000-0xfccb0fff]
[    3.898766] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    3.900473] pci 0000:00:13.1: reg 0x10: [mem 0xfcca0000-0xfcca0fff]
[    3.902847] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    3.904477] pci 0000:00:13.2: reg 0x10: [mem 0xfcc90000-0xfcc900ff]
[    3.908475] pci 0000:00:13.2: supports D1 D2
[    3.909899] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    3.912124] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    3.912463] pci 0000:00:14.0: calling  sb600_disable_hpet_bar+0x0/0x50 @ 1
[    3.916459] pci 0000:00:14.0: sb600_able_hpet_bar+0x0/0x50 took 0 usecs
[    3.920523] pci 0000:00:14.0: calling  force_disable_hpet_msi+0x0/0x10 @ 1
[    3.924458] pci 0000:00:14.0: force_disable_hpet_msi+0x0/0x10 took 0 usecs
[    3.926821] pci 0000:00:14.0: calling  sb600_hpet_quirk+0x0/0x40 @ 1
[    3.928458] pci 0000:00:14.0: sb600_hpet_quirk+0x0/0x40 took 0 usecs
[    3.930825] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    3.932461] pci 0000:00:14.1: calling  quirk_no_ata_d3+0x0/0x10 @ 1
[    3.936458] pci 0000:00:14.1: quirk_no_ata_d3+0x0/0x10 took 0 usecs
[    3.938655] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
[    3.940464] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
[    3.942332] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
[    3.944464] pci 0000:00:14.1: reg 0x1c: [io  0x0374-0x0377]
[    3.946304] pci 0000:00:14.1: reg 0x20: [io  0x0500-0x050f]
[    3.948282] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    3.948456] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    3.952457] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    3.954838] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    3.956663] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    3.958965] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    3.960680] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    3.962719] pci 0000:00:18.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.964458] pci 0000:00:18.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.968655] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    3.970675] pci 0000:00:18.1: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.972458] pci 0000:00:18.1: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.974860] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    3.976458] pci 0000:00:18.2: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.978780] pci 0000:00:18.2: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.980641] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    3.984458] pci 0000:00:18.3: calling  quirk_mmio_always_on+/0x10 @ 1
[    3.988458] pci 0000:00:18.3: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.992646] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    3.994726] pci 0000:00:18.4: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.996459] pci 0000:00:18.4: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.998880] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    4.000458] pci 0000:00:18.5: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.004457] pci 0000:00:18.5: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.006870] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    4.008459] pci 0000:00:19.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.010699] pci 0000:00:19.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.012651] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[    4.014695] pci 0000:00:19.1: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.016458] pci 0000:00:19.1: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.020646] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    4.022769] pci 0000:00:19.2: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.024458] pci 0000:00:19.2: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.026844] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    4.028458] pci 0000:00:19.3: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.030689] pci 0000:00:19.3: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.032649] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    4.034644] pci 0000:00:19.4: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.036458] pci 0000:00:19.4: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.040651] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    4.042706] pci 0000:00:19.5: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    4.044458] pci 0000:00:19.5: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    4.046963] pci 0000:03:00.0: [103c:323b] type 00 class 0x010400
[    4.048473] pci 0000:03:00.0: reg 0x10: [mem 0xfdf00000-0xfdffffff 64bit]
[    4.050818] pci 0000:03:00.0: reg 0x18: [mem 0xfdef0000-0xfdef03ff 64bit]
[    4.052462] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
[    4.054313] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    4.056461] pci 0000:03:00.0: enabling Extended Tags
  4.058182] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    4.060478] pci 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x8 link at 0000:00:02.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[    4.064503] pci 0000:00:02.0: PCI bridge to [bus 03]
[    4.068459] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    4.070466] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    4.072517] pci 0000:02:00.0: [103c:3306] type 00 class 0x088000
[    4.074544] pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
[    4.076466] pci 0000:02:00.0: reg 0x14: [mem 0xfddf0000-0xfddf01ff]
[    4.078559] pci 0000:02:00.0: reg 0x18: [io  0x3400-0x34ff]
[    4.080568] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:0a.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    4.084515] pci 0000:02:00.1: [102b:0533] type 00 class 0x030000
[    4.086519] pci 0000:02:00.1: reg 0x10: [mem 0xfb000000-0xfbffffff pref]
[    4.088466] pci 0000:02:00.1: reg 0x14: [mem 0xfdde0000-0xfdde3fff]
[    4.090575] pci 0000:02:00.1: reg 0x18: [mem 0xfd000000-0xfd7fffff]
[    4.092509] pci 0000:02:00.1: calling  efifb_fixup_resources+0x0/0x100 @ 1
[    4.094854] pci 0000:02:00.1: efifb_fixup_resources+0x0/0x100 took 0 usecs
[    4.096565] pci 0000:02:00.2: [103c:3307] type 00 class 0x088000
[    4.100478] pci 0000:02:00.2: reg 0x10: [io  0x3800-0x38ff]
[    4.102430] pci 0000:02:00.2: reg 0x14: [mem 0xfcff0000-0xfcff00ff]
[    4.104466] pci 0000:02:00.2: reg 0x18: [mem 0xfce00000-0xfcefffff]
[    4.106589] pci 0000:02:00.2: reg 0x1c: [mem 0xfcd80000-0xfcdfffff]
[    4.108465] pci 0000:02:00.2: reg 0x20: [mem 0xfcd70000-0xfcd77fff]
[    4.110561] pci 0000:02:00.2: reg 0x24: [mem 0xfcd60000-0xfcd67fff]
[    4.112466] pci 0000:02:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    4.114751] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    4.116531] pci 0000:02:00.4: [103c:3300] type 00 class 0x0c0300
[    4.118565] pci 0000:02:00.4: reg 0x20: [io  0x3c00-0x3c1f]
[    4.132478] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    4.134240] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    4.136249] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    4.136459] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    4.140580] pci 0000:04:00.0: [14e4:1657] type 00 class 0x020000
[    4.142746] pci 0000:04:00.0: reg 0x10: [mem 0xfcbf0000-0xfcbfffff 64bit pref]
[    4.144466] pci 0000:04:00.0: reg 0x18: [mem 0xfcbe0000-0xfcbeffff 64bit pref]
[    4.146819] pci 0000:04:00.0: reg 0x20: [mem 0xfcbd0000-0xfcbdffff 64bit pref]
[    4.148464] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    4.152520] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    4.154644] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:0c.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
[    4.156561] pci 0000:04:00.1: [14e4:1657] type 00 class 0x020000
[    4.160477] pci 0000:04:00.1: reg 0x10: [mem 0xfcbc0000-0xfcbcffff 64bit pref]
[    4.162982] pci 0000:04:00.1: reg 0x18: [mem 0xfcbb0000-0xfcbbffff 64bit pref]
[    4.164466] pci 0000:04:00.1: reg 0x20: [mem 0xfcba0000-0xfcbaffff 64bit pref]
[    4.168463] pci 0000:04:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    4.170767] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    4.172570] pci 0000:04:00.2: [14e4:1657] type 00 class 0x020000
[    4.174637] pci 0000:04:00.2: reg 0x10: [mem 0xfcb90000-0xfcb9ffff 64bit pref]
[    4.176478] pci 0000:04:00.2: reg 0x18: [mem 0xfcb80000-0xfcb8ffff 64bit pref]
[    4.178901] pci 0000:04:00.2: reg 0x20: [mem 0xfcb70000-0xfcb7ffff 64bit pref]
[    4.180463] pci 0000:04:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    4.184517] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
[    4.186684] pci 0000:04:00.3: [14e4:1657] type 00 class 0x020000
[    4.188477] pci 0000:04:00.3: reg 0x10: [mem 0xfcb60000-0xfcb6ffff 64bit pref]
[    4.190916] pci 0000:04:00.3: reg 0x18: [memfcb50000-0xfcb5ffff 64bit pref]
[    4.192466] pci 0000:04:00.3: reg 0x20: [mem 0xfcb40000-0xfcb4ffff 64bit pref]
[    4.196463] pci 0000:04:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    4.198649] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    4.200578] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    4.202341] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    4.204468] pci_bus 0000:01: extended config space not accessible
[    4.206538] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    4.208464] pci 0000:00:14.4:   bridge window [mem 0xfaf00000-0xfdffffff window] (subtractive decode)
[    4.212457] pci 0000:00:14.4:   bridge window [io  0x1000-0xffff window] (subtractive decode)
[    4.215178] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    4.216457] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    4.220457] pci 0000:00:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
[    4.224457] pci 0000:00:14.4:   bridge window [mem 0xfed00000-0xfed03fff window] (subtractive decode)
[    4.227370] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
[    4.228457] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    4.232457] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    4.235259] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    4.236964] ACPI: PCI Interrupt Link [I020] (IRQs *24)
[    4.240936] ACPI: PCI Interrupt Link [I021] (IRQs *25)
[    4.243161] ACPI: PCI Interrupt Link [I022] (IRQs *26)
[    4.244944] ACPI: PCI Interrupt Link [I023] (IRQs *27)
[    4.248885] ACPI: PCI Interrupt Link [I030] (IRQs *28)
[    4.251151] ACPI: PCI Interrupt Link [I031] (IRQs *29)
[    4.252947] ACPI: PCI Interrupt Link [I032] (IRQs *30)
[    4.255161] ACPI: PCI Interrupt Link [I033] (IRQs *31)
[    4.256933] ACPI: PCI Interrupt Link [I040] (IRQs *44)
[    4.259229] ACPI: PCI Interrupt Link [I041] (IRQs *45)
[    4.260965] ACPI: PCI Interrupt Link [I042] (IRQs *46)
[    4.264864] ACPI: PCI Interrupt Link [I043] (IRQs *47)
[    4.267156] ACPI: PCI Interrupt Link [I050] (IRQs *48)
[    4.268956] ACPI: PCI Interrupt Link [I051] (IRQs *49)
[    4.271201] ACPI: PCI Interrupt Link [I052] (IRQs *50)
[    4.272974] ACPI: PCI Interrupt Link [I053] (IRQs *51)
[    4.275312] ACPI: PCI Interrupt Link [I060] (IRQs *47)
[    4.276954] ACPI: PCI Interrupt Link [I061] (IRQs *44)
[    4.280834] ACPI: PCI Interrupt Link [I062] (IRQs *45)
[    4.283257] ACPI: PCI Interrupt Link [I063] (IRQs *46)
[    4.284967] ACPI: PCI Interrupt Link [I070] (IRQs *24)
[    4.287243] ACPI: PCI Interrupt Link [I071] (IRQs *25)
[    4.288993] ACPI: PCI Interrupt Link [I072] (IRQs *26)
[    4.291319] ACPI: PCI Interrupt Link [I073] (IRQs *27)
[    4.292613] ACPI: PCI Interrupt Link [I090] (IRQs *24)
[    4.294538] ACPI: PCI Interrupt Link [I091] (IRQs *24)
[    4.296610] ACPI: PCI Interrupt Link [I092] (IRQs *24)
[    4.298562] ACPI: PCI Interrupt Link [I093] (IRQs *24)
[    4.300985] ACPI: PCI Interrupt Link [I0A0] (IRQs *24)
[    4.304626] ACPI: PCI Interrupt Link [I0A1] (IRQs *25)
[    4.306950] ACPI: PCI Interrupt Link [I0A2] (IRQs *26)
[    4.309017] ACPI: PCI Interrupt Link [I0A3] (IRQs *27)
[    4.311267] ACPI: PCI Interrupt Link [I0B0] (IRQs *32)
[    4.313000] ACPI: PCI Interrupt Link [I0B1] (IRQs *33)
[    4.315349] ACPI: PCI Interrupt Link [I0B2] (IRQs *34)
[    4.317022] ACPI: PCI Interrupt Link [I0B3] (IRQs *35)
[    4.320896] ACPI: PCI Interrupt Link [I0C0] (IRQs *36)
[    4.323284] ACPI: PCI Interrupt Link [I0C1] (IRQs *37)
[    4.325020] ACPI: PCI Interrupt Link [I0C2] (IRQs *38)
[    4.327362] ACPI: PCI Interrupt Link [I0C3] (IRQs *39)
[    4.329010] ACPI: PCI Interrupt Link [I0D0] (IRQs *40)
[    4.332523] ACPI: PCI Interrupt Link [I0D1] (IRQs *41)
[    4.334904] ACPI: PCI Interrupt Link [I0D2] (IRQs *42)
[    4.337047] ACPI: PCI Interrupt Link [I0D3] (IRQs *43)
[    4.338860] ACPI: PCI Interrupt Link [BI02] (IRQs *52)
[    4.340542] ACPI: PCI Interrupt Link [BI03] (IRQs *52)
[    4.342520] ACPI: PCI Interrupt Link [BI04] (IRQs *52)
[    4.344560] ACPI: PCI Interrupt Link [BI05] (IRQs *52)
[    4.346553] ACPI: PCI Interrupt Link [BI06] (IRQs *54)
[    4.348579] ACPI: PCI Interrupt Link [BI07] (IRQs *24)
[    4.350438] ACPI: PCI Interrupt Link [BI08] (IRQs *24)
[    4.352599] ACPI: PCI Interrupt Link [BI09] (IRQs *24)
[    4.354509] ACPI: PCI Interrupt Link [BI0A] (IRQs *24)
[    4.356486] ACPI: PCI Interrupt Link [BI0B] (IRQs *54)
[    4.358331] ACPI: PCI Interrupt Link [BI0C] (IRQs *54)
[    4.360267] ACPI: PCI Interrupt Link [BI0D] (IRQs *54)
[    4.360574] ACPI: PCI Interrupt Link [PI20] (IRQs 10 11) *0, disabled.
[    4.364613] ACPI: PCI Interrupt Link [PI21] (IRQs 10 11) *0, disabled.
[    4.367062] ACPI: PCI Interrupt Link [PI22] (IRQs 10 11) *0, disabled.
[    4.368594] ACPI: PCI Interrupt Link [PI23] (IRQs 10 11) *0, disabled.
[    4.371072] ACPI: PCI Interrupt Link [PI30] (IRQs 10 11) *0, disabled.
[    4.372593] ACPI: PCI Interrupt Link [PI31] (IRQs 10 11) *0, disabled.
[    4.376592] ACPI: PCI Interrupt Link [PI32] (IRQs 10 11) *0, disabled.
[    4.378975] ACPI: PCI Interrupt Link [PI33] (IRQs 10 11) *0, disabled.
[    4.380593] ACPI: PCI Interrupt Link [PI40] (IRQs 10 11) *0, disabled.
[    4.382924] ACPI: PCI Interrupt Link [PI41] (IRQs 10 11) *0, disabled.
[    4.384592] ACPI: PCI Interrupt Link [PI42] (IRQs 10 11) *0, disabled.
[    4.388594] ACPI: PCI Interrupt Link [PI43] (IRQs 10 11) *0, disabled.
[    4.390955] ACPI: PCI Interrupt Link [PI50] (IRQs 10 11) *0, disabled.
[    4.392593] ACPI: PCI Interrupt Link [PI51] (IRQs 10 11) *0, disabled.
[    4.394904] ACPI: PCI Interrupt Link [PI52] (IRQs 10 11) *0, disabled.
[    4.396592] ACPI: PCI Interrupt Link [PI53] (IRQs 10 11) *0, disabled.
[    4.400592] ACPI: PCI Interrupt Link [PI60] (IRQs 10 11) *0, disabled.
[    4.402969] ACPI: PCI Interrupt Link [PI61] (IRQs 10 11) *0, disabled.
[    4.404593] ACPI: PCI Interrupt Link [PI62] (IRQs 10 11) *0, disabled.
[    4.406946] ACPI: PCI Interrupt Link [PI63] (IRQs 10 11) *0, disabled.
[    4.408593] ACPI: PCI Interrupt Link [PI70] (IRQs 10 11) *0, disabled.
[    4.412592] ACPI: PCI Interrupt Link [PI71] (IRQs 10 11) *0, disabled.
[    4.414942] ACPI: PCI Irrupt Link [PI72] (IRQs 10 11) *0, disabled.
[    4.416600] ACPI: PCI Interrupt Link [PI73] (IRQs 10 11) *0, disabled.
[    4.418963] ACPI: PCI Interrupt Link [PI90] (IRQs 10 11) *0, disabled.
[    4.420595] ACPI: PCI Interrupt Link [PI91] (IRQs 10 11) *0, disabled.
[    4.422952] ACPI: PCI Interrupt Link [PI92] (IRQs 10 11) *0, disabled.
[    4.424594] ACPI: PCI Interrupt Link [PI93] (IRQs 10 11) *0, disabled.
[    4.428593] ACPI: PCI Interrupt Link [PIA0] (IRQs 10 11) *0, disabled.
[    4.430880] ACPI: PCI Interrupt Link [PIA1] (IRQs 10 11) *0, disabled.
[    4.432592] ACPI: PCI Interrupt Link [PIA2] (IRQs 10 11) *0, disabled.
[    4.434881] ACPI: PCI Interrupt Link [PIA3] (IRQs 10 11) *0, disabled.
[    4.436592] ACPI: PCI Interrupt Link [PIB0] (IRQs 10 11) *0, disabled.
[    4.440457] ACPI: PCI Interrupt Link [PIB1] (IRQs 10 11) *0, disabled.
[    4.442839] ACPI: PCI Interrupt Link [PIB2] (IRQs 10 11) *0, disabled.
[    4.444593] ACPI: PCI Interrupt Link [PIB3] (IRQs 10 11) *0, disabled.
[    4.446951] ACPI: PCI Interrupt Link [PIC0] (IRQs 10 11) *0, disabled.
[    4.448592] ACPI: PCI Interrupt Link [PIC1] (IRQs 10 11) *0, disabled.
[    4.450953] ACPI: PCI Interrupt Link [PIC2] (IRQs 10 11) *0, disabled.
[    4.452613] ACPI: PCI Interrupt Link [PIC3] (IRQs 10 11) *0, disabled.
[    4.456591] ACPI: PCI Interrupt Link [PID0] (IRQs 10 11) *0, disabled.
[    4.458880] ACPI: PCI Interrupt Link [PID1] (IRQs 10 11) *0, disabled.
[    4.460592] ACPI: PCI Interrupt Link [PID2] (IRQs 10 11) *0, disabled.
[    4.463001] ACPI: PCI Interrupt Link [PID3] (IRQs 10 11) *0, disabled.
[    4.464593] ACPI: PCI Interrupt Link [PIR2] (IRQs 10 11) *0, disabled.
[    4.466932] ACPI: PCI Interrupt Link [PIR3] (IRQs 10) *0, disabled.
[    4.468600] ACPI: PCI Interrupt Link [PIR4] (IRQs 10 11) *0, disabled.
[    4.472596] ACPI: PCI Interrupt Link [PIR5] (IRQs 10 11) *0, disabled.
[    4.474920] ACPI: PCI Interrupt Link [PIR6] (IRQs 10 11) *0, disabled.
[    4.476594] ACPI: PCI Interrupt Link [PIR7] (IRQs 10 11) *0, disabled.
[    4.478946] ACPI: PCI Interrupt Link [PIR8] (IRQs 10 11) *0, disabled.
[    4.480593] ACPI: PCI Interrupt Link [PIR9] (IRQs 10 11) *0, disabled.
[    4.484596] ACPI: PCI Interrupt Link [PIRA] (IRQs 10 11) *0, disabled.
[    4.486990] ACPI: PCI Interrupt Link [PIRB] (IRQs 10 11) *0, disabled.
[    4.488593] ACPI: PCI Interrupt Link [PIRC] (IRQs 10 11) *0, disabled.
[    4.491021] ACPI: PCI Interrupt Link [PIRD] (IRQs 10 11) *0, disabled.
[    4.492569] ACPI: PCI Interrupt Link [USB1] (IRQs *22)
[    4.494399] ACPI: PCI Interrupt Link [USB2] (IRQs *23)
[    4.496561] ACPI: PCI Interrupt Link [USB3] (IRQs *23)
[    4.498516] ACPI: PCI Interrupt Link [USB4] (IRQs *22)
[    4.500611] ACPI: Invalid _PRS IRQ 0
[    4.502120] ACPI: PCI Interrupt Link [U1PI] (IRQs) *0
[    4.504616] ACPI: Invalid _PRS IRQ 0
[    4.505998] ACPI: PCI Interrupt Link [U2PI] (IRQs) *0
[    4.508621] ACPI: Invalid _PRS IRQ 0
[    4.510036] ACPI: PCI Interrupt Link [U3PI] (IRQs) *0
[    4.512018] ACPI: Invalid _PRS IRQ 0
[    4.512606] ACPI: PCI Interrupt Link [U4PI] (IRQs) *0
[    4.514392] ACPI: PCI Interrupt Link [SATA] (IRQs *16)
[    4.516537] ACPI: Invalid _PRS IRQ 0
[    4.517821] ACPI: PCI Interrupt Link [SATP] (IRQs) *0
[    4.520958] initcall acpi_init+0x0/0x313 returned 0 after 808593 usecs
[    4.523221] calling  pnp_init+0x0/0x11 @ 1
[    4.524464] initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
[    4.526398] calling  balloon_init+0x0/0x1b0 @ 1
[    4.527919] initcall balloon_init+0x0/0x1b0 returned -19 after 0 usecs
[    4.528458] calling  xen_setup_shutdown_event+0x0/0x30 @ 1
[    4.532457] initcall xen_setup_shutdown_event+0x0/0x30 returned -19 after 0 usecs
[    4.534897] calling  xenbus_probe_backend_init+0x0/0x4e @ 1
[    4.536465] initcall xenbus_probe_backend_init+0x0/0x4e returned 0 after 0 usecs
[    4.538960] calling  xenbus_probe_frontend_init+0x0/0x4e @ 1
[    4.540465] initcall xenbus_probe_frontend_init+0x0/0x4e returned 0 after 0 usecs
[    4.542995] calling  xen_acpi_pad_init+0x0/0x3c @ 1
[    4.544457] initcall xen_acpi_pad_init+0x0/0x3c returned -19 after 0 usecs
[    4.546688] calling  misc_init+0x0/0xbf @ 1
[    4.548463] initcall misc_init+0x0/0xbf returned 0 after 0 usecs
[    4.550462] calling  tpm_init+0x0/0x@ 1
[    4.552463] initcall tpm_init+0x0/0xd1 returned 0 after 0 usecs
[    4.554459] calling  vga_arb_device_init+0x0/0x21d @ 1
[    4.556215] pci 0000:02:00.1: vgaarb: setting as boot VGA device
[    4.556215] pci 0000:02:00.1: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.556458] pci 0000:02:00.1: vgaarb: bridge control possible
[    4.558490] vgaarb: loaded
[    4.559390] initcall vga_arb_device_init+0x0/0x21d returned 0 after 3906 usecs
[    4.560458] calling  cn_init+0x0/0xd0 @ 1
[    4.561844] initcall cn_init+0x0/0xd0 returned 0 after 0 usecs
[    4.564457] calling  dax_fs_init+0x0/0xbf @ 1
[    4.565953] initcall dax_fs_init+0x0/0xbf returned 0 after 0 usecs
[    4.568457] calling  dma_buf_init+0x0/0xaa @ 1
[    4.569939] initcall dma_buf_init+0x0/0xaa returned 0 after 0 usecs
[    4.572457] calling  init_scsi+0x0/0x8a @ 1
[    4.573924] SCSI subsystem initialized
[    4.575237] initcall init_scsi+0x0/0x8a returned 0 after 0 usecs
[    4.576457] calling  ata_init+0x0/0x56 @ 1
[    4.577936] libata version 3.00 loaded.
[    4.580458] initcall ata_init+0x0/0x56 returned 0 after 3906 usecs
[    4.582528] calling  xdbc_init+0x0/0x14b @ 1
[    4.583977] initcall xdbc_init+0x0/0x14b returned 0 after 0 usecs
[    4.584457] calling  serio_init+0x0/0x2a @ 1
[    4.585904] initcall serio_init+0x0/0x2a returned 0 after 0 usecs
[    4.588457] calling  input_init+0x0/0xfd @ 1
[    4.589912] initcall input_init+0x0/0xfd returned 0 after 0 usecs
[    4.592457] calling  rtc_init+0x0/0x4c @ 1
[    4.593819] initcall rtc_init+0x0/0x4c returned 0 after 0 usecs
[    4.596457] calling  dw_i2c_init_driver+0x0/0x13 @ 1
[    4.598191] initcall dw_i2c_init_driver+0x0/0x13 returned 0 after 0 usecs
[    4.600457] calling  cec_devnode_init+0x0/0xa4 @ 1
[    4.602054] initcall cec_devnode_init+0x0/0xa4 returned 0 after 0 usecs
[    4.604457] calling  power_supply_class_init+0x0/0x40 @ 1
[    4.606236] initcall power_supply_class_init+0x0/0x40 returned 0 after 0 usecs
[    48457] calling  hwmon_init+0x0/0xce @ 1
[    4.612464] initcall hwmon_init+0x0/0xce returned 0 after 0 usecs
[    4.614539] calling  edac_init+0x0/0x70 @ 1
[    4.616456] EDAC MC: Ver: 3.0.0
[    4.617634] initcall edac_init+0x0/0x70 returned 0 after 0 usecs
[    4.620457] calling  leds_init+0x0/0x3c @ 1
[    4.621906] initcall leds_init+0x0/0x3c returned 0 after 0 usecs
[    4.624457] calling  dmi_init+0x0/0x114 @ 1
[    4.625881] initcall dmi_init+0x0/0x114 returned 0 after 0 usecs
[    4.627869] calling  efisubsys_init+0x0/0x2d9 @ 1
[    4.628458] initcall efisubsys_init+0x0/0x2d9 returned 0 after 0 usecs
[    4.630641] calling  devfreq_init+0x0/0xa1 @ 1
[    4.632485] initcall devfreq_init+0x0/0xa1 returned 0 after 0 usecs
[    4.634533] calling  devfreq_event_init+0x0/0x4e @ 1
[    4.636460] initcall devfreq_event_init+0x0/0x4e returned 0 after 0 usecs
[    4.638713] calling  ras_init+0x0/0xf @ 1
[    4.640461] initcall ras_init+0x0/0xf returned 0 after 0 usecs
[    4.642404] calling  nvmem_init+0x0/0x11 @ 1
[    4.643913] initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
[    4.644458] calling  pci_subsys_init+0x0/0x67 @ 1
[    4.646049] PCI: Using ACPI for IRQ routing
[    4.658118] PCI: pci_cache_line_size set to 64 bytes
[    4.659931] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    4.660457] e820: reserve RAM buffer [mem 0xbddde000-0xbfffffff]
[    4.662555] e820: reserve RAM buffer [mem 0x83efff000-0x83fffffff]
[    4.664458] initcall pci_subsys_init+0x0/0x67 returned 0 after 19531 usecs
[    4.668457] calling  proto_init+0x0/0x11 @ 1
[    4.669875] initcall proto_init+0x0/0x11 returned 0 after 0 usecs
[    4.671918] calling  net_dev_init+0x0/0x23a @ 1
[    4.672550] initcall net_dev_init+0x0/0x23a returned 0 after 0 usecs
[    4.674679] calling  neigh_init+0x0/0x80 @ 1
[    4.676459] initcall neigh_init+0x0/0x80 returned 0 after 0 usecs
[    4.678506] calling  fib_notifier_init+0x0/0x11 @ 1
[    4.680457] initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
[    4.682719] calling  fib_rules_init+0x0/0xac @ 1
[    4.684459] initcall fib_rules_init+0x0/0xac returned 0 after 0 usecs
[    4.686574] calling  init_cgroup_netprio+0x0/0x14 @ 1
[    4.688458] initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
[    4.690741] calling  bpf_lwt_init+0x0/0x16 @ 1
[    4.692314] initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
[    4.692457] calling  pktsched_init+0x0/0x10f @ 1
[    4.693988] initcall pktsched_init+0x0/0x10f returned 0 after 0 usecs
[    4.696457] calling  tc_filter_init+0x0/0xf7 @ 1
[    4.697982] initcall tc_filter_init+0x0/0xf7 returned 0 after 0 usecs
[    4.700457] calling  tc_action_init+0x0/0x69 @ 1
[    4.702059] initcall tc_action_init+0x0/0x69 returned 0 after 0 usecs
[    4.704457] calling  genl_init+0x0/0x36 @ 1
[    4.705846] initcall genl_init+0x0/0x36 returned 0 after 0 usecs
[    4.708457] calling  cipso_v4_init+0x0/0x63 @ 1
[    4.709979] initcall cipso_v4_init+0x0/0x63 returned 0 after 0 usecs
[    4.712457] calling  wireless_nlevent_init+0x0/0x3a @ 1
[    4.714288] initcall wireless_nlevent_init+0x0/0x3a returned 0 after 0 usecs
[    4.716457] calling  netlbl_init+0x0/0x79 @ 1
[    17922] NetLabel: Initializing
[    4.720456] NetLabel:  domain hash size = 128
[    4.724456] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    4.726487] NetLabel:  unlabeled traffic allowed by default
[    4.728457] initcall netlbl_init+0x0/0x79 returned 0 after 11718 usecs
[    4.730651] calling  xen_mcfg_late+0x0/0xb3 @ 1
[    4.732457] initcall xen_mcfg_late+0x0/0xb3 returned 0 after 0 usecs
[    4.734566] calling  watchdog_init+0x0/0x88 @ 1
[    4.736476] initcall watchdog_init+0x0/0x88 returned 0 after 0 usecs
[    4.738694] calling  xen_p2m_debugfs+0x0/0x45 @ 1
[    4.738694] initcall xen_p2m_debugfs+0x0/0x45 returned 0 after 0 usecs
[    4.738694] calling  nmi_warning_debugfs+0x0/0x27 @ 1
[    4.740459] initcall nmi_warning_debugfs+0x0/0x27 returned 0 after 0 usecs
[    4.742791] calling  save_microcode_in_initrd+0x0/0x78 @ 1
[    4.744467] initcall save_microcode_in_initrd+0x0/0x78 returned 0 after 0 usecs
[    4.746900] calling  hpet_late_init+0x0/0x104 @ 1
[    4.748462] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    4.750196] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    4.754468] initcall hpet_late_init+0x0/0x104 returned 0 after 7812 usecs
[    4.756457] calling  init_amd_nbs+0x0/0xeb @ 1
[    4.758047] initcall init_amd_nbs+0x0/0xeb returned 0 after 0 usecs
[    4.760457] calling  uv_ptc_init+0x0/0xb4 @ 1
[    4.761866] initcall uv_ptc_init+0x0/0xb4 returned 0 after 0 usecs
[    4.764457] calling  sugov_register+0x0/0x11 @ 1
[    4.765999] initcall sugov_register+0x0/0x11 returned 0 after 0 usecs
[    4.768098] calling  clocksource_done_booting+0x0/0x42 @ 1
[    4.772491] clocksource: Switched to clocksource tsc-early
[    4.774355] initcall clocksource_done_booting+0x0/0x42 returned 0 after 1826 usecs
[    4.776955] calling  tracer_init_tracefs+0x0/0x1c6 @ 1
[    4.796203] initcall tracer_init_tracefs+0x0/0x1c6 returned 0 after 17141 usecs
[    4.798712] calling  init_trace_printk_function_export+0x0/0x2d @ 1
[    4.800772] initcall init_trace_printk_function_export+0x0/0x2d returned 0 after 1 usecs
[    4.803432] calling  init_graph_tracefs+0x0/0x2d @ 1
[    4.805166] initcall init_graph_tracefs+0x0/0x2d returned 0 after 1 usecs
[    4.807437] calling  trace_events_hist_init+0x0/0x49 @ 1
[    4.809197] initcall trace_events_hist_init+0x0/0x49 returned 0 after 1 usecs
[    4.811594] calling  init_kprobe_trace+0x0/0x8a @ 1
[    4.813205] initcall init_kprobe_trace+0x0/0x8a returned 0 after 2 usecs
[    4.815410] calling  init_uprobe_trace+0x0/0x4f @ 1
[    4.817146] initcall init_uprobe_trace+0x0/0x4f returned 0 after 5 usecs
[    4.819348] calling  bpf_init+0x0/0x48 @ 1
[    4.820781] initcall bpf_init+0x0/0x48 returned 0 after 4 usecs
[    4.822715] calling  init_pipe_fs+0x0/0x47 @ 1
[    4.824194] initcall init_pipe_fs+0x0/0x47 returned 0 after 12 usecs
[    4.826329] calling  cgroup_writeback_init+0x0/0x2b @ 1
[    4.828164] initcall cgroup_writeback_init+0x0/0x2b returned 0 after 41 usecs
[    4.830562] calling  inotify_user_setup+0x0/0x48 @ 1
[    4.832252] initcall inotify_user_setup+0x0/0x48 returned 0 after 20 usecs
[    4.834519] calling  eventpoll_init+0x0/0xa4 @ 1
[    4.836150] initcall eventpoll_init+0x0/0xa4 returned 0 after 10 usecs
[    4.838330] calling  anon_inode_init+0x0/0x5b @ 1
[    4.839925] initcall anon_inode_init+0x0/0x5b returned 0 after 6 usecs
[    4.842067] calling  init_dax_wait_table+0x0/0x40 @ 1
[    4.843744] initcall init_dax_wait_table+0x0/0x40 returned 0 after 17 usecs
[    4.846146] calling  proc_locks_init+0x0/0x28 @ 1
[    4.847775] initcall proc_locks_init+0x0/0x28 returned 0 after 2 usecs
[    4.849928] calling  dquot_init+0x0/0x11d @ 1
[    4.851407] VFS: Disk quotas dquot_6.6.0
[    4.852763] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.855028] initcall dquot_init+0x0/1d returned 0 after 3535 usecs
[    4.957314] calling  quota_init+0x0/0x24 @ 1
[    4.959042] initcall quota_init+0x0/0x24 returned 0 after 9 usecs
[    4.961090] calling  proc_cmdline_init+0x0/0x22 @ 1
[    4.962740] initcall proc_cmdline_init+0x0/0x22 returned 0 after 1 usecs
[    4.964908] calling  proc_consoles_init+0x0/0x25 @ 1
[    4.966699] initcall proc_consoles_init+0x0/0x25 returned 0 after 1 usecs
[    4.968950] calling  proc_cpuinfo_init+0x0/0x1f @ 1
[    4.970569] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 0 usecs
[    4.972791] calling  proc_devices_init+0x0/0x25 @ 1
[    4.974408] initcall proc_devices_init+0x0/0x25 returned 0 after 0 usecs
[    4.976697] calling  proc_interrupts_init+0x0/0x25 @ 1
[    4.978393] initcall proc_interrupts_init+0x0/0x25 returned 0 after 1 usecs
[    4.980717] calling  proc_loadavg_init+0x0/0x22 @ 1
[    4.982282] initcall proc_loadavg_init+0x0/0x22 returned 0 after 0 usecs
[    4.984459] calling  proc_meminfo_init+0x0/0x22 @ 1
[    4.986199] initcall proc_meminfo_init+0x0/0x22 returned 0 after 0 usecs
[    4.988402] calling  proc_stat_init+0x0/0x1f @ 1
[    4.989952] initcall proc_stat_init+0x0/0x1f returned 0 after 1 usecs
[    4.992059] calling  proc_uptime_init+0x0/0x22 @ 1
[    4.993615] initcall proc_uptime_init+0x0/0x22 returned 0 after 0 usecs
[    4.995889] calling  proc_version_init+0x0/0x22 @ 1
[    4.997514] initcall proc_version_init+0x0/0x22 returned 0 after 0 usecs
[    4.999741] calling  proc_softirqs_init+0x0/0x22 @ 1
[    5.001394] initcall proc_softirqs_init+0x0/0x22 returned 0 after 0 usecs
[    5.003701] calling  proc_kcore_init+0x0/0xd0 @ 1
[    5.005289] initcall proc_kcore_init+0x0/0xd0 returned 0 after 4 usecs
[    5.007461] calling  vmcore_init+0x0/0x540 @ 1
[    5.008962] initcall vmcore_init+0x0/0x540 returned 0 after 0 usecs
[    5.011027] calling  proc_kmsg_init+0x0/0x22 @ 1
[    5.012584] initcall proc_kmsg_init+0x0/0x22 returned 0 after 1 usecs
    5.043354] initcall proc_page_init+0x0/0x56 returned 0 after 6 usecs
[    5.118462] calling  init_ramfs_fs+0x0/0x20 @ 1
[    5.119992] initcall init_ramfs_fs+0x0/0x20 returned 0 after 0 usecs
[    5.122142] calling  init_hugetlbfs_fs+0x0/0x17e @ 1
[    5.123820] initcall init_hugetlbfs_fs+0x0/0x17e returned 0 after 28 usecs
[    5.126178] calling  tomoyo_initerface_init+0x0/0x178 @ 1
[    5.127997] initcall tomoyo_initerface_init+0x0/0x178 returned 0 after 0 usecs
[    5.130666] calling  aa_create_aafs+0x0/0x386 @ 1
[    5.132328] AppArmor: AppArmor Filesystem Enabled
[    5.133990] initcall aa_create_aafs+0x0/0x386 returned 0 after 1724 usecs
[    5.136685] calling  blk_scsi_ioctl_init+0x0/0x399 @ 1
[    5.138381] initcall blk_scsi_ioctl_init+0x0/0x399 returned 0 after 0 usecs
[    5.140720] calling  dynamic_debug_init_debugfs+0x0/0x62 @ 1
[    5.142570] initcall dynamic_debug_init_debugfs+0x0/0x62 returned 0 after 5 usecs
[    5.145035] calling  acpi_event_init+0x0/0x2d @ 1
[    5.146704] initcall acpi_event_init+0x0/0x2d returned 0 after 3 usecs
[    5.149249] calling  pnp_system_init+0x0/0x11 @ 1
[    5.150870] initcall pnp_system_init+0x0/0x11 returned 0 after 14 usecs
[    5.153037] calling  pnpacpi_init+0x0/0x6a @ 1
[    5.154535] pnp: PnP ACPI init
[    5.159399] system 00:00: [io  0x0379-0x037a] has been reserved
[    5.161469] system 00:00: [io  0x0400-0x043f] has been reserved
[    5.163444] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    5.165429] system 00:00: [io  0x04d6] has been reserved
[    5.167282] system 00:00: [io  0x0520] has been reserved
[    5.169046] system 00:00: [io  0x0580-0x059f] has been reserved
[    5.171047] system 00:00: [io  0x0600-0x067f] has been reserved
[    5.173009] system 00:00: [io  0x0700-0x0703] has been reserved
[    5.174977] system 00:00: [io  0x0820-0x082f] has been reserved
[    5.176982] system 00:00: [io  0x0900-0x09fe] has been reserved
[    5.178921] system 00:00: [io  0x0c06-0x0c07] has been reserved
[    5.180902] system 00:00: [io  0x0c14] has been reserved
[    5.182837] system 00:00: [io  0x0c4a] has been reserved
[    5.184668] system 00:00: [io  0x0c50-0x0c52] has been reserved
[    5.186721] system 00:00: [io  0x0c6c] has been reserved
[    5.188501] system 00:00: [io  0x0c6f] has been reserved
[    5.190243] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    5.192232] system 00:00: [io  0x0c90-0x0c9f] has been reserved
[    5.194216] system 00:00: [io  0x0ca0-0x0ca5] could not be reserved
[    5.196345] system 00:00: [io  0x0cd0-0x0cdf] has been reserved
[    5.198355] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    5.200378] system 00:00: [io  0x0b00-0x0b3f] has been reserved
[    5.202279] system 00:00: [io  0x03f8-0x03ff] has been reserved
[    5.204269] system 00:00: [mem 0xc0000000-0xcfffffff] has been reserved
[    5.206501] probe of 00:00 returned 1 after 47111 usecs
[    5.208428] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    5.210820] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    5.213043] pnp 00:02:ug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    5.315918] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    5.318359] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    5.320740] system 00:05: [mem 0xfaff4000-0xfaff7fff] could not be reserved
[    5.323053] probe of 00:05 returned 1 after 2318 usecs
[    5.324773] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    5.327136] pnp: PnP ACPI: found 6 devices
[    5.328539] initcall pnpacpi_init+0x0/0x6a returned 0 after 169924 usecs
[    5.330771] calling  chr_dev_init+0x0/0xa7 @ 1
[    5.334352] initcall chr_dev_init+0x0/0xa7 returned 0 after 2069 usecs
[    5.336687] calling  firmware_class_init+0x0/0xeb @ 1
[    5.338355] initcall firmware_class_init+0x0/0xeb returned 0 after 5 usecs
[    5.340650] calling  thermal_init+0x0/0xe1 @ 1
[    5.342137] initcall thermal_init+0x0/0xe1 returned 0 after 9 usecs
[    5.344236] calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
[    5.346299] initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
[    5.348881] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[    5.350597] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 0 usecs
[    5.352907] calling  map_properties+0x0/0x506 @ 1
[    5.354443] initcall map_properties+0x0/0x506 returned 0 after 0 usecs
[    5.356730] calling  init_acpi_pm_clocksource+0x0/0xdb @ 1
[    5.363109] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    5.366210] initcall init_acpi_pm_clocksource+0x0/0xdb returned 0 after 7415 usecs
[    5.368751] calling  pcibios_assign_resources+0x0/0xc0 @ 1
[    5.370583] pci 0000:00:0c.0: BAR 14: assigned [mem 0xfc000000-0xfc0fffff]
[    5.372836] pci 0000:03:00.0: BAR 6: assigned [mem 0xfde00000-0xfde7ffff pref]
[    5.375264] pci 0000:00:02.0: PCI bridge to [bus 03]
[    5.377023] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    5.379016] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    5.381229] pci 0000:02:00.2: BAR 6: assigned [mem 0xfcd00000-0xfcd0ffff pref]
[    5.383582] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    5.385315] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    5.387360] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    5.389877] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    5.392421] pci 0000:04:00.0: BAR 6: assigned [mem 0xfc000000-0xfc03ffff pref]
[    5.394836] pci 0000:04:00.1: BAR 6: assigned [mem 0xfc040000-0xfc07ffff pref]
[    5.397298] pci 0000:04:00.2: BAR 6: assigned [mem 0xfc080000-0xfc0bffff pref]
[    5.399747] pci 0000:04:00.3: BAR 6: assigned [mem 0xfc0c0000-0xfc0fffff pref]
[    5.402072] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    5.403615] pci 0000:00:0c.0:   bridge window [mem 0xfc000000-0xfc0fffff]
[    5.405820] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    5.408378] pci 0000:00:14.4: PCI bridge to [bus 01]
[    5.410081] pci_bus 0000:00: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    5.412357] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
[    5.414404] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[    5.416592] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[    5.418656] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
[    5.420710] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff windo
                                                                           [    5.522927] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff window]
[    5.525321] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb window]
[    5.527454] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df window]
[    5.529533] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
[    5.531851] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    5.533800] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdffffff]
[    5.535942] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    5.537753] pci_bus 0000:02: resource 1 [mem 0xfcd00000-0xfddfffff]
[    5.539847] pci_bus 0000:02: resource 2 [mem 0xfb000000-0xfbffffff 64bit pref]
[    5.542237] pci_bus 0000:04: resource 1 [mem 0xfc000000-0xfc0fffff]
[    5.544321] pci_bus 0000:04: resource 2 [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    5.546727] pci_bus 0000:01: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    5.549048] pci_bus 0000:01: resource 5 [io  0x1000-0xffff window]
[    5.551126] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
[    5.553166] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
[    5.555232] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
[    5.557352] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed03fff window]
[    5.559677] pci_bus 0000:01: resource 10 [mem 0xfed40000-0xfed44fff window]
[    5.561989] pci_bus 0000:01: resource 11 [io  0x03b0-0x03bb window]
[    5.564076] pci_bus 0000:01: resource 12 [io  0x03c0-0x03df window]
[    5.566210] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
[    5.568633] initcall pcibios_assign_resources+0x0/0xc0 returned 0 after 193428 usecs
[    5.571239] calling  sysctl_core_init+0x0/0x2b @ 1
[    5.572897] initcall sysctl_core_init+0x0/0x2b returned 0 after 13 usecs
[    5.575162] calling  eth_offload_init+0x0/0x14 @ 1
[    5.576818] initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
[    5.578963] calling  ipv4_offload_init+0x0/0x74 @ 1
[    5.580475] initcall ipv4_offload_init+0x0/0x74 returned 0 after 0 usecs
[ 5.582684] calling  inet_init+0x0/0x272 @ 1
[    5.684194] NET: Registered protocol family 2
[    5.685979] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
[    5.688853] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    5.691888] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    5.694370] TCP: Hash tables configured (established 262144 bind 65536)
[    5.696878] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    5.699193] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    5.701654] initcall inet_init+0x0/0x272 returned 0 after 17099 usecs
[    5.703810] calling  af_unix_init+0x0/0x4e @ 1
[    5.705301] NET: Registered protocol family 1
[    5.706837] initcall af_unix_init+0x0/0x4e returned 0 after 1508 usecs
[    5.709344] calling  ipv6_offload_init+0x0/0x7f @ 1
[    5.711049] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
[    5.713200] calling  xsk_init+0x0/0x3c @ 1
[    5.714640] NET: Registered protocol family 44
[    5.716183] initcall xsk_init+0x0/0x3c returned 0 after 1506 usecs
[    5.718219] calling  pci_apply_final_quirks+0x0/0xfa @ 1
[    5.719998] pci 0000:00:11.0: calling  quirk_msi_intx_disable_ati_bug+0x0/0x40 @ 1
[    5.722509] pci 0000:00:11.0: quirk_msi_intx_disable_ati_bug+0x0/0x40 took 2 usecs
[    5.725047] pci 0000:00:12.0: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    5.727677] PCI Interrupt Link [USB1] enabled at IRQ 22
[    5.808633] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x693 took 79300 usecs
[    5.811131] pci 0000:00:12.1: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    5.892627] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x693 took 77253 usecs
[    5.895188] pci 0000:00:12.2: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    5.897804] PCI Interrupt Link [USB2] enabled at IRQ 23
[    5.916644] pci 0000:00:12.2: quirk_usb_early_handoff+0x0/0x693 took 18592 usecs
[    5.919116] pci 0000:00:13.0: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    5.921632] PCI Interrupt Link [USB3] enabled at IRQ 23
[    6.000628] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x693 took 77339 usecs
[    6.003168] pci 0000:00:13.1: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    6.084845] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x693 took 77355 usecs
[    6.087436] pci 0000:00:13.2: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    6.089998] PCI Interrupt Link [USB4] enabled at IRQ 22
[    6.108633] pci 0000:00:13.2: quirk_usb_early_handoff+0x0/0x693 took 18397 usecs
[    6.111176] pci 0000:00:18.0: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.113295] pci 0000:00:18.0: quirk_amd_nb_node+0x0/0x80 took 1 usecs
[    6.115432] pci 0000:00:18.1: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.117659] pci 0000:00:18.1: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.119768] pci 0000:00:18.1: calling  pci_amd_enable_64bit_bar+0x0/0x1e3 @ 1
[    6.122133] pci 0000:00:18.1: pci_amd_enable_64bit_bar+0x0/0x1e3 took 0 usecs
[    6.124443] pci 0000:00:18.2: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.126671] pci 0000:00:18.2: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.128762] pci 0000:00:18.3: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.130878] pci 0000:00:18.3: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.132989] pci 0000:00:18.4: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.135171] pci 0000:00:18.4: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.137401] pci 0000:00:18.5: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.139540] pci 0000:00:18.5: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.141648] pci 0000:00:19.0: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.143794] pci 0000:00:19.0: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.146034] pci 0000:00:19.1: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.148171] pci 0000:00:19.1: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.150298] pci 0000:00:19.1: calling  pci_amd_enable_64bit_bar+0x0/0x1e3 @ 1
[    6.152681] pci 0000:00:19.1: pci_amd_enable_64bit_bar+0x0/0x1e3 took 0 usecs
[    6.155060] pci 0000:00:19.2: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.157262] pci 0000:00:19.2: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.159431] pci 0000:00:19.3: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.161542] pci 0000:00:19.3: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.163642] pci 0000:00:19.4: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.165885] pci 0000:00:19.4: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    68035] pci 0000:00:19.5: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.270291] pci 0000:00:19.5: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.272533] pci 0000:02:00.1: calling  pci_fixup_video+0x0/0xe0 @ 1
[    6.274649] pci 0000:02:00.1: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.277423] pci 0000:02:00.1: pci_fixup_video+0x0/0xe0 took 2713 usecs
[    6.279642] pci 0000:02:00.4: calling  quirk_usb_early_handoff+0x0/0x693 @ 1
[    6.282251] PCI Interrupt Link [BI0A] enabled at IRQ 24
[    6.284468] PCI Interrupt Link [I061] enabled at IRQ 44
[    6.286404] pci 0000:02:00.4: quirk_usb_early_handoff+0x0/0x693 took 4280 usecs
[    6.289038] PCI: CLS 64 bytes, default 64
[    6.290395] initcall pci_apply_final_quirks+0x0/0xfa returned 0 after 557043 usecs
[    6.292945] calling  acpi_reserve_resources+0x0/0xeb @ 1
[    6.294669] initcall acpi_reserve_resources+0x0/0xeb returned 0 after 3 usecs
[    6.297186] calling  populate_rootfs+0x0/0x10a @ 1
[    6.298835] Unpacking initramfs...
[    7.788204] Freeing initrd memory: 16988K
[    7.789813] initcall populate_rootfs+0x0/0x10a returned 0 after 1456069 usecs
[    7.792196] calling  pci_iommu_init+0x0/0x3f @ 1
[    7.794181] pci 0000:00:00.2: can't derive routing for PCI INT A
[    7.796320] pci 0000:00:00.2: PCI INT A: no GSI
[    7.798193] iommu: Adding device 0000:00:00.0 to group 0
[    7.800198] iommu: Adding device 0000:00:02.0 to group 1
[    7.802144] iommu: Adding device 0000:00:0a.0 to group 2
[    7.804126] iommu: Adding device 0000:00:0c.0 to group 3
[    7.806162] iommu: Adding device 0000:00:11.0 to group 4
[    7.808110] iommu: Adding device 0000:00:12.0 to group 5
[    7.809976] iommu: Adding device 0000:00:12.1 to group 5
[    7.811787] iommu: Adding device 0000:00:12.2 to group 5
[    7.813766] iommu: Adding device 0000:00:13.0 to group 6
[    7.815678] iommu: Adding device 0000:00:13.1 to group 6
[    7.817510] iommu: Adding device 0000:00:13.2 to group 6
[    7.819403] iommu: Adding device 0000:00:14.0 to group 7
[    7.821449] iommu: Adding device 0000:00:14.1 to group 8
[    7.823439] iommu: Adding device 0000:00:14.3 to group 9
[    7.825382] iommu: Adding device 0000:00:14.4 to group 10
[    7.827422] iommu: Adding device 0000:03:00.0 to group 11
[    7.829413] iommu: Adding device 0000:02:00.0 to group 12
[    7.831240] iommu: Adding device 0000:02:00.1 to group 12
[    7.833117] iommu: Adding device 0000:02:00.2 to group 12
[    7.834987] iommu: Adding device 0000:02:00.4 to group 12
[    7.837062] iommu: Adding device 0000:04:00.0 to group 13
[    7.838921] iommu: Adding device 0000:04:00.1 to group 13
[    7.840759] iommu: Adding device 0000:04:00.2 to group 13
[    7.842593] iommu: Adding device 0000:04:00.3 to group 13
[    7.881966] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    7.883884] AMD-Vi: Interrupt remapping enabled
[    7.885662] AMD-Vi: Lazy IO/TLB flushing enabled
[    7.889649] initcall pci_iommu_init+0x0/0x3f returned 0 after 93638 usecs
[    7.892011] calling  calgary_fixup_tce_spaces+0x0/0xf1 @ 1
[    7.893814] initcall calgary_fixup_tce_spaces+0x0/0xf1 returned -19 after 0 usecs
[    7.896405] calling  ir_dev_scope_init+0x0/0x33 @ 1
[    7.898058] initcall ir_dev_scope_init+0x0/0x33 returned -19 after 0 usecs
[    7.900390] calling  ia32_binfmt_init+0x0/0x14 @ 1
[    7.902113] initcall ia32_binfmt_init+0x0/0x14 returned 0 after 3 usecs
[    7.904296] calling  amd_uncore_init+0x0/0x275 @ 1
[    7.905998] amd_uncore: AMD NB counters detected
[    7.907811] initcall amd_uncore_init+0x0/0x275 returned 0 after 1775 usecs
[    7.910097] calling  amd_ibs_init+0x0/0x1b5 @ 1
[    7.911632] LVT offset 0 assigned for vector 0x400
[    7.913373] perf: AMD IBS detected (0x000000ff)
[    7.914934] initcall amd_ibs_init+0x0/0x1b5 returned 0 after 3224 usecs
[    7.917207] calling  amd_iommu_pc_init+0x0/0x248 @ 1
[    7.918871] initcall amd_iommu_pc_init+0x0/0x248 returned -19 after 0 usecs
[    7.921170] calling  msr_init+0x0/0xc6 @ 1
[    7.922526] initcall msr_init+0x0/0xc6 returned 0 after 2 usecs
[    7.924484] calling  rapl_pmu_init+0x0/0x20b @ 1
[    7.926152] initcall rapl_pmu_init+0x0/0x20b returned -19 after 0 usecs
[    7.928314] calling  intel_uncore_init+0x0/0x227 @ 1
[    7.930016] initcall intel_uncore_init+0x0/0x227 returned -19 after 0 usecs
[    7.932293] calling  cstate_pmu_init+0x0/0x16f @ 1
[    7.933892] initcall cstate_pmu_init+0x0/0x16f returned -19 after 0 usecs
[    7.936177] calling  register_kernel_offset_dumper+0x0/0x1b @ 1
[    7.938120] initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
[    7.940708] calling  i8259A_init_ops+0x0/0x21 @ 1
[    7.942257] initcall i8259A_init_ops+0x0/0x21 returned 0 after 0 usecs
[    7.944435] calling  init_tsc_clocksource+0x0/0xb1 @ 1
[    7.946193] initcall init_tsc_clocksource+0x0/0xb1 returned 0 after 1 usecs
[    7.948567] calling  add_rtc_cmos+0x0/0xcd @ 1
[    49990] initcall add_rtc_cmos+0x0/0xcd returned 0 after 2 usecs
[    8.052124] calling  i8237A_init_ops+0x0/0x37 @ 1
[    8.053726] initcall i8237A_init_ops+0x0/0x37 returned 0 after 1 usecs
[    8.055997] calling  thermal_throttle_init_device+0x0/0x42 @ 1
[    8.057898] initcall thermal_throttle_init_device+0x0/0x42 returned 0 after 0 usecs
[    8.060449] calling  ioapic_init_ops+0x0/0x14 @ 1
[    8.062006] initcall ioapic_init_ops+0x0/0x14 returned 0 after 0 usecs
[    8.064100] calling  register_e820_pmem+0x0/0x42 @ 1
[    8.065836] initcall register_e820_pmem+0x0/0x42 returned 0 after 3 usecs
[    8.068056] calling  add_pcspkr+0x0/0x4a @ 1
[    8.069494] initcall add_pcspkr+0x0/0x4a returned 0 after 25 usecs
[    8.071509] calling  start_periodic_check_for_corruption+0x0/0x30 @ 1
[    8.073691] Scanning for low memory corruption every 60 seconds
[    8.075760] initcall start_periodic_check_for_corruption+0x0/0x30 returned 0 after 2019 usecs
[    8.078608] calling  sysfb_init+0x0/0x7a @ 1
[    8.080030] initcall sysfb_init+0x0/0x7a returned 0 after 16 usecs
[    8.082078] calling  audit_classes_init+0x0/0xaf @ 1
[    8.083739] initcall audit_classes_init+0x0/0xaf returned 0 after 4 usecs
[    8.086071] calling  iosf_mbi_init+0x0/0x1a @ 1
[    8.087614] initcall iosf_mbi_init+0x0/0x1a returned 0 after 21 usecs
[    8.089716] calling  sgi_uv_sysfs_init+0x0/0xa8 @ 1
[    8.091338] initcall sgi_uv_sysfs_init+0x0/0xa8 returned -19 after 0 usecs
[    8.093571] calling  proc_execdomains_init+0x0/0x22 @ 1
[    8.095473] initcall proc_execdomains_init+0x0/0x22 returned 0 after 2 usecs
[    8.097791] calling  register_warn_debugfs+0x0/0x24 @ 1
[    8.099579] initcall register_warn_debugfs+0x0/0x24 returned 0 after 7 usecs
[    8.101918] calling  cpuhp_sysfs_init+0x0/0x8c @ 1
[    8.103478] initcall cpuhp_sysfs_init+0x0/0x8c returned 0 after 23 usecs
[    8.105723] calling  ioresources_init+0x0/0x4a @ 1
[    8.107357] initcall ioresources_init+0x0/0x4a returned 0 after 2 usecs
[    8.109868]lling  init_sched_debug_procfs+0x0/0x2f @ 1
[    8.211731] initcall init_sched_debug_procfs+0x0/0x2f returned 0 after 7 usecs
[    8.214147] calling  snapshot_device_init+0x0/0x11 @ 1
[    8.216035] initcall snapshot_device_init+0x0/0x11 returned 0 after 50 usecs
[    8.218417] calling  irq_gc_init_ops+0x0/0x14 @ 1
[    8.219999] initcall irq_gc_init_ops+0x0/0x14 returned 0 after 0 usecs
[    8.222140] calling  irq_pm_init_ops+0x0/0x14 @ 1
[    8.223771] initcall irq_pm_init_ops+0x0/0x14 returned 0 after 0 usecs
[    8.225993] calling  klp_init+0x0/0x29 @ 1
[    8.227415] initcall klp_init+0x0/0x29 returned 0 after 1 usecs
[    8.229359] calling  timekeeping_init_ops+0x0/0x14 @ 1
[    8.231074] initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
[    8.233362] calling  init_clocksource_sysfs+0x0/0x24 @ 1
[    8.235151] initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 30 usecs
[    8.237960] calling  init_timer_list_procfs+0x0/0x32 @ 1
[    8.239757] initcall init_timer_list_procfs+0x0/0x32 returned 0 after 0 usecs
[    8.242140] calling  alarmtimer_init+0x0/0x10f @ 1
[    8.243758] probe of alarmtimer returned 1 after 8 usecs
[    8.245596] initcall alarmtimer_init+0x0/0x10f returned 0 after 1825 usecs
[    8.247848] calling  init_posix_timers+0x0/0x2a @ 1
[    8.249562] initcall init_posix_timers+0x0/0x2a returned 0 after 19 usecs
[    8.251788] calling  clockevents_init_sysfs+0x0/0xc9 @ 1
[    8.253659] initcall clockevents_init_sysfs+0x0/0xc9 returned 0 after 114 usecs
[    8.256323] calling  proc_dma_init+0x0/0x22 @ 1
[    8.257856] initcall proc_dma_init+0x0/0x22 returned 0 after 1 usecs
[    8.259950] calling  proc_modules_init+0x0/0x1f @ 1
[    8.261588] initcall proc_modules_init+0x0/0x1f returned 0 after 1 usecs
[    8.263801] calling  kallsyms_init+0x0/0x22 @ 1
[    8.265457] initcall kallsyms_init+0x0/0x22 returned 0 after 1 usecs
[    8.267543] calling  pid_namespaces_init+0x0/0x40 @ 1
[    8.269260] initcall pid_namespaces_init+0x0/0x40 returned 0 ar 5 usecs
[    8.371558] calling  ikconfig_init+0x0/0x3b @ 1
[    8.373130] initcall ikconfig_init+0x0/0x3b returned 0 after 1 usecs
[    8.375253] calling  audit_watch_init+0x0/0x3c @ 1
[    8.376964] initcall audit_watch_init+0x0/0x3c returned 0 after 0 usecs
[    8.379138] calling  audit_fsnotify_init+0x0/0x3c @ 1
[    8.380832] initcall audit_fsnotify_init+0x0/0x3c returned 0 after 0 usecs
[    8.383120] calling  audit_tree_init+0x0/0x4d @ 1
[    8.384701] initcall audit_tree_init+0x0/0x4d returned 0 after 1 usecs
[    8.386907] calling  init_kprobes+0x0/0x1a3 @ 1
[    8.388649] initcall init_kprobes+0x0/0x1a3 returned 0 after 219 usecs
[    8.390887] calling  seccomp_sysctl_init+0x0/0x2c @ 1
[    8.392612] initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 3 usecs
[    8.395197] calling  utsname_sysctl_init+0x0/0x14 @ 1
[    8.396950] initcall utsname_sysctl_init+0x0/0x14 returned 0 after 5 usecs
[    8.399246] calling  init_tracepoints+0x0/0x28 @ 1
[    8.400822] initcall init_tracepoints+0x0/0x28 returned 0 after 0 usecs
[    8.402946] calling  init_lstats_procfs+0x0/0x22 @ 1
[    8.404606] initcall init_lstats_procfs+0x0/0x22 returned 0 after 0 usecs
[    8.406946] calling  stack_trace_init+0x0/0xb0 @ 1
[    8.408539] initcall stack_trace_init+0x0/0xb0 returned 0 after 9 usecs
[    8.410694] calling  init_blk_tracer+0x0/0x50 @ 1
[    8.412316] initcall init_blk_tracer+0x0/0x50 returned 0 after 8 usecs
[    8.414438] calling  perf_event_sysfs_init+0x0/0x84 @ 1
[    8.416349] initcall perf_event_sysfs_init+0x0/0x84 returned 0 after 130 usecs
[    8.418768] calling  init_uprobes+0x0/0x71 @ 1
[    8.420244] initcall init_uprobes+0x0/0x71 returned 0 after 2 usecs
[    8.422382] calling  padata_driver_init+0x0/0x39 @ 1
[    8.424013] initcall padata_driver_init+0x0/0x39 returned 0 after 0 usecs
[    8.426379] calling  system_trusted_keyring_init+0x0/0xf3 @ 1
[    8.428336] Initialise system trusted keyrings
[    8.429783] initcall system_trusted_keyring_init+0x0/0xf3 returned 0 after 1411 usecs
[    8.432416] calling  blacklist_init+0x0/0xa0 @ 1
[    83943] Key type blacklist registered
[    8.535455] initcall blacklist_init+0x0/0xa0 returned 0 after 99132 usecs
[    8.537747] calling  kswapd_init+0x0/0x8c @ 1
[    8.539238] initcall kswapd_init+0x0/0x8c returned 0 after 47 usecs
[    8.541378] calling  extfrag_debug_init+0x0/0x78 @ 1
[    8.543019] initcall extfrag_debug_init+0x0/0x78 returned 0 after 7 usecs
[    8.545358] calling  mm_compute_batch_init+0x0/0x19 @ 1
[    8.547124] initcall mm_compute_batch_init+0x0/0x19 returned 0 after 0 usecs
[    8.549458] calling  slab_proc_init+0x0/0x22 @ 1
[    8.550994] initcall slab_proc_init+0x0/0x22 returned 0 after 2 usecs
[    8.553151] calling  workingset_init+0x0/0x8e @ 1
[    8.554796] workingset: timestamp_bits=37 max_order=23 bucket_order=0
[    8.557003] initcall workingset_init+0x0/0x8e returned 0 after 2154 usecs
[    8.559299] calling  proc_vmalloc_init+0x0/0x30 @ 1
[    8.560907] initcall proc_vmalloc_init+0x0/0x30 returned 0 after 1 usecs
[    8.563140] calling  procswaps_init+0x0/0x1f @ 1
[    8.564735] initcall procswaps_init+0x0/0x1f returned 0 after 0 usecs
[    8.566931] calling  init_frontswap+0x0/0x91 @ 1
[    8.568497] initcall init_frontswap+0x0/0x91 returned 0 after 6 usecs
[    8.570632] calling  cpucache_init+0x0/0x35 @ 1
[    8.572251] initcall cpucache_init+0x0/0x35 returned 0 after 110 usecs
[    8.574477] calling  slab_proc_init+0x0/0x8 @ 1
[    8.576053] initcall slab_proc_init+0x0/0x8 returned 0 after 0 usecs
[    8.578148] calling  init_cleancache+0x0/0x91 @ 1
[    8.579718] initcall init_cleancache+0x0/0x91 returned 0 after 8 usecs
[    8.581905] calling  init_zbud+0x0/0x20 @ 1
[    8.583311] zbud: loaded
[    8.584162] initcall init_zbud+0x0/0x20 returned 0 after 829 usecs
[    8.586335] calling  zs_init+0x0/0x74 @ 1
[    8.587593] initcall zs_init+0x0/0x74 returned 0 after 11 usecs
[    8.589551] calling  fcntl_init+0x0/0x2a @ 1
[    8.590981] initcall fcntl_init+0x0/0x2a returned 0 after 1 usecs
[    8.592984] calling  proc_filesystems_init+0x0/0x@ 1
[    8.694781] initcall proc_filesystems_init+0x0/0x22 returned 0 after 1 usecs
[    8.697166] calling  start_dirtytime_writeback+0x0/0x2a @ 1
[    8.699059] initcall start_dirtytime_writeback+0x0/0x2a returned 0 after 0 usecs
[    8.701539] calling  blkdev_init+0x0/0x20 @ 1
[    8.703059] initcall blkdev_init+0x0/0x20 returned 0 after 5 usecs
[    8.705167] calling  dio_init+0x0/0x2d @ 1
[    8.706620] initcall dio_init+0x0/0x2d returned 0 after 1 usecs
[    8.708895] calling  dnotify_init+0x0/0x79 @ 1
[    8.710431] initcall dnotify_init+0x0/0x79 returned 0 after 13 usecs
[    8.712557] calling  fanotify_user_setup+0x0/0x77 @ 1
[    8.714210] initcall fanotify_user_setup+0x0/0x77 returned 0 after 3 usecs
[    8.716617] calling  userfaultfd_init+0x0/0x2e @ 1
[    8.718210] initcall userfaultfd_init+0x0/0x2e returned 0 after 8 usecs
[    8.720455] calling  aio_setup+0x0/0x7b @ 1
[    8.721853] initcall aio_setup+0x0/0x7b returned 0 after 10 usecs
[    8.723875] calling  fscrypt_init+0x0/0xb5 @ 1
[    8.725639] initcall fscrypt_init+0x0/0xb5 returned 0 after 186 usecs
[    8.727803] calling  init_sys32_ioctl+0x0/0x28 @ 1
[    8.729533] initcall init_sys32_ioctl+0x0/0x28 returned 0 after 66 usecs
[    8.731960] calling  mbcache_init+0x0/0x31 @ 1
[    8.733503] initcall mbcache_init+0x0/0x31 returned 0 after 10 usecs
[    8.735712] calling  init_devpts_fs+0x0/0x28 @ 1
[    8.737256] initcall init_devpts_fs+0x0/0x28 returned 0 after 8 usecs
[    8.739434] calling  ext4_init_fs+0x0/0x1a7 @ 1
[    8.740992] initcall ext4_init_fs+0x0/0x1a7 returned 0 after 58 usecs
[    8.743168] calling  journal_init+0x0/0x10c @ 1
[    8.744717] initcall journal_init+0x0/0x10c returned 0 after 32 usecs
[    8.746868] calling  init_autofs_fs+0x0/0x26 @ 1
[    8.748501] initcall init_autofs_fs+0x0/0x26 returned 0 after 51 usecs
[    8.750706] calling  init_pstore_fs+0x0/0x4d @ 1
[    8.752185] pstore: using deflate compression
[    8.753653] initcall init_pstore_fs+0x0/0x4d returned 0 after 1432 usecs[    8.809973] calling  ipc_init+0x0/0x25 @ 1
[    8.857422] initcall ipc_init+0x0/0x25 returned 0 after 7 usecs
[    8.859434] calling  ipc_sysctl_init+0x0/0x14 @ 1
[    8.861010] initcall ipc_sysctl_init+0x0/0x14 returned 0 after 7 usecs
[    8.863197] calling  init_mqueue_fs+0x0/0xf1 @ 1
[    8.864810] initcall init_mqueue_fs+0x0/0xf1 returned 0 after 24 usecs
[    8.867033] calling  key_proc_init+0x0/0x64 @ 1
[    8.868581] initcall key_proc_init+0x0/0x64 returned 0 after 2 usecs
[    8.870746] calling  selinux_nf_ip_init+0x0/0x49 @ 1
[    8.872353] initcall selinux_nf_ip_init+0x0/0x49 returned 0 after 0 usecs
[    8.874525] calling  init_sel_fs+0x0/0xfb @ 1
[    8.876059] initcall init_sel_fs+0x0/0xfb returned 0 after 0 usecs
[    8.878105] calling  selnl_init+0x0/0x5a @ 1
[    8.879550] initcall selnl_init+0x0/0x5a returned 0 after 7 usecs
[    8.881595] calling  sel_netif_init+0x0/0x3b @ 1
[    8.883111] initcall sel_netif_init+0x0/0x3b returned 0 after 0 usecs
[    8.885353] calling  sel_netnode_init+0x0/0x36 @ 1
[    8.886928] initcall sel_netnode_init+0x0/0x36 returned 0 after 0 usecs
[    8.889181] calling  sel_netport_init+0x0/0x36 @ 1
[    8.890776] initcall sel_netport_init+0x0/0x36 returned 0 after 0 usecs
[    8.892981] calling  aurule_init+0x0/0x2b @ 1
[    8.894448] initcall aurule_init+0x0/0x2b returned 0 after 0 usecs
[    8.896593] calling  crypto_algapi_init+0x0/0xd @ 1
[    8.898195] initcall crypto_algapi_init+0x0/0xd returned 0 after 1 usecs
[    8.900448] calling  seqiv_module_init+0x0/0x11 @ 1
[    8.902117] initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.904320] calling  dh_init+0x0/0x20 @ 1
[    8.905838] initcall dh_init+0x0/0x20 returned 0 after 55 usecs
[    8.907808] calling  rsa_init+0x0/0x50 @ 1
[    8.909193] initcall rsa_init+0x0/0x50 returned 0 after 53 usecs
[    8.911229] calling  hmac_module_init+0x0/0x11 @ 1
[    8.912822] initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.915071] calling  crypto_null_monit+0x0/0x48 @ 1
[    8.972480] tsc: Refined TSC clocksource calibration: 2792.998 MHz
[    9.017161] initcall crypto_null_mod_init+0x0/0x48 returned 0 after 306 usecs
[    9.018962] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28426a4c5eb, max_idle_ns: 440795237780 ns
[    9.021245] calling  md5_mod_init+0x0/0x11 @ 1
[    9.026153] clocksource: Switched to clocksource tsc
[    9.026226] initcall md5_mod_init+0x0/0x11 returned 0 after 81 usecs
[    9.029941] calling  sha1_generic_mod_init+0x0/0x11 @ 1
[    9.031734] initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 54 usecs
[    9.034085] calling  sha256_generic_mod_init+0x0/0x16 @ 1
[    9.035959] initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 78 usecs
[    9.038447] calling  crypto_ecb_module_init+0x0/0x11 @ 1
[    9.040182] initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
[    9.042567] calling  crypto_cbc_module_init+0x0/0x11 @ 1
[    9.044376] initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
[    9.046790] calling  crypto_cts_module_init+0x0/0x11 @ 1
[    9.048561] initcall crypto_cts_module_init+0x0/0x11 returned 0 after 0 usecs
[    9.050917] calling  crypto_module_init+0x0/0x11 @ 1
[    9.052572] initcall crypto_module_init+0x0/0x11 returned 0 after 0 usecs
[    9.054777] calling  crypto_ctr_module_init+0x0/0x3a @ 1
[    9.056619] initcall crypto_ctr_module_init+0x0/0x3a returned 0 after 0 usecs
[    9.058995] calling  crypto_gcm_module_init+0x0/0xb2 @ 1
[    9.060773] initcall crypto_gcm_module_init+0x0/0xb2 returned 0 after 0 usecs
[    9.063080] calling  aes_init+0x0/0x11 @ 1
[    9.064511] initcall aes_init+0x0/0x11 returned 0 after 40 usecs
[    9.066623] calling  crc32c_mod_init+0x0/0x11 @ 1
[    9.068219] initcall crc32c_mod_init+0x0/0x11 returned 0 after 49 usecs
[    9.070471] calling  crct10dif_mod_init+0x0/0x11 @ 1
[    9.072163] initcall crct10dif_mod_init+0x0/0x11 returned 0 after 50 usecs
[    9.074452] calling  lzo_mod_init+0x0/0x3a @ 1
[    9.073] initcall lzo_mod_init+0x0/0x3a returned 0 after 92 usecs
[    9.178318] calling  drbg_init+0x0/0x8b @ 1
[    9.180612] initcall drbg_init+0x0/0x8b returned 0 after 864 usecs
[    9.182788] calling  jent_mod_init+0x0/0x2e @ 1
[    9.184565] initcall jent_mod_init+0x0/0x2e returned 0 after 225 usecs
[    9.186899] calling  ghash_mod_init+0x0/0x11 @ 1
[    9.188513] initcall ghash_mod_init+0x0/0x11 returned 0 after 44 usecs
[    9.190673] calling  zstd_mod_init+0x0/0x3a @ 1
[    9.192261] initcall zstd_mod_init+0x0/0x3a returned 0 after 88 usecs
[    9.194383] calling  asymmetric_key_init+0x0/0x11 @ 1
[    9.196155] Key type asymmetric registered
[    9.197546] initcall asymmetric_key_init+0x0/0x11 returned 0 after 1356 usecs
[    9.199903] calling  x509_key_init+0x0/0x11 @ 1
[    9.201426] Asymmetric key parser 'x509' registered
[    9.203033] initcall x509_key_init+0x0/0x11 returned 0 after 1568 usecs
[    9.205222] calling  proc_genhd_init+0x0/0x42 @ 1
[    9.206835] initcall proc_genhd_init+0x0/0x42 returned 0 after 2 usecs
[    9.209234] calling  bsg_init+0x0/0x125 @ 1
[    9.210709] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    9.213448] initcall bsg_init+0x0/0x125 returned 0 after 2680 usecs
[    9.215547] calling  throtl_init+0x0/0x41 @ 1
[    9.217104] initcall throtl_init+0x0/0x41 returned 0 after 74 usecs
[    9.219213] calling  iolatency_init+0x0/0x11 @ 1
[    9.220780] initcall iolatency_init+0x0/0x11 returned 0 after 0 usecs
[    9.222927] calling  noop_init+0x0/0x11 @ 1
[    9.224340] io scheduler noop registered
[    9.225682] initcall noop_init+0x0/0x11 returned 0 after 1310 usecs
[    9.227789] calling  deadline_init+0x0/0x11 @ 1
[    9.229314] io scheduler deadline registered
[    9.230731] initcall deadline_init+0x0/0x11 returned 0 after 1382 usecs
[    9.232943] calling  cfq_init+0x0/0x74 @ 1
[    9.234339] io scheduler cfq registered (default)
[    9.235956] initcall cfq_init+0x0/0x74 returned 0 after 1596 usecs
[    9.238050] calling  deadline_init+0x0/0x11 @ 1
[    9.239573] io scheduler mq-deadline registered
[    9.241079] initcalladline_init+0x0/0x11 returned 0 after 1470 usecs
[    9.343379] calling  kyber_init+0x0/0x11 @ 1
[    9.344855] io scheduler kyber registered
[    9.346223] initcall kyber_init+0x0/0x11 returned 0 after 1334 usecs
[    9.348418] calling  bfq_init+0x0/0x85 @ 1
[    9.349751] initcall bfq_init+0x0/0x85 returned -28 after 0 usecs
[    9.351833] calling  btree_module_init+0x0/0x25 @ 1
[    9.353475] initcall btree_module_init+0x0/0x25 returned 0 after 2 usecs
[    9.355783] calling  crc_t10dif_mod_init+0x0/0x39 @ 1
[    9.357486] initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 2 usecs
[    9.359766] calling  percpu_counter_startup+0x0/0x51 @ 1
[    9.361623] initcall percpu_counter_startup+0x0/0x51 returned 0 after 104 usecs
[    9.364073] calling  digsig_init+0x0/0x36 @ 1
[    9.365645] initcall digsig_init+0x0/0x36 returned 0 after 1 usecs
[    9.367720] calling  sg_pool_init+0x0/0xc6 @ 1
[    9.369217] initcall sg_pool_init+0x0/0xc6 returned 0 after 18 usecs
[    9.371278] calling  phy_core_init+0x0/0x4a @ 1
[    9.372761] initcall phy_core_init+0x0/0x4a returned 0 after 4 usecs
[    9.374849] calling  crystalcove_pwm_driver_init+0x0/0x13 @ 1
[    9.376773] initcall crystalcove_pwm_driver_init+0x0/0x13 returned 0 after 8 usecs
[    9.379270] calling  pci_proc_init+0x0/0x6c @ 1
[    9.380826] initcall pci_proc_init+0x0/0x6c returned 0 after 43 usecs
[    9.382942] calling  pcie_portdrv_init+0x0/0x35 @ 1
[    9.384831] PCI Interrupt Link [BI02] enabled at IRQ 52
[    9.386673] probe of 0000:00:02.0 returned 1 after 2090 usecs
[    9.388689] probe of 0000:00:0a.0 returned 1 after 35 usecs
[    9.390766] PCI Interrupt Link [BI0C] enabled at IRQ 54
[    9.392583] probe of 0000:00:0c.0 returned 1 after 2047 usecs
[    9.394548] initcall pcie_portdrv_init+0x0/0x35 returned 0 after 9736 usecs
[    9.396883] calling  aer_service_init+0x0/0x32 @ 1
[    9.398497] initcall aer_service_init+0x0/0x32 returned 0 after 5 usecs
[    9.400650] calling  pcie_pme_service_init+0x0/0x11 @ 1
[    9.402392] initcall pcie_pme_service_init+0x0/0x11 returned 0 after 5 usecs
[   404676] calling  dpc_service_init+0x0/0x11 @ 1
[    9.506352] initcall dpc_service_init+0x0/0x11 returned 0 after 5 usecs
[    9.508647] calling  pci_hotplug_init+0x0/0x31 @ 1
[    9.510263] initcall pci_hotplug_init+0x0/0x31 returned 0 after 0 usecs
[    9.512489] calling  pcied_init+0x0/0x56 @ 1
[    9.513914] initcall pcied_init+0x0/0x56 returned 0 after 4 usecs
[    9.516057] calling  shpcd_init+0x0/0x59 @ 1
[    9.517514] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    9.519956] initcall shpcd_init+0x0/0x59 returned 0 after 2398 usecs
[    9.522126] calling  pci_stub_init+0x0/0x143 @ 1
[    9.523691] initcall pci_stub_init+0x0/0x143 returned 0 after 10 usecs
[    9.525959] calling  pci_epc_init+0x0/0x42 @ 1
[    9.527449] initcall pci_epc_init+0x0/0x42 returned 0 after 3 usecs
[    9.529570] calling  pci_epf_init+0x0/0x2a @ 1
[    9.531021] initcall pci_epf_init+0x0/0x2a returned 0 after 7 usecs
[    9.533124] calling  vesafb_driver_init+0x0/0x13 @ 1
[    9.534808] initcall vesafb_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.537062] calling  efifb_driver_init+0x0/0x13 @ 1
[    9.538689] initcall efifb_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.540915] calling  intel_idle_init+0x0/0x5b0 @ 1
[    9.542540] initcall intel_idle_init+0x0/0x5b0 returned -19 after 1 usecs
[    9.544782] calling  acpi_processor_driver_init+0x0/0x91 @ 1
[    9.546782] probe of cpu0 returned 1 after 87 usecs
[    9.548528] probe of cpu1 returned 1 after 64 usecs
[    9.550250] probe of cpu2 returned 1 after 73 usecs
[    9.551936] probe of cpu3 returned 1 after 71 usecs
[    9.553655] probe of cpu4 returned 1 after 76 usecs
[    9.555391] probe of cpu5 returned 1 after 70 usecs
[    9.557088] probe of cpu6 returned 1 after 72 usecs
[    9.558870] probe of cpu7 returned 1 after 70 usecs
[    9.560528] initcall acpi_processor_driver_init+0x0/0x91 returned 0 after 13511 usecs
[    9.563113] calling  acpi_hed_driver_init+0x0/0x11 @ 1
[    9.564995] initcall acpi_hed_drivinit+0x0/0x11 returned 0 after 86 usecs
[    9.667601] calling  bgrt_init+0x0/0xb5 @ 1
[    9.668993] initcall bgrt_init+0x0/0xb5 returned -19 after 0 usecs
[    9.671134] calling  erst_init+0x0/0x2d4 @ 1
[    9.672566] ERST: Error Record Serialization Table (ERST) support is initialized.
[    9.677447] pstore: No deflate compression
[    9.678892] pstore: Registered erst as persistent store backend
[    9.680927] initcall erst_init+0x0/0x2d4 returned 0 after 8180 usecs
[    9.683006] calling  ghes_init+0x0/0x137 @ 1
[    9.684580] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    9.687104] initcall ghes_init+0x0/0x137 returned 0 after 2575 usecs
[    9.689199] calling  intel_crc_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.691372] initcall intel_crc_pmic_opregion_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.694077] calling  intel_xpower_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.696374] initcall intel_xpower_pmic_opregion_driver_init+0x0/0x13 returned 0 after 7 usecs
[    9.699176] calling  intel_bxtwc_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.701365] initcall intel_bxtwc_pmic_opregion_driver_init+0x0/0x13 returned 0 after 7 usecs
[    9.704073] calling  intel_cht_wc_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.706341] initcall intel_cht_wc_pmic_opregion_driver_init+0x0/0x13 returned 0 after 7 usecs
[    9.709564] calling  chtdc_ti_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.711677] initcall chtdc_ti_pmic_opregion_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.714671] calling  gpio_clk_driver_init+0x0/0x13 @ 1
[    9.716527] initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.718810] calling  plt_clk_driver_init+0x0/0x13 @ 1
[    9.720432] initcall plt_clk_driver_init+0x0/0x13 returned 0 after 4 usecs
[    9.722676] calling  st_clk_driver_init+0x0/0x13 @ 1
[    9.724313] initcall st_clk_driver_init+0x0/0x13 returned 0 after 4 usecs
[    9.726707] calling  dw_pci_driver_init+0x0/0x1a @ 1
[    9.728389] initcall dw_pci_driver_init+0x0/0x1a returned 0 after 15 usecs
[    9.730670] calling  virtio_pci_driver_init+0x0/0x1a @ 1
[    9.732437] initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 15 usecs
[    9.734843] calling  xenbus_probe_initcall+0x0/0x42 @ 1
[    9.736624] initcall xenbus_probe_initcall+0x0/0x42 returned -19 after 0 usecs
[    9.739051] calling  xenbus_init+0x036 @ 1
[    9.840553] initcall xenbus_init+0x0/0x36 returned -19 after 0 usecs
[    9.842625] calling  xenbus_backend_init+0x0/0x3f @ 1
[    9.844333] initcall xenbus_backend_init+0x0/0x3f returned -19 after 0 usecs
[    9.846763] calling  hyper_sysfs_init+0x0/0x177 @ 1
[    9.848424] initcall hyper_sysfs_init+0x0/0x177 returned -19 after 0 usecs
[    9.850714] calling  hypervisor_subsys_init+0x0/0x25 @ 1
[    9.852544] initcall hypervisor_subsys_init+0x0/0x25 returned -19 after 0 usecs
[    9.855022] calling  platform_driver_init+0x0/0x1a @ 1
[    9.856807] initcall platform_driver_init+0x0/0x1a returned 0 after 10 usecs
[    9.859124] calling  xen_late_init_mcelog+0x0/0x58 @ 1
[    9.860923] initcall xen_late_init_mcelog+0x0/0x58 returned -19 after 0 usecs
[    9.863313] calling  pvcalls_back_init+0x0/0x66 @ 1
[    9.864944] initcall pvcalls_back_init+0x0/0x66 returned -19 after 0 usecs
[    9.867269] calling  n_null_init+0x0/0x1f @ 1
[    9.868721] initcall n_null_init+0x0/0x1f returned 0 after 0 usecs
[    9.870818] calling  pty_init+0x0/0x336 @ 1
[    9.872466] initcall pty_init+0x0/0x336 returned 0 after 258 usecs
[    9.874581] calling  sysrq_init+0x0/0x4a @ 1
[    9.876099] initcall sysrq_init+0x0/0x4a returned 0 after 2 usecs
[    9.878172] calling  xen_hvc_init+0x0/0x22d @ 1
[    9.879681] initcall xen_hvc_init+0x0/0x22d returned -19 after 0 usecs
[    9.881850] calling  serial8250_init+0x0/0x15b @ 1
[    9.883466] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    9.906220] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    9.909027] probe of 00:03 returned 1 after 23342 usecs
[    9.931344] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    9.935436] probe of serial8250 returned 1 after 6 usecs
[    9.937276] initcall serial8250_init+0x0/0x15b returned 0 after 52549 usecs
[    9.939603] calling  serial_pci_driver_init+0x0/0x1a @ 1
[    9.941438] initcall serial_pci_driver_init+0x0/0x1a returned 0 after 52 usecs
[    9.943857] calling  exar_pci_driver_init+0x0/0x1a @ 1
[    9.945676] initcall exar_pci_driver_init+0x0/0x1a returned 0 after 14 usecs
[    9.948019] calling  dw8250_platform_driver_init+0x0/0x13 @ 1
[    9.949933] initcall dw8250_platform_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.952570] calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
[    9.954453] initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 11 usecs
[    9.956916] calling  mid8250_pci_driver_init+0x0/0x1a @ 1
[    9.959138] initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 11 usecs
[    9.961566] calling  moxa8250_pci_driver_init+0x0/0x1a @ 1
[    9.963405] initcall moxa8250_pci_driver_init+0x0/0x1a returned 0 after 12 usecs
[    9.965991] calling  init+0x0/0xfd @ 1
[    9.967288] initcall init+0x0/0xfd returned 0 after 16 usecs
[    9.969179] calling  hpet_init+0x0/0x65 @ 1
[    9.970915] probe of PNP0103:00 returned 0 after 32 usecs
[    9.972821] initcall hpet_init+0x0/0x65 returned 0 after 2169 usecs
[    9.974915] calling  nvram_init+0x0/0x79 @ 1
[    9.976657] Non-volatile memory driver v1.3
[    9.978098] initcall nvram_init+0x0/0x79 returned 0 after 1644 usecs
[    9.980318] calling  hwrng_modinit+0x0/0x7d @ 1
[    9.982073] initcall hwrng_modinit+0x0/0x7d returned 0 after 241 usecs
[    9.984345] calling  agp_init+0x0/0x24 @ 1
[    9.985869] Linux agpgart interface v0.103
[    9.987277] initcall agp_init+0x0/0x24 returned 0 after 1374 usecs
[    9.989300] calling  agp_amd64_mod_init+0x0/0x20 @ 1
[    9.990979] initcall agp_amd64_mod_init+0x0/0x20 returned -19 after 0 usecs
[    9.993353] calling  agp_intel_init+0x0/0x29 @ 1
[    9.994872] initcall agp_intel_init+0x0/0x29 returned 0 after 15 usecs
[    9.997] calling  agp_sis_init+0x0/0x29 @ 1
[   10.098688] initcall agp_sis_init+0x0/0x29 returned 0 after 13 usecs
[   10.100800] calling  agp_via_init+0x0/0x29 @ 1
[   10.102370] initcall agp_via_init+0x0/0x29 returned 0 after 12 usecs
[   10.104441] calling  init_tis+0x0/0xb5 @ 1
[   10.105949] initcall init_tis+0x0/0xb5 returned 0 after 11 usecs
[   10.107914] calling  crb_acpi_driver_init+0x0/0x11 @ 1
[   10.109731] initcall crb_acpi_driver_init+0x0/0x11 returned 0 after 30 usecs
[   10.112074] calling  cn_proc_init+0x0/0x36 @ 1
[   10.113584] initcall cn_proc_init+0x0/0x36 returned 0 after 1 usecs
[   10.115758] calling  _nvm_misc_init+0x0/0x11 @ 1
[   10.117563] initcall _nvm_misc_init+0x0/0x11 returned 0 after 246 usecs
[   10.119805] calling  topology_sysfs_init+0x0/0x30 @ 1
[   10.121526] initcall topology_sysfs_init+0x0/0x30 returned 0 after 30 usecs
[   10.123825] calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
[   10.126969] initcall cacheinfo_sysfs_init+0x0/0x2c returned 172 after 1266 usecs
[   10.129548] calling  devcoredump_init+0x0/0x18 @ 1
[   10.131094] initcall devcoredump_init+0x0/0x18 returned 0 after 5 usecs
[   10.133319] calling  intel_soc_pmic_i2c_driver_init+0x0/0x13 @ 1
[   10.135421] initcall intel_soc_pmic_i2c_driver_init+0x0/0x13 returned 0 after 5 usecs
[   10.137962] calling  cht_wc_driver_init+0x0/0x13 @ 1
[   10.139558] initcall cht_wc_driver_init+0x0/0x13 returned 0 after 4 usecs
[   10.141780] calling  init_sd+0x0/0x162 @ 1
[   10.143171] initcall init_sd+0x0/0x162 returned 0 after 34 usecs
[   10.145192] calling  nvme_core_init+0x0/0x143 @ 1
[   10.147222] initcall nvme_core_init+0x0/0x143 returned 0 after 401 usecs
[   10.149624] calling  nvme_init+0x0/0x1a @ 1
[   10.151028] initcall nvme_init+0x0/0x1a returned 0 after 14 usecs
[   10.153062] calling  ahci_pci_driver_init+0x0/0x1a @ 1
[   10.154874] ahci 0000:00:11.0: version 3.0
[   10.156414] PCI Interrupt Link [SATA] enabled at IRQ 16
[   10.158224] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
[   10.161032] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc
[   10.164269] scsi host0: ahci
[   10.165442] ata1: SATA max UDMA/133 abar m1024@0xfccf0000 port 0xfccf0100 irq 16
[   10.167980] probe of 0000:00:11.0 returned 1 after 13119 usecs
[   10.170239] initcall ahci_pci_driver_init+0x0/0x1a returned 0 after 15026 usecs
[   10.172740] calling  net_olddevs_init+0x0/0x5d @ 1
[   10.174368] initcall net_olddevs_init+0x0/0x5d returned 0 after 3 usecs
[   10.176636] calling  kgdbdbgp_start_thread+0x0/0x4d @ 1
[   10.178477] initcall kgdbdbgp_start_thread+0x0/0x4d returned 0 ar 0 usecs
[   10.280800] calling  ledtrig_usb_init+0x0/0x2e @ 1
[   10.282483] initcall ledtrig_usb_init+0x0/0x2e returned 0 after 1 usecs
[   10.284794] calling  i8042_init+0x0/0x446 @ 1
[   10.286336] probe of 00:01 returned 1 after 7 usecs
[   10.287954] probe of 00:02 returned 1 after 5 usecs
[   10.289621] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[   10.294055] serio: i8042 KBD port at 0x60,0x64 irq 1
[   10.295953] serio: i8042 AUX port at 0x60,0x64 irq 12
[   10.297679] probe of i8042 returned 1 after 5254 usecs
[   10.299396] initcall i8042_init+0x0/0x446 returned 0 after 12763 usecs
[   10.301546] calling  input_leds_init+0x0/0x11 @ 1
[   10.303049] initcall input_leds_init+0x0/0x11 returned 0 after 0 usecs
[   10.305221] calling  mousedev_init+0x0/0x81 @ 1
[   10.307112] mousedev: PS/2 mouse device common for all mice
[   10.309075] initcall mousedev_init+0x0/0x81 returned 0 after 2191 usecs
[   10.311356] calling  evdev_init+0x0/0x11 @ 1
[   10.312858] initcall evdev_init+0x0/0x11 returned 0 after 0 usecs
[   10.314883] calling  atkbd_init+0x0/0x26 @ 1
[   10.316388] initcall atkbd_init+0x0/0x26 returned 0 after 22 usecs
[   10.318418] calling  psmouse_init+0x0/0x85 @ 1
[   10.319954] initcall psmouse_init+0x0/0x85 returned 0 after 37 usecs
[   10.322082] calling  cmos_init+0x0/0x6a @ 1
[   10.323516] rtc_cmos 00:04: RTC can wake from S4
[   10.325478] rtc_cmos 00:04: registered as rtc0
[   10.327035] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   10.329614] probe of 00:04 returned 1 after 6115 usecs
[   10.331320] initcall cmos_init+0x0/0x6a returned 0 after 7640 usecs
[   10.333401] calling  watchdog_gov_noop_register+0x0/0x11 @ 1
[   10.335408] initcall watchdog_gov_noop_register+0x0/0x11 returned 0 after 1 usecs
[   10.337795] calling  intel_pstate_init+0x0/0x36a @ 1
[   10.339458] initcall intel_pstate_init+0x0/0x36a returned -19 after 0 usecs
[   10.341765] calling  ledtrig_disk_init+0x0/0x54 @ 1
[   10.343436] initcall ledtrig_disk_init+0x0/0x54 returned 0 after 1 usecs
[   10.345690] calling  ledtrig_cpu_init+0x0/0xd3 @ 1
[   10.347932] ledtrig-cpu: registered to indicate activity on CPUs
[   10.349991] initcall ledtrig_cpu_init+0x0/0xd3 returned 0 after 2570 usecs
[   10.352312] calling  efivars_sysfs_init+0x0/0x30 @ 1
[   10.353949] initcall efivars_sysfs_init+0x0/0x30 returned -19 after 0 usecs
[   10.356365] calling  esrt_sysfs_init+0x0/0x2d9 @ 1
[   10.357970] initcall esrt_sysfs_init+0x0/0x2d9 returned -38 after 0 usecs
[   10.360173] calling  hid_init+0x0/0x5d @ 1
[   10.361] hidraw: raw HID events driver (C) Jiri Kosina
[   10.463499] initcall hid_init+0x0/0x5d returned 0 after 99531 usecs
[   10.465934] calling  pmc_core_probe+0x0/0x235 @ 1
[   10.467578] initcall pmc_core_probe+0x0/0x235 returned -19 after 0 usecs
[   10.469795] calling  pmc_atom_init+0x0/0x25e @ 1
[   10.471403] initcall pmc_atom_init+0x0/0x25e returned -19 after 8 usecs
[   10.473660] calling  extcon_class_init+0x0/0x17 @ 1
[   10.475322] initcall extcon_class_init+0x0/0x17 returned 0 after 3 usecs
[   10.477581] calling  powercap_init+0x0/0x2a1 @ 1
[   10.479295] probe of serio0 returned 0 after 162919 usecs
[   10.481317] initcall powercap_init+0x0/0x2a1 returned 0 after 2155 usecs
[   10.481503] ata1: SATA link down (SStatus 0 SControl 300)
[   10.483642] calling  pm_check_save_msr+0x0/0x20 @ 1
[   10.487226] initcall pm_check_save_msr+0x0/0x20 returned 0 after 0 usecs
[   10.489485] calling  sock_diag_init+0x0/0x34 @ 1
[   10.491066] initcall sock_diag_init+0x0/0x34 returned 0 after 61 usecs
[   10.493269] calling  blackhole_init+0x0/0x11 @ 1
[   10.494857] initcall blackhole_init+0x0/0x11 returned 0 after 0 usecs
[   10.497055] calling  gre_offload_init+0x0/0x49 @ 1
[   10.498653] initcall gre_offload_init+0x0/0x49 returned 0 after 0 usecs
[   10.500863] calling  sysctl_ipv4_init+0x0/0x4c @ 1
[   10.502510] initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 41 usecs
[   10.504710] calling  cubictcp_register+0x0/0x58 @ 1
[   10.506446] initcall cubictcp_register+0x0/0x58 returned 0 after 1 usecs
[   10.508640] calling  inet6_init+0x0/0x35f @ 1
[   10.510083] NET: Registered protocol family 10
[   10.516817] Segment Routing with IPv6
[   10.518075] initcall inet6_init+0x0/0x35f returned 0 after 7848 usecs
[   10.520286] calling  strp_mod_init+0x0/0x31 @ 1
[   10.522069] initcall strp_mod_init+0x0/0x31 returned 0 after 185 usecs
[   10.524305] calling  dcbnl_init+0x0/0x4d @ 1
[   10.525844] initcall dcbnl_init+0x0/0x4d returned 0 after 1 usecs
[   10.527857] calling  mcheck_init_device+0x0/0x12f @ 1
[   10.530323] initcall mcheck_init_device+0x0/0x12f returned 0 after 751 usecs
[   10.532768] calling  dev_mcelog_init_device+0x0/0x4b @ 1
[   10.534881] initcall dev_mcelog_init_device+0x0/0x4b returned 0 after 245 usecs
[   10.537511] calling  tboot_late_init+0x0/0x311 @ 1
[   10.539118] initcall tboot_late_init+0x0/0x311 returned 0 after 0 usecs
[   10.541361] calling  intel_rdt_late_init+0x0/0x4a9 @ 1
[   10.542892] probe of serio1 returned 0 after 61837 usecs
[   10.543137] initcall intel_rdt_late_init+0x0/0x4a9 returned -19 after 0 usecs
[   10.547383] calling  mcheck_late_init+0x0/0x75 @ 1
[   10.549011] RAS: Correctable Errors collector initialized.
[   10.550879] initcall mcheck_late_init+0x0/0x75 returned 0 after 1840 usecs
[   10.553172] calling  severities_debugfs_init+0x0/0x3b @ 1
[   10.554985] initcall severities_debugfs_init+0x0/0x3b returned 0 after 1 usecs
[   10.557471] calling  threshold_init_device+0x0/0x4b @ 1
[   10.560032] initcall threshold_init_device+0x0/0x4b returned 0 after 780 usecs
[   10.560498] probe of serio1 returned 0 after 15558 usecs
[   10.562475] calling  microcode_init+0x0/0x1d6 @ 1
[   10.566156] microcode: CPU0: patch_level=0x06000852
[   10.567842] microcode: CPU1: patch_level=0x06000852
[   10.569505] microcode: CPU2: patch_level=0x06000852
[   10.571223] microcode: CPU3: patch_level=0x06000852
[   10.572970] microcode: CPU4: patch_level=0x06000852
[   10.574644] microcode: CPU5: patch_level=0x06000852
[   10.576553] microcode: CPU6: patch_level=0x06000852
[   10.578218] microcode: CPU7: patch_level=0x06000852
[   10.580213] microcode: Microcode Update Driver: v2.2.
[   10.580216] initcall microcode_init+0x0/0x1d6 returned 0 after 13903 usecs
[   10.584392] calling  hpet_insert_resource+0x0/0x23 @ 1
[   10.586216] initcall hpet_insert_resource+0x0/0x23 returned 0 after 1 usecs
[   10.588499] calling  update_mp_table+0x0/0x503 @ 1
[   10.590045] initcall update_mp_table+0x0/0x503 returned 0 after 0 usecs
[   10.592344] calling  lapic_insert_resource+0x0/0x3f @ 1
[   10.594067] initcall lapic_insert_resource+0x0/0x3f returned 0 after 0 usecs
[   10.596590] calling  print_ICs+0x0/0x1af @ 1
[  .598014] initcall print_ICs+0x0/0x1af returned 0 after 0 usecs
[   10.700126] calling  pat_memtype_list_init+0x0/0x32 @ 1
[   10.701902] initcall pat_memtype_list_init+0x0/0x32 returned 0 after 2 usecs
[   10.704244] calling  create_tlb_single_page_flush_ceiling+0x0/0x29 @ 1
[   10.706869] initcall create_tlb_single_page_flush_ceiling+0x0/0x29 returned 0 after 1 usecs
[   10.710084] calling  create_init_pkru_value+0x0/0x29 @ 1
[   10.711872] initcall create_init_pkru_value+0x0/0x29 returned 0 after 1 usecs
[   10.714203] calling  init_oops_id+0x0/0x40 @ 1
[   10.715838] initcall init_oops_id+0x0/0x40 returned 0 after 0 usecs
[   10.717891] calling  sched_clock_init_late+0x0/0x85 @ 1
[   10.719674] sched_clock: Marking stable (9666140483, 1051748491)->(12010405765, -1292516791)
[   10.722934] initcall sched_clock_init_late+0x0/0x85 returned 0 after 3182 usecs
[   10.725577] calling  sched_init_debug+0x0/0x3e @ 1
[   10.727223] initcall sched_init_debug+0x0/0x3e returned 0 after 5 usecs
[   10.729495] calling  pm_qos_power_init+0x0/0xaf @ 1
[   10.731392] initcall pm_qos_power_init+0x0/0xaf returned 0 after 323 usecs
[   10.733741] calling  pm_debugfs_init+0x0/0x24 @ 1
[   10.735463] initcall pm_debugfs_init+0x0/0x24 returned 0 after 1 usecs
[   10.737613] calling  printk_late_init+0x0/0x122 @ 1
[   10.739283] initcall printk_late_init+0x0/0x122 returned 0 after 0 usecs
[   10.741559] calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
[   10.743367] initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 1 usecs
[   10.745894] calling  debugfs_kprobe_init+0x0/0xa7 @ 1
[   10.747615] initcall debugfs_kprobe_init+0x0/0xa7 returned 0 after 7 usecs
[   10.749873] calling  taskstats_init+0x0/0x37 @ 1
[   10.751427] registered taskstats version 1
[   10.752785] initcall taskstats_init+0x0/0x37 returned 0 after 1330 usecs
[   10.755012] calling  kdb_ftrace_register+0x0/0x2d @ 1
[   10.756757] initcall kdb_ftrace_register+0x0/0x2d returned 0 after 2 usecs
[   10.759056] calling  load_system_ceficate_list+0x0/0xea @ 1
[   10.861020] Loading compiled-in X.509 certificates
[   10.863288] Loaded X.509 cert 'Devel:Kernel OBS Project: 997e70001fb163f0b061e406501f73bdf3e10ca0'
[   10.866425] initcall load_system_certificate_list+0x0/0xea returned 0 after 5275 usecs
[   10.869012] calling  fault_around_debugfs+0x0/0x35 @ 1
[   10.870716] initcall fault_around_debugfs+0x0/0x35 returned 0 after 2 usecs
[   10.873024] calling  max_swapfiles_check+0x0/0x8 @ 1
[   10.874670] initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
[   10.877017] calling  init_zswap+0x0/0x41d @ 1
[   10.878534] zswap: loaded using pool lzo/zbud
[   10.880366] initcall init_zswap+0x0/0x41d returned 0 after 1809 usecs
[   10.882569] calling  split_huge_pages_debugfs+0x0/0x35 @ 1
[   10.884410] initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 2 usecs
[   10.886925] calling  check_early_ioremap_leak+0x0/0x39 @ 1
[   10.888746] initcall check_early_ioremap_leak+0x0/0x39 returned 0 after 0 usecs
[   10.891167] calling  init_root_keyring+0x0/0xa @ 1
[   10.892817] initcall init_root_keyring+0x0/0xa returned 0 after 5 usecs
[   10.895046] calling  big_key_init+0x0/0xb4 @ 1
[   10.901499] Key type big_key registered
[   10.902841] initcall big_key_init+0x0/0xb4 returned 0 after 6080 usecs
[   10.905054] calling  init_encrypted+0x0/0xc9 @ 1
[   10.908912] Key type encrypted registered
[   10.910234] initcall init_encrypted+0x0/0xc9 returned 0 after 3394 usecs
[   10.912486] calling  init_profile_hash+0x0/0x7f @ 1
[   10.914132] AppArmor: AppArmor sha1 policy hashing enabled
[   10.916035] initcall init_profile_hash+0x0/0x7f returned 0 after 1858 usecs
[   10.918427] calling  integrity_fs_init+0x0/0x49 @ 1
[   10.920088] initcall integrity_fs_init+0x0/0x49 returned 0 after 4 usecs
[   10.922339] calling  init_ima+0x0/0x8a @ 1
[   10.923706] ima: No TPM chip found, activating TPM-bypass!
[   10.925683] ima: Allocated hash algorithm: sha256
[   10.927208] initcall init_ima+0x0/0x8a returned 0 after 3420 usecs
[   10.929340] calling  init_evm+0x0/0xf4 @ 1
[   10.930700] evm: Initialising EVM extended attributes:
[   10.932479] evm: security.selinux
[   10.933619] evm: security.apparmor
[   10.934755] evm: security.ima
[   10.935817] evm: security.capability
[   10.937079] evm: HMAC attrs: 0x1
[   10.938182] initcall init_evm+0x0/0xf4 returned 0 after 7305 usecs
[   10.940280] calling  fail_make_request_debugfs+0x0/0x29 @ 1
[   10.942116] initcall fail_make_request_debugfs+0x0/0x29 returned 0 after 13 usecs
[   10.944654] calling  prandom_reseed+0x0/0x2a @ 1
[   10.946246] initcall prandom_reseed+0x0/0x2a returned 0 after 5 usecs
[   10.948436] calling  init_error_injection+0x0/0x6a @ 1
[   10.950369] initcall init_error_injection+0x0/0x6a returned 0 after 186 usecs
[   10.952810] calling  pci_resource_alignment_sysfs_init+0x0/0x21 @ 1
[   10.954971] initcall pci_resource_alignment_sysfs_init+0x0/0x21 returned 0 after 2 usecs
[   10.958161] calling  pci_sysfs_init+0x0/0x50 @ 1
[   10.959965] initcall pci_sysfs_init+0x0/0x50 returned 0 after 275 usecs
[   10.962248] calling  bert_init+0x0/0x206 @ 1
[   10.963682] initcall bert_init+0x0/0x206 returned 0 after 12 usecs
[   10.965837] calling  clk_debug_init+0x0/0x116 @ 1
[   10.967451] initcall clk_debug_init+0x0/0x116 returned 0 after 8 usecs
[   10.969632] calling  boot_w_for_devices+0x0/0x29 @ 1
[   11.071473] initcall boot_wait_for_devices+0x0/0x29 returned -19 after 0 usecs
[   11.073890] calling  dmar_free_unused_resources+0x0/0xb1 @ 1
[   11.075927] initcall dmar_free_unused_resources+0x0/0xb1 returned 0 after 0 usecs
[   11.078443] calling  deferred_probe_initcall+0x0/0x90 @ 1
[   11.080220] initcall deferred_probe_initcall+0x0/0x90 returned 0 after 12 usecs
[   11.082651] calling  late_resume_init+0x0/0x10b @ 1
[   11.084308]   Magic number: 2:847:632
[   11.085732] initcall late_resume_init+0x0/0x10b returned 0 after 1389 usecs
[   11.088056] calling  genpd_power_off_unused+0x0/0x7e @ 1
[   11.089834] initcall genpd_power_off_unused+0x0/0x7e returned 0 after 0 usecs
[   11.092189] calling  genpd_debug_init+0x0/0x184 @ 1
[   11.093814] initcall genpd_debug_init+0x0/0x184 returned 0 after 2 usecs
[   11.096047] calling  rtc_hctosys+0x0/0xdd @ 1
[   11.097681] rtc_cmos 00:04: setting system clock to 2018-09-13 12:37:23 UTC (1536842243)
[   11.100462] initcall rtc_hctosys+0x0/0xdd returned 0 after 2888 usecs
[   11.102875] calling  firmware_memmap_init+0x0/0x33 @ 1
[   11.104657] initcall firmware_memmap_init+0x0/0x33 returned 0 after 34 usecs
[   11.107040] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[   11.109115] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 0 usecs
[   11.111739] calling  efi_shutdown_init+0x0/0x3c @ 1
[   11.113370] initcall efi_shutdown_init+0x0/0x3c returned -19 after 0 usecs
[   11.115732] calling  itmt_legacy_init+0x0/0x4b @ 1
[   11.117370] initcall itmt_legacy_init+0x0/0x4b returned -19 after 0 usecs
[   11.119596] calling  pci_mmcfg_late_insert_resources+0x0/0x51 @ 1
[   11.121633] initcall pci_mmcfg_late_insert_resources+0x0/0x51 returned 0 after 0 usecs
[   11.124238] calling  tcp_congestion_default+0x0/0x18 @ 1
[   11.126175] initcall tcp_congestion_default+0x0/0x18 returned 0 after 0 usecs
[   11.128578] calling  ip_auto_config+0x0/0xf25 @ 1
[   11.130128] initcall ip_auto_config+0x0f25 returned 0 after 3 usecs
[   11.232501] calling  software_resume+0x0/0x200 @ 1
[   11.234090] initcall software_resume+0x0/0x200 returned -19 after 1 usecs
[   11.236487] calling  clear_boot_tracer+0x0/0x26 @ 1
[   11.238046] initcall clear_boot_tracer+0x0/0x26 returned 0 after 0 usecs
[   11.240292] calling  tracing_set_default_clock+0x0/0x35 @ 1
[   11.242112] initcall tracing_set_default_clock+0x0/0x35 returned 0 after 0 usecs
[   11.244572] calling  acpi_gpio_handle_deferred_request_interrupts+0x0/0xc0 @ 1
[   11.247043] initcall acpi_gpio_handle_deferred_request_interrupts+0x0/0xc0 returned 0 after 0 usecs
[   11.250085] calling  clk_disable_unused+0x0/0x160 @ 1
[   11.251757] initcall clk_disable_unused+0x0/0x160 returned 0 after 0 usecs
[   11.256843] Freeing unused kernel image memory: 2028K
[   11.280726] Write protecting the kernel read-only data: 18432k
[   11.308801] Freeing unused kernel image memory: 2008K
[   11.332486] Freeing unused kernel image memory: 496K
[   11.356443] Run /init as init process
[   11.378018] random: systemd: uninitialized urandom read (16 bytes read)
[   11.410090] random: systemd: uninitialized urandom read (16 bytes read)
[   11.441582] random: systemd: uninitialized urandom read (16 bytes read)
[   11.478000] systemd[1]: systemd 228 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[   11.581205] systemd[1]: Detected architecture x86-64.
[   11.604569] systemd[1]: Running in initial RAM disk.
[   11.628160] systemd[1]: Set hostname to <ph039>.
[   11.707115] systemd[1]: Listening on udev Kernel Socket.
[   11.732716] systemd[1]: Listening on udev Control Socket.
[   11.758827] systemd[1]: Listening on Journal Socket.
[   11.783590] systemd[1]: Created slice System Slice.
[   11.807023] systemd[1]: Reached target Slices.
[   11.829033] systemd[1]: Starting Load Kernel Modules...
[   11.854669] calling  alua_init+0x0/0x1000 [scsi_dh_alua] @ 197
[   11.882496] alua: device handler registered
[   11.882501] initcall alua_init+0x0/0x1000 [scsi_dh_alua] returned 0 after 68 usecs
[   11.939713] calling  clariion_init+0x0/0x1000 [scsi_dh_emc] @ 197
[   11.969162] emc: device handler registered
[   11.969165] initcall clariion_init+0x0/0x1000 [scsi_dh_emc] returned 0 after 1 usecs
[   12.026838] calling  rdac_init+0x0/0x1000 [scsi_dh_rdac] @ 197
[   12.054805] rdac: device handler registered
[   12.054854] initcall rdac_init+0x0/0x1000 [scsi_dh_rdac] returned 0 after 45 usecs
[   12.111360] calling  dm_init+0x0/0x4d [dm_mod] @ 197
[   12.134856] device-mapper: uevent: version 1.0.3
[   12.134925] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[   12.134935] initcall dm_init+0x0/0x4d [dm_mod] returned 0 after 105 usecs
[   12.184281] random: crng init done
[   12.247391] random: 7 urandom warning(s) missed due to ratelimiting
[   12.278141] calling  dm_multipath_init+0x0/0x1000 [dm_multipath] @ 197
[   12.310062] calling  acpi_button_driver_init+0x0/0x1000 [button] @ 293
[   12.336500] initcall dm_multipath_init+0x0/0x1000 [dm_multipath] returned 0 after 26037 usecs
[   12.343362] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   12.417894] ACPI: Power Button [PWRF]
[   12.418090] calling  usb_init+0x0/0x141 [usbcore] @ 306
[   12.435726] probe of LNXPWRBN:00 returned 1 after 92449 usecs
[   12.460837] ACPI: bus type USB registered
[   12.488286] initcall acpi_button_driver_init+0x0/0x1000 [button] returned 0 after 26805 usecs
[   12.507377] usbcore: registered new interface driver usbfs
[   12.574523] usbcore: registered new interface driver hub
[   12.574624] usbcore: registered new device driver usb
[   12.624959] calling  atiixp_pci_driver_init+0x0/0x1000 [pata_atiixp] @ 334
[   12.625620] initcall usb_init+0x0/0x141 [usbcore] returned 0 after 160908 usecs
[   12.658374] pata_atiixp 0000:00:14.1: can't derive routing for PCI INT A
[   12.726588] calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 327
[   12.729093] initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 2438 usecs
[   12.744736] scsi host1: pata_atiixp
[   12.748735] scsi host2: pata_atiixp
[   12.748781] ata2: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x500 irq 14
[   12.748782] ata3: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x508 irq 15
[   12.749039] probe of 0000:00:14.1 returned 1 after 90859 usecs
[   12.749083] initcall atiixp_pci_driver_init+0x0/0x1000 [pata_atiixp] returned 0 after 21961 usecs
[   12.804432] calling  sas_transport_init+0x0/0x1000 [scsi_transport_sas] @ 328
[   13.009121] initcall sas_transport_init+0x0/0x1000 [scsi_transport_sas] returned 0 after 82 usecs
[   13.052138] calling  ehci_hcd_init+0x0/0x1000 [ehci_hcd] @ 297
[   13.052141] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   13.052153] initcall ehci_hcd_init+0x0/0x1000 [ehci_hcd] returned 0 after 8 usecs
[   13.052214] calling  drm_core_init+0x0/0xcd [drm] @ 319
[   13.052281] initcall drm_core_init+0x0/0xcd [drm] returned 0 after 42 usecs
[   13.052761] calling  init_sg+0x0/0x1000 [sg] @ 197
[   13.052785] initcall init_sg+0x0/0x1000 [sg] returned 0 after 17 usecs
[   13.259991] calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 339
[   13.290947] calling  ata_generic_pci_driver_init+0x0/0x1000 [ata_generic] @ 334
[   13.290995] initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 288 usecs
[   13.326090] initcall ata_generic_pci_driver_init+0x0/0x1000 [ata_generic] returned 0 after 63 usecs
[   13.409179] calling  ohci_hcd_mod_init+0x0/0x1000 [ohci_hcd] @ 316
[   13.409196] calling  ehci_pci_init+0x0/0x1000 [ehci_pci] @ 348
[   13.409213] calling  hpsa_init+0x0/0x1000 [hpsa] @ 328
[   13.409471] HP HPSA Driver (v 3.4.20-125)
[   13.409487] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   13.409927] PCI Interrupt Link [I020] enabled at IRQ 24
[   13.410179] hpsa 0000:03:00.0: Logical aborts not supported
[   13.410182] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
[   13.438741] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   13.438753] calling  uhci_hcd_init+0x0/0x1000 [uhci_hcd] @ 297
[   13.438755] uhci_hcd: USB Universal Host Controller Interface driver
[   13.438918] uhci_hcd 0000:02:00.4: UHCI Host Controller
[   13.438926] uhci_hcd 0000:02:00.4: new USB bus registered, assigned bus number 1
[   13.438945] uhci_hcd 0000:02:00.4: detected 8 ports
[   13.438946] uhci_hcd 0000:02:00.4: port count misdetected? forcing to 2 ports
[   13.438987] uhci_hcd 0000:02:00.4: irq 36, io base 0x00003c00
[   13.439082] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   13.439084] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   13.439086] usb usb1: Product: UHCI Host Controller
[   13.439088] usb usb1: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default uhci_hcd
[   13.439089] usb usb1: SerialNumber: 0000:02:00.4
[   13.439236] hub 1-0:1.0: USB hub found
[   13.439245] hub 1-0:1.0: 2 ports detected
[   13.439315] probe of 1-0:1.0 returned 1 after 85 usecs
[   13.439344] probe of usb1 returned 1 after 154 usecs
[   13.439416] probe of 0000:02:00.4 returned 1 after 633 usecs
[   13.439434] initcall uhci_hcd_init+0x0/0x1000 [uhci_hcd] returned 0 after 660 usecs
[   13.467385] ehci-pci: EHCI PCI platform driver
[   13.480535] scsi host3: hpsa
[   13.480606] hpsa can't handle SMP requests
[   13.488874] hpsa 0000:03:00.0: scsi 3:0:0:0: added RAID              HP       P420i            controller SSDSmartPathCap- En- Exp=1
[   13.488878] hpsa 0000:03:00.0: scsi 3:0:1:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   13.488881] hpsa 0000:03:00.0: scsi 3:0:2:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   13.488883] hpsa 0000:03:00.0: scsi 3:0:3:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   13.488886] hpsa 0000:03:00.0: scsi 3:0:4:0: masked Enclosure         PMCSIERA SRCv8x6G         enclosure SSDSmartPathCap- En- Exp=0
[   13.488889] hpsa 0000:03:00.0: scsi 3:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   13.488891] hpsa 0000:03:00.0: scsi 3:1:0:1: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   13.488975] hpsa can't handle SMP requests
[   13.489159] scsi 3:0:0:0: RAID              HP       P420i            8.32 PQ: 0 ANSI: 5
[   13.489300] probe of 3:0:0:0 returned 0 after 7 usecs
[   13.489367] scsi 3:0:0:0: Attached scsi generic sg0 type 12
[   13.489538] scsi 3:1:0:0: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   13.489703] probe of 3:1:0:0 returned 1 after 44 usecs
[   13.489757] sd 3:1:0:0: Attached scsi generic sg1 type 0
[   13.489894] sd 3:1:0:0: [sda] 585871964 512-byte logical blocks: (300 GB/279 GiB)
[   13.489935] sd 3:1:0:0: [sda] Write Protect is off
[   13.489937] sd 3:1:0:0: [sda] Mode Sense: 73 00 00 08
[   13.489949] scsi 3:1:0:1: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   13.489991] sd 3:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   13.490127] probe of 3:1:0:1 returned 1 after 39 usecs
[   13.490196] sd 3:1:0:1: Attached scsi generic sg2 type 0
[   13.490285] probe of 0000:03:00.0 returned 1 after 81033 usecs
[   13.490299] sd 3:1:0:1: [sdb] 1171743324 512-byte logical blocks: (600 GB/559 GiB)
[   13.490325] initcall hpsa_init+0x0/0x1000 [hpsa] returned 0 after 22485 usecs
[   13.490335] sd 3:1:0:1: [sdb] Write Protect is off
[   13.490338] sd 3:1:0:1: [sdb] Mode Sense: 73 00 00 08
[   13.490425] sd 3:1:0:1: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   13.490693]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   13.490942]  sdb: sdb1
[   13.491393] sd 3:1:0:1: [sdb] Attached SCSI disk
[   13.491432] sd 3:1:0:0: [sda] Attached SCSI disk
[   13.492165] initcall ohci_hcd_mod_init+0x0/0x1000 [ohci_hcd] returned 0 after 24283 usecs
[   13.511864] ehci-pci 0000:00:12.2: EHCI Host Controller
[   13.683756] PM: Image not found (code -22)
[   13.689876] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 2
[   13.690075] calling  ttm_init+0x0/0x1000 [ttm] @ 319
[   13.690105] initcall ttm_init+0x0/0x1000 [ttm] returned 0 after 20 usecs
[   14.001724] calling  init_module+0x0/0x1000 [raid6_pq] @ 387
[   14.023862] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   14.108708] raid6: sse2x1   gen()  5438 MB/s
[   14.109703] ehci-pci 0000:00:12.2: debug port 1
[   14.204592] raid6: sse2x1   xor()  3755 MB/s
[   14.208839] ehci-pci 0000:00:12.2: irq 23, io mem 0xfccc0000
[   14.292596] raid6: sse2x2   gen()  6821 MB/s
[   14.356680] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   14.468473] raid6: sse2x2   xor()  5775 MB/s
[   14.514921] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   14.636473] raid6: sse2x4   gen()  9186 MB/s
[   14.646264] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.752470] raid6: sse2x4   xor()  3686 MB/s
[   14.774843] usb usb2: Product: EHCI Host Controller
[   14.799394] raid6: using algorithm sse2x4 gen() 9186 MB/s
[   14.824818] usb usb2: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ehci_hcd
[   14.824820] usb usb2: SerialNumber: 0000:00:12.2
[   14.824974] hub 2-0:1.0: USB hub found
[   14.860872] raid6: .... xor() 3686 MB/s, rmw enabled
[   14.860875] raid6: using ssse3x2 recovery algorithm
[   14.883899] hub 2-0:1.0: 6 ports detected
[   14.908069] initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 845922 usecs
[   14.947132] calling  drm_kms_helper_init+0x0/0x14 [drm_kms_helper] @ 319
[   14.947179] probe of 2-0:1.0 returned 1 after 122212 usecs
[   14.947201] probe of usb2 returned 1 after 122273 usecs
[   14.947314] probe of 0000:00:12.2 returned 1 after 1435700 usecs
[   14.947585] ehci-pci 0000:00:13.2: EHCI Host Controller
[   14.947590] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
[   14.947593] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   14.947607] ehci-pci 0000:00:13.2: debug port 1
[   14.947666] ehci-pci 0000:00:13.2: irq 22, io mem 0xfcc90000
[   14.960679] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   14.960765] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   14.960767] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.960768] usb usb3: Product: EHCI Host Controller
[   14.960769] usb usb3: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ehci_hcd
[   14.960770] usb usb3: SerialNumber: 0000:00:13.2
[   14.960896] hub 3-0:1.0: USB hub found
[   14.960903] hub 3-0:1.0: 6 ports detected
[   14.961023] probe of 3-0:1.0 returned 1 after 131 usecs
[   14.961045] probe of usb3 returned 1 after 185 usecs
[   14.961133] probe of 0000:00:13.2 returned 1 after 13801 usecs
[   14.961231] initcall ehci_pci_init+0x0/0x1000 [ehci_pci] returned 0 after 897843 usecs
[   15.280610] usb 2-2: new high-speed USB device number 2 using ehci-pci
[   15.288219] initcall drm_kms_helper_init+0x0/0x14 [drm_kms_helper] returned 0 after 37 usecs
[   15.288266] calling  ohci_pci_init+0x0/0x1000 [ohci_pci] @ 306
[   15.288270] ohci-pci: OHCI PCI platform driver
[   15.328642] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   15.618572] calling  calibrate_xor_blocks+0x0/0xf21 [xor] @ 387
[   15.646138] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[   15.666536] xor: automatically using best checksumming function   avx
[   15.694067] ohci-pci 0000:00:12.0: irq 22, io mem 0xfcce0000
[   15.715001] initcall calibrate_xor_blocks+0x0/0xf21 [xor] returned 0 after 47326 usecs
[   15.955284] calling  mgag200_init+0x0/0x1000 [mgag200] @ 319
[   16.040692] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   16.140478] calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 384
[   16.169045] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   16.193911] initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 3 usecs
[   16.230149] usb usb4: Product: OHCI PCI host controller
[   16.570740] calling  init_btrfs_fs+0x0/0x120 [btrfs] @ 385
[   16.589341] usb usb4: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   16.617686] Btrfs loaded, crc32c=crc32c-intel, assert=on
[   16.655802] usb usb4: SerialNumber: 0000:00:12.0
[   16.687077] initcall init_btrfs_fs+0x0/0x120 [btrfs] returned 0 after 68025 usecs
[   16.778111] BTRFS: device label SLE-12-SP4-Beta3 devid 1 transid 17558 /dev/sda3
[   16.804472] usb 2-2: New USB device found, idVendor=0424, idProduct=2660, bcdDevice= 8.01
[   16.832949] BTRFS: device fsid a279a180-354e-4250-88aa-69f0bad6d187 devid 1 transid 37 /dev/sda5
[   16.868295] usb 2-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   16.902660] BTRFS: device label SLE-12-SP3-GM_MU devid 1 transid 56483 /dev/sda2
[   16.930022] hub 2-2:1.0: USB hub found
[   16.968335] BTRFS info (device sda3): disk space caching is enabled
[   17.005899] hub 4-0:1.0: USB hub found
[   17.034647] BTRFS info (device sda3): has skinny extents
[   17.065093] [TTM] Zone  kernel: Available graphics memory: 16347742 kiB
[   17.619661] hub 4-0:1.0: 3 ports detected
[   17.619743] probe of 4-0:1.0 returned 1 after 613849 usecs
[   17.665619] hub 2-2:1.0: 2 ports detected
[   17.665654] probe of usb4 returned 1 after 659801 usecs
[   17.665720] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   17.665721] [TTM] Initializing pool allocator
[   17.665727] [TTM] Initializing DMA pool allocator
[   17.665867] probe of 0000:00:12.0 returned 1 after 2377578 usecs
[   17.666421] probe of 2-2:1.0 returned 1 after 736406 usecs
[   17.666446] probe of 2-2 returned 1 after 736759 usecs
[   17.673522] ohci-pci 0000:00:12.1: OHCI PCI host controller
[   17.925389] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 5
[   17.960885] fbcon: mgadrmfb (fb0) is primary device
[   18.008530] ohci-pci 0000:00:12.1: irq 22, io mem 0xfccd0000
[   18.072745] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   18.072747] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.072749] usb usb5: Product: OHCI PCI host controller
[   18.072750] usb usb5: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   18.072751] usb usb5: SerialNumber: 0000:00:12.1
[   18.073107] hub 5-0:1.0: USB hub found
[   18.073116] hub 5-0:1.0: 3 ports detected
[   18.073178] probe of 5-0:1.0 returned 1 after 78 usecs
[   18.073201] probe of usb5 returned 1 after 134 usecs
[   18.073392] probe of 0000:00:12.1 returned 1 after 407517 usecs
[   18.073612] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   18.073619] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 6
[   18.073649] ohci-pci 0000:00:13.0: irq 23, io mem 0xfccb0000
[   18.136530] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   18.136533] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.136534] usb usb6: Product: OHCI PCI host controller
[   18.136535] usb usb6: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   18.136536] usb usb6: SerialNumber: 0000:00:13.0
[   18.136914] hub 6-0:1.0: USB hub found
[   18.136923] hub 6-0:1.0: 3 ports detected
[   18.136990] probe of 6-0:1.0 returned 1 after 82 usecs
[   18.137011] probe of usb6 returned 1 after 134 usecs
[   18.137191] probe of 0000:00:13.0 returned 1 after 63793 usecs
[   18.165438] Console: switching to colour frame buffer device 160x64
[   18.944237] mgag200 0000:02:00.1: fb0: mgadrmfb frame buffer device
[   18.975403] ohci-pci 0000:00:13.1: OHCI PCI host controller
[   19.002704] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 7
[   19.038624] ohci-pci 0000:00:13.1: irq 23, io mem 0xfcca0000
[   19.068775] [drm] Initialized mgag200 1.0.0 20110418 for 0000:02:00.1 on minor 0
[   19.104400] probe of 0000:02:00.1 returned 1 after 3045727 usecs
[   19.128665] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   19.133642] initcall mgag200_init+0x0/0x1000 [mgag200] returned 0 after 2457268 usecs
[   19.173370] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.245932] usb usb7: Product: OHCI PCI host controller
[   19.271145] usb usb7: Manufacturer: Linux 4.19.0-rc3-1.gd3995d7-default ohci_hcd
[   19.306824] usb usb7: SerialNumber: 0000:00:13.1
[   19.329259] hub 7-0:1.0: USB hub found
[   19.347384] hub 7-0:1.0: 3 ports detected
[   19.366682] probe of 7-0:1.0 returned 1 after 37429 usecs
[   19.392679] probe of usb7 returned 1 after 63460 usecs
[   19.417323] probe of 0000:00:13.1 returned 1 after 1280126 usecs
[   19.446324] initcall ohci_pci_init+0x0/0x1000 [ohci_pci] returned 0 after 2762626 usecs
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
         Starting Switch Root...
[   19.547739] systemd-journald[202]: Received SIGTERM from PID 1 (systemd).
[   19.625573] systemd: 15 output lines suppressed due to ratelimiting
[   19.732483] usb 7-3: new low-speed USB device number 2 using ohci-pci
[   19.765051] systemd-sysv-generator[483]: Overwriting existing symlink /run/systemd/generator.late/inputattach.service with real service.
[   19.941766] BTRFS info (device sda3): disk space caching is enabled
[   19.986937] usb 7-3: New USB device found, idVendor=0d3d, idProduct=0040, bcdDevice= 0.01
[   20.026545] usb 7-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   20.060827] usb 7-3: Product: USB CAT5
[   20.086736] probe of 7-3 returned 1 after 7077 usecs
[   20.161767] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 520
[   20.196512] acpi_cpufreq: overriding BIOS provided _PSD data
[   20.225911] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned 0 after 32063 usecs
[   20.269275] calling  k10temp_driver_init+0x0/0x1000 [k10temp] @ 593
[   20.348810] calling  piix4_driver_init+0x0/0x1000 [i2c_piix4] @ 607
[   20.354062] probe of 0000:00:18.3 returned 1 after 825 usecs
[   20.386161] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   20.414991] probe of 0000:00:19.3 returned 1 after 625 usecs
[   20.440819] probe of 0000:00:14.0 returned 1 after 54706 usecs
[   20.467994] initcall k10temp_driver_init+0x0/0x1000 [k10temp] returned 0 after 86850 usecs
[   20.495834] initcall piix4_driver_init+0x0/0x1000 [i2c_piix4] returned 0 after 114039 usecs
[   20.577399] calling  fam15h_power_driver_init+0x0/0x1000 [fam15h_power] @ 518
[   20.612457] calling  ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] @ 621
[   20.620518] probe of 0000:00:18.4 returned 1 after 8181 usecs
[   20.670820] ipmi message handler version 39.2
[   20.680568] probe of 0000:00:19.4 returned 0 after 3289 usecs
[   20.695182] initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 46615 usecs
[   20.746032] initcall fam15h_power_driver_init+0x0/0x1000 [fam15h_power] returned 0 after 96279 usecs
[   20.812334] calling  pcspkr_platform_driver_init+0x0/0x1000 [pcspkr] @ 624
[   20.845470] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   20.845562] calling  pcc_cpufreq_init+0x0/0xeb6 [pcc_cpufreq] @ 537
[   20.845567] initcall pcc_cpufreq_init+0x0/0xeb6 [pcc_cpufreq] returned 0 after 0 usecs
[   20.877402] probe of pcspkr returned 1 after 32015 usecs
[   20.877423] initcall pcspkr_platform_driver_init+0x0/0x1000 [pcspkr] returned 0 after 31110 usecs
[   21.015512] calling  ilo_init+0x0/0x1000 [hpilo] @ 627
[   21.045065] calling  pps_init+0x0/0x1000 [pps_core] @ 618
[   21.045089] pps_core: LinuxPPS API ver. 1 registered
[   21.045090] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   21.045095] initcall pps_init+0x0/0x1000 [pps_core] returned 0 after 24 usecs
[   21.045708] calling  hpwdt_driver_init+0x0/0x1000 [hpwdt] @ 601
[   21.046220] calling  init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] @ 671
[   21.046222] ipmi device interface
[   21.046234] initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 10 usecs
[   21.047992] calling  ptp_init+0x0/0x1000 [ptp] @ 594
[   21.048004] PTP clock support registered
[   21.048008] initcall ptp_init+0x0/0x1000 [ptp] returned 0 after 9 usecs
[   21.048192] calling  fjes_init_module+0x0/0xa6 [fjes] @ 603
[   21.048435] calling  hid_init+0x0/0x1000 [usbhid] @ 595
[   21.048696] calling  sp5100_tco_init+0x0/0x1000 [sp5100_tco] @ 607
[   21.048709] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   21.048871] probe of sp5100-tco returned 0 after 44 usecs
[   21.048878] initcall sp5100_tco_init+0x0/0x1000 [sp5100_tco] returned 0 after 172 usecs
[   21.053259] probe of 7-3:1.0 returned 1 after 4805 usecs
[   21.059783] probe of 7-3:1.1 returned 1 after 6518 usecs
[   21.059803] usbcore: registered new interface driver usbhid
[   21.059804] usbhid: USB HID core driver
[   21.059813] initcall hid_init+0x0/0x1000 [usbhid] returned 0 after 10847 usecs
[   21.060451] calling  init_ipmi_si+0x0/0x30 [ipmi_si] @ 764
[   21.060453] IPMI System Interface driver.
[   21.060500] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   21.060504] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   21.060506] ipmi_si: Adding SMBIOS-specified kcs state machine
[   21.060519] probe of dmi-ipmi-si.0 returned 1 after 30 usecs
[   21.061316] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   21.064996] probe of 0000:02:00.2 returned 1 after 24708 usecs
[   21.065029] initcall ilo_init+0x0/0x1000 [hpilo] returned 0 after 4463 usecs
[   21.065534] initcall fjes_init_module+0x0/0xa6 [fjes] returned -19 after 4952 usecs
[   21.067344] PCI Interrupt Link [I060] enabled at IRQ 47
[   21.067436] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: NMI decoding initialized
[   21.069615] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   21.069618] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[   21.069619] ipmi_si: Adding ACPI-specified kcs state machine
[   21.069667] probe of IPI0001:00 returned 1 after 9143 usecs
[   21.069819] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   21.070035] calling  cryptd_init+0x0/0x1000 [cryptd] @ 728
[   21.070042] cryptd: max_cpu_qlen set to 1000
[   21.070046] initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after 7 usecs
[   21.076947] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: 2.0.0, timer margin: 30 seconds (nowayout=0).
[   21.077281] probe of 0000:02:00.0 returned 1 after 31551 usecs
[   21.077356] initcall hpwdt_driver_init+0x0/0x1000 [hpwdt] returned 0 after 7140 usecs
[   21.083147] Adding 4192252k swap on /dev/sda1.  Priority:-2 extents:1 across:4192252k FS
[   21.084636] calling  phy_init+0x0/0x58 [libphy] @ 620
[   21.084701] initcall phy_init+0x0/0x58 [libphy] returned 0 after 50 usecs
[   21.093652] systemd-journald[490]: Received request to flush runtime journal from PID 1
[   21.320787] calling  aes_init+0x0/0x1000 [aes_x86_64] @ 653
[   21.516347] calling  tg3_driver_init+0x0/0x1000 [tg3] @ 620
[   21.544661] initcall aes_init+0x0/0x1000 [aes_x86_64] returned 0 after 391 usecs
[   21.570199] tg3.c:v3.137 (May 11, 2014)
[   21.596482] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[   21.686282] calling  msr_init+0x0/0x1000 [msr] @ 1165
[   21.705576] PCI Interrupt Link [I0C0] enabled at IRQ 36
[   21.764495] ipmi_si IPI0001:00: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x13)
[   21.765891] tg3 0000:04:00.0: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 373
[   21.990080] calling  hid_generic_init+0x0/0x1000 [hid_generic] @ 578
[   22.027410] tg3 0000:04:00.0: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 3 usecs
[   22.052941] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.0/0003:0D3D:0040.0001/input/input5
[   22.124388] tg3 0000:04:00.0 eth0: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:90
[   22.166885] initcall msr_init+0x0/0x1000 [msr] returned 0 after 111651 usecs
[   22.193371] tg3 0000:04:00.0 eth0: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   22.193600] calling  aesni_init+0x0/0x1e7 [aesni_intel] @ 653
[   22.193603] AVX version of gcm_enc/dec engaged.
[   22.193605] AES CTR mode by8 optimization enabled
[   22.225109] hid-generic 0003:0D3D:0040.0001: input,hidraw0: USB HID v1.00 Keyboard [USB CAT5] on usb-0000:00:13.1-3/input0
[   22.267446] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   22.293996] probe of 0003:0D3D:0040.0001 returned 1 after 241412 usecs
[   22.314661] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   22.349546] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.1/0003:0D3D:0040.0002/input/input6
[   22.394862] probe of 0000:04:00.0 returned 1 after 824770 usecs
[   22.423175] hid-generic 0003:0D3D:0040.0002: input,hidraw1: USB HID v1.00 Mouse [USB CAT5] on usb-0000:00:13.1-3/input1
[   22.460986] PCI Interrupt Link [I0C1] enabled at IRQ 37
[   22.499815] probe of 0003:0D3D:0040.0002 returned 1 after 150767 usecs
[   22.524074] tg3 0000:04:00.1: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 373
[   22.556721] initcall hid_generic_init+0x0/0x1000 [hid_generic] returned 0 after 354601 usecs
[   22.595253] tg3 0000:04:00.1: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 1 usecs
[   22.624889] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   22.680639] tg3 0000:04:00.1 eth1: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:91
[   22.684192] initcall init_ipmi_si+0x0/0x30 [ipmi_si] returned 0 after 479079 usecs
[   22.684201] calling  crypto_pcbc_module_init+0x0/0x1000 [pcbc] @ 1253
[   22.684205] initcall crypto_pcbc_module_init+0x0/0x1000 [pcbc] returned 0 after 1 usecs
[   22.702484] tg3 0000:04:00.1 eth1: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   22.849802] initcall aesni_init+0x0/0x1e7 [aesni_intel] returned 0 after 161707 usecs
[   22.884352] tg3 0000:04:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   23.407020] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 630
[   23.435028] tg3 0000:04:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[   23.435167] probe of 0000:04:00.1 returned 1 after 974633 usecs
[   23.487055] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 350 usecs
[   23.511885] tg3 0000:04:00.2: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 373
[   23.682457] calling  ibft_init+0x0/0xf45 [iscsi_ibft] @ 1210
[   23.734053] tg3 0000:04:00.2: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 1 usecs
[   23.753387] tg3 0000:04:00.2 eth2: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:92
[   23.770526] No iBFT detected.
[   23.770532] initcall ibft_init+0x0/0xf45 [iscsi_ibft] returned 0 after 8 usecs
[   23.801443] tg3 0000:04:00.2 eth2: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   23.801458] tg3 0000:04:00.2 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   24.392504] tg3 0000:04:00.2 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   24.392717] calling  init_ipmi_ssif+0x0/0x20 [ipmi_ssif] @ 764
[   24.392719] IPMI SSIF Interface driver
[   24.392759] probe of 0000:04:00.2 returned 1 after 881055 usecs
[   24.392828] initcall init_ipmi_ssif+0x0/0x20 [ipmi_ssif] returned 0 after 103 usecs
[   24.392990] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 608
[   24.393268] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 259 usecs
[   24.394775] tg3 0000:04:00.3: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 373
[   24.394826] tg3 0000:04:00.3: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 25 usecs
[   24.406257] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 647
[   24.406512] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 242 usecs
[   24.464718] tg3 0000:04:00.3 eth3: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:93
[   24.884442] tg3 0000:04:00.3 eth3: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   24.884444] tg3 0000:04:00.3 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   24.884447] tg3 0000:04:00.3 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[   24.884573] probe of 0000:04:00.3 returned 1 after 491803 usecs
[   25.035022] initcall tg3_driver_init+0x0/0x1000 [tg3] returned 0 after 614007 usecs
[   25.072464] calling  sp_mod_init+0x0/0x1000 [ccp] @ 683
[   25.072571] initcall sp_mod_init+0x0/0x1000 [ccp] returned 0 after 85 usecs
[   25.131851] calling  svm_init+0x0/0xbb3 [kvm_amd] @ 647
[   25.190010] kvm: Nested Virtualization enabled
[   25.190682] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   25.211399] kvm: Nested Paging enabled
[   25.256938] initcall svm_init+0x0/0xbb3 [kvm_amd] returned 0 after 122139 usecs
[   25.308184] calling  mce_amd_init+0x0/0x1000 [edac_mce_amd] @ 644
[   25.337694] MCE: In-kernel MCE decoding enabled.
[   25.337703] initcall mce_amd_init+0x0/0x1000 [edac_mce_amd] returned 0 after 14 usecs
[   25.412033] calling  amd64_edac_init+0x0/0x1000 [amd64_edac_mod] @ 683
[   25.443766] EDAC amd64: Node 0: DRAM ECC enabled.
[   25.466321] EDAC amd64: F15h detected (node 0).
[   25.488190] EDAC MC: DCT0 chip selects:
[   25.506560] EDAC amd64: MC: 0:     0MB 1:     0MB
[   25.529072] EDAC amd64: MC: 2:     0MB 3:     0MB
[   25.551667] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[   25.573988] EDAC amd64: MC: 6:     0MB 7:     0MB
[   25.596397] EDAC MC: DCT1 chip selects:
[   25.614916] EDAC amd64: MC: 0:     0MB 1:     0MB
[   25.638264] EDAC amd64: MC: 2:     0MB 3:     0MB
[   25.660921] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[   25.683763] EDAC amd64: MC: 6:     0MB 7:     0MB
[   25.706283] EDAC amd64: using x8 syndromes.
[   25.726411] EDAC amd64: MCT channel count: 2
[   25.747086] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
[   25.792878] EDAC amd64: Node 1: DRAM ECC disabled.
[   25.815830] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[   25.815830]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[   25.815830]  (Note that use of the override may cause unknown side effects.)
[   25.933242] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[   25.985456] AMD64 EDAC driver v3.5.0
[   26.002839] initcall amd64_edac_init+0x0/0x1000 [amd64_edac_mod] returned 0 after 546109 usecs
[*     ] A start job is running for wicked m...twork interfaces (8s / no limit)[   28.751431] tg3 0000:04:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   28.783400] tg3 0000:04:00.0 eth0: Flow control is off for TX and off for RX
[   28.817467] tg3 0000:04:00.0 eth0: EEE is enabled
[   28.839976] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[**    ] A start job is running for wicked m...twork interfaces (8s / no limit)[   29.159044] calling  packet_init+0x0/0x1000 [af_packet] @ 1553
[   29.187248] NET: Registered protocol family 17
[   29.208866] initcall packet_init+0x0/0x1000 [af_packet] returned 0 after 21122 usecs
[  OK  ] Started wicked managed network interfaces.
         Starting Load kdump kernel and initrd...
[  OK  ] Reached target Network.
[  OK  ] Reached target Network is Online.
         Starting OpenSSH Daemon...
         Starting Login and scanning of iSCSI devices...
         Starting NTP Server Daemon...
[  OK  ] Started Login and scanning of iSCSI devices.
[  OK  ] Reached target Remote File Systems.
         Starting Permit User Sessions...
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started /etc/init.d/after.local Compatibility.
[  OK  ] Started OpenSSH Daemon.
[  OK  ] Started NTP Server Daemon.
[  OK  ] Reached target System Time Synchronized.
[  OK  ] Started qaset-service.
         Starting X Display Manager...
         Starting Postfix Mail Transport Agent...
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Reached target Timers.
         Starting Locale Service...
[  OK  ] Started Locale Service.
[  OK  ] Started Load kdump kernel and initrd.
         Starting Accounts Service...
         Starting Authorization Manager...
[  OK  ] Started X Display Manager.
[  OK  ] Started Authorization Manager.
[  OK  ] Started Accounts Service.
[  OK  ] Started Postfix Mail Transport Agent.
[  OK  ] Started Command Scheduler.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Update UTMP about System Runlevel Changes.


Welcome to SUSE Linux Enterprise Server 12 SP4 Beta3 (x86_64) - Kernel 4.19.0-rc3-1.gd3995d7-default (ttyS0).


ph039 login:


Welcome to SUSE Linux Enterprise Server 12 SP4 Beta3 (x86_64) - Kernel 4.19.0-rc3-1.gd3995d7-default (ttyS0).


ph039 login: root
Password:
Last login: Thu Sep 13 20:34:53 on ttyS0
ph039:~ # reboot
[  OK  ] Stopped wicked managed network interfaces.
         Stopping wicked network nanny service...
[  OK  ] Stopped wicked network nanny service.
         Stopping wicked network management service daemon...
[  OK  ] Stopped wicked network management service daemon.
         Stopping wicked AutoIPv4 supplicant service...
         Stopping wicked DHCPv6 supplicant service...
         Stopping wicked DHCPv4 supplicant service...
[  OK  ] Stopped wicked DHCPv4 supplicant service.
[  OK  ] Stopped wicked DHCPv6 supplicant service.
[  OK  ] Stopped wicked AutoIPv4 supplicant service.
         Stopping D-Bus System Message Bus...
[  OK  ] Stopped D-Bus System Message Bus.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Slices.
[  OK  ] Removed slice User and Session Slice.
[  OK  ] Stopped Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Stopped target Sockets.
[  OK  ] Closed Open-iSCSI iscsid Socket.
[  OK  ] Closed Syslog Socket.
[  OK  ] Closed PC/SC Smart Card Daemon Activation Socket.
[  OK  ] Closed D-Bus System Message Bus Socket.
[  OK  ] Stopped target System Initialization.
         Stopping Update UTMP about System Boot/Shutdown...
[  OK  ] Stopped Setup Virtual Console.
         Stopping Load/Save Random Seed...
[  OK  ] Stopped target Swap.
         Deactivating swap /dev/disk/by-id/s...01c840178773ac64adeb5bf-part1...
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped target Encrypted Volumes.
[  OK  ] Stopped Load Kernel Modules.
[  OK  ] Stopped Load/Save Random Seed.
[  OK  ] Stopped Update UTMP about System Boot/Shutdown.
[  OK  ] Stopped Create Volatile Files and Directories.
[  OK  ] Stopped target Local File Systems.
         Unmounting /var/lib/libvirt/images...
         Unmounting /usr/local...
         Unmounting /var/lib/mariadb...
         Unmounting /boot/grub2/i386-pc...
         Unmounting /srv...
         Unmounting /var/lib/mysql...
         Unmounting /var/cache...
         Unmounting /tmp...
         Unmounting /var/opt...
         Unmounting /var/lib/machines...
         Unmounting /opt...
         Unmounting /var/crash...
         Unmounting /var/lib/pgsql...
         Unmounting /home...
         Unmounting /var/lib/mailman...
         Unmounting /var/tmp...
         Unmounting /var/lib/named...
         Unmounting /var/spool...
         Unmounting /boot/grub2/x86_64-efi...
[  OK  ] Stopped Flush Journal to Persistent Storage.
         Unmounting /var/log...
[  OK  ] Deactivated swap /dev/disk/by-path/...0000:03:00.0-scsi-0:1:0:0-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/ww...1001c840178773ac64adeb5bf-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/sc...AL_VOLUME_001438027C7EAE0-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/sc...1001c840178773ac64adeb5bf-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/sc...P_LOGICAL_VOLUME_00000000-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/cc...1001c840178773ac64adeb5bf-part1.
[  OK  ] Deactivated swap /dev/cciss/c0d0p1.
[  OK  ] Deactivated swap /dev/sda1.
[  OK  ] Deactivated swap /dev/disk/by-uuid/...5bf-803c-44e6-90d7-1695025b0532.
[  OK  ] Unmounted /var/lib/libvirt/images.
[  OK  ] Unmounted /usr/local.
[  OK  ] Unmounted /var/lib/mariadb.
[  OK  ] Unmounted /boot/grub2/i386-pc.
[  OK  ] Unmounted /srv.
[  OK  ] Unmounted /var/lib/mysql.
[  OK  ] Unmounted /var/cache.
[  OK  ] Unmounted /tmp.
[  OK  ] Unmounted /var/opt.
[  OK  ] Unmounted /var/lib/machines.
[  OK  ] Unmounted /opt.
[  OK  ] Unmounted /var/crash.
[  OK  ] Unmounted /var/lib/pgsql.
[  OK  ] Unmounted /home.
[  OK  ] Unmounted /var/lib/mailman.
[  OK  ] Unmounted /var/tmp.
[  OK  ] Unmounted /var/lib/named.
[  OK  ] Unmounted /var/spool.
[  OK  ] Unmounted /boot/grub2/x86_64-efi.
[  OK  ] Unmounted /var/log.
[  OK  ] Stopped target Local File Systems (Pre).
[  OK  ] Stopped Remount Root and Kernel File Systems.
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Reached target Shutdown.
[   87.791825] watchdog: watchdog0: watchdog did not stop!
[   87.822195] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[   87.861478] systemd-journald[490]: Received SIGTERM from PID 1 (systemd-shutdow).
[   87.898784] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[   87.937401] systemd-shutdown[1]: Hardware watchdog 'HPE iLO2+ HW Watchdog Timer', version 0
[   87.977584] systemd-shutdown[1]: Unmounting file systems.
[   88.003684] systemd-shutdown[1]: Remounting '/' read-only with options 'space_cache,subvolid=257,subvol=/@'.
[   88.067261] BTRFS info (device sda3): disk space caching is enabled
[   88.100906] systemd-shutdown[1]: Remounting '/' read-only with options 'space_cache,subvolid=257,subvol=/@'.
[   88.149506] BTRFS info (device sda3): disk space caching is enabled
[   88.179880] systemd-shutdown[1]: All filesystems unmounted.
[   88.206511] systemd-shutdown[1]: Deactivating swaps.
[   88.230460] systemd-shutdown[1]: All swaps deactivated.
[   88.255735] systemd-shutdown[1]: Detaching loop devices.
[   88.343309] kvm: exiting hardware virtualization
[   88.366370] i2c i2c-1: shutdown
[   88.381461] i2c i2c-0: shutdown
[   88.396701] sd 3:1:0:1: shutdown
[   88.412305] sd 3:1:0:0: shutdown
[   88.428169] serio serio1: shutdown
[   88.444428] serio serio0: shutdown
[   88.460807] i8042 i8042: shutdown
[   88.477137] serial8250 serial8250: shutdown
[   88.496753] alarmtimer alarmtimer: shutdown
[   88.516814] pcspkr pcspkr: shutdown
[   88.533701] system 00:05: shutdown
[   88.549621] rtc_cmos 00:04: shutdown
[   88.566594] serial 00:03: shutdown
[   88.582793] i8042 aux 00:02: shutdown
[   88.600309] i8042 kbd 00:01: shutdown
[   88.617954] system 00:00: shutdown
[   88.634205] ipmi_si IPI0001:00: shutdown
[   88.653079] tg3 0000:04:00.3: shutdown
[   88.671211] tg3 0000:04:00.2: shutdown
[   88.689096] tg3 0000:04:00.1: shutdown
[   88.706365] tg3 0000:04:00.0: shutdown
[   88.724194] uhci_hcd 0000:02:00.4: shutdown
[   88.743790] hpilo 0000:02:00.2: shutdown
[   88.762277] mgag200 0000:02:00.1: shutdown
[   88.781742] hpwdt 0000:02:00.0: shutdown
[   88.800980] hpsa 0000:03:00.0: shutdown
[   88.840071] pci 0000:00:19.5: shutdown
[   88.858134] pci 0000:00:19.4: shutdown
[   88.875729] k10temp 0000:00:19.3: shutdown
[   88.895532] pci 0000:00:19.2: shutdown
[   88.913134] pci 0000:00:19.1: shutdown
[   88.931182] pci 0000:00:19.0: shutdown
[   88.949365] pci 0000:00:18.5: shutdown
[   88.967528] fam15h_power 0000:00:18.4: shutdown
[   88.989350] k10temp 0000:00:18.3: shutdown
[   89.008935] pci 0000:00:18.2: shutdown
[   89.027085] pci 0000:00:18.1: shutdown
[   89.045107] pci 0000:00:18.0: shutdown
[   89.063064] pci 0000:00:14.4: shutdown
[   89.080983] pci 0000:00:14.3: shutdown
[   89.099090] pata_atiixp 0000:00:14.1: shutdown
[   89.120519] piix4_smbus 0000:00:14.0: shutdown
[   89.141899] ehci-pci 0000:00:13.2: shutdown
[   89.162318] ohci-pci 0000:00:13.1: shutdown
[   89.162470] usb 7-3: USB disconnect, device number 2
[   89.182245] ohci-pci 0000:00:13.0: shutdown
[   89.207927] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.227197] ehci-pci 0000:00:12.2: shutdown
[   89.281187] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.281193] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.281207] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.281222] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.301634] ohci-pci 0000:00:12.1: shutdown
[   89.355384] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.410192] ohci-pci 0000:00:12.0: shutdown
[   89.464595] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.519654] ahci 0000:00:11.0: shutdown
[   89.539358] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.593595] pcieport 0000:00:0c.0: shutdown
[   89.613592] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.655553] usb 4-2: new full-speed USB device number 2 using ohci-pci
[   89.669039] pcieport 0000:00:0a.0: shutdown
[   89.687116] ohci-pci 0000:00:13.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.741967] pcieport 0000:00:02.0: shutdown
[   89.762026] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.817539] pci 0000:00:00.2: shutdown
[   89.848078] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.848082] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.848086] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.848092] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.868119] pci 0000:00:00.0: shutdown
[   89.923907] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.923911] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.923914] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.945313] ipmi_si dmi-ipmi-si.0: shutdown
[   89.998702] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   89.998706] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x0000000000000080 flags=0x0020]
[   90.515813] PM: Calling mce_syscore_shutdown+0x0/0x20
[   90.539580] PM: Calling ledtrig_cpu_syscore_shutdown+0x0/0x10
[   90.566176] usb 7-3: new low-speed USB device number 3 using ohci-pci
[   90.596179] PM: Calling irq_gc_shutdown+0x0/0x60
[   90.617592] PM: Calling i8259A_shutdown+0x0/0x10
[   90.647786] PM: Calling cpufreq_suspend+0x0/0x120
[   90.795525] reboot: Restarting system
[   90.812552] reboot: machine restart


--------------CB3DD83CD84F3B426A9A2787
Content-Type: text/x-log;
 name="initcall_debug_without_driver_core.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="initcall_debug_without_driver_core.log"

[    0.000000] Linux version 4.19.0-rc3-default+ (root@ph039) (gcc version 4.8.5 (SUSE Linux)) #69 SMP PREEMPT Thu Sep 13 22:11:28 CST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-rc3-default+ root=UUID=b314d001-d850-402f-8bce-77806d9f4aea sysrq_always_enabled panic=100 ignore_loglevel unknown_nmi_panic console=ttyS0,115200n8 resume=/dev/disk/by-uuid/bbe275bf-803c-44e6-90d7-1695025b0532 splash=silent quiet showopts crashkernel=116M,high crashkernel=72M,low nopti nospec nospectre_v2 nospec_store_bypass_disable initcall_debug
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x1ff/0x2d0 with crng_init=0
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
[    0.000000] tsc:ast TSC calibration using PIT
[    0.000000] tsc: Detected 2792.952 MHz processor
[    0.002540] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002544] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011133] AGP: No AGP bridge found
[    0.011210] last_pfn = 0x83efff max_arch_pfn = 0x400000000
[    0.011215] MTRR default type: uncachable
[    0.011216] MTRR fixed ranges enabled:
[    0.011219]   00000-9FFFF write-back
[    0.011220]   A0000-BFFFF uncachable
[    0.011222]   C0000-FFFFF write-back
[    0.011223] MTRR variable ranges enabled:
[    0.011225]   0 base 000000000000 mask FFFF80000000 write-back
[    0.011228]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.011229]   2 disabled
[    0.011230]   3 disabled
[    0.011231]   4 disabled
[    0.011232]   5 disabled
[    0.011233]   6 disabled
[    0.011234]   7 disabled
[    0.011236] TOM2: 000000083f000000 aka 33776M
[    0.012217] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.012493] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.012502] last_pfn = 0xbddde max_arch_pfn = 0x400000000
[    0.015067] found SMP MP-table at [mem 0x000f4f60-0x000f4f6f] mapped at [(____ptrval____)]
[    0.015285] Scanning 1 areas for low memory corruption
[    0.015288] Base memory trampoline at [(____ptrval____)] 84000 size 24576
[    0.015294] Using GB pages for direct mapping
[    0.015296] BRK [0x2b6a5f000, 0x2b6a5ffff] PGTABLE
[    0.015300] BRK [0x2b6a60000, 0x2b6a60fff] PGTABLE
[    0.015302] BRK [0x2b6a61000, 0x2b6a61fff] PGTABLE
[    0.015327] BRK [0x2b6a62000, 0x2b6a62fff] PGTABLE
[    0.015330] BRK [0x2b6a63000, 0x2b6a63fff] PGTABLE
[    0.015406] BRK [0x2b6a64000, 0x2b6a64fff] PGTABLE
[    0.015428] BRK [0x2b6a65000, 0x2b6a65fff] PGTABLE
[    0.015449] BRK [0x2b6a66000, 0x2b6a66fff] PGTABLE
[    0.015462] RAMDISK: [mem 0x36353000-0x371a0fff]
[    0.015470] ACPI: Early table checksum verification disabled
[    0.015525] ACPI: RSDP 0x00000000000F4EE000024 (v02 HP    )
[    0.015530] ACPI: XSDT 0x00000000BDDE1880 0000B4 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015538] ACPI: FACP 0x00000000BDDE1980 0000F4 (v03 HP     ProLiant 00000002 �?   0000162E)
[    0.015545] ACPI: DSDT 0x00000000BDDE1A80 00D2F7 (v01 HP     DSDT     00000001 INTL 20061109)
[    0.015550] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015554] ACPI: FACS 0x00000000BDDDE140 000040
[    0.015557] ACPI: SPCR 0x00000000BDDDE180 000050 (v01 HP     SPCRRBSU 00000001 �?   0000162E)
[    0.015561] ACPI: MCFG 0x00000000BDDDE200 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.015565] ACPI: HPET 0x00000000BDDDE240 000038 (v01 HP     ProLiant 00000002 �?   0000162E)
[    0.015569] ACPI: SPMI 0x00000000BDDDE280 000040 (v05 HP     ProLiant 00000001 �?   0000162E)
[    0.015573] ACPI: ERST 0x00000000BDDDE2C0 000230 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015577] ACPI: APIC 0x00000000BDDDE500 00009E (v01 HP     ProLiant 00000002      00000000)
[    0.015581] ACPI: SRAT 0x00000000BDDDE800 000128 (v02 AMD    AGESA    00000001 AMD  00000001)
[    0.015585] ACPI: FFFF 0x00000000BDDDF000 000176 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015589] ACPI: BERT 0x00000000BDDDF180 000030 (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015593] ACPI: HEST 0x00000000BDDDF1C0 00018C (v01 HP     ProLiant 00000001 �?   0000162E)
[    0.015596] ACPI: FFFF 0x00000000BDDDF380 000064 (v02 HP     ProLiant 00000002 �?   0000162E)
[    0.015600] ACPI: SLIT 0x00000000BDDDF400 000030 (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.015604] ACPI: FFFF 0x00000000BDDE1800 00006E (v01 HP     Proliant 00000001 PH   0000504D)
[    0.015608] ACPI: IVRS 0x00000000BDDDF800 0001A0 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.015612] ACPI: SSDT 0x00000000BDDEED80 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
[    0.015616] ACPI: SSDT 0x00000000BDDEEEC0 000377 (v01 HP     pmab     00000001 INTL 20120503)
[    0.015620] ACPI: SSDT 0x00000000BDDEF240 001714 (v02 AM   POWERNOW 00000001 AMD  00000001)
[    0.015627] ACPI: Local APIC address 0xfee00000
[    0.015674] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.015676] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.015678] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.015679] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.015680] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.015682] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.015683] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.015684] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.015687] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.015689] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.015691] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83effffff]
[    0.015695] NUMA: Initialized distance table, cnt=2
[    0.015698] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.015700] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x83effefff] -> [mem 0x00000000-0x83effefff]
[    0.015708] NODE_DATA(0) allocated [mem 0x83efe8000-0x83effdfff]
[    0.015746] Reserving 72MB of low memory at 2960MB for crashkernel (System low RAM: 3037MB)
[    0.015749] Reserving 116MB of memory at 33648MB for crashkernel (System RAM: 32717MB)
[    0.015795] Zone ranges:
[    0.015797]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015800]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015802]   Normal   [mem 0x0000000100000000-0x000000083effefff]
[    0.015804]   Device   empty
[    0.015805] Movable zone start for each node
[    0.015808] Early memory node ranges
[    0.015809]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.015811]   node   0: [mem 0x0000000000100000-0x00000000bddddfff]
[    0.015812]   node   0: [mem 0x0000000100000000-0x000000083effefff]
[    0.015996] Reserved but unavailable: 8836 pages
[    0.015998] Initmem setup node 0 [mem 0x0000000000001000-0x000000083effefff]
[    0.016001] On node 0 totalpages: 8375675
[    0.016003]   DMA zone: 64ages used for memmap
[    0.016004]   DMA zone: 42 pages reserved
[    0.016006]   DMA zone: 3998 pages, LIFO batch:0
[    0.016122]   DMA32 zone: 12088 pages used for memmap
[    0.016123]   DMA32 zone: 773598 pages, LIFO batch:63
[    0.039753]   Normal zone: 118720 pages used for memmap
[    0.039758]   Normal zone: 7598079 pages, LIFO batch:63
[    0.040941] ACPI: PM-Timer IO Port: 0x920
[    0.040945] ACPI: Local APIC address 0xfee00000
[    0.040954] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.040967] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
[    0.040970] IOAPIC[1]: apic_id 9, version 33, address 0xfaffc000, GSI 24-55
[    0.040973] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.040975] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.040977] ACPI: IRQ0 used by override.
[    0.040979] ACPI: IRQ9 used by override.
[    0.040983] Using ACPI (MADT) for SMP configuration information
[    0.040985] ACPI: HPET id: 0x1166a201 base: 0xfed00000
[    0.040988] ACPI: SPCR: SPCR table version 1
[    0.040989] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.040991] ACPI: SPCR: console: uart,mmio,0x0,115200
[    0.040994] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.040997] NODE_DATA(1) allocated [mem 0x83efc7000-0x83efdcfff]
[    0.040999]     NODE_DATA(1) on node 0
[    0.041021] Initmem setup node 1 [mem 0x0000000000000000-0x0000000000000000]
[    0.041023] On node 1 totalpages: 0
[    0.041036] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.041038] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.041040] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.041041] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.041043] PM: Registered nosave memory: [mem 0xbddde000-0xbde0dfff]
[    0.041044] PM: Registered nosave memory: [mem 0xbde0e000-0xcfffffff]
[    0.041046] PM: Registered nosave memory: [mem 0xd0000000-0xfebfffff]
[  0.041047] PM: Registered nosave memory: [mem 0xfec00000-0xfee0ffff]
[    0.041048] PM: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.041049] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.041052] [mem 0xd0000000-0xfebfffff] available for PCI devices
[    0.041054] Booting paravirtualized kernel on bare hardware
[    0.041057] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.190039] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:2
[    0.191119] percpu: Embedded 47 pages/cpu @(____ptrval____) s155648 r8192 d28672 u524288
[    0.191128] pcpu-alloc: s155648 r8192 d28672 u524288 alloc=1*2097152
[    0.191130] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7
[    0.191156] Built 2 zonelists, mobility grouping on.  Total pages: 8244761
[    0.191158] Policy zone: Normal
[    0.191161] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-rc3-default+ root=UUID=b314d001-d850-402f-8bce-77806d9f4aea sysrq_always_enabled panic=100 ignore_loglevel unknown_nmi_panic console=ttyS0,115200n8 resume=/dev/disk/by-uuid/bbe275bf-803c-44e6-90d7-1695025b0532 splash=silent quiet showopts crashkernel=116M,high crashkernel=72M,low nopti nospec nospectre_v2 nospec_store_bypass_disable initcall_debug
[    0.191209] sysrq: sysrq always enabled.
[    0.191381] log_buf_len individual max cpu contribution: 32768 bytes
[    0.191383] log_buf_len total cpu_extra contributions: 229376 bytes
[    0.191384] log_buf_len min size: 262144 bytes
[    0.191560] log_buf_len: 524288 bytes
[    0.191561] early log buf free: 250248(95%)
[    0.206246] AGP: Checking aperture...
[    0.214834] AGP: No AGP bridge found
[    0.214838] AGP: Node 0: aperture [bus addr 0xb0000000-0xb1ffffff] (32MB)
[    0.214839] Aperture pointing to e820 RAM. Ignoring.
[    0.214841] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.214842] AGP: Please enable the IOMMU option in the BIOS setup
[    0.214843] AGP: This costs you 64MB of RA
                                             [    0.214846] AGP: Mapping aperture over RAM [mem 0xb0000000-0xb3ffffff] (65536KB)
[    0.214849] PM: Registered nosave memory: [mem 0xb0000000-0xb3ffffff]
[    0.259666] Memory: 3021808K/33502700K available (12300K kernel code, 1503K rwdata, 3564K rodata, 2048K init, 1368K bss, 892412K reserved, 0K cma-reserved)
[    0.259799] ftrace: allocating 36145 entries in 142 pages
[    0.278428] rcu: Preemptible hierarchical RCU implementation.
[    0.278431] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.278432]  Tasks RCU enabled.
[    0.278434] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.282448] NR_IRQS: 33024, nr_irqs: 1032, preallocated irqs: 16
[    0.282752] spurious 8259A interrupt: IRQ7.
[    0.282964] calling  con_init+0x0/0x211 @ 0
[    0.287313] Console: colour VGA+ 80x25
[    0.287316] initcall con_init+0x0/0x211 returned 0 after 0 usecs
[    0.287318] calling  hvc_console_init+0x0/0x14 @ 0
[    0.287321] initcall hvc_console_init+0x0/0x14 returned 0 after 0 usecs
[    0.287324] calling  xen_cons_init+0x0/0x50 @ 0
[    0.287326] initcall xen_cons_init+0x0/0x50 returned 0 after 0 usecs
[    0.287329] calling  univ8250_console_init+0x0/0x27 @ 0
[    1.284365] console [ttyS0] enabled
[    1.285578] initcall univ8250_console_init+0x0/0x27 returned 0 after 0 usecs
[    1.288001] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.291731] ACPI: Core revision 20180810
[    1.293328] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    1.296601] hpet clockevent registered
[    1.297886] APIC: Switch to symmetric I/O mode setup
[    1.339075] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.360606] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28423ec566f, max_idle_ns: 440795221438 ns
[    1.364203] Calibrating delay loop (skipped), value calculated using timer frequency.. 5585.90 BogoMIPS (lpj=11171808)
[    1.368197] pid_max: default: 32768 minimum: 301
[    1.372299] Security Framework initialized
[    1.373683] calling  selinux_init+0x0/0x1f2 @ 0
[    1.375270] initcall selinux_init+0x0/0x1f2 returned 0 after 0 usecs
[    1.376198] calling  tomoyo_init+0x0/0x5d @ 0
[    1.377681] initcall tomoyo_init+0x0/0x5d returned 0 after 0 usecs
[    1.380197] calling  apparmor_init+0x0/0x24d @ 0
[    1.381767] AppArmor: AppArmor initialized
[    1.384198] initcall apparmor_init+0x0/0x24d returned 0 after 3906 usecs
[    1.386367] calling  integrity_iintcache_init+0x0/0x2e @ 0
[    1.388205] initcall integrity_iintcache_init+0x0/0x2e returned 0 after 0 usecs
[    1.399370] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    1.406053] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    1.408367] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.410943] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    1.412480] mce: CPU supports 7 MCE banks
[    1.413894] LVT offset 1 assigned for vector 0xf9
[    1.416201] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    1.418187] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    1.420200] Speculative Store Bypass: Vulnerable
[    1.429698] Freeing SMP alternatives memory: 32K
[    1.436195] smpboot: CPU0: AMD Opteron(tm) Processor 6320 (family: 0x15, model: 0x2, stepping: 0x0)
[    1.460210] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
[    1.462159] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
[    1.464202] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
[    1.466052] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
[    1.468200] calling  init_hw_perf_events+0x0/0x5b1 @ 1
[    1.469933] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    1.472197] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 430076)
[    1.476196] AMD PMU driver.
[    1.477160] ... version:                0
[    1.478492] ... bit width:              48
[    1.480196] ... generic registers:      6
[    1.481626] ... value mask:             0000ffffffffffff
[    1.483435] ... max period:             00007fffffffffff
[    1.484196] ... fixed-purpose events:   0
[    1.485549] ... event mask:             000000000000003f
[    1.488205] initcall init_hw_perf_events+0x0/0x5b1 returned 0 after 19531 usecs
[    1.490681] calling  init_real_mode+0x0/0x1d9 @ 1
[    1.492210] initcall init_real_mode+0x0/0x1d9 returned 0 after 0 usecs
[    1.494431] calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
[    1.496197] initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
[    1.498972] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
[    1.500198] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
[    1.504198] calling  kvm_setup_vsyscall_timeinfo+0x0/0x3b @ 1
[    1.506124] initcall kvm_setup_vsyscall_timeinfo+0x0/0x3b returned 0 after 0 usecs
[    1.508198] calling  early_efi_map_fb+0x0/0x32 @ 1
[    1.509788] initcall early_efi_map_fb+0x0/0x32 returned 0 after 0 usecs
[    1.512197] calling  spawn_ksoftirqd+0x0/0x39 @ 1
[    1.520203] initcall spawn_ksoftirqd+0x0/0x39 returned 0 after 7812 usecs
[    1.522564] calling  migration_init+0x0/0x34 @ 1
[    1.524143] initcall migration_init+0x0/0x34 returned 0 after 0 usecs
[    1.524201] calling  check_cpu_stall_init+0x0/0x1b @ 1
[    1.525903] initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
[    1.528197] calling  srcu_bootup_announce+0x0/0x34 @ 1
[    1.529980] rcu: Hierarchical SRCU implementation.
[    1.532197] initcall srcu_bootup_announce+0x0/0x34 returned 0 after 3906 usecs
[    1.534591] calling  rcu_spawn_gp_kthread+0x0/0x101 @ 1
[    1.536256] initcall rcu_spawn_gp_kthread+0x0/0x101 returned 0 after 0 usecs
[    1.540200] calling  cpu_stop_init+0x0/0x8a @ 1
[    1.548207] initcall cpu_stop_init+0x0/0x8a returned 0 after 7812 usecs
[    1.550437] calling  init_events+0x0/0x3a @ 1
[    1.552063] initcall init_events+0x0/0x3a returned 0 after 0 usecs
[    1.552198] calling  init_trace_printk+0x0/0xc @ 1
[    1.553764] initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
[    1.556197] calling  event_trace_enable_again+0x0/0x1f @ 1
[    1.558034] initcall event_trace_enable_again+0x0/0x1f returned 0 after 0 usecs
[    1.560198] calling  jump_label_init_module+0x0/0x11 @ 1
[    1.561977] initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
[    1.564198] calling  dynamic_debug_init+0x0/0x26a @ 1
[    1.568228] initcall dynamic_debug_init+0x0/0x26a returned 0 after 3906 usecs
[    1.570635] calling  rand_initialize+0x0/0x60 @ 1
[    1.572225] initcall rand_initialize+0x0/0x60 returned 0 after 0 usecs
[    1.574424] calling  idle_inject_init+0x0/0x11 @ 1
[    1.580202] initcall idle_inject_init+0x0/0x11 returned 0 after 7812 usecs
[    1.582625] calling  initialize_ptr_random+0x0/0x51 @ 1
[    1.584207] initcall initialize_ptr_random+0x0/0x51 returned 0 after 0 usecs
[    1.588214] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.596205] smp: Bringing up secondary CPUs ...
[    1.636256] x86: Booting SMP configuration:
[    1.637733] .... node  #0, CPUs:      #1 #2 #3
[    1.761961] .... node  #1, CPUs:   #4 #5 #6 #7
[    1.887122] smp: Brought up 2 nodes, 8 CPUs
[    1.889842] smpboot: Max logical packages: 1
[    1.891387] smpboot: Total of 8 processors activated (44687.23 BogoMIPS)
[    2.288207] node 0 initialised, 7397120 pages in 392ms
[    2.292257] devtmpfs: initialized
[    2.293475] x86/mm: Memory block size: 128MB
[    2.296586] calling  ipc_ns_init+0x0/0x48 @ 1
[    2.298128] initcall ipc_ns_init+0x0/0x48 returned 0 after 0 usecs
[    2.300177] calling  init_mmap_min_addr+0x0/0x16 @ 1
[    2.304199] initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
[    2.306378] calling  net_ns_init+0x0/0x111 @ 1
[    2.308216] initcall net_ns_init+0x0/0x111 returned 0 after 0 usecs
[    2.310361] calling  xen_pvh_gnttab_setup+0x0/0x34 @ 1
[    2.312199] initcall xen_pvh_gnttab_setup+0x0/0x34 returned -19 after 0 usecs
[    2.314634] calling  e820__register_nvs_regions+0x0/0x38 @ 1
[    2.316203] initcall e820__register_nvs_regions+0x0/0x38 returned 0 after 0 usecs
[    2.316203] calling  cpufreq_register_tsc_scaling+0x0/0x2b @ 1
[    2.318112] initcall cpufreq_register_tsc_scaling+0x0/0x2b returned 0 after 0 usecs
[    2.320198] calling  init_cpu_syscore+0x0/0xf @ 1
[    2.321885] initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
[    2.324198] calling  reboot_init+0x0/0x3d @ 1
[    2.325672] initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
[    2.327729] calling  init_lapic_sysfs+0x0/0x20 @ 1
[    2.332198] initcall init_lapic_sysfs+0x0/0x20 returned 0 after 0 usecs
[    2.332198] calling  uv_bau_init+0x0/0xfc3 @ 1
[    2.333701] initcall uv_bau_init+0x0/0xfc3 returned 0 after 0 usecs
[    2.335779] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    2.340198] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usecs
[    2.342376] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
[    2.344198] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
[    2.346571] calling  wq_sysfs_init+0x0/0x2b @ 1
[    2.346571] initcall wq_sysfs_init+0x0/0x2b returned 0 after 3906 usecs
[    2.346571] calling  ksysfs_init+0x0/0x93 @ 1
[    2.348205] initcall ksysfs_init+0x0/0x93 returned 0 after 0 usecs
[    2.350300] calling  pm_init+0x0/0x7f @ 1
[    2.352247] initcall pm_init+0x0/0x7f returned 0 after 0 usecs
[    2.354256] calling  pm_disk_init+0x0/0x18 @ 1
[    2.355760] initcall pmsk_init+0x0/0x18 returned 0 after 0 usecs
[    2.460200] calling  swsusp_header_init+0x0/0x30 @ 1
[    2.461906] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    2.464197] calling  rcu_set_runtime_mode+0x0/0x12 @ 1
[    2.465915] initcall rcu_set_runtime_mode+0x0/0x12 returned 0 after 0 usecs
[    2.468197] calling  rcu_spawn_tasks_kthread+0x0/0x46 @ 1
[    2.469996] initcall rcu_spawn_tasks_kthread+0x0/0x46 returned 0 after 0 usecs
[    2.472198] calling  init_jiffies_clocksource+0x0/0x18 @ 1
[    2.472198] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.475345] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 3906 usecs
[    2.480197] calling  futex_init+0x0/0xe8 @ 1
[    2.481610] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.484223] initcall futex_init+0x0/0xe8 returned 0 after 3906 usecs
[    2.486380] calling  cgroup_wq_init+0x0/0x30 @ 1
[    2.486380] initcall cgroup_wq_init+0x0/0x30 returned 0 after 0 usecs
[    2.486380] calling  cgroup1_wq_init+0x0/0x30 @ 1
[    2.488228] initcall cgroup1_wq_init+0x0/0x30 returned 0 after 0 usecs
[    2.490417] calling  ftrace_mod_cmd_init+0x0/0x9 @ 1
[    2.492199] initcall ftrace_mod_cmd_init+0x0/0x9 returned 0 after 0 usecs
[    2.494358] calling  init_wakeup_tracer+0x0/0x2d @ 1
[    2.496200] initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
[    2.498425] calling  init_graph_trace+0x0/0x61 @ 1
[    2.500201] initcall init_graph_trace+0x0/0x61 returned 0 after 0 usecs
[    2.502465] calling  init_per_zone_wmark_min+0x0/0x6f @ 1
[    2.504204] initcall init_per_zone_wmark_min+0x0/0x6f returned 0 after 0 usecs
[    2.506623] calling  init_zero_pfn+0x0/0x3f @ 1
[    2.508197] initcall init_zero_pfn+0x0/0x3f returned 0 after 0 usecs
[    2.510301] calling  memory_failure_init+0x0/0x9b @ 1
[    2.512199] initcall memory_failure_init+0x0/0x9b returned 0 after 0 usecs
[    2.514459] calling  fsnotify_init+0x0/0x4b @ 1
[    2.516214nitcall fsnotify_init+0x0/0x4b returned 0 after 0 usecs
[    2.620199] calling  filelock_init+0x0/0x8c @ 1
[    2.621745] initcall filelock_init+0x0/0x8c returned 0 after 0 usecs
[    2.624197] calling  init_script_binfmt+0x0/0x16 @ 1
[    2.625844] initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
[    2.628197] calling  init_elf_binfmt+0x0/0x16 @ 1
[    2.629787] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    2.632197] calling  init_compat_elf_binfmt+0x0/0x16 @ 1
[    2.634054] initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    2.636198] calling  debugfs_init+0x0/0x53 @ 1
[    2.637668] initcall debugfs_init+0x0/0x53 returned 0 after 0 usecs
[    2.640197] calling  tracefs_init+0x0/0x3a @ 1
[    2.641700] initcall tracefs_init+0x0/0x3a returned 0 after 0 usecs
[    2.644198] calling  securityfs_init+0x0/0x74 @ 1
[    2.645796] initcall securityfs_init+0x0/0x74 returned 0 after 0 usecs
[    2.648197] calling  prandom_init+0x0/0xd8 @ 1
[    2.649656] initcall prandom_init+0x0/0xd8 returned 0 after 0 usecs
[    2.649656] calling  pinctrl_init+0x0/0xb2 @ 1
[    2.649713] pinctrl core: initialized pinctrl subsystem
[    2.652215] initcall pinctrl_init+0x0/0xb2 returned 0 after 0 usecs
[    2.654319] calling  gpiolib_dev_init+0x0/0xcf @ 1
[    2.655921] initcall gpiolib_dev_init+0x0/0xcf returned 0 after 0 usecs
[    2.660198] calling  virtio_init+0x0/0x30 @ 1
[    2.661636] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
[    2.664197] calling  iommu_init+0x0/0x2b @ 1
[    2.665658] initcall iommu_init+0x0/0x2b returned 0 after 0 usecs
[    2.665658] calling  component_debug_init+0x0/0x1d @ 1
[    2.665974] initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
[    2.668199] calling  early_resume_init+0x0/0xd0 @ 1
[    2.669918] RTC time: 15:15:19, date: 09/13/18
[    2.672198] initcall early_resume_init+0x0/0xd0 returned 0 after 0 usecs
[    2.674419] calling  opp_debug_init+0x0/0x3d @ 1
[    2.676199] initcall opp_de_init+0x0/0x3d returned 0 after 0 usecs
[    2.780199] calling  cpufreq_core_init+0x0/0x4c @ 1
[    2.781848] initcall cpufreq_core_init+0x0/0x4c returned 0 after 0 usecs
[    2.784197] calling  cpuidle_init+0x0/0x3d @ 1
[    2.785693] initcall cpuidle_init+0x0/0x3d returned 0 after 0 usecs
[    2.788197] calling  capsule_reboot_register+0x0/0x11 @ 1
[    2.789972] initcall capsule_reboot_register+0x0/0x11 returned 0 after 0 usecs
[    2.792198] calling  bsp_pm_check_init+0x0/0x14 @ 1
[    2.793948] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
[    2.796198] calling  sock_init+0x0/0x9a @ 1
[    2.797714] initcall sock_init+0x0/0x9a returned 0 after 0 usecs
[    2.800198] calling  net_inuse_init+0x0/0x26 @ 1
[    2.801756] initcall net_inuse_init+0x0/0x26 returned 0 after 0 usecs
[    2.804198] calling  net_defaults_init+0x0/0x26 @ 1
[    2.805835] initcall net_defaults_init+0x0/0x26 returned 0 after 0 usecs
[    2.808198] calling  init_default_flow_dissectors+0x0/0x50 @ 1
[    2.810106] initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
[    2.812197] calling  netpoll_init+0x0/0x31 @ 1
[    2.813744] initcall netpoll_init+0x0/0x31 returned 0 after 0 usecs
[    2.816197] calling  netlink_proto_init+0x0/0x153 @ 1
[    2.817912] NET: Registered protocol family 16
[    2.817912] initcall netlink_proto_init+0x0/0x153 returned 0 after 0 usecs
[    2.818515] calling  __gnttab_init+0x0/0x30 @ 1
[    2.820198] initcall __gnttab_init+0x0/0x30 returned -19 after 0 usecs
[    2.822429] calling  irq_sysfs_init+0x0/0x8d @ 1
[    2.824277] initcall irq_sysfs_init+0x0/0x8d returned 0 after 0 usecs
[    2.826463] calling  audit_init+0x0/0x1a7 @ 1
[    2.828198] audit: initializing netlink subsys (disabled)
[    2.832224] initcall audit_init+0x0/0x1a7 returned 0 after 3906 usecs
[    2.832224] audit: type=2000 audit(1536851718.496:1): state=initialized audit_enabled=0 res=1
[    2.832224] calling  release_early_probes+0x0/0x33 @ 1
[    2.836198] initcall release_ly_probes+0x0/0x33 returned 0 after 0 usecs
[    2.940201] calling  bdi_class_init+0x0/0x49 @ 1
[    2.940204] initcall bdi_class_init+0x0/0x49 returned 0 after 0 usecs
[    2.942384] calling  mm_sysfs_init+0x0/0x29 @ 1
[    2.944198] initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usecs
[    2.946325] calling  gpiolib_sysfs_init+0x0/0x9d @ 1
[    2.948203] initcall gpiolib_sysfs_init+0x0/0x9d returned 0 after 0 usecs
[    2.951043] calling  pcibus_class_init+0x0/0x18 @ 1
[    2.956200] initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
[    2.958341] calling  pci_driver_init+0x0/0x22 @ 1
[    2.958341] initcall pci_driver_init+0x0/0x22 returned 0 after 0 usecs
[    2.958351] calling  backlight_class_init+0x0/0xa9 @ 1
[    2.960200] initcall backlight_class_init+0x0/0xa9 returned 0 after 0 usecs
[    2.962469] calling  xenbus_init+0x0/0x285 @ 1
[    2.964197] initcall xenbus_init+0x0/0x285 returned -19 after 0 usecs
[    2.966323] calling  tty_class_init+0x0/0x34 @ 1
[    2.968200] initcall tty_class_init+0x0/0x34 returned 0 after 0 usecs
[    2.970388] calling  vtconsole_class_init+0x0/0xc3 @ 1
[    2.972215] initcall vtconsole_class_init+0x0/0xc3 returned 0 after 0 usecs
[    2.974549] calling  iommu_dev_init+0x0/0x18 @ 1
[    2.976200] initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
[    2.978343] calling  mipi_dsi_bus_init+0x0/0x11 @ 1
[    2.979976] initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
[    2.984198] calling  wakeup_sources_debugfs_init+0x0/0x2b @ 1
[    2.984199] initcall wakeup_sources_debugfs_init+0x0/0x2b returned 0 after 0 usecs
[    2.986696] calling  isa_bus_init+0x0/0x3c @ 1
[    2.988210] initcall isa_bus_init+0x0/0x3c returned 0 after 0 usecs
[    2.990268] calling  register_node_type+0x0/0x2f @ 1
[    2.992017] initcall register_node_type+0x0/0x2f returned 0 after 0 usecs
[    2.996198] calling  regmap_initcall+0x0/0xd @ 1
[    2.997704] initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
[    3.000197] calling  sinit+0x0/0x99 @ 1
[    3.100206] initcall spi_init+0x0/0x99 returned 0 after 0 usecs
[    3.104197] calling  i2c_init+0x0/0x89 @ 1
[    3.105586] initcall i2c_init+0x0/0x89 returned 0 after 0 usecs
[    3.105586] calling  init_ladder+0x0/0x24 @ 1
[    3.108227] cpuidle: using governor ladder
[    3.109585] initcall init_ladder+0x0/0x24 returned 0 after 0 usecs
[    3.112199] calling  init_menu+0x0/0x11 @ 1
[    3.113747] cpuidle: using governor menu
[    3.115057] initcall init_menu+0x0/0x11 returned 0 after 0 usecs
[    3.116197] calling  pcc_init+0x0/0xa0 @ 1
[    3.117611] initcall pcc_init+0x0/0xa0 returned -19 after 0 usecs
[    3.120198] calling  amd_postcore_init+0x0/0x11a @ 1
[    3.121841] initcall amd_postcore_init+0x0/0x11a returned 0 after 0 usecs
[    3.124199] calling  kobject_uevent_init+0x0/0xc @ 1
[    3.125906] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
[    3.128264] calling  bts_init+0x0/0xbc @ 1
[    3.129641] initcall bts_init+0x0/0xbc returned -19 after 0 usecs
[    3.132198] calling  pt_init+0x0/0x384 @ 1
[    3.133680] initcall pt_init+0x0/0x384 returned -19 after 0 usecs
[    3.135653] calling  boot_params_ksysfs_init+0x0/0x26f @ 1
[    3.136203] initcall boot_params_ksysfs_init+0x0/0x26f returned 0 after 0 usecs
[    3.140197] calling  sbf_init+0x0/0xf3 @ 1
[    3.141566] initcall sbf_init+0x0/0xf3 returned 0 after 0 usecs
[    3.143651] calling  arch_kdebugfs_init+0x0/0x24 @ 1
[    3.144202] initcall arch_kdebugfs_init+0x0/0x24 returned 0 after 0 usecs
[    3.146463] calling  intel_pconfig_init+0x0/0xcc @ 1
[    3.148198] initcall intel_pconfig_init+0x0/0xcc returned 0 after 0 usecs
[    3.150443] calling  mtrr_if_init+0x0/0x61 @ 1
[    3.152199] initcall mtrr_if_init+0x0/0x61 returned 0 after 0 usecs
[    3.154283] calling  ffh_cstate_init+0x0/0x2b @ 1
[    3.156199] initcall ffh_cstate_init+0x0/0x2b returned 0 after 0 usecs
[    3.158308] calling  activate_jump_labels+0x0/0x32 @ 1
[    3.160239] initcall activate_jump_labels+0x0/0xreturned 0 after 0 usecs
[    3.164199] calling  kvm_setup_pv_tlb_flush+0x0/0xac @ 1
[    3.168198] initcall kvm_setup_pv_tlb_flush+0x0/0xac returned 0 after 0 usecs
[    3.170783] calling  gigantic_pages_init+0x0/0x30 @ 1
[    3.172200] initcall gigantic_pages_init+0x0/0x30 returned 0 after 0 usecs
[    3.174430] calling  uv_rtc_setup_clock+0x0/0x151 @ 1
[    3.176198] initcall uv_rtc_setup_clock+0x0/0x151 returned -19 after 0 usecs
[    3.178629] calling  kcmp_cookies_init+0x0/0x38 @ 1
[    3.180199] initcall kcmp_cookies_init+0x0/0x38 returned 0 after 0 usecs
[    3.182423] calling  acpi_pci_init+0x0/0x66 @ 1
[    3.184196] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.186716] ACPI: bus type PCI registered
[    3.188197] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.190355] initcall acpi_pci_init+0x0/0x66 returned 0 after 3906 usecs
[    3.192197] calling  dma_channel_table_init+0x0/0xcf @ 1
[    3.193973] initcall dma_channel_table_init+0x0/0xcf returned 0 after 0 usecs
[    3.196197] calling  dma_bus_init+0x0/0xc3 @ 1
[    3.197699] initcall dma_bus_init+0x0/0xc3 returned 0 after 0 usecs
[    3.200197] calling  setup_vcpu_hotplug_event+0x0/0x32 @ 1
[    3.201978] initcall setup_vcpu_hotplug_event+0x0/0x32 returned -19 after 0 usecs
[    3.204197] calling  register_xen_pci_notifier+0x0/0x2d @ 1
[    3.206077] initcall register_xen_pci_notifier+0x0/0x2d returned 0 after 0 usecs
[    3.208197] calling  xen_pcpu_init+0x0/0xb7 @ 1
[    3.209725] initcall xen_pcpu_init+0x0/0xb7 returned -19 after 0 usecs
[    3.212197] calling  dmi_id_init+0x0/0x345 @ 1
[    3.213689] initcall dmi_id_init+0x0/0x345 returned 0 after 0 usecs
[    3.216197] calling  ts_dmi_init+0x0/0x5d @ 1
[    3.217717] initcall ts_dmi_init+0x0/0x5d returned 0 after 0 usecs
[    3.220197] calling  pci_arch_init+0x0/0x68 @ 1
[    3.221754] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    3.224199] PCI: MMCONFIG at [mem 0xc0000-0xcfffffff] reserved in E820
[    3.228210] PCI: Using configuration type 1 for base access
[    3.232201] initcall pci_arch_init+0x0/0x68 returned 0 after 11718 usecs
[    3.234530] calling  init_vdso+0x0/0x40 @ 1
[    3.236212] initcall init_vdso+0x0/0x40 returned 0 after 0 usecs
[    3.238249] calling  sysenter_setup+0x0/0x14 @ 1
[    3.240201] initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
[    3.242436] calling  fixup_ht_bug+0x0/0xa1 @ 1
[    3.244198] initcall fixup_ht_bug+0x0/0xa1 returned 0 after 0 usecs
[    3.246309] calling  topology_init+0x0/0xc7 @ 1
[    3.249031] initcall topology_init+0x0/0xc7 returned 0 after 0 usecs
[    3.251207] calling  mtrr_init_finialize+0x0/0x3f @ 1
[    3.252199] initcall mtrr_init_finialize+0x0/0x3f returned 0 after 0 usecs
[    3.254543] calling  uid_cache_init+0x0/0x8c @ 1
[    3.256200] initcall uid_cache_init+0x0/0x8c returned 0 after 0 usecs
[    3.258351] calling  param_sysfs_init+0x0/0x1bf @ 1
[    3.261599] initcall param_sysfs_init+0x0/0x1bf returned 0 after 0 usecs
[    3.264206] calling  user_namespace_sysctl_init+0x0/0x3b @ 1
[    3.266130] initcall user_namespace_sysctl_init+0x0/0x3b returned 0 after 0 usecs
[    3.268198] calling  proc_schedstat_init+0x0/0x25 @ 1
[    3.269848] initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
[    3.272206] calling  pm_sysrq_init+0x0/0x19 @ 1
[    3.273703] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
[    3.276205] calling  create_proc_profile+0x0/0xd0 @ 1
[    3.277885] initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
[    3.280198] calling  crash_save_vmcoreinfo_init+0x0/0x643 @ 1
[    3.282251] initcall crash_save_vmcoreinfo_init+0x0/0x643 returned 0 after 0 usecs
[    3.284198] calling  crash_notes_memory_init+0x0/0x37 @ 1
[    3.285986] initcall crash_notes_memory_init+0x0/0x37 returned 0 after 0 usecs
[    3.288197] calling  cgroup_sysfs_init+0x0/0x18 @ 1
[    3.289893] initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    3.292197] calling  cgroup_namespaces_init+0x0/0x8 @ 1
[    3.294076] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
[    3.296197] calli user_namespaces_init+0x0/0x2d @ 1
[    3.300199] initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
[    3.304197] calling  hung_task_init+0x0/0x51 @ 1
[    3.305777] initcall hung_task_init+0x0/0x51 returned 0 after 0 usecs
[    3.308199] calling  dev_map_init+0x0/0x14 @ 1
[    3.309687] initcall dev_map_init+0x0/0x14 returned 0 after 0 usecs
[    3.312198] calling  stack_map_init+0x0/0x49 @ 1
[    3.313791] initcall stack_map_init+0x0/0x49 returned 0 after 0 usecs
[    3.316197] calling  oom_init+0x0/0x3e @ 1
[    3.317567] initcall oom_init+0x0/0x3e returned 0 after 0 usecs
[    3.320198] calling  default_bdi_init+0x0/0xba @ 1
[    3.321832] initcall default_bdi_init+0x0/0xba returned 0 after 0 usecs
[    3.324198] calling  cgwb_init+0x0/0x30 @ 1
[    3.325755] initcall cgwb_init+0x0/0x30 returned 0 after 0 usecs
[    3.327909] calling  percpu_enable_async+0x0/0xf @ 1
[    3.328197] initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
[    3.330429] calling  kcompactd_init+0x0/0x99 @ 1
[    3.332225] initcall kcompactd_init+0x0/0x99 returned 0 after 0 usecs
[    3.334468] calling  init_user_reserve+0x0/0x40 @ 1
[    3.336198] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    3.338456] calling  init_admin_reserve+0x0/0x40 @ 1
[    3.340197] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    3.342692] calling  init_reserve_notifier+0x0/0x21 @ 1
[    3.344198] initcall init_reserve_notifier+0x0/0x21 returned 0 after 0 usecs
[    3.346603] calling  swap_init_sysfs+0x0/0x67 @ 1
[    3.348200] initcall swap_init_sysfs+0x0/0x67 returned 0 after 0 usecs
[    3.350363] calling  swapfile_init+0x0/0xbc @ 1
[    3.352198] initcall swapfile_init+0x0/0xbc returned 0 after 0 usecs
[    3.354292] calling  hugetlb_init+0x0/0x18 @ 1
[    3.356200] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    3.358428] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    3.360219] initcall hugetlb_init+0x0/0x18 returned 0 afte906 usecs
[    3.364198] calling  ksm_init+0x0/0x2a5 @ 1
[    3.368216] initcall ksm_init+0x0/0x2a5 returned 0 after 0 usecs
[    3.370302] calling  hugepage_init+0x0/0x15a @ 1
[    3.372224] initcall hugepage_init+0x0/0x15a returned 0 after 0 usecs
[    3.374353] calling  mem_cgroup_init+0x0/0x148 @ 1
[    3.376243] initcall mem_cgroup_init+0x0/0x148 returned 0 after 0 usecs
[    3.378437] calling  mem_cgroup_swap_init+0x0/0x52 @ 1
[    3.380198] initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
[    3.382525] calling  sel_ib_pkey_init+0x0/0x32 @ 1
[    3.384198] initcall sel_ib_pkey_init+0x0/0x32 returned 0 after 0 usecs
[    3.386384] calling  crypto_wq_init+0x0/0x33 @ 1
[    3.388227] initcall crypto_wq_init+0x0/0x33 returned 0 after 3906 usecs
[    3.390532] calling  cryptomgr_init+0x0/0x11 @ 1
[    3.392086] initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
[    3.392198] calling  init_bio+0x0/0xd1 @ 1
[    3.393589] initcall init_bio+0x0/0xd1 returned 0 after 0 usecs
[    3.394269] calling  blk_settings_init+0x0/0x2a @ 1
[    3.396199] initcall blk_settings_init+0x0/0x2a returned 0 after 0 usecs
[    3.398477] calling  blk_ioc_init+0x0/0x2a @ 1
[    3.400198] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
[    3.402240] calling  blk_softirq_init+0x0/0x74 @ 1
[    3.403833] initcall blk_softirq_init+0x0/0x74 returned 0 after 0 usecs
[    3.408197] calling  blk_mq_init+0x0/0x2a @ 1
[    3.409714] initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
[    3.412197] calling  genhd_device_init+0x0/0x76 @ 1
[    3.413857] initcall genhd_device_init+0x0/0x76 returned 0 after 0 usecs
[    3.416199] calling  irq_poll_setup+0x0/0x6f @ 1
[    3.417749] initcall irq_poll_setup+0x0/0x6f returned 0 after 0 usecs
[    3.420197] calling  byt_gpio_init+0x0/0x13 @ 1
[    3.421701] initcall byt_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    3.423845] calling  gpiolib_debugfs_init+0x0/0x24 @ 1
[    3.424199] initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    3.428197] calling  pwm_debugfs_init+0x0/0 @ 1
[    3.432200] initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    3.434413] calling  pwm_sysfs_init+0x0/0x18 @ 1
[    3.436201] initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    3.438364] calling  pci_slot_init+0x0/0x50 @ 1
[    3.440199] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    3.442356] calling  fbmem_init+0x0/0xe3 @ 1
[    3.444221] initcall fbmem_init+0x0/0xe3 returned 0 after 0 usecs
[    3.446239] calling  scan_for_dmi_ipmi+0x0/0x10b @ 1
[    3.448219] initcall scan_for_dmi_ipmi+0x0/0x10b returned 0 after 0 usecs
[    3.450495] calling  acpi_init+0x0/0x34f @ 1
[    3.452256] ACPI: Added _OSI(Module Device)
[    3.453766] ACPI: Added _OSI(Processor Device)
[    3.455249] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.456197] ACPI: Added _OSI(Processor Aggregator Device)
[    3.457984] ACPI: Added _OSI(Linux-Dell-Video)
[    3.460197] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.479820] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    3.502151] ACPI: Interpreter enabled
[    3.503428] ACPI: (supports S0 S4 S5)
[    3.504199] ACPI: Using IOAPIC for interrupt routing
[    3.505991] HEST: Table parsing has been initialized.
[    3.508198] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.543371] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    3.544203] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.548372] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    3.551835] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    3.552198] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    3.556197] acpi PNP0A08:00: _OSC: platform willing to grant []
[    3.558147] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    3.560730] PCI host bridge to bus 0000:00
[    3.564198] pci_bus 0000:00: root bus resource [mem 0xfaf00000-0xfdffffff window]
[    3.566711] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
[    3.568197] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    3.570449] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    3.572197] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    3.574534] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed03fff window]
[    3.576197] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    3.580197] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    3.582469] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    3.584197] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.586658] pci_bus 0000:00: root bus resource [bus 00-3f]
[    3.588206] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    3.590200] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.592198] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.596424] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    3.598657] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    3.600214] pci 0000:00:02.0: enabling Extended Tags
[    3.601886] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    3.604410] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    3.60657pci 0000:00:0a.0: enabling Extended Tags
[    3.608224] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    3.610504] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    3.612214] pci 0000:00:0c.0: enabling Extended Tags
[    3.614022] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    3.616409] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    3.618414] pci 0000:00:11.0: calling  quirk_no_ata_d3+0x0/0x10 @ 1
[    3.620198] pci 0000:00:11.0: quirk_no_ata_d3+0x0/0x10 took 0 usecs
[    3.622295] pci 0000:00:11.0: reg 0x10: [io  0x1000-0x1007]
[    3.624205] pci 0000:00:11.0: reg 0x14: [io  0x1008-0x100b]
[    3.626051] pci 0000:00:11.0: reg 0x18: [io  0x1010-0x1017]
[    3.628204] pci 0000:00:11.0: reg 0x1c: [io  0x1018-0x101b]
[    3.630016] pci 0000:00:11.0: reg 0x20: [io  0x1020-0x102f]
[    3.632205] pci 0000:00:11.0: reg 0x24: [mem 0xfccf0000-0xfccf03ff]
[    3.634348] pci 0000:00:11.0: calling  quirk_amd_ide_mode+0x0/0xb0 @ 1
[    3.636204] pci 0000:00:11.0: set SATA to AHCI mode
[    3.637806] pci 0000:00:11.0: quirk_amd_ide_mode+0x0/0xb0 took 0 usecs
[    3.640407] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    3.642557] pci 0000:00:12.0: reg 0x10: [mem 0xfcce0000-0xfcce0fff]
[    3.644436] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    3.646550] pci 0000:00:12.1: reg 0x10: [mem 0xfccd0000-0xfccd0fff]
[    3.648435] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    3.650473] pci 0000:00:12.2: reg 0x10: [mem 0xfccc0000-0xfccc00ff]
[    3.652277] pci 0000:00:12.2: supports D1 D2
[    3.653707] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    3.656395] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    3.658502] pci 0000:00:13.0: reg 0x10: [mem 0xfccb0000-0xfccb0fff]
[    3.660432] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    3.664214] pci 0000:00:13.1: reg 0x10: [mem 0xfcca0000-0xfcca0fff]
[    3.666498] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    3.668218] pci 0000:00:13.2: reg 0x10: [mem 0xfcc90000-0xfcc900ff]
[    3.670418] pci 0000:00:13.2: supports D1 D2
[    3.672197] pci 0000:00:2: PME# supported from D0 D1 D2 D3hot
[    3.676395] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    3.680202] pci 0000:00:14.0: calling  sb600_disable_hpet_bar+0x0/0x50 @ 1
[    3.682464] pci 0000:00:14.0: sb600_disable_hpet_bar+0x0/0x50 took 0 usecs
[    3.684263] pci 0000:00:14.0: calling  force_disable_hpet_msi+0x0/0x10 @ 1
[    3.686654] pci 0000:00:14.0: force_disable_hpet_msi+0x0/0x10 took 0 usecs
[    3.688198] pci 0000:00:14.0: calling  sb600_hpet_quirk+0x0/0x50 @ 1
[    3.692197] pci 0000:00:14.0: sb600_hpet_quirk+0x0/0x50 took 0 usecs
[    3.694483] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    3.696202] pci 0000:00:14.1: calling  quirk_no_ata_d3+0x0/0x10 @ 1
[    3.698633] pci 0000:00:14.1: quirk_no_ata_d3+0x0/0x10 took 0 usecs
[    3.700212] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
[    3.702094] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
[    3.704205] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
[    3.706280] pci 0000:00:14.1: reg 0x1c: [io  0x0374-0x0377]
[    3.708204] pci 0000:00:14.1: reg 0x20: [io  0x0500-0x050f]
[    3.710128] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    3.712197] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    3.714365] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    3.716197] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    3.720245] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    3.722495] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    3.724421] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    3.726480] pci 0000:00:18.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.728198] pci 0000:00:18.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.730579] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    3.732199] pci 0000:00:18.1: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.734509] pci 0000:00:18.1: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.736383] pci 0000:00:18.2: [1022:1602] t 00 class 0x060000
[    3.740199] pci 0000:00:18.2: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.742437] pci 0000:00:18.2: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.744383] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    3.746522] pci 0000:00:18.3: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.748198] pci 0000:00:18.3: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.750680] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    3.752199] pci 0000:00:18.4: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.756198] pci 0000:00:18.4: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.758670] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    3.760199] pci 0000:00:18.5: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.762430] pci 0000:00:18.5: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.764383] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    3.766438] pci 0000:00:19.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.768198] pci 0000:00:19.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.772392] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[    3.774408] pci 0000:00:19.1: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.776198] pci 0000:00:19.1: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.778731] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    3.780199] pci 0000:00:19.2: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.782450] pci 0000:00:19.2: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.784384] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    3.788199] pci 0000:00:19.3: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.790450] pci 0000:00:19.3: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.792388] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    3.794460] pci 0000:00:19.4: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.796199] pci 0000:00:19.4: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.798676] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    3.800199] pci 0000:00:19.5: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    3.804198] pci 0000:19.5: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    3.808431] pci 0000:03:00.0: [103c:323b] type 00 class 0x010400
[    3.812213] pci 0000:03:00.0: reg 0x10: [mem 0xfdf00000-0xfdffffff 64bit]
[    3.814500] pci 0000:03:00.0: reg 0x18: [mem 0xfdef0000-0xfdef03ff 64bit]
[    3.816202] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
[    3.818079] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    3.820201] pci 0000:03:00.0: enabling Extended Tags
[    3.821876] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    3.824219] pci 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x8 link at 0000:00:02.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[    3.828243] pci 0000:00:02.0: PCI bridge to [bus 03]
[    3.830043] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    3.832198] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    3.836258] pci 0000:02:00.0: [103c:3306] type 00 class 0x088000
[    3.838312] pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
[    3.840206] pci 0000:02:00.0: reg 0x14: [mem 0xfddf0000-0xfddf01ff]
[    3.842325] pci 0000:02:00.0: reg 0x18: [io  0x3400-0x34ff]
[    3.844309] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:0a.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    3.848256] pci 0000:02:00.1: [102b:0533] type 00 class 0x030000
[    3.850276] pci 0000:02:00.1: reg 0x10: [mem 0xfb000000-0xfbffffff pref]
[    3.852205] pci 0000:02:00.1: reg 0x14: [mem 0xfdde0000-0xfdde3fff]
[    3.854343] pci 0000:02:00.1: reg 0x18: [mem 0xfd000000-0xfd7fffff]
[    3.856249] pci 0000:02:00.1: calling  efifb_fixup_resources+0x0/0x100 @ 1
[    3.858559] pci 0000:02:00.1: efifb_fixup_resources+0x0/0x100 took 0 usecs
[    3.860306] pci 0000:02:00.2: [103c:3307] type 00 class 0x088000
[    3.864219] pci 0000:02:00.2: reg 0x10: [io  0x3800-0x38ff]
[    3.866124] pci 0000:02:00.2: reg 0x14: [mem 0xfcff0000-0xfcff00ff]
[    3.868205] pci 0000:02:00.2: reg 0x18: [mem 0xfce00000-0xfcefffff]
[    3.870208] pci 0000:02:00.2: reg 0x1cmem 0xfcd80000-0xfcdfffff]
[    3.872206] pci 0000:02:00.2: reg 0x20: [mem 0xfcd70000-0xfcd77fff]
[    3.874596] pci 0000:02:00.2: reg 0x24: [mem 0xfcd60000-0xfcd67fff]
[    3.876206] pci 0000:02:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    3.878509] pci 0000:02:00.2: PME# supported from D0 D3hot D3cold
[    3.880269] pci 0000:02:00.4: [103c:3300] type 00 class 0x0c0300
[    3.882256] pci 0000:02:00.4: reg 0x20: [io  0x3c00-0x3c1f]
[    3.896218] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    3.898384] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    3.900199] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    3.902529] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    3.904322] pci 0000:04:00.0: [14e4:1657] type 00 class 0x020000
[    3.906351] pci 0000:04:00.0: reg 0x10: [mem 0xfcbf0000-0xfcbfffff 64bit pref]
[    3.908207] pci 0000:04:00.0: reg 0x18: [mem 0xfcbe0000-0xfcbeffff 64bit pref]
[    3.912207] pci 0000:04:00.0: reg 0x20: [mem 0xfcbd0000-0xfcbdffff 64bit pref]
[    3.914890] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    3.916285] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    3.918377] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:0c.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
[    3.920301] pci 0000:04:00.1: [14e4:1657] type 00 class 0x020000
[    3.922357] pci 0000:04:00.1: reg 0x10: [mem 0xfcbc0000-0xfcbcffff 64bit pref]
[    3.924207] pci 0000:04:00.1: reg 0x18: [mem 0xfcbb0000-0xfcbbffff 64bit pref]
[    3.926627] pci 0000:04:00.1: reg 0x20: [mem 0xfcba0000-0xfcbaffff 64bit pref]
[    3.928203] pci 0000:04:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    3.932257] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    3.934373] pci 0000:04:00.2: [14e4:1657] type 00 class 0x020000
[    3.936218] pci 0000:04:00.2: reg 0x10: [mem 0xfcb90000-0xfcb9ffff 64bit pref]
[    3.938734] pci 0000:04:00.2: reg 0x18: [mem 0xfcb80000-0xfcb8ffff 64bit pref]
[    3.940206] pci 0000:04:00.2: reg 0x20: [mem 0xfcb70000-0xfcb7ffff 64bit pref]
[    3.942596] pci 0000:04:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    3.944257] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
[    3.948275] pci 0000:04:00.3: [14e4:1657] type 00 class 0x020000
[    3.950304] pci 0000:04:00.3: reg 0x10: [mem 0xfcb60000-0xfcb6ffff 64bit pref]
[    3.952208] pci 0000:04:00.3: reg 0x18: [mem 0xfcb50000-0xfcb5ffff 64bit pref]
[   954625] pci 0000:04:00.3: reg 0x20: [mem 0xfcb40000-0xfcb4ffff 64bit pref]
[    3.956203] pci 0000:04:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    3.958594] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    3.960316] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    3.962006] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    3.964208] pci_bus 0000:01: extended config space not accessible
[    3.968258] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    3.970567] pci 0000:00:14.4:   bridge window [mem 0xfaf00000-0xfdffffff window] (subtractive decode)
[    3.972197] pci 0000:00:14.4:   bridge window [io  0x1000-0xffff window] (subtractive decode)
[    3.976197] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    3.979051] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    3.980197] pci 0000:00:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
[    3.984197] pci 0000:00:14.4:   bridge window [mem 0xfed00000-0xfed03fff window] (subtractive decode)
[    3.988197] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
[    3.991277] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    3.992197] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    3.996197] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    4.000729] ACPI: PCI Interrupt Link [I020] (IRQs *24)
[    4.002947] ACPI: PCI Interrupt Link [I021] (IRQs *25)
[    4.004697] ACPI: PCI Interrupt Link [I022] (IRQs *26)
[    4.006963] ACPI: PCI Interrupt Link [I023] (IRQs *27)
[    4.008685] ACPI: PCI Interrupt Link [I030] (IRQs *28)
[    4.010897] ACPI: PCI Interrupt Link [I031] (IRQs *29)
[    4.012712] ACPI: PCI Interrupt Link [I032] (IRQs *30)
[    4.016701] ACPI: PCI Interrupt Link [I033] (IRQs *31)
[    4.019076] ACPI: PCI Interrupt Link [I040] (IRQs *44)
[    4.020713] ACPI: PCI Interrupt Link [I041] (IRQs *45)
[    4.023045] ACPI: PCI Interrupt Link [I042] (IRQs *46)
[    4.024734] ACPI: PCI Interrupt Link [I043] (IRQs *47)
[    4.028356] ACPI: PCI Interrupt Link [I050] (IRQs *48)
[    4.030661] ACPI: PCI Interrupt Link [I051] (IRQs *49)
[    4.032743] ACPI: PCI Interrupt Link [I052] (IRQs *50)
[    4.035035] ACPI: PCI Interrupt Link [I053] (IRQs *51)
[    4.036755] ACPI: PCI Interrupt Link [I060] (IRQs *47)
[    4.039027] ACPI: PCI Interrupt Link [I061] (IRQs *44)
[    4.040731] ACPI: PCI Interrupt Link [I062] (IRQs *45)
[    4.044522] ACPI: PCI Interrupt Link [I063] (IRQs *46)
[    4.046816] ACPI: PCI Interrupt Link [I070] (IRQs *24)
[    4.048748] ACPI: PCI Interrupt Link [I071] (IRQs *25)
[    4.051073] ACPI: PCI Interrupt Link [I072] (IRQs *26)
[    4.052764] ACPI: PCI Interrupt Link [I073] (IRQs *27)
[    4.054901] ACPI: PCI Interrupt Link [I090] (IRQs *24)
[    4.056367] ACPI: PCI Interrupt Link [I091] (IRQs *24)
[    4.058264] ACPI: PCI Interrupt Link [I092] (IRQs *24)
[    4.060362] ACPI: PCI Interrupt Link [I093] (IRQs *24)
[    4.062666] ACPI: PCI Interrupt Link [I0A0] (IRQs *24)
[    4.064765] ACPI: PCI Interrupt Link [I0A1] (IRQs *25)
[    4.068786] ACPI: PCI Interrupt Link [I0A2] (IRQs *26)
[    4.071118] ACPI: PCI Interrupt Link [I0A3] (IRQs *27)
[    4.072762] ACPI: PCI Interrupt Link [I0B0] (IRQs *32)
[    4.075094] ACPI: PCI Interrupt Link [I0B1] (IRQs *33)
[    4.076785] ACPI: PCI Interrupt Link [I0B2] (IRQs *34)
[    4.080508] ACPI: PCI Interrupt Link [I0B3] (IRQs *35)
[    4.082887] ACPI: PCI Interrupt Link [I0C0] (IRQs *36)
[    4.084790] ACPI: PCI Interrupt Link [I0C1] (IRQs *37)
[    4.087152] ACPI: PCI Interrupt Link [I0C2] (IRQs *38)
[    4.088812] ACPI: PCI Interrupt Link [I0C3] (IRQs *39)
[    4.092561] ACPI: PCI Interrupt Link [I0D0] (IRQs *40)
[    4.095219] ACPI: PCI Interrupt Link [I0D1] (IRQs *41)
[    4.096807] ACPI: PCI Interrupt Link [I0D2] (IRQs *42)
[    4.099222] ACPI: PCI Interrupt Link [I0D3] (IRQs *43)
[    4.100278] ACPI: PCI Interrupt Link [BI02] (IRQs *52)
[    4.102085] ACPI: PCI Interrupt Link [BI03] (IRQs *52)
[    4.104297] ACPI: PCI Interrupt Link [BI04] (IRQs *52)
[    4.106165] ACPI: PCI Interrupt Link [BI05] (IRQs *52)
[    4.108317] ACPI: PCI Interrupt Link [BI06] (IRQs *54)
[    4.110192] ACPI: PCI Interrupt Link [BI07] (IRQs *24)
[    4.112337] ACPI: PCI Interrupt Link [BI08] (IRQs *24)
[    4.114229] ACPI: PCI Interrupt Link [BI09] (IRQs *24)
[    4.116357] ACPI: PCI Interrupt Link [BI0A] (IRQs *24)
[    4.118338] ACPI: PCI Interrupt Link [BI0B] (IRQs *54)
[    4.120377] ACPI: PCI Interrupt Link [BI0C] (IRQs *54)
[    4.122321] ACPI: PCI Interrupt Link [BI0D] (IRQs *54)
[    4.124318] ACPI: PCI Interrupt Link [PI20] (IRQs 10 11) *0, disabled.
[    4.126649] ACPI: PCI Interrupt Link [PI21] (IRQs 10 11) *0, disabled.
[    4.128342] ACPI: PCI Interrupt Link [PI22] (IRQs 10 11) *0, disabled.
[    4.130619] ACPI: PCI Interrupt Link [PI23] (IRQs 10 11) *0, disabled.
[    4.132341] ACPI: PCI Interrupt Link [PI30] (IRQs 10 11) *0, disabled.
[    4.136340] ACPI: PCI Interrupt Link [PI31] (IRQs 10 11) *0, disabled.
[    4.138791] ACPI: PCI Interrupt Link [PI32] (IRQs 10 11) *0, disabled.
[    4.140339] ACPI: PCI Interrupt Link [PI33] (IRQs 10 11) *0, disabled.
[    4.142697] ACPI: PCI Interrupt Link [PI40] (IRQs 10 11) *0, disabled.
[    4.144340] ACPI: PCI Interrupt Link [PI41] (IRQs 10 11) *0, disabled.
[    4.148340] ACPI: PCI Interrupt Link [PI42] (IRQs 10 11) *0, disabled.
[    4.150736] ACPI: PCI Interrupt Link [PI43] (IRQs 10 11) *0, disabled.
[    4.152342] ACPI: PCI Interrupt Link [PI50] (IRQs 10 11) *0, disabled.
[    4.154701] ACPI: PCI Interrupt Link [PI51] (IRQs 10 11) *0, disabled.
[    4.156342] ACPI: PCI Interrupt Link [PI52] (IRQs 10 11) *0, disabled.
[    4.160340] ACPI: PCI Interrupt Link [PI53] (IRQs 10 11) *0, disabled.
[    4.162718] ACPI: PCI Interrupt Link [PI60] (IRQs 10 11) *0, disabled.
[    4.164366] ACPI: PCI Interrupt Link [PI61] (IRQs 10 11) *0, disabled.
[    4.166715] ACPI: PCI Interrupt Link [PI62] (IRQs 10 11) *0, disabled.
[    4.168342] ACPI: PCI Interrupt Link [PI63] (IRQs 10 11) *0, disabled.
[    4.172304] ACPI: PCI Interrupt Link [PI70] (IRQs 10 11) *0, disabled.
[    4.174653] ACPI: PCI Interrupt Link [PI71] (IRQs 10 11) *0, disabled.
[    4.176341] ACPI: PCI Interrupt Link [PI72] (IRQs 10 11) *0, disabled.
[    4.178902] ACPI: PCI Interrupt Link [PI73] (IRQs 10 11) *0, disabled.
[    4.180339] ACPI: PCI Interrupt Link [PI90] (IRQs 10 11) *0, disabled.
[    4.184355] ACPI: PCI Interrupt Link [PI91] (IRQs 10 11) *0, disabled.
[    4.186764] ACPI: PCI Interrupt Link [PI92] (IRQs 10 11), disabled.
[    4.188340] ACPI: PCI Interrupt Link [PI93] (IRQs 10 11) *0, disabled.
[    4.190709] ACPI: PCI Interrupt Link [PIA0] (IRQs 10 11) *0, disabled.
[    4.192339] ACPI: PCI Interrupt Link [PIA1] (IRQs 10 11) *0, disabled.
[    4.196338] ACPI: PCI Interrupt Link [PIA2] (IRQs 10 11) *0, disabled.
[    4.198829] ACPI: PCI Interrupt Link [PIA3] (IRQs 10 11) *0, disabled.
[    4.200338] ACPI: PCI Interrupt Link [PIB0] (IRQs 10 11) *0, disabled.
[    4.202648] ACPI: PCI Interrupt Link [PIB1] (IRQs 10 11) *0, disabled.
[    4.204342] ACPI: PCI Interrupt Link [PIB2] (IRQs 10 11) *0, disabled.
[    4.208358] ACPI: PCI Interrupt Link [PIB3] (IRQs 10 11) *0, disabled.
[    4.210645] ACPI: PCI Interrupt Link [PIC0] (IRQs 10 11) *0, disabled.
[    4.212339] ACPI: PCI Interrupt Link [PIC1] (IRQs 10 11) *0, disabled.
[    4.214678] ACPI: PCI Interrupt Link [PIC2] (IRQs 10 11) *0, disabled.
[    4.216339] ACPI: PCI Interrupt Link [PIC3] (IRQs 10 11) *0, disabled.
[    4.220231] ACPI: PCI Interrupt Link [PID0] (IRQs 10 11) *0, disabled.
[    4.222552] ACPI: PCI Interrupt Link [PID1] (IRQs 10 11) *0, disabled.
[    4.224341] ACPI: PCI Interrupt Link [PID2] (IRQs 10 11) *0, disabled.
[    4.226657] ACPI: PCI Interrupt Link [PID3] (IRQs 10 11) *0, disabled.
[    4.228339] ACPI: PCI Interrupt Link [PIR2] (IRQs 10 11) *0, disabled.
[    4.230650] ACPI: PCI Interrupt Link [PIR3] (IRQs 10 11) *0, disabled.
[    4.232337] ACPI: PCI Interrupt Link [PIR4] (IRQs 10 11)  disabled.
[    4.236340] ACPI: PCI Interrupt Link [PIR5] (IRQs 10 11) *0, disabled.
[    4.238826] ACPI: PCI Interrupt Link [PIR6] (IRQs 10 11) *0, disabled.
[    4.240339] ACPI: PCI Interrupt Link [PIR7] (IRQs 10 11) *0, disabled.
[    4.244338] ACPI: PCI Interrupt Link [PIR8] (IRQs 10 11) *0, disabled.
[    4.246618] ACPI: PCI Interrupt Link [PIR9] (IRQs 10 11) *0, disabled.
[    4.248341] ACPI: PCI Interrupt Link [PIRA] (IRQs 10 11) *0, disabled.
[    4.250810] ACPI: PCI Interrupt Link [PIRB] (IRQs 10 11) *0, disabled.
[    4.252339] ACPI: PCI Interrupt Link [PIRC] (IRQs 10 11) *0, disabled.
[    4.256328] ACPI: PCI Interrupt Link [PIRD] (IRQs 10 11) *0, disabled.
[    4.258750] ACPI: PCI Interrupt Link [USB1] (IRQs *22)
[    4.260295] ACPI: PCI Interrupt Link [USB2] (IRQs *23)
[    4.262168] ACPI: PCI Interrupt Link [USB3] (IRQs *23)
[    4.264315] ACPI: PCI Interrupt Link [USB4] (IRQs *22)
[    4.266338] ACPI: Invalid _PRS IRQ 0
[    4.267762] ACPI: PCI Interrupt Link [U1PI] (IRQs) *0
[    4.268361] ACPI: Invalid _PRS IRQ 0
[    4.269784] ACPI: PCI Interrupt Link [U2PI] (IRQs) *0
[    4.272367] ACPI: Invalid _PRS IRQ 0
[    4.273712] ACPI: PCI Interrupt Link [U3PI] (IRQs) *0
[    4.276342] ACPI: Invalid _PRS IRQ 0
[    4.277780] ACPI: PCI Interrupt Link [U4PI] (IRQs) *0
[    4.279562] ACPI: PCI Interrupt Link [SATA] (IRQs *16)
[    4.280280] ACPI: Invalid _PRS IRQ 0
[    4.281805] ACPI: PCI Interrupt Link [SATP] (IRQs) *0
[    4.284723] initcall acpi_init+0x0/0x34f returned 0 after 812500 usecs
[    4.286949] calling  pnp_init+0x0/0x11 @ 1
[    4.288204] initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
[    4.290145] calling  balloon_init+0x0/0x1b7 @ 1
[    4.292197] initcall balloon_init+0x0/0x1b7 returned -19 after 0 usecs
[    4.294339] calling  xen_setup_shutdown_event+0x0/0x30 @ 1
[    4.296197] initcall xen_setup_shutdown_event+0x0/0x30 returned -19 after 0 usecs
[    4.298747] calling  xenbus_probe_backend_init+0x0/0x52 @ 1
[    4.300205] initcall xenbus_probe_backend_init+0x0/0x52 returned 0 after 0 usecs
[    4.302631] calling  xenbus_probe_frontend_init+0x0/0x52 @ 1
[    4.304204] initcall xenbus_probe_frontend_init+0x0/0x52 returned 0 after 0 usecs
[    4.306748] calling  xen_acpi_pad_init+0x0/0x3c @ 1
[    4.308197] initcall xen_acpi_pad_init+0x0/0x3c returned -19 after 0 usecs
[    4.310476] calling  misc_init+0x0/0xc1 @ 1
[    4.312203] inill misc_init+0x0/0xc1 returned 0 after 0 usecs
[    4.316198] calling  tpm_init+0x0/0xd3 @ 1
[    4.320204] initcall tpm_init+0x0/0xd3 returned 0 after 0 usecs
[    4.322301] calling  vga_arb_device_init+0x0/0x23b @ 1
[    4.324219] pci 0000:02:00.1: vgaarb: setting as boot VGA device
[    4.326267] pci 0000:02:00.1: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.328199] pci 0000:02:00.1: vgaarb: bridge control possible
[    4.330131] vgaarb: loaded
[    4.331101] initcall vga_arb_device_init+0x0/0x23b returned 0 after 3906 usecs
[    4.332199] calling  cn_init+0x0/0xc0 @ 1
[    4.333594] initcall cn_init+0x0/0xc0 returned 0 after 0 usecs
[    4.336198] calling  dax_fs_init+0x0/0xc9 @ 1
[    4.337688] initcall dax_fs_init+0x0/0xc9 returned 0 after 0 usecs
[    4.340198] calling  dma_buf_init+0x0/0xaf @ 1
[    4.341690] initcall dma_buf_init+0x0/0xaf returned 0 after 0 usecs
[    4.344198] calling  init_scsi+0x0/0x90 @ 1
[    4.345659] SCSI subsystem initialized
[    4.346932] initcall init_scsi+0x0/0x90 returned 0 after 0 usecs
[    4.348197] calling  ata_init+0x0/0x39d @ 1
[    4.349607] libata version 3.00 loaded.
[    4.352198] initcall ata_init+0x0/0x39d returned 0 after 3906 usecs
[    4.354305] calling  xdbc_init+0x0/0x151 @ 1
[    4.355747] initcall xdbc_init+0x0/0x151 returned 0 after 0 usecs
[    4.356197] calling  serio_init+0x0/0x2c @ 1
[    4.357616] initcall serio_init+0x0/0x2c returned 0 after 0 usecs
[    4.360197] calling  input_init+0x0/0x104 @ 1
[    4.361716] initcall input_init+0x0/0x104 returned 0 after 0 usecs
[    4.364197] calling  rtc_init+0x0/0x4e @ 1
[    4.365597] initcall rtc_init+0x0/0x4e returned 0 after 0 usecs
[    4.368197] calling  dw_i2c_init_driver+0x0/0x13 @ 1
[    4.369854] initcall dw_i2c_init_driver+0x0/0x13 returned 0 after 0 usecs
[    4.372197] calling  cec_devnode_init+0x0/0xb9 @ 1
[    4.373869] initcall cec_devnode_init+0x0/0xb9 returned 0 after 0 usecs
[    4.376197] calling  power_supply_class_init+0x0/0x40
[    4.380200] initcall power_supply_class_init+0x0/0x40 returned 0 after 0 usecs
[    4.384197] calling  hwmon_init+0x0/0xd2 @ 1
[    4.385745] initcall hwmon_init+0x0/0xd2 returned 0 after 0 usecs
[    4.388197] calling  edac_init+0x0/0x78 @ 1
[    4.389595] EDAC MC: Ver: 3.0.0
[    4.390777] initcall edac_init+0x0/0x78 returned 0 after 0 usecs
[    4.392198] calling  leds_init+0x0/0x3c @ 1
[    4.393606] initcall leds_init+0x0/0x3c returned 0 after 0 usecs
[    4.396197] calling  dmi_init+0x0/0x11c @ 1
[    4.397602] initcall dmi_init+0x0/0x11c returned 0 after 0 usecs
[    4.399604] calling  efisubsys_init+0x0/0x2dd @ 1
[    4.400198] initcall efisubsys_init+0x0/0x2dd returned 0 after 0 usecs
[    4.402354] calling  devfreq_init+0x0/0xa7 @ 1
[    4.404216] initcall devfreq_init+0x0/0xa7 returned 0 after 0 usecs
[    4.406397] calling  devfreq_event_init+0x0/0x50 @ 1
[    4.408202] initcall devfreq_event_init+0x0/0x50 returned 0 after 0 usecs
[    4.410404] calling  ras_init+0x0/0xf @ 1
[    4.412202] initcall ras_init+0x0/0xf returned 0 after 0 usecs
[    4.414376] calling  nvmem_init+0x0/0x11 @ 1
[    4.416205] initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
[    4.418215] calling  pci_subsys_init+0x0/0x69 @ 1
[    4.419770] PCI: Using ACPI for IRQ routing
[    4.430110] PCI: pci_cache_line_size set to 64 bytes
[    4.431874] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    4.432197] e820: reserve RAM buffer [mem 0xbddde000-0xbfffffff]
[    4.434279] e820: reserve RAM buffer [mem 0x83efff000-0x83fffffff]
[    4.436199] initcall pci_subsys_init+0x0/0x69 returned 0 after 19531 usecs
[    4.440198] calling  proto_init+0x0/0x11 @ 1
[    4.441629] initcall proto_init+0x0/0x11 returned 0 after 0 usecs
[    4.443635] calling  net_dev_init+0x0/0x245 @ 1
[    4.444286] initcall net_dev_init+0x0/0x245 returned 0 after 0 usecs
[    4.446437] calling  neigh_init+0x0/0x80 @ 1
[    4.448199] initcall neigh_init+0x0/0x80 returned 0 after 0 usecs
[    4.450209] calling  fib_notifier_init+0x0/0x11 @ 1
[    4.452198] initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
[    4.454414] calling  fib_rules_init+0x0/0xa8 @ 1
[    4.456198] initcall fib_rules_init+0x0/0xa8 returned 0 after 0 usecs
[    4.458361] calling  init_cgroup_netprio+0x0/0x14 @ 1
[    4.460198] initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
[    4.462433] calling  bpf_lwt_init+0x0/0x16 @ 1
[    4.464001] initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
[    4.464197] calling  pktsched_init+0x0/0x113 @ 1
[    4.465778] initcall pktsched_init+0x0/0x113 returned 0 after 0 usecs
[    4.468197] calling  tc_filter_init+0x0/0xfe @ 1
[    4.469763] initcall tc_filter_init+0x0/0xfe returned 0 after 0 usecs
[    4.472197] calling  tc_action_init+0x0/0x6d @ 1
[    4.473787] initcall tc_action_init+0x0/0x6d returned 0 after 0 usecs
[    4.476197] calling  genl_init+0x0/0x38 @ 1
[    4.477594] initcall genl_init+0x0/0x38 returned 0 after 0 usecs
[    4.480197] calling  cipso_v4_init+0x0/0x71 @ 1
[    4.481709] initcall cipso_v4_init+0x0/0x71 returned 0 after 0 usecs
[    4.484197] calling  wireless_nlevent_init+0x0/0x3c @ 1
[    4.486053] initcall wireless_nlevent_init+0x0/0x3c returned 0 after 0 usecs
[    4.488197] calling  netlbl_init+0x0/0x83 @ 1
[    89717] NetLabel: Initializing
[    4.492196] NetLabel:  domain hash size = 128
[    4.496196] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    4.498103] NetLabel:  unlabeled traffic allowed by default
[    4.500198] initcall netlbl_init+0x0/0x83 returned 0 after 11718 usecs
[    4.502372] calling  xen_mcfg_late+0x0/0xb0 @ 1
[    4.504197] initcall xen_mcfg_late+0x0/0xb0 returned 0 after 0 usecs
[    4.506265] calling  watchdog_init+0x0/0x77 @ 1
[    4.507809] initcall watchdog_init+0x0/0x77 returned 0 after 0 usecs
[    4.507809] calling  xen_p2m_debugfs+0x0/0x4b @ 1
[    4.508208] initcall xen_p2m_debugfs+0x0/0x4b returned 0 after 0 usecs
[    4.510421] calling  nmi_warning_debugfs+0x0/0x27 @ 1
[    4.512200] initcall nmi_warning_debugfs+0x0/0x27 returned 0 after 0 usecs
[    4.514523] calling  save_microcode_in_initrd+0x0/0x7f @ 1
[    4.516209] initcall save_microcode_in_initrd+0x0/0x7f returned 0 after 0 usecs
[    4.518681] calling  hpet_late_init+0x0/0x106 @ 1
[    4.520202] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    4.521921] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    4.527213] initcall hpet_late_init+0x0/0x106 returned 0 after 7812 usecs
[    4.532198] calling  init_amd_nbs+0x0/0xf7 @ 1
[    4.533748] initcall init_amd_nbs+0x0/0xf7 returned 0 after 0 usecs
[    4.536198] calling  uv_ptc_init+0x0/0xc2 @ 1
[    4.537670] initcall uv_ptc_init+0x0/0xc2 returned 0 after 0 usecs
[    4.537670] calling  sugov_register+0x0/0x11 @ 1
[    4.537690] initcall sugov_register+0x0/0x11 returned 0 after 0 usecs
[    4.540197] calling  clocksource_done_booting+0x0/0x42 @ 1
[    4.544197] clocksource: Switched to clocksource tsc-early
[    4.546041] initcall clocksource_done_booting+0x0/0x42 returned 0 after 1800 usecs
[    4.548633] calling  tracer_init_tracefs+0x0/0x1b8 @ 1
[    4.567904] initcall tracer_init_tracefs+0x0/0x1b8 returned 0 after 17124 usecs
[    4.570475] calling  init_trace_printk_function_export+0x0/0x2d @ 1
[    4.572607] initcall init_trace_printk_function_export+0x0/0x2d returned 0 after 1 usecs
[    4.575256] calling  init_graph_tracefs+0x0/0x2d @ 1
[    4.576910] initcall init_graph_tracefs+0x0/0x2d returned 0 after 2 usecs
[    4.579237] calling  trace_events_hist_init+0x0/0x4d @ 1
[    4.581054] initcall trace_events_hist_init+0x0/0x4d returned 0 after 1 usecs
[    4.583412] calling  init_kprobe_trace+0x0/0x8c @ 1
[    4.585029] initcall init_kprobe_trace+0x0/0x8c returned 0 after 2 usecs
[    4.587296] calling  init_uprobe_trace+0x0/0x4f @ 1
[    4.589014] initcall init_uprobe_trace+0x0/0x4f returned 0 after 3 usecs
[    4.591246] calling  bpf_init+0x0/0x4a @ 1
[    4.592636] initcall bpf_init+0x0/0x4a returned 0 after 5 usecs
[    4.594609] calling  init_pipe_fs+0x0/0x47 @ 1
[    4.596086] initcall init_pipe_fs+0x0/0x47 returned 0 after 12 usecs
[    4.598223] calling  cgroup_writeback_init+0x0/0x2d @ 1
[    4.600049] initcall cgroup_writeback_init+0x0/0x2d returned 0 after 42 usecs
[    4.602431] calling  inotify_user_setup+0x0/0x4b @ 1
[    4.604054] initcall inotify_user_setup+0x0/0x4b returned 0 after 18 usecs
[    4.606333] calling  eventpoll_init+0x0/0xa1 @ 1
[    4.608003] initcall eventpoll_init+0x0/0xa1 returned 0 after 10 usecs
[    4.610210] calling  anon_inode_init+0x0/0x5f @ 1
[    4.611785] initcall anon_inode_init+0x0/0x5f returned 0 after 7 usecs
[    4.613935] calling  init_dax_wait_table+0x0/0x34 @ 1
[    4.615636] initcall init_dax_wait_table+0x0/0x34 returned 0 after 17 usecs
[    4.617914] calling  proc_locks_init+0x0/0x28 @ 1
[    4.619412] initcall proc_locks_init+0x0/0x28 returned 0 after 2 usecs
[    4.621493] calling  dquot_init+0x0/0x132 @ 1
[    4.622891] VFS: Disk quotas dquot_6.6.0
[    4.624238] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.626499] initcall dquot_init+0x0/32 returned 0 after 3522 usecs
[    4.728710] calling  quota_init+0x0/0x26 @ 1
[    4.730165] initcall quota_init+0x0/0x26 returned 0 after 10 usecs
[    4.732166] calling  proc_cmdline_init+0x0/0x22 @ 1
[    4.733799] initcall proc_cmdline_init+0x0/0x22 returned 0 after 1 usecs
[    4.735981] calling  proc_consoles_init+0x0/0x25 @ 1
[    4.737683] initcall proc_consoles_init+0x0/0x25 returned 0 after 0 usecs
[    4.739988] calling  proc_cpuinfo_init+0x0/0x1f @ 1
[    4.741645] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 0 usecs
[    4.743829] calling  proc_devices_init+0x0/0x25 @ 1
[    4.745501] initcall proc_devices_init+0x0/0x25 returned 0 after 0 usecs
[    4.747739] calling  proc_interrupts_init+0x0/0x25 @ 1
[    4.749529] initcall proc_interrupts_init+0x0/0x25 returned 0 after 0 usecs
[    4.751858] calling  proc_loadavg_init+0x0/0x22 @ 1
[    4.753492] initcall proc_loadavg_init+0x0/0x22 returned 0 after 0 usecs
[    4.755667] calling  proc_meminfo_init+0x0/0x22 @ 1
[    4.757272] initcall proc_meminfo_init+0x0/0x22 returned 0 after 0 usecs
[    4.759551] calling  proc_stat_init+0x0/0x1f @ 1
[    4.761094] initcall proc_stat_init+0x0/0x1f returned 0 after 0 usecs
[    4.763202] calling  proc_uptime_init+0x0/0x22 @ 1
[    4.764843] initcall proc_uptime_init+0x0/0x22 returned 0 after 5 usecs
[    4.767030] calling  proc_version_init+0x0/0x22 @ 1
[    4.768738] initcall proc_version_init+0x0/0x22 returned 0 after 1 usecs
[    4.770972] calling  proc_softirqs_init+0x0/0x22 @ 1
[    4.772631] initcall proc_softirqs_init+0x0/0x22 returned 0 after 0 usecs
[    4.774835] calling  proc_kcore_init+0x0/0xd0 @ 1
[    4.776395] initcall proc_kcore_init+0x0/0xd0 returned 0 after 6 usecs
[    4.778696] calling  vmcore_init+0x0/0x36 @ 1
[    4.780151] initcall vmcore_init+0x0/0x36 returned 0 after 0 usecs
[    4.782237] calling  proc_kmsg_init+0x0/0x22 @ 1
[    4.783792] initcall proc_kmsg_init+0x0/0x22 returned 0 after 1 usecs
[    4.785950] calling  proc_page_init+0x0/0x56 @ 1
  4.787499] initcall proc_page_init+0x0/0x56 returned 0 after 1 usecs
[    4.889788] calling  init_ramfs_fs+0x0/0x20 @ 1
[    4.891300] initcall init_ramfs_fs+0x0/0x20 returned 0 after 0 usecs
[    4.893508] calling  init_hugetlbfs_fs+0x0/0x182 @ 1
[    4.895165] initcall init_hugetlbfs_fs+0x0/0x182 returned 0 after 28 usecs
[    4.897503] calling  tomoyo_initerface_init+0x0/0x17b @ 1
[    4.899400] initcall tomoyo_initerface_init+0x0/0x17b returned 0 after 0 usecs
[    4.901807] calling  aa_create_aafs+0x0/0x387 @ 1
[    4.903492] AppArmor: AppArmor Filesystem Enabled
[    4.905067] initcall aa_create_aafs+0x0/0x387 returned 0 after 1639 usecs
[    4.907318] calling  blk_scsi_ioctl_init+0x0/0x2ee @ 1
[    4.909152] initcall blk_scsi_ioctl_init+0x0/0x2ee returned 0 after 0 usecs
[    4.911420] calling  dynamic_debug_init_debugfs+0x0/0x64 @ 1
[    4.913290] initcall dynamic_debug_init_debugfs+0x0/0x64 returned 0 after 5 usecs
[    4.915805] calling  acpi_event_init+0x0/0x2f @ 1
[    4.917356] initcall acpi_event_init+0x0/0x2f returned 0 after 4 usecs
[    4.919639] calling  pnp_system_init+0x0/0x11 @ 1
[    4.921209] initcall pnp_system_init+0x0/0x11 returned 0 after 10 usecs
[    4.923352] calling  pnpacpi_init+0x0/0x74 @ 1
[    4.924851] pnp: PnP ACPI init
[    4.929863] system 00:00: [io  0x0379-0x037a] has been reserved
[    4.931895] system 00:00: [io  0x0400-0x043f] has been reserved
[    4.933862] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    4.935839] system 00:00: [io  0x04d6] has been reserved
[    4.937666] system 00:00: [io  0x0520] has been reserved
[    4.939506] system 00:00: [io  0x0580-0x059f] has been reserved
[    4.941432] system 00:00: [io  0x0600-0x067f] has been reserved
[    4.943409] system 00:00: [io  0x0700-0x0703] has been reserved
[    4.945362] system 00:00: [io  0x0820-0x082f] has been reserved
[    4.947345] system 00:00: [io  0x0900-0x09fe] has been reserved
[    4.949361] system 00:00: [io  0x0c06-0x0c07] has been reserved
[    4.951343] system 00:00: [io  0x0c14] has been reserved
[    4.953068] system 00:00: [io  0x0c4a] has been reserved
[    4.954858] system 00:00: [io  0x0c50-0x0c52] has been reserved
[    4.956836] system 00:00: [io  0x0c6c] has been reserved
[   958679] system 00:00: [io  0x0c6f] has been reserved
[    5.060631] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    5.062673] system 00:00: [io  0x0c90-0x0c9f] has been reserved
[    5.064682] system 00:00: [io  0x0ca0-0x0ca5] could not be reserved
[    5.067053] system 00:00: [io  0x0cd0-0x0cdf] has been reserved
[    5.069090] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    5.071268] system 00:00: [io  0x0b00-0x0b3f] has been reserved
[    5.073257] system 00:00: [io  0x03f8-0x03ff] has been reserved
[    5.075211] system 00:00: [mem 0xc0000000-0xcfffffff] has been reserved
[    5.077402] probe of 00:00 returned 1 after 147547 usecs
[    5.079285] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    5.081530] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    5.083889] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    5.086620] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    5.089203] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    5.091509] system 00:05: [mem 0xfaff4000-0xfaff7fff] could not be reserved
[    5.093826] probe of 00:05 returned 1 after 2321 usecs
[    5.095558] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    5.097743] pnp: PnP ACPI: found 6 devices
[    5.099149] initcall pnpacpi_init+0x0/0x74 returned 0 after 170212 usecs
[    5.101391] calling  chr_dev_init+0x0/0xad @ 1
[    5.105013] initcall chr_dev_init+0x0/0xad returned 0 after 2076 usecs
[    5.107274] calling  firmware_class_init+0x0/0xfa @ 1
[    5.109112] initcall firmware_class_init+0x0/0xfa returned 0 after 5 usecs
[    5.111404] calling  thermal_init+0x0/0xdd @ 1
[    5.112913] initcall thermal_init+0x0/0xdd returned 0 after 8 usecs
[    5.114939] calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
[    5.116920] initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
[    5.119562] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[    5.121312] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 0 usecs
[    5.123648] calling  map_properties+0x0/0x5ad @ 1
[    5.125192] initcall map_properties+0x0/0x5ad returned 0 after 0ecs
[    5.227438] calling  init_acpi_pm_clocksource+0x0/0xdf @ 1
[    5.233845] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    5.236863] initcall init_acpi_pm_clocksource+0x0/0xdf returned 0 after 7333 usecs
[    5.239492] calling  pcibios_assign_resources+0x0/0xb2 @ 1
[    5.241304] pci 0000:00:0c.0: BAR 14: assigned [mem 0xfc000000-0xfc0fffff]
[    5.243565] pci 0000:03:00.0: BAR 6: assigned [mem 0xfde00000-0xfde7ffff pref]
[    5.245971] pci 0000:00:02.0: PCI bridge to [bus 03]
[    5.247620] pci 0000:00:02.0:   bridge window [io  0x4000-0x4fff]
[    5.249748] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdffffff]
[    5.252032] pci 0000:02:00.2: BAR 6: assigned [mem 0xfcd00000-0xfcd0ffff pref]
[    5.254423] pci 0000:00:0a.0: PCI bridge to [bus 02]
[    5.256073] pci 0000:00:0a.0:   bridge window [io  0x3000-0x3fff]
[    5.258176] pci 0000:00:0a.0:   bridge window [mem 0xfcd00000-0xfddfffff]
[    5.260442] pci 0000:00:0a.0:   bridge window [mem 0xfb000000-0xfbffffff 64bit pref]
[    5.262937] pci 0000:04:00.0: BAR 6: assigned [mem 0xfc000000-0xfc03ffff pref]
[    5.265326] pci 0000:04:00.1: BAR 6: assigned [mem 0xfc040000-0xfc07ffff pref]
[    5.267981] pci 0000:04:00.2: BAR 6: assigned [mem 0xfc080000-0xfc0bffff pref]
[    5.270446] pci 0000:04:00.3: BAR 6: assigned [mem 0xfc0c0000-0xfc0fffff pref]
[    5.272782] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    5.274413] pci 0000:00:0c.0:   bridge window [mem 0xfc000000-0xfc0fffff]
[    5.276691] pci 0000:00:0c.0:   bridge window [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    5.279329] pci 0000:00:14.4: PCI bridge to [bus 01]
[    5.281008] pci_bus 0000:00: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    5.283607] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
[    5.285647] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[    5.287712] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[    5.289840] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
[    5.291898] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff windo
                                                                           [    5.394171] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff window]
[    5.396523] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb window]
[    5.398675] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df window]
[    5.400807] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
[    5.403137] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    5.404993] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdffffff]
[    5.407039] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    5.409001] pci_bus 0000:02: resource 1 [mem 0xfcd00000-0xfddfffff]
[    5.411062] pci_bus 0000:02: resource 2 [mem 0xfb000000-0xfbffffff 64bit pref]
[    5.413401] pci_bus 0000:04: resource 1 [mem 0xfc000000-0xfc0fffff]
[    5.415541] pci_bus 0000:04: resource 2 [mem 0xfcb00000-0xfcbfffff 64bit pref]
[    5.417981] pci_bus 0000:01: resource 4 [mem 0xfaf00000-0xfdffffff window]
[    5.420286] pci_bus 0000:01: resource 5 [io  0x1000-0xffff window]
[    5.422373] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
[    5.424408] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
[    5.426487] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
[    5.428664] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed03fff window]
[    5.430918] pci_bus 0000:01: resource 10 [mem 0xfed40000-0xfed44fff window]
[    5.433280] pci_bus 0000:01: resource 11 [io  0x03b0-0x03bb window]
[    5.435330] pci_bus 0000:01: resource 12 [io  0x03c0-0x03df window]
[    5.437430] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
[    5.440007] initcall pcibios_assign_resources+0x0/0xb2 returned 0 after 194065 usecs
[    5.442598] calling  sysctl_core_init+0x0/0x2b @ 1
[    5.444106] initcall sysctl_core_init+0x0/0x2b returned 0 after 12 usecs
[    5.446373] calling  eth_offload_init+0x0/0x14 @ 1
[    5.448015] initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
[    5.450241] calling  ipv4_offload_init+0x0/0x7a @ 1
[    5.451881] initcall ipv4_offload_init+0x0/0x7a returned 0 after 0 usecs
[ 5.454142] calling  inet_init+0x0/0x283 @ 1
[    5.555642] NET: Registered protocol family 2
[    5.557319] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
[    5.560504] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    5.563577] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    5.566078] TCP: Hash tables configured (established 262144 bind 65536)
[    5.568783] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    5.571048] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    5.573478] initcall inet_init+0x0/0x283 returned 0 after 17466 usecs
[    5.575665] calling  af_unix_init+0x0/0x50 @ 1
[    5.577142] NET: Registered protocol family 1
[    5.578707] initcall af_unix_init+0x0/0x50 returned 0 after 1537 usecs
[    5.580958] calling  ipv6_offload_init+0x0/0x83 @ 1
[    5.582636] initcall ipv6_offload_init+0x0/0x83 returned 0 after 1 usecs
[    5.584838] calling  xsk_init+0x0/0x40 @ 1
[    5.586195] NET: Registered protocol family 44
[    5.587692] initcall xsk_init+0x0/0x40 returned 0 after 1461 usecs
[    5.589800] calling  pci_apply_final_quirks+0x0/0xfc @ 1
[    5.591637] pci 0000:00:11.0: calling  quirk_msi_intx_disable_ati_bug+0x0/0x40 @ 1
[    5.594125] pci 0000:00:11.0: quirk_msi_intx_disable_ati_bug+0x0/0x40 took 1 usecs
[    5.596586] pci 0000:00:12.0: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    5.599197] PCI Interrupt Link [USB1] enabled at IRQ 22
[    5.680412] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x6b0 took 79547 usecs
[    5.682943] pci 0000:00:12.1: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    5.764384] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x6b0 took 77255 usecs
[    5.766923] pci 0000:00:12.2: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    5.769531] PCI Interrupt Link [USB2] enabled at IRQ 23
[    5.788379] pci 0000:00:12.2: quirk_usb_early_handoff+0x0/0x6b0 took 18606 usecs
[    5.790834] pci 0000:00:13.0: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    5.793404] PCI Interrupt Link [USB3] enabled at IRQ 23
[    5.872381] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x6b0 took 77350 usecs
[    5.874927] pci 0000:00:13.1: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    5.956593] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x6b0 took 77481 usecs
[    5.959196] pci 0000:00:13.2: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    5.961836] PCI Interrupt Link [USB4] enabled at IRQ 22
[    5.980379] pci 0000:00:13.2: quirk_usb_early_handoff+0x0/0x6b0 took 18315 usecs
[    5.982942] pci 0000:00:18.0: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    5.985118] pci 0000:00:18.0: quirk_amd_nb_node+0x0/0x80 took 1 usecs
[    5.987259] pci 0000:00:18.1: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    5.989464] pci 0000:00:18.1: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    5.991553] pci 0000:00:18.1: calling  pci_amd_enable_64bit_bar+0x0/0x1e0 @ 1
[    5.993911] pci 0000:00:18.1: pci_amd_enable_64bit_bar+0x0/0x1e0 took 0 usecs
[    5.996269] pci 0000:00:18.2: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    5.998413] pci 0000:00:18.2: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.000645] pci 0000:00:18.3: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.002796] pci 0000:00:18.3: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.004904] pci 0000:00:18.4: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.007044] pci 0000:00:18.4: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.009213] pci 0000:00:18.5: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.011373] pci 0000:00:18.5: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.013502] pci 0000:00:19.0: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.015658] pci 0000:00:19.0: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.017807] pci 0000:00:19.1: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.020029] pci 0000:00:19.1: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.022136] pci 0000:00:19.1: calling  pci_amd_enable_64bit_bar+0x0/0x1e0 @ 1
[    6.024508] pci 0000:00:19.1: pci_amd_enable_64bit_bar+0x0/0x1e0 took 0 usecs
[    6.026918] pci 0000:00:19.2: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.029183] pci 0000:00:19.2: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.031388] pci 0000:00:19.3: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.033559] pci 0000:00:19.3: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.035676] pci 0000:00:19.4: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.037721] pci 0000:00:19.4: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    69965] pci 0000:00:19.5: calling  quirk_amd_nb_node+0x0/0x80 @ 1
[    6.142135] pci 0000:00:19.5: quirk_amd_nb_node+0x0/0x80 took 0 usecs
[    6.144311] pci 0000:02:00.1: calling  pci_fixup_video+0x0/0xf0 @ 1
[    6.146433] pci 0000:02:00.1: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.149285] pci 0000:02:00.1: pci_fixup_video+0x0/0xf0 took 2790 usecs
[    6.151516] pci 0000:02:00.4: calling  quirk_usb_early_handoff+0x0/0x6b0 @ 1
[    6.154161] PCI Interrupt Link [BI0A] enabled at IRQ 24
[    6.156372] PCI Interrupt Link [I061] enabled at IRQ 44
[    6.158347] pci 0000:02:00.4: quirk_usb_early_handoff+0x0/0x6b0 took 4319 usecs
[    6.161199] PCI: CLS 64 bytes, default 64
[    6.162577] initcall pci_apply_final_quirks+0x0/0xfc returned 0 after 557572 usecs
[    6.165132] calling  acpi_reserve_resources+0x0/0xeb @ 1
[    6.166907] initcall acpi_reserve_resources+0x0/0xeb returned 0 after 3 usecs
[    6.169369] calling  populate_rootfs+0x0/0x116 @ 1
[    6.171014] Unpacking initramfs...
[    7.360940] Freeing initrd memory: 14648K
[    7.362350] initcall populate_rootfs+0x0/0x116 returned 0 after 1163455 usecs
[    7.364792] calling  pci_iommu_init+0x0/0x3f @ 1
[    7.366720] pci 0000:00:00.2: can't derive routing for PCI INT A
[    7.368947] pci 0000:00:00.2: PCI INT A: no GSI
[    7.370767] iommu: Adding device 0000:00:00.0 to group 0
[    7.372720] iommu: Adding device 0000:00:02.0 to group 1
[    7.374738] iommu: Adding device 0000:00:0a.0 to group 2
[    7.376674] iommu: Adding device 0000:00:0c.0 to group 3
[    7.378577] iommu: Adding device 0000:00:11.0 to group 4
[    7.380525] iommu: Adding device 0000:00:12.0 to group 5
[    7.382332] iommu: Adding device 0000:00:12.1 to group 5
[    7.384171] iommu: Adding device 0000:00:12.2 to group 5
[    7.386097] iommu: Adding device 0000:00:13.0 to group 6
[    7.387955] iommu: Adding device 0000:00:13.1 to group 6
[    7.389770] iommu: Adding device 0000:00:13.2 to group 6
[    7.391714] iommu: Adding device 0000:00:14.0 to group 7
[    7.393629] iommu: Adding device 0000:00:14.1 to group 8
[    7.395586] iommu: Adding device 0000:00:14.3 to group 9
[    7.397559] iommu: Adding device 0000:00:14.4 to group 10
[    7.399597] iommu: Adding device 0000:03:00.0 to group 11
[    7.401632] iommu: Adding device 0000:02:00.0 to group 12
[    7.403494] iommu: Adding device 0000:02:00.1 to group 12
[    7.405292] iommu: Adding device 0000:02:00.2 to group 12
[    7.407142] iommu: Adding device 0000:02:00.4 to group 12
[    7.409191] iommu: Adding device 0000:04:00.0 to group 13
[    7.411120] iommu: Adding device 0000:04:00.1 to group 13
[    7.412954] iommu: Adding device 0000:04:00.2 to group 13
[    7.414833] iommu: Adding device 0000:04:00.3 to group 13
[    7.454060] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    7.455872] AMD-Vi: Interrupt remapping enabled
[    7.457564] AMD-Vi: Lazy IO/TLB flushing enabled
[    7.461665] initcall pci_iommu_init+0x0/0x3f returned 0 after 93100 usecs
[    7.464004] calling  calgary_fixup_tce_spaces+0x0/0xee @ 1
[    7.465833] initcall calgary_fixup_tce_spaces+0x0/0xee returned -19 after 0 usecs
[    7.468373] calling  ir_dev_scope_init+0x0/0x34 @ 1
[    7.470088] initcall ir_dev_scope_init+0x0/0x34 returned -19 after 0 usecs
[    7.472454] calling  ia32_binfmt_init+0x0/0x14 @ 1
[    7.474070] initcall ia32_binfmt_init+0x0/0x14 returned 0 after 3 usecs
[    7.476267] calling  amd_uncore_init+0x0/0x27b @ 1
[    7.477918] amd_uncore: AMD NB counters detected
[    7.479648] initcall amd_uncore_init+0x0/0x27b returned 0 after 1694 usecs
[    7.481963] calling  amd_ibs_init+0x0/0x1c3 @ 1
[    7.483547] LVT offset 0 assigned for vector 0x400
[    7.485241] perf: AMD IBS detected (0x000000ff)
[    7.486780] initcall amd_ibs_init+0x0/0x1c3 returned 0 after 3157 usecs
[    7.489068] calling  amd_iommu_pc_init+0x0/0x229 @ 1
[    7.490723] initcall amd_iommu_pc_init+0x0/0x229 returned -19 after 0 usecs
[    7.493028] calling  msr_init+0x0/0xc3 @ 1
[    7.494388] initcall msr_init+0x0/0xc3 returned 0 after 2 usecs
[    7.496321] calling  rapl_pmu_init+0x0/0x234 @ 1
[    7.497893] initcall rapl_pmu_init+0x0/0x234 returned -19 after 1 usecs
[    7.500100] calling  intel_uncore_init+0x0/0x247 @ 1
[    7.501809] initcall intel_uncore_init+0x0/0x247 returned -19 after 0 usecs
[    7.504112] calling  cstate_pmu_init+0x0/0x177 @ 1
[    7.505718] initcall cstate_pmu_init+0x0/0x177 returned -19 after 0 usecs
[    7.507994] calling  register_kernel_offset_dumper+0x0/0x1b @ 1
[    7.509990] initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
[    7.512576] calling  i8259A_init_ops+0x0/0x21 @ 1
[    7.514123] initcall i8259A_init_ops+0x0/0x21 returned 0 after 0 usecs
[    7.516216] calling  init_tsc_clocksource+0x0/0xb3 @ 1
[    7.517981] initcall init_tsc_clocksource+0x0/0xb3 returned 0 after 1 usecs
[    7.520358] calling  add_rtc_cmos+0x0/0xa9 @ 1
[    21857] initcall add_rtc_cmos+0x0/0xa9 returned 0 after 2 usecs
[    7.623970] calling  i8237A_init_ops+0x0/0x37 @ 1
[    7.625560] initcall i8237A_init_ops+0x0/0x37 returned 0 after 1 usecs
[    7.627762] calling  thermal_throttle_init_device+0x0/0x42 @ 1
[    7.629779] initcall thermal_throttle_init_device+0x0/0x42 returned 0 after 0 usecs
[    7.632313] calling  ioapic_init_ops+0x0/0x14 @ 1
[    7.633858] initcall ioapic_init_ops+0x0/0x14 returned 0 after 0 usecs
[    7.635991] calling  register_e820_pmem+0x0/0x42 @ 1
[    7.637705] initcall register_e820_pmem+0x0/0x42 returned 0 after 4 usecs
[    7.640044] calling  add_pcspkr+0x0/0x40 @ 1
[    7.641487] initcall add_pcspkr+0x0/0x40 returned 0 after 23 usecs
[    7.643534] calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
[    7.645676] Scanning for low memory corruption every 60 seconds
[    7.647670] initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 1946 usecs
[    7.650616] calling  sysfb_init+0x0/0x70 @ 1
[    7.652054] initcall sysfb_init+0x0/0x70 returned 0 after 18 usecs
[    7.654106] calling  audit_classes_init+0x0/0xaf @ 1
[    7.655751] initcall audit_classes_init+0x0/0xaf returned 0 after 3 usecs
[    7.658055] calling  iosf_mbi_init+0x0/0x1a @ 1
[    7.659636] initcall iosf_mbi_init+0x0/0x1a returned 0 after 22 usecs
[    7.661773] calling  sgi_uv_sysfs_init+0x0/0xb0 @ 1
[    7.663371] initcall sgi_uv_sysfs_init+0x0/0xb0 returned -19 after 0 usecs
[    7.665622] calling  proc_execdomains_init+0x0/0x22 @ 1
[    7.667350] initcall proc_execdomains_init+0x0/0x22 returned 0 after 1 usecs
[    7.669790] calling  register_warn_debugfs+0x0/0x24 @ 1
[    7.671526] initcall register_warn_debugfs+0x0/0x24 returned 0 after 7 usecs
[    7.673856] calling  cpuhp_sysfs_init+0x0/0x81 @ 1
[    7.675475] initcall cpuhp_sysfs_init+0x0/0x81 returned 0 after 24 usecs
[    7.677692] calling  ioresources_init+0x0/0x4a @ 1
[    7.679401] initcall ioresources_init+0x0/0x4a returned 0 after 2 usecs
[    7.681542]lling  init_sched_debug_procfs+0x0/0x2f @ 1
[    7.783481] initcall init_sched_debug_procfs+0x0/0x2f returned 0 after 0 usecs
[    7.785917] calling  snapshot_device_init+0x0/0x11 @ 1
[    7.787705] initcall snapshot_device_init+0x0/0x11 returned 0 after 54 usecs
[    7.790166] calling  irq_gc_init_ops+0x0/0x14 @ 1
[    7.791745] initcall irq_gc_init_ops+0x0/0x14 returned 0 after 0 usecs
[    7.793829] calling  irq_pm_init_ops+0x0/0x14 @ 1
[    7.795373] initcall irq_pm_init_ops+0x0/0x14 returned 0 after 0 usecs
[    7.797573] calling  klp_init+0x0/0x29 @ 1
[    7.799024] initcall klp_init+0x0/0x29 returned 0 after 2 usecs
[    7.801030] calling  timekeeping_init_ops+0x0/0x14 @ 1
[    7.802740] initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
[    7.805040] calling  init_clocksource_sysfs+0x0/0x24 @ 1
[    7.806858] initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 27 usecs
[    7.809360] calling  init_timer_list_procfs+0x0/0x32 @ 1
[    7.811126] initcall init_timer_list_procfs+0x0/0x32 returned 0 after 0 usecs
[    7.813413] calling  alarmtimer_init+0x0/0x109 @ 1
[    7.815041] probe of alarmtimer returned 1 after 8 usecs
[    7.817039] initcall alarmtimer_init+0x0/0x109 returned 0 after 1981 usecs
[    7.819406] calling  init_posix_timers+0x0/0x2a @ 1
[    7.821065] initcall init_posix_timers+0x0/0x2a returned 0 after 18 usecs
[    7.823337] calling  clockevents_init_sysfs+0x0/0xc0 @ 1
[    7.825256] initcall clockevents_init_sysfs+0x0/0xc0 returned 0 after 116 usecs
[    7.827727] calling  proc_dma_init+0x0/0x22 @ 1
[    7.829269] initcall proc_dma_init+0x0/0x22 returned 0 after 1 usecs
[    7.831409] calling  proc_modules_init+0x0/0x1f @ 1
[    7.833034] initcall proc_modules_init+0x0/0x1f returned 0 after 1 usecs
[    7.835259] calling  kallsyms_init+0x0/0x22 @ 1
[    7.836787] initcall kallsyms_init+0x0/0x22 returned 0 after 1 usecs
[    7.838949] calling  pid_namespaces_init+0x0/0x40 @ 1
[    7.840590] initcall pid_namespaces_init+0x0/0x40 returned 0 ar 5 usecs
[    7.942916] calling  ikconfig_init+0x0/0x3a @ 1
[    7.944441] initcall ikconfig_init+0x0/0x3a returned 0 after 0 usecs
[    7.946613] calling  audit_watch_init+0x0/0x3a @ 1
[    7.948232] initcall audit_watch_init+0x0/0x3a returned 0 after 0 usecs
[    7.950455] calling  audit_fsnotify_init+0x0/0x3a @ 1
[    7.952160] initcall audit_fsnotify_init+0x0/0x3a returned 0 after 0 usecs
[    7.954393] calling  audit_tree_init+0x0/0x49 @ 1
[    7.956022] initcall audit_tree_init+0x0/0x49 returned 0 after 0 usecs
[    7.958185] calling  init_kprobes+0x0/0x1a0 @ 1
[    7.960026] initcall init_kprobes+0x0/0x1a0 returned 0 after 216 usecs
[    7.962309] calling  seccomp_sysctl_init+0x0/0x2c @ 1
[    7.964021] initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 3 usecs
[    7.966307] calling  utsname_sysctl_init+0x0/0x14 @ 1
[    7.968053] initcall utsname_sysctl_init+0x0/0x14 returned 0 after 5 usecs
[    7.970426] calling  init_tracepoints+0x0/0x2a @ 1
[    7.972021] initcall init_tracepoints+0x0/0x2a returned 0 after 0 usecs
[    7.974185] calling  init_lstats_procfs+0x0/0x22 @ 1
[    7.975878] initcall init_lstats_procfs+0x0/0x22 returned 0 after 0 usecs
[    7.978202] calling  stack_trace_init+0x0/0xb0 @ 1
[    7.979872] initcall stack_trace_init+0x0/0xb0 returned 0 after 6 usecs
[    7.982065] calling  init_blk_tracer+0x0/0x52 @ 1
[    7.983651] initcall init_blk_tracer+0x0/0x52 returned 0 after 9 usecs
[    7.985815] calling  perf_event_sysfs_init+0x0/0x7f @ 1
[    7.987668] initcall perf_event_sysfs_init+0x0/0x7f returned 0 after 134 usecs
[    7.990129] calling  init_uprobes+0x0/0x62 @ 1
[    7.991643] initcall init_uprobes+0x0/0x62 returned 0 after 2 usecs
[    7.993700] calling  padata_driver_init+0x0/0x39 @ 1
[    7.995329] initcall padata_driver_init+0x0/0x39 returned 0 after 0 usecs
[    7.997558] calling  system_trusted_keyring_init+0x0/0x116 @ 1
[    7.999489] Initialise system trusted keyrings
[    8.001003] initcall system_trusted_keyring_init+0x0/0x116 return0 after 1478 usecs
[    8.103733] calling  blacklist_init+0x0/0xb6 @ 1
[    8.105414] Key type blacklist registered
[    8.106745] initcall blacklist_init+0x0/0xb6 returned 0 after 1300 usecs
[    8.109091] calling  kswapd_init+0x0/0x8b @ 1
[    8.110596] initcall kswapd_init+0x0/0x8b returned 0 after 49 usecs
[    8.112700] calling  extfrag_debug_init+0x0/0x7a @ 1
[    8.114335] initcall extfrag_debug_init+0x0/0x7a returned 0 after 5 usecs
[    8.116609] calling  mm_compute_batch_init+0x0/0x19 @ 1
[    8.118305] initcall mm_compute_batch_init+0x0/0x19 returned 0 after 0 usecs
[    8.120679] calling  slab_proc_init+0x0/0x22 @ 1
[    8.122204] initcall slab_proc_init+0x0/0x22 returned 0 after 1 usecs
[    8.124333] calling  workingset_init+0x0/0x94 @ 1
[    8.125903] workingset: timestamp_bits=37 max_order=23 bucket_order=0
[    8.128073] initcall workingset_init+0x0/0x94 returned 0 after 2118 usecs
[    8.130395] calling  proc_vmalloc_init+0x0/0x30 @ 1
[    8.132025] initcall proc_vmalloc_init+0x0/0x30 returned 0 after 1 usecs
[    8.134249] calling  procswaps_init+0x0/0x1f @ 1
[    8.135788] initcall procswaps_init+0x0/0x1f returned 0 after 0 usecs
[    8.137906] calling  init_frontswap+0x0/0x93 @ 1
[    8.139500] initcall init_frontswap+0x0/0x93 returned 0 after 8 usecs
[    8.141665] calling  cpucache_init+0x0/0x35 @ 1
[    8.143269] initcall cpucache_init+0x0/0x35 returned 0 after 109 usecs
[    8.145401] calling  slab_proc_init+0x0/0x8 @ 1
[    8.146864] initcall slab_proc_init+0x0/0x8 returned 0 after 0 usecs
[    8.149019] calling  init_cleancache+0x0/0x93 @ 1
[    8.150615] initcall init_cleancache+0x0/0x93 returned 0 after 9 usecs
[    8.152764] calling  init_zbud+0x0/0x22 @ 1
[    8.154158] zbud: loaded
[    8.155044] initcall init_zbud+0x0/0x22 returned 0 after 863 usecs
[    8.157103] calling  zs_init+0x0/0x77 @ 1
[    8.158472] initcall zs_init+0x0/0x77 returned 0 after 10 usecs
[    8.160454] calling  fcntl_init+0x0/0x2a @ 1
[    8.161903] initcall fcntl_init+0x0/0xreturned 0 after 1 usecs
[    8.263981] calling  proc_filesystems_init+0x0/0x22 @ 1
[    8.265959] initcall proc_filesystems_init+0x0/0x22 returned 0 after 1 usecs
[    8.268384] calling  start_dirtytime_writeback+0x0/0x2a @ 1
[    8.270277] initcall start_dirtytime_writeback+0x0/0x2a returned 0 after 0 usecs
[    8.272758] calling  blkdev_init+0x0/0x20 @ 1
[    8.274160] initcall blkdev_init+0x0/0x20 returned 0 after 5 usecs
[    8.276219] calling  dio_init+0x0/0x2d @ 1
[    8.277558] initcall dio_init+0x0/0x2d returned 0 after 0 usecs
[    8.279627] calling  dnotify_init+0x0/0x7b @ 1
[    8.281118] initcall dnotify_init+0x0/0x7b returned 0 after 13 usecs
[    8.283483] calling  fanotify_user_setup+0x0/0x77 @ 1
[    8.285194] initcall fanotify_user_setup+0x0/0x77 returned 0 after 3 usecs
[    8.287487] calling  userfaultfd_init+0x0/0x2e @ 1
[    8.289221] initcall userfaultfd_init+0x0/0x2e returned 0 after 7 usecs
[    8.291437] calling  aio_setup+0x0/0x7d @ 1
[    8.292857] initcall aio_setup+0x0/0x7d returned 0 after 9 usecs
[    8.294812] calling  fscrypt_init+0x0/0xb9 @ 1
[    8.296470] initcall fscrypt_init+0x0/0xb9 returned 0 after 172 usecs
[    8.298865] calling  init_sys32_ioctl+0x0/0x28 @ 1
[    8.300541] initcall init_sys32_ioctl+0x0/0x28 returned 0 after 65 usecs
[    8.302909] calling  mbcache_init+0x0/0x31 @ 1
[    8.304403] initcall mbcache_init+0x0/0x31 returned 0 after 9 usecs
[    8.306533] calling  init_devpts_fs+0x0/0x28 @ 1
[    8.308101] initcall init_devpts_fs+0x0/0x28 returned 0 after 7 usecs
[    8.310271] calling  ext4_init_fs+0x0/0x195 @ 1
[    8.311797] initcall ext4_init_fs+0x0/0x195 returned 0 after 58 usecs
[    8.313934] calling  journal_init+0x0/0x104 @ 1
[    8.315424] initcall journal_init+0x0/0x104 returned 0 after 33 usecs
[    8.317937] calling  init_autofs_fs+0x0/0x2a @ 1
[    8.319600] initcall init_autofs_fs+0x0/0x2a returned 0 after 42 usecs
[    8.321769] calling  init_pstore_fs+0x0/0x4f @ 1
[    8.323357] pstore: using deflate compressi
                                              [    8.424974] initcall init_pstore_fs+0x0/0x4f returned 0 after 99233 usecs
[    8.427255] calling  ipc_init+0x0/0x25 @ 1
[    8.428813] initcall ipc_init+0x0/0x25 returned 0 after 6 usecs
[    8.430763] calling  ipc_sysctl_init+0x0/0x14 @ 1
[    8.432362] initcall ipc_sysctl_init+0x0/0x14 returned 0 after 6 usecs
[    8.434477] calling  init_mqueue_fs+0x0/0xa1 @ 1
[    8.436103] initcall init_mqueue_fs+0x0/0xa1 returned 0 after 25 usecs
[    8.438272] calling  key_proc_init+0x0/0x64 @ 1
[    8.440060] initcall key_proc_init+0x0/0x64 returned 0 after 2 usecs
[    8.442233] calling  selinux_nf_ip_init+0x0/0x4d @ 1
[    8.443845] initcall selinux_nf_ip_init+0x0/0x4d returned 0 after 0 usecs
[    8.446099] calling  init_sel_fs+0x0/0x109 @ 1
[    8.447586] initcall init_sel_fs+0x0/0x109 returned 0 after 0 usecs
[    8.449764] calling  selnl_init+0x0/0x59 @ 1
[    8.451192] initcall selnl_init+0x0/0x59 returned 0 after 9 usecs
[    8.453241] calling  sel_netif_init+0x0/0x37 @ 1
[    8.454797] initcall sel_netif_init+0x0/0x37 returned 0 after 0 usecs
[    8.456985] calling  sel_netnode_init+0x0/0x32 @ 1
[    8.458669] initcall sel_netnode_init+0x0/0x32 returned 0 after 0 usecs
[    8.460985] calling  sel_netport_init+0x0/0x32 @ 1
[    8.462579] initcall sel_netport_init+0x0/0x32 returned 0 after 0 usecs
[    8.464784] calling  aurule_init+0x0/0x2d @ 1
[    8.466189] initcall aurule_init+0x0/0x2d returned 0 after 0 usecs
[    8.468301] calling  crypto_algapi_init+0x0/0xd @ 1
[    8.469981] initcall crypto_algapi_init+0x0/0xd returned 0 after 1 usecs
[    8.472215] calling  seqiv_module_init+0x0/0x11 @ 1
[    8.473833] initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.476051] calling  dh_init+0x0/0x20 @ 1
[    8.477426] initcall dh_init+0x0/0x20 returned 0 after 42 usecs
[    8.479605] calling  rsa_init+0x0/0x40 @ 1
[    8.481009] initcall rsa_init+0x0/0x40 returned 0 after 33 usecs
[    8.483040] calling  hmac_module_init+0x0/0x11 @ 1
[    8.484643] initcall hmac_moduinit+0x0/0x11 returned 0 after 0 usecs
[    8.532218] tsc: Refined TSC clocksource calibration: 2792.999 MHz
[    8.586930] calling  crypto_null_mod_init+0x0/0x44 @ 1
[    8.589145] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28426b16f90, max_idle_ns: 440795205097 ns
[    8.591113] initcall crypto_null_mod_init+0x0/0x44 returned 0 after 258 usecs
[    8.596456] calling  md5_mod_init+0x0/0x11 @ 1
[    8.596465] clocksource: Switched to clocksource tsc
[    8.598032] initcall md5_mod_init+0x0/0x11 returned 0 after 69 usecs
[    8.601856] calling  sha1_generic_mod_init+0x0/0x11 @ 1
[    8.603623] initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 47 usecs
[    8.605963] calling  sha256_generic_mod_init+0x0/0x16 @ 1
[    8.607933] initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 82 usecs
[    8.610378] calling  crypto_ecb_module_init+0x0/0x11 @ 1
[    8.612145] initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.614497] calling  crypto_cbc_module_init+0x0/0x11 @ 1
[    8.616289] initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.618750] calling  crypto_cts_module_init+0x0/0x11 @ 1
[    8.620487] initcall crypto_cts_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.622875] calling  crypto_module_init+0x0/0x11 @ 1
[    8.624504] initcall crypto_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.626732] calling  crypto_ctr_module_init+0x0/0x3c @ 1
[    8.628613] initcall crypto_ctr_module_init+0x0/0x3c returned 0 after 0 usecs
[    8.630945] calling  crypto_gcm_module_init+0x0/0xb6 @ 1
[    8.632712] initcall crypto_gcm_module_init+0x0/0xb6 returned 0 after 1 usecs
[    8.635055] calling  aes_init+0x0/0x11 @ 1
[    8.636464] initcall aes_init+0x0/0x11 returned 0 after 40 usecs
[    8.638584] calling  crc32c_mod_init+0x0/0x11 @ 1
[    8.640189] initcall crc32c_mod_init+0x0/0x11 returned 0 after 42 usecs
[    8.642419] calling  crct10dif_mod_init+0x0/0x11 @ 1
[    8.644121] initcall crct10dif_mod_init+0x0/0x11 return0 after 45 usecs
[    8.746464] calling  lzo_mod_init+0x0/0x38 @ 1
[    8.748114] initcall lzo_mod_init+0x0/0x38 returned 0 after 90 usecs
[    8.750284] calling  drbg_init+0x0/0x7a @ 1
[    8.752597] initcall drbg_init+0x0/0x7a returned 0 after 845 usecs
[    8.754743] calling  jent_mod_init+0x0/0x30 @ 1
[    8.756440] initcall jent_mod_init+0x0/0x30 returned 0 after 210 usecs
[    8.758777] calling  ghash_mod_init+0x0/0x11 @ 1
[    8.760362] initcall ghash_mod_init+0x0/0x11 returned 0 after 41 usecs
[    8.762595] calling  zstd_mod_init+0x0/0x38 @ 1
[    8.764203] initcall zstd_mod_init+0x0/0x38 returned 0 after 93 usecs
[    8.766337] calling  asymmetric_key_init+0x0/0x11 @ 1
[    8.768105] Key type asymmetric registered
[    8.769550] initcall asymmetric_key_init+0x0/0x11 returned 0 after 1409 usecs
[    8.771911] calling  x509_key_init+0x0/0x11 @ 1
[    8.773401] Asymmetric key parser 'x509' registered
[    8.775031] initcall x509_key_init+0x0/0x11 returned 0 after 1591 usecs
[    8.777252] calling  proc_genhd_init+0x0/0x42 @ 1
[    8.778972] initcall proc_genhd_init+0x0/0x42 returned 0 after 2 usecs
[    8.781104] calling  bsg_init+0x0/0xe4 @ 1
[    8.782466] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    8.784887] initcall bsg_init+0x0/0xe4 returned 0 after 2369 usecs
[    8.786963] calling  throtl_init+0x0/0x43 @ 1
[    8.788460] initcall throtl_init+0x0/0x43 returned 0 after 65 usecs
[    8.790532] calling  iolatency_init+0x0/0x11 @ 1
[    8.792068] initcall iolatency_init+0x0/0x11 returned 0 after 0 usecs
[    8.794216] calling  noop_init+0x0/0x11 @ 1
[    8.795638] io scheduler noop registered
[    8.796971] initcall noop_init+0x0/0x11 returned 0 after 1300 usecs
[    8.799071] calling  deadline_init+0x0/0x11 @ 1
[    8.800573] io scheduler deadline registered
[    8.801987] initcall deadline_init+0x0/0x11 returned 0 after 1379 usecs
[    8.804175] calling  cfq_init+0x0/0x78 @ 1
[    8.805512] io scheduler cfq registered (default)
[    8.807109] initcall cfq_init+0x0/0x78 returned 0 after 1576 usecs
[    8.809172] calling  deadline_init+0x0/0x11 @ 1
[    8.810728] io scheduler mq-deadline registered
[    8.812224] initcall dline_init+0x0/0x11 returned 0 after 1460 usecs
[    8.914405] calling  kyber_init+0x0/0x11 @ 1
[    8.915876] io scheduler kyber registered
[    8.917272] initcall kyber_init+0x0/0x11 returned 0 after 1362 usecs
[    8.919430] calling  bfq_init+0x0/0x8e @ 1
[    8.920831] initcall bfq_init+0x0/0x8e returned -28 after 0 usecs
[    8.922845] calling  btree_module_init+0x0/0x25 @ 1
[    8.924454] initcall btree_module_init+0x0/0x25 returned 0 after 2 usecs
[    8.926663] calling  crc_t10dif_mod_init+0x0/0x39 @ 1
[    8.928393] initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 2 usecs
[    8.930651] calling  percpu_counter_startup+0x0/0x51 @ 1
[    8.932525] initcall percpu_counter_startup+0x0/0x51 returned 0 after 106 usecs
[    8.934976] calling  digsig_init+0x0/0x38 @ 1
[    8.936426] initcall digsig_init+0x0/0x38 returned 0 after 1 usecs
[    8.938515] calling  sg_pool_init+0x0/0xc1 @ 1
[    8.940023] initcall sg_pool_init+0x0/0xc1 returned 0 after 18 usecs
[    8.942140] calling  phy_core_init+0x0/0x4c @ 1
[    8.943689] initcall phy_core_init+0x0/0x4c returned 0 after 4 usecs
[    8.945761] calling  crystalcove_pwm_driver_init+0x0/0x13 @ 1
[    8.947661] initcall crystalcove_pwm_driver_init+0x0/0x13 returned 0 after 6 usecs
[    8.950249] calling  pci_proc_init+0x0/0x68 @ 1
[    8.951846] initcall pci_proc_init+0x0/0x68 returned 0 after 38 usecs
[    8.953999] calling  pcie_portdrv_init+0x0/0x35 @ 1
[    8.955879] PCI Interrupt Link [BI02] enabled at IRQ 52
[    8.958016] probe of 0000:00:02.0 returned 1 after 2386 usecs
[    8.959977] probe of 0000:00:0a.0 returned 1 after 33 usecs
[    8.962132] PCI Interrupt Link [BI0C] enabled at IRQ 54
[    8.963948] probe of 0000:00:0c.0 returned 1 after 2055 usecs
[    8.965875] initcall pcie_portdrv_init+0x0/0x35 returned 0 after 10007 usecs
[    8.968260] calling  aer_service_init+0x0/0x3c @ 1
[    8.969953] initcall aer_service_init+0x0/0x3c returned 0 after 5 usecs
[    8.972122] calling  pcie_pme_service_init+0x0/0x11 @ 1
[    8.973893] initcall pcie_pme_service_init+0x0/0x11 returned 0 after 4 usecs
[    76164] calling  dpc_service_init+0x0/0x11 @ 1
[    9.077968] initcall dpc_service_init+0x0/0x11 returned 0 after 4 usecs
[    9.080253] calling  pci_hotplug_init+0x0/0x33 @ 1
[    9.081872] initcall pci_hotplug_init+0x0/0x33 returned 0 after 0 usecs
[    9.084034] calling  pcied_init+0x0/0x5a @ 1
[    9.085476] initcall pcied_init+0x0/0x5a returned 0 after 4 usecs
[    9.087581] calling  shpcd_init+0x0/0x5d @ 1
[    9.089088] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    9.091326] initcall shpcd_init+0x0/0x5d returned 0 after 2199 usecs
[    9.093397] calling  pci_stub_init+0x0/0x155 @ 1
[    9.094994] initcall pci_stub_init+0x0/0x155 returned 0 after 10 usecs
[    9.097124] calling  pci_epc_init+0x0/0x42 @ 1
[    9.098732] initcall pci_epc_init+0x0/0x42 returned 0 after 3 usecs
[    9.100800] calling  pci_epf_init+0x0/0x2c @ 1
[    9.102302] initcall pci_epf_init+0x0/0x2c returned 0 after 6 usecs
[    9.104352] calling  vesafb_driver_init+0x0/0x13 @ 1
[    9.106010] initcall vesafb_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.108257] calling  efifb_driver_init+0x0/0x13 @ 1
[    9.109923] initcall efifb_driver_init+0x0/0x13 returned 0 after 4 usecs
[    9.112152] calling  intel_idle_init+0x0/0x5b2 @ 1
[    9.113779] initcall intel_idle_init+0x0/0x5b2 returned -19 after 0 usecs
[    9.116028] calling  acpi_processor_driver_init+0x0/0x97 @ 1
[    9.117993] probe of cpu0 returned 1 after 88 usecs
[    9.119831] probe of cpu1 returned 1 after 63 usecs
[    9.121543] probe of cpu2 returned 1 after 74 usecs
[    9.123279] probe of cpu3 returned 1 after 73 usecs
[    9.125008] probe of cpu4 returned 1 after 72 usecs
[    9.126768] probe of cpu5 returned 1 after 71 usecs
[    9.128682] probe of cpu6 returned 1 after 71 usecs
[    9.130441] probe of cpu7 returned 1 after 71 usecs
[    9.132210] initcall acpi_processor_driver_init+0x0/0x97 returned 0 after 13973 usecs
[    9.134840] calling  acpi_hed_driver_init+0x0/0x11 @ 1
[    9.136679] initcall acpi_hed_drivenit+0x0/0x11 returned 0 after 90 usecs
[    9.239186] calling  bgrt_init+0x0/0xbc @ 1
[    9.240641] initcall bgrt_init+0x0/0xbc returned -19 after 0 usecs
[    9.242689] calling  erst_init+0x0/0x2de @ 1
[    9.244125] ERST: Error Record Serialization Table (ERST) support is initialized.
[    9.249056] pstore: No deflate compression
[    9.250492] pstore: Registered erst as persistent store backend
[    9.252440] initcall erst_init+0x0/0x2de returned 0 after 8136 usecs
[    9.254513] calling  ghes_init+0x0/0x159 @ 1
[    9.256047] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    9.258460] initcall ghes_init+0x0/0x159 returned 0 after 2466 usecs
[    9.260930] calling  intel_crc_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.263073] initcall intel_crc_pmic_opregion_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.265848] calling  intel_xpower_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.268128] initcall intel_xpower_pmic_opregion_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.270999] calling  intel_bxtwc_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.273207] initcall intel_bxtwc_pmic_opregion_driver_init+0x0/0x13 returned 0 after 7 usecs
[    9.275984] calling  intel_cht_wc_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.278217] initcall intel_cht_wc_pmic_opregion_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.281126] calling  chtdc_ti_pmic_opregion_driver_init+0x0/0x13 @ 1
[    9.283461] initcall chtdc_ti_pmic_opregion_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.286118] calling  gpio_clk_driver_init+0x0/0x13 @ 1
[    9.287822] initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.290222] calling  plt_clk_driver_init+0x0/0x13 @ 1
[    9.291907] initcall plt_clk_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.294097] calling  st_clk_driver_init+0x0/0x13 @ 1
[    9.295796] initcall st_clk_driver_init+0x0/0x13 returned 0 after 4 usecs
[    9.298074] calling  dw_pci_driver_init+0x0/0x1a @ 1
[    9.299732] initcall dw_pci_driver_init+0x0/0x1a returned 0 after 14 usecs
[    9.301956] calling  virtio_pci_driver_init+0x0/0x1a @ 1
[    9.303727] initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 14 usecs
[    9.306115] calling  xenbus_probe_initcall+0x0/0x45 @ 1
[    9.307866] initcall xenbus_probe_initc+0x0/0x45 returned -19 after 0 usecs
[    9.410360] calling  xenbus_init+0x0/0x3b @ 1
[    9.411848] initcall xenbus_init+0x0/0x3b returned -19 after 0 usecs
[    9.413994] calling  xenbus_backend_init+0x0/0x44 @ 1
[    9.415712] initcall xenbus_backend_init+0x0/0x44 returned -19 after 0 usecs
[    9.418139] calling  hyper_sysfs_init+0x0/0x177 @ 1
[    9.419817] initcall hyper_sysfs_init+0x0/0x177 returned -19 after 0 usecs
[    9.422064] calling  hypervisor_subsys_init+0x0/0x26 @ 1
[    9.423824] initcall hypervisor_subsys_init+0x0/0x26 returned -19 after 0 usecs
[    9.426237] calling  platform_driver_init+0x0/0x1a @ 1
[    9.428030] initcall platform_driver_init+0x0/0x1a returned 0 after 11 usecs
[    9.430409] calling  xen_late_init_mcelog+0x0/0x60 @ 1
[    9.432089] initcall xen_late_init_mcelog+0x0/0x60 returned -19 after 0 usecs
[    9.434465] calling  pvcalls_back_init+0x0/0x70 @ 1
[    9.436043] initcall pvcalls_back_init+0x0/0x70 returned -19 after 0 usecs
[    9.438313] calling  n_null_init+0x0/0x1f @ 1
[    9.439836] initcall n_null_init+0x0/0x1f returned 0 after 0 usecs
[    9.441938] calling  pty_init+0x0/0x38e @ 1
[    9.443501] initcall pty_init+0x0/0x38e returned 0 after 176 usecs
[    9.445618] calling  sysrq_init+0x0/0x51 @ 1
[    9.447051] initcall sysrq_init+0x0/0x51 returned 0 after 2 usecs
[    9.449182] calling  xen_hvc_init+0x0/0x22e @ 1
[    9.450658] initcall xen_hvc_init+0x0/0x22e returned -19 after 0 usecs
[    9.452820] calling  serial8250_init+0x0/0x14e @ 1
[    9.454396] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    9.477018] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    9.479834] probe of 00:03 returned 1 after 23327 usecs
[    9.502046] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    9.506178] probe of serial8250 returned 1 after 6 usecs
[    9.508060] initcall serial8250_init+0x0/0x14e returned 0 after 52405 usecs
[    9.510459] calling  serial_pci_driver_init+0x0/0x1a @ 1
[    9.512278] initcall serial_pci_driver_init+0x0/0x1a returned 0 after 49 usecs
[    9.514659] calling  exar_pci_driver_init+0x0/0x1a @ 1
[    9.516412] initcall exar_pci_driver_init+0x0/0x1a returned 0 after 14 usecs
[    9.518868] calling  dw8250_platform_driver_init+0x0/0x13 @ 1
[    9.520783] initcall dw8250_platform_driver_init+0x0/0x13 returned 0 after 7 usecs
[    9.523266] calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
[    9.525141] initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 12 usecs
[    9.527580] calling  mid8250_pci_driver_init+0x0/0x1a @ 1
[    9.529427] initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 10 usecs
[    9.531830] calling  moxa8250_pci_driver_init+0x0/0x1a @ 1
[    9.533721] initcall moxa8250_pci_driver_init+0x0/0x1a returned 0 after 11 usecs
[    9.536150] calling  init+0x0/0x104 @ 1
[    9.537444] initcall init+0x0/0x104 returned 0 after 16 usecs
[    9.539419] calling  hpet_init+0x0/0x65 @ 1
[    9.541031] probe of PNP0103:00 returned 0 after 32 usecs
[    9.542875] initcall hpet_init+0x0/0x65 returned 0 after 2031 usecs
[    9.544937] calling  nvram_init+0x0/0x7d @ 1
[    9.546563] Non-volatile memory driver v1.3
[    9.548158] initcall nvram_init+0x0/0x7d returned 0 after 1715 usecs
[    9.550341] calling  hwrng_modinit+0x0/0x96 @ 1
[    9.552003] initcall hwrng_modinit+0x0/0x96 returned 0 after 163 usecs
[    9.554245] calling  agp_init+0x0/0x26 @ 1
[    9.555629] Linux agpgart interface v0.103
[    9.556906] initcall agp_init+0x0/0x26 returned 0 after 1246 usecs
[    9.559033] calling  agp_amd64_mod_init+0x0/0x20 @ 1
[    9.560714] initcall agp_amd64_mod_init+0x0/0x20 returned -19 after 0 usecs
[    9.563035] calling  agp_intel_init+0x0/0x29 @ 1
[    9.564559] initcall agp_intel_init+0x0/0x29 returned 0 after 15 usecs
[    9.567058] calling  agp_sis_init+0x0/0x29 @ 1
[    9.568689] initcall agp_sis_init+/0x29 returned 0 after 12 usecs
[    9.670860] calling  agp_via_init+0x0/0x29 @ 1
[    9.672369] initcall agp_via_init+0x0/0x29 returned 0 after 14 usecs
[    9.674499] calling  init_tis+0x0/0xb3 @ 1
[    9.675816] initcall init_tis+0x0/0xb3 returned 0 after 11 usecs
[    9.677842] calling  crb_acpi_driver_init+0x0/0x11 @ 1
[    9.679669] initcall crb_acpi_driver_init+0x0/0x11 returned 0 after 31 usecs
[    9.682018] calling  cn_proc_init+0x0/0x38 @ 1
[    9.683485] initcall cn_proc_init+0x0/0x38 returned 0 after 1 usecs
[    9.685607] calling  _nvm_misc_init+0x0/0x11 @ 1
[    9.687304] initcall _nvm_misc_init+0x0/0x11 returned 0 after 166 usecs
[    9.689636] calling  topology_sysfs_init+0x0/0x30 @ 1
[    9.691381] initcall topology_sysfs_init+0x0/0x30 returned 0 after 29 usecs
[    9.693671] calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
[    9.696353] initcall cacheinfo_sysfs_init+0x0/0x2c returned 172 after 987 usecs
[    9.698949] calling  devcoredump_init+0x0/0x18 @ 1
[    9.700581] initcall devcoredump_init+0x0/0x18 returned 0 after 6 usecs
[    9.702792] calling  intel_soc_pmic_i2c_driver_init+0x0/0x13 @ 1
[    9.704836] initcall intel_soc_pmic_i2c_driver_init+0x0/0x13 returned 0 after 8 usecs
[    9.707398] calling  cht_wc_driver_init+0x0/0x13 @ 1
[    9.709146] initcall cht_wc_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.711485] calling  init_sd+0x0/0x168 @ 1
[    9.712912] initcall init_sd+0x0/0x168 returned 0 after 39 usecs
[    9.714945] calling  nvme_core_init+0x0/0x13b @ 1
[    9.716837] initcall nvme_core_init+0x0/0x13b returned 0 after 318 usecs
[    9.719199] calling  nvme_init+0x0/0x1a @ 1
[    9.720614] initcall nvme_init+0x0/0x1a returned 0 after 16 usecs
[    9.722569] calling  ahci_pci_driver_init+0x0/0x1a @ 1
[    9.724326] ahci 0000:00:11.0: version 3.0
[    9.725943] PCI Interrupt Link [SATA] enabled at IRQ 16
[    9.727756] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
[    9.730574] ahci 0000:00:11.0: flags: 64bit ncq s ilck pm led clo pmp pio slum part ccc
[    9.833831] scsi host0: ahci
[    9.834928] ata1: SATA max UDMA/133 abar m1024@0xfccf0000 port 0xfccf0100 irq 16
[    9.837469] probe of 0000:00:11.0 returned 1 after 113157 usecs
[    9.839656] initcall ahci_pci_driver_init+0x0/0x1a returned 0 after 112648 usecs
[    9.842089] calling  net_olddevs_init+0x0/0x56 @ 1
[    9.843697] initcall net_olddevs_init+0x0/0x56 returned 0 after 2 usecs
[    9.845894] calling  kgdbdbgp_start_thread+0x0/0x4f @ 1
[    9.847612] initcall kgdbdbgp_start_thread+0x0/0x4f returned 0 after 0 usecs
[    9.850001] calling  ledtrig_usb_init+0x0/0x2e @ 1
[    9.851593] initcall ledtrig_usb_init+0x0/0x2e returned 0 after 2 usecs
[    9.853756] calling  i8042_init+0x0/0x476 @ 1
[    9.855274] probe of 00:01 returned 1 after 8 usecs
[    9.856925] probe of 00:02 returned 1 after 5 usecs
[    9.858513] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    9.863000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    9.864761] serio: i8042 AUX port at 0x60,0x64 irq 12
[    9.866514] probe of i8042 returned 1 after 5139 usecs
[    9.868246] initcall i8042_init+0x0/0x476 returned 0 after 12678 usecs
[    9.870493] calling  input_leds_init+0x0/0x11 @ 1
[    9.872059] initcall input_leds_init+0x0/0x11 returned 0 after 0 usecs
[    9.874504] calling  mousedev_init+0x0/0x85 @ 1
[    9.876321] mousedev: PS/2 mouse device common for all mice
[    9.878275] initcall mousedev_init+0x0/0x85 returned 0 after 2198 usecs
[    9.880581] calling  evdev_init+0x0/0x11 @ 1
[    9.881990] initcall evdev_init+0x0/0x11 returned 0 after 0 usecs
[    9.884078] calling  atkbd_init+0x0/0x26 @ 1
[    9.885538] initcall atkbd_init+0x0/0x26 returned 0 after 27 usecs
[    9.887616] calling  psmouse_init+0x0/0x8b @ 1
[    9.889224] initcall psmouse_init+0x0/0x8b returned 0 after 34 usecs
[    9.891263] calling  cmos_init+0x0/0x76 @ 1
[    9.892735] rtc_cmos 00:04: RTC can wake from S4
[    9.894625] rtc_cmos 00:04: registered as rtc0
[    9.896164] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    9.898806] probe of 00:04 returned 1 after 6087 usecs
[    9.900509] initcall cmos_init+0x0/0x76 returned 0 after 7610 usecs
[    9.902585] calling  watchdog_gov_noop_register+0x0/0x11 @ 1
[    9.904473] initcall watchdog_gov_noop_register+0x0/0x11 returned 0 after 0 usecs
[    9.906973] calling  intel_pstate_init+0x0/0x374 @ 1
[    9.908664] initcall intel_pstate_init+0x0/0x374 returned -19 after 0 usecs
[    9.910988] calli ledtrig_disk_init+0x0/0x54 @ 1
[   10.012734] initcall ledtrig_disk_init+0x0/0x54 returned 0 after 8 usecs
[   10.014990] calling  ledtrig_cpu_init+0x0/0xd8 @ 1
[   10.017076] ledtrig-cpu: registered to indicate activity on CPUs
[   10.019191] initcall ledtrig_cpu_init+0x0/0xd8 returned 0 after 2637 usecs
[   10.021507] calling  efivars_sysfs_init+0x0/0x220 @ 1
[   10.023206] initcall efivars_sysfs_init+0x0/0x220 returned -19 after 0 usecs
[   10.025554] calling  esrt_sysfs_init+0x0/0x2ec @ 1
[   10.027147] initcall esrt_sysfs_init+0x0/0x2ec returned -38 after 0 usecs
[   10.029507] calling  hid_init+0x0/0x65 @ 1
[   10.030900] hidraw: raw HID events driver (C) Jiri Kosina
[   10.032641] initcall hid_init+0x0/0x65 returned 0 after 1707 usecs
[   10.034716] calling  pmc_core_probe+0x0/0x244 @ 1
[   10.036269] initcall pmc_core_probe+0x0/0x244 returned -19 after 0 usecs
[   10.038517] calling  pmc_atom_init+0x0/0x270 @ 1
[   10.040023] initcall pmc_atom_init+0x0/0x270 returned -19 after 8 usecs
[   10.042231] calling  extcon_class_init+0x0/0x17 @ 1
[   10.043938] initcall extcon_class_init+0x0/0x17 returned 0 after 3 usecs
[   10.046361] probe of serio0 returned 0 after 160836 usecs
[   10.048392] calling  powercap_init+0x0/0x27d @ 1
[   10.050073] initcall powercap_init+0x0/0x27d returned 0 after 38 usecs
[   10.052245] calling  pm_check_save_msr+0x0/0x20 @ 1
[   10.053919] initcall pm_check_save_msr+0x0/0x20 returned 0 after 0 usecs
[   10.056152] calling  sock_diag_init+0x0/0x36 @ 1
[   10.057765] initcall sock_diag_init+0x0/0x36 returned 0 after 58 usecs
[   10.060063] calling  blackhole_init+0x0/0x11 @ 1
[   10.061636] initcall blackhole_init+0x0/0x11 returned 0 after 1 usecs
[   10.063732] calling  gre_offload_init+0x0/0x47 @ 1
[   10.065360] initcall gre_offload_init+0x0/0x47 returned 0 after 0 usecs
[   10.068034] calling  sysctl_ipv4_init+0x0/0x4e @ 1
[   10.069812] initcall sysctl_ipv4_init+0x0/0x4e returned 0 after 41 usecs
[   10.072243] calling  cubictcp_register+0x0/0x58 @ 1
[   10.073937] initcall cubictcp_register+0x0/0x58 returned 0 after 0 us
[   10.110177] probe of serio1 returned 0 after 61943 usecs
[   10.150827] ata1: SATA link down (SStatus 0 SControl 300)
[   10.176208] calling  inet6_init+0x0/0x376 @ 1
[   10.181365] NET: Registered protocol family 10
[   10.187813] Segment Routing with IPv6
[   10.189221] initcall inet6_init+0x0/0x376 returned 0 after 7719 usecs
[   10.191363] calling  strp_mod_init+0x0/0x33 @ 1
[   10.192979] initcall strp_mod_init+0x0/0x33 returned 0 after 70 usecs
[   10.193437] probe of serio1 returned 0 after 15446 usecs
[   10.195172] calling  dcbnl_init+0x0/0x4d @ 1
[   10.195175] initcall dcbnl_init+0x0/0x4d returned 0 after 0 usecs
[   10.200452] calling  mcheck_init_device+0x0/0x12c @ 1
[   10.203137] initcall mcheck_init_device+0x0/0x12c returned 0 after 862 usecs
[   10.205596] calling  dev_mcelog_init_device+0x0/0x53 @ 1
[   10.207403] initcall dev_mcelog_init_device+0x0/0x53 returned 0 after 37 usecs
[   10.210061] calling  tboot_late_init+0x0/0x34b @ 1
[   10.211779] initcall tboot_late_init+0x0/0x34b returned 0 after 0 usecs
[   10.214011] calling  intel_rdt_late_init+0x0/0x49c @ 1
[   10.215747] initcall intel_rdt_late_init+0x0/0x49c returned -19 after 0 usecs
[   10.218206] calling  mcheck_late_init+0x0/0x4e @ 1
[   10.219861] RAS: Correctable Errors collector initialized.
[   10.221955] initcall mcheck_late_init+0x0/0x4e returned 0 after 2061 usecs
[   10.224216] calling  severities_debugfs_init+0x0/0x3c @ 1
[   10.226059] initcall severities_debugfs_init+0x0/0x3c returned 0 after 1 usecs
[   10.228449] calling  threshold_init_device+0x0/0x46 @ 1
[   10.231085] initcall threshold_init_device+0x0/0x46 returned 0 after 776 usecs
[   10.233559] calling  microcode_init+0x0/0x1d7 @ 1
[   10.235340] microcode: CPU0: patch_level=0x06000852
[   10.237071] microcode: CPU1: patch_level=0x06000852
[   10.238779] microcode: CPU2: patch_level=0x06000852
[   10.240407] microcode: CPU3: patch_level=0x06000852
[   10.242207] microcode: CPU4: patch_level=0x06000852
[   10.243913] microcode: CPU5: patch_level=0x06000852
[   10.245676] microcode: CPU6: patch_level=0x06000852
[   10.247486] microcode: CPU7: patch_level=0x06000852
[   10.249253] microcode: Microcode Update Driver: v2.2.
[   10.249256] initcall microcode_init+0x0/0x1d7 returned 0 after 13762 usecs
[   10.253265] calling  hpet_insert_resource+0x0/0x23 @ 1
[   10.254987] initcall hpet_insert_resource+0x0/0x23 returned 0 after 1 usecs
[   10.254] calling  update_mp_table+0x0/0x4ff @ 1
[   10.359006] initcall update_mp_table+0x0/0x4ff returned 0 after 0 usecs
[   10.361284] calling  lapic_insert_resource+0x0/0x3f @ 1
[   10.363067] initcall lapic_insert_resource+0x0/0x3f returned 0 after 0 usecs
[   10.365404] calling  print_ICs+0x0/0x1d1 @ 1
[   10.366864] initcall print_ICs+0x0/0x1d1 returned 0 after 0 usecs
[   10.369012] calling  pat_memtype_list_init+0x0/0x32 @ 1
[   10.370756] initcall pat_memtype_list_init+0x0/0x32 returned 0 after 2 usecs
[   10.373085] calling  create_tlb_single_page_flush_ceiling+0x0/0x29 @ 1
[   10.375239] initcall create_tlb_single_page_flush_ceiling+0x0/0x29 returned 0 after 1 usecs
[   10.378030] calling  create_init_pkru_value+0x0/0x29 @ 1
[   10.379886] initcall create_init_pkru_value+0x0/0x29 returned 0 after 1 usecs
[   10.382252] calling  init_oops_id+0x0/0x40 @ 1
[   10.383765] initcall init_oops_id+0x0/0x40 returned 0 after 0 usecs
[   10.385861] calling  sched_clock_init_late+0x0/0x87 @ 1
[   10.387593] sched_clock: Marking stable (9332389700, 1053468215)->(12063622139, -1677764224)
[   10.390943] initcall sched_clock_init_late+0x0/0x87 returned 0 after 3271 usecs
[   10.393425] calling  sched_init_debug+0x0/0x3e @ 1
[   10.395084] initcall sched_init_debug+0x0/0x3e returned 0 after 4 usecs
[   10.397249] calling  pm_qos_power_init+0x0/0xba @ 1
[   10.399073] initcall pm_qos_power_init+0x0/0xba returned 0 after 110 usecs
[   10.401377] calling  pm_debugfs_init+0x0/0x24 @ 1
[   10.402963] initcall pm_debugfs_init+0x0/0x24 returned 0 after 3 usecs
[   10.405056] calling  printk_late_init+0x0/0x160 @ 1
[   10.406678] initcall printk_late_init+0x0/0x160 returned 0 after 0 usecs
[   10.408998] calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
[   10.410827] initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 1 usecs
[   10.413204] calling  debugfs_kprobe_init+0x0/0xa9 @ 1
[   10.414883] initcall debugfs_kprobe_init+0x0/0xa9 returned 0 after 4 usecs
[   10.417144] calling  taskstats_inix0/0x39 @ 1
[   10.518783] registered taskstats version 1
[   10.520162] initcall taskstats_init+0x0/0x39 returned 0 after 1359 usecs
[   10.522378] calling  kdb_ftrace_register+0x0/0x2d @ 1
[   10.524116] initcall kdb_ftrace_register+0x0/0x2d returned 0 after 2 usecs
[   10.526350] calling  load_system_certificate_list+0x0/0xff @ 1
[   10.528301] Loading compiled-in X.509 certificates
[   10.531206] Loaded X.509 cert 'Build time autogenerated kernel key: 84e50100ee138d51da8a0bcee80b45d470f2ecf9'
[   10.534506] initcall load_system_certificate_list+0x0/0xff returned 0 after 6058 usecs
[   10.537124] calling  fault_around_debugfs+0x0/0x35 @ 1
[   10.538921] initcall fault_around_debugfs+0x0/0x35 returned 0 after 3 usecs
[   10.541301] calling  max_swapfiles_check+0x0/0x8 @ 1
[   10.542911] initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
[   10.545207] calling  init_zswap+0x0/0x441 @ 1
[   10.546684] zswap: loaded using pool lzo/zbud
[   10.548556] initcall init_zswap+0x0/0x441 returned 0 after 1847 usecs
[   10.550708] calling  split_huge_pages_debugfs+0x0/0x35 @ 1
[   10.552602] initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 2 usecs
[   10.555036] calling  check_early_ioremap_leak+0x0/0x38 @ 1
[   10.556865] initcall check_early_ioremap_leak+0x0/0x38 returned 0 after 0 usecs
[   10.559353] calling  init_root_keyring+0x0/0xa @ 1
[   10.560978] initcall init_root_keyring+0x0/0xa returned 0 after 5 usecs
[   10.563190] calling  big_key_init+0x0/0xbb @ 1
[   10.569433] Key type big_key registered
[   10.570796] initcall big_key_init+0x0/0xbb returned 0 after 5955 usecs
[   10.573008] calling  init_encrypted+0x0/0xcb @ 1
[   10.576818] Key type encrypted registered
[   10.578276] initcall init_encrypted+0x0/0xcb returned 0 after 3665 usecs
[   10.580699] calling  init_profile_hash+0x0/0x80 @ 1
[   10.582316] AppArmor: AppArmor sha1 policy hashing enabled
[   10.584169] initcall init_profile_hash+0x0/0x80 returned 0 after 1810 usecs
[   10.586479] calling  integrity_fs_init+0x0/0x4b @ 1
[   10.588124] initcall integrity_fs_init+0x0/0x4b returned 0 after 4 usecs
[   10.590718] calling  init_ima+0x0/0x8a @ 1
[   10.592100] ima: No TPM chip found, activating TPM-bypass!
[   10.593973] ima: Allocated hash algorithm: sha256
[   10.595577] initcall init_ima+0x0/0x8a returned 0 after 3396 usecs
[   10.597677] calling  init_evm+0x0/0xee @ 1
[   10.599066] evm: Initialising EVM extended attributes:
[   10.600795] evm: security.selinux
[   10.601975] evm: security.apparmor
[   10.603123] evm: security.ima
[   10.604132] evm: security.capability
[   10.605408] evm: HMAC attrs: 0x1
[   10.606522] initcall init_evm+0x0/0xee returned 0 after 7279 usecs
[   10.608694] calling  fail_make_request_debugfs+0x0/0x28 @ 1
[   10.610521] initcall fail_make_request_debugfs+0x0/0x28 returned 0 after 12 usecs
[   10.613006] calling  prandom_reseed+0x0/0x2a @ 1
[   10.614526] initcall prandom_reseed+0x0/0x2a returned 0 after 5 usecs
[   10.616632] calling  init_error_injection+0x0/0x6a @ 1
[   10.618586] initcall init_error_injection+0x0/0x6a returned 0 after 187 usecs
[   10.621114] calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
[   10.623233] initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 2 usecs
[   10.625911] calling  pci_sysfs_init+0x0/0x4b @ 1
[   10.627832] initcall pci_sysfs_init+0x0/0x4b returned 0 after 278 usecs
[   10.630216] calling  bert_init+0x0/0x216 @ 1
[   10.631715] initcall bert_init+0x0/0x216 returned 0 after 12 usecs
[   10.633796] calling  clk_debug_init+0x0/0x111 @ 1
[   10.635385] initcall clk_debug_init+0x0/0x111 returned 0 after 7 usecs
[   10.637517] calling  boot_w_for_devices+0x0/0x28 @ 1
[   10.739350] initcall boot_wait_for_devices+0x0/0x28 returned -19 after 0 usecs
[   10.741783] calling  dmar_free_unused_resources+0x0/0xb5 @ 1
[   10.743658] initcall dmar_free_unused_resources+0x0/0xb5 returned 0 after 0 usecs
[   10.746096] calling  deferred_probe_initcall+0x0/0xa0 @ 1
[   10.747928] initcall deferred_probe_initcall+0x0/0xa0 returned 0 after 10 usecs
[   10.750394] calling  late_resume_init+0x0/0x1a0 @ 1
[   10.752048]   Magic number: 2:306:285
[   10.753386] initcall late_resume_init+0x0/0x1a0 returned 0 after 1306 usecs
[   10.755754] calling  genpd_power_off_unused+0x0/0x80 @ 1
[   10.757496] initcall genpd_power_off_unused+0x0/0x80 returned 0 after 0 usecs
[   10.760018] calling  genpd_debug_init+0x0/0x17d @ 1
[   10.761726] initcall genpd_debug_init+0x0/0x17d returned 0 after 4 usecs
[   10.763922] calling  rtc_hctosys+0x0/0xed @ 1
[   10.765506] rtc_cmos 00:04: setting system clock to 2018-09-13 15:15:29 UTC (1536851729)
[   10.768312] initcall rtc_hctosys+0x0/0xed returned 0 after 2910 usecs
[   10.770585] calling  firmware_memmap_init+0x0/0x33 @ 1
[   10.772360] initcall firmware_memmap_init+0x0/0x33 returned 0 after 31 usecs
[   10.774748] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[   10.776795] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 0 usecs
[   10.779421] calling  efi_shutdown_init+0x0/0x3e @ 1
[   10.781110] initcall efi_shutdown_init+0x0/0x3e returned -19 after 0 usecs
[   10.783300] calling  itmt_legacy_init+0x0/0x4a @ 1
[   10.784930] initcall itmt_legacy_init+0x0/0x4a returned -19 after 0 usecs
[   10.787133] calling  pci_mmcfg_late_insert_resources+0x0/0x4b @ 1
[   10.789216] initcall pci_mmcfg_late_insert_resources+0x0/0x4b returned 0 after 0 usecs
[   10.791826] calling  tcp_congestion_default+0x0/0x18 @ 1
[   10.793606] initcall tcp_congestion_default+0x0/0x18 returned 0 after 0 usecs
[   10.795922] calling  ip_auto_config+0x0/0xc2 @ 1
[   10.797438] initcall ip_auto_config+0x0/2 returned 0 after 5 usecs
[   10.899706] calling  software_resume+0x0/0x290 @ 1
[   10.901362] initcall software_resume+0x0/0x290 returned -19 after 1 usecs
[   10.903620] calling  clear_boot_tracer+0x0/0x28 @ 1
[   10.905222] initcall clear_boot_tracer+0x0/0x28 returned 0 after 0 usecs
[   10.907445] calling  tracing_set_default_clock+0x0/0x35 @ 1
[   10.909380] initcall tracing_set_default_clock+0x0/0x35 returned 0 after 0 usecs
[   10.912156] calling  acpi_gpio_handle_deferred_request_interrupts+0x0/0xd0 @ 1
[   10.914462] initcall acpi_gpio_handle_deferred_request_interrupts+0x0/0xd0 returned 0 after 0 usecs
[   10.917314] calling  clk_disable_unused+0x0/0x100 @ 1
[   10.919034] initcall clk_disable_unused+0x0/0x100 returned 0 after 0 usecs
[   11.332585] Freeing unused kernel image memory: 2048K
[   11.356664] Write protecting the kernel read-only data: 18432k
[   11.386457] Freeing unused kernel image memory: 2008K
[   11.410780] Freeing unused kernel image memory: 532K
[   11.434670] Run /init as init process
[   11.456282] random: systemd: uninitialized urandom read (16 bytes read)
[   11.488299] random: systemd: uninitialized urandom read (16 bytes read)
[   11.519678] random: systemd: uninitialized urandom read (16 bytes read)
[   11.555359] systemd[1]: systemd 228 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[   11.661099] systemd[1]: Detected architecture x86-64.
[   11.684946] systemd[1]: Running in initial RAM disk.
[   11.708238] systemd[1]: Set hostname to <ph039>.
[   11.787579] systemd[1]: Reached target Swap.
[   11.808186] systemd[1]: Listening on Journal Audit Socket.
[   11.834869] systemd[1]: Created slice System Slice.
[   11.858380] systemd[1]: Created slice system-systemd\x2dhibernate\x2dresume.slice.
[   11.894315] systemd[1]: Listening on Journal Socket (/dev/log).
[   11.922724] systemd[1]: Listening on udev Kernel Socket.
[   11.955623] scsi_dh_alua: module verification failed: signature and/or required key missing - tainting kernel
[   12.003430] calling  alua_init+0x0/0x1000 [scsi_dh_alua] @ 202
[   12.031674] alua: device handler registered
[   12.051940] initcall alua_init+0x0/0x1000 [scsi_dh_alua] returned 0 after 19990 usecs
[   12.090798] calling  clariion_init+0x0/0x1000 [scsi_dh_emc] @ 202
[   12.120144] emc: device handler registered
[   12.140027] initcall clariion_init+0x0/0x1000 [scsi_dh_emc] returned 0 after 19416 usecs
[   12.179030] calling  rdac_init+0x0/0x1000 [scsi_dh_rdac] @ 202
[   12.207113] rdac: device handler registered
[   12.224186] random: crng init done
[   12.227267] initcall rdac_init+0x0/0x1000 [scsi_dh_rdac] returned 0 after 19679 usecs
[   12.243293] random: 7 urandom warning(s) missed due to ratelimiting
[   12.314031] calling  dm_init+0x0/0x52 [dm_mod] @ 202
[   12.337837] device-mapper: uevent: version 1.0.3
[   12.337939] calling  sas_transport_init+0x0/0x1000 [scsi_transport_sas] @ 300
[   12.360189] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[   12.394072] initcall sas_transport_init+0x0/0x1000 [scsi_transport_sas] returned 0 after 67 usecs
[   12.434869] initcall dm_init+0x0/0x52 [dm_mod] returned 0 after 39896 usecs
[   12.510982] calling  usb_init+0x0/0x145 [usbcore] @ 299
[   12.536554] ACPI: bus type USB registered
[   12.555647] usbcore: registered new interface driver usbfs
[   12.555684] usbcore: registered new interface driver hub
[   12.555749] usbcore: registered new device driver usb
[   12.555763] initcall usb_init+0x0/0x145 [usbcore] returned 0 after 18842 usecs
[   12.556208] calling  drm_core_init+0x0/0xde [drm] @ 314
[   12.556318] initcall drm_core_init+0x0/0xde [drm] returned 0 after 67 usecs
[   12.726071] calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 303
[   12.726330] calling  hpsa_init+0x0/0x1000 [hpsa] @ 300
[   12.759348] calling  atiixp_pci_driver_init+0x0/0x1000 [pata_atiixp] @ 306
[   12.759361] calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 295
[   12.759366] initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 79 usecs
[   12.759387] initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 21 usecs
[   12.759447] calling  dm_multipath_init+0x0/0x1000 [dm_multipath] @ 202
[   12.759785] initcall dm_multipath_init+0x0/0x1000 [dm_multipath] returned 0 after 318 usecs
[   12.783910] HP HPSA Driver (v 3.4.20-125)
[   12.888733] calling  ehci_hcd_init+0x0/0x1000 [ehci_hcd] @ 299
[   12.927112] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   12.958725] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.999213] PCI Interrupt Link [I020] enabled at IRQ 24
[   13.018126] initcall ehci_hcd_init+0x0/0x1000 [ehci_hcd] returned 0 after 58015 usecs
[   13.046312] hpsa 0000:03:00.0: Logical aborts not supported
[   13.202099] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
[   13.202447] pata_atiixp 0000:00:14.1: can't derive routing for PCI INT A
[   13.265669] calling  ehci_pci_init+0x0/0x1000 [ehci_pci] @ 315
[   13.267523] scsi host2: pata_atiixp
[   13.294041] ehci-pci: EHCI PCI platform driver
[   13.311019] scsi host3: pata_atiixp
[   13.349080] scsi host1: hpsa
[   13.362897] ata2: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x500 irq 14
[   13.396301] hpsa can't handle SMP requests
[   13.416169] ata3: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x508 irq 15
[   13.449425] probe of 0000:00:14.1 returned 1 after 632415 usecs
[   13.449727] ehci-pci 0000:00:12.2: EHCI Host Controller
[   13.478114] initcall atiixp_pci_driver_init+0x0/0x1000 [pata_atiixp] returned 0 after 179752 usecs
[   13.503370] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[   13.581973] calling  ohci_hcd_mod_init+0x0/0x1000 [ohci_hcd] @ 297
[   13.582011] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   13.610983] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   13.610992] initcall ohci_hcd_mod_init+0x0/0x1000 [ohci_hcd] returned 0 after 6 usecs
[   13.720148] ehci-pci 0000:00:12.2: debug port 1
[   13.720279] calling  ttm_init+0x0/0x1000 [ttm] @ 314
[   13.720301] calling  init_sg+0x0/0x1000 [sg] @ 202
[   13.720335] initcall init_sg+0x0/0x1000 [sg] returned 0 after 27 usecs
[   13.742249] ehci-pci 0000:00:12.2: irq 23, io mem 0xfccc0000
[   13.765963] initcall ttm_init+0x0/0x1000 [ttm] returned 0 after 55 usecs
[   13.791348] hpsa 0000:03:00.0: scsi 1:0:0:0: added RAID              HP       P420i            controller SSDSmartPathCap- En- Exp=1
[   13.935380] hpsa 0000:03:00.0: scsi 1:0:1:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   13.991537] hpsa 0000:03:00.0: scsi 1:0:2:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   14.048069] hpsa 0000:03:00.0: scsi 1:0:3:0: masked Direct-Access     HP       EG000300JWBHR    PHYS DRV SSDSmartPathCap- En- Exp=0
[   14.105534] hpsa 0000:03:00.0: scsi 1:0:4:0: masked Enclosure         PMCSIERA SRCv8x6G         enclosure SSDSmartPathCap- En- Exp=0
[   14.162843] hpsa 0000:03:00.0: scsi 1:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   14.218645] hpsa 0000:03:00.0: scsi 1:1:0:1: added Direct-Access     HP       LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
[   14.274370] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   14.302261] hpsa can't handle SMP requests
[   14.321971] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   14.361973] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.362074] calling  uhci_hcd_init+0x0/0x1000 [uhci_hcd] @ 309
[   14.396510] usb usb1: Product: EHCI Host Controller
[   14.424600] uhci_hcd: USB Universal Host Controller Interface driver
[   14.479040] scsi 1:0:0:0: RAID              HP       P420i            8.32 PQ: 0 ANSI: 5
[   14.518099] usb usb1: Manufacturer: Linux 4.19.0-rc3-default+ ehci_hcd
[   14.549372] usb usb1: SerialNumber: 0000:00:12.2
[   14.549426] calling  ata_generic_pci_driver_init+0x0/0x1000 [ata_generic] @ 306
[   14.571642] probe of 1:0:0:0 returned 0 after 14 usecs
[   14.606465] initcall ata_generic_pci_driver_init+0x0/0x1000 [ata_generic] returned 0 after 39 usecs
[   14.630951] hub 1-0:1.0: USB hub found
[   14.692114] scsi 1:0:0:0: Attached scsi generic sg0 type 12
[   14.719053] hub 1-0:1.0: 6 ports detected
[   14.738479] scsi 1:1:0:0: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   14.777821] probe of 1-0:1.0 returned 1 after 146880 usecs
[   14.804208] probe of usb1 returned 1 after 173304 usecs
[   14.829504] uhci_hcd 0000:02:00.4: UHCI Host Controller
[   14.855082] probe of 1:1:0:0 returned 1 after 61 usecs
[   14.855356] sd 1:1:0:0: [sda] 585871964 512-byte logical blocks: (300 GB/279 GiB)
[   14.879672] uhci_hcd 0000:02:00.4: new USB bus registered, assigned bus number 2
[   14.879770] probe of 0000:00:12.2 returned 1 after 1547665 usecs
[   14.915314] sd 1:1:0:0: [sda] Write Protect is off
[   14.950853] sd 1:1:0:0: Attached scsi generic sg1 type 0
[   14.979685] sd 1:1:0:0: [sda] Mode Sense: 73 00 00 08
[   15.002628] uhci_hcd 0000:02:00.4: detected 8 ports
[   15.028351] sd 1:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   15.052477] uhci_hcd 0000:02:00.4: port count misdetected? forcing to 2 ports
[   15.076724]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   15.120497] scsi 1:1:0:1: Direct-Access     HP       LOGICAL VOLUME   8.32 PQ: 0 ANSI: 5
[   15.155695] sd 1:1:0:0: [sda] Attached SCSI disk
[   15.178457] uhci_hcd 0000:02:00.4: irq 36, io base 0x00003c00
[   15.178578] calling  drm_kms_helper_init+0x0/0x14 [drm_kms_helper] @ 314
[   15.178619] initcall drm_kms_helper_init+0x0/0x14 [drm_kms_helper] returned 0 after 26 usecs
[   15.340334] probe of 1:1:0:1 returned 1 after 48 usecs
[   15.340476] sd 1:1:0:1: [sdb] 1171743324 512-byte logical blocks: (600 GB/559 GiB)
[   15.364951] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   15.401485] sd 1:1:0:1: [sdb] Write Protect is off
[   15.441583] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.441752] calling  mgag200_init+0x0/0x1000 [mgag200] @ 314
[   15.464396] sd 1:1:0:1: [sdb] Mode Sense: 73 00 00 08
[   15.464456] sd 1:1:0:1: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   15.498921] sd 1:1:0:1: Attached scsi generic sg2 type 0
[   15.526680]  sdb: sdb1
[   15.550692] usb usb2: Product: UHCI Host Controller
[   15.595370] sd 1:1:0:1: [sdb] Attached SCSI disk
[   15.620507] usb usb2: Manufacturer: Linux 4.19.0-rc3-default+ uhci_hcd
[   15.708951] usb usb2: SerialNumber: 0000:02:00.4
[   15.709079] probe of 0000:03:00.0 returned 1 after 2925199 usecs
[   15.731267] hub 2-0:1.0: USB hub found
[   15.760198] initcall hpsa_init+0x0/0x1000 [hpsa] returned 0 after 310972 usecs
[   15.778154] hub 2-0:1.0: 2 ports detected
[   15.832417] probe of 2-0:1.0 returned 1 after 101154 usecs
[   15.860660] probe of usb2 returned 1 after 129428 usecs
[   15.885679] ehci-pci 0000:00:13.2: EHCI Host Controller
[   15.910765] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
[   15.910794] probe of 0000:02:00.4 returned 1 after 1486146 usecs
[   15.916950] PM: Image not found (code -22)
[   15.946904] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   15.976184] initcall uhci_hcd_init+0x0/0x1000 [uhci_hcd] returned 0 after 521896 usecs
[   15.996105] ehci-pci 0000:00:13.2: debug port 1
[   16.099943] ehci-pci 0000:00:13.2: irq 22, io mem 0xfcc90000
[   16.100108] calling  init_module+0x0/0x1000 [raid6_pq] @ 366
[   16.138839] [TTM] Zone  kernel: Available graphics memory: 16347754 kiB
[   16.185722] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   16.212648] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   16.220216] raid6: sse2x1   gen()  5389 MB/s
[   16.243851] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[   16.304499] [TTM] Initializing pool allocator
[   16.325454] [TTM] Initializing DMA pool allocator
[   16.332213] raid6: sse2x1   xor()  3961 MB/s
[   16.352212] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   16.411518] usb usb3: Product: EHCI Host Controller
[   16.434855] usb usb3: Manufacturer: Linux 4.19.0-rc3-default+ ehci_hcd
[   16.436211] raid6: sse2x2   gen()  8651 MB/s
[   16.480216] usb usb3: SerialNumber: 0000:00:13.2
[   16.528296] fbcon: mgadrmfb (fb0) is primary device
[   16.544279] hub 3-0:1.0: USB hub found
[   16.544287] hub 3-0:1.0: 6 ports detected
[   16.544417] probe of 3-0:1.0 returned 1 after 144 usecs
[   16.544441] probe of usb3 returned 1 after 210 usecs
[   16.544515] probe of 0000:00:13.2 returned 1 after 1664737 usecs
[   16.544562] initcall ehci_pci_init+0x0/0x1000 [ehci_pci] returned 0 after 380902 usecs
[   16.545053] calling  ohci_pci_init+0x0/0x1000 [ohci_pci] @ 297
[   16.545055] ohci-pci: OHCI PCI platform driver
[   16.552214] raid6: sse2x2   xor()  5843 MB/s
[   16.620213] raid6: sse2x4   gen()  8110 MB/s
[   16.634790] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   16.634798] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[   16.634828] ohci-pci 0000:00:12.0: irq 22, io mem 0xfcce0000
[   16.656422] usb 1-2: new high-speed USB device number 2 using ehci-pci
[   16.688215] raid6: sse2x4   xor()  5217 MB/s
[   16.688216] raid6: using algorithm sse2x2 gen() 8651 MB/s
[   16.688217] raid6: .... xor() 5843 MB/s, rmw enabled
[   16.688218] raid6: using ssse3x2 recovery algorithm
[   16.688224] initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 139809 usecs
[   16.689229] calling  calibrate_xor_blocks+0x0/0xf1b [xor] @ 366
[   16.689230] xor: automatically using best checksumming function   avx
[   16.689232] initcall calibrate_xor_blocks+0x0/0xf1b [xor] returned 0 after 1 usecs
[   16.689780] calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 366
[   16.689788] initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 5 usecs
[   16.696313] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   16.696316] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   16.696317] usb usb4: Product: OHCI PCI host controller
[   16.696318] usb usb4: Manufacturer: Linux 4.19.0-rc3-default+ ohci_hcd
[   16.696319] usb usb4: SerialNumber: 0000:00:12.0
[   16.696507] hub 4-0:1.0: USB hub found
[   16.696516] hub 4-0:1.0: 3 ports detected
[   16.696584] probe of 4-0:1.0 returned 1 after 84 usecs
[   16.696605] probe of usb4 returned 1 after 140 usecs
[   16.697070] probe of 0000:00:12.0 returned 1 after 152002 usecs
[   16.707396] calling  init_btrfs_fs+0x0/0x122 [btrfs] @ 366
[   16.707679] Btrfs loaded, crc32c=crc32c-intel, assert=on
[   16.707705] initcall init_btrfs_fs+0x0/0x122 [btrfs] returned 0 after 277 usecs
[   16.708376] BTRFS: device label SLE-12-SP3-GM_MU devid 1 transid 56483 /dev/sda2
[   16.716648] BTRFS: device label SLE-12-SP4-Beta3 devid 1 transid 17724 /dev/sda3
[   16.724808] BTRFS: device fsid a279a180-354e-4250-88aa-69f0bad6d187 devid 1 transid 37 /dev/sda5
[   16.732617] Console: switching to colour frame buffer device 160x64
[   16.739371] BTRFS info (device sda3): disk space caching is enabled
[   16.739373] BTRFS info (device sda3): has skinny extents
[   16.940538] usb 1-2: New USB device found, idVendor=0424, idProduct=2660, bcdDevice= 8.01
[   16.940540] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   17.007835] hub 1-2:1.0: USB hub found
[   17.049693] hub 1-2:1.0: 2 ports detected
[   17.238536] probe of 1-2:1.0 returned 1 after 230706 usecs
[   17.238560] probe of 1-2 returned 1 after 259120 usecs
[   18.208247] mgag200 0000:02:00.1: fb0: mgadrmfb frame buffer device
[   18.208471] ohci-pci 0000:00:12.1: OHCI PCI host controller
[   18.265389] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 5
[   18.265415] ohci-pci 0000:00:12.1: irq 22, io mem 0xfccd0000
[   18.272362] [drm] Initialized mgag200 1.0.0 20110418 for 0000:02:00.1 on minor 0
[   18.368133] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   18.368134] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.368135] usb usb5: Product: OHCI PCI host controller
[   18.368136] usb usb5: Manufacturer: Linux 4.19.0-rc3-default+ ohci_hcd
[   18.368137] usb usb5: SerialNumber: 0000:00:12.1
[   18.368972] probe of 0000:02:00.1 returned 1 after 2927173 usecs
[   18.369161] hub 5-0:1.0: USB hub found
[   18.369198] hub 5-0:1.0: 3 ports detected
[   18.369322] probe of 5-0:1.0 returned 1 after 166 usecs
[   18.369378] probe of usb5 returned 1 after 299 usecs
[   18.369479] initcall mgag200_init+0x0/0x1000 [mgag200] returned 0 after 1623041 usecs
[   18.369551] probe of 0000:00:12.1 returned 1 after 1672477 usecs
[   18.369848] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   18.369853] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 6
[   18.369944] ohci-pci 0000:00:13.0: irq 23, io mem 0xfccb0000
[   18.432537] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   18.894730] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.894731] usb usb6: Product: OHCI PCI host controller
[   18.894732] usb usb6: Manufacturer: Linux 4.19.0-rc3-default+ ohci_hcd
[   18.894733] usb usb6: SerialNumber: 0000:00:13.0
[   18.895007] hub 6-0:1.0: USB hub found
[   19.026318] hub 6-0:1.0: 3 ports detected
[   19.026377] probe of 6-0:1.0 returned 1 after 131374 usecs
[   19.026398] probe of usb6 returned 1 after 131426 usecs
[   19.026455] probe of 0000:00:13.0 returned 1 after 656899 usecs
[   19.126279] ohci-pci 0000:00:13.1: OHCI PCI host controller
[   19.126284] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 7
[   19.188569] ohci-pci 0000:00:13.1: irq 23, io mem 0xfcca0000
[   19.252452] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[   19.291606] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.326444] usb usb7: Product: OHCI PCI host controller
[   19.351462] usb usb7: Manufacturer: Linux 4.19.0-rc3-default+ ohci_hcd
[   19.382803] usb usb7: SerialNumber: 0000:00:13.1
[   19.405301] hub 7-0:1.0: USB hub found
[   19.423260] hub 7-0:1.0: 3 ports detected
[   19.442551] probe of 7-0:1.0 returned 1 after 37255 usecs
[   19.468477] probe of usb7 returned 1 after 63212 usecs
[   19.493260] probe of 0000:00:13.1 returned 1 after 367155 usecs
[   19.521864] initcall ohci_pci_init+0x0/0x1000 [ohci_pci] returned 0 after 2748496 usecs
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
[  OK  ] Closed udev Control Socket.
[  OK  ] Closed udev Kernel Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
         Starting Switch Root...
[   19.622577] systemd-journald[203]: Received SIGTERM from PID 1 (systemd).
[   19.694014] systemd: 16 output lines suppressed due to ratelimiting
[   19.804352] usb 7-3: new low-speed USB device number 2 using ohci-pci
[   19.859001] systemd-sysv-generator[463]: Overwriting existing symlink /run/systemd/generator.late/inputattach.service with real service.
[   20.018365] BTRFS info (device sda3): disk space caching is enabled
[   20.030706] usb 7-3: New USB device found, idVendor=0d3d, idProduct=0040, bcdDevice= 0.01
[   20.087513] usb 7-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   20.122232] usb 7-3: Product: USB CAT5
[   20.147632] probe of 7-3 returned 1 after 7228 usecs
[   20.221345] calling  acpi_button_driver_init+0x0/0x1000 [button] @ 511
[   20.253344] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   20.289538] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 557
[   20.290457] ACPI: Power Button [PWRF]
[   20.339040] probe of LNXPWRBN:00 returned 1 after 85793 usecs
[   20.366570] initcall acpi_button_driver_init+0x0/0x1000 [button] returned 0 after 44409 usecs
[   20.366886] acpi_cpufreq: overriding BIOS provided _PSD data
[   20.435177] calling  fjes_init_module+0x0/0xb1 [fjes] @ 570
[   20.473353] calling  fam15h_power_driver_init+0x0/0x1000 [fam15h_power] @ 604
[   20.494986] initcall fjes_init_module+0x0/0xb1 [fjes] returned -19 after 32217 usecs
[   20.525564] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned 0 after 17406 usecs
[   20.533304] probe of 0000:00:18.4 returned 1 after 1174 usecs
[   20.548935] probe of 0000:00:19.4 returned 0 after 15619 usecs
[   20.640055] initcall fam15h_power_driver_init+0x0/0x1000 [fam15h_power] returned 0 after 129222 usecs
[   20.640182] calling  pps_init+0x0/0x1000 [pps_core] @ 601
[   20.709900] pps_core: LinuxPPS API ver. 1 registered
[   20.734439] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   20.734539] calling  ilo_init+0x0/0x1000 [hpilo] @ 588
[   20.734698] calling  ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] @ 589
[   20.734735] ipmi message handler version 39.2
[   20.734742] initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 38 usecs
[   20.772880] Adding 4192252k swap on /dev/sda1.  Priority:-2 extents:1 across:4192252k FS
[   20.778840] initcall pps_init+0x0/0x1000 [pps_core] returned 0 after 43088 usecs
[   20.805144] probe of 0000:02:00.2 returned 1 after 2019 usecs
[   20.824703] systemd-journald[473]: Received request to flush runtime journal from PID 1
[   21.043187] initcall ilo_init+0x0/0x1000 [hpilo] returned 0 after 234556 usecs
[   21.043218] calling  hpwdt_driver_init+0x0/0x1000 [hpwdt] @ 592
[   21.107305] calling  pcc_cpufreq_init+0x0/0xea9 [pcc_cpufreq] @ 546
[   21.116807] PCI Interrupt Link [I060] enabled at IRQ 47
[   21.137912] initcall pcc_cpufreq_init+0x0/0xea9 [pcc_cpufreq] returned 0 after 118 usecs
[   21.162885] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: NMI decoding initialized
[   21.238643] calling  k10temp_driver_init+0x0/0x1000 [k10temp] @ 572
[   21.238788] probe of 0000:00:18.3 returned 1 after 125 usecs
[   21.238805] hpwdt 0000:02:00.0: HPE Watchdog Timer Driver: 2.0.0, timer margin: 30 seconds (nowayout=0).
[   21.238852] probe of 0000:02:00.0 returned 1 after 130947 usecs
[   21.238899] initcall hpwdt_driver_init+0x0/0x1000 [hpwdt] returned 0 after 241 usecs
[   21.239696] probe of 0000:00:19.3 returned 1 after 900 usecs
[   21.239721] initcall k10temp_driver_init+0x0/0x1000 [k10temp] returned 0 after 1049 usecs
[   21.261109] calling  hid_init+0x0/0x1000 [usbhid] @ 763
[   21.261315] calling  init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] @ 578
[   21.261317] ipmi device interface
[   21.261341] initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 19 usecs
[   21.262405] calling  msr_init+0x0/0x1000 [msr] @ 1091
[   21.265710] probe of 7-3:1.0 returned 1 after 4572 usecs
[   21.268567] calling  pcspkr_platform_driver_init+0x0/0x1000 [pcspkr] @ 616
[   21.268581] calling  piix4_driver_init+0x0/0x1000 [i2c_piix4] @ 579
[   21.269090] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   21.270146] probe of 0000:00:14.0 returned 1 after 1537 usecs
[   21.270194] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   21.270206] initcall piix4_driver_init+0x0/0x1000 [i2c_piix4] returned 0 after 1565 usecs
[   21.270778] probe of 7-3:1.1 returned 1 after 5062 usecs
[   21.270809] usbcore: registered new interface driver usbhid
[   21.270810] usbhid: USB HID core driver
[   21.270823] initcall hid_init+0x0/0x1000 [usbhid] returned 0 after 2177 usecs
[   21.270916] calling  ptp_init+0x0/0x1000 [ptp] @ 601
[   21.271220] PTP clock support registered
[   21.271244] initcall ptp_init+0x0/0x1000 [ptp] returned 0 after 292 usecs
[   21.272771] probe of pcspkr returned 1 after 4179 usecs
[   21.272829] initcall pcspkr_platform_driver_init+0x0/0x1000 [pcspkr] returned 0 after 1847 usecs
[   21.272876] calling  sp5100_tco_init+0x0/0x1000 [sp5100_tco] @ 579
[   21.272887] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   21.273300] probe of sp5100-tco returned 0 after 215 usecs
[   21.273306] initcall sp5100_tco_init+0x0/0x1000 [sp5100_tco] returned 0 after 415 usecs
[   21.273612] initcall msr_init+0x0/0x1000 [msr] returned 0 after 687 usecs
[   21.292380] calling  cryptd_init+0x0/0x1000 [cryptd] @ 630
[   21.292391] cryptd: max_cpu_qlen set to 1000
[   21.292400] initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after 11 usecs
[   21.504948] calling  init_ipmi_si+0x0/0x1a0 [ipmi_si] @ 578
[   22.233537] calling  aes_init+0x0/0x1000 [aes_x86_64] @ 619
[   22.272212] IPMI System Interface driver.
[   22.305137] initcall aes_init+0x0/0x1000 [aes_x86_64] returned 0 after 222 usecs
[   22.331340] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   22.525434] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   22.525436] ipmi_si: Adding SMBIOS-specified kcs state machine
[   22.525461] probe of dmi-ipmi-si.0 returned 1 after 194145 usecs
[   22.525484] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   22.525530] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   22.525533] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[   22.525534] ipmi_si: Adding ACPI-specified kcs state machine
[   22.525553] probe of IPI0001:00 returned 1 after 86 usecs
[   22.525757] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   22.525825] calling  hid_generic_init+0x0/0x1000 [hid_generic] @ 506
[   22.525951] calling  ibft_init+0x0/0xf43 [iscsi_ibft] @ 1149
[   22.525955] No iBFT detected.
[   22.525958] initcall ibft_init+0x0/0xf43 [iscsi_ibft] returned 0 after 2 usecs
[   22.526164] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.0/0003:0D3D:0040.0001/input/input5
[   22.528697] calling  aesni_init+0x0/0x1ed [aesni_intel] @ 614
[   22.528699] AVX version of gcm_enc/dec engaged.
[   22.528700] AES CTR mode by8 optimization enabled
[   22.532053] calling  phy_init+0x0/0x5c [libphy] @ 602
[   22.533071] initcall phy_init+0x0/0x5c [libphy] returned 0 after 971 usecs
[   22.543664] calling  tg3_driver_init+0x0/0x1000 [tg3] @ 601
[   22.543732] tg3.c:v3.137 (May 11, 2014)
[   22.544407] PCI Interrupt Link [I0C0] enabled at IRQ 36
[   22.544442] tg3 0000:04:00.0: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 5
[   22.544464] tg3 0000:04:00.0: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 18 usecs
[   22.549715] calling  crypto_pcbc_module_init+0x0/0x1000 [pcbc] @ 1174
[   22.549721] initcall crypto_pcbc_module_init+0x0/0x1000 [pcbc] returned 0 after 1 usecs
[   22.550419] initcall aesni_init+0x0/0x1ed [aesni_intel] returned 0 after 670 usecs
[   22.552418] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 614
[   22.552921] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 483 usecs
[   22.554605] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 634
[   22.554973] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 351 usecs
[   22.571257] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 628
[   22.571478] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 209 usecs
[   22.577662] tg3 0000:04:00.0 eth0: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:90
[   22.577666] tg3 0000:04:00.0 eth0: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   22.577668] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   22.577670] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   22.577867] probe of 0000:04:00.0 returned 1 after 34158 usecs
[   22.578464] PCI Interrupt Link [I0C1] enabled at IRQ 37
[   22.578496] tg3 0000:04:00.1: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 5
[   22.578521] tg3 0000:04:00.1: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 21 usecs
[   22.586689] hid-generic 0003:0D3D:0040.0001: input,hidraw0: USB HID v1.00 Keyboard [USB CAT5] on usb-0000:00:13.1-3/input0
[   22.586722] probe of 0003:0D3D:0040.0001 returned 1 after 60881 usecs
[   22.587959] input: USB CAT5 as /devices/pci0000:00/0000:00:13.1/usb7/7-3/7-3:1.1/0003:0D3D:0040.0002/input/input6
[   22.588505] hid-generic 0003:0D3D:0040.0002: input,hidraw1: USB HID v1.00 Mouse [USB CAT5] on usb-0000:00:13.1-3/input1
[   22.588525] probe of 0003:0D3D:0040.0002 returned 1 after 1791 usecs
[   22.588560] initcall hid_generic_init+0x0/0x1000 [hid_generic] returned 0 after 16888 usecs
[   22.610796] tg3 0000:04:00.1 eth1: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:91
[   23.416393] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[   23.452970] tg3 0000:04:00.1 eth1: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   23.575722] calling  sp_mod_init+0x0/0x1000 [ccp] @ 617
[   23.610671] tg3 0000:04:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   23.655752] initcall sp_mod_init+0x0/0x1000 [ccp] returned 0 after 159 usecs
[   23.707063] tg3 0000:04:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[   24.156470] ipmi_si IPI0001:00: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x13)
[   24.164936] probe of 0000:04:00.1 returned 1 after 1587058 usecs
[   24.456988] calling  svm_init+0x0/0xb1a [kvm_amd] @ 617
[   24.584803] tg3 0000:04:00.2: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 5
[   24.584807] tg3 0000:04:00.2: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 1 usecs
[   24.610189] tg3 0000:04:00.2 eth2: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:92
[   24.620073] kvm: Nested Virtualization enabled
[   24.654397] tg3 0000:04:00.2 eth2: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   24.705773] kvm: Nested Paging enabled
[   24.727091] tg3 0000:04:00.2 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   24.727096] tg3 0000:04:00.2 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   24.792692] initcall svm_init+0x0/0xb1a [kvm_amd] returned 0 after 203153 usecs
[   24.830454] probe of 0000:04:00.2 returned 1 after 341494 usecs
[   24.926554] tg3 0000:04:00.3: calling  quirk_brcm_5719_limit_mrrs+0x0/0x50 @ 5
[   24.926564] tg3 0000:04:00.3: quirk_brcm_5719_limit_mrrs+0x0/0x50 took 2 usecs
[   24.945301] tg3 0000:04:00.3 eth3: Tigon3 [partno(629133-002) rev 5719001] (PCI Express) MAC address 28:80:23:ae:1a:93
[   24.984605] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   24.996012] tg3 0000:04:00.3 eth3: attached PHY is 5719C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   25.047849] initcall init_ipmi_si+0x0/0x1a0 [ipmi_si] returned 0 after 452328 usecs
[   25.075807] tg3 0000:04:00.3 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[   25.196232] tg3 0000:04:00.3 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[   25.196489] probe of 0000:04:00.3 returned 1 after 270344 usecs
[   25.196554] calling  mce_amd_init+0x0/0x1000 [edac_mce_amd] @ 615
[   25.196556] MCE: In-kernel MCE decoding enabled.
[   25.196560] initcall mce_amd_init+0x0/0x1000 [edac_mce_amd] returned 0 after 2 usecs
[   25.346689] initcall tg3_driver_init+0x0/0x1000 [tg3] returned 0 after 146596 usecs
[   25.384073] calling  init_ipmi_ssif+0x0/0x1e0 [ipmi_ssif] @ 578
[   25.384075] IPMI SSIF Interface driver
[   25.384170] initcall init_ipmi_ssif+0x0/0x1e0 [ipmi_ssif] returned 0 after 89 usecs
[   25.384992] calling  amd64_edac_init+0x0/0x1000 [amd64_edac_mod] @ 630
[   25.499927] EDAC amd64: Node 0: DRAM ECC enabled.
[   25.499930] EDAC amd64: F15h detected (node 0).
[   25.499972] EDAC MC: DCT0 chip selects:
[   25.563206] EDAC amd64: MC: 0:     0MB 1:     0MB
[   25.563210] EDAC amd64: MC: 2:     0MB 3:     0MB
[   25.563213] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[   25.563215] EDAC amd64: MC: 6:     0MB 7:     0MB
[   25.563217] EDAC MC: DCT1 chip selects:
[   25.563219] EDAC amd64: MC: 0:     0MB 1:     0MB
[   25.563221] EDAC amd64: MC: 2:     0MB 3:     0MB
[   25.563224] EDAC amd64: MC: 4:  8192MB 5:  8192MB
[   25.563226] EDAC amd64: MC: 6:     0MB 7:     0MB
[   25.563228] EDAC amd64: using x8 syndromes.
[   25.563230] EDAC amd64: MCT channel count: 2
[   25.563790] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
[   25.563806] EDAC amd64: Node 1: DRAM ECC disabled.
[   25.563808] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[   25.563808]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[   25.563808]  (Note that use of the override may cause unknown side effects.)
[   25.563856] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[   25.563858] AMD64 EDAC driver v3.5.0
[   25.563872] initcall amd64_edac_init+0x0/0x1000 [amd64_edac_mod] returned 0 after 62555 usecs
[   25.640815] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[  *** ] A start job is running for wicked m...twork interfaces (9s / no limit)[   29.271963] tg3 0000:04:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   29.303697] tg3 0000:04:00.0 eth0: Flow control is off for TX and off for RX
[   29.337713] tg3 0000:04:00.0 eth0: EEE is enabled
[   29.359972] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   29.409873] calling  packet_init+0x0/0x1000 [af_packet] @ 1462
[   29.437904] NET: Registered protocol family 17
[   29.459211] initcall packet_init+0x0/0x1000 [af_packet] returned 0 after 20816 usecs
[  OK  ] Started wicked managed network interfaces.
         Starting Load kdump kernel and initrd...
[  OK  ] Reached target Network.
         Starting NTP Server Daemon...
         Starting OpenSSH Daemon...
[  OK  ] Reached target Network is Online.
         Starting Login and scanning of iSCSI devices...
[  OK  ] Started Login and scanning of iSCSI devices.
[  OK  ] Reached target Remote File Systems.
         Starting Permit User Sessions...
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started /etc/init.d/after.local Compatibility.
[  OK  ] Started OpenSSH Daemon.
[  OK  ] Started NTP Server Daemon.
[  OK  ] Reached target System Time Synchronized.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Reached target Timers.
         Starting X Display Manager...
         Starting Postfix Mail Transport Agent...
[  OK  ] Started qaset-service.
         Starting Locale Service...
[  OK  ] Started Locale Service.
         Starting Accounts Service...
[  OK  ] Started X Display Manager.
         Starting Authorization Manager...
[  OK  ] Started Authorization Manager.
[  OK  ] Started Accounts Service.
[  OK  ] Started Postfix Mail Transport Agent.
[  OK  ] Started Command Scheduler.


Welcome to SUSE Linux Enterprise Server 12 SP4 Beta3 (x86_64) - Kernel 4.19.0-rc3-default+ (ttyS0).


ph039 login: root
Password:
Last login: Thu Sep 13 23:12:22 on ttyS0
ph039:~ # reboot
[  OK  ] Stopped wicked managed network interfaces.
         Stopping wicked network nanny service...
[  OK  ] Stopped wicked network nanny service.
         Stopping wicked network management service daemon...
[  OK  ] Stopped wicked network management service daemon.
         Stopping wicked DHCPv4 supplicant service...
         Stopping wicked AutoIPv4 supplicant service...
         Stopping wicked DHCPv6 supplicant service...
[  OK  ] Stopped wicked AutoIPv4 supplicant service.
[  OK  ] Stopped wicked DHCPv4 supplicant service.
[  OK  ] Stopped wicked DHCPv6 supplicant service.
         Stopping D-Bus System Message Bus...
[  OK  ] Stopped D-Bus System Message Bus.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Sockets.
[  OK  ] Closed PC/SC Smart Card Daemon Activation Socket.
[  OK  ] Closed Open-iSCSI iscsid Socket.
[  OK  ] Closed Syslog Socket.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Slices.
[  OK  ] Removed slice User and Session Slice.
[  OK  ] Stopped Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Closed D-Bus System Message Bus Socket.
[  OK  ] Stopped target System Initialization.
         Stopping Load/Save Random Seed...
[  OK  ] Stopped Setup Virtual Console.
[  OK  ] Stopped target Swap.
         Deactivating swap /dev/disk/by-id/w...01c840178773ac64adeb5bf-part1...
[  OK  ] Stopped target Encrypted Volumes.
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped Load Kernel Modules.
         Stopping Update UTMP about System Boot/Shutdown...
[  OK  ] Stopped Load/Save Random Seed.
[  OK  ] Stopped Update UTMP about System Boot/Shutdown.
[  OK  ] Stopped Create Volatile Files and Directories.
[  OK  ] Stopped Flush Journal to Persistent Storage.
[  OK  ] Stopped target Local File Systems.
         Unmounting /var/opt...
         Unmounting /boot/grub2/i386-pc...
         Unmounting /var/spool...
         Unmounting /srv...
         Unmounting /tmp...
         Unmounting /var/tmp...
         Unmounting /home...
         Unmounting /var/cache...
         Unmounting /var/lib/machines...
         Unmounting /var/lib/named...
         Unmounting /var/log...
         Unmounting /var/lib/mysql...
         Unmounting /opt...
         Unmounting /var/lib/pgsql...
         Unmounting /var/crash...
         Unmounting /usr/local...
         Unmounting /var/lib/mailman...
         Unmounting /var/lib/mariadb...
         Unmounting /var/lib/libvirt/images...
         Unmounting /boot/grub2/x86_64-efi...
[  OK  ] Deactivated swap /dev/disk/by-path/...0000:03:00.0-scsi-0:1:0:0-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/ww...1001c840178773ac64adeb5bf-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/sc...1001c840178773ac64adeb5bf-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/sc...P_LOGICAL_VOLUME_00000000-part1.
[  OK  ] Deactivated swap /dev/disk/by-id/cc...1001c840178773ac64adeb5bf-part1.
[  OK  ] Deactivated swap /dev/cciss/c0d0p1.
[  OK  ] Deactivated swap /dev/sda1.
[  OK  ] Deactivated swap /dev/disk/by-uuid/...5bf-803c-44e6-90d7-1695025b0532.
[  OK  ] Unmounted /var/opt.
[  OK  ] Unmounted /boot/grub2/i386-pc.
[  OK  ] Unmounted /var/spool.
[  OK  ] Unmounted /srv.
[  OK  ] Unmounted /tmp.
[  OK  ] Unmounted /var/tmp.
[  OK  ] Unmounted /home.
[  OK  ] Unmounted /var/cache.
[  OK  ] Unmounted /var/lib/machines.
[  OK  ] Unmounted /var/lib/named.
[  OK  ] Unmounted /var/log.
[  OK  ] Unmounted /var/lib/mysql.
[  OK  ] Unmounted /opt.
[  OK  ] Unmounted /var/lib/pgsql.
[  OK  ] Unmounted /var/crash.
[  OK  ] Unmounted /usr/local.
[  OK  ] Unmounted /var/lib/mailman.
[  OK  ] Unmounted /var/lib/mariadb.
[  OK  ] Unmounted /var/lib/libvirt/images.
[  OK  ] Unmounted /boot/grub2/x86_64-efi.
[  OK  ] Stopped target Local File Systems (Pre).
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Remount Root and Kernel File Systems.
[  OK  ] Reached target Shutdown.
[  148.309970] watchdog: watchdog0: watchdog did not stop!
[  148.337384] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[  148.379811] systemd-journald[473]: Received SIGTERM from PID 1 (systemd-shutdow).
[  148.417022] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[  148.457980] systemd-shutdown[1]: Hardware watchdog 'HPE iLO2+ HW Watchdog Timer', version 0
[  148.498186] systemd-shutdown[1]: Unmounting file systems.
[  148.523909] systemd-shutdown[1]: Remounting '/' read-only with options 'space_cache,subvolid=257,subvol=/@'.
[  148.600361] BTRFS info (device sda3): disk space caching is enabled
[  148.636752] systemd-shutdown[1]: Remounting '/' read-only with options 'space_cache,subvolid=257,subvol=/@'.
[  148.683444] BTRFS info (device sda3): disk space caching is enabled
[  148.713686] systemd-shutdown[1]: All filesystems unmounted.
[  148.739999] systemd-shutdown[1]: Deactivating swaps.
[  148.764243] systemd-shutdown[1]: All swaps deactivated.
[  148.789306] systemd-shutdown[1]: Detaching loop devices.
[  148.844068] kvm: exiting hardware virtualization
[  148.867231] tg3 0000:04:00.3: shutdown
[  148.885255] tg3 0000:04:00.2: shutdown
[  148.903382] tg3 0000:04:00.1: shutdown
[  148.921483] tg3 0000:04:00.0: shutdown
[  148.939355] ipmi_si IPI0001:00: shutdown
[  148.958187] ipmi_si dmi-ipmi-si.0: shutdown
[  148.978360] i2c i2c-1: shutdown
[  148.993543] piix4_smbus 0000:00:14.0: shutdown
[  149.014826] pcspkr pcspkr: shutdown
[  149.031415] k10temp 0000:00:19.3: shutdown
[  149.051185] k10temp 0000:00:18.3: shutdown
[  149.070987] hpwdt 0000:02:00.0: shutdown
[  149.090050] hpilo 0000:02:00.2: shutdown
[  149.108899] pci 0000:00:19.4: shutdown
[  149.126841] fam15h_power 0000:00:18.4: shutdown
[  149.148491] ohci-pci 0000:00:13.1: shutdown
[  149.168677] ohci-pci 0000:00:13.0: shutdown
[  149.188810] ohci-pci 0000:00:12.1: shutdown
[  149.208973] ohci-pci 0000:00:12.0: shutdown
[  149.229295] i2c i2c-0: shutdown
[  149.244234] mgag200 0000:02:00.1: shutdown
[  149.263813] sd 1:1:0:1: shutdown
[  149.279203] ehci-pci 0000:00:13.2: shutdown
[  149.299563] sd 1:1:0:0: shutdown
[  149.315387] uhci_hcd 0000:02:00.4: shutdown
[  149.335347] ehci-pci 0000:00:12.2: shutdown
[  149.355667] pata_atiixp 0000:00:14.1: shutdown
[  149.377198] hpsa 0000:03:00.0: shutdown
[  149.416764] serio serio1: shutdown
[  149.433024] rtc_cmos 00:04: shutdown
[  149.450277] serio serio0: shutdown
[  149.466538] i8042 i8042: shutdown
[  149.482569] i8042 aux 00:02: shutdown
[  149.500214] i8042 kbd 00:01: shutdown
[  149.517952] ahci 0000:00:11.0: shutdown
[  149.536231] serial8250 serial8250: shutdown
[  149.555979] serial 00:03: shutdown
[  149.572597] pcieport 0000:00:0c.0: shutdown
[  149.592853] pcieport 0000:00:0a.0: shutdown
[  149.612294] pcieport 0000:00:02.0: shutdown
[  149.632332] alarmtimer alarmtimer: shutdown
[  149.652196] system 00:05: shutdown
[  149.668575] system 00:00: shutdown
[  149.684848] pci 0000:00:19.5: shutdown
[  149.703072] pci 0000:00:19.2: shutdown
[  149.721136] pci 0000:00:19.1: shutdown
[  149.739077] pci 0000:00:19.0: shutdown
[  149.756990] pci 0000:00:18.5: shutdown
[  149.774840] pci 0000:00:18.2: shutdown
[  149.792532] pci 0000:00:18.1: shutdown
[  149.810146] pci 0000:00:18.0: shutdown
[  149.827684] pci 0000:00:14.4: shutdown
[  149.845261] pci 0000:00:14.3: shutdown
[  149.862868] pci 0000:00:00.2: shutdown
[  149.880869] pci 0000:00:00.0: shutdown
[  149.899524] PM: Calling mce_syscore_shutdown+0x0/0x10
[  149.923866] PM: Calling ledtrig_cpu_syscore_shutdown+0x0/0x10
[  149.951477] PM: Calling irq_gc_shutdown+0x0/0x60
[  149.973765] PM: Calling i8259A_shutdown+0x0/0x10
[  149.995677] PM: Calling cpufreq_suspend+0x0/0x130
[  150.145608] reboot: Restarting system
[  150.163278] reboot: machine restart



--------------CB3DD83CD84F3B426A9A2787--
