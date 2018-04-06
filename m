Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1632125-1523027503-2-3767298425808856259
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
    1523027502; b=EUfwl0lUVc5sCHgQtH0SoMJS7FDg+loEiwI3VmeFYLo4LLFbxr
    Cyjk2MOMP56QraxyY2klzLuxGvEYvjKh+XRxm7SoFTv4VLtum9jByFqQky46RBCr
    lQbE3y9LHrUeNqqU3j+eKgAh0qt2w1y+L78axKD8Eb7/faWiJIZdaA032Md/4EqP
    9k+f5yv+D+g8T2vgX4Rb80cjh3TFvkwWAKlctpYvZkEPNeHlh9ecl1Yeu63NRCTM
    fOXGmSaf/m7Y1BHwsBvpgGV6dMV/BpUtHFim44UaB8vfC0xeWUjm22t8AvZJJRnl
    kZ+A0NxocFDQUCKmJm0NRtYWH1fp0K99M42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523027502; bh=HkdYQFi9QHTW1VXMlPDuOlc/YJAWVY
    K3znXxxfhgdfc=; b=pRExjc9SnAXu0ur+/5BBaVWPBqgiMpJedrf/qjoIGOAixo
    V4LdDj/Tp8vldwl8u66ZYK255Xs/Tw/yrVyM+coQTBYCdHcdXo3gPP/ejstpxgRG
    Xd7bASriaUR51pxJfatT6K+VGhF5yNSUeqGm1QhvxF9fE93+nu9KnX9YAJ8PVd6X
    TTnSAm93rBZ+H/UgbzP7fUR9f1pqZe4ik51v/+ULKMM9wqBeSRBBTtNxN8kl4dt3
    cGkA1pRzKW1w/70BuY2iZUP63AOulQiK8z2dBtamYpKh0TAHT8+wLXOdwnR7PZ/K
    S5jSy/bLXtZFJsvwotd8zdZjmzhn8x4V7ilRtFdQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK80LRK0E7XeBrsDsWfyRmWgJ+A8WNVw0r+Q878M5OLuxW7P5vdeF+x/0fEfUBdhFz8RyaMQaFkiDQtjDHxR2lpcH+yaE4c+9niSwmzcW12dSSVo0EQS
    F9cb2kyV5kV3DSDQwyfjMSWmu4WJqFPZnCdPY1OIkic/kxUq1ouJ2xm/D3aZKGWNg4VlCud72AhHkAmDwHSx9tLsOVvwQV2EaGMtlw7VltIwkqKESo/sO5yt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=cDkPDwh1C9UA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
    a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8
    a=AgaioDkCAAAA:8 a=7ZN4cI0QAAAA:8 a=1XWaLZrsAAAA:8 a=FNyBlpCuAAAA:8
    a=ttLlOQO2AAAA:8 a=DfNHnWVPAAAA:8 a=xLcVsCfpAAAA:8 a=KKAkSRfTAAAA:8
    a=20KFwNOVAAAA:8 a=WTJdmG3rAAAA:8 a=CbDCq_QkAAAA:8 a=i0EeH86SAAAA:8
    a=w7XRow0EAAAA:8 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=nYrHyQrp_unPgzlCBMwA:9
    a=IxeEJ_kE3VVNJ5QN:21 a=-KHg2mV8A0JfhcdY:21 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=aeg5Gbbo78KNqacMgKqU:22 a=xmb-EsYY8bH0VWELuYED:22 a=eNS--96rZ24oWIaEtn_1:22
    a=Dl0WHwQvj8hGZljrFLtM:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=1BJeXTq6bvZE9X1NrNaC:22
    a=rjTVMONInIDnV1a_A2c_:22 a=4-ZGFxpmiTxXQSWJmrgh:22 a=cvBusfyB2V15izCimMoJ:22
    a=q3NGepEMMmKWaCv8Sx90:22 a=1qrBK16LubpBFNPVNq2M:22 a=wbvQwYS7zXXSDml_C_4i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeDFPL2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 11:11:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbeDFN3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:29:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/72] 4.4.127-stable review
Date: Fri,  6 Apr 2018 15:23:01 +0200
Message-Id: <20180406084305.210085169@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.127-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.127-rc1
X-KernelTest-Deadline: 2018-04-08T08:43+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.127 release.
There are 72 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr  8 08:42:48 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.127-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.127-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ip6_vti: adjust vti mtu according to mtu of lower device"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    net: cavium: liquidio: fix up "Avoid dma_unmap_single on uninitialized ndata"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    spi: davinci: fix up dma_mapping_error() incorrect patch

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "mtip32xx: use runtime tag to initialize command header"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "cpufreq: Fix governor module removal race"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()"

Dan Williams <dan.j.williams@intel.com>
    nospec: Kill array_index_nospec_mask_check()

Will Deacon <will.deacon@arm.com>
    nospec: Move array_index_nospec() parameter checking into separate macro

