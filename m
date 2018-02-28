Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836079-2-1115995332774918015
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
    t=1519836078; b=hAoBRd9Qvb4KTCj98V0rTu6fQFcvdmuctlP7nr9h/aJExY8
    GXyA++53CV/OF0xnXw//ID6b7FFlRU4QukZBtRP4TiHjg/vVPVGwnd39LJWKnFDM
    CMA47YnBBQaEisU6MEG9EdjkEyB/QBuwkMQ5t/QskFW31jpBIG5GuMd4rLC4FzF8
    YojFyWsFtuVqhbb+N59jZ7rG1nkAXNxK4bCmD9p7hOFUivKSpKteHxEi236Ep82s
    W714F6aFOf6y4Y65tThq/HRnZAg7ckR465hxxep7f0PlfxprRgLK5Q7Zq004WiaZ
    aFTz4yEl6x1MIcZ7ynLapb5yBFsEAzWVjzu9p/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836078; bh=DudJn+aIZ+bWruXXxZ2
    VabkSgS+sfAqJXC/RBpqppys=; b=gRGSFFI8Gkxl5CfffLLLCQ/JLtb4F8HaoIX
    z1ZPaz7hZ6oOwIZxGglHX5zZJhGBGkTEp0TO7NpAAHYIYh2FlxEE+VNIZt3aAkwk
    E4Ni9GLCp5XQ6OnwL6qFvhQ+X8xwnqWyNTLF+AuuaPZRcqQB74wqZJZ2A1eNWjAH
    GGYeAf7qg3aCiuJ7bJIUMrh/AhBsFVCtpEeW19BI6ue27ZchxjzFeD/qA86MZxv1
    u5z2ILcq0aoAwUBqGT5OSjRDugNQUsKOKu+tPrp7tRW5AkouJyB3UTo25xmqrQeH
    stXbKxCFDupCXXegmbzu5tHr/bl5m4EIfU+cOCtgrjSeAq+w4OA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeB1QDh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34775 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932318AbeB1QDf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:35 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andy Lutomirski" <luto@amacapital.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.407440126@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 152/254] kbuild: add '-fno-stack-check' to kernel
 build options
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -736,6 +736,9 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
+# Make sure -fstack-check isn't enabled (like gentoo apparently did)
+KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
+
 # conserve stack if available
 KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 
