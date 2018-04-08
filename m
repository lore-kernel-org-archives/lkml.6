Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451319-1523200128-2-2484982324903041142
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
    1523200127; b=WIUTGPxQpGzkjiVzbrLkJpJcuwDofF5rxQGGaSoxbaMMUkskJA
    q9ycfc1vRd3fyfte7wdd2FMIc0uR7EgTAmirqsMaA1hS5/J0tS8c6sRUb9Rve9PR
    78+15OMo1rGKgxrX97L+5x3YhMgpgdaYvGjfJ8ze3tGg27//dntQ1Vrh+sm2BcEn
    Zl1syJSqnrP1bRj1rDIs5b2draedpDnFBlgfvBhuo/kNRHYIzDIzWdMzcBi4gMxO
    X8Msliv9BZ+3588dBW2ifZnqGtkZkCfq/VhLrDTjA6mupbGlBL3sxiq256CQmdML
    D8LVR5101oAnjFKtufSUE0UwTx/m5Pjy781Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523200127;
    bh=NUbXa/3yUlC0dftg/yIhLw936wQtWJZxmHENR+HWU6Y=; b=Ns1eekgkrQze
    fMoDtNsZvRs9R3YYR97m1IHweRlR5tY1vukjV03hg0sQjT9QdBSl9j9Jc61WNbn0
    rUnXtYdO5r/LAifJHLYHRsi0mAk5TdGoxhoiF3Ewqsw4C+I5mlmRRt913uKr/Czy
    EW30IHA+JJOzmo6aWtjH0xGBWpLqfHQE9i7LNtzyH+PZMFweGtQb5y/Chqnuhb/c
    +nFTomf2QYJFcNjcLplmluladTXt/mH894Ad4zuInCGzzCJxMfg6bxAyZQFKllPo
    PahZITE9fwgRg35ZuTsup3mRGpMbSF8CBxMiNyBcC8ObPTgD2ymJEkElib5dX7ap
    oN4bjvqgGw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJFi0VnB4GBbbkRXOngqw21w7RCkg7OIWEUKwJSjjOsMsgOFbMP38JJUsXNrjibT2kSrSqGUHU8hm05EFdjT/WyKuijE8AuMd7LLIATu/8pD7dRUUtT8
    pAlqW1vWGefKyjnSYFLQpTa6TNJzHjia57fkbSX5xlcxmKC9HFRM+49wsMXVfGerBmjsNt386UvqpFe6T56EM4gWQsgOUpjoKC2lSyKqHKFfvsPsIC0of7sI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=qZdH_PlXkI6c9sr2Dg0A:9 a=LayIltW-ULVADNM8:21 a=y89Zo5z5ImDWfH2d:21
    a=CjuIK1q_8ugA:10 a=IHVdBvm_DJz6d7jcrXgA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeDHPIq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:08:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeDHPIp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:08:45 -0400
Date: Sun, 8 Apr 2018 17:08:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.93
Message-ID: <20180408150840.GA16019@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.93 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt |    9=20
 Makefile                                                     |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                          |    2=20
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi              |    1=20
 arch/arm/boot/dts/am57xx-idk-common.dtsi                     |    1=20
 arch/arm/boot/dts/dra7-evm.dts                               |    2=20
 arch/arm/boot/dts/omap3-n900.dts                             |    4=20
 arch/arm/vfp/vfpmodule.c                                     |    2=20
 arch/arm64/Kconfig                                           |   12=20
 arch/arm64/include/asm/assembler.h                           |    3=20
 arch/arm64/include/asm/cpucaps.h                             |    3=20
 arch/arm64/include/asm/cputype.h                             |    3=20
 arch/arm64/include/asm/fixmap.h                              |    6=20
 arch/arm64/include/asm/memory.h                              |    6=20
 arch/arm64/include/asm/mmu.h                                 |   11=20
 arch/arm64/include/asm/mmu_context.h                         |    7=20
 arch/arm64/include/asm/pgtable-hwdef.h                       |    1=20
 arch/arm64/include/asm/pgtable-prot.h                        |   35 +
 arch/arm64/include/asm/pgtable.h                             |    1=20
 arch/arm64/include/asm/proc-fns.h                            |    6=20
 arch/arm64/include/asm/sysreg.h                              |    1=20
 arch/arm64/include/asm/tlbflush.h                            |   16=20
 arch/arm64/kernel/asm-offsets.c                              |    6=20
 arch/arm64/kernel/cpu-reset.S                                |    2=20
 arch/arm64/kernel/cpufeature.c                               |  135 ++++++
 arch/arm64/kernel/entry.S                                    |  188 ++++++=
