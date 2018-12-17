Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C0C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961D3217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545036983;
	bh=1QzFdT8rSINfpMF8rCPzzR5gqc13x+5QQ+rtOG364SU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fhJVX+4Ge3Gj3ZNCF+FINs3xvhs6wpAtN3ONgrg/OcYcLVFUU9c83KmzxQPBUTDb2
	 mkI0NFCSK27cd/gDnEqCHZkEn3df9Bg5rudYwZqEm8aAZ/xNJJudzJYijtY10DCLIq
	 kt5Zg5KaDVcZqI7wi2x5n4XFRzcC1latdHlBKGDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbeLQI4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731883AbeLQI4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:56:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28D52084D;
        Mon, 17 Dec 2018 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545036980;
        bh=1QzFdT8rSINfpMF8rCPzzR5gqc13x+5QQ+rtOG364SU=;
        h=Date:From:To:Cc:Subject:From;
        b=ou+wD5cYOKT358mnG/REpeU9WqWkMlYVQiXgBAY88zhfeRl7PdDLuRo5DRUCzINMJ
         14yrN4TlC+qQ4JMCTrc2l30qE4VYE+Eh+5h3eaBWb5oiaFlYw+e+JOvbDRlEDewm7Z
         BI2/0NOXfOTQflrmpQyIPvYIHDOabSzlO0e2WymQ=
Date:   Mon, 17 Dec 2018 09:56:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.89
Message-ID: <20181217085618.GA1159@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.89 kernel.

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

 Makefile                                              |    2=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                 |    2=20
 arch/arm/boot/dts/sama5d2.dtsi                        |    2=20
 arch/arm/mach-omap1/board-ams-delta.c                 |    3=20
 arch/arm/mach-omap2/prm44xx.c                         |    2=20
 arch/s390/kernel/perf_cpum_cf.c                       |    2=20
 arch/x86/kvm/lapic.c                                  |    2=20
 arch/x86/kvm/vmx.c                                    |    8=20
 arch/x86/xen/enlighten.c                              |   78 --------
 arch/x86/xen/setup.c                                  |    6=20
 drivers/acpi/arm64/iort.c                             |    2=20
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                 |    7=20
 drivers/gpu/drm/ast/ast_mode.c                        |   36 +++-
 drivers/gpu/drm/meson/meson_venc.c                    |    1=20
 drivers/hid/hid-sensor-custom.c                       |    2=20
 drivers/hid/hid-sensor-hub.c                          |   13 +
 drivers/hwmon/ina2xx.c                                |    6=20
 drivers/hwmon/w83795.c                                |    2=20
 drivers/iio/accel/hid-sensor-accel-3d.c               |    5=20
 drivers/iio/gyro/hid-sensor-gyro-3d.c                 |    5=20
 drivers/iio/humidity/hid-sensor-humidity.c            |    3=20
 drivers/iio/light/hid-sensor-als.c                    |    8=20
 drivers/iio/light/hid-sensor-prox.c                   |    8=20
 drivers/iio/magnetometer/hid-sensor-magn-3d.c         |    8=20
 drivers/iio/orientation/hid-sensor-incl-3d.c          |    8=20
 drivers/iio/pressure/hid-sensor-press.c               |    8=20
 drivers/iio/temperature/hid-sensor-temperature.c      |    3=20
 drivers/infiniband/hw/hfi1/chip.c                     |    3=20
 drivers/infiniband/hw/hfi1/hfi.h                      |    2=20
 drivers/infiniband/hw/hfi1/verbs.c                    |    2=20
 drivers/infiniband/hw/mlx5/odp.c                      |    1=20
 drivers/infiniband/hw/mlx5/qp.c                       |   19 +-
 drivers/infiniband/sw/rdmavt/ah.c                     |    4=20
 drivers/infiniband/sw/rdmavt/ah.h                     |    3=20
 drivers/net/ethernet/cavium/thunder/nic_main.c        |    3=20
 drivers/net/ethernet/hisilicon/hip04_eth.c            |    4=20
 drivers/net/ethernet/intel/igb/e1000_i210.c           |    1=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c         |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c       |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c        |    4=20
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h          |    1=20
 drivers/net/ethernet/realtek/8139cp.c                 |    5=20
 drivers/net/phy/phy_device.c                          |   19 --
 drivers/net/tun.c                                     |    6=20
 drivers/net/virtio_net.c                              |   14 +
 drivers/nvme/host/core.c                              |    4=20
 drivers/pci/dwc/pci-imx6.c                            |   10 -
 drivers/rtc/rtc-hid-sensor-time.c                     |    2=20
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c        |    2=20
 drivers/staging/speakup/kobjects.c                    |    4=20
 drivers/usb/gadget/function/u_ether.c                 |   11 -
 drivers/usb/gadget/udc/omap_udc.c                     |   88 +++------
 drivers/xen/balloon.c                                 |   65 +------
 drivers/xen/xlate_mmu.c                               |    1=20
 fs/btrfs/send.c                                       |   11 -
 fs/cachefiles/rdwr.c                                  |    9 -
 fs/exportfs/expfs.c                                   |    2=20
 fs/fscache/object.c                                   |    3=20
 fs/hfs/btree.c                                        |    3=20
 fs/hfsplus/btree.c                                    |    3=20
 fs/nfs/flexfilelayout/flexfilelayout.c                |    6=20
 fs/ocfs2/export.c                                     |    2=20
 fs/ocfs2/move_extents.c                               |   47 ++---
 fs/pstore/ram.c                                       |   15 -
 fs/sysv/inode.c                                       |    2=20
 include/linux/hid-sensor-hub.h                        |    4=20
 include/linux/pstore.h                                |    5=20
 include/net/neighbour.h                               |   28 ++-
 include/net/sctp/structs.h                            |    2=20
 include/xen/balloon.h                                 |    5=20
 kernel/printk/printk.c                                |  160 +++++++++++++=
