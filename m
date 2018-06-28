Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B11C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7779F25963
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7779F25963
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeF1DlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:41:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753194AbeF1DlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F850A8BA4930;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:51 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 00/11] net: hns3: a few code improvements
Date:   Thu, 28 Jun 2018 12:12:18 +0800
Message-ID: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a few code stylistic issues from
concentrated review, no functional changes introduced.

Huazhong Tan (2):
  net: hns3: remove back in struct hclge_hw
  net: hns3: use lower_32_bits and upper_32_bits

Peng Li (9):
  net: hns3: remove hclge_get_vector_index from
    hclge_bind_ring_with_vector
  net: hns3: rename the interface for init_client_instance and
    uninit_client_instance
  net: hns3: add vector status check before free vector
  net: hns3: add l4_type check for both ipv4 and ipv6
  net: hns3: add unlikely for error check
  net: hns3: remove unused head file in hnae3.c
  net: hns3: extraction an interface for state init|uninit
  net: hns3: print the ret value in error information
  net: hns3: remove the Redundant put_vector in hns3_client_uninit

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        | 18 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 18 +++----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 12 ++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 49 +++++++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 -
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 61 ++++++++++------------
 6 files changed, 85 insertions(+), 74 deletions(-)

-- 
2.9.3

