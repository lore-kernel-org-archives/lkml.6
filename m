Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1166103-1518432772-2-7060277231287989779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432772; b=YSmlzKLAl3tgBeoLr3C9omZrYOk+k3GfXLg66tqyElRLnZO
    zc5sDaIT0Ipt0TKBWaUM981WPuNP5BhMgwFBujdUiR6ov6+MwJocWSe2mEoNoSI1
    dpkQs1Je8lEVM+VY9kS0H3GqGx8R9vYyk+Qy0m8XbnTX8GhTuioapK2NgEIHM8eT
    D6Is+YNzACi05GU2X+iaOuhD/eWPAf6hs1ywTZXAlIwh7CJSFdxu+z3BZSajHRv+
    cFe0G3so+MBfDuXjqhIifLTuqW8jifm3CJu4WcHpAr6xrNx7FK3zSX5bQUUfwNt/
    J3s12kROPx52n5trXSJUISIsfjTYm3bR7xTCSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432772; bh=N
    ar6k5otbreVsVc3GKLBodyndWCmuQVMdH5rckOxtmw=; b=P5nyd4n2VIkvSF1SP
    j2awNNfLea1DsXVIMHKnS8QVjp5ismTcKopUR0pfBq+2wKENVWxlzRelX21h9LwG
    oyjm/zGXu81XQKhdsdEBq79lq5Ihle52vYNB+dSMLhat8c/uA8vxHGwH/NCoIWyp
    HqZM4I5IP4WRgoq72mu5W/1oVw4R344EPhkYYxPGlkEX8OnejDTg4HXsbDrNxjEV
    MR0kT62k0zuoTmjgyWh5gVmP4oxZu43TkWsiU94f6K/NI0MfOGTZP69bPb4sEmjf
    RWIt7CvDAh1DEG2gzIB9Mzz1fzmlaP8Ub0p7Hzg1ITdqWvecUIccCTAMpztj1moD
    wjKfA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>,
 <sumit.semwal@linaro.org>
Subject: [PATCH v2 8/9] staging: android: ion: Cleanup
 ion_page_pool_alloc_pages
Date: Mon, 12 Feb 2018 18:43:13 +0800
Message-ID: <1518432194-41536-9-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
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

Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
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
