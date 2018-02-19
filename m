Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-478194-1519057727-2-11827513338272769510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519057726; b=GxiE/f6SHOrUZqL+nfrHQdRaxcZvFWaSLRjaTtrwD1h59uz
    +gVyapnAYx/77R4K26kJvrR2/erfrPCWLqnHLKi/VzaAtPXnlBBSsJW6faKwefHj
    zxFwlqgORre+9ynF5ObhyHkrlK7BnOE/fG7ewj/QnwiMod6hSZcUK+AahYMA1Iz6
    MfhPw9AT+TBhJkQSPdj9I0OUu3HK0S8Or9VLUehesxXVmywhdJPt/n+3HBLS90aL
    tBFqzOfWcosXhP+/ZnUOZrGe2XUwvVgsOoUqZI+Uu5O9huvereh2iD/HjhBq0KgW
    rJagpxwgZmNx15WPynO8DSKtPbTFEESD02d1MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519057726; bh=V
    mUhkdk0E8KonXl/lCPqXZ1BBHXkBMUBvSnO3bWc+x4=; b=gUHXHGoW/kLu/F1Lu
    oAQDNLIZ19NUu2+T9q0lUfsIdw68KzDtN97Dm2ANJDaBAxnRm6081vbgxtd8xfnq
    EotWWhIdSRXPUpYj5qmuHonQGeJ1Q5AhNs0XA3qFni0wY956BiNjGcj8qeovF9V8
    pNzpOpjhCs3JC14IFapRoQv01GC5/zqj5DzMgxwB/8xum6HZ5z6UOjbzCkn5nK1Q
    rwOChQAV5Naj88CZjT5/RZWq8qQBTMta5/nQ2BjKOa4FMx13yb0L5JjKc4wTNDTM
    WRqvzS0biXpl+H9I/5zGW+cP5hbaOIdrf0Hs5+S3qHPdKGglhvvAA5Zht/1k3bcd
    a9aEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D3oPoLUB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X9qbJBi/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D3oPoLUB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X9qbJBi/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227bj9uhh3E4g1hv9M/d+0Ie7AczAILO6hPbHxosJl+A6XCCw/w8fn/0RWVzrycbolIGfEWx6A==
Date: Mon, 19 Feb 2018 13:28:32 -0300
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] staging:iio:meter: Add name to function definition
 arguments
Message-ID: <20180219162832.qbkogggfzwbgsqlt@smtp.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
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

This patch fixes the checkpatch.pl warning:

drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
argument 'struct device *' should also have an identifier name...

This commit adds arguments names to the signature declared in the
ade7854_state struct. For consistency reason, It also renames all
arguments in function definitions.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
  - Make the commit message clearer.
  - Use the same arguments name across signatures and definitions.

 drivers/staging/iio/meter/ade7754.c     |  6 +++---
 drivers/staging/iio/meter/ade7854-i2c.c | 28 ++++++++++++++--------------
 drivers/staging/iio/meter/ade7854-spi.c | 28 ++++++++++++++--------------
 drivers/staging/iio/meter/ade7854.h     | 28 ++++++++++++++--------------
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 3a1e342d75fb..9aa067736715 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -132,7 +132,7 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 }
 
 static int ade7754_spi_write_reg_16(struct device *dev,
-				    u8 reg_address, u16 value)
+				    u8 reg_address, u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -140,8 +140,8 @@ static int ade7754_spi_write_reg_16(struct device *dev,
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7754_WRITE_REG(reg_address);
-	st->tx[1] = (value >> 8) & 0xFF;
-	st->tx[2] = value & 0xFF;
+	st->tx[1] = (val >> 8) & 0xFF;
+	st->tx[2] = val & 0xFF;
 	ret = spi_write(st->us, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 8106f8cceeab..317e4f0d8176 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -17,7 +17,7 @@
 
 static int ade7854_i2c_write_reg_8(struct device *dev,
 				   u16 reg_address,
-				   u8 value)
+				   u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -26,7 +26,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = value;
+	st->tx[2] = val;
 
 	ret = i2c_master_send(st->i2c, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
@@ -36,7 +36,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 
 static int ade7854_i2c_write_reg_16(struct device *dev,
 				    u16 reg_address,
-				    u16 value)
+				    u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -45,8 +45,8 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (value >> 8) & 0xFF;
-	st->tx[3] = value & 0xFF;
+	st->tx[2] = (val >> 8) & 0xFF;
+	st->tx[3] = val & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 4);
 	mutex_unlock(&st->buf_lock);
@@ -56,7 +56,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
 				    u16 reg_address,
-				    u32 value)
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -65,9 +65,9 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (value >> 16) & 0xFF;
-	st->tx[3] = (value >> 8) & 0xFF;
-	st->tx[4] = value & 0xFF;
+	st->tx[2] = (val >> 16) & 0xFF;
+	st->tx[3] = (val >> 8) & 0xFF;
+	st->tx[4] = val & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 5);
 	mutex_unlock(&st->buf_lock);
