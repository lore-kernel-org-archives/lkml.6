Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AACC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181BC2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uOFlAj28";
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="AT5RQ/KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181BC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeJAQY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:24:58 -0400
Received: from forward102o.mail.yandex.net ([37.140.190.182]:55596 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728960AbeJAQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:24:57 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 12:24:56 EDT
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::22])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id F110D5A06210;
        Mon,  1 Oct 2018 12:42:55 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback8o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kW5jswQbbu-gtbe3Aog;
        Mon, 01 Oct 2018 12:42:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538386975;
        bh=xPz+Axc9rnNlHGWdMeK6XTKHuOrJcwkquWajQiPmZMs=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=uOFlAj28H7CVVCpLkxxsaA7qTx8rtcVy/EYTP1cxtA0+X+yIpnC4s3w7Z0iMtcEAk
         1oFbKxrxfbMujP+dnrlQraBqv9pLl4sseKHfSHQfFLD3lVc3dY1UsfrsawjjbQkOQn
         wN5dFogsv+CMqC/2H2OY/pnzbUQNIWRQ8XSCGfw8=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id cZBSEKZZGz-gs1WGwl7;
        Mon, 01 Oct 2018 12:42:54 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538386974;
        bh=xPz+Axc9rnNlHGWdMeK6XTKHuOrJcwkquWajQiPmZMs=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=AT5RQ/KFOHCK3+NoIiT2iTboG8EzMm/vOsBjdvT8l1qXO1AVkA3c0sDkHeUbh7MR0
         4CJPTdWzhm0amm19w1xIb7ogT8hHDSXpM3nsUgIKMaGfHlcXLsQhH0BXEdveqpnZhQ
         NB3NgvXwskosdeYiqQYVxDaGKNnOwsBLt+tSkgTE=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
From:   Andrey Abramov <st5pub@yandex.ru>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Andrey Abramov <st5pub@yandex.ru>
Subject: [PATCH] Staging: media: replaced deprecated probe method
Date:   Mon,  1 Oct 2018 12:42:29 +0300
Message-Id: <20181001094229.9148-1-st5pub@yandex.ru>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced i2c_driver::probe with i2c_driver::probe_new,
	because documentation says that probe method is "soon to be deprecated".
And fixed problems of the previous attempt.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 drivers/staging/media/bcm2048/radio-bcm2048.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
index a90b2eb112f9..6865e9fb6420 100644
--- a/drivers/staging/media/bcm2048/radio-bcm2048.c
+++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
@@ -2574,8 +2574,7 @@ static const struct video_device bcm2048_viddev_template = {
 /*
  *	I2C driver interface
  */
-static int bcm2048_i2c_driver_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int bcm2048_i2c_driver_probe(struct i2c_client *client)
 {
 	struct bcm2048_device *bdev;
 	int err;
@@ -2679,7 +2678,7 @@ static struct i2c_driver bcm2048_i2c_driver = {
 	.driver		= {
 		.name	= BCM2048_DRIVER_NAME,
 	},
-	.probe		= bcm2048_i2c_driver_probe,
+	.probe_new	= bcm2048_i2c_driver_probe,
 	.remove		= bcm2048_i2c_driver_remove,
 	.id_table	= bcm2048_id,
 };
-- 
2.19.0

