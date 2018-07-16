Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5320BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E5320BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:42:33 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56385 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbeGPQmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:42:33 -0400
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 51A542012BA075;
        Mon, 16 Jul 2018 18:14:10 +0200 (CEST)
To:     amd-gfx@lists.freedesktop.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Subject: KMS does not work on MSI B350M MORTAR with AMD Ryzen 3 2200g
Message-ID: <ba7e0ef4-5b5c-76d7-304d-6bdd2ad55b80@molgen.mpg.de>
Date:   Mon, 16 Jul 2018 18:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060709080405070606060400"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060709080405070606060400
Content-Type: multipart/mixed;
 boundary="------------3E9F0A289822BB448CB99FCC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3E9F0A289822BB448CB99FCC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


Trying to boot Debian Buster/testing with Linux 4.16.16 on a MSI B350M MO=
RTAR [1]
with a Ryzen 3 2200g and a monitor connected over HDMI, when kernel mode =
setting
(KMS) is enabled the monitor does not receive any updates, that means I d=
o not
see the login prompt and only the Linux and systemd service messages from=
 before.
The system seems to running though.

Debian=E2=80=99s package *firmware-amd-graphics* [2] is from August 2017 =
and therefore
outdated. I manually installed the firmware files from the Linux firmware=

repository [3].

Here is the log.

```
Jul 16 17:54:39 tokeiihto kernel: [   25.652026] [drm] BIOS signature inc=
orrect 0 0
Jul 16 17:54:39 tokeiihto kernel: [   25.652058] ATOM BIOS: 113-RAVEN-106=

Jul 16 17:54:39 tokeiihto kernel: [   25.652096] [drm] vm size is 262144 =
GB, 4 levels, block size is 9-bit, fragment size is 9-bit
Jul 16 17:54:39 tokeiihto kernel: [   25.652107] amdgpu 0000:38:00.0: VRA=
M: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Jul 16 17:54:39 tokeiihto kernel: [   25.652109] amdgpu 0000:38:00.0: GTT=
: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
Jul 16 17:54:39 tokeiihto kernel: [   25.652113] [drm] Detected VRAM RAM=3D=
1024M, BAR=3D256M
Jul 16 17:54:39 tokeiihto kernel: [   25.652114] [drm] RAM width 128bits =
UNKNOWN
Jul 16 17:54:39 tokeiihto kernel: [   25.652170] [TTM] Zone  kernel: Avai=
lable graphics memory: 7703370 kiB
Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Zone   dma32: Avai=
lable graphics memory: 2097152 kiB
Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Initializing pool =
allocator
Jul 16 17:54:39 tokeiihto kernel: [   25.652174] [TTM] Initializing DMA p=
ool allocator
Jul 16 17:54:39 tokeiihto kernel: [   25.652202] [drm] amdgpu: 1024M of V=
RAM memory ready
Jul 16 17:54:39 tokeiihto kernel: [   25.652203] [drm] amdgpu: 3072M of G=
TT memory ready.
Jul 16 17:54:39 tokeiihto kernel: [   25.652220] [drm] GART: num cpu page=
s 262144, num gpu pages 262144
Jul 16 17:54:39 tokeiihto kernel: [   25.652433] [drm] PCIE GART of 1024M=
 enabled (table at 0x000000F400800000).
Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Supports vblank ti=
mestamp caching Rev 2 (21.10.2013).
Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Driver supports pr=
ecise vblank timestamp query.
Jul 16 17:54:39 tokeiihto kernel: [   25.652983] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_asd.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653276] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_pfp.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653498] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_me.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653668] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_ce.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653960] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_rlc.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.654817] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_mec.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.656137] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_mec2.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.658217] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_sdma.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.658220] [drm] use_doorbell being=
 set to: [true]
Jul 16 17:54:39 tokeiihto kernel: [   25.659663] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_vcn.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.659667] [drm] Found VCN firmware=
 Version: 1.73 Family ID: 18
Jul 16 17:54:39 tokeiihto kernel: [   25.847424] [drm] VCN decode and enc=
ode initialized successfully.
Jul 16 17:54:39 tokeiihto kernel: [   25.852189] amdgpu 0000:38:00.0: rin=
g 0(gfx) uses VM inv eng 4 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852191] amdgpu 0000:38:00.0: rin=
g 1(comp_1.0.0) uses VM inv eng 5 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852193] amdgpu 0000:38:00.0: rin=
g 2(comp_1.1.0) uses VM inv eng 6 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852194] amdgpu 0000:38:00.0: rin=
g 3(comp_1.2.0) uses VM inv eng 7 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852195] amdgpu 0000:38:00.0: rin=
g 4(comp_1.3.0) uses VM inv eng 8 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852197] amdgpu 0000:38:00.0: rin=
g 5(comp_1.0.1) uses VM inv eng 9 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852198] amdgpu 0000:38:00.0: rin=
g 6(comp_1.1.1) uses VM inv eng 10 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852200] amdgpu 0000:38:00.0: rin=
g 7(comp_1.2.1) uses VM inv eng 11 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852201] amdgpu 0000:38:00.0: rin=
g 8(comp_1.3.1) uses VM inv eng 12 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852202] amdgpu 0000:38:00.0: rin=
g 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852204] amdgpu 0000:38:00.0: rin=
g 10(sdma0) uses VM inv eng 4 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.852205] amdgpu 0000:38:00.0: rin=
g 11(vcn_dec) uses VM inv eng 5 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.852207] amdgpu 0000:38:00.0: rin=
g 12(vcn_enc0) uses VM inv eng 6 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.852208] amdgpu 0000:38:00.0: rin=
g 13(vcn_enc1) uses VM inv eng 7 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.856580] [drm] Initialized amdgpu=
 3.23.0 20150101 for 0000:38:00.0 on minor 0
```

The messages `[drm] BIOS signature incorrect 0 0` stands out. The latest
mainboard firmware version 7A37v1F from May 2018 is installed [4].

Booting with `nomodeset` works.

Please find attached the full log with the KMS boot messages in the
beginning, and the nomodeset messages in the second part.

Do you have any hints how to get modesetting to work?


Kind regards,

Paul


PS: Here is the output of `lspci`.

```
$ lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15d0]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:15d=
1]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15d3]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15db]
00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15dc]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Contro=
ller [1022:790b] (rev 61)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bri=
dge [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15e8]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15e9]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ea]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15eb]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ec]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ed]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ee]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ef]
15:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 300 Ser=
ies Chipset USB 3.1 xHCI Controller [1022:43bb] (rev 02)
15:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 300 Se=
ries Chipset SATA Controller [1022:43b7] (rev 02)
15:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:43b2] (rev 02)
16:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
16:01.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
16:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
18:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL81=
11/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)=

38:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] [100=
2:15dd] (rev c8)
38:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Devic=
e [1002:15de]
38:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:15df]
38:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device =
[1022:15e0]
38:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device =
[1022:15e1]
38:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Device [1=
022:15e3]
39:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SA=
TA Controller [AHCI mode] [1022:7901] (rev 61)
```

[1]: https://www.msi.com/Motherboard/B350M-MORTAR/
[2]: https://packages.debian.org/buster/firmware-amd-graphics
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmw=
are.git/
[4]: https://www.msi.com/Motherboard/support/B350M-MORTAR

--------------3E9F0A289822BB448CB99FCC
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Linux version 4.16.0-2-a=
md64 (debian-kernel@lists.debian.org) (gcc version 7.3.0 (Debian 7.3.0-23=
)) #1 SMP Debian 4.16.16-2 (2018-06-22)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Command line: BOOT_IMAGE=
=3D/vmlinuz-4.16.0-2-amd64 root=3DUUID=3D313f78e2-468f-4660-b236-d1de214b=
f6b4 ro quiet
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] x86/fpu: Supporting XSAV=
E feature 0x001: 'x87 floating point registers'
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] x86/fpu: Supporting XSAV=
E feature 0x002: 'SSE registers'
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] x86/fpu: Supporting XSAV=
E feature 0x004: 'AVX registers'
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] x86/fpu: xstate_offset[2=
]:  576, xstate_sizes[2]:  256
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] x86/fpu: Enabled xstate =
features 0x7, context size is 832 bytes, using 'compacted' format.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: BIOS-provided phys=
ical RAM map:
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0000000000-0x000000000009ffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00000a0000-0x00000000000fffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0000100000-0x0000000003ffffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0004000000-0x0000000004009fff] ACPI NVS
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000400a000-0x0000000009d7ffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0009d80000-0x0000000009ffffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000a000000-0x000000000affffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000b000000-0x000000000b01ffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000b020000-0x000000009d1e4fff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d1e5000-0x000000009d2d4fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d2d5000-0x000000009d3c6fff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d3c7000-0x000000009d78ffff] ACPI NVS
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d790000-0x000000009e5bffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009e5c0000-0x000000009e664fff] type 20
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009e665000-0x000000009effffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009f000000-0x00000000dfffffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00f8000000-0x00000000fbffffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fd800000-0x00000000fdffffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fea00000-0x00000000fea0ffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00feb80000-0x00000000fec01fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fec10000-0x00000000fec10fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fec30000-0x00000000fec30fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fed00000-0x00000000fed00fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fed40000-0x00000000fed44fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fed80000-0x00000000fed8ffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fedc2000-0x00000000fedcffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fedd4000-0x00000000fedd5fff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fee00000-0x00000000feefffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00ff000000-0x00000000ffffffff] reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0100000000-0x000000041f33ffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] NX (Execute Disable) pro=
tection: active
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] efi: EFI v2.60 by Americ=
an Megatrends
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] efi:  ACPI 2.0=3D0x9d3c7=
000  ACPI=3D0x9d3c7000  SMBIOS=3D0x9e48d000  ESRT=3D0x98880f98  MEMATTR=3D=
0x97a58018=20
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] secureboot: Secure boot =
could not be determined (mode 0)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] SMBIOS 2.8 present.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] DMI: MSI MS-7A37/B350M M=
ORTAR (MS-7A37), BIOS 1.F0 04/27/2018
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: update [mem 0x0000=
0000-0x00000fff] usable =3D=3D> reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: remove [mem 0x000a=
0000-0x000fffff] usable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: last_pfn =3D 0x41f=
340 max_arch_pfn =3D 0x400000000
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] MTRR default type: uncac=
hable
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] MTRR fixed ranges enable=
d:
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   00000-9FFFF write-back=

Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   A0000-BFFFF write-thro=
ugh
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   C0000-FFFFF write-prot=
ect
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] MTRR variable ranges ena=
bled:
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   0 base 000000000000 ma=
sk FFFF80000000 write-back
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   1 base 000080000000 ma=
sk FFFFC0000000 write-back
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   2 base 0000C0000000 ma=
sk FFFFE0000000 write-back
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   3 disabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   4 disabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   5 disabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   6 disabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   7 disabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] TOM2: 0000000420000000 a=
ka 16896M
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] x86/PAT: Configuration [=
0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: update [mem 0xe000=
0000-0xffffffff] usable =3D=3D> reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: last_pfn =3D 0x9f0=
00 max_arch_pfn =3D 0x400000000
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] esrt: Reserving ESRT spa=
ce from 0x0000000098880f98 to 0x0000000098880fd0.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Base memory trampoline a=
t [        (ptrval)] 96000 size 24576
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Using GB pages for direc=
t mapping
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f82c000, 0x28f8=
2cfff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f82d000, 0x28f8=
2dfff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f82e000, 0x28f8=
2efff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f82f000, 0x28f8=
2ffff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f830000, 0x28f8=
30fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f831000, 0x28f8=
31fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f832000, 0x28f8=
32fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f833000, 0x28f8=
33fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f834000, 0x28f8=
34fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f835000, 0x28f8=
35fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f836000, 0x28f8=
36fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] BRK [0x28f837000, 0x28f8=
37fff] PGTABLE
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] RAMDISK: [mem 0x34e69000=
-0x3672bfff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: Early table checks=
um verification disabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: RSDP 0x000000009D3=
C7000 000024 (v02 ALASKA)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: XSDT 0x000000009D3=
C70A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: FACP 0x000000009D3=
CE8B8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI BIOS Warning (bug):=
 Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0=
x0000000000000000/0x1 (20180105/tbfadt-658)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: DSDT 0x000000009D3=
C71F0 0076C7 (v02 ALASKA A M I    01072009 INTL 20120913)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: FACS 0x000000009D7=
79E00 000040
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: APIC 0x000000009D3=
CE9D0 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: FPDT 0x000000009D3=
CEAB0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: FIDT 0x000000009D3=
CEAF8 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
CEB98 005367 (v02 AMD    AmdTable 00000002 MSFT 02000002)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D3F00 0007DC (v01 AMD    AMD CPU  00000001 AMD  00000001)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: CRAT 0x000000009D3=
D46E0 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: CDIT 0x000000009D3=
D4EF0 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D4F20 002D89 (v01 AMD    AMD AOD  00000001 INTL 20120913)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: MCFG 0x000000009D3=
D7CB0 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: HPET 0x000000009D3=
D7CF0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: UEFI 0x000000009D3=
D7D28 000042 (v01                 00000000      00000000)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: IVRS 0x000000009D3=
D7D70 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: BGRT 0x000000009D3=
D7E40 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D7E78 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D7F70 000E96 (v01 AMD    AmdTable 00000001 INTL 20120913)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D8E08 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D9658 001A41 (v01 AMD    AmdTable 00000001 INTL 20120913)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: WSMT 0x000000009D3=
DB0A0 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: Local APIC address=
 0xfee00000
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] No NUMA configuration fo=
und
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Faking a node at [mem 0x=
0000000000000000-0x000000041f33ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] NODE_DATA(0) allocated [=
mem 0x41f33b000-0x41f33ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] tsc: Fast TSC calibratio=
n failed
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] tsc: Using PIT calibrati=
on value
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Zone ranges:
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA      [mem 0x000000=
0000001000-0x0000000000ffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA32    [mem 0x000000=
0001000000-0x00000000ffffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   Normal   [mem 0x000000=
0100000000-0x000000041f33ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   Device   empty
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Movable zone start for e=
ach node
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Early memory node ranges=

Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
00000001000-0x000000000009ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
00000100000-0x0000000003ffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0000400a000-0x0000000009d7ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0000a000000-0x000000000affffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0000b020000-0x000000009d1e4fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0009d2d5000-0x000000009d3c6fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0009e665000-0x000000009effffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
00100000000-0x000000041f33ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Initmem setup node 0 [me=
m 0x0000000000001000-0x000000041f33ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] On node 0 totalpages: 39=
19015
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA zone: 64 pages use=
d for memmap
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA zone: 28 pages res=
erved
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA zone: 3999 pages, =
LIFO batch:0
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA32 zone: 10024 page=
s used for memmap
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   DMA32 zone: 641480 pag=
es, LIFO batch:31
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   Normal zone: 51149 pag=
es used for memmap
Jul 16 17:54:39 tokeiihto kernel: [    0.000000]   Normal zone: 3273536 p=
ages, LIFO batch:31
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Reserved but unavailable=
: 97 pages
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: PM-Timer IO Port: =
0x808
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: Local APIC address=
 0xfee00000
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id=
[0xff] high edge lint[0x1])
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] IOAPIC[0]: apic_id 5, ve=
rsion 33, address 0xfec00000, GSI 0-23
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] IOAPIC[1]: apic_id 6, ve=
rsion 33, address 0xfec01000, GSI 24-55
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0=
 bus_irq 0 global_irq 2 dfl dfl)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0=
 bus_irq 9 global_irq 9 low level)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: IRQ0 used by overr=
ide.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: IRQ9 used by overr=
ide.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Using ACPI (MADT) for SM=
P configuration information
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: HPET id: 0x1022820=
1 base: 0xfed00000
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] smpboot: Allowing 16 CPU=
s, 12 hotplug CPUs
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x00000000-0x00000fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x000a0000-0x000fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x04000000-0x04009fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x09d80000-0x09ffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x0b000000-0x0b01ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9d1e5000-0x9d2d4fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9d3c7000-0x9d78ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9d790000-0x9e5bffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9e5c0000-0x9e664fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9f000000-0xdfffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xe0000000-0xf7ffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xf8000000-0xfbffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfc000000-0xfd7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfd800000-0xfdffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfe000000-0xfe9fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfea00000-0xfea0ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfea10000-0xfeb7ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfeb80000-0xfec01fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec02000-0xfec0ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec10000-0xfec10fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec11000-0xfec2ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec30000-0xfec30fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec31000-0xfecfffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed00000-0xfed00fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed01000-0xfed3ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed40000-0xfed44fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed45000-0xfed7ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed80000-0xfed8ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed90000-0xfedc1fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedc2000-0xfedcffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedd0000-0xfedd3fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedd4000-0xfedd5fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedd6000-0xfedfffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfee00000-0xfeefffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfef00000-0xfeffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xff000000-0xffffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] e820: [mem 0xe0000000-0x=
f7ffffff] available for PCI devices
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Booting paravirtualized =
kernel on bare hardware
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] clocksource: refined-jif=
fies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211=
568 ns
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] random: get_random_bytes=
 called from start_kernel+0x94/0x4d3 with crng_init=3D0
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] setup_percpu: NR_CPUS:51=
2 nr_cpumask_bits:512 nr_cpu_ids:16 nr_node_ids:1
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] percpu: Embedded 44 page=
s/cpu @        (ptrval) s142296 r8192 d29736 u262144
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] pcpu-alloc: s142296 r819=
2 d29736 u262144 alloc=3D1*2097152
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] pcpu-alloc: [0] 00 01 02=
 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15=20
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Built 1 zonelists, mobil=
ity grouping on.  Total pages: 3857750
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Policy zone: Normal
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Kernel command line: BOO=
T_IMAGE=3D/vmlinuz-4.16.0-2-amd64 root=3DUUID=3D313f78e2-468f-4660-b236-d=
1de214bf6b4 ro quiet
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Calgary: detecting Calga=
ry via BIOS EBDA area
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Calgary: Unable to locat=
e Rio Grande table in EBDA - bailing!
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Memory: 15228176K/156760=
60K available (10252K kernel code, 1182K rwdata, 3136K rodata, 1524K init=
, 688K bss, 447884K reserved, 0K cma-reserved)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] SLUB: HWalign=3D64, Orde=
r=3D0-3, MinObjects=3D0, CPUs=3D16, Nodes=3D1
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ftrace: allocating 29954=
 entries in 118 pages
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Hierarchical RCU impleme=
ntation.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] 	RCU restricting CPUs fr=
om NR_CPUS=3D512 to nr_cpu_ids=3D16.
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] RCU: Adjusting geometry =
for rcu_fanout_leaf=3D16, nr_cpu_ids=3D16
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] NR_IRQS: 33024, nr_irqs:=
 1096, preallocated irqs: 16
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] Console: colour dummy de=
vice 80x25
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] console [tty0] enabled
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI: Core revision 2018=
0105
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI BIOS Error (bug): F=
ailure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180105/dswload-380)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI Error: AE_ALREADY_E=
XISTS, During name lookup/catalog (20180105/psobject-252)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI Error: AE_ALREADY_E=
XISTS, (SSDT:  AMD PT) while loading table (20180105/tbxfload-228)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] ACPI Error: 1 table load=
 failures, 7 successful (20180105/tbxfload-246)
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] clocksource: hpet: mask:=
 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] hpet clockevent register=
ed
Jul 16 17:54:39 tokeiihto kernel: [    0.000000] APIC: Switch to symmetri=
c I/O mode setup
Jul 16 17:54:39 tokeiihto kernel: [    0.004000] Switched APIC routing to=
 physical flat.
Jul 16 17:54:39 tokeiihto kernel: [    0.004000] ..TIMER: vector=3D0x30 a=
pic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Jul 16 17:54:39 tokeiihto kernel: [    0.024000] tsc: Fast TSC calibratio=
n failed
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] tsc: PIT calibration mat=
ches HPET. 1 loops
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] tsc: Detected 3499.923 M=
Hz processor
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] clocksource: tsc-early: =
mask: 0xffffffffffffffff max_cycles: 0x32730827544, max_idle_ns: 44079530=
6377 ns
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] Calibrating delay loop (=
skipped), value calculated using timer frequency.. 6999.84 BogoMIPS (lpj=3D=
13999692)
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] pid_max: default: 32768 =
minimum: 301
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] Security Framework initi=
alized
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] Yama: disabled by defaul=
t; enable with sysctl kernel.yama.*
Jul 16 17:54:39 tokeiihto kernel: [    0.032000] AppArmor: AppArmor initi=
alized
Jul 16 17:54:39 tokeiihto kernel: [    0.038025] Dentry cache hash table =
entries: 2097152 (order: 12, 16777216 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.039249] Inode-cache hash table e=
ntries: 1048576 (order: 11, 8388608 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.039355] Mount-cache hash table e=
ntries: 32768 (order: 6, 262144 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.039392] Mountpoint-cache hash ta=
ble entries: 32768 (order: 6, 262144 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.039768] CPU: Physical Processor =
ID: 0
Jul 16 17:54:39 tokeiihto kernel: [    0.039769] CPU: Processor Core ID: =
0
Jul 16 17:54:39 tokeiihto kernel: [    0.039875] mce: CPU supports 23 MCE=
 banks
Jul 16 17:54:39 tokeiihto kernel: [    0.039891] LVT offset 1 assigned fo=
r vector 0xf9
Jul 16 17:54:39 tokeiihto kernel: [    0.039938] LVT offset 2 assigned fo=
r vector 0xf4
Jul 16 17:54:39 tokeiihto kernel: [    0.039948] Last level iTLB entries:=
 4KB 1024, 2MB 1024, 4MB 512
Jul 16 17:54:39 tokeiihto kernel: [    0.039948] Last level dTLB entries:=
 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
Jul 16 17:54:39 tokeiihto kernel: [    0.039949] Spectre V2 : Mitigation:=
 Full AMD retpoline
Jul 16 17:54:39 tokeiihto kernel: [    0.039950] Spectre V2 : Spectre v2 =
mitigation: Enabling Indirect Branch Prediction Barrier
Jul 16 17:54:39 tokeiihto kernel: [    0.039951] Speculative Store Bypass=
: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
Jul 16 17:54:39 tokeiihto kernel: [    0.044727] Freeing SMP alternatives=
 memory: 24K
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] smpboot: CPU0: AMD Ryzen=
 3 2200G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: =
0x0)
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] Performance Events: Fam1=
7h core perfctr, AMD PMU driver.
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... version:            =
    0
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... bit width:          =
    48
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... generic registers:  =
    6
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... value mask:         =
    0000ffffffffffff
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... max period:         =
    00007fffffffffff
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... fixed-purpose events=
:   0
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] ... event mask:         =
    000000000000003f
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] Hierarchical SRCU implem=
entation.
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] smp: Bringing up seconda=
ry CPUs ...
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] x86: Booting SMP configu=
ration:
Jul 16 17:54:39 tokeiihto kernel: [    0.056000] .... node  #0, CPUs:    =
    #1
