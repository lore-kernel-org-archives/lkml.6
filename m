Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DFF20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD6Gv14h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DFF20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJMQhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeJMQhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:37:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C6F20835;
        Sat, 13 Oct 2018 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539421251;
        bh=JSJe9RqVs8pw/RmzK1FuwzGiKmrm5Vq8rKcikP1Q7og=;
        h=Date:From:To:Cc:Subject:From;
        b=uD6Gv14hoiq2fyAEAmx2ywN6ju4tShw5HSsPaIjxyoSsj+ukNSlwSvTR7jpullwWE
         +rZlju7c3oMtm5k9b5019KkK27pbxIUicrmCQzqG8fjdFzrpuSQHZuRgn8Nj+iDvQB
         p7uaolGKmawrGnzHQELaRjxM36lqWO5sve3ha0AU=
Date:   Sat, 13 Oct 2018 11:00:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.14
Message-ID: <20181013090049.GA10263@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.14 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                        |    2=20
 arch/arc/kernel/process.c                       |   20 ++
 arch/powerpc/include/asm/setup.h                |    1=20
 arch/powerpc/lib/code-patching.c                |   14 +
 arch/powerpc/mm/mem.c                           |    2=20
 arch/x86/entry/vdso/Makefile                    |   16 +-
 arch/x86/entry/vdso/vclock_gettime.c            |   26 +--
 arch/x86/kvm/mmu.c                              |   24 ++-
 arch/x86/kvm/vmx.c                              |    7=20
 block/blk-mq.c                                  |    4=20
 drivers/base/power/main.c                       |    5=20
 drivers/clocksource/timer-atmel-pit.c           |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c         |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |    4=20
 drivers/gpu/drm/drm_lease.c                     |    6=20
 drivers/gpu/drm/drm_syncobj.c                   |    5=20
 drivers/infiniband/core/ucma.c                  |    2=20
 drivers/md/dm-cache-metadata.c                  |    4=20
 drivers/md/dm-cache-target.c                    |    9 -
 drivers/md/dm-mpath.c                           |   14 +
 drivers/mmc/core/host.c                         |    2=20
 drivers/mmc/core/slot-gpio.c                    |    2=20
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |    8 -
 drivers/net/xen-netback/hash.c                  |   12 -
 drivers/of/unittest.c                           |   26 ++-
 drivers/pci/pci.c                               |   27 ++-
 drivers/tty/tty_io.c                            |   11 +
 drivers/usb/class/cdc-acm.c                     |    6=20
 drivers/usb/host/xhci-mtk.c                     |    4=20
 drivers/usb/host/xhci-pci.c                     |    2=20
 drivers/usb/serial/option.c                     |   15 +-
 drivers/usb/serial/usb-serial-simple.c          |    3=20
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    5=20
 fs/f2fs/checkpoint.c                            |    9 -
 fs/pstore/ram.c                                 |   29 +++-
 fs/ubifs/super.c                                |    3=20
 include/linux/hugetlb.h                         |   14 +
 include/linux/mm.h                              |    6=20
 kernel/events/core.c                            |    6=20
 mm/huge_memory.c                                |    2=20
 mm/hugetlb.c                                    |   37 ++++-
 mm/migrate.c                                    |    3=20
 mm/rmap.c                                       |   42 +++++
 mm/vmstat.c                                     |    3=20
 net/mac80211/cfg.c                              |    2=20
 net/mac80211/iface.c                            |    3=20
 net/rds/ib.h                                    |    2=20
 net/rds/ib_cm.c                                 |    2=20
 net/rds/ib_recv.c                               |   10 -
 net/tipc/netlink_compat.c                       |    2=20
 net/tipc/socket.c                               |   17 +-
 net/tipc/socket.h                               |    1=20
 tools/testing/selftests/x86/test_vdso.c         |  172 +++++++++++++++++++=
+++++
 53 files changed, 562 insertions(+), 114 deletions(-)

Alexandre Belloni (1):
      clocksource/drivers/timer-atmel-pit: Properly handle error cases

Andy Lutomirski (4):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      selftests/x86: Add clock_gettime() tests to test_vdso
      x86/vdso: Only enable vDSO retpolines when enabled and supported
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Chao Yu (1):
      f2fs: fix invalid memory access

Christophe Leroy (1):
      powerpc/lib: fix book3s/32 boot failure due to code patching

Chunfeng Yun (1):
      usb: xhci-mtk: resume USB3 roothub first

