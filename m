Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D15CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C786120879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544708461;
	bh=Sjxy7B/wZDho/JbIjGcjTmDYQn1aNJU4vZYSV+KmNNA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HN7XN8WD4/45RBEQLMGmCvkWQZeNXKIy25BxL0U5w47258DhzyzXwJEzv/tKsRVmg
	 jD024h8YA5id9waIPoegoq1AO/jefnNyAVAu6mGSMekne7eZEqd82Lyjcc22ss+1P0
	 0xSRx4sh7CJi/DfRzMcEYZDMqpw31ugYTaaxGFho=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C786120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeLMNlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbeLMNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:40:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E53720879;
        Thu, 13 Dec 2018 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544708457;
        bh=Sjxy7B/wZDho/JbIjGcjTmDYQn1aNJU4vZYSV+KmNNA=;
        h=Date:From:To:Cc:Subject:From;
        b=yl587SimuC5ql69le9Q3KD8imnxNm0wpwpFAMCNKtJVTmvBuWokKiTMVZftYCvKYF
         EHRWCBAqk4AGQXrXswrjgdeZjZ/tijlwL3SS3qY4aJAzgr77Bs8XKUnC7DY36THPji
         W0fGmp6NKz+FrR2fBEOTqq6YaKlwOk8zBAxLbLqw=
Date:   Thu, 13 Dec 2018 14:40:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.9
Message-ID: <20181213134055.GA21502@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.9 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                               |    2=20
 arch/arm/probes/kprobes/opt-arm.c                      |    2=20
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts          |   12 -
 arch/arm64/kernel/hibernate.c                          |    2=20
 arch/parisc/Makefile                                   |    7=20
 arch/riscv/include/asm/module.h                        |    1=20
 arch/x86/boot/compressed/eboot.c                       |   65 +++--
 arch/x86/kernel/e820.c                                 |   15 -
 arch/x86/kernel/kprobes/opt.c                          |    2=20
 crypto/cbc.c                                           |    6=20
 crypto/cfb.c                                           |    6=20
 crypto/pcbc.c                                          |    6=20
 drivers/cpufreq/ti-cpufreq.c                           |   26 +-
 drivers/dma/dw/core.c                                  |    6=20
 drivers/dma/imx-sdma.c                                 |   69 +++---
 drivers/dma/ti/cppi41.c                                |   16 +
 drivers/gnss/sirf.c                                    |    6=20
 drivers/gpio/gpio-mockup.c                             |    6=20
 drivers/gpio/gpio-pxa.c                                |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c            |    7=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h               |    2=20
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                  |   44 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |   16 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h      |    1=20
 drivers/gpu/drm/drm_internal.h                         |    2=20
 drivers/gpu/drm/drm_lease.c                            |    2=20
 drivers/gpu/drm/drm_sysfs.c                            |   10=20
 drivers/gpu/drm/i915/intel_pm.c                        |    4=20
 drivers/gpu/drm/msm/msm_gem_submit.c                   |   15 -
 drivers/hid/hid-ids.h                                  |    8=20
 drivers/hid/hid-input.c                                |    3=20
 drivers/hid/hid-multitouch.c                           |    6=20
 drivers/hid/hid-quirks.c                               |    2=20
 drivers/hid/uhid.c                                     |   13 -
 drivers/hv/channel_mgmt.c                              |  189 +++++++++++-=
