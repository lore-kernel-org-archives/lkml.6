Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1445372-1521815215-2-12481037796544751489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521815214; b=BuqKf1k9AGMMLgNqpIp+SZ2uQMk6maXnW4HtuIO9XtNZepc
    7t93ZNznm0dOE27L5XYvAEWgISSs8938w/V2j4+U8x7lzadw03TaiBiFybL05h/u
    +rFzIEuh6UNuamaIV53SrFVH3d6mY/TDd0LJlYEgnPS4FJpnnxF9o6fvYmVqu2UR
    Znp7zGaajYPKTmqZME0cCiHBo76Jq2KFFyLak8+KiOGovtcTPLwtaxb6HTe31wW5
    oPQ3DGece0STf2Vt9GOBNtLOeOR4vuM8j7i4FWQNmTnStmiekrxqcRjiVDRCuf03
    T6ZOnSRIoeDGdrHX33NHKdmoZxQWDNJGicVx3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521815214; bh=k
    m9b3pCt/YfDFFsztcXxDBcMDTKfLtZ2YjXynN6qE74=; b=CoI5EDrMjm7etapT8
    uQhFq+ueuJSwXaX7lJEUTKJ3mzW99qiRg7jmSOI4RDyTWdJthW8DH1D+/ldMBl6j
    r7qtbnu3USFrlGXwuI+zzHKUiWMR8e2ydQDgK+iAS8pWQ3dehCc4vJcdUlqrmSB7
    ip6mdajNT30QpxMllfEnKtMZyWBmt4l1TSD7JvaYyZ7/9JnBeJX879pWHdTdi7l1
    0S/R1wHLZ6oKaqE73WOprj5M1XShldhujpaoQ9hd+iGBAawxPRG8ak08b2GPTTAy
    vBpCva2soO5DrZLID0Df/gi1bklIRBG2PaEQwUn0YAxpJxy1m4K8yCsoBRrRjDH0
    OotTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uqZn216U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I6dJgw/L;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uqZn216U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I6dJgw/L;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuZWBO6yyJTnKBUx4B+RsiRljWG/SYHkRp77PV84v9edFTv4ak5I8+/TGdhtg0dnHLuW6M04A==
Date: Fri, 23 Mar 2018 11:26:41 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 5/8] staging:iio:ade7854: Remove write_reg_* duplications
Message-ID: <f653606d784c5b4dd1b502030a4b0ce43df8e913.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

This patch removes code duplications related to the write_reg_*
functions and centralizes them in a single function. Also, it eliminates
the legacy functions and replaces them by a unique signature that is
used by SPI and I2C.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Update commit message

 drivers/staging/iio/meter/ade7854-i2c.c | 33 +--------------------------------
 drivers/staging/iio/meter/ade7854-spi.c | 33 +--------------------------------
 drivers/staging/iio/meter/ade7854.c     | 12 ++++++------
 drivers/staging/iio/meter/ade7854.h     |  9 ++++-----
 4 files changed, 12 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index c9f46d26b752..29e959fdb932 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,34 +65,6 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 8);
-}
-
-static int ade7854_i2c_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 16);
-}
-
-static int ade7854_i2c_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 24);
-}
-
-static int ade7854_i2c_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 32);
-}
-
 static int ade7854_i2c_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
@@ -213,10 +185,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
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
index 9c5c16c4d6e0..be7397042850 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -67,34 +67,6 @@ static int ade7854_spi_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 8);
-}
-
-static int ade7854_spi_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 16);
-}
-
-static int ade7854_spi_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 24);
-}
-
-static int ade7854_spi_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 32);
-}
-
 static int ade7854_spi_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
@@ -260,10 +232,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
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
index 0193ae3aae29..45984b9a2bee 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -105,7 +105,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
 	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_8(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 8);
 
 error_ret:
 	return ret ? ret : len;
@@ -126,7 +126,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
 	ret = kstrtou16(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_16(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 16);
 
 error_ret:
 	return ret ? ret : len;
@@ -147,7 +147,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
 	ret = kstrtou32(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_24(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 24);
 
 error_ret:
 	return ret ? ret : len;
@@ -168,7 +168,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
 	ret = kstrtou32(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_32(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 32);
 
 error_ret:
 	return ret ? ret : len;
@@ -183,7 +183,7 @@ static int ade7854_reset(struct device *dev)
 	st->read_reg_16(dev, ADE7854_CONFIG, &val);
 	val |= BIT(7); /* Software Chip Reset */
 
-	return st->write_reg_16(dev, ADE7854_CONFIG, val);
+	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
 }
 
 static IIO_DEV_ATTR_AIGAIN(0644,
@@ -426,7 +426,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	else
 		irqen &= ~BIT(17);
 
-	return st->write_reg_32(dev, ADE7854_MASK0, irqen);
+	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
 }
 
 static int ade7854_initial_setup(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index a82d38224cbd..290adbf56951 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -145,7 +145,8 @@
 
 /**
  * struct ade7854_state - device instance specific data
- * @spi:			actual spi_device
+ * @spi:		actual spi_device
+ * @write_reg		Wrapper function for I2C and SPI write
  * @indio_dev:		industrial I/O device structure
  * @buf_lock:		mutex to protect tx and rx
  * @tx:			transmit buffer
@@ -158,10 +159,8 @@ struct ade7854_state {
 	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
 	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
 	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
-	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
-	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
-	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
-	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
+	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
+			 int bits);
 	int irq;
 	struct mutex buf_lock;
 	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
