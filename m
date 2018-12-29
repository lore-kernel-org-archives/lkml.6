Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DFCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD7120866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeL2OZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 09:25:56 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46763 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeL2OZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 09:25:55 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so14459030vso.13;
        Sat, 29 Dec 2018 06:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WkW+2nyBs8a0YRWtLumej52kXcZBghTC+7NVPnQKJ9k=;
        b=ca+vgME1CdqTbX0f+0CegxymY7LIqjNEWXjeNzK4A4OoKwqTPKgnoqkILJs18PvC0g
         62tuwxRrKX8gCVMG2vNSXITCVZA1vS5+J1B3pEcDSYi9xzyw0Rx95IC6tN2wSXnPeMCd
         i/Vtbh2lApLWi30BYtGu5BNN23OP+6kaSSoX+MrTzNrn0N9V6NzCVfuGtWK7vKiku0uW
         /YBl7l6Hd8Ld44N1Zu5dIxGeGVAq43qiRCqaEFX+KKMou4++ygDLQOkSuqWmBMXfuno/
         fiMxI+088WFx5XmNqEfbUV9V3FCXCSWCk08AAfVWmcnUmuVCXhVUXqC0n0w6600g+e4X
         fYYw==
X-Gm-Message-State: AA+aEWZWJi4dGB9qgh1b1wz7GKd+QZuxfWNoYSjxaSIxYLwtQ5aC7wpj
        8c0KeVH4kuV24eyFeRCjLg/t6Xz05xyr3KxHUR8=
X-Google-Smtp-Source: AFSGD/VgLHCreSL4B+cISSGeYRsWQUR+G6jz8hnti0SblO2HG6Epbno6h3jiX7eLnM1886lh7ygtaB694In0wgrKFZI=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr13199753vsm.152.1546093551694;
 Sat, 29 Dec 2018 06:25:51 -0800 (PST)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
 <CAMuHMdXPFgp5sLR5-UExEvxNbKSR5H--dk7KMit_XFSFN+1uHw@mail.gmail.com> <1996329d875e1ab5b9cd69db187b7037ad3a0d8d.camel@perches.com>
In-Reply-To: <1996329d875e1ab5b9cd69db187b7037ad3a0d8d.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 Dec 2018 15:25:38 +0100
Message-ID: <CAMuHMdW1OqswdSRj2DROFST46dLCmMU5=ki2x0FBn8OjJjgLdg@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Joe Perches <joe@perches.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Fri, Aug 24, 2018 at 12:00 AM Joe Perches <joe@perches.com> wrote:
> On Thu, 2018-08-23 at 23:52 +0200, Geert Uytterhoeven wrote:
> > Does gcc 8.x gives again the same warnings as my venerable old gcc 4.1.2,
> > that no one else seems to see? Or will the real bugs I detect this way stay
> > unfixed? Polyculture is a good thing, also in compilers.
>
> I'm not sure I understand what you mean.
> Patches that fix defects and patches that fix warnings
> both generally get applied.

Sure, patches that fix bugs do get applied. But someone has to write
those patches first.  And something has to trigger writing those patches.
If gcc 4.1.2 generates warning for real issues, but newer compilers do not,
we loose one of the many detectors of issues.

> > Reverted locally (incl. the follow-up), applied Andrew's fix, detected new
> > warnings in v4.18+, and sent patches where it makes sense...
>
> Thanks for that.

Given the rise of anonymous unions all over the place, I gave up, and
have upgraded from gcc 4.1.2 to 7.3.0 for cross-compiling m68k kernels.
One good things is that the kernel size for an atari_defconfig kernel dropped
by 3.7% or 163 KiB.

For the record, below is a list of differences in generated warnings.
Note that the source trees are not identical, as the tree used with
gcc-7.3.0 did not include any workarounds I needed for gcc-4.1.2.
All warnings flagged by gcc 4.1.2 should be false positives (iff I did a
good job during the last few years ;-)

I plan to repeat the exercise with gcc-8.2.0 (after v4.21-rc1 or so).

--- build.log.linux-4.20.0-atari-07795-g835f16c9b68966ff-gcc-4.1.2-20061115-prerelease-Ubuntu-4.1.1-21
+++ build.log.linux-4.20.0-atari-07767-gc085b9fd60f52a62-gcc-7.3.0-27ubuntu1~18.04

20 warning regressions:
  + arch/m68k/atari/config.c: warning: ISO C90 forbids variable length
array ‘switches’ [-Wvla]:  => 151:2
  + arch/m68k/include/asm/cmpxchg.h: warning: value computed is not
used [-Wunused-value]:  => 79:22, 122:3, 137:3
  + arch/m68k/include/asm/raw_io.h: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]:  => 20:19, 33:35,
26:31, 30:32
  + arch/m68k/include/asm/string.h: warning: argument 2 null where
non-null expected [-Wnonnull]:  => 72:25
  + arch/m68k/kernel/setup_mm.c: warning: #warning Are you building an
