Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeCEPlk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:41:40 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:41122 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeCEPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:41:35 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v4.16-rc4
Date: Mon,  5 Mar 2018 16:41:32 +0100
Message-Id: <1520264492-22030-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v4.16-rc4[1] compared to v4.15[2].

Summarized:
  - build errors: +11/-6
  - build warnings: +1510/-1466

JFYI, when comparing v4.16-rc4[1] to v4.16-rc3[3], the summaries are:
  - build errors: +10/-1
  - build warnings: +47244/-32

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/head/661e50bc853209e41a5c14a290ca4decc43cbfd1/ (all 274 configs)
[2] http://kisskb.ellerman.id.au/kisskb/head/d8a5b80568a9cb66810e75b182018e9edb68e8ff/ (271 out of 274 configs)
[3] http://kisskb.ellerman.id.au/kisskb/head/4a3928c6f8a53fa1aed28ccba227742486e8ddcb/ (268 out of 274 configs)


*** ERRORS ***

11 error regressions:
  + /kisskb/src/arch/powerpc/kvm/powerpc.c: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]:  => 1361:2
  + /kisskb/src/drivers/net/ethernet/intel/i40e/i40e_ethtool.c: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]:  => 4443:2, 4443:6
  + error: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: hotplug-cpu.c: undefined reference to `timed_topology_update':  => .text+0x410), .text+0x138)

6 error improvements:
  - /kisskb/src/arch/sh/mm/cache-sh4.c: error: 'cached_to_uncached' undeclared (first use in this function): 99:17 => 
  - /kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]: 192:2 => 
  - /kisskb/src/drivers/dma/omap-dma.c: error: unrecognizable insn:: 353:1 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_syncmap.c: error: 'err' may be used uninitialized in this function [-Werror=uninitialized]: 443:2 => 
  - error: "sgimc" [drivers/watchdog/indydog.ko] undefined!: N/A => 
  - error: No rule to make target arch/sh/boot/dts/.dtb.o: N/A => 


*** WARNINGS ***

[Deleted 967 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
[Deleted 1357 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

1510 warning regressions:
  + /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 13:2
  + /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'clearval' may be used uninitialized in this function [-Wuninitialized]:  => 34:2
  + /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 13:2
  + /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 13:2
  + /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 178:1
  + /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 178:1
  + /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 178:1
  + /kisskb/src/arch/powerpc/kvm/powerpc.c: warning: 'emulated' may be used uninitialized in this function [-Wuninitialized]:  => 1361:2
  + /kisskb/src/arch/x86/include/asm/io.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 66:1
  + /kisskb/src/arch/x86/include/asm/io.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 66:1
  + /kisskb/src/arch/x86/include/asm/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 66:1
  + /kisskb/src/arch/x86/kvm/svm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 6564:6, 6215:9
  + /kisskb/src/crypto/tcrypt.c: warning: 'do_mult_acipher_op' uses dynamic stack allocation [enabled by default]:  => 1144:1
  + /kisskb/src/crypto/tcrypt.c: warning: 'do_mult_aead_op' uses dynamic stack allocation [enabled by default]:  => 184:1
  + /kisskb/src/crypto/tcrypt.c: warning: 'test_mb_ahash_cycles' uses dynamic stack allocation [enabled by default]:  => 782:1
  + /kisskb/src/crypto/tcrypt.c: warning: 'test_mb_ahash_jiffies' uses dynamic stack allocation [enabled by default]:  => 746:1
  + /kisskb/src/drivers/dma-buf/reservation.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]:  => 210:7
  + /kisskb/src/drivers/dma-buf/reservation.c: warning: 'k' may be used uninitialized in this function [-Wuninitialized]:  => 225:6, 207:2, 155:1, 207:36
  + /kisskb/src/drivers/gpu/drm/radeon/radeon_object.c: warning: #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Wcpp]:  => 242:2
  + /kisskb/src/drivers/gpu/drm/sun4i/sun4i_tcon.c: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wuninitialized]:  => 915:51
  + /kisskb/src/drivers/infiniband/core/cq.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 78:1
  + /kisskb/src/drivers/infiniband/hw/bnxt_re/ib_verbs.c: warning: left shift count >= width of type [enabled by default]:  => 149:2, 3588:2, 3590:4
  + /kisskb/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 569:19
  + /kisskb/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 333:23, 336:12
  + /kisskb/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [enabled by default]:  => 569:2
  + /kisskb/src/drivers/infiniband/hw/cxgb4/device.c: warning: 'prev_time' may be used uninitialized in this function [-Wuninitialized]:  => 152:14
  + /kisskb/src/drivers/media/i2c/tvp7002.c: warning: 'cpl_msb' may be used uninitialized in this function [-Wuninitialized]:  => 647:37
  + /kisskb/src/drivers/media/usb/dvb-usb/pctv452e.c: warning: value computed is not used [-Wunused-value]:  => 922:2
  + /kisskb/src/drivers/mfd/rave-sp.c: warning: 'rave_sp_receive_frame' uses dynamic stack allocation [enabled by default]:  => 440:1
  + /kisskb/src/drivers/mtd/nand/nandsim.c: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat]:  => 760:2
  + /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'stmmac_dma_interrupt' uses dynamic stack allocation [enabled by default]:  => 2080:1
  + /kisskb/src/drivers/net/wireless/ath/carl9170/fwcmd.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>[]' [-Wattributes]:  => 124:2
  + /kisskb/src/drivers/net/wireless/intersil/p54/lmac.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>[3]' [-Wattributes]:  => 377:2
  + /kisskb/src/drivers/perf/arm_pmu_platform.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 234:5
  + /kisskb/src/drivers/sbus/char/oradax.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 478:15, 468:15, 498:15, 488:15
  + /kisskb/src/drivers/sbus/char/oradax.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 851:14
  + /kisskb/src/drivers/scsi/osst.h: warning: 'packed' attribute ignored for field of type 'u32' [-Wattributes]:  => 97:2
  + /kisskb/src/drivers/staging/ccree/cc_cipher.c: warning: 'cc_cipher_setkey' uses dynamic stack allocation [enabled by default]:  => 374:1
  + /kisskb/src/drivers/staging/gdm724x/gdm_lte.c: warning: 'packed' attribute ignored for field of type 'struct <anonymous>' [-Wattributes]:  => 196:3
  + /kisskb/src/drivers/staging/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u16' [-Wattributes]:  => 125:4, 129:4, 128:4, 127:4, 126:4
  + /kisskb/src/drivers/staging/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u32' [-Wattributes]:  => 123:4, 124:4
  + /kisskb/src/drivers/staging/vt6656/mac.h: warning: 'packed' attribute ignored for field of type 'struct <anonymous>' [-Wattributes]:  => 351:3
  + /kisskb/src/drivers/tty/serial/crisv10.c: warning: 'ser_interrupt' defined but not used [-Wunused-function]:  => 2462:1
  + /kisskb/src/fs/afs/write.c: warning: left shift count >= width of type [enabled by default]:  => 786:2, 138:2
  + /kisskb/src/fs/afs/write.c: warning: right shift count >= width of type [enabled by default]:  => 844:4, 117:3, 450:4, 406:2
  + /kisskb/src/fs/btrfs/tree-checker.c: warning: 'check_dir_item.isra.10' uses dynamic stack allocation [enabled by default]:  => 360:1
  + /kisskb/src/fs/f2fs/file.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 2786:6
  + /kisskb/src/include/asm-generic/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]:  => 155:15
  + /kisskb/src/include/drm/drm_print.h: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 105:24
  + /kisskb/src/include/linux/bitops.h: warning: left shift count >= width of type [-Wshift-count-overflow]:  => 7:24
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 3 has type 'ssize_t {aka int}' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/sched/mm.h: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 180:56
  + /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.<U4130>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]:  => 132:22
  + /kisskb/src/include/uapi/linux/byteorder/big_endian.h: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [-Wint-conversion]:  => 31:52
  + /kisskb/src/include/uapi/linux/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]:  => 52:9
  + /kisskb/src/include/uapi/linux/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 52:9
  + /kisskb/src/include/uapi/linux/swab.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 24:4, 130:24, 31:4, 30:4, 127:46, 25:4, 29:4, 28:4, 27:4, 26:4
  + /kisskb/src/kernel/fork.c: warning: 'task_struct_whitelist' defined but not used [-Wunused-function]:  => 691:13
  + /kisskb/src/kernel/jump_label.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 376:51
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1640>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3280>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3780>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4960>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U56e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6280>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32, 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6640>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32, 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U85a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U86e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8780>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua780>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uad20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub000>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub140>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucdc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ued20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uee60>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf780>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufdc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/lib/test_bitmap.c: warning: 'test_bitmap_arr32' uses dynamic stack allocation [enabled by default]:  => 319:1
  + /kisskb/src/lib/test_kasan.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 504:1
  + /kisskb/src/mm/hugetlb.c: warning: 'page' may be used uninitialized in this function [-Wuninitialized]:  => 1439:5
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.48' uses dynamic stack allocation [enabled by default]:  => 2153:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.50' uses dynamic stack allocation [enabled by default]:  => 1853:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.49' uses dynamic stack allocation [enabled by default]:  => 2221:1
  + /kisskb/src/net/rds/connection.c: warning: 'rds_walk_conn_path_info.isra.2.constprop.4' uses dynamic stack allocation [enabled by default]:  => 622:1
  + /kisskb/src/net/xfrm/xfrm_policy.c: warning: array subscript is above array bounds [-Warray-bounds]:  => 2375:15
  + /kisskb/src/sound/soc/fsl/fsl_ssi.c: warning: 'baudrate' may be used uninitialized in this function [-Wuninitialized]:  => 774:7
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
  + warning: vmlinux.o(.text+0x4b93ef8): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o(.text+0x79c50): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x79c5c): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7a23c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7a248): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b64c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b658): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b99c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text+0x7b9a8): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1c8): Section mismatch in reference from the function .init_fallback_flush() to the function .init.text:.ppc64_bolted_size():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1f4): Section mismatch in reference from the function .init_fallback_flush() to the function .init.text:.memblock_alloc_base():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x32f4): Section mismatch in reference from the function .pnv_setup_rfi_flush() to the function .init.text:.setup_rfi_flush():  => N/A

1466 warning improvements:
  - /kisskb/src/arch/arm/include/asm/spinlock.h: warning: 'ws' may be used uninitialized in this function [-Wuninitialized]: 110:21 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count >= width of type [enabled by default]: 334:1, 310:1, 108:1, 145:2, 145:1, 334:2, 115:1, 122:1 => 108:1, 334:2, 115:1, 122:1, 145:2, 310:1
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count is negative [enabled by default]: 310:1, 323:2, 81:1, 129:1, 108:1, 92:1, 81:2, 92:2, 122:1, 333:1, 115:1, 323:1 => 92:1, 115:1, 333:1, 122:1, 323:2, 310:1, 81:1, 129:1, 108:1
  - /kisskb/src/arch/sh/math-emu/math.c: warning: right shift count >= width of type [enabled by default]: 296:3, 294:1, 296:1, 294:3 => 296:3, 294:3
  - /kisskb/src/arch/sh/math-emu/math.c: warning: right shift count is negative [enabled by default]: 324:1, 145:1, 145:2, 334:2, 122:1, 115:1, 294:1, 334:1, 294:3, 310:1, 324:2, 129:1, 108:1 => 129:1, 108:1, 294:3, 310:1, 324:2, 145:2, 334:2, 122:1, 115:1
  - /kisskb/src/arch/x86/events/amd/ibs.c: warning: 'config' may be used uninitialized in this function [-Wuninitialized]: 306:11 => 
  - /kisskb/src/arch/x86/events/intel/uncore_snbep.c: warning: 'bus' may be used uninitialized in this function [-Wuninitialized]: 3576:3 => 
  - /kisskb/src/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c: warning: 'data' may be used uninitialized in this function [-Wuninitialized]: 77:14, 139:14 => 
  - /kisskb/src/arch/x86/kernel/espfix_64.c: warning: 'rand' may be used uninitialized in this function [-Wuninitialized]: 118:22 => 
  - /kisskb/src/arch/x86/kernel/ftrace.c: warning: 'size' may be used uninitialized in this function [-Wuninitialized]: 862:24 => 
  - /kisskb/src/arch/x86/kernel/hw_breakpoint.c: warning: 'align' may be used uninitialized in this function [-Wuninitialized]: 361:2, 361:20 => 361:20
  - /kisskb/src/arch/x86/kernel/ksysfs.c: warning: 'size' may be used uninitialized in this function [-Wuninitialized]: 227:17 => 
  - /kisskb/src/arch/x86/kernel/umip.c: warning: 'dummy_data_size' may be used uninitialized in this function [-Wuninitialized]: 414:27 => 
  - /kisskb/src/arch/x86/lib/insn-eval.c: warning: 'eff_addr' may be used uninitialized in this function [-Wuninitialized]: 1173:2 => 
  - /kisskb/src/block/bfq-iosched.c: warning: 'bfqd' may be used uninitialized in this function [-Wuninitialized]: 3860:2 => 
  - /kisskb/src/block/bfq-wf2q.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 812:24 => 
  - /kisskb/src/block/blk-cgroup.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 354:1 => 
  - /kisskb/src/block/blk-merge.c: warning: 'bbio' may be used uninitialized in this function [-Wuninitialized]: 285:2 => 
  - /kisskb/src/block/blk-mq.c: warning: 'wait' may be used uninitialized in this function [-Wuninitialized]: 1068:16 => 
  - /kisskb/src/block/blk-sysfs.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]: 459:21, 456:2 => 
  - /kisskb/src/block/bsg.c: warning: 'op' may be used uninitialized in this function [-Wuninitialized]: 244:2 => 
  - /kisskb/src/block/cfq-iosched.c: warning: control reaches end of non-void function [-Wreturn-type]: 3804:1 => 
  - /kisskb/src/drivers/acpi/acpica/exprep.c: warning: 'byte_alignment' may be used uninitialized in this function [-Wuninitialized]: 386:6 => 
  - /kisskb/src/drivers/acpi/ec.c: warning: 'handle' may be used uninitialized in this function [-Wuninitialized]: 1782:19 => 
  - /kisskb/src/drivers/acpi/osl.c: warning: 'queue' may be used uninitialized in this function [-Wuninitialized]: 1102:21 => 
  - /kisskb/src/drivers/acpi/pmic/tps68470_pmic.c: warning: 'bitmask' may be used uninitialized in this function [-Wuninitialized]: 307:36 => 
  - /kisskb/src/drivers/acpi/pmic/tps68470_pmic.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]: 307:36 => 
  - /kisskb/src/drivers/acpi/scan.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1830:24 => 
  - /kisskb/src/drivers/acpi/sysfs.c: warning: 'result' may be used uninitialized in this function [-Wuninitialized]: 654:6 => 
  - /kisskb/src/drivers/android/binder.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 5522:6 => 
  - /kisskb/src/drivers/android/binder_alloc.c: warning: 'buffer' may be used uninitialized in this function [-Wuninitialized]: 433:30 => 
  - /kisskb/src/drivers/android/binder_alloc.c: warning: 'buffer_size' may be used uninitialized in this function [-Wuninitialized]: 434:2 => 
  - /kisskb/src/drivers/auxdisplay/img-ascii-lcd.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 109:5, 207:2, 109:2, 207:5 => 207:5, 109:5
  - /kisskb/src/drivers/base/dma-coherent.c: warning: 'mem' may be used uninitialized in this function [-Wuninitialized]: 124:30 => 
  - /kisskb/src/drivers/base/regmap/regcache-rbtree.c: warning: 'new_base_reg' may be used uninitialized in this function [-Wuninitialized]: 289:13 => 
  - /kisskb/src/drivers/base/regmap/regcache-rbtree.c: warning: 'new_top_reg' may be used uninitialized in this function [-Wuninitialized]: 288:20 => 
  - /kisskb/src/drivers/base/regmap/regmap.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 2515:6 => 
  - /kisskb/src/drivers/block/drbd/drbd_receiver.c: warning: 'rl' may be used uninitialized in this function [-Wuninitialized]: 4573:32 => 
  - /kisskb/src/drivers/block/drbd/drbd_receiver.c: warning: 'what' may be used uninitialized in this function [-Wuninitialized]: 5588:2 => 
  - /kisskb/src/drivers/block/drbd/drbd_vli.h: warning: control reaches end of non-void function [-Wreturn-type]: 164:1 => 
  - /kisskb/src/drivers/char/hpet.c: warning: 'gsi' may be used uninitialized in this function [-Wuninitialized]: 254:19 => 
  - /kisskb/src/drivers/char/random.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 2131:6 => 
  - /kisskb/src/drivers/char/tpm/tpm-sysfs.c: warning: 'tpm_buf.data' may be used uninitialized in this function [-Wuninitialized]: 37:16 => 
  - /kisskb/src/drivers/char/tpm/tpm2-cmd.c: warning: 'hash' may be used uninitialized in this function [-Wuninitialized]: 514:20 => 
  - /kisskb/src/drivers/char/tpm/tpm2-cmd.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 876:2 => 
  - /kisskb/src/drivers/char/tpm/tpm_atmel.c: warning: 'base' may be used uninitialized in this function [-Wuninitialized]: 221:3, 198:13 => 
  - /kisskb/src/drivers/clk/renesas/rcar-gen2-cpg.c: warning: 'shift' may be used uninitialized in this function [-Wuninitialized]: 354:36 => 
  - /kisskb/src/drivers/crypto/atmel-sha.c: warning: 'key' may be used uninitialized in this function [-Wuninitialized]: 1804:8 => 
  - /kisskb/src/drivers/crypto/atmel-sha.c: warning: 'keylen' may be used uninitialized in this function [-Wuninitialized]: 1812:2 => 
  - /kisskb/src/drivers/crypto/caam/caamalg_qi.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat]: 1062:16, 672:16, 909:16 => 
  - /kisskb/src/drivers/crypto/qat/qat_common/qat_uclo.c: warning: 'img_desc.dram_base_addr_v' may be used uninitialized in this function [-Wuninitialized]: 1359:8 => 
  - /kisskb/src/drivers/crypto/qat/qat_common/qat_uclo.c: warning: 'img_desc.dram_bus_addr' may be used uninitialized in this function [-Wuninitialized]: 1284:12 => 
  - /kisskb/src/drivers/crypto/qat/qat_common/qat_uclo.c: warning: 'img_desc.dram_size' may be used uninitialized in this function [-Wuninitialized]: 1281:25 => 
  - /kisskb/src/drivers/devfreq/exynos-bus.c: warning: 'edata.load_count' may be used uninitialized in this function [-Wuninitialized]: 172:38 => 
  - /kisskb/src/drivers/devfreq/exynos-bus.c: warning: 'edata.total_count' may be used uninitialized in this function [-Wuninitialized]: 175:2 => 
  - /kisskb/src/drivers/firewire/core-device.c: warning: 'changed' may be used uninitialized in this function [-Wuninitialized]: 1154:2 => 
  - /kisskb/src/drivers/gpio/gpio-wm831x.c: warning: 'powerdomain' may be used uninitialized in this function [-Wuninitialized]: 234:13 => 
  - /kisskb/src/drivers/gpio/gpiolib-acpi.c: warning: 'desc' may be used uninitialized in this function [-Wuninitialized]: 929:47 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'crtc' may be used uninitialized in this function [-Wuninitialized]: 4537:5 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'dc_stream_attach' may be used uninitialized in this function [-Wuninitialized]: 3991:3 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'new_crtc_state' may be used uninitialized in this function [-Wuninitialized]: 4540:5, 4213:3 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'new_plane_state' may be used uninitialized in this function [-Wuninitialized]: 4666:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c: warning: 'handler' may be used uninitialized in this function [-Wuninitialized]: 163:7 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c: warning: 'id' may be used uninitialized in this function [-Wuninitialized]: 242:51 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c: warning: 'reg_val' may be used uninitialized in this function [-Wuninitialized]: 157:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.c: warning: 'index' may be used uninitialized in this function [-Wuninitialized]: 503:6 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/pp_psm.c: warning: 'state_id' may be used uninitialized in this function [-Wuninitialized]: 184:7, 172:7 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomctrl.c: warning: 'reg_block' may be used uninitialized in this function [-Wuninitialized]: 83:27 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/processpptables.c: warning: 'result' may be used uninitialized in this function [-Wuninitialized]: 1045:6 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c: warning: 'result' may be used uninitialized in this function [-Wuninitialized]: 1126:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/ci_smumgr.c: warning: 'voltage_level' may be used uninitialized in this function [-Wuninitialized]: 1462:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/ci_smumgr.c: warning: 'voltage_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1462:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.c: warning: 'vol_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1430:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.c: warning: 'voltage_level' may be used uninitialized in this function [-Wuninitialized]: 1518:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.c: warning: 'voltage_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1518:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smumgr.c: warning: 'voltage_level.Voltage' may be used uninitialized in this function [-Wuninitialized]: 1236:4 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 3041:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: warning: 'fault' may be used uninitialized in this function [-Wuninitialized]: 2768:24 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: warning: 'incr' may be used uninitialized in this function [-Wuninitialized]: 1168:14 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: warning: 'fw_data' may be used uninitialized in this function [-Wuninitialized]: 1949:12, 1293:5 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: warning: 'table_offset' may be used uninitialized in this function [-Wuninitialized]: 1949:12 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: warning: 'table_size' may be used uninitialized in this function [-Wuninitialized]: 1296:13, 1949:12 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: warning: 'fw_data' may be used uninitialized in this function [-Wuninitialized]: 1304:12, 804:5 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: warning: 'table_offset' may be used uninitialized in this function [-Wuninitialized]: 1304:12 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: warning: 'table_size' may be used uninitialized in this function [-Wuninitialized]: 807:13, 1304:12 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/soc15.c: warning: #warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15." [-Wcpp]: 558:3, 539:3 => 
  - /kisskb/src/drivers/gpu/drm/ast/ast_mode.c: warning: 'edid' may be used uninitialized in this function [-Wuninitialized]: 791:2 => 
  - /kisskb/src/drivers/gpu/drm/ast/ast_mode.c: warning: 'vbios_mode.enh_table' may be used uninitialized in this function [-Wuninitialized]: 468:2 => 
  - /kisskb/src/drivers/gpu/drm/ast/ast_mode.c: warning: 'vbios_mode.std_table' may be used uninitialized in this function [-Wuninitialized]: 245:8 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic.c: warning: 'crtc_state' may be used uninitialized in this function [-Wuninitialized]: 2126:14 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic.c: warning: 'plane' may be used uninitialized in this function [-Wuninitialized]: 831:2 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic.c: warning: 'plane_state' may be used uninitialized in this function [-Wuninitialized]: 831:2 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'new_crtc_state' may be used uninitialized in this function [-Wuninitialized]: 1775:26 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'new_plane_state' may be used uninitialized in this function [-Wuninitialized]: 1436:2 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'old_plane_state' may be used uninitialized in this function [-Wuninitialized]: 1432:2 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic_helper.c: warning: 'plane' may be used uninitialized in this function [-Wuninitialized]: 1436:2 => 
  - /kisskb/src/drivers/gpu/drm/drm_bufs.c: warning: 'master' may be used uninitialized in this function [-Wuninitialized]: 526:4 => 
  - /kisskb/src/drivers/gpu/drm/drm_edid.c: warning: 'clock2' may be used uninitialized in this function [-Wuninitialized]: 3112:3 => 
  - /kisskb/src/drivers/gpu/drm/drm_edid.c: warning: 'hdmi_len' may be used uninitialized in this function [-Wuninitialized]: 3710:30 => 
  - /kisskb/src/drivers/gpu/drm/i915/i915_gem_gtt.c: warning: 'addr' may be used uninitialized in this function [-Wuninitialized]: 574:25 => 
  - /kisskb/src/drivers/gpu/drm/i915/i915_gem_request.h: warning: 'seqno' may be used uninitialized in this function [-Wuninitialized]: 319:20 => 
  - /kisskb/src/drivers/gpu/drm/i915/i915_vma.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 768:3 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_bios.c: warning: 'seq_size' may be used uninitialized in this function [-Wuninitialized]: 1016:25 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_crt.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 759:6 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_csr.c: warning: 'si' may be used uninitialized in this function [-Wuninitialized]: 204:3 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_display.c: warning: 'crtc' may be used uninitialized in this function [-Wuninitialized]: 12066:7 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_display.c: warning: 'crtc_state' may be used uninitialized in this function [-Wuninitialized]: 12063:3 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_display.c: warning: 'old_crtc_state' may be used uninitialized in this function [-Wuninitialized]: 12055:3 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_dpio_phy.c: warning: 'was_enabled' may be used uninitialized in this function [-Wuninitialized]: 482:2 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_pipe_crc.c: warning: 'pipe' may be used uninitialized in this function [-Wuninitialized]: 671:2 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_pm.c: warning: 'cstate' may be used uninitialized in this function [-Wuninitialized]: 4497:32 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_runtime_pm.c: warning: 'reqs' may be used uninitialized in this function [-Wuninitialized]: 352:2 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_h' may be used uninitialized in this function [-Wuninitialized]: 1009:3 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_w' may be used uninitialized in this function [-Wuninitialized]: 1009:3 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_x' may be used uninitialized in this function [-Wuninitialized]: 1012:25 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_sprite.c: warning: 'src_y' may be used uninitialized in this function [-Wuninitialized]: 1025:20 => 
  - /kisskb/src/drivers/gpu/drm/i915/intel_tv.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1300:19 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_gem_context.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 328:6 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 1317:2, 774:3, 984:2, 1354:6 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_gem_request.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 404:2 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_gem_request.c: warning: 'request' may be used uninitialized in this function [-Wuninitialized]: 380:21 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_gem_timeline.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 82:6 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_syncmap.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 443:2 => 
  - /kisskb/src/drivers/gpu/drm/i915/selftests/i915_vma.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 206:2 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nv50_display.c: warning: 'curs' may be used uninitialized in this function [-Wuninitialized]: 2350:27 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 491:2 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 79:4 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c: warning: 'free' may be used uninitialized in this function [-Wuninitialized]: 223:2 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]: 163:16 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c: warning: 'stat' may be used uninitialized in this function [-Wuninitialized]: 160:31 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c: warning: 'stat' may be used uninitialized in this function [-Wuninitialized]: 160:31 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c: warning: 'emap' may be used uninitialized in this function [-Wuninitialized]: 157:10 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv50.c: warning: 'pt' may be used uninitialized in this function [-Wuninitialized]: 129:11 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]: 154:40 => 
  - /kisskb/src/drivers/gpu/drm/radeon/radeon_uvd.c: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 175:2 => 
  - /kisskb/src/drivers/gpu/drm/radeon/rv770_dpm.c: warning: 'postdiv_yclk' may be used uninitialized in this function [-Wuninitialized]: 434:23 => 
  - /kisskb/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'near_tdp_limit' may be used uninitialized in this function [-Wuninitialized]: 2185:4 => 
  - /kisskb/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'tdp_limit' may be used uninitialized in this function [-Wuninitialized]: 2183:4 => 
  - /kisskb/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'vddc_max' may be used uninitialized in this function [-Wuninitialized]: 2686:11 => 
  - /kisskb/src/drivers/gpu/drm/radeon/si_dpm.c: warning: 'vddc_min' may be used uninitialized in this function [-Wuninitialized]: 2685:41 => 
  - /kisskb/src/drivers/gpu/drm/radeon/trinity_dpm.c: warning: 'min_vce_voltage' may be used uninitialized in this function [-Wuninitialized]: 1576:4 => 
  - /kisskb/src/drivers/gpu/drm/udl/udl_modeset.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]: 29:9 => 
  - /kisskb/src/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c: warning: 'depth' may be used uninitialized in this function [-Wuninitialized]: 541:28 => 
  - /kisskb/src/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c: warning: 'res' may be used uninitialized in this function [-Wuninitialized]: 1012:6 => 
  - /kisskb/src/drivers/gpu/vga/vgaarb.c: warning: 'devfn' may be used uninitialized in this function [-Wuninitialized]: 1201:4 => 
  - /kisskb/src/drivers/hid/hid-asus.c: warning: 'kbd_func' may be used uninitialized in this function [-Wuninitialized]: 350:2 => 
  - /kisskb/src/drivers/hid/hid-logitech-hidpp.c: warning: '__name_length' may be used uninitialized in this function [-Wuninitialized]: 868:15 => 
  - /kisskb/src/drivers/hid/hid-logitech-hidpp.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 1040:24 => 
  - /kisskb/src/drivers/hid/hid-picolcd_debugfs.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 312:10 => 
  - /kisskb/src/drivers/hid/usbhid/hid-core.c: warning: 'field' may be used uninitialized in this function [-Wuninitialized]: 819:16 => 
  - /kisskb/src/drivers/hv/channel.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 502:6 => 
  - /kisskb/src/drivers/hwmon/applesmc.c: warning: 'count' may be used uninitialized in this function [-Wuninitialized]: 552:2 => 
  - /kisskb/src/drivers/hwmon/ltc2990.c: warning: 'value' may be used uninitialized in this function [-Wuninitialized]: 89:17 => 
  - /kisskb/src/drivers/i2c/busses/i2c-diolan-u2c.c: warning: 'byte' may be used uninitialized in this function [-Wuninitialized]: 393:18 => 
  - /kisskb/src/drivers/ide/ide-floppy.c: warning: 'pc' may be used uninitialized in this function [-Wuninitialized]: 302:2 => 
  - /kisskb/src/drivers/ide/ide-io.c: warning: control reaches end of non-void function [-Wreturn-type]: 295:1 => 
  - /kisskb/src/drivers/iio/accel/bmc150-accel-core.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 860:2 => 
  - /kisskb/src/drivers/iio/accel/mma9551.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]: 381:32 => 
  - /kisskb/src/drivers/iio/accel/mma9551_core.c: warning: 'pol_mask' may be used uninitialized in this function [-Wuninitialized]: 590:34 => 
  - /kisskb/src/drivers/iio/adc/bcm_iproc_adc.c: warning: 'adc_data' may be used uninitialized in this function [-Wuninitialized]: 477:8 => 
  - /kisskb/src/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: warning: 'st_lsm6dsx_read_fifo' uses dynamic stack allocation [enabled by default]: 306:1 => 
  - /kisskb/src/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c: warning: 'st_lsm6dsx_i2c_write' uses dynamic stack allocation [enabled by default]: 53:1 => 
  - /kisskb/src/drivers/iio/industrialio-core.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 1307:8 => 
  - /kisskb/src/drivers/iio/industrialio-core.c: warning: 'sz' may be used uninitialized in this function [-Wuninitialized]: 1308:2 => 
  - /kisskb/src/drivers/iio/industrialio-core.c: warning: control reaches end of non-void function [-Wreturn-type]: 262:1 => 
  - /kisskb/src/drivers/iio/light/isl29018.c: warning: 'new_int_time' may be used uninitialized in this function [-Wuninitialized]: 128:16 => 
  - /kisskb/src/drivers/iio/light/lm3533-als.c: warning: 'enable' may be used uninitialized in this function [-Wuninitialized]: 424:18 => 
  - /kisskb/src/drivers/iio/light/opt3001.c: warning: 'exponent' may be used uninitialized in this function [-Wuninitialized]: 515:23 => 
  - /kisskb/src/drivers/iio/proximity/srf08.c: warning: 'regval' may be used uninitialized in this function [-Wuninitialized]: 370:33 => 
  - /kisskb/src/drivers/iio/temperature/tsys01.c: warning: 'temperature' may be used uninitialized in this function [-Wuninitialized]: 94:9 => 
  - /kisskb/src/drivers/infiniband/core/rw.c: warning: 'first_wr' may be used uninitialized in this function [-Wuninitialized]: 546:2 => 
  - /kisskb/src/drivers/infiniband/core/rw.c: warning: 'last_wr' may be used uninitialized in this function [-Wuninitialized]: 543:23 => 
  - /kisskb/src/drivers/infiniband/ulp/srp/ib_srp.c: warning: comparison of distinct pointer types lacks a cast [enabled by default]: 3624:19 => 
  - /kisskb/src/drivers/input/mouse/cyapa.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 717:3 => 
  - /kisskb/src/drivers/input/mouse/cyapa_gen3.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 970:2 => 
  - /kisskb/src/drivers/input/touchscreen/hideep.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 632:2 => 
  - /kisskb/src/drivers/input/touchscreen/melfas_mip4.c: warning: 'fw_size' may be used uninitialized in this function [-Wuninitialized]: 1118:26 => 
  - /kisskb/src/drivers/input/touchscreen/melfas_mip4.c: warning: 'fw_start_offset' may be used uninitialized in this function [-Wuninitialized]: 1118:26 => 
  - /kisskb/src/drivers/input/touchscreen/s6sy761.c: warning: 'max_x' may be used uninitialized in this function [-Wuninitialized]: 436:22 => 
  - /kisskb/src/drivers/input/touchscreen/s6sy761.c: warning: 'max_y' may be used uninitialized in this function [-Wuninitialized]: 437:22 => 
  - /kisskb/src/drivers/input/touchscreen/sis_i2c.c: warning: 'contact_size' may be used uninitialized in this function [-Wuninitialized]: 265:12 => 
  - /kisskb/src/drivers/input/touchscreen/sis_i2c.c: warning: 'num_contacts' may be used uninitialized in this function [-Wuninitialized]: 250:11 => 
  - /kisskb/src/drivers/input/touchscreen/sun4i-ts.c: warning: 'temp' may be used uninitialized in this function [-Wuninitialized]: 224:16 => 
  - /kisskb/src/drivers/input/touchscreen/wdt87xx_i2c.c: warning: 'device_checksum' may be used uninitialized in this function [-Wuninitialized]: 753:4 => 
  - /kisskb/src/drivers/leds/leds-pca955x.c: warning: 'ls' may be used uninitialized in this function [-Wuninitialized]: 288:22 => 
  - /kisskb/src/drivers/media/dvb-core/dvb_frontend.c: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 2470:1 => 
  - /kisskb/src/drivers/media/dvb-frontends/cxd2841er.c: warning: 'carrier_offset' may be used uninitialized in this function [-Wuninitialized]: 3582:17 => 
  - /kisskb/src/drivers/media/v4l2-core/videobuf2-core.c: warning: 'vb' may be used uninitialized in this function [-Wuninitialized]: 2520:3 => 
  - /kisskb/src/drivers/misc/bh1770glc.c: warning: 'mode' may be used uninitialized in this function [-Wuninitialized]: 236:29 => 
  - /kisskb/src/drivers/misc/mei/bus-fixup.c: warning: 'ver.radio_type' may be used uninitialized in this function [-Wuninitialized]: 302:3 => 
  - /kisskb/src/drivers/misc/mei/bus-fixup.c: warning: 'ver.vendor_id' may be used uninitialized in this function [-Wuninitialized]: 301:2 => 
  - /kisskb/src/drivers/misc/vmw_vmci/vmci_datagram.c: warning: 'src_priv_flags' may be used uninitialized in this function [-Wuninitialized]: 262:4 => 
  - /kisskb/src/drivers/mtd/chips/cfi_cmdset_0002.c: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]: 1844:9 => 
  - /kisskb/src/drivers/mtd/chips/cfi_cmdset_0020.c: warning: the frame size of 1396 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 603:1 => 
  - /kisskb/src/drivers/mtd/devices/phram.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 114:16 => 
  - /kisskb/src/drivers/mtd/nand/nand_base.c: warning: 'best_ecc_bytes' may be used uninitialized in this function [-Wuninitialized]: 4490:18, 4563:18 => 
  - /kisskb/src/drivers/mtd/nand/nand_base.c: warning: 'best_step' may be used uninitialized in this function [-Wuninitialized]: 4488:17 => 
  - /kisskb/src/drivers/mtd/nand/nand_base.c: warning: 'best_strength' may be used uninitialized in this function [-Wuninitialized]: 4562:21, 4489:21 => 
  - /kisskb/src/drivers/nubus/proc.c: warning: #warning Need to set some I/O handlers here [-Wcpp]: 65:2 => 
  - /kisskb/src/drivers/nvme/target/io-cmd.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 144:21 => 
  - /kisskb/src/drivers/pci/quirks.c: warning: 'host_bridge' may be used uninitialized in this function [-Wuninitialized]: 2605:6 => 
  - /kisskb/src/drivers/pci/vc.c: warning: 'ctrl_pos2' may be used uninitialized in this function [-Wuninitialized]: 158:24 => 
  - /kisskb/src/drivers/platform/goldfish/goldfish_pipe.c: warning: 'consumed_size' may be used uninitialized in this function [-Wuninitialized]: 480:10 => 
  - /kisskb/src/drivers/platform/goldfish/goldfish_pipe.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 483:3 => 
  - /kisskb/src/drivers/platform/x86/wmi.c: warning: 'wblock' may be used uninitialized in this function [-Wuninitialized]: 1323:9 => 
  - /kisskb/src/drivers/power/supply/bq24190_charger.c: warning: 'en_term' may be used uninitialized in this function [-Wuninitialized]: 795:27 => 
  - /kisskb/src/drivers/power/supply/bq24190_charger.c: warning: 'force_20pct' may be used uninitialized in this function [-Wuninitialized]: 788:27 => 
  - /kisskb/src/drivers/power/supply/da9052-battery.c: warning: 'chg_end_current' may be used uninitialized in this function [-Wuninitialized]: 266:4 => 
  - /kisskb/src/drivers/power/supply/da9052-battery.c: warning: 'level_lower' may be used uninitialized in this function [-Wuninitialized]: 325:6 => 
  - /kisskb/src/drivers/power/supply/da9052-battery.c: warning: 'level_upper' may be used uninitialized in this function [-Wuninitialized]: 324:22 => 
  - /kisskb/src/drivers/power/supply/da9052-battery.c: warning: 'vbat_lower' may be used uninitialized in this function [-Wuninitialized]: 325:37 => 
  - /kisskb/src/drivers/power/supply/da9052-battery.c: warning: 'vbat_upper' may be used uninitialized in this function [-Wuninitialized]: 324:59 => 
  - /kisskb/src/drivers/rapidio/devices/rio_mport_cdev.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 273:6 => 
  - /kisskb/src/drivers/regulator/max8925-regulator.c: warning: 'ri' may be used uninitialized in this function [-Wuninitialized]: 313:45 => 
  - /kisskb/src/drivers/regulator/tps6586x-regulator.c: warning: 'num' may be used uninitialized in this function [-Wuninitialized]: 361:3 => 
  - /kisskb/src/drivers/scsi/sd.c: warning: control reaches end of non-void function [-Wreturn-type]: 1310:1 => 
  - /kisskb/src/drivers/spi/spi-sprd-adi.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]: 230:21 => 
  - /kisskb/src/drivers/spi/spidev.c: warning: 'n_ioc' may be used uninitialized in this function [-Wuninitialized]: 478:10 => 
  - /kisskb/src/drivers/staging/ccree/ssi_cipher.c: warning: 'ssi_blkcipher_setkey' uses dynamic stack allocation [enabled by default]: 419:1 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_mio_common.c: warning: 'freq_divider' may be used uninitialized in this function [-Wuninitialized]: 4897:22 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_mio_common.c: warning: 'freq_multiplier' may be used uninitialized in this function [-Wuninitialized]: 4898:8 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'gate2_sel' may be used uninitialized in this function [-Wuninitialized]: 954:34 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'gate_sel' may be used uninitialized in this function [-Wuninitialized]: 867:22, 909:22 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'ni_660x_clock' may be used uninitialized in this function [-Wuninitialized]: 667:10 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'ni_m_series_clock' may be used uninitialized in this function [-Wuninitialized]: 724:10 => 
  - /kisskb/src/drivers/staging/comedi/drivers/ni_tio.c: warning: 'source' may be used uninitialized in this function [-Wuninitialized]: 1175:7, 1222:7, 1122:7 => 
  - /kisskb/src/drivers/staging/fbtft/fbtft-core.c: warning: 'ts_start' may be used uninitialized in this function [-Wuninitialized]: 411:23 => 
  - /kisskb/src/drivers/staging/greybus/bootrom.c: warning: 'fw' may be used uninitialized in this function [-Wuninitialized]: 300:2 => 
  - /kisskb/src/drivers/staging/greybus/bootrom.c: warning: 'offset' may be used uninitialized in this function [-Wuninitialized]: 300:2 => 
  - /kisskb/src/drivers/staging/greybus/bootrom.c: warning: 'size' may be used uninitialized in this function [-Wuninitialized]: 300:2 => 
  - /kisskb/src/drivers/staging/greybus/interface.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 1024:4 => 
  - /kisskb/src/drivers/staging/greybus/manifest.c: warning: 'desc_string' may be used uninitialized in this function [-Wuninitialized]: 214:20 => 
  - /kisskb/src/drivers/staging/greybus/svc.c: warning: 'rail_count' may be used uninitialized in this function [-Wuninitialized]: 785:29 => 
  - /kisskb/src/drivers/staging/most/aim-cdev/cdev.c: warning: 'mbo' may be used uninitialized in this function [-Wuninitialized]: 281:2 => 
  - /kisskb/src/drivers/staging/vboxvideo/vbox_fb.c: warning: 'gobj' may be used uninitialized in this function [-Wuninitialized]: 173:30 => 
  - /kisskb/src/drivers/tty/serial/8250/8250_core.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]: 206:2, 251:18 => 251:18
  - /kisskb/src/drivers/tty/serial/ifx6x60.c: warning: 'cts' may be used uninitialized in this function [-Wuninitialized]: 667:26 => 
  - /kisskb/src/drivers/tty/serial/ifx6x60.c: warning: 'length' may be used uninitialized in this function [-Wuninitialized]: 669:19 => 
  - /kisskb/src/drivers/usb/core/hcd.c: warning: 'bufp' may be used uninitialized in this function [-Wuninitialized]: 709:3, 709:10 => 
  - /kisskb/src/drivers/usb/dwc3/gadget.c: warning: 'trb' may be used uninitialized in this function [-Wuninitialized]: 2335:4 => 
  - /kisskb/src/drivers/usb/gadget/function/f_fs.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 2194:7 => 
  - /kisskb/src/drivers/usb/host/max3421-hcd.c: warning: 'ep' may be used uninitialized in this function [-Wuninitialized]: 2019:1 => 
  - /kisskb/src/drivers/usb/host/max3421-hcd.c: warning: 'max3421_ep' may be used uninitialized in this function [-Wuninitialized]: 787:26 => 
  - /kisskb/src/drivers/usb/host/max3421-hcd.c: warning: 'max3421_hcd' may be used uninitialized in this function [-Wuninitialized]: 1959:3 => 
  - /kisskb/src/drivers/usb/host/xhci-hub.c: warning: 'ssa_count' may be used uninitialized in this function [-Wuninitialized]: 113:26 => 
  - /kisskb/src/drivers/usb/misc/sisusbvga/sisusb_init.c: warning: 'ModeIdIndex' may be used uninitialized in this function [-Wuninitialized]: 910:30 => 
  - /kisskb/src/drivers/usb/serial/cp210x.c: warning: 'count' may be used uninitialized in this function [-Wuninitialized]: 867:2 => 
  - /kisskb/src/drivers/usb/serial/f81534.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 230:2, 191:2 => 
  - /kisskb/src/drivers/usb/serial/io_edgeport.c: warning: 'divisor' may be used uninitialized in this function [-Wuninitialized]: 2348:2 => 
  - /kisskb/src/drivers/usb/serial/mos7720.c: warning: 'divisor' may be used uninitialized in this function [-Wuninitialized]: 1505:45 => 
  - /kisskb/src/drivers/usb/serial/qcserial.c: warning: 'ifnum' may be used uninitialized in this function [-Wuninitialized]: 404:29 => 
  - /kisskb/src/drivers/usb/typec/fusb302/fusb302.c: warning: 'ra_comp' may be used uninitialized in this function [-Wuninitialized]: 1425:7 => 
  - /kisskb/src/drivers/usb/typec/tcpm.c: warning: 'rdo' may be used uninitialized in this function [-Wuninitialized]: 1793:17 => 
  - /kisskb/src/drivers/usb/wusbcore/devconnect.c: warning: 'port' may be used uninitialized in this function [-Wuninitialized]: 315:17 => 
  - /kisskb/src/drivers/uwb/i1480/dfu/phy.c: warning: 'phy_stat' may be used uninitialized in this function [-Wuninitialized]: 189:2 => 
  - /kisskb/src/drivers/video/backlight/adp8860_bl.c: warning: 'ret_val' may be used uninitialized in this function [-Wuninitialized]: 579:10 => 
  - /kisskb/src/drivers/video/fbdev/aty/aty128fb.c: warning: 'output_freq' may be used uninitialized in this function [-Wuninitialized]: 1401:4 => 
  - /kisskb/src/drivers/video/fbdev/matrox/matroxfb_maven.c: warning: 'c' may be used uninitialized in this function [-Wuninitialized]: 745:19 => 
  - /kisskb/src/drivers/video/fbdev/sis/init301.c: warning: 'CRT2Index' may be used uninitialized in this function [-Wuninitialized]: 6969:7 => 
  - /kisskb/src/drivers/video/fbdev/sis/init301.c: warning: 'resindex' may be used uninitialized in this function [-Wuninitialized]: 6975:68 => 
  - /kisskb/src/drivers/w1/slaves/w1_ds2438.c: warning: 'temp' may be used uninitialized in this function [-Wuninitialized]: 301:16 => 
  - /kisskb/src/drivers/watchdog/ziirave_wdt.c: warning: 'fw' may be used uninitialized in this function [-Wuninitialized]: 766:1 => 
  - /kisskb/src/fs/9p/acl.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 144:9 => 
  - /kisskb/src/fs/afs/cell.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 628:14 => 
  - /kisskb/src/fs/autofs4/waitq.c: warning: 'wq' may be used uninitialized in this function [-Wuninitialized]: 478:3, 477:5 => 
  - /kisskb/src/fs/btrfs/acl.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 49:7 => 
  - /kisskb/src/fs/btrfs/backref.c: warning: 'count' may be used uninitialized in this function [-Wuninitialized]: 806:15 => 
  - /kisskb/src/fs/btrfs/ctree.c: warning: 'pslot' may be used uninitialized in this function [-Wuninitialized]: 2183:24, 1975:24 => 
  - /kisskb/src/fs/btrfs/delayed-inode.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 442:17 => 
  - /kisskb/src/fs/btrfs/extent_io.c: warning: 'tree' may be used uninitialized in this function [-Wuninitialized]: 2650:32 => 
  - /kisskb/src/fs/btrfs/free-space-cache.c: warning: 'next_zero' may be used uninitialized in this function [-Wuninitialized]: 2863:5 => 
  - /kisskb/src/fs/btrfs/inode.c: warning: 'cur_offset' may be used uninitialized in this function [-Wuninitialized]: 1548:31 => 
  - /kisskb/src/fs/btrfs/inode.c: warning: 'disk_num_bytes' may be used uninitialized in this function [-Wuninitialized]: 1470:7 => 
  - /kisskb/src/fs/btrfs/inode.c: warning: 'extent_end' may be used uninitialized in this function [-Wuninitialized]: 1432:6 => 
  - /kisskb/src/fs/btrfs/inode.c: warning: 'extent_offset' may be used uninitialized in this function [-Wuninitialized]: 1468:8 => 
  - /kisskb/src/fs/btrfs/inode.c: warning: 'ram_bytes' may be used uninitialized in this function [-Wuninitialized]: 1470:7 => 
  - /kisskb/src/fs/btrfs/ref-verify.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 565:6, 565:3, 568:2, 516:2, 600:7 => 600:7, 516:2, 568:2, 565:6
  - /kisskb/src/fs/btrfs/send.c: warning: 'found_key.offset' may be used uninitialized in this function [-Wuninitialized]: 1790:7 => 
  - /kisskb/src/fs/btrfs/send.c: warning: 'found_key.type' may be used uninitialized in this function [-Wuninitialized]: 1767:2 => 
  - /kisskb/src/fs/btrfs/uuid-tree.c: warning: 'eb' may be used uninitialized in this function [-Wuninitialized]: 152:25 => 
  - /kisskb/src/fs/btrfs/uuid-tree.c: warning: 'offset' may be used uninitialized in this function [-Wuninitialized]: 151:21 => 
  - /kisskb/src/fs/btrfs/volumes.c: warning: 'max_chunk_size' may be used uninitialized in this function [-Wuninitialized]: 4663:19 => 
  - /kisskb/src/fs/btrfs/volumes.c: warning: 'max_stripe_size' may be used uninitialized in this function [-Wuninitialized]: 4699:29 => 
  - /kisskb/src/fs/ceph/acl.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 63:7 => 
  - /kisskb/src/fs/ceph/locks.c: warning: 'lock_type' may be used uninitialized in this function [-Wuninitialized]: 197:40 => 
  - /kisskb/src/fs/crypto/keyinfo.c: warning: 'cipher_str' may be used uninitialized in this function [-Wuninitialized]: 319:7 => 
  - /kisskb/src/fs/crypto/keyinfo.c: warning: 'keysize' may be used uninitialized in this function [-Wuninitialized]: 219:6 => 
  - /kisskb/src/fs/dcache.c: warning: 'n' may be used uninitialized in this function [-Wuninitialized]: 2418:2 => 
  - /kisskb/src/fs/ext2/acl.c: warning: 'name_index' may be used uninitialized in this function [-Wuninitialized]: 161:9 => 
  - /kisskb/src/fs/ext4/acl.c: warning: 'name_index' may be used uninitialized in this function [-Wuninitialized]: 162:9 => 
  - /kisskb/src/fs/ext4/ext4_jbd2.h: warning: control reaches end of non-void function [-Wreturn-type]: 426:1 => 
  - /kisskb/src/fs/ext4/extents.c: warning: 'abut_ex' may be used uninitialized in this function [-Wuninitialized]: 3562:21 => 
  - /kisskb/src/fs/ext4/extents.c: warning: 'len' may be used uninitialized in this function [-Wuninitialized]: 2346:2 => 
  - /kisskb/src/fs/ext4/ialloc.c: warning: 'bit' may be used uninitialized in this function [-Wuninitialized]: 1282:9 => 
  - /kisskb/src/fs/ext4/inode.c: warning: 'retval' may be used uninitialized in this function [-Wuninitialized]: 590:5 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/fs/ext4/super.c: warning: 'first_not_zeroed' may be used uninitialized in this function [-Wuninitialized]: 4279:6 => 
  - /kisskb/src/fs/f2fs/checkpoint.c: warning: 'do_checkpoint' uses dynamic stack allocation [enabled by default]: 1342:1 => 
  - /kisskb/src/fs/f2fs/checkpoint.c: warning: 'get_checkpoint_version' uses dynamic stack allocation [enabled by default]: 749:1 => 
  - /kisskb/src/fs/f2fs/gc.c: warning: 'nofs' may be used uninitialized in this function [-Wuninitialized]: 876:35 => 
  - /kisskb/src/fs/f2fs/node.c: warning: 'nat_blk' may be used uninitialized in this function [-Wuninitialized]: 2494:11 => 
  - /kisskb/src/fs/gfs2/rgrp.c: warning: 'rs' may be used uninitialized in this function [-Wuninitialized]: 1553:17 => 
  - /kisskb/src/fs/hfsplus/unicode.c: warning: 'dsize' may be used uninitialized in this function [-Wuninitialized]: 299:5 => 
  - /kisskb/src/fs/hpfs/alloc.c: warning: 'sec' may be used uninitialized in this function [-Wuninitialized]: 203:7 => 
  - /kisskb/src/fs/jffs2/acl.c: warning: 'xprefix' may be used uninitialized in this function [-Wuninitialized]: 191:5 => 
  - /kisskb/src/fs/jffs2/scan.c: warning: 'sumlen' may be used uninitialized in this function [-Wuninitialized]: 540:4 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 316:1 => 
  - /kisskb/src/fs/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u16' [-Wattributes]: 125:4, 129:4, 126:4, 127:4, 128:4 => 
  - /kisskb/src/fs/ncpfs/ncp_fs_sb.h: warning: 'packed' attribute ignored for field of type '__u32' [-Wattributes]: 124:4, 123:4 => 
  - /kisskb/src/fs/nfs/filelayout/filelayout.c: warning: control reaches end of non-void function [-Wreturn-type]: 86:1 => 
  - /kisskb/src/fs/nfs/flexfilelayout/flexfilelayoutdev.c: warning: control reaches end of non-void function [-Wreturn-type]: 484:1 => 
  - /kisskb/src/fs/notify/fanotify/fanotify.c: warning: 'marks_ignored_mask' may be used uninitialized in this function [-Wuninitialized]: 132:32 => 
  - /kisskb/src/fs/notify/fanotify/fanotify.c: warning: 'marks_mask' may be used uninitialized in this function [-Wuninitialized]: 132:30 => 
  - /kisskb/src/fs/ntfs/dir.c: warning: 'bmp_vi' may be used uninitialized in this function [-Wuninitialized]: 1430:7 => 
  - /kisskb/src/fs/ocfs2/cluster/tcp.c: warning: array subscript is above array bounds [-Warray-bounds]: 285:36 => 
  - /kisskb/src/fs/ocfs2/file.c: warning: 'had_lock' may be used uninitialized in this function [-Wuninitialized]: 1301:29 => 
  - /kisskb/src/fs/ocfs2/quota_local.c: warning: 'dchunk' may be used uninitialized in this function [-Wuninitialized]: 948:45 => 
  - /kisskb/src/fs/ocfs2/stack_o2cb.c: warning: array subscript is above array bounds [-Warray-bounds]: 161:19 => 
  - /kisskb/src/fs/ocfs2/suballoc.c: warning: 'bg_bh' may be used uninitialized in this function [-Wuninitialized]: 476:2 => 
  - /kisskb/src/fs/ocfs2/xattr.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 3004:2 => 
  - /kisskb/src/fs/posix_acl.c: warning: control reaches end of non-void function [-Wreturn-type]: 35:1 => 
  - /kisskb/src/fs/quota/kqid.c: warning: control reaches end of non-void function [-Wreturn-type]: 53:1, 27:1, 80:1, 132:1, 113:1 => 
  - /kisskb/src/fs/reiserfs/bitmap.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]: 269:9 => 
  - /kisskb/src/fs/reiserfs/prints.c: warning: 'noreturn' function does return [enabled by default]: 370:1 => 
  - /kisskb/src/fs/reiserfs/xattr_acl.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]: 209:7 => 
  - /kisskb/src/fs/udf/inode.c: warning: 'adsize' may be used uninitialized in this function [-Wuninitialized]: 641:15 => 
  - /kisskb/src/fs/udf/truncate.c: warning: 'adsize' may be used uninitialized in this function [-Wuninitialized]: 229:14, 105:16 => 
  - /kisskb/src/fs/udf/unicode.c: warning: 'conv_f' may be used uninitialized in this function [-Wuninitialized]: 375:6, 394:2 => 
  - /kisskb/src/fs/userfaultfd.c: warning: 'basic_ioctls' may be used uninitialized in this function [-Wuninitialized]: 1461:3 => 
  - /kisskb/src/fs/xfs/libxfs/xfs_alloc.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 2353:8 => 
  - /kisskb/src/fs/xfs/libxfs/xfs_bmap.c: warning: 'error' may be used uninitialized in this function [-Wuninitialized]: 5095:8 => 
  - /kisskb/src/fs/xfs/xfs_acl.c: warning: 'ea_name' may be used uninitialized in this function [-Wuninitialized]: 156:8 => 
  - /kisskb/src/fs/xfs/xfs_log_recover.c: warning: 'uuid' may be used uninitialized in this function [-Wuninitialized]: 2355:3 => 
  - /kisskb/src/fs/xfs/xfs_rtalloc.c: warning: 'nrblocks' may be used uninitialized in this function [-Wuninitialized]: 980:4 => 
  - /kisskb/src/include/linux/ceph/osdmap.h: warning: control reaches end of non-void function [-Wreturn-type]: 71:1 => 
  - /kisskb/src/include/linux/compiler.h: warning: 'counter' may be used uninitialized in this function [-Wuninitialized]: 183:2 => 
  - /kisskb/src/include/linux/compiler.h: warning: 'wait' may be used uninitialized in this function [-Wuninitialized]: 211:31 => 
  - /kisskb/src/include/linux/dmaengine.h: warning: control reaches end of non-void function [-Wreturn-type]: 1123:1 => 
  - /kisskb/src/include/linux/file.h: warning: 'output.file' may be used uninitialized in this function [-Wuninitialized]: 40:7 => 
  - /kisskb/src/include/linux/file.h: warning: 'output.flags' may be used uninitialized in this function [-Wuninitialized]: 39:2 => 
  - /kisskb/src/include/linux/hid.h: warning: 'report' may be used uninitialized in this function [-Wuninitialized]: 1007:34 => 
  - /kisskb/src/include/linux/kref.h: warning: 'entry' may be used uninitialized in this function [-Wuninitialized]: 47:14 => 
  - /kisskb/src/include/linux/list.h: warning: 'wait' may be used uninitialized in this function [-Wuninitialized]: 29:13 => 
  - /kisskb/src/include/linux/mtd/map.h: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]: 362:2, 430:2 => 
  - /kisskb/src/include/linux/page_counter.h: warning: 'counter' may be used uninitialized in this function [-Wuninitialized]: 50:21 => 
  - /kisskb/src/include/linux/percpu-refcount.h: warning: 'percpu_count' may be used uninitialized in this function [-Wuninitialized]: 214:1, 177:1, 248:1, 276:1 => 
  - /kisskb/src/include/linux/pinctrl/pinconf-generic.h: warning: 'arg' may be used uninitialized in this function [-Wuninitialized]: 154:9 => 
  - /kisskb/src/include/linux/slab.h: warning: 'n_ioc' may be used uninitialized in this function [-Wuninitialized]: 618:18 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'dst_ptl' may be used uninitialized in this function [-Wuninitialized]: 350:2 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'ptl' may be used uninitialized in this function [-Wuninitialized]: 350:2 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'ws' may be used uninitialized in this function [-Wuninitialized]: 335:2 => 
  - /kisskb/src/include/linux/sunrpc/svc_xprt.h: warning: control reaches end of non-void function [-Wreturn-type]: 180:1 => 
  - /kisskb/src/include/linux/uuid.h: warning: 'uuid' may be used uninitialized in this function [-Wuninitialized]: 60:15 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.<U6260>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]: 114:22 => 
  - /kisskb/src/include/net/dst.h: warning: 'dst' may be used uninitialized in this function [-Wuninitialized]: 227:2 => 
  - /kisskb/src/include/uapi/linux/swab.h: warning: 'buf_addr' may be used uninitialized in this function [-Wuninitialized]: 52:9 => 
  - /kisskb/src/ipc/mqueue.c: warning: 'msg_ptr' may be used uninitialized in this function [-Wuninitialized]: 1171:3 => 
  - /kisskb/src/ipc/shm.c: warning: 'file' may be used uninitialized in this function [-Wuninitialized]: 1554:3, 1555:59 => 1565:59
  - /kisskb/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wuninitialized]: 1257:9, 1268:20 => 1268:20
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 6e0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1280>]' may be used uninitialized in this function [-Wuninitialized]: 119:32, 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1d20>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2640>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2dc0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2f00>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32, 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3140>]' may be used uninitialized in this function [-Wuninitialized]: 119:32, 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U33c0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U40a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4280>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U46e0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6b40>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6c80>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8280>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8320>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8aa0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8e60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U93c0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9960>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uadc0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub3c0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uba00>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubdc0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc0a0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc6e0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc780>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udaa0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udd20>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue000>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue140>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue460>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue8c0>]' may be used uninitialized in this function [-Wuninitialized]: 119:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf8c0>]' may be used uninitialized in this function [-Wuninitialized]: 100:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufe60>]' may be used uninitialized in this function [-Wuninitialized]: 100:33, 119:32 => 
  - /kisskb/src/kernel/sched/core.c: warning: control reaches end of non-void function [-Wreturn-type]: 3246:1 => 
  - /kisskb/src/kernel/trace/trace_events.c: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]: 1053:2 => 
  - /kisskb/src/kernel/trace/trace_events.c: warning: 'last_i' may be used uninitialized in this function [-Wuninitialized]: 2240:4, 2212:6 => 
  - /kisskb/src/lib/asn1_decoder.c: warning: 'errmsg' may be used uninitialized in this function [-Wuninitialized]: 515:2 => 
  - /kisskb/src/lib/assoc_array.c: warning: 'j' may be used uninitialized in this function [-Wuninitialized]: 658:2 => 
  - /kisskb/src/lib/cpumask.c: warning: control reaches end of non-void function [-Wreturn-type]: 228:1 => 
  - /kisskb/src/lib/kobject_uevent.c: warning: 'action' may be used uninitialized in this function [-Wuninitialized]: 219:4 => 
  - /kisskb/src/lib/kobject_uevent.c: warning: 'action_args' may be used uninitialized in this function [-Wuninitialized]: 138:7 => 
  - /kisskb/src/lib/kobject_uevent.c: warning: 'env' may be used uninitialized in this function [-Wuninitialized]: 219:39 => 
  - /kisskb/src/lib/mpi/mpicoder.c: warning: 'buff' may be used uninitialized in this function [-Wuninitialized]: 377:32, 330:5, 336:12, 352:8 => 336:12, 352:8
  - /kisskb/src/lib/string.c: warning: 'noreturn' function does return [enabled by default]: 1053:1 => 
  - /kisskb/src/lib/string.c: warning: 'noreturn' function does return: 1053:1 => 
  - /kisskb/src/lib/swiotlb.c: warning: 'dev_addr' may be used uninitialized in this function [-Wuninitialized]: 766:14 => 
  - /kisskb/src/lib/test_firmware.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 781:31 => 
  - /kisskb/src/mm/bootmem.c: warning: control reaches end of non-void function [-Wreturn-type]: 386:1 => 
  - /kisskb/src/mm/huge_memory.c: warning: 'huge_gfp' may be used uninitialized in this function [-Wuninitialized]: 1318:2 => 
  - /kisskb/src/mm/ksm.c: warning: 'found_rmap_hlist_len' may be used uninitialized in this function [-Wuninitialized]: 1365:4, 1365:15 => 1358:15
  - /kisskb/src/mm/ksm.c: warning: 'stable_node' may be used uninitialized in this function [-Wuninitialized]: 1863:16 => 
  - /kisskb/src/mm/memblock.c: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 1101:15 => 
  - /kisskb/src/mm/memcontrol.c: warning: 'isolated' may be used uninitialized in this function [-Wuninitialized]: 2090:2 => 
  - /kisskb/src/mm/memcontrol.c: warning: 'thresholds' may be used uninitialized in this function [-Wuninitialized]: 3417:16, 3531:35 => 
  - /kisskb/src/mm/memcontrol.c: warning: 'usage' may be used uninitialized in this function [-Wuninitialized]: 3536:6, 3448:6 => 
  - /kisskb/src/mm/memcontrol.c: warning: control reaches end of non-void function [-Wreturn-type]: 2849:1 => 
  - /kisskb/src/mm/mmap.c: warning: 'prev' may be used uninitialized in this function [-Wuninitialized]: 600:17 => 
  - /kisskb/src/mm/mmap.c: warning: 'rb_link' may be used uninitialized in this function [-Wuninitialized]: 601:15 => 
  - /kisskb/src/mm/mmap.c: warning: 'rb_parent' may be used uninitialized in this function [-Wuninitialized]: 601:15 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.47' uses dynamic stack allocation [enabled by default]: 2151:1 => 
  - /kisskb/src/mm/slub.c: warning: 'df.cnt' may be used uninitialized in this function [-Wuninitialized]: 2960:14 => 
  - /kisskb/src/mm/slub.c: warning: 'df.freelist' may be used uninitialized in this function [-Wuninitialized]: 2950:3, 2960:14 => 
  - /kisskb/src/mm/slub.c: warning: 'df.s' may be used uninitialized in this function [-Wuninitialized]: 269:43, 2939:1 => 
  - /kisskb/src/mm/slub.c: warning: 'df.tail' may be used uninitialized in this function [-Wuninitialized]: 2968:25, 2928:26 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.49' uses dynamic stack allocation [enabled by default]: 1851:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation [enabled by default]: 2219:1 => 
  - /kisskb/src/net/ceph/messenger.c: warning: 'new_piece' may be used uninitialized in this function [-Wuninitialized]: 1211:19 => 
  - /kisskb/src/net/ceph/messenger.c: warning: 'proto' may be used uninitialized in this function [-Wuninitialized]: 1471:38 => 
  - /kisskb/src/net/core/ethtool.c: warning: control reaches end of non-void function [-Wreturn-type]: 311:1 => 
  - /kisskb/src/net/core/neighbour.c: warning: 'p_name' may be used uninitialized in this function [-Wuninitialized]: 3232:10 => 
  - /kisskb/src/net/ipv4/esp4.c: warning: 'net_adj' may be used uninitialized in this function [-Wuninitialized]: 779:31 => 
  - /kisskb/src/net/ipv4/ping.c: warning: 'code' may be used uninitialized in this function [-Wuninitialized]: 474:63, 557:37 => 
  - /kisskb/src/net/ipv4/ping.c: warning: 'family' may be used uninitialized in this function [-Wuninitialized]: 474:2 => 
  - /kisskb/src/net/ipv4/ping.c: warning: 'icmph' may be used uninitialized in this function [-Wuninitialized]: 511:35 => 
  - /kisskb/src/net/ipv4/ping.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 530:3, 514:2, 475:29 => 
  - /kisskb/src/net/mac802154/llsec.c: warning: control reaches end of non-void function [-Wreturn-type]: 653:1 => 
  - /kisskb/src/net/netfilter/ipvs/ip_vs_core.c: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1195:1 => 
  - /kisskb/src/net/netfilter/ipvs/ip_vs_core.c: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 395:1 => 
  - /kisskb/src/net/netfilter/nf_conntrack_sip.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 659:5 => 
  - /kisskb/src/net/netfilter/nft_payload.c: warning: 'offset' may be used uninitialized in this function [-Wuninitialized]: 298:9, 107:9 => 
  - /kisskb/src/net/packet/af_packet.c: warning: 'hdrlen' may be used uninitialized in this function [-Wuninitialized]: 2358:16 => 
  - /kisskb/src/net/rds/connection.c: warning: 'rds_walk_conn_path_info.isra.4.constprop.6' uses dynamic stack allocation [enabled by default]: 613:1 => 
  - /kisskb/src/net/rxrpc/call_accept.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 627:2 => 
  - /kisskb/src/net/rxrpc/local_object.c: warning: control reaches end of non-void function [-Wreturn-type]: 72:1 => 
  - /kisskb/src/net/rxrpc/peer_object.c: warning: control reaches end of non-void function [-Wreturn-type]: 113:1 => 
  - /kisskb/src/net/rxrpc/recvmsg.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 103:2 => 
  - /kisskb/src/net/sched/act_mirred.c: warning: control reaches end of non-void function [-Wreturn-type]: 51:1 => 
  - /kisskb/src/net/sunrpc/svcauth_unix.c: warning: 'sin6' may be used uninitialized in this function [-Wuninitialized]: 686:24 => 
  - /kisskb/src/net/sunrpc/svcsock.c: warning: 'level' may be used uninitialized in this function [-Wuninitialized]: 753:6 => 
  - /kisskb/src/net/sunrpc/svcsock.c: warning: 'optname' may be used uninitialized in this function [-Wuninitialized]: 753:6 => 
  - /kisskb/src/net/xfrm/xfrm_policy.c: warning: 'dst_ops' may be used uninitialized in this function [-Wuninitialized]: 1492:7 => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-iop.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/soc_camera/soc_scale_crop.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o: N/A => 
  - modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o: N/A => 
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
