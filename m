Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230852-2-6395091102438311302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230851; b=RVNzgOzDaB4sRRsghfDv4st5wkR3r4WFPor4wtAq4kBnWG/
    C7PcJL+HdnbuX5yYUH7tU5XrV/MmeKpDs5rTc7emllN8+etYw4WIeRzQEluRzfpl
    v9esaAjbjOMk2hRRtCxTg/xR322Dsrj7mf4eerdUsbH0lV82NIcqqzJ76kZWgZ5d
    eNkHMMGlEQp0e5/f+HZiLPy/NqK/Vu6i3mUFFphJoSqcJTpwYCm8ZkbAUyBPVxRy
    Jejk0V+MGOmnnS69IGHadv4Yc3bC7AesJbhw3+45y5PRXSqv59mveWnKnf87EVWI
    n5+CEQftqYIPgSGnD8xt+h16SKpvpPw+vvBLDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230851; bh=+
    r4xHR0RPkBn/5ctJYHWq3iSigh7Opx5iwWC8tAnN4Q=; b=ug8j5AeVRFpTJw46m
    W7cfQ+JWP9fYWY3fB8BRqOUOrl5hkKbvRnOngWOrmtbFPdBLhVkY+NLOVjS9jgW8
    0kcoiZua6W6TWpF7MnyaQjRO6u131ekfc5h/HQdKQoGnyqmSa15CUpyFgfVcGZKr
    OluB9bOkngaBc2xKuWqnrUpwj4aTAtL8LjIFDAIxsv8JhaJ9KaYI+KsIpPvKDHRA
    3u7ZVjntlpBsItE8wruSi/FHc43FnNzpk8ScdYcg2H5XtN0yAgcXvSej6/7W0C6F
    RPrkXckVmXZVbNJyWj4kkkMOW86QRMb3ltvMEhiZdvIbhSUfTS9JjnHYzi7mq9My
    JzHiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XgQ530JG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B4LLaOfG;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XgQ530JG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B4LLaOfG;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs3nW3zG29mBIDG1Zf9xR5DA6FVR5gMWYo2NsXuMEb0S4v+iz4LT1xZM1g8+q7B8inUuthRBA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 7/9] Staging: iio: accel: adis16201: Prefer reverse
 christmas tree ordering
Date: Sat, 17 Mar 2018 01:36:24 +0530
Message-Id: <1521230786-18155-8-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
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
 gregkh@linuxfoundation.org, 21cnbao@gmail.com, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Prefer reverse christmas tree ordering of declarations to improve
readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -no change in this patch.

 drivers/staging/iio/accel/adis16201.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 298bf90..00e944e 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -259,9 +259,9 @@ static const struct adis_data adis16201_data = {
 
 static int adis16201_probe(struct spi_device *spi)
 {
-	int ret;
-	struct adis *st;
 	struct iio_dev *indio_dev;
+	struct adis *st;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
