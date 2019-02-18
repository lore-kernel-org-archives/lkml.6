Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D826CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A06217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfBRMUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:20:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfBRMUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:20:23 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D18CF395B8F3BC3F6F01;
        Mon, 18 Feb 2019 20:20:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 20:20:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Colin Ian King" <colin.king@canonical.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: rtl8192e: Remove set but not used variables 'broad_addr, stype'
Date:   Mon, 18 Feb 2019 12:33:59 +0000
Message-ID: <20190218123359.83746-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8192e/rtl8192e/rtl_core.c: In function '_rtl92e_tx':
drivers/staging/rtl8192e/rtl8192e/rtl_core.c:1732:28: warning:
 variable 'broad_addr' set but not used [-Wunused-but-set-variable]

drivers/staging/rtl8192e/rtl8192e/rtl_core.c:1731:24: warning:
 variable 'stype' set but not used [-Wunused-but-set-variable]

They're never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c145b689175c..ddf3ee71a632 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1728,8 +1728,8 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 				    MAX_DEV_ADDR_SIZE);
 	struct tx_desc *pdesc = NULL;
 	struct rtllib_hdr_1addr *header = NULL;
-	u16 fc = 0, type = 0, stype = 0;
-	bool  multi_addr = false, broad_addr = false, uni_addr = false;
+	u16 fc = 0, type = 0;
+	bool  multi_addr = false, uni_addr = false;
 	u8 *pda_addr = NULL;
 	int   idx;
 	u32 fwinfo_size = 0;
@@ -1747,11 +1747,10 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	header = (struct rtllib_hdr_1addr *)(((u8 *)skb->data) + fwinfo_size);
 	fc = le16_to_cpu(header->frame_ctl);
 	type = WLAN_FC_GET_TYPE(fc);
-	stype = WLAN_FC_GET_STYPE(fc);
 	pda_addr = header->addr1;
 
 	if (is_broadcast_ether_addr(pda_addr))
-		broad_addr = true;
+		;
 	else if (is_multicast_ether_addr(pda_addr))
 		multi_addr = true;
 	else



