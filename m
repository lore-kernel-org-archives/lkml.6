Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeBSN5g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:57:36 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:58894 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeBSN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:57:30 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v4.16-rc2
Date: Mon, 19 Feb 2018 14:57:27 +0100
Message-Id: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v4.16-rc2[1] compared to v4.15[2].

Summarized:
  - build errors: +16/-5
  - build warnings: +1659/-1549

JFYI, when comparing v4.16-rc2[1] to v4.16-rc1[3], the summaries are:
  - build errors: +5/-2
  - build warnings: +1087/-1095

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/head/91ab883eb21325ad80f3473633f794c78ac87f51/ (all 274 configs)
[2] http://kisskb.ellerman.id.au/kisskb/head/d8a5b80568a9cb66810e75b182018e9edb68e8ff/ (271 out of 274 configs)
[3] http://kisskb.ellerman.id.au/kisskb/head/7928b2cbe55b2a410a0f5c1f154610059c57b1b2/ (273 out of 274 configs)


*** ERRORS ***

16 error regressions:
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: junk at end of line, first unrecognized character is `U':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: missing ')':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected characters following instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected characters following instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL':  => 677
  + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]:  => 1361:2
  + /home/kisskb/slave/src/drivers/net/ethernet/intel/i40e/i40e_ethtool.c: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]:  => 4443:6, 4443:2
  + /home/kisskb/slave/src/fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function):  => 126:26
  + error: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: hotplug-cpu.c: undefined reference to `timed_topology_update':  => .text+0x138), .text+0x410)

5 error improvements:
  - /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error: 'cached_to_uncached' undeclared (first use in this function): 99:17 => 
  - /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]: 192:2 => 
  - /home/kisskb/slave/src/drivers/dma/omap-dma.c: error: unrecognizable insn:: 353:1 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_syncmap.c: error: 'err' may be used uninitialized in this function [-Werror=uninitialized]: 443:2 => 
  - error: "sgimc" [drivers/watchdog/indydog.ko] undefined!: N/A => 


*** WARNINGS ***

