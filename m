Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2724055-1524561693-2-15320279285008683101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524561691; b=jKwL095CTBAtdegFebmmga6JtJCKkd2vpi/TNLV8wlomJqVmL/
    l9pPlaQxgKYXWp4CsXf7aHdMGChw5FY1t/E6a5EdvXbnfdV0gVMKh41aztfMzIrc
    1t1H8txWtFo2wr0RK8kuWqzYenXk/McNipgs2Dtm3gRn0cLIqf6gkwrj3PiB+J/J
    /3zf/1Af7JoRw0+U868XlJaj414vGoQoUdSXyYDcA3NL4hGOpdRfUEf8lb2wNtTg
    Vh3cyplwYtsxlqtyiOStABnnIiuvWpJf51mhU8rMFLLOjpKxmYiiX7vMjJgZFh2s
    GobfCZpc/h8aRzqdHx4bpp2+mst5c30H6a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524561691;
    bh=0CeXfHexYkGxSdbMhxcgSCHZxXtWb/10/Rp0UxISuoA=; b=KKDSExR2S+MU
    qloK6yjjLykRSM5LAG945/momm6yN2fPel1FnW9ma9qmrZhY/YUxKxN/AsSHa2bI
    sjX8WOLy4ZaR0Z90vj+Uy+WrEQ/YDcXFD0O45nU8xwkXv8IG79WEb/lblANRt01X
    sWAOW6ZnjDnq6WXx0q7QLC8qAI1hIobjioOE70eClR9r/3eak9nd2rYeHyLjKVzi
    FJPiKgtbYIkBKk1jmeUNdySJwdUbQwsIGGvaq2bJlyD9xzsNyKD+Zwm26KAfoyR9
    /pzeRDtIUILuwpYVp6xamtUaTafGIe4aiXK/cSStTKe6vdK7PCm4hGF/HrsDYdLE
    D6QS7H2TKQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH2vbG0jCFZ3/o+XAk4GcXppwsBsTTXS4rVbtyROZVUKihfPQAFYld5ij5efuJQcfxiA/jY/hCHxexaHzstPDK6/YdzlSAh0jA3GhUHP7oWjvxllSLXQ
    +g1gFC+eMiun1Yv9agfszauFkCdoR0JJRDk9BxpASotn1wROjsR+0dKTVxWAfVsV20bQBavSO9ptlMdootEFpQPaI+QcctBRLpdAN6spHNVHJThoOdTc5hJV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=oWn3GetOCvNbiGlWVMIA:9 a=EOQ9u3CTYFYNzkgK:21 a=sSzrmDl6XHHrRklT:21
    a=wPNLvfGTeEIA:10 a=uNfyvELuhC7Fqg6pYjgA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755870AbeDXJVM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 05:21:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755804AbeDXJVE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 05:21:04 -0400
