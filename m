Return-Path: <himanshujha199640@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520236198; cv=none;
        d=google.com; s=arc-20160816;
        b=zRrk6oSY40clF7EYnV3wAWN0lgMlVT+pcnTkJEy7MlAz5w8UBmHSahuq9G8FWmumQw
         cAFDllqDM+7qiZ5NpHJlfF/YoIxsDPgGdmuJM45kCHDi2STdnz7R5aC23CEGTPAZU2Y9
         /ZPr521j0yeisW31g+3iYzYlA2IJdVFaFtyYn0TTKKuGltyQ8zCHEFeOSbCXdQ1nRPC9
         bFVzJRIpB4eUM8o8U14uAMwzeSTI/KLrDC6/FcEy316Pm46jRD5LwfmAb+RY6g/cLpd8
         MboolIizuhQ8uyaB19hzgca0jA95FrnafRMhsLkFHiadw2prnzcjdoo2i2MFb4t9RQuD
         fx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5teCbeC4EmSOv+0bVA4kD/UJB0m0g4d9CzKR+2K4Vxs=;
        b=JDUuUDbZJTys9fpMW/+mATG3cZgtGSdYCba4Laz4+v1Yrj6YfRVlIJ47daycMHwwgp
         IxCScM1ClrGS554PJIh7Gxt7Ox4ObpuHhK+b0Bo4P8n+5zIghW/FnoB+v1IO4xbCmmqV
         y1fH/J0UrTOxL2n42dxXKSqzZusikj85jNmr4OOaBKQV7s97lGluq/HtB2rnUqEBbxHN
         FSd0ZdE5NyzNQav4Jt8ghb65P1KJivYRmmg8HRIxKjZUcsXz6uW0HhG5XPZr75nR4Myk
         MDAGpJ53SmPFpWpMo+BsiQkBFNlec3m6PHqi5JcOYvhvdG8jELINjIO7WxjLjyP2rZYs
         zVwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RADKJntp;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RADKJntp;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvmYjJEAlLO4zo7RQTsCiqVlLfvUaZFNbAFmZtyX8/PoFxIlJ/Dv7jRTh26bfTNBvlZf3G+mw==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 02/11] Staging: iio: accel: Add a blank space before returns
Date: Mon,  5 Mar 2018 13:19:21 +0530
Message-Id: <1520236170-14668-3-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083192660121892?=
X-GMAIL-MSGID: =?utf-8?q?1594083192660121892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding a blank space before/after some returns improves readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0f6a204..0fae8aa 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -232,6 +232,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		return IIO_VAL_INT;
 	}
+
 	return -EINVAL;
 }
 
@@ -262,6 +263,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 		addr = adis16201_addresses[chan->scan_index];
 		return adis_write_reg_16(st, addr, val16);
 	}
+
 	return -EINVAL;
 }
 
@@ -336,6 +338,7 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = adis_init(st, indio_dev, spi, &adis16201_data);
 	if (ret)
 		return ret;
+
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
@@ -348,6 +351,7 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_cleanup_buffer_trigger;
+
 	return 0;
 
 error_cleanup_buffer_trigger:
-- 
2.7.4
