Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519838844-2-14437379348220696976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838844; b=f43bJarbh/qhdwz6AbIB1rO1DqHUVQek0BP3rwZo5qyAANc
    zTGi/BHJD4PifLhDkZj9XiWHkq3wdgqrPDwW3RPCc5Akcr/0QZ8+zGobSTnzTUUe
    COChTgGAWMaGMy9FM1s8pSqtzEo2eh0ae8INo69Lj5Op7kbdjyMbDdg3dZZkKmA0
    r1P550p/n1Pxyg+v1xbpjpLDGnIBmYzCeeBFIjesMTqX5IL7ZwjDK7TnYe65PlOm
    GWY7xq2xlps1JUE+9V8BKILVRhT4pSdl+e/2Mrcq0/dZ+QJw9mgCV2yDllE6T3CI
    sKljFIhhWwua5rwjC2wOdBN7u6+cjVbU/vtIn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838844; bh=5EQFM77MaU+WmjvdVL0
    2dGW+m7l7HtrRJDfKgjLBiXo=; b=XKVfGpJPBISycu0EO2H3g/Ei6H7DrcG22Lq
    9TkvUIxcwkdh3Tk4a2FMEYpjKr8QF1ersJe4cv5ZpxHe6ldgJiMuPTWor9Sft4UN
    WfIpTqLIjnJ1lvK8dnf8VfDWTKqKWa0ZWI9maxmqgaSYNlqlYksk4wLMR4EjbNIG
    3Q9bHBP0SCbHyi/ZdnEqLVUeGmnD/w943ARsDFto26MRlJqDr2SU0hkmdeu7jpQu
    XiBftkE7+DIiRdS7+bTQKlHz7/4NjioJMwDz0STg4E3NPk/aFHi5kCeHs+1ZwGqQ
    rY+wMmchT4UA2z1nPbn7QL8nvVnvFBHqFZRrBvtwzHXHzA9Qs2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeB1RZH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:25:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33297 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932616AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@amacapital.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Jiri Kosina" <jikos@kernel.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.432319321@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 072/140] kbuild: add '-fno-stack-check' to kernel
 build options
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 3ce120b16cc548472f80cf8644f90eda958cf1b6 upstream.

It appears that hardened gentoo enables "-fstack-check" by default for
gcc.

That doesn't work _at_all_ for the kernel, because the kernel stack
doesn't act like a user stack at all: it's much smaller, and it doesn't
auto-expand on use.  So the extra "probe one page below the stack" code
generated by -fstack-check just breaks the kernel in horrible ways,
causing infinite double faults etc.

[ I have to say, that the particular code gcc generates looks very
  stupid even for user space where it works, but that's a separate
  issue.  ]

Reported-and-tested-by: Alexander Tsoy <alexander@tsoy.me>
Reported-and-tested-by: Toralf Förster <toralf.foerster@gmx.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -631,6 +631,9 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
+# Make sure -fstack-check isn't enabled (like gentoo apparently did)
+KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
+
 # conserve stack if available
 KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 
