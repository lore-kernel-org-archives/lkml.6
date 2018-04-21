Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946402-1524271347-2-5621573472528641515
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271346; b=PPoAu/Venwo/E733kkM9e/XKY35W19gqKrj9SGYF6FQNSeTD6q
    gw7znbRYMMtEJ+QNSc2ZR+m/YoAwdjst7Ak0SWP+14Z47H4cXvwjyzQOFB9KPEu+
    9SD67pUzItWzVpLiIlagUAEP3uWDhlldFAxFWrY0RDMyPraCY9x60fyfYmVUo3Hi
    CWso8dCvCavXyYfxvIqhs1XUmBIHpMTYrxCHGeu+cjalGVe7RcOWGTvj5RoAYELi
    DNChX5o/mM47u8F1IzZZ43HXF3ZsVLiBeHNKf9LekBxx9cvzuoLqK26mKABdidF/
    Ovkm0FgN9uoGMJamy0jH6LXeATIgd7feZtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271346; bh=qsJnn
    OTz8xuVcb/wWYWo6XVUz+9USBoc8F3/JM0s8CE=; b=lHVbpq83g6KWRqhi9QbOA
    3GwlsWQWAqojZJ8ePTZ2NLik3zjWYkosjz6xWJIlSPrYotFwKBMNob2ZdEb9hGYh
    A0I8dln/laC94XthQ0KLRriG0a1IRso2J1YzJfmd301/z071/gKvkxMCKB+fJEpF
    yxlWRB+a4gczKORNQGkJWDalr+pgnVEa6NIYE+9AvBRPodrhpGrW54lMLU8FmFIh
    ReJRWqWrm+6f0gaAj8gn4WhQEKVlgHRAnXFpRIvtd+OCR6TDyaCQOxpeCs1tM2hk
    2M3sopLwvQwSr9H7P1KgoFYqJWRMcineG7eMdtSkxAK+G7QzXzPpJQYUiFh/0G6W
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=rjTCenoa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=rjTCenoa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
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
X-CM-Envelope: MS4wfA9SIj8TO0UGfLGt2P2VY5K0UtAmXPRdzsr6LzwBVTIeuuxPZh1EEvD/tH1v3zqljGJlwyxgK3JA5AQKD1dn6RSbXJ9R15YXsVrk706vuVEVp4en8XML
    l10490FfUxE6l7CS6pjf4Z0WN46qWYBEh6e5Rm5Ayp1NcpyFkZUvVlFJ3tCik8TGwet6uiKE7ahTzG7yFuv1Zjhk4I8oy6hBPmlHJ6o0D8eMPfGxxmM4BaYS
    9cywYY14mkxfuEsilUbaJQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=Twzk-UV6onNyqDn95IMA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 05/13] staging: iio: tsl2x7x: remove unnecessary chip status
 checks in suspend/resume
Date: Fri, 20 Apr 2018 20:41:45 -0400
Message-Id: <20180421004153.19073-6-masneyb@onstation.org>
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

tsl2x7x_suspend() and tsl2x7x_resume() both check to see what the
current chip status is. These checks are not necessary so this patch
removes those checks.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index f37fc74b8fbc..8d8af0cf9768 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1682,27 +1682,15 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 static int tsl2x7x_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
-
-	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
-		ret = tsl2x7x_chip_off(indio_dev);
-		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
-	}
 
-	return ret;
+	return tsl2x7x_chip_off(indio_dev);
 }
 
 static int tsl2x7x_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
 
-	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
-		ret = tsl2x7x_chip_on(indio_dev);
-
-	return ret;
+	return tsl2x7x_chip_on(indio_dev);
 }
 
 static int tsl2x7x_remove(struct i2c_client *client)
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