++++-
 kernel/trace/bpf_trace.c                              |    8=20
 lib/debugobjects.c                                    |    5=20
 lib/interval_tree_test.c                              |    4=20
 lib/rbtree_test.c                                     |    2=20
 mm/page_alloc.c                                       |    4=20
 net/core/rtnetlink.c                                  |    3=20
 net/ipv4/ip_fragment.c                                |    7=20
 net/ipv4/tcp_output.c                                 |   44 +++-
 net/ipv6/ip6_output.c                                 |   42 ++--
 net/ipv6/netfilter.c                                  |    3=20
 net/ipv6/netfilter/nf_conntrack_reasm.c               |    8=20
 net/ipv6/reassembly.c                                 |    8=20
 net/ipv6/seg6_iptunnel.c                              |    1=20
 net/netfilter/ipvs/ip_vs_ctl.c                        |    3=20
 net/netfilter/nf_tables_api.c                         |   20 --
 net/netfilter/nft_compat.c                            |    3=20
 net/netfilter/xt_hashlimit.c                          |    9 -
 net/sched/sch_netem.c                                 |    3=20
 net/sctp/associola.c                                  |    2=20
 sound/firewire/fireface/ff-protocol-ff400.c           |    2=20
 sound/pci/hda/patch_realtek.c                         |   33 +++
 sound/soc/codecs/wm_adsp.c                            |   37 ++--
 sound/soc/omap/omap-abe-twl6040.c                     |   67 +++----
 sound/soc/omap/omap-dmic.c                            |    9 +
 sound/soc/omap/omap-mcbsp.c                           |    6=20
 sound/soc/omap/omap-mcpdm.c                           |   43 ++++
 sound/soc/sh/rcar/ssi.c                               |    2=20
 sound/soc/soc-core.c                                  |    1=20
 tools/objtool/elf.c                                   |   19 +-
 tools/perf/util/namespaces.c                          |   17 +
 tools/perf/util/namespaces.h                          |    1=20
 tools/testing/selftests/Makefile                      |    1=20
 tools/testing/selftests/netfilter/Makefile            |    6=20
 tools/testing/selftests/netfilter/config              |    2=20
 tools/testing/selftests/netfilter/nft_trans_stress.sh |   78 ++++++++
 106 files changed, 839 insertions(+), 489 deletions(-)

