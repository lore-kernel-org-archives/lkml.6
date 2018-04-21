Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946400-1524271348-2-8292696826471654713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271348; b=boeCswZBxOeVkUJZkIjOWEg8pxp+E+tqVRycFPd4D21/Y2sDjQ
    5fpJ55lIM0/ppIyd69U0kg7jEa10KWm013CBVCeYEnYRbj63wRcjd0a2+uVMi0YF
    ucyQxELPjlr5RuhdNKmxmJib5fYF6D/qMEKXvdbb7Df5nn2y2ujW2KJV92YyKZM1
    dYTkhUSTohbsflPm/ZecVZ7NC6ocRBg6N3coZi3eN00gjs0XCmkZUg0g8cL3eYgF
    QNh476yFLGqk+7PXkCie0RhgIHEubepGYhMw50Vil4RofKBQAGPOiCl1awhwpsMA
    fS1Bq8nammt3hauFkmFyQnHIxOg6uHXypDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271348; bh=R/96m
    DZHPo5bvlfakohD+O15GoK6cU3sbl3FkY0lNWo=; b=lFAH7e9FK8d+BkIVrohDI
    PJ/5gOqTgUa/ZkHq8Isb6NdgO1xDC9IXHKxqPUmrNr01UFXSpmEf1t7AWuwO6eM7
    F7HaVc4Z1yVV7+thiRwBuTW2Ogp8A1nxU66R6KSPux3IH+0FzYLJbAq0VdN0db5N
    3USFOvQgfuBhYVP/MZDGfcxAPl1gVMiy9N74SXvhULQ5MmcL71xPplikc1qDcF/T
    4fSzvjIF3cQQLaUKo9Rtd2E24DNEO3F1E/Mk7Pm6g/RNLTzMIStBAqguFg1If+V7
    2akdWnXvjT1C09WEu/0qSNQO2nVChxTRqXZ+jrO7kkwTYGycl5gr7zyxWfPDh6wu
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=cESNaJ81 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=cESNaJ81 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3kxbyUsO/8fHi2t3aV6Fdh9lItlu68q2PpZ4LlMuGIDee2D/ysBstgLNgjYsn/V0GSbOAILC8ZFISdIKWMaRp+sYbbB0IZZdux4+rDtmI1YJvABiU2
    x499FJwxsIuy6KoXLV38EJ2Jxvbc6nizDaO52euCuRzU4QWWozs4rOMH9o51awdC0iuyW+JHiZKHgGiG3eFVKAWQw3rtNdRFYtTCxtxmAtEf3hTZ86pNUJ4A
    iqttbav/Uvgs2EVz0ATyXQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=3Vp_fQYSJCz8s-f7i7gA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 06/13] staging: iio: tsl2x7x: simplify
 tsl2x7x_write_interrupt_config return
Date: Fri, 20 Apr 2018 20:41:46 -0400
Message-Id: <20180421004153.19073-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
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

tsl2x7x_write_interrupt_config() has an unnecessary return value check
at the end of the function. This patch changes the function to just
return the value from the call to tsl2x7x_invoke_change().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8d8af0cf9768..d202bc7e1f4f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -982,18 +982,13 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
 					  int val)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret;
 
 	if (chan->type == IIO_INTENSITY)
 		chip->settings.als_interrupt_en = val ? true : false;
 	else
 		chip->settings.prox_interrupt_en = val ? true : false;
 
-	ret = tsl2x7x_invoke_change(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return tsl2x7x_invoke_change(indio_dev);
 }
 
 static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
