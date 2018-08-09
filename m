Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE23C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BDD208A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BDD208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbeHIPC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:02:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbeHIPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:02:57 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F5D6D0E;
        Thu,  9 Aug 2018 12:38:13 +0000 (UTC)
Date:   Thu, 9 Aug 2018 14:38:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.118
Message-ID: <20180809123809.GA8431@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.118 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                            |    2=20
 arch/microblaze/boot/Makefile                       |   10 ++--
 arch/powerpc/kernel/head_8xx.S                      |    2=20
 arch/powerpc/kernel/pci_32.c                        |    1=20
 arch/powerpc/platforms/chrp/time.c                  |    6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c       |    5 ++
 arch/powerpc/platforms/powermac/bootx_init.c        |    4 +
 arch/powerpc/platforms/powermac/setup.c             |    1=20
 arch/s390/include/asm/cpu_mf.h                      |    6 +-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c       |    2=20
 arch/x86/kernel/cpu/perf_event_intel_uncore_nhmex.c |    2=20
 crypto/authenc.c                                    |    1=20
 crypto/authencesn.c                                 |    1=20
 drivers/acpi/pci_root.c                             |    4 +
 drivers/ata/libata-eh.c                             |   12 +++--
 drivers/char/random.c                               |   10 +++-
 drivers/crypto/padlock-aes.c                        |    8 ++-
 drivers/gpu/drm/gma500/psb_intel_drv.h              |    2=20
 drivers/gpu/drm/gma500/psb_intel_lvds.c             |    2=20
 drivers/gpu/drm/radeon/radeon_connectors.c          |   10 ++--
 drivers/hid/i2c-hid/i2c-hid.c                       |    8 +++
 drivers/infiniband/core/mad.c                       |   11 ++--
 drivers/infiniband/core/ucma.c                      |    6 ++
 drivers/md/md.c                                     |    3 +
 drivers/media/common/siano/smsendian.c              |   14 ++---
 drivers/media/i2c/smiapp/smiapp-core.c              |   11 ++--
 drivers/media/pci/saa7164/saa7164-fw.c              |    3 -
 drivers/media/platform/omap3isp/isp.c               |    7 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c       |    6 +-
 drivers/net/can/usb/ems_usb.c                       |    1=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |    2=20
 drivers/net/wireless/ath/regd.h                     |    5 ++
 drivers/net/wireless/ath/regd_common.h              |   13 +++++
 drivers/net/wireless/mwifiex/usb.c                  |    3 +
 drivers/net/wireless/rsi/rsi_91x_sdio.c             |    2=20
 drivers/net/wireless/ti/wlcore/sdio.c               |    5 ++
 drivers/net/xen-netfront.c                          |    6 ++
 drivers/pci/pci-sysfs.c                             |   15 +++---
 drivers/regulator/pfuze100-regulator.c              |    1=20
 drivers/rtc/interface.c                             |    5 ++
 drivers/scsi/3w-9xxx.c                              |    5 ++
 drivers/scsi/3w-xxxx.c                              |    3 +
 drivers/scsi/megaraid.c                             |    3 +
 drivers/scsi/qla2xxx/qla_init.c                     |    7 +-
 drivers/scsi/qla2xxx/qla_os.c                       |    5 +-
 drivers/scsi/sg.c                                   |    1=20
 drivers/scsi/ufs/ufshcd.c                           |    2=20
 drivers/tty/hvc/hvc_opal.c                          |    1=20
 drivers/tty/pty.c                                   |    3 +
 drivers/usb/core/hub.c                              |    4 +
 drivers/virtio/virtio_balloon.c                     |    2=20
 fs/jfs/xattr.c                                      |   10 ++--
 fs/squashfs/block.c                                 |    2=20
 fs/squashfs/cache.c                                 |    3 +
 fs/squashfs/file.c                                  |    8 ++-
 fs/squashfs/fragment.c                              |   17 ++++---
 fs/squashfs/squashfs_fs.h                           |    6 ++
 fs/squashfs/squashfs_fs_sb.h                        |    1=20
 fs/squashfs/super.c                                 |    5 +-
 include/linux/ring_buffer.h                         |    1=20
 include/net/tcp.h                                   |    2=20
 kernel/bpf/verifier.c                               |    4 -
 kernel/trace/ring_buffer.c                          |   16 ++++++
 kernel/trace/trace.c                                |    6 ++
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
 sound/pci/emu10k1/emupcm.c                          |    4 +
 sound/pci/emu10k1/memory.c                          |    6 +-
 sound/pci/fm801.c                                   |   16 +++++-
 sound/pci/hda/patch_ca0132.c                        |    8 ++-
 sound/soc/soc-pcm.c                                 |    6 +-
 sound/usb/pcm.c                                     |    2=20
 tools/usb/usbip/src/usbip_detach.c                  |    9 ++-
 81 files changed, 365 insertions(+), 144 deletions(-)

