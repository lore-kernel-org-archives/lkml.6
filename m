Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1540903-1523024293-2-1488197001910236797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523024292; b=c9MLbCvmB1c3S0ASKh6eX7MPJKn89SMkunIrooHVaKKevhrVMh
    psHSH+AeqVgBNwr/VqxgCK3UCsgMfUPkX6TbClBA8QY9QCY5EeMOQcN6tkmmgsHt
    ChG7Q80qs5E5+on8zVCvCoiiElVs/diGxjNT5DzIMFY6XWTWUjYm96mScqUa5utX
    Wtv6dNcXvei8Kt8v9j7ymMuJZJECECKwJ6B5bwOZmFMWPwB45D1hQ8yTh8O5kw7S
    3zia/mPh5Vh0X9795H9HtaEhe9zzqXB8ZXFquq+CaaDf5vGlvhYiBhrG1IIsRuaq
    e1vIS77WMI0CkNa2RLtJr+VBOobn1R/gW9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523024292; bh=9Eu6MLBrgYwlGCHDFWuFEUt5cIfbuL
    3y6WCMAfiZ2ws=; b=KvXPeNoEiuGQVr8THZZjlnvqUDuDba/YItLkyzU7f/pQtm
    +ZTsB10oPLaMINUEqGqr7zJYUehN3WgHLddojabxzTBnzVUlPTSU6TC0zisOMlJ/
    SetWpsiGxAvuguqQS4UXsHZwCEE1h5rIux0OjLnAA4TW0lBYhWgF0EQVaL7oAToN
    aXy5ir8vPLb46VJooI9Bs2HXh2fsQnWcDe6v2djNl+H1sktcOqDjHAwX56/q0ULN
    PmIRHu43okVx6ooQ6VyiQJNUSUYVybCOS0bRdXfiIHdky84uIgVhRAe40wSbyU5z
    Ob+bAdnhMj0i3c9Xl5CNAmjM+hi3ql3Gq0xTEfyw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPO3SWDjXeDhqx4p6xZ2/Z+73OGO7PwNvmOMLtCyMAqnCJgfk90N52rAfLZbBMkCoBRYPPhbX7psqsC9wpZxbv66knQhoSWy1qLb9VdOZVqHsZtxQY6h
    qOvIOdRIIArD/1OdJ0ta2s7ZDPDhEVLUfRYdjr7xruGHwCmGYVX79SyyOmMjC60SXsUH3DNZaO8QbwQqCNfTZmaY5DL4Xf2bfhSGC7mN1jqIwIBxWgydQIzT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=V-N4SJbYLSYA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
    a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=AgaioDkCAAAA:8 a=7ZN4cI0QAAAA:8
    a=CEwII1yZAAAA:8 a=yC-0_ovQAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
    a=8AirrxEcAAAA:8 a=KKAkSRfTAAAA:8 a=FNyBlpCuAAAA:8 a=QyXUC8HyAAAA:8
    a=P-IC7800AAAA:8 a=ttLlOQO2AAAA:8 a=iox4zFpeAAAA:8 a=DfNHnWVPAAAA:8
    a=xLcVsCfpAAAA:8 a=FOH2dFAWAAAA:8 a=WTJdmG3rAAAA:8 a=CbDCq_QkAAAA:8
    a=8b9GpE9nAAAA:8 a=Z4Rwk6OoAAAA:8 a=MvuuwTCpAAAA:8 a=2KMo9-giAAAA:8
    a=K_7WMIZsrxvZQdtnFtgA:9 a=uCuXT9bP7FSnfPKT:21 a=j7jiw1OZWRzAgeU1:21
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=xmb-EsYY8bH0VWELuYED:22 a=eNS--96rZ24oWIaEtn_1:22 a=Dl0WHwQvj8hGZljrFLtM:22
    a=4LuAaoAPjBjBTe8K2uIj:22 a=QsnFDINu91a9xkgZirup:22 a=ST-jHhOKWsTCqRlWije3:22
    a=cvBusfyB2V15izCimMoJ:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=d3PnA9EDa4IxuAV0gXij:22
    a=1BJeXTq6bvZE9X1NrNaC:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=rjTVMONInIDnV1a_A2c_:22
    a=4-ZGFxpmiTxXQSWJmrgh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755084AbeDFNjB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:39:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755920AbeDFNi6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:38:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/67] 4.14.33-stable review
Date: Fri,  6 Apr 2018 15:23:30 +0200
Message-Id: <20180406084341.225558262@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.33-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.33-rc1
X-KernelTest-Deadline: 2018-04-08T08:43+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.33 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr  8 08:43:05 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.33-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.33-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ip6_vti: adjust vti mtu according to mtu of lower device"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "cpufreq: Fix governor module removal race"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"

Mikulas Patocka <mpatocka@redhat.com>
    Fix slab name "biovec-(1<<(21-12))"

