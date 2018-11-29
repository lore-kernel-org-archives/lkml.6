Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F872133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zcC8Beqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F872133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeK2RFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeK2RFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:19 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEA021104;
        Thu, 29 Nov 2018 06:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471268;
        bh=llOnNyYALsrKJTeaH+M4gTJXkcc1LjXtK1nleMNZEeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcC8BeqtNnWDPrlzw2BLG/TVW6Kq75UCtGvzcOlas9/UqBYmL3x4Ac4Gf9/evjhbb
         5YhlA0V51mEjJV6QFPzw1Dp+weLNtydja56nYz42+NzF9+bVzUu/+Im6AH6R9UuUkL
         4T/oMReEaGputC0WmB9XtlXLF29f5n2gzbJBIZsM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Fiedler <andreas.fiedler@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 68/68] net: gemini: Fix copy/paste error
Date:   Thu, 29 Nov 2018 00:55:59 -0500
Message-Id: <20181129055559.159228-68-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Fiedler <andreas.fiedler@gmx.net>

[ Upstream commit 07093b76476903f820d83d56c3040e656fb4d9e3 ]

The TX stats should be started with the tx_stats_syncp,
there seems to be a copy/paste error in the driver.

Signed-off-by: Andreas Fiedler <andreas.fiedler@gmx.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 1c9ad3630c77..dfd1ad0b1cb9 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -661,7 +661,7 @@ static void gmac_clean_txq(struct net_device *netdev, struct gmac_txq *txq,
 
 			u64_stats_update_begin(&port->tx_stats_syncp);
 			port->tx_frag_stats[nfrags]++;
-			u64_stats_update_end(&port->ir_stats_syncp);
+			u64_stats_update_end(&port->tx_stats_syncp);
 		}
 	}
 
-- 
2.17.1

