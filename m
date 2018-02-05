Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3245219-1517859659-2-2627664459787411955
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrosv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517859658; b=g6uqlEhB77t07lwKQol525Th91olSgwQDdGIyrVuIOxD8XF
    n+B4+Rkluckd1XNHT6GCn0YQCvPK2aqaYpl3XMGeQJKyoco1jaHYkzY93AEQ1zad
    +iLBmcPSAGSJrYpt2HjS3V4Q7ERiBtzkzzwMmWZm90BOk55OmspQIFSqMJAIPZ7t
    yEu0synei+WcG6/rV0ss74yQ69tCYeKrDS3Uzi46cQswjQGqRAPpZPn+MB6ekkCT
    Y39u/HY53mcaStPyqMVXIAUdt/nc/S+IYl+m/hCdlkQcsDa5FdrFLWNxPNN5anDf
    AhCvFzOyA36NWq4pW+5sw5E4Q8fERIM5ERR2Fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517859658; bh=5
    XWVRzKZohh7grVhzjNBR6I9Z8EGNrM0ilqyB53KuLI=; b=fISJGdOhtCtedM6/k
    scRlcKI8z6Rry66SwQ1a4PveFT43+cnDyZ5jfKrqgCX05h5NlYjoDssV2fC1NJVM
    do4SHnJrS7CKKVFF3vDR1deJtNuXOpLg6MtJDfWnxw4+20m7SbQ+uzVDx/eyTHOD
    cT3TBYpXGplGNK3g02NTJMwnJrNIVSVDz50NTmNdBPVmSC+Cs3MmcX7Hm4pQ70sG
    xPvdodPyPpv9FCtPhXutTagEDRHGGffDlV/9izjRyag3c+0zak4fgTAWp8vKjSaI
    1+bVaYAFnPOZit7cWGxOOYg05x3vd14jBGpzDwCuAfGMsbhKyD7nOn3Azn/heHqE
    T9Tkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KIa/7MJx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XWFlxiF7;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KIa/7MJx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XWFlxiF7;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225c7nybl6CbFXPUqh70uIwdA5HBLGVmF8E3l2SF8WUUXqifMKBtiOgKdbz2XoKnS+CBpVLTFg==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer and state protection
Date: Tue,  6 Feb 2018 01:10:45 +0530
Message-Id: <ec1848899e808fd5544bb1ca640abdc48fdfd6f3.1517845616.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517845616.git.shreeya.patel23498@gmail.com>
References: <cover.1517845616.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

iio_dev->mlock is to be used only by the IIO core for protecting
device mode changes between INDIO_DIRECT and INDIO_BUFFER.

This patch replaces the use of mlock with the already established
buf_lock mutex.

Introducing 'unlocked' forms of read and write registers. The
read/write frequency functions now require buf_lock to be held.
That's not obvious so avoid this but moving the locking inside
the functions where it is then clear that they are taking the
unlocked forms of the register read/write.

It isn't readily apparent that write frequency function requires
the locks to be taken, so move it inside the function to where it
is required to protect.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v2
  -Add static keyword to newly introduced functions and remove some
added comments which are not required.

Changes in v3
  -Remove some useless mlocks and send it as another patch.
Also make the necessary change in the current patch associated with 
the new patch with commit id 88eba33. Make commit message more 
appropriate.

Changes in v4
  -Write frequency function do not require lock so move it inside
the function to where it is required to protect.

Changes in v5
  -Remove goto statement and make the code to return -EINVAL there
itself. 

 drivers/staging/iio/meter/ade7758.h      |  2 +-
 drivers/staging/iio/meter/ade7758_core.c | 52 +++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 6ae78d8..2de81b5 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -111,7 +111,7 @@
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
- * @buf_lock:		mutex to protect tx and rx
+ * @buf_lock:		mutex to protect tx, rx, read and write frequency
  **/
 struct ade7758_state {
 	struct spi_device	*us;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 227dbfc..dfe8e97 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -24,17 +24,25 @@
 #include "meter.h"
 #include "ade7758.h"
 
-int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
+static int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 {
-	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7758_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7758_WRITE_REG(reg_address);
 	st->tx[1] = val;
 
-	ret = spi_write(st->us, st->tx, 2);
+	return spi_write(st->us, st->tx, 2);
+}
+
+int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	ret = __ade7758_spi_write_reg_8(dev, reg_address, val);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -91,7 +99,7 @@ static int ade7758_spi_write_reg_24(struct device *dev, u8 reg_address,
 	return ret;
 }
 
-int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
+static int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7758_state *st = iio_priv(indio_dev);
@@ -111,7 +119,6 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 		},
 	};
 
-	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7758_READ_REG(reg_address);
 	st->tx[1] = 0;
 
@@ -124,7 +131,19 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 	*val = st->rx[0];
 
 error_ret:
+	return ret;
+}
+
+int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->buf_lock);
+	ret = __ade7758_spi_read_reg_8(dev, reg_address, val);
 	mutex_unlock(&st->buf_lock);
+
 	return ret;
 }
 
@@ -480,10 +499,12 @@ static int ade7758_read_samp_freq(struct device *dev, int *val)
 	return 0;
 }
 
-static int ade7758_write_samp_freq(struct device *dev, int val)
+static int ade7758_write_samp_freq(struct iio_dev *indio_dev, int val)
 {
 	int ret;
 	u8 reg, t;
+	struct ade7758_state *st = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
 
 	switch (val) {
 	case 26040:
@@ -499,20 +520,23 @@ static int ade7758_write_samp_freq(struct device *dev, int val)
 		t = 3;
 		break;
 	default:
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
+	mutex_lock(&st->buf_lock);
+
+	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
 	if (ret)
 		goto out;
 
 	reg &= ~(5 << 3);
 	reg |= t << 5;
 
-	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
+	ret = __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
 
 out:
+	mutex_unlock(&st->buf_lock);
+
 	return ret;
 }
 
@@ -545,9 +569,9 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
-		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+
+		ret = ade7758_write_samp_freq(indio_dev, val);
+
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
