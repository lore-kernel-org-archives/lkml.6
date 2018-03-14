Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2296092-1521051116-2-8733405724622247423
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
    t=1521051115; b=GvsyUm+1pSnMNDqQWkJWbXstXGl9FD+vqCGhFraqk2OHN32
    AjDLgbZ0Q9tAtWa044/4O7Sv2/3M1XhDokXz5Oq87FXD/gN7OinQXlsgWw3VUMp2
    2YjSPyCZu9x8dnLY5pc3BHlQL1U4Im6RkBH4ki4n05uDG0ePKqliRl5ZwXMA9c6J
    XcOD6zPLJL87buIJHeWl+EyTC0ZMWKlBXG4dTdW3UtF4UHMcXQHKt6A36LkWwYNl
    gHVnIQMlbwKtNWnYw7J4pM13QOkXiv73+P6x4FMKFuODttizLJx//tUl+upjjgT5
    u0mFoxMSmmKq+wyM+ErAdy3lB7M1JN63QBNbAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521051115; bh=g
    B1tbAPrxMUb4+B9BL3mg/RpnZ7mqXxgBIfuRzmAUOw=; b=JHGIDuKNSkif4R5uy
    BlYCmGuNRhJbmITquQkcH5BMNbUzMNpiUMW6UxK6WJ9YwGHWC24Hq5WCUQWNMYYi
    uh2+Q1rhoyIW/WegMovtMlXae3E1HTWCuYX64Kxqzh5cnJYD+E+UYQE9rqAZYyGz
    YKOAPOLYKplFErAQVw1DjscqtbZh2/Sn+O8ZA+P9vzwoSp/BuPiVBdN+aPMXnIh7
    c9hWUbXD3LbzUAaRKr4ah5I46+R0Rg8GrT1XlA8so4cYnVEk0IlcUbhq4Hp5fhPi
    pehkoj5tK9Wni9SwAhjnJvnFD/h8bkR9OzkIrCtOU578snL7+jt4favLOG9GV4AK
    FdtXg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=svcprLHz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XRTAYbOv;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=svcprLHz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XRTAYbOv;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtdZ/5XAnWbrbhXcusbJtbq1zhDuK2cruD45N+GM6ar3dyoKDY8MG1eieqcWNM8g07+CazPQQ==
Date: Wed, 14 Mar 2018 15:11:43 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Subject: [PATCH 6/7] staging:iio:ade7854: Remove read_reg_* duplications
Message-ID: <0461c02559fa68aa5502a18d1aaa07123176786a.1521037060.git.rodrigosiqueiramelo@gmail.com>
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

The original code had a read function per data size; after updates, all
read functions tasks were centralized in a single function, but the old
signature was kept to maintain the module working without problems. This
patch removes a set of duplications associated with read_reg_*, and
update the areas that calling the old interface by the new one. During
the update for use a single function, some errors handlings were updated
based on the John Syne patches.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 53 +------------------------------
 drivers/staging/iio/meter/ade7854-spi.c | 55 ++-------------------------------
 drivers/staging/iio/meter/ade7854.c     | 28 ++++++++---------
 drivers/staging/iio/meter/ade7854.h     |  7 ++---
 4 files changed, 20 insertions(+), 123 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 845f8c348945..fc1ff08dc2d3 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -110,54 +110,6 @@ static int ade7854_i2c_read_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_i2c_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
-{
-	int ret;
-
-	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_8_BITS);
-
-	return ret;
-}
-
-static int ade7854_i2c_read_reg_16(struct device *dev,
-				   u16 reg_address,
-				   u16 *val)
-{
-	int ret;
-
-	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_16_BITS);
-
-	return ret;
-}
-
-static int ade7854_i2c_read_reg_24(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	int ret;
-
-	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_24_BITS);
-
-	return ret;
-}
-
-static int ade7854_i2c_read_reg_32(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	int ret;
-
-	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_32_BITS);
-
-	return ret;
-}
-
 static int ade7854_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
