Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A15206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222722;
	bh=Zs9K1YslK/bdDu1tkjt4eBv0EWqxhjEhpIVRjHO59ws=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oAHB2ZM86w0o4BAumnxxrbraUnsxGPK3rnCZTiZw98+PyvNgry4dCqGKoQs4t81h5
	 6sgFY7GTxpACAS+8jno/8KkefvipqUk9pJuFZGpmDeMps3XJvTsDMrnZDZcPNSzhKR
	 KDl1PZHwGqFjq3Y1NPs6K/ySfSkdxzWiq6FL5hpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392606AbfBOJZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbfBOJZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:25:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED34C2192C;
        Fri, 15 Feb 2019 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222708;
        bh=Zs9K1YslK/bdDu1tkjt4eBv0EWqxhjEhpIVRjHO59ws=;
        h=Date:From:To:Cc:Subject:From;
        b=FhPTv/9s7MnTdhGHxH4u7/02OZuzsgseMHl4gXmveRTzob+Bg2etqelIwcFCJGHAl
         gTgKAl9uqQF2+XmFKRQRmXar/3L636kQkrAXDQwg5w8DL1PrCOR8P6w2GH7suv2d52
         bwXW3gf9NdDqQ9ysm/GA0+iVP+JzdX+SGuUO6xvQ=
Date:   Fri, 15 Feb 2019 10:24:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.9
Message-ID: <20190215092442.GA1463@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.9 kernel.

Stay away from this, use 4.20.10 instead.

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
 arch/arm/boot/dts/da850.dtsi                      |    2=20
 arch/arm/mach-iop32x/n2100.c                      |    3=20
 arch/arm/mach-tango/pm.c                          |    6 -
 arch/arm/mach-tango/pm.h                          |    7 +
 arch/arm/mach-tango/setup.c                       |    2=20
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts          |    8 -
 arch/mips/kernel/mips-cm.c                        |    2=20
 arch/mips/loongson64/common/reset.c               |    7 +
 arch/mips/pci/pci-octeon.c                        |   10 +-
 arch/mips/vdso/Makefile                           |    5 -
 arch/powerpc/include/asm/book3s/64/pgtable.h      |   22 +---
 arch/powerpc/mm/pgtable-book3s64.c                |   22 ++++
 arch/powerpc/platforms/pseries/papr_scm.c         |    5 -
 drivers/ata/libata-core.c                         |    1=20
 drivers/firmware/arm_scmi/bus.c                   |    9 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |    1=20
 drivers/gpu/drm/drm_modes.c                       |    2=20
 drivers/gpu/drm/i915/intel_ddi.c                  |    2=20
 drivers/gpu/drm/i915/intel_display.c              |   51 +++++++++-
 drivers/gpu/drm/rockchip/rockchip_rgb.c           |   11 --
 drivers/gpu/drm/rockchip/rockchip_rgb.h           |   11 --
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c               |    9 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c           |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |    4=20
 drivers/iio/adc/axp288_adc.c                      |   76 ++++++++++++---
 drivers/iio/adc/ti-ads8688.c                      |    3=20
 drivers/iio/chemical/atlas-ph-sensor.c            |    7 -
 drivers/misc/mei/hw-me-regs.h                     |    2=20
 drivers/misc/mei/pci-me.c                         |    2=20
 drivers/misc/mic/vop/vop_main.c                   |    4=20
 drivers/misc/vexpress-syscfg.c                    |    2=20
 drivers/mtd/mtdpart.c                             |    4=20
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c         |   13 +-
 drivers/mtd/nand/spi/core.c                       |   46 ++++-----
 drivers/pinctrl/intel/pinctrl-cherryview.c        |    8 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c         |    2=20
 fs/debugfs/inode.c                                |    7 +
 fs/ext4/fsync.c                                   |   13 --
 kernel/signal.c                                   |   63 ++++++++++++-
 kernel/trace/trace_uprobe.c                       |    9 +
 net/batman-adv/hard-interface.c                   |    5 -
 net/batman-adv/soft-interface.c                   |    2=20
 net/ceph/messenger.c                              |    5 -
 net/mac80211/tx.c                                 |   12 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c             |  105 +++++++++++++++++=
+++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c          |    9 -
 net/wireless/ap.c                                 |    2=20
 net/wireless/core.h                               |    2=20
 net/wireless/sme.c                                |    2=20
 net/xfrm/xfrm_policy.c                            |    5 -
 net/xfrm/xfrm_user.c                              |   13 +-
 samples/mei/mei-amt-version.c                     |    2=20
 tools/iio/iio_generic_buffer.c                    |    2=20
 54 files changed, 460 insertions(+), 173 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Andreas Ziegler (2):
      tracing/uprobes: Fix output for multiple string arguments
      tracing: uprobes: Fix typo in pr_fmt string

