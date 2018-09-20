Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11FEECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9499C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbeITPc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:32:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387489AbeITPcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:32:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B35C6BA0D2741;
        Thu, 20 Sep 2018 17:50:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 17:50:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <santosh@chelsio.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] net: remove redundant null pointer check before kfree_skb
Date:   Thu, 20 Sep 2018 17:37:40 +0800
Message-ID: <1537436266-41955-1-git-send-email-zhongjiang@huawei.com>
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

zhong jiang (6):
  net: tap: remove redundant null pointer check before kfree_skb
  net: cxgb3: remove redundant null pointer check before kfree_skb
  ipv4: remove redundant null pointer check before kfree_skb
  net: nci: remove redundant null pointer check before kfree_skb
  net: cxgb3_main: remove redundant null pointer check before kfree_skb
  ipv6: remove redundant null pointer check before kfree_skb

 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    | 3 +--
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c | 3 +--
 drivers/net/tap.c                                  | 6 ++----
 net/ipv4/ip_fragment.c                             | 3 +--
 net/ipv6/af_inet6.c                                | 6 ++----
 net/nfc/nci/uart.c                                 | 6 ++----
 6 files changed, 9 insertions(+), 18 deletions(-)

-- 
1.7.12.4

