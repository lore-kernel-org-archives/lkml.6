Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520825229-2-14157661021687720293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825229; b=f96e42tl94rH94hZWHKGQK/QK7+N+PY//Vy/1RK6fH8Lt4h
    V6ejtU+u1UUhddD2P0HVydcS3iTx9g/brsYMbFXrwiQ+V3G+pLuv/vaOtkPUmerk
    VomYq4Ig0lmwK6P+ezQUoJZUj0FaHmPWfvK7mNNDYBjCk6KN8pW/MBKJEBi8d+j0
    mq9kdXT32dBj0Km7EyJp1Dp5tk8d2O/XPEqavu8564I/LYLysyXmDy9EuHYPhnHz
    8XDD42lvaAC5Bem+6ScVzKcVIBTDlLT8S1BFeVPPkz4ktGhNKu2YY0MPlld8+7GP
    6QkD7dCMJau1Pn62p3bLP2je18hnVEqSJCVaHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825229; bh=7u8R3lvRT7XRyA8x/2A
    ojJohiRKbqJecKNrByXZXs5M=; b=IboOAOTpQfnCctUPv6ZVvO4zXRuxvN5vOK5
    d73fGgtCoCHcPHHpjzHz4VegUiEZFHD9/66+CPpwGjWwt2uJQCymeHPbv6DrpHIS
    qe9+p/yRUbjF0ahbL1G/2snQtT/ng4Fg4fNChZr86/rctYoKglVpu2sIFCgzTB6y
    kg5becvxnDkpPn3nrZpr4gs92bjQP/3fo3vp5iYupVwjn+ePXS0kzBW36vRHCc6e
    iCfPP3w08zLpwqpZKVvFPdyyhJq9Jgb7y49Du4j/+5Yg/LG/g0/wol8P0/tNlr/e
    OphmA6eXAidTAusmY5odUzv2MtjzseRvhby5ws7z3E8yRuQj3vw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S932437AbeCLD1F (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:27:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41185 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932669AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        "Joe Perches" <joe@perches.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.582668271@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 034/104] bitops: Introduce BIT_ULL
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit bfd1ff6375c82930bfb3b401eee2c96720fa8e84 upstream.

Adding BIT(x) equivalent for unsigned long long type, BIT_ULL(x). Also
added BIT_ULL_MASK and BIT_ULL_WORD.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/bitops.h | 3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -4,8 +4,11 @@
 
 #ifdef	__KERNEL__
 #define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