Jul 16 17:54:39 tokeiihto kernel: [    0.056018] NMI watchdog: Enabled. P=
ermanently consumes one hw-PMU counter.
Jul 16 17:54:39 tokeiihto kernel: [    0.056147]   #2  #3
Jul 16 17:54:39 tokeiihto kernel: [    0.062403] smp: Brought up 1 node, =
4 CPUs
Jul 16 17:54:39 tokeiihto kernel: [    0.062403] smpboot: Max logical pac=
kages: 4
Jul 16 17:54:39 tokeiihto kernel: [    0.062403] smpboot: Total of 4 proc=
essors activated (27999.38 BogoMIPS)
Jul 16 17:54:39 tokeiihto kernel: [    0.062403] devtmpfs: initialized
Jul 16 17:54:39 tokeiihto kernel: [    0.062403] x86/mm: Memory block siz=
e: 128MB
Jul 16 17:54:39 tokeiihto kernel: [    0.065190] PM: Registering ACPI NVS=
 region [mem 0x04000000-0x04009fff] (40960 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.065190] PM: Registering ACPI NVS=
 region [mem 0x9d3c7000-0x9d78ffff] (3969024 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.065190] clocksource: jiffies: ma=
sk: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Jul 16 17:54:39 tokeiihto kernel: [    0.065190] futex hash table entries=
: 4096 (order: 6, 262144 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.065190] pinctrl core: initialize=
d pinctrl subsystem
Jul 16 17:54:39 tokeiihto kernel: [    0.065656] NET: Registered protocol=
 family 16
Jul 16 17:54:39 tokeiihto kernel: [    0.065729] audit: initializing netl=
ink subsys (disabled)
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] audit: type=3D2000 audit=
(1531756452.064:1): state=3Dinitialized audit_enabled=3D0 res=3D1
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] cpuidle: using governor =
ladder
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] cpuidle: using governor =
menu
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] ACPI: bus type PCI regis=
tered
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] acpiphp: ACPI Hot Plug P=
CI Controller Driver version: 0.5
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] PCI: MMCONFIG for domain=
 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] PCI: MMCONFIG at [mem 0x=
f8000000-0xfbffffff] reserved in E820
Jul 16 17:54:39 tokeiihto kernel: [    0.065732] PCI: Using configuration=
 type 1 for base access
Jul 16 17:54:39 tokeiihto kernel: [    0.068417] HugeTLB registered 1.00 =
GiB page size, pre-allocated 0 pages
Jul 16 17:54:39 tokeiihto kernel: [    0.068417] HugeTLB registered 2.00 =
MiB page size, pre-allocated 0 pages
Jul 16 17:54:39 tokeiihto kernel: [    0.068417] ACPI: Added _OSI(Module =
Device)
Jul 16 17:54:39 tokeiihto kernel: [    0.068417] ACPI: Added _OSI(Process=
or Device)
Jul 16 17:54:39 tokeiihto kernel: [    0.068417] ACPI: Added _OSI(3.0 _SC=
P Extensions)
Jul 16 17:54:39 tokeiihto kernel: [    0.068417] ACPI: Added _OSI(Process=
or Aggregator Device)
Jul 16 17:54:39 tokeiihto kernel: [    0.068498] ACPI BIOS Error (bug): F=
ailure looking up [\PTOS], AE_NOT_FOUND (20180105/psargs-364)
Jul 16 17:54:39 tokeiihto kernel: [    0.068507] ACPI Error: Method parse=
/execution failed \, AE_NOT_FOUND (20180105/psparse-550)
Jul 16 17:54:39 tokeiihto kernel: [    0.068513] ACPI: Executed 2 blocks =
of module-level executable AML code
Jul 16 17:54:39 tokeiihto kernel: [    0.071940] ACPI: [Firmware Bug]: BI=
OS _OSI(Linux) query ignored
Jul 16 17:54:39 tokeiihto kernel: [    0.073341] ACPI: Interpreter enable=
d
Jul 16 17:54:39 tokeiihto kernel: [    0.073351] ACPI: (supports S0 S3 S4=
 S5)
Jul 16 17:54:39 tokeiihto kernel: [    0.073352] ACPI: Using IOAPIC for i=
nterrupt routing
Jul 16 17:54:39 tokeiihto kernel: [    0.073573] PCI: Using host bridge w=
indows from ACPI; if necessary, use "pci=3Dnocrs" and report a bug
Jul 16 17:54:39 tokeiihto kernel: [    0.073802] ACPI: Enabled 2 GPEs in =
block 00 to 1F
Jul 16 17:54:39 tokeiihto kernel: [    0.075599] ACPI: Power Resource [P0=
ST] (on)
Jul 16 17:54:39 tokeiihto kernel: [    0.075617] ACPI: Power Resource [P3=
ST] (on)
Jul 16 17:54:39 tokeiihto kernel: [    0.079836] ACPI: PCI Root Bridge [P=
CI0] (domain 0000 [bus 00-ff])
Jul 16 17:54:39 tokeiihto kernel: [    0.079839] acpi PNP0A08:00: _OSC: O=
S supports [ExtendedConfig ASPM ClockPM Segments MSI]
Jul 16 17:54:39 tokeiihto kernel: [    0.079979] acpi PNP0A08:00: _OSC: O=
S now controls [PCIeHotplug PME AER PCIeCapability]
Jul 16 17:54:39 tokeiihto kernel: [    0.079986] acpi PNP0A08:00: [Firmwa=
re Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this=
 bridge
Jul 16 17:54:39 tokeiihto kernel: [    0.080223] PCI host bridge to bus 0=
000:00
Jul 16 17:54:39 tokeiihto kernel: [    0.080224] pci_bus 0000:00: root bu=
s resource [io  0x0000-0x03af window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080225] pci_bus 0000:00: root bu=
s resource [io  0x03e0-0x0cf7 window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080226] pci_bus 0000:00: root bu=
s resource [io  0x03b0-0x03df window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080227] pci_bus 0000:00: root bu=
s resource [io  0x0d00-0xffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080228] pci_bus 0000:00: root bu=
s resource [mem 0x000a0000-0x000bffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080229] pci_bus 0000:00: root bu=
s resource [mem 0x000c0000-0x000dffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080230] pci_bus 0000:00: root bu=
s resource [mem 0xe0000000-0xfec2ffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080231] pci_bus 0000:00: root bu=
s resource [mem 0xfee00000-0xffffffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.080232] pci_bus 0000:00: root bu=
s resource [bus 00-ff]
Jul 16 17:54:39 tokeiihto kernel: [    0.080241] pci 0000:00:00.0: [1022:=
15d0] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.080359] pci 0000:00:00.2: [1022:=
15d1] type 00 class 0x080600
Jul 16 17:54:39 tokeiihto kernel: [    0.080500] pci 0000:00:01.0: [1022:=
1452] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.080601] pci 0000:00:01.2: [1022:=
15d3] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.080705] pci 0000:00:01.2: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.080812] pci 0000:00:08.0: [1022:=
1452] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.080913] pci 0000:00:08.1: [1022:=
15db] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.080965] pci 0000:00:08.1: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.081021] pci 0000:00:08.1: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.081100] pci 0000:00:08.2: [1022:=
15dc] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.081151] pci 0000:00:08.2: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.081201] pci 0000:00:08.2: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.081310] pci 0000:00:14.0: [1022:=
790b] type 00 class 0x0c0500
Jul 16 17:54:39 tokeiihto kernel: [    0.081523] pci 0000:00:14.3: [1022:=
790e] type 00 class 0x060100
Jul 16 17:54:39 tokeiihto kernel: [    0.081699] pci 0000:00:18.0: [1022:=
15e8] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.081741] pci 0000:00:18.1: [1022:=
15e9] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.081789] pci 0000:00:18.2: [1022:=
15ea] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.081831] pci 0000:00:18.3: [1022:=
15eb] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.081872] pci 0000:00:18.4: [1022:=
15ec] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.081913] pci 0000:00:18.5: [1022:=
15ed] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.081962] pci 0000:00:18.6: [1022:=
15ee] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.082010] pci 0000:00:18.7: [1022:=
15ef] type 00 class 0x060000
Jul 16 17:54:39 tokeiihto kernel: [    0.082128] pci 0000:15:00.0: [1022:=
43bb] type 00 class 0x0c0330
Jul 16 17:54:39 tokeiihto kernel: [    0.082158] pci 0000:15:00.0: reg 0x=
10: [mem 0xfe8a0000-0xfe8a7fff 64bit]
Jul 16 17:54:39 tokeiihto kernel: [    0.082261] pci 0000:15:00.0: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.082355] pci 0000:15:00.1: [1022:=
43b7] type 00 class 0x010601
Jul 16 17:54:39 tokeiihto kernel: [    0.082418] pci 0000:15:00.1: reg 0x=
24: [mem 0xfe880000-0xfe89ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.082427] pci 0000:15:00.1: reg 0x=
30: [mem 0xfe800000-0xfe87ffff pref]
Jul 16 17:54:39 tokeiihto kernel: [    0.082479] pci 0000:15:00.1: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.082544] pci 0000:15:00.2: [1022:=
43b2] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.082643] pci 0000:15:00.2: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.096028] pci 0000:00:01.2: PCI br=
idge to [bus 15-1b]
Jul 16 17:54:39 tokeiihto kernel: [    0.096033] pci 0000:00:01.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.096037] pci 0000:00:01.2:   brid=
ge window [mem 0xfe700000-0xfe8fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.096135] pci 0000:16:00.0: [1022:=
43b4] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.096254] pci 0000:16:00.0: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.096343] pci 0000:16:01.0: [1022:=
43b4] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.096462] pci 0000:16:01.0: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.096560] pci 0000:16:04.0: [1022:=
43b4] type 01 class 0x060400
Jul 16 17:54:39 tokeiihto kernel: [    0.096678] pci 0000:16:04.0: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.096787] pci 0000:15:00.2: PCI br=
idge to [bus 16-1b]
Jul 16 17:54:39 tokeiihto kernel: [    0.096793] pci 0000:15:00.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.096797] pci 0000:15:00.2:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.096850] pci 0000:16:00.0: PCI br=
idge to [bus 17]
Jul 16 17:54:39 tokeiihto kernel: [    0.096934] pci 0000:18:00.0: [10ec:=
8168] type 00 class 0x020000
Jul 16 17:54:39 tokeiihto kernel: [    0.096983] pci 0000:18:00.0: reg 0x=
10: [io  0xf000-0xf0ff]
Jul 16 17:54:39 tokeiihto kernel: [    0.097025] pci 0000:18:00.0: reg 0x=
18: [mem 0xfe704000-0xfe704fff 64bit]
Jul 16 17:54:39 tokeiihto kernel: [    0.097052] pci 0000:18:00.0: reg 0x=
20: [mem 0xfe700000-0xfe703fff 64bit]
Jul 16 17:54:39 tokeiihto kernel: [    0.097202] pci 0000:18:00.0: suppor=
ts D1 D2
Jul 16 17:54:39 tokeiihto kernel: [    0.097203] pci 0000:18:00.0: PME# s=
upported from D0 D1 D2 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.108046] pci 0000:16:01.0: PCI br=
idge to [bus 18]
Jul 16 17:54:39 tokeiihto kernel: [    0.108054] pci 0000:16:01.0:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.108058] pci 0000:16:01.0:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.108126] pci 0000:16:04.0: PCI br=
idge to [bus 1b]
Jul 16 17:54:39 tokeiihto kernel: [    0.108288] pci 0000:38:00.0: [1002:=
15dd] type 00 class 0x030000
Jul 16 17:54:39 tokeiihto kernel: [    0.108340] pci 0000:38:00.0: reg 0x=
10: [mem 0xe0000000-0xefffffff 64bit pref]
Jul 16 17:54:39 tokeiihto kernel: [    0.108361] pci 0000:38:00.0: reg 0x=
18: [mem 0xf0000000-0xf01fffff 64bit pref]
Jul 16 17:54:39 tokeiihto kernel: [    0.108375] pci 0000:38:00.0: reg 0x=
20: [io  0xe000-0xe0ff]
Jul 16 17:54:39 tokeiihto kernel: [    0.108389] pci 0000:38:00.0: reg 0x=
24: [mem 0xfe600000-0xfe67ffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.108412] pci 0000:38:00.0: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.108429] pci 0000:38:00.0: BAR 0:=
 assigned to efifb
Jul 16 17:54:39 tokeiihto kernel: [    0.108536] pci 0000:38:00.0: PME# s=
upported from D1 D2 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.108668] pci 0000:38:00.1: [1002:=
15de] type 00 class 0x040300
Jul 16 17:54:39 tokeiihto kernel: [    0.108702] pci 0000:38:00.1: reg 0x=
10: [mem 0xfe688000-0xfe68bfff]
Jul 16 17:54:39 tokeiihto kernel: [    0.108785] pci 0000:38:00.1: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.108865] pci 0000:38:00.1: PME# s=
upported from D1 D2 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.108952] pci 0000:38:00.2: [1022:=
15df] type 00 class 0x108000
Jul 16 17:54:39 tokeiihto kernel: [    0.109009] pci 0000:38:00.2: reg 0x=
18: [mem 0xfe500000-0xfe5fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.109047] pci 0000:38:00.2: reg 0x=
24: [mem 0xfe68c000-0xfe68dfff]
Jul 16 17:54:39 tokeiihto kernel: [    0.109070] pci 0000:38:00.2: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.109232] pci 0000:38:00.3: [1022:=
15e0] type 00 class 0x0c0330
Jul 16 17:54:39 tokeiihto kernel: [    0.109272] pci 0000:38:00.3: reg 0x=
10: [mem 0xfe400000-0xfe4fffff 64bit]
Jul 16 17:54:39 tokeiihto kernel: [    0.109343] pci 0000:38:00.3: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.109431] pci 0000:38:00.3: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.109521] pci 0000:38:00.4: [1022:=
15e1] type 00 class 0x0c0330
Jul 16 17:54:39 tokeiihto kernel: [    0.109561] pci 0000:38:00.4: reg 0x=
10: [mem 0xfe300000-0xfe3fffff 64bit]
Jul 16 17:54:39 tokeiihto kernel: [    0.109632] pci 0000:38:00.4: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.109720] pci 0000:38:00.4: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.109811] pci 0000:38:00.6: [1022:=
15e3] type 00 class 0x040300
Jul 16 17:54:39 tokeiihto kernel: [    0.109844] pci 0000:38:00.6: reg 0x=
10: [mem 0xfe680000-0xfe687fff]
Jul 16 17:54:39 tokeiihto kernel: [    0.109927] pci 0000:38:00.6: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.110007] pci 0000:38:00.6: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.110182] pci 0000:00:08.1: PCI br=
idge to [bus 38]
Jul 16 17:54:39 tokeiihto kernel: [    0.110188] pci 0000:00:08.1:   brid=
ge window [io  0xe000-0xefff]
Jul 16 17:54:39 tokeiihto kernel: [    0.110192] pci 0000:00:08.1:   brid=
ge window [mem 0xfe300000-0xfe6fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.110198] pci 0000:00:08.1:   brid=
ge window [mem 0xe0000000-0xf01fffff 64bit pref]
Jul 16 17:54:39 tokeiihto kernel: [    0.110295] pci 0000:39:00.0: [1022:=
7901] type 00 class 0x010601
Jul 16 17:54:39 tokeiihto kernel: [    0.110391] pci 0000:39:00.0: reg 0x=
24: [mem 0xfe900000-0xfe9007ff]
Jul 16 17:54:39 tokeiihto kernel: [    0.110414] pci 0000:39:00.0: enabli=
ng Extended Tags
Jul 16 17:54:39 tokeiihto kernel: [    0.110499] pci 0000:39:00.0: PME# s=
upported from D3hot D3cold
Jul 16 17:54:39 tokeiihto kernel: [    0.110625] pci 0000:00:08.2: PCI br=
idge to [bus 39]
Jul 16 17:54:39 tokeiihto kernel: [    0.110634] pci 0000:00:08.2:   brid=
ge window [mem 0xfe900000-0xfe9fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.111129] ACPI: PCI Interrupt Link=
 [LNKA] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111178] ACPI: PCI Interrupt Link=
 [LNKB] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111218] ACPI: PCI Interrupt Link=
 [LNKC] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111272] ACPI: PCI Interrupt Link=
 [LNKD] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111319] ACPI: PCI Interrupt Link=
 [LNKE] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111357] ACPI: PCI Interrupt Link=
 [LNKF] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111395] ACPI: PCI Interrupt Link=
 [LNKG] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.111433] ACPI: PCI Interrupt Link=
 [LNKH] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:54:39 tokeiihto kernel: [    0.112019] pci 0000:38:00.0: vgaarb=
: setting as boot VGA device
Jul 16 17:54:39 tokeiihto kernel: [    0.112021] pci 0000:38:00.0: vgaarb=
: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Jul 16 17:54:39 tokeiihto kernel: [    0.112023] pci 0000:38:00.0: vgaarb=
: bridge control possible
Jul 16 17:54:39 tokeiihto kernel: [    0.112023] vgaarb: loaded
Jul 16 17:54:39 tokeiihto kernel: [    0.112023] pps_core: LinuxPPS API v=
er. 1 registered
Jul 16 17:54:39 tokeiihto kernel: [    0.112023] pps_core: Software ver. =
5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Jul 16 17:54:39 tokeiihto kernel: [    0.112023] PTP clock support regist=
ered
Jul 16 17:54:39 tokeiihto kernel: [    0.112023] EDAC MC: Ver: 3.0.0
Jul 16 17:54:39 tokeiihto kernel: [    0.112127] Registered efivars opera=
tions
Jul 16 17:54:39 tokeiihto kernel: [    0.134841] PCI: Using ACPI for IRQ =
routing
Jul 16 17:54:39 tokeiihto kernel: [    0.136518] PCI: pci_cache_line_size=
 set to 64 bytes
Jul 16 17:54:39 tokeiihto kernel: [    0.136596] e820: reserve RAM buffer=
 [mem 0x09d80000-0x0bffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.136597] e820: reserve RAM buffer=
 [mem 0x0b000000-0x0bffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.136597] e820: reserve RAM buffer=
 [mem 0x9d1e5000-0x9fffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.136598] e820: reserve RAM buffer=
 [mem 0x9d3c7000-0x9fffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.136598] e820: reserve RAM buffer=
 [mem 0x9f000000-0x9fffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.136599] e820: reserve RAM buffer=
 [mem 0x41f340000-0x41fffffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.136711] hpet0: at MMIO 0xfed0000=
0, IRQs 2, 8, 0
Jul 16 17:54:39 tokeiihto kernel: [    0.136711] hpet0: 3 comparators, 32=
-bit 14.318180 MHz counter
Jul 16 17:54:39 tokeiihto kernel: [    0.140018] clocksource: Switched to=
 clocksource tsc-early
Jul 16 17:54:39 tokeiihto kernel: [    0.149534] VFS: Disk quotas dquot_6=
=2E6.0
Jul 16 17:54:39 tokeiihto kernel: [    0.149574] VFS: Dquot-cache hash ta=
ble entries: 512 (order 0, 4096 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.149722] AppArmor: AppArmor Files=
ystem Enabled
Jul 16 17:54:39 tokeiihto kernel: [    0.149734] pnp: PnP ACPI init
Jul 16 17:54:39 tokeiihto kernel: [    0.149876] system 00:00: [mem 0xf80=
00000-0xfbffffff] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.149880] system 00:00: Plug and P=
lay ACPI device, IDs PNP0c01 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.149937] system 00:01: [mem 0xfeb=
80000-0xfebfffff] could not be reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.149940] system 00:01: Plug and P=
lay ACPI device, IDs PNP0c02 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.150021] pnp 00:02: Plug and Play=
 ACPI device, IDs PNP0b00 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.150150] system 00:03: [io  0x0a0=
0-0x0a0f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150151] system 00:03: [io  0x0a1=
0-0x0a1f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150152] system 00:03: [io  0x0a2=
0-0x0a2f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150153] system 00:03: [io  0x0a4=
0-0x0a4f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150155] system 00:03: Plug and P=
lay ACPI device, IDs PNP0c02 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.150392] pnp 00:04: [dma 0 disabl=
ed]
Jul 16 17:54:39 tokeiihto kernel: [    0.150466] pnp 00:04: Plug and Play=
 ACPI device, IDs PNP0400 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.150660] pnp 00:05: [dma 0 disabl=
ed]
Jul 16 17:54:39 tokeiihto kernel: [    0.150694] pnp 00:05: Plug and Play=
 ACPI device, IDs PNP0501 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.150843] system 00:06: [io  0x04d=
0-0x04d1] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150844] system 00:06: [io  0x040=
b] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150845] system 00:06: [io  0x04d=
6] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150846] system 00:06: [io  0x0c0=
0-0x0c01] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150847] system 00:06: [io  0x0c1=
4] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150848] system 00:06: [io  0x0c5=
0-0x0c51] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150849] system 00:06: [io  0x0c5=
2] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150850] system 00:06: [io  0x0c6=
c] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150850] system 00:06: [io  0x0c6=
f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150851] system 00:06: [io  0x0cd=
0-0x0cd1] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150852] system 00:06: [io  0x0cd=
2-0x0cd3] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150853] system 00:06: [io  0x0cd=
4-0x0cd5] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150854] system 00:06: [io  0x0cd=
6-0x0cd7] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150855] system 00:06: [io  0x0cd=
8-0x0cdf] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150856] system 00:06: [io  0x080=
0-0x089f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150857] system 00:06: [io  0x0b0=
0-0x0b0f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150858] system 00:06: [io  0x0b2=
0-0x0b3f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150859] system 00:06: [io  0x090=
0-0x090f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150859] system 00:06: [io  0x091=
0-0x091f] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150861] system 00:06: [mem 0xfec=
00000-0xfec00fff] could not be reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150862] system 00:06: [mem 0xfec=
01000-0xfec01fff] could not be reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150863] system 00:06: [mem 0xfed=
c0000-0xfedc0fff] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150864] system 00:06: [mem 0xfee=
00000-0xfee00fff] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150865] system 00:06: [mem 0xfed=
80000-0xfed8ffff] could not be reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150866] system 00:06: [mem 0xfec=
10000-0xfec10fff] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150867] system 00:06: [mem 0xff0=
00000-0xffffffff] has been reserved
Jul 16 17:54:39 tokeiihto kernel: [    0.150870] system 00:06: Plug and P=
lay ACPI device, IDs PNP0c02 (active)
Jul 16 17:54:39 tokeiihto kernel: [    0.151154] pnp: PnP ACPI: found 7 d=
evices
Jul 16 17:54:39 tokeiihto kernel: [    0.157004] clocksource: acpi_pm: ma=
sk: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Jul 16 17:54:39 tokeiihto kernel: [    0.157069] pci 0000:16:00.0: PCI br=
idge to [bus 17]
Jul 16 17:54:39 tokeiihto kernel: [    0.157083] pci 0000:16:01.0: PCI br=
idge to [bus 18]
Jul 16 17:54:39 tokeiihto kernel: [    0.157086] pci 0000:16:01.0:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157090] pci 0000:16:01.0:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157099] pci 0000:16:04.0: PCI br=
idge to [bus 1b]
Jul 16 17:54:39 tokeiihto kernel: [    0.157111] pci 0000:15:00.2: PCI br=
idge to [bus 16-1b]
Jul 16 17:54:39 tokeiihto kernel: [    0.157113] pci 0000:15:00.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157118] pci 0000:15:00.2:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157126] pci 0000:00:01.2: PCI br=
idge to [bus 15-1b]
Jul 16 17:54:39 tokeiihto kernel: [    0.157127] pci 0000:00:01.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157132] pci 0000:00:01.2:   brid=
ge window [mem 0xfe700000-0xfe8fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157141] pci 0000:00:08.1: PCI br=
idge to [bus 38]
Jul 16 17:54:39 tokeiihto kernel: [    0.157143] pci 0000:00:08.1:   brid=
ge window [io  0xe000-0xefff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157147] pci 0000:00:08.1:   brid=
ge window [mem 0xfe300000-0xfe6fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157150] pci 0000:00:08.1:   brid=
ge window [mem 0xe0000000-0xf01fffff 64bit pref]
Jul 16 17:54:39 tokeiihto kernel: [    0.157156] pci 0000:00:08.2: PCI br=
idge to [bus 39]
Jul 16 17:54:39 tokeiihto kernel: [    0.157161] pci 0000:00:08.2:   brid=
ge window [mem 0xfe900000-0xfe9fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157170] pci_bus 0000:00: resourc=
e 4 [io  0x0000-0x03af window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157171] pci_bus 0000:00: resourc=
e 5 [io  0x03e0-0x0cf7 window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157172] pci_bus 0000:00: resourc=
e 6 [io  0x03b0-0x03df window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157173] pci_bus 0000:00: resourc=
e 7 [io  0x0d00-0xffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157173] pci_bus 0000:00: resourc=
e 8 [mem 0x000a0000-0x000bffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157174] pci_bus 0000:00: resourc=
e 9 [mem 0x000c0000-0x000dffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157175] pci_bus 0000:00: resourc=
e 10 [mem 0xe0000000-0xfec2ffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157176] pci_bus 0000:00: resourc=
e 11 [mem 0xfee00000-0xffffffff window]
Jul 16 17:54:39 tokeiihto kernel: [    0.157177] pci_bus 0000:15: resourc=
e 0 [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157178] pci_bus 0000:15: resourc=
e 1 [mem 0xfe700000-0xfe8fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157179] pci_bus 0000:16: resourc=
e 0 [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157180] pci_bus 0000:16: resourc=
e 1 [mem 0xfe700000-0xfe7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157181] pci_bus 0000:18: resourc=
e 0 [io  0xf000-0xffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157182] pci_bus 0000:18: resourc=
e 1 [mem 0xfe700000-0xfe7fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157183] pci_bus 0000:38: resourc=
e 0 [io  0xe000-0xefff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157184] pci_bus 0000:38: resourc=
e 1 [mem 0xfe300000-0xfe6fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157184] pci_bus 0000:38: resourc=
e 2 [mem 0xe0000000-0xf01fffff 64bit pref]
Jul 16 17:54:39 tokeiihto kernel: [    0.157185] pci_bus 0000:39: resourc=
e 1 [mem 0xfe900000-0xfe9fffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.157367] NET: Registered protocol=
 family 2
