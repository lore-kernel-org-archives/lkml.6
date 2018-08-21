Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9AEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508D021531
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508D021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeHULVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:21:06 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:47310 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeHULVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:21:05 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id Rk1k1y0083XaVaC01k1kYu; Tue, 21 Aug 2018 10:01:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fs1bk-0007C1-2E
        for linux-kernel@vger.kernel.org; Tue, 21 Aug 2018 10:01:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fs1bk-0003QD-00
        for linux-kernel@vger.kernel.org; Tue, 21 Aug 2018 10:01:44 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v4.18
Date:   Tue, 21 Aug 2018 10:01:43 +0200
Message-Id: <20180821080143.13111-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v4.18[1] compared to v4.17[2].

Summarized:
  - build errors: +3/-1
  - build warnings: +258/-46409

JFYI, when comparing v4.18[1] to v4.18-rc8[3], the summaries are:
  - build errors: +2/-0
  - build warnings: +105/-71

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94710cac0ef4ee177a63b5227664b38c95bbf703/ (239 out of 244 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/29dcea88779c856c7dc92040a0c01233263101d4/ (all 244 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1ffaddd029c867d134a1dde39f540dcc8c52e274/ (233 out of 244 configs)


*** ERRORS ***

3 error regressions:
  + error: "__sanitizer_cov_trace_cmpd" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!:  => N/A
  + error: "__sanitizer_cov_trace_cmpf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!:  => N/A
  + error: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!:  => N/A

1 error improvements:
  - /kisskb/src/include/linux/thread_info.h: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small: 134:19 => 


*** WARNINGS ***

[Deleted 26903 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
[Deleted 19308 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

258 warning regressions:
  + /kisskb/src/arch/parisc/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]:  => 48:3
  + /kisskb/src/arch/parisc/kernel/pci-dma.c: warning: 'proc_pcxl_dma_show' defined but not used [-Wunused-function]:  => 335:12
  + /kisskb/src/arch/s390/kernel/sysinfo.c: warning: 'sysinfo_show' defined but not used [-Wunused-function]:  => 275:12
  + /kisskb/src/arch/xtensa/kernel/pci.c: warning: 'pci_ctrl_tail' defined but not used [-Wunused-variable]:  => 45:32
  + /kisskb/src/crypto/ablkcipher.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]:  => 448:2, 374:2
  + /kisskb/src/crypto/async_tx/raid6test.c: warning: 'raid6_dual_recov.constprop.1' uses dynamic stack allocation [enabled by default]:  => 128:1
  + /kisskb/src/crypto/blkcipher.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]:  => 513:2
  + /kisskb/src/drivers/auxdisplay/panel.c: warning: 'strncpy' output may be truncated copying 8 bytes from a string of length 8 [-Wstringop-truncation]:  => 1506:2, 1507:2, 1505:2
  + /kisskb/src/drivers/devfreq/devfreq.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 593:2
  + /kisskb/src/drivers/firmware/google/coreboot_table.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 102:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'strncpy' output may be truncated copying 19 bytes from a string of length 19 [-Wstringop-truncation]:  => 2291:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 3381:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 2021:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: warning: the frame size of 1044 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 2731:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_mclk' uses dynamic stack allocation [enabled by default]:  => 681:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_pcie' uses dynamic stack allocation [enabled by default]:  => 732:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'amdgpu_set_pp_dpm_sclk' uses dynamic stack allocation [enabled by default]:  => 631:1
  + /kisskb/src/drivers/gpu/drm/bridge/cdns-dsi.c: warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]:  => 1340:12
  + /kisskb/src/drivers/gpu/drm/bridge/cdns-dsi.c: warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]:  => 1353:12
  + /kisskb/src/drivers/gpu/drm/i2c/tda9950.c: warning: 'tda9950_write_range' uses dynamic stack allocation [enabled by default]:  => 96:1
  + /kisskb/src/drivers/gpu/drm/msm/msm_fence.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 34:2
  + /kisskb/src/drivers/gpu/drm/nouveau/nvif/client.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 72:2
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c: warning: overflow in conversion from 'int' to '__s8' {aka 'signed char'} changes value from '-251' to '5' [-Woverflow]:  => 60:21
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 192:2
  + /kisskb/src/drivers/gpu/drm/panel/panel-arm-versatile.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 267:2
  + /kisskb/src/drivers/infiniband/hw/cxgb4/device.c: warning: 'prev_time' may be used uninitialized in this function [-Wuninitialized]:  => 152:14
  + /kisskb/src/drivers/infiniband/hw/ocrdma/ocrdma_hw.c: warning: 'strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Wstringop-truncation]:  => 1368:3
  + /kisskb/src/drivers/isdn/capi/capidrv.c: warning: 'strncpy' output may be truncated copying 19 bytes from a string of length 19 [-Wstringop-truncation]:  => 2302:2
  + /kisskb/src/drivers/isdn/capi/capidrv.c: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 49 [-Wstringop-truncation]:  => 1827:3, 2016:3
  + /kisskb/src/drivers/isdn/hardware/eicon/message.c: warning: the frame size of 2096 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 5985:1
  + /kisskb/src/drivers/isdn/i4l/isdn_net.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 2997:2
  + /kisskb/src/drivers/isdn/i4l/isdn_tty.c: warning: 'strncpy' output may be truncated copying 5 bytes from a string of length 49 [-Wstringop-truncation]:  => 2054:4
  + /kisskb/src/drivers/isdn/i4l/isdn_tty.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 880:3, 790:3
  + /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_lmk_one.isra.27' uses dynamic stack allocation [enabled by default]:  => 648:1
  + /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_tcw_whitening.isra.26' uses dynamic stack allocation [enabled by default]:  => 795:1
  + /kisskb/src/drivers/md/dm-log-userspace-base.c: warning: 'strncpy' specified bound 129 equals destination size [-Wstringop-truncation]:  => 226:2
  + /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined [enabled by default]:  => 42:0
  + /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined [enabled by default]:  => 41:0
  + /kisskb/src/drivers/media/platform/omap3isp/isp.c: warning: 'isp_resume_modules' defined but not used [-Wunused-function]:  => 1008:13
  + /kisskb/src/drivers/media/platform/omap3isp/isp.c: warning: 'isp_suspend_modules' defined but not used [-Wunused-function]:  => 974:12
  + /kisskb/src/drivers/misc/c2port/core.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 929:2
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '____alloc_ei_netdev' defined but not used [-Wunused-function]:  => 988:27
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_close' defined but not used [-Wunused-function]:  => 230:12
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_get_stats' defined but not used [-Wunused-function]:  => 850:33
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_open' defined but not used [-Wunused-function]:  => 201:12
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_poll' defined but not used [-Wunused-function]:  => 509:13
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_set_multicast_list' defined but not used [-Wunused-function]:  => 950:13
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_start_xmit' defined but not used [-Wunused-function]:  => 300:20
  + /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_tx_timeout' defined but not used [-Wunused-function]:  => 254:13
  + /kisskb/src/drivers/net/ethernet/intel/i40e/i40e_ptp.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 697:2
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 543:41
  + /kisskb/src/drivers/net/ethernet/marvell/sky2.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 4928:3
  + /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: warning: 'stmmac_pci_resume' defined but not used [-Wunused-function]:  => 324:12
  + /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: warning: 'stmmac_pci_suspend' defined but not used [-Wunused-function]:  => 306:12
  + /kisskb/src/drivers/net/hamradio/hdlcdrv.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 614:4
  + /kisskb/src/drivers/net/phy/dp83640_reg.h: warning: "PAGE0" redefined:  => 8
  + /kisskb/src/drivers/net/wireless/broadcom/b43/leds.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 134:2
  + /kisskb/src/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: warning: 'strncpy' output truncated before terminating nul copying 3 bytes from a string of the same length [-Wstringop-truncation]:  => 4167:2
  + /kisskb/src/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]:  => 753:2
  + /kisskb/src/drivers/net/wireless/intersil/hostap/hostap_ioctl.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 3611:3
  + /kisskb/src/drivers/net/wireless/intersil/prism54/isl_ioctl.c: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 28 [-Wstringop-truncation]:  => 284:2
  + /kisskb/src/drivers/net/wireless/ray_cs.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 638:3
  + /kisskb/src/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c: warning: 'strncpy' specified bound 22 equals destination size [-Wstringop-truncation]:  => 149:2
  + /kisskb/src/drivers/nvme/host/core.c: warning: 'strncpy' output may be truncated copying 223 bytes from a string of length 255 [-Wstringop-truncation]:  => 2061:3
  + /kisskb/src/drivers/nvmem/rave-sp-eeprom.c: warning: 'rave_sp_eeprom_io' uses dynamic stack allocation [enabled by default]:  => 133:1
  + /kisskb/src/drivers/power/supply/charger-manager.c: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]:  => 488:3
  + /kisskb/src/drivers/rpmsg/qcom_glink_native.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 1404:3, 1454:3
  + /kisskb/src/drivers/rpmsg/qcom_smd.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 1068:2, 1296:3
  + /kisskb/src/drivers/scsi/3w-sas.c: warning: 'strncpy' output truncated before terminating nul copying 11 bytes from a string of the same length [-Wstringop-truncation]:  => 1328:3
  + /kisskb/src/drivers/scsi/arcmsr/arcmsr_hba.c: warning: 'strncpy' output truncated before terminating nul copying 16 bytes from a string of the same length [-Wstringop-truncation]:  => 2971:3
  + /kisskb/src/drivers/scsi/arcmsr/arcmsr_hba.c: warning: 'strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]:  => 2973:3
  + /kisskb/src/drivers/scsi/arcmsr/arcmsr_hba.c: warning: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Wstringop-truncation]:  => 2969:3
  + /kisskb/src/drivers/scsi/esas2r/esas2r_ioctl.c: warning: 'dma_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1910:19
  + /kisskb/src/drivers/scsi/ips.c: warning: 'strncpy' output may be truncated copying 4 bytes from a string of length 7 [-Wstringop-truncation]:  => 5627:2
  + /kisskb/src/drivers/scsi/ips.c: warning: 'strncpy' output truncated before terminating nul copying 16 bytes from a string of the same length [-Wstringop-truncation]:  => 4040:2, 3520:6
  + /kisskb/src/drivers/scsi/ips.c: warning: 'strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]:  => 4041:2, 5626:2, 5625:2, 3522:6
  + /kisskb/src/drivers/scsi/ips.c: warning: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Wstringop-truncation]:  => 2243:2, 3518:6, 4039:2
  + /kisskb/src/drivers/scsi/ips.c: warning: 'strncpy' specified bound 4 equals destination size [-Wstringop-truncation]:  => 5628:2
  + /kisskb/src/drivers/scsi/pm8001/pm8001_sas.c: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]:  => 886:2
  + /kisskb/src/drivers/scsi/qla2xxx/qla_mr.c: warning: 'strncpy' output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]:  => 1882:4, 1888:4, 1890:4, 1892:4, 1886:4
  + /kisskb/src/drivers/staging/fbtft/fbtft-core.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 774:2
  + /kisskb/src/drivers/staging/ks7010/ks_wlan_net.c: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 32 [-Wstringop-truncation]:  => 385:2
  + /kisskb/src/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 1923:2
  + /kisskb/src/drivers/staging/rtl8192e/rtllib_softmac.c: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]:  => 1694:5, 1687:5
  + /kisskb/src/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c: warning: 'strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]:  => 1463:6, 1468:5
  + /kisskb/src/drivers/staging/rtl8712/rtl871x_ioctl_linux.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 1792:2
  + /kisskb/src/drivers/staging/rts5208/rtsx_scsi.c: warning: 'strncpy' output truncated copying 28 bytes from a string of length 29 [-Wstringop-truncation]:  => 539:3
  + /kisskb/src/drivers/staging/rts5208/rtsx_scsi.c: warning: 'strncpy' output truncated copying between 1 and 27 bytes from a string of length 29 [-Wstringop-truncation]:  => 539:3
  + /kisskb/src/drivers/staging/speakup/kobjects.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 391:2, 522:2
  + /kisskb/src/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c: warning: 'strncpy' specified bound 128 equals destination size [-Wstringop-truncation]:  => 916:2
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.32' uses dynamic stack allocation [enabled by default]:  => 501:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target_tpg.c: warning: 'strncat' specified bound 1 equals source length [-Wstringop-overflow=]:  => 639:3
  + /kisskb/src/drivers/target/iscsi/iscsi_target_tpg.c: warning: 'strncat' specified bound 4 equals source length [-Wstringop-overflow=]:  => 640:3
  + /kisskb/src/drivers/video/fbdev/uvesafb.c: warning: 'strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]:  => 425:2
  + /kisskb/src/drivers/video/fbdev/uvesafb.c: warning: 'strncpy' specified bound 4096 equals destination size [-Wstringop-truncation]:  => 1873:2
  + /kisskb/src/drivers/video/hdmi.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 175:2
  + /kisskb/src/drivers/video/hdmi.c: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]:  => 174:2
  + /kisskb/src/fs/ceph/mds_client.c: warning: 'strncpy' output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]:  => 3647:2
  + /kisskb/src/fs/cifs/cifsencrypt.c: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 306:3
  + /kisskb/src/fs/configfs/symlink.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 67:3
  + /kisskb/src/fs/ext4/super.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 330:3, 326:2
  + /kisskb/src/fs/f2fs/namei.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 257:3, 249:3
  + /kisskb/src/fs/hfsplus/xattr.c: warning: 'strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]:  => 416:3
  + /kisskb/src/fs/kernfs/symlink.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 91:3
  + /kisskb/src/fs/proc/vmcore.c: warning: 'vmcoredd_mmap_dumps' defined but not used [-Wunused-function]:  => 228:12
  + /kisskb/src/fs/xfs/xfs_xattr.c: warning: 'strncpy' output may be truncated copying between 5 and 9 bytes from a string of length 9 [-Wstringop-truncation]:  => 142:2
  + /kisskb/src/include/linux/overflow.h: warning: comparison of distinct pointer types lacks a cast:  => 53:15, 54:15
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncat' specified bound 1 equals source length [-Wstringop-overflow=]:  => 313:10
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncat' specified bound 4 equals source length [-Wstringop-overflow=]:  => 313:10
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 127 bytes from a string of length 127 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 16 bytes from a string of length 20 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 16 bytes from a string of length 28 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 16 bytes from a string of length 32 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 19 bytes from a string of length 19 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 223 bytes from a string of length 255 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 64 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 32 bytes from a string of length 32 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 32 bytes from a string of length 49 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 4 bytes from a string of length 7 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 5 bytes from a string of length 49 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output may be truncated copying 64 bytes from a string of length 79 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated before terminating nul copying 11 bytes from a string of the same length [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated before terminating nul copying 16 bytes from a string of the same length [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated copying 28 bytes from a string of length 29 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' output truncated copying between 1 and 27 bytes from a string of length 29 [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 1024 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 128 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 129 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 16 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 20 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 200 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 22 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 256 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 4 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 4096 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 64 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound 8 equals destination size [-Wstringop-truncation]:  => 246:9
  + /kisskb/src/include/linux/string.h: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-overflow=]:  => 246:9
  + /kisskb/src/include/net/sock.h: warning: 'sk' may be used uninitialized in this function [-Wuninitialized]:  => 1863:19
  + /kisskb/src/include/scsi/fc_encode.h: warning: 'strncpy' output may be truncated copying 64 bytes from a string of length 79 [-Wstringop-truncation]:  => 275:3, 287:3
  + /kisskb/src/include/trace/events/wbt.h: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 141:3, 106:3, 36:3, 70:3
  + /kisskb/src/include/trace/events/writeback.h: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 99:3, 223:3, 69:3, 660:3, 277:3, 586:3, 179:3, 375:3, 324:3, 299:3
  + /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 46:26
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1640>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2460>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U25a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U26e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U31e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U48c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U61e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32, 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U65a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7460>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U81e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8820>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U95a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33, 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc960>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uca00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue500>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf280>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 146:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]:  => 127:33
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_ip_fixup' uses dynamic stack allocation [enabled by default]:  => 249:1
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation [enabled by default]:  => 301:1
  + /kisskb/src/lib/kobject.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 128:3
  + /kisskb/src/lib/test_hexdump.c: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]:  => 84:3
  + /kisskb/src/lib/test_hexdump.c: warning: 'strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Wstringop-truncation]:  => 98:3
  + /kisskb/src/lib/ubsan.c: warning: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Wattributes]:  => 432:1
  + /kisskb/src/lib/xxhash.c: warning: the frame size of 1624 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 236:1
  + /kisskb/src/net/bluetooth/hidp/core.c: warning: 'strncpy' output may be truncated copying 127 bytes from a string of length 127 [-Wstringop-truncation]:  => 778:2
  + /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 3102:1
  + /kisskb/src/net/core/rtnetlink.c: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 3102:1
  + /kisskb/src/net/ncsi/ncsi-manage.c: warning: 'vid' may be used uninitialized in this function [-Wuninitialized]:  => 625:19
  + /kisskb/src/net/netfilter/ipset/ip_set_core.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 1170:2
  + /kisskb/src/net/tipc/bearer.c: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]:  => 141:2
  + /kisskb/src/net/tipc/topsrv.c: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-overflow=]:  => 660:2
  + /kisskb/src/security/selinux/hooks.c: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]:  => 6718:2
  + <stdin>: warning: #warning syscall io_pgetevents not implemented [-Wcpp]:  => 1332:2
  + <stdin>: warning: #warning syscall rseq not implemented [-Wcpp]:  => 1335:2
  + warning: "clear_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!:  => N/A
  + warning: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + warning: "clear_page" [drivers/md/raid456.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/exofs/exofs.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/exofs/libore.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/fuse/fuse.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!:  => N/A
  + warning: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!:  => N/A
  + warning: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!:  => N/A
  + warning: "copy_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!:  => N/A
  + warning: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!:  => N/A
  + warning: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!:  => N/A
  + warning: "copy_page" [fs/fuse/fuse.ko] has no CRC!:  => N/A
  + warning: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!:  => N/A
  + warning: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + warning: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + warning: drivers/hwmon/ibmpowernv.o(.text+0xa1c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + warning: vmlinux.o(.text+0x35f80): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x389170): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3899b4): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x390750): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x390f94): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x3aa40): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3ff120): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x3ff964): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4b8b0c): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4b8e08): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x4c09cc): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x4c0cc8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text+0x4e475d4): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
  + warning: vmlinux.o(.text+0x535dac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
  + warning: vmlinux.o(.text+0x5360a8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2a44): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2ab4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2bbc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cd8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A

46409 warning improvements:
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'b' may be used uninitialized in this function [-Wuninitialized]: 13:2 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'clearval' may be used uninitialized in this function [-Wuninitialized]: 34:2 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 13:2 => 
  - /kisskb/src/arch/parisc/include/uapi/asm/swab.h: warning: 'r' may be used uninitialized in this function [-Wuninitialized]: 13:2 => 
  - /kisskb/src/arch/powerpc/boot/mpc8xx.c: warning: variable 'div' set but not used [-Wunused-but-set-variable]: 27:26 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]: 160:2 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'px_is' may be used uninitialized in this function [-Wmaybe-uninitialized]: 160:2 => 
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
  - /kisskb/src/drivers/char/tpm/tpm2-cmd.c: warning: 'blob_handle' may be used uninitialized in this function [-Wuninitialized]: 730:24 => 
  - /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: 'safexcel_cipher_exit_inv' uses dynamic stack allocation [enabled by default]: 470:1 => 
  - /kisskb/src/drivers/crypto/inside-secure/safexcel_hash.c: warning: 'safexcel_ahash_exit_inv' uses dynamic stack allocation [enabled by default]: 516:1 => 
  - /kisskb/src/drivers/dma/dmatest.c: warning: 'dmatest_func' uses dynamic stack allocation [enabled by default]: 811:1 => 
  - /kisskb/src/drivers/gpio/gpio-stmpe.c: warning: 'stmpe_gpio_irq' uses dynamic stack allocation [enabled by default]: 428:1 => 
  - /kisskb/src/drivers/gpio/gpiolib.c: warning: 'gpiod_get_array_value_complex' uses dynamic stack allocation [enabled by default]: 2757:1 => 
  - /kisskb/src/drivers/gpio/gpiolib.c: warning: 'gpiod_set_array_value_complex' uses dynamic stack allocation [enabled by default]: 2986:1 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c: warning: overflow in implicit constant conversion [-Woverflow]: 60:3 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c: warning: 'acr_ls_msgqueue_post_run' uses dynamic stack allocation [enabled by default]: 100:1 => 
  - /kisskb/src/drivers/iio/temperature/mlx90632.c: warning: 'object_new_raw' may be used uninitialized in this function [-Wuninitialized]: 472:39 => 
  - /kisskb/src/drivers/iio/temperature/mlx90632.c: warning: 'object_old_raw' may be used uninitialized in this function [-Wuninitialized]: 472:39 => 
  - /kisskb/src/drivers/input/rmi4/rmi_f11.c: warning: 'abs_fingers' may be used uninitialized in this function [-Wuninitialized]: 631:3 => 
  - /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_lmk_one.isra.29' uses dynamic stack allocation [enabled by default]: 648:1 => 
  - /kisskb/src/drivers/md/dm-crypt.c: warning: 'crypt_iv_tcw_whitening.isra.28' uses dynamic stack allocation [enabled by default]: 795:1 => 
  - /kisskb/src/drivers/mfd/arizona-core.c: warning: 'n_subdevs' may be used uninitialized in this function [-Wuninitialized]: 1387:6 => 
  - /kisskb/src/drivers/mfd/rave-sp.c: warning: 'rave_sp_receive_frame' uses dynamic stack allocation [enabled by default]: 440:1 => 
  - /kisskb/src/drivers/misc/tifm_7xx1.c: warning: 'tifm_7xx1_resume' uses dynamic stack allocation [enabled by default]: 298:1 => 
  - /kisskb/src/drivers/mmc/core/pwrseq_simple.c: warning: 'mmc_pwrseq_simple_set_gpios_value.isra.9' uses dynamic stack allocation [enabled by default]: 52:1 => 
  - /kisskb/src/drivers/mtd/inftlmount.c: warning: 'check_free_sectors.isra.0.constprop.1' uses dynamic stack allocation [enabled by default]: 359:1 => 
  - /kisskb/src/drivers/mtd/nftlmount.c: warning: 'check_free_sectors.isra.2' uses dynamic stack allocation [enabled by default]: 297:1 => 
  - /kisskb/src/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: warning: value computed is not used [-Wunused-value]: 9972:4 => 
  - /kisskb/src/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: warning: value computed is not used [-Wunused-value]: 4446:4 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mvpp2.c: warning: overflow in implicit constant conversion [-Woverflow]: 4366:41 => 
  - /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'stmmac_dma_interrupt' uses dynamic stack allocation [enabled by default]: 2117:1 => 
  - /kisskb/src/drivers/net/gtp.c: warning: 'pktinfo.dev' may be used uninitialized in this function [-Wuninitialized]: 585:3 => 
  - /kisskb/src/drivers/net/gtp.c: warning: 'pktinfo.fl4.daddr' may be used uninitialized in this function [-Wuninitialized]: 587:22 => 
  - /kisskb/src/drivers/net/gtp.c: warning: 'pktinfo.fl4.saddr' may be used uninitialized in this function [-Wuninitialized]: 587:22 => 
  - /kisskb/src/drivers/net/gtp.c: warning: 'pktinfo.gtph_port' may be used uninitialized in this function [-Wuninitialized]: 587:22 => 
  - /kisskb/src/drivers/net/gtp.c: warning: 'pktinfo.iph' may be used uninitialized in this function [-Wuninitialized]: 589:20 => 
  - /kisskb/src/drivers/net/gtp.c: warning: 'pktinfo.sk' may be used uninitialized in this function [-Wuninitialized]: 587:22 => 
  - /kisskb/src/drivers/net/phy/dp83640_reg.h: warning: "PAGE0" redefined [enabled by default]: 8:0 => 
  - /kisskb/src/drivers/net/wireless/intersil/p54/eeprom.c: warning: assuming signed overflow does not occur when assuming that (X - c) <= X is always true [-Wstrict-overflow]: 462:4, 460:4, 461:4, 463:4 => 
  - /kisskb/src/drivers/scsi/bfa/bfa_fcs_lport.c: warning: the frame size of 1712 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2160:1 => 
  - /kisskb/src/drivers/scsi/dpt_i2o.c: warning: 'adpt_i2o_passthru' uses dynamic stack allocation [enabled by default]: 1893:1 => 
  - /kisskb/src/drivers/scsi/osd/osd_initiator.c: warning: 'osd_req_decode_sense_full' uses dynamic stack allocation [enabled by default]: 1955:1 => 
  - /kisskb/src/drivers/scsi/scsi_debug.c: warning: value computed is not used [-Wunused-value]: 1622:2 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd.c: warning: 'ufs_get_device_desc' uses dynamic stack allocation [enabled by default]: 6093:1 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd.c: warning: 'ufshcd_init_icc_levels' uses dynamic stack allocation [enabled by default]: 5986:1 => 
  - /kisskb/src/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: warning: 'vchiq_dump_service_use_state' uses dynamic stack allocation [enabled by default]: 3498:1 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.31' uses dynamic stack allocation [enabled by default]: 501:1 => 
  - /kisskb/src/drivers/usb/host/xhci-tegra.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 552:6 => 
  - /kisskb/src/fs/btrfs/raid56.c: warning: 'finish_parity_scrub' uses dynamic stack allocation [enabled by default]: 2513:1 => 
  - /kisskb/src/fs/btrfs/raid56.c: warning: 'finish_rmw' uses dynamic stack allocation [enabled by default]: 1339:1 => 
  - /kisskb/src/fs/btrfs/ref-verify.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 503:2, 552:6, 592:7, 555:2 => 555:2, 503:2
  - /kisskb/src/fs/ocfs2/namei.c: warning: 'ocfs2_orphan_del' uses dynamic stack allocation [enabled by default]: 2400:1 => 
  - /kisskb/src/include/linux/string.h: warning: array subscript is above array bounds [-Warray-bounds]: 266:29 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.<U b48>.ycbcr_enc' may be used uninitialized in this function [-Wuninitialized]: 132:22 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.colorspace' may be used uninitialized in this function [-Wuninitialized]: 131:23 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.field' may be used uninitialized in this function [-Wuninitialized]: 130:18 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.quantization' may be used uninitialized in this function [-Wuninitialized]: 133:25 => 
  - /kisskb/src/include/media/v4l2-mediabus.h: warning: 'pix.xfer_func' may be used uninitialized in this function [-Wuninitialized]: 134:22 => 
  - /kisskb/src/include/net/netlink.h: warning: assuming signed overflow does not occur when assuming that (X - c) > X is always false [-Wstrict-overflow]: 717:38 => 
  - /kisskb/src/include/net/route.h: warning: 'pktinfo.rt' may be used uninitialized in this function [-Wuninitialized]: 343:31 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1dc0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32, 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U20a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U21e0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2960>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2be0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2f00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3780>]' may be used uninitialized in this function [-Wuninitialized]: 146:32, 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3960>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3f00>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U46e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5460>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6320>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6640>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U66e0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6a00>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U70a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U85a0>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua320>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub000>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
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
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue820>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueaa0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uedc0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uee60>]' may be used uninitialized in this function [-Wuninitialized]: 146:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf5a0>]' may be used uninitialized in this function [-Wuninitialized]: 127:33 => 
  - /kisskb/src/lib/reed_solomon/reed_solomon.c: warning: 'decode_rs16' uses dynamic stack allocation [enabled by default]: 373:1 => 
  - /kisskb/src/lib/reed_solomon/reed_solomon.c: warning: 'decode_rs8' uses dynamic stack allocation [enabled by default]: 329:1 => 
  - /kisskb/src/lib/xxhash.c: warning: the frame size of 1736 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 236:1 => 
  - /kisskb/src/net/core/rtnetlink.c: warning: 'rtnl_newlink' uses dynamic stack allocation [enabled by default]: 3083:1 => 
  - /kisskb/src/net/ipv6/xfrm6_state.c: warning: '__xfrm6_sort' uses dynamic stack allocation [enabled by default]: 84:1 => 
  - /kisskb/src/net/netfilter/nfnetlink.c: warning: 'nfnetlink_rcv_batch' uses dynamic stack allocation [enabled by default]: 452:1 => 
  - /kisskb/src/net/netfilter/nfnetlink.c: warning: 'nfnetlink_rcv_msg' uses dynamic stack allocation [enabled by default]: 223:1 => 
  - /kisskb/src/net/openvswitch/actions.c: warning: 'ovs_fragment' uses dynamic stack allocation [enabled by default]: 943:1 => 
  - /kisskb/src/net/openvswitch/datapath.c: warning: the frame size of 1456 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 1220:1 => 
  - /kisskb/src/security/keys/big_key.c: warning: 'big_key_crypt' uses dynamic stack allocation [enabled by default]: 136:1 => 
  - /kisskb/src/security/keys/dh.c: warning: 'kdf_ctr' uses dynamic stack allocation [enabled by default]: 211:1 => 
  - /kisskb/src/sound/soc/soc-dapm.c: warning: 'private_value' may be used uninitialized in this function [-Wuninitialized]: 3984:28 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_ARP: 214 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_BRIDGE: 269 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_INET: 108 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NF_TABLES_NETDEV: 109 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_ARP: 200 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_BRIDGE: 255 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_INET: 94 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NF_TABLES_NETDEV: 95 => 
  - warning: drivers/hwmon/ibmpowernv.o(.text+0xa3c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label(): N/A => 
  - warning: vmlinux.o(.text+0x35cc4c): Section mismatch in reference from the function devm_memremap_pages() to the function .meminit.text:arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x35d528): Section mismatch in reference from the function devm_memremap_pages_release() to the function .meminit.text:arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x35e90): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x36b4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x377538): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x377d84): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x37f098): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x37f8e4): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3944): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3978): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
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
