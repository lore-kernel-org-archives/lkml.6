Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-393451-1521921980-2-13471770464137362601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521921979; b=Y5KJVrs9LAORYwbBcQOEK9NDRCOysmjX5kvBDwcWaqd3/7r
    5y4mVSHL+JXHBL13WCSig08ooCxLMRd/o+ptLclKdJKVPsOshThEwSfh2Q+t7+Kr
    njJ7CY5k/bqaY6bHSf5jFzZEFV/V8p917KcgCwa+TZryhB5U1+fpNRkv4K5p3zaw
    ZXrkWRPm3gP1OcFO57SneRnXDR4Ed0UzFloUXd58+FngvwHUHpkrDSIiN0aSUuzV
    3pHx5bEM8/FcA7fMXKIu+rIvbmH+PSbYDFMpQ9Vmjfg0c3ikJRODA+mS0MlgBY+P
    BluwAcOsSZR2v+j54EQpinURkLhAL2VPE+mDkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521921979; bh=2
    WAopU4bPg4puCk/Wnb3WBXQJfaPSp1/pxSN2/hE2uw=; b=MtdiY7kV4qagbwjCw
    SGOUJMV1FyRUo8gLjpaVBZP1EwCplYF+YXH5p3AU2JamXkFZYoujmGtHS47PsyQH
    /0wvw4at+0FjiCCdn7oEr1E+7mChIZ/Xsn5N1IpzmCcBjViMs6TmdKf3K0UTTAFO
    LVLIFgVvQQhotO/Ck06JYBaxNBzsa88kXDfxWJ9cTJSjCzfWIEem5shtVI4yPz7j
    Pg9Abab7aK64tuhIe33QYak+0ywhtx66PBLE0IVEJk5eja5Z5F/MI4FG3xaYb7PB
    pxbTD3a8v9pisL4UTceCWIEwkpVYsnhdqcLDBAqni1TMj5djT/6ZDMvUGrLDil9q
    MeCUA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=dntZyB77 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=dntZyB77 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/4] staging: iio: tsl2x7x: use auto increment I2C protocol
Date: Sat, 24 Mar 2018 16:05:52 -0400
Message-Id: <20180324200555.1403-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200555.1403-1-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
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

The hardware supports 16-bit ALS and proximity readings, however the
datasheet recommends using the I2C auto increment protocol so that the
correct high and low bytes are read even if the integration cycle ends
between reading the lower and upper registers. More information about
this protocol can be found at https://www.i2c-bus.org/auto-increment/.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 100 ++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 77a81d75af4f..8530bccdb317 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -80,6 +80,8 @@
 /* tsl2X7X cmd reg masks */
 #define TSL2X7X_CMD_REG			0x80
 #define TSL2X7X_CMD_SPL_FN		0x60
+#define TSL2X7X_CMD_REPEAT_PROTO	0x00
+#define TSL2X7X_CMD_AUTOINC_PROTO	0x20
 
 #define TSL2X7X_CMD_PROX_INT_CLR	0X05
 #define TSL2X7X_CMD_ALS_INT_CLR		0x06
@@ -320,6 +322,55 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
 	return ret;
 }
 
+static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
+				     int upper_reg)
+{
+	u8 buf[2];
+	int ret;
+
+	ret = i2c_smbus_write_byte(chip->client,
+				   TSL2X7X_CMD_REG | TSL2X7X_CMD_AUTOINC_PROTO |
+				   lower_reg);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"%s: failed to enable auto increment protocol: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | lower_reg);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"%s: failed to read from register %x: %d\n", __func__,
+			lower_reg, ret);
+		return ret;
+	}
+	buf[0] = ret;
+
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | upper_reg);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"%s: failed to read from register %x: %d\n", __func__,
+			upper_reg, ret);
+		return ret;
+	}
+	buf[1] = ret;
+
+	ret = i2c_smbus_write_byte(chip->client,
+				   TSL2X7X_CMD_REG | TSL2X7X_CMD_REPEAT_PROTO |
+				   lower_reg);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"%s: failed to enable repeated byte protocol: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return le16_to_cpup((const __le16 *)&buf[0]);
+}
+
 /**
  * tsl2x7x_get_lux() - Reads and calculates current lux value.
  * @indio_dev:	pointer to IIO device
@@ -340,9 +391,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	struct tsl2x7x_lux *p;
 	u32 lux, ratio;
-	int i, ret;
 	u64 lux64;
-	u8 buf[4];
+	int ret;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -366,23 +416,17 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		goto out_unlock;
 	}
 
-	for (i = 0; i < 4; i++) {
-		int reg = TSL2X7X_CMD_REG | (TSL2X7X_ALS_CHAN0LO + i);
-
-		ret = i2c_smbus_read_byte_data(chip->client, reg);
-		if (ret < 0) {
-			dev_err(&chip->client->dev,
-				"%s: failed to read from register %x: %d\n",
-				__func__, reg, ret);
-			goto out_unlock;
-		}
-
-		buf[i] = ret;
-	}
+	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN0LO,
+					TSL2X7X_ALS_CHAN0HI);
+	if (ret < 0)
+		goto out_unlock;
+	chip->als_cur_info.als_ch0 = ret;
 
-	/* extract ALS/lux data */
-	chip->als_cur_info.als_ch0 = le16_to_cpup((const __le16 *)&buf[0]);
-	chip->als_cur_info.als_ch1 = le16_to_cpup((const __le16 *)&buf[2]);
+	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN1LO,
+					TSL2X7X_ALS_CHAN1HI);
+	if (ret < 0)
+		goto out_unlock;
+	chip->als_cur_info.als_ch1 = ret;
 
 	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
 	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
@@ -456,10 +500,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
  */
 static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 {
-	int i;
-	int ret;
-	u8 chdata[2];
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
+	int ret;
 
 	mutex_lock(&chip->prox_mutex);
 
@@ -490,18 +532,10 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 		break;
 	}
 
-	for (i = 0; i < 2; i++) {
-		int reg = TSL2X7X_CMD_REG | (TSL2X7X_PRX_LO + i);
-
-		ret = i2c_smbus_read_byte_data(chip->client, reg);
-		if (ret < 0)
-			goto prox_poll_err;
-
-		chdata[i] = ret;
-	}
-
-	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
-	ret = chip->prox_data;
+	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_PRX_LO, TSL2X7X_PRX_HI);
+	if (ret < 0)
+		goto prox_poll_err;
+	chip->prox_data = ret;
 
 prox_poll_err:
 	mutex_unlock(&chip->prox_mutex);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
