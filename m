Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B3C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694F721A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694F721A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbeHFRQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:16:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbeHFRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:16:42 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2896FC8A;
        Mon,  6 Aug 2018 15:07:09 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:07:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.146
Message-ID: <20180806150707.GA12139@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.146 kernel.

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

 Makefile                                            |    2=20
 arch/microblaze/boot/Makefile                       |   10 ++--
 arch/mips/include/asm/pci.h                         |    2=20
 arch/powerpc/kernel/head_8xx.S                      |    2=20
 arch/powerpc/kernel/pci_32.c                        |    1=20
 arch/powerpc/mm/slb.c                               |    8 +--
 arch/powerpc/platforms/chrp/time.c                  |    6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c       |    5 ++
 arch/powerpc/platforms/powermac/bootx_init.c        |    4 +
 arch/powerpc/platforms/powermac/setup.c             |    1=20
 arch/s390/include/asm/cpu_mf.h                      |    6 +-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c       |    2=20
 arch/x86/kernel/cpu/perf_event_intel_uncore_nhmex.c |    2=20
 arch/x86/kvm/vmx.c                                  |    7 +-
 crypto/authenc.c                                    |    1=20
 crypto/authencesn.c                                 |    1=20
 drivers/acpi/pci_root.c                             |    4 +
 drivers/ata/libata-eh.c                             |   12 +++--
 drivers/bluetooth/btusb.c                           |    3 +
 drivers/bluetooth/hci_qca.c                         |    2=20
 drivers/char/random.c                               |   10 +++-
 drivers/crypto/padlock-aes.c                        |    8 ++-
 drivers/dma/pxa_dma.c                               |    2=20
 drivers/gpu/drm/drm_atomic.c                        |    4 +
 drivers/gpu/drm/gma500/psb_intel_drv.h              |    2=20
 drivers/gpu/drm/gma500/psb_intel_lvds.c             |    2=20
 drivers/gpu/drm/radeon/radeon_connectors.c          |   10 ++--
 drivers/hid/hid-plantronics.c                       |    6 ++
 drivers/hid/i2c-hid/i2c-hid.c                       |    8 +++
 drivers/infiniband/core/mad.c                       |   11 ++--
 drivers/infiniband/core/ucma.c                      |    6 ++
 drivers/input/mouse/elan_i2c_core.c                 |    2=20
 drivers/input/serio/i8042-x86ia64io.h               |    7 ++
 drivers/md/md.c                                     |    3 +
 drivers/media/common/siano/smsendian.c              |   14 ++---
 drivers/media/i2c/smiapp/smiapp-core.c              |   11 ++--
 drivers/media/pci/saa7164/saa7164-fw.c              |    3 -
 drivers/media/platform/omap3isp/isp.c               |    7 +-
 drivers/media/platform/rcar_jpu.c                   |    4 +
 drivers/media/radio/si470x/radio-si470x-i2c.c       |    6 +-
 drivers/media/v4l2-core/videobuf2-core.c            |    9 ++-
 drivers/memory/tegra/mc.c                           |   22 ++-------
 drivers/memory/tegra/mc.h                           |    9 +++
 drivers/memory/tegra/tegra114.c                     |    2=20
 drivers/memory/tegra/tegra124.c                     |    6 ++
 drivers/memory/tegra/tegra210.c                     |    3 +
 drivers/memory/tegra/tegra30.c                      |    2=20
 drivers/mfd/cros_ec.c                               |    6 ++
 drivers/mtd/nand/fsl_ifc_nand.c                     |   17 ++++---
 drivers/net/can/usb/ems_usb.c                       |    1=20
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c           |    4 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |    2=20
 drivers/net/usb/lan78xx.c                           |    2=20
 drivers/net/wireless/ath/regd.h                     |    5 ++
 drivers/net/wireless/ath/regd_common.h              |   13 +++++
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c    |    1=20
 drivers/net/wireless/iwlwifi/pcie/rx.c              |    2=20
 drivers/net/wireless/mwifiex/usb.c                  |    3 +
 drivers/net/wireless/mwifiex/util.c                 |    8 ++-
 drivers/net/wireless/rsi/rsi_91x_sdio.c             |    2=20
 drivers/net/wireless/ti/wlcore/sdio.c               |    5 ++
 drivers/net/xen-netfront.c                          |   10 +++-
 drivers/pci/pci-sysfs.c                             |   15 +++---
 drivers/pinctrl/pinctrl-at91-pio4.c                 |    4 +
 drivers/regulator/pfuze100-regulator.c              |    1=20
 drivers/rtc/interface.c                             |    5 ++
 drivers/scsi/3w-9xxx.c                              |    5 ++
 drivers/scsi/3w-xxxx.c                              |    3 +
 drivers/scsi/megaraid.c                             |    3 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c         |    3 +
 drivers/scsi/scsi_dh.c                              |    5 +-
 drivers/scsi/sg.c                                   |    1=20
 drivers/scsi/ufs/ufshcd.c                           |    2=20
 drivers/thermal/samsung/exynos_tmu.c                |    1=20
 drivers/tty/hvc/hvc_opal.c                          |    1=20
 drivers/tty/pty.c                                   |    3 +
 drivers/usb/core/hub.c                              |    4 +
 drivers/virtio/virtio_balloon.c                     |    2=20
 fs/btrfs/qgroup.c                                   |   19 +++++++
 fs/btrfs/tree-log.c                                 |   10 +++-
 fs/ext4/balloc.c                                    |    3 +
 fs/ext4/ialloc.c                                    |    3 +
 fs/ext4/inline.c                                    |   19 ++++---
 fs/ext4/inode.c                                     |   16 ++----
 fs/f2fs/segment.c                                   |    3 +
 fs/f2fs/super.c                                     |    6 ++
 fs/nfsd/nfs4xdr.c                                   |    2=20
 fs/squashfs/block.c                                 |    2=20
 fs/squashfs/cache.c                                 |    3 +
 fs/squashfs/file.c                                  |    8 ++-
 fs/squashfs/fragment.c                              |   17 ++++---
 fs/squashfs/squashfs_fs.h                           |    6 ++
 fs/squashfs/squashfs_fs_sb.h                        |    1=20
 fs/squashfs/super.c                                 |    5 +-
 include/drm/drm_dp_helper.h                         |    1=20
 include/linux/dma-iommu.h                           |    1=20
 include/linux/mmc/sdio_ids.h                        |    1=20
 include/linux/netfilter/ipset/ip_set_timeout.h      |   10 +++-
 include/net/tcp.h                                   |    2=20
 include/soc/tegra/mc.h                              |    2=20
 kernel/auditfilter.c                                |    2=20
 kernel/auditsc.c                                    |    2=20
 kernel/bpf/verifier.c                               |    4 -
 kernel/trace/trace_events_trigger.c                 |   18 +++++--
 kernel/trace/trace_kprobe.c                         |   15 +++++-
 mm/slub.c                                           |    2=20
 mm/vmalloc.c                                        |    3 -
 net/dsa/slave.c                                     |    6 ++
 net/ipv4/fib_frontend.c                             |    4 -
 net/ipv4/inet_fragment.c                            |   10 ++--
 net/ipv4/ipconfig.c                                 |   13 +++++
 net/ipv4/tcp_dctcp.c                                |    4 -
 net/ipv4/tcp_input.c                                |   48 ++++++++++-----=
