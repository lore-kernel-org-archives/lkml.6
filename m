Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF873C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CEB208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CEB208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeH0Nfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:35:42 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:50368 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeH0Nfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:35:41 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id U9pR1y00c3XaVaC019pRsA; Mon, 27 Aug 2018 11:49:26 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fuE9G-0007on-6Z
        for linux-kernel@vger.kernel.org; Mon, 27 Aug 2018 11:49:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fuE9G-00042w-4w
        for linux-kernel@vger.kernel.org; Mon, 27 Aug 2018 11:49:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v4.19-rc1
Date:   Mon, 27 Aug 2018 11:49:26 +0200
Message-Id: <20180827094926.15512-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v4.19-rc1[1] compared to v4.18[2].

Summarized:
  - build errors: +5/-3
  - build warnings: +14732/-179

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5b394b2ddf0347bef56e50c69a58773c94343ff3/ (all 240 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94710cac0ef4ee177a63b5227664b38c95bbf703/ (239 out of 240 configs)


*** ERRORS ***

5 error regressions:
  + /kisskb/src/arch/nds32/include/asm/elf.h: error: expected '}' before ';' token:  => 126:29
  + error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
  + error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x0), (.fixup+0x8), (.fixup+0x10), (.fixup+0x18), (.fixup+0x20)

3 error improvements:
  - error: "__sanitizer_cov_trace_cmpd" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!: N/A => 
  - error: "__sanitizer_cov_trace_cmpf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!: N/A => 
  - error: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!: N/A => 


*** WARNINGS ***

[Deleted 14564 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on powerpc-all{mod,yes}config*]

