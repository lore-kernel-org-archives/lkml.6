Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184526-2-2313215764553838218
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184526; b=fSimOE1RkWiwNMV32VUMZ5rbkQm8swOgggz0GXyfWs83ObP
    /ya1LAWZP6jjBJgCcTYdIQiYeIzKGhpunTF6UMlAzFNb2mETmEmx1OmKczlAg8GE
    uTjliddzGCLmU1KDqg/rNfTrJdU/0wNpKEKAHUvVyuWTctacK3gb2hFzO9My7mgq
    FNDGH2vDHhZHncHXgioxFqx85mhL7v1SMkCqpgDRwCwFm9So9gO8q9NSCd152/pM
    +KKN+H1VlPql/hOWbXS7Eh4TjO1i+a+GQAYtFTLEP/99nzAlqdEK8tWxW+9P1IvB
    MbQNoypi/uXbe1lGQAXix+Hg/wnee3Czro5bHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184526; bh=HoHqeQZSLgzXsFBBuKC3E6uVXs
    /Twb/aNCjO1/iJ6Gc=; b=VW6IE16sbsyZfcyEl2L4fcaUGUoftrGKqJK8oOLi+B
    cCYxL8C0cA6Om22GM3Cx+eru4bLnvy5ebnZlMT7TjcHmMfxLxGTpGNrmE6udc63O
    xKq9aP0ZehBJ0yxKEZydrmEpiP3+yEIj+v5TYmEhnacetehZuGZK+mRmNTGN8DDz
    lHjLH72gAvcA6Q1EnsnjUCzAf+eBbT95qLUBOGDLHQjbt/NWWKDngAarUyCwQjCf
    JjAoTWf/rmemFpFoB4Ij0UwcsU/x0ts+kiJjSuiI/CfjrntAGh7bg4tDezqWti1i
    fQUYwyXxvuL9f9vYzYXrL8pfM5PTI16lnYCnmmnK+Nyg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeBINzL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:55:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeBINpc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: [PATCH 4.14 20/22] arch: define weak abort()
Date: Fri,  9 Feb 2018 14:40:09 +0100
Message-Id: <20180209133935.599639969@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 7c2c11b208be09c156573fc0076b7b3646e05219 upstream.

gcc toggle -fisolate-erroneous-paths-dereference (default at -O2
onwards) isolates faulty code paths such as null pointer access, divide
by zero etc.  If gcc port doesnt implement __builtin_trap, an abort() is
generated which causes kernel link error.

In this case, gcc is generating abort due to 'divide by zero' in
lib/mpi/mpih-div.c.

Currently 'frv' and 'arc' are failing.  Previously other arch was also
broken like m32r was fixed by commit d22e3d69ee1a ("m32r: fix build
failure").

Let's define this weak function which is common for all arch and fix the
problem permanently.  We can even remove the arch specific 'abort' after
this is done.

Link: http://lkml.kernel.org/r/1513118956-8718-1-git-send-email-sudipm.mukherjee@gmail.com
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/exit.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1755,3 +1755,11 @@ Efault:
 	return -EFAULT;
 }
 #endif
+
+__weak void abort(void)
+{
+	BUG();
+
+	/* if that doesn't kill us, halt */
+	panic("Oops failed to kill thread");
+}
