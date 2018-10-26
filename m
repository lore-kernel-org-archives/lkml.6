Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB317C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788320873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJZQ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:27:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbeJZQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:27:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7846BA8021581;
        Fri, 26 Oct 2018 15:51:29 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 26 Oct 2018
 15:51:22 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2 0/4] add support for MBIGEN generating message based SPIs
Date:   Fri, 26 Oct 2018 15:51:16 +0800
Message-ID: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now MBIGENs have pins that used to generate SPIs,
with
5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
we can support MBIGEN to generate message based SPIs by writing
GICD_SETSPIR. This patchset add support for MBIGEN generating
message based SPIs and a bugfix for MBI driver.


Patch #1 is a bugfix for MBI driver.
Pathc #2 ~ #4 is support for MBIGEN generating message based SPIs.

v2:
Move the doorbell address comments to the top.

Yang Yingliang (4):
  irqchip/gic-v3-mbi: fix uninitialized mbi_lock
  irqchip/mbigen: rename register marcros
  irqchip/mbigen: add support for a MBIGEN generating SPIs
  dt-bindings/irqchip/mbigen: add example of MBIGEN generate SPIs

 .../interrupt-controller/hisilicon,mbigen-v2.txt   | 17 +++++++-
 drivers/irqchip/irq-gic-v3-mbi.c                   |  2 +-
 drivers/irqchip/irq-mbigen.c                       | 47 +++++++++++++++-------
 3 files changed, 50 insertions(+), 16 deletions(-)

-- 
1.8.3


