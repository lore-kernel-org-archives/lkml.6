Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220212-1527604924-2-2081357178467812318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527604923; b=gWWeYjrORA93+iAU3lZknQhpf+gvHa3I5NRb7XLq66MlTF+j49
    PwHJQtRd0qp/tQo4AFjPLOMnYwAnb0kNDi1Qj+yO7aSimpTJqZCiapSIyrKD8fKw
    LWr3+6ShFDePh+/EQtgn8wAuhKxpSGEAjRj1b8USNO7uMmzFwO4/NOIDsTz3PFM8
    y7VgWF3Tb5ULmG1XXJtnpdJONiIE8i/RghlTq9NUFyKN3TpfZTaFcJl0RV9U3vHH
    djItOF9jueuogGLB7ymqDOP2xVhFOmiYxfVDgoiQ6xIlvsqj02Pq3itlrXegW/fQ
    c1x0spkvgO8W+MNLt0GCAKptzxcL/qaQB8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527604923; bh=
    pjoTm5CYV4nb2qhsrTIdwHx0lB/iWRymez4b2PmeHY8=; b=H7+JxWOOy0aA/UBb
    VmHiNunzDEnWtDAlasExHh76bowwWJ7KnxXlRWOVUBG2pwy3IbwxPYLbac+l5roL
    O+RZLKMa8WvdVl/pvzKWJ6AEjxbRUNIOT19ONl/mq+rhy3BWBjBiopXGO8sSl+Zn
    X/sh0HBGyENZ3XzVK3yUQd0X26yYWzYO//DGbmcbTCNAhrhzAFCJoz+hSfiyC4yg
    OvEt/CeO7d5OsdXEGtzbyH7elnPCUanpOjV5YfysTxAOwk3mOn/6l4w5VAtFdNKp
    XopX/m2ZxmHN67hglwLdDXvPRZVv596j3B0bgsOyPRikLuf5PjgoUjq9XgdjjS11
    C+v0ow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=el/Z3mTO;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=el/Z3mTO;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLOZ3sm+FcdAiV0Uy/G1pNa156v0uuF5quOFyCY3Ne7QAvZbICd846swKmCPrGrnFJu8hkBQFtIFfg+Y5aaJ7f8GATwaZJ08Ju8NB/MCE7ykPBBj9GO0
    PieROzBbc/H9ZHadacgqaozZATRnO/AzYS+OYIBRn2mLQE5kMmnmA2HtWQxPK5Muo1fMAHYNrJXUbbciV4g9WD60PXz+RM/nXKzOfJljKIEl4GJ6N4Nh8scc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=NEAV23lmAAAA:8 a=6u6tklEL0JwnnX2e5HgA:9
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935181AbeE2Ol7 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:41:59 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45214 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934933AbeE2Olu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:41:50 -0400
X-Google-Smtp-Source: AB8JxZqPX/fZSzmg2lTQ+pFohVem23JkTC012torgPl0wYDr6hwEPZu29mdwe1QjV1WZO9UdI5BTyg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] ovl: update documentation for unionmount-testsuite
Date: Tue, 29 May 2018 16:41:33 +0200
Message-Id: <20180529144143.16378-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144143.16378-1-mszeredi@redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

David's tree is no longer maintained, so point to my maintained fork.

Add --verify flag to the run example, which enables all latest features
and provides test coverage for constant st_ino/st_dev.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index 961b287ef323..72615a2c0752 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -429,11 +429,12 @@ This verification may cause significant overhead in some cases.
 Testsuite
 ---------
 
-There's testsuite developed by David Howells at:
+There's a testsuite originally developed by David Howells and currently
+maintained by Amir Goldstein at:
 
-  git://git.infradead.org/users/dhowells/unionmount-testsuite.git
+  https://github.com/amir73il/unionmount-testsuite.git
 
 Run as root:
 
   # cd unionmount-testsuite
-  # ./run --ov
+  # ./run --ov --verify
-- 
2.14.3
