Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA79C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C15120895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C15120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbeG0LIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbeG0LIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:53 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F004AF8;
        Fri, 27 Jul 2018 09:47:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/66] 4.17.11-stable review
Date:   Fri, 27 Jul 2018 11:44:53 +0200
Message-Id: <20180727093809.043856530@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.11-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.11-rc1
X-KernelTest-Deadline: 2018-07-29T09:38+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.11 release.
There are 66 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul 29 09:37:38 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.11-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.11-rc1

Roman Fietze <roman.fietze@telemotive.de>
    can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before checking can.ctrlmode

Faiz Abbas <faiz_abbas@ti.com>
    can: m_can: Fix runtime resume call

Stephane Grosjean <s.grosjean@peak-system.com>
    can: peak_canfd: fix firmware < v3.3.0: limit allocation to 32-bit DMA addr only

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix RX overflow interrupt not being enabled

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix incorrect clear of non-processed interrupts

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix device dropping off bus on RX overrun

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix recovery from error states not being propagated

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix power management handling

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    driver core: Partially revert "driver core: correct device's shutdown order"

Schmauss, Erik <erik.schmauss@intel.com>
    ACPICA: AML Parser: ignore dispatcher error status during table load

Jerry Zhang <zhangjerry@google.com>
    usb: gadget: f_fs: Only return delayed status when len is 0

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    usb: gadget: Fix OS descriptors support

Zheng Xiaowei <zhengxiaowei@ruijie.com.cn>
    usb: xhci: Fix memory leak in xhci_endpoint_reset()

Antti Seppälä <a.seppala@gmail.com>
    usb: dwc2: Fix DMA alignment to start at allocated boundary

Bin Liu <b-liu@ti.com>
    usb: core: handle hub C_PORT_OVER_CURRENT condition

Lubomir Rintel <lkundrak@v3.sk>
    usb: cdc_acm: Add quirk for Castles VEGA3000

Samuel Thibault <samuel.thibault@ens-lyon.org>
    staging: speakup: fix wraparound in uaccess length check

Hans de Goede <hdegoede@redhat.com>
    Revert "staging:r8188eu: Use lib80211 to support TKIP"

Eric Dumazet <edumazet@google.com>
    tcp: add tcp_ooo_try_coalesce() helper

Eric Dumazet <edumazet@google.com>
    tcp: call tcp_drop() from tcp_data_queue_ofo()

Eric Dumazet <edumazet@google.com>
    tcp: detect malicious patterns in tcp_collapse_ofo_queue()

Eric Dumazet <edumazet@google.com>
    tcp: avoid collapses in tcp_prune_queue() if possible

Eric Dumazet <edumazet@google.com>
    tcp: free batches of packets in tcp_prune_ofo_queue()

Roopa Prabhu <roopa@cumulusnetworks.com>
    vxlan: fix default fdb entry netlink notify ordering during netdev create

Roopa Prabhu <roopa@cumulusnetworks.com>
    vxlan: make netlink notify in vxlan_fdb_destroy optional

Roopa Prabhu <roopa@cumulusnetworks.com>
    vxlan: add new fdb alloc and create helpers

Roopa Prabhu <roopa@cumulusnetworks.com>
    rtnetlink: add rtnl_link_state check in rtnl_configure_link

Ariel Levkovich <lariel@mellanox.com>
    net/mlx5: Adjust clock overflow work period

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5e: Fix quota counting in aRFS expire flow

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5e: Don't allow aRFS for encapsulated packets

David Ahern <dsahern@gmail.com>
    net/ipv6: Fix linklocal to global address with VRF

Hangbin Liu <liuhangbin@gmail.com>
    multicast: do not restore deleted record source filter mode to new one

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: consider PHY_IGNORE_INTERRUPT in phy_start_aneg_priv

Daniel Borkmann <daniel@iogearbox.net>
    sock: fix sg page frag coalescing in sk_alloc_sg

John Hurley <john.hurley@netronome.com>
    nfp: flower: ensure dead neighbour entries are not offloaded

Shay Agroskin <shayag@mellanox.com>
    net/mlx5e: Refine ets validation function

Roi Dayan <roid@mellanox.com>
    net/mlx5e: Only allow offloading decap egress (egdev) flows

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Add ingress/egress indication for offloaded TC flows

Doron Roberts-Kedes <doronrk@fb.com>
    tls: check RCV_SHUTDOWN in tls_wait_data

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: restore previous behavior to accept BIOS WoL settings

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5: E-Switch, UBSAN fix undefined behavior in mlx5_eswitch_mode

Yuchung Cheng <ycheng@google.com>
    tcp: do not delay ACK in DCTCP upon CE status change

