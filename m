Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E937C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F9820844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=demfloro.ru header.i=@demfloro.ru header.b="Tth8HR7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F9820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=demfloro.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeIHSny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:43:54 -0400
Received: from mx.demfloro.ru ([185.52.0.75]:34038 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbeIHSnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:43:53 -0400
Received: from fire.localdomain (unknown [IPv6:2001:470:28:88::100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: demfloro)
        by mx.demfloro.ru (Postfix) with ESMTPSA id 426wqh6sBTz4tJt;
        Sat,  8 Sep 2018 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru; s=052018;
        t=1536415073; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=0Mth26JSeg5QUMobfUya/1HFQQU48/fzIShgGQlu17s=;
        b=Tth8HR7sYUn4uERfR/G1fhnySWxb6nxcPgzur6+XFF1hq/1WfXtP1bTW82guHZtb/A59zA
        JokDSMWNBsT5MGz7tFYqcval7miNoOAZgvmaWNPXN3nu8Pyxzi+hiIhI9iqFTYyxnlnmmK
        lUE7ZZRehQIiCKGAZxsHOyhtam7V7O2E2EEW56luHz4QUFiqckWFcrxjOCkU42iDxpoejc
        Ho4B0J4qX/3FA/cHRm6Mv6z+Ep06jrjYpeCfcgi6vlYlKmKq2YsGi6rECDQFFx1lrT0rZQ
        Vw6qMKCTFg0yUjESRlnjjvHV4t8KrCrUxzmNYl+adbrVk31EnVNExsmK98mqxA==
Date:   Sat, 8 Sep 2018 16:57:47 +0300
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: No video output on 4.19-rc1 on Dell XPS 13 9360
Message-ID: <20180908165747.16c2843c@fire.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/lMvNZTL7q01XseDB/OQYSCh"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru;
        s=arc052018; t=1536415073;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=0Mth26JSeg5QUMobfUya/1HFQQU48/fzIShgGQlu17s=;
        b=MdvzM8ycFjeH9+sFzoNGy3EbFU3uVTUtQ7kcJvFpWsRhj6+P6wvZij4QZCJEqUvQaFZ/WA
        +LimvijMqfm8G+MyyX6yYEebx7wElp2HebVEnvWBtBGmRlzG81943BIRxfUQg7CT/MRAlw
        U0y6/+ttyVpitNa4gARQr/PGhI0QER+tAIxjcSnt+6iEUr2z4ss+dai07mOUfbE+Frl+Pv
        kLTIcFpqErUDs971Z3vH/AJM6CQcDQRL/7x53ZAKzIIWCBv5aAwaZig1v2m7oV99mMY9dJ
        sDXkaY2cGXX9sRgnNwe0FEgNtaqF89mOCSVNo5rEcHKP/AO6uI8jA+e/zoC7WA==
ARC-Seal: i=1; s=arc052018; d=demfloro.ru; t=1536415073; a=rsa-sha256;
        cv=none;
        b=ZKsomk5fglfNaHCfLNXQeAsuLawJq2GNoIY8DTp6fmKHbbGN8IMZixzda6N47TVwUBiE3i1ht/CD5S/98N2NXChgo4rbAG6iaxQ4Csv8LHbKWL+yBdol6hbFdEtV8K7AD+XIgwsWyBW+7dliD7M4WXJ5aq4fRsZnADiRGLoJwwJy/yXoJm+AGMrX+hPnnHUbkeJBxVcm+U2oDMoBD6GNVCVVy+zRZr/ThNktWsDM7V9UvxXGzaP8lXedn6DCIXAxigTYDIMnyKiJTEXVIVaekdxi7m0j/J37ocMy5MsuNNzNAks5Syp1yyt9iR+od8GpwCFXNTgpGwEhlIo07fv6xA==
ARC-Authentication-Results: i=1; mx.demfloro.ru;
        auth=pass smtp.auth=demfloro smtp.mailfrom=demfloro@demfloro.ru
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've sent the email[1] before to iommu and lkml mailing lists only, but
according to iommu mailing list archive it wasn't received[2]. I'm
resending it to Lu Baolu and Joerg Roedel with proper kernel .config
file. Sorry if the duplication is unnecessary.

Since 4.19-rc1 my laptop boots with vertical static set of rows of dots
on the screen instead of proper video output. SSH'ing into it allowed
to get dmesg-without-pt.log output, PCI device 00:02.0 is VGA
compatible controller: Intel Corporation HD Graphics 620 (rev 02)

Appending "iommu=pt" to kernel cmdline allowed to boot with functional
graphics, but gave dmesg-with-pt.log output.

Bisect between v4.18 and v4.19-rc1 tags led me to commit
a7fc93fed94b173e2 (iommu/vt-d: Allocate and free pasid table).

Reverting this commit allows to build kernel on current master
(a12ed06ba2d3fa60e), which boots with functional graphical output
without specifying "iommu=pt".
Dmesg output is in dmesg-with-revert.log.

Without the revert current master boots like 4.19-rc1.

[1] https://lkml.org/lkml/2018/9/7/1081
[2] https://lists.linuxfoundation.org/pipermail/iommu/2018-September/date.html

--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg-without-pt.log

[    0.000000] Linux version 4.19.0-rc2-ARCH-test (feanor@fire) (gcc version 8.2.1 20180831 (GCC)) #2 SMP Thu Sep 6 21:52:25 MSK 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux-test root=/dev/mapper/xps-root rw cryptdevice=UUID=34167ea3-883e-42c4-9cd9-d19518301f18:system:allow-discards rootflags=noatime,autodefrag,ssd slub_debug=P page_poison=1 memtest=2 stack_guard_gap=512 pti=on spec_store_bypass_disable=on l1tf=full,force seed=7VG6ASQoP1PbHJD4L8UX1iWYqmnVryfDTeX9hxOd
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005f2b8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005f2b9000-0x000000005f2b9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005f2ba000-0x000000005f2bafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005f2bb000-0x0000000070874fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070875000-0x0000000070bfffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000070c00000-0x0000000070c43fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000070c44000-0x000000007aef5fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007aef6000-0x000000007b51ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007b520000-0x000000007b5fefff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007b600000-0x000000007f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027e7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ACPI=0x70c0d000  ACPI 2.0=0x70c0d000  SMBIOS=0xf0000  SMBIOS 3.0=0xf0020  MEMATTR=0x6e230018 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.001341] tsc: Detected 2712.000 MHz TSC
[    0.001341] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001343] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001350] last_pfn = 0x27e800 max_arch_pfn = 0x400000000
[    0.001354] MTRR default type: write-back
[    0.001354] MTRR fixed ranges enabled:
[    0.001355]   00000-9FFFF write-back
[    0.001356]   A0000-BFFFF uncachable
[    0.001356]   C0000-FFFFF write-protect
[    0.001357] MTRR variable ranges enabled:
[    0.001358]   0 base 0080000000 mask 7F80000000 uncachable
[    0.001359]   1 base 007E000000 mask 7FFE000000 uncachable
[    0.001359]   2 base 007D000000 mask 7FFF000000 uncachable
[    0.001360]   3 disabled
[    0.001360]   4 disabled
[    0.001360]   5 disabled
[    0.001360]   6 disabled
[    0.001361]   7 disabled
[    0.001361]   8 disabled
[    0.001361]   9 disabled
[    0.002285] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002915] last_pfn = 0x7b600 max_arch_pfn = 0x400000000
[    0.010414] Scanning 1 areas for low memory corruption
[    0.010417] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.010421] Using GB pages for direct mapping
[    0.010424] BRK [0x1b37fe000, 0x1b37fefff] PGTABLE
[    0.010426] BRK [0x1b37ff000, 0x1b37fffff] PGTABLE
[    0.010426] BRK [0x1b3800000, 0x1b3800fff] PGTABLE
[    0.010446] BRK [0x1b3801000, 0x1b3801fff] PGTABLE
[    0.010448] BRK [0x1b3802000, 0x1b3802fff] PGTABLE
[    0.010500] BRK [0x1b3803000, 0x1b3803fff] PGTABLE
[    0.010518] BRK [0x1b3804000, 0x1b3804fff] PGTABLE
[    0.010567] BRK [0x1b3805000, 0x1b3805fff] PGTABLE
[    0.010600] BRK [0x1b3806000, 0x1b3806fff] PGTABLE
[    0.010615] early_memtest: # of tests: 2
[    0.010616]   0x0000000000010000 - 0x0000000000058000 pattern ffffffffffffffff
[    0.010672]   0x0000000000059000 - 0x000000000008c000 pattern ffffffffffffffff
[    0.010712]   0x000000000008c690 - 0x0000000000098000 pattern ffffffffffffffff
[    0.010722]   0x0000000000100000 - 0x0000000036505000 pattern ffffffffffffffff
[    0.264797]   0x000000003727a000 - 0x000000003f392000 pattern ffffffffffffffff
[    0.293980]   0x000000003f3d2000 - 0x000000005d497000 pattern ffffffffffffffff
[    0.402366]   0x000000005f382000 - 0x000000006e230018 pattern ffffffffffffffff
[    0.456174]   0x000000006e2308f8 - 0x000000006fd4c000 pattern ffffffffffffffff
[    0.462216]   0x0000000100000000 - 0x00000001b1e00000 pattern ffffffffffffffff
[    1.103370]   0x00000001b380a000 - 0x000000027e800000 pattern ffffffffffffffff
[    1.834800]   0x0000000000010000 - 0x0000000000058000 pattern 0000000000000000
[    1.834857]   0x0000000000059000 - 0x000000000008c000 pattern 0000000000000000
[    1.834897]   0x000000000008c690 - 0x0000000000098000 pattern 0000000000000000
[    1.834907]   0x0000000000100000 - 0x0000000036505000 pattern 0000000000000000
[    2.030768]   0x000000003727a000 - 0x000000003f392000 pattern 0000000000000000
[    2.059940]   0x000000003f3d2000 - 0x000000005d497000 pattern 0000000000000000
[    2.168136]   0x000000005f382000 - 0x000000006e230018 pattern 0000000000000000
[    2.221669]   0x000000006e2308f8 - 0x000000006fd4c000 pattern 0000000000000000
[    2.227676]   0x0000000100000000 - 0x00000001b1e00000 pattern 0000000000000000
[    2.868115]   0x00000001b380a000 - 0x000000027e800000 pattern 0000000000000000
[    3.599993] Secure boot could not be determined
[    3.599995] RAMDISK: [mem 0x36505000-0x37279fff]
[    3.600003] ACPI: Early table checksum verification disabled
[    3.600007] ACPI: RSDP 0x0000000070C0D000 000024 (v02 DELL  )
[    3.600011] ACPI: XSDT 0x0000000070C0D0C0 0000FC (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600016] ACPI: FACP 0x0000000070C32B98 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    3.600021] ACPI: DSDT 0x0000000070C0D248 02594E (v02 DELL   CBX3     01072009 INTL 20160422)
[    3.600024] ACPI: FACS 0x000000007AEF3180 000040
[    3.600026] ACPI: APIC 0x0000000070C32CA8 000068 (v03 DELL   CBX3     01072009 AMI  00010013)
[    3.600029] ACPI: FPDT 0x0000000070C32D10 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600031] ACPI: FIDT 0x0000000070C32D58 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600034] ACPI: MCFG 0x0000000070C32E08 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    3.600036] ACPI: HPET 0x0000000070C32E48 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
[    3.600039] ACPI: SSDT 0x0000000070C32E80 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
[    3.600042] ACPI: BOOT 0x0000000070C331E0 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600044] ACPI: SSDT 0x0000000070C33208 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    3.600047] ACPI: HPET 0x0000000070C344D8 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    3.600050] ACPI: SSDT 0x0000000070C34510 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
[    3.600053] ACPI: UEFI 0x0000000070C35298 000042 (v01                 00000000      00000000)
[    3.600055] ACPI: SSDT 0x0000000070C352E0 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    3.600058] ACPI: LPIT 0x0000000070C361C0 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    3.600060] ACPI: WSMT 0x0000000070C36258 000028 (v01 DELL   CBX3     00000000 MSFT 0000005F)
[    3.600063] ACPI: SSDT 0x0000000070C36280 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
[    3.600066] ACPI: SSDT 0x0000000070C363E8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    3.600068] ACPI: SSDT 0x0000000070C36688 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    3.600071] ACPI: SSDT 0x0000000070C39690 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
[    3.600073] ACPI: DBGP 0x0000000070C39770 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    3.600076] ACPI: DBG2 0x0000000070C397A8 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    3.600078] ACPI: SSDT 0x0000000070C39800 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
[    3.600082] ACPI: SSDT 0x0000000070C39FE0 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
[    3.600084] ACPI: NHLT 0x0000000070C424D8 00002D (v00 INTEL  EDK2     00000002      01000013)
[    3.600087] ACPI: BGRT 0x0000000070C42508 000038 (v00                 01072009 AMI  00010013)
[    3.600090] ACPI: ASF! 0x0000000070C42540 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    3.600092] ACPI: DMAR 0x0000000070C425E0 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
[    3.600100] ACPI: Local APIC address 0xfee00000
[    3.600121] Zone ranges:
[    3.600122]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    3.600124]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    3.600125]   Normal   [mem 0x0000000100000000-0x000000027e7fffff]
[    3.600126] Movable zone start for each node
[    3.600127] Early memory node ranges
[    3.600128]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    3.600129]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    3.600130]   node   0: [mem 0x0000000000100000-0x000000005f2b8fff]
[    3.600131]   node   0: [mem 0x000000005f2bb000-0x0000000070874fff]
[    3.600131]   node   0: [mem 0x000000007b5ff000-0x000000007b5fffff]
[    3.600132]   node   0: [mem 0x0000000100000000-0x000000027e7fffff]
[    3.601101] Reserved but unavailable: 63472 pages
[    3.601102] Initmem setup node 0 [mem 0x0000000000001000-0x000000027e7fffff]
[    3.601104] On node 0 totalpages: 2027536
[    3.601105]   DMA zone: 64 pages used for memmap
[    3.601106]   DMA zone: 22 pages reserved
[    3.601106]   DMA zone: 3996 pages, LIFO batch:0
[    3.601175]   DMA32 zone: 7138 pages used for memmap
[    3.601175]   DMA32 zone: 456820 pages, LIFO batch:63
[    3.611959]   Normal zone: 24480 pages used for memmap
[    3.611960]   Normal zone: 1566720 pages, LIFO batch:63
[    3.638337] Reserving Intel graphics memory at [mem 0x7d800000-0x7f7fffff]
[    3.638632] ACPI: PM-Timer IO Port: 0x1808
[    3.638633] ACPI: Local APIC address 0xfee00000
[    3.638638] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    3.638639] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    3.638666] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    3.638668] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    3.638670] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    3.638672] ACPI: IRQ0 used by override.
[    3.638672] ACPI: IRQ9 used by override.
[    3.638674] Using ACPI (MADT) for SMP configuration information
[    3.638675] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    3.638678] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    3.638693] [mem 0x7f800000-0xdfffffff] available for PCI devices
[    3.638696] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    3.741860] random: get_random_bytes called from start_kernel+0x8a/0x48e with crng_init=0
[    3.741868] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:2 nr_node_ids:1
[    3.742009] percpu: Embedded 42 pages/cpu @(____ptrval____) s132504 r8192 d31336 u1048576
[    3.742015] pcpu-alloc: s132504 r8192 d31336 u1048576 alloc=1*2097152
[    3.742016] pcpu-alloc: [0] 0 1 
[    3.742032] Built 1 zonelists, mobility grouping on.  Total pages: 1995832
[    3.742034] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux-test root=/dev/mapper/xps-root rw cryptdevice=UUID=34167ea3-883e-42c4-9cd9-d19518301f18:system:allow-discards rootflags=noatime,autodefrag,ssd slub_debug=P page_poison=1 memtest=2 stack_guard_gap=512 pti=on spec_store_bypass_disable=on l1tf=full,force seed=7VG6ASQoP1PbHJD4L8UX1iWYqmnVryfDTeX9hxOd
[    3.742619] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    3.742819] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    4.304329] Memory: 7816536K/8110144K available (14360K kernel code, 671K rwdata, 4064K rodata, 964K init, 556K bss, 293608K reserved, 0K cma-reserved)
[    4.304510] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    4.304512] Kernel/User page tables isolation: enabled
[    4.313810] rcu: Hierarchical RCU implementation.
[    4.313811] rcu: 	RCU event tracing is enabled.
[    4.313812] rcu: 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    4.313813] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    4.313832] NR_IRQS: 4352, nr_irqs: 512, preallocated irqs: 16
[    4.314192] spurious 8259A interrupt: IRQ7.
[    4.314220] Console: colour dummy device 80x25
[    4.314417] console [tty0] enabled
[    4.314423] ACPI: Core revision 20180810
[    4.314899] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    4.314931] hpet clockevent registered
[    4.315003] APIC: Switch to symmetric I/O mode setup
[    4.315006] DMAR: Host address width 39
[    4.315008] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    4.315021] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    4.315024] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    4.315032] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    4.315035] DMAR: RMRR base: 0x00000070957000 end: 0x00000070976fff
[    4.315041] DMAR: RMRR base: 0x0000007d000000 end: 0x0000007f7fffff
[    4.315047] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    4.315049] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    4.315051] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    4.315053] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    4.316356] DMAR-IR: Enabled IRQ remapping in xapic mode
[    4.320673] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    4.364941] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2717868ea45, max_idle_ns: 440795316085 ns
[    4.364955] Calibrating delay loop (skipped), value calculated using timer frequency.. 5424.00 BogoMIPS (lpj=27120000)
[    4.364959] pid_max: default: 32768 minimum: 301
[    4.365748] Security Framework initialized
[    4.365754] Yama: becoming mindful.
[    4.365814] AppArmor: AppArmor initialized
[    4.365830] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    4.365833] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    4.366125] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    4.366127] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    4.366133] mce: CPU supports 8 MCE banks
[    4.366143] CPU0: Thermal monitoring enabled (TM1)
[    4.366159] process: using mwait in idle threads
[    4.366162] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    4.366164] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    4.366167] Spectre V2 : Mitigation: Full generic retpoline
[    4.366169] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    4.366171] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    4.366173] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    4.366176] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled
[    4.366178] SMT: Force disabled
[    4.370977] Freeing SMP alternatives memory: 32K
[    4.375885] TSC deadline timer enabled
[    4.375889] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    4.376026] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    4.376067] ... version:                4
[    4.376069] ... bit width:              48
[    4.376070] ... generic registers:      8
[    4.376072] ... value mask:             0000ffffffffffff
[    4.376074] ... max period:             00007fffffffffff
[    4.376075] ... fixed-purpose events:   3
[    4.376077] ... event mask:             00000007000000ff
[    4.376125] rcu: Hierarchical SRCU implementation.
[    4.376213] random: crng done (trusting CPU's manufacturer)
[    4.376368] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    4.376410] smp: Bringing up secondary CPUs ...
[    4.376516] x86: Booting SMP configuration:
[    4.376519] .... node  #0, CPUs:      #1
[    4.377213] smp: Brought up 1 node, 2 CPUs
[    4.377213] smpboot: Max logical packages: 1
[    4.377213] smpboot: Total of 2 processors activated (10848.00 BogoMIPS)
[    4.377213] devtmpfs: initialized
[    4.377213] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    4.377213] futex hash table entries: 512 (order: 3, 32768 bytes)
[    4.377213] xor: automatically using best checksumming function   avx       
[    4.377213] pinctrl core: initialized pinctrl subsystem
[    4.377213] NET: Registered protocol family 16
[    4.377213] audit: initializing netlink subsys (disabled)
[    4.377213] audit: type=2000 audit(1536261801.070:1): state=initialized audit_enabled=0 res=1
[    4.377213] cpuidle: using governor menu
[    4.377213] Simple Boot Flag at 0x47 set to 0x80
[    4.377213] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    4.377213] ACPI: bus type PCI registered
[    4.377213] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.377213] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    4.377213] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    4.377213] PCI: Using configuration type 1 for base access
[    4.384994] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    4.385096] cryptd: max_cpu_qlen set to 1000
[    4.554953] raid6: sse2x1   gen()  8793 MB/s
[    4.724949] raid6: sse2x1   xor()  6481 MB/s
[    4.894949] raid6: sse2x2   gen() 11204 MB/s
[    5.064950] raid6: sse2x2   xor()  7666 MB/s
[    5.234950] raid6: sse2x4   gen() 13169 MB/s
[    5.404950] raid6: sse2x4   xor()  7913 MB/s
[    5.574947] raid6: avx2x1   gen() 18037 MB/s
[    5.744948] raid6: avx2x1   xor() 12715 MB/s
[    5.914948] raid6: avx2x2   gen() 22135 MB/s
[    6.084947] raid6: avx2x2   xor() 14498 MB/s
[    6.254948] raid6: avx2x4   gen() 25787 MB/s
[    6.424947] raid6: avx2x4   xor() 14819 MB/s
[    6.424957] raid6: using algorithm avx2x4 gen() 25787 MB/s
[    6.424959] raid6: .... xor() 14819 MB/s, rmw enabled
[    6.424964] raid6: using avx2x2 recovery algorithm
[    6.425030] ACPI: Added _OSI(Module Device)
[    6.425032] ACPI: Added _OSI(Processor Device)
[    6.425034] ACPI: Added _OSI(3.0 _SCP Extensions)
[    6.425036] ACPI: Added _OSI(Processor Aggregator Device)
[    6.425042] ACPI: Added _OSI(Linux-Dell-Video)
[    6.425047] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    6.550262] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    6.566010] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    6.582444] ACPI: Dynamic OEM Table Load:
[    6.582444] ACPI: SSDT 0xFFFF9369F4921818 0006B4 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    6.585892] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    6.588280] ACPI: Dynamic OEM Table Load:
[    6.588287] ACPI: SSDT 0xFFFF9369F49A3060 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    6.589177] ACPI: Dynamic OEM Table Load:
[    6.589177] ACPI: SSDT 0xFFFF9369F4926868 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    6.589180] ACPI: Dynamic OEM Table Load:
[    6.589180] ACPI: SSDT 0xFFFF9369F49E3860 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    6.597365] ACPI: EC: EC started
[    6.597368] ACPI: EC: interrupt blocked
[    6.605772] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as first EC
[    6.605772] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x14, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    6.605772] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions
[    6.605772] ACPI: Interpreter enabled
[    6.605772] ACPI: (supports S0 S5)
[    6.605772] ACPI: Using IOAPIC for interrupt routing
[    6.605772] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    6.606986] ACPI: Enabled 8 GPEs in block 00 to 7F
[    6.622366] ACPI: Power Resource [WRST] (on)
[    6.623432] ACPI: Power Resource [WRST] (on)
[    6.624466] ACPI: Power Resource [WRST] (on)
[    6.625480] ACPI: Power Resource [WRST] (on)
[    6.626607] ACPI: Power Resource [WRST] (on)
[    6.627710] ACPI: Power Resource [WRST] (on)
[    6.629229] ACPI: Power Resource [WRST] (on)
[    6.630237] ACPI: Power Resource [WRST] (on)
[    6.631217] ACPI: Power Resource [WRST] (on)
[    6.632469] ACPI: Power Resource [WRST] (on)
[    6.633952] ACPI: Power Resource [WRST] (on)
[    6.634870] ACPI: Power Resource [WRST] (on)
[    6.635972] ACPI: Power Resource [WRST] (on)
[    6.637189] ACPI: Power Resource [WRST] (on)
[    6.639076] ACPI: Power Resource [WRST] (on)
[    6.640933] ACPI: Power Resource [WRST] (on)
[    6.642774] ACPI: Power Resource [WRST] (on)
[    6.649960] ACPI: Power Resource [WRST] (on)
[    6.651711] ACPI: Power Resource [WRST] (on)
[    6.653449] ACPI: Power Resource [WRST] (on)
[    6.729325] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    6.729339] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.730053] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    6.730053] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    6.730053] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    6.730053] PCI host bridge to bus 0000:00
[    6.730053] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    6.730053] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0x7f800000-0xdfffffff window]
[    6.730053] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    6.730053] pci_bus 0000:00: root bus resource [bus 00-fe]
[    6.730053] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    6.735422] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    6.735435] pci 0000:00:02.0: reg 0x10: [mem 0xdb000000-0xdbffffff 64bit]
[    6.735441] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    6.735446] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    6.735471] pci 0000:00:02.0: BAR 2: assigned to efifb
[    6.736045] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    6.736060] pci 0000:00:04.0: reg 0x10: [mem 0xdc420000-0xdc427fff 64bit]
[    6.736734] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    6.736757] pci 0000:00:14.0: reg 0x10: [mem 0xdc410000-0xdc41ffff 64bit]
[    6.736834] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    6.737615] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    6.737637] pci 0000:00:14.2: reg 0x10: [mem 0xdc434000-0xdc434fff 64bit]
[    6.738260] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    6.738523] pci 0000:00:15.0: reg 0x10: [mem 0xdc433000-0xdc433fff 64bit]
[    6.739990] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
[    6.740254] pci 0000:00:15.1: reg 0x10: [mem 0xdc432000-0xdc432fff 64bit]
[    6.741658] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    6.741685] pci 0000:00:16.0: reg 0x10: [mem 0xdc431000-0xdc431fff 64bit]
[    6.741768] pci 0000:00:16.0: PME# supported from D3hot
[    6.742400] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    6.742496] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    6.742509] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
[    6.743261] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    6.743361] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    6.743376] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    6.744108] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    6.744206] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    6.744221] pci 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
[    6.744959] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    6.745052] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    6.745064] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    6.745818] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    6.746488] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    6.746504] pci 0000:00:1f.2: reg 0x10: [mem 0xdc42c000-0xdc42ffff]
[    6.747104] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380
[    6.747132] pci 0000:00:1f.3: reg 0x10: [mem 0xdc428000-0xdc42bfff 64bit]
[    6.747159] pci 0000:00:1f.3: reg 0x20: [mem 0xdc400000-0xdc40ffff 64bit]
[    6.747218] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    6.748017] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    6.748079] pci 0000:00:1f.4: reg 0x10: [mem 0xdc430000-0xdc4300ff 64bit]
[    6.748150] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    6.749088] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    6.749095] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    6.749099] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.749633] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000
[    6.749962] pci 0000:3a:00.0: reg 0x10: [mem 0xdc000000-0xdc1fffff 64bit]
[    6.751230] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    6.752527] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    6.752534] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    6.753091] pci 0000:3b:00.0: [10ec:525a] type 00 class 0xff0000
[    6.753124] pci 0000:3b:00.0: reg 0x14: [mem 0xdc300000-0xdc300fff]
[    6.753368] pci 0000:3b:00.0: supports D1 D2
[    6.753369] pci 0000:3b:00.0: PME# supported from D1 D2 D3hot D3cold
[    6.753993] pci 0000:00:1c.5: PCI bridge to [bus 3b]
[    6.754000] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
[    6.754276] pci 0000:3c:00.0: [144d:a804] type 00 class 0x010802
[    6.754306] pci 0000:3c:00.0: reg 0x10: [mem 0xdc200000-0xdc203fff 64bit]
[    6.754772] pci 0000:00:1d.0: PCI bridge to [bus 3c]
[    6.754778] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    6.754805] pci_bus 0000:00: on NUMA node 0
[    6.762820] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.763095] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    6.763366] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.763636] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.763904] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.764170] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.764435] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.764698] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.775446] ACPI: EC: interrupt unblocked
[    6.775482] ACPI: EC: event unblocked
[    6.775498] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x14, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    6.775501] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions and events
[    6.775631] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    6.775631] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    6.775631] pci 0000:00:02.0: vgaarb: bridge control possible
[    6.775631] vgaarb: loaded
[    6.775631] SCSI subsystem initialized
[    6.775631] libata version 3.00 loaded.
[    6.775631] ACPI: bus type USB registered
[    6.775658] usbcore: registered new interface driver usbfs
[    6.775678] usbcore: registered new interface driver hub
[    6.775691] usbcore: registered new device driver usb
[    6.775730] pps_core: LinuxPPS API ver. 1 registered
[    6.775732] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.775740] PTP clock support registered
[    6.775751] EDAC MC: Ver: 3.0.0
[    6.776348] Registered efivars operations
[    6.785902] Advanced Linux Sound Architecture Driver Initialized.
[    6.785902] PCI: Using ACPI for IRQ routing
[    6.813824] PCI: pci_cache_line_size set to 64 bytes
[    6.814756] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    6.814759] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    6.814761] e820: reserve RAM buffer [mem 0x5f2b9000-0x5fffffff]
[    6.814764] e820: reserve RAM buffer [mem 0x70875000-0x73ffffff]
[    6.814766] e820: reserve RAM buffer [mem 0x7b600000-0x7bffffff]
[    6.814768] e820: reserve RAM buffer [mem 0x27e800000-0x27fffffff]
[    6.814962] Bluetooth: Core ver 2.22
[    6.814973] NET: Registered protocol family 31
[    6.814975] Bluetooth: HCI device and connection manager initialized
[    6.814979] Bluetooth: HCI socket layer initialized
[    6.814981] Bluetooth: L2CAP socket layer initialized
[    6.814990] Bluetooth: SCO socket layer initialized
[    6.814999] NetLabel: Initializing
[    6.815001] NetLabel:  domain hash size = 128
[    6.815002] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    6.815029] NetLabel:  unlabeled traffic allowed by default
[    6.815053] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    6.815151] wmi_bus wmi_bus-PNP0C14:01: WQBC data block query control method not found
[    6.815772] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    6.815779] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    6.817833] clocksource: Switched to clocksource tsc-early
[    6.818012] AppArmor: AppArmor Filesystem Enabled
[    6.818034] pnp: PnP ACPI init
[    6.818575] system 00:00: [io  0x0680-0x069f] has been reserved
[    6.818581] system 00:00: [io  0xffff] has been reserved
[    6.818585] system 00:00: [io  0xffff] has been reserved
[    6.818590] system 00:00: [io  0xffff] has been reserved
[    6.818594] system 00:00: [io  0x1800-0x18fe] has been reserved
[    6.818598] system 00:00: [io  0x164e-0x164f] has been reserved
[    6.818606] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.818820] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    6.818939] system 00:02: [io  0x1854-0x1857] has been reserved
[    6.818947] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    6.819418] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    6.819465] pnp 00:04: Plug and Play ACPI device, IDs DLL075b PNP0f13 (active)
[    6.820268] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    6.820282] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    6.820290] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    6.820298] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    6.820306] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    6.820314] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    6.820322] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    6.820330] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    6.820337] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    6.820345] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    6.820353] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.820471] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    6.820479] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    6.820486] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    6.820494] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    6.820501] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    6.820509] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    6.820516] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    6.820523] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.821275] system 00:07: [io  0xff00-0xfffe] has been reserved
[    6.821283] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.822060] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
[    6.822067] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
[    6.822075] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.832998] pnp: PnP ACPI: found 9 devices
[    6.840335] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    6.840352] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 1000
[    6.840380] pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
[    6.840384] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    6.840389] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    6.840395] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    6.840399] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.840406] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    6.840413] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    6.840421] pci 0000:00:1c.5: PCI bridge to [bus 3b]
[    6.840427] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
[    6.840435] pci 0000:00:1d.0: PCI bridge to [bus 3c]
[    6.840440] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    6.840449] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    6.840450] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    6.840451] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    6.840453] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    6.840454] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    6.840455] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    6.840456] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    6.840458] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    6.840459] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    6.840460] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    6.840461] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    6.840463] pci_bus 0000:00: resource 15 [mem 0x7f800000-0xdfffffff window]
[    6.840464] pci_bus 0000:00: resource 16 [mem 0xfd000000-0xfe7fffff window]
[    6.840466] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    6.840467] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
[    6.840468] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.840470] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
[    6.840471] pci_bus 0000:3b: resource 1 [mem 0xdc300000-0xdc3fffff]
[    6.840472] pci_bus 0000:3c: resource 1 [mem 0xdc200000-0xdc2fffff]
[    6.840840] NET: Registered protocol family 2
[    6.841053] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    6.841099] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    6.841327] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.841739] TCP: Hash tables configured (established 65536 bind 65536)
[    6.841770] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    6.841855] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    6.841980] NET: Registered protocol family 1
[    6.842131] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.843182] PCI: CLS 0 bytes, default 64
[    6.843237] Unpacking initramfs...
[    7.040517] Freeing initrd memory: 13780K
[    7.040585] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
[    7.040594] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
[    7.040609] DMAR: No ATSR found
[    7.040675] DMAR: dmar0: Using Queued invalidation
[    7.040688] DMAR: dmar1: Using Queued invalidation
[    7.040913] DMAR: Setting RMRR:
[    7.040987] WARNING: CPU: 1 PID: 1 at mm/page_alloc.c:4065 __alloc_pages_slowpath+0xac2/0xb90
[    7.040990] Modules linked in:
[    7.040995] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-rc2-ARCH-test #2
[    7.040997] Hardware name: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    7.041001] RIP: 0010:__alloc_pages_slowpath+0xac2/0xb90
[    7.041004] Code: 24 18 00 00 00 00 c7 44 24 40 00 00 00 00 c7 44 24 30 01 00 00 00 e9 20 fe ff ff 31 c0 41 81 e6 00 02 00 00 0f 85 bc fa ff ff <0f> 0b e9 b5 fa ff ff 65 48 8b 04 25 80 4d 01 00 8b 7c 24 3c 3b b8
[    7.041007] RSP: 0000:ffffa0b6c002fb68 EFLAGS: 00010046
[    7.041010] RAX: 0000000000000000 RBX: 0000000000488020 RCX: 0000000000000000
[    7.041013] RDX: ffffa0b6c002fc40 RSI: 000000000000000b RDI: 0000000000488020
[    7.041015] RBP: 000000000000000b R08: 0000000000000001 R09: 0000000000000787
[    7.041017] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
[    7.041019] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffafa59fc0
[    7.041022] FS:  0000000000000000(0000) GS:ffff9369f6300000(0000) knlGS:0000000000000000
[    7.041025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.041027] CR2: 0000000000000000 CR3: 00000001b320a001 CR4: 00000000003606e0
[    7.041029] Call Trace:
[    7.041036]  ? ___slab_alloc.constprop.83+0x504/0x530
[    7.041040]  ? intel_pasid_alloc_table+0xfc/0x1b0
[    7.041044]  __alloc_pages_nodemask+0x1ae/0x1d0
[    7.041047]  intel_pasid_alloc_table+0x169/0x1b0
[    7.041051]  dmar_insert_one_dev_info+0x2cf/0x4c0
[    7.041054]  set_domain_for_dev+0x6a/0x100
[    7.041058]  iommu_prepare_identity_map+0x48/0x9d
[    7.041062]  intel_iommu_init+0xce1/0x10b3
[    7.041068]  ? do_early_param+0x89/0x89
[    7.041071]  pci_iommu_init+0x11/0x3a
[    7.041074]  ? e820__memblock_setup+0x98/0x98
[    7.041077]  do_one_initcall+0x42/0x165
[    7.041081]  ? do_early_param+0x89/0x89
[    7.041084]  kernel_init_freeable+0x14c/0x1d6
[    7.041088]  ? rest_init+0x95/0x95
[    7.041091]  kernel_init+0x5/0xfb
[    7.041093]  ret_from_fork+0x35/0x40
[    7.041098] ---[ end trace ffc61c4938f5163e ]---
[    7.041110] DMAR: Mapping reserved region failed
[    7.041152] DMAR: Setting identity map for device 0000:00:14.0 [0x70957000 - 0x70976fff]
[    7.041160] DMAR: Prepare 0-16MiB unity mapping for LPC
[    7.041234] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    7.041501] DMAR: DRHD: handling fault status reg 2
[    7.041502] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    7.041506] DMAR: [DMA Write] Request device [00:02.0] fault addr 0 [fault reason 01] Present bit in root entry is clear
[    7.041594] iommu: Adding device 0000:00:00.0 to group 0
[    7.041619] iommu: Adding device 0000:00:02.0 to group 1
[    7.041643] iommu: Adding device 0000:00:04.0 to group 2
[    7.041678] iommu: Adding device 0000:00:14.0 to group 3
[    7.041698] iommu: Adding device 0000:00:14.2 to group 3
[    7.041728] iommu: Adding device 0000:00:15.0 to group 4
[    7.041747] iommu: Adding device 0000:00:15.1 to group 4
[    7.041774] iommu: Adding device 0000:00:16.0 to group 5
[    7.041803] iommu: Adding device 0000:00:1c.0 to group 6
[    7.041812] DMAR: DRHD: handling fault status reg 3
[    7.041819] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dc80000 [fault reason 01] Present bit in root entry is clear
[    7.041825] DMAR: DRHD: handling fault status reg 3
[    7.041829] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dc99000 [fault reason 01] Present bit in root entry is clear
[    7.041832] iommu: Adding device 0000:00:1c.4 to group 7
[    7.041834] DMAR: DRHD: handling fault status reg 3
[    7.041858] iommu: Adding device 0000:00:1c.5 to group 8
[    7.041889] iommu: Adding device 0000:00:1d.0 to group 9
[    7.041923] iommu: Adding device 0000:00:1f.0 to group 10
[    7.041943] iommu: Adding device 0000:00:1f.2 to group 10
[    7.041961] iommu: Adding device 0000:00:1f.3 to group 10
[    7.041979] iommu: Adding device 0000:00:1f.4 to group 10
[    7.042005] iommu: Adding device 0000:3a:00.0 to group 11
[    7.042050] iommu: Adding device 0000:3b:00.0 to group 12
[    7.042084] iommu: Adding device 0000:3c:00.0 to group 13
[    7.049347] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    7.049352] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.049354] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.049356] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.049357] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.049359] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.049678] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2717868ea45, max_idle_ns: 440795316085 ns
[    7.049691] clocksource: Switched to clocksource tsc
[    7.049716] Scanning for low memory corruption every 60 seconds
[    7.050638] Initialise system trusted keyrings
[    7.050675] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    7.054339] fuse init (API version 7.27)
[    7.055422] NET: Registered protocol family 38
[    7.055505] Key type asymmetric registered
[    7.055508] Asymmetric key parser 'x509' registered
[    7.055521] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    7.055548] io scheduler noop registered (default)
[    7.055550] io scheduler kyber registered
[    7.057692] pcieport 0000:00:1c.0: AER enabled with IRQ 123
[    7.057741] pcieport 0000:00:1c.4: AER enabled with IRQ 124
[    7.057786] pcieport 0000:00:1c.5: AER enabled with IRQ 125
[    7.057853] pcieport 0000:00:1d.0: AER enabled with IRQ 126
[    7.057903] efifb: probing for efifb
[    7.057921] efifb: framebuffer at 0x90000000, using 8128k, total 8128k
[    7.057924] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    7.057931] efifb: scrolling: redraw
[    7.057934] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    7.127381] Console: switching to colour frame buffer device 240x67
[    7.191996] fb0: EFI VGA frame buffer device
[    7.192183] intel_idle: MWAIT substates: 0x11142120
[    7.192184] intel_idle: v0.4.1 model 0x8E
[    7.192519] intel_idle: lapic_timer_reliable_states 0xffffffff
[    7.194789] ACPI: AC Adapter [AC] (on-line)
[    7.195084] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    7.195432] ACPI: Lid Switch [LID0]
[    7.195659] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    7.195995] ACPI: Power Button [PBTN]
[    7.196225] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    7.196558] ACPI: Sleep Button [SBTN]
[    7.196788] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    7.197088] ACPI: Power Button [PWRF]
[    7.200896] thermal LNXTHERM:00: registered as thermal_zone0
[    7.201148] ACPI: Thermal Zone [THM] (25 C)
[    7.201430] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.204265] Non-volatile memory driver v1.3
[    7.207668] DMAR: Setting identity map for device 0000:00:02.0 [0x7d000000 - 0x7f7fffff]
[    7.208050] DMAR: Allocating domain for 0000:00:02.0 failed
[    7.208457] [drm:ggtt_probe_common] *ERROR* Scratch setup failed
[    7.290631] battery: ACPI: Battery Slot [BAT0] (battery present)
[    7.365422] i915 0000:00:02.0: Device initialization failed (-12)
[    7.365672] i915 0000:00:02.0: Please file a bug at https://bugs.freedesktop.org/enter_bug.cgi?product=DRI against DRM/Intel providing the dmesg log by booting with drm.debug=0xf
[    7.366362] i915: probe of 0000:00:02.0 failed with error -12
[    7.369594] loop: module loaded
[    7.370028] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0002)
[    7.373533] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    7.375913] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    7.377121] nvme nvme0: pci function 0000:3c:00.0
[    7.377467] tun: Universal TUN/TAP device driver, 1.6
[    7.378073] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
[    7.380620] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    7.566071] uhci_hcd: USB Universal Host Controller Interface driver
[    7.566877] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.567096] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    7.568561] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000109810
[    7.568950] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    7.569414] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    7.569769] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.570060] usb usb1: Product: xHCI Host Controller
[    7.570276] usb usb1: Manufacturer: Linux 4.19.0-rc2-ARCH-test xhci-hcd
[    7.584634] usb usb1: SerialNumber: 0000:00:14.0
[    7.599105] hub 1-0:1.0: USB hub found
[    7.613186] hub 1-0:1.0: 12 ports detected
[    7.632371] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.646364] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    7.660434] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[    7.674693] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    7.688809] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.702960] usb usb2: Product: xHCI Host Controller
[    7.717134] usb usb2: Manufacturer: Linux 4.19.0-rc2-ARCH-test xhci-hcd
[    7.731404] usb usb2: SerialNumber: 0000:00:14.0
[    7.745809] hub 2-0:1.0: USB hub found
[    7.760340] hub 2-0:1.0: 6 ports detected
[    7.775814] usb: port power management may be unreliable
[    7.788527] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
[    7.797154]  nvme0n1: p1 p2
[    7.804215] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[    7.833904] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00079-QCARMSWPZ-1 api 6 features wowlan,ignore-otp crc32 fd869beb
[    7.849286] usbcore: registered new interface driver cdc_acm
[    7.864624] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    7.880117] usbcore: registered new interface driver usb-storage
[    7.895656] usbcore: registered new interface driver usbserial_generic
[    7.911082] usbserial: USB Serial support registered for generic
[    7.926575] usbcore: registered new interface driver cp210x
[    7.942009] usbserial: USB Serial support registered for cp210x
[    7.951165] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 20d869c3
[    7.957687] usbcore: registered new interface driver ftdi_sio
[    7.988499] usbserial: USB Serial support registered for FTDI USB Serial Device
[    8.004026] usbcore: registered new interface driver usb_serial_simple
[    8.019472] usbserial: USB Serial support registered for carelink
[    8.034835] usbserial: USB Serial support registered for zio
[    8.049964] usbserial: USB Serial support registered for funsoft
[    8.064842] usbserial: USB Serial support registered for flashloader
[    8.079540] usbserial: USB Serial support registered for google
[    8.094005] usbserial: USB Serial support registered for libtransistor
[    8.108370] usbserial: USB Serial support registered for vivopay
[    8.122590] usbserial: USB Serial support registered for moto_modem
[    8.136671] usbserial: USB Serial support registered for motorola_tetra
[    8.150630] usbserial: USB Serial support registered for novatel_gps
[    8.164326] usbserial: USB Serial support registered for hp4x
[    8.177803] usbserial: USB Serial support registered for suunto
[    8.191102] usbserial: USB Serial support registered for siemens_mpi
[    8.204593] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    8.218517] i8042: Warning: Keylock active
[    8.234923] serio: i8042 KBD port at 0x60,0x64 irq 1
[    8.247466] serio: i8042 AUX port at 0x60,0x64 irq 12
[    8.264233] rtc_cmos 00:01: RTC can wake from S4
[    8.278283] rtc_cmos 00:01: registered as rtc0
[    8.291346] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    8.304090] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    8.316607] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    8.332007] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    8.345701] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    8.536135] usb 1-2: New USB device found, idVendor=234b, idProduct=0001, bcdDevice= 1.00
[    8.548789] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    8.561374] usb 1-2: Product: NeuG True RNG
[    8.573893] usb 1-2: Manufacturer: Free Software Initiative of Japan
[    8.586419] usb 1-2: SerialNumber: FSIJ-1.0.6-87021528
[    8.599947] cdc_acm 1-2:1.0: ttyACM0: USB ACM device
[    8.685706] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[    8.698215] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[    8.710875] ath10k_pci 0000:3a:00.0: htt-ver 3.47 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    8.903664] ath: EEPROM regdomain: 0x6c
[    8.903665] ath: EEPROM indicates we should expect a direct regpair map
[    8.903666] ath: Country alpha2 being used: 00
[    8.903667] ath: Regpair used: 0x6c
[    9.181716] psmouse serio1: synaptics: queried max coordinates: x [..5666], y [..4734]
[    9.225977] psmouse serio1: synaptics: queried min coordinates: x [1276..], y [1118..]
[    9.238520] psmouse serio1: synaptics: Your touchpad (PNP: DLL075b PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    9.328440] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2a1, caps: 0xf00323/0x840300/0x12e800/0x0, board id: 3038, fw id: 2375007
[    9.380001] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
[    9.429533] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    9.475757] device-mapper: uevent: version 1.0.3
[    9.490137] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    9.504756] intel_pstate: Intel P-state driver initializing
[    9.519477] intel_pstate: HWP enabled
[    9.533856] EFI Variables Facility v0.08 2004-May-17
[    9.600997] hidraw: raw HID events driver (C) Jiri Kosina
[    9.615539] usbcore: registered new interface driver usbhid
[    9.629868] usbhid: USB HID core driver
[    9.663147] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    9.678561] Initializing XFRM netlink socket
[    9.692773] NET: Registered protocol family 10
[    9.707654] Segment Routing with IPv6
[    9.721248] NET: Registered protocol family 17
[    9.734764] Bluetooth: RFCOMM socket layer initialized
[    9.748294] Bluetooth: RFCOMM ver 1.11
[    9.761653] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.775068] Bluetooth: HIDP socket layer initialized
[    9.788826] microcode: sig=0x806e9, pf=0x80, revision=0x8e
[    9.802311] microcode: Microcode Update Driver: v2.2.
[    9.802321] AVX2 version of gcm_enc/dec engaged.
[    9.828534] AES CTR mode by8 optimization enabled
[    9.841680] sched_clock: Marking stable (9850674581, -9210152)->(9845852582, -4388153)
[    9.857793] registered taskstats version 1
[    9.871025] Loading compiled-in X.509 certificates
[    9.887837] Loaded X.509 cert 'Modules: 5869568a39df9c30b03d7a71d74ff2f3d1dff61b'
[    9.902148] Btrfs loaded, crc32c=crc32c-intel
[    9.915914] AppArmor: AppArmor sha1 policy hashing enabled
[   10.019923] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input7
[   10.034757] ALSA device list:
[   10.049433]   No soundcards found.
[   10.064243] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   10.079429] cfg80211: failed to load regulatory.db
[   10.196991] Freeing unused kernel image memory: 964K
[   10.245212] Write protecting the kernel read-only data: 20480k
[   10.261616] Freeing unused kernel image memory: 2004K
[   10.277289] Freeing unused kernel image memory: 32K
[   10.292591] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   10.307945] x86/mm: Checking user space page tables
[   10.323554] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   10.339219] Run /init as init process
[   12.045192] dmar_fault: 246094 callbacks suppressed
[   12.045196] DMAR: DRHD: handling fault status reg 3
[   12.075964] DMAR: [DMA Write] Request device [00:02.0] fault addr 7db80000 [fault reason 01] Present bit in root entry is clear
[   12.091873] DMAR: DRHD: handling fault status reg 3
[   12.107209] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d9c0000 [fault reason 01] Present bit in root entry is clear
[   12.123151] DMAR: DRHD: handling fault status reg 3
[   12.138966] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dfbd000 [fault reason 01] Present bit in root entry is clear
[   12.155271] DMAR: DRHD: handling fault status reg 3
[   17.055329] dmar_fault: 28370 callbacks suppressed
[   17.055334] DMAR: DRHD: handling fault status reg 3
[   17.087767] DMAR: [DMA Write] Request device [00:02.0] fault addr 7ddc0000 [fault reason 01] Present bit in root entry is clear
[   17.103300] DMAR: DRHD: handling fault status reg 3
[   17.118077] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dcc0000 [fault reason 01] Present bit in root entry is clear
[   17.133690] DMAR: DRHD: handling fault status reg 3
[   17.148685] DMAR: [DMA Write] Request device [00:02.0] fault addr 7db40000 [fault reason 01] Present bit in root entry is clear
[   17.164141] DMAR: DRHD: handling fault status reg 3
[   22.064989] dmar_fault: 85505 callbacks suppressed
[   22.064990] DMAR: DRHD: handling fault status reg 3
[   22.095559] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dfc0000 [fault reason 01] Present bit in root entry is clear
[   22.111632] DMAR: DRHD: handling fault status reg 3
[   22.127350] DMAR: [DMA Write] Request device [00:02.0] fault addr 7de00000 [fault reason 01] Present bit in root entry is clear
[   22.144014] DMAR: DRHD: handling fault status reg 3
[   22.160083] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dd80000 [fault reason 01] Present bit in root entry is clear
[   22.176898] DMAR: DRHD: handling fault status reg 3
[   26.437444] BTRFS: device label root devid 1 transid 256360 /dev/dm-1
[   26.455972] BTRFS: device label home devid 1 transid 607299 /dev/dm-3
[   26.479921] BTRFS: device label lxc devid 1 transid 596 /dev/dm-4
[   26.650955] BTRFS info (device dm-1): enabling auto defrag
[   26.667737] BTRFS info (device dm-1): enabling ssd optimizations
[   26.684466] BTRFS info (device dm-1): using free space tree
[   26.701136] BTRFS info (device dm-1): has skinny extents
[   26.952439] systemd[1]: systemd 239 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN +PCRE2 default-hierarchy=hybrid)
[   27.015086] systemd[1]: Detected architecture x86-64.
[   27.074956] dmar_fault: 262592 callbacks suppressed
[   27.074957] DMAR: DRHD: handling fault status reg 3
[   27.074962] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dbe0000 [fault reason 01] Present bit in root entry is clear
[   27.074968] DMAR: DRHD: handling fault status reg 3
[   27.074971] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dbf5000 [fault reason 01] Present bit in root entry is clear
[   27.074974] DMAR: DRHD: handling fault status reg 3
[   27.074976] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d9cd000 [fault reason 01] Present bit in root entry is clear
[   27.074979] DMAR: DRHD: handling fault status reg 3
[   27.222626] systemd[1]: Set hostname to <xps>.
[   27.302668] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   27.338579] systemd[1]: Listening on udev Kernel Socket.
[   27.374745] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   27.412681] systemd[1]: Created slice User and Session Slice.
[   27.452158] systemd[1]: Listening on LVM2 poll daemon socket.
[   27.489803] systemd[1]: Listening on Journal Audit Socket.
[   27.526955] systemd[1]: Listening on Journal Socket.
[   27.613437] BTRFS info (device dm-1): using free space tree
[   27.988053] audit: type=1400 audit(1536261824.674:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/chronyd" pid=308 comm="apparmor_parser"
[   27.988058] audit: type=1300 audit(1536261824.674:2): arch=c000003e syscall=1 success=yes exit=31329 a0=4 a1=5b15fcac7740 a2=7a61 a3=0 items=0 ppid=307 pid=308 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   27.988265] audit: type=1327 audit(1536261824.674:2): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E6368726F6E7964
[   28.069183] audit: type=1400 audit(1536261824.754:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/conky" pid=314 comm="apparmor_parser"
[   28.095671] audit: type=1300 audit(1536261824.754:3): arch=c000003e syscall=1 success=yes exit=19817 a0=4 a1=59b7d4c19940 a2=4d69 a3=0 items=0 ppid=313 pid=314 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   28.095673] audit: type=1327 audit(1536261824.754:3): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E636F6E6B79
[   28.261003] audit: type=1400 audit(1536261824.944:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/sshd" pid=343 comm="apparmor_parser"
[   28.261006] audit: type=1300 audit(1536261824.944:4): arch=c000003e syscall=1 success=yes exit=36985 a0=4 a1=6499f5a710e0 a2=9079 a3=0 items=0 ppid=342 pid=343 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   28.261150] audit: type=1327 audit(1536261824.944:4): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E73736864
[   28.396461] audit: type=1400 audit(1536261825.084:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/syncthing" pid=349 comm="apparmor_parser"
[   28.773700] systemd-journald[287]: Received request to flush runtime journal from PID 1
[   28.993126] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
[   29.505811] Adding 4194300k swap on /dev/mapper/xps-swap.  Priority:-2 extents:1 across:4194300k SS
[   29.568297] BTRFS info (device dm-3): enabling ssd optimizations
[   29.568300] BTRFS info (device dm-3): enabling auto defrag
[   29.568302] BTRFS info (device dm-3): using free space tree
[   29.568303] BTRFS info (device dm-3): has skinny extents
[   29.570189] BTRFS info (device dm-4): enabling ssd optimizations
[   29.570191] BTRFS info (device dm-4): enabling auto defrag
[   29.570192] BTRFS info (device dm-4): using free space tree
[   29.570193] BTRFS info (device dm-4): has skinny extents
[   31.362863] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[   31.373739] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[   31.398267] IPv6: ADDRCONF(NETDEV_UP): wlp58s0: link is not ready
[   31.436828] IPv6: ADDRCONF(NETDEV_UP): lxcbr: link is not ready
[   32.084955] dmar_fault: 422873 callbacks suppressed
[   32.084956] DMAR: DRHD: handling fault status reg 3
[   32.085355] DMAR: [DMA Read] Request device [00:02.0] fault addr 7d867000 [fault reason 01] Present bit in root entry is clear
[   32.085884] DMAR: DRHD: handling fault status reg 3
[   32.086082] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dc80000 [fault reason 01] Present bit in root entry is clear
[   32.086803] DMAR: DRHD: handling fault status reg 3
[   32.087019] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dcc0000 [fault reason 01] Present bit in root entry is clear
[   32.087785] DMAR: DRHD: handling fault status reg 3
[   37.095224] dmar_fault: 57407 callbacks suppressed
[   37.095226] DMAR: DRHD: handling fault status reg 3
[   37.095684] DMAR: [DMA Write] Request device [00:02.0] fault addr 7de40000 [fault reason 01] Present bit in root entry is clear
[   37.096662] DMAR: DRHD: handling fault status reg 3
[   37.096893] DMAR: [DMA Write] Request device [00:02.0] fault addr 7df00000 [fault reason 01] Present bit in root entry is clear
[   37.097504] DMAR: DRHD: handling fault status reg 3
[   37.097730] DMAR: [DMA Write] Request device [00:02.0] fault addr 7df40000 [fault reason 01] Present bit in root entry is clear
[   37.098575] DMAR: DRHD: handling fault status reg 3
[   37.366818] wlp58s0: authenticate with 04:f0:21:26:da:e4
[   37.412230] wlp58s0: send auth to 04:f0:21:26:da:e4 (try 1/3)
[   37.414966] wlp58s0: authenticated
[   37.425051] wlp58s0: associate with 04:f0:21:26:da:e4 (try 1/3)
[   37.427200] wlp58s0: RX AssocResp from 04:f0:21:26:da:e4 (capab=0x11 status=0 aid=1)
[   37.430257] wlp58s0: associated
[   37.447644] IPv6: ADDRCONF(NETDEV_CHANGE): wlp58s0: link becomes ready
[   42.104962] dmar_fault: 32948 callbacks suppressed
[   42.104965] DMAR: DRHD: handling fault status reg 3
[   42.105400] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d800000 [fault reason 01] Present bit in root entry is clear
[   42.106385] DMAR: DRHD: handling fault status reg 3
[   42.106615] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d8c0000 [fault reason 01] Present bit in root entry is clear
[   42.107292] DMAR: DRHD: handling fault status reg 3
[   42.107522] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d940000 [fault reason 01] Present bit in root entry is clear
[   42.108344] DMAR: DRHD: handling fault status reg 3
[   47.115320] dmar_fault: 36995 callbacks suppressed
[   47.115321] DMAR: DRHD: handling fault status reg 3
[   47.115743] DMAR: [DMA Write] Request device [00:02.0] fault addr 7da80000 [fault reason 01] Present bit in root entry is clear
[   47.116432] DMAR: DRHD: handling fault status reg 3
[   47.116651] DMAR: [DMA Write] Request device [00:02.0] fault addr 7db00000 [fault reason 01] Present bit in root entry is clear
[   47.117412] DMAR: DRHD: handling fault status reg 3
[   47.117628] DMAR: [DMA Write] Request device [00:02.0] fault addr 7db80000 [fault reason 01] Present bit in root entry is clear
[   47.118394] DMAR: DRHD: handling fault status reg 3
[   52.125258] dmar_fault: 46700 callbacks suppressed
[   52.125260] DMAR: DRHD: handling fault status reg 3
[   52.125691] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dcc0000 [fault reason 01] Present bit in root entry is clear
[   52.126644] DMAR: DRHD: handling fault status reg 3
[   52.126859] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dd40000 [fault reason 01] Present bit in root entry is clear
[   52.127621] DMAR: DRHD: handling fault status reg 3
[   52.127835] DMAR: [DMA Write] Request device [00:02.0] fault addr 7ddc0000 [fault reason 01] Present bit in root entry is clear
[   52.128618] DMAR: DRHD: handling fault status reg 3
[   57.134874] dmar_fault: 34598 callbacks suppressed
[   57.134877] DMAR: DRHD: handling fault status reg 3
[   57.135335] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dec0000 [fault reason 01] Present bit in root entry is clear
[   57.136057] DMAR: DRHD: handling fault status reg 3
[   57.136282] DMAR: [DMA Write] Request device [00:02.0] fault addr 7df40000 [fault reason 01] Present bit in root entry is clear
[   57.137091] DMAR: DRHD: handling fault status reg 3
[   57.137323] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dfc0000 [fault reason 01] Present bit in root entry is clear
[   57.138262] DMAR: DRHD: handling fault status reg 3
[   62.144816] dmar_fault: 34127 callbacks suppressed
[   62.144820] DMAR: DRHD: handling fault status reg 3
[   62.145278] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d8c0000 [fault reason 01] Present bit in root entry is clear
[   62.146110] DMAR: DRHD: handling fault status reg 3
[   62.146337] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d940000 [fault reason 01] Present bit in root entry is clear
[   62.147088] DMAR: DRHD: handling fault status reg 3
[   62.147313] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d9c0000 [fault reason 01] Present bit in root entry is clear
[   62.148070] DMAR: DRHD: handling fault status reg 3
[   67.154906] dmar_fault: 31388 callbacks suppressed
[   67.154909] DMAR: DRHD: handling fault status reg 3
[   67.201498] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dfc9000 [fault reason 01] Present bit in root entry is clear
[   67.226994] DMAR: DRHD: handling fault status reg 3
[   67.249700] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dc80000 [fault reason 01] Present bit in root entry is clear
[   67.272767] DMAR: DRHD: handling fault status reg 3
[   67.295477] DMAR: [DMA Write] Request device [00:02.0] fault addr 7db80000 [fault reason 01] Present bit in root entry is clear
[   67.319022] DMAR: DRHD: handling fault status reg 3
[   71.886063] dmar_fault: 27473 callbacks suppressed
[   71.886067] DMAR: DRHD: handling fault status reg 3
[   71.932707] DMAR: [DMA Write] Request device [00:02.0] fault addr 7df80000 [fault reason 01] Present bit in root entry is clear
[   71.958160] DMAR: DRHD: handling fault status reg 3
[   71.980902] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d8c0000 [fault reason 01] Present bit in root entry is clear
[   72.004357] DMAR: DRHD: handling fault status reg 3
[   72.027101] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dfcc000 [fault reason 01] Present bit in root entry is clear
[   72.050571] DMAR: DRHD: handling fault status reg 3
[   76.511699] dmar_fault: 26243 callbacks suppressed
[   76.511702] DMAR: DRHD: handling fault status reg 3
[   76.558530] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d940000 [fault reason 01] Present bit in root entry is clear
[   76.581602] DMAR: DRHD: handling fault status reg 3
[   76.604337] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dac0000 [fault reason 01] Present bit in root entry is clear
[   76.630205] DMAR: DRHD: handling fault status reg 3
[   76.653417] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d8c0000 [fault reason 01] Present bit in root entry is clear
[   76.677291] DMAR: DRHD: handling fault status reg 3
[   81.135892] dmar_fault: 27356 callbacks suppressed
[   81.135895] DMAR: DRHD: handling fault status reg 3
[   81.184633] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dfcc000 [fault reason 01] Present bit in root entry is clear
[   81.208685] DMAR: DRHD: handling fault status reg 3
[   81.232311] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dd40000 [fault reason 01] Present bit in root entry is clear
[   81.258854] DMAR: DRHD: handling fault status reg 3
[   81.282495] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dc40000 [fault reason 01] Present bit in root entry is clear
[   81.307022] DMAR: DRHD: handling fault status reg 3
[   85.760440] dmar_fault: 29255 callbacks suppressed
[   85.760443] DMAR: DRHD: handling fault status reg 3
[   85.809119] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dbc0000 [fault reason 01] Present bit in root entry is clear
[   85.833340] DMAR: DRHD: handling fault status reg 3
[   85.857048] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dec0000 [fault reason 01] Present bit in root entry is clear
[   85.881056] DMAR: DRHD: handling fault status reg 3
[   85.904743] DMAR: [DMA Read] Request device [00:02.0] fault addr 7dfbd000 [fault reason 01] Present bit in root entry is clear
[   85.929311] DMAR: DRHD: handling fault status reg 3
[   90.704973] dmar_fault: 136085 callbacks suppressed
[   90.704975] DMAR: DRHD: handling fault status reg 3
[   90.753475] DMAR: [DMA Write] Request device [00:02.0] fault addr 7de80000 [fault reason 01] Present bit in root entry is clear
[   90.777589] DMAR: DRHD: handling fault status reg 3
[   90.801339] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d940000 [fault reason 01] Present bit in root entry is clear
[   90.825333] DMAR: DRHD: handling fault status reg 3
[   90.849048] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d86f000 [fault reason 01] Present bit in root entry is clear
[   90.873187] DMAR: DRHD: handling fault status reg 3
[   95.714974] dmar_fault: 43184 callbacks suppressed
[   95.714977] DMAR: DRHD: handling fault status reg 3
[   95.763765] DMAR: [DMA Write] Request device [00:02.0] fault addr 7d880000 [fault reason 01] Present bit in root entry is clear
[   95.788060] DMAR: DRHD: handling fault status reg 3
[   95.811789] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dbc0000 [fault reason 01] Present bit in root entry is clear
[   95.836116] DMAR: DRHD: handling fault status reg 3
[   95.859872] DMAR: [DMA Write] Request device [00:02.0] fault addr 7dac0000 [fault reason 01] Present bit in root entry is clear
[   95.884282] DMAR: DRHD: handling fault status reg 3

--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg-with-pt.log

[    0.000000] Linux version 4.19.0-rc2-ARCH-test (feanor@fire) (gcc version 8.2.1 20180831 (GCC)) #2 SMP Thu Sep 6 21:52:25 MSK 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux-test root=/dev/mapper/xps-root rw iommu=pt cryptdevice=UUID=34167ea3-883e-42c4-9cd9-d19518301f18:system:allow-discards rootflags=noatime,autodefrag,ssd slub_debug=P page_poison=1 memtest=2 stack_guard_gap=512 pti=on spec_store_bypass_disable=on l1tf=full,force seed=7VG6ASQoP1PbHJD4L8UX1iWYqmnVryfDTeX9hxOd
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005f2b8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005f2b9000-0x000000005f2b9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005f2ba000-0x000000005f2bafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005f2bb000-0x0000000070874fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070875000-0x0000000070bfffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000070c00000-0x0000000070c43fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000070c44000-0x000000007aef5fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007aef6000-0x000000007b51ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007b520000-0x000000007b5fefff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007b600000-0x000000007f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027e7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ACPI=0x70c0d000  ACPI 2.0=0x70c0d000  SMBIOS=0xf0000  SMBIOS 3.0=0xf0020  MEMATTR=0x6e230018 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.001191] tsc: Detected 2712.000 MHz TSC
[    0.001191] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001193] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001200] last_pfn = 0x27e800 max_arch_pfn = 0x400000000
[    0.001203] MTRR default type: write-back
[    0.001204] MTRR fixed ranges enabled:
[    0.001205]   00000-9FFFF write-back
[    0.001205]   A0000-BFFFF uncachable
[    0.001206]   C0000-FFFFF write-protect
[    0.001206] MTRR variable ranges enabled:
[    0.001208]   0 base 0080000000 mask 7F80000000 uncachable
[    0.001208]   1 base 007E000000 mask 7FFE000000 uncachable
[    0.001209]   2 base 007D000000 mask 7FFF000000 uncachable
[    0.001209]   3 disabled
[    0.001210]   4 disabled
[    0.001210]   5 disabled
[    0.001210]   6 disabled
[    0.001210]   7 disabled
[    0.001211]   8 disabled
[    0.001211]   9 disabled
[    0.002136] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002747] last_pfn = 0x7b600 max_arch_pfn = 0x400000000
[    0.010049] Scanning 1 areas for low memory corruption
[    0.010053] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.010057] Using GB pages for direct mapping
[    0.010059] BRK [0x2539fe000, 0x2539fefff] PGTABLE
[    0.010061] BRK [0x2539ff000, 0x2539fffff] PGTABLE
[    0.010062] BRK [0x253a00000, 0x253a00fff] PGTABLE
[    0.010081] BRK [0x253a01000, 0x253a01fff] PGTABLE
[    0.010083] BRK [0x253a02000, 0x253a02fff] PGTABLE
[    0.010135] BRK [0x253a03000, 0x253a03fff] PGTABLE
[    0.010152] BRK [0x253a04000, 0x253a04fff] PGTABLE
[    0.010200] BRK [0x253a05000, 0x253a05fff] PGTABLE
[    0.010232] BRK [0x253a06000, 0x253a06fff] PGTABLE
[    0.010247] early_memtest: # of tests: 2
[    0.010249]   0x0000000000010000 - 0x0000000000058000 pattern ffffffffffffffff
[    0.010304]   0x0000000000059000 - 0x000000000008c000 pattern ffffffffffffffff
[    0.010344]   0x000000000008c690 - 0x0000000000098000 pattern ffffffffffffffff
[    0.010354]   0x0000000000100000 - 0x0000000036505000 pattern ffffffffffffffff
[    0.264323]   0x000000003727a000 - 0x000000003f392000 pattern ffffffffffffffff
[    0.293473]   0x000000003f3d2000 - 0x000000005d497000 pattern ffffffffffffffff
[    0.402009]   0x000000005f382000 - 0x000000006e230018 pattern ffffffffffffffff
[    0.455547]   0x000000006e2308f8 - 0x000000006fd4c000 pattern ffffffffffffffff
[    0.461525]   0x0000000100000000 - 0x0000000252000000 pattern ffffffffffffffff
[    1.679717]   0x0000000253a0a000 - 0x000000027e800000 pattern ffffffffffffffff
[    1.834342]   0x0000000000010000 - 0x0000000000058000 pattern 0000000000000000
[    1.834399]   0x0000000000059000 - 0x000000000008c000 pattern 0000000000000000
[    1.834439]   0x000000000008c690 - 0x0000000000098000 pattern 0000000000000000
[    1.834449]   0x0000000000100000 - 0x0000000036505000 pattern 0000000000000000
[    2.029332]   0x000000003727a000 - 0x000000003f392000 pattern 0000000000000000
[    2.058507]   0x000000003f3d2000 - 0x000000005d497000 pattern 0000000000000000
[    2.167118]   0x000000005f382000 - 0x000000006e230018 pattern 0000000000000000
[    2.220920]   0x000000006e2308f8 - 0x000000006fd4c000 pattern 0000000000000000
[    2.226969]   0x0000000100000000 - 0x0000000252000000 pattern 0000000000000000
[    3.445665]   0x0000000253a0a000 - 0x000000027e800000 pattern 0000000000000000
[    3.600521] Secure boot could not be determined
[    3.600522] RAMDISK: [mem 0x36505000-0x37279fff]
[    3.600530] ACPI: Early table checksum verification disabled
[    3.600533] ACPI: RSDP 0x0000000070C0D000 000024 (v02 DELL  )
[    3.600538] ACPI: XSDT 0x0000000070C0D0C0 0000FC (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600544] ACPI: FACP 0x0000000070C32B98 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    3.600549] ACPI: DSDT 0x0000000070C0D248 02594E (v02 DELL   CBX3     01072009 INTL 20160422)
[    3.600552] ACPI: FACS 0x000000007AEF3180 000040
[    3.600555] ACPI: APIC 0x0000000070C32CA8 000068 (v03 DELL   CBX3     01072009 AMI  00010013)
[    3.600557] ACPI: FPDT 0x0000000070C32D10 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600560] ACPI: FIDT 0x0000000070C32D58 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600562] ACPI: MCFG 0x0000000070C32E08 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    3.600565] ACPI: HPET 0x0000000070C32E48 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
[    3.600568] ACPI: SSDT 0x0000000070C32E80 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
[    3.600570] ACPI: BOOT 0x0000000070C331E0 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.600573] ACPI: SSDT 0x0000000070C33208 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    3.600576] ACPI: HPET 0x0000000070C344D8 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    3.600578] ACPI: SSDT 0x0000000070C34510 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
[    3.600581] ACPI: UEFI 0x0000000070C35298 000042 (v01                 00000000      00000000)
[    3.600584] ACPI: SSDT 0x0000000070C352E0 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    3.600587] ACPI: LPIT 0x0000000070C361C0 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    3.600589] ACPI: WSMT 0x0000000070C36258 000028 (v01 DELL   CBX3     00000000 MSFT 0000005F)
[    3.600592] ACPI: SSDT 0x0000000070C36280 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
[    3.600594] ACPI: SSDT 0x0000000070C363E8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    3.600597] ACPI: SSDT 0x0000000070C36688 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    3.600600] ACPI: SSDT 0x0000000070C39690 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
[    3.600602] ACPI: DBGP 0x0000000070C39770 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    3.600605] ACPI: DBG2 0x0000000070C397A8 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    3.600607] ACPI: SSDT 0x0000000070C39800 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
[    3.600610] ACPI: SSDT 0x0000000070C39FE0 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
[    3.600613] ACPI: NHLT 0x0000000070C424D8 00002D (v00 INTEL  EDK2     00000002      01000013)
[    3.600616] ACPI: BGRT 0x0000000070C42508 000038 (v00                 01072009 AMI  00010013)
[    3.600618] ACPI: ASF! 0x0000000070C42540 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    3.600621] ACPI: DMAR 0x0000000070C425E0 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
[    3.600629] ACPI: Local APIC address 0xfee00000
[    3.600644] Zone ranges:
[    3.600646]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    3.600647]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    3.600648]   Normal   [mem 0x0000000100000000-0x000000027e7fffff]
[    3.600650] Movable zone start for each node
[    3.600650] Early memory node ranges
[    3.600651]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    3.600652]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    3.600653]   node   0: [mem 0x0000000000100000-0x000000005f2b8fff]
[    3.600654]   node   0: [mem 0x000000005f2bb000-0x0000000070874fff]
[    3.600655]   node   0: [mem 0x000000007b5ff000-0x000000007b5fffff]
[    3.600656]   node   0: [mem 0x0000000100000000-0x000000027e7fffff]
[    3.601631] Reserved but unavailable: 63472 pages
[    3.601632] Initmem setup node 0 [mem 0x0000000000001000-0x000000027e7fffff]
[    3.601634] On node 0 totalpages: 2027536
[    3.601635]   DMA zone: 64 pages used for memmap
[    3.601636]   DMA zone: 22 pages reserved
[    3.601636]   DMA zone: 3996 pages, LIFO batch:0
[    3.601707]   DMA32 zone: 7138 pages used for memmap
[    3.601707]   DMA32 zone: 456820 pages, LIFO batch:63
[    3.612307]   Normal zone: 24480 pages used for memmap
[    3.612308]   Normal zone: 1566720 pages, LIFO batch:63
[    3.638702] Reserving Intel graphics memory at [mem 0x7d800000-0x7f7fffff]
[    3.638998] ACPI: PM-Timer IO Port: 0x1808
[    3.639000] ACPI: Local APIC address 0xfee00000
[    3.639004] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    3.639005] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    3.639032] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    3.639034] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    3.639036] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    3.639038] ACPI: IRQ0 used by override.
[    3.639038] ACPI: IRQ9 used by override.
[    3.639040] Using ACPI (MADT) for SMP configuration information
[    3.639041] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    3.639044] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    3.639060] [mem 0x7f800000-0xdfffffff] available for PCI devices
[    3.639063] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    3.742234] random: get_random_bytes called from start_kernel+0x8a/0x48e with crng_init=0
[    3.742242] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:2 nr_node_ids:1
[    3.742382] percpu: Embedded 42 pages/cpu @(____ptrval____) s132504 r8192 d31336 u1048576
[    3.742389] pcpu-alloc: s132504 r8192 d31336 u1048576 alloc=1*2097152
[    3.742390] pcpu-alloc: [0] 0 1 
[    3.742406] Built 1 zonelists, mobility grouping on.  Total pages: 1995832
[    3.742408] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux-test root=/dev/mapper/xps-root rw iommu=pt cryptdevice=UUID=34167ea3-883e-42c4-9cd9-d19518301f18:system:allow-discards rootflags=noatime,autodefrag,ssd slub_debug=P page_poison=1 memtest=2 stack_guard_gap=512 pti=on spec_store_bypass_disable=on l1tf=full,force seed=7VG6ASQoP1PbHJD4L8UX1iWYqmnVryfDTeX9hxOd
[    3.743009] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    3.743208] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    4.304679] Memory: 7816536K/8110144K available (14360K kernel code, 671K rwdata, 4064K rodata, 964K init, 556K bss, 293608K reserved, 0K cma-reserved)
[    4.304859] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    4.304861] Kernel/User page tables isolation: enabled
[    4.304978] rcu: Hierarchical RCU implementation.
[    4.304978] rcu: 	RCU event tracing is enabled.
[    4.304979] rcu: 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    4.304981] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    4.304999] NR_IRQS: 4352, nr_irqs: 512, preallocated irqs: 16
[    4.305359] spurious 8259A interrupt: IRQ7.
[    4.305387] Console: colour dummy device 80x25
[    4.305584] console [tty0] enabled
[    4.305590] ACPI: Core revision 20180810
[    4.306059] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    4.306092] hpet clockevent registered
[    4.306164] APIC: Switch to symmetric I/O mode setup
[    4.306167] DMAR: Host address width 39
[    4.306169] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    4.306181] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    4.306183] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    4.306192] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    4.306195] DMAR: RMRR base: 0x00000070957000 end: 0x00000070976fff
[    4.306201] DMAR: RMRR base: 0x0000007d000000 end: 0x0000007f7fffff
[    4.306207] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    4.306209] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    4.306211] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    4.306213] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    4.307508] DMAR-IR: Enabled IRQ remapping in xapic mode
[    4.311633] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    4.356102] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2717868ea45, max_idle_ns: 440795316085 ns
[    4.356115] Calibrating delay loop (skipped), value calculated using timer frequency.. 5424.00 BogoMIPS (lpj=27120000)
[    4.356119] pid_max: default: 32768 minimum: 301
[    4.356904] Security Framework initialized
[    4.356910] Yama: becoming mindful.
[    4.356971] AppArmor: AppArmor initialized
[    4.356987] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    4.356989] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    4.357278] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    4.357280] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    4.357286] mce: CPU supports 8 MCE banks
[    4.357296] CPU0: Thermal monitoring enabled (TM1)
[    4.357312] process: using mwait in idle threads
[    4.357315] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    4.357317] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    4.357321] Spectre V2 : Mitigation: Full generic retpoline
[    4.357322] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    4.357324] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    4.357326] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    4.357330] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled
[    4.357332] SMT: Force disabled
[    4.357583] Freeing SMP alternatives memory: 32K
[    4.362482] TSC deadline timer enabled
[    4.362486] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    4.362613] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    4.362653] ... version:                4
[    4.362654] ... bit width:              48
[    4.362656] ... generic registers:      8
[    4.362658] ... value mask:             0000ffffffffffff
[    4.362660] ... max period:             00007fffffffffff
[    4.362661] ... fixed-purpose events:   3
[    4.362663] ... event mask:             00000007000000ff
[    4.362710] rcu: Hierarchical SRCU implementation.
[    4.362797] random: crng done (trusting CPU's manufacturer)
[    4.362961] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    4.363002] smp: Bringing up secondary CPUs ...
[    4.363100] x86: Booting SMP configuration:
[    4.363102] .... node  #0, CPUs:      #1
[    4.363800] smp: Brought up 1 node, 2 CPUs
[    4.363800] smpboot: Max logical packages: 1
[    4.363800] smpboot: Total of 2 processors activated (10848.00 BogoMIPS)
[    4.363800] devtmpfs: initialized
[    4.363800] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    4.363800] futex hash table entries: 512 (order: 3, 32768 bytes)
[    4.363800] xor: automatically using best checksumming function   avx       
[    4.363800] pinctrl core: initialized pinctrl subsystem
[    4.363800] NET: Registered protocol family 16
[    4.363800] audit: initializing netlink subsys (disabled)
[    4.363800] audit: type=2000 audit(1536261369.060:1): state=initialized audit_enabled=0 res=1
[    4.363800] cpuidle: using governor menu
[    4.363800] Simple Boot Flag at 0x47 set to 0x80
[    4.363800] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    4.363800] ACPI: bus type PCI registered
[    4.363800] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.363800] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    4.363800] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    4.363800] PCI: Using configuration type 1 for base access
[    4.366162] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    4.366267] cryptd: max_cpu_qlen set to 1000
[    4.536112] raid6: sse2x1   gen()  8794 MB/s
[    4.706108] raid6: sse2x1   xor()  6486 MB/s
[    4.876109] raid6: sse2x2   gen() 11210 MB/s
[    5.046108] raid6: sse2x2   xor()  7667 MB/s
[    5.216110] raid6: sse2x4   gen() 13163 MB/s
[    5.386108] raid6: sse2x4   xor()  7914 MB/s
[    5.556108] raid6: avx2x1   gen() 18027 MB/s
[    5.726109] raid6: avx2x1   xor() 12742 MB/s
[    5.896109] raid6: avx2x2   gen() 22181 MB/s
[    6.066107] raid6: avx2x2   xor() 14487 MB/s
[    6.236107] raid6: avx2x4   gen() 25753 MB/s
[    6.406109] raid6: avx2x4   xor() 13641 MB/s
[    6.406111] raid6: using algorithm avx2x4 gen() 25753 MB/s
[    6.406113] raid6: .... xor() 13641 MB/s, rmw enabled
[    6.406115] raid6: using avx2x2 recovery algorithm
[    6.406179] ACPI: Added _OSI(Module Device)
[    6.406182] ACPI: Added _OSI(Processor Device)
[    6.406183] ACPI: Added _OSI(3.0 _SCP Extensions)
[    6.406185] ACPI: Added _OSI(Processor Aggregator Device)
[    6.406191] ACPI: Added _OSI(Linux-Dell-Video)
[    6.406197] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    6.530921] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    6.547170] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    6.563103] ACPI: Dynamic OEM Table Load:
[    6.563103] ACPI: SSDT 0xFFFF98EB74920000 0006B4 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    6.566565] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    6.568932] ACPI: Dynamic OEM Table Load:
[    6.568940] ACPI: SSDT 0xFFFF98EB749A1020 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    6.569830] ACPI: Dynamic OEM Table Load:
[    6.569830] ACPI: SSDT 0xFFFF98EB74923838 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    6.569833] ACPI: Dynamic OEM Table Load:
[    6.569833] ACPI: SSDT 0xFFFF98EB749E2820 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    6.578022] ACPI: EC: EC started
[    6.578025] ACPI: EC: interrupt blocked
[    6.587011] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as first EC
[    6.587011] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x14, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    6.587011] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions
[    6.587011] ACPI: Interpreter enabled
[    6.587011] ACPI: (supports S0 S5)
[    6.587011] ACPI: Using IOAPIC for interrupt routing
[    6.587011] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    6.588141] ACPI: Enabled 8 GPEs in block 00 to 7F
[    6.604407] ACPI: Power Resource [WRST] (on)
[    6.605470] ACPI: Power Resource [WRST] (on)
[    6.606504] ACPI: Power Resource [WRST] (on)
[    6.607513] ACPI: Power Resource [WRST] (on)
[    6.608639] ACPI: Power Resource [WRST] (on)
[    6.609741] ACPI: Power Resource [WRST] (on)
[    6.611257] ACPI: Power Resource [WRST] (on)
[    6.612263] ACPI: Power Resource [WRST] (on)
[    6.613240] ACPI: Power Resource [WRST] (on)
[    6.614489] ACPI: Power Resource [WRST] (on)
[    6.615973] ACPI: Power Resource [WRST] (on)
[    6.616891] ACPI: Power Resource [WRST] (on)
[    6.617989] ACPI: Power Resource [WRST] (on)
[    6.619205] ACPI: Power Resource [WRST] (on)
[    6.621091] ACPI: Power Resource [WRST] (on)
[    6.622946] ACPI: Power Resource [WRST] (on)
[    6.624786] ACPI: Power Resource [WRST] (on)
[    6.631973] ACPI: Power Resource [WRST] (on)
[    6.633720] ACPI: Power Resource [WRST] (on)
[    6.635457] ACPI: Power Resource [WRST] (on)
[    6.711298] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    6.711311] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.712024] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    6.712024] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    6.712024] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    6.716810] PCI host bridge to bus 0000:00
[    6.716816] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    6.716821] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    6.716826] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    6.716830] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    6.716835] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    6.716840] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    6.716844] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    6.716849] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    6.716853] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    6.716858] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    6.716862] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    6.716867] pci_bus 0000:00: root bus resource [mem 0x7f800000-0xdfffffff window]
[    6.716872] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    6.716875] pci_bus 0000:00: root bus resource [bus 00-fe]
[    6.716887] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    6.717389] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    6.717401] pci 0000:00:02.0: reg 0x10: [mem 0xdb000000-0xdbffffff 64bit]
[    6.717408] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    6.717413] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    6.717437] pci 0000:00:02.0: BAR 2: assigned to efifb
[    6.718009] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    6.718024] pci 0000:00:04.0: reg 0x10: [mem 0xdc420000-0xdc427fff 64bit]
[    6.718697] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    6.718720] pci 0000:00:14.0: reg 0x10: [mem 0xdc410000-0xdc41ffff 64bit]
[    6.718798] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    6.719578] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    6.719601] pci 0000:00:14.2: reg 0x10: [mem 0xdc434000-0xdc434fff 64bit]
[    6.720221] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    6.720485] pci 0000:00:15.0: reg 0x10: [mem 0xdc433000-0xdc433fff 64bit]
[    6.721952] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
[    6.722215] pci 0000:00:15.1: reg 0x10: [mem 0xdc432000-0xdc432fff 64bit]
[    6.723629] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    6.723657] pci 0000:00:16.0: reg 0x10: [mem 0xdc431000-0xdc431fff 64bit]
[    6.723731] pci 0000:00:16.0: PME# supported from D3hot
[    6.724366] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    6.724462] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    6.724475] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
[    6.725227] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    6.725328] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    6.725342] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    6.726074] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    6.726173] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    6.726188] pci 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
[    6.726927] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    6.727014] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    6.727026] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    6.727781] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    6.728449] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    6.728465] pci 0000:00:1f.2: reg 0x10: [mem 0xdc42c000-0xdc42ffff]
[    6.729064] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380
[    6.729092] pci 0000:00:1f.3: reg 0x10: [mem 0xdc428000-0xdc42bfff 64bit]
[    6.729119] pci 0000:00:1f.3: reg 0x20: [mem 0xdc400000-0xdc40ffff 64bit]
[    6.729178] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    6.729972] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    6.730034] pci 0000:00:1f.4: reg 0x10: [mem 0xdc430000-0xdc4300ff 64bit]
[    6.730106] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    6.731042] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    6.731050] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    6.731055] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.731588] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000
[    6.731917] pci 0000:3a:00.0: reg 0x10: [mem 0xdc000000-0xdc1fffff 64bit]
[    6.733186] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    6.734487] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    6.734494] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    6.735050] pci 0000:3b:00.0: [10ec:525a] type 00 class 0xff0000
[    6.735082] pci 0000:3b:00.0: reg 0x14: [mem 0xdc300000-0xdc300fff]
[    6.735323] pci 0000:3b:00.0: supports D1 D2
[    6.735325] pci 0000:3b:00.0: PME# supported from D1 D2 D3hot D3cold
[    6.735948] pci 0000:00:1c.5: PCI bridge to [bus 3b]
[    6.735955] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
[    6.736234] pci 0000:3c:00.0: [144d:a804] type 00 class 0x010802
[    6.736265] pci 0000:3c:00.0: reg 0x10: [mem 0xdc200000-0xdc203fff 64bit]
[    6.736736] pci 0000:00:1d.0: PCI bridge to [bus 3c]
[    6.736743] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    6.736770] pci_bus 0000:00: on NUMA node 0
[    6.744768] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.745043] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    6.745314] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.745583] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.745851] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.746117] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.746383] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.746646] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.757538] ACPI: EC: interrupt unblocked
[    6.757573] ACPI: EC: event unblocked
[    6.757589] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x14, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    6.757593] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions and events
[    6.757718] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    6.757718] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    6.757718] pci 0000:00:02.0: vgaarb: bridge control possible
[    6.757718] vgaarb: loaded
[    6.757718] SCSI subsystem initialized
[    6.757718] libata version 3.00 loaded.
[    6.757718] ACPI: bus type USB registered
[    6.757718] usbcore: registered new interface driver usbfs
[    6.757718] usbcore: registered new interface driver hub
[    6.757718] usbcore: registered new device driver usb
[    6.757718] pps_core: LinuxPPS API ver. 1 registered
[    6.757718] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.757718] PTP clock support registered
[    6.757718] EDAC MC: Ver: 3.0.0
[    6.757718] Registered efivars operations
[    6.767919] Advanced Linux Sound Architecture Driver Initialized.
[    6.767919] PCI: Using ACPI for IRQ routing
[    6.796252] PCI: pci_cache_line_size set to 64 bytes
[    6.797183] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    6.797185] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    6.797188] e820: reserve RAM buffer [mem 0x5f2b9000-0x5fffffff]
[    6.797190] e820: reserve RAM buffer [mem 0x70875000-0x73ffffff]
[    6.797192] e820: reserve RAM buffer [mem 0x7b600000-0x7bffffff]
[    6.797194] e820: reserve RAM buffer [mem 0x27e800000-0x27fffffff]
[    6.797403] Bluetooth: Core ver 2.22
[    6.797415] NET: Registered protocol family 31
[    6.797417] Bluetooth: HCI device and connection manager initialized
[    6.797420] Bluetooth: HCI socket layer initialized
[    6.797423] Bluetooth: L2CAP socket layer initialized
[    6.797431] Bluetooth: SCO socket layer initialized
[    6.797441] NetLabel: Initializing
[    6.797443] NetLabel:  domain hash size = 128
[    6.797444] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    6.797471] NetLabel:  unlabeled traffic allowed by default
[    6.797495] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    6.797495] wmi_bus wmi_bus-PNP0C14:01: WQBC data block query control method not found
[    6.797495] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    6.797495] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    6.799993] clocksource: Switched to clocksource tsc-early
[    6.800177] AppArmor: AppArmor Filesystem Enabled
[    6.800199] pnp: PnP ACPI init
[    6.800767] system 00:00: [io  0x0680-0x069f] has been reserved
[    6.800773] system 00:00: [io  0xffff] has been reserved
[    6.800778] system 00:00: [io  0xffff] has been reserved
[    6.800782] system 00:00: [io  0xffff] has been reserved
[    6.800787] system 00:00: [io  0x1800-0x18fe] has been reserved
[    6.800791] system 00:00: [io  0x164e-0x164f] has been reserved
[    6.800799] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.801011] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    6.801124] system 00:02: [io  0x1854-0x1857] has been reserved
[    6.801132] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    6.801603] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    6.801650] pnp 00:04: Plug and Play ACPI device, IDs DLL075b PNP0f13 (active)
[    6.802459] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    6.802473] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    6.802481] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    6.802489] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    6.802496] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    6.802505] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    6.802512] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    6.802520] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    6.802528] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    6.802536] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    6.802544] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.802662] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    6.802670] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    6.802678] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    6.802685] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    6.802693] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    6.802700] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    6.802707] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    6.802715] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.803477] system 00:07: [io  0xff00-0xfffe] has been reserved
[    6.803485] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.803485] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
[    6.803485] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
[    6.803485] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.818266] pnp: PnP ACPI: found 9 devices
[    6.825629] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    6.825645] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 1000
[    6.825676] pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
[    6.825680] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    6.825685] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    6.825691] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    6.825696] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.825703] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    6.825709] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    6.825718] pci 0000:00:1c.5: PCI bridge to [bus 3b]
[    6.825723] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
[    6.825731] pci 0000:00:1d.0: PCI bridge to [bus 3c]
[    6.825736] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    6.825745] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    6.825746] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    6.825748] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    6.825749] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    6.825750] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    6.825751] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    6.825753] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    6.825754] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    6.825755] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    6.825757] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    6.825758] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    6.825759] pci_bus 0000:00: resource 15 [mem 0x7f800000-0xdfffffff window]
[    6.825761] pci_bus 0000:00: resource 16 [mem 0xfd000000-0xfe7fffff window]
[    6.825762] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    6.825763] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
[    6.825765] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.825766] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
[    6.825767] pci_bus 0000:3b: resource 1 [mem 0xdc300000-0xdc3fffff]
[    6.825769] pci_bus 0000:3c: resource 1 [mem 0xdc200000-0xdc2fffff]
[    6.826152] NET: Registered protocol family 2
[    6.826354] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    6.826408] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    6.826637] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.827049] TCP: Hash tables configured (established 65536 bind 65536)
[    6.827079] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    6.827155] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    6.827279] NET: Registered protocol family 1
[    6.827431] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.828482] PCI: CLS 0 bytes, default 64
[    6.828543] Unpacking initramfs...
[    7.025712] Freeing initrd memory: 13780K
[    7.025778] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
[    7.025786] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
[    7.025802] DMAR: No ATSR found
[    7.025868] DMAR: dmar0: Using Queued invalidation
[    7.025880] DMAR: dmar1: Using Queued invalidation
[    7.026177] DMAR: Hardware identity mapping for device 0000:00:00.0
[    7.026198] WARNING: CPU: 1 PID: 1 at mm/page_alloc.c:4065 __alloc_pages_slowpath+0xac2/0xb90
[    7.026201] Modules linked in:
[    7.026206] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-rc2-ARCH-test #2
[    7.026209] Hardware name: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    7.026212] RIP: 0010:__alloc_pages_slowpath+0xac2/0xb90
[    7.026215] Code: 24 18 00 00 00 00 c7 44 24 40 00 00 00 00 c7 44 24 30 01 00 00 00 e9 20 fe ff ff 31 c0 41 81 e6 00 02 00 00 0f 85 bc fa ff ff <0f> 0b e9 b5 fa ff ff 65 48 8b 04 25 80 4d 01 00 8b 7c 24 3c 3b b8
[    7.026219] RSP: 0000:ffffa81c0002fb90 EFLAGS: 00010046
[    7.026222] RAX: 0000000000000000 RBX: 0000000000488020 RCX: 0000000000000000
[    7.026224] RDX: ffffa81c0002fc68 RSI: 000000000000000b RDI: 0000000000488020
[    7.026226] RBP: 000000000000000b R08: 0000000000000001 R09: 0000000000000787
[    7.026229] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
[    7.026231] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffa5659fc0
[    7.026233] FS:  0000000000000000(0000) GS:ffff98eb76300000(0000) knlGS:0000000000000000
[    7.026236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.026238] CR2: 0000000000000000 CR3: 000000025340a001 CR4: 00000000003606e0
[    7.026240] Call Trace:
[    7.026247]  ? ___slab_alloc.constprop.83+0x504/0x530
[    7.026252]  ? intel_pasid_alloc_table+0xfc/0x1b0
[    7.026255]  __alloc_pages_nodemask+0x1ae/0x1d0
[    7.026259]  intel_pasid_alloc_table+0x169/0x1b0
[    7.026262]  dmar_insert_one_dev_info+0x2cf/0x4c0
[    7.026267]  ? klist_iter_exit+0x17/0x30
[    7.026270]  ? bus_find_device+0x9c/0xd0
[    7.026273]  domain_add_dev_info+0x4b/0x80
[    7.026277]  dev_prepare_static_identity_mapping+0x2b/0x6d
[    7.026282]  intel_iommu_init+0xbdc/0x10b3
[    7.026286]  ? do_early_param+0x89/0x89
[    7.026289]  pci_iommu_init+0x11/0x3a
[    7.026292]  ? e820__memblock_setup+0x98/0x98
[    7.026295]  do_one_initcall+0x42/0x165
[    7.026299]  ? do_early_param+0x89/0x89
[    7.026302]  kernel_init_freeable+0x14c/0x1d6
[    7.026306]  ? rest_init+0x95/0x95
[    7.026308]  kernel_init+0x5/0xfb
[    7.026311]  ret_from_fork+0x35/0x40
[    7.026317] ---[ end trace c90f8db5437db718 ]---
[    7.026320] DMAR: Failed to setup IOMMU pass-through
[    7.026420] DMAR: Initialization failed
[    7.056225] =============================================================================
[    7.056229] BUG iommu_domain (Tainted: G        W       T): Objects remaining in iommu_domain on __kmem_cache_shutdown()
[    7.056231] -----------------------------------------------------------------------------

