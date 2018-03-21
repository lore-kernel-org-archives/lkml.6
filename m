Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521628182-2-658266018791067550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628181; b=vILtrvM+T41XCpTR8TzL83fK15Yb4nPjxq9eysFRyfG7UCl
    m80hj22IaFIaQ9vcm/su6G56SR1IVTMuUgdMZcWMVm8nt8tBTN6Weh+K9w7LcFbs
    wDMtxlIDuxOZ/j33s2kxEdBu2r7L35Ie5QqWF+dW5HxV/gWiP95T5Kr4hw//Rgbl
    W0Dry48S/sdX5SRxIEFVEGXbjif1hcYmA+8nVyKllFmyHzgpFw2qR2fXxGOB4SXn
    mP/Jj75rE+saAIC7zLHJKKGoGNLj9dWyYQKxOa+JFNpWh14DXVkPYCkj8mNtqbT4
    L5Ba4JOEsCCwEqsRjZZxbPSoX5dRqtLZNGb7CxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628181; bh=R
    vCfDa76fg8iiyxE+Rq/avKSbgMbQdcQbzijd486NKE=; b=ppEs8d5Z7EcaFDjHO
    F7zjQ2mXZuObuC3VgqgxSuh/QxCuP/kpd1EUxTCs58NNeYnh9IRQBNXQ4mFcYkfV
    biq2NzswIYKNn2msHig2RfQRfk7OV1c5VGg3zPeHlzxjUdrl+UoG1GeEFZJv7pMq
    EYVYVX52y0XUEyiJtmsTP//i/35f6KhI0/I2BPdS1KAHiuCvGQjJ9p0hFvjzaDFg
    5S9I5gQcvstFhEwTVyaQje0WowHLu7gIb0A1G/8oTYJqwNuvLCVlF58HRXNw9Rkd
    PVuRIjvZBtHWiP9Yb/XteBWCuIwhhoBN0p7gCmGlRaNMW+bpS4PNcuDdc0UNkS7b
    Fby3g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=kxD8hLPR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=kxD8hLPR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
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
Subject: [PATCH 10/11] staging: iio: tsl2x7x: put local variables in reverse
 Christmas tree order
Date: Wed, 21 Mar 2018 06:29:11 -0400
Message-Id: <20180321102912.5130-11-masneyb@onstation.org>
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

This patch ensures that all of the local variable declarations are in
reverse Christmas tree order where possible to increase code
readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 65b7fbca8c5d..5f78664d2b0e 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -336,13 +336,12 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
  */
 static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 {
-	u32 lux; /* raw lux calculated from device data */
-	u64 lux64;
-	u32 ratio;
-	u8 buf[4];
-	struct tsl2x7x_lux *p;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
+	struct tsl2x7x_lux *p;
+	u32 lux, ratio;
 	int i, ret;
+	u64 lux64;
+	u8 buf[4];
 
 	mutex_lock(&chip->als_mutex);
 
@@ -589,13 +588,9 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 
 static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 {
-	int i;
-	int ret = 0;
-	u8 *dev_reg;
-	int als_count;
-	int als_time;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	u8 reg_val = 0;
+	int ret, i, als_count, als_time;
+	u8 *dev_reg, reg_val;
 
 	/* Non calculated parameters */
 	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
@@ -1121,8 +1116,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 			    int *val2,
 			    long mask)
 {
-	int ret = -EINVAL;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
+	int ret = -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1583,9 +1578,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 static int tsl2x7x_probe(struct i2c_client *clientp,
 			 const struct i2c_device_id *id)
 {
-	int ret;
 	struct iio_dev *indio_dev;
 	struct tsl2X7X_chip *chip;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
 	if (!indio_dev)
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