14732 warning regressions:
  + /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'err' [-Wunused-variable]:  => 563:11
  + /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'error' [-Wunused-variable]:  => 532:6
  + /kisskb/src/arch/arc/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]:  => 95:29
  + /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined: 274:0 => 274, 274:0
  + /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined: 275:0 => 275:0, 275
  + /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 160:2
  + /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'px_is' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 160:2
  + /kisskb/src/arch/s390/mm/pgtable.c: warning: 'pmd_alloc_map' defined but not used [-Wunused-function]:  => 413:15
  + /kisskb/src/drivers/bluetooth/hci_h5.c: warning: 'rtl_vnd' defined but not used [-Wunused-variable]:  => 920:22
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'blnd_cfg.black_color') [-Wmissing-braces]:  => 1903:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1903:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c: warning: (near initialization for 'task_info.process_name') [-Wmissing-braces]:  => 1459:10
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1459:10
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c: warning: (near initialization for 'task_info.process_name') [-Wmissing-braces]:  => 262:10
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c: warning: missing braces around initializer [-Wmissing-braces]:  => 262:10
  + /kisskb/src/drivers/gpu/drm/drm_atomic.c: warning: 'crtc_state' may be used uninitialized in this function [-Wuninitialized]:  => 760:38
  + /kisskb/src/drivers/gpu/drm/drm_atomic.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 436:21
  + /kisskb/src/drivers/gpu/drm/i915/i915_irq.c: warning: 'gu_misc_iir' may be used uninitialized in this function [-Wuninitialized]:  => 3120:10
  + /kisskb/src/drivers/i2c/i2c-core-base.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 235:5
  + /kisskb/src/drivers/i2c/i2c-core-base.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 235:5
  + /kisskb/src/drivers/iio/proximity/isl29501.c: warning: 'msb' may be used uninitialized in this function [-Wuninitialized]:  => 253:7, 253:34
  + /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_lmk_one.isra.26' uses dynamic stack allocation [enabled by default]:  => 645:1
  + /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_tcw_whitening.isra.25' uses dynamic stack allocation [enabled by default]:  => 792:1
  + /kisskb/src/drivers/media/platform/qcom/camss/camss.c: warning: 'camss_runtime_resume' defined but not used [-Wunused-function]:  => 1001:12
  + /kisskb/src/drivers/media/platform/qcom/camss/camss.c: warning: 'camss_runtime_suspend' defined but not used [-Wunused-function]:  => 996:12
  + /kisskb/src/drivers/mtd/nand/raw/qcom_nandc.c: warning: "PAGE_READ" redefined:  => 154
  + /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c: warning: 'nvm_param.dir_type' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 49:5
  + /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c: warning: 'nvm_param.dir_type' may be used uninitialized in this function [-Wuninitialized]:  => 49:5
  + /kisskb/src/drivers/net/ethernet/microchip/lan743x_main.c: warning: 'lan743x_pm_resume' defined but not used [-Wunused-function]:  => 2987:12
  + /kisskb/src/drivers/net/ethernet/microchip/lan743x_main.c: warning: 'lan743x_pm_suspend' defined but not used [-Wunused-function]:  => 2964:12
  + /kisskb/src/drivers/nvme/target/discovery.c: warning: 'strncpy' output truncated copying 8 bytes from a string of length 11 [-Wstringop-truncation]:  => 160:2
  + /kisskb/src/drivers/pinctrl/cirrus/pinctrl-madera-core.c: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]:  => 660:3
  + /kisskb/src/drivers/pinctrl/cirrus/pinctrl-madera-core.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 659:5
  + /kisskb/src/drivers/s390/crypto/ap_bus.c: warning: 'process_mask_arg.constprop.6' uses dynamic stack allocation [enabled by default]:  => 1011:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation [enabled by default]:  => 311:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation [enabled by default]:  => 325:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation [enabled by default]:  => 487:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation [enabled by default]:  => 209:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation [enabled by default]:  => 276:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation [enabled by default]:  => 353:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation [enabled by default]:  => 297:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation [enabled by default]:  => 84:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_ieq' uses dynamic stack allocation [enabled by default]:  => 140:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_sba' uses dynamic stack allocation [enabled by default]:  => 111:1
  + /kisskb/src/drivers/soc/qcom/rpmh.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 355:6
  + /kisskb/src/drivers/spi/spi-sh-msiof.c: warning: "STR" redefined: 77:0 => 78, 78:0
  + /kisskb/src/drivers/usb/dwc3/dwc3-of-simple.c: warning: 'dwc3_of_simple_resume' defined but not used [-Wunused-function]:  => 223:12
  + /kisskb/src/drivers/usb/dwc3/dwc3-of-simple.c: warning: 'dwc3_of_simple_suspend' defined but not used [-Wunused-function]:  => 213:12
  + /kisskb/src/fs/gfs2/bmap.c: warning: 'height' may be used uninitialized in this function [-Wuninitialized]:  => 926:18
  + /kisskb/src/fs/gfs2/bmap.c: warning: 'len' may be used uninitialized in this function [-Wuninitialized]:  => 565:6
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1108 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 338:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 690:1
  + /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2176 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 1328:1
  + /kisskb/src/fs/ocfs2/dlmglue.c: warning: 'lockdep_keys' defined but not used [-Wunused-variable]:  => 99:30
  + /kisskb/src/include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]:  => 225:12
  + /kisskb/src/include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]:  => 225:12
  + /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]:  => 384:2
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated copying 8 bytes from a string of length 11 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1320>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U18c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33, 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33, 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4460>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4820>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U50a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5640>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5820>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U60a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6780>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U85a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9500>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9640>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9960>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua000>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua640>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua820>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub000>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub820>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uba00>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33, 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc500>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc820>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uce60>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud000>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud460>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud640>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uda00>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue820>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uea00>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf320>]' may be used uninitialized in this function [-Wuninitialized]:  => 129:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 148:32
  + /kisskb/src/kernel/sched/core.c: warning: unused variable 'steal' [-Wunused-variable]:  => 139:6
  + /kisskb/src/kernel/trace/trace_hwlat.c: warning: the frame size of 1696 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 341:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation [enabled by default]:  => 2133:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.52' uses dynamic stack allocation [enabled by default]:  => 1833:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.51' uses dynamic stack allocation [enabled by default]:  => 2201:1
  + /kisskb/src/net/core/filter.c: warning: value computed is not used [-Wunused-value]:  => 3262:4
  + /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 3148:1
  + /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 3148:1
  + /kisskb/src/net/ncsi/ncsi-manage.c: warning: 'vid' may be used uninitialized in this function [-Wuninitialized]: 625:19 => 610:5, 625:19
  + /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_decrypt_response.isra.6' uses dynamic stack allocation [enabled by default]:  => 1051:1
  + /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_encrypt_response.isra.7' uses dynamic stack allocation [enabled by default]:  => 772:1
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1480 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2840:1
  + /kisskb/src/net/sctp/sm_make_chunk.c: warning: 'sctp_pack_cookie.isra.9' uses dynamic stack allocation [enabled by default]:  => 1700:1
  + /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]:  => 268:1
  + /kisskb/src/scripts/unifdef.c: warning: 'strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]:  => 453:28
  + warning: drivers/hwmon/ibmpowernv.o(.text+0xfe8): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x10b4): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x1a54): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x1a94): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:read_id_reg():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x300c): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x3040): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:read_id_reg():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x37d8): Section mismatch in reference from the function .docg4_attach_chip() to the function .init.text:.init_mtd_structs():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0x3808): Section mismatch in reference from the function .docg4_attach_chip() to the function .init.text:.read_id_reg():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0xdbe): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs():  => N/A
  + warning: drivers/mtd/nand/raw/docg4.o(.text+0xfda): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs():  => N/A
  + warning: vmlinux.o(.text+0x226c5d0): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs():  => N/A
  + warning: vmlinux.o(.text+0x226c604): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:read_id_reg():  => N/A
  + warning: vmlinux.o(.text+0x27e84b8): Section mismatch in reference from the function .docg4_attach_chip() to the function .init.text:.init_mtd_structs():  => N/A
  + warning: vmlinux.o(.text+0x27e84e8): Section mismatch in reference from the function .docg4_attach_chip() to the function .init.text:.read_id_reg():  => N/A
  + warning: vmlinux.o(.text+0x2f3270): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x2f3ab4): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x2f9fd0): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x2fa814): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x33578): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x3670c0): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x367904): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x36b4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x37f80): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3944): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3978): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x422dac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4230a8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x42a42c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x42a728): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x49df0c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x49e208): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x4deae1c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o(.text+0x65c61): Section mismatch in reference from the function pti_clone_pgtable() to the function .init.text:pti_user_pagetable_walk_pte():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x26a8): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2718): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2820): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x293c): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A

