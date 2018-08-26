Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19241C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35C3216FA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35C3216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeHZK05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:26:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHZK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:26:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C36A7949;
        Sun, 26 Aug 2018 06:45:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/56] 3.18.120-stable review
Date:   Sun, 26 Aug 2018 08:44:21 +0200
Message-Id: <20180826064232.320669119@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.120-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.120-rc1
X-KernelTest-Deadline: 2018-08-28T06:42+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.120 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Aug 28 06:42:19 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.120-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.120-rc1

Jann Horn <jannh@google.com>
    reiserfs: fix broken xattr handling (heap corruption, bad retval)

Lukas Wunner <lukas@wunner.de>
    PCI: hotplug: Don't leak pci_slot on registration failure

Willem de Bruijn <willemb@google.com>
    packet: refine ring v3 block size test to hold one frame

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior state

Eric Dumazet <edumazet@google.com>
    xfrm_user: prevent leaking 2 bytes of kernel memory

Daniel Rosenberg <drosen@google.com>
    staging: android: ion: check for kref overflow

Randy Dunlap <rdunlap@infradead.org>
    tcp: identify cryptic messages as TCP seq # bugs

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Make sure the QCA7000 reset is triggered

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Avoid packet drop during initial sync

David Lechner <david@lechnology.com>
    net: usb: rtl8150: demote allmulti message to dev_dbg()

Dan Carpenter <dan.carpenter@oracle.com>
    qlogic: check kstrtoul() for errors

Alexander Duyck <alexander.h.duyck@intel.com>
    ixgbe: Be more careful when modifying MAC filters

Adam Ford <aford173@gmail.com>
    ARM: dts: am3517.dtsi: Disable reference to OMAP3 OTG controller

Russell King <rmk+kernel@armlinux.org.uk>
    drm/armada: fix colorkey mode property

Daniel Mack <daniel@zonque.org>
    ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: set module owner for icmp(6) matches

Yuiko Oshino <yuiko.oshino@microchip.com>
    smsc75xx: Add workaround for gigabit link up hardware errata.

Mathieu Malaterre <malat@debian.org>
    tracing: Use __printf markup to silence compiler

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: imx_v4_v5_defconfig: Select ULPI support

Greg Ungerer <gerg@linux-m68k.org>
    m68k: fix "bad page state" oops on ColdFire boot

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Fix receiving tx-timeout in error or recovery state.

Marek Szyprowski <m.szyprowski@samsung.com>
    drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 modes

BingJing Chang <bingjingc@synology.com>
    md/raid10: fix that replacement cannot complete recovery after reassemble

Dan Carpenter <dan.carpenter@oracle.com>
    dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()

Keerthy <j-keerthy@ti.com>
    ARM: dts: da850: Fix interrups property for gpio

Sandipan Das <sandipan@linux.ibm.com>
    perf report powerpc: Fix crash if callchain is empty

Daniel Mack <daniel@zonque.org>
    ARM: dts: am437x: make edt-ft5x06 a wakeup source

Michael Trimarchi <michael@amarulasolutions.com>
    brcmfmac: stop watchdog before detach and free everything

Ganesh Goudar <ganeshgr@chelsio.com>
    cxgb4: when disabling dcb set txq dcb priority to 0

Casey Schaufler <casey@schaufler-ca.com>
    Smack: Mark inode instant in smack_task_to_inode

Hangbin Liu <liuhangbin@gmail.com>
    ipv6: mcast: fix unsolicited report interval after receiving querys

Steven Rostedt (VMware) <rostedt@goodmis.org>
    locking/lockdep: Do not record IRQ state within lockdep code

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    net: davinci_emac: match the mdio device against its compatible if possible

Li RongQing <lirongqing@baidu.com>
    net: propagate dev_get_valid_name return code

Stefan Agner <stefan@agner.ch>
    net: hamradio: use eth_broadcast_addr

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: initialize enic->rfs_h.lock in enic_probe

Zhizhou Zhang <zhizhouzhang@asrmicro.com>
    arm64: make secondary_start_kernel() notrace

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: gadget: composite: fix delayed_status race condition when set_interface

William Wu <william.wu@rock-chips.com>
    usb: dwc2: fix isoc split in transfer with no data

Fathi Boudra <fathi.boudra@linaro.org>
    selftests: sync: add config fragment for testing sync framework

Eric Dumazet <edumazet@google.com>
    netfilter: ipv6: nf_defrag: reduce struct net memory waste

Kees Cook <keescook@chromium.org>
    isdn: Disable IIOCDBGVAR

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    Bluetooth: avoid killing an already killed socket

Chen Hu <hu1.chen@intel.com>
    serial: 8250_dw: always set baud rate in dw8250_set_termios

John Ogness <john.ogness@linutronix.de>
    USB: serial: sierra: fix potential deadlock at close

