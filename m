Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451319-1523200196-2-10620408979410874456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523200196; b=vn9N3OjuLhu54GKq2EMjspnxsCg4N9+P8GG3ccD1wY225v66I/
    Z98XdmUjIKUJ3WbUD7LsDHt4zW0OVTUM3LM5DEyjPfAUf61NH6FfMlWdmXlPrdtT
    iZvFEbATrzQFW+rKAlOyCI3IFK14adqiH0BaC+BpV0lubHTOCRUV1R/Crq9RpQuM
    nQorzNUEBgpoRaavTD7gUwbbGYXbBvJb4JWgiqRr+cMM3ttrDSirzXbc9hwI2lNO
    CLVeWDoMVT6v7m/u7/mraEL2wodeEgv7/fMHZo/gmfgx69n6nwCVdyGe39Aw3KVe
    zj1h8rDfWl9tAWtjp2mPy0wbgbbJ/Unr19vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523200196;
    bh=/mFYdiFew9m8V2et5q/QxRKASezV5euFcoh0JgL52Kw=; b=omPSq36mienU
    I5z++9dHmbbopm3DsQ5tL6fgc4WhIM63vp324FufjGUMKKZcXPt+rAj4bYlGtTU+
    dxtntybr0ZKW7wMqCWoZEJflz79BpO63P9A31KWyKNwRYaVvH0esNqumTc9BsKZy
    hVWRHAQkAZTgzn9eeHj2wS1haqkIrPycg+3Ih+JY2YSc2t8923aFfXwvpbs8e0cy
    p1qBXr1Su8zxZpCuaqYR+VjMlj0F1974R0imIGRsV87WyC6JWC6/nTtu5gD9BpMs
    j7EXY8+p9lUA6+JctV1oPbUtUEJROUTI0wLanPaT5Rf3Z1nNoUcLan2LJYb4+cYu
    KioQvOG9+A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMM9Ftl4MPvTQWSC+ETcWcWthwfYWnXZakSRaYmHOLWtqPBjLVXiFDhr4v5u2jDZlTCEMT0JFbUREokxHcso+k84/JiVe4XdVGGGDAWCOdykgeWhnAxc
    D7xNwCUQ1OMblHC8T4OjGyCsbG6VHMi1gg8pJUyIdn6+wc6ZbeYIdo/fICF6i9ph4QtMc9k7wP/PTtHL7xAy5HW3ObGQknLggxmXsftY6HVq2BeebV/50sxA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=gaia86k_lr-1IOVnSLEA:9 a=wC-PpJC1oAI8KJDw:21 a=qU-_RKM5gcuY19Gv:21
    a=CjuIK1q_8ugA:10 a=HU7zQE8jnHKcxmIf95AA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeDHPJx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:09:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeDHPJw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:09:52 -0400
Date: Sun, 8 Apr 2018 17:09:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.16
Message-ID: <20180408150947.GA16184@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.16 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/8250.txt  |    1=20
 Makefile                                           |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                |    2=20
 arch/arm/boot/dts/dra76-evm.dts                    |    1=20
 arch/arm/boot/dts/omap3-n900.dts                   |    4=20
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   63 +++++++
 arch/arm/crypto/Makefile                           |    2=20
 arch/arm/plat-omap/include/plat/sram.h             |   11 -
 arch/arm/plat-omap/sram.c                          |   36 ++++
 arch/arm/vfp/vfpmodule.c                           |    2=20
 arch/arm64/crypto/Makefile                         |    2=20
 arch/powerpc/include/asm/book3s/64/mmu.h           |    3=20
 arch/powerpc/include/asm/mmu_context.h             |   18 +-
 arch/powerpc/kernel/exceptions-64s.S               |    2=20
 arch/powerpc/kernel/irq.c                          |    8 +
 arch/powerpc/mm/mmu_context_book3s64.c             |    1=20
 arch/powerpc/mm/tlb-radix.c                        |   50 +++++-
 arch/x86/crypto/cast5_avx_glue.c                   |    3=20
 arch/x86/include/asm/hw_irq.h                      |    1=20
 arch/x86/kernel/idt.c                              |    3=20
 arch/x86/platform/uv/tlb_uv.c                      |    2=20
 block/bio.c                                        |    4=20
 block/partitions/msdos.c                           |    4=20
 crypto/ahash.c                                     |    7=20
 crypto/lrw.c                                       |    2=20
 crypto/testmgr.h                                   |    6=20
 drivers/base/arch_topology.c                       |   12 -
 drivers/char/mem.c                                 |    6=20
 drivers/cpufreq/cpufreq.c                          |    6=20
 drivers/crypto/caam/ctrl.c                         |    3=20
 drivers/crypto/ccp/ccp-crypto-rsa.c                |    7=20
 drivers/crypto/inside-secure/safexcel.c            |    2=20
 drivers/crypto/talitos.c                           |  168 ++++++++--------=
