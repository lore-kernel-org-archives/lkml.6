Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1250878-1518436548-2-5922615350181915692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518436547; b=C+7z9pg4nW/8k/PlOWZE3ps7VaGQkv1qc1VS+gIe3SexTaB
    uHOHvP2zrUik04EsaZBUdTHsFfUthYnh1eHBMn2/BnEKeM7RlAC51EflWdRHDeD7
    vzSx0Q5AmyRh1Eq0K+PZtRshwx7/QiUNxam9/fRSk6FFws00tOQd5nMbsALtUrES
    ni7Hnl1HmSF+GiAODLQXbag1GDYjCT/UcAwk7MFB1Y/2suF10XTjeadosI77WULz
    uOwpB9UTSuJ8q6wOb0HSHf1yg2s5C9noUdpROrnx6n0Uos1ZESwWqpvfo++aPrJA
    zhjCSlH4SL2+e0FQ4tArZkZOKQtEvW+lsHWSHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518436547; bh=X
    iqh/dhWUNSC7+PQEspD5QrxDWUpvlRYiEvkFMMbUAc=; b=MwbqdMh4DfptsxPUE
    +FZs0GuMhcYA2mukrIGZx8EvsX4wf9pUPo4CUHO6xKmlzrq6Z9/0ZpSdGyE+HvZH
    QW5/+/3Qdtfk9O0xORkM+9L2mjn9mFTQ+yx73pzg5E1XtK2ng9zGCamK5k3dr2K/
    qBJxO4vEtQHDSRcdy3pHRlL489lnIVNlZ/XeHTSZgqbc9xQH4/FeFTUKijOe4Riv
    F83Y7A/APohhp+a+qvshpxh9VwxBOSXcFJFPy9zpL6v2XGJ0/QNG08pcebuQqyhg
    ttDNdF/3GkUx6Zcz3GTv2fuBI5fAow0ehRnMkYgWjZtA1mSCZmh0TUj4lhMnD3AE
    Vpijw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tN3Uvh8z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KD5lu3mO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tN3Uvh8z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KD5lu3mO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2267XZ02TZ/KMsDPaUzaSdpeTClMNY9RoHwYszARR4g19IjegvlIfH4pskl+s2AnfBetEokUeA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Subject: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a
 switch statement
Date: Mon, 12 Feb 2018 17:24:58 +0530
Message-Id: <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>,
 pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use sign_extend32 function instead of manually coding it. Also, adjust a
switch block to explicitly match channels and return -EINVAL as default
case which improves code readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 011d2c5..6800347 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			if (chan->channel == 0) {
+			switch (chan->channel) {
+			case 0:
 				*val = 1;
 				*val2 = 220000;
-			} else {
+				break;
+			case 1:
 				*val = 0;
 				*val2 = 610000;
+				break;
+			default:
+				return -EINVAL;
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
@@ -155,9 +160,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, bits - 1);
 		return IIO_VAL_INT;
 	}
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
