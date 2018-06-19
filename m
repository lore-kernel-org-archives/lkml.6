Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C0C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C0C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937802AbeFSMfb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:35:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43631 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937674AbeFSMf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:35:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EF3952085A; Tue, 19 Jun 2018 14:35:27 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB8B120799;
        Tue, 19 Jun 2018 14:35:17 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        Hua Jing <jinghua@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Ken Ma <make@marvell.com>
Subject: [PATCH 0/2] clk: Fix switching CPU rate from 300Mhz to 1.2GHz on Armada 3700
Date:   Tue, 19 Jun 2018 14:34:44 +0200
Message-Id: <20180619123446.694-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in this series the first patch is the main patch which fixes the case
when switching CPU rate from 300Mhz (or 200M MHz) to 1.2GH. See the
commit log for the details. As this one is a fix, it should be applied
on v4.18-rc.

While I was on this file, I also switch to SPDX license identifier,
this one is fine for 4.19*;

Thanks,

Gregory

Gregory CLEMENT (2):
  clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to
    1.2GHz
  clk: mvebu: armada-37xx-periph: switch to SPDX license identifier

 drivers/clk/mvebu/armada-37xx-periph.c | 43 +++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

-- 
2.17.1
