Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F186C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101672089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YQsJoWnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfBRIuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:50:08 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:39060 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:50:05 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 41D2B10C16B4;
        Mon, 18 Feb 2019 00:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550479805; bh=ybQzD/DYq6MmRqt/C7FfsVhaFjc9m+EqxwjevXk2j7w=;
        h=From:To:Cc:Subject:Date:From;
        b=YQsJoWndE6jVrrheLQaqi3ISV9CdpNVxGBjUR1WgIbdcX0PmZXeox6xCnyjgaE514
         2rP7JivKbsStQ4BgKXLXKQP7eV2uCp8lqq3mvbOhXSNVLPtGJI7wVdDusprPw6MPqe
         MqyV5Rf+PsaqW9MI5Mc5Qsb+qUEF2cvxZ8l46Tdungi/cZORYrUfym5Se5H30j/yUV
         bxs5J1Hsyat8zm3xV0T5vADCuSepBe//8kKlY6WsLcvkwe1LjAs/dia0YpLqSaz6hY
         4sKgkWUDmc9xrU6ThLX+3cBEmHEG2WI6et8Y2mh682U1b+IwZlxdK3eUbJbBWn7i3D
         fv/pBdl3XpbIA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 05483502B;
        Mon, 18 Feb 2019 00:50:02 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: Performance improvements in Multi-Queue
Date:   Mon, 18 Feb 2019 09:49:50 +0100
Message-Id: <cover.1550479678.git.joabreu@synopsys.com>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 114 ++++++++++++---------
 5 files changed, 79 insertions(+), 76 deletions(-)

-- 
2.7.4

