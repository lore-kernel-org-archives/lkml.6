Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705BB218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549487467;
	bh=WZY4smVCnFN/7gi0vi9pev5OliI8l4EiF53S6xJCv1A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Q3VCmMllcFK3thLLNB+PHuHpqVyZZwW8kDMyaCMdJo5w5l0rxk3tE/Ip4gJWKkVP3
	 Zrq3zdI1T6hBBwkwdaooE9TLFPFg/NnyCia6+qoOj1pzFs2EgX5kqwEP7Miew3o9pX
	 kBUz3r2U0KSPlOlDZKq0EOy+qE55oReTifzy+E8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBFVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBFVLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:11:05 -0500
Received: from localhost (unknown [178.226.110.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09067218D9;
        Wed,  6 Feb 2019 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549487464;
        bh=WZY4smVCnFN/7gi0vi9pev5OliI8l4EiF53S6xJCv1A=;
        h=Date:From:To:Cc:Subject:From;
        b=X7IwrXX4ggLwDie9IsePVVu7QTPDwCmm6V47dI1c+jNlPbK2/bJ4VtvTpH1j508SL
         W3a531yyMfkWfeFMEhLIc5zwCvPleKQ3jtkyhk/bn1yz3VlaznYQ8UIcgkls3Oz99/
         k2xQC1DPay+tH0oTExW4zS668APdV2k9p5p0+XnA=
Date:   Wed, 6 Feb 2019 22:10:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.173
Message-ID: <20190206211053.GA5037@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.173 kernel.

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

 Makefile                                     |    2=20
 arch/arc/include/asm/perf_event.h            |    3 -
 arch/arm/mach-cns3xxx/pcie.c                 |    2=20
 arch/arm64/kernel/hyp-stub.S                 |    2=20
 arch/arm64/mm/flush.c                        |    4 -
 arch/s390/kernel/early.c                     |    4 -
 arch/s390/kernel/setup.c                     |    2=20
 arch/s390/kernel/smp.c                       |   12 +++-
 arch/x86/boot/compressed/aslr.c              |    4 -
 arch/x86/kvm/x86.c                           |    3 -
 drivers/base/core.c                          |    2=20
 drivers/block/loop.c                         |   47 +++++++++-------
 drivers/char/mwave/mwavedd.c                 |    7 ++
 drivers/input/joystick/xpad.c                |    3 +
 drivers/irqchip/irq-gic-v3-its.c             |   25 ++++-----
 drivers/mmc/host/sdhci-iproc.c               |    5 +
 drivers/net/can/dev.c                        |   27 ++++-----
 drivers/net/ethernet/freescale/ucc_geth.c    |    2=20
 drivers/net/ethernet/mellanox/mlx4/fw.c      |   75 ++++++++++++++++------=
-----
 drivers/net/ppp/pppoe.c                      |    1=20
 drivers/platform/x86/asus-nb-wmi.c           |    3 -
 drivers/s390/char/sclp_config.c              |    2=20
 drivers/staging/rtl8188eu/os_dep/usb_intf.c  |    1=20
 drivers/tty/n_hdlc.c                         |    1=20
 drivers/tty/tty_io.c                         |    3 -
 drivers/tty/vt/vt.c                          |    1=20
 drivers/usb/serial/pl2303.c                  |    1=20
 drivers/usb/serial/pl2303.h                  |    2=20
 drivers/usb/serial/usb-serial-simple.c       |    3 -
 fs/cifs/connect.c                            |   53 +++++++++++++++++++
 fs/cifs/smb2ops.c                            |    6 +-
 fs/cifs/smb2pdu.c                            |    4 -
 fs/dcache.c                                  |    6 --
 fs/f2fs/node.c                               |    4 +
 fs/gfs2/rgrp.c                               |    2=20
 fs/read_write.c                              |    4 +
 fs/super.c                                   |   30 ++++++++--
 include/linux/kobject.h                      |   17 ++++++
 include/linux/skbuff.h                       |    1=20
 include/net/ip_fib.h                         |    2=20
 kernel/exit.c                                |   12 +++-
 mm/migrate.c                                 |    7 +-
 mm/oom_kill.c                                |    8 ++
 net/bridge/br_forward.c                      |    7 +-
 net/bridge/br_netfilter_ipv6.c               |    1=20
 net/bridge/netfilter/nft_reject_bridge.c     |    1=20
 net/can/bcm.c                                |   27 +++++++++
 net/ipv4/fib_frontend.c                      |    4 -
 net/ipv4/fib_trie.c                          |   14 ++++-
 net/ipv4/ip_input.c                          |    1=20
 net/ipv6/af_inet6.c                          |    3 +
 net/l2tp/l2tp_core.c                         |   43 +++++++--------
 net/l2tp/l2tp_core.h                         |   31 +++++++++++
 net/l2tp/l2tp_ip.c                           |    3 +
 net/l2tp/l2tp_ip6.c                          |    3 +
 net/netrom/nr_timer.c                        |   20 +++----
 net/openvswitch/flow_netlink.c               |    2=20
 net/rose/rose_route.c                        |    5 +
 net/sched/sch_api.c                          |    3 -
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |    8 ++
 tools/perf/util/unwind-libdw.c               |    4 -
 61 files changed, 419 insertions(+), 166 deletions(-)

Alexander Popov (1):
      KVM: x86: Fix single-step debugging

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Andrei Vagin (1):
      kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Aya Levin (1):
      net/mlx4_core: Add masking for a few queries on HCA caps

Benjamin Herrenschmidt (1):
      drivers: core: Remove glue dirs from sysfs earlier

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Christian Borntraeger (1):
      s390/early: improve machine detection

Cong Wang (2):
      net_sched: refetch skb protocol for each filter
      netrom: switch to sock timer API

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Chinner (1):
      fs: don't scan the inode cache before SB_BORN is set

David Ahern (1):
      ipv6: Consider sk_bound_dev_if when binding a socket to an address

David Hildenbrand (2):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

Eugeniy Paltsev (1):
      ARC: perf: map generic branches to correct hardware condition

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Greg Kroah-Hartman (5):
      tty: Handle problem if line discipline does not have receive_buf
      Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_contro=
l_ioctl()"
      Revert "loop: Get rid of loop_index_mutex"
      Revert "loop: Fold __loop_release into loop_release"
      Linux 4.4.173

Gustavo A. R. Silva (1):
      char/mwave: fix potential Spectre v1 vulnerability

Ido Schimmel (1):
      net: ipv4: Fix memory leak in network namespace dismantle

Jacob Wen (2):
      l2tp: copy 4 more bytes to linear part if necessary
      l2tp: fix reading optional fields of L2TPv3

James Morse (1):
      arm64: hyp-stub: Forbid kprobing of the hyp-stub

Jimmy Durand Wesolowski (1):
      fs: add the fsnotify call to vfs_iter_write

Jo=E3o Paulo Rechi Vita (2):
      platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
      platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Koen Vandeputte (1):
      ARM: cns3xxx: Fix writing to wrong PCI config registers after alignme=
nt

Lorenzo Bianconi (1):
      l2tp: remove l2specific_len dependency in l2tp_core

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb=
 by removing it

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

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

Paulo Alcantara (1):
      cifs: Always resolve hostname before reconnecting

Pavel Shilovsky (2):
      CIFS: Fix possible hang during async MTU reads and writes
      CIFS: Do not count -ENODATA as failure for query directory

Ross Lagerwall (2):
      net: Fix usage of pskb_trim_rcsum
      openvswitch: Avoid OOB read when parsing flow nlattrs

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Shaokun Zhang (1):
      arm64: mm: remove page_mapping check in __sync_icache_dcache

Stefan Wahren (1):
      mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Waiman Long (1):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxbTV0ACgkQONu9yGCS
aT6ISRAAx+Eibeg919AVoPns16iHNyH0JeFz8rP2YUoByPhLAeBKnr56dI0d+OoQ
wMQTF9hi6PryGbrvV+GjL7adLjc1QG0WVre3aKDcotxku/4FJ+X6KqwsmjTPAyjD
PHqYNhcKrkQ93YuRxa7LDnHyJhWmJny2OoYrh/E6cihxi5ydTg4/8xPUN/7r1e3Z
M1qamuJouRi52UhF1NrImLUaAw9EYhOdf3iCArVfMq1bhjkWvFJbOjzPnyZNGKTJ
hE+iqplPmXL7yEFlzvbz0KLRJG+BvvHYjz4HEAR0D81C3/bXtnC19gCLjDyFGRWq
P/Ns/Q9CN980wbc/9A7++sfoBIBsAUQcm2+ijLqIhzX02/caymCUJjfQk5s5Qd1W
hjxXs/maQbLFQioUH2+mnu+W2HwGcrZqN3NWNOKIbXxrnSCd7H8wI96Y9E6QsSyG
3W847PmIUAKikA6XYyskxtcvbklpgXtEivJW9aLzr62FAHbLnE727fZdi4rCVPgG
16lKdVtEGehnJJujlCxVvjLhjv3gJ4VAs2eyiGYYCR5ME8Q6+jyqNhhbaoHzwwqc
spK5pdd9HP77a5x8/tJd7pQhqOcYquvpd4kztP7dZhrfAmkgDjM26NW4oGkECN52
GfqQGtNr31TdxYmaPLAXOyrdMOZQRhEMSOigamHUL8hnNI+kW/0=
=rZ+w
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
