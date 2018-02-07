Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2942899-1517976568-2-4260506326317074555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517976567; b=p00UTFvygBqYsZXec1iP2CZaLUePcouO0EWBLStz5pG/ktw
    g2srTzvtgmn117wnMkTU0sB0fo+H+AvPJx6FoVNhcIdKIKCxSusLLzYrkhNKq9kE
    aWqD2f+hWQLrRPbkWQrcyfHbaDTp/LUOjo5YrY80QgFoYGcpnhvJKuTIuhCiozZ0
    lpC0oi06x6p8FLrSfbKQ1JhmZkU1VL/9k3I0K/7SWlZbPL/nMRuHLdMo4Xniaqds
    WJtj2kcfNhPGknWt0yYTsdwd0Np7xM2PcSOg0m0+T635d1wInYdIHKE+HTAlr0jX
    +TOVreUJklWYDTqvBQrrMjOZPz/Sy98f1hZjNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517976567; bh=S
    19afkdWXUuGJIWbz46INNP43gVrUC+nmPfwl1xNJF0=; b=E9g+LsbDFUvNfxPAl
    xxo01e2dHvvyLSciB2RkC8dbucrYPYccNol3FAuNb+unEWSJnfDeK28fH1ilShHo
    mxDdty32Ribp0Bc1nHBzXIfz7EhwkUQ7Rvpn2cehLgNsgGMajUz+VUGIVg1Ol0p6
    kkF5pdE5tTAWJJYL/+DCk8VVWAMqLS/lv9Sfy6I6zo/1DIAE96D6BcTTKvQvUO/0
    e80sSKp+wuAapiLa5s2WQxzawpUosRb1TtJn7KuPOJuaLSzy3Nito/vjQkzDrFIu
    YDPZkG8AGL60Fikwl8QXSsGXY3JC7k0+5WOOPjbtWhiK6J2waudk9vLJTLhQlC0g
    4ZHWA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>
Subject: [PATCH 1/2] staging: android: ion: Cleanup ion_page_pool_alloc_pages
Date: Wed, 7 Feb 2018 11:59:45 +0800
Message-ID: <1517975986-46917-1-git-send-email-xieyisheng1@huawei.com>
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

ion_page_pool_alloc_pages calls alloc_pages to allocate pages for page
pools. If alloc_pages return NULL, it will return NULL, or it will
return the pages allocate from alloc_pages. So we can just return
alloc_pages without any judgement.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index e3a6e32..6d2caf0 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -11,13 +11,9 @@
 
 #include "ion.h"
 
-static void *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
+static inline struct page *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
 {
-	struct page *page = alloc_pages(pool->gfp_mask, pool->order);
-
-	if (!page)
-		return NULL;
-	return page;
+	return alloc_pages(pool->gfp_mask, pool->order);
 }
 
 static void ion_page_pool_free_pages(struct ion_page_pool *pool,
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
