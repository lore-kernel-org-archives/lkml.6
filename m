Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A271C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3512720859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIATt2fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3512720859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJMQ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeJMQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:26:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D9920859;
        Sat, 13 Oct 2018 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539420609;
        bh=14hUswpFM/PPdlgHmYzg9TOCgpsU9qmNhF+JZ+S8ChU=;
        h=Date:From:To:Cc:Subject:From;
        b=lIATt2fRCh3MuRzSUSJwvInhLYRXqISWy0CfzBv4dmC33vb8bD95CrQ23O8MuefCk
         HlFsHwGRqSWmsi/0lnlMtYigTPlvRk7vZ2xpc/Syp0Yn5OY1z/78LkPhY2vdUY0IT9
         6h1isa/9NzfS2YKQdIDmBrV7urFxDRdJfznxnry8=
Date:   Sat, 13 Oct 2018 10:50:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.123
Message-ID: <20181013085007.GA1293@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.124 kernel.

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

 Makefile                                           |    2=20
 arch/arm/mach-mvebu/pmsu.c                         |    6 -
 arch/arm64/include/asm/kvm_emulate.h               |    5 +
 arch/arm64/kernel/entry.S                          |    3=20
 arch/arm64/kvm/guest.c                             |   55 +++++++++++++++
 arch/hexagon/include/asm/bitops.h                  |    4 -
 arch/hexagon/kernel/dma.c                          |    2=20
 arch/powerpc/kernel/machine_kexec.c                |    7 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    2=20
 arch/s390/mm/extmem.c                              |    4 -
 arch/x86/kernel/tsc_msr.c                          |    1=20
 arch/x86/mm/numa_emulation.c                       |    2=20
 arch/x86/vdso/vclock_gettime.c                     |   26 ++++---
 crypto/ablkcipher.c                                |    2=20
 crypto/blkcipher.c                                 |    1=20
 drivers/base/power/main.c                          |    5 +
 drivers/block/floppy.c                             |    3=20
 drivers/crypto/mxs-dcp.c                           |   53 ++++++++-------
 drivers/gpio/gpio-adp5588.c                        |   24 +++++-
 drivers/hid/hid-core.c                             |    3=20
 drivers/hid/hid-ids.h                              |    2=20
 drivers/hid/hid-ntrig.c                            |    2=20
 drivers/hid/hid-sony.c                             |    6 +
 drivers/hwmon/adt7475.c                            |   14 ++--
 drivers/infiniband/core/ucma.c                     |    6 +
 drivers/md/dm-thin-metadata.c                      |   34 +++++++++
 drivers/md/dm-thin.c                               |   73 ++++++++++++++++=