Aneesh Kumar K.V (1):
      powerpc/radix: Fix kernel crash with mremap()

Bartosz Golaszewski (1):
      ARM: dts: da850: fix interrupt numbers for clocksource

Benedict Wong (1):
      xfrm: Make set-mark default behavior backward compatible

Boris Brezillon (3):
      mtd: Make sure mtd->erasesize is valid even if the partition is of si=
ze 0
      mtd: spinand: Handle the case where PROGRAM LOAD does not reset the c=
ache
      mtd: spinand: Fix the error/cleanup path in spinand_init()

Chen-Yu Tsai (1):
      pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller

Chuck Lever (1):
      svcrdma: Remove max_sge check at connect time

Dan Carpenter (1):
      misc: vexpress: Off by one in vexpress_syscfg_exec()

Dan Murphy (1):
      iio: ti-ads8688: Update buffer allocation for timestamps

Dmitry Torokhov (1):
      pinctrl: cherryview: fix Strago DMI workaround

Eric W. Biederman (3):
      signal: Always attempt to allocate siginfo for SIGSTOP
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals

Felix Fietkau (1):
      mac80211: ensure that mgmt tx skbs have tailroom for encryption

Florian Westphal (1):
      xfrm: refine validation of template and selector families

Greg Kroah-Hartman (2):
      debugfs: fix debugfs_rename parameter checking
      Linux 4.20.9

Gustavo A. R. Silva (1):
      drm/amd/powerplay: Fix missing break in switch

Hans de Goede (2):
      libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD
      iio: adc: axp288: Fix TS-pin handling

Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Johannes Berg (1):
      cfg80211: call disconnect_wk when AP stops

Lucas De Marchi (1):
      drm/i915: always return something on DDI clock selection

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Martin Kelly (1):
      tools: iio: iio_generic_buffer: make num_loops signed

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsi=
us

Oliver O'Halloran (1):
      powerpc/papr_scm: Use the correct bind address

Paul Burton (3):
      MIPS: Use lower case for addresses in nexys4ddr.dts
      MIPS: VDSO: Use same -m%-float cflag as the kernel proper
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping

Sandy Huang (1):
      drm/rockchip: rgb: update SPDX license identifier

Sudeep Holla (1):
      firmware: arm_scmi: provide the mandatory device release callback

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Theodore Ts'o (1):
      Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"

Thomas Hellstrom (3):
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Fix an uninitialized fence handle value
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Tomas Winkler (2):
      mei: me: add ice lake point device id.
      samples: mei: use /dev/mei0 instead of /dev/mei

Ville Syrj=E4l=E4 (1):
      drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BI=
OSen

Vincent Whitchurch (1):
      mic: vop: Fix use-after-free on remove

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Yifeng Li (1):
      mips: loongson64: remove unreachable(), fix loongson_poweroff().


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhVoACgkQONu9yGCS
aT7EHA//Y9fhQbtc8yXeVX7UP2nlr3H4pc13TlH58u4J1YKb9rLLRRKtt1gAoHYh
JY8cGMfjrqt9sbDXOf4ieEFUBqRJHlUX4nfkpUYCRfR6aoasYjBbbuOhEO2lxlwG
lL0HVq5xvK3ePUykgNm+0pOGLWMweUfYfGuIw4DCaDHSLQ/uJ/OwXlHb7LLd2aYh
msnLba1xaSZVrj80bU8qVy3IYcmcvlnS0dZJsE8P1ZIGbpkJFmMIEqY0pqUHxOTV
7PhuIze55cZbybHdiNocZH5KrJjTC+s2RPczCLLhfnycuR+0LB8vAGp+99TMU3Qq
JX15kBHieBfK2dovBS0fm51sbJ/tDD+IJQ2vU4tCcMc8Te6F+o2OM7FUPnSAteVm
qUUhLzRQqswhKes3DhTjXtYL2FXCU+wggnmGiAcJztAxviNeTwu974G3e/uwWSuy
eeshmI2LGjuFPtvlt4aZpfJhMsksAjntVzAjZpHbSYzaki3FQYI8J8sJSSH7h04q
EQG8hBcmI91IsemOrvOGwZuOA7gm/2uoW7yK/60q7WsDi6AU1aB7Vud0v8gNwWOv
9CPwuKjuVuOfsXorHIQ6xbpfl0rKyn9M32Y7o5MZDMdGnvrS+5VmeBOdQEoBkljB
WZd1sZgfPm6apD8Il5KmlCwrovpTHgPq2+5aJt6XOX4O1P7C6UM=
=6Xgq
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
