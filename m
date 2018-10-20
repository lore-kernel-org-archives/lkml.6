Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BED7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7221523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoxPgYEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F7221523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJTUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 16:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJTUPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 16:15:16 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7BC21523;
        Sat, 20 Oct 2018 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540037101;
        bh=SzfoMLxRe+5vAO4RpxxXHXe2CBTs/2B5p3YS0Q5VvgA=;
        h=Date:From:To:Cc:Subject:From;
        b=XoxPgYEV5+BiEFf5hKnGBrOcDGimtVmqmpW+jSWOpk1NClwOOXLPPuASBmXwB36ma
         TJLnjaaZNZX0lFRIZeukASnQmZVwNEh5AG1ENF3+Yep98lmx9kK0S9dlOeSFwR92gW
         ++IaXWphepCnQEZLfgzaikKFP4fHzXEwe6REK0O0=
Date:   Sat, 20 Oct 2018 14:04:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.78
Message-ID: <20181020120457.GA14222@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.78 kernel.

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

 Makefile                                 |    2=20
 arch/arc/Makefile                        |   24 -----
 arch/powerpc/include/asm/code-patching.h |    1=20
 arch/powerpc/kernel/tm.S                 |   20 +++-
 arch/powerpc/lib/code-patching.c         |    4=20
 arch/powerpc/lib/feature-fixups.c        |    8 -
 drivers/clocksource/timer-fttmr010.c     |   18 ++--
 drivers/clocksource/timer-ti-32k.c       |    3=20
 drivers/gpu/drm/arm/malidp_drv.c         |    1=20
 drivers/gpu/drm/i915/i915_drv.c          |   10 --
 drivers/gpu/drm/i915/i915_drv.h          |    9 --
 drivers/gpu/drm/i915/intel_ddi.c         |   13 ++
 drivers/gpu/drm/i915/intel_display.c     |   21 ++++
 drivers/gpu/drm/i915/intel_drv.h         |    3=20
 drivers/gpu/drm/i915/intel_lvds.c        |  136 --------------------------=
-----
 drivers/hid/hid-core.c                   |    3=20
 drivers/hwtracing/intel_th/pci.c         |    5 +
 drivers/i2c/busses/i2c-rcar.c            |   54 +++++++++++-
 drivers/infiniband/hw/hfi1/chip.c        |    7 +
 drivers/infiniband/hw/hfi1/pio.c         |   42 +++++++--
 drivers/infiniband/hw/hfi1/pio.h         |    2=20
 drivers/input/keyboard/atakbd.c          |   74 ++++++----------
 drivers/iommu/amd_iommu.c                |    6 +
 drivers/media/usb/dvb-usb-v2/af9035.c    |    6 -
 drivers/net/ethernet/ibm/emac/core.c     |   15 ++-
 drivers/net/ethernet/mellanox/mlx4/eq.c  |    3=20
 drivers/net/ethernet/renesas/ravb.h      |    5 +
 drivers/net/ethernet/renesas/ravb_main.c |   11 +-
 drivers/net/ethernet/renesas/ravb_ptp.c  |    2=20
 drivers/pci/dwc/pcie-designware.c        |    8 -
 drivers/pci/dwc/pcie-designware.h        |    3=20
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |    5 -
 drivers/scsi/ipr.c                       |  106 +++++++++++++-----------
 drivers/scsi/ipr.h                       |    1=20
 drivers/scsi/sd.c                        |    3=20
 drivers/staging/ccree/ssi_buffer_mgr.c   |    3=20
 fs/namespace.c                           |    7 -
 include/linux/huge_mm.h                  |    2=20
 kernel/memremap.c                        |   18 +++-
 mm/huge_memory.c                         |   10 --
 mm/mremap.c                              |   30 ++----
 net/batman-adv/bat_v_elp.c               |   10 +-
 net/batman-adv/bridge_loop_avoidance.c   |   10 +-
 net/batman-adv/gateway_client.c          |   11 ++
 net/batman-adv/network-coding.c          |   27 +++---
 net/batman-adv/soft-interface.c          |   25 ++++-
 net/batman-adv/sysfs.c                   |   30 ++++--
 net/batman-adv/translation-table.c       |    6 -
 net/batman-adv/tvlv.c                    |    8 +
 49 files changed, 437 insertions(+), 394 deletions(-)

Alexander Shishkin (1):
      intel_th: pci: Add Ice Lake PCH support

Alexandru Gheorghe (1):
      drm: mali-dp: Call drm_crtc_vblank_reset on device init

Alexey Brodkin (2):
      ARC: build: Get rid of toolchain check
      ARC: build: Don't set CROSS_COMPILE in arch's Makefile

