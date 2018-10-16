Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999FAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A6B20658
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBnN2Ctd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A6B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeJQBOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbeJQBOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80B120866;
        Tue, 16 Oct 2018 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710570;
        bh=w+8bq3BjVh3xiKjppFTiUpbBp57QashundoGprDdmFE=;
        h=From:To:Cc:Subject:Date:From;
        b=vBnN2Ctd7TwYxBd2eNY+5hpfajxKkMWozbyBLlRqHTM1AodiNVu+9becdktE+mFei
         TmDRusNPOznem/8Gxr919EHWB/UErQ+ILzC97KQ34at4iH8NVdNyB76CIl3NYj3HKH
         8PL55v+s2lLxLGmIy4qoWo91q+7NI5LX1STP1+s0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/71] 4.9.134-stable review
Date:   Tue, 16 Oct 2018 19:08:57 +0200
Message-Id: <20181016170539.315587743@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.134-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.134-rc1
X-KernelTest-Deadline: 2018-10-18T17:05+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.134 release.
There are 71 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Oct 18 17:05:18 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.134-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.134-rc1

Dan Carpenter <dan.carpenter@oracle.com>
    ipv4: frags: precedence bug in ip_expire()

Taehee Yoo <ap420073@gmail.com>
    ip: frags: fix crash in ip_do_fragment()

Peter Oskolkov <posk@google.com>
    ip: process in-order fragments efficiently

Peter Oskolkov <posk@google.com>
    ip: add helpers to process in-order fragments faster.

Peter Oskolkov <posk@google.com>
    ip: use rb trees for IP frag queue.

Eric Dumazet <edumazet@google.com>
    net: add rb_to_skb() and other rb tree helpers

Eric Dumazet <edumazet@google.com>
    net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends

Florian Westphal <fw@strlen.de>
    ipv6: defrag: drop non-last frags smaller than min mtu

Peter Oskolkov <posk@google.com>
    net: modify skb_rbtree_purge to return the truesize of all purged skbs.

Eric Dumazet <edumazet@google.com>
    net: speed up skb_rbtree_purge()

Peter Oskolkov <posk@google.com>
    ip: discard IPv4 datagrams with overlapping segments.

Eric Dumazet <edumazet@google.com>
    inet: frags: fix ip6frag_low_thresh boundary

Eric Dumazet <edumazet@google.com>
    inet: frags: get rid of ipfrag_skb_cb/FRAG_CB

Eric Dumazet <edumazet@google.com>
    inet: frags: reorganize struct netns_frags

Eric Dumazet <edumazet@google.com>
    rhashtable: reorganize struct rhashtable layout

Eric Dumazet <edumazet@google.com>
    ipv6: frags: rewrite ip6_expire_frag_queue()

Eric Dumazet <edumazet@google.com>
    inet: frags: do not clone skb in ip_expire()

Eric Dumazet <edumazet@google.com>
    inet: frags: break the 2GB limit for frags storage

Eric Dumazet <edumazet@google.com>
    inet: frags: remove inet_frag_maybe_warn_overflow()

Eric Dumazet <edumazet@google.com>
    inet: frags: get rif of inet_frag_evicting()

Eric Dumazet <edumazet@google.com>
    inet: frags: remove some helpers

Eric Dumazet <edumazet@google.com>
    inet: frags: use rhashtables for reassembly units

Eric Dumazet <edumazet@google.com>
    rhashtable: add schedule points

Eric Dumazet <edumazet@google.com>
    ipv6: export ip6 fragments sysctl to unprivileged users

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor lowpan_net_frag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor ipv6_frag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor ipfrag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: add a pointer to struct netns_frags

Eric Dumazet <edumazet@google.com>
    inet: frags: change inet_frags_init_net() return value

Eric Dumazet <edumazet@google.com>
    inet: make sure to grab rcu_read_lock before using ireq->ireq_opt

Eric Dumazet <edumazet@google.com>
    tcp/dccp: fix lockdep issue when SYN is backlogged

Eric Dumazet <edumazet@google.com>
    rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix wake-up interrupt race during resume

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: mvpp2: Extract the correct ethtype from the skb for tx csum offload

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Fix unbind ordering

Ido Schimmel <idosch@mellanox.com>
    team: Forbid enslaving team device to itself

Giacinto Cifelli <gciofono@gmail.com>
    qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Shahed Shaikh <shahed.shaikh@cavium.com>
    qlcnic: fix Tx descriptor corruption on 82xx devices

Yu Zhao <yuzhao@google.com>
    net/usb: cancel pending work when unbinding smsc75xx

Sean Tranchetti <stranche@codeaurora.org>
    netlabel: check for IPV4MASK in addrinfo_get

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Display all addresses in output of /proc/net/if_inet6

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: update fnhe_pmtu when first hop's MTU changes

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns: fix for unmapping problem when SMMU is on

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Call setup during switch resume

Wei Wang <weiwan@google.com>
    ipv6: take rcu lock in rawv6_send_hdrinc()

Eric Dumazet <edumazet@google.com>
    ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()

Paolo Abeni <pabeni@redhat.com>
    ip_tunnel: be careful when accessing the inner header

Paolo Abeni <pabeni@redhat.com>
    ip6_tunnel: be careful when accessing the inner header

Mahesh Bandewar <maheshb@google.com>
    bonding: avoid possible dead-lock

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix TX timeout during netpoll.

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't print a warning when setting link state for disabled ports

Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
    i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Jan Kara <jack@suse.cz>
    mm: Preserve _PAGE_DEVMAP across mprotect() calls

Adrian Hunter <adrian.hunter@intel.com>
    perf script python: Fix export-to-postgresql.py occasional failure