allnoconfig kernel? [-Wcpp]:  => 51:2
  + arch/m68k/kernel/setup_mm.c: warning: #warning No CPU/platform
type selected, your kernel will not work! [-Wcpp]:  => 50:2
  + arch/m68k/kernel/signal.c: warning: ISO C90 forbids variable
length array ‘buf’ [-Wvla]:  => 654:3
  + arch/m68k/mvme147/config.c: warning: #warning check me! [-Wcpp]:  => 150:2
  + arch/m68k/mvme16x/config.c: warning: #warning check me! [-Wcpp]:  => 397:2
  + drivers/i2c/i2c-core-base.c: warning: ‘ret’ may be used
uninitialized in this function [-Wmaybe-uninitialized]:  => 235:5
  + drivers/input/joystick/analog.c: warning: #warning Precise timer
not defined for this architecture. [-Wcpp]:  => 172:2
  + include/linux/dynamic_debug.h: warning: statement will never be
executed [-Wswitch-unreachable]:  => 115:19
  + <stdin>: warning: #warning syscall io_pgetevents not implemented
[-Wcpp]:  => 1333:2
  + <stdin>: warning: #warning syscall pkey_alloc not implemented
[-Wcpp]:  => 1321:2
  + <stdin>: warning: #warning syscall pkey_free not implemented
[-Wcpp]:  => 1324:2
  + <stdin>: warning: #warning syscall pkey_mprotect not implemented
[-Wcpp]:  => 1318:2
  + <stdin>: warning: #warning syscall rseq not implemented [-Wcpp]:  => 1336:2
  + <stdin>: warning: #warning syscall seccomp not implemented
[-Wcpp]:  => 1240:2
  + warning: unmet direct dependencies detected for NEED_MULTIPLE_NODES:  => N/A
  + warning: unmet direct dependencies detected for SND_SOC_QDSP6:  => N/A

269 warning improvements:
  - arch/m68k/kernel/setup_mm.c: warning: #warning Are you building an
allnoconfig kernel?: 51:2 =>
  - arch/m68k/kernel/setup_mm.c: warning: #warning No CPU/platform
type selected, your kernel will not work!: 50:2 =>
  - arch/m68k/mvme147/config.c: warning: #warning check me!: 150:2 =>
  - arch/m68k/mvme16x/config.c: warning: #warning check me!: 397:2 =>
  - drivers/ata/ahci_qoriq.c: warning: ‘px_cmd’ may be used
uninitialized in this function: 86 =>
  - drivers/ata/ahci_qoriq.c: warning: ‘px_is’ may be used
uninitialized in this function: 86 =>
  - drivers/ata/libata-scsi.c: warning: ‘ncq_prio_enable’ may be used
uninitialized in this function: 283 =>
  - drivers/ata/pata_legacy.c: warning: value computed is not used:
897, 914, 285, 407, 898, 283, 302, 373, 410, 280, 409, 408, 909, 899,
286, 901, 282, 900, 374, 902, 376, 375, 284, 915 =>
  - drivers/ata/pata_legacy.c: warning: ‘r’ is used uninitialized in
this function: 1053 =>
  - drivers/base/regmap/regcache-rbtree.c: warning: ‘new_base_reg’ may
be used uninitialized in this function: 393 =>
  - drivers/base/regmap/regcache-rbtree.c: warning: ‘new_top_reg’ may
be used uninitialized in this function: 393 =>
  - drivers/block/null_blk_main.c: warning: value computed is not used: 375 =>
  - drivers/block/null_blk_main.c: warning: ‘sector’ may be used
uninitialized in this function: 1157 =>
  - drivers/block/null_blk_main.c: warning: ‘size’ may be used
uninitialized in this function: 1157 =>
  - drivers/block/paride/ppc6lnx.c: warning: cast to pointer from
integer of different size: 142, 575, 144, 560, 430, 329, 537, 266,
235, 131, 201, 147, 145, 162, 146, 217 =>
  - drivers/bluetooth/btqca.c: warning: ‘rom_ver’ may be used
uninitialized in this function: 339 =>
  - drivers/crypto/atmel-sha.c: warning: ‘keylen’ may be used
uninitialized in this function: 1757 =>
  - drivers/crypto/atmel-sha.c: warning: ‘key’ may be used
uninitialized in this function: 1758 =>
  - drivers/dma/ti/omap-dma.c: warning: ‘port_window_bytes’ may be
used uninitialized in this function: 887 =>
  - drivers/fsi/fsi-master-ast-cf.c: warning: ‘p’ may be used
uninitialized in this function: 443 =>
  - drivers/gpio/gpio-grgpio.c: warning: ‘lirq’ may be used
uninitialized in this function: 290 =>
  - drivers/gpu/drm/drm_edid.c: warning: ‘hdmi_len’ may be used
uninitialized in this function: 3720 =>
  - drivers/gpu/drm/drm_rect.c: warning: comparison is always true due