Matthias Brugger <matthias.bgg@gmail.com>
    net: hns: Fix ethtool private flags

Keerthy <j-keerthy@ti.com>
    ARM: dts: DRA76-EVM: Set powerhold property for tps65917

Mike Frysinger <vapier@chromium.org>
    vt: change SGR 21 to follow the standards

Ondrej Zary <linux@rainbow-software.org>
    Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Masaki Ota <masaki.ota@jp.alps.com>
    Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude 7370

Gaku Inami <gaku.inami.xh@renesas.com>
    Revert "base: arch_topology: fix section mismatch build warnings"

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected cow in run_delalloc_nocow

Eric Biggers <ebiggers@google.com>
    crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one

Leonard Crestez <leonard.crestez@nxp.com>
    crypto: arm,arm64 - Fix random regeneration of S_shipped

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    crypto: ccp - return an actual key size from RSA max_size callback

Rui Miguel Silva <rui.silva@linaro.org>
    crypto: caam - Fix null dereference at error path

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: ahash - Fix early termination in hash walk

Conor McLoughlin <conor.mcloughlin@intel.com>
    crypto: testmgr - Fix incorrect values in PKCS#1 test vector

Gregory CLEMENT <gregory.clement@bootlin.com>
    crypto: inside-secure - fix clock management

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: lrw - Free rctx->ext with kzfree

Alexander Gerasiov <gq@redlab-i.ru>
    parport_pc: Add support for WCH CH382L PCI-E single parallel port card.

Oliver Neukum <oneukum@suse.com>
    media: usbtv: prevent double free in error case

Kees Cook <keescook@chromium.org>
    /dev/mem: Avoid overwriting "err" in read_mem()

Colin Ian King <colin.king@canonical.com>
    mei: remove dev_err message on an unsupported ioctl

Joel Stanley <joel@jms.id.au>
    serial: 8250: Add Nuvoton NPCM UART

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add ELDAT Easywave RX09 id

Clemens Werther <clemens.werther@gmail.com>
    USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Major Hayden <major@mhtx.net>
    USB: serial: ftdi_sio: add RT Systems VX-8 cable

Omar Sandoval <osandov@fb.com>
    bitmap: fix memset optimization on big-endian systems

John Stultz <john.stultz@linaro.org>
    usb: dwc2: Improve gadget state disconnection handling

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix missing encryption refresh on Security Request

Arnd Bergmann <arnd@arndb.de>
    phy: qcom-ufs: add MODULE_LICENSE tag

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: add and use xt_check_proc_name

Paolo Abeni <pabeni@redhat.com>
    netfilter: drop template ct when conntrack is skipped.

Paolo Abeni <pabeni@redhat.com>
    l2tp: fix races with ipv4-mapped ipv6 addresses

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add more missing match size checks

Michal Hocko <mhocko@kernel.org>
    netfilter: x_tables: make allocation less aggressive

Dennis Zhou <dennisszhou@gmail.com>
    percpu: add __GFP_NORETRY semantics to the percpu balancing path

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems

Greg Hackmann <ghackmann@google.com>
    net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Introduce safer rdma_addr_size() variants

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that device exists prior to accessing it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that device is connected prior to access it

Jason Gunthorpe <jgg@mellanox.com>
    RDMA/rdma_cm: Fix use after free race with process_one_req

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Ensure that CM_ID exists prior to access it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix use-after-free access in ucma_close

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check AF family prior resolving address

Florian Westphal <fw@strlen.de>
    xfrm_user: uncoditionally validate esn replay attribute struct

Richard Narron <comet.berkeley@gmail.com>
    partitions/msdos: Unable to mount UFS 44bsd partitions

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix lost pending interrupt due to race causing lost update to irq_happened

Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
    i2c: i2c-stm32f7: fix no check on returned setup

Mike Kravetz <mike.kravetz@oracle.com>
    ipc/shm.c: add split function to shm_vm_ops

Yan, Zheng <zyan@redhat.com>
    ceph: only dirty ITER_IOVEC pages for direct read

Linus Torvalds <torvalds@linux-foundation.org>
    perf/hwbp: Simplify the perf-hwbp code, fix documentation

Andrew Banman <abanman@hpe.com>
    x86/platform/uv/BAU: Add APIC idt entry

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: pcm: potential uninitialized return values

Stefan Roese <sr@denx.de>
    ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Nobutaka Okabe <nob77413@gmail.com>
    ALSA: usb-audio: Add native DSD support for TEAC UD-301

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: nand: atmel: Fix get_sectorsize() function

Linus Walleij <linus.walleij@linaro.org>
    mtd: jedec_probe: Fix crash in jedec_read_mfr()

Philipp Rossak <embed3d@gmail.com>
    ARM: dts: sun6i: a31s: bpi-m2: add missing regulators

Philipp Rossak <embed3d@gmail.com>
    ARM: dts: sun6i: a31s: bpi-m2: improve pmic properties