++-
 arch/arm64/kernel/head.S                                     |    2=20
 arch/arm64/kernel/process.c                                  |   12=20
 arch/arm64/kernel/sleep.S                                    |    2=20
 arch/arm64/kernel/vmlinux.lds.S                              |   22 +
 arch/arm64/mm/context.c                                      |   25 -
 arch/arm64/mm/mmu.c                                          |   31 +
 arch/arm64/mm/proc.S                                         |  216 ++++++=
++++-
 arch/frv/include/asm/timex.h                                 |    6=20
 arch/powerpc/kernel/exceptions-64s.S                         |    2=20
 arch/powerpc/kernel/irq.c                                    |    8=20
 arch/x86/crypto/cast5_avx_glue.c                             |    3=20
 arch/x86/kernel/kprobes/core.c                               |    9=20
 block/bio.c                                                  |    4=20
 block/partitions/msdos.c                                     |    4=20
 crypto/ahash.c                                               |    7=20
 drivers/block/mtip32xx/mtip32xx.c                            |   36 -
 drivers/hid/hid-sony.c                                       |   45 --
 drivers/infiniband/core/addr.c                               |   16=20
 drivers/infiniband/core/ucma.c                               |   61 +--
 drivers/input/mouse/alps.c                                   |   24 +
 drivers/input/mousedev.c                                     |   62 +--
 drivers/input/serio/i8042-x86ia64io.h                        |   24 +
 drivers/md/dm-ioctl.c                                        |    4=20
 drivers/md/raid10.c                                          |    1=20
 drivers/media/usb/usbtv/usbtv-core.c                         |    2=20
 drivers/misc/mei/main.c                                      |    1=20
 drivers/mtd/chips/jedec_probe.c                              |    2=20
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c             |   50 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c           |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c            |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c            |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c             |    4=20
 drivers/net/phy/mdio-xgene.c                                 |   50 +-
 drivers/net/phy/mdio-xgene.h                                 |    4=20
 drivers/parport/parport_pc.c                                 |    4=20
 drivers/pci/probe.c                                          |    2=20
 drivers/pci/setup-res.c                                      |    2=20
 drivers/scsi/virtio_scsi.c                                   |    1=20
 drivers/spi/Kconfig                                          |    1=20
 drivers/spi/spi-davinci.c                                    |    2=20
 drivers/staging/comedi/drivers/ni_mio_common.c               |    2=20
 drivers/tty/vt/vt.c                                          |    6=20
 drivers/usb/dwc2/hcd.c                                       |    7=20
 drivers/usb/gadget/udc/core.c                                |    4=20
 drivers/usb/serial/cp210x.c                                  |    1=20
 drivers/usb/serial/ftdi_sio.c                                |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                            |    9=20
 fs/btrfs/tree-log.c                                          |    2=20
 fs/ceph/file.c                                               |    9=20
 fs/compat_ioctl.c                                            |    2=20
 include/linux/cpumask.h                                      |   10=20
 include/linux/init.h                                         |    3=20
 include/linux/jiffies.h                                      |   13=20
 include/linux/llist.h                                        |   21 -
 include/linux/netfilter/x_tables.h                           |    2=20
 include/rdma/ib_addr.h                                       |    2=20
 include/uapi/linux/pci_regs.h                                |    2=20
 init/main.c                                                  |    7=20
 ipc/shm.c                                                    |   12=20
 kernel/events/hw_breakpoint.c                                |   30 -
 kernel/irq/manage.c                                          |    2=20
 kernel/kprobes.c                                             |    2=20
 kernel/module.c                                              |   20 -
 mm/vmscan.c                                                  |   13=20
 net/bluetooth/smp.c                                          |    8=20
 net/bridge/netfilter/ebt_among.c                             |   34 +
 net/ipv4/netfilter/nf_nat_h323.c                             |   57 +-
 net/ipv6/ip6_vti.c                                           |   20 -
 net/mac80211/ibss.c                                          |    4=20
 net/mac80211/rate.c                                          |    6=20
 net/netfilter/nf_conntrack_netlink.c                         |    7=20
 net/netfilter/x_tables.c                                     |   30 +
 net/netfilter/xt_hashlimit.c                                 |   11=20
 net/netfilter/xt_recent.c                                    |    6=20
 net/wireless/nl80211.c                                       |    2=20
 net/wireless/util.c                                          |    6=20
 net/xfrm/xfrm_ipcomp.c                                       |    2=20
 net/xfrm/xfrm_state.c                                        |    5=20
 net/xfrm/xfrm_user.c                                         |   21 -
 security/selinux/hooks.c                                     |   16=20
 security/selinux/ss/services.c                               |    2=20
 sound/core/oss/pcm_oss.c                                     |    4=20
 sound/core/pcm_native.c                                      |    2=20
 sound/usb/quirks.c                                           |    1=20
 110 files changed, 1204 insertions(+), 445 deletions(-)

