Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E3ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454262150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454262150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbeISRWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:22:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeISRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:22:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA3C3D23C1E6B;
        Wed, 19 Sep 2018 19:44:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 19:44:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <ubraun@linux.ibm.com>, <jwi@linux.ibm.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <Ariel.Elior@cavium.com>,
        <everest-linux-l2@cavium.com>, <grygorii.strashko@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <borntraeger@de.ibm.com>
Subject: [RESEND PATCH 0/5] net: Use FIELD_SIZEOF directly instead of reimplementing its function
Date:   Wed, 19 Sep 2018 19:32:09 +0800
Message-ID: <1537356734-51676-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is detected with the help of Coccinelle.

zhong jiang (5):
  net: iucv: Use FIELD_SIZEOF directly instead of reimplementing its
    function
  net: sched: Use FIELD_SIZEOF directly instead of reimplementing its
    function
  net: core: Use FIELD_SIZEOF directly instead of reimplementing its
    function
  net: qede: Use FIELD_SIZEOF directly instead of reimplementing its
    function
  net: ti: Use FIELD_SIZEOF directly instead of reimplementing its
    function

 drivers/net/ethernet/qlogic/qede/qede.h |  2 +-
 drivers/net/ethernet/ti/cpsw.c          |  6 +++---
 net/core/flow_dissector.c               | 10 +++++-----
 net/iucv/af_iucv.c                      |  2 +-
 net/sched/cls_flower.c                  |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.7.12.4

