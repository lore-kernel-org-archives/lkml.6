Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA5B24D87
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA5B24D87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeGCHEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:20 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:55142 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbeGCHD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:03:58 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 3818C41C55; Tue,  3 Jul 2018 09:03:48 +0200 (CEST)
Message-Id: <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Tue, 3 Jul 2018 08:06:57 +0200
Subject: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, nv@vosn.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct i2c_device_id argument of probe() is not used, so use probe_new()
instead.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 163f7ec189b0..2bc54a5a2c96 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
-static int st_accel_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+static int st_accel_i2c_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
@@ -182,7 +181,7 @@ static struct i2c_driver st_accel_driver = {
 		.of_match_table = of_match_ptr(st_accel_of_match),
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
-	.probe = st_accel_i2c_probe,
+	.probe_new = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
 	.id_table = st_accel_id_table,
 };
-- 
2.17.1

