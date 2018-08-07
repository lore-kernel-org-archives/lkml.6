Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6209721736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6209721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHHB1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:27:42 -0400
Received: from gateway36.websitewelcome.com ([192.185.179.26]:44297 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbeHHB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:27:42 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 91193400C5D80
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 17:12:32 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nB6cfilrsBcCXnB6ffInyM; Tue, 07 Aug 2018 18:09:41 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48018 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnB68-001oXX-0Q; Tue, 07 Aug 2018 18:09:04 -0500
Date:   Tue, 7 Aug 2018 18:09:00 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Jes Sorensen <jes@trained-monkey.org>, linux-acenic@sunsite.dk,
        Michael Chan <michael.chan@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Santosh Raspatur <santosh@chelsio.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Robert Richter <rric@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Tariq Toukan <tariqt@mellanox.com>, linux-rdma@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        everest-linux-l2@cavium.com,
        Manish Chopra <manish.chopra@cavium.com>,
        Rahul Verma <rahul.verma@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        Harish Patil <harish.patil@cavium.com>,
        Byungho An <bh74.an@samsung.com>,
        Girish K S <ks.giri@samsung.com>,
        Vipul Pandya <vipul.pandya@samsung.com>,
        Samuel Chessman <chessman@tux.org>
Subject: [PATCH 00/33] net: ethernet: Mark expected switch fall-throughs
Message-ID: <cover.1533675546.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.73.102
X-Source-L: No
X-Exim-ID: 1fnB68-001oXX-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48018
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to add some annotations in order to mark switch cases where we are
expecting to fall through.

Thanks

Gustavo A. R. Silva (33):
  8390: axnet_cs: Mark expected switch fall-through
  alteon: acenic: mark expected switch fall-through
  bnx2x: Mark expected switch fall-thoughs
  net: macb: Mark expected switch fall-through
  liquidio: mark expected switch fall-through
  cxgb4/l2t: Mark expected switch fall-through
  cxgb4/t4_hw: mark expected switch fall-throughs
  cxgb3/l2t: Mark expected switch fall-through
  net: thunderx: mark expected switch fall-through
  net: tulip_core: mark expected switch fall-through
  net: tulip: de4x5: mark expected switch fall-throughs
  be2net: Mark expected switch fall-through
  net: hns: Mark expected switch fall-through
  net: hns3: Mark expected switch fall-through
  i40e_main: mark expected switch fall-through
  i40e_txrx: mark expected switch fall-through
  net/mlx4/mcg: Mark expected switch fall-throughs
  net/mlx4/en_rx: Mark expected switch fall-throughs
  igb_main: Mark expected switch fall-throughs
  igb: e1000_82575: Mark expected switch fall-through
  igb: e1000_phy: Mark expected switch fall-through
  igbvf: netdev: Mark expected switch fall-through
  vxge: Mark expected switch fall-throughs
  net/mlx5e: Mark expected switch fall-throughs
  qed: qed_dev: Mark expected switch fall-throughs
  netxen_nic: Mark expected switch fall-throughs
  qede: qede_fp: Mark expected switch fall-through
  qlcnic: Mark expected switch fall-througs
  qlge: mark expected switch fall-through
  net: ethernet: sxgbe: mark expected switch fall-throughs
  net: sfc: falcon: mark expected switch fall-through
  net: tlan: Mark expected switch fall-through
  net: ethernet: ti: cpts: mark expected switch fall-through

 drivers/net/ethernet/8390/axnet_cs.c                    | 1 +
 drivers/net/ethernet/alteon/acenic.c                    | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c               | 2 +-
 drivers/net/ethernet/cadence/macb_ptp.c                 | 1 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c         | 1 +
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c     | 1 +
 drivers/net/ethernet/chelsio/cxgb3/l2t.c                | 1 +
 drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 1 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c              | 3 +++
 drivers/net/ethernet/dec/tulip/de4x5.c                  | 6 ++++++
 drivers/net/ethernet/dec/tulip/tulip_core.c             | 1 +
 drivers/net/ethernet/emulex/benet/be_ethtool.c          | 1 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c        | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c             | 1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c             | 3 ++-
 drivers/net/ethernet/intel/igb/e1000_82575.c            | 1 +
 drivers/net/ethernet/intel/igb/e1000_phy.c              | 1 +
 drivers/net/ethernet/intel/igb/igb_main.c               | 2 ++
 drivers/net/ethernet/intel/igbvf/netdev.c               | 1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c              | 2 ++
 drivers/net/ethernet/mellanox/mlx4/mcg.c                | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c        | 2 ++
 drivers/net/ethernet/neterion/vxge/vxge-config.c        | 3 +++
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c | 3 ++-
 drivers/net/ethernet/qlogic/qed/qed_dev.c               | 4 ++--
 drivers/net/ethernet/qlogic/qede/qede_fp.c              | 2 ++
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c     | 3 ++-
 drivers/net/ethernet/qlogic/qlge/qlge_mpi.c             | 1 +
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c      | 2 ++
 drivers/net/ethernet/sfc/falcon/ethtool.c               | 1 +
 drivers/net/ethernet/ti/cpts.c                          | 1 +
 drivers/net/ethernet/ti/tlan.c                          | 1 +
 33 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.7.4

