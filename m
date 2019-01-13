Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38763C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31A920873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547373301;
	bh=JREQmgmiIQbpAvL/cB4+0z4pn0XV9/sQ8swtu5PE+KI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AsRwqmg5LO4NaAyNVBmy+Rpi7iYUwZl1ZyC02s1OWdmLQ+vmuvP1neQBn6izgP77U
	 eQtOXvtp3uusMo80gfuA0UsRd4EtSvxOJLEKJAGyAyzBJukEsB+KVRe7CK2OJ47fgB
	 ZhwgetSWZ38D11znE1mBJ3HJh15Pmd8zy4wUYL0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfAMJzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfAMJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:54:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DAC20873;
        Sun, 13 Jan 2019 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547373298;
        bh=JREQmgmiIQbpAvL/cB4+0z4pn0XV9/sQ8swtu5PE+KI=;
        h=Date:From:To:Cc:Subject:From;
        b=Osb1RV4foL6gj54A/bdQDIZDu0vw5wFk2zZxzpoZ8X7bf8tYLTeabjCXohwKbJAPr
         iwoZZOXdKV90OzvzZFFxBDTvsS2MtJQ2TIdquFa+PoIAyEpkUjhbIJ5V8/kXY90MU7
         +CxRk4hqG4Hb7P8tpH+clRSHtrSXmoTWEw6JUJ4s=
Date:   Sun, 13 Jan 2019 10:54:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.150
Message-ID: <20190113095455.GA19868@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.150 kernel.

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

 Makefile                                             |    2=20
 arch/arm/boot/dts/imx7d-nitrogen7.dts                |    9=20
 arch/arm/mach-imx/cpuidle-imx6sx.c                   |    2=20
 arch/mips/kernel/vdso.c                              |    4=20
 arch/mips/math-emu/dsemul.c                          |   38 +-
 arch/powerpc/boot/crt0.S                             |    4=20
 arch/powerpc/kernel/signal_32.c                      |   20 +
 arch/powerpc/kernel/signal_64.c                      |   44 ++-
 arch/x86/crypto/chacha20_glue.c                      |    1=20
 drivers/gpu/drm/vc4/vc4_plane.c                      |    1=20
 drivers/hwtracing/intel_th/msu.c                     |    3=20
 drivers/infiniband/hw/hfi1/verbs.c                   |    2=20
 drivers/infiniband/sw/rxe/rxe_resp.c                 |   13 -
 drivers/input/keyboard/omap4-keypad.c                |   16 -
 drivers/iommu/intel-iommu.c                          |    4=20
 drivers/misc/genwqe/card_utils.c                     |    2=20
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c     |    3=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h          |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |   54 +++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h       |    4=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c    |    3=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c   |   14 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c    |   15 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c   |  246 +++++++++-----=
-----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h    |   13 -
 drivers/net/ethernet/hisilicon/hns/hns_enet.c        |   43 +++
 drivers/net/ethernet/neterion/vxge/vxge-config.c     |    2=20
 drivers/net/ethernet/nuvoton/w90p910_ether.c         |    2=20
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c |    3=20
 drivers/net/usb/lan78xx.c                            |    4=20
 drivers/net/wireless/broadcom/b43/phy_common.c       |    2=20
 drivers/pinctrl/meson/pinctrl-meson.c                |    3=20
 drivers/power/supply/olpc_battery.c                  |    4=20
 drivers/s390/scsi/zfcp_aux.c                         |    6=20
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                    |    2=20
 drivers/target/iscsi/cxgbit/cxgbit_cm.c              |    5=20
 drivers/target/iscsi/cxgbit/cxgbit_main.c            |    1=20
 drivers/tty/serial/sunsu.c                           |   31 ++
 drivers/vhost/vsock.c                                |    2=20
 fs/ceph/caps.c                                       |    1=20
 fs/dlm/lock.c                                        |   17 -
 fs/dlm/lockspace.c                                   |    2=20
 fs/gfs2/inode.c                                      |   18 -
 fs/gfs2/rgrp.c                                       |    2=20
 include/uapi/linux/input-event-codes.h               |    9=20
 kernel/fork.c                                        |   13 -
 kernel/memremap.c                                    |   11=20
 mm/memory_hotplug.c                                  |   16 +
 net/9p/client.c                                      |   21 +
 net/ceph/auth_x.c                                    |    2=20
 net/netfilter/ipset/ip_set_list_set.c                |    2=20
 net/netfilter/nf_conntrack_seqadj.c                  |    7=20
 net/sunrpc/auth_gss/svcauth_gss.c                    |    8=20
 net/sunrpc/cache.c                                   |   10=20
 net/sunrpc/xprtsock.c                                |    4=20
 net/xfrm/xfrm_state.c                                |    2=20
 scripts/checkstack.pl                                |    4=20
 sound/pci/cs46xx/dsp_spos.c                          |    3=20
 sound/usb/mixer.c                                    |   10=20
 sound/usb/quirks-table.h                             |    3=20
 tools/testing/nvdimm/test/iomap.c                    |    2=20
 61 files changed, 522 insertions(+), 273 deletions(-)

Alexander Shishkin (1):
      intel_th: msu: Fix an off-by-one in attribute store

Andreas Gruenbacher (2):
      gfs2: Get rid of potential double-freeing in gfs2_create_inode
      gfs2: Fix loop in gfs2_rbm_find

Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Arnd Bergmann (1):
      w90p910_ether: remove incorrect __init annotation

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace

Boris Brezillon (1):
      drm/vc4: Set ->is_yuv to false when num_planes =3D=3D 1

