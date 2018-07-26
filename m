Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D32DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5225D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbeGZO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbeGZO6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1E8C22082B; Thu, 26 Jul 2018 15:41:19 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 83E2A209A2;
        Thu, 26 Jul 2018 15:40:57 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/8] rtc: cleanup task handling
Date:   Thu, 26 Jul 2018 15:40:48 +0200
Message-Id: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series drops the now unused periodic task handling. It has been
used in total by 3 drivers that were dropped and mainly replaced by
kernel timers.

This allows to also remove a few rtc_device struct members and struct
rtc_task.

Tested using rtcpie and rtctest.

Alexandre Belloni (8):
  rtc: sa1100: don't set PIE frequency
  rtc: sh: remove dead code
  rtc: remove rtc_irq_register/rtc_irq_unregister
  rtc: remove irq_task and irq_task_lock
  rtc: simplify rtc_irq_set_state/rtc_irq_set_freq
  rtc: unexport rtc_irq_set_*
  char: rtc: remove task handling
  rtc: remove struct rtc_task

 drivers/char/rtc.c       | 13 ------
 drivers/rtc/class.c      |  1 -
 drivers/rtc/interface.c  | 97 +++++++---------------------------------
 drivers/rtc/rtc-dev.c    |  8 ++--
 drivers/rtc/rtc-sa1100.c |  1 -
 drivers/rtc/rtc-sh.c     | 89 +-----------------------------------
 include/linux/rtc.h      | 21 ++-------
 7 files changed, 25 insertions(+), 205 deletions(-)

-- 
2.18.0