Alexandre Belloni (1):
      rtc: ensure rtc_set_alarm fails when alarms are not supported

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns

Anson Huang (1):
      regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Anton Vasilyev (1):
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failu=
re

Brad Love (1):
      media: saa7164: Fix driver name in debug output

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

Dmitry Torokhov (1):
      HID: i2c-hid: check if device is there before really probing

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Eric Dumazet (5):
      tcp: do not force quickack when receiving out-of-order packets
      tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quick=
ack_mode
      tcp: do not aggressively quick ack after ECN events
      tcp: add one more quick ack after after ECN events
      inet: frag: enforce memory limits earlier

Eugeniy Paltsev (1):
      NET: stmmac: align DMA stuff to largest cache line length

Eyal Reizer (1):
      wlcore: sdio: check for valid platform device data before suspend

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Ganapathi Bhat (1):
      mwifiex: handle race during mwifiex_usb_disconnect

Greg Kroah-Hartman (1):
      Linux 3.18.118

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption

Jakub Kicinski (1):
      bpf: fix references to free_bpf_prog_info() in comments

Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning

Jonathan Neusch=E4fer (1):
      powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled b=
y Starlet

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

Masami Hiramatsu (1):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer

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

Quinn Tran (1):
      scsi: qla2xxx: Fix ISP recovery on unload

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Shuah Khan (Samsung OSG) (1):
      usbip: usbip_detach: Fix memory, udev context and udev leak

Siva Rebbagondla (1):
      rsi: Fix 'invalid vdd' warning in mmc

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

Theodore Ts'o (1):
      random: mix rdrand with entropy sent in from userspace

Thomas Richter (2):
      s390/cpum_sf: Add data entry sizes to sampling trailer entry
      perf: fix invalid bit in diagnostic entry

Tony Battersby (1):
      scsi: sg: fix minor memory leak in error path

Tudor-Dan Ambarus (2):
      crypto: authencesn - don't leak pointers to authenc keys
      crypto: authenc - don't leak pointers to authenc keys

Wenwen Wang (2):
      scsi: 3w-9xxx: fix a missing-check bug
      scsi: 3w-xxxx: fix a missing-check bug

Xiao Liang (1):
      xen-netfront: wait xenbus state change when load module manually

Yousuk Seung (1):
      tcp: refactor tcp_ecn_check_ce to remove sk type cast

Yufen Yu (1):
      md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Zhouyang Jia (2):
      ALSA: emu10k1: add error handling for snd_ctl_add
      ALSA: fm801: add error handling for snd_ctl_add


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltsNbEACgkQONu9yGCS
aT7WVg//SSaOGPjOAiObc9E7z8ONdCWWt4uQKkqU7NYaEHthxSSmO1zOzMHTBZ9M
/HMW9GS5aTtcORGRDAjaZNu3cTKjySHNEw8IUUYBxNtTwfCg7IDnqHzA2Vr/+rlB
mSHmmbDpsibmENR7NeJtkZKhmbhRHPNkQeviezyEdiNy2Kfst9L5QSEj0PsQeGcp
Be1x3QJJ/v8tMN/Vun8M7gMbrtCUFY65gbT+0dihbFBj9MiJv+R72D7G/1y8mjE+
hdhR78VyMW3JeZmfeia95xdSaHA8SwUHkVilxFFgxKFAXRXRDEUS7YoTT+olsSrY
2WqBHJrtGGm1/PDVZYIM1F3Gpz1VEsdlooxOG+MnAM24V2pizpdfxt5R6mFmXdTe
gFP7Sc3JFaW0SGUls5ZFbSFn/oHg2xBQ4S7l0aEHfVRCvwybWUowMVwb9uWaZCue
hkD2lvHGCkwI5XUcR39XAUXPGi0uuJ4VU9AAU8u1AT5UG3UBs/Tv+7zOY1LTXsB2
Ra9fpOR7tdnJz3OWfRrpSnH8tZQjSMCHouTgUPJGYH9jDW2+vEVMvMIBnD3kGBBc
9go+J28lQ6lQDjgCkgINZjPrQXGAG143xSUxwB7TmUPEzdG8wiU8pzOz0hJf7h0X
g9dmOePAs1UbNUxNjj06hc0sMyy+i4x6QUf0QWmJl5uNdeqBy9k=
=1740
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
