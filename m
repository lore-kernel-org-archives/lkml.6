Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230816-2-7224393292590134275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
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
    t=1521230816; b=FIAvkbe6+4mWeLds7rhVc1jR0/lsOG5Np/7L3/d7D6AgWAE
    dbqWGAOR0bBUVQWe9CEgnOccqbh3uHaKo5pXySofpb0acLcjgD6FQA6nLjsNHXhV
    UcPru6AvbNeVvrYVk3U5Ul8MQ5JAuy3U9zln6joYJEubOPcVYpZf9fYUK/CDcBNm
    iXNLWuQxJheasMd0a4RBwbXGEGrHfVnjqQL6D9GR/czpb2xgCIYY6k58i8trQq6R
    zNank54PH0nQZGd1RO2VOyt0tnl9K7PvMylAvzHzxV4lMp8c32wr9H1KZISREUvn
    xInw0clqJC2QNdPqVFxh/FDA5rXDNH5ihTFz3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230816; bh=S
    Krho046VL8MXEpWlfwSQuHZxg2nTmpMdUZUSYrDSTU=; b=iITHKgKRosUSxbGPk
    MXoF0YAtxNavSbCEAzy3iJXiOSZ2yuwbupQHv/6+INI/yCx+GYf0w15g7eOGnRm/
    1ojP0c5HaaOhfnuD4O1LMbJMeJkQl9MhWlaPAX5TLqTAPJ7Q+5lQKqgShh6pgRti
    aCralmgjAWgG06FGVbe4J8mEwmET5ei7Im7E/EgXI5d2jp9Rq2CBCF1EntR2E8Sl
    +kggjpXiEnyW7TvdZKfD3+LoGjTOltAmgeb2XuQNEHN0Yt/Em60MnS/S3z+ZwSQN
    d0Jvf/hgDqChRhCYTXBYqSfn7aWI7k3v92MwJcWCVdDUmta9t9e3JhwbREhVFXd5
    8quZQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nixNvzXo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sNdF/U0X;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nixNvzXo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sNdF/U0X;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsFIaoiHgWLVmXp9/WOGaIe2AcEZQDdzHgX8nJ0opJF6oO4vgj6ztrkxIs7v9DujghTRKuZDA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 0/9] Staging: iio: accel: adis16201 driver cleanup
Date: Sat, 17 Mar 2018 01:36:17 +0530
Message-Id: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
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

The following patch series cleans up miscellaneous code fragments and 
then the driver is moved from staging to mainline IIO subsytem directory.
Note that the last patch to move driver is *not* generated using '-M' flag,
which is used for detecting renames, since it may help reviewers to
suggest more cleanups/fix while pointing inline to the patch, the 
necessary changes. The framing of patch is made consistent with the
datasheet naming where possible.

For all the patches:
Suggested-by: Jonathan Cameron <jic23@kernel.org>
https://marc.info/?l=linux-iio&m=151775804702998&w=2

Himanshu Jha (9):
  Staging: iio: accel: adis16201: Rename few macro definitions
  Staging: iio: accel: adis16201: Remove unnecessary comments
  Staging: iio: accel: adis16201: Add _REG suffix to reisters
  Staging: iio: accel: adis16201: Group register definitions
  Staging: iio: accel: adis16201: Add comments about units in read_raw()
  Staging: iio: accel: adis16201: Use sign_extend32 function
  Staging: iio: accel: adis16201: Prefer reverse christmas tree ordering
  Staging: iio: accel: adis16201: Adjust argument to match open
    parentheses
  Staging: iio: accel: adis16201: Move adis16201 driver out of staging

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 327 +++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 385 ----------------------------------
 6 files changed, 340 insertions(+), 398 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