-----
 drivers/hv/connection.c                                |   24 +-
 drivers/hv/hyperv_vmbus.h                              |    7=20
 drivers/iommu/amd_iommu_init.c                         |    3=20
 drivers/iommu/intel-iommu.c                            |    2=20
 drivers/iommu/intel-svm.c                              |    2=20
 drivers/iommu/ipmmu-vmsa.c                             |    3=20
 drivers/media/cec/cec-adap.c                           |   47 +++-
 drivers/media/dvb-frontends/dvb-pll.c                  |  106 ++++-----
 drivers/media/pci/intel/ipu3/ipu3-cio2.c               |    4=20
 drivers/media/platform/omap3isp/isp.c                  |    3=20
 drivers/media/platform/vicodec/vicodec-core.c          |    5=20
 drivers/media/usb/gspca/gspca.c                        |   11=20
 drivers/mfd/cros_ec_dev.c                              |    8=20
 drivers/mtd/nand/raw/qcom_nandc.c                      |   32 +-
 drivers/mtd/spi-nor/cadence-quadspi.c                  |   19 +
 drivers/net/can/rcar/rcar_can.c                        |    5=20
 drivers/net/can/usb/ucan.c                             |    3=20
 drivers/net/ethernet/amazon/ena/ena_netdev.c           |    2=20
 drivers/net/ethernet/amd/sunlance.c                    |    4=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h            |    7=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c         |    1=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c      |    4=20
 drivers/net/ethernet/faraday/ftmac100.c                |    7=20
 drivers/net/ethernet/ibm/ibmvnic.c                     |   72 ++----
 drivers/net/ethernet/ibm/ibmvnic.h                     |    2=20
 drivers/net/ethernet/mellanox/mlx4/alloc.c             |    2=20
 drivers/net/ethernet/mellanox/mlx4/mlx4.h              |    4=20
 drivers/net/ethernet/mellanox/mlx4/mr.c                |    1=20
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c             |   14 -
 drivers/net/ethernet/qlogic/qed/qed_dev.c              |   44 +++
 drivers/net/ethernet/qlogic/qed/qed_int.c              |    2=20
 drivers/net/ethernet/qlogic/qed/qed_main.c             |    2=20
 drivers/net/ethernet/qlogic/qed/qed_rdma.c             |   50 ++--
 drivers/net/ethernet/qlogic/qed/qed_rdma.h             |    5=20
 drivers/net/team/team.c                                |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c |    3=20
 drivers/net/wireless/mac80211_hwsim.c                  |    8=20
 drivers/net/wireless/mediatek/mt76/Kconfig             |    6=20
 drivers/net/wireless/mediatek/mt76/mac80211.c          |    8=20
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c       |    6=20
 drivers/nvdimm/nd-core.h                               |    2=20
 drivers/nvdimm/pfn_devs.c                              |   64 +++--
 drivers/nvdimm/region_devs.c                           |   41 +++
 drivers/nvme/host/fc.c                                 |   73 +++++-
 drivers/s390/net/ism_drv.c                             |    2=20
 drivers/s390/virtio/virtio_ccw.c                       |   17 +
 drivers/scsi/ufs/ufs-hisi.c                            |    9=20
 drivers/scsi/ufs/ufs_quirks.h                          |    6=20
 drivers/scsi/ufs/ufshcd.c                              |    2=20
 drivers/staging/rtl8712/mlme_linux.c                   |    2=20
 drivers/staging/rtl8712/rtl871x_mlme.c                 |    2=20
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c          |    2=20
 drivers/tty/serial/8250/8250_mtk.c                     |   16 -
 drivers/tty/serial/kgdboc.c                            |    4=20
 drivers/tty/tty_io.c                                   |   11=20
 drivers/tty/tty_port.c                                 |    3=20
 drivers/usb/core/hub.c                                 |    2=20
 drivers/usb/core/quirks.c                              |    4=20
 drivers/usb/core/usb.c                                 |    6=20
 drivers/usb/dwc2/pci.c                                 |    1=20
 drivers/usb/gadget/function/f_fs.c                     |   26 --
 drivers/usb/host/hwa-hc.c                              |    2=20
 drivers/usb/host/xhci-pci.c                            |    4=20
 drivers/usb/host/xhci.c                                |   42 +++
 drivers/usb/host/xhci.h                                |    3=20
 drivers/usb/misc/appledisplay.c                        |    1=20
 drivers/usb/serial/console.c                           |    2=20
 drivers/vhost/vsock.c                                  |   57 ++---
 fs/cifs/dir.c                                          |    2=20
 fs/nfs/callback_proc.c                                 |   22 -
 fs/nfs/flexfilelayout/flexfilelayout.c                 |   21 -
 fs/nfs/flexfilelayout/flexfilelayout.h                 |    4=20
 fs/nfs/flexfilelayout/flexfilelayoutdev.c              |   19 +
 fs/nfs/nfs42proc.c                                     |   19 -
 fs/nfs/nfs4_fs.h                                       |    2=20
 fs/nfs/nfs4state.c                                     |   16 -
 include/linux/hyperv.h                                 |    7=20
 include/linux/tty.h                                    |    1=20
 include/linux/usb.h                                    |    4=20
 include/sound/pcm_params.h                             |    4=20
 lib/test_firmware.c                                    |    1=20
 net/batman-adv/bat_v_elp.c                             |    6=20
 net/batman-adv/fragmentation.c                         |    2=20
 net/mac80211/iface.c                                   |    2=20
 net/mac80211/rx.c                                      |    5=20
 net/mac80211/status.c                                  |    2=20
 net/mac80211/tx.c                                      |    4=20
 net/sunrpc/auth_gss/auth_gss.c                         |    4=20
 net/wireless/util.c                                    |    2=20
 sound/core/pcm_native.c                                |   14 -
 sound/pci/hda/hda_intel.c                              |    4=20
 sound/pci/hda/patch_realtek.c                          |   27 ++
 sound/usb/card.c                                       |    5=20
 sound/usb/quirks.c                                     |    1=20
 tools/testing/selftests/tc-testing/tdc.py              |   18 +
 130 files changed, 1177 insertions(+), 570 deletions(-)

