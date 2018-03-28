Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeC1GbQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:31:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:60895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeC1GbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:31:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,370,1517904000";
   d="scan'208";a="211925749"
Message-ID: <1522218664.9730.90.camel@gmail.com>
Subject: Re: regression: SCSI/SATA failure
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "hch@lst.de" <hch@lst.de>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sth@linux.vnet.ibm.com" <sth@linux.vnet.ibm.com>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Date: Wed, 28 Mar 2018 09:31:04 +0300
In-Reply-To: <1519311270.2535.53.camel@intel.com>
References: <1519311270.2535.53.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 14:54 +0000, Bityutskiy, Artem wrote:
> Hi Christoph,
> 
> one of our test box Skylake servers does not boot with v4.16-rcX.
> Bisection lead us to this commit:
> 
> 84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs
> 
> Reverting this single commit fixes the problem.
> 
> The server is a Dell R640 machine with the latest Dell BIOS. It has a
> single SATA SSD and we do not use raid, even though the system does
> have a megaraid controller.
> 
> Are you aware of this issue? Below is the failure message and the
> full
> dmesg with some debugging boot parameters is here:
> 
> https://pastebin.com/raw/tTYrTAEQ

The pastebin is now expired. Inlining dmesg here just in case someone
needs it.

Loading http://powerlab/pxelinux/node/sklep0/custom-kernel/kernel... ok
[    0.000000] microcode: microcode updated early to revision 0x200003c, date = 2017-12-08
[    0.000000] Linux version 4.16.0-rc2+ (abityuts@powerlab) (gcc version 7.3.1 20180130 (Red Hat 7.3.1-2) (GCC)) #1 SMP Thu Feb 22 16:09:31 EET 2018
[    0.000000] Command line: BOOT_IMAGE=http://powerlab/pxelinux/node/sklep0/custom-kernel/kernel initrd=http://powerlab/pxelinux/node/sklep0/custom-kernel/initramfs.img root=LABEL=root ro console=tty0 console=t
tyS0,115200 vconsole.font=latarcyrheb-sun16 LANG=en_US.UTF-8 nomodeset sysrq_always_enabled ignore_loglevel initcall_debug
[    0.000000] Intel Spectre v2 broken microcode detected; disabling Speculation Control
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006c2cefff] usable
[    0.000000] BIOS-e820: [mem 0x000000006c2cf000-0x000000006e7cefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006e7cf000-0x000000006f5fefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006f5ff000-0x000000006f7fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006f7ff000-0x000000006f7fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x6009a020-0x600a205f] usable ==> usable
[    0.000000] e820: update [mem 0x6009a020-0x600a205f] usable ==> usable
[    0.000000] e820: update [mem 0x60081020-0x6009945f] usable ==> usable
[    0.000000] e820: update [mem 0x60081020-0x6009945f] usable ==> usable
[    0.000000] e820: update [mem 0x5f16d020-0x5f1ce25f] usable ==> usable
[    0.000000] e820: update [mem 0x5f16d020-0x5f1ce25f] usable ==> usable
[    0.000000] e820: update [mem 0x5f10b020-0x5f16c25f] usable ==> usable
[    0.000000] e820: update [mem 0x5f10b020-0x5f16c25f] usable ==> usable
[    0.000000] e820: update [mem 0x5f0ae020-0x5f10a65f] usable ==> usable
[    0.000000] e820: update [mem 0x5f0ae020-0x5f10a65f] usable ==> usable
[    0.000000] e820: update [mem 0x5f051020-0x5f0ad65f] usable ==> usable
[    0.000000] e820: update [mem 0x5f051020-0x5f0ad65f] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000005f05101f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f051020-0x000000005f0ad65f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f0ad660-0x000000005f0ae01f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f0ae020-0x000000005f10a65f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f10a660-0x000000005f10b01f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f10b020-0x000000005f16c25f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f16c260-0x000000005f16d01f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f16d020-0x000000005f1ce25f] usable
[    0.000000] reserve setup_data: [mem 0x000000005f1ce260-0x000000006008101f] usable
[    0.000000] reserve setup_data: [mem 0x0000000060081020-0x000000006009945f] usable
[    0.000000] reserve setup_data: [mem 0x0000000060099460-0x000000006009a01f] usable
[    0.000000] reserve setup_data: [mem 0x000000006009a020-0x00000000600a205f] usable
[    0.000000] reserve setup_data: [mem 0x00000000600a2060-0x000000006c2cefff] usable
[    0.000000] reserve setup_data: [mem 0x000000006c2cf000-0x000000006e7cefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000006e7cf000-0x000000006f5fefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000006f5ff000-0x000000006f7fefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000006f7ff000-0x000000006f7fffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] efi: EFI v2.50 by Dell Inc.
[    0.000000] efi:  ACPI=0x6f7fe000  ACPI 2.0=0x6f7fe014  SMBIOS=0x6d268000  SMBIOS 3.0=0x6d266000 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. PowerEdge R640/0CRT1G, BIOS 1.2.11 10/19/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x3040000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask 3FE000000000 write-back
[    0.000000]   1 base 002000000000 mask 3FF000000000 write-back
[    0.000000]   2 base 003000000000 mask 3FFFC0000000 write-back
[    0.000000]   3 base 000080000000 mask 3FFF80000000 uncachable
[    0.000000]   4 base 00007F000000 mask 3FFFFF000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0x7f000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x6f800 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x255e745000, 0x255e745fff] PGTABLE
[    0.000000] BRK [0x255e746000, 0x255e746fff] PGTABLE
[    0.000000] BRK [0x255e747000, 0x255e747fff] PGTABLE
[    0.000000] BRK [0x255e748000, 0x255e748fff] PGTABLE
[    0.000000] BRK [0x255e749000, 0x255e749fff] PGTABLE
[    0.000000] BRK [0x255e74a000, 0x255e74afff] PGTABLE
[    0.000000] BRK [0x255e74b000, 0x255e74bfff] PGTABLE
[    0.000000] BRK [0x255e74c000, 0x255e74cfff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x52625000-0x5e054fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000006F7FE014 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x000000006F680188 00010C (v01 DELL   PE_SC3   00000000      01000013)
[    0.000000] ACPI: FACP 0x000000006F7F8000 000114 (v06 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: DSDT 0x000000006F79F000 03172B (v02 DELL   PE_SC3   00000003 DELL 00000001)
[    0.000000] ACPI: FACS 0x000000006EF6F000 000040
[    0.000000] ACPI: SSDT 0x000000006F7FC000 0003C6 (v02 DELL   Tpm2Tabl 00001000 INTL 20150818)
[    0.000000] ACPI: TPM2 0x000000006F7FB000 000038 (v04 DELL   PE_SC3   00000002      01000013)
[    0.000000] ACPI: MCEJ 0x000000006F7FA000 000130 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: WD__ 0x000000006F7F9000 000134 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: HPET 0x000000006F7F7000 000038 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: APIC 0x000000006F7F5000 0016DE (v04 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: MCFG 0x000000006F7F4000 00003C (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: MIGT 0x000000006F7F3000 000040 (v01 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: MSCT 0x000000006F7F2000 000090 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: NFIT 0x000000006F7D9000 018028 (v01                 00000000      00000000)
[    0.000000] ACPI: PCAT 0x000000006F7D8000 000048 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: PCCT 0x000000006F7D7000 00006E (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: RASF 0x000000006F7D6000 000030 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SLIT 0x000000006F7D5000 00006C (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SRAT 0x000000006F7D2000 002830 (v03 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: SVOS 0x000000006F7D1000 000032 (v01 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: OEM4 0x000000006F6FC000 0A27C4 (v02 INTEL  CPU  CST 00003000 INTL 20150818)
[    0.000000] ACPI: OEM1 0x000000006F6D1000 02A2C4 (v02 INTEL  CPU EIST 00003000 INTL 20150818)
[    0.000000] ACPI: OEM2 0x000000006F6B7000 019464 (v02 INTEL  CPU  HWP 00003000 INTL 20150818)
[    0.000000] ACPI: SSDT 0x000000006F681000 035130 (v02 INTEL  SSDT  PM 00004000 INTL 20150818)
[    0.000000] ACPI: SSDT 0x000000006F7FD000 000761 (v02 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: SSDT 0x000000006F67D000 002541 (v02 INTEL  SpsNm    00000002 INTL 20150818)
[    0.000000] ACPI: SPCR 0x000000006F67C000 000050 (v01                 00000000      00000000)
[    0.000000] ACPI: DMAR 0x000000006F67B000 000220 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: HEST 0x000000006F67A000 00017C (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: BERT 0x000000006F679000 000030 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: ERST 0x000000006F678000 000230 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: EINJ 0x000000006F677000 000150 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x40 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x4c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x42 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x4a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x44 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x48 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x46 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x5a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x50 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x58 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x52 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x56 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x54 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x2c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x6c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x60 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x2a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x6a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x62 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x28 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x68 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x64 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x66 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x70 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x3a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x7a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x32 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x72 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x38 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x78 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x34 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x74 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x36 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x76 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x41 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x4d -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x43 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x4b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x45 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x49 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x47 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x5b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x51 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x59 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x53 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x57 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x55 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x2d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x6d -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x61 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x2b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x6b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x63 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x29 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x69 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x65 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x67 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x71 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x3b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x7b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x33 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x73 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x39 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x79 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x35 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x75 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x37 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x77 -> Node 1
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x183fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x1840000000-0x303fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x183fffffff] -> [mem 0x00000000-0x183fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x183ffee000-0x183fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x303ffed000-0x303fffefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000303fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000006c2cefff]
[    0.000000]   node   0: [mem 0x000000006f7ff000-0x000000006f7fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000183fffffff]
[    0.000000]   node   1: [mem 0x0000001840000000-0x000000303fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000183fffffff]
[    0.000000] On node 0 totalpages: 24822383
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 1094 pages reserved
[    0.000000]   DMA zone: 3999 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6860 pages used for memmap
[    0.000000]   DMA32 zone: 438992 pages, LIFO batch:31
[    0.000000]   Normal zone: 380928 pages used for memmap
[    0.000000]   Normal zone: 24379392 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000001840000000-0x000000303fffffff]
[    0.000000] On node 1 totalpages: 25165824
[    0.000000]   Normal zone: 393216 pages used for memmap
[    0.000000]   Normal zone: 25165824 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 97 pages
[    0.000000] tboot: non-0 tboot_addr but it is not of type E820_TYPE_RESERVED
[    0.000000] ACPI: PM-Timer IO Port: 0x508
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.000000] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.000000] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.000000] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 72-79
[    0.000000] IOAPIC[6]: apic_id 16, version 32, address 0xfec28000, GSI 80-87
[    0.000000] IOAPIC[7]: apic_id 17, version 32, address 0xfec30000, GSI 88-95
[    0.000000] IOAPIC[8]: apic_id 18, version 32, address 0xfec38000, GSI 96-103
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] ACPI: SPCR: SPCR table version 1
[    0.000000] ACPI: SPCR: console: uart,io,0x3f8,115200
[    0.000000] smpboot: Allowing 328 CPUs, 224 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f051000-0x5f051fff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f0ad000-0x5f0adfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f0ae000-0x5f0aefff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f10a000-0x5f10afff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f10b000-0x5f10bfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f16c000-0x5f16cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f16d000-0x5f16dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f1ce000-0x5f1cefff]
[    0.000000] PM: Registered nosave memory: [mem 0x60081000-0x60081fff]
[    0.000000] PM: Registered nosave memory: [mem 0x60099000-0x60099fff]
[    0.000000] PM: Registered nosave memory: [mem 0x6009a000-0x6009afff]
[    0.000000] PM: Registered nosave memory: [mem 0x600a2000-0x600a2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x6c2cf000-0x6e7cefff]
[    0.000000] PM: Registered nosave memory: [mem 0x6e7cf000-0x6f5fefff]
[    0.000000] PM: Registered nosave memory: [mem 0x6f5ff000-0x6f7fefff]
[    0.000000] PM: Registered nosave memory: [mem 0x6f800000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0x8fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x90000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.000000] e820: [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:328 nr_node_ids:2
[    0.000000] percpu: Embedded 44 pages/cpu @        (ptrval) s141464 r8192 d30568 u262144
[    0.000000] pcpu-alloc: s141464 r8192 d30568 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 000 002 004 006 008 010 012 014 
[    0.000000] pcpu-alloc: [0] 016 018 020 022 024 026 028 030 
[    0.000000] pcpu-alloc: [0] 032 034 036 038 040 042 044 046 
[    0.000000] pcpu-alloc: [0] 048 050 052 054 056 058 060 062 
[    0.000000] pcpu-alloc: [0] 064 066 068 070 072 074 076 078 
[    0.000000] pcpu-alloc: [0] 080 082 084 086 088 090 092 094 
[    0.000000] pcpu-alloc: [0] 096 098 100 102 104 106 108 110 
[    0.000000] pcpu-alloc: [0] 112 114 116 118 120 122 124 126 
[    0.000000] pcpu-alloc: [0] 128 130 132 134 136 138 140 142 
[    0.000000] pcpu-alloc: [0] 144 146 148 150 152 154 156 158 
[    0.000000] pcpu-alloc: [0] 160 162 164 166 168 170 172 174 
[    0.000000] pcpu-alloc: [0] 176 178 180 182 184 186 188 190 
[    0.000000] pcpu-alloc: [0] 192 194 196 198 200 202 204 206 
[    0.000000] pcpu-alloc: [0] 208 210 212 214 216 218 220 222 
[    0.000000] pcpu-alloc: [0] 224 226 228 230 232 234 236 238 
[    0.000000] pcpu-alloc: [0] 240 242 244 246 248 250 252 254 
[    0.000000] pcpu-alloc: [0] 256 258 260 262 264 266 268 270 
[    0.000000] pcpu-alloc: [0] 272 274 276 278 280 282 284 286 
[    0.000000] pcpu-alloc: [0] 288 290 292 294 296 298 300 302 
[    0.000000] pcpu-alloc: [0] 304 306 308 310 312 314 316 318 
[    0.000000] pcpu-alloc: [0] 320 322 324 326 --- --- --- --- 
[    0.000000] pcpu-alloc: [1] 001 003 005 007 009 011 013 015 
[    0.000000] pcpu-alloc: [1] 017 019 021 023 025 027 029 031 
[    0.000000] pcpu-alloc: [1] 033 035 037 039 041 043 045 047 
[    0.000000] pcpu-alloc: [1] 049 051 053 055 057 059 061 063 
[    0.000000] pcpu-alloc: [1] 065 067 069 071 073 075 077 079 
[    0.000000] pcpu-alloc: [1] 081 083 085 087 089 091 093 095 
[    0.000000] pcpu-alloc: [1] 097 099 101 103 105 107 109 111 
[    0.000000] pcpu-alloc: [1] 113 115 117 119 121 123 125 127 
[    0.000000] pcpu-alloc: [1] 129 131 133 135 137 139 141 143 
[    0.000000] pcpu-alloc: [1] 145 147 149 151 153 155 157 159 
[    0.000000] pcpu-alloc: [1] 161 163 165 167 169 171 173 175 
[    0.000000] pcpu-alloc: [1] 177 179 181 183 185 187 189 191 
[    0.000000] pcpu-alloc: [1] 193 195 197 199 201 203 205 207 
[    0.000000] pcpu-alloc: [1] 209 211 213 215 217 219 221 223 
[    0.000000] pcpu-alloc: [1] 225 227 229 231 233 235 237 239 
[    0.000000] pcpu-alloc: [1] 241 243 245 247 249 251 253 255 
[    0.000000] pcpu-alloc: [1] 257 259 261 263 265 267 269 271 
[    0.000000] pcpu-alloc: [1] 273 275 277 279 281 283 285 287 
[    0.000000] pcpu-alloc: [1] 289 291 293 295 297 299 301 303 
[    0.000000] pcpu-alloc: [1] 305 307 309 311 313 315 317 319 
[    0.000000] pcpu-alloc: [1] 321 323 325 327 --- --- --- --- 
[    0.000000] Built 2 zonelists, mobility grouping on.  Total pages: 49206045
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=http://powerlab/pxelinux/node/sklep0/custom-kernel/kernel initrd=http://powerlab/pxelinux/node/sklep0/custom-kernel/initramfs.img root=LABEL=root ro console=tty0 co
nsole=ttyS0,115200 vconsole.font=latarcyrheb-sun16 LANG=en_US.UTF-8 nomodeset sysrq_always_enabled ignore_loglevel initcall_debug
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 1339392 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 2097152 bytes
[    0.000000] early log buf free: 236360(90%)
[    0.000000] Memory: 196278068K/199952828K available (10252K kernel code, 1372K rwdata, 3388K rodata, 1692K init, 1188K bss, 3674760K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=328, Nodes=2
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 32173 entries in 126 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU event tracing is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=328.
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=328
[    0.000000] NR_IRQS: 33024, nr_irqs: 4408, preallocated irqs: 16
[    0.000000]  Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] ACPI: Core revision 20180105
[    0.000000] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.002000] DMAR: Host address width 46
[    0.003000] DMAR: DRHD base: 0x000000d37fc000 flags: 0x0
[    0.004000] DMAR: dmar0: reg_base_addr d37fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.005000] DMAR: DRHD base: 0x000000e0ffc000 flags: 0x0
[    0.006000] DMAR: dmar1: reg_base_addr e0ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.007000] DMAR: DRHD base: 0x000000ee7fc000 flags: 0x0
[    0.008000] DMAR: dmar2: reg_base_addr ee7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.009000] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.010000] DMAR: dmar3: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.011000] DMAR: DRHD base: 0x000000aaffc000 flags: 0x0
[    0.012000] DMAR: dmar4: reg_base_addr aaffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.013000] DMAR: DRHD base: 0x000000b87fc000 flags: 0x0
[    0.014000] DMAR: dmar5: reg_base_addr b87fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.015000] DMAR: DRHD base: 0x000000c5ffc000 flags: 0x0
[    0.016000] DMAR: dmar6: reg_base_addr c5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.017000] DMAR: DRHD base: 0x0000009d7fc000 flags: 0x1
[    0.018000] DMAR: dmar7: reg_base_addr 9d7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.019000] DMAR: RMRR base: 0x0000006ef61000 end: 0x0000006ef63fff
[    0.020000] DMAR: ATSR flags: 0x0
[    0.021000] DMAR: ATSR flags: 0x0
[    0.022000] DMAR-IR: IOAPIC id 12 under DRHD base  0xc5ffc000 IOMMU 6
[    0.023000] DMAR-IR: IOAPIC id 11 under DRHD base  0xb87fc000 IOMMU 5
[    0.024000] DMAR-IR: IOAPIC id 10 under DRHD base  0xaaffc000 IOMMU 4
[    0.025000] DMAR-IR: IOAPIC id 18 under DRHD base  0xfbffc000 IOMMU 3
[    0.026000] DMAR-IR: IOAPIC id 17 under DRHD base  0xee7fc000 IOMMU 2
[    0.027000] DMAR-IR: IOAPIC id 16 under DRHD base  0xe0ffc000 IOMMU 1
[    0.028000] DMAR-IR: IOAPIC id 15 under DRHD base  0xd37fc000 IOMMU 0
[    0.029000] DMAR-IR: IOAPIC id 8 under DRHD base  0x9d7fc000 IOMMU 7
[    0.030000] DMAR-IR: IOAPIC id 9 under DRHD base  0x9d7fc000 IOMMU 7
[    0.031000] DMAR-IR: HPET id 0 under DRHD base 0x9d7fc000
[    0.032000] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.032000] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.035000] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.035000] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.036000] Switched APIC routing to physical flat.
[    0.039000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.044000] tsc: Detected 2100.000 MHz processor
[    0.045000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e4530a99b6, max_idle_ns: 440795257976 ns
[    0.046003] Calibrating delay loop (skipped), value calculated using timer frequency.. 4200.00 BogoMIPS (lpj=2100000)
[    0.047001] pid_max: default: 335872 minimum: 2624
[    0.050721] Security Framework initialized
[    0.051001] SELinux:  Initializing.
[    0.052199] SELinux:  Starting in permissive mode
[    0.074272] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.086234] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.088120] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.089318] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.092690] CPU: Physical Processor ID: 0
[    0.093000] CPU: Processor Core ID: 0
[    0.094013] mce: CPU supports 20 MCE banks
[    0.095014] CPU0: Thermal monitoring enabled (TM1)
[    0.096025] process: using mwait in idle threads
[    0.097002] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.098000] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.099002] Spectre V2 : Mitigation: Full generic retpoline
[    0.100000] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.101463] Freeing SMP alternatives memory: 32K
[    0.108359] TSC deadline timer enabled
[    0.109000] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8170M CPU @ 2.10GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.109440] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
[    0.110002] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
[    0.111001] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
[    0.112002] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
[    0.113001] calling  init_hw_perf_events+0x0/0x5d2 @ 1
[    0.114001] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.115003] ... version:                4
[    0.116000] ... bit width:              48
[    0.117000] ... generic registers:      4
[    0.118001] ... value mask:             0000ffffffffffff
[    0.119000] ... max period:             00007fffffffffff
[    0.120000] ... fixed-purpose events:   3
[    0.121000] ... event mask:             000000070000000f
[    0.122216] initcall init_hw_perf_events+0x0/0x5d2 returned 0 after 7812 usecs
[    0.123002] calling  init_real_mode+0x0/0x1a7 @ 1
[    0.124042] initcall init_real_mode+0x0/0x1a7 returned 0 after 0 usecs
[    0.125002] calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
[    0.126002] initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
[    0.127004] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
[    0.128002] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
[    0.129003] calling  early_efi_map_fb+0x0/0x34 @ 1
[    0.130001] initcall early_efi_map_fb+0x0/0x34 returned 0 after 0 usecs
[    0.131001] calling  spawn_ksoftirqd+0x0/0x40 @ 1
[    0.132013] initcall spawn_ksoftirqd+0x0/0x40 returned 0 after 0 usecs
[    0.133002] calling  migration_init+0x0/0x34 @ 1
[    0.134002] initcall migration_init+0x0/0x34 returned 0 after 0 usecs
[    0.135003] calling  check_cpu_stall_init+0x0/0x1b @ 1
[    0.136002] initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
[    0.137002] calling  srcu_bootup_announce+0x0/0x30 @ 1
[    0.138000] Hierarchical SRCU implementation.
[    0.139002] initcall srcu_bootup_announce+0x0/0x30 returned 0 after 976 usecs
[    0.140002] calling  rcu_spawn_gp_kthread+0x0/0x158 @ 1
[    0.141020] initcall rcu_spawn_gp_kthread+0x0/0x158 returned 0 after 0 usecs
[    0.142002] calling  cpu_stop_init+0x0/0x8d @ 1
[    0.143062] initcall cpu_stop_init+0x0/0x8d returned 0 after 0 usecs
[    0.144002] calling  init_events+0x0/0x40 @ 1
[    0.145012] initcall init_events+0x0/0x40 returned 0 after 0 usecs
[    0.146001] calling  init_trace_printk+0x0/0xc @ 1
[    0.147002] initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
[    0.148001] calling  event_trace_enable_again+0x0/0x21 @ 1
[    0.149002] initcall event_trace_enable_again+0x0/0x21 returned 0 after 0 usecs
[    0.150002] calling  jump_label_init_module+0x0/0x11 @ 1
[    0.151002] initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
[    0.152004] calling  dynamic_debug_init+0x0/0x23a @ 1
[    0.153763] initcall dynamic_debug_init+0x0/0x23a returned 0 after 0 usecs
[    0.154004] calling  rand_initialize+0x0/0x100 @ 1
[    0.155049] initcall rand_initialize+0x0/0x100 returned 0 after 0 usecs
[    0.156003] calling  initialize_ptr_random+0x0/0x36 @ 1
[    0.157003] initcall initialize_ptr_random+0x0/0x36 returned 0 after 0 usecs
[    0.161100] smp: Bringing up secondary CPUs ...
[    0.162139] x86: Booting SMP configuration:
[    0.163001] .... node  #1, CPUs:          #1
[    0.230004] .... node  #0, CPUs:     #2
[    0.236002] .... node  #1, CPUs:     #3
[    0.242001] .... node  #0, CPUs:     #4
[    0.248002] .... node  #1, CPUs:     #5
[    0.254001] .... node  #0, CPUs:     #6
[    0.260002] .... node  #1, CPUs:     #7
[    0.266002] .... node  #0, CPUs:     #8
[    0.271001] .... node  #1, CPUs:     #9
[    0.277001] .... node  #0, CPUs:    #10
[    0.283002] .... node  #1, CPUs:    #11
[    0.289001] .... node  #0, CPUs:    #12
[    0.295002] .... node  #1, CPUs:    #13
[    0.301001] .... node  #0, CPUs:    #14
[    0.307001] .... node  #1, CPUs:    #15
[    0.313001] .... node  #0, CPUs:    #16
[    0.319001] .... node  #1, CPUs:    #17
[    0.325001] .... node  #0, CPUs:    #18
[    0.331001] .... node  #1, CPUs:    #19
[    0.337002] .... node  #0, CPUs:    #20
[    0.342002] .... node  #1, CPUs:    #21
[    0.348001] .... node  #0, CPUs:    #22
[    0.353001] .... node  #1, CPUs:    #23
[    0.359001] .... node  #0, CPUs:    #24
[    0.364003] .... node  #1, CPUs:    #25
[    0.370002] .... node  #0, CPUs:    #26
[    0.376001] .... node  #1, CPUs:    #27
[    0.382001] .... node  #0, CPUs:    #28
[    0.387003] .... node  #1, CPUs:    #29
[    0.393002] .... node  #0, CPUs:    #30
[    0.399002] .... node  #1, CPUs:    #31
[    0.405002] .... node  #0, CPUs:    #32
[    0.410002] .... node  #1, CPUs:    #33
[    0.416002] .... node  #0, CPUs:    #34
[    0.421001] .... node  #1, CPUs:    #35
[    0.427001] .... node  #0, CPUs:    #36
[    0.432002] .... node  #1, CPUs:    #37
[    0.438002] .... node  #0, CPUs:    #38
[    0.443002] .... node  #1, CPUs:    #39
[    0.449002] .... node  #0, CPUs:    #40
[    0.455001] .... node  #1, CPUs:    #41
[    0.461002] .... node  #0, CPUs:    #42
[    0.467003] .... node  #1, CPUs:    #43
[    0.473002] .... node  #0, CPUs:    #44
[    0.479002] .... node  #1, CPUs:    #45
[    0.485002] .... node  #0, CPUs:    #46
[    0.490002] .... node  #1, CPUs:    #47
[    0.496002] .... node  #0, CPUs:    #48
[    0.501003] .... node  #1, CPUs:    #49
[    0.507002] .... node  #0, CPUs:    #50
[    0.512003] .... node  #1, CPUs:    #51
[    0.518002] .... node  #0, CPUs:    #52
[    0.521002] .... node  #1, CPUs:    #53
[    0.527002] .... node  #0, CPUs:    #54
[    0.533003] .... node  #1, CPUs:    #55
[    0.539002] .... node  #0, CPUs:    #56
[    0.545002] .... node  #1, CPUs:    #57
[    0.551002] .... node  #0, CPUs:    #58
[    0.557002] .... node  #1, CPUs:    #59
[    0.563002] .... node  #0, CPUs:    #60
[    0.568003] .... node  #1, CPUs:    #61
[    0.574002] .... node  #0, CPUs:    #62
[    0.579003] .... node  #1, CPUs:    #63
[    0.585002] .... node  #0, CPUs:    #64
[    0.591002] .... node  #1, CPUs:    #65
[    0.597002] .... node  #0, CPUs:    #66
[    0.603002] .... node  #1, CPUs:    #67
[    0.609002] .... node  #0, CPUs:    #68
[    0.615003] .... node  #1, CPUs:    #69
[    0.621002] .... node  #0, CPUs:    #70
[    0.627001] .... node  #1, CPUs:    #71
[    0.633002] .... node  #0, CPUs:    #72
[    0.638003] .... node  #1, CPUs:    #73
[    0.644002] .... node  #0, CPUs:    #74
[    0.649003] .... node  #1, CPUs:    #75
[    0.655002] .... node  #0, CPUs:    #76
[    0.660002] .... node  #1, CPUs:    #77
[    0.666002] .... node  #0, CPUs:    #78
[    0.672001] .... node  #1, CPUs:    #79
[    0.678002] .... node  #0, CPUs:    #80
[    0.684002] .... node  #1, CPUs:    #81
[    0.690002] .... node  #0, CPUs:    #82
[    0.696003] .... node  #1, CPUs:    #83
[    0.702002] .... node  #0, CPUs:    #84
[    0.707003] .... node  #1, CPUs:    #85
[    0.713002] .... node  #0, CPUs:    #86
[    0.719001] .... node  #1, CPUs:    #87
[    0.725002] .... node  #0, CPUs:    #88
[    0.730003] .... node  #1, CPUs:    #89
[    0.736002] .... node  #0, CPUs:    #90
[    0.741003] .... node  #1, CPUs:    #91
[    0.747002] .... node  #0, CPUs:    #92
[    0.753003] .... node  #1, CPUs:    #93
[    0.759002] .... node  #0, CPUs:    #94
[    0.765002] .... node  #1, CPUs:    #95
[    0.771002] .... node  #0, CPUs:    #96
[    0.777003] .... node  #1, CPUs:    #97
[    0.783002] .... node  #0, CPUs:    #98
[    0.789001] .... node  #1, CPUs:    #99
[    0.795002] .... node  #0, CPUs:   #100
[    0.801003] .... node  #1, CPUs:   #101
[    0.807002] .... node  #0, CPUs:   #102
[    0.813003] .... node  #1, CPUs:   #103
[    0.818264] smp: Brought up 2 nodes, 104 CPUs
[    0.820002] smpboot: Max logical packages: 7
[    0.821004] smpboot: Total of 104 processors activated (437039.30 BogoMIPS)
[    0.834001] devtmpfs: initialized
[    0.835047] x86/mm: Memory block size: 2048MB
[    0.836732] calling  ipc_ns_init+0x0/0x57 @ 1
[    0.837004] initcall ipc_ns_init+0x0/0x57 returned 0 after 0 usecs
[    0.838002] calling  init_mmap_min_addr+0x0/0x25 @ 1
[    0.839002] initcall init_mmap_min_addr+0x0/0x25 returned 0 after 0 usecs
[    0.840005] calling  init_cpufreq_transition_notifier_list+0x0/0x1b @ 1
[    0.841114] initcall init_cpufreq_transition_notifier_list+0x0/0x1b returned 0 after 0 usecs
[    0.842004] calling  net_ns_init+0x0/0x157 @ 1
[    0.843098] initcall net_ns_init+0x0/0x157 returned 0 after 0 usecs
[    0.844036] calling  e820__register_nvs_regions+0x0/0x38 @ 1
[    0.845002] PM: Registering ACPI NVS region [mem 0x6e7cf000-0x6f5fefff] (14876672 bytes)
[    0.846143] initcall e820__register_nvs_regions+0x0/0x38 returned 0 after 976 usecs
[    0.847002] calling  cpufreq_register_tsc_scaling+0x0/0x2a @ 1
[    0.848002] initcall cpufreq_register_tsc_scaling+0x0/0x2a returned 0 after 0 usecs
[    0.849002] calling  init_cpu_syscore+0x0/0xf @ 1
[    0.850003] initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
[    0.851001] calling  reboot_init+0x0/0x3d @ 1
[    0.852006] initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
[    0.853002] calling  init_lapic_sysfs+0x0/0x21 @ 1
[    0.854002] initcall init_lapic_sysfs+0x0/0x21 returned 0 after 0 usecs
[    0.855002] calling  uv_bau_init+0x0/0x172e @ 1
[    0.856002] initcall uv_bau_init+0x0/0x172e returned 0 after 0 usecs
[    0.857001] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
[    0.858002] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
[    0.859001] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    0.860001] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usecs
[    0.861001] calling  wq_sysfs_init+0x0/0x2b @ 1
[    0.862010] initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
[    0.863002] calling  ksysfs_init+0x0/0x93 @ 1
[    0.864005] initcall ksysfs_init+0x0/0x93 returned 0 after 0 usecs
[    0.865002] calling  pm_init+0x0/0x78 @ 1
[    0.866439] initcall pm_init+0x0/0x78 returned 0 after 0 usecs
[    0.867002] calling  pm_disk_init+0x0/0x18 @ 1
[    0.868003] initcall pm_disk_init+0x0/0x18 returned 0 after 0 usecs
[    0.869006] calling  swsusp_header_init+0x0/0x30 @ 1
[    0.870002] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    0.871004] calling  rcu_spawn_tasks_kthread+0x0/0x44 @ 1
[    0.872018] initcall rcu_spawn_tasks_kthread+0x0/0x44 returned 0 after 0 usecs
[    0.873002] calling  rcu_set_runtime_mode+0x0/0x12 @ 1
[    0.874002] initcall rcu_set_runtime_mode+0x0/0x12 returned 0 after 0 usecs
[    0.875001] calling  init_jiffies_clocksource+0x0/0x18 @ 1
[    0.876002] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.877003] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 976 usecs
[    0.878001] calling  futex_init+0x0/0xf9 @ 1
[    0.879267] futex hash table entries: 131072 (order: 11, 8388608 bytes)
[    0.880908] initcall futex_init+0x0/0xf9 returned 0 after 976 usecs
[    0.881002] calling  cgroup_wq_init+0x0/0x2e @ 1
[    0.882287] initcall cgroup_wq_init+0x0/0x2e returned 0 after 0 usecs
[    0.883002] calling  cgroup1_wq_init+0x0/0x2e @ 1
[    0.884288] initcall cgroup1_wq_init+0x0/0x2e returned 0 after 0 usecs
[    0.885002] calling  ftrace_mod_cmd_init+0x0/0xc @ 1
[    0.886003] initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
[    0.887002] calling  init_wakeup_tracer+0x0/0x2d @ 1
[    0.888004] initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
[    0.889001] calling  init_graph_trace+0x0/0x5d @ 1
[    0.890006] initcall init_graph_trace+0x0/0x5d returned 0 after 0 usecs
[    0.891004] calling  init_per_zone_wmark_min+0x0/0x83 @ 1
[    0.892075] initcall init_per_zone_wmark_min+0x0/0x83 returned 0 after 0 usecs
[    0.893003] calling  init_zero_pfn+0x0/0x38 @ 1
[    0.894001] initcall init_zero_pfn+0x0/0x38 returned 0 after 0 usecs
[    0.895002] calling  memory_failure_init+0x0/0x9f @ 1
[    0.896055] initcall memory_failure_init+0x0/0x9f returned 0 after 0 usecs
[    0.897002] calling  fsnotify_init+0x0/0x49 @ 1
[    0.898204] initcall fsnotify_init+0x0/0x49 returned 0 after 0 usecs
[    0.899002] calling  filelock_init+0x0/0x8c @ 1
[    0.900102] initcall filelock_init+0x0/0x8c returned 0 after 0 usecs
[    0.901002] calling  init_script_binfmt+0x0/0x16 @ 1
[    0.902003] initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.903002] calling  init_elf_binfmt+0x0/0x16 @ 1
[    0.904002] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.905002] calling  init_compat_elf_binfmt+0x0/0x16 @ 1
[    0.906002] initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.907002] calling  configfs_init+0x0/0x94 @ 1
[    0.908007] initcall configfs_init+0x0/0x94 returned 0 after 0 usecs
[    0.909002] calling  debugfs_init+0x0/0x53 @ 1
[    0.910003] initcall debugfs_init+0x0/0x53 returned 0 after 0 usecs
[    0.911001] calling  tracefs_init+0x0/0x3b @ 1
[    0.912003] initcall tracefs_init+0x0/0x3b returned 0 after 0 usecs
[    0.913001] calling  securityfs_init+0x0/0x69 @ 1
[    0.914133] initcall securityfs_init+0x0/0x69 returned 0 after 0 usecs
[    0.915002] calling  prandom_init+0x0/0xb6 @ 1
[    0.916329] initcall prandom_init+0x0/0xb6 returned 0 after 0 usecs
[    0.917002] calling  pinctrl_init+0x0/0xae @ 1
[    0.918001] pinctrl core: initialized pinctrl subsystem
[    0.919080] initcall pinctrl_init+0x0/0xae returned 0 after 976 usecs
[    0.920004] calling  iommu_init+0x0/0x2b @ 1
[    0.921003] initcall iommu_init+0x0/0x2b returned 0 after 0 usecs
[    0.922001] calling  component_debug_init+0x0/0x1d @ 1
[    0.923003] initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
[    0.924006] calling  early_resume_init+0x0/0xe0 @ 1
[    0.925051] RTC time: 14:23:06, date: 02/22/18
[    0.926002] initcall early_resume_init+0x0/0xe0 returned 0 after 976 usecs
[    0.927002] calling  opp_debug_init+0x0/0x3c @ 1
[    0.928003] initcall opp_debug_init+0x0/0x3c returned 0 after 0 usecs
[    0.929001] calling  cpufreq_core_init+0x0/0x4c @ 1
[    0.930003] initcall cpufreq_core_init+0x0/0x4c returned 0 after 0 usecs
[    0.931002] calling  cpuidle_init+0x0/0x3b @ 1
[    0.932004] initcall cpuidle_init+0x0/0x3b returned 0 after 0 usecs
[    0.933002] calling  capsule_reboot_register+0x0/0x11 @ 1
[    0.934002] initcall capsule_reboot_register+0x0/0x11 returned 0 after 0 usecs
[    0.935001] calling  bsp_pm_check_init+0x0/0x14 @ 1
[    0.936002] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
[    0.937001] calling  sock_init+0x0/0x9a @ 1
[    0.939256] initcall sock_init+0x0/0x9a returned 0 after 976 usecs
[    0.940001] calling  net_inuse_init+0x0/0x24 @ 1
[    0.941113] initcall net_inuse_init+0x0/0x24 returned 0 after 0 usecs
[    0.942001] calling  net_defaults_init+0x0/0x24 @ 1
[    0.943002] initcall net_defaults_init+0x0/0x24 returned 0 after 0 usecs
[    0.944001] calling  init_default_flow_dissectors+0x0/0x50 @ 1
[    0.945002] initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
[    0.946001] calling  netpoll_init+0x0/0x28 @ 1
[    0.947002] initcall netpoll_init+0x0/0x28 returned 0 after 0 usecs
[    0.948002] calling  netlink_proto_init+0x0/0x160 @ 1
[    0.949028] NET: Registered protocol family 16
[    0.950010] initcall netlink_proto_init+0x0/0x160 returned 0 after 976 usecs
[    0.951033] calling  irq_sysfs_init+0x0/0x94 @ 1
[    0.952083] initcall irq_sysfs_init+0x0/0x94 returned 0 after 0 usecs
[    0.953001] calling  audit_init+0x0/0x147 @ 1
[    0.954005] audit: initializing netlink subsys (disabled)
[    0.955033] initcall audit_init+0x0/0x147 returned 0 after 976 usecs
[    0.955033] audit: type=2000 audit(1519309381.955:1): state=initialized audit_enabled=0 res=1
[    0.956004] calling  bdi_class_init+0x0/0x49 @ 1
[    0.956011] initcall bdi_class_init+0x0/0x49 returned 0 after 0 usecs
[    0.959001] calling  mm_sysfs_init+0x0/0x29 @ 1
[    0.960002] initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usecs
[    0.961002] calling  pcibus_class_init+0x0/0x18 @ 1
[    0.962004] initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
[    0.963002] calling  pci_driver_init+0x0/0x11 @ 1
[    0.964008] initcall pci_driver_init+0x0/0x11 returned 0 after 0 usecs
[    0.965001] calling  backlight_class_init+0x0/0xa6 @ 1
[    0.966004] initcall backlight_class_init+0x0/0xa6 returned 0 after 0 usecs
[    0.967002] calling  tty_class_init+0x0/0x34 @ 1
[    0.968003] initcall tty_class_init+0x0/0x34 returned 0 after 0 usecs
[    0.969002] calling  vtconsole_class_init+0x0/0xd8 @ 1
[    0.970013] initcall vtconsole_class_init+0x0/0xd8 returned 0 after 0 usecs
[    0.971002] calling  iommu_dev_init+0x0/0x18 @ 1
[    0.972004] initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
[    0.973002] calling  mipi_dsi_bus_init+0x0/0x11 @ 1
[    0.974005] initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
[    0.975001] calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
[    0.976003] initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.977001] calling  register_node_type+0x0/0x2f @ 1
[    0.978010] initcall register_node_type+0x0/0x2f returned 0 after 0 usecs
[    0.979001] calling  regmap_initcall+0x0/0xd @ 1
[    0.980003] initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
[    0.981001] calling  i2c_init+0x0/0xb4 @ 1
[    0.982011] initcall i2c_init+0x0/0xb4 returned 0 after 0 usecs
[    0.983002] calling  init_menu+0x0/0x11 @ 1
[    0.984086] cpuidle: using governor menu
[    0.988006] initcall init_menu+0x0/0x11 returned 0 after 3906 usecs
[    0.994003] calling  pcc_init+0x0/0x34a @ 1
[    0.998004] Error parsing PCC subspaces from PCCT
[    1.003002] initcall pcc_init+0x0/0x34a returned -19 after 4882 usecs
[    1.009002] calling  amd_postcore_init+0x0/0x111 @ 1
[    1.014002] initcall amd_postcore_init+0x0/0x111 returned 0 after 0 usecs
[    1.021003] calling  kobject_uevent_init+0x0/0xc @ 1
[    1.026021] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
[    1.032034] calling  bts_init+0x0/0xbb @ 1
[    1.037002] initcall bts_init+0x0/0xbb returned -19 after 0 usecs
[    1.043002] calling  pt_init+0x0/0x354 @ 1
[    1.047249] initcall pt_init+0x0/0x354 returned 0 after 0 usecs
[    1.053002] calling  boot_params_ksysfs_init+0x0/0x275 @ 1
[    1.058023] initcall boot_params_ksysfs_init+0x0/0x275 returned 0 after 0 usecs
[    1.066002] calling  sbf_init+0x0/0xcb @ 1
[    1.070002] initcall sbf_init+0x0/0xcb returned 0 after 0 usecs
[    1.076002] calling  arch_kdebugfs_init+0x0/0x24c @ 1
[    1.081033] initcall arch_kdebugfs_init+0x0/0x24c returned 0 after 0 usecs
[    1.088003] calling  mtrr_if_init+0x0/0x5e @ 1
[    1.092006] initcall mtrr_if_init+0x0/0x5e returned 0 after 0 usecs
[    1.098002] calling  ffh_cstate_init+0x0/0x2a @ 1
[    1.103050] initcall ffh_cstate_init+0x0/0x2a returned 0 after 0 usecs
[    1.109002] calling  kvm_setup_pv_tlb_flush+0x0/0x64 @ 1
[    1.115004] initcall kvm_setup_pv_tlb_flush+0x0/0x64 returned 0 after 0 usecs
[    1.122002] calling  activate_jump_labels+0x0/0x32 @ 1
[    1.127002] initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
[    1.134002] calling  gigantic_pages_init+0x0/0x2f @ 1
[    1.139005] initcall gigantic_pages_init+0x0/0x2f returned 0 after 0 usecs
[    1.146002] calling  uv_rtc_setup_clock+0x0/0x242 @ 1
[    1.151002] initcall uv_rtc_setup_clock+0x0/0x242 returned -19 after 0 usecs
[    1.158002] calling  acpi_pci_init+0x0/0x62 @ 1
[    1.162001] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.170002] ACPI: bus type PCI registered
[    1.174001] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.180002] initcall acpi_pci_init+0x0/0x62 returned 0 after 17578 usecs
[    1.187002] calling  dma_bus_init+0x0/0xdd @ 1
[    1.191309] initcall dma_bus_init+0x0/0xdd returned 0 after 976 usecs
[    1.198002] calling  dma_channel_table_init+0x0/0xd7 @ 1
[    1.203108] initcall dma_channel_table_init+0x0/0xd7 returned 0 after 976 usecs
[    1.211002] calling  dmi_id_init+0x0/0x31d @ 1
[    1.215023] initcall dmi_id_init+0x0/0x31d returned 0 after 0 usecs
[    1.222002] calling  pci_arch_init+0x0/0x66 @ 1
[    1.226011] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    1.235052] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    1.236005] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mapping due to MTRR override.
[    1.237307] PCI: Using configuration type 1 for base access
[    1.238037] PCI: Dell System detected, enabling pci=bfsort.
[    1.239005] initcall pci_arch_init+0x0/0x66 returned 0 after 12695 usecs
[    1.240033] calling  init_vdso+0x0/0x34 @ 1
[    1.241019] initcall init_vdso+0x0/0x34 returned 0 after 0 usecs
[    1.242002] calling  sysenter_setup+0x0/0x14 @ 1
[    1.243002] initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
[    1.244001] calling  fixup_ht_bug+0x0/0x98 @ 1
[    1.245002] initcall fixup_ht_bug+0x0/0x98 returned 0 after 0 usecs
[    1.246002] calling  topology_init+0x0/0xbc @ 1
[    1.251128] initcall topology_init+0x0/0xbc returned 0 after 3906 usecs
[    1.252002] calling  mtrr_init_finialize+0x0/0x3f @ 1
[    1.253002] initcall mtrr_init_finialize+0x0/0x3f returned 0 after 0 usecs
[    1.254002] calling  uid_cache_init+0x0/0x93 @ 1
[    1.255065] initcall uid_cache_init+0x0/0x93 returned 0 after 0 usecs
[    1.256002] calling  param_sysfs_init+0x0/0x1b6 @ 1
[    1.257716] initcall param_sysfs_init+0x0/0x1b6 returned 0 after 0 usecs
[    1.258004] calling  user_namespace_sysctl_init+0x0/0x34 @ 1
[    1.259008] initcall user_namespace_sysctl_init+0x0/0x34 returned 0 after 0 usecs
[    1.260002] calling  pm_sysrq_init+0x0/0x19 @ 1
[    1.261052] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
[    1.262002] calling  create_proc_profile+0x0/0xd0 @ 1
[    1.263001] initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
[    1.264006] calling  crash_save_vmcoreinfo_init+0x0/0x5c3 @ 1
[    1.265026] initcall crash_save_vmcoreinfo_init+0x0/0x5c3 returned 0 after 0 usecs
[    1.266001] calling  crash_notes_memory_init+0x0/0x36 @ 1
[    1.267145] initcall crash_notes_memory_init+0x0/0x36 returned 0 after 0 usecs
[    1.268001] calling  cgroup_sysfs_init+0x0/0x18 @ 1
[    1.269003] initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    1.270001] calling  cgroup_namespaces_init+0x0/0x8 @ 1
[    1.271001] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
[    1.272001] calling  user_namespaces_init+0x0/0x2d @ 1
[    1.273005] initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
[    1.274002] calling  oom_init+0x0/0x30 @ 1
[    1.275018] initcall oom_init+0x0/0x30 returned 0 after 0 usecs
[    1.276004] calling  default_bdi_init+0x0/0xae @ 1
[    1.277100] initcall default_bdi_init+0x0/0xae returned 0 after 0 usecs
[    1.278002] calling  percpu_enable_async+0x0/0xf @ 1
[    1.279001] initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
[    1.280001] calling  kcompactd_init+0x0/0x97 @ 1
[    1.281012] initcall kcompactd_init+0x0/0x97 returned 0 after 0 usecs
[    1.282002] calling  init_reserve_notifier+0x0/0x1f @ 1
[    1.283002] initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
[    1.284004] calling  init_admin_reserve+0x0/0x40 @ 1
[    1.285002] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    1.286001] calling  init_user_reserve+0x0/0x40 @ 1
[    1.287001] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    1.288002] calling  swap_init_sysfs+0x0/0x63 @ 1
[    1.289003] initcall swap_init_sysfs+0x0/0x63 returned 0 after 0 usecs
[    1.290001] calling  swapfile_init+0x0/0xb7 @ 1
[    1.291001] initcall swapfile_init+0x0/0xb7 returned 0 after 0 usecs
[    1.292001] calling  hugetlb_init+0x0/0x528 @ 1
[    1.293004] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.294001] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.295044] initcall hugetlb_init+0x0/0x528 returned 0 after 1953 usecs
[    1.296002] calling  ksm_init+0x0/0x18b @ 1
[    1.297015] initcall ksm_init+0x0/0x18b returned 0 after 0 usecs
[    1.298002] calling  hugepage_init+0x0/0x154 @ 1
[    1.299010] initcall hugepage_init+0x0/0x154 returned 0 after 0 usecs
[    1.300002] calling  mem_cgroup_swap_init+0x0/0x52 @ 1
[    1.301003] initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
[    1.302001] calling  mem_cgroup_init+0x0/0x152 @ 1
[    1.303352] initcall mem_cgroup_init+0x0/0x152 returned 0 after 0 usecs
[    1.304003] calling  sel_ib_pkey_init+0x0/0x48 @ 1
[    1.305004] initcall sel_ib_pkey_init+0x0/0x48 returned 0 after 0 usecs
[    1.306001] calling  crypto_wq_init+0x0/0x31 @ 1
[    1.307283] initcall crypto_wq_init+0x0/0x31 returned 0 after 0 usecs
[    1.308002] calling  cryptomgr_init+0x0/0x11 @ 1
[    1.309002] initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
[    1.310001] calling  cryptd_init+0x0/0xc4 @ 1
[    1.311044] cryptd: max_cpu_qlen set to 1000
[    1.312002] initcall cryptd_init+0x0/0xc4 returned 0 after 976 usecs
[    1.313002] calling  init_bio+0x0/0xd2 @ 1
[    1.314323] initcall init_bio+0x0/0xd2 returned 0 after 0 usecs
[    1.315002] calling  blk_settings_init+0x0/0x2a @ 1
[    1.316002] initcall blk_settings_init+0x0/0x2a returned 0 after 0 usecs
[    1.317002] calling  blk_ioc_init+0x0/0x2a @ 1
[    1.318070] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
[    1.319002] calling  blk_softirq_init+0x0/0x71 @ 1
[    1.320026] initcall blk_softirq_init+0x0/0x71 returned 0 after 0 usecs
[    1.321002] calling  blk_mq_init+0x0/0x2a @ 1
[    1.322002] initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
[    1.323002] calling  genhd_device_init+0x0/0x76 @ 1
[    1.324309] initcall genhd_device_init+0x0/0x76 returned 0 after 0 usecs
[    1.325003] calling  irq_poll_setup+0x0/0x6c @ 1
[    1.326044] initcall irq_poll_setup+0x0/0x6c returned 0 after 0 usecs
[    1.327006] calling  pci_slot_init+0x0/0x50 @ 1
[    1.328003] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    1.329001] calling  fbmem_init+0x0/0xd5 @ 1
[    1.330015] initcall fbmem_init+0x0/0xd5 returned 0 after 0 usecs
[    1.331001] calling  scan_for_dmi_ipmi+0x0/0xf6 @ 1
[    1.332017] initcall scan_for_dmi_ipmi+0x0/0xf6 returned 0 after 0 usecs
[    1.333001] calling  acpi_init+0x0/0x365 @ 1
[    1.334608] ACPI: Added _OSI(Module Device)
[    1.335001] ACPI: Added _OSI(Processor Device)
[    1.336001] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.337001] ACPI: Added _OSI(Processor Aggregator Device)
[    1.358104] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.381308] ACPI: Dynamic OEM Table Load:
[    1.396108] ACPI: Dynamic OEM Table Load:
[    1.400410] ACPI: Dynamic OEM Table Load:
[    1.473265] ACPI: Interpreter enabled
[    1.474015] ACPI: (supports S0 S5)
[    1.475001] ACPI: Using IOAPIC for interrupt routing
[    1.476039] HEST: Table parsing has been initialized.
[    1.477003] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.478449] ACPI: GPE 0x6C active on init
[    1.479000] ACPI: Enabled 5 GPEs in block 00 to 7F
[    1.522382] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
[    1.529005] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.537032] acpi PNP0A08:00: PCIe AER handled by firmware
[    1.543056] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.550001] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.559208] PCI host bridge to bus 0000:00
[    1.564003] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.570002] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    1.577002] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.585001] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000cbfff window]
[    1.592001] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    1.600002] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9d7fffff window]
[    1.607003] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x380fffffffff window]
[    1.615002] pci_bus 0000:00: root bus resource [bus 00-16]
[    1.621010] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    1.627520] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    1.633490] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    1.640488] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    1.646009] pci 0000:00:05.4: reg 0x10: [mem 0x92d20000-0x92d20fff]
[    1.652488] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    1.659475] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    1.665466] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    1.672486] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
[    1.678547] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
[    1.685016] pci 0000:00:11.5: reg 0x10: [mem 0x92d16000-0x92d17fff]
[    1.691007] pci 0000:00:11.5: reg 0x14: [mem 0x92d1f000-0x92d1f0ff]
[    1.697007] pci 0000:00:11.5: reg 0x18: [io  0x2068-0x206f]
[    1.703007] pci 0000:00:11.5: reg 0x1c: [io  0x2074-0x2077]
[    1.708007] pci 0000:00:11.5: reg 0x20: [io  0x2040-0x205f]
[    1.714007] pci 0000:00:11.5: reg 0x24: [mem 0x92c80000-0x92cfffff]
[    1.720035] pci 0000:00:11.5: PME# supported from D3hot
[    1.725489] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
[    1.732021] pci 0000:00:14.0: reg 0x10: [mem 0x92d00000-0x92d0ffff 64bit]
[    1.738060] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.744486] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
[    1.751021] pci 0000:00:14.2: reg 0x10: [mem 0x92d1c000-0x92d1cfff 64bit]
[    1.758525] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
[    1.764028] pci 0000:00:16.0: reg 0x10: [mem 0x92d1b000-0x92d1bfff 64bit]
[    1.771048] pci 0000:00:16.0: PME# supported from D3hot
[    1.776488] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
[    1.783028] pci 0000:00:16.1: reg 0x10: [mem 0x92d1a000-0x92d1afff 64bit]
[    1.789080] pci 0000:00:16.1: PME# supported from D3hot
[    1.795470] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
[    1.801027] pci 0000:00:16.4: reg 0x10: [mem 0x92d19000-0x92d19fff 64bit]
[    1.808080] pci 0000:00:16.4: PME# supported from D3hot
[    1.813468] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
[    1.820016] pci 0000:00:17.0: reg 0x10: [mem 0x92d14000-0x92d15fff]
[    1.826007] pci 0000:00:17.0: reg 0x14: [mem 0x92d1e000-0x92d1e0ff]
[    1.832007] pci 0000:00:17.0: reg 0x18: [io  0x2060-0x2067]
[    1.838008] pci 0000:00:17.0: reg 0x1c: [io  0x2070-0x2073]
[    1.843007] pci 0000:00:17.0: reg 0x20: [io  0x2020-0x203f]
[    1.849007] pci 0000:00:17.0: reg 0x24: [mem 0x92c00000-0x92c7ffff]
[    1.855035] pci 0000:00:17.0: PME# supported from D3hot
[    1.860486] pci 0000:00:1c.0: [8086:a190] type 01 class 0x060400
[    1.867061] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.873507] pci 0000:00:1c.4: [8086:a194] type 01 class 0x060400
[    1.879060] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.885510] pci 0000:00:1f.0: [8086:a1c1] type 00 class 0x060100
[    1.892580] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
[    1.899015] pci 0000:00:1f.2: reg 0x10: [mem 0x92d10000-0x92d13fff]
[    1.905525] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
[    1.911019] pci 0000:00:1f.4: reg 0x10: [mem 0x92d18000-0x92d180ff 64bit]
[    1.918022] pci 0000:00:1f.4: reg 0x20: [io  0x2000-0x201f]
[    1.924480] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
[    1.930016] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    1.936550] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.942005] pci 0000:00:1c.0:   bridge window [mem 0x92a00000-0x92bfffff]
[    1.949048] pci 0000:02:00.0: [1556:be00] type 01 class 0x060400
[    1.958022] pci 0000:00:1c.4: PCI bridge to [bus 02-03]
[    1.963005] pci 0000:00:1c.4:   bridge window [mem 0x92000000-0x928fffff]
[    1.970004] pci 0000:00:1c.4:   bridge window [mem 0x91000000-0x91ffffff 64bit pref]
[    1.977043] pci 0000:03:00.0: [102b:0536] type 00 class 0x030000
[    1.983023] pci 0000:03:00.0: reg 0x10: [mem 0x91000000-0x91ffffff pref]
[    1.990011] pci 0000:03:00.0: reg 0x14: [mem 0x92808000-0x9280bfff]
[    1.996010] pci 0000:03:00.0: reg 0x18: [mem 0x92000000-0x927fffff]
[    2.002046] pci 0000:03:00.0: BAR 0: assigned to efifb
[    2.008086] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.013008] pci 0000:02:00.0:   bridge window [mem 0x92000000-0x928fffff]
[    2.019006] pci 0000:02:00.0:   bridge window [mem 0x91000000-0x91ffffff 64bit pref]
[    2.027016] pci_bus 0000:00: on NUMA node 0
[    2.031206] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    2.038054] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *6 10 11 12 14 15)
[    2.045052] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12 14 15)
[    2.052052] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    2.059052] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    2.066052] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 10 11 12 14 15)
[    2.073052] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 10 11 12 14 15)
[    2.080053] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    2.087257] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
[    2.093003] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.101041] acpi PNP0A08:01: PCIe AER handled by firmware
[    2.107100] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.114001] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.123103] PCI host bridge to bus 0000:17
[    2.124003] pci_bus 0000:17: root bus resource [io  0x4000-0x5fff window]
[    2.125002] pci_bus 0000:17: root bus resource [mem 0x9d800000-0xaaffffff window]
[    2.126001] pci_bus 0000:17: root bus resource [mem 0x381000000000-0x381fffffffff window]
[    2.127002] pci_bus 0000:17: root bus resource [bus 17-39]
[    2.128009] pci 0000:17:00.0: [8086:2030] type 01 class 0x060400
[    2.129082] pci 0000:17:00.0: PME# supported from D0 D3hot D3cold
[    2.130090] pci 0000:17:02.0: [8086:2032] type 01 class 0x060400
[    2.131022] pci 0000:17:02.0: enabling Extended Tags
[    2.132055] pci 0000:17:02.0: PME# supported from D0 D3hot D3cold
[    2.133057] pci 0000:17:03.0: [8086:2033] type 01 class 0x060400
[    2.134021] pci 0000:17:03.0: enabling Extended Tags
[    2.135054] pci 0000:17:03.0: PME# supported from D0 D3hot D3cold
[    2.136053] pci 0000:17:05.0: [8086:2034] type 00 class 0x088000
[    2.137095] pci 0000:17:05.2: [8086:2035] type 00 class 0x088000
[    2.138093] pci 0000:17:05.4: [8086:2036] type 00 class 0x080020
[    2.139008] pci 0000:17:05.4: reg 0x10: [mem 0x9e500000-0x9e500fff]
[    2.140092] pci 0000:17:08.0: [8086:208d] type 00 class 0x088000
[    2.141074] pci 0000:17:08.1: [8086:208d] type 00 class 0x088000
[    2.142071] pci 0000:17:08.2: [8086:208d] type 00 class 0x088000
[    2.143070] pci 0000:17:08.3: [8086:208d] type 00 class 0x088000
[    2.144071] pci 0000:17:08.4: [8086:208d] type 00 class 0x088000
[    2.145069] pci 0000:17:08.5: [8086:208d] type 00 class 0x088000
[    2.146069] pci 0000:17:08.6: [8086:208d] type 00 class 0x088000
[    2.147070] pci 0000:17:08.7: [8086:208d] type 00 class 0x088000
[    2.148069] pci 0000:17:09.0: [8086:208d] type 00 class 0x088000
[    2.149073] pci 0000:17:09.1: [8086:208d] type 00 class 0x088000
[    2.150070] pci 0000:17:09.2: [8086:208d] type 00 class 0x088000
[    2.151069] pci 0000:17:09.3: [8086:208d] type 00 class 0x088000
[    2.152070] pci 0000:17:09.4: [8086:208d] type 00 class 0x088000
[    2.153069] pci 0000:17:09.5: [8086:208d] type 00 class 0x088000
[    2.154070] pci 0000:17:09.6: [8086:208d] type 00 class 0x088000
[    2.155071] pci 0000:17:09.7: [8086:208d] type 00 class 0x088000
[    2.156069] pci 0000:17:0a.0: [8086:208d] type 00 class 0x088000
[    2.157073] pci 0000:17:0a.1: [8086:208d] type 00 class 0x088000
[    2.158069] pci 0000:17:0a.2: [8086:208d] type 00 class 0x088000
[    2.159072] pci 0000:17:0a.3: [8086:208d] type 00 class 0x088000
[    2.160071] pci 0000:17:0a.4: [8086:208d] type 00 class 0x088000
[    2.161070] pci 0000:17:0a.5: [8086:208d] type 00 class 0x088000
[    2.162071] pci 0000:17:0a.6: [8086:208d] type 00 class 0x088000
[    2.163071] pci 0000:17:0a.7: [8086:208d] type 00 class 0x088000
[    2.164072] pci 0000:17:0b.0: [8086:208d] type 00 class 0x088000
[    2.165075] pci 0000:17:0b.1: [8086:208d] type 00 class 0x088000
[    2.166071] pci 0000:17:0b.2: [8086:208d] type 00 class 0x088000
[    2.167071] pci 0000:17:0b.3: [8086:208d] type 00 class 0x088000
[    2.168073] pci 0000:17:0e.0: [8086:208e] type 00 class 0x088000
[    2.169075] pci 0000:17:0e.1: [8086:208e] type 00 class 0x088000
[    2.170071] pci 0000:17:0e.2: [8086:208e] type 00 class 0x088000
[    2.171071] pci 0000:17:0e.3: [8086:208e] type 00 class 0x088000
[    2.172071] pci 0000:17:0e.4: [8086:208e] type 00 class 0x088000
[    2.173070] pci 0000:17:0e.5: [8086:208e] type 00 class 0x088000
[    2.174070] pci 0000:17:0e.6: [8086:208e] type 00 class 0x088000
[    2.175071] pci 0000:17:0e.7: [8086:208e] type 00 class 0x088000
[    2.176069] pci 0000:17:0f.0: [8086:208e] type 00 class 0x088000
[    2.177073] pci 0000:17:0f.1: [8086:208e] type 00 class 0x088000
[    2.178070] pci 0000:17:0f.2: [8086:208e] type 00 class 0x088000
[    2.179073] pci 0000:17:0f.3: [8086:208e] type 00 class 0x088000
[    2.180071] pci 0000:17:0f.4: [8086:208e] type 00 class 0x088000
[    2.181070] pci 0000:17:0f.5: [8086:208e] type 00 class 0x088000
[    2.182071] pci 0000:17:0f.6: [8086:208e] type 00 class 0x088000
[    2.183070] pci 0000:17:0f.7: [8086:208e] type 00 class 0x088000
[    2.184071] pci 0000:17:10.0: [8086:208e] type 00 class 0x088000
[    2.185075] pci 0000:17:10.1: [8086:208e] type 00 class 0x088000
[    2.186071] pci 0000:17:10.2: [8086:208e] type 00 class 0x088000
[    2.187073] pci 0000:17:10.3: [8086:208e] type 00 class 0x088000
[    2.188071] pci 0000:17:10.4: [8086:208e] type 00 class 0x088000
[    2.189070] pci 0000:17:10.5: [8086:208e] type 00 class 0x088000
[    2.190072] pci 0000:17:10.6: [8086:208e] type 00 class 0x088000
[    2.191070] pci 0000:17:10.7: [8086:208e] type 00 class 0x088000
[    2.192072] pci 0000:17:11.0: [8086:208e] type 00 class 0x088000
[    2.193075] pci 0000:17:11.1: [8086:208e] type 00 class 0x088000
[    2.194071] pci 0000:17:11.2: [8086:208e] type 00 class 0x088000
[    2.195071] pci 0000:17:11.3: [8086:208e] type 00 class 0x088000
[    2.196081] pci 0000:17:1d.0: [8086:2054] type 00 class 0x088000
[    2.197075] pci 0000:17:1d.1: [8086:2055] type 00 class 0x088000
[    2.198072] pci 0000:17:1d.2: [8086:2056] type 00 class 0x088000
[    2.199071] pci 0000:17:1d.3: [8086:2057] type 00 class 0x088000
[    2.200075] pci 0000:17:1e.0: [8086:2080] type 00 class 0x088000
[    2.201073] pci 0000:17:1e.1: [8086:2081] type 00 class 0x088000
[    2.202072] pci 0000:17:1e.2: [8086:2082] type 00 class 0x088000
[    2.203078] pci 0000:17:1e.3: [8086:2083] type 00 class 0x088000
[    2.204071] pci 0000:17:1e.4: [8086:2084] type 00 class 0x088000
[    2.205071] pci 0000:17:1e.5: [8086:2085] type 00 class 0x088000
[    2.206070] pci 0000:17:1e.6: [8086:2086] type 00 class 0x088000
[    2.207100] pci 0000:18:00.0: [1000:005d] type 00 class 0x010400
[    2.208011] pci 0000:18:00.0: reg 0x10: [io  0x4000-0x40ff]
[    2.209007] pci 0000:18:00.0: reg 0x14: [mem 0x9e400000-0x9e40ffff 64bit]
[    2.210007] pci 0000:18:00.0: reg 0x1c: [mem 0x9e300000-0x9e3fffff 64bit]
[    2.211009] pci 0000:18:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    2.212069] pci 0000:18:00.0: supports D1 D2
[    2.213036] pci 0000:17:00.0: PCI bridge to [bus 18]
[    2.214002] pci 0000:17:00.0:   bridge window [io  0x4000-0x4fff]
[    2.215002] pci 0000:17:00.0:   bridge window [mem 0x9e300000-0x9e4fffff]
[    2.216097] pci 0000:19:00.0: [8086:1563] type 00 class 0x020000
[    2.217021] pci 0000:19:00.0: reg 0x10: [mem 0x9dc00000-0x9dffffff 64bit pref]
[    2.218020] pci 0000:19:00.0: reg 0x20: [mem 0x9e004000-0x9e007fff 64bit pref]
[    2.219007] pci 0000:19:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.220084] pci 0000:19:00.0: PME# supported from D0 D3hot D3cold
[    2.221109] pci 0000:19:00.1: [8086:1563] type 00 class 0x020000
[    2.222020] pci 0000:19:00.1: reg 0x10: [mem 0x9d800000-0x9dbfffff 64bit pref]
[    2.223020] pci 0000:19:00.1: reg 0x20: [mem 0x9e000000-0x9e003fff 64bit pref]
[    2.224007] pci 0000:19:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.225080] pci 0000:19:00.1: PME# supported from D0 D3hot D3cold
[    2.229027] pci 0000:17:02.0: PCI bridge to [bus 19]
[    2.230005] pci 0000:17:02.0:   bridge window [mem 0x9d800000-0x9e0fffff 64bit pref]
[    2.231042] pci 0000:1a:00.0: [8086:1521] type 00 class 0x020000
[    2.232018] pci 0000:1a:00.0: reg 0x10: [mem 0x9e180000-0x9e1fffff]
[    2.233018] pci 0000:1a:00.0: reg 0x1c: [mem 0x9e204000-0x9e207fff]
[    2.234018] pci 0000:1a:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.235083] pci 0000:1a:00.0: PME# supported from D0 D3hot D3cold
[    2.236086] pci 0000:1a:00.1: [8086:1521] type 00 class 0x020000
[    2.237017] pci 0000:1a:00.1: reg 0x10: [mem 0x9e100000-0x9e17ffff]
[    2.238018] pci 0000:1a:00.1: reg 0x1c: [mem 0x9e200000-0x9e203fff]
[    2.239018] pci 0000:1a:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    2.240078] pci 0000:1a:00.1: PME# supported from D0 D3hot D3cold
[    2.244023] pci 0000:17:03.0: PCI bridge to [bus 1a]
[    2.245003] pci 0000:17:03.0:   bridge window [mem 0x9e100000-0x9e2fffff]
[    2.246017] pci_bus 0000:17: on NUMA node 0
[    2.247100] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
[    2.248003] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.249041] acpi PNP0A08:02: PCIe AER handled by firmware
[    2.250087] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.251001] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.252126] PCI host bridge to bus 0000:3a
[    2.253002] pci_bus 0000:3a: root bus resource [io  0x6000-0x7fff window]
[    2.254001] pci_bus 0000:3a: root bus resource [mem 0xab000000-0xb87fffff window]
[    2.255001] pci_bus 0000:3a: root bus resource [mem 0x382000000000-0x382fffffffff window]
[    2.256001] pci_bus 0000:3a: root bus resource [bus 3a-5c]
[    2.257008] pci 0000:3a:05.0: [8086:2034] type 00 class 0x088000
[    2.258090] pci 0000:3a:05.2: [8086:2035] type 00 class 0x088000
[    2.259087] pci 0000:3a:05.4: [8086:2036] type 00 class 0x080020
[    2.260008] pci 0000:3a:05.4: reg 0x10: [mem 0xab000000-0xab000fff]
[    2.261088] pci 0000:3a:08.0: [8086:2066] type 00 class 0x088000
[    2.262080] pci 0000:3a:09.0: [8086:2066] type 00 class 0x088000
[    2.263081] pci 0000:3a:0a.0: [8086:2040] type 00 class 0x088000
[    2.264078] pci 0000:3a:0a.1: [8086:2041] type 00 class 0x088000
[    2.265075] pci 0000:3a:0a.2: [8086:2042] type 00 class 0x088000
[    2.266076] pci 0000:3a:0a.3: [8086:2043] type 00 class 0x088000
[    2.267075] pci 0000:3a:0a.4: [8086:2044] type 00 class 0x088000
[    2.268074] pci 0000:3a:0a.5: [8086:2045] type 00 class 0x088000
[    2.269075] pci 0000:3a:0a.6: [8086:2046] type 00 class 0x088000
[    2.270076] pci 0000:3a:0a.7: [8086:2047] type 00 class 0x088000
[    2.271074] pci 0000:3a:0b.0: [8086:2048] type 00 class 0x088000
[    2.272078] pci 0000:3a:0b.1: [8086:2049] type 00 class 0x088000
[    2.273076] pci 0000:3a:0b.2: [8086:204a] type 00 class 0x088000
[    2.274075] pci 0000:3a:0b.3: [8086:204b] type 00 class 0x088000
[    2.275077] pci 0000:3a:0c.0: [8086:2040] type 00 class 0x088000
[    2.276080] pci 0000:3a:0c.1: [8086:2041] type 00 class 0x088000
[    2.277076] pci 0000:3a:0c.2: [8086:2042] type 00 class 0x088000
[    2.278078] pci 0000:3a:0c.3: [8086:2043] type 00 class 0x088000
[    2.279077] pci 0000:3a:0c.4: [8086:2044] type 00 class 0x088000
[    2.280075] pci 0000:3a:0c.5: [8086:2045] type 00 class 0x088000
[    2.281077] pci 0000:3a:0c.6: [8086:2046] type 00 class 0x088000
[    2.282078] pci 0000:3a:0c.7: [8086:2047] type 00 class 0x088000
[    2.283076] pci 0000:3a:0d.0: [8086:2048] type 00 class 0x088000
[    2.284079] pci 0000:3a:0d.1: [8086:2049] type 00 class 0x088000
[    2.285077] pci 0000:3a:0d.2: [8086:204a] type 00 class 0x088000
[    2.286078] pci 0000:3a:0d.3: [8086:204b] type 00 class 0x088000
[    2.287084] pci_bus 0000:3a: on NUMA node 0
[    2.288064] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 5d-7f])
[    2.289002] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.290039] acpi PNP0A08:03: PCIe AER handled by firmware
[    2.291086] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.292001] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.293150] PCI host bridge to bus 0000:5d
[    2.294002] pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
[    2.295002] pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
[    2.296001] pci_bus 0000:5d: root bus resource [mem 0x383000000000-0x383fffffffff window]
[    2.297001] pci_bus 0000:5d: root bus resource [bus 5d-7f]
[    2.298008] pci 0000:5d:05.0: [8086:2034] type 00 class 0x088000
[    2.299094] pci 0000:5d:05.2: [8086:2035] type 00 class 0x088000
[    2.300089] pci 0000:5d:05.4: [8086:2036] type 00 class 0x080020
[    2.301009] pci 0000:5d:05.4: reg 0x10: [mem 0xb8800000-0xb8800fff]
[    2.302094] pci 0000:5d:0e.0: [8086:2058] type 00 class 0x110100
[    2.303078] pci 0000:5d:0e.1: [8086:2059] type 00 class 0x088000
[    2.304076] pci 0000:5d:0f.0: [8086:2058] type 00 class 0x110100
[    2.305077] pci 0000:5d:0f.1: [8086:2059] type 00 class 0x088000
[    2.306076] pci 0000:5d:10.0: [8086:2058] type 00 class 0x110100
[    2.307077] pci 0000:5d:10.1: [8086:2059] type 00 class 0x088000
[    2.308078] pci 0000:5d:12.0: [8086:204c] type 00 class 0x110100
[    2.309076] pci 0000:5d:12.1: [8086:204d] type 00 class 0x110100
[    2.310064] pci 0000:5d:12.2: [8086:204e] type 00 class 0x088000
[    2.311066] pci 0000:5d:12.4: [8086:204c] type 00 class 0x110100
[    2.312074] pci 0000:5d:12.5: [8086:204d] type 00 class 0x110100
[    2.313065] pci 0000:5d:15.0: [8086:2018] type 00 class 0x088000
[    2.314069] pci 0000:5d:16.0: [8086:2018] type 00 class 0x088000
[    2.315067] pci 0000:5d:16.4: [8086:2018] type 00 class 0x088000
[    2.316067] pci 0000:5d:17.0: [8086:2018] type 00 class 0x088000
[    2.317073] pci_bus 0000:5d: on NUMA node 0
[    2.318116] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-84])
[    2.319002] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.320040] acpi PNP0A08:06: PCIe AER handled by firmware
[    2.321087] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.322001] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.323029] acpi PNP0A08:06: host bridge window [io  0x0000 window] (ignored, not CPU addressable)
[    2.324074] PCI host bridge to bus 0000:80
[    2.325002] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xd37fffff window]
[    2.326001] pci_bus 0000:80: root bus resource [mem 0x384000000000-0x384fffffffff window]
[    2.327001] pci_bus 0000:80: root bus resource [bus 80-84]
[    2.328009] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
[    2.329075] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
[    2.330069] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
[    2.331009] pci 0000:80:05.4: reg 0x10: [mem 0xc6000000-0xc6000fff]
[    2.332070] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
[    2.333060] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
[    2.334049] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
[    2.335062] pci_bus 0000:80: on NUMA node 1
[    2.336055] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 85-ad])
[    2.337002] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.338041] acpi PNP0A08:07: PCIe AER handled by firmware
[    2.339089] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.340001] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.341165] PCI host bridge to bus 0000:85
[    2.342002] pci_bus 0000:85: root bus resource [io  0xa000-0xbfff window]
[    2.343001] pci_bus 0000:85: root bus resource [mem 0xd3800000-0xe0ffffff window]
[    2.344001] pci_bus 0000:85: root bus resource [mem 0x385000000000-0x385fffffffff window]
[    2.345001] pci_bus 0000:85: root bus resource [bus 85-ad]
[    2.346008] pci 0000:85:00.0: [8086:2030] type 01 class 0x060400
[    2.347025] pci 0000:85:00.0: enabling Extended Tags
[    2.348062] pci 0000:85:00.0: PME# supported from D0 D3hot D3cold
[    2.349080] pci 0000:85:01.0: [8086:2031] type 01 class 0x060400
[    2.350025] pci 0000:85:01.0: enabling Extended Tags
[    2.351058] pci 0000:85:01.0: PME# supported from D0 D3hot D3cold
[    2.352058] pci 0000:85:02.0: [8086:2032] type 01 class 0x060400
[    2.353024] pci 0000:85:02.0: enabling Extended Tags
[    2.354058] pci 0000:85:02.0: PME# supported from D0 D3hot D3cold
[    2.355075] pci 0000:85:03.0: [8086:2033] type 01 class 0x060400
[    2.356024] pci 0000:85:03.0: enabling Extended Tags
[    2.357057] pci 0000:85:03.0: PME# supported from D0 D3hot D3cold
[    2.358053] pci 0000:85:05.0: [8086:2034] type 00 class 0x088000
[    2.359097] pci 0000:85:05.2: [8086:2035] type 00 class 0x088000
[    2.360095] pci 0000:85:05.4: [8086:2036] type 00 class 0x080020
[    2.361009] pci 0000:85:05.4: reg 0x10: [mem 0xd4000000-0xd4000fff]
[    2.362096] pci 0000:85:08.0: [8086:208d] type 00 class 0x088000
[    2.363077] pci 0000:85:08.1: [8086:208d] type 00 class 0x088000
[    2.364074] pci 0000:85:08.2: [8086:208d] type 00 class 0x088000
[    2.365072] pci 0000:85:08.3: [8086:208d] type 00 class 0x088000
[    2.366073] pci 0000:85:08.4: [8086:208d] type 00 class 0x088000
[    2.367071] pci 0000:85:08.5: [8086:208d] type 00 class 0x088000
[    2.368072] pci 0000:85:08.6: [8086:208d] type 00 class 0x088000
[    2.369072] pci 0000:85:08.7: [8086:208d] type 00 class 0x088000
[    2.370072] pci 0000:85:09.0: [8086:208d] type 00 class 0x088000
[    2.371076] pci 0000:85:09.1: [8086:208d] type 00 class 0x088000
[    2.372071] pci 0000:85:09.2: [8086:208d] type 00 class 0x088000
[    2.373073] pci 0000:85:09.3: [8086:208d] type 00 class 0x088000
[    2.374073] pci 0000:85:09.4: [8086:208d] type 00 class 0x088000
[    2.375078] pci 0000:85:09.5: [8086:208d] type 00 class 0x088000
[    2.376073] pci 0000:85:09.6: [8086:208d] type 00 class 0x088000
[    2.377071] pci 0000:85:09.7: [8086:208d] type 00 class 0x088000
[    2.378073] pci 0000:85:0a.0: [8086:208d] type 00 class 0x088000
[    2.379076] pci 0000:85:0a.1: [8086:208d] type 00 class 0x088000
[    2.380072] pci 0000:85:0a.2: [8086:208d] type 00 class 0x088000
[    2.381073] pci 0000:85:0a.3: [8086:208d] type 00 class 0x088000
[    2.382073] pci 0000:85:0a.4: [8086:208d] type 00 class 0x088000
[    2.383072] pci 0000:85:0a.5: [8086:208d] type 00 class 0x088000
[    2.384074] pci 0000:85:0a.6: [8086:208d] type 00 class 0x088000
[    2.385072] pci 0000:85:0a.7: [8086:208d] type 00 class 0x088000
[    2.386073] pci 0000:85:0b.0: [8086:208d] type 00 class 0x088000
[    2.387077] pci 0000:85:0b.1: [8086:208d] type 00 class 0x088000
[    2.388072] pci 0000:85:0b.2: [8086:208d] type 00 class 0x088000
[    2.389073] pci 0000:85:0b.3: [8086:208d] type 00 class 0x088000
[    2.390076] pci 0000:85:0e.0: [8086:208e] type 00 class 0x088000
[    2.391075] pci 0000:85:0e.1: [8086:208e] type 00 class 0x088000
[    2.392073] pci 0000:85:0e.2: [8086:208e] type 00 class 0x088000
[    2.393071] pci 0000:85:0e.3: [8086:208e] type 00 class 0x088000
[    2.394072] pci 0000:85:0e.4: [8086:208e] type 00 class 0x088000
[    2.395071] pci 0000:85:0e.5: [8086:208e] type 00 class 0x088000
[    2.396072] pci 0000:85:0e.6: [8086:208e] type 00 class 0x088000
[    2.397073] pci 0000:85:0e.7: [8086:208e] type 00 class 0x088000
[    2.398071] pci 0000:85:0f.0: [8086:208e] type 00 class 0x088000
[    2.399075] pci 0000:85:0f.1: [8086:208e] type 00 class 0x088000
[    2.400071] pci 0000:85:0f.2: [8086:208e] type 00 class 0x088000
[    2.401072] pci 0000:85:0f.3: [8086:208e] type 00 class 0x088000
[    2.402073] pci 0000:85:0f.4: [8086:208e] type 00 class 0x088000
[    2.403071] pci 0000:85:0f.5: [8086:208e] type 00 class 0x088000
[    2.404073] pci 0000:85:0f.6: [8086:208e] type 00 class 0x088000
[    2.405072] pci 0000:85:0f.7: [8086:208e] type 00 class 0x088000
[    2.406073] pci 0000:85:10.0: [8086:208e] type 00 class 0x088000
[    2.407076] pci 0000:85:10.1: [8086:208e] type 00 class 0x088000
[    2.408073] pci 0000:85:10.2: [8086:208e] type 00 class 0x088000
[    2.409073] pci 0000:85:10.3: [8086:208e] type 00 class 0x088000
[    2.410072] pci 0000:85:10.4: [8086:208e] type 00 class 0x088000
[    2.411073] pci 0000:85:10.5: [8086:208e] type 00 class 0x088000
[    2.412074] pci 0000:85:10.6: [8086:208e] type 00 class 0x088000
[    2.413073] pci 0000:85:10.7: [8086:208e] type 00 class 0x088000
[    2.414073] pci 0000:85:11.0: [8086:208e] type 00 class 0x088000
[    2.415076] pci 0000:85:11.1: [8086:208e] type 00 class 0x088000
[    2.416073] pci 0000:85:11.2: [8086:208e] type 00 class 0x088000
[    2.417072] pci 0000:85:11.3: [8086:208e] type 00 class 0x088000
[    2.418084] pci 0000:85:1d.0: [8086:2054] type 00 class 0x088000
[    2.419076] pci 0000:85:1d.1: [8086:2055] type 00 class 0x088000
[    2.420075] pci 0000:85:1d.2: [8086:2056] type 00 class 0x088000
[    2.421073] pci 0000:85:1d.3: [8086:2057] type 00 class 0x088000
[    2.422077] pci 0000:85:1e.0: [8086:2080] type 00 class 0x088000
[    2.423075] pci 0000:85:1e.1: [8086:2081] type 00 class 0x088000
[    2.424073] pci 0000:85:1e.2: [8086:2082] type 00 class 0x088000
[    2.425073] pci 0000:85:1e.3: [8086:2083] type 00 class 0x088000
[    2.426073] pci 0000:85:1e.4: [8086:2084] type 00 class 0x088000
[    2.427073] pci 0000:85:1e.5: [8086:2085] type 00 class 0x088000
[    2.428072] pci 0000:85:1e.6: [8086:2086] type 00 class 0x088000
[    2.429102] pci 0000:85:00.0: PCI bridge to [bus 86]
[    2.430003] pci 0000:85:00.0:   bridge window [mem 0xd3e00000-0xd3ffffff]
[    2.431032] pci 0000:85:01.0: PCI bridge to [bus 87]
[    2.432003] pci 0000:85:01.0:   bridge window [mem 0xd3c00000-0xd3dfffff]
[    2.433031] pci 0000:85:02.0: PCI bridge to [bus 88]
[    2.434003] pci 0000:85:02.0:   bridge window [mem 0xd3a00000-0xd3bfffff]
[    2.435029] pci 0000:85:03.0: PCI bridge to [bus 89]
[    2.436003] pci 0000:85:03.0:   bridge window [mem 0xd3800000-0xd39fffff]
[    2.437019] pci_bus 0000:85: on NUMA node 1
[    2.438083] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus ae-d6])
[    2.439003] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.440040] acpi PNP0A08:08: PCIe AER handled by firmware
[    2.441087] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.442001] acpi PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.443118] PCI host bridge to bus 0000:ae
[    2.444002] pci_bus 0000:ae: root bus resource [io  0xc000-0xdfff window]
[    2.445001] pci_bus 0000:ae: root bus resource [mem 0xe1000000-0xee7fffff window]
[    2.446001] pci_bus 0000:ae: root bus resource [mem 0x386000000000-0x386fffffffff window]
[    2.447001] pci_bus 0000:ae: root bus resource [bus ae-d6]
[    2.448008] pci 0000:ae:00.0: [8086:2030] type 01 class 0x060400
[    2.449024] pci 0000:ae:00.0: enabling Extended Tags
[    2.450059] pci 0000:ae:00.0: PME# supported from D0 D3hot D3cold
[    2.451073] pci 0000:ae:01.0: [8086:2031] type 01 class 0x060400
[    2.452024] pci 0000:ae:01.0: enabling Extended Tags
[    2.453057] pci 0000:ae:01.0: PME# supported from D0 D3hot D3cold
[    2.454051] pci 0000:ae:02.0: [8086:2032] type 01 class 0x060400
[    2.455024] pci 0000:ae:02.0: enabling Extended Tags
[    2.456057] pci 0000:ae:02.0: PME# supported from D0 D3hot D3cold
[    2.457049] pci 0000:ae:03.0: [8086:2033] type 01 class 0x060400
[    2.458024] pci 0000:ae:03.0: enabling Extended Tags
[    2.459057] pci 0000:ae:03.0: PME# supported from D0 D3hot D3cold
[    2.460048] pci 0000:ae:05.0: [8086:2034] type 00 class 0x088000
[    2.461091] pci 0000:ae:05.2: [8086:2035] type 00 class 0x088000
[    2.462089] pci 0000:ae:05.4: [8086:2036] type 00 class 0x080020
[    2.463009] pci 0000:ae:05.4: reg 0x10: [mem 0xe1800000-0xe1800fff]
[    2.464091] pci 0000:ae:08.0: [8086:2066] type 00 class 0x088000
[    2.465086] pci 0000:ae:09.0: [8086:2066] type 00 class 0x088000
[    2.466086] pci 0000:ae:0a.0: [8086:2040] type 00 class 0x088000
[    2.467083] pci 0000:ae:0a.1: [8086:2041] type 00 class 0x088000
[    2.468081] pci 0000:ae:0a.2: [8086:2042] type 00 class 0x088000
[    2.469081] pci 0000:ae:0a.3: [8086:2043] type 00 class 0x088000
[    2.470080] pci 0000:ae:0a.4: [8086:2044] type 00 class 0x088000
[    2.471080] pci 0000:ae:0a.5: [8086:2045] type 00 class 0x088000
[    2.472080] pci 0000:ae:0a.6: [8086:2046] type 00 class 0x088000
[    2.473080] pci 0000:ae:0a.7: [8086:2047] type 00 class 0x088000
[    2.474081] pci 0000:ae:0b.0: [8086:2048] type 00 class 0x088000
[    2.475084] pci 0000:ae:0b.1: [8086:2049] type 00 class 0x088000
[    2.476080] pci 0000:ae:0b.2: [8086:204a] type 00 class 0x088000
[    2.477081] pci 0000:ae:0b.3: [8086:204b] type 00 class 0x088000
[    2.478083] pci 0000:ae:0c.0: [8086:2040] type 00 class 0x088000
[    2.479085] pci 0000:ae:0c.1: [8086:2041] type 00 class 0x088000
[    2.480083] pci 0000:ae:0c.2: [8086:2042] type 00 class 0x088000
[    2.481082] pci 0000:ae:0c.3: [8086:2043] type 00 class 0x088000
[    2.482082] pci 0000:ae:0c.4: [8086:2044] type 00 class 0x088000
[    2.483080] pci 0000:ae:0c.5: [8086:2045] type 00 class 0x088000
[    2.484081] pci 0000:ae:0c.6: [8086:2046] type 00 class 0x088000
[    2.485081] pci 0000:ae:0c.7: [8086:2047] type 00 class 0x088000
[    2.486080] pci 0000:ae:0d.0: [8086:2048] type 00 class 0x088000
[    2.487084] pci 0000:ae:0d.1: [8086:2049] type 00 class 0x088000
[    2.488081] pci 0000:ae:0d.2: [8086:204a] type 00 class 0x088000
[    2.489081] pci 0000:ae:0d.3: [8086:204b] type 00 class 0x088000
[    2.490121] pci 0000:ae:00.0: PCI bridge to [bus af]
[    2.491003] pci 0000:ae:00.0:   bridge window [mem 0xe1600000-0xe17fffff]
[    2.492036] pci 0000:ae:01.0: PCI bridge to [bus b0]
[    2.493003] pci 0000:ae:01.0:   bridge window [mem 0xe1400000-0xe15fffff]
[    2.494029] pci 0000:ae:02.0: PCI bridge to [bus b1]
[    2.495003] pci 0000:ae:02.0:   bridge window [mem 0xe1200000-0xe13fffff]
[    2.496029] pci 0000:ae:03.0: PCI bridge to [bus b2]
[    2.497003] pci 0000:ae:03.0:   bridge window [mem 0xe1000000-0xe11fffff]
[    2.498019] pci_bus 0000:ae: on NUMA node 1
[    2.499093] ACPI: PCI Root Bridge [PC09] (domain 0000 [bus d7-ff])
[    2.500003] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.501040] acpi PNP0A08:09: PCIe AER handled by firmware
[    2.502086] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    2.503001] acpi PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.504125] PCI host bridge to bus 0000:d7
[    2.505002] pci_bus 0000:d7: root bus resource [io  0xe000-0xffff window]
[    2.506001] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xfbffffff window]
[    2.507001] pci_bus 0000:d7: root bus resource [mem 0x387000000000-0x387fffffffff window]
[    2.508001] pci_bus 0000:d7: root bus resource [bus d7-ff]
[    2.509009] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
[    2.510097] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
[    2.511094] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
[    2.512009] pci 0000:d7:05.4: reg 0x10: [mem 0xee800000-0xee800fff]
[    2.513098] pci 0000:d7:0e.0: [8086:2058] type 00 class 0x110100
[    2.514081] pci 0000:d7:0e.1: [8086:2059] type 00 class 0x088000
[    2.515082] pci 0000:d7:0f.0: [8086:2058] type 00 class 0x110100
[    2.516081] pci 0000:d7:0f.1: [8086:2059] type 00 class 0x088000
[    2.517082] pci 0000:d7:10.0: [8086:2058] type 00 class 0x110100
[    2.518081] pci 0000:d7:10.1: [8086:2059] type 00 class 0x088000
[    2.519083] pci 0000:d7:12.0: [8086:204c] type 00 class 0x110100
[    2.520081] pci 0000:d7:12.1: [8086:204d] type 00 class 0x110100
[    2.521066] pci 0000:d7:12.2: [8086:204e] type 00 class 0x088000
[    2.522069] pci 0000:d7:12.4: [8086:204c] type 00 class 0x110100
[    2.523078] pci 0000:d7:12.5: [8086:204d] type 00 class 0x110100
[    2.524071] pci 0000:d7:15.0: [8086:2018] type 00 class 0x088000
[    2.525074] pci 0000:d7:16.0: [8086:2018] type 00 class 0x088000
[    2.526070] pci 0000:d7:16.4: [8086:2018] type 00 class 0x088000
[    2.527070] pci 0000:d7:17.0: [8086:2018] type 00 class 0x088000
[    2.528076] pci_bus 0000:d7: on NUMA node 1
[    2.529641] initcall acpi_init+0x0/0x365 returned 0 after 1166992 usecs
[    2.530003] calling  pnp_init+0x0/0x11 @ 1
[    2.531006] initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
[    2.532003] calling  misc_init+0x0/0xb7 @ 1
[    2.533005] initcall misc_init+0x0/0xb7 returned 0 after 0 usecs
[    2.534001] calling  vga_arb_device_init+0x0/0x248 @ 1
[    2.535013] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    2.536000] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.536044] pci 0000:03:00.0: vgaarb: bridge control possible
[    2.537001] vgaarb: loaded
[    2.538001] initcall vga_arb_device_init+0x0/0x248 returned 0 after 2929 usecs
[    2.539003] calling  cn_init+0x0/0xf0 @ 1
[    2.540005] initcall cn_init+0x0/0xf0 returned 0 after 0 usecs
[    2.541001] calling  dax_fs_init+0x0/0xbf @ 1
[    2.542184] initcall dax_fs_init+0x0/0xbf returned 0 after 0 usecs
[    2.543001] calling  dma_buf_init+0x0/0xaa @ 1
[    2.544004] initcall dma_buf_init+0x0/0xaa returned 0 after 0 usecs
[    2.545001] calling  init_scsi+0x0/0x83 @ 1
[    2.546037] SCSI subsystem initialized
[    2.547001] initcall init_scsi+0x0/0x83 returned 0 after 976 usecs
[    2.548001] calling  ata_init+0x0/0x2ee @ 1
[    2.549006] libata version 3.00 loaded.
[    2.550001] initcall ata_init+0x0/0x2ee returned 0 after 976 usecs
[    2.551001] calling  phy_init+0x0/0x4e @ 1
[    2.552011] initcall phy_init+0x0/0x4e returned 0 after 0 usecs
[    2.553001] calling  usb_init+0x0/0x162 @ 1
[    2.554003] ACPI: bus type USB registered
[    2.555010] usbcore: registered new interface driver usbfs
[    2.556005] usbcore: registered new interface driver hub
[    2.557429] usbcore: registered new device driver usb
[    2.558002] initcall usb_init+0x0/0x162 returned 0 after 3906 usecs
[    2.559002] calling  serio_init+0x0/0x2a @ 1
[    2.560005] initcall serio_init+0x0/0x2a returned 0 after 0 usecs
[    2.561001] calling  input_init+0x0/0xfd @ 1
[    2.562005] initcall input_init+0x0/0xfd returned 0 after 0 usecs
[    2.563001] calling  rtc_init+0x0/0x4c @ 1
[    2.564003] initcall rtc_init+0x0/0x4c returned 0 after 0 usecs
[    2.565001] calling  pps_init+0x0/0xaa @ 1
[    2.566002] pps_core: LinuxPPS API ver. 1 registered
[    2.567001] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.568002] initcall pps_init+0x0/0xaa returned 0 after 1953 usecs
[    2.569001] calling  ptp_init+0x0/0x99 @ 1
[    2.570002] PTP clock support registered
[    2.571001] initcall ptp_init+0x0/0x99 returned 0 after 976 usecs
[    2.572002] calling  power_supply_class_init+0x0/0x40 @ 1
[    2.573004] initcall power_supply_class_init+0x0/0x40 returned 0 after 0 usecs
[    2.574001] calling  hwmon_init+0x0/0xf9 @ 1
[    2.575017] initcall hwmon_init+0x0/0xf9 returned 0 after 0 usecs
[    2.576001] calling  md_init+0x0/0x161 @ 1
[    2.577359] initcall md_init+0x0/0x161 returned 0 after 0 usecs
[    2.578003] calling  edac_init+0x0/0x70 @ 1
[    2.579001] EDAC MC: Ver: 3.0.0
[    2.580280] initcall edac_init+0x0/0x70 returned 0 after 976 usecs
[    2.581002] calling  dmi_init+0x0/0x114 @ 1
[    2.582023] initcall dmi_init+0x0/0x114 returned 0 after 0 usecs
[    2.583002] calling  efisubsys_init+0x0/0x2cf @ 1
[    2.584002] Registered efivars operations
[    2.633022] initcall efisubsys_init+0x0/0x2cf returned 0 after 47851 usecs
[    2.634002] calling  devfreq_init+0x0/0xa1 @ 1
[    2.635010] initcall devfreq_init+0x0/0xa1 returned 0 after 0 usecs
[    2.636002] calling  ras_init+0x0/0xf @ 1
[    2.637006] initcall ras_init+0x0/0xf returned 0 after 0 usecs
[    2.638001] calling  nvmem_init+0x0/0x11 @ 1
[    2.639005] initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
[    2.640001] calling  pci_subsys_init+0x0/0x67 @ 1
[    2.641001] PCI: Using ACPI for IRQ routing
[    2.645259] PCI: pci_cache_line_size set to 64 bytes
[    2.646265] e820: reserve RAM buffer [mem 0x5f051020-0x5fffffff]
[    2.647001] e820: reserve RAM buffer [mem 0x5f0ae020-0x5fffffff]
[    2.648001] e820: reserve RAM buffer [mem 0x5f10b020-0x5fffffff]
[    2.649001] e820: reserve RAM buffer [mem 0x5f16d020-0x5fffffff]
[    2.650001] e820: reserve RAM buffer [mem 0x60081020-0x63ffffff]
[    2.651001] e820: reserve RAM buffer [mem 0x6009a020-0x63ffffff]
[    2.652001] e820: reserve RAM buffer [mem 0x6c2cf000-0x6fffffff]
[    2.653001] e820: reserve RAM buffer [mem 0x6f800000-0x6fffffff]
[    2.654567] initcall pci_subsys_init+0x0/0x67 returned 0 after 12695 usecs
[    2.655001] calling  proto_init+0x0/0x11 @ 1
[    2.656003] initcall proto_init+0x0/0x11 returned 0 after 0 usecs
[    2.657001] calling  net_dev_init+0x0/0x1eb @ 1
[    2.658182] initcall net_dev_init+0x0/0x1eb returned 0 after 0 usecs
[    2.659001] calling  neigh_init+0x0/0x80 @ 1
[    2.660002] initcall neigh_init+0x0/0x80 returned 0 after 0 usecs
[    2.661001] calling  fib_notifier_init+0x0/0x11 @ 1
[    2.662001] initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
[    2.663001] calling  fib_rules_init+0x0/0xac @ 1
[    2.664002] initcall fib_rules_init+0x0/0xac returned 0 after 0 usecs
[    2.665001] calling  init_cgroup_netprio+0x0/0x14 @ 1
[    2.666002] initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
[    2.667001] calling  genl_init+0x0/0x36 @ 1
[    2.668006] initcall genl_init+0x0/0x36 returned 0 after 0 usecs
[    2.669002] calling  watchdog_init+0x0/0x98 @ 1
[    2.670017] initcall watchdog_init+0x0/0x98 returned 0 after 0 usecs
[    2.671035] calling  nmi_warning_debugfs+0x0/0x27 @ 1
[    2.672004] initcall nmi_warning_debugfs+0x0/0x27 returned 0 after 0 usecs
[    2.673001] calling  save_microcode_in_initrd+0x0/0xa4 @ 1
[    2.674400] initcall save_microcode_in_initrd+0x0/0xa4 returned 0 after 0 usecs
[    2.675003] calling  hpet_late_init+0x0/0x111 @ 1
[    2.676022] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.677001] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    2.680002] initcall hpet_late_init+0x0/0x111 returned 0 after 3906 usecs
[    2.681002] calling  init_amd_nbs+0x0/0x11f @ 1
[    2.682036] initcall init_amd_nbs+0x0/0x11f returned 0 after 0 usecs
[    2.683001] calling  uv_ptc_init+0x0/0xb4 @ 1
[    2.684002] initcall uv_ptc_init+0x0/0xb4 returned 0 after 0 usecs
[    2.685002] calling  sugov_register+0x0/0x11 @ 1
[    2.686002] initcall sugov_register+0x0/0x11 returned 0 after 0 usecs
[    2.687001] calling  clocksource_done_booting+0x0/0x42 @ 1
[    2.688181] clocksource: Switched to clocksource tsc-early
[    2.693543] initcall clocksource_done_booting+0x0/0x42 returned 0 after 5412 usecs
[    2.701090] calling  tracer_init_tracefs+0x0/0x1b3 @ 1
[    2.711163] initcall tracer_init_tracefs+0x0/0x1b3 returned 0 after 4828 usecs
[    2.718372] calling  init_trace_printk_function_export+0x0/0x2d @ 1
[    2.724666] initcall init_trace_printk_function_export+0x0/0x2d returned 0 after 40 usecs
[    2.732821] calling  init_graph_tracefs+0x0/0x2d @ 1
[    2.737773] initcall init_graph_tracefs+0x0/0x2d returned 0 after 0 usecs
[    2.744542] calling  event_trace_init+0x0/0x2b3 @ 1
[    2.755811] initcall event_trace_init+0x0/0x2b3 returned 0 after 6250 usecs
[    2.762754] calling  init_kprobe_trace+0x0/0x8a @ 1
[    2.767621] initcall init_kprobe_trace+0x0/0x8a returned 0 after 1 usecs
[    2.774303] calling  init_uprobe_trace+0x0/0x4f @ 1
[    2.779173] initcall init_uprobe_trace+0x0/0x4f returned 0 after 1 usecs
[    2.785855] calling  init_pipe_fs+0x0/0x47 @ 1
[    2.790402] initcall init_pipe_fs+0x0/0x47 returned 0 after 110 usecs
[    2.796824] calling  cgroup_writeback_init+0x0/0x2b @ 1
[    2.802359] initcall cgroup_writeback_init+0x0/0x2b returned 0 after 312 usecs
[    2.809565] calling  inotify_user_setup+0x0/0x48 @ 1
[    2.814520] initcall inotify_user_setup+0x0/0x48 returned 0 after 5 usecs
[    2.821293] calling  eventpoll_init+0x0/0xc9 @ 1
[    2.826006] initcall eventpoll_init+0x0/0xc9 returned 0 after 99 usecs
[    2.832518] calling  anon_inode_init+0x0/0x5b @ 1
[    2.837294] initcall anon_inode_init+0x0/0x5b returned 0 after 79 usecs
[    2.843894] calling  proc_locks_init+0x0/0x1f @ 1
[    2.848594] initcall proc_locks_init+0x0/0x1f returned 0 after 2 usecs
[    2.855100] calling  dquot_init+0x0/0x119 @ 1
[    2.859447] VFS: Disk quotas dquot_6.6.0
[    2.863596] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.870457] initcall dquot_init+0x0/0x119 returned 0 after 10750 usecs
[    2.876967] calling  quota_init+0x0/0x24 @ 1
[    2.881233] initcall quota_init+0x0/0x24 returned 0 after 4 usecs
[    2.887317] calling  proc_cmdline_init+0x0/0x1f @ 1
[    2.892184] initcall proc_cmdline_init+0x0/0x1f returned 0 after 0 usecs
[    2.898866] calling  proc_consoles_init+0x0/0x1f @ 1
[    2.903820] initcall proc_consoles_init+0x0/0x1f returned 0 after 0 usecs
[    2.910590] calling  proc_cpuinfo_init+0x0/0x1f @ 1
[    2.915458] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 0 usecs
[    2.922143] calling  proc_devices_init+0x0/0x1f @ 1
[    2.927011] initcall proc_devices_init+0x0/0x1f returned 0 after 0 usecs
[    2.933692] calling  proc_interrupts_init+0x0/0x1f @ 1
[    2.938821] initcall proc_interrupts_init+0x0/0x1f returned 0 after 0 usecs
[    2.945765] calling  proc_loadavg_init+0x0/0x1f @ 1
[    2.950631] initcall proc_loadavg_init+0x0/0x1f returned 0 after 0 usecs
[    2.957313] calling  proc_meminfo_init+0x0/0x1f @ 1
[    2.962183] initcall proc_meminfo_init+0x0/0x1f returned 0 after 0 usecs
[    2.968865] calling  proc_stat_init+0x0/0x1f @ 1
[    2.973473] initcall proc_stat_init+0x0/0x1f returned 0 after 0 usecs
[    2.979897] calling  proc_uptime_init+0x0/0x1f @ 1
[    2.984681] initcall proc_uptime_init+0x0/0x1f returned 0 after 0 usecs
[    2.991275] calling  proc_version_init+0x0/0x1f @ 1
[    2.996143] initcall proc_version_init+0x0/0x1f returned 0 after 0 usecs
[    3.002828] calling  proc_softirqs_init+0x0/0x1f @ 1
[    3.007783] initcall proc_softirqs_init+0x0/0x1f returned 0 after 0 usecs
[    3.014550] calling  proc_kcore_init+0x0/0xd0 @ 1
[    3.019252] initcall proc_kcore_init+0x0/0xd0 returned 0 after 4 usecs
[    3.025765] calling  vmcore_init+0x0/0x610 @ 1
[    3.030203] initcall vmcore_init+0x0/0x610 returned 0 after 0 usecs
[    3.036451] calling  proc_kmsg_init+0x0/0x22 @ 1
[    3.041060] initcall proc_kmsg_init+0x0/0x22 returned 0 after 0 usecs
[    3.047485] calling  proc_page_init+0x0/0x56 @ 1
[    3.052095] initcall proc_page_init+0x0/0x56 returned 0 after 0 usecs
[    3.058518] calling  init_ramfs_fs+0x0/0x1f @ 1
[    3.063038] initcall init_ramfs_fs+0x0/0x1f returned 0 after 0 usecs
[    3.069375] calling  init_hugetlbfs_fs+0x0/0x17a @ 1
[    3.074739] initcall init_hugetlbfs_fs+0x0/0x17a returned 0 after 398 usecs
[    3.081679] calling  blk_scsi_ioctl_init+0x0/0x38c @ 1
[    3.086806] initcall blk_scsi_ioctl_init+0x0/0x38c returned 0 after 0 usecs
[    3.093749] calling  dynamic_debug_init_debugfs+0x0/0x62 @ 1
[    3.099398] initcall dynamic_debug_init_debugfs+0x0/0x62 returned 0 after 2 usecs
[    3.106858] calling  acpi_event_init+0x0/0x2d @ 1
[    3.111553] initcall acpi_event_init+0x0/0x2d returned 0 after 2 usecs
[    3.118063] calling  pnp_system_init+0x0/0x11 @ 1
[    3.122762] initcall pnp_system_init+0x0/0x11 returned 0 after 5 usecs
[    3.129277] calling  pnpacpi_init+0x0/0x6e @ 1
[    3.133710] pnp: PnP ACPI init
[    3.137225] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.143849] system 00:01: [io  0x0500-0x053f] has been reserved
[    3.149760] system 00:01: [io  0x0400-0x047f] has been reserved
[    3.155665] system 00:01: [io  0x0540-0x057f] has been reserved
[    3.161570] system 00:01: [io  0x0600-0x061f] has been reserved
[    3.167474] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    3.173380] system 00:01: [io  0x0880-0x0883] has been reserved
[    3.179286] system 00:01: [io  0x0800-0x081f] has been reserved
[    3.185190] system 00:01: [mem 0xfed1c000-0xfed3ffff] has been reserved
[    3.191786] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    3.198385] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    3.204981] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    3.211578] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    3.218175] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    3.224773] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    3.231371] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.238308] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.244976] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.251609] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[    3.258207] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[    3.264803] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
[    3.271400] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[    3.277999] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[    3.284596] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[    3.291192] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    3.297787] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[    3.304386] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.311371] system 00:05: [io  0x1000-0x10fe] has been reserved
[    3.317280] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.324555] pnp: PnP ACPI: found 6 devices
[    3.328648] initcall pnpacpi_init+0x0/0x6e returned 0 after 190367 usecs
[    3.335331] calling  chr_dev_init+0x0/0xa9 @ 1
[    3.340779] initcall chr_dev_init+0x0/0xa9 returned 0 after 988 usecs
[    3.347201] calling  firmware_class_init+0x0/0xe4 @ 1
[    3.352243] initcall firmware_class_init+0x0/0xe4 returned 0 after 0 usecs
[    3.359099] calling  thermal_init+0x0/0xdf @ 1
[    3.363542] initcall thermal_init+0x0/0xdf returned 0 after 7 usecs
[    3.369793] calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
[    3.375613] initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
[    3.383246] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[    3.388375] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 0 usecs
[    3.395315] calling  init_acpi_pm_clocksource+0x0/0xdb @ 1
[    3.405308] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.414158] initcall init_acpi_pm_clocksource+0x0/0xdb returned 0 after 13054 usecs
[    3.421791] calling  pcibios_assign_resources+0x0/0xca @ 1
[    3.427266] pci 0000:18:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    3.437148] pci 0000:19:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    3.447030] pci 0000:19:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    3.456911] pci 0000:1a:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    3.466793] pci 0000:1a:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    3.476689] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    3.484846] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    3.496304] pci 0000:00:1c.0: BAR 15: assigned [mem 0x380000000000-0x3800001fffff 64bit pref]
[    3.504804] pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
[    3.510967] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    3.515921] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    3.522002] pci 0000:00:1c.0:   bridge window [mem 0x92a00000-0x92bfffff]
[    3.528771] pci 0000:00:1c.0:   bridge window [mem 0x380000000000-0x3800001fffff 64bit pref]
[    3.537184] pci 0000:02:00.0: PCI bridge to [bus 03]
[    3.542139] pci 0000:02:00.0:   bridge window [mem 0x92000000-0x928fffff]
[    3.548907] pci 0000:02:00.0:   bridge window [mem 0x91000000-0x91ffffff 64bit pref]
[    3.556632] pci 0000:00:1c.4: PCI bridge to [bus 02-03]
[    3.561851] pci 0000:00:1c.4:   bridge window [mem 0x92000000-0x928fffff]
[    3.568621] pci 0000:00:1c.4:   bridge window [mem 0x91000000-0x91ffffff 64bit pref]
[    3.576343] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.582504] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
[    3.588667] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.595525] pci_bus 0000:00: resource 7 [mem 0x000c4000-0x000cbfff window]
[    3.602382] pci_bus 0000:00: resource 8 [mem 0xfe010000-0xfe010fff window]
[    3.609239] pci_bus 0000:00: resource 9 [mem 0x90000000-0x9d7fffff window]
[    3.616095] pci_bus 0000:00: resource 10 [mem 0x380000000000-0x380fffffffff window]
[    3.623728] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    3.629287] pci_bus 0000:01: resource 1 [mem 0x92a00000-0x92bfffff]
[    3.635539] pci_bus 0000:01: resource 2 [mem 0x380000000000-0x3800001fffff 64bit pref]
[    3.643432] pci_bus 0000:02: resource 1 [mem 0x92000000-0x928fffff]
[    3.649685] pci_bus 0000:02: resource 2 [mem 0x91000000-0x91ffffff 64bit pref]
[    3.656888] pci_bus 0000:03: resource 1 [mem 0x92000000-0x928fffff]
[    3.663138] pci_bus 0000:03: resource 2 [mem 0x91000000-0x91ffffff 64bit pref]
[    3.670426] pci 0000:17:02.0: BAR 14: assigned [mem 0x9e600000-0x9e6fffff]
[    3.677283] pci 0000:18:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[    3.684312] pci 0000:18:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    3.691687] pci 0000:17:00.0: PCI bridge to [bus 18]
[    3.696640] pci 0000:17:00.0:   bridge window [io  0x4000-0x4fff]
[    3.702721] pci 0000:17:00.0:   bridge window [mem 0x9e300000-0x9e4fffff]
[    3.709492] pci 0000:19:00.0: BAR 6: assigned [mem 0x9e600000-0x9e67ffff pref]
[    3.716692] pci 0000:19:00.1: BAR 6: assigned [mem 0x9e680000-0x9e6fffff pref]
[    3.723893] pci 0000:17:02.0: PCI bridge to [bus 19]
[    3.728849] pci 0000:17:02.0:   bridge window [mem 0x9e600000-0x9e6fffff]
[    3.735619] pci 0000:17:02.0:   bridge window [mem 0x9d800000-0x9e0fffff 64bit pref]
[    3.743370] pci 0000:1a:00.0: BAR 6: assigned [mem 0x9e280000-0x9e2fffff pref]
[    3.750578] pci 0000:1a:00.1: BAR 6: no space for [mem size 0x00080000 pref]
[    3.757604] pci 0000:1a:00.1: BAR 6: failed to assign [mem size 0x00080000 pref]
[    3.764981] pci 0000:17:03.0: PCI bridge to [bus 1a]
[    3.769935] pci 0000:17:03.0:   bridge window [mem 0x9e100000-0x9e2fffff]
[    3.776707] pci_bus 0000:17: resource 4 [io  0x4000-0x5fff window]
[    3.782869] pci_bus 0000:17: resource 5 [mem 0x9d800000-0xaaffffff window]
[    3.789725] pci_bus 0000:17: resource 6 [mem 0x381000000000-0x381fffffffff window]
[    3.797272] pci_bus 0000:18: resource 0 [io  0x4000-0x4fff]
[    3.802831] pci_bus 0000:18: resource 1 [mem 0x9e300000-0x9e4fffff]
[    3.809084] pci_bus 0000:19: resource 1 [mem 0x9e600000-0x9e6fffff]
[    3.815334] pci_bus 0000:19: resource 2 [mem 0x9d800000-0x9e0fffff 64bit pref]
[    3.822536] pci_bus 0000:1a: resource 1 [mem 0x9e100000-0x9e2fffff]
[    3.828805] pci_bus 0000:3a: resource 4 [io  0x6000-0x7fff window]
[    3.834970] pci_bus 0000:3a: resource 5 [mem 0xab000000-0xb87fffff window]
[    3.841827] pci_bus 0000:3a: resource 6 [mem 0x382000000000-0x382fffffffff window]
[    3.849384] pci_bus 0000:5d: resource 4 [io  0x8000-0x9fff window]
[    3.855546] pci_bus 0000:5d: resource 5 [mem 0xb8800000-0xc5ffffff window]
[    3.862405] pci_bus 0000:5d: resource 6 [mem 0x383000000000-0x383fffffffff window]
[    3.869968] pci_bus 0000:80: resource 4 [mem 0xc6000000-0xd37fffff window]
[    3.876825] pci_bus 0000:80: resource 5 [mem 0x384000000000-0x384fffffffff window]
[    3.884384] pci 0000:85:00.0: bridge window [io  0x1000-0x0fff] to [bus 86] add_size 1000
[    3.892536] pci 0000:85:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 86] add_size 200000 add_align 100000
[    3.903978] pci 0000:85:01.0: bridge window [io  0x1000-0x0fff] to [bus 87] add_size 1000
[    3.912127] pci 0000:85:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 87] add_size 200000 add_align 100000
[    3.923571] pci 0000:85:02.0: bridge window [io  0x1000-0x0fff] to [bus 88] add_size 1000
[    3.931730] pci 0000:85:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 88] add_size 200000 add_align 100000
[    3.943170] pci 0000:85:03.0: bridge window [io  0x1000-0x0fff] to [bus 89] add_size 1000
[    3.951320] pci 0000:85:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 89] add_size 200000 add_align 100000
[    3.962769] pci 0000:85:00.0: BAR 15: assigned [mem 0x385000000000-0x3850001fffff 64bit pref]
[    3.971268] pci 0000:85:01.0: BAR 15: assigned [mem 0x385000200000-0x3850003fffff 64bit pref]
[    3.979767] pci 0000:85:02.0: BAR 15: assigned [mem 0x385000400000-0x3850005fffff 64bit pref]
[    3.988265] pci 0000:85:03.0: BAR 15: assigned [mem 0x385000600000-0x3850007fffff 64bit pref]
[    3.996764] pci 0000:85:00.0: BAR 13: assigned [io  0xa000-0xafff]
[    4.002929] pci 0000:85:01.0: BAR 13: assigned [io  0xb000-0xbfff]
[    4.009093] pci 0000:85:02.0: BAR 13: no space for [io  size 0x1000]
[    4.015431] pci 0000:85:02.0: BAR 13: failed to assign [io  size 0x1000]
[    4.022115] pci 0000:85:03.0: BAR 13: no space for [io  size 0x1000]
[    4.028451] pci 0000:85:03.0: BAR 13: failed to assign [io  size 0x1000]
[    4.035136] pci 0000:85:03.0: BAR 13: assigned [io  0xa000-0xafff]
[    4.041300] pci 0000:85:02.0: BAR 13: assigned [io  0xb000-0xbfff]
[    4.047465] pci 0000:85:01.0: BAR 13: no space for [io  size 0x1000]
[    4.053803] pci 0000:85:01.0: BAR 13: failed to assign [io  size 0x1000]
[    4.060487] pci 0000:85:00.0: BAR 13: no space for [io  size 0x1000]
[    4.066822] pci 0000:85:00.0: BAR 13: failed to assign [io  size 0x1000]
[    4.073506] pci 0000:85:00.0: PCI bridge to [bus 86]
[    4.078463] pci 0000:85:00.0:   bridge window [mem 0xd3e00000-0xd3ffffff]
[    4.085233] pci 0000:85:00.0:   bridge window [mem 0x385000000000-0x3850001fffff 64bit pref]
[    4.093646] pci 0000:85:01.0: PCI bridge to [bus 87]
[    4.098598] pci 0000:85:01.0:   bridge window [mem 0xd3c00000-0xd3dfffff]
[    4.105370] pci 0000:85:01.0:   bridge window [mem 0x385000200000-0x3850003fffff 64bit pref]
[    4.113783] pci 0000:85:02.0: PCI bridge to [bus 88]
[    4.118734] pci 0000:85:02.0:   bridge window [io  0xb000-0xbfff]
[    4.124813] pci 0000:85:02.0:   bridge window [mem 0xd3a00000-0xd3bfffff]
[    4.131582] pci 0000:85:02.0:   bridge window [mem 0x385000400000-0x3850005fffff 64bit pref]
[    4.139996] pci 0000:85:03.0: PCI bridge to [bus 89]
[    4.144949] pci 0000:85:03.0:   bridge window [io  0xa000-0xafff]
[    4.151028] pci 0000:85:03.0:   bridge window [mem 0xd3800000-0xd39fffff]
[    4.157800] pci 0000:85:03.0:   bridge window [mem 0x385000600000-0x3850007fffff 64bit pref]
[    4.166215] pci_bus 0000:85: resource 4 [io  0xa000-0xbfff window]
[    4.172384] pci_bus 0000:85: resource 5 [mem 0xd3800000-0xe0ffffff window]
[    4.179241] pci_bus 0000:85: resource 6 [mem 0x385000000000-0x385fffffffff window]
[    4.186788] pci_bus 0000:86: resource 1 [mem 0xd3e00000-0xd3ffffff]
[    4.193038] pci_bus 0000:86: resource 2 [mem 0x385000000000-0x3850001fffff 64bit pref]
[    4.200933] pci_bus 0000:87: resource 1 [mem 0xd3c00000-0xd3dfffff]
[    4.207185] pci_bus 0000:87: resource 2 [mem 0x385000200000-0x3850003fffff 64bit pref]
[    4.215078] pci_bus 0000:88: resource 0 [io  0xb000-0xbfff]
[    4.220637] pci_bus 0000:88: resource 1 [mem 0xd3a00000-0xd3bfffff]
[    4.226889] pci_bus 0000:88: resource 2 [mem 0x385000400000-0x3850005fffff 64bit pref]
[    4.234782] pci_bus 0000:89: resource 0 [io  0xa000-0xafff]
[    4.240342] pci_bus 0000:89: resource 1 [mem 0xd3800000-0xd39fffff]
[    4.246592] pci_bus 0000:89: resource 2 [mem 0x385000600000-0x3850007fffff 64bit pref]
[    4.254499] pci 0000:ae:00.0: bridge window [io  0x1000-0x0fff] to [bus af] add_size 1000
[    4.262650] pci 0000:ae:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus af] add_size 200000 add_align 100000
[    4.274092] pci 0000:ae:01.0: bridge window [io  0x1000-0x0fff] to [bus b0] add_size 1000
[    4.282241] pci 0000:ae:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus b0] add_size 200000 add_align 100000
[    4.293682] pci 0000:ae:02.0: bridge window [io  0x1000-0x0fff] to [bus b1] add_size 1000
[    4.301833] pci 0000:ae:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus b1] add_size 200000 add_align 100000
[    4.313276] pci 0000:ae:03.0: bridge window [io  0x1000-0x0fff] to [bus b2] add_size 1000
[    4.321427] pci 0000:ae:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus b2] add_size 200000 add_align 100000
[    4.332869] pci 0000:ae:00.0: BAR 15: assigned [mem 0x386000000000-0x3860001fffff 64bit pref]
[    4.341371] pci 0000:ae:01.0: BAR 15: assigned [mem 0x386000200000-0x3860003fffff 64bit pref]
[    4.349872] pci 0000:ae:02.0: BAR 15: assigned [mem 0x386000400000-0x3860005fffff 64bit pref]
[    4.358370] pci 0000:ae:03.0: BAR 15: assigned [mem 0x386000600000-0x3860007fffff 64bit pref]
[    4.366868] pci 0000:ae:00.0: BAR 13: assigned [io  0xc000-0xcfff]
[    4.373034] pci 0000:ae:01.0: BAR 13: assigned [io  0xd000-0xdfff]
[    4.379197] pci 0000:ae:02.0: BAR 13: no space for [io  size 0x1000]
[    4.385535] pci 0000:ae:02.0: BAR 13: failed to assign [io  size 0x1000]
[    4.392220] pci 0000:ae:03.0: BAR 13: no space for [io  size 0x1000]
[    4.398558] pci 0000:ae:03.0: BAR 13: failed to assign [io  size 0x1000]
[    4.405240] pci 0000:ae:03.0: BAR 13: assigned [io  0xc000-0xcfff]
[    4.411405] pci 0000:ae:02.0: BAR 13: assigned [io  0xd000-0xdfff]
[    4.417570] pci 0000:ae:01.0: BAR 13: no space for [io  size 0x1000]
[    4.423905] pci 0000:ae:01.0: BAR 13: failed to assign [io  size 0x1000]
[    4.430590] pci 0000:ae:00.0: BAR 13: no space for [io  size 0x1000]
[    4.436929] pci 0000:ae:00.0: BAR 13: failed to assign [io  size 0x1000]
[    4.443611] pci 0000:ae:00.0: PCI bridge to [bus af]
[    4.448566] pci 0000:ae:00.0:   bridge window [mem 0xe1600000-0xe17fffff]
[    4.455336] pci 0000:ae:00.0:   bridge window [mem 0x386000000000-0x3860001fffff 64bit pref]
[    4.463750] pci 0000:ae:01.0: PCI bridge to [bus b0]
[    4.468705] pci 0000:ae:01.0:   bridge window [mem 0xe1400000-0xe15fffff]
[    4.475474] pci 0000:ae:01.0:   bridge window [mem 0x386000200000-0x3860003fffff 64bit pref]
[    4.483887] pci 0000:ae:02.0: PCI bridge to [bus b1]
[    4.488838] pci 0000:ae:02.0:   bridge window [io  0xd000-0xdfff]
[    4.494917] pci 0000:ae:02.0:   bridge window [mem 0xe1200000-0xe13fffff]
[    4.501688] pci 0000:ae:02.0:   bridge window [mem 0x386000400000-0x3860005fffff 64bit pref]
[    4.510103] pci 0000:ae:03.0: PCI bridge to [bus b2]
[    4.515055] pci 0000:ae:03.0:   bridge window [io  0xc000-0xcfff]
[    4.521132] pci 0000:ae:03.0:   bridge window [mem 0xe1000000-0xe11fffff]
[    4.527902] pci 0000:ae:03.0:   bridge window [mem 0x386000600000-0x3860007fffff 64bit pref]
[    4.536319] pci_bus 0000:ae: resource 4 [io  0xc000-0xdfff window]
[    4.542480] pci_bus 0000:ae: resource 5 [mem 0xe1000000-0xee7fffff window]
[    4.549335] pci_bus 0000:ae: resource 6 [mem 0x386000000000-0x386fffffffff window]
[    4.556886] pci_bus 0000:af: resource 1 [mem 0xe1600000-0xe17fffff]
[    4.563136] pci_bus 0000:af: resource 2 [mem 0x386000000000-0x3860001fffff 64bit pref]
[    4.571030] pci_bus 0000:b0: resource 1 [mem 0xe1400000-0xe15fffff]
[    4.577280] pci_bus 0000:b0: resource 2 [mem 0x386000200000-0x3860003fffff 64bit pref]
[    4.585173] pci_bus 0000:b1: resource 0 [io  0xd000-0xdfff]
[    4.590733] pci_bus 0000:b1: resource 1 [mem 0xe1200000-0xe13fffff]
[    4.596985] pci_bus 0000:b1: resource 2 [mem 0x386000400000-0x3860005fffff 64bit pref]
[    4.604880] pci_bus 0000:b2: resource 0 [io  0xc000-0xcfff]
[    4.610437] pci_bus 0000:b2: resource 1 [mem 0xe1000000-0xe11fffff]
[    4.616689] pci_bus 0000:b2: resource 2 [mem 0x386000600000-0x3860007fffff 64bit pref]
[    4.624606] pci_bus 0000:d7: resource 4 [io  0xe000-0xffff window]
[    4.630773] pci_bus 0000:d7: resource 5 [mem 0xee800000-0xfbffffff window]
[    4.637630] pci_bus 0000:d7: resource 6 [mem 0x387000000000-0x387fffffffff window]
[    4.645186] initcall pcibios_assign_resources+0x0/0xca returned 0 after 1189376 usecs
[    4.652994] calling  sysctl_core_init+0x0/0x2b @ 1
[    4.657783] initcall sysctl_core_init+0x0/0x2b returned 0 after 8 usecs
[    4.664382] calling  eth_offload_init+0x0/0x14 @ 1
[    4.669164] initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
[    4.675759] calling  inet_init+0x0/0x285 @ 1
[    4.680517] NET: Registered protocol family 2
[    4.685637] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes)
[    4.693956] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    4.702009] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    4.708821] TCP: Hash tables configured (established 524288 bind 65536)
[    4.715862] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    4.722435] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    4.730189] initcall inet_init+0x0/0x285 returned 0 after 48991 usecs
[    4.736614] calling  ipv4_offload_init+0x0/0x74 @ 1
[    4.741482] initcall ipv4_offload_init+0x0/0x74 returned 0 after 0 usecs
[    4.748163] calling  af_unix_init+0x0/0x4e @ 1
[    4.752600] NET: Registered protocol family 1
[    4.756950] initcall af_unix_init+0x0/0x4e returned 0 after 4250 usecs
[    4.763459] calling  ipv6_offload_init+0x0/0x7f @ 1
[    4.768327] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
[    4.775011] calling  pci_apply_final_quirks+0x0/0x125 @ 1
[    4.780710] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    4.789112] pci 0000:18:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    4.799776] PCI: CLS 32 bytes, default 64
[    4.803785] initcall pci_apply_final_quirks+0x0/0x125 returned 0 after 22840 usecs
[    4.811331] calling  acpi_reserve_resources+0x0/0xeb @ 1
[    4.816632] initcall acpi_reserve_resources+0x0/0xeb returned 0 after 1 usecs
[    4.823747] calling  populate_rootfs+0x0/0x10a @ 1
[    4.828557] Unpacking initramfs...
[    7.717387] Freeing initrd memory: 190656K
[    7.721519] initcall populate_rootfs+0x0/0x10a returned 0 after 2825180 usecs
[    7.728639] calling  pci_iommu_init+0x0/0x3f @ 1
[    7.733527] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    7.739953] software IO TLB [mem 0x4e625000-0x52625000] (64MB) mapped at [00000000e0625d9b-00000000391d6d3c]
[    7.749749] initcall pci_iommu_init+0x0/0x3f returned 0 after 16108 usecs
[    7.756520] calling  ir_dev_scope_init+0x0/0x33 @ 1
[    7.761387] initcall ir_dev_scope_init+0x0/0x33 returned 0 after 0 usecs
[    7.768105] calling  ia32_binfmt_init+0x0/0x14 @ 1
[    7.772892] initcall ia32_binfmt_init+0x0/0x14 returned 0 after 6 usecs
[    7.779491] calling  amd_uncore_init+0x0/0x275 @ 1
[    7.784273] initcall amd_uncore_init+0x0/0x275 returned -19 after 0 usecs
[    7.791040] calling  amd_ibs_init+0x0/0x201 @ 1
[    7.795564] initcall amd_ibs_init+0x0/0x201 returned -19 after 0 usecs
[    7.802073] calling  msr_init+0x0/0xf1 @ 1
[    7.806209] initcall msr_init+0x0/0xf1 returned 0 after 45 usecs
[    7.812199] calling  rapl_pmu_init+0x0/0x235 @ 1
[    7.817827] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[    7.825724] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.831453] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.837098] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    7.842485] initcall rapl_pmu_init+0x0/0x235 returned 0 after 25076 usecs
[    7.849256] calling  intel_uncore_init+0x0/0x244 @ 1
[    7.864025] initcall intel_uncore_init+0x0/0x244 returned 0 after 9581 usecs
[    7.871054] calling  cstate_pmu_init+0x0/0x170 @ 1
[    7.876882] initcall cstate_pmu_init+0x0/0x170 returned 0 after 1022 usecs
[    7.883740] calling  register_kernel_offset_dumper+0x0/0x1b @ 1
[    7.889643] initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
[    7.897361] calling  i8259A_init_ops+0x0/0x21 @ 1
[    7.902057] initcall i8259A_init_ops+0x0/0x21 returned 0 after 0 usecs
[    7.908567] calling  init_tsc_clocksource+0x0/0xc2 @ 1
[    7.913697] initcall init_tsc_clocksource+0x0/0xc2 returned 0 after 1 usecs
[    7.920638] calling  add_rtc_cmos+0x0/0xc9 @ 1
[    7.925074] initcall add_rtc_cmos+0x0/0xc9 returned 0 after 0 usecs
[    7.931325] calling  i8237A_init_ops+0x0/0x14 @ 1
[    7.936027] initcall i8237A_init_ops+0x0/0x14 returned 0 after 5 usecs
[    7.942540] calling  thermal_throttle_init_device+0x0/0x42 @ 1
[    7.950012] initcall thermal_throttle_init_device+0x0/0x42 returned 0 after 1616 usecs
[    7.957904] calling  msr_init+0x0/0xd5 @ 1
[    7.968118] initcall msr_init+0x0/0xd5 returned 0 after 5983 usecs
[    7.974290] calling  cpuid_init+0x0/0xd5 @ 1
[    7.981824] initcall cpuid_init+0x0/0xd5 returned 0 after 3198 usecs
[    7.988168] calling  ioapic_init_ops+0x0/0x14 @ 1
[    7.992868] initcall ioapic_init_ops+0x0/0x14 returned 0 after 0 usecs
[    7.999378] calling  add_pcspkr+0x0/0x6f @ 1
[    8.003656] initcall add_pcspkr+0x0/0x6f returned 0 after 15 usecs
[    8.009827] calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
[    8.016254] initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 0 usecs
[    8.024493] calling  sysfb_init+0x0/0x9f @ 1
[    8.028765] initcall sysfb_init+0x0/0x9f returned 0 after 8 usecs
[    8.034843] calling  audit_classes_init+0x0/0xaf @ 1
[    8.039802] initcall audit_classes_init+0x0/0xaf returned 0 after 3 usecs
[    8.046569] calling  pt_dump_init+0x0/0x32 @ 1
[    8.051003] initcall pt_dump_init+0x0/0x32 returned 0 after 0 usecs
[    8.057253] calling  pt_dump_debug_init+0x0/0xa7 @ 1
[    8.062223] initcall pt_dump_debug_init+0x0/0xa7 returned 0 after 15 usecs
[    8.069083] calling  aes_init+0x0/0x11 @ 1
[    8.073253] initcall aes_init+0x0/0x11 returned 0 after 79 usecs
[    8.079241] calling  iosf_mbi_init+0x0/0x1a @ 1
[    8.083811] initcall iosf_mbi_init+0x0/0x1a returned 0 after 48 usecs
[    8.090239] calling  sgi_uv_sysfs_init+0x0/0xa8 @ 1
[    8.095107] initcall sgi_uv_sysfs_init+0x0/0xa8 returned -19 after 0 usecs
[    8.101963] calling  proc_execdomains_init+0x0/0x1f @ 1
[    8.107181] initcall proc_execdomains_init+0x0/0x1f returned 0 after 3 usecs
[    8.114214] calling  register_warn_debugfs+0x0/0x24 @ 1
[    8.119429] initcall register_warn_debugfs+0x0/0x24 returned 0 after 1 usecs
[    8.126458] calling  cpuhp_sysfs_init+0x0/0x6d @ 1
[    8.131417] initcall cpuhp_sysfs_init+0x0/0x6d returned 0 after 171 usecs
[    8.138191] calling  ioresources_init+0x0/0x36 @ 1
[    8.142974] initcall ioresources_init+0x0/0x36 returned 0 after 2 usecs
[    8.149569] calling  init_sched_debug_procfs+0x0/0x29 @ 1
[    8.154957] initcall init_sched_debug_procfs+0x0/0x29 returned 0 after 0 usecs
[    8.162157] calling  snapshot_device_init+0x0/0x11 @ 1
[    8.167312] initcall snapshot_device_init+0x0/0x11 returned 0 after 25 usecs
[    8.174341] calling  irq_pm_init_ops+0x0/0x14 @ 1
[    8.179036] initcall irq_pm_init_ops+0x0/0x14 returned 0 after 0 usecs
[    8.185545] calling  timekeeping_init_ops+0x0/0x14 @ 1
[    8.190673] initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
[    8.197615] calling  init_clocksource_sysfs+0x0/0x69 @ 1
[    8.202934] initcall init_clocksource_sysfs+0x0/0x69 returned 0 after 18 usecs
[    8.210135] calling  init_timer_list_procfs+0x0/0x29 @ 1
[    8.215435] initcall init_timer_list_procfs+0x0/0x29 returned 0 after 0 usecs
[    8.222550] calling  alarmtimer_init+0x0/0x134 @ 1
[    8.227350] initcall alarmtimer_init+0x0/0x134 returned 0 after 17 usecs
[    8.234034] calling  init_posix_timers+0x0/0x2a @ 1
[    8.239016] initcall init_posix_timers+0x0/0x2a returned 0 after 113 usecs
[    8.245870] calling  clockevents_init_sysfs+0x0/0xc9 @ 1
[    8.253042] initcall clockevents_init_sysfs+0x0/0xc9 returned 0 after 1828 usecs
[    8.260421] calling  proc_dma_init+0x0/0x1f @ 1
[    8.264943] initcall proc_dma_init+0x0/0x1f returned 0 after 1 usecs
[    8.271287] calling  proc_modules_init+0x0/0x1f @ 1
[    8.276156] initcall proc_modules_init+0x0/0x1f returned 0 after 1 usecs
[    8.282841] calling  kallsyms_init+0x0/0x22 @ 1
[    8.287363] initcall kallsyms_init+0x0/0x22 returned 0 after 1 usecs
[    8.293697] calling  pid_namespaces_init+0x0/0x2d @ 1
[    8.298821] initcall pid_namespaces_init+0x0/0x2d returned 0 after 78 usecs
[    8.305762] calling  audit_watch_init+0x0/0x3a @ 1
[    8.310542] initcall audit_watch_init+0x0/0x3a returned 0 after 0 usecs
[    8.317137] calling  audit_fsnotify_init+0x0/0x3a @ 1
[    8.322179] initcall audit_fsnotify_init+0x0/0x3a returned 0 after 0 usecs
[    8.329036] calling  audit_tree_init+0x0/0x4d @ 1
[    8.333730] initcall audit_tree_init+0x0/0x4d returned 0 after 0 usecs
[    8.340240] calling  init_kprobes+0x0/0x1f9 @ 1
[    8.344906] initcall init_kprobes+0x0/0x1f9 returned 0 after 138 usecs
[    8.351420] calling  seccomp_sysctl_init+0x0/0x2c @ 1
[    8.356464] initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 3 usecs
[    8.363316] calling  utsname_sysctl_init+0x0/0x14 @ 1
[    8.368365] initcall utsname_sysctl_init+0x0/0x14 returned 0 after 5 usecs
[    8.375225] calling  init_tracepoints+0x0/0x28 @ 1
[    8.380005] initcall init_tracepoints+0x0/0x28 returned 0 after 0 usecs
[    8.386601] calling  stack_trace_init+0x0/0xb0 @ 1
[    8.391390] initcall stack_trace_init+0x0/0xb0 returned 0 after 6 usecs
[    8.397990] calling  init_blk_tracer+0x0/0x50 @ 1
[    8.402691] initcall init_blk_tracer+0x0/0x50 returned 0 after 7 usecs
[    8.409204] calling  perf_event_sysfs_init+0x0/0x84 @ 1
[    8.415009] initcall perf_event_sysfs_init+0x0/0x84 returned 0 after 577 usecs
[    8.422214] calling  init_uprobes+0x0/0x71 @ 1
[    8.426669] initcall init_uprobes+0x0/0x71 returned 0 after 18 usecs
[    8.433005] calling  padata_driver_init+0x0/0x39 @ 1
[    8.437961] initcall padata_driver_init+0x0/0x39 returned 0 after 0 usecs
[    8.444730] calling  system_trusted_keyring_init+0x0/0x61 @ 1
[    8.450461] Initialise system trusted keyrings
[    8.454901] initcall system_trusted_keyring_init+0x0/0x61 returned 0 after 4334 usecs
[    8.462715] calling  kswapd_init+0x0/0x8c @ 1
[    8.467126] initcall kswapd_init+0x0/0x8c returned 0 after 59 usecs
[    8.473391] calling  extfrag_debug_init+0x0/0x78 @ 1
[    8.478354] initcall extfrag_debug_init+0x0/0x78 returned 0 after 9 usecs
[    8.485122] calling  mm_compute_batch_init+0x0/0x19 @ 1
[    8.490338] initcall mm_compute_batch_init+0x0/0x19 returned 0 after 1 usecs
[    8.497366] calling  slab_proc_init+0x0/0x22 @ 1
[    8.501977] initcall slab_proc_init+0x0/0x22 returned 0 after 1 usecs
[    8.508400] calling  workingset_init+0x0/0x82 @ 1
[    8.513092] workingset: timestamp_bits=37 max_order=26 bucket_order=0
[    8.519520] initcall workingset_init+0x0/0x82 returned 0 after 6276 usecs
[    8.526285] calling  proc_vmalloc_init+0x0/0x22 @ 1
[    8.531154] initcall proc_vmalloc_init+0x0/0x22 returned 0 after 1 usecs
[    8.537840] calling  procswaps_init+0x0/0x1f @ 1
[    8.542448] initcall procswaps_init+0x0/0x1f returned 0 after 1 usecs
[    8.548872] calling  init_frontswap+0x0/0x91 @ 1
[    8.553487] initcall init_frontswap+0x0/0x91 returned 0 after 6 usecs
[    8.559912] calling  slab_sysfs_init+0x0/0xfa @ 1
[    8.565451] initcall slab_sysfs_init+0x0/0xfa returned 0 after 823 usecs
[    8.572140] calling  init_cleancache+0x0/0x91 @ 1
[    8.576839] initcall init_cleancache+0x0/0x91 returned 0 after 5 usecs
[    8.583353] calling  init_zbud+0x0/0x20 @ 1
[    8.587526] zbud: loaded
[    8.590062] initcall init_zbud+0x0/0x20 returned 0 after 2475 usecs
[    8.596312] calling  zs_init+0x0/0x74 @ 1
[    8.600449] initcall zs_init+0x0/0x74 returned 0 after 132 usecs
[    8.606447] calling  fcntl_init+0x0/0x2a @ 1
[    8.610715] initcall fcntl_init+0x0/0x2a returned 0 after 5 usecs
[    8.616794] calling  proc_filesystems_init+0x0/0x1f @ 1
[    8.622010] initcall proc_filesystems_init+0x0/0x1f returned 0 after 0 usecs
[    8.629038] calling  start_dirtytime_writeback+0x0/0x2a @ 1
[    8.634599] initcall start_dirtytime_writeback+0x0/0x2a returned 0 after 0 usecs
[    8.641972] calling  blkdev_init+0x0/0x2a @ 1
[    8.646329] initcall blkdev_init+0x0/0x2a returned 0 after 7 usecs
[    8.652495] calling  dio_init+0x0/0x2d @ 1
[    8.656667] initcall dio_init+0x0/0x2d returned 0 after 82 usecs
[    8.662663] calling  dnotify_init+0x0/0x79 @ 1
[    8.667108] initcall dnotify_init+0x0/0x79 returned 0 after 9 usecs
[    8.673358] calling  fanotify_user_setup+0x0/0x77 @ 1
[    8.678413] initcall fanotify_user_setup+0x0/0x77 returned 0 after 12 usecs
[    8.685359] calling  aio_setup+0x0/0xa1 @ 1
[    8.689679] initcall aio_setup+0x0/0xa1 returned 0 after 141 usecs
[    8.695846] calling  init_sys32_ioctl+0x0/0x28 @ 1
[    8.700809] initcall init_sys32_ioctl+0x0/0x28 returned 0 after 177 usecs
[    8.707577] calling  mbcache_init+0x0/0x31 @ 1
[    8.712064] initcall mbcache_init+0x0/0x31 returned 0 after 47 usecs
[    8.718403] calling  init_v2_quota_format+0x0/0x22 @ 1
[    8.723532] initcall init_v2_quota_format+0x0/0x22 returned 0 after 0 usecs
[    8.730476] calling  init_devpts_fs+0x0/0x28 @ 1
[    8.735090] initcall init_devpts_fs+0x0/0x28 returned 0 after 7 usecs
[    8.741518] calling  ext4_init_fs+0x0/0x1a8 @ 1
[    8.746204] initcall ext4_init_fs+0x0/0x1a8 returned 0 after 163 usecs
[    8.752710] calling  journal_init+0x0/0x10c @ 1
[    8.757363] initcall journal_init+0x0/0x10c returned 0 after 128 usecs
[    8.763875] calling  init_nls_cp437+0x0/0x13 @ 1
[    8.768481] initcall init_nls_cp437+0x0/0x13 returned 0 after 0 usecs
[    8.774906] calling  init_nls_ascii+0x0/0x13 @ 1
[    8.779514] initcall init_nls_ascii+0x0/0x13 returned 0 after 0 usecs
[    8.785939] calling  init_autofs4_fs+0x0/0x26 @ 1
[    8.790659] initcall init_autofs4_fs+0x0/0x26 returned 0 after 26 usecs
[    8.797256] calling  init_pstore_fs+0x0/0x4a @ 1
[    8.801865] initcall init_pstore_fs+0x0/0x4a returned 0 after 0 usecs
[    8.808287] calling  efivarfs_init+0x0/0x2c @ 1
[    8.812810] initcall efivarfs_init+0x0/0x2c returned 0 after 0 usecs
[    8.819148] calling  ipc_init+0x0/0x4c @ 1
[    8.823240] initcall ipc_init+0x0/0x4c returned 0 after 3 usecs
[    8.829143] calling  ipc_sysctl_init+0x0/0x14 @ 1
[    8.833843] initcall ipc_sysctl_init+0x0/0x14 returned 0 after 6 usecs
[    8.840355] calling  init_mqueue_fs+0x0/0xe7 @ 1
[    8.845046] initcall init_mqueue_fs+0x0/0xe7 returned 0 after 79 usecs
[    8.851553] calling  key_proc_init+0x0/0x58 @ 1
[    8.856077] initcall key_proc_init+0x0/0x58 returned 0 after 2 usecs
[    8.862412] calling  selinux_nf_ip_init+0x0/0x3b @ 1
[    8.867367] SELinux:  Registering netfilter hooks
[    8.873700] initcall selinux_nf_ip_init+0x0/0x3b returned 0 after 6183 usecs
[    8.880727] calling  init_sel_fs+0x0/0xa1 @ 1
[    8.885153] initcall init_sel_fs+0x0/0xa1 returned 0 after 75 usecs
[    8.891402] calling  selnl_init+0x0/0x7d @ 1
[    8.895673] initcall selnl_init+0x0/0x7d returned 0 after 7 usecs
[    8.901752] calling  sel_netif_init+0x0/0x3b @ 1
[    8.906364] initcall sel_netif_init+0x0/0x3b returned 0 after 2 usecs
[    8.912786] calling  sel_netnode_init+0x0/0x48 @ 1
[    8.917566] initcall sel_netnode_init+0x0/0x48 returned 0 after 1 usecs
[    8.924164] calling  sel_netport_init+0x0/0x48 @ 1
[    8.928946] initcall sel_netport_init+0x0/0x48 returned 0 after 1 usecs
[    8.935541] calling  aurule_init+0x0/0x2b @ 1
[    8.939890] initcall aurule_init+0x0/0x2b returned 0 after 0 usecs
[    8.946053] calling  fips_init+0x0/0x1b @ 1
[    8.950233] initcall fips_init+0x0/0x1b returned 0 after 1 usecs
[    8.956224] calling  crypto_algapi_init+0x0/0xd @ 1
[    8.961091] initcall crypto_algapi_init+0x0/0xd returned 0 after 1 usecs
[    8.967775] calling  seqiv_module_init+0x0/0x11 @ 1
[    8.972643] initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
[    8.979328] calling  rsa_init+0x0/0x50 @ 1
[    8.991017] tsc: Refined TSC clocksource calibration: 2095.078 MHz
[    8.997315] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
[    9.007489] clocksource: Switched to clocksource tsc
[    9.013011] initcall rsa_init+0x0/0x50 returned 0 after 28900 usecs
[    9.019283] calling  hmac_module_init+0x0/0x11 @ 1
[    9.024071] initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
[    9.030684] calling  crypto_null_mod_init+0x0/0x48 @ 1
[    9.035971] initcall crypto_null_mod_init+0x0/0x48 returned 0 after 142 usecs
[    9.043104] calling  md5_mod_init+0x0/0x11 @ 1
[    9.047642] initcall md5_mod_init+0x0/0x11 returned 0 after 91 usecs
[    9.053999] calling  sha1_generic_mod_init+0x0/0x11 @ 1
[    9.059346] initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 117 usecs
[    9.066564] calling  sha256_generic_mod_init+0x0/0x16 @ 1
[    9.072292] initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 319 usecs
[    9.079685] calling  crypto_cbc_module_init+0x0/0x11 @ 1
[    9.084996] initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
[    9.092128] calling  crypto_ctr_module_init+0x0/0x3c @ 1
[    9.097443] initcall crypto_ctr_module_init+0x0/0x3c returned 0 after 0 usecs
[    9.104574] calling  crypto_gcm_module_init+0x0/0xbe @ 1
[    9.109889] initcall crypto_gcm_module_init+0x0/0xbe returned 0 after 0 usecs
[    9.117019] calling  aes_init+0x0/0x11 @ 1
[    9.121157] initcall aes_init+0x0/0x11 returned 0 after 39 usecs
[    9.127168] calling  crc32c_mod_init+0x0/0x11 @ 1
[    9.132022] initcall crc32c_mod_init+0x0/0x11 returned 0 after 143 usecs
[    9.138720] calling  crct10dif_mod_init+0x0/0x11 @ 1
[    9.143766] initcall crct10dif_mod_init+0x0/0x11 returned 0 after 78 usecs
[    9.150638] calling  lzo_mod_init+0x0/0x3a @ 1
[    9.160824] initcall lzo_mod_init+0x0/0x3a returned 0 after 5603 usecs
[    9.167355] calling  drbg_init+0x0/0x20b @ 1
[    9.174586] initcall drbg_init+0x0/0x20b returned 0 after 2890 usecs
[    9.180945] calling  jent_mod_init+0x0/0x2e @ 1
[    9.185632] initcall jent_mod_init+0x0/0x2e returned 0 after 152 usecs
[    9.192157] calling  ghash_mod_init+0x0/0x11 @ 1
[    9.196909] initcall ghash_mod_init+0x0/0x11 returned 0 after 128 usecs
[    9.203519] calling  af_alg_init+0x0/0x3e @ 1
[    9.207879] NET: Registered protocol family 38
[    9.212323] initcall af_alg_init+0x0/0x3e returned 0 after 4339 usecs
[    9.218762] calling  algif_hash_init+0x0/0x11 @ 1
[    9.223469] initcall algif_hash_init+0x0/0x11 returned 0 after 0 usecs
[    9.229995] calling  algif_skcipher_init+0x0/0x11 @ 1
[    9.235048] initcall algif_skcipher_init+0x0/0x11 returned 0 after 0 usecs
[    9.241919] calling  rng_init+0x0/0x11 @ 1
[    9.246020] initcall rng_init+0x0/0x11 returned 0 after 0 usecs
[    9.251939] calling  asymmetric_key_init+0x0/0x11 @ 1
[    9.256991] Key type asymmetric registered
[    9.261089] initcall asymmetric_key_init+0x0/0x11 returned 0 after 4002 usecs
[    9.268223] calling  x509_key_init+0x0/0x11 @ 1
[    9.272754] Asymmetric key parser 'x509' registered
[    9.277634] initcall x509_key_init+0x0/0x11 returned 0 after 4765 usecs
[    9.284248] calling  proc_genhd_init+0x0/0x36 @ 1
[    9.288954] initcall proc_genhd_init+0x0/0x36 returned 0 after 1 usecs
[    9.295479] calling  bsg_init+0x0/0x194 @ 1
[    9.299725] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    9.307119] initcall bsg_init+0x0/0x194 returned 0 after 7279 usecs
[    9.313384] calling  throtl_init+0x0/0x41 @ 1
[    9.318051] initcall throtl_init+0x0/0x41 returned 0 after 302 usecs
[    9.324408] calling  noop_init+0x0/0x11 @ 1
[    9.328593] io scheduler noop registered
[    9.332519] initcall noop_init+0x0/0x11 returned 0 after 3834 usecs
[    9.338785] calling  deadline_init+0x0/0x11 @ 1
[    9.343314] io scheduler deadline registered
[    9.347589] initcall deadline_init+0x0/0x11 returned 0 after 4173 usecs
[    9.354202] calling  cfq_init+0x0/0x74 @ 1
[    9.358380] io scheduler cfq registered (default)
[    9.363086] initcall cfq_init+0x0/0x74 returned 0 after 4673 usecs
[    9.369263] calling  deadline_init+0x0/0x11 @ 1
[    9.373797] io scheduler mq-deadline registered
[    9.378329] initcall deadline_init+0x0/0x11 returned 0 after 4425 usecs
[    9.384941] calling  kyber_init+0x0/0x11 @ 1
[    9.389214] io scheduler kyber registered
[    9.393226] initcall kyber_init+0x0/0x11 returned 0 after 3917 usecs
[    9.399578] calling  crc_t10dif_mod_init+0x0/0x39 @ 1
[    9.404633] initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 1 usecs
[    9.411503] calling  percpu_counter_startup+0x0/0x51 @ 1
[    9.417589] initcall percpu_counter_startup+0x0/0x51 returned 0 after 746 usecs
[    9.424906] calling  sg_pool_init+0x0/0xd9 @ 1
[    9.429447] initcall sg_pool_init+0x0/0xd9 returned 0 after 86 usecs
[    9.435804] calling  phy_core_init+0x0/0x4a @ 1
[    9.440341] initcall phy_core_init+0x0/0x4a returned 0 after 2 usecs
[    9.446699] calling  pci_proc_init+0x0/0x66 @ 1
[    9.451412] initcall pci_proc_init+0x0/0x66 returned 0 after 177 usecs
[    9.457940] calling  pcie_portdrv_init+0x0/0x6f @ 1
[    9.466030] initcall pcie_portdrv_init+0x0/0x6f returned 0 after 3131 usecs
[    9.472993] calling  aer_service_init+0x0/0x32 @ 1
[    9.477784] initcall aer_service_init+0x0/0x32 returned -6 after 0 usecs
[    9.484483] calling  pcie_pme_service_init+0x0/0x11 @ 1
[    9.489727] pcieport 0000:00:1c.0: Signaling PME with IRQ 24
[    9.495398] pcieport 0000:00:1c.4: Signaling PME with IRQ 25
[    9.501076] pcieport 0000:17:00.0: Signaling PME with IRQ 27
[    9.506754] pcieport 0000:17:02.0: Signaling PME with IRQ 28
[    9.512429] pcieport 0000:17:03.0: Signaling PME with IRQ 29
[    9.518112] pcieport 0000:85:00.0: Signaling PME with IRQ 31
[    9.523788] pcieport 0000:85:01.0: Signaling PME with IRQ 32
[    9.529463] pcieport 0000:85:02.0: Signaling PME with IRQ 33
[    9.535141] pcieport 0000:85:03.0: Signaling PME with IRQ 34
[    9.540817] pcieport 0000:ae:00.0: Signaling PME with IRQ 36
[    9.546491] pcieport 0000:ae:01.0: Signaling PME with IRQ 37
[    9.552168] pcieport 0000:ae:02.0: Signaling PME with IRQ 38
[    9.557845] pcieport 0000:ae:03.0: Signaling PME with IRQ 39
[    9.563510] initcall pcie_pme_service_init+0x0/0x11 returned 0 after 72071 usecs
[    9.570907] calling  pci_hotplug_init+0x0/0x8 @ 1
[    9.575611] initcall pci_hotplug_init+0x0/0x8 returned 0 after 0 usecs
[    9.582138] calling  pcied_init+0x0/0x56 @ 1
[    9.586416] pciehp 0000:00:1c.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[    9.598775] pciehp 0000:85:00.0:pcie004: Slot #166 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.611299] pciehp 0000:85:01.0:pcie004: Slot #167 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.611303] pciehp 0000:85:00.0:pcie004: Slot(166): Card not present
[    9.623821] pciehp 0000:85:01.0:pcie004: Slot(167): Card not present
[    9.623823] pciehp 0000:85:02.0:pcie004: Slot #168 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.623837] pciehp 0000:85:02.0:pcie004: Slot(168): Card not present
[    9.623839] pciehp 0000:85:03.0:pcie004: Slot #169 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.623854] pciehp 0000:85:03.0:pcie004: Slot(169): Card not present
[    9.623855] pciehp 0000:ae:00.0:pcie004: Slot #164 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.623870] pciehp 0000:ae:00.0:pcie004: Slot(164): Card not present
[    9.623871] pciehp 0000:ae:01.0:pcie004: Slot #165 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.623887] pciehp 0000:ae:01.0:pcie004: Slot(165): Card not present
[    9.623889] pciehp 0000:ae:02.0:pcie004: Slot #162 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.623904] pciehp 0000:ae:02.0:pcie004: Slot(162): Card not present
[    9.623906] pciehp 0000:ae:03.0:pcie004: Slot #163 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    9.623920] initcall pcied_init+0x0/0x56 returned 0 after 36633 usecs
[    9.623921] calling  pci_stub_init+0x0/0x168 @ 1
[    9.623923] pciehp 0000:ae:03.0:pcie004: Slot(163): Card not present
[    9.623946] initcall pci_stub_init+0x0/0x168 returned 0 after 22 usecs
[    9.623948] calling  vesafb_driver_init+0x0/0x13 @ 1
[    9.623955] initcall vesafb_driver_init+0x0/0x13 returned 0 after 5 usecs
[    9.623957] calling  efifb_driver_init+0x0/0x13 @ 1
[    9.623962] efifb: probing for efifb
[    9.623987] efifb: framebuffer at 0x91000000, using 3072k, total 3072k
[    9.623988] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    9.623989] efifb: scrolling: redraw
[    9.623991] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    9.825032] Console: switching to colour frame buffer device 128x48
[    9.846800] fb0: EFI VGA frame buffer device
[    9.851194] initcall efifb_driver_init+0x0/0x13 returned 0 after 221909 usecs
[    9.858526] calling  intel_idle_init+0x0/0x5e2 @ 1
[    9.863458] intel_idle: MWAIT substates: 0x2020
[    9.868112] intel_idle: v0.4.1 model 0x55
[    9.874603] intel_idle: lapic_timer_reliable_states 0xffffffff
[    9.880591] initcall intel_idle_init+0x0/0x5e2 returned 0 after 16731 usecs
[    9.887743] calling  acpi_ac_init+0x0/0x7e @ 1
[    9.892502] initcall acpi_ac_init+0x0/0x7e returned 0 after 188 usecs
[    9.899121] calling  acpi_button_driver_init+0x0/0x11 @ 1
[    9.904777] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    9.912468] ACPI: Power Button [PWRF]
[    9.916244] initcall acpi_button_driver_init+0x0/0x11 returned 0 after 11272 usecs
[    9.924026] calling  acpi_fan_driver_init+0x0/0x13 @ 1
[    9.929313] initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 6 usecs
[    9.936458] calling  acpi_processor_driver_init+0x0/0x98 @ 1
[    9.952638] initcall acpi_processor_driver_init+0x0/0x98 returned 0 after 10120 usecs
[    9.960680] calling  acpi_thermal_init+0x0/0x7f @ 1
[    9.972243] initcall acpi_thermal_init+0x0/0x7f returned 0 after 412 usecs
[    9.985773] calling  acpi_battery_init+0x0/0x30 @ 1
[    9.996918] initcall acpi_battery_init+0x0/0x30 returned 0 after 1 usecs
[   10.009786] calling  acpi_hed_driver_init+0x0/0x11 @ 1
[   10.021181] initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 62 usecs
[   10.034346] calling  bgrt_init+0x0/0xb5 @ 1
[   10.044627] initcall bgrt_init+0x0/0xb5 returned -19 after 0 usecs
[   10.057203] calling  erst_init+0x0/0x317 @ 1
[   10.067545] ERST: Error Record Serialization Table (ERST) support is initialized.
[   10.081066] pstore: using zlib compression
[   10.091205] pstore: Registered erst as persistent store backend
[   10.103137] initcall erst_init+0x0/0x317 returned 0 after 34795 usecs
[   10.115585] calling  ghes_init+0x0/0x13d @ 1
[   10.126811] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[   10.140254] initcall ghes_init+0x0/0x13d returned 0 after 14114 usecs
[   10.152752] calling  gpio_clk_driver_init+0x0/0x13 @ 1
[   10.163935] initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 3 usecs
[   10.177004] calling  plt_clk_driver_init+0x0/0x13 @ 1
[   10.188204] initcall plt_clk_driver_init+0x0/0x13 returned 0 after 3 usecs
[   10.201165] calling  dw_pci_driver_init+0x0/0x1a @ 1
[   10.212242] initcall dw_pci_driver_init+0x0/0x1a returned 0 after 31 usecs
[   10.225213] calling  n_null_init+0x0/0x1f @ 1
[   10.235628] initcall n_null_init+0x0/0x1f returned 0 after 0 usecs
[   10.247913] calling  pty_init+0x0/0x1ec @ 1
[   10.258161] initcall pty_init+0x0/0x1ec returned 0 after 29 usecs
[   10.270274] calling  sysrq_init+0x0/0x6c @ 1
[   10.280489] initcall sysrq_init+0x0/0x6c returned 0 after 2 usecs
[   10.292504] calling  serial8250_init+0x0/0x15b @ 1
[   10.303237] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.336312] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   10.370525] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   10.383938] initcall serial8250_init+0x0/0x15b returned 0 after 78808 usecs
[   10.396899] calling  serial_pci_driver_init+0x0/0x1a @ 1
[   10.408429] initcall serial_pci_driver_init+0x0/0x1a returned 0 after 137 usecs
[   10.421758] calling  exar_pci_driver_init+0x0/0x1a @ 1
[   10.432874] initcall exar_pci_driver_init+0x0/0x1a returned 0 after 31 usecs
[   10.445893] calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
[   10.457263] initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 22 usecs
[   10.470451] calling  mid8250_pci_driver_init+0x0/0x1a @ 1
[   10.481711] initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 21 usecs
[   10.494850] calling  init_kgdboc+0x0/0x16 @ 1
[   10.505074] initcall init_kgdboc+0x0/0x16 returned 0 after 0 usecs
[   10.517057] calling  raw_init+0x0/0x139 @ 1
[   10.527146] initcall raw_init+0x0/0x139 returned 0 after 96 usecs
[   10.539033] calling  hpet_init+0x0/0x65 @ 1
[   10.549177] initcall hpet_init+0x0/0x65 returned 0 after 116 usecs
[   10.561181] calling  nvram_init+0x0/0x76 @ 1
[   10.571272] Non-volatile memory driver v1.3
[   10.581176] initcall nvram_init+0x0/0x76 returned 0 after 9689 usecs
[   10.593370] calling  hwrng_modinit+0x0/0x7d @ 1
[   10.603778] initcall hwrng_modinit+0x0/0x7d returned 0 after 18 usecs
[   10.616007] calling  agp_init+0x0/0x24 @ 1
[   10.625816] Linux agpgart interface v0.103
[   10.635634] initcall agp_init+0x0/0x24 returned 0 after 9587 usecs
[   10.647542] calling  agp_amd64_mod_init+0x0/0xa @ 1
[   10.658221] initcall agp_amd64_mod_init+0x0/0xa returned -19 after 113 usecs
[   10.670935] calling  agp_intel_init+0x0/0x29 @ 1
[   10.681165] initcall agp_intel_init+0x0/0x29 returned 0 after 45 usecs
[   10.693251] calling  agp_sis_init+0x0/0x29 @ 1
[   10.703277] initcall agp_sis_init+0x0/0x29 returned 0 after 27 usecs
[   10.715201] calling  agp_via_init+0x0/0x29 @ 1
[   10.725232] initcall agp_via_init+0x0/0x29 returned 0 after 32 usecs
[   10.737048] calling  cn_proc_init+0x0/0x36 @ 1
[   10.746962] initcall cn_proc_init+0x0/0x36 returned 0 after 0 usecs
[   10.758658] calling  topology_sysfs_init+0x0/0x30 @ 1
[   10.769371] initcall topology_sysfs_init+0x0/0x30 returned 0 after 203 usecs
[   10.781866] calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
[   10.797338] initcall cacheinfo_sysfs_init+0x0/0x2c returned 174 after 4739 usecs
[   10.810259] calling  init_kgdbts+0x0/0x16 @ 1
[   10.820152] initcall init_kgdbts+0x0/0x16 returned 0 after 0 usecs
[   10.831860] calling  init_sd+0x0/0x16a @ 1
[   10.841424] initcall init_sd+0x0/0x16a returned 0 after 17 usecs
[   10.852852] calling  init_sr+0x0/0x46 @ 1
[   10.862313] initcall init_sr+0x0/0x46 returned 0 after 5 usecs
[   10.873550] calling  init_sg+0x0/0x11b @ 1
[   10.882956] initcall init_sg+0x0/0x11b returned 0 after 5 usecs
[   10.894338] calling  ahci_pci_driver_init+0x0/0x1a @ 1
[   10.904968] ahci 0000:00:11.5: version 3.0
[   10.914630] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[   10.928195] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[   10.958620] scsi host0: ahci
[   10.967141] scsi host1: ahci
[   10.975563] scsi host2: ahci
[   10.983817] scsi host3: ahci
[   10.991972] scsi host4: ahci
[   11.000055] scsi host5: ahci
[   11.007828] ata1: SATA max UDMA/133 abar m524288@0x92c80000 port 0x92c80100 irq 40
[   11.020444] ata2: SATA max UDMA/133 abar m524288@0x92c80000 port 0x92c80180 irq 40
[   11.032997] ata3: SATA max UDMA/133 abar m524288@0x92c80000 port 0x92c80200 irq 40
[   11.045468] ata4: SATA max UDMA/133 abar m524288@0x92c80000 port 0x92c80280 irq 40
[   11.058055] ata5: SATA max UDMA/133 abar m524288@0x92c80000 port 0x92c80300 irq 40
[   11.070322] ata6: SATA max UDMA/133 abar m524288@0x92c80000 port 0x92c80380 irq 40
[   11.082676] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[   11.095536] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[   11.130743] scsi host6: ahci
[   11.138497] scsi host7: ahci
[   11.146093] scsi host8: ahci
[   11.153653] scsi host9: ahci
[   11.161102] scsi host10: ahci
[   11.168558] scsi host11: ahci
[   11.175911] scsi host12: ahci
[   11.183207] scsi host13: ahci
[   11.190185] ata7: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00100 irq 41
[   11.201964] ata8: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00180 irq 41
[   11.213679] ata9: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00200 irq 41
[   11.225294] ata10: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00280 irq 41
[   11.237092] ata11: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00300 irq 41
[   11.248756] ata12: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00380 irq 41
[   11.260345] ata13: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00400 irq 41
[   11.271788] ata14: SATA max UDMA/133 abar m524288@0x92c00000 port 0x92c00480 irq 41
[   11.283365] initcall ahci_pci_driver_init+0x0/0x1a returned 0 after 369581 usecs
[   11.294485] calling  net_olddevs_init+0x0/0x5d @ 1
[   11.302997] initcall net_olddevs_init+0x0/0x5d returned 0 after 2 usecs
[   11.313369] calling  cavium_ptp_init_module+0x0/0x1a @ 1
[   11.322465] initcall cavium_ptp_init_module+0x0/0x1a returned 0 after 16 usecs
[   11.333496] calling  cdrom_init+0x0/0x16 @ 1
[   11.341585] initcall cdrom_init+0x0/0x16 returned 0 after 3 usecs
[   11.351511] calling  mon_init+0x0/0x127 @ 1
[   11.359639] initcall mon_init+0x0/0x127 returned 0 after 100 usecs
[   11.369668] calling  ehci_hcd_init+0x0/0xbc @ 1
[   11.378037] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.388467] initcall ehci_hcd_init+0x0/0xbc returned 0 after 10185 usecs
[   11.389602] ata1: SATA link down (SStatus 0 SControl 300)
[   11.399053] calling  ehci_pci_init+0x0/0x65 @ 1
[   11.399055] ehci-pci: EHCI PCI platform driver
[   11.408281] ata4: SATA link down (SStatus 0 SControl 300)
[   11.416702] initcall ehci_pci_init+0x0/0x65 returned 0 after 17233 usecs
[   11.425162] ata6: SATA link down (SStatus 0 SControl 300)
[   11.434597] calling  ohci_hcd_mod_init+0x0/0x8d @ 1
[   11.434599] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.445689] ata2: SATA link down (SStatus 0 SControl 300)
[   11.455434] initcall ohci_hcd_mod_init+0x0/0x8d returned 0 after 20347 usecs
[   11.464669] ata5: SATA link down (SStatus 0 SControl 300)
[   11.475226] calling  ohci_pci_init+0x0/0x65 @ 1
[   11.475228] ohci-pci: OHCI PCI platform driver
[   11.485233] ata3: SATA link down (SStatus 0 SControl 300)
[   11.497017] initcall ohci_pci_init+0x0/0x65 returned 0 after 21262 usecs
[   11.547560] calling  uhci_hcd_init+0x0/0x112 @ 1
[   11.556970] uhci_hcd: USB Universal Host Controller Interface driver
[   11.568352] initcall uhci_hcd_init+0x0/0x112 returned 0 after 11115 usecs
[   11.580270] calling  xhci_hcd_init+0x0/0x1f @ 1
[   11.589881] ata10: SATA link down (SStatus 0 SControl 300)
[   11.589915] initcall xhci_hcd_init+0x0/0x1f returned 0 after 0 usecs
[   11.600723] ata12: SATA link down (SStatus 0 SControl 300)
[   11.612473] calling  xhci_pci_init+0x0/0x43 @ 1
[   11.612644] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.623536] ata14: SATA link down (SStatus 0 SControl 300)
[   11.633586] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[   11.644370] ata8: SATA link down (SStatus 0 SControl 300)
[   11.656670] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[   11.668699] ata13: SATA link down (SStatus 0 SControl 300)
[   11.679913] xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
[   11.694536] ata9: SATA link down (SStatus 0 SControl 300)
[   11.706407] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   11.719482] ata7: SATA link down (SStatus 0 SControl 300)
[   11.731148] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.744351] ata11: SATA link down (SStatus 0 SControl 300)
[   11.756104] usb usb1: Product: xHCI Host Controller
[   11.794034] usb usb1: Manufacturer: Linux 4.16.0-rc2+ xhci-hcd
[   11.806381] usb usb1: SerialNumber: 0000:00:14.0
[   11.817609] hub 1-0:1.0: USB hub found
[   11.827833] hub 1-0:1.0: 16 ports detected
[   11.839167] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.851068] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[   11.865337] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   11.878560] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.892178] usb usb2: Product: xHCI Host Controller
[   11.903435] usb usb2: Manufacturer: Linux 4.16.0-rc2+ xhci-hcd
[   11.915963] usb usb2: SerialNumber: 0000:00:14.0
[   11.927023] hub 2-0:1.0: USB hub found
[   11.937015] hub 2-0:1.0: 10 ports detected
[   11.947718] usb: port power management may be unreliable
[   11.959548] initcall xhci_pci_init+0x0/0x43 returned 0 after 338937 usecs
[   11.972567] calling  kgdbdbgp_start_thread+0x0/0x4d @ 1
[   11.983976] initcall kgdbdbgp_start_thread+0x0/0x4d returned 0 after 0 usecs
[   11.997195] calling  i8042_init+0x0/0x462 @ 1
[   12.007715] i8042: PNP: No PS/2 controller found.
[   12.018571] initcall i8042_init+0x0/0x462 returned -19 after 10612 usecs
[   12.031514] calling  serport_init+0x0/0x2d @ 1
[   12.042128] initcall serport_init+0x0/0x2d returned 0 after 0 usecs
[   12.054600] calling  evdev_init+0x0/0x11 @ 1
[   12.065088] initcall evdev_init+0x0/0x11 returned 0 after 96 usecs
[   12.077361] calling  atkbd_init+0x0/0x26 @ 1
[   12.087691] initcall atkbd_init+0x0/0x26 returned 0 after 8 usecs
[   12.099826] calling  psmouse_init+0x0/0x85 @ 1
[   12.110275] initcall psmouse_init+0x0/0x85 returned 0 after 13 usecs
[   12.122606] calling  cmos_init+0x0/0x6c @ 1
[   12.132758] rtc_cmos 00:00: RTC can wake from S4
[   12.143595] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[   12.155679] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   12.169297] initcall cmos_init+0x0/0x6c returned 0 after 35701 usecs
[   12.178104] usb 1-13: new full-speed USB device number 2 using xhci_hcd
[   12.181591] calling  ptp_kvm_init+0x0/0xf1 @ 1
[   12.181593] initcall ptp_kvm_init+0x0/0xf1 returned -19 after 0 usecs
[   12.216620] calling  dm_init+0x0/0x47 @ 1
[   12.226424] device-mapper: uevent: version 1.0.3
[   12.236801] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[   12.250979] initcall dm_init+0x0/0x47 returned 0 after 24022 usecs
[   12.262885] calling  dm_bufio_init+0x0/0x147 @ 1
[   12.273443] initcall dm_bufio_init+0x0/0x147 returned 0 after 301 usecs
[   12.285712] calling  dm_snapshot_init+0x0/0x20f @ 1
[   12.296287] initcall dm_snapshot_init+0x0/0x20f returned 0 after 14 usecs
[   12.308760] calling  dm_mirror_init+0x0/0x2a @ 1
[   12.319058] initcall dm_mirror_init+0x0/0x2a returned 0 after 0 usecs
[   12.323147] usb 1-13: New USB device found, idVendor=9999, idProduct=0120
[   12.331265] calling  dm_dirty_log_init+0x0/0x50 @ 1
[   12.331267] initcall dm_dirty_log_init+0x0/0x50 returned 0 after 0 usecs
[   12.343885] usb 1-13: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   12.354718] calling  dm_zero_init+0x0/0x2a @ 1
[   12.354720] initcall dm_zero_init+0x0/0x2a returned 0 after 0 usecs
[   12.367204] usb 1-13: Product: CAT5 Adapter
[   12.380277] calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
[   12.390511] usb 1-13: Manufacturer: Generic
[   12.390513] usb 1-13: SerialNumber: 000017147780
[   12.402577] initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 0 usecs
[   12.458228] calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
[   12.469753] initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 0 usecs
[   12.483148] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[   12.494166] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 0 usecs
[   12.506992] calling  intel_pstate_init+0x0/0x31c @ 1
[   12.517774] intel_pstate: Intel P-state driver initializing
[   12.528076] usb 1-14: new high-speed USB device number 3 using xhci_hcd
[   12.549902] intel_pstate: HWP enabled
[   12.559760] initcall intel_pstate_init+0x0/0x31c returned 0 after 41001 usecs
[   12.572947] calling  dmi_sysfs_init+0x0/0xdc @ 1
[   12.583774] initcall dmi_sysfs_init+0x0/0xdc returned 0 after 156 usecs
[   12.596503] calling  efivars_sysfs_init+0x0/0x210 @ 1
[   12.608193] EFI Variables Facility v0.08 2004-May-17
[   12.672111] usb 1-14: New USB device found, idVendor=1604, idProduct=10c0
[   12.713362] initcall efivars_sysfs_init+0x0/0x210 returned 0 after 102702 usecs
[   12.718198] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   12.731766] calling  esrt_sysfs_init+0x0/0x2ef @ 1
[   12.731768] initcall esrt_sysfs_init+0x0/0x2ef returned -38 after 0 usecs
[   12.745661] hub 1-14:1.0: USB hub found
[   12.756369] calling  efivars_pstore_init+0x0/0x9a @ 1
[   12.756371] initcall efivars_pstore_init+0x0/0x9a returned 0 after 0 usecs
[   12.769445] hub 1-14:1.0: 4 ports detected
[   12.779375] calling  hid_init+0x0/0x5d @ 1
[   12.779381] hidraw: raw HID events driver (C) Jiri Kosina
[   12.835431] initcall hid_init+0x0/0x5d returned 0 after 54740 usecs
[   12.847923] calling  hid_generic_init+0x0/0x1a @ 1
[   12.858707] initcall hid_generic_init+0x0/0x1a returned 0 after 5 usecs
[   12.871346] calling  a4_driver_init+0x0/0x1a @ 1
[   12.881940] initcall a4_driver_init+0x0/0x1a returned 0 after 3 usecs
[   12.894438] calling  apple_driver_init+0x0/0x1a @ 1
[   12.905301] initcall apple_driver_init+0x0/0x1a returned 0 after 4 usecs
[   12.918097] calling  belkin_driver_init+0x0/0x1a @ 1
[   12.929102] initcall belkin_driver_init+0x0/0x1a returned 0 after 2 usecs
[   12.941846] calling  ch_driver_init+0x0/0x1a @ 1
[   12.952448] initcall ch_driver_init+0x0/0x1a returned 0 after 2 usecs
[   12.964798] calling  ch_driver_init+0x0/0x1a @ 1
[   12.975173] initcall ch_driver_init+0x0/0x1a returned 0 after 2 usecs
[   12.987505] calling  cp_driver_init+0x0/0x1a @ 1
[   12.997850] initcall cp_driver_init+0x0/0x1a returned 0 after 2 usecs
[   13.010007] calling  ez_driver_init+0x0/0x1a @ 1
[   13.020260] initcall ez_driver_init+0x0/0x1a returned 0 after 3 usecs
[   13.032396] calling  ite_driver_init+0x0/0x1a @ 1
[   13.042732] initcall ite_driver_init+0x0/0x1a returned 0 after 2 usecs
[   13.054923] calling  ks_driver_init+0x0/0x1a @ 1
[   13.065247] initcall ks_driver_init+0x0/0x1a returned 0 after 2 usecs
[   13.077482] calling  lg_driver_init+0x0/0x1a @ 1
[   13.087784] initcall lg_driver_init+0x0/0x1a returned 0 after 3 usecs
[   13.099830] calling  ms_driver_init+0x0/0x1a @ 1
[   13.109940] initcall ms_driver_init+0x0/0x1a returned 0 after 2 usecs
[   13.121859] calling  mr_driver_init+0x0/0x1a @ 1
[   13.131866] initcall mr_driver_init+0x0/0x1a returned 0 after 2 usecs
[   13.143649] calling  hid_init+0x0/0x59 @ 1
[   13.155882] hid-generic 0003:9999:0120.0001: collection stack underflow
[   13.167889] hid-generic 0003:9999:0120.0001: item 0 0 0 12 parsing failed
[   13.179999] hid-generic: probe of 0003:9999:0120.0001 failed with error -22
[   13.194701] input: Generic CAT5 Adapter as /devices/pci0000:00/0000:00:14.0/usb1/1-13/1-13:1.1/0003:9999:0120.0002/input/input1
[   13.217328] hid-generic 0003:9999:0120.0002: input,hidraw0: USB HID v1.00 Mouse [Generic CAT5 Adapter] on usb-0000:00:14.0-13/input1
[   13.240795] usbcore: registered new interface driver usbhid
[   13.252249] usbhid: USB HID core driver
[   13.261894] initcall hid_init+0x0/0x59 returned 0 after 106337 usecs
[   13.274156] calling  smartconnect_driver_init+0x0/0x11 @ 1
[   13.285636] initcall smartconnect_driver_init+0x0/0x11 returned 0 after 39 usecs
[   13.298972] calling  pmc_atom_init+0x0/0x283 @ 1
[   13.309558] initcall pmc_atom_init+0x0/0x283 returned -19 after 20 usecs
[   13.322244] calling  powercap_init+0x0/0x2a7 @ 1
[   13.332779] initcall powercap_init+0x0/0x2a7 returned 0 after 23 usecs
[   13.345223] calling  pm_check_save_msr+0x0/0x20 @ 1
[   13.356015] initcall pm_check_save_msr+0x0/0x20 returned 0 after 0 usecs
[   13.368655] calling  sock_diag_init+0x0/0x34 @ 1
[   13.379522] initcall sock_diag_init+0x0/0x34 returned 0 after 286 usecs
[   13.392050] calling  init_net_drop_monitor+0x0/0x103 @ 1
[   13.403331] drop_monitor: Initializing network drop monitor service
[   13.415769] initcall init_net_drop_monitor+0x0/0x103 returned 0 after 12145 usecs
[   13.429352] calling  xt_init+0x0/0x105 @ 1
[   13.439530] initcall xt_init+0x0/0x105 returned 0 after 45 usecs
[   13.451745] calling  tcpudp_mt_init+0x0/0x16 @ 1
[   13.462475] initcall tcpudp_mt_init+0x0/0x16 returned 0 after 0 usecs
[   13.475063] calling  gre_offload_init+0x0/0x49 @ 1
[   13.486034] initcall gre_offload_init+0x0/0x49 returned 0 after 0 usecs
[   13.498925] calling  sysctl_ipv4_init+0x0/0x4c @ 1
[   13.509930] initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 27 usecs
[   13.512077] usb 1-14.1: new high-speed USB device number 4 using xhci_hcd
[   13.522870] calling  fou_init+0x0/0xa7 @ 1
[   13.522874] initcall fou_init+0x0/0xa7 returned 0 after 2 usecs
[   13.522875] calling  tunnel4_init+0x0/0x59 @ 1
[   13.522879] initcall tunnel4_init+0x0/0x59 returned 0 after 0 usecs
[   13.581751] calling  ip_tables_init+0x0/0x8e @ 1
[   13.592632] initcall ip_tables_init+0x0/0x8e returned 0 after 3 usecs
[   13.605394] calling  cubictcp_register+0x0/0x59 @ 1
[   13.613637] usb 1-14.1: New USB device found, idVendor=1604, idProduct=10c0
[   13.616622] initcall cubictcp_register+0x0/0x59 returned 0 after 0 usecs
[   13.616624] calling  xfrm_user_init+0x0/0x48 @ 1
[   13.616624] Initializing XFRM netlink socket
[   13.616630] initcall xfrm_user_init+0x0/0x48 returned 0 after 4 usecs
[   13.629993] usb 1-14.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   13.643238] calling  inet6_init+0x0/0x33d @ 1
[   13.643424] NET: Registered protocol family 10
[   13.654746] hub 1-14.1:1.0: USB hub found
[   13.666034] Segment Routing with IPv6
[   13.678083] hub 1-14.1:1.0: 4 ports detected
[   13.692006] initcall inet6_init+0x0/0x33d returned 0 after 47620 usecs
[   13.755048] calling  tunnel6_init+0x0/0x72 @ 1
[   13.765521] initcall tunnel6_init+0x0/0x72 returned 0 after 0 usecs
[   13.767019] usb 1-14.4: new high-speed USB device number 5 using xhci_hcd
[   13.777645] calling  xfrm6_transport_init+0x0/0x16 @ 1
[   13.777648] initcall xfrm6_transport_init+0x0/0x16 returned 0 after 0 usecs
[   13.777649] calling  xfrm6_mode_tunnel_init+0x0/0x16 @ 1
[   13.777652] initcall xfrm6_mode_tunnel_init+0x0/0x16 returned 0 after 0 usecs
[   13.838135] calling  xfrm6_beet_init+0x0/0x16 @ 1
[   13.848586] initcall xfrm6_beet_init+0x0/0x16 returned 0 after 0 usecs
[   13.860889] calling  sit_init+0x0/0xc4 @ 1
[   13.866720] usb 1-14.4: New USB device found, idVendor=1604, idProduct=10c0
[   13.870736] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   13.870941] initcall sit_init+0x0/0xc4 returned 0 after 197 usecs
[   13.883496] usb 1-14.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   13.895266] calling  ip6_tunnel_init+0x0/0xce @ 1
[   13.895489] initcall ip6_tunnel_init+0x0/0xce returned 0 after 215 usecs
[   13.907597] hub 1-14.4:1.0: USB hub found
[   13.920432] calling  fou6_init+0x0/0x67 @ 1
[   13.920434] initcall fou6_init+0x0/0x67 returned 0 after 0 usecs
[   13.931161] hub 1-14.4:1.0: 4 ports detected
[   13.943707] calling  packet_init+0x0/0x42 @ 1
[   13.943708] NET: Registered protocol family 17
[   14.005838] initcall packet_init+0x0/0x42 returned 0 after 60673 usecs
[   14.018202] calling  dcbnl_init+0x0/0x4d @ 1
[   14.028241] initcall dcbnl_init+0x0/0x4d returned 0 after 0 usecs
[   14.040149] calling  mcheck_init_device+0x0/0x12f @ 1
[   14.065524] initcall mcheck_init_device+0x0/0x12f returned 0 after 14191 usecs
[   14.078648] calling  tboot_late_init+0x0/0x2a8 @ 1
[   14.089203] initcall tboot_late_init+0x0/0x2a8 returned 0 after 0 usecs
[   14.101687] calling  mcheck_late_init+0x0/0x70 @ 1
[   14.112322] initcall mcheck_late_init+0x0/0x70 returned 0 after 3 usecs
[   14.124743] calling  severities_debugfs_init+0x0/0x3b @ 1
[   14.135902] initcall severities_debugfs_init+0x0/0x3b returned 0 after 0 usecs
[   14.148931] calling  threshold_init_device+0x0/0x4b @ 1
[   14.159944] initcall threshold_init_device+0x0/0x4b returned 0 after 0 usecs
[   14.172789] calling  microcode_init+0x0/0x1fb @ 1
[   14.183198] microcode: sig=0x50654, pf=0x80, revision=0x200003c
[   14.200043] microcode: Microcode Update Driver: v2.2.
[   14.200044] initcall microcode_init+0x0/0x1fb returned 0 after 16472 usecs
[   14.223443] calling  hpet_insert_resource+0x0/0x23 @ 1
[   14.234543] initcall hpet_insert_resource+0x0/0x23 returned 0 after 1 usecs
[   14.247396] calling  update_mp_table+0x0/0x509 @ 1
[   14.258019] initcall update_mp_table+0x0/0x509 returned 0 after 0 usecs
[   14.270425] calling  lapic_insert_resource+0x0/0x3f @ 1
[   14.281470] initcall lapic_insert_resource+0x0/0x3f returned 0 after 0 usecs
[   14.294321] calling  print_ICs+0x0/0x18d @ 1
[   14.304306] initcall print_ICs+0x0/0x18d returned 0 after 0 usecs
[   14.316197] calling  pat_memtype_list_init+0x0/0x32 @ 1
[   14.327189] initcall pat_memtype_list_init+0x0/0x32 returned 0 after 1 usecs
[   14.340060] calling  create_tlb_single_page_flush_ceiling+0x0/0x29 @ 1
[   14.352402] initcall create_tlb_single_page_flush_ceiling+0x0/0x29 returned 0 after 0 usecs
[   14.366630] calling  create_init_pkru_value+0x0/0x29 @ 1
[   14.377776] initcall create_init_pkru_value+0x0/0x29 returned 0 after 0 usecs
[   14.390708] calling  aesni_init+0x0/0x204 @ 1
[   14.400777] AVX2 version of gcm_enc/dec engaged.
[   14.411087] AES CTR mode by8 optimization enabled
[   14.448553] initcall aesni_init+0x0/0x204 returned 0 after 46650 usecs
[   14.460656] calling  init_oops_id+0x0/0x40 @ 1
[   14.470652] initcall init_oops_id+0x0/0x40 returned 0 after 1 usecs
[   14.482474] calling  sched_clock_init_late+0x0/0x95 @ 1
[   14.493318] sched_clock: Marking stable (14493316671, 0)->(19588313198, -5094996527)
[   14.507606] initcall sched_clock_init_late+0x0/0x95 returned 0 after 13951 usecs
[   14.520825] calling  sched_init_debug+0x0/0x3e @ 1
[   14.531437] initcall sched_init_debug+0x0/0x3e returned 0 after 3 usecs
[   14.543959] calling  pm_qos_power_init+0x0/0xad @ 1
[   14.554794] initcall pm_qos_power_init+0x0/0xad returned 0 after 117 usecs
[   14.567500] calling  pm_debugfs_init+0x0/0x24 @ 1
[   14.578046] initcall pm_debugfs_init+0x0/0x24 returned 0 after 5 usecs
[   14.590410] calling  printk_late_init+0x0/0x122 @ 1
[   14.601124] initcall printk_late_init+0x0/0x122 returned 0 after 0 usecs
[   14.613634] calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
[   14.625012] initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 1 usecs
[   14.638164] calling  debugfs_kprobe_init+0x0/0xd2 @ 1
[   14.649102] initcall debugfs_kprobe_init+0x0/0xd2 returned 0 after 3 usecs
[   14.661796] calling  taskstats_init+0x0/0x37 @ 1
[   14.672256] registered taskstats version 1
[   14.682106] initcall taskstats_init+0x0/0x37 returned 0 after 9622 usecs
[   14.694708] calling  kdb_ftrace_register+0x0/0x2d @ 1
[   14.705620] initcall kdb_ftrace_register+0x0/0x2d returned 0 after 1 usecs
[   14.718349] calling  load_system_certificate_list+0x0/0xea @ 1
[   14.730046] Loading compiled-in X.509 certificates
[   14.788338] Loaded X.509 cert 'Build time autogenerated kernel key: 9f61154e2155a4a5c2d7d0ca68f8dde2ba82ebea'
[   14.804235] initcall load_system_certificate_list+0x0/0xea returned 0 after 72445 usecs
[   14.818341] calling  fault_around_debugfs+0x0/0x35 @ 1
[   14.829597] initcall fault_around_debugfs+0x0/0x35 returned 0 after 1 usecs
[   14.842721] calling  max_swapfiles_check+0x0/0x8 @ 1
[   14.853990] initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
[   14.867135] calling  init_zswap+0x0/0x446 @ 1
[   14.877803] zswap: loaded using pool lzo/zbud
[   14.888775] initcall init_zswap+0x0/0x446 returned 0 after 10828 usecs
[   14.901465] calling  split_huge_pages_debugfs+0x0/0x35 @ 1
[   14.913168] initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 2 usecs
[   14.926731] calling  check_early_ioremap_leak+0x0/0x39 @ 1
[   14.938523] initcall check_early_ioremap_leak+0x0/0x39 returned 0 after 0 usecs
[   14.952196] calling  init_root_keyring+0x0/0xa @ 1
[   14.963174] initcall init_root_keyring+0x0/0xa returned 0 after 5 usecs
[   14.976090] calling  big_key_init+0x0/0x95 @ 1
[   14.994425] Key type big_key registered
[   15.004663] initcall big_key_init+0x0/0x95 returned 0 after 17325 usecs
[   15.017493] calling  prandom_reseed+0x0/0x2a @ 1
[   15.028565] initcall prandom_reseed+0x0/0x2a returned 0 after 161 usecs
[   15.041326] calling  init_error_injection+0x0/0x6a @ 1
[   15.052719] initcall init_error_injection+0x0/0x6a returned 0 after 5 usecs
[   15.066404] calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
[   15.078898] initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 1 usecs
[   15.092982] calling  pci_sysfs_init+0x0/0x50 @ 1
[   15.105066] initcall pci_sysfs_init+0x0/0x50 returned 0 after 1428 usecs
[   15.117771] calling  bert_init+0x0/0x23b @ 1
[   15.128062] initcall bert_init+0x0/0x23b returned 0 after 11 usecs
[   15.140231] calling  clk_debug_init+0x0/0x13e @ 1
[   15.150948] initcall clk_debug_init+0x0/0x13e returned 0 after 5 usecs
[   15.163468] calling  dmar_free_unused_resources+0x0/0xcd @ 1
[   15.175287] initcall dmar_free_unused_resources+0x0/0xcd returned 0 after 0 usecs
[   15.189438] calling  deferred_probe_initcall+0x0/0x30 @ 1
[   15.201062] initcall deferred_probe_initcall+0x0/0x30 returned 0 after 3 usecs
[   15.214528] calling  late_resume_init+0x0/0x1a0 @ 1
[   15.225502]   Magic number: 6:934:384
[   15.235136] machinecheck machinecheck32: hash matches
[   15.246208] usb usb2: hash matches
[   15.255686] clockevents clockevent101: hash matches
[   15.266672] initcall late_resume_init+0x0/0x1a0 returned 0 after 40203 usecs
[   15.279751] calling  rtc_hctosys+0x0/0x102 @ 1
[   15.290289] rtc_cmos 00:00: setting system clock to 2018-02-22 14:23:24 UTC (1519309404)
[   15.304515] initcall rtc_hctosys+0x0/0x102 returned 0 after 14014 usecs
[   15.317181] calling  firmware_memmap_init+0x0/0x33 @ 1
[   15.328248] initcall firmware_memmap_init+0x0/0x33 returned 0 after 13 usecs
[   15.341157] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[   15.353152] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 0 usecs
[   15.366947] calling  efi_shutdown_init+0x0/0x3c @ 1
[   15.377730] initcall efi_shutdown_init+0x0/0x3c returned 0 after 0 usecs
[   15.390315] calling  pci_mmcfg_late_insert_resources+0x0/0x51 @ 1
[   15.402329] initcall pci_mmcfg_late_insert_resources+0x0/0x51 returned 0 after 0 usecs
[   15.416179] calling  tcp_congestion_default+0x0/0x18 @ 1
[   15.427388] initcall tcp_congestion_default+0x0/0x18 returned 0 after 0 usecs
[   15.440449] calling  software_resume+0x0/0x290 @ 1
[   15.451166] initcall software_resume+0x0/0x290 returned -2 after 1 usecs
[   15.463811] calling  clear_boot_tracer+0x0/0x26 @ 1
[   15.474541] initcall clear_boot_tracer+0x0/0x26 returned 0 after 0 usecs
[   15.487154] calling  fb_logo_late_init+0x0/0xf @ 1
[   15.497790] initcall fb_logo_late_init+0x0/0xf returned 0 after 0 usecs
[   15.510302] calling  clk_disable_unused+0x0/0x170 @ 1
[   15.521221] initcall clk_disable_unused+0x0/0x170 returned 0 after 0 usecs
[   15.536060] Freeing unused kernel memory: 1692K
[   15.546498] Write protecting the kernel read-only data: 16384k
[   15.559405] Freeing unused kernel memory: 2016K
[   15.571140] Freeing unused kernel memory: 708K
[   15.773829] systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN 
default-hierarchy=hybrid)
[   15.826893] systemd[1]: Detected architecture x86-64.
[   15.838156] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 27 (Server Edition) dracut-046-8.git20180105.fc27 (Initramfs)!

