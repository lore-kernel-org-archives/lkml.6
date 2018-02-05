Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1248312-1517801757-2-2098628828160184084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517801756; b=S7Ws8fq694GU5NcKaktboqoDLZwL98oGLM5Wzlm5liSW3mD
    YkVQxoVUH+WCdH8fJexB1LQRWw+Dx8g3BV8Ge9I0LdPwkZrtE0woSuiXlkL7JmOY
    Yvhzu2Cl6iyjMvMEaAD786MN8oEpstrf2Ezq7x2bgEE7avflMLS5rQtR3lI+mt3F
    9xlJdQ+LZmVOhcoY9I4YSuFGd9vs0ClrwSvhBUJiXNsKb41UjtgPUv6TTpR3cU2S
    EHwd698AFqaVpIfxcKzyrOmjScbahzly9aI1bp6yTMrVLU0QYvg2P+qi69xiaGXt
    +5UY8+lhNLuWp9iex3A3dF6FtltrI1yPOQ4R+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517801756; bh=N
    lW8lTwF76f12+ADNcxUVac01f8elxUBQnmYYPNYz08=; b=l5KxcZRINfQxUKVlI
    okZi1sMOoJ2xLEJ8OTyYHTIDHCEWG6vd5ef4PZI6iF8r7+T3fUnZ16lcP08mKqpV
    GgP7NdnOK8anMCXFtr6POm/RyEwXhUmwJZZI8evwYxvOnemW1MlGSngiPZld/XNh
    G2fp1yWmFUFjVq1xZ5T7awiZjq3QOGG3OpwgHTcU8b9k3cWZqvsd6lEyVG944nDx
    6NC49C6JFCU/qjtfCicASbqwjV3xiIYImgU+ZQdA2+DXyBm4zKG/Kj32w1fS1Z79
    2rHPpxfXI67CYwXA5BocN5wEyG8pz47nn/Y7NyKdlnpksoZT90NzCcsQB2A4YZN6
    6Go9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>
Subject: [PATCH 2/2] staging: android: ion: Return void instead of int
Date: Mon, 5 Feb 2018 11:26:17 +0800
Message-ID: <1517801177-37021-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
References: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
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

Now, nobody care about the return value of ion_page_pool_add, therefore
we can just make it return void.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 150626f..e3a6e32 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -26,7 +26,7 @@ static void ion_page_pool_free_pages(struct ion_page_pool *pool,
 	__free_pages(page, pool->order);
 }
 
-static int ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
+static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 {
 	mutex_lock(&pool->mutex);
 	if (PageHighMem(page)) {
@@ -37,7 +37,6 @@ static int ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 		pool->low_count++;
 	}
 	mutex_unlock(&pool->mutex);
-	return 0;
 }
 
 static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