Matthias Brugger <matthias.bgg@gmail.com>
    net: hns: Fix ethtool private flags

Guoqing Jiang <gqjiang@suse.com>
    md/raid10: reset the 'first' at the end of loop

Keerthy <j-keerthy@ti.com>
    ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property

Keerthy <j-keerthy@ti.com>
    ARM: dts: dra7: Add power hold and power controller properties to palmas

Keerthy <j-keerthy@ti.com>
    Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition

Mike Frysinger <vapier@chromium.org>
    vt: change SGR 21 to follow the standards

Ondrej Zary <linux@rainbow-software.org>
    Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Andy Lutomirski <luto@kernel.org>
    fs/proc: Stop trying to report thread stacks

Eric Biggers <ebiggers@google.com>
    crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: ahash - Fix early termination in hash walk

Alexander Gerasiov <gq@redlab-i.ru>
    parport_pc: Add support for WCH CH382L PCI-E single parallel port card.

Oliver Neukum <oneukum@suse.com>
    media: usbtv: prevent double free in error case

Colin Ian King <colin.king@canonical.com>
    mei: remove dev_err message on an unsupported ioctl

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add ELDAT Easywave RX09 id

Clemens Werther <clemens.werther@gmail.com>
    USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Major Hayden <major@mhtx.net>
    USB: serial: ftdi_sio: add RT Systems VX-8 cable

John Stultz <john.stultz@linaro.org>
    usb: dwc2: Improve gadget state disconnection handling

Paolo Bonzini <pbonzini@redhat.com>
    scsi: virtio_scsi: always read VPD pages for multiqueue too

Alexander Potapenko <glider@google.com>
    llist: clang: introduce member_address_is_nonnull()

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix missing encryption refresh on Security Request

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: add and use xt_check_proc_name

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add more missing match size checks

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems

Greg Hackmann <ghackmann@google.com>
    net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Introduce safer rdma_addr_size() variants

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Don't allow join attempts for unsupported AF family

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that device exists prior to accessing it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that device is connected prior to access it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Ensure that CM_ID exists prior to access it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix use-after-free access in ucma_close

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check AF family prior resolving address

Florian Westphal <fw@strlen.de>
    xfrm_user: uncoditionally validate esn replay attribute struct

Nick Desaulniers <ndesaulniers@google.com>
    arm64: avoid overflow in VA_START and PAGE_OFFSET

Matthias Kaehlcke <mka@chromium.org>
    selinux: Remove redundant check for unknown labeling behavior

Matthias Kaehlcke <mka@chromium.org>
    netfilter: ctnetlink: Make some parameters integer to avoid enum mismatch

Arnd Bergmann <arnd@arndb.de>
    tty: provide tty_name() even without CONFIG_TTY

Richard Guy Briggs <rgb@redhat.com>
    audit: add tty field to LOGIN event

Matthias Kaehlcke <mka@chromium.org>
    frv: declare jiffies to be located in the .data section

Matthias Kaehlcke <mka@chromium.org>
    jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp

Mark Charlebois <charlebm@gmail.com>
    fs: compat: Remove warning from COMPATIBLE_IOCTL

Matthias Kaehlcke <mka@chromium.org>
    selinux: Remove unnecessary check of array base in selinux_set_mapping()

Matthias Kaehlcke <mka@chromium.org>
    cpumask: Add helper cpumask_available()

Matthias Kaehlcke <mka@chromium.org>
    genirq: Use cpumask_available() for check of cpumask variable

Nick Desaulniers <ndesaulniers@google.com>
    netfilter: nf_nat_h323: fix logical-not-parentheses warning

Nick Desaulniers <nick.desaulniers@gmail.com>
    Input: mousedev - fix implicit conversion warning

Matthias Kaehlcke <mka@chromium.org>
    dm ioctl: remove double parentheses

Matthias Kaehlcke <mka@chromium.org>
    PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant

Kaixu Xia <xiakaixu@huawei.com>
    writeback: fix the wrong congested state variable definition

Colin Ian King <colin.king@canonical.com>
    ACPI, PCI, irq: remove redundant check for null string pointer

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Krzysztof Opasiak <kopasiak90@gmail.com>
    usb: gadget: f_hid: fix: Prevent accessing released memory

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: align buffer size when allocating for OUT endpoint

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: fix usb_ep_align_maybe endianness and new usb_ep_align

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: change len to size_t on alloc_ep_req()

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: define free_ep_req as universal function

Richard Narron <comet.berkeley@gmail.com>
    partitions/msdos: Unable to mount UFS 44bsd partitions

Linus Torvalds <torvalds@linux-foundation.org>
    perf/hwbp: Simplify the perf-hwbp code, fix documentation

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: pcm: potential uninitialized return values

Stefan Roese <sr@denx.de>
    ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Linus Walleij <linus.walleij@linaro.org>
    mtd: jedec_probe: Fix crash in jedec_read_mfr()