Date: Tue, 24 Apr 2018 11:20:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.36
Message-ID: <20180424092056.GA24237@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.36 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                  |    2=20
 arch/arm/boot/dts/at91sam9g25.dtsi                        |    2=20
 arch/arm/boot/dts/da850-lego-ev3.dts                      |    4=20
 arch/arm/boot/dts/exynos5250.dtsi                         |    8=20
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts             |   24 +
 arch/arm/boot/dts/sama5d4.dtsi                            |    2=20
 arch/arm/mach-exynos/pm.c                                 |    6=20
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts       |    2=20
 arch/mips/include/asm/uaccess.h                           |   11=20
 arch/mips/lib/memset.S                                    |   11=20
 arch/powerpc/include/asm/barrier.h                        |    3=20
 arch/powerpc/include/asm/opal.h                           |    3=20
 arch/powerpc/include/asm/synch.h                          |    4=20
 arch/powerpc/kernel/dt_cpu_ftrs.c                         |   12=20
 arch/powerpc/kernel/eeh_pe.c                              |    3=20
 arch/powerpc/kernel/kprobes.c                             |   30 +-
 arch/powerpc/kernel/machine_kexec_file_64.c               |    2=20
 arch/powerpc/lib/feature-fixups.c                         |    2=20
 arch/powerpc/mm/hash_utils_64.c                           |    6=20
 arch/powerpc/platforms/powernv/opal-nvram.c               |   11=20
 arch/powerpc/platforms/pseries/lpar.c                     |    8=20
 arch/powerpc/sysdev/xive/native.c                         |    4=20
 arch/s390/hypfs/inode.c                                   |    2=20
 arch/um/os-Linux/file.c                                   |    1=20
 arch/um/os-Linux/signal.c                                 |    3=20
 arch/x86/um/stub_segv.c                                   |    3=20
 arch/x86/xen/enlighten_pv.c                               |    8=20
 drivers/acpi/nfit/core.c                                  |   18 -
 drivers/acpi/video_detect.c                               |    9=20
 drivers/base/regmap/regmap.c                              |    2=20
 drivers/char/random.c                                     |   84 +++++-
 drivers/char/tpm/tpm-interface.c                          |    4=20
 drivers/clk/bcm/clk-bcm2835.c                             |    8=20
 drivers/clk/mediatek/clk-mt2701.c                         |   15 -
 drivers/clk/mvebu/armada-38x.c                            |   14 -
 drivers/clk/renesas/clk-sh73a0.c                          |    6=20
 drivers/cpufreq/cppc_cpufreq.c                            |    3=20
 drivers/dma/at_xdmac.c                                    |    4=20
 drivers/extcon/extcon-intel-cht-wc.c                      |   11=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c          |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c               |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                    |    2=20
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c                     |    2=20
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c                    |    2=20
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                    |    2=20
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                    |    2=20
 drivers/gpu/drm/amd/amdgpu/si.c                           |   67 ++++
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                       |    4=20
 drivers/gpu/drm/i915/i915_reg.h                           |   10=20
 drivers/gpu/drm/i915/intel_sprite.c                       |   81 ++++-
 drivers/gpu/drm/radeon/radeon_device.c                    |    4=20
 drivers/gpu/drm/radeon/si_dpm.c                           |    4=20
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c               |   23 -
 drivers/hid/hid-core.c                                    |   10=20
 drivers/hid/hid-input.c                                   |   27 +
 drivers/hid/hid-multitouch.c                              |    5=20
 drivers/hid/hid-rmi.c                                     |    4=20
 drivers/hid/hidraw.c                                      |    5=20
 drivers/hid/i2c-hid/i2c-hid.c                             |   13=20
 drivers/hid/wacom_sys.c                                   |    4=20
 drivers/hid/wacom_wac.c                                   |   76 +++--
 drivers/i2c/busses/i2c-i801.c                             |   16 +
 drivers/infiniband/core/ucma.c                            |    3=20
 drivers/infiniband/hw/mlx5/mr.c                           |    2=20
 drivers/infiniband/sw/rxe/rxe_verbs.c                     |    5=20
 drivers/infiniband/ulp/srp/ib_srp.c                       |   18 -
 drivers/iommu/intel-svm.c                                 |    1=20
 drivers/irqchip/irq-gic-common.c                          |    9=20
 drivers/md/dm-crypt.c                                     |   66 ++++
 drivers/media/platform/vivid/vivid-vid-common.c           |    3=20
 drivers/media/platform/vsp1/vsp1_wpf.c                    |    2=20
 drivers/misc/cxl/cxllib.c                                 |   85 +++---
 drivers/mmc/host/jz4740_mmc.c                             |    2=20
 drivers/mmc/host/sdhci-pci-core.c                         |   25 +
 drivers/mmc/host/tmio_mmc_core.c                          |    2=20
 drivers/mtd/ubi/block.c                                   |    2=20
 drivers/mtd/ubi/build.c                                   |   11=20
 drivers/mtd/ubi/fastmap-wl.c                              |    1=20
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c             |   62 ++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h              |    1=20
 drivers/net/wireless/intel/iwlwifi/iwl-config.h           |    5=20
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c               |    4=20
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c             |  195 +++++++++=
+++--
 drivers/net/xen-netfront.c                                |    7=20
 drivers/nvdimm/dimm.c                                     |    8=20
 drivers/nvdimm/namespace_devs.c                           |    4=20
 drivers/pci/hotplug/acpiphp_glue.c                        |   23 +
 drivers/pci/quirks.c                                      |    4=20
 drivers/phy/allwinner/phy-sun4i-usb.c                     |   10=20
 drivers/pwm/pwm-rcar.c                                    |    8=20
 drivers/soc/mediatek/mtk-scpsys.c                         |    2=20
 drivers/spi/spi-atmel.c                                   |    8=20
 drivers/spi/spi.c                                         |   19 -
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c |    6=20
 drivers/staging/media/lirc/lirc_zilog.c                   |    9=20
 drivers/thermal/imx_thermal.c                             |    6=20
 drivers/thunderbolt/icm.c                                 |   10=20
 drivers/thunderbolt/nhi.c                                 |    1=20
 drivers/thunderbolt/switch.c                              |    9=20
 drivers/tty/n_tty.c                                       |    6=20
 drivers/tty/tty_io.c                                      |    9=20
 drivers/usb/core/generic.c                                |    9=20
 drivers/usb/dwc3/core.c                                   |    3=20
 drivers/usb/dwc3/dwc3-pci.c                               |    2=20
 drivers/usb/dwc3/gadget.c                                 |   43 +--
 drivers/usb/gadget/function/f_midi.c                      |    3=20
 drivers/usb/gadget/u_f.h                                  |    2=20
 drivers/usb/gadget/udc/core.c                             |    3=20
 drivers/usb/musb/musb_gadget_ep0.c                        |   14 -
 drivers/vfio/pci/vfio_pci_config.c                        |   29 +-
 drivers/watchdog/f71808e_wdt.c                            |    2=20
 fs/autofs4/root.c                                         |    2=20
 fs/cifs/Kconfig                                           |    1=20
 fs/cifs/cifsencrypt.c                                     |   85 +-----
 fs/cifs/cifsfs.c                                          |    1=20
 fs/cifs/cifsglob.h                                        |    3=20
 fs/cifs/cifsproto.h                                       |    5=20
 fs/cifs/inode.c                                           |   33 ++
 fs/cifs/link.c                                            |   27 -
 fs/cifs/misc.c                                            |   54 +++
 fs/cifs/smb2ops.c                                         |   15 -
 fs/cifs/smb2pdu.c                                         |    8=20
 fs/cifs/smb2proto.h                                       |    3=20
 fs/cifs/smb2transport.c                                   |   97 ++----
 fs/cifs/smbencrypt.c                                      |   27 -
 fs/ext4/balloc.c                                          |    3=20
 fs/ext4/ext4_jbd2.c                                       |    7=20
 fs/ext4/ialloc.c                                          |   47 ---
 fs/ext4/inode.c                                           |   11=20
 fs/ext4/ioctl.c                                           |    8=20
 fs/ext4/super.c                                           |   21 -
 fs/ext4/xattr.c                                           |  121 ++++----
 fs/ext4/xattr.h                                           |   11=20
 fs/fs-writeback.c                                         |    7=20
 fs/jbd2/journal.c                                         |   30 +-
 fs/jffs2/super.c                                          |    2=20
 fs/namespace.c                                            |    3=20
 fs/notify/fanotify/fanotify.c                             |   34 +-
 fs/orangefs/super.c                                       |    5=20
 fs/reiserfs/journal.c                                     |    2=20
 fs/ubifs/super.c                                          |   14 -
 fs/udf/unicode.c                                          |    6=20
 include/dt-bindings/clock/mt2701-clk.h                    |    3=20
 include/linux/backing-dev-defs.h                          |    5=20
 include/linux/backing-dev.h                               |   30 +-
 include/linux/blk_types.h                                 |    5=20
 include/linux/compiler-clang.h                            |    3=20
 include/linux/compiler-gcc.h                              |   12=20
 include/linux/hid.h                                       |   15 -
 include/linux/hmm.h                                       |    9=20
 include/linux/tty.h                                       |    1=20
 include/sound/pcm_oss.h                                   |    1=20
 include/uapi/linux/random.h                               |    3=20
 ipc/shm.c                                                 |   23 +
 kernel/resource.c                                         |    3=20
 kernel/trace/ring_buffer.c                                |    5=20
 mm/filemap.c                                              |    9=20
 mm/hmm.c                                                  |    3=20
 mm/ksm.c                                                  |    7=20
 mm/page-writeback.c                                       |   18 -
 mm/slab.c                                                 |    3=20
 net/dsa/tag_brcm.c                                        |    3=20
 net/dsa/tag_dsa.c                                         |    3=20
 net/dsa/tag_edsa.c                                        |    3=20
 net/dsa/tag_ksz.c                                         |    3=20
 net/dsa/tag_lan9303.c                                     |    3=20
 net/dsa/tag_mtk.c                                         |    3=20
 net/dsa/tag_qca.c                                         |    3=20
 net/dsa/tag_trailer.c                                     |    3=20
 net/sunrpc/rpc_pipe.c                                     |    1=20
 sound/core/oss/pcm_oss.c                                  |  186 +++++++++=
