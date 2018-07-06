Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01359C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A3323FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A3323FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbeGFNUE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:20:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57289 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932995AbeGFNUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:20:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CEB83208B3; Fri,  6 Jul 2018 15:19:59 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id A39182072D;
        Fri,  6 Jul 2018 15:19:49 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 0/6] Few improvements on mvneta
Date:   Fri,  6 Jul 2018 15:19:43 +0200
Message-Id: <20180706131949.2684-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series brings some improvements for the mvneta driver.

The main one is the last patch which improves the driver for system
with low memory.

Patch 2 and 4 also contribute to improve the performance, whereas the
3 other ones are more about cleanup.

The series had been tested on ARM32 (clearfog) and ARM64
(EspressoBin), with and without hardware buffer management.

Gregory

Gregory CLEMENT (2):
  net: mvneta: remove data pointer usage from device_node structure
  net: mvneta: Allocate page for the descriptor

Yelena Krivosheev (4):
  net: mvneta: increase number of buffers in RX and TX queue
  net: mvneta: discriminate error cause for missed packet
  net: mvneta: Verify hardware checksum only when offload checksum
    feature is set
  net: mvneta: Improve the buffer allocation method for SWBM

 drivers/net/ethernet/marvell/mvneta.c    | 395 ++++++++++++++---------
 drivers/net/ethernet/marvell/mvneta_bm.c |  13 +
 drivers/net/ethernet/marvell/mvneta_bm.h |   8 +-
 3 files changed, 258 insertions(+), 158 deletions(-)

-- 
2.17.1

