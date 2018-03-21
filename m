Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521628179-5-13022961880668286857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628178; b=qg4koEXCDRglkAgsXqU7bhG+LdGP3yB8hpSIh0K277q6/uW
    OFEYFf8sw9RCX71l0ry0NUwiq4h7Uw8FxNPntEtL69PSNg60WQEfrLQB9oWzwcho
    IOK3WUNBJBSTQvRBa37gQjFt0YlZJT+8cI9zHoQmsUJTdaFtYMdqTJ+X+JDkDsWl
    MEHExVLu0LiCjUgOuR4nTnfZOfl6X45f8B0giBNaUldWDzFezuFfLc6bD1zsiHhw
    Qe9dY5uG9s1XCONtbOESXIk6T3nXXToUBx0StWuDj3SA9/eCOXr7O09kRqwCUFzd
    CkDa5HQN6sqHOPyuAkediwaMCmcouuvM5Sn+89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628178; bh=+
    tjw9Tz8lL6T4ov8nLswLRQx+kE5Hgv06E+6oFhiXjg=; b=j8nqYGkxDMhVPC4bh
    udSOt1XPXPcafzwp9UuQPPlYlUTiFZSLODIkM8+Xp9DUOC+wvfzecL0pN4HHDOtx
    854CdyDVrZwuqUf18/3JgY79ltEir57SL2ooHD64K2aawpqZS567B4VLzXTLlG+Z
    RZZpkD+dO3syo+F4pbn1SIqMU/AyLzEbciMjMTfZqcWVGVpSnbyb3e2emlVHUbqi
    smu49vToceTZ4tyOGSBbhDY4eK7b2syf8vvsConWp9HYWiB9DRvkOm2HSIEq0SUf
    gFr8tFTS3DMRgVpPkzpp+oUqEp5aox5sa5fcOffRKx4QfcsXqZUpBoLem4Wxq5Up
    hhSOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=bSLT9q2N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=bSLT9q2N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 06/11] staging: iio: tsl2x7x: make logging consistent and
 correct newlines
Date: Wed, 21 Mar 2018 06:29:07 -0400
Message-Id: <20180321102912.5130-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch updates all of the logging commands so that they are
consistent with the other messages, includes __func__ in the message,
and all of the messages include newlines. This patch also removes some
debug log messages.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Remove some debug messages and every log message doesn't have to have
  the function name.
- Earlier patches in this current series dropped some of the debug
  messages that were in v1.

 drivers/staging/iio/light/tsl2x7x.c | 42 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index f7e7fcc17059..07ce3076a05d 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -374,7 +374,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
-				"failed to read. err=%x\n", ret);
+				"%s: failed to read from register %x: %d\n",
+				__func__, reg, ret);
 			goto out_unlock;
 		}
 
@@ -416,7 +417,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 
 	/* note: lux is 31 bit max at this point */
 	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev, "ch1lux > ch0lux-return last value\n");
+		dev_dbg(&chip->client->dev,
+			"%s: ch1lux > ch0lux; returning last value\n",
+			__func__);
 		ret = chip->als_cur_info.lux;
 		goto out_unlock;
 	}
@@ -591,8 +594,6 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 		return -ERANGE;
 
 	chip->settings.als_gain_trim = ret;
-	dev_info(&chip->client->dev,
-		 "%s als_calibrate completed\n", chip->client->name);
 
 	return ret;
 }
@@ -674,12 +675,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	 */
 	for (i = 0, dev_reg = chip->tsl2x7x_config;
 			i < TSL2X7X_MAX_CONFIG_REG; i++) {
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL2X7X_CMD_REG + i,
+		int reg = TSL2X7X_CMD_REG + i;
+
+		ret = i2c_smbus_write_byte_data(chip->client, reg,
 						*dev_reg++);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
-				"failed on write to reg %d.\n", i);
+				"%s: failed to write to register %x: %d\n",
+				__func__, reg, ret);
 			return ret;
 		}
 	}
@@ -907,15 +910,11 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 	 */
 	n = value[0];
 	if ((n % 3) || n < 6 ||
-	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3)) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
+	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3))
 		return -EINVAL;
-	}
 
-	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
+	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0)
 		return -EINVAL;
-	}
 
 	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
 		ret = tsl2x7x_chip_off(indio_dev);
@@ -1048,15 +1047,10 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 			chip->settings.persistence &= 0xF0;
 			chip->settings.persistence |=
 				(filter_delay & 0x0F);
-			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
-				 __func__, filter_delay);
 		} else {
 			chip->settings.persistence &= 0x0F;
 			chip->settings.persistence |=
 				((filter_delay << 4) & 0xF0);
-			dev_info(&chip->client->dev,
-				 "%s: Proximity persistence = %d",
-				 __func__, filter_delay);
 		}
 		ret = 0;
 		break;
@@ -1269,9 +1263,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		chip->settings.als_time =
 			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
-
-		dev_info(&chip->client->dev, "%s: als time = %d",
-			 __func__, chip->settings.als_time);
 		break;
 	default:
 		return -EINVAL;
@@ -1633,8 +1624,9 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 
 	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
 	if (ret < 0) {
-		dev_err(&clientp->dev, "write to cmd reg failed. err = %d\n",
-			ret);
+		dev_err(&clientp->dev,
+			"%s: Failed to write to CMD register: %d\n",
+			__func__, ret);
 		return ret;
 	}
 
@@ -1664,7 +1656,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 						indio_dev);
 		if (ret) {
 			dev_err(&clientp->dev,
-				"%s: irq request failed", __func__);
+				"%s: irq request failed\n", __func__);
 			return ret;
 		}
 	}
@@ -1681,8 +1673,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		return ret;
 	}
 
-	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
-
 	return 0;
 }
 
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