Aaro Koskinen (5):
      USB: omap_udc: use devm_request_irq()
      USB: omap_udc: fix crashes on probe error and module removal
      USB: omap_udc: fix omap_udc_start() on 15xx machines
      USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
      USB: omap_udc: fix rejection of out transfers when DMA is used

Adam Ford (1):
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1

Alin Nastac (1):
      netfilter: ipv6: Preserve link scope traffic original oif

Artem Savkov (2):
      objtool: Fix double-free in .cold detection error path
      objtool: Fix segfault in .cold detection with -ffunction-sections

Artemy Kovalyov (1):
      IB/mlx5: Fix page fault handling for MW

Christian Hewitt (1):
      drm/meson: add support for 1080p25 mode

Christoph Paasch (1):
      net: Prevent invalid access to skb->prev in __qdisc_drop_all

Christophe JAILLET (1):
      staging: rtl8723bs: Fix the return value in case of error in 'rtw_wx_=
read32()'

Colin Ian King (1):
      fscache, cachefiles: remove redundant variable 'cache'

Davidlohr Bueso (1):
      lib/rbtree-test: lower default params

Eran Ben Elisha (1):
      net/mlx4_en: Change min MTU size to ETH_MIN_MTU

Eric Dumazet (3):
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices
      tcp: Do not underestimate rwnd_limited
      tcp: lack of available data can also cause TSO defer

Florian Westphal (2):
      selftests: add script to stress-test nft packet path vs. control plane
      netfilter: nf_tables: fix use-after-free when deleting compat express=
ions

Greg Kroah-Hartman (1):
      Linux 4.14.89

Guenter Roeck (1):
      staging: speakup: Replace strncpy with memcpy

Hans de Goede (1):
      iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for sig=
ned numbers

Heiner Kallweit (1):
      net: phy: don't allow __set_phy_supported to add unsupported modes

Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission

Igor Druzhinin (1):
      Revert "xen/balloon: Mark unallocated host memory as UNUSABLE"

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Jason Wang (1):
      virtio-net: keep vnet header zeroed after processing XDP

Jiri Olsa (1):
      perf tools: Restore proper cwd on return from mnt namespace

Jiri Wiesner (1):
      ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize changes

Josh Elsasser (1):
      ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Kailang Yang (1):
      ALSA: hda/realtek - Fixed headphone issue for ALC700

Kamal Heib (1):
      RDMA/rdmavt: Fix rvt_create_ah function signature

Kees Cook (1):
      pstore/ram: Correctly calculate usable PRZ bytes

Kiran Kumar Modukuri (1):
      cachefiles: Fix page leak in cachefiles_read_backing_file while vmsca=
n is active

Kuninori Morimoto (1):
      ASoC: rsnd: fixup clock start checker

Larry Chen (1):
      ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Lorenzo Bianconi (1):
      net: thunderx: fix NULL pointer dereference in nic_remove

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointe=
r value

Majd Dibbiny (1):
      RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR

Marek Szyprowski (1):
      usb: gadget: u_ether: fix unsafe list iteration

Martynas Pumputis (1):
      bpf: fix check of allowed specifiers in bpf_trace_printk

Nathan Chancellor (1):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_i=
o_wakeup

NeilBrown (1):
      fscache: fix race between enablement and dropping of object

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops

Nicolin Chen (2):
      hwmon (ina2xx) Fix NULL id pointer in probe()
      hwmon: (ina2xx) Fix current value calculation

Pan Bian (5):
      exportfs: do not read dentry after free
      net: hisilicon: remove unexpected free_netdev
      hfs: do not free node before using
      hfsplus: do not free node before using
      ocfs2: fix potential use after free

Peter Ujfalusi (4):
      ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred pro=
bing
      ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
      ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CP=
U_IDLE
      ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Petr Mladek (2):
      printk: Hide console waiter logic into helpers
      printk: Wake klogd when passing console_lock owner

Piotr Stankiewicz (1):
      IB/hfi1: Fix an out-of-bounds access in get_hw_stats

Qian Cai (1):
      debugobjects: avoid recursive calls with kmemleak

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix dma-unsafe read of scratch registers

Robbie Ko (1):
      Btrfs: send, fix infinite loop due to directory rename dependencies

