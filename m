Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519996609-2-1287239571029834832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519996609; b=luACne8MpCNl/sUlUTTIhcyj6aNMy8wGDnIL9ZJ3edBi7y4
    xXHnpvbiAQAyVC8BlfTnysbXbP13Q8pJTa6oqIhvt+32MhTm9dmyIUqc0w6Yclww
    sH6dNOA9yEp6gVky3PojbwHFUUh+f1HoOngOUaKpV1ForZWgXwfOuoQPnFed/PxB
    CjB5yweBln7lLaY+mWnHRYVTQ36tZjGZWa1IGu8DuC1qa/aazpeLf6VfBG5BQEf8
    EKogL4d5WJk4lReM4RvD/cysF42DP4RbzTRPjjhhPqP6vheewpAc25PmyA1CyvEp
    wQQUz5KhNplKGm6z32GAfRVCZyOrMtDlGV+r+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519996609; bh=y
    wCcE71cyv9kw6zCnfVPAZeWe1UsvrhEqazpmkvRuBk=; b=XlQpE8aSqte0jtHeM
    wi3eU8Tazx4qowIlpgbN/fJ4964r2BXz6h196quaseJ7AYpbbu2VEkVYolFT1SOF
    qX3BGFxrNAv4nkXnrDGq2DPXwWnvVH5AMctIJruHHa1pQZniHsCBIputPT7DSZmS
    BwedA0e8eoT9u9+GU3dx9Xb5c0wL0mUCjpsogPzu7RUYbbFyOTvXVWtv2TwEKzQw
    r60UcwJu06m60dw7jao7NGjQXCIH64hX1TRRcuqLU+S10QkuL1JG1sONeiIzGeDM
    Ns7K6M9CzTp3cQ3VxMFE9LXFgPWG+WQhpXKDiDKHzQrN7A5fWLNa90Fu5UwNbVsj
    hctng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X9g/qfLE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TGVNXpO4;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X9g/qfLE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TGVNXpO4;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt+EXiQWCAQb1HnkCTDgqhFPeqsHCGJ0iShf5ixzsW4EtGCwgQ15mOP7E0nOcbjEl5MXjNMgA==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH 0/6] adis16209 driver cleanup
Date: Fri,  2 Mar 2018 18:46:29 +0530
Message-Id: <cover.1519995673.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.

Shreeya Patel (6):
  Staging: iio: adis16209: Arrange headers in alphabetical order
  Staging: iio: adis16209: Change the definition name
  Staging: iio: adis16209: Add _REG postfix for registers
  Staging: iio: adis16209: Remove unnecessary comments and group the
    definitions
  Staging: iio: adis16209: Add some informatic comments
  Staging: iio: adis16209: Use sign_extend32 and adjust a switch
    statement

 drivers/staging/iio/accel/adis16209.c | 245 +++++++++++++---------------------
 1 file changed, 94 insertions(+), 151 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
