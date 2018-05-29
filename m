Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473614-1527616352-2-5507928452563041477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527616352; b=J1CyBBaUxU7gi7rxabliey8N3/jhpYFfGgXgfGdnjmMIU+BxLm
    KChrxkWTRandtWoOgXTlPwr3ejbpjyDzfBqngBQnxcI00DKrp83dX+8qY7ANyMZG
    ZHh15ak58KN+4rhr9bsgbEOTNncsXgHgJGaaf1Syk+NzIgPRrpdUSXoqDzjAyTCg
    qESXtVzRHPPM/Z7B9PLJzKcXz2cxuMyghvO8xoCg1iIfa7LghtLL3tHmgTJi94fm
    Tcbzi2BxLwD+qMF0hqUzJlcJQ8Tw6aZ5diTk8gL3QHdWA+fFHgws0Iu8CXSmLtV+
    MoBngdCCcoLQmtYsS1usvvCciybHyQoCJPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:sender:list-id; s=fm2; t=1527616352; bh=nIK+GMBluQu
    nwjdDjHaFoOG+Eijsa4m850lIcmI2s1k=; b=PIodrRp0oUTFoCRtIvvDeBT5KdJ
    AG9Uh6FCILmzJCD5giNlyw6LdbQR70wQRc3y96GlCmE+U3XCotOjmzQMKGFtTIM0
    9DQ9eMhhAUFduKAzeromVgb54aZxdOXX66jitFeIWIRcAOSXsgOaqH70MhpQ/stL
    0ijpcu2Qco/rxmgOhEzYFoHfH1PCdYS02WTlfgeZNP5E9j2yJZ2Vy+BcPFD6O3c2
    2KgmAYMgK1z8Biyf0QLw1KveMqcvaboPVi5m2y+Nc15Is4o9gh4q5Yyz4354ri36
    B6d+HWqsG9A5X9QmZd6jQtY2diV2I1Fb2HYivz6qT9b4qxPIL3VyLMwJrSw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIQdLrvqh1YSdDbDvvll812D/qNwYxN/OdQojIBOMloepEQQj8tEEeqhSEakF1iPq+tM+5Gx4JwJPqGZ821N4kN2bkVwI8WbSG6Jwm/5YJSJnQRnT7Pi
    Wx/s+GbD5nRL5HeeO9edKWkTdmVUP/knLLKu66lNvqiHVoanUfPkwhXdQuRlnF2gwoBuvvITMzBuh740cVVEE0OZHFwnIbx3vwYqP8+TsElBA3FATWgV6quK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8
    a=QyXUC8HyAAAA:8 a=QHnUnqrNbGsPDOyfjgsA:9 a=yzbIBNFuMBQuJNWB:21
    a=tGGYIao_fjB3U7nK:21 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965453AbeE2Rw1 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 13:52:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:57205 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965391AbeE2Rw0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 13:52:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="58641737"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shaohua Li <shli@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-fsdevel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-writecache: fix compilation issue with !DAX
Date: Tue, 29 May 2018 11:52:16 -0600
Message-Id: <20180529175216.24937-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-reply-to: <20180528153834.2268557-1-arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As reported by Arnd (https://lkml.org/lkml/2018/5/28/1697), dm-writecache
will fail with link errors in configs where DAX isn't present:

drivers/md/dm-writecache.o: In function `writecache_ctr':
dm-writecache.c:(.text+0x1fdc): undefined reference to `dax_read_lock'
dm-writecache.c:(.text+0x2004): undefined reference to `dax_direct_access'
dm-writecache.c:(.text+0x21cc): undefined reference to `dax_read_unlock'

Fix this by following the lead of the other DM modules and wrapping calls
to the generic DAX code in #if IS_ENABLED(CONFIG_DAX_DRIVER) blocks.

We also expand the failure case for the 'p' (persistent memory) flag so
that fails on both architectures that don't support persistent memory and
on kernels that don't have DAX support configured.  This prevents us from
ever hitting the BUG() in the persistent_memory_claim() stub.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/dm-writecache.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 92af65fdf4af..1c2b53ae1a96 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -253,6 +253,7 @@ static void wc_unlock(struct dm_writecache *wc)
 	mutex_unlock(&wc->lock);
 }
 
+#if IS_ENABLED(CONFIG_DAX_DRIVER)
 static int persistent_memory_claim(struct dm_writecache *wc)
 {
 	int r;
@@ -337,6 +338,12 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 err1:
 	return r;
 }
+#else
+static int persistent_memory_claim(struct dm_writecache *wc)
+{
+	BUG();
+}
+#endif
 
 static void persistent_memory_release(struct dm_writecache *wc)
 {
@@ -1901,16 +1908,17 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	if (!strcasecmp(string, "s")) {
 		wc->pmem_mode = false;
 	} else if (!strcasecmp(string, "p")) {
-#ifdef CONFIG_ARCH_HAS_PMEM_API
+#if defined(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_DAX_DRIVER)
 		wc->pmem_mode = true;
 		wc->writeback_fua = true;
 #else
 		/*
-		 * If the architecture doesn't support persistent memory, this
-		 * driver can only be used in SSD-only mode.
+		 * If the architecture doesn't support persistent memory or
+		 * the kernel doesn't support any DAX drivers, this driver can
+		 * only be used in SSD-only mode.
 		 */
 		r = -EOPNOTSUPP;
-		ti->error = "Persistent memory not supported on this architecture";
+		ti->error = "Persistent memory or DAX not supported on this system";
 		goto bad;
 #endif
 	} else {
-- 
2.14.3
