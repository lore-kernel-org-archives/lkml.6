Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7202F2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548252581;
	bh=RJefRAKPCRLraI/C1QWDyfdbM8cLkt9QW0IvJz+OysI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=F0lCUUKqcpBR6eQtS6OfYDxKo/uuwyvyPLv9AXzrL+024T54yw1PVI//Cs1NixlJf
	 5w/7FqY48gzezsbD5YexjwDe5xy3bziBrm56ORKJl9DZgy0id9CSXe5iO5EJ04JBp7
	 RbmCiSZkC5aBsVqf8BLEE5MW8FwoYQb5C56+hmgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfAWOJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfAWOJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:09:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2D62133D;
        Wed, 23 Jan 2019 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548252577;
        bh=RJefRAKPCRLraI/C1QWDyfdbM8cLkt9QW0IvJz+OysI=;
        h=Date:From:To:Cc:Subject:From;
        b=XJKsacA2OqIcftBW0bhc/LUsXwPog4AQjauQoMbBWPEx/jAXIfVvV3J5bA1hy41JH
         d8fGcpcxF09ZBkYuvMREpGJ+Twy5AppSQjZ8t2iNDdps1XMDuS8+MSqhSKnutyt7tY
         TcDjy0v01juM3n6Jz0y9rlN4rUaM5S2MbgFSgLeo=
Date:   Wed, 23 Jan 2019 15:09:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.17
Message-ID: <20190123140935.GA27716@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.17 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                 |    2=20
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi            |   17=20
 arch/arm64/include/asm/kvm_arm.h                         |    3=20
 arch/arm64/kernel/head.S                                 |    5=20
 arch/arm64/kernel/kaslr.c                                |    8=20
 arch/arm64/kvm/hyp/switch.c                              |    2=20
 arch/mips/Kconfig                                        |    1=20
 arch/mips/bcm47xx/setup.c                                |   31 +
 arch/mips/lantiq/irq.c                                   |   68 --
 arch/mips/pci/msi-octeon.c                               |    4=20
 arch/x86/xen/time.c                                      |   12=20
 block/partition-generic.c                                |    8=20
 crypto/authenc.c                                         |   14=20
 crypto/authencesn.c                                      |    2=20
 crypto/sm3_generic.c                                     |    2=20
 drivers/block/loop.c                                     |  443 +++++++++-=
