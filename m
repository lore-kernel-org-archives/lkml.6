Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826229-2-17129110242680359788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826228; b=NGxdhfK6Xy5GlMuf33ABVycnkc47qq6t61YnLF1SyCkbKqZ
    tLyViBs3ntY3IbpsLPROqa/5XaKWZFj5dt+g6jEY5ssbVycDnUiCAln+4BYVrnYZ
    HAhFXCZPpL1qP9TE6gjIRFtLrkjGwLEqKcHs6h6/RsPbWWHzf7YA0tZemUQ7QL27
    iwXOD8iykC9ZbQI4SsnlY0Lg9xTaIeEO6siVoFP0Ff8e90IulmgZUBT9LbIhvOVn
    /xKSUoMgtG7R9jlxxa8YodZpnwMeXnK59xPt3Rl5favwHOLvT11lHxrU/f9F0hd6
    KJZkBK1mC6fkQzB05+pdP7lFgTeQR8hFJjPNaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826228; bh=xPLZoJTYy8T0FUMBw9j
    Qpskba0dnQgEaoc7Hldv5nRU=; b=fzrJIiYIkRHkySfXfVlb/So/X5HjIMV9KWe
    LhE5iBS68ew67eqrixldwHFHvV4zVYwMm7Rtr7P2vMNCjiO/zOCHi1TuOEWKaxqf
    9ufmKZHQnEiFbfHLO147mwke1+MH1IJVjNRmhUWPel8BdurfreLJY01mcUtsV/iR
    nwbMzx0XYuU+uVN9Iujgf503KkE8hXYK9rpmTCx42eW4T3N5MPr7IzrMTUP3ub9q
    Hml5mEmEkMg/sviq+B4NYFUNrnRlKF7iUYvqTVwtPnqdkogkzWwgl14iwso5Rn/R
    yXGBtig9zsnSlywYEqItvzNeyt+DlQGViCYUty6O6JaA80vJIvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeCLDmB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:42:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41162 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932661AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Peter Oberparleiter" <oberpar@linux.vnet.ibm.com>,
        "Yuan Pengfei" <coolypf@qq.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.419512224@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 018/104] gcov: add support for GCC 4.9
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan Pengfei <coolypf@qq.com>

commit a992bf836f9c3039a16f4bd068d161c86c6c3e2c upstream.

This patch handles the gcov-related changes in GCC 4.9:

  A new counter (time profile) is added. The total number is 9 now.

  A new profile merge function __gcov_merge_time_profile is added.

See gcc/gcov-io.h and libgcc/libgcov-merge.c

For the first change, the layout of struct gcov_info is affected.

For the second one, a dummy function is added to kernel/gcov/base.c
similarly.

Signed-off-by: Yuan Pengfei <coolypf@qq.com>
Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/gcov/base.c    | 6 ++++++
 kernel/gcov/gcc_4_7.c | 5 +++++
 2 files changed, 11 insertions(+)

--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -85,6 +85,12 @@ void __gcov_merge_ior(gcov_type *counter
 }
 EXPORT_SYMBOL(__gcov_merge_ior);
 
+void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_time_profile);
+
 /**
  * gcov_enable_events - enable event reporting through gcov_event()
  *
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -18,7 +18,12 @@
 #include <linux/vmalloc.h>
 #include "gcov.h"
 
+#if __GNUC__ == 4 && __GNUC_MINOR__ >= 9
+#define GCOV_COUNTERS			9
+#else
 #define GCOV_COUNTERS			8
+#endif
+
 #define GCOV_TAG_FUNCTION_LENGTH	3
 
 static struct gcov_info *gcov_info_head;