Fabio Estevam <festevam@gmail.com>
    ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]

Tony Lindgren <tony@atomide.com>
    ARM: OMAP: Fix SRAM W+X mapping


-------------

Diffstat:

 Documentation/devicetree/bindings/serial/8250.txt  |  1 +
 Makefile                                           |  4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |  2 +-
 arch/arm/boot/dts/dra76-evm.dts                    |  1 +
 arch/arm/boot/dts/omap3-n900.dts                   |  4 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   | 63 ++++++++++++++++++++--
 arch/arm/crypto/Makefile                           |  2 +
 arch/arm/plat-omap/include/plat/sram.h             | 11 +---
 arch/arm/plat-omap/sram.c                          | 36 ++++++++++++-
 arch/arm/vfp/vfpmodule.c                           |  2 +-
 arch/arm64/crypto/Makefile                         |  2 +
 arch/powerpc/kernel/exceptions-64s.S               |  2 +-
 arch/powerpc/kernel/irq.c                          |  8 +++
 arch/x86/crypto/cast5_avx_glue.c                   |  3 +-
 arch/x86/include/asm/hw_irq.h                      |  1 +
 arch/x86/kernel/idt.c                              |  3 ++
 arch/x86/platform/uv/tlb_uv.c                      |  2 -
 block/bio.c                                        |  4 +-
 block/partitions/msdos.c                           |  4 +-
 crypto/ahash.c                                     |  7 +--
 crypto/lrw.c                                       |  2 +-
 crypto/testmgr.h                                   |  6 +--
 drivers/base/arch_topology.c                       | 12 ++---
 drivers/char/mem.c                                 |  6 +--
 drivers/cpufreq/cpufreq.c                          |  6 ---
 drivers/crypto/caam/ctrl.c                         |  3 --
 drivers/crypto/ccp/ccp-crypto-rsa.c                |  7 ++-
 drivers/crypto/inside-secure/safexcel.c            |  2 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |  5 ++
 drivers/infiniband/core/addr.c                     | 25 +++++++++
 drivers/infiniband/core/ucma.c                     | 61 +++++++++++++--------
 drivers/input/mouse/alps.c                         | 24 +++++++--
 drivers/input/serio/i8042-x86ia64io.h              | 24 +++++++++
 drivers/media/usb/usbtv/usbtv-core.c               |  2 +
 drivers/misc/mei/main.c                            |  1 -
 drivers/mtd/chips/jedec_probe.c                    |  2 +
 drivers/mtd/nand/atmel/pmecc.c                     |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  4 +-
 drivers/parport/parport_pc.c                       |  4 ++
 drivers/phy/qualcomm/phy-qcom-ufs.c                |  5 ++
 drivers/staging/comedi/drivers/ni_mio_common.c     |  2 +
 drivers/tty/serial/8250/8250_of.c                  |  1 +
 drivers/tty/serial/8250/8250_port.c                | 33 ++++++++++++
 drivers/tty/vt/vt.c                                |  6 ++-
 drivers/usb/dwc2/hcd.c                             |  7 ++-
 drivers/usb/serial/cp210x.c                        |  1 +
 drivers/usb/serial/ftdi_sio.c                      |  2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |  9 ++++
 fs/btrfs/inode.c                                   | 37 +++++++++++--
 fs/ceph/file.c                                     |  9 ++--
 include/linux/bitmap.h                             | 22 ++++++--
 include/linux/netfilter/x_tables.h                 |  2 +
 include/rdma/ib_addr.h                             |  2 +
 include/uapi/linux/serial_core.h                   |  3 ++
 ipc/shm.c                                          | 12 +++++
 kernel/events/hw_breakpoint.c                      | 30 +++--------
 mm/percpu-km.c                                     |  8 +--
 mm/percpu-vm.c                                     | 18 ++++---
 mm/percpu.c                                        | 45 ++++++++++------
 net/bluetooth/smp.c                                |  8 ++-
 net/bridge/netfilter/ebt_among.c                   | 34 ++++++++++++
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     | 14 ++++-
 net/ipv6/ip6_vti.c                                 | 20 -------
 net/l2tp/l2tp_core.c                               | 38 +++++++------
 net/l2tp/l2tp_core.h                               |  3 --
 net/netfilter/x_tables.c                           | 37 ++++++++++++-
 net/netfilter/xt_hashlimit.c                       | 16 +++---
 net/netfilter/xt_recent.c                          |  6 +--
 net/xfrm/xfrm_ipcomp.c                             |  2 +-
 net/xfrm/xfrm_state.c                              |  5 ++
 net/xfrm/xfrm_user.c                               | 21 +++-----
 sound/core/oss/pcm_oss.c                           |  4 +-
 sound/core/pcm_native.c                            |  2 +-
 sound/usb/quirks.c                                 |  1 +
 77 files changed, 603 insertions(+), 228 deletions(-)