Jul 16 17:54:39 tokeiihto kernel: [    0.157600] tcp_listen_portaddr_hash=
 hash table entries: 8192 (order: 5, 131072 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.157641] TCP established hash tab=
le entries: 131072 (order: 8, 1048576 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.157812] TCP bind hash table entr=
ies: 65536 (order: 8, 1048576 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.157938] TCP: Hash tables configu=
red (established 131072 bind 65536)
Jul 16 17:54:39 tokeiihto kernel: [    0.157979] UDP hash table entries: =
8192 (order: 6, 262144 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.158015] UDP-Lite hash table entr=
ies: 8192 (order: 6, 262144 bytes)
Jul 16 17:54:39 tokeiihto kernel: [    0.158115] NET: Registered protocol=
 family 1
Jul 16 17:54:39 tokeiihto kernel: [    0.158279] pci 0000:38:00.0: Video =
device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Jul 16 17:54:39 tokeiihto kernel: [    0.158481] PCI: CLS 64 bytes, defau=
lt 64
Jul 16 17:54:39 tokeiihto kernel: [    0.158508] Unpacking initramfs...
Jul 16 17:54:39 tokeiihto kernel: [    0.464750] Freeing initrd memory: 2=
5356K
Jul 16 17:54:39 tokeiihto kernel: [    0.464857] AMD-Vi: Unable to write =
to IOMMU perf counter.
Jul 16 17:54:39 tokeiihto kernel: [    0.464953] pci 0000:00:00.2: can't =
derive routing for PCI INT A
Jul 16 17:54:39 tokeiihto kernel: [    0.464954] pci 0000:00:00.2: PCI IN=
T A: not connected
Jul 16 17:54:39 tokeiihto kernel: [    0.465381] iommu: Adding device 000=
0:00:01.0 to group 0
Jul 16 17:54:39 tokeiihto kernel: [    0.465582] iommu: Adding device 000=
0:00:01.2 to group 1
Jul 16 17:54:39 tokeiihto kernel: [    0.465780] iommu: Adding device 000=
0:00:08.0 to group 2
Jul 16 17:54:39 tokeiihto kernel: [    0.465992] iommu: Adding device 000=
0:00:08.1 to group 3
Jul 16 17:54:39 tokeiihto kernel: [    0.466011] iommu: Adding device 000=
0:00:08.2 to group 2
Jul 16 17:54:39 tokeiihto kernel: [    0.466197] iommu: Adding device 000=
0:00:14.0 to group 4
Jul 16 17:54:39 tokeiihto kernel: [    0.466211] iommu: Adding device 000=
0:00:14.3 to group 4
Jul 16 17:54:39 tokeiihto kernel: [    0.466415] iommu: Adding device 000=
0:00:18.0 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466430] iommu: Adding device 000=
0:00:18.1 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466451] iommu: Adding device 000=
0:00:18.2 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466465] iommu: Adding device 000=
0:00:18.3 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466479] iommu: Adding device 000=
0:00:18.4 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466494] iommu: Adding device 000=
0:00:18.5 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466506] iommu: Adding device 000=
0:00:18.6 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466519] iommu: Adding device 000=
0:00:18.7 to group 5
Jul 16 17:54:39 tokeiihto kernel: [    0.466719] iommu: Adding device 000=
0:15:00.0 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.466756] iommu: Adding device 000=
0:15:00.1 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.466795] iommu: Adding device 000=
0:15:00.2 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.466811] iommu: Adding device 000=
0:16:00.0 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.466826] iommu: Adding device 000=
0:16:01.0 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.466842] iommu: Adding device 000=
0:16:04.0 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.466867] iommu: Adding device 000=
0:18:00.0 to group 6
Jul 16 17:54:39 tokeiihto kernel: [    0.467141] iommu: Adding device 000=
0:38:00.0 to group 7
Jul 16 17:54:39 tokeiihto kernel: [    0.467219] iommu: Using direct mapp=
ing for device 0000:38:00.0
Jul 16 17:54:39 tokeiihto kernel: [    0.467310] iommu: Adding device 000=
0:38:00.1 to group 8
Jul 16 17:54:39 tokeiihto kernel: [    0.467344] iommu: Adding device 000=
0:38:00.2 to group 8
Jul 16 17:54:39 tokeiihto kernel: [    0.467377] iommu: Adding device 000=
0:38:00.3 to group 8
Jul 16 17:54:39 tokeiihto kernel: [    0.467410] iommu: Adding device 000=
0:38:00.4 to group 8
Jul 16 17:54:39 tokeiihto kernel: [    0.467443] iommu: Adding device 000=
0:38:00.6 to group 8
Jul 16 17:54:39 tokeiihto kernel: [    0.467459] iommu: Adding device 000=
0:39:00.0 to group 2
Jul 16 17:54:39 tokeiihto kernel: [    0.467713] AMD-Vi: Found IOMMU at 0=
000:00:00.2 cap 0x40
Jul 16 17:54:39 tokeiihto kernel: [    0.467713] AMD-Vi: Extended feature=
s (0x4f77ef22294ada):
Jul 16 17:54:39 tokeiihto kernel: [    0.467714]  PPR NX GT IA GA PC GA_v=
APIC
Jul 16 17:54:39 tokeiihto kernel: [    0.467716] AMD-Vi: Interrupt remapp=
ing enabled
Jul 16 17:54:39 tokeiihto kernel: [    0.467716] AMD-Vi: virtual APIC ena=
bled
Jul 16 17:54:39 tokeiihto kernel: [    0.513300] AMD-Vi: Lazy IO/TLB flus=
hing enabled
Jul 16 17:54:39 tokeiihto kernel: [    0.514126] amd_uncore: AMD NB count=
ers detected
Jul 16 17:54:39 tokeiihto kernel: [    0.514130] amd_uncore: AMD LLC coun=
ters detected
Jul 16 17:54:39 tokeiihto kernel: [    0.515039] Initialise system truste=
d keyrings
Jul 16 17:54:39 tokeiihto kernel: [    0.515354] workingset: timestamp_bi=
ts=3D40 max_order=3D22 bucket_order=3D0
Jul 16 17:54:39 tokeiihto kernel: [    0.517070] zbud: loaded
Jul 16 17:54:39 tokeiihto kernel: [    0.698421] Key type asymmetric regi=
stered
Jul 16 17:54:39 tokeiihto kernel: [    0.698422] Asymmetric key parser 'x=
509' registered
Jul 16 17:54:39 tokeiihto kernel: [    0.698483] Block layer SCSI generic=
 (bsg) driver version 0.4 loaded (major 248)
Jul 16 17:54:39 tokeiihto kernel: [    0.698550] io scheduler noop regist=
ered
Jul 16 17:54:39 tokeiihto kernel: [    0.698551] io scheduler deadline re=
gistered
Jul 16 17:54:39 tokeiihto kernel: [    0.698652] io scheduler cfq registe=
red (default)
Jul 16 17:54:39 tokeiihto kernel: [    0.698653] io scheduler mq-deadline=
 registered
Jul 16 17:54:39 tokeiihto kernel: [    0.699951] pcieport 0000:00:01.2: A=
ER enabled with IRQ 26
Jul 16 17:54:39 tokeiihto kernel: [    0.699965] pcieport 0000:00:01.2: S=
ignaling PME with IRQ 26
Jul 16 17:54:39 tokeiihto kernel: [    0.699989] pcieport 0000:00:08.1: S=
ignaling PME with IRQ 27
Jul 16 17:54:39 tokeiihto kernel: [    0.700012] pcieport 0000:00:08.2: S=
ignaling PME with IRQ 28
Jul 16 17:54:39 tokeiihto kernel: [    0.700042] efifb: probing for efifb=

Jul 16 17:54:39 tokeiihto kernel: [    0.700052] efifb: framebuffer at 0x=
e0000000, using 3072k, total 3072k
Jul 16 17:54:39 tokeiihto kernel: [    0.700053] efifb: mode is 1024x768x=
32, linelength=3D4096, pages=3D1
Jul 16 17:54:39 tokeiihto kernel: [    0.700053] efifb: scrolling: redraw=

Jul 16 17:54:39 tokeiihto kernel: [    0.700055] efifb: Truecolor: size=3D=
8:8:8:8, shift=3D24:16:8:0
Jul 16 17:54:39 tokeiihto kernel: [    0.701670] Console: switching to co=
lour frame buffer device 128x48
Jul 16 17:54:39 tokeiihto kernel: [    0.703195] fb0: EFI VGA frame buffe=
r device
Jul 16 17:54:39 tokeiihto kernel: [    0.703459] Monitor-Mwait will be us=
ed to enter C-1 state
Jul 16 17:54:39 tokeiihto kernel: [    0.703986] Serial: 8250/16550 drive=
r, 4 ports, IRQ sharing enabled
Jul 16 17:54:39 tokeiihto kernel: [    0.724894] 00:05: ttyS0 at I/O 0x3f=
8 (irq =3D 4, base_baud =3D 115200) is a 16550A
Jul 16 17:54:39 tokeiihto kernel: [    0.725213] Linux agpgart interface =
v0.103
Jul 16 17:54:39 tokeiihto kernel: [    0.725466] AMD IOMMUv2 driver by Jo=
erg Roedel <jroedel@suse.de>
Jul 16 17:54:39 tokeiihto kernel: [    0.725950] i8042: PNP: No PS/2 cont=
roller found.
Jul 16 17:54:39 tokeiihto kernel: [    0.726002] mousedev: PS/2 mouse dev=
ice common for all mice
Jul 16 17:54:39 tokeiihto kernel: [    0.726056] rtc_cmos 00:02: RTC can =
wake from S4
Jul 16 17:54:39 tokeiihto kernel: [    0.726249] rtc_cmos 00:02: rtc core=
: registered rtc_cmos as rtc0
Jul 16 17:54:39 tokeiihto kernel: [    0.726309] rtc_cmos 00:02: alarms u=
p to one month, y3k, 114 bytes nvram, hpet irqs
Jul 16 17:54:39 tokeiihto kernel: [    0.726727] ledtrig-cpu: registered =
to indicate activity on CPUs
Jul 16 17:54:39 tokeiihto kernel: [    0.727312] NET: Registered protocol=
 family 10
Jul 16 17:54:39 tokeiihto kernel: [    0.730569] Segment Routing with IPv=
6
Jul 16 17:54:39 tokeiihto kernel: [    0.730594] mip6: Mobile IPv6
Jul 16 17:54:39 tokeiihto kernel: [    0.730596] NET: Registered protocol=
 family 17
Jul 16 17:54:39 tokeiihto kernel: [    0.730599] mpls_gso: MPLS GSO suppo=
rt
Jul 16 17:54:39 tokeiihto kernel: [    0.730993] microcode: CPU0: patch_l=
evel=3D0x0810100b
Jul 16 17:54:39 tokeiihto kernel: [    0.730997] microcode: CPU1: patch_l=
evel=3D0x0810100b
Jul 16 17:54:39 tokeiihto kernel: [    0.731001] microcode: CPU2: patch_l=
evel=3D0x0810100b
Jul 16 17:54:39 tokeiihto kernel: [    0.731005] microcode: CPU3: patch_l=
evel=3D0x0810100b
Jul 16 17:54:39 tokeiihto kernel: [    0.731036] microcode: Microcode Upd=
ate Driver: v2.2.
Jul 16 17:54:39 tokeiihto kernel: [    0.731056] sched_clock: Marking sta=
ble (731032254, 0)->(817038994, -86006740)
Jul 16 17:54:39 tokeiihto kernel: [    0.731210] registered taskstats ver=
sion 1
Jul 16 17:54:39 tokeiihto kernel: [    0.731210] Loading compiled-in X.50=
9 certificates
Jul 16 17:54:39 tokeiihto kernel: [    0.754307] Loaded X.509 cert 'secur=
e-boot-test-key-lfaraone: 97c1b25cddf9873ca78a58f3d73bf727d2cf78ff'
Jul 16 17:54:39 tokeiihto kernel: [    0.754540] Loaded X.509 cert 'Debia=
n Project: Ben Hutchings: 008a018dca80932630'
Jul 16 17:54:39 tokeiihto kernel: [    0.754558] zswap: loaded using pool=
 lzo/zbud
Jul 16 17:54:39 tokeiihto kernel: [    0.754754] AppArmor: AppArmor sha1 =
policy hashing enabled
Jul 16 17:54:39 tokeiihto kernel: [    0.755490] rtc_cmos 00:02: setting =
system clock to 2018-07-16 15:54:14 UTC (1531756454)
Jul 16 17:54:39 tokeiihto kernel: [    1.029792] Freeing unused kernel me=
mory: 1524K
Jul 16 17:54:39 tokeiihto kernel: [    1.029794] Write protecting the ker=
nel read-only data: 16384k
Jul 16 17:54:39 tokeiihto kernel: [    1.031977] Freeing unused kernel me=
mory: 2024K
Jul 16 17:54:39 tokeiihto kernel: [    1.033917] Freeing unused kernel me=
mory: 960K
Jul 16 17:54:39 tokeiihto kernel: [    1.038356] x86/mm: Checked W+X mapp=
ings: passed, no W+X pages found.
Jul 16 17:54:39 tokeiihto kernel: [    1.090067] r8169 Gigabit Ethernet d=
river 2.3LK-NAPI loaded
Jul 16 17:54:39 tokeiihto kernel: [    1.091632] ACPI: bus type USB regis=
tered
Jul 16 17:54:39 tokeiihto kernel: [    1.091646] usbcore: registered new =
interface driver usbfs
Jul 16 17:54:39 tokeiihto kernel: [    1.091650] usbcore: registered new =
interface driver hub
Jul 16 17:54:39 tokeiihto kernel: [    1.091963] usbcore: registered new =
device driver usb
Jul 16 17:54:39 tokeiihto kernel: [    1.092632] SCSI subsystem initializ=
ed
Jul 16 17:54:39 tokeiihto kernel: [    1.095060] cryptd: max_cpu_qlen set=
 to 1000
Jul 16 17:54:39 tokeiihto kernel: [    1.095150] xhci_hcd 0000:15:00.0: x=
HCI Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.095155] xhci_hcd 0000:15:00.0: n=
ew USB bus registered, assigned bus number 1
Jul 16 17:54:39 tokeiihto kernel: [    1.095574] piix4_smbus 0000:00:14.0=
: SMBus Host Controller at 0xb00, revision 0
Jul 16 17:54:39 tokeiihto kernel: [    1.095575] piix4_smbus 0000:00:14.0=
: Using register 0x02 for SMBus port selection
Jul 16 17:54:39 tokeiihto kernel: [    1.096200] libata version 3.00 load=
ed.
Jul 16 17:54:39 tokeiihto kernel: [    1.098274] AVX2 version of gcm_enc/=
dec engaged.
Jul 16 17:54:39 tokeiihto kernel: [    1.098274] AES CTR mode by8 optimiz=
ation enabled
Jul 16 17:54:39 tokeiihto kernel: [    1.101119] r8169 0000:18:00.0 eth0:=
 RTL8168h/8111h at 0x        (ptrval), 30:9c:23:04:d6:98, XID 14100800 IR=
Q 36
Jul 16 17:54:39 tokeiihto kernel: [    1.101121] r8169 0000:18:00.0 eth0:=
 jumbo features [frames: 9200 bytes, tx checksumming: ko]
Jul 16 17:54:39 tokeiihto kernel: [    1.105770] r8169 0000:18:00.0 enp24=
s0: renamed from eth0
Jul 16 17:54:39 tokeiihto kernel: [    1.142265] alg: No test for pcbc(ae=
s) (pcbc-aes-aesni)
Jul 16 17:54:39 tokeiihto kernel: [    1.150549] xhci_hcd 0000:15:00.0: h=
cc params 0x0200ef81 hci version 0x110 quirks 0x48000410
Jul 16 17:54:39 tokeiihto kernel: [    1.150731] usb usb1: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0002
Jul 16 17:54:39 tokeiihto kernel: [    1.150732] usb usb1: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:54:39 tokeiihto kernel: [    1.150733] usb usb1: Product: xHCI =
Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.150734] usb usb1: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.150734] usb usb1: SerialNumber: =
0000:15:00.0
Jul 16 17:54:39 tokeiihto kernel: [    1.150825] hub 1-0:1.0: USB hub fou=
nd
Jul 16 17:54:39 tokeiihto kernel: [    1.150841] hub 1-0:1.0: 10 ports de=
tected
Jul 16 17:54:39 tokeiihto kernel: [    1.151222] xhci_hcd 0000:15:00.0: x=
HCI Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.151224] xhci_hcd 0000:15:00.0: n=
ew USB bus registered, assigned bus number 2
Jul 16 17:54:39 tokeiihto kernel: [    1.151226] xhci_hcd 0000:15:00.0: H=
ost supports USB 3.10 Enhanced SuperSpeed
Jul 16 17:54:39 tokeiihto kernel: [    1.151250] usb usb2: We don't know =
the algorithms for LPM for this host, disabling LPM.
Jul 16 17:54:39 tokeiihto kernel: [    1.151261] usb usb2: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0003
Jul 16 17:54:39 tokeiihto kernel: [    1.151262] usb usb2: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:54:39 tokeiihto kernel: [    1.151263] usb usb2: Product: xHCI =
Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.151264] usb usb2: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.151264] usb usb2: SerialNumber: =
0000:15:00.0
Jul 16 17:54:39 tokeiihto kernel: [    1.151332] hub 2-0:1.0: USB hub fou=
nd
Jul 16 17:54:39 tokeiihto kernel: [    1.151340] hub 2-0:1.0: 4 ports det=
ected
Jul 16 17:54:39 tokeiihto kernel: [    1.151479] ahci 0000:15:00.1: versi=
on 3.0
Jul 16 17:54:39 tokeiihto kernel: [    1.151574] xhci_hcd 0000:38:00.3: x=
HCI Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.151576] xhci_hcd 0000:38:00.3: n=
ew USB bus registered, assigned bus number 3
Jul 16 17:54:39 tokeiihto kernel: [    1.151681] ahci 0000:15:00.1: SSS f=
lag set, parallel bus scan disabled
Jul 16 17:54:39 tokeiihto kernel: [    1.151732] ahci 0000:15:00.1: AHCI =
0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
Jul 16 17:54:39 tokeiihto kernel: [    1.151735] ahci 0000:15:00.1: flags=
: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds=
 apst=20
