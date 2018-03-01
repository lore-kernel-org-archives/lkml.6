Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966436AbeCAHKU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:10:20 -0500
Received: from helium.openadk.org ([89.238.66.15]:46506 "EHLO
        helium.openadk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966327AbeCAHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:10:15 -0500
Date: Thu, 1 Mar 2018 08:10:12 +0100
From: Waldemar Brodkorb <wbx@openadk.org>
To: linux-kernel@vger.kernel.org
Subject: Re: xhci: Not enough bandwidth for new device state
Message-ID: <20180301071012.GZ12535@waldemar-brodkorb.de>
References: <20180228205444.GX12535@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20180228205444.GX12535@waldemar-brodkorb.de>
X-Operating-System: Linux 3.16.0-5-amd64 x86_64
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,
Waldemar Brodkorb wrote,

> Hi,
> 
> I am getting these messages from a Debian 9.3 system using
> Linux 4.9.x:
> [  547.352746] usb 3-5.2: 3:1: usb_set_interface failed (-28)
> [  548.352865] usb 3-5.3: Not enough bandwidth for new device state.
> [  548.352868] usb 3-5.3: Not enough bandwidth for altsetting 1
> 
> I have connected a 7-Port USB 3.0 Hub to my machine.
> I have 6 different Headsets and USB Soundcards connected to the HUB.
> 
> As soon as I start a C++ application which opens all ALSA devices
> I get these errors and the USB stopps working correctly.
> 
> I think the maximum count of USB sound devices, which behave stable
> is three or four. 
> 
> Is this some miscalculation of the Linux kernel regarding the USB
> bandwidth usage? How I can determine how much bandwidth the USB
> sound card driver preallocates?
> 
> Or are five USB soundcards really too much for an USB 3.0 bus?

Adding some more information, which where missing in my first mail.

Attached are dmesg from the machine, lsusb verbose output and
aplay -l information.

There is no webcam involved, which usually uses MaxPacketsize of
1024,
so why I get the overallocation?

thanks, best regards
 Waldemar


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg.txt"

[    0.000000] Linux version 4.9.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1) ) #1 SMP Debian 4.9.82-1+deb9u2 (2018-02-21)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.9.0-6-amd64 root=UUID=a09280ec-cb90-48f1-916e-2164e10a22e6 ro quiet
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000004efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000004f000-0x000000000004ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000050000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ca09ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca0a0000-0x00000000ca0a6fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ca0a7000-0x00000000ca4dafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca4db000-0x00000000ca7fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca7fb000-0x00000000cb488fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cb489000-0x00000000cb50cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cb50d000-0x00000000cb524fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cb525000-0x00000000cb541fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cb542000-0x00000000cb542fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cb543000-0x00000000cb578fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cb579000-0x00000000cb5f9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cb5fa000-0x00000000cb62cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cb62d000-0x00000000cb639fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cb63a000-0x00000000cbe68fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cbe69000-0x00000000cbea8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbea9000-0x00000000cbef4fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cbef5000-0x00000000cbf24fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbf25000-0x00000000cbf2cfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cbf2d000-0x00000000cbf38fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cbf39000-0x00000000cbf40fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cbf41000-0x00000000cbf4efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbf4f000-0x00000000cbf5ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cbf60000-0x00000000cbf67fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000cbf68000-0x00000000cbf69fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbf6a000-0x00000000cbf6cfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000cbf6d000-0x00000000cbf79fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbf7a000-0x00000000cbf8dfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000cbf8e000-0x00000000cbf94fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cbf95000-0x00000000cbf96fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbf97000-0x00000000cbfa1fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000cbfa2000-0x00000000cbfa9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbfaa000-0x00000000cbfb0fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000cbfb1000-0x00000000cbfb4fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbfb5000-0x00000000cbfe4fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000cbfe5000-0x00000000cbffcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cbffd000-0x00000000cbffefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbfff000-0x00000000cbffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd000000-0x00000000cf1fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022fdfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0xcb50d000  ACPI 2.0=0xcb50d000  SMBIOS=0xcbffd498  MPS=0xf4e40 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Hewlett-Packard HP ProDesk 400 G1 MT/198E, BIOS L02 v02.15 04/17/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x22fe00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7E00000000 write-back
[    0.000000]   1 base 0200000000 mask 7FE0000000 write-back
[    0.000000]   2 base 0220000000 mask 7FF0000000 write-back
[    0.000000]   3 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   4 base 00D0000000 mask 7FF0000000 uncachable
[    0.000000]   5 base 00CE000000 mask 7FFE000000 uncachable
[    0.000000]   6 base 00CD000000 mask 7FFF000000 uncachable
[    0.000000]   7 base 022FE00000 mask 7FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xcd000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcc000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4e30-0x000f4e3f] mapped at [ffff96fc000f4e30]
[    0.000000] Base memory trampoline at [ffff96fc00097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x1f0939000, 0x1f0939fff] PGTABLE
[    0.000000] BRK [0x1f093a000, 0x1f093afff] PGTABLE
[    0.000000] BRK [0x1f093b000, 0x1f093bfff] PGTABLE
[    0.000000] BRK [0x1f093c000, 0x1f093cfff] PGTABLE
[    0.000000] BRK [0x1f093d000, 0x1f093dfff] PGTABLE
[    0.000000] BRK [0x1f093e000, 0x1f093efff] PGTABLE
[    0.000000] BRK [0x1f093f000, 0x1f093ffff] PGTABLE
[    0.000000] BRK [0x1f0940000, 0x1f0940fff] PGTABLE
[    0.000000] BRK [0x1f0941000, 0x1f0941fff] PGTABLE
[    0.000000] BRK [0x1f0942000, 0x1f0942fff] PGTABLE
[    0.000000] BRK [0x1f0943000, 0x1f0943fff] PGTABLE
[    0.000000] BRK [0x1f0944000, 0x1f0944fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35841000-0x36c17fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000CB50D000 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000CB50D088 000094 (v01 HPQOEM SLIC-BPC 20140417 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CB519830 00010C (v05 HPQOEM SLIC-BPC 20140417 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CB50D1B0 00C67D (v02 HPQOEM SLIC-BPC 00000001 INTL 20091112)
[    0.000000] ACPI: FACS 0x00000000CBF93080 000040
[    0.000000] ACPI: APIC 0x00000000CB519940 000072 (v03 HPQOEM SLIC-BPC 20140417 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CB5199B8 000044 (v01 HPQOEM SLIC-BPC 20140417 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000CB519A00 000539 (v01 PmRef  Cpu0Ist  00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000CB519F40 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000CB51AA18 0001C7 (v01 PmRef  LakeTiny 00003000 INTL 20120711)
[    0.000000] ACPI: MCFG 0x00000000CB51ABE0 00003C (v01 HPQOEM SLIC-BPC 20140417 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CB51AC20 000038 (v01 HPQOEM SLIC-BPC 20140417 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000CB51AC58 00036D (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 0x00000000CB51AFC8 0033D8 (v01 SaSsdt SaSsdt   00003000 INTL 20091112)
[    0.000000] ACPI: SSDT 0x00000000CB51E3A0 00668F (v01 COMPAQ WMI      00000001 MSFT 03000001)
[    0.000000] ACPI: SLIC 0x00000000CB524A30 000176 (v01 HPQOEM SLIC-BPC 00000001      00000000)
[    0.000000] ACPI: MSDM 0x00000000CB524BA8 000055 (v03 HPQOEM SLIC-BPC 20140417 HPQ  00010013)
[    0.000000] ACPI: DMAR 0x00000000CB524C00 0000B8 (v01 INTEL  HSW      00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000022fdfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x22fdfb000-0x22fdfffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000022fdfffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000004efff]
[    0.000000]   node   0: [mem 0x0000000000050000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000ca09ffff]
[    0.000000]   node   0: [mem 0x00000000ca0a7000-0x00000000ca4dafff]
[    0.000000]   node   0: [mem 0x00000000ca7fb000-0x00000000cb488fff]
[    0.000000]   node   0: [mem 0x00000000cb525000-0x00000000cb541fff]
[    0.000000]   node   0: [mem 0x00000000cb543000-0x00000000cb578fff]
[    0.000000]   node   0: [mem 0x00000000cb5fa000-0x00000000cb62cfff]
[    0.000000]   node   0: [mem 0x00000000cb63a000-0x00000000cbe68fff]
[    0.000000]   node   0: [mem 0x00000000cbea9000-0x00000000cbef4fff]
[    0.000000]   node   0: [mem 0x00000000cbf2d000-0x00000000cbf38fff]
[    0.000000]   node   0: [mem 0x00000000cbfe5000-0x00000000cbffcfff]
[    0.000000]   node   0: [mem 0x00000000cbfff000-0x00000000cbffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000022fdfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000022fdfffff]
[    0.000000] On node 0 totalpages: 2078756
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 41 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12971 pages used for memmap
[    0.000000]   DMA32 zone: 830088 pages, LIFO batch:31
[    0.000000]   Normal zone: 19448 pages used for memmap
[    0.000000]   Normal zone: 1244672 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0004f000-0x0004ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xca0a0000-0xca0a6fff]
[    0.000000] PM: Registered nosave memory: [mem 0xca4db000-0xca7fafff]
[    0.000000] PM: Registered nosave memory: [mem 0xcb489000-0xcb50cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcb50d000-0xcb524fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcb542000-0xcb542fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcb579000-0xcb5f9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcb62d000-0xcb639fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbe69000-0xcbea8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbef5000-0xcbf24fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf25000-0xcbf2cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf39000-0xcbf40fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf41000-0xcbf4efff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf4f000-0xcbf5ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf60000-0xcbf67fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf68000-0xcbf69fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf6a000-0xcbf6cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf6d000-0xcbf79fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf7a000-0xcbf8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf8e000-0xcbf94fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf95000-0xcbf96fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf97000-0xcbfa1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbfa2000-0xcbfa9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbfaa000-0xcbfb0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbfb1000-0xcbfb4fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbfb5000-0xcbfe4fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbffd000-0xcbffefff]
[    0.000000] PM: Registered nosave memory: [mem 0xcc000000-0xccffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd000000-0xcf1fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf200000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xcf200000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 35 pages/cpu @ffff96fe2fa00000 s105240 r8192 d29928 u524288
[    0.000000] pcpu-alloc: s105240 r8192 d29928 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2046232
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.9.0-6-amd64 root=UUID=a09280ec-cb90-48f1-916e-2164e10a22e6 ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 7868660K/8315024K available (6236K kernel code, 1159K rwdata, 2868K rodata, 1416K init, 688K bss, 446364K reserved, 0K cma-reserved)
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:33024 nr_irqs:456 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3192.692 MHz processor
[    0.000018] Calibrating delay loop (skipped), value calculated using timer frequency.. 6385.38 BogoMIPS (lpj=12770768)
[    0.000019] pid_max: default: 32768 minimum: 301
[    0.000030] ACPI: Core revision 20160831
[    0.008548] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.008852] Security Framework initialized
[    0.008853] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.008857] AppArmor: AppArmor disabled by boot time parameter
[    0.009147] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.010270] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.010784] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010789] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010987] CPU: Physical Processor ID: 0
[    0.010988] CPU: Processor Core ID: 0
[    0.010991] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.010992] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.010995] mce: CPU supports 9 MCE banks
[    0.011002] CPU0: Thermal monitoring enabled (TM1)
[    0.011013] process: using mwait in idle threads
[    0.011015] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.011016] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.011017] Spectre V2 : Mitigation: Full generic retpoline
[    0.011745] Freeing SMP alternatives memory: 24K
[    0.017000] ftrace: allocating 25236 entries in 99 pages
[    0.033163] smpboot: Max logical packages: 1
[    0.033166] DMAR: Host address width 39
[    0.033167] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.033175] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.033175] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.033178] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.033179] DMAR: RMRR base: 0x000000cb62d000 end: 0x000000cb639fff
[    0.033180] DMAR: RMRR base: 0x000000cd000000 end: 0x000000cf1fffff
[    0.033181] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.033182] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.033183] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.033404] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.033405] x2apic enabled
[    0.033409] Switched APIC routing to cluster x2apic.
[    0.033827] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.073515] TSC deadline timer enabled
[    0.073518] smpboot: CPU0: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    0.073520] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.073539] ... version:                3
[    0.073539] ... bit width:              48
[    0.073540] ... generic registers:      8
[    0.073540] ... value mask:             0000ffffffffffff
[    0.073541] ... max period:             00007fffffffffff
[    0.073541] ... fixed-purpose events:   3
[    0.073541] ... event mask:             00000007000000ff
[    0.073960] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.074038] x86: Booting SMP configuration:
[    0.074039] .... node  #0, CPUs:      #1 #2 #3
[    0.081154] x86: Booted up 1 node, 4 CPUs
[    0.081156] smpboot: Total of 4 processors activated (25541.53 BogoMIPS)
[    0.083786] devtmpfs: initialized
[    0.083835] x86/mm: Memory block size: 128MB
[    0.086145] PM: Registering ACPI NVS region [mem 0xca0a0000-0xca0a6fff] (28672 bytes)
[    0.086146] PM: Registering ACPI NVS region [mem 0xcb489000-0xcb50cfff] (540672 bytes)
[    0.086157] PM: Registering ACPI NVS region [mem 0xcbf39000-0xcbf40fff] (32768 bytes)
[    0.086158] PM: Registering ACPI NVS region [mem 0xcbf4f000-0xcbf5ffff] (69632 bytes)
[    0.086160] PM: Registering ACPI NVS region [mem 0xcbf8e000-0xcbf94fff] (28672 bytes)
[    0.086197] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.086204] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.086233] pinctrl core: initialized pinctrl subsystem
[    0.086314] NET: Registered protocol family 16
[    0.099573] cpuidle: using governor ladder
[    0.119586] cpuidle: using governor menu
[    0.119601] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.119602] ACPI: bus type PCI registered
[    0.119603] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.119650] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.119652] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.119658] pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
[    0.119702] PCI: Using configuration type 1 for base access
[    0.119770] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
[    0.119804] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.132502] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.132503] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.132648] ACPI: Added _OSI(Module Device)
[    0.132648] ACPI: Added _OSI(Processor Device)
[    0.132649] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.132649] ACPI: Added _OSI(Processor Aggregator Device)
[    0.132806] ACPI: Executed 1 blocks of module-level executable AML code
[    0.136804] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.137474] ACPI: Dynamic OEM Table Load:
[    0.137478] ACPI: SSDT 0xFFFF96FE2595B400 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
[    0.137820] ACPI: Dynamic OEM Table Load:
[    0.137824] ACPI: SSDT 0xFFFF96FE262EE000 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
[    0.138187] ACPI: Dynamic OEM Table Load:
[    0.138190] ACPI: SSDT 0xFFFF96FE25F3D800 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
[    0.139005] ACPI: Interpreter enabled
[    0.139029] ACPI: (supports S0 S3 S4 S5)
[    0.139030] ACPI: Using IOAPIC for interrupt routing
[    0.139051] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.147118] ACPI: Power Resource [FN00] (off)
[    0.147189] ACPI: Power Resource [FN01] (off)
[    0.147923] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.147927] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.148098] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    0.148211] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.148212] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.148570] PCI host bridge to bus 0000:00
[    0.148572] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.148573] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.148574] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.148575] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.148576] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.148577] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.148578] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.148579] pci_bus 0000:00: root bus resource [mem 0xcf200000-0xfeafffff window]
[    0.148581] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.148587] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
[    0.148661] pci 0000:00:01.0: [8086:0c01] type 01 class 0x060400
[    0.148688] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.148763] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.148796] pci 0000:00:02.0: [8086:0412] type 00 class 0x038000
[    0.148803] pci 0000:00:02.0: reg 0x10: [mem 0xf7400000-0xf77fffff 64bit]
[    0.148808] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.148811] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.148897] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
[    0.148913] pci 0000:00:14.0: reg 0x10: [mem 0xf7900000-0xf790ffff 64bit]
[    0.148966] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.149002] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.149034] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
[    0.149050] pci 0000:00:16.0: reg 0x10: [mem 0xf791a000-0xf791a00f 64bit]
[    0.149107] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.149177] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
[    0.149193] pci 0000:00:1a.0: reg 0x10: [mem 0xf7918000-0xf79183ff]
[    0.149268] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.149314] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.149347] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
[    0.149360] pci 0000:00:1b.0: reg 0x10: [mem 0xf7910000-0xf7913fff 64bit]
[    0.149413] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.149451] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.149484] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    0.149543] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.149610] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.149642] pci 0000:00:1c.2: [8086:8c14] type 01 class 0x060400
[    0.149700] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.149916] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.149953] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
[    0.149969] pci 0000:00:1d.0: reg 0x10: [mem 0xf7917000-0xf79173ff]
[    0.150045] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.150090] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.150123] pci 0000:00:1f.0: [8086:8c5c] type 00 class 0x060100
[    0.150270] pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
[    0.150283] pci 0000:00:1f.2: reg 0x10: [io  0xf0b0-0xf0b7]
[    0.150290] pci 0000:00:1f.2: reg 0x14: [io  0xf0a0-0xf0a3]
[    0.150296] pci 0000:00:1f.2: reg 0x18: [io  0xf090-0xf097]
[    0.150303] pci 0000:00:1f.2: reg 0x1c: [io  0xf080-0xf083]
[    0.150309] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.150315] pci 0000:00:1f.2: reg 0x24: [mem 0xf7916000-0xf79167ff]
[    0.150346] pci 0000:00:1f.2: PME# supported from D3hot
[    0.150406] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
[    0.150419] pci 0000:00:1f.3: reg 0x10: [mem 0xf7915000-0xf79150ff 64bit]
[    0.150437] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.150547] pci 0000:01:00.0: [10de:104a] type 00 class 0x030000
[    0.150559] pci 0000:01:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
[    0.150570] pci 0000:01:00.0: reg 0x14: [mem 0xe0000000-0xe7ffffff 64bit pref]
[    0.150582] pci 0000:01:00.0: reg 0x1c: [mem 0xe8000000-0xe9ffffff 64bit pref]
[    0.150589] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.150597] pci 0000:01:00.0: reg 0x30: [mem 0xf7000000-0xf707ffff pref]
[    0.150661] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.150695] pci 0000:01:00.1: [10de:0e08] type 00 class 0x040300
[    0.150706] pci 0000:01:00.1: reg 0x10: [mem 0xf7080000-0xf7083fff]
[    0.160454] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.160455] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.160457] pci 0000:00:01.0:   bridge window [mem 0xf6000000-0xf70fffff]
[    0.160459] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe9ffffff 64bit pref]
[    0.160513] acpiphp: Slot [1] registered
[    0.160518] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.160583] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.160602] pci 0000:03:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.160628] pci 0000:03:00.0: reg 0x18: [mem 0xf7800000-0xf7800fff 64bit]
[    0.160645] pci 0000:03:00.0: reg 0x20: [mem 0xea100000-0xea103fff 64bit pref]
[    0.160733] pci 0000:03:00.0: supports D1 D2
[    0.160734] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.160776] pci 0000:03:00.0: System wakeup disabled by ACPI
[    0.172465] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.172468] pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
[    0.172471] pci 0000:00:1c.2:   bridge window [mem 0xf7800000-0xf78fffff]
[    0.172475] pci 0000:00:1c.2:   bridge window [mem 0xea100000-0xea1fffff 64bit pref]
[    0.174976] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.175015] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.175052] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.175089] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.175125] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.175162] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.175199] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.175238] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.175431] ACPI: Enabled 4 GPEs in block 00 to 3F
[    0.175499] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.175500] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.175501] vgaarb: loaded
[    0.175501] vgaarb: bridge control possible 0000:01:00.0
[    0.175526] Registered efivars operations
[    0.184559] PCI: Using ACPI for IRQ routing
[    0.185798] PCI: pci_cache_line_size set to 64 bytes
[    0.185833] e820: reserve RAM buffer [mem 0x0004f000-0x0004ffff]
[    0.185833] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.185834] e820: reserve RAM buffer [mem 0xca0a0000-0xcbffffff]
[    0.185837] e820: reserve RAM buffer [mem 0xca4db000-0xcbffffff]
[    0.185840] e820: reserve RAM buffer [mem 0xcb489000-0xcbffffff]
[    0.185843] e820: reserve RAM buffer [mem 0xcb542000-0xcbffffff]
[    0.185846] e820: reserve RAM buffer [mem 0xcb579000-0xcbffffff]
[    0.185849] e820: reserve RAM buffer [mem 0xcb62d000-0xcbffffff]
[    0.185851] e820: reserve RAM buffer [mem 0xcbe69000-0xcbffffff]
[    0.185854] e820: reserve RAM buffer [mem 0xcbef5000-0xcbffffff]
[    0.185856] e820: reserve RAM buffer [mem 0xcbf39000-0xcbffffff]
[    0.185858] e820: reserve RAM buffer [mem 0xcbffd000-0xcbffffff]
[    0.185859] e820: reserve RAM buffer [mem 0x22fe00000-0x22fffffff]
[    0.185963] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.185968] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.187983] clocksource: Switched to clocksource hpet
[    0.192521] VFS: Disk quotas dquot_6.6.0
[    0.192540] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.192604] pnp: PnP ACPI init
[    0.192681] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.192684] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.192753] pnp 00:01: can't evaluate _CRS: 12311
[    0.192775] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.192794] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.192829] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.192831] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.192930] system 00:04: [io  0x0a20-0x0a3f] has been reserved
[    0.192931] system 00:04: [io  0x0a10-0x0a1f] has been reserved
[    0.192932] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.192959] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.192992] pnp 00:06: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.193028] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    0.193029] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.193159] pnp 00:08: [dma 0 disabled]
[    0.193228] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.193673] system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.193675] system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.193676] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.193677] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.193678] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.193679] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.193681] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.193682] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.193683] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.193685] system 00:09: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.193686] system 00:09: [mem 0xf7fdf000-0xf7fdffff] has been reserved
[    0.193687] system 00:09: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.193689] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.193873] pnp: PnP ACPI: found 10 devices
[    0.199693] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.199707] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.199709] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.199710] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02] add_size 200000 add_align 100000
[    0.199719] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.199720] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.199721] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.199722] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.199724] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.199725] pci 0000:00:1c.0: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.199729] pci 0000:00:1c.0: BAR 14: assigned [mem 0xcf200000-0xcf3fffff]
[    0.199734] pci 0000:00:1c.0: BAR 15: assigned [mem 0xcf400000-0xcf5fffff 64bit pref]
[    0.199735] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.199737] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.199738] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.199741] pci 0000:00:01.0:   bridge window [mem 0xf6000000-0xf70fffff]
[    0.199743] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe9ffffff 64bit pref]
[    0.199745] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.199748] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.199751] pci 0000:00:1c.0:   bridge window [mem 0xcf200000-0xcf3fffff]
[    0.199754] pci 0000:00:1c.0:   bridge window [mem 0xcf400000-0xcf5fffff 64bit pref]
[    0.199759] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.199762] pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
[    0.199766] pci 0000:00:1c.2:   bridge window [mem 0xf7800000-0xf78fffff]
[    0.199769] pci 0000:00:1c.2:   bridge window [mem 0xea100000-0xea1fffff 64bit pref]
[    0.199774] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.199775] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.199776] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.199777] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff window]
[    0.199778] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff window]
[    0.199779] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff window]
[    0.199780] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff window]
[    0.199781] pci_bus 0000:00: resource 11 [mem 0xcf200000-0xfeafffff window]
[    0.199782] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.199783] pci_bus 0000:01: resource 1 [mem 0xf6000000-0xf70fffff]
[    0.199784] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xe9ffffff 64bit pref]
[    0.199785] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    0.199786] pci_bus 0000:02: resource 1 [mem 0xcf200000-0xcf3fffff]
[    0.199787] pci_bus 0000:02: resource 2 [mem 0xcf400000-0xcf5fffff 64bit pref]
[    0.199788] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.199789] pci_bus 0000:03: resource 1 [mem 0xf7800000-0xf78fffff]
[    0.199790] pci_bus 0000:03: resource 2 [mem 0xea100000-0xea1fffff 64bit pref]
[    0.199881] NET: Registered protocol family 2
[    0.200007] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.200089] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.200196] TCP: Hash tables configured (established 65536 bind 65536)
[    0.200210] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.200228] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.200269] NET: Registered protocol family 1
[    0.244071] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.244082] PCI: CLS 64 bytes, default 64
[    0.244112] Unpacking initramfs...
[    0.495833] Freeing initrd memory: 20316K
[    0.495911] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.495913] software IO TLB [mem 0xb5808000-0xb9808000] (64MB) mapped at [ffff96fcb5808000-ffff96fcb9807fff]
[    0.496188] audit: initializing netlink subsys (disabled)
[    0.496201] audit: type=2000 audit(1519886255.496:1): initialized
[    0.496486] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    0.496516] zbud: loaded
[    0.497102] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.497123] io scheduler noop registered
[    0.497124] io scheduler deadline registered
[    0.497132] io scheduler cfq registered (default)
[    0.497459] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.497462] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.497469] efifb: probing for efifb
[    0.497477] efifb: framebuffer at 0xe9000000, using 1920k, total 1920k
[    0.497478] efifb: mode is 800x600x32, linelength=3200, pages=1
[    0.497478] efifb: scrolling: redraw
[    0.497480] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.498896] Console: switching to colour frame buffer device 100x37
[    0.500236] fb0: EFI VGA frame buffer device
[    0.500240] intel_idle: MWAIT substates: 0x42120
[    0.500241] intel_idle: v0.4.1 model 0x3C
[    0.500351] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.500444] GHES: HEST is not enabled!
[    0.500479] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.520911] 00:08: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.521244] Linux agpgart interface v0.103
[    0.521292] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.521293] AMD IOMMUv2 functionality not available on this system
[    0.521548] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    0.524339] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.524342] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.524463] mousedev: PS/2 mouse device common for all mice
[    0.524491] rtc_cmos 00:02: RTC can wake from S4
[    0.524614] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.524638] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.524645] intel_pstate: Intel P-state driver initializing
[    0.524928] ledtrig-cpu: registered to indicate activity on CPUs
[    0.526140] NET: Registered protocol family 10
[    0.526654] mip6: Mobile IPv6
[    0.526657] NET: Registered protocol family 17
[    0.526662] mpls_gso: MPLS GSO support
[    0.527136] microcode: sig=0x306c3, pf=0x2, revision=0x17
[    0.527307] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.527635] registered taskstats version 1
[    0.527673] zswap: loaded using pool lzo/zbud
[    0.527971] ima: No TPM chip found, activating TPM-bypass!
[    0.528938] rtc_cmos 00:02: setting system clock to 2018-03-01 06:37:36 UTC (1519886256)
[    0.529297] PM: Hibernation image not present or could not be loaded.
[    0.532269] Freeing unused kernel memory: 1416K
[    0.532271] Write protecting the kernel read-only data: 12288k
[    0.533421] Freeing unused kernel memory: 1940K
[    0.541076] Freeing unused kernel memory: 1228K
[    0.552996] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.618224] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    0.618274] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    0.618280] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    0.618287] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    0.618835] random: udevadm: uninitialized urandom read (16 bytes read)
[    0.618856] random: udevadm: uninitialized urandom read (16 bytes read)
[    0.619401] random: udevadm: uninitialized urandom read (16 bytes read)
[    0.619436] random: udevadm: uninitialized urandom read (16 bytes read)
[    0.619618] random: udevadm: uninitialized urandom read (16 bytes read)
[    0.619661] random: udevadm: uninitialized urandom read (16 bytes read)
[    0.637642] ACPI: Invalid active2 threshold
[    0.637757] thermal LNXTHERM:00: registered as thermal_zone0
[    0.637757] ACPI: Thermal Zone [TZ00] (28 C)
[    0.637909] thermal LNXTHERM:01: registered as thermal_zone1
[    0.637909] ACPI: Thermal Zone [TZ01] (30 C)
[    0.639040] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.639045] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.639299] ACPI: bus type USB registered
[    0.639314] usbcore: registered new interface driver usbfs
[    0.639320] usbcore: registered new interface driver hub
[    0.639335] usbcore: registered new device driver usb
[    0.639811] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.639874] SCSI subsystem initialized
[    0.639982] ehci-pci: EHCI PCI platform driver
[    0.640065] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.640068] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.640078] ehci-pci 0000:00:1a.0: debug port 2
[    0.641040] libata version 3.00 loaded.
[    0.643993] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    0.644010] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7918000
[    0.645228] AVX2 version of gcm_enc/dec engaged.
[    0.645228] AES CTR mode by8 optimization enabled
[    0.648911] r8169 0000:03:00.0 eth0: RTL8168g/8111g at 0xffffae2d40c81000, a0:d3:c1:48:92:c0, XID 0c000800 IRQ 27
[    0.648912] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    0.660022] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.660189] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.660191] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.660192] usb usb1: Product: EHCI Host Controller
[    0.660193] usb usb1: Manufacturer: Linux 4.9.0-6-amd64 ehci_hcd
[    0.660194] usb usb1: SerialNumber: 0000:00:1a.0
[    0.660399] hub 1-0:1.0: USB hub found
[    0.660422] hub 1-0:1.0: 2 ports detected
[    0.660701] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.660705] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.660715] ehci-pci 0000:00:1d.0: debug port 2
[    0.664621] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    0.664730] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7917000
[    0.680045] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.680096] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.680098] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.680099] usb usb2: Product: EHCI Host Controller
[    0.680099] usb usb2: Manufacturer: Linux 4.9.0-6-amd64 ehci_hcd
[    0.680100] usb usb2: SerialNumber: 0000:00:1d.0
[    0.680291] hub 2-0:1.0: USB hub found
[    0.680296] hub 2-0:1.0: 2 ports detected
[    0.680525] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.680529] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    0.681601] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    0.681605] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.681959] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    0.681970] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.681970] usb usb3: Product: xHCI Host Controller
[    0.681971] usb usb3: Manufacturer: Linux 4.9.0-6-amd64 xhci-hcd
[    0.681972] usb usb3: SerialNumber: 0000:00:14.0
[    0.682158] hub 3-0:1.0: USB hub found
[    0.682192] hub 3-0:1.0: 10 ports detected
[    0.683023] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.683026] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    0.683156] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    0.683158] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.683159] usb usb4: Product: xHCI Host Controller
[    0.683160] usb usb4: Manufacturer: Linux 4.9.0-6-amd64 xhci-hcd
[    0.683160] usb usb4: SerialNumber: 0000:00:14.0
[    0.683276] hub 4-0:1.0: USB hub found
[    0.683284] hub 4-0:1.0: 2 ports detected
[    0.683536] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    0.683556] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    0.684300] ahci 0000:00:1f.2: version 3.0
[    0.684439] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x23 impl SATA mode
[    0.684441] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems 
[    0.708625] scsi host0: ahci
[    0.708751] scsi host1: ahci
[    0.708872] scsi host2: ahci
[    0.709010] scsi host3: ahci
[    0.709102] scsi host4: ahci
[    0.709164] scsi host5: ahci
[    0.709195] ata1: SATA max UDMA/133 abar m2048@0xf7916000 port 0xf7916100 irq 29
[    0.709197] ata2: SATA max UDMA/133 abar m2048@0xf7916000 port 0xf7916180 irq 29
[    0.709198] ata3: DUMMY
[    0.709198] ata4: DUMMY
[    0.709199] ata5: DUMMY
[    0.709201] ata6: SATA max UDMA/133 abar m2048@0xf7916000 port 0xf7916380 irq 29
[    0.988074] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.008041] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.008042] usb 3-1: new low-speed USB device number 2 using xhci_hcd
[    1.023980] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.023997] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.024013] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.025130] ata2.00: ATA-8: ST500DM002-1BD142, HP74, max UDMA/100
[    1.025132] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.025662] ata1.00: supports DRM functions and may not be fully accessible
[    1.026157] ata1.00: NCQ Send/Recv Log not supported
[    1.026158] ata1.00: ATA-9: Samsung SSD 850 EVO 250GB, EMT01B6Q, max UDMA/133
[    1.026160] ata1.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.026476] ata2.00: configured for UDMA/100
[    1.026819] ata1.00: supports DRM functions and may not be fully accessible
[    1.027337] ata1.00: NCQ Send/Recv Log not supported
[    1.027627] ata1.00: configured for UDMA/133
[    1.027909] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  1B6Q PQ: 0 ANSI: 5
[    1.029691] ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    1.029694] ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    1.029695] ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    1.032048] ata6.00: ATAPI: hp       CDDVDW SH-216DB, HH10, max UDMA/100
[    1.035683] ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    1.035686] ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    1.035687] ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    1.040732] ata6.00: configured for UDMA/100
[    1.068433] scsi 1:0:0:0: Direct-Access     ATA      ST500DM002-1BD14 HP74 PQ: 0 ANSI: 5
[    1.103315] scsi 5:0:0:0: CD-ROM            hp       CDDVDW SH-216DB  HH10 PQ: 0 ANSI: 5
[    1.115104] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    1.115105] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    1.115107] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    1.115203] sd 0:0:0:0: [sda] Write Protect is off
[    1.115204] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.115210] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.115339] sd 1:0:0:0: [sdb] Write Protect is off
[    1.115341] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.115347] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.118060]  sda: sda1 sda2 sda3
[    1.118371] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.129050] sr 5:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.129051] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.129159] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    1.133008]  sdb: sdb1
[    1.133267] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.140341] usb 1-1: New USB device found, idVendor=8087, idProduct=8008
[    1.140343] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.140579] hub 1-1:1.0: USB hub found
[    1.140659] hub 1-1:1.0: 4 ports detected
[    1.151423] usb 3-1: New USB device found, idVendor=093a, idProduct=2510
[    1.151424] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.151425] usb 3-1: Product: USB Optical Mouse
[    1.151426] usb 3-1: Manufacturer: PixArt
[    1.152715] hidraw: raw HID events driver (C) Jiri Kosina
[    1.154293] usbcore: registered new interface driver usbhid
[    1.154293] usbhid: USB HID core driver
[    1.154730] input: PixArt USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:093A:2510.0001/input/input3
[    1.154792] hid-generic 0003:093A:2510.0001: input,hidraw0: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:14.0-1/input0
[    1.160325] usb 2-1: New USB device found, idVendor=8087, idProduct=8000
[    1.160337] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.160578] hub 2-1:1.0: USB hub found
[    1.160658] hub 2-1:1.0: 6 ports detected
[    1.202171] random: fast init done
[    1.309366] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
[    1.316684] r8169 0000:03:00.0: firmware: failed to load rtl_nic/rtl8168g-2.fw (-2)
[    1.316719] r8169 0000:03:00.0: Direct firmware load for rtl_nic/rtl8168g-2.fw failed with error -2
[    1.316721] r8169 0000:03:00.0 eth0: unable to load firmware patch rtl_nic/rtl8168g-2.fw (-2)
[    1.325944] PM: Starting manual resume from disk
[    1.325946] PM: Hibernation image partition 8:3 present
[    1.325947] PM: Looking for hibernation image.
[    1.326109] PM: Image not found (code -22)
[    1.326110] PM: Hibernation image not present or could not be loaded.
[    1.334520] r8169 0000:03:00.0 eth0: link down
[    1.334570] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    1.334607] r8169 0000:03:00.0 eth0: link down
[    1.412896] usb 4-1: New USB device found, idVendor=2109, idProduct=0813
[    1.412897] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.412898] usb 4-1: Product: USB3.0 Hub
[    1.412899] usb 4-1: Manufacturer: VIA Labs, Inc.
[    1.414833] hub 4-1:1.0: USB hub found
[    1.415040] hub 4-1:1.0: 4 ports detected
[    1.416478] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    1.499999] tsc: Refined TSC clocksource calibration: 3192.608 MHz
[    1.500004] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0502f3f6b, max_idle_ns: 440795217409 ns
[    1.512996] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.527993] usb 3-2: new low-speed USB device number 3 using xhci_hcd
[    1.539047] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    1.539149] systemd[1]: Detected architecture x86-64.
[    1.539896] systemd[1]: Set hostname to <wbrodkorb-ws>.
[    1.627688] systemd[1]: Configuration file /etc/systemd/system/postfix.service.d/override.conf is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[    1.631099] systemd[1]: strongswan.service: Cannot add dependency job, ignoring: Unit strongswan.service is masked.
[    1.631112] systemd[1]: collectd.service: Cannot add dependency job, ignoring: Unit collectd.service is masked.
[    1.631116] systemd[1]: clamav-freshclam.service: Cannot add dependency job, ignoring: Unit clamav-freshclam.service is masked.
[    1.631118] systemd[1]: xrdp-sesman.service: Cannot add dependency job, ignoring: Unit xrdp-sesman.service is masked.
[    1.631120] systemd[1]: apache2.service: Cannot add dependency job, ignoring: Unit apache2.service is masked.
[    1.631124] systemd[1]: xrdp.service: Cannot add dependency job, ignoring: Unit xrdp.service is masked.
[    1.646804] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[    1.654146] RPC: Registered named UNIX socket transport module.
[    1.654147] RPC: Registered udp transport module.
[    1.654148] RPC: Registered tcp transport module.
[    1.654148] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.677989] usb 3-2: New USB device found, idVendor=046a, idProduct=0011
[    1.677990] usb 3-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.688471] input: HID 046a:0011 as /devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.0/0003:046A:0011.0002/input/input4
[    1.709176] systemd-journald[268]: Received request to flush runtime journal from PID 1
[    1.714364] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input5
[    1.714569] ACPI: Video Device [PEG0] (multi-head: yes  rom: no  post: no)
[    1.714912] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
[    1.748037] ACPI: Power Button [PWRB]
[    1.748091] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.748093] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input7
[    1.748094] ACPI: Power Button [PWRF]
[    1.748167] hid-generic 0003:046A:0011.0002: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0011] on usb-0000:00:14.0-2/input0
[    1.749453] acpi device:54: registered as cooling_device6
[    1.749496] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/LNXVIDEO:01/input/input8
[    1.749516] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    1.749593] wmi: Mapper loaded
[    1.772588] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.778276] [drm] Initialized
[    1.785420] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.785449] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.785472] sr 5:0:0:0: Attached scsi generic sg2 type 5
[    1.816397] Adding 2500768k swap on /dev/sda3.  Priority:-1 extents:1 across:2500768k SSFS
[    1.836319] EFI Variables Facility v0.08 2004-May-17
[    1.844262] input: PC Speaker as /devices/platform/pcspkr/input/input9
[    1.846785] usb 4-1.4: new SuperSpeed USB device number 3 using xhci_hcd
[    1.847912] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.847913] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.847913] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.847914] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.847914] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.849875] pstore: using zlib compression
[    1.849889] pstore: Registered efi as persistent store backend
[    1.852451] snd_hda_intel 0000:00:1b.0: enabling device (0100 -> 0102)
[    1.855637] checking generic (e9000000 1e0000) vs hw (e0000000 8000000)
[    1.855638] checking generic (e9000000 1e0000) vs hw (e8000000 2000000)
[    1.855639] fb: switching to nouveaufb from EFI VGA
[    1.855663] Console: switching to colour dummy device 80x25
[    1.855777] nouveau 0000:01:00.0: NVIDIA GF119 (0d90a0a1)
[    1.859973] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    1.860371] [drm] PipeC fused off
[    1.860378] [drm] Memory usable by graphics device = 2048M
[    1.860379] [drm] Replacing VGA console driver
[    1.870085] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.870086] [drm] Driver supports precise vblank timestamp query.
[    1.888259] intel_rapl: Found RAPL domain package
[    1.888267] intel_rapl: Found RAPL domain core
[    1.888268] intel_rapl: Found RAPL domain uncore
[    1.888276] intel_rapl: Found RAPL domain dram
[    1.888285] intel_rapl: RAPL package 0 domain package locked by BIOS
[    1.888293] intel_rapl: RAPL package 0 domain dram locked by BIOS
[    1.903840] [drm] Initialized i915 1.6.0 20160919 for 0000:00:02.0 on minor 0
[    1.908746] i915 0000:00:02.0: No connectors reported connected with modes
[    1.908748] [drm] Cannot find any crtc or sizes - going 1024x768
[    1.909049] Console: switching to colour frame buffer device 128x48
[    1.910217] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.916110] iTCO_vendor_support: vendor-support=0
[    1.916689] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    1.916737] iTCO_wdt: Found a Lynx Point TCO device (Version=2, TCOBASE=0x0460)
[    1.916999] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    1.966136] usb 4-1.4: New USB device found, idVendor=2109, idProduct=0813
[    1.966137] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.966138] usb 4-1.4: Product: USB3.0 Hub
[    1.966139] usb 4-1.4: Manufacturer: VIA Labs, Inc.
[    1.979973] hub 4-1.4:1.0: USB hub found
[    1.982267] hub 4-1.4:1.0: 4 ports detected
[    2.010830] nouveau 0000:01:00.0: bios: version 75.19.56.00.2b
[    2.012490] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    2.014176] input: HP WMI hotkeys as /devices/virtual/input/input10
[    2.021024] nouveau 0000:01:00.0: fb: 1024 MiB DDR3
[    2.050950] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC221: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    2.050952] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
[    2.050953] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    2.050954] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    2.050954] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    2.050956] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x1a
[    2.050956] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1b
[    2.060527] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    2.061159] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[    2.061196] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    2.061230] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[    2.061263] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[    2.071968] usb 3-5: new high-speed USB device number 4 using xhci_hcd
[    2.081811] [TTM] Zone  kernel: Available graphics memory: 4053114 kiB
[    2.081812] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    2.081813] [TTM] Initializing pool allocator
[    2.081816] [TTM] Initializing DMA pool allocator
[    2.081831] nouveau 0000:01:00.0: DRM: VRAM: 1024 MiB
[    2.081832] nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
[    2.081835] nouveau 0000:01:00.0: DRM: TMDS table version 2.0
[    2.081836] nouveau 0000:01:00.0: DRM: DCB version 4.0
[    2.081837] nouveau 0000:01:00.0: DRM: DCB outp 00: 02000300 00000000
[    2.081839] nouveau 0000:01:00.0: DRM: DCB outp 01: 01000302 00020030
[    2.081840] nouveau 0000:01:00.0: DRM: DCB outp 02: 02011362 00020010
[    2.081840] nouveau 0000:01:00.0: DRM: DCB outp 03: 04022380 00020010
[    2.081841] nouveau 0000:01:00.0: DRM: DCB outp 04: 08022382 00020010
[    2.081843] nouveau 0000:01:00.0: DRM: DCB conn 00: 00001030
[    2.081843] nouveau 0000:01:00.0: DRM: DCB conn 01: 00002161
[    2.081844] nouveau 0000:01:00.0: DRM: DCB conn 02: 01000230
[    2.096021] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.096021] [drm] Driver supports precise vblank timestamp query.
[    2.152884] nouveau 0000:01:00.0: DRM: MM: using COPY0 for buffer copies
[    2.213636] usb 3-5: New USB device found, idVendor=2109, idProduct=2813
[    2.213637] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.213638] usb 3-5: Product: USB2.0 Hub
[    2.213639] usb 3-5: Manufacturer: VIA Labs, Inc.
[    2.214530] hub 3-5:1.0: USB hub found
[    2.214724] hub 3-5:1.0: 4 ports detected
[    2.316117] nouveau 0000:01:00.0: DRM: allocated 1920x1080 fb: 0x60000, bo ffff96fe24758800
[    2.316244] fbcon: nouveaufb (fb1) is primary device
[    2.316244] fbcon: Remapping primary device, fb1, to tty 1-63
[    2.519955] usb 3-5.1: new full-speed USB device number 5 using xhci_hcd
[    2.526738] clocksource: Switched to clocksource tsc
[    2.638290] usb 3-5.1: New USB device found, idVendor=1395, idProduct=740a
[    2.638291] usb 3-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.638292] usb 3-5.1: Product: Sennheiser D 10
[    2.638293] usb 3-5.1: Manufacturer: Sennheiser Communications
[    2.638294] usb 3-5.1: SerialNumber: 5064290950727325
[    2.646790] input: Sennheiser Communications Sennheiser D 10 as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.1/3-5.1:1.0/0003:1395:740A.0003/input/input16
[    2.704255] hid-generic 0003:1395:740A.0003: input,hiddev0,hidraw2: USB HID v1.11 Device [Sennheiser Communications Sennheiser D 10] on usb-0000:00:14.0-5.1/input0
[    2.724371] usbcore: registered new interface driver snd-usb-audio
[    2.734116] nouveau 0000:01:00.0: fb1: nouveaufb frame buffer device
[    2.734119] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
[    2.734320] snd_hda_intel 0000:01:00.1: Disabling MSI
[    2.734325] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    2.795939] usb 3-5.2: new full-speed USB device number 6 using xhci_hcd
[    2.838516] r8169 0000:03:00.0 eth0: link down
[    2.838572] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    2.866359] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    2.868202] br0: port 1(eth0) entered blocking state
[    2.868203] br0: port 1(eth0) entered disabled state
[    2.868291] device eth0 entered promiscuous mode
[    2.869247] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
[    2.914745] usb 3-5.2: New USB device found, idVendor=1395, idProduct=740a
[    2.914747] usb 3-5.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.914748] usb 3-5.2: Product: Sennheiser D 10
[    2.914749] usb 3-5.2: Manufacturer: Sennheiser Communications
[    2.914750] usb 3-5.2: SerialNumber: 5064290900943123
[    2.923732] input: Sennheiser Communications Sennheiser D 10 as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.2/3-5.2:1.0/0003:1395:740A.0004/input/input17
[    2.980278] hid-generic 0003:1395:740A.0004: input,hiddev0,hidraw3: USB HID v1.11 Device [Sennheiser Communications Sennheiser D 10] on usb-0000:00:14.0-5.2/input0
[    3.083978] usb 3-5.3: new full-speed USB device number 7 using xhci_hcd
[    3.202853] usb 3-5.3: New USB device found, idVendor=1395, idProduct=740a
[    3.202857] usb 3-5.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.202859] usb 3-5.3: Product: Sennheiser DECT
[    3.202861] usb 3-5.3: Manufacturer: Sennheiser Communications
[    3.202863] usb 3-5.3: SerialNumber: 5043390950882396
[    3.212811] input: Sennheiser Communications Sennheiser DECT as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.3/3-5.3:1.0/0003:1395:740A.0005/input/input18
[    3.272616] hid-generic 0003:1395:740A.0005: input,hiddev0,hidraw4: USB HID v1.11 Device [Sennheiser Communications Sennheiser DECT] on usb-0000:00:14.0-5.3/input0
[    3.344550] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input19
[    3.344619] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input20
[    3.344673] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input21
[    3.379974] usb 3-5.4: new high-speed USB device number 8 using xhci_hcd
[    3.498052] usb 3-5.4: New USB device found, idVendor=2109, idProduct=2813
[    3.498054] usb 3-5.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.498055] usb 3-5.4: Product: USB2.0 Hub
[    3.498056] usb 3-5.4: Manufacturer: VIA Labs, Inc.
[    3.498998] hub 3-5.4:1.0: USB hub found
[    3.499848] hub 3-5.4:1.0: 4 ports detected
[    3.669252] random: crng init done
[    3.804015] usb 3-5.4.1: new full-speed USB device number 9 using xhci_hcd
[    3.918056] usb 3-5.4.1: New USB device found, idVendor=0b0e, idProduct=101b
[    3.918061] usb 3-5.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.918065] usb 3-5.4.1: Product: Jabra HANDSET 450
[    3.918068] usb 3-5.4.1: Manufacturer: GN Netcom A/S
[    3.918071] usb 3-5.4.1: SerialNumber: 02C4CF736004
[    3.931452] input: GN Netcom A/S Jabra HANDSET 450 as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.4/3-5.4.1/3-5.4.1:1.3/0003:0B0E:101B.0006/input/input22
[    3.988451] hid-generic 0003:0B0E:101B.0006: input,hiddev0,hidraw5: USB HID v1.11 Device [GN Netcom A/S Jabra HANDSET 450] on usb-0000:00:14.0-5.4.1/input3
[    4.079965] usb 3-5.4.4: new full-speed USB device number 10 using xhci_hcd
[    4.198078] usb 3-5.4.4: New USB device found, idVendor=0b0e, idProduct=1041
[    4.198084] usb 3-5.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.198088] usb 3-5.4.4: Product: Jabra PRO 9460
[    4.198092] usb 3-5.4.4: Manufacturer: GN Netcom A/S
[    4.198096] usb 3-5.4.4: SerialNumber: 02AA6C420006
[    4.220781] input: GN Netcom A/S Jabra PRO 9460 as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.4/3-5.4.4/3-5.4.4:1.3/0003:0B0E:1041.0007/input/input23
[    4.280692] hid-generic 0003:0B0E:1041.0007: input,hiddev0,hidraw6: USB HID v1.00 Device [GN Netcom A/S Jabra PRO 9460] on usb-0000:00:14.0-5.4.4/input3
[    4.636560] r8169 0000:03:00.0 eth0: link up
[    4.636738] br0: port 1(eth0) entered blocking state
[    4.636739] br0: port 1(eth0) entered forwarding state
[    4.636783] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   49.206033] FS-Cache: Loaded
[   49.206604] Key type dns_resolver registered
[   49.263357] FS-Cache: Netfs 'cifs' registered for caching
[   49.263421] Key type cifs.spnego registered
[   49.263423] Key type cifs.idmap registered
[   49.538431] Status code returned 0xc000006d NT_STATUS_LOGON_FAILURE
[   49.538446] CIFS VFS: Send error in SessSetup = -13
[   49.538561] CIFS VFS: cifs_mount failed w/return code = -13
[   49.804738] Status code returned 0xc000006d NT_STATUS_LOGON_FAILURE
[   49.804754] CIFS VFS: Send error in SessSetup = -13
[   49.804895] CIFS VFS: cifs_mount failed w/return code = -13
[   50.381413] Bridge firewalling registered
[   50.384931] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   50.427848] Initializing XFRM netlink socket
[   50.432103] Netfilter messages via NETLINK v0.30.
[   50.432659] ctnetlink v0.93: registering with nfnetlink.
[   50.462093] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[   50.494739] IPv6: ADDRCONF(NETDEV_UP): docker_gwbridge: link is not ready
[   51.781465] br0: renamed from ov-001000-xl4xb
[   51.814064] vxlan0: renamed from vx-001000-xl4xb
[   51.841917] br0: port 1(vxlan0) entered blocking state
[   51.841918] br0: port 1(vxlan0) entered disabled state
[   51.841958] device vxlan0 entered promiscuous mode
[   51.842075] br0: port 1(vxlan0) entered blocking state
[   51.842076] br0: port 1(vxlan0) entered forwarding state
[   51.874016] veth0: renamed from veth474eae8
[   51.889897] br0: port 2(veth0) entered blocking state
[   51.889898] br0: port 2(veth0) entered disabled state
[   51.889937] device veth0 entered promiscuous mode
[   51.889990] br0: port 2(veth0) entered blocking state
[   51.889991] br0: port 2(veth0) entered forwarding state
[   51.949901] eth0: renamed from veth6080810
[   51.988531] docker_gwbridge: port 1(veth181639f) entered blocking state
[   51.988532] docker_gwbridge: port 1(veth181639f) entered disabled state
[   51.988560] device veth181639f entered promiscuous mode
[   51.988595] IPv6: ADDRCONF(NETDEV_UP): veth181639f: link is not ready
[   51.988596] docker_gwbridge: port 1(veth181639f) entered blocking state
[   51.988596] docker_gwbridge: port 1(veth181639f) entered forwarding state
[   51.988621] docker_gwbridge: port 1(veth181639f) entered disabled state
[   52.017932] eth1: renamed from veth0aac8e6
[   52.033927] IPv6: ADDRCONF(NETDEV_CHANGE): veth181639f: link becomes ready
[   52.033942] docker_gwbridge: port 1(veth181639f) entered blocking state
[   52.033942] docker_gwbridge: port 1(veth181639f) entered forwarding state
[   52.033959] IPv6: ADDRCONF(NETDEV_CHANGE): docker_gwbridge: link becomes ready
[   52.415514] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   52.422712] Ebtables v2.0 registered
[   52.540185] tun: Universal TUN/TAP device driver, 1.6
[   52.540186] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   52.609534] virbr0: port 1(virbr0-nic) entered blocking state
[   52.609537] virbr0: port 1(virbr0-nic) entered disabled state
[   52.609612] device virbr0-nic entered promiscuous mode
[   52.697922] virbr0: port 1(virbr0-nic) entered blocking state
[   52.697924] virbr0: port 1(virbr0-nic) entered listening state
[   52.758486] virbr0: port 1(virbr0-nic) entered disabled state

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="lsusb-sound.txt"