-----
 net/netlink/af_netlink.c                            |    2=20
 net/socket.c                                        |    2=20
 sound/pci/emu10k1/emupcm.c                          |    4 +
 sound/pci/emu10k1/memory.c                          |    6 +-
 sound/pci/fm801.c                                   |   16 +++++-
 sound/pci/hda/patch_ca0132.c                        |    8 ++-
 sound/soc/pxa/brownstone.c                          |    1=20
 sound/soc/pxa/mioa701_wm9713.c                      |    1=20
 sound/soc/pxa/mmp-pcm.c                             |    1=20
 sound/soc/pxa/mmp-sspa.c                            |    1=20
 sound/soc/pxa/palm27x.c                             |    1=20
 sound/soc/pxa/pxa-ssp.c                             |    1=20
 sound/soc/pxa/pxa2xx-ac97.c                         |    1=20
 sound/soc/pxa/pxa2xx-pcm.c                          |    1=20
 sound/soc/soc-pcm.c                                 |    6 +-
 sound/usb/pcm.c                                     |    2=20
 tools/usb/usbip/src/usbip_detach.c                  |    9 ++-
 130 files changed, 526 insertions(+), 207 deletions(-)

Alexandre Belloni (1):
      rtc: ensure rtc_set_alarm fails when alarms are not supported