Jul 16 17:54:39 tokeiihto kernel: [    1.151763] xhci_hcd 0000:38:00.3: h=
cc params 0x0270ffe5 hci version 0x110 quirks 0x40000410
Jul 16 17:54:39 tokeiihto kernel: [    1.152186] usb usb3: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0002
Jul 16 17:54:39 tokeiihto kernel: [    1.152187] usb usb3: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:54:39 tokeiihto kernel: [    1.152188] usb usb3: Product: xHCI =
Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.152189] usb usb3: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.152189] usb usb3: SerialNumber: =
0000:38:00.3
Jul 16 17:54:39 tokeiihto kernel: [    1.152278] hub 3-0:1.0: USB hub fou=
nd
Jul 16 17:54:39 tokeiihto kernel: [    1.152291] hub 3-0:1.0: 4 ports det=
ected
Jul 16 17:54:39 tokeiihto kernel: [    1.152601] scsi host0: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.152609] xhci_hcd 0000:38:00.3: x=
HCI Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.152611] xhci_hcd 0000:38:00.3: n=
ew USB bus registered, assigned bus number 4
Jul 16 17:54:39 tokeiihto kernel: [    1.152613] xhci_hcd 0000:38:00.3: H=
ost supports USB 3.10 Enhanced SuperSpeed
Jul 16 17:54:39 tokeiihto kernel: [    1.152643] usb usb4: We don't know =
the algorithms for LPM for this host, disabling LPM.
Jul 16 17:54:39 tokeiihto kernel: [    1.152654] usb usb4: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0003
Jul 16 17:54:39 tokeiihto kernel: [    1.152655] usb usb4: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:54:39 tokeiihto kernel: [    1.152655] usb usb4: Product: xHCI =
Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.152656] usb usb4: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.152657] usb usb4: SerialNumber: =
0000:38:00.3
Jul 16 17:54:39 tokeiihto kernel: [    1.152741] hub 4-0:1.0: USB hub fou=
nd
Jul 16 17:54:39 tokeiihto kernel: [    1.152754] hub 4-0:1.0: 4 ports det=
ected
Jul 16 17:54:39 tokeiihto kernel: [    1.152808] scsi host1: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.152953] scsi host2: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.152971] xhci_hcd 0000:38:00.4: x=
HCI Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.152974] xhci_hcd 0000:38:00.4: n=
ew USB bus registered, assigned bus number 5
Jul 16 17:54:39 tokeiihto kernel: [    1.153104] scsi host3: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.153152] xhci_hcd 0000:38:00.4: h=
cc params 0x0260ffe5 hci version 0x110 quirks 0x40000410
Jul 16 17:54:39 tokeiihto kernel: [    1.153215] scsi host4: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.153311] scsi host5: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.153414] scsi host6: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.153527] scsi host7: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.153558] usb usb5: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0002
Jul 16 17:54:39 tokeiihto kernel: [    1.153559] usb usb5: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:54:39 tokeiihto kernel: [    1.153559] usb usb5: Product: xHCI =
Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.153560] usb usb5: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.153561] usb usb5: SerialNumber: =
0000:38:00.4
Jul 16 17:54:39 tokeiihto kernel: [    1.153575] ata1: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880100 irq 39
Jul 16 17:54:39 tokeiihto kernel: [    1.153578] ata2: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880180 irq 39
Jul 16 17:54:39 tokeiihto kernel: [    1.153578] ata3: DUMMY
Jul 16 17:54:39 tokeiihto kernel: [    1.153579] ata4: DUMMY
Jul 16 17:54:39 tokeiihto kernel: [    1.153581] ata5: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880300 irq 39
Jul 16 17:54:39 tokeiihto kernel: [    1.153583] ata6: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880380 irq 39
Jul 16 17:54:39 tokeiihto kernel: [    1.153584] ata7: DUMMY
Jul 16 17:54:39 tokeiihto kernel: [    1.153584] ata8: DUMMY
Jul 16 17:54:39 tokeiihto kernel: [    1.153644] hub 5-0:1.0: USB hub fou=
nd
Jul 16 17:54:39 tokeiihto kernel: [    1.153655] hub 5-0:1.0: 1 port dete=
cted
Jul 16 17:54:39 tokeiihto kernel: [    1.153728] xhci_hcd 0000:38:00.4: x=
HCI Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.153740] xhci_hcd 0000:38:00.4: n=
ew USB bus registered, assigned bus number 6
Jul 16 17:54:39 tokeiihto kernel: [    1.153742] xhci_hcd 0000:38:00.4: H=
ost supports USB 3.10 Enhanced SuperSpeed
Jul 16 17:54:39 tokeiihto kernel: [    1.153766] usb usb6: We don't know =
the algorithms for LPM for this host, disabling LPM.
Jul 16 17:54:39 tokeiihto kernel: [    1.153776] usb usb6: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0003
Jul 16 17:54:39 tokeiihto kernel: [    1.153777] usb usb6: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:54:39 tokeiihto kernel: [    1.153777] usb usb6: Product: xHCI =
Host Controller
Jul 16 17:54:39 tokeiihto kernel: [    1.153778] usb usb6: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.153779] usb usb6: SerialNumber: =
0000:38:00.4
Jul 16 17:54:39 tokeiihto kernel: [    1.153808] ahci 0000:39:00.0: AHCI =
0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
Jul 16 17:54:39 tokeiihto kernel: [    1.153810] ahci 0000:39:00.0: flags=
: 64bit ncq sntf ilck led clo only pmp fbs pio=20
Jul 16 17:54:39 tokeiihto kernel: [    1.153862] hub 6-0:1.0: USB hub fou=
nd
Jul 16 17:54:39 tokeiihto kernel: [    1.153866] hub 6-0:1.0: 1 port dete=
cted
Jul 16 17:54:39 tokeiihto kernel: [    1.154817] scsi host8: ahci
Jul 16 17:54:39 tokeiihto kernel: [    1.154887] ata9: SATA max UDMA/133 =
abar m2048@0xfe900000 port 0xfe900100 irq 52
Jul 16 17:54:39 tokeiihto kernel: [    1.466406] ata1: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:54:39 tokeiihto kernel: [    1.484356] usb 1-10: new low-speed =
USB device number 2 using xhci_hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.488444] usb 5-1: new low-speed U=
SB device number 2 using xhci_hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.512198] usb 4-2: new SuperSpeed =
USB device number 2 using xhci_hcd
Jul 16 17:54:39 tokeiihto kernel: [    1.532353] tsc: Refined TSC clockso=
urce calibration: 3503.043 MHz
Jul 16 17:54:39 tokeiihto kernel: [    1.532366] clocksource: tsc: mask: =
0xffffffffffffffff max_cycles: 0x327e8c14376, max_idle_ns: 440795362368 n=
s
Jul 16 17:54:39 tokeiihto kernel: [    1.532408] clocksource: Switched to=
 clocksource tsc
Jul 16 17:54:39 tokeiihto kernel: [    1.533114] usb 4-2: New USB device =
found, idVendor=3D0781, idProduct=3D558b
Jul 16 17:54:39 tokeiihto kernel: [    1.533116] usb 4-2: New USB device =
strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
Jul 16 17:54:39 tokeiihto kernel: [    1.533117] usb 4-2: Product: Extrem=
e
Jul 16 17:54:39 tokeiihto kernel: [    1.533118] usb 4-2: Manufacturer: S=
anDisk
Jul 16 17:54:39 tokeiihto kernel: [    1.533119] usb 4-2: SerialNumber: 4=
C530001051117121354
Jul 16 17:54:39 tokeiihto kernel: [    1.535046] usb-storage 4-2:1.0: USB=
 Mass Storage device detected
Jul 16 17:54:39 tokeiihto kernel: [    1.535157] scsi host9: usb-storage =
4-2:1.0
Jul 16 17:54:39 tokeiihto kernel: [    1.535228] usbcore: registered new =
interface driver usb-storage
Jul 16 17:54:39 tokeiihto kernel: [    1.535651] usbcore: registered new =
interface driver uas
Jul 16 17:54:39 tokeiihto kernel: [    1.632037] ata9: SATA link up 6.0 G=
bps (SStatus 133 SControl 300)
Jul 16 17:54:39 tokeiihto kernel: [    1.632892] ata9.00: supports DRM fu=
nctions and may not be fully accessible
Jul 16 17:54:39 tokeiihto kernel: [    1.632924] ata9.00: ATA-10: CT1000M=
X500SSD4, M3CR020, max UDMA/133
Jul 16 17:54:39 tokeiihto kernel: [    1.632925] ata9.00: 1953525168 sect=
ors, multi 1: LBA48 NCQ (depth 31/32), AA
Jul 16 17:54:39 tokeiihto kernel: [    1.633097] ata9.00: READ LOG DMA EX=
T failed, trying PIO
Jul 16 17:54:39 tokeiihto kernel: [    1.633098] ata9.00: failed to get I=
dentify Device Data, Emask 0x40
Jul 16 17:54:39 tokeiihto kernel: [    1.633099] ata9.00: ATA Identify De=
vice Log not supported
Jul 16 17:54:39 tokeiihto kernel: [    1.633099] ata9.00: Security Log no=
t supported
Jul 16 17:54:39 tokeiihto kernel: [    1.633102] ata9.00: failed to set x=
fermode (err_mask=3D0x40)
Jul 16 17:54:39 tokeiihto kernel: [    1.652760] usb 5-1: New USB device =
found, idVendor=3D413c, idProduct=3D3012
Jul 16 17:54:39 tokeiihto kernel: [    1.652763] usb 5-1: New USB device =
strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Jul 16 17:54:39 tokeiihto kernel: [    1.652765] usb 5-1: Product: Dell U=
SB Optical Mouse
Jul 16 17:54:39 tokeiihto kernel: [    1.652767] usb 5-1: Manufacturer: D=
ell
Jul 16 17:54:39 tokeiihto kernel: [    1.661166] hidraw: raw HID events d=
river (C) Jiri Kosina
Jul 16 17:54:39 tokeiihto kernel: [    1.665783] usbcore: registered new =
interface driver usbhid
Jul 16 17:54:39 tokeiihto kernel: [    1.665784] usbhid: USB HID core dri=
ver
Jul 16 17:54:39 tokeiihto kernel: [    1.666409] input: Dell Dell USB Opt=
ical Mouse as /devices/pci0000:00/0000:00:08.1/0000:38:00.4/usb5/5-1/5-1:=
1.0/0003:413C:3012.0001/input/input0
Jul 16 17:54:39 tokeiihto kernel: [    1.666466] hid-generic 0003:413C:30=
12.0001: input,hidraw0: USB HID v1.11 Mouse [Dell Dell USB Optical Mouse]=
 on usb-0000:38:00.4-1/input0
Jul 16 17:54:39 tokeiihto kernel: [    1.776415] usb 1-10: New USB device=
 found, idVendor=3D413c, idProduct=3D2105
Jul 16 17:54:39 tokeiihto kernel: [    1.776418] usb 1-10: New USB device=
 strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Jul 16 17:54:39 tokeiihto kernel: [    1.776421] usb 1-10: Product: Dell =
USB Keyboard
Jul 16 17:54:39 tokeiihto kernel: [    1.776423] usb 1-10: Manufacturer: =
Dell
Jul 16 17:54:39 tokeiihto kernel: [    1.778239] ata2: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:54:39 tokeiihto kernel: [    1.838433] input: Dell Dell USB Key=
board as /devices/pci0000:00/0000:00:01.2/0000:15:00.0/usb1/1-10/1-10:1.0=
/0003:413C:2105.0002/input/input1
Jul 16 17:54:39 tokeiihto kernel: [    1.896375] hid-generic 0003:413C:21=
05.0002: input,hidraw1: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] o=
n usb-0000:15:00.0-10/input0
Jul 16 17:54:39 tokeiihto kernel: [    2.090204] ata5: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:54:39 tokeiihto kernel: [    2.403934] ata6: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:54:39 tokeiihto kernel: [    2.556742] scsi 9:0:0:0: Direct-Acc=
ess     SanDisk  Extreme          1.00 PQ: 0 ANSI: 6
Jul 16 17:54:39 tokeiihto kernel: [    2.558766] sd 9:0:0:0: [sda] 122552=
320 512-byte logical blocks: (62.7 GB/58.4 GiB)
Jul 16 17:54:39 tokeiihto kernel: [    2.558977] sd 9:0:0:0: [sda] Write =
Protect is off
Jul 16 17:54:39 tokeiihto kernel: [    2.558978] sd 9:0:0:0: [sda] Mode S=
ense: 43 00 00 00
Jul 16 17:54:39 tokeiihto kernel: [    2.559188] sd 9:0:0:0: [sda] Write =
cache: disabled, read cache: enabled, doesn't support DPO or FUA
Jul 16 17:54:39 tokeiihto kernel: [    2.560794]  sda: sda1 sda2 sda3
Jul 16 17:54:39 tokeiihto kernel: [    2.561677] sd 9:0:0:0: [sda] Attach=
ed SCSI removable disk
Jul 16 17:54:39 tokeiihto kernel: [    7.352246] ata9: SATA link up 6.0 G=
bps (SStatus 133 SControl 300)
Jul 16 17:54:39 tokeiihto kernel: [    7.353434] ata9.00: supports DRM fu=
nctions and may not be fully accessible
Jul 16 17:54:39 tokeiihto kernel: [    7.354196] ata9.00: supports DRM fu=
nctions and may not be fully accessible
Jul 16 17:54:39 tokeiihto kernel: [    7.354772] ata9.00: configured for =
UDMA/133
Jul 16 17:54:39 tokeiihto kernel: [    7.354975] scsi 8:0:0:0: Direct-Acc=
ess     ATA      CT1000MX500SSD4  020  PQ: 0 ANSI: 5
Jul 16 17:54:39 tokeiihto kernel: [    7.355681] sd 8:0:0:0: [sdb] 195352=
5168 512-byte logical blocks: (1.00 TB/932 GiB)
Jul 16 17:54:39 tokeiihto kernel: [    7.355684] sd 8:0:0:0: [sdb] 4096-b=
yte physical blocks
Jul 16 17:54:39 tokeiihto kernel: [    7.355701] sd 8:0:0:0: [sdb] Write =
Protect is off
Jul 16 17:54:39 tokeiihto kernel: [    7.355702] sd 8:0:0:0: [sdb] Mode S=
ense: 00 3a 00 00
Jul 16 17:54:39 tokeiihto kernel: [    7.355724] sd 8:0:0:0: [sdb] Write =
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jul 16 17:54:39 tokeiihto kernel: [    7.356418]  sdb: sdb1 sdb2 sdb3
Jul 16 17:54:39 tokeiihto kernel: [    7.356898] sd 8:0:0:0: [sdb] suppor=
ts TCG Opal
Jul 16 17:54:39 tokeiihto kernel: [    7.356899] sd 8:0:0:0: [sdb] Attach=
ed SCSI disk
Jul 16 17:54:39 tokeiihto kernel: [    7.366336] random: fast init done
Jul 16 17:54:39 tokeiihto kernel: [    7.532012] raid6: sse2x1   gen()  8=
266 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    7.600241] raid6: sse2x1   xor()  7=
837 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    7.668236] raid6: sse2x2   gen() 16=
930 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    7.736273] raid6: sse2x2   xor() 10=
622 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    7.804250] raid6: sse2x4   gen() 17=
195 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    7.872247] raid6: sse2x4   xor()  9=
737 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    7.940243] raid6: avx2x1   gen() 18=
789 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.008250] raid6: avx2x1   xor() 14=
060 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.076385] raid6: avx2x2   gen() 23=
689 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.144022] raid6: avx2x2   xor() 14=
973 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.212020] raid6: avx2x4   gen() 24=
521 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.280244] raid6: avx2x4   xor() 13=
535 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.280244] raid6: using algorithm a=
vx2x4 gen() 24521 MB/s
Jul 16 17:54:39 tokeiihto kernel: [    8.280244] raid6: .... xor() 13535 =
MB/s, rmw enabled
Jul 16 17:54:39 tokeiihto kernel: [    8.280245] raid6: using avx2x2 reco=
very algorithm
Jul 16 17:54:39 tokeiihto kernel: [    8.280690] xor: automatically using=
 best checksumming function   avx      =20
Jul 16 17:54:39 tokeiihto kernel: [    8.280981] async_tx: api initialize=
d (async)
Jul 16 17:54:39 tokeiihto kernel: [    8.294920] device-mapper: uevent: v=
ersion 1.0.3
Jul 16 17:54:39 tokeiihto kernel: [    8.295021] device-mapper: ioctl: 4.=
37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
Jul 16 17:54:39 tokeiihto kernel: [   16.231577] NET: Registered protocol=
 family 38
Jul 16 17:54:39 tokeiihto kernel: [   18.161440] random: crng init done
Jul 16 17:54:39 tokeiihto kernel: [   25.066611] EXT4-fs (dm-0): mounted =
filesystem with ordered data mode. Opts: (null)
Jul 16 17:54:39 tokeiihto kernel: [   25.362715] EXT4-fs (dm-0): re-mount=
ed. Opts: errors=3Dremount-ro
Jul 16 17:54:39 tokeiihto kernel: [   25.435572] acpi_cpufreq: overriding=
 BIOS provided _PSD data
Jul 16 17:54:39 tokeiihto kernel: [   25.438414] input: Power Button as /=
devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
Jul 16 17:54:39 tokeiihto kernel: [   25.438422] ACPI: Power Button [PWRB=
]
Jul 16 17:54:39 tokeiihto kernel: [   25.438471] input: Power Button as /=
devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
Jul 16 17:54:39 tokeiihto kernel: [   25.438530] ACPI: Power Button [PWRF=
]
Jul 16 17:54:39 tokeiihto kernel: [   25.468856] shpchp: Standard Hot Plu=
g PCI Controller Driver version: 0.4
Jul 16 17:54:39 tokeiihto kernel: [   25.469261] parport_pc 00:04: report=
ed by Plug and Play ACPI
Jul 16 17:54:39 tokeiihto kernel: [   25.469403] parport0: PC-style at 0x=
378, irq 5 [PCSPP]
Jul 16 17:54:39 tokeiihto kernel: [   25.489094] sp5100_tco: SP5100/SB800=
 TCO WatchDog Timer Driver
Jul 16 17:54:39 tokeiihto kernel: [   25.489157] sp5100-tco sp5100-tco: I=
/O address 0x0cd6 already in use
Jul 16 17:54:39 tokeiihto kernel: [   25.489180] sp5100-tco: probe of sp5=
100-tco failed with error -16
Jul 16 17:54:39 tokeiihto kernel: [   25.492241] sd 9:0:0:0: Attached scs=
i generic sg0 type 0
Jul 16 17:54:39 tokeiihto kernel: [   25.492275] sd 8:0:0:0: Attached scs=
i generic sg1 type 0
Jul 16 17:54:39 tokeiihto kernel: [   25.520187] input: PC Speaker as /de=
vices/platform/pcspkr/input/input4
Jul 16 17:54:39 tokeiihto kernel: [   25.521959] EFI Variables Facility v=
0.08 2004-May-17
Jul 16 17:54:39 tokeiihto kernel: [   25.526279] snd_hda_intel 0000:38:00=
=2E1: Handle vga_switcheroo audio client
Jul 16 17:54:39 tokeiihto kernel: [   25.551075] kvm: disabled by bios
Jul 16 17:54:39 tokeiihto kernel: [   25.557356] MCE: In-kernel MCE decod=
ing enabled.
Jul 16 17:54:39 tokeiihto kernel: [   25.563048] input: HD-Audio Generic =
HDMI/DP,pcm=3D3 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input5
Jul 16 17:54:39 tokeiihto kernel: [   25.563148] input: HD-Audio Generic =
HDMI/DP,pcm=3D7 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input6
Jul 16 17:54:39 tokeiihto kernel: [   25.563186] input: HD-Audio Generic =
HDMI/DP,pcm=3D8 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input7
Jul 16 17:54:39 tokeiihto kernel: [   25.563222] input: HD-Audio Generic =
HDMI/DP,pcm=3D9 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input8
Jul 16 17:54:39 tokeiihto kernel: [   25.563250] input: HD-Audio Generic =
HDMI/DP,pcm=3D10 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/c=
ard0/input9
Jul 16 17:54:39 tokeiihto kernel: [   25.563288] input: HD-Audio Generic =
HDMI/DP,pcm=3D11 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/c=
ard0/input10
Jul 16 17:54:39 tokeiihto kernel: [   25.592485] EDAC amd64: Node 0: DRAM=
 ECC disabled.
Jul 16 17:54:39 tokeiihto kernel: [   25.592487] EDAC amd64: ECC disabled=
 in the BIOS or no ECC capability, module will not load.
Jul 16 17:54:39 tokeiihto kernel: [   25.592487]  Either enable ECC check=
ing or force module loading by setting 'ecc_enable_override'.
Jul 16 17:54:39 tokeiihto kernel: [   25.592487]  (Note that use of the o=
verride may cause unknown side effects.)
Jul 16 17:54:39 tokeiihto kernel: [   25.592927] pstore: using zlib compr=
ession
Jul 16 17:54:39 tokeiihto kernel: [   25.592944] pstore: Registered efi a=
s persistent store backend
Jul 16 17:54:39 tokeiihto kernel: [   25.594395] [drm] amdgpu kernel mode=
setting enabled.
Jul 16 17:54:39 tokeiihto kernel: [   25.601273] ppdev: user-space parall=
el port driver
Jul 16 17:54:39 tokeiihto kernel: [   25.605730] snd_hda_codec_realtek hd=
audioC1D0: autoconfig for ALC892: line_outs=3D3 (0x14/0x15/0x16/0x0/0x0) =
type:line
Jul 16 17:54:39 tokeiihto kernel: [   25.605732] snd_hda_codec_realtek hd=
audioC1D0:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Jul 16 17:54:39 tokeiihto kernel: [   25.605733] snd_hda_codec_realtek hd=
audioC1D0:    hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
Jul 16 17:54:39 tokeiihto kernel: [   25.605734] snd_hda_codec_realtek hd=
audioC1D0:    mono: mono_out=3D0x0
Jul 16 17:54:39 tokeiihto kernel: [   25.605734] snd_hda_codec_realtek hd=
audioC1D0:    dig-out=3D0x1e/0x0
Jul 16 17:54:39 tokeiihto kernel: [   25.605735] snd_hda_codec_realtek hd=
audioC1D0:    inputs:
Jul 16 17:54:39 tokeiihto kernel: [   25.605736] snd_hda_codec_realtek hd=
audioC1D0:      Front Mic=3D0x19
Jul 16 17:54:39 tokeiihto kernel: [   25.605737] snd_hda_codec_realtek hd=
audioC1D0:      Rear Mic=3D0x18
Jul 16 17:54:39 tokeiihto kernel: [   25.605738] snd_hda_codec_realtek hd=
audioC1D0:      Line=3D0x1a
Jul 16 17:54:39 tokeiihto kernel: [   25.622849] Parsing CRAT table with =
1 nodes
Jul 16 17:54:39 tokeiihto kernel: [   25.622852] Creating topology SYSFS =
entries
Jul 16 17:54:39 tokeiihto kernel: [   25.622876] Topology: Add APU node [=
0x0:0x0]
Jul 16 17:54:39 tokeiihto kernel: [   25.622877] Finished initializing to=
pology
Jul 16 17:54:39 tokeiihto kernel: [   25.622895] kfd kfd: Initialized mod=
ule
Jul 16 17:54:39 tokeiihto kernel: [   25.627825] checking generic (e00000=
00 300000) vs hw (e0000000 10000000)
Jul 16 17:54:39 tokeiihto kernel: [   25.627826] fb: switching to amdgpud=
rmfb from EFI VGA
Jul 16 17:54:39 tokeiihto kernel: [   25.627843] Console: switching to co=
lour dummy device 80x25
Jul 16 17:54:39 tokeiihto kernel: [   25.628920] [drm] initializing kerne=
l modesetting (RAVEN 0x1002:0x15DD 0x1002:0x15DD 0xC8).
Jul 16 17:54:39 tokeiihto kernel: [   25.628931] [drm] register mmio base=
: 0xFE600000
Jul 16 17:54:39 tokeiihto kernel: [   25.628931] [drm] register mmio size=
: 524288
Jul 16 17:54:39 tokeiihto kernel: [   25.629928] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_gpu_info.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.629934] [drm] probing gen 2 caps=
 for device 1022:15db =3D 700d03/e
Jul 16 17:54:39 tokeiihto kernel: [   25.629936] [drm] probing mlw for de=
vice 1022:15db =3D 700d03
Jul 16 17:54:39 tokeiihto kernel: [   25.630042] [drm] VCN decode is enab=
led in VM mode
Jul 16 17:54:39 tokeiihto kernel: [   25.630043] [drm] VCN encode is enab=
led in VM mode
Jul 16 17:54:39 tokeiihto kernel: [   25.638966] input: HD-Audio Generic =
Front Mic as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card1/in=
put11
Jul 16 17:54:39 tokeiihto kernel: [   25.639011] input: HD-Audio Generic =
Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card1/inp=
ut12
Jul 16 17:54:39 tokeiihto kernel: [   25.639043] input: HD-Audio Generic =
Line as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card1/input13=

