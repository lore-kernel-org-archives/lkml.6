Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C392C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B2206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B2206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIJMEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:04:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:04:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 199BBCAA;
        Mon, 10 Sep 2018 07:12:08 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:12:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.155
Message-ID: <20180910071206.GA21319@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.155 kernel.

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

 Makefile                                   |    2=20
 arch/alpha/kernel/osf_sys.c                |   64 ++++++++-----------
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |    1=20
 arch/powerpc/include/asm/fadump.h          |    3=20
 arch/powerpc/kernel/fadump.c               |   92 +++++++++++++++++++++++-=
----
 arch/powerpc/platforms/pseries/ras.c       |    2=20
 arch/sparc/kernel/sys_sparc_32.c           |   22 +++---
 arch/sparc/kernel/sys_sparc_64.c           |   20 +++---
 arch/x86/include/asm/io.h                  |    6 +
 arch/x86/mm/pageattr.c                     |    2=20
 arch/x86/mm/pat.c                          |   14 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |    5 +
 drivers/gpu/drm/ast/ast_ttm.c              |    6 +
 drivers/gpu/drm/cirrus/cirrus_ttm.c        |    7 ++
 drivers/gpu/drm/i915/i915_gem_userptr.c    |    3=20
 drivers/gpu/drm/mgag200/mgag200_ttm.c      |    7 ++
 drivers/gpu/drm/nouveau/nouveau_ttm.c      |    8 ++
 drivers/gpu/drm/radeon/radeon_object.c     |    5 +
 drivers/iio/frequency/ad9523.c             |    4 -
 drivers/iommu/dmar.c                       |    6 -
 drivers/iommu/intel-iommu.c                |   18 +++++
 drivers/md/bcache/writeback.c              |    4 -
 drivers/md/dm-cache-metadata.c             |    3=20
 drivers/misc/vmw_balloon.c                 |   67 ++++++++++++--------
 drivers/net/usb/lan78xx.c                  |    4 -
 drivers/pwm/pwm-tiehrpwm.c                 |    2=20
 drivers/spi/spi-davinci.c                  |    2=20
 drivers/video/fbdev/core/fbmem.c           |   38 +++++++++--
 fs/9p/xattr.c                              |    6 +
 fs/nfs/blocklayout/dev.c                   |    2=20
 fs/quota/quota.c                           |    2=20
 fs/ubifs/journal.c                         |   18 ++++-
 fs/ubifs/lprops.c                          |    8 +-
 fs/xattr.c                                 |    2=20
 include/linux/intel-iommu.h                |    8 +-
 include/linux/io.h                         |   22 ++++++
 include/video/udlfb.h                      |    2=20
 kernel/kthread.c                           |    8 ++
 kernel/power/Kconfig                       |    1=20
 kernel/sys.c                               |   95 +++++++++++++-----------=
-----
 kernel/trace/blktrace.c                    |    4 +
 kernel/trace/trace.c                       |    4 -
 kernel/trace/trace_uprobe.c                |    2=20
 kernel/user_namespace.c                    |   39 +++++------
 kernel/utsname_sysctl.c                    |   41 +++++++-----
 mm/memory.c                                |    9 --
 net/9p/client.c                            |    2=20
 net/9p/trans_fd.c                          |    7 +-
 net/9p/trans_rdma.c                        |    3=20
 net/9p/trans_virtio.c                      |   13 +++
 net/ieee802154/6lowpan/tx.c                |   21 +++++-
 net/mac802154/tx.c                         |   15 ++++
 tools/perf/util/auxtrace.c                 |    3=20
 53 files changed, 519 insertions(+), 235 deletions(-)

Adrian Hunter (1):
      perf auxtrace: Fix queue resize

Al Viro (1):
      osf_getdomainname(): use copy_to_user()

Alexander Aring (2):
      net: 6lowpan: fix reserved space for single frames
      net: mac802154: tx: expand tailroom if necessary

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Ben Hutchings (1):
      net: lan78xx: Fix misplaced tasklet_schedule() call

Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport

Christian Brauner (1):
      getxattr: use correct xattr length

Dan Carpenter (1):
      pnfs/blocklayout: off by one in bl_map_stripe()

