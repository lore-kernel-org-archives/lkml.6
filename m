Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3693C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B712146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543565;
	bh=o2CXTB25EvZQ7IYkmhlsjLCL7wK9HN5IKzCgkdpN7Is=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xSiM7KGRAG8LwdO9eKpPJWJaNPBV+o20bNFQ2MpHLYrPSTNmnChD8AUAy3tjTgt2u
	 VBXIpPA1vMCGrJMt9t5UfEU62upzBjr0KJRhoqL0wIUGncVwscZ8y1nlg5lnrNLAKx
	 LitKcQDDrgEK/DVygPQIJUhrLTwsGXv+0FSZ6otY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B712146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeLKPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbeLKPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD29820855;
        Tue, 11 Dec 2018 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543557;
        bh=o2CXTB25EvZQ7IYkmhlsjLCL7wK9HN5IKzCgkdpN7Is=;
        h=From:To:Cc:Subject:Date:From;
        b=SXqs0RJaxtFvCpTZWYFoifTXfjOS2io7XOdSqfwHB6EQf7Uy8rZAJnfCTF/2Gd8JT
         3KK0bNhQszVxgDGDQVp0xUOFjnv4/32JH2nEpEQMGJb/N2dxljfXvtkVl9xWVsCDxd
         mqqNhnPdBjnoenQi4LU43uzy++Hkblv+B2KnTFvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/67] 4.14.88-stable review
Date:   Tue, 11 Dec 2018 16:41:00 +0100
Message-Id: <20181211151630.378216233@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.88-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.88-rc1
X-KernelTest-Deadline: 2018-12-13T15:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.88 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec 13 15:16:01 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.88-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.88-rc1

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: ignore NullFunc frames in the duplicate detection

Felix Fietkau <nbd@nbd.name>
    mac80211: fix reordering of buffered broadcast packets

Felix Fietkau <nbd@nbd.name>
    mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext

Ben Greear <greearb@candelatech.com>
    mac80211: Clear beacon_int in ieee80211_do_stop

Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>
    mac80211_hwsim: Timer should be initialized before device registered

Dan Williams <dan.j.williams@intel.com>
    libnvdimm, pfn: Pad pfn namespaces relative to other regions

Macpaul Lin <macpaul@gmail.com>
    kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Chanho Park <parkch98@gmail.com>
    tty: do not set TTY_IO_ERROR flag if console port

Peter Shih <pihsun@chromium.org>
    tty: serial: 8250_mtk: always resume the device in probe.

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Offload the handling of channels to two workqueues

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gmc8: update MC firmware for polaris

Junwei Zhang <Jerry.Zhang@amd.com>
    drm/amdgpu: update mc firmware image for polaris12 variants

Young Xiao <YangX92@hotmail.com>
    Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c"

Young Xiao <YangX92@hotmail.com>
    staging: rtl8712: Fix possible buffer overrun

Paulo Alcantara <palcantara@suse.com>
    cifs: Fix separator when building path from dentry

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    staging: atomisp: remove "fun" strncpy warning

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Staging: lustre: remove two build warnings

Kees Cook <keescook@chromium.org>
    swiotlb: clean up reporting

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with block address in main area v2

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Prevent U1/U2 link pm states if exit latency is too long

Sandeep Singh <sandeep.singh@amd.com>
    xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

Kees Cook <keescook@chromium.org>
    ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

Bin Liu <b-liu@ti.com>
    dmaengine: cppi41: delete channel from pending list when stop channel

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    dmaengine: dw: Fix FIFO size for Intel Merrifield

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix leak of krb5p encode pages

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix use-after-free in network stack callers

Halil Pasic <pasic@linux.ibm.com>
    virtio/s390: fix race in ccw_io_helper()

Halil Pasic <pasic@linux.ibm.com>
    virtio/s390: avoid race on vcdev->config

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix interval evaluation with openmin/max

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Call snd_pcm_unlink() conditionally at closing

Chanho Min <chanho.min@lge.com>
    ALSA: pcm: Fix starvation on down_write_nonblock()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add support for AMD Stoney Ridge

Hui Peng <benquike@gmail.com>
    ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c

Mathias Payer <mathias.payer@nebelwelt.net>
    USB: check usb_get_extra_descriptor for proper size

Alexander Theissen <alex.theissen@me.com>
    usb: appledisplay: Add 27" Apple Cinema Display

Harry Pan <harry.pan@intel.com>
    usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm: don't warn about allocations which stall for too long

Yangtao Li <tiny.windzz@gmail.com>
    net: amd: add missing of_node_put()

Hangbin Liu <liuhangbin@gmail.com>
    team: no need to do team_notify_peers or team_mcast_rejoin when disabling port

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmvnic: Fix RX queue buffer cleanup

Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
    flexfiles: use per-mirror specified stateid for IO

Pan Bian <bianpan2016@163.com>
    iommu/vt-d: Use memunmap to free memremap

Vincent Chen <vincentc@andestech.com>
    net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix QM getters to always return a valid pq

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix bitmap_weight() check

Thor Thayer <thor.thayer@linux.intel.com>
    mtd: spi-nor: Fix Cadence QSPI page fault kernel panic

Kai-Heng Feng <kai.heng.feng@canonical.com>
    HID: multitouch: Add pointstick support for Cirque Touchpad

Olof Johansson <olof@lixom.net>
    mtd: rawnand: qcom: Namespace prefix some commands

Bartosz Golaszewski <brgl@bgdev.pl>
    gpio: mockup: fix indicated direction

