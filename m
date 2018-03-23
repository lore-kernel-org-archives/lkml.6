Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeCWTr5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:47:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:17528 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCWTrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:47:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="40093390"
Date: Sat, 24 Mar 2018 03:47:42 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Jon Maloy <jon.maloy@ericsson.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Ying Xue <ying.xue@windriver.com>,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] tipc: tipc_disc_addr_trial_msg() can be static
Message-ID: <20180323194742.GA68339@athens>
References: <201803240317.PGXU57zT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803240317.PGXU57zT%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 discover.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index e765573..9f666e0 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -134,13 +134,13 @@ static void disc_dupl_alert(struct tipc_bearer *b, u32 node_addr,
 
 /* tipc_disc_addr_trial(): - handle an address uniqueness trial from peer
  */
-bool tipc_disc_addr_trial_msg(struct tipc_discoverer *d,
-			      struct tipc_media_addr *maddr,
-			      struct tipc_bearer *b,
-			      u32 dst, u32 src,
-			      u32 sugg_addr,
-			      u8 *peer_id,
-			      int mtyp)
+static bool tipc_disc_addr_trial_msg(struct tipc_discoverer *d,
+				     struct tipc_media_addr *maddr,
+				     struct tipc_bearer *b,
+				     u32 dst, u32 src,
+				     u32 sugg_addr,
+				     u8 *peer_id,
+				     int mtyp)
 {
 	struct net *net = d->net;
 	struct tipc_net *tn = tipc_net(net);
