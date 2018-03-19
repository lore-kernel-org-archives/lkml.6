Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2355499-1521448100-2-6492145643421347518
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
    t=1521448099; b=JHpPwQ6S3nPqqt2Itnq/P65k2fpAjB7FxBhw+TMsSt7RTav
    GPbuq9xqQljv8Wmy+/XCHyvxJEj2IXdL8kLxDFY8zTA3cvoRD77GsS79RMUIwv7Q
    edbp58+S8cO947lVw7S1rw0kb/IQPMJVy+a9jCu0Mfa7bblfJ3IxzGN/zTtD0qBq
    VYdAFt4PyDL9O72zaJK/twIz0WJmqZ7NS/a1iiC0FGGhr0JhY8VFkNh4YR04ZKbI
    FzvB05sBjq+Hk0vCKQkjROYx6w/sRUMaLN2KVUIh+dfyWoExJbDr0mss7eaIkufF
    qzSSoOcP1xgItR2kL9LYttj3d7sangllFP442BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521448099; bh=DcC3TwO6JFwSFne5/PFemSCbVFmcRp1FBoGNYlVW1eA=; b=a
    BgciZP7hFdjNvRSf3HuimHSJ1/1Dg+tEJfKEc1NW3XULiUAOpZYH851sTwCBBsLs
    vD34eNbxB8wuY+uXafKPZ6HQP6Y8SEAbm6WB8cJ3qjyBeI8GqQCXGjP8HeIRZyuJ
    baYyDvgS8o7b4JTJ9d4BTUSO4ItJKRJWTXVCd5YPJcsWAx73YImvagPwj0OnZsPR
    m0yTEvHBbfUHtCbr87Zaq+o291B06elBIMFcKto4sTDpB0kgcLSDg3Njcec4rkzB
    iLlWMXkz3GYhBqZY/QWlzi7gebhmH4D6IPWL6OGMBxnACj9wZomSyWIsKIe9CyKr
    BGVGZkrBCTBDMCCYmSKtQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkgggtuggfshhpjeesghdtreertderjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvfedukeegnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkgggtuggfshhpjeesghdtreertderjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvfedukeegnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeCSI1w (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 04:27:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755285AbeCSI1G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 04:27:06 -0400
Date: Mon, 19 Mar 2018 09:27:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.11
Message-ID: <20180319082706.GA14925@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.11 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt |    3=20
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt   |    3=20
 Documentation/devicetree/bindings/serial/omap_serial.txt  |    1=20
 Documentation/devicetree/bindings/serial/rs485.txt        |    1=20
 Documentation/devicetree/bindings/usb/usb-xhci.txt        |    1=20
 Makefile                                                  |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                       |    2=20
 arch/arm/boot/dts/exynos4412-trats2.dts                   |    2=20
 arch/arm/boot/dts/omap3-n900.dts                          |    4=20
 arch/arm/boot/dts/r8a7791-koelsch.dts                     |   12 -
 arch/arm64/boot/dts/renesas/salvator-common.dtsi          |    1=20
 arch/powerpc/include/asm/code-patching.h                  |    1=20
 arch/powerpc/include/asm/kvm_book3s_64.h                  |   14 +
 arch/powerpc/kernel/entry_64.S                            |   10 -
 arch/powerpc/kernel/module_64.c                           |   12 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c                    |    2=20
 arch/powerpc/lib/code-patching.c                          |    5=20
 arch/x86/kernel/machine_kexec_64.c                        |    1=20
 arch/x86/kernel/module.c                                  |    1=20
 arch/x86/kvm/mmu.c                                        |   10 +
 arch/x86/kvm/svm.c                                        |    6=20
 arch/x86/tools/relocs.c                                   |    3=20
 crypto/ecc.c                                              |    2=20
 crypto/keywrap.c                                          |    4=20
 drivers/base/Kconfig                                      |    1=20
 drivers/char/agp/intel-gtt.c                              |    2=20
 drivers/clk/meson/gxbb.c                                  |    4=20
 drivers/clk/qcom/gcc-msm8916.c                            |    1=20
 drivers/clk/renesas/r8a77970-cpg-mssr.c                   |    1=20
 drivers/cpufreq/cpufreq.c                                 |    6=20
 drivers/crypto/caam/caamalg_qi.c                          |    6=20
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c              |    3=20
 drivers/crypto/chelsio/chcr_algo.c                        |    2=20
 drivers/dma-buf/dma-fence-array.c                         |   14 +
 drivers/dma/qcom/hidma_ll.c                               |    9 -
 drivers/gpio/gpiolib.c                                    |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                |    7=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                  |    7=20
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c                  |    4=20
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c                     |   14 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                 |   10 +
 drivers/gpu/drm/drm_edid.c                                |    9 -
 drivers/gpu/drm/drm_vblank.c                              |   12 -
 drivers/gpu/drm/etnaviv/Kconfig                           |    9 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                     |    8=20
 drivers/gpu/drm/i915/intel_guc_fw.c                       |    9 -
 drivers/gpu/drm/i915/intel_huc.c                          |   11 -
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c     |    2=20
 drivers/gpu/drm/sun4i/sun8i_mixer.h                       |    2=20
 drivers/hid/hid-elo.c                                     |    6=20
 drivers/hid/hid-multitouch.c                              |   17 +
 drivers/iio/adc/ina2xx-adc.c                              |   26 +-
 drivers/iio/health/max30102.c                             |   36 ++--
 drivers/infiniband/hw/mlx5/mr.c                           |    3=20
 drivers/leds/leds-pm8058.c                                |    2=20
 drivers/md/dm-mpath.c                                     |    5=20
 drivers/md/dm-raid.c                                      |   30 ++-
 drivers/media/platform/davinci/vpif_capture.c             |    2=20
 drivers/media/platform/vsp1/vsp1_drv.c                    |   16 +
 drivers/media/usb/cpia2/cpia2_v4l.c                       |    4=20
 drivers/mmc/core/mmc_test.c                               |   11 +
 drivers/mtd/nand/fsl_ifc_nand.c                           |    7=20
 drivers/mtd/nand/nand_base.c                              |    9 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |   10 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c              |    5=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c          |    5=20
 drivers/net/ieee802154/adf7242.c                          |    4=20
 drivers/net/ipvlan/ipvlan_core.c                          |    4=20
 drivers/net/veth.c                                        |    3=20
 drivers/net/virtio_net.c                                  |    9 -
 drivers/net/wireless/ath/ath10k/mac.c                     |   10 +
 drivers/net/wireless/ath/ath10k/wmi.h                     |    3=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c               |    4=20
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c            |    6=20
 drivers/net/wireless/mac80211_hwsim.c                     |   17 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c           |    6=20
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c                      |   22 ++
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c                  |    2=20
 drivers/power/supply/ab8500_charger.c                     |    6=20
 drivers/power/supply/sbs-manager.c                        |    2=20
 drivers/pwm/pwm-stmpe.c                                   |    2=20
 drivers/rtc/rtc-brcmstb-waketimer.c                       |   15 +
 drivers/scsi/lpfc/lpfc_nvme.c                             |   14 +
 drivers/scsi/lpfc/lpfc_nvmet.c                            |   11 +
 drivers/scsi/scsi_devinfo.c                               |    9 -
 drivers/scsi/scsi_dh.c                                    |    5=20
 drivers/scsi/sd_zbc.c                                     |   35 +--
 drivers/scsi/ses.c                                        |   11 -
 drivers/spi/spi-imx.c                                     |   11 -
 drivers/spi/spi-sun6i.c                                   |    2=20
 drivers/staging/android/ashmem.c                          |   15 -
 drivers/staging/comedi/drivers.c                          |    3=20
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c            |    8=20
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h            |   13 +
 drivers/staging/rtlwifi/rtl8822be/fw.c                    |    2=20
 drivers/tty/serial/8250/8250_pci.c                        |   11 +
 drivers/tty/serial/atmel_serial.c                         |    1=20
 drivers/tty/serial/earlycon.c                             |    3=20
 drivers/tty/serial/serial_core.c                          |    2=20
 drivers/tty/serial/sh-sci.c                               |    2=20
 drivers/usb/core/ledtrig-usbport.c                        |    8=20
 drivers/usb/core/message.c                                |    4=20
 drivers/usb/core/quirks.c                                 |    3=20
 drivers/usb/dwc3/core.c                                   |    2=20
 drivers/usb/gadget/function/f_fs.c                        |    1=20
 drivers/usb/host/xhci-pci.c                               |    3=20
 drivers/usb/host/xhci-rcar.c                              |    4=20
 drivers/usb/host/xhci.c                                   |    3=20
 drivers/usb/host/xhci.h                                   |   23 +-
 drivers/usb/mon/mon_text.c                                |  126 ++++++++-=
-----
 drivers/usb/storage/uas.c                                 |    2=20
 drivers/usb/storage/unusual_devs.h                        |    7=20
 drivers/usb/typec/fusb302/fusb302.c                       |   21 +-
 drivers/usb/usbip/vudc_sysfs.c                            |    8=20
 drivers/video/hdmi.c                                      |   51 +++--
 fs/btrfs/sysfs.c                                          |    8=20
 fs/btrfs/transaction.c                                    |   20 --
 fs/gfs2/bmap.c                                            |   77 +++-----
 fs/namei.c                                                |    3=20
 include/linux/dma-fence-array.h                           |    3=20
 include/linux/usb/quirks.h                                |    3=20
 kernel/bpf/verifier.c                                     |    2=20
 kernel/locking/locktorture.c                              |   76 ++++----
 kernel/sched/core.c                                       |    3=20
 kernel/sched/rt.c                                         |    2=20
 lib/usercopy.c                                            |    2=20
 net/mac80211/iface.c                                      |    2=20
 net/sched/sch_generic.c                                   |   28 ++-
 net/xfrm/xfrm_policy.c                                    |    2=20
 net/xfrm/xfrm_replay.c                                    |    3=20
 net/xfrm/xfrm_state.c                                     |    7=20
 security/integrity/ima/ima_appraise.c                     |    3=20
 sound/soc/codecs/rt5651.c                                 |    1=20
 sound/soc/codecs/sgtl5000.c                               |   11 +
 sound/soc/codecs/wm_adsp.c                                |   14 -
 sound/soc/nuc900/nuc900-ac97.c                            |    4=20
 sound/soc/sunxi/sun4i-i2s.c                               |    2=20
 tools/perf/arch/s390/annotate/instructions.c              |    3=20
 tools/perf/util/annotate.c                                |    8=20
 tools/perf/util/session.c                                 |    3=20
 tools/testing/selftests/firmware/fw_filesystem.sh         |    5=20
 tools/testing/selftests/rcutorture/bin/configinit.sh      |    2=20
 tools/usb/usbip/src/usbipd.c                              |    2=20
 143 files changed, 859 insertions(+), 438 deletions(-)

Adam Thomson (1):
      typec: tcpm: fusb302: Resolve out of order messaging events

Adiel Aloni (1):
      mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Adrian Hunter (1):
      mmc: mmc_test: Ensure command queue is disabled for testing

Alexei Starovoitov (1):
      bpf: fix stack state printing in verifier log

Alexey Khoroshilov (1):
      rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()

Andreas Gruenbacher (2):
      gfs2: Clean up {lookup,fillup}_metapath
      gfs2: Fixes to "Implement iomap for block_map" (2)

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Anusha Srivatsa (1):
      drm/i915/glk: Disable Guc and HuC on GLK

Arnaldo Carvalho de Melo (1):
      perf report: Fix -D output for user metadata events

Arnd Bergmann (1):
      IB/mlx5: revisit -Wmaybe-uninitialized warning

Axel Lin (1):
      pwm: stmpe: Fix wrong register offset for hwpwm=3D2 case

Bart Van Assche (1):
      scsi: core: scsi_get_device_flags_keyed(): Always return device flags

Bartosz Golaszewski (1):
      gpiolib: don't allow OPEN_DRAIN & OPEN_SOURCE flags simultaneously

Ben Greear (1):
      ath10k: fix invalid STS_CAP_OFFSET_MASK

Bjorn Andersson (1):
      leds: pm8058: Silence pointer to integer size warning

Brijesh Singh (1):
      KVM: X86: Restart the guest when insn_len is zero and SEV is enabled

Chris Wilson (2):
      dma-buf/fence: Fix lock inversion within dma-fence-array
      agp/intel: Flush all chipset writes after updating the GGTT

Christian K=C3=B6nig (1):
      drm/amdgpu: fix amdgpu_sync_resv v2

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

Damien Le Moal (1):
      scsi: sd_zbc: Fix potential memory leak

Dan Carpenter (6):
      drm/panel: rpi-touchscreen: propagate errors in rpi_touchscreen_i2c_r=
ead()
      crypto: chelsio - Fix an error code in chcr_hash_dma_map()
      power: supply: sbs-message: double left shift bug in sbsm_select()
      bnxt_en: Uninitialized variable in bnxt_tc_parse_actions()
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

Geert Uytterhoeven (2):
      crypto: keywrap - Add missing ULL suffixes for 64-bit constants
      arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset

Greentime Hu (1):
      earlycon: add reg-offset to physical address before mapping

Greg Kroah-Hartman (2):
      Revert "btrfs: use proper endianness accessors for super_copy"
      Linux 4.15.11

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

Ioana Radulescu (1):
      staging: fsl-dpaa2/eth: Fix access to FAS field

Jagdish Gediya (1):
      mtd: nand: ifc: update bufnum mask for ver >=3D 2.0.0

James Smart (1):
      scsi: lpfc: Fix crash during driver unload with running nvme traffic

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

Lukas Wunner (1):
      dt-bindings: serial: Add common rs485 binding for RTS polarity

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

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Avoid shifts by negative amounts
      KVM: PPC: Book3S HV: Fix typo in kvmppc_hv_get_dirty_log_radix()

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

Sara Sharon (1):
      iwlwifi: mvm: avoid dumping assert log when device is stopped

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized in autoconfig

SeongJae Park (1):
      rcutorture/configinit: Fix build directory error message

Sergei Shtylyov (1):
      clk: renesas: r8a77970: Add LVDS clock

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

Trent Piepho (1):
      spi: imx: Fix failure path leak on GPIO request error correctly

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Ville Syrj=C3=A4l=C3=A4 (2):
      video/hdmi: Allow "empty" HDMI infoframes
      drm/vblank: Fix vblank timestamp debugs

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


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqvdFkACgkQONu9yGCS
aT7Tbg/8CdFoi9mIiqp8nJD39knm+PW+cFq7psKBtKVldnWaoT2L5oS8lhgH7IAN
qD+F4xS12bdfBfUL2tGHA1mLCk5uWTy4ME/S7UqynoMnonkiLw5ugbcq6CpSa2/p
tGaix4JGdMWTmyzObkyiUkoTha7vjXwf56ijQEwt5PcHs/ZiqnsV+iOSzgU1Sx5+
bbSLwMF/6OORDzSMRgA+RVKPB5RWhLtpO9MNoUpoQps3rdbIrLqmu7qn6WitvVOE
7su+ZqdW1CU0ODbI60jWEVA9kGvO25MEz1hrJb8VJPFDi2hnqedSgi3xq4c32XTh
qGcJXagd9zw5IoMl0U9Ty+8NbirEhp0OinS37oxuLXHK89Uu4haL578M+ggokLIV
xjB39nb0AApzEL4wPmTUppVxpi/bEgzBhv+mQ1d+rM1bilHXS6/twR/WDRMqtOhO
kNP9Y/cGE+xYp5MV6HFvCzJmUqj6iw5ulQRMpB96EWc32iLjy0xA5+g0U2lzhioT
tfF09+nTmCl91AwbwCs7+SecGMO73RZKULAULL8HJb4kxBfGYm5xYbFblZlr9UNc
rny9WkevkYtTrA9CuTCKIqMvCMuHehHJ8SFi62EvAa4l9aRMz710t35Rwde/wAUZ
e4agUBcl0difj0C1ONF1OGG1dfWe46Am+K1Aok2al60axVMtQ30=
=6usa
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
