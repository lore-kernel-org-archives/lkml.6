Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB3BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C098C218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546456837;
	bh=EIkv03M3GXSIFjXuFz2KOmkAv/0FV4zhkeyxS8qewK0=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=E9vBbuR7vO2SrjGxanPRNCfdC6rroUryMbQvUK8vqRMEUEI1Ee21FZXguLwsO0niI
	 R2pFVzPLcC9uQfU6pkSd0ErArjq0+9VuJb2GE7nGJ3P6H0RmwGCnxne5qjmYkRpaoU
	 F/yFfJQ8zD1DD23HWxlt/meEpsoE4sDb1PhH/ldY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfABTUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:20:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:34066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfABTUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:20:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62AFEAE6E;
        Wed,  2 Jan 2019 19:20:34 +0000 (UTC)
Date:   Wed, 2 Jan 2019 20:20:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ixgbe: remove magic constant in ixgbe_reset_hw_82599()
Message-ID: <nycvar.YFH.7.76.1901022016380.14047@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

ixgbe_reset_hw_82599() resets the value of hw->mac.num_rar_entries to 
pre-defined value of 128. Let's get rid of that hardcoded literal, and use 
IXGBE_82599_RAR_ENTRIES instead, the same way the normal initialization 
path does.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 1e49716f52bc..109f8de5a1c2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1048,7 +1048,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	 * clear the multicast table.  Also reset num_rar_entries to 128,
 	 * since we modify this value when programming the SAN MAC address.
 	 */
-	hw->mac.num_rar_entries = 128;
+	hw->mac.num_rar_entries = IXGBE_82599_RAR_ENTRIES;
 	hw->mac.ops.init_rx_addrs(hw);
 
 	/* Store the permanent SAN mac address */
-- 
Jiri Kosina
SUSE Labs