Jul 16 17:54:39 tokeiihto kernel: [   25.639086] input: HD-Audio Generic =
Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/car=
d1/input14
Jul 16 17:54:39 tokeiihto kernel: [   25.639124] input: HD-Audio Generic =
Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/=
card1/input15
Jul 16 17:54:39 tokeiihto kernel: [   25.639161] input: HD-Audio Generic =
Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card=
1/input16
Jul 16 17:54:39 tokeiihto kernel: [   25.639192] input: HD-Audio Generic =
Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/ca=
rd1/input17
Jul 16 17:54:39 tokeiihto kernel: [   25.652026] [drm] BIOS signature inc=
orrect 0 0
Jul 16 17:54:39 tokeiihto kernel: [   25.652058] ATOM BIOS: 113-RAVEN-106=

Jul 16 17:54:39 tokeiihto kernel: [   25.652096] [drm] vm size is 262144 =
GB, 4 levels, block size is 9-bit, fragment size is 9-bit
Jul 16 17:54:39 tokeiihto kernel: [   25.652107] amdgpu 0000:38:00.0: VRA=
M: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Jul 16 17:54:39 tokeiihto kernel: [   25.652109] amdgpu 0000:38:00.0: GTT=
: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
Jul 16 17:54:39 tokeiihto kernel: [   25.652113] [drm] Detected VRAM RAM=3D=
1024M, BAR=3D256M
Jul 16 17:54:39 tokeiihto kernel: [   25.652114] [drm] RAM width 128bits =
UNKNOWN
Jul 16 17:54:39 tokeiihto kernel: [   25.652170] [TTM] Zone  kernel: Avai=
lable graphics memory: 7703370 kiB
Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Zone   dma32: Avai=
lable graphics memory: 2097152 kiB
Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Initializing pool =
allocator
Jul 16 17:54:39 tokeiihto kernel: [   25.652174] [TTM] Initializing DMA p=
ool allocator
Jul 16 17:54:39 tokeiihto kernel: [   25.652202] [drm] amdgpu: 1024M of V=
RAM memory ready
Jul 16 17:54:39 tokeiihto kernel: [   25.652203] [drm] amdgpu: 3072M of G=
TT memory ready.
Jul 16 17:54:39 tokeiihto kernel: [   25.652220] [drm] GART: num cpu page=
s 262144, num gpu pages 262144
Jul 16 17:54:39 tokeiihto kernel: [   25.652433] [drm] PCIE GART of 1024M=
 enabled (table at 0x000000F400800000).
Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Supports vblank ti=
mestamp caching Rev 2 (21.10.2013).
Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Driver supports pr=
ecise vblank timestamp query.
Jul 16 17:54:39 tokeiihto kernel: [   25.652983] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_asd.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653276] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_pfp.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653498] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_me.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653668] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_ce.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.653960] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_rlc.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.654817] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_mec.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.656137] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_mec2.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.658217] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_sdma.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.658220] [drm] use_doorbell being=
 set to: [true]
Jul 16 17:54:39 tokeiihto kernel: [   25.659663] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_vcn.bin
Jul 16 17:54:39 tokeiihto kernel: [   25.659667] [drm] Found VCN firmware=
 Version: 1.73 Family ID: 18
Jul 16 17:54:39 tokeiihto kernel: [   25.847424] [drm] VCN decode and enc=
ode initialized successfully.
Jul 16 17:54:39 tokeiihto kernel: [   25.852189] amdgpu 0000:38:00.0: rin=
g 0(gfx) uses VM inv eng 4 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852191] amdgpu 0000:38:00.0: rin=
g 1(comp_1.0.0) uses VM inv eng 5 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852193] amdgpu 0000:38:00.0: rin=
g 2(comp_1.1.0) uses VM inv eng 6 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852194] amdgpu 0000:38:00.0: rin=
g 3(comp_1.2.0) uses VM inv eng 7 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852195] amdgpu 0000:38:00.0: rin=
g 4(comp_1.3.0) uses VM inv eng 8 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852197] amdgpu 0000:38:00.0: rin=
g 5(comp_1.0.1) uses VM inv eng 9 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852198] amdgpu 0000:38:00.0: rin=
g 6(comp_1.1.1) uses VM inv eng 10 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852200] amdgpu 0000:38:00.0: rin=
g 7(comp_1.2.1) uses VM inv eng 11 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852201] amdgpu 0000:38:00.0: rin=
g 8(comp_1.3.1) uses VM inv eng 12 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852202] amdgpu 0000:38:00.0: rin=
g 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
Jul 16 17:54:39 tokeiihto kernel: [   25.852204] amdgpu 0000:38:00.0: rin=
g 10(sdma0) uses VM inv eng 4 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.852205] amdgpu 0000:38:00.0: rin=
g 11(vcn_dec) uses VM inv eng 5 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.852207] amdgpu 0000:38:00.0: rin=
g 12(vcn_enc0) uses VM inv eng 6 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.852208] amdgpu 0000:38:00.0: rin=
g 13(vcn_enc1) uses VM inv eng 7 on hub 1
Jul 16 17:54:39 tokeiihto kernel: [   25.856580] [drm] Initialized amdgpu=
 3.23.0 20150101 for 0000:38:00.0 on minor 0
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Linux version 4.16.0-2-a=
md64 (debian-kernel@lists.debian.org) (gcc version 7.3.0 (Debian 7.3.0-23=
)) #1 SMP Debian 4.16.16-2 (2018-06-22)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Command line: BOOT_IMAGE=
=3D/vmlinuz-4.16.0-2-amd64 root=3DUUID=3D313f78e2-468f-4660-b236-d1de214b=
f6b4 ro nomodeset
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] x86/fpu: Supporting XSAV=
E feature 0x001: 'x87 floating point registers'
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] x86/fpu: Supporting XSAV=
E feature 0x002: 'SSE registers'
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] x86/fpu: Supporting XSAV=
E feature 0x004: 'AVX registers'
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] x86/fpu: xstate_offset[2=
]:  576, xstate_sizes[2]:  256
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] x86/fpu: Enabled xstate =
features 0x7, context size is 832 bytes, using 'compacted' format.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: BIOS-provided phys=
ical RAM map:
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0000000000-0x000000000009ffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00000a0000-0x00000000000fffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0000100000-0x0000000003ffffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0004000000-0x0000000004009fff] ACPI NVS
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000400a000-0x0000000009d7ffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0009d80000-0x0000000009ffffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000a000000-0x000000000affffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000b000000-0x000000000b01ffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
000b020000-0x000000009d1e4fff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d1e5000-0x000000009d2d4fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d2d5000-0x000000009d3c6fff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d3c7000-0x000000009d78ffff] ACPI NVS
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009d790000-0x000000009e5bffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009e5c0000-0x000000009e664fff] type 20
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009e665000-0x000000009effffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
009f000000-0x00000000dfffffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00f8000000-0x00000000fbffffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fd800000-0x00000000fdffffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fea00000-0x00000000fea0ffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00feb80000-0x00000000fec01fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fec10000-0x00000000fec10fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fec30000-0x00000000fec30fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fed00000-0x00000000fed00fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fed40000-0x00000000fed44fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fed80000-0x00000000fed8ffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fedc2000-0x00000000fedcffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fedd4000-0x00000000fedd5fff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00fee00000-0x00000000feefffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
00ff000000-0x00000000ffffffff] reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BIOS-e820: [mem 0x000000=
0100000000-0x000000041f33ffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] NX (Execute Disable) pro=
tection: active
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] efi: EFI v2.60 by Americ=
an Megatrends
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] efi:  ACPI 2.0=3D0x9d3c7=
000  ACPI=3D0x9d3c7000  SMBIOS=3D0x9e48d000  ESRT=3D0x98880f98  MEMATTR=3D=
0x97a58018=20
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] secureboot: Secure boot =
could not be determined (mode 0)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] SMBIOS 2.8 present.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] DMI: MSI MS-7A37/B350M M=
ORTAR (MS-7A37), BIOS 1.F0 04/27/2018
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: update [mem 0x0000=
0000-0x00000fff] usable =3D=3D> reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: remove [mem 0x000a=
0000-0x000fffff] usable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: last_pfn =3D 0x41f=
340 max_arch_pfn =3D 0x400000000
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] MTRR default type: uncac=
hable
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] MTRR fixed ranges enable=
d:
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   00000-9FFFF write-back=

Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   A0000-BFFFF write-thro=
ugh
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   C0000-FFFFF write-prot=
ect
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] MTRR variable ranges ena=
bled:
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   0 base 000000000000 ma=
sk FFFF80000000 write-back
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   1 base 000080000000 ma=
sk FFFFC0000000 write-back
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   2 base 0000C0000000 ma=
sk FFFFE0000000 write-back
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   3 disabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   4 disabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   5 disabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   6 disabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   7 disabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] TOM2: 0000000420000000 a=
ka 16896M
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] x86/PAT: Configuration [=
0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: update [mem 0xe000=
0000-0xffffffff] usable =3D=3D> reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: last_pfn =3D 0x9f0=
00 max_arch_pfn =3D 0x400000000
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] esrt: Reserving ESRT spa=
ce from 0x0000000098880f98 to 0x0000000098880fd0.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Base memory trampoline a=
t [        (ptrval)] 96000 size 24576
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Using GB pages for direc=
t mapping
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x6222c000, 0x6222c=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x6222d000, 0x6222d=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x6222e000, 0x6222e=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x6222f000, 0x6222f=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x62230000, 0x62230=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x62231000, 0x62231=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x62232000, 0x62232=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x62233000, 0x62233=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x62234000, 0x62234=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] BRK [0x62235000, 0x62235=
fff] PGTABLE
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] RAMDISK: [mem 0x34e69000=
-0x3672bfff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: Early table checks=
um verification disabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: RSDP 0x000000009D3=
C7000 000024 (v02 ALASKA)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: XSDT 0x000000009D3=
C70A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: FACP 0x000000009D3=
CE8B8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI BIOS Warning (bug):=
 Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0=
x0000000000000000/0x1 (20180105/tbfadt-658)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: DSDT 0x000000009D3=
C71F0 0076C7 (v02 ALASKA A M I    01072009 INTL 20120913)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: FACS 0x000000009D7=
79E00 000040
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: APIC 0x000000009D3=
CE9D0 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: FPDT 0x000000009D3=
CEAB0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: FIDT 0x000000009D3=
CEAF8 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
CEB98 005367 (v02 AMD    AmdTable 00000002 MSFT 02000002)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D3F00 0007DC (v01 AMD    AMD CPU  00000001 AMD  00000001)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: CRAT 0x000000009D3=
D46E0 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: CDIT 0x000000009D3=
D4EF0 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D4F20 002D89 (v01 AMD    AMD AOD  00000001 INTL 20120913)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: MCFG 0x000000009D3=
D7CB0 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: HPET 0x000000009D3=
D7CF0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: UEFI 0x000000009D3=
D7D28 000042 (v01                 00000000      00000000)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: IVRS 0x000000009D3=
D7D70 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: BGRT 0x000000009D3=
D7E40 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D7E78 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D7F70 000E96 (v01 AMD    AmdTable 00000001 INTL 20120913)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D8E08 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: SSDT 0x000000009D3=
D9658 001A41 (v01 AMD    AmdTable 00000001 INTL 20120913)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: WSMT 0x000000009D3=
DB0A0 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: Local APIC address=
 0xfee00000
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] No NUMA configuration fo=
und
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Faking a node at [mem 0x=
0000000000000000-0x000000041f33ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] NODE_DATA(0) allocated [=
mem 0x41f33b000-0x41f33ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] tsc: Fast TSC calibratio=
n failed
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] tsc: Using PIT calibrati=
on value
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Zone ranges:
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA      [mem 0x000000=
0000001000-0x0000000000ffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA32    [mem 0x000000=
0001000000-0x00000000ffffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   Normal   [mem 0x000000=
0100000000-0x000000041f33ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   Device   empty
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Movable zone start for e=
ach node
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Early memory node ranges=

Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
00000001000-0x000000000009ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
00000100000-0x0000000003ffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0000400a000-0x0000000009d7ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0000a000000-0x000000000affffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0000b020000-0x000000009d1e4fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0009d2d5000-0x000000009d3c6fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
0009e665000-0x000000009effffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   node   0: [mem 0x00000=
00100000000-0x000000041f33ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Initmem setup node 0 [me=
m 0x0000000000001000-0x000000041f33ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] On node 0 totalpages: 39=
19015
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA zone: 64 pages use=
d for memmap
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA zone: 28 pages res=
erved
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA zone: 3999 pages, =
LIFO batch:0
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA32 zone: 10024 page=
s used for memmap
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   DMA32 zone: 641480 pag=
es, LIFO batch:31
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   Normal zone: 51149 pag=
es used for memmap
Jul 16 17:56:05 tokeiihto kernel: [    0.000000]   Normal zone: 3273536 p=
ages, LIFO batch:31
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Reserved but unavailable=
: 97 pages
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: PM-Timer IO Port: =
0x808
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: Local APIC address=
 0xfee00000
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id=
[0xff] high edge lint[0x1])
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] IOAPIC[0]: apic_id 5, ve=
rsion 33, address 0xfec00000, GSI 0-23
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] IOAPIC[1]: apic_id 6, ve=
rsion 33, address 0xfec01000, GSI 24-55
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0=
 bus_irq 0 global_irq 2 dfl dfl)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0=
 bus_irq 9 global_irq 9 low level)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: IRQ0 used by overr=
ide.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: IRQ9 used by overr=
ide.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Using ACPI (MADT) for SM=
P configuration information
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: HPET id: 0x1022820=
1 base: 0xfed00000
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] smpboot: Allowing 16 CPU=
s, 12 hotplug CPUs
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x00000000-0x00000fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x000a0000-0x000fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x04000000-0x04009fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x09d80000-0x09ffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x0b000000-0x0b01ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9d1e5000-0x9d2d4fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9d3c7000-0x9d78ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9d790000-0x9e5bffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9e5c0000-0x9e664fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0x9f000000-0xdfffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xe0000000-0xf7ffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xf8000000-0xfbffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfc000000-0xfd7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfd800000-0xfdffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfe000000-0xfe9fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfea00000-0xfea0ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfea10000-0xfeb7ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfeb80000-0xfec01fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec02000-0xfec0ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec10000-0xfec10fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec11000-0xfec2ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec30000-0xfec30fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfec31000-0xfecfffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed00000-0xfed00fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed01000-0xfed3ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed40000-0xfed44fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed45000-0xfed7ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed80000-0xfed8ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfed90000-0xfedc1fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedc2000-0xfedcffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedd0000-0xfedd3fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedd4000-0xfedd5fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfedd6000-0xfedfffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfee00000-0xfeefffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xfef00000-0xfeffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] PM: Registered nosave me=
mory: [mem 0xff000000-0xffffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] e820: [mem 0xe0000000-0x=
f7ffffff] available for PCI devices
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Booting paravirtualized =
kernel on bare hardware
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] clocksource: refined-jif=
fies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211=
568 ns
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] random: get_random_bytes=
 called from start_kernel+0x94/0x4d3 with crng_init=3D0
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] setup_percpu: NR_CPUS:51=
2 nr_cpumask_bits:512 nr_cpu_ids:16 nr_node_ids:1
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] percpu: Embedded 44 page=
s/cpu @        (ptrval) s142296 r8192 d29736 u262144
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] pcpu-alloc: s142296 r819=
2 d29736 u262144 alloc=3D1*2097152
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] pcpu-alloc: [0] 00 01 02=
 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15=20
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Built 1 zonelists, mobil=
ity grouping on.  Total pages: 3857750
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Policy zone: Normal
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Kernel command line: BOO=
T_IMAGE=3D/vmlinuz-4.16.0-2-amd64 root=3DUUID=3D313f78e2-468f-4660-b236-d=
1de214bf6b4 ro nomodeset
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Calgary: detecting Calga=
ry via BIOS EBDA area
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Calgary: Unable to locat=
e Rio Grande table in EBDA - bailing!
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Memory: 15228168K/156760=
60K available (10252K kernel code, 1182K rwdata, 3136K rodata, 1524K init=
, 688K bss, 447892K reserved, 0K cma-reserved)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] SLUB: HWalign=3D64, Orde=
r=3D0-3, MinObjects=3D0, CPUs=3D16, Nodes=3D1
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ftrace: allocating 29954=
 entries in 118 pages
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Hierarchical RCU impleme=
ntation.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] 	RCU restricting CPUs fr=
om NR_CPUS=3D512 to nr_cpu_ids=3D16.
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] RCU: Adjusting geometry =
for rcu_fanout_leaf=3D16, nr_cpu_ids=3D16
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] NR_IRQS: 33024, nr_irqs:=
 1096, preallocated irqs: 16
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] Console: colour dummy de=
vice 80x25
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] console [tty0] enabled
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI: Core revision 2018=
0105
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI BIOS Error (bug): F=
ailure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180105/dswload-380)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI Error: AE_ALREADY_E=
XISTS, During name lookup/catalog (20180105/psobject-252)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI Error: AE_ALREADY_E=
XISTS, (SSDT:  AMD PT) while loading table (20180105/tbxfload-228)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] ACPI Error: 1 table load=
 failures, 7 successful (20180105/tbxfload-246)
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] clocksource: hpet: mask:=
 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] hpet clockevent register=
ed
Jul 16 17:56:05 tokeiihto kernel: [    0.000000] APIC: Switch to symmetri=
c I/O mode setup
Jul 16 17:56:05 tokeiihto kernel: [    0.004000] Switched APIC routing to=
 physical flat.
Jul 16 17:56:05 tokeiihto kernel: [    0.004000] ..TIMER: vector=3D0x30 a=
pic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Jul 16 17:56:05 tokeiihto kernel: [    0.024000] tsc: Fast TSC calibratio=
n failed
Jul 16 17:56:05 tokeiihto kernel: [    0.032000] tsc: PIT calibration mat=
ches HPET. 1 loops
Jul 16 17:56:05 tokeiihto kernel: [    0.032000] tsc: Detected 3499.996 M=
Hz processor
Jul 16 17:56:05 tokeiihto kernel: [    0.032000] clocksource: tsc-early: =
mask: 0xffffffffffffffff max_cycles: 0x32734d20948, max_idle_ns: 44079530=
6379 ns
Jul 16 17:56:05 tokeiihto kernel: [    0.032000] Calibrating delay loop (=
skipped), value calculated using timer frequency.. 6999.99 BogoMIPS (lpj=3D=
13999984)
Jul 16 17:56:05 tokeiihto kernel: [    0.032000] pid_max: default: 32768 =
minimum: 301
Jul 16 17:56:05 tokeiihto kernel: [    0.036046] Security Framework initi=
alized
Jul 16 17:56:05 tokeiihto kernel: [    0.036049] Yama: disabled by defaul=
t; enable with sysctl kernel.yama.*
Jul 16 17:56:05 tokeiihto kernel: [    0.036119] AppArmor: AppArmor initi=
alized
Jul 16 17:56:05 tokeiihto kernel: [    0.038556] Dentry cache hash table =
entries: 2097152 (order: 12, 16777216 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.039783] Inode-cache hash table e=
ntries: 1048576 (order: 11, 8388608 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.039891] Mount-cache hash table e=
ntries: 32768 (order: 6, 262144 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.039930] Mountpoint-cache hash ta=
ble entries: 32768 (order: 6, 262144 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.040320] CPU: Physical Processor =
ID: 0
Jul 16 17:56:05 tokeiihto kernel: [    0.040322] CPU: Processor Core ID: =
0
Jul 16 17:56:05 tokeiihto kernel: [    0.040430] mce: CPU supports 23 MCE=
 banks
Jul 16 17:56:05 tokeiihto kernel: [    0.040447] LVT offset 1 assigned fo=
r vector 0xf9
Jul 16 17:56:05 tokeiihto kernel: [    0.040495] LVT offset 2 assigned fo=
r vector 0xf4
Jul 16 17:56:05 tokeiihto kernel: [    0.040506] Last level iTLB entries:=
 4KB 1024, 2MB 1024, 4MB 512
Jul 16 17:56:05 tokeiihto kernel: [    0.040507] Last level dTLB entries:=
 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
Jul 16 17:56:05 tokeiihto kernel: [    0.040509] Spectre V2 : Mitigation:=
 Full AMD retpoline
Jul 16 17:56:05 tokeiihto kernel: [    0.040511] Spectre V2 : Spectre v2 =
mitigation: Enabling Indirect Branch Prediction Barrier
Jul 16 17:56:05 tokeiihto kernel: [    0.040513] Speculative Store Bypass=
: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
Jul 16 17:56:05 tokeiihto kernel: [    0.045215] Freeing SMP alternatives=
 memory: 24K
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] smpboot: CPU0: AMD Ryzen=
 3 2200G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: =
0x0)
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] Performance Events: Fam1=
7h core perfctr, AMD PMU driver.
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... version:            =
    0
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... bit width:          =
    48
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... generic registers:  =
    6
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... value mask:         =
    0000ffffffffffff
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... max period:         =
    00007fffffffffff
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... fixed-purpose events=
:   0
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] ... event mask:         =
    000000000000003f
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] Hierarchical SRCU implem=
entation.
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] smp: Bringing up seconda=
ry CPUs ...
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] x86: Booting SMP configu=
ration:
Jul 16 17:56:05 tokeiihto kernel: [    0.052000] .... node  #0, CPUs:    =
    #1
Jul 16 17:56:05 tokeiihto kernel: [    0.052013] NMI watchdog: Enabled. P=
ermanently consumes one hw-PMU counter.
Jul 16 17:56:05 tokeiihto kernel: [    0.052150]   #2  #3
Jul 16 17:56:05 tokeiihto kernel: [    0.058326] smp: Brought up 1 node, =
4 CPUs
Jul 16 17:56:05 tokeiihto kernel: [    0.058326] smpboot: Max logical pac=
kages: 4
Jul 16 17:56:05 tokeiihto kernel: [    0.058326] smpboot: Total of 4 proc=
essors activated (27999.96 BogoMIPS)
Jul 16 17:56:05 tokeiihto kernel: [    0.058326] devtmpfs: initialized
Jul 16 17:56:05 tokeiihto kernel: [    0.058326] x86/mm: Memory block siz=
e: 128MB
Jul 16 17:56:05 tokeiihto kernel: [    0.060962] PM: Registering ACPI NVS=
 region [mem 0x04000000-0x04009fff] (40960 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.060962] PM: Registering ACPI NVS=
 region [mem 0x9d3c7000-0x9d78ffff] (3969024 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.060962] clocksource: jiffies: ma=
sk: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Jul 16 17:56:05 tokeiihto kernel: [    0.060962] futex hash table entries=
: 4096 (order: 6, 262144 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.060962] pinctrl core: initialize=
d pinctrl subsystem
Jul 16 17:56:05 tokeiihto kernel: [    0.061551] NET: Registered protocol=
 family 16
