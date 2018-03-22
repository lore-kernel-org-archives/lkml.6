Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3492523-1521745999-2-16432767801454080403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521745998; b=N6UaBnVuV98mNp10A/4sMwkyfxP3vh3i8Z6r1gN1BhkZyiR
    oFS02yK8MbhRGn92ixOHvkvGb0i4srRz5hXtpqIaPQ+H0mU9jJOmfSkgaH7S4DTa
    ge7RjnOE+Ljt6VTA3JJ0asF4cuXkfwXc64WImluQc7RsvFpf/igBnA1lv6k//4LB
    gnAlxlq3njMt7v4IfNTzRn1uD6YYkqo8JyBzkeyP3SeOHaHe1KWZVzecfiToSTbS
    GcUNeMggSAnGqD9zvkghPNf07dRPF3HNWerOO4Gpig3N2gQLyRe6XnoOM8QzLrcv
    ukepEKPxeGg0wMJuwU776HVmCwgYkxOYmt1JBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521745998; bh=k
    BNiO2E8cipc8JMaO/sUqgBRmxWFe0V1M3cAVBIjslg=; b=BehtSzGmjOI4Dn6CM
    F1877H/MCZ9/3n+t5TO3c63MCZaaT0Lh6E2XRgdkOcMbUWskXm1o7U/WIltKY4KD
    x4w1vjHNKlmW6JrYAnc5cBWd+5ukaRJcnq0HwclteLP1Qw7h8q7sWULPvMS4wt2S
    gxtMjfEKdtou+dgF9iDVbMzBPHAW3h9nwsZAQ92Pn3/3oYVnl1aqw1mw62cwqOeM
    ZHvEUS8NTN0DXH2aMyn20Z/0uF/588zCFhhF3GlWHqXXhcAf/XZHFbpUohRjOxdM
    BYdUA/eudkOKnozo8S6I1jBxNdDTIz2+ATuvfxkpILHsdg1Rc65Kdhqf1yhWQz2f
    QEQvA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TJdkwzDZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YWfov3jw;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TJdkwzDZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YWfov3jw;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt7hGIxGLzPxvtVj0xXLLJEp0tOAVOIa5ufW6sbCs4Ll8KpbAhXZ9mpTxW8w2HTw7e6daxVwA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 2/4] Staging: iio: accel: adis16201: Use GENMASK
Date: Fri, 23 Mar 2018 00:42:43 +0530
Message-Id: <1521745965-26972-2-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
 <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>,
 pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use GENMASK to improve readability and remove the local variables used to
store intermediate data.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index b04dbb3..e7593fa 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -185,28 +185,24 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	int bits;
-	s16 val16;
-	u8 addr;
+	int m;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ACCEL:
-			bits = 12;
-			break;
-		case IIO_INCLI:
-			bits = 9;
-			break;
-		default:
-			return -EINVAL;
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		m = GENMASK(11, 0);
+		break;
+	case IIO_INCLI:
+		m = GENMASK(8, 0);
+		break;
+	default:
+		return -EINVAL;
 		}
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16201_addresses[chan->scan_index];
-		return adis_write_reg_16(st, addr, val16);
-	}
 
-	return -EINVAL;
+	return adis_write_reg_16(st, adis16201_addresses[chan->scan_index],
+				 val & m);
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
