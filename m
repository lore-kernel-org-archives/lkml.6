Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946402-1524271340-3-10024408645845228557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271340; b=QnLC+uQ3GeG7NCwCBlb2HJ6eHN0PZlQsCespjXJxf+SLwpvAz1
    Oh+JTrrxgEtui2iVOA2zCq7aDIuOFi69HOrbptOQB95K6xMa5SDIQlZDabhkeegT
    mIvEyM2yCHzhLlEAslPd+UgTh5Kf0rZbyEWMKj58iSsZ0+ab/VSHwkkxCilyAyoZ
    pYAzN0SWTiXYow8eSoTVa9MYGa1ejz6ObFc6wQqqmXzXafqkv67ihLVFaR8FhxbI
    zuaEHR6DzvyTMtaDF9pohZS4M4KWEoQa8+9nJvQMriHvjQ/7mLtTlFrjxD9iUbhW
    P1uzNhpLF40OfBITpQq1y5n+DmcDxTwWNZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271340; bh=F86gE
    OW44qGN7bxO9+tv+qsIxMqQh8UF5SJbEu31Gos=; b=rMt3upWaE9Na27D+GgZme
    iOlJwC5+8pdrsHMRSvVrgfNdE5LFEXEk6q2hhH4JQnBQS05parM/lOMG2qoO1HT/
    plyyDxgzeBVRsoIk9oD2UDTiAq+KRUnut1L51UQvDkHBDzoMrrpNbNrXrFco0XFp
    NVqZ+qu51lAXrgB8kkNxgXb4NE0tMYmteZfRCN/b4qesm77FIVSfRFjoKvCQC+v4
    HWFWnpXb9Uo9ZrbTkLnR50o7scvBe8q8pCyABAersvh/JeHQz0866W6gabfLSdv3
    AfUN3hLqOX+I+IffaJHjpNq6xv3xEZ+QKhpInmqkTq6cl8PMxsU9aM9gpHkCcPzi
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=N0IS5y92 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=N0IS5y92 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLve4WgYYm1S1LTXLVllR7h3iqGnnOG3VVapYDFZDw2uyHHig1GRDIA6U12zbiVKftXYHMh9itZsAIdUhMhpHgl5EwSSIQ8DKOY7TQy3GfTKMgwKN7DW
    x7bxQIatAOeLYPA+QYe+A4RRD1azcz4UwvgSb9LGQf89tilqflgrZfMAhzOIIwELkr6BjIrt9VZW5LDVPJDJuh418BMW5wcLLH7Ymy4NujOdHDLTBWRNc72E
    khGSXith9jkprKtQ3+shYg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=oJxNwotOF7D_G5hRg7oA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 03/13] staging: iio: tsl2x7x: don't return error in IRQ handler
Date: Fri, 20 Apr 2018 20:41:43 -0400
Message-Id: <20180421004153.19073-4-masneyb@onstation.org>
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

tsl2x7x_event_handler() could return an error and this could cause the
interrupt to remain masked. We shouldn't return an error in the
interrupt handler so this patch always returns IRQ_HANDLED. An error
will be logged if one occurs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9cdcc8c9e812..95a00b965c5e 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1320,7 +1320,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 	ret = tsl2x7x_read_status(chip);
 	if (ret < 0)
-		return ret;
+		return IRQ_HANDLED;
 
 	/* What type of interrupt do we need to process */
 	if (ret & TSL2X7X_STA_PRX_INTR) {
@@ -1341,9 +1341,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 			       timestamp);
 	}
 
-	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
-	if (ret < 0)
-		return ret;
+	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
 
 	return IRQ_HANDLED;
 }
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