@@ -77,7 +77,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
 				    u16 reg_address,
-				    u32 value)
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -86,10 +86,10 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (value >> 24) & 0xFF;
-	st->tx[3] = (value >> 16) & 0xFF;
-	st->tx[4] = (value >> 8) & 0xFF;
-	st->tx[5] = value & 0xFF;
+	st->tx[2] = (val >> 24) & 0xFF;
+	st->tx[3] = (val >> 16) & 0xFF;
+	st->tx[4] = (val >> 8) & 0xFF;
+	st->tx[5] = val & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 63e200ffd1f2..72eddfec21f7 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -17,7 +17,7 @@
 
 static int ade7854_spi_write_reg_8(struct device *dev,
 		u16 reg_address,
-		u8 value)
+		u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -32,7 +32,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = value & 0xFF;
+	st->tx[3] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
@@ -42,7 +42,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 
 static int ade7854_spi_write_reg_16(struct device *dev,
 		u16 reg_address,
-		u16 value)
+		u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -57,8 +57,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 8) & 0xFF;
-	st->tx[4] = value & 0xFF;
+	st->tx[3] = (val >> 8) & 0xFF;
+	st->tx[4] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
@@ -68,7 +68,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 
 static int ade7854_spi_write_reg_24(struct device *dev,
 		u16 reg_address,
-		u32 value)
+		u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -83,9 +83,9 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 16) & 0xFF;
-	st->tx[4] = (value >> 8) & 0xFF;
-	st->tx[5] = value & 0xFF;
+	st->tx[3] = (val >> 16) & 0xFF;
+	st->tx[4] = (val >> 8) & 0xFF;
+	st->tx[5] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
@@ -95,7 +95,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 
 static int ade7854_spi_write_reg_32(struct device *dev,
 		u16 reg_address,
-		u32 value)
+		u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -110,10 +110,10 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 24) & 0xFF;
-	st->tx[4] = (value >> 16) & 0xFF;
-	st->tx[5] = (value >> 8) & 0xFF;
-	st->tx[6] = value & 0xFF;
+	st->tx[3] = (val >> 24) & 0xFF;
+	st->tx[4] = (val >> 16) & 0xFF;
+	st->tx[5] = (val >> 8) & 0xFF;
+	st->tx[6] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index c27247a7891a..a82d38224cbd 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -152,20 +152,20 @@
  * @rx:			receive buffer
  **/
 struct ade7854_state {
-	struct spi_device	*spi;
-	struct i2c_client	*i2c;
-	int			(*read_reg_8)(struct device *, u16, u8 *);
-	int			(*read_reg_16)(struct device *, u16, u16 *);
-	int			(*read_reg_24)(struct device *, u16, u32 *);
-	int			(*read_reg_32)(struct device *, u16, u32 *);
-	int			(*write_reg_8)(struct device *, u16, u8);
-	int			(*write_reg_16)(struct device *, u16, u16);
-	int			(*write_reg_24)(struct device *, u16, u32);
-	int			(*write_reg_32)(struct device *, u16, u32);
-	int			irq;
-	struct mutex		buf_lock;
-	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7854_MAX_RX];
+	struct spi_device *spi;
+	struct i2c_client *i2c;
+	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
+	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
+	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
+	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
+	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
+	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
+	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
+	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
+	int irq;
+	struct mutex buf_lock;
+	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
+	u8 rx[ADE7854_MAX_RX];
 
 };
 
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
