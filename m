Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1421790-1521815261-2-15682816677576409076
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
    t=1521815260; b=ZKCkXIzAracCa42Y9PlQTQkd9/7TbSHJn+MsPuC+iflw46K
    Z40T06thgDXxZn3bVHvpXsRh8hDQD73CFgBemCUxC6bO2Qm0V8lJgSOb/PA+V5S8
    Yj3enhbySufMhsHR22+lTaGlhldTjAil1G2yii2f5GAQWuF5wK7ll2Jls3JGp1sU
    lA9mTL7tFKm3iUSBxJD7tORJmIpeJ+oHR/7Px5bgsWjmyi4WK3i0Q7A/eAqNoULL
    T+OI8Jp7F38Grt7QisMCwckZ3fEtckXe4uSDfMP7PDfYX0SwknCJL7kuGPmKNa0/
    SrGSOiT1myr49DYPEeH30P61nE/4Pl0Es6Q3btQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521815260; bh=n
    wEn0iR7yFfb6jJeumzZLpNKPIiul3z933rc6797g54=; b=FHGfdKtpbHhAMwQzR
    7bHvzkZJ2Nk6CraWcoDSd6tgVu6IXsa3Uo/akxifOGlaChz+mv324KRg1oXhJL5g
    QM3PxOnPZaGLApbijSwdb7DFINKZttEvIqyzn4xwWPuyfV1uSVZN8NCgF+IYhCmj
    jk1FhJt57Zbe7XwDx2vtT1gG5glFcdOapld/4o4w55UP1lbXe0kEJfPUa4K2nINQ
    IVTfKu1mUaKn5MyTYV2ykVF7PYSki+kQJ4EqtNuhuWEziq6cib/M19xLQ/rbWUFX
    lggUGoCLTY7ZqEu0sPpXRCuFkQrTPLnXMnBqncPRe42ym7RP+22H3qsaUvAErnNu
    SQofg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EuSbbdj3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TiGFZ5O4;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EuSbbdj3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TiGFZ5O4;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELu7M5gaQ66Itfsekg/+blTw1G4W0dsNDQG8A+ZNDcRZjEYPzDB6ycuCI6SBb4x5U0IamEVF5w==
Date: Fri, 23 Mar 2018 11:27:27 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 8/8] staging:iio:ade7854: Remove read_reg_* duplications
Message-ID: <0af75d8bc519e2d8a38d62742fbf7de3c5899503.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

The original code had a read function per data size; after updates, all
read functions tasks were centralized in a single function, but the old
signature was kept to maintain the module working without problems. This
patch removes a set of duplications associated with read_reg_*, and
update the areas that calling the old interface by the new one.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Update commit message

 drivers/staging/iio/meter/ade7854-i2c.c | 33 +------------------------------
 drivers/staging/iio/meter/ade7854-spi.c | 35 ++-------------------------------
 drivers/staging/iio/meter/ade7854.c     | 18 ++++++++---------
 drivers/staging/iio/meter/ade7854.h     |  7 +++----
 4 files changed, 15 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 63793f9664c7..c3aa6ea9d036 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -110,34 +110,6 @@ static int ade7854_i2c_read_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_i2c_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
-{
-	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 8);
-}
-
-static int ade7854_i2c_read_reg_16(struct device *dev,
-				   u16 reg_address,
-				   u16 *val)
-{
-	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 16);
-}
-
-static int ade7854_i2c_read_reg_24(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 24);
-}
-
-static int ade7854_i2c_read_reg_32(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 32);
-}
-
 static int ade7854_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
@@ -149,10 +121,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
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
index ee6e4d166ece..fc9146757283 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -94,7 +94,7 @@ static int ade7854_spi_read_reg(struct device *dev,
 	st->tx[2] = reg_address & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
 			reg_address);
 		goto unlock;
@@ -120,34 +120,6 @@ static int ade7854_spi_read_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
-{
-	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 8);
-}
-
-static int ade7854_spi_read_reg_16(struct device *dev,
-				   u16 reg_address,
-				   u16 *val)
-{
-	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 16);
-}
-
-static int ade7854_spi_read_reg_24(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 24);
-}
-
-static int ade7854_spi_read_reg_32(struct device *dev,
-				   u16 reg_address,
-				   u32 *val)
-{
-	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 32);
-}
-
 static int ade7854_spi_probe(struct spi_device *spi)
 {
 	struct ade7854_state *st;
@@ -158,10 +130,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
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
index 45984b9a2bee..029c3bf42d4d 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -27,12 +27,12 @@ static ssize_t ade7854_read_8bit(struct device *dev,
 				 char *buf)
 {
 	int ret;
-	u8 val = 0;
+	u32 val = 0;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = st->read_reg_8(dev, this_attr->address, &val);
+	ret = st->read_reg(dev, this_attr->address, &val, 8);
 	if (ret < 0)
 		return ret;
 
@@ -44,12 +44,12 @@ static ssize_t ade7854_read_16bit(struct device *dev,
 				  char *buf)
 {
 	int ret;
-	u16 val = 0;
+	u32 val = 0;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = st->read_reg_16(dev, this_attr->address, &val);
+	ret = st->read_reg(dev, this_attr->address, &val, 16);
 	if (ret < 0)
 		return ret;
 
@@ -66,7 +66,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = st->read_reg_24(dev, this_attr->address, &val);
+	ret = st->read_reg(dev, this_attr->address, &val, 24);
 	if (ret < 0)
 		return ret;
 
@@ -83,7 +83,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 
-	ret = st->read_reg_32(dev, this_attr->address, &val);
+	ret = st->read_reg(dev, this_attr->address, &val, 32);
 	if (ret < 0)
 		return ret;
 
@@ -178,9 +178,9 @@ static int ade7854_reset(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
-	u16 val;
+	u32 val;
 
-	st->read_reg_16(dev, ADE7854_CONFIG, &val);
+	st->read_reg(dev, ADE7854_CONFIG, &val, 16);
 	val |= BIT(7); /* Software Chip Reset */
 
 	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
@@ -415,7 +415,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	int ret;
 	u32 irqen;
 
-	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
+	ret = st->read_reg(dev, ADE7854_MASK0, &irqen, 32);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 290adbf56951..a51e6e3183d3 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -146,6 +146,7 @@
 /**
  * struct ade7854_state - device instance specific data
  * @spi:		actual spi_device
+ * @read_reg		Wrapper function for I2C and SPI read
  * @write_reg		Wrapper function for I2C and SPI write
  * @indio_dev:		industrial I/O device structure
  * @buf_lock:		mutex to protect tx and rx
@@ -155,10 +156,8 @@
 struct ade7854_state {
 	struct spi_device *spi;
 	struct i2c_client *i2c;
-	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
-	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
-	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
-	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
+	int (*read_reg)(struct device *dev, u16 reg_address, u32 *val,
+			int bits);
 	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
 			 int bits);
 	int irq;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
