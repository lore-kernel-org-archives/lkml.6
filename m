Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D6C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729F421902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548494969;
	bh=MHE3EbrPMwhprOhQ84xeg4jVtAHspbtlGUkTpndaU28=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2QYBwr419zMiHJZp/4WM9G1vofoxtKWwAMwNWQUtKDvOIReLdhYQN5tfeGO+zA3YD
	 PWlshEhvZr9r7mS3GotBvYBByQDTP/3ztuIdbNMnLwOTxELiiREGKAHpt/fZnkgRGs
	 9rgH2ddjavb1ELCeb3OqLaNolC7vRkJhmd+c94hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfAZJ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAZJ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:29:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD0021902;
        Sat, 26 Jan 2019 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548494965;
        bh=MHE3EbrPMwhprOhQ84xeg4jVtAHspbtlGUkTpndaU28=;
        h=Date:From:To:Cc:Subject:From;
        b=cStduD2VlMIcYx+fjK/O6Dr9ePhtar3yLeSFO8qiAKmgx/oWMYByjJABKRDDGmgC0
         kIZx8psBB7VNyFhCxstTrCfuk88HuHS4NMXypoJgsKIdJvHpOAQQyjpMM5VRKNhSGP
         Droopkkj7vwNRG6hz3ApzqKv/vmPgWQYwdIbQFKY=
Date:   Sat, 26 Jan 2019 10:29:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.133
Message-ID: <20190126092919.GA23295@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.133 kernel.

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

 Documentation/filesystems/proc.txt               |    4 +
 Makefile                                         |    2=20
 arch/arm/mach-imx/clk-imx6q.c                    |    6 ++
 arch/mips/Kconfig                                |    3 +
 arch/mips/pci/msi-octeon.c                       |    4 +
 arch/mips/sibyte/common/Makefile                 |    1=20
 arch/mips/sibyte/common/dma.c                    |   14 ++++++
 arch/sparc/kernel/signal_32.c                    |    4 -
 crypto/authenc.c                                 |   14 +++++-
 crypto/cts.c                                     |    8 +--
 drivers/acpi/power.c                             |   22 ++++++++++
 drivers/base/bus.c                               |    7 ++-
 drivers/block/loop.c                             |   47 +++++++++++-------=
-----
 drivers/block/loop.h                             |    1=20
 drivers/cpuidle/cpuidle-pseries.c                |    8 +++
 drivers/gpu/drm/drm_fb_helper.c                  |    7 ++-
 drivers/i2c/i2c-dev.c                            |    6 ++
 drivers/md/dm-kcopyd.c                           |   19 ++++++---
 drivers/md/dm-snap.c                             |   22 ++++++++++
 drivers/media/firewire/firedtv-avc.c             |    6 +-
 drivers/media/firewire/firedtv.h                 |    6 +-
 drivers/media/platform/vivid/vivid-kthread-cap.c |    5 +-
 drivers/media/platform/vivid/vivid-kthread-out.c |    5 +-
 drivers/media/platform/vivid/vivid-vid-common.c  |    2=20
 drivers/media/usb/em28xx/em28xx-video.c          |    4 -
 drivers/media/v4l2-core/videobuf2-core.c         |   14 ++++--
 drivers/mfd/tps6586x.c                           |   24 +++++++++++
 drivers/mmc/host/atmel-mci.c                     |    3 -
 drivers/net/ethernet/realtek/r8169.c             |    2=20
 drivers/scsi/sd.c                                |    6 ++
 drivers/target/target_core_spc.c                 |   17 +++++---
 drivers/tty/tty_ldsem.c                          |   10 ++++
 drivers/usb/class/cdc-acm.c                      |    7 +++
 drivers/usb/storage/scsiglue.c                   |    8 ++-
 drivers/usb/storage/unusual_devs.h               |   12 +++++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |    2=20
 fs/btrfs/disk-io.c                               |    8 +++
 fs/cifs/file.c                                   |    8 +--
 fs/cifs/smb2file.c                               |    4 -
 fs/cifs/transport.c                              |    2=20
 fs/jffs2/super.c                                 |    3 -
 fs/ocfs2/localalloc.c                            |    9 +++-
 fs/pstore/ram_core.c                             |    5 ++
 include/linux/sunrpc/svc.h                       |    5 +-
 mm/slab.c                                        |    6 +-
 net/bridge/br_netfilter.c                        |    2=20
 net/can/gw.c                                     |   30 +++++++++++++-
 net/core/sock.c                                  |    1=20
 net/ipv6/datagram.c                              |    1=20
 net/packet/af_packet.c                           |    4 -
 net/sctp/ipv6.c                                  |    5 --
 net/sctp/protocol.c                              |    4 -
 net/sunrpc/rpcb_clnt.c                           |    8 +++
 net/sunrpc/svc.c                                 |   10 +++-
 net/sunrpc/svc_xprt.c                            |    5 +-
 net/sunrpc/svcsock.c                             |    2=20
 scripts/kconfig/zconf.l                          |    2=20
 security/selinux/ss/policydb.c                   |    3 -
 security/yama/yama_lsm.c                         |    4 +
 sound/firewire/bebob/bebob.c                     |    2=20
 tools/perf/util/parse-events.c                   |    2=20
 tools/perf/util/svghelper.c                      |    2=20
 62 files changed, 365 insertions(+), 104 deletions(-)

