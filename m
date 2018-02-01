Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2255742-1517450642-2-18229969011205058123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517450642; b=VYBucCV8hI6jHiYkMfVLpDrEaE5u+Jv052o8MZWU9pRh2MX
    Vl1cpK00YLN7uK0FhuSrMCuiboxIrcerZAuJcMIXHF3LGkjwni0Fy2xk/5mWnLj+
    OuE8OEhiZanyEGJEkHFeaj9mAAciayK7JdRswavdrIisA6EvTR4s0SxQ1oAMuPMo
    zrYrgQ12MkpVDu/NoYPSgUCYpmPEVcKUey8dAUdj0ejATA2dArErOs2qhDPIlR2b
    eoWOYsmmM/uqM0yaLEtAYmDAiuOR7nG7LP/P9p79zJnc0T9kxIl/chPtsZi7woBb
    Aqt8/Gwi6Fqb1SMkzp44c1jumQrzDhHDI+Hh0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517450642; bh=y
    8Eu4euMT+TF9Zclcmi8cgWG0Wgy/gawJMYcJsgHWjg=; b=MJGJYCD/9oVAvYGfB
    traso21m1jUuJix9e9ed3etAJuspY95aAg9p3Me8522IMYLh9CINkAJfhWtSsChv
    cDXkwNy4ci+Lv+JhTKBZ/HGKS4m8boE6qeMVszGUIg/jSy6j7YtJ10NHimJR1Kwf
    n4qkxkfItgvRR/654DVwYkp/oNIn9wbfJZ3Myj/1mR48z3H3gYZcQetPA7nTZtiM
    T78pjmvEt2W+9LKc1IejAV64Xyd5FGGxoN0U3riK7xkx4ZRUC8h2lt+L64ObKJ9F
    w3VsyC3peT/4FhTZXcKFD8I4OSJzygtdlPvE04JYDCSOHK+68bbGvLVnUzT3Cs5S
    CdJjg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
To: <gregkh@linuxfoundation.org>
Subject: [PATCH resend 3/3] staging: android: ion: Nuke ion_page_pool_init
Date: Thu, 1 Feb 2018 09:54:22 +0800
Message-ID: <1517450062-16123-3-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1517450062-16123-1-git-send-email-xieyisheng1@huawei.com>
References: <1517450062-16123-1-git-send-email-xieyisheng1@huawei.com>
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
Cc: devel@driverdev.osuosl.org, xieyisheng1@huawei.com, sumit.semwal@linaro.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ion_page_pool.c now is used to apply pool APIs for system heap, which do
not need do any initial at device_initcall. Therefore ion_page_pool_init
can be nuked.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index f2318c9..3c1eba5 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/list.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
 
@@ -167,9 +166,3 @@ void ion_page_pool_destroy(struct ion_page_pool *pool)
 {
 	kfree(pool);
 }
-
-static int __init ion_page_pool_init(void)
-{
-	return 0;
-}
-device_initcall(ion_page_pool_init);
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
