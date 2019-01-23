Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92302133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548252561;
	bh=p5WUnd3mtf7MpLr85RgH7XZ/klEBi48PZKeMOvrRdHQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zTJ9uQ/PZ8vRl7RXkTpaZPcLGhVp1WoY1ZeZrpUl1WZdUvoFGagvteNJTbqIf/MM7
	 cMNngX/5rLjc1ENhqcoCAznLyyAeVmjPr6PPruaRW8N7gOoJ8ScTSXO3bXEhRkTIoM
	 zkAhAGxRjT6E0B4zoQ5c3CSkAe1MjvZtc3rWFKnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfAWOJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfAWOJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:09:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DEB2133D;
        Wed, 23 Jan 2019 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548252557;
        bh=p5WUnd3mtf7MpLr85RgH7XZ/klEBi48PZKeMOvrRdHQ=;
        h=Date:From:To:Cc:Subject:From;
        b=DSdn+ymGzpsCiN8SZf7QvXHI0HfDE/fmFCw147LJOPw6cw5lA5Oa1e3kN0oCZChDT
         3GlXJWYca49Fl+ae5ulycW77IoF6xEz1EAkxgGmH8KuuOAObdTXTrKzs26rWwLWoeK
         YyPoHygPh25xTYtSUPk3Tisk+nKCOCAgBFls1vU0=
Date:   Wed, 23 Jan 2019 15:09:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.95
Message-ID: <20190123140915.GA27656@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.95 kernel.

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

 Makefile                                         |    2=20
 arch/arm64/include/asm/kvm_arm.h                 |    3=20
 arch/arm64/kernel/head.S                         |    5=20
 arch/arm64/kernel/kaslr.c                        |    8 -
 arch/arm64/kvm/hyp/switch.c                      |    2=20
 arch/mips/Kconfig                                |    1=20
 arch/mips/lantiq/irq.c                           |   68 -----------
 arch/mips/pci/msi-octeon.c                       |    4=20
 crypto/authenc.c                                 |   14 +-
 crypto/authencesn.c                              |    2=20
 drivers/block/loop.c                             |  140 +++++++++++++-----=
-----
 drivers/block/loop.h                             |    1=20
 drivers/block/nbd.c                              |    5=20
 drivers/crypto/Kconfig                           |    1=20
 drivers/crypto/bcm/cipher.c                      |   44 ++-----
 drivers/crypto/caam/caamhash.c                   |   15 +-
 drivers/crypto/talitos.c                         |   27 +---
 drivers/gpu/drm/drm_fb_helper.c                  |    7 -
 drivers/media/platform/vivid/vivid-kthread-cap.c |    5=20
 drivers/media/platform/vivid/vivid-kthread-out.c |    5=20
 drivers/media/platform/vivid/vivid-vid-common.c  |    2=20
 drivers/media/usb/em28xx/em28xx-video.c          |    4=20
 drivers/media/v4l2-core/v4l2-ioctl.c             |    4=20
 drivers/media/v4l2-core/videobuf2-core.c         |   14 +-
 drivers/mfd/tps6586x.c                           |   24 +++
 drivers/mmc/host/sdhci-msm.c                     |   51 ++++++++
 drivers/net/bonding/bond_main.c                  |    3=20
 drivers/of/property.c                            |    1=20
 drivers/scsi/scsi_pm.c                           |   26 ++--
 drivers/scsi/sd.c                                |    6=20
 drivers/tty/tty_io.c                             |   22 ++-
 drivers/tty/tty_ldsem.c                          |   10 +
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |    2=20
 fs/block_dev.c                                   |   28 ++--
 fs/btrfs/disk-io.c                               |    8 +
 fs/btrfs/inode.c                                 |    3=20
 fs/pstore/ram.c                                  |    9 -
 kernel/sched/fair.c                              |   14 +-
 kernel/sched/sched.h                             |    4=20
 net/bridge/br_netfilter_hooks.c                  |    2=20
 net/bridge/netfilter/ebtables.c                  |    6=20
 net/can/gw.c                                     |   30 ++++
 net/core/filter.c                                |   21 +--
 net/core/lwt_bpf.c                               |    1=20
 net/ipv4/ip_sockglue.c                           |   12 -
 net/ipv6/datagram.c                              |   11 -
 net/packet/af_packet.c                           |    4=20
 net/sctp/ipv6.c                                  |    5=20
 net/sctp/protocol.c                              |    4=20
 net/sunrpc/rpcb_clnt.c                           |    8 +
 net/tipc/netlink_compat.c                        |   50 ++++++++
 security/security.c                              |    7 +
 security/selinux/ss/policydb.c                   |    3=20
 security/yama/yama_lsm.c                         |    4=20
 54 files changed, 476 insertions(+), 286 deletions(-)

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean to the PoC

Arnd Bergmann (1):
      mips: fix n32 compat_ipc_parse_version

Aymen Sghaier (1):
      crypto: caam - fix zero-length buffer DMA mapping

Ben Hutchings (1):
      media: em28xx: Fix misplaced reset of dev->v4l::field_count

Christophe Leroy (2):
      crypto: talitos - reorder code in talitos_edesc_alloc()
      crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK

David Sterba (1):
      Revert "btrfs: balance dirty metadata pages in btrfs_finish_ordered_i=
o"

Dmitry Safonov (4):
      tty/ldsem: Wake up readers after timed out down_write()
      tty: Hold tty_ldisc_lock() during tty_reopen()
      tty: Simplify tty->count math in tty_reopen()
      tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Eric Biggers (2):
      crypto: bcm - convert to use crypto_authenc_extractkeys()
      crypto: authenc - fix parsing key with misaligned rta_len

Eric Dumazet (1):
      ipv6: fix kernel-infoleak in ipv6_local_error()

Greg Kroah-Hartman (1):
      Linux 4.14.95

Hans Verkuil (3):
      media: vivid: fix error handling of kthread_run
      media: vivid: set min width/height to a value > 0
      media: vb2: vb2_mmap: move lock up

Harsh Jain (1):
      crypto: authencesn - Avoid twice completion call in decrypt path

Hauke Mehrtens (1):
      MIPS: lantiq: Fix IPI interrupt handling

Ivan Mironov (2):
      scsi: sd: Fix cache_type_store()
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

J. Bruce Fields (1):
      sunrpc: handle ENOMEM in rpcb_getport_async

Jaegeuk Kim (1):
      loop: drop caches if offset or block_size are changed

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

Josef Bacik (1):
      btrfs: wait on ordered extents on abort cleanup

Julia Lawall (1):
      OF: properties: add missing of_node_put

Kees Cook (2):
      Yama: Check for pid death before checking ancestry
      pstore/ram: Avoid allocation and leak of platform data

Loic Poulain (1):
      mmc: sdhci-msm: Disable CDR function on TX

Mark Rutland (2):
      arm64/kvm: consistently handle host HCR_EL2 flags
      arm64: Don't trap host pointer auth use to EL2

Mauro Carvalho Chehab (1):
      media: vb2: be sure to unlock mutex on errors

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Sakari Ailus (1):
      media: v4l: ioctl: Validate num_planes for debug messages

Sasha Levin (1):
      Revert "scsi: target: iscsi: cxgbit: fix csk leak"

Shakeel Butt (1):
      netfilter: ebtables: account ebt_table_info to kmemcg

Stanley Chu (1):
      scsi: core: Synchronize request queue PM status only on successful re=
sume

Stephen Smalley (1):
      selinux: fix GPF on invalid policy

Tetsuo Handa (3):
      block/loop: Don't grab "struct file" for vfs_getattr() operation.
      block/loop: Use global lock for ioctl() operation.
      loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()

Varun Prakash (1):
      scsi: target: iscsi: cxgbit: fix csk leak

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

Willem de Bruijn (3):
      bonding: update nest level on unlink
      ip: on queued skb use skb_header_pointer instead of pskb_may_pull
      bpf: in __bpf_redirect_no_mac pull mac only if present

Xin Long (1):
      sctp: allocate sctp_sockaddr_entry with kzalloc

Xunlei Pang (1):
      sched/fair: Fix bandwidth timer clock drift condition

Ying Xue (5):
      tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
      tipc: fix uninit-value in tipc_nl_compat_bearer_enable
      tipc: fix uninit-value in tipc_nl_compat_link_set
      tipc: fix uninit-value in tipc_nl_compat_name_table_dump
      tipc: fix uninit-value in tipc_nl_compat_doit

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxIdYoACgkQONu9yGCS
aT5wZxAAuhBoUhfM9J1ZRhXlK3lfJ4z0/fqo2rSRlav509RMnj+hO2SGw4SKpovQ
0JKpKedN8xgiqdBxVUwQ5Q/c1sW0d3RHnUVKLdLdWCTkcf+aLCHzs7ROa0Hd7ytz
LSl+NUEPQWptHlZYQ4hj3NLmJAK6jnfWUzI2+eLtQb0jsv1H7hBlS7DOFXil8BvQ
EFQq45Q74q59yj4e7c9uUFj4E36s+asHKY74PxyzZrKcThlb2A5JADe04/Wuo5Kv
owNrfZDdl0+go+ssSR7krg2dcfSfQIvDvE4GgCNEmBTJLBsGtEB3JJYe7/+8M6Xn
yhBpp+7B172MgabTzBHs4doLA3RkSK7TYPLvkvgUcl9KAgoGCHEzEaANi27cXwC+
DF8TAJYXJgEFvr6NkU6DSHBGK3rxhVI3XbbPY+74JxY+8ItKWfK9bXAGBLoX0nYC
1MVSdjnQRvi+aB5Q9uQaXua5tsb6potjvQt5ornbaYxaSQlPbFe9h5/7kSzUBRW3
PDlJsGm2KJ7dOXoCtt3xjjAm8Wl1slcmlqG8MIrzeKVWGs1EzdLHt2cAiV91GL56
JySZSUBNz4xg3co1PX8wrwjZZqcGUH+Qycv4V0QtiFe/0mQJml2nTczmA/TE/GNT
MKpjkKNjlct4KIOmBYjkfDYWmDe50AbVYKf+Kb7p8lonZxCh7e8=
=zYVQ
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
