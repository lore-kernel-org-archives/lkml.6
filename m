Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EBCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BF92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPptsNWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfAaPNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:13:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33618 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:13:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so3020349ljd.0;
        Thu, 31 Jan 2019 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HWAjJhfUdi6J27wAaFNs9HkEQGmepN4HH+8X1u9IJi8=;
        b=JPptsNWatFKvm9qtoyPDq+QWMAuGH0xyRjQxrPfreG7MG7wULDUrQ/cXUIiW/QefQJ
         BytNV1vimcdcyfFJz1Wfmk2oh9Jth1qmJF0UDFGc2wPdI4adI8cOnsOxnAqkcOpO0hiT
         boxegSBhM+UvyjpTKZ3gLwHDBA5RToccT3hf70ljnkFcWb1HjjIdqwS/XKUSLyhGoD2R
         necv7+9+NzZAcYNVOgBjjFtjjamdsenhZHFCr0hoAX3BW2cnRkk6aOIVC8YqTa9P2gIh
         tcsOnQ+qiAc0GVEV5cEyMgBow4AREfYK3MsPHrtN5pbTVw76p7ExzAHZ9akjreP1XhUm
         zmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HWAjJhfUdi6J27wAaFNs9HkEQGmepN4HH+8X1u9IJi8=;
        b=oQu/9hcHepptUw2BjwpAPtAyQUBjzrvn+VLf6t7b/N0JS1CyZLcG2nLKATOfW2+obG
         F5x+3RHoDAmnsJRRMIG1hYF1Yno6v3Me8Jtah+Kbs7w+re9aPrXgj9L9kT8ZbUKlQPwA
         l1at0O9uOsc9uG2PtKee+GYYUzqdppY2LKfLkRi1aSdkZoUYMLhpHpLrR7+NL9J+RuyY
         /VlFF45NK3LIvdKu6IGtaRKj66B1kN23R43Ix1H+kSFViXmhD1J0G6xRxYeq5o2mqf7C
         c8Vt6H5gM9gxeY23+vaMdCs7z/ktCk6kufC/OwvoCkdsVstxiLitGvdRhsEiNX26c3Ty
         YAhQ==
X-Gm-Message-State: AJcUukfODRXx+mGH4GuYDUGK1XTKncvhbjfkkOM/LDOqWWjqKRy3hsxF
        hJ5hXiP1iTJGd/Ai3ThDqWoK96SW
X-Google-Smtp-Source: ALg8bN4n3tm6NnNgMm/a4xgpzbfHNHSVdZ8FuKo3CvP0TQYuKH/YLf7sQpszPRxiEiSTDveUrnz8Fw==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr25939851ljk.99.1548947577327;
        Thu, 31 Jan 2019 07:12:57 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id p89-v6sm832271ljp.60.2019.01.31.07.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:12:56 -0800 (PST)
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
Date:   Thu, 31 Jan 2019 18:12:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 9:16, Sowjanya Komatineni пишет:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
> 
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	other fixes
> 	Updated Kconfig for APB_DMA dependency
>  [V7] : Same as V6
>  [V6] : Updated for proper buffer allocation/freeing, channel release.
> 	Updated to use exact xfer size for syncing dma buffer.
>  [V5] : Same as V4
>  [V4] : Updated to allocate DMA buffer only when DMA mode.
> 	Updated to fall back to PIO mode when DMA channel request or
> 	buffer allocation fails.
>  [V3] : Updated without additional buffer allocation.
>  [V2] : Updated based on V1 review feedback along with code cleanup for
> 	proper implementation of DMA.
> 
>  drivers/i2c/busses/Kconfig     |   2 +-
>  drivers/i2c/busses/i2c-tegra.c | 362 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 339 insertions(+), 25 deletions(-)

Tegra20 crashes because of this patch:

<6>[    3.204854] pstore: Using crash dump compression: deflate
<6>[    3.306800] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4329-sdio for chip BCM4329/3
<6>[    3.306898] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
<6>[    3.307532] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: Sep  2 2011 14:48:19 version 4.220.48
<3>[    3.318169] brcmfmac: brcmf_setup_wiphybands: rxchain error (-52)
<7>[    3.379663] tegra-i2c 7000c000.i2c: unmasked irq: 0c
<7>[    3.379754] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<7>[    3.379763] tegra-i2c 7000c000.i2c: unmasked irq: 0d
<7>[    3.380017] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<7>[    3.380030] tegra-i2c 7000c000.i2c: unmasked irq: 0c
<7>[    3.380123] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<7>[    3.380133] tegra-i2c 7000c000.i2c: starting DMA for length: 112
<7>[    3.380144] tegra-i2c 7000c000.i2c: unmasked irq: 0c
<7>[    3.383507] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<6>[    3.383519] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
<7>[    3.383566] tegra-i2c 7000c000.i2c: unmasked irq: 0c
<7>[    3.383660] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<7>[    3.383670] tegra-i2c 7000c000.i2c: starting DMA for length: 224
<7>[    3.383678] tegra-i2c 7000c000.i2c: unmasked irq: 0c
<7>[    3.395181] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<7>[    3.395210] tegra-i2c 7000c000.i2c: unmasked irq: 0c
<7>[    3.395345] tegra-i2c 7000c000.i2c: transfer complete: 100 0 0
<7>[    3.395354] tegra-i2c 7000c000.i2c: unmasked irq: 0d
<4>[    3.395730] wm8903 0-001a: 0-001a supply AVDD not found, using dummy regulator
<6>[    3.395801] wm8903 0-001a: Linked as a consumer to regulator.0
<4>[    3.395829] wm8903 0-001a: 0-001a supply CPVDD not found, using dummy regulator
<4>[    3.395915] ------------[ cut here ]------------
<2>[    3.395919] kernel BUG at drivers/i2c/busses/i2c-tegra.c:810!
<0>[    3.395922] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP THUMB2
<4>[    3.395926] Modules linked in:
<4>[    3.395936] CPU: 0 PID: 121 Comm: kworker/0:3 Not tainted 5.0.0-rc2-next-20190121-00119-gbd91760d6769-dirty #1055
<4>[    3.395938] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
<4>[    3.395953] Workqueue: events deferred_probe_work_func
<4>[    3.395961] PC is at tegra_i2c_isr+0x26e/0x380
<4>[    3.395971] LR is at arm_heavy_mb+0x17/0x2c
<4>[    3.395975] pc : [<c05e9eb2>]    lr : [<c0112787>]    psr: 200001b3
<4>[    3.395978] sp : d66818e8  ip : c0f19274  fp : c0fd4c40
<4>[    3.395982] r10: c0fd4c54  r9 : d6c3c000  r8 : d668196c
<4>[    3.395985] r7 : 0000003e  r6 : d6476f04  r5 : 000000c2  r4 : d6476c40
<4>[    3.395989] r3 : 00000009  r2 : 00000068  r1 : 00000000  r0 : d6476f04
<4>[    3.395994] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment none
<4>[    3.395998] Control: 50c5387d  Table: 0000404a  DAC: 00000051
<0>[    3.396003] Process kworker/0:3 (pid: 121, stack limit = 0x(ptrval))
<0>[    3.396007] Stack: (0xd66818e8 to 0xd6682000)
<0>[    3.396014] 18e0:                   d66819d7 ffffffff d6681928 00000010 00000006 d64dc480
<0>[    3.396022] 1900: d6dd5800 00000000 0000003e d668196c d6c3c000 c0fd4c54 c0fd4c40 c0161a1d
<0>[    3.396029] 1920: 00000006 0000000a 0000003e ffffe000 d6dd5800 c0f0a0b0 c0fd45ef 00000010
<0>[    3.396036] 1940: 00000000 d6dd5800 d6dd5800 c0f60b58 16461000 00000000 d6c3c000 c0fe5228
<0>[    3.396044] 1960: c0fe4d28 c0161bb3 d66819a0 00000000 c0c637eb d6dd5800 d6dd5864 c0161c09
<0>[    3.396051] 1980: d6dd5800 d6dd5864 c0f60b58 c01641f1 c0164181 c0ea0e28 00000000 0000003e
<0>[    3.396058] 19a0: 00000001 c016103d 0000012b c01614b7 d66819f0 c0f0a864 c0f60bf4 fe44010c
<0>[    3.396065] 19c0: fe440100 d66819f0 fe441100 c03e42ab c015f3d7 c015f3dc 60000133 ffffffff
<0>[    3.396073] 19e0: d6681a24 c0f0a0b0 d6680000 c0101a65 60000193 16461000 00000000 a0000113
<0>[    3.396080] 1a00: 00000000 00000000 00000053 00000000 c0f0a0b0 c037a95d c0fe5228 c0fe4d28
<0>[    3.396087] 1a20: 0000000a d6681a40 c015f3d7 c015f3dc 60000133 ffffffff 00000051 00000000
<0>[    3.396094] 1a40: 00000400 c01601f3 00000000 a0000113 ffffe000 00000000 c0f0a0b0 00000000
<0>[    3.396101] 1a60: 00000113 c0fe4d28 ffffe000 00000000 00000001 000000fe 00000000 60000113
<0>[    3.396108] 1a80: 00000043 c016058d c0cca160 d6681b94 c0cb3f6c 00000001 c0cca160 0000000e
<0>[    3.396115] 1aa0: d6681ad8 d66c9420 c0cb3f6c 00000004 c0cca160 d6681b94 d6681ae6 c04acb79
<0>[    3.396122] 1ac0: c0cca160 d6681b94 d6681b0c 00000072 00000000 00000000 53425553 45545359
<0>[    3.396130] 1ae0: 32693d4d 45440063 45434956 32692b3d 2d303a63 61313030 d6681b00 c0646fa9
<0>[    3.396136] 1b00: 00000000 00000000 ffff0a00 00000000 00000000 00000000 00000000 00000000
<0>[    3.396143] 1b20: 00000000 00000000 00000000 00000000 c0cb729e d6681b48 d6ce7d58 d6ce7d58
<0>[    3.396150] 1b40: d6681b7c c0887ffd 00000076 d6681b7c c0d1da18 c04204d1 c0d1da18 d6681b94
<0>[    3.396158] 1b60: d6681bac 00000000 c0d1da18 d64fc300 d66c964c 00000002 0000003e c04acc47
<0>[    3.396165] 1b80: 00000000 d6681b94 d6681bb0 c04accb3 c0cca160 c0d1dae8 d64fc300 d6681bb0
<0>[    3.396172] 1ba0: c0cb7f0c c04ace3f 00000002 d6681bc8 c0cb7f0c d6681bac ffffffed d66c9420
<0>[    3.396179] 1bc0: c0423f1d c0cb7f0c d64fc300 c0d1da18 00000001 d66c9658 00000004 d66c9420
<0>[    3.396186] 1be0: d66c964c d66c964c 00000002 c0424009 d66ee7c0 00000005 d66c9420 00000004
<0>[    3.396194] 1c00: d66c964c c0424a2f d66c9640 00000005 d66c9400 d66c9420 d66ee740 c069d7e7
<0>[    3.396200] 1c20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000001f4
<0>[    3.396207] 1c40: 00000000 d66c9420 c069d745 c0fac584 d66c9400 00000000 c0fac584 00000002
<0>[    3.396214] 1c60: 0000003e c05e5485 c101d344 d66c9420 c101d348 00000000 00000000 c04afc75
<0>[    3.396222] 1c80: d66c9420 c0fac584 d6681cf8 c04affad 00000000 c0f98cb8 c0cf7a6c c04afe37
<0>[    3.396229] 1ca0: c09e36e4 c05e7b0f d66c9400 c0fac584 d66c9420 00000001 00000000 d6681cf8
<0>[    3.396236] 1cc0: c04affad 00000000 c0f98cb8 c0cf7a6c 0000003e c04ae939 d6dd8a6c d645deb8
<0>[    3.396243] 1ce0: 00000000 d66c9420 d66c9454 d66c9420 00000001 c04afadd d66c9420 00000001
<0>[    3.396250] 1d00: d66c9428 d66c9428 00000000 d66c9420 c0f98cfc c04af29f d7304e64 d66c9428
<0>[    3.396258] 1d20: 00000000 d6476c88 d66c9420 c04ad0e9 d66c9420 c04b8c93 d66c94a0 d66c9420
<0>[    3.396265] 1d40: c101d320 d66c9400 d6681d88 d6476c48 00000000 d66c9404 d66c9420 c05e5d95
<0>[    3.396272] 1d60: 00000000 c0646945 c0cc9e73 d73267d0 d732681c d6476c48 d6476c88 d7326388
<0>[    3.396279] 1d80: c0cf7a90 c05e7bd9 39386d77 00003330 00000000 00000000 00000000 001a0000
<0>[    3.396286] 1da0: 00000000 00000000 d73267d0 00000000 00000000 00000000 00000000 00000000
<0>[    3.396293] 1dc0: d6476c48 00000000 d6476c88 00000000 00000000 d7326388 7000c000 c05e61bd
<0>[    3.396300] 1de0: d6e0c000 c05e6465 fffffffe d6476c40 00000000 d6e0c010 d6e0c000 00000000
<0>[    3.396307] 1e00: d7326388 c05eac11 00000000 d6dd7dc0 d6476c40 d6debc00 00000001 d6e0c010
<0>[    3.396314] 1e20: 00000000 c0f998a4 00000000 00000000 c0f998a4 00000001 ffffe000 c04b1213
<0>[    3.396321] 1e40: c04b11e1 c101d344 d6e0c010 c101d348 00000000 c04afc75 d6e0c010 c0f998a4
<0>[    3.396328] 1e60: d6681ed0 c04affad 00000000 c0fd4c90 00000000 c04afe37 00000000 c0646805
<0>[    3.396335] 1e80: d6e0c010 c0f998a4 d6e0c010 00000001 00000000 d6681ed0 c04affad 00000000
<0>[    3.396342] 1ea0: c0fd4c90 00000000 ffffe000 c04ae939 d6ce746c d6eb9ab8 00000000 d6e0c010
<0>[    3.396350] 1ec0: d6e0c044 d6e0c010 00000001 c04afadd d6e0c010 00000001 d6e0c010 d6e0c010
<0>[    3.396357] 1ee0: c0f7d200 d6e0c010 c0f7d478 c04af29f 00000000 d6e0c010 c0f7d200 c0f7d200
<0>[    3.396364] 1f00: c0f7d21c c04af5e7 c04af59d c0f7d228 d6492180 d7301e80 d7305000 c012e74d
<0>[    3.396372] 1f20: c012f266 d7301e80 d6681f40 d6492180 d6492194 d7301e80 d7301e94 c0f03d00
<0>[    3.396379] 1f40: d7301e98 d6d17ec0 ffffe000 c012f355 ffffe000 c0fd457c c0c5ff88 c0132a24
<0>[    3.396386] 1f60: d6681f78 d6e31b40 d649e7c0 c0132a24 d6680000 d6492180 c012f11d d6d17ec0
<0>[    3.396393] 1f80: d6e31b5c c0132ac5 00000000 d649e7c0 c01329c1 00000000 00000000 00000000
<0>[    3.396400] 1fa0: 00000000 00000000 00000000 c01010bd 00000000 00000000 00000000 00000000
<0>[    3.396406] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
<0>[    3.396413] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
<4>[    3.396431] [<c05e9eb2>] (tegra_i2c_isr) from [<c0161a1d>] (__handle_irq_event_percpu+0x5d/0x1dc)
<4>[    3.396442] [<c0161a1d>] (__handle_irq_event_percpu) from [<c0161bb3>] (handle_irq_event_percpu+0x17/0x40)
<4>[    3.396450] [<c0161bb3>] (handle_irq_event_percpu) from [<c0161c09>] (handle_irq_event+0x2d/0x44)
<4>[    3.396461] [<c0161c09>] (handle_irq_event) from [<c01641f1>] (handle_fasteoi_irq+0x71/0xdc)
<4>[    3.396470] [<c01641f1>] (handle_fasteoi_irq) from [<c016103d>] (generic_handle_irq+0x1d/0x28)
<4>[    3.396479] [<c016103d>] (generic_handle_irq) from [<c01614b7>] (__handle_domain_irq+0x43/0x84)
<4>[    3.396489] [<c01614b7>] (__handle_domain_irq) from [<c03e42ab>] (gic_handle_irq+0x43/0x78)
<4>[    3.396499] [<c03e42ab>] (gic_handle_irq) from [<c0101a65>] (__irq_svc+0x65/0xac)
<4>[    3.396503] Exception stack(0xd66819f0 to 0xd6681a38)
<4>[    3.396508] 19e0:                                     60000193 16461000 00000000 a0000113
<4>[    3.396516] 1a00: 00000000 00000000 00000053 00000000 c0f0a0b0 c037a95d c0fe5228 c0fe4d28
<4>[    3.396522] 1a20: 0000000a d6681a40 c015f3d7 c015f3dc 60000133 ffffffff
<4>[    3.396532] [<c0101a65>] (__irq_svc) from [<c015f3dc>] (console_unlock+0x294/0x420)
<4>[    3.396539] [<c015f3dc>] (console_unlock) from [<c016058d>] (vprintk_emit+0x115/0x17c)
<4>[    3.396547] [<c016058d>] (vprintk_emit) from [<c04acb79>] (dev_vprintk_emit+0x99/0x14c)
<4>[    3.396555] [<c04acb79>] (dev_vprintk_emit) from [<c04acc47>] (dev_printk_emit+0x1b/0x24)
<4>[    3.396562] [<c04acc47>] (dev_printk_emit) from [<c04accb3>] (__dev_printk+0x2f/0x60)
<4>[    3.396568] [<c04accb3>] (__dev_printk) from [<c04ace3f>] (_dev_warn+0x2b/0x34)
<4>[    3.396581] [<c04ace3f>] (_dev_warn) from [<c0423f1d>] (_regulator_get+0x131/0x1d4)
<4>[    3.396590] [<c0423f1d>] (_regulator_get) from [<c0424009>] (regulator_bulk_get+0x3d/0x80)
<4>[    3.396601] [<c0424009>] (regulator_bulk_get) from [<c0424a2f>] (devm_regulator_bulk_get+0x37/0x60)
<4>[    3.396617] [<c0424a2f>] (devm_regulator_bulk_get) from [<c069d7e7>] (wm8903_i2c_probe+0xa3/0x55c)
<4>[    3.396632] [<c069d7e7>] (wm8903_i2c_probe) from [<c05e5485>] (i2c_device_probe+0x17d/0x194)
<4>[    3.396642] [<c05e5485>] (i2c_device_probe) from [<c04afc75>] (really_probe+0x141/0x1e4)
<4>[    3.396651] [<c04afc75>] (really_probe) from [<c04afe37>] (driver_probe_device+0x43/0x124)
<4>[    3.396659] [<c04afe37>] (driver_probe_device) from [<c04ae939>] (bus_for_each_drv+0x41/0x60)
<4>[    3.396667] [<c04ae939>] (bus_for_each_drv) from [<c04afadd>] (__device_attach+0x75/0xc0)
<4>[    3.396675] [<c04afadd>] (__device_attach) from [<c04af29f>] (bus_probe_device+0x5b/0x60)
<4>[    3.396682] [<c04af29f>] (bus_probe_device) from [<c04ad0e9>] (device_add+0x2a1/0x44c)
<4>[    3.396690] [<c04ad0e9>] (device_add) from [<c05e5d95>] (i2c_new_device+0xe1/0x1f8)
<4>[    3.396700] [<c05e5d95>] (i2c_new_device) from [<c05e7bd9>] (of_i2c_register_devices+0x7d/0xbc)
<4>[    3.396710] [<c05e7bd9>] (of_i2c_register_devices) from [<c05e61bd>] (i2c_register_adapter+0x105/0x2f0)
<4>[    3.396718] [<c05e61bd>] (i2c_register_adapter) from [<c05eac11>] (tegra_i2c_probe+0x30d/0x440)
<4>[    3.396728] [<c05eac11>] (tegra_i2c_probe) from [<c04b1213>] (platform_drv_probe+0x33/0x68)
<4>[    3.396737] [<c04b1213>] (platform_drv_probe) from [<c04afc75>] (really_probe+0x141/0x1e4)
<4>[    3.396745] [<c04afc75>] (really_probe) from [<c04afe37>] (driver_probe_device+0x43/0x124)
<4>[    3.396753] [<c04afe37>] (driver_probe_device) from [<c04ae939>] (bus_for_each_drv+0x41/0x60)
<4>[    3.396761] [<c04ae939>] (bus_for_each_drv) from [<c04afadd>] (__device_attach+0x75/0xc0)
<4>[    3.396769] [<c04afadd>] (__device_attach) from [<c04af29f>] (bus_probe_device+0x5b/0x60)
<4>[    3.396777] [<c04af29f>] (bus_probe_device) from [<c04af5e7>] (deferred_probe_work_func+0x4b/0x6c)
<4>[    3.396789] [<c04af5e7>] (deferred_probe_work_func) from [<c012e74d>] (process_one_work+0x155/0x3c8)
<4>[    3.396798] [<c012e74d>] (process_one_work) from [<c012f355>] (worker_thread+0x239/0x3d4)
<4>[    3.396807] [<c012f355>] (worker_thread) from [<c0132ac5>] (kthread+0x105/0x110)
<4>[    3.396814] [<c0132ac5>] (kthread) from [<c01010bd>] (ret_from_fork+0x11/0x34)
<4>[    3.396818] Exception stack(0xd6681fb0 to 0xd6681ff8)
<4>[    3.396823] 1fa0:                                     00000000 00000000 00000000 00000000
<4>[    3.396830] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
<4>[    3.396836] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
<0>[    3.396844] Code: 32b4 2b00 f43f af75 (de02) f8d4 
<4>[    3.396853] ---[ end trace e64225d6f8db918a ]---
<0>[    3.405350] Kernel panic - not syncing: Fatal exception in interrupt
<2>[    3.405365] CPU1: stopping
<4>[    3.405373] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.0.0-rc2-next-20190121-00119-gbd91760d6769-dirty #1055
<4>[    3.405376] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
<4>[    3.405396] [<c010dbed>] (unwind_backtrace) from [<c0109f45>] (show_stack+0x11/0x14)
<4>[    3.405412] [<c0109f45>] (show_stack) from [<c088568d>] (dump_stack+0x6d/0x7c)
<4>[    3.405423] [<c088568d>] (dump_stack) from [<c010c565>] (handle_IPI+0x2e5/0x308)
<4>[    3.405432] [<c010c565>] (handle_IPI) from [<c03e42dd>] (gic_handle_irq+0x75/0x78)
<4>[    3.405441] [<c03e42dd>] (gic_handle_irq) from [<c0101a65>] (__irq_svc+0x65/0xac)
<4>[    3.405444] Exception stack(0xd6d2bee8 to 0xd6d2bf30)
<4>[    3.405452] bee0:                   00000000 c0f12350 16472000 00000050 00000000 c0f12350
<4>[    3.405459] bf00: 00000000 00000000 00000000 c0fd530c caf99410 d7312678 fa000000 d6d2bf38
<4>[    3.405464] bf20: c061f981 c061fad0 60000133 ffffffff
<4>[    3.405477] [<c0101a65>] (__irq_svc) from [<c061fad0>] (cpuidle_enter_state+0x248/0x4d0)
<4>[    3.405490] [<c061fad0>] (cpuidle_enter_state) from [<c0621641>] (cpuidle_enter_state_coupled+0x1ad/0x2d4)
<4>[    3.405499] [<c0621641>] (cpuidle_enter_state_coupled) from [<c013e823>] (do_idle+0x17b/0x1b0)
<4>[    3.405507] [<c013e823>] (do_idle) from [<c013ea49>] (cpu_startup_entry+0x19/0x1c)
<4>[    3.405515] [<c013ea49>] (cpu_startup_entry) from [<00102551>] (0x102551)

