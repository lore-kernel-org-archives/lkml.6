Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7F8208B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7F8208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeHXPnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:43:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHXPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:43:05 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9754EBA2;
        Fri, 24 Aug 2018 12:08:41 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:08:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.5
Message-ID: <20180824120838.GA26093@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.5 kernel.

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

 Makefile                               |    2 -
 arch/parisc/include/asm/spinlock.h     |    8 +------
 arch/parisc/kernel/syscall.S           |   24 ++++++++++-----------
 arch/powerpc/kernel/security.c         |   27 +++++++++++++++---------
 arch/x86/include/asm/processor.h       |    1=20
 arch/x86/include/asm/set_memory.h      |    1=20
 arch/x86/mm/init.c                     |   37 ++++++++++++++++++++++++++++=
++---
 arch/x86/mm/init_64.c                  |    8 +------
 arch/x86/mm/pageattr.c                 |   13 +++++++++++
 drivers/edac/edac_mc.c                 |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |    3 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c       |    9 +++++++-
 drivers/i2c/busses/i2c-imx.c           |    8 +++----
 drivers/i2c/i2c-core-acpi.c            |   11 +++++++--
 drivers/pci/controller/pci-aardvark.c  |    1=20
 drivers/pci/hotplug/pci_hotplug_core.c |    9 ++++++++
 drivers/pci/hotplug/pciehp.h           |    1=20
 drivers/pci/hotplug/pciehp_core.c      |    7 ++++++
 drivers/pci/hotplug/pciehp_hpc.c       |   18 ++++------------
 drivers/pci/pci-acpi.c                 |    6 +----
 drivers/pci/pci.c                      |   28 ++++++++++++++++++++++++
 drivers/pci/probe.c                    |    4 +++
 drivers/tty/pty.c                      |    2 -
 fs/ext4/mballoc.c                      |    4 ++-
 fs/reiserfs/xattr.c                    |    4 ++-
 mm/page_alloc.c                        |   16 ++++++++++++--
 26 files changed, 184 insertions(+), 69 deletions(-)

Christian K=F6nig (1):
      PCI: Restore resized BAR state on resume

Dave Hansen (4):
      mm: Allow non-direct-map arguments to free_reserved_area()
      x86/mm/init: Pass unconverted symbol addresses to free_init_pages()
      x86/mm/init: Add helper for freeing kernel image pages
      x86/mm/init: Remove freed kernel image areas from alias mapping

Esben Haabendal (1):
      i2c: imx: Fix race condition in dma read

Greg Kroah-Hartman (1):
      Linux 4.18.5

Gustavo A. R. Silva (2):
      drm/i915/kvmgt: Fix potential Spectre v1
      drm/amdgpu/pm: Fix potential Spectre v1

Hans de Goede (1):
      i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes

Jann Horn (1):
      reiserfs: fix broken xattr handling (heap corruption, bad retval)

Jeremy Cline (1):
      ext4: fix spectre gadget in ext4_mb_regular_allocator()

John David Anglin (2):
      parisc: Remove unnecessary barriers from spinlock.h
      parisc: Remove ordered stores from syscall.S

Lukas Wunner (3):
      PCI: hotplug: Don't leak pci_slot on registration failure
      PCI: pciehp: Fix use-after-free on unplug
      PCI: pciehp: Fix unprotected list iteration in IRQ handler

Matthijs van Duin (1):
      pty: fix O_CLOEXEC for TIOCGPTPEER

Michael Ellerman (1):
      powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2

Myron Stowe (1):
      PCI: Skip MPS logic for Virtual Functions (VFs)

Rafael J. Wysocki (1):
      PCI / ACPI / PM: Resume all bridges on suspend-to-RAM

Takashi Iwai (1):
      EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]

Zachary Zhang (1):
      PCI: aardvark: Size bridges before resources allocation


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt/9UIACgkQONu9yGCS
aT6Lbg/8DKAG+8NIg+28PcXSXwjI+pMKMD677guw8EonBZi482hzHX0dKlF06DGr
YAw5tk+Zk8hsesnXhVi7xl6lNfP1EKiHpTCXl+yAcWjo5d8WThNHAaih8xrC/I0+
3E2Tk+xNr1opBsY/neVf+ZWBucjih8xZd8Ow9WRV+Q8McdsdXO63OCP9ClXfit5X
HVOYB5FTeld3y7kj4T7m88BBwmnLLStXNkdyj7jvLO9KUhgeas2ZJirl/A6kTYFN
eURjnt/n5YjAXi3CWSClMDgJ6FDYZIcKMblxQlsHNMoaZPuGz7b+p4TxIPZ3sd0V
dMcKwg7o4G1RvqsHK5jjS7K7o5Um+zppbHKs2O8+ZRi9xKpxI+wEwHaOHKlu1IU4
xVICJR6jRaCQR1EDOueOABl5MOerVVlKKCHA2zDPIDR7GwaPPhFU9wZUxZT/IsR0
+jU7W2vdfAKsYblU4X+YPrQtGXvebjNDIAqmu5gxy0H5Sh1x54zuP1u7OJwcDmp7
zK2Wvmm+nLKjWs7f6rAnnNd+R/EYBxYznTQULE8jWAjPu2RoW4/1KtnoGxAdnhzn
r1pKdT637RkUcmoD66Izka+6aWOLsvbObMu+xTctho36s7dtOTDeKS9+Ho5rfEXS
oYEyZx7K0oXZl+Fa9LUacuRq5cgw4L8DwiUe1fpeLYn0itcGdAw=
=wBle
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
