Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451319-1523200111-2-18276235433772597477
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
    1523200110; b=QI+cu+kFqml2RTzglAjJwZyc1FKr6i/l5DXyZoYewDvspy01eC
    oTcF9Icj0jiFuP525J1PHbFF2H02O7Fk45/y6p2lhJ83UEeMtzsIs2QRh2o50Tnz
    +uUrbTSqy9Ir9CKcdah1uzdSIkPx3g3uqKuiZsKOYTgR5TtWJIo3CbR1df4Pxy2H
    gfODgUbFpeeJ9IhbyVXmvtcX/CUD31dEpE//C9r3GraHuuVaJpg/bSH8GLGdCO4X
    k3buZOYCE5cAYiWWlAQN+uj6BGNynaBPlFYuT53k4J8qhEDMWylkEVzWgcu7+UyW
    KjiFWm5eTM9tZYrqgS4Mi1WNibOuhQ+lDcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523200110;
    bh=rmIo2TCmeT1kXaP7LVXqPjHvljXooC/uFqWEELXMDYQ=; b=LsUP/sFzcSLo
    aKHPccnH8uQLnvkM9R5ViEPiMordjtUMQnBgXWodpjfiEm7rGnMmZToYZa8sRM0F
    71Bh76QjKOTVV5heaHMrkKDY2dBOTu8HnMxcym+qU86Lpmlxuz+iSDgxAXJut4/G
    nIiQDwm/JwqxZr+rfehPMF8HYqchw5+FYkIXsQzXQcJ/ef/xI++LsJVo7HP14hlT
    D12AfGNjDue8R+JXVHV4D7szfG7t3s5wzi9CGQedZvvim7pf6Xmf309kpl8chqTc
    pG+gzK/AF9WXjxG5bFKV+4gs5g6Cx5x66AhzBGvL/oJXh566CDvwJNsrhTqEi1E5
    p3BJuLFEbg==
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
X-CM-Envelope: MS4wfBXKGG076DHES9mp2k2Hba7JMnOSqTRgPlhord2ZXHvM01kNRnkiLwCjPgPsnxSMP9aeOWBMd4+3cUoy6cyIKTyUOqOH+PEDYRw+xZ3HUSgX4erw0dBo
    YDD69IapGVfxLjc6O+iY7gDwzPBb0v86Qmr2jSG+h+cJiUh0XVjYxukELmZEQ6kkmkP4gFqqiJBK95GQxhUYQJ6F8jNfh+FVfK8AZNZq6PRu5iL/ERK0VVn+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=4qE4K9tgRJ-icgwf5BgA:9 a=W-of8H4xmzWYghoG:21 a=tWiUbYphw77Q1aOV:21
    a=CjuIK1q_8ugA:10 a=Z5l1U3tTiVtKtUGNFc4A:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeDHPHz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:07:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeDHPHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:07:53 -0400
Date: Sun, 8 Apr 2018 17:07:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.127
Message-ID: <20180408150748.GA15917@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.127 kernel.

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

 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt |    9 +
 Documentation/filesystems/proc.txt                           |   26 ----
 Makefile                                                     |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                          |    2=20
 arch/arm/boot/dts/am57xx-beagle-x15.dts                      |    1=20
 arch/arm/boot/dts/dra7-evm.dts                               |    2=20
 arch/arm/boot/dts/omap3-n900.dts                             |    4=20
 arch/arm64/include/asm/memory.h                              |    6=20
 arch/frv/include/asm/timex.h                                 |    6=20
 arch/x86/crypto/cast5_avx_glue.c                             |    3=20
 arch/x86/kernel/kprobes/core.c                               |    9 +
 block/partitions/msdos.c                                     |    4=20
 crypto/ahash.c                                               |    7 -
 drivers/acpi/pci_irq.c                                       |    3=20
 drivers/block/mtip32xx/mtip32xx.c                            |   36 +----
 drivers/cpufreq/cpufreq.c                                    |    6=20
 drivers/infiniband/core/addr.c                               |   16 ++
 drivers/infiniband/core/ucma.c                               |   67 ++++++=
+----
 drivers/input/mousedev.c                                     |   62 +++++-=
