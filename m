Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC19F20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC19F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeGZL3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:29:51 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:60484 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbeGZL3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:29:51 -0400
Received: from [192.168.0.22] (unknown [78.210.255.2])
        (Authenticated sender: daniel.lezcano)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id F2141780331;
        Thu, 26 Jul 2018 10:13:28 +0000 (UTC)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
From:   Daniel Lezcano <daniel.lezcano@free.fr>
Subject: [GIT PULL] timers for 4.19
Message-ID: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
Date:   Thu, 26 Jul 2018 12:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas, Ingo,

here are the changes for the timers for 4.19:

 - Add a less accurate but always-on clocksource for the sprd platform
(Baoling Wang)

 - Add the system timer for the new mediatek platforms (Stanley Chu)

 - Change the cpumask to cpu_possible_mask (Sudeep Holla)

Thanks !

  -- Daniel


The following changes since commit e5af5ff34cf037ac7bb70976161427dc40bf4a96:

  Merge tag 'fortglx/4.19/time-part2' of
https://git.linaro.org/people/john.stultz/linux into timers/core
(2018-07-20 06:43:05 +0200)

are available in the git repository at:

  ssh://git@git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.19

for you to fetch changes up to 1569557549697207e52310cc5b7dbc8e64bef504:

  clocksource/drivers/sprd: Register one always-on timer to compensate
suspend time (2018-07-26 11:26:34 +0200)

----------------------------------------------------------------
Baolin Wang (1):
      clocksource/drivers/sprd: Register one always-on timer to
compensate suspend time

Stanley Chu (5):
      clocksource/drivers/timer-mediatek: Add system timer bindings
      clocksource/drivers/timer-mediatek: Rename mtk_timer to timer-mediatek
      clocksource/drivers/timer-mediatek: Use specific prefix for GPT
      clocksource/drivers/timer-mediatek: Convert the driver to timer-of
      clocksource/drivers/timer-mediatek: Add support for system timer

Sudeep Holla (1):
      clocksource/drivers: Set clockevent device cpumask to
cpu_possible_mask

 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt |  34
++++++++++++---------
 drivers/clocksource/Makefile                                   |   2 +-
 drivers/clocksource/mtk_timer.c                                | 268
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
 drivers/clocksource/tegra20_timer.c                            |   2 +-
 drivers/clocksource/timer-atcpit100.c                          |   2 +-
 drivers/clocksource/timer-keystone.c                           |   2 +-
 drivers/clocksource/timer-mediatek.c                           | 328
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/timer-sprd.c                               |  50
+++++++++++++++++++++++++++++++
 drivers/clocksource/zevio-timer.c                              |   2 +-
 9 files changed, 403 insertions(+), 287 deletions(-)
 delete mode 100644 drivers/clocksource/mtk_timer.c
 create mode 100644 drivers/clocksource/timer-mediatek.c
