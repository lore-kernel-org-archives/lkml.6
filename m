Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710824-2-3820434067087883228
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
    t=1518710824; b=aJCz7TvUc3uLj8FKRIEIRDXq86eapqbEBMjadylgp7OsuU9
    Hml2D2ekJ2UOUoCq9HljXlkZ5cik1NfsK2Fp9N47T908GsW4kJDczBWapu0jUibs
    KMqkBLwYJ/Rh4epWgwtEZ0InsbZcb0wioHxyEVPv9zcR/j4NRP8TdMJISJHNFPki
    R8/t3CIvMz7k71dvIXgXyK9MuXAGqm9/R3Ae6E5WyGkx3zgGJVvtZ5U7juq2YKVR
    9JzjDLuEUcRp4qh0jRzBV/LjyHIysdZWFqr539wMrqUrhtsyY5GjPVIXL+lL4XC6
    OZB13b3XSLJ5vZZmaAJ+G3wHkLu9LrmFIHmytuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710824; bh=/QokFDUBF0m8Adq1pezowmdXC1
    ZUQKwoplMOOvv1QiE=; b=DB9xoRg2z2V1xjR0UTH4pZz+eOOfT/j0ajPydEA4IJ
    XmW2xHxWih37fbsG36jP+6QrHFj8V2HimXaCgUGsZRQm8rLpa29jX0qDgMAXOYI5
    M3SQG+vyHYT4u9RygtXc2qRELDaNxZmTUaKHvoPIHrZ8ebTWL7VWspCV9Rg5nivO
    3Phdy7T8Y3lH4582VozKwOytscPyA+G1rnEf4oNIKhY+2mbOT6VDiOnidz+8pg3e
    auIGziTDQAqFeWIKz6gSRDlkxKdMWUNcCaeAzo7KTIMUKcBXhF3hnbUrjHGeAzbB
    PNNUEB1cqKBq1CLM4SOUhgAUGSK+vMYGWrZT35qPUXig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424557AbeBOPpy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424535AbeBOPpw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tejun Heo <tj@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Lai Jiangshan <laijs@cn.fujitsu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 157/202] kernel/async.c: revert "async: simplify lowest_in_progress()"
Date: Thu, 15 Feb 2018 16:17:37 +0100
Message-Id: <20180215151721.123971697@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 4f7e988e63e336827f4150de48163bed05d653bd upstream.

This reverts commit 92266d6ef60c ("async: simplify lowest_in_progress()")
which was simply wrong: In the case where domain is NULL, we now use the
wrong offsetof() in the list_first_entry macro, so we don't actually
fetch the ->cookie value, but rather the eight bytes located
sizeof(struct list_head) further into the struct async_entry.

On 64 bit, that's the data member, while on 32 bit, that's a u64 built
from func and data in some order.

I think the bug happens to be harmless in practice: It obviously only
affects callers which pass a NULL domain, and AFAICT the only such
caller is

  async_synchronize_full() ->
  async_synchronize_full_domain(NULL) ->
  async_synchronize_cookie_domain(ASYNC_COOKIE_MAX, NULL)

and the ASYNC_COOKIE_MAX means that in practice we end up waiting for
the async_global_pending list to be empty - but it would break if
somebody happened to pass (void*)-1 as the data element to
async_schedule, and of course also if somebody ever does a
async_synchronize_cookie_domain(, NULL) with a "finite" cookie value.

Maybe the "harmless in practice" means this isn't -stable material.  But
I'm not completely confident my quick git grep'ing is enough, and there
might be affected code in one of the earlier kernels that has since been
removed, so I'll leave the decision to the stable guys.

Link: http://lkml.kernel.org/r/20171128104938.3921-1-linux@rasmusvillemoes.dk
Fixes: 92266d6ef60c "async: simplify lowest_in_progress()"
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Adam Wallis <awallis@codeaurora.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/async.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/kernel/async.c
+++ b/kernel/async.c
@@ -84,20 +84,24 @@ static atomic_t entry_count;
 
 static async_cookie_t lowest_in_progress(struct async_domain *domain)
 {
-	struct list_head *pending;
+	struct async_entry *first = NULL;
 	async_cookie_t ret = ASYNC_COOKIE_MAX;
 	unsigned long flags;
 
 	spin_lock_irqsave(&async_lock, flags);
 
-	if (domain)
-		pending = &domain->pending;
-	else
-		pending = &async_global_pending;
+	if (domain) {
+		if (!list_empty(&domain->pending))
+			first = list_first_entry(&domain->pending,
+					struct async_entry, domain_list);
+	} else {
+		if (!list_empty(&async_global_pending))
+			first = list_first_entry(&async_global_pending,
+					struct async_entry, global_list);
+	}
 
-	if (!list_empty(pending))
-		ret = list_first_entry(pending, struct async_entry,
-				       domain_list)->cookie;
+	if (first)
+		ret = first->cookie;
 
 	spin_unlock_irqrestore(&async_lock, flags);
 	return ret;
