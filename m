Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A359C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0F22075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BNF/ixu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfBSJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:39:30 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52124 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfBSJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:39:30 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DB30210C1A3B;
        Tue, 19 Feb 2019 01:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550569169; bh=T2f5e/nXmAQbn638UC2q1hHm53IkVIFRTLmTMQ4B5wQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BNF/ixu8ITmf9b7MNd5WqBMIBgSdcUCV+ZqHJPOAgW1WNQUMlFMNpIxG5PvkpypIC
         3K6Y47P1SINmYc6xwFX+1pq+F8q/Po7uH27Bw7tTYOIXNbcdpxBcy8IoFqiHQvBwt1
         wvFchlfc0lDGLaktoYDKn58CK1HhdEohj2Ful+AhHOhw1/0/RFdxzbGqANfDJNHCa1
         3YruzV1djj3SgUiLJerJVvqX/VnMF5W16JxBtn18Wluio1+Foi9L5gbCQTsRKFf59E
         5lNL1etaW12GLgsbx1RIceyHjD0RrrWWkaNPbHJbwdHQnW+IyWoa4veGFxHaOkffWe
         vzKpz0Fcja5mA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id D51AC5A56;
        Tue, 19 Feb 2019 01:38:57 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next v3 0/3] net: stmmac: Performance improvements in Multi-Queue
Date:   Tue, 19 Feb 2019 10:38:46 +0100
Message-Id: <cover.1550569066.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested in XGMAC2 and GMAC5.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>

Jose Abreu (3):
  net: stmmac: Fix NAPI poll in TX path when in multi-queue
  net: stmmac: dwmac4: Also use TBU interrupt to clean TX path
  net: stmmac: dwxgmac2: Also use TBU interrupt to clean TX path

 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  24 ++---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 115 ++++++++++++---------
 5 files changed, 81 insertions(+), 75 deletions(-)

-- 
2.7.4

