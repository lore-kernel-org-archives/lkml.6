Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01946C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B585E219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B585E219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbeHFRP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:15:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:15:28 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 091BDCA1;
        Mon,  6 Aug 2018 15:05:56 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:05:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.61
Message-ID: <20180806150554.GA11930@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.61 kernel.

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

 Makefile                                          |    2=20
 arch/x86/entry/entry_64.S                         |   18 +----
 arch/x86/kernel/apic/apic.c                       |    3=20
 arch/x86/kvm/vmx.c                                |    7 --
 drivers/crypto/padlock-aes.c                      |    8 +-
 drivers/gpu/drm/vc4/vc4_plane.c                   |    3=20
 drivers/infiniband/core/uverbs_cmd.c              |   59 +++++++++++++++++-
 drivers/net/bonding/bond_main.c                   |   14 +++-
 drivers/net/can/usb/ems_usb.c                     |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    4 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c  |   40 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c     |   69 +++++++++++++++++=
+++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h   |    5 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c     |   22 +++++++
 drivers/scsi/sg.c                                 |    1=20
 drivers/virtio/virtio_balloon.c                   |    2=20
 fs/squashfs/block.c                               |    2=20
 fs/squashfs/fragment.c                            |   13 ++--
 fs/squashfs/squashfs_fs_sb.h                      |    1=20
 fs/squashfs/super.c                               |    5 -
 fs/userfaultfd.c                                  |    4 -
 kernel/auditsc.c                                  |   13 ++--
 net/dsa/slave.c                                   |    6 +
 net/ipv4/inet_fragment.c                          |   10 +--
 net/ipv4/ip_fragment.c                            |    5 +
 net/netlink/af_netlink.c                          |    2=20
 net/rxrpc/call_accept.c                           |    4 -
 net/socket.c                                      |    2=20
 28 files changed, 275 insertions(+), 50 deletions(-)

Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit

Anton Vasilyev (1):
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Boris Brezillon (1):
      drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats

Eli Cohen (1):
      net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager

Emmanuel Grumbach (1):
      iwlwifi: add more card IDs for 9000 series

Eric Dumazet (3):
      bonding: avoid lockdep confusion in bond_get_stats()
      inet: frag: enforce memory limits earlier
      ipv4: frags: handle possible skb truesize change

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Greg Kroah-Hartman (1):
      Linux 4.14.61

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption

Jack Morgenstein (1):
      RDMA/uverbs: Expand primary and alt AV port checks

Jeremy Cline (2):
      netlink: Fix spectre v1 gadget in netlink_create()
      net: socket: fix potential spectre v1 gadget in socketcall

Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning

Jose Abreu (1):
      net: stmmac: Fix WoL for PCI-based setups

Len Brown (1):
      x86/apic: Future-proof the TSC_DEADLINE quirk for SKX

Linus Torvalds (2):
      squashfs: more metadata hardening
      squashfs: more metadata hardenings

Mike Rapoport (1):
      userfaultfd: remove uffd flags from vma->vm_flags if UFFD_EVENT_FORK =
fails

Roman Kagan (1):
      kvm: x86: vmx: fix vpid leak

Tony Battersby (1):
      scsi: sg: fix minor memory leak in error path

Yi Wang (1):
      audit: fix potential null dereference 'context->module.name'

YueHaibing (1):
      rxrpc: Fix user call ID check in rxrpc_service_prealloc_one


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltoY9IACgkQONu9yGCS
aT5l4RAAyKKfraz793ad5n/+vssfXiDW4UFu4nStUWAezJ2BnfII0F5VsD+Gw1wY
FlBUwS/pwxc6JQXFelOi6+Gn7DC2LGZp0DbJBaLh3IB/XFAf/Ip5HS6tVW1WfUdj
z9q2TglgRZaAZ4ij1AGxKVge3VtImW1/EX/32poZ9vwFejeL3o6GnveeXPA2SAQT
abjSzxZYosFbQzDXS3QOMjMkfRicRZg/3Nd8iieCGxK0G03NdSwF4Hd9uRMRnyHK
U04TTM8cBU3VnrD7Tdv9uxNIvGW9vKRgOEUMFM85tyEp2/BFYsGAcSpjeWBIjn8Y
rfp0ndTLlP6LObvYKKBd+WKeesC+MZE3YRCJyKsORuDIZIJVBIgZxL7v45V6DagT
/hqgCGUI5+bydM2nVgJCBwq/sjo1AqVD/0hPMhDatl0MiCmfGZx+DOT65RC9UJrX
1Ba3hSdWfx/ZJmPN8as3x1Xs9aFTnJoqNdcPL1EBz84cGYEEb5Sw4+3MzIEDkgMR
Rl8Yp9uw0QvP+V1Fo36uwA13b7TsNu/8RJ95zlKc8yJ28ZYWTqn0wsSuu4vINjjX
me76TxZR47NwukPjNKgU8vu6pWzcmAI3g3rh77STfk+EHCfhIDqf+gvtWEtCSOOa
tdIkfCsH12E5xriBMPPrJwINV/W4Un3KBeyxi7/rPMtDhzmzG1c=
=dbhP
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