Breno Leitao (1):
      powerpc/tm: Set MSR[TS] just prior to recheckpoint

Christian Borntraeger (1):
      genwqe: Fix size check

Colin Ian King (1):
      vxge: ensure data0 is initialized in when fetching firmware version i=
nformation

Dan Carpenter (2):
      scsi: bnx2fc: Fix NULL dereference in error handling
      ALSA: cs46xx: Potential NULL dereference in probe

Dan Williams (2):
      mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: kill mapping "System RAM" support

David Herrmann (1):
      fork: record start_time late

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Eric Biggers (1):
      crypto: x86/chacha20 - avoid sleeping with preemption disabled

Fabio Estevam (1):
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Florian Westphal (1):
      netfilter: seqadj: re-load tcp header pointer after possible head rea=
llocation

Greg Kroah-Hartman (1):
      Linux 4.9.150

Hui Peng (1):
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Ilya Dryomov (1):
      libceph: fix CEPH_FEATURE_CEPHX_V2 check in calc_signature()

Ivan Mironov (1):
      bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some =
hw

Jason Martinsen (1):
      lan78xx: Resolve issue with changing MAC address

Jerome Brunet (1):
      pinctrl: meson: fix pull enable register calculation

Kangjie Lu (1):
      net: netxen: fix a missing check and an uninitialized use

Larry Finger (1):
      b43: Fix error in cordic routine

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Michael J. Ruhl (1):
      IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Michal Hocko (1):
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

Nathan Chancellor (1):
      drivers: net: xgene: Remove unnecessary forward declarations

Pan Bian (1):
      netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel

Paul Burton (1):
      MIPS: math-emu: Write-protect delay slot emulation pages

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Peter Hutterer (1):
      Input: restore EV_ABS ABS_RESERVED

Qian Cai (1):
      checkstack.pl: fix for aarch64

Sagi Grimberg (1):
      rxe: fix error completion wr_id and qp_num

Sohil Mehta (1):
      iommu/vt-d: Handle domain agaw being less than iommu agaw

Stefan Hajnoczi (1):
      vhost/vsock: fix uninitialized vhost_vsock->guest_cid

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Sudarsana Reddy Kalluru (3):
      bnx2x: Clear fip MAC when fcoe offload support is disabled
      bnx2x: Remove configured vlans as part of unload sequence.
      bnx2x: Send update-svid ramrod with retry/poll flags enabled

Takashi Iwai (1):
      ALSA: usb-audio: Avoid access before bLength check in build_audio_pro=
cunit()

Tony Lindgren (1):
      Input: omap-keypad - fix idle configuration to not block SoC idle sta=
tes

Trond Myklebust (1):
      SUNRPC: Fix a race with XPRT_CONNECTING

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix csk leak
      scsi: target: iscsi: cxgbit: add missing spin_lock_init()

Vasily Averin (6):
      sunrpc: fix cache_head leak due to queued request
      sunrpc: use SVC_NET() in svcauth_gss_* functions
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlo=
ck()
      dlm: memory leaks on error path in dlm_user_request()

Yan, Zheng (1):
      ceph: don't update importing cap's mseq when handing cap export

Yangtao Li (1):
      serial/sunsu: fix refcount leak

Yonglong Liu (9):
      net: hns: Incorrect offset address used for some registers.
      net: hns: All ports can not work when insmod hns ko after rmmod.
      net: hns: Some registers use wrong address according to the datasheet.
      net: hns: Fixed bug that netdev was opened twice
      net: hns: Clean rx fbd when ae stopped.
      net: hns: Free irq when exit from abnormal branch
      net: hns: Avoid net reset caused by pause frames storm
      net: hns: Fix ntuple-filters status error.
      net: hns: Add mac pcs config when enable|disable mac


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw7Cu8ACgkQONu9yGCS
aT4cmw/+NRiC48HWdS4/6TxVa846nAFwk2ItXJoSAuSvAwdJta9fIUaPUwzb6SDV
JSyVGuIKWZWIUlPvh1SkJmxpKSlGCWDhMUIbLAa4sMqj2esesZ6z60930ioiUUsC
+n+2xGWZ3lGrDjw2ki9jYS8WLFr3NPN9hpwrOmn6N8r1AQ4XPcdGiuU/Hi/l+S05
60vCb8+vgBjW1GqaFdGPTsE1npDERx33QU7EGzteMvEX9KK8c5szLmRgIO8RZVps
ihhSLClQ/EBaybYasqclCW/bvaPs65q2y026jd94RQEHsC7xciI4yUFVba+X7jFc
jlfWgqFtBDtdnzJlQU0/+hNFOzdvWhdkUecEsXDpJ2VTRv20NjoSAZgXPznykVHn
/uV9Yk10Gu6C2YYFv0ULvXJLtJE0tZMqsTi1NH9icr8IFo/P3maAF2O4Zs9dH0rT
W1mWtnH9OHS/UgZxlVdHi4XZTHpaHtzZONuwZZ3KvF0DhNjyYxGeFbxQ++Ow5RBf
L+wF5IHcmNL8yWGgzsZtJpE1ZinfFnQ0TX+piH1rkbG+T5PJdsNZudoSuKQxSe+B
rqQGQmc2k0LAl35nGL5DXaY3gX7PKd1K2YT4XBwab2/rCq/ZRC55LcJDxXf0pqJ9
HT8VeE44/y2LI4qZMMfyNLnujZe1BFiyQ8FWVcmajdnoRfxqvSM=
=TzAY
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
