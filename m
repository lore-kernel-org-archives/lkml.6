Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0417DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9520821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBKKdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:33:16 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:32932 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:33:12 -0500
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id bNZ11z00l3XaVaC06NZ13e; Mon, 11 Feb 2019 11:33:02 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gt8tZ-0007H4-NZ
        for linux-kernel@vger.kernel.org; Mon, 11 Feb 2019 11:33:01 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gt8tZ-0000Pu-Kg
        for linux-kernel@vger.kernel.org; Mon, 11 Feb 2019 11:33:01 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.0-rc6
Date:   Mon, 11 Feb 2019 11:33:01 +0100
Message-Id: <20190211103301.1558-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.0-rc6[1] compared to v4.20[2].

Summarized:
  - build errors: +2/-5
  - build warnings: +106/-14838

JFYI, when comparing v5.0-rc6[1] to v5.0-rc5[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +57/-59

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d13937116f1e82bf508a6325111b322c30c85eb9/ (238 out of 240 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/ (238 out of 240 configs)


*** ERRORS ***

2 error regressions:
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

5 error improvements:
  - /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3: 130:61 => 
  - /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]: 8800:3 => 
  - /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iounmap' [-Werror=implicit-function-declaration]: 8417:3 => 
  - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5040), (.head.text+0x5100) => 
  - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 


*** WARNINGS ***

[Deleted 14735 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on {mips,powerpc}-all{mod,yes}config*]

106 warning regressions:
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]:  => 182:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation [enabled by default]:  => 1075:1
  + /kisskb/src/arch/um/kernel/skas/uaccess.c: warning: unused variable 'buf' [-Wunused-variable]:  => 62:10
  + /kisskb/src/drivers/atm/ambassador.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]:  => 1762:3
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.23' uses dynamic stack allocation [enabled by default]:  => 405:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'stream_update.src') [-Wmissing-braces]:  => 4590:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]:  => 4590:9
  + /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 2962:6
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 551:41
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 1815:15
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/events.c: warning: 'error_str' may be used uninitialized in this function [-Wuninitialized]:  => 238:3
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation [enabled by default]:  => 1089:1
  + /kisskb/src/drivers/net/veth.c: warning: 'veth_get_stats64' uses dynamic stack allocation [enabled by default]:  => 364:1
  + /kisskb/src/drivers/net/wan/lmc/lmc_main.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]:  => 1874:9, 1877:5, 1876:5, 1852:9, 1861:9, 1863:5
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation [enabled by default]:  => 310:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation [enabled by default]:  => 324:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation [enabled by default]:  => 486:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation [enabled by default]:  => 209:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation [enabled by default]:  => 275:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation [enabled by default]:  => 352:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation [enabled by default]:  => 296:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation [enabled by default]:  => 84:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_ieq' uses dynamic stack allocation [enabled by default]:  => 140:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_sba' uses dynamic stack allocation [enabled by default]:  => 111:1
  + /kisskb/src/drivers/s390/scsi/zfcp_erp.c: warning: 'erp_action' may be used uninitialized in this function [-Wuninitialized]:  => 262:2
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.32' uses dynamic stack allocation [enabled by default]:  => 501:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation [enabled by default]:  => 2846:1
  + /kisskb/src/fs/buffer.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 233:10
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]:  => 232:15
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]:  => 232:15
  + /kisskb/src/include/linux/skbuff.h: warning: 'extra_uref' may be used uninitialized in this function [-Wuninitialized]:  => 1338:6
  + /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 279:3
  + /kisskb/src/kernel/bpf/verifier.c: warning: 'prev_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 5065:4
  + /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 40:4
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 960>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U11e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2000>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2500>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U35a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4460>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4780>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6960>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U76e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U93c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9640>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua280>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua460>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua500>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uac80>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc820>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34, 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud500>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue500>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf780>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufe60>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32, 133:34
  + /kisskb/src/kernel/trace/trace_dynevent.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 89:5
  + /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_out_of_bounds' uses dynamic stack allocation [enabled by default]:  => 67:1
  + /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_vla_bound_not_positive' uses dynamic stack allocation [enabled by default]:  => 51:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation [enabled by default]:  => 2167:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.52' uses dynamic stack allocation [enabled by default]:  => 1874:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.51' uses dynamic stack allocation [enabled by default]:  => 2235:1
  + /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]:  => 232:1
  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]:  => 1908:1
  + /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]:  => 268:1
  + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS:  => N/A
  + warning: vmlinux.o(.text+0x32fb0): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x35d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x37b14): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3cd5b0): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3cdc18): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3d4cb0): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3d5318): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x44b190): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x44b7f8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A