-------------

Diffstat:

 .../devicetree/bindings/pinctrl/pinctrl-palmas.txt |  9 +++
 Documentation/filesystems/proc.txt                 | 26 ---------
 Makefile                                           |  4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |  2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  1 +
 arch/arm/boot/dts/dra7-evm.dts                     |  2 +
 arch/arm/boot/dts/omap3-n900.dts                   |  4 +-
 arch/arm64/include/asm/memory.h                    |  6 +-
 arch/frv/include/asm/timex.h                       |  6 ++
 arch/x86/crypto/cast5_avx_glue.c                   |  3 +-
 arch/x86/kernel/kprobes/core.c                     |  9 +++
 block/partitions/msdos.c                           |  4 +-
 crypto/ahash.c                                     |  7 ++-
 drivers/acpi/pci_irq.c                             |  3 -
 drivers/block/mtip32xx/mtip32xx.c                  | 36 ++++--------
 drivers/cpufreq/cpufreq.c                          |  6 --
 drivers/infiniband/core/addr.c                     | 16 ++++++
 drivers/infiniband/core/ucma.c                     | 67 +++++++++++++++-------
 drivers/input/mousedev.c                           | 62 +++++++++++---------
 drivers/input/serio/i8042-x86ia64io.h              | 24 ++++++++
 drivers/md/dm-ioctl.c                              |  4 +-
 drivers/md/raid10.c                                |  1 +
 drivers/media/usb/usbtv/usbtv-core.c               |  2 +
 drivers/misc/mei/main.c                            |  1 -
 drivers/mtd/chips/jedec_probe.c                    |  2 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  4 +-
 drivers/parport/parport_pc.c                       |  4 ++
 drivers/pci/pci-driver.c                           |  2 +
 drivers/pci/probe.c                                |  2 +-
 drivers/pci/setup-res.c                            |  2 +-
 drivers/scsi/virtio_scsi.c                         |  1 +
 drivers/spi/spi-davinci.c                          |  2 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |  2 +
 drivers/tty/vt/vt.c                                |  6 +-
 drivers/usb/dwc2/hcd.c                             |  7 ++-
 drivers/usb/gadget/function/f_hid.c                | 24 ++++++--
 drivers/usb/gadget/function/f_midi.c               |  6 --
 drivers/usb/gadget/function/f_sourcesink.c         |  6 --
 drivers/usb/gadget/function/g_zero.h               |  1 -
 drivers/usb/gadget/u_f.c                           |  6 +-
 drivers/usb/gadget/u_f.h                           | 26 ++++++++-
 drivers/usb/serial/cp210x.c                        |  1 +
 drivers/usb/serial/ftdi_sio.c                      |  2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |  9 +++
 fs/compat_ioctl.c                                  |  2 +-
 fs/proc/task_mmu.c                                 | 29 ++++------
 fs/proc/task_nommu.c                               | 28 ++++-----
 include/linux/audit.h                              | 24 ++++++++
 include/linux/cpumask.h                            | 10 ++++
 include/linux/jiffies.h                            | 13 ++---
 include/linux/llist.h                              | 21 ++++++-
 include/linux/netfilter/x_tables.h                 |  2 +
 include/linux/nospec.h                             | 14 -----
 include/linux/tty.h                                |  4 +-
 include/linux/usb/gadget.h                         | 17 +++++-
 include/rdma/ib_addr.h                             |  2 +
 include/uapi/linux/pci_regs.h                      |  2 +-
 kernel/audit.c                                     | 18 ++----
 kernel/auditsc.c                                   |  8 ++-
 kernel/events/hw_breakpoint.c                      | 30 +++-------
 kernel/irq/manage.c                                |  2 +-
 kernel/kprobes.c                                   |  2 +-
 mm/backing-dev.c                                   |  4 +-
 net/bluetooth/smp.c                                |  8 ++-
 net/bridge/netfilter/ebt_among.c                   | 34 +++++++++++
 net/ipv4/netfilter/nf_nat_h323.c                   | 57 +++++++++---------
 net/ipv6/ip6_vti.c                                 | 20 -------
 net/netfilter/nf_conntrack_netlink.c               |  7 +--
 net/netfilter/x_tables.c                           | 30 ++++++++++
 net/netfilter/xt_hashlimit.c                       |  5 +-
 net/netfilter/xt_recent.c                          |  6 +-
 net/xfrm/xfrm_ipcomp.c                             |  2 +-
 net/xfrm/xfrm_state.c                              |  5 ++
 net/xfrm/xfrm_user.c                               | 21 +++----
 security/selinux/hooks.c                           | 16 ------
 security/selinux/ss/services.c                     |  2 +-
 sound/core/oss/pcm_oss.c                           |  4 +-
 sound/core/pcm_native.c                            |  2 +-
 82 files changed, 522 insertions(+), 357 deletions(-)
