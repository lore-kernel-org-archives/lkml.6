Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C47C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26EF20644
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/+p5FXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26EF20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeJMQgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeJMQgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:36:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E5120644;
        Sat, 13 Oct 2018 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539421230;
        bh=xr3JEzYVQf4n+6L3GQTgWbhFEXZWhxlfZIIWyo3KQOU=;
        h=Date:From:To:Cc:Subject:From;
        b=G/+p5FXAELhL3x5Vt42WirufJqvtJf2SQJEYW+6WLccUxkDPdfMy15vaJLU4IeERa
         F9MFv8UBTbQ5E9Hf7vUS/7JSsG6RNhFTRPLU8PD4HgXKcvppvl9jEXpgGSlJ6Qhe9i
         NGnci5Hi5UHtdCbnO3Fj0EO7BjPPHrhxF44MQoyM=
Date:   Sat, 13 Oct 2018 11:00:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.76
Message-ID: <20181013090027.GA31707@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.76 kernel.

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

 Makefile                                        |    2=20
 arch/arc/kernel/process.c                       |   20 ++
 arch/powerpc/include/asm/setup.h                |    1=20
 arch/powerpc/lib/code-patching.c                |   45 +++---
 arch/powerpc/mm/mem.c                           |    2=20
 arch/x86/entry/vdso/Makefile                    |   16 +-
 arch/x86/entry/vdso/vclock_gettime.c            |   26 +--
 arch/x86/kvm/mmu.c                              |   24 ++-
 block/blk-mq.c                                  |    4=20
 drivers/base/power/main.c                       |    5=20
 drivers/clocksource/timer-atmel-pit.c           |   20 +-
 drivers/crypto/chelsio/chcr_algo.c              |   41 +++--
 drivers/crypto/chelsio/chcr_crypto.h            |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c         |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |    4=20
 drivers/gpu/drm/drm_syncobj.c                   |    5=20
 drivers/infiniband/core/ucma.c                  |    2=20
 drivers/md/dm-cache-metadata.c                  |    4=20
 drivers/md/dm-cache-target.c                    |    9 -
 drivers/net/wireless/ath/ath10k/debug.c         |   12 +
 drivers/net/wireless/ath/ath10k/trace.h         |   12 -
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |    8 -
 drivers/net/wireless/ath/ath10k/wmi.c           |    2=20
 drivers/net/xen-netback/hash.c                  |   12 -
 drivers/nvme/host/fc.c                          |    4=20
 drivers/of/unittest.c                           |   26 ++-
 drivers/pci/pci.c                               |   27 ++-
 drivers/tty/tty_io.c                            |   11 +
 drivers/usb/class/cdc-acm.c                     |    6=20
 drivers/usb/host/xhci-mtk.c                     |    4=20
 drivers/usb/host/xhci-pci.c                     |    2=20
 drivers/usb/serial/usb-serial-simple.c          |    3=20
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    5=20
 drivers/virtio/virtio_balloon.c                 |   23 ++-
 fs/f2fs/checkpoint.c                            |    9 -
 fs/ubifs/super.c                                |    3=20
 include/linux/balloon_compaction.h              |   35 ++++
 include/linux/hugetlb.h                         |   14 +
 include/linux/mm.h                              |    6=20
 kernel/events/core.c                            |    6=20
 mm/balloon_compaction.c                         |   28 ++-
 mm/huge_memory.c                                |    2=20
 mm/hugetlb.c                                    |   37 ++++-
 mm/migrate.c                                    |    3=20
 mm/rmap.c                                       |   42 +++++
 mm/vmstat.c                                     |    3=20
 net/mac80211/cfg.c                              |    2=20
 net/rds/ib.h                                    |    2=20
 net/rds/ib_cm.c                                 |    2=20
 net/rds/ib_recv.c                               |   10 -
 tools/perf/builtin-script.c                     |   14 -
 tools/perf/util/annotate.c                      |   17 +-
 tools/perf/util/path.c                          |   14 +
 tools/perf/util/path.h                          |    3=20
 tools/perf/util/setup.py                        |    2=20
 tools/testing/selftests/x86/test_vdso.c         |  172 +++++++++++++++++++=
+++++
 56 files changed, 660 insertions(+), 158 deletions(-)

Alexandre Belloni (1):
      clocksource/drivers/timer-atmel-pit: Properly handle error cases

