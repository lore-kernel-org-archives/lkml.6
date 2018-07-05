Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D8C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8265624148
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8265624148
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeGEBJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:09:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7246 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752969AbeGEBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:09:40 -0400
X-UUID: 61bcadc44fa641c3a37f6380655fce41-20180705
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1190124561; Thu, 05 Jul 2018 09:09:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 5 Jul 2018 09:09:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 5 Jul 2018 09:09:33 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v7 0/5] Add system timer driver for Mediatek SoCs
Date:   Thu, 5 Jul 2018 09:09:27 +0800
Message-ID: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
- Remove duplicated variable gpt_sched_reg.
- Remove log for mtk_syst_init().

Changes since v5:
- Optimize driver and remove redundant register operations.
- Docuement registers.
- Fix system timer base address.

Changes since v4:
- Simplify dt-bindings.
- Add error handling for mtk_syst_init().

Changes since v3:
- Use the same binding style for both GPT and System Timer.
- Use timer_of.of_clk->period instead of private structure.
- Arrange patches to contain system timer changes in patch 5/5 only.

Changes since v2:
- Rename existed mtk_timer.c to timer-mediatek.c.
- Add system timer support into timer-mediatek.c instead of creating a new file.
- Use _gpt_ and _syst_ to identify different timers.
- Convert gpt driver to use timer_of.
- Fix system timer driver: irq flags.
- Fix bindings of both gpt and system timer.

Changes since v1:
- Use timer_of structure and APIs to make driver more clean.
- Remove unnecessary headers.
- Use fixed-clock.
- Fix indent.


Stanley Chu (5):
  clocksource/drivers/timer-mediatek: Add system timer bindings
  clocksource/drivers/timer-mediatek: Rename mtk_timer to timer-mediatek
  clocksource/drivers/timer-mediatek: Use specific prefix for GPT
  clocksource/drivers/timer-mediatek: Convert the driver to timer-of
  clocksource/drivers/timer-mediatek: Add support for system timer

 .../bindings/timer/mediatek,mtk-timer.txt          |  36 ++-
 drivers/clocksource/Makefile                       |   2 +-
 drivers/clocksource/mtk_timer.c                    | 268 -----------------
 drivers/clocksource/timer-mediatek.c               | 328 +++++++++++++++++++++
 4 files changed, 350 insertions(+), 284 deletions(-)
 delete mode 100644 drivers/clocksource/mtk_timer.c
 create mode 100644 drivers/clocksource/timer-mediatek.c