+---
 sound/core/pcm.c                                          |    8=20
 sound/core/rawmidi_compat.c                               |   18 -
 sound/pci/hda/hda_intel.c                                 |    3=20
 sound/pci/hda/patch_realtek.c                             |    3=20
 sound/soc/codecs/ssm2602.c                                |   19 -
 sound/soc/soc-topology.c                                  |   23 +
 sound/usb/line6/midi.c                                    |    2=20
 virt/kvm/arm/vgic/vgic-its.c                              |   15 -
 179 files changed, 1840 insertions(+), 801 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: bluetooth: send exit report for recent Bluetooth devices

Aaron Ma (3):
      HID: i2c-hid: fix size check and type usage
      HID: Fix hid_report_len usage
      HID: core: Fix size as type u32

Al Viro (5):
      jffs2_kill_sb(): deal with failed allocations
      hypfs_kill_super(): deal with failed allocations
      orangefs_kill_sb(): deal with allocation failures
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts

Alex Deucher (4):
      drm/amdgpu: Add an ATPX quirk for hybrid laptop
      drm/amdgpu/sdma: fix mask in emit_pipeline_sync
      drm/amdgpu: Fix PCIe lane width calculation
      drm/amdgpu/si: implement get/set pcie_lanes asic callback

Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update

Alex Williamson (1):
      vfio/pci: Virtualize Maximum Read Request Size

