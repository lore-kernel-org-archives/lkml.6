Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7602218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbfA3U4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbfA3U4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:22 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F11C786FBB9DFF80BE84;
        Thu, 31 Jan 2019 04:56:19 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:11 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Thu, 31 Jan 2019 04:55:40 +0800
Message-ID: <20190130205552.8512-1-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS3
ethernet controller driver

Huazhong Tan (4):
  net: hns3: change hnae3_register_ae_dev() to int
  net: hns3: Fix NULL deref when unloading driver
  net: hns3: fix netif_napi_del() not do problem when unloading
  net: hns3: fix improper error handling in the hclge_init_ae_dev()

Jian Shen (4):
  net: hns3: fix VF dump register issue
  net: hns3: fix for rss result nonuniform
  net: hns3: stop sending keep alive msg to PF when VF is resetting
  net: hns3: keep flow director state unchanged when reset

Peng Li (2):
  net: hns3: use the correct interface to stop|open port
  net: hns3: fix an issue for hclgevf_ae_get_hdev

Yunsheng Lin (1):
  net: hns3: only support tc 0 for VF

liyongxin (1):
  net: hns3: reuse the definition of l3 and l4 header info union

 drivers/net/ethernet/hisilicon/hns3/hnae3.c   | 10 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 95 +++++++++----------
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  1 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  6 +-
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 12 +--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 50 +++++-----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         | 10 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  8 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.h        |  4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 22 +++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 25 ++++-
 13 files changed, 145 insertions(+), 104 deletions(-)

-- 
2.20.1


