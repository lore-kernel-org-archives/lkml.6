Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D4C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33AD2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33AD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLMIj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:39:57 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:52845 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeLMIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:39:34 -0500
Received: from localhost.localdomain (10.28.8.16) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 13 Dec 2018
 16:39:52 +0800
From:   Sunny Luo <sunny.luo@amlogic.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] spi: meson-axg: add few enhanced features
Date:   Thu, 13 Dec 2018 16:39:11 +0800
Message-ID: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.16]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a few enhanced features for the SPICC controller of Meson-AXG SoC.

These patches are actually quite independent from each other, I send them
together in case to avoid the file conflicts.

Changes since v1 at [1]
- Add OF and COMMON_CLK dependence for SPICC in Kconfig to avoid compiling
  error.

[1] https://lore.kernel.org/lkml/20180503213645.20694-1-yixun.lan@amlogic.com

Sunny Luo (3):
  spi: meson-axg: support MAX 80M clock
  spi: meson-axg: enhance output enable feature
  spi: meson-axg: add a linear clock divider support

 drivers/spi/Kconfig           |   2 +-
 drivers/spi/spi-meson-spicc.c | 270 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 223 insertions(+), 49 deletions(-)

-- 
2.7.4

