Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3830068-1521371808-2-3117594987355547134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521371807; b=oitM6Ebw0FJdzoR+YVIdjJekUm1MiMyyCueAIMuuHJtIqD3
    uxLJFQ6d/eBxQuhzYQW1BAeDbNwYZtVIqNTwR42WtNJ/fFhmiV32cG7U103K7AEj
    o5RrWnQvm88p8lXcz54cHJrr65rjnGLlJs6/wqRPYMmsTReb62C+c8jpv6JWn2HL
    x2tZesGlt2VdmsJJZ3pT/uc3kigmt0/ATUY9IgweoDnf0fJ9wgC3tdASnLkhc8gK
    aiBLqPuApLOK+XW7vHz1tSOpg6ZEKpNxLaONweefCBS2ZxMErQFJ/WxF0RHDr7X7
    jP6ihgvnmsZHeT5sMyNCRJYtBzajjbaeINUJMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521371807; bh=gYG56svhPLH4+MxIr7GyDOkhA6aLz6JVk2R4e22nTzk=; b=e
    5Uh7nf9n3CmnAinStXQuxaCGQZ9E3sk1lX7RsFHE7gMRAJZ/huVhDWUNw5HqZ+/4
    Cqm4MD7YW1oTOAF1QrJ0qQgkUUIAVUKYR1SCDWXufM4+DZhVpZotxyCkYjnsVZcF
    O7aznRI+QDL8i3yHhU99lW4Q8NaUjvxUsLtRQbIdHfnOvfBUB0YbPeATW7tZvGUq
    vZSRrLoXlBRW/W2mY5rv2htudqHbXPIwfFUWHubzsf3woH5aVBPSNOdbCshxxb+Z
    53+ZasRHlmBgEjXGqluz2Xa514XArOmYerk/C27eZ2IB45gJv2lbEn3FcWEflsWw
    j1VeNfimu13N+ifbCILrw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeCRLQq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 07:16:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbeCRLQp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 07:16:45 -0400
Date: Sun, 18 Mar 2018 12:16:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.122
Message-ID: <20180318111644.GA12788@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.122 kernel.

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

 Makefile                                       |    2=20
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     |    8 -
 arch/arm/mach-omap2/omap-secure.c              |    2=20
 arch/mips/ath25/board.c                        |    2=20
 arch/mips/cavium-octeon/octeon-irq.c           |    2=20
 arch/mips/kernel/smp-bmips.c                   |    8 -
 arch/x86/kernel/cpu/mcheck/mce.c               |   22 ++++
 arch/x86/kernel/machine_kexec_64.c             |    1=20
 arch/x86/kernel/module.c                       |   14 ++
 arch/x86/tools/relocs.c                        |    3=20
 drivers/block/loop.c                           |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c       |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |   58 +++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |   30 ------
 drivers/gpu/drm/drm_probe_helper.c             |   20 ++++
 drivers/gpu/drm/nouveau/nouveau_connector.c    |   18 ++-
 drivers/gpu/drm/radeon/cik.c                   |   31 ------
 drivers/gpu/drm/radeon/radeon_connectors.c     |   74 +++++++++-----
 drivers/infiniband/core/ucma.c                 |    6 +
 drivers/infiniband/hw/mlx5/cq.c                |    7 +
 drivers/input/keyboard/matrix_keypad.c         |    4=20
 drivers/input/keyboard/tca8418_keypad.c        |    2=20
 drivers/md/bcache/super.c                      |   11 ++
 drivers/media/i2c/tc358743.c                   |    2=20
 drivers/mtd/ubi/vmt.c                          |   15 ++-
 drivers/scsi/qla2xxx/qla_init.c                |    1=20
 drivers/scsi/qla2xxx/qla_target.c              |    2=20
 drivers/staging/android/ashmem.c               |   15 +--
 drivers/staging/comedi/drivers.c               |    3=20
 drivers/tty/serial/8250/8250_pci.c             |   11 ++
 drivers/tty/serial/atmel_serial.c              |    1=20
 drivers/tty/serial/sh-sci.c                    |    2=20
 drivers/usb/core/message.c                     |    4=20
 drivers/usb/core/quirks.c                      |    3=20
 drivers/usb/gadget/function/f_fs.c             |    1=20
 drivers/usb/mon/mon_text.c                     |  124 +++++++++++++++-----=
-----
 drivers/usb/storage/uas.c                      |    2=20
 drivers/usb/storage/unusual_devs.h             |    7 +
 drivers/watchdog/hpwdt.c                       |   12 ++
 fs/ext4/xattr.c                                |    3=20
 fs/nfs/direct.c                                |    2=20
 include/drm/drm_crtc_helper.h                  |    1=20
 include/linux/netfilter/x_tables.h             |   38 +------
 include/linux/nospec.h                         |    1=20
 include/linux/usb/quirks.h                     |    3=20
 include/linux/workqueue.h                      |    1=20
 kernel/workqueue.c                             |   16 +++
 net/bridge/netfilter/ebt_among.c               |   21 +++-
 net/bridge/netfilter/ebtables.c                |   13 ++
 net/ipv4/netfilter.c                           |    7 -
 net/ipv4/netfilter/arp_tables.c                |   20 ++--
 net/ipv4/netfilter/ip_tables.c                 |   20 ++--
 net/ipv6/netfilter/ip6_tables.c                |   21 ++--
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c       |    4=20
 net/netfilter/nf_nat_proto_common.c            |    7 +
 net/netfilter/nfnetlink_queue.c                |    2=20
 net/netfilter/x_tables.c                       |   55 +++++++++++
 net/netfilter/xt_IDLETIMER.c                   |    9 +
 net/netfilter/xt_LED.c                         |   12 +-
 net/sctp/sm_make_chunk.c                       |    2=20
 scripts/Makefile.lib                           |    8 -
 sound/core/seq/seq_clientmgr.c                 |   21 ++--
 sound/core/seq/seq_fifo.c                      |    2=20
 sound/core/seq/seq_memory.c                    |   14 ++
 sound/core/seq/seq_memory.h                    |    3=20
 sound/pci/hda/patch_conexant.c                 |    2=20
 sound/pci/hda/patch_realtek.c                  |   16 +++
 67 files changed, 571 insertions(+), 288 deletions(-)

