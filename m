Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85403C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E012070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfAHItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:49:08 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:47932 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:49:07 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id Mkox1z00o3XaVaC01koxk7; Tue, 08 Jan 2019 09:48:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggn4D-0006kJ-FO
        for linux-kernel@vger.kernel.org; Tue, 08 Jan 2019 09:48:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggn4D-0006yJ-De
        for linux-kernel@vger.kernel.org; Tue, 08 Jan 2019 09:48:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.0-rc1
Date:   Tue,  8 Jan 2019 09:48:57 +0100
Message-Id: <20190108084857.26756-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.0-rc1[1] compared to v4.20[2].

Summarized:
  - build errors: +12/-4
  - build warnings: +405/-350

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bfeffd155283772bbe78c6a05dec7c0128ee500c/ (all 240 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)


*** ERRORS ***

12 error regressions:
  + /kisskb/src/arch/mips/generic/init.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/generic/irq.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/kernel/branch.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/kernel/cmpxchg.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/kernel/cpu-probe.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/mm/cache.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/mm/extable.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/mm/fault.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + /kisskb/src/arch/mips/net/bpf_jit.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + arch/mips/vdso/vdso-image.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

4 error improvements:
  - /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3: 130:61 => 
  - /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]: 8800:3 => 
  - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5040), (.head.text+0x5100) => 
  - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 


*** WARNINGS ***

[Deleted 490 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on {mips,powerpc}-all{mod,yes}config*]

405 warning regressions:
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]:  => 182:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation [enabled by default]:  => 1075:1
  + /kisskb/src/arch/um/kernel/skas/uaccess.c: warning: unused variable 'buf' [-Wunused-variable]:  => 62:10
  + /kisskb/src/drivers/atm/ambassador.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]:  => 1762:3
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.23' uses dynamic stack allocation [enabled by default]:  => 405:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'stream_update.src') [-Wmissing-braces]:  => 4576:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]:  => 4576:9
  + /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 2962:6
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 551:41
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 1815:15
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/events.c: warning: 'error_str' may be used uninitialized in this function [-Wuninitialized]:  => 238:3
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation [enabled by default]:  => 1089:1
  + /kisskb/src/drivers/net/veth.c: warning: 'veth_get_stats64' uses dynamic stack allocation [enabled by default]:  => 364:1
  + /kisskb/src/drivers/net/wan/lmc/lmc_main.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]:  => 1874:9, 1876:5, 1852:9, 1863:5, 1877:5, 1861:9
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
  + /kisskb/src/drivers/s390/scsi/zfcp_erp.c: warning: 'erp_action' may be used uninitialized in this function [-Wuninitialized]:  => 262:2
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.32' uses dynamic stack allocation [enabled by default]:  => 501:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation [enabled by default]:  => 2846:1
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near initialization for 'cap.header') [-Wmissing-braces]:  => 181:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near initialization for 'capspd.header') [-Wmissing-braces]:  => 369:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near initialization for 'captgt.header') [-Wmissing-braces]:  => 368:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: missing braces around initializer [-Wmissing-braces]:  => 368:9, 181:9, 369:9
  + /kisskb/src/fs/cifs/cifssmb.c: warning: the frame size of 1316 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 186:1
  + /kisskb/src/fs/cifs/cifssmb.c: warning: the frame size of 1320 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 186:1
  + /kisskb/src/fs/cifs/cifssmb.c: warning: the frame size of 1328 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 186:1
  + /kisskb/src/fs/cifs/cifssmb.c: warning: the frame size of 1340 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 186:1
  + /kisskb/src/fs/cifs/cifssmb.c: warning: the frame size of 1344 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 186:1
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: the frame size of 1316 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 220:1
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: the frame size of 1320 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 220:1
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: the frame size of 1328 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 220:1
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: the frame size of 1340 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 220:1
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: the frame size of 1344 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 220:1
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]:  => 232:15
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]:  => 232:15
  + /kisskb/src/include/linux/skbuff.h: warning: 'extra_uref' may be used uninitialized in this function [-Wuninitialized]:  => 1338:6
  + /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 279:3
  + /kisskb/src/kernel/bpf/verifier.c: warning: 'prev_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 5030:4
  + /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 40:4
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 320>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1780>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U21e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U23c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U35a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U43c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U53c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6960>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U75a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U78c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7960>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34, 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8500>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9640>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua000>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua820>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uad20>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 133:34, 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub320>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub820>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub960>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uba00>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud280>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue000>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue320>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue640>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uec80>]' may be used uninitialized in this function [-Wuninitialized]:  => 152:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uee60>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 133:34
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

