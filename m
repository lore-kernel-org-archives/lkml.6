Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521628175-2-2370826726055599783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628174; b=FaJVqnuA+23/IFWrHeIynGERgPtpybNcVqWgSL0YH9MWAro
    dtyHK1GRtMKYZoGmBbkg9aHv51KhG9GxJoK7+o352qc/PmBa6tB3A1RKlqfKWEP0
    R/tSvem9++vqC/uaHBlH2c9xu8/hBCwzbEbj6cSHH7DB3/6vztjfo5CKcdvRZXbD
    Iy1FtRegyeHuq4XzeE74Ui6pIt+OX54Wa0/YxbBv0MgQ0aPfiBE73KpCSDxqEjHu
    xj/syduslV5Texr4UvRqCoouaScMhlSakM6T+tEnQtQCpFckDpVqEqDf7vsxVgHd
    Qdpl/VL/vbWNLUD+pkyR5K6GEVmH8kdAia+fCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628174; bh=n
    jPTtZXifYrFBpohr3OI8NinYoDA0sFC1tKxa1KLLl8=; b=Dfql+H7SWBBj4s1n+
    GxT5vAuYlbvNUcGrfJ8lgKQLSffCvYNgHTuIZabkkOS85No5SOZHTuCZxX9jM/lI
    rGoJ8G2gWhzSYVrXG4GwHCv61+IH4uzJrHqt/q7OF4Oa3HVZlXgVsOt6HEvP9dPA
    CXXmhDi8saCZZMLhS7VnwapOQ9934IYzBVtV7HjHFxXlHQhl8vQ4AkfBP4h02Kd3
    2tLoj9DXLqpDWHZ59bhSLGnqdVvD28QBzll89UF3yzigKVrRMuecZWMQBjYTYasQ
    SeyZWB5fpA18N36lA4t8DnecYOR+nhTo/f2qA6y/VN5crkngARgDDJ1lj8BJEH1U
    J8XFw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=SPx02r3E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=SPx02r3E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 00/11] staging: iio: tsl2x7x: staging cleanups
Date: Wed, 21 Mar 2018 06:29:01 -0400
Message-Id: <20180321102912.5130-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
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

Here is another set of staging cleanups for the tsl2x7x driver. The
driver is about ready to move out of staging. I want to test a few other
things first before submitting a patch to move the driver out of
staging.

High-level changes in this series:
- Interrupts and IIO events now work properly
. Split out interrupt and persistence variables into separate ALS and
  proximity variables to improve code readability.
- Simplify code, remove unnecessary code, and improve code readability.

# How to test the interrupts

cd /sys/bus/iio/devices/iio:device0

echo 0 > events/in_intensity0_thresh_falling_value
echo 512 > events/in_intensity0_thresh_rising_value
echo 1 > events/in_intensity0_thresh_rising_en

# proximity0 already has threshold range at [0,512]
echo 1 > events/in_proximity0_thresh_rising_en

Run iio_event_monitor tsl2772 and verify that events are sent properly.

Question: Should I use in_intensity0_thresh_either_en instead of
in_intensity0_thresh_{rising,falling}_en? The same goes for the
proximity0. This is the current contents of the events/ directory:

in_intensity0_thresh_either_period
in_intensity0_thresh_falling_en
in_intensity0_thresh_falling_value
in_intensity0_thresh_rising_en
in_intensity0_thresh_rising_value
in_proximity0_thresh_either_period
in_proximity0_thresh_falling_en
in_proximity0_thresh_falling_value
in_proximity0_thresh_rising_en
in_proximity0_thresh_rising_value

Brian Masney (11):
  staging: iio: tsl2x7x: remove unnecessary code
  staging: iio: tsl2x7x: correct interrupt handler trigger
  staging: iio: tsl2x7x: no need to clear interrupt flag when getting
    lux
  staging: iio: tsl2x7x: simplify tsl2x7x_prox_cal()
  staging: iio: tsl2x7x: split out als and prox interrupt settings
  staging: iio: tsl2x7x: make logging consistent and correct newlines
  staging: iio: tsl2x7x: split out als and prox persistence settings
  staging: iio: tsl2x7x: remove unused variables from tsl2x7x_get_lux()
  staging: iio: tsl2x7x: remove ch0 and ch1 variables from
    tsl2x7x_get_lux()
  staging: iio: tsl2x7x: put local variables in reverse Christmas tree
    order
  staging: iio: tsl2x7x: add copyright

 drivers/staging/iio/light/tsl2x7x.c | 300 ++++++++++--------------------------
 drivers/staging/iio/light/tsl2x7x.h |  16 +-
 2 files changed, 91 insertions(+), 225 deletions(-)

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