++---
 drivers/md/raid10.c                                |    5 +
 drivers/media/i2c/soc_camera/ov772x.c              |    2=20
 drivers/media/platform/exynos4-is/fimc-isp-video.c |   11 ++-
 drivers/media/platform/s3c-camif/camif-capture.c   |    2=20
 drivers/media/usb/tm6000/tm6000-dvb.c              |    5 +
 drivers/media/usb/uvc/uvc_video.c                  |   24 +++++-
 drivers/media/v4l2-core/v4l2-event.c               |   37 +++++-----
 drivers/media/v4l2-core/v4l2-fh.c                  |    2=20
 drivers/misc/tsl2550.c                             |    2=20
 drivers/mtd/spi-nor/fsl-quadspi.c                  |   20 ++---
 drivers/net/appletalk/ipddp.c                      |    8 +-
 drivers/net/ethernet/cadence/macb.c                |    2=20
 drivers/net/ethernet/hp/hp100.c                    |    2=20
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |    7 +-
 drivers/net/ethernet/realtek/r8169.c               |    9 +-
 drivers/net/wireless/rndis_wlan.c                  |    2=20
 drivers/net/wireless/ti/wlcore/cmd.c               |    6 +
 drivers/pci/pci.c                                  |   27 +++++--
 drivers/s390/net/qeth_l2_main.c                    |    2=20
 drivers/s390/net/qeth_l3_main.c                    |    2=20
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |    2=20
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |    4 -
 drivers/spi/spi-rspi.c                             |   10 +-
 drivers/spi/spi-sh-msiof.c                         |    3=20
 drivers/spi/spi-tegra20-slink.c                    |   31 ++++++--
 drivers/staging/android/ashmem.c                   |    6 +
 drivers/staging/android/ion/ion.c                  |   60 ++++++++++-------
 drivers/target/iscsi/iscsi_target_auth.c           |   45 ++++--------
 drivers/target/iscsi/iscsi_target_tpg.c            |    3=20
 drivers/thermal/of-thermal.c                       |    7 +-
 drivers/tty/serial/8250/serial_cs.c                |    6 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   10 ++
 drivers/usb/class/cdc-wdm.c                        |    2=20
 drivers/usb/core/devio.c                           |   24 ++++++
 drivers/usb/core/driver.c                          |   28 ++++----
 drivers/usb/core/usb.c                             |    2=20
 drivers/usb/misc/yurex.c                           |    3=20
 drivers/usb/serial/kobil_sct.c                     |   12 ++-
 drivers/usb/serial/usb-serial-simple.c             |    3=20
 drivers/usb/wusbcore/security.c                    |    2=20
 drivers/uwb/hwa-rc.c                               |    1=20
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |    5 +
 drivers/xen/events/events_base.c                   |    2=20
 drivers/xen/manage.c                               |    6 +
 fs/cifs/cifs_unicode.c                             |    3=20
 fs/cifs/cifssmb.c                                  |   11 ++-
 fs/cifs/misc.c                                     |    8 ++
 fs/cifs/smb2ops.c                                  |    2=20
 fs/ext4/balloc.c                                   |   21 +++---
 fs/ext4/dir.c                                      |   20 ++---
 fs/ext4/ext4.h                                     |    8 --
 fs/ext4/ext4_extents.h                             |    1=20
 fs/ext4/extents.c                                  |    6 +
 fs/ext4/ialloc.c                                   |   19 ++++-
 fs/ext4/inline.c                                   |   42 +-----------
 fs/ext4/inode.c                                    |    3=20
 fs/ext4/mballoc.c                                  |    6 +
 fs/ext4/mmp.c                                      |    1=20
 fs/ext4/resize.c                                   |   20 +++++
 fs/ext4/super.c                                    |   14 +++-
 fs/ext4/xattr.c                                    |   49 ++++++--------
 fs/jbd2/transaction.c                              |    2=20
 fs/nfsd/nfs4proc.c                                 |    1=20
 fs/ocfs2/buffer_head_io.c                          |    1=20
 fs/ocfs2/dlm/dlmmaster.c                           |    4 -
 fs/proc/base.c                                     |   14 ++++
 fs/seq_file.c                                      |    7 +-
 fs/ubifs/super.c                                   |    3=20
 include/linux/netfilter_bridge/ebtables.h          |    5 +
 include/linux/seq_file.h                           |   13 +--
 include/linux/slub_def.h                           |    3=20
 include/media/v4l2-fh.h                            |    1=20
 kernel/cgroup.c                                    |    6 +
 kernel/module.c                                    |    6 +
 kernel/time/alarmtimer.c                           |    3=20
 kernel/trace/ring_buffer.c                         |    2=20
 mm/madvise.c                                       |    2=20
 mm/shmem.c                                         |    2=20
 mm/slub.c                                          |    6 -
 net/bridge/netfilter/ebt_arpreply.c                |    3=20
 net/core/neighbour.c                               |   13 ++-
 net/ipv4/af_inet.c                                 |    1=20
 net/ipv6/ip6_offload.c                             |    1=20
 net/ipv6/ip6_output.c                              |    3=20
 net/mac80211/cfg.c                                 |    2=20
 net/mac80211/ibss.c                                |   22 +++---
 net/mac80211/main.c                                |   26 ++++++-
 net/mac80211/mlme.c                                |   53 +++++++++++++++
 net/wireless/nl80211.c                             |    1=20
 sound/aoa/core/gpio-feature.c                      |    4 -
 sound/firewire/bebob/bebob_maudio.c                |   24 ++++--
 sound/pci/emu10k1/emufx.c                          |    2=20
 sound/pci/hda/hda_intel.c                          |    3=20
 sound/soc/codecs/cs4265.c                          |    4 -
 sound/soc/soc-dapm.c                               |    7 ++
 tools/vm/page-types.c                              |    6 -
 tools/vm/slabinfo.c                                |    4 -
 124 files changed, 891 insertions(+), 404 deletions(-)

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