Jul 16 17:56:05 tokeiihto kernel: [    0.061623] audit: initializing netl=
ink subsys (disabled)
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] audit: type=3D2000 audit=
(1531756550.060:1): state=3Dinitialized audit_enabled=3D0 res=3D1
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] cpuidle: using governor =
ladder
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] cpuidle: using governor =
menu
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] ACPI: bus type PCI regis=
tered
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] acpiphp: ACPI Hot Plug P=
CI Controller Driver version: 0.5
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] PCI: MMCONFIG for domain=
 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] PCI: MMCONFIG at [mem 0x=
f8000000-0xfbffffff] reserved in E820
Jul 16 17:56:05 tokeiihto kernel: [    0.061628] PCI: Using configuration=
 type 1 for base access
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] HugeTLB registered 1.00 =
GiB page size, pre-allocated 0 pages
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] HugeTLB registered 2.00 =
MiB page size, pre-allocated 0 pages
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI: Added _OSI(Module =
Device)
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI: Added _OSI(Process=
or Device)
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI: Added _OSI(3.0 _SC=
P Extensions)
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI: Added _OSI(Process=
or Aggregator Device)
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI BIOS Error (bug): F=
ailure looking up [\PTOS], AE_NOT_FOUND (20180105/psargs-364)
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI Error: Method parse=
/execution failed \, AE_NOT_FOUND (20180105/psparse-550)
Jul 16 17:56:05 tokeiihto kernel: [    0.064552] ACPI: Executed 2 blocks =
of module-level executable AML code
Jul 16 17:56:05 tokeiihto kernel: [    0.068261] ACPI: [Firmware Bug]: BI=
OS _OSI(Linux) query ignored
Jul 16 17:56:05 tokeiihto kernel: [    0.070048] ACPI: Interpreter enable=
d
Jul 16 17:56:05 tokeiihto kernel: [    0.070063] ACPI: (supports S0 S3 S4=
 S5)
Jul 16 17:56:05 tokeiihto kernel: [    0.070065] ACPI: Using IOAPIC for i=
nterrupt routing
Jul 16 17:56:05 tokeiihto kernel: [    0.070315] PCI: Using host bridge w=
indows from ACPI; if necessary, use "pci=3Dnocrs" and report a bug
Jul 16 17:56:05 tokeiihto kernel: [    0.070558] ACPI: Enabled 2 GPEs in =
block 00 to 1F
Jul 16 17:56:05 tokeiihto kernel: [    0.072341] ACPI: Power Resource [P0=
ST] (on)
Jul 16 17:56:05 tokeiihto kernel: [    0.072360] ACPI: Power Resource [P3=
ST] (on)
Jul 16 17:56:05 tokeiihto kernel: [    0.076535] ACPI: PCI Root Bridge [P=
CI0] (domain 0000 [bus 00-ff])
Jul 16 17:56:05 tokeiihto kernel: [    0.076540] acpi PNP0A08:00: _OSC: O=
S supports [ExtendedConfig ASPM ClockPM Segments MSI]
Jul 16 17:56:05 tokeiihto kernel: [    0.076679] acpi PNP0A08:00: _OSC: O=
S now controls [PCIeHotplug PME AER PCIeCapability]
Jul 16 17:56:05 tokeiihto kernel: [    0.076688] acpi PNP0A08:00: [Firmwa=
re Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this=
 bridge
Jul 16 17:56:05 tokeiihto kernel: [    0.076921] PCI host bridge to bus 0=
000:00
Jul 16 17:56:05 tokeiihto kernel: [    0.076924] pci_bus 0000:00: root bu=
s resource [io  0x0000-0x03af window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076926] pci_bus 0000:00: root bu=
s resource [io  0x03e0-0x0cf7 window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076928] pci_bus 0000:00: root bu=
s resource [io  0x03b0-0x03df window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076930] pci_bus 0000:00: root bu=
s resource [io  0x0d00-0xffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076932] pci_bus 0000:00: root bu=
s resource [mem 0x000a0000-0x000bffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076934] pci_bus 0000:00: root bu=
s resource [mem 0x000c0000-0x000dffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076937] pci_bus 0000:00: root bu=
s resource [mem 0xe0000000-0xfec2ffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076939] pci_bus 0000:00: root bu=
s resource [mem 0xfee00000-0xffffffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.076941] pci_bus 0000:00: root bu=
s resource [bus 00-ff]
Jul 16 17:56:05 tokeiihto kernel: [    0.076951] pci 0000:00:00.0: [1022:=
15d0] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.077068] pci 0000:00:00.2: [1022:=
15d1] type 00 class 0x080600
Jul 16 17:56:05 tokeiihto kernel: [    0.077208] pci 0000:00:01.0: [1022:=
1452] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.077312] pci 0000:00:01.2: [1022:=
15d3] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.077415] pci 0000:00:01.2: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.077523] pci 0000:00:08.0: [1022:=
1452] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.077624] pci 0000:00:08.1: [1022:=
15db] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.077676] pci 0000:00:08.1: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.077734] pci 0000:00:08.1: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.077813] pci 0000:00:08.2: [1022:=
15dc] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.077863] pci 0000:00:08.2: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.077915] pci 0000:00:08.2: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.078023] pci 0000:00:14.0: [1022:=
790b] type 00 class 0x0c0500
Jul 16 17:56:05 tokeiihto kernel: [    0.078190] pci 0000:00:14.3: [1022:=
790e] type 00 class 0x060100
Jul 16 17:56:05 tokeiihto kernel: [    0.078369] pci 0000:00:18.0: [1022:=
15e8] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078411] pci 0000:00:18.1: [1022:=
15e9] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078459] pci 0000:00:18.2: [1022:=
15ea] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078501] pci 0000:00:18.3: [1022:=
15eb] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078542] pci 0000:00:18.4: [1022:=
15ec] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078583] pci 0000:00:18.5: [1022:=
15ed] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078631] pci 0000:00:18.6: [1022:=
15ee] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078679] pci 0000:00:18.7: [1022:=
15ef] type 00 class 0x060000
Jul 16 17:56:05 tokeiihto kernel: [    0.078797] pci 0000:15:00.0: [1022:=
43bb] type 00 class 0x0c0330
Jul 16 17:56:05 tokeiihto kernel: [    0.078826] pci 0000:15:00.0: reg 0x=
10: [mem 0xfe8a0000-0xfe8a7fff 64bit]
Jul 16 17:56:05 tokeiihto kernel: [    0.078929] pci 0000:15:00.0: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.079021] pci 0000:15:00.1: [1022:=
43b7] type 00 class 0x010601
Jul 16 17:56:05 tokeiihto kernel: [    0.079084] pci 0000:15:00.1: reg 0x=
24: [mem 0xfe880000-0xfe89ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.079093] pci 0000:15:00.1: reg 0x=
30: [mem 0xfe800000-0xfe87ffff pref]
Jul 16 17:56:05 tokeiihto kernel: [    0.079145] pci 0000:15:00.1: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.079208] pci 0000:15:00.2: [1022:=
43b2] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.079307] pci 0000:15:00.2: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.092028] pci 0000:00:01.2: PCI br=
idge to [bus 15-1b]
Jul 16 17:56:05 tokeiihto kernel: [    0.092036] pci 0000:00:01.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.092039] pci 0000:00:01.2:   brid=
ge window [mem 0xfe700000-0xfe8fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.092136] pci 0000:16:00.0: [1022:=
43b4] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.092255] pci 0000:16:00.0: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.092344] pci 0000:16:01.0: [1022:=
43b4] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.092461] pci 0000:16:01.0: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.092559] pci 0000:16:04.0: [1022:=
43b4] type 01 class 0x060400
Jul 16 17:56:05 tokeiihto kernel: [    0.092677] pci 0000:16:04.0: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.092802] pci 0000:15:00.2: PCI br=
idge to [bus 16-1b]
Jul 16 17:56:05 tokeiihto kernel: [    0.092811] pci 0000:15:00.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.092815] pci 0000:15:00.2:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.092876] pci 0000:16:00.0: PCI br=
idge to [bus 17]
Jul 16 17:56:05 tokeiihto kernel: [    0.092971] pci 0000:18:00.0: [10ec:=
8168] type 00 class 0x020000
Jul 16 17:56:05 tokeiihto kernel: [    0.093024] pci 0000:18:00.0: reg 0x=
10: [io  0xf000-0xf0ff]
Jul 16 17:56:05 tokeiihto kernel: [    0.093071] pci 0000:18:00.0: reg 0x=
18: [mem 0xfe704000-0xfe704fff 64bit]
Jul 16 17:56:05 tokeiihto kernel: [    0.093099] pci 0000:18:00.0: reg 0x=
20: [mem 0xfe700000-0xfe703fff 64bit]
Jul 16 17:56:05 tokeiihto kernel: [    0.093262] pci 0000:18:00.0: suppor=
ts D1 D2
Jul 16 17:56:05 tokeiihto kernel: [    0.093263] pci 0000:18:00.0: PME# s=
upported from D0 D1 D2 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.104047] pci 0000:16:01.0: PCI br=
idge to [bus 18]
Jul 16 17:56:05 tokeiihto kernel: [    0.104056] pci 0000:16:01.0:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.104060] pci 0000:16:01.0:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.104129] pci 0000:16:04.0: PCI br=
idge to [bus 1b]
Jul 16 17:56:05 tokeiihto kernel: [    0.104294] pci 0000:38:00.0: [1002:=
15dd] type 00 class 0x030000
Jul 16 17:56:05 tokeiihto kernel: [    0.104346] pci 0000:38:00.0: reg 0x=
10: [mem 0xe0000000-0xefffffff 64bit pref]
Jul 16 17:56:05 tokeiihto kernel: [    0.104367] pci 0000:38:00.0: reg 0x=
18: [mem 0xf0000000-0xf01fffff 64bit pref]
Jul 16 17:56:05 tokeiihto kernel: [    0.104380] pci 0000:38:00.0: reg 0x=
20: [io  0xe000-0xe0ff]
Jul 16 17:56:05 tokeiihto kernel: [    0.104394] pci 0000:38:00.0: reg 0x=
24: [mem 0xfe600000-0xfe67ffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.104417] pci 0000:38:00.0: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.104435] pci 0000:38:00.0: BAR 0:=
 assigned to efifb
Jul 16 17:56:05 tokeiihto kernel: [    0.104544] pci 0000:38:00.0: PME# s=
upported from D1 D2 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.104675] pci 0000:38:00.1: [1002:=
15de] type 00 class 0x040300
Jul 16 17:56:05 tokeiihto kernel: [    0.104708] pci 0000:38:00.1: reg 0x=
10: [mem 0xfe688000-0xfe68bfff]
Jul 16 17:56:05 tokeiihto kernel: [    0.104791] pci 0000:38:00.1: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.104872] pci 0000:38:00.1: PME# s=
upported from D1 D2 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.104960] pci 0000:38:00.2: [1022:=
15df] type 00 class 0x108000
Jul 16 17:56:05 tokeiihto kernel: [    0.105017] pci 0000:38:00.2: reg 0x=
18: [mem 0xfe500000-0xfe5fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.105054] pci 0000:38:00.2: reg 0x=
24: [mem 0xfe68c000-0xfe68dfff]
Jul 16 17:56:05 tokeiihto kernel: [    0.105077] pci 0000:38:00.2: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.105241] pci 0000:38:00.3: [1022:=
15e0] type 00 class 0x0c0330
Jul 16 17:56:05 tokeiihto kernel: [    0.105281] pci 0000:38:00.3: reg 0x=
10: [mem 0xfe400000-0xfe4fffff 64bit]
Jul 16 17:56:05 tokeiihto kernel: [    0.105352] pci 0000:38:00.3: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.105441] pci 0000:38:00.3: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.105530] pci 0000:38:00.4: [1022:=
15e1] type 00 class 0x0c0330
Jul 16 17:56:05 tokeiihto kernel: [    0.105570] pci 0000:38:00.4: reg 0x=
10: [mem 0xfe300000-0xfe3fffff 64bit]
Jul 16 17:56:05 tokeiihto kernel: [    0.105641] pci 0000:38:00.4: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.105730] pci 0000:38:00.4: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.105821] pci 0000:38:00.6: [1022:=
15e3] type 00 class 0x040300
Jul 16 17:56:05 tokeiihto kernel: [    0.105854] pci 0000:38:00.6: reg 0x=
10: [mem 0xfe680000-0xfe687fff]
Jul 16 17:56:05 tokeiihto kernel: [    0.105937] pci 0000:38:00.6: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.106018] pci 0000:38:00.6: PME# s=
upported from D0 D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.106192] pci 0000:00:08.1: PCI br=
idge to [bus 38]
Jul 16 17:56:05 tokeiihto kernel: [    0.106200] pci 0000:00:08.1:   brid=
ge window [io  0xe000-0xefff]
Jul 16 17:56:05 tokeiihto kernel: [    0.106204] pci 0000:00:08.1:   brid=
ge window [mem 0xfe300000-0xfe6fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.106211] pci 0000:00:08.1:   brid=
ge window [mem 0xe0000000-0xf01fffff 64bit pref]
Jul 16 17:56:05 tokeiihto kernel: [    0.106308] pci 0000:39:00.0: [1022:=
7901] type 00 class 0x010601
Jul 16 17:56:05 tokeiihto kernel: [    0.106403] pci 0000:39:00.0: reg 0x=
24: [mem 0xfe900000-0xfe9007ff]
Jul 16 17:56:05 tokeiihto kernel: [    0.106426] pci 0000:39:00.0: enabli=
ng Extended Tags
Jul 16 17:56:05 tokeiihto kernel: [    0.106513] pci 0000:39:00.0: PME# s=
upported from D3hot D3cold
Jul 16 17:56:05 tokeiihto kernel: [    0.106634] pci 0000:00:08.2: PCI br=
idge to [bus 39]
Jul 16 17:56:05 tokeiihto kernel: [    0.106644] pci 0000:00:08.2:   brid=
ge window [mem 0xfe900000-0xfe9fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.107124] ACPI: PCI Interrupt Link=
 [LNKA] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107175] ACPI: PCI Interrupt Link=
 [LNKB] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107217] ACPI: PCI Interrupt Link=
 [LNKC] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107273] ACPI: PCI Interrupt Link=
 [LNKD] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107321] ACPI: PCI Interrupt Link=
 [LNKE] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107361] ACPI: PCI Interrupt Link=
 [LNKF] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107400] ACPI: PCI Interrupt Link=
 [LNKG] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.107439] ACPI: PCI Interrupt Link=
 [LNKH] (IRQs 4 5 7 10 11 14 15) *0
Jul 16 17:56:05 tokeiihto kernel: [    0.108019] pci 0000:38:00.0: vgaarb=
: setting as boot VGA device
Jul 16 17:56:05 tokeiihto kernel: [    0.108023] pci 0000:38:00.0: vgaarb=
: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Jul 16 17:56:05 tokeiihto kernel: [    0.108027] pci 0000:38:00.0: vgaarb=
: bridge control possible
Jul 16 17:56:05 tokeiihto kernel: [    0.108029] vgaarb: loaded
Jul 16 17:56:05 tokeiihto kernel: [    0.108029] pps_core: LinuxPPS API v=
er. 1 registered
Jul 16 17:56:05 tokeiihto kernel: [    0.108029] pps_core: Software ver. =
5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Jul 16 17:56:05 tokeiihto kernel: [    0.108029] PTP clock support regist=
ered
Jul 16 17:56:05 tokeiihto kernel: [    0.108029] EDAC MC: Ver: 3.0.0
Jul 16 17:56:05 tokeiihto kernel: [    0.108142] Registered efivars opera=
tions
Jul 16 17:56:05 tokeiihto kernel: [    0.128479] PCI: Using ACPI for IRQ =
routing
Jul 16 17:56:05 tokeiihto kernel: [    0.130501] PCI: pci_cache_line_size=
 set to 64 bytes
Jul 16 17:56:05 tokeiihto kernel: [    0.130579] e820: reserve RAM buffer=
 [mem 0x09d80000-0x0bffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.130580] e820: reserve RAM buffer=
 [mem 0x0b000000-0x0bffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.130580] e820: reserve RAM buffer=
 [mem 0x9d1e5000-0x9fffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.130581] e820: reserve RAM buffer=
 [mem 0x9d3c7000-0x9fffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.130581] e820: reserve RAM buffer=
 [mem 0x9f000000-0x9fffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.130582] e820: reserve RAM buffer=
 [mem 0x41f340000-0x41fffffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.132072] hpet0: at MMIO 0xfed0000=
0, IRQs 2, 8, 0
Jul 16 17:56:05 tokeiihto kernel: [    0.132082] hpet0: 3 comparators, 32=
-bit 14.318180 MHz counter
Jul 16 17:56:05 tokeiihto kernel: [    0.134117] clocksource: Switched to=
 clocksource tsc-early
Jul 16 17:56:05 tokeiihto kernel: [    0.141481] VFS: Disk quotas dquot_6=
=2E6.0
Jul 16 17:56:05 tokeiihto kernel: [    0.141524] VFS: Dquot-cache hash ta=
ble entries: 512 (order 0, 4096 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.141679] AppArmor: AppArmor Files=
ystem Enabled
Jul 16 17:56:05 tokeiihto kernel: [    0.141693] pnp: PnP ACPI init
Jul 16 17:56:05 tokeiihto kernel: [    0.141839] system 00:00: [mem 0xf80=
00000-0xfbffffff] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.141844] system 00:00: Plug and P=
lay ACPI device, IDs PNP0c01 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.141902] system 00:01: [mem 0xfeb=
80000-0xfebfffff] could not be reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.141906] system 00:01: Plug and P=
lay ACPI device, IDs PNP0c02 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.141989] pnp 00:02: Plug and Play=
 ACPI device, IDs PNP0b00 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.142118] system 00:03: [io  0x0a0=
0-0x0a0f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142121] system 00:03: [io  0x0a1=
0-0x0a1f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142123] system 00:03: [io  0x0a2=
0-0x0a2f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142125] system 00:03: [io  0x0a4=
0-0x0a4f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142128] system 00:03: Plug and P=
lay ACPI device, IDs PNP0c02 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.142366] pnp 00:04: [dma 0 disabl=
ed]
Jul 16 17:56:05 tokeiihto kernel: [    0.142440] pnp 00:04: Plug and Play=
 ACPI device, IDs PNP0400 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.142625] pnp 00:05: [dma 0 disabl=
ed]
Jul 16 17:56:05 tokeiihto kernel: [    0.142667] pnp 00:05: Plug and Play=
 ACPI device, IDs PNP0501 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.142814] system 00:06: [io  0x04d=
0-0x04d1] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142817] system 00:06: [io  0x040=
b] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142819] system 00:06: [io  0x04d=
6] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142821] system 00:06: [io  0x0c0=
0-0x0c01] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142823] system 00:06: [io  0x0c1=
4] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142825] system 00:06: [io  0x0c5=
0-0x0c51] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142827] system 00:06: [io  0x0c5=
2] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142829] system 00:06: [io  0x0c6=
c] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142831] system 00:06: [io  0x0c6=
f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142832] system 00:06: [io  0x0cd=
0-0x0cd1] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142834] system 00:06: [io  0x0cd=
2-0x0cd3] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142836] system 00:06: [io  0x0cd=
4-0x0cd5] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142838] system 00:06: [io  0x0cd=
6-0x0cd7] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142840] system 00:06: [io  0x0cd=
8-0x0cdf] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142842] system 00:06: [io  0x080=
0-0x089f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142844] system 00:06: [io  0x0b0=
0-0x0b0f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142846] system 00:06: [io  0x0b2=
0-0x0b3f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142848] system 00:06: [io  0x090=
0-0x090f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142849] system 00:06: [io  0x091=
0-0x091f] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142852] system 00:06: [mem 0xfec=
00000-0xfec00fff] could not be reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142854] system 00:06: [mem 0xfec=
01000-0xfec01fff] could not be reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142856] system 00:06: [mem 0xfed=
c0000-0xfedc0fff] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142858] system 00:06: [mem 0xfee=
00000-0xfee00fff] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142860] system 00:06: [mem 0xfed=
80000-0xfed8ffff] could not be reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142862] system 00:06: [mem 0xfec=
10000-0xfec10fff] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142864] system 00:06: [mem 0xff0=
00000-0xffffffff] has been reserved
Jul 16 17:56:05 tokeiihto kernel: [    0.142868] system 00:06: Plug and P=
lay ACPI device, IDs PNP0c02 (active)
Jul 16 17:56:05 tokeiihto kernel: [    0.143152] pnp: PnP ACPI: found 7 d=
evices
Jul 16 17:56:05 tokeiihto kernel: [    0.148968] clocksource: acpi_pm: ma=
sk: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Jul 16 17:56:05 tokeiihto kernel: [    0.149036] pci 0000:16:00.0: PCI br=
idge to [bus 17]
Jul 16 17:56:05 tokeiihto kernel: [    0.149050] pci 0000:16:01.0: PCI br=
idge to [bus 18]
Jul 16 17:56:05 tokeiihto kernel: [    0.149053] pci 0000:16:01.0:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149059] pci 0000:16:01.0:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149069] pci 0000:16:04.0: PCI br=
idge to [bus 1b]
Jul 16 17:56:05 tokeiihto kernel: [    0.149082] pci 0000:15:00.2: PCI br=
idge to [bus 16-1b]
Jul 16 17:56:05 tokeiihto kernel: [    0.149085] pci 0000:15:00.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149090] pci 0000:15:00.2:   brid=
ge window [mem 0xfe700000-0xfe7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149099] pci 0000:00:01.2: PCI br=
idge to [bus 15-1b]
Jul 16 17:56:05 tokeiihto kernel: [    0.149102] pci 0000:00:01.2:   brid=
ge window [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149107] pci 0000:00:01.2:   brid=
ge window [mem 0xfe700000-0xfe8fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149117] pci 0000:00:08.1: PCI br=
idge to [bus 38]
Jul 16 17:56:05 tokeiihto kernel: [    0.149120] pci 0000:00:08.1:   brid=
ge window [io  0xe000-0xefff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149125] pci 0000:00:08.1:   brid=
ge window [mem 0xfe300000-0xfe6fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149130] pci 0000:00:08.1:   brid=
ge window [mem 0xe0000000-0xf01fffff 64bit pref]
Jul 16 17:56:05 tokeiihto kernel: [    0.149137] pci 0000:00:08.2: PCI br=
idge to [bus 39]
Jul 16 17:56:05 tokeiihto kernel: [    0.149142] pci 0000:00:08.2:   brid=
ge window [mem 0xfe900000-0xfe9fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149152] pci_bus 0000:00: resourc=
e 4 [io  0x0000-0x03af window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149153] pci_bus 0000:00: resourc=
e 5 [io  0x03e0-0x0cf7 window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149154] pci_bus 0000:00: resourc=
e 6 [io  0x03b0-0x03df window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149155] pci_bus 0000:00: resourc=
e 7 [io  0x0d00-0xffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149156] pci_bus 0000:00: resourc=
e 8 [mem 0x000a0000-0x000bffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149157] pci_bus 0000:00: resourc=
e 9 [mem 0x000c0000-0x000dffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149158] pci_bus 0000:00: resourc=
e 10 [mem 0xe0000000-0xfec2ffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149159] pci_bus 0000:00: resourc=
e 11 [mem 0xfee00000-0xffffffff window]
Jul 16 17:56:05 tokeiihto kernel: [    0.149160] pci_bus 0000:15: resourc=
e 0 [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149161] pci_bus 0000:15: resourc=
e 1 [mem 0xfe700000-0xfe8fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149162] pci_bus 0000:16: resourc=
e 0 [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149162] pci_bus 0000:16: resourc=
e 1 [mem 0xfe700000-0xfe7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149163] pci_bus 0000:18: resourc=
e 0 [io  0xf000-0xffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149164] pci_bus 0000:18: resourc=
e 1 [mem 0xfe700000-0xfe7fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149165] pci_bus 0000:38: resourc=
e 0 [io  0xe000-0xefff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149166] pci_bus 0000:38: resourc=
e 1 [mem 0xfe300000-0xfe6fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149167] pci_bus 0000:38: resourc=
e 2 [mem 0xe0000000-0xf01fffff 64bit pref]
Jul 16 17:56:05 tokeiihto kernel: [    0.149168] pci_bus 0000:39: resourc=
e 1 [mem 0xfe900000-0xfe9fffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.149349] NET: Registered protocol=
 family 2