[Deleted 1135 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
[Deleted 1433 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

1659 warning regressions:
  + /home/kisskb/slave/src/arch/parisc/include/uapi/asm/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 13:2
  + /home/kisskb/slave/src/arch/parisc/include/uapi/asm/swab.h: warning: 'clearval' may be used uninitialized in this function [-Wuninitialized]:  => 34:2
  + /home/kisskb/slave/src/arch/parisc/include/uapi/asm/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 13:2
  + /home/kisskb/slave/src/arch/parisc/include/uapi/asm/swab.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 13:2
  + /home/kisskb/slave/src/arch/powerpc/include/asm/io.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 178:1
  + /home/kisskb/slave/src/arch/powerpc/include/asm/io.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 178:1
  + /home/kisskb/slave/src/arch/powerpc/include/asm/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 178:1
  + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: warning: 'emulated' may be used uninitialized in this function [-Wuninitialized]:  => 1361:2
  + /home/kisskb/slave/src/arch/x86/kvm/svm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 6519:6, 6168:9
  + /home/kisskb/slave/src/crypto/tcrypt.c: warning: 'do_mult_acipher_op' uses dynamic stack allocation [enabled by default]:  => 1144:1
  + /home/kisskb/slave/src/crypto/tcrypt.c: warning: 'do_mult_aead_op' uses dynamic stack allocation [enabled by default]:  => 184:1
  + /home/kisskb/slave/src/crypto/tcrypt.c: warning: 'test_mb_ahash_cycles' uses dynamic stack allocation [enabled by default]:  => 782:1
  + /home/kisskb/slave/src/crypto/tcrypt.c: warning: 'test_mb_ahash_jiffies' uses dynamic stack allocation [enabled by default]:  => 746:1
  + /home/kisskb/slave/src/drivers/char/tpm/tpm.h: warning: 'blob_handle' may be used uninitialized in this function [-Wuninitialized]:  => 489:18
  + /home/kisskb/slave/src/drivers/dma-buf/reservation.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]:  => 210:7
  + /home/kisskb/slave/src/drivers/dma-buf/reservation.c: warning: 'k' may be used uninitialized in this function [-Wuninitialized]:  => 225:6, 155:1, 207:36, 207:2, 210:7
  + /home/kisskb/slave/src/drivers/gpu/drm/sun4i/sun4i_tcon.c: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wuninitialized]:  => 912:51
  + /home/kisskb/slave/src/drivers/infiniband/core/cq.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 78:1
  + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/ib_verbs.c: warning: left shift count >= width of type [enabled by default]:  => 3550:2, 3552:4, 149:2
  + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 569:19
  + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 336:12, 333:23
  + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [enabled by default]:  => 569:2
  + /home/kisskb/slave/src/drivers/infiniband/hw/cxgb4/device.c: warning: 'prev_time' may be used uninitialized in this function [-Wuninitialized]:  => 152:14
  + /home/kisskb/slave/src/drivers/leds/leds-mc13783.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]:  => 108:24
  + /home/kisskb/slave/src/drivers/leds/leds-mc13783.c: warning: 'shift' may be used uninitialized in this function [-Wuninitialized]:  => 108:24
  + /home/kisskb/slave/src/drivers/leds/leds-ot200.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]:  => 111:8
  + /home/kisskb/slave/src/drivers/md/dm.c: warning: 'front_pad' may be used uninitialized in this function [-Wuninitialized]:  => 2906:27
  + /home/kisskb/slave/src/drivers/md/raid0.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 306:1
  + /home/kisskb/slave/src/drivers/md/raid5.c: warning: 'target' may be used uninitialized in this function [-Wuninitialized]:  => 1516:2
  + /home/kisskb/slave/src/drivers/media/usb/cx231xx/cx231xx-i2c.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 610:1
  + /home/kisskb/slave/src/drivers/media/usb/dvb-usb/pctv452e.c: warning: value computed is not used [-Wunused-value]:  => 922:2
  + /home/kisskb/slave/src/drivers/media/usb/em28xx/em28xx-video.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 847:1
  + /home/kisskb/slave/src/drivers/memstick/core/ms_block.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 677:1, 465:1, 654:1, 720:1
  + /home/kisskb/slave/src/drivers/memstick/core/mspro_block.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 663:1
  + /home/kisskb/slave/src/drivers/mfd/rave-sp.c: warning: 'rave_sp_receive_frame' uses dynamic stack allocation [enabled by default]:  => 440:1
  + /home/kisskb/slave/src/drivers/mfd/sec-core.c: warning: 'num_sec_devs' may be used uninitialized in this function [-Wuninitialized]:  => 484:6
  + /home/kisskb/slave/src/drivers/mfd/sec-core.c: warning: 'sec_devs' may be used uninitialized in this function [-Wuninitialized]:  => 484:6
  + /home/kisskb/slave/src/drivers/misc/ics932s401.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]:  => 405:42
  + /home/kisskb/slave/src/drivers/misc/ics932s401.c: warning: 'x' may be used uninitialized in this function [-Wuninitialized]:  => 384:2
  + /home/kisskb/slave/src/drivers/mtd/nand/nandsim.c: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat]:  => 760:2
  + /home/kisskb/slave/src/drivers/net/ethernet/mellanox/mlxsw/core.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 307:1
  + /home/kisskb/slave/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'stmmac_dma_interrupt' uses dynamic stack allocation [enabled by default]:  => 2080:1
  + /home/kisskb/slave/src/drivers/net/wireless/ath/carl9170/fwcmd.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>[]' [-Wattributes]:  => 124:2
  + /home/kisskb/slave/src/drivers/net/wireless/ath/carl9170/mac.c: warning: 'power' may be used uninitialized in this function [-Wuninitialized]:  => 525:10
  + /home/kisskb/slave/src/drivers/net/wireless/ath/carl9170/phy.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 1568:1
  + /home/kisskb/slave/src/drivers/net/wireless/ath/carl9170/rx.c: warning: 'head' may be used uninitialized in this function [-Wuninitialized]:  => 805:6
  + /home/kisskb/slave/src/drivers/net/wireless/intersil/p54/lmac.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>[3]' [-Wattributes]:  => 377:2
  + /home/kisskb/slave/src/drivers/net/wireless/intersil/p54/lmac.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>[3]' [-Wattributes]In file included from /home/kisskb/slave/src/drivers/net/wireless/intersil/p54/main.c:27:0::  => 377:2
  + /home/kisskb/slave/src/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c: warning: 'drv_type' may be used uninitialized in this function [-Wuninitialized]:  => 134:12
  + /home/kisskb/slave/src/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c: warning: 'pull_dir' may be used uninitialized in this function [-Wuninitialized]:  => 134:12
  + /home/kisskb/slave/src/drivers/sbus/char/oradax.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 498:15, 468:15, 488:15, 478:15
  + /home/kisskb/slave/src/drivers/sbus/char/oradax.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 851:14
  + /home/kisskb/slave/src/drivers/scsi/osst.h: warning: 'packed' attribute ignored for field of type 'u32' [-Wattributes]:  => 97:2
  + /home/kisskb/slave/src/drivers/slimbus/messaging.c: warning: 'tid' may be used uninitialized in this function [-Wuninitialized]:  => 126:14
  + /home/kisskb/slave/src/drivers/staging/ccree/cc_cipher.c: warning: 'cc_cipher_setkey' uses dynamic stack allocation [enabled by default]:  => 374:1
  + /home/kisskb/slave/src/drivers/staging/gdm724x/gdm_lte.c: warning: 'packed' attribute ignored for field of type 'struct <anonymous>' [-Wattributes]:  => 196:3
  + /home/kisskb/slave/src/drivers/staging/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u16' [-Wattributes]:  => 128:4, 129:4, 126:4, 125:4, 127:4
  + /home/kisskb/slave/src/drivers/staging/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u32' [-Wattributes]:  => 123:4, 124:4
  + /home/kisskb/slave/src/drivers/staging/vt6656/mac.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>' [-Wattributes]:  => 351:3
  + /home/kisskb/slave/src/drivers/tty/serial/crisv10.c: warning: 'ser_interrupt' defined but not used [-Wunused-function]  CC [M]  drivers/usb/gadget/functions.o:  => 2462:1
  + /home/kisskb/slave/src/drivers/tty/serial/crisv10.c: warning: 'ser_interrupt' defined but not used [-Wunused-function]:  => 2462:1
  + /home/kisskb/slave/src/drivers/usb/gadget/function/f_ncm.c: warning: 'tmp' may be used uninitialized in this function [-Wuninitialized]:  => 1262:5, 1208:5, 1302:20, 1302:7, 1213:12, 1250:13
  + /home/kisskb/slave/src/fs/btrfs/tree-checker.c: warning: 'check_dir_item.isra.10' uses dynamic stack allocation [enabled by default]:  => 360:1
  + /home/kisskb/slave/src/fs/f2fs/file.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 2786:6
  + /home/kisskb/slave/src/fs/ocfs2/alloc.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]:  => 1391:3
  + /home/kisskb/slave/src/fs/xfs/scrub/agheader.c: warning: (near initialization for 'sai.oinfo') [-Wmissing-braces]:  => 770:9
  + /home/kisskb/slave/src/fs/xfs/scrub/agheader.c: warning: missing braces around initializer [-Wmissing-braces]:  => 770:9
  + /home/kisskb/slave/src/include/asm-generic/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 155:15
  + /home/kisskb/slave/src/include/drm/drm_print.h: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 105:24
  + /home/kisskb/slave/src/include/linux/bitops.h: warning: left shift count >= width of type [-Wshift-count-overflow]:  => 7:24
  + /home/kisskb/slave/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /home/kisskb/slave/src/include/linux/kern_levels.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /home/kisskb/slave/src/include/linux/kern_levels.h: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /home/kisskb/slave/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 3 has type 'ssize_t {aka int}' [-Wformat=]:  => 5:18
  + /home/kisskb/slave/src/include/linux/sched/mm.h: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 169:56
  + /home/kisskb/slave/src/include/math-emu/double.h: warning: "__LITTLE_ENDIAN" is not defined [-Wundef]:  => 59:5
  + /home/kisskb/slave/src/include/math-emu/single.h: warning: "__LITTLE_ENDIAN" is not defined [-Wundef]:  => 50:5
  + /home/kisskb/slave/src/include/media/v4l2-mediabus.h: warning: 'pix.<U2098>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]:  => 132:22
  + /home/kisskb/slave/src/include/uapi/linux/byteorder/big_endian.h: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [-Wint-conversion]:  => 31:52
  + /home/kisskb/slave/src/include/uapi/linux/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 52:9
  + /home/kisskb/slave/src/include/uapi/linux/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 52:9
  + /home/kisskb/slave/src/include/uapi/linux/swab.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 127:46, 29:4, 28:4, 24:4, 31:4, 30:4, 130:24, 27:4, 26:4, 25:4
  + /home/kisskb/slave/src/kernel/fork.c: warning: 'task_struct_whitelist' defined but not used [-Wunused-function]:  => 702:13
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U15a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5780>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U65a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7460>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33, 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uad20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub960>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubdc0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 146:32, 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ube60>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud280>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32, 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud640>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud780>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uda00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ued20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uedc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf000>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf320>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf780>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufdc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /home/kisskb/slave/src/kernel/time/tick-sched.c: warning: 'now' may be used uninitialized in this function [-Wuninitialized]: 639:17 => 1074:31, 639:17
  + /home/kisskb/slave/src/lib/test_bitmap.c: warning: 'test_bitmap_arr32' uses dynamic stack allocation [enabled by default]:  => 319:1
  + /home/kisskb/slave/src/lib/test_kasan.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 504:1
  + /home/kisskb/slave/src/mm/hugetlb.c: warning: 'page' may be used uninitialized in this function [-Wuninitialized]:  => 1439:5
  + /home/kisskb/slave/src/mm/slub.c: warning: 'deactivate_slab.isra.48' uses dynamic stack allocation [enabled by default]:  => 2153:1
  + /home/kisskb/slave/src/mm/slub.c: warning: 'get_partial_node.isra.50' uses dynamic stack allocation [enabled by default]:  => 1853:1
  + /home/kisskb/slave/src/mm/slub.c: warning: 'unfreeze_partials.isra.49' uses dynamic stack allocation [enabled by default]:  => 2221:1
  + /home/kisskb/slave/src/mm/usercopy.c: warning: 'noreturn' function does return [enabled by default]:  => 101:1
  + /home/kisskb/slave/src/net/core/filter.c: warning: unused variable 'val' [-Wunused-variable]:  => 3382:6
  + /home/kisskb/slave/src/net/rds/connection.c: warning: 'rds_walk_conn_path_info.isra.2.constprop.4' uses dynamic stack allocation [enabled by default]:  => 622:1
  + /home/kisskb/slave/src/sound/soc/fsl/fsl_ssi.c: warning: 'baudrate' may be used uninitialized in this function [-Wuninitialized]:  => 774:7
  + arch/arm/configs/omap2plus_defconfig: warning: symbol value 'm' invalid for LIRC:  => 322
  + arch/cris/arch-v32/Kconfig: warning: choice default symbol 'ETRAX_KGDB_PORT0' is not contained in the choice:  => 17
  + modpost: WARNING: modpost: Found 4 section mismatch(es).:  => N/A
  + modpost: WARNING: modpost: Found 5 section mismatch(es).:  => N/A
  + warning: "memcpy" [drivers/net/netdevsim/netdevsim.ko] has no CRC!:  => N/A
  + warning: "memcpy" [drivers/siox/siox-core.ko] has no CRC!:  => N/A
  + warning: "memcpy" [drivers/slimbus/slimbus.ko] has no CRC!:  => N/A
  + warning: "memcpy" [drivers/staging/ipx/ipx.ko] has no CRC!:  => N/A
  + warning: "memcpy" [drivers/staging/ncpfs/ncpfs.ko] has no CRC!:  => N/A
  + warning: "memcpy" [net/netfilter/nf_conncount.ko] has no CRC!:  => N/A
  + warning: vmlinux.o(.text+0x214): Section mismatch in reference from the function sfp_upstream_stop() to the function .init.text:setup_profiling_timer():  => N/A
  + warning: vmlinux.o(.text+0x35f0): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x4b903f8): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o(.text+0x79c30): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x79c3c): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7a21c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7a228): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b62c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b638): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b97c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b988): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1c8): Section mismatch in reference from the function .init_fallback_flush() to the function .init.text:.ppc64_bolted_size():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1f4): Section mismatch in reference from the function .init_fallback_flush() to the function .init.text:.memblock_alloc_base():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x32b8): Section mismatch in reference from the function .pnv_setup_rfi_flush() to the function .init.text:.setup_rfi_flush():  => N/A