to limited range of data type: 106, 90, 114, 98 =>
  - drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c: warning: ‘sharp’
may be used uninitialized in this function: 353 =>
  - drivers/gpu/drm/selftests/drm_selftest.c: warning:
‘__drm_subtests’ defined but not used: 95 =>
  - drivers/gpu/drm/udl/udl_modeset.c: warning: ‘reg’ may be used
uninitialized in this function: 51 =>
  - drivers/hwmon/sch56xx-common.c: warning: cast to pointer from
integer of different size: 145 =>
  - drivers/hwmon/smsc47b397.c: warning: cast to pointer from integer
of different size: 119 =>
  - drivers/i2c/i2c-core-base.c: warning: ‘ret’ may be used
uninitialized in this function: 188 =>
  - drivers/i3c/master/dw-i3c-master.c: warning: comparison is always
false due to limited range of data type: 837, 973 =>
  - drivers/iio/accel/mma9551_core.c: warning: ‘pol_mask’ may be used
uninitialized in this function: 542 =>
  - drivers/iio/adc/rcar-gyroadc.c: warning: ‘ret’ may be used
uninitialized in this function: 341 =>
  - drivers/iio/adc/ti-ads8688.c: warning: ‘i’ may be used
uninitialized in this function: 300 =>
  - drivers/iio/adc/twl4030-madc.c: warning: comparison is always
false due to limited range of data type: 633 =>
  - drivers/iio/dac/ad5064.c: warning: type qualifiers ignored on
function return type: 791 =>
  - drivers/iio/light/hid-sensor-als.c: warning: ‘min’ may be used
uninitialized in this function: 96 =>
  - drivers/iio/light/hid-sensor-prox.c: warning: ‘min’ may be used
uninitialized in this function: 76 =>
  - drivers/iio/pressure/hid-sensor-press.c: warning: ‘min’ may be
used uninitialized in this function: 80 =>
  - drivers/infiniband/core/uverbs_cmd.c: warning: ‘ib_dev’ may be
used uninitialized in this function: 985, 510 =>
  - drivers/infiniband/core/uverbs_std_types.c: warning:
initialization from incompatible pointer type: 265, 232, 248, 252,
255, 228, 260, 220, 263, 235, 240, 243 =>
  - drivers/infiniband/core/uverbs_std_types_counters.c: warning:
initialization from incompatible pointer type: 135, 147, 121, 128 =>
  - drivers/infiniband/core/uverbs_std_types_cq.c: warning:
initialization from incompatible pointer type: 191, 201, 149 =>
  - drivers/infiniband/core/uverbs_std_types_dm.c: warning:
initialization from incompatible pointer type: 101, 108, 88 =>
  - drivers/infiniband/core/uverbs_std_types_flow_action.c: warning:
initialization from incompatible pointer type: 428, 404, 380, 435 =>
  - drivers/infiniband/core/uverbs_std_types_mr.c: warning:
initialization from incompatible pointer type: 117, 146 =>
  - drivers/infiniband/ulp/srpt/ib_srpt.c: warning: ‘prev_nents’ may
be used uninitialized in this function: 889 =>
  - drivers/input/joystick/analog.c: warning: #warning Precise timer
not defined for this architecture.: 172:2 =>
  - drivers/input/mouse/pc110pad.c: warning: value computed is not used: 64 =>
  - drivers/input/rmi4/rmi_driver.c: warning: comparison is always
false due to limited range of data type: 582 =>
  - drivers/input/touchscreen/htcpen.c: warning: value computed is not
used: 87, 153 =>
  - drivers/iommu/io-pgtable-arm-v7s.c: warning: ‘cptep’ may be used
uninitialized in this function: 434 =>
  - drivers/macintosh/via-pmu.c: warning: ‘gpio1_interrupt’ defined
but not used: 1707 =>
  - drivers/md/bcache/alloc.c: warning: ‘bucket’ may be used
uninitialized in this function: 331 =>
  - drivers/md/dm-stats.c: warning: ‘mult’ may be used uninitialized
in this function: 781 =>
  - drivers/md/dm-zoned-metadata.c: warning: ‘dmap’ may be used
uninitialized in this function: 1305 =>
  - drivers/md/raid10.c: warning: ‘rp_repl’ may be used uninitialized
in this function: 204 =>
  - drivers/media/cec/cec-api.c: warning: ‘ev_idx’ may be used
uninitialized in this function: 301 =>
  - drivers/media/i2c/mt9v111.c: warning: ‘new_fmt.code’ may be used
uninitialized in this function: 884 =>
  - drivers/media/platform/vicodec/codec-fwht.c: warning: ‘stat’ may
be used uninitialized in this function: 808 =>
  - drivers/media/platform/vivid/vivid-cec.c: warning: ‘bit’ may be
used uninitialized in this function: 69 =>
  - drivers/media/usb/dvb-usb/pctv452e.c: warning: value computed is
