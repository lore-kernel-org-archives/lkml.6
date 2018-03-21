Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521628177-5-18332920312784178390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628176; b=T0RPz36hzUKFLN+9zYlHaQJHcu5flPgjNAp2lQBZ+GDj4TZ
    5Tinmj679iSm063jFSezyEd4f+Ok3hMwirBX3rzd2TWhjpqwb6jGdptQS4wPH2wT
    hUT5DuRSxOkgj6YhWH/zN8WzZPyIrnqemPFE2XaF6sqxaPAheTyalyNXH/jboqfV
    IAi3U3YtJEKdHeufVgv7vKYySzvDUTF+haDOZf8ampS6+5n/Vv6+x/Jh+cc69mRe
    jNegiDf1VFqDmxxNiRbxUvl0JUPzSAvK9M7fwFYagxvVwitgwZFhEEsF86pWdp5y
    jH+MGad0TLwE4R2jf4M/T8BdxWyBOmOFgvMW8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628176; bh=D
    ugtZV/YnuqGTGgLH1XfEAvbptCzihT/9FWeVe3S2VQ=; b=tiax9zaXhfruPkZ4r
    e8qL6fnB+sze6Oe7Ow3q1OYvQSNxXIrQk6PBJVQS/yoam0tRWrdPYiNCHKBkUgR0
    Y3VBuwBsoqW+7X8VGi5KRniVXW0BjapSRb7JowfyTjKfk4vlHW/kBlKuDnwxAfpA
    wB3DSNdpdwk1jW+IVENr34QCzx4h1gF4Tl7FWcgpGbhqI1o+HzkCAFpmMiab2ECU
    MqhEs6Cc5zDv/EvvamhBFBBCLYq6PHx0IMhL8M1LeW4ItsEq/SkmaFihhkN1ZYRk
    XWbIyDncvZsqmWCs3jVUi5ItrebXYs7aj0PFYfHXYUCuUBrSeABqS/viA6Jp0kOJ
    uTubw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=s6082t9z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=s6082t9z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 08/11] staging: iio: tsl2x7x: remove unused variables from
 tsl2x7x_get_lux()
Date: Wed, 21 Mar 2018 06:29:09 -0400
Message-Id: <20180321102912.5130-9-masneyb@onstation.org>
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

tsl2x7x_get_lux() has a ch0lux and ch1lux variables that are not used
so this patch removes them.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index c1e441857226..1e38e8449f9e 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -344,8 +344,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	struct tsl2x7x_lux *p;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	int i, ret;
-	u32 ch0lux = 0;
-	u32 ch1lux = 0;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -416,15 +414,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 				   tsl2x7x_als_gain[chip->settings.als_gain]);
 	}
 
-	/* note: lux is 31 bit max at this point */
-	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev,
-			"%s: ch1lux > ch0lux; returning last value\n",
-			__func__);
-		ret = chip->als_cur_info.lux;
-		goto out_unlock;
-	}
-
 	/* adjust for active time scale */
 	if (chip->als_time_scale == 0)
 		lux = 0;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