Alex Deucher (2):
      drm/amdgpu/gmc8: update MC firmware for polaris
      drm/amdgpu/gmc8: always load MC firmware in the driver

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Andrew Morton (1):
      drivers/net/ethernet/qlogic/qed/qed_rdma.h: fix typo

Andy Shevchenko (1):
      dmaengine: dw: Fix FIFO size for Intel Merrifield

Arnd Bergmann (1):
      mt76: fix building without CONFIG_LEDS_CLASS

Arthur Kiyanovski (1):
      net: ena: fix crash during failed resume from hibernation

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Bartosz Golaszewski (1):
      gpio: mockup: fix indicated direction

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop

Benson Leung (1):
      HID: input: Ignore battery reported by Symbol DS4308

Bin Liu (1):
      dmaengine: cppi41: delete channel from pending list when stop channel

Brenda J. Butler (1):
      tc-testing: tdc.py: Guard against lack of returncode in executed comm=
and

Chanho Min (1):
      ALSA: pcm: Fix starvation on down_write_nonblock()

Chanho Park (1):
      tty: do not set TTY_IO_ERROR flag if console port

Chris Chiu (4):
      ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire=
 U27-880
      ALSA: hda/realtek - Add support for Acer Aspire C24-860 headset mic
      ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4660G
      ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G

Chris Wilson (1):
      drm/i915: Downgrade Gen9 Plane WM latency error

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Colin Ian King (1):
      test_firmware: fix error return getting clobbered

Dan Carpenter (1):
      usb: dwc2: pci: Fix an error code in probe

Dan Williams (1):
      libnvdimm, pfn: Pad pfn namespaces relative to other regions

Daniel Vetter (1):
      drm/lease: Send a distinct uevent

Dave Gerlach (1):
      cpufreq: ti-cpufreq: Only register platform_device when supported

David Abdurachmanov (1):
      riscv: fix warning in arch/riscv/include/asm/module.h

David Herrmann (1):
      Revert "HID: uhid: use strlcpy() instead of strncpy()"

