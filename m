Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521815180-2-12520942744848953620
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
    t=1521815179; b=Si/050R8U7M5tXG0GRLVq9vfVzdBeLg4YpUAlAQuqlfukr/
    1SfRYZpdCQr73uGOv4uxWF5cQi9lMHdm26EdDNlOVqetT9CrecFIAynlyaOUQ/un
    DuAnhSrg7ryvkM8r1+nztu7Qe64ZEqtUBZogbV2sJWExE8hm0XS/RLHXPV2fDH1l
    ftKkZURuKnToFYLUJ/TXq534HC1SJrTsZWIV+p7sMQ1JdHmEdpVnB3JpigPEBaQZ
    flEXvrZ2R9s4EUA/A+ZgDRbck4S98+zsTidBJ+xX688bhKBCIoMVOZhfdlq0lGoZ
    wAOSgSKXqO6omOKDHgMezbdfoLWg7bHJlpyQTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521815179; bh=0
    Cl5fA32TnwlQOU5d9vnG7xFkFVos7V52WRqVCM/Jx8=; b=Fw49nJM0BP0LbOE/h
    ehyaUvkMr3kXu0pxu8ay3Dcs2SwEYucaGmZz38Qr5tn60lA+hSdpFINT8MEsc3jR
    yempBJDO0lLDHBB5QsXIWj09shEuCfpgP9pUoh8MYwv5zQVT1/I8JjCdN0U6uOFn
    fcU9PneHrGksWzp1bmKdjAQj77tmByz50n5wRnQNnLdHeA3jZTH6bme3nG1+xbxx
    pHWsC8umnNY57dEF7I9tT85+SUkx+ofn5R09QoVmtwd2cCTCrSRa+FBSxDG3r4+m
    WNlgHmxt9mNNUpfPxuh2SVeGwK+H4/TQlPTlSbA6dXmo/kwtKX+tsfzeduj8m4gT
    SGyvQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=apqdGONT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U76APjIU;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=apqdGONT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U76APjIU;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsYp+APu8FOG/nbmocjTEkyM0yPdwzYP7pRMQPkBU/1M44GT1s5JqMoezNHvHNCbgWvs+ztbg==
Date: Fri, 23 Mar 2018 11:26:06 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 3/8] staging:iio:ade7854: Rework I2C write function
Message-ID: <c87da79c773f417c94b4609476c54f7de085b697.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

The write operation using I2C has many code duplications and four
different interfaces per data size. This patch introduces a single
function that centralizes the main tasks.

The central function inserted by this patch can easily replace all the
four functions related to the data size. However, this patch does not
remove any code signature for keeping the meter module work and make
easier to review this patch.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Remove the use of defines that not improve the readability
 - Replace variable name "bytes" for "bits"

 drivers/staging/iio/meter/ade7854-i2c.c | 96 ++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 37c957482493..c9f46d26b752 100644
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
+				 int bits)
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
+	switch (bits) {
+	case 8:
+		st->tx[2] = val & 0xFF;
+		count = 3;
+		break;
+	case 16:
+		st->tx[2] = (val >> 8) & 0xFF;
+		st->tx[3] = val & 0xFF;
+		count = 4;
+		break;
+	case 24:
+		st->tx[2] = (val >> 16) & 0xFF;
+		st->tx[3] = (val >> 8) & 0xFF;
+		st->tx[4] = val & 0xFF;
+		count = 5;
+		break;
+	case 32:
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
+	return ade7854_i2c_write_reg(dev, reg_address, val, 8);
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
+	return ade7854_i2c_write_reg(dev, reg_address, val, 16);
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
+	return ade7854_i2c_write_reg(dev, reg_address, val, 24);
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
+	return ade7854_i2c_write_reg(dev, reg_address, val, 32);
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
