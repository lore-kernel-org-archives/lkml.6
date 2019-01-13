Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A52DC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A14620873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547373386;
	bh=Koy9eWi4lXXphPMQGY94fxFGByBScBZwBz6/NThE9fA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=S3D1g3oxapbpdH9czgTfeBkbtTakiN8wliipCLnddys4SfrojxIlaKhDzTn2cD882
	 v4gtzyhkmjwbehSd8jCfyJdkQ3MitZmAhpZJ3hAaGmv6rCgAKWiUlxe87FtW782Tqi
	 mWdfmAvwpVzTifpK4k98X+S1B7Ty2/GOzZtAhpFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfAMJ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfAMJ4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:56:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1946720873;
        Sun, 13 Jan 2019 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547373383;
        bh=Koy9eWi4lXXphPMQGY94fxFGByBScBZwBz6/NThE9fA=;
        h=Date:From:To:Cc:Subject:From;
        b=lop5sfIyWo+FH7mc/GvfgUsOLN1yXHwRojbtW6MVS4bp02Vm/SUrHAq9T0wPlKUO+
         bkcoJyRV9Y4kiwjVbd60ILmJwwDigpfTKMqOSD/PSB+2oeuT2xjI3ibq8BurFJisuz
         5AGR1b1KCEKY0sngL2ngNIOg4pbNcmamvBcYV96g=
Date:   Sun, 13 Jan 2019 10:56:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.2
Message-ID: <20190113095621.GA25067@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.2 kernel.

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

 Makefile                                                 |    2=20
 arch/powerpc/kernel/signal_32.c                          |   38 +
 arch/powerpc/kernel/signal_64.c                          |   64 +--
 arch/powerpc/platforms/4xx/ocm.c                         |    4=20
 block/blk-mq-sched.c                                     |    3=20
 block/blk-mq-sched.h                                     |    1=20
 block/blk-stat.h                                         |    5=20
 block/blk-wbt.c                                          |    4=20
 block/mq-deadline.c                                      |   12=20
 drivers/base/dd.c                                        |    4=20
 drivers/block/zram/zram_drv.c                            |    4=20
 drivers/dax/pmem.c                                       |   14=20
 drivers/gpu/drm/nouveau/dispnv50/disp.c                  |   12=20
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c              |    4=20
 drivers/gpu/drm/vc4/vc4_plane.c                          |    1=20
 drivers/hwtracing/intel_th/msu.c                         |    3=20
 drivers/hwtracing/stm/policy.c                           |   12=20
 drivers/iio/adc/qcom-spmi-adc5.c                         |   58 +-
 drivers/iio/dac/ad5686.c                                 |    3=20
 drivers/infiniband/core/iwcm.c                           |   12=20
 drivers/infiniband/sw/rxe/rxe_resp.c                     |   13=20
 drivers/infiniband/ulp/srpt/ib_srpt.c                    |   18=20
 drivers/iommu/intel-iommu.c                              |    4=20
 drivers/md/dm-table.c                                    |    3=20
 drivers/media/pci/cx23885/cx23885-core.c                 |   55 ++
 drivers/media/pci/cx23885/cx23885.h                      |    2=20
 drivers/misc/genwqe/card_utils.c                         |    2=20
 drivers/net/wireless/broadcom/b43/phy_common.c           |    2=20
 drivers/nvdimm/pmem.c                                    |   13=20
 drivers/of/base.c                                        |  101 +++-
 drivers/of/dynamic.c                                     |    3=20
 drivers/of/of_private.h                                  |    4=20
 drivers/pci/p2pdma.c                                     |   10=20
 drivers/pci/pci-driver.c                                 |   27 -
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c            |    4=20
 drivers/power/supply/olpc_battery.c                      |    4=20
 drivers/s390/scsi/zfcp_aux.c                             |    6=20
 drivers/scsi/lpfc/lpfc_sli.c                             |    3=20
 drivers/video/fbdev/pxafb.c                              |    4=20
 fs/ceph/caps.c                                           |    1=20
 fs/dlm/lock.c                                            |   17=20
 fs/dlm/lockspace.c                                       |    2=20
 fs/gfs2/inode.c                                          |   18=20
 fs/gfs2/rgrp.c                                           |    2=20
 fs/lockd/clntproc.c                                      |    2=20
 fs/lockd/xdr.c                                           |    4=20
 fs/lockd/xdr4.c                                          |    4=20
 fs/nfsd/nfs4proc.c                                       |    2=20
 include/linux/hmm.h                                      |    4=20
 include/linux/memremap.h                                 |    2=20
 kernel/fork.c                                            |   13=20
 kernel/memremap.c                                        |   94 ++--
 kernel/pid.c                                             |    6=20
 kernel/rcu/srcutree.c                                    |    2=20
 kernel/sched/fair.c                                      |   43 --
 lib/test_debug_virtual.c                                 |    1=20
 mm/hmm.c                                                 |  305 ++--------=
