Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520339151-2-6138263397229428115
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
    t=1520339150; b=N8HIYfawyhl7peYgeWU5/zcCSQ9uI9eEhAehOA4lhD0x25x
    EffO6w/Y6UIBOAU88gJa/RgcOwRW9kjkqLrO/B+C3kJKFhs3UAGjLGObmD/mfE7N
    szJ3ZizzFMk/6Y6mtpbI325gm93VHV+VuB5Eo8s9B4aRvpw++0Nm7yifWad5P6Fb
    CLVcXzu6ss/viN1TWAU5oMZ/1QY147o3V/HHw3aMbwFWg6Vyo0RRgeIGTqM6N5st
    9i8kJQlcVVsgoUothiXqPsRYeGa12BWlHh6NTGH53SKT/jI0Vzgm0DYf13DSIbur
    +Kbw6MaqUJNdSs+HdRyvdJHlIrTowLk7PlrP77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520339150; bh=N
    6YBYffQWcqAJ122QjDLHz4HK5SMBmk6QqI0tnq+FaE=; b=ektkJN/Ha3fVpBMh2
    ImRqCdRitSlfOOP4QqkfojdFSuXyC30PaZgN5AVtA9yWdVo2M8C93qrglaw/uQIc
    EkWjzdVJ0Mpl4D9IdIDJx0UDk9mm8Aw0DEpEFlRWok7BCw4LE50ZZ2DJZk9UEo1w
    Gsxqd72pONQxUOnS4Q4+xJz3CH3D30WKvPudU2rcx6gXhV1OV6jtjsYD6rHDkTnb
    D1lvBnWyfyJkKqT7BbRZ5vnY0+XD5ByHgY9IcXxblbgUcn1S8RpJvMbtduL9kShJ
    Q2AjKcAjz0NaB898bY5S3fu+GdUbiaiqSckXdfDecWa/K0NllAkAa754f83n675w
    3f+6Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CtXpoetf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pAGuBrUr;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CtXpoetf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pAGuBrUr;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELseKSLDiw74ZDthdeDj7rLnP4zzFtOxyV2gCg5aQmWak/2ZXH+4x+h9EhWzdPeSBcu6SC7h5Q==
Date: Tue, 6 Mar 2018 09:25:37 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by
 IIO_DEVICE_ATTR
Message-ID: <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520338980.git.rodrigosiqueiramelo@gmail.com>
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
