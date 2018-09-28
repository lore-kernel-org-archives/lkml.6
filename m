Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD442174E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD442174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mxic.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeI1ObW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:31:22 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:52990 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeI1ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:31:21 -0400
X-Greylist: delayed 2016 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 10:31:21 EDT
Received: from TWHMLLG4.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG4.macronix.com with ESMTP id w8S7ZK4k018848
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:35:20 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id w8S7ZEhL018803;
        Fri, 28 Sep 2018 15:35:14 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   masonccyang@mxic.com.tw
To:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
Subject: [PATCH v3 0/2] spi: Add Macronix controller driver
Date:   Fri, 28 Sep 2018 15:35:10 +0800
Message-Id: <1538120112-15530-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com w8S7ZEhL018803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>


Hi Mark, Trent and Boris,

I patched spi-mxic.c for clk_ctrl and run time PM.

please help to review.

thanks & best regards,
Mason


Mason Yang (2):
  spi: Add MXIC controller driver
  dt-bindings: spi: Document Macronix controller bindings

 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mxic.c                             | 599 +++++++++++++++++++++
 4 files changed, 640 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/spi/spi-mxic.c

-- 
1.9.1

