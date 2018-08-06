Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8FCC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99825219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99825219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeHFRO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:14:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbeHFRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:14:59 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3510BCA1;
        Mon,  6 Aug 2018 15:05:28 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:05:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.13
Message-ID: <20180806150525.GA11838@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.13 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/x86/entry/entry_64.S                               |   18 ----
 arch/x86/kernel/apic/apic.c                             |    3=20
 arch/x86/kvm/vmx.c                                      |    7 -
 arch/x86/platform/efi/efi_64.c                          |    2=20
 drivers/crypto/padlock-aes.c                            |    8 +
 drivers/gpu/drm/drm_atomic_helper.c                     |    8 +
 drivers/gpu/drm/vc4/vc4_plane.c                         |    3=20
 drivers/infiniband/core/uverbs_cmd.c                    |   59 +++++++++++=
+-
 drivers/net/bonding/bond_main.c                         |   14 ++-
 drivers/net/can/usb/ems_usb.c                           |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c      |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c       |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c   |    4=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c        |   40 ++++++++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c |    3=20
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c           |   69 +++++++++++=
+++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h         |    5 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c           |   22 +++++
 drivers/scsi/sg.c                                       |    1=20
 drivers/virtio/virtio_balloon.c                         |    2=20
 fs/squashfs/block.c                                     |    2=20
 fs/squashfs/fragment.c                                  |   13 ++-
 fs/squashfs/squashfs_fs_sb.h                            |    1=20
 fs/squashfs/super.c                                     |    5 -
 fs/userfaultfd.c                                        |    4=20
 ipc/shm.c                                               |   12 ++
 kernel/auditsc.c                                        |   13 ++-
 mm/hugetlb.c                                            |    7 +
 net/dsa/slave.c                                         |    6 +
 net/ipv4/inet_fragment.c                                |    6 -
 net/ipv4/ip_fragment.c                                  |    5 +
 net/netlink/af_netlink.c                                |    2=20
 net/rxrpc/call_accept.c                                 |    4=20
 net/socket.c                                            |    5 -
 35 files changed, 308 insertions(+), 54 deletions(-)

Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit

Anton Vasilyev (1):
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Boris Brezillon (3):
      drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats
      drm/atomic: Check old_plane_state->crtc in drm_atomic_helper_async_ch=
eck()
      drm/atomic: Initialize variables in drm_atomic_helper_async_check() t=
o make gcc happy

Brijesh Singh (1):
      x86/efi: Access EFI MMIO data as unencrypted when SEV is active

Eli Cohen (1):
      net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager

Emmanuel Grumbach (1):
      iwlwifi: add more card IDs for 9000 series

Eric Dumazet (3):
      bonding: avoid lockdep confusion in bond_get_stats()
      inet: frag: enforce memory limits earlier
      ipv4: frags: handle possible skb truesize change

Feras Daoud (1):
      net/mlx5e: IPoIB, Set the netdevice sw mtu in ipoib enhanced flow

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Greg Kroah-Hartman (1):
      Linux 4.17.13

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption

Jack Morgenstein (1):
      RDMA/uverbs: Expand primary and alt AV port checks

Jane Chu (1):
      ipc/shm.c add ->pagesize function to shm_vm_ops

Jeremy Cline (3):
      netlink: Fix spectre v1 gadget in netlink_create()
      net: socket: fix potential spectre v1 gadget in socketcall
      net: socket: Fix potential spectre v1 gadget in sock_is_registered

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

Or Gerlitz (1):
      net/mlx5e: Set port trust mode to PCP as default

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmfmac: fix regression in parsing NVRAM for multiple devices

Roman Kagan (1):
      kvm: x86: vmx: fix vpid leak

Tony Battersby (1):
      scsi: sg: fix minor memory leak in error path

Yi Wang (1):
      audit: fix potential null dereference 'context->module.name'

YueHaibing (1):
      rxrpc: Fix user call ID check in rxrpc_service_prealloc_one


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltoY7IACgkQONu9yGCS
aT53MQ/+MXeCJWHHCuAfPFqyPlY4Um14x5l2FIG/tq3cnAMh+MzZL3RvfXEZeJda
Q2MIFiRGl/MZ3vofJAtcfnE9/R2xYf/M2yoESo8WG7IlKn5ab4inFmkFYY15J31E
l4OKceki4GXc4AEOQiqTGqmHCva45L8KJxMuFJlnKd5QmgiuXc1tIhBNmBTgBaDm
G8ov0ex864AJx+DhUPst8jkBCCUj70LPbrMOE8w9DE4kFL+I/kf2uPKrOcau2pt0
JWAcwCCGSkpVDV9jsi8M4j0oQoWNDVI+WpZC+ZGAHjVtwC9svKDXIpVReijW7iA0
b+d5ELUZh3C4F8UP8zh0YpFZ5v6qvflrz3tfWsqSbPUJ1wwupcV9ywRquPJNtUob
9zHpBS4puOQv+9V4hKOFvAtF67vNoNuEaShXFqwPpCmyP9LGWfDGBBrFoLx+NYad
wqumlKJt7AatrE+wUQ0U99mUoHf7AtPRsXDBWu0JwsiqMdkxkcdplIbxLzSOPmK6
3sIX9GNjNkjiqrHgWJ35Oj+g2L0WkOkI/y9cGeeYlSixMLxT4bK8F+j74bERG6hR
MJ7wi1LhCXntgZOwjuu+t2qUKk1MtV9Oj5tw/4O4L+7Qmba7c7ubM76OXL+59Wa7
+Bqbd0E+DHUibr1ZbipnNEWKIjnWJrABKLblCEuT5YC5HNk20mc=
=4iu7
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