AKASHI Takahiro (1):
      module: extend 'rodata=3Doff' boot cmdline parameter to module mappin=
gs

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port car=
d.

Alexander Potapenko (1):
      llist: clang: introduce member_address_is_nonnull()

Arnd Bergmann (1):
      xgene_enet: remove bogus forward declarations

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (1):
      mei: remove dev_err message on an unsupported ioctl

Dan Carpenter (1):
      ALSA: pcm: potential uninitialized return values

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Eric Biggers (1):
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short=
 one

Fabio Estevam (1):
      ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]

Florian Westphal (3):
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: bridge: ebt_among: add more missing match size checks
      netfilter: x_tables: add and use xt_check_proc_name

Frank Mori Hess (1):
      staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Frank Praznik (1):
      HID: sony: Use LED_CORE_SUSPENDRESUME

Greg Hackmann (1):
      net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Greg Kroah-Hartman (7):
      Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"
      Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"
      Revert "spi: bcm-qspi: shut up warning about cfi header inclusion"
      Revert "mtip32xx: use runtime tag to initialize command header"
      Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
      spi: davinci: fix up dma_mapping_error() incorrect patch
      Linux 4.9.93

Guoqing Jiang (1):
      md/raid10: reset the 'first' at the end of loop

Herbert Xu (1):
      crypto: ahash - Fix early termination in hash walk

Jayachandran C (2):
      arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
      arm64: Turn on KPTI only on CPUs that need it

Johan Hovold (1):
      USB: serial: cp210x: add ELDAT Easywave RX09 id

John Stultz (1):
      usb: dwc2: Improve gadget state disconnection handling

Keerthy (4):
      Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override prop=
erty definition
      ARM: dts: dra7: Add power hold and power controller properties to pal=
mas
      ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
      ARM: dts: am57xx-idk-common: Add overide powerhold property

Leon Romanovsky (5):
      RDMA/ucma: Check AF family prior resolving address
      RDMA/ucma: Fix use-after-free access in ucma_close
      RDMA/ucma: Ensure that CM_ID exists prior to access it
      RDMA/ucma: Check that device is connected prior to access it
      RDMA/ucma: Check that device exists prior to accessing it

Linus Torvalds (1):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Marc Zyngier (2):
      arm64: Allow checking of a CPU-local erratum
      arm64: Force KPTI to be disabled on Cavium ThunderX

Mark Charlebois (1):
      fs: compat: Remove warning from COMPATIBLE_IOCTL

Mark Rutland (1):
      arm64: factor out entry stack manipulation

Masaki Ota (1):
      Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude =
7370

Masami Hiramatsu (1):
      kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Matthias Brugger (1):
      net: hns: Fix ethtool private flags

Matthias Kaehlcke (14):
      PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
      dm ioctl: remove double parentheses
      genirq: Use cpumask_available() for check of cpumask variable
      cpumask: Add helper cpumask_available()
      selinux: Remove unnecessary check of array base in selinux_set_mappin=
g()
      jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_=
in_smp
      frv: declare jiffies to be located in the .data section
      nl80211: Fix enum type of variable in nl80211_put_sta_rate()
      cfg80211: Fix array-bounds warning in fragment copy
      netfilter: ctnetlink: Make some parameters integer to avoid enum mism=