-----
 drivers/block/loop.h                                     |    1=20
 drivers/block/nbd.c                                      |    5=20
 drivers/crypto/Kconfig                                   |    1=20
 drivers/crypto/bcm/cipher.c                              |   44 -
 drivers/crypto/caam/caamhash.c                           |   15=20
 drivers/crypto/ccree/cc_aead.c                           |   40 -
 drivers/crypto/talitos.c                                 |   26=20
 drivers/gpu/drm/drm_fb_helper.c                          |    7=20
 drivers/gpu/drm/i915/gvt/kvmgt.c                         |   14=20
 drivers/infiniband/core/nldev.c                          |    4=20
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h                |   35 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c             |    6=20
 drivers/media/common/videobuf2/videobuf2-core.c          |   14=20
 drivers/media/platform/vivid/vivid-kthread-cap.c         |    5=20
 drivers/media/platform/vivid/vivid-kthread-out.c         |    5=20
 drivers/media/platform/vivid/vivid-vid-common.c          |    2=20
 drivers/media/v4l2-core/v4l2-ioctl.c                     |    4=20
 drivers/mfd/tps6586x.c                                   |   24=20
 drivers/mmc/host/sdhci-msm.c                             |   43 +
 drivers/net/bonding/bond_main.c                          |    3=20
 drivers/net/dsa/realtek-smi.c                            |   18=20
 drivers/net/ethernet/microchip/lan743x_main.c            |   11=20
 drivers/net/ethernet/realtek/r8169.c                     |    7=20
 drivers/net/tun.c                                        |   11=20
 drivers/of/property.c                                    |    1=20
 drivers/scsi/scsi_pm.c                                   |   26=20
 drivers/scsi/sd.c                                        |    6=20
 drivers/target/iscsi/cxgbit/cxgbit_cm.c                  |   23=20
 drivers/tty/tty_io.c                                     |   22=20
 drivers/tty/tty_ldsem.c                                  |   10=20
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c          |    2=20
 drivers/xen/events/events_base.c                         |    2=20
 fs/block_dev.c                                           |   28=20
 fs/btrfs/disk-io.c                                       |    8=20
 fs/btrfs/inode.c                                         |    3=20
 fs/pstore/ram.c                                          |    9=20
 include/linux/bcma/bcma_soc.h                            |    1=20
 include/linux/genhd.h                                    |    2=20
 include/net/netfilter/nf_conntrack_count.h               |   19=20
 include/uapi/rdma/vmw_pvrdma-abi.h                       |    1=20
 init/Kconfig                                             |    1=20
 lib/int_sqrt.c                                           |    2=20
 net/bridge/br_netfilter_hooks.c                          |    2=20
 net/bridge/netfilter/ebtables.c                          |    6=20
 net/can/gw.c                                             |   30 -
 net/core/filter.c                                        |   21=20
 net/core/lwt_bpf.c                                       |    1=20
 net/ipv4/ip_sockglue.c                                   |   12=20
 net/ipv4/tcp_timer.c                                     |    2=20
 net/ipv6/datagram.c                                      |   11=20
 net/ipv6/icmp.c                                          |    8=20
 net/netfilter/nf_conncount.c                             |  290 ++++-----
 net/netfilter/nft_connlimit.c                            |   14=20
 net/packet/af_packet.c                                   |    4=20
 net/sctp/ipv6.c                                          |    5=20
 net/sctp/protocol.c                                      |    4=20
 net/smc/af_smc.c                                         |    4=20
 net/sunrpc/rpcb_clnt.c                                   |    8=20
 net/tipc/netlink_compat.c                                |   50 +
 net/tipc/topsrv.c                                        |    2=20
 security/security.c                                      |    7=20
 security/selinux/ss/policydb.c                           |    3=20
 security/yama/yama_lsm.c                                 |    4=20
 tools/testing/selftests/android/Makefile                 |    2=20
 tools/testing/selftests/futex/functional/Makefile        |    1=20
 tools/testing/selftests/gpio/Makefile                    |    1=20
 tools/testing/selftests/kvm/Makefile                     |    2=20
 tools/testing/selftests/lib.mk                           |    8=20
 tools/testing/selftests/networking/timestamping/Makefile |    1=20
 tools/testing/selftests/vm/Makefile                      |    1=20
 86 files changed, 981 insertions(+), 656 deletions(-)

Adit Ranadive (1):
      RDMA/vmw_pvrdma: Return the correct opcode when creating WR

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean to the PoC

Arnd Bergmann (1):
      mips: fix n32 compat_ipc_parse_version

Aymen Sghaier (1):
      crypto: caam - fix zero-length buffer DMA mapping

Bryan Whitehead (1):
      lan743x: Remove phy_read from link status change function

Christophe Leroy (2):
      crypto: talitos - reorder code in talitos_edesc_alloc()
      crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK

Cong Wang (1):
      smc: move unhash as early as possible in smc_release()

David Sterba (1):
      Revert "btrfs: balance dirty metadata pages in btrfs_finish_ordered_i=
o"

Dmitry Safonov (4):
      tty/ldsem: Wake up readers after timed out down_write()
      tty: Hold tty_ldisc_lock() during tty_reopen()
      tty: Simplify tty->count math in tty_reopen()
      tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Eric Biggers (4):
      crypto: sm3 - fix undefined shift by >=3D width of value
      crypto: ccree - convert to use crypto_authenc_extractkeys()
      crypto: bcm - convert to use crypto_authenc_extractkeys()
      crypto: authenc - fix parsing key with misaligned rta_len

