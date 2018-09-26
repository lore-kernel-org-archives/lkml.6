Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E0ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F425204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F425204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIZPDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:03:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:03:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 598C9108A;
        Wed, 26 Sep 2018 08:51:55 +0000 (UTC)
Date:   Wed, 26 Sep 2018 10:51:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.158
Message-ID: <20180926085152.GA11519@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.158 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                           |    2 -
 arch/arm/mach-exynos/suspend.c                     |    1=20
 arch/arm/mach-hisi/hotplug.c                       |   41 +++++++++++++---=
-----
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |    2 -
 arch/mips/ath79/setup.c                            |    1=20
 arch/mips/include/asm/mach-ath79/ath79.h           |    1=20
 arch/mips/jz4740/Platform                          |    2 -
 arch/mips/kernel/vdso.c                            |   20 ++++++++++
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c   |    2 -
 arch/powerpc/platforms/powernv/opal.c              |    2 -
 drivers/clk/imx/clk-imx6ul.c                       |    1=20
 drivers/crypto/sahara.c                            |    4 +-
 drivers/dma/pl330.c                                |    5 +-
 drivers/gpio/gpiolib.h                             |    2 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    2 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |   13 ++++++
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |    2 -
 drivers/hwtracing/coresight/coresight-tpiu.c       |    7 ++-
 drivers/hwtracing/coresight/coresight.c            |    7 ++-
 drivers/infiniband/core/cma.c                      |   12 +++---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    2 +
 drivers/iommu/arm-smmu-v3.c                        |    1=20
 drivers/media/v4l2-core/videobuf2-core.c           |    5 ++
 drivers/misc/hmc6352.c                             |    2 +
 drivers/misc/mei/bus-fixup.c                       |    2 -
 drivers/mtd/maps/solutionengine.c                  |    6 +--
 drivers/mtd/mtdchar.c                              |   10 +++--
 drivers/net/ethernet/ti/cpsw.c                     |   37 +++++++++++-----=
--
 drivers/net/xen-netfront.c                         |   30 +++++++--------
 drivers/parport/parport_sunbpp.c                   |    8 +++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |   32 ++++++++++++----
 drivers/platform/x86/toshiba_acpi.c                |    3 +
 drivers/rtc/rtc-bq4802.c                           |    4 ++
 drivers/s390/net/qeth_core_main.c                  |    3 +
 drivers/s390/net/qeth_core_sys.c                   |    1=20
 drivers/usb/class/cdc-wdm.c                        |    2 -
 drivers/usb/core/hcd-pci.c                         |    2 -
 drivers/usb/core/message.c                         |   11 +++++
 drivers/usb/core/quirks.c                          |    7 +++
 drivers/usb/gadget/udc/net2280.c                   |   16 +++++++-
 drivers/usb/host/u132-hcd.c                        |    2 -
 drivers/usb/misc/uss720.c                          |    4 +-
 drivers/usb/misc/yurex.c                           |    5 +-
 drivers/usb/serial/io_ti.h                         |    2 -
 drivers/usb/serial/ti_usb_3410_5052.h              |    2 -
 drivers/usb/storage/scsiglue.c                     |    9 ++++
 drivers/usb/storage/unusual_devs.h                 |    7 +++
 drivers/video/fbdev/core/modedb.c                  |   41 +++++++++++++++-=
-----
 drivers/video/fbdev/goldfishfb.c                   |    1=20
 drivers/video/fbdev/omap/omapfb_main.c             |    2 -
 drivers/video/fbdev/via/viafbdev.c                 |    3 +
 fs/binfmt_elf.c                                    |    2 -
 fs/cifs/readdir.c                                  |   11 ++++-
 fs/cifs/smb2pdu.c                                  |   25 +++++++-----
 fs/gfs2/bmap.c                                     |    2 -
 fs/pstore/ram_core.c                               |   17 +++++++-
 kernel/audit_watch.c                               |   12 +++++-
 net/mac80211/cfg.c                                 |    2 -
 net/mac80211/key.c                                 |   24 +++++++-----
 net/xfrm/xfrm_policy.c                             |    5 ++
 scripts/Kbuild.include                             |    3 +
 sound/core/pcm_lib.c                               |   14 +++++--
 sound/isa/msnd/msnd_pinnacle.c                     |    4 +-
 sound/usb/quirks-table.h                           |    3 +
 tools/hv/hv_kvp_daemon.c                           |    2 -
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   10 +++--
 tools/testing/selftests/timers/raw_skew.c          |    5 ++
 67 files changed, 382 insertions(+), 150 deletions(-)

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Alan Stern (1):
      USB: net2280: Fix erroneous synchronization change

Andreas Gruenbacher (1):
      gfs2: Special-case rindex for gfs2_grow

Andy Shevchenko (1):
      gpiolib: Mark gpio_suffixes array with __maybe_unused

Anton Vasilyev (1):
      video: goldfishfb: fix memory leak on driver remove

Ben Hutchings (1):
      USB: yurex: Fix buffer over-read in yurex_write()

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

Dan Carpenter (5):
      fbdev: omapfb: off by one in omapfb_register_client()
      cifs: prevent integer overflow in nxt_dir_entry()
      CIFS: fix wrapping bugs in num_entries()
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()
      mei: bus: type promotion bug in mei_nfc_if_version()

