Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521628173-2-5298344170186426003
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
    t=1521628172; b=Z3L6sUEddD2ciWq73XfTrTJlopKejwZ2zN4A90tAfm4zfAX
    sYvAgEonAmbSGDkiLbTERiUC2rWQKzTKl+ny+yblroWEKj9WnTsnKLJOghwIqJ2B
    GY3B2wl2FrYbp99yjdSItXWCtlrppefCpCHfDrKrPRhxiPFey5TQZZv17X/4X3aB
    Nx6rnBPkzjgt7Xx5kEbdWDhv4JslWMCvNQ9RU1H3yyFmkK0Eoa8YO5gX37Q2oKc/
    o4Vf3U6Ik/2LjIABg2hlp1EX4Ccs2NnQzQUS+kluwHfvhk94GvvrWKiSJB1kDyju
    Fh8r1L6Elz2LZUYAsih723lJZdn32MTrObNx5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628172; bh=/
    umSD4WXbmXwm3lg42o1nRtdY8ucjG4OUPfBAlyuulM=; b=LNsClw3RxUvDFdFYs
    a9Sm/ItHVb0hdWkfGdd0ia0KL+PK3RYHlYFRryWTwitYTZ3Y431bRYhzDlHPkap0
    FEE07kR6dT9JsDdE+sWvL2b14mvGVqcC/e/MxeWUiUc2QWVzudss8TXJ6SjUQt92
    TaVpx1FWgRONeshgIeEmcQcc4icEb0VJMkMXHl5JRvHCWU+8uaBHhg+6DHsuOJlF
    ieMf/reZS68iXAP2eDkFv6ebTreoamJdCHkmghlctLc5dJVkUCjLRM2zfR+ESQP1
    CmPUcUzN7/Gru0waR6Vwe/aF4iCpxd6pCIsO4qPX46pBAwfe1sRUzMJM7wE6QEsu
    schxg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=bhWI3gqL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=bhWI3gqL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
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
Subject: [PATCH 01/11] staging: iio: tsl2x7x: remove unnecessary code
Date: Wed, 21 Mar 2018 06:29:02 -0400
Message-Id: <20180321102912.5130-2-masneyb@onstation.org>
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

As a follow up to the work in commit a0722d05a195 ("staging: iio:
tsl2x7x: convert mutex_trylock() to mutex_lock()"), this patch removes
the unnecessary calls to tsl2x7x_get_prox() and tsl2x7x_get_lux() in
tsl2x7x_event_handler(). Previously, these functions were locked with
mutex_trylock(), but that is no longer the case. This patch also removes
a comment that is no longer relevant about returning the last sample.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 82681300e106..82cf9d853b18 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1430,7 +1430,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 	/* What type of interrupt do we need to process */
 	if (ret & TSL2X7X_STA_PRX_INTR) {
-		tsl2x7x_get_prox(indio_dev); /* freshen data for ABI */
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
 						    0,
@@ -1440,7 +1439,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 	}
 
 	if (ret & TSL2X7X_STA_ALS_INTR) {
-		tsl2x7x_get_lux(indio_dev); /* freshen data for ABI */
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
 						    0,
@@ -1745,10 +1743,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		return ret;
 	}
 
-	/*
-	 * ALS and PROX functions can be invoked via user space poll
-	 * or H/W interrupt. If busy return last sample.
-	 */
 	mutex_init(&chip->als_mutex);
 	mutex_init(&chip->prox_mutex);
 
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
