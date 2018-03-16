Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4140376-1521240596-2-9718720903815832012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240594; b=FfyKzQuVCdGxWxPAr81/kGIjJHxDHc9lO7vPYpAGRSQ7Nk/
    sJoUt51oYvYEwnb2LlPD/ZyOQOKy1uDqke+iXRxi6YCZ73LftgJ8Jcr2LR5KsBqe
    kEHbeod2S8RHRwYdYRlDra+78SXORIh3Q8fqbcsjNYPkIfrifuwaLjYp3GH5tMEc
    wsVSV8uoZmVL9K4Fz8m/DUO2ooeaIwHwtU8QmOK3o3VGPHJZzz9OhWLp9JzIzpKX
    Yh/6WMfJLz6mbeuP3Vf6G/1ELw2PRfv6Vy3mGL5/fCIvQGSC46sqi+PsZrbKH8cT
    rTrv1rXhRZPq7T2lQE5A1SF1vwelscHL+Hro6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521240594; bh=X
    hqFG1YNVotZQKGoDlflMY1baCj48BrPuiuoz/pW934=; b=NPTUia1XJe8csqKet
    kC2Bw+jC51ZuWGwGNaPJnI3OYRquAPFWMvi29X8lc5wa++cZN8QWRXfmNeSNcXS2
    7eRVSMxNcYtMpoCgFgUgISykk5iQHr5EoJplPUexPkVKWumDjrIexp8iJ+XRrq6s
    cimTQxzcHTNc+JxDGfp+XwZbS8w2hcvFVrbwvF6qCkwGKL8ekqV5ZiQZ2xjCyIJR
    qM5Vqlot4oVkgUmzPhghYobtAhRaf3KZorMZsQ++sxkJUvRlLdVhFSsq8D7MXX2O
    i8ERhFXDfq8ZyNgYFhJqQAkyRw0PENcSzQKNis+VBjGOJZveY+22P5NeaXlDUCLg
    qyw0w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TmhuW9+D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OILaTvee;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TmhuW9+D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OILaTvee;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvhhv0ZWmQ0eCJrr4ryCm391JT8Q7Ga45qdOvctKa44bzyD6XbKaymHsAC9swSFwKEGbujG8g==
Date: Fri, 16 Mar 2018 19:49:40 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 5/8] staging:iio:ade7854: Replace many functions for one
 function
Message-ID: <518e40bdf740819b7ca0e5d8dc5a5756337a3bd8.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

This patch removes code duplications related to the write_reg_*
functions and centralizes them in a single function. Also, it eliminates
the legacy functions and replaces them by a unique signature that is
used by SPI and I2C.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 33 +--------------------------------
 drivers/staging/iio/meter/ade7854-spi.c | 33 +--------------------------------
 drivers/staging/iio/meter/ade7854.c     | 12 ++++++------
 drivers/staging/iio/meter/ade7854.h     |  9 ++++-----
 4 files changed, 12 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 1daad42b1e92..e95147a1bac1 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,34 +65,6 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
-}
-
-static int ade7854_i2c_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
-}
-
-static int ade7854_i2c_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
-}
-
-static int ade7854_i2c_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
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
index f21dc24194fb..1eba3044b86f 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -67,34 +67,6 @@ static int ade7854_spi_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
-}
-
-static int ade7854_spi_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
-}
-
-static int ade7854_spi_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
-}
-
-static int ade7854_spi_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
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
index 0193ae3aae29..4aa7c6ce0016 100644
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
index 71bdd638f348..aa29faf7c91f 100644
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
+			 int type);
 	int irq;
 	struct mutex buf_lock;
 	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