179 warning improvements:
  - /kisskb/src/arch/s390/kernel/sysinfo.c: warning: 'sysinfo_show' defined but not used [-Wunused-function]: 275:12 => 
  - /kisskb/src/arch/sh/kernel/cpu/clock-cpg.c: warning: 'arch_init_clk_ops' is deprecated (declared at /kisskb/src/arch/sh/include/asm/clock.h:8) [-Wdeprecated-declarations]: 53:3 => 
  - /kisskb/src/arch/sh/kernel/cpu/clock-cpg.c: warning: 'cpg_clk_init' is deprecated (declared at /kisskb/src/arch/sh/kernel/cpu/clock-cpg.c:47) [-Wdeprecated-declarations]: 77:2 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh4/clock-sh4-202.c: warning: 'cpg_clk_init' is deprecated (declared at /kisskb/src/arch/sh/include/asm/clock.h:12) [-Wdeprecated-declarations]: 162:2 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh4a/clock-sh7780.c: warning: 'cpg_clk_init' is deprecated (declared at /kisskb/src/arch/sh/include/asm/clock.h:12) [-Wdeprecated-declarations]: 110:2 => 
  - /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: warning: 'struct page' declared inside parameter list: 40:37 => 
  - /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: warning: its scope is only this definition or declaration, which is probably not what you want: 40:37 => 
  - /kisskb/src/crypto/ablkcipher.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]: 448:2, 374:2 => 
  - /kisskb/src/crypto/async_tx/async_pq.c: warning: 'async_gen_syndrome' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/crypto/async_tx/async_pq.c: warning: 'async_syndrome_val' uses dynamic stack allocation [enabled by default]: 429:1 => 
  - /kisskb/src/crypto/async_tx/raid6test.c: warning: 'raid6_dual_recov.constprop.1' uses dynamic stack allocation [enabled by default]: 128:1 => 
  - /kisskb/src/crypto/blkcipher.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]: 513:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_mclk' uses dynamic stack allocation [enabled by default]: 681:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_pcie' uses dynamic stack allocation [enabled by default]: 732:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_sclk' uses dynamic stack allocation [enabled by default]: 631:1 => 
  - /kisskb/src/drivers/gpu/drm/bridge/cdns-dsi.c: warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]: 1340:12 => 
  - /kisskb/src/drivers/gpu/drm/bridge/cdns-dsi.c: warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]: 1353:12 => 
  - /kisskb/src/drivers/gpu/drm/i2c/tda9950.c: warning: 'tda9950_write_range' uses dynamic stack allocation [enabled by default]: 96:1 => 
  - /kisskb/src/drivers/gpu/drm/i2c/tda998x_drv.c: warning: 'reg_write_range' uses dynamic stack allocation [enabled by default]: 612:1 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c: warning: 'acr_r352_load' uses dynamic stack allocation [enabled by default]: 815:1 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c: warning: 'acr_r352_ls_write_wpr' uses dynamic stack allocation [enabled by default]: 451:1 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c: warning: 'acr_r367_ls_write_wpr' uses dynamic stack allocation [enabled by default]: 302:1 => 
  - /kisskb/src/drivers/infiniband/hw/ocrdma/ocrdma_hw.c: warning: 'strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Wstringop-truncation]: 1368:3 => 
  - /kisskb/src/drivers/isdn/i4l/isdn_tty.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]: 880:3, 790:3 => 
  - /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_lmk_one.isra.27' uses dynamic stack allocation [enabled by default]: 648:1 => 
  - /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_tcw_whitening.isra.26' uses dynamic stack allocation [enabled by default]: 795:1 => 
  - /kisskb/src/drivers/media/platform/omap3isp/isp.c: warning: 'isp_resume_modules' defined but not used [-Wunused-function]: 1008:13 => 
  - /kisskb/src/drivers/media/platform/omap3isp/isp.c: warning: 'isp_suspend_modules' defined but not used [-Wunused-function]: 974:12 => 
  - /kisskb/src/drivers/mtd/maps/solutionengine.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'resource_size_t' [-Wformat]: 64:9 => 
  - /kisskb/src/drivers/mtd/maps/solutionengine.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' [-Wformat]: 64:9 => 
  - /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: warning: 'stmmac_pci_resume' defined but not used [-Wunused-function]: 324:12 => 
  - /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: warning: 'stmmac_pci_suspend' defined but not used [-Wunused-function]: 306:12 => 
  - /kisskb/src/drivers/net/phy/mdio-mux-gpio.c: warning: 'mdio_mux_gpio_switch_fn' uses dynamic stack allocation [enabled by default]: 42:1 => 
  - /kisskb/src/drivers/net/ppp/ppp_mppe.c: warning: 'get_new_key_from_sha' uses dynamic stack allocation [enabled by default]: 158:1 => 
  - /kisskb/src/drivers/net/wireless/broadcom/b43/leds.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]: 134:2 => 
  - /kisskb/src/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]: 753:2 => 
  - /kisskb/src/drivers/nvmem/rave-sp-eeprom.c: warning: 'rave_sp_eeprom_io' uses dynamic stack allocation [enabled by default]: 133:1 => 
  - /kisskb/src/drivers/perf/arm_pmu_platform.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 234:5 => 
  - /kisskb/src/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]: 1923:2 => 
  - /kisskb/src/drivers/staging/speakup/kobjects.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]: 522:2, 391:2 => 
  - /kisskb/src/drivers/target/iscsi/iscsi_target_tpg.c: warning: 'strncat' specified bound 1 equals source length [-Wstringop-overflow=]: 639:3 => 
  - /kisskb/src/drivers/target/iscsi/iscsi_target_tpg.c: warning: 'strncat' specified bound 4 equals source length [-Wstringop-overflow=]: 640:3 => 
  - /kisskb/src/drivers/usb/typec/tps6598x.c: warning: 'tps6598x_block_read' uses dynamic stack allocation [enabled by default]: 102:1 => 
  - /kisskb/src/drivers/video/fbdev/amifb.c: warning: 'amifb_setup' defined but not used [-Wunused-function]: 2344:19 => 
  - /kisskb/src/fs/ceph/mds_client.c: warning: 'strncpy' output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]: 3647:2 => 
  - /kisskb/src/fs/configfs/symlink.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]: 67:3 => 
  - /kisskb/src/fs/f2fs/namei.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]: 249:3, 257:3 => 
  - /kisskb/src/fs/kernfs/symlink.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]: 91:3 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 316:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 676:1 => 
  - /kisskb/src/fs/ntfs/aops.c: warning: 'ntfs_write_mst_block' uses dynamic stack allocation [enabled by default]: 1329:1 => 
  - /kisskb/src/fs/ntfs/compress.c: warning: 'ntfs_decompress' uses dynamic stack allocation [enabled by default]: 441:1 => 
  - /kisskb/src/fs/ntfs/mft.c: warning: 'ntfs_sync_mft_mirror' uses dynamic stack allocation [enabled by default]: 637:1 => 
  - /kisskb/src/fs/ntfs/mft.c: warning: 'write_mft_record_nolock' uses dynamic stack allocation [enabled by default]: 845:1 => 
  - /kisskb/src/fs/proc/vmcore.c: warning: 'vmcoredd_mmap_dumps' defined but not used [-Wunused-function]: 228:12 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 3 has type 'ssize_t {aka int}' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/string.h: warning: '__builtin_strncat' specified bound 1 equals source length [-Wstringop-overflow=]: 313:10 => 
  - /kisskb/src/include/linux/string.h: warning: '__builtin_strncat' specified bound 4 equals source length [-Wstringop-overflow=]: 313:10 => 
  - /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 127 bytes from a string of length 127 [-Wstringop-truncation]: 246:9 => 
  - /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 16 bytes from a string of length 20 [-Wstringop-truncation]: 246:9 => 
  - /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 20 equals destination size [-Wstringop-truncation]: 246:9 => 
  - /kisskb/src/kernel/cgroup/cgroup-v1.c: warning: 'root' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1256:3 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1640>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2460>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U25a0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U26e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U31e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32, 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U48c0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4a00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4aa0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5140>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5aa0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U61e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32, 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U65a0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7460>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7dc0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U81e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]: 127:33, 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9280>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U96e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9be0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua3c0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua6e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaa00>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubaa0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33, 146:32 => 129:33
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc1e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc6e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uca00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucd20>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud0a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udb40>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue500>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf280>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/trace/trace_hwlat.c: warning: the frame size of 1672 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 343:1 => 
  - /kisskb/src/lib/bch.c: warning: 'build_deg2_base' uses dynamic stack allocation [enabled by default]: 1149:1 => 
  - /kisskb/src/lib/bch.c: warning: 'encode_bch' uses dynamic stack allocation [enabled by default]: 253:1 => 
  - /kisskb/src/lib/bch.c: warning: 'solve_linear_system.isra.15.constprop.16' uses dynamic stack allocation [enabled by default]: 502:1 => 
  - /kisskb/src/lib/kobject.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]: 128:3 => 
  - /kisskb/src/lib/lz4/lz4hc_compress.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 579:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.49' uses dynamic stack allocation [enabled by default]: 2134:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.51' uses dynamic stack allocation [enabled by default]: 1834:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.50' uses dynamic stack allocation [enabled by default]: 2202:1 => 
  - /kisskb/src/net/bluetooth/hidp/core.c: warning: 'strncpy' output may be truncated copying 127 bytes from a string of length 127 [-Wstringop-truncation]: 778:2 => 
  - /kisskb/src/net/core/flow_dissector.c: warning: 'vlan' may be used uninitialized in this function [-Wuninitialized]: 789:7 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 3102:1 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 3102:1 => 
  - /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_decrypt_response.isra.5' uses dynamic stack allocation [enabled by default]: 1048:1 => 
  - /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_encrypt_response.isra.6' uses dynamic stack allocation [enabled by default]: 769:1 => 
  - /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_secure_packet_auth.isra.7' uses dynamic stack allocation [enabled by default]: 178:1 => 
  - /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_secure_packet_encrypt.isra.8' uses dynamic stack allocation [enabled by default]: 242:1 => 
  - /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_verify_packet_1' uses dynamic stack allocation [enabled by default]: 398:1 => 
  - /kisskb/src/net/rxrpc/rxkad.c: warning: 'rxkad_verify_packet_2' uses dynamic stack allocation [enabled by default]: 498:1 => 
  - /kisskb/src/net/sctp/sm_make_chunk.c: warning: 'sctp_pack_cookie.isra.8' uses dynamic stack allocation [enabled by default]: 1700:1 => 
  - /kisskb/src/net/tls/tls_sw.c: warning: 'tls_read_size' uses dynamic stack allocation [enabled by default]: 996:1 => 
  - /kisskb/src/net/xfrm/xfrm_policy.c: warning: array subscript is above array bounds [-Warray-bounds]: 2380:15 => 
  - /kisskb/src/security/apparmor/policy_unpack.c: warning: 'pos' may be used uninitialized in this function [-Wmaybe-uninitialized]: 515:9 => 
  - /kisskb/src/sound/soc/fsl/fsl_ssi.c: warning: 'baudrate' may be used uninitialized in this function [-Wuninitialized]: 769:7 => 
  - modpost: WARNING: modpost: Found 1 section mismatch(es).: N/A => 
  - warning: "clear_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!: N/A => 
  - warning: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - warning: "clear_page" [drivers/md/raid456.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/exofs/exofs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/exofs/libore.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!: N/A => 
  - warning: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: drivers/hwmon/ibmpowernv.o(.text+0xa1c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label(): N/A => 
  - warning: unmet direct dependencies detected for PREEMPT_COUNT: N/A => 
  - warning: vmlinux.o(.text+0x35f80): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x389170): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3899b4): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x390750): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x390f94): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3aa40): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3ff120): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3ff964): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4b8b0c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4b8e08): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4c09cc): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4c0cc8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4e475d4): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label(): N/A => 
  - warning: vmlinux.o(.text+0x535dac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x5360a8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2a44): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2ab4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2bbc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2cd8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
