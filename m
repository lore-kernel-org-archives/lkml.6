Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B4D206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B4D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbeISPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:17:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43778 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeISPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:17:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 51E4120703; Wed, 19 Sep 2018 11:40:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 21B0420379;
        Wed, 19 Sep 2018 11:40:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 0/3] net: phy: phylink: ensure the carrier is off when starting phylink
Date:   Wed, 19 Sep 2018 11:39:30 +0200
Message-Id: <20180919093933.24411-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Following the discussion we had regarding the phylink issue related to
the carrier link state not being off when starting phylink, I sent a fix
patch a few days ago for the PPv2 driver:
https://lkml.org/lkml/2018/9/14/633

The idea was to send a patch which could go to the stable branches, but
a better solution would be to directly call netif_carrier_off() from
within phylink_start(). This is the aim of this series.

Thanks!
Antoine

Antoine Tenart (3):
  net: phy: phylink: ensure the carrier is off when starting phylink
  net: mvpp2: do not explicitly set the carrier state in open
  net: mvneta: do not explicitly set the carrier state in open

 drivers/net/ethernet/marvell/mvneta.c           | 3 ---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 -
 drivers/net/phy/phylink.c                       | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.17.1