Eric Dumazet (2):
      ipv6: fix kernel-infoleak in ipv6_local_error()
      ipv6: make icmp6_send() robust against null skb->dev

Florian La Roche (1):
      fix int_sqrt64() for very large numbers

Florian Westphal (5):
      netfilter: nf_conncount: don't skip eviction when age is negative
      netfilter: nf_conncount: split gc in two phases
      netfilter: nf_conncount: restart search when nodes have been erased
      netfilter: nf_conncount: merge lookup and add functions
      netfilter: nf_conncount: fix argument order to find_next_bit

Greg Kroah-Hartman (1):
      Linux 4.19.17

Hans Verkuil (3):
      media: vivid: fix error handling of kthread_run
      media: vivid: set min width/height to a value > 0
      media: vb2: vb2_mmap: move lock up

Harsh Jain (1):
      crypto: authencesn - Avoid twice completion call in decrypt path

Hauke Mehrtens (1):
      MIPS: lantiq: Fix IPI interrupt handling

Heiner Kallweit (2):
      r8169: don't try to read counters if chip is in a PCI power-save state
      r8169: load Realtek PHY driver module before r8169

Heinrich Schuchardt (1):
      arm64: dts: marvell: armada-ap806: reserve PSCI area

Ivan Mironov (2):
      scsi: sd: Fix cache_type_store()
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

J. Bruce Fields (1):
      sunrpc: handle ENOMEM in rpcb_getport_async

Jaegeuk Kim (1):
      loop: drop caches if offset or block_size are changed

James Morris (1):
      LSM: Check for NULL cred-security on free

Jan Kara (16):
      blockdev: Fix livelocks on loop device
      loop: Fold __loop_release into loop_release
      loop: Get rid of loop_index_mutex
      loop: Push lo_ctl_mutex down into individual ioctls
      loop: Split setting of lo_state from loop_clr_fd
      loop: Push loop_ctl_mutex down into loop_clr_fd()
      loop: Push loop_ctl_mutex down to loop_get_status()
      loop: Push loop_ctl_mutex down to loop_set_status()
      loop: Push loop_ctl_mutex down to loop_set_fd()
      loop: Push loop_ctl_mutex down to loop_change_fd()
      loop: Move special partition reread handling in loop_clr_fd()
      loop: Move loop_reread_partitions() out of loop_ctl_mutex
      loop: Fix deadlock when calling blkdev_reread_part()
      loop: Avoid circular locking dependency between loop_ctl_mutex and bd=
_mutex
      loop: Get rid of 'nested' acquisition of loop_ctl_mutex
      nbd: Use set_blocksize() to set device blocksize

Jason Gunthorpe (1):
      packet: Do not leak dev refcounts on error exit

JianJhen Chen (1):
      net: bridge: fix a bug on using a neighbour cache entry without check=
ing its state

Johan Hovold (1):
      net: dsa: realtek-smi: fix OF child-node lookup

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend

Josef Bacik (1):
      btrfs: wait on ordered extents on abort cleanup

Juergen Gross (1):
      xen: Fix x86 sched_clock() interface for xen

Julia Lawall (1):
      OF: properties: add missing of_node_put

Kees Cook (2):
      Yama: Check for pid death before checking ancestry
      pstore/ram: Avoid allocation and leak of platform data

Leon Romanovsky (1):
      RDMA/nldev: Don't expose unsafe global rkey to regular user

Loic Poulain (1):
      mmc: sdhci-msm: Disable CDR function on TX

Mark Rutland (2):
      arm64/kvm: consistently handle host HCR_EL2 flags
      arm64: Don't trap host pointer auth use to EL2

Mauro Carvalho Chehab (1):
      media: vb2: be sure to unlock mutex on errors

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Pablo Neira Ayuso (2):
      netfilter: nf_conncount: move all list iterations under spinlock
      netfilter: nf_conncount: speculative garbage collection on empty lists

