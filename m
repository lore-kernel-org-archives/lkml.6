Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825117-2-13357611649349064576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825116; b=iIpVF6d0p4BNSMlZv0GyUZNeMNkSuFnnQ1CNC/YgypooGxj
    JvOYMupZ864Srtn1Ag0kzM1X5aT5pYr+BhEqnf+GuQM8itfXKkBCBGYdR9cz67lm
    c51PYHVgZbrjdGIsaic+J2E5tFnn88uawL1DIe9TxJcyRVZV/EJJJGCbVrWOk8bY
    TUIg4n/uEsKmmap+dyVy3yR5NIeNJKUnOkhZaMseLkvK3jL7C8XfQciUJyKxwCXf
    8SnwUs8RNbSPFl5/q58G9OZJlC7OfpNIQGoBOBgV6pmMJwl9d+oChJyI9bk0eT8Z
    IfLW0ATRb/GSv2/Z3ZrIEvUi987jNYtFPQFhSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825116; bh=EwFbqxIbMeRCKe4icDE
    CVfQnBE8sjmtj6BiCikx4EFg=; b=iwvws0wBQeUZ8HLcgbN4LrbtN50hZ/2csTL
    cRlyMkfCYyZqlPqQQEVcRt5LkWJzvlQesMTk+CecA2N7QjLdQtB5RP187Pt/j+nC
    myZZ5BQSqmaoFxFYIh3nFY6V3PhMEGYsjqFqirQ/t+0j54I6hq3i6YQeWHKgs4W0
    T5XduIBzLaB9n7tsLNuAmat3J4uxE0v48qHaqBeLZLx64/d81vKSQLAMv+qvjEkc
    A0FkBLn9xjtL+KoF5GR0G5tdBWJMnh1xNqIVcU1bbswBHYJMRY/lvWP3WtcKVkPF
    zXxC5cE+gb5RIAB7ej+J3CygGucvBZxIyxjsuyGyumf8LZoHPwg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S932861AbeCLDYO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:24:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41244 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932691AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Frank Arnold" <frank.arnold@amd.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Borislav Petkov" <borislav.petkov@amd.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.128748183@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 028/104] x86/bitops: Move BIT_64() for a wider use
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

From: Borislav Petkov <borislav.petkov@amd.com>

commit e8f380e00840f694599e6ab42806639f7de26f11 upstream.

Needed for shifting 64-bit values on 32-bit, like MSR values,
for example.

Signed-off-by: Borislav Petkov <borislav.petkov@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Frank Arnold <frank.arnold@amd.com>
Link: http://lkml.kernel.org/r/1337684026-19740-1-git-send-email-bp@amd64.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/bitops.h | 2 ++
 drivers/edac/mce_amd.h        | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>
 #include <asm/alternative.h>
 
+#define BIT_64(n)			(U64_C(1) << (n))
+
 /*
  * These have to be done with inline assembly: that way the bit-setting
  * is guaranteed to be atomic. All bit operations return 0 if the bit
--- a/drivers/edac/mce_amd.h
+++ b/drivers/edac/mce_amd.h
@@ -5,8 +5,6 @@
 
 #include <asm/mce.h>
 
-#define BIT_64(n)			(U64_C(1) << (n))
-
 #define EC(x)				((x) & 0xffff)
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
