Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeDWSvJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:51:09 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:46301 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:51:07 -0400
X-Google-Smtp-Source: AIpwx48vqu/mIRJGUvniDk1aCbFcQHZVqeobt1l6wtNrHMg+dF8n9aePiyE5+8Lf1fQsgZd4+1ScjWzJMtcywJCYKj4=
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 23 Apr 2018 20:50:46 +0200
X-Google-Sender-Auth: f7JwMq-UACyE3Ha6jZYwcv91ly8
Message-ID: <CA+7wUszgY3uFVfMe4T-_5x9KuzWNSgKHXcRKgfcmpE+Keo73Vg@mail.gmail.com>
Subject: Tracking: radeon 0000:00:10.0: ring 0 stalled for more than 10240msec
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am pretty sure I was able to run kodi on an old Mac Mini G4 (big
endian) with AMD RV280. Today it is failing to start with:

[  162.971551] radeon 0000:00:10.0: ring 0 stalled for more than 10240msec
[  162.971568] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  163.482863] radeon 0000:00:10.0: ring 0 stalled for more than 10752msec
[  163.482880] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  163.994225] radeon 0000:00:10.0: ring 0 stalled for more than 11264msec
[  163.994241] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  164.505598] radeon 0000:00:10.0: ring 0 stalled for more than 11776msec
[  164.505614] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  165.016996] radeon 0000:00:10.0: ring 0 stalled for more than 12288msec
[  165.017013] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  165.528429] radeon 0000:00:10.0: ring 0 stalled for more than 12800msec
[  165.528446] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  166.039865] radeon 0000:00:10.0: ring 0 stalled for more than 13312msec
[  166.039882] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  166.551351] radeon 0000:00:10.0: ring 0 stalled for more than 13824msec
[  166.551368] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  167.062819] radeon 0000:00:10.0: ring 0 stalled for more than 14336msec
[  167.062836] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  167.574331] radeon 0000:00:10.0: ring 0 stalled for more than 14848msec
[  167.574348] radeon 0000:00:10.0: GPU lockup (current fence id
0x00000000000001d6 last fence id 0x00000000000001d7 on ring 0)
[  167.798244] [TTM] Buffer eviction failed
[  167.940488] radeon: wait for empty RBBM fifo failed! Bad things might happen.
[  168.076053] Failed to wait GUI idle while programming pipes. Bad
things might happen.
[  168.092258] radeon 0000:00:10.0: Saved 91 dwords of commands on ring 0.
[  168.092380] radeon 0000:00:10.0: (r100_asic_reset:2560)
RBBM_STATUS=0x83F96100
[  168.589895] radeon 0000:00:10.0: (r100_asic_reset:2581)
RBBM_STATUS=0x80010140
[  169.083456] radeon 0000:00:10.0: (r100_asic_reset:2589)
RBBM_STATUS=0x00000140
[  169.083482] radeon 0000:00:10.0: GPU reset succeed
[  169.083487] radeon 0000:00:10.0: GPU reset succeeded, trying to resume
[  169.083550] radeon 0000:00:10.0: WB disabled
[  169.083561] radeon 0000:00:10.0: fence driver on ring 0 use gpu
addr 0x0000000000000000 and cpu addr 0x883a5378
[  169.083612] [drm] radeon: ring at 0x0000000000001000
[  169.228838] [drm:r100_ring_test [radeon]] *ERROR* radeon: ring test
failed (scratch(0x15E8)=0xCAFEDEAD)
[  169.228910] [drm:r100_cp_init [radeon]] *ERROR* radeon: cp isn't
working (-22).
[  169.228919] radeon 0000:00:10.0: failed initializing CP (-22).


How should I go and debug this (other than plain git-bisect) ?

For reference:

# modprobe radeon

...