Bus 002 Device 002: ID 8087:8000 Intel Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x8000 
  bcdDevice            0.04
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             6
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood        0 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered

Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            4.09
  iManufacturer           3 Linux 4.9.0-6-amd64 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:1d.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x02
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0507 highspeed power suspend enable connect
   Port 2: 0000.0100 power
Device Status:     0x0001
  Self Powered

Bus 001 Device 002: ID 8087:8008 Intel Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x8008 
  bcdDevice            0.04
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             4
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood        0 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            4.09
  iManufacturer           3 Linux 4.9.0-6-amd64 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:1a.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x02
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0507 highspeed power suspend enable connect
   Port 2: 0000.0100 power
Device Status:     0x0001
  Self Powered

Bus 004 Device 003: ID 2109:0813 VIA Labs, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         3 
  bMaxPacketSize0         9
  idVendor           0x2109 VIA Labs, Inc.
  idProduct          0x0813 
  bcdDevice           90.15
  iManufacturer           1 VIA Labs, Inc.
  iProduct                2 USB3.0 Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           31
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           19
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             4
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
  bPwrOn2PwrGood      100 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.4 micro seconds
  wHubDelay          4004 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.02a0 5Gbps power Rx.Detect
   Port 2: 0000.02a0 5Gbps power Rx.Detect
   Port 3: 0000.02a0 5Gbps power Rx.Detect
   Port 4: 0000.02a0 5Gbps power Rx.Detect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           42
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           4 micro seconds
    bU2DevExitLat         231 micro seconds
  Container ID Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType      4
    bReserved               0
    ContainerID             {00000000-0000-0000-0000-000000000000}
