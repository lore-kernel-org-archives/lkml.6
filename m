Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D359C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE1325651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE1325651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeFYJDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:03:33 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:36860 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbeFYJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:03:31 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 2x3V1y00N3XaVaC06x3VFU; Mon, 25 Jun 2018 11:03:29 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fXNPF-00032Z-A2
        for linux-kernel@vger.kernel.org; Mon, 25 Jun 2018 11:03:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fXNPF-0002qT-8h
        for linux-kernel@vger.kernel.org; Mon, 25 Jun 2018 11:03:29 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v4.18-rc2
Date:   Mon, 25 Jun 2018 11:03:29 +0200
Message-Id: <20180625090329.10895-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v4.18-rc2[1] compared to v4.17[2].

Summarized:
  - build errors: +13/-1
  - build warnings: +2226/-1738

JFYI, when comparing v4.18-rc2[1] to v4.18-rc1[3], the summaries are:
  - build errors: +6/-4
  - build warnings: +879/-1071

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/head/7daf201d7fe8334e2d2364d4e8ed3394ec9af819/ (231 out of 244 configs)
[2] http://kisskb.ellerman.id.au/kisskb/head/29dcea88779c856c7dc92040a0c01233263101d4/ (all 244 configs)
[3] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689aedb85d56ab40/ (233 out of 244 configs)


*** ERRORS ***

13 error regressions:
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1 of 'rseq_handle_notify_resume' from incompatible pointer type [-Werror=incompatible-pointer-types]:  => 873:29
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1 of 'rseq_handle_notify_resume' from incompatible pointer type [-Werror]:  => 873:3
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1 of 'rseq_signal_deliver' from incompatible pointer type [-Werror=incompatible-pointer-types]:  => 804:22
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1 of 'rseq_signal_deliver' from incompatible pointer type [-Werror]:  => 804:2
  + /kisskb/src/arch/mips/kernel/signal.c: error: too few arguments to function 'rseq_handle_notify_resume':  => 873:3
  + /kisskb/src/arch/mips/kernel/signal.c: error: too few arguments to function 'rseq_signal_deliver':  => 804:2
  + /kisskb/src/drivers/ata/pata_ali.c: error: implicit declaration of function 'pci_domain_nr' [-Werror=implicit-function-declaration]:  => 469:38
  + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
  + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
  + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
  + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
  + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
  + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A

1 error improvements:
  - /kisskb/src/include/linux/thread_info.h: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small: 134:19 => 


*** WARNINGS ***