Amir Goldstein (1):
      fanotify: fix logic of events on child

Andrew Lunn (1):
      net: dsa: Discard frames from unused ports

Andrew Morton (1):
      fs/reiserfs/journal.c: add missing resierfs_warning() arg

Aniruddha Banerjee (1):
      irqchip/gic: Take lock when updating irq type

Arnd Bergmann (1):
      clk: fix false-positive Wmaybe-uninitialized warning

Aurelien Aptel (2):
      CIFS: refactor crypto shash/sdesc allocation&free
      CIFS: add sha512 secmech

Bart Van Assche (3):
      RDMA/rxe: Fix an out-of-bounds read
      IB/srp: Fix srp_abort()
      IB/srp: Fix completion vector assignment algorithm

Bas Nieuwenhuizen (1):
      drm/amdgpu: Fix always_valid bos multiple LRU insertions.

Benjamin Herrenschmidt (1):
      powerpc/xive: Fix trying to "push" an already active pool VP

Boris Brezillon (1):
      clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Chen-Yu Tsai (1):
      phy: allwinner: sun4i-usb: poll vbus changes on A23/A33 when driving =
VBUS

Chris Chiu (1):
      tpm: self test failure should not cause suspend to fail

Claudio Imbrenda (1):
      mm/ksm.c: fix inconsistent accounting of zero pages

Dan Carpenter (1):
      regmap: Fix reversed bounds check in regmap_raw_write()

Dan Williams (4):
      libnvdimm, dimm: fix dpa reservation vs uninitialized label area
      libnvdimm, namespace: use a safe lookup for dimm device name
      nfit, address-range-scrub: fix scrub in-progress reporting
      nfit: skip region registration for incomplete control regions

Daniel Kurtz (1):
      mmc: sdhci-pci: Only do AMD tuning for HS200

David Lechner (1):
      ARM: dts: da850-lego-ev3: Fix battery voltage gpio

David Wang (1):
      ALSA: hda - New VIA controller suppor no-snoop path

Dmitry Torokhov (1):
      HID: input: fix battery level reporting on BT mice

Eric Biggers (2):
      ipc/shm: fix use-after-free of shm file via remap_file_pages()
      ext4: limit xattr size to INT_MAX

Eryu Guan (1):
      ext4: protect i_disksize update by i_data_sem in direct write path

Eugen Hristev (1):
      spi: atmel: init FIFOs before spi enable

Fabi=E1n Inostroza (1):
      ALSA: line6: Use correct endpoint type for midi output

Felipe Balbi (2):
      usb: gadget: udc: core: update usb_ep_queue() documentation
      usb: dwc3: gadget: never call ->complete() from ->ep_queue()

Frederic Barrat (1):
      cxl: Fix possible deadlock when processing page faults from cxllib

George Cherian (1):
      cpufreq: CPPC: Use transition_delay_us depending transition_latency

Greg Kroah-Hartman (1):
      Linux 4.14.36

Greg Thelen (1):
      writeback: safer lock nesting

Gustavo A. R. Silva (1):
      CIFS: fix sha512 check in cifs_crypto_secmech_release

Hans Verkuil (2):
      media: atomisp_fops.c: disable atomisp_compat_ioctl32
      media: vivid: check if the cec_adapter is valid

Hans de Goede (2):
      ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z=
