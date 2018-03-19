Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2356021-1521448017-2-6218114113955315787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521448016; b=MRCU/nk8+t69l1A9hPkl/mZnw2mvISuCIG0Aryi5qRFkADq
    CQCgjKvwVMRgE1jBtv6u3KvArEm1bH6r4TxyyS0nTlaGoHO3Wq1g2x92CLRwKjR1
    sTtZmHDVdrMIUGr9CxCimynhZ00heBOmoSRetfLQ2fxC9JSwQHSUOSdhRKo0WP0k
    Ztvc/n1aPyDGShIYv7wdYA9yT3wlzHXJkHZZJ2XhmFBiX0bgQ/xtteau8dcXe0oR
    bDppc1EvtzE+WHMqJGihN/1w8vZKN3NYh2/sppxLJwT5Di4tTQUC+Au57G180q8p
    XP8H06YiBXKRt6609joKBuZO8TzzCHo+U6JK36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521448016; bh=JlNwqMal+0sqsSOaxjZNpBgr3JunQfDewlW3axEvO4A=; b=c
    +aj2pfBtCAcPoyPezZJDB/sRieivOoS6190YoTS5p0XCv7MRp2JT8x8deyrPpM3n
    9J7MEVzDq3RenfBCLU15CtHW9qxvWo618jzbE3iN5xJQ5YKmf9BWMebJU/YHc+S2
    YHwrfC8UYG5md1vaGvsebkIzRGk8wXX3IEp1dW/Qkt89qUdQVvt0m0+QXdAEVogJ
    56tAkjSQOrp2DzcJpADVyP1BcHXgnfX3HmN6UKqfHCkjczcJZW9ffbZl6NiPf0Iq
    c/AcEvjmVaxXTDPLjBlSIRVb7dBmgqZB/rj9/JUJsK26fTi8Phlhys6DGMAqRApd
    OBWfX2r7o5fnj9oSW43cg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkgggtuggfshhpjeesghdtreertderjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduleehtdelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkgggtuggfshhpjeesghdtreertderjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduleehtdelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeCSI0x (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 04:26:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbeCSI0m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 04:26:42 -0400
Date: Mon, 19 Mar 2018 09:26:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.28
Message-ID: <20180319082641.GA13742@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.28 kernel.

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

 Documentation/devicetree/bindings/usb/usb-xhci.txt   |    1=20
 Makefile                                             |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                  |    2=20
 arch/arm/boot/dts/exynos4412-trats2.dts              |    2=20
 arch/arm/boot/dts/omap3-n900.dts                     |    4=20
 arch/arm/boot/dts/r8a7791-koelsch.dts                |   12 -
 arch/arm64/boot/dts/renesas/salvator-common.dtsi     |    1=20
 arch/powerpc/include/asm/code-patching.h             |    1=20
 arch/powerpc/kernel/entry_64.S                       |   10 +
 arch/powerpc/kernel/module_64.c                      |   12 +
 arch/powerpc/lib/code-patching.c                     |    5=20
 arch/x86/kernel/machine_kexec_64.c                   |    1=20
 arch/x86/kernel/module.c                             |    1=20
 arch/x86/tools/relocs.c                              |    3=20
 crypto/ecc.c                                         |    2=20
 drivers/base/Kconfig                                 |    1=20
 drivers/char/agp/intel-gtt.c                         |    2=20
 drivers/clk/meson/gxbb.c                             |    4=20
 drivers/clk/qcom/gcc-msm8916.c                       |    1=20
 drivers/cpufreq/cpufreq.c                            |    6=20
 drivers/crypto/caam/caamalg_qi.c                     |    6=20
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c         |    3=20
 drivers/dma-buf/dma-fence-array.c                    |   14 +-
 drivers/dma/qcom/hidma_ll.c                          |    9 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c           |    7 -
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c             |    4=20
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c                |   14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c            |   10 +
 drivers/gpu/drm/drm_edid.c                           |    9 +
 drivers/gpu/drm/etnaviv/Kconfig                      |    9 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                |    8 -
 drivers/gpu/drm/i915/intel_guc_loader.c              |    9 -
 drivers/gpu/drm/i915/intel_huc.c                     |   11 -
 drivers/gpu/drm/sun4i/sun8i_mixer.h                  |    2=20
 drivers/hid/hid-elo.c                                |    6=20
 drivers/hid/hid-multitouch.c                         |   17 ++
 drivers/iio/adc/ina2xx-adc.c                         |   26 ++-
 drivers/iio/health/max30102.c                        |   36 +++--
 drivers/infiniband/hw/mlx5/mr.c                      |    3=20
 drivers/leds/leds-pm8058.c                           |    2=20
 drivers/md/dm-mpath.c                                |    5=20
 drivers/md/dm-raid.c                                 |   30 +++-
 drivers/media/platform/davinci/vpif_capture.c        |    2=20
 drivers/media/platform/vsp1/vsp1_drv.c               |   16 ++
 drivers/media/usb/cpia2/cpia2_v4l.c                  |    4=20
 drivers/mmc/core/mmc_test.c                          |   11 +
 drivers/mtd/nand/fsl_ifc_nand.c                      |    7 +
 drivers/mtd/nand/nand_base.c                         |    9 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c            |   10 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c     |    5=20
 drivers/net/ieee802154/adf7242.c                     |    4=20
 drivers/net/ipvlan/ipvlan_core.c                     |    4=20
 drivers/net/phy/at803x.c                             |    4=20
 drivers/net/phy/phy.c                                |    9 -
 drivers/net/phy/phy_device.c                         |   20 ++-
 drivers/net/veth.c                                   |    3=20
 drivers/net/virtio_net.c                             |    9 -
 drivers/net/wireless/ath/ath10k/mac.c                |   10 +
 drivers/net/wireless/ath/ath10k/wmi.h                |    3=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c          |    4=20
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c       |    6=20
 drivers/net/wireless/mac80211_hwsim.c                |   17 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c      |    6=20
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c                 |   22 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c             |    2=20
 drivers/power/supply/ab8500_charger.c                |    6=20
 drivers/pwm/pwm-stmpe.c                              |    2=20
 drivers/rtc/rtc-brcmstb-waketimer.c                  |   15 +-
 drivers/scsi/scsi_devinfo.c                          |    9 -
 drivers/scsi/scsi_dh.c                               |    5=20
 drivers/scsi/ses.c                                   |   11 +
 drivers/spi/spi-sun6i.c                              |    2=20
 drivers/staging/android/ashmem.c                     |   15 +-
 drivers/staging/comedi/drivers.c                     |    3=20
 drivers/staging/rtlwifi/rtl8822be/fw.c               |    2=20
 drivers/staging/typec/fusb302/fusb302.c              |   21 ++-
 drivers/tty/serial/8250/8250_pci.c                   |   11 +
 drivers/tty/serial/atmel_serial.c                    |    1=20
 drivers/tty/serial/earlycon.c                        |    3=20
 drivers/tty/serial/serial_core.c                     |    2=20
 drivers/tty/serial/sh-sci.c                          |    2=20
 drivers/usb/core/ledtrig-usbport.c                   |    8 +
 drivers/usb/core/message.c                           |    4=20
 drivers/usb/core/quirks.c                            |    3=20
 drivers/usb/dwc3/core.c                              |    2=20
 drivers/usb/gadget/function/f_fs.c                   |    1=20
 drivers/usb/host/xhci-pci.c                          |    3=20
 drivers/usb/host/xhci-rcar.c                         |    4=20
 drivers/usb/host/xhci.c                              |    3=20
 drivers/usb/host/xhci.h                              |   23 +--
 drivers/usb/mon/mon_text.c                           |  126 +++++++++++---=
-----
 drivers/usb/storage/uas.c                            |    2=20
 drivers/usb/storage/unusual_devs.h                   |    7 +
 drivers/usb/usbip/vudc_sysfs.c                       |    8 -
 drivers/video/hdmi.c                                 |   51 ++++---
 fs/btrfs/sysfs.c                                     |    8 -
 fs/btrfs/transaction.c                               |   20 +--
 fs/namei.c                                           |    3=20
 include/linux/dma-fence-array.h                      |    3=20
 include/linux/phy.h                                  |    1=20
 include/linux/usb/quirks.h                           |    3=20
 kernel/locking/locktorture.c                         |   76 ++++++-----
 kernel/sched/core.c                                  |    3=20
 kernel/sched/rt.c                                    |    2=20
 lib/usercopy.c                                       |    2=20
 net/mac80211/iface.c                                 |    2=20
 net/sched/sch_generic.c                              |   28 ++--
 net/xfrm/xfrm_policy.c                               |    2=20
 net/xfrm/xfrm_replay.c                               |    3=20
 net/xfrm/xfrm_state.c                                |    7 +
 security/integrity/ima/ima_appraise.c                |    3=20
 sound/soc/codecs/rt5651.c                            |    1=20
 sound/soc/codecs/sgtl5000.c                          |   11 +
 sound/soc/codecs/wm_adsp.c                           |   14 +-
 sound/soc/nuc900/nuc900-ac97.c                       |    4=20
 sound/soc/sunxi/sun4i-i2s.c                          |    2=20
 tools/perf/arch/s390/annotate/instructions.c         |    3=20
 tools/perf/util/annotate.c                           |    8 -
 tools/testing/selftests/firmware/fw_filesystem.sh    |    5=20
 tools/testing/selftests/rcutorture/bin/configinit.sh |    2=20
 tools/usb/usbip/src/usbipd.c                         |    2=20
 121 files changed, 732 insertions(+), 341 deletions(-)

Adam Thomson (1):
      typec: tcpm: fusb302: Resolve out of order messaging events

Adiel Aloni (1):
      mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Adrian Hunter (1):
      mmc: mmc_test: Ensure command queue is disabled for testing

Alexey Khoroshilov (1):
      rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew Lunn (1):
      net: phy: Restore phy_resume() locking assumption

Anusha Srivatsa (1):
      drm/i915/glk: Disable Guc and HuC on GLK

Arnd Bergmann (1):
      IB/mlx5: revisit -Wmaybe-uninitialized warning

Axel Lin (1):
      pwm: stmpe: Fix wrong register offset for hwpwm=3D2 case

Bart Van Assche (1):
      scsi: core: scsi_get_device_flags_keyed(): Always return device flags

Ben Greear (1):
      ath10k: fix invalid STS_CAP_OFFSET_MASK

Bjorn Andersson (1):
      leds: pm8058: Silence pointer to integer size warning

Chris Wilson (2):
      dma-buf/fence: Fix lock inversion within dma-fence-array
      agp/intel: Flush all chipset writes after updating the GGTT

Christophe JAILLET (2):
      power: supply: ab8500_charger: Fix an error handling path
      power: supply: ab8500_charger: Bail out in case of error in 'ab8500_c=
harger_init_hw_registers()'

Christophe Leroy (1):
      Fix misannotated out-of-line _copy_to_user()

Colin Ian King (3):
      usbip: vudc: fix null pointer dereference on udc->lock
      staging: rtl8822be: fix missing null check on dev_alloc_skb return
      crypto: cavium - fix memory leak on info

Dan Carpenter (2):
      media: cpia2: Fix a couple off by one bugs
      ASoC: nuc900: Fix a loop timeout test

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

Davidlohr Bueso (1):
      locking/locktorture: Fix num reader/writer corner cases

Emmanuel Grumbach (1):
      iwlwifi: mvm: rs: don't override the rate history in the search cycle

Eric W. Biederman (1):
      userns: Don't fail follow_automount based on s_user_ns

Fabio Estevam (1):
      ASoC: sgtl5000: Fix suspend/resume

Fabrizio Castro (1):
      pinctrl: sh-pfc: r8a7791: Add can_clk function

Felix Kuehling (1):
      drm/amdgpu: fix get_max_engine_clock_in_mhz

Frank Mori Hess (1):
      staging: comedi: fix comedi_nsamples_left.

Geert Uytterhoeven (1):
      arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset

Greentime Hu (1):
      earlycon: add reg-offset to physical address before mapping

Greg Kroah-Hartman (2):
      Revert "btrfs: use proper endianness accessors for super_copy"
      Linux 4.14.28

Gustavo A. R. Silva (1):
      media: davinci: vpif_capture: add NULL check on devm_kzalloc return v=
alue

H.J. Lu (1):
      x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Hans de Goede (2):
      ASoC: rt5651: Fix regcache sync errors on resume
      HID: multitouch: Only look at non touch fields in first packet of a f=
rame

Heinz Mauelshagen (1):
      dm raid: fix raid set size revalidation

Horia Geant=C4=83 (1):
      crypto: caam/qi - use correct print specifier for size_t

Jagdish Gediya (1):
      mtd: nand: ifc: update bufnum mask for ver >=3D 2.0.0

Jani Nikula (1):
      drm/edid: set ELD connector type in drm_edid_to_eld()

Jernej Skrabec (1):
      drm/sun4i: Fix format mask in DE2 driver

Jiri Kosina (1):
      HID: elo: clear BTN_LEFT mapping

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek

Johan Hovold (1):
      USB: ledtrig-usbport: fix of-node leak

John Fastabend (1):
      net: sched: drop qdisc_reset from dev_graft_qdisc

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Josh Poimboeuf (1):
      powerpc/modules: Don't try to restore r2 after a sibling call

Julien BOIBESSOT (1):
      tools/usbip: fixes build with musl libc toolchain

Kai-Heng Feng (1):
      xhci: Fix front USB ports on ASUS PRIME B350M-A

Kieran Bingham (1):
      media: vsp1: Prevent suspending and resuming DRM pipelines

Li Dongyang (1):
      scsi: ses: don't ask for diagnostic pages repeatedly during probe

Limin Zhu (1):
      mwifiex: cfg80211: do not change virtual interface during scan proces=
sing

Lorenzo Colitti (1):
      net: xfrm: allow clearing socket xfrm policies.

Luca Coelho (1):
      mac80211: remove BUG() when interface type is invalid

Luis R. Rodriguez (1):
      test_firmware: fix setting old custom fw path back on exit

Mahesh Bandewar (1):
      ipvlan: add L2 check for packets arriving via virtual devices

Manikanta Pubbisetty (1):
      ath10k: update tdls teardown state to target

Mathias Nyman (1):
      xhci: fix endpoint context tracer output

Michael Chan (1):
      bnxt_en: Don't print "Link speed -1 no longer supported" messages.

Michael Hennerich (1):
      net: ieee802154: adf7242: Fix bug if defined DEBUG

Mimi Zohar (1):
      ima: relax requiring a file signature for new files with zero length

Miquel Raynal (1):
      mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()

Monk Liu (2):
      drm/amdgpu:fix random missing of FLR NOTIFY
      drm/amdgpu:fix virtual dce bug

Nicholas Piggin (1):
      powerpc/64: Don't trace irqs-off at interrupt return to soft-disabled=
 context

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Oliver Neukum (1):
      uas: fix comparison for error code

Paul E. McKenney (2):
      sched: Stop switched_to_rt() from sending IPIs to offline CPUs
      sched: Stop resched_cpu() from sending IPIs to offline CPUs

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Peter Meerwald-Stadler (1):
      iio: health: max30102: Add power enable parameter to get_temp function

Philipp Zabel (1):
      drm/etnaviv: make THERMAL selectable

Pierre (1):
      crypto: ecc - Fix NULL pointer deref. on no default_rng

Rafael J. Wysocki (1):
      cpufreq: Fix governor module removal race

Richard Fitzgerald (1):
      ASoC: wm_adsp: For TLV controls only register TLV get/set

Roger Quadros (1):
      usb: dwc3: Fix lock-up on ID change during system suspend/resume

Russell King (1):
      net: phy: fix resume handling

Sara Sharon (1):
      iwlwifi: mvm: avoid dumping assert log when device is stopped

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized in autoconfig

SeongJae Park (1):
      rcutorture/configinit: Fix build directory error message

Simon Horman (1):
      ARM: dts: koelsch: Move cec_clock to root node

Simon Shields (1):
      ARM: dts: exynos: Correct Trats2 panel reset line

Sinan Kaya (1):
      dmaengine: qcom_hidma: check pending interrupts

Srinivas Kandagatla (1):
      clk: qcom: msm8916: fix mnd_width for codec_digcodec

Stefan Br=C3=BCns (1):
      iio: adc: ina2xx: Shift bus voltage register to mask flag bits

Steffen Maier (1):
      dm mpath: fix passing integrity data

Stephen Hemminger (1):
      veth: set peer GSO values

Sunil Goutham (1):
      net: thunderx: Set max queue count taking XDP_TX into account

Takeshi Kihara (1):
      pinctrl: sh-pfc: r8a7795-es1: Fix MOD_SEL1 bit[25:24] to 0x3 when usi=
ng STP_ISEN_1_D

Teijo Kinnunen (1):
      USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Thomas Richter (2):
      perf annotate: Fix unnecessary memory allocation for s390x
      perf annotate: Fix objdump comment parsing for Intel mov dissassembly

Tobias Jordan (1):
      spi: sun6i: disable/unprepare clocks on remove

Toshiaki Makita (1):
      virtio_net: Disable interrupts if napi_complete_done rescheduled napi

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Ville Syrj=C3=A4l=C3=A4 (1):
      video/hdmi: Allow "empty" HDMI infoframes

Xinyong (1):
      usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Xose Vazquez Perez (2):
      scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
      scsi: dh: add new rdac devices

Yixun Lan (1):
      clk: meson: gxbb: fix wrong clock for SARADC/SANA

Yong Deng (1):
      ASoC: sun4i-i2s: Fix RX slot number of SUN8I

Yong Zhao (1):
      drm/amdkfd: Fix memory leaks in kfd topology

Yoshihiro Shimoda (1):
      usb: host: xhci-rcar: add support for r8a77965

Yossef Efraim (1):
      xfrm: Fix xfrm_replay_overflow_offload_esn


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqvdEAACgkQONu9yGCS
aT4u5w//RmVRee9n+HcgEu3wPy0ZRxwmnAcV3fwZH7ddq8DOyhS87nHhRnt5KdSR
3HAkQZHHoUEEHuB5ooKpItYEcbz1kWoqVJAb82dxNBy5QxV1V7EtDxA+Jkm3nsrV
ipsIVHPMxHcvpK6q2Wd2SGPgrO1CMCRdZv0TkTOGxykvqNSWqA8fDqorWLdjrYRG
OTwEdVTrO32z3M6TdV+K2nNpFANcGTAGSx3mOuOW/H7a45W12ntnykkniXwHy7J+
9zzHrCUP5Md3ZMJLu27zgFqNcMRjHoaFAZwT7IQf/XqkPr4tG4Jd6/o9wWZcOGnC
kLuMx3nBnrlg+8koE/e3A04Lz55g4XfogAce8MTzc16tpsf2So4ofqLGMc+17qra
YpZuSxUmfoGiL54OgCVOIsz88cy5SKvJQzKC8oCixOVHu1sFjO0U2oqTboJIgXhM
0Is5MYSv/efuNg8w4KpDdhr+73Q8p6fJmZVeYePJpLx3+YWuSoaSEoOJgqZ9flqR
H5lSsHAE4KtpzCs8aBwUbiItGM3dLHFe7r6U7DbGRFPcAI4Sdhn/ekbK1ppz+ikx
0uKDMmEuhmeU79YMwoauHGGmMfRAR45GQ955lX3Wo5O0kt9oRWF7RDuxzoU7zWJ4
V6irQv9g4yDfK9SwTRcDzQwrX7qhyzj0VYkrlsXnIFuBT7bzcKc=
=DBVU
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
