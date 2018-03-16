Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4140376-1521240613-2-6904273246806077666
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
    t=1521240612; b=UoW2pXPrG++yhKbKuvm2W5E8XW5AOERyiPEEwG8aFW0txzj
    0mSiJF4s3XezHeiPKUX8qR1jatNIoEyp33/PQs6x0Jj+f1ECPxolzubooesRIv0Y
    SJeEG+bvkIsOvPbkfaJO+mcWJfbLTec54SH9A1IuP4WNF2jIf3gIvgTHHNQJ2nXB
    I2MyuAalxp2QPwl67GdiSB2wAGpFwfMO/ZXgaBZTUus68QgqbLuFZZ1VBDeFDwaH
    liG+Z+g6LdVH9WynadgD5XAg7+qqyyWl+fIutZxlyKpjco2AnpNc8F4yyrcFFueI
    dZPo6un8LFvJc04qddxj5nPoKQ0pKPX7imwHJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521240612; bh=l
    QdjCJHYvjpXz3Pe0slGkjP/yBxvfkD2XsDO80ae0Qk=; b=hFnMtmkQaG26t1EIH
    lw77ewaN7XelFQ3x0VBVC3RcCpdJpunggr22yt5tSpRg6T4W2q5PLVBhzF2hFOAR
    3q5DX2m/gNYUN68DD71mg5+kxqQs6kIfLvUMsd5QgFQhGFpfg57Wzst2bZjhwE3e
    KWAkCIrvGb/QAZO8GBCDttjpZRIwAMxp9Zme27NwmvpjfII0tmgh7B5vxc6SKZT5
    nYkvdudQDZoWkcVZ187gSWJRwQ+ykwEGuIj1dxBbL3R513D+6/QsxVLayeIDFf2p
    oLMBM+c1L2E+q1bNLVOD2IUxnxpnbEshrOYTrR6G5s3UctQfDJ+N8iUD1X4JvPhF
    iU5ZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WiLsFld/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iMf2teJS;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WiLsFld/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iMf2teJS;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsiOp0WmHjpelMAbT9xxOEcuc7w1LmKMMP1vvf1iTijP8Zs9/F95nqaJgf0eQnP9jyHTceDcw==
Date: Fri, 16 Mar 2018 19:49:59 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 6/8] staging:iio:ade7854: Rework I2C read function
Message-ID: <1d0edf1a515e71b0198cb76ed6ec679f85ba2127.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

The read operation for the I2C function has many duplications that can
be generalized into a single function. This patch reworks the read
operation for I2C to centralizes all similar code in a single function.
Part of the rework includes a proper error handling and a fix on the
i2c_master_recv for 32 bits as pointed by John Syne patches.

It is possible to remove all the old interface to use the new one,
however, for keeping the things simple and working this patch maintain
legacy interface.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 110 ++++++++++++--------------------
 1 file changed, 41 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index e95147a1bac1..20db8eedb84a 100644
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
+				int bytes)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -79,95 +80,66 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
 	if (ret < 0)
-		goto out;
+		goto unlock;
 
-	ret = i2c_master_recv(st->i2c, st->rx, 1);
+	ret = i2c_master_recv(st->i2c, st->rx, bytes);
 	if (ret < 0)
-		goto out;
+		goto unlock;
+
+	switch (bytes) {
+	case DATA_SIZE_8_BITS:
+		*val = st->rx[0];
+		break;
+	case DATA_SIZE_16_BITS:
+		*val = (st->rx[0] << 8) | st->rx[1];
+		break;
+	case DATA_SIZE_24_BITS:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case DATA_SIZE_32_BITS:
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
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_8_BITS);
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
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_16_BITS);
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
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_24_BITS);
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
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_32_BITS);
 }
 
 static int ade7854_i2c_probe(struct i2c_client *client,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