Jul 16 17:56:05 tokeiihto kernel: [    0.149584] tcp_listen_portaddr_hash=
 hash table entries: 8192 (order: 5, 131072 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.149633] TCP established hash tab=
le entries: 131072 (order: 8, 1048576 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.149798] TCP bind hash table entr=
ies: 65536 (order: 8, 1048576 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.149928] TCP: Hash tables configu=
red (established 131072 bind 65536)
Jul 16 17:56:05 tokeiihto kernel: [    0.149971] UDP hash table entries: =
8192 (order: 6, 262144 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.150008] UDP-Lite hash table entr=
ies: 8192 (order: 6, 262144 bytes)
Jul 16 17:56:05 tokeiihto kernel: [    0.150111] NET: Registered protocol=
 family 1
Jul 16 17:56:05 tokeiihto kernel: [    0.150275] pci 0000:38:00.0: Video =
device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Jul 16 17:56:05 tokeiihto kernel: [    0.150477] PCI: CLS 64 bytes, defau=
lt 64
Jul 16 17:56:05 tokeiihto kernel: [    0.150504] Unpacking initramfs...
Jul 16 17:56:05 tokeiihto kernel: [    0.454352] Freeing initrd memory: 2=
5356K
Jul 16 17:56:05 tokeiihto kernel: [    0.454397] AMD-Vi: Unable to write =
to IOMMU perf counter.
Jul 16 17:56:05 tokeiihto kernel: [    0.454516] pci 0000:00:00.2: can't =
derive routing for PCI INT A
Jul 16 17:56:05 tokeiihto kernel: [    0.454518] pci 0000:00:00.2: PCI IN=
T A: not connected
Jul 16 17:56:05 tokeiihto kernel: [    0.454957] iommu: Adding device 000=
0:00:01.0 to group 0
Jul 16 17:56:05 tokeiihto kernel: [    0.455162] iommu: Adding device 000=
0:00:01.2 to group 1
Jul 16 17:56:05 tokeiihto kernel: [    0.455383] iommu: Adding device 000=
0:00:08.0 to group 2
Jul 16 17:56:05 tokeiihto kernel: [    0.455585] iommu: Adding device 000=
0:00:08.1 to group 3
Jul 16 17:56:05 tokeiihto kernel: [    0.455605] iommu: Adding device 000=
0:00:08.2 to group 2
Jul 16 17:56:05 tokeiihto kernel: [    0.455792] iommu: Adding device 000=
0:00:14.0 to group 4
Jul 16 17:56:05 tokeiihto kernel: [    0.455808] iommu: Adding device 000=
0:00:14.3 to group 4
Jul 16 17:56:05 tokeiihto kernel: [    0.456023] iommu: Adding device 000=
0:00:18.0 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456039] iommu: Adding device 000=
0:00:18.1 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456054] iommu: Adding device 000=
0:00:18.2 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456069] iommu: Adding device 000=
0:00:18.3 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456084] iommu: Adding device 000=
0:00:18.4 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456098] iommu: Adding device 000=
0:00:18.5 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456113] iommu: Adding device 000=
0:00:18.6 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456137] iommu: Adding device 000=
0:00:18.7 to group 5
Jul 16 17:56:05 tokeiihto kernel: [    0.456347] iommu: Adding device 000=
0:15:00.0 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456377] iommu: Adding device 000=
0:15:00.1 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456406] iommu: Adding device 000=
0:15:00.2 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456423] iommu: Adding device 000=
0:16:00.0 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456440] iommu: Adding device 000=
0:16:01.0 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456464] iommu: Adding device 000=
0:16:04.0 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456492] iommu: Adding device 000=
0:18:00.0 to group 6
Jul 16 17:56:05 tokeiihto kernel: [    0.456764] iommu: Adding device 000=
0:38:00.0 to group 7
Jul 16 17:56:05 tokeiihto kernel: [    0.456844] iommu: Using direct mapp=
ing for device 0000:38:00.0
Jul 16 17:56:05 tokeiihto kernel: [    0.456939] iommu: Adding device 000=
0:38:00.1 to group 8
Jul 16 17:56:05 tokeiihto kernel: [    0.456974] iommu: Adding device 000=
0:38:00.2 to group 8
Jul 16 17:56:05 tokeiihto kernel: [    0.457010] iommu: Adding device 000=
0:38:00.3 to group 8
Jul 16 17:56:05 tokeiihto kernel: [    0.457051] iommu: Adding device 000=
0:38:00.4 to group 8
Jul 16 17:56:05 tokeiihto kernel: [    0.457086] iommu: Adding device 000=
0:38:00.6 to group 8
Jul 16 17:56:05 tokeiihto kernel: [    0.457102] iommu: Adding device 000=
0:39:00.0 to group 2
Jul 16 17:56:05 tokeiihto kernel: [    0.457356] AMD-Vi: Found IOMMU at 0=
000:00:00.2 cap 0x40
Jul 16 17:56:05 tokeiihto kernel: [    0.457358] AMD-Vi: Extended feature=
s (0x4f77ef22294ada):
Jul 16 17:56:05 tokeiihto kernel: [    0.457359]  PPR NX GT IA GA PC GA_v=
APIC
Jul 16 17:56:05 tokeiihto kernel: [    0.457362] AMD-Vi: Interrupt remapp=
ing enabled
Jul 16 17:56:05 tokeiihto kernel: [    0.457363] AMD-Vi: virtual APIC ena=
bled
Jul 16 17:56:05 tokeiihto kernel: [    0.551588] AMD-Vi: Lazy IO/TLB flus=
hing enabled
Jul 16 17:56:05 tokeiihto kernel: [    0.552445] amd_uncore: AMD NB count=
ers detected
Jul 16 17:56:05 tokeiihto kernel: [    0.552456] amd_uncore: AMD LLC coun=
ters detected
Jul 16 17:56:05 tokeiihto kernel: [    0.553648] Initialise system truste=
d keyrings
Jul 16 17:56:05 tokeiihto kernel: [    0.553804] workingset: timestamp_bi=
ts=3D40 max_order=3D22 bucket_order=3D0
Jul 16 17:56:05 tokeiihto kernel: [    0.555511] zbud: loaded
Jul 16 17:56:05 tokeiihto kernel: [    0.737855] Key type asymmetric regi=
stered
Jul 16 17:56:05 tokeiihto kernel: [    0.737861] Asymmetric key parser 'x=
509' registered
Jul 16 17:56:05 tokeiihto kernel: [    0.737939] Block layer SCSI generic=
 (bsg) driver version 0.4 loaded (major 248)
Jul 16 17:56:05 tokeiihto kernel: [    0.738017] io scheduler noop regist=
ered
Jul 16 17:56:05 tokeiihto kernel: [    0.738022] io scheduler deadline re=
gistered
Jul 16 17:56:05 tokeiihto kernel: [    0.738138] io scheduler cfq registe=
red (default)
Jul 16 17:56:05 tokeiihto kernel: [    0.738140] io scheduler mq-deadline=
 registered
Jul 16 17:56:05 tokeiihto kernel: [    0.739464] pcieport 0000:00:01.2: A=
ER enabled with IRQ 26
Jul 16 17:56:05 tokeiihto kernel: [    0.739481] pcieport 0000:00:01.2: S=
ignaling PME with IRQ 26
Jul 16 17:56:05 tokeiihto kernel: [    0.739515] pcieport 0000:00:08.1: S=
ignaling PME with IRQ 27
Jul 16 17:56:05 tokeiihto kernel: [    0.739549] pcieport 0000:00:08.2: S=
ignaling PME with IRQ 28
Jul 16 17:56:05 tokeiihto kernel: [    0.739572] efifb: probing for efifb=

Jul 16 17:56:05 tokeiihto kernel: [    0.739584] efifb: framebuffer at 0x=
e0000000, using 3072k, total 3072k
Jul 16 17:56:05 tokeiihto kernel: [    0.739586] efifb: mode is 1024x768x=
32, linelength=3D4096, pages=3D1
Jul 16 17:56:05 tokeiihto kernel: [    0.739588] efifb: scrolling: redraw=

Jul 16 17:56:05 tokeiihto kernel: [    0.739591] efifb: Truecolor: size=3D=
8:8:8:8, shift=3D24:16:8:0
Jul 16 17:56:05 tokeiihto kernel: [    0.741195] Console: switching to co=
lour frame buffer device 128x48
Jul 16 17:56:05 tokeiihto kernel: [    0.742760] fb0: EFI VGA frame buffe=
r device
Jul 16 17:56:05 tokeiihto kernel: [    0.742809] Monitor-Mwait will be us=
ed to enter C-1 state
Jul 16 17:56:05 tokeiihto kernel: [    0.743402] Serial: 8250/16550 drive=
r, 4 ports, IRQ sharing enabled
Jul 16 17:56:05 tokeiihto kernel: [    0.764327] 00:05: ttyS0 at I/O 0x3f=
8 (irq =3D 4, base_baud =3D 115200) is a 16550A
Jul 16 17:56:05 tokeiihto kernel: [    0.764641] Linux agpgart interface =
v0.103
Jul 16 17:56:05 tokeiihto kernel: [    0.764894] AMD IOMMUv2 driver by Jo=
erg Roedel <jroedel@suse.de>
Jul 16 17:56:05 tokeiihto kernel: [    0.765391] i8042: PNP: No PS/2 cont=
roller found.
Jul 16 17:56:05 tokeiihto kernel: [    0.765460] mousedev: PS/2 mouse dev=
ice common for all mice
Jul 16 17:56:05 tokeiihto kernel: [    0.765532] rtc_cmos 00:02: RTC can =
wake from S4
Jul 16 17:56:05 tokeiihto kernel: [    0.765728] rtc_cmos 00:02: rtc core=
: registered rtc_cmos as rtc0
Jul 16 17:56:05 tokeiihto kernel: [    0.765805] rtc_cmos 00:02: alarms u=
p to one month, y3k, 114 bytes nvram, hpet irqs
Jul 16 17:56:05 tokeiihto kernel: [    0.765886] ledtrig-cpu: registered =
to indicate activity on CPUs
Jul 16 17:56:05 tokeiihto kernel: [    0.766541] NET: Registered protocol=
 family 10
Jul 16 17:56:05 tokeiihto kernel: [    0.769771] Segment Routing with IPv=
6
Jul 16 17:56:05 tokeiihto kernel: [    0.769809] mip6: Mobile IPv6
Jul 16 17:56:05 tokeiihto kernel: [    0.769822] NET: Registered protocol=
 family 17
Jul 16 17:56:05 tokeiihto kernel: [    0.769841] mpls_gso: MPLS GSO suppo=
rt
Jul 16 17:56:05 tokeiihto kernel: [    0.770290] microcode: CPU0: patch_l=
evel=3D0x0810100b
Jul 16 17:56:05 tokeiihto kernel: [    0.770314] microcode: CPU1: patch_l=
evel=3D0x0810100b
Jul 16 17:56:05 tokeiihto kernel: [    0.770336] microcode: CPU2: patch_l=
evel=3D0x0810100b
Jul 16 17:56:05 tokeiihto kernel: [    0.770356] microcode: CPU3: patch_l=
evel=3D0x0810100b
Jul 16 17:56:05 tokeiihto kernel: [    0.770427] microcode: Microcode Upd=
ate Driver: v2.2.
Jul 16 17:56:05 tokeiihto kernel: [    0.770448] sched_clock: Marking sta=
ble (770423101, 0)->(857857771, -87434670)
Jul 16 17:56:05 tokeiihto kernel: [    0.770631] registered taskstats ver=
sion 1
Jul 16 17:56:05 tokeiihto kernel: [    0.771211] Loading compiled-in X.50=
9 certificates
Jul 16 17:56:05 tokeiihto kernel: [    0.794925] Loaded X.509 cert 'secur=
e-boot-test-key-lfaraone: 97c1b25cddf9873ca78a58f3d73bf727d2cf78ff'
Jul 16 17:56:05 tokeiihto kernel: [    0.795770] Loaded X.509 cert 'Debia=
n Project: Ben Hutchings: 008a018dca80932630'
Jul 16 17:56:05 tokeiihto kernel: [    0.796393] zswap: loaded using pool=
 lzo/zbud
Jul 16 17:56:05 tokeiihto kernel: [    0.797180] AppArmor: AppArmor sha1 =
policy hashing enabled
Jul 16 17:56:05 tokeiihto kernel: [    0.798412] rtc_cmos 00:02: setting =
system clock to 2018-07-16 15:55:51 UTC (1531756551)
Jul 16 17:56:05 tokeiihto kernel: [    1.072227] Freeing unused kernel me=
mory: 1524K
Jul 16 17:56:05 tokeiihto kernel: [    1.072730] Write protecting the ker=
nel read-only data: 16384k
Jul 16 17:56:05 tokeiihto kernel: [    1.074580] Freeing unused kernel me=
mory: 2024K
Jul 16 17:56:05 tokeiihto kernel: [    1.076388] Freeing unused kernel me=
mory: 960K
Jul 16 17:56:05 tokeiihto kernel: [    1.080506] x86/mm: Checked W+X mapp=
ings: passed, no W+X pages found.
Jul 16 17:56:05 tokeiihto kernel: [    1.136229] SCSI subsystem initializ=
ed
Jul 16 17:56:05 tokeiihto kernel: [    1.137219] piix4_smbus 0000:00:14.0=
: SMBus Host Controller at 0xb00, revision 0
Jul 16 17:56:05 tokeiihto kernel: [    1.137711] piix4_smbus 0000:00:14.0=
: Using register 0x02 for SMBus port selection
Jul 16 17:56:05 tokeiihto kernel: [    1.138344] ACPI: bus type USB regis=
tered
Jul 16 17:56:05 tokeiihto kernel: [    1.138861] usbcore: registered new =
interface driver usbfs
Jul 16 17:56:05 tokeiihto kernel: [    1.139368] usbcore: registered new =
interface driver hub
Jul 16 17:56:05 tokeiihto kernel: [    1.140090] libata version 3.00 load=
ed.
Jul 16 17:56:05 tokeiihto kernel: [    1.140376] usbcore: registered new =
device driver usb
Jul 16 17:56:05 tokeiihto kernel: [    1.141459] ahci 0000:15:00.1: versi=
on 3.0
Jul 16 17:56:05 tokeiihto kernel: [    1.141664] ahci 0000:15:00.1: SSS f=
lag set, parallel bus scan disabled
Jul 16 17:56:05 tokeiihto kernel: [    1.142214] ahci 0000:15:00.1: AHCI =
0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
Jul 16 17:56:05 tokeiihto kernel: [    1.142720] ahci 0000:15:00.1: flags=
: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds=
 apst=20
Jul 16 17:56:05 tokeiihto kernel: [    1.143362] cryptd: max_cpu_qlen set=
 to 1000
Jul 16 17:56:05 tokeiihto kernel: [    1.146214] r8169 Gigabit Ethernet d=
river 2.3LK-NAPI loaded
Jul 16 17:56:05 tokeiihto kernel: [    1.147186] scsi host0: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.147909] scsi host1: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.148825] scsi host2: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.149351] scsi host3: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.149850] scsi host4: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.150914] scsi host5: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.151415] scsi host6: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.151902] scsi host7: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.152349] ata1: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880100 irq 36
Jul 16 17:56:05 tokeiihto kernel: [    1.152750] ata2: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880180 irq 36
Jul 16 17:56:05 tokeiihto kernel: [    1.153137] ata3: DUMMY
Jul 16 17:56:05 tokeiihto kernel: [    1.153516] ata4: DUMMY
Jul 16 17:56:05 tokeiihto kernel: [    1.153891] ata5: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880300 irq 36
Jul 16 17:56:05 tokeiihto kernel: [    1.154283] ata6: SATA max UDMA/133 =
abar m131072@0xfe880000 port 0xfe880380 irq 36
Jul 16 17:56:05 tokeiihto kernel: [    1.154668] ata7: DUMMY
Jul 16 17:56:05 tokeiihto kernel: [    1.155053] ata8: DUMMY
Jul 16 17:56:05 tokeiihto kernel: [    1.155504] AVX2 version of gcm_enc/=
dec engaged.
Jul 16 17:56:05 tokeiihto kernel: [    1.155817] xhci_hcd 0000:15:00.0: x=
HCI Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.155880] ahci 0000:39:00.0: AHCI =
0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
Jul 16 17:56:05 tokeiihto kernel: [    1.155885] ahci 0000:39:00.0: flags=
: 64bit ncq sntf ilck led clo only pmp fbs pio=20
Jul 16 17:56:05 tokeiihto kernel: [    1.155895] AES CTR mode by8 optimiz=
ation enabled
Jul 16 17:56:05 tokeiihto kernel: [    1.156140] scsi host8: ahci
Jul 16 17:56:05 tokeiihto kernel: [    1.156315] xhci_hcd 0000:15:00.0: n=
ew USB bus registered, assigned bus number 1
Jul 16 17:56:05 tokeiihto kernel: [    1.156735] ata9: SATA max UDMA/133 =
abar m2048@0xfe900000 port 0xfe900100 irq 38
Jul 16 17:56:05 tokeiihto kernel: [    1.161099] r8169 0000:18:00.0 eth0:=
 RTL8168h/8111h at 0x        (ptrval), 30:9c:23:04:d6:98, XID 14100800 IR=
Q 39
Jul 16 17:56:05 tokeiihto kernel: [    1.161626] r8169 0000:18:00.0 eth0:=
 jumbo features [frames: 9200 bytes, tx checksumming: ko]
Jul 16 17:56:05 tokeiihto kernel: [    1.163585] r8169 0000:18:00.0 enp24=
s0: renamed from eth0
Jul 16 17:56:05 tokeiihto kernel: [    1.169756] alg: No test for pcbc(ae=
s) (pcbc-aes-aesni)
Jul 16 17:56:05 tokeiihto kernel: [    1.212478] xhci_hcd 0000:15:00.0: h=
cc params 0x0200ef81 hci version 0x110 quirks 0x48000410
Jul 16 17:56:05 tokeiihto kernel: [    1.213285] usb usb1: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0002
Jul 16 17:56:05 tokeiihto kernel: [    1.213902] usb usb1: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:56:05 tokeiihto kernel: [    1.214516] usb usb1: Product: xHCI =
Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.215139] usb usb1: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.215758] usb usb1: SerialNumber: =
0000:15:00.0
Jul 16 17:56:05 tokeiihto kernel: [    1.216516] hub 1-0:1.0: USB hub fou=
nd
Jul 16 17:56:05 tokeiihto kernel: [    1.217153] hub 1-0:1.0: 10 ports de=
tected
Jul 16 17:56:05 tokeiihto kernel: [    1.218236] xhci_hcd 0000:15:00.0: x=
HCI Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.218781] xhci_hcd 0000:15:00.0: n=
ew USB bus registered, assigned bus number 2
Jul 16 17:56:05 tokeiihto kernel: [    1.219322] xhci_hcd 0000:15:00.0: H=
ost supports USB 3.10 Enhanced SuperSpeed
Jul 16 17:56:05 tokeiihto kernel: [    1.219771] usb usb2: We don't know =
the algorithms for LPM for this host, disabling LPM.
Jul 16 17:56:05 tokeiihto kernel: [    1.220205] usb usb2: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0003
Jul 16 17:56:05 tokeiihto kernel: [    1.220633] usb usb2: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:56:05 tokeiihto kernel: [    1.221065] usb usb2: Product: xHCI =
Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.221487] usb usb2: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.221912] usb usb2: SerialNumber: =
0000:15:00.0
Jul 16 17:56:05 tokeiihto kernel: [    1.222409] hub 2-0:1.0: USB hub fou=
nd
Jul 16 17:56:05 tokeiihto kernel: [    1.222819] hub 2-0:1.0: 4 ports det=
ected
Jul 16 17:56:05 tokeiihto kernel: [    1.223426] xhci_hcd 0000:38:00.3: x=
HCI Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.223827] xhci_hcd 0000:38:00.3: n=
ew USB bus registered, assigned bus number 3
Jul 16 17:56:05 tokeiihto kernel: [    1.224382] xhci_hcd 0000:38:00.3: h=
cc params 0x0270ffe5 hci version 0x110 quirks 0x40000410
Jul 16 17:56:05 tokeiihto kernel: [    1.225056] usb usb3: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0002
Jul 16 17:56:05 tokeiihto kernel: [    1.225486] usb usb3: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:56:05 tokeiihto kernel: [    1.225922] usb usb3: Product: xHCI =
Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.226362] usb usb3: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.226815] usb usb3: SerialNumber: =
0000:38:00.3
Jul 16 17:56:05 tokeiihto kernel: [    1.227345] hub 3-0:1.0: USB hub fou=
nd
Jul 16 17:56:05 tokeiihto kernel: [    1.227796] hub 3-0:1.0: 4 ports det=
ected
Jul 16 17:56:05 tokeiihto kernel: [    1.228546] xhci_hcd 0000:38:00.3: x=
HCI Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.228999] xhci_hcd 0000:38:00.3: n=
ew USB bus registered, assigned bus number 4
Jul 16 17:56:05 tokeiihto kernel: [    1.229456] xhci_hcd 0000:38:00.3: H=
ost supports USB 3.10 Enhanced SuperSpeed
Jul 16 17:56:05 tokeiihto kernel: [    1.229932] usb usb4: We don't know =
the algorithms for LPM for this host, disabling LPM.
Jul 16 17:56:05 tokeiihto kernel: [    1.230408] usb usb4: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0003
Jul 16 17:56:05 tokeiihto kernel: [    1.230874] usb usb4: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:56:05 tokeiihto kernel: [    1.231346] usb usb4: Product: xHCI =
Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.231816] usb usb4: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.232319] usb usb4: SerialNumber: =
0000:38:00.3
Jul 16 17:56:05 tokeiihto kernel: [    1.232878] hub 4-0:1.0: USB hub fou=
nd
Jul 16 17:56:05 tokeiihto kernel: [    1.233344] hub 4-0:1.0: 4 ports det=
ected
Jul 16 17:56:05 tokeiihto kernel: [    1.233993] xhci_hcd 0000:38:00.4: x=
HCI Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.234458] xhci_hcd 0000:38:00.4: n=
ew USB bus registered, assigned bus number 5
Jul 16 17:56:05 tokeiihto kernel: [    1.235034] xhci_hcd 0000:38:00.4: h=
cc params 0x0260ffe5 hci version 0x110 quirks 0x40000410
Jul 16 17:56:05 tokeiihto kernel: [    1.235741] usb usb5: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0002
Jul 16 17:56:05 tokeiihto kernel: [    1.236201] usb usb5: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:56:05 tokeiihto kernel: [    1.236648] usb usb5: Product: xHCI =
Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.237092] usb usb5: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.237534] usb usb5: SerialNumber: =
0000:38:00.4
Jul 16 17:56:05 tokeiihto kernel: [    1.238047] hub 5-0:1.0: USB hub fou=
nd
Jul 16 17:56:05 tokeiihto kernel: [    1.238475] hub 5-0:1.0: 1 port dete=
cted
Jul 16 17:56:05 tokeiihto kernel: [    1.238961] xhci_hcd 0000:38:00.4: x=
HCI Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.239391] xhci_hcd 0000:38:00.4: n=
ew USB bus registered, assigned bus number 6
Jul 16 17:56:05 tokeiihto kernel: [    1.239816] xhci_hcd 0000:38:00.4: H=
ost supports USB 3.10 Enhanced SuperSpeed
Jul 16 17:56:05 tokeiihto kernel: [    1.240262] usb usb6: We don't know =
the algorithms for LPM for this host, disabling LPM.
Jul 16 17:56:05 tokeiihto kernel: [    1.240706] usb usb6: New USB device=
 found, idVendor=3D1d6b, idProduct=3D0003