Andreas Schwab (1):
      Input: atakbd - fix Atari keymap

Arindam Nath (1):
      iommu/amd: Return devid as alias for ACPI HID devices

Christian Lamparter (1):
      net: emac: fix fixed-link setup for the RTL8363SB switch

Christophe Leroy (1):
      powerpc/lib/feature-fixups: use raw_patch_instruction()

Clint Taylor (1):
      drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Dave Jiang (1):
      mm: disallow mappings that conflict for devm_memremap_pages()

Gilad Ben-Yossef (1):
      staging: ccree: check DMA pool buf !NULL before free

Greg Kroah-Hartman (2):
      Revert "vfs: fix freeze protection in mnt_want_write_file() for overl=
ayfs"
      Linux 4.14.78

Jisheng Zhang (1):
      PCI: dwc: Fix scheduling while atomic issues

Johannes Thumshirn (1):
      scsi: sd: don't crash the host on invalid commands

Jozef Balga (1):
      media: af9035: prevent buffer overflow on write

Kazuya Mizuguchi (1):
      ravb: do not write 1 to reserved bits

Keerthy (1):
      clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for=
 non-am43 SoCs

Laura Abbott (2):
      scsi: ibmvscsis: Fix a stringop-overflow warning
      scsi: ibmvscsis: Ensure partition name is properly NUL terminated

Linus Torvalds (1):
      mremap: properly flush TLB before releasing the page

Marek Lindner (2):
      batman-adv: fix backbone_gw refcount on queue_work() failure
      batman-adv: fix hardif_neigh refcount on queue_work() failure

Michael J. Ruhl (1):
      IB/hfi1: Fix destroy_qp hang after a link down

Michael Neuling (2):
      powerpc/tm: Fix userspace r13 corruption
      powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Natanael Copa (1):
      HID: quirks: fix support for Apple Magic Keyboards

Nathan Chancellor (1):
      net/mlx4: Use cpumask_available for eq->affinity_mask

Sven Eckelmann (8):
      batman-adv: Avoid probe ELP information leak
      batman-adv: Fix segfault when writing to throughput_override
      batman-adv: Fix segfault when writing to sysfs elp_interval
      batman-adv: Prevent duplicated gateway_node entry
      batman-adv: Prevent duplicated nc_node entry
      batman-adv: Prevent duplicated softif_vlan entry
      batman-adv: Prevent duplicated global TT entry
      batman-adv: Prevent duplicated tvlv handler

Tao Ren (1):
      clocksource/drivers/fttmr010: Fix set_next_event handler

Ville Syrj=E4l=E4 (1):
      drm/i915: Nuke the LVDS lid notifier

Wen Xiong (1):
      scsi: ipr: System hung while dlpar adding primary ipr adapter back

Wolfram Sang (1):
      i2c: rcar: handle RXDMA HW behaviour on Gen3


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvLGekACgkQONu9yGCS
aT7P9w/+Oi6kxdh6gsyFTCdHklwztLIMskCcSyDtgYBeO9/b+xuOgFVSxSpyyCcX
HzEWuQ9A3F1AH8gLi55am8gZzYei49BQ9tHgSDl8BE5IWBknwQBineumSyIcvbMB
jx251eEPJSgDke0H9BQ6fRG8cTjjOAMDRK+YKbRNjHdshBrDcubXrqo1r2UFRiWH
aukyZkROsivcIVi/INLFb6jjaQsQF07KaGIEpweCZN3DdQHQKXvYWKJkbKEnmH38
04WchCB8tsStkWi52FiNsAUklsTTfd2QHxy7mCUaECIR/KQ3VmTuZc8cgmVPPk0Y
VmNOKV54DdNf1aYTu7pe0R6LZSJCmuZTCwCvXlZsgQqItAf+ghlfq7LBUOqMGi5d
o4VbuoPxd6fdqmEg4iKUEdISX0MBZBhH84CZy2t9I4qdpaH/mbi9knGc5lb8klU4
B9fuGbdZ1a/ezNOJUxRTrPza7bsdJRGsOeRxyTMWueYjLdb35TgFbHtlgmUdYy6r
sPU2EXsHbotn2BPL/eE5S/06jaDL8sbwcMMW6vsZHpf3MjIiNO1wbAUI1ZL8lBwP
Nu+JeemRnC6pZ930rZj2Mct70Dlc7tyz9uiz+1BriUW+C8oOeBx6NyqAXs2WLUCf
MIHR3SKZhFpmco9+C6k1+lQiRGcoDtWUw837DIsgDhBq7bn0miI=
=MUYW
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