Mikulas Patocka <mpatocka@redhat.com>
    mach64: detect the dot clock divider correctly on sparc

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Always map near top of user memory

Jann Horn <jannh@google.com>
    mm/vmstat.c: fix outdated vmstat_text

Daniel Rosenberg <drosen@google.com>
    ext4: Fix error code in ext4_xattr_set_entry()

Amber Lin <Amber.Lin@amd.com>
    drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/lapic: always disable MMIO interface in x2APIC mode

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: add new compatibility string for macb on sama5d3

Nicolas Ferre <nicolas.ferre@microchip.com>
    net: macb: disable scatter-gather for macb on sama5d3

Jongsung Kim <neidhard.kim@lge.com>
    stmmac: fix valid numbers of unicast filter entries

Yu Zhao <yuzhao@google.com>
    sound: enable interrupt after dma buffer initialization

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()

Laura Abbott <labbott@redhat.com>
    scsi: iscsi: target: Don't use stack buffer for scatterlist

Tony Lindgren <tony@atomide.com>
    mfd: omap-usb-host: Fix dts probe of children

Lei Yang <Lei.Yang@windriver.com>
    selftests: memory-hotplug: add required configs

Lei Yang <Lei.Yang@windriver.com>
    selftests/efivarfs: add required kernel configs

Danny Smith <danny.smith@axis.com>
    ASoC: sigmadsp: safeload should not have lower byte limit

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: wm8804: Add ACPI support


-------------

Diffstat:

 Documentation/devicetree/bindings/net/macb.txt     |   1 +
 Documentation/networking/ip-sysctl.txt             |  13 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi                |   2 +-
 arch/mips/include/asm/processor.h                  |  10 +-
 arch/mips/kernel/process.c                         |  25 +
 arch/mips/kernel/vdso.c                            |  18 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   4 +-
 arch/x86/include/asm/pgtable_types.h               |   2 +-
 arch/x86/include/uapi/asm/kvm.h                    |   1 +
 arch/x86/kvm/lapic.c                               |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   2 +-
 drivers/i2c/busses/i2c-scmi.c                      |   1 +
 drivers/mfd/omap-usb-host.c                        |  11 +-
 drivers/net/bonding/bond_main.c                    |  43 +-
 drivers/net/dsa/bcm_sf2.c                          |  12 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  13 +-
 drivers/net/ethernet/cadence/macb.c                |   8 +
 drivers/net/ethernet/hisilicon/hns/hnae.c          |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  30 +-
 drivers/net/ethernet/marvell/mvpp2.c               |  10 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   8 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  12 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   5 +-
 drivers/net/team/team.c                            |   5 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/smsc75xx.c                         |   1 +
 drivers/scsi/qla2xxx/qla_target.h                  |   4 +-
 drivers/target/iscsi/iscsi_target.c                |  22 +-
 drivers/usb/host/xhci-hub.c                        |  18 +-
 drivers/video/fbdev/aty/atyfb.h                    |   3 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   7 +-
 drivers/video/fbdev/aty/mach64_ct.c                |  10 +-
 fs/ext4/xattr.c                                    |   2 +-
 include/linux/netdevice.h                          |   7 +
 include/linux/rhashtable.h                         |   4 +-
 include/linux/skbuff.h                             |  34 +-
 include/net/bonding.h                              |   7 +-
 include/net/inet_frag.h                            | 133 +++--
 include/net/inet_sock.h                            |   6 -
 include/net/ip.h                                   |   1 -
 include/net/ip_fib.h                               |   1 +
 include/net/ipv6.h                                 |  26 +-
 include/uapi/linux/snmp.h                          |   1 +
 lib/rhashtable.c                                   |   5 +-
 mm/vmstat.c                                        |   1 -
 net/core/dev.c                                     |  28 +-
 net/core/rtnetlink.c                               |   6 +
 net/core/skbuff.c                                  |  31 +-
 net/dccp/input.c                                   |   4 +-
 net/dccp/ipv4.c                                    |   4 +-
 net/ieee802154/6lowpan/6lowpan_i.h                 |  26 +-
 net/ieee802154/6lowpan/reassembly.c                | 148 +++---
 net/ipv4/fib_frontend.c                            |  12 +-
 net/ipv4/fib_semantics.c                           |  50 ++
 net/ipv4/inet_connection_sock.c                    |   5 +-
 net/ipv4/inet_fragment.c                           | 379 +++-----------
 net/ipv4/ip_fragment.c                             | 573 ++++++++++++---------
 net/ipv4/ip_sockglue.c                             |   3 +-
 net/ipv4/ip_tunnel.c                               |   9 +
 net/ipv4/proc.c                                    |   7 +-
 net/ipv4/tcp_input.c                               |  37 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv6/addrconf.c                                |   4 +-
 net/ipv6/ip6_tunnel.c                              |  13 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            | 100 ++--
 net/ipv6/proc.c                                    |   5 +-
 net/ipv6/raw.c                                     |  29 +-
 net/ipv6/reassembly.c                              | 212 ++++----
 net/netlabel/netlabel_unlabeled.c                  |   3 +-
 sound/hda/hdac_controller.c                        |   8 +-
 sound/soc/codecs/sigmadsp.c                        |   3 +-
 sound/soc/codecs/wm8804-i2c.c                      |  15 +-
 tools/perf/scripts/python/export-to-postgresql.py  |   9 +
 tools/testing/selftests/efivarfs/config            |   1 +
 tools/testing/selftests/memory-hotplug/config      |   1 +
 80 files changed, 1185 insertions(+), 1133 deletions(-)


