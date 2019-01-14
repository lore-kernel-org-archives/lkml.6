Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9748C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FF32063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfANMRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:17:15 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:48770 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:17:15 -0500
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id QCH51z00W3XaVaC06CH5KY; Mon, 14 Jan 2019 13:17:05 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj1At-0007x3-HC
        for linux-kernel@vger.kernel.org; Mon, 14 Jan 2019 13:17:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj1At-0006MY-Fm
        for linux-kernel@vger.kernel.org; Mon, 14 Jan 2019 13:17:03 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.0-rc2
Date:   Mon, 14 Jan 2019 13:17:03 +0100
Message-Id: <20190114121703.24210-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.0-rc2[1] compared to v4.20[2].

Summarized:
  - build errors: +3/-4
  - build warnings: +369/-301

JFYI, when comparing v5.0-rc2[1] to v5.0-rc1[3], the summaries are:
  - build errors: +0/-9
  - build warnings: +168/-153

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8/ (239 out of 240 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bfeffd155283772bbe78c6a05dec7c0128ee500c/ (all 240 configs)


*** ERRORS ***

3 error regressions:
  + /kisskb/src/arch/mips/generic/init.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

4 error improvements:
  - /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3: 130:61 => 
  - /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]: 8800:3 => 
  - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5040), (.head.text+0x5100) => 
  - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 


*** WARNINGS ***

[Deleted 454 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on {mips,powerpc}-all{mod,yes}config*]

369 warning regressions:
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]:  => 182:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation [enabled by default]:  => 1075:1
  + /kisskb/src/arch/um/kernel/skas/uaccess.c: warning: unused variable 'buf' [-Wunused-variable]:  => 62:10
  + /kisskb/src/drivers/atm/ambassador.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]:  => 1762:3
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.23' uses dynamic stack allocation [enabled by default]:  => 405:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'stream_update.src') [-Wmissing-braces]:  => 4589:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]:  => 4589:9
  + /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 2962:6
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 551:41
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 1815:15
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/events.c: warning: 'error_str' may be used uninitialized in this function [-Wuninitialized]:  => 238:3
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation [enabled by default]:  => 1089:1
  + /kisskb/src/drivers/net/veth.c: warning: 'veth_get_stats64' uses dynamic stack allocation [enabled by default]:  => 364:1
  + /kisskb/src/drivers/net/wan/lmc/lmc_main.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]:  => 1874:9, 1852:9, 1876:5, 1861:9, 1863:5, 1877:5
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
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near initialization for 'cap.header') [-Wmissing-braces]:  => 181:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near initialization for 'capspd.header') [-Wmissing-braces]:  => 369:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near initialization for 'captgt.header') [-Wmissing-braces]:  => 368:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: missing braces around initializer [-Wmissing-braces]:  => 368:9, 181:9, 369:9
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]:  => 232:15
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]:  => 232:15
  + /kisskb/src/include/linux/skbuff.h: warning: 'extra_uref' may be used uninitialized in this function [-Wuninitialized]:  => 1338:6
  + /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 279:3
  + /kisskb/src/kernel/bpf/verifier.c: warning: 'prev_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 5030:4
  + /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 40:4
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 780>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 820>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 960>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U10a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2960>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34, 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U33c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U40a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U43c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34, 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U45a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6640>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U71e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8320>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9000>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U93c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32, 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U98c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34, 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua280>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uad20>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub500>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc640>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud780>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue320>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue820>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/trace/trace_dynevent.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 89:5
  + /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_out_of_bounds' uses dynamic stack allocation [enabled by default]:  => 67:1
  + /kisskb/src/lib/test_ubsan.c: warning: 'test_ubsan_vla_bound_not_positive' uses dynamic stack allocation [enabled by default]:  => 51:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation [enabled by default]:  => 2167:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.52' uses dynamic stack allocation [enabled by default]:  => 1874:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.51' uses dynamic stack allocation [enabled by default]:  => 2235:1
  + /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]:  => 232:1
  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]:  => 1906:1
  + /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]:  => 268:1
  + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS:  => N/A
  + warning: vmlinux.o(.text+0x2fad00): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x2fb358): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x301d20): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x302378): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x35d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3776c0): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x377d18): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A

301 warning improvements:
  - /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'err' [-Wunused-variable]: 563:11 => 
  - /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'error' [-Wunused-variable]: 532:6 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined [enabled by default]: 274:0 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined [enabled by default]: 275:0 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/s390/kernel/nospec-branch.c: warning: statement with no effect [-Wunused-value]: 130:3 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count >= width of type [enabled by default]: 334:2, 122:1, 145:2, 310:1, 115:1, 108:1 => 310:1
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count is negative [enabled by default]: 129:1, 323:2, 92:1, 333:1, 108:1, 115:1, 310:1, 122:1, 81:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: right shift count is negative [enabled by default]: 324:2, 294:3, 129:1, 122:1, 334:2, 145:2, 310:1, 115:1, 108:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: statement with no effect [-Wunused-value]: 129:1, 296:1, 294:1, 324:1, 108:1, 335:1, 147:1, 122:1, 115:1 => 
  - /kisskb/src/drivers/dma-buf/reservation.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]: 211:7 => 
  - /kisskb/src/drivers/dma-buf/reservation.c: warning: 'k' may be used uninitialized in this function [-Wuninitialized]: 208:36, 208:2, 226:6, 156:1 => 
  - /kisskb/src/drivers/gpu/drm/drm_info.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]: 118:24 => 
  - /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 5985:1 => 
  - /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2096 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 5985:1 => 
  - /kisskb/src/drivers/lightnvm/core.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 977:6 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined [enabled by default]: 1631:0 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined [enabled by default]: 1639:0 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 216:1 => 
  - /kisskb/src/drivers/net/usb/rtl8150.c: warning: "RSR" redefined: 30:0 => 
  - /kisskb/src/drivers/net/wireless/quantenna/qtnfmac/commands.c: warning: 'resp' may be used uninitialized in this function [-Wmaybe-uninitialized]: 133:54 => 
  - /kisskb/src/drivers/net/wireless/quantenna/qtnfmac/commands.c: warning: 'resp' may be used uninitialized in this function [-Wuninitialized]: 133:38 => 
  - /kisskb/src/drivers/nvme/host/lightnvm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 580:6 => 
  - /kisskb/src/drivers/scsi/esas2r/esas2r_ioctl.c: warning: 'dma_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1910:19 => 
  - /kisskb/src/drivers/scsi/sym53c8xx_2/sym_defs.h: warning: "WSR" redefined: 109:0 => 
  - /kisskb/src/drivers/spi/spi-sh-msiof.c: warning: "STR" redefined [enabled by default]: 74:0 => 
  - /kisskb/src/fs/gfs2/bmap.c: warning: 'height' may be used uninitialized in this function [-Wuninitialized]: 921:18 => 
  - /kisskb/src/fs/gfs2/bmap.c: warning: 'len' may be used uninitialized in this function [-Wuninitialized]: 565:6 => 
  - /kisskb/src/include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]: 225:12 => 
  - /kisskb/src/include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]: 225:12 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 47:5 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 1e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1320>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1a00>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1e60>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2e60>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]: 133:33, 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3960>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3b40>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U95a0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9dc0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uda00>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue780>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue960>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ued20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uedc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf0a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf1e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf280>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
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
