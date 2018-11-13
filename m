Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07011C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78082250F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78082250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbeKMVss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:48:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43757 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKMVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:48:48 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gMXDd-0003cR-Q8; Tue, 13 Nov 2018 11:50:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peng Li <lipeng321@huawei.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] net: hns3: fix spelling mistake "failded" -> "failed"
Date:   Tue, 13 Nov 2018 11:50:57 +0000
Message-Id: <20181113115057.13237-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix, the spelling of "failded" is incorrect in dev_err and
dev_warn messages. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 43bfc730a62d..1b97a1bdbd2f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2440,7 +2440,7 @@ int hclge_set_all_vf_rst(struct hclge_dev *hdev, bool reset)
 		ret = hclge_set_vf_rst(hdev, vport->vport_id, reset);
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
-				"set vf(%d) rst failded %d!\n",
+				"set vf(%d) rst failed %d!\n",
 				vport->vport_id, ret);
 			return ret;
 		}
@@ -2455,7 +2455,7 @@ int hclge_set_all_vf_rst(struct hclge_dev *hdev, bool reset)
 		ret = hclge_inform_reset_assert_to_vf(vport);
 		if (ret)
 			dev_warn(&hdev->pdev->dev,
-				 "inform reset to vf(%d) failded %d!\n",
+				 "inform reset to vf(%d) failed %d!\n",
 				 vport->vport_id, ret);
 	}
 
-- 
2.19.1

