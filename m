Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1166103-1518432797-2-344708203674506941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432796; b=NKHCBb7P5PkGr5w4xNzpPBXtXFCFRIw8WSXtpvTlsVlWg8h
    O9aQaVQQxpU6Ew64AI5Z8TmUj6/Tx1TqECK7y/BGvrklcAYleOsaF6sbEmj9OSoU
    PHK/lsqH/vzBkIxjLsbda0UUM7P0AUREBT4mnJ3cUwf4dmfcLdjDTDTHv0DnKDe6
    jbSoncbIlWOMf5AAE5MswG536SfnDQOKTBLMacmPqCtA7gMtEw04qjnD5O82U+cF
    mRyU+Xnxw4uPirjTCHGYy2rmmOYKHL7szxSCzpFltsPrTNsItnLD5du/Q8IX6xKZ
    sLZ93d4aOnXWfJu/LbpPMgifwwhW+j/kTtIVAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432796; bh=m
    oSWVkrmt/MnVuh1dBJqZFFBDzxW3SY6s8kqGTMKKQ4=; b=arZ/UsEFadF01PfOx
    0btM/sBk5OyGsqFFLCfGAoWqymMGNd0v8JZUy/tEAW0sS2mF+BaqqZVNvywLpDbS
    j3jFCNWi3sCLyqngJzt2PHh9KWEMXd3PlBLJT+Ch6f4llE0FNVHcJEgpYLbabG/9
    m1qq5yWXyNihz6lTchlBmdr5rcqIbdVB8nXfrqc4jER0mh0lZ4np12jnQg4t4SUT
    LFfebhIIoJho9DaWNzMFL2cqKn0MpM5Qd4i1nC1UuNPabpbX7gYKMXkxe3MW7VP8
    G0g3Svrak1HTgucv6qHt9e5yeVR8fTtxBV1GiJIkmUQ9LSQZWsPabxJZ3j8HnWvs
    odJsA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
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
Subject: [PATCH v2 4/9] staging: android: ion: Avoid NULL point in error path
Date: Mon, 12 Feb 2018 18:43:09 +0800
Message-ID: <1518432194-41536-5-git-send-email-xieyisheng1@huawei.com>
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

If we failed to create debugfs for ion at ion_device_create, the
debug_root of ion_device will be NULL, and then when try to create debug
file for shrinker of heap it will be create on the top of debugfs. If we
also failed to create this the debug file, it call dentry_path to found
the path of debug_root, then a NULL point will occur.

Fix this by avoiding call dentry_path, but show the debug name only when
failed to create debug file for shrinker.

Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 57e0d80..4b69372 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -564,13 +564,9 @@ void ion_device_add_heap(struct ion_heap *heap)
 		debug_file = debugfs_create_file(debug_name,
 						 0644, dev->debug_root, heap,
 						 &debug_shrink_fops);
-		if (!debug_file) {
-			char buf[256], *path;
-
-			path = dentry_path(dev->debug_root, buf, 256);
-			pr_err("Failed to create heap shrinker debugfs at %s/%s\n",
-			       path, debug_name);
-		}
+		if (!debug_file)
+			pr_err("Failed to create ion heap shrinker debugfs at %s\n",
+			       debug_name);
 	}
 
 	dev->heap_cnt++;
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
