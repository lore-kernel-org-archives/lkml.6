Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAD4208B0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeHBG1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:27:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59622 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeHBG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:27:08 -0400
Received: from localhost (unknown [172.56.41.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C40CE100970E6;
        Wed,  1 Aug 2018 21:37:54 -0700 (PDT)
Date:   Wed, 01 Aug 2018 21:37:53 -0700 (PDT)
Message-Id: <20180801.213753.1303803168352407122.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 21:37:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes keep trickling in:

1) Various IP fragmentation memory limit hardening changes from
   Eric Dumazet.

2) Revert ipv6 metrics leak change, it causes more problems than it fixes
   for now.

3) Fix WoL regression in stmmac driver, from Jose Abreu.

4) Netlink socket spectre v1 gadget fix, from Jeremy Cline.

Please pull, thanks a lot!

The following changes since commit c1d61e7fe3760851319138550efb732273ab2e57:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-07-31 09:46:36 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to e6aed040eafb4ce1881bbc59a225f6b27d250396:

  Revert "net/ipv6: fix metrics leak" (2018-08-01 21:32:30 -0700)

----------------------------------------------------------------
Adi Nissim (1):
      net/mlx5e: Fix null pointer access when setting MTU of vport representor

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix SERDES support on 88E6141/6341

David S. Miller (3):
      Merge tag 'wireless-drivers-for-davem-2018-07-31' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge tag 'mlx5-fixes-2018-07-31' of git://git.kernel.org/.../saeed/linux
      Revert "net/ipv6: fix metrics leak"

Eli Cohen (1):
      net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager

Emmanuel Grumbach (1):
      iwlwifi: add more card IDs for 9000 series

Eric Dumazet (3):
      inet: frag: enforce memory limits earlier
      ipv4: frags: handle possible skb truesize change
      bonding: avoid lockdep confusion in bond_get_stats()

Feras Daoud (1):
      net/mlx5e: IPoIB, Set the netdevice sw mtu in ipoib enhanced flow

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Govindarajulu Varadarajan (1):
      enic: do not call enic_change_mtu in enic_probe

Ioana Ciornei (1):
      Documentation: dpaa2: Use correct heading adornment

Jeremy Cline (1):
      netlink: Fix spectre v1 gadget in netlink_create()

Jose Abreu (1):
      net: stmmac: Fix WoL for PCI-based setups

Or Gerlitz (1):
      net/mlx5e: Set port trust mode to PCP as default

Rafa©© Mi©©ecki (1):
      brcmfmac: fix regression in parsing NVRAM for multiple devices

YueHaibing (1):
      rxrpc: Fix user call ID check in rxrpc_service_prealloc_one

 Documentation/networking/dpaa2/overview.rst             |  1 +
 drivers/net/bonding/bond_main.c                         | 14 ++++++++++++--
 drivers/net/dsa/mv88e6xxx/chip.c                        |  4 ++--
 drivers/net/ethernet/cisco/enic/enic_main.c             |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c      |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c       |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c       |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c   |  4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c        | 40 +++++++++++++++++++++++++++++++++++++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c           | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h         |  5 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c           | 22 ++++++++++++++++++++++
 net/dsa/slave.c                                         |  6 ++++++
 net/ipv4/inet_fragment.c                                |  6 +++---
 net/ipv4/ip_fragment.c                                  |  5 +++++
 net/ipv6/ip6_fib.c                                      | 18 ++++--------------
 net/netlink/af_netlink.c                                |  2 ++
 net/rxrpc/call_accept.c                                 |  4 ++--
 19 files changed, 184 insertions(+), 30 deletions(-)