350 warning improvements:
  - /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'err' [-Wunused-variable]: 563:11 => 
  - /kisskb/src/arch/alpha/kernel/osf_sys.c: warning: unused variable 'error' [-Wunused-variable]: 532:6 => 
  - /kisskb/src/arch/m68k/atari/config.c: warning: variable length array 'switches' is used [-Wvla]: 151:2 => 
  - /kisskb/src/arch/m68k/kernel/signal.c: warning: variable length array 'buf' is used [-Wvla]: 654:3 => 
  - /kisskb/src/arch/m68k/mvme147/config.c: warning: #warning check me! [-Wcpp]: 150:2 => 
  - /kisskb/src/arch/m68k/mvme16x/config.c: warning: #warning check me! [-Wcpp]: 397:2 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined [enabled by default]: 274:0 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined [enabled by default]: 275:0 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 159:1 => 
  - /kisskb/src/arch/s390/kernel/nospec-branch.c: warning: statement with no effect [-Wunused-value]: 130:3 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count >= width of type [enabled by default]: 115:1, 108:1, 122:1, 334:2, 310:1, 145:2 => 310:1
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count is negative [enabled by default]: 115:1, 333:1, 81:1, 92:1, 323:2, 108:1, 122:1, 310:1, 129:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: right shift count is negative [enabled by default]: 145:2, 294:3, 310:1, 129:1, 108:1, 324:2, 122:1, 334:2, 115:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: statement with no effect [-Wunused-value]: 147:1, 296:1, 115:1, 294:1, 335:1, 122:1, 108:1, 324:1, 129:1 => 
  - /kisskb/src/drivers/block/paride/ppc6lnx.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 575:6, 217:2, 162:2, 144:2, 537:5, 147:2, 146:2, 235:4, 329:11, 430:15, 142:3, 560:4, 145:2, 201:2, 131:18, 266:4 => 
  - /kisskb/src/drivers/dma-buf/reservation.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]: 211:7 => 
  - /kisskb/src/drivers/dma-buf/reservation.c: warning: 'k' may be used uninitialized in this function [-Wuninitialized]: 208:36, 208:2, 156:1, 226:6 => 
  - /kisskb/src/drivers/gpu/drm/drm_info.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]: 118:24 => 
  - /kisskb/src/drivers/hwmon/sch56xx-common.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 145:2 => 
  - /kisskb/src/drivers/hwmon/smsc47b397.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 119:2 => 
  - /kisskb/src/drivers/iommu/io-pgtable-arm-v7s.c: warning: 'cptep' may be used uninitialized in this function [-Wuninitialized]: 438:7, 473:2 => 438:7
  - /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 5985:1 => 
  - /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2096 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 5985:1 => 
  - /kisskb/src/drivers/lightnvm/core.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 977:6 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined [enabled by default]: 42:0 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined [enabled by default]: 41:0 => 
  - /kisskb/src/drivers/misc/altera-stapl/altera-lpt.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 40:9, 34:2 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '____alloc_ei_netdev' defined but not used [-Wunused-function]: 988:27 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_close' defined but not used [-Wunused-function]: 230:12 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_get_stats' defined but not used [-Wunused-function]: 850:33 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_open' defined but not used [-Wunused-function]: 201:12 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_poll' defined but not used [-Wunused-function]: 509:13 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_set_multicast_list' defined but not used [-Wunused-function]: 950:13 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_start_xmit' defined but not used [-Wunused-function]: 300:20 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_tx_timeout' defined but not used [-Wunused-function]: 254:13 => 
  - /kisskb/src/drivers/net/ethernet/8390/wd.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 296:4, 289:4 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined [enabled by default]: 1631:0 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined [enabled by default]: 1639:0 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'pdata' [-Wunused-variable]: 1640:28 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'val' [-Wunused-variable]: 912:6 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript is above array bounds [-Warray-bounds]: 993:89 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 216:1 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'assoc_num' may be used uninitialized in this function [-Wuninitialized]: 2068:5, 1926:2, 2003:2 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'rx_sc' may be used uninitialized in this function [-Wuninitialized]: 1926:2 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'secy' may be used uninitialized in this function [-Wuninitialized]: 2069:21 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'tx_sc' may be used uninitialized in this function [-Wuninitialized]: 2003:2, 2068:24 => 
  - /kisskb/src/drivers/net/tun.c: warning: 'linear' may be used uninitialized in this function [-Wuninitialized]: 1733:46, 1513:31, 1513:34 => 1533:34, 1753:46
  - /kisskb/src/drivers/net/usb/rtl8150.c: warning: "RSR" redefined: 30:0 => 
  - /kisskb/src/drivers/net/wireless/quantenna/qtnfmac/commands.c: warning: 'resp' may be used uninitialized in this function [-Wmaybe-uninitialized]: 133:54 => 
  - /kisskb/src/drivers/net/wireless/quantenna/qtnfmac/commands.c: warning: 'resp' may be used uninitialized in this function [-Wuninitialized]: 133:38 => 
  - /kisskb/src/drivers/nvme/host/lightnvm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 580:6 => 
  - /kisskb/src/drivers/scsi/esas2r/esas2r_ioctl.c: warning: 'dma_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1910:19 => 
  - /kisskb/src/drivers/scsi/imm.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 467:2, 305:3, 465:2, 461:2, 494:2, 341:15, 463:2, 247:2, 473:2, 303:3, 486:2, 563:2, 470:2 => 
  - /kisskb/src/drivers/scsi/ppa.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 436:2, 245:3, 379:2, 399:2, 439:2, 257:15 => 
  - /kisskb/src/drivers/scsi/sym53c8xx_2/sym_defs.h: warning: "WSR" redefined: 109:0 => 
  - /kisskb/src/drivers/spi/spi-sh-msiof.c: warning: "STR" redefined [enabled by default]: 74:0 => 
  - /kisskb/src/drivers/tty/rocket_int.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 68:9, 73:9, 46:2, 54:2 => 
  - /kisskb/src/fs/btrfs/qgroup.c: warning: array subscript is below array bounds [-Warray-bounds]: 1710:17, 1709:18 => 
  - /kisskb/src/fs/nfs/nfs3acl.c: warning: value computed is not used [-Wunused-value]: 44:2 => 
  - /kisskb/src/fs/posix_acl.c: warning: value computed is not used [-Wunused-value]: 147:3 => 
  - /kisskb/src/fs/reiserfs/stree.c: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 812:1 => 
  - /kisskb/src/include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]: 225:12 => 
  - /kisskb/src/include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]: 225:12 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/include/net/sock.h: warning: 'sk' may be used uninitialized in this function [-Wuninitialized]: 1928:19 => 
  - /kisskb/src/kernel/acct.c: warning: value computed is not used [-Wunused-value]: 177:2 => 
  - /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 47:5 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 1e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1320>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1a00>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1e60>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2e60>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U31e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]: 152:32, 133:33 => 152:32
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3b40>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U41e0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4820>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U50a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5dc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U61e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6f00>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7aa0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7d20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8460>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub640>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uda00>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue3c0>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue780>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue960>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ued20>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf000>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf0a0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf1e0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf280>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]: 152:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufdc0>]' may be used uninitialized in this function [-Wuninitialized]: 133:33 => 
  - /kisskb/src/lib/test_kasan.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 504:1 => 
  - /kisskb/src/mm/memcontrol.c: warning: value computed is not used [-Wunused-value]: 1047:5 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.37' uses dynamic stack allocation [enabled by default]: 2170:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.39' uses dynamic stack allocation [enabled by default]: 1870:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.38' uses dynamic stack allocation [enabled by default]: 2238:1 => 
  - /kisskb/src/net/core/filter.c: warning: value computed is not used [-Wunused-value]: 3304:4 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 3224:1 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 3224:1 => 
  - /kisskb/src/net/ncsi/ncsi-manage.c: warning: 'vid' may be used uninitialized in this function [-Wuninitialized]: 626:5, 641:19 => 676:19
  - /kisskb/src/sound/pci/hda/patch_ca0132.c: warning: assignment makes pointer from integer without a cast [enabled by default]: 8800:18 => 
  - /kisskb/src/sound/soc/codecs/wm9712.c: warning: 'regmap' may be used uninitialized in this function [-Wuninitialized]: 666:31 => 
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