----
 drivers/input/serio/i8042-x86ia64io.h                        |   24 +++
 drivers/md/dm-ioctl.c                                        |    4=20
 drivers/md/raid10.c                                          |    1=20
 drivers/media/usb/usbtv/usbtv-core.c                         |    2=20
 drivers/misc/mei/main.c                                      |    1=20
 drivers/mtd/chips/jedec_probe.c                              |    2=20
 drivers/net/ethernet/cavium/liquidio/lio_main.c              |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c           |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c            |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c            |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c             |    4=20
 drivers/parport/parport_pc.c                                 |    4=20
 drivers/pci/pci-driver.c                                     |    2=20
 drivers/pci/probe.c                                          |    2=20
 drivers/pci/setup-res.c                                      |    2=20
 drivers/scsi/virtio_scsi.c                                   |    1=20
 drivers/spi/spi-davinci.c                                    |    2=20
 drivers/staging/comedi/drivers/ni_mio_common.c               |    2=20
 drivers/tty/vt/vt.c                                          |    6=20
 drivers/usb/dwc2/hcd.c                                       |    7 -
 drivers/usb/gadget/function/f_hid.c                          |   24 +++
 drivers/usb/gadget/function/f_midi.c                         |    6=20
 drivers/usb/gadget/function/f_sourcesink.c                   |    6=20
 drivers/usb/gadget/function/g_zero.h                         |    1=20
 drivers/usb/gadget/u_f.c                                     |    6=20
 drivers/usb/gadget/u_f.h                                     |   26 +++-
 drivers/usb/serial/cp210x.c                                  |    1=20
 drivers/usb/serial/ftdi_sio.c                                |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                            |    9 +
 fs/compat_ioctl.c                                            |    2=20
 fs/proc/task_mmu.c                                           |   29 +---
 fs/proc/task_nommu.c                                         |   28 +---
 include/linux/audit.h                                        |   24 +++
 include/linux/cpumask.h                                      |   10 +
 include/linux/jiffies.h                                      |   13 --
 include/linux/llist.h                                        |   21 +++
 include/linux/netfilter/x_tables.h                           |    2=20
 include/linux/nospec.h                                       |   14 --
 include/linux/tty.h                                          |    4=20
 include/linux/usb/gadget.h                                   |   17 ++
 include/rdma/ib_addr.h                                       |    2=20
 include/uapi/linux/pci_regs.h                                |    2=20
 kernel/audit.c                                               |   18 --
 kernel/auditsc.c                                             |    8 -
 kernel/events/hw_breakpoint.c                                |   30 +---
 kernel/irq/manage.c                                          |    2=20
 kernel/kprobes.c                                             |    2=20
 mm/backing-dev.c                                             |    4=20
 net/bluetooth/smp.c                                          |    8 +
 net/bridge/netfilter/ebt_among.c                             |   34 +++++
 net/ipv4/netfilter/nf_nat_h323.c                             |   57 ++++--=
---
 net/ipv6/ip6_vti.c                                           |   20 ---
 net/netfilter/nf_conntrack_netlink.c                         |    7 -
 net/netfilter/x_tables.c                                     |   30 ++++
 net/netfilter/xt_hashlimit.c                                 |    5=20
 net/netfilter/xt_recent.c                                    |    6=20
 net/xfrm/xfrm_ipcomp.c                                       |    2=20
 net/xfrm/xfrm_state.c                                        |    5=20
 net/xfrm/xfrm_user.c                                         |   21 +--
 security/selinux/hooks.c                                     |   16 --
 security/selinux/ss/services.c                               |    2=20
 sound/core/oss/pcm_oss.c                                     |    4=20
 sound/core/pcm_native.c                                      |    2=20
 82 files changed, 521 insertions(+), 356 deletions(-)

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port car=
d.

Alexander Potapenko (1):
      llist: clang: introduce member_address_is_nonnull()

Andy Lutomirski (1):
      fs/proc: Stop trying to report thread stacks

Arnd Bergmann (1):
      tty: provide tty_name() even without CONFIG_TTY

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (2):
      ACPI, PCI, irq: remove redundant check for null string pointer
      mei: remove dev_err message on an unsupported ioctl

Dan Carpenter (1):
      ALSA: pcm: potential uninitialized return values

Dan Williams (1):
      nospec: Kill array_index_nospec_mask_check()

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Eric Biggers (1):
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short=
 one

Felipe F. Tonello (4):
      usb: gadget: define free_ep_req as universal function
      usb: gadget: change len to size_t on alloc_ep_req()
      usb: gadget: fix usb_ep_align_maybe endianness and new usb_ep_align
      usb: gadget: align buffer size when allocating for OUT endpoint

Florian Westphal (3):
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: bridge: ebt_among: add more missing match size checks
      netfilter: x_tables: add and use xt_check_proc_name

Frank Mori Hess (1):
      staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Greg Hackmann (1):
      net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Greg Kroah-Hartman (9):
      Revert "PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()"
      Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"
      Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"
      Revert "cpufreq: Fix governor module removal race"
      Revert "mtip32xx: use runtime tag to initialize command header"
      spi: davinci: fix up dma_mapping_error() incorrect patch
      net: cavium: liquidio: fix up "Avoid dma_unmap_single on uninitialize=
