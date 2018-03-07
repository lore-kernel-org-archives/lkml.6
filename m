Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2240270-1520399432-2-18198613562244543260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES dasven, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520399432; b=ewz7I5faVnV88N9DUQV8r1+eMToWOh/H+0fr9p2E99OX8Vc
    dQLH18N6nfANnVNWDDiV7ZZwpZZfOmkYnmLoYWCJQZ3i20T64H3uhdg9ltx4xFA4
    AQ01kguuYJwLuNVuafRppwCo8kz9WlJ7RbP9uXTn5HJ4/oDOUpWR+qkESqPojFmN
    xPj6a27Uxa5tyK1lX2gcmHpw2wlMriYn9R8qUtNI+gE9JnmSy0zEvZwoBu86NNP6
    Y4wqIeOC5uNC0D7cSY5Rd2vlzmxZBi3n6ygcqg/5dHuR3jEjs6PXQ/inPVTfo6tR
    1FGBZx7Ws9I4b1s8tV3hiEj4FsDt69lUlLnY4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520399432; bh=+
    TTLl0RNnRMjBn25xkvD+AD+5FGzblqw6TUudyoihX4=; b=q87MS+PY8jWizdQOk
    /LZilMZmWVaxQzH/NYagjy7Wz9P9BLbD40gYoottg/px2PK4kAELnPpgenGTi1aP
    SRYnO5uPeI9CHwSBuWMpoUmGpu3fpgN5qVHUmRKdyPe4h1/mJMKdk/dqIxaTCQDf
    DBtT9zT5r6nBmGt1fl7oqk/sWzXF8Wke23oK/u1CJVieVP3J4m6irFqeoAjoBoCY
    bvVQOxlD7UeAW93ROwOrnl05NcK2auNXZL4vPbeJWpoYfw+pEQTg3d/vA1aHCecL
    v5BKxregHFvwYOkH9IX0T+36bFmFEfy4Rg3Lf7f1LnIqqAJjDU9O8Llb5ZEJ3c0A
    3jWSA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IAW5ml5H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=puEp0U1y;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IAW5ml5H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=puEp0U1y;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELufp6njxxHskFLQmVg6mTRbowg3xOsvnQ6Qu6ZXtoap/027WPPjtwn8tH2ewwHlVamSCpW5KQ==
From: hariprasath.elango@gmail.com
To: lars@metafoo.de
Subject: [PATCH] staging: iio: adc: Remove reduntant __func__ from debug print
Date: Wed,  7 Mar 2018 10:40:05 +0530
Message-Id: <20180307051005.13038-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
Cc: devel@driverdev.osuosl.org,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

dev_dbg includes the function name & line number by default when dynamic
debugging is enabled. Hence__func__ is reduntant here and removed.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 1f0d1a0..da489ae 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -34,7 +34,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
-	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	dev_dbg(&indio_dev->dev, "(%d)\n", state);
 	return ade7758_set_irq(&indio_dev->dev, state);
 }
 
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