Anatoly Pugachev (1):
      disable loading f2fs module on PAGE_SIZE > 4KB

Andrea Adami (1):
      ASoC: pxa: Fix module autoload for platform drivers

Anson Huang (1):
      regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Anton Vasilyev (1):
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failu=
re

Bartlomiej Zolnierkiewicz (1):
      thermal: exynos: fix setting rising_threshold for Exynos5433

Brad Love (1):
      media: saa7164: Fix driver name in debug output

Chao Yu (1):
      f2fs: fix to don't trigger writeback during recovery

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Chintan Pandya (1):
      mm: vmalloc: avoid racy handling of debugobjects in vunmap

Chris Novakovic (1):
      ipconfig: Correctly initialise ic_nameservers

Christoph Hellwig (1):
      PCI: Prevent sysfs disable of device while driver is attached

Christophe Leroy (1):
      powerpc/8xx: fix invalid register expression in head_8xx.S

Colin Ian King (1):
      media: smiapp: fix timeout checking in smiapp_read_nvm

Cong Wang (1):
      infiniband: fix a possible use-after-free bug

DaeRyong Jeong (1):
      tty: Fix data race in tty_insert_flip_string_fixed_flag

Damien Le Moal (1):
      libata: Fix command retry decision

Dan Carpenter (1):
      scsi: megaraid: silence a static checker bug

David Sterba (1):
      btrfs: add barriers to btrfs_sync_log before log_commit_wait wakeups

Dmitry Osipenko (2):
      memory: tegra: Do not handle spurious interrupts
      memory: tegra: Apply interrupts mask per SoC

Dmitry Torokhov (1):
      HID: i2c-hid: check if device is there before really probing

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Donald Shanty III (1):
      Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Eric Dumazet (5):
      tcp: do not force quickack when receiving out-of-order packets
      tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quick=
ack_mode
      tcp: do not aggressively quick ack after ECN events
      tcp: add one more quick ack after after ECN events
      inet: frag: enforce memory limits earlier

Eric Engestrom (1):
      dmaengine: pxa_dma: remove duplicate const qualifier

Eugeniy Paltsev (1):
      NET: stmmac: align DMA stuff to largest cache line length

Eyal Reizer (1):
      wlcore: sdio: check for valid platform device data before suspend

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Ganapathi Bhat (1):
      mwifiex: handle race during mwifiex_usb_disconnect

Greg Kroah-Hartman (1):
      Linux 4.4.146

Hans Verkuil (1):
      media: videobuf2-core: don't call memop 'finish' when queueing

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption

Jakub Kicinski (1):
      bpf: fix references to free_bpf_prog_info() in comments

Jane Wan (1):
      mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter=
 pages

Jeremy Cline (2):
      netlink: Fix spectre v1 gadget in netlink_create()
      net: socket: fix potential spectre v1 gadget in socketcall

Jian-Hong Pan (1):
      Bluetooth: btusb: Add a new Realtek 8723DE ID 2ff8:b011

Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning

Jonathan Neusch=C3=A4fer (1):
      powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled b=
y Starlet

Jos=C3=A9 Roberto de Souza (1):
      drm: Add DP PSR2 sink enable bit

Jozsef Kadlecsik (1):
      netfilter: ipset: List timing out entries with "timeout 1" instead of=
 zero

Juergen Gross (1):
      xen/netfront: raise max number of slots in xennet_get_responses()

Julia Lawall (1):
      pinctrl: at91-pio4: add missing of_node_put

KT Liao (1):
      Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Kai Chieh Chuang (1):
      ASoC: dpcm: fix BE dai not hw_free and shutdown

Kan Liang (2):
      perf/x86/intel/uncore: Correct fixed counter index check in generic c=
ode
      perf/x86/intel/uncore: Correct fixed counter index check for NHM

Leon Romanovsky (1):
      RDMA/mad: Convert BUG_ONs to error flows

Linus Torvalds (3):
      squashfs: be more careful about metadata corruption
      squashfs: more metadata hardening
      squashfs: more metadata hardenings

Lorenzo Bianconi (1):
      ipv4: remove BUG_ON() from fib_compute_spec_dst

Luc Van Oostenryck (2):
      drm/radeon: fix mode_valid's return type
      drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Marc Zyngier (1):
      dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

Mathieu Malaterre (5):
      mm/slub.c: add __printf verification to slab_err()
      powerpc/32: Add a missing include header
      powerpc/chrp/time: Make some functions static, add missing header inc=
lude
      powerpc/powermac: Add missing prototype for note_bootable_part()
      powerpc/powermac: Mark variable x as unused

Mauro Carvalho Chehab (2):
      media: siano: get rid of __le32/__le16 cast warnings
      media: si470x: fix __be16 annotations

Maya Erez (1):
      scsi: ufs: fix exception event handling

Michal Simek (1):
      microblaze: Fix simpleImage format generation

Mika Westerberg (1):
      PCI: pciehp: Request control of native hotplug only if supported

Nicholas Piggin (1):
      powerpc/64s: Fix compiler store ordering to SLB shadow area

Ondrej Mosn=C3=A1=C4=8Dek (1):
      audit: allow not equal op for audit by executable

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()

Qu Wenruo (1):
      btrfs: qgroup: Finish rescan when hit the last leaf of extent tree

Roman Kagan (1):
      kvm: x86: vmx: fix vpid leak

Satendra Singh Thakur (1):
      drm/atomic: Handling the case when setting old crtc for plane

Scott Mayhew (1):
      nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo

Sean Lanigan (1):
      brcmfmac: Add support for bcm43364 wireless chipset

Shaul Triebitz (1):
      iwlwifi: pcie: fix race in Rx buffer allocator

Shivasharan S (1):
      scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath I=
Os

Shuah Khan (Samsung OSG) (1):
      usbip: usbip_detach: Fix memory, udev context and udev leak

Siva Rebbagondla (1):
      rsi: Fix 'invalid vdd' warning in mmc

Stefan Wahren (1):
      net: lan78xx: fix rx handling before first packet is send

Steven Rostedt (VMware) (3):
      tracing: Fix double free of event_trigger_data
      tracing: Fix possible double free in event_enable_trigger_func()
      tracing: Quiet gcc warning about maybe unused link variable

Stewart Smith (1):
      hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Suman Anna (1):
      media: omap3isp: fix unbalanced dma_iommu_mapping

Sven Eckelmann (9):
      ath: Add regulatory mapping for FCC3_ETSIC
      ath: Add regulatory mapping for ETSI8_WORLD
      ath: Add regulatory mapping for APL13_WORLD
      ath: Add regulatory mapping for APL2_FCCA
      ath: Add regulatory mapping for Uganda
      ath: Add regulatory mapping for Tanzania
      ath: Add regulatory mapping for Serbia
      ath: Add regulatory mapping for Bermuda
      ath: Add regulatory mapping for Bahamas