Andy Lutomirski (4):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      selftests/x86: Add clock_gettime() tests to test_vdso
      x86/vdso: Only enable vDSO retpolines when enabled and supported
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Arnaldo Carvalho de Melo (1):
      perf annotate: Use asprintf when formatting objdump command line

Carl Huang (1):
      ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Chao Yu (1):
      f2fs: fix invalid memory access

Christophe Leroy (2):
      powerpc/lib/code-patching: refactor patch_instruction()
      powerpc/lib: fix book3s/32 boot failure due to code patching

Chunfeng Yun (1):
      usb: xhci-mtk: resume USB3 roothub first

Cong Wang (1):
      ucma: fix a use-after-free in ucma_resolve_ip()

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Dmitry Safonov (1):
      tty: Drop tty->count on tty_reopen() failure

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Greg Kroah-Hartman (1):
      Linux 4.14.76

Guenter Roeck (1):
      of: unittest: Disable interrupt node tests for old world MAC systems

Harsh Jain (1):
      crypto: chelsio - Fix memory corruption in DMA Mapped buffers.

Ilya Dryomov (1):
      blk-mq: I/O and timer unplugs are inverted in blktrace

James Smart (1):
      nvme_fc: fix ctrl create failures racing with workq items

Jan Beulich (1):
      xen-netback: fix input validation in xenvif_set_hash_mapping()

Jan Stancek (1):
      virtio_balloon: fix increment of vb->num_pfns in fill_balloon()

Jann Horn (1):
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly

Jason Ekstrand (1):
      drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set

Jiri Olsa (2):
      perf tools: Fix python extension build for gcc 8
      perf utils: Move is_directory() to path.h

Joe Thornber (1):
      dm cache metadata: ignore hints array being too small during resize

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra MTP6550 id

Ka-Cheong Poon (1):
      rds: rds_ib_recv_alloc_cache() should call alloc_percpu_gfp() instead

Kirill A. Shutemov (1):
      mm, thp: fix mlocking THP page with migration enabled

Mathias Nyman (1):
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Michael Neuling (1):
      powerpc: Avoid code patching freed init sections

Michael S. Tsirkin (1):
      virtio_balloon: fix deadlock on OOM

Mike Kravetz (1):
      mm: migration: fix migration of huge PMD shared pages

Mike Snitzer (1):
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

Sean Christopherson (1):
      KVM: x86: fix L1TF's MMIO GFN calculation

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Vineet Gupta (1):
      ARC: clone syscall to setp r25 as thread pointer

Yu Wang (1):
      ath10k: fix kernel panic issue during pci probe

Zhi Chen (1):
      ath10k: fix scan crash due to incorrect length calculation


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvBtCsACgkQONu9yGCS
aT6ZlA/7B2s8f1bRB2IbPiQ6hcYEpBqjtFsjNl+p1u+NKE5advQMh1rDRLiPAQPP
vSZi1l0rB/MPxmfheyuOa1651Z6mtkF4B/OG0XMuN40Z/o9dCJ81SxMU7W1H3D1v
gleMCWNyL8HEYed2vywXjnOfemku34ewvnySb1+yNiVb6hQc0OziVRnsloNn6Hbs
WMZP9Tju4SBHw0wUNgWaMwYIrnKJaAqRbpENTkcmNx/yXRqsEAYvPVIwGN4UFtXI
QRe2hERajUUhSZrYiFisynKSKqx4nqXbl7ZxLGq6bQMtJp8W8/iPAiSq2kLXIbtL
cg25TycevBS5q23XV8r7g3XNwOB50OXZLBHxRSDIfZHalHKYiZn3lbbtTMpYRafP
bmnOJHj0+S6kDGsqiMEMwa9jZHS71AU0taPQUebqm9Ix6/jdiRTF6xvloNRG56KF
6igaamuqXXkB6qaFQciFSC1HZPO4/7DnVEEHtk8um56+ww7+MRxqPDAWec7ENDBk
/8LNc1aOpFWA0pE7othIGR+U4NeOtKV3mYdAdTFEKoggFcrEo8bArUR9bnroxXSa
qJKs9RM+u8fpcjaWFM5i5Wwv7h5oLy1hp6mQPYsYJa18s5wz0bkWEvx+SfGvdsd3
D62GxF09yUfPyyE1HAsYVK8H45gG3525Jot1wrkR5/fQ3WSLWUo=
=Mnt4
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