atch
      mac80211: Fix clang warning about constant operand in logical operati=
on
      mac80211: ibss: Fix channel type enum in ieee80211_sta_join_ibss()
      btrfs: Remove extra parentheses from condition in copy_items()
      selinux: Remove redundant check for unknown labeling behavior

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

Nick Desaulniers (4):
      Input: mousedev - fix implicit conversion warning
      netfilter: nf_nat_h323: fix logical-not-parentheses warning
      arm64: avoid overflow in VA_START and PAGE_OFFSET
      mm/vmscan.c: fix unsequenced modification and access warning

Nobutaka Okabe (1):
      ALSA: usb-audio: Add native DSD support for TEAC UD-301

Oliver Neukum (1):
      media: usbtv: prevent double free in error case

Ondrej Zary (1):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Paolo Bonzini (1):
      scsi: virtio_scsi: always read VPD pages for multiqueue too

Richard Narron (1):
      partitions/msdos: Unable to mount UFS 44bsd partitions

Roland Dreier (1):
      RDMA/ucma: Introduce safer rdma_addr_size() variants

Stefan Agner (1):
      usb: gadget: remove redundant self assignment

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Steffen Klassert (1):
      xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit sys=
tems

Suzuki K Poulose (1):
      arm64: capabilities: Handle duplicate entries for a capability

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

Will Deacon (20):
      arm64: mm: Use non-global mappings for kernel space
      arm64: mm: Move ASID from TTBR0 to TTBR1
      arm64: mm: Allocate ASIDs in pairs
      arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
      arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
      arm64: entry: Add exception trampoline page for exceptions from EL0
      arm64: mm: Map entry trampoline into trampoline and kernel page tables
      arm64: entry: Explicitly pass exception level to kernel_ventry macro
      arm64: entry: Hook up entry trampoline to exception vectors
      arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tas=
ks
      arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
      arm64: kaslr: Put kernel vectors address in separate data page
      arm64: use RET instruction for exiting the trampoline
      arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
      arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
      arm64: Take into account ID_AA64PFR0_EL1.CSV3
      arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0=
()
      arm64: kpti: Add ->enable callback to remap swapper using nG mappings
      arm64: entry: Reword comment about post_ttbr_update_workaround
      arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives

Yan, Zheng (1):
      ceph: only dirty ITER_IOVEC pages for direct read


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrKMHcACgkQONu9yGCS
aT4zlw/+MwNIgf/8uECpM9Oa1nEdSCEruOb3k2rZjLRdmCnmri57Hdb31E0bJTFN
m7wi+H5Gyg5rXFCLm6IcE1XqVCtINaojpKGOMAZUqCITKlUAjUT+gaFZct7ohSRB
MFGV8rG9ZmxU9KYBujjKcbJRiuwJnXkY9YM0NB5vFCiqJ4zsuYVddwCJhg2Bz1Fj
DespZPpb+2vaxOl03XtiLYGhgytFzP43Gjwt1bmCYG9rg3M4xWqTuBDzyU83JKMO
RQwADV5hnPG+1PIbbSl/Quj+GVBxWpser8XJv4yPMJNAFebRHxyE08wy0j34d89c
2DEZ1cUqaaDjR1WOvHbR/oGsNKxMnIH3WAb6m2Nv/wN+1zSneJ1QtBFNaGVd5C+d
L8FrZ4uBnk2eqqldzlBexsoUksmnzhcCNzLhucFYaFiaboMzgL99uKbZLTFJsqKr
p7fFe+EzJMo4OIHfL/H5sHLUfypJZjyZDrsE67AdeZs2mk67rrLjzQi6ae248ci/
FTk6KpKfbiCb//Aznrcu5thFrHYHYfiiVhLYlRnMJ0wQiaOqTZ/wPxj6fCEVqwtd
dB8bx68lddD2BkQWbKf3Fv148WaYl9v6DQWLSEk0Zn+aFcrGrjj3RXd9qNGHQVDw
DVfXY0LWr6iN6Q0CvSmeC4snbyEHAVHH91at37YOP/qRlj3L7pI=
=sOaQ
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
