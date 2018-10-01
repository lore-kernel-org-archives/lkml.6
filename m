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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC08C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0162089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BPxfw45Q";
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QhlisunV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0162089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJAQxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:53:45 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:46577 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728823AbeJAQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:53:44 -0400
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 4E9574083ABA;
        Mon,  1 Oct 2018 13:16:38 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 347R6Fl1sS-Gbouu7o2;
        Mon, 01 Oct 2018 13:16:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538388998;
        bh=kOq2Qu0FFYddShqtznwMpnOXFc/E8De1RDXjwDNb/3Q=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=BPxfw45QctdRYcFVenNSVlAchnE48j7xHj5vdgkNV3vQS71l9K3/2PlObSWjApqi8
         J0bg1Uopft4dSH0J1ZyBOGHCBkhtx7MnT5Gn9gyjE+1Sqet7Y8/4wxpDXOjKwLy28j
         lpZW7oB5yxRtNHAkLPYs2PQTnPdwCXNCu7cSINi0=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id gjR3ALARCt-Ga1K0Cbw;
        Mon, 01 Oct 2018 13:16:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538388996;
        bh=kOq2Qu0FFYddShqtznwMpnOXFc/E8De1RDXjwDNb/3Q=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=QhlisunV6IMMb5f7hDt9YpCE1lqrORVB69CksijG2hMSiejEIyvENAuRFj5iOegyS
         wV4g4MHynyn5BsJSZmo1jr1Q9m9QFm8qxqyYhurSSI9Wqx68AVh+dI0fBHk670ofhj
         67vF326y0w9mt2xksl26Cs+4+7ZjN+OoTG62rCOk=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
From:   Andrey Abramov <st5pub@yandex.ru>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Andrey Abramov <st5pub@yandex.ru>
Subject: [PATCH v3] Staging: media: replace deprecated probe method
Date:   Mon,  1 Oct 2018 13:15:31 +0300
Message-Id: <20181001101531.12596-1-st5pub@yandex.ru>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced i2c_driver::probe with i2c_driver::probe_new,
	because documentation says that probe method is "soon to be deprecated".

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
v3:  fix commit message

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

