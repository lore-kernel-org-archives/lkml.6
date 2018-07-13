Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B6EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB92D2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB92D2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGMQ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:29:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38787 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbeGMQ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:29:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DD0C1208C4; Fri, 13 Jul 2018 18:14:02 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9085C20737;
        Fri, 13 Jul 2018 18:13:52 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/5] net: mvpp2: add debugfs interface
Date:   Fri, 13 Jul 2018 18:13:39 +0200
Message-Id: <20180713161344.19872-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPv2 Header Parser and Classifier are not straightforward to debug,
having easy access to some of the many lookup tables configuration is
helpful during development and debug.

This series adds a basic debugfs interface, allowing to read data from
the Header Parser and some of the Classifier tables.

For now, the interface is read-only, and contains only some basic info.

This was actually used during RSS development, and might be useful to
troubleshoot some issues we might find.

The first patch of the series converts the mvpp2 files to SPDX, which
eases adding the new debugfs dedicated file.

The second patch adds the interface, and exposes basic Header Parser data.

The 3rd patch adds a hit counter for the Header Parser TCAM.

The 4th patch exposes classifier info.

The 5th patch adds some hit counters for some of the classifier engines.

Antoine Tenart (1):
  net: mvpp2: switch to SPDX identifiers

Maxime Chevallier (4):
  net: mvpp2: add a debugfs interface for the Header Parser
  net: mvpp2: debugfs: add hit counter stats for Header Parser entries
  net: mvpp2: debugfs: add entries for classifier flows
  net: mvpp2: debugfs: add classifier hit counters

 drivers/net/ethernet/marvell/mvpp2/Makefile        |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |  23 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |  52 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     |  26 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 703 +++++++++++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   9 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     |  33 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h     |  16 +-
 8 files changed, 829 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c

-- 
2.11.0

