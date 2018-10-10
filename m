Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B23DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A2F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWKWlNPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJJQd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJJQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:33:26 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FEB20645;
        Wed, 10 Oct 2018 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539162731;
        bh=zs3oOCIYv+WtQlAejOFFJUILDvdsotNrC8hUvg/d4J0=;
        h=Date:From:To:Cc:Subject:From;
        b=TWKWlNPvHZWU5R3ImfaRt5UC5jkAo6rCV9xujXXOesfX8wsAol+G8e30pURlcmwH1
         h/1E/pCVbx4fxl6KsnlWFxT7b1v05G9sO979KjsaDsls/li6oAzHMhQIikk6r9oAWg
         k4x4WBL917hFGyk5GZXPRML3g2M28l90BvOM5Hn4=
Date:   Wed, 10 Oct 2018 11:12:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.160
Message-ID: <20181010091208.GA2393@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.160 kernel.

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

 Documentation/hwmon/ina2xx                          |    2=20
 Makefile                                            |    2=20
 arch/arm/boot/dts/dra7.dtsi                         |    4 -
 arch/arm/mach-mvebu/pmsu.c                          |    6 -
 arch/arm64/include/asm/cpufeature.h                 |    8 +-
 arch/arm64/include/asm/jump_label.h                 |    4 -
 arch/arm64/include/asm/kvm_emulate.h                |    5 +
 arch/arm64/include/asm/sysreg.h                     |    1=20
 arch/arm64/kernel/cpufeature.c                      |    8 ++
 arch/arm64/kvm/guest.c                              |   55 ++++++++++++++-
 arch/hexagon/include/asm/bitops.h                   |    4 -
 arch/hexagon/kernel/dma.c                           |    2=20
 arch/powerpc/kernel/machine_kexec.c                 |    7 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c                 |    2=20
 arch/powerpc/platforms/powernv/pci-ioda.c           |    2=20
 arch/s390/mm/extmem.c                               |    4 -
 arch/x86/entry/entry_64.S                           |    4 -
 arch/x86/kernel/tsc_msr.c                           |    1=20
 arch/x86/mm/numa_emulation.c                        |    2=20
 crypto/ablkcipher.c                                 |    2=20
 crypto/blkcipher.c                                  |    1=20
 drivers/block/floppy.c                              |    3=20
 drivers/bluetooth/btusb.c                           |    1=20
 drivers/crypto/mxs-dcp.c                            |   53 ++++++++------
 drivers/edac/i7core_edac.c                          |   22 ++++--
 drivers/gpio/gpio-adp5588.c                         |   24 +++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm204.c |    3=20
 drivers/hid/hid-ntrig.c                             |    2=20
 drivers/hwmon/adt7475.c                             |   14 ++-
 drivers/hwmon/ina2xx.c                              |   13 +++
 drivers/i2c/busses/i2c-i801.c                       |    9 ++
 drivers/i2c/busses/i2c-uniphier-f.c                 |    7 -
 drivers/i2c/busses/i2c-uniphier.c                   |    7 -
 drivers/infiniband/core/ucma.c                      |    6 +
 drivers/infiniband/ulp/srp/ib_srp.c                 |    6 -
 drivers/input/mouse/elantech.c                      |    2=20
 drivers/md/dm-thin-metadata.c                       |   34 +++++++++
 drivers/md/dm-thin.c                                |   73 +++++++++++++++=
