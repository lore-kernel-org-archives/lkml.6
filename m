Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B6826A8F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B6826A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935336AbeFZMa7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:30:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33940 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934709AbeFZMa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:30:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 914B120703; Tue, 26 Jun 2018 14:30:55 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6E397203B0;
        Tue, 26 Jun 2018 14:30:55 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v2 0/2] net: mscc: ocelot: add more features
Date:   Tue, 26 Jun 2018 14:28:47 +0200
Message-Id: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds link aggregation and VLAN filtering hardware offload
support to the ocelot driver.

PTP support will be sent later.

changes in v2:
 - rebased on v4.18-rc1
 - check for aggregation type and only offload it when type is hash (balance-xor
   or 802.3ad)

Alexandre Belloni (1):
  net: mscc: ocelot: add bonding support

Antoine Tenart (1):
  net: mscc: ocelot: add VLAN filtering

 drivers/net/ethernet/mscc/ocelot.c | 445 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/mscc/ocelot.h |   2 +-
 2 files changed, 444 insertions(+), 3 deletions(-)

-- 
2.18.0

