Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4140376-1521240635-4-8194649791565875261
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rocaen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240634; b=Mq3EaE4t5JNb0L1OmYTkbpSTLJXvXpVXyNJqu7gj8RPBjrl
    vlBPz61lJkGw+lcyMVfa9wpm4MjaQWNZ6vKhySbVttTjj2dUfbxDnOnpXv4gDKlH
    vn2ZqeRSfAzAnp2xxQvAe7ppcZeeeI66HDd8k5JuzuZ5rO1B41qSGo60yvwL5YfX
    l4wa4aYU8CI6sg7o53RrUNLTQEGWhknv01fFGWoqFptDWwzv84aRfwg0z+50NGbI
    peoqJe1m8ATAFdDRc4+GvpidM38pFCrAhYMkeK6W0TYcsiS6/+xHfedbiEx522BQ
    Gi5zfFqAl78zjeIhWhlyeseATnJOcbXHSiA3fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521240634; bh=F
    pPFIpEW620YokEL8xZhCMmInHpaD4xSSu+zPdZTniQ=; b=EH7jfrioI+mBdJc6l
    u8z+UbfiDHbqFQ0BjZ4uybczPXlyP0+k8fBrdpguuAe0qrv9aeaxzx4CZhkzfw3U
    uliCRfofBKl3x/c7TkVhsFBi8g8nWErEO/SdOC+UZiJsy752HhfhiKJPIL8xcNm5
    6+ysKWkwBzG3go6JrLVoZymBqzZOzDtRsYmgjhUz0feu+H4lAW4NQXCmwfNI4FdF
    SCfO/2gJzt/WTHBRkhBv5GKVgr4Gu75oXtpMZOQMYFfllP46URXEnMhkSK4IDiup
    eVB19woDT3KUY8v9gFI2PBqVtC/Vx5f4j6upDe2rxVijLQnNbLn2BjLfkElvs6n2
    z7wuw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ng9FurRk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qUlYwIgX;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ng9FurRk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qUlYwIgX;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs5wWguEau65lZzYhzQa1TirPG45uDVvY/2Lo2HQFJO1I9dRkdCy0qXTbkFFONZSzuY86JrKw==
Date: Fri, 16 Mar 2018 19:50:15 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 7/8] staging:iio:ade7854: Rework SPI read function
Message-ID: <9aa718713752ddbc54b0ecdd8dad7fbe85854781.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

Rework read SPI function to reduce the code duplication and centralizes
all the task in a single function.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-spi.c | 140 +++++++++-----------------------
 1 file changed, 37 insertions(+), 103 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 1eba3044b86f..964d6c6e76d1 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -67,9 +67,10 @@ static int ade7854_spi_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
+static int ade7854_spi_read_reg(struct device *dev,
+				u16 reg_address,
+				u32 *val,
+				int bytes)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -82,7 +83,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 1,
+			.len = bytes,
 		}
 	};
 
@@ -94,128 +95,61 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
+		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
 			reg_address);
-		goto error_ret;
+		goto unlock;
+	}
+
+	switch (bytes) {
+	case DATA_SIZE_8_BITS:
+		*val = st->rx[0];
+		break;
+	case DATA_SIZE_16_BITS:
+		*val = be16_to_cpup((const __be16 *)st->rx);
+		break;
+	case DATA_SIZE_24_BITS:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case DATA_SIZE_32_BITS:
+		*val = be32_to_cpup((const __be32 *)st->rx);
+		break;
 	}
-	*val = st->rx[0];
 
-error_ret:
+unlock:
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
+static int ade7854_spi_read_reg_8(struct device *dev,
+				  u16 reg_address,
+				  u8 *val)
+{
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_8_BITS);
+}
+
 static int ade7854_spi_read_reg_16(struct device *dev,
 				   u16 reg_address,
 				   u16 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-		}
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
-			reg_address);
-		goto error_ret;
-	}
-	*val = be16_to_cpup((const __be16 *)st->rx);
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_16_BITS);
 }
 
 static int ade7854_spi_read_reg_24(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 3,
-		}
-	};
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
-			reg_address);
-		goto error_ret;
-	}
-	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_24_BITS);
 }
 
 static int ade7854_spi_read_reg_32(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 4,
-		}
-	};
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
-			reg_address);
-		goto error_ret;
-	}
-	*val = be32_to_cpup((const __be32 *)st->rx);
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_32_BITS);
 }
 
 static int ade7854_spi_probe(struct spi_device *spi)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
