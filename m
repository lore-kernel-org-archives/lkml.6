Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB82DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B142085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfAVQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:40:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729487AbfAVQkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:40:13 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1793FA9A5B6E0CEE3A7F;
        Wed, 23 Jan 2019 00:40:05 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.54.154) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 00:39:55 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Wed, 23 Jan 2019 00:39:28 +0800
Message-ID: <20190122163940.7876-1-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.54.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS3
ethernet controller driver

Huazhong Tan (1):
  net: hns3: fix bug of ethtool_ops.get_channels for VF

Jian Shen (2):
  net: hns3: add rx multicast packets statistic
  net: hns3: refactor the statistics updating for netdev

Peng Li (2):
  net: hns3: add calling roce callback function when link status change
  net: hns3: clear param in ring when free ring

Yunsheng Lin (6):
  net: hns3: fix rss configuration lost problem when setting channel
  net: hns3: fix for shaper not setting when TC num changes
  net: hns3: Change fw error code NOT_EXEC to NOT_SUPPORTED
  net: hns3: do not return GE PFC setting err when initializing
  net: hns3: add ETS TC weight setting in SSU module
  net: hns3: fix PFC not setting problem for DCB module

liuzhongzhu (1):
  net: hns3: add statistics for PFC frames and MAC control frames

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  47 ++++--
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   8 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   1 +
 .../hisilicon/hns3/hns3pf/hclge_cmd.c         |  12 +-
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         |  19 +--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 138 ++++++++++++++----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   8 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c |  70 +++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |   7 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  10 +-
 12 files changed, 254 insertions(+), 73 deletions(-)

-- 
2.20.1


