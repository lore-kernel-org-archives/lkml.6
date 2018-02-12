Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1250878-1518436531-2-7250405460410476913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518436531; b=rLPTawxSoHtBGBrMxxeSv7Jqa9qfCpwwLTwZlmkfTC6/CmL
    MRyvWK6CI2N9hKe/rK1oMRYpMi+5QY4FSyMdOSszij6KefddNwl0Jolqpv3aQiLn
    7nbmNwPF1m/EwpES6oRBB0u9dyB9luMB2bx+9KRmQGihTz3CzRPaE/dj1wYIjgKN
    E3KvhYBWx+Prz3Sg/A4jcAComdDpPhhGtnRQXsys/86tOXUxBjyipOsqxPgVwEei
    zZcZqKqoDLpqoV4k1sfAXSqnU6cvKE7rhnT42HuxUK4BzxqB2DtK92T6uXofsglw
    fXEyG8H5CRBWEBKM/uFlsEL8jPG3tdp9GOaZPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518436531; bh=G
    kFKr374nM/5GlDplObuOKdhWpV02M43mRkuB37X5Vc=; b=H1tKLUu8pzkoWJSor
    of/Ct9bKMvL3O2ioJ0elvus9QofS6mShL7lotXQjl25KbQH7IpwT048Tb12wiapW
    x/sEf9yxoDp9HiewvfdkftRryVG7FUkFdh9qIpXnitdH/trXjwJD+3isne0JP1oz
    5pizJYxY+Pj2bSPHHY/aCxJfVMfXNxl/cPzQxqXLTZn9605crWc4GhjPJKrkKC46
    L23dhTSdmv+XSmZChDL3kTv7+bG/0J0GJbT/YaOyBXaLHUM3Lv17l6V3xQUKHdqG
    HH4zjRTceMrbfktWqiQn+L6m7n8Nhg2EW4eJwUWfakVoNesO9PbUfZF/zP3Y3dJN
    qqxfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HSXpq09t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rh1cD9hc;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HSXpq09t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rh1cD9hc;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225NQjDx/2ndibSqLfrQxSvZ/R8DYOiB8hCA0W2lVeIn5/zMTF/0+ofEff9qeIQz7t+NqAXwVg==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Subject: [PATCH 0/4] staging: iio: accel: adis16201 driver cleanup
Date: Mon, 12 Feb 2018 17:24:55 +0530
Message-Id: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
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

The following patch series cleans up miscellaneous code fragments and
then the driver is moved from staging to mainline IIO subsytem directory.
Note that the last patch to move driver is *not* generated using '-M' flag,
which is used for detecting renames, since it may help reviewers to
suggest more cleanups/fix while pointing inline to the patch the
necessary changes.

All the patches have been tested using 0-day test service with success.

For all the patches:
Suggested-by: Jonathan Cameron <jic23@kernel.org>

Himanshu Jha (4):
  staging: iio: accel: adis16201: Use SPDX identifier
  staging: iio: accel: Remove unnecessary comments and add suitable
    suffix
  staging: iio: accel: Use sign_extend32 and adjust a switch statement
  staging: iio: accel: Move adis16201 driver out of staging

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 315 ++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 381 ----------------------------------
 6 files changed, 328 insertions(+), 394 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
