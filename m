Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826602-2-17636212263348086139
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
    t=1520826601; b=fXi7hC1nIVlvZQ7cJDM8x5OpQPHxh9LCDk6Jo13KFK+H4TV
    FkzpQeIWD+SRikQcpm0xvi1mkauyQF89cGdLZ5ztVftiIgUx9MZ9dem9eqbcOhUK
    Ri/RUkFx/8d8Nj38Q+gQHmKD2X0I/AnU1wo14HLpz2HdcTM9vhn2ZMGmPC0eKuIV
    8eYQSnYgij85ceEzzmwTIDSiONRhW3AdTND7DKENBKfgvn7ZFrtdu1qkA/xFkGsH
    eR0Z+ksWrlyLWVhExtosn2m+ACde2emKqngJoFRJWRPO6kFTpb/3XTREAJAXRWBq
    t8it1MITKxFDOmi68EleW+vy2c0Nn/+5vrWZA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826601; bh=kF86RQGyD8uWHoM4dIK
    /8ofpFLQVskGXUSw83ozcGj0=; b=V1dsOm3yy3ptGDqXMR3SvWlCJyMEg3XhmRO
    hrbrYLo9xXZQ7WThcQi1LgFnfkNV0RQXmViTmdA6sHxoO9EpUMT/4Xa3fQdJGuO3
    jCXksAy35HK0N8JSIRbAepmS+3VtH6DuPzi+wGwqacRILpMZNIeiTGv+Muo4GO3X
    9McEC6ApE1KtV9J5Pyw0rheJrY4Eagjb0Yv/4Rw538IMRH5dIvs0bCa5AP8J1gOo
    2cp14b8EdEYa6/+Mq4PPuvd50e5lgyHV50vGYtUsDjOENwemGC8vb5LS2ejCeCV9
    dBZ7V7HHPcLcNOYdpGKEOJ3ZpcOqBG3ZEy49Zm7LMdSt2tltNCg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932889AbeCLDsw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:48:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41078 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932615AbeCLDHl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:41 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "zhenwei.pi" <zhenwei.pi@youruncloud.com>,
        "Thomas Gleixner" <tglx@linutronix.de>, dave.hansen@linux.intel.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.654351201@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 072/104] x86/pti: Document fix wrong index
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

From: "zhenwei.pi" <zhenwei.pi@youruncloud.com>

commit 98f0fceec7f84d80bc053e49e596088573086421 upstream.

In section <2. Runtime Cost>, fix wrong index.

Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Link: https://lkml.kernel.org/r/1516237492-27739-1-git-send-email-zhenwei.pi@youruncloud.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/x86/pti.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.txt
@@ -78,7 +78,7 @@ this protection comes at a cost:
      non-PTI SYSCALL entry code, so requires mapping fewer
      things into the userspace page tables.  The downside is
      that stacks must be switched at entry time.
-  d. Global pages are disabled for all kernel structures not
+  c. Global pages are disabled for all kernel structures not
      mapped into both kernel and userspace page tables.  This
      feature of the MMU allows different processes to share TLB
      entries mapping the kernel.  Losing the feature means more