5E
      extcon: intel-cht-wc: Set direction and drv flags for V5 boost GPIO

Heinrich Schuchardt (1):
      usb: musb: gadget: misplaced out of bounds check

Hui Wang (2):
      ALSA: hda/realtek - set PINCFG_HEADSET_MIC to parse_flags
      ALSA: hda/realtek - adjust the location of one mic

Ian Kent (1):
      autofs: mount point create should honour passed in mode

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix WD_EN register read

James Kelly (1):
      ASoC: ssm2602: Replace reg_default_raw with reg_default

Jan Kara (1):
      udf: Fix leak of UTF-16 surrogates into encoded strings

Jarkko Nikula (1):
      spi: Fix unregistration of controller with fixed SPI bus number

Jason A. Donenfeld (1):
      um: Compile with modern headers

Jason Andryuk (2):
      x86/xen: Delay get_cpu_cap until stack canary is established
      xen-netfront: Fix hang on device removal

Jean Delvare (2):
      i2c: i801: Save register SMBSLVCMD value only once
      i2c: i801: Restore configuration at shutdown

Jerome Brunet (1):
      ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate

J=E9r=F4me Glisse (2):
      mm/hmm: fix header file if/else/endif maze
      mm/hmm: hmm_pfns_bad() was accessing wrong struct

Kees Cook (1):
      task_struct: only use anon struct under randstruct plugin

Kieran Bingham (1):
      media: vsp1: Fix BRx conditional path in WPF

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

Leon Romanovsky (1):
      RDMA/mlx5: Protect from NULL pointer derefence

Liam Girdwood (1):
      ASoC: topology: Fix kcontrol name string handling

Lu Baolu (1):
      iommu/vt-d: Fix a potential memory leak

Luca Coelho (2):
      iwlwifi: add shared clock PHY config flag for some devices
      iwlwifi: add a bunch of new 9000 PCI IDs

Marc Zyngier (2):
      KVM: arm/arm64: vgic-its: Fix potential overrun in vgic_copy_lpi_list
      drm/rockchip: Clear all interrupts before requesting the IRQ

Marek Szyprowski (2):
      ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
      ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250

Masaharu Hayakawa (1):
      mmc: tmio: Fix error handling when issuing CMD23

Matt Redfearn (4):
      MIPS: uaccess: Add micromips clobbers to bzero invocation
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Maxime Chevallier (1):
      spi: Fix scatterlist elements size in spi_map_buf

Maxime Jayat (1):
      dmaengine: at_xdmac: fix rare residue corruption

Michael Ellerman (1):
      powerpc/lib: Fix off-by-one in alternate feature patching

Michael Neuling (1):
      powerpc/eeh: Fix enabling bridge MMIO windows

Mika Westerberg (5):
      ACPI / hotplug / PCI: Check presence of slot itself in get_slot_statu=
s()
      thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
      thunderbolt: Serialize PCIe tunnel creation with PCI rescan
      thunderbolt: Resume control channel after hibernation image is created
      thunderbolt: Prevent crash when ICM firmware is not running

Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()

Mikulas Patocka (2):
      block: use 32-bit blk_status_t on Alpha
      dm crypt: limit the number of allocated pages

Naveen N. Rao (1):
      powerpc/kprobes: Fix call trace due to incorrect preempt count

Nicholas Piggin (5):
      powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
      powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear unwanted LPCR =
bits
      powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
      powerpc/powernv: define a standard delay for OPAL_BUSY type retry loo=
ps
      powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Nico Sneck (1):
      drm/radeon: add PX quirk for Asus K73TK

Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Paul Mackerras (1):
      powerpc/64: Call H_REGISTER_PROC_TBL when running as a HPT guest on P=
OWER9

Paul Parsons (1):
      drm/radeon: Fix PCIe lane width calculation

Richard Genoud (1):
      clk: mvebu: armada-38x: add support for missing clocks

Richard Weinberger (3):
      ubifs: Check ubifs_wbuf_sync() return code
      ubi: fastmap: Don't flush fastmap work on detach
      ubi: Reject MLC NAND

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Roger Quadros (1):
      usb: dwc3: prevent setting PRTCAP to OTG from debugfs

Roland Dreier (1):
      RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA de=
vice

Romain Izard (1):
      ubi: Fix error for write access

Ronnie Sahlberg (2):
      cifs: fix memory leak in SMB2_open()
      fix smb3-encryption breakage when CONFIG_DEBUG_SG=3Dy

Ryo Kodama (1):
      pwm: rcar: Fix a condition to prevent mismatch value setting to duty