David Rivshin (1):
      drivers: net: cpsw: fix segfault in case of bad phy-handle

Douglas Anderson (1):
      pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant

Felix Fietkau (1):
      MIPS: ath79: fix system restart

Fredrik Noring (1):
      fbdev: Distinguish between interlaced and progressive modes

Greg Kroah-Hartman (1):
      Linux 4.4.158

Gustavo A. R. Silva (1):
      misc: hmc6352: fix potential Spectre v1

Hans Verkuil (1):
      media: videobuf2-core: check for q->error in vb2_core_qbuf()

Jann Horn (1):
      mtdchar: fix overflows in adjustment of `count`

Jia-Ju Bai (3):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_fr=
ame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
      usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstandin=
g_interrupt()

Johan Hovold (2):
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion hand=
ler

John Keeping (1):
      dmaengine: pl330: fix irq race with terminate_all

John Stultz (1):
      selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock =
adjustments are in progress

Juergen Gross (1):
      xen/netfront: fix waiting for xenbus state change

Julia Lawall (1):
      parport: sunbpp: fix error return code

Julian Wiedmann (2):
      s390/qeth: fix race in used-buffer accounting
      s390/qeth: reset layer2 attribute on layer switch

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Krzysztof Kozlowski (1):
      ARM: exynos: Clear global variable on init error path

Loic Poulain (1):
      arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Maciej W. Rozycki (1):
      binfmt_elf: Respect error return from `regset->active'

Manikanta Pubbisetty (1):
      mac80211: restrict delayed tailroom needed decrement

Masahiro Yamada (1):
      kbuild: add .DELETE_ON_ERROR special target

Mathias Nyman (2):
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in usb_set_inte=
rface()

Maxence Dupr=E8s (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB con=
troller

Miao Zhong (1):
      iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Michael M=FCller (1):
      crypto: sharah - Unregister correct algorithms for SAHARA 3

Nicholas Mc Guire (4):
      clk: imx6ul: fix missing of_node_put()
      ARM: hisi: handle of_iomap and fix missing of_node_put
      ARM: hisi: fix error handling and missing of_node_put
      ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Piggin (1):
      powerpc/powernv: opal_put_chars partial write fix

Parav Pandit (1):
      RDMA/cma: Protect cma dev list with lock

Paul Burton (2):
      MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads
      MIPS: VDSO: Match data page cache colouring when D$ aliases

Paul Cercueil (1):
      MIPS: jz4740: Bump zload address

Randy Dunlap (3):
      mtd/maps: fix solutionengine.c printk format warnings
      fbdev/via: fix defined but not used warning
      platform/x86: toshiba_acpi: Fix defined but not used build warnings

Robin Murphy (1):
      coresight: tpiu: Fix disabling timeouts

Ronny Chevalier (1):
      audit: fix use-after-free in audit_add_watch

Sandipan Das (2):
      perf powerpc: Fix callchain ip filtering when return address is in a =
register
      perf powerpc: Fix callchain ip filtering

Suzuki K Poulose (1):
      coresight: Handle errors in finding input/output ports

Takashi Iwai (2):
      ALSA: msnd: Fix the default sample sizes
      ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Thierry Reding (1):
      drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Timo Wischer (1):
      ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Vitaly Kuznetsov (1):
      xen-netfront: fix queue name setting

Wei Lu (1):
      drm/amdkfd: Fix error codes in kfd_get_process

Xiao Liang (1):
      xen-netfront: fix warn message as irq device name has '/'

YueHaibing (1):
      xfrm: fix 'passing zero to ERR_PTR()' warning

Zhouyang Jia (1):
      rtc: bq4802: add error handling for devm_ioremap


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlurSKcACgkQONu9yGCS
aT6mVw/+KGUakcKgcsvSZB04SmZ3K5/VUAfY5veQwFM7Kxqc3rs/vKhp6/QX0bqg
Z93ms19noh/RkD3/WLmO0tiUTgcZHYZPTKsnL0V/VfhyPlA8D1nWgYPxXOB0ikL4
mJfU9f4admU6chlfGIuuiGroWlPrWgabpwv5XYQ8/d0rW73y8gGVMLgyAthsiKOY
JqQ6cV6BlDVpuFbsHXrsbf0zES+c5goEuToTo+B1c3tAVEt6MxunXV9IFADpYPBM
Xaa4j0hnrKFe9uisLiqU264F9wpTjHPCCtNL1BHT4fYZDvoKpNQl22MDQRmn9r3K
BnZ1orsZ5I17ClQRYa+pwECQNckQkscD82uGsXuOBr/AshNxwYfwFMasdXmusaPR
vijHexCwXSifPT/j8v3jpeFGw1i7ZhXFMRMMrvlYRskeB+pr/d4W38n8GHHIDBQ6
dAKiv17MH6bpd6l+6EwWdCY51AvsDaL3V/XTSZpc1U5fGNM2lWdvXBKWW8qFskoR
eNoNmvd2Zc+8HDe8klS+xpTVR7fcQhrjzIO4/ynXkZGIDnS8IItteMQHeHzfrDAt
OdHU8qAzymYjhCdTkkmmwVKvjC81PEF3lYsELkXF8Y1IOw5WhVNPLdO48M+KYIfT
9ACnTexhNLIM9WtsVGjiolADlhImslDKK54QQLx+hEeyyjjbKQQ=
=9aWs
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
