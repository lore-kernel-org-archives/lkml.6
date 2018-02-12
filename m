Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1066285-1518432768-5-8870106331370915764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432768; b=Y2HfGmEksuulVVEHGU/5ieXsEMQ8dFiX9mXtALio1skEB0W
    twj8YwUIhJN2RFRpz0rQsgvdRfAaPhG7hfnKpO2a6uaNjqf9z8EjpdcnURrHZaGg
    s8KwXrWr/2RcKY93zGdgCpxzPwtcPBgksvP0YanTaKaLfj9vAFBh6gb8nleeHnqt
    v4C+HSEvIiEaTngeYPi85aSGq61gE7OndVYW/wczaj3M7+FKAZ80E+aSXEkd3CCo
    Crm7j/13sk0am3909XpRQ0E7bI+xRf/NuqOSNUzkzGEOb7qFc/+x2KqTkhfFpnDT
    nUhT7zHAI1WNwMFdsVceMlbUx15jF+JgT7j6wkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432768; bh=E
    ODfinHEoqLYiXhxTVHEnySfFbYYMQItJrF5cDw1PAw=; b=iaCitZC9d5N24l2MH
    phZORbv8spfGQMRcffBQmCOZPwHUf7opM00dVnWjQtEDzBUqPRfJWb/KVsxYJstD
    9ZcOu0E8/5plFdDu3AGDbXNKLr3tZvKag/3pKYnOXgmc5eXcYu2VR7OG4lTEtcyC
    kmhQzTKU2wLGQLHxjE2OSrDy3TqP5qvoxo5xdGRc8tIRwHB/YYoUnMfzF7rN8nKF
    kMTWJN9uQvPhC7vwWmO5tNQUUxUNFlw0hc/dsMhaGwUwY3th40ZTgirJm5BxSlZU
    tudB4T897r9QFwiAzk+fvj4HE/drASduN5uhlqhyiHL1W0/lCppJyVrDZndC3akU
    joJXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>,
 <sumit.semwal@linaro.org>
Subject: [PATCH v2 0/9] staging: android: ion: Some cleanup about ion
Date: Mon, 12 Feb 2018 18:43:05 +0800
Message-ID: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, Yisheng Xie <xieyisheng1@huawei.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

When I tried to review the code of ion, I find that there are many place
can be cleanup, so I post this patchset.

I mark it as v2, because I have post them in different patchset before[1][2]
[3][4]. And now, I combine them in one patchset to make it easy to review,
Meanwhile, I add some acks and rebase them to v4.15-rc1.

Thanks.

[1] https://lkml.org/lkml/2018/1/31/711
[2] https://lkml.org/lkml/2018/2/1/240
[3] https://lkml.org/lkml/2018/2/4/320
[4] https://lkml.org/lkml/2018/2/6/949

Yisheng Xie (9):
  staging: android: ion: Remove unused declaration
    ion_buffer_fault_user_mappings
  staging: android: ion: Remove unused include files for
    ion_page_pool.c
  staging: android: ion: Nuke ion_page_pool_init
  staging: android: ion: Avoid NULL point in error path
  staging: android: ion: Remove lable debugfs_done
  staging: android: ion: Remove dead code in ion_page_pool_free
  staging: android: ion: Return void instead of int
  staging: android: ion: Cleanup ion_page_pool_alloc_pages
  staging: android: ion: Combine cache and uncache pools

 drivers/staging/android/ion/ion.c             | 20 ++-----
 drivers/staging/android/ion/ion.h             | 22 +-------
 drivers/staging/android/ion/ion_page_pool.c   | 33 ++----------
 drivers/staging/android/ion/ion_system_heap.c | 76 +++++----------------------
 4 files changed, 24 insertions(+), 127 deletions(-)

-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