[   15.860130] systemd[1]: No hostname configured.
[   15.870879] systemd[1]: Set hostname to <localhost>.
[   15.881957] systemd[1]: Initializing machine ID from random generator.
[   15.985696] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[   16.005054] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[   16.024063] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[   16.042348] systemd[1]: Created slice System Slice.
[  OK  ] Created slice System Slice.
[  OK  ] Reached target Slices.
[  OK  ] Listening on Journal Socket.
         Starting Setup Virtual Console...
         Starting dracut cmdline hook...
[  OK  ] Reached target Swap.
         Starting Apply Kernel Variables...
[  OK  ] Reached target Local File Systems.
         Starting Journal Service...
         Starting Create Volatile Files and Directories...
         Starting Create list of required st��…ce nodes for the current kernel...
[  OK  ] Listening on udev Control Socket.
[  OK  ] Reached target Timers.
[  OK  ] Started Setup Virtual Console.
[   16.160225] audit: type=1130 audit(1519309405.369:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? te
rminal=? res=success'
[   16.193646] audit: type=1131 audit(1519309405.369:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? te
rminal=? res=success'
[  OK  ] Started Apply Kernel Variables.
[   16.235256] audit: type=1130 audit(1519309405.444:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
 res=success'
[  OK  ] Started Create Volatile Files and Directories.
[   16.279118] audit: type=1130 audit(1519309405.488:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? te
rminal=? res=success'
[  OK  ] Started Create list of required sta��…vice nodes for the current kernel.
[   16.326216] audit: type=1130 audit(1519309405.535:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? termina
l=? res=success'
[  OK  ] Started Journal Service.
[   16.369174] audit: type=1130 audit(1519309405.578:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal
=? res=success'
[  OK  ] Started dracut cmdline hook.
[   16.414124] audit: type=1130 audit(1519309405.623:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
 res=success'
         Startin[   16.453021] calling  iscsi_transport_init+0x0/0x1000 [scsi_transport_iscsi] @ 960
g Open-iSCSI...
[   16.470661] Loading iSCSI transport class v2.0-870.
[   16.470780] initcall iscsi_transport_init+0x0/0x1000 [scsi_transport_iscsi] returned 0 after 110 usecs
         Starting dracut pre-udev hook...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Open-iSCSI.
[   16.518243] audit: type=1130 audit(1519309405.727:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=iscsid comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=suc
cess'
[  OK  ] Started Create Static Device Nodes in /dev.
[   16.565200] audit: type=1130 audit(1519309405.774:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr
=? terminal=? res=success'
[   16.618149] calling  init_sunrpc+0x0/0x6e [sunrpc] @ 977
[   16.634414] RPC: Registered named UNIX socket transport module.
[   16.650618] RPC: Registered udp transport module.
[   16.665524] RPC: Registered tcp transport module.
[   16.680281] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   16.696883] initcall init_sunrpc+0x0/0x6e [sunrpc] returned 0 after 61439 usecs
[  OK  ] Started dracut pre-udev hook.
[   16.858215] audit: type=1130 audit(1519309406.067:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal
=? res=success'
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting dracut pre-trigger hook...
[  OK  ] Started dracut pre-trigger hook.
         Starting udev Coldplug all Devices...
         Mounting Kernel Configuration File System...
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Started udev Coldplug all Devices.
         Starting dracut initqueue hook...
         Starting Show Plymouth Boot Screen...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on Open-iSCSI iscsiuio Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
[   17.358855] calling  dca_init+0x0/0x1d [dca] @ 1114
[   17.373816] dca service started, version 1.12.1
[   17.388274] initcall dca_init+0x0/0x1d [dca] returned 0 after 14117 usecs
[   17.405782] calling  megasas_init+0x0/0x1000 [megaraid_sas] @ 1108
[   17.422136] megasas: 07.704.04.00-rc1
[   17.436349] megaraid_sas 0000:18:00.0: FW now in Ready state
[   17.436397] calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 1089
[   17.452316] megaraid_sas 0000:18:00.0: 64 bit DMA mask and 32 bit consistent mask
[   17.469646] initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 148 usecs
[   17.490458] megaraid_sas 0000:18:00.0: firmware supports msix        : (96)
[   17.523435] megaraid_sas 0000:18:00.0: current msix/online cpus      : (96/104)
[   17.540676] megaraid_sas 0000:18:00.0: RDPQ mode     : (disabled)
[   17.540679] megaraid_sas 0000:18:00.0: Current firmware supports maximum commands: 928        LDIO threshold: 0
[   17.541087] megaraid_sas 0000:18:00.0: Configured max firmware commands: 927
[   17.594103] calling  igb_init_module+0x0/0x1000 [igb] @ 1099
[   17.596665] megaraid_sas 0000:18:00.0: FW supports sync cache        : No
[   17.609421] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[   17.609422] igb: Copyright (c) 2007-2014 Intel Corporation.
[   17.664305] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 1089
[   17.664654] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 336 usecs
[   17.665275] calling  ixgbe_init_module+0x0/0x1000 [ixgbe] @ 1074
[   17.665278] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
[   17.665279] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   17.671740] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 1197
[   17.671937] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 187 usecs
[   17.678012] megaraid_sas 0000:18:00.0: Init cmd return status SUCCESS for SCSI host 14
[   17.701071] megaraid_sas 0000:18:00.0: firmware type : Extended VD(240 VD)firmware
[   17.816968] megaraid_sas 0000:18:00.0: controller type       : MR(2048MB)
[   17.816969] megaraid_sas 0000:18:00.0: Online Controller Reset(OCR)  : Enabled
[   17.816970] megaraid_sas 0000:18:00.0: Secure JBOD support   : No
[   17.816971] megaraid_sas 0000:18:00.0: NVMe passthru support : No
[   17.832806] igb 0000:1a:00.0: added PHC on eth0
[   17.884517] igb 0000:1a:00.0: Intel(R) Gigabit Ethernet Network Connection
[   17.884518] igb 0000:1a:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 24:6e:96:78:2e:ba
[   17.884808] igb 0000:1a:00.0: eth0: PBA No: J24844-010
[   17.925219] igb 0000:1a:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   17.925709] megaraid_sas 0000:18:00.0: INIT adapter done
[   17.952759] megaraid_sas 0000:18:00.0: Jbod map is not supported megasas_setup_jbod_map 5133
[   17.952895] megaraid_sas 0000:18:00.0: pci id                : (0x1000)/(0x005d)/(0x1028)/(0x1f47)
[   17.983199] megaraid_sas 0000:18:00.0: unevenspan support    : yes
[   17.983200] megaraid_sas 0000:18:00.0: firmware crash dump   : no
[   17.983200] megaraid_sas 0000:18:00.0: jbod sync map         : no
[   17.983203] scsi host14: Avago SAS based MegaRAID driver
[   17.983918] initcall megasas_init+0x0/0x1000 [megaraid_sas] returned 0 after 548601 usecs
[   18.044918] igb 0000:1a:00.1: added PHC on eth1
[   18.059087] igb 0000:1a:00.1: Intel(R) Gigabit Ethernet Network Connection
[   18.072940] igb 0000:1a:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 24:6e:96:78:2e:bb
[   18.087493] igb 0000:1a:00.1: eth1: PBA No: J24844-010
[   18.099699] igb 0000:1a:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   18.114561] scsi 14:2:0:0: Direct-Access     DELL     PERC H730P Mini  4.27 PQ: 0 ANSI: 5
[   18.114762] initcall igb_init_module+0x0/0x1000 [igb] returned 0 after 493478 usecs
[   18.146855] igb 0000:1a:00.0 eno3: renamed from eth0
[   18.166986] igb 0000:1a:00.1 eno4: renamed from eth1
[   18.213876] sd 14:2:0:0: Attached scsi generic sg0 type 0
[   18.213922] sd 14:2:0:0: [sda] 233308160 512-byte logical blocks: (119 GB/111 GiB)
[   18.240939] sd 14:2:0:0: [sda] 4096-byte physical blocks
[   18.253240] sd 14:2:0:0: [sda] Write Protect is off
[   18.264899] sd 14:2:0:0: [sda] Mode Sense: 1f 00 00 08
[   18.276843] sd 14:2:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   18.297172]  sda: sda1 sda2 sda3
[   18.307695] sd 14:2:0:0: [sda] Attached SCSI disk
[   18.517630] ixgbe 0000:19:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[   18.633636] ixgbe 0000:19:00.0: PCI Express bandwidth of 32GT/s available
[   18.647399] ixgbe 0000:19:00.0: (Speed:8.0GT/s, Width: x4, Encoding Loss:<2%)
[   18.775292] ixgbe 0000:19:00.0: MAC: 4, PHY: 0, PBA No: J24844-010
[   18.788332] ixgbe 0000:19:00.0: 24:6e:96:78:2e:b8
[   18.962088] ixgbe 0000:19:00.0: Intel(R) 10 Gigabit Network Connection
[   19.579270] ixgbe 0000:19:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[   19.695572] ixgbe 0000:19:00.1: PCI Express bandwidth of 32GT/s available
[   19.709212] ixgbe 0000:19:00.1: (Speed:8.0GT/s, Width: x4, Encoding Loss:<2%)
[   19.837016] ixgbe 0000:19:00.1: MAC: 4, PHY: 0, PBA No: J24844-010
[   19.850146] ixgbe 0000:19:00.1: 24:6e:96:78:2e:b9
[   20.023933] ixgbe 0000:19:00.1: Intel(R) 10 Gigabit Network Connection
[   20.037382] initcall ixgbe_init_module+0x0/0x1000 [ixgbe] returned 0 after 2316487 usecs
[   20.055933] ixgbe 0000:19:00.1 eno2: renamed from eth1
[   20.075892] ixgbe 0000:19:00.0 eno1: renamed from eth0
[  201.706075] sd 14:2:0:0: [sda] tag#0 task abort called for scmd(00000000c342d874)
[  201.720357] sd 14:2:0:0: [sda] tag#0 CDB: Read(10) 28 00 0d e7 ff 80 00 00 08 00
[  201.734621] sd 14:2:0:0: task abort: FAILED scmd(00000000c342d874)
[  201.754134] sd 14:2:0:0: target reset called for scmd(00000000c342d874)
[  201.767566] sd 14:2:0:0: [sda] tag#0 megasas: target reset FAILED!!
[  201.780690] sd 14:2:0:0: [sda] tag#0 Controller reset is requested due to IO timeout
[  201.780690] SCSI command pointer: (00000000c342d874)  SCSI host state: 5      SCSI 
[  201.809709] IO request frame:
[  201.809709] 
[  201.809710] f1000000 
[  201.827987] 00000000 
[  201.836901] 00000000 
[  201.846047] 5d880000 
[  201.855161] 00600002 
[  201.864093] 00000020 
[  201.872746] 00000000 
[  201.881168] 00001000 
[  201.889432] 
[  201.889432] 
[  201.897570] 00000000 
[  201.912011] 0000000a 
[  201.919897] 00000000 
[  201.927608] 00000000 
[  201.935275] 00000000 
[  201.943047] 00000000 
[  201.950516] 00000000 
[  201.957709] 02000000 
[  201.964776] 
[  201.964776] 
[  201.971731] e70d0028 
[  201.983967] 000080ff 
[  201.990676] 00000008 
[  201.997192] 00000000 
[  202.003611] 00000000 
[  202.009812] 00000000 
[  202.015847] 00000000 
[  202.021770] 00000000 
[  202.027576] 
[  202.027576] 
[  202.033382] 00140012 
[  202.043209] 00000009 
[  202.048521] 0de7ff80 
[  202.053711] 00000000 
[  202.058818] 00000008 
[  202.063850] 00000000 
[  202.068797] 00020100 
[  202.073549] 00000000 
[  202.078131] 
[  202.078131] 
[  202.082708] beb56000 
[  202.089903] 0000002f 
[  202.094106] 00001000 
[  202.098230] 40000000 
[  202.102238] 00000000 
[  202.106134] 00000000 
[  202.109878] 00000000 
[  202.113456] 00000000 
[  202.117008] 
[  202.117008] 
[  202.120545] 00000000 
[  202.126100] 00000000 
[  202.129656] 00000000 
[  202.133191] 00000000 
[  202.136716] 00000000 
[  202.140241] 00000000 
[  202.143767] 00000000 
[  202.147264] 00000000 
[  202.150772] 
[  202.150772] 
[  202.154257] 00000000 
[  202.159702] 00000000 
[  202.163206] 00000000 
[  202.166706] 00000000 
[  202.170204] 00000000 
[  202.173697] 00000000 
[  202.177186] 00000000 
[  202.180659] 00000000 
[  202.184135] 
[  202.184135] 
[  202.187592] 00000000 
[  202.192952] 00000000 
[  202.196440] 00000000 
[  202.199892] 00000000 
[  202.203349] 00000000 
[  202.206798] 00000000 
[  202.210252] 00000000 
[  202.213691] 00000000 
[  202.217140] 
[  398.314076] sd 14:2:0:0: [sda] tag#0 task abort called for scmd(000000001879ac88)
[  398.323033] sd 14:2:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 10 07 80 00 00 08 00
[  398.331974] sd 14:2:0:0: task abort: FAILED scmd(000000001879ac88)
[  398.345996] sd 14:2:0:0: target reset called for scmd(000000001879ac88)
[  398.354370] sd 14:2:0:0: [sda] tag#0 megasas: target reset FAILED!!
[  398.362501] sd 14:2:0:0: [sda] tag#0 Controller reset is requested due to IO timeout
[  398.362501] SCSI command pointer: (000000001879ac88)  SCSI host state: 5      SCSI 
[  398.381638] IO request frame:
[  398.381638] 
[  398.381639] f1000000 
[  398.390467] 00000000 
[  398.394896] 00000000 
[  398.399324] 5d880000 
[  398.403781] 00600002 
[  398.408209] 00000020 
[  398.412677] 00000000 
[  398.417128] 00001000 
[  398.421596] 
[  398.421596] 
[  398.426061] 00000000 
[  398.433490] 0000000a 
[  398.437981] 00000000 
[  398.442476] 00000000 
[  398.446955] 00000000 
[  398.451434] 00000000 
[  398.455933] 00000000 
[  398.460402] 02000000 
[  398.464873] 
[  398.464873] 
[  398.469320] 10000028 
[  398.476725] 00008007 
[  398.481202] 00000008 
[  398.485685] 00000000 
[  398.490188] 00000000 
[  398.494684] 00000000 
[  398.499183] 00000000 
[  398.503720] 00000000 
[  398.508216] 
[  398.508216] 
[  398.512699] 00140012 
[  398.520149] 00000009 
[  398.524652] 00100780 
[  398.529169] 00000000 
[  398.533744] 00000008 
[  398.538279] 00000000 
[  398.542819] 00020100 
[  398.547369] 00000000 
[  398.551907] 
[  398.551907] 
[  398.556426] bbd04000 
[  398.563531] 0000002f 
[  398.567687] 00001000 
[  398.571765] 40000000 
[  398.575722] 00000000 
[  398.579595] 00000000 
[  398.583300] 00000000 
[  398.586837] 00000000 
[  398.590345] 
[  398.590345] 
[  398.593846] 00000000 
[  398.599337] 00000000 
[  398.602851] 00000000 
[  398.606346] 00000000 
[  398.609851] 00000000 
[  398.613352] 00000000 
[  398.616839] 00000000 
[  398.620300] 00000000 
[  398.623776] 
[  398.623776] 
[  398.627227] 00000000 
[  398.632666] 00000000 
[  398.636145] 00000000 
[  398.639619] 00000000 
[  398.643106] 00000000 
[  398.646573] 00000000 
[  398.650044] 00000000 
[  398.653500] 00000000 
[  398.656957] 
[  398.656957] 
[  398.660405] 00000000 
[  398.665748] 00000000 
[  398.669208] 00000000 
[  398.672654] 00000000 
[  398.676117] 00000000 
[  398.679574] 00000000 
[  398.683074] 00000000 
[  398.686499] 00000000 
[  398.689935] 
[  594.922063] sd 14:2:0:0: [sda] tag#0 task abort called for scmd(000000005b78ba6b)
[  594.931012] sd 14:2:0:0: [sda] tag#0 CDB: Read(10) 28 00 03 f8 07 80 00 00 08 00
[  594.939953] sd 14:2:0:0: task abort: FAILED scmd(000000005b78ba6b)
[  594.953981] sd 14:2:0:0: target reset called for scmd(000000005b78ba6b)
[  594.962346] sd 14:2:0:0: [sda] tag#0 megasas: target reset FAILED!!
[  594.970454] sd 14:2:0:0: [sda] tag#0 Controller reset is requested due to IO timeout
[  594.970454] SCSI command pointer: (000000005b78ba6b)  SCSI host state: 5      SCSI 
[  594.989607] IO request frame:
[  594.989607] 
[  594.989609] f1000000 
[  594.998456] 00000000 
[  595.002886] 00000000 
[  595.007318] 5d880000 
[  595.011742] 00600002 
[  595.016186] 00000020 
[  595.020639] 00000000 
[  595.025115] 00001000 
[  595.029583] 
[  595.029583] 
[  595.034028] 00000000 
[  595.041411] 0000000a 
[  595.045881] 00000000 
[  595.050353] 00000000 
[  595.054827] 00000000 
[  595.059306] 00000000 
[  595.063780] 00000000 
[  595.068415] 02000000 
[  595.072920] 
[  595.072920] 
[  595.077421] f8030028 
[  595.084846] 00008007 
[  595.089325] 00000008 
[  595.093826] 00000000 
[  595.098437] 00000000 
[  595.102937] 00000000 
[  595.107437] 00000000 
[  595.111940] 00000000 
[  595.116431] 
[  595.116431] 
[  595.120901] 00140012 
[  595.128352] 00000009 
[  595.132850] 03f80780 
[  595.137364] 00000000 
[  595.141890] 00000008 
[  595.146423] 00000000 
[  595.150958] 00020100 
[  595.155498] 00000000 
[  595.160047] 
[  595.160047] 
[  595.164578] c269e000 
[  595.171708] 00000017 
[  595.175885] 00001000 
[  595.179973] 40000000 
[  595.183944] 00000000 
[  595.187822] 00000000 
[  595.191536] 00000000 
[  595.195082] 00000000 
[  595.198609] 
[  595.198609] 
[  595.202122] 00000000 
[  595.207619] 00000000 
[  595.211143] 00000000 
[  595.214655] 00000000 
[  595.218161] 00000000 
[  595.221663] 00000000 
[  595.225162] 00000000 
[  595.228645] 00000000 
[  595.232123] 
[  595.232123] 
[  595.235582] 00000000 
[  595.240986] 00000000 
[  595.244471] 00000000 
[  595.247965] 00000000 
[  595.251453] 00000000 
[  595.254935] 00000000 
[  595.258416] 00000000 
[  595.261884] 00000000 
[  595.265351] 
[  595.265351] 
[  595.268804] 00000000 
[  595.274158] 00000000 
[  595.277618] 00000000 
[  595.281076] 00000000 
[  595.284529] 00000000 
[  595.287997] 00000000 
[  595.291464] 00000000 
[  595.294903] 00000000 
[  595.298356] 
[  736.901520] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  737.459232] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  738.002067] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  738.545137] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  739.088217] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  739.631220] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  740.174130] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  740.717158] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  741.260179] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  741.803162] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  742.346139] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  742.889141] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  743.432158] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  743.975154] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  744.518159] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  745.061253] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  745.604161] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  746.147134] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  746.690136] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  747.233129] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  747.776137] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  748.319131] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  748.862202] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  749.405114] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  749.948157] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  750.491135] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  751.034159] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  751.577133] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  752.119949] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  752.662725] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  753.205783] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  753.750727] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  754.294788] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  754.838607] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  755.382680] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  755.927778] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  756.471804] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  757.014747] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  757.559781] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  758.103854] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  758.647760] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  759.191743] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  759.735861] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  760.279765] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  760.823758] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  761.367761] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  761.909739] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  762.454694] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  762.994984] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  763.540841] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  764.086828] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  764.630915] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  765.173818] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  765.719923] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  766.265875] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  766.811835] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  767.354899] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  767.897963] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  768.438833] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  768.982707] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  769.527950] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  770.072850] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  770.617864] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  771.162828] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  771.706887] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  772.251794] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  772.794820] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  773.338784] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  773.881714] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  774.426843] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  774.971827] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  775.514757] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  776.057745] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  776.602825] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  777.147747] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  777.690858] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  778.235819] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  778.780822] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  779.324850] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  779.867850] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  780.412778] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  780.957860] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  781.503764] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  782.044754] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  782.586848] d[  782.587449] random: crng init done
racut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  783.132052] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  783.675137] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  784.218132] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  784.761164] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  785.304171] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  785.847150] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  786.390126] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  786.933125] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  787.476115] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  788.018091] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  788.562126] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  789.105224] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  789.648138] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  790.191153] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  790.734270] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  791.278109] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  791.821238] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  792.364080] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  792.906954] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  793.448131] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  793.990225] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  794.533252] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  795.075092] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  795.617967] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  796.161213] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  796.703119] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  797.246178] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  797.788088] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  798.330146] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  798.873127] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  799.416173] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  799.959134] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  800.499844] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  801.042880] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  801.586596] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  801.587882] dracut-initqueue[1081]: Warning: Could not boot.
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on Open-iSCSI iscsiuio Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
[  736.901520] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  737.459232] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  738.002067] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  738.545137] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  739.088217] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  739.631220] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  740.174130] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  740.717158] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  741.260179] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  741.803162] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  742.346139] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  742.889141] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  743.432158] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  743.975154] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  744.518159] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  745.061253] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  745.604161] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  746.147134] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  746.690136] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  747.233129] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  747.776137] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  748.319131] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  748.862202] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  749.405114] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  749.948157] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  750.491135] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  751.034159] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  751.577133] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  752.119949] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  752.662725] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  753.205783] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  753.750727] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  754.294788] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  754.838607] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  755.382680] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  755.927778] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  756.471804] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  757.014747] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  757.559781] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  758.103854] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  758.647760] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  759.191743] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  759.735861] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  760.279765] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  760.823758] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  761.367761] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  761.909739] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  762.454694] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  762.994984] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  763.540841] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  764.086828] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  764.630915] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  765.173818] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  765.719923] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  766.265875] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  766.811835] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  767.354899] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  767.897963] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  768.438833] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  768.982707] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  769.527950] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  770.072850] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  770.617864] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  771.162828] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  771.706887] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  772.251794] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  772.794820] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  773.338784] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  773.881714] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  774.426843] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  774.971827] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  775.514757] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  776.057745] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  776.602825] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  777.147747] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  777.690858] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  778.235819] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  778.780822] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  779.324850] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  779.867850] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  780.412778] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  780.957860] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  781.503764] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  782.044754] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  782.586848] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  783.132052] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  783.675137] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  784.218132] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  784.761164] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  785.304171] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  785.847150] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  786.390126] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  786.933125] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  787.476115] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  788.018091] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  788.562126] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  789.105224] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  789.648138] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  790.191153] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  790.734270] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  791.278109] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  791.821238] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  792.364080] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  792.906954] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  793.448131] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  793.990225] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  794.533252] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  795.075092] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  795.617967] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  796.161213] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  796.703119] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  797.246178] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  797.788088] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  798.330146] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  798.873127] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  799.416173] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  799.959134] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  800.499844] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  801.042880] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  801.586596] dracut-initqueue[1081]: Warning: dracut-initqueue timeout - starting timeout scripts
[  801.587882] dracut-initqueue[1081]: Warning: Could not boot.
[  802.809754] dracut-initqueue[1081]: Warning: /dev/disk/by-label/root does not exist
         Starting Setup Virtual Console...
