Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1EAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30E5218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549487493;
	bh=AFYAJ+p7uiSJaMdL1N8LBzo01eiOIUlaEMz42Oi3gow=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uT3wEOgOHpTQbBagznVIljieoMn5LYIltokENFJAfwZ5hvgBdpOwCOPJ6vo2pPaM0
	 wAPk5You7WJn/RVv0+EoGMokif1ILFj7Z8WlLW3jdz1jG+5pepsTvvPjRVmV1vRaAy
	 A+xwhEOcKYdpw912hhQHfW9NYRd7VB6HtYlIkGuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBFVLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfBFVL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:11:28 -0500
Received: from localhost (unknown [178.226.110.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA19218E0;
        Wed,  6 Feb 2019 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549487486;
        bh=AFYAJ+p7uiSJaMdL1N8LBzo01eiOIUlaEMz42Oi3gow=;
        h=Date:From:To:Cc:Subject:From;
        b=OD/HFmuXX7xhe4kA4DUcWGbwjmVI/ThqOv0swD5XEwRMH3vLNsC2GofN6eZHYo+hu
         57Lj+zZ7FFGZpUtvajVFoPaMrko1zjdsNIHRPsZzrwmg4dQ9bW+1Rzh21QgYCrHvXd
         cjUwbuCOtqTpVjQIeTKxLw7uRrKFERK2DUM3uScc=
Date:   Wed, 6 Feb 2019 22:11:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.155
Message-ID: <20190206211115.GA5110@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.155 kernel.

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

 Makefile                                          |    2=20
 arch/arm/mach-cns3xxx/pcie.c                      |    2=20
 arch/arm64/kernel/hibernate.c                     |    4 -
 arch/arm64/kernel/hyp-stub.S                      |    2=20
 arch/arm64/kernel/kaslr.c                         |    1=20
 drivers/base/core.c                               |    2=20
 drivers/mmc/host/sdhci-iproc.c                    |    5 +
 drivers/net/ethernet/freescale/ucc_geth.c         |    2=20
 drivers/net/ethernet/mellanox/mlx4/fw.c           |   75 +++++++++++++----=
-----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   19 +----
 drivers/net/ipvlan/ipvlan_main.c                  |    6 -
 drivers/platform/x86/asus-nb-wmi.c                |    3=20
 fs/cifs/connect.c                                 |   53 +++++++++++++++
 fs/cifs/smb2pdu.c                                 |    4 -
 fs/dcache.c                                       |    6 -
 fs/gfs2/rgrp.c                                    |    2=20
 fs/notify/fsnotify.c                              |    8 +-
 fs/read_write.c                                   |    4 -
 fs/super.c                                        |   30 +++++++-
 include/linux/kobject.h                           |   17 ++++
 include/linux/netdevice.h                         |    8 ++
 include/net/l3mdev.h                              |    3=20
 kernel/exit.c                                     |   12 ++-
 mm/memory-failure.c                               |    3=20
 mm/migrate.c                                      |    7 +-
 mm/oom_kill.c                                     |    8 ++
 net/ipv4/ip_fragment.c                            |    2=20
 net/ipv6/af_inet6.c                               |    3=20
 net/l2tp/l2tp_core.c                              |   43 ++++++------
 net/l2tp/l2tp_core.h                              |   31 +++++++++
 net/l2tp/l2tp_ip.c                                |    3=20
 net/l2tp/l2tp_ip6.c                               |    3=20
 net/netrom/nr_timer.c                             |   20 ++---
 net/rose/rose_route.c                             |    5 +
 34 files changed, 292 insertions(+), 106 deletions(-)

Amir Goldstein (1):
      fanotify: fix handling of events on child sub-directory

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Andrei Vagin (1):
      kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean also when kaslr =
is off

Aya Levin (2):
      net/mlx4_core: Add masking for a few queries on HCA caps
      net/mlx5e: Allow MAC invalidation while spoofchk is ON

Benjamin Herrenschmidt (1):
      drivers: core: Remove glue dirs from sysfs earlier

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Cong Wang (1):
      netrom: switch to sock timer API

Daniel Borkmann (1):
      ipvlan, l3mdev: fix broken l3s mode wrt local routes

Dave Chinner (1):
      fs: don't scan the inode cache before SB_BORN is set

David Ahern (1):
      ipv6: Consider sk_bound_dev_if when binding a socket to an address

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

Greg Kroah-Hartman (2):
      Fix "net: ipv4: do not handle duplicate fragments as overlapping"
      Linux 4.9.155

Jacob Wen (2):
      l2tp: copy 4 more bytes to linear part if necessary
      l2tp: fix reading optional fields of L2TPv3

James Morse (2):
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume

Jimmy Durand Wesolowski (1):
      fs: add the fsnotify call to vfs_iter_write

Jo=E3o Paulo Rechi Vita (2):
      platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
      platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

Koen Vandeputte (1):
      ARM: cns3xxx: Fix writing to wrong PCI config registers after alignme=
nt

Lorenzo Bianconi (1):
      l2tp: remove l2specific_len dependency in l2tp_core

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Naoya Horiguchi (1):
      mm: hwpoison: use do_send_sig_info() instead of force_sig()

Paulo Alcantara (1):
      cifs: Always resolve hostname before reconnecting

Pavel Shilovsky (1):
      CIFS: Do not count -ENODATA as failure for query directory

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Stefan Wahren (1):
      mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

Waiman Long (1):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxbTXMACgkQONu9yGCS
aT6X0hAAmBbkaRdIwgvx4z6PtGODKBJ0wAEidcTAVZMTyFwYKH993Abnk9PiN2XC
YtXLIU5ALHuug/M2OqsR1Q0cSszXXG9fgqSXEaO+DmBeyANFS4KAiIYiqOrlxkhv
seLOTGB/IY516w0FnzsMSJx3waEbhBIcxOF4eg1+0Jc9DQJhn/T+E1Kbmh1Sj2ZT
Xg5JWNlwc+ym5F5Fig8qFdIRIv3MpvcGH648jqYxxXNFTORY90q26BZY+xf5cH3C
12Tr6aXeZA1edLDk8lwSTyNgmdA5sulPvjvMpfXA91J016QuOsJtFjiRrZq0snpU
fARxeNhh00vDQPxnmyfvRII/pM0+Xr+q+R0kv2EuGfyXoYWqoJiup3uA+p4L5m/O
23QMfy+QmKplCcpL67+/u+KR2VQNSIp66MO/LM4Z5IaQm0BR0XIFoF+IzymqXGSq
HOcC+2pPcyLKZwBDAvJ1yomnJDT7Od8MjSa4+oNnhVabv6zdHlFQyMTxsCZeIviO
8AwbIiQwi/bUYPCQ4NcHkZ2v7HA44nUej0MScNOhC8UNKOCnQ8G4Pr0lm5f5D3yp
dYBaWFdAIbpJafeCtfkabdg80WZuhNLKsJtK72gxbNGQNZyWp/XvX36/QQmuG5a4
TkgoXjgSGdi6VtOp6lMAPZAY+ubaS0q0TYKr7EHN99y71PEPooU=
=cmyt
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