Alex Deucher (2):
      drm/radeon: fix KV harvesting
      drm/amdgpu: fix KV harvesting

Arnd Bergmann (2):
      watchdog: hpwdt: fix unused variable warning
      ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev

Colin Ian King (2):
      MIPS: ath25: Check for kzalloc allocation failure
      MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Dan Williams (1):
      nospec: Include <asm/barrier.h> dependency

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

Dennis Wassenberg (2):
      ALSA: hda: add dock and led support for HP EliteBook 820 G3
      ALSA: hda: add dock and led support for HP ProBook 640 G2

Dmitry Torokhov (1):
      Input: tca8418_keypad - remove double read of key event register

Eric Dumazet (1):
      netfilter: IDLETIMER: be syzkaller friendly

Florian Westphal (9):
      netfilter: nfnetlink_queue: fix timestamp attribute
      netfilter: add back stackpointer size checks
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
      netfilter: use skb_to_full_sk in ip_route_me_harder
      netfilter: x_tables: pass xt_counters struct instead of packet counter
      netfilter: x_tables: pass xt_counters struct to counter allocator
      netfilter: x_tables: pack percpu counter allocations

Frank Mori Hess (1):
      staging: comedi: fix comedi_nsamples_left.

Greg Kroah-Hartman (3):
      Revert "ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux"
      fixup: sctp: verify size of a new chunk in _sctp_make_chunk()
      Linux 4.4.122

H.J. Lu (1):
      x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

James Hogan (1):
      kbuild: Handle builtin dtb file names containing hyphens

Jerry Hoemann (2):
      watchdog: hpwdt: SMBIOS check
      watchdog: hpwdt: Check source of NMI

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Josh Poimboeuf (1):
      x86/module: Detect and skip invalid relocations

Julia Lawall (1):
      USB: usbmon: remove assignment from IS_ERR argument

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend

Leon Romanovsky (3):
      RDMA/ucma: Limit possible option size
      RDMA/ucma: Check that user doesn't overflow QP state
      RDMA/mlx5: Fix integer overflow while resizing CQ

Lukas Wunner (5):
      workqueue: Allow retrieval of current task's work struct
      drm: Allow determining if current task is output poll worker
      drm/nouveau: Fix deadlock on runtime suspend
      drm/radeon: Fix deadlock on runtime suspend
      drm/amdgpu: Fix deadlock on runtime suspend

Michael Lyle (1):
      bcache: don't attach backing with duplicate UUID

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Oliver Neukum (1):
      uas: fix comparison for error code

Paolo Abeni (2):
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Philipp Zabel (1):
      tc358743: fix register i2c_rd/wr function fix

Quinn Tran (1):
      scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport

Rex Zhu (1):
      drm/amdgpu: Notify sbios device ready before send request

Ross Zwisler (1):
      loop: Fix lost writes caused by missing flag

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes

Tahsin Erdogan (1):
      ext4: inplace xattr block update fails to deduplicate blocks

Takashi Iwai (3):
      ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
      ALSA: seq: Don't allow resizing pool in use
      ALSA: seq: More protection for concurrent write and ioctl races

Teijo Kinnunen (1):
      USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Trond Myklebust (1):
      NFS: Fix an incorrect type in struct nfs_direct_req

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Xinyong (1):
      usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlquSpsACgkQONu9yGCS
aT72QBAAkCwWszz+9fUf1oLpFB+HciUlAmjbsXxeuEpn3Z9Ow+QeBXjmeVQCblTE
n504XQjJ4uyPTSIiMXTzJGW2woIxILWw5MDG48opoD9Z/BmkRSaYVj2WP1QYQMRm
9pYgxrZzFX6004lnVR1H8g7z/Iu9g9+S152Bc738ugj/nyTIdR7qdoWLs9skQ/Pk
I1ZzuoyqtY1Pg5DHZRCXOqkvrXvZDRjGzJcnJdLuBFfNNDNCL/Q1VwPBkWC3ZGd2
7VPx1cvd9CANkCkcRP9/qLWf4j2WdYnbWO8S2OAxiITUWSCc9CVcMaVhunTg9kE+
MYNjTh3OmgU+rW+PEkYSsxa1IZC7uygGLN0e2Uq5deR4MiQFBUIaaYKcQWy+O2/P
O3+HCMegjXqxSLyUBQ/Ba7Nfu8EMUrvX/B+ceLIvLiXRnzkuDBI+jAdbayGmL5Qf
pc6MxFYOTY2sH0f+8iqgUqvSKHT9xpIFnqrsRXCP5eBmDtfU0VA3X+QNla0hLu7g
fG4XQFzOTh14XIuuBk5j7LrML/0sESdc14k5HaDR2nYVsF8phKiu1S5/UbHWGdU1
XhJYvrgbTXsj39hGSklew9TBgS3cOHvfILAkQ6v1GHnlpPYnvMEDmRQ69Df2ir2F
7lqDWX2OJI5cnXzwejqXyexcD0/DzKxOqErkPtlv13MuiQCRxSg=
=rwbD
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