[    7.056234] Disabling lock debugging due to kernel taint
[    7.056237] INFO: Slab 0x00000000b109a678 objects=11 used=1 fp=0x00000000377cbd7d flags=0x8000000000008100
[    7.056241] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B   W       T 4.19.0-rc2-ARCH-test #2
[    7.056243] Hardware name: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    7.056245] Call Trace:
[    7.056249]  dump_stack+0x46/0x60
[    7.056253]  slab_err+0xab/0xcf
[    7.056256]  ? unfreeze_partials.isra.73+0x180/0x180
[    7.056260]  ? on_each_cpu_mask+0x1e/0x40
[    7.056263]  ? __kmem_cache_shutdown+0x1ff/0x220
[    7.056267]  __kmem_cache_shutdown.cold.102+0x1d/0x130
[    7.056270]  shutdown_cache+0x10/0x1b0
[    7.056274]  kmem_cache_destroy+0x1fd/0x230
[    7.056277]  intel_iommu_init+0xf47/0x10b3
[    7.056282]  ? do_early_param+0x89/0x89
[    7.056285]  pci_iommu_init+0x11/0x3a
[    7.056287]  ? e820__memblock_setup+0x98/0x98
[    7.056290]  do_one_initcall+0x42/0x165
[    7.056293]  ? do_early_param+0x89/0x89
[    7.056298]  kernel_init_freeable+0x14c/0x1d6
[    7.056301]  ? rest_init+0x95/0x95
[    7.056304]  kernel_init+0x5/0xfb
[    7.056307]  ret_from_fork+0x35/0x40
[    7.056310] INFO: Object 0x000000007ed53471 @offset=5632
[    7.056312] kmem_cache_destroy iommu_domain: Slab cache still has objects
[    7.056315] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B   W       T 4.19.0-rc2-ARCH-test #2
[    7.056317] Hardware name: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    7.056319] Call Trace:
[    7.056322]  dump_stack+0x46/0x60
[    7.056324]  kmem_cache_destroy+0x21a/0x230
[    7.056328]  intel_iommu_init+0xf47/0x10b3
[    7.056331]  ? do_early_param+0x89/0x89
[    7.056334]  pci_iommu_init+0x11/0x3a
[    7.056336]  ? e820__memblock_setup+0x98/0x98
[    7.056339]  do_one_initcall+0x42/0x165
[    7.056342]  ? do_early_param+0x89/0x89
[    7.056345]  kernel_init_freeable+0x14c/0x1d6
[    7.056348]  ? rest_init+0x95/0x95
[    7.056350]  kernel_init+0x5/0xfb
[    7.056353]  ret_from_fork+0x35/0x40
[    7.056357] =============================================================================
[    7.056359] BUG iommu_iova (Tainted: G    B   W       T): Objects remaining in iommu_iova on __kmem_cache_shutdown()
[    7.056362] -----------------------------------------------------------------------------

