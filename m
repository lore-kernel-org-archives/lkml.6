Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B31C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC482075C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC482075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJFMW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 08:22:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50508 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJFMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 08:22:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 34BFD13AE15A2;
        Fri,  5 Oct 2018 22:20:31 -0700 (PDT)
Date:   Fri, 05 Oct 2018 22:20:27 -0700 (PDT)
Message-Id: <20181005.222027.1089846249951010801.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 22:20:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I know this is really soon after the previous net pull request, but I want
to get this in for the BPF 32-bit right shift truncation fix.

1) Fix truncation of 32-bit right shift in bpf, from Jann Horn.

2) Fix memory leak in wireless wext compat, from Stefan Seyfried.

3) Use after free in cfg80211's reg_process_hint(), from Yu Zhao.

4) Need to cancel pending work when unbinding in smsc75xx otherwise
   we oops, also from Yu Zhao.

5) Don't allow enslaving a team device to itself, from Ido Schimmel.

6) Fix backwards compat with older userspace for rtnetlink FDB dumps.
   From Mauricio Faria.

7) Add validation of tc policy netlink attributes, from David Ahern.

8) Fix RCU locking in rawv6_send_hdrinc(), from Wei Wang.

Please pull, thanks a lot!

The following changes since commit cec4de302c5ff2c5eb3bfcb0c4845a095f5149b9:

  Merge gitolite.kernel.org:/pub/scm/linux/kernel/git/davem/net (2018-10-03 16:09:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 35f3625c21852ad839f20c91c7d81c4c1101e207:

  net: mvpp2: Extract the correct ethtype from the skb for tx csum offload (2018-10-05 14:52:43 -0700)

----------------------------------------------------------------
Baruch Siach (1):
      net: phy: phylink: fix SFP interface autodetection

David Ahern (1):
      net: sched: Add policy validation for tc attributes

David S. Miller (4):
      Merge branch 'mlxsw-fixes'
      Merge tag 'mac80211-for-davem-2018-10-04' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'bnxt_en-fixes'
      Merge git://git.kernel.org/.../bpf/bpf

Davide Caratti (1):
      be2net: don't flip hw_features when VXLANs are added/deleted

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Flavio Leitner (1):
      openvswitch: load NAT helper

Florian Fainelli (1):
      net: dsa: b53: Keep CPU port as tagged in all VLANs

Ido Schimmel (2):
      mlxsw: spectrum: Delete RIF when VLAN device is removed
      team: Forbid enslaving team device to itself

Jann Horn (1):
      bpf: 32-bit RSH verification must truncate input before the ALU op

Jianfeng Tan (1):
      net/packet: fix packet drop as of virtio gso

Mauricio Faria de Oliveira (1):
      rtnetlink: fix rtnl_fdb_dump() for ndmsg header

Maxime Chevallier (1):
      net: mvpp2: Extract the correct ethtype from the skb for tx csum offload

Michael Chan (1):
      bnxt_en: Fix VNIC reservations on the PF.

Nir Dotan (1):
      mlxsw: pci: Derive event type from event queue number

Roman Gushchin (2):
      bpf: harden flags check in cgroup_storage_update_elem()
      bpf: don't accept cgroup local storage with zero value size

Shanthosh RK (1):
      net: bpfilter: Fix type cast and pointer warnings

Stefan Seyfried (1):
      cfg80211: fix wext-compat memory leak

Vasundhara Volam (2):
      bnxt_en: Fix enables field in HWRM_QUEUE_COS2BW_CFG request
      bnxt_en: get the reduced max_irqs by the ones used by RDMA

Venkat Duvvuru (1):
      bnxt_en: free hwrm resources, if driver probe fails.

Wei Wang (1):
      ipv6: take rcu lock in rawv6_send_hdrinc()

Wenwen Wang (2):
      net: cxgb3_main: fix a missing-check bug
      yam: fix a missing-check bug

Yu Zhao (2):
      cfg80211: fix use-after-free in reg_process_hint()
      net/usb: cancel pending work when unbinding smsc75xx

 drivers/net/dsa/b53/b53_common.c                |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 14 ++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c   |  6 +++---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 17 +++++++++++++++++
 drivers/net/ethernet/emulex/benet/be_main.c     |  5 +----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  9 +++++----
 drivers/net/ethernet/mellanox/mlxsw/pci.c       | 11 +++++++----
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c  |  2 ++
 drivers/net/hamradio/yam.c                      |  4 ++++
 drivers/net/phy/phylink.c                       | 48 ++++++++++++++++++++++++++++--------------------
 drivers/net/team/team.c                         |  6 ++++++
 drivers/net/usb/smsc75xx.c                      |  1 +
 include/linux/virtio_net.h                      | 18 ++++++++++++++++++
 kernel/bpf/local_storage.c                      |  5 ++++-
 kernel/bpf/verifier.c                           | 10 +++++++++-
 net/bpfilter/bpfilter_kern.c                    |  4 ++--
 net/core/rtnetlink.c                            | 29 ++++++++++++++++++++---------
 net/ipv6/raw.c                                  | 29 ++++++++++++++++++++---------
 net/mac80211/cfg.c                              |  2 +-
 net/openvswitch/conntrack.c                     |  4 ++++
 net/packet/af_packet.c                          | 11 +++++++----
 net/sched/sch_api.c                             | 24 ++++++++++++++++++++----
 net/wireless/reg.c                              |  7 ++++---
 net/wireless/wext-compat.c                      | 14 ++++++++++----
 24 files changed, 203 insertions(+), 81 deletions(-)