Takashi Iwai <tiwai@suse.de>
    ALSA: vxpocket: Fix invalid endian conversions

Takashi Iwai <tiwai@suse.de>
    ALSA: memalloc: Don't exceed over the requested size

Takashi Iwai <tiwai@suse.de>
    ALSA: cs5535audio: Fix invalid endian conversion

Takashi Iwai <tiwai@suse.de>
    ALSA: virmidi: Fix too long output trigger loop

Takashi Iwai <tiwai@suse.de>
    ALSA: vx222: Fix invalid endian conversions

Cong Wang <xiyou.wangcong@gmail.com>
    vsock: split dwork to avoid reinitializations

Hangbin Liu <liuhangbin@gmail.com>
    net_sched: fix NULL pointer dereference when delete tcindex filter

Hangbin Liu <liuhangbin@gmail.com>
    net_sched: Fix missing res info when create new tc_index filter

Cong Wang <xiyou.wangcong@gmail.com>
    llc: use refcount_inc_not_zero() for llc_sap_find()

Wei Wang <weiwan@google.com>
    l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/am3517.dtsi                      |  5 ++
 arch/arm/boot/dts/am437x-sk-evm.dts                |  2 +
 arch/arm/boot/dts/da850.dtsi                       |  6 +--
 arch/arm/configs/imx_v4_v5_defconfig               |  2 +
 arch/arm/mach-pxa/irq.c                            |  4 +-
 arch/arm64/kernel/smp.c                            |  2 +-
 arch/m68k/include/asm/mcf_pgalloc.h                |  4 +-
 drivers/dma/k3dma.c                                |  2 +-
 drivers/gpu/drm/armada/armada_hw.h                 |  1 +
 drivers/gpu/drm/armada/armada_overlay.c            | 30 ++++++++---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            | 29 ++++++----
 drivers/gpu/drm/exynos/regs-gsc.h                  |  1 +
 drivers/isdn/i4l/isdn_common.c                     |  8 +--
 drivers/md/raid10.c                                |  7 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  6 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  6 +++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  2 +-
 drivers/net/ethernet/cisco/enic/enic_clsf.c        |  3 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 12 ++++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |  2 +
 drivers/net/ethernet/qualcomm/qca_spi.c            |  5 +-
 drivers/net/ethernet/ti/davinci_emac.c             |  4 ++
 drivers/net/hamradio/bpqether.c                    |  8 +--
 drivers/net/usb/rtl8150.c                          |  2 +-
 drivers/net/usb/smsc75xx.c                         | 62 ++++++++++++++++++++++
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |  7 +++
 drivers/pci/hotplug/pci_hotplug_core.c             |  9 ++++
 drivers/staging/android/ion/ion.c                  | 17 ++++--
 drivers/tty/serial/8250/8250_dw.c                  |  2 +-
 drivers/usb/dwc2/hcd_intr.c                        |  3 +-
 drivers/usb/gadget/composite.c                     |  3 ++
 drivers/usb/serial/sierra.c                        |  4 +-
 fs/reiserfs/xattr.c                                |  4 +-
 include/net/af_vsock.h                             |  4 +-
 include/net/llc.h                                  |  5 ++
 include/net/net_namespace.h                        |  1 +
 include/net/netns/ipv6.h                           |  1 -
 kernel/locking/lockdep.c                           | 12 ++---
 kernel/trace/trace.c                               |  5 ++
 net/bluetooth/sco.c                                |  3 +-
 net/core/dev.c                                     |  4 +-
 net/dccp/ccids/ccid2.c                             |  6 ++-
 net/ipv4/netfilter/ip_tables.c                     |  1 +
 net/ipv4/tcp.c                                     |  4 +-
 net/ipv6/mcast.c                                   |  9 ++--
 net/ipv6/netfilter/ip6_tables.c                    |  1 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |  6 +--
 net/l2tp/l2tp_core.c                               |  2 +-
 net/llc/llc_core.c                                 |  4 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |  8 +--
 net/packet/af_packet.c                             | 10 ++--
 net/sched/cls_tcindex.c                            |  8 ++-
 net/vmw_vsock/af_vsock.c                           | 15 +++---
 net/vmw_vsock/vmci_transport.c                     |  3 +-
 net/xfrm/xfrm_user.c                               |  8 +--
 security/smack/smack_lsm.c                         |  1 +
 sound/core/memalloc.c                              |  8 +--
 sound/core/seq/seq_virmidi.c                       | 10 ++++
 sound/pci/cs5535audio/cs5535audio.h                |  6 +--
 sound/pci/cs5535audio/cs5535audio_pcm.c            |  4 +-
 sound/pci/vx222/vx222_ops.c                        |  8 +--
 sound/pcmcia/vx/vxp_ops.c                          | 10 ++--
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  2 +-
 tools/testing/selftests/sync/config                |  4 ++
 67 files changed, 316 insertions(+), 129 deletions(-)