14838 warning improvements:
  - /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'err' [-Wunused-variable]: 563:11 => 
  - /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'error' [-Wunused-variable]: 532:6 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/s390/kernel/nospec-branch.c: warning: statement with no effect [-Wunused-value]: 130:3 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count >= width of type [enabled by default]: 310:1, 145:2, 334:2, 108:1, 115:1, 122:1 => 310:1
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count is negative [enabled by default]: 129:1, 81:1, 108:1, 323:2, 310:1, 92:1, 122:1, 115:1, 333:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: right shift count is negative [enabled by default]: 294:3, 145:2, 310:1, 122:1, 115:1, 324:2, 334:2, 129:1, 108:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: statement with no effect [-Wunused-value]: 147:1, 122:1, 115:1, 335:1, 296:1, 324:1, 108:1, 294:1, 129:1 => 
  - /kisskb/src/drivers/dma-buf/reservation.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]: 211:7 => 
  - /kisskb/src/drivers/dma-buf/reservation.c: warning: 'k' may be used uninitialized in this function [-Wuninitialized]: 156:1, 226:6, 208:2, 208:36 => 
  - /kisskb/src/drivers/gpu/drm/drm_info.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]: 118:24 => 
  - /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 5985:1 => 
  - /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2096 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 5985:1 => 
  - /kisskb/src/drivers/lightnvm/core.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 977:6 => 
  - /kisskb/src/drivers/net/usb/rtl8150.c: warning: "RSR" redefined: 30:0 => 
  - /kisskb/src/drivers/net/wireless/quantenna/qtnfmac/commands.c: warning: 'resp' may be used uninitialized in this function [-Wmaybe-uninitialized]: 133:54 => 
  - /kisskb/src/drivers/net/wireless/quantenna/qtnfmac/commands.c: warning: 'resp' may be used uninitialized in this function [-Wuninitialized]: 133:38 => 
  - /kisskb/src/drivers/nvme/host/lightnvm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 580:6 => 
  - /kisskb/src/drivers/scsi/esas2r/esas2r_ioctl.c: warning: 'dma_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1910:19 => 
  - /kisskb/src/drivers/scsi/sym53c8xx_2/sym_defs.h: warning: "WSR" redefined: 109:0 => 
  - /kisskb/src/fs/buffer.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 235:37 => 
  - /kisskb/src/include/linux/kernel.h: warning: comparison of distinct pointer types lacks a cast [enabled by default]: 845:29 => 
  - /kisskb/src/include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]: 225:12 => 
  - /kisskb/src/include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]: 225:12 => 
  - /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 47:5 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 1e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1a00>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1e60>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2e60>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3b40>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U41e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4820>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U50a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5dc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U60a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U61e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6280>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U95a0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U96e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9960>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9dc0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua320>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue3c0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue780>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue960>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ued20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uedc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf0a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf1e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufdc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/lib/test_kasan.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 504:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.37' uses dynamic stack allocation [enabled by default]: 2170:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.39' uses dynamic stack allocation [enabled by default]: 1870:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.38' uses dynamic stack allocation [enabled by default]: 2238:1 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 3224:1 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 3224:1 => 
  - /kisskb/src/sound/pci/hda/patch_ca0132.c: warning: assignment makes pointer from integer without a cast [enabled by default]: 8800:18 => 
  - /kisskb/src/sound/soc/codecs/wm9712.c: warning: 'regmap' may be used uninitialized in this function [-Wuninitialized]: 666:31 => 
  - drivers/staging/mt7621-dts/Kconfig: warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type: 4 => 
  - warning: There are too many unreachable loose objects; run 'git prune' to remove them.: N/A => 
  - warning: vmlinux.o(.text+0x2f160c): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x2f1de4): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x2f86ac): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x2f8e84): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x335f0): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x35c4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x36c93c): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x36d114): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x37ee4): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x42402c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x424318): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x42b78c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x42ba78): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4a66ac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4a6998): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