-----
 drivers/gpu/drm/i915/intel_ddi.c                   |   12 -
 drivers/i2c/busses/i2c-stm32f7.c                   |    5=20
 drivers/infiniband/core/addr.c                     |   25 +++
 drivers/infiniband/core/ucma.c                     |   61 ++++---
 drivers/input/mouse/alps.c                         |   24 ++-
 drivers/input/serio/i8042-x86ia64io.h              |   24 +++
 drivers/media/usb/usbtv/usbtv-core.c               |    2=20
 drivers/misc/mei/main.c                            |    1=20
 drivers/mtd/chips/jedec_probe.c                    |    2=20
 drivers/mtd/nand/atmel/pmecc.c                     |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |    4=20
 drivers/parport/parport_pc.c                       |    4=20
 drivers/phy/qualcomm/phy-qcom-ufs.c                |    5=20
 drivers/staging/comedi/drivers/ni_mio_common.c     |    2=20
 drivers/tty/serial/8250/8250_of.c                  |    1=20
 drivers/tty/serial/8250/8250_port.c                |   33 ++++
 drivers/tty/vt/vt.c                                |    6=20
 drivers/usb/serial/cp210x.c                        |    1=20
 drivers/usb/serial/ftdi_sio.c                      |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                  |    9 +
 fs/btrfs/inode.c                                   |   37 ++++
 fs/ceph/file.c                                     |    9 -
 include/linux/bitmap.h                             |   22 ++
 include/linux/netfilter/x_tables.h                 |    2=20
 include/rdma/ib_addr.h                             |    2=20
 include/uapi/linux/serial_core.h                   |    3=20
 ipc/shm.c                                          |   12 +
 kernel/events/hw_breakpoint.c                      |   30 ---
 mm/percpu-km.c                                     |    8 -
 mm/percpu-vm.c                                     |   18 +-
 mm/percpu.c                                        |   45 +++--
 net/bluetooth/smp.c                                |    8 -
 net/bridge/netfilter/ebt_among.c                   |   34 ++++
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |   14 +
 net/ipv6/ip6_vti.c                                 |   20 --
 net/ipv6/route.c                                   |   13 -
 net/l2tp/l2tp_core.c                               |   38 ++--
 net/l2tp/l2tp_core.h                               |    3=20
 net/netfilter/x_tables.c                           |   37 ++++
 net/netfilter/xt_hashlimit.c                       |   16 +-
 net/netfilter/xt_recent.c                          |    6=20
 net/xfrm/xfrm_ipcomp.c                             |    2=20
 net/xfrm/xfrm_state.c                              |    5=20
 net/xfrm/xfrm_user.c                               |   21 +-
 sound/core/oss/pcm_oss.c                           |    4=20
 sound/core/pcm_native.c                            |    2=20
 sound/usb/quirks.c                                 |    1=20
 83 files changed, 730 insertions(+), 357 deletions(-)

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port car=
d.

Andrew Banman (1):
      x86/platform/uv/BAU: Add APIC idt entry

Arnd Bergmann (1):
      phy: qcom-ufs: add MODULE_LICENSE tag

Benjamin Herrenschmidt (2):
      powerpc/mm: Add tracking of the number of coprocessors using a context
      powerpc/mm: Workaround Nest MMU bug with TLB invalidations

Boris Brezillon (1):
      mtd: nand: atmel: Fix get_sectorsize() function

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (1):
      mei: remove dev_err message on an unsupported ioctl

Conor McLoughlin (1):
      crypto: testmgr - Fix incorrect values in PKCS#1 test vector

Dan Carpenter (1):
      ALSA: pcm: potential uninitialized return values

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Dennis Zhou (1):
      percpu: add __GFP_NORETRY semantics to the percpu balancing path

Dhinakaran Pandiyan (1):
      drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.

Eric Biggers (1):
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short=
 one

Eric Dumazet (1):
      ipv6: fix possible deadlock in rt6_age_examine_exception()

Fabio Estevam (1):
      ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]

Florian Westphal (3):
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: bridge: ebt_among: add more missing match size checks
      netfilter: x_tables: add and use xt_check_proc_name

Frank Mori Hess (1):
      staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Gaku Inami (1):
      Revert "base: arch_topology: fix section mismatch build warnings"

Greg Hackmann (1):
      net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Greg Kroah-Hartman (5):
      Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"
      Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"
      Revert "cpufreq: Fix governor module removal race"
      Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
      Linux 4.15.16

Gregory CLEMENT (1):
      crypto: inside-secure - fix clock management

Herbert Xu (2):
      crypto: lrw - Free rctx->ext with kzfree
      crypto: ahash - Fix early termination in hash walk

Jason Gunthorpe (1):
      RDMA/rdma_cm: Fix use after free race with process_one_req