-----
 mm/memcontrol.c                                          |   20=20
 mm/memory_hotplug.c                                      |   16=20
 mm/swapfile.c                                            |    3=20
 net/9p/client.c                                          |   21 +
 net/sunrpc/auth_gss/svcauth_gss.c                        |    8=20
 net/sunrpc/cache.c                                       |   10=20
 net/sunrpc/xprtrdma/frwr_ops.c                           |    6=20
 net/sunrpc/xprtrdma/verbs.c                              |    9=20
 security/selinux/ss/policydb.c                           |   51 +-
 sound/pci/cs46xx/dsp_spos.c                              |    3=20
 sound/usb/card.c                                         |    2=20
 sound/usb/mixer.c                                        |   29 +
 sound/usb/quirks-table.h                                 |    6=20
 sound/usb/stream.c                                       |   36 +
 tools/testing/nvdimm/test/iomap.c                        |   17=20
 tools/testing/selftests/android/Makefile                 |    2=20
 tools/testing/selftests/futex/functional/Makefile        |    1=20
 tools/testing/selftests/gpio/Makefile                    |    6=20
 tools/testing/selftests/kvm/Makefile                     |    2=20
 tools/testing/selftests/lib.mk                           |    8=20
 tools/testing/selftests/networking/timestamping/Makefile |    1=20
 tools/testing/selftests/tc-testing/bpf/Makefile          |    1=20
 tools/testing/selftests/vm/Makefile                      |    1=20
 80 files changed, 709 insertions(+), 610 deletions(-)

Alexander Shishkin (2):
      stm class: Fix a module refcount leak in policy creation error path
      intel_th: msu: Fix an off-by-one in attribute store

Andreas Gruenbacher (2):
      gfs2: Get rid of potential double-freeing in gfs2_create_inode
      gfs2: Fix loop in gfs2_rbm_find

Bart Van Assche (1):
      RDMA/srpt: Fix a use-after-free in the channel release code

Benjamin Coddington (1):
      lockd: Show pid of lockd for remote locks

Boris Brezillon (1):
      drm/vc4: Set ->is_yuv to false when num_planes =3D=3D 1

Brad Love (1):
      media: cx23885: only reset DMA on problematic CPUs

Breno Leitao (1):
      powerpc/tm: Set MSR[TS] just prior to recheckpoint

Christian Borntraeger (1):
      genwqe: Fix size check

Christian Lamparter (1):
      powerpc/4xx/ocm: Fix compilation error due to PAGE_KERNEL usage

Christophe Leroy (1):
      lib: fix build failure in CONFIG_DEBUG_VIRTUAL test

Chuck Lever (1):
      xprtrdma: Yet another double DMA-unmap

Damien Le Moal (1):
      block: mq-deadline: Fix write completion handling

Dan Carpenter (1):
      ALSA: cs46xx: Potential NULL dereference in probe

Dan Williams (7):
      mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: kill mapping "System RAM" support
      mm, devm_memremap_pages: fix shutdown handling
      mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support
      mm, hmm: use devm semantics for hmm_devmem_{add, remove}
      mm, hmm: replace hmm_devmem_pages_create() with devm_memremap_pages()
      mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL

David Herrmann (1):
      fork: record start_time late

Dennis Krein (1):
      srcu: Lock srcu_data structure in srcu_gp_start()

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Enric Balletbo i Serra (1):
      drm/rockchip: psr: do not dereference encoder before it is null check=
