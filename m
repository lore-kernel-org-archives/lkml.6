Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E002084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545037003;
	bh=uadQJYKyaKHE7MWKSc28DKNHRYsVi7P+xsAVOUiwVOg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SlVBBXlM0ZHyMRm+pwbSGCX7BMCRfNx+aibaL/pJwjk2zTT+pbRbvudCb6/YKI2Fr
	 SIh6WUulh48VZ7CW53QD2rfnu8eSfvIiRJ/TQaSvg3OOmcPuVQhIDLHdKcZgF5rDeP
	 qAzWXi/krtubEcn8Zoiy6Nk2N8fs9XmNSUjm/21c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbeLQI4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbeLQI4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:56:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1A22084D;
        Mon, 17 Dec 2018 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545037000;
        bh=uadQJYKyaKHE7MWKSc28DKNHRYsVi7P+xsAVOUiwVOg=;
        h=Date:From:To:Cc:Subject:From;
        b=bG6rbZuW8lAjQP+c9muRECrjqErMpssDvnU8XKBgJUeWSha1swg96PXs5jb73d1ze
         l44TGdWWVDVewxehvM0PG1rpxlM9MvVKUA5ZRKM50hqXfUkrIYgynmZKvVNTGA8FkO
         cUcvPalkgEngTLcFya5dvOG9CRsY6/M7lW+NqX6w=
Date:   Mon, 17 Dec 2018 09:56:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.146
Message-ID: <20181217085637.GA1232@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.146 kernel.

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

 Makefile                                              |    2=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                 |    2=20
 arch/arm/mach-omap1/board-ams-delta.c                 |    3=20
 arch/arm/mach-omap2/prm44xx.c                         |    2=20
 arch/s390/kernel/perf_cpum_cf.c                       |    2=20
 arch/x86/kvm/lapic.c                                  |    2=20
 arch/x86/kvm/vmx.c                                    |    8 -
 drivers/gpu/drm/ast/ast_mode.c                        |   36 ++++++-
 drivers/hwmon/ina2xx.c                                |    2=20
 drivers/hwmon/w83795.c                                |    2=20
 drivers/infiniband/hw/mlx5/qp.c                       |   19 ++-
 drivers/net/ethernet/cavium/thunder/nic_main.c        |    3=20
 drivers/net/ethernet/hisilicon/hip04_eth.c            |    4=20
 drivers/net/ethernet/intel/igb/e1000_i210.c           |    1=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c         |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c       |    4=20
 drivers/net/ethernet/realtek/8139cp.c                 |    5 +
 drivers/net/phy/phy_device.c                          |   19 +--
 drivers/net/tun.c                                     |    6 -
 drivers/staging/speakup/kobjects.c                    |    4=20
 drivers/usb/gadget/udc/omap_udc.c                     |   87 ++++++-------=
-----
 drivers/xen/xlate_mmu.c                               |    1=20
 fs/btrfs/send.c                                       |   11 +-
 fs/cachefiles/rdwr.c                                  |    9 +
 fs/exportfs/expfs.c                                   |    2=20
 fs/fscache/object.c                                   |    3=20
 fs/hfs/btree.c                                        |    3=20
 fs/hfsplus/btree.c                                    |    3=20
 fs/ocfs2/export.c                                     |    2=20
 fs/ocfs2/move_extents.c                               |   47 +++++----
 fs/pstore/platform.c                                  |    4=20
 fs/sysv/inode.c                                       |    2=20
 include/net/neighbour.h                               |   28 ++++-
 kernel/trace/bpf_trace.c                              |    8 +
 lib/debugobjects.c                                    |    3=20
 net/core/rtnetlink.c                                  |    3=20
 net/ipv4/tcp_output.c                                 |   12 +-
 net/ipv6/ip6_output.c                                 |   42 ++++----
 net/netfilter/ipvs/ip_vs_ctl.c                        |    3=20
 net/sched/sch_netem.c                                 |    3=20
 sound/soc/omap/omap-abe-twl6040.c                     |   67 ++++++-------
 sound/soc/omap/omap-dmic.c                            |    9 +
 sound/soc/omap/omap-mcpdm.c                           |   43 ++++++++
 sound/soc/soc-core.c                                  |    1=20
 tools/objtool/elf.c                                   |   19 +++
 tools/testing/selftests/Makefile                      |    1=20
 tools/testing/selftests/netfilter/Makefile            |    6 +
 tools/testing/selftests/netfilter/config              |    2=20
 tools/testing/selftests/netfilter/nft_trans_stress.sh |   78 +++++++++++++=
+++
 49 files changed, 417 insertions(+), 215 deletions(-)