++---
 drivers/md/md-cluster.c                             |   19 ++---
 drivers/md/raid10.c                                 |    5 +
 drivers/media/i2c/soc_camera/ov772x.c               |    2=20
 drivers/media/platform/exynos4-is/fimc-isp-video.c  |   11 ++-
 drivers/media/platform/fsl-viu.c                    |   38 ++++++----
 drivers/media/platform/omap3isp/isp.c               |    2=20
 drivers/media/platform/s3c-camif/camif-capture.c    |    2=20
 drivers/media/usb/tm6000/tm6000-dvb.c               |    5 +
 drivers/media/usb/uvc/uvc_video.c                   |   24 ++++--
 drivers/media/v4l2-core/v4l2-event.c                |   37 +++++-----
 drivers/media/v4l2-core/v4l2-fh.c                   |    2=20
 drivers/misc/tsl2550.c                              |    2=20
 drivers/misc/vmw_vmci/vmci_queue_pair.c             |    4 -
 drivers/net/ethernet/cadence/macb.c                 |    2=20
 drivers/net/ethernet/hisilicon/hns/hnae.h           |    6 -
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c    |    7 +
 drivers/net/ethernet/realtek/r8169.c                |    9 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c            |    5 +
 drivers/net/wireless/mac80211_hwsim.c               |    3=20
 drivers/net/wireless/rndis_wlan.c                   |    2=20
 drivers/net/wireless/ti/wlcore/cmd.c                |    6 +
 drivers/power/reset/vexpress-poweroff.c             |   12 ++-
 drivers/s390/net/qeth_l2_main.c                     |    2=20
 drivers/s390/net/qeth_l3_main.c                     |    2=20
 drivers/scsi/bnx2i/bnx2i_hwi.c                      |    2=20
 drivers/scsi/ibmvscsi/ibmvscsi.c                    |    4 -
 drivers/spi/spi-rspi.c                              |   34 ++++++++-
 drivers/spi/spi-sh-msiof.c                          |   28 +++++++
 drivers/spi/spi-tegra20-slink.c                     |   31 ++++++--
 drivers/staging/android/ashmem.c                    |    6 +
 drivers/staging/rts5208/sd.c                        |    2=20
 drivers/target/iscsi/iscsi_target_auth.c            |   15 ----
 drivers/target/iscsi/iscsi_target_tpg.c             |    3=20
 drivers/thermal/of-thermal.c                        |    7 +
 drivers/tty/serial/8250/serial_cs.c                 |    6 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c         |   10 +-
 drivers/tty/serial/imx.c                            |    8 ++
 drivers/usb/class/cdc-wdm.c                         |    2=20
 drivers/usb/core/devio.c                            |   24 +++++-
 drivers/usb/core/driver.c                           |   28 +++----
 drivers/usb/core/usb.c                              |    2=20
 drivers/usb/gadget/udc/fotg210-udc.c                |   15 ++--
 drivers/usb/misc/yurex.c                            |    3=20
 drivers/usb/serial/kobil_sct.c                      |   12 ++-
 drivers/usb/wusbcore/security.c                     |    2=20
 drivers/uwb/hwa-rc.c                                |    1=20
 drivers/xen/cpu_hotplug.c                           |   15 ++--
 drivers/xen/events/events_base.c                    |    2=20
 drivers/xen/manage.c                                |    6 +
 fs/cifs/cifs_unicode.c                              |    3=20
 fs/cifs/cifssmb.c                                   |   11 ++-
 fs/cifs/misc.c                                      |    8 ++
 fs/cifs/smb2ops.c                                   |    2=20
 fs/ext4/xattr.c                                     |    5 +
 fs/nfsd/nfs4proc.c                                  |    1=20
 fs/ocfs2/dlm/dlmmaster.c                            |    4 -
 fs/proc/base.c                                      |   14 +++
 include/linux/platform_data/ina2xx.h                |    2=20
 include/linux/slub_def.h                            |    3=20
 include/media/v4l2-fh.h                             |    1=20
 kernel/module.c                                     |    6 +
 kernel/time/alarmtimer.c                            |    3=20
 lib/klist.c                                         |   10 +-
 mm/madvise.c                                        |    2=20
 mm/slub.c                                           |    6 -
 net/6lowpan/iphc.c                                  |    1=20
 net/mac80211/ibss.c                                 |   22 +++---
 net/mac80211/main.c                                 |   26 +++++--
 net/mac80211/mesh_hwmp.c                            |    4 +
 net/mac80211/mlme.c                                 |   53 ++++++++++++++
 net/wireless/nl80211.c                              |    1=20
 net/wireless/util.c                                 |    2=20
 sound/aoa/core/gpio-feature.c                       |    4 -
 sound/pci/hda/hda_intel.c                           |    3=20
 sound/pci/hda/patch_realtek.c                       |    1=20
 sound/soc/soc-dapm.c                                |    7 +
 tools/perf/arch/powerpc/util/sym-handling.c         |    4 -
 tools/vm/page-types.c                               |    6 -
 tools/vm/slabinfo.c                                 |    4 -
 117 files changed, 815 insertions(+), 286 deletions(-)

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Akinobu Mita (2):
      media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_pow=
