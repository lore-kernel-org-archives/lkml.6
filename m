Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F50AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100922086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760165;
	bh=H0Bnkl1KCKTM2kBip0hdFA+S0ohvbkOQvMoXm4zx+MQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=b2iQgZrsMvXdOXghxk8dTTvBEHTQS3WxmXbJ8RfNzAqYPHhNW7s5GbbuFhdEb+xhk
	 rZAlq3FsOqnInLRMT4SfkSMZPYxHuQ43Pyg0Phss4g4gd262U2zdZk/m5icSX+rRFX
	 GDXdEWkT0in8jl7CotPxMPHU88EubEKm2sAhKf/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfBUOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbfBUOmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1022075A;
        Thu, 21 Feb 2019 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760158;
        bh=H0Bnkl1KCKTM2kBip0hdFA+S0ohvbkOQvMoXm4zx+MQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OvNF7BkMkYitkJA9oHlsdlNK6HUNNdtbbEmnoLlKXc2ZZlmwPZpfuQD0LyS2mRRSX
         1kj1WB3lruNJusZrpCmc5xRoG+8s6Urb2+BVtVErL8K5CNuqgJKsZdxbLuSwGr1/CN
         TttUUl4R3h2wvsL9YOvS+EjUOIPmXIZT4vGI4dZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 00/32] 4.20.12-stable review
Date:   Thu, 21 Feb 2019 15:35:48 +0100
Message-Id: <20190221125250.855065214@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.12-rc1
X-KernelTest-Deadline: 2019-02-23T12:52+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.12 release.
There are 32 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.12-rc1

Eric Dumazet <edumazet@google.com>
    ax25: fix possible use-after-free

Eric Dumazet <edumazet@google.com>
    mISDN: fix a race in dev_expire_timer()

Eric Dumazet <edumazet@google.com>
    net/x25: do not hold the cpu too long in x25_new_lci()

Jann Horn <jannh@google.com>
    netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs

Wei Yongjun <weiyongjun1@huawei.com>
    hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    mmc: meson-gx: fix interrupt name

Qian Cai <cai@lca.pw>
    x86_64: increase stack size for KASAN_EXTRA

Wei Yongjun <weiyongjun1@huawei.com>
    scsi: target/core: Use kmem_cache_free() instead of kfree()

Logan Gunthorpe <logang@deltatee.com>
    PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/arm: Revert "Defer persistent reservations until after paging_init()"

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64, mm, efi: Account for GICv3 LPI tables in static memblock reserve table

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    af_packet: fix raw sockets over 6in4 tunnel

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    net: Do not allocate page fragments that are not skb aligned

Murali Karicheri <m-karicheri2@ti.com>
    net: netcp: Fix ethss driver probe issue

Eric Dumazet <edumazet@google.com>
    tcp: tcp_v4_err() should be more careful

Eric Dumazet <edumazet@google.com>
    tcp: clear icsk_backoff in tcp_write_queue_purge()

David S. Miller <davem@davemloft.net>
    net: Add header for usage of fls64()

Jason Wang <jasowang@redhat.com>
    vhost: correctly check the return value of translate_desc() in log_used()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay again

Willem de Bruijn <willemb@google.com>
    net: validate untrusted gso packets without csum offload

Alexandre Torgue <alexandre.torgue@st.com>
    net: stmmac: handle endianness in dwmac4_get_timestamp

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix a race in EEE enable callback

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    net: phy: xgmiitorgmii: Support generic PHY status read

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ip6_gre: initialize erspan_ver just for erspan tunnels

Hauke Mehrtens <hauke.mehrtens@intel.com>
    net: Fix for_each_netdev_feature on Big endian

Mao Wenan <maowenan@huawei.com>
    net: crypto set sk to NULL when af_alg_release.

Petr Machata <petrm@mellanox.com>
    mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Eric Dumazet <edumazet@google.com>
    vxlan: test dev->flags & IFF_UP before calling netif_rx()

Paolo Abeni <pabeni@redhat.com>
    vsock: cope with memory allocation failure at socket creation time

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Zhiqiang Liu <liuzhiqiang26@huawei.com>
    net: fix IPv6 prefix route residue

John David Anglin <dave.anglin@bell.net>
    dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to exit


-------------

Diffstat:

 Makefile                                           |  4 +--
 arch/arm64/include/asm/memory.h                    | 11 +++++++
 arch/arm64/kernel/setup.c                          |  1 -
 arch/x86/include/asm/page_64_types.h               |  4 +++
 crypto/af_alg.c                                    |  4 ++-
 drivers/firmware/efi/efi.c                         |  4 ---
 drivers/firmware/efi/libstub/arm-stub.c            |  3 --
 drivers/hwmon/lm80.c                               |  4 ++-
 drivers/isdn/mISDN/timerdev.c                      |  2 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   | 28 ++++++++++++++----
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     | 12 ++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  9 ++++--
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 22 +++++++-------
 drivers/net/ethernet/ti/netcp_core.c               |  2 +-
 drivers/net/phy/xilinx_gmii2rgmii.c                |  5 +++-
 drivers/net/vxlan.c                                | 14 +++++++--
 drivers/pci/pci.c                                  |  3 +-
 drivers/target/target_core_transport.c             |  2 +-
 drivers/vhost/vhost.c                              |  2 +-
 include/linux/efi.h                                |  7 -----
 include/linux/memblock.h                           |  3 --
 include/linux/netdev_features.h                    | 24 +++++++++++++--
 include/linux/skbuff.h                             |  2 +-
 include/linux/virtio_net.h                         |  9 ++++++
 include/net/ax25.h                                 | 12 ++++++++
 include/net/inetpeer.h                             |  1 +
 mm/memblock.c                                      | 11 +++++--
 net/ax25/ax25_ip.c                                 |  4 +--
 net/ax25/ax25_route.c                              | 19 +++++-------
 net/core/dev.c                                     |  4 +--
 net/core/skbuff.c                                  |  4 +++
 net/ipv4/inetpeer.c                                |  1 +
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c        |  7 ++++-
 net/ipv4/route.c                                   |  7 +++--
 net/ipv4/tcp.c                                     |  2 +-
 net/ipv4/tcp_ipv4.c                                |  7 +++--
 net/ipv6/addrconf.c                                |  3 +-
 net/ipv6/ip6_gre.c                                 | 34 +++++++++++++---------
 net/packet/af_packet.c                             |  3 +-
 net/vmw_vsock/vmci_transport.c                     |  4 +++
 net/x25/af_x25.c                                   |  6 ++--
 43 files changed, 211 insertions(+), 104 deletions(-)


