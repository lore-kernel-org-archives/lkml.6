Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeAaVLX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:11:23 -0500
Received: from mout.web.de ([212.227.15.14]:54978 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbeAaVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:11:21 -0500
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Simran Singhal <singhalsimran0@gmail.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/adc: Delete an error message for a failed memory
 allocation in two functions
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <0a3e6b48-f837-ce30-4adf-28ce5d885c24@users.sourceforge.net>
Date: Wed, 31 Jan 2018 22:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:g0/NI6b03TZYNm6U6xbd0V5Vp8r3MvL/4mqzE2XwHfGFqy/byH/
 N4lx00TmQMaG52qjuTlY0KZ0fT7IpqGBxlZHGAmmya7WHYTxBz+Dgx8I4kC1ACJQ2Ei1YV3
 LW3CmZsOHsueZ3Wpj4Ew60crMS9StURYlmmI262c+dnU+1nKkk3RtGYfCz8fpuL7nVYJ2qq
 SLVP3+n/ps2oIa1+//cgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4/NfD6kdT1M=:fmcqp0Aiwnw8uP9usov19i
 /Ijtge2UdZyfKT6BoTUiPYu0IS74tyyVmuY3hQ6lMNNs7lmHr2bAk0hmE0wqvjmPloBbO0qYw
 aeuW1Y2YCVw8xlQikHdUgc7k0MrYQqhBhlFdTDgvGOlxCwTthKecCXlMD32+YZWnGotQUaGKr
 IVvMzv4LQA7nDcGxolX1WyehxLlWsQuvOJSLEn6sxUlP+IR5f7U+P2YBU3FNyFeOQA9SsEHgK
 dFP9xGyiFMXoDgXZuaEEcM8M46EstxQxhXIO5UV9ZjMtQ/jODo06lfjqauCnrdQSxt2s1huyF
 qNGaQVIlVfUAaNGEHvWbm54CVhmhN+ket4SM9yolNaO8KpQLy/v847Ulm7CKajhNr3XaBHHiX
 JtK5fva3zaUlIc5RChz2jeM2oCgVzWZlu1Jt9uYkCWffE1oanOVz+t2bJKya+5T0ZXJH+VM7r
 WN8EZrbdmYUMgN1VgH5miOUZSRVU7xMRA+yk9RBNYkNoBOqJEj3K829O/5kdjMWsJsP4WFYvr
 gsfQclpypBrxKyUnnXzPFIEMQ7OhHYlXHHtE0Q49eBX4Q0fR/uakORxRXdnbgQR07rRUiiGAO
 Tbbwz8G5N97LVaOWMrh70q0KrdrIq369p0Fb78Z5ZpJe19/0WNinpp0xDTAa5zHItU1ZRtuOe
 /0rUwQ3YdK9tIKpgjW0VV2bpGjzhjJiTONxkfX9DXdQjpXGX3NjWiCN+a5vUsie4xPpl4TnP2
 2cN+m/HMtB2lmDwg2p3XBErWTML7yeMzhmzjB8vnY7bSh7OVPNik5roh/+YO4aje1jrqog5SK
 msIvR6K1pxKKQol1HUtNOoag6r/EuplC1xxq97Uw/lo6yeKUK8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:57:50 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/at91_adc.c | 1 -
 drivers/iio/adc/max1027.c  | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3836d4222a3e..ce37cfeb8d1c 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -912,7 +912,6 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 					sizeof(struct at91_adc_trigger),
 					GFP_KERNEL);
 	if (!st->trigger_list) {
-		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
 		ret = -ENOMEM;
 		goto error_ret;
 	}
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 375da6491499..74b305c775f2 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -425,10 +425,8 @@ static int max1027_probe(struct spi_device *spi)
 	st->buffer = devm_kmalloc(&indio_dev->dev,
 				  indio_dev->num_channels * 2,
 				  GFP_KERNEL);
-	if (st->buffer == NULL) {
-		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
+	if (!st->buffer)
 		return -ENOMEM;
-	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
 					 &max1027_trigger_handler, NULL);
-- 
2.16.1