[  100.369890] [drm] radeon kernel modesetting enabled.
[  100.377816] checking generic (9c008000 5a000) vs hw (98000000 8000000)
[  100.377824] fb: switching to radeondrmfb from OFfb ATY,RockHo
[  100.382566] Console: switching to colour dummy device 80x25
[  100.386224] radeon 0000:00:10.0: enabling device (0006 -> 0007)
[  100.389596] [drm] initializing kernel modesetting (RV280
0x1002:0x5962 0x1002:0x5962 0x01).
[  100.389783] radeon 0000:00:10.0: Invalid PCI ROM header signature:
expecting 0xaa55, got 0x0000
[  100.389813] radeon 0000:00:10.0: Invalid PCI ROM header signature:
expecting 0xaa55, got 0x0000
[  100.390218] [drm:radeon_get_bios [radeon]] *ERROR* Unable to locate
a BIOS ROM
[  100.390247] [drm] Using device-tree clock info
[  100.390286] agpgart-uninorth 0000:00:0b.0: putting AGP V2 device into 4x mode
[  100.390300] radeon 0000:00:10.0: putting AGP V2 device into 4x mode
[  100.390345] radeon 0000:00:10.0: GTT: 256M 0x00000000 - 0x0FFFFFFF
[  100.390355] [drm] Generation 2 PCI interface, using max accessible memory
[  100.390368] radeon 0000:00:10.0: VRAM: 128M 0x0000000098000000 -
0x000000009FFFFFFF (32M used)
[  100.390406] [drm] Detected VRAM RAM=128M, BAR=128M
[  100.390415] [drm] RAM width 64bits DDR
[  100.405414] [TTM] Zone  kernel: Available graphics memory: 254062 kiB
[  100.405444] [TTM] Initializing pool allocator
[  100.405542] [drm] radeon: 32M of VRAM memory ready
[  100.405554] [drm] radeon: 256M of GTT memory ready.
[  100.406161] radeon 0000:00:10.0: WB disabled
[  100.406187] radeon 0000:00:10.0: fence driver on ring 0 use gpu
addr 0x0000000000000000 and cpu addr 0x883a5378
[  100.406204] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  100.406212] [drm] Driver supports precise vblank timestamp query.
[  100.406252] [drm] radeon: irq initialized.
[  100.406276] [drm] Loading R200 Microcode
[  100.446688] radeon 0000:00:10.0: firmware: direct-loading firmware
radeon/R200_cp.bin
[  100.447755] [drm] radeon: ring at 0x0000000000001000
[  100.447800] [drm] ring test succeeded in 0 usecs
[  100.448435] [drm] ib test succeeded in 0 usecs
[  100.454640] [drm] Connector Table: 7 (mini internal tmds)
[  100.454680] [drm] No TMDS info found in BIOS
[  100.454692] [drm] No TV DAC info found in BIOS
[  100.454900] [drm] Radeon Display Connectors
[  100.454910] [drm] Connector 0:
[  100.454916] [drm]   DVI-I-1
[  100.454922] [drm]   HPD1
[  100.454930] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[  100.454937] [drm]   Encoders:
[  100.454944] [drm]     DFP1: INTERNAL_TMDS1
[  100.454951] [drm]     CRT2: INTERNAL_DAC2
[  100.454958] [drm] Connector 1:
[  100.454963] [drm]   SVIDEO-1
[  100.454969] [drm]   Encoders:
[  100.454975] [drm]     TV1: INTERNAL_DAC2
[  100.542734] [drm] fb mappable at 0x98040000
[  100.542764] [drm] vram apper at 0x98000000
[  100.542770] [drm] size 1572864
[  100.542777] [drm] fb depth is 16
[  100.542783] [drm]    pitch is 2048
[  100.614204] Console: switching to colour frame buffer device 128x48
[  100.623505] radeon 0000:00:10.0: fb0: radeondrmfb frame buffer device
[  100.634507] [drm] Initialized radeon 2.50.0 20080528 for
0000:00:10.0 on minor 0


Thanks
