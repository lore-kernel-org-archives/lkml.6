Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45E820873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45E820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeG3KKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:10:11 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:6231 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbeG3KKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:10:11 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 30 Jul 2018 17:36:16 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id B06D284612;
        Mon, 30 Jul 2018 17:36:16 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,422,1526310000"; 
   d="scan'208";a="288300604"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 30 Jul 2018 17:36:13 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 0/2] Add functions to get optional clocks
Date:   Mon, 30 Jul 2018 09:36:06 +0100
Message-Id: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

Phil Edworthy (2):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks

 drivers/clk/clk-devres.c | 18 ++++++++++++++++--
 drivers/clk/clkdev.c     | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/clk.h      | 30 +++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.7.4

