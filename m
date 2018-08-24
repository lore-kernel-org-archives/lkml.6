Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120D8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEB821710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k8MPpSHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEB821710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeHXMig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:38:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43859 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeHXMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:38:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so6847293wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=z4ffCXzbbDJPOq/rb6uuve93foFOxyU52TMljzPih58=;
        b=k8MPpSHj1ACjeQRBbx3gDxNVTKVbqx3BXo0cplaQiykDztOJ6CokFkInlg9y3SgXW+
         O//r2kVi6extVZx2NS9yM50gABGlv+dg3mTsF+Lh3SGVxRNoTqQ1km13gGonLlPCZcH+
         vhR1jvEQgaODkzTN8gN/6xOT0/zl1hAjvVIiYnIG2hShkPh4rWw8YadDTWSqlSStYpYF
         kO1ZZ25aoVxhB4ggfH/HSCCTwRwSAsvfUoXTVirm1na3mpd6Vaj88oXVLjuajpnM3NT0
         WiBbiu02KMP3cEler9cW/Ju8XxeW2BPE0WGB2w1wR+GNSs1w8lZVLnH188tJ44xGfI34
         BlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z4ffCXzbbDJPOq/rb6uuve93foFOxyU52TMljzPih58=;
        b=YFvFDn35zx/fsRWRjnaopkx6fG4PxYRRjCA91Gwvb3lgOFsWyPVk3+X6IOWHfHjz+R
         nB0LID/hK9OiY4VANaTrxL3qze8oWoVKKGJoLj3xlw5vFT0NsjnriV6bCwM7QFzG6nqd
         V9RO5KFcsrxb8HM0OQaxZ6ncIeWRUVX/RPXvrmg8WNlH0ri9TNRHdDd8ECKbsqIn7UjH
         REqnLkPz994AUk0RlWzlYBT9QnVV3JR1tOzf3D88V1tP4UR/9rrvaE+xg29u3NOAlz53
         LcKSGCq7cT0MEL4kr00/WsRMyeressbImM93WMyo7rl+bR/6L2Ax/bO7X6sq7lTBu0N9
         Rikg==
X-Gm-Message-State: APzg51AjJcwYjP5DnrFinU2/xIOHfcSeMLMJxQV3mSj2Gj/iKyfR93qL
        vQbmEZUXN1tEI6IIyR81jAtZOg==
X-Google-Smtp-Source: ANB0VdaiiuDtTra1UMpQxVn4G67i2ZhXpx6RrxcQJ2haX/v/ALDcDyirEwq26zOY/n1qI8VCWT6Ong==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr633131wrd.67.1535101492843;
        Fri, 24 Aug 2018 02:04:52 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h75-v6sm2690896wma.46.2018.08.24.02.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 02:04:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Joao Pinto <jpinto@synopsys.com>,
        Vitor Soares <soares@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Revert "net: stmmac: Do not keep rearming the coalesce timer in stmmac_xmit"
Date:   Fri, 24 Aug 2018 11:04:40 +0200
Message-Id: <20180824090440.13411-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4ae0169fd1b3c792b66be58995b7e6b629919ecf.

This change in the handling of the coalesce timer is causing regression on
(at least) amlogic platforms.

Network will break down very quickly (a few seconds) after starting
a download. This can easily be reproduced using iperf3 for example.

The problem has been reported on the S805, S905, S912 and A113 SoCs
(Realtek and Micrel PHYs) and it is likely impacting all Amlogics
platforms using Gbit ethernet

No problem was seen with the platform using 10/100 only PHYs (GXL internal)

Reverting change brings things back to normal and allows to use network
again until we better understand the problem with the coalesce timer.

Cc: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Vitor Soares <soares@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 76649adf8fb0..c0a855b7ab3b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -112,7 +112,6 @@ struct stmmac_priv {
 	u32 tx_count_frames;
 	u32 tx_coal_frames;
 	u32 tx_coal_timer;
-	bool tx_timer_armed;
 
 	int tx_coalesce;
 	int hwts_tx_en;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ff1ffb46198a..9f458bb16f2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3147,16 +3147,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * element in case of no SG.
 	 */
 	priv->tx_count_frames += nfrags + 1;
-	if (likely(priv->tx_coal_frames > priv->tx_count_frames) &&
-	    !priv->tx_timer_armed) {
+	if (likely(priv->tx_coal_frames > priv->tx_count_frames)) {
 		mod_timer(&priv->txtimer,
 			  STMMAC_COAL_TIMER(priv->tx_coal_timer));
-		priv->tx_timer_armed = true;
 	} else {
 		priv->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, desc);
 		priv->xstats.tx_set_ic_bit++;
-		priv->tx_timer_armed = false;
 	}
 
 	skb_tx_timestamp(skb);
-- 
2.17.1

