Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2296092-1521051045-2-10706321823899643803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521051045; b=wKNSbenuVmmq284Us11J/6p7szz0xmoW/Phhe7O7dwpuR2H
    qyuNXYT4I28ZVv3pFsKme2uPEyid40OBJAgnriQ2NoUtixv9O8yoDE+JFLh1TH1W
    LkdlDfE9aUJMWjZ9o5vau+L91WhyLrZApI0ROhz9trS3K/WEOpPl1VeVPvy8e8L0
    U9zft7p+mrILW7C0t+8wD0eIPfm+lt9Q9ae5+Zg13WyIKqtE2vLY40pPzjMAGMS9
    LUTlZzD81S3WMCevcxJ2EOXLKDDyY7cNnjQRWuYyrGcsf6nAv5jCdnh7Z7RsuQM2
    z0e0O8KEcSJRZckSPxx6VYy6surf0fNRXK3p6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521051045; bh=o
    ALN840XSOvQ9BjP99mKBrQV4zQePQ7KfM/ZYkEWlLk=; b=dxwq4chj7gbLtpSqL
    c3LQdARX7JYGwR5MdHyyAiGiH6OUYVttkCdYF6H2BNHjuk/Mtd63OsBHNeIuoEq7
    WkLMKMfEisna4LojFHz4N/s8GqLicYlZYigrJb6GPljru1HA3kue/1EKihyz1VwF
    34PWdyRS4BzJBUBUbxfYaBWpmQPbq0k8k4VKV64Ed5+e0C1laH6zYMrpA7RVdjP3
    U3lFEQiLNJ7kOrLnl0qMUwnfMP+lFOfDct35uN1qDxGg9F7phTxqCVNKZUlT8f6s
    h24cpwbDVnnmdDk3bnscMiGA8+4ywjSyb9F+I8JaMIcxNEPqK+HwiEloiRFRZKYs
    cNcog==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bVcfO+/w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gnjR/6fv;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bVcfO+/w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gnjR/6fv;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsBsTbpuRHaRXZiq+e4IH0tloWnTHcCTEYE7MV/ad81tCpONnZl3rr/Ot+DJPqXdHAEggEdNQ==
Date: Wed, 14 Mar 2018 15:10:18 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Subject: [PATCH 1/7] staging:iio:ade7854: Rework I2C write function
Message-ID: <98c74382f0ea9c5d33f7ea9c9697d87889c1baa2.1521037060.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
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

The write operation using I2C has many code duplications and four
different interfaces per data size. This patch introduces a single
function that centralizes the main tasks.

The central function inserted by this patch can easily replace all the
four functions related to the data size. However, this patch does not
remove any code signature for keeping the meter module work and make
easier to review this patch.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 89 +++++++++++++++++++--------------
 drivers/staging/iio/meter/ade7854.h     |  7 +++
 2 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 317e4f0d8176..03133a05eae4 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -15,41 +15,74 @@
 #include <linux/iio/iio.h>
 #include "ade7854.h"
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
+static int ade7854_i2c_write_reg(struct device *dev,
+				 u16 reg_address,
+				 u32 val,
+				 enum data_size type)
 {
 	int ret;
+	int count;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = val;
 
-	ret = i2c_master_send(st->i2c, st->tx, 3);
+	switch (type) {
+	case DATA_SIZE_8_BITS:
+		st->tx[2] = val & 0xFF;
+		count = 3;
+		break;
+	case DATA_SIZE_16_BITS:
+		st->tx[2] = (val >> 8) & 0xFF;
+		st->tx[3] = val & 0xFF;
+		count = 4;
+		break;
+	case DATA_SIZE_24_BITS:
+		st->tx[2] = (val >> 16) & 0xFF;
+		st->tx[3] = (val >> 8) & 0xFF;
+		st->tx[4] = val & 0xFF;
+		count = 5;
+		break;
+	case DATA_SIZE_32_BITS:
+		st->tx[2] = (val >> 24) & 0xFF;
+		st->tx[3] = (val >> 16) & 0xFF;
+		st->tx[4] = (val >> 8) & 0xFF;
+		st->tx[5] = val & 0xFF;
+		count = 6;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_i2c_write_unlock;
+	}
+
+	ret = i2c_master_send(st->i2c, st->tx, count);
+
+error_i2c_write_unlock:
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
 }
 
+static int ade7854_i2c_write_reg_8(struct device *dev,
+				   u16 reg_address,
+				   u8 val)
+{
+	int ret;
+
+	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
+
+	return ret;
+}
+
 static int ade7854_i2c_write_reg_16(struct device *dev,
 				    u16 reg_address,
 				    u16 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 8) & 0xFF;
-	st->tx[3] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 4);
-	mutex_unlock(&st->buf_lock);
+	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
 
 	return ret;
 }
@@ -59,18 +92,8 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 				    u32 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 16) & 0xFF;
-	st->tx[3] = (val >> 8) & 0xFF;
-	st->tx[4] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 5);
-	mutex_unlock(&st->buf_lock);
+	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
 
 	return ret;
 }
@@ -80,23 +103,13 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 				    u32 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 24) & 0xFF;
-	st->tx[3] = (val >> 16) & 0xFF;
-	st->tx[4] = (val >> 8) & 0xFF;
-	st->tx[5] = val & 0xFF;
 
-	ret = i2c_master_send(st->i2c, st->tx, 6);
-	mutex_unlock(&st->buf_lock);
+	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
 
 	return ret;
 }
 
+
 static int ade7854_i2c_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index a82d38224cbd..71bdd638f348 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -143,6 +143,13 @@
 #define ADE7854_SPI_BURST	(u32)(1000 * 1000)
 #define ADE7854_SPI_FAST	(u32)(2000 * 1000)
 
+enum data_size {
+	DATA_SIZE_8_BITS = 1,
+	DATA_SIZE_16_BITS,
+	DATA_SIZE_24_BITS,
+	DATA_SIZE_32_BITS,
+};
+
 /**
  * struct ade7854_state - device instance specific data
  * @spi:			actual spi_device
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
