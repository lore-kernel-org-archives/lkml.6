Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1675485-1520383440-2-16376797010692894979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520383440; b=pUy9uLeuhfNS2oFZEHf2KKhdv0nzyoxTJGgBTGj7hLT3izh
    VK4gW715lXXQZOWVIwbp1e9H8S33JdPmD9kuGf7j9j4W1W8LbzbyLzELY0quFefy
    RGEmzakNgZI8myMIDgRjjL5F4GrD/Db//J8g3xWNr89YYUOsF2eX2P1ek2qJRG/3
    hVJf/dBlGRfvplyZ2nRaZyDOnn1DHgjYZ93bre2qwQ36iacf8za2ql7zg4tYnx92
    fFcizqTvqNUcEahy+lCbp58uYNhslFLH4pvnZombxTBRa4bAktgg6FkNtpgfS7MG
    foV+6sEOxRd4ANGU8qecsf+4qf89cl+snmM7y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520383440; bh=N
    6YBYffQWcqAJ122QjDLHz4HK5SMBmk6QqI0tnq+FaE=; b=YaG5fO036k7Qqdo/i
    016XzLd9ex2dN/xwckxxao1O0I0zrV4iqrelP8T+xj2xoM6+nrVtOsDGrxJKhEo8
    CElaqNTtIUV7+pcHHbrrRIdBXspNnNtT6rT8QwHofk0rDJBN1TxuQEVdFFx5mQoz
    GQM9RsFYuPvJJQY7YjkrLf2n7/HDoz+OT9qTiZKzk9IaHvTQbp+i+3jKzLHC9neV
    jVIwLvatdS8QzR1RUZ7/TvdyHaEHtn6OFYGiG0hrGWcUvyFRJkGCYRMud/EbU+Dz
    O6/wyiucTvCxcoK7Lrw73h6iro0lSVRFFTe9tX4sK+Yrz92bAft22U4G/+/KNzkr
    zbXbg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZlMNeRuz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sowLrUkd;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZlMNeRuz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sowLrUkd;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtAzgzDZ1JIuaNbZ+Ern/YO1WbHk46ZdpplnAJbkbZXBwjIGVzkQqLkMqybHTdKox8z51lXnQ==
Date: Tue, 6 Mar 2018 21:43:47 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by
 IIO_DEVICE_ATTR
Message-ID: <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
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

The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a
tiny change in the name definition. This extra macro does not improve
the readability and also creates some checkpatch errors.

This patch fixes the checkpatch.pl errors:

staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) not
decimal permissions
staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) not
decimal permissions
staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) not
decimal permissions
staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) not
decimal permissions

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
 drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index c44eb577dc35..275e8dfff836 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
 		ade7753_read_16bit,
 		NULL,
 		ADE7753_PERIOD);
-static IIO_DEV_ATTR_CH_OFF(1, 0644,
-		ade7753_read_8bit,
-		ade7753_write_8bit,
-		ADE7753_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, 0644,
-		ade7753_read_8bit,
-		ade7753_write_8bit,
-		ADE7753_CH2OS);
+
+static IIO_DEVICE_ATTR(choff_1, 0644,
+			ade7753_read_8bit,
+			ade7753_write_8bit,
+			ADE7753_CH1OS);
+
+static IIO_DEVICE_ATTR(choff_2, 0644,
+			ade7753_read_8bit,
+			ade7753_write_8bit,
+			ADE7753_CH2OS);
 
 static int ade7753_set_irq(struct device *dev, bool enable)
 {
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1decb2b8afab..c078b770fa53 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_APGAIN);
-static IIO_DEV_ATTR_CH_OFF(1, 0644,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, 0644,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CH2OS);
+
+static IIO_DEVICE_ATTR(choff_1, 0644,
+			ade7759_read_8bit,
+			ade7759_write_8bit,
+			ADE7759_CH1OS);
+
+static IIO_DEVICE_ATTR(choff_2, 0644,
+			ade7759_read_8bit,
+			ade7759_write_8bit,
+			ADE7759_CH2OS);
 
 static int ade7759_set_irq(struct device *dev, bool enable)
 {
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
