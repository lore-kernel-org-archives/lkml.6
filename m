Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16018C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD90B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD90B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeIFRvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:51:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40017 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727650AbeIFRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:51:12 -0400
X-UUID: 6be8ff8de3ce4f3190b13aea803eb0e7-20180906
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jun.gao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 459858057; Thu, 06 Sep 2018 21:15:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 21:15:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 21:15:35 +0800
From:   Jun Gao <jun.gao@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <srv_heupstream@mediatek.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 0/2] Register i2c adapter driver earlier and use DMA safe buffers
Date:   Thu, 6 Sep 2018 21:15:27 +0800
Message-ID: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series based on v4.19-rc2, include i2c adapter driver register time
modification and DMA safe buffers used for i2c transactions.

changes since v2:
- Remove the patch i2c: Add helper to ease DMA handling
- Use i2c refactor function to release a DMA safe buffer

changes since v1:
- Add the initializations for DMA safe buffer pointers

Jun Gao (2):
  i2c: mediatek: Register i2c adapter driver earlier
  i2c: mediatek: Use DMA safe buffers for i2c transactions

 drivers/i2c/busses/i2c-mt65xx.c | 74 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

--
1.8.1.1

