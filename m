Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69670ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB55208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB55208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGPW3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:29:41 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59871 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728758AbeGPW3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:29:41 -0400
Received: from [192.168.0.4] (ip5f5bd268.dynamic.kabel-deutschland.de [95.91.210.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 43E3D2012BA075;
        Tue, 17 Jul 2018 00:00:17 +0200 (CEST)
Subject: Re: KMS does not work on MSI B350M MORTAR with AMD Ryzen 3 2200g
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
References: <ba7e0ef4-5b5c-76d7-304d-6bdd2ad55b80@molgen.mpg.de>
 <CADnq5_M6JRbBabcJWdft7QPOaZcww+g+4E4Ssn32cPwTN6ob3Q@mail.gmail.com>
From:   Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Message-ID: <758d29fc-588f-fd7d-cfa3-68c278f24562@molgen.mpg.de>
Date:   Tue, 17 Jul 2018 00:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_M6JRbBabcJWdft7QPOaZcww+g+4E4Ssn32cPwTN6ob3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alex,


Thank you for your response.

Am 16.07.2018 um 18:30 schrieb Alex Deucher:
> On Mon, Jul 16, 2018 at 12:14 PM, Paul Menzel
> <pmenzel+amd-gfx@molgen.mpg.de> wrote:
>> Dear Linux folks,
>>
>>
>> Trying to boot Debian Buster/testing with Linux 4.16.16 on a MSI B350M MORTAR [1]
>> with a Ryzen 3 2200g and a monitor connected over HDMI, when kernel mode setting
>> (KMS) is enabled the monitor does not receive any updates, that means I do not
>> see the login prompt and only the Linux and systemd service messages from before.
>> The system seems to running though.
>>
>> Debian’s package *firmware-amd-graphics* [2] is from August 2017 and therefore
>> outdated. I manually installed the firmware files from the Linux firmware
>> repository [3].
>>
>> Here is the log.
>>
>> ```
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652026] [drm] BIOS signature incorrect 0 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652058] ATOM BIOS: 113-RAVEN-106
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652096] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652107] amdgpu 0000:38:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652109] amdgpu 0000:38:00.0: GTT: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652113] [drm] Detected VRAM RAM=1024M, BAR=256M
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652114] [drm] RAM width 128bits UNKNOWN
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652170] [TTM] Zone  kernel: Available graphics memory: 7703370 kiB
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652171] [TTM] Initializing pool allocator
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652174] [TTM] Initializing DMA pool allocator
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652202] [drm] amdgpu: 1024M of VRAM memory ready
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652203] [drm] amdgpu: 3072M of GTT memory ready.
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652220] [drm] GART: num cpu pages 262144, num gpu pages 262144
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652433] [drm] PCIE GART of 1024M enabled (table at 0x000000F400800000).
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652541] [drm] Driver supports precise vblank timestamp query.
>> Jul 16 17:54:39 tokeiihto kernel: [   25.652983] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_asd.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.653276] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_pfp.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.653498] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_me.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.653668] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_ce.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.653960] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_rlc.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.654817] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_mec.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.656137] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_mec2.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.658217] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_sdma.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.658220] [drm] use_doorbell being set to: [true]
>> Jul 16 17:54:39 tokeiihto kernel: [   25.659663] amdgpu 0000:38:00.0: firmware: direct-loading firmware amdgpu/raven_vcn.bin
>> Jul 16 17:54:39 tokeiihto kernel: [   25.659667] [drm] Found VCN firmware Version: 1.73 Family ID: 18
>> Jul 16 17:54:39 tokeiihto kernel: [   25.847424] [drm] VCN decode and encode initialized successfully.
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852189] amdgpu 0000:38:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852191] amdgpu 0000:38:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852193] amdgpu 0000:38:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852194] amdgpu 0000:38:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852195] amdgpu 0000:38:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852197] amdgpu 0000:38:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852198] amdgpu 0000:38:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852200] amdgpu 0000:38:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852201] amdgpu 0000:38:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852202] amdgpu 0000:38:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852204] amdgpu 0000:38:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852205] amdgpu 0000:38:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852207] amdgpu 0000:38:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
>> Jul 16 17:54:39 tokeiihto kernel: [   25.852208] amdgpu 0000:38:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
>> Jul 16 17:54:39 tokeiihto kernel: [   25.856580] [drm] Initialized amdgpu 3.23.0 20150101 for 0000:38:00.0 on minor 0
>> ```
>>
>> The messages `[drm] BIOS signature incorrect 0 0` stands out. The latest
>> mainboard firmware version 7A37v1F from May 2018 is installed [4].
>>
>> Booting with `nomodeset` works.
>>
>> Please find attached the full log with the KMS boot messages in the
>> beginning, and the nomodeset messages in the second part.
>>
>> Do you have any hints how to get modesetting to work?
> 
> Are
> CONFIG_DRM_AMD_DC and CONFIG_DRM_AMD_DC_DCN1_0 set in your kernel config?
> Those are required for modesetting on raven.

No, the second option is not selected in linux-image-4.16.0-2-amd64 [5].

```
#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
# CONFIG_DRM_AMD_DC_PRE_VEGA is not set
# CONFIG_DRM_AMD_DC_FBC is not set
# CONFIG_DRM_AMD_DC_DCN1_0 is not set
# CONFIG_DEBUG_KERNEL_DC is not set
```

It’s selected in linux-image-4.17.0-1 [6]. That version is not yet in 
Debian Buster/testing.

I wonder, if in the future the Linux kernel could give feedback to the 
user if options are unselected.


Kind regards,

Paul


[5]: https://packages.debian.org/sid/amd64/linux-image-4.16.0-2-amd64
[6]: https://packages.debian.org/sid/amd64/linux-image-4.17.0-1-amd64
