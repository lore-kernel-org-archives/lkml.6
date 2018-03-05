Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520236251-2-8764141174055292415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236250; b=l3R6M22qUO45oJEPPBH0Sqg47DV+CGjMyWAPOJVqmECVfl8
    uLTxDv/WlDwqF7hwmY14qGam6SFZkmNJkOxBbV3id3A4nXnQ7BsZK0hui0ubiD0g
    D3iOAdGFQV1C9ORPnAR6ARgeL4K1ZLYjLzvs8ZvimIpGDjvo5NtswsVsUg42ltYb
    ce4yT2Hxp7Gp25bzGDlgssTH7Ak+Dql07Oz01Of8hHl3gFPrCv84Qbiab2tEzkIl
    SP8iHRNcYfOKarYRuS3WNnQWYOU/gt1LQvr4hhV3DWZPlij0J81/NHTbVLUjq56k
    Dr0vYqvu05bBQrYi1cBqQWZ3fKv+Ddmc3hSdTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236250; bh=+
    eIS0Syd+xuWjq4EhsNbRdWtNkch5XZw1VOk8m4Q2kE=; b=sGeOquZPymnmeNO2e
    hHVhrqaazknfSgCLLPM+SX3fcKGBQiXv4lPwNyztO7ux0IOYPcXraD4jDWdGbKvF
    FKgLCI5PkrI3fv2Zb0DGcWF5C+FzvMIXh5YnVF86U4iGO7wQapNIpt/sToJfrpo1
    XYWnAAr+LywAKM3o1ghJfLeV32kfGGNzSDaK82TpQXNCY6LIaSEA4f9URpD8sn8W
    Tgw2h9motl1MLgwpLZvhjrS+rlXlbbH6RpBmPiHPR0GCFnx7fr+U1MboCVaPLoFk
    /Xe8VqXlvd2+WBrk+gNoZZ/0H+8hazb4hcx3MKRdGccrFsYh+ww4NYFRwydD55Pg
    6PJ7g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vU+Y6N+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=reN7B4ZC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vU+Y6N+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=reN7B4ZC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsI4sjcP0sseRzQAPcGbU+oKhRgIYBW5FbZqbrqFxgSXbPlQX3BqGIe1EP3mEC8ulg++eH85A==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 08/11] Staging: iio: accel: Use switch statement than if-else
Date: Mon,  5 Mar 2018 13:19:27 +0530
Message-Id: <1520236170-14668-9-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use switch statement instead of if-else pair to explicitly match
the only two channels present.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 1737708..307d4ab 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -114,12 +114,15 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
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
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