Andreas Larsson (1):
      sparc32: Fix inverted invalid_frame_pointer checks on sigreturns

Arnaldo Carvalho de Melo (2):
      perf svghelper: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()

Ben Hutchings (1):
      media: em28xx: Fix misplaced reset of dev->v4l::field_count

Breno Leitao (1):
      powerpc/pseries/cpuidle: Fix preempt warning

Christoph Lameter (1):
      slab: alien caches must not be initialized if the allocation of the a=
lien cache failed

Daniel Santos (1):
      jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Daniel Vetter (1):
      sysfs: Disable lockdep for driver bind/unbind files

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

David Disseldorp (1):
      scsi: target: use consistent left-aligned ASCII INQUIRY data

Dmitry Safonov (1):
      tty/ldsem: Wake up readers after timed out down_write()

Eric Biggers (2):
      crypto: cts - fix crash on short inputs
      crypto: authenc - fix parsing key with misaligned rta_len

Eric Dumazet (1):
      ipv6: fix kernel-infoleak in ipv6_local_error()

Greg Kroah-Hartman (1):
      Linux 3.18.133

Hans Verkuil (3):
      media: vivid: fix error handling of kthread_run
      media: vivid: set min width/height to a value > 0
      media: vb2: vb2_mmap: move lock up

Hans de Goede (1):
      ACPI: power: Skip duplicate power resource references in _PRx

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specif=
ied
      USB: storage: add quirk for SMI SM3350

Ivan Mironov (2):
      scsi: sd: Fix cache_type_store()
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

J. Bruce Fields (1):
      sunrpc: handle ENOMEM in rpcb_getport_async

Jason Gunthorpe (1):
      packet: Do not leak dev refcounts on error exit

JianJhen Chen (1):
      net: bridge: fix a bug on using a neighbour cache entry without check=
ing its state

Joel Fernandes (Google) (1):
      pstore/ram: Do not treat empty buffers as valid

Jonas Danielsson (1):
      mmc: atmel-mci: do not assume idle after atmci_request_end

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend

Josef Bacik (1):
      btrfs: wait on ordered extents on abort cleanup

Junxiao Bi (1):
      ocfs2: fix panic due to unrecovered local alloc

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Kees Cook (1):
      Yama: Check for pid death before checking ancestry

Lucas Stach (1):
      clk: imx6q: reset exclusive gates on init

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Masahiro Yamada (1):
      kconfig: fix memory leak when EOF is encountered in quotation

Mauro Carvalho Chehab (1):
      media: vb2: be sure to unlock mutex on errors

Michal Hocko (1):
      mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/sma=
ps

Nathan Chancellor (1):
      media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Nikos Tsironis (2):
      dm kcopyd: Fix bug causing workqueue stalls
      dm snapshot: Fix excessive memory usage and workqueue stalls

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Pavel Shilovsky (1):
      CIFS: Do not hide EINTR after sending network packets

Ross Lagerwall (1):
      cifs: Fix potential OOB access of lock element array

Stephen Smalley (1):
      selinux: fix GPF on invalid policy

Takashi Sakamoto (1):
      ALSA: bebob: fix model-id of unit for Apogee Ensemble

Tetsuo Handa (1):
      block/loop: Use global lock for ioctl() operation.

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

Xin Long (1):
      sctp: allocate sctp_sockaddr_entry with kzalloc

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on

yupeng (1):
      net: call sk_dst_reset when set SO_DONTROUTE


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxMKG0ACgkQONu9yGCS
aT5UoxAA1tGmqoXwZLcrCYiwuiZJCDwi1t5X+Juy7RB8pox51fBqctbfXyTt+TST
YJlcDDo5l4RPeQx9Ownf/N1oVAfqmycqje/Uh3SfF9h6mgCAF0qKdmCa3h/sOecp
nMi0V+m3FGmn1D637MEB8vyKgB/9s3iOr1wqcsLvGoXA1oKmFl+ntv2F3rp+du+6
vVVxKX5xG7+0chhW9MkKqKnorLMBaldHprv/Y9V58CuzxF+fYao1IF7kRluBDtCi
JPLXesrWp+Z2Uq3g6K+P3Za5cGqkU1uvmJxgl0yjp6S8omwiCT8TI0fLl+Jx0Oij
pimly3SlG6CHn5YgstxD+hcV3tuounPGiCdgV+m610H9XOapM/+j/XeY7D5INlde
JX2KW/neXJNnrY96JSy0heHT0VEbPVj1JAxZaJc3o2FHWNQTV6bA1D7MPbdTCRGf
MjXLz/5ZaLQ5iivOIJj+ZA3GDn1Hy4cn1/3WZHlNQE03Vo5eo7bGAWyY+Kz8wPQs
xpDbfCBjvJ9Unk32veUK009PE0nUSONYPdFBxPxhEECGbIafCNrxHhEpJciUPfc3
C7u8zDs3WvIxMxNsCpQGKIvJnpKio/lTFHBPBJ7yGDt8+QO50gCMOpdZ00V25PYS
96SBztL1waOoXRLMc79jAZAS+p1CzNy2X4R4X5Yq0pGLX8ZZ0dU=
=eHps
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
