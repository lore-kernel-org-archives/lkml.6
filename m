Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB81C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0794C206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeLODRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:17:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbeLODRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:17:32 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E08F582B0B23;
        Sat, 15 Dec 2018 11:17:29 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 11:17:22 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [Patch net 00/10] net: hns: Code improvements & fixes for HNS driver
Date:   Sat, 15 Dec 2018 11:53:19 +0800
Message-ID: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some code improvements and fixes
for the identified problems in the HNS driver.

Every patch is independent.

Yonglong Liu (10):
  net: hns: Incorrect offset address used for some registers.
  net: hns: All ports can not work when insmod hns ko after rmmod.
  net: hns: some registers use wrong address according to the datasheet.
  net: hns: fixed bug that netdev was opened twice
  net: hns: clean rx fbd when ae stopped.
  net: hns: free irq when exit from abnormal branch
  net: hns: Avoid net reset caused by pause frames storm
  net: hns: Fix ntuple-filters status error.
  net: hns: Add mac pcs config when enable|disable mac
  net: hns: fix ping failed when use net bridge and send multicast

 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   3 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  14 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  15 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 503 ++++++++++++++-------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  13 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  43 +-
 6 files changed, 413 insertions(+), 178 deletions(-)

-- 
1.9.1

