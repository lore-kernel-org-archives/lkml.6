Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248DFECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6727208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvVn4W3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6727208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeGPQ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:58:43 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40552 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeGPQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:58:43 -0400
Received: by mail-wm0-f45.google.com with SMTP id z13-v6so16524933wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gQ3EClf2OMCsnS7Us+J6Tb+zqSrvhPk2+txjNekZK+o=;
        b=LvVn4W3gCwYZMmSESbKTNK9Rf1lBVrau/u0fSECbVkzyMRuRfYhdlRWCEfcCHY544f
         Du3CxENDaycllocyCRHJmybEdeiFP6FHSWMEmjBb1NlFMDw2wsNIWcD4++YCk+TP8xDS
         gASX7BalZ9sjd8vuVhFhPNo4hFcVdsk5w44l0fSQlPY6Nr3CYiPWvrG6qxW6BgzPvQpG
         ghVvXEjRUnaTBVJfHv2qkcr3ed+pWD/cukoFZ+o3dcbMfGhbJpmXt+mXt1oj8rkDV2Us
         Wq9TY9AnRtxNTrWFagPi/ahKIX0AZrI3uR1ooq8ESugHJWeyiDGFU7hfARw5iYpvqV45
         UOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gQ3EClf2OMCsnS7Us+J6Tb+zqSrvhPk2+txjNekZK+o=;
        b=c3jNjzrXf8em4SbeFtv5/0r8LlP/tGnbXUZV80n7jNGeesymfZTG2Tj+oQGAhWX5Wu
         ByEY0ojbNoG5N6fqJXeFrvX+3NS1TkovG39vp2KMIHWbFjnlVZS5pM8sfOP8LaSw1S2E
         s46JkBUR82V6pwigoC3dMNxFPi2+nDnMaKIhI4NwwGrQ7VO4Morhd0RpREXwjszjCGZ9
         P7ZQEvIJxtndXKD+fnY9O6E/+BDpPOY5hZ4ymMgR5Sp/PioiUBQfXBoKrrd9TuTOpLK/
         Z7ET4Cyiz/TATjD7KwGTzxVspbzu2cHnh2DfGRH/LCbuonSjX00++ZnuaNSBYFR/0zJF
         UdUg==
X-Gm-Message-State: AOUpUlE6jIVzJqeKY+6nvSfHsI0HJ2k8rYOSxtO/J+UkHW03Beo61po/
        uKXbX2cNMIFmoyy1GzkeUj3gesuzq4NyZuH2kmyDaQ==
X-Google-Smtp-Source: AAOMgpfv0q6Q9sft8wg4hAfCJNjV6zuU+kstFNNioW+MyFONbm3kYSHYuRPk0K2+0tDADXAN3O70NIzLVBZ1FOjdAKc=
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr9522830wmd.105.1531758631047;
 Mon, 16 Jul 2018 09:30:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9563:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 09:30:30
 -0700 (PDT)
In-Reply-To: <ba7e0ef4-5b5c-76d7-304d-6bdd2ad55b80@molgen.mpg.de>
References: <ba7e0ef4-5b5c-76d7-304d-6bdd2ad55b80@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Jul 2018 12:30:30 -0400
Message-ID: <CADnq5_M6JRbBabcJWdft7QPOaZcww+g+4E4Ssn32cPwTN6ob3Q@mail.gmail.com>
Subject: Re: KMS does not work on MSI B350M MORTAR with AMD Ryzen 3 2200g
To:     Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:14 PM, Paul Menzel
<pmenzel+amd-gfx@molgen.mpg.de> wrote:
> Dear Linux folks,
>
>
> Trying to boot Debian Buster/testing with Linux 4.16.16 on a MSI B350M MO=
RTAR [1]
> with a Ryzen 3 2200g and a monitor connected over HDMI, when kernel mode =
setting
> (KMS) is enabled the monitor does not receive any updates, that means I d=
o not
> see the login prompt and only the Linux and systemd service messages from=
 before.