Yuchung Cheng <ycheng@google.com>
    tcp: do not cancel delay-AcK on DCTCP special ACK

Yuchung Cheng <ycheng@google.com>
    tcp: helpers to send special DCTCP ack

Yuchung Cheng <ycheng@google.com>
    tcp: fix dctcp delayed ACK schedule

Eric Dumazet <edumazet@google.com>
    net: skb_segment() should not return NULL

Zhao Chen <zhaochen6@huawei.com>
    net-next/hinic: fix a problem in hinic_xmit_frame()

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapper

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    net: dsa: mv88e6xxx: fix races between lock and irq freeing

Willem de Bruijn <willemb@google.com>
    ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Paolo Abeni <pabeni@redhat.com>
    ip: hash fragments consistently

Jarod Wilson <jarod@redhat.com>
    bonding: set default miimon value for non-arp modes if not set

Neil Armstrong <narmstrong@baylibre.com>
    clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_commit()

Alexey Kardashevskiy <aik@ozlabs.ru>
    KVM: PPC: Check if IOMMU page is contained in the pinned physical page

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    xen/PVH: Set up GS segment for stack canary

Joel Stanley <joel@jms.id.au>
    clk: aspeed: Support HPLL strapping on ast2400

Joel Stanley <joel@jms.id.au>
    clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical

Gregory CLEMENT <gregory.clement@bootlin.com>
    clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz

Paul Burton <paul.burton@mips.com>
    MIPS: Fix off-by-one in pci_resource_to_user()

Felix Fietkau <nbd@nbd.name>
    MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Christoph Hellwig <hch@lst.de>
    Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()"

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/mips/ath79/common.c                           |   2 +-
 arch/mips/pci/pci.c                                |   2 +-
 arch/powerpc/include/asm/mmu_context.h             |   4 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |   2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |   6 +-
 arch/powerpc/mm/mmu_context_iommu.c                |  37 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/xen/xen-pvh.S                             |  26 +-
 drivers/acpi/acpica/psloop.c                       |  26 ++
 drivers/base/dd.c                                  |   8 -
 drivers/clk/clk-aspeed.c                           |  46 ++-
 drivers/clk/meson/gxbb.c                           |   1 +
 drivers/clk/mvebu/armada-37xx-periph.c             |  38 ++
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |   3 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   7 +
 drivers/gpu/drm/nouveau/nv50_display.c             |   8 +-
 drivers/iommu/Kconfig                              |   1 -
 drivers/iommu/intel-iommu.c                        |  62 +++-
 drivers/net/bonding/bond_options.c                 |  23 +-
 drivers/net/can/m_can/m_can.c                      |  11 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |  19 +
 drivers/net/can/xilinx_can.c                       | 392 +++++++++++++++------
 drivers/net/dsa/mv88e6xxx/chip.c                   |  21 +-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |   1 +
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   3 -
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  42 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |  12 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 drivers/net/ethernet/realtek/r8169.c               |   3 +-
 drivers/net/phy/phy.c                              |   2 +-
 drivers/net/vxlan.c                                | 126 +++++--
 drivers/staging/rtl8188eu/Kconfig                  |   1 -
 drivers/staging/rtl8188eu/core/rtw_recv.c          | 161 ++++++---
 drivers/staging/rtl8188eu/core/rtw_security.c      |  92 ++---
 drivers/staging/speakup/speakup_soft.c             |   6 +-
 drivers/usb/class/cdc-acm.c                        |   3 +
 drivers/usb/core/hub.c                             |   8 +-
 drivers/usb/dwc2/hcd.c                             |  44 +--
 drivers/usb/gadget/composite.c                     |   1 -
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/usb/host/xhci.c                            |   1 +
 drivers/vfio/vfio_iommu_spapr_tce.c                |   2 +-
 include/net/tcp.h                                  |   7 +
 net/core/rtnetlink.c                               |   9 +-
 net/core/skbuff.c                                  |  10 +-
 net/core/sock.c                                    |   6 +-
 net/ipv4/igmp.c                                    |   3 +-
 net/ipv4/ip_output.c                               |   2 +
 net/ipv4/ip_sockglue.c                             |   7 +-
 net/ipv4/tcp_dctcp.c                               |  50 +--
 net/ipv4/tcp_input.c                               |  65 +++-
 net/ipv4/tcp_output.c                              |  33 +-
 net/ipv6/datagram.c                                |   7 +-
 net/ipv6/icmp.c                                    |   5 +-
 net/ipv6/ip6_output.c                              |   2 +
 net/ipv6/mcast.c                                   |   3 +-
 net/ipv6/tcp_ipv6.c                                |   6 +-
 net/tls/tls_sw.c                                   |   3 +
 66 files changed, 1097 insertions(+), 474 deletions(-)


