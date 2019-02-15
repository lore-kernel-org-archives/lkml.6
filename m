Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA28C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C0721929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Sp1Lxj8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394993AbfBONmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:42:19 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:43856 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBONmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:42:19 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2A2A410C107D;
        Fri, 15 Feb 2019 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550238139; bh=NWYxkmdZOi1SKjkvKKsU2uZ3PcH4jl6/8meIqcWLijg=;
        h=From:To:Cc:Subject:Date:From;
        b=Sp1Lxj8dxwyfI7hzacjqgobAGTIn3MJeyuyoVJE+kLHi8q4PbkxMKrVwmIAaW+FuD
         rTZ9ej+cfflp4TxxyHxvGZgnUJ0rWOj3Z+TqN2bnA+1KU+2IsUkqjBd+uobbC5YzrZ
         gAXPlivt6LNtC4afOQoVEGXuEaKGFuetdQMywzPMC6vK0lkH+9uKyGcxz449AbSwwc
         6dIl9tfU2GEXzZ/nHCbA+A5w+5IfW8guipv+t6yGFBZPepp4vLjWIjDsouUNlXzywg
         n/1Oj8URw1hv3kkzhJq+D1eU/tDtFm5DMBetLKYGGm/jiAmPZKXlILt5FnpM2og+A4
         SEs79Z+DOt77Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 1DD6B5343;
        Fri, 15 Feb 2019 05:42:16 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 0/3] net: stmmac: Performance improvements in Multi-Queue
Date:   Fri, 15 Feb 2019 14:42:04 +0100
Message-Id: <cover.1550237884.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested in XGMAC2 and GMAC5. I guess 1/3 can be backported but besides being a
kind of "not that small" refactoring it's also for a scenario that no-one
complained yet ... Advice ?

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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 112 ++++++++++++---------
 5 files changed, 77 insertions(+), 76 deletions(-)

-- 
2.7.4

