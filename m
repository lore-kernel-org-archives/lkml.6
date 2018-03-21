Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeCUOae (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42804 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeCUOaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:25 -0400
X-Google-Smtp-Source: AG47ELvnorIiUXjDhQso4FS6aJNbLVCqMTHwFKbbKvN29fyyMa6Xkl+3FqhVdmXFoiAlgmEurxJGOg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 07/11] staging: iio: ad7746: Add remove()
Date: Wed, 21 Mar 2018 11:28:55 -0300
Message-Id: <1521642539-4845-8-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the driver to be probed and removed as a module.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 815573c..8abba71 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -768,6 +768,15 @@ static int ad7746_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int ad7746_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
 static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7745", 7745 },
 	{ "ad7746", 7746 },
@@ -792,6 +801,7 @@ static struct i2c_driver ad7746_driver = {
 		.of_match_table = of_match_ptr(ad7746_of_match),
 	},
 	.probe = ad7746_probe,
+	.remove = ad7746_remove,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
-- 
2.7.4
