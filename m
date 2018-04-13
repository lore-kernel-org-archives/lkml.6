Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637495; cv=none;
        d=google.com; s=arc-20160816;
        b=Mrq+DWMSYA89by3lR80bFi24P5h3Z1zW31yKvlITt6BbE64R7HeW3lYh405KjCtpLF
         EhwNnFKaVqzfvWTNu+9g1D+xIQFh+ShjM62urEvMJkeVgbRdkvfuwOv8rvLlrU0OW4He
         HvBmLM6Y3Z2VJmcOQ+A4/+bm0cMXOOWmpHO4tE1Wrnys3WLIKGmA7bc8nqX/3rN1Yhv5
         KmFzLQ1Mx883W8DUWr4eG1v4AO1OVpjbjMODCJVG5PUz691v4NSWXLJSXknFhhEgdVOs
         8MIhwGKhd+I4GMPOTaXihtCLI3JYhxfX3ak5sNovEyb3pujeOyYZTay9sqzj5typ+UhW
         q5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=eCgSdFgwB255m0N9UHOWkjZkqY+jO5YLR8ayCqttdPc=;
        b=blZZgb2RIWGe0n1X9i8KC5mAchkYx7W6gESiIRDz45WoQzZz9jb+uRO+YdeUX7UV7u
         +0y027CVBqCTIAtuuw4m1AAspe+rgXUBcLqrghx0yJNMBNf2NLIeGN2hrSC3Ge9oeAUa
         GE6sajQRHK1kEGLnoPk3YphwGLkl88xOmS3kjh+TTbcvu9QjrYqzyaWRdgqD3iLP+1Pk
         HSKd2VC/WIJb/uZ6nSQYeoD5AUXLqJXHGPmjTl3NBkYP1DNiIJN78Q70rh6eWV8JKBnu
         RiSmQXHYfIcnGTOCK2VgBh1ClVJCLRs0+fZL3i2cjowy5v8Z/qSJiqUtT+T7JEEVCD80
         c0dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=YMuLbwf0;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=YMuLbwf0;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx4/w4j8gHE7QkYcCphnPE54niWE27cjV9nAHP8adE6vpjDLXx8gPnktIEvFvxAyQHuFxzzopfg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 06/14] staging: iio: ad7746: Reorder variable declarations
Date: Fri, 13 Apr 2018 13:36:43 -0300
Message-Id: <1523637411-8531-7-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649710321213681?=
X-GMAIL-MSGID: =?utf-8?q?1597649710321213681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reorder some variable declarations in an inverse-pyramid scheme.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 9ef476a..f53612a 100644
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
@@ -680,8 +680,8 @@ static int ad7746_probe(struct i2c_client *client,
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