d ndata"
      Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
      Linux 4.4.127

Guoqing Jiang (1):
      md/raid10: reset the 'first' at the end of loop

Herbert Xu (1):
      crypto: ahash - Fix early termination in hash walk

Johan Hovold (1):
      USB: serial: cp210x: add ELDAT Easywave RX09 id

John Stultz (1):
      usb: dwc2: Improve gadget state disconnection handling

Kaixu Xia (1):
      writeback: fix the wrong congested state variable definition

Keerthy (3):
      Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override prop=
erty definition
      ARM: dts: dra7: Add power hold and power controller properties to pal=
mas
      ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property

Krzysztof Opasiak (1):
      usb: gadget: f_hid: fix: Prevent accessing released memory

Leon Romanovsky (6):
      RDMA/ucma: Check AF family prior resolving address
      RDMA/ucma: Fix use-after-free access in ucma_close
      RDMA/ucma: Ensure that CM_ID exists prior to access it
      RDMA/ucma: Check that device is connected prior to access it
      RDMA/ucma: Check that device exists prior to accessing it
      RDMA/ucma: Don't allow join attempts for unsupported AF family

Linus Torvalds (1):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Mark Charlebois (1):
      fs: compat: Remove warning from COMPATIBLE_IOCTL

Masami Hiramatsu (1):
      kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Matthias Brugger (1):
      net: hns: Fix ethtool private flags

Matthias Kaehlcke (9):
      PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
      dm ioctl: remove double parentheses
      genirq: Use cpumask_available() for check of cpumask variable
      cpumask: Add helper cpumask_available()
      selinux: Remove unnecessary check of array base in selinux_set_mappin=
g()
      jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_=
in_smp
      frv: declare jiffies to be located in the .data section
      netfilter: ctnetlink: Make some parameters integer to avoid enum mism=
atch
      selinux: Remove redundant check for unknown labeling behavior

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards

Nick Desaulniers (3):
      Input: mousedev - fix implicit conversion warning
      netfilter: nf_nat_h323: fix logical-not-parentheses warning
      arm64: avoid overflow in VA_START and PAGE_OFFSET

Oliver Neukum (1):
      media: usbtv: prevent double free in error case

Ondrej Zary (1):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Paolo Bonzini (1):
      scsi: virtio_scsi: always read VPD pages for multiqueue too

Richard Guy Briggs (1):
      audit: add tty field to LOGIN event

Richard Narron (1):
      partitions/msdos: Unable to mount UFS 44bsd partitions

Roland Dreier (1):
      RDMA/ucma: Introduce safer rdma_addr_size() variants

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Steffen Klassert (1):
      xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit sys=
tems

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

Will Deacon (1):
      nospec: Move array_index_nospec() parameter checking into separate ma=
cro


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrKMEQACgkQONu9yGCS
aT60qw//XjfZ0lQ3Vvje29QrA2xYDW6pTRSwzt+qNFEChKrCcDV+AI2XCznvpbzl
D7tOq59bh7T1GDbVoOLl0DEQf0kkneU/5R9gdT4QIGDQaOYWvc65TR/bIOXDpHtt
r3kij1idNKnJ8qcvsREMXdiIaZkisn1OFgXJM7cLI508bt1dkpXUVsk/9tY8jY0M
S41SYcAqeI8vqQLz1ElCVMam7S4nwS/erPe7hN6sn8bbPwn1q4fJVLW4OojsLX/2
7D16phm4LC/4CMYZ2eKDu78PThcBVYAOwVKTjoxV1y0IEv2PZ5fLAsvYUmDJ64/g
J0MNzGCtpmxcsk+zLrcT18CIPR4KujtL3xeeMEG6PlYNxEbQf1jkhyTqgO9s4qES
5AJb1ATFfMzawgoUysl/Dr5YBxUQFapPQrIovzVkdhxLrYTSI2aSTrCR/gjEPn7z
4glvsEUBZNRR/zJ9kPTpmcea8bnNMCSbJUG3hcvbPqzeacRhjhAoYtSLJ5eeV28z
F00x6gQidMdg1GiAnrMVyxopNJtPxUCy2OPS3vkm1OYXeI0+It1B7h6NGBci8Crn
Ci5xPk/Ou7pTkTlvPcS5rMzey/KkO5hn+j20rJZq3oJYLfdNmyVZ9keM3XzxAgpy
1iq8irasx4NnGs9Nbseb9WB0w6ntGWnfCrWx910CXY0/EGLMSJM=
=DAnC
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
