Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1445372-1521815231-2-6941621236828317926
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521815230; b=vm82YusYubIGOZRACehZh88UTZgsbZJcAhFVrzJJ6pZV73W
    PXZJVTKuj3RylCqX1cM8N/PRqPh4lVbYRtv913nTjRZOrMsmf9rGilfOa/EURSDu
    pHYyIusP5IrVQTeuj1TGQnXNdEmbUPOBanjFPavh3WXf7XkTO9Td2x0AQAFn3RGE
    Zi63SyMLyHX+S5WLMpwMUSnJsvFvXFG13/Xd0dBwuNMu9RLp4Mx8J90UfK1Kmlg5
    U4yEQsnzHQFJkB/0dynB9//cNQK5LJ+JeYiGzfu/VqJ7xkxqhVACZrqCnbTE15bT
    IiPKj+LBWPl55gu8FyGQG+oToFYrMSzH9BGtp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521815230; bh=i
    KO9McMyYeo6Yt4zCGknvmdDjFOIO35URCnZnjLJYjQ=; b=UuVcYDIjLoCj0Xkk2
    PUYZC6zn4s/xgqdxim8tQV85oTR50CChRaXroBVJD7SlgPpWpEIRYND6KsHNmVY2
    4DdoRje/xxQMSzGYLmtyRqHRzrBSTNM7/eLQ3zs8PJZ5hL88Mcg1C5aJ0i8kJF3t
    mtc0Qo05vhLAQXpb2qgOQqdZI+mAfnm0RYvGU3LHfqjTnAB1twy6uN96D5BeGc4+
    oFP3K48C+97ahBTafgxszcE9eEqeFLTHVFF2l5hHfLxsez9HWTAGtIfrsKVfs/oI
    yZO1bO34dXa6bNY/1lCCBonjv3jv2cu+LwRvwSVbM8SAh0iwaHnNXOgY3XYsTIrj
    l9+gA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TCVpjWuc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hvMCOEiX;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TCVpjWuc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hvMCOEiX;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELusAKKWIWaDyjS3CoJWAm6hCuqSgAF8lSzJTyw5KY9rKnLBL830wBNqStd/aK+qVdEZ4lSgQQ==
Date: Fri, 23 Mar 2018 11:26:57 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 6/8] staging:iio:ade7854: Rework I2C read function
Message-ID: <c7f86bb795b71e693692b228da854939be67cb1d.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

The read operation for the I2C function has many duplications that can
be generalized into a single function. This patch reworks the read
operation for I2C to centralizes all similar code in a single function.

It is possible to remove all the old interface to use the new one,
however, for keeping the things simple and working this patch maintain
legacy interface.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Remove the use of defines that not improve the readability
 - Replace variable name "bytes" for "bits"
 - Update commit message

 drivers/staging/iio/meter/ade7854-i2c.c | 106 +++++++++++---------------------
 1 file changed, 37 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 29e959fdb932..63793f9664c7 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,9 +65,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-static int ade7854_i2c_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
+static int ade7854_i2c_read_reg(struct device *dev,
+				u16 reg_address,
+				u32 *val,
+				int bits)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -79,95 +80,62 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
 	if (ret < 0)
-		goto out;
+		goto unlock;
 
-	ret = i2c_master_recv(st->i2c, st->rx, 1);
+	ret = i2c_master_recv(st->i2c, st->rx, bits);
 	if (ret < 0)
-		goto out;
+		goto unlock;
+
+	switch (bits) {
+	case 8:
+		*val = st->rx[0];
+		break;
+	case 16:
+		*val = (st->rx[0] << 8) | st->rx[1];
+		break;
+	case 24:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case 32:
+		*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
+			(st->rx[2] << 8) | st->rx[3];
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
 
-	*val = st->rx[0];
-out:
+unlock:
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
+static int ade7854_i2c_read_reg_8(struct device *dev,
+				  u16 reg_address,
+				  u8 *val)
+{
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 8);
+}
+
 static int ade7854_i2c_read_reg_16(struct device *dev,
 				   u16 reg_address,
 				   u16 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret < 0)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 2);
-	if (ret < 0)
-		goto out;
-
-	*val = (st->rx[0] << 8) | st->rx[1];
-out:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 16);
 }
 
 static int ade7854_i2c_read_reg_24(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret < 0)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret < 0)
-		goto out;
-
-	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
-out:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 24);
 }
 
 static int ade7854_i2c_read_reg_32(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret < 0)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 4);
-	if (ret < 0)
-		goto out;
-
-	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
-		(st->rx[2] << 8) | st->rx[3];
-out:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 32);
 }
 
 static int ade7854_i2c_probe(struct i2c_client *client,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
