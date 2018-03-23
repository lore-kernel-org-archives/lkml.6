Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1421790-1521815244-2-13416237785063897786
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rocaen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521815244; b=NAcD29g6L7sbr8hBi/gIqCx6RT/Hle9fjkLICx9H076egFN
    naFaIPaWt4LS9WXyoM5cZExlnOzaJDio7FawFQwna2u5Sotr5xAXOEyN/A4JOLfT
    J3voGgmBqvoF0r3YdWSwnfrgqqVkVQGR+1n/g9Cuo3GoSKUr6ZNHZQgoShJT9jRM
    Gu4m4juOXlbCNjyV2WoLlXLnKHE4q/br0Ckc370WFzZOY4afeffhTECfXqVjqpMm
    loCLK8RSJUMEjk+uZkz+JoOg9mNFahFCcHWjjndUMDDKIyBNPdJ5uR3JJcE4yw7a
    LXp8YCJdw5g9dVwNs6BEjklvBw2EQW0hLK8DlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521815244; bh=r
    xqNek8f+93mkF3Udo/iA9rn/7qLIivH/I8PBrgzsOA=; b=IJP5Ubk2sgUzjghD/
    exMoK7doQJgvwNDPC4Fp5gYrfH009uXkTCY0Itsl2PKusXMg70v//rIIBaTICdCB
    lVufjblbgH3pBaulEKJ0a16118QUqTd/lv9ZHS4gD0517NIwsC+ld1NKkyYPR7Ur
    UDoPpmvWinAp2Wh6npeX+ZpwFuKMWBqkoL4TWJUucMvWmI2KwYOGCdJjFSr2JLhm
    CrRqhD4O0rz6NfPTTxacFkcqwFNeyTQffWIHv2BlduqSeAQLSghwnmDvUbx4dsnn
    hoOcRlmDrwHnyOfq/KGCeEvOc+P4jys2E0k41yBKJ7LCwwLJh6Us5gIBwxb8jr4y
    RYYDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J5owWWiq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pqSNZC9d;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J5owWWiq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pqSNZC9d;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvY1zdXGIEU8H+ldj90C1t9r0qAGZXP0DoOkqaeU2kCrVAEc/UGZtPZWX0Te6zGLcaZI2ggBg==
Date: Fri, 23 Mar 2018 11:27:12 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 7/8] staging:iio:ade7854: Rework SPI read function
Message-ID: <960df20b2a51e6517e9ccef2b5486ee116f35ba4.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
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
Changes in v3:
 - Remove the use of defines that not improve the readability
 - Replace variable name "bytes" for "bits"
 - Update commit message

 drivers/staging/iio/meter/ade7854-spi.c | 136 ++++++++------------------------
 1 file changed, 33 insertions(+), 103 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index be7397042850..ee6e4d166ece 100644
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
+				int bits)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -82,7 +83,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 1,
+			.len = bits,
 		}
 	};
 
@@ -94,128 +95,57 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
+		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
 			reg_address);
-		goto error_ret;
+		goto unlock;
+	}
+
+	switch (bits) {
+	case 8:
+		*val = st->rx[0];
+		break;
+	case 16:
+		*val = be16_to_cpup((const __be16 *)st->rx);
+		break;
+	case 24:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case 32:
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
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 8);
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
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 16);
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
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 24);
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
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 32);
 }
 
 static int ade7854_spi_probe(struct spi_device *spi)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