[Deleted 1635 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
[Deleted 2030 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

2226 warning regressions:
  + /kisskb/src/arch/parisc/kernel/pci-dma.c: warning: 'proc_pcxl_dma_show' defined but not used [-Wunused-function]:  => 335:12
  + /kisskb/src/arch/s390/kernel/sysinfo.c: warning: 'sysinfo_show' defined but not used [-Wunused-function]:  => 275:12
  + /kisskb/src/arch/xtensa/kernel/pci.c: warning: 'pci_ctrl_tail' defined but not used [-Wunused-variable]:  => 45:32
  + /kisskb/src/crypto/async_tx/raid6test.c: warning: 'raid6_dual_recov.constprop.1' uses dynamic stack allocation [enabled by default]:  => 128:1
  + /kisskb/src/drivers/firmware/google/coreboot_table.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 102:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 2021:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: warning: the frame size of 1044 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 2731:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_mclk' uses dynamic stack allocation [enabled by default]:  => 681:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_pcie' uses dynamic stack allocation [enabled by default]:  => 732:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_sclk' uses dynamic stack allocation [enabled by default]:  => 631:1
  + /kisskb/src/drivers/gpu/drm/bridge/cdns-dsi.c: warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]:  => 1340:12
  + /kisskb/src/drivers/gpu/drm/bridge/cdns-dsi.c: warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]:  => 1353:12
  + /kisskb/src/drivers/gpu/drm/i2c/tda9950.c: warning: 'tda9950_write_range' uses dynamic stack allocation [enabled by default]:  => 96:1
  + /kisskb/src/drivers/infiniband/hw/cxgb4/device.c: warning: 'prev_time' may be used uninitialized in this function [-Wuninitialized]:  => 152:14
  + /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_lmk_one.isra.27' uses dynamic stack allocation [enabled by default]:  => 648:1
  + /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_tcw_whitening.isra.26' uses dynamic stack allocation [enabled by default]:  => 795:1
  + /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined [enabled by default]:  => 42:0
  + /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined [enabled by default]:  => 41:0
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '____alloc_ei_netdev' defined but not used [-Wunused-function]:  => 988:27
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_close' defined but not used [-Wunused-function]:  => 230:12
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_get_stats' defined but not used [-Wunused-function]:  => 850:33
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_open' defined but not used [-Wunused-function]:  => 201:12
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_poll' defined but not used [-Wunused-function]:  => 509:13
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_set_multicast_list' defined but not used [-Wunused-function]:  => 950:13
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_start_xmit' defined but not used [-Wunused-function]:  => 300:20
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_tx_timeout' defined but not used [-Wunused-function]:  => 254:13
  + /kisskb/src/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c: warning: 'clearval' may be used uninitialized in this function [-Wuninitialized]:  => 2608:26
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 543:41
  + /kisskb/src/drivers/nvmem/rave-sp-eeprom.c: warning: 'rave_sp_eeprom_io' uses dynamic stack allocation [enabled by default]:  => 133:1
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.32' uses dynamic stack allocation [enabled by default]:  => 501:1
  + /kisskb/src/drivers/usb/dwc3/dwc3-qcom.c: warning: 'dwc3_qcom_resume' defined but not used [-Wunused-function]:  => 243:12
  + /kisskb/src/drivers/usb/dwc3/dwc3-qcom.c: warning: 'dwc3_qcom_suspend' defined but not used [-Wunused-function]:  => 222:12
  + /kisskb/src/fs/proc/vmcore.c: warning: 'vmcoredd_mmap_dumps' defined but not used [-Wunused-function]:  => 228:12
  + /kisskb/src/include/linux/overflow.h: warning: comparison of distinct pointer types lacks a cast:  => 53:15, 54:15
  + /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.<Ue098>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]:  => 132:22
  + /kisskb/src/include/net/sock.h: warning: 'sk' may be used uninitialized in this function [-Wuninitialized]:  => 1863:19
  + /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 46:26
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 820>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U26e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U41e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4780>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4960>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5140>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6460>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7460>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U86e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uad20>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub820>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc6e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uea00>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 3099:1
  + /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 3099:1
  + /kisskb/src/net/ncsi/ncsi-manage.c: warning: 'vid' may be used uninitialized in this function [-Wuninitialized]:  => 625:19
  + <stdin>: warning: #warning syscall io_pgetevents not implemented [-Wcpp]:  => 1332:2
  + <stdin>: warning: #warning syscall rseq not implemented [-Wcpp]:  => 1335:2
  + warning: drivers/hwmon/ibmpowernv.o(.text+0xa1c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + warning: vmlinux.o(.text+0x388158): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x388994): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x38f758): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x38ff94): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3fe0e8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3fe924): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4b796c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4b7c68): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x4bf84c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4bfb48): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x4e44634): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o(.text+0x534bec): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x534ee8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2a44): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2ab4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2bbc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cd8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A

