Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1166103-1518432768-3-1934994735680635374
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
    t=1518432767; b=XHeNDAuT5wMC4kBqLyuAH5wcl2lYmISjiw+ogIUxA7LlpOL
    N71BWSxLWtd7uqgD9s1Wxskrub3WvcGNolXNyz5i/jFL4Z2xE5U2hDLUlkYYhGYB
    3xQZ3VAmcBAmXcrUC+o0By6wE+/Dgr5YO2XpPwypMHTYodVS9O8/3YjfqXhI338P
    9tKcCpn35z2CK+7TzGC9Co6Af0pa7DuSWrgugq5XEqHL3T9n6S0JpPdAuNrBJGzP
    XVJmxzyOHLssw991k5EOqBCWa18O+HY2MM4/LOLeEy/NdoP6u8oEA4z6a7cSEOD6
    abOnN+2Ps9uHIw8sd3bUswBjgSboRwNn6XALYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432767; bh=t
    5HJhLXwQ2Lb7Mf/oGXcmNcthBYw6g6qjSjd+ESw0Ao=; b=uw7UOnhd+8CkjZ2E4
    w0dHYub2CqWbbTBNmV5H8fAtaDL7FwSvNj85WCAOnwSmaiLIvoHo/mldFabfoty8
    3zhIPJ37P68Ir0eL9Wqqd1Il9mW5ZMrDA6luiRFwpRf0S4h9sQNFOqOt5cVSF2Nx
    uqRva+LZrVrIFfcVcS7IBP9Yx7GKsoMCd7+HlwDhcmCgt8VbV7qRlho4RIHqxctE
    1NYOdaAQ1wIDsCb+ZObRCeTLWahkuhMmQxoQCpdL6g1q6WoMIMyVH9NAN9/3jpW/
    qMFBpHoyHlFXaXwdbo4aMheH9JGKvD9bSjG72P9uNTTLzBlsndS8l5EScsFrT0He
    fON4Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
Subject: [PATCH v2 3/9] staging: android: ion: Nuke ion_page_pool_init
Date: Mon, 12 Feb 2018 18:43:08 +0800
Message-ID: <1518432194-41536-4-git-send-email-xieyisheng1@huawei.com>
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

ion_page_pool.c now is used to apply pool APIs for system heap, which do
not need do any initial at device_initcall. Therefore ion_page_pool_init
can be nuked.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index f0847b3..4452e28 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/list.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
 
@@ -158,9 +157,3 @@ void ion_page_pool_destroy(struct ion_page_pool *pool)
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