Device Status:     0x000d
  Self Powered
  U1 Enabled
  U2 Enabled

Bus 004 Device 002: ID 2109:0813 VIA Labs, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         3 
  bMaxPacketSize0         9
  idVendor           0x2109 VIA Labs, Inc.
  idProduct          0x0813 
  bcdDevice           90.11
  iManufacturer           1 VIA Labs, Inc.
  iProduct                2 USB3.0 Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           31
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           19
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             4
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
  bPwrOn2PwrGood      100 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.4 micro seconds
  wHubDelay          4004 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.02a0 5Gbps power Rx.Detect
   Port 2: 0000.02a0 5Gbps power Rx.Detect
   Port 3: 0000.02a0 5Gbps power Rx.Detect
   Port 4: 0000.0263 5Gbps power suspend enable connect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           42
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           4 micro seconds
    bU2DevExitLat         231 micro seconds
  Container ID Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType      4
    bReserved               0
    ContainerID             {00000000-0000-0000-0000-000000000000}
Device Status:     0x000d
  Self Powered
  U1 Enabled
  U2 Enabled

Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         3 
  bMaxPacketSize0         9
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0003 3.0 root hub
  bcdDevice            4.09
  iManufacturer           3 Linux 4.9.0-6-amd64 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:14.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           31
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.0 micro seconds
  wHubDelay             0 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.0263 5Gbps power suspend enable connect
   Port 2: 0000.02a0 5Gbps power Rx.Detect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           15
  bNumDeviceCaps          1
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x02
      Latency Tolerance Messages (LTM) Supported
    wSpeedsSupported   0x0008
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   3
      Lowest fully-functional device speed is SuperSpeed (5Gbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat         512 micro seconds
Device Status:     0x0001
  Self Powered

Bus 003 Device 013: ID 0b0e:1041 GN Netcom 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0b0e GN Netcom
  idProduct          0x1041 
  bcdDevice            3.13
  iManufacturer           1 GN Netcom A/S
  iProduct                2 Jabra PRO 9460
  iSerial                 3 02AA6C420006
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          231
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           75
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 9
        bNrInPins               1
        baSource( 0)            5
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               9
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              20
        bRefresh                0
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           6
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     334
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0024  1x 36 bytes
        bInterval               8
Device Status:     0x0001
  Self Powered

Bus 003 Device 010: ID 0b0e:101b GN Netcom 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0b0e GN Netcom
  idProduct          0x101b 
  bcdDevice            1.26
  iManufacturer           1 GN Netcom A/S
  iProduct                2 Jabra HANDSET 450
  iSerial                 3 02C4CF736004
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          222
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           75
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 9
        bNrInPins               1
        baSource( 0)            5
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               9
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           6
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     275
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0024  1x 36 bytes
        bInterval               8
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled

Bus 003 Device 007: ID 2109:2813 VIA Labs, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x2109 VIA Labs, Inc.
  idProduct          0x2813 
  bcdDevice           90.14
  iManufacturer           1 VIA Labs, Inc.
  iProduct                2 USB2.0 Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             4
  wHubCharacteristic 0x01e9
    Per-port power switching
    Per-port overcurrent protection
    TT think time 32 FS bits
    Port indicators
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0103 power enable connect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           42
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           4 micro seconds
    bU2DevExitLat         231 micro seconds
  Container ID Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType      4
    bReserved               0
    ContainerID             {00000000-0000-0000-0000-000000000000}
Device Status:     0x0001
  Self Powered

Bus 003 Device 009: ID 1395:740a Sennheiser Communications 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1395 Sennheiser Communications
  idProduct          0x740a 
  bcdDevice            1.00
  iManufacturer           1 Sennheiser Communications
  iProduct                2 Sennheiser DECT
  iSerial                 3 5043390950882396
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          231
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     460
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           77
        bInCollection           2
        baInterfaceNr( 0)       2
        baInterfaceNr( 1)       3
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0402 Headset
        bAssocTerminal         14
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID              12
        bControlSize            2
        bmaControls( 0)      0x02
        bmaControls( 0)      0x00
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0402 Headset
        bAssocTerminal         13
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x02
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               1
        baSource( 0)            2
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               8
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 008: ID 1395:740a Sennheiser Communications 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1395 Sennheiser Communications
  idProduct          0x740a 
  bcdDevice            1.00
  iManufacturer           1 Sennheiser Communications
  iProduct                2 Sennheiser D 10
  iSerial                 3 5064290900943123
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          231
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     460
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           77
        bInCollection           2
        baInterfaceNr( 0)       2
        baInterfaceNr( 1)       3
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0402 Headset
        bAssocTerminal         14
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID              12
        bControlSize            2
        bmaControls( 0)      0x02
        bmaControls( 0)      0x00
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0402 Headset
        bAssocTerminal         13
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x02
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               1
        baSource( 0)            2
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               8
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 006: ID 1395:740a Sennheiser Communications 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1395 Sennheiser Communications
  idProduct          0x740a 
  bcdDevice            1.00
  iManufacturer           1 Sennheiser Communications
  iProduct                2 Sennheiser D 10
  iSerial                 3 5064290950727325
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          231
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     460
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           77
        bInCollection           2
        baInterfaceNr( 0)       2
        baInterfaceNr( 1)       3
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0402 Headset
        bAssocTerminal         14
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID              12
        bControlSize            2
        bmaControls( 0)      0x02
        bmaControls( 0)      0x00
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0402 Headset
        bAssocTerminal         13
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x02
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               1
        baSource( 0)            2
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               8
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 005: ID 2109:2813 VIA Labs, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x2109 VIA Labs, Inc.
  idProduct          0x2813 
  bcdDevice           90.11
  iManufacturer           1 VIA Labs, Inc.
  iProduct                2 USB2.0 Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             4
  wHubCharacteristic 0x00e9
    Per-port power switching
    Per-port overcurrent protection
    TT think time 32 FS bits
    Port indicators
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0103 power enable connect
   Port 3: 0000.0103 power enable connect
   Port 4: 0000.0503 highspeed power enable connect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           42
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           4 micro seconds
    bU2DevExitLat         231 micro seconds
  Container ID Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType      4
    bReserved               0
    ContainerID             {00000000-0000-0000-0000-000000000000}
Device Status:     0x0001
  Self Powered

Bus 003 Device 003: ID 046a:0011 Cherry GmbH G83 (RS 6000) Keyboard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046a Cherry GmbH
  idProduct          0x0011 G83 (RS 6000) Keyboard
  bcdDevice            1.00
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      64
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 002: ID 093a:2510 Pixart Imaging, Inc. Optical Mouse
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x093a Pixart Imaging, Inc.
  idProduct          0x2510 Optical Mouse
  bcdDevice            1.00
  iManufacturer           1 PixArt
  iProduct                2 USB Optical Mouse
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      46
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            4.09
  iManufacturer           3 Linux 4.9.0-6-amd64 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:14.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts            10
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x06
  PortPwrCtrlMask    0xff 0xff
 Hub Port Status:
   Port 1: 0000.0303 lowspeed power enable connect
   Port 2: 0000.0303 lowspeed power enable connect
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0503 highspeed power enable connect
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power
Device Status:     0x0001
  Self Powered

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="aplay.txt"

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC221 Analog [ALC221 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 3: S10 [Sennheiser D 10], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 4: S10_1 [Sennheiser D 10], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 5: DECT [Sennheiser DECT], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 6: J450 [Jabra HANDSET 450], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 8: J9460 [Jabra PRO 9460], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

--NMuMz9nt05w80d4+--