Alistair Strachan (1):
      staging: android: ashmem: Fix mmap size validation

Andy Lutomirski (2):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Andy Shevchenko (1):
      x86/tsc: Add missing header to tsc_msr.c

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is dis=
abled

Anton Vasilyev (1):
      uwb: hwa-rc: fix memory leak at probe

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Bart Van Assche (1):
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the outpu=
t buffer size

Ben Hutchings (1):
      USB: yurex: Check for truncation in yurex_read()

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Breno Leitao (1):
      scsi: ibmvscsi: Improve strings handling

Catalin Marinas (1):
      arm64: Add trace_hardirqs_off annotation in ret_to_user

Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Colin Ian King (1):
      net: hp100: fix always-true check for link up state

Dan Carpenter (3):
      rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
      hwmon: (adt7475) Make adt7475_read_word() return errors
      cifs: read overflow in is_valid_oplock_break()

Dan Williams (1):
      x86/numa_emulation: Fix emulated-to-physical node mapping

Danek Duvall (1):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

Emmanuel Grumbach (2):
      mac80211: fix a race between restart and CSA flows
      mac80211: shorten the IBSS debug messages

Eric Dumazet (1):
      ipv6: fix possible use-after-free in ip6_xmit()

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Gao Feng (1):
      ebtables: arpreply: Add the standard target sanity check

Geert Uytterhoeven (1):
      spi: rspi: Fix interrupted DMA transfers

Greg Hackmann (1):
      staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free

Greg Kroah-Hartman (1):
      Linux 3.18.124

Han Xu (1):
      mtd: fsl-quadspi: fix macro collision problems with READ/WRITE

Hari Bathini (1):
      powerpc/kdump: Handle crashkernel memory reservation failure

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

J. Bruce Fields (1):
      nfsd: fix corrupted reply to badly ordered compound

Jann Horn (2):
      RDMA/ucma: check fd type in ucma_migrate_id()
      proc: restrict kernel stack dumps to root

Jessica Yu (1):
      module: exclude SHN_UNDEF symbols from kallsyms api

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Joe Thornber (1):
      dm thin metadata: try to avoid ever aborting transactions

Joel Fernandes (Google) (1):
      mm: shmem.c: Correctly annotate new inodes for lockdep

Johan Hovold (2):
      USB: serial: kobil_sct: fix modem-status error handling
      USB: serial: simple: add Motorola Tetra MTP6550 id

Jon Kuhn (1):
      fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Julia Lawall (1):
      usb: wusbcore: security: cast sizeof to int for comparison

Julian Wiedmann (1):
      s390/qeth: don't dump past end of unknown HW header

Junxiao Bi (1):
      ocfs2: fix ocfs2 read block panic

Kai-Heng Feng (2):
      ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENAB=
LED

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty

Liam Girdwood (1):
      ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Linus Torvalds (1):
      Make file credentials available to the seqfile interfaces

Marc Zyngier (1):
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

Matt Ranostay (1):
      tsl2550: fix lux1_input error in low light

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Mike Snitzer (1):
      dm thin metadata: fix __udivdi3 undefined on 32-bit

Naoya Horiguchi (2):
      tools/vm/slabinfo.c: fix sign-compare warning
      tools/vm/page-types.c: fix "defined but not used" warning

Nicholas Mc Guire (1):
      ALSA: snd-aoa: add of_node_put() in error path

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Prateek Sood (1):
      cgroup: Fix deadlock in cpu hotplug path

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

Randy Dunlap (2):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int

Richard Weinberger (1):
      ubifs: Check for name being NULL while mounting

Roderick Colenbrander (2):
      HID: sony: Update device ids
      HID: sony: Support DS4 dongle

Sakari Ailus (1):
      media: v4l: event: Prevent freeing event subscriptions while accessed

Sebastian Andrzej Siewior (1):
      Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_ou=
tstanding_interrupt()"

Stafford Horne (1):
      crypto: skcipher - Fix -Wstringop-truncation warnings

Stephen Rothwell (1):
      fs/cifs: suppress a string overflow warning

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_tr=
y_fmt()

