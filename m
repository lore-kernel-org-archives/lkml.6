Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4140376-1521240578-2-9239544567493861790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rocask.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240577; b=PXfK17zwan9ugwRaJe2yPx4EPas52x5E+D9YMaomoQsJHX9
    oHLaYiyCeYMNiU5RZwgr6BjDwZzxCoUqBUUtfAqnqU0b0LVcNHiGPQ3S6JOAkHup
    ZChBUIZTpDKmJqN6XYqo4MUWzuT24qoS9RuKhFCoZzPpGwShO5EtEviU9h5SM06s
    NoHmm+XGTO8pHUIsjzFxAQp52nmOGKGHLrMbX1y2TzwraKHUahK8l7Z2y6AE49wV
    EYdmRz1TerVAwk0h8oA7bGMiUdo+cIw0OW6CXfhBFAngIS5uHD7gX+5L07itS2t7
    9xkhmHZVfT8jlwiu5mSGgVYykIMw6PZ9efzj++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521240577; bh=A
    2mDlj5z2t4MF6hVwCzv9kfT+A92GnBePFSZEjpfhcs=; b=dL7f3KRRHv1+bRBtM
    qJ3l4NBNlkokmDN/xHR9HbLoyLeEPyZIRUJtcLCRGrIXDci+S7ryLHOEePcEm9FP
    NVok1CewzPoXDqRnOddxq+e/yLtQjEvZN+i3hbxttFEM/tW4sdcUEGpZ3693OqPu
    Cem8H7GIwVP5w4JicsePZ5yFUJ5aZgLF3ato+6R4J6G84LEDrBvqxYd8Od07sqBD
    VyYH1bnUO4J0PAexFda5G/zE4ERrdOIV7SfkvZfdJGXtVGw7LVQTBlI11yOwBRSq
    luu8Zi+4zqXLik8Pw6xP+Vq1fmNmziM1d+bp/oRh5ILcdb3aXFgZD4cUHXOHFZG/
    ZtsFw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J7ngZpci x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=isjhVe1R;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J7ngZpci x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=isjhVe1R;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsFN5tTN3nXG/9DY/YBznd+cof6DBTnTOe/OjwLHHpt5H/2oAwixraxiFYPuGDaIYGPatq7pg==
Date: Fri, 16 Mar 2018 19:49:24 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 4/8] staging:iio:ade7854: Rework SPI write function
Message-ID: <66ce9378178c994eb64d19ba3cccc5dbfc64e0ef.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180223
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The write operation using SPI has a many code duplications (similar to
I2C) and four different interfaces per data size. This patch introduces
a single function that centralizes the main task related to SPI.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-spi.c | 108 ++++++++++++--------------------
 1 file changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 4419b8f06197..f21dc24194fb 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -15,9 +15,10 @@
 #include <linux/iio/iio.h>
 #include "ade7854.h"
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
+static int ade7854_spi_write_reg(struct device *dev,
+				 u16 reg_address,
+				 u32 val,
+				 int bytes)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -32,93 +33,66 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = val & 0xFF;
+	switch (bytes) {
+	case DATA_SIZE_8_BITS:
+		st->tx[3] = val & 0xFF;
+		break;
+	case DATA_SIZE_16_BITS:
+		xfer.len = 5;
+		st->tx[3] = (val >> 8) & 0xFF;
+		st->tx[4] = val & 0xFF;
+		break;
+	case DATA_SIZE_24_BITS:
+		xfer.len = 6;
+		st->tx[3] = (val >> 16) & 0xFF;
+		st->tx[4] = (val >> 8) & 0xFF;
+		st->tx[5] = val & 0xFF;
+		break;
+	case DATA_SIZE_32_BITS:
+		xfer.len = 7;
+		st->tx[3] = (val >> 24) & 0xFF;
+		st->tx[4] = (val >> 16) & 0xFF;
+		st->tx[5] = (val >> 8) & 0xFF;
+		st->tx[6] = val & 0xFF;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
+unlock:
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
 }
 
+static int ade7854_spi_write_reg_8(struct device *dev,
+				   u16 reg_address,
+				   u8 val)
+{
+	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
+}
+
 static int ade7854_spi_write_reg_16(struct device *dev,
 				    u16 reg_address,
 				    u16 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 5,
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (val >> 8) & 0xFF;
-	st->tx[4] = val & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
+	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
 }
 
 static int ade7854_spi_write_reg_24(struct device *dev,
 				    u16 reg_address,
 				    u32 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 6,
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (val >> 16) & 0xFF;
-	st->tx[4] = (val >> 8) & 0xFF;
-	st->tx[5] = val & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
+	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
 }
 
 static int ade7854_spi_write_reg_32(struct device *dev,
 				    u16 reg_address,
 				    u32 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 7,
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (val >> 24) & 0xFF;
-	st->tx[4] = (val >> 16) & 0xFF;
-	st->tx[5] = (val >> 8) & 0xFF;
-	st->tx[6] = val & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
+	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
 }
 
 static int ade7854_spi_read_reg_8(struct device *dev,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
