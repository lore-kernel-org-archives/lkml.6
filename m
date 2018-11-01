Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8CFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5018220820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5018220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeKAQFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:05:17 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:44043 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727781AbeKAQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:05:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E29F4182CF666;
        Thu,  1 Nov 2018 07:03:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hat75_764b258d0ee38
X-Filterd-Recvd-Size: 2270
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Nov 2018 07:03:32 +0000 (UTC)
Message-ID: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
Subject: [PATCH] igb: Fix format with line continuation whitespace
From:   Joe Perches <joe@perches.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 00:03:31 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The line continuation unintentionally adds whitespace so
instead use a coalesced format to remove the whitespace.

Miscellanea:

o Use a more typical style for ternaries and arguments
  for this logging message

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5df88ad8ac81..3a3410f03d04 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1850,13 +1850,12 @@ static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 	 * configuration' in respect to these parameters.
 	 */
 
-	netdev_dbg(netdev, "Qav Tx mode: cbs %s, launchtime %s, queue %d \
-			    idleslope %d sendslope %d hiCredit %d \
-			    locredit %d\n",
-		   (ring->cbs_enable) ? "enabled" : "disabled",
-		   (ring->launchtime_enable) ? "enabled" : "disabled", queue,
-		   ring->idleslope, ring->sendslope, ring->hicredit,
-		   ring->locredit);
+	netdev_dbg(netdev, "Qav Tx mode: cbs %s, launchtime %s, queue %d idleslope %d sendslope %d hiCredit %d locredit %d\n",
+		   ring->cbs_enable ? "enabled" : "disabled",
+		   ring->launchtime_enable ? "enabled" : "disabled",
+		   queue,
+		   ring->idleslope, ring->sendslope,
+		   ring->hicredit, ring->locredit);
 }
 
 static int igb_save_txtime_params(struct igb_adapter *adapter, int queue,

