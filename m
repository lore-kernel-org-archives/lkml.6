Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644E7222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfBPJxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 04:53:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfBPJxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 04:53:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F47A2F5D26583C1F0D3;
        Sat, 16 Feb 2019 17:53:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 17:53:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dchickles@marvell.com>,
        <sburla@marvell.com>, <fmanlunas@marvell.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] liquidio: using NULL instead of plain integer
Date:   Sat, 16 Feb 2019 17:53:10 +0800
Message-ID: <20190216095310.22544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warning:

drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1453:35: warning: Using plain integer as NULL pointer
drivers/net/ethernet/cavium/liquidio/lio_main.c:2910:23: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 9f4f3c1d..43d11c3 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1450,7 +1450,7 @@ void cn23xx_tell_vf_its_macaddr_changed(struct octeon_device *oct, int vfidx,
 		mbox_cmd.recv_len = 0;
 		mbox_cmd.recv_status = 0;
 		mbox_cmd.fn = NULL;
-		mbox_cmd.fn_arg = 0;
+		mbox_cmd.fn_arg = NULL;
 		ether_addr_copy(mbox_cmd.msg.s.params, mac);
 		mbox_cmd.q_no = vfidx * oct->sriov_info.rings_per_vf;
 		octeon_mbox_write(oct, &mbox_cmd);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index e97e675..9b7819f 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2907,7 +2907,7 @@ static int liquidio_set_vf_spoofchk(struct net_device *netdev, int vfidx,
 	nctrl.ncmd.s.param2 = enable;
 	nctrl.ncmd.s.more = 0;
 	nctrl.iq_no = lio->linfo.txpciq[0].s.q_no;
-	nctrl.cb_fn = 0;
+	nctrl.cb_fn = NULL;
 
 	retval = octnet_send_nic_ctrl_pkt(oct, &nctrl);
 
-- 
2.7.0


