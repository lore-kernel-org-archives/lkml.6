Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33740C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB64218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549487453;
	bh=pVqaXhrDjaOg4LRaNSE+COulbcp+8Mnk9ba+Rtvxcpw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gi7GlaM8JY6QJzoMbyQlIM3OxM1SAH2VjMY9mupv4BlUbUTyr2zomMJAQUfAHRqrp
	 /X35YQKHtUSJpEsnUdpMqO8i4igHGGji+FmxOA3uPoOycTQe9lO2J4qBxCQQcnuXor
	 lkJL8J4lyBsG2XU8W3fcP6pVO4BL9iAoJEdHwxRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfBFVKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:10:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBFVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:10:50 -0500
Received: from localhost (unknown [178.226.110.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5D4218B0;
        Wed,  6 Feb 2019 21:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549487449;
        bh=pVqaXhrDjaOg4LRaNSE+COulbcp+8Mnk9ba+Rtvxcpw=;
        h=Date:From:To:Cc:Subject:From;
        b=w8WsgR8BYhCFby13bcCk3UCGaVW4L1MarpWVG3EvphTaFzeiqko2d2HCezTTAJWjm
         2K2zv+VmxNXkchtYA6pHHPpU6iXOlE6rVX3jffTW+M0HiXO6rVvduT0G2zwhRLD6Pd
         lWOukSS5h4HIblFl07JpzCKg5dSDqP9tOxcRGZg0=
Date:   Wed, 6 Feb 2019 22:10:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.134
Message-ID: <20190206211033.GA4973@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.134 kernel.

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

 Makefile                                    |    2 -
 arch/s390/kernel/smp.c                      |    4 ++
 arch/x86/boot/compressed/aslr.c             |    4 +-
 drivers/input/joystick/xpad.c               |    3 +
 drivers/net/can/dev.c                       |   27 ++++++++---------
 drivers/net/ethernet/freescale/ucc_geth.c   |    2 +
 drivers/platform/x86/asus-nb-wmi.c          |    3 -
 drivers/s390/char/sclp_config.c             |    2 +
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1=20
 drivers/tty/n_hdlc.c                        |    1=20
 drivers/tty/tty_io.c                        |    3 +
 drivers/tty/vt/vt.c                         |    1=20
 drivers/usb/serial/pl2303.c                 |    1=20
 drivers/usb/serial/pl2303.h                 |    2 +
 drivers/usb/serial/usb-serial-simple.c      |    3 +
 fs/cifs/smb2ops.c                           |    6 +--
 fs/cifs/smb2pdu.c                           |    4 +-
 fs/dcache.c                                 |    6 ---
 fs/f2fs/node.c                              |    4 +-
 fs/gfs2/rgrp.c                              |    2 -
 mm/migrate.c                                |    7 +++-
 mm/oom_kill.c                               |    8 +++++
 net/can/bcm.c                               |   27 +++++++++++++++++
 net/ipv6/af_inet6.c                         |    3 +
 net/l2tp/l2tp_core.c                        |   43 ++++++++++++++---------=
-----
 net/l2tp/l2tp_core.h                        |   31 ++++++++++++++++++++
 net/l2tp/l2tp_ip.c                          |    3 +
 net/l2tp/l2tp_ip6.c                         |    3 +
 net/netrom/nr_timer.c                       |   20 ++++++-------
 net/openvswitch/flow_netlink.c              |    2 -
 net/rose/rose_route.c                       |    5 +++
 tools/perf/util/unwind-libdw.c              |    4 +-
 32 files changed, 168 insertions(+), 69 deletions(-)

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Cong Wang (1):
      netrom: switch to sock timer API

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters

David Ahern (1):
      ipv6: Consider sk_bound_dev_if when binding a socket to an address

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Greg Kroah-Hartman (2):
      tty: Handle problem if line discipline does not have receive_buf
      Linux 3.18.134

Jacob Wen (2):
      l2tp: copy 4 more bytes to linear part if necessary
      l2tp: fix reading optional fields of L2TPv3

Jo=E3o Paulo Rechi Vita (2):
      platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
      platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

Lorenzo Bianconi (1):
      l2tp: remove l2specific_len dependency in l2tp_core

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb=
 by removing it

Martin Vuille (1):
      perf unwind: Unwind with libdw doesn't take symfs into account

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Milian Wolff (1):
      perf unwind: Take pgoff into account when reporting elf to libdwfl

Nicolas Pitre (1):
      vt: invoke notifier on screen size change

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Pan Bian (1):
      f2fs: read page index before freeing

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Pavel Shilovsky (2):
      CIFS: Fix possible hang during async MTU reads and writes
      CIFS: Do not count -ENODATA as failure for query directory

Ross Lagerwall (1):
      openvswitch: Avoid OOB read when parsing flow nlattrs

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Waiman Long (1):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxbTUUACgkQONu9yGCS
aT7hQBAAwBhH828hnmQ1BOzmQe8h8fy1SeBCc9qovZta4x6QNP8GZ9Hxag8xBuv9
KcKWxFulQJTfQpqkWi2onvVNhj4XRe6aS49JYfZ2karX1IYxp6DM16XARVmt+2xM
pFo8KPoZxhwiGhFGK4RPs0JhApEKlatyrkwLILtbSJbm9PthakGU7pOd2BOhwk8a
6ySYzZe/+4+qjEyHVefQpN5fgux05rWjREjysQZijxE7qs4zfF3VDB2cuJ85nDiV
ybybUcysks+mdSZFr9UU+ARqxHUryzY1xX1sO+4JQPDf9UhLwl9EPk9HfNs30oi6
mFPPpeL6Fei+X+Vy2P/sK7AkwHg29txlbKdoX17TTmW0ohcmBMyPb9ETtwNyeMaU
lgRvEj+UDN6rHuzjRxZJvtfz7doEBCn+L8VydAhxyrGoQ1hxZV3c8ldW+vCBvO2D
rilozC0iE8kO65kckiir6Ns52VZxbscuyHMpugjypdprv8zoGQ8hUdaVm90AxvEY
bsMReUxehSr2d8fUFynojB48a5ekkhmdyb5yK67GAbNaZXMTfi8yd7WdB2AIwI9P
G8YfNoOgVnBEZQBHCzii04CNFwxOdX7WISYfkeG/UA4v7MoPEQaxU4hbfQcXxbfD
9M+NNHOKogQOL3/8sgkB7eS9SSoh14Mw7/UaA70rqtl7pJU7fZo=
=atC5
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
