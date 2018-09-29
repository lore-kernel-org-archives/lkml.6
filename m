Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A287BC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4908021502
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sEdc+qK/";
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aXYk92La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4908021502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeI3BWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:22:01 -0400
Received: from forward100j.mail.yandex.net ([5.45.198.240]:55762 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbeI3BWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:22:01 -0400
Received: from mxback6j.mail.yandex.net (mxback6j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10f])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id B799F5D85CF5;
        Sat, 29 Sep 2018 21:52:26 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback6j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kPwK8j4bPW-qQZKlKk4;
        Sat, 29 Sep 2018 21:52:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538247146;
        bh=WUi1ueU8hOsgoaKf8dMcW0fLcw94VO/x3lPCnDetNms=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=sEdc+qK/sZrCCK6OtmH3QCFMzzA4ElKJwCzUlkCVml2YgUgwwk7DZ0+lJM9Q12Yfa
         4VSKVgZ2TmKpZcI8UqS8FVGpWNLtLqX2bVbIakZ3LiHuyE/G2GWOeMzqXd0BisiRvA
         2XTTAnnddxSQYOdOerDsYV9Z9BKGlSKVBFFO0wYM=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6U6u8UHQAn-qPXWVCqZ;
        Sat, 29 Sep 2018 21:52:25 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538247145;
        bh=WUi1ueU8hOsgoaKf8dMcW0fLcw94VO/x3lPCnDetNms=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=aXYk92LapfQNMxf0cOK0AhodM5N3QeG/R2qB3vRPFbwo/+ML3+S97RGom13mdi70I
         0mknu99oXhXyhQCe12/z8n9KPsvoAXbVuMuMipvvDPhsRFdizQyRccQUwUpAA3xbuq
         WBrgiDKlEoc4ySL1JEiKmgHmTHcFhvaD2diCiNeI=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
From:   Andrey Abramov <st5pub@yandex.ru>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Andrey Abramov <st5pub@yandex.ru>
Subject: [PATCH] Staging: media: replaced deprecated probe method
Date:   Sat, 29 Sep 2018 21:51:50 +0300
Message-Id: <20180929185150.16657-1-st5pub@yandex.ru>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/media/bcm2048/radio-bcm2048.c replaced i2c_driver::probe with i2c_driver::probe_new, because documentation says that i2c_driver::probe "soon to be deprecated"

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 drivers/staging/media/bcm2048/radio-bcm2048.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
index a90b2eb112f9..756f7f08c713 100644
--- a/drivers/staging/media/bcm2048/radio-bcm2048.c
+++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
@@ -2574,8 +2574,7 @@ static const struct video_device bcm2048_viddev_template = {
 /*
  *	I2C driver interface
  */
-static int bcm2048_i2c_driver_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int bcm2048_i2c_driver_probe_new(struct i2c_client *client)
 {
 	struct bcm2048_device *bdev;
 	int err;
@@ -2679,7 +2678,7 @@ static struct i2c_driver bcm2048_i2c_driver = {
 	.driver		= {
 		.name	= BCM2048_DRIVER_NAME,
 	},
-	.probe		= bcm2048_i2c_driver_probe,
+	.probe_new	= bcm2048_i2c_driver_probe_new,
 	.remove		= bcm2048_i2c_driver_remove,
 	.id_table	= bcm2048_id,
 };
-- 
2.19.0

