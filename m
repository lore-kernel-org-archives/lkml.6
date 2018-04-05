Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3788080-1522962262-2-14229089284121085438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522962261; b=ZtrE9ohb/FPRpoNPJF4Rp3q6FIOJC4wCFmUPnJPflgxFqUqtXg
    jtXoaqcLYDhRSepYsBaOTvDXT9PArTV7ulthwylBlBDggSVWFYACMd9tuISLRhyv
    RpIlhrl+X2WWVX79JqShVVXta0vZog8zPFGrrtLdoqFIPuzp49/BSAHWGNTooRBg
    Bmvo2IFZvJ6Coa6l5bhJ+RZpf+Oux+ptlAyIzZ6IUrfapYsQfz+oPSmSky54MqAk
    qOpIs4bMudSazwvn6AriABU/s9Ht42bgMA0wHZJ11pOTEtwjifwN08xglJODri24
    sI1K8iUqKreWSaVYexXJZBFhis1gjfwkt+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522962261; bh=CqeRro7s2T4ECCKwm4SsOwVYUj4Swb
    FxyzQBHAbosDQ=; b=ZYjVcAW26ZTVL2uuKzp66z3bORt3QNOgjjCmEU5iTeYHE9
    iTBSPBTGAgeoDlCS2BXprBxcmqf7dKCw2noQsBMjInofSudlwvR4tBZ3F9M0LbxD
    3na9B7IXE4GApxE8nc+YelUb0El1ul+NiCJSyjbCv0AMf98o/vSzoIxPJ6GPpHHz
    K5oo1kkzJy+Tr+u/2+iU7UqiWfqeyVi4GkA0b9XHvK06f1WDtaAREdYeBqzYbRR8
    J0TXO9VN+uRwq4EfIhSANDUd2+8NNTW7bFWu2jYynxOmBg0a7YxbMP+XmL1JRrQh
    oDQLodLW/o1rqiGRUGcW8v/+1m8wnN8jb+FnBQ5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL9K4SpcpGvPsuceJAYADy35avhMopKeyRKn7+PxbNZGTy+CVw/bh6O3yhotvGOwR1tli3YfyVgg4FHri/oH9Zlm3mBbgWpg7CMrFcmPwbJ/PDtic4xD
    mJvsbHnecWrlUFqQAaHgKlxv9fsukL4g7c/nK+GxwNtzNEyvOIiEnhXWsfAjSrxEIq7AS8d1xEjt7XnQWOPABvM7ko6tgg1wju4JxvngqDpZfceuLOWEAK2Z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=07d9gI8wAAAA:8 a=JfrnYn6hAAAA:8
    a=lAgNKBcoAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8
    a=KN3jm4avFPWGE3ae_ggA:9 a=GjJr7sqrnOeF--_0:21 a=u7rOl5gCBXi8Erx7:21
    a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=drE6d5tx1tjNRBs8zHOc:22 a=AjGcO6oz07-iQ99wixmX:22
    a=cQPPKAXgyycSBL8etih5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750726AbeDEVDw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 17:03:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDEVDv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 17:03:51 -0400
Date: Fri, 6 Apr 2018 00:03:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm@kvack.org
Subject: [PATCH v2 2/3] gup: return -EFAULT on access_ok failure
Message-ID: <1522962072-182137-4-git-send-email-mst@redhat.com>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522962072-182137-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

get_user_pages_fast is supposed to be a faster drop-in equivalent of
get_user_pages. As such, callers expect it to return a negative return
code when passed an invalid address, and never expect it to
return 0 when passed a positive number of pages, since
its documentation says:

 * Returns number of pages pinned. This may be fewer than the number
 * requested. If nr_pages is 0 or negative, returns 0. If no pages
 * were pinned, returns -errno.

When get_user_pages_fast fall back on get_user_pages this is exactly
what happens.  Unfortunately the implementation is inconsistent: it returns 0 if
passed a kernel address, confusing callers: for example, the following
is pretty common but does not appear to do the right thing with a kernel
address:

        ret = get_user_pages_fast(addr, 1, writeable, &page);
        if (ret < 0)
                return ret;

Change get_user_pages_fast to return -EFAULT when supplied a
kernel address to make it match expectations.

All caller have been audited for consistency with the documented
semantics.

Lightly tested.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Fixes: 5b65c4677a57 ("mm, x86/mm: Fix performance regression in get_user_pages_fast()")
Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/gup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6afae32..8f3a064 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1806,9 +1806,12 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
+	if (nr_pages <= 0)
+		return 0;
+
 	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
 					(void __user *)start, len)))
-		return 0;
+		return -EFAULT;
 
 	if (gup_fast_permitted(start, nr_pages, write)) {
 		local_irq_disable();
-- 
MST