@@ -169,10 +121,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	st->read_reg_8 = ade7854_i2c_read_reg_8;
-	st->read_reg_16 = ade7854_i2c_read_reg_16;
-	st->read_reg_24 = ade7854_i2c_read_reg_24;
-	st->read_reg_32 = ade7854_i2c_read_reg_32;
+	st->read_reg = ade7854_i2c_read_reg;
 	st->write_reg = ade7854_i2c_write_reg;
 	st->i2c = client;
 	st->irq = client->irq;
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 0feef24aa888..5711f9ff822e 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -94,7 +94,7 @@ static int ade7854_spi_read_reg(struct device *dev,
 	st->tx[2] = reg_address & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
 			reg_address);
 		goto error_spi_read_unlock;
@@ -120,54 +120,6 @@ static int ade7854_spi_read_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
-{
-	int ret;
-
-	ret = ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_8_BITS);
-
-	return ret;
-}
-
-static int ade7854_spi_read_reg_16(struct device *dev,
-				   u16 reg_address,
-				   u16 *val)
-{
-	int ret;
-
-	ret = ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_16_BITS);
-
-	return ret;
-}
-
-static int ade7854_spi_read_reg_24(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	int ret;
-
-	ret = ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_24_BITS);
-
-	return ret;
-}
-
-static int ade7854_spi_read_reg_32(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	int ret;
-
-	ret = ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
-				   DATA_SIZE_32_BITS);
-
-	return ret;
-}
-
 static int ade7854_spi_probe(struct spi_device *spi)
 {
 	struct ade7854_state *st;
@@ -178,10 +130,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
-	st->read_reg_8 = ade7854_spi_read_reg_8;
-	st->read_reg_16 = ade7854_spi_read_reg_16;
-	st->read_reg_24 = ade7854_spi_read_reg_24;
-	st->read_reg_32 = ade7854_spi_read_reg_32;
+	st->read_reg = ade7854_spi_read_reg;
 	st->write_reg = ade7854_spi_write_reg;
 	st->irq = spi->irq;
 	st->spi = spi;
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index f9a977dcd670..09fd8c067738 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -27,13 +27,13 @@ static ssize_t ade7854_read_8bit(struct device *dev,
 				 char *buf)
 {
 	int ret;
-	u8 val = 0;
+	u32 val = 0;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = st->read_reg_8(dev, this_attr->address, &val);
-	if (ret)
+	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_8_BITS);
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -44,13 +44,13 @@ static ssize_t ade7854_read_16bit(struct device *dev,
 				  char *buf)
 {
 	int ret;
-	u16 val = 0;
+	u32 val = 0;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = st->read_reg_16(dev, this_attr->address, &val);
-	if (ret)
+	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_16_BITS);
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -66,8 +66,8 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = st->read_reg_24(dev, this_attr->address, &val);
-	if (ret)
+	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_24_BITS);
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -83,8 +83,8 @@ static ssize_t ade7854_read_32bit(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 
-	ret = st->read_reg_32(dev, this_attr->address, &val);
-	if (ret)
+	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_32_BITS);
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -178,9 +178,9 @@ static int ade7854_reset(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
-	u16 val;
+	u32 val;
 
-	st->read_reg_16(dev, ADE7854_CONFIG, &val);
+	st->read_reg(dev, ADE7854_CONFIG, &val, DATA_SIZE_16_BITS);
 	val |= BIT(7); /* Software Chip Reset */
 
 	return st->write_reg(dev, ADE7854_CONFIG, val, DATA_SIZE_16_BITS);
@@ -415,8 +415,8 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	int ret;
 	u32 irqen;
 
-	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
-	if (ret)
+	ret = st->read_reg(dev, ADE7854_MASK0, &irqen, DATA_SIZE_32_BITS);
+	if (ret < 0)
 		return ret;
 
 	if (enable)
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 3830607de7c5..3d762e74a7be 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -153,6 +153,7 @@ enum data_size {
 /**
  * struct ade7854_state - device instance specific data
  * @spi:		actual spi_device
+ * @read_reg		Wrapper function for I2C and SPI read
  * @write_reg		Wrapper function for I2C and SPI write
  * @indio_dev:		industrial I/O device structure
  * @buf_lock:		mutex to protect tx and rx
@@ -162,10 +163,8 @@ enum data_size {
 struct ade7854_state {
 	struct spi_device *spi;
 	struct i2c_client *i2c;
-	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
-	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
-	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
-	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
+	int (*read_reg)(struct device *dev, u16 reg_address, u32 *val,
+			enum data_size type);
 	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
 			 enum data_size type);
 	int irq;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
