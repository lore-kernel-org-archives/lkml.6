Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324317-2-963155908536125805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324316; b=dOh8hPP26eVtyTKCQL1/oiY3/sexXcFo89/SSTMqAaBfGK5
    ZlzW1w4e1gM2XV+Umift85oZk1EBg/w27Zj1z5Jdj+GJpaS5oJBgGjCQQuVmO15+
    dgyjYW57cpLBwVtGdwrE+xY8TsPQ+0t4sW4xP+9OaHEfCYHAocfgzutVTd49rHK8
    Qc9dA0zKsWu/hT5TWguZL/OsfcYOXxhED3gcuRDqL+1klBMXJHKv/Dit4HUPW+ky
    AsXwWPDnJB9GNY4Ie8dI76P1p0Yt7ZLgKa/Cc6us5QQEP+00KUASnXJH0TSfD38f
    YhlTzlDQxULA9+I3fkwuQxqbccdr3byg/ssqjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324316; bh=LN53uIdqJdMO+ZGxoA3
    9D3gxYgERD6bgDlpvn644+oU=; b=nfD/FxzgETweQzIyBx68f98Y5rwcE1gqJtI
    fM47KgNbVP3LG62v4+B5Az+uBv1aZq+SBq8XmqccZsO+KDdfr+0wDQL6qlC4x1qZ
    B5ZRugZKpVgo7PGNpgJy7lF4WKIXAChFFYvhr3hwzpz/03apCX+wjg889Ajm4vzK
    5okWD7Pcj9dYAnvOHW3nKRaJBLctg7jzg8qKnAq/InNlvgEs9edW1Kx+zoP9WcxF
    i0YBut/5CVLmdJRxFlwYpbLwpaWsREZEiSL80of+rfPz2R9LECKJkF6bVrXpGbAV
    4fl31phLtJEARIdvgCTRXEQF9QUiMDUJkkq5lMtwV7XDPFkUCjQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeBKEpM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41884 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752859AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Davidson" <md@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Will Deacon" <will.deacon@arm.com>,
        "Matthew Wilcox" <mawilcox@microsoft.com>,
        "Joe Perches" <joe@perches.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Anshul Garg" <aksgarg1989@gmail.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "David Miller" <davem@davemloft.net>,
        "Peter Zijlstra" <peterz@infradead.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.871972403@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 094/136] lib/int_sqrt: optimize small argument
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 3f3295709edea6268ff1609855f498035286af73 upstream.

The current int_sqrt() computation is sub-optimal for the case of small
@x.  Which is the interesting case when we're going to do cumulative
distribution functions on idle times, which we assume to be a random
variable, where the target residency of the deepest idle state gives an
upper bound on the variable (5e6ns on recent Intel chips).

In the case of small @x, the compute loop:

	while (m != 0) {
		b = y + m;
		y >>= 1;

		if (x >= b) {
			x -= b;
			y += m;
		}
		m >>= 2;
	}

can be reduced to:

	while (m > x)
		m >>= 2;

Because y==0, b==m and until x>=m y will remain 0.

And while this is computationally equivalent, it runs much faster
because there's less code, in particular less branches.

      cycles:                 branches:              branch-misses:

OLD:

hot:   45.109444 +- 0.044117  44.333392 +- 0.002254  0.018723 +- 0.000593
cold: 187.737379 +- 0.156678  44.333407 +- 0.002254  6.272844 +- 0.004305

PRE:

hot:   67.937492 +- 0.064124  66.999535 +- 0.000488  0.066720 +- 0.001113
cold: 232.004379 +- 0.332811  66.999527 +- 0.000488  6.914634 +- 0.006568

POST:

hot:   43.633557 +- 0.034373  45.333132 +- 0.002277  0.023529 +- 0.000681
cold: 207.438411 +- 0.125840  45.333132 +- 0.002277  6.976486 +- 0.004219

Averages computed over all values <128k using a LFSR to generate order.
Cold numbers have a LFSR based branch trace buffer 'confuser' ran between
each int_sqrt() invocation.

Link: http://lkml.kernel.org/r/20171020164644.876503355@infradead.org
Fixes: 30493cc9dddb ("lib/int_sqrt.c: optimize square root algorithm")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Anshul Garg <aksgarg1989@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joe Perches <joe@perches.com>
Cc: David Miller <davem@davemloft.net>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Davidson <md@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/int_sqrt.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -22,6 +22,9 @@ unsigned long int_sqrt(unsigned long x)
 		return x;
 
 	m = 1UL << (BITS_PER_LONG - 2);
+	while (m > x)
+		m >>= 2;
+
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
