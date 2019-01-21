Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838DC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC872084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfAUHrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:47:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfAUHrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:47:33 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7977AD2FDF0DF61B7443;
        Mon, 21 Jan 2019 15:47:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Jan 2019 15:47:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: rtl8712: drop pointless static qualifier in r8712_efuse_pg_packet_write()
Date:   Mon, 21 Jan 2019 07:53:13 +0000
Message-ID: <1548057193-130411-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'intrepeat_times' variable static since new
value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8712/rtl8712_efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index 8bc45ff..39eb743 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -358,7 +358,7 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
 	u8 pg_header = 0;
 	u16 efuse_addr = 0, curr_size = 0;
 	u8 efuse_data, target_word_cnts = 0;
-	static int repeat_times;
+	int repeat_times;
 	int sub_repeat;
 	u8 bResult = true;
 