not used: 922 =>
  - drivers/mfd/lm3533-ctrlbank.c: warning: comparison is always false
due to limited range of data type: 129 =>
  - drivers/misc/altera-stapl/altera-lpt.c: warning: cast to pointer
from integer of different size: 40, 34 =>
  - drivers/mtd/nand/raw/fsmc_nand.c: warning: comparison is always
false due to limited range of data type: 324, 316, 309 =>
  - drivers/mtd/nand/raw/nand_base.c: warning: ‘best_ecc_bytes’ may be
used uninitialized in this function: 5264, 5345 =>
  - drivers/mtd/nand/raw/nand_base.c: warning: ‘best_step’ may be used
uninitialized in this function: 5264 =>
  - drivers/mtd/nand/raw/nand_base.c: warning: ‘best_strength’ may be
used uninitialized in this function: 5345, 5264 =>
  - drivers/mtd/nand/raw/vf610_nfc.c: warning: ‘offset’ may be used
uninitialized in this function: 367 =>
  - drivers/net/ethernet/8390/wd.c: warning: cast to pointer from
integer of different size: 289, 296 =>
  - drivers/net/ethernet/apm/xgene/xgene_enet_main.c: warning:
‘offset’ may be used uninitialized in this function: 431 =>
  - drivers/net/ethernet/apm/xgene/xgene_enet_main.c: warning:
‘pbuf_addr’ may be used uninitialized in this function: 424 =>
  - drivers/net/ethernet/apm/xgene/xgene_enet_main.c: warning: ‘size’
may be used uninitialized in this function: 431 =>
  - drivers/net/ethernet/broadcom/genet/bcmgenet.c: warning:
‘tx_cb_ptr’ may be used uninitialized in this function: 1551 =>
  - drivers/net/ethernet/freescale/fec_main.c: warning: ‘vlan_tag’ may
be used uninitialized in this function: 1369 =>
  - drivers/net/ethernet/freescale/fec_ptp.c: warning: ‘corr_inc’ may
be used uninitialized in this function: 293 =>
  - drivers/net/ethernet/freescale/fec_ptp.c: warning: ‘corr_period’
may be used uninitialized in this function: 293 =>
  - drivers/net/ethernet/hisilicon/hns/hns_enet.c: warning:
‘last_offset’ may be used uninitialized in this function: 424 =>
  - drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c: warning:
comparison is always false due to limited range of data type: 396 =>
  - drivers/net/ethernet/stmicro/stmmac/dwmac5.c: warning:
‘min_prio_idx’ may be used uninitialized in this function: 378 =>
  - drivers/net/ethernet/via/via-rhine.c: warning: ‘sd.dma’ may be
used uninitialized in this function: 2121 =>
  - drivers/net/gtp.c: warning: ‘pktinfo.fl4.daddr’ may be used
uninitialized in this function: 559 =>
  - drivers/net/gtp.c: warning: ‘pktinfo.fl4.saddr’ may be used
uninitialized in this function: 559 =>
  - drivers/net/gtp.c: warning: ‘pktinfo.gtph_port’ may be used
uninitialized in this function: 559 =>
  - drivers/net/gtp.c: warning: ‘pktinfo.iph’ may be used
uninitialized in this function: 559 =>
  - drivers/net/gtp.c: warning: ‘pktinfo.rt’ may be used uninitialized
in this function: 559 =>
  - drivers/net/gtp.c: warning: ‘pktinfo.sk’ may be used uninitialized
in this function: 559 =>
  - drivers/net/ieee802154/adf7242.c: warning: ‘status’ may be used
uninitialized in this function: 509 =>
  - drivers/net/macvlan.c: warning: ‘mode’ may be used uninitialized
in this function: 1483 =>
  - drivers/net/tun.c: warning: ‘copylen’ may be used uninitialized in
this function: 1757 =>
  - drivers/net/tun.c: warning: ‘linear’ may be used uninitialized in
this function: 1753 =>
  - drivers/net/wireless/ath/ath6kl/htc_pipe.c: warning: ‘packet’ may
be used uninitialized in this function: 211 =>
  - drivers/net/wireless/broadcom/b43/phy_n.c: warning: ‘idx’ may be
used uninitialized in this function: 3999 =>
  - drivers/net/wireless/broadcom/b43/phy_n.c: warning: ‘val_addr’ may
be used uninitialized in this function: 174 =>
  - drivers/net/wireless/broadcom/b43/radio_2057.c: warning: ‘size’
may be used uninitialized in this function: 541 =>
  - drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c: warning:
comparison is always false due to limited range of data type: 5432 =>
  - drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c: warning:
‘seq.head.next’ is used uninitialized in this function: 515 =>
  - drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c: warning:
‘seq.head.prev’ is used uninitialized in this function: 515 =>
  - drivers/net/wireless/ralink/rt2x00/rt2800lib.c: warning:
‘gf20_mode’ may be used uninitialized in this function: 1913 =>
  - drivers/net/wireless/ralink/rt2x00/rt2800lib.c: warning:
‘gf40_mode’ may be used uninitialized in this function: 1913 =>
  - drivers/net/wireless/ralink/rt2x00/rt2800lib.c: warning:
‘mm20_mode’ may be used uninitialized in this function: 1913 =>
  - drivers/net/wireless/ralink/rt2x00/rt2800lib.c: warning:
‘mm40_mode’ may be used uninitialized in this function: 1913 =>
  - drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: warning:
‘rf_amode’ may be used uninitialized in this function: 3438 =>
  - drivers/net/wireless/st/cw1200/scan.c: warning: value computed is
not used: 335 =>
  - drivers/net/wireless/st/cw1200/sta.c: warning: value computed is
not used: 143 =>
  - drivers/net/wireless/ti/wl1251/main.c: warning: comparison is
always true due to limited range of data type: 907 =>
  - drivers/net/wireless/ti/wl18xx/event.c: warning: comparison is
always true due to limited range of data type: 100 =>
  - drivers/net/wireless/ti/wlcore/main.c: warning: comparison is
always true due to limited range of data type: 3523 =>
  - drivers/nfc/nfcmrvl/i2c.c: warning: comparison is always false due
to limited range of data type: 52 =>
  - drivers/nfc/trf7970a.c: warning: comparison is always false due to
limited range of data type: 767 =>
  - drivers/of/overlay.c: warning: ‘fragment’ may be used
uninitialized in this function: 183 =>
  - drivers/of/unittest.c: warning: ‘overlay_base_symbols’ may be used
uninitialized in this function: 2313 =>
  - drivers/scsi/imm.c: warning: cast to pointer from integer of
different size: 563, 305, 494, 247, 473, 303, 461, 463, 486, 465, 470,
467, 341 =>
  - drivers/scsi/libfc/fc_elsct.c: warning: ‘fh_type’ may be used
uninitialized in this function: 51 =>
  - drivers/scsi/libfc/fc_elsct.c: warning: ‘r_ctl’ may be used
uninitialized in this function: 50 =>
  - drivers/scsi/ppa.c: warning: cast to pointer from integer of
different size: 439, 399, 245, 436, 379, 257 =>
  - drivers/scsi/scsi_debug.c: warning: value computed is not used: 1624 =>
  - drivers/scsi/sd.c: warning: comparison is always false due to
limited range of data type: 2472 =>
  - drivers/soc/qcom/rpmh.c: warning: ‘ret’ may be used uninitialized
in this function: 355 =>
  - drivers/soc/renesas/renesas-soc.c: warning: ‘eslo’ may be used
uninitialized in this function: 290 =>
  - drivers/spi/spi-npcm-pspi.c: warning: ‘mode_val’ may be used
uninitialized in this function: 113 =>
  - drivers/spi/spi-uniphier.c: warning: ‘val1’ may be used
uninitialized in this function: 117 =>
  - drivers/spi/spi-uniphier.c: warning: ‘val2’ may be used
uninitialized in this function: 117 =>
  - drivers/staging/comedi/drivers/pcl816.c: warning: ‘last_chan’ may
be used uninitialized in this function: 157 =>
  - drivers/staging/comedi/drivers/pcl818.c: warning: ‘last_chan’ may
be used uninitialized in this function: 347 =>
  - drivers/staging/erofs/data.c: warning: ‘last_block’ may be used
uninitialized in this function: 377 =>
  - drivers/staging/fbtft/fbtft-core.c: warning: ‘ts_start’ may be
used uninitialized in this function: 349 =>
  - drivers/staging/greybus/bootrom.c: warning: ‘offset’ may be used
uninitialized in this function: 247 =>
  - drivers/staging/greybus/bootrom.c: warning: ‘size’ may be used
uninitialized in this function: 247 =>
  - drivers/staging/rtl8188eu/hal/phy.c: warning: ‘path_a_ok’ may be
used uninitialized in this function: 954 =>
  - drivers/staging/rtl8188eu/hal/phy.c: warning: ‘path_b_ok’ may be
used uninitialized in this function: 954 =>
  - drivers/staging/rtl8712/rtl8712_recv.c: warning: ‘rx_pwr_all’ may
be used uninitialized in this function: 732 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning: previous
declaration of ‘rtw_clear_scan_deny’ was here: 618 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning: previous
declaration of ‘rtw_dec_to_roam’ was here: 681 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning: previous
declaration of ‘rtw_indicate_scan_done’ was here: 602 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning: previous
declaration of ‘rtw_set_to_roam’ was here: 680 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning: previous
declaration of ‘rtw_to_roam’ was here: 682 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning:
‘rtw_clear_scan_deny’ declared inline after being called: 618 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning:
‘rtw_dec_to_roam’ declared inline after being called: 681 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning:
‘rtw_indicate_scan_done’ declared inline after being called: 602 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning:
‘rtw_set_to_roam’ declared inline after being called: 680 =>
  - drivers/staging/rtl8723bs/include/rtw_mlme.h: warning:
‘rtw_to_roam’ declared inline after being called: 682 =>
  - drivers/target/target_core_user.c: warning: ‘dbi’ may be used
uninitialized in this function: 676 =>
  - drivers/tty/rocket_int.h: warning: cast to pointer from integer of
different size: 46, 73, 54, 68 =>
  - drivers/tty/serial/8250/8250_core.c: warning: ‘i’ may be used
uninitialized in this function: 227 =>
  - drivers/tty/serial/8250/8250_port.c: warning: ‘flags’ may be used
uninitialized in this function: 3234 =>
  - drivers/tty/serial/sh-sci.c: warning: ‘flags’ may be used
uninitialized in this function: 2969 =>
  - drivers/tty/serial/st-asc.c: warning: ‘flags’ may be used
uninitialized in this function: 881 =>
  - drivers/tty/serial/xilinx_uartps.c: warning: ‘flags’ may be used
uninitialized in this function: 1177 =>
  - drivers/tty/vt/keyboard.c: warning: comparison is always true due
to limited range of data type: 739 =>
  - drivers/usb/dwc2/gadget.c: warning: ‘flags’ may be used
uninitialized in this function: 4072 =>
  - drivers/usb/dwc2/params.c: warning: comparison is always false due
to limited range of data type: 598 =>
  - drivers/usb/gadget/function/f_hid.c: warning: comparison is always
false due to limited range of data type: 926, 925, 924 =>
  - drivers/usb/gadget/function/uvc_configfs.c: warning: comparison is
always false due to limited range of data type: 1589, 1588, 1785, 204
=>
  - drivers/usb/gadget/udc/aspeed-vhub/dev.c: warning: ‘max’ may be
used uninitialized in this function: 341 =>
  - drivers/usb/gadget/udc/bdc/bdc_core.c: warning: ‘status’ may be
used uninitialized in this function: 34 =>
  - drivers/usb/host/max3421-hcd.c: warning: ‘max3421_hcd’ may be used
uninitialized in this function: 1864 =>
  - drivers/usb/host/xhci-hub.c: warning: ‘ssa_count’ may be used
uninitialized in this function: 58 =>
  - drivers/video/fbdev/omap2/omapfb/dss/dispc.c: warning: ‘flags’ may
be used uninitialized in this function: 282 =>
  - fs/afs/dynroot.c: warning: ‘len’ may be used uninitialized in this
function: 100 =>
  - fs/btrfs/check-integrity.c: warning: ‘next_bytenr’ may be used
uninitialized in this function: 843, 2213, 678 =>
  - fs/btrfs/check-integrity.c: warning: ‘tmp_disk_key.objectid’ may
be used uninitialized in this function: 847 =>
  - fs/btrfs/extent_io.c: warning: ‘tree’ may be used uninitialized in
this function: 2486 =>
  - fs/btrfs/inode.c: warning: ‘disk_num_bytes’ may be used
uninitialized in this function: 1277 =>
  - fs/btrfs/inode.c: warning: ‘extent_offset’ may be used
uninitialized in this function: 1274 =>
  - fs/btrfs/inode.c: warning: ‘ram_bytes’ may be used uninitialized
in this function: 1278 =>
  - fs/btrfs/ref-verify.c: warning: ‘ret’ may be used uninitialized in
this function: 450, 514 =>
  - fs/btrfs/tree-log.c: warning: ‘start_slot’ may be used
uninitialized in this function: 4278 =>
  - fs/ceph/file.c: warning: value computed is not used: 831 =>
  - fs/cifs/connect.c: warning: ‘rc’ may be used uninitialized in this
function: 3960 =>
  - fs/cifs/connect.c: warning: ‘ses’ may be used uninitialized in
this function: 3962 =>
  - fs/cifs/connect.c: warning: ‘tcon’ may be used uninitialized in
this function: 3963 =>
  - fs/cifs/connect.c: warning: ‘xid’ may be used uninitialized in
this function: 3961 =>
  - fs/cifs/smbdirect.c: warning: ‘rc’ may be used uninitialized in
this function: 2113 =>
  - fs/dcache.c: warning: ‘n’ may be used uninitialized in this
function: 2709, 2544 =>
  - fs/f2fs/data.c: warning: ‘flags’ may be used uninitialized in this
function: 1341 =>
  - fs/f2fs/data.c: warning: ‘len’ may be used uninitialized in this
function: 1340 =>
  - fs/f2fs/file.c: warning: ‘err’ may be used uninitialized in this
function: 2926 =>
  - fs/f2fs/node.c: warning: ‘head’ may be used uninitialized in this
function: 237 =>
  - fs/f2fs/node.c: warning: ‘nat_blk’ may be used uninitialized in
this function: 2730 =>
  - fs/iomap.c: warning: value computed is not used: 1531 =>
  - fs/nfs/callback_xdr.c: warning: ‘op_nr’ may be used uninitialized