Jul 16 17:56:05 tokeiihto kernel: [    1.241145] usb usb6: New USB device=
 strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jul 16 17:56:05 tokeiihto kernel: [    1.241590] usb usb6: Product: xHCI =
Host Controller
Jul 16 17:56:05 tokeiihto kernel: [    1.242028] usb usb6: Manufacturer: =
Linux 4.16.0-2-amd64 xhci-hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.242467] usb usb6: SerialNumber: =
0000:38:00.4
Jul 16 17:56:05 tokeiihto kernel: [    1.242972] hub 6-0:1.0: USB hub fou=
nd
Jul 16 17:56:05 tokeiihto kernel: [    1.243398] hub 6-0:1.0: 1 port dete=
cted
Jul 16 17:56:05 tokeiihto kernel: [    1.472900] ata1: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:56:05 tokeiihto kernel: [    1.552351] usb 1-10: new low-speed =
USB device number 2 using xhci_hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.565353] tsc: Refined TSC clockso=
urce calibration: 3503.061 MHz
Jul 16 17:56:05 tokeiihto kernel: [    1.566380] clocksource: tsc: mask: =
0xffffffffffffffff max_cycles: 0x327e9c43762, max_idle_ns: 440795243118 n=
s
Jul 16 17:56:05 tokeiihto kernel: [    1.567161] clocksource: Switched to=
 clocksource tsc
Jul 16 17:56:05 tokeiihto kernel: [    1.572354] usb 5-1: new low-speed U=
SB device number 2 using xhci_hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.588228] usb 4-2: new SuperSpeed =
USB device number 2 using xhci_hcd
Jul 16 17:56:05 tokeiihto kernel: [    1.609051] usb 4-2: New USB device =
found, idVendor=3D0781, idProduct=3D558b
Jul 16 17:56:05 tokeiihto kernel: [    1.610103] usb 4-2: New USB device =
strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
Jul 16 17:56:05 tokeiihto kernel: [    1.610746] usb 4-2: Product: Extrem=
e
Jul 16 17:56:05 tokeiihto kernel: [    1.611332] usb 4-2: Manufacturer: S=
anDisk
Jul 16 17:56:05 tokeiihto kernel: [    1.611905] usb 4-2: SerialNumber: 4=
C530001051117121354
Jul 16 17:56:05 tokeiihto kernel: [    1.615396] usb-storage 4-2:1.0: USB=
 Mass Storage device detected
Jul 16 17:56:05 tokeiihto kernel: [    1.616199] scsi host9: usb-storage =
4-2:1.0
Jul 16 17:56:05 tokeiihto kernel: [    1.616901] usbcore: registered new =
interface driver usb-storage
Jul 16 17:56:05 tokeiihto kernel: [    1.618014] usbcore: registered new =
interface driver uas
Jul 16 17:56:05 tokeiihto kernel: [    1.636036] ata9: SATA link up 6.0 G=
bps (SStatus 133 SControl 300)
Jul 16 17:56:05 tokeiihto kernel: [    1.637484] ata9.00: supports DRM fu=
nctions and may not be fully accessible
Jul 16 17:56:05 tokeiihto kernel: [    1.638131] ata9.00: ATA-10: CT1000M=
X500SSD4, M3CR020, max UDMA/133
Jul 16 17:56:05 tokeiihto kernel: [    1.638691] ata9.00: 1953525168 sect=
ors, multi 1: LBA48 NCQ (depth 31/32), AA
Jul 16 17:56:05 tokeiihto kernel: [    1.639851] ata9.00: supports DRM fu=
nctions and may not be fully accessible
Jul 16 17:56:05 tokeiihto kernel: [    1.641007] ata9.00: configured for =
UDMA/133
Jul 16 17:56:05 tokeiihto kernel: [    1.737154] usb 5-1: New USB device =
found, idVendor=3D413c, idProduct=3D3012
Jul 16 17:56:05 tokeiihto kernel: [    1.738142] usb 5-1: New USB device =
strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Jul 16 17:56:05 tokeiihto kernel: [    1.739149] usb 5-1: Product: Dell U=
SB Optical Mouse
Jul 16 17:56:05 tokeiihto kernel: [    1.739835] usb 5-1: Manufacturer: D=
ell
Jul 16 17:56:05 tokeiihto kernel: [    1.748313] hidraw: raw HID events d=
river (C) Jiri Kosina
Jul 16 17:56:05 tokeiihto kernel: [    1.753205] usbcore: registered new =
interface driver usbhid
Jul 16 17:56:05 tokeiihto kernel: [    1.753803] usbhid: USB HID core dri=
ver
Jul 16 17:56:05 tokeiihto kernel: [    1.755189] input: Dell Dell USB Opt=
ical Mouse as /devices/pci0000:00/0000:00:08.1/0000:38:00.4/usb5/5-1/5-1:=
1.0/0003:413C:3012.0001/input/input0
Jul 16 17:56:05 tokeiihto kernel: [    1.756613] hid-generic 0003:413C:30=
12.0001: input,hidraw0: USB HID v1.11 Mouse [Dell Dell USB Optical Mouse]=
 on usb-0000:38:00.4-1/input0
Jul 16 17:56:05 tokeiihto kernel: [    1.788318] ata2: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:56:05 tokeiihto kernel: [    1.844683] usb 1-10: New USB device=
 found, idVendor=3D413c, idProduct=3D2105
Jul 16 17:56:05 tokeiihto kernel: [    1.845784] usb 1-10: New USB device=
 strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Jul 16 17:56:05 tokeiihto kernel: [    1.846458] usb 1-10: Product: Dell =
USB Keyboard
Jul 16 17:56:05 tokeiihto kernel: [    1.847128] usb 1-10: Manufacturer: =
Dell
Jul 16 17:56:05 tokeiihto kernel: [    1.909933] input: Dell Dell USB Key=
board as /devices/pci0000:00/0000:00:01.2/0000:15:00.0/usb1/1-10/1-10:1.0=
/0003:413C:2105.0002/input/input1
Jul 16 17:56:05 tokeiihto kernel: [    1.968728] hid-generic 0003:413C:21=
05.0002: input,hidraw1: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] o=
n usb-0000:15:00.0-10/input0
Jul 16 17:56:05 tokeiihto kernel: [    2.103937] ata5: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:56:05 tokeiihto kernel: [    2.420183] ata6: SATA link down (SS=
tatus 0 SControl 300)
Jul 16 17:56:05 tokeiihto kernel: [    2.421908] scsi 8:0:0:0: Direct-Acc=
ess     ATA      CT1000MX500SSD4  020  PQ: 0 ANSI: 5
Jul 16 17:56:05 tokeiihto kernel: [    2.424478] sd 8:0:0:0: [sda] 195352=
5168 512-byte logical blocks: (1.00 TB/932 GiB)
Jul 16 17:56:05 tokeiihto kernel: [    2.425224] sd 8:0:0:0: [sda] 4096-b=
yte physical blocks
Jul 16 17:56:05 tokeiihto kernel: [    2.425968] sd 8:0:0:0: [sda] Write =
Protect is off
Jul 16 17:56:05 tokeiihto kernel: [    2.426705] sd 8:0:0:0: [sda] Mode S=
ense: 00 3a 00 00
Jul 16 17:56:05 tokeiihto kernel: [    2.426718] sd 8:0:0:0: [sda] Write =
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jul 16 17:56:05 tokeiihto kernel: [    2.428491]  sda: sda1 sda2 sda3
Jul 16 17:56:05 tokeiihto kernel: [    2.429596] sd 8:0:0:0: [sda] suppor=
ts TCG Opal
Jul 16 17:56:05 tokeiihto kernel: [    2.430313] sd 8:0:0:0: [sda] Attach=
ed SCSI disk
Jul 16 17:56:05 tokeiihto kernel: [    2.520010] raid6: sse2x1   gen()  8=
258 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.588007] raid6: sse2x1   xor()  7=
848 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.620886] scsi 9:0:0:0: Direct-Acc=
ess     SanDisk  Extreme          1.00 PQ: 0 ANSI: 6
Jul 16 17:56:05 tokeiihto kernel: [    2.622427] sd 9:0:0:0: [sdb] 122552=
320 512-byte logical blocks: (62.7 GB/58.4 GiB)
Jul 16 17:56:05 tokeiihto kernel: [    2.623305] sd 9:0:0:0: [sdb] Write =
Protect is off
Jul 16 17:56:05 tokeiihto kernel: [    2.624148] sd 9:0:0:0: [sdb] Mode S=
ense: 43 00 00 00
Jul 16 17:56:05 tokeiihto kernel: [    2.624439] sd 9:0:0:0: [sdb] Write =
cache: disabled, read cache: enabled, doesn't support DPO or FUA
Jul 16 17:56:05 tokeiihto kernel: [    2.626950]  sdb: sdb1 sdb2 sdb3
Jul 16 17:56:05 tokeiihto kernel: [    2.628508] sd 9:0:0:0: [sdb] Attach=
ed SCSI removable disk
Jul 16 17:56:05 tokeiihto kernel: [    2.636728] random: fast init done
Jul 16 17:56:05 tokeiihto kernel: [    2.656008] raid6: sse2x2   gen() 17=
171 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.724008] raid6: sse2x2   xor() 10=
692 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.792009] raid6: sse2x4   gen() 17=
195 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.860008] raid6: sse2x4   xor()  9=
537 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.928008] raid6: avx2x1   gen() 18=
794 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    2.996008] raid6: avx2x1   xor() 14=
057 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    3.064006] raid6: avx2x2   gen() 23=
524 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    3.132006] raid6: avx2x2   xor() 15=
075 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    3.200007] raid6: avx2x4   gen() 24=
420 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    3.268008] raid6: avx2x4   xor() 13=
511 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    3.268590] raid6: using algorithm a=
vx2x4 gen() 24420 MB/s
Jul 16 17:56:05 tokeiihto kernel: [    3.269157] raid6: .... xor() 13511 =
MB/s, rmw enabled
Jul 16 17:56:05 tokeiihto kernel: [    3.269722] raid6: using avx2x2 reco=
very algorithm
Jul 16 17:56:05 tokeiihto kernel: [    3.271303] xor: automatically using=
 best checksumming function   avx      =20
Jul 16 17:56:05 tokeiihto kernel: [    3.272655] async_tx: api initialize=
d (async)
Jul 16 17:56:05 tokeiihto kernel: [    3.287638] device-mapper: uevent: v=
ersion 1.0.3
Jul 16 17:56:05 tokeiihto kernel: [    3.288381] device-mapper: ioctl: 4.=
37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
Jul 16 17:56:05 tokeiihto kernel: [   10.891088] random: crng init done
Jul 16 17:56:05 tokeiihto kernel: [   13.279343] NET: Registered protocol=
 family 38
Jul 16 17:56:05 tokeiihto kernel: [   13.532395] EXT4-fs (dm-0): mounted =
filesystem with ordered data mode. Opts: (null)
Jul 16 17:56:05 tokeiihto kernel: [   13.846358] EXT4-fs (dm-0): re-mount=
ed. Opts: errors=3Dremount-ro
Jul 16 17:56:05 tokeiihto kernel: [   13.929517] acpi_cpufreq: overriding=
 BIOS provided _PSD data
Jul 16 17:56:05 tokeiihto kernel: [   13.933205] input: Power Button as /=
devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
Jul 16 17:56:05 tokeiihto kernel: [   13.933648] ACPI: Power Button [PWRB=
]
Jul 16 17:56:05 tokeiihto kernel: [   13.934125] input: Power Button as /=
devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
Jul 16 17:56:05 tokeiihto kernel: [   13.934654] ACPI: Power Button [PWRF=
]
Jul 16 17:56:05 tokeiihto kernel: [   13.944255] parport_pc 00:04: report=
ed by Plug and Play ACPI
Jul 16 17:56:05 tokeiihto kernel: [   13.944830] parport0: PC-style at 0x=
378, irq 5 [PCSPP]
Jul 16 17:56:05 tokeiihto kernel: [   13.968760] shpchp: Standard Hot Plu=
g PCI Controller Driver version: 0.4
Jul 16 17:56:05 tokeiihto kernel: [   13.973069] sp5100_tco: SP5100/SB800=
 TCO WatchDog Timer Driver
Jul 16 17:56:05 tokeiihto kernel: [   13.976099] sp5100-tco sp5100-tco: I=
/O address 0x0cd6 already in use
Jul 16 17:56:05 tokeiihto kernel: [   13.976888] sp5100-tco: probe of sp5=
100-tco failed with error -16
Jul 16 17:56:05 tokeiihto kernel: [   13.999111] sd 8:0:0:0: Attached scs=
i generic sg0 type 0
Jul 16 17:56:05 tokeiihto kernel: [   14.000275] input: PC Speaker as /de=
vices/platform/pcspkr/input/input4
Jul 16 17:56:05 tokeiihto kernel: [   14.001357] EFI Variables Facility v=
0.08 2004-May-17
Jul 16 17:56:05 tokeiihto kernel: [   14.001482] snd_hda_intel 0000:38:00=
=2E1: Handle vga_switcheroo audio client
Jul 16 17:56:05 tokeiihto kernel: [   14.001522] sd 9:0:0:0: Attached scs=
i generic sg1 type 0
Jul 16 17:56:05 tokeiihto kernel: [   14.032460] input: HD-Audio Generic =
HDMI/DP,pcm=3D3 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input5
Jul 16 17:56:05 tokeiihto kernel: [   14.032980] input: HD-Audio Generic =
HDMI/DP,pcm=3D7 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input6
Jul 16 17:56:05 tokeiihto kernel: [   14.033508] input: HD-Audio Generic =
HDMI/DP,pcm=3D8 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input7
Jul 16 17:56:05 tokeiihto kernel: [   14.034218] input: HD-Audio Generic =
HDMI/DP,pcm=3D9 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/ca=
rd0/input8
Jul 16 17:56:05 tokeiihto kernel: [   14.034780] input: HD-Audio Generic =
HDMI/DP,pcm=3D10 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/c=
ard0/input9
Jul 16 17:56:05 tokeiihto kernel: [   14.035312] input: HD-Audio Generic =
HDMI/DP,pcm=3D11 as /devices/pci0000:00/0000:00:08.1/0000:38:00.1/sound/c=
ard0/input10
Jul 16 17:56:05 tokeiihto kernel: [   14.054041] pstore: using zlib compr=
ession
Jul 16 17:56:05 tokeiihto kernel: [   14.055301] pstore: Registered efi a=
s persistent store backend
Jul 16 17:56:05 tokeiihto kernel: [   14.055437] snd_hda_codec_realtek hd=
audioC1D0: autoconfig for ALC892: line_outs=3D3 (0x14/0x15/0x16/0x0/0x0) =
type:line
Jul 16 17:56:05 tokeiihto kernel: [   14.056217] snd_hda_codec_realtek hd=
audioC1D0:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Jul 16 17:56:05 tokeiihto kernel: [   14.056677] snd_hda_codec_realtek hd=
audioC1D0:    hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
Jul 16 17:56:05 tokeiihto kernel: [   14.057132] snd_hda_codec_realtek hd=
audioC1D0:    mono: mono_out=3D0x0
Jul 16 17:56:05 tokeiihto kernel: [   14.057580] snd_hda_codec_realtek hd=
audioC1D0:    dig-out=3D0x1e/0x0
Jul 16 17:56:05 tokeiihto kernel: [   14.058030] snd_hda_codec_realtek hd=
audioC1D0:    inputs:
Jul 16 17:56:05 tokeiihto kernel: [   14.061637] snd_hda_codec_realtek hd=
audioC1D0:      Front Mic=3D0x19
Jul 16 17:56:05 tokeiihto kernel: [   14.062091] snd_hda_codec_realtek hd=
audioC1D0:      Rear Mic=3D0x18
Jul 16 17:56:05 tokeiihto kernel: [   14.062535] snd_hda_codec_realtek hd=
audioC1D0:      Line=3D0x1a
Jul 16 17:56:05 tokeiihto kernel: [   14.063308] kvm: disabled by bios
Jul 16 17:56:05 tokeiihto kernel: [   14.067203] MCE: In-kernel MCE decod=
ing enabled.
Jul 16 17:56:05 tokeiihto kernel: [   14.069507] EDAC amd64: Node 0: DRAM=
 ECC disabled.
Jul 16 17:56:05 tokeiihto kernel: [   14.069969] EDAC amd64: ECC disabled=
 in the BIOS or no ECC capability, module will not load.
Jul 16 17:56:05 tokeiihto kernel: [   14.069969]  Either enable ECC check=
ing or force module loading by setting 'ecc_enable_override'.
Jul 16 17:56:05 tokeiihto kernel: [   14.069969]  (Note that use of the o=
verride may cause unknown side effects.)
Jul 16 17:56:05 tokeiihto kernel: [   14.096973] ppdev: user-space parall=
el port driver
Jul 16 17:56:05 tokeiihto kernel: [   14.124563] EDAC amd64: Node 0: DRAM=
 ECC disabled.
Jul 16 17:56:05 tokeiihto kernel: [   14.125144] EDAC amd64: ECC disabled=
 in the BIOS or no ECC capability, module will not load.
Jul 16 17:56:05 tokeiihto kernel: [   14.125144]  Either enable ECC check=
ing or force module loading by setting 'ecc_enable_override'.
Jul 16 17:56:05 tokeiihto kernel: [   14.125144]  (Note that use of the o=
verride may cause unknown side effects.)
Jul 16 17:56:05 tokeiihto kernel: [   14.145409] [drm:amdgpu_init [amdgpu=
]] *ERROR* VGACON disables amdgpu kernel modesetting.
Jul 16 17:56:05 tokeiihto kernel: [   14.146596] input: HD-Audio Generic =
Front Mic as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card1/in=
put11
Jul 16 17:56:05 tokeiihto kernel: [   14.148523] input: HD-Audio Generic =
Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card1/inp=
ut12
Jul 16 17:56:05 tokeiihto kernel: [   14.149788] input: HD-Audio Generic =
Line as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card1/input13=

Jul 16 17:56:05 tokeiihto kernel: [   14.149873] input: HD-Audio Generic =
Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/car=
d1/input14
Jul 16 17:56:05 tokeiihto kernel: [   14.149943] input: HD-Audio Generic =
Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/=
card1/input15
Jul 16 17:56:05 tokeiihto kernel: [   14.150009] input: HD-Audio Generic =
Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/card=
1/input16
Jul 16 17:56:05 tokeiihto kernel: [   14.150068] input: HD-Audio Generic =
Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:38:00.6/sound/ca=
rd1/input17
Jul 16 17:56:05 tokeiihto kernel: [   14.160828] EXT4-fs (sda2): mounted =
filesystem with ordered data mode. Opts: (null)
Jul 16 17:56:22 tokeiihto kernel: [   31.653198] r8169 0000:18:00.0: firm=
ware: failed to load rtl_nic/rtl8168h-2.fw (-2)
Jul 16 17:56:22 tokeiihto kernel: [   31.653245] firmware_class: See http=
s://wiki.debian.org/Firmware for information about missing firmware
Jul 16 17:56:22 tokeiihto kernel: [   31.653292] r8169 0000:18:00.0: Dire=
ct firmware load for rtl_nic/rtl8168h-2.fw failed with error -2
Jul 16 17:56:22 tokeiihto kernel: [   31.653339] r8169 0000:18:00.0 enp24=
s0: unable to load firmware patch rtl_nic/rtl8168h-2.fw (-2)
Jul 16 17:56:22 tokeiihto kernel: [   31.694665] r8169 0000:18:00.0 enp24=
s0: link down
Jul 16 17:56:22 tokeiihto kernel: [   31.694677] r8169 0000:18:00.0 enp24=
s0: link down
Jul 16 17:56:22 tokeiihto kernel: [   31.694796] IPv6: ADDRCONF(NETDEV_UP=
): enp24s0: link is not ready
Jul 16 17:56:25 tokeiihto kernel: [   34.876371] r8169 0000:18:00.0 enp24=
s0: link up
Jul 16 17:56:25 tokeiihto kernel: [   34.876425] IPv6: ADDRCONF(NETDEV_CH=
ANGE): enp24s0: link becomes ready

--------------3E9F0A289822BB448CB99FCC--

--------------ms060709080405070606060400
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA3MTYxNjE0MDlaMC8GCSqGSIb3DQEJBDEiBCCTA0a1k1Z4cLkuU32a
CoIgQ6qT0TVOJIoR7K/SrLc2LDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAIxR
uu0Kc1YZZy6pWNGvMJKmrXmjgigMWh4HmCisfo79//ewqOTFTj9NrnJyV2QYSRcxJCTjDmjP
q03YetyQoT8+PRAS20CLvfb0sJCKFKGbSQA7x2vSt2J9/yz+WWTbRhUwkG9Ms6XO151D7Aa2
8c4g3jRsNd2QYFBdpryu3lTnymuf1ZGvj2dVBPl535F+Sdr0pchuTJ/eY8aODLajLn9CR8Cg
9xyCy17WtgsRqW4fDzPagsdTkMkCb4CZin5kIxc/DRByeXz1S+8zhWK+U2w7+CgYJT8xw3K0
37SOWo2ymyM7ezKFhYtpTg1jQGB7WkwjVYhFu+KdjiLL7xmTOIsAAAAAAAA=
--------------ms060709080405070606060400--
