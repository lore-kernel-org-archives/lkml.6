Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3577380-1517489027-2-4020862054458209472
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
    t=1517489026; b=e6Yog9Ix7IyU730w2gWV5lBwosH726rZ+IAZleW2TXfGlSs
    Id2gT9G3LET7hOVvRnGgTl3vdqAm0/nrfrmY5S9Pkn21NpHNqxKiyzxKKJ21coJM
    zQ+WzDtibMOueXE/h/zw8VmFRs3k3kK7smWKscBwi+T1zRwl7AeV8pcGgejXab3w
    WsUcyR8HP5JHvg7JTAXzgzQ8JNUxC5fSDXi5FpdLh6Z1Sz+eqEt12zoh/Q1dIDTb
    XMkPEGPEoyntNerDtcethTexA7l/uptQ+RtBDdu/NO9qrBOa2SbZzZmJImgVkPVM
    gw4Ga86tBuWO25xGZMQK8kdkI1GjwhogA8I+2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517489026; bh=5
    mC0jbx2Uy9LVwolmfYB7MTJDWXjD/A+JyUn7uEVxuk=; b=j1E7CiBhO+jMPVeWA
    eTP2KXxRUCrzwcfagZi+4Rxp8IeqgG8elweBiMbNu1T6wW+Xr7llh8SLMywpQxO7
    1jz4uoaMS6HJ+Uvgsyym8VDl1igJ8ZoY/N8fvwxBcCu0C1+aVez8B/5ZBY3x6u1B
    QzXjftY1929B+H717F2mH6OC8oM3dk6Jv5BTFXcpgulHsPeUQ+fEn7QKmhoGFZX2
    dRDqmgwd/AdneGgn+/OPFm4y4a8yxyNbMczz6ru3ci6NbkRJ4AWQSjWWz5Zdo9yz
    1fMJkTTHYFZN6IFIcFED0/veY8uEYZ5rKzhBZ3JStpIlH4gnV3+bl3DwujDPdjjc
    bNq6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
Subject: [PATCH 1/2] staging: android: ion: Avoid NULL point in error path
Date: Thu, 1 Feb 2018 20:34:06 +0800
Message-ID: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
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

If we failed to create debugfs for ion at ion_device_create, the
debug_root of ion_device will be NULL, and then when try to create debug
file for shrinker of heap it will be create on the top of debugfs. If we
also failed to create this the debug file, it call dentry_path to found
the path of debug_root, then a NULL point will occur.

Fix this by avoiding call dentry_path, but show the debug name only when
failed to create debug file for shrinker.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index f480885..3e41644 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -570,13 +570,9 @@ void ion_device_add_heap(struct ion_heap *heap)
 		debug_file = debugfs_create_file(
 			debug_name, 0644, dev->debug_root, heap,
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
