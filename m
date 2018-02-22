Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4094173-1519297707-2-17588664242521093296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519297707; b=PN5AYDE/gAn+GbpTctYowuJQbqQtj1FR+3dDBY5bhb32Qir
    tD8shbPJPQCkgnRiVuitfi2S7srOBv/2jbmnMrvee13RkHaWt8nLgdQrslx1Us48
    wZ0gOXLtCUZjcF2XkAhNpVF9cH4adrVSixTHmoqiKomVZlrKRh6iHOOrBagI9oLJ
    ePqpHmHuGdmq2JiDYDCqOle3qWnamO7n1dmrHRJIu53OCHdgHqkyu7Kf9QyPkyvx
    IqN64wmz9OOwb14G0KyU5yfIqTNt/aqr4gTjgpsVgVpxKlZEPR4AWbGpRNSZMdwG
    xpJ+01wMJLLkO1/20tNG+HNr8RFO3/oaEs1W7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519297707; bh=4
    dBd5YD1XwZkrJDRvoxK4Q/+B05/7Tq646SPF9+bUFU=; b=FnWqHvliQHgK2Xwuv
    yTlxhbot0tmN6QztkpBMWfwrEOIgw/XsIhneTeVobVV6W2pXsrZax9bFUWGbWZ2+
    6jvuYKE97H5TvyHoS2pqX70NyJKvtxrtn2dt3XXCj06kFQq4SB3NLYkYkBIrD+dY
    /YlNyc984XhgbIH6Qpx2VbG3Xv/77umElK1wOAJzAuaTAIYtm7/WlNMCzzgL0O23
    8urnLgS8L4i0xWDMXE6gl2N5kAQ3hWK3AWyziu8zubnjFEm1Rxn3AK0VBRNZT3Kf
    P0ao5iOUPOEl0B1pOMAsr/V0UEGWkjlpFlmD9jmgJdri15+l3+lwSiu/bEJcNspf
    yDfXg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
To: <gregkh@linuxfoundation.org>
Subject: [PATCH -next 1/2] staging: android: ion: Remove check of debug_file
Date: Thu, 22 Feb 2018 18:58:39 +0800
Message-ID: <1519297120-26308-1-git-send-email-xieyisheng1@huawei.com>
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
 sumit.semwal@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's no need to check the return value of debug_file for it is just a
debugfs and we will go on the following process if we failed to create
debug_file. So just remove it.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 74d9a4e..0606d50 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -522,7 +522,6 @@ static int debug_shrink_get(void *data, u64 *val)
 
 void ion_device_add_heap(struct ion_heap *heap)
 {
-	struct dentry *debug_file;
 	struct ion_device *dev = internal_dev;
 	int ret;
 
@@ -556,12 +555,8 @@ void ion_device_add_heap(struct ion_heap *heap)
 		char debug_name[64];
 
 		snprintf(debug_name, 64, "%s_shrink", heap->name);
-		debug_file = debugfs_create_file(debug_name,
-						 0644, dev->debug_root, heap,
-						 &debug_shrink_fops);
-		if (!debug_file)
-			pr_err("Failed to create ion heap shrinker debugfs at %s\n",
-			       debug_name);
+		debugfs_create_file(debug_name, 0644, dev->debug_root,
+				    heap, &debug_shrink_fops);
 	}
 
 	dev->heap_cnt++;
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
