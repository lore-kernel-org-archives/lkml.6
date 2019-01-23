Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CE4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfAWORx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:17:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfAWORx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:17:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E1E152EFD6EBAAE231C;
        Wed, 23 Jan 2019 22:17:50 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 22:17:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 1/2] usb: ftdi-elan: remove a unnecessary variable 'empty_packets'
Date:   Wed, 23 Jan 2019 22:16:56 +0800
Message-ID: <20190123141657.8308-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190123141657.8308-1-yuehaibing@huawei.com>
References: <20190123141657.8308-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'empty_packets' does not used in any other places
except for self increment, so it can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/misc/ftdi-elan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 76c718a..b2b05c9 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -915,7 +915,6 @@ static int ftdi_elan_respond_engine(struct usb_ftdi *ftdi)
 	int bytes_read = 0;
 	int retry_on_empty = 1;
 	int retry_on_timeout = 3;
-	int empty_packets = 0;
 read:{
 		int packet_bytes = 0;
 		int retval = usb_bulk_msg(ftdi->udev,
@@ -963,7 +962,6 @@ read:{
 		} else if (packet_bytes == 2) {
 			unsigned char s0 = ftdi->bulk_in_buffer[0];
 			unsigned char s1 = ftdi->bulk_in_buffer[1];
-			empty_packets += 1;
 			if (s0 == 0x31 && s1 == 0x60) {
 				if (retry_on_empty-- > 0) {
 					goto more;
-- 
2.7.0