Santiago Esteban (1):
      ARM: dts: at91: sama5d4: fix pinctrl compatible string

Sean Wang (4):
      arm: dts: mt7623: fix USB initialization fails on bananapi-r2
      soc: mediatek: fix the mistaken pointer accessed when subdomains are =
added
      clk: mediatek: fix PWM clock source by adding a fixed-factor clock
      dt-bindings: clock: mediatek: add binding for fixed-factor clock axis=
el_d4

Sean Young (2):
      Revert "media: lirc_zilog: driver only sends LIRCCODE"
      media: staging: lirc_zilog: incorrect reference counting

Sinan Kaya (1):
      PCI: Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken

Steve French (1):
      smb3: Fix root directory when server returns inode number of zero

Steven Rostedt (VMware) (1):
      ring-buffer: Check if memory is available before allocation

Takashi Iwai (8):
      resource: fix integer overflow at reallocation
      ALSA: pcm: Fix UAF at PCM release via PCM timer access
      ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
      ALSA: pcm: Avoid potential races between OSS ioctls and read/write
      ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
      ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
      ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Tejun Heo (1):
      tty: make n_tty_read() always abort if hangup is in progress

Theodore Ts'o (16):
      random: use a tighter cap in credit_entropy_bits_safe()
      jbd2: if the journal is aborted then don't allow update of the log ta=
il
      ext4: shutdown should not prevent get_write_access
      ext4: eliminate sleep from shutdown ioctl
      ext4: pass -ESHUTDOWN code to jbd2 layer
      ext4: don't update checksum of new initialized bitmaps
      ext4: fail ext4_iget for root directory if unallocated
      ext4: always initialize the crc32c checksum driver
      ext4: don't allow r/w mounts if metadata blocks overlap the superblock
      ext4: move call to ext4_error() into ext4_xattr_check_block()
      ext4: add bounds checking to ext4_xattr_find_entry()
      ext4: add extra checks to ext4_xattr_block_get()
      random: fix crng_ready() test
      random: use a different mixing algorithm for add_device_randomness()
      random: crng_reseed() should lock the crng instance that it is modify=
ing
      random: add new ioctl RNDRESEEDCRNG

Thiago Jung Bauermann (1):
      powerpc/kexec_file: Fix error code when trying to load kdump kernel

Thinh Nguyen (1):
      usb: dwc3: pci: Properly cleanup resource

Ville Syrj=E4l=E4 (1):
      drm/i915: Correctly handle limited range YCbCr data on VLV/CHV

Vlastimil Babka (1):
      mm, slab: reschedule cache_reap() on the same CPU

Yavuz, Tuba (1):
      USB: gadget: f_midi: fixing a possible double-free in f_midi

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlre9vcACgkQONu9yGCS
aT4L+xAAg5YmfHMTlL7vR2E89h6iixBypX1a25a2jwEM1/HuPWvWh1qRgBX8MphH
FcoSl+I47hfnzn7RfJgLWJBDdTBjDViNx9s4QjWlk306QfNnO8TcXyV3mY2CK6Ca
2lE6u76Sc9fm8oPSYbfJspsphxoFSVVSHrsuitQyENFqw1kB9WDtP1y+KXOY0B1s
VTrEM9fzJ4XE3aWF4FK+bwiUOGgEPHIJFzbrabvcnYaDazrypwn2B+F0AyjrLLbo
0ObYg2PW7uKasE6OeKmOBp9neBVWvN/5KCVQigchOhT9jt3P9ImN+kfI+mvdeMf8
q8Qa6ecLoJJ27/zcveI77lbwRIrpDFRjuoMcKNwGGgBQ8aRugUcxk0NLLF5oR1Qo
GhGKagQGTDRmYKSjgbZPinImTIFatdT0Sgh5p+EAkTubsD24wOShr7MZyr4b4YRA
FtJ5F0u7hKQ6PHucbuCbPgfsQU+8ZKNfg1uzOVsgPMwyWqjlr7XbvCkGUIwAvOyJ
YsfO8tT1Rlz7Zgz/2n6BfmTbPACStQGeW4Ucv/XFGFD/Dv90GsvcoO/ahvn0sevE
qWQ+X0Dez19gJ6t8uVwFYQpdMM8r8ekM8M7CgsWvo1eP9OuvMyBLvy2vq6ACIR63
/6yOGVOCbQe4rXcUdt0xFTBOq2BkujR8ffOkYma0o3LFQKUP4IE=
=7OcL
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