Paul Burton (1):
      kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace & GCC <=3D =
4.7

Rafa=C5=82 Mi=C5=82ecki (1):
      MIPS: BCM47XX: Setup struct device for the SoC

Sakari Ailus (1):
      media: v4l: ioctl: Validate num_planes for debug messages

Sasha Levin (1):
      Revert "scsi: target: iscsi: cxgbit: fix csk leak"

Shakeel Butt (1):
      netfilter: ebtables: account ebt_table_info to kmemcg

Shawn Bohrer (1):
      netfilter: nf_conncount: replace CONNCOUNT_LOCK_SLOTS with CONNCOUNT_=
SLOTS

Shuah Khan (1):
      selftests: Fix test errors related to lib.mk khdr target

Stanislav Fomichev (1):
      tun: publish tfile after it's fully initialized

Stanley Chu (1):
      scsi: core: Synchronize request queue PM status only on successful re=
sume

Stephen Smalley (1):
      selinux: fix GPF on invalid policy

Tetsuo Handa (3):
      block/loop: Don't grab "struct file" for vfs_getattr() operation.
      block/loop: Use global lock for ioctl() operation.
      loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix csk leak
      scsi: target: iscsi: cxgbit: fix csk leak

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

Willem de Bruijn (3):
      bonding: update nest level on unlink
      ip: on queued skb use skb_header_pointer instead of pskb_may_pull
      bpf: in __bpf_redirect_no_mac pull mac only if present

Xin Long (1):
      sctp: allocate sctp_sockaddr_entry with kzalloc

Ying Xue (6):
      tipc: fix uninit-value in in tipc_conn_rcv_sub
      tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
      tipc: fix uninit-value in tipc_nl_compat_bearer_enable
      tipc: fix uninit-value in tipc_nl_compat_link_set
      tipc: fix uninit-value in tipc_nl_compat_name_table_dump
      tipc: fix uninit-value in tipc_nl_compat_doit

Yuchung Cheng (1):
      tcp: change txhash on SYN-data timeout

Yufen Yu (1):
      block: use rcu_work instead of call_rcu to avoid sleep in softirq

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on

Zhenyu Wang (1):
      drm/i915/gvt: Fix mmap range check


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxIdZ4ACgkQONu9yGCS
aT54EQ//SwB1fE3eFB/ZooCU320Rvd740va2aAXto/i1ut6fnENXVCuEoqAUdezb
rwxrdK1RTQ3B8sitp0pQ44bZ9SRS72C51WCpzTD63+JAAaEbGeOkefRQwXZyqDlX
kyUvOS2al1+Bwh4t5W6fgXj1idVwz6ZQ3mKjoQ1YNlm6teG7jGUHo5JhGPcz0xfa
rGvngNTWg61KYRCGYpoeREEht/QALbsigk36ykCf6cEktBq70XyEjhY3rCWYr4X6
DDqyQgzHD2wrBXO603N6rRP85OjRWZ6QHO97qMV1C8MA5ZFI9PZtRDLllJdjICUO
SDG+66eSLeWBpCtvv2oNP/be+QOZN8fOMB/UYM0Cu6tZspvMh7YapYSU1Nwgru6f
98Kiost9STzIgxqNXr+Kzoc+qh7ywaw6MMaS/Ut3hlexev9xtd0/kz9KnulQcA+1
6Jh1b+X0SwZwVAelft5UOpn62PyPkje+r7PulmdGWnScF/tIDikxal1BH1CNkHj+
EGae9IzUIY+XGqdKNwvMGMGN6iFeWjwAXJe+tPRrmDW6NluY9dZ1t9SDwap46wrI
+v6NuaR/5hMrroZmol8J+Y4krRvxMCKZFArPvCKPZS01nUQarDLR7BeemHmzC00i
JDBiv4MPdKOMZOnT3Y7f0gsb4qAhagxj/KRlOlaVxfMK2U4bl+w=
=WoTc
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