er
      media: soc_camera: ov772x: correct setting of banding filter

Alan Stern (3):
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()
      USB: remove LPM management from usb_driver_claim_interface()

Alexey Dobriyan (1):
      slub: make ->cpu_partial unsigned int

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size

Alexey Khoroshilov (1):
      media: fsl-viu: fix error handling in viu_of_probe()

Alistair Strachan (1):
      staging: android: ashmem: Fix mmap size validation

Andy Shevchenko (1):
      x86/tsc: Add missing header to tsc_msr.c

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is dis=
abled

Anton Vasilyev (2):
      uwb: hwa-rc: fix memory leak at probe
      usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Bart Van Assche (3):
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the outpu=
t buffer size
      scsi: klist: Make it safe to use klists in atomic context
      IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Ben Greear (1):
      ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

Ben Hutchings (1):
      USB: yurex: Check for truncation in yurex_read()

Ben Skeggs (1):
      drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VB=
IOS

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Breno Leitao (1):
      scsi: ibmvscsi: Improve strings handling

Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Colin Ian King (1):
      staging: rts5208: fix missing error check on call to rtsx_write_regis=
ter

Dan Carpenter (5):
      vmci: type promotion bug in qp_host_get_user_memory()
      rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
      hwmon: (adt7475) Make adt7475_read_word() return errors
      cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()
      cifs: read overflow in is_valid_oplock_break()

Dan Williams (1):
      x86/numa_emulation: Fix emulated-to-physical node mapping

Danek Duvall (2):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
      mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

Emmanuel Grumbach (2):
      mac80211: fix a race between restart and CSA flows
      mac80211: shorten the IBSS debug messages

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Geert Uytterhoeven (2):
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Greg Kroah-Hartman (1):
      Linux 4.4.160

Guoqing Jiang (1):
      md-cluster: clear another node's suspend_area after the copy is finis=
hed

Hari Bathini (1):
      powerpc/kdump: Handle crashkernel memory reservation failure

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Huazhong Tan (1):
      net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_P=
AGES

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

J. Bruce Fields (1):
      nfsd: fix corrupted reply to badly ordered compound

Jan Beulich (1):
      x86/entry/64: Add two more instruction suffixes

Jann Horn (2):
      RDMA/ucma: check fd type in ucma_migrate_id()
      proc: restrict kernel stack dumps to root

Javier Martinez Canillas (1):
      media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data

Jessica Yu (1):
      module: exclude SHN_UNDEF symbols from kallsyms api

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Jian-Hong Pan (1):
      Bluetooth: Add a new Realtek 8723DE ID 0bda:b009

Joe Thornber (1):
      dm thin metadata: try to avoid ever aborting transactions

Johan Hovold (2):
      USB: serial: kobil_sct: fix modem-status error handling
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove

Jon Kuhn (1):
      fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Julia Lawall (1):
      usb: wusbcore: security: cast sizeof to int for comparison

Julian Wiedmann (1):
      s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng (3):
      ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENAB=
LED
      ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Kevin Hilman (1):
      ARM: dts: dra7: fix DCAN node addresses

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Liam Girdwood (1):
      ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Lothar Felten (1):
      hwmon: (ina2xx) fix sysfs shunt resistor read access

Marc Zyngier (1):
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

Masahiro Yamada (2):
      i2c: uniphier: issue STOP only for last message or I2C_M_STOP
      i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Matt Ranostay (1):
      tsl2550: fix lux1_input error in low light

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Michael Scott (1):
      6lowpan: iphc: reset mac_header after decompress to fix panic

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Mika Westerberg (1):
      i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Mike Snitzer (1):
      dm thin metadata: fix __udivdi3 undefined on 32-bit

