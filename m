Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460763-1522315291-2-3001587970597708783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522315290; b=OFoA8ynK9DwWZRzDApQasrabCBhwtrqP3lc/aVOWZK+5x7ptdw
    uN9C6wkpqryEpBejEnvURVonHvKsVwN1o0slntreTjD/YeShC+cYjix3aomFugxS
    hLndOWiNgKs8MQFFxDthXbHoP4KoRaG0zu7rTOCQ2Y9B2iys8ck+2GkLGOkKnsTf
    ruCWcm+DgUvwhNQ89nuXaNZRtozN3B+NXJQ+LQVVLdGg5mO9LBvNybTVPrCgBVO+
    EaLvGYr1tqyPR9loscM79aH8KG2C3JoR3IT7jlCP7qOOkbiMC/hAs5BrCtHWJv//
    H4YL3U0FHbPBe+v2oRTd2j44JPz4u8DoJYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522315290; bh=7nUq3
    Dpv0QUNUYeuPabkXzwaslnOc8NBBV9nk6T7mJA=; b=ndXAjVxCuCJo1mJkVjMhb
    HkEohLiBpUTltOvqiwU9JmONNLonjfT7s2YL/OFIrMIscnHB0mg1ryhf+0Bq7BmA
    j+sQFGO6xGRI0f1EHnVQTfBuC92I+tsDcystv4CkhgP0gBjKKMEy2xsqL4GH07Ay
    GDpX3sFq5dTTRJG+2GzTkb8h/Mq8nzUmlAIRXXUTQkOyVkNjscpoE0nj8JUS1l08
    gtQ19gxAm0M1nVBZMlmxhBQ0GZSXdu8Su/ZYraouJhOl1FEv3Nx3G6nRlxU6QSa/
    lO5aq0VYFgY5in+0OHy5m26avwjQTJboXpsn07tVJCIjMM14kaWhStq17JJPPCTM
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=O+uWRmfV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jLu94+OU;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=O+uWRmfV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jLu94+OU;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFjvGmAb1E3bULTjbGFtg7BBZX8mN471FT1Q6xJsFCp24jkxX8YSwMEhzWPLO2bpDP4fdTnsupzo50JZPnI6Ppj1cLc9kU/9r40RDWRTJr0n9W6dtrfG
    ZzIGebvcGksJW7+aOibBrUPRC0irS3saSeWoj9AKqtLV5SIYP8sGvqWY8GKQ1Kob6k3pud1QGh4KkxsyQ2l0iHsEYRCHFuX6AGIXSLXQsLDRbZ+CLkR9Ebjn
    voutYIVYLvpjVh2jiyYj6Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MsQ-QqnFFZYA:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=rEax1i_7dPk0db-LxJsA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49JQCZQklGAjHGCkZk0s0k8KxMK7uMV2iteWQ2lkmlkOaT3Uhl2k8ejsc7MGG3olbx7JB2eEg==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: [PATCH v6 5/6] Staging: iio: adis16209: Use GENMASK
Date: Thu, 29 Mar 2018 14:51:19 +0530
Message-Id: <5d43c34c95f3b58f5b79254ae67bf7a080f39a92.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use GENMASK to improve readability and remove the local
variables used to store intermediate data.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v6
  -Introduce this new patch in the series.

 drivers/staging/iio/accel/adis16209.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index ed6d7c7..cc50667 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -112,25 +112,22 @@ static int adis16209_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	int bits;
-	s16 val16;
-	u8 addr;
+	int m;
+
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_INCLI:
-			bits = 14;
+			m = GENMASK(13, 0);
 			break;
 		default:
 			return -EINVAL;
 		}
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16209_addresses[chan->scan_index][0];
-		return adis_write_reg_16(st, addr, val16);
-	}
-	return -EINVAL;
+
+	return adis_write_reg_16(st, adis16209_addresses[chan->scan_index][0],
+				 val & m);
 }
 
 static int adis16209_read_raw(struct iio_dev *indio_dev,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