[    7.056365] INFO: Slab 0x00000000ed9599b4 objects=64 used=19 fp=0x00000000045ef563 flags=0x8000000000000100
[    7.056368] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B   W       T 4.19.0-rc2-ARCH-test #2
[    7.056371] Hardware name: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    7.056373] Call Trace:
[    7.056375]  dump_stack+0x46/0x60
[    7.056378]  slab_err+0xab/0xcf
[    7.056381]  ? on_each_cpu_mask+0x1e/0x40
[    7.056384]  ? __kmem_cache_shutdown+0x1ff/0x220
[    7.056387]  __kmem_cache_shutdown.cold.102+0x1d/0x130
[    7.056390]  shutdown_cache+0x10/0x1b0
[    7.056393]  kmem_cache_destroy+0x1fd/0x230
[    7.056398]  iova_cache_put+0x39/0x60
[    7.056401]  intel_iommu_init+0xf4c/0x10b3
[    7.056404]  ? do_early_param+0x89/0x89
[    7.056407]  pci_iommu_init+0x11/0x3a
[    7.056410]  ? e820__memblock_setup+0x98/0x98
[    7.056412]  do_one_initcall+0x42/0x165
[    7.056415]  ? do_early_param+0x89/0x89
[    7.056418]  kernel_init_freeable+0x14c/0x1d6
[    7.056421]  ? rest_init+0x95/0x95
[    7.056424]  kernel_init+0x5/0xfb
[    7.056426]  ret_from_fork+0x35/0x40
[    7.056430] INFO: Object 0x00000000b8eb0491 @offset=256
[    7.056432] INFO: Object 0x000000002002666a @offset=896
[    7.056434] INFO: Object 0x0000000084897767 @offset=1088
[    7.056435] INFO: Object 0x000000008aebb0ac @offset=1280
[    7.056437] INFO: Object 0x000000008c089539 @offset=1472
[    7.056439] INFO: Object 0x00000000040ead38 @offset=1664
[    7.056441] INFO: Object 0x00000000b14f5cb1 @offset=1728
[    7.056443] INFO: Object 0x00000000f25f41a3 @offset=1792
[    7.056445] INFO: Object 0x00000000f00b095f @offset=1856
[    7.056446] INFO: Object 0x00000000a2684d82 @offset=1920
[    7.056448] INFO: Object 0x00000000c9e2097d @offset=2368
[    7.056450] INFO: Object 0x000000006047b235 @offset=2432
[    7.056452] INFO: Object 0x000000003705eb45 @offset=2560
[    7.056454] INFO: Object 0x000000009f4c7cdd @offset=2944
[    7.056456] INFO: Object 0x000000006f8feedc @offset=3008
[    7.056458] INFO: Object 0x00000000b234e6bf @offset=3200
[    7.056460] INFO: Object 0x000000008cc723bf @offset=3392
[    7.056461] INFO: Object 0x000000000bc1a674 @offset=3456
[    7.056463] INFO: Object 0x00000000aef46f8f @offset=3584
[    7.056465] kmem_cache_destroy iommu_iova: Slab cache still has objects
[    7.056468] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B   W       T 4.19.0-rc2-ARCH-test #2
[    7.056470] Hardware name: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    7.056472] Call Trace:
[    7.056474]  dump_stack+0x46/0x60
[    7.056477]  kmem_cache_destroy+0x21a/0x230
[    7.056481]  iova_cache_put+0x39/0x60
[    7.056483]  intel_iommu_init+0xf4c/0x10b3
[    7.056487]  ? do_early_param+0x89/0x89
[    7.056489]  pci_iommu_init+0x11/0x3a
[    7.056492]  ? e820__memblock_setup+0x98/0x98
[    7.056494]  do_one_initcall+0x42/0x165
[    7.056497]  ? do_early_param+0x89/0x89
[    7.056500]  kernel_init_freeable+0x14c/0x1d6
[    7.056503]  ? rest_init+0x95/0x95
[    7.056506]  kernel_init+0x5/0xfb
[    7.056508]  ret_from_fork+0x35/0x40
[    7.056511] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    7.056514] software IO TLB: mapped [mem 0x6a230000-0x6e230000] (64MB)
[    7.056618] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    7.056622] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.056624] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.056626] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.056627] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.056629] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.056881] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2717868ea45, max_idle_ns: 440795316085 ns
[    7.056894] clocksource: Switched to clocksource tsc
[    7.056917] Scanning for low memory corruption every 60 seconds
[    7.057884] Initialise system trusted keyrings
[    7.057923] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    7.061402] fuse init (API version 7.27)
[    7.062348] NET: Registered protocol family 38
[    7.062410] Key type asymmetric registered
[    7.062412] Asymmetric key parser 'x509' registered
[    7.062428] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    7.062452] io scheduler noop registered (default)
[    7.062454] io scheduler kyber registered
[    7.064376] pcieport 0000:00:1c.0: AER enabled with IRQ 122
[    7.064422] pcieport 0000:00:1c.4: AER enabled with IRQ 123
[    7.064467] pcieport 0000:00:1c.5: AER enabled with IRQ 124
[    7.064507] pcieport 0000:00:1d.0: AER enabled with IRQ 125
[    7.064562] efifb: probing for efifb
[    7.064583] efifb: framebuffer at 0x90000000, using 8128k, total 8128k
[    7.064586] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    7.064587] efifb: scrolling: redraw
[    7.064590] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    7.068507] Console: switching to colour frame buffer device 240x67
[    7.072029] fb0: EFI VGA frame buffer device
[    7.072061] intel_idle: MWAIT substates: 0x11142120
[    7.072063] intel_idle: v0.4.1 model 0x8E
[    7.072421] intel_idle: lapic_timer_reliable_states 0xffffffff
[    7.075934] ACPI: AC Adapter [AC] (on-line)
[    7.076075] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    7.076102] ACPI: Lid Switch [LID0]
[    7.076180] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    7.076208] ACPI: Power Button [PBTN]
[    7.076294] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    7.076321] ACPI: Sleep Button [SBTN]
[    7.076398] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    7.076422] ACPI: Power Button [PWRF]
[    7.080040] thermal LNXTHERM:00: registered as thermal_zone0
[    7.080061] ACPI: Thermal Zone [THM] (25 C)
[    7.080193] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.085083] Non-volatile memory driver v1.3
[    7.088851] [drm] VT-d active for gfx access
[    7.088872] checking generic (90000000 7f0000) vs hw (90000000 10000000)
[    7.088873] fb: switching to inteldrmfb from EFI VGA
[    7.088910] Console: switching to colour dummy device 80x25
[    7.088957] [drm] Replacing VGA console driver
[    7.104979] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.104982] [drm] Driver supports precise vblank timestamp query.
[    7.110980] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    7.111457] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver1_04.bin failed with error -2
[    7.111462] i915 0000:00:02.0: Failed to load DMC firmware i915/kbl_dmc_ver1_04.bin. Disabling runtime power management.
[    7.111465] i915 0000:00:02.0: DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    7.156349] [drm] Initialized i915 1.6.0 20180719 for 0000:00:02.0 on minor 0
[    7.166451] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    7.176830] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    7.176833] battery: ACPI: Battery Slot [BAT0] (battery present)
[    7.177796] fbcon: inteldrmfb (fb0) is primary device
[    7.179794] loop: module loaded
[    7.180100] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0002)
[    7.183104] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    7.184992] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    7.185964] nvme nvme0: pci function 0000:3c:00.0
[    7.186131] tun: Universal TUN/TAP device driver, 1.6
[    7.186630] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
[    7.188599] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    7.377635] uhci_hcd: USB Universal Host Controller Interface driver
[    7.378104] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.378112] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    7.379215] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000109810
[    7.379220] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    7.379806] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    7.379808] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.379809] usb usb1: Product: xHCI Host Controller
[    7.379811] usb usb1: Manufacturer: Linux 4.19.0-rc2-ARCH-test xhci-hcd
[    7.379812] usb usb1: SerialNumber: 0000:00:14.0
[    7.380111] hub 1-0:1.0: USB hub found
[    7.380180] hub 1-0:1.0: 12 ports detected
[    7.385067] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.385072] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    7.385077] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[    7.385192] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    7.385194] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.385195] usb usb2: Product: xHCI Host Controller
[    7.385197] usb usb2: Manufacturer: Linux 4.19.0-rc2-ARCH-test xhci-hcd
[    7.385198] usb usb2: SerialNumber: 0000:00:14.0
[    7.385356] hub 2-0:1.0: USB hub found
[    7.385379] hub 2-0:1.0: 6 ports detected
[    7.386871] usb: port power management may be unreliable
[    7.388202] usbcore: registered new interface driver cdc_acm
[    7.388202] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    7.388222] usbcore: registered new interface driver usb-storage
[    7.388251] usbcore: registered new interface driver usbserial_generic
[    7.388260] usbserial: USB Serial support registered for generic
[    7.388271] usbcore: registered new interface driver cp210x
[    7.388279] usbserial: USB Serial support registered for cp210x
[    7.388290] usbcore: registered new interface driver ftdi_sio
[    7.388296] usbserial: USB Serial support registered for FTDI USB Serial Device
[    7.388315] usbcore: registered new interface driver usb_serial_simple
[    7.388323] usbserial: USB Serial support registered for carelink
[    7.388332] usbserial: USB Serial support registered for zio
[    7.388340] usbserial: USB Serial support registered for funsoft
[    7.388346] usbserial: USB Serial support registered for flashloader
[    7.388353] usbserial: USB Serial support registered for google
[    7.388363] usbserial: USB Serial support registered for libtransistor
[    7.388372] usbserial: USB Serial support registered for vivopay
[    7.388379] usbserial: USB Serial support registered for moto_modem
[    7.388387] usbserial: USB Serial support registered for motorola_tetra
[    7.388393] usbserial: USB Serial support registered for novatel_gps
[    7.388400] usbserial: USB Serial support registered for hp4x
[    7.388407] usbserial: USB Serial support registered for suunto
[    7.388415] usbserial: USB Serial support registered for siemens_mpi
[    7.388545] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    7.389096] i8042: Warning: Keylock active
[    7.391332] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.391337] serio: i8042 AUX port at 0x60,0x64 irq 12
[    7.391692] rtc_cmos 00:01: RTC can wake from S4
[    7.392147] rtc_cmos 00:01: registered as rtc0
[    7.392168] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    7.394569] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    7.394623] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    7.396531] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    7.467460]  nvme0n1: p1 p2
[    7.577982] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
[    7.577984] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[    7.578531] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00079-QCARMSWPZ-1 api 6 features wowlan,ignore-otp crc32 fd869beb
[    7.641792] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 20d869c3
[    7.746155] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    7.927354] usb 1-2: New USB device found, idVendor=234b, idProduct=0001, bcdDevice= 1.00
[    7.927356] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.927357] usb 1-2: Product: NeuG True RNG
[    7.927358] usb 1-2: Manufacturer: Free Software Initiative of Japan
[    7.927359] usb 1-2: SerialNumber: FSIJ-1.0.6-87021528
[    7.928574] cdc_acm 1-2:1.0: ttyACM0: USB ACM device
[    8.222564] psmouse serio1: synaptics: queried max coordinates: x [..5666], y [..4734]
[    8.226239] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[    8.227907] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[    8.229331] ath10k_pci 0000:3a:00.0: htt-ver 3.47 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    8.259804] psmouse serio1: synaptics: queried min coordinates: x [1276..], y [1118..]
[    8.259821] psmouse serio1: synaptics: Your touchpad (PNP: DLL075b PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    8.319382] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2a1, caps: 0xf00323/0x840300/0x12e800/0x0, board id: 3038, fw id: 2375007
[    8.330162] Console: switching to colour frame buffer device 240x67
[    8.371077] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7
[    8.377787] ath: EEPROM regdomain: 0x6c
[    8.377897] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    8.378766] ath: EEPROM indicates we should expect a direct regpair map
[    8.395931] ath: Country alpha2 being used: 00
[    8.395932] ath: Regpair used: 0x6c
[    8.405680] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    8.441547] device-mapper: uevent: version 1.0.3
[    8.443085] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    8.444124] intel_pstate: Intel P-state driver initializing
[    8.445278] intel_pstate: HWP enabled
[    8.446219] EFI Variables Facility v0.08 2004-May-17
[    8.534508] hidraw: raw HID events driver (C) Jiri Kosina
[    8.535366] usbcore: registered new interface driver usbhid
[    8.536183] usbhid: USB HID core driver
[    8.572373] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    8.573643] Initializing XFRM netlink socket
[    8.574695] NET: Registered protocol family 10
[    8.575708] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffffa52ab3a0)
[    8.577997] Segment Routing with IPv6
[    8.578863] NET: Registered protocol family 17
[    8.581002] Bluetooth: RFCOMM socket layer initialized
[    8.581990] Bluetooth: RFCOMM ver 1.11
[    8.582977] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    8.583805] Bluetooth: HIDP socket layer initialized
[    8.589563] microcode: sig=0x806e9, pf=0x80, revision=0x8e
[    8.590459] microcode: Microcode Update Driver: v2.2.
[    8.590465] AVX2 version of gcm_enc/dec engaged.
[    8.592150] AES CTR mode by8 optimization enabled
[    8.594937] sched_clock: Marking stable (8603975592, -9216227)->(8608053871, -13294506)
[    8.595955] registered taskstats version 1
[    8.596834] Loading compiled-in X.509 certificates
[    8.609527] Loaded X.509 cert 'Modules: 5869568a39df9c30b03d7a71d74ff2f3d1dff61b'
[    8.610981] Btrfs loaded, crc32c=crc32c-intel
[    8.611898] AppArmor: AppArmor sha1 policy hashing enabled
[    8.657037] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    8.657955] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.658870] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    8.659782] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    8.660715] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    8.661621] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[    8.662526] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[    8.663422] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    8.667961] snd_hda_codec_realtek hdaudioC0D0: Failed to find dell wmi symbol dell_micmute_led_set
[    8.724274] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input9
[    8.725296] ALSA device list:
[    8.726210]   No soundcards found.
[    8.727202] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    8.728117] cfg80211: failed to load regulatory.db
[    8.729410] Freeing unused kernel image memory: 964K
[    8.733313] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[    8.734262] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    8.735198] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    8.736127] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    8.738272] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    8.741036] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    8.766170] Write protecting the kernel read-only data: 20480k
[    8.767585] Freeing unused kernel image memory: 2004K
[    8.768467] Freeing unused kernel image memory: 32K
[    8.769422] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    8.770269] x86/mm: Checking user space page tables
[    8.771105] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    8.771902] Run /init as init process
[   18.785368] BTRFS: device label home devid 1 transid 607290 /dev/dm-3
[   18.791125] BTRFS: device label lxc devid 1 transid 595 /dev/dm-4
[   18.792723] BTRFS: device label root devid 1 transid 256340 /dev/dm-1
[   18.955622] BTRFS info (device dm-1): enabling auto defrag
[   18.957227] BTRFS info (device dm-1): enabling ssd optimizations
[   18.958779] BTRFS info (device dm-1): using free space tree
[   18.960306] BTRFS info (device dm-1): has skinny extents
[   19.193193] systemd[1]: systemd 239 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN +PCRE2 default-hierarchy=hybrid)
[   19.216533] systemd[1]: Detected architecture x86-64.
[   19.228106] systemd[1]: Set hostname to <xps>.
[   19.307693] systemd[1]: Listening on Journal Audit Socket.
[   19.309898] systemd[1]: Listening on Journal Socket.
[   19.311889] systemd[1]: Reached target Remote File Systems.
[   19.313943] systemd[1]: Listening on Network Service Netlink Socket.
[   19.316290] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   19.320290] systemd[1]: Mounting Huge Pages File System...
[   19.323389] systemd[1]: Mounting FUSE Control File System...
[   19.389338] BTRFS info (device dm-1): using free space tree
[   19.494688] systemd-journald[299]: Received request to flush runtime journal from PID 1
[   19.568256] audit: type=1400 audit(1536261384.250:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/chronyd" pid=334 comm="apparmor_parser"
[   19.569012] audit: type=1300 audit(1536261384.250:2): arch=c000003e syscall=1 success=yes exit=31329 a0=4 a1=5a549b6823d0 a2=7a61 a3=0 items=0 ppid=333 pid=334 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   19.570583] audit: type=1327 audit(1536261384.250:2): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E6368726F6E7964
[   19.610184] audit: type=1400 audit(1536261384.300:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/conky" pid=352 comm="apparmor_parser"
[   19.611072] audit: type=1300 audit(1536261384.300:3): arch=c000003e syscall=1 success=yes exit=19817 a0=4 a1=57d526398940 a2=4d69 a3=0 items=0 ppid=351 pid=352 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   19.612902] audit: type=1327 audit(1536261384.300:3): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E636F6E6B79
[   19.743913] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
[   19.790020] audit: type=1400 audit(1536261384.480:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/sshd" pid=381 comm="apparmor_parser"
[   19.791047] audit: type=1300 audit(1536261384.480:4): arch=c000003e syscall=1 success=yes exit=36985 a0=4 a1=5790835e3e70 a2=9079 a3=0 items=0 ppid=380 pid=381 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   19.793377] audit: type=1327 audit(1536261384.480:4): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E73736864
[   19.925894] audit: type=1400 audit(1536261384.610:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/syncthing" pid=394 comm="apparmor_parser"
[   20.004289] BTRFS info (device dm-4): enabling ssd optimizations
[   20.004291] BTRFS info (device dm-4): enabling auto defrag
[   20.004291] BTRFS info (device dm-4): using free space tree
[   20.004292] BTRFS info (device dm-4): has skinny extents
[   20.014808] BTRFS info (device dm-3): enabling ssd optimizations
[   20.014810] BTRFS info (device dm-3): enabling auto defrag
[   20.014812] BTRFS info (device dm-3): using free space tree
[   20.014813] BTRFS info (device dm-3): has skinny extents
[   20.023088] Adding 4194300k swap on /dev/mapper/xps-swap.  Priority:-2 extents:1 across:4194300k SS
[   20.504579] IPv6: ADDRCONF(NETDEV_UP): lxcbr: link is not ready
[   21.289530] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[   21.292599] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[   21.323055] IPv6: ADDRCONF(NETDEV_UP): wlp58s0: link is not ready
[   22.209596] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[   22.212776] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[   22.244501] IPv6: ADDRCONF(NETDEV_UP): wlp58s0: link is not ready
[   28.189552] wlp58s0: authenticate with 04:f0:21:26:da:e4
[   28.234709] wlp58s0: send auth to 04:f0:21:26:da:e4 (try 1/3)
[   28.237337] wlp58s0: authenticated
[   28.246287] wlp58s0: associate with 04:f0:21:26:da:e4 (try 1/3)
[   28.248172] wlp58s0: RX AssocResp from 04:f0:21:26:da:e4 (capab=0x11 status=0 aid=1)
[   28.250900] wlp58s0: associated
[   28.264857] IPv6: ADDRCONF(NETDEV_CHANGE): wlp58s0: link becomes ready

--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg-with-revert.log

[    0.000000] Linux version 4.19.0-rc2-ARCH-test (feanor@fire) (gcc version 8.2.1 20180831 (GCC)) #2 SMP Fri Sep 7 21:51:26 MSK 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux-test root=/dev/mapper/xps-root rw cryptdevice=UUID=34167ea3-883e-42c4-9cd9-d19518301f18:system:allow-discards rootflags=noatime,autodefrag,ssd slub_debug=P page_poison=1 memtest=2 stack_guard_gap=512 pti=on spec_store_bypass_disable=on l1tf=full,force seed=7VG6ASQoP1PbHJD4L8UX1iWYqmnVryfDTeX9hxOd
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005f2b8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005f2b9000-0x000000005f2b9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005f2ba000-0x000000005f2bafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005f2bb000-0x0000000070874fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070875000-0x0000000070bfffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000070c00000-0x0000000070c43fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000070c44000-0x000000007aef5fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007aef6000-0x000000007b51ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007b520000-0x000000007b5fefff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007b600000-0x000000007f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027e7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ACPI=0x70c0d000  ACPI 2.0=0x70c0d000  SMBIOS=0xf0000  SMBIOS 3.0=0xf0020  MEMATTR=0x6e230018 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. XPS 13 9360/05HM5Y, BIOS 2.9.0 07/09/2018
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.001371] tsc: Detected 2712.000 MHz TSC
[    0.001372] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001374] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001380] last_pfn = 0x27e800 max_arch_pfn = 0x400000000
[    0.001383] MTRR default type: write-back
[    0.001384] MTRR fixed ranges enabled:
[    0.001385]   00000-9FFFF write-back
[    0.001386]   A0000-BFFFF uncachable
[    0.001386]   C0000-FFFFF write-protect
[    0.001387] MTRR variable ranges enabled:
[    0.001388]   0 base 0080000000 mask 7F80000000 uncachable
[    0.001389]   1 base 007E000000 mask 7FFE000000 uncachable
[    0.001389]   2 base 007D000000 mask 7FFF000000 uncachable
[    0.001390]   3 disabled
[    0.001390]   4 disabled
[    0.001390]   5 disabled
[    0.001390]   6 disabled
[    0.001391]   7 disabled
[    0.001391]   8 disabled
[    0.001391]   9 disabled
[    0.002319] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002934] last_pfn = 0x7b600 max_arch_pfn = 0x400000000
[    0.010429] Scanning 1 areas for low memory corruption
[    0.010432] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.010436] Using GB pages for direct mapping
[    0.010438] BRK [0x4a1fe000, 0x4a1fefff] PGTABLE
[    0.010439] BRK [0x4a1ff000, 0x4a1fffff] PGTABLE
[    0.010440] BRK [0x4a200000, 0x4a200fff] PGTABLE
[    0.010466] BRK [0x4a201000, 0x4a201fff] PGTABLE
[    0.010468] BRK [0x4a202000, 0x4a202fff] PGTABLE
[    0.010650] BRK [0x4a203000, 0x4a203fff] PGTABLE
[    0.010690] BRK [0x4a204000, 0x4a204fff] PGTABLE
[    0.010722] early_memtest: # of tests: 2
[    0.010723]   0x0000000000010000 - 0x0000000000058000 pattern ffffffffffffffff
[    0.010779]   0x0000000000059000 - 0x000000000008c000 pattern ffffffffffffffff
[    0.010819]   0x000000000008c690 - 0x0000000000098000 pattern ffffffffffffffff
[    0.010829]   0x0000000000100000 - 0x0000000036505000 pattern ffffffffffffffff
[    0.265039]   0x000000003727a000 - 0x000000003f392000 pattern ffffffffffffffff
[    0.294111]   0x000000003f3d2000 - 0x0000000048800000 pattern ffffffffffffffff
[    0.327445]   0x000000004a20a000 - 0x000000005d497000 pattern ffffffffffffffff
[    0.396613]   0x000000005f382000 - 0x000000006e230018 pattern ffffffffffffffff
[    0.450332]   0x000000006e2308f8 - 0x000000006fd4c000 pattern ffffffffffffffff
[    0.456571]   0x0000000100000000 - 0x000000027e7fe000 pattern ffffffffffffffff
[    1.834879]   0x0000000000010000 - 0x0000000000058000 pattern 0000000000000000
[    1.834936]   0x0000000000059000 - 0x000000000008c000 pattern 0000000000000000
[    1.834977]   0x000000000008c690 - 0x0000000000098000 pattern 0000000000000000
[    1.834987]   0x0000000000100000 - 0x0000000036505000 pattern 0000000000000000
[    2.030619]   0x000000003727a000 - 0x000000003f392000 pattern 0000000000000000
[    2.059536]   0x000000003f3d2000 - 0x0000000048800000 pattern 0000000000000000
[    2.092777]   0x000000004a20a000 - 0x000000005d497000 pattern 0000000000000000
[    2.161852]   0x000000005f382000 - 0x000000006e230018 pattern 0000000000000000
[    2.215477]   0x000000006e2308f8 - 0x000000006fd4c000 pattern 0000000000000000
[    2.221543]   0x0000000100000000 - 0x000000027e7fe000 pattern 0000000000000000
[    3.601892] Secure boot could not be determined
[    3.601894] RAMDISK: [mem 0x36505000-0x37279fff]
[    3.601902] ACPI: Early table checksum verification disabled
[    3.601906] ACPI: RSDP 0x0000000070C0D000 000024 (v02 DELL  )
[    3.601910] ACPI: XSDT 0x0000000070C0D0C0 0000FC (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.601915] ACPI: FACP 0x0000000070C32B98 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    3.601921] ACPI: DSDT 0x0000000070C0D248 02594E (v02 DELL   CBX3     01072009 INTL 20160422)
[    3.601924] ACPI: FACS 0x000000007AEF3180 000040
[    3.601926] ACPI: APIC 0x0000000070C32CA8 000068 (v03 DELL   CBX3     01072009 AMI  00010013)
[    3.601928] ACPI: FPDT 0x0000000070C32D10 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.601931] ACPI: FIDT 0x0000000070C32D58 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.601933] ACPI: MCFG 0x0000000070C32E08 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    3.601936] ACPI: HPET 0x0000000070C32E48 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
[    3.601939] ACPI: SSDT 0x0000000070C32E80 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
[    3.601941] ACPI: BOOT 0x0000000070C331E0 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
[    3.601944] ACPI: SSDT 0x0000000070C33208 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    3.601947] ACPI: HPET 0x0000000070C344D8 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    3.601949] ACPI: SSDT 0x0000000070C34510 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
[    3.601952] ACPI: UEFI 0x0000000070C35298 000042 (v01                 00000000      00000000)
[    3.601955] ACPI: SSDT 0x0000000070C352E0 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    3.601957] ACPI: LPIT 0x0000000070C361C0 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    3.601960] ACPI: WSMT 0x0000000070C36258 000028 (v01 DELL   CBX3     00000000 MSFT 0000005F)
[    3.601963] ACPI: SSDT 0x0000000070C36280 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
[    3.601965] ACPI: SSDT 0x0000000070C363E8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    3.601968] ACPI: SSDT 0x0000000070C36688 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    3.601971] ACPI: SSDT 0x0000000070C39690 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
[    3.601973] ACPI: DBGP 0x0000000070C39770 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    3.601976] ACPI: DBG2 0x0000000070C397A8 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    3.601978] ACPI: SSDT 0x0000000070C39800 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
[    3.601981] ACPI: SSDT 0x0000000070C39FE0 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
[    3.601984] ACPI: NHLT 0x0000000070C424D8 00002D (v00 INTEL  EDK2     00000002      01000013)
[    3.601987] ACPI: BGRT 0x0000000070C42508 000038 (v00                 01072009 AMI  00010013)
[    3.601989] ACPI: ASF! 0x0000000070C42540 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    3.601992] ACPI: DMAR 0x0000000070C425E0 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
[    3.602000] ACPI: Local APIC address 0xfee00000
[    3.602015] Zone ranges:
[    3.602016]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    3.602018]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    3.602019]   Normal   [mem 0x0000000100000000-0x000000027e7fffff]
[    3.602021] Movable zone start for each node
[    3.602022] Early memory node ranges
[    3.602023]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    3.602024]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    3.602025]   node   0: [mem 0x0000000000100000-0x000000005f2b8fff]
[    3.602025]   node   0: [mem 0x000000005f2bb000-0x0000000070874fff]
[    3.602026]   node   0: [mem 0x000000007b5ff000-0x000000007b5fffff]
[    3.602027]   node   0: [mem 0x0000000100000000-0x000000027e7fffff]
[    3.603006] Reserved but unavailable: 63472 pages
[    3.603008] Initmem setup node 0 [mem 0x0000000000001000-0x000000027e7fffff]
[    3.603010] On node 0 totalpages: 2027536
[    3.603011]   DMA zone: 64 pages used for memmap
[    3.603012]   DMA zone: 22 pages reserved
[    3.603013]   DMA zone: 3996 pages, LIFO batch:0
[    3.603083]   DMA32 zone: 7138 pages used for memmap
[    3.603084]   DMA32 zone: 456820 pages, LIFO batch:63
[    3.613630]   Normal zone: 24480 pages used for memmap
[    3.613631]   Normal zone: 1566720 pages, LIFO batch:63
[    3.640602] Reserving Intel graphics memory at [mem 0x7d800000-0x7f7fffff]
[    3.640898] ACPI: PM-Timer IO Port: 0x1808
[    3.640899] ACPI: Local APIC address 0xfee00000
[    3.640903] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    3.640904] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    3.640940] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    3.640942] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    3.640944] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    3.640945] ACPI: IRQ0 used by override.
[    3.640946] ACPI: IRQ9 used by override.
[    3.640948] Using ACPI (MADT) for SMP configuration information
[    3.640949] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    3.640952] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    3.640967] [mem 0x7f800000-0xdfffffff] available for PCI devices
[    3.640970] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    3.744193] random: get_random_bytes called from start_kernel+0x8a/0x48e with crng_init=0
[    3.744202] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:2 nr_node_ids:1
[    3.744330] percpu: Embedded 42 pages/cpu @(____ptrval____) s132504 r8192 d31336 u1048576
[    3.744336] pcpu-alloc: s132504 r8192 d31336 u1048576 alloc=1*2097152
[    3.744337] pcpu-alloc: [0] 0 1 
[    3.744353] Built 1 zonelists, mobility grouping on.  Total pages: 1995832
[    3.744355] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux-test root=/dev/mapper/xps-root rw cryptdevice=UUID=34167ea3-883e-42c4-9cd9-d19518301f18:system:allow-discards rootflags=noatime,autodefrag,ssd slub_debug=P page_poison=1 memtest=2 stack_guard_gap=512 pti=on spec_store_bypass_disable=on l1tf=full,force seed=7VG6ASQoP1PbHJD4L8UX1iWYqmnVryfDTeX9hxOd
[    3.744934] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    3.745141] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    4.307250] Memory: 7816520K/8110144K available (14360K kernel code, 671K rwdata, 4064K rodata, 964K init, 556K bss, 293624K reserved, 0K cma-reserved)
[    4.307429] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    4.307431] Kernel/User page tables isolation: enabled
[    4.307549] rcu: Hierarchical RCU implementation.
[    4.307550] rcu: 	RCU event tracing is enabled.
[    4.307551] rcu: 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    4.307553] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    4.307571] NR_IRQS: 4352, nr_irqs: 512, preallocated irqs: 16
[    4.307931] spurious 8259A interrupt: IRQ7.
[    4.307959] Console: colour dummy device 80x25
[    4.308155] console [tty0] enabled
[    4.308161] ACPI: Core revision 20180810
[    4.308629] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    4.308661] hpet clockevent registered
[    4.308733] APIC: Switch to symmetric I/O mode setup
[    4.308736] DMAR: Host address width 39
[    4.308738] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    4.308750] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    4.308752] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    4.308761] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    4.308763] DMAR: RMRR base: 0x00000070957000 end: 0x00000070976fff
[    4.308770] DMAR: RMRR base: 0x0000007d000000 end: 0x0000007f7fffff
[    4.308777] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    4.308778] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    4.308781] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    4.308783] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    4.308819] DMAR: DRHD: handling fault status reg 3
[    4.308823] DMAR: [DMA Write] Request device [00:02.0] fault addr 7df00000 [fault reason 01] Present bit in root entry is clear
[    4.310083] DMAR-IR: Enabled IRQ remapping in xapic mode
[    4.314204] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    4.358671] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2717868ea45, max_idle_ns: 440795316085 ns
[    4.358685] Calibrating delay loop (skipped), value calculated using timer frequency.. 5424.00 BogoMIPS (lpj=27120000)
[    4.358689] pid_max: default: 32768 minimum: 301
[    4.359468] Security Framework initialized
[    4.359474] Yama: becoming mindful.
[    4.359540] AppArmor: AppArmor initialized
[    4.359557] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    4.359560] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    4.359838] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    4.359840] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    4.359846] mce: CPU supports 8 MCE banks
[    4.359856] CPU0: Thermal monitoring enabled (TM1)
[    4.359871] process: using mwait in idle threads
[    4.359874] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    4.359876] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    4.359879] Spectre V2 : Mitigation: Full generic retpoline
[    4.359881] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    4.359883] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    4.359885] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    4.359888] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled
[    4.359890] SMT: Force disabled
[    4.360138] Freeing SMP alternatives memory: 32K
[    4.366151] TSC deadline timer enabled
[    4.366155] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    4.366282] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    4.366322] ... version:                4
[    4.366323] ... bit width:              48
[    4.366325] ... generic registers:      8
[    4.366327] ... value mask:             0000ffffffffffff
[    4.366329] ... max period:             00007fffffffffff
[    4.366330] ... fixed-purpose events:   3
[    4.366332] ... event mask:             00000007000000ff
[    4.366380] rcu: Hierarchical SRCU implementation.
[    4.366467] random: crng done (trusting CPU's manufacturer)
[    4.366627] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    4.366669] smp: Bringing up secondary CPUs ...
[    4.366767] x86: Booting SMP configuration:
[    4.366770] .... node  #0, CPUs:      #1
[    4.367564] smp: Brought up 1 node, 2 CPUs
[    4.367564] smpboot: Max logical packages: 1
[    4.367564] smpboot: Total of 2 processors activated (10848.00 BogoMIPS)
[    4.367564] devtmpfs: initialized
[    4.367564] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    4.367564] futex hash table entries: 512 (order: 3, 32768 bytes)
[    4.367564] xor: automatically using best checksumming function   avx       
[    4.367564] pinctrl core: initialized pinctrl subsystem
[    4.367564] NET: Registered protocol family 16
[    4.367564] audit: initializing netlink subsys (disabled)
[    4.367564] audit: type=2000 audit(1536346561.060:1): state=initialized audit_enabled=0 res=1
[    4.367564] cpuidle: using governor menu
[    4.367564] Simple Boot Flag at 0x47 set to 0x80
[    4.367564] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    4.367564] ACPI: bus type PCI registered
[    4.367564] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.367564] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    4.367564] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    4.367564] PCI: Using configuration type 1 for base access
[    4.368755] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    4.368827] cryptd: max_cpu_qlen set to 1000
[    4.538677] raid6: sse2x1   gen()  8856 MB/s
[    4.708677] raid6: sse2x1   xor()  6481 MB/s
[    4.878679] raid6: sse2x2   gen() 11190 MB/s
[    5.048676] raid6: sse2x2   xor()  7663 MB/s
[    5.218679] raid6: sse2x4   gen() 13132 MB/s
[    5.388677] raid6: sse2x4   xor()  7915 MB/s
[    5.558678] raid6: avx2x1   gen() 18027 MB/s
[    5.728677] raid6: avx2x1   xor() 12738 MB/s
[    5.898678] raid6: avx2x2   gen() 22170 MB/s
[    6.068676] raid6: avx2x2   xor() 14490 MB/s
[    6.238677] raid6: avx2x4   gen() 25729 MB/s
[    6.408678] raid6: avx2x4   xor() 14917 MB/s
[    6.408680] raid6: using algorithm avx2x4 gen() 25729 MB/s
[    6.408682] raid6: .... xor() 14917 MB/s, rmw enabled
[    6.408684] raid6: using avx2x2 recovery algorithm
[    6.408746] ACPI: Added _OSI(Module Device)
[    6.408748] ACPI: Added _OSI(Processor Device)
[    6.408750] ACPI: Added _OSI(3.0 _SCP Extensions)
[    6.408752] ACPI: Added _OSI(Processor Aggregator Device)
[    6.408758] ACPI: Added _OSI(Linux-Dell-Video)
[    6.408764] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    6.534336] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    6.549749] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    6.566553] ACPI: Dynamic OEM Table Load:
[    6.566553] ACPI: SSDT 0xFFFF8D3DB4927070 0006B4 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    6.570123] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    6.572383] ACPI: Dynamic OEM Table Load:
[    6.572390] ACPI: SSDT 0xFFFF8D3DB49A0000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    6.573277] ACPI: Dynamic OEM Table Load:
[    6.573277] ACPI: SSDT 0xFFFF8D3DB4922020 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    6.573280] ACPI: Dynamic OEM Table Load:
[    6.573280] ACPI: SSDT 0xFFFF8D3DB49E2208 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    6.581339] ACPI: EC: EC started
[    6.581342] ACPI: EC: interrupt blocked
[    6.589497] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as first EC
[    6.589497] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x14, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    6.589497] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions
[    6.589497] ACPI: Interpreter enabled
[    6.589497] ACPI: (supports S0 S5)
[    6.589497] ACPI: Using IOAPIC for interrupt routing
[    6.589497] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    6.590726] ACPI: Enabled 8 GPEs in block 00 to 7F
[    6.606750] ACPI: Power Resource [WRST] (on)
[    6.607817] ACPI: Power Resource [WRST] (on)
[    6.608855] ACPI: Power Resource [WRST] (on)
[    6.609870] ACPI: Power Resource [WRST] (on)
[    6.611000] ACPI: Power Resource [WRST] (on)
[    6.612107] ACPI: Power Resource [WRST] (on)
[    6.613628] ACPI: Power Resource [WRST] (on)
[    6.614639] ACPI: Power Resource [WRST] (on)
[    6.615622] ACPI: Power Resource [WRST] (on)
[    6.616875] ACPI: Power Resource [WRST] (on)
[    6.618359] ACPI: Power Resource [WRST] (on)
[    6.619283] ACPI: Power Resource [WRST] (on)
[    6.620386] ACPI: Power Resource [WRST] (on)
[    6.621607] ACPI: Power Resource [WRST] (on)
[    6.623497] ACPI: Power Resource [WRST] (on)
[    6.625359] ACPI: Power Resource [WRST] (on)
[    6.627207] ACPI: Power Resource [WRST] (on)
[    6.634412] ACPI: Power Resource [WRST] (on)
[    6.636166] ACPI: Power Resource [WRST] (on)
[    6.637906] ACPI: Power Resource [WRST] (on)
[    6.713745] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    6.713758] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.714473] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    6.714473] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    6.714473] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    6.719277] PCI host bridge to bus 0000:00
[    6.719283] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    6.719288] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    6.719293] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    6.719297] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    6.719302] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    6.719307] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    6.719311] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    6.719316] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    6.719320] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    6.719325] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    6.719329] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    6.719334] pci_bus 0000:00: root bus resource [mem 0x7f800000-0xdfffffff window]
[    6.719338] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    6.719342] pci_bus 0000:00: root bus resource [bus 00-fe]
[    6.719354] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    6.719857] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    6.719869] pci 0000:00:02.0: reg 0x10: [mem 0xdb000000-0xdbffffff 64bit]
[    6.719876] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    6.719881] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    6.719910] pci 0000:00:02.0: BAR 2: assigned to efifb
[    6.720483] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    6.720497] pci 0000:00:04.0: reg 0x10: [mem 0xdc420000-0xdc427fff 64bit]
[    6.721172] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    6.721195] pci 0000:00:14.0: reg 0x10: [mem 0xdc410000-0xdc41ffff 64bit]
[    6.721273] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    6.722062] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    6.722084] pci 0000:00:14.2: reg 0x10: [mem 0xdc434000-0xdc434fff 64bit]
[    6.722705] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    6.722968] pci 0000:00:15.0: reg 0x10: [mem 0xdc433000-0xdc433fff 64bit]
[    6.724447] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
[    6.724710] pci 0000:00:15.1: reg 0x10: [mem 0xdc432000-0xdc432fff 64bit]
[    6.726124] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    6.726152] pci 0000:00:16.0: reg 0x10: [mem 0xdc431000-0xdc431fff 64bit]
[    6.726237] pci 0000:00:16.0: PME# supported from D3hot
[    6.726874] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    6.726972] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    6.726986] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
[    6.727737] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    6.727837] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    6.727852] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    6.728589] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    6.728687] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    6.728701] pci 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
[    6.729439] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    6.729528] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    6.729541] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    6.730295] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    6.730965] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    6.730979] pci 0000:00:1f.2: reg 0x10: [mem 0xdc42c000-0xdc42ffff]
[    6.731583] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380
[    6.731611] pci 0000:00:1f.3: reg 0x10: [mem 0xdc428000-0xdc42bfff 64bit]
[    6.731638] pci 0000:00:1f.3: reg 0x20: [mem 0xdc400000-0xdc40ffff 64bit]
[    6.731698] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    6.732499] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    6.732561] pci 0000:00:1f.4: reg 0x10: [mem 0xdc430000-0xdc4300ff 64bit]
[    6.732632] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    6.733571] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    6.733578] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    6.733583] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.734116] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000
[    6.734442] pci 0000:3a:00.0: reg 0x10: [mem 0xdc000000-0xdc1fffff 64bit]
[    6.735716] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    6.737018] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    6.737025] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    6.737582] pci 0000:3b:00.0: [10ec:525a] type 00 class 0xff0000
[    6.737615] pci 0000:3b:00.0: reg 0x14: [mem 0xdc300000-0xdc300fff]
[    6.737860] pci 0000:3b:00.0: supports D1 D2
[    6.737861] pci 0000:3b:00.0: PME# supported from D1 D2 D3hot D3cold
[    6.738491] pci 0000:00:1c.5: PCI bridge to [bus 3b]
[    6.738497] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
[    6.738772] pci 0000:3c:00.0: [144d:a804] type 00 class 0x010802
[    6.738803] pci 0000:3c:00.0: reg 0x10: [mem 0xdc200000-0xdc203fff 64bit]
[    6.739269] pci 0000:00:1d.0: PCI bridge to [bus 3c]
[    6.739276] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    6.739303] pci_bus 0000:00: on NUMA node 0
[    6.747380] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.747656] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    6.747927] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.748196] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.748464] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.748734] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.748999] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.749263] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.760337] ACPI: EC: interrupt unblocked
[    6.760372] ACPI: EC: event unblocked
[    6.760388] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x14, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    6.760392] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions and events
[    6.760521] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    6.760521] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    6.760521] pci 0000:00:02.0: vgaarb: bridge control possible
[    6.760521] vgaarb: loaded
[    6.760521] SCSI subsystem initialized
[    6.760521] libata version 3.00 loaded.
[    6.760521] ACPI: bus type USB registered
[    6.760521] usbcore: registered new interface driver usbfs
[    6.760521] usbcore: registered new interface driver hub
[    6.760521] usbcore: registered new device driver usb
[    6.760521] pps_core: LinuxPPS API ver. 1 registered
[    6.760521] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.760521] PTP clock support registered
[    6.760521] EDAC MC: Ver: 3.0.0
[    6.760521] Registered efivars operations
[    6.770108] Advanced Linux Sound Architecture Driver Initialized.
[    6.770108] PCI: Using ACPI for IRQ routing
[    6.799987] PCI: pci_cache_line_size set to 64 bytes
[    6.800921] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    6.800924] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    6.800926] e820: reserve RAM buffer [mem 0x5f2b9000-0x5fffffff]
[    6.800928] e820: reserve RAM buffer [mem 0x70875000-0x73ffffff]
[    6.800931] e820: reserve RAM buffer [mem 0x7b600000-0x7bffffff]
[    6.800933] e820: reserve RAM buffer [mem 0x27e800000-0x27fffffff]
[    6.801141] Bluetooth: Core ver 2.22
[    6.801152] NET: Registered protocol family 31
[    6.801154] Bluetooth: HCI device and connection manager initialized
[    6.801157] Bluetooth: HCI socket layer initialized
[    6.801160] Bluetooth: L2CAP socket layer initialized
[    6.801167] Bluetooth: SCO socket layer initialized
[    6.801176] NetLabel: Initializing
[    6.801178] NetLabel:  domain hash size = 128
[    6.801179] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    6.801205] NetLabel:  unlabeled traffic allowed by default
[    6.801229] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    6.801229] wmi_bus wmi_bus-PNP0C14:01: WQBC data block query control method not found
[    6.801229] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    6.801229] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    6.802576] clocksource: Switched to clocksource tsc-early
[    6.802772] AppArmor: AppArmor Filesystem Enabled
[    6.802793] pnp: PnP ACPI init
[    6.803355] system 00:00: [io  0x0680-0x069f] has been reserved
[    6.803360] system 00:00: [io  0xffff] has been reserved
[    6.803365] system 00:00: [io  0xffff] has been reserved
[    6.803369] system 00:00: [io  0xffff] has been reserved
[    6.803373] system 00:00: [io  0x1800-0x18fe] has been reserved
[    6.803378] system 00:00: [io  0x164e-0x164f] has been reserved
[    6.803386] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.803600] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    6.803708] system 00:02: [io  0x1854-0x1857] has been reserved
[    6.803716] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    6.804191] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    6.804238] pnp 00:04: Plug and Play ACPI device, IDs DLL075b PNP0f13 (active)
[    6.805053] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    6.805066] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    6.805074] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    6.805082] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    6.805089] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    6.805097] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    6.805105] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    6.805113] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    6.805121] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    6.805129] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    6.805136] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.805254] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    6.805261] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    6.805269] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    6.805276] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    6.805284] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    6.805291] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    6.805299] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    6.805306] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.806064] system 00:07: [io  0xff00-0xfffe] has been reserved
[    6.806072] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.806072] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
[    6.806072] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
[    6.806072] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    6.816857] pnp: PnP ACPI: found 9 devices
[    6.824234] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    6.824250] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 1000
[    6.824278] pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
[    6.824282] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    6.824289] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    6.824295] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    6.824300] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.824307] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    6.824313] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    6.824322] pci 0000:00:1c.5: PCI bridge to [bus 3b]
[    6.824327] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
[    6.824335] pci 0000:00:1d.0: PCI bridge to [bus 3c]
[    6.824340] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    6.824348] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    6.824350] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    6.824351] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    6.824353] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    6.824354] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    6.824355] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    6.824356] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    6.824358] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    6.824359] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    6.824360] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    6.824361] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    6.824363] pci_bus 0000:00: resource 15 [mem 0x7f800000-0xdfffffff window]
[    6.824364] pci_bus 0000:00: resource 16 [mem 0xfd000000-0xfe7fffff window]
[    6.824365] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    6.824367] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
[    6.824368] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
[    6.824369] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
[    6.824371] pci_bus 0000:3b: resource 1 [mem 0xdc300000-0xdc3fffff]
[    6.824372] pci_bus 0000:3c: resource 1 [mem 0xdc200000-0xdc2fffff]
[    6.824740] NET: Registered protocol family 2
[    6.824960] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    6.825005] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    6.825244] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.825643] TCP: Hash tables configured (established 65536 bind 65536)
[    6.825676] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    6.825761] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    6.825886] NET: Registered protocol family 1
[    6.826052] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.827088] PCI: CLS 0 bytes, default 64
[    6.827140] Unpacking initramfs...
[    7.023503] Freeing initrd memory: 13780K
[    7.023572] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
[    7.023580] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
[    7.023596] DMAR: No ATSR found
[    7.023660] DMAR: dmar0: Using Queued invalidation
[    7.023672] DMAR: dmar1: Using Queued invalidation
[    7.023900] DMAR: Setting RMRR:
[    7.023977] DMAR: Setting identity map for device 0000:00:02.0 [0x7d000000 - 0x7f7fffff]
[    7.024054] DMAR: Setting identity map for device 0000:00:14.0 [0x70957000 - 0x70976fff]
[    7.024061] DMAR: Prepare 0-16MiB unity mapping for LPC
[    7.024112] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    7.024353] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    7.024459] iommu: Adding device 0000:00:00.0 to group 0
[    7.024485] iommu: Adding device 0000:00:02.0 to group 1
[    7.024509] iommu: Adding device 0000:00:04.0 to group 2
[    7.024543] iommu: Adding device 0000:00:14.0 to group 3
[    7.024564] iommu: Adding device 0000:00:14.2 to group 3
[    7.024593] iommu: Adding device 0000:00:15.0 to group 4
[    7.024613] iommu: Adding device 0000:00:15.1 to group 4
[    7.024639] iommu: Adding device 0000:00:16.0 to group 5
[    7.024669] iommu: Adding device 0000:00:1c.0 to group 6
[    7.024695] iommu: Adding device 0000:00:1c.4 to group 7
[    7.024720] iommu: Adding device 0000:00:1c.5 to group 8
[    7.024746] iommu: Adding device 0000:00:1d.0 to group 9
[    7.024781] iommu: Adding device 0000:00:1f.0 to group 10
[    7.024800] iommu: Adding device 0000:00:1f.2 to group 10
[    7.024819] iommu: Adding device 0000:00:1f.3 to group 10
[    7.024842] iommu: Adding device 0000:00:1f.4 to group 10
[    7.024871] iommu: Adding device 0000:3a:00.0 to group 11
[    7.024916] iommu: Adding device 0000:3b:00.0 to group 12
[    7.024951] iommu: Adding device 0000:3c:00.0 to group 13
[    7.032002] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    7.032009] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.032011] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.032013] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.032014] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.032016] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.032325] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2717868ea45, max_idle_ns: 440795316085 ns
[    7.032337] clocksource: Switched to clocksource tsc
[    7.032362] Scanning for low memory corruption every 60 seconds
[    7.033268] Initialise system trusted keyrings
[    7.033306] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    7.036814] fuse init (API version 7.27)
[    7.037824] NET: Registered protocol family 38
[    7.037907] Key type asymmetric registered
[    7.037909] Asymmetric key parser 'x509' registered
[    7.037923] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    7.037949] io scheduler noop registered (default)
[    7.037951] io scheduler kyber registered
[    7.040015] pcieport 0000:00:1c.0: AER enabled with IRQ 123
[    7.040065] pcieport 0000:00:1c.4: AER enabled with IRQ 124
[    7.040110] pcieport 0000:00:1c.5: AER enabled with IRQ 125
[    7.040156] pcieport 0000:00:1d.0: AER enabled with IRQ 126
[    7.040207] efifb: probing for efifb
[    7.040226] efifb: framebuffer at 0x90000000, using 8128k, total 8128k
[    7.040228] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    7.040230] efifb: scrolling: redraw
[    7.040233] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    7.044207] Console: switching to colour frame buffer device 240x67
[    7.047779] fb0: EFI VGA frame buffer device
[    7.047807] intel_idle: MWAIT substates: 0x11142120
[    7.047808] intel_idle: v0.4.1 model 0x8E
[    7.048119] intel_idle: lapic_timer_reliable_states 0xffffffff
[    7.050386] ACPI: AC Adapter [AC] (on-line)
[    7.050531] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    7.050560] ACPI: Lid Switch [LID0]
[    7.050634] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    7.050677] ACPI: Power Button [PBTN]
[    7.050750] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    7.050780] ACPI: Sleep Button [SBTN]
[    7.050853] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    7.050880] ACPI: Power Button [PWRF]
[    7.054553] thermal LNXTHERM:00: registered as thermal_zone0
[    7.054577] ACPI: Thermal Zone [THM] (25 C)
[    7.054702] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.059640] Non-volatile memory driver v1.3
[    7.063007] [drm] VT-d active for gfx access
[    7.063031] checking generic (90000000 7f0000) vs hw (90000000 10000000)
[    7.063032] fb: switching to inteldrmfb from EFI VGA
[    7.063069] Console: switching to colour dummy device 80x25
[    7.063201] [drm] Replacing VGA console driver
[    7.075297] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.075301] [drm] Driver supports precise vblank timestamp query.
[    7.082278] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    7.083557] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver1_04.bin failed with error -2
[    7.083562] i915 0000:00:02.0: Failed to load DMC firmware i915/kbl_dmc_ver1_04.bin. Disabling runtime power management.
[    7.083565] i915 0000:00:02.0: DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    7.128723] [drm] Initialized i915 1.6.0 20180719 for 0000:00:02.0 on minor 0
[    7.142354] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    7.151612] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    7.153494] battery: ACPI: Battery Slot [BAT0] (battery present)
[    7.153928] loop: module loaded
[    7.154228] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0002)
[    7.154354] fbcon: inteldrmfb (fb0) is primary device
[    7.157085] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    7.158799] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    7.159720] nvme nvme0: pci function 0000:3c:00.0
[    7.159846] tun: Universal TUN/TAP device driver, 1.6
[    7.160448] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
[    7.162232] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    7.350179] uhci_hcd: USB Universal Host Controller Interface driver
[    7.350646] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.350653] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    7.351813] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000109810
[    7.351818] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    7.352398] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    7.352399] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.352401] usb usb1: Product: xHCI Host Controller
[    7.352402] usb usb1: Manufacturer: Linux 4.19.0-rc2-ARCH-test xhci-hcd
[    7.352403] usb usb1: SerialNumber: 0000:00:14.0
[    7.352698] hub 1-0:1.0: USB hub found
[    7.352766] hub 1-0:1.0: 12 ports detected
[    7.357685] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    7.357690] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    7.357695] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[    7.357828] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    7.357829] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.357831] usb usb2: Product: xHCI Host Controller
[    7.357832] usb usb2: Manufacturer: Linux 4.19.0-rc2-ARCH-test xhci-hcd
[    7.357833] usb usb2: SerialNumber: 0000:00:14.0
[    7.358016] hub 2-0:1.0: USB hub found
[    7.358045] hub 2-0:1.0: 6 ports detected
[    7.359656] usb: port power management may be unreliable
[    7.361074] usbcore: registered new interface driver cdc_acm
[    7.361075] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    7.361101] usbcore: registered new interface driver usb-storage
[    7.361134] usbcore: registered new interface driver usbserial_generic
[    7.361144] usbserial: USB Serial support registered for generic
[    7.361155] usbcore: registered new interface driver cp210x
[    7.361163] usbserial: USB Serial support registered for cp210x
[    7.361174] usbcore: registered new interface driver ftdi_sio
[    7.361180] usbserial: USB Serial support registered for FTDI USB Serial Device
[    7.361196] usbcore: registered new interface driver usb_serial_simple
[    7.361204] usbserial: USB Serial support registered for carelink
[    7.361214] usbserial: USB Serial support registered for zio
[    7.361222] usbserial: USB Serial support registered for funsoft
[    7.361229] usbserial: USB Serial support registered for flashloader
[    7.361236] usbserial: USB Serial support registered for google
[    7.361242] usbserial: USB Serial support registered for libtransistor
[    7.361251] usbserial: USB Serial support registered for vivopay
[    7.361259] usbserial: USB Serial support registered for moto_modem
[    7.361266] usbserial: USB Serial support registered for motorola_tetra
[    7.361272] usbserial: USB Serial support registered for novatel_gps
[    7.361279] usbserial: USB Serial support registered for hp4x
[    7.361286] usbserial: USB Serial support registered for suunto
[    7.361294] usbserial: USB Serial support registered for siemens_mpi
[    7.361432] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    7.361979] i8042: Warning: Keylock active
[    7.363775] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.363780] serio: i8042 AUX port at 0x60,0x64 irq 12
[    7.364185] rtc_cmos 00:01: RTC can wake from S4
[    7.364635] rtc_cmos 00:01: registered as rtc0
[    7.364667] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    7.365207] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    7.365296] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    7.412728]  nvme0n1: p1 p2
[    7.550312] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
[    7.550314] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[    7.550861] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00079-QCARMSWPZ-1 api 6 features wowlan,ignore-otp crc32 fd869beb
[    7.559736] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    7.578008] device-mapper: uevent: version 1.0.3
[    7.579327] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    7.579330] intel_pstate: Intel P-state driver initializing
[    7.580050] intel_pstate: HWP enabled
[    7.580070] EFI Variables Facility v0.08 2004-May-17
[    7.612503] hidraw: raw HID events driver (C) Jiri Kosina
[    7.612534] usbcore: registered new interface driver usbhid
[    7.612535] usbhid: USB HID core driver
[    7.617651] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 20d869c3
[    7.649192] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    7.649618] Initializing XFRM netlink socket
[    7.649852] NET: Registered protocol family 10
[    7.653852] Segment Routing with IPv6
[    7.653895] NET: Registered protocol family 17
[    7.655222] Bluetooth: RFCOMM socket layer initialized
[    7.655224] Bluetooth: RFCOMM ver 1.11
[    7.655226] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    7.655227] Bluetooth: HIDP socket layer initialized
[    7.657902] microcode: sig=0x806e9, pf=0x80, revision=0x8e
[    7.659211] microcode: Microcode Update Driver: v2.2.
[    7.659218] AVX2 version of gcm_enc/dec engaged.
[    7.659219] AES CTR mode by8 optimization enabled
[    7.674107] sched_clock: Marking stable (7678049027, -9219234)->(7683104681, -14274888)
[    7.677915] registered taskstats version 1
[    7.677916] Loading compiled-in X.509 certificates
[    7.685649] Loaded X.509 cert 'Modules: 0a002137e428a2c20a8eb2c95a294213d8a53022'
[    7.687491] Btrfs loaded, crc32c=crc32c-intel
[    7.687509] AppArmor: AppArmor sha1 policy hashing enabled
[    7.719196] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    7.768871] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input6
[    7.768930] ALSA device list:
[    7.768931]   No soundcards found.
[    7.770516] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    7.770517] cfg80211: failed to load regulatory.db
[    7.899811] usb 1-2: New USB device found, idVendor=234b, idProduct=0001, bcdDevice= 1.00
[    7.899812] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.899813] usb 1-2: Product: NeuG True RNG
[    7.899814] usb 1-2: Manufacturer: Free Software Initiative of Japan
[    7.899815] usb 1-2: SerialNumber: FSIJ-1.0.6-87021528
[    7.901021] cdc_acm 1-2:1.0: ttyACM0: USB ACM device
[    8.221834] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[    8.224675] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[    8.227188] ath10k_pci 0000:3a:00.0: htt-ver 3.47 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    8.354618] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffffb94ab3a0)
[    8.357754] Console: switching to colour frame buffer device 240x67
[    8.362247] ath: EEPROM regdomain: 0x6c
[    8.362248] ath: EEPROM indicates we should expect a direct regpair map
[    8.362250] ath: Country alpha2 being used: 00
[    8.362251] ath: Regpair used: 0x6c
[    8.419141] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    8.419773] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    8.420733] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.448682] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    8.448683] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    8.448683] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    8.448685] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[    8.448686] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[    8.448687] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    8.453648] snd_hda_codec_realtek hdaudioC0D0: Failed to find dell wmi symbol dell_micmute_led_set
[    8.456777] Freeing unused kernel image memory: 964K
[    8.488928] Write protecting the kernel read-only data: 20480k
[    8.490339] Freeing unused kernel image memory: 2004K
[    8.491412] Freeing unused kernel image memory: 32K
[    8.492497] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    8.493465] x86/mm: Checking user space page tables
[    8.494446] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    8.495417] Run /init as init process
[    8.517014] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[    8.518070] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    8.519104] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    8.521768] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    8.522791] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    8.523814] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    8.661226] psmouse serio1: synaptics: queried max coordinates: x [..5666], y [..4734]
[    8.695952] psmouse serio1: synaptics: queried min coordinates: x [1276..], y [1118..]
[    8.697030] psmouse serio1: synaptics: Your touchpad (PNP: DLL075b PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    8.769547] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2a1, caps: 0xf00323/0x840300/0x12e800/0x0, board id: 3038, fw id: 2375007
[    8.807379] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input8
[    9.025724] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input16
[   17.998355] BTRFS: device label home devid 1 transid 609442 /dev/dm-3
[   18.002173] BTRFS: device label root devid 1 transid 257230 /dev/dm-1
[   18.006135] BTRFS: device label lxc devid 1 transid 613 /dev/dm-4
[   18.152333] BTRFS info (device dm-1): enabling auto defrag
[   18.154888] BTRFS info (device dm-1): enabling ssd optimizations
[   18.157409] BTRFS info (device dm-1): using free space tree
[   18.159959] BTRFS info (device dm-1): has skinny extents
[   18.384051] systemd[1]: systemd 239 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN +PCRE2 default-hierarchy=hybrid)
[   18.409188] systemd[1]: Detected architecture x86-64.
[   18.428699] systemd[1]: Set hostname to <xps>.
[   18.508835] systemd[1]: Listening on LVM2 metadata daemon socket.
[   18.512141] systemd[1]: Listening on Journal Socket (/dev/log).
[   18.515289] systemd[1]: Listening on udev Control Socket.
[   18.521517] systemd[1]: Listening on Process Core Dump Socket.
[   18.524639] systemd[1]: Listening on Journal Audit Socket.
[   18.527687] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   18.531806] systemd[1]: Created slice User and Session Slice.
[   18.589275] BTRFS info (device dm-1): using free space tree
[   18.720315] systemd-journald[294]: Received request to flush runtime journal from PID 1
[   18.733860] audit: type=1400 audit(1536346575.423:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/chronyd" pid=319 comm="apparmor_parser"
[   18.734791] audit: type=1300 audit(1536346575.423:2): arch=c000003e syscall=1 success=yes exit=31329 a0=4 a1=586343b34570 a2=7a61 a3=0 items=0 ppid=318 pid=319 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   18.736661] audit: type=1327 audit(1536346575.423:2): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E6368726F6E7964
[   18.781922] audit: type=1400 audit(1536346575.473:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/conky" pid=329 comm="apparmor_parser"
[   18.782975] audit: type=1300 audit(1536346575.473:3): arch=c000003e syscall=1 success=yes exit=19817 a0=4 a1=5591b66a4b10 a2=4d69 a3=0 items=0 ppid=328 pid=329 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   18.782977] audit: type=1327 audit(1536346575.473:3): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E636F6E6B79
[   18.916674] audit: type=1400 audit(1536346575.603:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/sshd" pid=372 comm="apparmor_parser"
[   18.918052] audit: type=1300 audit(1536346575.603:4): arch=c000003e syscall=1 success=yes exit=36985 a0=4 a1=6431a6a8d100 a2=9079 a3=0 items=0 ppid=371 pid=372 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/bin/apparmor_parser" subj==unconfined key=(null)
[   18.920526] audit: type=1327 audit(1536346575.603:4): proctitle=2F7362696E2F61707061726D6F725F706172736572002D492F6574632F61707061726D6F722E64002D2D7265706C616365002F6574632F61707061726D6F722E642F7573722E62696E2E73736864
[   19.025455] audit: type=1400 audit(1536346575.713:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/syncthing" pid=377 comm="apparmor_parser"
[   19.038974] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
[   19.263970] BTRFS info (device dm-3): enabling ssd optimizations
[   19.263972] BTRFS info (device dm-3): enabling auto defrag
[   19.263975] BTRFS info (device dm-3): using free space tree
[   19.263975] BTRFS info (device dm-3): has skinny extents
[   19.302914] BTRFS info (device dm-4): enabling ssd optimizations
[   19.302916] BTRFS info (device dm-4): enabling auto defrag
[   19.302917] BTRFS info (device dm-4): using free space tree
[   19.302917] BTRFS info (device dm-4): has skinny extents
[   19.316267] Adding 4194300k swap on /dev/mapper/xps-swap.  Priority:-2 extents:1 across:4194300k SS
[   21.143470] IPv6: ADDRCONF(NETDEV_UP): lxcbr: link is not ready
[   21.946557] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[   21.949236] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[   21.977013] IPv6: ADDRCONF(NETDEV_UP): wlp58s0: link is not ready
[   22.877151] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[   22.880200] ath10k_pci 0000:3a:00.0: Unknown eventid: 90118
[   22.906737] IPv6: ADDRCONF(NETDEV_UP): wlp58s0: link is not ready
[   28.850736] wlp58s0: authenticate with 04:f0:21:26:da:e4
[   28.895963] wlp58s0: send auth to 04:f0:21:26:da:e4 (try 1/3)
[   28.898189] wlp58s0: authenticated
[   28.898705] wlp58s0: associate with 04:f0:21:26:da:e4 (try 1/3)
[   28.900422] wlp58s0: RX AssocResp from 04:f0:21:26:da:e4 (capab=0x11 status=0 aid=1)
[   28.903221] wlp58s0: associated
[   28.916533] IPv6: ADDRCONF(NETDEV_CHANGE): wlp58s0: link becomes ready

--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci.txt

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers (rev 02)
	Subsystem: Dell Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=10 <?>

00:02.0 VGA compatible controller: Intel Corporation HD Graphics 620 (rev 02) (prog-if 00 [VGA controller])
	DeviceName:  Onboard IGD
	Subsystem: Dell HD Graphics 620
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at db000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 90000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable+ Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00008000, Page Request Allocation: 00000020
	Kernel driver in use: i915

00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 02)
	Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dc420000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: proc_thermal

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller (rev 21) (prog-if 30 [XHCI])
	Subsystem: Dell Sunrise Point-LP USB 3.0 xHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 131
	Region 0: Memory at dc410000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00338  Data: 0000
	Kernel driver in use: xhci_hcd

00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Thermal subsystem (rev 21)
	Subsystem: Dell Sunrise Point-LP Thermal subsystem
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at dc434000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal

00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
	Subsystem: Dell Sunrise Point-LP Serial IO I2C Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dc433000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss

00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 (rev 21)
	Subsystem: Dell Sunrise Point-LP Serial IO I2C Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at dc432000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME HECI #1 (rev 21)
	Subsystem: Dell Sunrise Point-LP CSME HECI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at dc431000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 (rev f1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 123
	Bus: primary=00, secondary=01, subordinate=39, sec-latency=0
	I/O behind bridge: 00002000-00002fff [size=4K]
	Memory behind bridge: c4000000-da0fffff [size=353M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000c1ffffff [size=544M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x2, ASPM not supported
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x0 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00238  Data: 0000
	Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [220 v1] Secondary PCI Express <?>
	Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #5 (rev f1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 124
	Bus: primary=00, secondary=3a, subordinate=3a, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: dc000000-dc1fffff [size=2M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #8, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00258  Data: 0000
	Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=50us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=44us
	Capabilities: [220 v1] Secondary PCI Express <?>
	Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #6 (rev f1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 125
	Bus: primary=00, secondary=3b, subordinate=3b, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: dc300000-dc3fffff [size=1M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #6, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #9, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00298  Data: 0000
	Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=60us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=60us
	Capabilities: [220 v1] Secondary PCI Express <?>
	Kernel driver in use: pcieport

00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #9 (rev f1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 126
	Bus: primary=00, secondary=3c, subordinate=3c, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: dc200000-dc2fffff [size=1M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #9, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #12, PowerLimit 25.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee002b8  Data: 0000
	Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=40us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=44us
	Capabilities: [220 v1] Secondary PCI Express <?>
	Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Sunrise Point-LP LPC Controller (rev 21)
	Subsystem: Dell Sunrise Point-LP LPC Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
	Subsystem: Dell Sunrise Point-LP PMC
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at dc42c000 (32-bit, non-prefetchable) [disabled] [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21) (prog-if 80)
	Subsystem: Dell Sunrise Point-LP HD Audio
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 134
	Region 0: Memory at dc428000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at dc400000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee003b8  Data: 0000
	Kernel driver in use: snd_hda_intel

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
	Subsystem: Dell Sunrise Point-LP SMBus
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dc430000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]
	Kernel driver in use: i801_smbus

3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
	Subsystem: Bigfoot Networks, Inc. QCA6174 802.11ac Wireless Network Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 130
	Region 0: Memory at dc000000 (64-bit, non-prefetchable) [size=2M]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit-
		Address: fee00318  Data: 0000
		Masking: 000000fe  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF Via message
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [168 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [178 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [180 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=50us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=44us
	Kernel driver in use: ath10k_pci

3b:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)
	Subsystem: Dell RTS525A PCI Express Card Reader
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 128
	Region 1: Memory at dc300000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002d8  Data: 0000
	Capabilities: [b0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF Via message/WAKE#
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
	Capabilities: [158 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [160 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=60us PortTPowerOnTime=60us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=60us
	Kernel driver in use: rtsx_pci

3c:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961 (prog-if 02 [NVM Express])
	Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dc200000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 25.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=00003000
		PBA: BAR=0 offset=00002000
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [158 v1] Power Budgeting <?>
	Capabilities: [168 v1] Secondary PCI Express <?>
	Capabilities: [188 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [190 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=44us
	Kernel driver in use: nvme


--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bisect.log

git bisect start
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
# bad: [5b394b2ddf0347bef56e50c69a58773c94343ff3] Linux 4.19-rc1
git bisect bad 5b394b2ddf0347bef56e50c69a58773c94343ff3
# good: [54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
git bisect good 54dbe75bbf1e189982516de179147208e90b5e45
# good: [2475c515d4031c494ff452508a8bf8c281ec6e56] Merge tag 'staging-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 2475c515d4031c494ff452508a8bf8c281ec6e56
# good: [c125311d96b1bfcce0f5930a4f0fdfe39ea14f7c] blk-wbt: don't maintain inflight counts if disabled
git bisect good c125311d96b1bfcce0f5930a4f0fdfe39ea14f7c
# good: [2f34a64aeac4d87e8ed8275d9f1230e18a50079c] Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 2f34a64aeac4d87e8ed8275d9f1230e18a50079c
# good: [aa5b1054badb60191f6a09e7ef65beacf837c5d4] Merge tag 'powerpc-4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good aa5b1054badb60191f6a09e7ef65beacf837c5d4
# bad: [2923b27e54242acf27fd16b299e102117c82f52f] Merge tag 'libnvdimm-for-4.19_dax-memory-failure' of gitolite.kernel.org:pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad 2923b27e54242acf27fd16b299e102117c82f52f
# bad: [0519359784328bfa92bf0931bf0cff3b58c16932] Merge branch 'for-4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
git bisect bad 0519359784328bfa92bf0931bf0cff3b58c16932
# bad: [6488a7f35eeab463f6c9c2ea34d30ca856f0bc8e] Merge branches 'arm/shmobile', 'arm/renesas', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' into next
git bisect bad 6488a7f35eeab463f6c9c2ea34d30ca856f0bc8e
# bad: [d9737953d85131436b09668b5e8d3389c37c1f28] iommu/vt-d: Remove the obsolete per iommu pasid tables
git bisect bad d9737953d85131436b09668b5e8d3389c37c1f28
# good: [af39507305fb83a5d3c475c2851f4d59545d8a18] iommu/vt-d: Apply global PASID in SVA
git bisect good af39507305fb83a5d3c475c2851f4d59545d8a18
# good: [cc580e41260dbf1a46269235f1f2b572137d9d03] iommu/vt-d: Per PCI device pasid table interfaces
git bisect good cc580e41260dbf1a46269235f1f2b572137d9d03
# bad: [4774cc5245700b8f4414123908c3a7a1c78e5cbb] iommu/vt-d: Apply per pci device pasid table in SVA
git bisect bad 4774cc5245700b8f4414123908c3a7a1c78e5cbb
# bad: [a7fc93fed94b173e2f9815d50f4024161b0a39ae] iommu/vt-d: Allocate and free pasid table
git bisect bad a7fc93fed94b173e2f9815d50f4024161b0a39ae
# first bad commit: [a7fc93fed94b173e2f9815d50f4024161b0a39ae] iommu/vt-d: Allocate and free pasid table

--MP_/lMvNZTL7q01XseDB/OQYSCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=xps-kernel.config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 4.19.0-rc2 Kernel Configuration
#

#
# Compiler: gcc (GCC) 8.2.1 20180831
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=80201
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION="-ARCH-test"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="xps"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_HYPERVISOR_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_CALGARY_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=4
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_X86_VSYSCALL_EMULATION is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
CONFIG_RESET_ATTACK_MITIGATION=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
CONFIG_VHOST_NET=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=32
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
# CONFIG_MODULE_COMPRESS is not set
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_WBT_SQ=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLK_MQ_PCI=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=m
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_SYN_COOKIES=y
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_NV is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_CUBIC is not set
CONFIG_DEFAULT_BBR=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="bbr"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
# CONFIG_NF_CONNTRACK_PROCFS is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
# CONFIG_NF_CONNTRACK_LABELS is not set
# CONFIG_NF_CT_PROTO_DCCP is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_SET=y
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=y
CONFIG_NFT_COUNTER=y
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=y
CONFIG_NFT_LIMIT=y
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=y
CONFIG_NFT_REJECT_INET=y
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=y
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
# CONFIG_NFT_FIB_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=y
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=m
# CONFIG_NF_TPROXY_IPV4 is not set
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_CHAIN_ROUTE_IPV4 is not set
CONFIG_NFT_REJECT_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
# CONFIG_NF_DUP_IPV4 is not set
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=y
CONFIG_NF_NAT_IPV4=m
CONFIG_NFT_CHAIN_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NFT_MASQ_IPV4=m
CONFIG_NFT_REDIR_IPV4=m
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
# CONFIG_NF_TPROXY_IPV6 is not set
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_CHAIN_ROUTE_IPV6 is not set
CONFIG_NFT_REJECT_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
CONFIG_NFT_FIB_IPV6=m
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=m
# CONFIG_NF_NAT_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_TABLES_BRIDGE=y
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_MRP=m
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_DEFAULT=y
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=y
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_CSUM is not set
# CONFIG_NET_ACT_VLAN is not set
CONFIG_NET_ACT_BPF=y
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
# CONFIG_BT_RFCOMM_TTY is not set
# CONFIG_BT_BNEP is not set
CONFIG_BT_HIDP=y
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
# CONFIG_BT_HCIUART_H4 is not set
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIUART_ATH3K is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
# CONFIG_CFG80211_REG_CELLULAR_HINTS is not set
CONFIG_CFG80211_REG_RELAX_NO_IR=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
CONFIG_MAC80211_RC_MINSTREL_VHT=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE="ath10k/QCA6174/hw3.0/firmware-6.bin ath10k/QCA6174/hw3.0/board-2.bin"
CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware/"
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_FC is not set

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
CONFIG_MISC_RTSX_PCI=y
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_MQ_DEFAULT=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
CONFIG_PATA_AMD=y
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=y
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
CONFIG_PATA_SCH=y
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_MQ_DEFAULT=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_FEC=y
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
CONFIG_DM_INTEGRITY=m
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=y
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_ETHERNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=m
# CONFIG_USB_NET_AX8817X is not set
# CONFIG_USB_NET_AX88179_178A is not set
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_VL600 is not set
# CONFIG_USB_NET_CH9200 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
# CONFIG_WLAN_VENDOR_ADMTEK is not set
CONFIG_ATH_COMMON=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
CONFIG_ATH10K=y
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=y
# CONFIG_ATH10K_SDIO is not set
# CONFIG_ATH10K_USB is not set
# CONFIG_ATH10K_DEBUG is not set
# CONFIG_ATH10K_DEBUGFS is not set
# CONFIG_ATH10K_DFS_CERTIFIED is not set
# CONFIG_WCN36XX is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=m
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=y
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_CORE is not set
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=2
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=1024
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=2048
# CONFIG_SND_USB is not set
# CONFIG_SND_PCMCIA is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=m
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=y
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_ROLE_SWITCH=m
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=y
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_MXM_WMI is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# CONFIG_FPGA is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FS_ENCRYPTION is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
# CONFIG_CONFIGFS_FS is not set
CONFIG_EFIVAR_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="apparmor"
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_XOR=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SHA1_MB is not set
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SPECK is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=60
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--MP_/lMvNZTL7q01XseDB/OQYSCh--
