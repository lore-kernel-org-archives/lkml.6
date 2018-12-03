Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF735C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6930F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6930F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeLCGNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:13:39 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:48208 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbeLCGNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:13:39 -0500
Received: from localhost.localdomain (10.28.8.22) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Mon, 3 Dec 2018
 14:13:49 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
Date:   Mon, 3 Dec 2018 14:13:22 +0800
Message-ID: <20181203061324.36248-1-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series try to add GPIO interrupt controller support for Meson-G12A SoCs.
Although the total number of pins is the same as the Meson-AXG SoC, the gpio
banks and irq numbers are different. To avoid confusion on use, i think the
new compatible string is needed.

Xingyu Chen (2):
  dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
  irqchip/meson-gpio: Add support for Meson-G12A SoC

 .../interrupt-controller/amlogic,meson-gpio-intc.txt         | 1 +
 drivers/irqchip/irq-meson-gpio.c                             | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.19.2

