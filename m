Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4051070-1521240526-2-8475715895570985651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240526; b=b0BGbpSiDZePwfAiaIPCTQEdKbi6iZdbXZCteTxI9Servkh
    50AM569XdruJCUTaJ2xx9cBOXrOybsDTOYJ47j2rk4V0Drcuuz0uu4bxK3Q4TEeC
    BkyB+oYeDfA96WeFFwX5spH4uMRNlQ9gMGR5YegS2oFJjsUO8EOsVoqRZJBl6hnX
    WMOu3ot+or+r+/KElYTAjGkvqU5HeEjzrJNr2BlNrAKgaKOjByR6bwt0spqgOohv
    1CBp56H6XSHSm4uOrvxb4ERd4Vxz6JahzqN4LvL81Sw8hhl2d6g1HU0/Lu2KPFEO
    pVS+OZdEbJl/dkSB1PrT8Qor7EzDPmHZlxUXJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521240526; bh=q
    xZfHaoPFze8Euk5uF4NgGA4jLuvTvFO9y6rbAabhNE=; b=KA+mT87B8DYmgeM8W
    j/eID5SxpVocSKRPeNcbXq3miqe9AqwxClaK3Z57vpm5e4NLzeYKyeU610kkak78
    yS2eug2yqKLDNxsQYBPsduhROhWtZy1uIvlPvXlWCi8N54wpM2bnoYsoL8dx3bBu
    Toqax7yLFeppER/u2+UMEushfow+EPH/8ibo7llxnD6alboQMOfcFyJHEBvkaKzZ
    1sXcpJSI0rNA9JWhKT03svRCxlg07S7FHqR4iQSpXXlWNR5bs4C52ps8BBFhSvLy
    aTsZRlz6QIZ1CWegifn15KReUm4vO5YVM9a+AfIlogjG7CgMtcQsEst7mfKBPkRq
    OYsRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JOHOQkEw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TnjSO+pt;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JOHOQkEw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TnjSO+pt;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELu6RWiEKdPHNoCngrSdKiq87xjz6cK5ncS4ffY0C/6oKmFH0lew5iokskuisdQp3kiHLONbgA==
Date: Fri, 16 Mar 2018 19:48:33 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 1/8] staging:iio:ade7854: Fix error handling on read/write
Message-ID: <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

The original code does not correctly handle the error related to I2C
read and write. This patch fixes the error handling related to all
read/write functions for I2C. This patch is an adaptation of the John
Syne patches.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
 drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 317e4f0d8176..4437f1e33261 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_16(struct device *dev,
@@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 4);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
@@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 5);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
@@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
@@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 1);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = st->rx[0];
@@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 8) | st->rx[1];
@@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 90d07cdca4b8..0193ae3aae29 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_8(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_16(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_24(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
 	struct ade7854_state *st = iio_priv(indio_dev);
 
 	ret = st->read_reg_32(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	u32 irqen;
 
 	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (enable)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
