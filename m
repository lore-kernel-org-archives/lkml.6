Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeCUOaT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:19 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37010 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeCUOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:08 -0400
X-Google-Smtp-Source: AG47ELvhaJF2YgBMaAPJdVt20LEvGd90iJCAl9BJmbaL06KqDuddSKBmGctbDcjDicP1mAzTnotTJw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 04/11] staging: iio: ad7746: Reorder variable declarations
Date: Wed, 21 Mar 2018 11:28:52 -0300
Message-Id: <1521642539-4845-5-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder some variable declarations in an inverse-pyramid scheme.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 86919e8..57623db 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -220,8 +220,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan)
 {
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, delay, idx;
 	u8 vt_setup, cap_setup;
+	int ret, delay, idx;
 
 	switch (chan->type) {
 	case IIO_CAPACITANCE:
@@ -289,8 +289,8 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	bool doit;
 	int ret, timeout = 10;
+	bool doit;
 
 	ret = strtobool(buf, &doit);
 	if (ret < 0)
@@ -681,8 +681,8 @@ static int ad7746_probe(struct i2c_client *client,
 	struct ad7746_platform_data *pdata = client->dev.platform_data;
 	struct ad7746_chip_info *chip;
 	struct iio_dev *indio_dev;
-	int ret = 0;
 	unsigned char regval = 0;
+	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
-- 
2.7.4