S=E9bastien Szymanski (1):
      ASoC: cs4265: fix MMTLR Data switch control

Takashi Sakamoto (1):
      ALSA: bebob: use address returned by kmalloc() instead of kernel stac=
k for streaming DMA mapping

Theodore Ts'o (14):
      ext4: avoid divide by zero fault when deleting corrupted inline direc=
tories
      ext4: recalucate superblock checksum after updating free blocks/inodes
      ext4: fix online resize's handling of a too-small final block group
      ext4: verify the depth of extent tree in ext4_find_extent()
      ext4: only look at the bg_flags field if it is valid
      ext4: fix check to prevent initializing reserved inodes
      ext4: always check block group bounds in ext4_init_block_bitmap()
      ext4: fix false negatives *and* false positives in ext4_check_descrip=
tors()
      ext4: add corruption check in ext4_xattr_set_entry()
      ext4: always verify the magic number in xattr blocks
      ext4: never move the system.data xattr out of the inode body
      ext4: add more inode number paranoia checks
      jbd2: don't mark block as modified if the handle is out of credits
      ext4: avoid running out of journal credits when appending to an inlin=
e file

Thomas Gleixner (1):
      alarmtimer: Prevent overflow for relative nanosleep

Toke H=F8iland-J=F8rgensen (1):
      gso_segment: Reset skb->mac_len after modifying network header

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Tony Lindgren (1):
      wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages

Vasily Gorbik (1):
      s390/extmem: fix gcc 8 stringop-overflow warning

Vasily Khoruzhick (1):
      neighbour: confirm neigh entries when ARP packet is received

Vincent Pelletier (2):
      scsi: target: iscsi: Use hex2bin instead of a re-implementation
      scsi: target: iscsi: Use bin2hex instead of a re-implementation

Vitaly Kuznetsov (1):
      xen/manage: don't complain about an empty value in control/sysrq node

Willy Tarreau (2):
      ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_I=
OCTL_INFO
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Xiao Ni (1):
      RAID10 BUG_ON in raise_barrier when force is true and conf->barrier i=
s 0

Zhouyang Jia (4):
      drivers/tty: add error handling for pcmcia_loop_config
      media: tm6000: add error handling for dvb_register_adapter
      HID: hid-ntrig: add error handling for sysfs_create_group
      scsi: bnx2i: add error handling for ioremap_nocache

ming_qian (1):
      media: uvcvideo: Support realtek's UVC 1.5 device


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvBsbsACgkQONu9yGCS
aT4xDA/+OsaVU113PREMHNUBqiCvOPPX/HykVCdcmzF2+Qjo8nva65iA8fOlnx8Q
2HjPKwDGPQ6D6ql+0Tvcgsv8Ck6qbSM4CwBuWFLi0WJLgLFg/OgWRTsZigoi0mDt
aX+rj1tLy7nBeNjeE2FDA7s+Th07pelCimgef+WZpGivaye6AP76Jr/XPvWpYgmG
aQpI1BkewqV1OWh8JiuKfxzlUm2UWRIjfg8YP5HfjtmKs03n4AmgN8rNrJOK32cG
CAjEogUYvae2uPS70f3an6volaTnOgiEm3UdVfP8coZnMeHO9RT2D5jyT7RJP8RC
COprURKH0euVaCZSAx9YfexfsWwfy2z1kom5rSOevOVajalNO/eA/U9hX+hnbDoY
aDMFtecQxSvAB2dC/5zu48FS4l5yj0WVllM0IultGVG4Y4yGMq9EYGRJL9ZcNi/C
vAv52GSfI+GJtB1exbPVsBOC90HjU4RCgtaNpGzdt9G/Oq4e0Vf14VGD0/nIgD1k
CWR0pOqiV9q1v6RYX0PhcTVFsQ+c8b6pBkfRGOr1AaGz5G6DXlV9zXI7WKNl/mSz
SDToI3V4UQK/YQUZTVbkgbpgw7Cx2g0pUFsh3Egjryup6/6LgxvaS4ISXNcAz802
psJ2ixF/r4n6VFkheWzOeo0wjcUFMm4+foQbR8ny/WoytZ2Rmys=
=iOim
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