Naoya Horiguchi (2):
      tools/vm/slabinfo.c: fix sign-compare warning
      tools/vm/page-types.c: fix "defined but not used" warning

Nicholas Mc Guire (1):
      ALSA: snd-aoa: add of_node_put() in error path

Olaf Hering (1):
      xen: avoid crash in disable_hotplug_cpu

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Randy Dunlap (2):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int

Sakari Ailus (1):
      media: v4l: event: Prevent freeing event subscriptions while accessed

Sandipan Das (1):
      perf probe powerpc: Ignore SyS symbols irrespective of endianness

Sebastian Andrzej Siewior (1):
      Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_ou=
tstanding_interrupt()"

Stafford Horne (1):
      crypto: skcipher - Fix -Wstringop-truncation warnings

Stephen Rothwell (1):
      fs/cifs: suppress a string overflow warning

Sudeep Holla (1):
      power: vexpress: fix corruption in notifier registration

Suzuki K Poulose (1):
      arm64: cpufeature: Track 32bit EL0 support

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_tr=
y_fmt()

Theodore Ts'o (1):
      ext4: never move the system.data xattr out of the inode body

Thomas Gleixner (1):
      alarmtimer: Prevent overflow for relative nanosleep

Tony Lindgren (1):
      wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Uwe Kleine-K=F6nig (1):
      serial: imx: restore handshaking irq for imx1

Vasily Gorbik (1):
      s390/extmem: fix gcc 8 stringop-overflow warning

Vincent Pelletier (1):
      scsi: target: iscsi: Use bin2hex instead of a re-implementation

Vitaly Kuznetsov (1):
      xen/manage: don't complain about an empty value in control/sysrq node

Xiao Ni (1):
      RAID10 BUG_ON in raise_barrier when force is true and conf->barrier i=
s 0

Yuan-Chi Pang (1):
      mac80211: mesh: fix HWMP sequence numbering to follow standard

Zhouyang Jia (4):
      drivers/tty: add error handling for pcmcia_loop_config
      media: tm6000: add error handling for dvb_register_adapter
      HID: hid-ntrig: add error handling for sysfs_create_group
      scsi: bnx2i: add error handling for ioremap_nocache

ming_qian (1):
      media: uvcvideo: Support realtek's UVC 1.5 device


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu9wmYACgkQONu9yGCS
aT5Wpw/+OaElW1puraJhLOzkJ8fIwGGyZNDKCx5q3Po3PgDDXA86LPH/994tt2vA
DMwA+vgRyzOcxjK+XIs0k8oItZztDFdd8esw+LPt0rmgsbBGzld5ssHNeVgWYyVX
PTzJKmY0DylMlcME8+wFW70GjPgd/Cl6Q1pgQaQ30jEEjZJ5HHXiey6h0be+ZbS3
stRHEPSL3r5tYlDg8KDyL1YlmT0H+e7pzhS4XOTLUTcbkG8Kwm8S6coDnzl+cr77
LIsyILRtSylsC1EGGkb2CZr1MUQigIkUKG7C/tvMQbNRImmJ6Dww2qKuxWpnOm6W
q62c7Ls17f+Y+gbkokCLcsJmwCNdZmEzVAZwRjYb85r4DfXqJ3ebIzMHNQMqzVCQ
a0gsi5xm7SRVnRVe92WezrsrazqacF52HUnjF0lERdoOHPkuuSTD9z1IlyfwBOjT
w4kmLbGsh7HESXHtqJalbx8tfR4AtwCPZDD4VVkOgyKPyy93ktjcHz5qTqy2BXOH
bvFtnZe39DvIOsU81MpTsCLjuTPhsr9DE6lHGcVPe9P0AaE8aUx63I7HYtsdhd3D
SthKwhJCQfrMc6RGOC7vZhoRAvHxZyUjgRbfJ+PQDyMOwhxPEOTaKpn+kUCEX5Mz
WKZxaPq45AInWb+Ah67eObMr0lSh0xRavp5L5uZdbyEAGgLlJfI=
=xx6T
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