Denis Bolotin (5):
      qed: Fix PTT leak in qed_drain()
      qed: Fix overriding offload_tc by protocols without APP TLV
      qed: Fix reading wrong value in loop condition
      qed: Fix bitmap_weight() check
      qed: Fix QM getters to always return a valid pq

Dexuan Cui (1):
      Drivers: hv: vmbus: Offload the handling of channels to two workqueues

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection

Enric Balletbo i Serra (1):
      Revert "mfd: cros_ec: Use devm_kzalloc for private data"

Eric Snowberg (1):
      x86/efi: Allocate e820 buffer before calling efi_exit_boot_service

Fabrizio Castro (1):
      can: rcar_can: Fix erroneous registration

Felix Fietkau (2):
      mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
      mac80211: fix reordering of buffered broadcast packets

Filippo Sironi (1):
      amd/iommu: Fix Guest Virtual APIC Log Tail Address Register

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix crash on early domain free

Greg Kroah-Hartman (1):
      Linux 4.19.9

Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
      virtio/s390: fix race in ccw_io_helper()

Hangbin Liu (1):
      team: no need to do team_notify_peers or team_mcast_rejoin when disab=
ling port

Hans Verkuil (4):
      media: vicodec: lower minimum height to 360
      media: cec: check for non-OK/NACK conditions while claiming a LA
      media: gspca: fix frame overflow error
      media: vicodec: fix memchr() kernel oops

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Helge Deller (1):
      parisc: Enable -ffunction-sections for modules on 32-bit kernel

Hui Peng (1):
      ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in =
card.c

Jack Morgenstein (1):
      net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

James Smart (1):
      nvme-fc: resolve io failures during connect

Johan Hovold (2):
      USB: serial: console: fix reported terminal settings
      gnss: sirf: fix activation retry handling

Jouni Malinen (1):
      cfg80211: Fix busy loop regression in ieee80211_ie_split_ric()

Juliet Kim (1):
      net/ibmnvic: Fix deadlock problem in reset

Junwei Zhang (1):
      drm/amdgpu: update mc firmware image for polaris12 variants

Kai-Heng Feng (2):
      HID: multitouch: Add pointstick support for Cirque Touchpad
      ALSA: hda: Add support for AMD Stoney Ridge

Kees Cook (1):
      ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

Lu Baolu (1):
      iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Lucas Bates (1):
      tc-testing: tdc.py: ignore errors when decoding stdout/stderr

Lucas Stach (4):
      Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"
      Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
      dmaengine: imx-sdma: implement channel termination via worker
      dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Masami Hiramatsu (1):
      kprobes/x86: Fix instruction patching corruption when copying more th=
an one RIP-relative instruction

Masayoshi Mizuma (1):
      Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Mauro Carvalho Chehab (2):
      media: dvb-pll: fix tuner frequency ranges
      media: dvb-pll: don't re-validate tuner frequencies

Michal Kalderon (1):
      qed: Fix rdma_info structure allocation

Nic Soud=C3=A9e (1):
      HID: quirks: fix RetroUSB.com devices

Nicholas Kazlauskas (2):
      drm/amdgpu: Add amdgpu "max bpc" connector property (v2)
      drm/amd/display: Support amdgpu "max bpc" connector property (v2)

Olga Kornievskaia (1):
      NFSv4.2 copy do not allocate memory under the lock

Olof Johansson (1):
      mtd: rawnand: qcom: Namespace prefix some commands

Pan Bian (2):
      iommu/vt-d: Use memunmap to free memremap
      crypto: do not free algorithm before using

Paulo Alcantara (1):
      cifs: Fix separator when building path from dentry

Peter Shih (1):
      tty: serial: 8250_mtk: always resume the device in probe.

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmutil: really fix decoding channel info for 160 MHz bandwidth

Robert Foss (1):
      drm/msm: Move fence put to where failure occurs

Robert Jarzmik (1):
      gpio: pxa: fix legacy non pinctrl aware builds again

Sakari Ailus (2):
      media: omap3isp: Unregister media device as first
      media: ipu3-cio2: Unregister device nodes first, then release resourc=
