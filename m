Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4094253-1524311767-2-9029509894805128988
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524311766; b=SpK4h/naIianhUY0AHDJlwi0t6ASvdDM9ECBMr43rXHH+DZwH9
    qoJL6sjVtj7Y5XomfU/OzsElWG188I6KwGy1uLWCKXkOo7ksVEBfRQlGqT0zzAck
    ghg+ezo4UocILLu5xcf4CG6zdTbyDNurGtMfMzb9qO7KJyI9+1YY0R8bJcMZvLZ9
    qrKA9IGfICPJbV9yhgNqzXXywiAh8hDHwdcyZx01wRKjexLuXRO/qPBgU15g5vlp
    tCgDoszBf+hshd6m789PTpAGI9XbGYnPSbKj2BIy3WoBMIBQ64g/KfxzRAhMihic
    HxRfX91KV4uhtaoEH8nx2hQfbsY/YYg/BXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524311766; bh=6EBJS
    RwFn2bmnXUg8QNm9xzhRVp6H8DMyS/zr6fsk9Y=; b=Lq18BFWSCRdJnYil3eEEp
    yEzzU3y+PjA94SNMCnuM8v/TcviS5bIZn/jev7OVKDiwJ0iq9zcJSynLAj66Q32U
    3nfdAXGRfcnrmzGVY90DSi3tWkzBSXu5MkZYBA6qYiSg12F9itCyQxS1A7xtciw1
    gxmZsNLNsHTGrZcFqEC/oh8GyZd1KnAPovnViNhZER7CXYTuXwvskzcZLT78ewls
    ctgWAlkJhF0WcfzJQ4y5x4NRlBuLma2iKU+/wGe+5nMwzF3JSk6WtDf8yG8XfAu7
    q9OcYaCaHwPeAIQWE485Bobhwxlk2wDRcP6S7Avz/2Shs73EkPlsTWrDIHlAY/aA
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rW08Fixg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=K/9/slNO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rW08Fixg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=K/9/slNO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPaTumgna7eUQ00siyt84Go7LcInwPjqwuUKKeAAUDG1itb1WknUXnOjLFpGu7DykuvqvY0CisU1QfS6FuD4UdlJGKmBfBr0z03lwseGYWE2B576TYI/
    3DxND9p25QLSGtYrtp72dp6xgJf3DlLtgcNpJEWK6rveypPKCRSba/k381OIEnhomhGsjYuoGkvLdosoRVGgx4fDepDTidkHIBJhKInvBaK573VxcxOzOHCt
    ig7O5zT4wp9wY6TU5+Mg7w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=px3f5oUF_X8A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=0vQS1--XZT20WKcNXioA:9
    a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=LKaD5f4U21sCTSoq:21 a=NSCniYQ-T9Yp5EoL:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+esC0MMsKYm9wqcrCNqPoPrKD3qSDZkZiw7zRlmkhhctqoP+vsYiT/IRIUcVwgjLZaYDuhiw==
Date: Sat, 21 Apr 2018 08:55:52 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Syne <john3909@gmail.com>
Subject: [PATCH 2/3] stagging:iio:meter: Add ade7854_read_raw function
Message-ID: <9900ff3d492dbca4dc39cdd8ca6490af05a4f09a.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180323
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
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds the ade7854_read_raw() function which is responsible for
handling the read operation for registers: AIGAIN, BIGAIN, CIGAIN,
NIGAIN, AVGAIN, BVGAIN, and CVGAIN. For the sake of simplicity, this
patch only adds basic manipulation for current and voltage channels.
Finally, this patch disables the old approach for reading data.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 41 ++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 2fbb2570ba54..242ecde75900 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -229,31 +229,31 @@ static int ade7854_reset(struct device *dev)
 }
 
 static IIO_DEV_ATTR_AIGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_AIGAIN);
 static IIO_DEV_ATTR_BIGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_BIGAIN);
 static IIO_DEV_ATTR_CIGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_CIGAIN);
 static IIO_DEV_ATTR_NIGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_NIGAIN);
 static IIO_DEV_ATTR_AVGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_AVGAIN);
 static IIO_DEV_ATTR_BVGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_BVGAIN);
 static IIO_DEV_ATTR_CVGAIN(0644,
-		ade7854_read_24bit,
+		NULL,
 		ade7854_write_24bit,
 		ADE7854_CVGAIN);
 static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
@@ -471,6 +471,32 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
 }
 
+static int ade7854_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long mask)
+{
+	struct ade7854_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_CURRENT:
+	case IIO_VOLTAGE:
+		ret = st->read_reg(&indio_dev->dev, chan->address, val, 24);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int ade7854_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -572,6 +598,7 @@ static const struct attribute_group ade7854_attribute_group = {
 
 static const struct iio_info ade7854_info = {
 	.attrs = &ade7854_attribute_group,
+	.read_raw = &ade7854_read_raw,
 };
 
 int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