Aaro Koskinen (4):
      USB: omap_udc: use devm_request_irq()
      USB: omap_udc: fix crashes on probe error and module removal
      USB: omap_udc: fix omap_udc_start() on 15xx machines
      USB: omap_udc: fix USB gadget functionality on Palm Tungsten E

Adam Ford (1):
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1

Artem Savkov (2):
      objtool: Fix double-free in .cold detection error path
      objtool: Fix segfault in .cold detection with -ffunction-sections

Christoph Paasch (1):
      net: Prevent invalid access to skb->prev in __qdisc_drop_all

Colin Ian King (1):
      fscache, cachefiles: remove redundant variable 'cache'

Eric Dumazet (1):
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices

Florian Westphal (1):
      selftests: add script to stress-test nft packet path vs. control plane

Greg Kroah-Hartman (1):
      Linux 4.9.146

Guenter Roeck (1):
      staging: speakup: Replace strncpy with memcpy

Heiner Kallweit (1):
      net: phy: don't allow __set_phy_supported to add unsupported modes

Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Josh Elsasser (1):
      ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Kiran Kumar Modukuri (1):
      cachefiles: Fix page leak in cachefiles_read_backing_file while vmsca=
n is active

Larry Chen (1):
      ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Lorenzo Bianconi (1):
      net: thunderx: fix NULL pointer dereference in nic_remove

Majd Dibbiny (1):
      RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR

Martynas Pumputis (1):
      bpf: fix check of allowed specifiers in bpf_trace_printk

Namhyung Kim (1):
      pstore: Convert console write to use ->write_buf

Nathan Chancellor (1):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_i=
o_wakeup

NeilBrown (1):
      fscache: fix race between enablement and dropping of object

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops

Nicolin Chen (1):
      hwmon: (ina2xx) Fix current value calculation

Pan Bian (5):
      exportfs: do not read dentry after free
      net: hisilicon: remove unexpected free_netdev
      hfs: do not free node before using
      hfsplus: do not free node before using
      ocfs2: fix potential use after free

Peter Ujfalusi (3):
      ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred pro=
bing
      ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CP=
U_IDLE
      ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Qian Cai (1):
      debugobjects: avoid recursive calls with kmemleak

Robbie Ko (1):
      Btrfs: send, fix infinite loop due to directory rename dependencies

Srikanth Boddepalli (1):
      xen: xlate_mmu: add missing header to fix 'W=3D1' warning

Stefano Brivio (2):
      ipv6: Check available headroom in ip6_xmit() even without options
      neighbour: Avoid writing before skb->head in neigh_hh_output()

Su Yanjun (1):
      net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Tarick Bedeir (1):
      net/mlx4_core: Correctly set PFC param if global pause is turned off.

Thomas Richter (1):
      s390/cpum_cf: Reject request for sampling in event initialization

Tzung-Bi Shih (1):
      ASoC: dapm: Recalculate audio map forcely when card instantiated

Xin Long (1):
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


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwXZMUACgkQONu9yGCS
aT71eQ/9E+FV4eY2n038yxUhwvuAeWf5ga0Xc7Jv5VJ/S1+HlLd4rznHk0q/FlRq
qCMZuqQcThAl2UCqo2CMNOTcR8rUsCWsuz5FZ5v5VmIUKIayH/1YiebWkFoJTj0K
blz9jLmONMEvLlPgzG1jLlYssy3k1VfGwrZmaDMD49WURHU9aE6ZeyWq7NSO4bOw
TCQxsWeAhtXWTTHJt39SokCIlQNyPetwQIqp8HDdfOJYOMjI2IicoLJH686Iu6vL
PKZAm68gsnCoAkw4qlbiEXHLOPhF7eDdxxLSMDgKhiwpsLq8inlY6dKB+sWIbnv1
xoi1JC4OG3nsriL9zEX/xOGRSYZfhFvcyRmJ4yweSz9sW4BjUy8cDvFRDCocxC4y
SoSvJLGgtjzksPJBY7T7PqI2L0q67TiGm5KFhVk3kB7AQIezvh24C1d4QHFigF4Y
dZz91Hue7f8wdK8FDkUs+UeWo9wS/n8e+hzACa/aOKWBNew6LPI81FAQHp7dQz0O
JZzegrVCLPZfBJJ9bxjPIy35auqOzYR1mG57YA1GTuhJSoKxt1hkPh4XONbYR6BM
aCUUPB4njThF0YQjcZOVu60+bv1PAnJpY6BuFNr6TRxD+DdLqBkcM+UZdf9A3ibz
XsYBbzUEKYhB3DSessbS+B6qZ7dIqfBwmnxbPprKPaAGOpqCrkY=
=aKHd
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
