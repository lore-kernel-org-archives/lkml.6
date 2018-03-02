Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2537421-1520026995-2-13172553894761910143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520026994; b=X3kODot1VjUkeJxqp/LOAzU2NiFLzlQ9r9r6DTDbUDJvbbz
    FUWhe6kC/4Bj//aP4Hyub2diV5M5eMtjBc7hTcAaMRCo1Tv35hiAD8KyqvnQiN2j
    t8KW1nosJa3DhYpZ40zsdPjqDpS0ZlS5YaTPtb0z4CLpoFqkFpRJz011fZAd7CTg
    kSI5ix2WeD60FCcSLzId2XejRtEZ/uxFC1ntiYyaVQLbKSygRb5ol3Rm7/LpM9d2
    AKs/1YzOqeH0ed7Xszw1HU9sFl2dQNoNzJUbcVB2cRIAO1aLHZKRXOe8U6Yg7K3a
    xJgRLrmCdnIvOEfGB0kQmRNL0tlqmZeH8Xm2yVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520026994; bh=f
    3EP8uHLNTYP33ZE9pjWuVNTgj8I+1XOWOUiZB3UjzI=; b=ANEXUMlHES+SNCSny
    CDM4SVRBIfhNxLnLlng0fDFhaeD9CwjOije3oOO72RrQ2pH024HknNJFuJPIOQzm
    oCcQ6XOIxSfVTLAKkavrTUBnhi7mF42ce3YlA2PGjTXOPa6F5vwQWx0IOCRSwcgM
    lsBwI7IIWwPqQpYs+89zQPIPL56ZudqBlIVsobvSIhJn4O0m9A/kMZAcADjdaYQQ
    96E0R0L16ymFjoZjvdK8MdN1mbNSo7TT5jAmIV9CD4UhZXewM08vX1UplFaFm2O9
    UWhlkVfgMw+wr29Vw5q0n4eCYspUxq0a5rwhVoqOSCa+uMxQc/Gbk8cm/SkIZg2H
    +rBtg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZOnNwUK0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jOh+q7gT;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZOnNwUK0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jOh+q7gT;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuT4BDRBfJJA8Eo/DZP8RyQ9MdJ5dNocKD089htzebKxXawOnZOJOMPZWHR7VJeVjywwlgMuA==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: Larry.Finger@lwfinger.net
Subject: [PATCH 0/4] staging: rtl8712: fix coding style issues
Date: Sat,  3 Mar 2018 03:12:17 +0530
Message-Id: <1520026941-16548-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix issues found with checkpatch.pl for rtl8712 driver.

Arushi Singhal (4):
  staging: rtl8712: Remove multiple blank line(s)
  staging: rtl8712: Added spaces around '+'.
  staging: rtl8712: Add spaces around '|'
  staging: rtl8712: remove unnecessary parentheses

 drivers/staging/rtl8712/os_intfs.c                 |  1 -
 drivers/staging/rtl8712/recv_linux.c               |  4 +-
 drivers/staging/rtl8712/rtl8712_bitdef.h           |  1 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |  8 +--
 drivers/staging/rtl8712/rtl8712_cmd.h              |  4 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |  2 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   |  2 -
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h |  1 -
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h |  2 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  |  1 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  |  2 -
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h        |  2 +-
 drivers/staging/rtl8712/rtl8712_gp_regdef.h        |  1 -
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h |  1 -
 drivers/staging/rtl8712/rtl8712_led.c              | 70 +++++++++++-----------
 15 files changed, 45 insertions(+), 57 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
