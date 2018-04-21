Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946402-1524271352-2-13476919685001769438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271351; b=jQg2YjV/bW7mwnlcqJXmroptN6SjrhSdmyC71NjW/UTMM5Mkmw
    ealPdkK4hwkj3cCB56f/bobptxl9MbdDRfaQdBXVNjbv+TFs416KaKYZ3vYDmYSF
    Wq9SJQtUI1kSEhypEYht7PgqJzCKRDCWXVD69tgTqqtucjIPAn8jNUKLNBKxWirH
    qxhbWHsgOz8wT84/VCZhmad8qwaMA8ExnhLPIVAgWrA+0JvCLn2w80L21+AvQ6ww
    9037kPph30QOj1ArmA2f1UL8Qy2v4rvf+SrLthQRZmdmvBh9gofvr671wCz32KPz
    y+x8+fsCpOcLEtVmpzeiZ06OKKCrwNoqGizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271351; bh=hA6j/
    VKwHVgPhvE/3KrQhh7Bpb4tQSnYVnVqbNOg73E=; b=o6VXxioywpQ2V/WA6jvq/
    pVUc1B/2er9AUQSHbF3o2XkI5r7ZPEgaQymDZYwjDuv+9wJhVJTc7GDb388f0Csv
    C9/5cuOpHGX2UdUGREW0x35BWZVLI7RvLjKlEVezQfWvvWWNL1CHAb3g5zMubrpP
    IWnfQY0GRA8asgN3P7Y6Z+QLBdOYHcrCX9A4W5Gp1hxCndMwDWyIUo2yyrc+5d/9
    MHdpvbxlroXmgcKPNEpTH3Gvd/RD8XSVDtjjDK/hxDbEexWvVVZddH6Uc/cFgb7h
    02atB0UihgFtgUJT38oWzOYTZkCB/1R8i0FNQnmpHHqsD87Tex9VpSE375KI50yp
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=Ym9xikFc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=Ym9xikFc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
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
X-CM-Envelope: MS4wfN/RJCJAFByqIS6TbHTScfPAvB4ZjlsTOhZFgH8Lkd+7/NDECmNUI4Ovjr9kLHXHRlJhb9GAsLB4/AEvfmp6ZgeIBgdXJ4q8JeCtlLizN9CBW3281ukl
    9JFKH6PsjZmd9suPe9qWa4+uNGv3F4XuUvepY2TGsUbTTev4su/tx57PObocoLu9mZHqquBWYq4oz2XQtb6M+AKhfxqSBJhcv+JdpRUh6hDiKXdwpAJx5TM1
    7RWM5HHdvNUngIx9TLSvow==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=-qlrbnVak0kI9VtPup4A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 09/13] staging: iio: tsl2x7x: move power and diode settings
 into header file
Date: Fri, 20 Apr 2018 20:41:49 -0400
Message-Id: <20180421004153.19073-10-masneyb@onstation.org>
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

The power and diode defines are needed for the platform data so this
patch moves the defines out of the .c file and into the header file. A
comment for the diode is also cleaned up while this code is touched.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 12 ------------
 drivers/staging/iio/light/tsl2x7x.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 15bc0af1bb6c..87b99deef7a8 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -103,18 +103,6 @@
 #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
 #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
 
-/*Prox diode to use */
-#define TSL2X7X_DIODE0			0x01
-#define TSL2X7X_DIODE1			0x02
-#define TSL2X7X_DIODE_BOTH		0x03
-
-/* LED Power */
-#define TSL2X7X_100_mA			0x00
-#define TSL2X7X_50_mA			0x01
-#define TSL2X7X_25_mA			0x02
-#define TSL2X7X_13_mA			0x03
-#define TSL2X7X_MAX_TIMER_CNT		0xFF
-
 #define TSL2X7X_MIN_ITIME		3
 
 /* TAOS txx2x7x Device family members */
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 992ee2465609..2c96f0b39b1e 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -23,6 +23,18 @@ struct tsl2x7x_lux {
 #define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
 				     TSL2X7X_DEF_LUX_TABLE_SZ)
 
+/* Proximity diode to use */
+#define TSL2X7X_DIODE0                  0x01
+#define TSL2X7X_DIODE1                  0x02
+#define TSL2X7X_DIODE_BOTH              0x03
+
+/* LED Power */
+#define TSL2X7X_100_mA                  0x00
+#define TSL2X7X_50_mA                   0x01
+#define TSL2X7X_25_mA                   0x02
+#define TSL2X7X_13_mA                   0x03
+#define TSL2X7X_MAX_TIMER_CNT           0xFF
+
 /**
  * struct tsl2x7x_default_settings - power on defaults unless
  *                                   overridden by platform data.
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
