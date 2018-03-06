Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520339179-2-14345706866270685167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520339178; b=L/6bAwM3l6tjmilEbsNHa5fgQE+/nDAsJs4LiVWFwmftNZC
    fIHT7dLciB2R4ETe50DWY5LIQSzV5i6A+0+BzGOIN3wNXpE0qPxVJ1U8ar7tPUph
    Xu128REHBJn5KkA5ljLHqnouar2d7PxKzoOo8pWWZZplLZBg99Iojhxi0cPHqZC9
    /53XfUJTE91EabuHKviy4oUYhIjqOFFpLXU3fXG3MfX5ErlMCcjeLYWUtuVAM2tv
    DeU4KNsSXPzeo+zpH0tmqwPtCJI8u52Wpf1BgDd2I9LaPW8HSmvbonjwmobz3kdy
    nV5Bn5f2+YHJ2Rm6o7kG5k1jKI7rnfN1y14JcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520339178; bh=X
    z98VFNW+imhDjeWTgtuR9I3Fe16wEV2I/tDlhg/+KA=; b=b4OVpg3FDxUMuajgc
    SQ78wD1WFk8YxlG9TlJzK97MT417c3cIIUNRIG+x1IxVhLC/dr47DXCrSZRCEEmW
    xMBhRk0JEmBwvFIfD4bXPcvYkucltwYPZUkkXtfzBqhrIDGnwf5qH5TopnynT8Bp
    WYPntKClZRmXOwyZLVLorNh7Iso++Djdm3zVxPvN4ISfaZWUfrD2DxP7Xstk9rJl
    Gl0vSQ38VEZcmn44Pyy944hLscRbdl2YKoBMw/V5voGQpZ7QcjIY/mebRlJkWuqJ
    NpodwlbmNsjWyGnC4GLIH6q16F6W2DbshB0gtTu8fxZMBjzks6/twu/G/8zOCdNa
    fe23g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LRQU4k47 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tljUNJer;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LRQU4k47 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tljUNJer;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELukFBLb0QqYA3Wrf78VarwyeBxUbLK7eZivekHDYdhCl/xvuQeSo6hrbyrAid1SORrrlxGLrw==
Date: Tue, 6 Mar 2018 09:26:07 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
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

This patch fixes the checkpatch.pl checks:

staging/iio/meter/ade7854-spi.c:19: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:44: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:70: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:97: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:125: CHECK: Alignment should match open
parenthesis

...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7758_trigger.c |  4 +--
 drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 1f0d1a0cf889..483cb8622571 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -30,7 +30,7 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
  * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
  **/
 static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
+					      bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
@@ -63,7 +63,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 
 	st->trig = iio_trigger_alloc("%s-dev%d",
-					spi_get_device_id(st->us)->name,
+				     spi_get_device_id(st->us)->name,
 					indio_dev->id);
 	if (!st->trig) {
 		ret = -ENOMEM;
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 72eddfec21f7..4419b8f06197 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -16,8 +16,8 @@
 #include "ade7854.h"
 
 static int ade7854_spi_write_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 val)
+				   u16 reg_address,
+				   u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -41,8 +41,8 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 }
 
 static int ade7854_spi_write_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 val)
+				    u16 reg_address,
+				    u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -67,8 +67,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 }
 
 static int ade7854_spi_write_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 val)
+				    u16 reg_address,
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -94,8 +94,8 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 }
 
 static int ade7854_spi_write_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 val)
+				    u16 reg_address,
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -122,8 +122,8 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 *val)
+				  u16 reg_address,
+				  u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -149,7 +149,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = st->rx[0];
@@ -160,8 +160,8 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 *val)
+				   u16 reg_address,
+				   u16 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -186,7 +186,7 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = be16_to_cpup((const __be16 *)st->rx);
@@ -197,8 +197,8 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 *val)
+				   u16 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -224,7 +224,7 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -235,8 +235,8 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 *val)
+				   u16 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -262,7 +262,7 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = be32_to_cpup((const __be32 *)st->rx);
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
