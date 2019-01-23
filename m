Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A1D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548252535;
	bh=QF+iWOPKk51eUmDsxlDBqMDLQCxfcwpPT9lSjqTiW84=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=znUYRwpOROLS89v+M8FObHzt8jwitO6RpkcOQBjsaddZdEo5ZFQ07vqIyc5CzHQJI
	 epJKbF8pYXiDl4v/XCKXP1GKIfF/ZRyuSP3qTpROAPCyk2iCCXY8sWCdvl6AHHJWxt
	 LHGinBdWUNaFZ3+ULD70KQI2YkXUk9kQQVVo0Vfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfAWOIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAWOIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:08:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9562184D;
        Wed, 23 Jan 2019 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548252529;
        bh=QF+iWOPKk51eUmDsxlDBqMDLQCxfcwpPT9lSjqTiW84=;
        h=Date:From:To:Cc:Subject:From;
        b=hL+9XBbTgvkRuYnn0vEJFRKlAKn5mXqA/ZXjDzKzJCTWn66MRxfWvRYNxsiXL2Yds
         x+9Sr453UNHR1Wy+Fb7dj9nt5HhlM1qBm+7ArbH+bGws3NMeovXMsp/UTeJLXnxNbL
         gXU1Gjd/ty10HFmfMGri6iiCWj8vvIAfTz8AcA8c=
Date:   Wed, 23 Jan 2019 15:08:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.152
Message-ID: <20190123140846.GA27512@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.152 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/arm64/include/asm/kvm_arm.h                 |    3=20
 arch/arm64/kernel/head.S                         |    5 -
 arch/arm64/kernel/kaslr.c                        |    8 +-
 arch/arm64/kvm/hyp/switch.c                      |    2=20
 arch/mips/Kconfig                                |    1=20
 arch/mips/pci/msi-octeon.c                       |    4 -
 crypto/authenc.c                                 |   14 +++-
 crypto/authencesn.c                              |    2=20
 drivers/block/loop.c                             |   79 +++++++++++-------=
-----
 drivers/block/loop.h                             |    1=20
 drivers/block/nbd.c                              |   37 ++++------
 drivers/crypto/caam/caamhash.c                   |   15 ++--
 drivers/crypto/talitos.c                         |   27 ++-----
 drivers/gpu/drm/drm_fb_helper.c                  |    7 +-
 drivers/media/platform/vivid/vivid-kthread-cap.c |    5 +
 drivers/media/platform/vivid/vivid-kthread-out.c |    5 +
 drivers/media/platform/vivid/vivid-vid-common.c  |    2=20
 drivers/media/usb/em28xx/em28xx-video.c          |    4 -
 drivers/media/v4l2-core/videobuf2-core.c         |   14 ++--
 drivers/mfd/tps6586x.c                           |   24 ++++++
 drivers/net/bonding/bond_main.c                  |    3=20
 drivers/scsi/scsi_pm.c                           |   26 ++++---
 drivers/scsi/sd.c                                |    6 +
 drivers/tty/tty_io.c                             |   22 ++++--
 drivers/tty/tty_ldsem.c                          |   10 ++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |    2=20
 fs/block_dev.c                                   |   28 +++++---
 fs/btrfs/disk-io.c                               |    8 ++
 fs/f2fs/recovery.c                               |   31 ---------
 fs/proc/array.c                                  |    3=20
 mm/memory.c                                      |   22 ++++++
 net/bridge/br_netfilter_hooks.c                  |    2=20
 net/bridge/netfilter/ebtables.c                  |    6 +
 net/can/gw.c                                     |   30 +++++++-
 net/ipv4/ip_sockglue.c                           |   12 +--
 net/ipv6/datagram.c                              |   11 +--
 net/packet/af_packet.c                           |    4 -
 net/sctp/ipv6.c                                  |    5 -
 net/sctp/protocol.c                              |    4 -
 net/sunrpc/rpcb_clnt.c                           |    8 ++
 net/tipc/netlink_compat.c                        |   50 ++++++++++++++
 security/security.c                              |    7 ++
 security/selinux/ss/policydb.c                   |    3=20
 security/yama/yama_lsm.c                         |    4 -
 45 files changed, 368 insertions(+), 200 deletions(-)

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean to the PoC

Arnd Bergmann (1):
      mips: fix n32 compat_ipc_parse_version

Aymen Sghaier (1):
      crypto: caam - fix zero-length buffer DMA mapping

Ben Hutchings (1):
      media: em28xx: Fix misplaced reset of dev->v4l::field_count

Chao Yu (1):
      Revert "f2fs: do not recover from previous remained wrong dnodes"

Christophe Leroy (2):
      crypto: talitos - reorder code in talitos_edesc_alloc()
      crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK

Dmitry Safonov (4):
      tty/ldsem: Wake up readers after timed out down_write()
      tty: Hold tty_ldisc_lock() during tty_reopen()
      tty: Simplify tty->count math in tty_reopen()
      tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Eric Biggers (1):
      crypto: authenc - fix parsing key with misaligned rta_len

Eric Dumazet (1):
      ipv6: fix kernel-infoleak in ipv6_local_error()

Greg Kroah-Hartman (1):
      Linux 4.9.152

Guenter Roeck (1):
      proc: Remove empty line in /proc/self/status

Hans Verkuil (3):
      media: vivid: fix error handling of kthread_run
      media: vivid: set min width/height to a value > 0
      media: vb2: vb2_mmap: move lock up

Harsh Jain (1):
      crypto: authencesn - Avoid twice completion call in decrypt path

Ivan Mironov (2):
      scsi: sd: Fix cache_type_store()
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

J. Bruce Fields (1):
      sunrpc: handle ENOMEM in rpcb_getport_async

James Morris (1):
      LSM: Check for NULL cred-security on free

Jan Kara (4):
      blockdev: Fix livelocks on loop device
      loop: Fold __loop_release into loop_release
      loop: Get rid of loop_index_mutex
      nbd: Use set_blocksize() to set device blocksize

Jason Gunthorpe (1):
      packet: Do not leak dev refcounts on error exit

JianJhen Chen (1):
      net: bridge: fix a bug on using a neighbour cache entry without check=
ing its state

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend

Josef Bacik (2):
      btrfs: wait on ordered extents on abort cleanup
      nbd: set the logical and physical blocksize properly

Kees Cook (1):
      Yama: Check for pid death before checking ancestry

Mark Rutland (2):
      arm64/kvm: consistently handle host HCR_EL2 flags
      arm64: Don't trap host pointer auth use to EL2

Mauro Carvalho Chehab (1):
      media: vb2: be sure to unlock mutex on errors

Michal Hocko (1):
      mm, memcg: fix reclaim deadlock with writeback

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Sasha Levin (1):
      Revert "scsi: target: iscsi: cxgbit: fix csk leak"

Shakeel Butt (1):
      netfilter: ebtables: account ebt_table_info to kmemcg

Stanley Chu (1):
      scsi: core: Synchronize request queue PM status only on successful re=
sume

Stephen Smalley (1):
      selinux: fix GPF on invalid policy

Tetsuo Handa (2):
      block/loop: Use global lock for ioctl() operation.
      loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()

Varun Prakash (1):
      scsi: target: iscsi: cxgbit: fix csk leak

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

Willem de Bruijn (2):
      bonding: update nest level on unlink
      ip: on queued skb use skb_header_pointer instead of pskb_may_pull

Xin Long (1):
      sctp: allocate sctp_sockaddr_entry with kzalloc

Ying Xue (5):
      tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
      tipc: fix uninit-value in tipc_nl_compat_bearer_enable
      tipc: fix uninit-value in tipc_nl_compat_link_set
      tipc: fix uninit-value in tipc_nl_compat_name_table_dump
      tipc: fix uninit-value in tipc_nl_compat_doit

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxIdWsACgkQONu9yGCS
aT5OpA//dhFhVCPcYHRZNNhVWwv96ok05ppPg5AZehYaJMn03qCx3XtUxcxv0PRW
Sjys/StzX+T7TZnc18fl6Aq+U0YsX1ZTxBRyfjPufrg7HX5k+bBYnZpeLfPdYmqC
xRPO/EapatGL4CWi1ZjYfoa/tXnX4HFkP8jSYAJpW4oO5xFXFKVNAtMOa19OKhsY
AIi/gOrrM1JhtOwryYJkrwPuk5eB5NhsGKHXN9g3eC8HZEeJL31r5GrBPVE265sj
Zv5CJA9gTvmvCttRU9zNg3yyGses3R4W6JtiVsZQVKzGg/d9KQz3+ASOOiT3WONe
9DOG3VKOJQ6mGZZdjY4HtofzMJxG2kURXRAk0iBP4wG+4aDcAQm5im4zBzYoIpwG
DV3tJCjA7HCUAPhemBk6kzT5uliMTKzP9zaq4iplVDNLx+Hg32iSPGdG9DvAzXcS
Reb2waBa2/mv2Xuq7o2mmlYSVWa+JtrGoemtST+2sIGoXAhUvJUk0b/GPgppzkJ5
fzsryIrEUOfikdnmONedcQP+stcAj+gIj5xzV2COSCtnG5h+oYtt44p5z3KqY9Fd
i12QLyitQW4pXJDoVbwPLJvGlAogdoqJuMh3to2HhN8pboBTBGxmkZpD9hT3ru5o
n6p1RftJYlYqZMJiCz2ZT7gP1rrscoYn4G5JSZrnuMtLboK7pkU=
=lcIm
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