Dave Airlie (2):
      x86/io: add interface to reserve io memtype for a resource range. (v1=
=2E1)
      drm/drivers: add support for using the arch wc mapping API.

Greg Kroah-Hartman (1):
      Linux 4.4.155

Hari Bathini (1):
      powerpc/fadump: handle crash memory ranges array index overflow

Jacob Pan (2):
      iommu/vt-d: Add definitions for PFSID
      iommu/vt-d: Fix dev iotlb pfsid use

Jann Horn (2):
      sys: don't hold uts_sem while accessing userspace memory
      userns: move user access out of the mutex

Jeremy Cline (1):
      fs/quota: Fix spectre gadget in do_quotactl

Jiri Slaby (1):
      x86/mm/pat: Fix L1TF stable backport for CPA, 2nd call

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Mahesh Salgaonkar (1):
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Matthew Auld (1):
      drm/i915/userptr: reject zero user_size

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock

Mikulas Patocka (2):
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: set optimal write delay

Nadav Amit (4):
      vmw_balloon: fix inflation of 64-bit GFNs
      vmw_balloon: do not use 2MB without batching
      vmw_balloon: VMCI_DOORBELL_SET does not check status
      vmw_balloon: fix VMCI use when balloon built into kernel

Peter Zijlstra (1):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition

Richard Weinberger (4):
      ubifs: Fix memory leak in lprobs self-check
      Revert "UBIFS: Fix potential integer overflow in allocation"
      ubifs: Check data node size before truncate
      ubifs: Fix synced_i_size calculation for xattr inodes

Shan Hai (1):
      bcache: release dc->writeback_lock properly in bch_writeback_thread()

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthrea=
ds

Steven Rostedt (VMware) (3):
      tracing: Do not call start/stop() functions when tracing_on does not =
change
      tracing/blktrace: Fix to allow setting same value
      uprobes: Use synchronize_rcu() not synchronize_sched()

Tomas Bortoli (3):
      net/9p/client.c: version pointer uninitialized
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before th=
e kfree()
      9p: fix multiple NULL-pointer-dereferences

Vignesh R (1):
      pwm: tiehrpwm: Fix disabling of output of PWMs

jiangyiwen (1):
      9p/virtio: fix off-by-one error in sg list bounds check

piaojun (1):
      fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr =
failed

zhangyi (F) (1):
      PM / sleep: wakeup: Fix build error caused by missing SRCU support


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluWGUUACgkQONu9yGCS
aT4m4RAAwGinvV8TxmzDuMZ1FW1I3F5Ik34ofJBmpOMc1NBfQXoK5qYKilG0quf8
AcZ6vXmaCP9s8JnWUkpDE9tModVktVRM8fR4kV7l/v5r4D0jBPGRdwLNU8IB0K9R
etxX8wW19LSUD2R5CnfFfW/0lCyUmTPlN+e7wfLZwU/99XTGr5BG/+riGJxpqCdk
WBphKDu8dxMMIsbMCdEBBfdGVQwLLeqhHq9DhJh4GHXGa7nQuIrUAjA+svqWTEUn
6hwZjoPpvjH5s/v7ExCbJ8uXb84r1Lq3gYyN7HqjersTT+hqg/Pudf03trTbNgXi
dHbgU2eWVyCMeI0E1sbCqsHUOeP6UBv5ff+6a7OHyeC26rV8+EE0Uq4qSwSpZvBr
bNdBXunNomPr7nLUrSJmKrS0+pbRgE3O37rTST8eBcU0WRMeIGrldoZ6WnVv+tx0
owGurBY+4jLOc0fTTmR0omYx2pI71iHbkx9aJyJ9vZznFwXDVZNq7yRkise0xzTO
TgyphGwK5dasLO0RBHo1G6W9MRtGPr0eRsVHnw4Uy9OrNpuf0UlL4JuP6WspCoKB
8gM3Qg9Zx3VKnFLF9uAwqX5gftZTgM9FsEGxxEm9NFw3AOP/3+mljBrjjeRu5id7
W4PZyt1gBWlvQEPWOfWUd2IyZVzioF47/xKwaPKE/geET2Ro8Wo=
=jKo8
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
