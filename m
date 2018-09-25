Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8390120842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8390120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIYI0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:26:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25527 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727816AbeIYI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:26:10 -0400
X-UUID: 152cd9598d4d4199a2e6acb60ac82b63-20180925
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1942760757; Tue, 25 Sep 2018 10:20:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Sep 2018 10:20:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Sep 2018 10:20:45 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>
Subject: [PATCH v4 0/3] Add Mediatek SPI slave driver
Date:   Tue, 25 Sep 2018 10:20:40 +0800
Message-ID: <1537842043-15255-1-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7f2423debd91771a1d3a5ca02cd3990f1417bcb8 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Tue, 25 Sep 2018 10:11:44 +0800
Subject: Subject: [PATCH v4 0/3] Add Mediatek SPI slave driver

v4:
1. Fix Mark Brown review comment about kconfig & driver.

v3:
1. Fix Rob Herring review comment about bindings.
2. remove unused variables in driver.

v2:
1. Fix Sean Wang review comment.
2. remove unused register and offset define.
3. update bindings file with assigned-clocks and assigned-clocks-parents.

v1:
This series are based on 4.19-rc1 and provide three patches to add mediatek spi slave driver.


Leilk Liu (3):
  spi: mediatek: add bindings for Mediatek MT2712 soc platform
  spi: mediatek: add spi slave for Mediatek MT2712
  arm64: dts: Add spi slave dts

 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |  32 ++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  11 +
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-slave-mt27xx.c                     | 554 +++++++++++++++++++++
 5 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
 create mode 100644 drivers/spi/spi-slave-mt27xx.c

-- 
1.9.1


