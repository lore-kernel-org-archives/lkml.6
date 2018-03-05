Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520236199-2-6033381909006843377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236199; b=nlMwwB2uxCkDcxYJ09FtAHfPQtAJjTkvuA54tQ71CtqNqDj
    mXkijVGEqbaBBUtHwnyRpDfES0Hba7Nm7JhkyW4O/AGhsu+jMnqtZiD3TJHTybCp
    RaB/aNaMoGmCbsDXEAKAsh1p62bcuBTH+9LELBLz0IfNDjdagvf4Dv2t4VRueeh1
    BFwfvakVFS14TIlo+roL6yqXpCO1iQjx5mTqPBiLhGOLs0/IGiE/EtEo1ZX7Rr5i
    NNCkh3P7ickADNZEcakOhdM5JTGE7fq+rsj+SI1FBC4w9wNNJ97ubTmy0SPi8Hkm
    N7C372eguWvIbsVaI8zF+WV772/AQuqi7RFp8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236199; bh=1
    idGbbG8/NC3sgooGhA0+PGHT3IKuGH2cC2twmkDgKo=; b=ukM/urBDWvGlr20nj
    a9POhEXQgq8W715aNUbsjx4jfKwHBC7PcaApXdQ0SS1Y2YijBP5QwrF2iO5eHgxB
    9cjrI+vPmD0u40WNH6seLuEOUOnnsmzwNyT6MMWLXjgMq1ikHu0YFD7Sh1xddDIU
    g3Q0ejYcN4C+ucj+kqkrZxjtRY5jeuUYuFY2thDnelLSZS5FQeqG9dlU/pnjWDwC
    TwW2zlQdkXUlqXtdh2zqxaXxXyYzK5GONHvmvN1lt94BXU65YwtqxgsLTvJSN5ak
    fY94yN8gUXPlkfjzSjpLNq5EwIiF0xKA7Z2AY8Q1CDnZ2mG8OEJd3D/lmjjtOxdn
    gqeoA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LPwjX/dh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Af9SKt/U;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LPwjX/dh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Af9SKt/U;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs4MN0QJRZB7ad1IHelw4QJY+5OlgwCrZ6z8nvNvYdh6CP6HxMpMFi5bW85rg51breb3JxLQQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 00/11] staging: iio: accel: adis16201 driver cleanup
Date: Mon,  5 Mar 2018 13:19:19 +0530
Message-Id: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
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

The following patch series cleans up miscellaneous code fragments and
then the driver is moved from staging to mainline IIO subsytem directory.
Note that the last patch to move driver is *not* generated using '-M' flag,
which is used for detecting renames, since it may help reviewers to
suggest more cleanups/fix while pointing inline to the patch, the
necessary changes. The framing of patch is made consistent with the datasheet
naming where possible.

For all the patches:
Suggested-by: Jonathan Cameron <jic23@kernel.org>
https://marc.info/?l=linux-iio&m=151775804702998&w=2

All the patches have been tested using 0-day test service with success.

Himanshu Jha (11):
  Staging: iio: accel: Prefer alphabetical sequence of header files
  Staging: iio: accel: Add a blank space before returns
  Staging: iio: accel: Remove unnecessary comments
  Staging: iio: accel: Rename few macro definitions
  Staging: iio: accel: Add _REG suffix to registers
  Staging: iio: accel: Reverse christmas tree
  Staging: iio: accel: Adjust arguments to match open parentheses
  Staging: iio: accel: Use switch statement than if-else
  Staging: iio: accel: Use sign_extend32 function
  Staging: iio: accel: Add comments about units in data read function
  Staging: iio: accel: Move adis16201 driver out of staging subsystem

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 323 ++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 381 ----------------------------------
 6 files changed, 336 insertions(+), 394 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
