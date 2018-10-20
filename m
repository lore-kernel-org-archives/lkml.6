Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE449C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907EB2145D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQmhJR+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907EB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJTUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 16:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbeJTUPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 16:15:48 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FC42145D;
        Sat, 20 Oct 2018 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540037132;
        bh=dyvIQeiroVXSONPvWmvavW/CCW6Cs4Agit3YpFWHn/w=;
        h=Date:From:To:Cc:Subject:From;
        b=PQmhJR+bMSWrNkj4yBEvDgHQANiZR/Yx2dC29Jcju+X5q5jwnB5jWQu/8z1MrLwsq
         xecVgRr5pQ81qR51Q7JGRfTEkmKrffg3eU2Jrvplh8BibIMS2f/cCdCZOP8RFj3AWB
         oFXDkjRKJPQYC0YC648yZCGnkB1YN7dLvz067raY=
Date:   Sat, 20 Oct 2018 14:05:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.16
Message-ID: <20181020120528.GA14314@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.16 kernel.

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

 Makefile                                     |    2=20
 arch/arc/Makefile                            |   24 ------
 arch/powerpc/kernel/tm.S                     |   20 ++++-
 arch/powerpc/mm/numa.c                       |    4 -
 arch/riscv/include/asm/asm-prototypes.h      |    7 +
 arch/x86/boot/compressed/mem_encrypt.S       |   19 ----
 drivers/clocksource/timer-fttmr010.c         |   18 ++--
 drivers/clocksource/timer-ti-32k.c           |    3=20
 drivers/gpu/drm/arm/malidp_drv.c             |    1=20
 drivers/hwtracing/intel_th/pci.c             |    5 +
 drivers/infiniband/core/uverbs_cmd.c         |   68 +++++++++++------
 drivers/infiniband/hw/bnxt_re/main.c         |   93 +++++++++--------------
 drivers/input/keyboard/atakbd.c              |   74 +++++++-----------
 drivers/iommu/amd_iommu.c                    |    6 +
 drivers/iommu/rockchip-iommu.c               |    6 +
 drivers/media/usb/dvb-usb-v2/af9035.c        |    6 +
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h  |    1=20
 drivers/net/ethernet/ibm/emac/core.c         |   15 ++-
 drivers/net/ethernet/mellanox/mlx4/eq.c      |    3=20
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c   |    9 ++
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h   |    1=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c    |   15 +++
 drivers/net/ethernet/qlogic/qed/qed_hsi.h    |    4 +
 drivers/net/ethernet/renesas/ravb.h          |    5 +
 drivers/net/ethernet/renesas/ravb_main.c     |   11 +-
 drivers/net/ethernet/renesas/ravb_ptp.c      |    2=20
 drivers/pci/controller/dwc/pcie-designware.c |    8 +-
 drivers/pci/controller/dwc/pcie-designware.h |    3=20
 drivers/pinctrl/pinctrl-amd.c                |   33 +++++---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c     |    5 -
 drivers/scsi/ipr.c                           |  106 +++++++++++++++-------=
-----
 drivers/scsi/ipr.h                           |    1=20
 drivers/scsi/lpfc/lpfc_attr.c                |   15 ++-
 drivers/scsi/lpfc/lpfc_debugfs.c             |   10 +-
 drivers/scsi/lpfc/lpfc_nvme.c                |   11 ++
 drivers/scsi/sd.c                            |    3=20
 drivers/soundwire/stream.c                   |   23 ++++-
 drivers/spi/spi-gpio.c                       |    4 -
 fs/namespace.c                               |    7 -
 include/linux/huge_mm.h                      |    2=20
 kernel/bpf/sockmap.c                         |   91 ++++++++++++++++++-----
 mm/huge_memory.c                             |   10 +-
 mm/mremap.c                                  |   30 +++----
 net/batman-adv/bat_v_elp.c                   |   10 +-
 net/batman-adv/bridge_loop_avoidance.c       |   10 ++
 net/batman-adv/gateway_client.c              |   11 ++
 net/batman-adv/network-coding.c              |   27 +++---
 net/batman-adv/soft-interface.c              |   25 ++++--
 net/batman-adv/sysfs.c                       |   30 +++++--
 net/batman-adv/translation-table.c           |    6 +
 net/batman-adv/tvlv.c                        |    8 +-
 net/smc/af_smc.c                             |    7 +
 net/smc/smc_clc.c                            |   14 +--
 tools/testing/selftests/bpf/test_maps.c      |   10 +-
 tools/testing/selftests/net/pmtu.sh          |    4 -
 55 files changed, 562 insertions(+), 384 deletions(-)

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

