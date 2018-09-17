Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727222147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727222147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeIQHow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 03:44:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39931 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725997AbeIQHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 03:44:52 -0400
X-UUID: 1e39bc4a0dcf4305abaa4006dd547f92-20180917
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2145018832; Mon, 17 Sep 2018 10:19:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 17 Sep 2018 10:19:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 17 Sep 2018 10:19:30 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>
Subject: [PATCH v3 0/3] Add Mediatek SPI slave driver
Date:   Mon, 17 Sep 2018 10:19:19 +0800
Message-ID: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 32CEBE71047435EAFD9724CA7509BA5A6850123689BA99CA9CE9AE3C8615D7E92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 82bced99683343899dea4634452940b15d6374eb Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Mon, 17 Sep 2018 10:07:45 +0800
Subject: [PATCH v3 0/3] Add Mediatek SPI slave driver

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
  spis: mediatek: add bindings for Mediatek MT2712 soc platform
  spis: mediatek: add spi slave for Mediatek MT2712
  arm64: dts: Add spi slave dts

 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |  32 ++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  11 +
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-slave-mt27xx.c                     | 553 +++++++++++++++++++++
 5 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
 create mode 100644 drivers/spi/spi-slave-mt27xx.c

-- 
1.9.1

