Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1210825-1517801756-2-5832726855746042591
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
    t=1517801755; b=GwlNcIJk097Rpvd9VeFzGYwNsBDonK4Eo7G6/xndslt4b08
    mx/xaTS4rhwJoFc8lM05yRAxYLYt51Hd+AhIipcaagDhLK/ecldUvhbHfuLPvqAD
    yjq2GK5OE2Fwz8tWQ0XvYh93gCi370D9jtyUWvgUuqXjdshpE7Qk96oGPkIrK1VJ
    NW/2k2IyVE6Kpdgeo6OXf9xNNUNOOQ3BjiV+iB2FaWm3f9z1Wrytw7a9RUgP4A4v
    66rt3Ff7g+d7UMyVvtxdcEJpMFezGpMpz2HlnMziku8/kJOtBuPkp3i4DXTHP9uj
    gjcTLTmy0Qi135jL0WDUamR60B2dVuogA46Bl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517801755; bh=F
    htXb86or3KT62g0IDjhFD1tfCapV5h05BrIsqIhvNA=; b=rvSIm9S8uA+B/8JTT
    occPcw/F9WhHbWbHayzdnCSO5viohAe20YDZ+1JT9hVGln9uhVjTigl8Db22+nh0
    HATT8g+jS/7/l4FFc4nQxQr9XUU9WVr4Ve28FJap5i5M+5oBqsXZ06+KrtTNZHTE
    4zkf6TY3epVKv4qg23Np+TOkNb8BwcbLqlMR/C3dCAO2jNLmArtJa07xBnTKr1QK
    x+zB1PLQY4gdlYplyknuygO6FHd5iIDqJKladAf99xv7v2fcUOcPOFa1A5lswOhn
    4kgy72vrd//ZFfdLIwIHpD+mPIR5NqIIy2yvDQQ3DKD6bjeeGlQWEUcjCdGFIf3v
    MJvHg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>
Subject: [PATCH 1/2] staging: android: ion: Remove dead code in
 ion_page_pool_free
Date: Mon, 5 Feb 2018 11:26:16 +0800
Message-ID: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
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

ion_page_pool_add will always return 0, however ion_page_pool_free will
call ion_page_pool_free_pages when ion_page_pool_add's return value is
not 0, so it is a dead code which can be removed.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 4452e28..150626f 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -79,13 +79,9 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
 {
-	int ret;
-
 	BUG_ON(pool->order != compound_order(page));
 
-	ret = ion_page_pool_add(pool, page);
-	if (ret)
-		ion_page_pool_free_pages(pool, page);
+	ion_page_pool_add(pool, page);
 }
 
 static int ion_page_pool_total(struct ion_page_pool *pool, bool high)
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
