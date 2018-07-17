Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E5720BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E5720BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeGQKIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:08:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729640AbeGQKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:08:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EDC8E2C9F37E2;
        Tue, 17 Jul 2018 17:36:45 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 17:36:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <derek.chickles@caviumnetworks.com>,
        <satananda.burla@caviumnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <felix.manlunas@caviumnetworks.com>,
        <raghu.vatsavayi@caviumnetworks.com>, <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] liquidio: Using NULL instead of plain integer
Date:   Tue, 17 Jul 2018 17:27:13 +0800
Message-ID: <20180717092713.7752-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/net/ethernet/cavium/liquidio/lio_main.c:3068:23: warning:
 Using plain integer as NULL pointer
drivers/net/ethernet/cavium/liquidio/lio_main.c:2909:23: warning:
 Using plain integer as NULL pointer
drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:385:27: warning:
 Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index 1f8b7f6..91dce8b 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -382,7 +382,7 @@ void cn23xx_vf_ask_pf_to_do_flr(struct octeon_device *oct)
 	mbox_cmd.recv_len = 0;
 	mbox_cmd.recv_status = 0;
 	mbox_cmd.fn = NULL;
-	mbox_cmd.fn_arg = 0;
+	mbox_cmd.fn_arg = NULL;
 
 	octeon_mbox_write(oct, &mbox_cmd);
 }
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index a60d5af..dd76477 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2906,7 +2906,7 @@ static int liquidio_set_vf_vlan(struct net_device *netdev, int vfidx,
 	    vfidx + 1; /* vfidx is 0 based, but vf_num (param2) is 1 based */
 	nctrl.ncmd.s.more = 0;
 	nctrl.iq_no = lio->linfo.txpciq[0].s.q_no;
-	nctrl.cb_fn = 0;
+	nctrl.cb_fn = NULL;
 	nctrl.wait_time = LIO_CMD_WAIT_TM;
 
 	octnet_send_nic_ctrl_pkt(oct, &nctrl);
@@ -3065,7 +3065,7 @@ static int liquidio_set_vf_link_state(struct net_device *netdev, int vfidx,
 	nctrl.ncmd.s.param2 = linkstate;
 	nctrl.ncmd.s.more = 0;
 	nctrl.iq_no = lio->linfo.txpciq[0].s.q_no;
-	nctrl.cb_fn = 0;
+	nctrl.cb_fn = NULL;
 	nctrl.wait_time = LIO_CMD_WAIT_TM;
 
 	octnet_send_nic_ctrl_pkt(oct, &nctrl);
-- 
2.7.0


