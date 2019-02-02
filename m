Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FFBC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87A2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBBOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:40:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbfBBOkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:52 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DCA2768138C6479D0B8;
        Sat,  2 Feb 2019 22:40:50 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:39 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Sat, 2 Feb 2019 22:39:25 +0800
Message-ID: <20190202143937.8924-1-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.97.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS3
ethernet controller driver

Huazhong Tan (1):
  net: hns3: fix a wrong checking in the hclge_tx_buffer_calc()

Jian Shen (1):
  net: hns3: don't allow user to change vlan filter state

Peng Li (2):
  net: hns3: fix a code style issue for hns3_update_new_int_gl()
  net: hns3: fix an issue for hns3_update_new_int_gl

Weihang Li (2):
  net: hns3: add hclge_cmd_check_retval() to parse comman's return value
  net: hns3: move some set_bit statement into hclge_prepare_mac_addr

Yonglong Liu (1):
  net: hns3: Modify parameter type from int to bool in set_gro_en

Yunsheng Lin (1):
  net: hns3: code optimization for hclge_rx_buffer_calc

liuzhongzhu (4):
  net: hns3: fix the problem that the supported port is empty
  net: hns3: optimize the maximum TC macro
  net: hns3: modify the upper limit judgment condition
  net: hns3: MAC table entry count function increases operation 0 value
    protection measures

 .../net/ethernet/hisilicon/hns3/hclge_mbx.h   |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  33 ++--
 .../hisilicon/hns3/hns3pf/hclge_cmd.c         |  62 +++---
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   7 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 184 ++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  31 ++-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  34 +++-
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |   2 +
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  12 ++
 11 files changed, 216 insertions(+), 159 deletions(-)

-- 
2.20.1