Takashi Iwai (2):
      ALSA: emu10k1: Rate-limit error messages about page errors
      ALSA: usb-audio: Apply rate limit to warning messages in URB complete=
 callback

Takashi Sakamoto (1):
      ALSA: hda/ca0132: fix build failure when a local macro is defined

Terry Junge (1):
      HID: hid-plantronics: Re-resend Update to map button for PTT products

Theodore Ts'o (3):
      random: mix rdrand with entropy sent in from userspace
      ext4: fix inline data updates with checksums enabled
      ext4: check for allocation block validity with block group locked

Thierry Escande (1):
      Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Thomas Richter (2):
      s390/cpum_sf: Add data entry sizes to sampling trailer entry
      perf: fix invalid bit in diagnostic entry

Tony Battersby (1):
      scsi: sg: fix minor memory leak in error path

Tudor-Dan Ambarus (2):
      crypto: authencesn - don't leak pointers to authenc keys
      crypto: authenc - don't leak pointers to authenc keys

Vincent Palatin (1):
      mfd: cros_ec: Fail early if we cannot identify the EC

Wei Yongjun (1):
      media: rcar_jpu: Add missing clk_disable_unprepare() on error in jpu_=
open()

Wenwen Wang (2):
      scsi: 3w-9xxx: fix a missing-check bug
      scsi: 3w-xxxx: fix a missing-check bug

Xiao Liang (1):
      xen-netfront: wait xenbus state change when load module manually

Xinming Hu (1):
      mwifiex: correct histogram data with appropriate index

Xose Vazquez Perez (1):
      scsi: scsi_dh: replace too broad "TP9" string with the exact models

Yousuk Seung (1):
      tcp: refactor tcp_ecn_check_ce to remove sk type cast

Yufen Yu (1):
      md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Zhouyang Jia (2):
      ALSA: emu10k1: add error handling for snd_ctl_add
      ALSA: fm801: add error handling for snd_ctl_add

tangpengpeng (1):
      net: fix amd-xgbe flow-control issue


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltoZBsACgkQONu9yGCS
aT6n3RAAoYFH0UoIQ28hRBXRk9O3CTMZooC0CyxGydmJ8Up70c0p7SK4KqXKACWf
ZbdB+Q5nfny38QVsdiMTo9521OUtNjc+nQisA1rLrZAByx7+DdTfm4IkSzJqBEx3
XVJmSDHPEZ2GcxuCibalE9U1etK36jwxaaLzkxR7sYH6DxmTxrSZkMWLdN8XN4wO
iQGEJ0+JLrk/nHymNUWIOLAwjKKx5/BU2bPwLcumfjQGc6AJEylsYl1OgIR9qGTK
Pk2WuvKCwbbn0qDLSRD4nCGi6lCbMTdi8MazL8kK82loV0rLs3qp41oPubqOgXpN
KjEtbUPRVi38f5Mu5No/JlWDHeiej022TpuN+pED5IqYqm93Qyw2BJFyZGoj282M
uCYmxdGhKxe+Ec0NbPhW2XueS7cMIxWDtsiNpJ1jeEkwS60jzLKiVd+n7yWD2JXe
oZg1DqfuKxtHiOlpSpog6dr2fmhe4WOJPXK/Jg5uJv+Ov1ktG3XVrmMLhQWCnwof
uuf0F+naI1HIWrjyRVRFHP5jnWF9LgFB2ZJJa2MqC2zcwYOE+W6LbBF5uqdmbiIx
mswkydyCxBnLr77vNAdSqydW+ZsODxDiUuvtsybHIf/KN2HBZKvzKGmcwVzeJ8Jc
iboTe3m9EwdYwz5TjQ6qdPmqCDWkUcefEdWFXqBoPK+BQgel+hg=
=kqxo
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