Romain Izard (1):
      ARM: dts: at91: sama5d2: use the divided clock for SMC

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

Sasha Levin (1):
      Revert "printk: Never set console_may_schedule in console_trylock()"

Sergey Senozhatsky (1):
      printk: Never set console_may_schedule in console_trylock()

Shmulik Ladkani (1):
      ipv6: sr: properly initialize flowi6 prior passing to ip6_route_output

Srikanth Boddepalli (1):
      xen: xlate_mmu: add missing header to fix 'W=3D1' warning

Stefano Brivio (2):
      ipv6: Check available headroom in ip6_xmit() even without options
      neighbour: Avoid writing before skb->head in neigh_hh_output()

Steven Rostedt (VMware) (1):
      printk: Add console owner and waiter logic to load balance console wr=
ites

Su Yanjun (1):
      net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Taehee Yoo (2):
      netfilter: xt_hashlimit: fix a possible memory leak in htable_create()
      netfilter: nf_tables: deactivate expressions in rule replecement rout=
ine

Takashi Sakamoto (1):
      ALSA: fireface: fix reference to wrong register for clock configurati=
on

Tarick Bedeir (1):
      net/mlx4_core: Correctly set PFC param if global pause is turned off.

Thomas Richter (1):
      s390/cpum_cf: Reject request for sampling in event initialization

Tigran Mkrtchyan (1):
      flexfiles: enforce per-mirror stateid only for v4 DSes

Trent Piepho (1):
      PCI: imx6: Fix link training status detection in link up check

Tzung-Bi Shih (1):
      ASoC: dapm: Recalculate audio map forcely when card instantiated

Wei Yang (1):
      mm/page_alloc.c: fix calculation of pgdat->nr_zones

Xin Long (2):
      sctp: kfree_rcu asoc
      ipvs: call ip_vs_dst_notifier earlier than ipv6_dev_notf

Y.C. Chen (1):
      drm/ast: fixed reading monitor EDID not stable issue

Yi Wang (2):
      KVM: x86: fix empty-body warnings
      x86/kvm/vmx: fix old-style function declaration

Yuchung Cheng (1):
      tcp: fix NULL ref in tail loss probe

YueHaibing (1):
      sysv: return 'err' instead of 0 in __sysv_write_inode

Yunjian Wang (1):
      igb: fix uninitialized variables

shaoyunl (1):
      drm/amdgpu: Add delay after enable RLC ucode


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwXZLIACgkQONu9yGCS
aT6SEg/9HvIYziiPR61CtETE8yT/1XE2OdUxK0XrXLnBuMU6ylhUtPbedzR/xDtb
TtgdxHg5Olaa5hhFVGiFzobgS1VkURxSIZ5diaD34yqja10pO2XOGYt2pZbz6n8a
VgmYTsOZrVxS6z7B6lrzUuVGJgUsNfJrHY46Koj3tEw2Uz2bGimWNx8Pvj78Wi7F
FbMygiG0ozXY3P7HRBuJ2PxgSnJErwG5igk2rKtAR2VLPVqI+ehJc8Sscm1BmvUO
Nes7JI5j3+1At1zIuo3vJWXiP5vVud8a9cao+DaSSM6/B6QKal4ESBHTNKF3R4UL
t+HYV0hxC13WImiqiHaBVGyZzzBse/IZ92NdD/jBT4+nF0OpagJjD+s6MjnkyQ7c
zddWWV36OkLAqDgv/RjQLVl6XNFRSiSoj4upuPgNWI0Rh/jUolzBNX3o2abnXd31
mpqX/T5RsBg6IEVio4IDcbRE7JTBtki1gTF947hhcxMoUq1Wd6a3w9CQms95vrOZ
IjWTMKV0z6KZZgkhiB/6nOLoqRCs/X4XIN8+i4cnj66u5r8t/DcsHqjK6UoLQiDs
sKotakedRiApTuzti4fT5Xkrj9rNivzAsoWLcfNiSRmahhQqQ/bj4xmCVjfuHS7P
2Mv0QXWC7o1SySnx11NmrQSln7f4GPtzovjZzd75e5iXX9DA46U=
=LdYC
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