> The system seems to running though.
>
> Debian=E2=80=99s package *firmware-amd-graphics* [2] is from August 2017 =
and therefore
> outdated. I manually installed the firmware files from the Linux firmware
> repository [3].
>
> Here is the log.
>
> ```
> Jul 16 17:54:39 tokeiihto kernel: [   25.652026] [drm] BIOS signature inc=
orrect 0 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.652058] ATOM BIOS: 113-RAVEN-106
> Jul 16 17:54:39 tokeiihto kernel: [   25.652096] [drm] vm size is 262144 =
GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> Jul 16 17:54:39 tokeiihto kernel: [   25.652107] amdgpu 0000:38:00.0: VRA=
M: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
> Jul 16 17:54:39 tokeiihto kernel: [   25.652109] amdgpu 0000:38:00.0: GTT=
: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
> Jul 16 17:54:39 tokeiihto kernel: [   25.652113] [drm] Detected VRAM RAM=
=3D1024M, BAR=3D256M
> Jul 16 17:54:39 tokeiihto kernel: [   25.652114] [drm] RAM width 128bits =
UNKNOWN
> Jul 16 17:54:39 tokeiihto kernel: [   25.652170] [TTM] Zone  kernel: Avai=
lable graphics memory: 7703370 kiB
> Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Zone   dma32: Avai=
lable graphics memory: 2097152 kiB
> Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Initializing pool =
allocator
> Jul 16 17:54:39 tokeiihto kernel: [   25.652174] [TTM] Initializing DMA p=
ool allocator
> Jul 16 17:54:39 tokeiihto kernel: [   25.652202] [drm] amdgpu: 1024M of V=
RAM memory ready
> Jul 16 17:54:39 tokeiihto kernel: [   25.652203] [drm] amdgpu: 3072M of G=
TT memory ready.
> Jul 16 17:54:39 tokeiihto kernel: [   25.652220] [drm] GART: num cpu page=
s 262144, num gpu pages 262144
> Jul 16 17:54:39 tokeiihto kernel: [   25.652433] [drm] PCIE GART of 1024M=
 enabled (table at 0x000000F400800000).
> Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Supports vblank ti=
mestamp caching Rev 2 (21.10.2013).
> Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Driver supports pr=
ecise vblank timestamp query.
> Jul 16 17:54:39 tokeiihto kernel: [   25.652983] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_asd.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.653276] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_pfp.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.653498] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_me.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.653668] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_ce.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.653960] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_rlc.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.654817] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_mec.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.656137] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_mec2.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.658217] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_sdma.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.658220] [drm] use_doorbell being=
 set to: [true]
> Jul 16 17:54:39 tokeiihto kernel: [   25.659663] amdgpu 0000:38:00.0: fir=
mware: direct-loading firmware amdgpu/raven_vcn.bin
> Jul 16 17:54:39 tokeiihto kernel: [   25.659667] [drm] Found VCN firmware=
 Version: 1.73 Family ID: 18
> Jul 16 17:54:39 tokeiihto kernel: [   25.847424] [drm] VCN decode and enc=
ode initialized successfully.
> Jul 16 17:54:39 tokeiihto kernel: [   25.852189] amdgpu 0000:38:00.0: rin=
g 0(gfx) uses VM inv eng 4 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852191] amdgpu 0000:38:00.0: rin=
g 1(comp_1.0.0) uses VM inv eng 5 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852193] amdgpu 0000:38:00.0: rin=
g 2(comp_1.1.0) uses VM inv eng 6 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852194] amdgpu 0000:38:00.0: rin=
g 3(comp_1.2.0) uses VM inv eng 7 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852195] amdgpu 0000:38:00.0: rin=
g 4(comp_1.3.0) uses VM inv eng 8 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852197] amdgpu 0000:38:00.0: rin=
g 5(comp_1.0.1) uses VM inv eng 9 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852198] amdgpu 0000:38:00.0: rin=
g 6(comp_1.1.1) uses VM inv eng 10 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852200] amdgpu 0000:38:00.0: rin=
g 7(comp_1.2.1) uses VM inv eng 11 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852201] amdgpu 0000:38:00.0: rin=
g 8(comp_1.3.1) uses VM inv eng 12 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852202] amdgpu 0000:38:00.0: rin=
g 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
> Jul 16 17:54:39 tokeiihto kernel: [   25.852204] amdgpu 0000:38:00.0: rin=
g 10(sdma0) uses VM inv eng 4 on hub 1
> Jul 16 17:54:39 tokeiihto kernel: [   25.852205] amdgpu 0000:38:00.0: rin=
g 11(vcn_dec) uses VM inv eng 5 on hub 1
> Jul 16 17:54:39 tokeiihto kernel: [   25.852207] amdgpu 0000:38:00.0: rin=
g 12(vcn_enc0) uses VM inv eng 6 on hub 1
> Jul 16 17:54:39 tokeiihto kernel: [   25.852208] amdgpu 0000:38:00.0: rin=
g 13(vcn_enc1) uses VM inv eng 7 on hub 1
> Jul 16 17:54:39 tokeiihto kernel: [   25.856580] [drm] Initialized amdgpu=
 3.23.0 20150101 for 0000:38:00.0 on minor 0
> ```
>
> The messages `[drm] BIOS signature incorrect 0 0` stands out. The latest
> mainboard firmware version 7A37v1F from May 2018 is installed [4].
>
> Booting with `nomodeset` works.
>
> Please find attached the full log with the KMS boot messages in the
> beginning, and the nomodeset messages in the second part.
>
> Do you have any hints how to get modesetting to work?

Are
CONFIG_DRM_AMD_DC and CONFIG_DRM_AMD_DC_DCN1_0 set in your kernel config?
Those are required for modesetting on raven.

Alex

>
>
> Kind regards,
>
> Paul
>
>
> PS: Here is the output of `lspci`.
>
> ```
> $ lspci -nn
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15d0]
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:15d=
1]
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
> 00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15d3]
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15db]
> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15dc]
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Contro=
ller [1022:790b] (rev 61)
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bri=
dge [1022:790e] (rev 51)
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15e8]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15e9]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ea]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15eb]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ec]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ed]
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ee]
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ef]
> 15:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 300 Ser=
ies Chipset USB 3.1 xHCI Controller [1022:43bb] (rev 02)
> 15:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 300 Se=
ries Chipset SATA Controller [1022:43b7] (rev 02)
> 15:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:43b2] (rev 02)
> 16:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
> 16:01.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
> 16:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
> 18:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL81=
11/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
> 38:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] [1002:=
15dd] (rev c8)
> 38:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Devic=
e [1002:15de]
> 38:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:15df]
> 38:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device =
[1022:15e0]
> 38:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device =
[1022:15e1]
> 38:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Device [1=
022:15e3]
> 39:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SA=
TA Controller [AHCI mode] [1022:7901] (rev 61)
> ```
>
> [1]: https://www.msi.com/Motherboard/B350M-MORTAR/
> [2]: https://packages.debian.org/buster/firmware-amd-graphics
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmw=
are.git/
> [4]: https://www.msi.com/Motherboard/support/B350M-MORTAR
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
