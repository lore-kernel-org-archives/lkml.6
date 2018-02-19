Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeBSRLb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:31 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38838 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbeBSRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:30 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: netdev@vger.kernel.org
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] stmmac multi-queue fixes and cleanups
Date: Mon, 19 Feb 2018 18:11:08 +0100
Message-Id: <20180219171116.15326-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stmmac multi-queue fixes and cleanups

Niklas Cassel (7):
  net: stmmac: set MSS for each tx DMA channel
  net: stmmac: do not clear tx_skbuff entries in
    stmmac_xmit()/stmmac_tso_xmit()
  net: stmmac: WARN if tx_skbuff entries are reused before cleared
  net: stmmac: rename dwmac4_tx_queue_routing() to match reality
  net: stmmac: call correct function in
    stmmac_mac_config_rx_queues_routing()
  net: stmmac: add error handling in stmmac_mtl_setup()
  net: stmmac: honor error code from stmmac_dt_phy()

 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  6 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 23 +++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 34 +++++++++++++++++-----
 4 files changed, 42 insertions(+), 23 deletions(-)

-- 
2.14.2
