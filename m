Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B11ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF32620989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF32620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeIXPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:12:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56018 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbeIXPMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:12:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1F3B320725; Mon, 24 Sep 2018 11:11:08 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id C2A1E20618;
        Mon, 24 Sep 2018 11:11:07 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/2] net: mvpp2: Add txq to CPU mapping
Date:   Mon, 24 Sep 2018 11:11:04 +0200
Message-Id: <20180924091106.15094-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This short series adds XPS support to the mvpp2 driver, by mapping
txqs and CPUs. This comes with a patch using round-robin scheduling
for the HW to pick the next txq to transmit from, instead of the default
fixed-priority scheduling.

Maxime Chevallier (2):
  net: mvpp2: support XPS by mapping TX queues to CPUs
  net: mvpp2: use round-robin scheduling for TX queues on the same CPU

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.11.0

