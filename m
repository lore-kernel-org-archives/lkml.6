Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1755588-1525734911-2-5281750149093091130
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525734911; b=iOV9oz9d2siCSRdyuPngkbRhRcmTubfZzW/cSjX8pFcbHkocEo
    vBvgeiDjCaSCE3K63CUGMTdWw0mPMtD45xHA6lDm18d/yCwBPej3U0YROzQjipQ/
    NlZnx/lM2MV8lNgNKhLvI/yTJ26ZDx+8E2cgEK9DHHL2VzbEWNpYiSB08v26nP58
    lFFNpl/WKdWZx6Mxz10wlF1BvOl1+1f1vNMQdIuZ1yBIj4gxMPyY+zOhAaEfh3ZM
    PXSqdazr/W6Fq8tiFre/btYLQMVJJMpAAI4MZXN0ZzK5LwEtF18JydPEspD7J5eM
    m4JmSgXBpQXRo/1B6dErb7fiJ0v8VpGuzqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525734911; bh=N3RZH3u6D8HXIQ3cZpo3nwSDvJznil
    zSXBVOP5T3a0E=; b=iOublZiJ9/kkdAmkn6Inl/DZwPLVtcwDSLN+GtMUeMaJrR
    m80XsyiHPHl/+tMVr6IxC1mOGPXe7oE9Jt3R+EDZXdO0yRc8d8/l75UZZewL6x3+
    x4iYg+Nfz+ed/V6vWESMxWisOsrAbjAOGaNMihYoPzhDsxE7P6BaWIFRfLOLi3Ft
    79vZmuUi8eFUKkxHHFA0R3IMdBFNo10y0Ac/Exr+NwuGrjrKmePQWeiPbmcSLzxI
    Doc0jN+p0lNSXaIy8QB5FyS9xKcK2fFml6yK40w3FlBz5j02U2/EjX8PC/XZzksp
    MSawK4fEZpy/gaarrh4Frt2hAneNxKfrAEj/H9SA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=0qSRCEzG x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=0qSRCEzG x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFaZADEPsAdzHHAb6RVcGdvBoIwcYbpTWuRvp9oEgEGCuMVPIGoH6utmir6v7kfKkOV5wBRGccTvZJ9Hhb9KTghfC2VqPhvuXpvQ48FzwoO1SLJYFXhg
    CTh7Xwowv7XtDgQilH0zNS0y4mnyroQQ90GnacoTHUkAuVuqtgT8ix4bcD7PxbxbUp7nhBVtwvB8BIEawmUa9RO7BPiFJOqSFTkvGTsJo1HdWAEEyGRYi1U5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=PuvxfXWCAAAA:8 a=mQdGnmZtL-RcDV5UKHoA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=uAr15Ul7AJ1q7o2wzYQp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeEGXPI (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 19:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752773AbeEGXPI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 May 2018 19:15:08 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: tglx@linutronix.de, arnd@arndb.de, cl@linux.com
Cc: keescook@chromium.org, luto@amacapital.net, longman@redhat.com,
        viro@zeniv.linux.org.uk, willy@infradead.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] mm: expland documentation over __read_mostly
Date: Mon,  7 May 2018 16:15:06 -0700
Message-Id: <20180507231506.4891-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

__read_mostly can easily be misused by folks, its not meant for
just read-only data. There are performance reasons for using it, but
we also don't provide any guidance about its use. Provide a bit more
guidance over it use.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/linux/cache.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Every now and then we get a patch suggesting to use __read_mostly for
something new or old but with no justifications. Add a bit more
verbiage to help guide its users.

Is this sufficient documentation to at least ask for a reason in the commit
log as to why its being used for new entries? Or should we be explicit and
ask for such justifications in commit logs? Taken from prior discussions
with Christoph Lameter [0] over its use.

[0] https://lkml.kernel.org/r/alpine.DEB.2.11.1504301343190.28879@gentwo.org

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..62bc5adc0ed5 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -15,8 +15,14 @@
 
 /*
  * __read_mostly is used to keep rarely changing variables out of frequently
- * updated cachelines. If an architecture doesn't support it, ignore the
- * hint.
+ * updated cachelines. Its use should be reserved for data that is used
+ * frequently in hot paths. Performance traces can help decide when to use
+ * this. You want __read_mostly data to be tightly packed, so that in the
+ * best case multiple frequently read variables for a hot path will be next
+ * to each other in order to reduce the number of cachelines needed to
+ * execute a critial path. We should be mindful and selective if its use.
+ *
+ * If an architecture doesn't support it, ignore the hint.
  */
 #ifndef __read_mostly
 #define __read_mostly
-- 
2.17.0