Aya Levin <ayal@mellanox.com>
    net/mlx4: Fix UBSAN warning of signed integer overflow

Tariq Toukan <tariqt@mellanox.com>
    net/mlx4_core: Fix uninitialized variable compilation warning

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Shen Jing <jingx.shen@intel.com>
    Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers"

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix reading wrong value in loop condition

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix PTT leak in qed_drain()

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Filippo Sironi <sironi@amazon.de>
    amd/iommu: Fix Guest Virtual APIC Log Tail Address Register

Sven Eckelmann <sven@narfation.org>
    batman-adv: Expand merged fragment buffer for full packet

Sven Eckelmann <sven@narfation.org>
    batman-adv: Use explicit tvlv padding for ELP packets

Benson Leung <bleung@chromium.org>
    HID: input: Ignore battery reported by Symbol DS4308

Colin Ian King <colin.king@canonical.com>
    test_firmware: fix error return getting clobbered

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    can: rcar_can: Fix erroneous registration

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix crash on early domain free

Rafał Miłecki <rafal@milecki.pl>
    brcmutil: really fix decoding channel info for 160 MHz bandwidth

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: omap3isp: Unregister media device as first


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/probes/kprobes/opt-arm.c                  |   2 +-
 drivers/dma/cppi41.c                               |  16 +-
 drivers/dma/dw/core.c                              |   6 +-
 drivers/gpio/gpio-mockup.c                         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  35 +++-
 drivers/hid/hid-ids.h                              |   4 +
 drivers/hid/hid-input.c                            |   3 +
 drivers/hid/hid-multitouch.c                       |   6 +
 drivers/hv/channel_mgmt.c                          | 185 ++++++++++++++-------
 drivers/hv/connection.c                            |  24 ++-
 drivers/hv/hyperv_vmbus.h                          |   7 +
 drivers/iommu/amd_iommu_init.c                     |   3 +-
 drivers/iommu/intel-iommu.c                        |   2 +-
 drivers/iommu/intel-svm.c                          |   2 +-
 drivers/iommu/ipmmu-vmsa.c                         |   3 +
 drivers/media/platform/omap3isp/isp.c              |   3 +-
 drivers/mtd/nand/qcom_nandc.c                      |  32 ++--
 drivers/mtd/spi-nor/cadence-quadspi.c              |  19 ++-
 drivers/net/can/rcar/rcar_can.c                    |   5 +-
 drivers/net/ethernet/amd/sunlance.c                |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   7 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |   1 +
 drivers/net/ethernet/faraday/ftmac100.c            |   7 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   4 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h          |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c            |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |  29 +++-
 drivers/net/ethernet/qlogic/qed/qed_int.c          |   2 +
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   2 +-
 drivers/net/team/team.c                            |   2 -
 .../net/wireless/broadcom/brcm80211/brcmutil/d11.c |   3 +
 drivers/net/wireless/mac80211_hwsim.c              |   8 +-
 drivers/nvdimm/nd-core.h                           |   2 +
 drivers/nvdimm/pfn_devs.c                          |  64 ++++---
 drivers/nvdimm/region_devs.c                       |  41 +++++
 drivers/s390/virtio/virtio_ccw.c                   |  17 +-
 drivers/staging/lustre/lnet/lnet/config.c          |   3 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |   2 +-
 .../css2400/runtime/debug/src/ia_css_debug.c       |   4 +-
 drivers/staging/rtl8712/mlme_linux.c               |   2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |   2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   2 +-
 drivers/tty/serial/8250/8250_mtk.c                 |  16 +-
 drivers/tty/serial/kgdboc.c                        |   4 +-
 drivers/tty/tty_port.c                             |   3 +-
 drivers/usb/core/hub.c                             |   2 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/core/usb.c                             |   6 +-
 drivers/usb/gadget/function/f_fs.c                 |  26 +--
 drivers/usb/host/hwa-hc.c                          |   2 +-
 drivers/usb/host/xhci-pci.c                        |   4 +
 drivers/usb/host/xhci.c                            |  42 ++++-
 drivers/usb/host/xhci.h                            |   3 +
 drivers/usb/misc/appledisplay.c                    |   1 +
 drivers/vhost/vsock.c                              |  57 ++++---
 fs/cifs/dir.c                                      |   2 +-
 fs/f2fs/data.c                                     |   3 +
 fs/f2fs/inode.c                                    |  18 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |  21 +--
 fs/nfs/flexfilelayout/flexfilelayout.h             |   4 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c          |  19 +++
 include/linux/hyperv.h                             |   7 +
 include/linux/usb.h                                |   4 +-
 include/sound/pcm_params.h                         |   4 +-
 lib/swiotlb.c                                      |  20 +--
 lib/test_firmware.c                                |   1 +
 mm/page_alloc.c                                    |  10 --
 net/batman-adv/bat_v_elp.c                         |   6 +-
 net/batman-adv/fragmentation.c                     |   2 +-
 net/mac80211/iface.c                               |   2 +
 net/mac80211/rx.c                                  |   1 +
 net/mac80211/status.c                              |   2 +
 net/mac80211/tx.c                                  |   4 +-
 net/sunrpc/auth_gss/auth_gss.c                     |   4 +
 sound/core/pcm_native.c                            |  14 +-
 sound/pci/hda/hda_intel.c                          |   4 +
 sound/pci/hda/patch_realtek.c                      |   9 +
 sound/usb/card.c                                   |   5 +-
 80 files changed, 640 insertions(+), 278 deletions(-)


