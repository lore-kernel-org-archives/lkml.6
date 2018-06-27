Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B62C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257F52650A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F52650A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933080AbeF0HyQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:54:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25914 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752460AbeF0HyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:54:10 -0400
X-UUID: 8c3244423e95453fa8db17a9d74b3bb6-20180627
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 90004065; Wed, 27 Jun 2018 15:54:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 15:54:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 15:54:03 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v2 0/2] Add system timer driver for Mediatek SoCs
Date:   Wed, 27 Jun 2018 15:53:57 +0800
Message-ID: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new driver for system timer on the Mediatek SoCs.

Changes since v1:
- Use timer_of structure and APIs to make driver more clean.
- Remove unnecessary headers.
- Use fixed-clock.
- Fix indent.


Stanley Chu (2):
  dt-bindings: Add mtk-systimer bindings
  clocksource/drivers/mtk_systimer: Add support for Mediatek SoCs

 .../bindings/timer/mediatek,mtk-systimer.txt       |  18 +++
 drivers/clocksource/Kconfig                        |  13 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/mtk_systimer.c                 | 132 +++++++++++++++++++++
 4 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
 create mode 100644 drivers/clocksource/mtk_systimer.c

