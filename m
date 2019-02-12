Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7668F217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfBLGDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:03:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:49157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfBLGDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:03:50 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LtrKX-1h3eHb16SD-011BkY; Tue, 12 Feb 2019 07:03:43 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] mei: expand minor range when registering chrdev region
Date:   Tue, 12 Feb 2019 14:02:52 +0800
Message-Id: <20190212060252.8948-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AFEpkk746hQ1g1EnyQqapKfE5WRcSJSYixM6Mildc9CVtEJe778
 JfueeGaSJ8Bv7m9ddB2P7fvWQeuNcdZtq94BZUin540+YB959ReZYdL6kHkPzYtEcEosrJR
 eR12dKL1P48noxxnxsmfUUzLn9QFGBrfCtMpoTvp8/HoQQFs918TXXZ+rw0HenO/a8OKwJH
 LW5J2YOxyGWTtZ2Xo4B8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tA3JTLIhUes=:NwPOKHTQhRodzWs9+SOHXg
 mtSxPS4enii3HtSLX9Uis6UWoELOJCGlHUywnAcVLY7L+P6UDTUqlKJ/6qOw9HdfyozKetOQP
 ZNyjkvmAFYC+t1njvzRjZ3RT4XWpA1b5xtbywVW2zO7S7XR8cydQxxj7B9AzTFmeg8Kybieg1
 SQNXcdpzO3orGRaOHSj3bTxE/5IiYNQiyq8bIaM+DpSGcA+IAJ1eEpyycgC1pDFLO3kPo3a8S
 G16ziEqrl0PCU4rGMJ9iO2hqLFnYMBTuMtwCxv3Ec/Gs5mWuJUJ9h9jghF7rFF7ZRxbQs7yx9
 4rfuqPxerxJv9paa/wWl+YFE6TkaQS27aMiDDDvLLR9PgN7vfhWPn6LmcetdojyqNIju/WaNp
 vDODz5HUmdr3WH5mb4jPL8lA7pVWxtGMwe9uJ/EOsy1G41SO5v953jr8Ib9pgrjsUeoOlmCMg
 mkW+Qn5dAzhdyzI297Hwuk1dFYYKjl64Ybg7cYhLn9MDjfvu4/RPCu90i2YxwScqJ84iJbgTw
 49Q7luKS1iMNblIMs2u/JnPvBRZMAOy5iIWcLyi7z6sECJKQ9qGH7yFeHEEopz04b6zaFjSEx
 ts+7+pjQRvGRbv95R7irfi+K4lPb6rRbK5q07qfD5J+xKYXy6/A75sV2FeeuyfZCnn0WmMaR9
 JMrQCO4Lyr+8EDrvqlrTOSzRE9ocAzX/cFL7YjuxXJhI2t+/YSlMQZFssiQifxSSDJX55lT64
 YWfXqlNLAlRKahbivmQPUf9+rMJ/DF7pJorlXh7RK17hJGvEwbh5vc27Fy7XjLzI2onkVcA2H
 V0nRWRX982QUeRRTPT4Y1nwPZwiJPBV05P2bUqnULtukX2oP8vpUs4rfLjC7xU/FHfmeLy70L
 HovxADEHf3EFCDv2zMBtbuj2l0Lt5WXRrBfor0YrORYVCsYpaoR29c4xfouuLT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, total amount of available minor number
for a single major is MINORMARK + 1. So expand
minor range when registering chrdev region.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 87281b3695e6..3df54f1e1a8b 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -869,7 +869,7 @@ static const struct file_operations mei_fops = {
 
 static struct class *mei_class;
 static dev_t mei_devt;
-#define MEI_MAX_DEVS  MINORMASK
+#define MEI_MAX_DEVS  (MINORMASK + 1)
 static DEFINE_MUTEX(mei_minor_lock);
 static DEFINE_IDR(mei_idr);
 
-- 
2.20.1

