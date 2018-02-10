Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-218212-1518282089-2-6625092345304565975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518282088; b=MWOQulvfaDwDrDUq11DWYxR7Y1Mz9nTStA/9DzCxPeguRYA
    rYUOJKebnqATR3wVotIiUgflOzXlI+YExLQgzjyV8gsu4V1cZKHgXIJejDYdXxe5
    vRyXJliEI3lombyVf9n0c7y18zFXrYXMjKVZAYC/B4olMc483P31An0yPwRe3Cer
    lqqKM+CtrEvp9KVfErYe7vy0U/k57L6EWi0/kB+UnNyJJpzaMRylmsJbSTAEZDVb
    qp4oRbHYKZsbz6zwRbWl4AMukAM0z1+K+nuJhTvJYI/iPdfnqMkmF9vdxt1fYwe2
    HKIvvzgGjmbfxpjFM096HT+H0sP2pLZ1kqcK9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518282088;
    bh=NokljemTg0eSA95ekPpKYsLTiSHC0t+k7TnL/nxbgFA=; b=o5paeBrJqJB/
    DbHWqaIOE64MP4ARJ3KJGGapQCx9OrGfQMZh09VEgTgXYP+oBQWw5i1KgRZYZ5ZY
    X/KETVXki3oyQs6UGq1j1dTRiDACl0zCBNIYCBYTm7rsQXmvUBj1xI8WYS2SzjvX
    TVhU0XPSf4jpQZbiX7fwK949co1GFKHS38Vwh0+ex2+6rkaytUjas7ouLp31YcXb
    KOlY2uoG4eJQzyhLpZP1eH4N43TgIQhmSyZ+4SiO5mbFNAieoFaZmKpI1h5nf3SP
    CCsl5ME2imSMzLbJrW19mnWHIjYXp7PB8lPNVc8TKWTXlDzok23yZE5sKby909nh
    9l+nFqeMng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbeBJRBZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 12:01:25 -0500
Received: from mail.efficios.com ([167.114.142.141]:35813 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJRBY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 10 Feb 2018 12:01:24 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH for 4.16] Documentation: Allow comments in arch features files
Date: Sat, 10 Feb 2018 12:00:58 -0500
Message-Id: <1518282058-24226-1-git-send-email-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180210114700.mq2rg4lbjtzyx5pn@gmail.com>
References: <20180210114700.mq2rg4lbjtzyx5pn@gmail.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The list-arch.sh script considers lines beginning with "#" as match for
the feature table.

Given that those tables are never in lines beginning with "#",
add a reverse grep on "^#" when matching the "ok/TODO" state of
the architecture.

This allows adding comments within the feature files, for instance
describing the architecture requirements for the feature in each
architecture.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 Documentation/features/list-arch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index c16b5b5..1ec47c3 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -17,7 +17,7 @@ for F in */*/arch-support.txt; do
   N=$(grep -h "^# Feature name:"        $F | cut -c25-)
   C=$(grep -h "^#         Kconfig:"     $F | cut -c25-)
   D=$(grep -h "^#         description:" $F | cut -c25-)
-  S=$(grep -hw $ARCH $F | cut -d\| -f3)
+  S=$(grep -hv "^#" $F | grep -w $ARCH | cut -d\| -f3)
 
   printf "%10s/%-22s:%s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$C" "$D"
 done
-- 
1.9.1

