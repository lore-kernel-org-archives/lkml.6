Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824482-2-6132998844848338724
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
    t=1520824481; b=UjwrRjau/a+r3/eudjm/aq6+sCRrikk1Fvr7MKYKYcCTC4A
    /5v+it6Vw1x3S8AKtE+i6OaaiJcYj7mpuIoFVZrAfQylVZ6sd+TGH3fvZMwZ8vUz
    mDIn6OOoJ+ybQPWamY3cdl+GSitAbooUaeQNS+n2foNVe0nYJL8x31eImQ97a2Xg
    fPjSMNWwoGdsO2xVIGMZD5Xdu6K2ZQdIYuH2Bi3O7FIjrh3Kvnfzcsqchp8fENf7
    fWqHyfDrtV/i6o0ZckmaB7Y2HXjrzYNT9wXJNgHBoLjVjYR+T6jiK6A3dH/hlD6q
    hdWJSsSqgCZE9C6Kzc3Hy4h9oFFFvaW4GZd9Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824481; bh=u+k7qEbgcQyRgp5bbvX
    m2lQsGQ5w565/WFCTJ/ZRv70=; b=JlL6iCBbZHWuNV1aJNrN0Hc3D995JIDzzxV
    9ll6I9MY+hMOEdf1YhgyUvuo7w9eo4ubDhfyeoGBIjLTdW/1+AWF5F4Dq1ilNmSG
    2NYokn8tjnw91+FHhtIV9X2JCVALN+UdvteG2Bzo9G47b3mTcHR7cYyuSf0IQVnp
    oywMjjW/ON9bjrhGgT7cSltWALG1yR+xRoWHQiiusmcoJmJsKh9aOxPFy2aadNCd
    nEE16f8CvSnxPoxnZXITqwbo8adxMFxMgPLex6QLDrsXmPkfBvKaiN4cOgRzeQAT
    VYZeMKF+seI41YnSqLBxwMKNwuDVE6xwdp/l+ErgvmuRsyGqb+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S932951AbeCLDNJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:13:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41584 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932803AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.289522228@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 68/76] nospec: Move array_index_nospec() parameter
 checking into separate macro
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 8fa80c503b484ddc1abbd10c7cb2ab81f3824a50 upstream.

For architectures providing their own implementation of
array_index_mask_nospec() in asm/barrier.h, attempting to use WARN_ONCE() to
complain about out-of-range parameters using WARN_ON() results in a mess
of mutually-dependent include files.

Rather than unpick the dependencies, simply have the core code in nospec.h
perform the checking for us.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1517840166-15399-1-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -20,20 +20,6 @@ static inline unsigned long array_index_
 						    unsigned long size)
 {
 	/*
-	 * Warn developers about inappropriate array_index_nospec() usage.
-	 *
-	 * Even if the CPU speculates past the WARN_ONCE branch, the
-	 * sign bit of @index is taken into account when generating the
-	 * mask.
-	 *
-	 * This warning is compiled out when the compiler can infer that
-	 * @index and @size are less than LONG_MAX.
-	 */
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
-			"array_index_nospec() limited to range of [0, LONG_MAX]\n"))
-		return 0;
-
-	/*
 	 * Always calculate and emit the mask even if the compiler
 	 * thinks the mask is not needed. The compiler does not take
 	 * into account the value of @index under speculation.
@@ -44,6 +30,26 @@ static inline unsigned long array_index_
 #endif
 
 /*
+ * Warn developers about inappropriate array_index_nospec() usage.
+ *
+ * Even if the CPU speculates past the WARN_ONCE branch, the
+ * sign bit of @index is taken into account when generating the
+ * mask.
+ *
+ * This warning is compiled out when the compiler can infer that
+ * @index and @size are less than LONG_MAX.
+ */
+#define array_index_mask_nospec_check(index, size)				\
+({										\
+	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
+	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
+		_mask = 0;							\
+	else									\
+		_mask = array_index_mask_nospec(index, size);			\
+	_mask;									\
+})
+
+/*
  * array_index_nospec - sanitize an array index after a bounds check
  *
  * For a code sequence like:
@@ -61,7 +67,7 @@ static inline unsigned long array_index_
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