1738 warning improvements:
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined [enabled by default]: 274:0 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined [enabled by default]: 275:0 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]: 13:2 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'clearval' may be used uninitialized in this function [-Wuninitialized]: 34:2 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 13:2 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 13:2 => 
  - /kisskb/src/arch/powerpc/boot/mpc8xx.c: warning: variable 'div' set but not used [-Wunused-but-set-variable]: 27:26 => 
  - /kisskb/src/arch/s390/kernel/early.c: warning: 'memmove_early' defined but not used [-Wunused-function]: 313:20 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: statement with no effect [-Wunused-value]/kisskb/src/arch/sh/kernel/cpu/clock-cpg.c: In function 'arch_clk_init':: 108:1 => 
  - /kisskb/src/arch/x86/net/bpf_jit_comp.c: warning: 'reload_skb_data' may be used uninitialized in this function [-Wuninitialized]: 913:8 => 
  - /kisskb/src/crypto/async_tx/raid6test.c: warning: 'raid6_dual_recov.constprop.0' uses dynamic stack allocation [enabled by default]: 128:1 => 
  - /kisskb/src/crypto/cfb.c: warning: 'crypto_cfb_decrypt_inplace' uses dynamic stack allocation [enabled by default]: 179:1 => 
  - /kisskb/src/crypto/cfb.c: warning: 'crypto_cfb_encrypt_inplace' uses dynamic stack allocation [enabled by default]: 110:1 => 
  - /kisskb/src/crypto/cfb.c: warning: 'crypto_cfb_final' uses dynamic stack allocation [enabled by default]: 67:1 => 
  - /kisskb/src/crypto/cipher.c: warning: 'cipher_crypt_unaligned' uses dynamic stack allocation [enabled by default]: 76:1 => 
  - /kisskb/src/crypto/ctr.c: warning: 'crypto_ctr_crypt_final' uses dynamic stack allocation [enabled by default]: 71:1 => 
  - /kisskb/src/crypto/ctr.c: warning: 'crypto_ctr_crypt_inplace' uses dynamic stack allocation [enabled by default]: 124:1 => 
  - /kisskb/src/crypto/cts.c: warning: 'cts_cbc_decrypt' uses dynamic stack allocation [enabled by default]: 221:1 => 
  - /kisskb/src/crypto/cts.c: warning: 'cts_cbc_encrypt' uses dynamic stack allocation [enabled by default]: 129:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'apply_z' uses dynamic stack allocation [enabled by default]: 720:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'ecc_gen_privkey' uses dynamic stack allocation [enabled by default]: 984:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'ecc_make_pub_key' uses dynamic stack allocation [enabled by default]: 1020:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'ecc_point_double_jacobian' uses dynamic stack allocation [enabled by default]: 708:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'ecc_point_mult.isra.0' uses dynamic stack allocation [enabled by default]: 896:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'vli_mmod_fast' uses dynamic stack allocation [enabled by default]: 533:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'vli_mod_inv' uses dynamic stack allocation [enabled by default]: 632:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'vli_mod_mult_fast' uses dynamic stack allocation [enabled by default]: 543:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'vli_mod_square_fast' uses dynamic stack allocation [enabled by default]: 553:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'xycz_add' uses dynamic stack allocation [enabled by default]: 784:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'xycz_add_c' uses dynamic stack allocation [enabled by default]: 841:1 => 
  - /kisskb/src/crypto/ecc.c: warning: 'xycz_initial_double' uses dynamic stack allocation [enabled by default]: 743:1 => 
  - /kisskb/src/crypto/pcbc.c: warning: 'crypto_pcbc_decrypt_inplace.isra.2' uses dynamic stack allocation [enabled by default]: 161:1 => 
  - /kisskb/src/crypto/pcbc.c: warning: 'crypto_pcbc_encrypt_inplace.isra.3' uses dynamic stack allocation [enabled by default]: 89:1 => 
  - /kisskb/src/crypto/tcrypt.c: warning: 'do_mult_acipher_op' uses dynamic stack allocation [enabled by default]: 1144:1 => 
  - /kisskb/src/crypto/tcrypt.c: warning: 'do_mult_aead_op' uses dynamic stack allocation [enabled by default]: 184:1 => 
  - /kisskb/src/crypto/tcrypt.c: warning: 'test_mb_ahash_cycles' uses dynamic stack allocation [enabled by default]: 782:1 => 
  - /kisskb/src/crypto/tcrypt.c: warning: 'test_mb_ahash_jiffies' uses dynamic stack allocation [enabled by default]: 746:1 => 
  - /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: 'safexcel_cipher_exit_inv' uses dynamic stack allocation [enabled by default]: 470:1 => 
  - /kisskb/src/drivers/crypto/inside-secure/safexcel_hash.c: warning: 'safexcel_ahash_exit_inv' uses dynamic stack allocation [enabled by default]: 516:1 => 
  - /kisskb/src/drivers/dma/dmatest.c: warning: 'dmatest_func' uses dynamic stack allocation [enabled by default]: 811:1 => 
  - /kisskb/src/drivers/gpio/gpio-stmpe.c: warning: 'stmpe_gpio_irq' uses dynamic stack allocation [enabled by default]: 428:1 => 
  - /kisskb/src/drivers/gpio/gpiolib.c: warning: 'gpiod_get_array_value_complex' uses dynamic stack allocation [enabled by default]: 2757:1 => 
  - /kisskb/src/drivers/gpio/gpiolib.c: warning: 'gpiod_set_array_value_complex' uses dynamic stack allocation [enabled by default]: 2986:1 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c: warning: 'acr_ls_msgqueue_post_run' uses dynamic stack allocation [enabled by default]: 100:1 => 
  - /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_lmk_one.isra.29' uses dynamic stack allocation [enabled by default]: 648:1 => 
  - /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_tcw_whitening.isra.28' uses dynamic stack allocation [enabled by default]: 795:1 => 
  - /kisskb/src/drivers/mfd/arizona-core.c: warning: 'n_subdevs' may be used uninitialized in this function [-Wuninitialized]: 1387:6 => 
  - /kisskb/src/drivers/mfd/rave-sp.c: warning: 'rave_sp_receive_frame' uses dynamic stack allocation [enabled by default]: 440:1 => 
  - /kisskb/src/drivers/misc/tifm_7xx1.c: warning: 'tifm_7xx1_resume' uses dynamic stack allocation [enabled by default]: 298:1 => 
  - /kisskb/src/drivers/mmc/core/pwrseq_simple.c: warning: 'mmc_pwrseq_simple_set_gpios_value.isra.9' uses dynamic stack allocation [enabled by default]: 52:1 => 
  - /kisskb/src/drivers/mtd/inftlmount.c: warning: 'check_free_sectors.isra.0.constprop.1' uses dynamic stack allocation [enabled by default]: 359:1 => 
  - /kisskb/src/drivers/mtd/nftlmount.c: warning: 'check_free_sectors.isra.2' uses dynamic stack allocation [enabled by default]: 297:1 => 
  - /kisskb/src/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: warning: value computed is not used [-Wunused-value]: 9972:4 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mvpp2.c: warning: overflow in implicit constant conversion [-Woverflow]: 4366:41 => 
  - /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'stmmac_dma_interrupt' uses dynamic stack allocation [enabled by default]: 2117:1 => 
  - /kisskb/src/drivers/scsi/dpt_i2o.c: warning: 'adpt_i2o_passthru' uses dynamic stack allocation [enabled by default]: 1893:1 => 
  - /kisskb/src/drivers/scsi/osd/osd_initiator.c: warning: 'osd_req_decode_sense_full' uses dynamic stack allocation [enabled by default]: 1955:1 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd.c: warning: 'ufs_get_device_desc' uses dynamic stack allocation [enabled by default]: 6093:1 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd.c: warning: 'ufshcd_init_icc_levels' uses dynamic stack allocation [enabled by default]: 5986:1 => 
  - /kisskb/src/drivers/spi/spi-sh-msiof.c: warning: "STR" redefined [enabled by default]: 77:0 => 
  - /kisskb/src/drivers/staging/comedi/drivers/pcl818.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]: 337:6 => 
  - /kisskb/src/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: warning: 'vchiq_dump_service_use_state' uses dynamic stack allocation [enabled by default]: 3498:1 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.31' uses dynamic stack allocation [enabled by default]: 501:1 => 
  - /kisskb/src/drivers/tty/serial/sunzilog.c: warning: 'sunzilog_putchar' defined but not used [-Wunused-function]: 1132:13 => 
  - /kisskb/src/fs/btrfs/raid56.c: warning: 'finish_parity_scrub' uses dynamic stack allocation [enabled by default]: 2513:1 => 
  - /kisskb/src/fs/btrfs/raid56.c: warning: 'finish_rmw' uses dynamic stack allocation [enabled by default]: 1339:1 => 
  - /kisskb/src/fs/ocfs2/namei.c: warning: 'ocfs2_orphan_del' uses dynamic stack allocation [enabled by default]: 2400:1 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%d' expects argument of type 'int', but argument 4 has type 'tcflag_t {aka long unsigned int}' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%d' expects argument of type 'int', but argument 5 has type 'tcflag_t {aka long unsigned int}' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/string.h: warning: array subscript is above array bounds [-Warray-bounds]: 266:29 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.<U b48>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]: 132:22 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.xfer_func' may be used uninitialized in this function [-Wuninitialized]: 134:22 => 
  - /kisskb/src/include/uapi/linux/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]: 52:9 => 
  - /kisskb/src/include/uapi/linux/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 52:9 => 
  - /kisskb/src/include/uapi/linux/swab.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 52:9 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 280>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 6e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 780>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1780>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1dc0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33, 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2000>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U20a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U21e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2f00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3780>]' may be used uninitialized in this function [-Wuninitialized]: 146:32, 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3960>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3f00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U46e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5460>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6320>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6640>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7140>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9280>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua320>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub960>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ube60>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc780>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc8c0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucc80>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uce60>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucf00>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud5a0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud6e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue640>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue780>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uedc0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uee60>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf5a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/lib/reed_solomon/reed_solomon.c: warning: 'decode_rs16' uses dynamic stack allocation [enabled by default]: 373:1 => 
  - /kisskb/src/lib/reed_solomon/reed_solomon.c: warning: 'decode_rs8' uses dynamic stack allocation [enabled by default]: 329:1 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: 'rtnl_newlink' uses dynamic stack allocation [enabled by default]: 3083:1 => 
  - /kisskb/src/net/ipv6/xfrm6_state.c: warning: '__xfrm6_sort' uses dynamic stack allocation [enabled by default]: 84:1 => 
  - /kisskb/src/net/netfilter/nfnetlink.c: warning: 'nfnetlink_rcv_batch' uses dynamic stack allocation [enabled by default]: 452:1 => 
  - /kisskb/src/net/netfilter/nfnetlink.c: warning: 'nfnetlink_rcv_msg' uses dynamic stack allocation [enabled by default]: 223:1 => 
  - /kisskb/src/net/openvswitch/actions.c: warning: 'ovs_fragment' uses dynamic stack allocation [enabled by default]: 943:1 => 
  - /kisskb/src/security/keys/big_key.c: warning: 'big_key_crypt' uses dynamic stack allocation [enabled by default]: 136:1 => 
  - /kisskb/src/security/keys/dh.c: warning: 'kdf_ctr' uses dynamic stack allocation [enabled by default]: 211:1 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_ARP: 214 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_BRIDGE: 269 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_INET: 108 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_NETDEV: 109 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_ARP: 200 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_BRIDGE: 255 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_INET: 94 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_NETDEV: 95 => 
  - warning: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: drivers/hwmon/ibmpowernv.o(.text+0xa3c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label(): N/A => 
  - warning: vmlinux.o(.text+0x35cc4c): Section mismatch in reference from the function devm_memremap_pages() to the function .meminit.text:arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x35d528): Section mismatch in reference from the function devm_memremap_pages_release() to the function .meminit.text:arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x35e90): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x377538): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x377d84): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x37f098): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x37f8e4): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3a950): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3eab28): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3eb374): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x49a5dc): Section mismatch in reference from the function hmm_devmem_release() to the function .meminit.text:arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x49a950): Section mismatch in reference from the function hmm_devmem_pages_create() to the function .meminit.text:arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4a708c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4a73a8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4aefac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4af2c8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x4caf898): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label(): N/A => 
  - warning: vmlinux.o(.text+0x52196c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x521c88): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x25e0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2650): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2834): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x293c): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
