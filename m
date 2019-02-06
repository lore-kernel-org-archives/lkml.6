Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE923C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F9221900
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549487556;
	bh=k88ut3TrmoO5usNPOFd4d7Tb+poTG/xZR/qi9qqkj9s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EVDUBBD0H4Apkva+n3xcImV4qsjue6XE75qTGjUmjv+fwBRVvWQix0uh+YjNEsGzz
	 PAbbdM9ENlOJBGpqt32tfrfALoZ1MjwCzLyr0MXntTt/FOhFmCx8WLQX43pjw2PCtL
	 3cL55xm7CxEshhBb/+cNCcnEHKdZDqI5hFYO+CFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBFVMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfBFVMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:12:32 -0500
Received: from localhost (unknown [178.226.110.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF85218E0;
        Wed,  6 Feb 2019 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549487550;
        bh=k88ut3TrmoO5usNPOFd4d7Tb+poTG/xZR/qi9qqkj9s=;
        h=Date:From:To:Cc:Subject:From;
        b=qjax8cI/uW79+Yf/imbJ0x9GSwrYZQ7il5x/VvapTSpJcMGZE9y129UZ3HwacPOAu
         NEOwmtPMqVO5cK7JCTCME4FQb6GU1Ufh/NPq1Zz28GCdch8iWuYBSVYW6sSiHoG9Pf
         fhwQrQ6tPyvV1wI/XWQXp4+0gr9YePmcQyzo3/u0=
Date:   Wed, 6 Feb 2019 22:12:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.7
Message-ID: <20190206211220.GA5312@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.7 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/arm/mach-cns3xxx/pcie.c                      |    2=20
 arch/arm64/kernel/hibernate.c                     |    4=20
 arch/arm64/kernel/hyp-stub.S                      |    2=20
 arch/arm64/kernel/kaslr.c                         |    1=20
 arch/arm64/mm/flush.c                             |    6=20
 drivers/gpio/gpio-altera-a10sr.c                  |    4=20
 drivers/gpio/gpio-eic-sprd.c                      |   14 +
 drivers/gpio/gpio-pcf857x.c                       |   26 +--
 drivers/gpio/gpiolib.c                            |    9 +
 drivers/gpu/drm/msm/msm_gpu.h                     |    2=20
 drivers/infiniband/core/uverbs_main.c             |   25 ++-
 drivers/infiniband/hw/hfi1/file_ops.c             |    2=20
 drivers/infiniband/sw/rdmavt/qp.c                 |    7=20
 drivers/iommu/intel-iommu.c                       |    2=20
 drivers/md/raid5-cache.c                          |   33 ++--
 drivers/md/raid5.c                                |    8 -
 drivers/mmc/host/bcm2835.c                        |    2=20
 drivers/mmc/host/mtk-sd.c                         |    2=20
 drivers/net/ethernet/freescale/ucc_geth.c         |    2=20
 drivers/net/ethernet/mellanox/mlx4/fw.c           |   75 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   22 +-
 drivers/net/ethernet/renesas/ravb_main.c          |   12 -
 drivers/net/ipvlan/ipvlan_main.c                  |    6=20
 drivers/net/tun.c                                 |    3=20
 drivers/net/virtio_net.c                          |  169 +++++++++++++++--=
-----
 drivers/of/dynamic.c                              |   32 +++-
 drivers/of/kobj.c                                 |    4=20
 drivers/of/overlay.c                              |  115 +++++++++-----
 drivers/platform/x86/asus-nb-wmi.c                |    3=20
 drivers/vhost/net.c                               |    3=20
 drivers/vhost/scsi.c                              |    2=20
 drivers/vhost/vhost.c                             |    7=20
 drivers/vhost/vhost.h                             |    4=20
 drivers/vhost/vsock.c                             |    2=20
 fs/btrfs/ctree.c                                  |   78 ++++++----
 fs/btrfs/super.c                                  |    3=20
 fs/cifs/connect.c                                 |   53 ++++++
 fs/cifs/file.c                                    |   11 +
 fs/cifs/smb2pdu.c                                 |   54 ++++---
 fs/dcache.c                                       |    6=20
 fs/gfs2/rgrp.c                                    |    2=20
 fs/nfs/write.c                                    |    9 -
 include/linux/netdevice.h                         |    8 +
 include/linux/of.h                                |   15 +
 include/linux/sched/coredump.h                    |    1=20
 include/net/l3mdev.h                              |    3=20
 include/net/tls.h                                 |    2=20
 kernel/exit.c                                     |   12 +
 mm/hugetlb.c                                      |    3=20
 mm/memory-failure.c                               |    3=20
 mm/memory_hotplug.c                               |   36 ++--
 mm/migrate.c                                      |    7=20
 mm/oom_kill.c                                     |   12 +
 net/core/dev.c                                    |    3=20
 net/ipv4/gre_demux.c                              |   17 ++
 net/ipv4/ip_gre.c                                 |   16 --
 net/ipv6/addrconf.c                               |    2=20
 net/ipv6/af_inet6.c                               |    3=20
 net/ipv6/ip6_gre.c                                |   11 -
 net/ipv6/ip6mr.c                                  |    7=20
 net/ipv6/seg6_iptunnel.c                          |    2=20
 net/l2tp/l2tp_core.c                              |    9 -
 net/l2tp/l2tp_core.h                              |   20 ++
 net/l2tp/l2tp_ip.c                                |    3=20
 net/l2tp/l2tp_ip6.c                               |    3=20
 net/netrom/nr_timer.c                             |   20 +-
 net/rose/rose_route.c                             |    5=20
 net/sctp/ipv6.c                                   |    3=20
 net/sctp/protocol.c                               |    3=20
 net/sctp/sm_make_chunk.c                          |   11 +
 net/sctp/stream.c                                 |   58 +++----
 net/tls/tls_sw.c                                  |    6=20
 sound/core/pcm_lib.c                              |    9 +
 sound/pci/hda/patch_realtek.c                     |   78 +++++-----
 sound/usb/quirks.c                                |    1=20
 tools/testing/selftests/seccomp/seccomp_bpf.c     |   72 +++++++--
 77 files changed, 878 insertions(+), 416 deletions(-)

Alexei Naberezhnov (1):
      md/raid5: fix 'out of memory' during raid cache recovery

Andrea Arcangeli (1):
      mm/hugetlb.c: teach follow_hugetlb_page() to handle FOLL_NOWAIT

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Andrei Vagin (1):
      kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean also when kaslr =
is off

Arnd Bergmann (1):
      drm/msm/gpu: fix building without debugfs

Aurelien Aptel (1):
      CIFS: fix use-after-free of the lease keys

Axel Lin (1):
      gpio: altera-a10sr: Set proper output level for direction_output

Aya Levin (2):
      net/mlx4_core: Add masking for a few queries on HCA caps
      net/mlx5e: Allow MAC invalidation while spoofchk is ON

Bartosz Golaszewski (1):
      gpiolib: fix line event timestamps for nested irqs

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Bodong Wang (1):
      Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manag=
er"

Catalin Marinas (1):
      arm64: Do not issue IPIs for user executable ptes

Chaotian Jing (1):
      mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay

Cong Wang (1):
      netrom: switch to sock timer API

Daniel Borkmann (1):
      ipvlan, l3mdev: fix broken l3s mode wrt local routes

Dave Watson (2):
      net: tls: Fix deadlock in free_resources tx
      net: tls: Save iv in tls_rec for async crypto requests

David Ahern (1):
      ipv6: Consider sk_bound_dev_if when binding a socket to an address

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

Eric W. Biederman (1):
      btrfs: On error always free subvol_name in btrfs_mount

Filipe Manana (1):
      Btrfs: fix deadlock when allocating tree block during leaf/node split

Frank Rowand (4):
      of: overlay: add tests to validate kfrees from overlay removal
      of: overlay: add missing of_node_get() in __of_attach_node_sysfs
      of: overlay: use prop add changeset entry for property in new nodes
      of: overlay: do not duplicate properties from overlay for new nodes

George Amanakis (1):
      tun: move the call to tun_set_real_num_queues

Gerald Schaefer (1):
      iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Greg Kroah-Hartman (1):
      Linux 4.20.7

Jacob Wen (2):
      l2tp: copy 4 more bytes to linear part if necessary
      l2tp: fix reading optional fields of L2TPv3

Jakub Kicinski (1):
      net/ipv6: don't return positive numbers when nothing was dumped

James Morse (2):
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume

Jason Wang (1):
      vhost: fix OOB in get_rx_bufs()

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

Lorenzo Bianconi (3):
      net: ip_gre: always reports o_key to userspace
      net: ip_gre: use erspan key field for tunnel lookup
      net: ip6_gre: always reports o_key to userspace

Lukas Wunner (1):
      mmc: bcm2835: Fix DMA channel leak on probe error

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Michael J. Ruhl (1):
      IB/hfi1: Remove overly conservative VM_EXEC flag check

Mike Marciniszyn (1):
      IB/hfi1: Add limit test for RC/UC send via loopback

Naoya Horiguchi (1):
      mm: hwpoison: use do_send_sig_info() instead of force_sig()

Neo Hou (2):
      gpio: sprd: Fix the incorrect data register
      gpio: sprd: Fix incorrect irq type setting for the async EIC

Nir Dotan (1):
      ip6mr: Fix notifiers call on mroute_clean_tables()

Olek Poplavsky (1):
      ALSA: usb-audio: Add Opus #3 to quirks for native DSD support

Oscar Salvador (1):
      mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages

Paulo Alcantara (1):
      cifs: Always resolve hostname before reconnecting

Pavel Shilovsky (4):
      CIFS: Do not count -ENODATA as failure for query directory
      CIFS: Fix possible oops and memory leaks in async IO
      CIFS: Fix trace command logging for SMB2 reads and writes
      CIFS: Do not consider -ENODATA as stat failure for reads

Roger Quadros (1):
      gpio: pcf857x: Fix interrupts on multiple instances

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Simon Horman (1):
      ravb: expand rx descriptor data to accommodate hw checksum

Takashi Iwai (1):
      ALSA: pcm: Fix tight loop of OSS capture stream

Tetsuo Handa (1):
      oom, oom_reaper: do not enqueue same task twice

Toshiaki Makita (7):
      virtio_net: Don't enable NAPI when interface is down
      virtio_net: Don't call free_old_xmit_skbs for xdp_frames
      virtio_net: Fix not restoring real_num_rx_queues
      virtio_net: Fix out of bounds access of sq
      virtio_net: Don't process redirected XDP frames when XDP is disabled
      virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs
      virtio_net: Differentiate sk_buff and xdp_frame on freeing

Trond Myklebust (1):
      NFS: Fix up return value on fatal errors in nfs_page_async_flush()

Waiman Long (1):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()

Xin Long (4):
      sctp: improve the events for sctp stream reset
      sctp: improve the events for sctp stream adding
      sctp: set chunk transport correctly when it's a new asoc
      sctp: set flow sport from saddr only when it's 0

Yishai Hadas (2):
      IB/uverbs: Fix OOPs upon device disassociation
      IB/uverbs: Fix OOPs in uverbs_user_mmap_disassociate

Yohei Kanemaru (1):
      ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxbTbQACgkQONu9yGCS
aT5cgw//eOCwQDfVxAflexMJmd0yotw9u8XaSEEQ0LmDTbF9fmwR3ghjd+OBOXDM
hGg6ztVcIAAUsk3vN8ujATTGLTCt1FbDOt0qtR4e6FZexHtDoYzxkxhdjFrbe8BV
IdDtGRSAE9RhyY4vQrogz57BuDEhA8QOm19dvp0ZcmF6W2vvZeP8q87eixRlnlKB
imqKPwd/gCKKHTnObb02qDL9nnn5hmaXjLS4P5m89yc+OPgOrEdfURMLTrC0IZhk
Dm/35vPZBHxGlso7zm4k/F2/WkyPmnwQlOfpgr0crbiOxSH56weUNa60ZjsQ5Nyt
pcvLa1pjtQaSBTJ7D3pgN1JsnmkIFr8xkt/i6GM+Qa0gd5KVNCFzLHa2yoiD0P/t
CtXjHqJKuHYNOEJddyR7qlMB9Uf1JTM/w//DASQbgNnjrScuTKUu+Ck6gXfv8yi0
HbS9PWTsB3nNvXj0uDCLs3+dMo2mfwx+qYvy5nbckSRhSVf+lWWWjZXrtOT2nZY0
xjALJGWCe2nRaxyEDjwjGKQmAXU4eHRDTfoEinj6lhaOxiHSymRlWFrqRwvOmStu
5vpp4TfbymbsD57zl91OD+Z0J8f5Nc/9mwX0u8ql3mP1wJ6qnpK06B64Skxk4BGM
1KUdpsWbBXPq2ce6SUWpH25BhDHwBGtiknn3rOX6a5jPX12+Bxs=
=zwa2
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
