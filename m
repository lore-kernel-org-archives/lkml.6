Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C4BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25022218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549487510;
	bh=FpV8H7EDCAeKW1oqqfhiTP8CWwW/fh4NwenZ8f/vyUE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RQYJAXF3Btxt96KZCVkd/kI1z3AqN6sz6PxxCeLTADNrEOC79+7JDDNlvbop+SAMB
	 S3PsjAot929mwKIs+jHHgFLAZ1+vHTBIhtBM3HI1+tfK3cTQYFfdW3RYRTL75c8dlX
	 kmrfJJw9BNpX9Gy7beWvkepgGvTua4Is+X/EUWEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBFVLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBFVLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:11:46 -0500
Received: from localhost (unknown [178.226.110.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06591218B0;
        Wed,  6 Feb 2019 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549487505;
        bh=FpV8H7EDCAeKW1oqqfhiTP8CWwW/fh4NwenZ8f/vyUE=;
        h=Date:From:To:Cc:Subject:From;
        b=rJft0xcHgZ/TjX31gwTG9pt7OwSiQ/Q8t3D7Rgw2Q598rzOlWRKdb8yNXKwCapIBa
         N8/f9o92Q7xKXJGtei2o5wY1qtzhWE6ArOFvaRmK5U3bqU5L9GD6i5Q+JthQp/XtBU
         Oq3Ae4UDKtopCLhwU6iSI4+JeG6vs4m42pZMYGus=
Date:   Wed, 6 Feb 2019 22:11:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.98
Message-ID: <20190206211135.GA5174@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.98 kernel.

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
 arch/arm/mach-cns3xxx/pcie.c                      |    2=20
 arch/arm64/kernel/hibernate.c                     |    4 -
 arch/arm64/kernel/hyp-stub.S                      |    2=20
 arch/arm64/kernel/kaslr.c                         |    1=20
 drivers/base/core.c                               |    2=20
 drivers/gpio/gpio-altera-a10sr.c                  |    4 -
 drivers/gpio/gpio-pcf857x.c                       |   26 +++----
 drivers/infiniband/hw/hfi1/file_ops.c             |    2=20
 drivers/iommu/intel-iommu.c                       |    2=20
 drivers/md/raid5-cache.c                          |   33 ++++++---
 drivers/md/raid5.c                                |    8 +-
 drivers/mmc/host/bcm2835.c                        |    2=20
 drivers/mmc/host/sdhci-iproc.c                    |    5 +
 drivers/net/ethernet/freescale/ucc_geth.c         |    2=20
 drivers/net/ethernet/mellanox/mlx4/fw.c           |   75 ++++++++++++-----=
----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   22 ++----
 drivers/net/ipvlan/ipvlan_main.c                  |    6 -
 drivers/net/virtio_net.c                          |   55 ++++++++++-----
 drivers/platform/x86/asus-nb-wmi.c                |    3=20
 fs/cifs/connect.c                                 |   53 ++++++++++++++
 fs/cifs/smb2pdu.c                                 |    4 -
 fs/dcache.c                                       |    6 -
 fs/gfs2/rgrp.c                                    |    2=20
 fs/nfs/write.c                                    |    9 +-
 fs/notify/fsnotify.c                              |    8 +-
 include/linux/kobject.h                           |   17 ++++
 include/linux/netdevice.h                         |    8 ++
 include/linux/sched/coredump.h                    |    1=20
 include/net/l3mdev.h                              |    3=20
 kernel/exit.c                                     |   12 ++-
 mm/memory-failure.c                               |    3=20
 mm/migrate.c                                      |    7 +
 mm/oom_kill.c                                     |   12 ++-
 net/core/dev.c                                    |    3=20
 net/ipv4/ip_fragment.c                            |    2=20
 net/ipv6/af_inet6.c                               |    3=20
 net/ipv6/seg6_iptunnel.c                          |    2=20
 net/l2tp/l2tp_core.c                              |   43 ++++++------
 net/l2tp/l2tp_core.h                              |   31 ++++++++
 net/l2tp/l2tp_ip.c                                |    3=20
 net/l2tp/l2tp_ip6.c                               |    3=20
 net/netrom/nr_timer.c                             |   20 ++---
 net/rose/rose_route.c                             |    5 +
 net/sctp/stream.c                                 |   62 +++++++----------
 sound/pci/hda/patch_realtek.c                     |   78 ++++++++++++-----=
-----
 tools/testing/selftests/seccomp/seccomp_bpf.c     |   72 ++++++++++++++++-=
---
 47 files changed, 493 insertions(+), 237 deletions(-)

Alexei Naberezhnov (1):
      md/raid5: fix 'out of memory' during raid cache recovery

Amir Goldstein (1):
      fanotify: fix handling of events on child sub-directory

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Andrei Vagin (1):
      kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean also when kaslr =
is off

Axel Lin (1):
      gpio: altera-a10sr: Set proper output level for direction_output

Aya Levin (2):
      net/mlx4_core: Add masking for a few queries on HCA caps
      net/mlx5e: Allow MAC invalidation while spoofchk is ON

Benjamin Herrenschmidt (1):
      drivers: core: Remove glue dirs from sysfs earlier

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Bodong Wang (1):
      Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manag=
er"

Cong Wang (1):
      netrom: switch to sock timer API

Daniel Borkmann (1):
      ipvlan, l3mdev: fix broken l3s mode wrt local routes

David Ahern (1):
      ipv6: Consider sk_bound_dev_if when binding a socket to an address

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

Gerald Schaefer (1):
      iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Greg Kroah-Hartman (2):
      Fix "net: ipv4: do not handle duplicate fragments as overlapping"
      Linux 4.14.98

Jacob Wen (2):
      l2tp: copy 4 more bytes to linear part if necessary
      l2tp: fix reading optional fields of L2TPv3

James Morse (2):
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume

Josh Elsasser (1):
      net: set default network namespace in init_dummy_netdev()

Jo=E3o Paulo Rechi Vita (2):
      platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
      platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

Kailang Yang (1):
      ALSA: hda/realtek - Fixed hp_pin no value

Kees Cook (1):
      selftests/seccomp: Enhance per-arch ptrace syscall skip tests

Koen Vandeputte (1):
      ARM: cns3xxx: Fix writing to wrong PCI config registers after alignme=
nt

Lorenzo Bianconi (1):
      l2tp: remove l2specific_len dependency in l2tp_core

Lukas Wunner (1):
      mmc: bcm2835: Fix DMA channel leak on probe error

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Michael J. Ruhl (1):
      IB/hfi1: Remove overly conservative VM_EXEC flag check

Naoya Horiguchi (1):
      mm: hwpoison: use do_send_sig_info() instead of force_sig()

Paulo Alcantara (1):
      cifs: Always resolve hostname before reconnecting

Pavel Shilovsky (1):
      CIFS: Do not count -ENODATA as failure for query directory

Roger Quadros (1):
      gpio: pcf857x: Fix interrupts on multiple instances

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Stefan Wahren (1):
      mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

Tetsuo Handa (1):
      oom, oom_reaper: do not enqueue same task twice

Toshiaki Makita (3):
      virtio_net: Don't enable NAPI when interface is down
      virtio_net: Don't call free_old_xmit_skbs for xdp_frames
      virtio_net: Fix not restoring real_num_rx_queues

Trond Myklebust (1):
      NFS: Fix up return value on fatal errors in nfs_page_async_flush()

Waiman Long (1):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()

Xin Long (2):
      sctp: improve the events for sctp stream adding
      sctp: improve the events for sctp stream reset

Yohei Kanemaru (1):
      ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxbTYcACgkQONu9yGCS
aT5tqBAAkQN5fOK73X58mCUcoE84mmsa9l611VIcK/aHC2CJPANo6E5J91WC/Mos
bhRhT1ibJI4OcjJooLPjUIcd9R2EH8OY5W4PcmE2YExxJCdhbc/fr5oVaRcIuRPA
lP/BlGgNznSxKWMMRyyLYow8+GlVipCNzFF7cLksSZjHKdls43Wn/8ZqcMxuvQha
fBgpoiTYzBKF23pliQbmq0JXrXK6J51wlrtJkw/LmhFytk02E7xDb7IDUIpbJW8i
T+QAyuHV3HN8CjOa9cm31B2IDrhdLbcjNUAGcygZrEpBuiR/t7tkOLho+GXRIHMe
0evNlovfzyUR8lTAcIMpSsGhHaHh09vi5qN4jGFLGhz4nEjxS/ye2Hi9URyO2mYc
MtG2DLHIdj9mLe4jd2dTp4z10/iDajICHg4GYw6yibH3bSZMWdqWBJ7nHYVZs04Z
K7iSrOLoU8r9kwJ8YteB5PwCCZqr7Z35dNIg/G3tSfwSsbXlr6mEI7J/aIAY1Mqx
xjeXHIRppTAN9Yy6QG9iotjRV51p/p46BE5NR5JVYqgjXnBBrVH6baaRoDuA61vk
DF30QvwHHAyLZ+dHLLz/kuiYDUCE4Mn5GkeQfKXW06z1ZpVFq3oKzM7SjJvc0T0L
s5wDRE/vcMM9IrLWwYm1YDcUXn4Vt4sghbYVz0fDVajREwkbGVo=
=G1wz
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
