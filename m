Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3527955-1520957179-2-9027052227585937843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520957178; b=P8wkL2kcNSSqbFTcZpjNnzLknUPKp8IRx228u6sbdKwfZRW
    YW7ut2uNE1i7uqFFnerP9mcznOuqHX2p2f9BZlAVJMpEvPSpIrf+cbowjfgRYmWM
    NYoq3ievk8p/vmNgWmr0SJhtj7XuQ49OJ3UmO+ASGI89BfD4Qq5N6bnTZG6MINCw
    1GXkZls9UJ06JInScIGCcJK3tff6DCGXXRmbFV9RTT3bCz7gV2k5BlERP01E3nfu
    XOFooHYGM7ZQ1gWBeOR2vJvZHE0DnMOXxGq8+reHz8pNBExMvASxtE1J0V8+WF3y
    HF4mB/rrqKorYLJXVuLxqezS4rfvhxy84z9hBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520957178; bh=Z
    ap+EJvbuPDKya01+xiLVa8byDlhai8YfrK09tNaWEk=; b=rUo4IRcbcjnuKQBJk
    PBEymTu28ByFNYde9wyrVjoxMQgaa/yM5Iyn9hD3Tgwo1+C+KDNzLROIuAqs6Av7
    +g8akss+c9D+9dVMKxpz96RIbrQkCrHi9Yn9Jbt6AZQJ+xD8/dDxrBTVzFJt+Ztz
    8Ao/MXYGc2+KMU/vpSEChbfWZ9Sl/WKuKQ9vDfg6xz+zXa0n/GGkAUj/nYFF/KsU
    Nk2E8K94v0EqYdKC87Qu3wcqON1srnk/tZCxVMfgsq0GfZwQRoOjTaG6pjZwk4WE
    g1XJuyRwc0YQCqFDTH7SMwQiQeggKGJ1OJtjSOPd2+TT+mHxoiPb9DyijyE4UePV
    jxIPQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mNBOiBoj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IYHB5Fvh;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mNBOiBoj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IYHB5Fvh;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtpzkOioYQHowmFKfNkxBtn+1l/qUs3Vfm2KO0qK84DqUoIrifiBI/jFViMf696YzRmqr5EVw==
Date: Tue, 13 Mar 2018 13:06:05 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH v2 3/3] staging:iio:ad2s1210: Add write_raw to handle frequency
Message-ID: <8eaa05b021f1be0f1c8666b0030ba36abc98195e.1520956563.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
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

The write interface of AD2S1210 utilizes IIO_DEVICE_ATTR, which violate
the official IIO ABI. This patch, add the write_raw function responsible
for handling the fclkin and fexcit channel; also it removes the use of
IIO_DEVICE_ATTR for fclkin and fexcit.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
 - Removes unnecessary switch case in the write_raw function.
 - Replaces the use of goto for direct return.
 - Removes definition with string.
 - Removes unecessary label.

 drivers/staging/iio/resolver/ad2s1210.c | 107 ++++++++++++++------------------
 1 file changed, 45 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 27a42ed10fcd..001ddca92e8f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -210,64 +210,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-static ssize_t ad2s1210_store_fclkin(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fclkin;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fclkin);
-	if (ret)
-		return ret;
-	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
-		dev_err(dev, "ad2s1210: fclkin out of range\n");
-		return -EINVAL;
-	}
-
-	mutex_lock(&st->lock);
-	st->fclkin = fclkin;
-
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
-static ssize_t ad2s1210_store_fexcit(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fexcit;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fexcit);
-	if (ret < 0)
-		return ret;
-	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
-		dev_err(dev,
-			"ad2s1210: excitation frequency out of range\n");
-		return -EINVAL;
-	}
-	mutex_lock(&st->lock);
-	st->fexcit = fexcit;
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
 static ssize_t ad2s1210_show_control(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -545,8 +487,50 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644, NULL, ad2s1210_store_fclkin, 0);
-static IIO_DEVICE_ATTR(fexcit, 0644, NULL, ad2s1210_store_fexcit, 0);
+static int ad2s1210_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	unsigned int clk = val;
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_FREQUENCY)
+		return -EINVAL;
+
+	switch (chan->channel) {
+	case FCLKIN:
+		if (clk < AD2S1210_MIN_CLKIN ||
+		    clk > AD2S1210_MAX_CLKIN) {
+			dev_err(&indio_dev->dev,
+				"ad2s1210: fclkin out of range\n");
+			return -EINVAL;
+		}
+		mutex_lock(&st->lock);
+		st->fclkin = clk;
+		break;
+	case FEXCIT:
+		if (clk < AD2S1210_MIN_EXCIT ||
+		    clk > AD2S1210_MAX_EXCIT) {
+			dev_err(&indio_dev->dev,
+				"ad2s1210: excitation frequency out of range\n");
+			return -EINVAL;
+		}
+		mutex_lock(&st->lock);
+		st->fexcit = clk;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ret = ad2s1210_update_frequency_control_word(st);
+	if (ret < 0)
+		goto error_unlock_mutex;
+	ret = ad2s1210_soft_reset(st);
+error_unlock_mutex:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
 static IIO_DEVICE_ATTR(control, 0644,
 		       ad2s1210_show_control, ad2s1210_store_control, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
@@ -577,8 +561,6 @@ static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
 		       AD2S1210_REG_LOT_LOW_THRD);
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fclkin.dev_attr.attr,
-	&iio_dev_attr_fexcit.dev_attr.attr,
 	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
@@ -635,6 +617,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
+	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
 };
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