Joel Stanley (1):
      serial: 8250: Add Nuvoton NPCM UART

Johan Hovold (1):
      USB: serial: cp210x: add ELDAT Easywave RX09 id

Keerthy (1):
      ARM: dts: DRA76-EVM: Set powerhold property for tps65917

Kees Cook (1):
      /dev/mem: Avoid overwriting "err" in read_mem()

LEROY Christophe (2):
      crypto: talitos - don't persistently map req_ctx->hw_context and req_=
ctx->buf
      crypto: talitos - fix IPsec cipher in length

Leon Romanovsky (5):
      RDMA/ucma: Check AF family prior resolving address
      RDMA/ucma: Fix use-after-free access in ucma_close
      RDMA/ucma: Ensure that CM_ID exists prior to access it
      RDMA/ucma: Check that device is connected prior to access it
      RDMA/ucma: Check that device exists prior to accessing it

Leonard Crestez (1):
      crypto: arm,arm64 - Fix random regeneration of S_shipped

Linus Torvalds (1):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()

Liu Bo (1):
      Btrfs: fix unexpected cow in run_delalloc_nocow

Maciej S. Szmigiero (1):
      crypto: ccp - return an actual key size from RSA max_size callback

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Masaki Ota (1):
      Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude =
7370

Matthias Brugger (1):
      net: hns: Fix ethtool private flags

Michal Hocko (1):
      netfilter: x_tables: make allocation less aggressive

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards

Mike Kravetz (1):
      ipc/shm.c: add split function to shm_vm_ops

Mikulas Patocka (1):
      Fix slab name "biovec-(1<<(21-12))"

Nicholas Piggin (2):
      powerpc/64s: Fix lost pending interrupt due to race causing lost upda=
te to irq_happened
      powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolati=
le GPRs

Nobutaka Okabe (1):
      ALSA: usb-audio: Add native DSD support for TEAC UD-301

Oliver Neukum (1):
      media: usbtv: prevent double free in error case

Omar Sandoval (1):
      bitmap: fix memset optimization on big-endian systems

Ondrej Zary (1):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Paolo Abeni (2):
      l2tp: fix races with ipv4-mapped ipv6 addresses
      netfilter: drop template ct when conntrack is skipped.

Philipp Rossak (2):
      ARM: dts: sun6i: a31s: bpi-m2: improve pmic properties
      ARM: dts: sun6i: a31s: bpi-m2: add missing regulators

Pierre-Yves MORDRET (1):
      i2c: i2c-stm32f7: fix no check on returned setup

Richard Narron (1):
      partitions/msdos: Unable to mount UFS 44bsd partitions

Roland Dreier (1):
      RDMA/ucma: Introduce safer rdma_addr_size() variants

Rui Miguel Silva (1):
      crypto: caam - Fix null dereference at error path

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Steffen Klassert (1):
      xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit sys=
tems

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

Tony Lindgren (1):
      ARM: OMAP: Fix SRAM W+X mapping

Yan, Zheng (1):
      ceph: only dirty ITER_IOVEC pages for direct read


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrKMLoACgkQONu9yGCS
aT43qg//ZIVmt9DioKqPAj5OZUHRqQRlGPxDZZlHvDiseGyZnVby4xNy4/ouDHbt
kYiS4AmKxE2Qu8ECmdxKz1NNhV5DGonTzrIfdK/gD8m7u2TB2fdXN0n0vuXWoPPc
+XBy/6RtaPCQTki8Yux8F6G2r9flGZHhjCrE7UxChqisFy1Skk67/0PZJum6PftP
h+xmUCr2Uoosj3uWIT8rJhojKuoQ+ISJ+u7KrnBzevRgClgMCaJCL7Vd/SGZWIWQ
1M/+lIJFBVmRpHu9VSiDP4k3Z+xIkCRrMULFUX4sjPuPDyTZGwZ9TvhFaPMwzRMy
moTlnEwubjp6rVn0Z/ZI4lacXDV+bb6NZo2C8YS950OTdvT4+OiCbyX6YGDa8rPd
ErGUec25JMXydrNQxJajsw1uag/Lf5Xz4BHS7H7q5VkMTEHPTMRpClWOUf52YSsz
ffteF5oBZc7nYcZhgfn2YSfZnLlYVxUTLi12+IX1jj2ZtqOuY57h9xI6/sBcnUT1
bBuv51PS9I32BX2nNxwgFuCEdpzgn7OuwdhFVXgrFcXcW7hfLKDDAHE1kEoO6JMz
zBb9zcrxijS1U5ZNaQBnamZBE49apf/HNbg8M/BiDRS5cP76cut2Z5ZsFLEkujDr
mZsTGIa7zkjFkwwcXCHXdgwTpTq8BGT3eWOio186uhaFt5oMrxQ=
=ncI+
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
