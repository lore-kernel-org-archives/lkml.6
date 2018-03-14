Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2296092-1521051065-2-14353571015250868335
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
    t=1521051064; b=I4pZzAV8SVLLznfz2GoJkPZH+7I00dtTNv9fK5L2NaQP14S
    bWS0Kv2eVc8VcgQJ/rbhNydtEbntFnxkFq/oAOYIaM+p9LEOPemiKU5AY0UHKZHj
    xbMXQ9tulgjgCTqHSRVAr1zBZRx2/MeFWvK8C9w3tUAWWPt413rJhgXKh/1HrsLg
    Mj6joxiwW2QKGbBl5QEcDf+razp/8CEy9v+YL8KrRkPy74wtI8+2wrGZ3qDzJiSL
    hFQITmlL40MNDLQjbkh2bPdh+3upATWAMPpRDdXWTz58RiY1iPcv4jRnqHytB+hZ
    ziVc0fLvaGN2lOwzPoxCXX8hh53XWJTkmJ4+ZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521051064; bh=o
    INGyp/qAVIVJK2ouHQIYli6B3G/PH8Ex5T/tXbl+FA=; b=REPh83lv23mmSlq0B
    QoSPR/ENPBANBvdtP3WLryWZ8dtaLnsj6ulMySow+dKS/Tax6ZLQZmmcLk3x8ZRz
    +R1aFi53So2Asiq+BbRbQUOt8pgnnYFDxfuno/DYNeUAhpTPXeNCxclu83yd35fN
    WhZYUkGSNtYgpI1gLErcDhYH1YolEeZ10l76/bJzLtnzXPOEa3fKyZS3QzwuyWa5
    Fl/uCqYUBd9ubRN7k/pC7o85KhUvBt+WoMvN/Pxbx0ywtYA7SVM0COK3zktrVBVK
    vVLM3ceZ1JMQRh4LB+hjBnFJ+syfDfAkIpwvuo013FH8sxT2P8l0PetsaKH6lzZj
    VuCfA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KUblMZYi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OHuLg7x3;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KUblMZYi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OHuLg7x3;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsqexlmpQynoplZRHKXj0KCEnZscYj1xFYKLyEHfrMvJCC7sG7EcsxX7nUPx2USAjAyfKSb9g==
Date: Wed, 14 Mar 2018 15:10:52 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Subject: [PATCH 3/7] staging:iio:ade7854: Replace many functions for one
 function
Message-ID: <6a661af6660a1951b4138e0be4269013686cce13.1521037060.git.rodrigosiqueiramelo@gmail.com>
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

This patch removes code duplications related to the write_reg_*
functions and centralizes them in a single function. Also, it eliminates
the legacy functions and replaces them by a unique signature that is
used by SPI and I2C.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 50 +--------------------------------
 drivers/staging/iio/meter/ade7854-spi.c | 49 +-------------------------------
 drivers/staging/iio/meter/ade7854.c     | 12 ++++----
 drivers/staging/iio/meter/ade7854.h     |  9 +++---
 4 files changed, 12 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 03133a05eae4..f302359d2265 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,51 +65,6 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	int ret;
-
-	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
-
-	return ret;
-}
-
-static int ade7854_i2c_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	int ret;
-
-	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
-
-	return ret;
-}
-
-static int ade7854_i2c_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	int ret;
-
-	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
-
-	return ret;
-}
-
-static int ade7854_i2c_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	int ret;
-
-	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
-
-	return ret;
-}
-
-
 static int ade7854_i2c_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
@@ -230,10 +185,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
 	st->read_reg_16 = ade7854_i2c_read_reg_16;
 	st->read_reg_24 = ade7854_i2c_read_reg_24;
 	st->read_reg_32 = ade7854_i2c_read_reg_32;
-	st->write_reg_8 = ade7854_i2c_write_reg_8;
-	st->write_reg_16 = ade7854_i2c_write_reg_16;
-	st->write_reg_24 = ade7854_i2c_write_reg_24;
-	st->write_reg_32 = ade7854_i2c_write_reg_32;
+	st->write_reg = ade7854_i2c_write_reg;
 	st->i2c = client;
 	st->irq = client->irq;
 
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 0dae118428cf..df3df85f9440 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -67,50 +67,6 @@ static int ade7854_spi_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	int ret;
-
-	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
-
-	return ret;
-}
-
-static int ade7854_spi_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	int ret;
-
-	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
-
-	return ret;
-}
-
-static int ade7854_spi_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	int ret;
-
-	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
-
-	return ret;
-}
-
-static int ade7854_spi_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	int ret;
-
-	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
-
-	return ret;
-}
-
 static int ade7854_spi_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
@@ -276,10 +232,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
 	st->read_reg_16 = ade7854_spi_read_reg_16;
 	st->read_reg_24 = ade7854_spi_read_reg_24;
 	st->read_reg_32 = ade7854_spi_read_reg_32;
-	st->write_reg_8 = ade7854_spi_write_reg_8;
-	st->write_reg_16 = ade7854_spi_write_reg_16;
-	st->write_reg_24 = ade7854_spi_write_reg_24;
-	st->write_reg_32 = ade7854_spi_write_reg_32;
+	st->write_reg = ade7854_spi_write_reg;
 	st->irq = spi->irq;
 	st->spi = spi;
 
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 90d07cdca4b8..f9a977dcd670 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -105,7 +105,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
 	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_8(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_8_BITS);
 
 error_ret:
 	return ret ? ret : len;
@@ -126,7 +126,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
 	ret = kstrtou16(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_16(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_16_BITS);
 
 error_ret:
 	return ret ? ret : len;
@@ -147,7 +147,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
 	ret = kstrtou32(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_24(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_24_BITS);
 
 error_ret:
 	return ret ? ret : len;
@@ -168,7 +168,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
 	ret = kstrtou32(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_32(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_32_BITS);
 
 error_ret:
 	return ret ? ret : len;
@@ -183,7 +183,7 @@ static int ade7854_reset(struct device *dev)
 	st->read_reg_16(dev, ADE7854_CONFIG, &val);
 	val |= BIT(7); /* Software Chip Reset */
 
-	return st->write_reg_16(dev, ADE7854_CONFIG, val);
+	return st->write_reg(dev, ADE7854_CONFIG, val, DATA_SIZE_16_BITS);
 }
 
 static IIO_DEV_ATTR_AIGAIN(0644,
@@ -426,7 +426,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	else
 		irqen &= ~BIT(17);
 
-	return st->write_reg_32(dev, ADE7854_MASK0, irqen);
+	return st->write_reg(dev, ADE7854_MASK0, irqen, DATA_SIZE_32_BITS);
 }
 
 static int ade7854_initial_setup(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 71bdd638f348..3830607de7c5 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -152,7 +152,8 @@ enum data_size {
 
 /**
  * struct ade7854_state - device instance specific data
- * @spi:			actual spi_device
+ * @spi:		actual spi_device
+ * @write_reg		Wrapper function for I2C and SPI write
  * @indio_dev:		industrial I/O device structure
  * @buf_lock:		mutex to protect tx and rx
  * @tx:			transmit buffer
@@ -165,10 +166,8 @@ struct ade7854_state {
 	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
 	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
 	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
-	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
-	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
-	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
-	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
+	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
+			 enum data_size type);
 	int irq;
 	struct mutex buf_lock;
 	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