ed.

Evan Green (1):
      iio: adc: qcom-spmi-adc5: Initialize prescale properly

Ewan D. Milne (1):
      scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcn=
t is invalid

Frank Rowand (2):
      of: of_node_get()/of_node_put() nodes held in phandle cache
      of: __of_detach_node() - remove node from phandle cache

Greg Kroah-Hartman (2):
      Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"
      Linux 4.20.2

Huang Ying (1):
      mm, swap: fix swapoff with KSM pages

Hui Peng (1):
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

J. Bruce Fields (1):
      nfsd4: zero-length WRITE should succeed

Jaegeuk Kim (1):
      dm: do not allow readahead to limit IO size

Jarkko Nikula (1):
      PCI / PM: Allow runtime PM without callback functions

Larry Finger (1):
      b43: Fix error in cordic routine

Linus Torvalds (1):
      sched/fair: Fix infinite loop in update_blocked_averages() by reverti=
ng a9e7f6544b9c

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Check rc from drm_dp_mst_topology_mgr_resume=
()

Matthew Wilcox (1):
      Fix failure path in alloc_pid()

Michal Hocko (2):
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined
      memcg, oom: notify on oom killer invocation from the charge path

Minchan Kim (1):
      zram: fix double free backing device

Ming Lei (1):
      block: deactivate blk_stat timer in wbt_disable_default()

Mircea Caprioru (1):
      iio: dac: ad5686: fix bit shift read register

Ondrej Mosnacek (1):
      selinux: policydb - fix byte order and alignment issues

Rafael J. Wysocki (1):
      driver core: Add missing dev->bus->need_parent_lock checks

Sagi Grimberg (1):
      rxe: fix error completion wr_id and qp_num

Shaokun Zhang (1):
      drivers/perf: hisi: Fixup one DDRC PMU register offset

Shuah Khan (1):
      selftests: Fix test errors related to lib.mk khdr target

Sohil Mehta (1):
      iommu/vt-d: Handle domain agaw being less than iommu agaw

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Steve Wise (1):
      RDMA/iwcm: Don't copy past the end of dev_name() string

Takashi Iwai (3):
      ALSA: usb-audio: Avoid access before bLength check in build_audio_pro=
cunit()
      ALSA: usb-audio: Check mixer unit descriptors more strictly
      ALSA: usb-audio: Always check descriptor sizes in parser code

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

YueHaibing (1):
      video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated da=
ta"


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw7C0QACgkQONu9yGCS
aT5zPhAAjUNz5Ja/Hkh7/XtL3uoFFHYnP0GdWjDkTUY/HvAr+MJ44fpoSODzabPs
Xjl2ZOM3cRCe24fa5Ufq8D7GZ8aggHT0QW3d0gsL1yBDnQsj4M0d8tcC1bMXPT0E
PcVe33910utUiyyRpwOOzUqUnmwgTSZ3MDMYfXAYYZzlJQjuulSgFFSfa+R2ue/2
w2w4LaIMhjbQbQ9/KI5YQL1nSrvu1wZA1RNn+Tapy5GzGZ8I9zclBa5Ad06mYQBU
up6GCmGe0Zt2VYYRYauyIR1zO1mTfcNPJcVkZDHFgPmdiI5beZuiUIA8WohPV4LI
AXqFy+RCkh1ulLsECgb8elqLWmIUGQdHifBbSUuYOCHZIhrahlxtM1+FQkvQyf7D
WQHSNgcIWPHZtwPGbCsevS/wltLs0H4fl6d1aHomedACvI2Mn+IDHyBweUNBlasp
sGiH0yllICs+JqRgFxQLb5Mk+2DQSGc+odF1kiLxGyGW98+ANpevxnBZtCZCW6Us
7T1J7p9OD0Gj6eK0+frlYDtO1KEtzUiZi/CQfNh7CEWMUdDBygmE5cHUOHD0rrAV
FchKxfoTfYHuOaQ4yOXCRAHtQCQ7/T8JZQNYiYzGmecV/rIf5g9VDj0VKhM17DI8
lvzMNgsPli1GaHyNps7uuvP6uPxmo37BljY5WT3LokqB1f3bldU=
=gWUg
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