Cong Wang (2):
      tipc: call start and done ops directly in __tipc_nl_compat_dumpit()
      ucma: fix a use-after-free in ucma_resolve_ip()

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Dmitry Safonov (1):
      tty: Drop tty->count on tty_reopen() failure

Felix Fietkau (2):
      mac80211: allocate TXQs for active monitor interfaces
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Greg Kroah-Hartman (1):
      Linux 4.18.14

Guenter Roeck (1):
      of: unittest: Disable interrupt node tests for old world MAC systems

Ilya Dryomov (1):
      blk-mq: I/O and timer unplugs are inverted in blktrace

Jan Beulich (1):
      xen-netback: fix input validation in xenvif_set_hash_mapping()

Jann Horn (2):
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly
      drm: fix use-after-free read in drm_mode_create_lease_ioctl()

Jason Ekstrand (1):
      drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set

Joe Thornber (1):
      dm cache metadata: ignore hints array being too small during resize

Johan Hovold (2):
      USB: serial: simple: add Motorola Tetra MTP6550 id
      USB: serial: option: add two-endpoints device-id flag

Ka-Cheong Poon (1):
      rds: rds_ib_recv_alloc_cache() should call alloc_percpu_gfp() instead

Kees Cook (1):
      pstore/ram: Fix failure-path memory leak in ramoops_init

Kirill A. Shutemov (1):
      mm, thp: fix mlocking THP page with migration enabled

Kristian Evensen (1):
      USB: serial: option: improve Quectel EP06 detection

Marek Szyprowski (1):
      mmc: slot-gpio: Fix debounce time to use miliseconds again

Mathias Nyman (1):
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Michael Neuling (1):
      powerpc: Avoid code patching freed init sections

Mike Kravetz (1):
      mm: migration: fix migration of huge PMD shared pages

Mike Snitzer (2):
      dm mpath: fix attached_handler_name leak and dangling hw_handler_name=
 pointer
      dm cache: fix resize crash if user doesn't reload cache table

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

Reinette Chatre (1):
      perf/core: Add sanity check to deal with pinned event failure

Rex Zhu (1):
      drm/amdgpu: Fix vce work queue was not cancelled when suspend

Richard Weinberger (1):
      ubifs: Check for name being NULL while mounting

Romain Izard (1):
      usb: cdc_acm: Do not leak URB buffers

Sean Christopherson (2):
      KVM: x86: fix L1TF's MMIO GFN calculation
      KVM: VMX: check for existence of secondary exec controls before acces=
sing

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Tony Lindgren (1):
      mmc: core: Fix debounce time to use microseconds

Vineet Gupta (1):
      ARC: clone syscall to setp r25 as thread pointer

Zhi Chen (1):
      ath10k: fix scan crash due to incorrect length calculation


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvBtEEACgkQONu9yGCS
aT70aA//TpEU/IZjqWQ1vuY9DBcef6bH0Xuw52p9JEF5dUz0lLpjMODtlsPZQtp4
yvFwgCBTT1+Dw+8VUzkUzUebZTaQRbx2PVJn8cXZLx/ZqFIP2mT5J0ttdszxrZlw
qDOuYre3r2eIcV4K7wK/yHUIA6TxsB8AhnRZcA+bKbwCehzWqhHHm0rhs1KDuY2v
IZZnsqNgCSANL50fLj2OMfLsRN/Yz/ImNEBGgNAjEbuumiE32tcv2mnzRpqfFn/V
dhIaeUgfuRHZe6IpGLAUM5Dt1vhxG1C/h2TFRws8bB9xKW+OZ+xFWIFhQManc/7t
UZOEWL5jKGelIWGHzszyQSZIm2DNv17pBxEMSO+YlmYofqS6LMIjvCThcYIX6r6b
0TvXFUghInxs9LBKBJFtcvmQT+/U0maGpZeaiTqgmMTeHj2BZKHtvy4boZZ6pMrb
pSDNR5eE+5N3cHBgX3BE0h8O6Zl/fLAds65PwCnEIEan0SR94PXOfwDVdRFgo7x4
EXFedBr4b4Ue7Cf/QezLjA09C7ftPI1J3e7BpmPOSRnBM996/Begzy3h3rtv+eef
OKN+xgOAkCRM23evMQVeofQU/1eRUYUC8SjlSScrq4G+2933KwmlOvEYkaWBNKTy
edGlLqy7kYPzyXxPxCAK/Fmdh2314ZdFh2dHJbNY6jJuvcGjJD4=
=mo1v
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
