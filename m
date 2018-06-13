Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3A9BFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4184208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tURx/pWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4184208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935692AbeFMOw3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935183AbeFMOw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:52:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF07F208B0;
        Wed, 13 Jun 2018 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528901547;
        bh=9qdyDEU/xALGpBLlHklk9bFPSSntaERR24qHRAH3+lY=;
        h=Date:From:To:Cc:Subject:From;
        b=tURx/pWrE1PGbp+nBn4xuBetpJpexgFHLzOUFiZOOAOf8o38yhT63LELdaoChl8pK
         yz7ICCD8anJFVfdOjfR+uNtOFkKHyBxEEPqkYXd7YLZQ4ElUgB1/e8KI94+xAhiJ6k
         nNVQVMNkkQHmtyCMpGyriRePs7z7NCXuLJNtyPoI=
Date:   Wed, 13 Jun 2018 16:52:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.113
Message-ID: <20180613145205.GA5719@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.113 kernel.

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

 Makefile                                         |    2 -
 arch/mips/kernel/ptrace.c                        |    2 -
 arch/mips/kernel/ptrace32.c                      |    2 -
 drivers/gpu/drm/drm_fops.c                       |    1=20
 drivers/gpu/drm/i915/intel_lvds.c                |    8 +++++
 drivers/isdn/hardware/eicon/diva.c               |   22 ++++++++++-----
 drivers/isdn/hardware/eicon/diva.h               |    5 ++-
 drivers/isdn/hardware/eicon/divasmain.c          |   18 +++++++-----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2 -
 drivers/net/ethernet/cisco/enic/enic_main.c      |    8 ++---
 drivers/net/ethernet/mellanox/mlx4/qp.c          |    4 +-
 drivers/net/team/team.c                          |    3 +-
 drivers/net/usb/cdc_mbim.c                       |    2 -
 fs/aio.c                                         |    3 --
 include/linux/tcp.h                              |    2 -
 include/uapi/linux/nl80211.h                     |    2 -
 kernel/trace/trace_events_trigger.c              |    5 ++-
 mm/mmap.c                                        |   32 ++++++++++++++++++=
+++++
 mm/vmscan.c                                      |    2 -
 net/core/rtnetlink.c                             |    8 ++---
 net/dccp/proto.c                                 |    2 -
 net/ipv4/tcp_input.c                             |   10 ++++---
 net/ipv6/ip6mr.c                                 |    3 +-
 net/packet/af_packet.c                           |    2 -
 security/selinux/ss/services.c                   |    2 -
 25 files changed, 104 insertions(+), 48 deletions(-)

Al Viro (1):
      fix io_destroy()/aio_complete() race

Alexey Kodanev (1):
      dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Dan Carpenter (1):
      team: use netdev_features_t instead of u32

Daniele Palmas (1):
      net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Dave Airlie (1):
      drm: set FMODE_UNSIGNED_OFFSET for drm files

Eric Biggers (1):
      cfg80211: further limit wiphy names to 64 bytes

Eric Dumazet (3):
      tcp: avoid integer overflows in tcp_rcv_space_adjust()
      net/packet: refine check for priv area size
      rtnetlink: validate attributes in do_setlink()

Govindarajulu Varadarajan (1):
      enic: set DMA mask to 47 bit

Greg Kroah-Hartman (1):
      Linux 3.18.113

Hugh Dickins (1):
      mm: fix the NULL mapping case in __isolate_lru_page()

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Julia Lawall (1):
      bnx2x: use the right constant

Linus Torvalds (2):
      mmap: introduce sane default mmap limits
      mmap: relax file size limit for regular files

Maciej W. Rozycki (1):
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Sabrina Dubroca (1):
      ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succ=
eeds

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Steven Rostedt (VMware) (1):
      tracing: Fix crash when freeing instances with event triggers

Wenwen Wang (1):
      isdn: eicon: fix a missing-check bug


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlshL5EACgkQONu9yGCS
aT6jTRAAiifR38lGqggS8IqNMHlK2E31xgkE5CX5WY/ysyTXC4lied2JCJCpEZR8
ZCqN3ql8Q153Yr5yfAgo0JvvqvuCQ6dgis8BskG2Xiuej8oAEtIGm1m5oWqNgl3t
RjaG/+UZBIgCl7yPDIwB6joj7o2ZfdnXFqrM8MqPioe8S9z4rcRDU7S/ucKMHZ/6
Tn0NTXTnVCbcpSTCz/2+3hzEEHdaFU6fPbbi+M0/IpMR7FPH3USYgASXpDEOCH3b
yFiC8HDx9epCoGNZrJKmePtLaFlMKoQ8YZ+UmACymKC492g981G9rlYFbmh7T+ft
Nu6peUDGw99trYFYEvsDDCd7Q9pAELOLNklZV9o4q8aUJ13/pJkT27Jksjv6WUlP
qV+vEvDpIbzAXrz2JZoG7SvJGM+k9BeDUILdcVxiSDcBUdK+aPl5bVAOIJr+kbgr
0BK6WmJgfgiZygf8ZSQ+qIbMfGzwf3GUqqoGt28OhiTg2y3ErPhM/MNQYAHGRmEp
E+Za9WoEfHa6XufK51XH5TGMBwu2ACI8W7KI1d5N/8QrGUDodYkYreKYVcCMA3l5
JhqhMdAgLJKgXFnerH5uz7LYh+0XT8mo2Gmc1+NQQ9hgX3aUZNRl2kMi05JLkL8/
K097LMr6PjNksLl5cmFrs3vDrUowMT5bDL4xLB1fjETZ+3K87Ws=
=aSMf
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
