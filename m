Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3481C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DCE2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DCE2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeI2DvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:51:21 -0400
Received: from mail.ispras.ru ([83.149.199.45]:40028 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeI2DvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:51:21 -0400
Received: from localhost.localdomain (unknown [85.140.181.162])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2C6A554006A;
        Sat, 29 Sep 2018 00:25:43 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacob Feder <jacobsfeder@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] staging: axis-fifo: add error handling of class_create()
Date:   Sat, 29 Sep 2018 00:25:27 +0300
Message-Id: <1538169927-26267-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/staging/axis-fifo/axis-fifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index abeee0ecc122..63c8efd1b8db 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -1089,6 +1089,8 @@ static int __init axis_fifo_init(void)
 	pr_info("axis-fifo driver loaded with parameters read_timeout = %i, write_timeout = %i\n",
 		read_timeout, write_timeout);
 	axis_fifo_driver_class = class_create(THIS_MODULE, DRIVER_NAME);
+	if (IS_ERR(axis_fifo_driver_class))
+		return PTR_ERR(axis_fifo_driver_class);
 	return platform_driver_register(&axis_fifo_driver);
 }
 
-- 
2.7.4

