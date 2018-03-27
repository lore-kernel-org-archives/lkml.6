Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-285901-1522177671-2-18337666669749581762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522177670; b=jrrWPUnsZWTIjthCNcR+BP0gPzFXPDFh13mbUTITJ8LZpHt
    J604A5tMTfyzk9GW8fETTEMz+0cjsGlNOQQQYxcEghZidjGDERjQMsPEZ/LuRpzz
    TvDaTSmlmEAy7lOhdyUYWqvD+s2ItNaqczowR2yYWq0MdeufhByfeRLe/Z/XVt+6
    t3BdddIT0rYsdLXohVXUQThMYuwQc4AyV3bmNd85PAJpEkGcSimsf22D8x51NUEj
    3RZ49Iu2EgfZi6WUAUB5dOVeYaBaoKgjsI1wHKuRoLhLz1Td/Pclb3qs9odFJBJl
    /tg5+khmTOCyYtPss2aPj1hGgCy4bLlFTclkGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522177670; bh=e
    aqpVhpt/AjvHGCIFeld9X9e/31LaFzqPadVnW5I61k=; b=LEQEyROLieUXJ0bta
    Y86d1EUPU+4DwzzTG+6fIw/3NJeeXLxe+4Eh1KefncOwuTTWi9qCz/jDa/JDSrZ6
    4YPSq+hNkLQ4ni5i20pMWJD/fV2WacATCuIqXAuWuwXqUcDIrD1lp18lqPffKTh3
    CaET6q05k4Gl8jz3jf4oWybwq4vEu9R7AVYUXvIWY1ISldiLwEl/x1iZqHw2/DR/
    QUWP2FrrF4HjRoyV1yohfXn3ChmJOQne5sM14SeewXUpRNGZo1frioDKkRv5C9bD
    ISH0YtHfbNP5JBLNGeTpIguFgsyxAGc3xMv86lyGjr26sH3wUfX2aaJPOgZKaZiL
    Ta5Rg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WS+1IeKQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QHmY7sW5;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WS+1IeKQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QHmY7sW5;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfElHh0NBSKRta4rcMBCVaKvMYXykLFRKY6W+i6IwlaaFbFJ3VhM7QbhX+KSeCafJNXbGdtgPKaVylq0JS+Me9zuFCQZ/O2GpwE+r3vzKLFyUiyWi4fOT
    /2CZ6CcMmVeDCAp3YusAiRAoTW7yQ0anePuaNcnjbUisECLgUGgty6JZZEMUz3Y/EfwOmMOE4UEjKuvxJxr/b7kU0lqtgGEA6pl4UtTJLAWFHWw7IE7rCG7t
    IBG7edxZXHkCgnBS9+C8Eg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=jZC4oIpbfc8A:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=KPmL81TUiWVCujQF3Z8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/Ej4QFn8q5WbzH0s/+Tv/aCKBVlH8cUDP1RrDXUoSYVDoDbHD4pIKZyIIeyAjtqhDBDJA6vg==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [PATCH] staging: comedi: s626: Use Preferred kernel type
Date: Tue, 27 Mar 2018 20:07:24 +0100
Message-Id: <20180327190724.9459-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, sunnyddayss@gmail.com, abbotti@mev.co.uk,
 sfaragnaus@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change to kenel type u8 or u16 instead of uint8_t or uint16_t

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/comedi/drivers/s626.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/staging/comedi/drivers/s626.c
index 0b3cfe934e14..6aa143dceda2 100644
--- a/drivers/staging/comedi/drivers/s626.c
+++ b/drivers/staging/comedi/drivers/s626.c
@@ -2268,10 +2268,10 @@ static int s626_initialize(struct comedi_device *dev)
 	 */
 	{
 		struct comedi_subdevice *s = dev->read_subdev;
-		uint8_t poll_list;
-		uint16_t adc_data;
-		uint16_t start_val;
-		uint16_t index;
+		u8 poll_list;
+		u16 adc_data;
+		u16 start_val;
+		u16 index;
 		unsigned int data[16];
 
 		/* Create a simple polling list for analog input channel 0 */
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