[  OK    802.877090] kauditd_printk_skb: 4 callbacks suppressed
0m] Started Setu[  802.877092] audit: type=1130 audit(1519310192.086:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hos
tname=? addr=? terminal=? res=success'
p Virtual Console.
[  802.909403] audit: type=1131 audit(1519310192.086:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? t
erminal=? res=success'
         Starting Dracut Emergency Shell...
[  802.962833] audit: type=1131 audit(1519310192.171:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=
? res=success'
Warning: /dev/disk/by-label/root does not exist

Generating "/run/initramfs/rdsosreport.txt"
Are you already aware of the problem? Any hints/[  988.138084] sd 14:2:0:0: [sda] tag#0 task abort called for scmd(00000000193f6c54)
[  988.149101] sd 14:2:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 10 07 80 00 00 08 00
[  988.160116] sd 14:2:0:0: task abort: FAILED scmd(00000000193f6c54)
[  988.176960] sd 14:2:0:0: target reset called for scmd(00000000193f6c54)
[  988.187402] sd 14:2:0:0: [sda] tag#0 megasas: target reset FAILED!!
[  988.197593] sd 14:2:0:0: [sda] tag#0 Controller reset is requested due to IO timeout
[  988.197593] SCSI command pointer: (00000000193f6c54)  SCSI host state: 5      SCSI 
[  988.220944] IO request frame:
[  988.220944] 
[  988.220944] f1000000 
[  988.233988] 00000000 
[  988.240540] 00000000 
[  988.247095] 5d880000 
[  988.253677] 00600002 
[  988.260235] 00000020 
[  988.266827] 00000000 
[  988.273413] 00001000 
[  988.279991] 
[  988.279991] 
[  988.286582] 00000000 
[  988.298221] 0000000a 
[  988.304824] 00000000 
[  988.311412] 00000000 
[  988.318003] 00000000 
[  988.324599] 00000000 
[  988.331183] 00000000 
[  988.337859] 02000000 
[  988.344430] 
[  988.344430] 
[  988.351006] 10000028 
[  988.362631] 00008007 
[  988.369222] 00000008 
[  988.375918] 00000000 
[  988.382518] 00000000 
[  988.389178] 00000000 
[  988.395775] 00000000 
[  988.402357] 00000000 
[  988.408950] 
[  988.408950] 
[  988.415652] 00140012 
[  988.427405] 00000009 
[  988.433879] 00100780 
[  988.440251] 00000000 
[  988.446372] 00000008 
[  988.452193] 00000000 
[  988.457695] 00020100 
[  988.462898] 00000000 
[  988.467826] 
[  988.467826] 
[  988.472493] bab8f000 
[  988.479615] 00000017 
[  988.483792] 00001000 
[  988.487969] 40000000 
[  988.491955] 00000000 
[  988.495910] 00000000 
[  988.499674] 00000000 
[  988.503327] 00000000 
[  988.506888] 
[  988.506888] 
[  988.510422] 00000000 
[  988.515999] 00000000 
[  988.519540] 00000000 
[  988.523064] 00000000 
[  988.526570] 00000000 
[  988.530079] 00000000 
[  988.533575] 00000000 
[  988.537053] 00000000 
[  988.540534] 
[  988.540534] 
[  988.543994] 00000000 
[  988.549404] 00000000 
[  988.552894] 00000000 
[  988.556361] 00000000 
[  988.559835] 00000000 
[  988.563311] 00000000 
[  988.566786] 00000000 
[  988.570234] 00000000 
[  988.573693] 
[  988.573693] 
[  988.577133] 00000000 
[  988.582480] 00000000 
[  988.586031] 00000000 
[  988.589493] 00000000 
[  988.592955] 00000000 
[  988.596408] 00000000 
[  988.599854] 00000000 
[  988.603283] 00000000 
[  988.606724]