in this function: 880 =>
  - fs/nfs/nfs3acl.c: warning: value computed is not used: 44 =>
  - fs/nfs/nfs3proc.c: warning: value computed is not used: 798 =>
  - fs/nfsd/nfs4xdr.c: warning: ‘next’ may be used uninitialized in
this function: 2065 =>
  - fs/ocfs2/file.c: warning: value computed is not used: 2386 =>
  - fs/ocfs2/file.c: warning: ‘had_lock’ may be used uninitialized in
this function: 1136 =>
  - fs/posix_acl.c: warning: value computed is not used: 147 =>
  - fs/proc/inode.c: warning: ‘pdeo’ may be used uninitialized in this
function: 341 =>
  - fs/splice.c: warning: ‘ret’ may be used uninitialized in this
function: 695 =>
  - fs/udf/super.c: warning: ‘map’ may be used uninitialized in this
function: 1197 =>
  - fs/udf/unicode.c: warning: ‘c’ may be used uninitialized in this
function: 98 =>
  - fs/xfs/libxfs/xfs_sb.c: warning: ‘error’ may be used uninitialized
in this function: 877 =>
  - fs/xfs/scrub/repair.c: warning: ‘freelen’ may be used
uninitialized in this function: 203 =>
  - fs/xfs/scrub/repair.c: warning: ‘usedlen’ may be used
uninitialized in this function: 202 =>
  - fs/xfs/xfs_buf.c: warning: value computed is not used: 1319 =>
  - fs/xfs/xfs_log_recover.c: warning: ‘uuid’ may be used
uninitialized in this function: 2272 =>
  - include/linux/net_dim.h: warning: ‘curr_stats.bpms’ may be used
uninitialized in this function: 390 =>
  - include/linux/net_dim.h: warning: ‘curr_stats.epms’ may be used
uninitialized in this function: 390 =>
  - include/linux/net_dim.h: warning: ‘curr_stats.ppms’ may be used
uninitialized in this function: 390 =>
  - include/linux/sbitmap.h: warning: value computed is not used: 491 =>
  - include/linux/sunrpc/xdr.h: warning: ‘len’ may be used
uninitialized in this function: 480, 512 =>
  - ipc/shm.c: warning: ‘file’ may be used uninitialized in this
function: 1608 =>
  - ipc/util.c: warning: comparison is always false due to limited
range of data type: 220 =>
  - kernel/acct.c: warning: value computed is not used: 177 =>
  - kernel/bpf/verifier.c: warning: ‘prev_offset’ may be used
uninitialized in this function: 4813 =>
  - kernel/cgroup/cgroup-v1.c: warning: ‘root’ may be used
uninitialized in this function: 1114 =>
  - kernel/printk/printk.c: warning: ‘old’ may be used uninitialized
in this function: 161 =>
  - kernel/time/timekeeping.c: warning: comparison is always false due
to limited range of data type: 2298, 2300 =>
  - kernel/time/timekeeping.c: warning: ‘cs_was_changed_seq’ may be
used uninitialized in this function: 1124 =>
  - lib/assoc_array.c: warning: ‘j’ may be used uninitialized in this
function: 490 =>
  - lib/errseq.c: warning: value computed is not used: 200 =>
  - lib/mpi/mpicoder.c: warning: ‘buff’ may be used uninitialized in
this function: 336 =>
  - lib/rhashtable.c: warning: ‘next’ may be used uninitialized in
this function: 229 =>
  - lib/sbitmap.c: warning: value computed is not used: 451 =>
  - lib/test_overflow.c: warning: comparison is always false due to
limited range of data type: 415, 327, 328, 383, 330, 449, 381, 324,
453, 353, 425, 452, 413, 439, 323, 326, 448, 367, 329, 437, 366, 325,
427, 352 =>
  - mm/ksm.c: warning: ‘found_rmap_hlist_len’ may be used
uninitialized in this function: 1367 =>
  - mm/ksm.c: warning: ‘stable_node’ may be used uninitialized in this
function: 1808 =>
  - mm/memcontrol.c: warning: value computed is not used: 1047 =>
  - mm/page-writeback.c: warning: ‘filepages’ is used uninitialized in
this function: 1952, 1624 =>
  - mm/page-writeback.c: warning: ‘headroom’ is used uninitialized in
this function: 1952, 1624 =>
  - mm/page-writeback.c: warning: ‘writeback’ is used uninitialized in
this function: 1623 =>
  - mm/page_isolation.c: warning: ‘order’ may be used uninitialized in
this function: 96 =>
  - mm/shmem.c: warning: comparison is always false due to limited
range of data type: 1604 =>
  - mm/zswap.c: warning: ‘ret’ may be used uninitialized in this
function: 860 =>
  - net/batman-adv/netlink.c: warning: ‘msg_head’ may be used
uninitialized in this function: 337, 196 =>
  - net/bluetooth/l2cap_core.c: warning: comparison is always false
