Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826606-2-15103483394151366193
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
    t=1520826605; b=wiTk6mZFGuFoB191EfjGGWDyJfS/fSlNp0wewcExEiuLB8s
    xYbeRycKP9CQ8Ja0Ktk3pU4CPEf87jBvWDyUWd6lFOm0d392UJsISsU3/cGXUk6k
    3xwi+LU6PkuAab6S5de5p9qVIY5JxDCqFtKQZXJviCyDPGzyWX1otw/YVlkNnNcE
    h7npFxlRb932RIuYRsW0T7BMF3a+sDeFuG45C3m3eFK99WMEbLb5GgcI6b8fOjFx
    8wxFpxKCVizFUlLjjlp6CGYh9ikkmgJvXbiEVMKTPo92MSyv+LPnYXlPMY+HIfpc
    IAf63+6dSH9i699WqTtR/Wp6poZ813j4zu6dmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826605; bh=62LvtiIcFXhlNijLvw3
    zzZuRFBPipldqfEfDestmuQo=; b=EGyPwEgF9tPoHYr1Kw3cBr5HnOn96MesmHV
    rig8XPTSNroJEtr+fuwdB6cbx5253ys4vQqG6BG2MA6umFhdBQvUrvgYxo7LFlAN
    YsA0Vg0v2PPNYXRC91A0Jw55Ml50HA/VqS5njX1hNC7ZmKtndKLOE4cdh6RYGNd3
    1ycLHo7e2AEF2HpYPz79CSHZ8c7cYw78DDL11TuIUqg9daN11JkT/QBLJQMtP7HB
    cid+7qOEk31pqjBGXmLw9W1RPuzFioN87o32HA4oBLihp3S2GqyP7fOWIVv68S8O
    ac8FD4IwoI/ezuzi/F7GBH1NYKyHsU+v+yxOT/1A8Dn5rcKNi2Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeCLDsv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:48:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41089 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932617AbeCLDHl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:41 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, bp@alien8.de, peterz@infradead.org,
        "David Woodhouse" <dwmw@amazon.co.uk>, karahmed@amazon.de,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.285219861@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 093/104] x86/retpoline: Avoid retpolines for built-in
 __init functions
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

From: David Woodhouse <dwmw@amazon.co.uk>

commit 66f793099a636862a71c59d4a6ba91387b155e0c upstream.

There's no point in building init code with retpolines, since it runs before
any potentially hostile userspace does. And before the retpoline is actually
ALTERNATIVEd into place, for much of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-2-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/init.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -3,6 +3,13 @@
 
 #include <linux/compiler.h>
 
+/* Built-in __init functions needn't be compiled with retpoline */
+#if defined(RETPOLINE) && !defined(MODULE)
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#else
+#define __noretpoline
+#endif
+
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -40,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold notrace
+#define __init		__section(.init.text) __cold notrace __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