es

Sandeep Singh (1):
      xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

Sasha Levin (1):
      arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability =
issues

Shen Jing (1):
      Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted =
AIO transfers"

Stefan Hajnoczi (1):
      vhost/vsock: fix use-after-free in network stack callers

Sudarsana Reddy Kalluru (1):
      bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Sven Eckelmann (2):
      batman-adv: Use explicit tvlv padding for ELP packets
      batman-adv: Expand merged fragment buffer for full packet

Takashi Iwai (3):
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: pcm: Fix interval evaluation with openmin/max
      ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

Tariq Toukan (1):
      net/mlx4_core: Fix uninitialized variable compilation warning

Thomas Falcon (2):
      ibmvnic: Fix RX queue buffer cleanup
      ibmvnic: Update driver queues after change in ring size support

Thor Thayer (1):
      mtd: spi-nor: Fix Cadence QSPI page fault kernel panic

Tigran Mkrtchyan (1):
      flexfiles: use per-mirror specified stateid for IO

Tony Das (1):
      ALSA: usb-audio: Add SMSL D1 to quirks for native DSD support

Trond Myklebust (1):
      NFSv4: Fix a NFSv4 state manager deadlock

Ursula Braun (1):
      s390/ism: clear dmbe_mask bit before SMC IRQ handling

Vasundhara Volam (1):
      bnxt_en: Fix filling time in bnxt_fill_coredump_record()

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered

Vincent Chen (1):
      net: faraday: ftmac100: remove netif_running(netdev) check before dis=
abling interrupts

Wei Li (1):
      scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC

Will Deacon (1):
      arm64: hibernate: Avoid sending cross-calling with interrupts disabled

Yan-Hsuan Chuang (1):
      mac80211: fix GFP_KERNEL under tasklet context

Yangtao Li (1):
      net: amd: add missing of_node_put()

Young Xiao (2):
      staging: rtl8712: Fix possible buffer overrun
      Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors a=
nd an off-by-one mistake in core/rtw_mlme_ext.c"

YueHaibing (1):
      can: ucan: remove set but not used variable 'udev'


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwSYWcACgkQONu9yGCS
aT4pLQ//eCnKV8FCxV4fEvvzXmL85W/7nGYRnlIE3e1XplCD4jrhfmb9tnQ6zIjz
GWk2CM3mVdvNH1YBTuN6BGIO7jDSYoFV0r4N6vc1Tn8IZNWLJrybGaWFmtoTgRRN
+ZOrLffCorNYHgXMnsgz3btKvBlYPh9h3Gqr82DlghAsGwu3eQvm51+stzcMrFfo
k8an0LHOzNXm6O3jXX5I/AD05S3fGGymnfEdmqxPIMDS1FTzkIckWSXZ/0g74fNv
A3039ZDDBywr/yjF+wL/n4LCpvhZihKxJoAHK91EEdPPAMXaREs8uXgunGa6aJHy
FPX4QTQC7/b3vObRqoLW+mVB0virOKM8bChm/y2h5QNC3v5Pw9HLbmG9hIwJqM2T
xSik52CPyrHaJey2G4Qm2IkR2XT4iMrtua0KUa7KUA/ItfuKBxLNIXw69FnJ3DU2
7WTnSzfG5g7lCVyB4ZrrRORxtZF7GMXub39OTagXwImGMxSYLg6BXmlskxClDOBV
rnwuIuvuK6kEtFv0S7OELcUsWRbEjeXSSE9zOQMHHXXPkIrsEunvI5wnPnmV5AkR
u8UjHuy3sHv7Po4a2vms4BGlYcirha1dbmi+tXMN/ChoTpxg89IgTYpBVg4WmKGR
jaOMsrKD7NpCdQ9zAix+5g5a4q6Wu+uz3u6jN+1yKr2I2g5YJY4=
=SW69
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