Daniel Kurtz (1):
      pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type

Greg Kroah-Hartman (2):
      Revert "vfs: fix freeze protection in mnt_want_write_file() for overl=
ayfs"
      Linux 4.18.16

Heiko Stuebner (1):
      iommu/rockchip: Free irqs in shutdown handler

James Cowgill (1):
      RISC-V: include linux/ftrace.h in asm-prototypes.h

James Smart (1):
      scsi: lpfc: Synchronize access to remoteport via rport

Jisheng Zhang (1):
      PCI: dwc: Fix scheduling while atomic issues

Johannes Thumshirn (1):
      scsi: sd: don't crash the host on invalid commands

John Fastabend (3):
      bpf: sockmap only allow ESTABLISHED sock state
      bpf: sockmap, fix transition through disconnect without close
      bpf: test_maps, only support ESTABLISHED socks

Jozef Balga (1):
      media: af9035: prevent buffer overflow on write

Kairui Song (1):
      x86/boot: Fix kexec booting failure in the SEV bit detection code

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

Linus Walleij (1):
      spi: gpio: Fix copy-and-paste error

Majd Dibbiny (1):
      RDMA/uverbs: Fix validity check for modify QP

Marek Lindner (2):
      batman-adv: fix backbone_gw refcount on queue_work() failure
      batman-adv: fix hardif_neigh refcount on queue_work() failure

Michael Neuling (2):
      powerpc/tm: Fix userspace r13 corruption
      powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Nathan Chancellor (1):
      net/mlx4: Use cpumask_available for eq->affinity_mask

Sabrina Dubroca (1):
      selftests: pmtu: properly redirect stderr to /dev/null

Sanyog Kale (1):
      soundwire: Fix acquiring bus lock twice during master release

Selvin Xavier (1):
      RDMA/bnxt_re: Fix system crash during RDMA resource initialization

Shreyas NC (2):
      soundwire: Fix duplicate stream state assignment
      soundwire: Fix incorrect exit after configuring stream

Srikar Dronamraju (1):
      powerpc/numa: Use associativity if VPHN hcall is successful

Steve Wise (1):
      cxgb4: fix abort_req_rss6 struct

Sudarsana Reddy Kalluru (2):
      qed: Fix populating the invalid stag value in multi function mode.
      qed: Do not add VLAN 0 tag to untagged frames in multi-function mode.

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

Ursula Braun (1):
      net/smc: fix non-blocking connect problem

Wen Xiong (1):
      scsi: ipr: System hung while dlpar adding primary ipr adapter back

YueHaibing (1):
      net/smc: fix sizeof to int comparison


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvLGggACgkQONu9yGCS
aT6DUBAAo5ihXw8t8a+/Wme6ihFjXzFy5K+ecRA5bWD9ADjeNSGypgAhcj4YeR26
UMxqNZo+qXD912S013YpmduiahDWlb9Hf2ZpgqeqVjh9vCg4jqil7kJKx5aGmW13
M2ceQWy197//3udCaAcXbkBTgQ28jovUJCuxyyFg79Bht3JGeYRbsFYX+SzgdeVh
4W1ZxVTRhaYPxpGj71CJSiIRlQ+acRu2QYLhRRxGDNUAG5TgbXv/5Cwf4FHIdlDi
aLuW7/FkRwFt1f36sd+e0AxyLlZpMDEmayv2fAC+78HyxbblGlJvrdKEtrtRAqkX
W3PlOMgsErXsIQMGqYPFogyr2i2wPGi1BkBbOcbk+ImXjJqNw+M3Xlj9+EY7CjVs
50tjQhFhRTIiIQp6KceGsyu/HQSc4cBV6kI96j6s0zIGdyxKwXfQpFkfyNccjmnZ
P0FrOFrtQDqJNCI81a6RDWDRLf7V6d3NnX50SKzT6KlPbC8r/PiVhrVHOPcKcrj1
RuMqSkzWuYAtdw4xSScvFGvq6cjK8ULkPp3fuH2ftldD+CHdzOFU9o2YSGAwEYMz
9n5U7S4mRjRjyerq5GFOFT26GAZz6E8cOKfMHzGIokz2XUNImM2uvV07XPSa/zpK
256R0WE3xYx3b2Ts6vSEq9WeUAU4U6IVryN6nqeyQY/EANtC29I=
=em6G
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
