Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4140376-1521240561-2-14843404065178690389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240560; b=sJ9uevmyVp4cy5NWD2zbMSvtPSzm2woJ67ZLOG/1ZqF+EBQ
    zntdqIZoJX+R3XDDud2DL7+BLJPnC33T2jnd1pXKg+JMxntP0Oh87v/SJTPxlVIu
    Kd3XjIS1fIzQNufOx0LjGqm7mklat1/3YfDWujzs18x2buJKDgGFG9sDGVtVprXC
    MRrHDcw4mSPj6USE9he3n/EvF47uhE2pkm62htoRe8wHrqidZ5z2pcuSIhuT+ikH
    8qO8qx6HcQG06B2E8wWU9i/dYP2+0mcv/tsQ63TNr6dvCJxco3QockamPpAGT1ig
    KRorbNRqhk87Vh+tzecQRzp6JCIDyNxZq4JHjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521240560; bh=o
    qNccl7H9+MeT4iL8fR0De8O8YdK1+mTuiIW2yfh+fQ=; b=G4HdHyJVywrgzrkrm
    Af5cQvhLz5KkzjHqWWZiy9/m/deKaMnoD9fZOKsNoX+ru/V1GgtucGIoStwFJIF2
    T6tbCvN//liZJrfaOGQrghv+OTNI4BHB+w/CXGrvZjiot0w2utrgsqrXeZIEMm16
    +8+j0TXLQcqB0q4SH6xPYRMeN0shd5TMIYNqlQHSjJvqB590I3joqEbMM5JW3p2M
    /e/l2HYEnpFoFvAbBX+MQPBYajneo6qOR/xFTsPUgPDf1l17NuVNEJTAjfTfFrWO
    ZHIZQpHegM0amxO4lbKOL3P6XiZQMN7oOAXqnp2i/UYNfxp/kAKBwalkQ2qeEudY
    qc/Eg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aeWBD2dB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZI+H+VSx;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aeWBD2dB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZI+H+VSx;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtPPog/AxuO6VSoILjJq79wbu0IPu+0xctIpNcWCz4D8L8kf7tvEr7sTaT3OKZId8dYR06Qgw==
Date: Fri, 16 Mar 2018 19:49:08 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 3/8] staging:iio:ade7854: Rework I2C write function
Message-ID: <d739c0eb2843e7b7d6251d6d805d3874e598cbcc.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

The write operation using I2C has many code duplications and four
different interfaces per data size. This patch introduces a single
function that centralizes the main tasks.

The central function inserted by this patch can easily replace all the
four functions related to the data size. However, this patch does not
remove any code signature for keeping the meter module work and make
easier to review this patch.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 96 ++++++++++++++++-----------------
 drivers/staging/iio/meter/ade7854.h     |  7 +++
 2 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 37c957482493..1daad42b1e92 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -15,86 +15,82 @@
 #include <linux/iio/iio.h>
 #include "ade7854.h"
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
+static int ade7854_i2c_write_reg(struct device *dev,
+				 u16 reg_address,
+				 u32 val,
+				 int bytes)
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
+	switch (bytes) {
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
+		goto unlock;
+	}
+
+	ret = i2c_master_send(st->i2c, st->tx, count);
+
+unlock:
 	mutex_unlock(&st->buf_lock);
 
 	return ret < 0 ? ret : 0;
 }
 
+static int ade7854_i2c_write_reg_8(struct device *dev,
+				   u16 reg_address,
+				   u8 val)
+{
+	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
+}
+
 static int ade7854_i2c_write_reg_16(struct device *dev,
 				    u16 reg_address,
 				    u16 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 8) & 0xFF;
-	st->tx[3] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 4);
-	mutex_unlock(&st->buf_lock);
-
-	return ret < 0 ? ret : 0;
+	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
 }
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
 				    u16 reg_address,
 				    u32 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 16) & 0xFF;
-	st->tx[3] = (val >> 8) & 0xFF;
-	st->tx[4] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 5);
-	mutex_unlock(&st->buf_lock);
-
-	return ret < 0 ? ret : 0;
+	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
 }
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
 				    u16 reg_address,
 				    u32 val)
 {
-	int ret;
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
-
-	ret = i2c_master_send(st->i2c, st->tx, 6);
-	mutex_unlock(&st->buf_lock);
-
-	return ret < 0 ? ret : 0;
+	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
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
