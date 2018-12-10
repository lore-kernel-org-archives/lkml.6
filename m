Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A602C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A1E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeLJL0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:26:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeLJL0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:26:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0CFA48DC86A89;
        Mon, 10 Dec 2018 19:26:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Dec 2018
 19:26:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <pabeni@redhat.com>, <idosch@mellanox.com>,
        <ktkhai@virtuozzo.com>, <lucien.xin@gmail.com>,
        <petrm@mellanox.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ipvlan: Remove a useless comparison
Date:   Mon, 10 Dec 2018 19:25:38 +0800
Message-ID: <20181210112538.16324-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following gcc warning:

drivers/net/ipvlan/ipvlan_main.c:543:12: warning:
 comparison is always false due to limited range of data type [-Wtype-limits]

'mode' is a u16 variable, IPVLAN_MODE_L2 is zero,
the comparison is always false

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 4a94956..162a337 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -535,7 +535,7 @@ static int ipvlan_nl_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (data[IFLA_IPVLAN_MODE]) {
 		u16 mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
 
-		if (mode < IPVLAN_MODE_L2 || mode >= IPVLAN_MODE_MAX)
+		if (mode >= IPVLAN_MODE_MAX)
 			return -EINVAL;
 	}
 	if (data[IFLA_IPVLAN_FLAGS]) {
-- 
2.7.0