1549 warning improvements:
  - /home/kisskb/slave/src/arch/arm/include/asm/spinlock.h: warning: 'ws' may be used uninitialized in this function [-Wuninitialized]: 110:21 => 
  - /home/kisskb/slave/src/arch/sh/math-emu/math.c: warning: left shift count >= width of type [enabled by default]: 334:1, 108:1, 145:2, 115:1, 310:1, 122:1, 334:2, 145:1 => 115:1, 145:2, 310:1, 122:1, 334:2, 108:1
  - /home/kisskb/slave/src/arch/sh/math-emu/math.c: warning: left shift count is negative [enabled by default]: 310:1, 122:1, 92:2, 323:2, 129:1, 108:1, 92:1, 333:1, 81:2, 115:1, 81:1, 323:1 => 310:1, 122:1, 323:2, 129:1, 108:1, 333:1, 92:1, 81:1, 115:1
  - /home/kisskb/slave/src/arch/sh/math-emu/math.c: warning: right shift count >= width of type [enabled by default]: 294:1, 296:1, 294:3, 296:3 => 296:3, 294:3
  - /home/kisskb/slave/src/arch/sh/math-emu/math.c: warning: right shift count is negative [enabled by default]: 324:2, 145:1, 129:1, 294:1, 122:1, 310:1, 334:2, 115:1, 145:2, 334:1, 108:1, 294:3, 324:1 => 115:1, 145:2, 108:1, 294:3, 324:2, 129:1, 334:2, 122:1, 310:1
  - /home/kisskb/slave/src/arch/x86/events/amd/ibs.c: warning: 'config' may be used uninitialized in this function [-Wuninitialized]: 306:11 => 
  - /home/kisskb/slave/src/arch/x86/events/intel/uncore_snbep.c: warning: 'bus' may be used uninitialized in this function [-Wuninitialized]: 3576:3 => 
  - /home/kisskb/slave/src/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c: warning: 'data' may be used uninitialized in this function [-Wuninitialized]: 77:14, 139:14 => 
  - /home/kisskb/slave/src/arch/x86/kernel/espfix_64.c: warning: 'rand' may be used uninitialized in this function [-Wuninitialized]: 118:22 => 
  - /home/kisskb/slave/src/arch/x86/kernel/ftrace.c: warning: 'size' may be used uninitialized in this function [-Wuninitialized]: 862:24 => 
  - /home/kisskb/slave/src/arch/x86/kernel/hw_breakpoint.c: warning: 'align' may be used uninitialized in this function [-Wuninitialized]: 361:2, 361:20 => 361:20
  - /home/kisskb/slave/src/arch/x86/kernel/ksysfs.c: warning: 'size' may be used uninitialized in this function [-Wuninitialized]: 227:17 => 
  - /home/kisskb/slave/src/arch/x86/kernel/umip.c: warning: 'dummy_data_size' may be used uninitialized in this function [-Wuninitialized]: 414:27 => 
  - /home/kisskb/slave/src/arch/x86/lib/insn-eval.c: warning: 'eff_addr' may be used uninitialized in this function [-Wuninitialized]: 1173:2 => 
  - /home/kisskb/slave/src/block/bfq-iosched.c: warning: 'bfqd' may be used uninitialized in this function [-Wuninitialized]: 3860:2 => 
  - /home/kisskb/slave/src/block/bfq-wf2q.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 812:24 => 
  - /home/kisskb/slave/src/block/blk-cgroup.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 354:1 => 
  - /home/kisskb/slave/src/block/blk-merge.c: warning: 'bbio' may be used uninitialized in this function [-Wuninitialized]: 285:2 => 
  - /home/kisskb/slave/src/block/blk-mq.c: warning: 'wait' may be used uninitialized in this function [-Wuninitialized]: 1068:16 => 
  - /home/kisskb/slave/src/block/blk-sysfs.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]: 459:21, 456:2 => 
  - /home/kisskb/slave/src/block/bsg.c: warning: 'op' may be used uninitialized in this function [-Wuninitialized]: 244:2 => 
  - /home/kisskb/slave/src/drivers/acpi/acpica/exprep.c: warning: 'byte_alignment' may be used uninitialized in this function [-Wuninitialized]: 386:6 => 
  - /home/kisskb/slave/src/drivers/acpi/ec.c: warning: 'handle' may be used uninitialized in this function [-Wuninitialized]: 1782:19 => 
  - /home/kisskb/slave/src/drivers/acpi/osl.c: warning: 'queue' may be used uninitialized in this function [-Wuninitialized]: 1102:21 => 
  - /home/kisskb/slave/src/drivers/acpi/pmic/tps68470_pmic.c: warning: 'bitmask' may be used uninitialized in this function [-Wuninitialized]: 307:36 => 
  - /home/kisskb/slave/src/drivers/acpi/pmic/tps68470_pmic.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]: 307:36 => 
  - /home/kisskb/slave/src/drivers/acpi/scan.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1830:24 => 
  - /home/kisskb/slave/src/drivers/acpi/sysfs.c: warning: 'result' may be used uninitialized in this function [-Wuninitialized]: 654:6 => 
  - /home/kisskb/slave/src/drivers/android/binder.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 5522:6 => 
  - /home/kisskb/slave/src/drivers/android/binder_alloc.c: warning: 'buffer' may be used uninitialized in this function [-Wuninitialized]: 433:30 => 
  - /home/kisskb/slave/src/drivers/android/binder_alloc.c: warning: 'buffer_size' may be used uninitialized in this function [-Wuninitialized]: 434:2 => 
  - /home/kisskb/slave/src/drivers/auxdisplay/img-ascii-lcd.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 207:5, 109:5, 207:2, 109:2 => 109:5, 207:5
  - /home/kisskb/slave/src/drivers/base/dma-coherent.c: warning: 'mem' may be used uninitialized in this function [-Wuninitialized]: 124:30 => 
  - /home/kisskb/slave/src/drivers/base/regmap/regcache-rbtree.c: warning: 'new_base_reg' may be used uninitialized in this function [-Wuninitialized]: 289:13 => 
  - /home/kisskb/slave/src/drivers/base/regmap/regcache-rbtree.c: warning: 'new_top_reg' may be used uninitialized in this function [-Wuninitialized]: 288:20 => 
  - /home/kisskb/slave/src/drivers/base/regmap/regmap.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 2515:6 => 
  - /home/kisskb/slave/src/drivers/char/hpet.c: warning: 'gsi' may be used uninitialized in this function [-Wuninitialized]: 254:19 => 
  - /home/kisskb/slave/src/drivers/char/random.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 2131:6 => 
  - /home/kisskb/slave/src/drivers/char/tpm/tpm2-cmd.c: warning: 'hash' may be used uninitialized in this function [-Wuninitialized]: 514:20 => 
  - /home/kisskb/slave/src/drivers/char/tpm/tpm2-cmd.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 876:2 => 
  - /home/kisskb/slave/src/drivers/char/tpm/tpm_atmel.c: warning: 'base' may be used uninitialized in this function [-Wuninitialized]: 221:3, 198:13 => 
  - /home/kisskb/slave/src/drivers/clk/renesas/rcar-gen2-cpg.c: warning: 'shift' may be used uninitialized in this function [-Wuninitialized]: 354:36 => 
  - /home/kisskb/slave/src/drivers/crypto/atmel-sha.c: warning: 'key' may be used uninitialized in this function [-Wuninitialized]: 1804:8 => 
  - /home/kisskb/slave/src/drivers/crypto/atmel-sha.c: warning: 'keylen' may be used uninitialized in this function [-Wuninitialized]: 1812:2 => 
  - /home/kisskb/slave/src/drivers/crypto/caam/caamalg_qi.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat]: 672:16, 1062:16, 909:16 => 
  - /home/kisskb/slave/src/drivers/crypto/qat/qat_common/qat_uclo.c: warning: 'img_desc.dram_base_addr_v' may be used uninitialized in this function [-Wuninitialized]: 1359:8 => 
  - /home/kisskb/slave/src/drivers/crypto/qat/qat_common/qat_uclo.c: warning: 'img_desc.dram_bus_addr' may be used uninitialized in this function [-Wuninitialized]: 1284:12 => 
  - /home/kisskb/slave/src/drivers/crypto/qat/qat_common/qat_uclo.c: warning: 'img_desc.dram_size' may be used uninitialized in this function [-Wuninitialized]: 1281:25 => 
  - /home/kisskb/slave/src/drivers/devfreq/exynos-bus.c: warning: 'edata.load_count' may be used uninitialized in this function [-Wuninitialized]: 172:38 => 
  - /home/kisskb/slave/src/drivers/devfreq/exynos-bus.c: warning: 'edata.total_count' may be used uninitialized in this function [-Wuninitialized]: 175:2 => 
  - /home/kisskb/slave/src/drivers/firewire/core-device.c: warning: 'changed' may be used uninitialized in this function [-Wuninitialized]: 1154:2 => 
  - /home/kisskb/slave/src/drivers/gpio/gpiolib-acpi.c: warning: 'desc' may be used uninitialized in this function [-Wuninitialized]: 929:47 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'crtc' may be used uninitialized in this function [-Wuninitialized]: 4537:5 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'dc_stream_attach' may be used uninitialized in this function [-Wuninitialized]: 3991:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'new_crtc_state' may be used uninitialized in this function [-Wuninitialized]: 4540:5, 4213:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'new_plane_state' may be used uninitialized in this function [-Wuninitialized]: 4666:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c: warning: 'handler' may be used uninitialized in this function [-Wuninitialized]: 163:7 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c: warning: 'id' may be used uninitialized in this function [-Wuninitialized]: 242:51 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c: warning: 'reg_val' may be used uninitialized in this function [-Wuninitialized]: 157:11 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.c: warning: 'index' may be used uninitialized in this function [-Wuninitialized]: 503:6 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/pp_psm.c: warning: 'state_id' may be used uninitialized in this function [-Wuninitialized]: 172:7, 184:7 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomctrl.c: warning: 'reg_block' may be used uninitialized in this function [-Wuninitialized]: 83:27 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/processpptables.c: warning: 'result' may be used uninitialized in this function [-Wuninitialized]: 1045:6 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c: warning: 'result' may be used uninitialized in this function [-Wuninitialized]: 1126:10 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/ci_smumgr.c: warning: 'voltage_level' may be used uninitialized in this function [-Wuninitialized]: 1462:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/ci_smumgr.c: warning: 'voltage_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1462:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.c: warning: 'vol_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1430:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.c: warning: 'voltage_level' may be used uninitialized in this function [-Wuninitialized]: 1518:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.c: warning: 'voltage_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1518:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smumgr.c: warning: 'voltage_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1236:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 3041:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: warning: 'fault' may be used uninitialized in this function [-Wuninitialized]: 2768:24 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: warning: 'incr' may be used uninitialized in this function [-Wuninitialized]: 1168:14 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: warning: 'fw_data' may be used uninitialized in this function [-Wuninitialized]: 1293:5, 1949:12 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: warning: 'table_offset' may be used uninitialized in this function [-Wuninitialized]: 1949:12 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: warning: 'table_size' may be used uninitialized in this function [-Wuninitialized]: 1949:12, 1296:13 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: warning: 'fw_data' may be used uninitialized in this function [-Wuninitialized]: 1304:12, 804:5 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: warning: 'table_offset' may be used uninitialized in this function [-Wuninitialized]: 1304:12 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: warning: 'table_size' may be used uninitialized in this function [-Wuninitialized]: 1304:12, 807:13 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/amd/amdgpu/soc15.c: warning: #warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15." [-Wcpp]: 558:3, 539:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/ast/ast_mode.c: warning: 'edid' may be used uninitialized in this function [-Wuninitialized]: 791:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/ast/ast_mode.c: warning: 'vbios_mode.enh_table' may be used uninitialized in this function [-Wuninitialized]: 468:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/ast/ast_mode.c: warning: 'vbios_mode.std_table' may be used uninitialized in this function [-Wuninitialized]: 245:8 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic.c: warning: 'crtc_state' may be used uninitialized in this function [-Wuninitialized]: 2126:14 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic.c: warning: 'plane' may be used uninitialized in this function [-Wuninitialized]: 831:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic.c: warning: 'plane_state' may be used uninitialized in this function [-Wuninitialized]: 831:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'new_crtc_state' may be used uninitialized in this function [-Wuninitialized]: 1775:26 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'new_plane_state' may be used uninitialized in this function [-Wuninitialized]: 1436:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'old_plane_state' may be used uninitialized in this function [-Wuninitialized]: 1432:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'plane' may be used uninitialized in this function [-Wuninitialized]: 1436:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_bufs.c: warning: 'master' may be used uninitialized in this function [-Wuninitialized]: 526:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_edid.c: warning: 'clock2' may be used uninitialized in this function [-Wuninitialized]: 3112:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/drm_edid.c: warning: 'hdmi_len' may be used uninitialized in this function [-Wuninitialized]: 3710:30 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/i915_gem_gtt.c: warning: 'addr' may be used uninitialized in this function [-Wuninitialized]: 574:25 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/i915_gem_request.h: warning: 'seqno' may be used uninitialized in this function [-Wuninitialized]: 319:20 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/i915_vma.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 768:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_bios.c: warning: 'seq_size' may be used uninitialized in this function [-Wuninitialized]: 1016:25 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_crt.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 759:6 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_csr.c: warning: 'si' may be used uninitialized in this function [-Wuninitialized]: 204:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_display.c: warning: 'crtc' may be used uninitialized in this function [-Wuninitialized]: 12066:7 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_display.c: warning: 'crtc_state' may be used uninitialized in this function [-Wuninitialized]: 12063:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_display.c: warning: 'old_crtc_state' may be used uninitialized in this function [-Wuninitialized]: 12055:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_dpio_phy.c: warning: 'was_enabled' may be used uninitialized in this function [-Wuninitialized]: 482:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_pipe_crc.c: warning: 'pipe' may be used uninitialized in this function [-Wuninitialized]: 671:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_pm.c: warning: 'cstate' may be used uninitialized in this function [-Wuninitialized]: 4497:32 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_runtime_pm.c: warning: 'reqs' may be used uninitialized in this function [-Wuninitialized]: 352:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_h' may be used uninitialized in this function [-Wuninitialized]: 1009:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_w' may be used uninitialized in this function [-Wuninitialized]: 1009:3 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_x' may be used uninitialized in this function [-Wuninitialized]: 1012:25 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_y' may be used uninitialized in this function [-Wuninitialized]: 1025:20 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/intel_tv.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1300:19 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_gem_context.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 328:6 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 984:2, 1317:2, 774:3, 1354:6 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_gem_request.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 404:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_gem_request.c: warning: 'request' may be used uninitialized in this function [-Wuninitialized]: 380:21 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_gem_timeline.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 82:6 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_syncmap.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 443:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/i915/selftests/i915_vma.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 206:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nv50_display.c: warning: 'curs' may be used uninitialized in this function [-Wuninitialized]: 2350:27 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 491:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 79:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c: warning: 'free' may be used uninitialized in this function [-Wuninitialized]: 223:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]: 163:16 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c: warning: 'stat' may be used uninitialized in this function [-Wuninitialized]: 160:31 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c: warning: 'stat' may be used uninitialized in this function [-Wuninitialized]: 160:31 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c: warning: 'emap' may be used uninitialized in this function [-Wuninitialized]: 157:10 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv50.c: warning: 'pt' may be used uninitialized in this function [-Wuninitialized]: 129:11 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]: 154:40 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c: warning: 'inst' may be used uninitialized in this function [-Wuninitialized]: 101:1, 89:20 => 101:1
  - /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 101:1, 75:3 => 101:1
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/radeon_uvd.c: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 175:2 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/rv770_dpm.c: warning: 'postdiv_yclk' may be used uninitialized in this function [-Wuninitialized]: 434:23 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'near_tdp_limit' may be used uninitialized in this function [-Wuninitialized]: 2185:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'tdp_limit' may be used uninitialized in this function [-Wuninitialized]: 2183:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'vddc_max' may be used uninitialized in this function [-Wuninitialized]: 2686:11 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'vddc_min' may be used uninitialized in this function [-Wuninitialized]: 2685:41 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/radeon/trinity_dpm.c: warning: 'min_vce_voltage' may be used uninitialized in this function [-Wuninitialized]: 1576:4 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/udl/udl_modeset.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]: 29:9 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c: warning: 'depth' may be used uninitialized in this function [-Wuninitialized]: 541:28 => 
  - /home/kisskb/slave/src/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c: warning: 'res' may be used uninitialized in this function [-Wuninitialized]: 1012:6 => 
  - /home/kisskb/slave/src/drivers/gpu/vga/vgaarb.c: warning: 'devfn' may be used uninitialized in this function [-Wuninitialized]: 1201:4 => 
  - /home/kisskb/slave/src/drivers/hid/hid-asus.c: warning: 'kbd_func' may be used uninitialized in this function [-Wuninitialized]: 350:2 => 
  - /home/kisskb/slave/src/drivers/hid/hid-logitech-hidpp.c: warning: '__name_length' may be used uninitialized in this function [-Wuninitialized]: 868:15 => 
  - /home/kisskb/slave/src/drivers/hid/hid-logitech-hidpp.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 1040:24 => 
  - /home/kisskb/slave/src/drivers/hid/hid-picolcd_debugfs.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 312:10 => 
  - /home/kisskb/slave/src/drivers/hid/usbhid/hid-core.c: warning: 'field' may be used uninitialized in this function [-Wuninitialized]: 819:16 => 
  - /home/kisskb/slave/src/drivers/hv/channel.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 502:6 => 
  - /home/kisskb/slave/src/drivers/hwmon/applesmc.c: warning: 'count' may be used uninitialized in this function [-Wuninitialized]: 552:2 => 
  - /home/kisskb/slave/src/drivers/hwmon/ltc2990.c: warning: 'value' may be used uninitialized in this function [-Wuninitialized]: 89:17 => 
  - /home/kisskb/slave/src/drivers/hwmon/w83627ehf.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]: 2835:30 => 
  - /home/kisskb/slave/src/drivers/i2c/busses/i2c-diolan-u2c.c: warning: 'byte' may be used uninitialized in this function [-Wuninitialized]: 393:18 => 
  - /home/kisskb/slave/src/drivers/iio/accel/bmc150-accel-core.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 860:2 => 
  - /home/kisskb/slave/src/drivers/iio/accel/mma9551.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]: 381:32 => 
  - /home/kisskb/slave/src/drivers/iio/accel/mma9551_core.c: warning: 'pol_mask' may be used uninitialized in this function [-Wuninitialized]: 590:34 => 
  - /home/kisskb/slave/src/drivers/iio/adc/bcm_iproc_adc.c: warning: 'adc_data' may be used uninitialized in this function [-Wuninitialized]: 477:8 => 
  - /home/kisskb/slave/src/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: warning: 'st_lsm6dsx_read_fifo' uses dynamic stack allocation [enabled by default]: 306:1 => 
  - /home/kisskb/slave/src/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c: warning: 'st_lsm6dsx_i2c_write' uses dynamic stack allocation [enabled by default]: 53:1 => 
  - /home/kisskb/slave/src/drivers/iio/light/isl29018.c: warning: 'new_int_time' may be used uninitialized in this function [-Wuninitialized]: 128:16 => 
  - /home/kisskb/slave/src/drivers/iio/light/lm3533-als.c: warning: 'enable' may be used uninitialized in this function [-Wuninitialized]: 424:18 => 
  - /home/kisskb/slave/src/drivers/iio/light/opt3001.c: warning: 'exponent' may be used uninitialized in this function [-Wuninitialized]: 515:23 => 
  - /home/kisskb/slave/src/drivers/iio/proximity/srf08.c: warning: 'regval' may be used uninitialized in this function [-Wuninitialized]: 370:33 => 
  - /home/kisskb/slave/src/drivers/iio/temperature/tsys01.c: warning: 'temperature' may be used uninitialized in this function [-Wuninitialized]: 94:9 => 
  - /home/kisskb/slave/src/drivers/infiniband/core/rw.c: warning: 'first_wr' may be used uninitialized in this function [-Wuninitialized]: 546:2 => 
  - /home/kisskb/slave/src/drivers/infiniband/core/rw.c: warning: 'last_wr' may be used uninitialized in this function [-Wuninitialized]: 543:23 => 
  - /home/kisskb/slave/src/drivers/infiniband/ulp/srp/ib_srp.c: warning: comparison of distinct pointer types lacks a cast [enabled by default]: 3624:19 => 
  - /home/kisskb/slave/src/drivers/input/mouse/cyapa.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 717:3 => 
  - /home/kisskb/slave/src/drivers/input/mouse/cyapa_gen3.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 970:2 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/melfas_mip4.c: warning: 'fw_size' may be used uninitialized in this function [-Wuninitialized]: 1118:26 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/melfas_mip4.c: warning: 'fw_start_offset' may be used uninitialized in this function [-Wuninitialized]: 1118:26 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/s6sy761.c: warning: 'max_x' may be used uninitialized in this function [-Wuninitialized]: 436:22 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/s6sy761.c: warning: 'max_y' may be used uninitialized in this function [-Wuninitialized]: 437:22 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/sis_i2c.c: warning: 'contact_size' may be used uninitialized in this function [-Wuninitialized]: 265:12 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/sis_i2c.c: warning: 'num_contacts' may be used uninitialized in this function [-Wuninitialized]: 250:11 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/sun4i-ts.c: warning: 'temp' may be used uninitialized in this function [-Wuninitialized]: 224:16 => 
  - /home/kisskb/slave/src/drivers/input/touchscreen/wdt87xx_i2c.c: warning: 'device_checksum' may be used uninitialized in this function [-Wuninitialized]: 753:4 => 
  - /home/kisskb/slave/src/drivers/leds/leds-pca955x.c: warning: 'ls' may be used uninitialized in this function [-Wuninitialized]: 288:22 => 
  - /home/kisskb/slave/src/drivers/media/dvb-core/dvb_frontend.c: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 2470:1 => 
  - /home/kisskb/slave/src/drivers/media/dvb-frontends/cxd2841er.c: warning: 'carrier_offset' may be used uninitialized in this function [-Wuninitialized]: 3582:17 => 
  - /home/kisskb/slave/src/drivers/media/v4l2-core/videobuf2-core.c: warning: 'vb' may be used uninitialized in this function [-Wuninitialized]: 2520:3 => 
  - /home/kisskb/slave/src/drivers/mfd/arizona-core.c: warning: 'n_subdevs' may be used uninitialized in this function [-Wuninitialized]: 1387:6 => 
  - /home/kisskb/slave/src/drivers/mfd/htc-pasic3.c: warning: unused variable 'asic' [-Wunused-variable]: 189:22 => 
  - /home/kisskb/slave/src/drivers/misc/bh1770glc.c: warning: 'mode' may be used uninitialized in this function [-Wuninitialized]: 236:29 => 
  - /home/kisskb/slave/src/drivers/misc/mei/bus-fixup.c: warning: 'ver.radio_type' may be used uninitialized in this function [-Wuninitialized]: 302:3 => 
  - /home/kisskb/slave/src/drivers/misc/mei/bus-fixup.c: warning: 'ver.vendor_id' may be used uninitialized in this function [-Wuninitialized]: 301:2 => 
  - /home/kisskb/slave/src/drivers/misc/vmw_vmci/vmci_datagram.c: warning: 'src_priv_flags' may be used uninitialized in this function [-Wuninitialized]: 262:4 => 
  - /home/kisskb/slave/src/drivers/mtd/chips/cfi_cmdset_0020.c: warning: the frame size of 1396 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 603:1 => 
  - /home/kisskb/slave/src/drivers/mtd/devices/phram.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 114:16 => 
  - /home/kisskb/slave/src/drivers/mtd/maps/solutionengine.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'resource_size_t' [-Wformat]: 64:9 => 
  - /home/kisskb/slave/src/drivers/mtd/maps/solutionengine.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' [-Wformat]: 64:9 => 
  - /home/kisskb/slave/src/drivers/mtd/nand/nand_base.c: warning: 'best_ecc_bytes' may be used uninitialized in this function [-Wuninitialized]: 4563:18, 4490:18 => 
  - /home/kisskb/slave/src/drivers/mtd/nand/nand_base.c: warning: 'best_step' may be used uninitialized in this function [-Wuninitialized]: 4488:17 => 
  - /home/kisskb/slave/src/drivers/mtd/nand/nand_base.c: warning: 'best_strength' may be used uninitialized in this function [-Wuninitialized]: 4489:21, 4562:21 => 
  - /home/kisskb/slave/src/drivers/net/arcnet/arc-rimi.c: warning: unused variable 'lp' [-Wunused-variable]: 346:23 => 
  - /home/kisskb/slave/src/drivers/net/can/cc770/cc770_platform.c: warning: unused variable 'priv' [-Wunused-variable]: 244:21 => 
  - /home/kisskb/slave/src/drivers/net/ethernet/8390/ax88796.c: warning: unused variable 'ei_local' [-Wunused-variable]: 778:20 => 
  - /home/kisskb/slave/src/drivers/net/ethernet/freescale/fsl_pq_mdio.c: warning: unused variable 'priv' [-Wunused-variable]: 505:27 => 
  - /home/kisskb/slave/src/drivers/net/ethernet/fujitsu/fmvj18x_cs.c: warning: unused variable 'buf' [-Wunused-variable]: 818:17 => 
  - /home/kisskb/slave/src/drivers/net/ethernet/smsc/smc911x.c: warning: unused variable 'lp' [-Wunused-variable]: 2136:24 => 
  - /home/kisskb/slave/src/drivers/net/ethernet/smsc/smc91c92_cs.c: warning: unused variable 'smc' [-Wunused-variable]: 958:23 => 
  - /home/kisskb/slave/src/drivers/net/tun.c: warning: 'linear' may be used uninitialized in this function [-Wuninitialized]: 1361:34, 1361:31, 1556:46 => 1730:46, 1533:34
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+12)' may be used uninitialized in this function [-Wuninitialized]: 2256:46 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+16)' may be used uninitialized in this function [-Wuninitialized]: 2256:69 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+160)' may be used uninitialized in this function [-Wuninitialized]: 2252:48 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+164)' may be used uninitialized in this function [-Wuninitialized]: 2252:48 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+168)' may be used uninitialized in this function [-Wuninitialized]: 2252:72 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+172)' may be used uninitialized in this function [-Wuninitialized]: 2258:47 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+176)' may be used uninitialized in this function [-Wuninitialized]: 2250:48 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+180)' may be used uninitialized in this function [-Wuninitialized]: 2250:48 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+184)' may be used uninitialized in this function [-Wuninitialized]: 2250:72 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+20)' may be used uninitialized in this function [-Wuninitialized]: 2257:31 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+360)' may be used uninitialized in this function [-Wuninitialized]: 2261:24 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+368)' may be used uninitialized in this function [-Wuninitialized]: 2255:22 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+372)' may be used uninitialized in this function [-Wuninitialized]: 2254:22 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+4)' may be used uninitialized in this function [-Wuninitialized]: 2256:46 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'cap_rid.softCap' may be used uninitialized in this function [-Wuninitialized]: 2865:37 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'cap_rid.softSubVer' may be used uninitialized in this function [-Wuninitialized]: 2868:2 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'cap_rid.softVer' may be used uninitialized in this function [-Wuninitialized]: 2868:2 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.channel' may be used uninitialized in this function [-Wuninitialized]: 5828:5 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.len' may be used uninitialized in this function [-Wuninitialized]: 7724:5 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.mode' may be used uninitialized in this function [-Wuninitialized]: 7709:23 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.noisedBm' may be used uninitialized in this function [-Wuninitialized]: 7725:28 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.normalizedSignalStrength' may be used uninitialized in this function [-Wuninitialized]: 7717:27 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.sigQuality' may be used uninitialized in this function [-Wuninitialized]: 7714:20 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.signalQuality' may be used uninitialized in this function [-Wuninitialized]: 5738:6 => 
  - /home/kisskb/slave/src/drivers/net/wireless/cisco/airo.c: warning: 'wkr.kindex' may be used uninitialized in this function [-Wuninitialized]: 5188:6 => 
  - /home/kisskb/slave/src/drivers/nubus/proc.c: warning: #warning Need to set some I/O handlers here [-Wcpp]: 65:2 => 
  - /home/kisskb/slave/src/drivers/nvme/target/io-cmd.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 144:21 => 
  - /home/kisskb/slave/src/drivers/pci/quirks.c: warning: 'host_bridge' may be used uninitialized in this function [-Wuninitialized]: 2605:6 => 
  - /home/kisskb/slave/src/drivers/pci/vc.c: warning: 'ctrl_pos2' may be used uninitialized in this function [-Wuninitialized]: 158:24 => 
  - /home/kisskb/slave/src/drivers/platform/goldfish/goldfish_pipe.c: warning: 'consumed_size' may be used uninitialized in this function [-Wuninitialized]: 480:10 => 
  - /home/kisskb/slave/src/drivers/platform/goldfish/goldfish_pipe.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 483:3 => 
  - /home/kisskb/slave/src/drivers/platform/x86/wmi.c: warning: 'wblock' may be used uninitialized in this function [-Wuninitialized]: 1323:9 => 
  - /home/kisskb/slave/src/drivers/power/supply/bq24190_charger.c: warning: 'en_term' may be used uninitialized in this function [-Wuninitialized]: 795:27 => 
  - /home/kisskb/slave/src/drivers/power/supply/bq24190_charger.c: warning: 'force_20pct' may be used uninitialized in this function [-Wuninitialized]: 788:27 => 
  - /home/kisskb/slave/src/drivers/power/supply/da9052-battery.c: warning: 'chg_end_current' may be used uninitialized in this function [-Wuninitialized]: 266:4 => 
  - /home/kisskb/slave/src/drivers/power/supply/da9052-battery.c: warning: 'level_lower' may be used uninitialized in this function [-Wuninitialized]: 325:6 => 
  - /home/kisskb/slave/src/drivers/power/supply/da9052-battery.c: warning: 'level_upper' may be used uninitialized in this function [-Wuninitialized]: 324:22 => 
  - /home/kisskb/slave/src/drivers/power/supply/da9052-battery.c: warning: 'vbat_lower' may be used uninitialized in this function [-Wuninitialized]: 325:37 => 
  - /home/kisskb/slave/src/drivers/power/supply/da9052-battery.c: warning: 'vbat_upper' may be used uninitialized in this function [-Wuninitialized]: 324:59 => 
  - /home/kisskb/slave/src/drivers/rapidio/devices/rio_mport_cdev.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 273:6 => 
  - /home/kisskb/slave/src/drivers/regulator/max8925-regulator.c: warning: 'ri' may be used uninitialized in this function [-Wuninitialized]: 313:45 => 
  - /home/kisskb/slave/src/drivers/regulator/tps6586x-regulator.c: warning: 'num' may be used uninitialized in this function [-Wuninitialized]: 361:3 => 
  - /home/kisskb/slave/src/drivers/spi/spi-sprd-adi.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]: 230:21 => 
  - /home/kisskb/slave/src/drivers/staging/ccree/ssi_cipher.c: warning: 'ssi_blkcipher_setkey' uses dynamic stack allocation [enabled by default]: 419:1 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_mio_common.c: warning: 'freq_divider' may be used uninitialized in this function [-Wuninitialized]: 4897:22 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_mio_common.c: warning: 'freq_multiplier' may be used uninitialized in this function [-Wuninitialized]: 4898:8 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'gate2_sel' may be used uninitialized in this function [-Wuninitialized]: 954:34 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'gate_sel' may be used uninitialized in this function [-Wuninitialized]: 909:22, 867:22 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'ni_660x_clock' may be used uninitialized in this function [-Wuninitialized]: 667:10 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'ni_m_series_clock' may be used uninitialized in this function [-Wuninitialized]: 724:10 => 
  - /home/kisskb/slave/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'source' may be used uninitialized in this function [-Wuninitialized]: 1222:7, 1122:7, 1175:7 => 
  - /home/kisskb/slave/src/drivers/staging/fbtft/fbtft-core.c: warning: 'ts_start' may be used uninitialized in this function [-Wuninitialized]: 411:23 => 
  - /home/kisskb/slave/src/drivers/staging/greybus/bootrom.c: warning: 'fw' may be used uninitialized in this function [-Wuninitialized]: 300:2 => 
  - /home/kisskb/slave/src/drivers/staging/greybus/bootrom.c: warning: 'offset' may be used uninitialized in this function [-Wuninitialized]: 300:2 => 
  - /home/kisskb/slave/src/drivers/staging/greybus/bootrom.c: warning: 'size' may be used uninitialized in this function [-Wuninitialized]: 300:2 => 
  - /home/kisskb/slave/src/drivers/staging/greybus/interface.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 1024:4 => 
  - /home/kisskb/slave/src/drivers/staging/greybus/manifest.c: warning: 'desc_string' may be used uninitialized in this function [-Wuninitialized]: 214:20 => 
  - /home/kisskb/slave/src/drivers/staging/greybus/svc.c: warning: 'rail_count' may be used uninitialized in this function [-Wuninitialized]: 785:29 => 
  - /home/kisskb/slave/src/drivers/staging/iio/adc/ad7606_par.c: warning: unused variable 'st' [-Wunused-variable]: 39:23, 23:23 => 
  - /home/kisskb/slave/src/drivers/staging/most/aim-cdev/cdev.c: warning: 'mbo' may be used uninitialized in this function [-Wuninitialized]: 281:2 => 
  - /home/kisskb/slave/src/drivers/staging/vboxvideo/vbox_fb.c: warning: 'gobj' may be used uninitialized in this function [-Wuninitialized]: 173:30 => 
  - /home/kisskb/slave/src/drivers/thermal/broadcom/ns-thermal.c: warning: unused variable 'ns_thermal' [-Wunused-variable]: 81:21 => 
  - /home/kisskb/slave/src/drivers/tty/serial/ifx6x60.c: warning: 'cts' may be used uninitialized in this function [-Wuninitialized]: 667:26 => 
  - /home/kisskb/slave/src/drivers/tty/serial/ifx6x60.c: warning: 'length' may be used uninitialized in this function [-Wuninitialized]: 669:19 => 
  - /home/kisskb/slave/src/drivers/usb/core/hcd.c: warning: 'bufp' may be used uninitialized in this function [-Wuninitialized]: 709:3, 709:10 => 
  - /home/kisskb/slave/src/drivers/usb/dwc3/gadget.c: warning: 'trb' may be used uninitialized in this function [-Wuninitialized]: 2335:4 => 
  - /home/kisskb/slave/src/drivers/usb/gadget/function/f_fs.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 2194:7 => 
  - /home/kisskb/slave/src/drivers/usb/host/max3421-hcd.c: warning: 'ep' may be used uninitialized in this function [-Wuninitialized]: 2019:1 => 
  - /home/kisskb/slave/src/drivers/usb/host/max3421-hcd.c: warning: 'max3421_ep' may be used uninitialized in this function [-Wuninitialized]: 787:26 => 
  - /home/kisskb/slave/src/drivers/usb/host/max3421-hcd.c: warning: 'max3421_hcd' may be used uninitialized in this function [-Wuninitialized]: 1959:3 => 
  - /home/kisskb/slave/src/drivers/usb/host/xhci-hub.c: warning: 'ssa_count' may be used uninitialized in this function [-Wuninitialized]: 113:26 => 
  - /home/kisskb/slave/src/drivers/usb/misc/sisusbvga/sisusb_init.c: warning: 'ModeIdIndex' may be used uninitialized in this function [-Wuninitialized]: 910:30 => 
  - /home/kisskb/slave/src/drivers/usb/serial/cp210x.c: warning: 'count' may be used uninitialized in this function [-Wuninitialized]: 867:2 => 
  - /home/kisskb/slave/src/drivers/usb/serial/f81534.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 230:2, 191:2 => 
  - /home/kisskb/slave/src/drivers/usb/serial/io_edgeport.c: warning: 'divisor' may be used uninitialized in this function [-Wuninitialized]: 2348:2 => 
  - /home/kisskb/slave/src/drivers/usb/serial/mos7720.c: warning: 'divisor' may be used uninitialized in this function [-Wuninitialized]: 1505:45 => 
  - /home/kisskb/slave/src/drivers/usb/serial/qcserial.c: warning: 'ifnum' may be used uninitialized in this function [-Wuninitialized]: 404:29 => 
  - /home/kisskb/slave/src/drivers/usb/typec/fusb302/fusb302.c: warning: 'ra_comp' may be used uninitialized in this function [-Wuninitialized]: 1425:7 => 
  - /home/kisskb/slave/src/drivers/usb/typec/tcpm.c: warning: 'rdo' may be used uninitialized in this function [-Wuninitialized]: 1793:17 => 
  - /home/kisskb/slave/src/drivers/usb/wusbcore/devconnect.c: warning: 'port' may be used uninitialized in this function [-Wuninitialized]: 315:17 => 
  - /home/kisskb/slave/src/drivers/uwb/i1480/dfu/phy.c: warning: 'phy_stat' may be used uninitialized in this function [-Wuninitialized]: 189:2 => 
  - /home/kisskb/slave/src/drivers/video/backlight/adp8860_bl.c: warning: 'ret_val' may be used uninitialized in this function [-Wuninitialized]: 579:10 => 
  - /home/kisskb/slave/src/drivers/video/fbdev/aty/aty128fb.c: warning: 'output_freq' may be used uninitialized in this function [-Wuninitialized]: 1401:4 => 
  - /home/kisskb/slave/src/drivers/video/fbdev/matrox/matroxfb_maven.c: warning: 'c' may be used uninitialized in this function [-Wuninitialized]: 745:19 => 
  - /home/kisskb/slave/src/drivers/video/fbdev/sis/init301.c: warning: 'CRT2Index' may be used uninitialized in this function [-Wuninitialized]: 6969:7 => 
  - /home/kisskb/slave/src/drivers/video/fbdev/sis/init301.c: warning: 'resindex' may be used uninitialized in this function [-Wuninitialized]: 6975:68 => 
  - /home/kisskb/slave/src/drivers/w1/slaves/w1_ds2438.c: warning: 'temp' may be used uninitialized in this function [-Wuninitialized]: 301:16 => 
  - /home/kisskb/slave/src/drivers/watchdog/ziirave_wdt.c: warning: 'fw' may be used uninitialized in this function [-Wuninitialized]: 766:1 => 
  - /home/kisskb/slave/src/fs/autofs4/waitq.c: warning: 'wq' may be used uninitialized in this function [-Wuninitialized]: 478:3, 477:5 => 
  - /home/kisskb/slave/src/fs/btrfs/ctree.c: warning: 'pslot' may be used uninitialized in this function [-Wuninitialized]: 1975:24, 2183:24 => 
  - /home/kisskb/slave/src/fs/btrfs/extent_io.c: warning: 'tree' may be used uninitialized in this function [-Wuninitialized]: 2650:32 => 
  - /home/kisskb/slave/src/fs/btrfs/free-space-cache.c: warning: 'next_zero' may be used uninitialized in this function [-Wuninitialized]: 2863:5 => 
  - /home/kisskb/slave/src/fs/btrfs/inode.c: warning: 'disk_num_bytes' may be used uninitialized in this function [-Wuninitialized]: 1470:7 => 
  - /home/kisskb/slave/src/fs/btrfs/inode.c: warning: 'extent_offset' may be used uninitialized in this function [-Wuninitialized]: 1468:8 => 
  - /home/kisskb/slave/src/fs/btrfs/inode.c: warning: 'ram_bytes' may be used uninitialized in this function [-Wuninitialized]: 1470:7 => 
  - /home/kisskb/slave/src/fs/btrfs/ref-verify.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 565:3, 600:7, 568:2, 565:6, 516:2 => 516:2, 565:6, 568:2, 600:7
  - /home/kisskb/slave/src/fs/btrfs/send.c: warning: 'found_key.offset' may be used uninitialized in this function [-Wuninitialized]: 1790:7 => 
  - /home/kisskb/slave/src/fs/btrfs/send.c: warning: 'found_key.type' may be used uninitialized in this function [-Wuninitialized]: 1767:2 => 
  - /home/kisskb/slave/src/fs/btrfs/uuid-tree.c: warning: 'eb' may be used uninitialized in this function [-Wuninitialized]: 152:25 => 
  - /home/kisskb/slave/src/fs/btrfs/uuid-tree.c: warning: 'offset' may be used uninitialized in this function [-Wuninitialized]: 151:21 => 
  - /home/kisskb/slave/src/fs/crypto/keyinfo.c: warning: 'cipher_str' may be used uninitialized in this function [-Wuninitialized]: 319:7 => 
  - /home/kisskb/slave/src/fs/crypto/keyinfo.c: warning: 'keysize' may be used uninitialized in this function [-Wuninitialized]: 219:6 => 
  - /home/kisskb/slave/src/fs/dcache.c: warning: 'n' may be used uninitialized in this function [-Wuninitialized]: 2418:2 => 
  - /home/kisskb/slave/src/fs/ext4/extents.c: warning: 'abut_ex' may be used uninitialized in this function [-Wuninitialized]: 3562:21 => 
  - /home/kisskb/slave/src/fs/ext4/ialloc.c: warning: 'bit' may be used uninitialized in this function [-Wuninitialized]: 1282:9 => 
  - /home/kisskb/slave/src/fs/ext4/readpage.c: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /home/kisskb/slave/src/fs/ext4/super.c: warning: 'first_not_zeroed' may be used uninitialized in this function [-Wuninitialized]: 4279:6 => 
  - /home/kisskb/slave/src/fs/f2fs/checkpoint.c: warning: 'do_checkpoint' uses dynamic stack allocation [enabled by default]: 1342:1 => 
  - /home/kisskb/slave/src/fs/f2fs/checkpoint.c: warning: 'get_checkpoint_version' uses dynamic stack allocation [enabled by default]: 749:1 => 
  - /home/kisskb/slave/src/fs/f2fs/gc.c: warning: 'nofs' may be used uninitialized in this function [-Wuninitialized]: 876:35 => 
  - /home/kisskb/slave/src/fs/f2fs/node.c: warning: 'nat_blk' may be used uninitialized in this function [-Wuninitialized]: 2494:11 => 
  - /home/kisskb/slave/src/fs/gfs2/rgrp.c: warning: 'rs' may be used uninitialized in this function [-Wuninitialized]: 1553:17 => 
  - /home/kisskb/slave/src/fs/hfsplus/unicode.c: warning: 'dsize' may be used uninitialized in this function [-Wuninitialized]: 299:5 => 
  - /home/kisskb/slave/src/fs/hpfs/alloc.c: warning: 'sec' may be used uninitialized in this function [-Wuninitialized]: 203:7 => 
  - /home/kisskb/slave/src/fs/jffs2/scan.c: warning: 'sumlen' may be used uninitialized in this function [-Wuninitialized]: 540:4 => 
  - /home/kisskb/slave/src/fs/mpage.c: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 316:1 => 
  - /home/kisskb/slave/src/fs/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u16' [-Wattributes]: 126:4, 125:4, 127:4, 129:4, 128:4 => 
  - /home/kisskb/slave/src/fs/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u32' [-Wattributes]: 123:4, 124:4 => 
  - /home/kisskb/slave/src/fs/ntfs/dir.c: warning: 'bmp_vi' may be used uninitialized in this function [-Wuninitialized]: 1430:7 => 
  - /home/kisskb/slave/src/fs/ocfs2/file.c: warning: 'had_lock' may be used uninitialized in this function [-Wuninitialized]: 1301:29 => 
  - /home/kisskb/slave/src/fs/ocfs2/quota_local.c: warning: 'dchunk' may be used uninitialized in this function [-Wuninitialized]: 948:45 => 
  - /home/kisskb/slave/src/fs/ocfs2/suballoc.c: warning: 'bg_bh' may be used uninitialized in this function [-Wuninitialized]: 476:2 => 
  - /home/kisskb/slave/src/fs/ocfs2/xattr.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 3004:2 => 
  - /home/kisskb/slave/src/fs/reiserfs/bitmap.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]: 269:9 => 
  - /home/kisskb/slave/src/fs/userfaultfd.c: warning: 'basic_ioctls' may be used uninitialized in this function [-Wuninitialized]: 1461:3 => 
  - /home/kisskb/slave/src/fs/xfs/libxfs/xfs_alloc.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 2353:8 => 
  - /home/kisskb/slave/src/fs/xfs/libxfs/xfs_bmap.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 5095:8 => 
  - /home/kisskb/slave/src/fs/xfs/xfs_log_recover.c: warning: 'uuid' may be used uninitialized in this function [-Wuninitialized]: 2355:3 => 
  - /home/kisskb/slave/src/fs/xfs/xfs_rtalloc.c: warning: 'nrblocks' may be used uninitialized in this function [-Wuninitialized]: 980:4 => 
  - /home/kisskb/slave/src/include/linux/compiler.h: warning: 'wait' may be used uninitialized in this function [-Wuninitialized]: 211:31 => 
  - /home/kisskb/slave/src/include/linux/file.h: warning: 'output.file' may be used uninitialized in this function [-Wuninitialized]: 40:7 => 
  - /home/kisskb/slave/src/include/linux/file.h: warning: 'output.flags' may be used uninitialized in this function [-Wuninitialized]: 39:2 => 
  - /home/kisskb/slave/src/include/linux/hid.h: warning: 'report' may be used uninitialized in this function [-Wuninitialized]: 1007:34 => 
  - /home/kisskb/slave/src/include/linux/kref.h: warning: 'entry' may be used uninitialized in this function [-Wuninitialized]: 47:14 => 
  - /home/kisskb/slave/src/include/linux/list.h: warning: 'wait' may be used uninitialized in this function [-Wuninitialized]: 29:13 => 
  - /home/kisskb/slave/src/include/linux/percpu-refcount.h: warning: 'percpu_count' may be used uninitialized in this function [-Wuninitialized]: 214:1, 276:1, 248:1, 177:1 => 
  - /home/kisskb/slave/src/include/linux/pinctrl/pinconf-generic.h: warning: 'arg' may be used uninitialized in this function [-Wuninitialized]: 154:9 => 
  - /home/kisskb/slave/src/include/linux/slab.h: warning: 'n_ioc' may be used uninitialized in this function [-Wuninitialized]: 618:18 => 
  - /home/kisskb/slave/src/include/linux/spinlock.h: warning: 'dst_ptl' may be used uninitialized in this function [-Wuninitialized]: 350:2 => 
  - /home/kisskb/slave/src/include/linux/spinlock.h: warning: 'ptl' may be used uninitialized in this function [-Wuninitialized]: 350:2 => 
  - /home/kisskb/slave/src/include/linux/spinlock.h: warning: 'ws' may be used uninitialized in this function [-Wuninitialized]: 335:2 => 
  - /home/kisskb/slave/src/include/linux/uuid.h: warning: 'uuid' may be used uninitialized in this function [-Wuninitialized]: 60:15 => 
  - /home/kisskb/slave/src/include/media/v4l2-mediabus.h: warning: 'pix.<U6260>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]: 114:22 => 
  - /home/kisskb/slave/src/include/uapi/linux/swab.h: warning: 'buf_addr' may be used uninitialized in this function [-Wuninitialized]: 52:9 => 
  - /home/kisskb/slave/src/ipc/mqueue.c: warning: 'msg_ptr' may be used uninitialized in this function [-Wuninitialized]: 1171:3 => 
  - /home/kisskb/slave/src/ipc/shm.c: warning: 'file' may be used uninitialized in this function [-Wuninitialized]: 1555:59, 1554:3 => 1565:59
  - /home/kisskb/slave/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 1257:9, 1268:20 => 1268:20
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 6e0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1280>]' may be used uninitialized in this function [-Wuninitialized]: 100:33, 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1d20>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1dc0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2640>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2f00>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32, 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3140>]' may be used uninitialized in this function [-Wuninitialized]: 100:33, 119:32 => 127:33
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U40a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4280>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4dc0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6b40>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6c80>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6e60>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7780>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U78c0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8280>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8320>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8aa0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8dc0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U93c0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9960>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaaa0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uadc0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub3c0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub500>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uba00>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc0a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc6e0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc780>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udaa0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue460>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue8c0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf8c0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufe60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33, 119:32 => 
  - /home/kisskb/slave/src/kernel/trace/trace_events.c: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]: 1053:2 => 
  - /home/kisskb/slave/src/kernel/trace/trace_events.c: warning: 'last_i' may be used uninitialized in this function [-Wuninitialized]: 2240:4, 2212:6 => 
  - /home/kisskb/slave/src/lib/asn1_decoder.c: warning: 'errmsg' may be used uninitialized in this function [-Wuninitialized]: 515:2 => 
  - /home/kisskb/slave/src/lib/assoc_array.c: warning: 'j' may be used uninitialized in this function [-Wuninitialized]: 658:2 => 
  - /home/kisskb/slave/src/lib/kobject_uevent.c: warning: 'action' may be used uninitialized in this function [-Wuninitialized]: 219:4 => 
  - /home/kisskb/slave/src/lib/kobject_uevent.c: warning: 'action_args' may be used uninitialized in this function [-Wuninitialized]: 138:7 => 
  - /home/kisskb/slave/src/lib/kobject_uevent.c: warning: 'env' may be used uninitialized in this function [-Wuninitialized]: 219:39 => 
  - /home/kisskb/slave/src/lib/mpi/mpicoder.c: warning: 'buff' may be used uninitialized in this function [-Wuninitialized]: 336:12, 330:5, 352:8, 377:32 => 352:8, 336:12
  - /home/kisskb/slave/src/lib/swiotlb.c: warning: 'dev_addr' may be used uninitialized in this function [-Wuninitialized]: 766:14 => 
  - /home/kisskb/slave/src/lib/test_firmware.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 781:31 => 
  - /home/kisskb/slave/src/mm/huge_memory.c: warning: 'huge_gfp' may be used uninitialized in this function [-Wuninitialized]: 1318:2 => 
  - /home/kisskb/slave/src/mm/ksm.c: warning: 'found_rmap_hlist_len' may be used uninitialized in this function [-Wuninitialized]: 1365:4, 1365:15 => 1358:15
  - /home/kisskb/slave/src/mm/ksm.c: warning: 'stable_node' may be used uninitialized in this function [-Wuninitialized]: 1863:16 => 
  - /home/kisskb/slave/src/mm/memblock.c: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 1101:15 => 
  - /home/kisskb/slave/src/mm/memcontrol.c: warning: 'isolated' may be used uninitialized in this function [-Wuninitialized]: 2090:2 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'deactivate_slab.isra.47' uses dynamic stack allocation [enabled by default]: 2151:1 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'df.cnt' may be used uninitialized in this function [-Wuninitialized]: 2960:14 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'df.freelist' may be used uninitialized in this function [-Wuninitialized]: 2950:3, 2960:14 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'df.s' may be used uninitialized in this function [-Wuninitialized]: 269:43, 2939:1 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'df.tail' may be used uninitialized in this function [-Wuninitialized]: 2968:25, 2928:26 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'get_partial_node.isra.49' uses dynamic stack allocation [enabled by default]: 1851:1 => 
  - /home/kisskb/slave/src/mm/slub.c: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation [enabled by default]: 2219:1 => 
  - /home/kisskb/slave/src/net/rds/connection.c: warning: 'rds_walk_conn_path_info.isra.4.constprop.6' uses dynamic stack allocation [enabled by default]: 613:1 => 
  - /home/kisskb/slave/src/sound/drivers/serial-u16550.c: warning: 'uart' may be used uninitialized in this function [-Wuninitialized]: 959:6 => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-iop.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/soc_camera/soc_scale_crop.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/rtc/rtc-goldfish.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o: N/A => 
  - warning: "memcpy" [drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.ko] has no CRC!: N/A => 
  - warning: "memcpy" [drivers/misc/eeprom/at24.ko] has no CRC!: N/A => 
  - warning: "memcpy" [drivers/net/dummy.ko] has no CRC!: N/A => 
  - warning: "memcpy" [fs/ncpfs/ncpfs.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/bridge/netfilter/nf_tables_bridge.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/ipv4/netfilter/nf_tables_arp.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/ipv4/netfilter/nf_tables_ipv4.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/ipv6/netfilter/nf_tables_ipv6.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/ipx/ipx.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/netfilter/nf_tables_inet.ko] has no CRC!: N/A => 
  - warning: "memcpy" [net/netfilter/nf_tables_netdev.ko] has no CRC!: N/A => 
  - warning: vmlinux.o(.text+0x214): Section mismatch in reference from the function srcu_torture_stats_print() to the function .init.text:setup_profiling_timer(): N/A => 
  - warning: vmlinux.o(.text+0x34ec8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x35e8): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3956c): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x4a993b8): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x110): Section mismatch in reference from the function .init_fallback_flush() to the function .init.text:.safe_stack_limit(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x13c): Section mismatch in reference from the function .init_fallback_flush() to the function .init.text:.memblock_alloc_base(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x31dc): Section mismatch in reference from the function .pnv_setup_rfi_flush() to the function .init.text:.setup_rfi_flush(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