due to limited range of data type: 3820 =>
  - net/bridge/br_netlink.c: warning: ‘err’ may be used uninitialized
in this function: 591 =>
  - net/ceph/ceph_fs.c: warning: ‘mode’ may be used uninitialized in
this function: 59 =>
  - net/core/dev.c: warning: ‘tail’ may be used uninitialized in this
function: 3389 =>
  - net/core/filter.c: warning: value computed is not used: 3469 =>
  - net/core/rtnetlink.c: warning: ‘ivvl[0]’ may be used uninitialized
in this function: 2214 =>
  - net/core/sock.c: warning: value computed is not used: 1003 =>
  - net/hsr/hsr_device.c: warning: ‘hsr_tag’ may be used uninitialized
in this function: 259 =>
  - net/ieee802154/6lowpan/rx.c: warning: comparison is always true
due to limited range of data type: 251 =>
  - net/ieee802154/nl802154.c: warning: ‘wpan_dev_id’ may be used
uninitialized in this function: 49 =>
  - net/ipv4/ipmr.c: warning: ‘uc’ may be used uninitialized in this
function: 1224 =>
  - net/ipv4/tcp_bbr.c: warning: value computed is not used: 935 =>
  - net/ipv4/tcp_input.c: warning: ‘last_ackt’ may be used
uninitialized in this function: 3049 =>
  - net/ipv6/ip6mr.c: warning: ‘uc’ may be used uninitialized in this
function: 1405 =>
  - net/mac80211/ht.c: warning: ‘smps_mode’ may be used uninitialized
in this function: 141 =>
  - net/mac80211/mesh_pathtbl.c: warning: ‘mpath’ may be used
uninitialized in this function: 417 =>
  - net/mac80211/mlme.c: warning: ‘pwr_level_80211h’ may be used
uninitialized in this function: 1479 =>
  - net/mac80211/tdls.c: warning: ‘subband_start’ may be used
uninitialized in this function: 78 =>
  - net/mac80211/tx.c: warning: ‘chanctx_conf’ may be used
uninitialized in this function: 2452 =>
  - net/ncsi/ncsi-manage.c: warning: ‘vid’ is used uninitialized in
this function: 661 =>
  - net/ncsi/ncsi-netlink.c: warning: ‘channel_id’ may be used
uninitialized in this function: 275 =>
  - net/netfilter/nf_conntrack_core.c: warning: ‘bucket’ may be used
uninitialized in this function: 1078 =>
  - net/sunrpc/xprtrdma/svc_rdma_recvfrom.c: warning: ‘position’ may
be used uninitialized in this function: 398 =>
  - net/tipc/socket.c: warning: ‘copy’ may be used uninitialized in
this function: 1734 =>
  - net/tls/tls_sw.c: warning: ‘control’ may be used uninitialized in
this function: 1479 =>
  - net/wireless/nl80211.c: warning: ‘wdev_id’ may be used
uninitialized in this function: 71 =>
  - security/apparmor/policy_unpack.c: warning: ‘pos’ may be used
uninitialized in this function: 467 =>
  - sound/firewire/motu/amdtp-motu.c: warning: ‘copy_message’ defined
but not used: 288 =>
  - sound/firewire/motu/amdtp-motu.c: warning: ‘copy_sph’ defined but
not used: 274 =>
  - sound/soc/codecs/arizona.c: warning: ‘aif_rx_state’ may be used
uninitialized in this function: 1793 =>
  - sound/soc/codecs/arizona.c: warning: ‘aif_tx_state’ may be used
uninitialized in this function: 1793 =>
  - sound/soc/codecs/da7219-aad.c: warning: ‘pll_ctrl’ may be used
uninitialized in this function: 121 =>
  - sound/soc/codecs/rt5665.c: warning: ‘val1’ may be used
uninitialized in this function: 2634 =>
  - sound/soc/codecs/rt5665.c: warning: ‘val2’ may be used
uninitialized in this function: 2634 =>
  - sound/soc/codecs/wm8996.c: warning: ‘bclk_reg’ may be used
uninitialized in this function: 1538 =>
  - sound/soc/xtensa/xtfpga-i2s.c: warning: value computed is not used: 172 =>
  - <stdin>: warning: #warning syscall  LD [M]
net/netfilter/xt_iprange.ko: 1240:2 =>
  - <stdin>: warning: #warning syscall io_pgetevents not implemented: 1333:2 =>
  - <stdin>: warning: #warning syscall pkey_alloc not implemented: 1321:2 =>
  - <stdin>: warning: #warning syscall pkey_free not implemented: 1324:2 =>
  - <stdin>: warning: #warning syscall pkey_mprotect not implemented: 1318:2 =>
  - <stdin>: warning: #warning syscall rseq not implemented: 1336:2 =>
  - <stdin>: warning: #warning syscall seccomp not implemented: 1240:2 =>
  - {standard input}: Warning: expression out of range: defaulting to
0: 2955, 2956 =>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
